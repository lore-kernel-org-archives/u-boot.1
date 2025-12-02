Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A189D12673
	for <u-boot@archiver.kernel.org>; Tue,  2 Dec 2025 21:05:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 787A58391B;
	Tue,  2 Dec 2025 22:05:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GE+EiuxM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2BD383AB8; Tue,  2 Dec 2025 22:05:06 +0100 (CET)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 678C4830A0
 for <u-boot@lists.denx.de>; Tue,  2 Dec 2025 22:05:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-4511f736011so194404b6e.0
 for <u-boot@lists.denx.de>; Tue, 02 Dec 2025 13:05:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1764709502; x=1765314302; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=punhUX57BXUk6RDVq3QxuWhknqaMfas7EVw0zth9wU8=;
 b=GE+EiuxMuMdsWmKHnsEKfo4UThFg+25H3KJJwuBOBBFvzXn+cI74tJBDTK9wePRCbG
 iiWu2sZEww7i7oPnCVEKrg+ew4xoycGxdQo8SKZX7wVLN9Q+08UYYEAavhnbd7xx5GfE
 Vyfe/+KiKoSupdA3aYgtG3AB4viZ9gpgtosE8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764709502; x=1765314302;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=punhUX57BXUk6RDVq3QxuWhknqaMfas7EVw0zth9wU8=;
 b=Fv1m5PWLzfVpep6NQDwEKR4C0yGLvSjtFTvAMkTTlwnauaHLvYQKwwH2n1K9N4V3sq
 +f3ctSPcfj5ckPXvV/TBn74BI0J36JWpgz0q5QkzlnEcdPuuXgZaULpcNxcynkPdvEfC
 XkcCxyrtYK8NVEdWjgaEXMfLlyCNFM3E5oD2gnoQhSjRloEGkI4G4RNdr6XeAF6QS3CH
 LAhCqTnuK60TMQYtYLMBG1NWvfp78qPTd6pj6IZzrbfhe/RWEYsV9JiSSk7vBbAKzjjU
 FuOvQ2uMMGf6+SDyLH1RnkgyT0Jo3uDzgstEp/gPN//TkiA/nPU1gQ5BWB1etx4x0Mzi
 YiDA==
X-Gm-Message-State: AOJu0YzUWpL29Ix0MGTtIu9ghPlN/+zE8g9oYcE+op7sPotVp1Mop33n
 wDwM1PnJQaq9hU1h0S8btRWiOMGFmyVe18mReT4TewSJHPV93vWwJ7Ytt9f2mEBmgtMjPKRPXP9
 dAwr6f58=
X-Gm-Gg: ASbGncss/3R+x0LDiiC+NElyBzSDBeavil1VhsIVJ29PZmqNZMOyOa4HQpE5xAZF2xt
 VVYlrtfRrtdxseQwMl+ImmRdti8sn37AmVqE1hfkvxzqK3/qu9H54ErCkFG0DTGtYJiNX9v0ap1
 MLS4Gg0rLHvTg1QnmgJJxNnv8+rH94UlMwosZimPH4bFpnJSi5VCMM+Al6Rs6lBhgDFLGr+kBtt
 EpsfCwn4irzkg+vzv7Y6vrVJ6RizLeI9Oqi54GRgPVoQxeCenxzAtjhU32t2Gr28lzYnyFT8Hjl
 nLHFWD2Je53oL2KAEm0qkg7ZARJCVOcSwspjsIbU3XWVVZY12afr/mXDE+359M1XcxwKi127Ynu
 c+buii/GwkjxzJH/KAoSqQrPPORY3TcPRmAu70JVXpFN0fXe/JRJJTT8t8O43ZGnM1OdekBhPYZ
 bRA+/6SZQj/L/py5Z+us2Xk1Ln70+Jh+7Sa+YWNzB+ouiQkHrS
X-Google-Smtp-Source: AGHT+IE5XiQZtNiD8JK11hCVPODLvEgD4B6uUw7cKmT7cHyQoaU65zsIih1ChWMgL+qo5uE7Nw/qug==
X-Received: by 2002:a05:6808:4fd4:b0:450:da6a:269b with SMTP id
 5614622812f47-4536d746417mr9229b6e.26.1764709502403; 
 Tue, 02 Dec 2025 13:05:02 -0800 (PST)
Received: from [127.0.1.1] (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-453170ce788sm6182478b6e.16.2025.12.02.13.05.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Dec 2025 13:05:02 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
In-Reply-To: <def8f892-abc8-485b-9916-c3c1c7318226@linaro.org>
References: <def8f892-abc8-485b-9916-c3c1c7318226@linaro.org>
Subject: Re: Please pull net-next-20251201
Message-Id: <176470950152.2689932.2841946965186510436.b4-ty@konsulko.com>
Date: Tue, 02 Dec 2025 15:05:01 -0600
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

On Mon, 01 Dec 2025 13:11:54 +0100, Jerome Forissier wrote:

> The following changes since commit 65a131531077d75eaa01f8376d8f7f04c146a457:
> 
>   Merge tag 'u-boot-imx-next-20251129' of https://gitlab.denx.de/u-boot/custodians/u-boot-imx into next (2025-11-29 15:39:36 -0600)
> 
> are available in the Git repository at:
> 
>   https://source.denx.de/u-boot/custodians/u-boot-net.git/ tags/net-next-20251201
> 
> [...]

Merged into u-boot/next, thanks!

-- 
Tom


