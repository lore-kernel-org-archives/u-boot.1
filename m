Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13C12C79FA5
	for <u-boot@archiver.kernel.org>; Mon,  5 Jan 2026 16:43:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CCC0883E8E;
	Mon,  5 Jan 2026 17:42:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="VLTs9ilV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C50E8398C; Mon,  5 Jan 2026 17:41:28 +0100 (CET)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D794183D71
 for <u-boot@lists.denx.de>; Mon,  5 Jan 2026 17:41:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wm1-x342.google.com with SMTP id
 5b1f17b1804b1-4779adb38d3so882905e9.2
 for <u-boot@lists.denx.de>; Mon, 05 Jan 2026 08:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1767631284; x=1768236084;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LXGqqMhOgM72PicPapDZFM/cucF/bdSLxHj+FrqVzi4=;
 b=VLTs9ilVxB/sf/AxKF9Ntlr/ko0Fz1PV1ht90L7H/ytBbCsQj7Sw+mFgSYblJxCqgV
 zHsUo90pF2nH02JJtv9f3FJ8Ugd5lcBgDcVl7vd/GQMbIuQGYbGAY/kXXlnWdeI1Yo4y
 Q9b3XzJ0tGNqHGtPiCLtBixy3kjeTskNiXWjseaPOyyCIpGIl1HS+qkn03s6czpzC8p/
 v94jw50VnYpFkvmuiWifgo+31wz8DRKRB/fuVfkWM78X83BRPhmbtWd3AYjEzLgODypi
 VxxDs/naXsE5dYd2h+3REYtRcZqIFjiy0DKNyLr0IAzFCJmFHsVA7lUNF90BIQ3jAfFq
 ombQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767631284; x=1768236084;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=LXGqqMhOgM72PicPapDZFM/cucF/bdSLxHj+FrqVzi4=;
 b=Nyxw1hBIusP6BPwZkSZ+Ehgv66Wg8BTkpieuY+f4To+WZH8HKzp3Y9WU/2B9MJYIOk
 NvaAlzv27uik2Fzo544k4B8DTm0nGPfkScw6aJJtGn/ZuV6CiJ+xSNoFpcqrzOFcyUfN
 MMuqKspUt0NP/BwYcL4eKyR1AiLISVPaLk+hkTiadeMBV5EtbclhR7Ye7rx8NNOVNkSi
 BeL+A1MHPpv1nSWuFny93Jw0Yk2ajIonXwpkjfUKu/epOOKE+fiHaXZ6uLrM5PSdf5CT
 UbYBpphDYOOn3aXqJK/RueqSKxfnkhBojjUexO/1I8z/VvTlMV/gmeHYlMYBou+vS7zA
 GEvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUt9ApBs+kJV1VuNpgTjV768olWDuIPruX3yqpYBB2FSfZlffPo/oU5kCiACIX+H+syElNi/Uo=@lists.denx.de
X-Gm-Message-State: AOJu0YwkCHNRVFDvboRgL03M5/LWAam1tawIiZD5ADgRLBMfG49aUsiv
 s65CdxCEFIYtsOtJ0w5gnde6/QnxF9HQ7rMOjpzvhFeGDNgwg1CSKDsS8XMShIysawE=
X-Gm-Gg: AY/fxX7gFpJkiRfuzwJg/XkEEUdMY9feW7L2O3iJoJPF1EGFPZtJSiMSi1c6OOBxok7
 F/tPSsq4Gh1S0vK91zIWobI8hYj4dxEpWVJVeHeCv908N9TpzreLWLcMwQkUPg8/MSOTKE3pEZ9
 j6UG+7s2dEvPrp4RTJ5iKOZ1HBB1ApWKtnfCizcLy9PxMdzyxcbl4EuKLOJ815moX+WP/ZqEmhS
 oG6A4+eQWKOt6MfSzBVEnOQS/EZnQtTo4i9zKSL4W+50o45++l27nUIRedkl9ThWrnjEvT1fpOE
 Wz6B05ZE4/ctjgn83Dazw0ip+pbtYCSKiF8xwk1XIBFkauxNNxUPn6ZopQFiRuGkT8skv/kZ2cq
 kP2mnrEgx+c2cpPdh4ytN//PgwjNV+rSDlT1GM/9ydWsOPSGBQPbTyVYBwZV0FrZS+scU1f/b3Y
 I4MckqYgV1
X-Google-Smtp-Source: AGHT+IEaR3prmk7z0MWU+5o/1hZr9yYR9Lbc7c4MGc7QyH4VxnSPxog+WOPfsJshSvHaEVdAwMK/Gw==
X-Received: by 2002:a05:600c:1f8b:b0:45d:d97c:236c with SMTP id
 5b1f17b1804b1-47d4846e310mr464544275e9.21.1767631284190; 
 Mon, 05 Jan 2026 08:41:24 -0800 (PST)
Received: from localhost ([2001:4091:a246:82fd:4350:c3d9:84a3:70dd])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d6d45bb57sm179261215e9.14.2026.01.05.08.41.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Jan 2026 08:41:23 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Mon, 05 Jan 2026 17:38:52 +0100
Subject: [PATCH v9 07/13] arm: mach-k3: am62xx-lpm-common: Helper for LPM
 meta data address from DT
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260105-topic-am62-ioddr-v2025-04-rc1-v9-7-7e33f2c77dbf@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3214; i=msp@baylibre.com;
 h=from:subject:message-id; bh=duT2j41enchv6Pq/f138ksXQNbnczAJlrcW1tiJJiIk=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhszol61sO+abP8vhUT+ve/djXGGNVYhQrU/SqsIpHZkPG
 pjUHs3pKGVhEONikBVTZOlMDE37L7/zWPKiZZth5rAygQxh4OIUgIn8f8fIsEJYlk/I8d7y2XtW
 Xl9Yd13pka7ZhB9uc7b2fFdaH3z6XB3D/4LNZflv5Bp2TDnr0DLJJuJf857sW6t8rdc8SHqt5a7
 WzQEA
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

Add a small helper that uses memory regions referenced by the R5
devicetree node to calculate the LPM meta data address.

Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
---
 arch/arm/mach-k3/am62xx-lpm-common.c | 45 ++++++++++++++++++++++++++++++++++++
 arch/arm/mach-k3/am62xx-lpm-common.h |  1 +
 2 files changed, 46 insertions(+)

diff --git a/arch/arm/mach-k3/am62xx-lpm-common.c b/arch/arm/mach-k3/am62xx-lpm-common.c
index fa068c60ce9ccf9cec89aeae1d224b07091a3298..6870395aec838949b5c25a32262a6c30e6c88d2e 100644
--- a/arch/arm/mach-k3/am62xx-lpm-common.c
+++ b/arch/arm/mach-k3/am62xx-lpm-common.c
@@ -9,6 +9,8 @@
 #include <config.h>
 #include <asm/arch/hardware.h>
 #include <asm/io.h>
+#include <dm/of_access.h>
+#include <dm/ofnode.h>
 #include <linux/soc/ti/ti_sci_protocol.h>
 #include <vsprintf.h>
 #include <wait_bit.h>
@@ -48,6 +50,8 @@
 #define WKUP_CTRL_MMR_CANUART_WAKE_OFF_MODE_STAT		0x18318
 #define WKUP_CTRL_MMR_CANUART_WAKE_OFF_MODE_STAT_MW		0x555555
 
+#define K3_R5_MEMREGION_LPM_METADATA_OFFSET	0x108000
+
 #define CLKSTOP_TRANSITION_TIMEOUT_MS	10
 
 static int wkup_ctrl_remove_can_io_isolation(void)
@@ -126,6 +130,43 @@ int __maybe_unused wkup_ctrl_remove_can_io_isolation_if_set(void)
 }
 
 #if IS_ENABLED(CONFIG_K3_IODDR)
+int wkup_r5f_am62_lpm_meta_data_addr(u64 *meta_data_addr)
+{
+	struct ofnode_phandle_args memregion_phandle;
+	ofnode memregion;
+	ofnode wkup_bus;
+	int ret;
+
+	wkup_bus = ofnode_path("/bus@f0000/bus@b00000");
+	if (!ofnode_valid(wkup_bus)) {
+		printf("Failed to find wkup bus\n");
+		return -EINVAL;
+	}
+
+	memregion = ofnode_by_compatible(wkup_bus, "ti,am62-r5f");
+	if (!ofnode_valid(memregion)) {
+		printf("Failed to find r5f devicetree node ti,am62-r5f\n");
+		return -EINVAL;
+	}
+
+	ret = ofnode_parse_phandle_with_args(memregion, "memory-region", NULL,
+					     0, 1, &memregion_phandle);
+	if (ret) {
+		printf("Failed to parse phandle for second memory region\n");
+		return ret;
+	}
+
+	ret = ofnode_read_u64_index(memregion_phandle.node, "reg", 0, meta_data_addr);
+	if (ret) {
+		printf("Failed to read memory region offset\n");
+		return ret;
+	}
+
+	*meta_data_addr += K3_R5_MEMREGION_LPM_METADATA_OFFSET;
+
+	return 0;
+}
+
 static int lpm_restore_context(u64 ctx_addr)
 {
 	struct ti_sci_handle *ti_sci = get_ti_sci_handle();
@@ -167,6 +208,10 @@ void __noreturn lpm_resume_from_ddr(u64 meta_data_addr)
 	image_entry();
 }
 #else
+int wkup_r5f_am62_lpm_meta_data_addr(u64 *meta_data_addr)
+{
+	return -EINVAL;
+}
 
 void __noreturn lpm_resume_from_ddr(u64 meta_data_addr)
 {
diff --git a/arch/arm/mach-k3/am62xx-lpm-common.h b/arch/arm/mach-k3/am62xx-lpm-common.h
index d5793759da4a05d355f5d88fbd8e103ebc46f9cc..741e3ccbcbd082da9d11c61624df8a4f456fd724 100644
--- a/arch/arm/mach-k3/am62xx-lpm-common.h
+++ b/arch/arm/mach-k3/am62xx-lpm-common.h
@@ -13,6 +13,7 @@
 
 bool wkup_ctrl_is_lpm_exit(void);
 int wkup_ctrl_remove_can_io_isolation_if_set(void);
+int wkup_r5f_am62_lpm_meta_data_addr(u64 *meta_data_addr);
 void lpm_resume_from_ddr(u64 meta_data_addr);
 
 #endif  /* _AM62XX_LPM_COMMON_H_ */

-- 
2.51.0

