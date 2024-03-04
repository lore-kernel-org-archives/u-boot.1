Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4493CC54E41
	for <u-boot@archiver.kernel.org>; Mon,  4 Mar 2024 12:31:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA74087D8E;
	Mon,  4 Mar 2024 13:31:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="N9MRZ51k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9509987D8E; Mon,  4 Mar 2024 13:31:02 +0100 (CET)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B59DD87D4E
 for <u-boot@lists.denx.de>; Mon,  4 Mar 2024 13:31:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=B.Hahn@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1709555460; x=1712147460;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nScf7k/IxKy0PHH4esFT0647utumWpsivi6nwU61y58=;
 b=N9MRZ51kDYI9BTWl5dCGjOM6rO5jmwZmD16ycUjc3t3R7Z2uaWsiWNaasNMz2OCe
 xI9zaiFgLAd6EQi8NnOKZEFlQIN7YY39JdUlj1+QG/tzmTopx+HA/bNQMPPUVLUy
 2UuOjpeHYCs/HhR6PqYowMSL5vrK60jo24rvE80uW+Q=;
X-AuditID: ac14000a-fadff7000000290d-35-65e5bf04cb05
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id F4.36.10509.40FB5E56;
 Mon,  4 Mar 2024 13:31:00 +0100 (CET)
Received: from llp-hahn.hahn.test (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Mon, 4 Mar 2024
 13:30:59 +0100
From: Benjamin Hahn <B.Hahn@phytec.de>
Subject: [PATCH 0/2] board: phytec_imx8mp: Use 2GHz RAM timings for PCL-070
 from pcb_rev 1
Date: Mon, 4 Mar 2024 13:30:46 +0100
Message-ID: <20240304-pcl-070-patches-v1-0-6aa6c89e3b81@phytec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPa+5WUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDYwMT3YLkHF0DcwPdgsSS5IzUYt0UY8MkSwvL5DTTJGMloK6CotS0zAq
 widGxtbUAbc1sZGEAAAA=
To: Tom Rini <trini@konsulko.com>, Teresa Remmet <t.remmet@phytec.de>, Fabio
 Estevam <festevam@gmail.com>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>, Benjamin Hahn
 <B.Hahn@phytec.de>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709555459; l=754;
 i=B.Hahn@phytec.de; s=20240126; h=from:subject:message-id;
 bh=nScf7k/IxKy0PHH4esFT0647utumWpsivi6nwU61y58=;
 b=L4lgf28ilO5GsbIP7ifVHbvYahZoP3YQVCA01y9MKpkIn12q1bKRqgFF+iwSjcc5Fg7/aIRUa
 4FZ0BgW17pMCYArQ7OakpaNTrJMOfStZ74IcBHRl8VS7N4P4qe7uay4
X-Developer-Key: i=B.Hahn@phytec.de; a=ed25519;
 pk=r04clMulHz6S6js6elPBA+U+zVdDAqJyEyoNd8I3pSw=
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGLMWRmVeSWpSXmKPExsWyRpKBR5dl/9NUg65p3BYPr/pbTJ20md3i
 7d5Odovud+oOLB47Z91l93h1YBW7x9k7Oxg9+rtbWANYorhsUlJzMstSi/TtErgyNn55wVzw
 hbVi+qkZ7A2MX1m6GDk5JARMJD59O83UxcjFISSwmEni19VjrBDOA0aJm2+fMYNUsQmoSex6
 85oVxBYWiJFYceYGUJyDg0VAReLlGTaQMK+Ak0TrjDOsELagxMmZT1hASpgFNCXW79IHCTML
 yEtsfzuHGWS8hMAGRonOlU3sIAkRgWyJZ51b2CHqoyTeTQwCMSUEhCU27dSCKN/FJHFi5k92
 iHiixM7XciCdQgKyEjfPb2GDeEVeYtq518wQdqjEkU2rmSYwCs9CctAshINmITloASPzKkah
 3Mzk7NSizGy9gozKktRkvZTUTYygsBdh4NrB2DfH4xAjEwfjIUYJDmYlEd6aX09ShXhTEiur
 Uovy44tKc1KLDzFKc7AoifOu7ghOFRJITyxJzU5NLUgtgskycXBKNTDG21yZcObXvtkbt3k6
 iVQ6Bq4xXsq16Ped6dvTPjm82tbIybvl7r3bEsesn8+14VnmdT1N9I+gWWqHt0N9VlDbRXEW
 4S+xLFWLCk+VtdoXXcuN0cwr2Jh7SFPKwiqr+k/NH7vlt673PKmSP3i9NnS6V07oN1u+/Gdl
 xa8Zv4Y5BD9v9FDft1mJpTgj0VCLuag4EQAs+NQcaQIAAA==
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

PCL-070 supports 2GHz RAM-timings from pcb_rev 1 and newer. PCM-070
supports 2GHz RAM-timings only from pcb_rev 3 and newer.

Signed-off-by: Benjamin Hahn <B.Hahn@phytec.de>
---
Benjamin Hahn (2):
      board: phytec: common: phytec_som_detection: Add phytec_get_som_type
      board: phycore_imx8mp: Use 2GHz RAM timings for PCL-070 from pcb_rev 1

 board/phytec/common/phytec_som_detection.c | 10 ++++++++++
 board/phytec/common/phytec_som_detection.h |  8 ++++++++
 board/phytec/phycore_imx8mp/spl.c          |  6 ++++--
 3 files changed, 22 insertions(+), 2 deletions(-)
---
base-commit: eac52e4be4e234d563d6911737ee7ccdc0ada1f1
change-id: 20240304-pcl-070-patches-d31b989cf5b3

Best regards,
-- 
Benjamin Hahn <B.Hahn@phytec.de>

