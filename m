Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D219D606A324
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 10:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=bCbkGpHY;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.a=rsa-sha256 header.s=default2602 header.b=oNDQGe5X
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A130B409D3;
	Wed, 11 Nov 2026 10:13:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eH4sNAwxQVgj; Wed, 11 Nov 2026 10:13:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org DB53B40A81
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794392018;
	b=oT6pjrO4xYy3o+HqlcfWAFlg4P3t+7tVUQhqmD0R07qzn8CW5aG/SppeYTOrjQWGujij
	 BFE61m9byD+KpLnv5X57wjXPI87XEdhRrqlQLdOlhsHSl/IAyfkC+f3MmXPiE+MiyPPc7
	 0TT2SEcOS+v2TV0QvM/lDKH0YKTZ/ma/xUX3vj9+PkWTd2JtGtecNQ0B40lLYHT31sMd+
	 ANUXucwt2MUofyV2xzyQAgZBzcsknlBXSC8rSQ2d33Hdv3lN9F4iyN4tADQUuaNEy6zDk
	 efiGl8n6BxjuTofJFCtpfbB0wXLUhJXFq9QVy3P6QmoMpdBkPtdP07IbnmXw3Boofsw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794392018;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Virus-Scanned:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=oZrXa8IwRoX9QHU18hKuqGMbWtFC/ARI0QxgWrwWgd8=;
	b=YBivjuAuG9sAp6gWBTeZoAYe3FiwnC2DYhkXp2seEtOuuzRIhALkDEprj/xmht9+YVpl
	 578ujQIasskDt9f8v5ke1F+N96kMlGxu63R2S4SAfIcpmu6d4prRQbxC+CQ2JfkIgOoCO
	 FCBPeBdOjN8xatW6DzgBGY35YlXJZXNihrk9WvxwhSaC1cIhcd3xsk5QdHDylVyL1lFFa
	 OtQymK7tjwNujVBEMXFj/6Ol8htR+mhBxH1ppkXTpqd7bwcmrlnGhnmhRUtQI5t8B8tmd
	 spuq30Wa3BNZbkKpLzt2flx+NPdtHDL1vjo9iGOM+jxY1ZcwskG8R1QKvm8eXmioqqg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=ew.tq-group.com;
	dkim=pass header.d=ew.tq-group.com header.i=@ew.tq-group.com header.a=rsa-sha256 header.s=default2602 header.b=oNDQGe5X;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794392018;
	bh=oZrXa8IwRoX9QHU18hKuqGMbWtFC/ARI0QxgWrwWgd8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bCbkGpHYPuMlWxBmpFtXrGRsuCRFGlhpGwAgfRUdx22inRc7IkRmvNshpM0QRqqdZ
	 x2r6xvwGu/E6opY5HAgRmkIJUTiZc/6bSyjjvovXTN6Q3QoMX9ml3nAiCDKcMKMBG/
	 4UupUk/yyYJs8epKLJ87z5qA5ggXqYdIOPU0jaVKQEseancIh47WKFL+i1dMKkDyEP
	 UYou9Mci8EdgrRvsSLoF9yr7kWOTo/0ytH4wNulksgc+pWJ0XpBAVjQyeae5EZCQ2s
	 G1oJtEV5tbhOQAhO6kSWbcOJnt3q4yDex58WAVIO1t3tWXP1zoq78jGvO5W2WhC2LW
	 2HSwlKWX3Gg+w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id DB53B40A81;
	Wed, 11 Nov 2026 10:13:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id AE49B1A6
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 10:13:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A00C540856
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 10:13:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id H0nxbzKa4UVD for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 10:13:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9CE994084F
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=188.40.3.216
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=188.40.3.216;
 helo=www537.your-server.de; envelope-from=nora.schiffer@ew.tq-group.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=ew.tq-group.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=ew.tq-group.com header.i=@ew.tq-group.com
 header.a=rsa-sha256 header.s=default2602 header.b=oNDQGe5X
Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9CE994084F
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 10:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=oZrXa8IwRoX9QHU18hKuqGMbWtFC/ARI0QxgWrwWgd8=; b=oNDQGe5XdC6PNCsZzmrUEMwvg/
 97akgx6kMYrcOCCIF/9Yu77jJafNV285ARCEPVlfx5u5sIFDHm1Gxnpv6gBBR2LTlKHHJSb8bdhHN
 0COF2pGN084gIEyIYssQeHBB26OvXnsRv78D9zE6esPcHgAgSh2vtYUDglzyZjD7o+UDsOwGN9ONJ
 U8cO0+QVe0wMGGbyDArexjSu16ALLg0MQ+UDDscXj67v/1kB8x2u7lYLzJQb3jTj3PdgAQFCPXe0p
 RRDWO+PlJWQUwa7tsQ/f4sfaJ+NwyY1CWd9SShoJUWz2FPNvkMqwdAOjm2YP1uWswrAtEnObB5skj
 k4aQKaXw==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
 by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96.2) (envelope-from <nora.schiffer@ew.tq-group.com>)
 id 1xR5KW-0004wl-0x; Wed, 11 Nov 2026 11:13:24 +0100
Received: from localhost ([127.0.0.1])
 by sslproxy05.your-server.de with esmtpsa (TLS1.3) tls TLS_AES_256_GCM_SHA384
 (Exim 4.96) (envelope-from <nora.schiffer@ew.tq-group.com>)
 id 1xR5KW-000Lq2-1X; Wed, 11 Nov 2026 11:13:23 +0100
From: Nora Schiffer <nora.schiffer@ew.tq-group.com>
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Marek Vasut <marex@nabladev.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@ew.tq-group.com,
 u-boot@lists.u-boot-project.org,
 Nora Schiffer <nora.schiffer@ew.tq-group.com>
Subject: [PATCH v2 3/7] power: domain: rename imx8m-power-domain to
 imx-gpcv2-power-domain
Date: Wed, 11 Nov 2026 11:12:54 +0100
Message-ID: <afa440adc4fd913db84f3f36e2fb0d9e2c3ba953.1794391398.git.nora.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794391398.git.nora.schiffer@ew.tq-group.com>
References: <cover.1794391398.git.nora.schiffer@ew.tq-group.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.6/28180/Wed Nov 11 07:24:27 2026)
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Prepare to port i.MX7D support from the Linux kernel to the driver.

Also fix the help text incorrectly stating that the driver manipulates
power domains via the ATF.

Signed-off-by: Nora Schiffer <nora.schiffer@ew.tq-group.com>
---
 configs/imx8m_data_modul.config               |  2 +-
 configs/imx8mm-cl-iot-gate-optee_defconfig    |  2 +-
 configs/imx8mm-cl-iot-gate_defconfig          |  2 +-
 configs/imx8mm-mx8menlo_defconfig             |  2 +-
 configs/imx8mm-phygate-tauri-l_defconfig      |  2 +-
 configs/imx8mm_evk_defconfig                  |  2 +-
 configs/imx8mm_phg_defconfig                  |  2 +-
 configs/imx8mm_venice_defconfig               |  2 +-
 configs/imx8mn_venice_defconfig               |  2 +-
 configs/imx8mp-libra-fpsc_defconfig           |  2 +-
 configs/imx8mp_dhsom.config                   |  2 +-
 configs/imx8mp_evk_defconfig                  |  2 +-
 configs/imx8mp_venice_defconfig               |  2 +-
 configs/imx8mq_evk_defconfig                  |  2 +-
 configs/imx8mq_phanbell_defconfig             |  2 +-
 configs/imx8mq_reform2_defconfig              |  2 +-
 configs/kontron-osm-s-mx8mp.config            |  2 +-
 configs/kontron-sl-mx8mm_defconfig            |  2 +-
 configs/kontron_pitx_imx8m_defconfig          |  2 +-
 configs/librem5-devkit_defconfig              |  2 +-
 configs/librem5_defconfig                     |  2 +-
 configs/phycore-imx8mm_defconfig              |  2 +-
 configs/phycore-imx8mp_defconfig              |  2 +-
 configs/pico-imx8mq_defconfig                 |  2 +-
 configs/toradex-smarc-imx8mp_defconfig        |  2 +-
 configs/verdin-imx8mm_defconfig               |  2 +-
 configs/verdin-imx8mp_defconfig               |  2 +-
 drivers/power/domain/Kconfig                  | 15 +++---
 drivers/power/domain/Makefile                 |  2 +-
 ...ower-domain.c => imx-gpcv2-power-domain.c} | 50 +++++++++----------
 30 files changed, 60 insertions(+), 61 deletions(-)
 rename drivers/power/domain/{imx8m-power-domain.c => imx-gpcv2-power-domain.c} (90%)

diff --git a/configs/imx8m_data_modul.config b/configs/imx8m_data_modul.config
index 92940ddb947..287bb851b24 100644
--- a/configs/imx8m_data_modul.config
+++ b/configs/imx8m_data_modul.config
@@ -116,7 +116,7 @@ CONFIG_GPIO_HOG=y
 CONFIG_HASH_VERIFY=y
 CONFIG_HUSH_PARSER=y
 CONFIG_I2C_EEPROM=y
-CONFIG_IMX8M_POWER_DOMAIN=y
+CONFIG_IMX_GPCV2_POWER_DOMAIN=y
 CONFIG_IMX_BOOTAUX=y
 CONFIG_IMX_TMU=y
 CONFIG_IMX_WATCHDOG=y
diff --git a/configs/imx8mm-cl-iot-gate-optee_defconfig b/configs/imx8mm-cl-iot-gate-optee_defconfig
index 32922b6c6bf..6f772b7694f 100644
--- a/configs/imx8mm-cl-iot-gate-optee_defconfig
+++ b/configs/imx8mm-cl-iot-gate-optee_defconfig
@@ -116,7 +116,7 @@ CONFIG_PINCTRL=y
 CONFIG_SPL_PINCTRL=y
 CONFIG_PINCTRL_IMX8M=y
 CONFIG_POWER_DOMAIN=y
-CONFIG_IMX8M_POWER_DOMAIN=y
+CONFIG_IMX_GPCV2_POWER_DOMAIN=y
 CONFIG_DM_PMIC=y
 CONFIG_DM_PMIC_BD71837=y
 CONFIG_SPL_DM_PMIC_BD71837=y
diff --git a/configs/imx8mm-cl-iot-gate_defconfig b/configs/imx8mm-cl-iot-gate_defconfig
index 0f69e2c0391..827d0ea343d 100644
--- a/configs/imx8mm-cl-iot-gate_defconfig
+++ b/configs/imx8mm-cl-iot-gate_defconfig
@@ -119,7 +119,7 @@ CONFIG_PINCTRL=y
 CONFIG_SPL_PINCTRL=y
 CONFIG_PINCTRL_IMX8M=y
 CONFIG_POWER_DOMAIN=y
-CONFIG_IMX8M_POWER_DOMAIN=y
+CONFIG_IMX_GPCV2_POWER_DOMAIN=y
 CONFIG_DM_PMIC=y
 CONFIG_DM_PMIC_BD71837=y
 CONFIG_SPL_DM_PMIC_BD71837=y
diff --git a/configs/imx8mm-mx8menlo_defconfig b/configs/imx8mm-mx8menlo_defconfig
index b3ba43a73a2..2d5d591b85a 100644
--- a/configs/imx8mm-mx8menlo_defconfig
+++ b/configs/imx8mm-mx8menlo_defconfig
@@ -136,7 +136,7 @@ CONFIG_PINCTRL=y
 CONFIG_SPL_PINCTRL=y
 CONFIG_PINCTRL_IMX8M=y
 CONFIG_POWER_DOMAIN=y
-CONFIG_IMX8M_POWER_DOMAIN=y
+CONFIG_IMX_GPCV2_POWER_DOMAIN=y
 CONFIG_DM_PMIC=y
 CONFIG_SPL_DM_PMIC_PCA9450=y
 CONFIG_DM_PMIC_PFUZE100=y
diff --git a/configs/imx8mm-phygate-tauri-l_defconfig b/configs/imx8mm-phygate-tauri-l_defconfig
index cacfe5b35b3..e6cbf5f3c01 100644
--- a/configs/imx8mm-phygate-tauri-l_defconfig
+++ b/configs/imx8mm-phygate-tauri-l_defconfig
@@ -93,7 +93,7 @@ CONFIG_PINCTRL=y
 CONFIG_SPL_PINCTRL=y
 CONFIG_PINCTRL_IMX8M=y
 CONFIG_POWER_DOMAIN=y
-CONFIG_IMX8M_POWER_DOMAIN=y
+CONFIG_IMX_GPCV2_POWER_DOMAIN=y
 CONFIG_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_GPIO=y
diff --git a/configs/imx8mm_evk_defconfig b/configs/imx8mm_evk_defconfig
index b41082d45de..ad0b22ff4af 100644
--- a/configs/imx8mm_evk_defconfig
+++ b/configs/imx8mm_evk_defconfig
@@ -105,7 +105,7 @@ CONFIG_PINCTRL=y
 CONFIG_SPL_PINCTRL=y
 CONFIG_PINCTRL_IMX8M=y
 CONFIG_POWER_DOMAIN=y
-CONFIG_IMX8M_POWER_DOMAIN=y
+CONFIG_IMX_GPCV2_POWER_DOMAIN=y
 CONFIG_DM_PMIC=y
 CONFIG_SPL_DM_PMIC_PCA9450=y
 CONFIG_DM_REGULATOR=y
diff --git a/configs/imx8mm_phg_defconfig b/configs/imx8mm_phg_defconfig
index 5c59b90603d..ef0e304357c 100644
--- a/configs/imx8mm_phg_defconfig
+++ b/configs/imx8mm_phg_defconfig
@@ -88,7 +88,7 @@ CONFIG_PINCTRL=y
 CONFIG_SPL_PINCTRL=y
 CONFIG_PINCTRL_IMX8M=y
 CONFIG_POWER_DOMAIN=y
-CONFIG_IMX8M_POWER_DOMAIN=y
+CONFIG_IMX_GPCV2_POWER_DOMAIN=y
 CONFIG_DM_PMIC=y
 CONFIG_DM_PMIC_PCA9450=y
 CONFIG_SPL_DM_PMIC_PCA9450=y
diff --git a/configs/imx8mm_venice_defconfig b/configs/imx8mm_venice_defconfig
index 559f6ff421f..4e6f439c002 100644
--- a/configs/imx8mm_venice_defconfig
+++ b/configs/imx8mm_venice_defconfig
@@ -140,7 +140,7 @@ CONFIG_PINCTRL=y
 CONFIG_SPL_PINCTRL=y
 CONFIG_PINCTRL_IMX8M=y
 CONFIG_POWER_DOMAIN=y
-CONFIG_IMX8M_POWER_DOMAIN=y
+CONFIG_IMX_GPCV2_POWER_DOMAIN=y
 CONFIG_DM_PMIC=y
 CONFIG_DM_PMIC_BD71837=y
 CONFIG_SPL_DM_PMIC_BD71837=y
diff --git a/configs/imx8mn_venice_defconfig b/configs/imx8mn_venice_defconfig
index d1f1e905053..e46fd496e4f 100644
--- a/configs/imx8mn_venice_defconfig
+++ b/configs/imx8mn_venice_defconfig
@@ -134,7 +134,7 @@ CONFIG_PINCTRL=y
 CONFIG_SPL_PINCTRL=y
 CONFIG_PINCTRL_IMX8M=y
 CONFIG_POWER_DOMAIN=y
-CONFIG_IMX8M_POWER_DOMAIN=y
+CONFIG_IMX_GPCV2_POWER_DOMAIN=y
 CONFIG_DM_PMIC=y
 CONFIG_DM_PMIC_BD71837=y
 CONFIG_SPL_DM_PMIC_BD71837=y
diff --git a/configs/imx8mp-libra-fpsc_defconfig b/configs/imx8mp-libra-fpsc_defconfig
index 8f39175a9cd..6f9a3a4bcf5 100644
--- a/configs/imx8mp-libra-fpsc_defconfig
+++ b/configs/imx8mp-libra-fpsc_defconfig
@@ -135,7 +135,7 @@ CONFIG_PINCTRL=y
 CONFIG_SPL_PINCTRL=y
 CONFIG_PINCTRL_IMX8M=y
 CONFIG_POWER_DOMAIN=y
-CONFIG_IMX8M_POWER_DOMAIN=y
+CONFIG_IMX_GPCV2_POWER_DOMAIN=y
 CONFIG_IMX8MP_HSIOMIX_BLKCTRL=y
 CONFIG_DM_PMIC=y
 CONFIG_DM_PMIC_PCA9450=y
diff --git a/configs/imx8mp_dhsom.config b/configs/imx8mp_dhsom.config
index 35a59c15a4d..0a5293e0b02 100644
--- a/configs/imx8mp_dhsom.config
+++ b/configs/imx8mp_dhsom.config
@@ -114,7 +114,7 @@ CONFIG_DM_PMIC_PCA9450=y
 CONFIG_DM_REGULATOR_GPIO=y
 CONFIG_DM_REGULATOR_PCA9450=y
 CONFIG_IMX8MP_HSIOMIX_BLKCTRL=y
-CONFIG_IMX8M_POWER_DOMAIN=y
+CONFIG_IMX_GPCV2_POWER_DOMAIN=y
 CONFIG_POWER_DOMAIN=y
 CONFIG_SPL_DM_PMIC_PCA9450=y
 CONFIG_SPL_DM_REGULATOR=y
diff --git a/configs/imx8mp_evk_defconfig b/configs/imx8mp_evk_defconfig
index 3f815f5fb66..083315bd290 100644
--- a/configs/imx8mp_evk_defconfig
+++ b/configs/imx8mp_evk_defconfig
@@ -126,7 +126,7 @@ CONFIG_PINCTRL=y
 CONFIG_SPL_PINCTRL=y
 CONFIG_PINCTRL_IMX8M=y
 CONFIG_POWER_DOMAIN=y
-CONFIG_IMX8M_POWER_DOMAIN=y
+CONFIG_IMX_GPCV2_POWER_DOMAIN=y
 CONFIG_IMX8MP_HSIOMIX_BLKCTRL=y
 CONFIG_DM_PMIC=y
 CONFIG_DM_PMIC_PCA9450=y
diff --git a/configs/imx8mp_venice_defconfig b/configs/imx8mp_venice_defconfig
index f7780e03099..a20152353ac 100644
--- a/configs/imx8mp_venice_defconfig
+++ b/configs/imx8mp_venice_defconfig
@@ -139,7 +139,7 @@ CONFIG_PINCTRL=y
 CONFIG_SPL_PINCTRL=y
 CONFIG_PINCTRL_IMX8M=y
 CONFIG_POWER_DOMAIN=y
-CONFIG_IMX8M_POWER_DOMAIN=y
+CONFIG_IMX_GPCV2_POWER_DOMAIN=y
 CONFIG_IMX8MP_HSIOMIX_BLKCTRL=y
 CONFIG_DM_PMIC=y
 CONFIG_DM_PMIC_BD71837=y
diff --git a/configs/imx8mq_evk_defconfig b/configs/imx8mq_evk_defconfig
index 546be61c6f5..936bde3e061 100644
--- a/configs/imx8mq_evk_defconfig
+++ b/configs/imx8mq_evk_defconfig
@@ -99,7 +99,7 @@ CONFIG_PINCTRL=y
 CONFIG_SPL_PINCTRL=y
 CONFIG_PINCTRL_IMX8M=y
 CONFIG_POWER_DOMAIN=y
-CONFIG_IMX8M_POWER_DOMAIN=y
+CONFIG_IMX_GPCV2_POWER_DOMAIN=y
 CONFIG_DM_PMIC=y
 CONFIG_SPL_DM_PMIC_PFUZE100=y
 CONFIG_DM_REGULATOR=y
diff --git a/configs/imx8mq_phanbell_defconfig b/configs/imx8mq_phanbell_defconfig
index 23d2d3b61a5..92b2e5059a0 100644
--- a/configs/imx8mq_phanbell_defconfig
+++ b/configs/imx8mq_phanbell_defconfig
@@ -84,7 +84,7 @@ CONFIG_PINCTRL=y
 CONFIG_SPL_PINCTRL=y
 CONFIG_PINCTRL_IMX8M=y
 CONFIG_POWER_DOMAIN=y
-CONFIG_IMX8M_POWER_DOMAIN=y
+CONFIG_IMX_GPCV2_POWER_DOMAIN=y
 CONFIG_DM_REGULATOR=y
 CONFIG_SPL_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_FIXED=y
diff --git a/configs/imx8mq_reform2_defconfig b/configs/imx8mq_reform2_defconfig
index c904fc677e6..0d0732ac5f1 100644
--- a/configs/imx8mq_reform2_defconfig
+++ b/configs/imx8mq_reform2_defconfig
@@ -87,7 +87,7 @@ CONFIG_PHY_IMX8MQ_USB=y
 CONFIG_PINCTRL=y
 CONFIG_PINCTRL_IMX8M=y
 CONFIG_POWER_DOMAIN=y
-CONFIG_IMX8M_POWER_DOMAIN=y
+CONFIG_IMX_GPCV2_POWER_DOMAIN=y
 CONFIG_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_GPIO=y
diff --git a/configs/kontron-osm-s-mx8mp.config b/configs/kontron-osm-s-mx8mp.config
index 786fd3e7a6d..25e29622c8f 100644
--- a/configs/kontron-osm-s-mx8mp.config
+++ b/configs/kontron-osm-s-mx8mp.config
@@ -160,7 +160,7 @@ CONFIG_PINCTRL=y
 CONFIG_SPL_PINCTRL=y
 CONFIG_PINCTRL_IMX8M=y
 CONFIG_POWER_DOMAIN=y
-CONFIG_IMX8M_POWER_DOMAIN=y
+CONFIG_IMX_GPCV2_POWER_DOMAIN=y
 CONFIG_IMX8MP_HSIOMIX_BLKCTRL=y
 CONFIG_DM_PMIC=y
 CONFIG_DM_PMIC_PCA9450=y
diff --git a/configs/kontron-sl-mx8mm_defconfig b/configs/kontron-sl-mx8mm_defconfig
index 08803592016..9d98b9eb2b9 100644
--- a/configs/kontron-sl-mx8mm_defconfig
+++ b/configs/kontron-sl-mx8mm_defconfig
@@ -173,7 +173,7 @@ CONFIG_PINCTRL=y
 CONFIG_SPL_PINCTRL=y
 CONFIG_PINCTRL_IMX8M=y
 CONFIG_POWER_DOMAIN=y
-CONFIG_IMX8M_POWER_DOMAIN=y
+CONFIG_IMX_GPCV2_POWER_DOMAIN=y
 CONFIG_DM_PMIC=y
 CONFIG_DM_PMIC_PCA9450=y
 CONFIG_SPL_DM_PMIC_PCA9450=y
diff --git a/configs/kontron_pitx_imx8m_defconfig b/configs/kontron_pitx_imx8m_defconfig
index ee9690c1ca5..8628419d9ed 100644
--- a/configs/kontron_pitx_imx8m_defconfig
+++ b/configs/kontron_pitx_imx8m_defconfig
@@ -94,7 +94,7 @@ CONFIG_PINCTRL=y
 CONFIG_SPL_PINCTRL=y
 CONFIG_PINCTRL_IMX8M=y
 CONFIG_POWER_DOMAIN=y
-CONFIG_IMX8M_POWER_DOMAIN=y
+CONFIG_IMX_GPCV2_POWER_DOMAIN=y
 CONFIG_DM_PMIC=y
 CONFIG_DM_PMIC_PFUZE100=y
 CONFIG_SPL_DM_PMIC_PFUZE100=y
diff --git a/configs/librem5-devkit_defconfig b/configs/librem5-devkit_defconfig
index c422b150d9a..0838f79ef7e 100644
--- a/configs/librem5-devkit_defconfig
+++ b/configs/librem5-devkit_defconfig
@@ -150,7 +150,7 @@ CONFIG_PINCTRL=y
 CONFIG_PINCTRL_IMX8M=y
 CONFIG_POWER_LEGACY=y
 CONFIG_POWER_DOMAIN=y
-CONFIG_IMX8M_POWER_DOMAIN=y
+CONFIG_IMX_GPCV2_POWER_DOMAIN=y
 CONFIG_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_GPIO=y
diff --git a/configs/librem5_defconfig b/configs/librem5_defconfig
index e2207683875..48fe4040111 100644
--- a/configs/librem5_defconfig
+++ b/configs/librem5_defconfig
@@ -120,7 +120,7 @@ CONFIG_PINCTRL=y
 CONFIG_PINCTRL_IMX8M=y
 CONFIG_POWER_LEGACY=y
 CONFIG_POWER_DOMAIN=y
-CONFIG_IMX8M_POWER_DOMAIN=y
+CONFIG_IMX_GPCV2_POWER_DOMAIN=y
 CONFIG_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_GPIO=y
diff --git a/configs/phycore-imx8mm_defconfig b/configs/phycore-imx8mm_defconfig
index 2be57246add..14aca76e6c2 100644
--- a/configs/phycore-imx8mm_defconfig
+++ b/configs/phycore-imx8mm_defconfig
@@ -116,7 +116,7 @@ CONFIG_PINCTRL=y
 CONFIG_SPL_PINCTRL=y
 CONFIG_PINCTRL_IMX8M=y
 CONFIG_POWER_DOMAIN=y
-CONFIG_IMX8M_POWER_DOMAIN=y
+CONFIG_IMX_GPCV2_POWER_DOMAIN=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_GPIO=y
 CONFIG_DM_RNG=y
diff --git a/configs/phycore-imx8mp_defconfig b/configs/phycore-imx8mp_defconfig
index 93f19641666..089771b646f 100644
--- a/configs/phycore-imx8mp_defconfig
+++ b/configs/phycore-imx8mp_defconfig
@@ -141,7 +141,7 @@ CONFIG_PINCTRL=y
 CONFIG_SPL_PINCTRL=y
 CONFIG_PINCTRL_IMX8M=y
 CONFIG_POWER_DOMAIN=y
-CONFIG_IMX8M_POWER_DOMAIN=y
+CONFIG_IMX_GPCV2_POWER_DOMAIN=y
 CONFIG_IMX8MP_HSIOMIX_BLKCTRL=y
 CONFIG_DM_PMIC=y
 CONFIG_DM_PMIC_PCA9450=y
diff --git a/configs/pico-imx8mq_defconfig b/configs/pico-imx8mq_defconfig
index fbcfcc6509c..1c546be2ede 100644
--- a/configs/pico-imx8mq_defconfig
+++ b/configs/pico-imx8mq_defconfig
@@ -85,7 +85,7 @@ CONFIG_PHY_ATHEROS=y
 CONFIG_PINCTRL=y
 CONFIG_PINCTRL_IMX8M=y
 CONFIG_POWER_DOMAIN=y
-CONFIG_IMX8M_POWER_DOMAIN=y
+CONFIG_IMX_GPCV2_POWER_DOMAIN=y
 CONFIG_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_GPIO=y
diff --git a/configs/toradex-smarc-imx8mp_defconfig b/configs/toradex-smarc-imx8mp_defconfig
index 98b6e346a28..76b5b1da019 100644
--- a/configs/toradex-smarc-imx8mp_defconfig
+++ b/configs/toradex-smarc-imx8mp_defconfig
@@ -146,7 +146,7 @@ CONFIG_PINCTRL=y
 CONFIG_SPL_PINCTRL=y
 CONFIG_PINCTRL_IMX8M=y
 CONFIG_POWER_DOMAIN=y
-CONFIG_IMX8M_POWER_DOMAIN=y
+CONFIG_IMX_GPCV2_POWER_DOMAIN=y
 CONFIG_IMX8MP_HSIOMIX_BLKCTRL=y
 CONFIG_DM_PMIC=y
 CONFIG_DM_PMIC_PCA9450=y
diff --git a/configs/verdin-imx8mm_defconfig b/configs/verdin-imx8mm_defconfig
index c4aa0cf10d4..c7397602aae 100644
--- a/configs/verdin-imx8mm_defconfig
+++ b/configs/verdin-imx8mm_defconfig
@@ -132,7 +132,7 @@ CONFIG_PINCTRL=y
 CONFIG_SPL_PINCTRL=y
 CONFIG_PINCTRL_IMX8M=y
 CONFIG_POWER_DOMAIN=y
-CONFIG_IMX8M_POWER_DOMAIN=y
+CONFIG_IMX_GPCV2_POWER_DOMAIN=y
 CONFIG_DM_PMIC=y
 CONFIG_SPL_DM_PMIC_PCA9450=y
 CONFIG_DM_REGULATOR=y
diff --git a/configs/verdin-imx8mp_defconfig b/configs/verdin-imx8mp_defconfig
index e8fab2cad20..3dc644003e1 100644
--- a/configs/verdin-imx8mp_defconfig
+++ b/configs/verdin-imx8mp_defconfig
@@ -147,7 +147,7 @@ CONFIG_PINCTRL=y
 CONFIG_SPL_PINCTRL=y
 CONFIG_PINCTRL_IMX8M=y
 CONFIG_POWER_DOMAIN=y
-CONFIG_IMX8M_POWER_DOMAIN=y
+CONFIG_IMX_GPCV2_POWER_DOMAIN=y
 CONFIG_IMX8MP_HSIOMIX_BLKCTRL=y
 CONFIG_DM_PMIC=y
 CONFIG_DM_PMIC_PCA9450=y
diff --git a/drivers/power/domain/Kconfig b/drivers/power/domain/Kconfig
index 13a661ce04f..40cc30961c0 100644
--- a/drivers/power/domain/Kconfig
+++ b/drivers/power/domain/Kconfig
@@ -33,6 +33,13 @@ config BCM6328_POWER_DOMAIN
 	  Enable support for manipulating BCM6345 power domains via MMIO
 	  mapped registers.
 
+config IMX_GPCV2_POWER_DOMAIN
+	bool "Enable i.MX8M power domain driver"
+	depends on POWER_DOMAIN && ARCH_IMX8M
+	select CLK
+	help
+	  Enable support for manipulating NXP i.MX8M on-SoC power domains.
+
 config IMX8_POWER_DOMAIN
 	bool "Enable i.MX8 power domain driver"
 	depends on ARCH_IMX8
@@ -40,14 +47,6 @@ config IMX8_POWER_DOMAIN
 	  Enable support for manipulating NXP i.MX8 on-SoC power domains via IPC
 	  requests to the SCU.
 
-config IMX8M_POWER_DOMAIN
-	bool "Enable i.MX8M power domain driver"
-	depends on POWER_DOMAIN && ARCH_IMX8M
-	select CLK
-	help
-	  Enable support for manipulating NXP i.MX8M on-SoC power domains via
-	  requests to the ATF.
-
 config IMX8MP_HSIOMIX_BLKCTRL
 	bool "Enable i.MX8MP HSIOMIX domain driver"
 	depends on POWER_DOMAIN && IMX8MP
diff --git a/drivers/power/domain/Makefile b/drivers/power/domain/Makefile
index 3b816ed3bed..1e6bf57aafb 100644
--- a/drivers/power/domain/Makefile
+++ b/drivers/power/domain/Makefile
@@ -7,8 +7,8 @@ obj-$(CONFIG_$(PHASE_)POWER_DOMAIN) += power-domain-uclass.o
 obj-$(CONFIG_AGILEX5_PMGR_POWER_DOMAIN) += altr-pmgr-agilex5.o
 obj-$(CONFIG_APPLE_PMGR_POWER_DOMAIN) += apple-pmgr.o
 obj-$(CONFIG_BCM6328_POWER_DOMAIN) += bcm6328-power-domain.o
+obj-$(CONFIG_IMX_GPCV2_POWER_DOMAIN) += imx-gpcv2-power-domain.o
 obj-$(CONFIG_IMX8_POWER_DOMAIN) += imx8-power-domain-legacy.o imx8-power-domain.o
-obj-$(CONFIG_IMX8M_POWER_DOMAIN) += imx8m-power-domain.o
 obj-$(CONFIG_IMX8MP_HSIOMIX_BLKCTRL) += imx8mp-hsiomix.o
 obj-$(CONFIG_IMX8MP_MEDIAMIX_BLKCTRL) += imx8mp-mediamix.o
 obj-$(CONFIG_MESON_EE_POWER_DOMAIN) += meson-ee-pwrc.o
diff --git a/drivers/power/domain/imx8m-power-domain.c b/drivers/power/domain/imx-gpcv2-power-domain.c
similarity index 90%
rename from drivers/power/domain/imx8m-power-domain.c
rename to drivers/power/domain/imx-gpcv2-power-domain.c
index a3ef49aa67c..2fc5bf7613e 100644
--- a/drivers/power/domain/imx8m-power-domain.c
+++ b/drivers/power/domain/imx-gpcv2-power-domain.c
@@ -137,7 +137,7 @@ struct imx_pgc_domain_data {
 	const struct imx_pgc_regs *pgc_regs;
 };
 
-struct imx8m_power_domain_plat {
+struct imx_gpcv2_power_domain_plat {
 	struct power_domain pd;
 	const struct imx_pgc_domain *domain;
 	const struct imx_pgc_regs *regs;
@@ -333,10 +333,10 @@ static const struct imx_pgc_domain_data imx8mp_pgc_domain_data = {
 };
 #endif
 
-static int imx8m_power_domain_on(struct power_domain *power_domain)
+static int imx_gpcv2_power_domain_on(struct power_domain *power_domain)
 {
 	struct udevice *dev = power_domain->dev;
-	struct imx8m_power_domain_plat *pdata = dev_get_plat(dev);
+	struct imx_gpcv2_power_domain_plat *pdata = dev_get_plat(dev);
 	const struct imx_pgc_domain *domain = pdata->domain;
 	const struct imx_pgc_regs *regs = pdata->regs;
 	void __iomem *base = pdata->base;
@@ -395,10 +395,10 @@ out_clk_disable:
 	return ret;
 }
 
-static int imx8m_power_domain_off(struct power_domain *power_domain)
+static int imx_gpcv2_power_domain_off(struct power_domain *power_domain)
 {
 	struct udevice *dev = power_domain->dev;
-	struct imx8m_power_domain_plat *pdata = dev_get_plat(dev);
+	struct imx_gpcv2_power_domain_plat *pdata = dev_get_plat(dev);
 	const struct imx_pgc_domain *domain = pdata->domain;
 	const struct imx_pgc_regs *regs = pdata->regs;
 	void __iomem *base = pdata->base;
@@ -462,15 +462,15 @@ out_clk_disable:
 	return ret;
 }
 
-static int imx8m_power_domain_of_xlate(struct power_domain *power_domain,
-				      struct ofnode_phandle_args *args)
+static int imx_gpcv2_power_domain_of_xlate(struct power_domain *power_domain,
+					   struct ofnode_phandle_args *args)
 {
 	power_domain->id = 0;
 
 	return 0;
 }
 
-static int imx8m_power_domain_bind(struct udevice *dev)
+static int imx_gpcv2_power_domain_bind(struct udevice *dev)
 {
 	ofnode subnode;
 	const char *name;
@@ -502,9 +502,9 @@ static int imx8m_power_domain_bind(struct udevice *dev)
 	return 0;
 }
 
-static int imx8m_power_domain_probe(struct udevice *dev)
+static int imx_gpcv2_power_domain_probe(struct udevice *dev)
 {
-	struct imx8m_power_domain_plat *pdata = dev_get_plat(dev);
+	struct imx_gpcv2_power_domain_plat *pdata = dev_get_plat(dev);
 	struct power_domain_plat *plat = dev_get_uclass_plat(dev);
 	int ret;
 
@@ -525,9 +525,9 @@ static int imx8m_power_domain_probe(struct udevice *dev)
 	return 0;
 }
 
-static int imx8m_power_domain_of_to_plat(struct udevice *dev)
+static int imx_gpcv2_power_domain_of_to_plat(struct udevice *dev)
 {
-	struct imx8m_power_domain_plat *pdata = dev_get_plat(dev);
+	struct imx_gpcv2_power_domain_plat *pdata = dev_get_plat(dev);
 	struct imx_pgc_domain_data *domain_data =
 		(struct imx_pgc_domain_data *)dev_get_driver_data(dev);
 
@@ -542,7 +542,7 @@ static int imx8m_power_domain_of_to_plat(struct udevice *dev)
 	return 0;
 }
 
-static const struct udevice_id imx8m_power_domain_ids[] = {
+static const struct udevice_id imx_gpcv2_power_domain_ids[] = {
 #ifdef CONFIG_IMX8MQ
 	{ .compatible = "fsl,imx8mq-gpc", .data = (long)&imx8m_pgc_domain_data },
 #endif
@@ -558,19 +558,19 @@ static const struct udevice_id imx8m_power_domain_ids[] = {
 	{ }
 };
 
-static const struct power_domain_ops imx8m_power_domain_ops = {
-	.on = imx8m_power_domain_on,
-	.off = imx8m_power_domain_off,
-	.of_xlate = imx8m_power_domain_of_xlate,
+static const struct power_domain_ops imx_gpcv2_power_domain_ops = {
+	.on = imx_gpcv2_power_domain_on,
+	.off = imx_gpcv2_power_domain_off,
+	.of_xlate = imx_gpcv2_power_domain_of_xlate,
 };
 
-U_BOOT_DRIVER(imx8m_power_domain) = {
-	.name = "imx8m_power_domain",
+U_BOOT_DRIVER(imx_gpcv2_power_domain) = {
+	.name = "imx_gpcv2_power_domain",
 	.id = UCLASS_POWER_DOMAIN,
-	.of_match = imx8m_power_domain_ids,
-	.bind = imx8m_power_domain_bind,
-	.probe = imx8m_power_domain_probe,
-	.of_to_plat = imx8m_power_domain_of_to_plat,
-	.plat_auto	= sizeof(struct imx8m_power_domain_plat),
-	.ops = &imx8m_power_domain_ops,
+	.of_match = imx_gpcv2_power_domain_ids,
+	.bind = imx_gpcv2_power_domain_bind,
+	.probe = imx_gpcv2_power_domain_probe,
+	.of_to_plat = imx_gpcv2_power_domain_of_to_plat,
+	.plat_auto	= sizeof(struct imx_gpcv2_power_domain_plat),
+	.ops = &imx_gpcv2_power_domain_ops,
 };
-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/

