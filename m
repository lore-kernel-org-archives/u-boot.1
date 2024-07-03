Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 196CEC30653
	for <u-boot@archiver.kernel.org>; Wed,  3 Jul 2024 13:48:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B6EC188867;
	Wed,  3 Jul 2024 15:46:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="r1dXmvBN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 13FF8887C7; Wed,  3 Jul 2024 07:42:49 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4232088784
 for <u-boot@lists.denx.de>; Wed,  3 Jul 2024 07:42:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Schultz@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1719985367; x=1722577367;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=H6tDJ8Ts6ewX6N9Vvm9z6tzX0WHPPfkLLx7FGRhpWvc=;
 b=r1dXmvBNWTuQHJexWuk1kyvcVWzZan4pz0pkgJb3kVBUS0mfUT0fWHD9yDCSRMws
 2BAbm4/wzJxoYT6uZX4aRyHyBAwKrV3LpkiBDX4lQfB6XM75B39q/tGhv+jNIoqn
 wdSfAQT/+r9RJB7Ax2rwZJBfXLm0ufUmRjIDQlhjX/o=;
X-AuditID: ac14000a-03251700000021bc-7f-6684e4d7561f
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 99.7D.08636.7D4E4866;
 Wed,  3 Jul 2024 07:42:47 +0200 (CEST)
Received: from ls-radium.phytec (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 3 Jul 2024
 07:42:44 +0200
From: Daniel Schultz <d.schultz@phytec.de>
To: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>, <trini@konsulko.com>, 
 <m.othacehe@gmail.com>, <joe.hershberger@ni.com>, <w.egorov@phytec.de>,
 <t.remmet@phytec.de>
CC: <d-gole@ti.com>, <festevam@gmail.com>, <mkorpershoek@baylibre.com>,
 <sjg@chromium.org>, Daniel Schultz <d.schultz@phytec.de>
Subject: [PATCH 7/9] include: env: phytec: k3_mmc: Apply overlays during boot
Date: Tue, 2 Jul 2024 22:42:00 -0700
Message-ID: <20240703054202.2812540-8-d.schultz@phytec.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240703054202.2812540-1-d.schultz@phytec.de>
References: <20240703054202.2812540-1-d.schultz@phytec.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJLMWRmVeSWpSXmKPExsWyRpKBR/f6k5Y0g7dzeCxa1npYPLzqb/Fp
 52NWixk3p7FZvDg2l93i25ZtjBZTJ21mt3i7t5PdovudugOnx/sbrewesxsusnjsnHWX3ePV
 gVXsHmfv7GD06O9uYfW4fmY7k8fxG9uZAjiiuGxSUnMyy1KL9O0SuDL6b71gLPjIVrHl7m+W
 BsYHrF2MnBwSAiYS53Y8ZwSxhQSWMEnMm6QAYd9jlFi8JgPEZhPQkrizZS5zFyMXh4jAOkaJ
 uVc2MYE4zAJNjBITWy4zgVQJC/hKrNyzCMxmEVCRmH7gPQuIzStgJfHr0l1GiG3yEjMvfWcH
 sTkFrCUm/34ONJUDaJuVxMI/5hDlghInZz4Ba2UGKm/eOpsZwpaQOPjiBTPEcQoSs7dNhhs5
 7dxrZgg7VGLrl+1MExiFZiEZNQvJqFlIRi1gZF7FKJSbmZydWpSZrVeQUVmSmqyXkrqJERQ9
 IgxcOxj75ngcYmTiYDzEKMHBrCTCK/W+OU2INyWxsiq1KD++qDQntfgQozQHi5I47+qO4FQh
 gfTEktTs1NSC1CKYLBMHp1QD41zBn2KlhRVP+1Z05Rx/3Haww+1F0YdjXx9vk2sxKpux+WTm
 zykcRd9mPo8q2zePx07SZiHbDl63eVceZrn1/ZH8uGHZvsvXhLMalyqI6AS2yoZYXtMU4A/o
 CNi7dafVCoFyfsHNnbbZzkdvr3BZmVYQ/ba77bXVpIkLLDJv3Y+ctaMm/Eb3RCWW4oxEQy3m
 ouJEAIKwoV6MAgAA
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

Include the overlays.env file and run the apply routine before
booting the Kernel.

Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
---
 include/env/phytec/k3_mmc.env | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/env/phytec/k3_mmc.env b/include/env/phytec/k3_mmc.env
index e1208a6eea1..3d3595ceb7e 100644
--- a/include/env/phytec/k3_mmc.env
+++ b/include/env/phytec/k3_mmc.env
@@ -6,6 +6,8 @@
 
 /* Logic for TI K3 based SoCs to boot from a MMC device. */
 
+#include <env/phytec/overlays.env>
+
 mmcargs=setenv bootargs console=${console} earlycon=${earlycon}
 	root=/dev/mmcblk${mmcdev}p${mmcroot} rootwait rw
 loadimage=load mmc ${mmcdev}:${mmcpart} ${loadaddr} Image
@@ -15,4 +17,5 @@ mmcboot=run mmcargs;
 	mmc rescan;
 	run loadimage;
 	run loadfdt;
+	run mmc_apply_overlays;
 	booti ${loadaddr} - ${fdt_addr_r}
-- 
2.25.1

