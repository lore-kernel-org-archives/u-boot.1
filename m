Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E870CF8864
	for <u-boot@archiver.kernel.org>; Thu, 20 Nov 2025 16:09:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EDBF9840D8;
	Thu, 20 Nov 2025 17:09:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="GScqjb7g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96F278409E; Thu, 20 Nov 2025 17:05:06 +0100 (CET)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 892E883F33
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 17:05:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-b737c6c13e1so199948166b.3
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 08:05:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1763654704; x=1764259504;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=zHDX2dPuRSxXmWa+bDrfHyWoKVhIY+HWxDPtBIG+H5s=;
 b=GScqjb7ggyhTmIztpa3CSwdwivuqYZCLr8D8HzM6hPz7NUZtRmO8qz5BhOkqZwqlZU
 tUGDrBxVXnS1j4xQbLCaf2AKLzMYeyYYS0X+FaQzrwTdmcO6p1qlO6fjc1m/6xXk2fWC
 k3IfB9UvA9Ntc95oGy/JyoJDLRhC35o35YXt62gYxo1sMFYjjU7StK4G36jh5OI7tYLr
 nvTKVfsaRY0LazlyrCYNfkkBwFnkRYBOT/DRlXCZme8gnY5kkCNqE0R7grMniQHtt0RD
 MYaMvFN2IZghHBxsMV3lssUFvfyb1r5QifrIT6jukgDKoH6suNropAa/eZ+4mIr6WNQR
 YF7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763654704; x=1764259504;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=zHDX2dPuRSxXmWa+bDrfHyWoKVhIY+HWxDPtBIG+H5s=;
 b=wxFk7Oq5Vdf4dwx/EDJ1tBGXKs60qbM6QOXblYIoRUArVpBIiLQzC8gtuAOIx3dgBf
 xx2og8Fvi21HPYE3xUHtrgnGFf852UnO1rjsX5e2XJC6EmzrkeE0bOT/Eg0uYWFNTeqy
 1yKTb0c+eWMdIYjN1AAt65ve4SCfwvOV6z5VQVxeh7uYylAlcn/dTJPJw0r1viJpBUXs
 DBY4XVcvtyw2VwyLw9l1jO9EwmmNuR8wrd9oN5ybIBjd97dbajQUK9smfHT1pCEUH7/d
 BwHD4WN+oD1VE4TNQO7IzFlzlhKPXnQEfrkHPD1bKGsfCc5pGD1KrhBrCKwe1VL4Gw9/
 rJdQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7WQAlHPWRnsWSy1nVOEg6Pc0lhWWwzdZHv1zgry1LVU8io2xs0vfYMH1KvxV8+mK+wP8L6+c=@lists.denx.de
X-Gm-Message-State: AOJu0YxfTQ1FEyj4Ob2AkVKpjTiFzOln5QrRysRRXdWRnbEX3Jwzs7RK
 4a/Y9+9MRCjMqqrkuZkb33BYss/HLL7X/b2qXSo7sSQt28i6ALe6BqWEbUT9cL8uUSs=
X-Gm-Gg: ASbGncuM2i5p8VrUFl8oxd6pyIisHCQtizn3Dq23TuENFmeTIRulSE/ieadmwO/lSyB
 qD26poGGYAuPMnZ8QBJC7dBa+HaWPUv3xBlfdl9CVWULaus2lI6vRqkH6aDxdkRajX44W6Qzuco
 ZfmZHw693uUHfZVMzMJ6dsQIoNyIC28u03dFCzaTul2oMQSpP+TIvH7BRU6oO6xRcWThzJBkUNL
 ZxQWtLmg14z/7JVUkJskMlQd1Xwq+BCJyIV0/OjvC3f5zYAsrboiBdjzZL6e/NiM/R9SiYzA68I
 tKGmy5RPTIUopP2b7pOal/6knAMGDrXFjDUhxCCluPTZeGzL7Xz+OIj14DxT6sxv+/aDENab6q1
 K549h3q3iLUbgi6kiYtnrLmYcxiE95/fAUp7tpV7uZFij5Sd0ZWTERdVo47APekpgAGRsHV0Of2
 3vWy+pvPM=
X-Google-Smtp-Source: AGHT+IHtF3HGonxd2KcwjUKVsstBM/IhJwCdLGvuXViOX42zbflAmsXalYcsFE6O22KrMTNYjNdTTA==
X-Received: by 2002:a17:907:26c2:b0:b74:984c:a92e with SMTP id
 a640c23a62f3a-b7654d86db0mr431169766b.3.1763654703792; 
 Thu, 20 Nov 2025 08:05:03 -0800 (PST)
Received: from localhost ([2001:4090:a247:809c:875a:7c11:12fc:ed9])
 by smtp.gmail.com with UTF8SMTPSA id
 a640c23a62f3a-b7655038011sm234264666b.62.2025.11.20.08.05.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Nov 2025 08:05:03 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Thu, 20 Nov 2025 17:03:21 +0100
Subject: [PATCH v6 04/13] firmware: ti_sci: Add TI_SCI_MSG_MIN_CONTEXT_RESTORE
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251120-topic-am62-ioddr-v2025-04-rc1-v6-4-6dd99a7271bb@baylibre.com>
References: <20251120-topic-am62-ioddr-v2025-04-rc1-v6-0-6dd99a7271bb@baylibre.com>
In-Reply-To: <20251120-topic-am62-ioddr-v2025-04-rc1-v6-0-6dd99a7271bb@baylibre.com>
To: Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@kernel.org>, 
 Nishanth Menon <nm@ti.com>, Robert Nelson <robertcnelson@gmail.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Bryan Brattlof <bb@ti.com>
Cc: Vishal Mahaveer <vishalm@ti.com>, Kevin Hilman <khilman@baylibre.com>, 
 Dhruva Gole <d-gole@ti.com>, Sebin Francis <sebin.francis@ti.com>, 
 Kendall Willis <k-willis@ti.com>, Akashdeep Kaur <a-kaur@ti.com>, 
 u-boot@lists.denx.de, Anshul Dalal <anshuld@ti.com>, 
 Moteen Shah <m-shah@ti.com>, Santhosh Kumar K <s-k6@ti.com>, 
 Nathan Morrisson <nmorrisson@phytec.com>, 
 Garrett Giordano <ggiordano@phytec.com>, Judith Mendez <jm@ti.com>, 
 Aparna Patra <a-patra@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>, 
 Chintan Vankar <c-vankar@ti.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 Prasanth Babu Mantena <p-mantena@ti.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Beleswar Padhi <b-padhi@ti.com>, 
 Manorit Chawdhry <m-chawdhry@ti.com>, Andrew Davis <afd@ti.com>, 
 Wadim Egorov <w.egorov@phytec.de>, Udit Kumar <u-kumar1@ti.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, E Shattow <e@freeshell.de>, 
 Devarsh Thakkar <devarsht@ti.com>, Peng Fan <peng.fan@nxp.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Andre Przywara <andre.przywara@arm.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4660; i=msp@baylibre.com;
 h=from:subject:message-id; bh=O2DZjYhWpnyAi3rF8ozeA3FMPC6aO4iy43lKwRfFrHw=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkx56zde4gy2QUvOTkjUf8Y2J2R5QIq2/t7YJpUdx5c+0
 nevV3/cUcrCIMbFICumyNKZGJr2X37nseRFyzbDzGFlAhnCwMUpABM5voHhn+6SfaxaM/apymRW
 zJp0uqhvm8bDnsKULTcDZDQthYrvbGL4n3Rou8WiFSlZNiI3Zj1fUWpskKWpNX3VnefFJ/b0sfK
 x8gMA
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Thu, 20 Nov 2025 17:09:03 +0100
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

Tested-by: Anshul Dalal <anshuld@ti.com>
Reviewed-by: Dhruva Gole <d-gole@ti.com>
Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
---
 drivers/firmware/ti_sci.c              | 38 ++++++++++++++++++++++++++++++++++
 drivers/firmware/ti_sci.h              | 16 ++++++++++++++
 include/linux/soc/ti/ti_sci_protocol.h |  9 ++++++++
 3 files changed, 63 insertions(+)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index 6f57dcfe8de8f874318cd53372c798d182faae73..f1cb871e8f45013097f6f8188222770ffe3653dc 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -2710,6 +2710,41 @@ static int ti_sci_cmd_change_fwl_owner(const struct ti_sci_handle *handle,
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
+	lpm_ops->restore_context = ti_sci_cmd_restore_context;
 }
 
 /**
diff --git a/drivers/firmware/ti_sci.h b/drivers/firmware/ti_sci.h
index ce50bf6800eb1fee70a872d8ae648b1a9582b681..3f8c27c7d8c5b35cc55c18ed33225e7b5262b3da 100644
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
+ * @ctx_lo		Low 32-bits of physical pointer to address to use for context save.
+ * @ctx_hi		High 32-bits of physical pointer to address to use for context save.
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
2.51.0

