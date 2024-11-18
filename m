Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5084CD68BD0
	for <u-boot@archiver.kernel.org>; Mon, 18 Nov 2024 06:30:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA4518946F;
	Mon, 18 Nov 2024 07:27:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1731911264;
	bh=huis+Gg6TN5IbJ12btTz4g2EtZD0WOV6APLMeIhuz2o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CA6CIVPrWTzHeoqaPhtuAcbaxWZM40fW9WlmKdUFNBnJIh5jolZ0uXo+Nny3O+kHM
	 2v6HXHcfdtYmoRauAxCvWrzlGJxyc0Urm4P5JW50Gs797VLkHRGpvQTgmLRRqhSwCM
	 JsrX0twHO57+ufoWm5q9iwJTKdBS9eRvjaj6mdaBN3FILFqdmBftf7IrPz/h1eT2lQ
	 h1wl+Zm+6QMJI2Fj4YjOtARps1FQ3TRuEMkYRVZLcJ+8JEF6aoNy+8iPVHlZ7Fr7Of
	 toQ39RHpWdZYsCpbDL2tXTxTIkQyHKlJt/NymSOvxqc5ra2DFqgoJ8BbO54TUg61F1
	 LsVfHz8+JA1dg==
Received: from localhost.localdomain (82-131-203-244.pool.digikabel.hu
 [82.131.203.244])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 0280589475;
 Mon, 18 Nov 2024 07:27:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1731911261;
 bh=huis+Gg6TN5IbJ12btTz4g2EtZD0WOV6APLMeIhuz2o=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=mHliBC65D7g6rrL4VfG2KSLYzWizD4JoR7nkPh7rQqvmcqAtZPxzZMDkf3whNFSGA
 J6I6x8q621xZhVP/Wkis9AwxEduSn8aFLDKuU/ZXWKofu57IY2qNImHVhIOxCkTpoc
 6EPxGlTWTUen+ZPWkEyenuDjEhcCasHmIZJSUfkS+0KJFFNVYzvPYjtkEGdtMAXp/+
 IcJpRwbiOaJ+hJx+TPF9UAJ3gHYDUmnh8bjKCOPPxdHxEgvcmh0977gw1EaowbcXRG
 BavypmuW9soWMBfDRlhTOwD0tT0NZsFWIWQR/yM3kvgoW7y2ckM3npZV/m9IjbIKdE
 i44gN6tqcxvog==
From: Heiko Schocher <hs@denx.de>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Walter Schweizer <walter.schweizer@siemens.com>,
 Enrico Leto <enrico.leto@siemens.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Heiko Schocher <hs@denx.de>, Anatolij Gustschin <agust@denx.de>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 20/20] siemens: capricorn: update maintainers
Date: Mon, 18 Nov 2024 07:27:14 +0100
Message-Id: <20241118062715.32989-21-hs@denx.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241118062715.32989-1-hs@denx.de>
References: <20241118062715.32989-1-hs@denx.de>
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

From: Enrico Leto <enrico.leto@siemens.com>

update MAINTAINERS file, add some more board maintainers.

Signed-off-by: Enrico Leto <enrico.leto@siemens.com>
Signed-off-by: Heiko Schocher <hs@denx.de>
Reviewed-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>

---

Changes in v2:
- add Reviewed-by from Alexander

 board/siemens/capricorn/MAINTAINERS | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/board/siemens/capricorn/MAINTAINERS b/board/siemens/capricorn/MAINTAINERS
index b4c52032cc9..5f467aa9b6e 100644
--- a/board/siemens/capricorn/MAINTAINERS
+++ b/board/siemens/capricorn/MAINTAINERS
@@ -1,10 +1,12 @@
 CAPRICORN BOARD
+M:	Alexander Sverdlin <alexander.sverdlin@siemens.com>
 M:	Anatolij Gustschin <agust@denx.de>
+M:	Heiko Schocher <hs@denx.de>
+M:	Walter Schweizer <walter.schweizer@siemens.com>
 S:	Maintained
+F:	arch/arm/dts/imx8-capricorn-cxg3.dts
+F:	arch/arm/dts/imx8-capricorn-u-boot.dtsi
+F:	arch/arm/dts/imx8-capricorn.dtsi
 F:	board/siemens/capricorn/
+F:	configs/capricorn_cxg3_defconfig
 F:	include/configs/capricorn-common.h
-F:	include/configs/deneb.h
-F:	include/configs/giedi.h
-F:	include/configs/siemens-env-common.h
-F:	configs/deneb_defconfig
-F:	configs/giedi_defconfig
-- 
2.20.1

