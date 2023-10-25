Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4C23C0032E
	for <u-boot@archiver.kernel.org>; Wed, 25 Oct 2023 11:17:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C7854879E0;
	Wed, 25 Oct 2023 13:17:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 155AD87A96; Wed, 25 Oct 2023 13:17:27 +0200 (CEST)
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net
 [217.70.183.194])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40859879E0
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 13:17:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=0leil.net
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=foss+uboot@0leil.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5CE984000A;
 Wed, 25 Oct 2023 11:17:24 +0000 (UTC)
From: Quentin Schulz <foss+uboot@0leil.net>
To: Klaus Goger <klaus.goger@theobroma-systems.com>
Cc: Quentin Schulz <foss+uboot@0leil.net>, u-boot@lists.denx.de,
 heiko@sntech.de, Quentin Schulz <quentin.schulz@theobroma-systems.com>
Subject: [PATCH] rockchip: ringneck-px30: enable i2c command
Date: Wed, 25 Oct 2023 13:17:12 +0200
Message-ID: <20231025-ringneck-i2c-cmd-v1-1-e8671d1f20e8@theobroma-systems.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: foss@0leil.net
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

From: Quentin Schulz <quentin.schulz@theobroma-systems.com>=0D
=0D
This is a useful tool to check the presence of a device on a specific=0D
i2c bus, so let's enable it.=0D
=0D
Cc: Quentin Schulz <foss+uboot@0leil.net>=0D
Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>=0D
---=0D
 configs/ringneck-px30_defconfig | 1 +=0D
 1 file changed, 1 insertion(+)=0D
=0D
diff --git a/configs/ringneck-px30_defconfig b/configs/ringneck-px30_defcon=
fig=0D
index b4666d0e90f..f47dfa58782 100644=0D
--- a/configs/ringneck-px30_defconfig=0D
+++ b/configs/ringneck-px30_defconfig=0D
@@ -53,6 +53,7 @@ CONFIG_SPL_ATF=3Dy=0D
 # CONFIG_CMD_LZMADEC is not set=0D
 # CONFIG_CMD_UNZIP is not set=0D
 CONFIG_CMD_GPT=3Dy=0D
+CONFIG_CMD_I2C=3Dy=0D
 # CONFIG_CMD_LOADB is not set=0D
 # CONFIG_CMD_LOADS is not set=0D
 CONFIG_CMD_MMC=3Dy=0D
=0D
---=0D
base-commit: 351da15f71e3d70dbc63e90781b403415452d864=0D
change-id: 20231025-ringneck-i2c-cmd-6417b86bc9a8=0D
=0D
Best regards,=0D
-- =0D
Quentin Schulz <quentin.schulz@theobroma-systems.com>=0D
=0D
