Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97E84CCF9F8
	for <u-boot@archiver.kernel.org>; Mon,  3 Nov 2025 22:56:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0812282A9E;
	Mon,  3 Nov 2025 23:56:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="S0x1Vdhr";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="fzu5A5KH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23C24838CE; Mon,  3 Nov 2025 23:56:40 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F29908144A
 for <u-boot@lists.denx.de>; Mon,  3 Nov 2025 23:56:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4d0n5J4s17z9sps;
 Mon,  3 Nov 2025 23:56:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1762210596;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=6Z4P/Bt0Q9C14XbpVRb2SQxaQrJ3N+BPQcAEsv4MojQ=;
 b=S0x1VdhrhThEdvpb+Phtf2xwsU6nE26PswouU9fqLd3mWeDaGy7Yg9nyaKpsuoyxwGUTOb
 G7dmfhSpmc375/hzfNKF4Ibn2dDNYZwp1YhYG2Aws7ky6Cf6zr9ZRgRKO9u5ykoSNlbX+t
 5IbiIWNYsOhIhHacojx4B+FRFp2UkKtQ7GRC4pHEAcUotktPw26+snXcHq1j1jJQuMo6/P
 XulhxAJgsHruluhetCAmq1xuqpILesKgYUWmD1PGQ1d3FublT2Indh/9Lini7xd/1+GvTh
 SnD9i7V7A8eAh0sf75vnnE4wAHXptQd6oxvaMJK7usyjYLgiPYsVvM2AqgJaqg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1762210594;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=6Z4P/Bt0Q9C14XbpVRb2SQxaQrJ3N+BPQcAEsv4MojQ=;
 b=fzu5A5KHweSQO9y2m+hrriu65+PQe3Yhmcswj00CvBq7rmXEosBxOyXUPhFhR4kEC5W/ih
 nFaIJSiEupOVd77SiA/Q4CO7ykNUhWzbbdGyyPqeDTe3/EU3AMP0aHcKWPwJ8AgaezxG9G
 xH07HPMDY236l0kBdDDAI5lq0yqpn5xM1PXtPC/jcQQ5l2de7+t7NoVrVcpmZxZXj/hVqJ
 /4nK1mOeOHawz1lu515pRbcWora1aWc0DCFjERI83s+WOdHgG15EfULcVP2Kl3WA2vbVh8
 hrVpG7pu1zd/wYAVFwe3ZaUTFAol76QjOIV8X4vlp8ZthGzBw2tvxwDvNOI2Fw==
To: u-boot@lists.denx.de
Cc: Vinh Nguyen <vinh.nguyen.xz@renesas.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Alice Guo <alice.guo@nxp.com>, Cristian Marussi <cristian.marussi@arm.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Peng Fan <peng.fan@nxp.com>, Sean Anderson <seanga2@gmail.com>,
 Tom Rini <trini@konsulko.com>, Valentin Caron <valentin.caron@foss.st.com>,
 Ye Li <ye.li@nxp.com>
Subject: [PATCH v3] firmware: scmi: Add clock v3.2 CONFIG_SET support
Date: Mon,  3 Nov 2025 23:56:03 +0100
Message-ID: <20251103225625.195926-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: a2c80c7c30065a9fcd4
X-MBO-RS-META: ns9f9iw33izywgbmr3yoqpyyp6ws1ob5
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

From: Vinh Nguyen <vinh.nguyen.xz@renesas.com>

SCMI v3.2 introduces a new clock CONFIG_SET message format that can
optionally carry also OEM specific configuration values beside the usual
clock enable/disable requests. Add support to use such new format when
talking to a v3.2 compliant SCMI platform.

Support existing enable/disable operations across different clock protocol
versions: this patch still does not add protocol operations to support the
new OEM specific optional configuration capabilities.

No functional change for the SCMI drivers users of the related enable and
disable clock operations.

Signed-off-by: Vinh Nguyen <vinh.nguyen.xz@renesas.com>
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
[Marek: Remodel after Linux e49e314a2cf7 ("firmware: arm_scmi: Add clock v3.2 CONFIG_SET support")
        Support both old < 2.1 and new >= 2.1 protocol versions.
	Update commit message based on Linux one]
---
Cc: Alice Guo <alice.guo@nxp.com>
Cc: Cristian Marussi <cristian.marussi@arm.com>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Sean Anderson <seanga2@gmail.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Valentin Caron <valentin.caron@foss.st.com>
Cc: Vinh Nguyen <vinh.nguyen.xz@renesas.com>
Cc: Ye Li <ye.li@nxp.com>
Cc: u-boot@lists.denx.de
---
V2: Fix up iMX95 and sandbox after rework
V3: Cache pointer to top-level SCMI clock device in each struct clk_scmi
    and use it to extract struct scmi_clock_priv private data which
    contain protocol version. This is necessary, because clk_scmi .dev
    may not necessarily point to direct subdevice of the top level SCMI
    clock device.
---
 arch/arm/mach-imx/imx9/scmi/clock_scmi.c   |  2 +-
 drivers/clk/clk_scmi.c                     | 35 ++++++++++++++++++----
 drivers/firmware/scmi/sandbox-scmi_agent.c |  4 +--
 include/scmi_protocols.h                   | 17 +++++++++--
 4 files changed, 48 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-imx/imx9/scmi/clock_scmi.c b/arch/arm/mach-imx/imx9/scmi/clock_scmi.c
index fa15b5f8df9..fc1d5d77799 100644
--- a/arch/arm/mach-imx/imx9/scmi/clock_scmi.c
+++ b/arch/arm/mach-imx/imx9/scmi/clock_scmi.c
@@ -10,7 +10,7 @@
 
 int imx_clk_scmi_enable(u32 clock_id, bool enable)
 {
-	struct scmi_clk_state_in in = {
+	struct scmi_clk_state_in_v1 in = {
 		.clock_id = clock_id,
 		.attributes = (enable) ? 1 : 0,
 	};
diff --git a/drivers/clk/clk_scmi.c b/drivers/clk/clk_scmi.c
index a7d89f32cd7..cdbf7e6df52 100644
--- a/drivers/clk/clk_scmi.c
+++ b/drivers/clk/clk_scmi.c
@@ -16,6 +16,7 @@
 
 struct clk_scmi {
 	struct clk clk;
+	struct udevice *sdev;	/* SCMI top-level clock device */
 	u32 ctrl_flags;
 };
 
@@ -134,17 +135,40 @@ static int scmi_clk_get_attibute(struct udevice *dev, int clkid, char **name,
 
 static int scmi_clk_gate(struct clk *clk, int enable)
 {
-	struct scmi_clk_state_in in = {
+	struct scmi_clk_state_in_v1 in_v1 = {
+		.clock_id = clk_get_id(clk),
+		.attributes = enable,
+	};
+	/* Valid only from SCMI clock v2.1 */
+	struct scmi_clk_state_in_v2 in_v2 = {
 		.clock_id = clk_get_id(clk),
 		.attributes = enable,
 	};
 	struct scmi_clk_state_out out;
-	struct scmi_msg msg = SCMI_MSG_IN(SCMI_PROTOCOL_ID_CLOCK,
-					  SCMI_CLOCK_CONFIG_SET,
-					  in, out);
+	struct scmi_msg msg_v1 = SCMI_MSG_IN(SCMI_PROTOCOL_ID_CLOCK,
+					     SCMI_CLOCK_CONFIG_SET,
+					     in_v1, out);
+	struct scmi_msg msg_v2 = SCMI_MSG_IN(SCMI_PROTOCOL_ID_CLOCK,
+					     SCMI_CLOCK_CONFIG_SET,
+					     in_v2, out);
+	struct scmi_clock_priv *priv;
+	struct clk_scmi *clkscmi;
+	struct clk *c;
 	int ret;
 
-	ret = devm_scmi_process_msg(clk->dev, &msg);
+	ret = clk_get_by_id(clk->id, &c);
+	if (ret)
+		return ret;
+
+	clkscmi = container_of(c, struct clk_scmi, clk);
+
+	priv = dev_get_priv(clkscmi->sdev);
+	if (!priv)
+		return -EINVAL;
+
+	ret = devm_scmi_process_msg(clk->dev,
+				    (priv->version < CLOCK_PROTOCOL_VERSION_2_1) ?
+				    &msg_v1 : &msg_v2);
 	if (ret)
 		return ret;
 
@@ -319,6 +343,7 @@ static int scmi_clk_probe(struct udevice *dev)
 			}
 
 			dev_clk_dm(dev, i, &clk_scmi->clk);
+			clk_scmi->sdev = dev;
 
 			if (CLK_HAS_RESTRICTIONS(attributes)) {
 				u32 perm;
diff --git a/drivers/firmware/scmi/sandbox-scmi_agent.c b/drivers/firmware/scmi/sandbox-scmi_agent.c
index 74a87832dcb..5b242a039c2 100644
--- a/drivers/firmware/scmi/sandbox-scmi_agent.c
+++ b/drivers/firmware/scmi/sandbox-scmi_agent.c
@@ -828,7 +828,7 @@ static int sandbox_scmi_clock_rate_get(struct udevice *dev,
 
 static int sandbox_scmi_clock_gate(struct udevice *dev, struct scmi_msg *msg)
 {
-	struct scmi_clk_state_in *in = NULL;
+	struct scmi_clk_state_in_v1 *in = NULL;
 	struct scmi_clk_state_out *out = NULL;
 	struct sandbox_scmi_clk *clk_state = NULL;
 
@@ -836,7 +836,7 @@ static int sandbox_scmi_clock_gate(struct udevice *dev, struct scmi_msg *msg)
 	    !msg->out_msg || msg->out_msg_sz < sizeof(*out))
 		return -EINVAL;
 
-	in = (struct scmi_clk_state_in *)msg->in_msg;
+	in = (struct scmi_clk_state_in_v1 *)msg->in_msg;
 	out = (struct scmi_clk_state_out *)msg->out_msg;
 
 	clk_state = get_scmi_clk_state(in->clock_id);
diff --git a/include/scmi_protocols.h b/include/scmi_protocols.h
index bcd8e671149..ecab021b472 100644
--- a/include/scmi_protocols.h
+++ b/include/scmi_protocols.h
@@ -733,6 +733,7 @@ int scmi_pwd_name_get(struct udevice *dev, u32 domain_id, u8 **name);
 /*
  * SCMI Clock Protocol
  */
+#define CLOCK_PROTOCOL_VERSION_2_1	0x20001
 #define CLOCK_PROTOCOL_VERSION_3_0	0x30000
 
 enum scmi_clock_message_id {
@@ -800,15 +801,27 @@ struct scmi_clk_attribute_out_v2 {
 };
 
 /**
- * struct scmi_clk_state_in - Message payload for CLOCK_CONFIG_SET command
+ * struct scmi_clk_state_in_v1 - Message payload for CLOCK_CONFIG_SET command for protocol < 2.1
  * @clock_id:	SCMI clock ID
  * @attributes:	Attributes of the targets clock state
  */
-struct scmi_clk_state_in {
+struct scmi_clk_state_in_v1 {
 	u32 clock_id;
 	u32 attributes;
 };
 
+/**
+ * struct scmi_clk_state_in_v2 - Message payload for CLOCK_CONFIG_SET command for protocol >= 2.1
+ * @clock_id:	SCMI clock ID
+ * @attributes:	Attributes of the targets clock state
+ * @extended_config_val: Extended and OEM specific configuration
+ */
+struct scmi_clk_state_in_v2 {
+	u32 clock_id;
+	u32 attributes;
+	u32 extended_config_val;
+};
+
 /**
  * struct scmi_clk_state_out - Response payload for CLOCK_CONFIG_SET command
  * @status:	SCMI command status
-- 
2.51.0

