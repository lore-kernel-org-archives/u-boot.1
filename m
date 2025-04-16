Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C51EFC369BA
	for <u-boot@archiver.kernel.org>; Wed, 16 Apr 2025 16:26:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A06A382ED4;
	Wed, 16 Apr 2025 18:25:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="h6stTfFv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56DFA82F10; Wed, 16 Apr 2025 18:25:57 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6FFEA82EAA
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 18:25:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziyao@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 34F9A25D27;
 Wed, 16 Apr 2025 18:25:55 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DoM-69WoIkiB; Wed, 16 Apr 2025 18:25:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1744820754; bh=9LIKZmaTEfMOPDI0VssnDOqiAmhzw93K7hQp+T8VYCs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=h6stTfFv2Kluhbd8p4RC4qWlLdfzcxtIQRdFlMoeJCqnNNfmqVvnDHwy0M5knwvI8
 sTcvJSKS3NioiqcB7c8gWllt6TEnZpoTn2dMezz/kp73dQNRwCIObWJzhiwYRITfyJ
 ucaqEYieNAX6ZGxQOOFl4IEqj9imLLm4RykRaFVZ3TKgnsUcZQSvdM5ujmQpaQBcRL
 L3UwrR2K+4uwEGT+Irki/mQoTEm70+o8DkXmS23sv+TbYmlfBkX5K5Gu3VwYC/UrMn
 SsSN2JYXOVJEjjLMlha4oFTvCq5SLbBh/ySUTGgrA9+VjDk/Ba14QbqHmdj1CL+wXF
 FiBPreAFW85fw==
From: Yao Zi <ziyao@disroot.org>
To: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>, Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, Simon Glass <sjg@chromium.org>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, E Shattow <e@freeshell.de>,
 Yu-Chien Peter Lin <peter.lin@sifive.com>,
 Sumit Garg <sumit.garg@kernel.org>, Bin Meng <bmeng.cn@gmail.com>
Cc: u-boot@lists.denx.de, Yao Zi <ziyao@disroot.org>,
 Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 1/3] riscv: dts: binman.dtsi: Switch to u-boot-nodtb entry
 for proper U-Boot
Date: Wed, 16 Apr 2025 16:25:31 +0000
Message-ID: <20250416162533.1396-2-ziyao@disroot.org>
In-Reply-To: <20250416162533.1396-1-ziyao@disroot.org>
References: <20250416162533.1396-1-ziyao@disroot.org>
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

Switch to u-boot-nodtb entry which precisely represents a proper U-Boot
and could be matched with u_boot_any. This allows RISC-V ports that make
use of binman to be built without disabling SPL_BINMAN_UBOOT_SYMBOLS
explicitly, which is set to y by default.

Fixes: 0784510f741 ("riscv: sifive: unleashed: Switch to use binman to generate u-boot.itb")
Suggested-by: Jonas Karlman <jonas@kwiboo.se>
Signed-off-by: Yao Zi <ziyao@disroot.org>
---
 arch/riscv/dts/binman.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/dts/binman.dtsi b/arch/riscv/dts/binman.dtsi
index 0405faca574..b7656423b69 100644
--- a/arch/riscv/dts/binman.dtsi
+++ b/arch/riscv/dts/binman.dtsi
@@ -35,7 +35,7 @@
 					compression = "none";
 					load = /bits/ 64 <CONFIG_TEXT_BASE>;
 
-					uboot_blob: blob-ext {
+					uboot_blob: u-boot-nodtb {
 						filename = "u-boot-nodtb.bin";
 					};
 				};
-- 
2.49.0

