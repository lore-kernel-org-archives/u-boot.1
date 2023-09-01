Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08E08CA0FE1
	for <u-boot@archiver.kernel.org>; Fri,  1 Sep 2023 09:50:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 041E7868D1;
	Fri,  1 Sep 2023 11:50:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1693561822;
	bh=l3oNd+/TSGWG3B/avVCqREm4/aeAegNLtfl8DRVhnTo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zyFcPq/wH+VcZolMd/1cASjS3BwY2JHnbT2CsYPArfl9ribEaQ5VTPPuGizL9Tz9Z
	 rMoi5gdgbLOaEnylm3H5v9d48ZsT9pSE3kjuhrxZivGwGXEx0rjozAFfBDe7ZirNfr
	 NuPPvcRIaH8J88TbPM7QDV6D/ufgFXVNJc0JKVUT6wa/mYH6jgqk3COsJX7vLoXhgZ
	 lgt0YgVzwH4Se6Dys9OkGuxu481aLazPgY0htzWFrAM0jGMEHcaMbX1tnpFf9aMsP3
	 VgbwWSGp31Q5WWK8OPWITVRUZ650UFDeJ9bD5xb1KzRKoyjfz+UJHidxLbg00OT7t9
	 AytewV2Ag5tQg==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id ED27D80422;
 Fri,  1 Sep 2023 11:50:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1693561820;
 bh=l3oNd+/TSGWG3B/avVCqREm4/aeAegNLtfl8DRVhnTo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=EqmzD7hk4Z2oj9gHxGhPAAbGzBY4yUYMX94qJIM24ibguuHBaBJV7DjCJI67DAFUI
 lMcCf8Uu8axZ0Q8p7r1EcwB1rmauQvuB1dDGP+NmpNdgIkQaaSmfSit3+rBtoJX3uO
 gQ/ELpPMcIryHBEk0uV8czyJrtT71BiAPhf2czqIUPLoCg7TQT/1XFV0JHY23HxIGz
 2JfSw3IPdX6389x507aeNNN4J30XpxvmYQZF1P6+0hXS15EhLafER0cfc6CQSYaRn+
 SK2pTOu8+fQ90ba3W/yDMJXCxfbC+p0lF3RGazr8q+/gC6T3531WYb50raE19dcDZ1
 i5XZ58n5xR+tA==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Simon Glass <sjg@chromium.org>, Angus Ainslie <angus@akkea.ca>,
 Dmitrii Merkurev <dimorinny@google.com>,
 Eddie Cai <eddie.cai.linux@gmail.com>,
 Kever Yang <kever.yang@rock-chips.com>, Lukasz Majewski <lukma@denx.de>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Nishanth Menon <nm@ti.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Stefan Roese <sr@denx.de>,
 kernel@puri.sm
Subject: [PATCH v2 03/17] configs: sandbox: Enable DM_USB_GADGET
Date: Fri,  1 Sep 2023 11:49:49 +0200
Message-Id: <20230901095003.352930-3-marex@denx.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230901095003.352930-1-marex@denx.de>
References: <20230901095003.352930-1-marex@denx.de>
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

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Reviewed-by: Simon Glass <sjg@chromium.org>
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
V2: Add RB from Mattijs, Simon
---
 configs/sandbox64_defconfig        | 1 +
 configs/sandbox_defconfig          | 1 +
 configs/sandbox_flattree_defconfig | 1 +
 configs/sandbox_noinst_defconfig   | 1 +
 configs/sandbox_spl_defconfig      | 1 +
 configs/sandbox_vpl_defconfig      | 1 +
 6 files changed, 6 insertions(+)

diff --git a/configs/sandbox64_defconfig b/configs/sandbox64_defconfig
index 55a01b7eb9d..1104b86ff7c 100644
--- a/configs/sandbox64_defconfig
+++ b/configs/sandbox64_defconfig
@@ -236,6 +236,7 @@ CONFIG_TIMER=y
 CONFIG_TIMER_EARLY=y
 CONFIG_SANDBOX_TIMER=y
 CONFIG_USB=y
+CONFIG_DM_USB_GADGET=y
 CONFIG_USB_EMUL=y
 CONFIG_USB_KEYBOARD=y
 CONFIG_VIDEO=y
diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index 98f0bc13a5f..d667cb9ae47 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -299,6 +299,7 @@ CONFIG_TIMER=y
 CONFIG_TIMER_EARLY=y
 CONFIG_SANDBOX_TIMER=y
 CONFIG_USB=y
+CONFIG_DM_USB_GADGET=y
 CONFIG_USB_EMUL=y
 CONFIG_USB_KEYBOARD=y
 CONFIG_USB_GADGET=y
diff --git a/configs/sandbox_flattree_defconfig b/configs/sandbox_flattree_defconfig
index db916e6c4e9..29ae4532c50 100644
--- a/configs/sandbox_flattree_defconfig
+++ b/configs/sandbox_flattree_defconfig
@@ -203,6 +203,7 @@ CONFIG_TIMER=y
 CONFIG_TIMER_EARLY=y
 CONFIG_SANDBOX_TIMER=y
 CONFIG_USB=y
+CONFIG_DM_USB_GADGET=y
 CONFIG_USB_EMUL=y
 CONFIG_USB_KEYBOARD=y
 CONFIG_VIDEO=y
diff --git a/configs/sandbox_noinst_defconfig b/configs/sandbox_noinst_defconfig
index ee04fbbc2e9..d39e54f98d2 100644
--- a/configs/sandbox_noinst_defconfig
+++ b/configs/sandbox_noinst_defconfig
@@ -217,6 +217,7 @@ CONFIG_TIMER=y
 CONFIG_TIMER_EARLY=y
 CONFIG_SANDBOX_TIMER=y
 CONFIG_USB=y
+CONFIG_DM_USB_GADGET=y
 CONFIG_USB_EMUL=y
 CONFIG_USB_KEYBOARD=y
 CONFIG_VIDEO=y
diff --git a/configs/sandbox_spl_defconfig b/configs/sandbox_spl_defconfig
index 69b413382a1..4a67af2f088 100644
--- a/configs/sandbox_spl_defconfig
+++ b/configs/sandbox_spl_defconfig
@@ -223,6 +223,7 @@ CONFIG_TIMER=y
 CONFIG_TIMER_EARLY=y
 CONFIG_SANDBOX_TIMER=y
 CONFIG_USB=y
+CONFIG_DM_USB_GADGET=y
 CONFIG_USB_EMUL=y
 CONFIG_USB_KEYBOARD=y
 CONFIG_VIDEO=y
diff --git a/configs/sandbox_vpl_defconfig b/configs/sandbox_vpl_defconfig
index 27354b8b5ed..8d76f19729b 100644
--- a/configs/sandbox_vpl_defconfig
+++ b/configs/sandbox_vpl_defconfig
@@ -236,6 +236,7 @@ CONFIG_VPL_TIMER=y
 CONFIG_TIMER_EARLY=y
 CONFIG_SANDBOX_TIMER=y
 CONFIG_USB=y
+CONFIG_DM_USB_GADGET=y
 CONFIG_USB_EMUL=y
 CONFIG_USB_KEYBOARD=y
 CONFIG_VIDEO=y
-- 
2.40.1

