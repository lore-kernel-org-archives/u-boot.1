Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6344DC43458
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 16:39:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A256384AF5;
	Tue,  7 Jul 2026 18:37:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=0leil.net header.i=@0leil.net header.b="AggLBZsj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B1D184A3E; Tue,  7 Jul 2026 18:09:53 +0200 (CEST)
Received: from smtp-42ab.mail.infomaniak.ch (smtp-42ab.mail.infomaniak.ch
 [IPv6:2001:1600:19:b8b8::42ab])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 065D984A06
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 18:09:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot@0leil.net
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch
 [10.4.36.108])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4gvmQQ5Dc9z1L1;
 Tue,  7 Jul 2026 18:09:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1783440590;
 bh=mPu7l1rTEUdh7iUFAtZgiwmhGWxCubROMay6V+fsDZY=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=AggLBZsjJ12zfqrzjSPPyqrkQFxAfbf0NgJDX6WeupK/F3V7jR4O2zDrAe1UQqahp
 jgI2u441nZDO79RossrgCA2oH2EBxGBhoOwUhl2xC9P+j144DZBgrAZgKUE8/ySpko
 ydVA0moPIS6mYD8AK42NuoFpr3/GPdHRK25F+JdB2+2pKRdw68U2D0g/2nsbhGmeHV
 i4nw3VWNBZ6ApS8Ks0TWfGKiA+pePMAjyNHOo6WZLb9OEfVVaaQfF/wHuTfbZy9cOu
 mRsnbrA5Ch7ACXxdl5b5NrwyyigjcQHggAEPgRqlki2egi/oxPxNJ3typGRpfaIq+6
 HehnFQ3PQVpxA==
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4gvmQP46v7zWsb; Tue,  7 Jul 2026 18:09:49 +0200 (CEST)
From: Quentin Schulz <u-boot@0leil.net>
Date: Tue, 07 Jul 2026 18:09:25 +0200
Subject: [PATCH 11/12] MAINTAINERS: remove Philipp Tomsich from ARM
 ROCKCHIP maintainers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-rk-custodian-v1-11-dbc9c696e613@0leil.net>
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

Philipp hasn't been active for years so we thank Philipp for his work
over the years and update the MAINTAINERS entry to reflect the reality.

Signed-off-by: Quentin Schulz <u-boot@0leil.net>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index bd2ef6166cb9..1ddd9a3e45c4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -570,7 +570,6 @@ F:	drivers/usb/host/xhci-rcar*
 
 ARM ROCKCHIP
 M:	Simon Glass <sjg@chromium.org>
-M:	Philipp Tomsich <philipp.tomsich@vrull.eu>
 M:	Kever Yang <kever.yang@rock-chips.com>
 S:	Maintained
 T:	git https://source.denx.de/u-boot/custodians/u-boot-rockchip.git

-- 
2.55.0

