Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B553DC2FC04
	for <u-boot@archiver.kernel.org>; Thu, 17 Aug 2023 06:04:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E9E986A76;
	Thu, 17 Aug 2023 08:04:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.b="pPTJvdsO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C814186A6E; Thu, 17 Aug 2023 08:04:40 +0200 (CEST)
Received: from s.wrqvtzvf.outbound-mail.sendgrid.net
 (s.wrqvtzvf.outbound-mail.sendgrid.net [149.72.126.143])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0B91B86A2B
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 08:04:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=bounces+31435339-7456-u-boot=lists.denx.de@em2124.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=from:subject:in-reply-to:references:mime-version:to:cc:
 content-transfer-encoding:content-type:cc:content-type:from:subject:to;
 s=s1; bh=e8RHNDCtD7m4rHNlaZj+hOXKowghulG6VWYSwHGrLlg=;
 b=pPTJvdsOVZBfPcNwwL9tBIPWaDwpZnC9UFq7j/11M97CEOmaJnmqYjKcjHSrGf6VeQOp
 /FmAma//yPsYBYZ73gdA6kq2hTb1K7gZp26IZpOlqVGK8UR+/TMVt/bt4J2+ynHTw/LC/2
 j2OcVJauzGtrrPGIkdQQhsQuSVT+af2wA2Z7aPKBptWmkwPTiE+oiAs/EumKfg0suzCdZ0
 tcEpLlVrSO67xKULDiqYK6z2AU3bfn+612RmZ4uMRAXaFVvBReq7r3H0xSj+FKFPr+jnNP
 tSDg71brI3faLrgKNz9XtFOBhBHA8eaHGyQ0VE6I6/m4wY3jbnCVN6DT5/J0Q/gQ==
Received: by filterdrecv-d7bbbc8bf-b8xkx with SMTP id
 filterdrecv-d7bbbc8bf-b8xkx-1-64DDB874-1A
 2023-08-17 06:04:36.455756777 +0000 UTC m=+8490289.969106039
Received: from bionic.localdomain (unknown) by geopod-ismtpd-8 (SG) with ESMTP
 id 4nSGcpSXT72tNSG3fKi3jg Thu, 17 Aug 2023 06:04:36.195 +0000 (UTC)
From: Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 2/3] board: rockchip: rk35xx: Add device tree files to
 MAINTAINERS
Date: Thu, 17 Aug 2023 06:04:36 +0000 (UTC)
Message-ID: <20230817060422.477759-3-jonas@kwiboo.se>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230817060422.477759-1-jonas@kwiboo.se>
References: <20230817060422.477759-1-jonas@kwiboo.se>
MIME-Version: 1.0
X-SG-EID: =?us-ascii?Q?TdbjyGynYnRZWhH+7lKUQJL+ZxmxpowvO2O9SQF5CwCVrYgcwUXgU5DKUU3QxA?=
 =?us-ascii?Q?fZekEeQsTe+RrMu3cja6a0h9oeo1yH3j1gNDv1o?=
 =?us-ascii?Q?r=2F9YYg14xtwZ2adLVvCpHX46SsGiOaLF6r3PSkC?=
 =?us-ascii?Q?7Uy68lBZKNRrWq7Or2ZWt4j2HPfVji5CjnLa+1S?=
 =?us-ascii?Q?OmsNVVLIhcl6VQStTJaY57ZyvVxhig+86=2FG5v90?=
 =?us-ascii?Q?FyfU8lZMYs4b1GII6yklJnc+txSEUMc6lex=2FFM?=
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Eugen Hristev
 <eugen.hristev@collabora.com>, Andy Yan <andyshrk@163.com>, Jagan Teki
 <jagan@amarulasolutions.com>, Chris Morgan <macromorgan@hotmail.com>,
 Jagan Teki <jagan@edgeble.ai>, Jonas Karlman <jonas@kwiboo.se>, Joseph Chen
 <chenjh@rock-chips.com>
Cc: u-boot@lists.denx.de
X-Entity-ID: P7KYpSJvGCELWjBME/J5tg==
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
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

Update MAINTAINERS files for RK3566/RK3568/RK3588 boards to include
related device tree files. Also replace space with tabs.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 board/anbernic/rgxx3_rk3566/MAINTAINERS       |  3 ++
 .../neural-compute-module-6/MAINTAINERS       |  6 +++
 board/radxa/rock5a-rk3588s/MAINTAINERS        |  2 +
 board/radxa/rock5b-rk3588/MAINTAINERS         |  4 +-
 board/rockchip/evb_rk3568/MAINTAINERS         | 51 ++++++++++---------
 board/rockchip/evb_rk3588/MAINTAINERS         |  3 +-
 6 files changed, 43 insertions(+), 26 deletions(-)

diff --git a/board/anbernic/rgxx3_rk3566/MAINTAINERS b/board/anbernic/rgxx3_rk3566/MAINTAINERS
index 1c0d3fe7b5bf..6be16a47e8eb 100644
--- a/board/anbernic/rgxx3_rk3566/MAINTAINERS
+++ b/board/anbernic/rgxx3_rk3566/MAINTAINERS
@@ -4,3 +4,6 @@ S:	Maintained
 F:	board/anbernic/rgxx3_rk3566
 F:	include/configs/anbernic-rgxx3-rk3566.h
 F:	configs/anbernic-rgxx3_defconfig
+F:	arch/arm/dts/rk3566-anbernic-rgxx3.dts
+F:	arch/arm/dts/rk3566-anbernic-rgxx3.dtsi
+F:	arch/arm/dts/rk3566-anbernic-rgxx3-u-boot.dtsi
diff --git a/board/edgeble/neural-compute-module-6/MAINTAINERS b/board/edgeble/neural-compute-module-6/MAINTAINERS
index bc7f9b0e680d..42e5df506bf3 100644
--- a/board/edgeble/neural-compute-module-6/MAINTAINERS
+++ b/board/edgeble/neural-compute-module-6/MAINTAINERS
@@ -5,3 +5,9 @@ F:	board/edgeble/neural-compute-module-6
 F:	include/configs/neural-compute-module-6.h
 F:	configs/neu6a-io-rk3588_defconfig
 F:	configs/neu6b-io-rk3588_defconfig
+F:	arch/arm/dts/rk3588-edgeble-neu6a.dtsi
+F:	arch/arm/dts/rk3588-edgeble-neu6a-io.dts
+F:	arch/arm/dts/rk3588-edgeble-neu6a-io-u-boot.dtsi
+F:	arch/arm/dts/rk3588-edgeble-neu6b.dtsi
+F:	arch/arm/dts/rk3588-edgeble-neu6b-io.dts
+F:	arch/arm/dts/rk3588-edgeble-neu6b-io-u-boot.dtsi
diff --git a/board/radxa/rock5a-rk3588s/MAINTAINERS b/board/radxa/rock5a-rk3588s/MAINTAINERS
index 62fb6b4c0eea..05750269b8dd 100644
--- a/board/radxa/rock5a-rk3588s/MAINTAINERS
+++ b/board/radxa/rock5a-rk3588s/MAINTAINERS
@@ -4,3 +4,5 @@ S:	Maintained
 F:	board/radxa/rock5a-rk3588s
 F:	include/configs/rock5a-rk3588s.h
 F:	configs/rock5a-rk3588s_defconfig
+F:	arch/arm/dts/rk3588s-rock-5a.dts
+F:	arch/arm/dts/rk3588s-rock-5a-u-boot.dtsi
diff --git a/board/radxa/rock5b-rk3588/MAINTAINERS b/board/radxa/rock5b-rk3588/MAINTAINERS
index 693751e583d9..734115a4a3dc 100644
--- a/board/radxa/rock5b-rk3588/MAINTAINERS
+++ b/board/radxa/rock5b-rk3588/MAINTAINERS
@@ -2,5 +2,7 @@ ROCK5B-RK3588
 M:	Eugen Hristev <eugen.hristev@collabora.com>
 S:	Maintained
 F:	board/radxa/rock5b-rk3588
-F:	include/configs/rock5b-rk3588
+F:	include/configs/rock5b-rk3588.h
 F:	configs/rock5b-rk3588_defconfig
+F:	arch/arm/dts/rk3588-rock-5b.dts
+F:	arch/arm/dts/rk3588-rock-5b-u-boot.dtsi
diff --git a/board/rockchip/evb_rk3568/MAINTAINERS b/board/rockchip/evb_rk3568/MAINTAINERS
index 1cdeafcf79b2..5a2ec13e21ee 100644
--- a/board/rockchip/evb_rk3568/MAINTAINERS
+++ b/board/rockchip/evb_rk3568/MAINTAINERS
@@ -1,13 +1,13 @@
 EVB-RK3568
-M:      Joseph Chen <chenjh@rock-chips.com>
-S:      Maintained
-F:      board/rockchip/evb_rk3568
-F:      include/configs/evb_rk3568.h
-F:      configs/evb-rk3568_defconfig
-F:	arch/arm/dts/rk3568-evb-boot.dtsi
+M:	Joseph Chen <chenjh@rock-chips.com>
+S:	Maintained
+F:	board/rockchip/evb_rk3568
+F:	include/configs/evb_rk3568.h
+F:	configs/evb-rk3568_defconfig
+F:	arch/arm/dts/rk3568-evb-u-boot.dtsi
 F:	arch/arm/dts/rk3568-evb.dts
 
-Lubancat-2
+LUBANCAT-2
 M:	Andy Yan <andyshrk@163.com>
 S:	Maintained
 F:	configs/lubancat-2-rk3568_defconfig
@@ -15,24 +15,27 @@ F:	arch/arm/dts/rk3568-lubancat-2.dts
 F:	arch/arm/dts/rk3568-lubancat-2-u-boot.dtsi
 
 NANOPI-R5C
-M:      Tianling Shen <cnsztl@gmail.com>
-S:      Maintained
-F:      configs/nanopi-r5c-rk3568_defconfig
-F:      arch/arm/dts/rk3568-nanopi-r5c.dts
-F:      arch/arm/dts/rk3568-nanopi-r5c-u-boot.dtsi
+M:	Tianling Shen <cnsztl@gmail.com>
+S:	Maintained
+F:	configs/nanopi-r5c-rk3568_defconfig
+F:	arch/arm/dts/rk3568-nanopi-r5c.dts
+F:	arch/arm/dts/rk3568-nanopi-r5c-u-boot.dtsi
 
 NANOPI-R5S
-M:      Tianling Shen <cnsztl@gmail.com>
-S:      Maintained
-F:      configs/nanopi-r5s-rk3568_defconfig
-F:      arch/arm/dts/rk3568-nanopi-r5s.dts
-F:      arch/arm/dts/rk3568-nanopi-r5s.dtsi
-F:      arch/arm/dts/rk3568-nanopi-r5s-u-boot.dtsi
+M:	Tianling Shen <cnsztl@gmail.com>
+S:	Maintained
+F:	configs/nanopi-r5s-rk3568_defconfig
+F:	arch/arm/dts/rk3568-nanopi-r5s.dts
+F:	arch/arm/dts/rk3568-nanopi-r5s.dtsi
+F:	arch/arm/dts/rk3568-nanopi-r5s-u-boot.dtsi
 
-RADXA-CM3
+RADXA-CM3-IO
 M:	Jagan Teki <jagan@amarulasolutions.com>
 S:	Maintained
 F:	configs/radxa-cm3-io-rk3566_defconfig
+F:	arch/arm/dts/rk3566-radxa-cm3.dtsi
+F:	arch/arm/dts/rk3566-radxa-cm3-io.dts
+F:	arch/arm/dts/rk3566-radxa-cm3-io-u-boot.dtsi
 
 RADXA-E25
 M:	Jonas Karlman <jonas@kwiboo.se>
@@ -43,8 +46,8 @@ F:	arch/arm/dts/rk3568-radxa-e25.dts
 F:	arch/arm/dts/rk3568-radxa-e25-u-boot.dtsi
 
 ROCK-3A
-M:      Akash Gajjar <gajjar04akash@gmail.com>
-S:      Maintained
-F:      configs/rock-3a-rk3568_defconfig
-F:      arch/arm/dts/rk3568-rock-3a.dts
-F:      arch/arm/dts/rk3568-rock-3a-u-boot.dtsi
+M:	Akash Gajjar <gajjar04akash@gmail.com>
+S:	Maintained
+F:	configs/rock-3a-rk3568_defconfig
+F:	arch/arm/dts/rk3568-rock-3a.dts
+F:	arch/arm/dts/rk3568-rock-3a-u-boot.dtsi
diff --git a/board/rockchip/evb_rk3588/MAINTAINERS b/board/rockchip/evb_rk3588/MAINTAINERS
index 7b7df3c5a8ac..6b2c257a1705 100644
--- a/board/rockchip/evb_rk3588/MAINTAINERS
+++ b/board/rockchip/evb_rk3588/MAINTAINERS
@@ -4,4 +4,5 @@ S:	Maintained
 F:	board/rockchip/evb_rk3588
 F:	include/configs/evb_rk3588.h
 F:	configs/evb-rk3588_defconfig
-F:	arch/arm/dts/rk3588-evb-u-boot.dtsi
+F:	arch/arm/dts/rk3588-evb1-v10.dts
+F:	arch/arm/dts/rk3588-evb1-v10-u-boot.dtsi
-- 
2.41.0

