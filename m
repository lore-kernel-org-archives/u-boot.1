Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73E08EE4996
	for <u-boot@archiver.kernel.org>; Tue, 22 Aug 2023 13:49:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9160586429;
	Tue, 22 Aug 2023 15:49:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=de.bosch.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=de.bosch.com header.i=@de.bosch.com header.b="q6gTFq6X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB06C86428; Tue, 22 Aug 2023 15:49:25 +0200 (CEST)
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01on062e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe02::62e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24F9F847C3
 for <u-boot@lists.denx.de>; Tue, 22 Aug 2023 15:49:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=de.bosch.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=Thomas.Mittelstaedt@de.bosch.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YBeQGRrlSeRs2p/OMFZ0KlLR90xtydQim0fKnpS4qindm7bgLF6Sl6YKCrT4PHtBbHURGJO84skIf19PxSCCMZpAKr+fpxctD21cL0r/CnM2te69aP96fdmVceYNhpwHZjFq56dFZTSiF29oSMQz+tMULzh346O46MFe0/bvBblX/HfhxrptRCvJ+Al385F6bjafTxxMzohf9fhaMMsZtcB7gK3RgKknZ8nsyW3eh2MsLaLmvYar7scdcPeYHy0se2JjmOazyxdwkqwBrP0rtK9qQfIfK9MWVA98zpQtF2i43S1DuJN5exMaSnXBq3yma1nMKq2O8BpH0SqvP/gEWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9wqNySPPqv7SXbnNOzJkpSfdunfVHZTP+t66sITdTik=;
 b=Twl8x6sIOjG8vxWY+5iurgIKba3a42Yj8jySHD5TTyqhJXfQpo98pHhxlz8o27YO06wlN86/Czx4hRY82fxZRMGHljSqvi7D75oEVuXdgg8IIoVjQ+uJHxv9vSd0D2rOsY6+EfG3OORKj7OxMpBWo1bUSg3IXckMGLw7bkw2YEaXiDJS3hkwZhKvXBY152WaUe2zASOYM4M8VK0jqfn0f4HP+xg/CiRctqyGHVn4fH1JmY6pSSsQ8kSDJBPhystOZzU7WoXKYolRV7ZI3fHu1n+tI5Mwnmt7KTER6KN+L/Yq2F4pXuuw3q34XWoAz6qfh2f1Nq1UaRNaVNDwB6GlgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 139.15.153.199) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=de.bosch.com;
 dmarc=pass (p=reject sp=none pct=100) action=none header.from=de.bosch.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=de.bosch.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9wqNySPPqv7SXbnNOzJkpSfdunfVHZTP+t66sITdTik=;
 b=q6gTFq6XazJGhuus0fd0pnVQulVsrVxqJ+chaPRMu4j/ETfWyeXxQc0a7c8WiVokb7TXQ3Q/tzEH4H+jZCmVMrM7TfixcC7oFg5Hqs+aBJQ1WfDYBJWTAeoonJOVsMtg9X3fHzJSII3KxY1mPB2gzR6wAEM/4/jOyLRPjRj0BVayL8aD5qtXay9aWNeCUAV/SCzooL2ka+RJ5CQEThqGmvdJfGHG9orOrioawcn1ASmWdNwOQ5MuKZvqfPd9ACUpt9sKoJfQ45etXr634gwd10N07elucji93Pwic2sUowBrsV7BAf81Sat6zPYa8mQI9CknLaRaoh7ogJhUCAAq6w==
Received: from AS9P250CA0018.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:532::21)
 by GV1PR10MB6372.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:a5::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Tue, 22 Aug
 2023 13:49:19 +0000
Received: from AM7EUR03FT018.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:532:cafe::84) by AS9P250CA0018.outlook.office365.com
 (2603:10a6:20b:532::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20 via Frontend
 Transport; Tue, 22 Aug 2023 13:49:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 139.15.153.199)
 smtp.mailfrom=de.bosch.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=de.bosch.com;
Received-SPF: Pass (protection.outlook.com: domain of de.bosch.com designates
 139.15.153.199 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=139.15.153.199; helo=eop.bosch-org.com; pr=C
Received: from eop.bosch-org.com (139.15.153.199) by
 AM7EUR03FT018.mail.protection.outlook.com (100.127.140.97) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6723.15 via Frontend Transport; Tue, 22 Aug 2023 13:49:19 +0000
Received: from FE-EXCAS2001.de.bosch.com (10.139.217.200) by eop.bosch-org.com
 (139.15.153.199) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 22 Aug
 2023 15:49:17 +0200
Received: from SI-HUB2000.de.bosch.com (10.4.103.108) by
 FE-EXCAS2001.de.bosch.com (10.139.217.200) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.31; Tue, 22 Aug 2023 15:49:17 +0200
Received: from localhost.localdomain (10.34.189.209) by
 SI-HUB2000.de.bosch.com (10.4.103.108) with Microsoft SMTP Server id
 15.1.2507.31; Tue, 22 Aug 2023 15:49:16 +0200
From: <thomas.mittelstaedt@de.bosch.com>
To: <u-boot@lists.denx.de>
CC: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH v3 0/1] *** Documentation extended with specific information
 for VirtualBox ***
Date: Tue, 22 Aug 2023 13:49:01 +0000
Message-ID: <20230822134902.33032-1-thomas.mittelstaedt@de.bosch.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.34.189.209]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7EUR03FT018:EE_|GV1PR10MB6372:EE_
X-MS-Office365-Filtering-Correlation-Id: 9033c9ce-d1a2-4daa-df24-08dba3169593
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qbWLKPcaX/AAGIxEMHQktKAiYZ+vE+0P/Ce8r6hJ5gDPEmD9kJrVFkf7x0+KbB428Sm74d+IGOH8DHc8B7IVLkZVxp6ozAGwlhJwrQJOQ8nNxg2uegacgONMmydTEDYvk/3PeSr6i6udT26efXhe+IDXSEtrNxk2dPCDPyc2fOo7QQvWgV1/4wrMksxK788XNuHHNWcs1tPl/TrFboy3KWsQzZPAwrfnXtoRORa1lyDh58yrQZsz6XhBFntn6mNK/Hvk4IiLnVAnltDPuJNI5ttZYuyDgoF+wWf3yM+F49RvFJCETz4OdHtRFOPQFkpDelrsDugxFgyR3xW/jpyjqobXtR6OSp4Ecshy77oUFX3EpjpQtEPc8ArR4Zd+RsdtH0L4zZaPDx5y4S5gFo0p/L0W+3+foIqOhEIc5yfqRzAdVlKWWcKkmC5cQEUMA8axLzB6tehCqVIRSTc09UiLms8znTdZsOjjzhNyv/EQYN6hhoRDe7SnKNV7SQcq/qa9H7RoVjbzAP4hjyUTSDGvZQjqb7lMkUzEmR7+RoSSyQqkwMSF7Saw2/BXxNte0EPDjbieoV8NAkSTnTAkgUa/BziWQ2dGR89I4RZCLuEsMzmJlId0pnLcJT1LZ/2pVEknwE89cRivXDfTkzz+l6Gtjb1adWqNPGCTIfbWXzcuC9V+Ha/3Me1khKlm88V2ovm/xa6QFm2dNsIxoYoOUBjb8ljOYNUlPFmDbR1LsxQq+iwyWC7ym/QcsP2Zp+pyr8pcT8N4TlLI324IrzNfZuon9Xr8nPyQRsKiT1BYZFG9uKftkVI5v9z28HiC64TBReHl
X-Forefront-Antispam-Report: CIP:139.15.153.199; CTRY:DE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:eop.bosch-org.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(39860400002)(376002)(346002)(396003)(1800799009)(186009)(82310400011)(451199024)(46966006)(40470700004)(36840700001)(40480700001)(86362001)(82960400001)(81166007)(40460700003)(478600001)(70206006)(82740400003)(316002)(54906003)(6916009)(41300700001)(70586007)(356005)(6666004)(26005)(47076005)(16526019)(1076003)(2616005)(2876002)(426003)(336012)(5660300002)(8936002)(2906002)(4744005)(8676002)(36860700001)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: de.bosch.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 13:49:19.6380 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9033c9ce-d1a2-4daa-df24-08dba3169593
X-MS-Exchange-CrossTenant-Id: 0ae51e19-07c8-4e4b-bb6d-648ee58410f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=0ae51e19-07c8-4e4b-bb6d-648ee58410f4; Ip=[139.15.153.199];
 Helo=[eop.bosch-org.com]
X-MS-Exchange-CrossTenant-AuthSource: AM7EUR03FT018.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6372
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

From: Thomas Mittelstaedt <thomas.mittelstaedt@de.bosch.com>

Changes compared to V1:

- Findings from H.Schuchardt applied
- Partition scheme changed from 3 to 2 partitions

Thomas Mittelstaedt (1):
  Documentation extended with specific information for VirtualBox

 doc/develop/uefi/u-boot_on_efi.rst | 84 ++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

-- 
2.30.2

