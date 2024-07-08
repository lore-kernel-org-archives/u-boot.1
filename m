Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A46D6C3DA42
	for <u-boot@archiver.kernel.org>; Mon,  8 Jul 2024 06:08:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 583E988677;
	Mon,  8 Jul 2024 08:08:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="qkdrNAao";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86CE5884C6; Mon,  8 Jul 2024 08:08:09 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 19C2488677
 for <u-boot@lists.denx.de>; Mon,  8 Jul 2024 08:08:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Schultz@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1720418887; x=1723010887;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NCsdmF9EJBeA/GT09NtJK05wVbJVNO8+8+rCZpcJ/PE=;
 b=qkdrNAaok8ReHFZjDZbih/MGRMZlel+Z/KWn4FEIjGOuNtP8PIo5ttoMURl2sq6R
 UlKPHV49wuVMS4syxLA873B9NElOC8TOBYqfQJq0atCCbbL/Eue8KooAFl6GV9G5
 pJzOviuHD4gkI731wLEk3aOX8i4vVDgWHSQ0Qiu+W3E=;
X-AuditID: ac14000a-03251700000021bc-61-668b82469e07
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id A4.21.08636.6428B866;
 Mon,  8 Jul 2024 08:08:06 +0200 (CEST)
Received: from ls-radium.phytec (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Mon, 8 Jul 2024
 08:08:03 +0200
From: Daniel Schultz <d.schultz@phytec.de>
To: <u-boot@lists.denx.de>, <trini@konsulko.com>, <joe.hershberger@ni.com>,
 <w.egorov@phytec.de>
CC: <d-gole@ti.com>, <nm@ti.com>, <mkorpershoek@baylibre.com>,
 <upstream@lists.phytec.de>, <t.remmet@phytec.de>, <y.moog@phytec.de>,
 <m-chawdhry@ti.com>, <kamlesh@ti.com>, <jm@ti.com>, <B.Hahn@phytec.de>,
 Daniel Schultz <d.schultz@phytec.de>
Subject: [PATCH 5/6] configs: phytec_am62x_a53_defconfig: Set
 CONFIG_CMD_EXTENSION
Date: Sun, 7 Jul 2024 23:07:33 -0700
Message-ID: <20240708060734.4029040-6-d.schultz@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240708060734.4029040-1-d.schultz@phytec.de>
References: <20240708060734.4029040-1-d.schultz@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCLMWRmVeSWpSXmKPExsWyRpKBR9e9qTvNYKu4RctaD4tPHzItPu18
 zGpxtH8Ns8WlB6kWL47NZbd48+Msk8XUSZvZLd7u7WS36H6n7sDl8f5GK7vHqwOr2D3O3tnB
 6NHf3cLqcf3MdiaP4ze2MwWwRXHZpKTmZJalFunbJXBlrFh0kLVgGmvFpJMrWBoYj7J0MXJy
 SAiYSHRf2sPcxcjFISSwhEli8bMnrBDOPUaJR4uvsIFUsQloSdzZMpcZxBYRSJJYdrETrIhZ
 4DujxIuPv1hBEsICQRLz3uwEK2IRUJGY93g7I4jNK2AlceX4OTaIdfISMy99ZwexOQWsJR5N
 6wQ7QwioZu7kDWwQ9YISJ2c+AYszA9U3b53NDGFLSBx88YIZol5BYva2yYwwM6ede80MYYdK
 HNm0mmkCo9AsJKNmIRk1C8moBYzMqxiFcjOTs1OLMrP1CjIqS1KT9VJSNzGCYkaEgWsHY98c
 j0OMTByMhxglOJiVRHhPP25PE+JNSaysSi3Kjy8qzUktPsQozcGiJM67uiM4VUggPbEkNTs1
 tSC1CCbLxMEp1cBo2Xxr6p/T/f8YnKS2r2vZwHz/yhFdRb2KBhPH/4uqtBWsQxasq9tv96+g
 bf9H6ejU5mtB5/SuSGz+IPFtftpCx6vO0R7sazZ/vCvFpcB39PfhPQbMjz32hxZbrr7yTHNf
 hY+uTRf3lX9GJqwxK40vRl5LllIUvRLp85972dnTm9sKfh4XOlWgxFKckWioxVxUnAgAfjXj
 G4cCAAA=
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

CONFIG_CMD_EXTENSION is required to load SOM detection overlays.

Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
---
 configs/phycore_am62x_a53_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/phycore_am62x_a53_defconfig b/configs/phycore_am62x_a53_defconfig
index 06b8834e074..ec75b1a424d 100644
--- a/configs/phycore_am62x_a53_defconfig
+++ b/configs/phycore_am62x_a53_defconfig
@@ -63,6 +63,7 @@ CONFIG_SPL_SPI_FLASH_SFDP_SUPPORT=y
 CONFIG_SPL_SPI_LOAD=y
 CONFIG_SYS_SPI_U_BOOT_OFFS=0x280000
 CONFIG_SPL_YMODEM_SUPPORT=y
+CONFIG_CMD_EXTENSION=y
 CONFIG_CMD_DFU=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
-- 
2.25.1

