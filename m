Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9C36C43458
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 16:39:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 26D5584A5D;
	Tue,  7 Jul 2026 18:37:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=0leil.net header.i=@0leil.net header.b="m45Y1EkA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35FD184A35; Tue,  7 Jul 2026 18:09:51 +0200 (CEST)
Received: from smtp-190b.mail.infomaniak.ch (smtp-190b.mail.infomaniak.ch
 [185.125.25.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4E3F784A8D
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 18:09:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot@0leil.net
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch
 [10.4.36.108])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4gvmQN6VZNz1kR;
 Tue,  7 Jul 2026 18:09:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1783440588;
 bh=SXpOhHbiCdR1VRP97phFc+YYXMOPCS4CV4i2nn/HV48=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=m45Y1EkAHvofgjjMuCw/47k9fSLng3/HZ3zqdFeI/+Mjq1M4GMkCRX/Bz0nKdAgaE
 vAQIezR1rdgD2PtEeS7CyGcV/mhPvxkjf7V1lrIT+tBlEXQgN+G0T/vkQZAx0a6vmS
 eZEyEQXY4ZAEVzwiB65xHSrmFGUiQ7TukJrBgiGUl/GMP1biyPzp6lmfE5aCl+M4en
 AaXoe51inz68kGV37odLCro0KllLgR/5So0hR47etpiZ3D+J9mZ67h9UdIIfQUaa9X
 W6rb0TkjT9XT2zbMGj7fjWSJHoqKe+qNtNOpPg2279udgpeVAa9jTOPcG0++0e40Db
 OtydXSXvutTsA==
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4gvmQM6tfWzYyJ; Tue,  7 Jul 2026 18:09:47 +0200 (CEST)
From: Quentin Schulz <u-boot@0leil.net>
Date: Tue, 07 Jul 2026 18:09:23 +0200
Subject: [PATCH 09/12] MAINTAINERS: add more Rockchip drivers to ARM ROCKCHIP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-rk-custodian-v1-9-dbc9c696e613@0leil.net>
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

A few drivers are not using "rockchip" in their path so they aren't
currently detected by get_maintainer.pl as belonging to the ARM ROCKCHIP
entry, so let's fix that oversight by adding them individually. We could
use N: rk_ but I feel this isn't distinctive enough to avoid too many
false positive and I don't want to be keeping a list of things to not
match against.

Signed-off-by: Quentin Schulz <u-boot@0leil.net>
---
 MAINTAINERS | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1c94356dc4b8..b7f68d849755 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -589,6 +589,9 @@ N:	rv11
 F:	board/radxa/
 F:	board/theobroma-systems
 F:	drivers/gpio/rk_gpio.c
+F:	drivers/i2c/rk_i2c.c
+F:	drivers/pwm/rk_pwm.c
+F:	drivers/spi/rk_spi.[ch]
 F:	tools/rkcommon.c
 F:	tools/rkcommon.h
 F:	tools/rkimage.c

-- 
2.55.0

