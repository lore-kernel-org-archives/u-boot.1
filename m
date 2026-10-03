Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5F9ACA5FE8
	for <u-boot@archiver.kernel.org>; Sat,  3 Oct 2026 12:48:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8EC9541207;
	Sat,  3 Oct 2026 12:48:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JvRfnqnXjXgh; Sat,  3 Oct 2026 12:48:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 994DC41360
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791031681;
	b=gU5bJeJj2XLzPSz4vmgFFaYJdPBItCfdA7Q+BdO46DWD8etPsU396AFg8ReS9HZbfRjI
	 N08MbaJN0TlAhZ5Jw9X4XmnM3IpO2wziPDQii+n8G64774XQRFiX5KyWSGWxCanybFH97
	 C/Zb4PwcerT5uQu5o9YTfmKj7QvwKihOxMdwl280xw0IkBRRzrvalXxr1tOO3lsRAAedF
	 RIm/CHC0lMO7wfm1eaQXVkD6Xs9jg0aWvLLIw13TpVgOLozx8FmCRB9EhOhJAm58D0v0q
	 /LkG09r1esNPTHU3XjwlL14xGW9YVRF49ksBl4hOLou6/xFHDG8blu4/ydewzaBs8uQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791031681;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=S4vj8L0x29K8X1wSqZnJxby4KqEm8bZbjF9PCkIZ4Bs=;
	b=KlEGBb1Qxn54G2gMbRNEXHtaMh3XrFGp76X6yd4gwbKvdFjo7m0PPEjECJd9DVWDpFLN
	 RRp4NrWd8hB2od3d1VZ1QB8C3J9ENTPolz51O2LwLp7KWLm4yp7e8TFs4ICyTIn1la5WW
	 8JY4LCVrNZo/vaqTQOG9Oujjh3xhUiPH/L3a7Ghzr68V/V8RGyTxXGFh/CThs7ULPRrFy
	 k9tKG419fHknPTajYg91NAh6P4J5YTHVbd+BUS5pgnETimmG7hVAgt1Ti2O0qb325h6gv
	 FlN9XDCAvH8xOC6XikL2nrbbSB8mTsf4ij4vpFdm3uwjkf/GX1XzGMvl6coUOUCRhBA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791031681;
	bh=S4vj8L0x29K8X1wSqZnJxby4KqEm8bZbjF9PCkIZ4Bs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=ee854AWiXvZEHIS8/W2ovDM0WudBfz7RGFhBDYysRwCPkT0lcPx+Y9U2pNRLeDHHR
	 rPpMc0NCZMWTelh7le0LvPPfYv90khEloxj1lBhYi6hgEn40l9Eq9ps3ZO8QoES+Ue
	 K7Jc1CUGMswsXQW0+78RtAPeZddztp5W80rmqx2scKdU7nX2g8cOwyBzYCsTIdvOvd
	 fiMkiKKhmBP+bagA4YTYSVJQPkeJgWCoiJWpFsRmLU+Xb6laInRrv6Ds+0fEnhQ2/l
	 oNcNX+ej2kEYI08oaqh2hSz+WZC9M34gC762P4Hc5H5ecXutDmyfleTBy/DzteHoU2
	 G/tILfkIxnpcQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 994DC41360;
	Sat,  3 Oct 2026 12:48:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 4639632F
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 04:37:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3871B400E6
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 04:37:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id h1smLekZNPDr for <u-boot@lists.u-boot-project.org>;
 Sat,  3 Oct 2026 04:37:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 5AB2A40059
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791002221;
 b=H1Cmdd+z6pnTv7H7M0XbUPu2smTA7hzjQnhP+mcB7Nwd6Lrw331rmbEsrm/hDLDBHfSV
 8mBosc2ZaQwYP7tfVwRV3KGyZtKLXKHj/5/fcPQfWGfu+0bJjMSkCrZQ8N6B42yo+8FYI
 6RmyLkE2z7pI1oXIdcodOe1MvuHu2rnS0GFLLSnV5V4pRqgx3ZDPTuQeDACZYsxvPIheb
 TSuAfHUCUNE5fG+OzijzL0w8SHjwiXiug+d8uIMVUscqsZ7Oav7iOVLrhbMyomXD+asff
 twG3cFOWRK0+DIFJFBwwFD2u66MhWzx97LGZd5JmxaG1RZsimfUwF5fwC9zjXfgBatQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791002221;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=S4vj8L0x29K8X1wSqZnJxby4KqEm8bZbjF9PCkIZ4Bs=;
 b=iWjtOmEXYImBEyh8TcnDURBPmCUTU6gtXaPE+P6lCCgzQ2Vg2OjaaTM9UW3aGDigelvA
 FZOc2k9sniZqrBD0+Wpm1VwCO/0O6soTaG7UGFnIl/Mv2WlK2G1zPaUoBKpOQycjA2wP/
 u/3ZX6PBdzeWdTMeHc5TwotkzlEgLAr0CJ9C3jBqyxNWvxngT5MjWlAVhPZxhEyR4DDUu
 Fro5sALCXB+mlvB70D38F3YsswpqMVIcy1ikLaRV8sF3HtCpDxMpoufg47F3g9I/P65zV
 aiAn6MxZogY2y/QlG1KGF/dK+3J1wh7BUbzYDE09x3JH/8lM/gufktejgDTQldMIFFw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=i7D9gFBp; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=devnull+iav.iav.lv@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=i7D9gFBp
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5AB2A40059
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 04:37:00 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 3230060AAF;
 Sat,  3 Oct 2026 04:36:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DBFD3C2BCF4;
 Sat,  3 Oct 2026 04:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1791002218;
 bh=UyftThb9xe/BVji6EWK1UzUIwI8dLn3DpHjXV2CG8as=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=i7D9gFBplURhXMS7LSr6v2YdrgIOVWBJrTomeGOc4sTL7ZJhkI91b4/OEIhur8juq
 BUl1bc4CmRInDF4+t/zP38idHJTKER8STaG3tmtoSnRRHrhdXojY9ze7n/xzEBCBdk
 aXVmQud7rMJTx9boIdHa9H/whYc1/8rb6CT/S3at3e9x5wJAy7iD5Xu8yWy38k+eq5
 WZxxyX+STZ2ZvMLGr8mzYzwg9F2WlyXptaZ2zycmiaYYqS5YtDYMxg6lDEHL7l2AOr
 GY85PVPlXwjx7W7t+gHW2/PiSb27qsd1qW8xF/2Ab8G8YFq5AmHOjWSjIHSnvwtiyl
 7eB6z4hsTnkNA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id CB57ECA5FE4;
 Sat,  3 Oct 2026 04:36:58 +0000 (UTC)
From: Igor Velkov via B4 Relay <devnull+iav.iav.lv@kernel.org>
Date: Sat, 03 Oct 2026 07:36:56 +0300
Subject: [PATCH 2/2] arm: mvebu: set up the AHCI controller that is being
 probed
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261003-ahci-mvebu-windows-v1-2-e382f73fc299@iav.lv>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2256; i=iav@iav.lv;
 h=from:subject:message-id;
 bh=IXNqB2FfOr+AfTwgdsEd6OhEY0WR9pooeokYKG7kKAk=;
 b=owGbwMvMwCVmNH1q96v4SmbG02pJDFkH2jL3eqde1vl3OcG6QeNk3Q7pYzI6kid3PPdRvv/XM
 qpugejbjlIWBjEuBlkxRZYJhzRuZSy5+tffw/wBzBxWJpAhDFycAnCT/RgZpsqU/7C2drl70+N/
 xYznm/KCp0xQiVvK9LuNbdkEW16ztYwMH3avzfq/8+pjBnc79fUhcob3f+Z9eldY8qgtV/vP5Mp
 eFgA=
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

board_ahci_enable() sets the DRAM windows and the regret bit only at
MVEBU_SATA0_BASE, the first controller (sata@a8000), but the generic AHCI
driver calls it before probing each controller. On Armada 388 the second
controller, sata@e0000, is left without these windows, so its DMA does not
reach DRAM: the link comes up, the first command never completes and
scsi scan hangs.

Use the address of the controller being probed. MVEBU_SATA0_BASE has no
other user, drop it.

Tested on Helios4, whose disk is on the second controller: without this
change scsi scan hangs; with it the disk is found, and blocks read in
U-Boot have the same CRC32 as when read from Linux.

Signed-off-by: Igor Velkov <iav@iav.lv>
---
 arch/arm/mach-mvebu/cpu.c              | 7 +++++--
 arch/arm/mach-mvebu/include/mach/soc.h | 1 -
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-mvebu/cpu.c b/arch/arm/mach-mvebu/cpu.c
index 09a0292699c..c13b9d70bfd 100644
--- a/arch/arm/mach-mvebu/cpu.c
+++ b/arch/arm/mach-mvebu/cpu.c
@@ -6,6 +6,7 @@
 #include <config.h>
 #include <ahci.h>
 #include <cpu_func.h>
+#include <dm.h>
 #include <init.h>
 #include <linux/bitops.h>
 #include <linux/delay.h>
@@ -609,8 +610,10 @@ static void ahci_mvebu_regret_option(void __iomem *base)
 
 int board_ahci_enable(struct udevice *dev)
 {
-	ahci_mvebu_mbus_config((void __iomem *)MVEBU_SATA0_BASE);
-	ahci_mvebu_regret_option((void __iomem *)MVEBU_SATA0_BASE);
+	void __iomem *base = dev_remap_addr(dev);
+
+	ahci_mvebu_mbus_config(base);
+	ahci_mvebu_regret_option(base);
 
 	return 0;
 }
diff --git a/arch/arm/mach-mvebu/include/mach/soc.h b/arch/arm/mach-mvebu/include/mach/soc.h
index 33fdfd6d6c1..3ae5cffb669 100644
--- a/arch/arm/mach-mvebu/include/mach/soc.h
+++ b/arch/arm/mach-mvebu/include/mach/soc.h
@@ -77,7 +77,6 @@
 #define MVEBU_USB20_BASE	(MVEBU_REGISTER(0x58000))
 #define MVEBU_REG_PCIE0_BASE	(MVEBU_REGISTER(0x80000))
 #define MVEBU_AXP_SATA_BASE	(MVEBU_REGISTER(0xa0000))
-#define MVEBU_SATA0_BASE	(MVEBU_REGISTER(0xa8000))
 #define MVEBU_NAND_BASE		(MVEBU_REGISTER(0xd0000))
 #define MVEBU_SDIO_BASE		(MVEBU_REGISTER(0xd8000))
 #define MVEBU_LCD_BASE		(MVEBU_REGISTER(0xe0000))

-- 
2.43.0


