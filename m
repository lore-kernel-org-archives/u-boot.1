Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF691C43458
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 16:38:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98AEE84A0A;
	Tue,  7 Jul 2026 18:37:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=0leil.net header.i=@0leil.net header.b="mqFYxLH2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9A2884A30; Tue,  7 Jul 2026 18:09:46 +0200 (CEST)
Received: from smtp-42ab.mail.infomaniak.ch (smtp-42ab.mail.infomaniak.ch
 [IPv6:2001:1600:19:b8b8::42ab])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6DE69849A4
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 18:09:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot@0leil.net
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch
 [10.4.36.108])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4gvmQJ0GBxz295;
 Tue,  7 Jul 2026 18:09:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1783440583;
 bh=OXt1RFe3leIoarTp6pI39xg7ObjnqHzPgjVjiD8wxao=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=mqFYxLH2acNVnIWkjLP86eLAFq+5VWAdyGz9kdEE9KN6TbBVd7rdx1ux5dt/PiZVe
 Hf00sN44zp5R7Q2Y5YT+wa2yoLkqQQIY9BhwpxVlUrXi5r/sUKEn0257wRtBT6/0pD
 SpNZCW+GbxycDkDr7FZLV+lnrK5efyl/Q5TuaIQe755+QwVQn7C+ZJopmMVBfIkS3i
 hNhE7rXHwN0WAWLEj0+y8l1vf7FkqVzeC+2MHbBA6qhuQ461ZAPf1LlPoGo2cxii5/
 5/Iw6z0I9tF0qsYjZhs2ii7R5QPc8Bw0rST+tEGtwUD9U3oPVquYgoFCsX89q+YR90
 yXqwga1Xo2YoQ==
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4gvmQG6nCCzZ1k; Tue,  7 Jul 2026 18:09:42 +0200 (CEST)
From: Quentin Schulz <u-boot@0leil.net>
Date: Tue, 07 Jul 2026 18:09:17 +0200
Subject: [PATCH 03/12] MAINTAINERS: add N: px30 regex to ARM ROCKCHIP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-rk-custodian-v1-3-dbc9c696e613@0leil.net>
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

PX30 is a Rockchip SoC, so let's match *anything* in U-Boot which
contains this string in the path.

Signed-off-by: Quentin Schulz <u-boot@0leil.net>
---
 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6f52fb76fede..37766bfcc3ca 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -574,15 +574,14 @@ M:	Philipp Tomsich <philipp.tomsich@vrull.eu>
 M:	Kever Yang <kever.yang@rock-chips.com>
 S:	Maintained
 T:	git https://source.denx.de/u-boot/custodians/u-boot-rockchip.git
+N:	px30
 N:	rockchip
-F:	arch/arm/dts/px30*
 F:	arch/arm/dts/rk3*
 F:	arch/arm/dts/rv11*
 F:	board/amarula/vyasa-rk3288/
 F:	board/anbernic/rgxx3_rk3566/
 F:	board/armsom/sige7-rk3588/
 F:	board/chipspark/popmetal_rk3288
-F:	board/engicam/px30_core/
 F:	board/firefly/
 F:	board/mqmaker/miqi_rk3288/
 F:	board/phytec/phycore_rk3288

-- 
2.55.0

