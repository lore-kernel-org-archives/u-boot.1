Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09C97E7718B
	for <u-boot@archiver.kernel.org>; Wed,  1 Jan 2025 19:20:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F313980352;
	Wed,  1 Jan 2025 20:19:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="MviqEXaa";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="tJaAv2fz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A10C4803AC; Wed,  1 Jan 2025 20:19:50 +0100 (CET)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A77ED8031D
 for <u-boot@lists.denx.de>; Wed,  1 Jan 2025 20:19:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4YNfmN2RF1z9sxM;
 Wed,  1 Jan 2025 20:19:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1735759188;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N+ice3bbnt8GiQB5I9+EC6utf36hrBmSwY+q9D7POKU=;
 b=MviqEXaazmQ4/2KHVCTNLrCVmmsTMqu0AWEfEL/9Xrd2pscsOjKIMzjZY03vGztvQ8Kai+
 54AlLyQpzQ8wJPpLUSsoLSaOLuziEkBf8rBgUmJwMcvEwGnbAWeK2KERPjGI6sXTlohyib
 5ZJx4pMqoY6hIaPfYzg9D3Uu5cwc0I4U+Y8lOfHuBAJifVoLxIMWxT9nxn2AZZSo9gRlXa
 g5oQXLDresWgKS80WrPcUgqU5Z2kBA5UmR2ZElIHP3yjyajmKPjMd6CMsWNU+HQRmCuKr+
 XWw+g7fUsj8so7tli++4dBdR4oXQb61VE9E5bWmPin3ttiHPc9Iy3kcGLTTyYQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1735759186;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N+ice3bbnt8GiQB5I9+EC6utf36hrBmSwY+q9D7POKU=;
 b=tJaAv2fzm6QIU2EwWHAWLSvZkv2gin152nQgHeW6aLA0TlM3IkAw39xZTAikNsJ6AgL9b6
 C5jOi98Vl7TWtuJC2L3k4KaXk0a4PgAyJ3U8y4SKeJArOMQNGZmqeT7SKp920Itog/6vN8
 Mfk1nX1I5cgIv5kMi7Vxt5GKHCZVMhxRYWQP2PTUPEiDHbOGmB/EwYAtiLePyrIDrKU/qT
 TX0vlj27KALG0nLxz1XGhKjN6q0CjFktN5SnfSFeFqDaF3V44uXD8qg+98A9DWRWcB6BIW
 CvzNwsDK7d3AYj7exvgu5CJaOoNB23iTS/tPYyWtuZ3FInPnBTKYBaLaqQXV+g==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Peter Robinson <pbrobinson@gmail.com>,
 Biju Das <biju.das.jz@bp.renesas.com>,
 Chris Paterson <chris.paterson2@renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 2/3] arm64: Add MIDR entries for Cortex-A57 and Cortex-A76
Date: Wed,  1 Jan 2025 20:19:05 +0100
Message-ID: <20250101191920.25317-2-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20250101191920.25317-1-marek.vasut+renesas@mailbox.org>
References: <20250101191920.25317-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 1db311d36b15d0c4006
X-MBO-RS-META: tcjasfp5oe3f5nwckp7zzp3ycef1ueyu
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

Add MIDR entries for Cortex-A57 and Cortex-A76 cores.
Those are used on R-Car Gen3 and Gen4 SoCs respectively.

Reviewed-by: Paul Barker <paul.barker.ct@bp.renesas.com>
Reviewed-by: Peter Robinson <pbrobinson@gmail.com>
Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Chris Paterson <chris.paterson2@renesas.com>
Cc: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
V2: - Rebase on u-boot/next
    - Add RB from Paul and Peter
---
 arch/arm/include/asm/armv8/cpu.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/include/asm/armv8/cpu.h b/arch/arm/include/asm/armv8/cpu.h
index aa1470bb72d..4dbb589aab8 100644
--- a/arch/arm/include/asm/armv8/cpu.h
+++ b/arch/arm/include/asm/armv8/cpu.h
@@ -5,7 +5,9 @@
 
 #define MIDR_PARTNUM_CORTEX_A35		0xD04
 #define MIDR_PARTNUM_CORTEX_A53		0xD03
+#define MIDR_PARTNUM_CORTEX_A57		0xD07
 #define MIDR_PARTNUM_CORTEX_A72		0xD08
+#define MIDR_PARTNUM_CORTEX_A76		0xD0B
 #define MIDR_PARTNUM_SHIFT		0x4
 #define MIDR_PARTNUM_MASK		(0xFFF << MIDR_PARTNUM_SHIFT)
 
@@ -29,4 +31,6 @@ static inline unsigned int read_midr(void)
 
 is_cortex_a(35)
 is_cortex_a(53)
+is_cortex_a(57)
 is_cortex_a(72)
+is_cortex_a(76)
-- 
2.45.2

