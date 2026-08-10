Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48B54C5AD55
	for <u-boot@archiver.kernel.org>; Mon, 10 Aug 2026 22:36:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6562D4070C;
	Mon, 10 Aug 2026 22:36:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2T0lqM_TrDAb; Mon, 10 Aug 2026 22:36:21 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7603440706
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786401381;
	bh=MG4Bip8r99lTr+VxgSwGOEG3yBVO2pxLn0pSWlr10ag=;
	h=To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=aiXEOUi74mfnfnRY/urdLoBbP5GrDzxidBYYVpyZeFGtB+AJOnsYhz6Jq0jsDlsDz
	 5Y5jlu14IO/pqJEueeC9RHebLI1f6G/9/ZVf27Yb//F8rsauYrGXjAvE4kPwfH2kKj
	 2R4+bF5TJa9WQ07JEC6o32jUYE5UJXoD7oi9K42Xr96qFc4USBgs2OfhNDSaVU1Bv2
	 z4ZhLBxV7ClnagNB3u37t8PF/rPMf4Nf/5wZkSY2TrjeX4eAvsgR2yrKds0Eqv6s8y
	 jXCNN9nNVF2gHb4U1NOTuiMJP/zeuq1ZRsp2YOI+0KS6HXCP83SOIFXu0vNTRcZCrh
	 McbWNFvvqdI1g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7603440706;
	Mon, 10 Aug 2026 22:36:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 1CD7723F
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 22:36:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 007A2406E2
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 22:36:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lyrixNptFs8D for <u-boot@lists.u-boot-project.org>;
 Mon, 10 Aug 2026 22:36:17 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.172;
 helo=mout-p-202.mailbox.org; envelope-from=marek.vasut+renesas@mailbox.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 24B4A406DB
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 24B4A406DB
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 24B4A406DB
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 22:36:16 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4hJqNZ6zb2zMlMF;
 Tue, 11 Aug 2026 00:36:14 +0200 (CEST)
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 5/6] remoteproc: renesas: rsip: Implement SCMI core stop
Date: Tue, 11 Aug 2026 00:35:06 +0200
Message-ID: <20260810223604.1333043-5-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260810223604.1333043-1-marek.vasut+renesas@mailbox.org>
References: <20260810223604.1333043-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 3c40d928f8f663a4fbb
X-MBO-RS-META: n7fuec6c7xai349qb7po1z9h3hhprc4y
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1786401375;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MG4Bip8r99lTr+VxgSwGOEG3yBVO2pxLn0pSWlr10ag=;
 b=Xh7KSnh9h61/FPK6VLfHMaFX2Z521gdL6g0017by+ugyfeEvTUwKZZms3nDlB9uI6CQW30
 aPOEN77IqaIkzhDMr6pKX7uTn9Cbkfb7Bn7SBD1fc3fOqQ5kIEmjCIGc/zyC1eKAiDEuDP
 vOLd954fGLYrBIdpY00C/XgaPK6BVVck3Qva4K7pZNdgCuWNJ/Q05LZRzwMzuNINvkFxqB
 CHyI9vKJbAx9Ci+uVjPbd4MKI8DMlLZ0nGUnokumIVy6gcaVQMIcLBMFYv/3rpo5i42bGP
 L/TAbz1sKHAMJgSG2OShbfYYZZw2Vo0voNCuyzD7/haBElnMxA+D8YhHpgF9dQ==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1786401373;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MG4Bip8r99lTr+VxgSwGOEG3yBVO2pxLn0pSWlr10ag=;
 b=kQXs+TflLBmx1qHOfrNAMB9qXw8V10J4oPljyL8JPx+I4YmVpX9rVTg9ErrkcfU9Rd1ZW5
 iBZG4lSrbqyLIXDqYCuosoeU4k4OpaRqvj111A1mWqui1mSwo3HpRbP9/sdKXhzX9QHVcM
 wJaUmutzhs9gU0wqBrnXqllaWVo0oNohGDap1n9eI7ug8ecEzI6fOSwANLvvEFWs1FZ7vy
 Vdvag6KZm9kWnweD8eAxb1XhfMdEu34S1AlYbPeRUU9uNqiyRo404RfFBYcvKkwd9PuzUz
 Cb/0LoBgKcmXsZoOHCaqauYolYdD8ce/7uuDYZG/DZ0c2WRUd0qsoyxsYdNgKw==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=mailbox.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=Xh7KSnh9; 
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=kQXs+Tfl
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

Currently the driver could only start cores. Add support for stopping
CR52 and CA720AE cores via SCMI. Note that the SCP core is controlled
via direct register IO.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
---
 drivers/remoteproc/renesas_rsip.c | 67 +++++++++++++++++++++----------
 1 file changed, 46 insertions(+), 21 deletions(-)

diff --git a/drivers/remoteproc/renesas_rsip.c b/drivers/remoteproc/renesas_rsip.c
index 96f3bf77eb8..7c2643e9728 100644
--- a/drivers/remoteproc/renesas_rsip.c
+++ b/drivers/remoteproc/renesas_rsip.c
@@ -100,22 +100,53 @@ static void scp_send_interrupt(void)
  * This must be removed when proper upstream SCP port exists
  */
 #define SCMI_PD_POWER_STATE_SET_BOOTADDR	0x4411
+#define SCMI_PD_POWER_STATE_SET_STATE_ON	0
+#define SCMI_PD_POWER_STATE_SET_STATE_OFF	BIT(30)
 
 /**
- * scp_cpu_core_start() - Boot CPU core by invoking SCP via SCMI
+ * scp_cpu_core_id_to_domain() - Convert core ID to SCMI domain ID
+ * @core: CPU core
+ * @domain: SCMI domain
+ */
+static int scp_cpu_core_id_to_domain(const u32 core, u32 *domain)
+{
+	if (core >= RCAR5_SCP_CORES && core < RCAR5_SCP_CORES + RCAR5_CR52_CORES) {
+		/* CR52 */
+		*domain = core - RCAR5_SCP_CORES + SCMI_PD_CORE_RT_CORE00;
+		return 0;
+	}
+
+	if (core >= RCAR5_SCP_CORES + RCAR5_CR52_CORES &&
+	    core < RCAR5_SCP_CORES + RCAR5_CR52_CORES + RCAR5_CA720_CORES) {
+		/* CA720 */
+		*domain = core - RCAR5_SCP_CORES - RCAR5_CR52_CORES + SCMI_PD_CORE_AP_CORE00;
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+/**
+ * scp_cpu_core_set() - Start or stop CPU core by invoking SCP via SCMI
  * @core: CPU core to boot
  * @ep: Entry point
+ * @state: Power state, 0: Power on, BIT(30): Power off
  */
-static void scp_cpu_core_start(const u32 core, const u32 ep)
+static int scp_cpu_core_set(const u32 core, const u32 ep, const u32 state)
 {
 	struct scp_scmi_shmem *shmem = (struct scp_scmi_shmem *)SCP_SCMI_SHMEM_AREA09;
 	struct scp_scmi_pd_power_state_set_a2p scmi_parameter = {
 		.flags = 1,	/* Asynchronous power transition using APMU */
-		.domain_id = core,
-		.power_state = 0,	/* Power on */
+		.domain_id = 0,		/* Core ID */
+		.power_state = state,	/* 0: Power on, BIT(30): Power off */
 		.boot_addr = ep,
 	};
 	u32 status;
+	int ret;
+
+	ret = scp_cpu_core_id_to_domain(core, &scmi_parameter.domain_id);
+	if (ret)
+		return ret;
 
 	/* Wait for SCP to be free, then set it busy */
 	scp_wait_fw_free();
@@ -136,7 +167,10 @@ static void scp_cpu_core_start(const u32 core, const u32 ep)
 	if (status) {
 		printf("SCP POWER_STATE_SET domain %d failed, status=0x%x (%d)\n",
 		       scmi_parameter.domain_id, status, status);
+		return -EINVAL;
 	}
+
+	return 0;
 }
 
 /**
@@ -214,27 +248,16 @@ static int renesas_rsip_rproc_init(struct udevice *dev)
 static int renesas_rsip_rproc_start(struct udevice *dev)
 {
 	struct renesas_rsip_rproc_privdata *priv = dev_get_priv(dev);
-	int scmi_core;
 
 	if (priv->core_id == 0) {
 		/* SCP */
 		clrbits_le32(SCP_CPUWAIT, SCP_CPUWAIT_WAIT);
 		return 0;
-	} else if (priv->core_id >= RCAR5_SCP_CORES &&
-		   priv->core_id < RCAR5_SCP_CORES + RCAR5_CR52_CORES) {
-		/* CR52 */
-		scmi_core = priv->core_id - RCAR5_SCP_CORES +
-			    SCMI_PD_CORE_RT_CORE00;
-	} else if (priv->core_id >= RCAR5_SCP_CORES + RCAR5_CR52_CORES &&
-		   priv->core_id < RCAR5_SCP_CORES + RCAR5_CR52_CORES + RCAR5_CA720_CORES) {
-		/* CA720 */
-		scmi_core = priv->core_id - RCAR5_SCP_CORES - RCAR5_CR52_CORES +
-			    SCMI_PD_CORE_AP_CORE00;
+	} else {
+		/* CR52 or CA720 */
+		return scp_cpu_core_set(priv->core_id, priv->ep,
+					SCMI_PD_POWER_STATE_SET_STATE_ON);
 	}
-
-	scp_cpu_core_start(scmi_core, priv->ep);
-
-	return 0;
 }
 
 /**
@@ -250,9 +273,11 @@ static int renesas_rsip_rproc_stop(struct udevice *dev)
 	if (priv->core_id == 0) {
 		/* SCP */
 		return renesas_rsip_rproc_init(dev);
+	} else {
+		/* CR52 or CA720 */
+		return scp_cpu_core_set(priv->core_id, 0,
+					SCMI_PD_POWER_STATE_SET_STATE_OFF);
 	}
-
-	return 0;
 }
 
 /**
-- 
2.53.0

