Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2C87C88E4C
	for <u-boot@archiver.kernel.org>; Fri, 11 Sep 2026 10:48:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 93B6A8124B;
	Fri, 11 Sep 2026 10:48:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eKWiHRG7qWpn; Fri, 11 Sep 2026 10:48:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 5686C80E28
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789123696;
	b=bbkOj4icsYmkXkEOiqM62eZWZzCooSnTqX9dqQ44iMflTONcGuO7vc6xvOjWa/YlNXlg
	 TVGDJ8MqQFmNkrFZdvXayqgn1vhIqK1gQ3TBDVQ8C29/KDhgJYfchbXDYSRPwcwPSJWk+
	 nvD7XTocWsdlQWqky05yT3jMKl5Xtu8Pt2x+p9L5yobe7YVpt4fw/M2jUV54XNys19pgo
	 z+ySmoGmveTj4FIrb2zqs22bNDZ4agq7NBcvLq7tYKUE6za2RRSokVJHCz7LSWG1WEM8r
	 lOCSFD80zrcIAjJrPzhn4N6dc7K1KhOIL2qHVxDAahBQRyZrgp1zM3WVlTLXU7mAGVA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789123696;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-ZohoMailClient:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=6EnbdXiUv7ELBAwfx33G0p9jdmatzXJpcQrkNCjrYsU=;
	b=qFhL8nvkbTAaQ/Jm0VELqkYVKGmAGGZ+giq2VOwrQ+hbjDlNA+qIqEz93SY1ZNfkltAU
	 me+d2ur9VD3I9TS5HZ0r26GSxyuS5pU12wGiFQSKcm290Ci10YYJCgbwjgo0bNdbGm8GI
	 GUBp9ayqk44vmtaLkkQKbYN3ogTjvt5nts1sg62d0OsiqR4NlZJxqCUV2PzL9Bk9BbLvn
	 yJ9YDyRtKahfBpNEvUbS7HCARoB0GbLekTOoEzQMKc3a6k4r2UQtI5ceb7jZkAkqoc78U
	 jsyf8rvhRgRKyJ5Z6CXMJeJmnOx0NzzIzvGRNfhqpsI8jsik6IrSqICvV1bmF76WRng==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; dmarc=pass header.from=ziyao.cc;
	dkim=pass header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256 header.s=zmail header.b=N9CK2fX3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789123696;
	bh=6EnbdXiUv7ELBAwfx33G0p9jdmatzXJpcQrkNCjrYsU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=c8t1uxDYARuuAZjDNJOdHOtmR3d1OUBwGwv2RVUhb+l2cHXnmFT7dtD9roHWCvuHu
	 bgMTBkZaY6dCXkchvbcf80zJXmR5sUK/5U8k8bwUaVHV+22503A2Op7aP4nMoOO0Vu
	 Q58bYgEh9mft5pFcnHGMojp0WwaslotQBIGM4YVdn/deRDk7a/HcQD4dtw5RyO8JMz
	 2rTbAXNIS7GPEGkqtFh8onwuzGjmcE59B2I5I97U0Rl6BK/d9tBVl70453ArtzdSo/
	 wX0Jhdk71xRtBNiX+WfjsdLTwTyAmd79uP08hg3iuqLXdPtmLNS4WHcdEfRNKknj44
	 Ar8IO7ES4mUug==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5686C80E28;
	Fri, 11 Sep 2026 10:48:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 7815632F
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 10:48:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E8D1580CA8
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 10:48:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kKjPAN3Vj0Ei for <u-boot@lists.u-boot-project.org>;
 Fri, 11 Sep 2026 10:48:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org B917080CA3
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=136.143.188.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789123686;
 b=iCl+OVgrWj7tMxjTbPRrTFHMwwn6vWXIhBL/tc3ioZa1+AhJejN8YodgpJnBNpq23Aja
 GMbhP2YOxUVFkdSllHp/DIL9QmWpMy7FGNRrppUqMHKVrXr9l/b11oIl3tZVFJWgrAdll
 y6DwTOyO1A7iQYBKirMKcWA9R65GnAaDohn4rkgt7g5TozuFCrnO2zRAHCOjIn4sro4Ie
 llP7edIHiT1NrTTR1vF0auneVblz/1qD09yoK84vaBgVMvvJk4dlbkfZaLHgGDqVGw+Yt
 51hIISyOWkTMbTyWUoL+FHmwIYRChlb2sUPE/4W/fqbmFG390qjDB5gRWKpfoO/VFpw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789123686;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-ZohoMailClient;
 bh=6EnbdXiUv7ELBAwfx33G0p9jdmatzXJpcQrkNCjrYsU=;
 b=ND2dtKB62xVJUw8tS9L8/vkpu4FunIZdShQ5vpxg5FRmIhfk0vBNDS/Fpf/VOUzvO0jm
 deB4yHEYNyi00B11Ozhlt431jeLV3dWZbuquOrgmy+JRq5IwPfgRchpf+RJx9xqQTwp8P
 MFrhx8/vEktB15IOd2PiJEoeRisfkbn0C9KVkZKs0U1U0uAyv3BYb9K+t8H1JaWIDcC33
 zL+nZ9vjcyNi94EqPaEDH3L7BKocC5T9iP9YU4yNeA8lFcEEVG0X1ifSN6iOgGj5f1G6s
 FYYuvzVmInEU8OCMUhwbZ68kR+ZKg86mrxUlyKO9msEESvl2RjJ/x+eFiVBjIikGTbw==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=ziyao.cc; 
 dkim=pass header.d=ziyao.cc header.i=me@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=N9CK2fX3; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.188.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=136.143.188.15;
 helo=sender4-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=ziyao.cc header.i=me@ziyao.cc
 header.a=rsa-sha256 header.s=zmail header.b=N9CK2fX3
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com
 [136.143.188.15])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B917080CA3
 for <u-boot@lists.u-boot-project.org>; Fri, 11 Sep 2026 10:48:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1789123680; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=HcPfZEchi7se5s99dr+/mjyHFrwWQKuC4V+i3PN9HFTW+2G2GaZ3t7sqHzyTf2wFmNxI5yrn9qL/XWyYj4Cabu+c+5pKnfFd3SvtvnFts84knIUir99oroxX+AvUkpY6D3nhLUJe3ra6+5GB4tMG9UFB5cOB8cqZFkX+JwI9R8Q=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1789123680;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=6EnbdXiUv7ELBAwfx33G0p9jdmatzXJpcQrkNCjrYsU=; 
 b=bOLgFEaVqok2gDJXyT8VnmEoDpuzlMKLSRgkgcR0I6b54kKWNhZrBdJvY7kzr4t0FdJ/o81VIyZWfjjNutKIqWSFoj1f5iz/U1qRJDvZJ7T6lqzrqPzG+S3GlJhG9kIX/75S53dzp+TDuagzQVfg0F8ZEzMiLA+R2xW35p3gFSQ=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1789123680; 
 s=zmail; d=ziyao.cc; i=me@ziyao.cc;
 h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=6EnbdXiUv7ELBAwfx33G0p9jdmatzXJpcQrkNCjrYsU=;
 b=N9CK2fX3RC5hUdMX+Sb6gw5whVWiTo87UX1k5LkptscSfA7O3/Ja+NFuB3swXnq0
 lfdITtz979UYPRdBULXxiKpu3KYK8VGQr0Pr4VeI9sgT21+wqY0CauDCMrmlL/Vy8ER
 t6xAqscOil/0w1CSBUqxhTCoiyTrak+N0u1eevto=
Received: by mx.zohomail.com with SMTPS id 1789123679635448.2353198223866;
 Fri, 11 Sep 2026 03:47:59 -0700 (PDT)
From: Yao Zi <me@ziyao.cc>
To: Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org,
	Yao Zi <me@ziyao.cc>
Subject: [PATCH v4 10/19] LoongArch: Boot Image bits
Date: Fri, 11 Sep 2026 10:45:55 +0000
Message-ID: <20260911104604.2910944-11-me@ziyao.cc>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911104604.2910944-1-me@ziyao.cc>
References: <20260911104604.2910944-1-me@ziyao.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Jiaxun Yang <jiaxun.yang@flygoat.com>

Implement loading and booting functions for LoongArch
standard kernel image as per spec.

LoongArch kernel do expect us to fake a efi systemtable
for passing fdt to kernel, we don't need to implement any
EFI functions for kernel because it won't look into anything
beside devicetree from that table if we tell kernel we are
not efi compatible by setting a0 boot argument to zero.

Link: https://docs.kernel.org/arch/loongarch/booting.html
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Yao Zi <me@ziyao.cc>
---

Changed from v3
- Do not include bootm.o twice for compilation in
  arch/loongarch/lib/Makefile
- Declare LoongArch-specific, LIB_BOOTM's dependency on CRC32 in
  boot/Kconfig instead of arch/loongarch/Kconfig
- Store the fake EFI system table in gd->bd->bi_boot_params instead of
  images->kbd->bi_boot_params, since the latter isn't automatically
  initialized

Changed from v2
- Use LIB_BOOT[MI] instead of CMD_BOOT[MI] in
  arch/loongarch/lib/Makefile
- Drop now redundant definition of board_quiesce_devices() stub
- Replace announce_and_cleanup() with generic bootm_final() in bootm.c
- Remove usage of USB_DEVICE
- Clean up header includes in lib/bootm.c
- Use u-boot/crc.h for CRC32 in lib/bootm.c, select CRC32 for LIB_BOOTM
  on LoongArch
- Don't align the generated systab to 64K
- Correctly pass cmdline_start to Linux kernel
- Hang if either OF_LIBFDT is disabled or images->ft_len is zero in
  boot_jump_linux()
- Tidy up comments for linux_image_h
- Explain the kernel bug fixed by clearing the highest 4bits of kernel
  entry address.
- Clear only the highest 4bits of kernel entry address, instead of
  the highest 16bits with TO_PHYS(), to ensure compatibility with
  future kernels supporting wider address ranges.

Changed from v1
- Remove now unused arch_lmb_reserve()

 arch/loongarch/lib/Makefile |   2 +
 arch/loongarch/lib/bootm.c  | 129 ++++++++++++++++++++++++++++++++++++
 arch/loongarch/lib/image.c  |  77 +++++++++++++++++++++
 boot/Kconfig                |   1 +
 cmd/Kconfig                 |   2 +-
 5 files changed, 210 insertions(+), 1 deletion(-)
 create mode 100644 arch/loongarch/lib/bootm.c
 create mode 100644 arch/loongarch/lib/image.c

diff --git a/arch/loongarch/lib/Makefile b/arch/loongarch/lib/Makefile
index 3c17b9cd85af..9eb9662066a5 100644
--- a/arch/loongarch/lib/Makefile
+++ b/arch/loongarch/lib/Makefile
@@ -3,6 +3,8 @@
 # Copyright (C) 2024 Jiaxun yang <jiaxun.yang@flygoat.com>
 #
 
+obj-$(CONFIG_$(PHASE_)LIB_BOOTM) += bootm.o
+obj-$(CONFIG_$(PHASE_)LIB_BOOTI) += image.o
 obj-$(CONFIG_CMD_GO) += boot.o
 obj-y	+= cache.o
 obj-y	+= interrupts.o
diff --git a/arch/loongarch/lib/bootm.c b/arch/loongarch/lib/bootm.c
new file mode 100644
index 000000000000..1d58556cd78b
--- /dev/null
+++ b/arch/loongarch/lib/bootm.c
@@ -0,0 +1,129 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2024 Jiaxun Yang <jiaxun.yang@flygoat.com>
+ */
+
+#include <asm/global_data.h>
+#include <bootstage.h>
+#include <bootm.h>
+#include <command.h>
+#include <dm.h>
+#include <dm/device.h>
+#include <dm/root.h>
+#include <efi.h>
+#include <efi_api.h>
+#include <fdt_support.h>
+#include <hang.h>
+#include <image.h>
+#include <linux/sizes.h>
+#include <log.h>
+#include <memalign.h>
+#include <u-boot/crc.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+static const efi_guid_t efi_guid_fdt = EFI_FDT_GUID;
+
+/* LoongArch do expect a EFI style systab */
+static int generate_systab(struct bootm_headers *images)
+{
+	const int nr_cfgtab = 1;
+	struct efi_system_table *systab;
+	struct efi_configuration_table *cfgtab;
+	size_t table_size = sizeof(struct efi_system_table) +
+			    nr_cfgtab * sizeof(struct efi_configuration_table);
+
+	systab = malloc(table_size);
+	if (!systab) {
+		log_warning("Failed to allocate memory for systab\n");
+		return -ENOMEM;
+	}
+	memset(systab, 0, table_size);
+
+	cfgtab = (void *)systab + sizeof(struct efi_system_table);
+
+	systab->hdr.signature = EFI_SYSTEM_TABLE_SIGNATURE;
+	systab->hdr.headersize = sizeof(struct efi_system_table);
+	systab->nr_tables = nr_cfgtab;
+	systab->tables = cfgtab;
+	systab->hdr.crc32 = crc32(0, (const unsigned char *)systab,
+				  systab->hdr.headersize);
+
+	cfgtab[0].guid = efi_guid_fdt;
+	cfgtab[0].table = images->ft_addr;
+
+	gd->bd->bi_boot_params = (ulong)systab;
+
+	return 0;
+}
+
+static void boot_prep_linux(struct bootm_headers *images)
+{
+	if (CONFIG_IS_ENABLED(OF_LIBFDT) && IS_ENABLED(CONFIG_LMB) && images->ft_len) {
+		debug("using: FDT\n");
+		if (image_setup_linux(images)) {
+			printf("FDT creation failed! hanging...");
+			hang();
+		}
+		if (generate_systab(images)) {
+			printf("Failed to generate EFI systab\n");
+			hang();
+		}
+	} else {
+		printf("Device tree not found or missing FDT support\n");
+		hang();
+	}
+}
+
+static void boot_jump_linux(struct bootm_headers *images, int flag)
+{
+	void (*kernel)(ulong efi_boot, char *cmdline, void *systab);
+	int fake = (flag & BOOTM_STATE_OS_FAKE_GO);
+
+	kernel = (void (*)(ulong efi_boot, char *cmdline, void *systab))images->ep;
+
+	bootstage_mark(BOOTSTAGE_ID_RUN_OS);
+
+	debug("## Transferring control to kernel (at address %08lx) ...\n",
+	      (ulong)kernel);
+
+	bootm_final(fake);
+	cleanup_before_linux();
+
+	if (!fake) {
+		if (CONFIG_IS_ENABLED(OF_LIBFDT) && images->ft_len) {
+			kernel(0, (char *)images->cmdline_start,
+			       (void *)gd->bd->bi_boot_params);
+		} else {
+			printf("Device tree not found or missing FDT support\n");
+			hang();
+		}
+	}
+}
+
+int do_bootm_linux(int flag, struct bootm_info *bmi)
+{
+	struct bootm_headers *images = bmi->images;
+
+	if (flag & BOOTM_STATE_OS_BD_T || flag & BOOTM_STATE_OS_CMDLINE)
+		return -1;
+
+	if (flag & BOOTM_STATE_OS_PREP) {
+		boot_prep_linux(images);
+		return 0;
+	}
+
+	if (flag & (BOOTM_STATE_OS_GO | BOOTM_STATE_OS_FAKE_GO)) {
+		boot_jump_linux(images, flag);
+		return 0;
+	}
+
+	boot_prep_linux(images);
+	boot_jump_linux(images, flag);
+	return 0;
+}
+
+int do_bootm_vxworks(int flag, struct bootm_info *bmi)
+{
+	return do_bootm_linux(flag, bmi);
+}
diff --git a/arch/loongarch/lib/image.c b/arch/loongarch/lib/image.c
new file mode 100644
index 000000000000..ea54345b50ee
--- /dev/null
+++ b/arch/loongarch/lib/image.c
@@ -0,0 +1,77 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2024 Jiaxun Yang <jiaxun.yang@flygoat.com>
+ *
+ * Based on riscv/lib/image.c
+ */
+
+#include <asm/global_data.h>
+#include <errno.h>
+#include <image.h>
+#include <linux/bitfield.h>
+#include <linux/sizes.h>
+#include <linux/stddef.h>
+#include <mapmem.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+#define LINUX_LOONGARCH_IMAGE_MAGIC	0x818223cd
+
+struct linux_image_h {
+	uint32_t	code0;			/* Executable code */
+	uint32_t	code1;			/* Executable code */
+	uint64_t	kernel_entry;		/* Kernel entry point */
+	uint64_t	image_size;		/* Effective Image size */
+	uint64_t	load_offset;		/* load offset */
+	uint64_t	res1;			/* reserved */
+	uint64_t	res2;			/* reserved */
+	uint64_t	res3;			/* reserved */
+	uint32_t	magic;			/* Magic number */
+	uint32_t	pe_header;		/* Offset to the PE header */
+};
+
+int booti_setup(ulong image, ulong *relocated_addr, ulong *size, ulong *ep,
+		bool force_reloc)
+{
+	struct linux_image_h *lhdr;
+	phys_addr_t ep_phys;
+
+	lhdr = (struct linux_image_h *)map_sysmem(image, 0);
+
+	if (lhdr->magic != LINUX_LOONGARCH_IMAGE_MAGIC) {
+		puts("Bad Linux LoongArch Image magic!\n");
+		return -EINVAL;
+	}
+
+	if (lhdr->image_size == 0) {
+		puts("Image lacks image_size field, error!\n");
+		return -EINVAL;
+	}
+
+	*size = lhdr->image_size;
+	if (force_reloc ||
+	    (gd->ram_base <= image && image < gd->ram_base + gd->ram_size)) {
+		*relocated_addr = gd->ram_base + lhdr->load_offset;
+	} else {
+		*relocated_addr = image;
+	}
+
+	/*
+	 * Before Linux commit beb2800074c1 ("LoongArch: Fix entry point in
+	 * kernel image header"), kernel_entry is filled with a DMW-mapped
+	 * virtual address instead of a physical address, we must convert it
+	 * back to physical address.
+	 *
+	 * On loongarch64, the lowest 60 bits of DMW-mapped address are
+	 * identical to the physical address, and the highest 4 bits are for
+	 * determining access privileges and types. So clearing the highest 4
+	 * bits works around the issue, and is a no-op since the length of
+	 * physical addresses never exceed 60 bits.
+	 */
+	ep_phys = lhdr->kernel_entry & GENMASK(59, 0);
+	*ep = *relocated_addr + (ep_phys - lhdr->load_offset);
+
+	unmap_sysmem(lhdr);
+
+	return 0;
+}
diff --git a/boot/Kconfig b/boot/Kconfig
index c67dc0ba4932..fbc4d63ceeee 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -38,6 +38,7 @@ config LIB_BOOTI
 
 config LIB_BOOTM
 	bool
+	select CRC32 if LOONGARCH
 
 config LIB_BOOTZ
 	bool
diff --git a/cmd/Kconfig b/cmd/Kconfig
index 4aa02dc809ad..f5c6be55377f 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -394,7 +394,7 @@ config CMD_BOOTZ
 
 config CMD_BOOTI
 	bool "booti"
-	depends on ARM64 || RISCV || SANDBOX
+	depends on ARM64 || LOONGARCH || RISCV || SANDBOX
 	depends on LMB
 	default y
 	select LIB_BOOTI
-- 
2.55.0

