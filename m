Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FF0DC43327
	for <u-boot@archiver.kernel.org>; Tue, 30 Jun 2026 17:06:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D885B84AC0;
	Tue, 30 Jun 2026 19:06:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="IByKyiOS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E211284A52; Tue, 30 Jun 2026 19:06:03 +0200 (CEST)
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com
 [IPv6:2607:f8b0:4864:20::c2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 596E184A3C
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 19:06:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-6a198cdc4e4so125724eaf.1
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 10:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1782839160; x=1783443960; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6iEsXeufqc72BNOSXoD8aAp6guaEhLfD0ktMtuoCOmE=;
 b=IByKyiOSeGmUYuoyFQ0mBFON89sbqoGphGgLS5cAwZph5gVrKWJv7SZfasOAf6Jnz1
 fY/r3pGAFgd+BIiELtC7AbfLB4IpPcjXCY51Hw+4Dz5LeW2fZKSVuJDOlCedJ805GHbu
 1xFVOGD5n7nFt8VBOPqq0AP8NuyfDQlLX3b9Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782839160; x=1783443960;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6iEsXeufqc72BNOSXoD8aAp6guaEhLfD0ktMtuoCOmE=;
 b=oyZ9mlKHfCNlSIbc16UzOoGEmj0HOD0Z9rWxGL1yZ4D9K8U9pjau9XVYRE6RZF3DNq
 5fypRBSd9xPUBPhsvaLwJhBMYIcb/S+n7bCRzp8BN4hyYjQ9cp8WyuSQXbedNwwlN/xd
 xWvrB5lnkumsAOImOI6r3urimwnCuO6xqZtHcFD9ea5X+kiqRSQQZUmMzfDV5nqS7kqT
 9RJQzQ5X38xlhgvqGTziwfsHAzTvGuROHnil5Qy3NfBQyJuPGfL/4uXAQwoXghivS5aK
 WMgDIfTIlPQe08c/OmatLu64paDFnGNGeOMgr2vR/hXOOBnOQdZFAmTPwbSP6WypVT6I
 llkg==
X-Gm-Message-State: AOJu0Ywd4wMqP3kt6Z3otfhR/M4MFE4X7l4jdJmh6cWniqDS9CQCIx/w
 qol//V7GsDr5uwfoNHEQ8DUTgeRp8GfeHchQuCDFpNffPkS+NGCgDw36J+4MPnOw7HM=
X-Gm-Gg: AfdE7clkYgA2dHBpzPxl6RFLFw3vKqlHgjnSmqHP90R0KWxhC0l1S4PXCpBebPvnaPc
 c0AaXQ+7rsCnJpzZqOix00USP6iy0kxgtaG1qha3+JQxROHMkj5dLlZPd7AizpzrMl9uu5AXNvY
 nYVDmgWjavWKHjU4p9dREhXqA9231HcSe0fK2b7I53ue4aNAdA3c7DUIYyrFYpyB7KMee2MKaK3
 F6xumS5l4V8nApoG59LJpcbsvAaNl0x/jbcohmP1auYGBQ5FS67yEEj5PDH+tPYsOTxoClxtGyq
 SDJ8cT14IfrHmBw1bLvIYnrJGaAGb076M0aQfPXxnjCty2EYRruVet2b1uODK56FVlpovCZ3aS6
 xHshmoE2n1HEWBuiunORefbzxfKXdCz2S5nJ86+RglBGEuWALNOZjJ8vmeatmG0BXPtKQZY6tQU
 bifn9fUor9uLLPvAUdId7+hTyKkNnbWNM16HxGDXR3U4EVP09IXowAUFKmN+mmNGswLx+SHcCXP
 aHMjSGsTNgY8xUivGN24rvejmTudgqnUZTRbDs=
X-Received: by 2002:a05:6820:160f:b0:6a1:50ec:3a54 with SMTP id
 006d021491bc7-6a196b8b282mr914975eaf.20.1782839160020; 
 Tue, 30 Jun 2026 10:06:00 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-103-245.totalplay.net.
 [189.203.103.245]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6a189214c7asm2398727eaf.7.2026.06.30.10.05.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2026 10:05:59 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Casey Connolly <casey.connolly@linaro.org>
Cc: Sumit Garg <sumit.garg@kernel.org>, neil.armstrong@linaro.org, 
 Luca Weiss <luca.weiss@fairphone.com>
In-Reply-To: <20260630125057.100816-2-casey.connolly@linaro.org>
References: <20260630125057.100816-2-casey.connolly@linaro.org>
Subject: Re: [PULL] Please pull qcom-fixes-2026.07
Message-Id: <178283915920.999526.11441727826608833029.b4-ty@konsulko.com>
Date: Tue, 30 Jun 2026 11:05:59 -0600
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

On Tue, 30 Jun 2026 14:36:59 +0200, Casey Connolly wrote:

> A last minute fix for the release, the UFS controller on the new Milos
> SoC (used in the Fairphone Gen. 6) needs a stub driver for it's ref
> clock (similar to SM8650 before) and a handful of other clocks to get
> the UFS controller probed.
> 
> This change shouldn't impact any other platforms.
> 
> CI: https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/pipelines/30574
> 
> [...]

Merged into u-boot/master, thanks!

-- 
Tom


