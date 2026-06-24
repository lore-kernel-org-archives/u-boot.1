Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB44CCDB47F
	for <u-boot@archiver.kernel.org>; Wed, 24 Jun 2026 07:46:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84D34849CB;
	Wed, 24 Jun 2026 09:45:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="aRGYBlrw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1981B84A0F; Wed, 24 Jun 2026 09:45:43 +0200 (CEST)
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2163984A0E
 for <u-boot@lists.denx.de>; Wed, 24 Jun 2026 09:45:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=richard.genoud@bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id D801C1A0912;
 Wed, 24 Jun 2026 07:45:40 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id AA575601C5;
 Wed, 24 Jun 2026 07:45:40 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id A5325106C85A3; 
 Wed, 24 Jun 2026 09:45:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1782287139; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=Eq3i3oe+TN8UoXtxfCH0f+zmANu2CmFoXP+FjKol+nU=;
 b=aRGYBlrw7rViy4q1dX4ZCR0mdXdRpculV1mGsiqKWmw/IJPmitqS0JcPyPFNUP+DXTA5kC
 02nheGIa4lRQdsbFWxd8GUs2ld0Mi6LSkG2zEodzitnmhl6wQmCg0LbThGfbfRqOUHsjpz
 YAsLZLlEMz4vWccDNSaIgAx5qGBoVTz0gefnB40hipiGr7jw0/JWDx+T7j9F9mCWK395nb
 LQy1kvLlK4RuWTRjsyQmoUF36XF9MgHPX+VKtkbGc96hneT2Wbj0Df7nVTW9FvTcWwslCN
 SxsS9HjQyJ9kubGooCa+vhZTGCynjVKiq51TSKT84g7XG7N9coLUmkNGleehqg==
From: "Richard Genoud (TI)" <richard.genoud@bootlin.com>
To: Tom Rini <trini@konsulko.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 Apurva Nandan <a-nandan@ti.com>, "Andrew F . Davis" <afd@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>,
 Vaishnav Achath <vaishnav.a@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>,
 Simon Glass <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: Markus Schneider-Pargmann <msp@baylibre.com>,
 Kendall Willis <k-willis@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Abhash Kumar <a-kumar2@ti.com>,
 Thomas Richard <thomas.richard@bootlin.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Richard Genoud <richard.genoud@bootlin.com>, u-boot@lists.denx.de
Subject: [PATCH v3 12/19] ram: k3-ddrss: support j784s4/j721e/j721s2 DDR resume
Date: Wed, 24 Jun 2026 09:44:52 +0200
Message-ID: <20260624074459.873906-13-richard.genoud@bootlin.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260624074459.873906-1-richard.genoud@bootlin.com>
References: <20260624074459.873906-1-richard.genoud@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

j78s4/j721e/j7200/J721s2 can't use the standard resume sequence.
Typical DDR resume sequence is:
- exit DDR from retention
- de-assert the DDR_RET pin
- restore DDR max frequency
- exit DDR from low power

We have to separate each action in order to de-assert the DDR_RET pins
at the right time, because the DDR_RET pins are all tied together in
hardware.

At resume, only the initialization of the DDR is done by the driver, the
rest is handled in boart_init_f().
So, introduce lpm_init_only flag to only initialize the DDR when resume
is detected for those boards.

Signed-off-by: Richard Genoud (TI) <richard.genoud@bootlin.com>
---
 drivers/ram/k3-ddrss/k3-ddrss.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/ram/k3-ddrss/k3-ddrss.c b/drivers/ram/k3-ddrss/k3-ddrss.c
index 42992412a071..69bbac4e2b92 100644
--- a/drivers/ram/k3-ddrss/k3-ddrss.c
+++ b/drivers/ram/k3-ddrss/k3-ddrss.c
@@ -123,6 +123,7 @@ enum intrlv_size {
 
 struct k3_ddrss_data {
 	u32 flags;
+	bool lpm_init_only;
 	bool (*is_lpm_resume)(void);
 	void (*ddrss_deassert_retention)(void);
 };
@@ -1158,6 +1159,9 @@ static int k3_ddrss_probe(struct udevice *dev)
 	k3_lpddr4_init(ddrss);
 	k3_lpddr4_hardware_reg_init(ddrss);
 
+	if (is_lpm_resume && ddrss_data->lpm_init_only)
+		return k3_ddrss_init_freq(ddrss);
+
 	if (is_lpm_resume)
 		k3_ddrss_self_refresh_exit(ddrss->ddrss_ctl_cfg);
 
@@ -1290,6 +1294,8 @@ static struct ram_ops k3_ddrss_ops = {
 
 static const struct k3_ddrss_data k3_data = {
 	.flags = SINGLE_DDR_SUBSYSTEM,
+	.lpm_init_only = true,
+	.is_lpm_resume = j7xx_board_is_resuming,
 };
 
 static const struct k3_ddrss_data am62xx_data = {
@@ -1300,6 +1306,8 @@ static const struct k3_ddrss_data am62xx_data = {
 
 static const struct k3_ddrss_data j721s2_data = {
 	.flags = MULTI_DDR_SUBSYSTEM,
+	.lpm_init_only = true,
+	.is_lpm_resume = j7xx_board_is_resuming,
 };
 
 static const struct k3_ddrss_data j722s_data = {
