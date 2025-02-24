Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 760FEC021B3
	for <u-boot@archiver.kernel.org>; Mon, 24 Feb 2025 09:57:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F121280079;
	Mon, 24 Feb 2025 10:57:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hLfwtlyL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 741F4805C4; Mon, 24 Feb 2025 10:57:17 +0100 (CET)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43FE080017
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 10:57:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=matwey.kornilov@gmail.com
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2fc32756139so6382519a91.1
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 01:57:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740391033; x=1740995833; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=VmQXGMCO3PVe2wyqXYMJyC3kOiPxzjQMYhB8jsc/cGQ=;
 b=hLfwtlyLMOLuJRgtvPlz4upwUqKPmDwtSEnX/28MG4q1Lo3iz7LzQwsY370lqT0Xze
 m125zmT9qQEhuz1yyR42FjzV1fN4vwoxAQO0FNDRvHNTiUxGFxn0y+ORm2yPLCr+O3dw
 Evw006agXRNZjAMfs7EA1Fl++No+HHoapyGGClTIqa4Pn8JLMmuowPeZDahsXXFV8zp0
 jE+FMyaJBGE4Jdv0fiRWUpQribcXWPbWrxhC8ls2qs9BM46BwAJPdhlia3/b6rIZIsf1
 Z2EG8rtKSi89ZdjNRetVGYNs8VmV+mSUjWj0HwyMmOwkRH+hIkayS1SjkiBDYIifBgYP
 ShIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740391033; x=1740995833;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VmQXGMCO3PVe2wyqXYMJyC3kOiPxzjQMYhB8jsc/cGQ=;
 b=ZGk4r+JRRKGx4zx/d4FQ8AvMp1HmwKcYICH1znqZCNcEh/jutat+OAODPUsSv6QVJh
 tvsX9AkKKAXgZHqwIIFjwIgwOwqkyYWXn1Er1lwnOLlDyrloURd58kDqOg+JSjqlnS9f
 evf+ESMZZRuLmZIRiHWLnYKOd5OZhhM/XL9BrR9AwcE3YCbi36tYY0gZp5rAeKfFoJT7
 VTB6NsMqC8RWFjFLm+TRAsExhJhzeWTEu+vQtNRzzQ5y0euXBJghN5SzYEH+4CSgaoqJ
 oAAOCFWHuxgrIdrx9XXV3NUfb8gJdiT31OSi93Qx3dfYiU2nra9aXMhkO5R/6hDy3jWV
 yWrA==
X-Gm-Message-State: AOJu0Yzi778EVr6DJySU3cFf9e+hMmyf8S32R2Kq5vlOzMttTmOoOVa1
 lhwUjRI+6B/PewRdD+0J2orRioA0wAPi7ue0WgJNPBr2nmkVj4JdidG0fA8RACb0ZYLbv5tSmRl
 f9ZQi/MjqPavfR/RfbJyQ3EG6SAv4Opbv8l8=
X-Gm-Gg: ASbGnctyUt4oIO7mlSNh3xwbYJ7lBLblJH3R+RC10rRKqODHHjI0unCdjqruAAagTlG
 SsosZB62nC0a5guuvFeFNXNgPGBuFrXZbJEVgdkNzT6tVV7hL/XgVS0ZwO4a0QvbnZyHPLa1jAv
 kMnwX+4CKrjOMR2v/Wqv/QRZT5yxXkXFfxbCY7eA==
X-Google-Smtp-Source: AGHT+IELm+EykI/0mCra/TTKNYZ7PpBxSGXAuMZn73F+vr4JvV7CoQXG76ypk8e+8wDGRstrtJcIUm1n0ZoOb3U2AL0=
X-Received: by 2002:a17:90b:2d87:b0:2ee:f076:20fb with SMTP id
 98e67ed59e1d1-2fce86cf0b7mr23865774a91.17.1740391033331; Mon, 24 Feb 2025
 01:57:13 -0800 (PST)
MIME-Version: 1.0
From: "Matwey V. Kornilov" <matwey.kornilov@gmail.com>
Date: Mon, 24 Feb 2025 12:57:02 +0300
X-Gm-Features: AWEUYZkq9yJP9cb_rm14BJXR34z7lI4bzQ10OlQjnMDEetFHCksCgAB496qoeNA
Message-ID: <CAJs94EYBX3iNiOcSPXtrxA_brQACwjcTSJ6BjhqJdOdBNGxG+Q@mail.gmail.com>
Subject: Need help with booting from SPI Flash
To: U-Boot Mailing List <u-boot@lists.denx.de>
Content-Type: text/plain; charset="UTF-8"
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

Hi,

I have an Allwinner based board with manually soldered 16MB SPI Flash.
I am trying to place u-boot into the flash and need some help so far.
I have already updated the board DTS file and checked that the Linux
kernel provides me with a /dev/mtd0 device which is writable and
readable.

I enable the following config options additionally to the board configuration:
CONFIG_SPL_SPI_FLASH_SUPPORT,
CONFIG_SPL_SPI,
CONFIG_SPL_MTD_SUPPORT,
CONFIG_SPL_SPI_FLASH_MTD,
CONFIG_SPL_SPI_LOAD.
I am not sure that I chose every relevant option.

However, I see the following message from the bootloader:

U-Boot SPL 2024.01-rc1-45362-g94a35b52f78-dirty (Feb 24 2025 - 12:43:35 +0300)
mxstatus=0xc0408000 mhcr=0x0000010b mcor=0x00000003 mhint=0x00004000
Trying to boot from SPI
Invalid bus 0 (err=-19)
SPI probe failed.
SPL: failed to boot from all boot devices
### ERROR ### Please RESET the board ###

Are there any obvious things I missed? How could I debug this?

-- 
With best regards,
Matwey V. Kornilov
