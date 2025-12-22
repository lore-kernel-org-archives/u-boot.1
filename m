Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 716F6E69166
	for <u-boot@archiver.kernel.org>; Mon, 22 Dec 2025 20:05:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 500C683FD4;
	Mon, 22 Dec 2025 21:04:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Iim5OXOm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42BB883DEB; Mon, 22 Dec 2025 21:02:59 +0100 (CET)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D96883B95
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 21:02:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wm1-x343.google.com with SMTP id
 5b1f17b1804b1-47d1d8a49f5so18615645e9.3
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 12:02:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1766433777; x=1767038577;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jLPCJgb06syJTNtIqYzYBBcRnIByanNnMTPTA3y88dY=;
 b=Iim5OXOm5+JKNyjWcsE55qwvpmExnh9BxBjFZnIweMxGzcmePEjGEzABM3EJ4+X5Zy
 Pa8W8zAtSE6GJdS57Jjm2d3Xnfvelbc6uPNdIBhEAw2OsHjhXWVtfJ6ScwQlbA+tKzSu
 KyhAXGy96s+cFxTkY2yg53VEw4uYbI4pKdHcnZI0iq7DG/ZkTfHx3NaOPlGsmPRrKEOK
 k9v1FC7jPMmwEmos4ZHTPNGEfkCBogGlOqA7RnjHxYyOIt/GLyoDd4gBUHGHI9ZV2vgX
 QpQdQ2KD5vKn0Lz0V8Bnnb4P4mfG9T9Uv8sDzaUJvrzSgPdN24S/Z+mz3wXAMK68efcu
 dhtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766433777; x=1767038577;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=jLPCJgb06syJTNtIqYzYBBcRnIByanNnMTPTA3y88dY=;
 b=qX1tOALbpVPbAUQvFs/AFT9P2eoHO0Xb8lKBnuWAglKYjtN3Qiqqw7MLUUro+lnDKY
 4gWdHSEa4UsKmB1/dH1BGX2CbpIj81H0GnhtxhoeGjl1qTjzguezWOmUWRIwrJFsiTfv
 AZQprqJ29tHBCsu6O8SwXRZh4Fzq5egKonDnbOXFXzO7fEMv82F4Z2/ObvVnwiRLrFxu
 Ft91b6pEOYSvbb2eQGeeUMb9Zcl1KA3al/us49OefmaCXinCnw0A4T5Toq3J/SVs+4m6
 YT/Lz4kXHkEpQIX7Qz9LXos4HVExhDzHlJEcaNAQwvi73e/d2JJdtQ8NwQYIcVEjZa5L
 b3CA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUH/VSOJWsWvrM1ImTJ8TUHWQH398mRvLasty2FXA9vGeniafhy5d39yfINCIoiMTDexh09HmQ=@lists.denx.de
X-Gm-Message-State: AOJu0Yxvb59lkl8z6yzsrxFXhv87pTdeaSmTQneL3xvDYF/OQSyWnd8F
 p3RVzPSO89yVlmREM1j//2/WPuLjiQ0jmHCesgDLqeBrGjCjGBpXy7MMq9m9/rY4dzU=
X-Gm-Gg: AY/fxX55Z2RcFhBPd7g7mJ0IZVwBRNc8g/38r73xZlcvqxSXvEMaBTiArtNwGwHk323
 Gsx9SgQEOzCSaKCnGrH/7oKUM2K0hIeLKjsSh3TqMnv+cLF7F/6DjVgV+7raEJTA+vb9krrDzAC
 A/+HhdSn/vWxyBcQVxnwY7Mxsij4mtLK+L5TZv28eRkjBQJVLcwVCHbwozF+R+xN+FGY6A8IxdK
 5VNn/wFl0c4GwMCdOmK9gkYabOm/cOYXcMjIkZ9mA5eq+9y98R+kl3B5JOnVYtqvDOW0JxUhLoU
 KdptNbpJTzLE+IfrJrEKr/dqBeTFQw+KVO+dNyX7UPTeODRQTPNxWTs11hP1w2hNexyKYSB00Vv
 CbWbf0V01Dhh3Ma2d37q8q2Uk9wDRP3ioFvQIC7oGJJVtcw8fxG6VWKionQuPzJ7L0Dq5tMKGVs
 5hegCO1sB3
X-Google-Smtp-Source: AGHT+IGKH+yNYJzfMtp02L2Qo3zQcqgq5SeGNj24/aF9RITTs7CtaoZr/2JDF5kpaCmbD3INmM9Dlg==
X-Received: by 2002:a05:600c:8116:b0:477:641a:1402 with SMTP id
 5b1f17b1804b1-47d1953bd09mr117117045e9.4.1766433776622; 
 Mon, 22 Dec 2025 12:02:56 -0800 (PST)
Received: from localhost ([2001:4091:a246:82fd:4350:c3d9:84a3:70dd])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be26a81b6sm263803335e9.0.2025.12.22.12.02.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Dec 2025 12:02:56 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Mon, 22 Dec 2025 21:01:27 +0100
Subject: [PATCH v8 06/13] arm: mach-k3: am62xx-lpm-common: Add
 lpm_resume_from_ddr
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251222-topic-am62-ioddr-v2025-04-rc1-v8-6-e70fed16b166@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3209; i=msp@baylibre.com;
 h=from:subject:message-id; bh=m43/06JDGncLCQ/lOVx3wFnPjsZSC4N56gpXOX5wcqk=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkzPxdsfHjnDoMCitN3Rm+ecot3EbbZXwn+pPPXew/u3+
 P7bSVOfdpSyMIhxMciKKbJ0Joam/ZffeSx50bLNMHNYmUCGMHBxCsBE2tUY/mf+fS2jtFVavdLq
 e+H8de3PVV/v6/Zl0Wbbp/WsPje/3ZSRYX7Ac8vVP/0+qNyZZpuXJOEyqX0ib2LSxyU9Wmf1pqy
 L4gQA
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

