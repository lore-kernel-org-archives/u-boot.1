Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F20CBC5AD4C
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 02:58:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A800A8755C;
	Tue, 21 Nov 2023 03:58:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KHDe8TpM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9D2F87582; Tue, 21 Nov 2023 03:58:25 +0100 (CET)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A26B7871F0
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 03:58:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-7a6774da682so233160639f.3
 for <u-boot@lists.denx.de>; Mon, 20 Nov 2023 18:58:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700535501; x=1701140301; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=GbabAeYcBJ4pDWhbeccv8ix3SI0zM5QRS+QVs/XaCH0=;
 b=KHDe8TpMMLjnbgsqDsWBrhIFBE6RR45YESlJTscn9eOSaX7/Lhiy7aFbhK6C0ANXqo
 YaQEeUzfvwyLhLfo79uVvn1RY7Svslp5ShDWvbLFqDe6BmhAwXIWvcR7YJaCmoAzwV//
 WhHzeQrbg0vULx09PFn//ksKfZYZjV/Wz/BsI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700535501; x=1701140301;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GbabAeYcBJ4pDWhbeccv8ix3SI0zM5QRS+QVs/XaCH0=;
 b=Ife4I4e7E1eVjCiS7B+vphC5S6IPZoS5NzGl7FIdSk7JKpEJe7VRZBRUT4uUHCdOzP
 2crERW9iOgxDNMy1PNr6PwyXQ68h+MSU0cor9Gtnn72yvKYF1AKgAKgCEf1mjiXZ1ts6
 Ur7RD8NaVYpw2fSWf2t4Ou9jBMKLydBm4apn6Eh80bSAcVohBiIJPZbrY7PwjRwcAv8h
 66OG+EZE07fAyt9zsATUOCwsIb5m4BCgLeWfnIqC/kgneD+oEKpyTW2c8iKc445yNt8U
 E4ZABq38EcrB47NXuVj+1RVfXXK0RHnORKDv5LSYOK1+lvOGfCnLXtYziARG+EB0ViW8
 xqMA==
X-Gm-Message-State: AOJu0YztuXLXH4WFY2RxyhJMMcTA5EvBQVL4yOyeCvl/9nqHz2x43jFP
 3s4Zh+giHaKAMOLiEasPyfYnn4ILVcjGQCwoIMx7hg==
X-Google-Smtp-Source: AGHT+IHPShDKDwF+VFsFxkbZUEBis8JM8zzb309AIkTREslFOUvO8CaMnhakHFUj+uchhIO4t5QLgg==
X-Received: by 2002:a92:ad0b:0:b0:35b:37a:52e5 with SMTP id
 w11-20020a92ad0b000000b0035b037a52e5mr5838477ilh.31.1700535501080; 
 Mon, 20 Nov 2023 18:58:21 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 ca18-20020a0566381c1200b00437a3c128dfsm2398826jab.108.2023.11.20.18.58.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Nov 2023 18:58:20 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Mark Kettenis <kettenis@openbsd.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Brandon Maier <brandon.maier@collins.com>,
 Kautuk Consul <kconsul@ventanamicro.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Subject: [PATCH v3] smbios: arm64: Ensure table is written at a good address
Date: Mon, 20 Nov 2023 19:58:16 -0700
Message-ID: <20231121025818.741258-1-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
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

Work around this problem by automatically choosing an address below 4GB
(but as high as possible), if needed.

Tell efi_loader about the address in the same way as we do for ACPI
tables.

Signed-off-by: Simon Glass <sjg@chromium.org>
---
Please see previous discussion here:

  https://patchwork.ozlabs.org/project/uboot/patch/
  20231025123117.v2.1.I054cad60e00f8cfde39256c7c7d9c960987fb9be@changeid/

Changes in v3:
- Add RISC-V to the condition, too
- Update the commit message

Changes in v2:
- Update to search for a suitable area automatically, if enabled

 lib/Kconfig                 | 13 ++++++++
 lib/efi_loader/efi_smbios.c | 63 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 75 insertions(+), 1 deletion(-)

diff --git a/lib/Kconfig b/lib/Kconfig
index 19649517a39b..c70faeeebed5 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -998,6 +998,19 @@ config GENERATE_SMBIOS_TABLE
 	  See also SMBIOS_SYSINFO which allows SMBIOS values to be provided in
 	  the devicetree.
 
+config SMBIOS_TABLE_FIXED
+	bool "Place the SMBIOS table at a special address"
+	depends on GENERATE_SMBIOS_TABLE && SMBIOS && EFI_LOADER
+	depends on ARM64 || RISCV
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
index 48446f654d9b..566f206af5b6 100644
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
+	if (find_addr_below(SZ_4G - 1, SZ_64K, &addr) ||
+	    !write_smbios_table(addr)) {
 		log_err("Failed to write SMBIOS table\n");
 		return log_msg_ret("smbios", -EINVAL);
 	}
-- 
2.43.0.rc1.413.gea7ed67945-goog

