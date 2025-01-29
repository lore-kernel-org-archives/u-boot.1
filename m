Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E677C0218D
	for <u-boot@archiver.kernel.org>; Wed, 29 Jan 2025 22:00:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8147080AE4;
	Wed, 29 Jan 2025 23:00:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="sGvAd0wB";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Vvom2qDk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8234A80BA8; Wed, 29 Jan 2025 23:00:33 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org
 [IPv6:2001:67c:2050:0:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6ADDA80A46
 for <u-boot@lists.denx.de>; Wed, 29 Jan 2025 23:00:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4Yjx0v0X93z9spH;
 Wed, 29 Jan 2025 23:00:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1738188031;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=7TW1IpLOlN1d1zKw1JjByov2Yo8XzKUpv1pVANIgxHE=;
 b=sGvAd0wBTglkCTMg0owGxDYQiJAyHZIVA+y3HuUvUw6Y1rqSS9poaUHdJ76J5tvtPoMdFm
 PJvOedKkrYxwRVi0jav+4i6zZDXR770SiFm+oJZNjPEzgDXvNbXLsTBl3Pz2vnhLe1bnPq
 v9Q6rXoKSL+RuRno2ukGtDY5ee0KmuWhkUgpjJGXX4+0orgNCsPRKc9TZGY/qA/H78Sejk
 QRjA1aPyEF0TjIA22xkMPuYqbgT190AdpeubcEVL6v/YFuiPxakqmWnRUh2NeCwo1sduTQ
 y2bBuPcrM9IU+xzRZYoSu5pBdzl/3JhdqIBCbYpaQ1Cd9MPwr/+ffUawbWwBuw==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1738188029;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=7TW1IpLOlN1d1zKw1JjByov2Yo8XzKUpv1pVANIgxHE=;
 b=Vvom2qDkL26O19Vt+N+H3nIa0lZZkMmbt7puGU9pMW1vG4NagLZArSdAnF0mRCtp9wal/A
 VTKw7C6vxsZFzTaigjjFMyS+Uw5CG+rMSqbWILxbrGLOjeMecf/aoTLch/B/rl8w7syE5+
 0q1fKjAIzlYFqLm1CV1QfdIHSHxZUsw1e/bwxo9cUt1AlvoI12TyBwAUus8GvyuMKrAqQu
 5igwEqJdx5Zkt1/SxN0/UzXZTb20D40ZcVeSjawAj9JOxUThPvX2BHSkfVtgQTqxdMsFB2
 SsyuNcM0DqN5tOlkQtx8xtJuWRDTmc7pYa6cxplwxH82vrFX9OtQK9gBJmKUSg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tom Rini <trini@konsulko.com>, Andre Przywara <andre.przywara@arm.com>,
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
 Quentin Schulz <quentin.schulz@cherry.de>,
 Peter Hoyes <Peter.Hoyes@arm.com>, Raymond Mao <raymond.mao@linaro.org>,
 Sam Protsenko <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v2 1/3] arm64: Add late jump to kernel board hook
Date: Wed, 29 Jan 2025 22:59:18 +0100
Message-ID: <20250129220010.264635-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: j4fkf6cmemphuxpkewcxgf7spt7t1bwc
X-MBO-RS-ID: 2066deaf24fd2a8cb63
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

Reviewed-by: Tom Rini <trini@konsulko.com>
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
Cc: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Peter Hoyes <Peter.Hoyes@arm.com>
Cc: Raymond Mao <raymond.mao@linaro.org>
Cc: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Simon Glass <sjg@chromium.org>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
V2: Add RB from Tom
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

