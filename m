Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5073CE7D12
	for <u-boot@archiver.kernel.org>; Tue,  1 Oct 2024 12:07:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6088189062;
	Tue,  1 Oct 2024 14:07:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=thorsis.com header.i=@thorsis.com header.b="EmhZgOWI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 05DFD890EE; Tue,  1 Oct 2024 14:07:43 +0200 (CEST)
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 189BA88FC7
 for <u-boot@lists.denx.de>; Tue,  1 Oct 2024 14:07:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=thorsis.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ada@thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 9812A1486A23; Tue,  1 Oct 2024 14:07:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
 t=1727784460; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=d0h3NmmBYdGZWyTFM7gG/EO9mEtfiMQ5ruiid1yrz9g=;
 b=EmhZgOWI0Bolp9s1vToXCGioYPJTTHyP8ronBzGkl7iObVqIwUM6Yxwb3+j1+QPrnGzeWx
 O7D3vxU5nVrzkXk6M3TpniJYtNON9IQnhtX/CEWushIe9dReu5XH8knFj97z+cnRnLvWsn
 ZPnwkYlOhjacMmCpM5Fcdkk06+JdxY1UMl30EHrw7cCcWNrDtcx2t6f/O5zwWvylx7gf2O
 CASSREA+FNhRHsL6wfOtVLtf3Ns2gRmj5oPr34yNYJlll4b2tYHHZ/IFH940bauE4x0DKZ
 8I0YWWNA6fwGxtzkO6I5lmKKPheEJg0OeJegN60lkDG6GoZxwq5vX3xab+LtBw==
From: Alexander Dahl <ada@thorsis.com>
To: Eugen Hristev <eugen.hristev@collabora.com>
Cc: Tom Rini <trini@konsulko.com>,
 =?UTF-8?q?Andreas=20Bie=C3=9Fmann?= <andreas.devel@googlemail.com>,
 Bo Shen <voice.shen@atmel.com>, u-boot@lists.denx.de (open list)
Subject: [PATCH] ARM: at91: clock: Add missing include of asm/io.h
Date: Tue,  1 Oct 2024 14:07:33 +0200
Message-Id: <20241001120733.675579-1-ada@thorsis.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

In one inline function in this header `readl()` is used, but the
declaration was not found, so buildman gave this warning:

    w+include/asm/arch/clk.h: In function 'get_h32mxdiv':
    w+include/asm/arch/clk.h:65:16: warning: implicit declaration of function 'readl' [-Wimplicit-function-declaration]

Fixes: 927b901b47a6 ("ARM: atmel: add sama5d4ek board support")
Signed-off-by: Alexander Dahl <ada@thorsis.com>
---

Notes:
    based on next

 arch/arm/mach-at91/include/mach/clk.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-at91/include/mach/clk.h b/arch/arm/mach-at91/include/mach/clk.h
index c1d92739e47..09b8f0586c6 100644
--- a/arch/arm/mach-at91/include/mach/clk.h
+++ b/arch/arm/mach-at91/include/mach/clk.h
@@ -11,6 +11,7 @@
 #include <asm/arch/hardware.h>
 #include <asm/arch/at91_pmc.h>
 #include <asm/global_data.h>
+#include <asm/io.h>
 
 #define GCK_CSS_SLOW_CLK	0
 #define GCK_CSS_MAIN_CLK	1

base-commit: 3a0b829efc35227b1079a444f00e0729502197ad
-- 
2.39.5

