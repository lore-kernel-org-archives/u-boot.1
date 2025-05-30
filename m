Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9A71C5B552
	for <u-boot@archiver.kernel.org>; Fri, 30 May 2025 09:49:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA59783216;
	Fri, 30 May 2025 11:49:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="fzM455Y9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 999D183216; Fri, 30 May 2025 11:49:13 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BAB0C83214
 for <u-boot@lists.denx.de>; Fri, 30 May 2025 11:49:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziyao@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 8C4D6260FC;
 Fri, 30 May 2025 11:49:11 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id v-gaaD9dOcbv; Fri, 30 May 2025 11:49:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1748598550; bh=fE//qP1709NPtoPKFjRFp3E2fxFtVEbP58BphArrPbk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=fzM455Y9S4TdJpM6tKlcxCOS/ytgbOxvZdPf3QtZz8FNEY5/duipzRjLd60PFR9Ym
 pt94ptD3gltMGEzANPz5I5eNwvjW2gJ3mvYfLT+XQVAzFdvUqNGu8WW/l9nVFoRGXp
 cEICnGuvyFe+A/D9a1M/M7b2V5G8UMTB/JpGwTiuMHjrLAQGObli5KaIbGhNVhKxmI
 mDMSo6YuBUKM5fZc/d7rqJcsg34Fsxi9P3jnmUZoClO111Y7X1WBbHGHjURkI9aGxr
 UvZH88+sYMQAEPZ+2wIWaqof4ay0kDiV/wBQiG2Mw8CPJIlV9XQJI6LaihA3tSdLgD
 FtaC+9zE/0xpw==
From: Yao Zi <ziyao@disroot.org>
To: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>, Wei Fu <wefu@redhat.com>,
 Yixun Lan <dlan@gentoo.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Maksim Kiselev <bigunclemax@gmail.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Han Gao <rabenda.cn@gmail.com>,
 Han Gao <gaohan@iscas.ac.cn>, Yao Zi <ziyao@disroot.org>
Subject: [PATCH 1/5] riscv: cpu: th1520: Build spl.c for SPL only
Date: Fri, 30 May 2025 09:48:47 +0000
Message-ID: <20250530094851.57198-2-ziyao@disroot.org>
In-Reply-To: <20250530094851.57198-1-ziyao@disroot.org>
References: <20250530094851.57198-1-ziyao@disroot.org>
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

Symbols in spl.c only function correctly in SPL stage. Build the file
for SPL only to avoid weak symbols in proper U-Boot being unexpectedly
reloaded.

Fixes: 5fe9ced3552 ("riscv: cpu: Add TH1520 CPU support")
Signed-off-by: Yao Zi <ziyao@disroot.org>
---
 arch/riscv/cpu/th1520/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/cpu/th1520/Makefile b/arch/riscv/cpu/th1520/Makefile
index 5d806c06e2e..d971ea7390d 100644
--- a/arch/riscv/cpu/th1520/Makefile
+++ b/arch/riscv/cpu/th1520/Makefile
@@ -5,4 +5,4 @@
 obj-y += cache.o
 obj-y += cpu.o
 obj-y += dram.o
-obj-y += spl.o
+obj-$(CONFIG_SPL_BUILD) += spl.o
-- 
2.49.0

