Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D7C9C54E60
	for <u-boot@archiver.kernel.org>; Sun, 17 Mar 2024 06:24:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF41287D09;
	Sun, 17 Mar 2024 07:24:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="ruU/bjjd";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="kN0enRP/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D8AC87EDD; Sun, 17 Mar 2024 07:24:22 +0100 (CET)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org
 [IPv6:2001:67c:2050:0:465::201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3FD8887A0E
 for <u-boot@lists.denx.de>; Sun, 17 Mar 2024 07:24:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4Ty7HP642Kz9srt;
 Sun, 17 Mar 2024 07:24:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1710656657;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=xGg97k1E/Po0Gmd/X+0kDHLoz0UgV5g0LenfDEUeDS8=;
 b=ruU/bjjd5d6mDKwBtbBmR79QGkP5XLZ1dhEsuAaZsknBMSmM4ajmgBq5EkfSgOptJa8sCB
 gD9aLbATQFGn80s1FOuMJKKONGKrgHdN32vukPVRSP9IXb3pjvyJn0O+xqSp48A2jJNtRn
 4hsuEOL1L8+nLzN7hBvzqDctbETNcZSTOV1qCEK7q9po4nZul0CUQ31sb6XPNVPbDKvGWg
 6B0EunpHOGB3jaUzRAEyVcRY8ORSxZSTlhsvUa7ilAz/nMQJxL4liQLuzjXM9elEo5km2x
 C2F5ED/366OJ1XGc4Q38BvRQNIVU5SSyzVaruAudjAYcT7rU+76FHAi+3v4OnQ==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1710656656;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=xGg97k1E/Po0Gmd/X+0kDHLoz0UgV5g0LenfDEUeDS8=;
 b=kN0enRP/YVGDkJCdvtmnw/tu0bdaIflDaipWIq/O9PNdki1xHA2loDrICzuK0eQIB5wq4H
 MlSRe20q5LxP6j+q4Er86dsuh3VKVXrWKoyK60WowPkWQ6mYkLJWZ+KDQCNiAiB0DjNZ1B
 BoYQxTApING4BaGQATz5iGAnZWUJKjgq4StauAP3AIm7MiI0XPW+BLDxptVfSXxeSxCRF3
 nEPP18z5Pje47ycTua68XPMli+pQt6kElvMG6H7hBvjkoVrT50JVLX1U2eibvSuhPnyOyS
 hNjD1sjfVcUVwlxigxvKMCUEjlxhWJ/tslvUZyp+0I4rVsO/egjE3bYKtRh4lg==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Adam Ford <aford173@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Ralph Siemsen <ralph.siemsen@linaro.org>
Subject: [PATCH] ARM: dts: renesas: Stop using the -u-boot DTs for build
Date: Sun, 17 Mar 2024 07:23:38 +0100
Message-ID: <20240317062353.655840-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 9759c29d1c645fc11ff
X-MBO-RS-META: ys3x1tcfu5qexzfxm1czy4bnkgpij18a
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

The U-Boot build system can automatically paste -u-boot.dtsi at the
end of matching .dts during build. Stop emulating this behavior and
rename the -u-boot.dts files to -u-boot.dtsi, drop "#include...dts"
from those new u-boot.dtsi files, and update board configuration
accordingly.

The rename, '#include...dts` scrubbing and configuration update has
been done using the following script:
```
$ find . -name r[78]\*-u-boot.dts | sort -u | while read line ; do \
  git mv ${line%-u-boot.dts}-u-boot.dts ${line%-u-boot.dts}-u-boot.dtsi ; \
  done
$ sed -i '/^#include.*dts"/ d' `find . -name r[78]\*-u-boot.dtsi`
$ sed -i 's@-u-boot@@g' `git grep -li renesas configs`
```
The Salvator-X and ULCB board files have been updated manually.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Adam Ford <aford173@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Ralph Siemsen <ralph.siemsen@linaro.org>
---
 arch/arm/dts/Makefile                         | 58 +++++++++----------
 ...boot.dts => r7s72100-gr-peach-u-boot.dtsi} |  1 -
 ....dts => r8a774a1-hihope-rzg2m-u-boot.dtsi} |  1 -
 ....dts => r8a774b1-hihope-rzg2n-u-boot.dtsi} |  1 -
 ...-u-boot.dts => r8a774c0-ek874-u-boot.dtsi} |  1 -
 ....dts => r8a774e1-hihope-rzg2h-u-boot.dtsi} |  1 -
 ...r-u-boot.dts => r8a7790-lager-u-boot.dtsi} |  1 -
 ...t-u-boot.dts => r8a7790-stout-u-boot.dtsi} |  1 -
 ...u-boot.dts => r8a7791-koelsch-u-boot.dtsi} |  1 -
 ...-u-boot.dts => r8a7791-porter-u-boot.dtsi} |  1 -
 ...u-boot.dts => r8a7792-blanche-u-boot.dtsi} |  1 -
 ...se-u-boot.dts => r8a7793-gose-u-boot.dtsi} |  1 -
 ...alt-u-boot.dts => r8a7794-alt-u-boot.dtsi} |  1 -
 ...lk-u-boot.dts => r8a7794-silk-u-boot.dtsi} |  1 -
 ...ot.dts => r8a77950-salvator-x-u-boot.dtsi} |  1 -
 ...b-u-boot.dts => r8a77950-ulcb-u-boot.dtsi} |  1 -
 ...ot.dts => r8a77960-salvator-x-u-boot.dtsi} |  1 -
 ...b-u-boot.dts => r8a77960-ulcb-u-boot.dtsi} |  1 -
 ...ot.dts => r8a77965-salvator-x-u-boot.dtsi} |  1 -
 ...b-u-boot.dts => r8a77965-ulcb-u-boot.dtsi} |  1 -
 ...-u-boot.dts => r8a77970-eagle-u-boot.dtsi} |  1 -
 ...-u-boot.dts => r8a77970-v3msk-u-boot.dtsi} |  1 -
 ...u-boot.dts => r8a77980-condor-u-boot.dtsi} |  1 -
 ...-u-boot.dts => r8a77980-v3hsk-u-boot.dtsi} |  1 -
 ...-u-boot.dts => r8a77990-ebisu-u-boot.dtsi} |  1 -
 ...-u-boot.dts => r8a77995-draak-u-boot.dtsi} |  1 -
 ...u-boot.dts => r8a779a0-falcon-u-boot.dtsi} |  1 -
 ...u-boot.dts => r8a779f0-spider-u-boot.dtsi} |  1 -
 ...ot.dts => r8a779g0-white-hawk-u-boot.dtsi} |  1 -
 ...oot.dts => r8a779h0-gray-hawk-u-boot.dtsi} |  1 -
 board/renesas/salvator-x/salvator-x.c         |  6 +-
 board/renesas/ulcb/ulcb.c                     |  6 +-
 configs/alt_defconfig                         |  2 +-
 configs/blanche_defconfig                     |  2 +-
 configs/gose_defconfig                        |  2 +-
 configs/grpeach_defconfig                     |  2 +-
 configs/hihope_rzg2_defconfig                 |  4 +-
 configs/koelsch_defconfig                     |  2 +-
 configs/lager_defconfig                       |  2 +-
 configs/porter_defconfig                      |  2 +-
 configs/r8a77970_eagle_defconfig              |  2 +-
 configs/r8a77970_v3msk_defconfig              |  2 +-
 configs/r8a77980_condor_defconfig             |  2 +-
 configs/r8a77980_v3hsk_defconfig              |  2 +-
 configs/r8a77990_ebisu_defconfig              |  2 +-
 configs/r8a77995_draak_defconfig              |  2 +-
 configs/r8a779a0_falcon_defconfig             |  2 +-
 configs/r8a779f0_spider_defconfig             |  2 +-
 configs/r8a779g0_whitehawk_defconfig          |  2 +-
 configs/r8a779h0_grayhawk_defconfig           |  2 +-
 configs/rcar3_salvator-x_defconfig            |  4 +-
 configs/rcar3_ulcb_defconfig                  |  4 +-
 configs/silinux_ek874_defconfig               |  2 +-
 configs/silk_defconfig                        |  2 +-
 configs/stout_defconfig                       |  2 +-
 55 files changed, 61 insertions(+), 90 deletions(-)
 rename arch/arm/dts/{r7s72100-gr-peach-u-boot.dts => r7s72100-gr-peach-u-boot.dtsi} (97%)
 rename arch/arm/dts/{r8a774a1-hihope-rzg2m-u-boot.dts => r8a774a1-hihope-rzg2m-u-boot.dtsi} (91%)
 rename arch/arm/dts/{r8a774b1-hihope-rzg2n-u-boot.dts => r8a774b1-hihope-rzg2n-u-boot.dtsi} (91%)
 rename arch/arm/dts/{r8a774c0-ek874-u-boot.dts => r8a774c0-ek874-u-boot.dtsi} (95%)
 rename arch/arm/dts/{r8a774e1-hihope-rzg2h-u-boot.dts => r8a774e1-hihope-rzg2h-u-boot.dtsi} (91%)
 rename arch/arm/dts/{r8a7790-lager-u-boot.dts => r8a7790-lager-u-boot.dtsi} (91%)
 rename arch/arm/dts/{r8a7790-stout-u-boot.dts => r8a7790-stout-u-boot.dtsi} (91%)
 rename arch/arm/dts/{r8a7791-koelsch-u-boot.dts => r8a7791-koelsch-u-boot.dtsi} (90%)
 rename arch/arm/dts/{r8a7791-porter-u-boot.dts => r8a7791-porter-u-boot.dtsi} (92%)
 rename arch/arm/dts/{r8a7792-blanche-u-boot.dts => r8a7792-blanche-u-boot.dtsi} (89%)
 rename arch/arm/dts/{r8a7793-gose-u-boot.dts => r8a7793-gose-u-boot.dtsi} (91%)
 rename arch/arm/dts/{r8a7794-alt-u-boot.dts => r8a7794-alt-u-boot.dtsi} (96%)
 rename arch/arm/dts/{r8a7794-silk-u-boot.dts => r8a7794-silk-u-boot.dtsi} (91%)
 rename arch/arm/dts/{r8a77950-salvator-x-u-boot.dts => r8a77950-salvator-x-u-boot.dtsi} (96%)
 rename arch/arm/dts/{r8a77950-ulcb-u-boot.dts => r8a77950-ulcb-u-boot.dtsi} (97%)
 rename arch/arm/dts/{r8a77960-salvator-x-u-boot.dts => r8a77960-salvator-x-u-boot.dtsi} (96%)
 rename arch/arm/dts/{r8a77960-ulcb-u-boot.dts => r8a77960-ulcb-u-boot.dtsi} (97%)
 rename arch/arm/dts/{r8a77965-salvator-x-u-boot.dts => r8a77965-salvator-x-u-boot.dtsi} (96%)
 rename arch/arm/dts/{r8a77965-ulcb-u-boot.dts => r8a77965-ulcb-u-boot.dtsi} (97%)
 rename arch/arm/dts/{r8a77970-eagle-u-boot.dts => r8a77970-eagle-u-boot.dtsi} (96%)
 rename arch/arm/dts/{r8a77970-v3msk-u-boot.dts => r8a77970-v3msk-u-boot.dtsi} (97%)
 rename arch/arm/dts/{r8a77980-condor-u-boot.dts => r8a77980-condor-u-boot.dtsi} (96%)
 rename arch/arm/dts/{r8a77980-v3hsk-u-boot.dts => r8a77980-v3hsk-u-boot.dtsi} (95%)
 rename arch/arm/dts/{r8a77990-ebisu-u-boot.dts => r8a77990-ebisu-u-boot.dtsi} (97%)
 rename arch/arm/dts/{r8a77995-draak-u-boot.dts => r8a77995-draak-u-boot.dtsi} (94%)
 rename arch/arm/dts/{r8a779a0-falcon-u-boot.dts => r8a779a0-falcon-u-boot.dtsi} (94%)
 rename arch/arm/dts/{r8a779f0-spider-u-boot.dts => r8a779f0-spider-u-boot.dtsi} (95%)
 rename arch/arm/dts/{r8a779g0-white-hawk-u-boot.dts => r8a779g0-white-hawk-u-boot.dtsi} (95%)
 rename arch/arm/dts/{r8a779h0-gray-hawk-u-boot.dts => r8a779h0-gray-hawk-u-boot.dtsi} (95%)

diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
index dabd3b91859..b6da94ab04b 100644
--- a/arch/arm/dts/Makefile
+++ b/arch/arm/dts/Makefile
@@ -1140,41 +1140,41 @@ dtb-$(CONFIG_ARCH_IMXRT) += imxrt1050-evk.dtb \
 	imxrt1170-evk.dtb \
 
 dtb-$(CONFIG_RCAR_GEN2) += \
-	r8a7790-lager-u-boot.dtb \
-	r8a7790-stout-u-boot.dtb \
-	r8a7791-koelsch-u-boot.dtb \
-	r8a7791-porter-u-boot.dtb \
-	r8a7792-blanche-u-boot.dtb \
-	r8a7793-gose-u-boot.dtb \
-	r8a7794-alt-u-boot.dtb \
-	r8a7794-silk-u-boot.dtb
+	r8a7790-lager.dtb \
+	r8a7790-stout.dtb \
+	r8a7791-koelsch.dtb \
+	r8a7791-porter.dtb \
+	r8a7792-blanche.dtb \
+	r8a7793-gose.dtb \
+	r8a7794-alt.dtb \
+	r8a7794-silk.dtb
 
 dtb-$(CONFIG_RCAR_GEN3) += \
 	r8a774a1-beacon-rzg2m-kit.dtb \
 	r8a774b1-beacon-rzg2n-kit.dtb \
 	r8a774e1-beacon-rzg2h-kit.dtb \
-	r8a774a1-hihope-rzg2m-u-boot.dtb \
-	r8a774b1-hihope-rzg2n-u-boot.dtb \
-	r8a774c0-ek874-u-boot.dtb \
-	r8a774e1-hihope-rzg2h-u-boot.dtb \
-	r8a77950-ulcb-u-boot.dtb \
-	r8a77950-salvator-x-u-boot.dtb \
-	r8a77960-ulcb-u-boot.dtb \
-	r8a77960-salvator-x-u-boot.dtb \
-	r8a77965-ulcb-u-boot.dtb \
-	r8a77965-salvator-x-u-boot.dtb \
-	r8a77970-eagle-u-boot.dtb \
-	r8a77970-v3msk-u-boot.dtb \
-	r8a77980-condor-u-boot.dtb \
-	r8a77980-v3hsk-u-boot.dtb \
-	r8a77990-ebisu-u-boot.dtb \
-	r8a77995-draak-u-boot.dtb
+	r8a774a1-hihope-rzg2m.dtb \
+	r8a774b1-hihope-rzg2n.dtb \
+	r8a774c0-ek874.dtb \
+	r8a774e1-hihope-rzg2h.dtb \
+	r8a77950-ulcb.dtb \
+	r8a77950-salvator-x.dtb \
+	r8a77960-ulcb.dtb \
+	r8a77960-salvator-x.dtb \
+	r8a77965-ulcb.dtb \
+	r8a77965-salvator-x.dtb \
+	r8a77970-eagle.dtb \
+	r8a77970-v3msk.dtb \
+	r8a77980-condor.dtb \
+	r8a77980-v3hsk.dtb \
+	r8a77990-ebisu.dtb \
+	r8a77995-draak.dtb
 
 dtb-$(CONFIG_RCAR_GEN4) += \
-	r8a779a0-falcon-u-boot.dtb \
-	r8a779f0-spider-u-boot.dtb \
-	r8a779g0-white-hawk-u-boot.dtb \
-	r8a779h0-gray-hawk-u-boot.dtb
+	r8a779a0-falcon.dtb \
+	r8a779f0-spider.dtb \
+	r8a779g0-white-hawk.dtb \
+	r8a779h0-gray-hawk.dtb
 
 dtb-$(CONFIG_TARGET_RZG2L) += \
 	r9a07g044l2-smarc.dts
@@ -1184,7 +1184,7 @@ DTC_FLAGS += -R 4 -p 0x1000
 endif
 
 dtb-$(CONFIG_RZA1) += \
-	r7s72100-gr-peach-u-boot.dtb
+	r7s72100-gr-peach.dtb
 
 dtb-$(CONFIG_ARCH_KEYSTONE) += keystone-k2hk-evm.dtb \
 	keystone-k2l-evm.dtb \
diff --git a/arch/arm/dts/r7s72100-gr-peach-u-boot.dts b/arch/arm/dts/r7s72100-gr-peach-u-boot.dtsi
similarity index 97%
rename from arch/arm/dts/r7s72100-gr-peach-u-boot.dts
rename to arch/arm/dts/r7s72100-gr-peach-u-boot.dtsi
index 0ae9f91fbe8..34fba29e859 100644
--- a/arch/arm/dts/r7s72100-gr-peach-u-boot.dts
+++ b/arch/arm/dts/r7s72100-gr-peach-u-boot.dtsi
@@ -5,7 +5,6 @@
  * Copyright (C) 2019 Marek Vasut <marek.vasut@gmail.com>
  */
 
-#include "r7s72100-gr-peach.dts"
 
 / {
 	aliases {
diff --git a/arch/arm/dts/r8a774a1-hihope-rzg2m-u-boot.dts b/arch/arm/dts/r8a774a1-hihope-rzg2m-u-boot.dtsi
similarity index 91%
rename from arch/arm/dts/r8a774a1-hihope-rzg2m-u-boot.dts
rename to arch/arm/dts/r8a774a1-hihope-rzg2m-u-boot.dtsi
index b735e972214..3ad619bdb90 100644
--- a/arch/arm/dts/r8a774a1-hihope-rzg2m-u-boot.dts
+++ b/arch/arm/dts/r8a774a1-hihope-rzg2m-u-boot.dtsi
@@ -5,7 +5,6 @@
  * Copyright (C) 2021 Renesas Electronics Corporation
  */
 
-#include "r8a774a1-hihope-rzg2m-ex.dts"
 #include "r8a774a1-u-boot.dtsi"
 
 &gpio3 {
diff --git a/arch/arm/dts/r8a774b1-hihope-rzg2n-u-boot.dts b/arch/arm/dts/r8a774b1-hihope-rzg2n-u-boot.dtsi
similarity index 91%
rename from arch/arm/dts/r8a774b1-hihope-rzg2n-u-boot.dts
rename to arch/arm/dts/r8a774b1-hihope-rzg2n-u-boot.dtsi
index 0bdc6909bfb..6f2f6c71c2f 100644
--- a/arch/arm/dts/r8a774b1-hihope-rzg2n-u-boot.dts
+++ b/arch/arm/dts/r8a774b1-hihope-rzg2n-u-boot.dtsi
@@ -5,7 +5,6 @@
  * Copyright (C) 2021 Renesas Electronics Corp.
  */
 
-#include "r8a774b1-hihope-rzg2n-ex.dts"
 #include "r8a774b1-u-boot.dtsi"
 
 &gpio3 {
diff --git a/arch/arm/dts/r8a774c0-ek874-u-boot.dts b/arch/arm/dts/r8a774c0-ek874-u-boot.dtsi
similarity index 95%
rename from arch/arm/dts/r8a774c0-ek874-u-boot.dts
rename to arch/arm/dts/r8a774c0-ek874-u-boot.dtsi
index 8fa6d8074b3..dcdddd9aed6 100644
--- a/arch/arm/dts/r8a774c0-ek874-u-boot.dts
+++ b/arch/arm/dts/r8a774c0-ek874-u-boot.dtsi
@@ -5,7 +5,6 @@
  * Copyright (C) 2021 Renesas Electronisc Corporation
  */
 
-#include "r8a774c0-ek874.dts"
 #include "r8a774c0-u-boot.dtsi"
 
 / {
diff --git a/arch/arm/dts/r8a774e1-hihope-rzg2h-u-boot.dts b/arch/arm/dts/r8a774e1-hihope-rzg2h-u-boot.dtsi
similarity index 91%
rename from arch/arm/dts/r8a774e1-hihope-rzg2h-u-boot.dts
rename to arch/arm/dts/r8a774e1-hihope-rzg2h-u-boot.dtsi
index 03a17bac7ec..8e57e03c899 100644
--- a/arch/arm/dts/r8a774e1-hihope-rzg2h-u-boot.dts
+++ b/arch/arm/dts/r8a774e1-hihope-rzg2h-u-boot.dtsi
@@ -5,7 +5,6 @@
  * Copyright (C) 2020 Renesas Electronics Corp.
  */
 
-#include "r8a774e1-hihope-rzg2h-ex.dts"
 #include "r8a774e1-u-boot.dtsi"
 
 &gpio3 {
diff --git a/arch/arm/dts/r8a7790-lager-u-boot.dts b/arch/arm/dts/r8a7790-lager-u-boot.dtsi
similarity index 91%
rename from arch/arm/dts/r8a7790-lager-u-boot.dts
rename to arch/arm/dts/r8a7790-lager-u-boot.dtsi
index 28b8b604c37..ed1891706ce 100644
--- a/arch/arm/dts/r8a7790-lager-u-boot.dts
+++ b/arch/arm/dts/r8a7790-lager-u-boot.dtsi
@@ -5,7 +5,6 @@
  * Copyright (C) 2018 Marek Vasut <marek.vasut@gmail.com>
  */
 
-#include "r8a7790-lager.dts"
 #include "r8a7790-u-boot.dtsi"
 
 &scif0 {
diff --git a/arch/arm/dts/r8a7790-stout-u-boot.dts b/arch/arm/dts/r8a7790-stout-u-boot.dtsi
similarity index 91%
rename from arch/arm/dts/r8a7790-stout-u-boot.dts
rename to arch/arm/dts/r8a7790-stout-u-boot.dtsi
index 85bcb787613..3b393045e36 100644
--- a/arch/arm/dts/r8a7790-stout-u-boot.dts
+++ b/arch/arm/dts/r8a7790-stout-u-boot.dtsi
@@ -5,7 +5,6 @@
  * Copyright (C) 2018 Marek Vasut <marek.vasut@gmail.com>
  */
 
-#include "r8a7790-stout.dts"
 #include "r8a7790-u-boot.dtsi"
 
 &scifa0 {
diff --git a/arch/arm/dts/r8a7791-koelsch-u-boot.dts b/arch/arm/dts/r8a7791-koelsch-u-boot.dtsi
similarity index 90%
rename from arch/arm/dts/r8a7791-koelsch-u-boot.dts
rename to arch/arm/dts/r8a7791-koelsch-u-boot.dtsi
index c5a1332131d..541c4191d69 100644
--- a/arch/arm/dts/r8a7791-koelsch-u-boot.dts
+++ b/arch/arm/dts/r8a7791-koelsch-u-boot.dtsi
@@ -5,7 +5,6 @@
  * Copyright (C) 2018 Marek Vasut <marek.vasut@gmail.com>
  */
 
-#include "r8a7791-koelsch.dts"
 #include "r8a7791-u-boot.dtsi"
 
 &scif0 {
diff --git a/arch/arm/dts/r8a7791-porter-u-boot.dts b/arch/arm/dts/r8a7791-porter-u-boot.dtsi
similarity index 92%
rename from arch/arm/dts/r8a7791-porter-u-boot.dts
rename to arch/arm/dts/r8a7791-porter-u-boot.dtsi
index bfec1fc6d62..cbf2c5265d8 100644
--- a/arch/arm/dts/r8a7791-porter-u-boot.dts
+++ b/arch/arm/dts/r8a7791-porter-u-boot.dtsi
@@ -5,7 +5,6 @@
  * Copyright (C) 2018 Marek Vasut <marek.vasut@gmail.com>
  */
 
-#include "r8a7791-porter.dts"
 #include "r8a7791-u-boot.dtsi"
 
 &scif0 {
diff --git a/arch/arm/dts/r8a7792-blanche-u-boot.dts b/arch/arm/dts/r8a7792-blanche-u-boot.dtsi
similarity index 89%
rename from arch/arm/dts/r8a7792-blanche-u-boot.dts
rename to arch/arm/dts/r8a7792-blanche-u-boot.dtsi
index 1f33df81cef..8c36a3e5850 100644
--- a/arch/arm/dts/r8a7792-blanche-u-boot.dts
+++ b/arch/arm/dts/r8a7792-blanche-u-boot.dtsi
@@ -5,7 +5,6 @@
  * Copyright (C) 2018 Marek Vasut <marek.vasut@gmail.com>
  */
 
-#include "r8a7792-blanche.dts"
 #include "r8a7792-u-boot.dtsi"
 
 &iic3 {
diff --git a/arch/arm/dts/r8a7793-gose-u-boot.dts b/arch/arm/dts/r8a7793-gose-u-boot.dtsi
similarity index 91%
rename from arch/arm/dts/r8a7793-gose-u-boot.dts
rename to arch/arm/dts/r8a7793-gose-u-boot.dtsi
index dd0932ceca9..41c4361c6e1 100644
--- a/arch/arm/dts/r8a7793-gose-u-boot.dts
+++ b/arch/arm/dts/r8a7793-gose-u-boot.dtsi
@@ -5,7 +5,6 @@
  * Copyright (C) 2018 Marek Vasut <marek.vasut@gmail.com>
  */
 
-#include "r8a7793-gose.dts"
 #include "r8a7793-u-boot.dtsi"
 
 &scif0 {
diff --git a/arch/arm/dts/r8a7794-alt-u-boot.dts b/arch/arm/dts/r8a7794-alt-u-boot.dtsi
similarity index 96%
rename from arch/arm/dts/r8a7794-alt-u-boot.dts
rename to arch/arm/dts/r8a7794-alt-u-boot.dtsi
index 0a39039fc97..e156b4c93c7 100644
--- a/arch/arm/dts/r8a7794-alt-u-boot.dts
+++ b/arch/arm/dts/r8a7794-alt-u-boot.dtsi
@@ -5,7 +5,6 @@
  * Copyright (C) 2018 Marek Vasut <marek.vasut@gmail.com>
  */
 
-#include "r8a7794-alt.dts"
 #include "r8a7794-u-boot.dtsi"
 
 &i2c7 {
diff --git a/arch/arm/dts/r8a7794-silk-u-boot.dts b/arch/arm/dts/r8a7794-silk-u-boot.dtsi
similarity index 91%
rename from arch/arm/dts/r8a7794-silk-u-boot.dts
rename to arch/arm/dts/r8a7794-silk-u-boot.dtsi
index 3fcb535a3ac..e448ea7e146 100644
--- a/arch/arm/dts/r8a7794-silk-u-boot.dts
+++ b/arch/arm/dts/r8a7794-silk-u-boot.dtsi
@@ -5,7 +5,6 @@
  * Copyright (C) 2018 Marek Vasut <marek.vasut@gmail.com>
  */
 
-#include "r8a7794-silk.dts"
 #include "r8a7794-u-boot.dtsi"
 
 &scif2 {
diff --git a/arch/arm/dts/r8a77950-salvator-x-u-boot.dts b/arch/arm/dts/r8a77950-salvator-x-u-boot.dtsi
similarity index 96%
rename from arch/arm/dts/r8a77950-salvator-x-u-boot.dts
rename to arch/arm/dts/r8a77950-salvator-x-u-boot.dtsi
index ba7cf521d0d..23f12543746 100644
--- a/arch/arm/dts/r8a77950-salvator-x-u-boot.dts
+++ b/arch/arm/dts/r8a77950-salvator-x-u-boot.dtsi
@@ -5,7 +5,6 @@
  * Copyright (C) 2018 Marek Vasut <marek.vasut@gmail.com>
  */
 
-#include "r8a77950-salvator-x.dts"
 #include "r8a77950-u-boot.dtsi"
 
 / {
diff --git a/arch/arm/dts/r8a77950-ulcb-u-boot.dts b/arch/arm/dts/r8a77950-ulcb-u-boot.dtsi
similarity index 97%
rename from arch/arm/dts/r8a77950-ulcb-u-boot.dts
rename to arch/arm/dts/r8a77950-ulcb-u-boot.dtsi
index e371cde349f..c65c2e6406d 100644
--- a/arch/arm/dts/r8a77950-ulcb-u-boot.dts
+++ b/arch/arm/dts/r8a77950-ulcb-u-boot.dtsi
@@ -5,7 +5,6 @@
  * Copyright (C) 2018 Marek Vasut <marek.vasut@gmail.com>
  */
 
-#include "r8a77950-ulcb.dts"
 #include "r8a77950-u-boot.dtsi"
 
 / {
diff --git a/arch/arm/dts/r8a77960-salvator-x-u-boot.dts b/arch/arm/dts/r8a77960-salvator-x-u-boot.dtsi
similarity index 96%
rename from arch/arm/dts/r8a77960-salvator-x-u-boot.dts
rename to arch/arm/dts/r8a77960-salvator-x-u-boot.dtsi
index 2a9f0aa2180..84a28bf885c 100644
--- a/arch/arm/dts/r8a77960-salvator-x-u-boot.dts
+++ b/arch/arm/dts/r8a77960-salvator-x-u-boot.dtsi
@@ -5,7 +5,6 @@
  * Copyright (C) 2018 Marek Vasut <marek.vasut@gmail.com>
  */
 
-#include "r8a77960-salvator-x.dts"
 #include "r8a77960-u-boot.dtsi"
 
 / {
diff --git a/arch/arm/dts/r8a77960-ulcb-u-boot.dts b/arch/arm/dts/r8a77960-ulcb-u-boot.dtsi
similarity index 97%
rename from arch/arm/dts/r8a77960-ulcb-u-boot.dts
rename to arch/arm/dts/r8a77960-ulcb-u-boot.dtsi
index 79042b20852..6372f953956 100644
--- a/arch/arm/dts/r8a77960-ulcb-u-boot.dts
+++ b/arch/arm/dts/r8a77960-ulcb-u-boot.dtsi
@@ -5,7 +5,6 @@
  * Copyright (C) 2018 Marek Vasut <marek.vasut@gmail.com>
  */
 
-#include "r8a77960-ulcb.dts"
 #include "r8a77960-u-boot.dtsi"
 
 / {
diff --git a/arch/arm/dts/r8a77965-salvator-x-u-boot.dts b/arch/arm/dts/r8a77965-salvator-x-u-boot.dtsi
similarity index 96%
rename from arch/arm/dts/r8a77965-salvator-x-u-boot.dts
rename to arch/arm/dts/r8a77965-salvator-x-u-boot.dtsi
index e5421f9ca8f..d9a28fe9bab 100644
--- a/arch/arm/dts/r8a77965-salvator-x-u-boot.dts
+++ b/arch/arm/dts/r8a77965-salvator-x-u-boot.dtsi
@@ -5,7 +5,6 @@
  * Copyright (C) 2018 Marek Vasut <marek.vasut@gmail.com>
  */
 
-#include "r8a77965-salvator-x.dts"
 #include "r8a77965-u-boot.dtsi"
 
 / {
diff --git a/arch/arm/dts/r8a77965-ulcb-u-boot.dts b/arch/arm/dts/r8a77965-ulcb-u-boot.dtsi
similarity index 97%
rename from arch/arm/dts/r8a77965-ulcb-u-boot.dts
rename to arch/arm/dts/r8a77965-ulcb-u-boot.dtsi
index 969911d89ce..aa5de3d0465 100644
--- a/arch/arm/dts/r8a77965-ulcb-u-boot.dts
+++ b/arch/arm/dts/r8a77965-ulcb-u-boot.dtsi
@@ -5,7 +5,6 @@
  * Copyright (C) 2018 Marek Vasut <marek.vasut@gmail.com>
  */
 
-#include "r8a77965-ulcb.dts"
 #include "r8a77965-u-boot.dtsi"
 
 / {
diff --git a/arch/arm/dts/r8a77970-eagle-u-boot.dts b/arch/arm/dts/r8a77970-eagle-u-boot.dtsi
similarity index 96%
rename from arch/arm/dts/r8a77970-eagle-u-boot.dts
rename to arch/arm/dts/r8a77970-eagle-u-boot.dtsi
index eb868eda414..c7971b9e9ce 100644
--- a/arch/arm/dts/r8a77970-eagle-u-boot.dts
+++ b/arch/arm/dts/r8a77970-eagle-u-boot.dtsi
@@ -5,7 +5,6 @@
  * Copyright (C) 2018 Marek Vasut <marek.vasut@gmail.com>
  */
 
-#include "r8a77970-eagle.dts"
 #include "r8a77970-u-boot.dtsi"
 #include <dt-bindings/gpio/gpio.h>
 
diff --git a/arch/arm/dts/r8a77970-v3msk-u-boot.dts b/arch/arm/dts/r8a77970-v3msk-u-boot.dtsi
similarity index 97%
rename from arch/arm/dts/r8a77970-v3msk-u-boot.dts
rename to arch/arm/dts/r8a77970-v3msk-u-boot.dtsi
index 6ee06d7c000..c7b2e07793d 100644
--- a/arch/arm/dts/r8a77970-v3msk-u-boot.dts
+++ b/arch/arm/dts/r8a77970-v3msk-u-boot.dtsi
@@ -5,7 +5,6 @@
  * Copyright (C) 2019 Cogent Embedded, Inc.
  */
 
-#include "r8a77970-v3msk.dts"
 #include "r8a77970-u-boot.dtsi"
 #include <dt-bindings/gpio/gpio.h>
 
diff --git a/arch/arm/dts/r8a77980-condor-u-boot.dts b/arch/arm/dts/r8a77980-condor-u-boot.dtsi
similarity index 96%
rename from arch/arm/dts/r8a77980-condor-u-boot.dts
rename to arch/arm/dts/r8a77980-condor-u-boot.dtsi
index f4a3b43b8ff..34a735ae5b2 100644
--- a/arch/arm/dts/r8a77980-condor-u-boot.dts
+++ b/arch/arm/dts/r8a77980-condor-u-boot.dtsi
@@ -5,7 +5,6 @@
  * Copyright (C) 2019 Marek Vasut <marek.vasut@gmail.com>
  */
 
-#include "r8a77980-condor.dts"
 #include "r8a77980-u-boot.dtsi"
 
 / {
diff --git a/arch/arm/dts/r8a77980-v3hsk-u-boot.dts b/arch/arm/dts/r8a77980-v3hsk-u-boot.dtsi
similarity index 95%
rename from arch/arm/dts/r8a77980-v3hsk-u-boot.dts
rename to arch/arm/dts/r8a77980-v3hsk-u-boot.dtsi
index d083df65f9a..2901d0e7b57 100644
--- a/arch/arm/dts/r8a77980-v3hsk-u-boot.dts
+++ b/arch/arm/dts/r8a77980-v3hsk-u-boot.dtsi
@@ -5,7 +5,6 @@
  * Copyright (C) 2019 Cogent Embedded, Inc.
  */
 
-#include "r8a77980-v3hsk.dts"
 #include "r8a77980-u-boot.dtsi"
 
 / {
diff --git a/arch/arm/dts/r8a77990-ebisu-u-boot.dts b/arch/arm/dts/r8a77990-ebisu-u-boot.dtsi
similarity index 97%
rename from arch/arm/dts/r8a77990-ebisu-u-boot.dts
rename to arch/arm/dts/r8a77990-ebisu-u-boot.dtsi
index fc1c4a79294..b6b7b8f3609 100644
--- a/arch/arm/dts/r8a77990-ebisu-u-boot.dts
+++ b/arch/arm/dts/r8a77990-ebisu-u-boot.dtsi
@@ -5,7 +5,6 @@
  * Copyright (C) 2018 Marek Vasut <marek.vasut@gmail.com>
  */
 
-#include "r8a77990-ebisu.dts"
 #include "r8a77990-u-boot.dtsi"
 
 / {
diff --git a/arch/arm/dts/r8a77995-draak-u-boot.dts b/arch/arm/dts/r8a77995-draak-u-boot.dtsi
similarity index 94%
rename from arch/arm/dts/r8a77995-draak-u-boot.dts
rename to arch/arm/dts/r8a77995-draak-u-boot.dtsi
index 41ceae1da77..1922c40a438 100644
--- a/arch/arm/dts/r8a77995-draak-u-boot.dts
+++ b/arch/arm/dts/r8a77995-draak-u-boot.dtsi
@@ -5,7 +5,6 @@
  * Copyright (C) 2018 Marek Vasut <marek.vasut@gmail.com>
  */
 
-#include "r8a77995-draak.dts"
 #include "r8a77995-u-boot.dtsi"
 
 / {
diff --git a/arch/arm/dts/r8a779a0-falcon-u-boot.dts b/arch/arm/dts/r8a779a0-falcon-u-boot.dtsi
similarity index 94%
rename from arch/arm/dts/r8a779a0-falcon-u-boot.dts
rename to arch/arm/dts/r8a779a0-falcon-u-boot.dtsi
index 9d28791c605..3b8a017cb41 100644
--- a/arch/arm/dts/r8a779a0-falcon-u-boot.dts
+++ b/arch/arm/dts/r8a779a0-falcon-u-boot.dtsi
@@ -5,7 +5,6 @@
  * Copyright (C) 2020 Renesas Electronics Corp.
  */
 
-#include "r8a779a0-falcon.dts"
 #include "r8a779a0-u-boot.dtsi"
 
 / {
diff --git a/arch/arm/dts/r8a779f0-spider-u-boot.dts b/arch/arm/dts/r8a779f0-spider-u-boot.dtsi
similarity index 95%
rename from arch/arm/dts/r8a779f0-spider-u-boot.dts
rename to arch/arm/dts/r8a779f0-spider-u-boot.dtsi
index 26fc8bcf440..2fc7e7789a2 100644
--- a/arch/arm/dts/r8a779f0-spider-u-boot.dts
+++ b/arch/arm/dts/r8a779f0-spider-u-boot.dtsi
@@ -5,7 +5,6 @@
  * Copyright (C) 2021 Renesas Electronics Corp.
  */
 
-#include "r8a779f0-spider.dts"
 #include "r8a779f0-u-boot.dtsi"
 
 / {
diff --git a/arch/arm/dts/r8a779g0-white-hawk-u-boot.dts b/arch/arm/dts/r8a779g0-white-hawk-u-boot.dtsi
similarity index 95%
rename from arch/arm/dts/r8a779g0-white-hawk-u-boot.dts
rename to arch/arm/dts/r8a779g0-white-hawk-u-boot.dtsi
index bd756036645..a102639010d 100644
--- a/arch/arm/dts/r8a779g0-white-hawk-u-boot.dts
+++ b/arch/arm/dts/r8a779g0-white-hawk-u-boot.dtsi
@@ -5,7 +5,6 @@
  * Copyright (C) 2021 Renesas Electronics Corp.
  */
 
-#include "r8a779g0-white-hawk.dts"
 #include "r8a779g0-u-boot.dtsi"
 
 / {
diff --git a/arch/arm/dts/r8a779h0-gray-hawk-u-boot.dts b/arch/arm/dts/r8a779h0-gray-hawk-u-boot.dtsi
similarity index 95%
rename from arch/arm/dts/r8a779h0-gray-hawk-u-boot.dts
rename to arch/arm/dts/r8a779h0-gray-hawk-u-boot.dtsi
index 935ba9465dc..92c13151613 100644
--- a/arch/arm/dts/r8a779h0-gray-hawk-u-boot.dts
+++ b/arch/arm/dts/r8a779h0-gray-hawk-u-boot.dtsi
@@ -5,7 +5,6 @@
  * Copyright (C) 2023 Renesas Electronics Corp.
  */
 
-#include "r8a779h0-gray-hawk.dts"
 #include "r8a779h0-u-boot.dtsi"
 
 / {
diff --git a/board/renesas/salvator-x/salvator-x.c b/board/renesas/salvator-x/salvator-x.c
index 8c47246ae8b..afb3b63582b 100644
--- a/board/renesas/salvator-x/salvator-x.c
+++ b/board/renesas/salvator-x/salvator-x.c
@@ -79,15 +79,15 @@ int board_fit_config_name_match(const char *name)
 	u32 cpu_type = renesas_get_cpu_type();
 
 	if ((cpu_type == RENESAS_CPU_TYPE_R8A7795) &&
-	    !strcmp(name, "r8a77950-salvator-x-u-boot"))
+	    !strcmp(name, "r8a77950-salvator-x"))
 		return 0;
 
 	if ((cpu_type == RENESAS_CPU_TYPE_R8A7796) &&
-	    !strcmp(name, "r8a77960-salvator-x-u-boot"))
+	    !strcmp(name, "r8a77960-salvator-x"))
 		return 0;
 
 	if ((cpu_type == RENESAS_CPU_TYPE_R8A77965) &&
-	    !strcmp(name, "r8a77965-salvator-x-u-boot"))
+	    !strcmp(name, "r8a77965-salvator-x"))
 		return 0;
 
 	return -1;
diff --git a/board/renesas/ulcb/ulcb.c b/board/renesas/ulcb/ulcb.c
index 8f5de216995..cda6976602d 100644
--- a/board/renesas/ulcb/ulcb.c
+++ b/board/renesas/ulcb/ulcb.c
@@ -70,15 +70,15 @@ int board_fit_config_name_match(const char *name)
 	u32 cpu_type = renesas_get_cpu_type();
 
 	if ((cpu_type == RENESAS_CPU_TYPE_R8A7795) &&
-	    !strcmp(name, "r8a77950-ulcb-u-boot"))
+	    !strcmp(name, "r8a77950-ulcb"))
 		return 0;
 
 	if ((cpu_type == RENESAS_CPU_TYPE_R8A7796) &&
-	    !strcmp(name, "r8a77960-ulcb-u-boot"))
+	    !strcmp(name, "r8a77960-ulcb"))
 		return 0;
 
 	if ((cpu_type == RENESAS_CPU_TYPE_R8A77965) &&
-	    !strcmp(name, "r8a77965-ulcb-u-boot"))
+	    !strcmp(name, "r8a77965-ulcb"))
 		return 0;
 
 	return -1;
diff --git a/configs/alt_defconfig b/configs/alt_defconfig
index e4007ab8f71..06e9e11f297 100644
--- a/configs/alt_defconfig
+++ b/configs/alt_defconfig
@@ -16,7 +16,7 @@ CONFIG_ENV_SIZE=0x40000
 CONFIG_ENV_OFFSET=0xC0000
 CONFIG_ENV_SECT_SIZE=0x40000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="r8a7794-alt-u-boot"
+CONFIG_DEFAULT_DEVICE_TREE="r8a7794-alt"
 CONFIG_SPL_TEXT_BASE=0xe6300000
 CONFIG_ARCH_RENESAS_BOARD_STRING="Alt"
 CONFIG_R8A7794=y
diff --git a/configs/blanche_defconfig b/configs/blanche_defconfig
index af7622a88af..c392055e5a7 100644
--- a/configs/blanche_defconfig
+++ b/configs/blanche_defconfig
@@ -12,7 +12,7 @@ CONFIG_ENV_SIZE=0x40000
 CONFIG_ENV_OFFSET=0x40000
 CONFIG_ENV_SECT_SIZE=0x40000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="r8a7792-blanche-u-boot"
+CONFIG_DEFAULT_DEVICE_TREE="r8a7792-blanche"
 CONFIG_ARCH_RENESAS_BOARD_STRING="Blanche"
 CONFIG_R8A7792=y
 CONFIG_TARGET_BLANCHE=y
diff --git a/configs/gose_defconfig b/configs/gose_defconfig
index 1eadf7c14d3..35edc677c48 100644
--- a/configs/gose_defconfig
+++ b/configs/gose_defconfig
@@ -16,7 +16,7 @@ CONFIG_ENV_SIZE=0x40000
 CONFIG_ENV_OFFSET=0xC0000
 CONFIG_ENV_SECT_SIZE=0x40000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="r8a7793-gose-u-boot"
+CONFIG_DEFAULT_DEVICE_TREE="r8a7793-gose"
 CONFIG_SPL_TEXT_BASE=0xe6300000
 CONFIG_ARCH_RENESAS_BOARD_STRING="Gose"
 CONFIG_R8A7793=y
diff --git a/configs/grpeach_defconfig b/configs/grpeach_defconfig
index eef3bad4e65..0c581b634a2 100644
--- a/configs/grpeach_defconfig
+++ b/configs/grpeach_defconfig
@@ -11,7 +11,7 @@ CONFIG_ENV_SIZE=0x10000
 CONFIG_ENV_OFFSET=0x80000
 CONFIG_ENV_SECT_SIZE=0x10000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="r7s72100-gr-peach-u-boot"
+CONFIG_DEFAULT_DEVICE_TREE="r7s72100-gr-peach"
 CONFIG_RZA1=y
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_SYS_MONITOR_LEN=524288
diff --git a/configs/hihope_rzg2_defconfig b/configs/hihope_rzg2_defconfig
index a2c7e78cb86..88c7ed1b98f 100644
--- a/configs/hihope_rzg2_defconfig
+++ b/configs/hihope_rzg2_defconfig
@@ -7,7 +7,7 @@ CONFIG_SYS_MALLOC_LEN=0x4000000
 CONFIG_ENV_SIZE=0x20000
 CONFIG_ENV_OFFSET=0xFFFE0000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="r8a774a1-hihope-rzg2m-u-boot"
+CONFIG_DEFAULT_DEVICE_TREE="r8a774a1-hihope-rzg2m"
 CONFIG_RCAR_GEN3=y
 CONFIG_TARGET_HIHOPE_RZG2=y
 CONFIG_SYS_MONITOR_LEN=1048576
@@ -40,7 +40,7 @@ CONFIG_CMD_EXT4_WRITE=y
 CONFIG_CMD_FAT=y
 CONFIG_CMD_FS_GENERIC=y
 CONFIG_OF_CONTROL=y
-CONFIG_OF_LIST="r8a774a1-hihope-rzg2m-u-boot r8a774b1-hihope-rzg2n-u-boot r8a774e1-hihope-rzg2h-u-boot"
+CONFIG_OF_LIST="r8a774a1-hihope-rzg2m r8a774b1-hihope-rzg2n r8a774e1-hihope-rzg2h"
 CONFIG_MULTI_DTB_FIT_LZO=y
 CONFIG_MULTI_DTB_FIT_USER_DEFINED_AREA=y
 CONFIG_ENV_OVERWRITE=y
diff --git a/configs/koelsch_defconfig b/configs/koelsch_defconfig
index 963e02d6b54..ad411b45141 100644
--- a/configs/koelsch_defconfig
+++ b/configs/koelsch_defconfig
@@ -16,7 +16,7 @@ CONFIG_ENV_SIZE=0x40000
 CONFIG_ENV_OFFSET=0xC0000
 CONFIG_ENV_SECT_SIZE=0x40000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="r8a7791-koelsch-u-boot"
+CONFIG_DEFAULT_DEVICE_TREE="r8a7791-koelsch"
 CONFIG_SPL_TEXT_BASE=0xe6300000
 CONFIG_ARCH_RENESAS_BOARD_STRING="Koelsch"
 CONFIG_R8A7791=y
diff --git a/configs/lager_defconfig b/configs/lager_defconfig
index 605909e812f..f60d4db5ec2 100644
--- a/configs/lager_defconfig
+++ b/configs/lager_defconfig
@@ -16,7 +16,7 @@ CONFIG_ENV_SIZE=0x40000
 CONFIG_ENV_OFFSET=0xC0000
 CONFIG_ENV_SECT_SIZE=0x40000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="r8a7790-lager-u-boot"
+CONFIG_DEFAULT_DEVICE_TREE="r8a7790-lager"
 CONFIG_SPL_TEXT_BASE=0xe6300000
 CONFIG_ARCH_RENESAS_BOARD_STRING="Lager"
 CONFIG_R8A7790=y
diff --git a/configs/porter_defconfig b/configs/porter_defconfig
index 021e521745f..f05a0baf215 100644
--- a/configs/porter_defconfig
+++ b/configs/porter_defconfig
@@ -16,7 +16,7 @@ CONFIG_ENV_SIZE=0x40000
 CONFIG_ENV_OFFSET=0xC0000
 CONFIG_ENV_SECT_SIZE=0x40000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="r8a7791-porter-u-boot"
+CONFIG_DEFAULT_DEVICE_TREE="r8a7791-porter"
 CONFIG_SPL_TEXT_BASE=0xe6300000
 CONFIG_ARCH_RENESAS_BOARD_STRING="Porter"
 CONFIG_R8A7791=y
diff --git a/configs/r8a77970_eagle_defconfig b/configs/r8a77970_eagle_defconfig
index 62fa7e1133c..a3f695e4238 100644
--- a/configs/r8a77970_eagle_defconfig
+++ b/configs/r8a77970_eagle_defconfig
@@ -9,7 +9,7 @@ CONFIG_ENV_SIZE=0x40000
 CONFIG_ENV_OFFSET=0x700000
 CONFIG_ENV_SECT_SIZE=0x40000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="r8a77970-eagle-u-boot"
+CONFIG_DEFAULT_DEVICE_TREE="r8a77970-eagle"
 CONFIG_SPL_TEXT_BASE=0xe6318000
 CONFIG_RCAR_GEN3=y
 CONFIG_TARGET_EAGLE=y
diff --git a/configs/r8a77970_v3msk_defconfig b/configs/r8a77970_v3msk_defconfig
index b34087293ad..05c8d0e3868 100644
--- a/configs/r8a77970_v3msk_defconfig
+++ b/configs/r8a77970_v3msk_defconfig
@@ -9,7 +9,7 @@ CONFIG_ENV_SIZE=0x40000
 CONFIG_ENV_OFFSET=0x700000
 CONFIG_ENV_SECT_SIZE=0x40000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="r8a77970-v3msk-u-boot"
+CONFIG_DEFAULT_DEVICE_TREE="r8a77970-v3msk"
 CONFIG_SPL_TEXT_BASE=0xe6318000
 CONFIG_RCAR_GEN3=y
 CONFIG_R8A77970=y
diff --git a/configs/r8a77980_condor_defconfig b/configs/r8a77980_condor_defconfig
index 8a501950364..9e11c1b27ee 100644
--- a/configs/r8a77980_condor_defconfig
+++ b/configs/r8a77980_condor_defconfig
@@ -8,7 +8,7 @@ CONFIG_ENV_SIZE=0x40000
 CONFIG_ENV_OFFSET=0x700000
 CONFIG_ENV_SECT_SIZE=0x40000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="r8a77980-condor-u-boot"
+CONFIG_DEFAULT_DEVICE_TREE="r8a77980-condor"
 CONFIG_SPL_TEXT_BASE=0xe6318000
 CONFIG_RCAR_GEN3=y
 CONFIG_TARGET_CONDOR=y
diff --git a/configs/r8a77980_v3hsk_defconfig b/configs/r8a77980_v3hsk_defconfig
index 8d67b7f6bfe..f61574dd02d 100644
--- a/configs/r8a77980_v3hsk_defconfig
+++ b/configs/r8a77980_v3hsk_defconfig
@@ -8,7 +8,7 @@ CONFIG_ENV_SIZE=0x40000
 CONFIG_ENV_OFFSET=0x700000
 CONFIG_ENV_SECT_SIZE=0x40000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="r8a77980-v3hsk-u-boot"
+CONFIG_DEFAULT_DEVICE_TREE="r8a77980-v3hsk"
 CONFIG_SPL_TEXT_BASE=0xe6318000
 CONFIG_RCAR_GEN3=y
 CONFIG_R8A77980=y
diff --git a/configs/r8a77990_ebisu_defconfig b/configs/r8a77990_ebisu_defconfig
index 28fa30e31e5..fe4134226ac 100644
--- a/configs/r8a77990_ebisu_defconfig
+++ b/configs/r8a77990_ebisu_defconfig
@@ -8,7 +8,7 @@ CONFIG_SYS_MALLOC_F_LEN=0x2000
 CONFIG_ENV_SIZE=0x20000
 CONFIG_ENV_OFFSET=0xFFFE0000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="r8a77990-ebisu-u-boot"
+CONFIG_DEFAULT_DEVICE_TREE="r8a77990-ebisu"
 CONFIG_SPL_TEXT_BASE=0xe6318000
 CONFIG_RCAR_GEN3=y
 CONFIG_TARGET_EBISU=y
diff --git a/configs/r8a77995_draak_defconfig b/configs/r8a77995_draak_defconfig
index 644320632a9..a964d4ea51e 100644
--- a/configs/r8a77995_draak_defconfig
+++ b/configs/r8a77995_draak_defconfig
@@ -8,7 +8,7 @@ CONFIG_SYS_MALLOC_F_LEN=0x2000
 CONFIG_ENV_SIZE=0x20000
 CONFIG_ENV_OFFSET=0xFFFE0000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="r8a77995-draak-u-boot"
+CONFIG_DEFAULT_DEVICE_TREE="r8a77995-draak"
 CONFIG_SPL_TEXT_BASE=0xe6318000
 CONFIG_RCAR_GEN3=y
 CONFIG_TARGET_DRAAK=y
diff --git a/configs/r8a779a0_falcon_defconfig b/configs/r8a779a0_falcon_defconfig
index 04a5600960d..6681cb0088f 100644
--- a/configs/r8a779a0_falcon_defconfig
+++ b/configs/r8a779a0_falcon_defconfig
@@ -8,7 +8,7 @@ CONFIG_ENV_SIZE=0x40000
 CONFIG_ENV_OFFSET=0xC00000
 CONFIG_ENV_SECT_SIZE=0x40000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="r8a779a0-falcon-u-boot"
+CONFIG_DEFAULT_DEVICE_TREE="r8a779a0-falcon"
 CONFIG_RCAR_GEN4=y
 CONFIG_TARGET_FALCON=y
 CONFIG_SYS_MONITOR_LEN=1048576
diff --git a/configs/r8a779f0_spider_defconfig b/configs/r8a779f0_spider_defconfig
index 54e0928debb..942e0184412 100644
--- a/configs/r8a779f0_spider_defconfig
+++ b/configs/r8a779f0_spider_defconfig
@@ -6,7 +6,7 @@ CONFIG_ENV_SIZE=0x40000
 CONFIG_ENV_OFFSET=0xD00000
 CONFIG_ENV_SECT_SIZE=0x40000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="r8a779f0-spider-u-boot"
+CONFIG_DEFAULT_DEVICE_TREE="r8a779f0-spider"
 CONFIG_RCAR_GEN4=y
 CONFIG_TARGET_SPIDER=y
 CONFIG_SYS_MONITOR_LEN=1048576
diff --git a/configs/r8a779g0_whitehawk_defconfig b/configs/r8a779g0_whitehawk_defconfig
index 1489c327c41..4cc6203e54d 100644
--- a/configs/r8a779g0_whitehawk_defconfig
+++ b/configs/r8a779g0_whitehawk_defconfig
@@ -5,7 +5,7 @@ CONFIG_SYS_MALLOC_LEN=0x4000000
 CONFIG_ENV_SIZE=0x20000
 CONFIG_ENV_OFFSET=0xFFFE0000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="r8a779g0-white-hawk-u-boot"
+CONFIG_DEFAULT_DEVICE_TREE="r8a779g0-white-hawk"
 CONFIG_RCAR_GEN4=y
 CONFIG_TARGET_WHITEHAWK=y
 CONFIG_SYS_MONITOR_LEN=1048576
diff --git a/configs/r8a779h0_grayhawk_defconfig b/configs/r8a779h0_grayhawk_defconfig
index 84401eb9309..7368708195d 100644
--- a/configs/r8a779h0_grayhawk_defconfig
+++ b/configs/r8a779h0_grayhawk_defconfig
@@ -5,7 +5,7 @@ CONFIG_SYS_MALLOC_LEN=0x4000000
 CONFIG_ENV_SIZE=0x20000
 CONFIG_ENV_OFFSET=0xFFFE0000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="r8a779h0-gray-hawk-u-boot"
+CONFIG_DEFAULT_DEVICE_TREE="r8a779h0-gray-hawk"
 CONFIG_RCAR_GEN4=y
 CONFIG_TARGET_GRAYHAWK=y
 CONFIG_SYS_MONITOR_LEN=1048576
diff --git a/configs/rcar3_salvator-x_defconfig b/configs/rcar3_salvator-x_defconfig
index a69bb4381ca..c76cbec76d4 100644
--- a/configs/rcar3_salvator-x_defconfig
+++ b/configs/rcar3_salvator-x_defconfig
@@ -6,7 +6,7 @@ CONFIG_SYS_MALLOC_LEN=0x4000000
 CONFIG_ENV_SIZE=0x20000
 CONFIG_ENV_OFFSET=0xFFFE0000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="r8a77950-salvator-x-u-boot"
+CONFIG_DEFAULT_DEVICE_TREE="r8a77950-salvator-x"
 CONFIG_SPL_TEXT_BASE=0xe6338000
 CONFIG_RCAR_GEN3=y
 CONFIG_TARGET_SALVATOR_X=y
@@ -48,7 +48,7 @@ CONFIG_CMD_EXT4_WRITE=y
 CONFIG_CMD_FAT=y
 CONFIG_CMD_FS_GENERIC=y
 CONFIG_OF_CONTROL=y
-CONFIG_OF_LIST="r8a77950-salvator-x-u-boot r8a77960-salvator-x-u-boot r8a77965-salvator-x-u-boot"
+CONFIG_OF_LIST="r8a77950-salvator-x r8a77960-salvator-x r8a77965-salvator-x"
 CONFIG_MULTI_DTB_FIT_LZO=y
 CONFIG_MULTI_DTB_FIT_USER_DEFINED_AREA=y
 CONFIG_OF_DTB_PROPS_REMOVE=y
diff --git a/configs/rcar3_ulcb_defconfig b/configs/rcar3_ulcb_defconfig
index 5bd36979423..701dfcb7a0e 100644
--- a/configs/rcar3_ulcb_defconfig
+++ b/configs/rcar3_ulcb_defconfig
@@ -7,7 +7,7 @@ CONFIG_SYS_MALLOC_F_LEN=0x2000
 CONFIG_ENV_SIZE=0x20000
 CONFIG_ENV_OFFSET=0xFFFE0000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="r8a77950-ulcb-u-boot"
+CONFIG_DEFAULT_DEVICE_TREE="r8a77950-ulcb"
 CONFIG_SPL_TEXT_BASE=0xe6338000
 CONFIG_RCAR_GEN3=y
 CONFIG_TARGET_ULCB=y
@@ -46,7 +46,7 @@ CONFIG_CMD_EXT4_WRITE=y
 CONFIG_CMD_FAT=y
 CONFIG_CMD_FS_GENERIC=y
 CONFIG_OF_CONTROL=y
-CONFIG_OF_LIST="r8a77950-ulcb-u-boot r8a77960-ulcb-u-boot r8a77965-ulcb-u-boot"
+CONFIG_OF_LIST="r8a77950-ulcb r8a77960-ulcb r8a77965-ulcb"
 CONFIG_MULTI_DTB_FIT_LZO=y
 CONFIG_MULTI_DTB_FIT_USER_DEFINED_AREA=y
 CONFIG_OF_DTB_PROPS_REMOVE=y
diff --git a/configs/silinux_ek874_defconfig b/configs/silinux_ek874_defconfig
index 0f0aca36ee6..93902e009b2 100644
--- a/configs/silinux_ek874_defconfig
+++ b/configs/silinux_ek874_defconfig
@@ -9,7 +9,7 @@ CONFIG_ENV_SIZE=0x10000
 CONFIG_ENV_OFFSET=0x3F0000
 CONFIG_ENV_SECT_SIZE=0x10000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="r8a774c0-ek874-u-boot"
+CONFIG_DEFAULT_DEVICE_TREE="r8a774c0-ek874"
 CONFIG_SPL_TEXT_BASE=0xe6318000
 CONFIG_RCAR_GEN3=y
 CONFIG_TARGET_SILINUX_EK874=y
diff --git a/configs/silk_defconfig b/configs/silk_defconfig
index 939ccc9c478..40ac8759d08 100644
--- a/configs/silk_defconfig
+++ b/configs/silk_defconfig
@@ -16,7 +16,7 @@ CONFIG_ENV_SIZE=0x40000
 CONFIG_ENV_OFFSET=0xC0000
 CONFIG_ENV_SECT_SIZE=0x40000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="r8a7794-silk-u-boot"
+CONFIG_DEFAULT_DEVICE_TREE="r8a7794-silk"
 CONFIG_SPL_TEXT_BASE=0xe6300000
 CONFIG_ARCH_RENESAS_BOARD_STRING="Silk"
 CONFIG_R8A7794=y
diff --git a/configs/stout_defconfig b/configs/stout_defconfig
index 1022ee9e71a..428a0241986 100644
--- a/configs/stout_defconfig
+++ b/configs/stout_defconfig
@@ -16,7 +16,7 @@ CONFIG_ENV_SIZE=0x40000
 CONFIG_ENV_OFFSET=0xC0000
 CONFIG_ENV_SECT_SIZE=0x40000
 CONFIG_DM_GPIO=y
-CONFIG_DEFAULT_DEVICE_TREE="r8a7790-stout-u-boot"
+CONFIG_DEFAULT_DEVICE_TREE="r8a7790-stout"
 CONFIG_SPL_TEXT_BASE=0xe6300000
 CONFIG_ARCH_RENESAS_BOARD_STRING="Stout"
 CONFIG_R8A7790=y
-- 
2.43.0

