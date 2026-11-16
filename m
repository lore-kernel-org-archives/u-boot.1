Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37658606FEA4
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 11:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=n3rjiBnK;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=jvSxGnfk
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0949760839;
	Mon, 16 Nov 2026 11:06:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RIBsyn78qQYm; Mon, 16 Nov 2026 11:06:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5A3666081B
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794827214;
	b=cFwsJm+HfkF5CIBNG5F9+NcBwBc+yx4VZWwYkmbR861AMbtAPQAl/N8cMxTma6QLiYXP
	 bFIt5WbNM4Tizug9BaJ5kQNKdkGC1W3ukkkxZ+BmgJZXmRfR/S5izcAW9FqzGYn/tmbAW
	 eCF7Ayzrrh7g8EgBO3IKYh5y708JoWoha7Z0u2cAA1E2Gqu5/3W/WOkd36I9tCqU1WbjN
	 WVsBBEYrAuccDOH1ab/qpOBHnWnf5+389/Xb0+kah8ZCJPzI/hwQF6qUbfGVLfwSNkWQh
	 mavVeD/f72pHnjZ3LNaA5Shyf1PSo7i/7kbPUmBBw3a4yun8aSchxnM7bfbrVO+QIHg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794827214;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-MBO-RS-META:X-MBO-RS-ID:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=88Z0h9afGhgk2F3Pt7Avr8NLe5djWTjs1f4xKRazAP4=;
	b=Tntm6keqSnDhLdcHHElsioF0C+sJqBEs4gjTpR0BkZOqVd1eEzPhswGIyoCwPU7niXzi
	 u2OYOBsd/ijwBU0D2lhkwu9raoFBQxgLrrhM0J7LKb+UcZax/GqDgLf7ufegWGWUMqvdw
	 63Xj2wrTOY8LlxOn2jeXuDx9PVJGxiSgVnoOg7NE9TTOnuaFVnr+mkbYxeGH7ytQYvfoi
	 VQA8I1C3+FpRKYHVGQlmJHdrQtDiB6FP0Gg3swYEldLbT1hJs5YhTjJX1aRTlpngyVbgP
	 HfGgTY5o/96t6Kv9x7DLDOAwXGhkdmCNRvgQn8DE5xZzyYPyWSCUjzKHcfHpk50nGZw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794827214;
	bh=88Z0h9afGhgk2F3Pt7Avr8NLe5djWTjs1f4xKRazAP4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=n3rjiBnKUBOiwW+5oOBYKzoraBLlAp/jv9BBiewS3UPoLjWBrOIPDS7pJsAQyN9Z5
	 9G4utfAYnYaICHanmCLFecdwcdSYijOwOfHpy4EphwizvA1JEe6K/JnKFpQPwAe+pr
	 geFgV79jlxJr3udd40AfDTLlHceOxj2UTpM8E8zZa9IpD9hFyA6q1AUmtzGJci3o4n
	 l8TM/aDQZGUBQeL3OKZWZHjI0bzyMNqLWUB3FP4QK+kEO4S836sLmY+dplWNOREbxZ
	 C8rlwmXQ75RPBXZ3X5WDGIUuzZ7Yxu8wB8YuEJ3HGU4CdmRqtY71+nyqUa6dzvvV6a
	 ZyaJ+7XsZwJuw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5A3666081B;
	Mon, 16 Nov 2026 11:06:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6E5401A6
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 11:06:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6021F40070
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 11:06:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vycmrute1j-x for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 11:06:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org E64B540068
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=80.241.56.171
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=80.241.56.171;
 helo=mout-p-201.mailbox.org; envelope-from=marek.vasut+renesas@mailbox.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=jvSxGnfk
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E64B540068
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 11:06:48 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4jSlRm1K9rzMlZP;
 Mon, 16 Nov 2026 12:06:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1794827204;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=88Z0h9afGhgk2F3Pt7Avr8NLe5djWTjs1f4xKRazAP4=;
 b=jvSxGnfkjECf8N7JK+6q3F6ixCPiq9rXWO4nm+ZDLX3f1Naxzjn9ADSdl2gxBI+Uzc36d2
 Fny3YWlmmgirfSWqMo8TieUNsbA6VlA1bwUSSINxOeYr+XBOhKO24+WCGgLsQV8GzWUEB7
 +++QmR3y36ZgVuITUOgYWQrQZXBYt15XOVcIG7eSoFuyvScQXcB8wVZb7enPUMyO/wQprG
 kNrnEKIedw5mJAGFF2n0UMkYU6aV8tGQgGcm2hYBVlmb2uJolHMpfSk22uodfVb/719XLt
 cvcjLpzy4aNKrtyNNof7DaTai6+tkMQdngbAFJXQdj/nVCkTfOxbPMitQd33Ew==
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
Subject: [PATCH 9/9] cmd: scmi: Add verbose protocol information printing
Date: Mon, 16 Nov 2026 12:05:45 +0100
Message-ID: <20261116110615.3394324-9-marek.vasut+renesas@mailbox.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261116110615.3394324-1-marek.vasut+renesas@mailbox.org>
References: <20261116110615.3394324-1-marek.vasut+renesas@mailbox.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: kmc5aj8phqe5grfrg74cauznaai8bts9
X-MBO-RS-ID: 5f800c17142401bf118
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

Extend the 'scmi info' subcommand with an option -v parameter to print
detailed information about SCMI protocols. Currently supported protocols
are power domain, reset domain, clock and regulator.

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
 cmd/scmi.c     | 272 ++++++++++++++++++++++++++++++++++++++++++++++++-
 test/dm/scmi.c |  87 ++++++++++++++++
 2 files changed, 356 insertions(+), 3 deletions(-)

diff --git a/cmd/scmi.c b/cmd/scmi.c
index 8ab4451cdbd..72549745ffd 100644
--- a/cmd/scmi.c
+++ b/cmd/scmi.c
@@ -100,6 +100,267 @@ static const char *get_proto_name(enum scmi_std_protocol id)
 	return NULL;
 }
 
+/**
+ * print_pwd_proto_details() - print details of SCMI power domain protocol
+ * @proto:	SCMI proto device
+ *
+ * Print SCMI power domain protocol details.
+ */
+static void print_pwd_proto_details(struct udevice *proto)
+{
+	int i, num_pwdoms, ret;
+	size_t stats_len;
+	u64 stats_addr;
+
+	ret = scmi_pwd_protocol_attrs(proto, &num_pwdoms, &stats_addr, &stats_len);
+	if (ret) {
+		printf("          Power domain attributes UNKNOWN (ret=%d)\n", ret);
+		return;
+	}
+
+	printf("          Statistics address: 0x%llx\n", stats_addr);
+	printf("          Statistics length: 0x%zx\n", stats_len);
+	printf("          Number of power domains: %d\n", num_pwdoms);
+
+	for (i = 0; i < num_pwdoms; i++) {
+		u32 attributes;
+		u8 *name;
+
+		ret = scmi_pwd_attrs(proto, i, &attributes, &name);
+		if (ret) {
+			printf("          %8d: UNKNOWN (ret=%d)\n", i, ret);
+			continue;
+		}
+
+		printf("          %8d: Name: %s\n", i, name);
+		free(name);
+
+		printf("                    Attributes: 0x%08x\n", attributes);
+
+		if (attributes & BIT(27)) {
+			printf("                    - bit 27: Extended power domain name\n");
+			ret = scmi_pwd_name_get(proto, i, &name);
+			if (ret) {
+				printf("                      Name UNKNOWN (ret=%d)\n", ret);
+			} else {
+				printf("                      Name: %s\n", name);
+				free(name);
+			}
+		}
+		if (attributes & BIT(28))
+			printf("                    - bit 28: Power state change requested notification support\n");
+		if (attributes & BIT(29))
+			printf("                    - bit 29: Power state synchronous support\n");
+		if (attributes & BIT(30))
+			printf("                    - bit 30: Power state asynchronous support\n");
+		if (attributes & BIT(31))
+			printf("                    - bit 31: Power state change notification support\n");
+	}
+}
+
+/**
+ * print_clock_proto_details() - print details of SCMI clock protocol
+ * @proto:	SCMI proto device
+ *
+ * Print SCMI clock protocol details.
+ */
+static void print_clock_proto_details(struct udevice *proto)
+{
+	size_t i, num_clocks;
+	int ret;
+
+	ret = scmi_clk_get_num_clock(proto, &num_clocks);
+	if (ret)
+		return;
+
+	printf("          Number of clocks: %zu\n", num_clocks);
+
+	for (i = 0; i < num_clocks; i++) {
+		char name[SCMI_CLOCK_NAME_LENGTH_MAX];
+		u32 attributes, perm;
+
+		ret = scmi_clk_get_attribute(proto, i, name, &attributes);
+		if (ret) {
+			printf("          %8zu: UNKNOWN (ret=%d)\n", i, ret);
+			continue;
+		}
+
+		printf("          %8zu: Name: %s\n", i, name);
+		printf("                    Rate: %ld Hz\n", scmi_clk_get_rate_id(proto, i));
+		printf("                    Attributes: 0x%08x\n", attributes);
+
+		if (attributes & BIT(0))
+			printf("                    - bit 0: Enabled\n");
+		if (attributes & BIT(1)) {
+			printf("                    - bit 1: Restricted\n");
+			ret = scmi_clk_get_permissions(proto, i, &perm);
+			if (ret) {
+				printf("                      Permissions UNKNOWN (ret=%d)\n", ret);
+			} else {
+				printf("                      Permissions: 0x%08x\n", perm);
+				if (perm & SUPPORT_CLK_RATE_CONTROL)
+					printf("                      - bit 29: Clock rate control\n");
+				if (perm & SUPPORT_CLK_PARENT_CONTROL)
+					printf("                      - bit 30: Clock parent control\n");
+				if (perm & SUPPORT_CLK_STAT_CONTROL)
+					printf("                      - bit 31: Clock state control\n");
+			}
+		}
+		if (attributes & BIT(27))
+			printf("                    - bit 27: Extended configuration support\n");
+		if (attributes & BIT(28))
+			printf("                    - bit 28: Parent clock identifier support\n");
+		if (attributes & BIT(29))
+			printf("                    - bit 29: Extended clock name\n");
+		if (attributes & BIT(30))
+			printf("                    - bit 30: Clock rate change requested notification support\n");
+		if (attributes & BIT(31))
+			printf("                    - bit 31: Clock rate change notification support\n");
+	}
+}
+
+/**
+ * print_rd_proto_details() - print details of SCMI reset domain protocol
+ * @proto:	SCMI proto device
+ *
+ * Print SCMI reset domain protocol details.
+ */
+#ifdef CONFIG_RESET_SCMI
+static void print_rd_proto_details(struct udevice *proto)
+{
+	int i, num_rddoms, ret;
+
+	ret = scmi_reset_protocol_attrs(proto, &num_rddoms);
+	if (ret) {
+		printf("          Reset domain attributes UNKNOWN (ret=%d)\n", ret);
+		return;
+	}
+
+	printf("          Number of reset domains: %d\n", num_rddoms);
+
+	for (i = 0; i < num_rddoms; i++) {
+		u32 attributes, latency;
+		u8 *name;
+
+		ret = scmi_reset_attrs(proto, i, &attributes, &latency, &name);
+		if (ret) {
+			printf("          %8d: UNKNOWN (ret=%d)\n", i, ret);
+			continue;
+		}
+
+		printf("          %8d: Name: %s\n", i, name);
+		free(name);
+
+		printf("                    Latency: %d us\n", latency);
+		printf("                    Attributes: 0x%08x\n", attributes);
+
+		if (attributes & BIT(29))
+			printf("                    - bit 29: Extended reset domain name\n");
+		if (attributes & BIT(30))
+			printf("                    - bit 30: Reset notification support\n");
+		if (attributes & BIT(31))
+			printf("                    - bit 31: Asynchronous reset support\n");
+	}
+}
+#else
+static void print_rd_proto_details(struct udevice *proto) { }
+#endif
+
+/**
+ * print_voltd_proto_details() - print details of SCMI voltd domain protocol
+ * @proto:	SCMI proto device
+ *
+ * Print SCMI voltd domain protocol details.
+ */
+#ifdef CONFIG_DM_REGULATOR_SCMI
+static void print_voltd_proto_details(struct udevice *proto)
+{
+	int i, num_voltdoms, ret;
+
+	ret = scmi_voltd_protocol_attrs(proto, &num_voltdoms);
+	if (ret) {
+		printf("          Reset domain attributes UNKNOWN (ret=%d)\n", ret);
+		return;
+	}
+
+	printf("          Number of voltd domains: %d\n", num_voltdoms);
+
+	for (i = 0; i < num_voltdoms; i++) {
+		u32 attributes;
+		u8 *name;
+
+		ret = scmi_voltd_attrs(proto, i, &attributes, &name);
+		if (ret) {
+			printf("          %8d: UNKNOWN (ret=%d)\n", i, ret);
+			continue;
+		}
+
+		printf("          %8d: Name: %s\n", i, name);
+		free(name);
+
+		printf("                    Attributes: 0x%08x\n", attributes);
+
+		if (attributes & BIT(30))
+			printf("                    - bit 30: Extended voltage domain name\n");
+		if (attributes & BIT(31))
+			printf("                    - bit 31: Asynchronous voltage level set support\n");
+	}
+}
+#else
+static void print_voltd_proto_details(struct udevice *proto) { };
+#endif
+
+/**
+ * print_proto_details() - print details of SCMI protocol
+ * @agent:	SCMI agent device
+ * @id:		SCMI Protocol ID
+ * @verbose:	Print verbose details of each protocol
+ *
+ * Print SCMI protocol details. By default, print only the
+ * protocol name. In case verbose printing is requested,
+ * print as much information about each protocol as possible.
+ */
+static void print_proto_details(struct udevice *agent,
+				enum scmi_std_protocol id,
+				const bool verbose)
+{
+	struct udevice *proto;
+	u32 version;
+	int ret;
+
+	printf("      %s\n", get_proto_name(id));
+
+	if (!verbose)
+		return;
+
+	proto = scmi_get_protocol(agent, id);
+	if (!proto) {
+		printf("          SCMI protocol 0x%x not found\n", id);
+		return;
+	}
+
+	ret = scmi_generic_protocol_version(proto, id, &version);
+	if (!ret)
+		printf("          Version: 0x%08x\n", version);
+
+	switch (id) {
+	case SCMI_PROTOCOL_ID_POWER_DOMAIN:
+		print_pwd_proto_details(proto);
+		break;
+	case SCMI_PROTOCOL_ID_CLOCK:
+		print_clock_proto_details(proto);
+		break;
+	case SCMI_PROTOCOL_ID_RESET_DOMAIN:
+		print_rd_proto_details(proto);
+		break;
+	case SCMI_PROTOCOL_ID_VOLTAGE_DOMAIN:
+		print_voltd_proto_details(proto);
+		break;
+	default:
+		break;
+	}
+}
+
 /**
  * do_scmi_info() - get the information of SCMI services
  *
@@ -119,11 +380,15 @@ static int do_scmi_info(struct cmd_tbl *cmdtp, int flag, int argc,
 	struct udevice *agent, *base_proto;
 	u32 agent_id, num_protocols;
 	u8 *agent_name, *protocols;
+	bool verbose = false;
 	int i, ret;
 
-	if (argc != 1)
+	if (argc != 1 && argc != 2)
 		return CMD_RET_USAGE;
 
+	if (argc == 2)
+		verbose = true;
+
 	agent = get_agent();
 	if (!agent)
 		return CMD_RET_FAILURE;
@@ -152,7 +417,7 @@ static int do_scmi_info(struct cmd_tbl *cmdtp, int flag, int argc,
 	protocols = scmi_protocols(agent);
 	if (protocols)
 		for (i = 0; i < num_protocols; i++)
-			printf("      %s\n", get_proto_name(protocols[i]));
+			print_proto_details(agent, protocols[i], verbose);
 	printf("  vendor: %s\n", scmi_vendor(agent));
 	printf("  sub vendor: %s\n", scmi_sub_vendor(agent));
 	printf("  impl version: 0x%x\n", scmi_impl_version(agent));
@@ -377,7 +642,8 @@ static int do_scmi(struct cmd_tbl *cmdtp, int flag,
 
 U_BOOT_LONGHELP(scmi,
 	" - SCMI utility\n"
-	" info - get the info of SCMI services\n"
+	" info [-v] - get the info of SCMI services\n"
+	"   - -v ... print verbose information\n"
 	" perm_dev <agent-id in hex> <device-id in hex> <flags in hex>\n"
 	"   - set access permission to device\n"
 	" perm_proto <agent-id in hex> <device-id in hex> <protocol-id in hex> <flags in hex>\n"
diff --git a/test/dm/scmi.c b/test/dm/scmi.c
index 3655594c26d..9e0b70a24b9 100644
--- a/test/dm/scmi.c
+++ b/test/dm/scmi.c
@@ -258,6 +258,93 @@ static int dm_test_scmi_cmd(struct unit_test_state *uts)
 
 	ut_assert_console_end();
 
+	/* scmi info */
+	ut_assertok(run_command("scmi info -v", 0));
+
+	ut_assert_nextline("SCMI device: scmi");
+	snprintf(cmd_out, 30, "  protocol version: 0x%x",
+		 SCMI_BASE_PROTOCOL_VERSION);
+	ut_assert_nextline(cmd_out);
+	ut_assert_nextline("  # of agents: 2");
+	ut_assert_nextline("      0: platform");
+	ut_assert_nextline("    > 1: OSPM");
+	snprintf(cmd_out, 30, "  # of protocols: %d", num_proto);
+	ut_assert_nextline(cmd_out);
+	if (CONFIG_IS_ENABLED(SCMI_POWER_DOMAIN)) {
+		ut_assert_nextline("      Power domain management");
+		ut_assert_nextline("          Version: 0x00030000");
+		ut_assert_nextline("          Statistics address: 0x0");
+		ut_assert_nextline("          Statistics length: 0x0");
+		ut_assert_nextline("          Number of power domains: 3");
+		ut_assert_nextline("                 0: Name: power-domain--0");
+		ut_assert_nextline("                    Attributes: 0x28000000");
+		ut_assert_nextline("                    - bit 27: Extended power domain name");
+		ut_assert_nextline("                      Name: power-domain--0-extended");
+		ut_assert_nextline("                    - bit 29: Power state synchronous support");
+		ut_assert_nextline("                 1: Name: power-domain--1");
+		ut_assert_nextline("                    Attributes: 0x28000000");
+		ut_assert_nextline("                    - bit 27: Extended power domain name");
+		ut_assert_nextline("                      Name: power-domain--1-extended");
+		ut_assert_nextline("                    - bit 29: Power state synchronous support");
+		ut_assert_nextline("                 2: Name: power-domain--2");
+		ut_assert_nextline("                    Attributes: 0x28000000");
+		ut_assert_nextline("                    - bit 27: Extended power domain name");
+		ut_assert_nextline("                      Name: power-domain--2-extended");
+		ut_assert_nextline("                    - bit 29: Power state synchronous support");
+	}
+	if (CONFIG_IS_ENABLED(CLK_SCMI)) {
+		ut_assert_nextline("      Clock management");
+		ut_assert_nextline("          Version: 0x00030000");
+		ut_assert_nextline("          Number of clocks: 3");
+		ut_assert_nextline("                 0: Name: clk0");
+		ut_assert_nextline("                    Rate: 333 Hz");
+		ut_assert_nextline("                    Attributes: 0x00000002");
+		ut_assert_nextline("                    - bit 1: Restricted");
+		ut_assert_nextline("                      Permissions: 0xe0000000");
+		ut_assert_nextline("                      - bit 29: Clock rate control");
+		ut_assert_nextline("                      - bit 30: Clock parent control");
+		ut_assert_nextline("                      - bit 31: Clock state control");
+		ut_assert_nextline("                 1: Name: clk1");
+		ut_assert_nextline("                    Rate: 200 Hz");
+		ut_assert_nextline("                    Attributes: 0x00000002");
+		ut_assert_nextline("                    - bit 1: Restricted");
+		ut_assert_nextline("                      Permissions: 0xe0000000");
+		ut_assert_nextline("                      - bit 29: Clock rate control");
+		ut_assert_nextline("                      - bit 30: Clock parent control");
+		ut_assert_nextline("                      - bit 31: Clock state control");
+		ut_assert_nextline("                 2: Name: clk2");
+		ut_assert_nextline("                    Rate: 1000 Hz");
+		ut_assert_nextline("                    Attributes: 0x00000002");
+		ut_assert_nextline("                    - bit 1: Restricted");
+		ut_assert_nextline("                      Permissions: 0xe0000000");
+		ut_assert_nextline("                      - bit 29: Clock rate control");
+		ut_assert_nextline("                      - bit 30: Clock parent control");
+		ut_assert_nextline("                      - bit 31: Clock state control");
+
+	}
+	if (CONFIG_IS_ENABLED(RESET_SCMI)) {
+		ut_assert_nextline("      Reset domain management");
+		ut_assert_nextline("          Version: 0x00030000");
+		ut_assert_nextline("          Number of reset domains: 1");
+		ut_assert_nextline("                 0: Name: rd0");
+		ut_assert_nextline("                    Latency: 0 us");
+		ut_assert_nextline("                    Attributes: 0x00000000");
+	}
+	if (CONFIG_IS_ENABLED(DM_REGULATOR_SCMI)) {
+		ut_assert_nextline("      Voltage domain management");
+		ut_assert_nextline("          Version: 0x00030000");
+		ut_assert_nextline("          Number of voltd domains: 2");
+		ut_assert_nextline("                 0: Name: regu0");
+		ut_assert_nextline("                    Attributes: 0x00000000");
+		ut_assert_nextline("                 1: Name: regu1");
+		ut_assert_nextline("                    Attributes: 0x00000000");
+	}
+	ut_assert_nextline("  vendor: U-Boot");
+	ut_assert_nextline("  sub vendor: Sandbox");
+	ut_assert_nextline("  impl version: 0x1");
+
+	ut_assert_console_end();
+
 	/* scmi perm_dev */
 	ut_assertok(run_command("scmi perm_dev 1 0 1", 0));
 	ut_assert_console_end();
-- 
2.53.0

