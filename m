Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DC6ED29FB3
	for <u-boot@archiver.kernel.org>; Wed,  6 Nov 2024 07:52:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD40D88D9B;
	Wed,  6 Nov 2024 08:52:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="glxLCxEK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F01DA88FE5; Wed,  6 Nov 2024 08:52:00 +0100 (CET)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08CF488D54
 for <u-boot@lists.denx.de>; Wed,  6 Nov 2024 08:51:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrej.skvortzov@gmail.com
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-53b34ed38easo6185327e87.0
 for <u-boot@lists.denx.de>; Tue, 05 Nov 2024 23:51:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730879518; x=1731484318; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9H8BI1nxMhnY1aC/1UPYlcLv6bhXAqfIJhiiOedjjek=;
 b=glxLCxEK8NNu8x4LjLwJ/AdHj/XEHRbe2hIx9BX6Bq3zHIOC6g9o/HVoSGq2TqAeEu
 Jr0RfVboH6kum/SWCOQEmeva3UBsKov6SgTadSIbHMy8J09Kh+6VQ5umdXSjbOD2RnNN
 qS3mYFgNFSvdjB2K6nvl6e4V88BgzPfI9YsQY2BulBim2SSKflJV59Dxa2vLI3bJdukz
 /T0RM3nE4n/IQJd/E7TrextDt+uFFsD5/kl3GGysPlQLfCPtd7oTljnemyMd0jM1aGjh
 lmyF/z/AlVRDjd/XEeAVyogyc51ogy1+CyxDr8qYs0cs/orrt/5aF06KhgmeqMUgOuj8
 v6DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730879518; x=1731484318;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9H8BI1nxMhnY1aC/1UPYlcLv6bhXAqfIJhiiOedjjek=;
 b=cnw3NuHi/7KOFgJf+EtxhtRYjzG365fHgpqhbLYbgFad/ekIaylVkjP7uyp2QklnR5
 Jr9gR3T7HIXcZffYlyxY3Gs3eHDkPGBS0ZBeHc249AfDeIgWjTuKU9viu/pRqtC3ePkx
 vaEFxt1Q3bh3Tknv9RRQXm9xNbiTlCdMkKw0ABJTI1bgUMSUZtlDzV7wDmxbCfnD4b9Z
 8HPdrm3i0bBU7V4Pb6bhRpattCD+Vxjrk4cPZO75j8Qf9dsNdHhhvwJ9KiWtEmmr68hT
 8I8gd2pkeIclPCDB81dvyyayAfP8NoRXFAogxMBzs7Yn/ONBSlyTuYrnEvQXW37ALPzx
 geGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUekmNVwbExaqd1vNeV5TLUtGQqwUg+xc1FkkA52UXggzX6Ky4avExM7Rj2At3Ol6t6SW/BlIw=@lists.denx.de
X-Gm-Message-State: AOJu0Yz2GQZYbM/pO8f+kJPpcgTwK5wZucCNs5aN6hr2H4j1OuZNL871
 8zVXPMi+IkDqthBVudvSFO5n+St3BWXvwNoZT+wkvNqspZqBheVZ
X-Google-Smtp-Source: AGHT+IEMR3SDEzP0Y6i+guo/L6x2QN/cCes4LbYLM6sB+PKG9PuY896K5J5aU69fqio3Tt1FI3hwZg==
X-Received: by 2002:a05:6512:2311:b0:539:edbe:ac86 with SMTP id
 2adb3069b0e04-53b348b7e1dmr20402825e87.10.1730879518023; 
 Tue, 05 Nov 2024 23:51:58 -0800 (PST)
Received: from localhost.localdomain ([94.19.228.143])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-53c7bcce425sm2389985e87.170.2024.11.05.23.51.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Nov 2024 23:51:57 -0800 (PST)
From: Andrey Skvortsov <andrej.skvortzov@gmail.com>
To: Samuel Holland <samuel@sholland.org>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de, Andre Przywara <andre.przywara@arm.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Samuel Dionne-Riel <samuel@dionne-riel.com>
Cc: Andrey Skvortsov <andrej.skvortzov@gmail.com>
Subject: [PATCH v2] sunxi: defconfig: Add pstore support for pinephone
Date: Wed,  6 Nov 2024 10:49:47 +0300
Message-ID: <20241106074947.1296774-1-andrej.skvortzov@gmail.com>
X-Mailer: git-send-email 2.45.2
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

pstore will allow users to catch kernel crashes and report them to
developers. Modern (Android) phones have pstore usually enabled to get
information about kernel crash, since it's the simplest way to get
kernel backtrace on mobile device without serial console. Usually it's
enabled by default in distribution kernels like Debian.

CONFIG_PSTORE=y
CONFIG_PSTORE_RAM=m

systemd has service that automatically handles pstore and saves them
in /var/lib/pstore for later usage.

In general any DRAM address, that isn't overwritten during a boot is
suitable for pstore.

Range from 0x40000000 - 0x50000000 is heavily used by u-boot for
internal use and to load kernel, fdt, fdto, scripts, pxefile and ramdisk
later in the boot process. Ramdisk start address is 0x4FF00000,
initramfs for kernel with some hacking features and debug info enabled
can take more than 100Mb and final address will be around 0x58000000.
Address 0x61000000 will most likely not overlap with that.

Signed-off-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>
---

Changes since v1:
 - updated description with pstore usage details

 configs/pinephone_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/pinephone_defconfig b/configs/pinephone_defconfig
index 9d39204a439..7b80cc3131b 100644
--- a/configs/pinephone_defconfig
+++ b/configs/pinephone_defconfig
@@ -10,6 +10,8 @@ CONFIG_DRAM_ZQ=3881949
 CONFIG_MMC_SUNXI_SLOT_EXTRA=2
 CONFIG_PINEPHONE_DT_SELECTION=y
 # CONFIG_SYS_MALLOC_CLEAR_ON_INIT is not set
+CONFIG_CMD_PSTORE=y
+CONFIG_CMD_PSTORE_MEM_ADDR=0x61000000
 CONFIG_OF_LIST="sun50i-a64-pinephone-1.1 sun50i-a64-pinephone-1.2"
 CONFIG_LED_STATUS=y
 CONFIG_LED_STATUS_GPIO=y
-- 
2.45.2

