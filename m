Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 802BE606BE3D
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 11:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=GGiTds8Z;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=VcvFL18x
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 51339605F8;
	Mon, 16 Nov 2026 11:06:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Bu7YSwIRVxHX; Mon, 16 Nov 2026 11:06:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 95ACE60769
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794827197;
	b=pRz9XBY1gMTi4Rp3nalEtzYHR6hp368RpbhvTLUUFsAbYDgNiT9GRdWqCZOY+hmLtoM6
	 /zrvLeNYhC2Or5uEUVEf8pVJForHxSb0zln0kpZ0913VmbDWgALy1CeSoZb5huYMmZgLY
	 1M66YrvjnFV+VP+RPanCs65YOAUYPqaXAGt4NyBoZdLknXLSQ7yf0Y+sKGpDkIPcGhJ22
	 v5BhChCPaUcZc9QpGdDPNx7r77ZBgWixn0Verm029XBgfQu3ARCMq2rC6lE1Nl4nWImmA
	 /PC9Pv32AjmbTMrZIkb1rX+DEGY24l0cngJuMYNXJL9g5NjYY4AS6KosBIjMWDNTAZw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794827197;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=bnD1VUbgFfkDevmltm2WFkV84y9dyfFRWZPFkgZl8DY=;
	b=j+1qiW0rWervq9yBzq1gR3OL05CsuvJYEZkftPwCC2JyOkbRlQZgmIPH0lvWbBg7AEEZ
	 cMNGqKu1THjcE7iJzDsJBYTih4XbpOXrlo6ckaTGvE+xv1D2TCU0/7/T8eeU/puRn82Ke
	 I7Eg/olwun5Ii3RN2Sh2wJr+S7juHY4odMgPYruX50//UaRDIec3yOoiIK27AC4RKGFTs
	 kHyNQ/8CVGrQHHueFJq6NXtDijFNwaeTLP4+qdurqAp6sXYsw6pVxj5FkAgJSzpBzSe8X
	 38ISXgnc5bOtgom3hGN7A+3Sj3gHdw1SEC1oqmU8Ze45Aaxv2q+GpZX3sOwVo0NulwA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=VcvFL18x;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794827197;
	bh=bnD1VUbgFfkDevmltm2WFkV84y9dyfFRWZPFkgZl8DY=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=GGiTds8ZPPUtuL1WtToVLDPIs25TEGy7SrUKft5NF1OeVykSmaH6MceCkWa643gQE
	 OkHD3jkl7VoQxNbLP2KR/sIl9ivvBoxOoy0mzvpuooyB/w0MYNafuqa5Sj2xU+MW0G
	 Pp/NNWki3a8JEtfRNFxs1ogiGyHgN49D4ahVXLWpUlOmI/z6b9einaLdPHfVrktkWM
	 HS7mygCVtuEvmgYwqv5JF/PSFGrGUw4UWnhK4vebPckG5gPp8MLpfPWJFr4WmWXYr2
	 Gme2NiapdSSgOBA2WTY064fVYdfsbCfOh3R1Oc69Xb2LAaMEhF/Fc2yvDlaPc6Zd7u
	 FkBPltoMGmVtg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 95ACE60769;
	Mon, 16 Nov 2026 11:06:37 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id BF0E81A6
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 11:06:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A527C605F8
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 11:06:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RIZBbfptaOeL for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 11:06:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org B22D960769
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::201"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::201; helo=mout-p-201.mailbox.org;
 envelope-from=marek.vasut+renesas@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=VcvFL18x
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B22D960769
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 11:06:32 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4jSlRS6yCbzMlC5;
 Mon, 16 Nov 2026 12:06:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1794827189;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=bnD1VUbgFfkDevmltm2WFkV84y9dyfFRWZPFkgZl8DY=;
 b=VcvFL18xYgR2UfDHmGYWiIN8cvHRHZO3tTa/6jBtz8FhhUVHQBMj2Ojfi3MMPgGcP8QcaY
 nm8i+eYIgFSyH/vR7wuNjzjSu27vIBuAaGprAtA8pACFIeQwQV2+A7SkU+CDAvvKr0EuXk
 u7NVZ1Nx1nE969dR8T4i9oYXwVRfIzzWdiIVj68lBMaMhXbfsz2uAyWwB3pNGBUc73H3GC
 A/3/MQJ6zfPbNmJjL0RDKyggYhO4lfTcXdcKi0wRI/8KywRmyyTTBnIh1J9ZYK5YGWo7tV
 y2UppEXBZ7A6aMTusvoKLt4YCNwhYqEnFcsxcsCZekuY4n5mk/hO538r0q17+A==
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
Subject: [PATCH 1/9] firmware: scmi: sandbox: Add SCMI reset domain version
 attribute handling
Date: Mon, 16 Nov 2026 12:05:37 +0100
Message-ID: <20261116110615.3394324-1-marek.vasut+renesas@mailbox.org>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: m5zmfr5x5auxaddiqawe6y47oye4seh9
X-MBO-RS-ID: d397213042b84b7e610
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

Add handling for the SCMI reset domain PROTOCOL_VERSION command.
Report reset version 3.0 .

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
 include/scmi_protocols.h                   |  1 +
 2 files changed, 18 insertions(+)

diff --git a/drivers/firmware/scmi/sandbox-scmi_agent.c b/drivers/firmware/scmi/sandbox-scmi_agent.c
index 9cb7a560451..1575e341a19 100644
--- a/drivers/firmware/scmi/sandbox-scmi_agent.c
+++ b/drivers/firmware/scmi/sandbox-scmi_agent.c
@@ -883,6 +883,21 @@ static int sandbox_scmi_clock_permissions_get(struct udevice *dev,
 	return 0;
 }
 
+static int sandbox_scmi_rd_version(struct udevice *dev,
+				   struct scmi_msg *msg)
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
 static int sandbox_scmi_rd_attribs(struct udevice *dev, struct scmi_msg *msg)
 {
 	struct scmi_rd_attr_in *in = NULL;
@@ -1262,6 +1277,8 @@ static int sandbox_scmi_test_process_msg(struct udevice *dev,
 			return sandbox_proto_not_supported(msg);
 
 		switch (msg->message_id) {
+		case SCMI_RESET_DOMAIN_VERSION:
+			return sandbox_scmi_rd_version(dev, msg);
 		case SCMI_RESET_DOMAIN_ATTRIBUTES:
 			return sandbox_scmi_rd_attribs(dev, msg);
 		case SCMI_RESET_DOMAIN_RESET:
diff --git a/include/scmi_protocols.h b/include/scmi_protocols.h
index 86165f8ba5e..2c26ab9d020 100644
--- a/include/scmi_protocols.h
+++ b/include/scmi_protocols.h
@@ -921,6 +921,7 @@ struct scmi_clk_get_permissions_out {
  */
 
 enum scmi_reset_domain_message_id {
+	SCMI_RESET_DOMAIN_VERSION = 0x0,
 	SCMI_RESET_DOMAIN_ATTRIBUTES = 0x3,
 	SCMI_RESET_DOMAIN_RESET = 0x4,
 };
-- 
2.53.0

