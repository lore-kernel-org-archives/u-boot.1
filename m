Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1135BC52D7C
	for <u-boot@archiver.kernel.org>; Wed, 21 Aug 2024 21:03:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6058D88E43;
	Wed, 21 Aug 2024 23:03:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1724274237;
	bh=dyaiioFBsm8cZojNQe/NfrZb/6wHY7FuQ0bV2dIIAJE=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=FZU9ghVKDNo6lKiqFMTtDV4uIZC+IRi/8pK7Q+AGHR/FiNtN+KCc39JEZwPozCmv4
	 fPZMzT/S+MC8nhp8jLoQqB1LjO3o4E/O56D7KEOhz+CdYyGdWN/7RvzHOr+YEDOx/I
	 cZEKERK+XAzJYg+tA/a/fXl7gzNMwXltHcUlASY5Fz0sATeKAqQl6urnUb2AMgG9ll
	 8/9HxyqgTHBXGGxYLLVHKnSBFqTIGwCANdoIzUxa2j2W1DONBHwZS2H122qp9G4iSy
	 KKQJWubwCKQxAUVl83dtAfvY1UUQqmAtI775EAuc0RBKlBt0/lDBD30oCGyH5QONko
	 bz61GNzaANsfw==
Received: from tr.lan (ip-86-49-120-218.bb.vodafone.cz [86.49.120.218])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 3499A88E3F;
 Wed, 21 Aug 2024 23:03:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1724274236;
 bh=dyaiioFBsm8cZojNQe/NfrZb/6wHY7FuQ0bV2dIIAJE=;
 h=From:To:Cc:Subject:Date:From;
 b=dcTcwqd3/4mvX4WnaMUHMKi8d+vCw2drTFa8CbQv6IqjGc6+RctHr6QGAPmchN3n4
 FR7BkftAokRP9bPXzQ+Q1gtOZI7UMZOOlKbTXOxjSTPuQLS0SyDX/INGS6LBa207Vj
 UUVvqHgjzac+C8oXhK7y0tFRWi8kf6k8L0dsSQmE5eVrWFZZ/7mPxL0LS01g80PL9E
 kBQFrN1uH2obvS5d4Q9M9L5bAd0/k1OgVffuiRvAvJd45bzoO5Ch48aX2d1ZlWVTPG
 j5R8Ihl7lVMmhXovJy0xZ+mmRG7udmdEq1XpTRt9Uo4ASHpVU9JAtY3OJmGpAfCneo
 SENGLAuo8QM9Q==
From: Marek Vasut <marex@denx.de>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Fabio Estevam <festevam@denx.de>
Subject: [PATCH] ARM: imx: Enable cat and xxd commands on Data Modul i.MX8M
 Mini/Plus eDM SBC
Date: Wed, 21 Aug 2024 23:03:33 +0200
Message-ID: <20240821210345.269145-1-marex@denx.de>
X-Mailer: git-send-email 2.43.0
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

Enable 'cat' command to print file from filesystem to stdout.
Enable 'xxd' command to hexdump file from filesystem to stdout.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Fabio Estevam <festevam@denx.de>
Cc: u-boot@lists.denx.de
---
 configs/imx8mm_data_modul_edm_sbc_defconfig | 2 ++
 configs/imx8mp_data_modul_edm_sbc_defconfig | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/configs/imx8mm_data_modul_edm_sbc_defconfig b/configs/imx8mm_data_modul_edm_sbc_defconfig
index f26a8791cd0..17ebe5e743d 100644
--- a/configs/imx8mm_data_modul_edm_sbc_defconfig
+++ b/configs/imx8mm_data_modul_edm_sbc_defconfig
@@ -105,6 +105,8 @@ CONFIG_CMD_SPI=y
 CONFIG_CMD_USB=y
 CONFIG_CMD_USB_SDP=y
 CONFIG_CMD_USB_MASS_STORAGE=y
+CONFIG_CMD_CAT=y
+CONFIG_CMD_XXD=y
 CONFIG_CMD_DHCP=y
 CONFIG_CMD_DHCP6=y
 CONFIG_CMD_TFTPPUT=y
diff --git a/configs/imx8mp_data_modul_edm_sbc_defconfig b/configs/imx8mp_data_modul_edm_sbc_defconfig
index fe3e757eefd..be47583dd7a 100644
--- a/configs/imx8mp_data_modul_edm_sbc_defconfig
+++ b/configs/imx8mp_data_modul_edm_sbc_defconfig
@@ -112,6 +112,8 @@ CONFIG_CMD_SPI=y
 CONFIG_CMD_USB=y
 CONFIG_CMD_USB_SDP=y
 CONFIG_CMD_USB_MASS_STORAGE=y
+CONFIG_CMD_CAT=y
+CONFIG_CMD_XXD=y
 CONFIG_CMD_DHCP=y
 CONFIG_CMD_DHCP6=y
 CONFIG_CMD_TFTPPUT=y
-- 
2.43.0

