Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5FCAC2BD09
	for <u-boot@archiver.kernel.org>; Mon,  1 Jul 2024 13:53:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0026886A3;
	Mon,  1 Jul 2024 15:53:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="CzBDyVJ6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 968A88824C; Mon,  1 Jul 2024 08:21:18 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B577888664
 for <u-boot@lists.denx.de>; Mon,  1 Jul 2024 08:21:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Schultz@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1719814876; x=1722406876;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/mmGTTLBpjAphcLbEEXMrgBbfRTFdiFKbVPVaZK+Rjk=;
 b=CzBDyVJ6wUBdQ2CXAK/BzBi6JreLzJlL9sB/O1weBMtKtT+MxMFecFY2XcneULUp
 ZNEIrthkfq4kpupXHdy8poexliNO3kkdpzxNqZySvAt62QKDXbQUbI4I24s+6tAO
 L1AZLbcXYmqfun8mO0ZlEWMPggCperF9dUd3GJ1uyhc=;
X-AuditID: ac14000a-03e52700000021bc-3b-66824adcfe0a
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 5D.A0.08636.CDA42866;
 Mon,  1 Jul 2024 08:21:16 +0200 (CEST)
Received: from ls-radium.phytec (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Mon, 1 Jul 2024
 08:21:14 +0200
From: Daniel Schultz <d.schultz@phytec.de>
To: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
CC: <w.egorov@phytec.de>, <trini@konsulko.com>, <d-gole@ti.com>,
 <mkorpershoek@baylibre.com>, <nm@ti.com>, Daniel Schultz
 <d.schultz@phytec.de>
Subject: [PATCH 2/4] configs: phycore_am64x_a53: Add more commands
Date: Sun, 30 Jun 2024 23:20:48 -0700
Message-ID: <20240701062050.1475249-2-d.schultz@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240701062050.1475249-1-d.schultz@phytec.de>
References: <20240701062050.1475249-1-d.schultz@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLLMWRmVeSWpSXmKPExsWyRpKBR/eOV1Oawb5TmhYtaz0sXhyby27x
 5sdZJoupkzazW7zd28lu0f1O3YHN4/2NVnaPVwdWsXucvbOD0aO/u4XV4/iN7UwBrFFcNimp
 OZllqUX6dglcGWf+nGIpeMFaseNNdQNjE2sXIyeHhICJxLF7G4BsLg4hgSVMEjO/9TNBOPcY
 Jb5s2s4CUsUmoCVxZ8tcZhBbRMBMYtHa82wgRcwCkxklmg8tZAdJCAs4SXSdvgU2lkVAVWLh
 7PtsIDavgJVE965vbBDr5CVmXvoOVs8pYC0x+dZtsHohoJprO+6zQ9QLSpyc+QRsMTNQffPW
 2cwQtoTEwRcvmCHqFSRmb5vMCDNz2rnXzBB2qMSRTauZJjAKzUIyahaSUbOQjFrAyLyKUSg3
 Mzk7tSgzW68go7IkNVkvJXUTIygKRBi4djD2zfE4xMjEwXiIUYKDWUmEN/BXfZoQb0piZVVq
 UX58UWlOavEhRmkOFiVx3tUdwalCAumJJanZqakFqUUwWSYOTqkGxtopnp4Rc3jlfr+ZwrjY
 w70z32xngFoKJyvTVsHjnyet2v/L8ZfyweBt7/8vEixL8uQt2/A8YDL7myDOROv6izHrU7ju
 dRyf0js9XPHQRAaWjLiEXyns119UfwtWW6igq7EsZsO8zF27LbeL8DnkeJ5+otNYnnqtktun
 bfOegr+Pf4hpLZTIVmIpzkg01GIuKk4EALOpQjpwAgAA
X-Mailman-Approved-At: Mon, 01 Jul 2024 15:53:19 +0200
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

Add the rtc command for testing this device. Additionally, add smc
and cache commands to boot non-Linux firmwares on the A53.

Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
---
 configs/phycore_am64x_a53_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/configs/phycore_am64x_a53_defconfig b/configs/phycore_am64x_a53_defconfig
index dac82f99a1a..fe09f79796d 100644
--- a/configs/phycore_am64x_a53_defconfig
+++ b/configs/phycore_am64x_a53_defconfig
@@ -70,7 +70,10 @@ CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_MTD=y
 CONFIG_CMD_USB=y
+CONFIG_CMD_CACHE=y
+CONFIG_CMD_RTC=y
 CONFIG_CMD_TIME=y
+CONFIG_CMD_SMC=y
 CONFIG_OF_CONTROL=y
 CONFIG_SPL_OF_CONTROL=y
 CONFIG_MULTI_DTB_FIT=y
-- 
2.25.1

