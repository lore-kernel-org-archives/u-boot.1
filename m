Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F3FCC7115B
	for <u-boot@archiver.kernel.org>; Mon, 23 Jun 2025 12:24:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35E2D82E36;
	Mon, 23 Jun 2025 14:23:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="o3Dg23xS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9652681E13; Mon, 23 Jun 2025 14:10:34 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 956DF82D17
 for <u-boot@lists.denx.de>; Mon, 23 Jun 2025 14:10:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-607cc1a2bd8so6180746a12.2
 for <u-boot@lists.denx.de>; Mon, 23 Jun 2025 05:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1750680632; x=1751285432;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lNl3FkJS844M/jfNelrzdAN+laqa/vOKLncqFut97XU=;
 b=o3Dg23xSkJ2xJ0d9wIx1fNF/Be6Caf2d0NdIozNAMzCCJbb9Y/PskxBe7WrtMABb8r
 p1TwLb/Rvf6OKkdSkV2HljKJ/4XU1Zvp0I12znGoMs94ijTF+hj1Eg9Z6cTWLWuvzxNz
 WG0BTBFKjoVN9Cw58fY24liJiO+aGDAsKPNNYQb6+DrX9EeDsp3OXM62DNkuLAess8vx
 64SoOOsjBDQaY2s3KC4mcbFi1ku6U1QlSA71N1Qejs4E7C//iQxTfIJnKiK53qob7sqb
 1W7Luw9m0iLoCH4jVbwWMwM1eXy72rEeGClf12G/6qpTs2bPdrmyXMp9jTsOiZNXAOdy
 Ubfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750680632; x=1751285432;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lNl3FkJS844M/jfNelrzdAN+laqa/vOKLncqFut97XU=;
 b=u9TLdhZugX0TUuzqzUMDs3EG0i1zcBgL6+zGNJ2Tl36ZkFw4KKWzKGRKM2pnEDsvCu
 RXT9BeASZLksqKRLvr9+PSQHT0gNHooreLj4aGMEn6z5MJ8yyIlDHSqdM/UbV95N/e/D
 3Hq6QtPIG3enhUxjTAwvmVZ6JpBFiaAeDH4JrJX68vgOU/DPnql4StQALuwM6hZTd+jp
 MzzLVTa/5HKhjiaFTlQyvewwPYMZ3Jvob9vme4kf7eylyd98EMBmed/eDSUzr8ISHYGt
 8guFv88fVidLt64pv85toOjbwaM+92W7yM8deApN1uiJUYIRfMbWbGEO/RBIhs14u//X
 KJ7A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhMlgPdzqz9WPifDhwfO9tcW2LknSgzJzwebt1vW0zUSG6qxD/Klka7BZG1NQrmqRc2/wmPbU=@lists.denx.de
X-Gm-Message-State: AOJu0YyZuw73X3FlhSPX1Es1x+PBzq/yu5DYYnBSFIZ8kYBoKsq6Wc16
 uO2AlPFzAR9P+0iaQPbc85ZhWwKbOPgo5jF6GzFSLFr7RQ73oSp/yfa6BBHVcGibzZQ=
X-Gm-Gg: ASbGncsUEkOGm+qduzEXUtccWO5vwx96wPX2iMp1BX/hA7wJP+fldzXnXIYZdZK3V8m
 4ApLrpunpnr7OKlqxlwr6P8PVow6aBY17xoat7G8JDyXVruZcb8y8fEuKZ9mS7t4TFMceTfbMgf
 zgxQPL+RUOpZLfl3n5r7E5TgEruU8ljy/3RwkGzh8GPoJqvLFPwVmIZhSxWDJ4oUDEoc5CW2oyt
 GAzXNgIdxbe2UkK1+I+gBTi6pzay9s8QMRWdp/D3Hh1KizjAaQmV/bkwgrn9wQO0116bVDZ5BOl
 /6aH9uIcCmKkg7saMGgF0XB08atMtNq1EL/blvfJboqIU6yZ25kmO7vWIno6qtViK/i/Aw==
X-Google-Smtp-Source: AGHT+IGbX7Cxs9l9cOMJfiiiDsr38u+9EhVFMrW/qjf0XICv4kYAbWl87UGBi3zz23qddQY/d0iN5Q==
X-Received: by 2002:a17:906:c154:b0:ad8:a935:b8ff with SMTP id
 a640c23a62f3a-ae057ef75famr1302397166b.31.1750680631923; 
 Mon, 23 Jun 2025 05:10:31 -0700 (PDT)
Received: from localhost ([2001:4090:a244:83c4:9fe4:a128:a20c:8b84])
 by smtp.gmail.com with UTF8SMTPSA id
 a640c23a62f3a-ae0541b719fsm692804766b.128.2025.06.23.05.10.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Jun 2025 05:10:31 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Mon, 23 Jun 2025 14:08:27 +0200
Subject: [PATCH v3 04/22] firmware: ti_sci: Add TI_SCI_MSG_MIN_CONTEXT_RESTORE
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250623-topic-am62-ioddr-v2025-04-rc1-v3-4-a4da322c16af@baylibre.com>
References: <20250623-topic-am62-ioddr-v2025-04-rc1-v3-0-a4da322c16af@baylibre.com>
In-Reply-To: <20250623-topic-am62-ioddr-v2025-04-rc1-v3-0-a4da322c16af@baylibre.com>
To: Sumit Garg <sumit.garg@kernel.org>, Nishanth Menon <nm@ti.com>, 
 Bryan Brattlof <bb@ti.com>, Tom Rini <trini@konsulko.com>, 
 Robert Nelson <robertcnelson@gmail.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>
Cc: Sebin Francis <sebin.francis@ti.com>, Dhruva Gole <d-gole@ti.com>, 
 Akashdeep Kaur <a-kaur@ti.com>, u-boot@lists.denx.de, 
 Kevin Hilman <khilman@baylibre.com>, Vishal Mahaveer <vishalm@ti.com>, 
 Kendall Willis <k-willis@ti.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4401; i=msp@baylibre.com;
 h=from:subject:message-id; bh=DJvoKcBsmPnSx2/OknhX2WTvws1wrxM04GGiKsVz+TQ=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhoxI50utx5n6fS06EhYobkjmD51yzHXB/8SloudKehMuN
 6dz5x7vKGVhEONikBVTZOlMDE37L7/zWPKiZZth5rAygQxh4OIUgIm0pjAy/Fl2UU1Ae1WO8+Lt
 mffsVz3xMFQQWnW+gCFcvKN9X/fEbkaGjTw1O5+/4cifJrFJdkNi/Ozk3TsY/z/m6xF2vZkWfWA
 BLwA=
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Mon, 23 Jun 2025 14:23:35 +0200
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
index 8013afef304dfb70ab14150ddc49d43ebebb5902..2083f3811862b23db093320d47afea919b761057 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -2708,6 +2708,41 @@ static int ti_sci_cmd_change_fwl_owner(const struct ti_sci_handle *handle,
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
@@ -2726,6 +2761,7 @@ static void ti_sci_setup_ops(struct ti_sci_info *info)
 	struct ti_sci_rm_psil_ops *psilops = &ops->rm_psil_ops;
 	struct ti_sci_rm_udmap_ops *udmap_ops = &ops->rm_udmap_ops;
 	struct ti_sci_fwl_ops *fwl_ops = &ops->fwl_ops;
+	struct ti_sci_lpm_ops *lpm_ops = &ops->lpm_ops;
 
 	bops->board_config = ti_sci_cmd_set_board_config;
 	bops->board_config_rm = ti_sci_cmd_set_board_config_rm;
@@ -2793,6 +2829,8 @@ static void ti_sci_setup_ops(struct ti_sci_info *info)
 
 	fw_ops->get_dm_version = ti_sci_cmd_get_dm_version;
 	fw_ops->query_dm_cap = ti_sci_cmd_query_dm_cap;
+
+	lpm_ops->restore_context = ti_sci_cmd_restore_context;
 }
 
 /**
diff --git a/drivers/firmware/ti_sci.h b/drivers/firmware/ti_sci.h
index ce50bf6800eb1fee70a872d8ae648b1a9582b681..e0e7c229deda20bf638a5e33f0225d8a35a01779 100644
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
@@ -1572,4 +1575,15 @@ struct ti_sci_msg_fwl_change_owner_info_resp {
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
index 52696763ecf6bc2336e796978e1cc02896db13ab..cb9798c8546617bcea9cc0f49f19c70e1e2c16f1 100644
--- a/include/linux/soc/ti/ti_sci_protocol.h
+++ b/include/linux/soc/ti/ti_sci_protocol.h
@@ -632,6 +632,14 @@ struct ti_sci_fwl_ops {
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
@@ -654,6 +662,7 @@ struct ti_sci_ops {
 	struct ti_sci_rm_psil_ops rm_psil_ops;
 	struct ti_sci_rm_udmap_ops rm_udmap_ops;
 	struct ti_sci_fwl_ops fwl_ops;
+	struct ti_sci_lpm_ops lpm_ops;
 };
 
 /**

-- 
2.49.0

