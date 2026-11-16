Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C90606FE8E
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 11:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Gnn339rk;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=ngUmFKwN
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A5DCC406AB;
	Mon, 16 Nov 2026 11:06:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RynH9I-P3tTz; Mon, 16 Nov 2026 11:06:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9DEEA406D5
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794827212;
	b=X8VqBdbTBwkzoyB95qdUQbtLClKiGbCYyr14bjswWQxp+PNK/6BsPh+hzvvlTUpW2cNH
	 N47KVkQ3Syw0Cp0NX7/nrfTYUAjVW78h3weU+i5YzUlxKuRcmXTpHdw2doE6/SaSeIveE
	 lSbunkLZGH2pm5X+FWC7feE6givSK/64ZzqwT/8icsSmr6fKvGbu7cfBv+BLV0EElX6fw
	 T9LGS/o46wDRup0pkhsHuOrtKSFEx5Dln5MSkaviLC2JIAyIyDw8sUhT+d8Wnz7iVhYRx
	 rCBewv8geYWjn4goRJ38PurA/ZC0kgafaETXFxAUAv8skFWYeE4TTGELdfdEfVJyfGw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794827212;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-MBO-RS-ID:X-MBO-RS-META:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=XtU9Mb/cJ3XHCb+x3oeaRZjPAkux/F/V72HlnL15Yjo=;
	b=bCNkJ8No6HA2VSABjUZZdb54tYQXP49kBGhFUpvuC3N70XqH9DnwTUmceNeb5rGneimb
	 WRF9i8JfLWm6ZVau9yr+QGWY3y1b2W8QLFALbIoilF6sAoFPnSa9mvqsqQUvlGiHqYYGx
	 BcVtpOno+5xUvTst7uN1FwGVZ89832NOKZ9DqfI107prR2A4T17KxI44F10opha9w82wn
	 H3XT50FEeFvw3eh+Wzok9R3ZyKHOELFFcIX49A+XxOwFVV9Hjhw8QLT29Ewr/weu+WSmv
	 lF2rtXDd9oJmROaO2oQSMuQLxJYlbhv6Vw/NMq1mUEURK4QgqEMujxAa1gb6KwG9UTA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794827212;
	bh=XtU9Mb/cJ3XHCb+x3oeaRZjPAkux/F/V72HlnL15Yjo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Gnn339rkq5nugMkvABAOE0syMTcbfTtB9ohei0nwnwwV5+IITxSfPsUh1brqsF+Xw
	 b4jlUXJj07wYgd/6HRaOjFctGvBMldziKsMSzbvVlvgrQH8LLDBQ3uwYurXp37zYOz
	 a4hxHM+8xK95bE8QlRcwx3uwwTUgnQ1mCFup4vFMek93ubQlXQSq/DrNUesmosP7tP
	 XR4jY5t+dEDSPX7qDLJq+ImBOVvU0i8dTvTkKzb4eyqrnbauk9Qp6lVegwDgtaAmWV
	 r7y0IFunRAonMdTdCwpJVxAmSUi5Kkbx6Lvd0sPu0mLP/2Ddxw8JklYElRKyao7BKm
	 LyTdARMV85P/Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9DEEA406D5;
	Mon, 16 Nov 2026 11:06:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 2AF931A6
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 11:06:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 10ECE80DCB
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 11:06:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kjuHWFu8WbIl for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 11:06:46 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org EA36080DC7
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=80.241.56.151
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.151;
 helo=mout-p-101.mailbox.org; envelope-from=marek.vasut+renesas@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=ngUmFKwN
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EA36080DC7
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 11:06:45 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4jSlRk24r3z8sfB;
 Mon, 16 Nov 2026 12:06:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1794827202;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XtU9Mb/cJ3XHCb+x3oeaRZjPAkux/F/V72HlnL15Yjo=;
 b=ngUmFKwNtGhZx7j78Kp27aRTXaeVSMwwm4WkMs/jWpoAZ1URZAnO1XjsddPrI9T3LoDYD6
 Qk23aztCmA/5gJoUbzNkxRfJu7B0jRJkjf3QExUZvm7085gSsUqpDaMimEUxKT+pAMRiWd
 5tTpWKxUQrrK6NkA2jUlMWewzFTrw4gcRjhhDI1nvGQWjQjf+bHIXqVhJpd2n/Hc6M+o+Y
 57GdZtodoIqRRRX1aFKSZ2EsMv58+SqVfKZfvOeSNZ4VZ4f3cED7n4cSjerBm3cL7lQMy8
 S1idCTRVaKY20Ij0qClEFKmfCOhq9/DJh5t3IOG4cEwIoq+cFf1foDZzT1N1AA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Alexey Charkov <alchark@flipper.net>,
 Casey Connolly <casey.connolly@linaro.org>,
 Daniel Golle <daniel@makrotopia.org>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Lukasz Majewski <lukma@nabladev.com>,
 Mehmet Fide <mehmet.fide@screeningeagle.com>,
 Michal Simek <michal.simek@amd.com>, Peng Fan <peng.fan@nxp.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Udit Kumar <u-kumar1@ti.com>
Subject: [PATCH 8/9] regulator: scmi: Export discovery functions
Date: Mon, 16 Nov 2026 12:05:44 +0100
Message-ID: <20261116110615.3394324-8-marek.vasut+renesas@mailbox.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261116110615.3394324-1-marek.vasut+renesas@mailbox.org>
References: <20261116110615.3394324-1-marek.vasut+renesas@mailbox.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 361d3977693a58f33f4
X-MBO-RS-META: 1d113rxhrx1krur4t6pehrtkkj77r4ps
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Make functions to determine SCMI regulator protocol regulator name and
attributes available outside of SCMI regulator protocol implementation.
Those functions can be invoked from the 'scmi info' command to print
detailed information about the SCMI regulator protocol.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Alexey Charkov <alchark@flipper.net>
Cc: Casey Connolly <casey.connolly@linaro.org>
Cc: Daniel Golle <daniel@makrotopia.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>
Cc: Lukasz Majewski <lukma@nabladev.com>
Cc: Mehmet Fide <mehmet.fide@screeningeagle.com>
Cc: Michal Simek <michal.simek@amd.com>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: Udit Kumar <u-kumar1@ti.com>
Cc: u-boot@lists.u-boot-project.org
---
 drivers/power/regulator/scmi_regulator.c | 60 +++++++++++++++++++++---
 include/scmi_protocols.h                 | 37 +++++++++++++++
 2 files changed, 90 insertions(+), 7 deletions(-)

diff --git a/drivers/power/regulator/scmi_regulator.c b/drivers/power/regulator/scmi_regulator.c
index aa7b4278260..19d6ee3d512 100644
--- a/drivers/power/regulator/scmi_regulator.c
+++ b/drivers/power/regulator/scmi_regulator.c
@@ -125,10 +125,35 @@ static int scmi_regulator_of_to_plat(struct udevice *dev)
 	return 0;
 }
 
-static int scmi_regulator_probe(struct udevice *dev)
+int scmi_voltd_protocol_attrs(struct udevice *dev, int *num_voltdoms)
 {
-	struct scmi_regulator_platdata *pdata = dev_get_plat(dev);
-	struct scmi_voltd_attr_in in = { 0 };
+	struct scmi_voltd_protocol_attr_out out;
+	struct scmi_msg msg = {
+		.protocol_id = SCMI_PROTOCOL_ID_VOLTAGE_DOMAIN,
+		.message_id = SCMI_PROTOCOL_ATTRIBUTES,
+		.out_msg = (u8 *)&out,
+		.out_msg_sz = sizeof(out),
+	};
+	int ret;
+
+	if (!dev || !num_voltdoms)
+		return -EINVAL;
+
+	ret = devm_scmi_process_msg(dev, &msg);
+	if (ret)
+		return ret;
+
+	if (out.status)
+		return scmi_to_linux_errno(out.status);
+
+	*num_voltdoms = SCMI_RD_PROTO_ATTRS_NUM_RD(out.attributes);
+
+	return 0;
+}
+
+int scmi_voltd_attrs(struct udevice *dev, u32 domain_id, u32 *attributes, u8 **name)
+{
+	struct scmi_voltd_attr_in in = { .domain_id = domain_id };
 	struct scmi_voltd_attr_out out = { 0 };
 	struct scmi_msg scmi_msg = {
 		.protocol_id = SCMI_PROTOCOL_ID_VOLTAGE_DOMAIN,
@@ -140,14 +165,35 @@ static int scmi_regulator_probe(struct udevice *dev)
 	};
 	int ret;
 
-	ret = devm_scmi_of_get_channel(dev);
+	ret = devm_scmi_process_msg(dev, &scmi_msg);
 	if (ret)
 		return ret;
 
-	/* Check voltage domain is known from SCMI server */
-	in.domain_id = pdata->domain_id;
+	if (out.status)
+		return scmi_to_linux_errno(out.status);
 
-	ret = devm_scmi_process_msg(dev, &scmi_msg);
+	if (attributes)
+		*attributes = out.attributes;
+
+	if (name) {
+		*name = strdup(out.name);
+		if (!*name)
+			return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static int scmi_regulator_probe(struct udevice *dev)
+{
+	struct scmi_regulator_platdata *pdata = dev_get_plat(dev);
+	int ret;
+
+	ret = devm_scmi_of_get_channel(dev);
+	if (ret)
+		return ret;
+
+	ret = scmi_voltd_attrs(dev, pdata->domain_id, NULL, NULL);
 	if (ret) {
 		dev_err(dev, "Failed to query voltage domain %u: %d\n",
 			pdata->domain_id, ret);
diff --git a/include/scmi_protocols.h b/include/scmi_protocols.h
index e90234efab1..fbba5a3baed 100644
--- a/include/scmi_protocols.h
+++ b/include/scmi_protocols.h
@@ -1010,6 +1010,18 @@ enum scmi_voltage_domain_message_id {
 #define SCMI_VOLTD_CONFIG_OFF		0
 #define SCMI_VOLTD_CONFIG_ON		0x7
 
+#define SCMI_VOLTD_PROTO_ATTRS_NUM_VOLTD(attributes) ((attributes) & GENMASK(15, 0))
+
+/**
+ * struct scmi_voltd_protocol_attr_out
+ * @status:		SCMI command status
+ * @attributes:		Protocol attributes
+ */
+struct scmi_voltd_protocol_attr_out {
+	s32 status;
+	u32 attributes;
+};
+
 /**
  * struct scmi_voltd_attr_in - Payload for VOLTAGE_DOMAIN_ATTRIBUTES message
  * @domain_id:	SCMI voltage domain ID
@@ -1594,4 +1606,29 @@ int scmi_pinctrl_settings_configure_one(struct udevice *dev, enum select_type se
 int scmi_pinctrl_set_function(struct udevice *dev, enum select_type select_type,
 			      unsigned int selector, u32 function_id);
 
+/**
+ * scmi_voltd_protocol_attrs - get protocol attributes
+ * @dev:		SCMI protocol device
+ * @num_voltdoms:	Number of voltd domains
+ *
+ * Obtain the protocol attributes, the number of voltd domains.
+ *
+ * Return: 0 on success, error code on failure
+ */
+int scmi_voltd_protocol_attrs(struct udevice *dev, int *num_voltdoms);
+
+/**
+ * scmi_voltd_attrs - get voltd domain attributes
+ * @dev:	SCMI protocol device
+ * @domain_id:	Identifier of voltd domain
+ * @attributes:	Power domain attributes
+ * @name:	Name of voltd domain
+ *
+ * Obtain the attributes of the given voltd domain, @domain_id, in @attributes
+ * as well as its name in @name.
+ *
+ * Return: 0 on success, error code on failure
+ */
+int scmi_voltd_attrs(struct udevice *dev, u32 domain_id, u32 *attributes, u8 **name);
+
 #endif /* _SCMI_PROTOCOLS_H */
-- 
2.53.0

