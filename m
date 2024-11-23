Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FBB4E6ADDD
	for <u-boot@archiver.kernel.org>; Sat, 23 Nov 2024 16:54:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA60089401;
	Sat, 23 Nov 2024 17:53:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1732380804;
	bh=FZpdWdNKPa8UE9QJ8n+pmNNrYrN6/mGXlBVpZ5/w1GE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FkQnzi8D/miBAseEm64TP1tRcvPQju6yI/q71bOK1Mek6N7xCrG7eAErRfn4gEKcb
	 LMt66YaIqbJ8HKJaYQeTkUzTTbTsy/Q56kXxdbJZwezLitkHOI/OpX0LK3VSI94bGm
	 ZCuTCAPRnpHadgHuy0o3G1lvR3Q1RPuMm3hzEZQD1Sw09i5ktj3bT1S0ohukRqxHp1
	 fgMWOYF4hVnCTfSTlWzHJAe5KUaq6syjbyMurw+Gt6Mx99rhBlS2umvRymssmkWwIU
	 UILw0aljsiMgr5z0pk6l6Erv4LyiSihx0Q0kFltv4h34CyhzNPxmfVdDBwyDVlhwBx
	 SZ1KJZwjXVrkA==
Received: from localhost.localdomain (82-131-203-244.pool.digikabel.hu
 [82.131.203.244])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 593AD88EAF;
 Sat, 23 Nov 2024 17:53:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1732380800;
 bh=FZpdWdNKPa8UE9QJ8n+pmNNrYrN6/mGXlBVpZ5/w1GE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=VqklPx7Vpc2j2JiGA9Z4iRvjueyqvNoQ0VC9CSkjHuvuAebBeChjERj20ft56e8m5
 Kg/RZKOdxsJJdk/B+ifIbYCErrT7LcQlim+v3Ey0wrOgblQzCRzZ/dux3gqvwhMcU2
 hxyG+IsYW4NXfarfrbGS7PsFJcsTk7k0vXUJr1p4FeFiioJpqRRT+fU8fxjYhe6kDf
 3d8Itg2tamuMmF8SObgEcE/hYfvveBSBG7/NsO5jGZDUMYuBNL/30z3zdOYKvF8Cvn
 TvZyZZrpb3VZgr00G1C89QqelR7VCuX1YGoFY+RdHPgd6Fhw2zYEAcc8MelG12BTBH
 FWHNfZLmQi3qQ==
From: Heiko Schocher <hs@denx.de>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Walter Schweizer <walter.schweizer@siemens.com>,
 Enrico Leto <enrico.leto@siemens.com>, Heiko Schocher <hs@denx.de>,
 Anatolij Gustschin <agust@denx.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 10/20] siemens: imximage.cfg: sync image names
Date: Sat, 23 Nov 2024 17:52:54 +0100
Message-Id: <20241123165304.100538-11-hs@denx.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241123165304.100538-1-hs@denx.de>
References: <20241123165304.100538-1-hs@denx.de>
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

sync the image names in imximage.cfg with
the ones used in arch/arm/dts/imx8qxp-u-boot.dtsi

Signed-off-by: Heiko Schocher <hs@denx.de>
---

(no changes since v1)

 board/siemens/capricorn/imximage.cfg | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/board/siemens/capricorn/imximage.cfg b/board/siemens/capricorn/imximage.cfg
index f73c5a7a9b0..7fd3fb8b72e 100644
--- a/board/siemens/capricorn/imximage.cfg
+++ b/board/siemens/capricorn/imximage.cfg
@@ -15,12 +15,18 @@ DCD_SKIP true
 
 /* SoC type IMX8QX */
 SOC_TYPE IMX8QX
-/* Append seco container image */
-APPEND ahab-container.img
+/*
+ * Append seco container image,
+ * use same name as in arch/arm/dts/imx8qxp-u-boot.dtsi
+ */
+APPEND mx8qxc0-ahab-container.img
 /* Create the 2nd container */
 CONTAINER
-/* Add scfw image with exec attribute */
-IMAGE SCU capricorn-scfw-tcm.bin
+/*
+ * Add scfw image with exec attribute
+ * use same name as in arch/arm/dts/imx8qxp-u-boot.dtsi
+ */
+IMAGE SCU mx8qx-mek-scfw-tcm.bin
 
 /* Add SPL image with exec attribute */
 IMAGE A35 spl/u-boot-spl.bin 0x00100000
-- 
2.20.1

