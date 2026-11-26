Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB88E606A31C
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 10:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=lEbMIPId;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.a=rsa-sha256 header.s=default2602 header.b=Eim6lejr
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8992260A46;
	Thu, 26 Nov 2026 10:47:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id AZAWvMP8Tbpf; Thu, 26 Nov 2026 10:47:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org A3BFF608F6
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795690026;
	b=iL5FXCBp0kM2py67KK2WE7o0KWsV7xXp/MWOVM14Z+FfUFLjqevBDOe0agbfjEYgcF66
	 OYaxPotSNHWZ6IaJduLE7DQeVQt3s93uN2XN6LjsCy3TdK4NVWlClPz7e0kQWtBZy903D
	 gKDZpQav3muWNrJZh90hx5SpAMtoN25riUkVGW4mbZvZ71lDN6nwE+gYVsuqNeg1vpX6t
	 otf+yuuHvjtSbG+wfGZyFu+J//zI1xhcMkv33FO7x98tZDyEbiK0w+pgqkHVGzsQLlVHp
	 ZSnMFvxx4XiHsZa8drmVIcvl7vvrLc5yM25p7Pgc/v/PIai8Ugvs/zNyRiemFiuFKjQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795690026;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Virus-Scanned:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=YNLl3kE8xHjSPpnzb731HtpIlOc+7pD42Ze872dCOKQ=;
	b=tKTdMOzpdWVRR0h4rupcaoia9tuFRrayBMvbCxes9EQbpqplz4RV0ccR97v9gZP/1U8s
	 oXBtrbve2KsdCtppqiKmtDsqZReadkWAa4/7Hoj7szeI/AXCk2o98bBYeeaV3B0pZsR9I
	 IfTTJcSpPs16kQB2DQqoF3lJ3DceI833i5a5SYywAF6MNy8dYWIBgxChMntQUJm5VRGBA
	 v9fTjyyUDQjjHrhLrj8d+ZC4LeNpFnymoKbqVt4AANgReAZmsDB92DDjjvalz1g3GfFWz
	 Nz4HTXGmeeNGkI3UXCP1Yh1eWLzh8iqDaRCvrRPc0uGNHKLpWnyFMPjjQHrIC5VmhXQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	dmarc=pass header.from=ew.tq-group.com;
	dkim=pass header.d=ew.tq-group.com header.i=@ew.tq-group.com header.a=rsa-sha256 header.s=default2602 header.b=Eim6lejr;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795690026;
	bh=YNLl3kE8xHjSPpnzb731HtpIlOc+7pD42Ze872dCOKQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lEbMIPIdmcdg9Y0J9GcQsxAttQrEOIam+hA23CMjtxnEp5DniA5Voyfj+nPeslzoM
	 Rz/5AlwDN01sHb49lCgkqEBHSnyHgINrisseLAm74Fi8uN7NWwafSLUQHJHR5+1tCT
	 LxrcM0yn8OZpq14HeM6vcCg2w17D81QgD6Cp885rsYiMu+AagDJe+LQ/TmExznk/Sg
	 LDV4WWZ82w6UcFfiX0mfKq+A//z/JxqUEcSn+5nfAx7vGrliJN0doyrNxJzLmJHTxv
	 udPQGY+2J+Pb6mGqBM1uCmHDBU7Z9RAyJBtWYVh5e0zlk6SfRMlN8dAj6m3wlm1VKJ
	 q2yWktIN8ohTw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A3BFF608F6;
	Thu, 26 Nov 2026 10:47:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 7A507371
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 10:46:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6BFAA608F6
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 10:46:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eAUwGFRCcIjh for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 10:46:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2B044608E9
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=188.40.3.216
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=188.40.3.216;
 helo=www537.your-server.de; envelope-from=max.merchel@ew.tq-group.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com
 header.a=rsa-sha256 header.s=default2602 header.b=Eim6lejr
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2B044608E9
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 10:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID;
 bh=YNLl3kE8xHjSPpnzb731HtpIlOc+7pD42Ze872dCOKQ=; b=Eim6lejrhzp35FtJCXlXvkL9sY
 I9n3BKEG997RHqebempmUP3+ht847ldPjGDeP0Lx5+iYtu2mOwiw03s1shlRrzEJZrJJMAxFG6Yrj
 CsbCYX9JF2SCuLiM1ihLlL3fU1waR6AuE0RFZhi2y6WvLds1PfVeTWk3memsT1eGFuego6Uj98SNq
 yG0WSDYWiH7QEdXAXNoyLrU8tNU/amVGuFivNlAhw/lOsd1c5Od2NFXsnf0jubFTN1R2ziCnfn9ux
 PB7I3C4YNd8la8MiPosJuRrGNtEgq9/guF4ClXhYtq+bLSk0tb5k+e52E7d7hNspFNOVbqHkd2qKk
 ecFao9ew==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <Max.Merchel@ew.tq-group.com>)
 id 1xWX05-000Ntu-2G; Thu, 26 Nov 2026 11:46:49 +0100
Received: from localhost ([127.0.0.1])
 by sslproxy06.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <Max.Merchel@ew.tq-group.com>)
 id 1xWX04-0002PX-26; Thu, 26 Nov 2026 11:46:49 +0100
From: Max Merchel <Max.Merchel@ew.tq-group.com>
Date: Thu, 26 Nov 2026 11:46:46 +0100
Subject: [PATCH 1/6] configs: tqma6: rename .defconfig to .config
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261126-update-tqma6-v1-1-a105aba78868@ew.tq-group.com>
References: <20261126-update-tqma6-v1-0-a105aba78868@ew.tq-group.com>
In-Reply-To: <20261126-update-tqma6-v1-0-a105aba78868@ew.tq-group.com>
To: Tanmay Kathpalia <tanmay.kathpalia@altera.com>, u-boot@ew.tq-group.com, 
 u-boot@lists.u-boot-project.org, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Max Merchel <max.merchel@ew.tq-group.com>, 
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Paul Gerber <Paul.Gerber@tq-group.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Primoz Fiser <primoz.fiser@norik.com>, Adam Ford <aford173@gmail.com>, 
 Nora Schiffer <nora.schiffer@ew.tq-group.com>, 
 Johan Jonker <jbx6244@gmail.com>, 
 Markus Niebel <Markus.Niebel@ew.tq-group.com>, 
 Paul Gerber <Paul.Gerber@ew.tq-group.com>, 
 Max Merchel <Max.Merchel@ew.tq-group.com>
X-Mailer: b4 0.14.3
X-Virus-Scanned: Clear (ClamAV 1.4.6/28194/Wed Nov 25 07:26:59 2026)
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Change name from *.defconfig to *.config

Signed-off-by: Max Merchel <Max.Merchel@ew.tq-group.com>
---
 configs/{tqma6_mba6_common.defconfig => tqma6_mba6_common.config} | 2 +-
 configs/{tqma6_mba6_mmc.defconfig => tqma6_mba6_mmc.config}       | 0
 configs/{tqma6_mba6_spi.defconfig => tqma6_mba6_spi.config}       | 0
 configs/tqma6dl_mba6_mmc_defconfig                                | 4 ++--
 configs/tqma6dl_mba6_spi_defconfig                                | 4 ++--
 configs/tqma6q_mba6_mmc_defconfig                                 | 4 ++--
 configs/tqma6q_mba6_spi_defconfig                                 | 4 ++--
 configs/tqma6s_mba6_mmc_defconfig                                 | 4 ++--
 configs/tqma6s_mba6_spi_defconfig                                 | 4 ++--
 9 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/configs/tqma6_mba6_common.defconfig b/configs/tqma6_mba6_common.config
similarity index 100%
rename from configs/tqma6_mba6_common.defconfig
rename to configs/tqma6_mba6_common.config
index 6865d3b2641..415589db03e 100644
--- a/configs/tqma6_mba6_common.defconfig
+++ b/configs/tqma6_mba6_common.config
@@ -57,12 +57,12 @@ CONFIG_SPI_FLASH_SPANSION=y
 CONFIG_SPI_FLASH_STMICRO=y
 CONFIG_SPI_FLASH_WINBOND=y
 # CONFIG_SPI_FLASH_USE_4K_SECTORS is not set
-CONFIG_PHY_ANEG_TIMEOUT=8000
 CONFIG_DM_MDIO=y
 CONFIG_DM_ETH_PHY=y
 CONFIG_FEC_MXC=y
 CONFIG_RGMII=y
 CONFIG_MII=y
+CONFIG_PHY_ANEG_TIMEOUT=8000
 CONFIG_PINCTRL=y
 CONFIG_PINCTRL_IMX6=y
 CONFIG_DM_PMIC=y
diff --git a/configs/tqma6_mba6_mmc.defconfig b/configs/tqma6_mba6_mmc.config
similarity index 100%
rename from configs/tqma6_mba6_mmc.defconfig
rename to configs/tqma6_mba6_mmc.config
diff --git a/configs/tqma6_mba6_spi.defconfig b/configs/tqma6_mba6_spi.config
similarity index 100%
rename from configs/tqma6_mba6_spi.defconfig
rename to configs/tqma6_mba6_spi.config
diff --git a/configs/tqma6dl_mba6_mmc_defconfig b/configs/tqma6dl_mba6_mmc_defconfig
index 06166cb7da5..f16d8e484ac 100644
--- a/configs/tqma6dl_mba6_mmc_defconfig
+++ b/configs/tqma6dl_mba6_mmc_defconfig
@@ -1,5 +1,5 @@
-#include <configs/tqma6_mba6_common.defconfig>
-#include <configs/tqma6_mba6_mmc.defconfig>
+#include <configs/tqma6_mba6_common.config>
+#include <configs/tqma6_mba6_mmc.config>
 
 CONFIG_MX6DL=y
 CONFIG_DEFAULT_DEVICE_TREE="nxp/imx/imx6dl-mba6b"
diff --git a/configs/tqma6dl_mba6_spi_defconfig b/configs/tqma6dl_mba6_spi_defconfig
index f22ea543042..fcc03ad491d 100644
--- a/configs/tqma6dl_mba6_spi_defconfig
+++ b/configs/tqma6dl_mba6_spi_defconfig
@@ -1,5 +1,5 @@
-#include <configs/tqma6_mba6_common.defconfig>
-#include <configs/tqma6_mba6_spi.defconfig>
+#include <configs/tqma6_mba6_common.config>
+#include <configs/tqma6_mba6_spi.config>
 
 CONFIG_MX6DL=y
 CONFIG_DEFAULT_DEVICE_TREE="nxp/imx/imx6dl-mba6b"
diff --git a/configs/tqma6q_mba6_mmc_defconfig b/configs/tqma6q_mba6_mmc_defconfig
index 2d3fcbccc14..05fad3d82f4 100644
--- a/configs/tqma6q_mba6_mmc_defconfig
+++ b/configs/tqma6q_mba6_mmc_defconfig
@@ -1,5 +1,5 @@
-#include <configs/tqma6_mba6_common.defconfig>
-#include <configs/tqma6_mba6_mmc.defconfig>
+#include <configs/tqma6_mba6_common.config>
+#include <configs/tqma6_mba6_mmc.config>
 
 CONFIG_MX6Q=y
 CONFIG_DEFAULT_DEVICE_TREE="nxp/imx/imx6q-mba6b"
diff --git a/configs/tqma6q_mba6_spi_defconfig b/configs/tqma6q_mba6_spi_defconfig
index 5d61d097eec..7af41523c2d 100644
--- a/configs/tqma6q_mba6_spi_defconfig
+++ b/configs/tqma6q_mba6_spi_defconfig
@@ -1,5 +1,5 @@
-#include <configs/tqma6_mba6_common.defconfig>
-#include <configs/tqma6_mba6_spi.defconfig>
+#include <configs/tqma6_mba6_common.config>
+#include <configs/tqma6_mba6_spi.config>
 
 CONFIG_MX6Q=y
 CONFIG_DEFAULT_DEVICE_TREE="nxp/imx/imx6q-mba6b"
diff --git a/configs/tqma6s_mba6_mmc_defconfig b/configs/tqma6s_mba6_mmc_defconfig
index 323f582e874..23d2a75e55b 100644
--- a/configs/tqma6s_mba6_mmc_defconfig
+++ b/configs/tqma6s_mba6_mmc_defconfig
@@ -1,5 +1,5 @@
-#include <configs/tqma6_mba6_common.defconfig>
-#include <configs/tqma6_mba6_mmc.defconfig>
+#include <configs/tqma6_mba6_common.config>
+#include <configs/tqma6_mba6_mmc.config>
 
 CONFIG_MX6S=y
 CONFIG_DEFAULT_DEVICE_TREE="nxp/imx/imx6dl-mba6b"
diff --git a/configs/tqma6s_mba6_spi_defconfig b/configs/tqma6s_mba6_spi_defconfig
index 9701d35cfb8..4e674fe6634 100644
--- a/configs/tqma6s_mba6_spi_defconfig
+++ b/configs/tqma6s_mba6_spi_defconfig
@@ -1,5 +1,5 @@
-#include <configs/tqma6_mba6_common.defconfig>
-#include <configs/tqma6_mba6_spi.defconfig>
+#include <configs/tqma6_mba6_common.config>
+#include <configs/tqma6_mba6_spi.config>
 
 CONFIG_MX6S=y
 CONFIG_DEFAULT_DEVICE_TREE="nxp/imx/imx6dl-mba6b"

-- 
2.53.0

