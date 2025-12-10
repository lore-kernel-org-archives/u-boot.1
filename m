Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC403D3C925
	for <u-boot@archiver.kernel.org>; Wed, 10 Dec 2025 15:54:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27B1D83D1A;
	Wed, 10 Dec 2025 16:53:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="0ex9a/uf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0873E83A35; Wed, 10 Dec 2025 15:11:01 +0100 (CET)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EFEDB836C8
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 15:10:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-64312565c10so10963938a12.2
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 06:10:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1765375858; x=1765980658;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=scPqoX44GXGUzC9B+35HM0I4+UTgowYONX2S5Zp8lDU=;
 b=0ex9a/ufGxlJOZxWOcHVvGOqIDoDOKY27vdr3enVEjwdqhnXY9fQSJmV3O5Sr4gSox
 s8UpQvsMr4HpEqsNwxgUOWkyn95gK2A4jmAizkub8oINN3ZxzX1XknyDBqkxTLs09KnB
 2LQnhxt5fGETnIj7Dk9Wp+KDmjiRaUhEIywS2OzPU8XzQRR6LsbrfvjGn+pHLokBeyKJ
 ND+NY8y0Rbpd9zlEDr7Iue/N7kzdVhtJ8lKbYeEGvFse3lPMaKD76XrEhK/EZ1Z4trWm
 PlpPsTrwDxXhRDSGvburSeiSXPYNjyk4W/4hlgAiVX7tWkKhyN+OIIThJ8N3DjhfoMxo
 7B1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765375858; x=1765980658;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=scPqoX44GXGUzC9B+35HM0I4+UTgowYONX2S5Zp8lDU=;
 b=NiLtHRtocDA8asKUYAJWhbnFKeiOvhPFMLb8rJy0q9g1uTbJXx0484jC60Tu9UuZPU
 mz5PU6xwaVgTeY8ZRUQ4SY1UmZ23gsTlBvqnVxaOOCGtgjJzj+kCEDbvHWn5ZxAMJfpL
 LggsSiU3zEnx4WBxHw8gg2/Ib309lMjMTSgxrB4ATkkf7Dqzg7PKT2qUMiL5YpDvA1pQ
 88NB+zv14xy7TAI/dcEA5XOvbEqGv/hyC5GyQ+L6SDpxjQ6j5ezzBmcLAJIV4HpgE9P9
 RMJ5i/8jWgwCsKJiYgFB4cWMFdcJoSLtn39aAeBhbH5hGKO+1QC2rMzU+RUDvXY8D4Av
 NO5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXiWIugftABI29ot6QHn2OM+mo9vbL7YTpUZqM+KGp5Cq2C/EKl3rwTwA8YiqYJvDAIbxyOKSw=@lists.denx.de
X-Gm-Message-State: AOJu0YznBknMPuFARgv2ojUC+/1Pb/cy0CD0fPPXMxU3eSVL976eJOBe
 ID7tX9o3yWQcKWM2GpN2yb1wl9ukrDM6TvYvgodYYtTmMSb57D1MgMBZZyVIif/cnR0gQ8VKsuw
 DJCUB
X-Gm-Gg: ASbGncv6WdHB4Rb185xLRVCBD33w+EOJwPPWh54owpQSZT1+UoKdrwcC4SftgFByg89
 J5bUbOYT8mdHY1I6uSPCdYqfyqJN2jr3FCRVINi9uti7A/+j9dgN/fpLtWNvT1oQUWrGgy06jgQ
 cXSi9L9BBwZaMB+bSjG8vt4D6q1Avq7JQHn4jaqacrsrtZe/IQW1qwtNDeltJuUh8ShHJRpY2cl
 6CSzlbZ3RJngAh6xE7mSoP8mb0Yl4C4t23DdgraBFknEEQQnIzuvqiGgY7xUBt3QABwD3+B8Ydu
 aJMfOAkJDVpo159mKn0xqlkVSLrvmCqptNEinOw2Lm4ZKnfMAp2dh55OW1i4ba+KSNM0LQimz8T
 Kz+g5oSGHE8OG91a9jka2Vwukuf5V5Rd+6aDC5wgR5Mo17K8DE+LYQmCuKNFp35+lfq7L7/XkCT
 XnBXi1/by7AqtAOAdP61U=
X-Google-Smtp-Source: AGHT+IGrdZCn8/ivPQ0apmKZ/KrAE21O6z1kyF7aeXTGhZbpmq3U/w4Wugb2gr2D4Qxb/ZXn6SWY6g==
X-Received: by 2002:a17:906:d54a:b0:b73:8e7d:4fa3 with SMTP id
 a640c23a62f3a-b7ce846d1c1mr267796266b.32.1765375858325; 
 Wed, 10 Dec 2025 06:10:58 -0800 (PST)
Received: from localhost ([2001:4091:a246:86d6:2b1a:7262:ad08:3918])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b79f49a897fsm1690931866b.51.2025.12.10.06.10.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Dec 2025 06:10:57 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Wed, 10 Dec 2025 15:09:01 +0100
Subject: [PATCH v7 07/13] arm: mach-k3: common: Helper for LPM meta data
 address from DT
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251210-topic-am62-ioddr-v2025-04-rc1-v7-7-f113b156f83f@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3280; i=msp@baylibre.com;
 h=from:subject:message-id; bh=zSLYqt5O2FUJGHm0vgn5O1G8RSizn8siHj/tq8/f4eo=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkzLen3V2BNMUqL6O3isJ8/+oeUharbjiZjKC2G1uyfmc
 4qz+jzrKGVhEONikBVTZOlMDE37L7/zWPKiZZth5rAygQxh4OIUgIm8N2b4H1xuu+bjcYvVfMEl
 IQnLUuWm7P0XZb1u8pG5HDUu/LNrNBkZFqqfWnWqaOeCbl/uzPm+AZPf1m4s0jvj2PT6Tu06+e9
 /eAA=
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

Add a small helper that uses memory regions referenced by the R5
devicetree node to calculate the LPM meta data address.

Tested-by: Anshul Dalal <anshuld@ti.com>
Reviewed-by: Kendall Willis <k-willis@ti.com>
Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
---
 arch/arm/mach-k3/common.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-k3/common.h |  1 +
 2 files changed, 45 insertions(+)

diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
index ee56f0b86ce303e319cfcd2b0db3bade1540635b..f058e973d08e233a458892df86e6da22ba3852fe 100644
--- a/arch/arm/mach-k3/common.c
+++ b/arch/arm/mach-k3/common.c
@@ -16,6 +16,8 @@
 #include <linux/printk.h>
 #include "common.h"
 #include <dm.h>
+#include <dm/of_access.h>
+#include <dm/ofnode.h>
 #include <remoteproc.h>
 #include <asm/cache.h>
 #include <linux/soc/ti/ti_sci_protocol.h>
@@ -36,6 +38,7 @@
 #include <wait_bit.h>
 
 #define CLKSTOP_TRANSITION_TIMEOUT_MS	10
+#define K3_R5_MEMREGION_LPM_METADATA_OFFSET	0x108000
 
 #define PROC_BOOT_CTRL_FLAG_R5_CORE_HALT	0x00000001
 #define PROC_BOOT_STATUS_FLAG_R5_WFI		0x00000002
@@ -194,6 +197,43 @@ int __maybe_unused wkup_ctrl_remove_can_io_isolation_if_set(void)
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
@@ -235,6 +275,10 @@ void __noreturn lpm_resume_from_ddr(u64 meta_data_addr)
 	image_entry();
 }
 #else
+int wkup_r5f_am62_lpm_meta_data_addr(u64 *meta_data_addr)
+{
+	return -EINVAL;
+}
 
 void __noreturn lpm_resume_from_ddr(u64 meta_data_addr)
 {
diff --git a/arch/arm/mach-k3/common.h b/arch/arm/mach-k3/common.h
index 2c7cc552505bcdffc17fd469db3ee90779f3c192..c2632d4fb0a9b8fec137e4af33116773eb4ee633 100644
--- a/arch/arm/mach-k3/common.h
+++ b/arch/arm/mach-k3/common.h
@@ -53,6 +53,7 @@ void ti_secure_image_check_binary(void **p_image, size_t *p_size);
 int shutdown_mcu_r5_core1(void);
 bool wkup_ctrl_is_lpm_exit(void);
 int wkup_ctrl_remove_can_io_isolation_if_set(void);
+int wkup_r5f_am62_lpm_meta_data_addr(u64 *meta_data_addr);
 void lpm_resume_from_ddr(u64 meta_data_addr);
 
 #if IS_ENABLED(CONFIG_SPL_OS_BOOT_SECURE) && !IS_ENABLED(CONFIG_ARM64)

-- 
2.51.0

