Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65984E7717F
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 13:47:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0057E80137;
	Thu, 12 Dec 2024 14:47:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="H+dQxDZy";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="UkE4C8r8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F08D8018E; Thu, 12 Dec 2024 14:47:48 +0100 (CET)
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F41F08010E
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 14:47:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4Y8DLT506mz9tRR;
 Thu, 12 Dec 2024 14:47:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1734011265;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=G4fPl43AD90vyfin5cQ8ti+FHwXovPYz4/KEymIAQFU=;
 b=H+dQxDZy1yEtyq+OR7XgbreAMgE04iOjmpi8+vCoJB15zZSzGSA2RYK1uEi085nRD2rZfw
 wjvrESxuF4ohVwOBLdYpkjQ4HioF4wNFccdRs+Lajx9wXeuDIeWaG/tFqNmc11EU3Vt+Vn
 LUvAzhvFZpzZKbtpZq+sFKU+bWBjVNHrMrRqxVsxoMDfOpQ7f7C7pR8OIYR69mnO/74Ccy
 W9I6clidFs12o7o+TGcBdhx/yO+bJi+885poy/9o1r/MJyZJjFeva6EmmfljmtQMIBHLwm
 8V12GadCQ6ylmKeFntfrHiHzGdACiG3paECP6EkgRxEzmPiQta7ImNtmN5T6qg==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1734011263;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=G4fPl43AD90vyfin5cQ8ti+FHwXovPYz4/KEymIAQFU=;
 b=UkE4C8r8avR8sRPAsyvVr6jkfK1XES93B+UJQa2odxxI+8bnW1efACqxcKu+t9FOPnjKM3
 AQrYIz6ZcVgpsw05Tn0NmJYXFBV5NCsjeJJGIkK0jhCi8O+qAji0fhwt2fT8DW2B73jTHv
 lfmptgn5aeoOujxxn1u8ca6X2vcsWs27bOut8y//BhZE8NK5Yh3ret13Y8H21ZclEMy5XV
 e4CPqfkauGTaMbg/GTl+0axhF0YmTaTOcEajDn3zvOoC7K6T/D/ieuU0l6Y0b/8CVqwGIP
 xzCMjQ2wBtE8jgXULE/5idxRsUD/7Wqu69NMsnaclddfNpezxYehh08WjsLMGw==
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
Subject: [RFC][PATCH 1/3] arm64: Add late jump to kernel board hook
Date: Thu, 12 Dec 2024 14:47:17 +0100
Message-ID: <20241212134729.85391-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: digt59dy86ctf61abxo4ekmyh9tnb85d
X-MBO-RS-ID: 715c8ed7fee41562b58
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

Add empty weak assembler function armv8_switch_to_el2_prep() which is
jumped to just before U-Boot determines which EL it is running in and
decides which path to take to boot the Linux kernel.

This weak function is meant to be used by architecture specific code
to implement jump to a firmware blob, which then returns right past
this weak function and continues execution of U-Boot code which then
boots the Linux kernel. One example of such use case is when U-Boot
jump tp TFA BL31, which switches from EL3 to EL2 and then returns to
U-Boot code newly running in EL2 and starts the Linux kernel.

The weak function is called with caches already disabled and DM shut
down. Any preparatory work or even loading of more data must be done
in board_prep_linux(), this hook is meant only for the final jump to
the firmware and return to U-Boot before booting Linux.

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
 arch/arm/cpu/armv8/transition.S |  8 ++++++++
 arch/arm/include/asm/system.h   | 16 ++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/arch/arm/cpu/armv8/transition.S b/arch/arm/cpu/armv8/transition.S
index 9dbdff3a4fc..85f13ccd0d2 100644
--- a/arch/arm/cpu/armv8/transition.S
+++ b/arch/arm/cpu/armv8/transition.S
@@ -9,8 +9,16 @@
 #include <linux/linkage.h>
 #include <asm/macro.h>
 
+.pushsection .text.armv8_switch_to_el2_prep, "ax"
+WEAK(armv8_switch_to_el2_prep)
+	ret
+ENDPROC(armv8_switch_to_el2_prep)
+.popsection
+
 .pushsection .text.armv8_switch_to_el2, "ax"
 ENTRY(armv8_switch_to_el2)
+	bl	armv8_switch_to_el2_prep
+	nop
 	switch_el x6, 1f, 0f, 0f
 0:
 	cmp x5, #ES_TO_AARCH64
diff --git a/arch/arm/include/asm/system.h b/arch/arm/include/asm/system.h
index dbf9ab43e28..091082281c7 100644
--- a/arch/arm/include/asm/system.h
+++ b/arch/arm/include/asm/system.h
@@ -238,6 +238,22 @@ int __asm_flush_l3_dcache(void);
 int __asm_invalidate_l3_icache(void);
 void __asm_switch_ttbr(u64 new_ttbr);
 
+/*
+ * armv8_switch_to_el2_prep() - prepare for switch from EL3 to EL2 for ARMv8
+ *
+ * @args:        For loading 64-bit OS, fdt address.
+ *               For loading 32-bit OS, zero.
+ * @mach_nr:     For loading 64-bit OS, zero.
+ *               For loading 32-bit OS, machine nr
+ * @fdt_addr:    For loading 64-bit OS, zero.
+ *               For loading 32-bit OS, fdt address.
+ * @arg4:	 Input argument.
+ * @entry_point: kernel entry point
+ * @es_flag:     execution state flag, ES_TO_AARCH64 or ES_TO_AARCH32
+ */
+void armv8_switch_to_el2_prep(u64 args, u64 mach_nr, u64 fdt_addr,
+			      u64 arg4, u64 entry_point, u64 es_flag);
+
 /*
  * armv8_switch_to_el2() - switch from EL3 to EL2 for ARMv8
  *
-- 
2.45.2

