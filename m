Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F368BC5AD55
	for <u-boot@archiver.kernel.org>; Mon, 10 Aug 2026 22:36:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 328A640730;
	Mon, 10 Aug 2026 22:36:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DSAVNhAMkszE; Mon, 10 Aug 2026 22:36:23 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9025640718
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786401383;
	bh=yVlF+PDX/JFgjzWDkwMoBS3oyA+HCrOs98bLMTPSJ7A=;
	h=To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=oNWdigVc9V07Lo3FyGvGUYp5qSyvmZo1v2qDsMCLJRq5W4SeF6fxbZJFTMJbbTSKR
	 xa+0AiXSGT6VHf1GuZ4m7zfLQvJDCO2n3Kzgv3FNtEUQiKxLhMwrHvz5/dfLOvoh/L
	 lQ8y6RY1Upv7BJf9bPs/OtBqke3Za4eNPDgoLCI8vlwMS7WcD/NXatijX7R3HxeNph
	 DgO+dcJdyZ7Y/ZTpldyaWZHrWV25cbKJhP0kfqGOuDSX1h1S5VCtktacKv3wFS6GfJ
	 w0C5JYIzpSfxnBDYW5VMm4te1XI2W+GL54ku0a79FAW2bt2HiNvvbA7o02VnBS+ly2
	 x1sImrX5el4wg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9025640718;
	Mon, 10 Aug 2026 22:36:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id D8B8810E
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 22:36:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CA31780DF8
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 22:36:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ncJeOZD23jiV for <u-boot@lists.u-boot-project.org>;
 Mon, 10 Aug 2026 22:36:18 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::201; helo=mout-p-201.mailbox.org;
 envelope-from=marek.vasut+renesas@mailbox.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org C3CF980CD3
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C3CF980CD3
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C3CF980CD3
 for <u-boot@lists.u-boot-project.org>; Mon, 10 Aug 2026 22:36:17 +0000 (UTC)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4hJqNb5xfQzMlGL;
 Tue, 11 Aug 2026 00:36:15 +0200 (CEST)
To: u-boot@lists.u-boot-project.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 6/6] remoteproc: renesas: rsip: Implement core status
Date: Tue, 11 Aug 2026 00:35:07 +0200
Message-ID: <20260810223604.1333043-6-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260810223604.1333043-1-marek.vasut+renesas@mailbox.org>
References: <20260810223604.1333043-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: c4c1236f11026ad3bf3
X-MBO-RS-META: 3w3qq9y4qfqw47jyio5jhguu39hc55gc
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1786401375;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yVlF+PDX/JFgjzWDkwMoBS3oyA+HCrOs98bLMTPSJ7A=;
 b=Lz9D5aHnX4Dcks+fdxuIJ+dlPoobJbBLB4AYDxvjPvX31BVb8pfHaUyKPNauolb5NW0zwu
 INV3twiwFdnQg9kEYGwYAJXUrgxoe7tKefSR1vZbIN5rOCoCiQF11c9RQBNYeNipZZHNXu
 PJL3ZIIy8w7HLwuW6MTdOM+/u/cvOjLFjkxyxc39bNyGzRsPDte/yD4qACGW7uhR348phz
 UH/mnyxc+9x5q2wOvwJAFUmgSzkGElWcK6aSppEeq1pJX+y4QCJo1GkTfLPxt+iW/MYLGV
 XQtQqpbMnNTCsPCBwKpTTIDGqxtygimIgHQ3j1EBnaKzTcORTo75htayt8yeqA==
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailbox.org; s=mail20150812; 
 t=1786401374;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yVlF+PDX/JFgjzWDkwMoBS3oyA+HCrOs98bLMTPSJ7A=;
 b=EcJQhdG481wUUMxFTHF9LhcxoqZPwoqlpujK6BZ3lEMNpR+1ZlCL0FaIgcoZmCo8SZU2mO
 IjUE7y7q5RIqNVQsQibduid7Xla1nt3uAv6Bo6/SIBFAEpM3vYsFJpdu3s7+gJ32c1JM4+
 z4V6okYMwwSLPBWtpD7fYNl6b5Wna0S54AP0ofaOR9QMsZfshY3K2Ih8CvDer+bBYXBDS5
 P4FJJmo7bOaonPUjpykkCRs12jVXEmAEHyJ7+E+6yFORmxEmRVTM8cqxLYigg2bStep0v3
 07XDDEP2tvlHFEEvcNE+u4VWrSnBvjOCAPen+00dWpH5WivBmnqyTnnWWFn/3w==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=mailbox.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=mailbox.org
 header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812
 header.b=Lz9D5aHn; 
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=EcJQhdG4
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
From: Marek Vasut via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Currently the driver can not report core status. Determine SCP core
state via SCP_CPUWAIT_WAIT bit and use SCMI PD protocol POWER_STATE_GET
call to determine CR52 and CA720AE core state. Report the core states.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
---
 drivers/remoteproc/renesas_rsip.c | 58 +++++++++++++++++++++++++++++--
 1 file changed, 56 insertions(+), 2 deletions(-)

diff --git a/drivers/remoteproc/renesas_rsip.c b/drivers/remoteproc/renesas_rsip.c
index 7c2643e9728..c71424a2c16 100644
--- a/drivers/remoteproc/renesas_rsip.c
+++ b/drivers/remoteproc/renesas_rsip.c
@@ -102,6 +102,7 @@ static void scp_send_interrupt(void)
 #define SCMI_PD_POWER_STATE_SET_BOOTADDR	0x4411
 #define SCMI_PD_POWER_STATE_SET_STATE_ON	0
 #define SCMI_PD_POWER_STATE_SET_STATE_OFF	BIT(30)
+#define SCMI_PD_POWER_STATE_GET			0x4405
 
 /**
  * scp_cpu_core_id_to_domain() - Convert core ID to SCMI domain ID
@@ -173,6 +174,52 @@ static int scp_cpu_core_set(const u32 core, const u32 ep, const u32 state)
 	return 0;
 }
 
+/**
+ * scp_cpu_core_get() - Get CPU core state by invoking SCP via SCMI
+ * @core: CPU core to get
+ */
+static int scp_cpu_core_get(const u32 core)
+{
+	struct scp_scmi_shmem *shmem = (struct scp_scmi_shmem *)SCP_SCMI_SHMEM_AREA09;
+	u32 status, pwr;
+	u32 domain_id;	/* Core ID */
+	int ret;
+
+	ret = scp_cpu_core_id_to_domain(core, &domain_id);
+	if (ret)
+		return ret;
+
+	/* Wait for SCP to be free, then set it busy */
+	scp_wait_fw_free();
+	shmem->status &= ~SCP_SCMI_STATUS_FREE;
+	shmem->flags = 0;
+
+	/* Set up the message and copy it to SHMEM */
+	shmem->message_header = SCMI_PD_POWER_STATE_GET;
+	memcpy(shmem->payload, &domain_id, sizeof(domain_id));
+	shmem->length = sizeof(shmem->message_header) + sizeof(domain_id);
+
+	/* Send message to SCP and wait for completion */
+	scp_send_interrupt();
+	scp_wait_fw_free();
+
+	/* Read back the result */
+	status = readl((uintptr_t)shmem->payload);
+	if (status) {
+		printf("SCP POWER_STATE_GET domain %d failed, status=0x%x (%d)\n",
+		       domain_id, status, status);
+		return -EINVAL;
+	}
+
+	pwr = readl((uintptr_t)(shmem->payload + 4));
+	if (pwr == SCMI_PD_POWER_STATE_SET_STATE_ON)
+		return 0;
+	else if (pwr == SCMI_PD_POWER_STATE_SET_STATE_OFF)
+		return 1;
+	else
+		return -EINVAL;
+}
+
 /**
  * struct renesas_rsip_rproc_privdata - remote processor private data
  * @core_id:		CPU core id
@@ -301,8 +348,15 @@ static int renesas_rsip_rproc_reset(struct udevice *dev)
  */
 static int renesas_rsip_rproc_is_running(struct udevice *dev)
 {
-	/* We assume the core is stopped. */
-	return 1;
+	struct renesas_rsip_rproc_privdata *priv = dev_get_priv(dev);
+
+	if (priv->core_id == 0) {
+		/* SCP */
+		return readl(SCP_CPUWAIT) & SCP_CPUWAIT_WAIT;
+	} else {
+		/* CR52 or CA720 */
+		return scp_cpu_core_get(priv->core_id);
+	}
 }
 
 /**
-- 
2.53.0

