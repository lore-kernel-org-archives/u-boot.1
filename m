Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C8FFE7719E
	for <u-boot@archiver.kernel.org>; Sun, 12 Jan 2025 22:38:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72D52801A9;
	Sun, 12 Jan 2025 23:38:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="NYQTHRkQ";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="vE7+mrEU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B22380079; Sun, 12 Jan 2025 23:38:33 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15F3780658
 for <u-boot@lists.denx.de>; Sun, 12 Jan 2025 23:38:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4YWVfZ4vHPz9sW6;
 Sun, 12 Jan 2025 23:38:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1736721510;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YpqmVbcJOqpKdqXN1GLmdMYYxxA/yfPcnNZClsfHiT8=;
 b=NYQTHRkQEGssIItpJTLtXHpwoFblxomajmZJwq4V1yjD+8fhgTCRWhnviyi9R/TO5bnRuN
 bQwtPN9aGdaSWSszOffhGlbmn6ihCy/7CffEWPZeZuzmYWCP7VDRbm7Lr8CrLJBURg9Rzs
 Bip/Vaf2kG0RhDQQGGrw7rTQIJ5Y9kd/WKAKtOrtatodgQuV6/ko+zyXyZTOT7ALZuzzHC
 2ab1zroNocyN1oCv4zpU7PSw86fIWkNp3mhe2STZuaGPy8gRex3w7KDlwrO6Y/5fjH3Br+
 SdnzI/i5OhjS0GEH0bBAT5bNi/GP0csEJ20NNNX0mYfJ44UWcFcijfLyk/wyAg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1736721508;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YpqmVbcJOqpKdqXN1GLmdMYYxxA/yfPcnNZClsfHiT8=;
 b=vE7+mrEU3I21I3y3DOUcj3CKKVbRfRNVDryFEKzT4vL41lrIuNJukEJC0Ok4aWfq7kb+EA
 cKk/nwDDFNX+nhCpgV3HuJgWN85uG/42/hYWUJp4pFz+Ytyqq3vZnCrNrdaFbyEKatnf7+
 cV5ExbqKhDtdQzqC4XzW5sUt5sr0ls2HIu7pVW31vU7f+gs4zDwg1m2Z6TX1as2x6Y1orv
 Sa+1CmYLZzAwU1thOLmUKxD6Z8ajAmIvPGQd7xqSZDatf86JC2P141+0GT6KzkFGAxMNnI
 5qVuHYgIbTY7XtVOzVhSKzHc3EOaCYCM4VB4yHGtW2/Mq5cIRsEOTbSeNsDEVw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Andre Przywara <andre.przywara@arm.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Julien Masson <jmasson@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maxim Moskalets <maximmosk4@gmail.com>, Michael Walle <mwalle@kernel.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Paul-Erwan Rio <paulerwan.rio@gmail.com>,
 Peter Hoyes <Peter.Hoyes@arm.com>, Raymond Mao <raymond.mao@linaro.org>,
 Sam Protsenko <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 3/3] arm64: renesas: Add TFA BL31 handoff support
Date: Sun, 12 Jan 2025 23:36:59 +0100
Message-ID: <20250112223755.179959-3-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250112223755.179959-1-marek.vasut+renesas@mailbox.org>
References: <20250112223755.179959-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 73ef1c87008674c0a9e
X-MBO-RS-META: 1y51ptktjg98jzmxxabnq3z53t6nzbto
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

Implement custom U_BOOT_FIT_LOADABLE_HANDLER and armv8_switch_to_el2_prep()
handling in case the TFA was loaded. The loadables handler sets up custom
handoff structure used by Renesas TFA fork in fixed location in DRAM and
indicates the TFA has been loaded.

The custom armv8_switch_to_el2_prep() handling tests whether the TFA BL31
was previously loaded and the custom handoff structure was set up, and if
so, jumps to TFA BL31 which switches from EL3 to EL2 and then returns to
U-Boot just past bl in armv8_switch_to_el2() to finish starting the Linux
kernel.

The jump to Linux through TFA works in such a way that the custom
armv8_switch_to_el2_prep() handler configures the custom handoff structure
such that the target jump address of the TFA BL31 on exit is set to the
armv8_switch_to_el2() + 4, which is just past the bl, and just before the
U-Boot code which implements the Linux kernel boot from either EL. The
registers passed through the TFA BL31 are all the registers passed into
armv8_switch_to_el2_prep() to assure maximum compatibility with all the
boot modes. The armv8_switch_to_el2_prep() handler jumps to the TFA BL31,
which does its setup, drops EL from EL3 to EL2 and finally jumps to the
armv8_switch_to_el2() + 4 entry point, which then allows U-Boot to boot
the Linux kernel the usual way.

In order to build suitable kernel fitImage, build TFA first, temporarily
from downstream repository:
remote: https://github.com/renesas-rcar/arm-trusted-firmware.git
branch: rcar_gen4_v2.7_v4x

```
$ git clean -fqdx
$ MBEDTLS_DIR=/path/to/mbedtls/ make -j$(nproc) bl31 \
	PLAT=rcar_gen4 ARCH=aarch64 LSI=V4H SPD=none \
	CTX_INCLUDE_AARCH32_REGS=0 MBEDTLS_COMMON_MK=1 \
	PTP_NONSECURE_ACCESS=1 LOG_LEVEL=20 DEBUG=0 \
	ENABLE_ASSERTIONS=0 E=0
```

Build Linux kernel Image and device tree from current mainline Linux
kernel repository, obtain 'Image' and 'r8a779g0-white-hawk.dtb' .

Bundle the files together using provided fit-image.its fitImage description:
```
$ mkimage -f fit-image.its fitImage
```

To start the kernel fiImage generated in previous step, load fitImage
to DRAM and use the 'bootm' command to start it:
=> load 0x58000000 ... fitImage && bootm 0x58000000

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Andre Przywara <andre.przywara@arm.com>
Cc: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Julien Masson <jmasson@baylibre.com>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Maxim Moskalets <maximmosk4@gmail.com>
Cc: Michael Walle <mwalle@kernel.org>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Paul-Erwan Rio <paulerwan.rio@gmail.com>
Cc: Peter Hoyes <Peter.Hoyes@arm.com>
Cc: Raymond Mao <raymond.mao@linaro.org>
Cc: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Simon Glass <sjg@chromium.org>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 board/renesas/common/gen4-common.c | 118 +++++++++++++++++++++++++++++
 1 file changed, 118 insertions(+)

diff --git a/board/renesas/common/gen4-common.c b/board/renesas/common/gen4-common.c
index 52a0639073b..c7f3f9a30ab 100644
--- a/board/renesas/common/gen4-common.c
+++ b/board/renesas/common/gen4-common.c
@@ -7,11 +7,13 @@
 
 #include <asm/arch/renesas.h>
 #include <asm/arch/sys_proto.h>
+#include <asm/armv8/mmu.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/mach-types.h>
 #include <asm/processor.h>
 #include <asm/system.h>
+#include <image.h>
 #include <linux/errno.h>
 
 #define RST_BASE	0xE6160000 /* Domain0 */
@@ -88,3 +90,119 @@ int ft_board_setup(void *blob, struct bd_info *bd)
 {
 	return 0;
 }
+
+/* R-Car Gen4 TFA BL31 handoff structure and handling. */
+struct param_header {
+	u8			type;
+	u8			version;
+	u16			size;
+	u32			attr;
+};
+
+struct tfa_image_info {
+	struct param_header	h;
+	uintptr_t		image_base;
+	u32			image_size;
+	u32			image_max_size;
+};
+
+struct aapcs64_params {
+	u64			arg0;
+	u64			arg1;
+	u64			arg2;
+	u64			arg3;
+	u64			arg4;
+	u64			arg5;
+	u64			arg6;
+	u64			arg7;
+};
+
+struct entry_point_info {
+	struct param_header	h;
+	uintptr_t		pc;
+	u32			spsr;
+	struct aapcs64_params	args;
+};
+
+struct bl2_to_bl31_params_mem {
+	struct tfa_image_info	bl32_image_info;
+	struct tfa_image_info	bl33_image_info;
+	struct entry_point_info	bl33_ep_info;
+	struct entry_point_info	bl32_ep_info;
+};
+
+/* Default jump address, return to U-Boot */
+#define BL33_BASE	0x44100000
+/* Custom parameters address passed to TFA by ICUMXA loader */
+#define PARAMS_BASE	0x46422200
+
+/* Usually such a structure is produced by ICUMXA and passed in at 0x46422200 */
+static const struct bl2_to_bl31_params_mem blinfo_template = {
+	.bl33_ep_info.h.type = 1,	/* PARAM_EP */
+	.bl33_ep_info.h.version = 2,	/* Version 2 */
+	.bl33_ep_info.h.size = sizeof(struct entry_point_info),
+	.bl33_ep_info.h.attr = 0x81,	/* Executable | Non-Secure */
+	.bl33_ep_info.spsr = 0x2c9,	/* Mode=EL2, SP=ELX, Exceptions=OFF */
+	.bl33_ep_info.pc = BL33_BASE,
+
+	.bl33_image_info.h.type = 1,	/* PARAM_EP */
+	.bl33_image_info.h.version = 2,	/* Version 2 */
+	.bl33_image_info.h.size = sizeof(struct image_info),
+	.bl33_image_info.h.attr = 0,
+	.bl33_image_info.image_base = BL33_BASE,
+};
+
+static bool tfa_bl31_image_loaded;
+static ulong tfa_bl31_image_addr;
+
+static void tfa_bl31_image_process(ulong image, size_t size)
+{
+	/* Custom parameters address passed to TFA by ICUMXA loader */
+	struct bl2_to_bl31_params_mem *blinfo = (struct bl2_to_bl31_params_mem *)PARAMS_BASE;
+
+	/* Clear a page and copy template */
+	memset((void *)PARAMS_BASE, 0, PAGE_SIZE);
+	memcpy(blinfo, &blinfo_template, sizeof(*blinfo));
+	tfa_bl31_image_addr = image;
+	tfa_bl31_image_loaded = true;
+}
+
+U_BOOT_FIT_LOADABLE_HANDLER(IH_TYPE_TFA_BL31, tfa_bl31_image_process);
+
+void armv8_switch_to_el2_prep(u64 args, u64 mach_nr, u64 fdt_addr,
+			      u64 arg4, u64 entry_point, u64 es_flag)
+{
+	typedef void __noreturn (*image_entry_noargs_t)(void);
+	image_entry_noargs_t image_entry =
+		(image_entry_noargs_t)(void *)tfa_bl31_image_addr;
+	struct bl2_to_bl31_params_mem *blinfo =
+		(struct bl2_to_bl31_params_mem *)PARAMS_BASE;
+
+	/*
+	 * Destination address in arch/arm/cpu/armv8/transition.S
+	 * right past the first bl in armv8_switch_to_el2() to let
+	 * the rest of U-Boot pre-Linux code run. The code does run
+	 * without stack pointer!
+	 */
+	const u64 ep = ((u64)(uintptr_t)&armv8_switch_to_el2) + 4;
+
+	/* If TFA BL31 was not part of the fitImage, do regular boot. */
+	if (!tfa_bl31_image_loaded)
+		return;
+
+	/*
+	 * Set up kernel entry point and parameters:
+	 * x0 is FDT address, x1..x3 must be 0
+	 */
+	blinfo->bl33_ep_info.pc = ep;
+	blinfo->bl33_ep_info.args.arg0 = args;
+	blinfo->bl33_ep_info.args.arg1 = mach_nr;
+	blinfo->bl33_ep_info.args.arg2 = fdt_addr;
+	blinfo->bl33_ep_info.args.arg3 = arg4;
+	blinfo->bl33_ep_info.args.arg4 = entry_point;
+	blinfo->bl33_ep_info.args.arg5 = es_flag;
+	blinfo->bl33_image_info.image_base = ep;
+
+	/* Jump to TFA BL31 */
+	image_entry();
+}
-- 
2.45.2

