Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2BB4CEFCFE
	for <u-boot@archiver.kernel.org>; Tue,  6 Jan 2026 20:00:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17AF383D9F;
	Tue,  6 Jan 2026 21:00:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="SmWeDBUe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BAC4983FC1; Tue,  6 Jan 2026 21:00:52 +0100 (CET)
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com
 [91.218.175.173])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D244383BC4
 for <u-boot@lists.denx.de>; Tue,  6 Jan 2026 21:00:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sean.anderson@linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1767729650;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=OQgI/c0Xrg3UacRNuoN3aFN9unudDhp4oreGdwd1axY=;
 b=SmWeDBUe6Tfh1K9m1SIVlZ/cUew98JAS4rehI7Alwnq9EpReW/HWLA9e246rGSgNrTRELs
 v7PwCPNvDz+N8vJpwcMbzL+SsKHSQ1N1kq3MJvma0Jo2gqgr0x+ZGcliCcRrxh+bKIKcsz
 nG6/SBazM1e1VcA5sE1UZPVxviAxWvc=
From: Sean Anderson <sean.anderson@linux.dev>
To: Tom Rini <trini@konsulko.com>, Adam Ford <aford173@gmail.com>,
 u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Sean Anderson <sean.anderson@linux.dev>
Subject: [PATCH] clk: versaclock: Add support for 5P49V6975
Date: Tue,  6 Jan 2026 15:00:32 -0500
Message-Id: <20260106200033.661309-1-sean.anderson@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
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

Add support for the 5P49V6975 which is an updated revision of the the
5P49V5935.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
---

 drivers/clk/clk_versaclock.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/clk/clk_versaclock.c b/drivers/clk/clk_versaclock.c
index 19a787eaf0c..f210ffa4931 100644
--- a/drivers/clk/clk_versaclock.c
+++ b/drivers/clk/clk_versaclock.c
@@ -141,6 +141,7 @@ enum vc5_model {
 	IDT_VC5_5P49V5935,
 	IDT_VC6_5P49V6901,
 	IDT_VC6_5P49V6965,
+	IDT_VC6_5P49V6975,
 };
 
 /* Structure to describe features of a particular VC5 model */
@@ -226,6 +227,13 @@ static const struct vc5_chip_info idt_5p49v6965_info = {
 	.flags = 0,
 };
 
+static const struct vc5_chip_info idt_5p49v6975_info = {
+	.model = IDT_VC6_5P49V6975,
+	.clk_fod_cnt = 4,
+	.clk_out_cnt = 5,
+	.flags = VC5_HAS_INTERNAL_XTAL,
+};
+
 static int vc5_update_bits(struct udevice *dev, unsigned int reg, unsigned int mask,
 			   unsigned int src)
 {
@@ -667,6 +675,7 @@ static int vc5_map_index_to_output(const enum vc5_model model,
 	case IDT_VC5_5P49V5935:
 	case IDT_VC6_5P49V6901:
 	case IDT_VC6_5P49V6965:
+	case IDT_VC6_5P49V6975:
 	default:
 		return n;
 	}
@@ -1023,6 +1032,7 @@ static const struct udevice_id versaclock_ids[] = {
 	{ .compatible = "idt,5p49v5935", .data = (ulong)&idt_5p49v5935_info },
 	{ .compatible = "idt,5p49v6901", .data = (ulong)&idt_5p49v6901_info },
 	{ .compatible = "idt,5p49v6965", .data = (ulong)&idt_5p49v6965_info },
+	{ .compatible = "idt,5p49v6975", .data = (ulong)&idt_5p49v6975_info },
 	{},
 };
 
-- 
2.35.1.1320.gc452695387.dirty

base-commit: 6cdd7597a2fbfc1572c1b0af23d3daf1cefa2de7
branch: versaclk_5p49v6975
