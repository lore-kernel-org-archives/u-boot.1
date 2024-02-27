Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EE8AC54798
	for <u-boot@archiver.kernel.org>; Tue, 27 Feb 2024 20:41:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E154688012;
	Tue, 27 Feb 2024 21:40:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB6C98805C; Tue, 27 Feb 2024 21:40:56 +0100 (CET)
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com
 [210.160.252.172])
 by phobos.denx.de (Postfix) with ESMTP id 7A5808803A
 for <u-boot@lists.denx.de>; Tue, 27 Feb 2024 21:40:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=bp.renesas.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=paul.barker.ct@bp.renesas.com
X-IronPort-AV: E=Sophos;i="6.06,188,1705330800"; d="scan'208";a="199492142"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
 by relmlie6.idc.renesas.com with ESMTP; 28 Feb 2024 05:40:54 +0900
Received: from renesas-deb12.mshome.net (unknown [10.226.92.31])
 by relmlir5.idc.renesas.com (Postfix) with ESMTP id 54D8440083FB;
 Wed, 28 Feb 2024 05:40:52 +0900 (JST)
From: Paul Barker <paul.barker.ct@bp.renesas.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>,
	u-boot@lists.denx.de
Subject: [PATCH v3 5/8] board: rzg2l: Enable access to Renesas RAA215300 PMIC
Date: Tue, 27 Feb 2024 20:40:32 +0000
Message-Id: <20240227204035.3761-6-paul.barker.ct@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240227204035.3761-1-paul.barker.ct@bp.renesas.com>
References: <20240227204035.3761-1-paul.barker.ct@bp.renesas.com>
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

Enable the appropriate PMIC driver as well as the `pmic` command.

Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
---
 configs/renesas_rzg2l_smarc_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/configs/renesas_rzg2l_smarc_defconfig b/configs/renesas_rzg2l_smarc_defconfig
index ad46297c6619..2cab79329db4 100644
--- a/configs/renesas_rzg2l_smarc_defconfig
+++ b/configs/renesas_rzg2l_smarc_defconfig
@@ -27,6 +27,7 @@ CONFIG_CMD_GPIO=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_PART=y
+CONFIG_CMD_PMIC=y
 CONFIG_CMD_EXT2=y
 CONFIG_CMD_EXT4=y
 CONFIG_CMD_EXT4_WRITE=y
@@ -49,6 +50,8 @@ CONFIG_DM_I2C=y
 CONFIG_MMC_IO_VOLTAGE=y
 CONFIG_MMC_UHS_SUPPORT=y
 CONFIG_MMC_HS400_SUPPORT=y
+CONFIG_DM_PMIC=y
+CONFIG_PMIC_RAA215300=y
 CONFIG_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_GPIO=y
-- 
2.44.0

