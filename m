Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 572D3CD128A
	for <u-boot@archiver.kernel.org>; Wed,  3 Apr 2024 19:07:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5DECA88391;
	Wed,  3 Apr 2024 21:07:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="by5afC5V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 00DF388359; Wed,  3 Apr 2024 21:07:28 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A7988838F
 for <u-boot@lists.denx.de>; Wed,  3 Apr 2024 21:07:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 784FC3FE40
 for <u-boot@lists.denx.de>; Wed,  3 Apr 2024 19:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1712171245;
 bh=cCMn8AJqW95BZUyG/vxxPJ8RgLay5SzGNwn1mefbXmo=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=by5afC5VlrPWXt2sCaAA3ruW04CmqCzcx2GR5tiUk9hWBVLeTUvbt9bCH6NTm+q6U
 hlU/uSHx2nMMg1rwK+PuxeKBzSEQVFOeoo0y/UZ7DqlmMV2fZsSozS7A9L7FBLq45a
 YUbxOkyeTo3MOo9OnWeDZkxvhREHAnT2kn5ZqftVwJZgqUYRiZtyFWhONCp/9CxSKQ
 gcNGnQzKieQEjAd2m9ZCZfGqdZnwnuEufXyzTBBBdmXszR2iHbK5FYvVWm4b/EzZBZ
 /e6eLVca1+CbXcbyxoZ5JT4BULPI17C+XGlxGnILKq4TNS/vCti9nBPyNqTMPWtNTv
 pdQa5DMq1/2xQ==
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3419f517aceso56840f8f.3
 for <u-boot@lists.denx.de>; Wed, 03 Apr 2024 12:07:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712171245; x=1712776045;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cCMn8AJqW95BZUyG/vxxPJ8RgLay5SzGNwn1mefbXmo=;
 b=NyBCKEXFLzmCzpkPiUApyy4xhdocfoMNQ9aZ1NcdEclVxSstD6ikPrJDOK14sIfZUr
 lpwMzGfVXJU58knHOXkOteXlv+uldrk0sTGOH2/qnJ2artC93ebt6PwYoowyGU9OTMAa
 INK2nzszLQRzMuADdkJOgOc3vONmKUJiisvlunbTdBR+WUaAiW5gpo/hxqpfb4vhvlY/
 o27sT/5FYUBHhHOxnUSE+mGKadppGJPvsrdD5NuwsS//H4kt+OCfVacb1QDkuFT2kHLn
 mJZEAFFmYE0Mp0OS05nPKwC6qnV6Ctbokpp0m3XyjSpKVNcndRfKpx7HiDJZtwydZ95Q
 LE0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVwkaNam7yPrnVhxKtEduRcFfRjq95qEvDE5Eb9A+XLLGuuHXHJ8XzvPXK+JgTl8z0sHgXTbb8IZsybLKhwiPpoQlNmEA==
X-Gm-Message-State: AOJu0YyE6dqfebpVVMvAB///unSbiz/HFaFobFoZubwkLH2wflCm+mpK
 auGZ5Pdos1v8KdH2ChHRur1JSzLEckxbXWMBa3TWbnhAqMTfGQEjf212wz3e1WlDNzfr13jONZo
 VYTe/hu0x8pibsVGIc13ATDqCehSzyobA7ILncx23qHOcKnESDZDSHvfrasYVIG/+Hg4=
X-Received: by 2002:adf:ef4f:0:b0:341:e10a:4858 with SMTP id
 c15-20020adfef4f000000b00341e10a4858mr201090wrp.56.1712171244868; 
 Wed, 03 Apr 2024 12:07:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEEOhbyaWOnkzACcad71gQhRMLJwdOrLxfn9mxhdre+WbpyKOVdNfW5tomHJmATUt+lU34A+A==
X-Received: by 2002:adf:ef4f:0:b0:341:e10a:4858 with SMTP id
 c15-20020adfef4f000000b00341e10a4858mr201071wrp.56.1712171244438; 
 Wed, 03 Apr 2024 12:07:24 -0700 (PDT)
Received: from workstation5.fritz.box
 (ip-062-143-245-032.um16.pools.vodafone-ip.de. [62.143.245.32])
 by smtp.gmail.com with ESMTPSA id
 d1-20020adfef81000000b00341d84f641asm18042610wro.8.2024.04.03.12.07.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Apr 2024 12:07:23 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Shantur Rathore <i@shantur.com>, Mathew McBride <matt@traverse.com.au>,
 Mark Kettenis <kettenis@openbsd.org>, Ramon Fried <rfried.dev@gmail.com>,
 Sean Edmond <seanedmond@microsoft.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Dan Carpenter <dan.carpenter@linaro.org>, E Shattow <lucent@gmail.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 0/2] boot: enable compliant booting on EFI systems
Date: Wed,  3 Apr 2024 21:07:13 +0200
Message-ID: <20240403190715.144725-1-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

If UEFI is enabled in U-Boot, we want it to conform to the UEFI
specification. This requires enabling the boot manager boot method.

The default sequence of boot methods is determined by alphabetical sorting
during linkage.

* efi_mgr must run before efi to be UEFI compliant
* pxe should run as last resort

Heinrich Schuchardt (2):
  boot: enable booting via EFI boot manager by default
  boot: correct the default sequence of boot methods

 boot/Makefile           | 2 +-
 boot/bootmeth_efi.c     | 2 +-
 boot/bootmeth_efi_mgr.c | 2 +-
 boot/bootmeth_pxe.c     | 2 +-
 test/boot/bootflow.c    | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

-- 
2.43.0

