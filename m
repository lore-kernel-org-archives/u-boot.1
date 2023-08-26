Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B168C83F01
	for <u-boot@archiver.kernel.org>; Sat, 26 Aug 2023 22:26:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9ABB78144A;
	Sun, 27 Aug 2023 00:26:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="oLyIvMVm";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="W2FRnUPf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD979833CF; Sun, 27 Aug 2023 00:26:11 +0200 (CEST)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38E6781420
 for <u-boot@lists.denx.de>; Sun, 27 Aug 2023 00:26:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4RYBHN6nklz9sqk;
 Sun, 27 Aug 2023 00:26:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1693088768;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=St3W86F10i0TUzK5XhKpToN8yca65KWPHA0eJ8WXxM4=;
 b=oLyIvMVmnkNIaMunnlFUBCyFwRG94QvxnzpclcZPXqgDltQLSUD+F+RGpafxqb++o2MJqN
 0+Y5NRT+LrXPRBx1JMys3hl/xruY2oOCNU9vvi02Oz+I6F2HEjSN3w4N4ZEiqyD5BSzfo0
 UBhK8tAXO2ZSNaPMYXEsk17i82BX59yYbHUk0n3v0SvzAgjw+3ER78lNgaR4jLqJqN+yb0
 l1Bb8wFytLw6+lkbNA4AJbh4hv7LJLDZ4Cff8bqyuLGUKpny4T2J0CRSMgegPCCJW3yLmv
 usR810Rw7r+EYThuW6EwdNtS40eYDqtehaRgRyZnvrBA0rkwq1p1JY0wyaKxMw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1693088766;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=St3W86F10i0TUzK5XhKpToN8yca65KWPHA0eJ8WXxM4=;
 b=W2FRnUPfiBMTXiUb0JuMIBpv8+HzvRK42v5bngWBYgIgjN1xojYQtV0x0qjVJfDTwZAMGS
 AAFuTi0/A8f5G7etnevELKC96x1geDDpxUTVcpO8uWBTguQuqRntxJM02Wn/QI9pytnCIr
 Esj9sYEJiuz9I6LEw3ZQNi/XuEQOAjs5J69MqR5YoyQ5h8bET8dC/2JK0dVxXeQFO/Ocg5
 RMBgVxQvDALiyB532LC7T+O2SSJiwb4o/yNLsvAet+RDKHHLlb3phFbjzKhxoojU4oJRCC
 nxQHefPW4PKHHyTlKEsHV3bKJat1sVp0xKTJEEMbJ1r0X260vjjdvXgcJPFACA==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michal Simek <michal.simek@amd.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Angelo Durgehello <angelo.dureghello@timesys.com>,
 Bin Meng <bmeng.cn@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Huan Wang <alison.wang@nxp.com>, Ovidiu Panait <ovpanait@gmail.com>,
 Simon Glass <sjg@chromium.org>, Zong Li <zong.li@sifive.com>
Subject: [PATCH v2 1/2] tools: relocate-rela: Add M68K support
Date: Sun, 27 Aug 2023 00:25:35 +0200
Message-Id: <20230826222536.26689-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 2c285272cc9eebfd78f
X-MBO-RS-META: hoknx9e3jt7kfa49w1477wcem7eg77w8
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

Add M68K ELF32 support into this tool, so it can patch static rela
into M68K u-boot-nodtb.bin . This is the first step toward M68K
relocation support, and in turn, removal of NEEDS_MANUAL_RELOC
from the codebase altogether.

Tested-by: Michal Simek <michal.simek@amd.com> # microblaze, arm64
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Angelo Dureghello <angelo@kernel-space.org>
Cc: Angelo Durgehello <angelo.dureghello@timesys.com>
Cc: Bin Meng <bmeng.cn@gmail.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Huan Wang <alison.wang@nxp.com>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: Michal Simek <michal.simek@amd.com>
Cc: Ovidiu Panait <ovpanait@gmail.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Zong Li <zong.li@sifive.com>
---
V2: - Add handling for R_68K_JMP_SLOT
    - Add MB/ARM64 TB
---
 tools/relocate-rela.c | 116 +++++++++++++++++++++++++++++++-----------
 1 file changed, 85 insertions(+), 31 deletions(-)

diff --git a/tools/relocate-rela.c b/tools/relocate-rela.c
index e28e7fcc6f5..613abd25ef4 100644
--- a/tools/relocate-rela.c
+++ b/tools/relocate-rela.c
@@ -24,6 +24,30 @@
 #define R_AARCH64_RELATIVE	1027
 #endif
 
+#ifndef EM_M68K
+#define EM_M68K			4
+#endif
+
+#ifndef R_68K_NONE
+#define R_68K_NONE		0
+#endif
+
+#ifndef R_68K_32
+#define R_68K_32		1
+#endif
+
+#ifndef R_68K_GLOB_DAT
+#define R_68K_GLOB_DAT		20
+#endif
+
+#ifndef R_68K_JMP_SLOT
+#define R_68K_JMP_SLOT		21
+#endif
+
+#ifndef R_68K_RELATIVE
+#define R_68K_RELATIVE		22
+#endif
+
 #ifndef EM_MICROBLAZE
 #define EM_MICROBLAZE		189
 #endif
@@ -46,6 +70,7 @@
 
 static int ei_class;
 static int ei_data;
+static int machine;
 
 static uint64_t rela_start, rela_end, text_base, dyn_start;
 
@@ -111,7 +136,7 @@ static int decode_elf64(FILE *felf, char **argv)
 	uint64_t sh_addr, sh_offset, sh_size;
 	Elf64_Half sh_index, sh_num;
 	Elf64_Shdr *sh_table; /* Elf symbol table */
-	int ret, i, machine;
+	int ret, i;
 	char *sh_str;
 
 	debug("64bit version\n");
@@ -245,7 +270,7 @@ static int decode_elf32(FILE *felf, char **argv)
 	uint32_t sh_addr, sh_offset, sh_size;
 	Elf32_Half sh_index, sh_num;
 	Elf32_Shdr *sh_table; /* Elf symbol table */
-	int ret, i, machine;
+	int ret, i;
 	char *sh_str;
 
 	debug("32bit version\n");
@@ -262,12 +287,20 @@ static int decode_elf32(FILE *felf, char **argv)
 	machine = elf16_to_cpu(header.e_machine);
 	debug("Machine %d\n", machine);
 
-	if (machine != EM_MICROBLAZE) {
+	if (machine != EM_MICROBLAZE && machine != EM_M68K) {
 		fprintf(stderr, "%s: Not supported machine type\n", argv[0]);
 		return 30;
 	}
 
 	text_base = elf32_to_cpu(header.e_entry);
+	/*
+	 * M68K ELF entry point is MONITOR_BASE, not TEXT_BASE.
+	 * TEXT_BASE is always MONITOR_BASE &~ 0x7ff, so clear
+	 * those bits here.
+	 */
+	if (machine == EM_M68K)
+		text_base &= ~0x7ff;
+
 	section_header_base = elf32_to_cpu(header.e_shoff);
 	section_header_size = elf16_to_cpu(header.e_shentsize) *
 			      elf16_to_cpu(header.e_shnum);
@@ -488,25 +521,44 @@ static bool supported_rela32(Elf32_Rela *rela, uint32_t *type)
 
 	debug("Type:\t");
 
-	switch (*type) {
-	case R_MICROBLAZE_32:
-		debug("R_MICROBLAZE_32\n");
-		return true;
-	case R_MICROBLAZE_GLOB_DAT:
-		debug("R_MICROBLAZE_GLOB_DAT\n");
-		return true;
-	case R_MICROBLAZE_NONE:
-		debug("R_MICROBLAZE_NONE - ignoring - do nothing\n");
-		return false;
-	case R_MICROBLAZE_REL:
-		debug("R_MICROBLAZE_REL\n");
-		return true;
-	default:
-		fprintf(stderr, "warning: unsupported relocation type %"
-			PRIu32 " at %" PRIx32 "\n", *type, rela->r_offset);
-
-		return false;
+	if (machine == EM_M68K) {
+		switch (*type) {
+		case R_68K_32:
+			debug("R_68K_32\n");
+			return true;
+		case R_68K_GLOB_DAT:
+			debug("R_68K_GLOB_DAT\n");
+			return true;
+		case R_68K_JMP_SLOT:
+			debug("R_68K_JMP_SLOT\n");
+			return true;
+		case R_68K_NONE:
+			debug("R_68K_NONE - ignoring - do nothing\n");
+			return false;
+		case R_68K_RELATIVE:
+			debug("R_68K_RELATIVE\n");
+			return true;
+		}
+	} else {
+		switch (*type) {
+		case R_MICROBLAZE_32:
+			debug("R_MICROBLAZE_32\n");
+			return true;
+		case R_MICROBLAZE_GLOB_DAT:
+			debug("R_MICROBLAZE_GLOB_DAT\n");
+			return true;
+		case R_MICROBLAZE_NONE:
+			debug("R_MICROBLAZE_NONE - ignoring - do nothing\n");
+			return false;
+		case R_MICROBLAZE_REL:
+			debug("R_MICROBLAZE_REL\n");
+			return true;
+		}
 	}
+	fprintf(stderr, "warning: unsupported relocation type %"
+		PRIu32 " at %" PRIx32 "\n", *type, rela->r_offset);
+
+	return false;
 }
 
 static int rela_elf32(char **argv, FILE *f)
@@ -569,8 +621,8 @@ static int rela_elf32(char **argv, FILE *f)
 
 		debug("Addr:\t0x%" PRIx32 "\n", addr);
 
-		switch (type) {
-		case R_MICROBLAZE_REL:
+		if ((machine == EM_M68K && type == R_68K_RELATIVE) ||
+		    (machine == EM_MICROBLAZE && type == R_MICROBLAZE_REL)) {
 			if (fseek(f, addr, SEEK_SET) < 0) {
 				fprintf(stderr, "%s: %s: seek to %"
 					PRIx32 " failed: %s\n",
@@ -585,9 +637,12 @@ static int rela_elf32(char **argv, FILE *f)
 					argv[0], argv[1], addr);
 				return 4;
 			}
-			break;
-		case R_MICROBLAZE_32:
-		case R_MICROBLAZE_GLOB_DAT:
+		} else if ((machine == EM_M68K &&
+		            (type == R_68K_32 || type == R_68K_GLOB_DAT ||
+			     type == R_68K_JMP_SLOT)) ||
+			   (machine == EM_MICROBLAZE &&
+			    (type == R_MICROBLAZE_32 ||
+			     type == R_MICROBLAZE_GLOB_DAT))) {
 			/* global symbols read it and add reloc offset */
 			index = swrela.r_info >> 8;
 			pos_dyn = dyn_start + sizeof(Elf32_Sym) * index;
@@ -632,12 +687,11 @@ static int rela_elf32(char **argv, FILE *f)
 					argv[0], argv[1], addr);
 				return 4;
 			}
-
-			break;
-		case R_MICROBLAZE_NONE:
+		} else if (machine == EM_M68K && type == R_68K_NONE) {
+			debug("R_68K_NONE - skip\n");
+		} else if (machine == EM_MICROBLAZE && type == R_MICROBLAZE_NONE) {
 			debug("R_MICROBLAZE_NONE - skip\n");
-			break;
-		default:
+		} else {
 			fprintf(stderr, "warning: unsupported relocation type %"
 				PRIu32 " at %" PRIx32 "\n",
 				type, rela.r_offset);
-- 
2.40.1

