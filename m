Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FAC5C02192
	for <u-boot@archiver.kernel.org>; Wed,  5 Feb 2025 23:15:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F39C580834;
	Thu,  6 Feb 2025 00:15:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="BmnBrywl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC5C78033D; Thu,  6 Feb 2025 00:15:28 +0100 (CET)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B048806FB
 for <u-boot@lists.denx.de>; Thu,  6 Feb 2025 00:15:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2f9c3ec68c7so343085a91.2
 for <u-boot@lists.denx.de>; Wed, 05 Feb 2025 15:15:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1738797325; x=1739402125; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/Wj7/GFVydo7uTfZlCnvaqsWCaqh2fr8UlGwp0vNz90=;
 b=BmnBrywl9wykPYwmv4MHmGqP+q+7Z9wxdhJHAd9mQ6PwYr3bmmGGa5YzOlJPHSRtoT
 jjxaQaCailg56rj3V7PLdvfw2hQyY950aBdZ6UWs0To6A9yvVvvkMa4SSmInsxnEjqdw
 k93pPlSQUj2pQRn8bt7wqMJUuO+AGrVNo6FMQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738797325; x=1739402125;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/Wj7/GFVydo7uTfZlCnvaqsWCaqh2fr8UlGwp0vNz90=;
 b=ndMSJeLfRlqNrYdD9QXnM1SqsOgQ0q/KXTfnUw2pUkn9yfe0vgxx+0Ri9GgGA/ASLS
 xyju/CvQ/WCLs14OVWkU0UePmxljahesW9UCBYkcAaISWEXIO6Ph8aXDlpIXFoCi0W7S
 bVeC44wjWIXYgk/LHHuM3C5VnRJgvy/nkXMuoN/gcT8SJuRl41J7N2AME1YCu3tzBF0O
 mMV/N5nkFw2skZ3Mk+mQpAV4fpx7vOc2T0IfHAhzT1MKVPgv9sE9bvSSSGNaOzKWyfr5
 zJsp2zuY8Qbl3JMiCRRVIDh5CM+Jc6j0x9gbZQa8yFdYstNTOE4nyld7VCYWODAYJk6x
 A4hQ==
X-Gm-Message-State: AOJu0Yy6Wj5C9ZWdE44eiA2W9ACcjP35Sod8lhHHZCSzCZxG8sXO+og2
 +QAIx+TWVNnham9wCm8r05TE5yMG37UqEZesX9LZe01wWEMAai8OMVExNAZT4H4=
X-Gm-Gg: ASbGncuCJA/rtUQGvJLUlmup1dSiNi7oQFfGr5feuoRGVtekrDOZnQqfHtjCHqcTx9P
 PWStbaLvkO2Tmn5KVuI7fkgAdVwP0DSu6admSfHzc4uhvqJ1yyzyWXfQivDtos6nO5391d0B2iF
 Xrug5i3X/RyiFttmLES9ITLO2obEqEXgO8hDJ0jOrhB98BV4eGn1yOA39WSBvrKvY1HD4yrCE5k
 JYxytUWa43ayt+rDgY8FhYjCgDdwDDiI8vluGUi161QioqTlvvF5fwq9ekV6f/Yu+bkXGlGLL3C
 taj39JkrpPonvg==
X-Google-Smtp-Source: AGHT+IFYc11MlW28rf5S3trC8vGAULbTUEORI8rE9A2tuYICPUpxzMhcs0P7Y2+RZy3coPThbiHeYA==
X-Received: by 2002:a17:90b:2792:b0:2ee:b666:d14a with SMTP id
 98e67ed59e1d1-2f9e0783f77mr8159109a91.17.1738797325146; 
 Wed, 05 Feb 2025 15:15:25 -0800 (PST)
Received: from [127.0.1.1] ([189.177.145.20]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f9bf6f26e5sm2622901a91.0.2025.02.05.15.15.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Feb 2025 15:15:24 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, praneeth@ti.com, vigneshr@ti.com, u-kumar1@ti.com, 
 d-gole@ti.com, Aashvij Shenai <a-shenai@ti.com>
Cc: m-chawdhry@ti.com, kamlesh@ti.com
In-Reply-To: <20250129105609.2239453-1-a-shenai@ti.com>
References: <20250129105609.2239453-1-a-shenai@ti.com>
Subject: Re: [PATCH] arm64: configs: Remove SYS_BOOTM_LEN for TI devices
Message-Id: <173879732362.2019786.5383732481212777891.b4-ty@konsulko.com>
Date: Wed, 05 Feb 2025 17:15:23 -0600
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

On Wed, 29 Jan 2025 16:26:09 +0530, Aashvij Shenai wrote:

> AM62x BOOTM_LEN is too small to contain OS images. Removing this sets the
> size to a default 0x4000000 (for all arm64 devices).
> 
> It is unnecessary to specifically call the default size for the other
> configs.
> 
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


