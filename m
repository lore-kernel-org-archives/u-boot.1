Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFDEFEE644D
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 06:14:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ECC8D88E16;
	Thu, 12 Sep 2024 08:13:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="T9veppn3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E71C688D9F; Thu, 12 Sep 2024 08:07:00 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A85988DAE
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 08:06:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=l.rubusch@gmail.com
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a8a7dddd2aaso4704566b.3
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 23:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726121217; x=1726726017; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TD9JRY7G1DS8yikvGcH42adJEvkLry5qRRx6nFwl78M=;
 b=T9veppn3tvV2+8ihe7Lm2hUE0CMR0Xub6tuCTlVxgKQA7qkO+4kR3jtrjtOZMZwVHV
 3fsrqe+GVKE2y3TQOAllG6d63Dm8sjfYditBc0WPq6PZIJosr8Mlx9TX1nArFWAN7YRV
 u4UQRCFAGIUWe0JAQRxuOMHHgF3TAg0+gNm+TOlI7Dp8DSONqsusY+gQadNAq8qXue9f
 YZwhshWKQQL4YJHI+E5JrjV7pzWwBMZO2+UPqnvzaCiZNozEJoTIVdIQGJgG6dsidAkI
 eGFZ6pHUA0wGAOjYoKANtNrIKjeldeCc9815/iauL6Dmeq9rQazE/Lay23RuRuzMp5pA
 ISlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726121217; x=1726726017;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TD9JRY7G1DS8yikvGcH42adJEvkLry5qRRx6nFwl78M=;
 b=LchAgqyw9c5DB4vSk9bKylPnoI8tz2X2oJQbVp8tsJYEQjg+kGjtMK6331G2gbPqSU
 JeGsFdTsTsss5HS2XFfqPYBkO7lg3PoqqCZjU0PWUbTXJOhK6GXXTY2mIqyLTFKOEVOT
 6y+q2AiuikWdQu4yHVCaNsna8J/5phnXNHmmpbr70BFF4ZhaEWk2Nay9CRLJROXYPGcZ
 OmlB/BDGgomUGNs/r9QVGz+Px1Amu4muBAur78HNk7gjtYGgGVPTVldF3p//fId6Jj53
 yb9IQiF00R73ejZFARksWT+EQzNN6inyPt69SMhah/7Au4My1kll9+VZc3KinPplZs6j
 cyLA==
X-Gm-Message-State: AOJu0Yye0P8Ob6jItD4Khr3/EajgJ8IrRwUmiBqlJ3XV1JBblI+jyCI+
 CqAxu08KFDGzEoRu7CE1lOl9Ky+kq0YiCV94WmeMuMhtvmsIwjRe3xZIxQ==
X-Google-Smtp-Source: AGHT+IESzcD8Q0l9J4N9jsCq+lvzLXgpEqrFCvC8BpFFxaNozR1vljVsBWNOzxvz+I2GiSVFLsPPEQ==
X-Received: by 2002:a17:907:6e9f:b0:a80:a23e:fbf9 with SMTP id
 a640c23a62f3a-a9029446fe6mr59654566b.6.1726121216783; 
 Wed, 11 Sep 2024 23:06:56 -0700 (PDT)
Received: from 77c10117340a.v.cablecom.net (84-72-156-211.dclient.hispeed.ch.
 [84.72.156.211]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d2598b844sm698112866b.76.2024.09.11.23.06.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 23:06:56 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: u-boot@lists.denx.de, trini@konsulko.com, marex@denx.de,
 simon.k.r.goldschmidt@gmail.com, tien.fong.chee@intel.com
Cc: l.rubusch@gmail.com
Subject: [PATCH 6/9] ARM: socfpga: add Enclustra AA1 boot scripts
Date: Thu, 12 Sep 2024 06:06:46 +0000
Message-Id: <20240912060649.190-7-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240912060649.190-1-l.rubusch@gmail.com>
References: <20240912060649.190-1-l.rubusch@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 12 Sep 2024 08:13:00 +0200
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

Add support to boot Enclustra SoMs from MMC, SD or QSPI flash.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 board/enclustra/bootscripts/qspi-aa1.cmd | 12 ++++++++++++
 board/enclustra/bootscripts/sd-aa1.cmd   | 10 ++++++++++
 2 files changed, 22 insertions(+)
 create mode 100644 board/enclustra/bootscripts/qspi-aa1.cmd
 create mode 100644 board/enclustra/bootscripts/sd-aa1.cmd

diff --git a/board/enclustra/bootscripts/qspi-aa1.cmd b/board/enclustra/bootscripts/qspi-aa1.cmd
new file mode 100644
index 0000000000..42d02cfce1
--- /dev/null
+++ b/board/enclustra/bootscripts/qspi-aa1.cmd
@@ -0,0 +1,12 @@
+# This is an example input file for boot.scr generation.
+# Generate boot.scr
+# ./tools/mkimage -A arm -O linux -T script -C none -a 0 -e 0 -d board/enclustra/bootscripts/qspi-aa1.cmd boot.scr
+#
+# NB: The needed variables need to be set in the environment.
+bridge enable
+sf probe
+sf read $kernel_addr_r $qspi_offset_addr_kernel $kernel_size
+sf read $fdt_addr_r $qspi_offset_addr_devicetree $fdt_size
+sf read $rootfs_addr_r $qspi_offset_addr_rootfs $rootfs_size
+run fdtload_qspi
+bootm $kernel_addr_r $rootfs_addr_r $fdt_addr_r
diff --git a/board/enclustra/bootscripts/sd-aa1.cmd b/board/enclustra/bootscripts/sd-aa1.cmd
new file mode 100644
index 0000000000..4beefc7e13
--- /dev/null
+++ b/board/enclustra/bootscripts/sd-aa1.cmd
@@ -0,0 +1,10 @@
+# This is an example input file for boot.scr generation.
+# Generate boot.scr
+# ./tools/mkimage -A arm -O linux -T script -C none -a 0 -e 0 -n "U-boot mmc start script" -d board/enclustra/bootscripts/sd-aa1.cmd boot.scr
+#
+# NB: The needed variables need to be set in the environment.
+bridge enable
+fatload mmc $devnum:$distro_bootpart $kernel_addr_r Image
+fatload mmc $devnum:$distro_bootpart $fdt_addr_r $fdtfile
+run fdtload
+bootm $kernel_addr_r - $fdt_addr_r
-- 
2.25.1

