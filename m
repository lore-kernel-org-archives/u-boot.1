Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC1D1C3ABB2
	for <u-boot@archiver.kernel.org>; Wed, 18 Sep 2024 06:15:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5585288EEA;
	Wed, 18 Sep 2024 08:14:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fhEhhMvw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A11E88CDC; Tue, 17 Sep 2024 08:22:08 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44D4388D51
 for <u-boot@lists.denx.de>; Tue, 17 Sep 2024 08:22:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=l.rubusch@gmail.com
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a8a765f980dso95578466b.1
 for <u-boot@lists.denx.de>; Mon, 16 Sep 2024 23:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726554125; x=1727158925; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TD9JRY7G1DS8yikvGcH42adJEvkLry5qRRx6nFwl78M=;
 b=fhEhhMvwYiqrPdSUlNWETjBDLp8U8YX0KjV1zGdJa4C6WA8hCjxziaQSJPMQ24oGUR
 MF1ozXt4nh0VrQ5e7kU9xmxH2L/ycjXy29r4ISb+NcylLP8OaMKPi/tH8kpirhKytJud
 RaI/lGXBU4ihZGYELCr9ZxXWwAtI4niDLsu3q3JkVi7cQGPJMaDLWpki5Aw5HScAdKnm
 LkenKmkkRKdMl47+wueYC6FQVbkbRUV/HKjcGg9SQIyuF1LasR/gXFk99VkKuZhEmq+P
 Ue6ip1AB7FJ+sNA4J2HiwEDPejY4ZKbNdK+0sgbue5bw1fxlyVB5fLGE1kGotsVdQucZ
 U39g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726554125; x=1727158925;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TD9JRY7G1DS8yikvGcH42adJEvkLry5qRRx6nFwl78M=;
 b=J1h+wYrJ/4w0cEZ3R/acODQQmDhc8xzppqHAZuLGqRNHM4EcNObINPQtZIS3QTk1+T
 kJWFNDrZHfDW0o99ZeP+zGry87YOvvoy7DyFZngNUJgnKb0Z7fwF9Lq84JW8ezW0n8hg
 9z3KsBejeylq2smqCalYGTVA2WP/AdOvmnePKQjMb6idhb2TlJ6rGGrUjZeYKdsY5yXh
 8YfCkAAFNX/tTZn4KvrOjSbLRXxYZg+7MDqWDVwwS9+R+IAAH87O+YfswHPcSN5Ojlvi
 EYjVgNTpueVXOjEGW1r3biZlPMa6G1HwCpTOXBDzXsBpIKshPZT302BcglItlLN3+GMJ
 ScuQ==
X-Gm-Message-State: AOJu0Yzk1bg2H+I4nyFfhSMS5juRNOB6/Ia6mzoWt5i2YBZWY8xzjUPn
 ++pT7nHnAk/vLP5+ZJqTjqKqhRaFLAOQgpEOUWaSKxURNGSWvbeKsvUWiB0R
X-Google-Smtp-Source: AGHT+IGGf8gjIvSIpmoMUyCRf4kP6idumDg3hWaWk/p29ZHp6DcDle4MouhqOpP1xFj8J24qayKsbA==
X-Received: by 2002:a17:907:ea0:b0:a8d:2624:1a84 with SMTP id
 a640c23a62f3a-a90296100ddmr902005066b.11.1726554124243; 
 Mon, 16 Sep 2024 23:22:04 -0700 (PDT)
Received: from fc8b2ad344cc.pool3007.local ([83.68.141.146])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9061328e61sm403556366b.196.2024.09.16.23.22.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Sep 2024 23:22:03 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: u-boot@lists.denx.de, trini@konsulko.com, marex@denx.de,
 simon.k.r.goldschmidt@gmail.com, tien.fong.chee@intel.com
Cc: l.rubusch@gmail.com
Subject: [PATCH v2 6/7] ARM: socfpga: add Enclustra AA1 boot scripts
Date: Tue, 17 Sep 2024 06:21:56 +0000
Message-Id: <20240917062157.3181-7-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240917062157.3181-1-l.rubusch@gmail.com>
References: <20240917062157.3181-1-l.rubusch@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 18 Sep 2024 08:14:47 +0200
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

