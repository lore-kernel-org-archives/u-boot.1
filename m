Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99F0DCCD1BF
	for <u-boot@archiver.kernel.org>; Sat, 25 Oct 2025 22:35:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8328282C7F;
	Sun, 26 Oct 2025 00:35:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="ZH88Hb9S";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="stweSOCA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 947FE82E34; Sun, 26 Oct 2025 00:35:13 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9215C807C0
 for <u-boot@lists.denx.de>; Sun, 26 Oct 2025 00:35:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org
 [IPv6:2001:67c:2050:b231:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4cvF2l17SGz9t4g;
 Sun, 26 Oct 2025 00:35:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761431711;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=uSlSRRJEhx+yVoZ23/CSd3XNloFcMAMjd+6TVGBlDhg=;
 b=ZH88Hb9SQBsh9qEm0Qx+ezXtGFtAie8BxHBWEs+7BTgBGv8Sd3+cDQpK588OJV0EvZmDVy
 s4DbIGx3NbsVuMLx49Q12y8EgwV/4u/2fTbIHvU9c0ejkDcLylp0S/OPvTg3s5IsNqMzbO
 sz1bNe3qbjgsKPxqWMcuYRzOktX5nlowoSXmJ9MuWqH37E83vosuXpcxenPVPt0jVm1arm
 MbEiTO1fMmRwfZd3Nn8mKJNShuKTPzSpMWHXux6CoyIaGoD0r9OxHfELv/42+0r26+WbSH
 8caKbXrbRSj2udYB9hweLN8Xh8GEf5Yk8pRPjDXkqI2E3Kppg+0ZP8uh94fwBA==
Authentication-Results: outgoing_mbo_mout;
 dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=stweSOCA;
 spf=pass (outgoing_mbo_mout: domain of marek.vasut+renesas@mailbox.org
 designates 2001:67c:2050:b231:465::102 as permitted sender)
 smtp.mailfrom=marek.vasut+renesas@mailbox.org
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1761431709;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=uSlSRRJEhx+yVoZ23/CSd3XNloFcMAMjd+6TVGBlDhg=;
 b=stweSOCAqUJDOqSV7Yp9R+Kyb4miQBQ/U1fTSiYK9n4MU+rRrnhAgvKOZNxbEeP86gEiD1
 As2FShgkSUykzF2WK252B3XzQ0DoCNeRG3AF3lq9JjRhiYArubmX+hncuWROfnVHq2Rd6g
 7TlKZFzhpVRc+r4VfONR4OmKs2dj2FKoNxnStXrJnhHswe+xyMrxrMUaV7SzwsDJZUREW+
 JEmKNVJPW0Epoc+8zfzko72B6DAUxbB+iuSVErYsu7Ts6FaJt4bOn74CwqrhMn868uEmnG
 pzxP3uJsBFzTW/7KIWATDfFuawTE58RKr6cEuiMo6oWL53VZYRdsgWw44gfZYQ==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Alice Guo <alice.guo@nxp.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>, Valentin Caron <valentin.caron@foss.st.com>,
 Ye Li <ye.li@nxp.com>
Subject: [PATCH] firmware: scmi: Fix up code comments
Date: Sun, 26 Oct 2025 00:34:32 +0200
Message-ID: <20251025223456.253958-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: 8xdtyopb5okkmsib8i17rp11rpmqkw7b
X-MBO-RS-ID: fe0ba63a28744c39759
X-Rspamd-Queue-Id: 4cvF2l17SGz9t4g
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
 include/scmi_protocols.h | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/scmi_protocols.h b/include/scmi_protocols.h
index ce767117570..c889f62424b 100644
--- a/include/scmi_protocols.h
+++ b/include/scmi_protocols.h
@@ -751,13 +751,13 @@ enum scmi_clock_message_id {
 #define SCMI_CLK_RATE_ROUND_UP		BIT(2)
 #define SCMI_CLK_RATE_ROUND_CLOSEST	BIT(3)
 
 #define SCMI_CLOCK_NAME_LENGTH_MAX 16
 
 /**
- * struct scmi_clk_get_nb_out - Response for SCMI_PROTOCOL_ATTRIBUTES command
+ * struct scmi_clk_protocol_attr_out - Response for SCMI_PROTOCOL_ATTRIBUTES command
  * @status:	SCMI command status
  * @attributes:	Attributes of the clock protocol, mainly number of clocks exposed
  */
 struct scmi_clk_protocol_attr_out {
 	s32 status;
 	u32 attributes;
@@ -817,13 +817,13 @@ struct scmi_clk_state_in {
  */
 struct scmi_clk_state_out {
 	s32 status;
 };
 
 /**
- * struct scmi_clk_state_in - Message payload for CLOCK_RATE_GET command
+ * struct scmi_clk_rate_get_in - Message payload for CLOCK_RATE_GET command
  * @clock_id:	SCMI clock ID
  * @attributes:	Attributes of the targets clock state
  */
 struct scmi_clk_rate_get_in {
 	u32 clock_id;
 };
@@ -838,13 +838,13 @@ struct scmi_clk_rate_get_out {
 	s32 status;
 	u32 rate_lsb;
 	u32 rate_msb;
 };
 
 /**
- * struct scmi_clk_state_in - Message payload for CLOCK_RATE_SET command
+ * struct scmi_clk_rate_set_in - Message payload for CLOCK_RATE_SET command
  * @flags:	Flags for the clock rate set request
  * @clock_id:	SCMI clock ID
  * @rate_lsb:	32bit LSB of the clock rate in Hertz
  * @rate_msb:	32bit MSB of the clock rate in Hertz
  */
 struct scmi_clk_rate_set_in {
@@ -860,13 +860,13 @@ struct scmi_clk_rate_set_in {
  */
 struct scmi_clk_rate_set_out {
 	s32 status;
 };
 
 /**
- * struct scmi_clk_parent_state_in - Message payload for CLOCK_PARENT_SET command
+ * struct scmi_clk_parent_set_in - Message payload for CLOCK_PARENT_SET command
  * @clock_id:		SCMI clock ID
  * @parent_clk:		SCMI clock ID
  */
 struct scmi_clk_parent_set_in {
 	u32 clock_id;
 	u32 parent_clk;
@@ -878,19 +878,21 @@ struct scmi_clk_parent_set_in {
  */
 struct scmi_clk_parent_set_out {
 	s32 status;
 };
 
 /**
+ * struct scmi_clk_get_permissions_in - Message payload for CLOCK_GET_PERMISSIONS command
  * @clock_id:	Identifier for the clock device.
  */
 struct scmi_clk_get_permissions_in {
 	u32 clock_id;
 };
 
 /**
+ * struct scmi_clk_get_permissions_out - Response payload for CLOCK_GET_PERMISSIONS command
  * @status:	Negative 32-bit integers are used to return error status codes.
  * @permissions:	Bit[31] Clock state control, Bit[30] Clock parent control,
  * Bit[29] Clock rate control, Bits[28:0] Reserved, must be zero.
  */
 struct scmi_clk_get_permissions_out {
 	s32 status;
-- 
2.51.0

