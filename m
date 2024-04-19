Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 053C1C4345F
	for <u-boot@archiver.kernel.org>; Fri, 19 Apr 2024 16:22:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 746528876E;
	Fri, 19 Apr 2024 18:22:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="oBHc3UJ7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 584B18876E; Fri, 19 Apr 2024 17:55:55 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D556886C1
 for <u-boot@lists.denx.de>; Fri, 19 Apr 2024 17:55:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=D.Schultz@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1713542153; x=1716134153;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8lA8eOHBU6awdEVeE7hTx9CiR1fcJCD8TeW+kzcvM6I=;
 b=oBHc3UJ7BV5Z/nPTgppXuZunVzEtW1QNWU/ljX7vPoLrLbmmI7qQnZKaKV6cQxoI
 VEshMIry8jr2JDQd6tXfxzXLUg8II5MXAnVaAlyBtt7Lb3+gKbLrNYDwR0kZo9mt
 a0Uju7Sdg4QLCpP8QH+tIMOodwGRnYCs1PR0O9yq6ak=;
X-AuditID: ac14000a-fadff7000000290d-6d-66229408bf9f
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id EB.38.10509.80492266;
 Fri, 19 Apr 2024 17:55:52 +0200 (CEST)
Received: from ls-radium.phytec (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Fri, 19 Apr
 2024 17:55:51 +0200
From: Daniel Schultz <d.schultz@phytec.de>
To: <u-boot@lists.denx.de>
CC: Daniel Schultz <d.schultz@phytec.de>
Subject: [PATCH 0/5] Update PHYTEC SOM Detection
Date: Fri, 19 Apr 2024 08:55:35 -0700
Message-ID: <20240419155540.2447006-1-d.schultz@phytec.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBLMWRmVeSWpSXmKPExsWyRpKBR5dzilKawarvTBZv93ayOzB6nL2z
 gzGAMYrLJiU1J7MstUjfLoEr4/vUXtaC45wVX//vYG5gPM3excjJISFgInFt52nGLkYuDiGB
 JUwSe1f3sUM49xklvm6+ywxSxSagJXFny1wwW0RASuJl50Ygm4ODWUBDov0ZE0hYWMBA4tGd
 gywgYRYBVYmOmbkgYV4BK4l7k3cxQeySl5h56Ts7RFxQ4uTMJywgNjNQvHnrbGYIW0Li4IsX
 YLaQgILE7G2TGWF6p517zQxhh0oc2bSaaQKjwCwko2YhGTULyagFjMyrGIVyM5OzU4sys/UK
 MipLUpP1UlI3MYJCT4SBawdj3xyPQ4xMHIyHGCU4mJVEeM04FNOEeFMSK6tSi/Lji0pzUosP
 MUpzsCiJ867uCE4VEkhPLEnNTk0tSC2CyTJxcEo1MColrs9xSkhOEX2zdVfEyvQbYpmV25Yd
 sXx3xnVe1OpDC+evDwq0847J+dIU+jPH5lapV5KwJ1fcDXHVzKC/hl05L+cI/Mq7YrNx/erd
 h7hkd8m58WgtmNgQduDFnvSCsrl/q6+zJO7t0z+YbHAmLWGmg4fMzD6zW3JTBfmuLnVo4o2I
 fPY2TYmlOCPRUIu5qDgRAHMOnq0rAgAA
X-Mailman-Approved-At: Fri, 19 Apr 2024 18:22:18 +0200
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

This patch series extends PHYTEC's SOM detection by minor
fixes, a generic helper function and a new valid flag.

Moreover, it adds a module to provide access to the SOM
detection for our TI AM6 products.

Daniel Schultz (3):
  board: phytec: common: Generic "add extension" function
  board: phytec: common: Fix eepom is empty check
  board: phytec: Add SOM detection for AM6x

Yannic Moog (2):
  board: phytec: introduce eeprom struct member 'valid'
  board: phytec: check eeprom_data validity

 board/phytec/common/Kconfig                |  18 +++
 board/phytec/common/Makefile               |   1 +
 board/phytec/common/am6_som_detection.c    | 159 +++++++++++++++++++++
 board/phytec/common/am6_som_detection.h    |  36 +++++
 board/phytec/common/imx8m_som_detection.c  |  13 +-
 board/phytec/common/phytec_som_detection.c |  97 +++++++++----
 board/phytec/common/phytec_som_detection.h |  16 ++-
 board/phytec/phycore_am62x/Kconfig         |   4 +
 board/phytec/phycore_am64x/Kconfig         |   4 +
 9 files changed, 314 insertions(+), 34 deletions(-)
 create mode 100644 board/phytec/common/am6_som_detection.c
 create mode 100644 board/phytec/common/am6_som_detection.h

-- 
2.25.1

