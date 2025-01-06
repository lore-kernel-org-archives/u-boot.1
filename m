Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACF34E77188
	for <u-boot@archiver.kernel.org>; Mon,  6 Jan 2025 13:04:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C8A3C805C5;
	Mon,  6 Jan 2025 14:04:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="CATQWiOC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED351801C3; Mon,  6 Jan 2025 14:04:32 +0100 (CET)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DCBE48058A
 for <u-boot@lists.denx.de>; Mon,  6 Jan 2025 14:04:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=ventanamicro.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mchitale@ventanamicro.com
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2166360285dso207173155ad.1
 for <u-boot@lists.denx.de>; Mon, 06 Jan 2025 05:04:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1736168668; x=1736773468; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eNI3eck26caf4faqRhsQEICKMnk/bJVX4VuKlllV1kM=;
 b=CATQWiOC8nZbdGNT66VEkOukfqYvxocYx7RRvjzep6cZFFEfjLMsVnHbls09iYskRP
 XmtJl8jmF3IwQwMWIBnbDgD/PdEa/TheDLvBsJOP6xrAzmNI2Mj8916z2e+r6iUYiMli
 uRy71vOtT1mftUTWTJtxOQKm3TZTN1ld+qZddv7uj0B3u5nvsbiKAG5Uvu6AdKNQSyG9
 ku6rsBncxzflgRtkvYFtQEnE1LMsFJcDjGSYlieS6KemCGp1T5lf0/000YHJLVlAnD7E
 qi3TKdsNh7FUmc1vITKKLGRSwu7r8RmvIZ7CiAjEUlOKAt/q/I9UpczGZXiXpcUsemHF
 w0Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736168668; x=1736773468;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eNI3eck26caf4faqRhsQEICKMnk/bJVX4VuKlllV1kM=;
 b=uGkChcWnkeKuMjQEbSTrIcaXR6lwHfwB61NPE4FHbfEWnQ8sE8ItOnsuYRztWBD2Yv
 LZpIGruVMIk2pjWgZ7BgrFaoGipbhrClRRFqt4/WOwRJ80x0Q3tBHNytPNL1pFLBmuOA
 Jl5/QI+kHSE7hQmiv3A/zQzCY0C2Jdb65pgULlfuRJ7WEAgLSRM20zYHJPdGgbhjPzoA
 wZNvGIzoxKk/Qlnkyv4eLaWwbspPa4951Mo2jRRQu8irvw7KSQf3NTJqFalxylQ8RNxC
 mu1wO+OzjW8DqR5BGd6CFegsivCzbQkwQ/7oOPO4IQSh3Z8yyOznYi3fR5EqebLQMp/i
 VeOA==
X-Gm-Message-State: AOJu0YxzWWdSezE04I0v/ORpu3XNHjzr4nZ7a+wujVf6zEbhVf1/BNrY
 vkqyduot0TMnhMZ8v3Cm0bhBNoIojckk86OwiRffaMUljLMZ1Gu+bQF8SsN+fXzfBCMdjdGbLQL
 FrFU=
X-Gm-Gg: ASbGncuQD0AWxrfSflQ6WNhupOLLwPF9pNPFcviqViYdXLDXdT7XZF/mGcIJu8VV+Rd
 TUFIqXz8ENWC+fbTtQPMmAxDflpf/oZFn6pcnDlqS85EEN4Or529hamCPR+n2ZKDOP1T2+wy79g
 6R5my7kn/G9l+AbK3EdTNRSNeRJfvbKzdwJE8+AO/ocQ0FUW1+NJr94zrtX+jCfM9rGIpmS/nCX
 BaraZybhldWrNXwfunIWgblLUy/EC1AZK2ekLFCXoG8nAEx6fHswCQ=
X-Google-Smtp-Source: AGHT+IE+Cj0x/5HozDxpPkvBerc1V2pUVIj3rA0yx3QyHNQPstSSLWrVmWkq9AcdAsVnDlznkm9x0A==
X-Received: by 2002:a17:903:2282:b0:216:59ed:1ab0 with SMTP id
 d9443c01a7336-219e6eb3b88mr773137135ad.27.1736168667965; 
 Mon, 06 Jan 2025 05:04:27 -0800 (PST)
Received: from vm.. ([103.97.166.196]) by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-2f4477c8537sm33632428a91.21.2025.01.06.05.04.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2025 05:04:25 -0800 (PST)
From: Mayuresh Chitale <mchitale@ventanamicro.com>
To: u-boot@lists.denx.de
Cc: Mayuresh Chitale <mchitale@ventanamicro.com>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>, Conor Dooley <conor.dooley@microchip.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH v1 1/2] riscv: Enhance extension probing
Date: Mon,  6 Jan 2025 13:04:04 +0000
Message-Id: <20250106130405.220369-2-mchitale@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250106130405.220369-1-mchitale@ventanamicro.com>
References: <20250106130405.220369-1-mchitale@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Enhance the existing extension probing mechanism by adding support for
more extensions and probing using the "riscv,isa" property. This patch
is ported from the latest upstream linux.

Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
---
 arch/riscv/cpu/cpu.c                | 557 ++++++++++++++++++++++++++++
 arch/riscv/include/asm/cpufeature.h |  37 ++
 arch/riscv/include/asm/hwcap.h      | 105 ++++++
 3 files changed, 699 insertions(+)
 create mode 100644 arch/riscv/include/asm/cpufeature.h
 create mode 100644 arch/riscv/include/asm/hwcap.h

diff --git a/arch/riscv/cpu/cpu.c b/arch/riscv/cpu/cpu.c
index affe70081b5..f3f9f9f2351 100644
--- a/arch/riscv/cpu/cpu.c
+++ b/arch/riscv/cpu/cpu.c
@@ -14,8 +14,12 @@
 #include <log.h>
 #include <asm/encoding.h>
 #include <asm/system.h>
+#include <asm/hwcap.h>
+#include <asm/cpufeature.h>
 #include <dm/uclass-internal.h>
 #include <linux/bitops.h>
+#include <linux/log2.h>
+#include <linux/ctype.h>
 
 /*
  * The variables here must be stored in the data section since they are used
@@ -33,6 +37,559 @@ u32 available_harts_lock = 1;
 #endif
 #endif
 
+/* Host ISA bitmap */
+static DECLARE_BITMAP(riscv_isa, RISCV_ISA_EXT_MAX) __section(".data");
+
+static unsigned int riscv_cbom_block_size __section(".data");
+static unsigned int riscv_cboz_block_size __section(".data");
+/**
+ * __riscv_isa_extension_available() - Check whether given extension
+ * is available or not
+ *
+ * @bit: bit position of the desired extension
+ * Return: true or false
+ *
+ */
+static bool __riscv_isa_extension_available(unsigned int bit)
+{
+	if (bit >= RISCV_ISA_EXT_MAX)
+		return false;
+
+	return test_bit(bit, riscv_isa) ? true : false;
+}
+
+inline unsigned int riscv_get_cbom_block_size(void)
+{
+	return riscv_cbom_block_size;
+}
+
+inline unsigned int riscv_get_cboz_block_size(void)
+{
+	return riscv_cboz_block_size;
+}
+
+static int riscv_ext_zicbom_validate(const struct riscv_isa_ext_data *data,
+				     const unsigned long *isa_bitmap)
+{
+	struct udevice *dev;
+
+	if (!CONFIG_IS_ENABLED(RISCV_ISA_ZICBOM) || riscv_cbom_block_size)
+		return 0;
+
+	uclass_first_device(UCLASS_CPU, &dev);
+	if (!dev) {
+		log_info("Failed to get cpu device!\n");
+		return -ENXIO;
+	}
+
+	if (!dev_read_u32(dev, "riscv,cbom-block-size",
+			  &riscv_cbom_block_size)) {
+		if (!riscv_cbom_block_size) {
+			log_err("Zicbom detected in ISA string, disabling as no cbom-block-size found\n");
+			return -EINVAL;
+		}
+		if (!is_power_of_2(riscv_cbom_block_size)) {
+			log_err("Zicbom disabled as cbom-block-size present, but is not a power-of-2\n");
+			return -EINVAL;
+		}
+		return 0;
+	} else {
+		return -EINVAL;
+	}
+}
+
+static int riscv_ext_zicboz_validate(const struct riscv_isa_ext_data *data,
+				     const unsigned long *isa_bitmap)
+{
+	struct udevice *dev;
+
+	if (!CONFIG_IS_ENABLED(RISCV_ISA_ZICBOM) || riscv_cboz_block_size)
+		return 0;
+
+	uclass_first_device(UCLASS_CPU, &dev);
+	if (!dev) {
+		log_debug("Failed to get cpu device!\n");
+		return -ENXIO;
+	}
+
+	if (!dev_read_u32(dev, "riscv,cboz-block-size",
+			  &riscv_cboz_block_size)) {
+		if (!riscv_cboz_block_size) {
+			log_err("Zicboz detected in ISA string, disabling as no cboz-block-size found\n");
+			return -EINVAL;
+		}
+		if (!is_power_of_2(riscv_cboz_block_size)) {
+			log_err("Zicboz disabled as cboz-block-size present, but is not a power-of-2\n");
+			return -EINVAL;
+		}
+		return 0;
+	} else {
+		return -EINVAL;
+	}
+}
+
+static int riscv_ext_zca_depends(const struct riscv_isa_ext_data *data,
+				 const unsigned long *isa_bitmap)
+{
+	if (__riscv_isa_extension_available(RISCV_ISA_EXT_ZCA))
+		return 0;
+
+	return -EINVAL;
+}
+
+static int riscv_ext_zcd_validate(const struct riscv_isa_ext_data *data,
+				  const unsigned long *isa_bitmap)
+{
+	if (__riscv_isa_extension_available(RISCV_ISA_EXT_ZCA) &&
+	    __riscv_isa_extension_available(RISCV_ISA_EXT_d))
+		return 0;
+
+	return -EINVAL;
+}
+
+static int riscv_ext_zcf_validate(const struct riscv_isa_ext_data *data,
+				  const unsigned long *isa_bitmap)
+{
+	if (IS_ENABLED(CONFIG_64BIT))
+		return -EINVAL;
+
+	if (__riscv_isa_extension_available(RISCV_ISA_EXT_ZCA) &&
+	    __riscv_isa_extension_available(RISCV_ISA_EXT_f))
+		return 0;
+
+	return -EINVAL;
+}
+
+static const unsigned int riscv_zk_bundled_exts[] = {
+	RISCV_ISA_EXT_ZBKB,
+	RISCV_ISA_EXT_ZBKC,
+	RISCV_ISA_EXT_ZBKX,
+	RISCV_ISA_EXT_ZKND,
+	RISCV_ISA_EXT_ZKNE,
+	RISCV_ISA_EXT_ZKR,
+	RISCV_ISA_EXT_ZKT,
+};
+
+static const unsigned int riscv_zkn_bundled_exts[] = {
+	RISCV_ISA_EXT_ZBKB,
+	RISCV_ISA_EXT_ZBKC,
+	RISCV_ISA_EXT_ZBKX,
+	RISCV_ISA_EXT_ZKND,
+	RISCV_ISA_EXT_ZKNE,
+	RISCV_ISA_EXT_ZKNH,
+};
+
+static const unsigned int riscv_zks_bundled_exts[] = {
+	RISCV_ISA_EXT_ZBKB,
+	RISCV_ISA_EXT_ZBKC,
+	RISCV_ISA_EXT_ZKSED,
+	RISCV_ISA_EXT_ZKSH
+};
+
+#define RISCV_ISA_EXT_ZVKN	\
+	RISCV_ISA_EXT_ZVKNED,	\
+	RISCV_ISA_EXT_ZVKNHB,	\
+	RISCV_ISA_EXT_ZVKB,	\
+	RISCV_ISA_EXT_ZVKT
+
+static const unsigned int riscv_zvkn_bundled_exts[] = {
+	RISCV_ISA_EXT_ZVKN
+};
+
+static const unsigned int riscv_zvknc_bundled_exts[] = {
+	RISCV_ISA_EXT_ZVKN,
+	RISCV_ISA_EXT_ZVBC
+};
+
+static const unsigned int riscv_zvkng_bundled_exts[] = {
+	RISCV_ISA_EXT_ZVKN,
+	RISCV_ISA_EXT_ZVKG
+};
+
+#define RISCV_ISA_EXT_ZVKS	\
+	RISCV_ISA_EXT_ZVKSED,	\
+	RISCV_ISA_EXT_ZVKSH,	\
+	RISCV_ISA_EXT_ZVKB,	\
+	RISCV_ISA_EXT_ZVKT
+
+static const unsigned int riscv_zvks_bundled_exts[] = {
+	RISCV_ISA_EXT_ZVKS
+};
+
+static const unsigned int riscv_zvksc_bundled_exts[] = {
+	RISCV_ISA_EXT_ZVKS,
+	RISCV_ISA_EXT_ZVBC
+};
+
+static const unsigned int riscv_zvksg_bundled_exts[] = {
+	RISCV_ISA_EXT_ZVKS,
+	RISCV_ISA_EXT_ZVKG
+};
+
+static const unsigned int riscv_zvbb_exts[] = {
+	RISCV_ISA_EXT_ZVKB
+};
+
+#define RISCV_ISA_EXT_ZVE64F_IMPLY_LIST	\
+	RISCV_ISA_EXT_ZVE64X,		\
+	RISCV_ISA_EXT_ZVE32F,		\
+	RISCV_ISA_EXT_ZVE32X
+
+#define RISCV_ISA_EXT_ZVE64D_IMPLY_LIST	\
+	RISCV_ISA_EXT_ZVE64F,		\
+	RISCV_ISA_EXT_ZVE64F_IMPLY_LIST
+
+#define RISCV_ISA_EXT_V_IMPLY_LIST	\
+	RISCV_ISA_EXT_ZVE64D,		\
+	RISCV_ISA_EXT_ZVE64D_IMPLY_LIST
+
+static const unsigned int riscv_zve32f_exts[] = {
+	RISCV_ISA_EXT_ZVE32X
+};
+
+static const unsigned int riscv_zve64f_exts[] = {
+	RISCV_ISA_EXT_ZVE64F_IMPLY_LIST
+};
+
+static const unsigned int riscv_zve64d_exts[] = {
+	RISCV_ISA_EXT_ZVE64D_IMPLY_LIST
+};
+
+static const unsigned int riscv_v_exts[] = {
+	RISCV_ISA_EXT_V_IMPLY_LIST
+};
+
+static const unsigned int riscv_zve64x_exts[] = {
+	RISCV_ISA_EXT_ZVE32X,
+	RISCV_ISA_EXT_ZVE64X
+};
+
+/*
+ * While the [ms]envcfg CSRs were not defined until version 1.12 of the RISC-V
+ * privileged ISA, the existence of the CSRs is implied by any extension which
+ * specifies [ms]envcfg bit(s). Hence, we define a custom ISA extension for the
+ * existence of the CSR, and treat it as a subset of those other extensions.
+ */
+static const unsigned int riscv_xlinuxenvcfg_exts[] = {
+	RISCV_ISA_EXT_XLINUXENVCFG
+};
+
+/*
+ * Zc* spec states that:
+ * - C always implies Zca
+ * - C+F implies Zcf (RV32 only)
+ * - C+D implies Zcd
+ *
+ * These extensions will be enabled and then validated depending on the
+ * availability of F/D RV32.
+ */
+static const unsigned int riscv_c_exts[] = {
+	RISCV_ISA_EXT_ZCA,
+	RISCV_ISA_EXT_ZCF,
+	RISCV_ISA_EXT_ZCD,
+};
+
+/*
+ * The canonical order of ISA extension names in the ISA string is defined in
+ * chapter 27 of the unprivileged specification.
+ *
+ * Ordinarily, for in-kernel data structures, this order is unimportant but
+ * isa_ext_arr defines the order of the ISA string in /proc/cpuinfo.
+ *
+ * The specification uses vague wording, such as should, when it comes to
+ * ordering, so for our purposes the following rules apply:
+ *
+ * 1. All multi-letter extensions must be separated from other extensions by an
+ *    underscore.
+ *
+ * 2. Additional standard extensions (starting with 'Z') must be sorted after
+ *    single-letter extensions and before any higher-privileged extensions.
+ *
+ * 3. The first letter following the 'Z' conventionally indicates the most
+ *    closely related alphabetical extension category, IMAFDQLCBKJTPVH.
+ *    If multiple 'Z' extensions are named, they must be ordered first by
+ *    category, then alphabetically within a category.
+ *
+ * 3. Standard supervisor-level extensions (starting with 'S') must be listed
+ *    after standard unprivileged extensions.  If multiple supervisor-level
+ *    extensions are listed, they must be ordered alphabetically.
+ *
+ * 4. Standard machine-level extensions (starting with 'Zxm') must be listed
+ *    after any lower-privileged, standard extensions.  If multiple
+ *    machine-level extensions are listed, they must be ordered
+ *    alphabetically.
+ *
+ * 5. Non-standard extensions (starting with 'X') must be listed after all
+ *    standard extensions. If multiple non-standard extensions are listed, they
+ *    must be ordered alphabetically.
+ *
+ * An example string following the order is:
+ *    rv64imadc_zifoo_zigoo_zafoo_sbar_scar_zxmbaz_xqux_xrux
+ *
+ * New entries to this struct should follow the ordering rules described above.
+ */
+const struct riscv_isa_ext_data riscv_isa_ext[] = {
+	__RISCV_ISA_EXT_DATA(i, RISCV_ISA_EXT_i),
+	__RISCV_ISA_EXT_DATA(m, RISCV_ISA_EXT_m),
+	__RISCV_ISA_EXT_DATA(a, RISCV_ISA_EXT_a),
+	__RISCV_ISA_EXT_DATA(f, RISCV_ISA_EXT_f),
+	__RISCV_ISA_EXT_DATA(d, RISCV_ISA_EXT_d),
+	__RISCV_ISA_EXT_DATA(q, RISCV_ISA_EXT_q),
+	__RISCV_ISA_EXT_SUPERSET(c, RISCV_ISA_EXT_c, riscv_c_exts),
+	__RISCV_ISA_EXT_SUPERSET(v, RISCV_ISA_EXT_v, riscv_v_exts),
+	__RISCV_ISA_EXT_DATA(h, RISCV_ISA_EXT_h),
+	__RISCV_ISA_EXT_SUPERSET_VALIDATE(zicbom, RISCV_ISA_EXT_ZICBOM, riscv_xlinuxenvcfg_exts,
+					  riscv_ext_zicbom_validate),
+	__RISCV_ISA_EXT_SUPERSET_VALIDATE(zicboz, RISCV_ISA_EXT_ZICBOZ, riscv_xlinuxenvcfg_exts,
+					  riscv_ext_zicboz_validate),
+	__RISCV_ISA_EXT_DATA(zicntr, RISCV_ISA_EXT_ZICNTR),
+	__RISCV_ISA_EXT_DATA(zicond, RISCV_ISA_EXT_ZICOND),
+	__RISCV_ISA_EXT_DATA(zicsr, RISCV_ISA_EXT_ZICSR),
+	__RISCV_ISA_EXT_DATA(zifencei, RISCV_ISA_EXT_ZIFENCEI),
+	__RISCV_ISA_EXT_DATA(zihintntl, RISCV_ISA_EXT_ZIHINTNTL),
+	__RISCV_ISA_EXT_DATA(zihintpause, RISCV_ISA_EXT_ZIHINTPAUSE),
+	__RISCV_ISA_EXT_DATA(zihpm, RISCV_ISA_EXT_ZIHPM),
+	__RISCV_ISA_EXT_DATA(zimop, RISCV_ISA_EXT_ZIMOP),
+	__RISCV_ISA_EXT_DATA(zacas, RISCV_ISA_EXT_ZACAS),
+	__RISCV_ISA_EXT_DATA(zawrs, RISCV_ISA_EXT_ZAWRS),
+	__RISCV_ISA_EXT_DATA(zfa, RISCV_ISA_EXT_ZFA),
+	__RISCV_ISA_EXT_DATA(zfh, RISCV_ISA_EXT_ZFH),
+	__RISCV_ISA_EXT_DATA(zfhmin, RISCV_ISA_EXT_ZFHMIN),
+	__RISCV_ISA_EXT_DATA(zca, RISCV_ISA_EXT_ZCA),
+	__RISCV_ISA_EXT_DATA_VALIDATE(zcb, RISCV_ISA_EXT_ZCB, riscv_ext_zca_depends),
+	__RISCV_ISA_EXT_DATA_VALIDATE(zcd, RISCV_ISA_EXT_ZCD, riscv_ext_zcd_validate),
+	__RISCV_ISA_EXT_DATA_VALIDATE(zcf, RISCV_ISA_EXT_ZCF, riscv_ext_zcf_validate),
+	__RISCV_ISA_EXT_DATA_VALIDATE(zcmop, RISCV_ISA_EXT_ZCMOP, riscv_ext_zca_depends),
+	__RISCV_ISA_EXT_DATA(zba, RISCV_ISA_EXT_ZBA),
+	__RISCV_ISA_EXT_DATA(zbb, RISCV_ISA_EXT_ZBB),
+	__RISCV_ISA_EXT_DATA(zbc, RISCV_ISA_EXT_ZBC),
+	__RISCV_ISA_EXT_DATA(zbkb, RISCV_ISA_EXT_ZBKB),
+	__RISCV_ISA_EXT_DATA(zbkc, RISCV_ISA_EXT_ZBKC),
+	__RISCV_ISA_EXT_DATA(zbkx, RISCV_ISA_EXT_ZBKX),
+	__RISCV_ISA_EXT_DATA(zbs, RISCV_ISA_EXT_ZBS),
+	__RISCV_ISA_EXT_BUNDLE(zk, riscv_zk_bundled_exts),
+	__RISCV_ISA_EXT_BUNDLE(zkn, riscv_zkn_bundled_exts),
+	__RISCV_ISA_EXT_DATA(zknd, RISCV_ISA_EXT_ZKND),
+	__RISCV_ISA_EXT_DATA(zkne, RISCV_ISA_EXT_ZKNE),
+	__RISCV_ISA_EXT_DATA(zknh, RISCV_ISA_EXT_ZKNH),
+	__RISCV_ISA_EXT_DATA(zkr, RISCV_ISA_EXT_ZKR),
+	__RISCV_ISA_EXT_BUNDLE(zks, riscv_zks_bundled_exts),
+	__RISCV_ISA_EXT_DATA(zkt, RISCV_ISA_EXT_ZKT),
+	__RISCV_ISA_EXT_DATA(zksed, RISCV_ISA_EXT_ZKSED),
+	__RISCV_ISA_EXT_DATA(zksh, RISCV_ISA_EXT_ZKSH),
+	__RISCV_ISA_EXT_DATA(ztso, RISCV_ISA_EXT_ZTSO),
+	__RISCV_ISA_EXT_SUPERSET(zvbb, RISCV_ISA_EXT_ZVBB, riscv_zvbb_exts),
+	__RISCV_ISA_EXT_DATA(zvbc, RISCV_ISA_EXT_ZVBC),
+	__RISCV_ISA_EXT_SUPERSET(zve32f, RISCV_ISA_EXT_ZVE32F, riscv_zve32f_exts),
+	__RISCV_ISA_EXT_DATA(zve32x, RISCV_ISA_EXT_ZVE32X),
+	__RISCV_ISA_EXT_SUPERSET(zve64d, RISCV_ISA_EXT_ZVE64D, riscv_zve64d_exts),
+	__RISCV_ISA_EXT_SUPERSET(zve64f, RISCV_ISA_EXT_ZVE64F, riscv_zve64f_exts),
+	__RISCV_ISA_EXT_SUPERSET(zve64x, RISCV_ISA_EXT_ZVE64X, riscv_zve64x_exts),
+	__RISCV_ISA_EXT_DATA(zvfh, RISCV_ISA_EXT_ZVFH),
+	__RISCV_ISA_EXT_DATA(zvfhmin, RISCV_ISA_EXT_ZVFHMIN),
+	__RISCV_ISA_EXT_DATA(zvkb, RISCV_ISA_EXT_ZVKB),
+	__RISCV_ISA_EXT_DATA(zvkg, RISCV_ISA_EXT_ZVKG),
+	__RISCV_ISA_EXT_BUNDLE(zvkn, riscv_zvkn_bundled_exts),
+	__RISCV_ISA_EXT_BUNDLE(zvknc, riscv_zvknc_bundled_exts),
+	__RISCV_ISA_EXT_DATA(zvkned, RISCV_ISA_EXT_ZVKNED),
+	__RISCV_ISA_EXT_BUNDLE(zvkng, riscv_zvkng_bundled_exts),
+	__RISCV_ISA_EXT_DATA(zvknha, RISCV_ISA_EXT_ZVKNHA),
+	__RISCV_ISA_EXT_DATA(zvknhb, RISCV_ISA_EXT_ZVKNHB),
+	__RISCV_ISA_EXT_BUNDLE(zvks, riscv_zvks_bundled_exts),
+	__RISCV_ISA_EXT_BUNDLE(zvksc, riscv_zvksc_bundled_exts),
+	__RISCV_ISA_EXT_DATA(zvksed, RISCV_ISA_EXT_ZVKSED),
+	__RISCV_ISA_EXT_DATA(zvksh, RISCV_ISA_EXT_ZVKSH),
+	__RISCV_ISA_EXT_BUNDLE(zvksg, riscv_zvksg_bundled_exts),
+	__RISCV_ISA_EXT_DATA(zvkt, RISCV_ISA_EXT_ZVKT),
+	__RISCV_ISA_EXT_DATA(smaia, RISCV_ISA_EXT_SMAIA),
+	__RISCV_ISA_EXT_DATA(smmpm, RISCV_ISA_EXT_SMMPM),
+	__RISCV_ISA_EXT_SUPERSET(smnpm, RISCV_ISA_EXT_SMNPM, riscv_xlinuxenvcfg_exts),
+	__RISCV_ISA_EXT_DATA(smstateen, RISCV_ISA_EXT_SMSTATEEN),
+	__RISCV_ISA_EXT_DATA(ssaia, RISCV_ISA_EXT_SSAIA),
+	__RISCV_ISA_EXT_DATA(sscofpmf, RISCV_ISA_EXT_SSCOFPMF),
+	__RISCV_ISA_EXT_SUPERSET(ssnpm, RISCV_ISA_EXT_SSNPM, riscv_xlinuxenvcfg_exts),
+	__RISCV_ISA_EXT_DATA(sstc, RISCV_ISA_EXT_SSTC),
+	__RISCV_ISA_EXT_DATA(svinval, RISCV_ISA_EXT_SVINVAL),
+	__RISCV_ISA_EXT_DATA(svnapot, RISCV_ISA_EXT_SVNAPOT),
+	__RISCV_ISA_EXT_DATA(svpbmt, RISCV_ISA_EXT_SVPBMT),
+	__RISCV_ISA_EXT_DATA(svvptc, RISCV_ISA_EXT_SVVPTC),
+};
+
+const size_t riscv_isa_ext_count = ARRAY_SIZE(riscv_isa_ext);
+
+static void riscv_isa_set_ext(const struct riscv_isa_ext_data *ext, unsigned long *bitmap)
+{
+	if (ext->id != RISCV_ISA_EXT_INVALID)
+		__set_bit(ext->id, bitmap);
+
+	for (int i = 0; i < ext->subset_ext_size; i++) {
+		if (ext->subset_ext_ids[i] != RISCV_ISA_EXT_INVALID)
+			__set_bit(ext->subset_ext_ids[i], bitmap);
+	}
+}
+
+static void match_isa_ext(const char *name, const char *name_end)
+{
+	for (int i = 0; i < riscv_isa_ext_count; i++) {
+		const struct riscv_isa_ext_data *ext = &riscv_isa_ext[i];
+
+		if ((name_end - name == strlen(ext->name)) &&
+		    !strncasecmp(name, ext->name, name_end - name)) {
+			if (ext->validate && !ext->validate(ext, riscv_isa))
+				riscv_isa_set_ext(ext, riscv_isa);
+			break;
+		}
+	}
+}
+
+static void riscv_parse_isa_string(const char *isa)
+{
+	/*
+	 * For all possible cpus, we have already validated in
+	 * the boot process that they at least contain "rv" and
+	 * whichever of "32"/"64" this kernel supports, and so this
+	 * section can be skipped.
+	 */
+	isa += 4;
+
+	while (*isa) {
+		const char *ext = isa++;
+		const char *ext_end = isa;
+		bool ext_err = false;
+
+		switch (*ext) {
+		case 'x':
+		case 'X':
+			log_warning("Vendor extensions are ignored in riscv,isa. Use riscv,isa-extensions instead.");
+			/*
+			 * To skip an extension, we find its end.
+			 * As multi-letter extensions must be split from other multi-letter
+			 * extensions with an "_", the end of a multi-letter extension will
+			 * either be the null character or the "_" at the start of the next
+			 * multi-letter extension.
+			 */
+			for (; *isa && *isa != '_'; ++isa)
+				;
+			ext_err = true;
+			break;
+		case 's':
+			/*
+			 * Workaround for invalid single-letter 's' & 'u' (QEMU).
+			 * No need to set the bit in riscv_isa as 's' & 'u' are
+			 * not valid ISA extensions. It works unless the first
+			 * multi-letter extension in the ISA string begins with
+			 * "Su" and is not prefixed with an underscore.
+			 */
+			if (ext[-1] != '_' && ext[1] == 'u') {
+				++isa;
+				ext_err = true;
+				break;
+			}
+			fallthrough;
+		case 'S':
+		case 'z':
+		case 'Z':
+			/*
+			 * Before attempting to parse the extension itself, we find its end.
+			 * As multi-letter extensions must be split from other multi-letter
+			 * extensions with an "_", the end of a multi-letter extension will
+			 * either be the null character or the "_" at the start of the next
+			 * multi-letter extension.
+			 *
+			 * Next, as the extensions version is currently ignored, we
+			 * eliminate that portion. This is done by parsing backwards from
+			 * the end of the extension, removing any numbers. This may be a
+			 * major or minor number however, so the process is repeated if a
+			 * minor number was found.
+			 *
+			 * ext_end is intended to represent the first character *after* the
+			 * name portion of an extension, but will be decremented to the last
+			 * character itself while eliminating the extensions version number.
+			 * A simple re-increment solves this problem.
+			 */
+			for (; *isa && *isa != '_'; ++isa)
+				if (unlikely(!isalnum(*isa)))
+					ext_err = true;
+
+			ext_end = isa;
+			if (unlikely(ext_err))
+				break;
+
+			if (!isdigit(ext_end[-1]))
+				break;
+
+			while (isdigit(*--ext_end))
+				;
+
+			if (tolower(ext_end[0]) != 'p' || !isdigit(ext_end[-1])) {
+				++ext_end;
+				break;
+			}
+
+			while (isdigit(*--ext_end))
+				;
+
+			++ext_end;
+			break;
+		default:
+			/*
+			 * Things are a little easier for single-letter extensions, as they
+			 * are parsed forwards.
+			 *
+			 * After checking that our starting position is valid, we need to
+			 * ensure that, when isa was incremented at the start of the loop,
+			 * that it arrived at the start of the next extension.
+			 *
+			 * If we are already on a non-digit, there is nothing to do. Either
+			 * we have a multi-letter extension's _, or the start of an
+			 * extension.
+			 *
+			 * Otherwise we have found the current extension's major version
+			 * number. Parse past it, and a subsequent p/minor version number
+			 * if present. The `p` extension must not appear immediately after
+			 * a number, so there is no fear of missing it.
+			 *
+			 */
+			if (unlikely(!isalpha(*ext))) {
+				ext_err = true;
+				break;
+			}
+
+			if (!isdigit(*isa))
+				break;
+
+			while (isdigit(*++isa))
+				;
+
+			if (tolower(*isa) != 'p')
+				break;
+
+			if (!isdigit(*++isa)) {
+				--isa;
+				break;
+			}
+
+			while (isdigit(*++isa))
+				;
+
+			break;
+		}
+
+		/*
+		 * The parser expects that at the start of an iteration isa points to the
+		 * first character of the next extension. As we stop parsing an extension
+		 * on meeting a non-alphanumeric character, an extra increment is needed
+		 * where the succeeding extension is a multi-letter prefixed with an "_".
+		 */
+		if (*isa == '_')
+			++isa;
+
+		if (unlikely(ext_err))
+			continue;
+		match_isa_ext(ext, ext_end);
+	}
+}
+
 static inline bool supports_extension(char ext)
 {
 #if CONFIG_IS_ENABLED(RISCV_MMODE)
diff --git a/arch/riscv/include/asm/cpufeature.h b/arch/riscv/include/asm/cpufeature.h
new file mode 100644
index 00000000000..655180c993e
--- /dev/null
+++ b/arch/riscv/include/asm/cpufeature.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef _ASM_CPUFEATURE_H
+#define _ASM_CPUFEATURE_H
+struct riscv_isa_ext_data {
+	const unsigned int id;
+	const char *name;
+	const char *property;
+	const unsigned int *subset_ext_ids;
+	const unsigned int subset_ext_size;
+	int (*validate)(const struct riscv_isa_ext_data *data, const unsigned long *isa_bitmap);
+};
+
+#define _RISCV_ISA_EXT_DATA(_name, _id, _subset_exts, _subset_exts_size, _validate) {	\
+	.name = #_name,									\
+	.property = #_name,								\
+	.id = _id,									\
+	.subset_ext_ids = _subset_exts,							\
+	.subset_ext_size = _subset_exts_size,						\
+	.validate = _validate								\
+}
+
+#define __RISCV_ISA_EXT_DATA(_name, _id) _RISCV_ISA_EXT_DATA(_name, _id, NULL, 0, NULL)
+#define __RISCV_ISA_EXT_DATA_VALIDATE(_name, _id, _validate) \
+			_RISCV_ISA_EXT_DATA(_name, _id, NULL, 0, _validate)
+
+/* Used to declare pure "lasso" extension (Zk for instance) */
+#define __RISCV_ISA_EXT_BUNDLE(_name, _bundled_exts) \
+	_RISCV_ISA_EXT_DATA(_name, RISCV_ISA_EXT_INVALID, _bundled_exts, \
+			    ARRAY_SIZE(_bundled_exts), NULL)
+
+/* Used to declare extensions that are a superset of other extensions (Zvbb for instance) */
+#define __RISCV_ISA_EXT_SUPERSET(_name, _id, _sub_exts) \
+	_RISCV_ISA_EXT_DATA(_name, _id, _sub_exts, ARRAY_SIZE(_sub_exts), NULL)
+#define __RISCV_ISA_EXT_SUPERSET_VALIDATE(_name, _id, _sub_exts, _validate) \
+	_RISCV_ISA_EXT_DATA(_name, _id, _sub_exts, ARRAY_SIZE(_sub_exts), _validate)
+#endif
diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
new file mode 100644
index 00000000000..aa68ada6b2b
--- /dev/null
+++ b/arch/riscv/include/asm/hwcap.h
@@ -0,0 +1,105 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef _ASM_RISCV_HWCAP_H
+#define _ASM_RISCV_HWCAP_H
+
+#define RISCV_ISA_EXT_a		('a' - 'a')
+#define RISCV_ISA_EXT_c		('c' - 'a')
+#define RISCV_ISA_EXT_d		('d' - 'a')
+#define RISCV_ISA_EXT_f		('f' - 'a')
+#define RISCV_ISA_EXT_h		('h' - 'a')
+#define RISCV_ISA_EXT_i		('i' - 'a')
+#define RISCV_ISA_EXT_m		('m' - 'a')
+#define RISCV_ISA_EXT_q		('q' - 'a')
+#define RISCV_ISA_EXT_v		('v' - 'a')
+
+/*
+ * These macros represent the logical IDs of each multi-letter RISC-V ISA
+ * extension and are used in the ISA bitmap. The logical IDs start from
+ * RISCV_ISA_EXT_BASE, which allows the 0-25 range to be reserved for single
+ * letter extensions. The maximum, RISCV_ISA_EXT_MAX, is defined in order
+ * to allocate the bitmap and may be increased when necessary.
+ *
+ * New extensions should just be added to the bottom, rather than added
+ * alphabetically, in order to avoid unnecessary shuffling.
+ */
+#define RISCV_ISA_EXT_BASE		26
+
+#define RISCV_ISA_EXT_SSCOFPMF		26
+#define RISCV_ISA_EXT_SSTC		27
+#define RISCV_ISA_EXT_SVINVAL		28
+#define RISCV_ISA_EXT_SVPBMT		29
+#define RISCV_ISA_EXT_ZBB		30
+#define RISCV_ISA_EXT_ZICBOM		31
+#define RISCV_ISA_EXT_ZIHINTPAUSE	32
+#define RISCV_ISA_EXT_SVNAPOT		33
+#define RISCV_ISA_EXT_ZICBOZ		34
+#define RISCV_ISA_EXT_SMAIA		35
+#define RISCV_ISA_EXT_SSAIA		36
+#define RISCV_ISA_EXT_ZBA		37
+#define RISCV_ISA_EXT_ZBS		38
+#define RISCV_ISA_EXT_ZICNTR		39
+#define RISCV_ISA_EXT_ZICSR		40
+#define RISCV_ISA_EXT_ZIFENCEI		41
+#define RISCV_ISA_EXT_ZIHPM		42
+#define RISCV_ISA_EXT_SMSTATEEN		43
+#define RISCV_ISA_EXT_ZICOND		44
+#define RISCV_ISA_EXT_ZBC		45
+#define RISCV_ISA_EXT_ZBKB		46
+#define RISCV_ISA_EXT_ZBKC		47
+#define RISCV_ISA_EXT_ZBKX		48
+#define RISCV_ISA_EXT_ZKND		49
+#define RISCV_ISA_EXT_ZKNE		50
+#define RISCV_ISA_EXT_ZKNH		51
+#define RISCV_ISA_EXT_ZKR		52
+#define RISCV_ISA_EXT_ZKSED		53
+#define RISCV_ISA_EXT_ZKSH		54
+#define RISCV_ISA_EXT_ZKT		55
+#define RISCV_ISA_EXT_ZVBB		56
+#define RISCV_ISA_EXT_ZVBC		57
+#define RISCV_ISA_EXT_ZVKB		58
+#define RISCV_ISA_EXT_ZVKG		59
+#define RISCV_ISA_EXT_ZVKNED		60
+#define RISCV_ISA_EXT_ZVKNHA		61
+#define RISCV_ISA_EXT_ZVKNHB		62
+#define RISCV_ISA_EXT_ZVKSED		63
+#define RISCV_ISA_EXT_ZVKSH		64
+#define RISCV_ISA_EXT_ZVKT		65
+#define RISCV_ISA_EXT_ZFH		66
+#define RISCV_ISA_EXT_ZFHMIN		67
+#define RISCV_ISA_EXT_ZIHINTNTL		68
+#define RISCV_ISA_EXT_ZVFH		69
+#define RISCV_ISA_EXT_ZVFHMIN		70
+#define RISCV_ISA_EXT_ZFA		71
+#define RISCV_ISA_EXT_ZTSO		72
+#define RISCV_ISA_EXT_ZACAS		73
+#define RISCV_ISA_EXT_ZVE32X		74
+#define RISCV_ISA_EXT_ZVE32F		75
+#define RISCV_ISA_EXT_ZVE64X		76
+#define RISCV_ISA_EXT_ZVE64F		77
+#define RISCV_ISA_EXT_ZVE64D		78
+#define RISCV_ISA_EXT_ZIMOP		79
+#define RISCV_ISA_EXT_ZCA		80
+#define RISCV_ISA_EXT_ZCB		81
+#define RISCV_ISA_EXT_ZCD		82
+#define RISCV_ISA_EXT_ZCF		83
+#define RISCV_ISA_EXT_ZCMOP		84
+#define RISCV_ISA_EXT_ZAWRS		85
+#define RISCV_ISA_EXT_SVVPTC		86
+#define RISCV_ISA_EXT_SMMPM		87
+#define RISCV_ISA_EXT_SMNPM		88
+#define RISCV_ISA_EXT_SSNPM		89
+
+#define RISCV_ISA_EXT_XLINUXENVCFG	127
+
+#define RISCV_ISA_EXT_MAX		128
+#define RISCV_ISA_EXT_INVALID		U32_MAX
+
+#ifdef CONFIG_RISCV_M_MODE
+#define RISCV_ISA_EXT_SxAIA		RISCV_ISA_EXT_SMAIA
+#define RISCV_ISA_EXT_SUPM		RISCV_ISA_EXT_SMNPM
+#else
+#define RISCV_ISA_EXT_SxAIA		RISCV_ISA_EXT_SSAIA
+#define RISCV_ISA_EXT_SUPM		RISCV_ISA_EXT_SSNPM
+#endif
+
+#endif /* _ASM_RISCV_HWCAP_H */
-- 
2.34.1

