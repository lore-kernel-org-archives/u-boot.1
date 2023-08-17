Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0B2CC2FC04
	for <u-boot@archiver.kernel.org>; Thu, 17 Aug 2023 06:05:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 538CB86A8B;
	Thu, 17 Aug 2023 08:04:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.b="nXlZ2b4c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4E90986A82; Thu, 17 Aug 2023 08:04:42 +0200 (CEST)
Received: from s.wrqvtbkv.outbound-mail.sendgrid.net
 (s.wrqvtbkv.outbound-mail.sendgrid.net [149.72.123.24])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8ED2186A45
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 08:04:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=bounces+31435339-7456-u-boot=lists.denx.de@em2124.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=from:subject:in-reply-to:references:mime-version:to:cc:
 content-transfer-encoding:content-type:cc:content-type:from:subject:to;
 s=s1; bh=YFCy2dk2F0Qp01tieuoJ2YXT9SPT3ucdStlTeIL+Wzg=;
 b=nXlZ2b4cNZ7nRfVjT2VrvSd5cnoCxiVrcCtfYNGpEiP2Ui/f2qbnvBncdTfoin1B/J3m
 NxXDkpRhtTcyJ8vsUCcdqTdJqvb3w9e7lXvl+bcJd3CCBsCsStxvLdSOEW5taJ5R39SR3m
 3mvSrsd+ieQrm6f6dgnA6K3RXxVyLbF16ZGQgRv3MUCD17iJMV8cX6K/j/wfre3STtySin
 bUkw/gX5MTEnw6fYy9JFMGc4hag0fdZVpDLIxYlWhqMW5bSODYX/PU0AymBYpzLsMHgeU7
 giwE2P7Dy93u+QV90VwvYHZfZYZzFkhip8IzACYNrcQpxdiBg3aQGKl3f3a555uA==
Received: by filterdrecv-77869f68cc-s89tm with SMTP id
 filterdrecv-77869f68cc-s89tm-1-64DDB875-79
 2023-08-17 06:04:37.957328145 +0000 UTC m=+8490508.073937351
Received: from bionic.localdomain (unknown) by geopod-ismtpd-8 (SG) with ESMTP
 id Yi3EXd1uS8icFHh3yQ0ujw Thu, 17 Aug 2023 06:04:37.735 +0000 (UTC)
From: Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH 3/3] board: rockchip: rk35xx: Add myself as reviewer to
 MAINTAINERS
Date: Thu, 17 Aug 2023 06:04:38 +0000 (UTC)
Message-ID: <20230817060422.477759-4-jonas@kwiboo.se>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230817060422.477759-1-jonas@kwiboo.se>
References: <20230817060422.477759-1-jonas@kwiboo.se>
MIME-Version: 1.0
X-SG-EID: =?us-ascii?Q?TdbjyGynYnRZWhH+7lKUQJL+ZxmxpowvO2O9SQF5CwCVrYgcwUXgU5DKUU3QxA?=
 =?us-ascii?Q?fZekEeQsTe+RrMu3cja6a0hxscLS1Cmoy8jDZCR?=
 =?us-ascii?Q?S4N8U3hbsLda8wSM5eONpVRpNruwoRnC8TEL+ph?=
 =?us-ascii?Q?2Ycz4HrzxKFL8Qm4LbMpqL9m4eOjb=2FG+GMhgUiO?=
 =?us-ascii?Q?90byDKJ5a7zSvz=2FgrL5DxWW=2FbqH8xTWI8xiOcNw?=
 =?us-ascii?Q?MsehvYrapd8U5qDvI0K4NXFSZvQLV3keoM2=2FjI?=
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Eugen Hristev
 <eugen.hristev@collabora.com>, Tianling Shen <cnsztl@gmail.com>, Jagan Teki
 <jagan@amarulasolutions.com>, Akash Gajjar <gajjar04akash@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>, Joseph Chen <chenjh@rock-chips.com>
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

Add myself as a reviewer for RK3566/RK3568/RK3588 boards that I have and
can help with review and testing of defconfig and device tree changes.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 board/radxa/rock5a-rk3588s/MAINTAINERS | 1 +
 board/radxa/rock5b-rk3588/MAINTAINERS  | 1 +
 board/rockchip/evb_rk3568/MAINTAINERS  | 4 ++++
 3 files changed, 6 insertions(+)

diff --git a/board/radxa/rock5a-rk3588s/MAINTAINERS b/board/radxa/rock5a-rk3588s/MAINTAINERS
index 05750269b8dd..a569efa74e3e 100644
--- a/board/radxa/rock5a-rk3588s/MAINTAINERS
+++ b/board/radxa/rock5a-rk3588s/MAINTAINERS
@@ -1,5 +1,6 @@
 ROCK5A-RK3588
 M:	Eugen Hristev <eugen.hristev@collabora.com>
+R:	Jonas Karlman <jonas@kwiboo.se>
 S:	Maintained
 F:	board/radxa/rock5a-rk3588s
 F:	include/configs/rock5a-rk3588s.h
diff --git a/board/radxa/rock5b-rk3588/MAINTAINERS b/board/radxa/rock5b-rk3588/MAINTAINERS
index 734115a4a3dc..4460c9971a96 100644
--- a/board/radxa/rock5b-rk3588/MAINTAINERS
+++ b/board/radxa/rock5b-rk3588/MAINTAINERS
@@ -1,5 +1,6 @@
 ROCK5B-RK3588
 M:	Eugen Hristev <eugen.hristev@collabora.com>
+R:	Jonas Karlman <jonas@kwiboo.se>
 S:	Maintained
 F:	board/radxa/rock5b-rk3588
 F:	include/configs/rock5b-rk3588.h
diff --git a/board/rockchip/evb_rk3568/MAINTAINERS b/board/rockchip/evb_rk3568/MAINTAINERS
index 5a2ec13e21ee..cc9eb432a8b5 100644
--- a/board/rockchip/evb_rk3568/MAINTAINERS
+++ b/board/rockchip/evb_rk3568/MAINTAINERS
@@ -16,6 +16,7 @@ F:	arch/arm/dts/rk3568-lubancat-2-u-boot.dtsi
 
 NANOPI-R5C
 M:	Tianling Shen <cnsztl@gmail.com>
+R:	Jonas Karlman <jonas@kwiboo.se>
 S:	Maintained
 F:	configs/nanopi-r5c-rk3568_defconfig
 F:	arch/arm/dts/rk3568-nanopi-r5c.dts
@@ -23,6 +24,7 @@ F:	arch/arm/dts/rk3568-nanopi-r5c-u-boot.dtsi
 
 NANOPI-R5S
 M:	Tianling Shen <cnsztl@gmail.com>
+R:	Jonas Karlman <jonas@kwiboo.se>
 S:	Maintained
 F:	configs/nanopi-r5s-rk3568_defconfig
 F:	arch/arm/dts/rk3568-nanopi-r5s.dts
@@ -31,6 +33,7 @@ F:	arch/arm/dts/rk3568-nanopi-r5s-u-boot.dtsi
 
 RADXA-CM3-IO
 M:	Jagan Teki <jagan@amarulasolutions.com>
+R:	Jonas Karlman <jonas@kwiboo.se>
 S:	Maintained
 F:	configs/radxa-cm3-io-rk3566_defconfig
 F:	arch/arm/dts/rk3566-radxa-cm3.dtsi
@@ -47,6 +50,7 @@ F:	arch/arm/dts/rk3568-radxa-e25-u-boot.dtsi
 
 ROCK-3A
 M:	Akash Gajjar <gajjar04akash@gmail.com>
+R:	Jonas Karlman <jonas@kwiboo.se>
 S:	Maintained
 F:	configs/rock-3a-rk3568_defconfig
 F:	arch/arm/dts/rk3568-rock-3a.dts
-- 
2.41.0

