Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BA63C5321E
	for <u-boot@archiver.kernel.org>; Mon, 26 Aug 2024 16:49:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95C7788AC2;
	Mon, 26 Aug 2024 18:49:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="VTWJ5p/a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15A2888AD2; Mon, 26 Aug 2024 18:49:16 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 79F4088ABE
 for <u-boot@lists.denx.de>; Mon, 26 Aug 2024 18:49:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=B.Hahn@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1724690952; x=1727282952;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=FLr8tmUnUjHpRzFS+CT9lgn8Ue+b1b89T/g1BYCGM3s=;
 b=VTWJ5p/aN1XiislTrtXf8s2lZjIFohqfs+/pvFnlMX6mpPmr/byqtV6sAWMQVMqd
 VsEfm00X0ifwqCL8cztr0SwvhE4aJLLUQeSp7n6Nk6Ut1Y3LyvOL/345K5iuKw/Z
 ggA75RgPvvSnZmeM1payOvMDovWz/vL9zSQ4wks/4r0=;
X-AuditID: ac14000a-03251700000021bc-b8-66ccb207f4a5
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id D0.BB.08636.702BCC66;
 Mon, 26 Aug 2024 18:49:11 +0200 (CEST)
Received: from llp-Hahn.hahn.test (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Mon, 26 Aug
 2024 18:49:11 +0200
From: Benjamin Hahn <B.Hahn@phytec.de>
Subject: [PATCH 0/2] phycore-imx8mp: Add support for SPI NOR flash
Date: Mon, 26 Aug 2024 18:49:04 +0200
Message-ID: <20240826-wip-bhahn-add_qspi_support-v1-0-0ea7840b940a@phytec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAGyzGYC/x3MwQqDMAwA0F+RnBeIRWT6KzKkXTObS82auQ3Ef
 7d4fJe3g3ERNhibHQp/xWTNFe2tgWfyeWGUWA2OXEd31+NPFEPyKaOPcX6bymyb6lo+2LeOKND
 AHQeogRZ+yf/Kp8dxnP2SE/BsAAAA
To: Teresa Remmet <t.remmet@phytec.de>, Yannic Moog <y.moog@phytec.de>, Tom
 Rini <trini@konsulko.com>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>, Benjamin Hahn
 <B.Hahn@phytec.de>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724690951; l=693;
 i=B.Hahn@phytec.de; s=20240126; h=from:subject:message-id;
 bh=FLr8tmUnUjHpRzFS+CT9lgn8Ue+b1b89T/g1BYCGM3s=;
 b=pl80NyeNwy/xomHtWtYTq+yjKGeHt4j9JBLRvy8Nhz4hYLJkoELJ8quNeezGDeO2r000lf6ia
 jfKbblXDIuICSGhkQUA1AP8jg7uAyNg89CVNM1awnX4nAysWI0zYTzd
X-Developer-Key: i=B.Hahn@phytec.de; a=ed25519;
 pk=r04clMulHz6S6js6elPBA+U+zVdDAqJyEyoNd8I3pSw=
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLLMWRmVeSWpSXmKPExsWyRpKBR5dj05k0g6cNjBZTJ21mt3i7t5Pd
 ovudugOzx6sDq9g9zt7ZwejR393CGsAcxWWTkpqTWZZapG+XwJXx4GkvY8F21oqOh5OYGhgP
 snQxcnJICJhIHLvzFMwWEljCJHFosQ+E/ZBRYlp7IYjNJqAmsevNa1YQW1jASeJT9wFGEJtF
 QFXi+cxL7CA2r4CvROeWm0wQtqDEyZlPgGZycDALaEqs36UPEmYWkJfY/nYOcxcjF9DaHYwS
 y1bsAOsVEUiX2PbiOytEfZTEu4lBEKcJS3zevYYNon4Xk8Svk/PYQGokBBIldr6WgzhTVuLm
 +S1sEPXyEtPOvWaGsEMljmxazTSBUXgWkotmIVw0C8lFCxiZVzEK5WYmZ6cWZWbrFWRUlqQm
 66WkbmIEBbkIA9cOxr45HocYmTgYDzFKcDArifDKXT6ZJsSbklhZlVqUH19UmpNafIhRmoNF
 SZx3dUdwqpBAemJJanZqakFqEUyWiYNTqoGxsuydcM7PY5OiNLWXF2z/pXl7cdCSz9ulmHev
 NeqJfMb0QezaZ8H3iSneB5Xi+Pa9/7RmSjBf2dewjzkT5WwOlm/zEfP6uemMWm24yj2G5NzN
 BaFsvhOXfg9U/9UVfLMzru+t2IzJuq01/HylnNfWOM/P/PbxypRZ25/bn78y7de5tV5hAjs+
 KbEUZyQaajEXFScCANXmN9FgAgAA
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

Add support for flashing and booting from spi nor flash.

Signed-off-by: Benjamin Hahn <B.Hahn@phytec.de>
---
Benjamin Hahn (2):
      configs: phycore-imx8mp_defconfig: Enable SPI NOR flash support
      board: phytec: phycore_imx8mp: Add mtd spi partitions

 board/phytec/phycore_imx8mp/phycore-imx8mp.c   | 34 ++++++++++++++++++++++++++
 board/phytec/phycore_imx8mp/phycore_imx8mp.env |  4 +++
 configs/phycore-imx8mp_defconfig               | 24 ++++++++++++++++++
 3 files changed, 62 insertions(+)
---
base-commit: ee2af844ba1b27b2e959c4e649e4b769fbeb4074
change-id: 20240826-wip-bhahn-add_qspi_support-61200b09e4eb

Best regards,
-- 
Benjamin Hahn <B.Hahn@phytec.de>

