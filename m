Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38BB7C47073
	for <u-boot@archiver.kernel.org>; Sat, 30 Dec 2023 23:53:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33F0C877B7;
	Sun, 31 Dec 2023 00:53:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="eRQs+O0Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 34A7B8747A; Sun, 31 Dec 2023 00:53:17 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E31EE876F3
 for <u-boot@lists.denx.de>; Sun, 31 Dec 2023 00:53:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.fritz.box (ip-178-202-040-247.um47.pools.vodafone-ip.de
 [178.202.40.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id E21514167A; 
 Sat, 30 Dec 2023 23:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1703980393;
 bh=S5Scu3XjM2HC7J7MMrzBVYkhpC+RU4ayDjctB1goeeI=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=eRQs+O0ZecvfVzsXYsOJHYMc5ITVq3n7msFy2oZ0YojRaK6y+xgWfBfXa7x7cdIhA
 Mpo8IeH0slS4tFZWpwsQCS5ZIVbQCOiI0TcpDiswRJ3+3ikBJIqDwaP8Bvko7f2xdn
 pFUrL/EyAESicTot+Ze+zczhOUB7yaXdHujGokHNQHb86dWpT29wG2dEitWNNxawvk
 jqKOYVdjRd8kNmqTjyQ/zwsOAnpX8t0W/oFuVm3sRiNTJALD7skG07TNFNhyKLdI9e
 9xmKuuSbv0/8xW/aCiB0zlMzgYHRVlLhTd8CMadwxVM06jCG1nZ9j37O9v0JcsfUw1
 K50LPwQuNWvVA==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Tom Rini <trini@konsulko.com>
Cc: Bin Meng <bmeng.cn@gmail.com>, Simon Glass <sjg@chromium.org>,
 Sergei Antonov <saproj@gmail.com>, Chris Packham <judge.packham@gmail.com>,
 u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH 2/2] riscv: qemu: imply GOLDFISH_RTC
Date: Sun, 31 Dec 2023 00:53:01 +0100
Message-ID: <20231230235301.236868-3-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231230235301.236868-1-heinrich.schuchardt@canonical.com>
References: <20231230235301.236868-1-heinrich.schuchardt@canonical.com>
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

QEMU's virt board provides an emulated Goldfish RTC. Enable the driver by
default.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 board/emulation/qemu-riscv/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/board/emulation/qemu-riscv/Kconfig b/board/emulation/qemu-riscv/Kconfig
index cdd0d0d95f..e15d23c99b 100644
--- a/board/emulation/qemu-riscv/Kconfig
+++ b/board/emulation/qemu-riscv/Kconfig
@@ -58,6 +58,8 @@ config BOARD_SPECIFIC_OPTIONS # dummy
 	imply NVME_PCI
 	imply PCIE_ECAM_GENERIC
 	imply DM_RNG
+	imply DM_RTC
+	imply RTC_GOLDFISH
 	imply SCSI
 	imply SYS_NS16550
 	imply SIFIVE_SERIAL
-- 
2.43.0

