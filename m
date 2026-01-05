Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8C36C79FA5
	for <u-boot@archiver.kernel.org>; Mon,  5 Jan 2026 16:44:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 36A6483EE3;
	Mon,  5 Jan 2026 17:42:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="pGJwo4Ks";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 27788839DF; Mon,  5 Jan 2026 17:41:35 +0100 (CET)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 19FB4839A8
 for <u-boot@lists.denx.de>; Mon,  5 Jan 2026 17:41:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wr1-x443.google.com with SMTP id
 ffacd0b85a97d-42fb0fc5aa9so26372f8f.1
 for <u-boot@lists.denx.de>; Mon, 05 Jan 2026 08:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1767631282; x=1768236082;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jLPCJgb06syJTNtIqYzYBBcRnIByanNnMTPTA3y88dY=;
 b=pGJwo4KsZFjBodKbKdcgdcJZm1rEzRSGtriv2qKOmZy36woP4BqKl2EY39rtp8zqeI
 p7dCqmTOfMVJhFe8IKrlBnBxTl3FG04QvnSQY6rWOHj80SdnNParnLFtmGqfGwweKufn
 0MHBKtxD2cTNBmeiX1zeLWRqA+ouoC0Gbu3uhiRROpk0nAYwdr6b5kuZbSXK+EGTy2a2
 mLQzOlYT7r9w6RoO+qi7/Eh2PDlJnl/u5XU/n4xPLTxHBiIt9R7kZ8TQ2tFyfaJ8tgHb
 4wFTW+Xhhaq213/UDmt+Or8FqCDSSVDMRFn2s9chr5dZXgNMUzWn7Y8oODEM1mdBP3gV
 GKGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767631282; x=1768236082;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=jLPCJgb06syJTNtIqYzYBBcRnIByanNnMTPTA3y88dY=;
 b=jusosK+H3hDeeNKVWlhTfZZ9RU8wISB3Sq/uOeU5wJoDSgcQcaNwFv/cJWEikRtXCZ
 rZnzhY1cqayeNjI3fCYqnuFfn2GnOp6rWGaHBthC59gYQah+sM417yER/gNrHxZPrtuj
 IwpizeKZkSXrJhG8I4qEylZfV5ghCeDsZjLT75IReIkt2aZhW/xjmomNKIqkPfwKO869
 7uswt190ZweHJu75W8sTZxljdDPOptc1eIsWmcegisDETw1NmnmBSnbPmxHzTu9ObNyt
 sO5U0xYsVG3DZWZ0JqytdwPWQbQBT8Oxr0nJ8c3MuPD4rAnylYyth7PRc6bEiLl+VGuX
 DG1A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSZPCyIQkzearHxa9+zH0bMMzr6SNFhp7fQ0EA5ODeMKDeHfJ/k76lxB/Y6rmHU6gQDrkBIgI=@lists.denx.de
X-Gm-Message-State: AOJu0Yzt+2sgshZZok0OcOYWpL0pB6AV0M4nR5flUqBkddvqXKIAfoyI
 ainEoMOcSzGiu6ecuxvgZ3oNhjptqVFW6/d6hB2F1SjzJHevvLgsSnJEulh5ogweY00=
X-Gm-Gg: AY/fxX7MYXqWqozHgUNPmfUwXFmA7WnjfCT63kYCFWc63J/JtAyhFYWVA2N/u6bQvhj
 +fHBVn6hSp0KamqJ/Mc3sYpu5G9PH2XpaAZVwNOhjTKJ+XAo/Dsypph2bZSUtEy9oZ0spHOxIrl
 kptVigbo9DTdlFuax6vKex9tAVqfv4e7oCu6o+5wX5M5oCv7fkjkkp2wt5F6m9rtupWHviEDfZd
 v2hLjlxR4M3PFjCo64eZjtTStO5yXHLxpxH/kQ3i27GVgcM8mCqYC7BpJtQgCPqnz3sUssD8aTo
 6ddDXdJYvAKj+JSpVjf7flW1onLNozUxguTZ829/5rX0sTAJ6E57Zy/+6bCEe14xyvWUrZaYTky
 7QqA5DKEJVrKtQFC/pAp3pzLy/BHFqLIws0zykOwixCnqId/OXS3KWI7LroHbHT97VpwVOQQIUw
 FxYXFWfcCa
X-Google-Smtp-Source: AGHT+IGL6WnrF/e9fpllAZ6Llcs1451S1tVNruOM+XKZgVLlVJqR5r6ahGVKouteCll39xb0Ngob2A==
X-Received: by 2002:a05:6000:2209:b0:430:fd84:317a with SMTP id
 ffacd0b85a97d-432bca50bcfmr495722f8f.38.1767631282359; 
 Mon, 05 Jan 2026 08:41:22 -0800 (PST)
Received: from localhost ([2001:4091:a246:82fd:4350:c3d9:84a3:70dd])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bca5334fsm417349f8f.28.2026.01.05.08.41.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jan 2026 08:41:21 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Mon, 05 Jan 2026 17:38:51 +0100
Subject: [PATCH v9 06/13] arm: mach-k3: am62xx-lpm-common: Add
 lpm_resume_from_ddr
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260105-topic-am62-ioddr-v2025-04-rc1-v9-6-7e33f2c77dbf@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3209; i=msp@baylibre.com;
 h=from:subject:message-id; bh=m43/06JDGncLCQ/lOVx3wFnPjsZSC4N56gpXOX5wcqk=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhszolw0xMbpFGwU+WWVJtgkoJJe+Pia25NTttEqeEJUFL
 zS2zJ7SUcrCIMbFICumyNKZGJr2X37nseRFyzbDzGFlAhnCwMUpABO5Y8Dw3/3N/NZfO+9/ZsgP
 ynLeI5DRf9ZoQ9XWlzuY92+wWBeju5eRYUtzse2kg+xyxmmG7WY31BQYS7cZZS1Z9UBmxfyERYZ
 zmQA=
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

This is a common function that helps to resume from DDR. There are two
pointers which are fetched from DDR to resume, the TIFS context pointer
which points to the context in DDR. There is another pointer to the DM
loadaddr to jump back into DM.

Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
---
 arch/arm/mach-k3/am62xx-lpm-common.c | 52 ++++++++++++++++++++++++++++++++++++
 arch/arm/mach-k3/am62xx-lpm-common.h |  1 +
 2 files changed, 53 insertions(+)

diff --git a/arch/arm/mach-k3/am62xx-lpm-common.c b/arch/arm/mach-k3/am62xx-lpm-common.c
index 54d86b0474df691e8568a9c38530c56cc1eb3a0a..fa068c60ce9ccf9cec89aeae1d224b07091a3298 100644
--- a/arch/arm/mach-k3/am62xx-lpm-common.c
+++ b/arch/arm/mach-k3/am62xx-lpm-common.c
@@ -9,9 +9,12 @@
 #include <config.h>
 #include <asm/arch/hardware.h>
 #include <asm/io.h>
+#include <linux/soc/ti/ti_sci_protocol.h>
+#include <vsprintf.h>
 #include <wait_bit.h>
 
 #include "am62xx-lpm-common.h"
+#include "common.h"
 
 /*
  * Shared WKUP_CTRL_MMR0 definitions used to remove IO isolation
@@ -121,3 +124,52 @@ int __maybe_unused wkup_ctrl_remove_can_io_isolation_if_set(void)
 		return wkup_ctrl_remove_can_io_isolation();
 	return 0;
 }
+
+#if IS_ENABLED(CONFIG_K3_IODDR)
+static int lpm_restore_context(u64 ctx_addr)
+{
+	struct ti_sci_handle *ti_sci = get_ti_sci_handle();
+	int ret;
+
+	ret = ti_sci->ops.lpm_ops.min_context_restore(ti_sci, ctx_addr);
+	if (ret)
+		printf("Failed to restore context from DDR %d\n", ret);
+
+	return ret;
+}
+
+struct lpm_meta_data {
+	u64 dm_jump_address;
+	u64 tifs_context_save_address;
+	u64 reserved[30];
+} __packed;
+
+void __noreturn lpm_resume_from_ddr(u64 meta_data_addr)
+{
+	struct lpm_meta_data lpm_data = *(struct lpm_meta_data *)(uintptr_t)meta_data_addr;
+	typedef void __noreturn (*image_entry_noargs_t)(void);
+	image_entry_noargs_t image_entry;
+	int ret;
+
+	ret = lpm_restore_context(lpm_data.tifs_context_save_address);
+	if (ret)
+		panic("Failed to restore context from 0x%x%08x\n",
+		      (u32)(lpm_data.tifs_context_save_address >> 32),
+		      (u32)lpm_data.tifs_context_save_address);
+
+	image_entry = (image_entry_noargs_t)(uintptr_t)lpm_data.dm_jump_address;
+	printf("Resuming from DDR, jumping to stored DM loadaddr 0x%x%08x, TIFS context restored from 0x%x%08x\n",
+	       (u32)(lpm_data.dm_jump_address >> 32),
+	       (u32)lpm_data.dm_jump_address,
+	       (u32)(lpm_data.tifs_context_save_address >> 32),
+	       (u32)lpm_data.tifs_context_save_address);
+
+	image_entry();
+}
+#else
+
+void __noreturn lpm_resume_from_ddr(u64 meta_data_addr)
+{
+	panic("No IO+DDR support");
+}
+#endif
diff --git a/arch/arm/mach-k3/am62xx-lpm-common.h b/arch/arm/mach-k3/am62xx-lpm-common.h
index 2d110bcca0fc74ecd5424ae288d43519d0c05908..d5793759da4a05d355f5d88fbd8e103ebc46f9cc 100644
--- a/arch/arm/mach-k3/am62xx-lpm-common.h
+++ b/arch/arm/mach-k3/am62xx-lpm-common.h
@@ -13,5 +13,6 @@
 
 bool wkup_ctrl_is_lpm_exit(void);
 int wkup_ctrl_remove_can_io_isolation_if_set(void);
+void lpm_resume_from_ddr(u64 meta_data_addr);
 
 #endif  /* _AM62XX_LPM_COMMON_H_ */

-- 
2.51.0

