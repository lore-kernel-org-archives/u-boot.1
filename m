Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7E9AC4707B
	for <u-boot@archiver.kernel.org>; Wed, 10 Jan 2024 13:36:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E23D687AB3;
	Wed, 10 Jan 2024 14:36:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="XIpq1ZUi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB6C587AE2; Wed, 10 Jan 2024 14:35:59 +0100 (CET)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D9A687AB7
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 14:35:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1704893755; x=1707485755;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6SN6aOzwIP+Y9cmzEVeFtYtx89weEOXxuCDlIzEued0=;
 b=XIpq1ZUiLmPV+2khjIJXVhQyTiklC90zcQRHTKHX7q0etz2EX0Vc+oXBXLxFJg+M
 wq/mrCRDtszu5UG9e5vb/c3ZdOEhIz1VLLTKyS6XWmDICW9L4Ce9bcg42YNZjy8I
 xGoToEaoBe91+eNvvMXDGB7uhONKegWKWhHc/We2WQs=;
X-AuditID: ac14000a-fbefe7000000290d-2b-659e9d3bb39b
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 47.95.10509.B3D9E956;
 Wed, 10 Jan 2024 14:35:55 +0100 (CET)
Received: from lws-moog.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 10 Jan
 2024 14:35:55 +0100
From: Yannic Moog <y.moog@phytec.de>
Date: Wed, 10 Jan 2024 14:35:46 +0100
Subject: [PATCH v2 3/3] board: phytec: MAINTAINERS: add missing phytec doc
 files
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240110-wip-y-moog-phytec-de-tauri-l_upstream-v2-3-4ea2dd6a4f74@phytec.de>
References: <20240110-wip-y-moog-phytec-de-tauri-l_upstream-v2-0-4ea2dd6a4f74@phytec.de>
In-Reply-To: <20240110-wip-y-moog-phytec-de-tauri-l_upstream-v2-0-4ea2dd6a4f74@phytec.de>
To: Fabio Estevam <festevam@gmail.com>, NXP i.MX U-Boot Team
 <uboot-imx@nxp.com>, Teresa Remmet <t.remmet@phytec.de>
CC: <upstream@lists.phytec.de>, <u-boot@lists.denx.de>, Yannic Moog
 <y.moog@phytec.de>
X-Mailer: b4 0.12.3
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNLMWRmVeSWpSXmKPExsWyRpKBR9d67rxUg32XLC0eXvW3eLu3k91i
 yuP17Bbd79QdWDx2zrrL7nH2zg5Gj/7uFlaPje92MAWwRHHZpKTmZJalFunbJXBlzLp+kLlg
 EVfF4e1PGBsYf3B0MXJySAiYSFxu/M7excjFISSwmElixpF7bBDOQ0aJHy862UGq2ARUJB6/
 uMcKYrMIqEq0btrDBGILCwRJrOm8ClbDKyAocXLmE5YuRg4OZgFNifW79EHCzALyEtvfzmGG
 KImQONbWC2YLAdmvPy0DG8kpEClxqHcLC4gtIlAmsa23H2pMhMScR2YQdwpLtC+6xQTRKivx
 4nwvO0RcXmLaudfMEHaoxJFNq5kmMArNQnLQLISDZiE5aAEj8ypGodzM5OzUosxsvYKMypLU
 ZL2U1E2MoAAXYeDawdg3x+MQIxMH4yFGCQ5mJRFehc9zUoV4UxIrq1KL8uOLSnNSiw8xSnOw
 KInzru4IThUSSE8sSc1OTS1ILYLJMnFwSjUwep7V89hzirXxz5bjC2wljzmfNf10PPR99MOT
 xXNupx/xDzzgG+bw7c8i2SfysUf7D04Xbp7vpynxeJfHsqjEHU9W3hHsuBFqdbUtSjp75fkO
 nyMxPofkSr4cFrRter1Ub83NQs6s2LNhOc9Yt21ZJRAQFSCrudJFdsqvdRIhW5ieCFx9y226
 QYmlOCPRUIu5qDgRAGrNS5leAgAA
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

Add rst documentation files to the respective MAINTAINERS file for
PHYTEC boards.

Signed-off-by: Yannic Moog <y.moog@phytec.de>
---
 board/phytec/phycore_imx8mm/MAINTAINERS | 1 +
 board/phytec/phycore_imx8mp/MAINTAINERS | 1 +
 2 files changed, 2 insertions(+)

diff --git a/board/phytec/phycore_imx8mm/MAINTAINERS b/board/phytec/phycore_imx8mm/MAINTAINERS
index cf6f92c07e5..e46e3691bac 100644
--- a/board/phytec/phycore_imx8mm/MAINTAINERS
+++ b/board/phytec/phycore_imx8mm/MAINTAINERS
@@ -12,4 +12,5 @@ F:	configs/imx8mm-phygate-tauri-l_defconfig
 F:      configs/phycore-imx8mm_defconfig
 F:	doc/board/phytec/imx8mm-phygate-tauri-l.rst
 F:	doc/board/phytec/index.rst
+F:	doc/board/phytec/phycore_imx8mm.rst
 F:      include/configs/phycore_imx8mm.h
diff --git a/board/phytec/phycore_imx8mp/MAINTAINERS b/board/phytec/phycore_imx8mp/MAINTAINERS
index cb7ce558a81..d3beb978d3a 100644
--- a/board/phytec/phycore_imx8mp/MAINTAINERS
+++ b/board/phytec/phycore_imx8mp/MAINTAINERS
@@ -6,4 +6,5 @@ F:      arch/arm/dts/imx8mp-phyboard-pollux-rdk.dts
 F:      arch/arm/dts/imx8mp-phyboard-pollux-rdk-u-boot.dtsi
 F:      board/phytec/phycore_imx8mp/
 F:      configs/phycore-imx8mp_defconfig
+F:	doc/board/phytec/phycore-imx8mp.rst
 F:      include/configs/phycore_imx8mp.h

-- 
2.34.1

