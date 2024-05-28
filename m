Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B30C7C25B78
	for <u-boot@archiver.kernel.org>; Tue, 28 May 2024 13:35:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 37AB58841F;
	Tue, 28 May 2024 15:35:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="KAbBr4wh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 81F48884E9; Tue, 28 May 2024 15:35:28 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9CACB883A0
 for <u-boot@lists.denx.de>; Tue, 28 May 2024 15:35:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=T.Remmet@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1716903326; x=1719495326;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=msgZLdvc5is+pUl95izHVaQYxCMLP9w1rFRQfOEZIdc=;
 b=KAbBr4whv64OXRrlzW9GtAP/qMdvTb7LK7ET6q1xi+bce0ehKnWlDT9lowN1mVpt
 e9xlrJopAQkXsInl95a5fwYbPq9qS3f4ypaOIa/VZUevpx6GGFP3gn6pPTWk883X
 Yc3DWar4sqRZVggc5bPtaXdns1csV4r9ap4HBVI/bHE=;
X-AuditID: ac14000a-03251700000021bc-25-6655dd9e0188
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 72.E8.08636.E9DD5566;
 Tue, 28 May 2024 15:35:26 +0200 (CEST)
Received: from llp-tremmet2.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Tue, 28 May
 2024 15:35:25 +0200
From: Teresa Remmet <t.remmet@phytec.de>
To: <u-boot@lists.denx.de>
CC: Yannic Moog <y.moog@phytec.de>, Fabio Estevam <festevam@gmail.com>, Tom
 Rini <trini@konsulko.com>, Benjamin Hahn <B.Hahn@phytec.de>, Yashwanth
 Varakala <y.varakala@phytec.de>, Wadim Egorov <w.egorov@phytec.de>,
 <upstream@lists.phytec.de>
Subject: [PATCH 0/4] Support all phyCORE-i.MX8MP RAM variants
Date: Tue, 28 May 2024 15:35:11 +0200
Message-ID: <20240528133515.307315-1-t.remmet@phytec.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOLMWRmVeSWpSXmKPExsWyRpKBR3fe3dA0g7kvhC0eXvW3mDppM7vF
 272d7Bbd79QdWDx2zrrL7vHqwCp2j7N3djB69He3sAawRHHZpKTmZJalFunbJXBlLF+zl7ng
 NGfF57MHmRoYL7F3MXJySAiYSDTOmsPUxcjFISSwhEni8udZzBDOU0aJs3NXs4FUsQloSDxd
 cZoJxBYRkJJ42bkRrIhZ4DujxJyF/WCjhAVsJVYcaAErYhFQleh6fJgRxOYVsJD48+MaE8Q6
 eYn9B88yQ8QFJU7OfMICYjMDxZu3zmaGsCUkDr54AWYLAcV3XTrJCNM77dxrZgg7VOLIptVM
 ExgFZiEZNQvJqFlIRi1gZF7FKJSbmZydWpSZrVeQUVmSmqyXkrqJERS4IgxcOxj75ngcYmTi
 YDzEKMHBrCTCe2ZSaJoQb0piZVVqUX58UWlOavEhRmkOFiVx3tUdwalCAumJJanZqakFqUUw
 WSYOTqkGRj11h7ywdYcNiksv7NkkOmlG7dImxdlvkup5pnxK7D3whOnUDsaFF0KPqPXukuTb
 x7XCQXuv8W8vR+5NMap3Jp6+yfK0LGAX20dxicY1TxeHu+Q9VuLfJW+eKM222KVG4+sSB5aq
 x8Z/3J76aO970/2b3VjGMNTqI9u7+nzXjHiB93t+zPHZosRSnJFoqMVcVJwIAJM2QQ9KAgAA
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

Add support for several RAM sizes and speed grades for phyCORE-i.MX8MP.

We have support with this series for:
- 1GB 1.5GHz
- 1GB 2GHz
- 2GB 1.5GHz (was supported before)
- 2GB 2GHz (was supported before)
- 4GB 1.5GHz
- 4GB 2GHz
- 8GB 2GHz

RAM size and speed grade is detected and set using EEPROM data on default.
Alternative it is possible to set fix RAM size and speed over Kconfig.

Teresa

Benjamin Hahn (1):
  board: phycore_imx8mp: enable setting 2GHz timings without RAM size

Teresa Remmet (3):
  board: phytec: phycore-imx8mp: spl: Fix syle issue
  board: phytec: phycore_imx8mp: Add support for different RAM sizes
  board: phytec: phycore_imx8mp: Make RAM size configuration fix

 board/phytec/phycore_imx8mp/Kconfig          |  67 ++++++++
 board/phytec/phycore_imx8mp/lpddr4_timing.c  | 153 +++++++++++++++++++
 board/phytec/phycore_imx8mp/lpddr4_timing.h  |  16 ++
 board/phytec/phycore_imx8mp/phycore-imx8mp.c |  11 ++
 board/phytec/phycore_imx8mp/spl.c            | 136 +++++++++--------
 include/configs/phycore_imx8mp.h             |   4 +-
 6 files changed, 322 insertions(+), 65 deletions(-)
 create mode 100644 board/phytec/phycore_imx8mp/lpddr4_timing.h

-- 
2.34.1

