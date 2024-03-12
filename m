Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFA7AC54E5D
	for <u-boot@archiver.kernel.org>; Tue, 12 Mar 2024 14:30:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2240F87F43;
	Tue, 12 Mar 2024 15:30:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="RLrC2IRZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16F8887F6A; Tue, 12 Mar 2024 15:30:45 +0100 (CET)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 30DCA87D9B
 for <u-boot@lists.denx.de>; Tue, 12 Mar 2024 15:30:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=L.Anderweit@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1710253842; x=1712845842;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=IJvSgBnymsEF4AaF+j+zldO8Wn2TGMFSFAsODmudbO4=;
 b=RLrC2IRZDWJdnArcwcEoneWzxtMjgqYaK/pz8ceeJ3vduyiGjXzBBxyHQDryxReF
 B2y//FAGrN7o/EpDfeC+tEgPWSnM+TpYheJc5PbJ+03dE8n2Ia9GbgW5OH+TRoUR
 Vpjb+ZSDuqwUqXigFa9Qs3hoH9421mFVnrFTf6zSRh8=;
X-AuditID: ac14000a-fadff7000000290d-98-65f0671255eb
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id B9.0A.10509.21760F56;
 Tue, 12 Mar 2024 15:30:42 +0100 (CET)
Received: from augenblix2.phytec.de (172.25.0.11) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Tue, 12 Mar
 2024 15:30:42 +0100
From: Leonard Anderweit <l.anderweit@phytec.de>
To: <trini@konsulko.com>, <t.remmet@phytec.de>, <festevam@gmail.com>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
Subject: [PATCH v3 0/5] Add RAUC boot logic for phycore_imx8mp
Date: Tue, 12 Mar 2024 15:30:28 +0100
Message-ID: <20240312143033.3336-1-l.anderweit@phytec.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.11]
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCLMWRmVeSWpSXmKPExsWyRpKBR1co/UOqwfEGK4uHV/0tpk7azG7x
 dm8nu0X3O3UHFo+ds+6ye7w6sIrd4+ydHYwe/d0trAEsUVw2Kak5mWWpRfp2CVwZaw/dYCu4
 zlXR3ziLtYHxNEcXIyeHhICJxPdHG5m6GLk4hAQWM0nMbuyBch4zSiz51c8IUsUmoC+x8uUi
 FhBbRMBF4tfSPUA2BwezgJnEhM/JIGFhATuJNYtfs4PYLAKqEieffmYFKeEVsJT42ZEGsUte
 Yual72AlvAKCEidnPgGbyAwUb946mxnClpA4+OIFmC0koCRx59QvNpjeaedeM0PYoRJHNq1m
 msAoMAvJqFlIRs1CMmoBI/MqRqHczOTs1KLMbL2CjMqS1GS9lNRNjKCQFWHg2sHYN8fjECMT
 B+MhRgkOZiUR3tc6b1OFeFMSK6tSi/Lji0pzUosPMUpzsCiJ867uCE4VEkhPLEnNTk0tSC2C
 yTJxcEo1MCYz5C9atVtWZmfGnfrcdl3NIsvn+983834P+z9vxi0tk1m8AVEJC2u5//hXRvg5
 9PNPmJLGLDnNo/nI1zlLy294dO+q2aRZd+DPjLk57UuqOKzbLdLKDu/KXnk0UPzx2TSrS9Y/
 dTTZM6Y5ydlm+r/Ydt7ooCjPxLl3vnp/lrb2bYpa+iK8WYmlOCPRUIu5qDgRAKCGa0dHAgAA
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

v3:
 - swap loadimage and loadfdt in first patch
 - add Tested-by and Reviewed-by

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

