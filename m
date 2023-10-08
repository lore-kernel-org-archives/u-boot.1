Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 486D3E95A67
	for <u-boot@archiver.kernel.org>; Sun,  8 Oct 2023 12:48:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22BF68692B;
	Sun,  8 Oct 2023 14:47:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="eDEiXxZ4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2040E86A2B; Sun,  8 Oct 2023 14:47:47 +0200 (CEST)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur04on0624.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0e::624])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE38486898
 for <u-boot@lists.denx.de>; Sun,  8 Oct 2023 14:47:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=josua@solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J0nXvg6MczWp/l8I9Zl2ud2Ewt0C4WUZcg+XogulEuZpqKbd8iEzX2UF6AjpfwbcdzVGAkIhT1U7yQb+U28HT22SgzLAvPSTqOuBQthyV1s7/Ww7JM+sIvaSt8SEi50c2PRi4DMqWb2lV1Sx6QCnm4hI1nZBj3rzpntBmbON4VnHKNko25EeKhwIw3t9zNT24crCniIUq0mj6wul5/bg27yF00+NCuEYs0MmikDOiqeA0n1AV5KQ+1xSxQsoczA8WyRc3RSX1WyUu/ORRGCGLQbBQG3sg8qKgOA3N+GGafe4OvpWkkqszt86VnYGnBRZiwaXJQIZbNZ5B4oFQQXF7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F1JjiXROCipypl/0Tw17/vFslpJ2BNPPgl3prb6LaZM=;
 b=I+ZZM5T1hkKyvhLP2zI+WrIY8rviWfujXmbGC4Qeh/BEel1jFrahGXfMZd0NBM+eVhKhcfWs8w78/PfVIj8Sojl9e1QsxEaKvtPqWNCKj2sbnsLD2s2VDL0wgfzBKyCvpvhbgw9P9EvGBF3w8YS/LzwrggRGPLQVoCojzsfxflMD0w6YBOZFHZFplzqv6fqXVRmH4rs0nLuAExRP00XEH4UD85Jvb2iF0OC9+GkRucfUqzY4q5e2uTcW4fVIbuvJulj5a4cyIlmWNRWLnMAFudCxXxOktuxay9Xzt0BLCpQqhZaJW3SlC8TFALFyYSn9/UulXlnNk8sWZeFLFUj2lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F1JjiXROCipypl/0Tw17/vFslpJ2BNPPgl3prb6LaZM=;
 b=eDEiXxZ44PoQe6W3LPfpr85Z1VP19a8eri7rwpJQqE2Sz83MI9utoCJBNjh4Jgpk7yPStTekk+gsSf9DvwdcclYlzWPKvr/1wGPM9wwSv+FyQihea++vlSnocYuCNS8337wZR8FRIR0w0U3QKf8maBMug10DbiSPhq5+UvQdn+I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com (2603:10a6:20b:42e::18)
 by AM9PR04MB7651.eurprd04.prod.outlook.com (2603:10a6:20b:280::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Sun, 8 Oct
 2023 12:47:40 +0000
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::986:55cb:8fd6:87a4]) by AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::986:55cb:8fd6:87a4%5]) with mapi id 15.20.6863.032; Sun, 8 Oct 2023
 12:47:40 +0000
From: Josua Mayer <josua@solid-run.com>
To: u-boot@lists.denx.de
Cc: sr@denx.de, sjg@chromium.org, kabel@kernel.org,
 Josua Mayer <josua@solid-run.com>
Subject: [PATCH 2/3] cmd: mvebu/bubt: move eMMC data-partition uboot from
 LBA-0 to 4096
Date: Sun,  8 Oct 2023 14:46:20 +0200
Message-Id: <20231008124621.18803-3-josua@solid-run.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231008124621.18803-1-josua@solid-run.com>
References: <20231008124621.18803-1-josua@solid-run.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR2P278CA0019.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:46::14) To AS8PR04MB8963.eurprd04.prod.outlook.com
 (2603:10a6:20b:42e::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8963:EE_|AM9PR04MB7651:EE_
X-MS-Office365-Filtering-Correlation-Id: b0932bb2-a789-4550-dd25-08dbc7fcc233
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x+i1jX1Yi+vNOWA/4pdfx3i5sHeepIRjsDQSNtFGM2EIl1jFeewir2zqK86ADG+3zgakj4CoVIPxP6X8jSi/qdx8ivDNAz3qHO9jWsFW5RTl+WDQpWDL2107SlHkKSTWSmVrAiu8bxDndblZaWOZRYi83iPMofQSW9S00XihTHo6S4zELDCn4p6N09iBaz9BJUVNbUsN7QXlh5EL41v4pV0kvrZTNtOgnGt2EkQ+1QjFom+88//bX/bKrWePFRuJedCnHRTtjaXh9yRnj+u173K3qFjW9ehRajDMEn08hfzz6pUxVIWUuU9+EN2LHCez9/ELIgSK+0suNSlfS52MC9oSus24Q7yiGnuf3Vlwfsho+k0JVS0jGEb1wap3AEL1DLiOfaadlae5YyDrq5j6zM1DRQB1DQoKJc9a0Eqf0MSi1SePr13XP8mHPqmAnUgYylU6HaImHKtZ5c8abn0A6LOtQlh+/PRhLJNPmKkoWc2VrUZlFPuxHycya585//AL9uquSCanqHEyT0GTCLv+PjGfZp/IBeBwZ+z+oP8+4gSJ6hAuGSK6UNjJFw118+KrkOMcxhleGerBcnn3YcRHb98DI1e5402VPMzDZOWzkWIhKgjXEwoyuoBse+i4R17h
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8963.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(366004)(136003)(346002)(376002)(39840400004)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(83380400001)(1076003)(107886003)(2616005)(26005)(66946007)(66476007)(66556008)(316002)(6916009)(8936002)(5660300002)(8676002)(4326008)(41300700001)(6506007)(52116002)(6666004)(6512007)(2906002)(6486002)(478600001)(36756003)(38100700002)(38350700002)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?I4u80OseqepALDqAYiXBhlfHSMGTIQ1k8vy/cd62AGOXYKna0+cRkpZDE08a?=
 =?us-ascii?Q?3VA6qc8YQ+ryLnCr9pr8NnuoTGSd/W+6aurOm/QUF8Ndc4LL0PB76YxaBJR9?=
 =?us-ascii?Q?wJ4w6JEJSqtVVowa2wxjGDBSCjkZ2XJP8AWWs112pzPD95qgGUmyQ752w4bW?=
 =?us-ascii?Q?eZp9/ulsfvD0wUVQARpU1jA002Sef1b9sbMUnyOePmnPfmPCVTuRVs3vIhj3?=
 =?us-ascii?Q?8cXAZsTSznwk/2X8acMogEQEeCtAlzu1EFpMXCDxUxBSseCPVsUmnb8Z/qZV?=
 =?us-ascii?Q?gtFdcS75zN//F3c2e6HIZ9+JFuBsSRfq78fq75sJrOjROC06CeFRG87mX7Tf?=
 =?us-ascii?Q?ib13c12DLxKuyTOx9dFzZlKkFFCiv/oUVh1US6aen5ysr69qINBg6uSqohgJ?=
 =?us-ascii?Q?dQ5djtytvYvtE1xfUW+vqLUubpAuk4b0oRAZCJDQ+pFhc//TbgQq/WOoqsSJ?=
 =?us-ascii?Q?rFMshs4BHUOzTKoW/jUQ/RkO7zjrDB/odoENCeL57/vGE3rikmv5KTKDm9Qo?=
 =?us-ascii?Q?YtuFoWd8vhHr7LGGpyJ5rx3tH1XvH1XjyH2OPqTYsHTBLf7goDuque68LtE7?=
 =?us-ascii?Q?bsQ/PnmgAOwSGmm9Gf3sN3ZnlYwwzBW1Twuv7TgbsTZ5WoBL2l2OfN4PCsWD?=
 =?us-ascii?Q?qEMpkA1YqRxt31mtxQirzlVi9b+/bkuiqDZoAWj5Zi90RpEY0EceI5acilti?=
 =?us-ascii?Q?p46hHW+DbxZ4Eke297obfK8sZ/8PvlMb/r9MuNcQFt7HWsKKGCnZFBK1kFND?=
 =?us-ascii?Q?H7DuEyr7vM7RHRwnszW29Q4ii2DiCT0ySY+EbFNIjVTh98auqM3joivBE72d?=
 =?us-ascii?Q?ay4YaIMQnkf+EsaRsNazC+nsPsOfqGLDDr8StHdQgDkl1YOtQe65OG6nafpY?=
 =?us-ascii?Q?MumKc4cej/DfTCAsjSmCfu8VIwe7iCpTOY15AgjVjCRC2JDNtLtTYTRsTSk2?=
 =?us-ascii?Q?Z/KNGL6TxfuGl04woXq2OpuqxK0k8URnOcvDUoInjr7BkltYuxYDEZS+JZC7?=
 =?us-ascii?Q?R41wemoAyrGMEal5cBLFv+uHAI0KcxzK7o3wqeQPYXnuZoydxALoySqhpdvO?=
 =?us-ascii?Q?PZ4ot4bktFBeFR9eiiRN5p5heFt/WBoUpFl7/cptst1aHJJ0SS9au5s0DR7y?=
 =?us-ascii?Q?x501M4Aq8Sh8jEa9J9D77NaAuIbCqvcMc/mMZBtUPxmWaJGRdrrVFXiElTdS?=
 =?us-ascii?Q?O9v7kZhZCEu9g9y6oxVy7QL+EgXqukJHSSWNEiJMMNIx5TJSn4VcnOIotLQf?=
 =?us-ascii?Q?GB9K6IZldTkkMRHr3tiZKI/EBNH7iMreQCHh6bBflOzlf1uTdKCp9E0ge/mW?=
 =?us-ascii?Q?x1m6U/iVaUh636+0ShtNCGiNjDBUDCnBKResxQ/nOSehNVIR0RvVoWGLUMUx?=
 =?us-ascii?Q?LwBmC7KwHhLiMpBprXdAfpPLJGkgslpSLk7N76CcdiVpibCSxLygstIl6j8o?=
 =?us-ascii?Q?Kcn1k9P0yyArLFAkMepBLx/M+MvcqkNaAIJEMd8MdmSY1S37oD95c8YFIajr?=
 =?us-ascii?Q?ekO0itGh2dpWf7G41GhMJ5ZkF6tE2vQqUsLXo1sgE9zz1QdaLBnjfu/RyfTU?=
 =?us-ascii?Q?bBLVs7x4Ru1nj95xlLUmUJSMzux/wHRFO7IYyF25?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0932bb2-a789-4550-dd25-08dbc7fcc233
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8963.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2023 12:47:40.8572 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iFwilGwVABKE4mGadUWXNMwHNIaUlqNXQq/6QkNBUnqCHrnXbmPwxa4utKs4zCn5hOLRhdrNtes9ZUrb2NZpeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7651
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

A38x bootrom only searches 2 sectors when booting from eMMC,
irregardless of data or boot partition: 0 & 4096.

For eMMC boot partitions sector 0 is fine, but on data partition it
conflicts with MBR.

Change bubt command default to 4096 for eMMC data partition only, to
allow using an MBR partition table on the eMMC data partition while also
booting from it.

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 cmd/mvebu/bubt.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/cmd/mvebu/bubt.c b/cmd/mvebu/bubt.c
index ca24a5c1c4b..eb1fef9243d 100644
--- a/cmd/mvebu/bubt.c
+++ b/cmd/mvebu/bubt.c
@@ -240,9 +240,14 @@ static int mmc_burn_image(size_t image_size)
 #endif
 
 	/* SD reserves LBA-0 for MBR and boots from LBA-1,
-	 * MMC/eMMC boots from LBA-0
+	 * MMC/eMMC boots from LBA-0 and LBA-4096
 	 */
-	start_lba = IS_SD(mmc) ? 1 : 0;
+	if (IS_SD(mmc))
+		start_lba = 1;
+	else if (!part)
+		start_lba = 4096;
+	else
+		start_lba = 0;
 #ifdef CONFIG_BLK
 	blk_count = image_size / mmc->write_bl_len;
 	if (image_size % mmc->write_bl_len)
-- 
2.35.3

