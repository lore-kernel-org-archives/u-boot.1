Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8D2EC43458
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 16:39:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A269184ACF;
	Tue,  7 Jul 2026 18:37:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=0leil.net header.i=@0leil.net header.b="QFgsFcXW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9005E84A0B; Tue,  7 Jul 2026 18:09:49 +0200 (CEST)
Received: from smtp-bc0e.mail.infomaniak.ch (smtp-bc0e.mail.infomaniak.ch
 [IPv6:2001:1600:19:7ff8::bc0e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA4B384A30
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 18:09:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot@0leil.net
Received: from smtp-3-0001.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:4:17::246c])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4gvmQM1y1rz19sM;
 Tue,  7 Jul 2026 18:09:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1783440587;
 bh=TuczWXTJGJoC/7VVCd9bTpvLnUFqWleSz6zoqUycQjU=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=QFgsFcXWklDK4iNxMvUKjIB1DI9twj7tDw4IinjC8GpoYSTK2oHLppcgT1zMWnEt8
 +2DJGdzk7GkwWj7eV82tpQA0T1SiUto3LWeTT0oQJ5k53ZgYBEqKA86cnoe8+z+gR+
 LvUtBGbPIqEqdAVyHu+KQ+rY0X+nH+Ll29YiH3Lnb4bPK/s6lcdjI2gOXBsUr2SGAX
 /TzmhPpAqZusGTKNe5TPoiTrRZVNz7S4FfDSbxI+rlpT6UqRAfjbm+wplToF8xIsz8
 v2cP8FpHiSu5j78mF59vX0IHAhagnKkR3436aDyf5V/Fhe/Tp8B8n/9WVc+egiUQi4
 nMs/0vywd+wwQ==
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4gvmQL28shzYBh; Tue,  7 Jul 2026 18:09:46 +0200 (CEST)
From: Quentin Schulz <u-boot@0leil.net>
Date: Tue, 07 Jul 2026 18:09:21 +0200
Subject: [PATCH 07/12] MAINTAINERS: add N: rv11 regex to ARM ROCKCHIP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-rk-custodian-v1-7-dbc9c696e613@0leil.net>
References: <20260707-rk-custodian-v1-0-dbc9c696e613@0leil.net>
In-Reply-To: <20260707-rk-custodian-v1-0-dbc9c696e613@0leil.net>
To: u-boot@lists.denx.de
Cc: Heiko Stuebner <heiko@sntech.de>, Jonas Karlman <jonas@kwiboo.se>, 
 Tom Rini <trini@konsulko.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Simon Glass <sjg@chromium.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Peng Fan <peng.fan@nxp.com>, 
 Kory Maincent <kory.maincent@bootlin.com>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, 
 Stefan Roese <stefan.roese@mailbox.org>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Philip Molloy <philip.molloy@analog.com>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Quentin Schulz <u-boot@0leil.net>
X-Mailer: b4 0.15-dev-47773
X-Infomaniak-Routing: alpha
X-Mailman-Approved-At: Tue, 07 Jul 2026 18:37:14 +0200
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

Rockchip has an RV11xx SoC series (RV1103, RV1106, RV1126) so let's
match *anything* in U-Boot which contains this string in the path and
not only the U-Boot Device Trees.

Signed-off-by: Quentin Schulz <u-boot@0leil.net>
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 97d5e8feb51b..49b35945f820 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -583,7 +583,8 @@ N:	rk3
 # RK8xx PMIC/regulator family
 N:	rk8
 N:	rockchip
-F:	arch/arm/dts/rv11*
+# RV11xx SoC family
+N:	rv11
 F:	board/radxa/
 F:	board/theobroma-systems
 F:	drivers/gpio/rk_gpio.c

-- 
2.55.0

