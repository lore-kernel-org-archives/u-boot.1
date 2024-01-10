Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1C62C4707C
	for <u-boot@archiver.kernel.org>; Wed, 10 Jan 2024 13:36:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EFEA387A7F;
	Wed, 10 Jan 2024 14:35:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="Lwlo9ybw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC59187ABE; Wed, 10 Jan 2024 14:35:57 +0100 (CET)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF0F387906
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 14:35:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1704893755; x=1707485755;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vuNO4DJxarnvTM/my8JFom0RwZxgOYXpAa9YLAFrcls=;
 b=Lwlo9ybw5ZJDJ3EbSQcXxvh0M+rCFAAIk8HjalyS2aks6Br0F0/1rtaNNbh6nEUM
 Rlv+ViAJlAwKJswbSQkl+CdIKdR0spWMkR7mR2vD36U4surkusMJk7PHgZJNq90L
 PbrxVr4Si2+hUEiQrKBBZah4T507hrzj+5MGZhAbp4M=;
X-AuditID: ac14000a-fadff7000000290d-28-659e9d3b2f3b
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 56.95.10509.B3D9E956;
 Wed, 10 Jan 2024 14:35:55 +0100 (CET)
Received: from lws-moog.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 10 Jan
 2024 14:35:55 +0100
From: Yannic Moog <y.moog@phytec.de>
Subject: [PATCH v2 0/3] This series adds support for the phyGATE-Tauri-L.
Date: Wed, 10 Jan 2024 14:35:43 +0100
Message-ID: <20240110-wip-y-moog-phytec-de-tauri-l_upstream-v2-0-4ea2dd6a4f74@phytec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAC+dnmUC/5WPQW7CMBBFr4K87lTjSXAcVtwDoWqwB2KpJJEdA
 hHK3etQVWLRTZZ/NHrv/6dKEoMktds8VZQxpNC1OdDHRrmG24tA8DkrQio0EcI99DDBtesu0Df
 TIA68wMC3GOD769anIQpfAa2rTWnZmW2hMquPcg6Pl+dwzLkJaeji9NKOermuNYwaNFQlMhNXX
 Fe4/33+9LIIM61EjfUamjMOz5aFnch/NL2iG4I+Mfk6D/Js3mjL+pH+Fq/qSJmKvnBYGka09p0
 6z/MPH/SKa8wBAAA=
To: Fabio Estevam <festevam@gmail.com>, NXP i.MX U-Boot Team
 <uboot-imx@nxp.com>, Teresa Remmet <t.remmet@phytec.de>
CC: <upstream@lists.phytec.de>, <u-boot@lists.denx.de>, Yannic Moog
 <y.moog@phytec.de>
X-Mailer: b4 0.12.3
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrALMWRmVeSWpSXmKPExsWyRpKBR9d67rxUg2ML5S0eXvW3eLu3k91i
 yuP17Bbd79QdWDx2zrrL7nH2zg5Gj/7uFlaPje92MAWwRHHZpKTmZJalFunbJXBlTJ1/kqXg
 D1fFqeZpzA2Mpzi6GDk5JARMJHo7/rB1MXJxCAksZpJ49mgOO4TzkFHix4tOdpAqNgEViccv
 7rGC2MICnhIbnj0Ai7MIqEq0bzrLAmLzCkRI9G3/wwhhC0qcnPkEKM7BwSygKbF+lz5ImFlA
 XmL72znMIPMlBI4xSRzuXQzWKyJQJrGttx+qPkJiziMziOOEJdoX3WICsYUEZCVenO9lh4jL
 S0w795oZwg6VOLJpNdMERsFZSDbPQtg8C8nmBYzMqxiFcjOTs1OLMrP1CjIqS1KT9VJSNzGC
 QlmEgWsHY98cj0OMTByMhxglOJiVRHgVPs9JFeJNSaysSi3Kjy8qzUktPsQozcGiJM67uiM4
 VUggPbEkNTs1tSC1CCbLxMEp1cDoMv+VtGpRXtLEB7t7llz7zL64OfLEsbzVT7X/T/n/N9dc
 Pr2aRXXbNMVZr78aTpaY9Gj7uwCWq3szMy2m9+b+bpw7Q7B90rkmjRX1B1VMz887ey+xS+HQ
 iYXlrbUCWtYX4l9ya7A3y96ccz54XjdLrO9WU5+jcStfXZ3/4qMw45UVExyjsvm3KbEUZyQa
 ajEXFScCACzbSnlTAgAA
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

The config is minimal and mostly a copy from the phycore-imx8mm. SPI
(flash) is disabled as it is not populated by default.
Also add documentation for the phyGATE-Tauri-L board. While at it, add
the other PHYTEC doc files to MAINTAINERS; they were missing for
existing phycore-imx8m{m,p} doc.

---
Changes in v2:
- readd TIDP83867; is populated on the SoM by default
- remove remnants from SPI config options (savedefconfig)
- add doc/board/phytec files to MAINTAINERS

---
Yannic Moog (3):
      Add support for phyGATE-Tauri-L-iMX8MM
      doc: board: phytec: Add phyGATE-Tauri board documentation
      board: phytec: MAINTAINERS: add missing phytec doc files

 arch/arm/dts/Makefile                           |   1 +
 arch/arm/dts/imx8mm-phygate-tauri-l-u-boot.dtsi |  70 ++++
 arch/arm/dts/imx8mm-phygate-tauri-l.dts         | 489 ++++++++++++++++++++++++
 board/phytec/phycore_imx8mm/MAINTAINERS         |   6 +
 board/phytec/phycore_imx8mp/MAINTAINERS         |   1 +
 configs/imx8mm-phygate-tauri-l_defconfig        | 115 ++++++
 doc/board/phytec/imx8mm-phygate-tauri-l.rst     |  60 +++
 doc/board/phytec/index.rst                      |   1 +
 8 files changed, 743 insertions(+)
---
base-commit: c5e461fbf7cc72f0c1c8a79226b6a5170e56cb4d
change-id: 20231220-wip-y-moog-phytec-de-tauri-l_upstream-08c9648ac653

Best regards,
-- 
Yannic Moog <y.moog@phytec.de>

