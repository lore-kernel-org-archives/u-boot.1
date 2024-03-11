Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39F59C5475B
	for <u-boot@archiver.kernel.org>; Mon, 11 Mar 2024 13:06:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF5AA87E50;
	Mon, 11 Mar 2024 14:06:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="Jc/97MuD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B08C187E64; Mon, 11 Mar 2024 14:04:21 +0100 (CET)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 54A0887D35
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 14:04:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=L.Anderweit@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1710162257; x=1712754257;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=X/3OzaYTeCcrLUIlmxsHKOLVXWMF/hbqgX7kvesKuj0=;
 b=Jc/97MuDeR02iKRKNgEwpENFfP4vGTlhryEycK10B4JSm0owyp5u36YiL9WDhEO0
 W9ltpX0yP/6VVxtPUzTn/aTpTQi8QICwiEteaLliZuIC0dIJ8q5Y6XfycH8m3Om9
 8+8bO0g5ig7xfLwmHP8eNxp0pres8NzAxa3GdXd+dq0=;
X-AuditID: ac14000a-fbefe7000000290d-09-65ef01510ab0
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 63.93.10509.1510FE56;
 Mon, 11 Mar 2024 14:04:17 +0100 (CET)
Received: from augenblix2.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Mon, 11 Mar
 2024 14:04:17 +0100
From: Leonard Anderweit <l.anderweit@phytec.de>
To: <trini@konsulko.com>, <t.remmet@phytec.de>, <festevam@gmail.com>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
Subject: [PATCH 0/5] Add RAUC boot logic for phycore_imx8mp
Date: Mon, 11 Mar 2024 14:03:55 +0100
Message-ID: <20240311130400.4023780-1-l.anderweit@phytec.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrKLMWRmVeSWpSXmKPExsWyRpKBRzeQ8X2qwZZmc4uHV/0tpk7azG7x
 dm8nu0X3O3UHFo+ds+6ye7w6sIrd4+ydHYwe/d0trAEsUVw2Kak5mWWpRfp2CVwZF7atYC14
 xlmx//lPtgbGn+xdjJwcEgImEtdWLWHrYuTiEBJYzCQxcdUrFgjnMaPEs58/WUGq2AT0JVa+
 XMQCYosIuEj8WroHyObgYBYwk5jwORkkLCxgLbHo3wawEhYBVYnre84zgdi8AjYSr3+tZIJY
 Ji8x89J3doi4oMTJmU/A6pmB4s1bZzND2BISB1+8ALOFBJQk7pz6xQbTO+3ca2YIO1TiyKbV
 TBMYBWYhGTULyahZSEYtYGRexSiUm5mcnVqUma1XkFFZkpqsl5K6iREUtCIMXDsY++Z4HGJk
 4mA8xCjBwawkwvta522qEG9KYmVValF+fFFpTmrxIUZpDhYlcd7VHcGpQgLpiSWp2ampBalF
 MFkmDk6pBsbEc6lxC99Hyah2NMeEXJzoH754x+PP0i9jbp54t1n8/ocVR4z3ap4vffs6Xulh
 p8Tvpldbczg2tXi4XVQ4+s3k06J679u/zz9M0Dt8cUnxrFefzxR8lYz9MftLh4zVQ4tnr04c
 2ygY/Mw490jQ2xc6oZGdy/cmL9c++8E+8EuMs2OpyPPQbX3flFiKMxINtZiLihMBTpE0t0gC
 AAA=
X-Mailman-Approved-At: Mon, 11 Mar 2024 14:06:01 +0100
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

This series adds RAUC boot logic for the phycore_imx8mp.
The first patch converts the environment from a CFG_EXTRA_ENV_SETTINGS #define
to a text environment for better readability and maintainability.
The second patch moves the default bootcmd from the defconfig to the board
environment.
The third patch enables the redundant environment on phycore_imx8mp.
Patch 4 adds RAUC boot logic common to all phytec boards.
Patch 5 adds the RAUC boot logic to phycore_imx8mp.

Leonard Anderweit (5):
  phycore_imx8mp: Move environment from include/config to board
  phycore_imx8mp: Move default bootcmd to board env
  configs: phycore-imx8mp_defconfig: Use redundant environment
  include: env: Add phytec RAUC boot logic
  board: phytec: phycore_imx8mp: Add RAUC boot logic to environment

 .../phytec/phycore_imx8mp/phycore_imx8mp.env  | 62 +++++++++++++++++++
 configs/phycore-imx8mp_defconfig              |  4 +-
 include/configs/phycore_imx8mp.h              | 43 -------------
 include/env/phytec/rauc.env                   | 52 ++++++++++++++++
 4 files changed, 116 insertions(+), 45 deletions(-)
 create mode 100644 board/phytec/phycore_imx8mp/phycore_imx8mp.env
 create mode 100644 include/env/phytec/rauc.env

-- 
2.25.1

