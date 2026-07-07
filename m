Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B94B5C43458
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 16:39:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 221D884AC0;
	Tue,  7 Jul 2026 18:37:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=0leil.net header.i=@0leil.net header.b="RzrLY95d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5907984A3E; Tue,  7 Jul 2026 18:09:48 +0200 (CEST)
Received: from smtp-42af.mail.infomaniak.ch (smtp-42af.mail.infomaniak.ch
 [84.16.66.175])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2636084A06
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 18:09:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot@0leil.net
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch
 [10.4.36.108])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4gvmQK4h2yz297;
 Tue,  7 Jul 2026 18:09:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1783440585;
 bh=Wyz7x7foOo2bND+bNfrZE74JnkFnOsS3mA5J6s/HPQk=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=RzrLY95dCaQWkD4QShhu8QrbZ/ZPXdkZud4YL4YQ6YXKpkrROgFJlgUcVCyQFIkrF
 0RkfYoBZofS1JareuXwio3myKK0a47LSP4I3SCLxLul0GtGi7x8Wa75hNnXwu3rH0w
 eYgROZnWEA45mo8CQCfHJdhcpmgr4kfGeLaJ5nWKLA3uj8RISAY4zjdzC269s+Ugst
 p1HSZS9NRcm7uFnB5OALQPKE4bQpqiOaPBQQTA23CVXNJfqS4ZmT+KZ6wg8J85PYjb
 dUPjGjBVFgWIAXTYQZktaRa7KY8s1l/ET/Qqu++0MOLAQwRI+fuyUWwEBaxI2eKmcS
 8BmDfLdMSBhOQ==
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4gvmQJ4sH2zXYk; Tue,  7 Jul 2026 18:09:44 +0200 (CEST)
From: Quentin Schulz <u-boot@0leil.net>
Date: Tue, 07 Jul 2026 18:09:19 +0200
Subject: [PATCH 05/12] MAINTAINERS: add N: rk3 regex to ARM ROCKCHIP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-rk-custodian-v1-5-dbc9c696e613@0leil.net>
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

Most Rockchip SoCs have their name start with rk3xxx. Historically, the
second digit is for the generation of SoC, e.g. rk31xx was before
rk32xx, itself before rk33xx and now rk35xx (and the expected rk36xx end
of this year). We won't talk about the rk30xx timeline but it's also
prefixed the same way. So let's match *anything* in U-Boot which
contains rk3 in the path to simplify the MAINTAINERS entry and hopefully
catch as much as possible.

board/firefly/ and board/pine64/ only contain subdirectories and each of
them have rk3 in their name.

Signed-off-by: Quentin Schulz <u-boot@0leil.net>
---
 MAINTAINERS | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9527af78d391..393c8abde10c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -578,20 +578,12 @@ T:	git https://source.denx.de/u-boot/custodians/u-boot-rockchip.git
 X:	configs/kmsupx5_defconfig
 N:	px30
 N:	px5
+# RK3xxx SoC family
+N:	rk3
 N:	rockchip
-F:	arch/arm/dts/rk3*
 F:	arch/arm/dts/rv11*
-F:	board/amarula/vyasa-rk3288/
-F:	board/anbernic/rgxx3_rk3566/
-F:	board/armsom/sige7-rk3588/
-F:	board/chipspark/popmetal_rk3288
-F:	board/firefly/
-F:	board/mqmaker/miqi_rk3288/
-F:	board/phytec/phycore_rk3288
-F:	board/pine64
 F:	board/radxa/
 F:	board/theobroma-systems
-F:	board/vamrs/rock960_rk3399/
 F:	drivers/gpio/rk_gpio.c
 F:	tools/rkcommon.c
 F:	tools/rkcommon.h

-- 
2.55.0

