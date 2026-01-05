Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B346C79FA7
	for <u-boot@archiver.kernel.org>; Mon,  5 Jan 2026 16:43:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B777F83E21;
	Mon,  5 Jan 2026 17:42:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="mFYTAWff";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8D7D83DEE; Mon,  5 Jan 2026 17:41:23 +0100 (CET)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB0D283D71
 for <u-boot@lists.denx.de>; Mon,  5 Jan 2026 17:41:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wm1-x341.google.com with SMTP id
 5b1f17b1804b1-47d63594f7eso827105e9.0
 for <u-boot@lists.denx.de>; Mon, 05 Jan 2026 08:41:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1767631281; x=1768236081;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xR7nsW/jE2jNaKjdDfA2d8cOJMawXkwr3x7eqDyaoSM=;
 b=mFYTAWffk5LgCIJ2DEiHL8rLinoi5XzcJRPTDToxskTDrgNUsMupNA4qbLB0JTXmfn
 8zhzAKn7z70f8HsgT/n0Yx7hR+6WxQN3ChPfxONRdi0J2pJVTINA+8/H8yYDV20f+ovy
 E/cwjuP2GfoFYJA6Ci9+Ybo89jremdAoW7QTSzT5hq5F/dVec01dTCx7Tz3pml1CMpk9
 IaPyj7YXNmp62SY0Rd0iZBygAklFvdGd9TAgsbDn+vM7y2dUq+7jmXbjnq5M/JHy2ZDr
 YrAFE+zGRlhfDXws62ycmRtSEJsRdKk+fcWfIadGCI41MfHLKSB8pKPdP3rV1VzcIXH6
 d4hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767631281; x=1768236081;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=xR7nsW/jE2jNaKjdDfA2d8cOJMawXkwr3x7eqDyaoSM=;
 b=sibXeGCe8dxRcHHJSTfvIvoWwfdv1qlAMDmhkjsLLDdw/gcy4+O0KE3HVhH3bsfceC
 jFG7TOFRXqQ+9J7uUKtdkRZhq1Dzd2m9kJz/smScrqmehkRcJeldl3gp+ZoHqJBrzniZ
 rY9alDfnboTvV+cZ+GtLQrxU5eSx5/yWzH8MaeBB8Zo2bQexqsw/G577T9Jvsgl1dpHP
 6Ed7HTeb7mx92P85P2xbBjoX2FC977CRAgkp1AhtM+9aazTGbpXaS27K3oZRaozzPNNy
 MSEsMqbaPtc7YNOiomtse5XybUbXxmYfWdn9zISg1QXdlLB2pbnEi7On+IDQAe6jQ1/p
 IPAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUEZfLEsQ6QbmiG2/9EnarGFwIY0aiD1PPToM2iCMKvJkweWoDs6ZZrRcIgWOlOo67v8mBhJQI=@lists.denx.de
X-Gm-Message-State: AOJu0Yzpyl4OYvD5+E2uG3jwA+dOI+3g+rEvPuF6C1MxapMHXpO6upPE
 lIIj2pGE46qeheXsAXT7XIoEdjE38TQ9O6zZlrgBP3E3Sb6j47fsJwMMk4FiCGYBOow=
X-Gm-Gg: AY/fxX7KeYk60HMGfPI/oq5XZhKr7pYiyM9kdOJvtEMPamaNWJ0lITPSWKG9UfMCgxI
 1LjU/0iXur6ahl6AGs5keGeevPK7PfXa8ZdZnl8y/PXgwzRayARxYgE11PcBtoEWA8qT6URysts
 9QEgMcZMPMGy37J4k8lg4XhWLMIbmP1fI4kybigMxgNSd+4z7wFDTwtM9rGkfBVIhJ3pGWQNf/2
 jn0jrVwvpZQBwYBG/Mk5sPq5ndJh410n6ghIFyfSxAr1K7rtGpuXgYnblg9ZKYEcAj6eelp+qK/
 pNwTAH/M3N5hZlJRFvocvC4xa44vzdgD1aiimz3D1yqo6S459a/Lw0U9wTMRXtMW/CzSJtWWdkz
 UFRaQXhilA6SEGT5dsNCdv50g2L5PfspQ0t3/q/qsdV3UGn84FZdpEBFPPHoSD6/vk/j7GDkVXv
 oDLdwN+uPg
X-Google-Smtp-Source: AGHT+IEhpwijo66Z3F7ZQMwxhA/6C5QGouMK31TaTpaCy5V32URHNVWu7ZyViomBdt3LV0w2FMUJSQ==
X-Received: by 2002:a05:600c:358d:b0:47d:6c69:bf28 with SMTP id
 5b1f17b1804b1-47d6c69c00cmr120581065e9.24.1767631281106; 
 Mon, 05 Jan 2026 08:41:21 -0800 (PST)
Received: from localhost ([2001:4091:a246:82fd:4350:c3d9:84a3:70dd])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bca2fce0sm460053f8f.18.2026.01.05.08.41.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jan 2026 08:41:20 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Mon, 05 Jan 2026 17:38:50 +0100
Subject: [PATCH v9 05/13] firmware: ti_sci: Add TI_SCI_MSG_MIN_CONTEXT_RESTORE
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260105-topic-am62-ioddr-v2025-04-rc1-v9-5-7e33f2c77dbf@baylibre.com>
References: <20260105-topic-am62-ioddr-v2025-04-rc1-v9-0-7e33f2c77dbf@baylibre.com>
In-Reply-To: <20260105-topic-am62-ioddr-v2025-04-rc1-v9-0-7e33f2c77dbf@baylibre.com>
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
 Prasanth Babu Mantena <p-mantena@ti.com>, Beleswar Padhi <b-padhi@ti.com>, 
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4602; i=msp@baylibre.com;
 h=from:subject:message-id; bh=kFx3gDxbO2dfYfn1jpvBMi+dhUJLf8TZ7j755OBuiEc=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhszol9VTbmzdUvbari1fsbeqJ7D9yJRL/AwWq5+l1ub+5
 NrvK97RUcrCIMbFICumyNKZGJr2X37nseRFyzbDzGFlAhnCwMUpABM5ZsbIsNFS39jq10+xnMxm
 M5eY51teNraIyGx4Hc0YdmL6nG/3rzEyXBXayPxxwxWvOXd6WbNVAh1/nHVmtp89+e3W4Bl19x5
 n8QIA
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Mon, 05 Jan 2026 17:42:35 +0100
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

Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
---
 drivers/firmware/ti_sci.c              | 38 ++++++++++++++++++++++++++++++++++
 drivers/firmware/ti_sci.h              | 16 ++++++++++++++
 include/linux/soc/ti/ti_sci_protocol.h |  9 ++++++++
 3 files changed, 63 insertions(+)

diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index 6f57dcfe8de8f874318cd53372c798d182faae73..74e4f162aaa2da8c3ecc1cf393ca11fa5108d83b 100644
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
index ce50bf6800eb1fee70a872d8ae648b1a9582b681..68908c6c8c46ed2e3f0ed1ad4e764b14f0b5f465 100644
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
index 52696763ecf6bc2336e796978e1cc02896db13ab..6b1dd801f5f8ec5f6bce3490401a71b24954a2ff 100644
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
2.51.0

