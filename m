Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F27ACD37B6
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 07:19:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6EBB384653;
	Wed, 13 May 2026 09:19:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="HasFw5l+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A1CFB8341A; Wed, 13 May 2026 09:19:20 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BFCA6836AC
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 09:19:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lvq71hcJr+fHECsDiwt5D60Wsl++4v1hmU9mJ/a7hxvThFAIY2pfMGfx/vAqPdmnVHtCQ5oqB5jK3ujjB2Z7qvHbsRp2FUpmfQt/Nob+oyMCMVPB82O2KNcoyOES22N6E3fbf37ZIIeGQdYv/l8cUZgBUVV9b48xZFd1nSK2RIjEh/1Pob/Ek/ep+L68iOUSasKy+rEHYKt/YpFl/271gSSWKNcBkTTD7Axxc6tWvCin6uph57rq4vvBLlIv9hAUaTzXRqzg0W5V2j4BXgC7xMOvbgxAa0wXuRbIjA/mSjpDCs5wG9tz3yjP1umTwiMGKqBoYHpQ6B41n5cZvZVW4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N8M9LcO0jLBExliuZboKt3+4JTz8cRowYyAaQS+IDqw=;
 b=v6k25kvmlKPn51RuOdVlOrs6rQ36+A4kX0deIFCUMzHZIOyyWgVkC+DMLQAffukoYE5Sy/X2KvGK77o//Tk9RXNDGMUBPxokhzqqBk4AOtc5zwNNcQcIPLYp1E3iVHXe3F6va0Ib4uIB3PQJUN39S/C6BPbX8zCM/9P/k/xH17Rbbu4WsU3F/tnvGdxF0bss4zNOgJM3FBHCDcUbVo8uB6GC5FsY/LoXa+mO/+Q9XhlIPKECpXFdTOPADRzU+NPtADzC+pu9uh8fO/Dq7PsWsgaORTKHLT6C7KSEtEXK8dr1j05KoxS3xEEbXytozlWg/5ZB6CDChTEsKJV6tdR69w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 91.26.50.189) smtp.rcpttodomain=konsulko.com smtp.mailfrom=phytec.de;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=phytec.de; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N8M9LcO0jLBExliuZboKt3+4JTz8cRowYyAaQS+IDqw=;
 b=HasFw5l+DP0gUIyj9nrY59C6u4qyEBqjG6AC4p1S6K51KxLlJVvURZ1is3I5ASwYESpZ/fXZtkWORBMmK5//R/LfDYnHpCNteAM5YaKwZ2JcDTXN7FYVhzYg6XKw794BjVYM1lhbf6hXcp9/1bpj3DmHH20RdMqvzuDoSxVjC8Nik3l09ELbNtBybgmWkKkxwHxWcMMptubjSUwQ8o0L8UE6SKFJgYDShc8D5QOCso1vjwCeaPI9m/KfU95xrVPcfqkadEPgvDOoeRpM6hQV8BKrU9O5KkbjKjiXM6B0V9NW9KNeTmLloV81xK/4KuFyOWcAWXwSTPD2h4zXMNKvWQ==
Received: from AS4P189CA0065.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:659::8)
 by PAVP195MB2237.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:309::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 07:19:14 +0000
Received: from AMS0EPF0000019B.eurprd05.prod.outlook.com
 (2603:10a6:20b:659:cafe::5a) by AS4P189CA0065.outlook.office365.com
 (2603:10a6:20b:659::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.17 via Frontend Transport; Wed, 13
 May 2026 07:19:14 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 91.26.50.189)
 smtp.mailfrom=phytec.de;
 dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=phytec.de;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 phytec.de discourages use of 91.26.50.189 as permitted sender)
Received: from Postix.phytec.de (91.26.50.189) by
 AMS0EPF0000019B.mail.protection.outlook.com (10.167.16.247) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Wed, 13 May 2026 07:19:13 +0000
Received: from phytec.de (172.25.0.51) by Postix.phytec.de (172.25.0.11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 13 May
 2026 09:19:13 +0200
From: Wadim Egorov <w.egorov@phytec.de>
To: <trini@konsulko.com>, <d.haller@phytec.de>, <peng.fan@nxp.com>,
 <jh80.chung@samsung.com>, <m.schwan@phytec.de>
CC: <u-boot@lists.denx.de>, <upstream@lists.phytec.de>
Subject: [PATCH 0/7] board: phytec: Update rm-cfgs, env and docs
Date: Wed, 13 May 2026 09:18:58 +0200
Message-ID: <20260513071905.83522-1-w.egorov@phytec.de>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.25.0.51]
X-ClientProxiedBy: Postix.phytec.de (172.25.0.11) To Postix.phytec.de
 (172.25.0.11)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF0000019B:EE_|PAVP195MB2237:EE_
X-MS-Office365-Filtering-Correlation-Id: 70e4b91d-4ba0-48f4-c089-08deb0bfefae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|11063799003|18002099003|56012099003|3023799003;
X-Microsoft-Antispam-Message-Info: BpjLHVSvuZ1qxYf9a78VXDZOe3LJMd8G1a11tAT1vJAu8Xhc3X8SLoF2z5V2q2qVYq/LW4NiPPjM/mASp788M6m8KkUGuiT1ZTXnlUNruB5x2rfLDnNPvEMwMra2RRXE68zQefjBLNctc1zLblZ0aNcVUJe3nGQIDr4jlIbavT9+/w1s4McK3ILS9Umh85SZrtTuo0b3x3d44TPuYPqENyTKPt09qNyGDgj6YUeaj2SH9p0PK+b9RlGG4t3bc9GBz+qdT8iW+U2+dDNBIfGMv8rj5Bd3T4zx77qee7wMy9M6LNg0B7XZnn14RY2bE6G4YqCWQmBAHdl0TdJAr1TOmS9Rc7sVbA6yx9xblQtf0u1P7Xv5/78oyL5uOnlPPaE+rJiF3lqSnZpBT57y5RmaIzVpviZFG2Qe3sXMZHu3hYz5hFLuNq7hh2l8+m2wH9YaYTNVb3onI8wz8oLvbz6uSll472lSMHMF4b5GJ+GQh8dhWfvlGfe1ZlGoKHru8z6dcYdqyLRBayWjfOB7gcQRc4/Yyh1bCIPY4cmkN8RQuvKfzuw0k1NB9SAxeO/FztcOxBQs2pT90jixSH8hh7WCCOgXIz8VHNcvwT2iiMozgFXTiIlacMLMJr/zk2/1ov4xMsg7aZyCH4S3TLhC4gWIGaZq8olu9QAlA7wSbMqJG/Oz8RIG6iVfGeRwMBlM0SLnv0vcpY/37ezdlo/ADr3+ebgQwimdjrSpTXtrUzA6nIA=
X-Forefront-Antispam-Report: CIP:91.26.50.189; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:Postix.phytec.de; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(11063799003)(18002099003)(56012099003)(3023799003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: DWKVldJ+9ZWspdbbX2SAOAaDpzPT3z8ZxzYnrNQfFMQyiah8x5CRJbHZEDnybIUvP1Rzn1Z22qNwRNzKJGvG304LC3zpOxz8AbbtErrHI9XHOj6kk8e0t4+Jf8RqN2Y1GEWU0Ea4Es9pxX0VhRemn96pSGXXwKWniV0VJv96dTkEhoyeYr7jXMorP71ZjBAdurln3YB1iLOk9ZwNr/Pse4djJshzNMx5iBYjnmcqzWGBLCDOn986H7+JMle2mENw3wizZAKGS/WlGY5sprh2uHlCD0o8NNp0DkhVz2HROsUIpuFx1ogDTkeI3Ow87DvOCbZ8fAnUoEV+2x4dWWGtt+U75itqTzWA1dlEATP4dVcvBk6I4W1jqmXAWCC2uCdVxTLjlZVecgtXtXUU5zn9GCefCZSIyoCCklwskIGBG5xvOiSvFNNxuDYBZFnKSYR1
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 07:19:13.9174 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70e4b91d-4ba0-48f4-c089-08deb0bfefae
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e609157c-80e2-446d-9be3-9c99c2399d29; Ip=[91.26.50.189];
 Helo=[Postix.phytec.de]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF0000019B.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVP195MB2237
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

This is a small updates across all K3 based phytec SoMs.
Update docs, rm-cfg yaml files and drop rauc environment.

Wadim Egorov (7):
  board: phytec: phycore_am62x: Add tifs-rm-cfg
  arm: dts: k3-am625-phycore-som-binman: Enable tifs-rm-cfg
  board: phytec: phycore_am68x: Update rm-cfg
  include: env: phytec: Drop legacy RAUC boot logic
  doc: board: phytec: Fix typos and copy-paste errors in K3 docs
  doc: board: phytec: k3: Document boot flow and watchdog
  doc: board: phytec: Document DDR size override Kconfigs

 arch/arm/dts/k3-am625-phycore-som-binman.dtsi |   5 +
 board/phytec/phycore_am62x/tifs-rm-cfg.yaml   | 867 ++++++++++++++++++
 board/phytec/phycore_am68x/rm-cfg.yaml        |  14 +-
 doc/board/phytec/k3-common.rst                |  47 +
 doc/board/phytec/phycore-am62ax.rst           |   8 +-
 doc/board/phytec/phycore-am62x.rst            |  21 +-
 doc/board/phytec/phycore-am64x.rst            |  24 +-
 include/env/phytec/k3_mmc.env                 |   4 +-
 include/env/phytec/rauc.env                   |  52 --
 9 files changed, 972 insertions(+), 70 deletions(-)
 create mode 100644 board/phytec/phycore_am62x/tifs-rm-cfg.yaml
 delete mode 100644 include/env/phytec/rauc.env

-- 
2.48.1

