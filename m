Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051ED606E4AD
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 11:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=m2EDWkGf;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=q9gQ3MXg
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BE6DA60841;
	Mon, 16 Nov 2026 11:06:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id P6F8smiS8GyU; Mon, 16 Nov 2026 11:06:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A72FC60834
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794827211;
	b=Zd6PNkU+q9XUU0AI9RHygFmimMLhGILtXDcl20p5uTSA340Ua8AKlPKgVt06Zo2wt0DM
	 H0QxIKDrcDyC1p5q9rGAHfUr0qIr7GALuiO7uSbDih2a/nYFOt4CX9ThQ+XoSzrF19Iy1
	 gEdwdtQBbhFr1I2+8eWDYjA4/S7fKOV/59Y91Vr6fXPjTl0c0S4GXRIuhbPZyxGYcZO1y
	 aKJvNNDhvg8MjJ+Dqq7MLt9Xid5Mn9SiJG4sDB21KNXR3uesdVkYZXlflqAlcdCvdYyA1
	 FeCQIjexaZ1H1BpzyWQ4pDkDn3mP8vFYAQNPctJYwDdwXVc45JiuNz7xNUesoK9LT3Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794827211;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-MBO-RS-META:X-MBO-RS-ID:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=489zIbhVP4zpSBkF+W2XT/uBhOnM1osayY4pHBxkFys=;
	b=Wy7qY309SIsqsFZb7NlT8952e3mPS3SsOSBkAAIABtaIpVHdP6ZuJA/Li9umz6fYGUCQ
	 tKabhSvtVrX9dtdOb+NBo0mmzGAJFT1tSX6rOUmGuJfqhK0+qnS9ZBbQsHCqx6l6m8R/7
	 aHDOIBwTMafrJNsx7F9c8zR4trafuiAZkpryqw+O4dMQf7aignXyaTHYuz5yfHg9WZqah
	 C3RdHwGpjxvMi7s5Q6hmQdsWYpHmNeFMeqADyy2P3/YG9beI89vEK1x6mkTq8v4WuFMEj
	 ImRIsqXvMI9TvqDbMJd1SRb1AmFy7eSeYuSxXATBWRyDn87gJdDs5VST5TAl+FVFBnw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794827211;
	bh=489zIbhVP4zpSBkF+W2XT/uBhOnM1osayY4pHBxkFys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=m2EDWkGflAzhF0tZnlhskWuwUE/o405sZ+9N1uVMm8bZcAQ4jDJXtV6fMxpYkfuhl
	 zcLWuBHJQPb3PZ4Iu0IUvCoCicBVe1XHW4eJEtjYhTxo0/AQTJIp0G3b7bFsV14qL+
	 /V00BzdxcJ8GTIC/rc996ZdaBxYHiHSqozGU++QCna427nJPHjcPBHghIS2VJAGjEQ
	 1r3nUnDBFhVcU+MYbGNzWO1YohE7CPYnRfNLVU6LNwpDJwtfIj4SghnEs4pKpIBzjC
	 rxoUFbfMd2BVxL/6QzGkYydag0pxbVf6ALtA69PaIUS63j7aZXVWQFeRrBVgVJo5rR
	 NiEp6LqpxmdMA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A72FC60834;
	Mon, 16 Nov 2026 11:06:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 556302FE
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 11:06:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 415A9406A3
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 11:06:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aBib4eB4dWBI for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 11:06:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 37D7B405DD
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::201"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::201; helo=mout-p-201.mailbox.org;
 envelope-from=marek.vasut+renesas@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=q9gQ3MXg
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 37D7B405DD
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 11:06:43 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4jSlRh3wFWzMkxq;
 Mon, 16 Nov 2026 12:06:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1794827200;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=489zIbhVP4zpSBkF+W2XT/uBhOnM1osayY4pHBxkFys=;
 b=q9gQ3MXgzueBrF6VvHYjagREyrBHBKHqxjJBlhvxGyL8OXxesOABIfi3TuVCF9ZbKanuGe
 4X/vnW1hfWcY5TFHzIMTD82qWaC9RwEOEMIIxnG3eHpqdOQql8+MJ47t2yfGkM6JJXhGHW
 4fbUWSUjrxx9MZWRZuupWNJCAEN+93slycK8lTAD2wsZD0eUlrvjFnZKAvpSiR+VxyexRs
 gs55b56ob35BL23XrWRoSe81SJ97MaDAC9goR7PyRflPq79J9nzo0AMBBb7NoDAGqz/5wT
 d2pz2Fu8KdjX5Og4OXehW9LndoRES85Zc5VfR6mB6UPswTgSLXdhxs53Bz32MA==
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
Subject: [PATCH 7/9] reset: scmi: Export discovery functions
Date: Mon, 16 Nov 2026 12:05:43 +0100
Message-ID: <20261116110615.3394324-7-marek.vasut+renesas@mailbox.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261116110615.3394324-1-marek.vasut+renesas@mailbox.org>
References: <20261116110615.3394324-1-marek.vasut+renesas@mailbox.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: jp7t6wececifjazjdm6s6ed9odf4pwhd
X-MBO-RS-ID: 8f253bebe2da1eb5eab
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Make functions to determine SCMI reset protocol reset name, attributes
and latency available outside of SCMI reset protocol implementation.
Those functions can be invoked from the 'scmi info' command to print
detailed information about the SCMI reset protocol.

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
 drivers/reset/reset-scmi.c | 62 ++++++++++++++++++++++++++++++++------
 include/scmi_protocols.h   | 39 ++++++++++++++++++++++++
 2 files changed, 92 insertions(+), 9 deletions(-)

diff --git a/drivers/reset/reset-scmi.c b/drivers/reset/reset-scmi.c
index f92a9e35579..2fdb147cb21 100644
--- a/drivers/reset/reset-scmi.c
+++ b/drivers/reset/reset-scmi.c
@@ -43,26 +43,70 @@ static int scmi_reset_deassert(struct reset_ctl *rst)
 	return scmi_reset_set_level(rst, false);
 }
 
-static int scmi_reset_request(struct reset_ctl *rst)
+int scmi_reset_protocol_attrs(struct udevice *dev, int *num_rddoms)
 {
-	struct scmi_rd_attr_in in = {
-		.domain_id = rst->id,
+	struct scmi_rd_protocol_attr_out out;
+	struct scmi_msg msg = {
+		.protocol_id = SCMI_PROTOCOL_ID_RESET_DOMAIN,
+		.message_id = SCMI_PROTOCOL_ATTRIBUTES,
+		.out_msg = (u8 *)&out,
+		.out_msg_sz = sizeof(out),
 	};
+	int ret;
+
+	if (!dev || !num_rddoms)
+		return -EINVAL;
+
+	ret = devm_scmi_process_msg(dev, &msg);
+	if (ret)
+		return ret;
+
+	if (out.status)
+		return scmi_to_linux_errno(out.status);
+
+	*num_rddoms = SCMI_RD_PROTO_ATTRS_NUM_RD(out.attributes);
+
+	return 0;
+}
+
+int scmi_reset_attrs(struct udevice *dev, u32 domain_id, u32 *attributes,
+		     u32 *latency, u8 **name)
+{
+	struct scmi_rd_attr_in in = { .domain_id = domain_id, };
 	struct scmi_rd_attr_out out;
 	struct scmi_msg msg = SCMI_MSG_IN(SCMI_PROTOCOL_ID_RESET_DOMAIN,
 					  SCMI_RESET_DOMAIN_ATTRIBUTES,
 					  in, out);
 	int ret;
 
-	/*
-	 * We don't really care about the attribute, just check
-	 * the reset domain exists.
-	 */
-	ret = devm_scmi_process_msg(rst->dev, &msg);
+	if (!dev)
+		return -EINVAL;
+
+	ret = devm_scmi_process_msg(dev, &msg);
 	if (ret)
 		return ret;
 
-	return scmi_to_linux_errno(out.status);
+	if (out.status)
+		return scmi_to_linux_errno(out.status);
+
+	if (attributes)
+		*attributes = out.attributes;
+
+	if (latency)
+		*latency = out.latency;
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
+static int scmi_reset_request(struct reset_ctl *rst)
+{
+	return scmi_reset_attrs(rst->dev, rst->id, NULL, NULL, NULL);
 }
 
 static const struct reset_ops scmi_reset_domain_ops = {
diff --git a/include/scmi_protocols.h b/include/scmi_protocols.h
index a50794aceac..e90234efab1 100644
--- a/include/scmi_protocols.h
+++ b/include/scmi_protocols.h
@@ -937,6 +937,18 @@ enum scmi_reset_domain_message_id {
 #define SCMI_RD_RESET_FLAG_ASSERT	BIT(1)
 #define SCMI_RD_RESET_FLAG_CYCLE	BIT(0)
 
+#define SCMI_RD_PROTO_ATTRS_NUM_RD(attributes) ((attributes) & GENMASK(15, 0))
+
+/**
+ * struct scmi_rd_protocol_attr_out
+ * @status:		SCMI command status
+ * @attributes:		Protocol attributes
+ */
+struct scmi_rd_protocol_attr_out {
+	s32 status;
+	u32 attributes;
+};
+
 /**
  * struct scmi_rd_attr_in - Payload for RESET_DOMAIN_ATTRIBUTES message
  * @domain_id:	SCMI reset domain ID
@@ -1415,6 +1427,33 @@ int scmi_clk_get_permissions(struct udevice *dev, int id, u32 *perm);
  */
 ulong scmi_clk_get_rate_id(struct udevice *dev, int id);
 
+/**
+ * scmi_reset_protocol_attrs - get protocol attributes
+ * @dev:	SCMI protocol device
+ * @num_rddoms:	Number of reset domains
+ *
+ * Obtain the protocol attributes, the number of reset domains.
+ *
+ * Return: 0 on success, error code on failure
+ */
+int scmi_reset_protocol_attrs(struct udevice *dev, int *num_rddoms);
+
+/**
+ * scmi_reset_attrs - get reset domain attributes
+ * @dev:	SCMI protocol device
+ * @domain_id:	Identifier of reset domain
+ * @attributes:	Power domain attributes
+ * @latency:	Power domain latency
+ * @name:	Name of reset domain
+ *
+ * Obtain the attributes of the given reset domain, @domain_id, in @attributes
+ * as well as its name in @name.
+ *
+ * Return: 0 on success, error code on failure
+ */
+int scmi_reset_attrs(struct udevice *dev, u32 domain_id, u32 *attributes,
+		     u32 *latency, u8 **name);
+
 /**
  * scmi_pinctrl_protocol_attrs - get pinctrl information
  * @dev: SCMI protocol device
-- 
2.53.0

