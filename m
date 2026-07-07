Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5FA7C43458
	for <u-boot@archiver.kernel.org>; Tue,  7 Jul 2026 16:40:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13FF084B01;
	Tue,  7 Jul 2026 18:37:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=0leil.net header.i=@0leil.net header.b="KYd75ebr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A154384A0B; Tue,  7 Jul 2026 18:09:54 +0200 (CEST)
Received: from smtp-bc0b.mail.infomaniak.ch (smtp-bc0b.mail.infomaniak.ch
 [IPv6:2001:1600:19:b8b8::bc0b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 63183849A4
 for <u-boot@lists.denx.de>; Tue,  7 Jul 2026 18:09:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot@0leil.net
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch
 [10.4.36.108])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4gvmQR6yp2z4l;
 Tue,  7 Jul 2026 18:09:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1783440591;
 bh=zR002Ig5C2ZgMOc0R66VeuHrhrvZRfCr/UGyGWJY4n4=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=KYd75ebrXoJnUx4KgAs6vy5ZR4LjdsDRjOTSg+jvgV5MGzgIpCEMHgEBSz0olD3/c
 ko+x+oVp/VCcC+MM55a1PO/42/DGztsNAlYqLi08ua9WU9TO1o1bqQPoGw06mTh6vX
 0U7MkII/4bpAfti3POsPuRYjFu4Cd+aLT+oJgjLNFFcO4bNZ9zqDj7rWkipG4rVALy
 9YbS1SAa5tn/jsiVBt50fL8h/boz2mtYyXqijha8KKWxgij+s/al2ksNDjg596eiRo
 Kf6eH3whxhDAnelQzUQey0uZUoSUeFuC92BrlUCU2y1ABHcealbyElhh07GXcfPpqJ
 NIiLU9Yej70uA==
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4gvmQQ3spFzXGg; Tue,  7 Jul 2026 18:09:50 +0200 (CEST)
From: Quentin Schulz <u-boot@0leil.net>
Date: Tue, 07 Jul 2026 18:09:26 +0200
Subject: [PATCH 12/12] MAINTAINERS: add myself as ARM ROCKCHIP maintainer
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-rk-custodian-v1-12-dbc9c696e613@0leil.net>
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

Kever has been pulled into different responsibilities at Rockchip and
this means he has less to no time for his maintainership in U-Boot as
has been seen for about a year now. Let's try to improve the situation
and have Rockchip-related things merged again by adding myself as
another maintainer.

Signed-off-by: Quentin Schulz <u-boot@0leil.net>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1ddd9a3e45c4..068f59412801 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -570,6 +570,7 @@ F:	drivers/usb/host/xhci-rcar*
 
 ARM ROCKCHIP
 M:	Simon Glass <sjg@chromium.org>
+M:	Quentin Schulz <u-boot@0leil.net>
 M:	Kever Yang <kever.yang@rock-chips.com>
 S:	Maintained
 T:	git https://source.denx.de/u-boot/custodians/u-boot-rockchip.git

-- 
2.55.0

