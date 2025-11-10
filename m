Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46808CCFA13
	for <u-boot@archiver.kernel.org>; Mon, 10 Nov 2025 20:13:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1794B83AE9;
	Mon, 10 Nov 2025 21:13:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="o3Tn9lE5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 037F683AAC; Mon, 10 Nov 2025 21:11:47 +0100 (CET)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB95183A98
 for <u-boot@lists.denx.de>; Mon, 10 Nov 2025 21:11:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-b7277324054so510722566b.0
 for <u-boot@lists.denx.de>; Mon, 10 Nov 2025 12:11:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1762805504; x=1763410304;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pPw92q6W04yGrglPzrZU9FUz0DpT6vCa0OS2edbdxC0=;
 b=o3Tn9lE5faJ8DgLT9PWyZHMzJgJYUWRX9e3GOIPKC/DoGSzGiHK8NcyYcMDdgd7knb
 Kfs5uY28wzNpGdMClKvYp+fcEbZ3ZqaL3PfIFuu942Bqz8xRJuykOeRfJah/IG0bmsYx
 POkDvR0GgosP3vYsMthE1Uq41f2OUpcK1G0Ry5iZ8saBMvRtrxePQkgTjEDO9+y+nXRb
 zxzAaEze51wzXqHX1AEItCX8oHCxSyD8fKrR+zQ1v27k1FW1Qt4B8YOgIgg7QyyIL94L
 35JmD1DtnPrhZ9mCOxs1Q1HW33H6JfmRPk0XaixWlNoM2SNKKndSUwvF4h7ROUnzDQba
 bRRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762805504; x=1763410304;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=pPw92q6W04yGrglPzrZU9FUz0DpT6vCa0OS2edbdxC0=;
 b=YBiNW5OEXgLoYV9fE5t1sWXQqmLKN6YMday934V5xD2pMn3h5cxt1K3m75qQNFDpPv
 lb+gBrLsjYdwGIMf5fzxq+1dkE0E01iqucTXRh5WqmBs10UXzP+IHm3oJN46OSQXVcnS
 Q1U09A37M/d8Cw8IP86QIk54i1oXZcUixgMXEXwWgK/iLFAaNb9FmMxoo6jrtsuf+pm1
 3clNeRTKZpNnzLZMz2hFVCrkNRpSqySOm13ErMHdyT8xN6SboE5Lf+026kw6Ae1dGVOm
 r38xLEN/rOep5k68rzLPczcChAZb4D/ln2iXs/S0ADzIY0ZaF7yQ9Qgda9CV32BhK8Tj
 Ioug==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFriob/VDUKblsAQtOuPIax7KMA+QWpXVS1h7sJz2WTR7LlOjCsNMF72rWdZ/2+UajGTg0E3E=@lists.denx.de
X-Gm-Message-State: AOJu0Yxvd3qtxLxGRBKgNG4ugpJX7OGYMkfWFyFuJomtjIx1T90LW8mf
 sNvWJSeZqImKc9SqcHMuO01QWrx+etuh25TL4SH2KGFLPHmATYyg2EnOhSY4ijCq8EY=
X-Gm-Gg: ASbGncsvXJH5V1ylySfNDq3N44dUJPuB9UkYT2054LUKbYqQqdsI0j/ArR6dYHucK3A
 aeJ14ezEDK7WAdeLWKLPC3xKp834nNvueiFFncBskiEsIJgzmusDYDpXI4+NVfmtPzBegkpEch3
 qR/2iXlT8Ba0QlZ7Otdv0tRMCeIP/OdJkLXjTGt8k20nVwmDKnGh5ORbeqJ34QysugC216fj9dm
 hpkhzR6L4+7OmJl2Z8jFb12Sibd4Rio4Q9cVLXt9L8ZOha8OsRRI1H8SjN9t0P60btACyhO+BS2
 fJk/KzDVmChZ0IQz7pb7GXRK46XWHwtlL7qEzEsy8vh8UV+UbPXSCwUGdzPsNPGcgRJZ70AvkfH
 B3EniMlPb0g7dgV3Z19YoBxPG6m9B4oi3dgCkHU27bUbsAEjoaVzIcR48/9oWepf155LfGjkxaa
 ludoUNeQ==
X-Google-Smtp-Source: AGHT+IHJ3D62zXOGqmlFEXsOg2XoVidg/UXug3+RbKmUxcp80ttD3WXeaiDJMG9Tri7xS1p2uShwPg==
X-Received: by 2002:a17:906:794e:b0:b72:7dbd:3a4 with SMTP id
 a640c23a62f3a-b72e0312dc0mr974673266b.18.1762805504335; 
 Mon, 10 Nov 2025 12:11:44 -0800 (PST)
Received: from localhost ([2001:4090:a247:830a:fe22:a8:f29a:a5c3])
 by smtp.gmail.com with UTF8SMTPSA id
 a640c23a62f3a-b72bf312e51sm1158606466b.17.2025.11.10.12.11.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Nov 2025 12:11:44 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Mon, 10 Nov 2025 21:10:28 +0100
Subject: [PATCH v5 04/13] firmware: ti_sci: Add TI_SCI_MSG_MIN_CONTEXT_RESTORE
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251110-topic-am62-ioddr-v2025-04-rc1-v5-4-980ee0036c26@baylibre.com>
References: <20251110-topic-am62-ioddr-v2025-04-rc1-v5-0-980ee0036c26@baylibre.com>
In-Reply-To: <20251110-topic-am62-ioddr-v2025-04-rc1-v5-0-980ee0036c26@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4618; i=msp@baylibre.com;
 h=from:subject:message-id; bh=tEFYccWVNswH5w5+Ml4KSc+ccLOzSoRZWocU0AmuqMY=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkwht+NnzI7wtPS9XPuloNvU/KcO38tSe09bJ7XguZIfE
 uXcfv3qKGVhEONikBVTZOlMDE37L7/zWPKiZZth5rAygQxh4OIUgIm8uMXwP6P3S/rMn7Kb1+mJ
 SvBO+mdaE7nCpfI4/4PrR1u3/d/WY8PwvyJW7geTwdrsiNr3VRskNqywP85w7jPXq2fbjB833rx
 5kBEA
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Mon, 10 Nov 2025 21:13:08 +0100
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

