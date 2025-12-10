Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72DF9D3E77D
	for <u-boot@archiver.kernel.org>; Wed, 10 Dec 2025 22:28:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 562A283C94;
	Wed, 10 Dec 2025 23:28:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TtcDtZYP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43D5D83CAA; Wed, 10 Dec 2025 21:11:28 +0100 (CET)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF7908042F
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 21:11:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alchark@gmail.com
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-598eaafa587so144259e87.3
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 12:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765397485; x=1766002285; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=WsKn1G1/4srsIWi/wK//e1V/3kE4yxRSmtOx1lC41pE=;
 b=TtcDtZYPkV9DKb+KtDTKQ+bSfFFpv+oQBZISggpJdRumV/GSPaQGM/Ge5KdamGw/o5
 +PGk2xjdaPt9nHV3xZI6vAPtnQ9s8LIA7FjoxUBGF3kELIhBJUsegvedhRU1TLkChPST
 I5MrU23hzRhsujys7y/epmPkLHwbx3yqzBwlfOHnaneCt5m9XXKOLGs+fSreWOUt4u6L
 pw7CcauGLZ8nUOxMU5+anjUoCMFSYbDBGcB7JpouQOFEifM5hDp2a3LcCGCC6GNDDeam
 lRB8TiHJqHlXmsPNnpPUt/iljQhPLg6+2EFvGDuU6yBvglNqwrjN2cmFOVNSxGAWTXTt
 J5jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765397485; x=1766002285;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=WsKn1G1/4srsIWi/wK//e1V/3kE4yxRSmtOx1lC41pE=;
 b=pY4P+oTWJoigYtaitu095BWQIr3GZhl97iqsIwbssamC4WUan3OhokGSw2PA/Dx/2z
 fuHooVUqKGGy4iDEZi9usdb3xmx67Xd/im+mFTEnO/kFH0fVZmJz/8T5eE7xStHMNlW5
 SKr6dwF9RaM+AzmQqNFMzP245nMObMvASBtA+BA3II7diPTrAJiYgRihBCVpFddwPcpN
 Ke72Ds0PEyR/e1enQ0jBcQPPbg8M6C6GMyKuljSSWpq71YeDNrjBBLYvV+rIq9EVjeGb
 R5RCuDhGxjPy3KBIh48S7th8oeHR+mz39iCubDSMTAKOFZguBSnXeSaRTA6jX0HSNH1r
 06qQ==
X-Gm-Message-State: AOJu0YwcQBd6LbPRP9WgQeCMc9Ad7AoXOnJlWJh3/BDKKcENatk2l8xz
 0MVigNcJmmAmaThyVUoMzvzCodXWUeAKPxXf6folPGf3BLQ6iH3ep/Hr
X-Gm-Gg: AY/fxX6bAn49hZDeFttwA/isyZ7PXngtJqRAbyTngs6dpcswDGzHVWCV3EXsQZ90mFN
 KgD3isGsRGNa3NPM+pMifWu0qSJrCUArsRqiyVjg4v582qOJSboMlSDM0HJmQPE7w9A21v96E7r
 cJooBz6crNH6VHmEKq5P/WcAvv8tBzzN1vdnrr0JsnVqG+kDviovinFgLazjsGRlVMh6qGAcTn3
 k6ayc1yYDsGGtn9QT5MKV1VCL1hfBq7Dn9aI7e4P23vwFevB3+/FLLPgeJLfWNoNKK2omjqmnue
 1vFLRVCe3bA1ZnCrtzQ64PGjoHb9bIaPJNHho72laFETMIa3x9YRPFu8gLFnt98/G+4JFIIkiVU
 rft7SGf7bj3OmYlxqP/myQHrrF/L/yUNbgO1R74AGP0Av5wBeCKXYf8y+A7DvCZKGFBjc+yUBIh
 bSvkGsed70OKZQ92H1yXYPGWqL
X-Google-Smtp-Source: AGHT+IEEW8bxppoo+NFf8PFBDE12mBCx+O1FKt1Jjo1BhQY6f74qmrmY2TWLY7qC6FKz1Kyu/vfsvw==
X-Received: by 2002:a05:6512:3c8f:b0:598:ed36:d9fe with SMTP id
 2adb3069b0e04-598ee4d72b6mr1277819e87.47.1765397484490; 
 Wed, 10 Dec 2025 12:11:24 -0800 (PST)
Received: from alchark-surface.localdomain ([31.173.84.52])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-598f2f45bbbsm134986e87.45.2025.12.10.12.11.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Dec 2025 12:11:23 -0800 (PST)
From: Alexey Charkov <alchark@gmail.com>
Date: Wed, 10 Dec 2025 23:10:47 +0300
Subject: [PATCH 1/4] common/spl: fit: Avoid directly loading images to
 load_addr
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251210-rk3576-ufs-v1-1-a3f9e76eb66e@gmail.com>
References: <20251210-rk3576-ufs-v1-0-a3f9e76eb66e@gmail.com>
In-Reply-To: <20251210-rk3576-ufs-v1-0-a3f9e76eb66e@gmail.com>
To: u-boot@lists.denx.de, Shawn Lin <shawn.lin@rock-chips.com>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>, 
 Michael Walle <mwalle@kernel.org>, Rasmus Villemoes <ravi@prevas.dk>, 
 Marek Vasut <marek.vasut@mailbox.org>, Anshul Dalal <anshuld@ti.com>, 
 Andre Przywara <andre.przywara@arm.com>, Peng Fan <peng.fan@nxp.com>, 
 Alice Guo <alice.guo@nxp.com>, Ye Li <ye.li@nxp.com>, 
 Hrushikesh Salunke <h-salunke@ti.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Anurag Dutta <a-dutta@ti.com>, Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Philippe Reynes <philippe.reynes@softathome.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Xuhui Lin <xuhui.lin@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Lukasz Czechowski <lukasz.czechowski@thaumatec.com>, 
 Johan Jonker <jbx6244@gmail.com>, Dhruva Gole <d-gole@ti.com>, 
 Yifeng Zhao <yifeng.zhao@rock-chips.com>, Sam Edwards <cfsworks@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Tuyen Dang <tuyen.dang.xa@renesas.com>, Greg Malysa <malysagreg@gmail.com>, 
 Utsav Agarwal <utsav.agarwal@analog.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, 
 Oliver Gaskell <Oliver.Gaskell@analog.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 Stefan Roese <stefan.roese@mailbox.org>, Heiko Schocher <hs@nabladev.com>, 
 Sumit Garg <sumit.garg@kernel.org>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, 
 Randolph <randolph@andestech.com>, 
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Huan Zhou <me@per1cycle.org>, 
 Gabriel Fernandez <gabriel.fernandez@foss.st.com>, 
 Christian Marangi <ansuelsmth@gmail.com>, 
 Elaine Zhang <zhangqing@rock-chips.com>, 
 Joseph Chen <chenjh@rock-chips.com>, Ian Roberts <ian.roberts@timesys.com>, 
 Alexey Charkov <alchark@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1468; i=alchark@gmail.com;
 h=from:subject:message-id; bh=eDZe4HJgICMNmvQXl+/R192ufeCKaFHpHPwWWb6rpYI=;
 b=owGbwMvMwCW2adGNfoHIK0sZT6slMWRaXn62gp3nadqsbFk9j8B77a0S4jVLohkzq+xbYjlKf
 86pnPOno5SFQYyLQVZMkWXutyW2U434Zu3y8PgKM4eVCWQIAxenAEwkfTkjw+t1F5bdq61+ueSs
 ZNZznRu3YzctsjmS2v7CoyUya1HilIsM//PPSqQ2troYnG3mPbVpUZHw161WRrOi6i/sCNNeFm5
 QwgAA
X-Developer-Key: i=alchark@gmail.com; a=openpgp;
 fpr=9DF6A43D95320E9ABA4848F5B2A2D88F1059D4A5
X-Mailman-Approved-At: Wed, 10 Dec 2025 23:28:32 +0100
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

Load images unconditionally to a known-safe location (which is
CONFIG_SYS_LOAD_ADDR) to be later relocated to its desired load address.

Some storage devices may be unable to directly load each of the images
listed in a FIT to their desired load addresses, as is the case with
e.g. booting from UFS storage on Rockchip RK3576, where part of the
ATF should end up in SRAM but the UFS controller cannot directly write
there.

Furthermore, the code down the line does a memmove or image decompression
from the original src_ptr, anyway, so there shouldn't be any performance
implications from this change.

Signed-off-by: Alexey Charkov <alchark@gmail.com>
---
 common/spl/spl_fit.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
index a588d13eb402..f10c0ca7d281 100644
--- a/common/spl/spl_fit.c
+++ b/common/spl/spl_fit.c
@@ -291,11 +291,7 @@ static int load_simple_fit(struct spl_load_info *info, ulong fit_offset,
 			return 0;
 		}
 
-		if (spl_decompression_enabled() &&
-		    (image_comp == IH_COMP_GZIP || image_comp == IH_COMP_LZMA))
-			src_ptr = map_sysmem(ALIGN(CONFIG_SYS_LOAD_ADDR, ARCH_DMA_MINALIGN), len);
-		else
-			src_ptr = map_sysmem(ALIGN(load_addr, ARCH_DMA_MINALIGN), len);
+		src_ptr = map_sysmem(ALIGN(CONFIG_SYS_LOAD_ADDR, ARCH_DMA_MINALIGN), len);
 		length = len;
 
 		overhead = get_aligned_image_overhead(info, offset);

-- 
2.49.1

