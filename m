Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87AB3C25B47
	for <u-boot@archiver.kernel.org>; Fri, 27 Oct 2023 20:57:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9B7287735;
	Fri, 27 Oct 2023 22:57:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=seco.com header.i=@seco.com header.b="rUmN4bFd";
	dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b="rUmN4bFd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A200B8773B; Fri, 27 Oct 2023 22:57:43 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2062e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1b::62e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A1DE87732
 for <u-boot@lists.denx.de>; Fri, 27 Oct 2023 22:57:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sean.anderson@seco.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=Z4MdzYCc2h0UJHvipgm5LVOscWxM9FmIkwsdG+Hojjq4owW0MccgQTi5TF8AIYEilsvY4QtFE3iNz7PTQoO7r1Qq8f+kVd96RzNHGAM3ssiALeDOFj98KBnyCh4qo/TO1gy2WBBwSrwKx7lIaBpBbFOkzSxAUI62Pmdlkl0esAic95Nde2Nw7pHikh3pFXzjgd1ieOzOvdaHT2djGL8m+hfX+6HReglz1HsWsqjdNfnkWoOR+AVL3UlFy/TY/eGX+D6lybfNLS5b82zdCHuJdO602tmKjiYxd88ROuzWlaEsZatG1ZqP32pBVrcXAACbDquZryxCQHiNDojiQgfvFA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JD4zFyhEfEKkItG/0GpPdrRVejIR71vtPlJSL/gnWeY=;
 b=QtJw7fcYAmK4w+6WvuNisR03issDmR1FBwY3IKnhPtwLbSsXEAoM+b9EYDjo7JS8eTbhbemN5aWtsxIkCBqyTKCp4SRTeiti8S7I5lX17hmxJr+NXmdHPXtAro8nmj9MN4TEUvuLPzlTGlYaUa7/mu0KvbzpZ6eq5EMB1z27X/8vdrhxd4AElujyVxWba2Uyew2CAdRGZcBOqp+oAqp3M0aGCYt7Q+E2cQl6SMSxGUAUO8e7czeDrkQNzc+C7KGdmZQAqF7JEXTDddJ0KwTPT4NAVS4icd2JEg3vWYS6b98gie2Q7ei1No/WiDUUimUn5GofKr5Px0IzFh6w0jZxRQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.160.56.83) smtp.rcpttodomain=broadcom.com smtp.mailfrom=seco.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=seco.com;
 dkim=pass (signature was verified) header.d=seco.com; arc=pass (0 oda=1
 ltdi=1 spf=[1,1,smtp.mailfrom=seco.com] dkim=[1,1,header.d=seco.com]
 dmarc=[1,1,header.from=seco.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JD4zFyhEfEKkItG/0GpPdrRVejIR71vtPlJSL/gnWeY=;
 b=rUmN4bFdVhAPfguUjcIDhSGLuRnv70aFw5qtySmYxA3nmfhl7ZJ9Ho/rlbAWthsoL7kZJqdCJjAkzU7GJJAS/JV1NKYgQ4k1kBuRwTnT3D2eFjltlgnSvz67l12LeKyLbvkP0KMDAa15j7vOZSqJUnvuS5p1fWf4hyU1zPQQxmpTnXN7JmyN3a6+WP13y8egnmg54drH7q8HBZosPPqY5NR+6CNeQb/WVR8yNhtPCOlGLaRDCHIMXYbaKnildcLEY+GwpK+aX5n4k/LnWJ+PEn9zNia8SYrM0f7DuiKeJzAY0rSxNreQnSAgROCZPnlhW8Qp0OGQtpCC7IZHX9M/IQ==
Received: from AM6PR04CA0048.eurprd04.prod.outlook.com (2603:10a6:20b:f0::25)
 by GVXPR03MB10513.eurprd03.prod.outlook.com (2603:10a6:150:158::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.22; Fri, 27 Oct
 2023 20:57:37 +0000
Received: from VI1EUR05FT018.eop-eur05.prod.protection.outlook.com
 (2603:10a6:20b:f0:cafe::5a) by AM6PR04CA0048.outlook.office365.com
 (2603:10a6:20b:f0::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.25 via Frontend
 Transport; Fri, 27 Oct 2023 20:57:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.160.56.83)
 smtp.mailfrom=seco.com; dkim=pass (signature was verified)
 header.d=seco.com;dmarc=pass action=none header.from=seco.com;
Received-SPF: Pass (protection.outlook.com: domain of seco.com designates
 20.160.56.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.160.56.83; helo=inpost-eu.tmcas.trendmicro.com; pr=C
Received: from inpost-eu.tmcas.trendmicro.com (20.160.56.83) by
 VI1EUR05FT018.mail.protection.outlook.com (10.233.243.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6954.12 via Frontend Transport; Fri, 27 Oct 2023 20:57:36 +0000
Received: from outmta (unknown [192.168.82.132])
 by inpost-eu.tmcas.trendmicro.com (Trend Micro CAS) with ESMTP id
 C0052200813AA; Fri, 27 Oct 2023 20:57:35 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (unknown
 [104.47.14.51])
 by repre.tmcas.trendmicro.com (Trend Micro CAS) with ESMTPS id 08E402008006E; 
 Fri, 27 Oct 2023 20:57:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UPVBrd+QHZsSuySYhpaHbG/lNmfWKLi38RRHpfVVnflLgml2J7kFvwhiWME2/61F1cxz2+CnddDp6+WLjWf5ysJbgLnPjiSk79LFUyePBZrWcErZl9bhc35iYDK2KjuuQwnO0wzvjZCBYVbNQ8X+3/EVxxPG7yz2pAaUzgMC2JIC82VjayFrqXUYAmBEtytXCFw5uVImB+OyQFP51o7FlhrsjEBrC0V70GGCkvw1/neEl5uoOZdM2wv0vDeJZyPOrdiZIcHjnYsgFj8jxz613Wjn+HbaFhnp3ZnkwB7qQzHYu5m4L+Wozxd3b0eHuZsfE3C+IqW95VMBFfN5a9MdUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JD4zFyhEfEKkItG/0GpPdrRVejIR71vtPlJSL/gnWeY=;
 b=lPkIvg7LBG5BgPw5xgV8yrPLW3PRKxq53dRDaQ0HAqW2mQBxL0wdvuOPec4VQsykFI195HIwtLwZLuoHlxANec9WfG2NyuMNzmKLhJBu9ivu6o3dW4l3zIaQPfa+1bl3Fxxzf7QTu1bUJI/GzXAfCYcWlf1KbsNqCGUh7xM71kO1QC0dZOSebxTTinjjVGHhT/64QpaBbIXz4CVRSH1zT/SOiP6zNx9kLckYyomnmO99yiQH2pLWYloeDbIc7hl16YhreFliPIa97c6T3hXv3L2v2MDngd66eCs0ayybAuUpNJef7uUi62nqH0HBsFJ6XTi3gxD/3s6QF5HfhOBwDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JD4zFyhEfEKkItG/0GpPdrRVejIR71vtPlJSL/gnWeY=;
 b=rUmN4bFdVhAPfguUjcIDhSGLuRnv70aFw5qtySmYxA3nmfhl7ZJ9Ho/rlbAWthsoL7kZJqdCJjAkzU7GJJAS/JV1NKYgQ4k1kBuRwTnT3D2eFjltlgnSvz67l12LeKyLbvkP0KMDAa15j7vOZSqJUnvuS5p1fWf4hyU1zPQQxmpTnXN7JmyN3a6+WP13y8egnmg54drH7q8HBZosPPqY5NR+6CNeQb/WVR8yNhtPCOlGLaRDCHIMXYbaKnildcLEY+GwpK+aX5n4k/LnWJ+PEn9zNia8SYrM0f7DuiKeJzAY0rSxNreQnSAgROCZPnlhW8Qp0OGQtpCC7IZHX9M/IQ==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com (2603:10a6:10:3dd::13)
 by AS8PR03MB9843.eurprd03.prod.outlook.com (2603:10a6:20b:618::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Fri, 27 Oct
 2023 20:57:27 +0000
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::7d1a:d4ce:f301:582a]) by DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::7d1a:d4ce:f301:582a%6]) with mapi id 15.20.6933.024; Fri, 27 Oct 2023
 20:57:27 +0000
From: Sean Anderson <sean.anderson@seco.com>
To: u-boot@lists.denx.de,
	Jaehoon Chung <jh80.chung@samsung.com>
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Bharat Kumar Reddy Gooty <bharat.gooty@broadcom.com>,
 Henrik Grimler <henrik@grimler.se>, Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH] mmc: sdhci: Rework SDHCI_QUIRK_BROKEN_R1B
Date: Fri, 27 Oct 2023 16:57:03 -0400
Message-Id: <20231027205702.1549693-1-sean.anderson@seco.com>
X-Mailer: git-send-email 2.35.1.1320.gc452695387.dirty
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0122.namprd03.prod.outlook.com
 (2603:10b6:208:32e::7) To DB9PR03MB8847.eurprd03.prod.outlook.com
 (2603:10a6:10:3dd::13)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB9PR03MB8847:EE_|AS8PR03MB9843:EE_|VI1EUR05FT018:EE_|GVXPR03MB10513:EE_
X-MS-Office365-Filtering-Correlation-Id: da908dce-d7c1-43cd-c658-08dbd72f592c
X-TrendMicro-CAS-OUT-LOOP-IDENTIFIER: 656f966764b7fb185830381c646b41a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 8P1Dyi1fmrXu1CoPlJpA0nqZl2g6mq/OvaSwyKmD9hNiAfChjOxxOxTGJzgGpGPC/jMGwIuiQvHTfFMMuHaLw2r00kC9RFWJjAhDayoow0lWi1hKwk0ArzoyqpmtiCRuoex2vZ1dUCUZG5iYyi21uLN9bm3zHHRMo2eJ+JkS3gDoZs7+wskdoSrhWGb4NBS74UYgfyJLn+1bjDN2SVOR6gRyprf0aJIH0YqkX17tuFVWmkNVUsCGedKaM5EUM9p3pTjLnELO0v3RNAfcGGXZ7HjEUK8ADCCpZkcfJoH9HZxPgcQC5ww0O8YMapRdRthwpgtz1vRE5JUZQqgtLVtVd2wtyqLxNu7a5bkGsKwgofLzTdh7OwXvnpa1mH6d+8fSSfqYQXIRur4cHCtvhSs+y14Q97rTNUZHUOwPuHecP+J0Xcoz+v4P/7AKg1Y4+V1qIHO5sXiRNu+WH4WU7NOg3uYQfOoO7gCtdrLUnknnOVeZ47UZHZ2pHFfHX6GLzLe25pAxWcWLgYTVMkZfj1rGHePgIcJ5dOy7hsmhgf/vIkM7pBLPuf9xw8eEr1BbA/NIncVfiGg0WIBFP9fz1gNNLgyMk0KNT3ryatWkGtM+8zvoetCbHrI7HM4YARmQB2u1
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:DB9PR03MB8847.eurprd03.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230031)(39850400004)(376002)(366004)(136003)(346002)(396003)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(52116002)(83380400001)(1076003)(107886003)(2906002)(26005)(41300700001)(8676002)(8936002)(478600001)(6666004)(44832011)(86362001)(54906003)(66556008)(66476007)(6916009)(66946007)(38100700002)(316002)(4326008)(6486002)(38350700005)(5660300002)(36756003)(2616005)(6512007)(6506007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB9843
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VI1EUR05FT018.eop-eur05.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: cb872329-fe5a-456b-4c0f-08dbd72f5379
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0D2Zu0oKlUsyQDk9maDnPECbE+LTaFCK7l3Qje3T39TRBIOE8j0XFkdhhGD2RgtSOBqGnG0CO/BZs/nipYZgXL4iCLkG+RoNR0Kffg6yGu7opDzmzYURJWn5bGLoxMK/cr5i8A2a3FwlzY1V55BKIFOyR2PvMMSzr68EAkAOQQz/eBxmq2J8XdMUkOpYsrHeZZpuV5vZaAVHGkJmLY2nmawdrclm5kjXKWHDa3p1g55yhOWUgMqeZRHFoTREjF/7fvMNPyZX687YlfmrgIWtNMHfaZi0rAt1CEydr29hrtTwkSwcEsw2pazy1csIKcrhLgDGBvAeQg6z4Z+IhP++OHe1JvdxLT8Sv/4xE6a3/qDHMMUSH+2eQlee+821ZgpoyiqDeR+9o1BLGiOUwemi9E292KFEdWDp1Ie0OBDhLBxX1JiPli1qy/bRa4qxIQsdyJL467nCByWnOYQF+dFFe+YivzqxoNOIY8mFceEjaZMFeE4t/zue766qfcFSrQGfl8OS8scgLrSfUbrqmqcl1lFZ5H+mLdHKft+/0SEYhn3VORjgwnOwxlPDDd+5eWQqb1phLCVJgWipDOmI5+a2d+vSWfJrDysNtSL2lv3vXUrljisFr16q8DUPehdysT+SdOtAxzgrKTvxYJf/4hQCZ7TcXeWDTIyGBQBijImZg98iCx5uN87uXG3J1BFRKcaUTRDDlk87TRaOABhupVTn3dgr8F+qqPs8Zk0Yw0nPVtrb/LNdFmw9YzXXZlPjDp4LT8jvrjEO11/aU7/sv3RNRg==
X-Forefront-Antispam-Report: CIP:20.160.56.83; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:inpost-eu.tmcas.trendmicro.com;
 PTR:inpost-eu.tmcas.trendmicro.com; CAT:NONE;
 SFS:(13230031)(39850400004)(396003)(376002)(136003)(346002)(230922051799003)(82310400011)(451199024)(186009)(1800799009)(64100799003)(36840700001)(40470700004)(46966006)(86362001)(2906002)(83380400001)(36860700001)(34070700002)(47076005)(336012)(40480700001)(1076003)(5660300002)(7636003)(356005)(7596003)(6512007)(2616005)(40460700003)(82740400003)(41300700001)(44832011)(107886003)(6666004)(54906003)(70586007)(36756003)(316002)(6916009)(6506007)(8676002)(478600001)(6486002)(4326008)(26005)(70206006)(8936002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 20:57:36.1660 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da908dce-d7c1-43cd-c658-08dbd72f592c
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bebe97c3-6438-442e-ade3-ff17aa50e733; Ip=[20.160.56.83];
 Helo=[inpost-eu.tmcas.trendmicro.com]
X-MS-Exchange-CrossTenant-AuthSource: VI1EUR05FT018.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR03MB10513
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

As noted in commit 3a6383207be ("mmc: sdhci: add the quirk for broken
r1b response"), some MMC controllers don't always set the transfer
complete bit with R1b responses.

According to the SD Host Controller Simplified Specification v4.20,

> In the case of a command pairing with response-with-busy[, Transfer
> Complete] is set when busy is de-asserted. Refer to DAT Line Active
> and Command Inhibit (DAT) in the Present State register.

By polling the DAT Line Active bit in the present state register, we can
detect when we are no longer busy, without waiting for a long timeout.
This results in much faster reads/writes on buggy controllers.

Signed-off-by: Sean Anderson <sean.anderson@seco.com>
---
I've CC'd a few people who've added this quirk to controllers recently.
Please let me know if your hardware still works. It's possible that my
hardware is buggy in a different way.

 drivers/mmc/sdhci.c | 19 ++++++++++++-------
 include/sdhci.h     |  1 +
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/sdhci.c b/drivers/mmc/sdhci.c
index fc9c6c37996..0178ed8a11e 100644
--- a/drivers/mmc/sdhci.c
+++ b/drivers/mmc/sdhci.c
@@ -306,14 +306,19 @@ static int sdhci_send_command(struct mmc *mmc, struct mmc_cmd *cmd,
 		if (stat & SDHCI_INT_ERROR)
 			break;
 
-		if (get_timer(start) >= SDHCI_READ_STATUS_TIMEOUT) {
-			if (host->quirks & SDHCI_QUIRK_BROKEN_R1B) {
+		if (host->quirks & SDHCI_QUIRK_BROKEN_R1B &&
+		    cmd->resp_type & MMC_RSP_BUSY && !data) {
+			unsigned int state =
+				sdhci_readl(host, SDHCI_PRESENT_STATE);
+
+			if (!(state & SDHCI_DAT_ACTIVE))
 				return 0;
-			} else {
-				printf("%s: Timeout for status update!\n",
-				       __func__);
-				return -ETIMEDOUT;
-			}
+		}
+
+		if (get_timer(start) >= SDHCI_READ_STATUS_TIMEOUT) {
+			printf("%s: Timeout for status update: %08x %08x\n",
+			       __func__, stat, mask);
+			return -ETIMEDOUT;
 		}
 	} while ((stat & mask) != mask);
 
diff --git a/include/sdhci.h b/include/sdhci.h
index 70fefca2a97..a1b74e3bd79 100644
--- a/include/sdhci.h
+++ b/include/sdhci.h
@@ -57,6 +57,7 @@
 #define SDHCI_PRESENT_STATE	0x24
 #define  SDHCI_CMD_INHIBIT	BIT(0)
 #define  SDHCI_DATA_INHIBIT	BIT(1)
+#define  SDHCI_DAT_ACTIVE	BIT(2)
 #define  SDHCI_DOING_WRITE	BIT(8)
 #define  SDHCI_DOING_READ	BIT(9)
 #define  SDHCI_SPACE_AVAILABLE	BIT(10)
-- 
2.35.1.1320.gc452695387.dirty

