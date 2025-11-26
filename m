Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09A26D10F2D
	for <u-boot@archiver.kernel.org>; Wed, 26 Nov 2025 12:19:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B4428841D2;
	Wed, 26 Nov 2025 13:17:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=postmarketos.org header.i=@postmarketos.org header.b="ZzkumIll";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF7FB84207; Wed, 26 Nov 2025 13:17:44 +0100 (CET)
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com
 [91.218.175.183])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B668841E7
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 13:17:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=postmarketos.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=funderscore@postmarketos.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
 s=key1; t=1764159462;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wQwhZhK5VNVUAT3YA3ruS5BRmlDtEzZ8opLk8q/+5tU=;
 b=ZzkumIll5M7158H3GvDB87gRBiOKvHj/RxJQyrnVECpXj0LrB52Sge6FHpCLZvZRGsKRmY
 anydmYfxxNI5iG44AKgxSTwV8N2cSAzW++8lcV5XetxmARfUP0JeiQpemjdSC4EiRrnPjI
 koayQ3oWniHeZdqteosKxwC4dv3QLJ5BeXDAOdJMkwE3R3rLyY0StbAbUCqdeIBW2QtU2T
 awQ3zy9z75UMv/OsHl0ILaGXJOIMXIA6bdNuiJ52fCBjLSWYHYigCz75CWi8Cc0LTd54aT
 5Iaaj6Q1X7CJROZw1lSx2oq87tiN2wKhnUaF5wLhQqkBpfE0nBh312fr9CVOeQ==
From: Ferass El Hafidi <funderscore@postmarketos.org>
Date: Wed, 26 Nov 2025 12:17:11 +0000
Subject: [PATCH v5 09/10] spl: meson: set SPL max size for GX SoCs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251126-spl-gx-v5-9-6cbffb2451ca@postmarketos.org>
References: <20251126-spl-gx-v5-0-6cbffb2451ca@postmarketos.org>
In-Reply-To: <20251126-spl-gx-v5-0-6cbffb2451ca@postmarketos.org>
To: Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Beniamino Galvani <b.galvani@gmail.com>
Cc: Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>, 
 u-boot@lists.denx.de, u-boot-amlogic@groups.io, 
 ~postmarketos/upstreaming@lists.sr.ht, 
 Ferass El Hafidi <funderscore@postmarketos.org>
X-Developer-Signature: v=1; a=openpgp-sha256; l=757;
 i=funderscore@postmarketos.org; h=from:subject:message-id;
 bh=PDzH7SB/kKCbCMBeXt+SecbBFG+OI5/EuyEnYYNJiKk=;
 b=owEBbQKS/ZANAwAKAYSvy9DXiZoDAcsmYgBpJu/ZXzMplCa6iEIRVvL7IJBxvURSC72hOuFrN
 +yAu+X1BCKJAjMEAAEKAB0WIQQDAbw3+1VcrP15i+6Er8vQ14maAwUCaSbv2QAKCRCEr8vQ14ma
 A3aAD/9g024T93zEChuL3AQCQI6DHh3SKP1rIxQma3aKAuc5eUCK20FrU8JQ48CHRIkcniXnVHF
 V++YZ9PNVL/JAM4Nzhr3UVUdWHwUXBFzU9WbHHnAVLm1cQ7zZQlNSM5N8Fur2e3sh1UBhgbEUvW
 vvdecsHtJ6TNnWMjoiVwyEu8BhJ+PWtK8m0/FQiINutoxwgbLpyImzk3LAoltnxqkbYvYusi9p2
 Rrbqci8XlC/DnlRHJSvagKsgiMv0WL4XCkMAMGuNVSRn/ioCxIN+c3oQN6OjZETMRW0+U/3Q5VY
 TaJt6eFQ4hYb9tW/oXsO+DRqlgICHoZRpIR/LittLkayoy1FZiTiahNHqi10Pi2KCZnlW2PUJmj
 tJprviCLG0ozU7FokxK15pKay/LAjqYQ7hqBEdTbGt8EZkv2wqtyR3XOV5p1VyTqVKU717YRtDJ
 HeH6320qasPR29dPeqem4SxeYI2gVztL1s1cLamsPk8CLXhRvHb66m2FLCwd4UjU7pYDBVCg/zb
 ftY5Hi0iBn+gHDLpZBUHm54u6T8o9yFSnNvRRarPieD6pLGL5+e5LiZ48RC0H2yNXdvOGggkmlT
 VGZhU6XFAQlPVFdG/rg2zr38f/rlbH3hhyMowBXXDaA82JCcawUzLUIwe7ju8Ug+nDJk/yDPdRR
 T0x59fB6ABguc+A==
X-Developer-Key: i=funderscore@postmarketos.org; a=openpgp;
 fpr=0301BC37FB555CACFD798BEE84AFCBD0D7899A03
X-Migadu-Flow: FLOW_OUT
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

Enforce the max size for U-Boot SPL at the Kconfig level, to prevent the
build system from producing an image too large for the bootROM to load.

Signed-off-by: Ferass El Hafidi <funderscore@postmarketos.org>
---
 common/spl/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index f34b96efc02..bc233fa2ed9 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -41,6 +41,7 @@ config SPL_SIZE_LIMIT
 	default 0x11000 if ARCH_MX6 && !MX6_OCRAM_256KB
 	default 0x31000 if ARCH_MX6 && MX6_OCRAM_256KB
 	default 0x30000 if ARCH_MVEBU && ARMADA_32BIT
+	default 0xb000 if ARCH_MESON && MESON_GX
 	default 0x0
 	help
 	  Specifies the maximum length of the U-Boot SPL image.

-- 
2.51.2

