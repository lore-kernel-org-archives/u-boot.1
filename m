Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E90FC54ED0
	for <u-boot@archiver.kernel.org>; Thu, 22 May 2025 14:51:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 282FA8310F;
	Thu, 22 May 2025 16:51:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="sSCOJPH/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1AF528309A; Thu, 22 May 2025 16:11:05 +0200 (CEST)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.154.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE74D830CE
 for <u-boot@lists.denx.de>; Thu, 22 May 2025 16:11:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=microchip.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=prvs=230144c57=Eoin.Dickson@microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1747923061; x=1779459061;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=e5KbOMJ9dPp439pZV57ilP0Hbsz6yfH+cu1ml3mLD64=;
 b=sSCOJPH/m7nfdFbuF4sq4js4JN/FTX782R5WtGcdjB63hlsQcKyhNTLj
 0T/S5SedJRRux9Ezjn+6Zg/co9Jz4nOdT0nkrjIOOZJWNE4Rhdat3jSh/
 nbLUFBtTV5yFJ2sdWvgXT+AJ7YrUaepaDcHdga0jDgU0wMsI492N3Uzto
 fjL3j9ohDbBYgY7nph3us/YYDMNXI9S8EOo6CkbbwXkE8OWI+j1a/3ymi
 ILoCE1WOsH5smbeULFdGROdu4nkL8I6w3g7oGr8pJ6/nIZGx0BLh8gqkv
 SdAd34LV2eGnFcfsg5lrpY520sxOrgW1VDO2H0H64wy8ARuTp8tln5OR4 Q==;
X-CSE-ConnectionGUID: 4Vv6n9SaRFWqXYHoGSYIZA==
X-CSE-MsgGUID: 4QzCr52NSpK0+oQ4XIsl2Q==
X-IronPort-AV: E=Sophos;i="6.15,306,1739862000"; d="scan'208";a="41493682"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 22 May 2025 07:10:58 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 22 May 2025 07:10:55 -0700
Received: from ird-lt-m75649b.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.44 via Frontend Transport; Thu, 22 May 2025 07:10:53 -0700
From: Eoin Dickson <Eoin.Dickson@microchip.com>
To: <u-boot@lists.denx.de>
CC: <rick@andestech.com>, <ycliang@andestech.com>,
 <conor.dooley@microchip.com>, <jamie.gibbons@microchip.com>,
 <praveen.kumar@microchip.com>, <eoin.dickson@microchip.com>,
 <cyril.jean@microchip.com>, <jagan@amarulasolutions.com>
Subject: [PATCH v1 3/4] configs: beaglev_fire: Enable GPIO and MMC_SPI
Date: Thu, 22 May 2025 19:40:01 +0530
Message-ID: <20250522141002.1212408-4-Eoin.Dickson@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250522141002.1212408-1-Eoin.Dickson@microchip.com>
References: <20250522141002.1212408-1-Eoin.Dickson@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Mailman-Approved-At: Thu, 22 May 2025 16:50:59 +0200
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

From: Eoin Dickson <eoin.dickson@microchip.com>

Enable CONFIG_MPFS_GPIO, CONFIG_CMD_GPIO and CONFIG_DM_GPIO and
CONFIG_MMC_SPI in the beaglev_fire_defconfig.

Signed-off-by: Eoin Dickson <eoin.dickson@microchip.com>
---
 configs/beaglev_fire_defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/configs/beaglev_fire_defconfig b/configs/beaglev_fire_defconfig
index cd0734841f..36525f997e 100644
--- a/configs/beaglev_fire_defconfig
+++ b/configs/beaglev_fire_defconfig
@@ -27,3 +27,7 @@ CONFIG_MPFS_MBOX=y
 CONFIG_MISC=y
 CONFIG_MPFS_SYSCONTROLLER=y
 CONFIG_SYSRESET=y
+CONFIG_MPFS_GPIO=y
+CONFIG_CMD_GPIO=y
+CONFIG_DM_GPIO=y
+CONFIG_MMC_SPI=y
-- 
2.34.1

