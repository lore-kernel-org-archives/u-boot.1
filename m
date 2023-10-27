Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E9D4C25B48
	for <u-boot@archiver.kernel.org>; Fri, 27 Oct 2023 20:08:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6A7A087687;
	Fri, 27 Oct 2023 22:08:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=seco.com header.i=@seco.com header.b="Et98QMOD";
	dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b="Et98QMOD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 32FF387685; Fri, 27 Oct 2023 22:08:08 +0200 (CEST)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on20618.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaf::618])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE6BE87691
 for <u-boot@lists.denx.de>; Fri, 27 Oct 2023 22:08:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sean.anderson@seco.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=f0CheeMxYggcS3XhV46J8XJ92PcWC5bnKY4ECWaI6c6DABpvP+xYx02eMT6hiEuKc1hK8eE/G8WLXJGI2HOUbZCDF9CJXNEtmkiH910nptcULOcOWgLYHwfhzQwx47ng9Mb2SlLY0Jdkp45dsWt5o3NANdCd7GBgtc+7NCEipximDEcVg9/MR3wZEH3dwjZymrMB4AtMUWLM0Es/mFEdzMboheQIR44fhC9OECeyw7oRpkQ/Sx0t7CE8QafRmZkaOZBE0b9P6ehYbFSKjT/FQn3Af5yd0LUVpd0zAJeeu8FyazzFKeoOYSEg/X4NT7vCRFdTdW/GS4g+iRgO/Z+rCw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J/fmOmpkN9c/feuwlEGG6XGCjsbV6ArEg8qUqZTz5kE=;
 b=W4z2fxLclGyR4aPsxFjhgbiOise7ketY3uDuYxn7suEvRYen5IR9vLYnccl0r+KoIdwfxlNOU4SwPOVijckyj2Y9rEHEc+Oz6HFr77sgFTOSajTCNZZw7ACNZJOIzdsNJE5rTGb26kv/YWFekhoXb9/Dj0RHQSpzR//SSk6uQ9VO5Kvs4J3ZmFVauy2hoQl5hl5XAle4R+Qj7ndy7UmBxVkaKHmprdD32FmVNoPDqnU9RBotRafGeURNUr7vgcp6VW+yVnAYHd9Cy6uJv1q/HdHgGlkIsI4RdmgVYYYrDZTta6CzI2s794XcsAxoi2puCRQrZJj86s6v1ObTn8EQ8g==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.160.56.87) smtp.rcpttodomain=chromium.org smtp.mailfrom=seco.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=seco.com;
 dkim=pass (signature was verified) header.d=seco.com; arc=pass (0 oda=1
 ltdi=1 spf=[1,1,smtp.mailfrom=seco.com] dkim=[1,1,header.d=seco.com]
 dmarc=[1,1,header.from=seco.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J/fmOmpkN9c/feuwlEGG6XGCjsbV6ArEg8qUqZTz5kE=;
 b=Et98QMODQwoAjry8l9SNcOXvDBpp1H7JsMS0Pjwn/tdN3rBstQJt1iaF+Vk7IRiydn1ou4JMzBHHrw3uhMIB5+7E+R48f1MG2WmQ4ieNU+SkLZBiSa7ZANZUQYt7a1a6l388SZz4yht4XyTXIl44fUhjwp/c8rSWEwOPEMI5kEMJdppYG0i1Aa8LsxoNfIzfw8PAocMmF4WmSeOXsuronl7woY/t6RjQgRHV/QW+upTm1nI3X/fDfgpPo0QcYSMOxs8d5WNuTCzi5xQ02REJ3yEgANM3z6DjE8S6JadsXlhV36y+RAFXjIIMuDkPOn62IKX2tuYaVmC8uz5MOUwZHw==
Received: from DBBPR09CA0016.eurprd09.prod.outlook.com (2603:10a6:10:c0::28)
 by DU0PR03MB9228.eurprd03.prod.outlook.com (2603:10a6:10:474::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Fri, 27 Oct
 2023 20:08:02 +0000
Received: from DB8EUR05FT034.eop-eur05.prod.protection.outlook.com
 (2603:10a6:10:c0:cafe::55) by DBBPR09CA0016.outlook.office365.com
 (2603:10a6:10:c0::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.25 via Frontend
 Transport; Fri, 27 Oct 2023 20:08:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.160.56.87)
 smtp.mailfrom=seco.com; dkim=pass (signature was verified)
 header.d=seco.com;dmarc=pass action=none header.from=seco.com;
Received-SPF: Pass (protection.outlook.com: domain of seco.com designates
 20.160.56.87 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.160.56.87; helo=inpost-eu.tmcas.trendmicro.com; pr=C
Received: from inpost-eu.tmcas.trendmicro.com (20.160.56.87) by
 DB8EUR05FT034.mail.protection.outlook.com (10.233.238.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6954.12 via Frontend Transport; Fri, 27 Oct 2023 20:08:01 +0000
Received: from outmta (unknown [192.168.82.133])
 by inpost-eu.tmcas.trendmicro.com (Trend Micro CAS) with ESMTP id
 663A52008009A; Fri, 27 Oct 2023 20:08:01 +0000 (UTC)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (unknown
 [104.47.11.233])
 by repre.tmcas.trendmicro.com (Trend Micro CAS) with ESMTPS id 74E5E2008006E; 
 Fri, 27 Oct 2023 20:08:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WZngYMNpMTy1GUlbjZFAilOCHmS2Qf+84myNwysqTm3jBU0aAMTCP7ipeMNnQVuUQ6wXPjoOxQb+pUejr/JTDLmp0piv1pNT5Sw59lZh8u0XQpR6awM6ZswbPjeRUU3PuD5rhXDvH9FTulrjNb9mMIKVQNEEFEN2Y7smsogGX/Ig3ucLyEUATVj+yRA8yGCxv57BQRartExWf0JG2JEeFSUzd4bCEcO/jAZJnkBs0F3aTkOj20VTEIHn4F3DiRaeIoX3g+vcjlSomL6A/3svUfSKP+4rYTgK9xIOcyjmUr2FZ3YHTWy+pwuchYwa7pPxXzzuSvbd+h8BDiwLm0EnAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J/fmOmpkN9c/feuwlEGG6XGCjsbV6ArEg8qUqZTz5kE=;
 b=ibZbznofOevTfX+iIdcRKpOH1OmMQfkjYi+5JN6jmUnaytCVmkSG1xDEdjcBj47d6vYMvgMoYo2+o6yf/jPT78/eJ9p6JHHdBcs8YHuvjLv63nz90FYGFKCtn8orcCS+EW5uynp1dfq4uYGmrUqv4yx1rT8fCkJaFPntLwwHMI4Jx0riwWxoe8206Scpu3hdtSYFSGVaNvtl749N9K+1SPA9HidoIHvbSmgTuLnxynpMHCHH/ZDqySjJ2rB0WDXc2TXgRPsP8AgwqEQ2AujrFd8/UtRzSrzIZKZUdFCUKeIuAVqaWzd9ApVLfqYIpobKW9gqtyPGP9pWAgoaDyuinA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J/fmOmpkN9c/feuwlEGG6XGCjsbV6ArEg8qUqZTz5kE=;
 b=Et98QMODQwoAjry8l9SNcOXvDBpp1H7JsMS0Pjwn/tdN3rBstQJt1iaF+Vk7IRiydn1ou4JMzBHHrw3uhMIB5+7E+R48f1MG2WmQ4ieNU+SkLZBiSa7ZANZUQYt7a1a6l388SZz4yht4XyTXIl44fUhjwp/c8rSWEwOPEMI5kEMJdppYG0i1Aa8LsxoNfIzfw8PAocMmF4WmSeOXsuronl7woY/t6RjQgRHV/QW+upTm1nI3X/fDfgpPo0QcYSMOxs8d5WNuTCzi5xQ02REJ3yEgANM3z6DjE8S6JadsXlhV36y+RAFXjIIMuDkPOn62IKX2tuYaVmC8uz5MOUwZHw==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com (2603:10a6:10:3dd::13)
 by AS8PR03MB7717.eurprd03.prod.outlook.com (2603:10a6:20b:401::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.23; Fri, 27 Oct
 2023 20:07:59 +0000
Received: from DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::7d1a:d4ce:f301:582a]) by DB9PR03MB8847.eurprd03.prod.outlook.com
 ([fe80::7d1a:d4ce:f301:582a%6]) with mapi id 15.20.6933.024; Fri, 27 Oct 2023
 20:07:58 +0000
From: Sean Anderson <sean.anderson@seco.com>
To: u-boot@lists.denx.de,
	Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marex@denx.de>, Simon Glass <sjg@chromium.org>,
 Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH] bootm: Enable legacy VxWorks booting from FITs
Date: Fri, 27 Oct 2023 16:07:40 -0400
Message-Id: <20231027200741.1542324-1-sean.anderson@seco.com>
X-Mailer: git-send-email 2.35.1.1320.gc452695387.dirty
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR0102CA0033.prod.exchangelabs.com
 (2603:10b6:207:18::46) To DB9PR03MB8847.eurprd03.prod.outlook.com
 (2603:10a6:10:3dd::13)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DB9PR03MB8847:EE_|AS8PR03MB7717:EE_|DB8EUR05FT034:EE_|DU0PR03MB9228:EE_
X-MS-Office365-Filtering-Correlation-Id: 0aa0bf56-f83e-4c02-9c27-08dbd7286c3d
X-TrendMicro-CAS-OUT-LOOP-IDENTIFIER: 656f966764b7fb185830381c646b41a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: /2IOIOyEeNngeznmZZHdpfqjFdik+YpEwbYCZTRogH7gL4GzJQLAKL7HWgeuxK0OnSrslIHmAScZ0JDeBOBMI+67Abun6+FLmVlrg3CO9qzSfWLeK9+rHlICN7jZvOZgtxR7bRcGAtXkGijHGtnDNe1cZGR/Gj9UvsBYaMELmNqCqHqEjLlLv8wsfK4Ovo+qpiBtxi5S6qa9cAIYTPYOmPpXgw5CTQ3u4FnnLwz5MRVKOlujLT5LTSJY5ORhV3Orvj0JaA3/zZO50tT5zqJ0ED42dDS0wmojBHs1wL/LR0YqPqppneF3RsDQZZLHSE5hXsBXSbCjcfhFLiSk+fITpVV/E2X0M03F6Y+hNfzgcR48jCjMsPaG2Po+6JFL2JV6NEwHk6H7hNuyvLYzHEuYwZAO1sJOaDSp/Jh7IJ+XngHa/5ksa8hoOIzk4qLb8nyZXL6F+VaBeSEbU3z2ytYtswZyG7QcGndxyx3/FuxtoH2ttKrDrp+Xzet7Jr7a6ETYN7+TqlYmSWD/KREEHT2cZfZP1sXHht6KbJeVrWdb1lHQ9+sdu2S4Vwy3ulaIi/knm0REBZFtfCl5P0qGx026W3n9V1QvsNxL3PuYMT+Jjo+a3/J/58OMNYnGC76jsa0l
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:DB9PR03MB8847.eurprd03.prod.outlook.com;
 PTR:; CAT:NONE;
 SFS:(13230031)(6029001)(346002)(376002)(39850400004)(396003)(136003)(366004)(230922051799003)(1800799009)(451199024)(186009)(64100799003)(86362001)(4744005)(2906002)(44832011)(41300700001)(6916009)(316002)(66476007)(54906003)(66946007)(66556008)(1076003)(107886003)(8676002)(8936002)(4326008)(36756003)(5660300002)(6486002)(38350700005)(38100700002)(478600001)(83380400001)(2616005)(6666004)(26005)(6506007)(52116002)(6512007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB7717
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB8EUR05FT034.eop-eur05.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: f5dea507-c046-4607-8f84-08dbd7286a67
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VDhx0BVAGlO3csIrYeL8UpUgI9AK4wYLdjwSZKLG0E6V1cojok3tDgJ6DHFhg0W+2+X0a8CQ7whuQwz7cviNUtEU1jvEfBKKcjVFfMDjcI2sGm2wO2WaT5vlWTWXb+8BXBFefQERs/HGdMHDNMGGdZBmu0V3nGIzOfCNfgVunRbPM2Kb6Q83xB9AxgXOga7/1caltOUGq+xNcaqB10I1wqRQh7ZMrReXFbJXVGkICOaipqM4tWF8/3xG8Xj9dkrAcXjzt4bHflbOnliGb+6atgh79fEiihAVJ1NNlf+Ehff6af6mPrGWUnYjh2D7gH2uRtSkTqll6dK3x9uYRxocierAFmlejHoxAark37SmsHGoVThpOjKXToe4BZsAEQ8UNVVi8AQJ0tGYRLW8PsfpfeYCGSMhhVq7waoL3WmfG0x3kO4ABjtcQtVYamo1J6Ip9wo2MR92IrL4Nq/QPPNcrtC1qIapjwiLg1uMiU/wH2b5ZG2gFyq+B3gnbXW7tWwkA20AIvA7zXbTN3TRSCAsOS68geIp1ZhVQSrFYNtEPt3hJ3sMgFHh4MhvYW03viY0ymhN6cxZf2cVARCjGpB9D/7e69l56aqUJ11c6GkcBKs37QvS/TLmIj/RB4Ew1VFfwOOH57JAPpCjNZm0pxV0vUkJRYWuC3XBiqILX49V9FEd7VqaWJHn/uS6xSscpBcnuVh+we6VDYiADz4ttWmYzxmKtfgS9bwAEWus1jymGPz/evu3qNN9D/9FqubVz7tDcZ2PbLb08ArN/LqvGdboRw==
X-Forefront-Antispam-Report: CIP:20.160.56.87; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:inpost-eu.tmcas.trendmicro.com;
 PTR:inpost-eu.tmcas.trendmicro.com; CAT:NONE;
 SFS:(13230031)(6029001)(396003)(346002)(136003)(376002)(39850400004)(230922051799003)(186009)(451199024)(1800799009)(82310400011)(64100799003)(46966006)(36840700001)(40470700004)(6666004)(54906003)(7596003)(70206006)(6916009)(316002)(7636003)(356005)(70586007)(5660300002)(478600001)(6486002)(41300700001)(86362001)(44832011)(8676002)(4326008)(82740400003)(8936002)(6512007)(6506007)(36756003)(2616005)(1076003)(107886003)(2906002)(4744005)(34070700002)(336012)(40460700003)(40480700001)(83380400001)(47076005)(26005)(36860700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 20:08:01.6916 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0aa0bf56-f83e-4c02-9c27-08dbd7286c3d
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bebe97c3-6438-442e-ade3-ff17aa50e733; Ip=[20.160.56.87];
 Helo=[inpost-eu.tmcas.trendmicro.com]
X-MS-Exchange-CrossTenant-AuthSource: DB8EUR05FT034.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR03MB9228
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

This works without issue, so don't fail.

Signed-off-by: Sean Anderson <sean.anderson@seco.com>
---

 boot/bootm_os.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/boot/bootm_os.c b/boot/bootm_os.c
index 9c035b5be88..30296eb27d7 100644
--- a/boot/bootm_os.c
+++ b/boot/bootm_os.c
@@ -317,13 +317,6 @@ static int do_bootm_vxworks_legacy(int flag, int argc, char *const argv[],
 	if (flag != BOOTM_STATE_OS_GO)
 		return 0;
 
-#if defined(CONFIG_FIT)
-	if (!images->legacy_hdr_valid) {
-		fit_unsupported_reset("VxWorks");
-		return 1;
-	}
-#endif
-
 	do_bootvx_fdt(images);
 
 	return 1;
-- 
2.35.1.1320.gc452695387.dirty

