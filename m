Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DA7DCCFA13
	for <u-boot@archiver.kernel.org>; Mon, 10 Nov 2025 20:14:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03D3083E63;
	Mon, 10 Nov 2025 21:13:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="XugzJ7MV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5AAE983AA1; Mon, 10 Nov 2025 21:11:50 +0100 (CET)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A54983AA9
 for <u-boot@lists.denx.de>; Mon, 10 Nov 2025 21:11:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-6419b7b4b80so1917186a12.2
 for <u-boot@lists.denx.de>; Mon, 10 Nov 2025 12:11:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1762805508; x=1763410308;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=WrC9JMTc4ZxmFZdErBUGhBvZwwF+roj3RqZ+YbKthwg=;
 b=XugzJ7MV/8NwSN0aWy9p+odBrKgpXJWc/CpOB7nD1Zx0UqmQCmmrfIsadbyanT57wi
 4Eyn/0IudxgoczcyAEC2rXWLyk3FYUGbZlvTgr/6DF0c4lTnFOoUgLbWXTi6ccfLqoyQ
 GbE2J7IpehAzksP8KXlrg5ch74JnV5TLx7F8Rwv7PoIwj4PBvSibdh8PD+IB/NM6cIfE
 e2iU/3M+/qVK8nh0Xl1ZYdLsExcaJzHfuMdjqZjJOhGswvYqtgIx9twWSJnc9Txb0fDX
 3d8FVpAU7IaXE1K1heBI60vuWDqRX4VzZKCKy++t0W64TUg/RR3M50xeCUBXiayJT3M6
 Zdmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762805508; x=1763410308;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=WrC9JMTc4ZxmFZdErBUGhBvZwwF+roj3RqZ+YbKthwg=;
 b=t+BG/wm6h0rWdDFBWaCiEgwfkCu0tERsiOLfzCI2W+GzGuptKVve6nNGqctfhcWsaf
 zGFEZs3V4kqAo6HZmXRVkaGUZHyRLnr466UHC9JVyAc5lcznCHwKOGi3absuCktrYGeh
 xBaVrQNuoliQIDwIp92XfPx4YpS4U1wYolsV/fWPDMRb4lF30znT/JxPzGRpR+CAeXsZ
 1ZpDQMrNsX6Bd1XIZw4PV/7Phi4LEioW9VeODy6vPpnn+/DQ0NXBgY1AokQ10jnxQkQk
 TaH0Ljik+Fr5ZLm0NcGWunVDNAIp6027DDkoMHBQk+TPHLjYhFJSXPBwekoGyMZZrH4L
 b4rQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpkKL2m4hl8BEPzNiT9BLzYdmnKfSRnjwYuQT9SeHj4uu7CZaIeKmpAA5LiPLBOkTg3J2KvU8=@lists.denx.de
X-Gm-Message-State: AOJu0Yz7LHAxVzIGrlRBSRsy3BV8H/g0kICNoTY4L6dKVWhutpFB14yW
 8273xfMSOlr9xaaTMRBwXbKGsR8ITmDLkIn5UFGBcRDK1MBn6YX1k5AUUW3cv5ghfig=
X-Gm-Gg: ASbGncvuth+ER8H9sKJFdcgY0UBk5LABmf+N1eU/x8Z0rMLJGGA3tiB8T/tnJyMSD2M
 Cd2QpOyr3To6wmtbq2Z1TCZ/FTeAuTSf7tFIO+kJfyvqAgLPcnVOCu4kGPf6M7uTKHStt1HQf0X
 q2ov5Hvpd7+1TVBwZurRNWj4aqqZ/7L9Xrvj6c6cHKdSYBTk4pZV1mt7rHS2Bfjgg0o1EBPksDN
 2HDhyHuSKGaXZeS59ewO7R5UjXTLum1vUNAh+uPg2YX1Fh6IQ2QCYFZxPWiQnLSdT5zaiyObr2C
 IR4tcxxIp+E/iTJ2ucSt+Bx+LQwte9SvLxkjIkeKeT9tcuCb6O1Eh1d3/obpR1g37FFM7HD713y
 a30xuBLgKybO9RLBj5Df0nV83N9QwqFLJ44O4Zl9zHpYmeRfSYwmdXgahSwhi1rpQmflclqhXeJ
 1xyKgB/A==
X-Google-Smtp-Source: AGHT+IETvTf/PQWaeRx3GWWHBGKmQ8NMjojy4XIUOxkKfThLjdlNT/uXbl3th5BQbCgpvOGb3uVrIQ==
X-Received: by 2002:a17:906:9c82:b0:b3c:82d5:2119 with SMTP id
 a640c23a62f3a-b72e02b31afmr866753066b.6.1762805507739; 
 Mon, 10 Nov 2025 12:11:47 -0800 (PST)
Received: from localhost ([2001:4090:a247:830a:fe22:a8:f29a:a5c3])
 by smtp.gmail.com with UTF8SMTPSA id
 a640c23a62f3a-b72bf9be009sm1150409366b.60.2025.11.10.12.11.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Nov 2025 12:11:47 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Mon, 10 Nov 2025 21:10:31 +0100
Subject: [PATCH v5 07/13] arm: mach-k3: common: Helper for LPM meta data
 address from DT
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251110-topic-am62-ioddr-v2025-04-rc1-v5-7-980ee0036c26@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3158; i=msp@baylibre.com;
 h=from:subject:message-id; bh=VmwDAg15baCPPdVuZK58cRoyoCOZYnLWtEVPXqt9ixs=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkwht2s7GlnCV2ffj9yXtf7M4QcfdBVqtxiLlwXGX7ixf
 N6sCRtDO0pZGMS4GGTFFFk6E0PT/svvPJa8aNlmmDmsTCBDGLg4BWAiOscY/ucudYgv26oiXOXl
 sEDe/p/9GynthpIPXPt3PXsxJ8r8xxJGhvm/DE8FaJudTNthwzFrSsd5pk/+nQrKi26pHW4y9rY
 +xAYA
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

Add a small helper that uses memory regions referenced by the R5
devicetree node to calculate the LPM meta data address.

Tested-by: Anshul Dalal <anshuld@ti.com>
Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
---
 arch/arm/mach-k3/common.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-k3/common.h |  1 +
 2 files changed, 44 insertions(+)

diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
index 38d6c88644705ca55b669aee081c8bcf33df8540..0a49c99a36b4d09cb1de46c1e5266dd4cfc0cbe3 100644
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
@@ -190,6 +193,42 @@ bool wkup_ctrl_is_lpm_exit(void)
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
 static int lpm_restore_context(u64 ctx_addr)
 {
 	struct ti_sci_handle *ti_sci = get_ti_sci_handle();
@@ -231,6 +270,10 @@ void __noreturn lpm_resume_from_ddr(u64 meta_data_addr)
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
index 3333b30b56e711b082d4da7f6773cf0002bbfe30..c579796a7a3baec12792ad137c5c03e7ea361d55 100644
--- a/arch/arm/mach-k3/common.h
+++ b/arch/arm/mach-k3/common.h
@@ -53,6 +53,7 @@ void ti_secure_image_check_binary(void **p_image, size_t *p_size);
 int shutdown_mcu_r5_core1(void);
 void wkup_ctrl_remove_can_io_isolation_if_set(void);
 bool wkup_ctrl_is_lpm_exit(void);
+int wkup_r5f_am62_lpm_meta_data_addr(u64 *meta_data_addr);
 void lpm_resume_from_ddr(u64 meta_data_addr);
 
 #if (IS_ENABLED(CONFIG_K3_QOS))

-- 
2.51.0

