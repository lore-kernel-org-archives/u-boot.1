Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24189C369D1
	for <u-boot@archiver.kernel.org>; Sun, 27 Apr 2025 14:52:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 774588209C;
	Sun, 27 Apr 2025 16:52:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="NNyrv1KG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 146FB80FDA; Sun, 27 Apr 2025 16:52:10 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 279CB81FDE
 for <u-boot@lists.denx.de>; Sun, 27 Apr 2025 16:52:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziyao@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id D766425DA1;
 Sun, 27 Apr 2025 16:52:07 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lWpV5qAjwaJ8; Sun, 27 Apr 2025 16:52:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1745765527; bh=mH3iPTLjaKg4i6r+U7cSMQBzGktdlBVlNwo78zDhLJM=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=NNyrv1KGJ6iVP8ZfT6Jhg5Lsri7/KL9Jetuf0IWdz/RWVxZSQvAizwEdSTXTQRYD3
 gOyprknauCukum2SPKdBtHFMjPFpzDqG3Aexs2sFzghX9mtJPiALOZuImVk7N+3Zts
 1hhBOMJICJTf76MdEa84NduBBSx2kYPK/5X5ACoRKh+takH8Pd5jVvr6ePt6TbbASg
 0LWQGaMLTR+zQY/8ElBI3h0zuFwqGUTSGIyhKBauvkDWgHiKqUe1vnBzy3Gqd9W7J1
 RmARrxuKkpqiGY+pN3eY6Kh5ieG4iNf9IHG/m0g7xQ95ldpeC0YOoD6rX4U+Lq8y4/
 deh/aCTs/MZWw==
From: Yao Zi <ziyao@disroot.org>
To: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Anton Blanchard <antonb@tenstorrent.com>, Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Christian Marangi <ansuelsmth@gmail.com>, Andrew Davis <afd@ti.com>,
 Nishanth Menon <nm@ti.com>
Cc: u-boot@lists.denx.de, Nathaniel Hourt <I@nathaniel.land>,
 Yao Zi <ziyao@disroot.org>
Subject: [PATCH 1/2] Makefile: Strip leading spaces when preprocessing
 generated_defconfig
Date: Sun, 27 Apr 2025 14:50:10 +0000
Message-ID: <20250427145011.17331-2-ziyao@disroot.org>
In-Reply-To: <20250427145011.17331-1-ziyao@disroot.org>
References: <20250427145011.17331-1-ziyao@disroot.org>
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

Clang's preprocessor may emit extra spaces for lines starting with '#'.
Lines with these extra characters cannot be handled by Kconfig and will
be ignored with warnings like,

        unexpected data:  # CONFIG_OF_BOARD_FIXUP is not set

Those options that is expected to be assigned explicitly with N will be
set to the default value, messing up board configurations.

Let's sed these spaces away to ensure board configurations could be
correctly generated with Clang.

Fixes: 2027e99e61a ("Makefile: Run defconfig files through the C preprocessor")
Reported-by: Nathaniel Hourt <I@nathaniel.land>
Signed-off-by: Yao Zi <ziyao@disroot.org>
---
 scripts/kconfig/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/kconfig/Makefile b/scripts/kconfig/Makefile
index 079add4d5da..ba30652f01a 100644
--- a/scripts/kconfig/Makefile
+++ b/scripts/kconfig/Makefile
@@ -94,6 +94,7 @@ endif
 
 %_defconfig: $(obj)/conf
 	$(Q)$(CPP) -nostdinc -P -I $(srctree) -undef -x assembler-with-cpp $(srctree)/arch/$(SRCARCH)/configs/$@ -o generated_defconfig
+	$(Q)sed -i -e 's/^[[:space:]]//' generated_defconfig
 	$(Q)$< $(silent) --defconfig=generated_defconfig $(Kconfig)
 
 # Added for U-Boot (backward compatibility)
-- 
2.49.0

