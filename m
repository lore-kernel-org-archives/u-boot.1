Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0ED5C3271E
	for <u-boot@archiver.kernel.org>; Mon,  8 Jul 2024 06:08:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E251B88671;
	Mon,  8 Jul 2024 08:08:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="sqL9f6ju";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0876288671; Mon,  8 Jul 2024 08:08:06 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33A9F88663
 for <u-boot@lists.denx.de>; Mon,  8 Jul 2024 08:08:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Schultz@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1720418883; x=1723010883;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gYdtJH67idd2Zb1C8qek88IMfTa7zgdYprjZLJEzps8=;
 b=sqL9f6ju+33R3AoK4Vi+n+tU0mKrn6Nx3+CE9meCNK20VE91Jp0a0qR/r0hn5neu
 hogipH8ZZlDJBhwGDR4fYfmPtzdJtyWjCDxRC6B49oFMfXjH/1WkaqMaXACqgFs5
 K4Ol/YUj4xQ3vu1f8mTvOJccvWK5D1msYp446MQEsMo=;
X-AuditID: ac14000a-03251700000021bc-5b-668b8243e52f
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 82.21.08636.3428B866;
 Mon,  8 Jul 2024 08:08:03 +0200 (CEST)
Received: from ls-radium.phytec (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Mon, 8 Jul 2024
 08:08:00 +0200
From: Daniel Schultz <d.schultz@phytec.de>
To: <u-boot@lists.denx.de>, <trini@konsulko.com>, <joe.hershberger@ni.com>,
 <w.egorov@phytec.de>
CC: <d-gole@ti.com>, <nm@ti.com>, <mkorpershoek@baylibre.com>,
 <upstream@lists.phytec.de>, <t.remmet@phytec.de>, <y.moog@phytec.de>,
 <m-chawdhry@ti.com>, <kamlesh@ti.com>, <jm@ti.com>, <B.Hahn@phytec.de>,
 Daniel Schultz <d.schultz@phytec.de>
Subject: [PATCH 4/6] board: phytec: common: Kconfig: Enable
 SUPPORT_EXTENSION_SCAN
Date: Sun, 7 Jul 2024 23:07:32 -0700
Message-ID: <20240708060734.4029040-5-d.schultz@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240708060734.4029040-1-d.schultz@phytec.de>
References: <20240708060734.4029040-1-d.schultz@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKLMWRmVeSWpSXmKPExsWyRpKBR9e5qTvNYM8RDYuWtR4Wnz5kWnza
 +ZjV4mj/GmaLSw9SLV4cm8tu8ebHWSaLqZM2s1u83dvJbtH9Tt2By+P9jVZ2j1cHVrF7nL2z
 g9Gjv7uF1eP6me1MHsdvbGcKYIvisklJzcksSy3St0vgyjh67RdzwR72io1H57I3MM5j62Lk
 5JAQMJHo7L4EZHNxCAksYZKYfriLGcK5xyhxfvs8JpAqNgEtiTtb5jKD2CICSRLLLnayghQx
 C3xnlHjx8RcrSEJYIEji2JMJYA0sAioSfRPugtm8AlYSP+c/hVonLzHz0nd2EJtTwFri0bRO
 FhBbCKhm7uQNbBD1ghInZz4BizMD1Tdvnc0MYUtIHHzxghmiXkFi9rbJjDAzp517zQxhh0oc
 2bSaaQKj0Cwko2YhGTULyagFjMyrGIVyM5OzU4sys/UKMipLUpP1UlI3MYKiRoSBawdj3xyP
 Q4xMHIyHGCU4mJVEeE8/bk8T4k1JrKxKLcqPLyrNSS0+xCjNwaIkzru6IzhVSCA9sSQ1OzW1
 ILUIJsvEwSnVwLhsn1Hq6/nbz84OfbVyjXvOIn2/aZqX3FY3bF/A2Xpq+QH+xLVd6i89jz/L
 +aMfsrPE49MtecalCy8d3hbvxBDz4fzLhqQvkYGsJ9gmi2Svn5G53+B8z8qTds/OHIqT4j2T
 2RPmfUD6x2GZVaeWb/ike9HJ58V+7Sb++XYXhVycL6Rl/C3JTpZUYinOSDTUYi4qTgQAoocL
 OIgCAAA=
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

Enable SUPPORT_EXTENSION_SCAN for the phyCORE-AM62x and -AM64x
boards.

Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
---
 board/phytec/common/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/board/phytec/common/Kconfig b/board/phytec/common/Kconfig
index f394ace786a..120f58b6ec6 100644
--- a/board/phytec/common/Kconfig
+++ b/board/phytec/common/Kconfig
@@ -24,6 +24,7 @@ config PHYTEC_AM62_SOM_DETECTION
 	depends on (TARGET_PHYCORE_AM62X_A53 || TARGET_PHYCORE_AM62X_R5) && \
 		   PHYTEC_SOM_DETECTION
 	select PHYTEC_SOM_DETECTION_BLOCKS
+	select SUPPORT_EXTENSION_SCAN
 	depends on SPL_I2C && DM_I2C
 	default y
 	help
@@ -35,6 +36,7 @@ config PHYTEC_AM64_SOM_DETECTION
 	depends on (TARGET_PHYCORE_AM64X_A53 || TARGET_PHYCORE_AM64X_R5) && \
 		   PHYTEC_SOM_DETECTION
 	select PHYTEC_SOM_DETECTION_BLOCKS
+	select SUPPORT_EXTENSION_SCAN
 	depends on SPL_I2C && DM_I2C
 	default y
 	help
-- 
2.25.1

