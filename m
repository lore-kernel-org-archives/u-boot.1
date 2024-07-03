Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8E7AC30653
	for <u-boot@archiver.kernel.org>; Wed,  3 Jul 2024 13:48:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 211FC8886D;
	Wed,  3 Jul 2024 15:46:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="hyuhPaqu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD00388784; Wed,  3 Jul 2024 07:42:52 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A507887C6
 for <u-boot@lists.denx.de>; Wed,  3 Jul 2024 07:42:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Schultz@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1719985370; x=1722577370;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GMIu+Sp6Pq2EEN87mMA+bwaQvuJ41Aa0rmdb4m9yrEE=;
 b=hyuhPaqumggF9SUCoPKdS048Wq17nbP7oFGkaGdCKN8Bs+lDu1SZAqI+eQBT60vz
 vISixSUiydQSHvGv5PfCmby7FSul2OXwOOZRm3VLEobs+aD3qGycUx21s8DGMQb1
 nlwaA8pq4HLrzEu1iBThEH1b2YUXsznHw+8KjhElCho=;
X-AuditID: ac14000a-03251700000021bc-83-6684e4d9ab62
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 7B.7D.08636.AD4E4866;
 Wed,  3 Jul 2024 07:42:50 +0200 (CEST)
Received: from ls-radium.phytec (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 3 Jul 2024
 07:42:47 +0200
From: Daniel Schultz <d.schultz@phytec.de>
To: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>, <trini@konsulko.com>, 
 <m.othacehe@gmail.com>, <joe.hershberger@ni.com>, <w.egorov@phytec.de>,
 <t.remmet@phytec.de>
CC: <d-gole@ti.com>, <festevam@gmail.com>, <mkorpershoek@baylibre.com>,
 <sjg@chromium.org>, Daniel Schultz <d.schultz@phytec.de>
Subject: [PATCH 8/9] board: phytec: phycore_am62x: Use k3_mmc.env logic
Date: Tue, 2 Jul 2024 22:42:01 -0700
Message-ID: <20240703054202.2812540-9-d.schultz@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240703054202.2812540-1-d.schultz@phytec.de>
References: <20240703054202.2812540-1-d.schultz@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNLMWRmVeSWpSXmKPExsWyRpKBR/fWk5Y0g++nGS1a1npYPLzqb/Fp
 52NWixk3p7FZvDg2l93i25ZtjBZTJ21mt3i7t5PdovudugOnx/sbrewesxsusnjsnHWX3ePV
 gVXsHmfv7GD06O9uYfW4fmY7k8fxG9uZAjiiuGxSUnMyy1KL9O0SuDImvOphLDjFUfF03mW2
 BsY97F2MnBwSAiYS707fYO5i5OIQEljCJPH7zSYmCOceo8Tfn+3MIFVsAloSd7bMBasSEVjH
 KDH3CkQVs0ATo8TElstMIFXCAu4Sj76fAOtgEVCROPNlDhuIzStgJdF+9yErxD55iZmXvoPt
 5hSwlpj8+zlQPQfQOiuJhX/MIcoFJU7OfMICYjMDlTdvnc0MYUtIHHzxAswWElCQmL1tMiPM
 yGnnXjND2KESW79sZ5rAKDQLyahZSEbNQjJqASPzKkah3Mzk7NSizGy9gozKktRkvZTUTYyg
 CBJh4NrB2DfH4xAjEwfjIUYJDmYlEV6p981pQrwpiZVVqUX58UWlOanFhxilOViUxHlXdwSn
 CgmkJ5akZqemFqQWwWSZODilGhgV7q+MfXzp3JND52J0Jqz//OiCqJ/s+jamo6Fz961gOemn
 f/B7zfSDwVP4nefK/JXemr1AT6uUk3NRx5+iPcvzuqcqZtnpqPm821tg01c77+67FX+eaWy9
 6qa/Z0d/aOfR6Pe/38UkHM05Ysxdtd6+rc3V/VlF9H6llP1HZVMthHu4ZKZYxDxXYinOSDTU
 Yi4qTgQAB9AbR44CAAA=
X-Mailman-Approved-At: Wed, 03 Jul 2024 15:46:48 +0200
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

Use our common environment file to implement MMC boot.

Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
---
 board/phytec/phycore_am62x/phycore_am62x.env | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/board/phytec/phycore_am62x/phycore_am62x.env b/board/phytec/phycore_am62x/phycore_am62x.env
index 2d6475d408f..046bbd22f25 100644
--- a/board/phytec/phycore_am62x/phycore_am62x.env
+++ b/board/phytec/phycore_am62x/phycore_am62x.env
@@ -1,4 +1,5 @@
 #include <env/ti/k3_dfu.env>
+#include <env/phytec/k3_mmc.env>
 
 fdtaddr=0x88000000
 loadaddr=0x82000000
@@ -14,13 +15,3 @@ mmcroot=2
 mmcpart=1
 console=ttyS2,115200n8
 earlycon=ns16550a,mmio32,0x02800000
-mmcargs=setenv bootargs console=${console} earlycon=${earlycon}
-	root=/dev/mmcblk${mmcdev}p${mmcroot} rootwait rw
-loadimage=load mmc ${mmcdev}:${mmcpart} ${loadaddr} Image
-loadfdt=load mmc ${mmcdev}:${mmcpart} ${fdtaddr} ${fdtfile}
-mmcboot=run mmcargs;
-	mmc dev ${mmcdev};
-	mmc rescan;
-	run loadimage;
-	run loadfdt;
-	booti ${loadaddr} - ${fdtaddr}
-- 
2.25.1

