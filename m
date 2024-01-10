Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80E72C4707C
	for <u-boot@archiver.kernel.org>; Wed, 10 Jan 2024 12:58:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C73B1878D7;
	Wed, 10 Jan 2024 13:58:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="VwNMmJEN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C3E2787A7F; Wed, 10 Jan 2024 13:58:08 +0100 (CET)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E259A878A5
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 13:58:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1704891486; x=1707483486;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=AIffe7WiyPHmITjO6G8rDxhlW43eOG4Rqc6QNL3dxf0=;
 b=VwNMmJENTT8xio3hHNWTOR6BO39sAQV5Udzs4nacnr1iC7Vn8CY2YFSiv78W+REc
 JdkbVwhIDCRPvbJOedqHF+0L8saEii/zAYogXoySVpQ8fRr23PnDCoUVGGBzbPG7
 SvAGLqh0BbB7wfNiLSuDRBKSIg6u8LsjAV14GDZOS8E=;
X-AuditID: ac14000a-fadff7000000290d-b7-659e945ee788
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 39.45.10509.E549E956;
 Wed, 10 Jan 2024 13:58:06 +0100 (CET)
Received: from lws-moog.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 10 Jan
 2024 13:58:06 +0100
From: Yannic Moog <y.moog@phytec.de>
Subject: [PATCH 0/2] This series adds support for the phyGATE-Tauri-L.
Date: Wed, 10 Jan 2024 13:57:40 +0100
Message-ID: <20240110-wip-y-moog-phytec-de-tauri-l_upstream-v1-0-1ba2d9220da6@phytec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAESUnmUC/5WOQQ6CMBBFr0K6dsy0IBRX3sMYMymDNFEgLaCEc
 HcLxoQtyzeZvPcn4dlZ9uIcTcLxYL1t6gDyEAlTUf1gsEVgoVDFUimEt21hhFfTPKCtxo4NFAw
 d9c7C8963vnNML0Bt8jTRZNJTLIKrdVzaz9q53gJX1neNG9fsIJfr3sIgQUKWIJGijPIML7/nY
 8FLMNgSlJjvsZnUYKmJyTBvbMveQf037rIqQMAiNpikhKj11jrP8xcyFjO5fgEAAA==
To: Fabio Estevam <festevam@gmail.com>, NXP i.MX U-Boot Team
 <uboot-imx@nxp.com>, Teresa Remmet <t.remmet@phytec.de>
CC: <upstream@lists.phytec.de>, <u-boot@lists.denx.de>, Yannic Moog
 <y.moog@phytec.de>
X-Mailer: b4 0.12.3
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHLMWRmVeSWpSXmKPExsWyRpKBRzduyrxUg7c/VC0eXvW3eLu3k91i
 yuP17Bbd79QdWDx2zrrL7nH2zg5Gj/7uFlaPje92MAWwRHHZpKTmZJalFunbJXBlrJj7k7Vg
 PXvFhW8uDYw3WLsYOTkkBEwk5s+8BGRzcQgJLGaSaD/wkB0kISTwkFHi0HklEJtNQEXi8Yt7
 YA3CAm4SR56/YgGxWQRUJe5M6GQCsXkFIiRuT77CCGELSpyc+QSohoODWUBTYv0ufZAws4C8
 xPa3c5hBdkkIrGaS2DGpC2ymiECZxLbefqj6CIk5j8wgbhOWaF90iwniHFmJF+d72SHi8hLT
 zr1mhrBDJbZ+2c40gVFwFpLNsxA2z0KyeQEj8ypGodzM5OzUosxsvYKMypLUZL2U1E2MoDAW
 YeDawdg3x+MQIxMH4yFGCQ5mJRFehc9zUoV4UxIrq1KL8uOLSnNSiw8xSnOwKInzru4IThUS
 SE8sSc1OTS1ILYLJMnFwSjUwRlRN3+RS2iApf2C5ycsPjfr3A6+sv1FxKouP8Zl+6N7a5spK
 3y0mugEvzPslliumB5lfFr4XwHV1Z4ehzMTrPRsXXWgIvsnPtiyARfzQk7PZbh27k/aJnmV6
 Ux5r6BbucykxtU98xaVcln3B085nv5JtO2in8XaC1e8YBq3MDFen9wuP/WNUYinOSDTUYi4q
 TgQAGtrHClECAAA=
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

The config is minimal and mostly a copy from the phycore-imx8mm. TI PHY
and SPI (flash) are disabled as they are not populated by default.

---
Yannic Moog (2):
      Add support for phyGATE-Tauri-L-iMX8MM
      doc: board: phytec: Add phyGATE-Tauri board documentation

 arch/arm/dts/Makefile                           |   1 +
 arch/arm/dts/imx8mm-phygate-tauri-l-u-boot.dtsi |  70 ++++
 arch/arm/dts/imx8mm-phygate-tauri-l.dts         | 489 ++++++++++++++++++++++++
 board/phytec/phycore_imx8mm/MAINTAINERS         |   3 +
 configs/imx8mm-phygate-tauri-l_defconfig        | 117 ++++++
 doc/board/phytec/imx8mm-phygate-tauri-l.rst     |  60 +++
 doc/board/phytec/index.rst                      |   1 +
 7 files changed, 741 insertions(+)
---
base-commit: c5e461fbf7cc72f0c1c8a79226b6a5170e56cb4d
change-id: 20231220-wip-y-moog-phytec-de-tauri-l_upstream-08c9648ac653

Best regards,
-- 
Yannic Moog <y.moog@phytec.de>

