Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87945C2BD09
	for <u-boot@archiver.kernel.org>; Wed,  3 Jul 2024 13:46:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF90287F8C;
	Wed,  3 Jul 2024 15:46:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="ZFMxCCSJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71982887C6; Wed,  3 Jul 2024 07:42:28 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84B8588784
 for <u-boot@lists.denx.de>; Wed,  3 Jul 2024 07:42:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Schultz@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1719985345; x=1722577345;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=uc6R0w/WASFK93BbbSLFQIBPNllqIWRkW0cTsUu4ARc=;
 b=ZFMxCCSJoD1vYEpJnA0dN0QPGBpY8R32Frfv4/qjW3Ipnkt44OmQDEaDUXvdC+qJ
 zGDYJyvApn3LH2QFYyKOPeIIFeRlitnkNuOVeJXmmQyLK7JhMEWzcXrZiKLwICVi
 sY85VKRtUm4Z3OcGzb5HgVJWTVK9uraIH+zDnKQvMI8=;
X-AuditID: ac14000a-03251700000021bc-63-6684e4c1d726
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id EC.6D.08636.1C4E4866;
 Wed,  3 Jul 2024 07:42:25 +0200 (CEST)
Received: from ls-radium.phytec (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 3 Jul 2024
 07:42:23 +0200
From: Daniel Schultz <d.schultz@phytec.de>
To: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>, <trini@konsulko.com>, 
 <m.othacehe@gmail.com>, <joe.hershberger@ni.com>, <w.egorov@phytec.de>,
 <t.remmet@phytec.de>
CC: <d-gole@ti.com>, <festevam@gmail.com>, <mkorpershoek@baylibre.com>,
 <sjg@chromium.org>, Daniel Schultz <d.schultz@phytec.de>
Subject: [PATCH 0/9] Generalize PHYTEC Overlay Handling
Date: Tue, 2 Jul 2024 22:41:53 -0700
Message-ID: <20240703054202.2812540-1-d.schultz@phytec.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCLMWRmVeSWpSXmKPExsWyRpKBR/fgk5Y0g8bT5hYtaz0sHl71t/i0
 8zGrxYyb09gsXhyby27xbcs2RoupkzazW7zd28lu0f1O3YHT4/2NVnaP2Q0XWTx2zrrL7vHq
 wCp2j7N3djB69He3sHpcP7OdyeP4je1MARxRXDYpqTmZZalF+nYJXBmfO6azFnzgreh8t42x
 gXEZdxcjJ4eEgInEvjXbGbsYuTiEBJYwSTxdO5cdwrnHKDH7wyEmkCo2AS2JO1vmMoMkRATW
 MUrMvbKJCcRhFmhilJjYchmsSljAXOLgih/sIDaLgIrE5Ic/2UBsXgEriW39r1gh9slLzLz0
 nR0iLihxcuYTFhCbGSjevHU2M4QtIXHwxQswW0hAQWL2tsmMML3Tzr1mhrBDJbZ+2c40gVFg
 FpJRs5CMmoVk1AJG5lWMQrmZydmpRZnZegUZlSWpyXopqZsYQTEhwsC1g7FvjschRiYOxkOM
 EhzMSiK8Uu+b04R4UxIrq1KL8uOLSnNSiw8xSnOwKInzru4IThUSSE8sSc1OTS1ILYLJMnFw
 SjUwdnMc1An5wlfgljarXWVam640z24DX6len+5zdbZ+0+oupewJ9E6sq7v/3bq0c8m09yta
 9rrynuNZ18ChunyJX3ei1LVP52PZJfy2Cn389FDvd7dKm8g2x7UrBbaVlghqSkx/ke+8YbnU
 X9c4BnGtUt0t058bM0QaK1W9lGZ81+Bws93D9ZQSS3FGoqEWc1FxIgAlr/GTdwIAAA==
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

The overlays are specified in the bootenv.txt file that is loaded into
the environment. Then these overlays get loaded and applied via a script.
These scripts for loading and applying devicetree overlays are identical
for many phytec boards.
Create a common overlays.env that can be included.
Add support for devicetree overlays to phycore-imx8mp and include the
overlays.env for phycore-imx93.
Rename existing environment variables according to bootstd doc.
Move MMC boot logic into a common k3_mmc.env file and include the new
overlays.env file as well.

Benjamin Hahn (5):
  include: env: phytec: Create env file for loading and applying
    overlays
  phycore-imx8mp: Add overlay and bootenv.txt support
  phycore_imx93: include common overlays.env
  board: phytec: renaming of variables according to bootstd doc
  include: env: phytec: renaming of variables according to bootstd doc

Daniel Schultz (4):
  include: env: phytec: Add common mmc boot for K3 SoMs
  include: env: phytec: k3_mmc: Apply overlays during boot
  board: phytec: phycore_am62x: Use k3_mmc.env logic
  board: phytec: phycore_am64x: Use k3_mmc.env logic

 board/phytec/phycore_am62x/phycore_am62x.env  | 11 +----
 board/phytec/phycore_am64x/phycore_am64x.env  | 12 +----
 .../phytec/phycore_imx8mp/phycore_imx8mp.env  | 27 ++++++++---
 board/phytec/phycore_imx93/phycore_imx93.env  | 45 +++++--------------
 configs/phycore-imx8mp_defconfig              |  6 +--
 include/env/phytec/k3_mmc.env                 | 21 +++++++++
 include/env/phytec/overlays.env               | 38 ++++++++++++++++
 7 files changed, 98 insertions(+), 62 deletions(-)
 create mode 100644 include/env/phytec/k3_mmc.env
 create mode 100644 include/env/phytec/overlays.env

-- 
2.25.1

