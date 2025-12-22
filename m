Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D10AE69160
	for <u-boot@archiver.kernel.org>; Mon, 22 Dec 2025 20:05:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC63784106;
	Mon, 22 Dec 2025 21:04:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Zscr1EQi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CAD7383D1A; Mon, 22 Dec 2025 21:03:00 +0100 (CET)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A98E83EC0
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 21:02:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-wm1-x342.google.com with SMTP id
 5b1f17b1804b1-4779adb38d3so29030085e9.2
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 12:02:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1766433778; x=1767038578;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LXGqqMhOgM72PicPapDZFM/cucF/bdSLxHj+FrqVzi4=;
 b=Zscr1EQitSrJwZtZcW/9V3HKANPOskJAWeX/S4XzZZd+lmOlKjSknC9dxXjF5zvHUK
 32LJXPqyzFEDsiHXOp/LX9It8RgxnH37TTmf2aIDTYB1xx3p28cdT/+Xrzavku4EkXpR
 lHarweRZr6JvilCxSKfAAydfTO+0pJLtvTScd8iD+nG72qLBPVcqe7oMNdn05HJTGg3P
 gTixlDx/pL3p83wHF/udhjyypz+4D6QvYkYYpcffxKPAaCjDCe8tTtZQXFopkkbTFuY/
 ldPnSroQC2RoHhUlNbNUWL2PAMao5+mFznKduAnofrTSvZTGPFnZfw4cUZUy07F+Np0P
 Gl6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766433778; x=1767038578;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=LXGqqMhOgM72PicPapDZFM/cucF/bdSLxHj+FrqVzi4=;
 b=fUjs0zYmpawYQbUqRkN0jd0/XhbPXrUXjzXykxn3+GM29qkIN9pygQNrl+tEoIJS9x
 q+IkGhrUR1DQF+My/GOdD2Y4rl0TK/975yw1edKyJ3Rf+Jzmd8K2+spOPWCE5/lzsYYx
 0DaVgH4um6M9B6o6GEuImQkJDTRUb2WiljjJ+JPDKvSK+0rsDaW2fhg7W+s1Z8Okd850
 xtdPbG7onTaq0t7DgA8PHlxbnz8bMwNZYbl0UGSia1+zxF/Q4DZE9vOkFztLGqLyP5fS
 w/mKyoRlEBtjeZanM00G1EM8BV1aTTOiRZAhdsvYf5RYzGs+9xPkgARUuT8AmsCGBiQE
 I3RQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWuTQcw1qUwL96eho1jKten/rRnHewT6LIBHzkmPtV2G7RzJJNq7/puT+7FRXHUBOG1y19VBIk=@lists.denx.de
X-Gm-Message-State: AOJu0YxXQO5XlaPwgEnsL8rpekEZekDQK1JudVW8jQ8RUEKGYw+BI1TN
 4tl/XkxPorGWwKef6NsBJDj8ADvRCrstZAHHI4fprkyAh+Jaq7HhogebIh0leIzFKOc=
X-Gm-Gg: AY/fxX60IJT8PqFV+zZgVqHxpkD9NNBjhDHlsufyIf+o0M9NfMzyEDpfrsWbZOuQWNZ
 OEyaQ5XlarNZg24VxQYy6h/ocfKq8HBvUi3uKzXOlghTZB1HGvsasQZPZX5fe6cw4FiEN3v/bzF
 F07NBypmPskE5GqpmSqpgAVpk2wupWVon2yhP42N3f8nogxMYrJELZY6aogq+J+xtcLLR2MLlxa
 gxY8Q9OS1KDO3B/rJ2HXvN6EpBh0p0OH9PM6IZrZsofik2JWp4hOL1NORZLPKiTs1DLsZ39Fq5i
 ADTojLngGFYfoB/sv4SfTdLZKBsiGT+WkwSrO0ZGT06SFpPhzvooyawNa0tOrchIjr4+CgXLAPG
 bihx2U+K3l+XcXZfMc9D7YKV2HUd8TgbvSegMVme2o3hsmsGJzm5V+AcOvOpn2RDp/L2+sb/P76
 D55xFLQT9N
X-Google-Smtp-Source: AGHT+IH0xXb3n3TUck3lK5dvugEI7YnYu1tE6endNEiNdwW+XMxoCMsMQmmPxYsgcf/nttEGpbDyJw==
X-Received: by 2002:a05:600c:8116:b0:477:abea:9028 with SMTP id
 5b1f17b1804b1-47d1953bc47mr108401015e9.6.1766433777731; 
 Mon, 22 Dec 2025 12:02:57 -0800 (PST)
Received: from localhost ([2001:4091:a246:82fd:4350:c3d9:84a3:70dd])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be272e46fsm255166445e9.4.2025.12.22.12.02.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Dec 2025 12:02:57 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Mon, 22 Dec 2025 21:01:28 +0100
Subject: [PATCH v8 07/13] arm: mach-k3: am62xx-lpm-common: Helper for LPM
 meta data address from DT
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251222-topic-am62-ioddr-v2025-04-rc1-v8-7-e70fed16b166@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3214; i=msp@baylibre.com;
 h=from:subject:message-id; bh=duT2j41enchv6Pq/f138ksXQNbnczAJlrcW1tiJJiIk=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkzPxXsCzRSNqoJmOy7oc5jp+uazrOQtmS92+Sva2Wf5u
 suHBKh2lLIwiHExyIopsnQmhqb9l995LHnRss0wc1iZQIYwcHEKwEQOzGRk2FzvVnPGtqLCL0Qh
 xM8vjU/oXHdpy7/vaQI6oVlLDG8qMfyVOSd0ylefK/p8Z1uwd5ehd9ZnPusKyRP6cX3JfU1Mn5k B
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

