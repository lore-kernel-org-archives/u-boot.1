Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99F28D5E133
	for <u-boot@archiver.kernel.org>; Tue, 16 Dec 2025 11:27:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 131C6839DD;
	Tue, 16 Dec 2025 12:26:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2683683990; Tue, 16 Dec 2025 12:26:46 +0100 (CET)
Received: from smtp-42ab.mail.infomaniak.ch (smtp-42ab.mail.infomaniak.ch
 [84.16.66.171])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED89C83984
 for <u-boot@lists.denx.de>; Tue, 16 Dec 2025 12:26:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=foss+uboot@0leil.net
Received: from smtp-4-0001.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:7:10::a6c])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4dVvlR4ZWhzfdX;
 Tue, 16 Dec 2025 12:26:43 +0100 (CET)
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4dVvlQ5DVyzrS2; Tue, 16 Dec 2025 12:26:42 +0100 (CET)
From: Quentin Schulz <foss+uboot@0leil.net>
Date: Tue, 16 Dec 2025 12:26:31 +0100
Subject: [PATCH v2 3/3] rockchip: rk3288-tinker-s: remove duplicate include
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251216-rockchip-more-template-v2-3-6372e27fc689@cherry.de>
References: <20251216-rockchip-more-template-v2-0-6372e27fc689@cherry.de>
In-Reply-To: <20251216-rockchip-more-template-v2-0-6372e27fc689@cherry.de>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Philipp Tomsich <philipp.tomsich@vrull.eu>, 
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Johan Jonker <jbx6244@gmail.com>, Sumit Garg <sumit.garg@kernel.org>, 
 Xuhui Lin <xuhui.lin@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>, 
 Michael Trimarchi <michael@amarulasolutions.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>
X-Mailer: b4 0.14.3
X-Infomaniak-Routing: alpha
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

From: Quentin Schulz <quentin.schulz@cherry.de>

arch/arm/dts/rk3288-tinker-u-boot.dtsi already includes
rk3288-u-boot.dtsi so no need to do it twice.

Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
---
 arch/arm/dts/rk3288-tinker-s-u-boot.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/dts/rk3288-tinker-s-u-boot.dtsi b/arch/arm/dts/rk3288-tinker-s-u-boot.dtsi
index 614d47ce180..9e2f1089fb2 100644
--- a/arch/arm/dts/rk3288-tinker-s-u-boot.dtsi
+++ b/arch/arm/dts/rk3288-tinker-s-u-boot.dtsi
@@ -3,7 +3,6 @@
  * Copyright (C) 2019 Amarula Solutions SRO
  */
 
-#include "rk3288-u-boot.dtsi"
 #include "rk3288-tinker-u-boot.dtsi"
 
 / {

-- 
2.52.0

