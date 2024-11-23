Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3E1EE6ADDD
	for <u-boot@archiver.kernel.org>; Sat, 23 Nov 2024 16:56:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8AA108943E;
	Sat, 23 Nov 2024 17:53:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1732380812;
	bh=73OWqAnbvPHpbX13UH0DKmhSv6TPPIX/xOSyVjC9JDk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OEzTiRq6Mk7zDMoE/pTjLQLh21qezEevo0sZv9Fv5fMUhVSMIPw9vb8K3oGUL/rCW
	 YWYDqB1Qf8DkGMZpA+S60YqvTOn25HnCYKHpag+BWpqTAKEEnfmURA3PPU5m60ENGB
	 9CLhjvRPoe81sTrmxELoiBgR+izNjEJ+7eXt7C6bue8igSSmiMsvKaOFJMx6s3UWm0
	 4GMnuNC04RM1+EnaL1XRPl8wPTBK0K6CFDLl4Ne0hp3mpnLSof6FvLjLtqXZAZG3mB
	 //GZwhqBr8BoTIH+nJbz5rFEgNQbKWNFylSREyxA4Ldz9+vl9HeAaWAa8yJUfwEj/l
	 SjzI5tUHFaeMA==
Received: from localhost.localdomain (82-131-203-244.pool.digikabel.hu
 [82.131.203.244])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id A3E21893F7;
 Sat, 23 Nov 2024 17:53:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1732380809;
 bh=73OWqAnbvPHpbX13UH0DKmhSv6TPPIX/xOSyVjC9JDk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=BBpUqhtqt20HAJxQDqPChjuwPVaSLEGla/2+DOygFLEBqTlD/HhmkhcQbWxpzm2/c
 TmAwUEl5B4bcpoJij1kb4oHfmFngKu/BGQhYGcrdWYkfyI2qQHKyAFsaK2xgfQ9W3b
 VlUyUWF6TAIwU2bu0wuU88tjwhqOEhDiPCKCuPn5MJtFThUvPF019I/8t82/VO2iWZ
 Gp3rvJdZ6lV9CLdyWP47f8rWDtEmrvdfHH5jvSawzE+hNTNttBr/nBDP5tZyHBDcAh
 lc2mFAD7X76CQr6X8uUQ2t6ptHM+DEZYunG3SbmgNSm3xIbEWMpk8GSJCUcOHu2EGd
 tcDAHl1yjePNA==
From: Heiko Schocher <hs@denx.de>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Walter Schweizer <walter.schweizer@siemens.com>,
 Enrico Leto <enrico.leto@siemens.com>, Heiko Schocher <hs@denx.de>,
 Anatolij Gustschin <agust@denx.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 20/20] siemens: capricorn: update maintainers
Date: Sat, 23 Nov 2024 17:53:04 +0100
Message-Id: <20241123165304.100538-21-hs@denx.de>
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

