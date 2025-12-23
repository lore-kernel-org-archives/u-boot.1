Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1087E6FE23
	for <u-boot@archiver.kernel.org>; Tue, 23 Dec 2025 17:18:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2729E84159;
	Tue, 23 Dec 2025 18:18:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="lYJ8kzFx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3953D84148; Tue, 23 Dec 2025 18:18:18 +0100 (CET)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A8D584159
 for <u-boot@lists.denx.de>; Tue, 23 Dec 2025 18:18:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-3f551ad50d1so1865416fac.0
 for <u-boot@lists.denx.de>; Tue, 23 Dec 2025 09:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1766510294; x=1767115094; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AOon/33PCDJJlEwm8zztF0tqXXOycV0XKMJ13NWKo4U=;
 b=lYJ8kzFxA+LJn0JGBfm59Gqd6nMvlt7DgKl772P6DTl/EvMTAdAt6nyG/NkKX7Bmd+
 a513/+Fhryl4+VdHjC6PzbDYmxujr6KYxYM5pVly6X44M2joDfTWp31ASNk8gcoso7TI
 j4bCVKgj/PW7tpoXwvPftOw2ZqCZ62O9owHNQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766510294; x=1767115094;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AOon/33PCDJJlEwm8zztF0tqXXOycV0XKMJ13NWKo4U=;
 b=QcNQvk06nlJmksiFE9gaXq//qEAJ4i/MO6G1BUXmtxCxOBXORG/LLksUWHy6Jdesuo
 VVxfxHwquJr+kOyrgT6iijlJQcxfwcpHT7/eCFdRMyiAPK7xJ6f/QYNE6hb8GuPoNQW8
 ahSq8pwQPXO5Trujjk5iuFdgPzeX/NVexc3MkCGo3NT3DZU7HKOxSl4AsQHmJsDc2Znx
 RYzXZGuzeKHHwW+6+6uR5V0SbptnMdMq5VcBxCK+Hhi/CHHMg+dX3/vViI6VPDNF6T0I
 MRdR+Y95E5fcRlhEy5iQfQSEkbFfvIGx9vO0wC7vLb5mbilmEfdaDyPWzDqQKsEAixHk
 0yxA==
X-Gm-Message-State: AOJu0YwjMRC3P87wSgtmX55vzzQIyryn8BtJhpB3NS3JD/ahQakYawS0
 TFX7KjBiyOjZLFXpyyCi8+KSp7KkAolKXZMFBJcVLAZ9BvEQOQaVP3KblHByrKRcWrG8r8lyayO
 h3z0NcRc=
X-Gm-Gg: AY/fxX75rDVtJBByGp7QtKu5ZpyR5FUp5vXLTuBw4Z8nHyFGyX65If+oBmzxWgV9W5h
 XXUOEKxCZFxNJcz9GEfy+2LhNdkJdwMKDXwmeLCRhw2XtTYSAyLml2NtJlc2Bm1+KGeoBLdiDDy
 G5v0/vEBQH/1j0v8YaoC1KLgl4ktF/R4p1xrEFbAGVHQo2QD89RIB19UKyPAHy9zJsyU+F8BVn8
 jWIoNOWkG7kLFXOXmCqm+PYy5ONJbwNECdVp80j6/u1L5/Nwe+Hj3yA1jLAqUlXWXAJs34iJ2xp
 KLovpFVcpGt1OJwdNFGXGbsON7TB2pyn+PWF80rxjU943aM78YJdRoD+vspmfd2no4Ot3rTUs19
 WyEUfuaOtSDbxAtSVfSfcEZcPEeTbeG/D9Jl1uUjiuqWPqLtm3B3w3gonWPNR2sckZyT2i/wVUs
 ue6z3WxsS8XR/h/rIzBdg7atbZVKeZ3FcVvF+jD1U+vv6I55Ph
X-Google-Smtp-Source: AGHT+IFreWvhiSD+QSaKc/g/LmM4n5hSPtG3+2GhwfkgnPwftINwPoXfTEfeXGY47BWC3Kqztkr5cw==
X-Received: by 2002:a05:6871:6018:b0:3ec:9c0c:283a with SMTP id
 586e51a60fabf-3fda56c0f1bmr7022641fac.24.1766510293929; 
 Tue, 23 Dec 2025 09:18:13 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3fdaab620b8sm8771980fac.14.2025.12.23.09.18.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Dec 2025 09:18:13 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20251223092858.5563-1-clamor95@gmail.com>
References: <20251223092858.5563-1-clamor95@gmail.com>
Subject: Re: Please pull u-boot-tegra staging
Message-Id: <176651029277.1176914.17763441723932155200.b4-ty@konsulko.com>
Date: Tue, 23 Dec 2025 11:18:12 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On Tue, 23 Dec 2025 11:28:58 +0200, Svyatoslav Ryhel wrote:

> The following changes since commit d24f4ae65433aa7720c075a9f1d1aaf7e1985ced:
> 
>   test/py, buildman: Update filelock package version (2025-12-18 10:28:10 -0600)
> 
> are available in the Git repository at:
> 
>   https://source.denx.de/u-boot/custodians/u-boot-tegra.git staging
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom


