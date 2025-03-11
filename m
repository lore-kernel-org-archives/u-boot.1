Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60BDDC28B2E
	for <u-boot@archiver.kernel.org>; Tue, 11 Mar 2025 13:16:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8EE9881CF0;
	Tue, 11 Mar 2025 14:13:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="T/02lJ0w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F3F380FB9; Tue, 11 Mar 2025 11:33:19 +0100 (CET)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08B7181761
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 11:33:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-ac2bfcd2a66so74642066b.0
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 03:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1741689171; x=1742293971;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=15X/xSfmZPilC4sx3n19qI28QrL308QJAbeYCd08z7k=;
 b=T/02lJ0wiQ48DRFSbJTSQL5GImdWi9d/50zJqOSqf9lJgJ724X+DvFqKnNTnY6vFVD
 N29Uh3RefSA63TiK0w4EEkHsx6VgdL0DMz9fZAnY1TaUllHeT4iKENLRwpZmbjK8Yxve
 H+JaFjY7AD54ELoA79oCN4a70RBFmz9zR0PaLlEj4PkGcp09dnHH3zkmiJuzmQTRJuq7
 gxXK+UpgGPAYhMzRZK5lXS0O/sYW9ZoRoDvQ2KxrKbx8Z3ZGb4yoa6jbqC9P6Nen+zTx
 CjBw23j9NSbXnDejAyyqzEK9pt2xfyBgv5wZqOY22JxU19lqHm9AEYdXlRwHASQytb7A
 tjow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741689171; x=1742293971;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=15X/xSfmZPilC4sx3n19qI28QrL308QJAbeYCd08z7k=;
 b=sw6SCXpAFS9s/5EQ+NYJvTymkVvpvi/vCdqcFwpTa3DOyusDcKv31F4+MQEZxPdaPY
 209RjhhGBFJhaRFEMtTHHG0R8ttznHQYSqxbGDXo0JecdKWTpqPeEC5xocFWOFO2gYWN
 YT/7ruQBVZRh3Uprzq0ihu1u2FJMoR6WkX1pfYqljdE81M95Q6C6qoNOttq6ZxkJtLLH
 Drm8GwddHBLa26ENa+rKJS4xVPG21B26v47ZwpEMrDhtEG2X5au9le+mGQzyTfmZK1oJ
 2KpR5mv9HYtmXmkIhMVldI0RPz+i7vi3cokiXFNPMOro/mE3YTJqsiPe6h0VicaTurGG
 I2iQ==
X-Gm-Message-State: AOJu0YzccSE+RXKc7kJwmygqnIzfXXJhhDd6Q4p4A/AqAyT2RtOMLsnJ
 k5j7U/Xmzrufeldbhs8ehcteSExcL0SGXQSv3IlV/xIaMW3UT27GkPBuJwTcgm5pKTq3kCFO7Tz
 1
X-Gm-Gg: ASbGnctIYyWRbB934mxSmIOnwlFQBLtYn4KtCbqUnTBsXD4tUn7Nj+5tSVOR5QbOK2g
 yd9RlVury5zIgR6f/S80sN7bT1CIpYd7I3l4BRafWJ+ldHNevo7pfTWoaa6qTp9T7Nlp7BQMGhx
 W12mhzptTTx+4ttel34YytMZMoyJHdaf8LzSi8G6ai+7nODqoUUYpe0CMtFJJcWXBSePWoEBk/y
 rRWl2gSZEBmekYj9P4joOIu8m2jMmhGlfREyO67cOJFIDRElBiP3maBLepZfSJ0sgQbGfxq0v/F
 qoeZvkHsgnvgMpkHDpiGijAIAjupcxTOMxyvmPLp
X-Google-Smtp-Source: AGHT+IGrYZfYRk886RxDgOVyVojSoXNG0xE9DUd8b4EZ5zNLXgjbrwu4dhaqLZAJyuRYpGeFOeGhLw==
X-Received: by 2002:a17:907:980a:b0:ac0:b05:f0c0 with SMTP id
 a640c23a62f3a-ac2b9db4067mr390023766b.1.1741689170975; 
 Tue, 11 Mar 2025 03:32:50 -0700 (PDT)
Received: from localhost ([2001:4090:a247:83e0:938:b3cb:2c1b:889c])
 by smtp.gmail.com with UTF8SMTPSA id
 a640c23a62f3a-ac24a84397fsm811826666b.96.2025.03.11.03.32.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 03:32:50 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Tue, 11 Mar 2025 11:30:43 +0100
Subject: [PATCH 04/19] firmware: ti_sci: Add TI_SCI_MSG_MIN_CONTEXT_RESTORE
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250311-topic-am62-ioddr-v2025-04-rc1-v1-4-666de9c105cb@baylibre.com>
References: <20250311-topic-am62-ioddr-v2025-04-rc1-v1-0-666de9c105cb@baylibre.com>
In-Reply-To: <20250311-topic-am62-ioddr-v2025-04-rc1-v1-0-666de9c105cb@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@linaro.org>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>
Cc: u-boot@lists.denx.de, Vishal Mahaveer <vishalm@ti.com>, 
 Kevin Hilman <khilman@baylibre.com>, Dhruva Gole <d-gole@ti.com>, 
 Sebin Francis <sebin.francis@ti.com>, Kendall Willis <k-willis@ti.com>, 
 Akashdeep Kaur <a-kaur@ti.com>, 
 Markus Schneider-Pargmann <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4464; i=msp@baylibre.com;
 h=from:subject:message-id; bh=1826k2oVV+FBgo7js26h14yHYRwg+GJ0hSbHDTRNoKc=;
 b=owGbwMvMwCGm0rPl0RXRdfaMp9WSGNIvCPw9u2l5182elYVv7Re518w2vsebxvTRP5Gr5Xu4k
 NDZ6i7jjlIWBjEOBlkxRZa7Hxa+q5O7viBi3SNHmDmsTCBDGLg4BWAi+z8wMjyZ6bLZdF21Y0Jw
 8UsBtUD1bv2JT0KEXqivDX63ZHr9B6CKNTcv9yRet5v7cIskx1Qfptfi+Wy3Xitf9mBcbVfzg9+
 PGQA=
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Tue, 11 Mar 2025 14:13:18 +0100
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

This patch adds code to be able to call TI_SCI_MSG_MIN_CONTEXT_RESTORE.
The context needs to be restored after booting SPL when resuming from
IO+DDR.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 drivers/firmware/ti_sci.c              | 38 ++++++++++++++++++++++++++++++++++
 drivers/firmware/ti_sci.h              | 14 +++++++++++++
 include/linux/soc/ti/ti_sci_protocol.h |  9 ++++++++
 3 files changed, 61 insertions(+)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index 190a1e3f5fc3713464b0cbf3ae8c35e3f185a353..f8270d2aa206412989d025502ddf297bc2d433dd 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -2608,6 +2608,41 @@ static int ti_sci_cmd_change_fwl_owner(const struct ti_sci_handle *handle,
 	return ret;
 }
 
+static int ti_sci_cmd_restore_context(const struct ti_sci_handle *handle, u64 ctx_addr)
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
@@ -2625,6 +2660,7 @@ static void ti_sci_setup_ops(struct ti_sci_info *info)
 	struct ti_sci_rm_psil_ops *psilops = &ops->rm_psil_ops;
 	struct ti_sci_rm_udmap_ops *udmap_ops = &ops->rm_udmap_ops;
 	struct ti_sci_fwl_ops *fwl_ops = &ops->fwl_ops;
+	struct ti_sci_lpm_ops *lpm_ops = &ops->lpm_ops;
 
 	bops->board_config = ti_sci_cmd_set_board_config;
 	bops->board_config_rm = ti_sci_cmd_set_board_config_rm;
@@ -2689,6 +2725,8 @@ static void ti_sci_setup_ops(struct ti_sci_info *info)
 	fwl_ops->set_fwl_region = ti_sci_cmd_set_fwl_region;
 	fwl_ops->get_fwl_region = ti_sci_cmd_get_fwl_region;
 	fwl_ops->change_fwl_owner = ti_sci_cmd_change_fwl_owner;
+
+	lpm_ops->restore_context = ti_sci_cmd_restore_context;
 }
 
 /**
diff --git a/drivers/firmware/ti_sci.h b/drivers/firmware/ti_sci.h
index bb8bc7beeadbed5415eb4450735d488de019e9af..e8fdc652b855e9057b734c3e4f526e380d0b78bd 100644
--- a/drivers/firmware/ti_sci.h
+++ b/drivers/firmware/ti_sci.h
@@ -43,6 +43,9 @@
 #define TI_SCI_MSG_QUERY_CLOCK_FREQ	0x010d
 #define TI_SCI_MSG_GET_CLOCK_FREQ	0x010e
 
+/* Low Power Mode Requests */
+#define TI_SCI_MSG_MIN_CONTEXT_RESTORE	0x0308
+
 /* Processor Control Messages */
 #define TISCI_MSG_PROC_REQUEST		0xc000
 #define TISCI_MSG_PROC_RELEASE		0xc001
@@ -1530,4 +1533,15 @@ struct ti_sci_msg_fwl_change_owner_info_resp {
 	u16			owner_permission_bits;
 } __packed;
 
+/**
+ * struct ti_sci_msg_min_restore_context_req - Request to restore context from DDR
+ *
+ * @hdr:		Generic Header
+ */
+struct ti_sci_msg_min_restore_context_req {
+	struct ti_sci_msg_hdr	hdr;
+	u32			ctx_lo;
+	u32			ctx_hi;
+} __packed;
+
 #endif /* __TI_SCI_H */
diff --git a/include/linux/soc/ti/ti_sci_protocol.h b/include/linux/soc/ti/ti_sci_protocol.h
index 8e4c43cef3111412b5d894ad29152dde92822a64..1bf261368ca23ab03c60d25732b3e1f7d368b0ec 100644
--- a/include/linux/soc/ti/ti_sci_protocol.h
+++ b/include/linux/soc/ti/ti_sci_protocol.h
@@ -594,6 +594,14 @@ struct ti_sci_fwl_ops {
 	int (*change_fwl_owner)(const struct ti_sci_handle *handle, struct ti_sci_msg_fwl_owner *owner);
 };
 
+/**
+ * struct ti_sci_lpm_ops - Low Power Mode operations
+ * @restore_context: Request restoring context from DDR.
+ */
+struct ti_sci_lpm_ops {
+	int (*restore_context)(const struct ti_sci_handle *handle, u64 ctx_addr);
+};
+
 /**
  * struct ti_sci_ops - Function support for TI SCI
  * @board_ops:	Miscellaneous operations
@@ -615,6 +623,7 @@ struct ti_sci_ops {
 	struct ti_sci_rm_psil_ops rm_psil_ops;
 	struct ti_sci_rm_udmap_ops rm_udmap_ops;
 	struct ti_sci_fwl_ops fwl_ops;
+	struct ti_sci_lpm_ops lpm_ops;
 };
 
 /**

-- 
2.47.2

