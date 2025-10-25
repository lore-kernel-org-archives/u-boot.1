Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 981C0CCD1BF
	for <u-boot@archiver.kernel.org>; Sat, 25 Oct 2025 23:50:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9211182A9E;
	Sun, 26 Oct 2025 01:50:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="uaCJmbxJ";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="UZtfzVWq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 21F8982C7F; Sun, 26 Oct 2025 01:50:40 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53322807C0
 for <u-boot@lists.denx.de>; Sun, 26 Oct 2025 01:50:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4cvGjn0hBhz9spF;
 Sun, 26 Oct 2025 01:50:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761436237;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=KSyGNyLzGYJCMVzdaHrAml/+C7N4z2TaFlMY6Pf1XJ0=;
 b=uaCJmbxJENGUbMA11kjD4b7iUYEr+a9YXg51FeeaGu1wuJWQl6tXY6z4cnIndECa6+0inf
 R/6WpXceK5nCTebGxnDjW/xRX1uKprVOcMgsHzjNHtVcUJu+0Jcu7vTS2jPR+4menvQKZV
 EwUDN9odfi5c/mpnYjdwQ2868eGhcCGeK5ePNMTq8i9s8RnJ3Enhho/P9wHKkilTqHs8wn
 rh/Z+Z8YEOmWPKLO/mSGUD1pvQWYKthavezL+czM7mOM9h9WE7eiri9sYBMW3q5reDQnKn
 OBt69/G2RNKDjHnkoP40dv6gvF+hCTbZxLveW0c9M+vTWvwMRlXTESGK34Z6ow==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761436235;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=KSyGNyLzGYJCMVzdaHrAml/+C7N4z2TaFlMY6Pf1XJ0=;
 b=UZtfzVWq8uxtO8ykzPUZs5Fe01oRRzUkO8Db0JdI2od7i+fYYjbs6M5p/3X1lOgpxuLlKt
 LSm3IR3h3hsieMcqtFM9dVvPa4kVFJ8j7v3Ioyxqbr35HkU2yNaigB3v6Af/7f3Okasu8x
 ZIO2D4hRUbzHBXeauJySlkxu4D82LE9g8fcuUx2RpT3hZFNkWK5JTaAopfJTG7VBW7pPPE
 WS6K1wISsZrrLAEHzCUx9ijM7mr9gwbQ+5p95x6Mjh3qbBvc0J4aj1wh2NNATbGrP3Ljbu
 w6n8DmWfV1AIwToim26dEVnnmqP/BuIFU2x3eHBwoF3dxTacwt+BtIM64VTkBQ==
To: u-boot@lists.denx.de
Cc: Vinh Nguyen <vinh.nguyen.xz@renesas.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Alice Guo <alice.guo@nxp.com>, Cristian Marussi <cristian.marussi@arm.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Peng Fan <peng.fan@nxp.com>, Sean Anderson <seanga2@gmail.com>,
 Tom Rini <trini@konsulko.com>, Valentin Caron <valentin.caron@foss.st.com>,
 Ye Li <ye.li@nxp.com>
Subject: [PATCH] firmware: scmi: Add clock v3.2 CONFIG_SET support
Date: Sun, 26 Oct 2025 01:50:15 +0200
Message-ID: <20251025235022.300844-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: mqtqw494jdb7xbpoejn44chcszut9dew
X-MBO-RS-ID: 531e205a62441b6ebc3
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
 drivers/clk/clk_scmi.c   | 22 +++++++++++++++++-----
 include/scmi_protocols.h | 17 +++++++++++++++--
 2 files changed, 32 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/clk_scmi.c b/drivers/clk/clk_scmi.c
index a7d89f32cd7..f9e17c38cad 100644
--- a/drivers/clk/clk_scmi.c
+++ b/drivers/clk/clk_scmi.c
@@ -134,17 +134,29 @@ static int scmi_clk_get_attibute(struct udevice *dev, int clkid, char **name,
 
 static int scmi_clk_gate(struct clk *clk, int enable)
 {
-	struct scmi_clk_state_in in = {
+	struct scmi_clock_priv *priv = dev_get_priv(clk->dev->parent);
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
+
 	int ret;
 
-	ret = devm_scmi_process_msg(clk->dev, &msg);
+	ret = devm_scmi_process_msg(clk->dev,
+				    (priv->version < CLOCK_PROTOCOL_VERSION_2_1) ?
+				    &msg_v1 : &msg_v2);
 	if (ret)
 		return ret;
 
diff --git a/include/scmi_protocols.h b/include/scmi_protocols.h
index 81979e81b6b..d89612541ef 100644
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

