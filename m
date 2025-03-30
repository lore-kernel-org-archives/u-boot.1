Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7524DC28B20
	for <u-boot@archiver.kernel.org>; Sun, 30 Mar 2025 21:40:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0E488144A;
	Sun, 30 Mar 2025 23:40:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="nlA5J3WS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71229800C1; Sun, 30 Mar 2025 23:40:30 +0200 (CEST)
Received: from smtp.forwardemail.net (smtp.forwardemail.net [149.28.215.223])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05D82800C1
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 23:40:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=SRS0=c171=WS=kwiboo.se=jonas@fe-bounces.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=fe-e1b5cab7be; t=1743370826;
 bh=e9Ifp1DNzgH076aWSlbbseNsbkenRrB/IV4fM9i3AzU=;
 b=nlA5J3WSnKurNaZlyOmJkRqWeCihgZGmobPoe+ayUKU6Fw+96l9WZH7VezI6kJ9RNWoIKMheW
 cGgO4sOYnpAJMr17GoN9XJsra+F13/aVozoJV1zT6ept9R+cR7yGbIPlqFBwIOZgk1fT3Fy4toU
 HWC06/hfS3yCbojFIHTwv2RGFJohmYxREBi/kCxOqRE2/zTTek215gKdctQvDO+8IU3nel1OQUY
 NiihoO7AMQOMvRtkQPFqOeQjdTSC/m9bFHz7DaIjCwMLBL71ndCe4VNHnWSmjLZdZt22WIGRr8a
 VDYjQ6Fnp1VQbpOI+SGRcDtk2e4Ccc4dY+oo/cW0H0Uw==
X-Forward-Email-ID: 67e9ba45f4aa6b41f9be0759
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 149.28.215.223
X-Forward-Email-Version: 1.0.0
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de,
 Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 0/2] rockchip: Update rng compatible for RK356x and RK3588
Date: Sun, 30 Mar 2025 21:40:09 +0000
Message-ID: <20250330214015.3466802-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.49.0
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

This series adds support for and updates the random generator compatible
used for RK356x and RK3588.

The RK356x rng node is already part of dts/upstream so the rng node in
u-boot.dtsi is dropped, and because it is not enabled for rk3566 it gets
enabled in u-boot.dtsi to restore its use in U-Boot.

The RK3588 dts/upstream rng node will not land in U-Boot until v6.15-dts
is pulled into U-Boot for a future release, so the compatible is just
updated to match the compatible used in upstream Linux.

Jonas Karlman (2):
  rng: rockchip_rng: Add compatible for RK3568
  rng: rockchip_rng: Update compatible for RK3588

 arch/arm/dts/rk356x-u-boot.dtsi  | 9 ++++-----
 arch/arm/dts/rk3588s-u-boot.dtsi | 4 ++--
 drivers/rng/rockchip_rng.c       | 6 +++++-
 3 files changed, 11 insertions(+), 8 deletions(-)

-- 
2.49.0

