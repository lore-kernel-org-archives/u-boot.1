Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 037C8D3C924
	for <u-boot@archiver.kernel.org>; Wed, 10 Dec 2025 15:54:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A6D3383D07;
	Wed, 10 Dec 2025 16:53:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="x/fh0Xvd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1898983869; Wed, 10 Dec 2025 15:10:58 +0100 (CET)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1858F83A26
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 15:10:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-b72b495aa81so1051416566b.2
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 06:10:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1765375855; x=1765980655;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ijivZO2aDW3avR//60gsbEVuWFIiYWE8zSfXrfb9RMQ=;
 b=x/fh0XvdJ9MGVZzQVDQB0DEnGnAmVt/6buik10IsLXBIzCfNbooKi9mAy7oKFECSNs
 kJ52399HpH8HutNH+vkS6NDjFRySLnNLXKDot6JjvaVFDrDgKX9gAsYPETcE0epbKtv5
 oBsRcN9akcUN2qOU96tTemW+cjk6bG+IZBPR9FxE1OZONS0bEb7CP0tsKzP5+oXwcRe4
 S01lmwAucyl7o5cJ9glSomvea1wgOX//WqTxh9I/oLdT+ZplI6caXkqCuxIUPVovKGmL
 +x6o6Z/QXMUQSRqXHaqrvyhIQrpX9n0KhfBXVE5wCr8thdkG9FBWK/IAmNIKZAmO/myo
 UOkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765375855; x=1765980655;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ijivZO2aDW3avR//60gsbEVuWFIiYWE8zSfXrfb9RMQ=;
 b=lgl8YrTwCHbWv+9G6ewmSOuCu28Yw1ywFU5wWMRVR1x7EvCTDQdbUIkna2GVCK4Ta7
 N9SUVLND0ic9wyanKIqgRKt5R/EnRiC+JrKkBHRTq/591ySdhjlQXKp5FRffETofkwli
 k5GvOuaKDpYETzjuaTAt6SS5DHXEuKNOb7ObCWVO/r4pbxQ56+tAhwr/inxeQUAw1wtv
 oj36T9I9jyQqWtVRSIJ/FHUIhGMTM4uNQF4NOqJbJxDdOZCZgEVYcXLSF9bvHXmNpiEC
 VZ0gUVU7Bf4ojw813nxl8nsX39CvNzzdUd2zi9cxGnVMOT6dG8ysezYsVsSFpwWmNyEV
 VspA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUeKafpZ/zRX7vquRbhhf2jQZa3/adBZscIMVwYAy3openqyojXSCqz9L8nOQzkQAWtXj21cRY=@lists.denx.de
X-Gm-Message-State: AOJu0YzX2NsviS8vGLnRLjopCAb+Uo/ydrde/heDNaz+BiEJbB1L+VWb
 lAlAA9bOgMZX16fpQgbk1I1exhFwQLzsfWs14N8sNizDDhisEN30C84rCqHK+yNNCouMn3hU925
 82TDs
X-Gm-Gg: ASbGncu/MzXEvlZoGSxolMSIbMX2LHFUIp5vGQ/GoBuec6lt0Qi3Q1ntCRqOdIJ6JDX
 g8eiiCNsQCQspo37TZafc5zrGaGxOJ9XW3YTj0DawhEej9J0Gtq27P8RuZatxCTamiKwdq/Ll2f
 FrffRiM6CyeaoIixQ/MX5EXvUNnZD5Ya/3paDK4cw5GtaGo4mgu5bw+Qf4oRSUOYqcqDH/SAoX/
 yAFJKa06kiTdo+gtjwipxhJBWE9UDNrNiMVqnAjda5Y0PhU6X4Wv5jHKjzTs8E5Fgy4yIXTHmxS
 9zgwqOF1ZtgAQBVXQVVpx7bw5uF+Wi7Im0bqDBjn29z3da6hSm7H/pplZmevItzowaJAuey1C1b
 5lUK572JTHv4828R1zfS9mCJ1CtP7SZN6K5NyAj+IfLBPlPFXLdiv0L1bUureiyCyWFPfZW0/s/
 Epjxj6/p71
X-Google-Smtp-Source: AGHT+IEWbu/5oXbSv9Y7xO+riLSKdGDowCT08GjRz1yL3lVABk8+5jDAhR6bU35ozO1+BHzBGPPYrQ==
X-Received: by 2002:a17:907:86a0:b0:b72:c1e9:5f1e with SMTP id
 a640c23a62f3a-b7ce8345aeemr289864666b.3.1765375855462; 
 Wed, 10 Dec 2025 06:10:55 -0800 (PST)
Received: from localhost ([2001:4091:a246:86d6:2b1a:7262:ad08:3918])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-647b2edd772sm16781110a12.12.2025.12.10.06.10.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Dec 2025 06:10:54 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Wed, 10 Dec 2025 15:08:59 +0100
Subject: [PATCH v7 05/13] firmware: ti_sci: Add TI_SCI_MSG_MIN_CONTEXT_RESTORE
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251210-topic-am62-ioddr-v2025-04-rc1-v7-5-f113b156f83f@baylibre.com>
References: <20251210-topic-am62-ioddr-v2025-04-rc1-v7-0-f113b156f83f@baylibre.com>
In-Reply-To: <20251210-topic-am62-ioddr-v2025-04-rc1-v7-0-f113b156f83f@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4596; i=msp@baylibre.com;
 h=from:subject:message-id; bh=YqDY4+HPFT8n1n4ZW8PZqb1SFkKFSDvthKggU1LawD4=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkzLekWDXTxcF7dx78uovaXwPW3x6bhtJ2orYx57u36vY
 BdTjNzeUcrCIMbFICumyNKZGJr2X37nseRFyzbDzGFlAhnCwMUpABOx2c3IsMf1QG5b6VPZLU0T
 hGoMJN39BPx59ZduV+qrOfrrtMC7DYwMUy8Iq+910DR6t2f3uX9SdQ1xUcmyv/2qHTPjRDcoX+z
 gAgA=
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Wed, 10 Dec 2025 16:53:41 +0100
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

