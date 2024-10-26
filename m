Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11793D10BFF
	for <u-boot@archiver.kernel.org>; Sat, 26 Oct 2024 16:17:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 76F2489031;
	Sat, 26 Oct 2024 18:16:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZHHDJDuQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17B8F88F70; Sat, 26 Oct 2024 17:52:38 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2923B88EFD
 for <u-boot@lists.denx.de>; Sat, 26 Oct 2024 17:52:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=l.rubusch@gmail.com
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a9a017a382bso52341066b.3
 for <u-boot@lists.denx.de>; Sat, 26 Oct 2024 08:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729957955; x=1730562755; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+Q7JtJi6Wqz4MrkVheVk4/io0wAVG04EhwWPdjQa8n0=;
 b=ZHHDJDuQJEuhjGch/wSX/zN5572OlJfk3Gel+MDYZs1XeXyzitqa4r/62oS5nhYIgl
 kc3Hx40mHBzKBpOAtVfKLALAh2zqT38DK0Z/+7elk0SEk0ySz6JbNhVMlHUSAmDfeLuz
 fz2Vd/ItpjNqerP1/TftrRPQ0zyiNHMEXWWQrM47ozDfNuW8waDjwoDcy0pUA2s9NCR6
 9SdzyX48cvnu/XScMKHornj2tnJaUhE04olf9zL1abHvEwUFQ0PuCfhLsGAiHVIZY/0F
 i4UokTn6YJkpPcSq7HzI2jG7ULSCBBCxGBYjbu8iVyhv03t7s29L4XnzXh5O9dSad11A
 xggg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729957955; x=1730562755;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+Q7JtJi6Wqz4MrkVheVk4/io0wAVG04EhwWPdjQa8n0=;
 b=stk37Ppn/qVCX96jw5hFH7IHASMs2OS/HQK/88Jt/3XtqFXOgA9wgnAKMgTiU/lyxQ
 N92IjfhysJwzIS1bCVSDIqz1tFGXmdtsN6oHf03BVZ0ubAJ5KirHD5/QF8KZpv31VUYG
 uBHBDQgPo30qvVbCDwrrc9fMxfS9uftvxFci9xudkS0OLVYunO8QFBFtvUR78ZsfqL2Y
 XAOC1W9G8UwBfUWXs7i3G6Dayw7xpC9PZn9AemofMKA5kQyZsu2P3S3xUfFM1o8F0Ffg
 f9WWjEjOaZ6dcLkZs9OjySfRh53Q0C8a9sj9souwXztefDxNrfk8wnzCySPRfp/mDBA3
 fHMg==
X-Gm-Message-State: AOJu0Yzykzce/9PAfzwshZYw4m3OGHB05yyivn7w7QHP8EmilxiO2WKb
 h/Rh3ZJGDicS6qs10fOhXVvy0bLAmMYmU+QzQ5WQUD5qdldw9i8YV6Jw2Q==
X-Google-Smtp-Source: AGHT+IF7DcYDsbyv1SG1EV6cC50vq2MATZ1nJNBK4WVAY2YX7qR//knlRYgAQ0dArbi4UTkyIa7n0g==
X-Received: by 2002:a05:6402:13cb:b0:5cb:b261:c35a with SMTP id
 4fb4d7f45d1cf-5cbbfa71aa0mr931448a12.5.1729957955356; 
 Sat, 26 Oct 2024 08:52:35 -0700 (PDT)
Received: from 6c1d2e1f4cf4.v.cablecom.net (84-72-156-211.dclient.hispeed.ch.
 [84.72.156.211]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5cbb63197casm1620179a12.63.2024.10.26.08.52.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Oct 2024 08:52:34 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: u-boot@lists.denx.de, trini@konsulko.com, marex@denx.de,
 simon.k.r.goldschmidt@gmail.com, tien.fong.chee@intel.com,
 sumit.garg@linaro.org
Cc: sjg@chromium.org, xypron.glpk@gmx.de, michal.simek@amd.com,
 jit.loon.lim@intel.com, barnas@google.com, l.rubusch@gmail.com
Subject: [PATCH v4 05/11] ARM: socfpga: add Mercury+ AA1 boot scripts
Date: Sat, 26 Oct 2024 15:52:14 +0000
Message-Id: <20241026155220.26300-6-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241026155220.26300-1-l.rubusch@gmail.com>
References: <20241026155220.26300-1-l.rubusch@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 26 Oct 2024 18:16:43 +0200
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
2.25.1

