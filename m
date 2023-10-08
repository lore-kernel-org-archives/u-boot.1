Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB103E95A82
	for <u-boot@archiver.kernel.org>; Sun,  8 Oct 2023 14:59:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B79CB86AB9;
	Sun,  8 Oct 2023 16:59:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="KwUES/mq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9231386524; Sun,  8 Oct 2023 16:59:30 +0200 (CEST)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on2062b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe16::62b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 586C686961
 for <u-boot@lists.denx.de>; Sun,  8 Oct 2023 16:59:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=solid-run.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=josua@solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A7sPFbhwIykt6gOvcLt/DTnC4229x+7q+Ex8Evr6CvejudKUs88u0s9qDaPrTBdj6srdPvo6owFbQ4/xs5gfbtjevNsSVAn1Fv7SILlYsXtWdTpW+hJ6jhhgTB0l3dBGEWjmoGkArlZICscYkhx42Ota3wAInSeMdKpTcHdh2baVj4DAgCsi4VBZ7ISSENvLq5/1KUfyPuDg4y27LMmbNRUkLKbI4NB1a935PpxyumAsUEQYk/i662yHIg1VGLmXzY5EWzgsv6x26IuNF45ihzosgeuOWdyHlkWUZDcLKC+YojHET4606hhvx+Uc1tdFrIkteIFslp1WF7gEejDipQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pN8SkB1nXbKKlOybA38bXKMxo4d/Mw7p7bqGLvds/d4=;
 b=oM1JvAoNAsgVYGkzSVzCHqOu2xNTjfnpoeYBWv3aC4CByBcYHbV6GCEm4TkwOiD4AbKVq+caIJ6XorFBvWsTmRQfmawFIJ92n+uDovXGTiVP3sYOx8sUWLN8oj1kw+36csJvLqFKmEmtYnKohpGbA4jIBRYBaCyLAnx1KqjPWm6AUdZc8oWyo3bMfjza81wqQLlCLMie+wNWaXzboEDHVDvjlLj70cYJYr5vO6jnS3JR1MJR4peRsEoCRTieAEVlzwMHxi2o7uS/vO1Xs6mWdD4Ep1GjCLspiYLwLPvgkwimwCeYvcKBqtDCvcSv/43HSfChm85uq8kbZ0BSAvexcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pN8SkB1nXbKKlOybA38bXKMxo4d/Mw7p7bqGLvds/d4=;
 b=KwUES/mqtsV21lJ13RxFELttY5P8ZGSUXsdHP3F1ogGlpw1iFZWZS4fUpgwfxjzV+aSy2Wm8L8mn2QnN7n2cDk07jvgjUTZbgyp3WLaIieLdK20ekS4wBG4wjnSXYx+oXXULPVa58UKlt+4xys/TA9KIAN9Ju5TNBxJQeXUwlgQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com (2603:10a6:20b:42e::18)
 by AS8PR04MB7525.eurprd04.prod.outlook.com (2603:10a6:20b:29b::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Sun, 8 Oct
 2023 14:59:22 +0000
Received: from AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::986:55cb:8fd6:87a4]) by AS8PR04MB8963.eurprd04.prod.outlook.com
 ([fe80::986:55cb:8fd6:87a4%5]) with mapi id 15.20.6863.032; Sun, 8 Oct 2023
 14:59:22 +0000
From: Josua Mayer <josua@solid-run.com>
To: u-boot@lists.denx.de
Cc: sr@denx.de,
	Josua Mayer <josua@solid-run.com>
Subject: [PATCH 2/2] arm: mvebu: clearfog: support 512MB memory size from tlv
 eeprom
Date: Sun,  8 Oct 2023 16:58:04 +0200
Message-Id: <20231008145804.25567-3-josua@solid-run.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231008145804.25567-1-josua@solid-run.com>
References: <20231008145804.25567-1-josua@solid-run.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MR1P264CA0012.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:2e::17) To AS8PR04MB8963.eurprd04.prod.outlook.com
 (2603:10a6:20b:42e::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8963:EE_|AS8PR04MB7525:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b36794e-bee5-407b-44cf-08dbc80f2802
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gga1xjiMPKNB28i45wDWGnuEtQRQv9hxjqLaiqNkSq5ygJhDUTdDoP+hJ9lJ4Q6A/qvuGP/lbC/OFwhHOQHDCPrEriWbeR+8hnpsWqHoU4GnZhR4AX2CoYGKevTPZtCRJxcRvyXBtYrhXgcY+9Pp8Hie0+2siSXLTQrD3UBbzSKsoUdWJ4G2Y7Xt4T9WWcp5cZ+mti9mlu0rDwRK5u02e2IQimUSMHGoUpxQx97/oXGPPKOPdQssrJWZm9A02p9ozwPQoaRRmaYeE5jrEOo5Xo712MAyPnIXZkPfjQYlzIVyV8+zvj+A5dJmLXznVPbG2KJ3GxF1kjYrFgVpztP84KC9fc5KQgpq/CAvW+5dvoxA6bwfvZTbt7QjJOCjukMP92vZAvbOOn+3KvpNnQGE7A0NtG63YCVIzdFIyo/vsoNButOPtMiOwdOeEUtvEw7R95OEk9xbtZVQHCn7fZ/0d9RWwBSqRslBiBe/lh/B5k7ywZXEfao8cYF27c4pDQ2QIsj0fPaVsQvOHUas4PPO5H+uYNQafjUGsn9bjiKTMMddsGntpDnBXxIxh8JwV/TGHH95NIynda5G0hRFu/HmRBKXlBl2KmYBl4E4On33mtxCVIkMcz83yCt8V78yhUfp
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8963.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39840400004)(136003)(376002)(396003)(346002)(366004)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(107886003)(1076003)(2616005)(26005)(66476007)(66556008)(66946007)(316002)(6916009)(8936002)(8676002)(4326008)(5660300002)(41300700001)(6506007)(52116002)(6666004)(6512007)(2906002)(4744005)(6486002)(478600001)(36756003)(38100700002)(38350700002)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LmSfhV5QzYbRIcKx+GzqOhW1oNl2dDCarsCGaCg0iih1SqhM2XtDNxWxs7pd?=
 =?us-ascii?Q?jMz/I0CdbH3iGooDxJPYDu6dkV1zY+VXTNBaib5levM4fvNyOL0ug4osHraE?=
 =?us-ascii?Q?MMxF7LgBjRDcDNaB5eXfx5nbaocnRSso6pHYMZGeSLRn8lAqXXxLzPZsztZv?=
 =?us-ascii?Q?92doJLa/qDfZ9Uss/mAUS6iFw+pgBB+luvJUpGogz93rHbXh6RXxOTyMgp8s?=
 =?us-ascii?Q?adq8dKmI/hu09zmweDH8bNKHQBcf5/5XiRYdYKMY/Gt3hePIQH69W4B5ozhf?=
 =?us-ascii?Q?EQq0ld4of8KPRNoRWDdoFv6oNaltaNMkL1bNDivS3MhPxnBIwv7QJ21LqYrg?=
 =?us-ascii?Q?HsID2VYp1HK1TrKThHmo94hYBoENm4bcKTiIodgFKex+GK9unj8cinrngUhA?=
 =?us-ascii?Q?CxoxScQ/tLjDWIkV1pAmuqDwWdsoSyOq1/aOVYB/fQcib1np0Q1Mccf9RXN2?=
 =?us-ascii?Q?HoQK/3aSMfobzL1f6ONtpFHYwImC7TZE3xEPZHaZfff9ZyGEGYjjnA2aJAdJ?=
 =?us-ascii?Q?FgEitfBn94Au76j4r4g6yGwGSqfmX9X3CcM9LcmbCSMfPOOXD66IkcD8wgUD?=
 =?us-ascii?Q?/QOZdkQ0MG7jaPD63QmcgOI3qC8DleQAU8YgOsW6G3PJAG1k0sR9OXLbIL0z?=
 =?us-ascii?Q?BA1eSH8t4yUG1lXbJD7Phr4g76YHYXtUIqdrT6uI+hr/Eh/3/IaG1jQOQJYk?=
 =?us-ascii?Q?wUc04lNgHqWQhV0J3WF1gr1UxG/fHil2oDm+kMzj1bIegqjKewB8Jsx4kj1W?=
 =?us-ascii?Q?BjuA0NKGERxA9lqSkvX0n5bmk7qJDrMWQ46vuoYHZ2U8JtQi695sIZ8A0hLr?=
 =?us-ascii?Q?VJSTZ0ZB19UyBqrvPqGuv9sTLNkz109hP07OKAqsi6gxmpYp9y+/8JGLQaet?=
 =?us-ascii?Q?RlDZh1CsnRBs+OSrqUix10QdL0sKUmglEdkODpTDIvwh86BXWXITx5A2A71U?=
 =?us-ascii?Q?mQpAtl1qdBRZQBfDQ+eyX0RUkjs56hSj3TQFk6vZ9wC0O0GgDFTgSUCefZJQ?=
 =?us-ascii?Q?SzGgSw3h843nk2wWt+JhOxp1ec/uG3bHFOReXTBpGddr/NVUkDKEnOWSYSEb?=
 =?us-ascii?Q?jdNqpffX8i7GKAogfQmCC/l10hrzhLoIqNKTYSWF4jq7QWW9tsUdGcgkbN1j?=
 =?us-ascii?Q?a+Esq6g74Auf2h+r5o/wRdmzyoNRgMHzFbAxSx6otzL9mXhj9tZoqvv9kxAP?=
 =?us-ascii?Q?MKErsPNcHBEcZ03gxAizsaeIrwQ/yfH/6RFPkZfRwUxTA7VaF6La08W0fc+6?=
 =?us-ascii?Q?e1c3zHSN5pFLUjmM99OWTvZ8EFTp/BItP+An1ydjDD6zzmIq0ZtrmUZj2Hvr?=
 =?us-ascii?Q?8/+QDoRuw6KTP3tdkiMEdTRbMgmX99fAybGe3NqR0ka8lK8ScEw5guzhfOtG?=
 =?us-ascii?Q?pcx46i9HL8/5u+8SPWXZpTbxnTHUY1Le8QeAoh7sdVE0AnfrtI5krHgQaFq1?=
 =?us-ascii?Q?XNCNm6sWCGUmQBkKkTm6rhLnEKQ+4ewHdTselik4emjEPO71HdRbDnRJA2k/?=
 =?us-ascii?Q?wQJKUqAKkiaQdLD4zd5hHmFb0qr0DxcMtefhgm+oZYoakFrEFJWHI3lq6pOj?=
 =?us-ascii?Q?EHdEMlt/+Upn7OH/wy8yc1IKAvGkJPHk/qQUddZQ?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b36794e-bee5-407b-44cf-08dbc80f2802
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8963.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2023 14:59:22.6025 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zSd0jAHYQXQ4v0hGDRjtil30rzFKuppWeG0ViXyOLaSsTEyAwI/d00MXVmP4Q0o1gwlewwEN1gz3RCTJGHX4Uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7525
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

Handle 2GBit memory size value "2" from tlv eeprom on ddr
initialisation, to support SoMs with 512MB ddr memory.

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 board/solidrun/clearfog/clearfog.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/board/solidrun/clearfog/clearfog.c b/board/solidrun/clearfog/clearfog.c
index 4f4532b537e..6fa2fe5fe3e 100644
--- a/board/solidrun/clearfog/clearfog.c
+++ b/board/solidrun/clearfog/clearfog.c
@@ -159,6 +159,9 @@ struct mv_ddr_topology_map *mv_ddr_topology_map_get(void)
 	cf_read_tlv_data();
 
 	switch (cf_tlv_data.ram_size) {
+	case 2:
+		ifp->memory_size = MV_DDR_DIE_CAP_2GBIT;
+		break;
 	case 4:
 	default:
 		ifp->memory_size = MV_DDR_DIE_CAP_4GBIT;
-- 
2.35.3

