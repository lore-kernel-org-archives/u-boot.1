Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514CF606D7B3
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 11:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=jU0BkeOs;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=HXQuhX0O
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D314A60814;
	Mon, 16 Nov 2026 11:06:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 01FHN0_lDyEE; Mon, 16 Nov 2026 11:06:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 89694607E4
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794827205;
	b=SSSY/tnEf6Csc2Wk2kI8ndNyPah/34hXiFyA+mTb02Vcpu/oxOEeMCPhMQ+aS0EV/aYS
	 RT884qgraRGY12ysDqrpMEA1X+4O7Ve6OpNnpIctpC4gmMNpbq4cSCAuvodHcFlGLcOan
	 PmjR7YM5zONpOTNyoAmhEszA87t8LqdMJwvY1knsYY31WfU32jiwY03k/xu50eNLUAPZI
	 QrxopnS3UH0qIC6fkBUUC9CFWATXA9xZzZmHM/OIeseti0SYwHWYDJ2mELGEC9ceuA8Jq
	 pXHAEX6xOmd97+wle9Id0U9S+9ZxbEk+KjuCLFGqrqO9ri4kh1i8rYIMdm0vGlpnjog==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794827205;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-MBO-RS-ID:X-MBO-RS-META:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ki+yKtIBXO0L9nXzRbVqVrvj//OvMZpcMJaQUD5qKrA=;
	b=AiRAjwEXvcNwaCXdKKFAYh9z8+CG0Psib3j4/nwh0oNTp5DqllfqRdch4r2nTJMwCwNA
	 1kCAXpxVGZNpo8L/OE6UvWAN2CJvKz/5W6dARZcD5d72SLY49qMdJKv/m5XqByUP9UxmQ
	 Dpi0xRKgNhuJOFCpiZUmbbnV8BSnbb4g2PpYxrKe54G9siSeuqpvRFrTdFoSsMZdvUccO
	 pfAZMLacO08PxDzkILg0Nc149FaZxgSUd4N96wz4W9QdKt4RLy59WlxlDyqWnAZGlCKoB
	 2hjumjqp+OquvpZPOihrk8VxOABxa+qV9k2LiD+yHHyeK18OV3up3k9WhAFv/5MAUVQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794827205;
	bh=ki+yKtIBXO0L9nXzRbVqVrvj//OvMZpcMJaQUD5qKrA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jU0BkeOsJrHNvPQYip51Xc8cN3C0kGKJ2JEa1CvT0BUm6mOsUg5u8zFavswKRY5zK
	 va59KkurhASXZ2G+yePM+Qr5/0ixgdWbhBPF8Foad79RNShQV4CIQ4rE3vfaixKSWg
	 8SA1l7peJ8q6u68FDzHg6VAh39HILv/m8lDv2rVRPxFwPsfT9WGJDjnLAlJUIO1/Ih
	 zjrlgILVub0C45WoHsjy76njrO5CdzoAsoRkfSq+8eAsniTUF8xxwEfn0RXRKn3TNb
	 r2OPUewH/MjnF55m8JVoTZcFhBL+d7pUnzGeFooQr3KWwfhEJruIihGw0hXC5pmeMH
	 4gJPVfBX3KJjA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 89694607E4;
	Mon, 16 Nov 2026 11:06:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id F34C628C
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 11:06:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E54D7405DD
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 11:06:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id C39PPWFa85Qe for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 11:06:40 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 33406405CF
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=80.241.56.152
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.152;
 helo=mout-p-102.mailbox.org; envelope-from=marek.vasut+renesas@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=HXQuhX0O
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 33406405CF
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 11:06:39 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4jSlRb11fvzKnCX;
 Mon, 16 Nov 2026 12:06:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1794827195;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ki+yKtIBXO0L9nXzRbVqVrvj//OvMZpcMJaQUD5qKrA=;
 b=HXQuhX0OBE+E9evPnB2T9duDYvy1c799WQzAtq1h8kKwFol8Mypv3CVCPSvQt9Ayx+olTn
 KyEMiYGFYYG+mpN2HP/sv7RU1lmqEPyzPv1GAho+QvMoA5nPpoTAbWMYqV8YGZk1aWHVcq
 9+zCaUe8ywZ1T+FeQAdL1MU8Yxc6BwXpQ2QIGvofJwHRiHOWwGjEbei4TDj8d4hJpcPm1G
 OFrro/JT3HQlKbk3vDZU2boT7Hja/LXtk6vWxmRZqB3uXBUURLbAD9BDVVYak2RXhgylCb
 qPtKW++fgrtO9nZExj0hYYA61+ljSMzJsuxZG1rfVyjUPGW9bccKk8i7kZ7YUA==
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
Subject: [PATCH 4/9] firmware: scmi: sandbox: Add SCMI voltage domain protocol
 attribute handling
Date: Mon, 16 Nov 2026 12:05:40 +0100
Message-ID: <20261116110615.3394324-4-marek.vasut+renesas@mailbox.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261116110615.3394324-1-marek.vasut+renesas@mailbox.org>
References: <20261116110615.3394324-1-marek.vasut+renesas@mailbox.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 633726fdc450f09cfd2
X-MBO-RS-META: mentzsxpci6f391hpjwf99i5c7gqq4bz
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

Add handling for the SCMI voltage domain PROTOCOL_ATTRIBUTE command.
Report regulator count.

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
 drivers/firmware/scmi/sandbox-scmi_agent.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/firmware/scmi/sandbox-scmi_agent.c b/drivers/firmware/scmi/sandbox-scmi_agent.c
index b0f19e99d52..c6666bfbd25 100644
--- a/drivers/firmware/scmi/sandbox-scmi_agent.c
+++ b/drivers/firmware/scmi/sandbox-scmi_agent.c
@@ -997,6 +997,21 @@ static int sandbox_scmi_voltd_version(struct udevice *dev, struct scmi_msg *msg)
 	return 0;
 }
 
+static int sandbox_scmi_voltd_protocol_attribs(struct udevice *dev,
+					       struct scmi_msg *msg)
+{
+	struct scmi_voltd_protocol_attr_out *out = NULL;
+
+	if (!msg->out_msg || msg->out_msg_sz < sizeof(*out))
+		return -EINVAL;
+
+	out = (struct scmi_voltd_protocol_attr_out *)msg->out_msg;
+	out->attributes = ARRAY_SIZE(scmi_voltd);
+	out->status = SCMI_SUCCESS;
+
+	return 0;
+}
+
 static int sandbox_scmi_voltd_attribs(struct udevice *dev, struct scmi_msg *msg)
 {
 	struct scmi_voltd_attr_in *in = NULL;
@@ -1325,6 +1340,8 @@ static int sandbox_scmi_test_process_msg(struct udevice *dev,
 		switch (msg->message_id) {
 		case SCMI_VOLTAGE_DOMAIN_VERSION:
 			return sandbox_scmi_voltd_version(dev, msg);
+		case SCMI_PROTOCOL_ATTRIBUTES:
+			return sandbox_scmi_voltd_protocol_attribs(dev, msg);
 		case SCMI_VOLTAGE_DOMAIN_ATTRIBUTES:
 			return sandbox_scmi_voltd_attribs(dev, msg);
 		case SCMI_VOLTAGE_DOMAIN_CONFIG_SET:
-- 
2.53.0

