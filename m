Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 844F0CA9EBB
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 20:21:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 43D678149E;
	Fri,  9 Oct 2026 20:21:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1BIp1u3ji_ow; Fri,  9 Oct 2026 20:21:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 2C163812EE
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791577295;
	b=iXL6nl+SnUuZB6yzqtEHSZsxwuMvLLSw3RqBDZjlMSxuAcn7J6My1i1Z/iDT74Xd7bOB
	 K9bmt91brUCyxUvf5Oiml7M8po/49G1YdlsN0GYb3S/8uVIndVjSh5fqlkhvTqzLAiPdx
	 NGbC20lr6WD/GXv0duyXQlYfSu44m3/sIXMMqs/DtnixH3f96YTJHrHy7SXZZYkytUy7r
	 bTi/roC3wsjy9RUgYuZ12FFOs6CKnOTq8JxHtMvElpUyrTsEonlyxfSAeGOLvnsRQrY/k
	 BIkKlbxiSoSYhX9z4oZuixkoWiVk5y1EzP+4FqIvJbcLgspo3jTHOb0TmhXzyaUeDmQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791577295;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=AFMvz9b4dOMN1FRJpPmTaQ7hWyDEHRwaVHVlalZx7wU=;
	b=UvsX2YvFKDReeGP9CMSwTL4gmL9vjUT8V1fRcLuUd0A8WXh7qBJtJobgI0uvzerl2Sv9
	 Yu4EI4Jan3jHbertDgQ/Wm9Pq6gr0mxsSwG2MAfA8na2o2Nhiy17cmENbyv8jxTRVXFyV
	 Ed3BsX+DanaD2i/kMNBqGpB5qq6u6TF8IX6b7UB76Yf5u+raK1L52ynp9Xbdh5PzA1XA6
	 iKBIzpzhN697sDKbUF4YWBsvbST9JJba9Bz8Si5ijz2keYGOnVJafyNhlq6dK3awvCuJY
	 gQINbIDG7f+d8kqV4ncUZq/3jqqvZLrJ1Qk4rTwOnAQCoJVzsiPxJ+6plhxc88XH14A==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791577295;
	bh=AFMvz9b4dOMN1FRJpPmTaQ7hWyDEHRwaVHVlalZx7wU=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:From;
	b=Ii7QQlRBUEVaSDmRnWUN+cmTeHbw3HIt/yTw8+cz5AIm7E7TTnO1ccqoiJa36FRFu
	 wHDztBIwLtc73UPklVk9I0deHztmujoDtZe7KfpjK+VBAnr4pY9vIaZelEAQddHtEe
	 /ZXFscAQWhEr4sveRafWQU2QRtMB5ftLwwZ7Bi8D5w6U40F929Mg+dV8NA2nBmWVGU
	 E6IQASw1zAg+ZF5QXauPv7U4HlFWEEyIxAxyyrDpuQD1qkAGijPiHzYy6tHHzNJj1D
	 wd/x6itYpJPQWSHE6danWsokhkQ1yE4VcJ5xr6HcVCzQrQ26g/1cfXVq/A1rZht0EJ
	 l0mA8B6NMJPMg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2C163812EE;
	Fri,  9 Oct 2026 20:21:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id F127A3B4
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 20:13:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E319440053
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 20:13:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aGjY_gSSwnM9 for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 20:13:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org D5C1D40080
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791576837;
 b=lUb8TWkCEQq13aFLDn+kRZg1IlAXUSYZieTIWc1iVU59ZgSEmk+gRzDWF8Ih4NS7MY+L
 d245USxdYA0rWyloRaCjqaVMrmcZYZOIOKnvemj9u+iA7mpZe38P0DISRNmqzHRWAZ+Va
 6N2g2aPSV0F1VNPeNGJ6u8broghJxxirTj5ggkcH75zumCbsLoxF9JscIJKMiFjjhWRAL
 Lmu+5efmuXOTABBiYuYC+7pcUuI1ccHZXSwjV3AIqCo3bCI4o+dukJFvSP06dGBuJ1/ZO
 AhsZdewtEFcsrIXRBSJn6XxiRQk8cAE7LTRuGiCrRF8iNU80pbtMNN9PVT62dyEsZWw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791576837;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=AFMvz9b4dOMN1FRJpPmTaQ7hWyDEHRwaVHVlalZx7wU=;
 b=F/5JSwHQkYGSVtUGiky6Ga8osoroyKm/D4lwxR4YS6YEc05VaCa5w+HfO8q6DqAtp/Vr
 orw9FAqOU6xkT+Nt/it7W+84+uU1AZjZnBzuKVj62jgChe1pvFAbVyu/z2JsY7Hg9cdDI
 DbbAxOOSLNJgyC92gJu1tTFGM9EmZ3s9Fcn6vMqFSfgwZFO+wYDt8gyTEbpYBtostCmHO
 G++UrPXlqsfUP2AR1OSN/AqCGmLE3aBmYTQ5CFseyCoKofyXR7HPiReV5BgIqQca+jCC+
 631G+fnJUay13aPeqAf9NnyFauFeUU3QYHWlzGtoAY2M1PsLp+lVdAeBzZ6uV+E7zJw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=ofFFKF1A; 
 arc=none smtp.remote-ip=172.105.4.254
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org;
 envelope-from=devnull+wadowski.arkadiusz.gmail.com@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=ofFFKF1A
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D5C1D40080
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 20:13:56 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 0D59460120;
 Fri,  9 Oct 2026 20:13:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B255EC2BCF5;
 Fri,  9 Oct 2026 20:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1791576834;
 bh=YdqPq/wM5sukbWCT3qOZsj7HR0HlQt+TQvjKTXSpAh8=;
 h=From:Date:Subject:To:Cc:Reply-To:From;
 b=ofFFKF1AO14TR0Iu5AS1fwHUPkG0VIPgGIo2SbgDtY+2P3PPHFLWM6hsPp1jLtrk6
 JaWfYfYTAUYPKOXpqFLdrwSrycAXs4miieNmvL4dqxf+fKj/66XLan5CsOWv6FVfui
 IWeZyudar5tv891YZFgWxgtLD5Qg0qDWY7Z6XRFhw9n1MKtthjI10AtTQg3H3XFlnQ
 3MWar7DWsIc7jijuFCQmyBZTrxcGLqW8iSba/UPLq9WWcAzWitL5WBJtvw7qr3vt3r
 v0K4o8w4j9TFRuTvftI1bIBGRGfRBVzAOLfrdPBpjWJWFLNCcutOkpf5yndDM32/Vd
 MuPU6MMKLbGmw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 8DE24CA9EBB;
 Fri,  9 Oct 2026 20:13:54 +0000 (UTC)
From: Arkadiusz Wadowski via B4 Relay
 <devnull+wadowski.arkadiusz.gmail.com@kernel.org>
Date: Fri, 09 Oct 2026 22:13:17 +0200
Subject: [PATCH v2] board: qemu-arm: Add SPL support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-spl-for-quemu-arm-v2-1-460427488c17@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32NQQ6CMBBFr0Jm7Zi2KLauvIdhUXCAMZRiC0RDu
 LuAe5cvef/9GSIFpgjXZIZAE0f23QrqkEDZ2K4m5MfKoITKpBAGY99i5QO+RnIj2uBQnaQyF1P
 Ys0lh3fWBKn7vzXv+4zgWTyqHLbQZDcfBh89+OsnN+9efJErUZFMjMl1prW+1s9weS+8gX5blC
 xqr8ETEAAAA
X-Change-ID: 20261009-spl-for-quemu-arm-2412979ba593
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, 
 Arkadiusz Wadowski <wadowski.arkadiusz@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791576832; l=4979;
 i=wadowski.arkadiusz@gmail.com; s=20261009; h=from:subject:message-id;
 bh=JDkQR1jI2dR/+MdscKbdpNDlzhyz0P3/TwaN7s3vVZ4=;
 b=j3UA4W8rEIyYREwUeSyNRITg2Xxycvn/9nLA6oDcUEAcCZ1Ccin5scumdFBSVlV97P9WmgwKp
 XdnmqLlz9+XDeOSYaFbT6iKfBGiCWI89yFdhxTPQIF8DPLiJ4Nbpu/9
X-Developer-Key: i=wadowski.arkadiusz@gmail.com; a=ed25519;
 pk=HKeMLZz72hO1HTxmFN3fZohsVyICtXJ2xUrbSalR0wQ=
X-Endpoint-Received: by B4 Relay for wadowski.arkadiusz@gmail.com/20261009
 with auth_id=1144
X-Original-From: Arkadiusz Wadowski <wadowski.arkadiusz@gmail.com>
X-Mailman-Approved-At: Fri, 09 Oct 2026 20:21:34 +0000
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
Reply-To: wadowski.arkadiusz@gmail.com
Errors-To: u-boot-bounces@lists.u-boot-project.org

From: Arkadiusz Wadowski <wadowski.arkadiusz@gmail.com>

Add an optional SPL boot path for the QEMU ARM64 virt machine,
allowing the SPL-to-U-Boot boot flow to be explored without
physical hardware.

Use the existing NOR loader to load u-boot.img from flash into
RAM at 0x41000000. Generate u-boot-with-spl.bin with the payload
placed after SPL padding.

Signed-off-by: Arkadiusz Wadowski <wadowski.arkadiusz@gmail.com>
---
This patch adds an optional SPL boot path for the QEMU ARM64 virt
machine. It provides an emulated environment for exploring the
SPL-to-U-Boot boot flow without physical hardware.

SPL starts at flash address zero and uses the existing NOR loader
to load U-Boot proper into RAM at 0x41000000. The combined
u-boot-with-spl.bin image places u-boot.img at flash offset 0x100000.

QEMU provides initialized RAM at reset, so this boot path does
not require a DRAM initialization sequence.
---
Changes in v2:
- EDITME: describe what is new in this series revision.
- EDITME: use bulletpoints and terse descriptions.
- Link to v1: https://patch.msgid.link/20261009-spl-for-quemu-arm-v1-1-8ea39068f888@gmail.com
---
 Makefile                             |  2 +-
 arch/arm/mach-qemu/Kconfig           |  1 +
 board/emulation/qemu-arm/Kconfig     |  2 ++
 board/emulation/qemu-arm/Kconfig.spl | 40 ++++++++++++++++++++++++++++++++++++
 board/emulation/qemu-arm/qemu-arm.c  |  8 ++++++++
 include/configs/qemu-arm.h           |  4 ++++
 6 files changed, 56 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 6303a0cca6a..49c1da0fb03 100644
--- a/Makefile
+++ b/Makefile
@@ -2458,7 +2458,7 @@ spl/u-boot-spl-dtb.bin: spl/u-boot-spl
 spl/u-boot-spl-dtb.hex: spl/u-boot-spl
 	@:
 
-spl/u-boot-spl: tools prepare $(if $(CONFIG_SPL_OF_CONTROL),dts/dt.dtb)
+spl/u-boot-spl: tools prepare $(if $(and $(CONFIG_SPL_OF_CONTROL),$(filter-out y,$(CONFIG_OF_OMIT_DTB))),dts/dt.dtb)
 	$(Q)$(MAKE) obj=spl -f $(srctree)/scripts/Makefile.xpl all
 
 spl/sunxi-spl.bin: spl/u-boot-spl
diff --git a/arch/arm/mach-qemu/Kconfig b/arch/arm/mach-qemu/Kconfig
index 9c06c6a3a5c..7e8aa62d38c 100644
--- a/arch/arm/mach-qemu/Kconfig
+++ b/arch/arm/mach-qemu/Kconfig
@@ -18,6 +18,7 @@ config TARGET_QEMU_ARM_64BIT
 	bool "ARMv8, 64bit"
 	select ARM64
 	select BOARD_LATE_INIT
+	select SUPPORT_SPL
 
 config TARGET_QEMU_ARM_SBSA
 	bool "SBSA Reference"
diff --git a/board/emulation/qemu-arm/Kconfig b/board/emulation/qemu-arm/Kconfig
index 447061b25cd..b66b260b292 100644
--- a/board/emulation/qemu-arm/Kconfig
+++ b/board/emulation/qemu-arm/Kconfig
@@ -1,3 +1,5 @@
+source "board/emulation/qemu-arm/Kconfig.spl"
+
 if TARGET_QEMU_ARM_32BIT || TARGET_QEMU_ARM_64BIT
 
 config TEXT_BASE
diff --git a/board/emulation/qemu-arm/Kconfig.spl b/board/emulation/qemu-arm/Kconfig.spl
new file mode 100644
index 00000000000..5dd7f478e82
--- /dev/null
+++ b/board/emulation/qemu-arm/Kconfig.spl
@@ -0,0 +1,40 @@
+# SPDX-License-Identifier: GPL-2.0+
+if TARGET_QEMU_ARM_64BIT && SPL
+
+config TEXT_BASE
+	range 0x41000000 0xffffffff
+	default 0x41000000
+
+config QEMU_ARM64_SPL
+	def_bool y
+	select SPL_LIBCOMMON_SUPPORT
+	select SPL_LIBGENERIC_SUPPORT
+	select SPL_HAS_BSS_LINKER_SECTION
+	select SPL_SEPARATE_BSS
+	select SPL_NOR_SUPPORT
+	select PANIC_HANG
+	select SPL_LEGACY_IMAGE_FORMAT
+	select SPL_DM
+	select SPL_OF_CONTROL
+	select SPL_SERIAL
+	select SPL_DM_SERIAL
+
+config SPL_PAYLOAD
+	default "u-boot.img"
+
+config SPL_TARGET
+	default "u-boot-with-spl.bin"
+
+config SPL_BLOBLIST
+	default n
+
+config SPL_MAX_SIZE
+	default 0x100000
+
+config SPL_BSS_START_ADDR
+	default 0x40400000
+
+config SPL_BSS_MAX_SIZE
+	default 0x100000
+
+endif
diff --git a/board/emulation/qemu-arm/qemu-arm.c b/board/emulation/qemu-arm/qemu-arm.c
index 38f0ec5f2fb..b0ab31ce793 100644
--- a/board/emulation/qemu-arm/qemu-arm.c
+++ b/board/emulation/qemu-arm/qemu-arm.c
@@ -11,6 +11,7 @@
 #include <fdtdec.h>
 #include <init.h>
 #include <log.h>
+#include <spl.h>
 #include <usb.h>
 #include <virtio_types.h>
 #include <virtio.h>
@@ -202,3 +203,10 @@ void flash_write32(u32 value, void *addr)
 {
 	asm("str %" __W "1, %0" : "=m"(*(u32 *)addr) : "r"(value));
 }
+
+#if defined(CONFIG_TARGET_QEMU_ARM_64BIT) && defined(CONFIG_SPL_BUILD)
+u32 spl_boot_device(void)
+{
+	return BOOT_DEVICE_NOR;
+}
+#endif
diff --git a/include/configs/qemu-arm.h b/include/configs/qemu-arm.h
index e296f398798..18939dd8fd5 100644
--- a/include/configs/qemu-arm.h
+++ b/include/configs/qemu-arm.h
@@ -11,4 +11,8 @@
 
 /* For timer, QEMU emulates an ARMv7/ARMv8 architected timer */
 
+#if defined(CONFIG_TARGET_QEMU_ARM_64BIT) && defined(CONFIG_SPL)
+#define CFG_SYS_UBOOT_BASE CONFIG_SPL_PAD_TO
+#endif
+
 #endif /* __CONFIG_H */

---
base-commit: 0a55b098d6f5f6bafa84fc2f18b433dd167bf729
change-id: 20261009-spl-for-quemu-arm-2412979ba593

Best regards,
--  
Arkadiusz Wadowski <wadowski.arkadiusz@gmail.com>


