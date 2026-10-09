Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4505ACA601E
	for <u-boot@archiver.kernel.org>; Fri,  9 Oct 2026 18:14:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E456A81470;
	Fri,  9 Oct 2026 18:14:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tMKR0InjzD2r; Fri,  9 Oct 2026 18:14:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org C4DA781497
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791569679;
	b=gLGCfigHN9rjy4xMxDsw4zTnyru1t61hALHFM2PKOLmKWjHS106X80rmOVTHkv/ynQ/G
	 36iix7AhBoM68+JUuDVWLoAtyzY16k5VB4ly5grpasn04rDOgJzH/b2tJfWuQrXoXVKw0
	 5Mx4MIdLWXCzE7KNIEQ5hESujRxYMBHPijgpmx0v0sf6Y2CPqtVaCAXCZ76jlRRRiBqh3
	 3QkO6Xhn/Zk4nI+YzOnI/0p3sVSlKaQP1yjdkPZyWhKGtI0Q3Y+qCWVnRo1LYCY0m0p7C
	 yBVcDBVvwkUz+mF4HjRzQKrdYAmCuX+a4iY/Pzwm89DhBqAmPOwixsL/1cKO43FFhPw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791569679;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:X-Mailman-Approved-At:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=zSrv/MkYUMf0Be4ogJf8u+hDOGYx5ivC2WKR95pwwqE=;
	b=epzSkByOxf8qU+TxOfQoypVy8UKkOJJbp1TaVmXb7AuZKUy/iR7cxHtVfHZ2o9HProTB
	 wntu7bjtTlyMwahPd1qmTBBuwTtIWsDSlqVAexDebfenGGv3XpbI9SJ6DqmyanFWcW6+D
	 j8fY/jJn3SJegd+Zkvy3BjjzYPfWL8ubDHf7fLbUvxGbnpQVtkwaWKa7vBnFmUzoAN1dL
	 m1DFCVoMO0DOMVfSCdhetgofm1WgASf0ACyaRaQEjuvmSONaAibh4/Z+OE7J6h8DQc8DH
	 IThZFWzisMAPr2IL1h6GA9pK2Tk82i/KFU+R77G1evugAcmIN0FJimxuDvlTu5aGVgg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791569679;
	bh=zSrv/MkYUMf0Be4ogJf8u+hDOGYx5ivC2WKR95pwwqE=;
	h=From:Date:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:From;
	b=TndTKTBl08exynM8jZqJFfHza47QH6nNG+Q7Lr/tTmkXPJRCcNQTlBW/S2G37+rui
	 CtbIMc/YAcriQwUrItJWqZGAXo5JhlqUKC7DA1b101uV+mXOtjql7Oxt1zJFuHPkXD
	 hv9y/hQrIq1r8w7XjXwxxQPq1TbzxMsEHYwYsVBlvitD3IGVKrDTC3mto4zj1KBJxU
	 0kRHZ2iu8DE1as9ZlC7wVwgvxHhbm0Ey4ytvRljyH2+f1SHUn5erm8Tx2bVMqV0kjg
	 haKY5iKYudMjiNpK/PT4QTaETqGgQWT6S4+F4lNpqzWyuQVeM0b03Uh1d6nZhrj4gM
	 ffyLsDIdsDvPQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C4DA781497;
	Fri,  9 Oct 2026 18:14:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 9749D2AA
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 16:18:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 88D0060644
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 16:18:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id g4ncGn2qqL3W for <u-boot@lists.u-boot-project.org>;
 Fri,  9 Oct 2026 16:18:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org DEC336061E
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791562724;
 b=URMjbZtVHfnskHFjaJi7nomFonNymlZjJfPoVoC8XP96BVrPGXhZCawBH7tvhF+OF5sg
 usY41jrvtBBaPGEUxISBBMHU2nweIhzAhdDYg5Td4WAJ9NnvMAN6KLkrJyvkrOkM0ctEF
 9jTs4jjERKziwLtuT8uZ+e2fv31V+pUncuOfzS73Z8J9oaCpMM1pn++UF4MK3aMVWJ2u1
 MFdJOsIE0dxyQFvcVyZHcMpjqsImowedgTnBc0U1PQ5ouRjLNDaFycMT4VcD/2R4xG2do
 7IolOXftVZ3+QixGpse9nzi1vkB2eWWPnIfTJILixKZuSYuu0AefhdMzQZwm2PznG9A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791562724;
 h=Received-SPF:Received:Received:DKIM-Signature:Received:From:Date:
 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=zSrv/MkYUMf0Be4ogJf8u+hDOGYx5ivC2WKR95pwwqE=;
 b=LsGlEhnewFrk76NKgtD0YAnumklKNmlae028Q4cRuncoaIRxm/u5OQDylT3k7dRRCmtZ
 AzsCBZIEse0SwEVoalKtJFFXbEEAIuodD1ljwFHoySmmYVpAiN7dsBamxma6AHeeCuGTF
 ljQN0QdyLPls36L8R0M5Qve54ztrIovYFH2KXqvRvwQhymUiGtb13q1NaD9uQuLNJrZ0Z
 R1Jt/Jha4/m/E7i99fPZBqVb9QL4J2mhK2eD1rhBHyTIrYET+UxED0W1RROspC9TgXVeY
 RLyMpPRnixNdLrzxqtAnS9fRQxviA3k5v8qf90KQGIFE0NVe+72cTz/4fZANYT5YsfQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=bzTvJEnq; 
 arc=none smtp.remote-ip=172.234.252.31
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org;
 envelope-from=devnull+wadowski.arkadiusz.gmail.com@kernel.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=bzTvJEnq
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DEC336061E
 for <u-boot@lists.u-boot-project.org>; Fri,  9 Oct 2026 16:18:43 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id C9D25416B2;
 Fri,  9 Oct 2026 16:18:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AB1E3C2BCF7;
 Fri,  9 Oct 2026 16:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1791562722;
 bh=0VEuCkepfw0j0fpwGzKQTzgKsuUR01NtSAMgXFBtfdA=;
 h=From:Date:Subject:To:Cc:Reply-To:From;
 b=bzTvJEnq3Uj82HhUobnP7QmkxtixPR/f9BroasSJ25bAjl/JUH77KukTgiR//6fEL
 /T/1LEZfYYYQ80XXvQkUSHuicmLFw/1hcZtJgfCmqN5YavSswK4ddXkqqbEvs9sjQV
 B3jkTaxVgsLvGH0DHo/kPTt7rEV2FR6O9vi+sSXUhLeSrjD2TGJ72rMNCrt2pbKAA0
 fkUj1T/MZavO/hAuDYyTTTAGEGTLr0ZBoID+ATMYFYApGQ5gZXL7NGHbxAqtCWOrEs
 +coA7NJsz8GvjIvUl8QkaLOzsIp2T+ICZy6BbZG4khcTTc0YFMkQVCsASxgabhZC+2
 yZ+dFHE5rkX5w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 86E9ECA601D;
 Fri,  9 Oct 2026 16:18:42 +0000 (UTC)
From: Arkadiusz Wadowski via B4 Relay
 <devnull+wadowski.arkadiusz.gmail.com@kernel.org>
Date: Fri, 09 Oct 2026 18:18:34 +0200
Subject: [PATCH] board: qemu-arm: Add SPL support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-spl-for-quemu-arm-v1-1-8ea39068f888@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMTQ6CMBBA4auQWTtJWwVTrmJYFBxkDL8zlpAQ7
 m7R5bd4bwclYVIosx2EVlaexgR7yaDpwvgi5GcyOOMKa4xHnXtsJ8El0hAxyIDuZp2/+zrk/gq
 pm4Va3n7PR/W3xvpNzeccwXF8ATsB3tp1AAAA
X-Change-ID: 20261009-spl-for-quemu-arm-2412979ba593
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, 
 Arkadiusz Wadowski <wadowski.arkadiusz@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791562720; l=4272;
 i=wadowski.arkadiusz@gmail.com; s=20261009; h=from:subject:message-id;
 bh=Faa0L6PATQopGf7/F0Ko6Anx3zgkNBnJrWZvNbNFVTo=;
 b=YkkH5QI2uLteg9BRKX2HSPjlwix1o6UQVI67ZzCvZ0OjtGy+mJpNcu7sy9BzFtSeOG2OlmDra
 mOmpbEi2N3pDYD+VmvDLK0Ad1vNrCLHfGgFxcC+bxmQPrXGQFe3p690
X-Developer-Key: i=wadowski.arkadiusz@gmail.com; a=ed25519;
 pk=HKeMLZz72hO1HTxmFN3fZohsVyICtXJ2xUrbSalR0wQ=
X-Endpoint-Received: by B4 Relay for wadowski.arkadiusz@gmail.com/20261009
 with auth_id=1144
X-Original-From: Arkadiusz Wadowski <wadowski.arkadiusz@gmail.com>
X-Mailman-Approved-At: Fri, 09 Oct 2026 18:14:35 +0000
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
 arch/arm/mach-qemu/Kconfig           |  1 +
 board/emulation/qemu-arm/Kconfig     |  4 ++++
 board/emulation/qemu-arm/Kconfig.spl | 43 ++++++++++++++++++++++++++++++++++++
 board/emulation/qemu-arm/qemu-arm.c  |  8 +++++++
 include/configs/qemu-arm.h           |  4 ++++
 5 files changed, 60 insertions(+)

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
index 447061b25cd..c6bfb82e7f3 100644
--- a/board/emulation/qemu-arm/Kconfig
+++ b/board/emulation/qemu-arm/Kconfig
@@ -1,3 +1,7 @@
+if TARGET_QEMU_ARM_64BIT && SPL
+source "board/emulation/qemu-arm/Kconfig.spl"
+endif
+
 if TARGET_QEMU_ARM_32BIT || TARGET_QEMU_ARM_64BIT
 
 config TEXT_BASE
diff --git a/board/emulation/qemu-arm/Kconfig.spl b/board/emulation/qemu-arm/Kconfig.spl
new file mode 100644
index 00000000000..38002a87b70
--- /dev/null
+++ b/board/emulation/qemu-arm/Kconfig.spl
@@ -0,0 +1,43 @@
+# SPDX-License-Identifier: GPL-2.0+
+
+config TEXT_BASE
+	range 0x41000000 0xffffffff
+	default 0x41000000
+
+config OF_OMIT_DTB
+	default n
+
+config DEFAULT_DEVICE_TREE
+	default "qemu-arm64"
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


