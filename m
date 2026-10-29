Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67DE606A31A
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 05:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=YpwflbDV;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256 header.s=zmail header.b=WNhwutEV
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 80BF5405A1;
	Thu, 29 Oct 2026 05:10:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aYjWy3CHZcic; Thu, 29 Oct 2026 05:10:07 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 45578403C4
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793250607;
	b=X9JWqi7H+DBWR5v0bTIXd1eRYgM1+NVaNAFHumkZjEr54Tg1gsn6+A0stLrmk5mzx047
	 s/xJT1wv94fpyfew3FyfW2+fs03bSA1pZp4FwVCCqWvktKUkSy/BubKUVA+s6k7EpkBX8
	 5OejB32OhbFUvi6ABUgGUl++sIKHwD3gLjwepCqUBBmB16wVqhTXdUH9tMfdFVNb4Orj/
	 BGjJQPTfu4rS0QfAUWy0fHCR8O3zfpnWaePWpL2de94ICurzRLeDEI9TJ+zbu1eEEhXcx
	 t6V0unNRK4ybZvdVrDMTx7HQtzCwAbuQrtV241Tsz2pWy9J5kQbh5HerAqvr9MabPfg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793250607;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-ZohoMailClient:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=5jL0XsOHOIsKWUbKMuWyKtUhfJwuL60UAvIi06FueT4=;
	b=U0cEedP9P+mTO0fgHtT9UWva8VAx0d70Fz/Ge2G11aiwAn0E9N8w3UdrqfscveI54AWF
	 bMv8w9kiprSU/WLJ1X2VjT4UYat0KUAE+LKegTPxDl9Y5Gg5cyanPeOYTkl6LhTB7f5Yl
	 jKMZknQ2jcXKXTiyGqK4IrIYJcs2Qvf6Wj6FCV3DtSicwjX4LA9X1jZQrOoCDhZd7DtEz
	 yFCbvpSqkgILjox5CmFfzAvXUIy6o3lWn1BBHuQt7XsWyyo0apcOsRJhdwdk7r/I0VNs8
	 ERx+HTjmZlf8ACteTGTyVioXzReKIwgOTP93uii+JXMGgIgW4spcWJuXWrMcqDsfzRw==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; 
	dmarc=pass header.from=ziyao.cc;
	dkim=pass header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256 header.s=zmail header.b=WNhwutEV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793250607;
	bh=5jL0XsOHOIsKWUbKMuWyKtUhfJwuL60UAvIi06FueT4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YpwflbDVCGE29n8COsuxegKfgw4ZwXWmRG3YZ7Z5P9MB9NZXQoqb3+vXf++YFY5ij
	 WPa5SVeXMRNnfO+/FmzlVDlvjaJlofxvpgp3cZPFH7lrW7dkxLvAMxT5TXS/25EZHU
	 Xs26BylGrXYtQp3SYm+OQNXKZETpoEwIHeuAqVWzHoIIiiJMbbpShyn5PdRRedwj/9
	 ZVMd1QlLJG6rvzC/5mnhX0HNu6dXoa+weK1K5zq1/o8lq2uh1glNTYS6WzO0F3HEG7
	 3tgHatkrLjWkq2SWQ1VXmR8zbJqY9aSn1ekbcuY/C9FdLtoqcHFSZFSQxy7L8HXH2r
	 TtME9b3kXR9gQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 45578403C4;
	Thu, 29 Oct 2026 05:10:07 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 711241DE
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 05:10:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 62CEE403C4
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 05:10:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aZF31wdDjOq8 for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 05:10:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 3F073403AA
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.180.15
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793250605;
 b=tM6M4Advfj9gESJFjV6FxgwNFwBWjjpn6hkgn/N7bo6hY/QBAtDbAynsF5AORBSgkLa5
 DzJK+VKjmWW/nGFT1DA6Bwfv8/a7D8S7RwJP2mzsdd+Bs1v+HsCqw9Vus/8+o015h2Q34
 meyVWEQiVIg1vSSXPX+itQ35PKe3RzaPhtWJr7PgBMYu28CAomCoOtpG5+syhGoIxsnes
 iFgx73bRl2/XWMXK74+RbaeSlkOHObUZav/hxfOudJpPdPfrGSBG+Fxrhs+ds/VaYMB7X
 kr0ZYS1XMqVSIXS2nbxqzszSs/xSzxOYyhbIm06sYfDy5SrZLaICLQdCyecYOQyrmpw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793250605;
 h=Received-SPF:DKIM-Signature:Received:From:To:Cc:Subject:Date:
 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding:X-ZohoMailClient;
 bh=5jL0XsOHOIsKWUbKMuWyKtUhfJwuL60UAvIi06FueT4=;
 b=HNiaSH50BQ9x8lusKzCKgPoEgq2Iu1oW5hxebWAGA0R2+DbZU4LEcrt80ZkqFDg9Zkr6
 EDMSglCTX2Dy23b4dU+N1+6q+mW2nxwiPWjeAx5k/1UVmN677Er6yL1VzHW4ysQtss5n1
 IB2kQgZPR0kp2Nn60ldji/xKrrgBA1cYfgb0IcFacQ8ahXaCGBNC1K4TjH+1rr8RcaAXc
 9701x73u9Jqu22W5xqu2yhxBsOOdi+A0UDeRgjR08tMMq9E807MXhpgN/sJnPiMHbWZZ6
 Uh5RlnXSGcOjQ1UxOPtw4vwRVn6w9oDPEBMnf2w8KjrmXOAuM1Vmyf4hDE/NtEFt+sw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=ziyao.cc;
 dkim=pass header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=WNhwutEV; 
 arc=pass header.oldest-pass=0 smtp.remote-ip=165.173.180.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.180.15;
 helo=sender6-op-o15.zoho.com; envelope-from=me@ziyao.cc; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ziyao.cc
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=ziyao.cc header.i=@ziyao.cc header.a=rsa-sha256
 header.s=zmail header.b=WNhwutEV
Received: from sender6-op-o15.zoho.com (sender6-op-o15.zoho.com
 [165.173.180.15])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3F073403AA
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 05:10:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1793250599; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=fv8B9aJQjYHN5bcr9Z3FSPadbGQepEpzBBNc+F2H1tUOcMBZL3lctKCvI3RPe6ZcFRmNZkMI1DDePO9rpl6jK2u/P5/0M31By6XG8UCFpUPHKI/rJlMtmGGACQWMlqz42UiLBR/X/U3EUrZHNFmY3u+9hsYtI+t31nxb/Q34B7Y=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1793250599;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=5jL0XsOHOIsKWUbKMuWyKtUhfJwuL60UAvIi06FueT4=; 
 b=iJZmb11u0Q+DqIpNbY6sgNjKXQkYmntkreQ0/7vHwdYyMc+aQwX8K/8Klw53eq2PREnZw4n1Y1u+HH/rRF6y8YV0hE9sVfHTwMmHooe2S3TgCEsqZ8fX7D6Uxm9J8I8HqMzqtDGzbcSZ5JFso4e+1tr8cyaws+oAWSM2iO7L3r8=
ARC-Authentication-Results: i=1; mx.zohomail.com; dkim=pass  header.i=ziyao.cc;
 spf=pass  smtp.mailfrom=me@ziyao.cc;
 dmarc=pass header.from=<me@ziyao.cc>
DKIM-Signature: a=rsa-sha256;
 b=WNhwutEVpPJZ/mqFW/wnjySglAp+e2n/BOdAeBPEUip0whXqPtVb8s+01yRtAMmdMCCjkMVCqYkc2GPTMkbsq2l1oPovSubF9kHndiU/MZcrUSUzTEQxHavlJzlfOZG51oXoRcLkhspBFORkSA9UF1WTRrWdp/9VOM8RZLujpr8=;
 c=relaxed/relaxed; s=zmail; d=ziyao.cc; v=1;
 bh=5jL0XsOHOIsKWUbKMuWyKtUhfJwuL60UAvIi06FueT4=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 179325059721898.26282268021089;
 Wed, 28 Oct 2026 22:09:57 -0700 (PDT)
From: Yao Zi <me@ziyao.cc>
To: Tom Rini <trini@konsulko.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 u-boot@lists.u-boot-project.org
Cc: Yao Zi <me@ziyao.cc>
Subject: [PATCH v6 10/20] LoongArch: Boot Image bits
Date: Thu, 29 Oct 2026 05:07:27 +0000
Message-ID: <20261029050738.1107663-11-me@ziyao.cc>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261029050738.1107663-1-me@ziyao.cc>
References: <20261029050738.1107663-1-me@ziyao.cc>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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

No changes since v4

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
---
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
index 8fcdc36c9318..7dcda1d17ea5 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -38,6 +38,7 @@ config LIB_BOOTI
 
 config LIB_BOOTM
 	bool
+	select CRC32 if LOONGARCH
 
 config LIB_BOOTZ
 	bool
diff --git a/cmd/Kconfig b/cmd/Kconfig
index e36406b64577..54d45fa42bc6 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -405,7 +405,7 @@ config CMD_BOOTZ
 
 config CMD_BOOTI
 	bool "booti"
-	depends on ARM64 || RISCV || SANDBOX
+	depends on ARM64 || LOONGARCH || RISCV || SANDBOX
 	depends on LMB
 	default y
 	select LIB_BOOTI
-- 
2.56.0

