Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18905D6C2BA
	for <u-boot@archiver.kernel.org>; Wed, 20 Nov 2024 00:29:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 44F3B8963A;
	Wed, 20 Nov 2024 01:28:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DDwcf84L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E46E895D8; Tue, 19 Nov 2024 23:46:57 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 51CD6895D0
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 23:46:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=l.rubusch@gmail.com
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43159555f29so5964695e9.3
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 14:46:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732056415; x=1732661215; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3VeLkBhHNTPKgBKHtvcBkoTCMemneo1KRpoomrwYlaY=;
 b=DDwcf84LYpsDdKWVn+K3lJLjcoTVV0wgL273nhlgSaxK58ksxFAuDL4pp1A5WQ9i6Q
 2JOl903xlXoOwV6raN4YN2cAf0OJV9quaxxwB6Ftih5VhNb6h2rNZECd55kxXi5/yrNk
 j5DrgKoPrTRFqfUggXrB23bEsauJKPFLN3hT011TCXvAYMPzAYkh36rsdeeDYQKTSWGy
 9onm9kwrdPNBSEqmTJD5fbO113s6n4uD9YBOj0f+xJ86USTYtKuERGLetCOrVUL7A9NZ
 YUUV67kCxen0GYH0Fh24LX7GVYfNEG2MULYY1Ds3FUB5yWTdp/b0ijSM/zV1D4t2I3Pw
 lMwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732056415; x=1732661215;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3VeLkBhHNTPKgBKHtvcBkoTCMemneo1KRpoomrwYlaY=;
 b=HeAXVG316U0084l3ORb56+gCwGQRoaITRTGuG5U6HiVEz9iqVTDmgKY9ZMZKWapbg8
 Ot/XuWMqo2QXP2Nm46lOx8cb0LDSzhCjIYiexLm8P/QX1hV0l9+MPHJ3+5OnyJ7dhB45
 FSWCgj+p+wqNM/GetmWm3o/m3SG4iDavZWveLlWim0Db+e0e3Kd0FBptGH/cGcb4gJ4v
 K5j7LIGnOhlnFufQiqjlYMt9YfuKuEmjXjMVHw+vw0SqkS1sqYpEjQ5/6v/yJ1MSsMV2
 tZ1Euwk8bOPN5WIYRA1FujMU80VwzSIBjarX/UgVKZpYzoTmXgLXgvoEJTBwk2aT9RC3
 2Sgg==
X-Gm-Message-State: AOJu0YwrKgmzGIuPsQeneBrpeqqIHr7GNBZDasCbdt+ZcSu+bsfzTudQ
 oty/DMAACeelpXSvawCIKYGBACJMcKeEZiKAZBf35Nhvq58NWfuSucpVJZCO
X-Gm-Gg: ASbGncsc8nLT1KEez2X6JAcZjH6OFAfD8EMojcrjxKKxPM5uzf9i0f9fdr5r3brHsTD
 W6s7G7Vfn8rypE1X6scmDO+5jrDdgfyR68Ln11hrQC/e44T9JkkW6m3hN3lVi30ZAuyVC8ZZdYz
 iN/lx/src+pf64kK0FHEPwFihAC3bdQCXMoWizSrFJw7NunS00CWVsBq/jvoOIO9gLUoPe71gns
 4jQgMPlkDzAyKP5nNScHqZrjQRoSSmUsHnPxzQYcyt1MJv1+/XrBRDVURvcDxZcIHnb+XRJhoht
 2RZfkfM+CpGUrBNUYi+E38Eu4Eu2
X-Google-Smtp-Source: AGHT+IG/2bGj5YoltLW7qTJV6suLg1u9fnYFlIce0y9SzdgUyBmk/z80PuQYwW4c9c7wLTU4G468sw==
X-Received: by 2002:a5d:6c63:0:b0:37d:4705:ff71 with SMTP id
 ffacd0b85a97d-38254b165eemr153370f8f.10.1732056414353; 
 Tue, 19 Nov 2024 14:46:54 -0800 (PST)
Received: from d71e1d1a2016.v.cablecom.net (84-72-156-211.dclient.hispeed.ch.
 [84.72.156.211]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432da27fc8esm216979795e9.21.2024.11.19.14.46.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2024 14:46:53 -0800 (PST)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: u-boot@lists.denx.de, trini@konsulko.com, marex@denx.de,
 simon.k.r.goldschmidt@gmail.com, tien.fong.chee@intel.com,
 sumit.garg@linaro.org
Cc: sjg@chromium.org, xypron.glpk@gmx.de, michal.simek@amd.com,
 jit.loon.lim@intel.com, barnas@google.com, l.rubusch@gmail.com
Subject: [PATCH v4 v5 05/10] ARM: socfpga: add Mercury+ AA1 boot scripts
Date: Tue, 19 Nov 2024 22:46:38 +0000
Message-Id: <20241119224643.27692-6-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241119224643.27692-1-l.rubusch@gmail.com>
References: <20241119224643.27692-1-l.rubusch@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 20 Nov 2024 01:27:55 +0100
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

Add bootscripts to boot Enclustra SoMs from MicroSD card or QSPI flash.
MicroSD card as bood device here covers the cases of sdmmc or emmc as
such boot media.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 board/enclustra/bootscripts/qspi-aa1.cmd | 12 ++++++++++++
 board/enclustra/bootscripts/sd-aa1.cmd   |  9 +++++++++
 2 files changed, 21 insertions(+)
 create mode 100644 board/enclustra/bootscripts/qspi-aa1.cmd
 create mode 100644 board/enclustra/bootscripts/sd-aa1.cmd

diff --git a/board/enclustra/bootscripts/qspi-aa1.cmd b/board/enclustra/bootscripts/qspi-aa1.cmd
new file mode 100644
index 0000000000..9633754491
--- /dev/null
+++ b/board/enclustra/bootscripts/qspi-aa1.cmd
@@ -0,0 +1,12 @@
+# This is an example input file for boot.scr generation.
+# Generate boot.scr
+# ./tools/mkimage -A arm -O linux -T script -C none -a 0 -e 0 -d board/enclustra/bootscripts/qspi-aa1.cmd boot.scr
+#
+# Note: The needed variables need to be set in the environment.
+bridge enable
+sf probe
+sf read $kernel_addr_r $qspi_offset_addr_kernel $kernel_size
+sf read $fdt_addr_r $qspi_offset_addr_devicetree $fdt_size
+sf read $rootfs_addr_r $qspi_offset_addr_rootfs $rootfs_size
+run fdtload_qspi
+bootm $kernel_addr_r $rootfs_addr_r $fdt_addr_r
diff --git a/board/enclustra/bootscripts/sd-aa1.cmd b/board/enclustra/bootscripts/sd-aa1.cmd
new file mode 100644
index 0000000000..604ae0760a
--- /dev/null
+++ b/board/enclustra/bootscripts/sd-aa1.cmd
@@ -0,0 +1,9 @@
+# This is an example input file for boot.scr generation.
+# Generate boot.scr
+# ./tools/mkimage -A arm -O linux -T script -C none -a 0 -e 0 -n "U-boot mmc start script" -d board/enclustra/bootscripts/sd-aa1.cmd boot.scr
+#
+# Note: The needed variables need to be set in the environment.
+bridge enable
+load mmc $devnum:$distro_bootpart $kernel_addr_r Image
+load mmc $devnum:$distro_bootpart $fdt_addr_r $fdtfile
+booti $kernel_addr_r - $fdt_addr_r
-- 
2.39.2

