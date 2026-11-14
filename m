Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B161A606A323
	for <u-boot@archiver.kernel.org>; Sat, 14 Nov 2026 00:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=Sx6Lm95x
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7EB2160896;
	Sat, 14 Nov 2026 00:09:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xZE5-gdQ3xTt; Sat, 14 Nov 2026 00:09:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 91F94606F5
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794614977;
	b=QsLw3++ph9R0NB328TvZuJAxTtrXzoxtkMcK/VSVaU1EZPHqLNjS0GuHY1DR/iIXFajI
	 mBHCuAqt4H1YDNYe0lvfByKR/EVUjKtOLLDBQDK2Ixea72w0eHdw54k7HpnzfmxtEzuuG
	 Ti78rA+ZqEgzsD3ODBw9DqN/0h1XL6G0pAOXJ465/ZRTqOhUYFpjU24ybVettXmO30bDM
	 9xk7/sPv9jNewcKtDleaqCD21US+056pKt44blyeb/8FdarfIEyplHq848FOpB7xui4mK
	 PuIphvmWUs0W+VdXB2XcbaCJY7ieNSjHbGEOkEcUZQyMTkRHDSwBKbr7rEKbQQ2vjUA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794614977;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:Date:
	 From:To:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=70D4mUlD/JqJfD8eWu3/VZ+x583nuCgMHqVTxP5Js/A=;
	b=YNqXmZtnMEHOrXUt7vH/Jr45YHZu+3irfwd1yCbL5P/KWXMDUrMw7vVuD2kR/HF6J4Mo
	 QOjefQL7LU6IttlUoYtRvw1vRFfafVK2r3w6g9JA9EzHrsnjmfnTTTD9J7L27rrRnitlg
	 k8IXofK3fjF2mm+fKaKsljgHnzq2d/Q5mGq3fuJ6u1cOszu4Ohf8R48IOCRA3rRyVlWNV
	 siG8gfDVkOXDC0Bcb5HF+Kj4WjxV+wXlrlWLy75o7vseJC+MDUCYHTTDsVeI/VTEAcGbp
	 VdJRb7B9ZRwctjF0rhEJm5sXiUpKvqjWyGLgtYTvvu/Yze8NOhN/eaXGZypvHx/8VVA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794614977;
	bh=70D4mUlD/JqJfD8eWu3/VZ+x583nuCgMHqVTxP5Js/A=;
	h=Date:From:To:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Sx6Lm95xNYw47FTQn+OqxIe3UKDaSiTr/1VY5Ht8sgd8QO8Rjq8hSihAELc9OL/nG
	 /6sjCVNLXCJi4HMKdtK4wDqCoSA0dxZ5pGqLVbewj+BO8u/yvtlW/qzJMtsVTmhiZT
	 1miAxJcOAGcRW3p1lqA7ZaR7iG76x7G0n74ZkEk5PzNSr5wSZOzMlNGHKu4TFUvMal
	 VhYTR0D8zLePGQKk8LjEO4iP5Agao8WpZb4dfzpCVRQwu5PrIOdWVpgAArrhX2ORs/
	 o47lzjHN0maqpnTJVCxmpk8PXWVIoZXPIkM5WDSQnyK7hhGSyTyipAMGg/ast6MoAl
	 Pbc04eu3MOufQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 91F94606F5;
	Sat, 14 Nov 2026 00:09:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 39E172FB
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 00:09:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 37AD240269
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 00:09:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Vk_SuX1z88Hv for <u-boot@lists.u-boot-project.org>;
 Sat, 14 Nov 2026 00:09:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org C623C4025F
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a07:2ec0:3002::65"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a07:2ec0:3002::65;
 helo=pidgin.makrotopia.org; envelope-from=daniel@makrotopia.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=none (p=none dis=none)
 header.from=makrotopia.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org
 [IPv6:2a07:2ec0:3002::65])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C623C4025F
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 00:09:33 +0000 (UTC)
Received: from local by pidgin.makrotopia.org with esmtpsa
 (TLS1.3:TLS_AES_256_GCM_SHA384:256:X25519MLKEM768) (Exim 4.100.1)
 (envelope-from <daniel@makrotopia.org>) id 1xS1Kf-000000008Tu-0VEI;
 Sat, 14 Nov 2026 00:09:25 +0000
Date: Sat, 14 Nov 2026 00:09:22 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Alexey Brodkin <alexey.brodkin@synopsys.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>,
 Yao Zi <me@ziyao.cc>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Daniel Golle <daniel@makrotopia.org>,
 Aristo Chen <aristo.chen@canonical.com>,
 =?iso-8859-1?Q?Jo=E3o?= Loureiro <joaofl@gmail.com>,
 uboot-snps-arc@synopsys.com, u-boot@lists.u-boot-project.org,
 openwrt-devel@lists.openwrt.org
Subject: [PATCH 1/9] boot: Return distinct errors for ordinary bootm failures
Message-ID: <6967c8e6471682be69f20ac7436e8180cf348ec1.1794614777.git.daniel@makrotopia.org>
References: <cover.1794614777.git.daniel@makrotopia.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1794614777.git.daniel@makrotopia.org>
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The image allocation helpers and several Linux boot handlers return -1
for ordinary failures. This is BOOTM_ERR_RESET, so bootm_run_states()
resets the board for an allocation failure or an unsupported subcommand.

Return -ENOMEM for allocation failures and -ENOSYS for unsupported
subcommands.

Fixes: 148c55c66c33 ("boot: bootm: release the imagemap on every failing exit")
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 arch/arc/lib/bootm.c        |  5 +++--
 arch/arm/lib/bootm.c        |  3 ++-
 arch/microblaze/lib/bootm.c |  3 ++-
 arch/mips/lib/bootm.c       |  3 ++-
 arch/riscv/lib/bootm.c      |  3 ++-
 arch/x86/lib/bootm.c        |  2 +-
 boot/image-board.c          | 13 +++++++------
 7 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/arch/arc/lib/bootm.c b/arch/arc/lib/bootm.c
index 91165a06a46..b41422f2216 100644
--- a/arch/arc/lib/bootm.c
+++ b/arch/arc/lib/bootm.c
@@ -6,6 +6,7 @@
 #include <bootm.h>
 #include <bootstage.h>
 #include <env.h>
+#include <errno.h>
 #include <image.h>
 #include <irq_func.h>
 #include <log.h>
@@ -78,7 +79,7 @@ int do_bootm_linux(int flag, struct bootm_info *bmi)
 
 	/* No need for those on ARC */
 	if ((flag & BOOTM_STATE_OS_BD_T) || (flag & BOOTM_STATE_OS_CMDLINE))
-		return -1;
+		return -ENOSYS;
 
 	if (flag & BOOTM_STATE_OS_PREP)
 		return boot_prep_linux(images);
@@ -88,5 +89,5 @@ int do_bootm_linux(int flag, struct bootm_info *bmi)
 		return 0;
 	}
 
-	return -1;
+	return -ENOSYS;
 }
diff --git a/arch/arm/lib/bootm.c b/arch/arm/lib/bootm.c
index 9a115cc6078..753ec0016e7 100644
--- a/arch/arm/lib/bootm.c
+++ b/arch/arm/lib/bootm.c
@@ -20,6 +20,7 @@
 #include <asm/global_data.h>
 #include <dm/root.h>
 #include <env.h>
+#include <errno.h>
 #include <image.h>
 #include <u-boot/zlib.h>
 #include <asm/byteorder.h>
@@ -380,7 +381,7 @@ int do_bootm_linux(int flag, struct bootm_info *bmi)
 
 	/* No need for those on ARM */
 	if (flag & BOOTM_STATE_OS_BD_T || flag & BOOTM_STATE_OS_CMDLINE)
-		return -1;
+		return -ENOSYS;
 
 	if (flag & BOOTM_STATE_OS_PREP) {
 		boot_prep_linux(images);
diff --git a/arch/microblaze/lib/bootm.c b/arch/microblaze/lib/bootm.c
index b54c902602f..257ca42fa7c 100644
--- a/arch/microblaze/lib/bootm.c
+++ b/arch/microblaze/lib/bootm.c
@@ -12,6 +12,7 @@
 #include <command.h>
 #include <cpu_func.h>
 #include <env.h>
+#include <errno.h>
 #include <fdt_support.h>
 #include <hang.h>
 #include <image.h>
@@ -69,7 +70,7 @@ int do_bootm_linux(int flag, struct bootm_info *bmi)
 
 	/* cmdline init is the part of 'prep' and nothing to do for 'bdt' */
 	if (flag & BOOTM_STATE_OS_BD_T || flag & BOOTM_STATE_OS_CMDLINE)
-		return -1;
+		return -ENOSYS;
 
 	if (flag & BOOTM_STATE_OS_PREP) {
 		boot_prep_linux(images);
diff --git a/arch/mips/lib/bootm.c b/arch/mips/lib/bootm.c
index 066c830f3fa..cc2b94a8efb 100644
--- a/arch/mips/lib/bootm.c
+++ b/arch/mips/lib/bootm.c
@@ -7,6 +7,7 @@
 #include <bootm.h>
 #include <bootstage.h>
 #include <env.h>
+#include <errno.h>
 #include <image.h>
 #include <fdt_support.h>
 #include <log.h>
@@ -286,7 +287,7 @@ int do_bootm_linux(int flag, struct bootm_info *bmi)
 
 	/* No need for those on MIPS */
 	if (flag & BOOTM_STATE_OS_BD_T)
-		return -1;
+		return -ENOSYS;
 
 	/*
 	 * Cmdline init has been moved to 'bootm prep' because it has to be
diff --git a/arch/riscv/lib/bootm.c b/arch/riscv/lib/bootm.c
index 69c9ca5c487..0500387ded7 100644
--- a/arch/riscv/lib/bootm.c
+++ b/arch/riscv/lib/bootm.c
@@ -10,6 +10,7 @@
 #include <bootm.h>
 #include <command.h>
 #include <dm.h>
+#include <errno.h>
 #include <fdt_support.h>
 #include <hang.h>
 #include <log.h>
@@ -75,7 +76,7 @@ int do_bootm_linux(int flag, struct bootm_info *bmi)
 
 	/* No need for those on RISC-V */
 	if (flag & BOOTM_STATE_OS_BD_T || flag & BOOTM_STATE_OS_CMDLINE)
-		return -1;
+		return -ENOSYS;
 
 	if (flag & BOOTM_STATE_OS_PREP) {
 		boot_prep_linux(images);
diff --git a/arch/x86/lib/bootm.c b/arch/x86/lib/bootm.c
index e054f42fa86..2647ec0c950 100644
--- a/arch/x86/lib/bootm.c
+++ b/arch/x86/lib/bootm.c
@@ -236,7 +236,7 @@ int do_bootm_linux(int flag, struct bootm_info *bmi)
 
 	/* No need for those on x86 */
 	if (flag & BOOTM_STATE_OS_BD_T || flag & BOOTM_STATE_OS_CMDLINE)
-		return -1;
+		return -ENOSYS;
 
 	if (flag & BOOTM_STATE_OS_PREP)
 		return boot_prep_linux(images);
diff --git a/boot/image-board.c b/boot/image-board.c
index 7602f5bfaaa..020d417a378 100644
--- a/boot/image-board.c
+++ b/boot/image-board.c
@@ -13,6 +13,7 @@
 #include <cpu_func.h>
 #include <display_options.h>
 #include <env.h>
+#include <errno.h>
 #include <fpga.h>
 #include <image.h>
 #include <init.h>
@@ -534,7 +535,7 @@ int boot_get_ramdisk(char const *select, struct bootm_headers *images,
  *
  * returns:
  *      0 - success
- *     -1 - failure
+ *     -ENOMEM - allocation failure
  */
 int boot_ramdisk_high(ulong rd_data, ulong rd_len, ulong *initrd_start,
 		      ulong *initrd_end)
@@ -615,7 +616,7 @@ int boot_ramdisk_high(ulong rd_data, ulong rd_len, ulong *initrd_start,
 	return 0;
 
 error:
-	return -1;
+	return -ENOMEM;
 }
 
 int boot_get_setup(struct bootm_headers *images, u8 arch,
@@ -837,7 +838,7 @@ int boot_get_loadable(struct bootm_headers *images)
  *
  * returns:
  *      0 - success
- *     -1 - failure
+ *     -ENOMEM - allocation failure
  */
 int boot_get_cmdline(ulong *cmd_start, ulong *cmd_end)
 {
@@ -858,7 +859,7 @@ int boot_get_cmdline(ulong *cmd_start, ulong *cmd_end)
 
 	err = lmb_alloc_mem(LMB_MEM_ALLOC_MAX, 0xf, &addr, barg, LMB_NONE);
 	if (err)
-		return -1;
+		return -ENOMEM;
 
 	cmdline = (char *)(uintptr_t)addr;
 
@@ -886,7 +887,7 @@ int boot_get_cmdline(ulong *cmd_start, ulong *cmd_end)
  *
  * returns:
  *      0 - success
- *     -1 - failure
+ *     -ENOMEM - allocation failure
  */
 int boot_get_kbd(struct bd_info **kbd)
 {
@@ -897,7 +898,7 @@ int boot_get_kbd(struct bd_info **kbd)
 	err = lmb_alloc_mem(LMB_MEM_ALLOC_MAX, 0xf, &addr,
 			    sizeof(struct bd_info), LMB_NONE);
 	if (err)
-		return -1;
+		return -ENOMEM;
 
 	*kbd = (struct bd_info *)(uintptr_t)addr;
 	**kbd = *gd->bd;
-- 
2.56.0
