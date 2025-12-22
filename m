Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F906E69160
	for <u-boot@archiver.kernel.org>; Mon, 22 Dec 2025 20:05:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C19BC83F14;
	Mon, 22 Dec 2025 21:04:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="qZXJJVxp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC85F83EE2; Mon, 22 Dec 2025 21:02:58 +0100 (CET)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D6EF83DEB
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 21:02:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wm1-x343.google.com with SMTP id
 5b1f17b1804b1-47a95efd2ceso37357775e9.2
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 12:02:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1766433775; x=1767038575;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xR7nsW/jE2jNaKjdDfA2d8cOJMawXkwr3x7eqDyaoSM=;
 b=qZXJJVxpiDrmkz4d9uKa8EpICQ6AemvmMbEj77AE/noWgWGcPRPLYx6sqXYOS9I8px
 vtgiDniyy/UzIXr5e7PLoF0EY+NqT3u6HRVn4aIgzZzQp6GdmsJ5ewQMAhWvbpLnx1Yl
 cHKBe15jk8Z2o1p/MBs2McOknMtL8WZSj8RlT3avo0ou4KntDl9h9HirNo0twW/SROqP
 /L2V9fCEZ04syp9cQpvE3CP9hhsIBr7rlQv0vrOYKUXDxEj3CJ0rOYf/Q2s8oAirHLQy
 dHCdvpWRwqRCAADTyQtFZ+QSo26ImeRkSDV7SEfFW75/tMXs/00syCtZQ6dtdvGEfl3i
 rJVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766433775; x=1767038575;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=xR7nsW/jE2jNaKjdDfA2d8cOJMawXkwr3x7eqDyaoSM=;
 b=lkaST6LUuO3R7t3r/HnFCyhLajr/94/RuIyZQc68HQu5Zc8jiFKVEsnRoNWdqm7Nxi
 9uyQ49EUfoeIxBhvnzrgNxfGJEswyHy09Pj/1xkm0jIb7tc6sXNdNf22N8wLdXiLgeLK
 IW3iWJ1TGtdnoriIUgxN85kQH/MGJjof2C8+CR17zmvFhymyfYG9Dylnc8fZmU6zC7hn
 x5kfFn+SgwdhmvCqsmrSOQG7YQjQ5GowViXOJ2NiCEo9vZ0cgSM+b+MTEHNUYySnzfSY
 P3g1MKBNC1KXq/xP2yR6mk5h9bcikKVs6RKNOGhWBW6srxOSANJQBGgCxLwKMqHM+TfK
 sHNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXm9bfQOW3YGDRvrXX9FoVp3Ttdtn8TE/gKJz3ii72L6uJ66XXJZlDVLurNAARMTsuyNH5aD2E=@lists.denx.de
X-Gm-Message-State: AOJu0YwaGZnevyG4bUUdoMV5ciM7neHNmMv8LEgxeziLD22OOJ80GI+V
 emqMJFtkFEgGnmcEEmMxIHwHDj3NMf4yz/Zn389uKdI5E9E9HrjbWnZvgcT5gn3ULq8=
X-Gm-Gg: AY/fxX4mNAaWDPj7ROqBl3k5y0F6XqtQLUsDz5+87Kng66qAVFIXR2aYeX+wFGCIU5s
 c3gYTNq4e+FOPTt9sGHP01rHRGBP2BxKWSc+5qsMq8zzUOsPqgCxQmGXdBhWVMXflXJApmLeW81
 0wIhP62lDs83Y+4FTo8WIzq6nPof/Sg8qZ2Y5DzXl2i9AXbRiX4fgqxbfTKE6pW0bVWSBhvTs8B
 uSNzLy8+SGK3pIFq2/gx31M0hpOe7fqxbbgRXUsmfDufol+q0klP+xLNg7DlQ9KNetebAa3RxWm
 /2/lm93uynDN/1vgAUdlNJxBFLztEJNF3FAaykgsCRQZOHgGuPI9QZVRAmGEGRr9Ez8nx27l2Dx
 steZcY327Ra2ooh3pkkYyLGVqF0V6+T7PsQHAC8/bn/0+HXduBXdS/KKrNsf93zjwpnfAxmGouM
 WCy8itg3uM
X-Google-Smtp-Source: AGHT+IEO7LQcgBBebBI/2K1oIrbeVwO/RC8yAqMWe2dLupKXdhWxuor26Vga4bNWCQRVU4lky9bloA==
X-Received: by 2002:a05:600c:8b8c:b0:477:af07:dd1c with SMTP id
 5b1f17b1804b1-47d195aaf01mr115894125e9.35.1766433775440; 
 Mon, 22 Dec 2025 12:02:55 -0800 (PST)
Received: from localhost ([2001:4091:a246:82fd:4350:c3d9:84a3:70dd])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d193cba81sm203403995e9.10.2025.12.22.12.02.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Dec 2025 12:02:54 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Mon, 22 Dec 2025 21:01:26 +0100
Subject: [PATCH v8 05/13] firmware: ti_sci: Add TI_SCI_MSG_MIN_CONTEXT_RESTORE
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251222-topic-am62-ioddr-v2025-04-rc1-v8-5-e70fed16b166@baylibre.com>
References: <20251222-topic-am62-ioddr-v2025-04-rc1-v8-0-e70fed16b166@baylibre.com>
In-Reply-To: <20251222-topic-am62-ioddr-v2025-04-rc1-v8-0-e70fed16b166@baylibre.com>
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
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkzPxZuKD1zSurz07g0fqZn2zrWzbdcIhG61tmc/2jMrR
 VHLfLdMRykLgxgXg6yYIktnYmjaf/mdx5IXLdsMM4eVCWQIAxenAExE7BjD/7yEEzvmzV7reqbB
 /A1f7toFd3es6WkPDF48wWKykLHorX5Ghr2Sijterjkw0XGdrUNVnVFJjvGCY61y5+2ffZ39Wft
 oFAsA
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Mon, 22 Dec 2025 21:04:36 +0100
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

