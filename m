Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5667EE49A8
	for <u-boot@archiver.kernel.org>; Sat, 19 Aug 2023 14:25:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E85C87037;
	Sat, 19 Aug 2023 16:24:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1692455080;
	bh=l4FtVR9GYfFEqTSPkgFG75fCzm6GDLsRAfNbl0SqcL4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gBmJ/paVc8QeYvdNixsy/XnD37i5/GTvQKykcBDQCWBvA2eIx7armZpZg//pnKrEd
	 zNbP/XlaoihZ2K0uBLIToz0j+A1flQ4yQ91Ei4rSC4Q2Tcg1p0Q0AJ/HKWJotEh3G7
	 /H1rTbRn0nIpK74wwQ+rHyq2VB+yO55vLpIqFaRq9R5bkd9rPaQSxaTCWwNvwDDkpg
	 DFaYJyu2C4ejAj+YuiA6lw4Ux06A2TYxXKMHSlBg+6cN5gCgOMTMfpk7BBHl8AlZ9u
	 1PIuhNzFlN6/hF/1P/SSYeTCZU0h9MRcySAWxlAZm67R4YnDpzyb/W7Qz7xvewV8E6
	 yvrCy1VZlHfPQ==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 0234486FCA;
 Sat, 19 Aug 2023 16:24:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1692455078;
 bh=l4FtVR9GYfFEqTSPkgFG75fCzm6GDLsRAfNbl0SqcL4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=XJ3pZsY+wpQ/wCHtsLmGeafzMpz7s/jbSMGxzCNOC6ZmWI7jueTzo+07ON+JUrk6j
 QrVLSUKrfp9Ac6+OQFrqYwmcQ74OvdK2V7dKIG6SXMq9gVnFz6KKEZwmcjSPAYiDg9
 17m0B47dyOKY3Bi4kucuHDB0oYqZMsZ3P9EZHdJGKq8ORulbaSIxXUB7697QvFseV0
 dSgoW+vyhhN/y/iDQbi2XL16laEm2PnjknRM6RZA+Jw0Heqt3csM3w1KKbrRnm2CQj
 WAnI6KL9DBDnUHunBvV58TEmZzuKYWA2VKGRhVPVymDDEVJbZMdynjgBlCDNLJ+GtN
 /oOhPiNy/GOkA==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Angus Ainslie <angus@akkea.ca>,
 Dmitrii Merkurev <dimorinny@google.com>,
 Eddie Cai <eddie.cai.linux@gmail.com>,
 Kever Yang <kever.yang@rock-chips.com>, Lukasz Majewski <lukma@denx.de>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Nishanth Menon <nm@ti.com>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <sr@denx.de>, kernel@puri.sm
Subject: [PATCH 03/17] configs: sandbox: Enable DM_USB_GADGET
Date: Sat, 19 Aug 2023 16:23:53 +0200
Message-Id: <20230819142407.49632-3-marex@denx.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230819142407.49632-1-marex@denx.de>
References: <20230819142407.49632-1-marex@denx.de>
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

Switch sandbox to DM_USB_GADGET, DM is the future.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Angus Ainslie <angus@akkea.ca>
Cc: Dmitrii Merkurev <dimorinny@google.com>
Cc: Eddie Cai <eddie.cai.linux@gmail.com>
Cc: Kever Yang <kever.yang@rock-chips.com>
Cc: Lukasz Majewski <lukma@denx.de>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: Nishanth Menon <nm@ti.com>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
Cc: Philipp Tomsich <philipp.tomsich@vrull.eu>
Cc: Simon Glass <sjg@chromium.org>
Cc: Stefan Roese <sr@denx.de>
Cc: kernel@puri.sm
---
 configs/sandbox64_defconfig        | 1 +
 configs/sandbox_defconfig          | 1 +
 configs/sandbox_flattree_defconfig | 1 +
 configs/sandbox_noinst_defconfig   | 1 +
 configs/sandbox_spl_defconfig      | 1 +
 configs/sandbox_vpl_defconfig      | 1 +
 6 files changed, 6 insertions(+)

diff --git a/configs/sandbox64_defconfig b/configs/sandbox64_defconfig
index 69e5efe8748..72452695cdc 100644
--- a/configs/sandbox64_defconfig
+++ b/configs/sandbox64_defconfig
@@ -230,6 +230,7 @@ CONFIG_TIMER=y
 CONFIG_TIMER_EARLY=y
 CONFIG_SANDBOX_TIMER=y
 CONFIG_USB=y
+CONFIG_DM_USB_GADGET=y
 CONFIG_USB_EMUL=y
 CONFIG_USB_KEYBOARD=y
 CONFIG_VIDEO=y
diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index 1cd1c2ed7cd..9f8b81f5fe6 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -298,6 +298,7 @@ CONFIG_TIMER=y
 CONFIG_TIMER_EARLY=y
 CONFIG_SANDBOX_TIMER=y
 CONFIG_USB=y
+CONFIG_DM_USB_GADGET=y
 CONFIG_USB_EMUL=y
 CONFIG_USB_KEYBOARD=y
 CONFIG_USB_GADGET=y
diff --git a/configs/sandbox_flattree_defconfig b/configs/sandbox_flattree_defconfig
index 8aa295686dc..cedae60d3cf 100644
--- a/configs/sandbox_flattree_defconfig
+++ b/configs/sandbox_flattree_defconfig
@@ -204,6 +204,7 @@ CONFIG_TIMER=y
 CONFIG_TIMER_EARLY=y
 CONFIG_SANDBOX_TIMER=y
 CONFIG_USB=y
+CONFIG_DM_USB_GADGET=y
 CONFIG_USB_EMUL=y
 CONFIG_USB_KEYBOARD=y
 CONFIG_VIDEO=y
diff --git a/configs/sandbox_noinst_defconfig b/configs/sandbox_noinst_defconfig
index 2c6aab6c859..360686b9682 100644
--- a/configs/sandbox_noinst_defconfig
+++ b/configs/sandbox_noinst_defconfig
@@ -218,6 +218,7 @@ CONFIG_TIMER=y
 CONFIG_TIMER_EARLY=y
 CONFIG_SANDBOX_TIMER=y
 CONFIG_USB=y
+CONFIG_DM_USB_GADGET=y
 CONFIG_USB_EMUL=y
 CONFIG_USB_KEYBOARD=y
 CONFIG_VIDEO=y
diff --git a/configs/sandbox_spl_defconfig b/configs/sandbox_spl_defconfig
index 8d50162b274..bc79adfcd8f 100644
--- a/configs/sandbox_spl_defconfig
+++ b/configs/sandbox_spl_defconfig
@@ -224,6 +224,7 @@ CONFIG_TIMER=y
 CONFIG_TIMER_EARLY=y
 CONFIG_SANDBOX_TIMER=y
 CONFIG_USB=y
+CONFIG_DM_USB_GADGET=y
 CONFIG_USB_EMUL=y
 CONFIG_USB_KEYBOARD=y
 CONFIG_VIDEO=y
diff --git a/configs/sandbox_vpl_defconfig b/configs/sandbox_vpl_defconfig
index f3a0fd19a96..2c817b3847d 100644
--- a/configs/sandbox_vpl_defconfig
+++ b/configs/sandbox_vpl_defconfig
@@ -237,6 +237,7 @@ CONFIG_VPL_TIMER=y
 CONFIG_TIMER_EARLY=y
 CONFIG_SANDBOX_TIMER=y
 CONFIG_USB=y
+CONFIG_DM_USB_GADGET=y
 CONFIG_USB_EMUL=y
 CONFIG_USB_KEYBOARD=y
 CONFIG_VIDEO=y
-- 
2.40.1

