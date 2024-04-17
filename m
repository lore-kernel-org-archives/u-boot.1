Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E90DC4345F
	for <u-boot@archiver.kernel.org>; Wed, 17 Apr 2024 22:12:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78505884E8;
	Thu, 18 Apr 2024 00:12:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gZB2f0yN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B7FA884E3; Thu, 18 Apr 2024 00:12:28 +0200 (CEST)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6539F884E1
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 00:12:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-69b0f08a877so1620756d6.0
 for <u-boot@lists.denx.de>; Wed, 17 Apr 2024 15:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1713391945; x=1713996745; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sP44Jja08tYHuyfTQvVf3xCOimxGwZ6PPRC7ZpekU14=;
 b=gZB2f0yNmIEPEYt0G89Ae7/A98RynzkLQjh+HwWYDT6102b+S95sl7+Qpq80X/Awoh
 BlaiNeL2wKELaImFSLj0yb6EtGzruPXac9H9tzAccybam2lvhSZ4MaEP1pTCXYlhIEH0
 oD5wZA2w8QnpBacdutbe/ZTIvLjK6ZOhoPGDU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713391945; x=1713996745;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sP44Jja08tYHuyfTQvVf3xCOimxGwZ6PPRC7ZpekU14=;
 b=HWPNZ6W+EG5uxB+XuacqIzaZdMuCc6yRDs6vbGiSyPkusAqk2ADKTBiL4fIq5e83He
 xPuHTj3lk5VScYWyPsxhbHjk3ZPw0q1ElaSJs++sp0szT11afIPGxxKh2c0KIAfqr/Hh
 UlrH6uDx++djPDVtOOWgph2FVhkPWxdk6lnTDP4TFQXNqe0rvR8LS5OriD68WpZcXCYt
 gl7Toa41vcbAfvzHBQzn7/B2yz7aqgfK1i0rVhQ7IeUGaGpmKj9yiLqSP1OzCTCG7Tm8
 WF8+eDlrG/G9dN0CeStaLwQd4MPibN9UYu7jl88PkE1WcJ4/QEGE0Nix3h5AwO+UIvqA
 dLiA==
X-Gm-Message-State: AOJu0YxhYYCYgx8UiyQhL3EkeDEoDaqMuc3PhLGBh6l6ttwEqV1gtJ/c
 1wU3AjUZa2vYkx9KAdbHqf0++lem7NfLvXEPLSq1p4QRczqRD4mmysj7i2NZTNY=
X-Google-Smtp-Source: AGHT+IFuTG3545RV1sZ1GHYEQbMVUHDitnviNnkm8c+uxBIxxZWPtpRf2Z3A8zbp2yQnJ0zJe1POJQ==
X-Received: by 2002:ad4:4423:0:b0:6a0:5356:f5b3 with SMTP id
 e3-20020ad44423000000b006a05356f5b3mr344021qvt.14.1713391945293; 
 Wed, 17 Apr 2024 15:12:25 -0700 (PDT)
Received: from [127.0.1.1] ([187.144.73.35]) by smtp.gmail.com with ESMTPSA id
 m14-20020a0c9d0e000000b0069b748abd98sm59703qvf.89.2024.04.17.15.12.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Apr 2024 15:12:24 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>, Neha Malcom Francis <n-francis@ti.com>, 
 Nikhil M Jain <n-jain1@ti.com>, Andrew Davis <afd@ti.com>, 
 Roger Quadros <rogerq@kernel.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Kamlesh Gurudasani <kamlesh@ti.com>, Manorit Chawdhry <m-chawdhry@ti.com>, 
 Robert Nelson <robertcnelson@gmail.com>, Nishanth Menon <nm@ti.com>, 
 Bryan Brattlof <bb@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Jonathan Humphreys <j-humphreys@ti.com>
Cc: u-boot@lists.denx.de
In-Reply-To: <20240408211100.93936-1-j-humphreys@ti.com>
References: <20240408211100.93936-1-j-humphreys@ti.com>
Subject: Re: [PATCH 00/15] configs: ti: Enable basic settings for
 SystemReady ACS
Message-Id: <171339194347.1235623.6411676418711378498.b4-ty@konsulko.com>
Date: Wed, 17 Apr 2024 16:12:23 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
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

On Mon, 08 Apr 2024 16:10:45 -0500, Jonathan Humphreys wrote:

> Set basic settings needed for System Ready IR ACS testing, for several TI SoC
> based platforms: AM64, AM62, AM62p, BeaglePlay, J7, and BeagleboneAI.
> 
> For AM64, AM62, and AM62p, also includes some config cleanup.  Should be no
> functional change.
> 
> Jonathan Humphreys (15):
>   configs: am64x: cosmetic config cleanup
>   configs: am64x: Enable basic EFI CMD support
>   configs: am64x: Enable RTC emulation
>   configs: j721e: Enable basic EFI CMD support
>   configs: j721e: Enable RTC emulation
>   configs: beagleplay: Enable basic EFI CMD support
>   configs: beagleplay: Enable RTC emulation
>   configs: am62px: cosmetic config cleanup
>   configs: am62px: Enable basic EFI CMD support
>   configs: am62px: Enable RTC emulation
>   configs: am62x: cosmetic config cleanup
>   configs: am62x: Enable basic EFI CMD support
>   configs: am62x: Enable RTC emulation
>   configs: beagleboneai64: Enable basic EFI CMD support
>   configs: beagleboneai64: Enable RTC emulation
> 
> [...]

Applied to u-boot/master, thanks!

-- 
Tom


