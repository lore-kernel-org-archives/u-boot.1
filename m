Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F64AC369BA
	for <u-boot@archiver.kernel.org>; Wed, 16 Apr 2025 16:26:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E474482EAA;
	Wed, 16 Apr 2025 18:26:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="iWiaEkjB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AFC9D82F30; Wed, 16 Apr 2025 18:26:04 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F137782F6F
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 18:26:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziyao@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id B23A4204DA;
 Wed, 16 Apr 2025 18:26:01 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Kc6YFaBtAMKW; Wed, 16 Apr 2025 18:26:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1744820761; bh=iL08rXOj+0RAsj6hYSKqFr7NESZE3ymQ9CtisYUC/zM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=iWiaEkjBJBeokwjOjKYe7ZoD1gDLep72xjhpk7Gbg5NaJv59qkwixqZfoEZGpevL4
 tc1DftD5byeqvFxRHiiqfn60+DLJS1mOuu8S6sS7DrXR89zyIms+bE6dZokunT8P79
 dIOHDQs+nX11DXnW7SbhyIC03XZn9ilUwNh6Hob12b8QVoyC5qT/nMTDBmbrvxEeQh
 +gc3ap0mFYrKBK2nl5frGoB5GS1Y8ZTNyKYMGQeSe7qd5GqRbQqTai2AC78Cp0ssTU
 SKAieB1exyhf7aZxSHRWKfu0+kWndPKPpy/Ygmmk4OalaKFd1tEuUnrV4z8N+LKcrp
 k9fk49myfpcHA==
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
Subject: [PATCH v2 2/3] riscv: dts: starfive: Prevent binman from relocating
 symbols in SPL
Date: Wed, 16 Apr 2025 16:25:32 +0000
Message-ID: <20250416162533.1396-3-ziyao@disroot.org>
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

SPL and proper U-Boot are split into two images with default binman
configuration of StarFive VisionFive 2, thus proper U-Boot symbols
cannot be found in the SPL image. This fixes errors like

  Section '/binman/spl-img': Symbol '_binman_u_boot_any_prop_size'
    in entry '/binman/spl-img/mkimage/u-boot-spl/u-boot-spl-nodtb':
      Entry 'u-boot-any' not found in list (u-boot-spl-nodtb,
      u-boot-spl-dtb,u-boot-spl,mkimage,spl-img)

Fixes: 90602e779d3 ("riscv: dts: starfive: generate u-boot-spl.bin.normal.out")
Suggested-by: Jonas Karlman <jonas@kwiboo.se>
Signed-off-by: Yao Zi <ziyao@disroot.org>
---
 arch/riscv/dts/starfive-visionfive2-binman.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/dts/starfive-visionfive2-binman.dtsi b/arch/riscv/dts/starfive-visionfive2-binman.dtsi
index 4cce001e80d..10e3d964588 100644
--- a/arch/riscv/dts/starfive-visionfive2-binman.dtsi
+++ b/arch/riscv/dts/starfive-visionfive2-binman.dtsi
@@ -96,6 +96,7 @@
 			args = "-T sfspl";
 
 			u-boot-spl {
+				no-write-symbols;
 			};
 		};
 	};
-- 
2.49.0

