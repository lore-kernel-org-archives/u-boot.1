Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83B6CC98314
	for <u-boot@archiver.kernel.org>; Thu, 24 Sep 2026 12:36:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0EDA34074E;
	Thu, 24 Sep 2026 12:36:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lsyNL3aav3Wk; Thu, 24 Sep 2026 12:36:04 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 2F0A7406F1
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790253364;
	b=fZR3Y+LGszSCDth9e8jxsViUV9c6Qvou18kLDwqMrDxBnf7ZY8HaSdwsitqErj9RFGkX
	 2seG6j8HQnRCgSMKWWI5W7a/Uts4SQD2fzoNUd2nyru+5jqzxVSnoQcLgZc5M9aAiE9h8
	 cKxveljiG/YNjrvq8UyXfnv9+5BtG7QRG+nyuVHFAgbGDdsWIZ/SXBaiPRZgreJNyZzyG
	 +xfgstFo5u3Y/aOp+NuSLRH2J4I2D4PmaTuxcnB8euf4VbopQy8zs6MK0eUWjfy1P3CBZ
	 4p4kBMaM2YnpdekLDdQhNGjuRfS+4Nxt168x+l+lZ8SNNvjR/x0pngn5SbHbhqP4DRg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790253364;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=HneI6EKpvurenaBcGtqr56JdKw6++H0Uuv/8s71lCjE=;
	b=g5OxnZGCbEMkCwUIh2elClgmxOJp4SXt9T2usfeIIKlhg9fX7f5bQFwDw2H0uMrAv8QE
	 eOa79o3M2y6yPJaoEfM7rP5qShxcsFWleQRbhCLn/NT/HB0yB8Pi08xNd6XDm/WVqfmyX
	 ijuvgCncwSzYWtTuf9+tsCohFyIjD7XvzRQYgkprDqrojvfy6SzMnvh7cBMRnbJGDbHP3
	 ZiMVrpgyKFXOvFEzn19KGozaQhbwdqBs+5zSRqfZtETZODCiUyPMswOBIG2JNUpKvqw2S
	 OeQseZYdfvwyPTwipeyzklE9qcMxcioc2P8Oj9o8U/brnyGoKarRTRhruyp6X66FKKQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790253364;
	bh=HneI6EKpvurenaBcGtqr56JdKw6++H0Uuv/8s71lCjE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=1QAJsDV3I/Zbut5bRPzfUWQsTE40cWtmZIywCdflWyjRjSk3F5aRu9wseP539ZY/E
	 93JpwBLxQo9MRZuiHeehvRNRp6GUPTyCrPUFyysulDtPEeLbGEHkjVxJEfVzJeGNmz
	 6DRTJycv5kr8xk1UYqpI/aEwHAoQlf3EQ7PiSN7jqZvZokUHUCE6L2XQVwr792lDqX
	 EjJgL1jUJRh9o6ODk8ZmlAs4mZrQpm6bSw9ePOctyf32E6k6q0ECLGLJnX978tpTEv
	 9huo7YDZyGzAJF+5KLajog0Qi8Mmv2hebRXBiAPIxSL3CH5oWnOZNUAHn7AzYxeawr
	 KJFZN1YI8t8gw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2F0A7406F1;
	Thu, 24 Sep 2026 12:36:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 450DE194
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 12:36:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 36B8540456
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 12:36:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Sc8fXHwvazO8 for <u-boot@lists.u-boot-project.org>;
 Thu, 24 Sep 2026 12:36:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 7FCE2400FB
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790253361;
 b=pMXVvFpGb1nfIE3FAKjnx19pwGfkcbLECM83bVbsCxnhSne+yrREqRvS/b1BxJCvjsvM
 B7FisROQOF8/fg/x+mdN7r/qetL2BGTHSSMGtStsshTsbvxR29RS49rfFGEqSP4sllTmH
 hBVTCO5wfro/BWdzVoAZBJtvCudV0Zqjsyaq+x+quf6LcBOD2IqyT3NFTthM1rwQnO1IN
 oA+V6kHH0Du3/3ZW6qo/LOBq2olOH9x+pPCPjwlIc4/+jfruJORey8aBjkCQh9QNJE4c+
 hHUivmkokGiOL6nK98u4OM1cck4mjJKeZp5JbDw5E5zDJODMu8ittfzPn76Y6RVGOIg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790253361;
 h=Received-SPF:Received:Received:Received:DKIM-Signature:From:To:Cc:
 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
 bh=HneI6EKpvurenaBcGtqr56JdKw6++H0Uuv/8s71lCjE=;
 b=BnmHxBJYb12loWc2yI79uQqlV0SdVnzhIQ4dys4wLpixS366OCzJBbEkib5vKrLObKse
 N2U6Wjj81o//YTSQxrPyz72v7BObBOutjlH2RZB/v3ybks9HClR+scRz7l2tDUNs0d3sB
 ocLzIyd7XlnaQX61AXRDLu9h4BKgfyD1va6hl7N7VvNpdCSns0g+768Nfs0WI0Vh3pbJl
 a6dgQF9R7KJ21NtbzhzGNzat73llfCORtbYWle4p0mQUaddZNXgyVCS1WSm5wO4ZRP70s
 ZOp9xkJIc5oZemIk7fxZ015ur0BPCkgyyA+ehB27R9/9wgx80KM8Cx4ozm1SZIbch1A==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=bootlin.com; 
 dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=tFmPTObA; 
 arc=none smtp.remote-ip=185.246.85.4
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.246.85.4;
 helo=smtpout-03.galae.net; envelope-from=richard.genoud@bootlin.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=dkim header.b=tFmPTObA
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7FCE2400FB
 for <u-boot@lists.u-boot-project.org>; Thu, 24 Sep 2026 12:36:00 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 78A0C4E41059;
 Thu, 24 Sep 2026 12:35:58 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 4B88860341;
 Thu, 24 Sep 2026 12:35:58 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 17D841032917D; 
 Thu, 24 Sep 2026 14:35:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1790253353; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding:in-reply-to:references;
 bh=HneI6EKpvurenaBcGtqr56JdKw6++H0Uuv/8s71lCjE=;
 b=tFmPTObAeLEHVQjyIo6O5SmdhD+J6kVJUUJTQm6/WLdKKVeIOqVJMTnEZJdupYKwJHYJx9
 cn5UIWY7/0AzQILxiqtisZ7wak4pgNiUsrGr7aC3U1zZLuH0o5+d0RTyWneze2So7r55Lb
 ReCZ1Q28qVrt0o+ICnT8xH6LAV+u6RkYRAi/rSE6D+ryI/wq9RSQ6ssX9ONK6Cseog8JTi
 iCm7i11lRukFiies7FC2BJf6uZvJ9uYwuG2ikna1P04fZ6Gv78VH/0Gr8SPCE0RNAEL4OQ
 3Zh9CZSFnA2n9dCNVVzLV6pCB79daESAzaextbGG0bzaIoYwkm6TByudvsipkg==
From: "Richard Genoud (TI)" <richard.genoud@bootlin.com>
To: Tom Rini <trini@konsulko.com>, Manorit Chawdhry <m-chawdhry@ti.com>,
 "Andrew F . Davis" <afd@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Bryan Brattlof <bb@ti.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: Markus Schneider-Pargmann <msp@baylibre.com>,
 Kendall Willis <k-willis@ti.com>, Udit Kumar <u-kumar1@ti.com>,
 Abhash Kumar <a-kumar2@ti.com>,
 Thomas Richard <thomas.richard@bootlin.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Richard Genoud <richard.genoud@bootlin.com>,
 u-boot@lists.u-boot-project.org
Subject: [PATCH v6 02/22] firmware: ti_sci: Add TI_SCI_MSG_MIN_CONTEXT_RESTORE
Date: Thu, 24 Sep 2026 14:35:13 +0200
Message-ID: <20260924123533.2599438-3-richard.genoud@bootlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924123533.2599438-1-richard.genoud@bootlin.com>
References: <20260924123533.2599438-1-richard.genoud@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: "Markus Schneider-Pargmann (TI)" <msp@baylibre.com>

This patch adds code to be able to call TI_SCI_MSG_MIN_CONTEXT_RESTORE.
The context needs to be restored after booting SPL when resuming from
IO+DDR.

Signed-off-by: Markus Schneider-Pargmann (TI) <msp@baylibre.com>
---
 drivers/firmware/ti_sci.c              | 38 ++++++++++++++++++++++++++
 drivers/firmware/ti_sci.h              | 16 +++++++++++
 include/linux/soc/ti/ti_sci_protocol.h |  9 ++++++
 3 files changed, 63 insertions(+)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index 0f5e180e9e94..c015bd3cc245 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -2710,6 +2710,41 @@ static int ti_sci_cmd_change_fwl_owner(const struct ti_sci_handle *handle,
 	return ret;
 }
 
+static int ti_sci_cmd_min_context_restore(const struct ti_sci_handle *handle, u64 ctx_addr)
+{
+	struct ti_sci_msg_min_restore_context_req req;
+	struct ti_sci_msg_hdr *resp;
+	struct ti_sci_info *info;
+	struct ti_sci_xfer *xfer;
+	int ret = 0;
+
+	if (IS_ERR(handle))
+		return PTR_ERR(handle);
+	if (!handle)
+		return -EINVAL;
+
+	info = handle_to_ti_sci_info(handle);
+
+	xfer = ti_sci_setup_one_xfer(info, TI_SCI_MSG_MIN_CONTEXT_RESTORE,
+				     TI_SCI_FLAG_REQ_ACK_ON_PROCESSED,
+				     (u32 *)&req, sizeof(req), sizeof(*resp));
+	if (IS_ERR(xfer)) {
+		ret = PTR_ERR(xfer);
+		return ret;
+	}
+
+	req.ctx_lo = (u32)(ctx_addr & 0xffffffff);
+	req.ctx_hi = (u32)(ctx_addr >> 32);
+
+	ret = ti_sci_do_xfer(info, xfer);
+	if (ret) {
+		dev_err(info->dev, "Failed restoring context %d\n", ret);
+		return ret;
+	}
+
+	return ret;
+}
+
 /*
  * ti_sci_setup_ops() - Setup the operations structures
  * @info:	pointer to TISCI pointer
@@ -2728,6 +2763,7 @@ static void ti_sci_setup_ops(struct ti_sci_info *info)
 	struct ti_sci_rm_psil_ops *psilops = &ops->rm_psil_ops;
 	struct ti_sci_rm_udmap_ops *udmap_ops = &ops->rm_udmap_ops;
 	struct ti_sci_fwl_ops *fwl_ops = &ops->fwl_ops;
+	struct ti_sci_lpm_ops *lpm_ops = &ops->lpm_ops;
 
 	bops->board_config = ti_sci_cmd_set_board_config;
 	bops->board_config_rm = ti_sci_cmd_set_board_config_rm;
@@ -2795,6 +2831,8 @@ static void ti_sci_setup_ops(struct ti_sci_info *info)
 
 	fw_ops->get_dm_version = ti_sci_cmd_get_dm_version;
 	fw_ops->query_dm_cap = ti_sci_cmd_query_dm_cap;
+
+	lpm_ops->min_context_restore = ti_sci_cmd_min_context_restore;
 }
 
 /**
diff --git a/drivers/firmware/ti_sci.h b/drivers/firmware/ti_sci.h
index ce50bf6800eb..68908c6c8c46 100644
--- a/drivers/firmware/ti_sci.h
+++ b/drivers/firmware/ti_sci.h
@@ -45,6 +45,9 @@
 #define TI_SCI_MSG_QUERY_CLOCK_FREQ	0x010d
 #define TI_SCI_MSG_GET_CLOCK_FREQ	0x010e
 
+/* Low Power Mode Requests */
+#define TI_SCI_MSG_MIN_CONTEXT_RESTORE	0x0308
+
 /* Processor Control Messages */
 #define TISCI_MSG_PROC_REQUEST		0xc000
 #define TISCI_MSG_PROC_RELEASE		0xc001
@@ -1572,4 +1575,17 @@ struct ti_sci_msg_fwl_change_owner_info_resp {
 	u16			owner_permission_bits;
 } __packed;
 
+/**
+ * struct ti_sci_msg_min_restore_context_req - Request to restore context from DDR
+ *
+ * @hdr:		Generic Header
+ * @ctx_lo		Low 32-bits of physical pointer to address to use for context restore.
+ * @ctx_hi		High 32-bits of physical pointer to address to use for context restore.
+ */
+struct ti_sci_msg_min_restore_context_req {
+	struct ti_sci_msg_hdr	hdr;
+	u32			ctx_lo;
+	u32			ctx_hi;
+} __packed;
+
 #endif /* __TI_SCI_H */
diff --git a/include/linux/soc/ti/ti_sci_protocol.h b/include/linux/soc/ti/ti_sci_protocol.h
index 52696763ecf6..6b1dd801f5f8 100644
--- a/include/linux/soc/ti/ti_sci_protocol.h
+++ b/include/linux/soc/ti/ti_sci_protocol.h
@@ -632,6 +632,14 @@ struct ti_sci_fwl_ops {
 	int (*change_fwl_owner)(const struct ti_sci_handle *handle, struct ti_sci_msg_fwl_owner *owner);
 };
 
+/**
+ * struct ti_sci_lpm_ops - Low Power Mode operations
+ * @min_context_restore: Request restoring context from DDR.
+ */
+struct ti_sci_lpm_ops {
+	int (*min_context_restore)(const struct ti_sci_handle *handle, u64 ctx_addr);
+};
+
 /**
  * struct ti_sci_ops - Function support for TI SCI
  * @board_ops:	Miscellaneous operations
@@ -654,6 +662,7 @@ struct ti_sci_ops {
 	struct ti_sci_rm_psil_ops rm_psil_ops;
 	struct ti_sci_rm_udmap_ops rm_udmap_ops;
 	struct ti_sci_fwl_ops fwl_ops;
+	struct ti_sci_lpm_ops lpm_ops;
 };
 
 /**
-- 
2.55.0

