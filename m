Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74DE9C43458
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 16:39:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF4D884AD7;
	Tue,  7 Jul 2026 18:37:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=0leil.net header.i=@0leil.net header.b="mSqFK5f8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4409C84A0B; Tue,  7 Jul 2026 18:09:50 +0200 (CEST)
Received: from smtp-42ab.mail.infomaniak.ch (smtp-42ab.mail.infomaniak.ch
 [IPv6:2001:1600:19:b8b8::42ab])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71196849BA
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 18:09:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot@0leil.net
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch
 [10.4.36.108])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4gvmQN0yjSzqv;
 Tue,  7 Jul 2026 18:09:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1783440587;
 bh=kYaiHZZikCW1Heq6wdPkdeglmXtr1rhS+L37UEb4mbA=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=mSqFK5f8F01sf89eM2YbUYAs4CNPZ7JETi1Xoz2xWrBNB9ijfSM1YoAH1iE5WU9F2
 X2CCP2J9rie6IvsEcN5aUDXiQV2PUpkvvZmx+OFvvILEWHDCy13bwmf11oAV9fFd6F
 K9OtDNl5vVymPe4vUWDyhyXRNC5og3yfVYY+u2pWlbya9cgz9GBLLQ/WFM8gZ4+9ud
 +XCDTGM4NOiukX102KhE2iCS3E6VHMZwInQ2+DpsOh3LM7KCsUoChQ6HGIVQNjXs6q
 XM+hqT6IEPXOJvYRzuryzlZ8LBNLGNjDBOXDwpEitahmnoegSeUw8eiDzyHyDt/G5H
 eYUlGI91efpuQ==
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4gvmQM0yygzZLs; Tue,  7 Jul 2026 18:09:47 +0200 (CEST)
From: Quentin Schulz <u-boot@0leil.net>
Date: Tue, 07 Jul 2026 18:09:22 +0200
Subject: [PATCH 08/12] MAINTAINERS: add N: rkmtd regex to ARM ROCKCHIP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-rk-custodian-v1-8-dbc9c696e613@0leil.net>
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

rkmtd is a Rockchip feature, so let's match *anything* with that in the
path.

Signed-off-by: Quentin Schulz <u-boot@0leil.net>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 49b35945f820..1c94356dc4b8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -582,6 +582,7 @@ N:	px5
 N:	rk3
 # RK8xx PMIC/regulator family
 N:	rk8
+N:	rkmtd
 N:	rockchip
 # RV11xx SoC family
 N:	rv11

-- 
2.55.0

