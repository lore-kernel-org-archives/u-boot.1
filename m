Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E939CC369C2
	for <u-boot@archiver.kernel.org>; Thu, 24 Apr 2025 12:14:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F1B08819D2;
	Thu, 24 Apr 2025 14:14:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="wZxwKQt0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 36C008082A; Thu, 24 Apr 2025 14:14:25 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C56D82063
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 14:14:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 905A841A01
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 12:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1745496858;
 bh=Ar3pM8CNnQ7NlJ9Qj6DPIqB05zpShXcdHPMh5UinlJ4=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=wZxwKQt07kkyxAik4NgAbHRDQC6X6CytFPKzauqImdYOEp2j9Q5S9g8kpOHU6KeGc
 o36nc8Q0LOR7fEtmzfouBAkFPAN7eVR4DB63H9QUBmtsxGGXnV5QsidGR70IjElOIV
 5DZd9CoZ3kdy+oSpitNvTVVU6hQczQnMkqotkivw31FXJcTz9dwkVOI4XBmva+jp5L
 fuc+rvRby5RRk6h76dWgo129P6Tyr4jrS1oRrXIwP/yg63xNzyAJLbTlJV6heJL7Wb
 TxRqdD74zTnbuMdI0tKM9LtZLrha+vpvCbECnItQFgHHGGsXysVWoJbVRmDfEuTT+N
 r/r0V4SC/erfg==
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3912d5f6689so479556f8f.1
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 05:14:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745496811; x=1746101611;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ar3pM8CNnQ7NlJ9Qj6DPIqB05zpShXcdHPMh5UinlJ4=;
 b=NT2zvHoSO25Gii5IebO87eSXQS6Fr0Zicjp+rfWlqir3TiFExMgNFAwZAaypIsXft4
 nxj7mrnpynPAJ1+GUif6MocNhYv1tkpEGeER+3fbeMUrootoe7Nlzsm/VieDnpphTv20
 2lhp/z2oQm6cop7qhS3o7rEnaUq/+pZYlNTrTLdlRN2oTKXWkIRjG8j6TjD5lVCqszyl
 i9lpEfgI+dwKrrGCoqZTHmSlrHhh13aIj6CDoWiC8pm44JnZiIWqjeNzDF9nUgPOJgSH
 9Cj99V/OnBmfMXDXIPlb4bVIiG0qHrnBN/8o1NqdBfmJgGB0O7tG4+DiXAMLdB3gX8AC
 GVzg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVaZLFjjRv9NFDQJBVFpHvkCav9qpESwsBeWY1X9SI8il1RA7jSY6w9nq+AApEQz3U5pymco/I=@lists.denx.de
X-Gm-Message-State: AOJu0YyM0lhJGHj+y9l8Xvl6E566yk/m9hRtHtop9Az06ZPldbqh6P0N
 VbQMd7sJGdf/gbjm83p6+ArCNFcmjTv5Bx+n8nfKuJFnZJaGiOfu9MW+PuDGsxKx+XfVqMjkjvP
 4Hd/OxHt92vg1Gp6ICigP7apeb59fDHMvh9yNRDWR78gNHFcqo1jPEcTH9A2FkJX1l18=
X-Gm-Gg: ASbGncuU9qmOYQirnFkxEBhfQ125BYI00JxzhMA0QJxC5TH9mQiN0Dc6ofdgFy+GlAW
 2tp5g5RHcEyZpAL7Dv+aaQLmh75lU92alLUcKfBO9KLSkbnhBhU3XtHln06Ys24YZaRrZMDm69p
 4CBavkn1lCi2cIb4PzUgYzA1ifJ6M3TKnWLK4kOSJTxrUBJcBl0vjMb7+is1U8OBnIvIlcJ6iGj
 qDdV812xKpuE1urdrr7zyzgci26UAjyGOq+517hGSLzxDzKJEOQkHTUdefviGs0tm5vjV0NZ1Tx
 aMCVjQjotsEU4RXQ0lSJ5K9oQH7iS4g+3NpoRmgJvZLa2aP4Z7K6GY3r40mZETXPldX5Z0vnW58
 2zksVRFMnrrYnWg==
X-Received: by 2002:a05:6000:258a:b0:390:eb50:37c3 with SMTP id
 ffacd0b85a97d-3a06cf5ef0dmr1956824f8f.27.1745496810967; 
 Thu, 24 Apr 2025 05:13:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGCM8rqsEVI8zZAEx9i7xap9XVbcqyTccxDhPaXOz96JWPhZakY4pEYFruslv42sjRt40q3Zw==
X-Received: by 2002:a05:6000:258a:b0:390:eb50:37c3 with SMTP id
 ffacd0b85a97d-3a06cf5ef0dmr1956799f8f.27.1745496810563; 
 Thu, 24 Apr 2025 05:13:30 -0700 (PDT)
Received: from localhost.localdomain
 (ip-005-147-080-091.um06.pools.vodafone-ip.de. [5.147.80.91])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a06d5326e1sm1900906f8f.70.2025.04.24.05.13.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Apr 2025 05:13:29 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>
Cc: Tom Rini <trini@konsulko.com>, E Shattow <e@freeshell.de>,
 Sumit Garg <sumit.garg@kernel.org>, H Bell <dmoo_dv@protonmail.com>,
 Lukas Funke <lukas.funke@weidmueller.com>,
 Matthias Brugger <mbrugger@suse.com>, "E . Shattow" <lucent@gmail.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Simon Glass <sjg@chromium.org>, Andreas Schwab <schwab@suse.de>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v4 7/8] doc: starfive: use jh7110_common.rst
Date: Thu, 24 Apr 2025 14:13:14 +0200
Message-ID: <20250424121315.144549-8-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250424121315.144549-1-heinrich.schuchardt@canonical.com>
References: <20250424121315.144549-1-heinrich.schuchardt@canonical.com>
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

To avoid duplicate maintenance just include jh7110_common.rst to describe
the usage of the different boot sources.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v4:
	no change
v3:
	no change
v2:
	new patch
---
 doc/board/starfive/milk-v_mars.rst   | 12 +--------
 doc/board/starfive/pine64_star64.rst | 18 +------------
 doc/board/starfive/visionfive2.rst   | 39 +---------------------------
 3 files changed, 3 insertions(+), 66 deletions(-)

diff --git a/doc/board/starfive/milk-v_mars.rst b/doc/board/starfive/milk-v_mars.rst
index aba9c9c53d4..ce4539a46f1 100644
--- a/doc/board/starfive/milk-v_mars.rst
+++ b/doc/board/starfive/milk-v_mars.rst
@@ -57,13 +57,6 @@ environment
 or the configuration variable CONFIG_DEFAULT_FDT_FILE can be used to set to
 provide a default value.
 
-Boot source selection
----------------------
-
-The board provides the DIP switches MSEL[1:0] to select the boot device out of
-SPI flash, eMMC, SD-card, UART. To select booting from SD-card set the DIP
-switches MSEL[1:0] to 10.
-
 Preparing the SD-Card
 ---------------------
 
@@ -105,7 +98,4 @@ Copy U-Boot to the SD card
 	sudo cp jh7110-starfive-visionfive-2.dtb /mnt/
 	sudo umount /mnt
 
-Booting
--------
-
-Once you plugin the sdcard and power up, you should see the U-Boot prompt.
+.. include:: jh7110_common.rst
diff --git a/doc/board/starfive/pine64_star64.rst b/doc/board/starfive/pine64_star64.rst
index 1df4b68e4a0..d1752c452da 100644
--- a/doc/board/starfive/pine64_star64.rst
+++ b/doc/board/starfive/pine64_star64.rst
@@ -55,19 +55,6 @@ environment
 or the configuration variable CONFIG_DEFAULT_FDT_FILE can be used to set to
 provide a default value.
 
-Boot source selection
----------------------
-
-Boot mode is selected by an MSEL-DIP marked S1804 and GPIO_0 position adjacent
-to the 40pin GPIO header. ON/ONKE and number markings of the MSEL-DIP are
-misleading; Instead refer to the ``L`` (0) and ``H`` (1) silkscreen for
-accurate selection.
-
-+ (QSPI) Flash: 00
-+ SD: 01
-+ EMMC: 10
-+ UART: 11
-
 Preparing the SD-Card
 ---------------------
 
@@ -109,10 +96,7 @@ Copy U-Boot to the SD card
 	sudo cp jh7110-starfive-visionfive-2.dtb /mnt/
 	sudo umount /mnt
 
-Booting
--------
-
-Once you plugin the sdcard and power up, you should see the U-Boot prompt.
+.. include:: jh7110_common.rst
 
 Serial Number and MAC address issues
 ------------------------------------
diff --git a/doc/board/starfive/visionfive2.rst b/doc/board/starfive/visionfive2.rst
index 44e7fcb3a48..6f3c572f1f8 100644
--- a/doc/board/starfive/visionfive2.rst
+++ b/doc/board/starfive/visionfive2.rst
@@ -132,13 +132,7 @@ Program the SD card
 	sudo cp jh7110-starfive-visionfive-2.dtb /mnt/
 	sudo umount /mnt
 
-Booting
--------
-
-The board provides the DIP switches MSEL[1:0] to select the boot device.
-To select booting from SD-card set the DIP switches MSEL[1:0] to 10.
-
-Once you plugin the sdcard and power up, you should see the U-Boot prompt.
+.. include:: jh7110_common.rst
 
 Sample boot log from StarFive VisionFive2 board
 -----------------------------------------------
@@ -479,34 +473,3 @@ Sample boot log from StarFive VisionFive2 board
 
 	Welcome to Buildroot
 	buildroot login:
-
-Booting from SPI
-----------------
-
-Use Building steps from "Booting from MMC using U-Boot SPL" section.
-
-Partition the SPI in Linux via mtdblock. (Require to boot the board in
-SD boot mode by enabling MTD block in Linux)
-
-Use prebuilt image from here [1], which support to partition the SPI flash.
-
-
-Program the SPI (Require to boot the board in SD boot mode)
-
-Execute below steps on U-Boot proper,
-
-.. code-block:: none
-
-  sf probe
-  fatload mmc 1:3 $kernel_addr_r u-boot.itb
-  sf update $kernel_addr_r 0x100000 $filesize
-
-  fatload mmc 1:3 $kernel_addr_r u-boot-spl.bin.normal.out
-  sf update $kernel_addr_r 0x0 $filesize
-
-
-Power off the board
-
-Change DIP switches MSEL[1:0] are set to 00, select the boot mode to flash
-
-Power up the board.
-- 
2.48.1

