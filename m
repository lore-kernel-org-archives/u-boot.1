Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080E660A380A
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 11:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=tL/Uap+U;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=edFVNLKg
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D7837607B5;
	Mon, 16 Nov 2026 11:06:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tDO6z9eF0-4G; Mon, 16 Nov 2026 11:06:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E238A60728
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794827209;
	b=lOHFkRI6iNxVAFFghnqht/US+Qt6hAz5ckfbkIpkc0PLfHReZbp9zyOymmwn9dw6xH8D
	 z77mkuj6JTes04VOP7Wr7yjg4NBQ/yJSKvMo6bopoaJizzUa6b0YAKpnpyzwE1yXwyOiQ
	 pwJ3Mab4AsZjq1UOgrUvTq+plgkioPtjV4TgFe/zgDYHa2LfpLjeM7o/cmvxXt3krSxqR
	 5jC0ze99shGOcoZz/WRqMVnERyalq6wCheyDWTft/wetTWTmZr9WJrZ80sekZlSeYpHRS
	 Nz0AE2xnL+Grycj8Bs059U1hFI+yLoF4W9VcXY45EdFpbuX9AHsANwBR284FUAl4qKw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794827209;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-MBO-RS-META:X-MBO-RS-ID:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Kv6mO+GYey3AxW0+880Pw2WMsTwAPDF6LQDUxQbz7BA=;
	b=IU6CXMKlFe6ws4oIZz5sdsW10+YfD5DI2C1hotnxTCRpKLF46y7xN9aEOfG9W6D8OZom
	 NqwRJuea5U5LjdiLedFb1sK4qm6LA7J5w+OuaekoPnLuiJSCTUBDvhxRKjvxf/Komw1tL
	 A1OOdMZEODZ4tXjjf0bmMXoviZxOABbE4pZDi1CPqu+oPRb5atMV4FH13plU7bllSSjSm
	 abviabLKZQ5p8NvCktcrUB3DbwzAJ7NUQ8IxfztEjXNY+KEtn82qNBbTX7es3bZpjRqzk
	 TjS+UaR+1p2rLbfvNfHJBiipMW0NQ1TU3qWYu5VUytn3oL3l8E4mteGFcYeyoP10f3w==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=edFVNLKg;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794827209;
	bh=Kv6mO+GYey3AxW0+880Pw2WMsTwAPDF6LQDUxQbz7BA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tL/Uap+UbkuU2t6604EPN5FXo88HB466F3vl/0jpV7yfkpIqy0diD8qNPuY+c6DfV
	 G7lOH6zZ+yraU8uR7EnCimpbOZYxo1yXu9j7MWIS9UixeDXv/0U96UsSZxo18g9EQT
	 0X3NS9opTMj9N1+/eUMRTD5mc1uN4iQQOmOvfkWWGlrgDZszIsI1j8uCtyy+RGX+E6
	 voI7RG+6lRrkdPrEJREu73/RKth2dLTmlTjInjp/DapH0OI4ddXROMqFRYRyZSSNk6
	 LmNpwPO85RVcswnjZrkPhTiqOISjHH2EVLzUTPWdZf67JHXnxnHT1gUdROTiCMD+AG
	 ouPh9GqJuHRmA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E238A60728;
	Mon, 16 Nov 2026 11:06:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 05FF01A6
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 11:06:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EB9D1607C7
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 11:06:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dyNZUxvSIxmz for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 11:06:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org DD97D60769
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::103"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::103; helo=mout-p-103.mailbox.org;
 envelope-from=marek.vasut+renesas@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=edFVNLKg
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DD97D60769
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 11:06:41 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4jSlRf5QBczKm7b;
 Mon, 16 Nov 2026 12:06:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1794827198;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Kv6mO+GYey3AxW0+880Pw2WMsTwAPDF6LQDUxQbz7BA=;
 b=edFVNLKglQOdQaLQYz8sGGQGEuwfFIwIk3/27GqV7SXJYRmHS1xhNcS/3cDSWnAJQyBRbE
 J/a3FMEsKJRa8Ijvxdoww3hm73EYErRMVr1HzEMGWxC6ZnM1kChJ8z6ZKLuYxzYYIJG5i4
 Aw3B9QdkQ4DSXp1im3/us+hzEfrB2T5RFYhnVQy+RXJ9cng1sGaqTQK620gBIvUWWFq89Z
 7U0OvsrpU30lo9DCMv7/854bs0VhxnwNbyTgJ9wwSIPNGKcJLAA4TN7meSRvpsQS3BBqAK
 +Kt3IwKXAT/OSRcdLCKJycOOfnY3g/zjSqsSG7IHkCDUjuhNuUV+/epjUgq30Q==
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
Subject: [PATCH 6/9] clk: scmi: Export discovery functions
Date: Mon, 16 Nov 2026 12:05:42 +0100
Message-ID: <20261116110615.3394324-6-marek.vasut+renesas@mailbox.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261116110615.3394324-1-marek.vasut+renesas@mailbox.org>
References: <20261116110615.3394324-1-marek.vasut+renesas@mailbox.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: odi7x8aazb7r4g576iinhpjfp5jk8nkc
X-MBO-RS-ID: c81b4e037e071cae66b
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

Make functions to determine SCMI clock protocol clock name, rate,
attributes and permissions available outside of SCMI clock protocol
implementation. Those functions can be invoked from the 'scmi info'
command to print detailed information about the SCMI clock protocol.

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
 drivers/clk/clk_scmi.c   | 18 +++++++++------
 include/scmi_protocols.h | 47 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/clk_scmi.c b/drivers/clk/clk_scmi.c
index 12c7b1e8254..90e34c2128d 100644
--- a/drivers/clk/clk_scmi.c
+++ b/drivers/clk/clk_scmi.c
@@ -26,7 +26,7 @@ struct scmi_clock_priv {
 	u32 version;
 };
 
-static int scmi_clk_get_permissions(struct udevice *dev, int clkid, u32 *perm)
+int scmi_clk_get_permissions(struct udevice *dev, int clkid, u32 *perm)
 {
 	struct scmi_clock_priv *priv = dev_get_priv(dev);
 	int ret;
@@ -67,7 +67,7 @@ static int scmi_clk_get_permissions(struct udevice *dev, int clkid, u32 *perm)
 	return 0;
 }
 
-static int scmi_clk_get_num_clock(struct udevice *dev, size_t *num_clocks)
+int scmi_clk_get_num_clock(struct udevice *dev, size_t *num_clocks)
 {
 	struct scmi_clk_protocol_attr_out out;
 	struct scmi_msg msg = {
@@ -87,8 +87,7 @@ static int scmi_clk_get_num_clock(struct udevice *dev, size_t *num_clocks)
 	return 0;
 }
 
-static int scmi_clk_get_attribute(struct udevice *dev, int clkid, char *name,
-				  u32 *attr)
+int scmi_clk_get_attribute(struct udevice *dev, int clkid, char *name, u32 *attr)
 {
 	struct scmi_clock_priv *priv = dev_get_priv(dev);
 	struct scmi_clk_attribute_in in = {
@@ -262,10 +261,10 @@ static int scmi_clk_disable(struct clk *clk)
 	return 0;
 }
 
-static ulong scmi_clk_get_rate(struct clk *clk)
+ulong scmi_clk_get_rate_id(struct udevice *dev, int id)
 {
 	struct scmi_clk_rate_get_in in = {
-		.clock_id = clk_get_id(clk),
+		.clock_id = id,
 	};
 	struct scmi_clk_rate_get_out out;
 	struct scmi_msg msg = SCMI_MSG_IN(SCMI_PROTOCOL_ID_CLOCK,
@@ -273,7 +272,7 @@ static ulong scmi_clk_get_rate(struct clk *clk)
 					  in, out);
 	int ret;
 
-	ret = devm_scmi_process_msg(clk->dev, &msg);
+	ret = devm_scmi_process_msg(dev, &msg);
 	if (ret < 0)
 		return ret;
 
@@ -284,6 +283,11 @@ static ulong scmi_clk_get_rate(struct clk *clk)
 	return (ulong)(((u64)out.rate_msb << 32) | out.rate_lsb);
 }
 
+static ulong scmi_clk_get_rate(struct clk *clk)
+{
+	return scmi_clk_get_rate_id(clk->dev, clk_get_id(clk));
+}
+
 static ulong __scmi_clk_set_rate(struct clk *clk, ulong rate)
 {
 	struct scmi_clk_rate_set_in in = {
diff --git a/include/scmi_protocols.h b/include/scmi_protocols.h
index 1a58549555d..a50794aceac 100644
--- a/include/scmi_protocols.h
+++ b/include/scmi_protocols.h
@@ -1368,6 +1368,53 @@ enum scmi_config_type {
 	SCMI_PIN_SLEW_RATE = 20,
 };
 
+/**
+ * scmi_clk_get_num_clock - get clock count
+ * @dev: SCMI protocol device
+ * @num_clocks: Number of clocks
+ *
+ * Obtain the number of clocks.
+ *
+ * Return: 0 on success, error code on failure
+ */
+int scmi_clk_get_num_clock(struct udevice *dev, size_t *num_clocks);
+
+/**
+ * scmi_clk_get_attribute - get clock attributes
+ * @dev: SCMI protocol device
+ * @id: SCMI clock ID
+ * @name: SCMI clock name
+ * @attr: SCMI clock attributes
+ *
+ * Obtain the clock name and attributes from SCMI clock ID.
+ *
+ * Return: 0 on success, error code on failure
+ */
+int scmi_clk_get_attribute(struct udevice *dev, int id, char *name, u32 *attr);
+
+/**
+ * scmi_clk_get_permissions - get clock permissions
+ * @dev: SCMI protocol device
+ * @id: SCMI clock ID
+ * @perm: SCMI clock permissions
+ *
+ * Obtain the clock permissions from SCMI clock ID.
+ *
+ * Return: 0 on success, error code on failure
+ */
+int scmi_clk_get_permissions(struct udevice *dev, int id, u32 *perm);
+
+/**
+ * scmi_clk_get_rate_id - get clock rate
+ * @dev: SCMI protocol device
+ * @id: SCMI clock ID
+ *
+ * Obtain the clock rate in Hz from SCMI clock ID.
+ *
+ * Return: clock rate in Hz
+ */
+ulong scmi_clk_get_rate_id(struct udevice *dev, int id);
+
 /**
  * scmi_pinctrl_protocol_attrs - get pinctrl information
  * @dev: SCMI protocol device
-- 
2.53.0

