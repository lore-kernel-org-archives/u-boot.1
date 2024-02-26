Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D2BBC48BF6
	for <u-boot@archiver.kernel.org>; Mon, 26 Feb 2024 21:24:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8835687F8A;
	Mon, 26 Feb 2024 22:24:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="fRyrUJDK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5F7C887FB2; Mon, 26 Feb 2024 22:24:12 +0100 (CET)
Received: from smtp-relay-canonical-1.canonical.com
 (smtp-relay-canonical-1.canonical.com [185.125.188.121])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E364687F74
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 22:24:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from LT2ubnt.. (dynamic-046-114-105-150.46.114.pool.telefonica.de
 [46.114.105.150])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id B78B940ED6; 
 Mon, 26 Feb 2024 21:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1708982645;
 bh=aKH8sBe2NYkwVF5UXutJbpmQLwsDXUrqWE8/NV6Do7Y=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
 MIME-Version;
 b=fRyrUJDKJB5F4wPgCON6sQSPvIgwjBArUn0ANAaiXO4x2g5DaHsO1gkH0+/Fgn4R5
 dQRZdWlgQxUuL8qtL2T7aAsxjovvEEd7hKB2EdEkQPtbXe+/6cmpQinqLfUOMSdCxw
 YvfSrZe5HO59zmDTzupXsMf9O60/m3tDUvRTSZACCoWHb6LeaY760etR15PSX4vlBM
 23Q/70hjfh6c1ztHVWqO6JLecAZn2LpAbBmFKTYZlmLAec19sjdjJucKlF7Bej5SP8
 XnVEp+p2zx0Lc/KBkErTomnLYgKXgZVOHAwtKVseMcwyhpa1FFVghB2+YwR7uGvCuX
 S8G3+q26nkkeA==
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: [PATCH v2 1/2] arm: page align EFI binary section
Date: Mon, 26 Feb 2024 22:24:07 +0100
Message-ID: <20240226212408.7535-2-heinrich.schuchardt@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240226212408.7535-1-heinrich.schuchardt@canonical.com>
References: <20240226212408.7535-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Change the alignment of the relocation code in EFI binaries to match page
boundaries.

Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
v2:
	new patch
---
 arch/arm/lib/crt0_arm_efi.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/lib/crt0_arm_efi.S b/arch/arm/lib/crt0_arm_efi.S
index 75ee37b7d3..7a4e5dff75 100644
--- a/arch/arm/lib/crt0_arm_efi.S
+++ b/arch/arm/lib/crt0_arm_efi.S
@@ -115,14 +115,14 @@ section_table:
 	.short	0		/* NumberOfLineNumbers  (0 for executables) */
 	.long	0xe0500020	/* Characteristics (section flags) */
 
-	.align		9
+	.align		12
 _start:
 	stmfd		sp!, {r0-r2, lr}
 
 	adr		r1, .L_DYNAMIC
 	ldr		r0, [r1]
 	add		r1, r0, r1
-	adr		r0, image_base
+	adrl		r0, image_base
 	bl		_relocate
 	teq		r0, #0
 	bne		0f
-- 
2.43.0

