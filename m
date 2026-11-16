Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01163606D7A3
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 11:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=bfSOMx9h;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=NiTM/QjU
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CFC4F607C7;
	Mon, 16 Nov 2026 11:06:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TykA2sMp2DO6; Mon, 16 Nov 2026 11:06:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1558660769
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794827203;
	b=sLDxTuptgVctuZZ9vLPLHMJcHFSNyrMic1NEEPloEvvuGVXhjfiv7AxX8eyxRU/q80/K
	 ODT4Z+wJ6FispFKpJOn1RzoUvYlv5kIY+j2GEPFUojwRcnsGToKJ65XSfZ8Ty1eVfy0H4
	 JPnFAxRotT9Fz+pHqibzMieMMkIja6EvN3mOzpWd/+ZYhQYLB5vBLRKFIqtWiAt/iD+iC
	 p/WLqviZ8RwOZYpcgw1xJs3ozYMWH92LG5OjuX5J7poXmjf/1eTufGKLqeGoPuj+7PAf6
	 EcO1unykNMgWpOj5ior483BD7Tn9SblCfta7JizRziNOyb9Fj3mR6gRyhT8T6LnPG/w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794827203;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-MBO-RS-ID:X-MBO-RS-META:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ZTxvPfw8YWAtZD3FDpA2/ngXIk/sWo5lWhAo1QDni30=;
	b=bX5XeSO8gBAlL8/mU4LszO0bdfLrxymY8gk3afaOusl0D9r0mjHv6AqFBA9Su3phMJ69
	 2uSxrtHZi90w6mmwdvBwGtUpWUvvhYgEj5Y5ZTl7yoPII8l2xF4IgIlB/Up+5Y4bhE7uQ
	 +xZpXojq/SRTnRsqdcnxFq0UBGYKTC3IEhM0hUHtp+GDbdF9PA5+V74sJMsUuyLFbCJOY
	 H2E+zkEjIUxzRRQkt5Bvpz6DF8Q7F+/Oe5jokqgkw+9qcRpI87GIup7qM/3k4fEUvJVSw
	 bmJK6vFJ/TyMSQmEIgX0p5Z8gE+IW4v89x3wMo4bjARCo1yDQPdFtP2IRa0tKqCJXDQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794827203;
	bh=ZTxvPfw8YWAtZD3FDpA2/ngXIk/sWo5lWhAo1QDni30=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bfSOMx9hnM+NfaGc5+kflcFbID1kg3Xoy767785/IguQrJTdbNvOBDmUs2zC70Anw
	 x1AaOLFpBk3kyk6f1tGIVmcXUFy9/lvfUaSi2fxKaJU4vgxNnuZjwdAyekBjz2T5NY
	 Geyl74aTtHjUBoViYNWKDsnOxDcOGm6xjH9+iJvN2Gz4FojAljTi0UE05sucxuGJd/
	 WkL4EzbzeaXPhPoumwdWs6Nuut4Jay88XfU/sk6Gf/UsrpYGjxPiuKqd4JIP7HoxVM
	 vipcmdz+qd3yDfqbFLu5RTIIdiiQaRjnLntX4+TH8t7Qz0uXdl5iDavmSoJ4H5qYED
	 Ztcu5yigJ4mUg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1558660769;
	Mon, 16 Nov 2026 11:06:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id B52A72FB
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 11:06:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A5C3B80DCB
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 11:06:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cUYFuSjI7her for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 11:06:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 66C4780DC7
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=80.241.56.171
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.171;
 helo=mout-p-201.mailbox.org; envelope-from=marek.vasut+renesas@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=NiTM/QjU
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 66C4780DC7
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 11:06:35 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4jSlRY17BpzMlLS;
 Mon, 16 Nov 2026 12:06:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1794827193;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZTxvPfw8YWAtZD3FDpA2/ngXIk/sWo5lWhAo1QDni30=;
 b=NiTM/QjUsajCFYV4dvD4tv6b349O6TBacruapF6SktArcNJ0P40h/hd8v6GfZvL3Tj8bFi
 IzqAz43/zl5LZo0AwIk4fmTHGHzQf3XFri6lgAnqFN7yCRp/EW2DJYfBO5h2cbDf0YNphs
 KQmmxXac6JfhUrhwcXH2w2b8Mt2vS1TvPzYEU+ZcuDxOd9tYvINTD0BTs0MGRMIPepNpqV
 ySOXCghhx8cGviL2cjNi2ESYaMmQhu6kP6xMPLe8vJhqRuX2otIACiFvKSswUQYBT9mfm1
 PTaI0GtxdZyCQHNlesY5ArL1nMNJrO0otDWrMfWN6G9R1oNUhCkJxOohrOgcRA==
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
Subject: [PATCH 3/9] firmware: scmi: sandbox: Add SCMI voltage domain version
 attribute handling
Date: Mon, 16 Nov 2026 12:05:39 +0100
Message-ID: <20261116110615.3394324-3-marek.vasut+renesas@mailbox.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261116110615.3394324-1-marek.vasut+renesas@mailbox.org>
References: <20261116110615.3394324-1-marek.vasut+renesas@mailbox.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 587782e33c9da252347
X-MBO-RS-META: t1zn3yrszpu8w7cue7aaz64gnhkcxp91
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

Add handling for the SCMI voltage domain PROTOCOL_VERSION command.
Report voltage domain version 3.0 .

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
 drivers/firmware/scmi/sandbox-scmi_agent.c | 16 ++++++++++++++++
 include/scmi_protocols.h                   |  1 +
 2 files changed, 17 insertions(+)

diff --git a/drivers/firmware/scmi/sandbox-scmi_agent.c b/drivers/firmware/scmi/sandbox-scmi_agent.c
index 6f058d5c2aa..b0f19e99d52 100644
--- a/drivers/firmware/scmi/sandbox-scmi_agent.c
+++ b/drivers/firmware/scmi/sandbox-scmi_agent.c
@@ -983,6 +983,20 @@ static int sandbox_scmi_rd_reset(struct udevice *dev, struct scmi_msg *msg)
 	return 0;
 }
 
+static int sandbox_scmi_voltd_version(struct udevice *dev, struct scmi_msg *msg)
+{
+	struct scmi_protocol_version_out *out = NULL;
+
+	if (!msg->out_msg || msg->out_msg_sz < sizeof(*out))
+		return -EINVAL;
+
+	out = (struct scmi_protocol_version_out *)msg->out_msg;
+	out->version = 0x30000;
+	out->status = SCMI_SUCCESS;
+
+	return 0;
+}
+
 static int sandbox_scmi_voltd_attribs(struct udevice *dev, struct scmi_msg *msg)
 {
 	struct scmi_voltd_attr_in *in = NULL;
@@ -1309,6 +1323,8 @@ static int sandbox_scmi_test_process_msg(struct udevice *dev,
 			return sandbox_proto_not_supported(msg);
 
 		switch (msg->message_id) {
+		case SCMI_VOLTAGE_DOMAIN_VERSION:
+			return sandbox_scmi_voltd_version(dev, msg);
 		case SCMI_VOLTAGE_DOMAIN_ATTRIBUTES:
 			return sandbox_scmi_voltd_attribs(dev, msg);
 		case SCMI_VOLTAGE_DOMAIN_CONFIG_SET:
diff --git a/include/scmi_protocols.h b/include/scmi_protocols.h
index 2c26ab9d020..ed64db4e4e9 100644
--- a/include/scmi_protocols.h
+++ b/include/scmi_protocols.h
@@ -982,6 +982,7 @@ struct scmi_rd_reset_out {
  */
 
 enum scmi_voltage_domain_message_id {
+	SCMI_VOLTAGE_DOMAIN_VERSION = 0x0,
 	SCMI_VOLTAGE_DOMAIN_ATTRIBUTES = 0x3,
 	SCMI_VOLTAGE_DOMAIN_CONFIG_SET = 0x5,
 	SCMI_VOLTAGE_DOMAIN_CONFIG_GET = 0x6,
-- 
2.53.0

