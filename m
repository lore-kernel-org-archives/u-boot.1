Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DB05C98317
	for <u-boot@archiver.kernel.org>; Thu, 24 Sep 2026 12:36:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C496381D16;
	Thu, 24 Sep 2026 12:36:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZKg4_KJuBlbL; Thu, 24 Sep 2026 12:36:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org B0DF481D4D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790253392;
	b=pEw46OxKIYJinowdLwJ14wDGqmSMEvRZXJR9kYemjBQg2gTPyHBrDy87gFsN1f+G9mSC
	 FO4zTW4IdgA19iMJt4PkFFzGiAtXfC7yBIJTYJAN9Yg7yA7XcLAlP+sufXnVpmygHMml/
	 mnxttNN2yoAJ8wEx1tLspqujaJzG9hc0qjyLf+PMRgDvwtmDBgUVByXq3TlDNa6jV22ai
	 Mis74q8Rt+e1EOQrmhhrw1LMh5yEoqlnGGJ6piNZ8FSyYKr5GR75pG9/v1kibLv5AhUFs
	 2yc0hYnFgY16l/TsB0wGN09A8ucgC7LEJoWc25HT8aIsoFAxS+rkezd/+Bp153wQWNA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790253392;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ZHCWy/HFJLiy2RkfTEtb5Hz1TR34CJuCK1HOANWec5E=;
	b=E+YFDGBr8T0RcuZxlPE0NuK+jLuvjS7MyNPvlhxFu8nU7B2WPdmVedUY4exWiPhfi9g4
	 nPZZ7kOPYGf4SaoHI7FOlEfqbpPpWm9r0rokb95TYK2+c+jXYzyXSbO4jZBRQo+PUlWEq
	 IbDtOhlJcqiUvi1No33p2IJIzV9OVB8GNHdZdQhOjw+q3kPHvlFQyQvftgjkIMVbJeKkI
	 lCagOyCzK2TQpATIpGF9Aceo46659WpPJJzEGJkAXPkRjdif9xN4ANc3U1hQsetUVS+2N
	 ++Ej2MQzrg0noAwmgIWeRHTJgjUXyWi7iQ9ZxRV03N8UUVWgQmwPR7hbECDSujJBE7A==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790253392;
	bh=ZHCWy/HFJLiy2RkfTEtb5Hz1TR34CJuCK1HOANWec5E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SRDUTT/XVMNKPKuVEisZYy+H14qJ8cp6rG97Mn+wJLQbmKC7JAtrmnzlN1/iIvnN0
	 2VHCqUcDuC/So3qeUZPvK5/Rlp/gBCJ/427nJA9Tyo2g0DairaagTyXOSzKRZH77zp
	 39oQ5lOCAH2sjc7dfA7926Kj4RXDp4tiIAc6BZhvUsvdvTGlzolhSrkFsm9g+HJZTp
	 3Y5CxzC0RyIRWVVvOB3zX3HZoqcJcAGwF9BWSVSnXgjLz75gFGRMTKxb9ZkR4MUDcX
	 1uPKg5LYOYUmDfQTXPbmNPSCV75DM8/qCBlkBG3KhWGlG5GEbsYmrXzBVr/7qhpDuk
	 h5vHQY0fm2UPQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B0DF481D4D;
	Thu, 24 Sep 2026 12:36:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2619C392
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 12:36:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0B05840D04
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 12:36:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id anSsIGKxKU5A for <u-boot@lists.u-boot-project.org>;
 Thu, 24 Sep 2026 12:36:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 49F4340853
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790253389;
 b=amR88BjFiNDGTwRz9/q0DUuJ2duiKkJMYn0QnHfuoUFCf/ttOr5LVTnciJZ8guNIznof
 SqiwvK3eol13UfbjrDtmEJR7cHCJWZ6YLerE0qjoVjTHE/oTvv5GYoOyLksKCZQ/oNvUd
 C6OHrImao8f/VGlKjgEpLAHp0MU2GXhivTw5nDmRY962gUZXef8rJfvzpjY5qYVVFGjuX
 7NMoDALRBgAwjSah3WhxkIMznCNqdjIwPFZjRtwljUKRU4ye/i+XMDSYbImeDmi04sosp
 5C+9KWlSOsubF1QaAFDJUhMldFREmhseKykSJrUvO11QYMwg4PglRIBbRK4ppg9dAJQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790253389;
 h=Received-SPF:Received:Received:Received:DKIM-Signature:From:To:Cc:
 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
 bh=ZHCWy/HFJLiy2RkfTEtb5Hz1TR34CJuCK1HOANWec5E=;
 b=tOJULP7rTuJneJmQYSZiPE+qvUJlAd43rgDyXEID1CeDN0Xpff4u9atw2+Mlw40pVt4J
 5tOtAvrj0ZFS6GDVEKyI9EB11EGt9ZFdevNH1NSg897vPRNQFpMVaYW3Z2cPew5eEEfzK
 0v6zqAabqintIBY2BaZaXHOrcGw5OsZZDQJx8GeYzO7H+wl8swiYJTt8HQykL47WydqH9
 Bo1JScFSbwiFL77enGLDeBqWP+HDW8vwvfCYVs3tQ54YeQH8Gc+9rWeKUtNZ+rPfEFCTn
 Dcz2/2XouRsj+CRaGijhYrr+N8pIaYaP1KpHSohnufOD4w8e0lH+WjeXVGUBtEdXwNg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=bootlin.com; 
 dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=bJ3ed5Fk; 
 arc=none smtp.remote-ip=185.246.85.4
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.246.85.4;
 helo=smtpout-03.galae.net; envelope-from=richard.genoud@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com
 header.a=rsa-sha256 header.s=dkim header.b=bJ3ed5Fk
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 49F4340853
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 12:36:28 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 4173D4E4105A;
 Thu, 24 Sep 2026 12:36:27 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 15CE860341;
 Thu, 24 Sep 2026 12:36:27 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id E0F39103293C5; 
 Thu, 24 Sep 2026 14:36:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1790253385; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=ZHCWy/HFJLiy2RkfTEtb5Hz1TR34CJuCK1HOANWec5E=;
 b=bJ3ed5FkogH6CLKwoE/jCmIFJ34wEdngoL1VFm2XJYJDDG59lDFLXsN7PdKZ4pjzHqIGVh
 pTXgwc9zsHSza3hA+i32xCI6kVOhJPK8d3gagVIWPMhXQFvd5BKJDZIV5yfF7IgyVWEiuC
 ikNnJobF9nZO7T9sIIpWMx8d2N9pM96ee/bDrDa4KD8DPAslMuXsEk8DHhLUXUObaKrxl2
 NccB35vPwbEclmRa1LXd59aq2X9BIAFsNRT17w13mh7pL7ZfOSsw7QChYt5bs+5jYqPVGn
 e6cycjXtZSgSPlXA/m+2pkwaVfkPn7ktAVV7uzIYFc9Q1WxoCWDsOT/7tijF+w==
From: "Richard Genoud (TI)" <richard.genoud@bootlin.com>
To: Tom Rini <trini@konsulko.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 "Andrew F . Davis" <afd@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Bryan Brattlof <bb@ti.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: Markus Schneider-Pargmann <msp@baylibre.com>,
 Kendall Willis <k-willis@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Abhash Kumar <a-kumar2@ti.com>,
 Thomas Richard <thomas.richard@bootlin.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v6 07/22] mach-k3: r5: common: introduce k3_deassert_ddr_ret()
Date: Thu, 24 Sep 2026 14:35:18 +0200
Message-ID: <20260924123533.2599438-8-richard.genoud@bootlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924123533.2599438-1-richard.genoud@bootlin.com>
References: <20260924123533.2599438-1-richard.genoud@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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
Errors-To: u-boot-bounces@lists.u-boot-project.org

Deasserting DDR retention pin is quite similar from J7200, J784s4
and j721s2 SoCs.

Instead of duplicating almost the same code, add it in lpm-common.c.

NB: On J7200, there's a latch, so the clock needs to be toggled.

Reviewed-by: Udit Kumar <u-kumar1@ti.com>
Signed-off-by: Richard Genoud (TI) <richard.genoud@bootlin.com>
---
 arch/arm/mach-k3/lpm-common.h    |  2 ++
 arch/arm/mach-k3/r5/lpm-common.c | 27 +++++++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/arch/arm/mach-k3/lpm-common.h b/arch/arm/mach-k3/lpm-common.h
index 27a27065442c..17352b06353f 100644
--- a/arch/arm/mach-k3/lpm-common.h
+++ b/arch/arm/mach-k3/lpm-common.h
@@ -15,6 +15,8 @@
 void __noreturn do_resume(void);
 void lpm_process(void);
 int save_lpm_region_idx(unsigned int image_id, unsigned long image_start);
+void k3_deassert_ddr_ret(const char *pmic_name, unsigned int ddr_ret_val,
+			 unsigned int ddr_ret_clk, bool toggle);
 void k3_set_lpm_core_bus_node_path(const char *node_path);
 void k3_set_lpm_core_compatible(const char *compatible);
 #else
diff --git a/arch/arm/mach-k3/r5/lpm-common.c b/arch/arm/mach-k3/r5/lpm-common.c
index 5d484f6df037..f1d16f38157f 100644
--- a/arch/arm/mach-k3/r5/lpm-common.c
+++ b/arch/arm/mach-k3/r5/lpm-common.c
@@ -46,6 +46,33 @@ enum k3_resume_state {
 	K3_RESUME_STATE_RESUMING
 };
 
+#define GPIO_OUT_1 0x3D
+void k3_deassert_ddr_ret(const char *pmic_name, unsigned int ddr_ret_val,
+			 unsigned int ddr_ret_clk, bool toggle)
+{
+	struct udevice *pmic;
+	int regval;
+	int err;
+
+	err = uclass_get_device_by_name(UCLASS_PMIC, pmic_name, &pmic);
+	if (err) {
+		printf("Getting %s init failed: %d\n", pmic_name, err);
+		return;
+	}
+
+	/* Set DDR_RET Signal Low on PMIC */
+	regval = pmic_reg_read(pmic, GPIO_OUT_1) & ~ddr_ret_val;
+	pmic_reg_write(pmic, GPIO_OUT_1, regval);
+
+	if (toggle) {
+		/* Now toggle the CLK of the latch for DDR retention */
+		pmic_reg_write(pmic, GPIO_OUT_1, regval | ddr_ret_clk);
+		pmic_reg_write(pmic, GPIO_OUT_1, regval & ~ddr_ret_clk);
+		pmic_reg_write(pmic, GPIO_OUT_1, regval | ddr_ret_clk);
+		pmic_reg_write(pmic, GPIO_OUT_1, regval & ~ddr_ret_clk);
+	}
+}
+
 bool j7xx_board_is_resuming(void)
 {
 	static enum k3_resume_state k3_resuming;
-- 
2.55.0

