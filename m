Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E4CFC83F2E
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 14:57:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0AA46865FB;
	Thu, 31 Aug 2023 16:57:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1693493856;
	bh=l4dCX7Pqh7mYr0QA04SasHKdy3TdMZrof00zKBmLIxc=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=p0C2KPDnEn+v7XJYcNQtbF/NpytoexwmJsiqb+aHUIQuz+ysopZJBOr8MPEPiB0mc
	 H+orUd4nshRXw/UcFfkT/0FTtPobjNoFZoaJgiuOaIVW1/8EgX/9xyq8aqVlsMAs+p
	 IZWflLY4mTQCqANAtSCSqMX/OTwsUhOd950yPyrNrBgcv3KLQ1r5IMjz0dCB+UfVa9
	 6c1NKP3Y+7zVT+VRSnZfA1BgzIYBUKE7kq2lSiegs7en172a8wzklUiXbcKHCMAy9j
	 v+9DpQb7Gzt9Ak1pZ/MV7v8/05pT5wCm3VAVrxx8Mftpu29m/lPoctXwuz6SKzXpLR
	 /8PgmH4uYU+Dg==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 9582B865A0;
 Thu, 31 Aug 2023 16:57:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1693493854;
 bh=l4dCX7Pqh7mYr0QA04SasHKdy3TdMZrof00zKBmLIxc=;
 h=From:To:Cc:Subject:Date:From;
 b=SrUZYLb6CLT6V3BhA82OjBLG1BKqTIkbAt9Tbt/NfIH5vkeduV5RZjgM94u3iLhHO
 t49Cg2nyxIphvWjIYto9cXQ5cQjYz2CmuZ9bKjI3eHkOidmumgIPpoPyYwcXh2dV76
 WM3RFUzPET7sH3Aq6KsGJ8wY7hWfXbHC+OudKE59K6z8J3dRFUY6+5BbmGMNLI+IKs
 Fm6A+luuq64UlawDs32zQ3gQ2G2sH7RlCGvf7/nKGt1Opq+R/ANWhUvIb+fynWgS9Q
 6+KsOqQGHBTm1uIj6rXwoGsFd30pfhpv/z4dVL1iaWu/KclgTInSGzYJM7UEb0GQbv
 sQGxwbN9aHM/g==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Fabio Estevam <festevam@denx.de>, Peng Fan <peng.fan@nxp.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Stefano Babic <sbabic@denx.de>, Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH] imx: hab: Use size parameter
Date: Thu, 31 Aug 2023 16:57:24 +0200
Message-Id: <20230831145724.80227-1-marex@denx.de>
X-Mailer: git-send-email 2.40.1
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

The current code works by sheer coincidence, because (see HABv4 API
documentation, section 3.4) the RVT authenticate_image call updates
the size that is passed in with the actual size ROM code pulls from
IVT/CSF . So if the input size is larger, that is "fine" . Pass in
size instead to make this really correct.

Signed-off-by: Marek Vasut <marex@denx.de>
---
NOTE: Rasmus, can you please double-check this one ? Thanks
---
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Fabio Estevam <festevam@denx.de>
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: Stefano Babic <sbabic@denx.de>
Cc: Tim Harvey <tharvey@gateworks.com>
---
 arch/arm/mach-imx/spl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/spl.c b/arch/arm/mach-imx/spl.c
index 6c13b00ef10..b30cd962553 100644
--- a/arch/arm/mach-imx/spl.c
+++ b/arch/arm/mach-imx/spl.c
@@ -353,7 +353,7 @@ void *spl_load_simple_fit_fix_load(const void *fit)
 	debug("%s: ivt: %p offset: %lx size: %lx\n", __func__, ivt, offset, size);
 	debug("%s: ivt self: %x\n", __func__, ivt->self);
 
-	if (imx_hab_authenticate_image((uintptr_t)fit, (uintptr_t)ivt, offset))
+	if (imx_hab_authenticate_image((uintptr_t)fit, (uintptr_t)size, offset))
 		panic("spl: ERROR: image authentication unsuccessful\n");
 
 	return (void *)fit;
-- 
2.40.1

