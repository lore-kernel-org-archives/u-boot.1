Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 513FDC7EE39
	for <u-boot@archiver.kernel.org>; Sun, 29 Jun 2025 20:02:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B21FF82F30;
	Sun, 29 Jun 2025 22:02:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CF9+JauA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B372A82F4E; Sun, 29 Jun 2025 22:02:05 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B951282EA9
 for <u-boot@lists.denx.de>; Sun, 29 Jun 2025 22:02:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3a57ae5cb17so829037f8f.0
 for <u-boot@lists.denx.de>; Sun, 29 Jun 2025 13:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751227323; x=1751832123; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5+S4tKNGUgcPqeBZE4hV5oHOjUoJOjaTy24/d2hFkJU=;
 b=CF9+JauAQNz5ec2A0ZXRg71XWTwjgjky3KSKColjjjqEv8xOBzaZvOumyZuzcVVDQH
 LtOKY/6Jdco6Wmn+G4k9hv0asr2FMw67H0BbPYFlB7rVZX7f8SozF1GsxvzmEXTIOJjV
 u0aRX5SO0ipxlwmFbvRNl0SWXmtHYvD+uMd41NopbMf3LsAF1C4WKzYiwyPc9PupzJ86
 ATyhRzkSoDDn7531Yir8Q/JaHfq5ZJ+wpmtP6V/+mM6fPrYnPpYW3uYGBIQStMgcSO+v
 4vVJPatvEvPGss9CSp0iJ69e0iLnzyieSxAxwWkKPv0Bb8fpXIyj+uTkRdmN49Uh5x8F
 Chtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751227323; x=1751832123;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5+S4tKNGUgcPqeBZE4hV5oHOjUoJOjaTy24/d2hFkJU=;
 b=dX6BIZmX/cwdwjqfLPG/k0k2dYYnryRwt5T7Y03RPP4f6lh+Y39YjY2hQyKdKiwPts
 QPHTuAYn8PJk1azsFjrpkoUtvKQrHX4xx/MzO1FXUfmcZtVuB5opeAM+P7Zn8wMmwonh
 tqeeDPgtCnkx12zYT9jKXUXQcl4fi/81SokZMtjBEq/rx9OPCQ3hdfOw3S7iHfSFAF/b
 5eA5k5THLx96Mg/p6lBbOFMY5gwHzR5L/bwcUBo3mIwE0LtSn3ykNfhUHRr/QHXoAUVb
 EU3nlYIRWRKwm1nJdk6xnQauBrgT84FakHAGN9f0iH3Yb+X9QScpqwEC8VIzyk/5h9pU
 SCrQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUt3oGkAneyB7wCFGs36LgtQXoxh/sQjqtG60EG7fzx2c6DGsPuA2OvjyTN5Rley43JBBsM4RY=@lists.denx.de
X-Gm-Message-State: AOJu0YzFJla5zfGOoaEz56DLyum4l8hP7LUXaY7/YDhk6WMsc8mWz3We
 H5h/8n1Md2ibHtlior366VATjN9MrYcIkXoAka99M1xCsPv2TA1asRY6vhfXZg==
X-Gm-Gg: ASbGncujzCpuJgPbs2HaTSUEUvNETbgOB8Xbq+pADGAW3a38wIPdPc4EKEZQ7MPGdRi
 byyQ56mRHF83Si10lA8YbX+o0/iikQkiG0V+fB/uV5waVBGLWSMiMojOIhkEYk+4oYpcuDE7Je3
 oKof6iCjxNo3SQRmjYdwUs++NGutG+u/ZoAWWg+ZUsQGgYIg0ZxWLefk+35xEu8pAH3s7aVixpd
 ZBaeS1ay4iAkFuDxsh7uMHfYhqHAipo+A2uaGqBrxNGzRTQmDadlqqZPPlWrCuWZ2mRZYosvB27
 QJDrpZGFUnejMKr0BEWnd3RFhgLHUjWAbjOxUqgKjNdkWVgyuSXWMJpgEzK1M9RfrixT3ZAQgpg
 vyr1vP0KH4ysNwLzCS4D6LcRq/sMsaBYz0Y5sL/bSdJ5Sb7kcFBt5Ak3MnBHXeePQ8FzSmw/8tw
 lB5I+XT8ML/VcGw52LkLAx
X-Google-Smtp-Source: AGHT+IHYu+YtNh3hgKgPWK4b2mOJJRLw54xTpyloUvKZuP7sB7YCKj3k1TL6fgosoS1aiNtUAijP0w==
X-Received: by 2002:a05:6000:4716:b0:3a4:ef0d:e614 with SMTP id
 ffacd0b85a97d-3a8fe5b1cecmr9429950f8f.33.1751227322683; 
 Sun, 29 Jun 2025 13:02:02 -0700 (PDT)
Received: from cypher.home.roving-it.com
 (2.c.4.1.7.3.6.4.2.a.a.3.0.f.c.2.1.8.6.2.1.1.b.f.0.b.8.0.1.0.0.2.ip6.arpa.
 [2001:8b0:fb11:2681:2cf0:3aa2:4637:14c2])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-3a892e5f918sm8465384f8f.100.2025.06.29.13.02.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Jun 2025 13:02:02 -0700 (PDT)
From: Peter Robinson <pbrobinson@gmail.com>
To: Adam Ford <aford173@gmail.com>, Tom Rini <trini@konsulko.com>,
 "Derald D. Woods" <woods.technical@gmail.com>, Marek Vasut <marex@denx.de>,
 Paul Kocialkowski <contact@paulk.fr>, u-boot@lists.denx.de
Cc: Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH 0/3] drop legacy musb stack
Date: Sun, 29 Jun 2025 21:01:58 +0100
Message-ID: <20250629200200.53994-1-pbrobinson@gmail.com>
X-Mailer: git-send-email 2.50.0
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

Drop the legacy musb driver stack. There was just two remaining users,
both of which appear to have musb-new drivers, I can't test those
devices but it should be relatively striaght forward to follow up with
any fixes, and one appears to be a mistake. I think it's useful to get
rid of this legacy code. I didn't rename the musb-new -> musb directory
as it seems like churn, I can follow up with a rename patch if it's
wanted.

Peter Robinson (3):
  omap3: evm: Drop old musb omap3 driver
  am33xx: am3517 evm: Drop old musb AM35X driver
  usb: musb: drop musb legacy drivers

 configs/am3517_evm_defconfig  |    2 +-
 configs/omap3_evm_defconfig   |    1 -
 drivers/usb/Kconfig           |    2 -
 drivers/usb/musb/Kconfig      |   20 -
 drivers/usb/musb/Makefile     |    9 -
 drivers/usb/musb/am35x.c      |  138 ----
 drivers/usb/musb/am35x.h      |   81 ---
 drivers/usb/musb/musb_core.c  |  150 -----
 drivers/usb/musb/musb_core.h  |  343 ----------
 drivers/usb/musb/musb_debug.h |  191 ------
 drivers/usb/musb/musb_hcd.c   | 1161 ---------------------------------
 drivers/usb/musb/musb_hcd.h   |   93 ---
 drivers/usb/musb/musb_udc.c   |  953 ---------------------------
 drivers/usb/musb/omap3.c      |  129 ----
 drivers/usb/musb/omap3.h      |   38 --
 15 files changed, 1 insertion(+), 3310 deletions(-)
 delete mode 100644 drivers/usb/musb/Kconfig
 delete mode 100644 drivers/usb/musb/Makefile
 delete mode 100644 drivers/usb/musb/am35x.c
 delete mode 100644 drivers/usb/musb/am35x.h
 delete mode 100644 drivers/usb/musb/musb_core.c
 delete mode 100644 drivers/usb/musb/musb_core.h
 delete mode 100644 drivers/usb/musb/musb_debug.h
 delete mode 100644 drivers/usb/musb/musb_hcd.c
 delete mode 100644 drivers/usb/musb/musb_hcd.h
 delete mode 100644 drivers/usb/musb/musb_udc.c
 delete mode 100644 drivers/usb/musb/omap3.c
 delete mode 100644 drivers/usb/musb/omap3.h

-- 
2.50.0

