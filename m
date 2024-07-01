Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7D75C2BD09
	for <u-boot@archiver.kernel.org>; Mon,  1 Jul 2024 13:53:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A504886B5;
	Mon,  1 Jul 2024 15:53:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="tsckgkFL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 672E788657; Mon,  1 Jul 2024 08:21:23 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E9FF8824C
 for <u-boot@lists.denx.de>; Mon,  1 Jul 2024 08:21:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Schultz@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1719814881; x=1722406881;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=l5PwJ529kbhE7voOA3aOyDqVDvtVaMLKqOZi6fmZ7Vk=;
 b=tsckgkFLE1DLxcvoi0GoNldk6d5qEDDagVv88ij/9+TgJYBXILgXNbzW/ROSs4nN
 vwvGzZY7l6wpqLpeMFmk1LjpnH0qCm7iiLg/arO3ofTEF4986zpXjtjJxUkPCbXt
 bM/tahvtv4JBp5PO9+bo4/4iWlq+D+9GK5TYPpkkyW8=;
X-AuditID: ac14000a-03251700000021bc-44-66824ae022e0
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id D0.B0.08636.0EA42866;
 Mon,  1 Jul 2024 08:21:20 +0200 (CEST)
Received: from ls-radium.phytec (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Mon, 1 Jul 2024
 08:21:18 +0200
From: Daniel Schultz <d.schultz@phytec.de>
To: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
CC: <w.egorov@phytec.de>, <trini@konsulko.com>, <d-gole@ti.com>,
 <mkorpershoek@baylibre.com>, <nm@ti.com>, Daniel Schultz
 <d.schultz@phytec.de>
Subject: [PATCH 4/4] board: phytec: phycore_am64x: Move earlycon into own
 variable
Date: Sun, 30 Jun 2024 23:20:50 -0700
Message-ID: <20240701062050.1475249-4-d.schultz@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240701062050.1475249-1-d.schultz@phytec.de>
References: <20240701062050.1475249-1-d.schultz@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLLMWRmVeSWpSXmKPExsWyRpKBR/eBV1OawckrVhYtaz0sXhyby27x
 5sdZJoupkzazW7zd28lu0f1O3YHN4/2NVnaPVwdWsXucvbOD0aO/u4XV4/iN7UwBrFFcNimp
 OZllqUX6dglcGU9O/mYqaOOomNnUx9rA2MXexcjJISFgInFr72K2LkYuDiGBJUwSC3raWCGc
 e4wSezceYAapYhPQkrizZS6YLSJgJrFo7XmwDmaByYwSzYcWAo3i4BAWCJK4NY8RpIZFQFXi
 w+urLCA2r4CVxLTjs9ggtslLzLz0HWwzp4C1xORbt1lBbCGgmms77rND1AtKnJz5BKyXGai+
 eetsZghbQuLgixfMEPUKErO3TWaEmTnt3GtmCDtU4sim1UwTGIVmIRk1C8moWUhGLWBkXsUo
 lJuZnJ1alJmtV5BRWZKarJeSuokRFAUiDFw7GPvmeBxiZOJgPMQowcGsJMIb+Ks+TYg3JbGy
 KrUoP76oNCe1+BCjNAeLkjjv6o7gVCGB9MSS1OzU1ILUIpgsEwenVANjiYvvXRtBwRm9Sz2j
 bk80fXCt+bCNfBvjtAPP83Qjlgn4yc0stJJ2EPp3UnrbdhW77n1mR/JmR70ru/15wsTap9M6
 H7NnSvK8E1ze4cdX6dewdfohU3Ed6cyyUwY8++9wsJk83qfw+nhM1DITti9cj5PntmluuFbR
 +Gjl5c3RWTmLX1w9/UNWiaU4I9FQi7moOBEAVGxjx3ACAAA=
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
 board/phytec/phycore_am64x/phycore_am64x.env | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/board/phytec/phycore_am64x/phycore_am64x.env b/board/phytec/phycore_am64x/phycore_am64x.env
index ada3a9233be..e24a958f51d 100644
--- a/board/phytec/phycore_am64x/phycore_am64x.env
+++ b/board/phytec/phycore_am64x/phycore_am64x.env
@@ -11,7 +11,8 @@ mmcdev=1
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

