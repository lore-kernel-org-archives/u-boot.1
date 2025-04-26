Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06DA3C369CB
	for <u-boot@archiver.kernel.org>; Sat, 26 Apr 2025 17:26:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B18881E0F;
	Sat, 26 Apr 2025 19:26:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="ca2qj/VF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D214881E14; Sat, 26 Apr 2025 19:26:49 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC2C8810EB
 for <u-boot@lists.denx.de>; Sat, 26 Apr 2025 19:26:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziyao@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 93B5525C66;
 Sat, 26 Apr 2025 19:26:47 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NSC4KZWbwjPi; Sat, 26 Apr 2025 19:26:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1745688406; bh=yxcykSKVvdt/dhQS/DL+Pkgz3+6esJo6Ep0TrfX0n4M=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=ca2qj/VF2HCNeKHJW2YA9jNECj8319hjAoe9OCFhUlR3gYJ+agyLeYZgMnTgy737P
 BW+S9K4Cz2dMrSvKLmn0z62kWipWfipve71EI9MzoWTUfqSm69/qyJN8PaLHTxUYzS
 hKiPrp5iZ/PVCiLI8H7Igd2HEtOLzjasbdjMNkbZ05dKe0Tna2mIwICoDBSOx3pdF3
 qRE3alHU6ZHwW5/YS0ri8vicWHoNyLqTi0ILh/Ozuge1Sy05UrbM4PLk8tC4bXdkqq
 YPBiGCY3lxUH5XukDCvs8nNrL6PbhTCb/A2E68VMsglG6erRvNZy90sg43S5TBieJs
 Vr1KZhILFV4xw==
From: Yao Zi <ziyao@disroot.org>
To: Leo <ycliang@andestech.com>,
	Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 Yao Zi <ziyao@disroot.org>
Subject: [PATCH] riscv: dts: binman.dtsi: Drop filename property for proper
 U-Boot
Date: Sat, 26 Apr 2025 17:26:02 +0000
Message-ID: <20250426172601.36427-2-ziyao@disroot.org>
In-Reply-To: <20250426141424.GX5495@bill-the-cat>
References: <20250426141424.GX5495@bill-the-cat>
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

Drop filename property for proper U-Boot entry since binman takes
"u-boot-nodtb.bin" as the default filename for u-boot-nodtb entries.

This follows efe9c12322b ("riscv: dts: binman.dtsi: Switch to
u-boot-nodtb entry for proper U-Boot") to clean binman.dtsi up.

Signed-off-by: Yao Zi <ziyao@disroot.org>
---

Here's the clean up patch, thank you Leo and Tom!

 arch/riscv/dts/binman.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/riscv/dts/binman.dtsi b/arch/riscv/dts/binman.dtsi
index 5aeeeddb59f..b518560bb94 100644
--- a/arch/riscv/dts/binman.dtsi
+++ b/arch/riscv/dts/binman.dtsi
@@ -36,7 +36,6 @@
 					load = /bits/ 64 <CONFIG_TEXT_BASE>;
 
 					uboot_blob: u-boot-nodtb {
-						filename = "u-boot-nodtb.bin";
 					};
 				};
 #else
-- 
2.49.0

