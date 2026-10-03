Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86507CA5FDD
	for <u-boot@archiver.kernel.org>; Sat,  3 Oct 2026 12:48:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9E2664133E;
	Sat,  3 Oct 2026 12:47:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id poqlySRtakhl; Sat,  3 Oct 2026 12:47:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 54B4B412D8
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791031677;
	b=AhER6opkS+Z7G5LZg7bqhgMoE7hu0KrzCNyAO7eHEz5R8hYyFobTJ8b8p7fgPcw5QClK
	 BJ/7URJTwGSYOb605/fo4vqKrZgUywLjsX2NHtivwuxFjj7DY3rTgIOgdu5/v9gowmH11
	 usSpTvVF5/9UoNLAOjS6YZIEm6nCdJDeSR5MMGDbwgaxvuG85Pvgplt2EG5U1raW8fycq
	 u66kU3Sw9LZKUrQ1VtFbj+MX/EycPrK0yYflD6jqg6IkfFvyiByoFbdRce6diA3Af2J7H
	 9yh1AjlfiY56lRQTeuUcsu1XT60TNcw+qpKwGnCYwM8sxpbEF1tXYGzgsOGSgAC1NgA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791031677;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=7mXQeX7ev6q+gyTPPtep9V2ad3SKCJRDrW22JB25TeI=;
	b=LBI2j9+zbhxifs5INxp7JDvvmx0B3rPBoVomzzacThkVW8rD7d3YL8UX2qTQ3T68xwxI
	 KB66qaCjpcZXLpEwOQl4RfZJIc5UvNXjTjKrMPJhkeSPrQQXbTSmOk0osttRYdJn10eit
	 Xm5gNzsZ2ydo9UwNJJgm5D92rWcdFgvDmbKPfuOMA3Uc4uAmP55VGgQTfsECJ+6Ky5F5r
	 SKjwZ2ATYMopodih8zAykJA296oa2XjwD+8FPYSV2FQXVxMPpjPXT/49FBahtgtJfvN/m
	 cTLfL6G2NbJ9bSm9jhsbXAZ5eR/qHq4rsV1wQta5PKVSLI0jLrx6DllN0aEG1yu5SdQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=oii+Hw4q;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791031677;
	bh=7mXQeX7ev6q+gyTPPtep9V2ad3SKCJRDrW22JB25TeI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=cV0f98tAPilgrbu03I8/w1PScd4ypYd1QA7lZtAecDPKJvZpjch2R0Zv3bWYO7Gy4
	 Pcwy4gxXMRb/0gUOT8TYR4ctTb0rn1uviEpzWCLjTriKUcAG/yJAJlH/jzuNRhvu4r
	 bD+hXjq0lbT7MVIQuqkO2iP3t5aaYCRwbgZ0V6Xa0yj/NAAdLVzjoX5gICvPgjUfTu
	 Xgor9Cs2hOZCbFNARVONBF5B0XR4hoQgDY/QbBOh8hMO4LR8bJgdY3Tn5leKhLAepb
	 6ukUDXkUGtD+Xzr5sZK3vUYh4zfNFMtvrpvll3xOXY9fC8P2I7QaA3+4D/FEnL1wkQ
	 Ussb87SWo+d8w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 54B4B412D8;
	Sat,  3 Oct 2026 12:47:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id B853D34E
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 04:37:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AABCF40BBB
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 04:37:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WrNr4alxB31b for <u-boot@lists.u-boot-project.org>;
 Sat,  3 Oct 2026 04:37:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org E960E40D77
Authentication-Results: smtp4.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791002220;
 b=eFsp8yzkVCSjJede3eEZ4++F0vnKwtPuX4ViBGULM2INwsn+NzLj/t5Aa6J0EC9Nea5F
 a1Et3ZuRLLfWv4kmOW2HwP0qSxSQidIOZVYQzaP2I4l2WVrlt5zgoMEYSwQVZKEpjgiov
 J1lniMUt7c8id8JYZQoX32wzotFqIke8m46uROYqSNXfbW77x7+Kh/tUejWDCwvpqBXnp
 /LNMZlJoc4fQn4eKusdkT6JC12XDzW7tZ2Y8hN4czXPQqRwcGCcPMDk1dAQmNyWgqSRpu
 q9uQASjjIPm67fONpigRpD9/4VrbGy2u597wtZDJkRKHBl+XOcm9mxwWj5mql2VPMXg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791002220;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=7mXQeX7ev6q+gyTPPtep9V2ad3SKCJRDrW22JB25TeI=;
 b=dH0Sah/1OicegyL2nD3J9ktAe7bSFYrSTI9Rnlj9iWKYKL+gdYTuBQamwBfKiJmGTNo6
 7BvAaJDrxw0oLJCmLXBtj3+Z6Ld1Jlxsbd01L/Mkk/lm8XUNMvCrNOkcTeyOB8KGHnnB/
 WL0Jo7WV6QvPPiZDP71JKJeVA3hwSs+p10rRX4kQKKdaD3e7brKHCo5dWYN5atK6OrR1e
 Tf18f3jKAF8/741TcdxWAlkt/seTP9MHoqZk0vMALrkhfSES7blc7TfY2wgWMEbTdJYaa
 9UCDE0klBDrOu6UD/LZLp5BjmpLo0uJlqIsIuzV/ji8A8v0RP1BGyi0rdaeK4B7h9rg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=oii+Hw4q; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=devnull+iav.iav.lv@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=oii+Hw4q
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E960E40D77
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 04:36:59 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id E855E4391E;
 Sat,  3 Oct 2026 04:36:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CB78DC4AF13;
 Sat,  3 Oct 2026 04:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1791002218;
 bh=XrBVBknf1S7AQ+yaMYCSx92dwxie7hxZiyVggSGJvqw=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=oii+Hw4q7gCOWNn2SO54K13zCUVEBU+VdGOefKera0OBuExlpyIgJ3bOYJWGwMeVk
 CZT71nipZCdmz0M6z8UqLRY6MxTIRDVBsoVYjFBTKwijxA1cpoIBVZHlGhcRwM/8c6
 4eqnxJTg+aI1lztORYwuMOy4howK7cLCvjfc/KBJIJWoiGMJEctbzBJoFzbxoVXa+/
 Tt1V/3P5gzVzy1zlcNbXToFPHhkAJTPB0wwfIOuvEiT/Df5Wuh5mtnbSPVyKdEVkcR
 f3kQZqMLc5UT1ZXL+Se8bVrKwhxK9e+2amai4Yri7FtptL2vOBV5Ff7p2kFES0r3q1
 myXKpf169IuUw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id BCA18CA5FC1;
 Sat,  3 Oct 2026 04:36:58 +0000 (UTC)
From: Igor Velkov via B4 Relay <devnull+iav.iav.lv@kernel.org>
Date: Sat, 03 Oct 2026 07:36:55 +0300
Subject: [PATCH 1/2] ata: ahci_generic: pass the AHCI device to
 board_ahci_enable()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261003-ahci-mvebu-windows-v1-1-e382f73fc299@iav.lv>
References: <20261003-ahci-mvebu-windows-v1-0-e382f73fc299@iav.lv>
In-Reply-To: <20261003-ahci-mvebu-windows-v1-0-e382f73fc299@iav.lv>
To: Stefan Roese <stefan.roese@mailbox.org>, Tom Rini <trini@konsulko.com>, 
 Aaron Williams <awilliams@marvell.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Chris Packham <judge.packham@gmail.com>, 
 Robert Marko <robert.marko@sartura.hr>, Baruch Siach <baruch@tkos.co.il>, 
 u-boot@lists.u-boot-project.org, Igor Velkov <iav@iav.lv>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3663; i=iav@iav.lv;
 h=from:subject:message-id;
 bh=7+gIMq43dS+isEi/l16AqsbIu+D/GsrJCavd9JkOvFg=;
 b=owGbwMvMwCVmNH1q96v4SmbG02pJDFkH2jI+/J/y6c+Bwwsv7fF44uU0WVP0EPPqCC8jFs2tz
 VcvbVtY3VHKwiDGxSArpsgy4ZDGrYwlV//6e5g/gJnDygQyhIGLUwAm8sqRkeHN0U6+mYZv1k4z
 DT1w/BC33qKpns9/Rk2dNlei9O/ZR4URjAw/+gXCtLTv3Vh+a2FlwpPl6qvNg3R55k9+n6p1+PF
 Or2p2AA==
X-Developer-Key: i=iav@iav.lv; a=openpgp;
 fpr=90C228DA68A4D5FD4F4837E03297958BEA5F7903
X-Endpoint-Received: by B4 Relay for iav@iav.lv/default with auth_id=1060
X-Original-From: Igor Velkov <iav@iav.lv>
X-Mailman-Approved-At: Sat, 03 Oct 2026 12:47:49 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Reply-To: iav@iav.lv
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Igor Velkov <iav@iav.lv>

The generic AHCI driver calls board_ahci_enable() before it probes each
controller, but does not tell it which one. Board code that sets up a
controller can only use a fixed address, as the Armada 38x code does
with the address of its first controller.

Pass the device being probed and declare the function in ahci.h. The
existing implementations do not use the argument yet.

Signed-off-by: Igor Velkov <iav@iav.lv>
---
 arch/arm/mach-mvebu/cpu.c               |  2 +-
 arch/mips/mach-octeon/cpu.c             |  3 ++-
 board/Marvell/mvebu_armada-37xx/board.c |  3 ++-
 drivers/ata/ahci_generic.c              |  4 ++--
 include/ahci.h                          | 10 ++++++++++
 5 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-mvebu/cpu.c b/arch/arm/mach-mvebu/cpu.c
index a1eb6927c3e..09a0292699c 100644
--- a/arch/arm/mach-mvebu/cpu.c
+++ b/arch/arm/mach-mvebu/cpu.c
@@ -607,7 +607,7 @@ static void ahci_mvebu_regret_option(void __iomem *base)
 	writel(0x80, base + AHCI_VENDOR_SPECIFIC_0_DATA);
 }
 
-int board_ahci_enable(void)
+int board_ahci_enable(struct udevice *dev)
 {
 	ahci_mvebu_mbus_config((void __iomem *)MVEBU_SATA0_BASE);
 	ahci_mvebu_regret_option((void __iomem *)MVEBU_SATA0_BASE);
diff --git a/arch/mips/mach-octeon/cpu.c b/arch/mips/mach-octeon/cpu.c
index c771da61a68..049b5f05337 100644
--- a/arch/mips/mach-octeon/cpu.c
+++ b/arch/mips/mach-octeon/cpu.c
@@ -3,6 +3,7 @@
  * Copyright (C) 2020-2022 Marvell International Ltd.
  */
 
+#include <ahci.h>
 #include <dm.h>
 #include <dm/uclass.h>
 #include <env.h>
@@ -457,7 +458,7 @@ int arch_misc_init(void)
 	return 0;
 }
 
-int board_ahci_enable(void)
+int board_ahci_enable(struct udevice *dev)
 {
 	cvmx_sata_uctl_shim_cfg_t shim_cfg;
 
diff --git a/board/Marvell/mvebu_armada-37xx/board.c b/board/Marvell/mvebu_armada-37xx/board.c
index c30fca6cffd..126f5d78262 100644
--- a/board/Marvell/mvebu_armada-37xx/board.c
+++ b/board/Marvell/mvebu_armada-37xx/board.c
@@ -4,6 +4,7 @@
  */
 
 #include <config.h>
+#include <ahci.h>
 #include <dm.h>
 #include <dm/device-internal.h>
 #include <env.h>
@@ -190,7 +191,7 @@ int board_late_init(void)
 #endif
 
 /* Board specific AHCI / SATA enable code */
-int board_ahci_enable(void)
+int board_ahci_enable(struct udevice *ahci_dev)
 {
 	struct udevice *dev;
 	int ret;
diff --git a/drivers/ata/ahci_generic.c b/drivers/ata/ahci_generic.c
index 6e5a6cbafd8..8a21d70c68a 100644
--- a/drivers/ata/ahci_generic.c
+++ b/drivers/ata/ahci_generic.c
@@ -11,7 +11,7 @@
  * Dummy implementation that can be overwritten by a board
  * specific function
  */
-__weak int board_ahci_enable(void)
+__weak int board_ahci_enable(struct udevice *dev)
 {
 	return 0;
 }
@@ -36,7 +36,7 @@ static int generic_ahci_probe(struct udevice *dev)
 	 * Board specific SATA / AHCI enable code, e.g. enable the
 	 * AHCI power or deassert reset
 	 */
-	board_ahci_enable();
+	board_ahci_enable(dev);
 
 	ahci_probe_scsi(dev, (ulong)dev_remap_addr(dev));
 
diff --git a/include/ahci.h b/include/ahci.h
index 470cda006de..76f4e3ef5c8 100644
--- a/include/ahci.h
+++ b/include/ahci.h
@@ -278,4 +278,14 @@ int ahci_probe_scsi(struct udevice *ahci_dev, ulong base);
  */
 int ahci_probe_scsi_pci(struct udevice *ahci_dev);
 
+/**
+ * board_ahci_enable() - board specific setup of an AHCI controller
+ *
+ * Called by the generic AHCI driver before it probes each controller.
+ *
+ * @ahci_dev: AHCI controller being probed
+ * Return: 0 if OK, -ve on error
+ */
+int board_ahci_enable(struct udevice *ahci_dev);
+
 #endif

-- 
2.43.0


