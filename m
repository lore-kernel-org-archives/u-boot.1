Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D74F1C71136
	for <u-boot@archiver.kernel.org>; Fri, 13 Jun 2025 14:00:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B6D8182D4D;
	Fri, 13 Jun 2025 15:59:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="fWkEEd+j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D95F82D09; Fri, 13 Jun 2025 15:22:01 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1A53082CA8
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 15:21:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-ad89c32a7b5so338047866b.2
 for <u-boot@lists.denx.de>; Fri, 13 Jun 2025 06:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1749820918; x=1750425718;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=MCsTA1dIhPfrJFbBOyX/SSFjeoF/SB+H5iTqJnDpR7s=;
 b=fWkEEd+jd6/7mFAA8mz1nEunKFTy9hK+t1nSzg8W9SkJFEL2MZnJzwXnixDf/YzC5U
 JUSVyqymFRF1kxu+1j6UyyDf0aDjHOT56TVPjkXkKLubR1JrcUrxnyD4nmrFbYbPAGqb
 mwD2Iy+SzmZKvTPyqswM+DqV82elOXu2xTgFCiQPVLps56Ujqh31t/bCA5WiKywvxK6Z
 usYQGpWarQNblVBVGn9Dxqrp9pcWaMQQNPSHBrgRuBP3r50vjAFBieapGUmFG/0uWz1y
 52H9fq/L4aQF3uaBgNgfSvGQ+6qNN7zMTjVj8nsdCEoJqJVbsMdXHR+q+OQ5bp2pArjd
 T0SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749820918; x=1750425718;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MCsTA1dIhPfrJFbBOyX/SSFjeoF/SB+H5iTqJnDpR7s=;
 b=e1epQNxUczJeErH51niCseBYTkEl6/AleZ022khasXdLR/97TWegOF0Tb1mpC5WCcP
 dqtCgfLMXQxeugmEZtehAzQaYdcbuzhn0MfpSLAlP0SxBkgCncN7rvXS+xSTUHyAmmrA
 X1rw2ZRoMqHhmV39XMIIMDgXOqMRABGo6VPgaP1cbb67dGazEzA7xG8fdFUbGBssv8+F
 EayvMnI+p6OyDdci3Ri/4S/VcnhQUVE9A4l8deZbIyvTShK8JYcS58wjFBLAR4fuGjZe
 sb0BvCMknpmY90M3t7Omxs85NpbB99glFnANj0xWZTNh6QBWWItrkRrQCAVds3z7Nntx
 VG8Q==
X-Gm-Message-State: AOJu0YzhGc3Jl7CyirrobkaGdpxfe1xhV+R7JpOj54bjlLTtOthE8mI0
 kLNsBOopjjGqk8HEUy7OgKZPMdQuVaIlUWqyse5Chmv6T88iCX1INvkEr4tgVmOHMJy5j/zNZkr
 wGcaK
X-Gm-Gg: ASbGnctCLcWiHImhBL+s/YtUKWHYvMtRL+asfRzJ52RDMfdk3QngLCg7y0LgGd4MPEd
 CKNBps6bdzTFLe7ULIaQ3NOfUIVZfi8qhYAR1cFomRuHEgngxhoBDvik0rEbTZ53k9GsYuIW9xz
 xHsWOLmET+19Q1zo+92mxxT0FxS6Zmk33/Etc26iRnBbFfmCbDfZSHu+iQxxO5vrxtGJUEqoNYF
 6yR/qkW/thesaUeHmRxGGsN4pteECtIOGqYrAuxLpfkHxbi4QwF5kD+w/wVBYls2sTEtV3d++J8
 4qGPuWSER14bfeoon2kKwkgdV5/thw6DnxxAPhXQP4bwYY/XR8Zr+ESMeko=
X-Google-Smtp-Source: AGHT+IGEFzNA+V3ugwALV8dDwvt9uI6oG7AstSUnY9nXG3saLapmz88Y3ZnwoxbgXzRKEj1A5Fj9uw==
X-Received: by 2002:a17:907:9603:b0:ad8:8364:d4ac with SMTP id
 a640c23a62f3a-adec5caaba6mr310104866b.55.1749820918481; 
 Fri, 13 Jun 2025 06:21:58 -0700 (PDT)
Received: from localhost ([2001:4090:a244:83c4:9fe4:a128:a20c:8b84])
 by smtp.gmail.com with UTF8SMTPSA id
 a640c23a62f3a-adec88ff265sm128557166b.95.2025.06.13.06.21.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Jun 2025 06:21:58 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Fri, 13 Jun 2025 15:19:24 +0200
Subject: [PATCH v2 04/22] firmware: ti_sci: Add TI_SCI_MSG_MIN_CONTEXT_RESTORE
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250613-topic-am62-ioddr-v2025-04-rc1-v2-4-3d233aaea355@baylibre.com>
References: <20250613-topic-am62-ioddr-v2025-04-rc1-v2-0-3d233aaea355@baylibre.com>
In-Reply-To: <20250613-topic-am62-ioddr-v2025-04-rc1-v2-0-3d233aaea355@baylibre.com>
To: Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>, 
 Sumit Garg <sumit.garg@kernel.org>, Robert Nelson <robertcnelson@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Bryan Brattlof <bb@ti.com>
Cc: u-boot@lists.denx.de, Kevin Hilman <khilman@baylibre.com>, 
 Vishal Mahaveer <vishalm@ti.com>, Akashdeep Kaur <a-kaur@ti.com>, 
 Kendall Willis <k-willis@ti.com>, Sebin Francis <sebin.francis@ti.com>, 
 Dhruva Gole <d-gole@ti.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4464; i=msp@baylibre.com;
 h=from:subject:message-id; bh=pCGafYK/PUWi856Q3b5sIiUIZ5vRvobEVNh06KIYVh8=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhgwf1XauW3wbnsqVrstu/eZcoBskZSiz8lpn3/nNO/5+V
 Nvzp+ZPRykLgxgXg6yYIktnYmjaf/mdx5IXLdsMM4eVCWQIAxenAExkpwUjw5zr+VrljKH/oiU0
 Pvbv9xK6cfJ0qNomjcPy0y4/leKasp2R4b5y1TwHgY+1u3yNamc8lGn+/1KCS8DA2HPnzOM9lw5
 nMAEA
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Fri, 13 Jun 2025 15:59:32 +0200
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
index 344df9454b3b604afe678d96a4eae178955324fe..9ae49ab850bbfb4785f446f45cad34fff4cc7cdc 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -2613,6 +2613,41 @@ static int ti_sci_cmd_change_fwl_owner(const struct ti_sci_handle *handle,
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
@@ -2630,6 +2665,7 @@ static void ti_sci_setup_ops(struct ti_sci_info *info)
 	struct ti_sci_rm_psil_ops *psilops = &ops->rm_psil_ops;
 	struct ti_sci_rm_udmap_ops *udmap_ops = &ops->rm_udmap_ops;
 	struct ti_sci_fwl_ops *fwl_ops = &ops->fwl_ops;
+	struct ti_sci_lpm_ops *lpm_ops = &ops->lpm_ops;
 
 	bops->board_config = ti_sci_cmd_set_board_config;
 	bops->board_config_rm = ti_sci_cmd_set_board_config_rm;
@@ -2694,6 +2730,8 @@ static void ti_sci_setup_ops(struct ti_sci_info *info)
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
index aa4d105ee988e9e14b5f5028733fe84cf2fc3a98..ce1c8a29cc1eccd90f19dc3c593986b68eac22f1 100644
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
2.49.0

