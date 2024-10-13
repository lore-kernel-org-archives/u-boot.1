Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6FB3CF259D
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 02:45:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C997E8888F;
	Mon, 14 Oct 2024 04:44:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mz8KKZnR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6B24488F16; Sun, 13 Oct 2024 16:32:52 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CBF3E88F44
 for <u-boot@lists.denx.de>; Sun, 13 Oct 2024 16:32:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=l.rubusch@gmail.com
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5c937982445so760359a12.2
 for <u-boot@lists.denx.de>; Sun, 13 Oct 2024 07:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728829963; x=1729434763; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TPcNzIJW4FtShyRIxCI4CHgzqxuw4HuH5HFOsQ13zss=;
 b=mz8KKZnRoNPx19fygdKFDC59yuHRcnIXIRcqEcWWs92wZyAgtA1kj3Qp1brYr/6m0T
 BXn9mTukGqMQRB3pBbBHzKxJO/joF+lN5Bhi4MEZ+fWuD9UIz+VZ7UMqXwr1pOPh9W6F
 9qfd5oTLhDXHFG+cxCoJV44S2LiNQY4+B1xfZ4qjim4xYGBoK0CCAcks68jqvUlA8frY
 8MSJNm2M+znpZYEaP4BM9J/dSgUCTE95rwt7Rxny/+yXeAu0aRkGlXWNkEXX2HZsNFGx
 41DSikb17HgqCNNIS+W3G5cBVpoTRBokgvxzRtTwD9oHu6bBbacxSDwb1kkZHoT8O2p5
 Vqlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728829963; x=1729434763;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TPcNzIJW4FtShyRIxCI4CHgzqxuw4HuH5HFOsQ13zss=;
 b=jdtR37yZq5/k3EtBE+KA9wgWW9oAbuPQpq7jHyvJoFX8dsAIr+9UA7BQmCS/Hi2r6+
 M6N6Vp6f+2LbBRVSVaMurAME1OpySLQsqfpOi9CdNQzWIgBGTDTEi0m9PEJuGpWkcdla
 MsxGS+yl+bjU4siWBlWoZ1fcqwv2urr/8MywByjDNHyBHGMUFITDQILxkIZaBLa4xlID
 Derup/0ocTQuUbhVF81/xHEnHfD38TLgb6LjA17fIs91CLYOJ/SYLcZD3fGxY3nbMFzl
 zoX/ZLyt/qAmsBkZsAO9GYCBMpu24ti0LMTpQquCoxHIJnTQEM6QHxXnwmtu/MbldPsV
 1psg==
X-Gm-Message-State: AOJu0YzIysSd5OsZsWvVACXv5FHtA6dUcWu4084OsijIcrLWL1iz90z3
 17JnLD1rWTRvPaZ30qIZEOwHfK33KHxh/YgVYKRUhGRqU9C1MwZX8wee9g==
X-Google-Smtp-Source: AGHT+IElsCucIwo58SC70AccIqlnSG6cgWXkMxeDq6oMq931AcTl5o0Ug1XrhTwKi7W+m38/6Xvl0g==
X-Received: by 2002:a17:907:7290:b0:a99:6036:900 with SMTP id
 a640c23a62f3a-a99b941602amr369561566b.4.1728829963172; 
 Sun, 13 Oct 2024 07:32:43 -0700 (PDT)
Received: from e8ff02ae9b18.v.cablecom.net (84-72-156-211.dclient.hispeed.ch.
 [84.72.156.211]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a99efcf15d1sm189886266b.102.2024.10.13.07.32.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Oct 2024 07:32:42 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: u-boot@lists.denx.de, trini@konsulko.com, marex@denx.de,
 simon.k.r.goldschmidt@gmail.com, tien.fong.chee@intel.com,
 sumit.garg@linaro.org
Cc: sjg@chromium.org, xypron.glpk@gmx.de, michal.simek@amd.com,
 jit.loon.lim@intel.com, barnas@google.com, l.rubusch@gmail.com
Subject: [PATCH 06/10] ARM: socfpga: add Mercury+ AA1 boot scripts
Date: Sun, 13 Oct 2024 14:32:28 +0000
Message-Id: <20241013143232.2090645-7-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241013143232.2090645-1-l.rubusch@gmail.com>
References: <20241013143232.2090645-1-l.rubusch@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 14 Oct 2024 04:44:22 +0200
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
index 0000000000..65bee32767
--- /dev/null
+++ b/board/enclustra/bootscripts/sd-aa1.cmd
@@ -0,0 +1,9 @@
+# This is an example input file for boot.scr generation.
+# Generate boot.scr
+# ./tools/mkimage -A arm -O linux -T script -C none -a 0 -e 0 -n "U-boot mmc start script" -d board/enclustra/bootscripts/sd-aa1.cmd boot.scr
+#
+# NB: The needed variables need to be set in the environment.
+bridge enable
+fatload mmc $devnum:$distro_bootpart $kernel_addr_r zImage
+fatload mmc $devnum:$distro_bootpart $fdt_addr_r $fdtfile
+bootz $kernel_addr_r - $fdt_addr_r
-- 
2.25.1

