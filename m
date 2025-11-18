Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99135CEE34D
	for <u-boot@archiver.kernel.org>; Tue, 18 Nov 2025 21:01:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B36C83AEF;
	Tue, 18 Nov 2025 22:01:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="MgGeM+bm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E193C83AC7; Tue, 18 Nov 2025 22:01:00 +0100 (CET)
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9C3783B1A
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 22:00:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-6567607bd65so1250993eaf.2
 for <u-boot@lists.denx.de>; Tue, 18 Nov 2025 13:00:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763499656; x=1764104456; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xSf49YeqXbWhuWiR1jO3EypYDvnI5fGxhbI/zqqHbGg=;
 b=MgGeM+bmsZM0elT5pJ/cih7a+SFUAXOsH6ilCd0pJjApuI+GrsGKm+/971BN6Oa54n
 7EVpXs5GCBvq5CUsSN0tfZjDSBJssW6j24/XIp6rdudNNlqNNFj1BmVYIMnhhZKsMjjD
 xpW8EJ8w/ykot8JQMAyhOCyH9xZISVySg4ncUlds5nVLahmyOEneiGbYDbFe+jwqX2Fw
 f6VqwoyhZnoSMA46dtMOdTwMNWfgGwZkOnMvpWEmWJMa2fYsq6Yd7vWE5CeYsXI6SaIe
 o5HKAYvXb/6hUGI+RxJLuRUSy6T6Kc0TvYB8XYL0ZGyHoJbIKTXWTM+z4ZTMalPJy7af
 DXsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763499656; x=1764104456;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xSf49YeqXbWhuWiR1jO3EypYDvnI5fGxhbI/zqqHbGg=;
 b=RKPk3lLanW3ovdCaN0su+6noahXkVmMi4ti0s+jTt6W/B1BE/2+7rQPmadtL9eZSWW
 di/NowTKkN+g08rzR4wqaoBAPc1WCIWow+gGxOpQqY6PnlwFq2LNuOSYR2rx/dEAblIp
 AF/fs0k14oGA1QjWnpmJv44mdCC3J7rnZYmY/UMi14LG0O9T3mXfXTcyDL713YPcj8lv
 syVc5R7ro1O9HQ/ERquQXWcHStGchF82hYYtJZ3YXkLVyILQGW9Ww2w9TIxV8Y4VjToD
 Em9uPVNuYZLfREXcWNyVtXFgHJI4YJgda7MA/yYA3WFrAOHc1+RMaG+NnKXrxuSy9qpK
 ddXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgWkMUObXXIidlRfN/zIG0fIAxf0MXQS16wixRyKMs1yS7tj4D8v+TurQfnDHVhatRBuCd9qU=@lists.denx.de
X-Gm-Message-State: AOJu0Yy7CamebCUhY6C7EwGjKa63SC4bqYM+VD9PhoK5zbZ/tB/A4wGv
 rpkWXMF7r7z8Xt8cvtKZZ0evee5pCmCBmKIX8K79llhyp1JATWAGxyiY5kYWP/kcrps0ZMGfkyV
 3tbU8
X-Gm-Gg: ASbGnctFUuAXkFO/gmnfBptAuDRus+TZxMh5H7ruU8w6y0ZF9/rkk2Ige/gkyW5BGaW
 DRFhkFoFYbIOlEIrJQuKUrAaApDCt85IAkEcI+Bkn29GUfDJNpgoF7ij+4+7fLuQjVpewRne9Xa
 SwpEG/aytvqtJIx9j7qZxsakQVcVkWL/nf21ehjDMqWkad+LSykfCbC/9H/xXNHZ57XgTt8rf7q
 U5mMvwfJBB4NF+Ul9epgAYIT8gqsJYw6KhRzpJ2awbzMmCqJzkRQcVmHuJsKYI9lWncT8ex/oqM
 ZbgwOJ2OpoHefk/pQ5xfGagI+6jYo5WPCabTTNcrodCWWPqACpYFaHC2AQW1UhrQhwFxNnoaeJ8
 s6MgLWvbfIppbHRhZAK4i5lqEn6w54r+uuY28P31NP1aQ6rpbLWbRWSVsCOVFVBRQ9RJUrYyCen
 lyuPM+mSoS9JaSM1PpDohgW0HcoWPWOmw=
X-Google-Smtp-Source: AGHT+IEHZ1aJVFLussYRWVmeNfrM+hVsH4+15p/EQQOTyM060P+Yg8LzRC6+5VO0CNZhX8PN5uWVyw==
X-Received: by 2002:a05:6870:d613:b0:3ec:5cc6:315f with SMTP id
 586e51a60fabf-3ec5cc64ed9mr2934493fac.3.1763499656322; 
 Tue, 18 Nov 2025 13:00:56 -0800 (PST)
Received: from localhost ([2605:a601:81da:7100:264b:feff:fe59:d7f7])
 by smtp.gmail.com with UTF8SMTPSA id
 586e51a60fabf-3e8522b268fsm7473647fac.18.2025.11.18.13.00.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Nov 2025 13:00:55 -0800 (PST)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Minkyu Kang <mk7.kang@samsung.com>,
	Tom Rini <trini@konsulko.com>
Cc: Minkyu Kang <promsoft@gmail.com>,
	u-boot@lists.denx.de
Subject: [PATCH] doc: samsung: Fix PXE doc for E850-96 board
Date: Tue, 18 Nov 2025 15:00:55 -0600
Message-ID: <20251118210055.25385-1-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.47.3
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

As stated in PXELINUX doc [1], the PXE configuration file has to be in
the format of "01-MAC-address" for Ethernet connections:

    The hardware type (using its ARP "htype" code) and address, all in
    lowercase hexadecimal with dash separators. For example, for an
    Ethernet (i.e. ARP hardware type "1") with address
    "88:99:AA:BB:CC:DD", it would search for the filename
    "01-88-99-aa-bb-cc-dd".

Indeed, PXE implementation in U-Boot looks for files like that, as can
be seen from this call chain:

    format_mac_pxe()
    pxe_mac_path()
    pxe_get()
    extlinux_pxe_read_bootflow()

Mention the fact that PXE expects the configuration file to be prepended
with "01" in the PXE section of E850-96 documentation. While at it, fix
some other minor issues in PXE section.

[1] https://wiki.syslinux.org/wiki/index.php?title=PXELINUX

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 doc/board/samsung/e850-96.rst | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/doc/board/samsung/e850-96.rst b/doc/board/samsung/e850-96.rst
index 2b66e6568fb3..3174a7daff96 100644
--- a/doc/board/samsung/e850-96.rst
+++ b/doc/board/samsung/e850-96.rst
@@ -637,9 +637,14 @@ machine:
     `-- pxelinux.cfg
         `-- 01-02-36-f5-1c-81-13
 
-  where ``'01-02-36-f5-1c-81-13'`` file contains extlinux configuration for
-  TFTP to load and boot. The name of this file is the Ethernet MAC address,
-  which can be looked up in the ``$ethaddr`` environment variable in U-Boot.
+  where ``'01-02-36-f5-1c-81-13'`` file contains extlinux configuration for TFTP
+  to load and boot. The name of this file has to be in the format of
+  ``'01-MAC-address'``. The Ethernet MAC address in this case is
+  ``02-36-f5-1c-81-13``, and it can be looked up in the ``$ethaddr`` environment
+  variable in U-Boot::
+
+    => env print ethaddr
+    ethaddr=02:36:f5:1c:81:13
 
   An example of such configuration file is::
 
@@ -667,11 +672,11 @@ machine:
     arch/arm64/configs/defconfig
     ----------------------------
 
-    # Needed for boot from USB storage (mounting rootfs from USB drive)
+    # Keep USB PHY driver built-in, as the Ethernet controller sits on USB bus
     CONFIG_PHY_EXYNOS5_USBDRD=y
     CONFIG_TYPEC=y
 
-    # Needed for NFS boot
+    # Keep Ethernet driver built-in
     CONFIG_USB_NET_SMSC95XX=y
     CONFIG_USB_USBNET=y
 

base-commit: 91861e5a30d217d8e70130c9124c1646f4afef29
-- 
2.47.3

