Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D0B2C2BD09
	for <u-boot@archiver.kernel.org>; Mon,  1 Jul 2024 13:53:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2385D886AB;
	Mon,  1 Jul 2024 15:53:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="PmHFwjdJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4EFF88657; Mon,  1 Jul 2024 08:21:20 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED8458824C
 for <u-boot@lists.denx.de>; Mon,  1 Jul 2024 08:21:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Schultz@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1719814878; x=1722406878;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Bn2n5NVkC7t1q6wggQyIhl3UUX4Gc/lBP6biGUSjvPo=;
 b=PmHFwjdJcLSvW6VV8RTAERRmpffQmXMs13/o0FEwQuRe+D0bQIT6oob5OdhOQ44W
 /Fp2/LERz9geXz8MgUo5lwTGqswQgj++Xd3xlSUSqX0nqR5jKG+PVI9o5/Ac0Jw/
 5UbWSHltDr4tdYVfaiwy+1SUjsOeZKXYW4TqV3LzTow=;
X-AuditID: ac14000a-03251700000021bc-40-66824ade2065
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 1F.A0.08636.EDA42866;
 Mon,  1 Jul 2024 08:21:18 +0200 (CEST)
Received: from ls-radium.phytec (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Mon, 1 Jul 2024
 08:21:16 +0200
From: Daniel Schultz <d.schultz@phytec.de>
To: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
CC: <w.egorov@phytec.de>, <trini@konsulko.com>, <d-gole@ti.com>,
 <mkorpershoek@baylibre.com>, <nm@ti.com>, Daniel Schultz
 <d.schultz@phytec.de>
Subject: [PATCH 3/4] board: phytec: phycore_am62x: Move earlycon into own
 variable
Date: Sun, 30 Jun 2024 23:20:49 -0700
Message-ID: <20240701062050.1475249-3-d.schultz@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240701062050.1475249-1-d.schultz@phytec.de>
References: <20240701062050.1475249-1-d.schultz@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHLMWRmVeSWpSXmKPExsWyRpKBR/eeV1OawZXDhhYtaz0sXhyby27x
 5sdZJoupkzazW7zd28lu0f1O3YHN4/2NVnaPVwdWsXucvbOD0aO/u4XV4/iN7UwBrFFcNimp
 OZllqUX6dglcGYu3TGApaOOo+Lb0HWsDYxd7FyMnh4SAicTvSY1sXYxcHEICS5gkfr6bxwrh
 3GOU2P73ODNIFZuAlsSdLXPBbBEBM4lFa8+DdTALTGaUaD60EGyUsECQxM1ZX1lBbBYBVYm1
 j3vB4rwCVhLP199lglgnLzHz0newOKeAtcTkW7fB6oWAaq7tuA9VLyhxcuYTFhCbGai+eets
 ZghbQuLgixfMEPUKErO3TWaEmTnt3GtmCDtU4sim1UwTGIVmIRk1C8moWUhGLWBkXsUolJuZ
 nJ1alJmtV5BRWZKarJeSuokRFAciDFw7GPvmeBxiZOJgPMQowcGsJMIb+Ks+TYg3JbGyKrUo
 P76oNCe1+BCjNAeLkjjv6o7gVCGB9MSS1OzU1ILUIpgsEwenVAOj7sKatjkfgiasvfvT7960
 NdcvdixRmdBv/bGl4/lT3fL/c9bqbFpa6aa64rAOP0tL7T0b7jzV4Cmbs6rcElexLRCf3ui9
 /v+5lVVpDP8+OGWU3FnwVU/f6MGsp/YruS8vueAkO+u/vkN7+95EjWXHfb5FW/Gr+GydLvQl
 07dDPqRC88S3CDtDJZbijERDLeai4kQAujj5c3ECAAA=
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

By moving the earlycon definition into a dedicated variable, it's
easier to change these values in case the kernel should print on
a different serial interface.

Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
---
 board/phytec/phycore_am62x/phycore_am62x.env | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/board/phytec/phycore_am62x/phycore_am62x.env b/board/phytec/phycore_am62x/phycore_am62x.env
index 42db26a5990..2d6475d408f 100644
--- a/board/phytec/phycore_am62x/phycore_am62x.env
+++ b/board/phytec/phycore_am62x/phycore_am62x.env
@@ -13,7 +13,8 @@ mmcdev=1
 mmcroot=2
 mmcpart=1
 console=ttyS2,115200n8
-mmcargs=setenv bootargs console=${console} earlycon=ns16550a,mmio32,0x02800000
+earlycon=ns16550a,mmio32,0x02800000
+mmcargs=setenv bootargs console=${console} earlycon=${earlycon}
 	root=/dev/mmcblk${mmcdev}p${mmcroot} rootwait rw
 loadimage=load mmc ${mmcdev}:${mmcpart} ${loadaddr} Image
 loadfdt=load mmc ${mmcdev}:${mmcpart} ${fdtaddr} ${fdtfile}
-- 
2.25.1

