Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38612C25B48
	for <u-boot@archiver.kernel.org>; Tue, 24 Oct 2023 23:31:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 96BBC879F4;
	Wed, 25 Oct 2023 01:31:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cD/+naYa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E4838798A; Wed, 25 Oct 2023 01:31:38 +0200 (CEST)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com
 [IPv6:2607:f8b0:4864:20::1036])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33B9D86ED0
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 01:31:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-27d1a03f540so3864566a91.1
 for <u-boot@lists.denx.de>; Tue, 24 Oct 2023 16:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1698190292; x=1698795092; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=st07FQoNNyJoDLoqsS94ktdeHL2Lz5Mi1RaXT3qZecE=;
 b=cD/+naYaOr+FONxIHnGTTonpexUyFuTGD0YiR2PnD7ESeCpdtuphbon5dt0E7YiUiu
 gzz1p2m2d2NCkKGgbw4XGnzc8PN7yfYO2FIomIe4lTy5WSpQnTQ4YlePRall0e3sVIEt
 ITvrrVK3MHNZwKMKt0DbXQBAG/syL6L/P6HVs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698190292; x=1698795092;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=st07FQoNNyJoDLoqsS94ktdeHL2Lz5Mi1RaXT3qZecE=;
 b=sLaYozDLtDarl9X5iy0U89A6ZV93pCa7hbqnRjwEmgelhZpwEb8bS2eOpRxTwjuE8i
 l//ZxzwxlHgtMnvH1/NIwFGxPsATIpbHcLFEh3aXh95iWMezZGhp58637Ss8Wz3O9vQw
 aovC9Ys5t74dMq0XP4H/jcNp44Wxhu7vZCdCjL8e6VWT2F3KsvSmcPIW3pgLh4bu9spR
 cIkqE5Y7K9jzfR8wRx5I8FBFXND/8u/WfeL1uPin3MF/y7yruiRH8WBSuer81uNOQ9aL
 OLzORwBsmCevuUmLEvdkSm7hAfKvQgmgS2x8YfXOdHfiam9SCqK20mNXQ+mqTfHv72p8
 OWmg==
X-Gm-Message-State: AOJu0Yx5Vb9ln5lkbr1wfUmwcXW13XjMIvr/zVOn6O/G6q+rQrSDm/dv
 UYGWAtaIcD3HrZdyrwZuDD51hgt+UR0bRR2TcOd1Pw==
X-Google-Smtp-Source: AGHT+IGvGS9dz9imuIsytEA+PAkMfDLQ/PV3wevCxtvarhGRzAD9hne6ClBb7dgaRd3YHbgIZ87kcA==
X-Received: by 2002:a17:90a:9408:b0:27c:ed3f:a73c with SMTP id
 r8-20020a17090a940800b0027ced3fa73cmr10322592pjo.42.1698190292285; 
 Tue, 24 Oct 2023 16:31:32 -0700 (PDT)
Received: from sjg1.roam.corp.google.com ([202.144.206.130])
 by smtp.gmail.com with ESMTPSA id
 g9-20020a17090ace8900b00263cca08d95sm9243001pju.55.2023.10.24.16.31.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 16:31:32 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mark Kettenis <kettenis@openbsd.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Brandon Maier <brandon.maier@collins.com>,
 Kautuk Consul <kconsul@ventanamicro.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Subject: [PATCH v2] smbios: arm64: Allow table to be written at a fixed addr
Date: Wed, 25 Oct 2023 12:31:19 +1300
Message-ID: <20231025123117.v2.1.I054cad60e00f8cfde39256c7c7d9c960987fb9be@changeid>
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
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

U-Boot typically sets up its malloc() pool near the top of memory. On
ARM64 systems this can result in an SMBIOS table above 4GB which is
not supported by SMBIOSv2.

Work around this problem by providing a new option to choose an address
below 4GB (but as high as possible), if needed.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Update to search for a suitable area automatically, if enabled

 lib/Kconfig                 | 12 +++++++
 lib/efi_loader/efi_smbios.c | 63 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 74 insertions(+), 1 deletion(-)

diff --git a/lib/Kconfig b/lib/Kconfig
index f6ca559897e7..a1eec98b392f 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -994,6 +994,18 @@ config GENERATE_SMBIOS_TABLE
 	  See also SMBIOS_SYSINFO which allows SMBIOS values to be provided in
 	  the devicetree.
 
+config SMBIOS_TABLE_FIXED
+	bool "Place the SMBIOS table at a special address"
+	depends on GENERATE_SMBIOS_TABLE && ARM64 && SMBIOS && EFI_LOADER
+	default y
+	help
+	  Use this option to place the SMBIOS table at a special address.
+
+	  U-Boot typically sets up its malloc() pool near the top of memory. On
+	  ARM64 systems this can result in an SMBIOS table above 4GB which is
+	  not supported by SMBIOSv2. This option works around this problem by
+	  chosing an address just below 4GB, if needed.
+
 endmenu
 
 config LIB_RATIONAL
diff --git a/lib/efi_loader/efi_smbios.c b/lib/efi_loader/efi_smbios.c
index 48446f654d9b..bdbce4c4d785 100644
--- a/lib/efi_loader/efi_smbios.c
+++ b/lib/efi_loader/efi_smbios.c
@@ -47,6 +47,60 @@ efi_status_t efi_smbios_register(void)
 					       map_sysmem(addr, 0));
 }
 
+/**
+ * find_addr_below() - Find a usable region below the given max_addr
+ *
+ * Check if *addrp is suitable to define a memory region which finishes below
+ * @max_addr + @req_size. If so, do nothing and return 0
+ *
+ * As a backup, if CONFIG_SMBIOS_TABLE_FIXED is enabled, search for a
+ * 4KB-aligned DRAM region which is large enough. Make sure it is below U-Boot's
+ * stack space, assumed to be 64KB.
+ *
+ * @max_addr: Maximum address that can be used (region must finish before here)
+ * @req:size: Required size of region
+ * @addrp: On entry: Current proposed address; on exit, holds the new address,
+ *	on success
+ * Return 0 if OK (existing region was OK, or a new one was found), -ENOSPC if
+ * nothing suitable was found
+ */
+static int find_addr_below(ulong max_addr, ulong req_size, ulong *addrp)
+{
+	struct bd_info *bd = gd->bd;
+	ulong max_base;
+	int i;
+
+	max_base = max_addr - req_size;
+	if (*addrp <= max_base)
+		return 0;
+
+	if (!IS_ENABLED(CONFIG_SMBIOS_TABLE_FIXED))
+		return -ENOSPC;
+
+	/* Make sure that the base is at least 64KB below the stack */
+	max_base = min(max_base,
+		       ALIGN(gd->start_addr_sp - SZ_64K - req_size, SZ_4K));
+
+	for (i = CONFIG_NR_DRAM_BANKS - 1; i >= 0; i--) {
+		ulong start = bd->bi_dram[i].start;
+		ulong size = bd->bi_dram[i].size;
+		ulong addr;
+
+		/* chose an address at most req_size bytes before the end */
+		addr = min(max_base, start - req_size + size);
+
+		/* check this is in the range */
+		if (addr >= start && addr + req_size < start + size) {
+			*addrp = addr;
+			log_warning("Forcing SMBIOS table to address %lx\n",
+				    addr);
+			return 0;
+		}
+	}
+
+	return -ENOSPC;
+}
+
 static int install_smbios_table(void)
 {
 	ulong addr;
@@ -61,7 +115,14 @@ static int install_smbios_table(void)
 		return log_msg_ret("mem", -ENOMEM);
 
 	addr = map_to_sysmem(buf);
-	if (!write_smbios_table(addr)) {
+
+	/*
+	 * Deal with a fixed address if needed. For simplicity we assume that
+	 * the SMBIOS-table size is <64KB. If a suitable address cannot be
+	 * found, then write_smbios_table() returns an error.
+	 */
+	if (find_addr_below(SZ_4G, SZ_64K, &addr) ||
+	    !write_smbios_table(addr)) {
 		log_err("Failed to write SMBIOS table\n");
 		return log_msg_ret("smbios", -EINVAL);
 	}
-- 
2.42.0.758.gaed0368e0e-goog

