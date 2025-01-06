Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51AF2E77198
	for <u-boot@archiver.kernel.org>; Mon,  6 Jan 2025 13:04:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22AA8805F7;
	Mon,  6 Jan 2025 14:04:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="ipzxkxRn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0AB06805D7; Mon,  6 Jan 2025 14:04:40 +0100 (CET)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B2DFA801E8
 for <u-boot@lists.denx.de>; Mon,  6 Jan 2025 14:04:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=ventanamicro.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mchitale@ventanamicro.com
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2eeb4d643a5so21029785a91.3
 for <u-boot@lists.denx.de>; Mon, 06 Jan 2025 05:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1736168676; x=1736773476; darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fAZN5zzZdOwcMUIWMfMrbBjSIKMhof7AJYxWBn3jn3A=;
 b=ipzxkxRnhUGYLIbbBdkLxzZx0tCepHpCAQCGCdC0K3iFXrWe7/c4J4xgq3O5NjcPA/
 gkuKpJDy4QPJfEioQtq3pHnT8ARsRIPltxAhZVe14xiJ8sJF5R3UNS6ortQSXkru93mg
 X2dOQ0O8MW1k0qGHZYlfikkAszpmOs2mWp3qUucG8/w7xZ+yzyVf2FWeb8j/7D1ZcIfL
 v80kGqmDap8c48h23cktL2v01RgGfhV4ElEqRv+8PSewaRtsa+F9uAW0ciz4AnZZop0k
 6GinsSR2ggf1h/2madXCpPanfJ3LwRc3CzpPo/RLzKz6E+dU0VFAUL34L6vpPDAnGi3Z
 OFeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736168676; x=1736773476;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fAZN5zzZdOwcMUIWMfMrbBjSIKMhof7AJYxWBn3jn3A=;
 b=dp95nRBgEY3EEqAW2HKrOozASuelYEcbSJo9mpqNecaemW43EpN0DmQMunxZMyS/qv
 nlD1B/eXs4yMXviF1vHDP7fdm6hGmTeWNrNUUqQ1H8vgQR41zh6punfVD5ST2eVq+nAs
 5g3jBFut8nbZKnnxeL7mifSTRc/gSjukALXvsSzYHFBDaDGW7Z6nmL51Q3hbXyfV+AR3
 Aw2MP7oM8iIEgZbl+Ub5+S8FoIAveNa2FHDZ5HneYYc82UTAjG8V9BdeTgBGNKegP4nU
 n6L/4S+PQqyuxS2joJwA/hPgP2ZZ6iCdJszMesYMoCiN9nL4TfoyNgUp5tlKYoxktg8j
 8YVw==
X-Gm-Message-State: AOJu0YyWdfyagwz/AH4FzkLmbI2Vjjv9/fuAyNxpCHwS8t+4akyQEd4+
 6+/VwodS3xJ+Sy9n4mGDhlCksyBS+b6wJMgG4YXGWideTYTQtB8VNG6xVCZUIEty8O0V65K+bKG
 6wD0=
X-Gm-Gg: ASbGnct7ugzm88TIRrTPIZpdjSySYrFkLpjJB9uum00c4KW/d7M68bmJHvhla00GiAy
 M3nRmpH4e3GHkpQ6eqAY5tpt9eMjHuwc67P+yCKxjcDfAHsUI3j5Ov8HL/EzFUvpzbtpxrPaAXz
 3JKpzrjQ9DrYG/6K2gItrPW/ciYltup3ez44TjpaSIMDHrvfB+q3qmHG9K5gYuhnxcue2ACDqCs
 6OyRPRVHAtu+M9JUh98cgEbAKTsXq4WcOalV4jAEKSNDZv/NsW/nGI=
X-Google-Smtp-Source: AGHT+IFv6wsYrrA/TL+kKW3n1nCL6uONFXcRylUedIlzsiLXGKshLBZSRhJ5pDIEBg8ZnaiggQP98A==
X-Received: by 2002:a17:90a:dfcd:b0:2ee:7233:4e8c with SMTP id
 98e67ed59e1d1-2f452dfa47amr93431331a91.8.1736168675897; 
 Mon, 06 Jan 2025 05:04:35 -0800 (PST)
Received: from vm.. ([103.97.166.196]) by smtp.googlemail.com with ESMTPSA id
 98e67ed59e1d1-2f4477c8537sm33632428a91.21.2025.01.06.05.04.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2025 05:04:31 -0800 (PST)
From: Mayuresh Chitale <mchitale@ventanamicro.com>
To: u-boot@lists.denx.de
Cc: Mayuresh Chitale <mchitale@ventanamicro.com>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>, Conor Dooley <conor.dooley@microchip.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH v1 2/2] riscv: Fallback to riscv,isa
Date: Mon,  6 Jan 2025 13:04:05 +0000
Message-Id: <20250106130405.220369-3-mchitale@ventanamicro.com>
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

Update the cpu probing to fallback to "riscv,isa" property if
"riscv,isa-extensions" is not available and modify the riscv CMO code
to use the block size that was probed during cpu setup.

Signed-off-by: Mayuresh Chitale <mchitale@ventanamicro.com>
---
 arch/riscv/cpu/cpu.c   | 71 +++++++++++++-----------------------------
 arch/riscv/lib/cache.c | 26 +++-------------
 2 files changed, 25 insertions(+), 72 deletions(-)

diff --git a/arch/riscv/cpu/cpu.c b/arch/riscv/cpu/cpu.c
index f3f9f9f2351..06ecd92b9bc 100644
--- a/arch/riscv/cpu/cpu.c
+++ b/arch/riscv/cpu/cpu.c
@@ -595,55 +595,7 @@ static inline bool supports_extension(char ext)
 #if CONFIG_IS_ENABLED(RISCV_MMODE)
 	return csr_read(CSR_MISA) & (1 << (ext - 'a'));
 #elif CONFIG_CPU
-	char sext[2] = {ext};
-	struct udevice *dev;
-	const char *isa;
-	int ret, i;
-
-	uclass_find_first_device(UCLASS_CPU, &dev);
-	if (!dev) {
-		debug("unable to find the RISC-V cpu device\n");
-		return false;
-	}
-
-	ret = dev_read_stringlist_search(dev, "riscv,isa-extensions", sext);
-	if (ret >= 0)
-		return true;
-
-	/*
-	 * Only if the property is not found (ENODATA) is the fallback to
-	 * riscv,isa used, otherwise the extension is not present in this
-	 * CPU.
-	 */
-	if (ret != -ENODATA)
-		return false;
-
-	isa = dev_read_string(dev, "riscv,isa");
-	if (!isa)
-		return false;
-
-	/*
-	 * Skip the first 4 characters (rv32|rv64).
-	 */
-	for (i = 4; i < sizeof(isa); i++) {
-		switch (isa[i]) {
-		case 's':
-		case 'x':
-		case 'z':
-		case '_':
-		case '\0':
-			/*
-			 * Any of these characters mean the single
-			 * letter extensions have all been consumed.
-			 */
-			return false;
-		default:
-			if (isa[i] == ext)
-				return true;
-		}
-	}
-
-	return false;
+	return __riscv_isa_extension_available(ext);
 #else  /* !CONFIG_CPU */
 #warning "There is no way to determine the available extensions in S-mode."
 #warning "Please convert your board to use the RISC-V CPU driver."
@@ -679,7 +631,26 @@ static void dummy_pending_ipi_clear(ulong hart, ulong arg0, ulong arg1)
 
 int riscv_cpu_setup(void)
 {
-	int __maybe_unused ret;
+	int ret = -ENODEV, ext_count, i;
+	const char *isa, **exts;
+	struct udevice *dev;
+
+	uclass_find_first_device(UCLASS_CPU, &dev);
+	if (!dev) {
+		debug("unable to find the RISC-V cpu device\n");
+		return ret;
+	}
+
+	ext_count = dev_read_string_list(dev, "riscv,isa-extensions", &exts);
+	if (ext_count > 0) {
+		for (i = 0; i < ext_count; i++)
+			match_isa_ext(exts[i], exts[i] + strlen(exts[i]));
+	} else {
+		isa = dev_read_string(dev, "riscv,isa");
+		if (!isa)
+			return ret;
+		riscv_parse_isa_string(isa);
+	}
 
 	/* Enable FPU */
 	if (supports_extension('d') || supports_extension('f')) {
diff --git a/arch/riscv/lib/cache.c b/arch/riscv/lib/cache.c
index e184d5e2059..71e4937ab54 100644
--- a/arch/riscv/lib/cache.c
+++ b/arch/riscv/lib/cache.c
@@ -24,7 +24,7 @@ enum {
 	CBO_INVAL
 } riscv_cbo_ops;
 static int zicbom_block_size;
-
+extern unsigned int riscv_get_cbom_block_size(void);
 static inline void do_cbo_clean(unsigned long base)
 {
 	asm volatile ("add a0, %0, zero\n" CBO_CLEAN(%0) ::
@@ -79,25 +79,6 @@ void cbo_inval(unsigned long start, unsigned long end)
 		cbo_op(CBO_INVAL, start, end);
 }
 
-static int riscv_zicbom_init(void)
-{
-	struct udevice *dev;
-
-	if (!CONFIG_IS_ENABLED(RISCV_ISA_ZICBOM) || zicbom_block_size)
-		return 1;
-
-	uclass_first_device(UCLASS_CPU, &dev);
-	if (!dev) {
-		log_debug("Failed to get cpu device!\n");
-		return 0;
-	}
-
-	if (dev_read_u32(dev, "riscv,cbom-block-size", &zicbom_block_size))
-		log_debug("riscv,cbom-block-size DT property not present\n");
-
-	return zicbom_block_size;
-}
-
 void invalidate_icache_all(void)
 {
 	asm volatile ("fence.i" ::: "memory");
@@ -166,6 +147,7 @@ __weak int dcache_status(void)
 
 __weak void enable_caches(void)
 {
-	if (!riscv_zicbom_init())
-		log_info("Zicbom not initialized.\n");
+	zicbom_block_size = riscv_get_cbom_block_size();
+	if (!zicbom_block_size)
+		log_debug("Zicbom not initialized.\n");
 }
-- 
2.34.1

