Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4389BC54E58
	for <u-boot@archiver.kernel.org>; Tue, 12 Mar 2024 09:00:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 915ED87DB0;
	Tue, 12 Mar 2024 10:00:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="ZMcWXHNF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD1C587F2F; Tue, 12 Mar 2024 10:00:09 +0100 (CET)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 354F18792D
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 10:00:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=L.Anderweit@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1710234006; x=1712826006;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BmZMg8nArlughbigWtdi2BkJumE3OQlxPp57C3IkSuk=;
 b=ZMcWXHNFcMnQElo+knHGEk+LhddDfUVcNePWQ1XKJFgmojJmoOvmczXzp2gFivlo
 F9MGusdCVVZxu02/uQGOXzzwTHF00b2zBrqibHnT1GqteEYXQreAHTbnjs60ds4P
 nAJnsmp9eVXv4ai0e59s5T/R/KPFrZcSKU94CA4ciYA=;
X-AuditID: ac14000a-fadff7000000290d-f9-65f01996851d
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 73.97.10509.69910F56;
 Tue, 12 Mar 2024 10:00:06 +0100 (CET)
Received: from augenblix2.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Tue, 12 Mar
 2024 10:00:06 +0100
From: Leonard Anderweit <l.anderweit@phytec.de>
To: <trini@konsulko.com>, <t.remmet@phytec.de>, <festevam@gmail.com>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
Subject: [PATCH v2 0/5] Add RAUC boot logic for phycore_imx8mp
Date: Tue, 12 Mar 2024 09:59:52 +0100
Message-ID: <20240312085957.902398-1-l.anderweit@phytec.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCLMWRmVeSWpSXmKPExsWyRpKBR3ea5IdUg0MTLS0eXvW3mDppM7vF
 272d7Bbd79QdWDx2zrrL7vHqwCp2j7N3djB69He3sAawRHHZpKTmZJalFunbJXBlrDv7lb2g
 gati/oo7rA2MnRxdjJwcEgImEnsPz2fsYuTiEBJYzCRx/2A/C4TzmFGi4+dNNpAqNgF9iZUv
 F7GA2CICLhK/lu4Bsjk4mAXMJCZ8TgYJCwvYSZy5NhusnEVAVeJNwy5mkBJeAWuJ1135ELvk
 JWZe+s4OYvMKCEqcnPkEbCIzULx562xmCFtC4uCLF2C2kICSxJ1Tv9hgeqede80MYYdKHNm0
 mmkCo8AsJKNmIRk1C8moBYzMqxiFcjOTs1OLMrP1CjIqS1KT9VJSNzGCQlaEgWsHY98cj0OM
 TByMhxglOJiVRHhf67xNFeJNSaysSi3Kjy8qzUktPsQozcGiJM67uiM4VUggPbEkNTs1tSC1
 CCbLxMEp1cAo0Hjpu1GTc9ljcXfxgneB82ZeUqjiWmyTm1VRKW2guCjtSFV3pfy0v59YVUuU
 lio/POIRIM+oxdH8ROf8ESuzg8vuGVjf+GFrULP9rccZ/9Kk2DVdl/YJPEn8ZL/21Jb+yL4T
 ecemf+a8csB//+F5xxe3xT5kFHkcfn6SsvChhplrF6XOf3tLiaU4I9FQi7moOBEAjkQdpEcC
 AAA=
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

v2:
 - rebase on next

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

