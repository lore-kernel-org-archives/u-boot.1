Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6186C3271E
	for <u-boot@archiver.kernel.org>; Mon,  8 Jul 2024 06:09:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B89DC886BB;
	Mon,  8 Jul 2024 08:08:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="M076b+ns";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D1F5886B1; Mon,  8 Jul 2024 08:08:12 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6571B884C6
 for <u-boot@lists.denx.de>; Mon,  8 Jul 2024 08:08:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Schultz@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1720418890; x=1723010890;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=UJO9XkK60JJzJoCu4F0wRlx6L8TGpfxQzstoM7Ep/8Q=;
 b=M076b+nsWDAOQG+V+wLN8zfHZ9JqoY94cI4pUBfm4NNeGwdWKnClyGo06mj2bCxc
 qK3Eb5ttfy+Zsop0X8rf0BYec2NzU/a/pGAHKahalJzsiZvQ1VDoXM1raeEfq3Kc
 JxZv1WclxG3zuAg/LSPEhH4Ci41gpBN6ZXltkBIiqnE=;
X-AuditID: ac14000a-03251700000021bc-65-668b824ae6b7
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 76.21.08636.A428B866;
 Mon,  8 Jul 2024 08:08:10 +0200 (CEST)
Received: from ls-radium.phytec (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Mon, 8 Jul 2024
 08:08:07 +0200
From: Daniel Schultz <d.schultz@phytec.de>
To: <u-boot@lists.denx.de>, <trini@konsulko.com>, <joe.hershberger@ni.com>,
 <w.egorov@phytec.de>
CC: <d-gole@ti.com>, <nm@ti.com>, <mkorpershoek@baylibre.com>,
 <upstream@lists.phytec.de>, <t.remmet@phytec.de>, <y.moog@phytec.de>,
 <m-chawdhry@ti.com>, <kamlesh@ti.com>, <jm@ti.com>, <B.Hahn@phytec.de>,
 Daniel Schultz <d.schultz@phytec.de>
Subject: [PATCH 6/6] configs: phycore_am64x_a53_defconfig: Enable SOM detection
Date: Sun, 7 Jul 2024 23:07:34 -0700
Message-ID: <20240708060734.4029040-7-d.schultz@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240708060734.4029040-1-d.schultz@phytec.de>
References: <20240708060734.4029040-1-d.schultz@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrELMWRmVeSWpSXmKPExsWyRpKBR9erqTvNYMNfYYuWtR4Wnz5kWnza
 +ZjV4mj/GmaLSw9SLV4cm8tu8ebHWSaLqZM2s1u83dvJbtH9Tt2By+P9jVZ2j1cHVrF7nL2z
 g9Gjv7uF1eP6me1MHsdvbGcKYIvisklJzcksSy3St0vgyth9WKngIXvF5lVT2BsY37F1MXJy
 SAiYSOy+f4+5i5GLQ0hgCZPE574NrCAJIYF7jBIn/2SC2GwCWhJ3tsxlBrFFBJIkll3sZAVp
 YBb4zijx4uMvsAZhAX+J5bMfAk3l4GARUJFo2OMDEuYVsJJYOesSE8QyeYmZl76zg9icAtYS
 j6Z1skDsspKYO3kDG0S9oMTJmU/A4sxA9c1bZzND2BISB1+8YIaoV5CYvW0yI8zMaedeM0PY
 oRJHNq1mmsAoNAvJqFlIRs1CMmoBI/MqRqHczOTs1KLMbL2CjMqS1GS9lNRNjKB4EWHg2sHY
 N8fjECMTB+MhRgkOZiUR3tOP29OEeFMSK6tSi/Lji0pzUosPMUpzsCiJ867uCE4VEkhPLEnN
 Tk0tSC2CyTJxcEo1MKau3/LFK0uUOY+3aWvlx6A1i2ONTmRbLJz8Pfn2ywfcTt3zWras/zpH
 rakxNqDq9MzV+x1O//j37PQ2kZoIKcOUpkl9SgHrzdIOnLA7d7B94p+ss9Ob4+6cnVDQV7Y8
 JqVdcvXX6QU8cxwd7t+SWXNzuV0zZ2GPevTb442bPt7eItDRmi3F7aHEUpyRaKjFXFScCABb
 k9y5hQIAAA==
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

Enable SOM detection for the phyCORE-AM64x and also set
CONFIG_CMD_EXTENSION as requirement for this feature.

Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
---
 configs/phycore_am64x_a53_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configs/phycore_am64x_a53_defconfig b/configs/phycore_am64x_a53_defconfig
index fe09f79796d..c4145e9c10c 100644
--- a/configs/phycore_am64x_a53_defconfig
+++ b/configs/phycore_am64x_a53_defconfig
@@ -10,6 +10,7 @@ CONFIG_NR_DRAM_BANKS=2
 CONFIG_SOC_K3_AM642=y
 CONFIG_K3_ATF_LOAD_ADDR=0x701c0000
 CONFIG_TARGET_PHYCORE_AM64X_A53=y
+CONFIG_PHYTEC_SOM_DETECTION=y
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x80480000
 CONFIG_ENV_SIZE=0x20000
@@ -63,6 +64,7 @@ CONFIG_SPL_SPI_FLASH_SFDP_SUPPORT=y
 CONFIG_SPL_SPI_LOAD=y
 CONFIG_SYS_SPI_U_BOOT_OFFS=0x280000
 CONFIG_SPL_YMODEM_SUPPORT=y
+CONFIG_CMD_EXTENSION=y
 CONFIG_CMD_ASKENV=y
 CONFIG_CMD_DFU=y
 CONFIG_CMD_GPT=y
-- 
2.25.1

