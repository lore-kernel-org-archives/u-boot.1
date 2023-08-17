Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22D1FC64EDA
	for <u-boot@archiver.kernel.org>; Thu, 17 Aug 2023 21:52:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5724486BE8;
	Thu, 17 Aug 2023 23:52:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kwiboo.se header.i=@kwiboo.se header.b="Y7Pixok5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C8F686BDD; Thu, 17 Aug 2023 23:52:52 +0200 (CEST)
Received: from s.wrqvtbkv.outbound-mail.sendgrid.net
 (s.wrqvtbkv.outbound-mail.sendgrid.net [149.72.123.24])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD4A486B9B
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 23:52:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kwiboo.se
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=bounces+31435339-7456-u-boot=lists.denx.de@em2124.kwiboo.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=from:subject:mime-version:to:cc:content-transfer-encoding:
 content-type:cc:content-type:from:subject:to;
 s=s1; bh=iqYkJ21X7HJiKnU76h5/au8JwBw5wy1aW0G3Htmht8c=;
 b=Y7Pixok5soxDt5AHnc3yEU4ryLZD0TT83GjFibtmqPWrPfkv7a228g08ZvhU2kk0pGD7
 LR3VCLcWNxaregDRqvzvvfOuagxMZQ/OBIZ9qbMWwxRgZ3V62wPVufEV7viSSyq9G5r0ZL
 C12xFl/QNvErPyuLE9Blvo0Tky3TFpAPbOY7BdvcGAu8rk8OzhN6Cv40yKg8bZNSCMF4Dd
 N17vxxA+gK7DHW1Ehcm4M/vV8PQvKBcrWEy7DC3jAewj89HLwwFZJz4FSgqT8653DBSqRZ
 4EU66jGVyrcmSRknljHTiBZjIMY5q6pcYmYPZMlIkHV8iaQF+Br9y2m6u7k7Q8Uw==
Received: by filterdrecv-canary-5685797b66-whj87 with SMTP id
 filterdrecv-canary-5685797b66-whj87-1-64DE96B0-5
 2023-08-17 21:52:48.167752323 +0000 UTC m=+8547409.941686180
Received: from bionic.localdomain (unknown) by geopod-ismtpd-6 (SG) with ESMTP
 id g6u-xv7NRZed8F08iws7lw Thu, 17 Aug 2023 21:52:47.848 +0000 (UTC)
From: Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH] rockchip: rk3566-anbernic-rgxx3: Rename defconfig to include
 SoC name
Date: Thu, 17 Aug 2023 21:52:48 +0000 (UTC)
Message-ID: <20230817215245.692612-1-jonas@kwiboo.se>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-SG-EID: =?us-ascii?Q?TdbjyGynYnRZWhH+7lKUQJL+ZxmxpowvO2O9SQF5CwCVrYgcwUXgU5DKUU3QxA?=
 =?us-ascii?Q?fZekEeQsTe+RrMu3cja6a0h3lTKEq=2FdXBJ8uNZP?=
 =?us-ascii?Q?tebUWAbXNZgMVogsMO1B4+uXShSaeIhlYupA7vK?=
 =?us-ascii?Q?hn3SPAluESmRHyJlwYGep5S87yBX9T2SfT3XFrQ?=
 =?us-ascii?Q?L0Wo=2FaqbI6+XL74SI4kV6+MGFkc9638oISfs+lS?=
 =?us-ascii?Q?ZXQFy2p1KG4eMZF6oS9ZysdepLPzUsDNkjUHdl?=
To: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Chris Morgan
 <macromorgan@hotmail.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, Jonas Karlman
 <jonas@kwiboo.se>
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

Rename defconfig to include SoC name, use similar pattern as other
RK356x boards: <soc>-<name>.dts -> <name>-<soc>_defconfig

Suggested-by: Kever Yang <kever.yang@rock-chips.com>
Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
 board/anbernic/rgxx3_rk3566/MAINTAINERS                         | 2 +-
 ...anbernic-rgxx3_defconfig => anbernic-rgxx3-rk3566_defconfig} | 0
 doc/board/rockchip/rockchip.rst                                 | 2 +-
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename configs/{anbernic-rgxx3_defconfig => anbernic-rgxx3-rk3566_defconfig} (100%)

diff --git a/board/anbernic/rgxx3_rk3566/MAINTAINERS b/board/anbernic/rgxx3_rk3566/MAINTAINERS
index 6be16a47e8eb..7970e5a4aad7 100644
--- a/board/anbernic/rgxx3_rk3566/MAINTAINERS
+++ b/board/anbernic/rgxx3_rk3566/MAINTAINERS
@@ -3,7 +3,7 @@ M:	Chris Morgan <macromorgan@hotmail.com>
 S:	Maintained
 F:	board/anbernic/rgxx3_rk3566
 F:	include/configs/anbernic-rgxx3-rk3566.h
-F:	configs/anbernic-rgxx3_defconfig
+F:	configs/anbernic-rgxx3-rk3566_defconfig
 F:	arch/arm/dts/rk3566-anbernic-rgxx3.dts
 F:	arch/arm/dts/rk3566-anbernic-rgxx3.dtsi
 F:	arch/arm/dts/rk3566-anbernic-rgxx3-u-boot.dtsi
diff --git a/configs/anbernic-rgxx3_defconfig b/configs/anbernic-rgxx3-rk3566_defconfig
similarity index 100%
rename from configs/anbernic-rgxx3_defconfig
rename to configs/anbernic-rgxx3-rk3566_defconfig
diff --git a/doc/board/rockchip/rockchip.rst b/doc/board/rockchip/rockchip.rst
index 4668e598515e..de9fe8e642b1 100644
--- a/doc/board/rockchip/rockchip.rst
+++ b/doc/board/rockchip/rockchip.rst
@@ -91,7 +91,7 @@ List of mainline supported Rockchip boards:
      - Theobroma Systems RK3399-Q7 SoM - Puma (puma_rk3399)
 
 * rk3566
-     - Anbernic RGxx3 (anbernic-rgxx3)
+     - Anbernic RGxx3 (anbernic-rgxx3-rk3566)
      - Pine64 Quartz64-A Board (quartz64-a-rk3566)
      - Pine64 Quartz64-B Board (quartz64-b-rk3566)
      - Pine64 SOQuartz on Blade (soquartz-blade-rk3566)
-- 
2.41.0

