Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F981CCD1BF
	for <u-boot@archiver.kernel.org>; Tue, 28 Oct 2025 13:59:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D573B81D6A;
	Tue, 28 Oct 2025 14:59:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="iWtTzNH1";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="gM+uQCzY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C0B682A9E; Tue, 28 Oct 2025 14:59:29 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B6BD080422
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 14:59:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4cwsSF3pYCz9tTM;
 Tue, 28 Oct 2025 14:59:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761659965;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=KH8zWb3Z4SAWcRsSqH/MQbrNFCNwufvpAI3+c65+ckI=;
 b=iWtTzNH1m8cB12mDPUJnSmkk48/310Tn7TsDteeuw6LtVJFgBSbYvvTkYnbqbnMzTF7Ax+
 kUez51ShhHInregRK3Hi+A+FXG7m0edmVfuPv23fxUNWkTHoWok4nwA1V7vJKL5m/FGuU8
 A3zfu9UidsTrI1AKgJVDlgmdUKLdqGrcTZJgJc4YKW2POY1RmlyIhEN7VqiMRoENeDxYK7
 bOFBnLDOAJRi2NS8z4QTUqhWNHU8bsunbJeWRlAoHnqvmNi2w9gQQ8IgRqFu6hihrvWchd
 jZT+c5xxV6reyt6YrKHwmKJeks/OAF0+0bZQ71C1j2twraoGEW+rd0u2k/FeuQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761659963;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=KH8zWb3Z4SAWcRsSqH/MQbrNFCNwufvpAI3+c65+ckI=;
 b=gM+uQCzYcccv3JuLWwd0RV7mAxZKIkq0C0Mbvwx3AJ/uU0XgAJlzl9XKIdnJbNBOME9BRN
 H76hI/YnhjnrN3I1K815TkkeXffGt9lbsUVBHsQ1o+4YEhRToS/nbFa4tsiQkTG8Xb4Rix
 vlxV35VXMNhlPYYrbZwghI/a+3jPgdYubSZezppfqRA2HiImSlsAzzi/qsIlMLEOvKOUY+
 m/NSjyzBRs0ok0xSaZQbHxSCrDZxD1cmk3zS3mwukUMD1exGzDrune11oem30afg0zpFHP
 7LgTxD9rWt1a3dS1kXJRcYC062Z0pfvzlHy4E5cL860jSm/pnIH63f8mkmtV8A==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Alice Guo <alice.guo@nxp.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>, Valentin Caron <valentin.caron@foss.st.com>,
 Ye Li <ye.li@nxp.com>
Subject: [PATCH v2] firmware: scmi: Fix up code comments
Date: Tue, 28 Oct 2025 14:58:57 +0100
Message-ID: <20251028135919.8573-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: uua7iriwya1edgtdcqyfu7trcsw4ahue
X-MBO-RS-ID: 4b1bf5f9ec6e6c8ffa5
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

Fix multiple instances of copy-paste errors. Fill in missing
headers for CLOCK_GET_PERMISSIONS message and response.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Alice Guo <alice.guo@nxp.com>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: Valentin Caron <valentin.caron@foss.st.com>
Cc: Ye Li <ye.li@nxp.com>
Cc: u-boot@lists.denx.de
---
V2: Fix scmi_base_protocol_attrs, scmi_base_protocol_message_attrs,
    struct scmi_clk_attribute_out, struct scmi_clk_attribute_out_v2,
    struct scmi_pinctrl_config_set_in
---
 include/scmi_protocols.h | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/include/scmi_protocols.h b/include/scmi_protocols.h
index bb74a57f79a..bcd8e671149 100644
--- a/include/scmi_protocols.h
+++ b/include/scmi_protocols.h
@@ -399,7 +399,7 @@ int scmi_generic_protocol_version(struct udevice *dev,
 int scmi_base_protocol_version(struct udevice *dev, u32 *version);
 
 /**
- * scmi_protocol_attrs - get protocol attributes
+ * scmi_base_protocol_attrs - get protocol attributes
  * @dev:		SCMI protocol device
  * @num_agents:		Number of SCMI agents
  * @num_protocols:	Number of SCMI protocols
@@ -414,7 +414,7 @@ int scmi_base_protocol_attrs(struct udevice *dev, u32 *num_agents,
 			     u32 *num_protocols);
 
 /**
- * scmi_protocol_message_attrs - get message-specific attributes
+ * scmi_base_protocol_message_attrs - get message-specific attributes
  * @dev:		SCMI protocol device
  * @message_id:		SCMI message ID
  * @attributes:		Message-specific attributes
@@ -754,7 +754,7 @@ enum scmi_clock_message_id {
 #define SCMI_CLOCK_NAME_LENGTH_MAX 16
 
 /**
- * struct scmi_clk_get_nb_out - Response for SCMI_PROTOCOL_ATTRIBUTES command
+ * struct scmi_clk_protocol_attr_out - Response for SCMI_PROTOCOL_ATTRIBUTES command
  * @status:	SCMI command status
  * @attributes:	Attributes of the clock protocol, mainly number of clocks exposed
  */
@@ -772,7 +772,7 @@ struct scmi_clk_attribute_in {
 };
 
 /**
- * struct scmi_clk_get_nb_out - Response payload for SCMI_CLOCK_ATTRIBUTES command
+ * struct scmi_clk_attribute_out - Response payload for SCMI_CLOCK_ATTRIBUTES command
  * @status:	SCMI command status
  * @attributes:	clock attributes
  * @clock_name:	name of the clock
@@ -785,7 +785,7 @@ struct scmi_clk_attribute_out {
 };
 
 /**
- * struct scmi_clk_get_nb_out_v2 - Response payload for SCMI_CLOCK_ATTRIBUTES command
+ * struct scmi_clk_attribute_out_v2 - Response payload for SCMI_CLOCK_ATTRIBUTES command
  * Clock management Protocol 2.0
  * @status:	SCMI command status
  * @attributes:	clock attributes
@@ -818,7 +818,7 @@ struct scmi_clk_state_out {
 };
 
 /**
- * struct scmi_clk_state_in - Message payload for CLOCK_RATE_GET command
+ * struct scmi_clk_rate_get_in - Message payload for CLOCK_RATE_GET command
  * @clock_id:	SCMI clock ID
  * @attributes:	Attributes of the targets clock state
  */
@@ -839,7 +839,7 @@ struct scmi_clk_rate_get_out {
 };
 
 /**
- * struct scmi_clk_state_in - Message payload for CLOCK_RATE_SET command
+ * struct scmi_clk_rate_set_in - Message payload for CLOCK_RATE_SET command
  * @flags:	Flags for the clock rate set request
  * @clock_id:	SCMI clock ID
  * @rate_lsb:	32bit LSB of the clock rate in Hertz
@@ -861,7 +861,7 @@ struct scmi_clk_rate_set_out {
 };
 
 /**
- * struct scmi_clk_parent_state_in - Message payload for CLOCK_PARENT_SET command
+ * struct scmi_clk_parent_set_in - Message payload for CLOCK_PARENT_SET command
  * @clock_id:		SCMI clock ID
  * @parent_clk:		SCMI clock ID
  */
@@ -879,6 +879,7 @@ struct scmi_clk_parent_set_out {
 };
 
 /**
+ * struct scmi_clk_get_permissions_in - Message payload for CLOCK_GET_PERMISSIONS command
  * @clock_id:	Identifier for the clock device.
  */
 struct scmi_clk_get_permissions_in {
@@ -886,6 +887,7 @@ struct scmi_clk_get_permissions_in {
 };
 
 /**
+ * struct scmi_clk_get_permissions_out - Response payload for CLOCK_GET_PERMISSIONS command
  * @status:	Negative 32-bit integers are used to return error status codes.
  * @permissions:	Bit[31] Clock state control, Bit[30] Clock parent control,
  * Bit[29] Clock rate control, Bits[28:0] Reserved, must be zero.
@@ -1082,7 +1084,7 @@ struct scmi_pin_config {
 };
 
 /**
- * struct scmi_pad_config_set_in - Message payload for PAD_CONFIG_SET command
+ * struct scmi_pinctrl_config_set_in - Message payload for PAD_CONFIG_SET command
  * @identifier:		Identifier for the pin or group.
  * @function_id:	Identifier for the function selected to be enabled
  * 			for the selected pin or group. This field is set to
-- 
2.51.0

