Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24651CF887B
	for <u-boot@archiver.kernel.org>; Thu, 20 Nov 2025 16:10:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B52284125;
	Thu, 20 Nov 2025 17:09:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="IQLhuWrI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 259028409B; Thu, 20 Nov 2025 17:05:10 +0100 (CET)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16F1C83935
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 17:05:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=msp@baylibre.com
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-b734fcbf1e3so188242966b.3
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 08:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1763654707; x=1764259507;
 darn=lists.denx.de; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=AgQsa5ZXGfhJxiutiGaEo/+x4xQPWY8qbN4BKWWAXTM=;
 b=IQLhuWrISgB+s2ttD9FacTf3hKybn3oyl3PJpwgPeclGgLnVrC7Kl2SaytO2dcUCEn
 MLI8gD6voIvMtnVN9V5/OAW9r2oyGazJexOrHyHTuTa5Ovlk0Iesrk5hR28jJWxd9awz
 3xLd85GSupYNPDdlLasSMKZEJlBUcp67yUbKPIvUdP0cJRtOgvI+GhjY0y6I0VvoU5Fo
 aW06vlDY/NhAJjk4OXb7Y3XS9ssDoMmjJQS9/J2omwsK0IV/DBFvgqv67Ngn6bHcPI70
 MzB5gELM2biStJFVWSlz9+cEPrVB8VLIPrqSkOHxmtFuXFBw0NcwFeaSN8VMTaEleb0F
 S9jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763654707; x=1764259507;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=AgQsa5ZXGfhJxiutiGaEo/+x4xQPWY8qbN4BKWWAXTM=;
 b=Ocmh+ZhAJlMIpwdrFDzRbaM/lhf7YM/I+5b/lWFwf4EvfFJblEckgOWN20CpsWYrXe
 rHYl8nDC+r/huP+93hJBa4vVaJQKsbvz+l+8JYBF8TfSe90PqbyssEgiBKYpSpowH20g
 Wya5VVFJ++6eDe21+jkFHu17FxzItC5pjvDpfEQjcScVKJvaw96CglVlwYrcY0ez4TYh
 ZR3XwGo0Xykep+NijmrHk0eFwn6HalDz1+AQOD999807DNvLCBmZzmqcHOSrfcbALvwb
 EUFbjl7OUkPstCDoNA6qPFzRn9Moe+mZLdPM6gXKI44Ap7yGYAlZgi9+aaeQA7KPukPw
 xyrw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXzHqpjf4VNkpcaSEVlewi5EvZuvkjv3GLrayfJFLP8zDPl5eSrdgHhxNz3cmr62kwNT61ukyo=@lists.denx.de
X-Gm-Message-State: AOJu0Yz9Odg0PI4xY954GvZlyuBGgunLSPh8FaDea/lMTJ3UnjSy5gj2
 SEpaLN7xpeucH3e1jxrt80TKqwz77gCNeba6O++0vPwMD/rXAlNymHXHY8ZhIUoIZKc=
X-Gm-Gg: ASbGncttJCAMjf+Ml5JQy2lJbXoQyT3t8W6PdSvAodhyAs4Wkbzth+ZfICujRHY+Ie8
 3MqsVS0oMWmRcyWr4Fc4sIXiNF4W+DF0PFdNz9RU6ZBnyN8dtc/i5RKENYmYTEqnK2ZwEHuudx0
 pStuegbbvkFeCCbuTs0JK57q3R8R4PpKQtIv0J+3Kmr9gWSoNPCDuI8kgd1O1Vg6t60rIWc8N8/
 aP2qt9IaXuNzDw1zNH4A7kgzKU5dDaXgBhq14ANcCrGX9ti1EwtIlYSZbAElB4TBUBRBtvFi+ZQ
 LJJsMsF/EYQyfTnMBz91LetaRFt09YHwpHhM+Ij2V5SUacqAFzLzp4LDKVX3zr23jyssi5ga/6D
 US3CikHuHFy8gr+0RtBoBB3ExJrvy30R+fE+Tp4ypmy5ryLO+FkKyXgWxKB+ArPehcU+f5jPsmk
 ixrNJSmiA=
X-Google-Smtp-Source: AGHT+IGeOqqyH/rhXRU8zoPg0DEbJTBMMVz7l8u0J+Kw/98gQl7ifQ3ad2QQHF8FQndIkT2rjcZ6kw==
X-Received: by 2002:a17:907:7fa9:b0:b75:7b39:88bc with SMTP id
 a640c23a62f3a-b766ac25a18mr3336166b.58.1763654707447; 
 Thu, 20 Nov 2025 08:05:07 -0800 (PST)
Received: from localhost ([2001:4090:a247:809c:875a:7c11:12fc:ed9])
 by smtp.gmail.com with UTF8SMTPSA id
 a640c23a62f3a-b7654ff3c6asm236253566b.52.2025.11.20.08.05.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Nov 2025 08:05:07 -0800 (PST)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Thu, 20 Nov 2025 17:03:24 +0100
Subject: [PATCH v6 07/13] arm: mach-k3: common: Helper for LPM meta data
 address from DT
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251120-topic-am62-ioddr-v2025-04-rc1-v6-7-6dd99a7271bb@baylibre.com>
References: <20251120-topic-am62-ioddr-v2025-04-rc1-v6-0-6dd99a7271bb@baylibre.com>
In-Reply-To: <20251120-topic-am62-ioddr-v2025-04-rc1-v6-0-6dd99a7271bb@baylibre.com>
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
 h=from:subject:message-id; bh=Ao2crEIjmlUz1TRvkLVOJmx6Hqcd2sEH6d1WbXO0/5o=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkx5G5bVlqt9fv5f/GSt6RZlt5qukhvTdkfnCbvuvf+yo
 WlSegNDRykLgxgXg6yYIktnYmjaf/mdx5IXLdsMM4eVCWQIAxenAEzklTojwwrP9mks2idDSz9v
 4l7GamQi0rLtQvD8Fy3PMx7t0Ph+ZRHDP7vOXRpnine41824x7grf8/7L3v8JYo8b9w/LvDUdE3
 dNS4A
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41
X-Mailman-Approved-At: Thu, 20 Nov 2025 17:09:03 +0100
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
index b28c2cd5776f29d75d54da9078e5fb17768d69c9..191254b391af68cb6c277f986069ed87211f2fc1 100644
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
@@ -191,6 +194,42 @@ bool wkup_ctrl_is_lpm_exit(void)
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
@@ -232,6 +271,10 @@ void __noreturn lpm_resume_from_ddr(u64 meta_data_addr)
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

