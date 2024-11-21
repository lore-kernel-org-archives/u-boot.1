Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B077D75BB9
	for <u-boot@archiver.kernel.org>; Thu, 21 Nov 2024 05:29:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B3B0896AF;
	Thu, 21 Nov 2024 06:26:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1732166794;
	bh=73OWqAnbvPHpbX13UH0DKmhSv6TPPIX/xOSyVjC9JDk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=acZYJ++WCxYMTbNgb2H0dmRmR8i7syPxQ/xXmxslwXY9DuliZ70+4jxenlxvrc8mR
	 YHKds+Ss9i6AanxYHS6pPlU8n+0Cx3eaaxRpNPSvxaMSXPY3eu3u/NVuZOJ6TxHL8D
	 7nTtzjYryEEpzgr3/TW1WDssPkbQBz4w+Fk1MKBiufbQj7yFwjf53/BGjH1CHkr0r7
	 37o/UfFgyP6xIntjubrThV/zcIL0Nw0T9BaouV8YkIaiREuaRuUZPnS/HOhrsaRYS/
	 /CyfawPIYzEGntOK7FCcMH/opRyPcZwe/jFtdlaI/jVEc26ZsfZ89PUQj0ACvPFstl
	 Nk9PwCIhtKdpg==
Received: from localhost.localdomain (82-131-203-244.pool.digikabel.hu
 [82.131.203.244])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 10AF18969B;
 Thu, 21 Nov 2024 06:26:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1732166786;
 bh=73OWqAnbvPHpbX13UH0DKmhSv6TPPIX/xOSyVjC9JDk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=YwHinreV5fSXD7HVNakJLA2xVy2m5H6b5qczMCgHL2xPeyFeulX9D0ZybW70jUCV0
 8MiB434+9PAJgGy4QQhVT11n1T5ujpfHHjXAni/OK2FMXA5mVXxDBg84Ju68Zw4fXO
 YX8H5MBKxyd6qOh3arVN/mCHu9mwPIdZ98hM378mLZdoMuLQOg+Xdo9oxo36O2+1xI
 2XMPP8/mkLXV8aWR4SVCbsHh0r59KCATg/kBnIYnujIpTt2znFcuvsDZaWlPybLuP3
 6swC6PFY4pVlu6mTsr7yHLXAniDW8lHwIg/Tgeej2nmkHVTeNIy9f0NaqU46CRiil4
 trC5OjozSiAhw==
From: Heiko Schocher <hs@denx.de>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Walter Schweizer <walter.schweizer@siemens.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Enrico Leto <enrico.leto@siemens.com>, Heiko Schocher <hs@denx.de>,
 Anatolij Gustschin <agust@denx.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 20/20] siemens: capricorn: update maintainers
Date: Thu, 21 Nov 2024 06:26:01 +0100
Message-Id: <20241121052601.72880-21-hs@denx.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241121052601.72880-1-hs@denx.de>
References: <20241121052601.72880-1-hs@denx.de>
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

(no changes since v2)

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

