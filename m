Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32BB4C5AD55
	for <u-boot@archiver.kernel.org>; Mon, 10 Aug 2026 22:36:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D1E66607B8;
	Mon, 10 Aug 2026 22:36:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id nyWvcQgTC1tI; Mon, 10 Aug 2026 22:36:20 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 293EC607AB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786401380;
	bh=tZkvPE+ybcyiJ/MsmizCrkxEtEnPPSFKrWyPQ4uF0FU=;
	h=To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=zOM4tH96KSMQC1V9ozGxM1mGi3VQwAhLczuMifmvrmHnBh+Ez1SbZ2Ht3PopgCSf2
	 Gzg/GIJypdbCuB55jXHynHBeOHaJBDIG+znSXxcDjRMEMQv8c8lNVidmxj64/aGBe3
	 JehzSJpWWw8vBtCO4C8ZqBztdSlYwYqrWprPAcZPTNC+gmWd0FXODWgGUzSvmLVOCu
	 KqNKFV0yV5C144IEthWO/7pMHkA/mJL4PU0fDLgUXAgOCHhwpGQq4hThITOjfypVC9
	 4JCzL35aS2HzErTK68cv4QRWvCJHc5gy+2oUFAploGvFtm5gI3M7SZIeruq3BU1wt3
	 i9MuSWQwHb9vQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 293EC607AB;
	Mon, 10 Aug 2026 22:36:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3D89A1AF
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 22:36:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 34583607B3
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 22:36:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vQ9EhXMmxWf7 for <u-boot@lists.u-boot-project.org>;
 Mon, 10 Aug 2026 22:36:16 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::101; helo=mout-p-101.mailbox.org;
 envelope-from=marek.vasut+renesas@mailbox.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 5038E605E8
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5038E605E8
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5038E605E8
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 22:36:16 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4hJqNY726Qz8v3M;
 Tue, 11 Aug 2026 00:36:13 +0200 (CEST)
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 4/6] remoteproc: renesas: rsip: Reset SCP core on stop
Date: Tue, 11 Aug 2026 00:35:05 +0200
Message-ID: <20260810223604.1333043-4-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260810223604.1333043-1-marek.vasut+renesas@mailbox.org>
References: <20260810223604.1333043-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 9764e459869d370c414
X-MBO-RS-META: i1ifxp6g14bt3bt63pukqhg5g5xu66rs
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1786401374;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tZkvPE+ybcyiJ/MsmizCrkxEtEnPPSFKrWyPQ4uF0FU=;
 b=b/TPEnS7TaQ0ytX1B8v0H8o0oGsJj9d0u0wyo4rbTBh7VkDlLHrEZf8uUCuCF1K2M5ARae
 jWIR63Y4vquG287qLx/pmoCZEbk8xPhb2bZQeW7wnjDHe2K22KCqN3Ad7nYrhOICzqyLsj
 5S9NuzDKZoJTVljbqMsMCKknQGgHsRp/c2x2lSd5jVIb7lietom6JN3UbWI6MnL6W0dtma
 5JUXXsB6ZwSoVNoate8q82pMnG7kBVceEV0TuXrayoz1C5K+fA6vZ8LoafQGqJjwt/5ykk
 GZz6k7faKCX+Gzu36g6WVFZ7CDf0/O7X5bcvjrewjO0fsNnVNCXJvsb1tZWUmA==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1786401372;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tZkvPE+ybcyiJ/MsmizCrkxEtEnPPSFKrWyPQ4uF0FU=;
 b=YjaYkKe8H+b+/yXet+9db1fiTxsH95m73xB1CglrMcMFDeCBJqIpI4uxE3MhLpjwwlHwX4
 dTTYqRO7r1EUvU/lOLiCqxKf2cxVAg59mJJSPOv2ZkTL3JK45yNFtJHuv/BC9DtcVpAIss
 UzbwNa9xR3WBBZBCgcR4M4ii3WBIIjnEgPbVmlBhgkz1eCgTAC70K4k354ywb++LhPLxs3
 oz8D5ZMpN07gtrnV45uhP0vmSkz+i8GYwpDsAmNpe/ZnapgGBpAf3CbJmWPoFWTPUTEc8I
 VN8pT5VNdyBwUkS/4cBxCVxjVb8clL6CfJaOUlFXw9v0OC9Oec9jjMtx7idhbw==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=mailbox.org
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=mailbox.org
 header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812
 header.b=b/TPEnS7; 
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=YjaYkKe8
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
From: Marek Vasut via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Use SCP core init code, which resets the SCP core, as a SCP core stop.
Once stop is invoked, the SCP core is reset and ready to be loaded with
new software, which is practical for SCP firwmare development.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
---
 drivers/remoteproc/renesas_rsip.c | 79 +++++++++++++++----------------
 1 file changed, 39 insertions(+), 40 deletions(-)

diff --git a/drivers/remoteproc/renesas_rsip.c b/drivers/remoteproc/renesas_rsip.c
index cbf999e88f2..96f3bf77eb8 100644
--- a/drivers/remoteproc/renesas_rsip.c
+++ b/drivers/remoteproc/renesas_rsip.c
@@ -169,6 +169,42 @@ static int renesas_rsip_rproc_load(struct udevice *dev, ulong addr, ulong size)
 	return 0;
 }
 
+/**
+ * renesas_rsip_rproc_init() - Initialize the remote processor
+ * @dev:	corresponding remote processor device
+ *
+ * Return: 0 if all went ok, else corresponding -ve error
+ */
+static int renesas_rsip_rproc_init(struct udevice *dev)
+{
+	struct renesas_rsip_rproc_privdata *priv = dev_get_priv(dev);
+	struct reset_ctl *rst = dev_get_priv(dev->parent);
+	u32 addr;
+
+	if (priv->core_id != 0)	/* No init for non-SCP cores */
+		return 0;
+
+	/*
+	 * Put SCP into reset, configure SCP entry point address and systick
+	 * timer, release SCP from reset, and zero out SCP STCM regions.
+	 */
+	reset_assert(rst);
+
+	writel(SCP_STCM, SCP_CFGVECTABLE);
+	writel(SCP_CFGNSSTCALIB_13_3MHZ, SCP_CFGNSSTCALIB);
+	setbits_le32(SCP_CPUWAIT, SCP_CPUWAIT_WAIT);
+
+	reset_deassert(rst);
+
+	/* Fill zero to SCP STCM regions 0 ... 27 */
+	for (addr = SCP_STCM; addr < 0xc1061b00; addr += 8)
+		writeq(0, addr);
+
+	asm volatile("dsb sy");
+
+	return 0;
+}
+
 /**
  * renesas_rsip_rproc_start() - Start the remote processor
  * @dev:	corresponding remote processor device
@@ -211,9 +247,9 @@ static int renesas_rsip_rproc_stop(struct udevice *dev)
 {
 	struct renesas_rsip_rproc_privdata *priv = dev_get_priv(dev);
 
-	if (priv->core_id == 0) {	/* SCP */
-		setbits_le32(SCP_CPUWAIT, SCP_CPUWAIT_WAIT);
-		return 0;
+	if (priv->core_id == 0) {
+		/* SCP */
+		return renesas_rsip_rproc_init(dev);
 	}
 
 	return 0;
@@ -244,43 +280,6 @@ static int renesas_rsip_rproc_is_running(struct udevice *dev)
 	return 1;
 }
 
-/**
- * renesas_rsip_rproc_init() - Initialize the remote processor
- * @dev:	corresponding remote processor device
- *
- * Return: 0 if all went ok, else corresponding -ve error
- */
-static int renesas_rsip_rproc_init(struct udevice *dev)
-{
-	struct renesas_rsip_rproc_privdata *priv = dev_get_priv(dev);
-	struct reset_ctl *rst = dev_get_priv(dev->parent);
-	u32 addr;
-
-	if (priv->core_id != 0)	/* No init for non-SCP cores */
-		return 0;
-
-	/*
-	 * Put SCP into reset, configure SCP entry point address and systick
-	 * timer, release SCP from reset, and zero out SCP STCM regions.
-	 */
-
-	reset_assert(rst);
-
-	writel(SCP_STCM, SCP_CFGVECTABLE);
-	writel(SCP_CFGNSSTCALIB_13_3MHZ, SCP_CFGNSSTCALIB);
-	setbits_le32(SCP_CPUWAIT, SCP_CPUWAIT_WAIT);
-
-	reset_deassert(rst);
-
-	/* Fill zero to SCP STCM regions 0 ... 27 */
-	for (addr = SCP_STCM; addr < 0xc1061b00; addr += 8)
-		writeq(0, addr);
-
-	asm volatile("dsb sy");
-
-	return 0;
-}
-
 /**
  * renesas_rsip_rproc_device_to_virt() - Convert device address to virtual address
  * @dev:	corresponding remote processor device
-- 
2.53.0

