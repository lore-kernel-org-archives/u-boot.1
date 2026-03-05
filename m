Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 253E1F33A75
	for <u-boot@archiver.kernel.org>; Thu,  5 Mar 2026 14:49:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9869E83F75;
	Thu,  5 Mar 2026 15:49:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ugerpb0H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3A6E83F7F; Thu,  5 Mar 2026 15:49:46 +0100 (CET)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C9FB481E18
 for <u-boot@lists.denx.de>; Thu,  5 Mar 2026 15:49:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-4163a7c7ca5so2786450fac.1
 for <u-boot@lists.denx.de>; Thu, 05 Mar 2026 06:49:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1772722183; x=1773326983; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XBSl+p4e3tzKaixPCERQDXKbUT8/Qnh+9u0e0TCQ9yY=;
 b=ugerpb0HcdZkt8XtsaAKhdg2chfz+8WwM12uOyS3YsBCk1K8UsuEq7w5/QeBsVDSIY
 qHGjevGelxTWzeRuK3Mz/RHgzoI76dq3jJNwWmDqh2UGHlVY8RlG6M27BhzxcD13+bwR
 +NRoVSYHR9guW5SMUFqcekvO9eeMKOtTVpFls=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772722183; x=1773326983;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XBSl+p4e3tzKaixPCERQDXKbUT8/Qnh+9u0e0TCQ9yY=;
 b=UxKsG82mmA/fD/VxNxZqgxbXLN8WVWNTV7PKxLeEep9kGwTBjQOJcAy20rMJeyi0aj
 GGS+YurPTculd6t8ZxRw5lexmVFRhPPT2T2Zc8uU97Wp5kwniA7XROgfc9f83xvaFcHB
 ZFOTW/rVKPMbSTe7jiEdbAnaAn3xq89sf4Sr6pFxYAQOWjeHHU9Ibt8iI3PgrUMeI7zr
 +1FXa3QqATs43NT2x36USAFUIgnnikTwkeVhbNq/0juEISshkXMsE4q1JAX4UXLf+EK5
 vMcmufd8/8RQAzYTieDe7uB7ogpuFhOEXV1G9naVK5OipFmSoET281JpSoijjg39Wxj7
 DtSA==
X-Gm-Message-State: AOJu0YxggM7l1jWXXSy++dnRGziDE+FHRH7pBestUf/GrimLSlt9upIe
 iol1sqHDR/UO5qvvJagOLDXJlq/DZk40g/rWU88OyQvZdq5sUkANH75G7WMcrLYl5+c=
X-Gm-Gg: ATEYQzyp58e58HKP9LCivHgeqrogoHyP6IqUhLBGX8MsI3l+HvxFBEDP2W2d7vPeV38
 mJVWvAM+JesieAFGictNqd4D0UzsJArbuXRhvkqr6CPt3NlckHsMlg+7P3p2e+Y1UKdUWFY0kBf
 qzsD9nYrvh0UN/2JdSOCB24L+JH8Ss6X2cigQAV1c+wPvEhmA+zxvZpffq9OvCRWOX3VdDBqleZ
 iYUKj5odpzzVjNroyRilWE/gfGCTo4NRcUpksrFBur/Xhjy/nNmolNOfEFuJF0vMvnXXvPo+Sd+
 63aX7kqc0kBAj90XKPNTP9XD05/81UAWm5orhFYeghZSVXbB0qIiDxP3AI5RrEwlqgUNpGLgTKw
 dQILqyPJF93MEq9XjWP1FJCDJg5ZOVl1ZtXDxyRdejzGjz9BWqjy/I5NzrAD4TgRsdwcawF817r
 0QRZnUSRKdyUsjjtjRM9cVKHv/vEzpgl28H3l6QzUYDlOGRLrssVZF8Z5tHnIICMPuFiY9JZ0Zs
 FMRz3oizh9wguzRGoIVytd+Ev50AxXzYdIfgMS0GApGTVv+Bw==
X-Received: by 2002:a05:6870:a68a:b0:40a:40c8:a6ad with SMTP id
 586e51a60fabf-416ab4f0bbfmr3153405fac.1.1772722183494; 
 Thu, 05 Mar 2026 06:49:43 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4160cf2572bsm19246871fac.2.2026.03.05.06.49.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2026 06:49:43 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: u-boot@lists.denx.de, Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <88393bb3-c241-4be9-8268-1ccd047ba1c9@linaro.org>
References: <88393bb3-c241-4be9-8268-1ccd047ba1c9@linaro.org>
Subject: Re: [GIT PULL] Please pull u-boot-ufs-20260304
Message-Id: <177272218274.529370.2649525527856773041.b4-ty@konsulko.com>
Date: Thu, 05 Mar 2026 08:49:42 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Wed, 04 Mar 2026 21:15:03 +0100, Neil Armstrong wrote:

> This is a (very) late PR for master with a few UFS fixes and changes.
> 
> Thanks,
> Neil
> 
> The following changes since commit 437ea9f8be5afaebe2d8cbab6242f1182857f21e:
> 
>    Gitlab: Fix TEST_PY_TEST_SPEC for qemu-x86_64 in sjg-lab (2026-02-26 09:06:33 -0600)
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


