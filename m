Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 725B0CAC59F
	for <u-boot@archiver.kernel.org>; Thu, 18 Sep 2025 09:06:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9031480B9B;
	Thu, 18 Sep 2025 11:06:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Bn57avrB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE0F382F14; Thu, 18 Sep 2025 11:06:46 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C22EE80107
 for <u-boot@lists.denx.de>; Thu, 18 Sep 2025 11:06:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wtMBzw1XUb4FL4008yIZ7TxsRSyzFdA91Z1Ki5Bc7eVJvPxBIpD2um/zcbYZZkrNz7JIIMGb+fievSSCz9hit/fxSA1ebT0zLWblx7qbCqpbLrYDBWUpL73ojZ5xUO29XxcsfP+7H55GwYSa0N/98olalE5P1QQWmyqpzGSNclx649lGbANTu94RmS9g/dDZgPUCxR149lLR6wuJqKclGIsQqTsRdFIcj369r+n4AcbQkku1QvL7Y6nVdi/gEpdb1xLVvUTwRlgGjW7LWppgst4mEITFFljOOM+pPk8NXVfWy67/oG3SQh5ulUSm2BqNWx1R1cgi8PTf6X9Mm3tEdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RljUFgpHIgxKpajnYtiEcEjlgjlsWHdx8zqSKBtzhzo=;
 b=a3qphuarcUfjJv0t1+khafM6Ml5h0Hv+og1BcmK04GTqvtqtKoUw0jMOUaceWe14zaDOj2LbTditTZX8c1S3Nhsh35vect1zkXcGDW9C/aWcDpf4ri7AfYr4YYhLD8FsIbGVM3rMLJFSikjPTQJtMIi4xwFQiN/94H19vigLIXnYeDhfCz+4ta6kEO8RtRapwa7UKI+O1okzBbKaztSUsYZB5DJMeMkkX7JbFD5oz6OnEfGcZbmEx/gNDDMGUqzmd8MdJ70M5uxOu5Ri9s4k0OnnJxV0Z9vxN4IGYpBXsHb4E8JCrrciCrn9P0wg1fz0wUduoB+dJveNfLPdH7e5pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RljUFgpHIgxKpajnYtiEcEjlgjlsWHdx8zqSKBtzhzo=;
 b=Bn57avrBpTMI5huq28CwfxJSHutkeK+pEwrNnU29LDBGcCFcaRjYRSjcGTwloG5xIJoUHFnE1tcxQTgKlkO7nTQfehGlHB6QPk/5B7zsvLSOfIFdM+cZYhWfRTX3ZdtrnD0pDjfduxTzoIJoGOzz2VZU1JKnf7esnwmJ+xtjB1SDeajkq82fr6eER0/wxkGacIwcJlXQ6xqr4UqUhfCi8U8AY3xrA40+dU2upB8hSvcN9zCkCiJSfJ/rMTZWUni7sBysjBWGCHl3ri10NEubNXZtTZnrlRjVL9XGK+xKeuaVi98kVRM0qA+FNFpW5Ely1QnT3dUVrpUCBDnn6Ptjaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by PAXPR04MB8128.eurprd04.prod.outlook.com (2603:10a6:102:1c8::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Thu, 18 Sep
 2025 09:06:41 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 09:06:41 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: lukma@denx.de, marex@denx.de, trini@konsulko.com, festevam@gmail.com,
 alice.guo@nxp.com
Cc: u-boot@lists.denx.de, ye.li@nxp.com, peng.fan@nxp.com, ping.bai@nxp.com
Subject: [PATCH v1] usb: f_sdp: Update SDP driver to support PQC container
Date: Tue,  9 Sep 2025 04:00:55 +0800
Message-ID: <20250908200055.3645976-1-alice.guo@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0090.apcprd02.prod.outlook.com
 (2603:1096:4:90::30) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|PAXPR04MB8128:EE_
X-MS-Office365-Filtering-Correlation-Id: 85243b69-2c33-4e7c-66b4-08ddf692aebc
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|52116014|376014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0cMj6xDUUYq/b7KWYy3eQFNKjgjs+vtnSw2a1UwksV3FsVmmVh9B0YGMxYDQ?=
 =?us-ascii?Q?OCKmRU01UP3lXHaJX2BRU2ldgToNXHbSfc6NPnu8UNO8wedV5y8b1AyMQQFv?=
 =?us-ascii?Q?i38J9SyvK7edsUGSsOuG1PG0FF5eeapDo0ZwL6OR8wjaw23ZXlkaW/K53jKm?=
 =?us-ascii?Q?oeupsSOgeXQs4cd6LKcbtx5AeUSMmTDAoSguMd+xg3R8kEuhD2wwrQlfCC6o?=
 =?us-ascii?Q?38Guv7dKq8np6gPlIfYlj/pJvEQJqb5rh/bfVH9IOo/hsaHRMs+J75g9p3Y2?=
 =?us-ascii?Q?0VZTFOUU7WxKJqKy9JQOfyKGXRbflyF6tPVTsjMKC2eiB1mtXGkp20v8pQaj?=
 =?us-ascii?Q?zBBhzhYbQLjKdwtazy6opQ7dmrIi+FMiKUE5q9fnQn2pAFGx6gPSXbCEG/j8?=
 =?us-ascii?Q?/+26jp5D8nQ7KAY+9WL5ELuXKayP5xaLi4ne04di+V1bJ+cPQjwVAtFh0PR6?=
 =?us-ascii?Q?a2wpoOzR4XC9OiU1ks8swRDOswKGonoP+Ikwy8MXfBKrOrJPoh2/PuHK1IcB?=
 =?us-ascii?Q?xSLVRNmeEW+l6pJUlBeE+EZH2GiG06RT92l4wMSkTzEZon6AoCnfPx6IPOxF?=
 =?us-ascii?Q?cNhwcQqt3pLCRWKxIVQWN53ZwsYR2tjxiq2mFD/Rm7bl/7TSGtsb5jT5hNTW?=
 =?us-ascii?Q?iKJTP//zfHo3HzsC3vYP8en1RoHqFnMMr/i44Qy1ysw+TmCTDuMovboYsP9t?=
 =?us-ascii?Q?6es4DP+HomLZydeZKux+HWLvM3wY2fc7Ed1wWhgKuYDkXEWY7A6aUqHqixL9?=
 =?us-ascii?Q?nn95V3EQc/+SFRao3shNWwJpIEvlf4NO1NYspPaNosJ5PKt53wKG9ThWy/KM?=
 =?us-ascii?Q?sxDaVHyCwPEWeICMYdVlzo1DDxf1BLzbvGGyiloGuIo25Gak2JCtCoHvwkSb?=
 =?us-ascii?Q?QSluqPCxdWaA9nKg7flM/wNnSlAgPanGgTAbCIkXScwWMm7uy2zjIpbfDiY3?=
 =?us-ascii?Q?ZHQuSvdkaGTdn0OXUkXUOXeuLS0k7GgeshVZL6uxLgjQzm1rOXldZKxtg3XU?=
 =?us-ascii?Q?zgQE1wJ3RGdv9p57TSYwDanxPOpSxTj7FKUGIRxzvcHFi5FvhSMvb2jzBdiP?=
 =?us-ascii?Q?pl7n43lTSx1m9f6c7G2ub29Cb+UB1X4W4g6W/8kO9QsKLVJQ94D4sSDPx9Gy?=
 =?us-ascii?Q?rE/pECQ6xQ0arn9KrturRAefN/FugPlkaWYMW4t5WEWFUeqt/ZJkiUqWOjfD?=
 =?us-ascii?Q?F+beIrT5m45xCpLwxg48Llpjs4lgfe6yr0qOgG7v2mSyDzkf2LOu1Id3LcQd?=
 =?us-ascii?Q?no1pELhBIK6D12ua5ClMv4YeTSgUjo3QM/2GiYna8SaZe2dlWrjSzCT2qW31?=
 =?us-ascii?Q?dBBWXGn7DAAOBVYGStXrEt7iEihQFun1EEYdEI9MO7q8vTZIUeHFOhUSqnIY?=
 =?us-ascii?Q?/Z/w8FkfLfe7oaPeZq+QHZmFS8JvaVBFOG6aNWu4DJ9ck/+8FVxVGIUNg0N+?=
 =?us-ascii?Q?FyXIwS31pVxf+dwI46ISxaz/dkCLTQHhS3OOmUmMejWW2/kSkY4mhQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(52116014)(376014)(366016)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kH5zjqXuIn6S2K5uluJxVHxy92Oj1bLP/p4UJ7Nm598zapXSpEEw+AkQJHX3?=
 =?us-ascii?Q?vvW/7W0IZhLNpSu164WIyWgceLMoM4OahLM5eMo5aRUuudwEWQUciYc3Juja?=
 =?us-ascii?Q?wENm9Az7NAqUPJn+fxNoV7YSeblaca97qjrcmePk6Y32EzR3VM/HSefYp0yb?=
 =?us-ascii?Q?a99Jvcak7vdhqzyoiSjcAuVCLdRPMKMygEnkpqqzSsiKYPDvnaX6Y4GxNsO6?=
 =?us-ascii?Q?nzx7669dCUeAowphT0I9D7192US5vYE5fEh7A+wKxrHK/cTq5GZmqu3WR61i?=
 =?us-ascii?Q?5k4uDnJcAjoE4kVxf24f5UoF4QkXZUp7GGLQuJJd4NgbgffC7ne+gXVzH4sG?=
 =?us-ascii?Q?tRUMG7SX0E6LqxyLCs3UNH84/YLhDamaLcOrOUrJ7gLP3Vks0qZsvzKz715P?=
 =?us-ascii?Q?bXkosy4mmtAtcsoTHL4uju54glwXRzHDZh9NXivtpFNAPoi70jmZfQsDeRQf?=
 =?us-ascii?Q?DjeofJNFUn2f9+XmDl6DXkC5v0CqNwDrpu1fb31A/aVv6FmTZ088zFV9LTq5?=
 =?us-ascii?Q?DQcEVLZosL4yl2pX3QHvvCgYycpY/h6yZAhKr+JN2Ran+WW98FKVyAZabiJM?=
 =?us-ascii?Q?pRnvQC9eSYk0tmRapqvGXKotRVGleCHr7sV6c/HoKNo3WWWvE3j2rMbpJUzz?=
 =?us-ascii?Q?/KelYTmfAR8kaqcMUaWirT5gMdwsWfsQNWu5WrPoci90NxlbX0dLC4xRXm0j?=
 =?us-ascii?Q?bbOfOxT/HUSGj+7xax/9km3f6Am8mso/ynbN0pyV8exZNcGE44q3e6CYmZfj?=
 =?us-ascii?Q?85RZfAUU/h4luJb943KV6uYG6wAD1vNCzzKKD63d+lOTR0cDP3h3r5pvVNQV?=
 =?us-ascii?Q?s2TISmRlcpiNYVV3f3NwW9PoIN5nVll7DZVowO2BpdFP++69G3UAiZHwyBBW?=
 =?us-ascii?Q?QdafF5jtMbIx/9a6grPsW8/rrtVIz5CEfosEm8t9XEgLS4WA7I+Mz5UId5yi?=
 =?us-ascii?Q?ph7aS/f/5JF4v10j0HMHZVEDg4srYcf3YDzC2SoS1l3HNcrSaBF4W9ZQu4PB?=
 =?us-ascii?Q?ZYEhw6Atal25hgaLnQ+NGjXnO+oeT+TFI8FyQSW11+PzM4hTfBoVO/OJlVxO?=
 =?us-ascii?Q?p3iCHnqt4yNQLEvU8hVDNZ5z2b0aZq5mgDqH488ziQCB73i+YpbB0PnaDHiV?=
 =?us-ascii?Q?hq8RqHYsERMlE0F4xQugLgrErFImXE1yGh7FLh9wg2ZtaO8mhuE8svJ5WHr+?=
 =?us-ascii?Q?bke9zbpC9BC8Sx24QVvVBUp/OrS38yt5PfyOrmlrCYjuCMTgYMPAKTuRi5D4?=
 =?us-ascii?Q?CGTtwT+z6s2vfIQ8CcaQ9v4Nol+pPxLKlNSz/Ns1OG0FRMiuZNKn+PznY0bN?=
 =?us-ascii?Q?aUaKmIEju3KsUPlaG0MiJdwYbJUozCj+IdgaRB6m7oMW0u9ENmDlrjD3ZqhC?=
 =?us-ascii?Q?G3i779AZ9m07qOvySm0yoBHGBcXnHbDB7LqnXSN02OCdEZEVlDut1BPEKR32?=
 =?us-ascii?Q?ZQumVIfoKQkNlxVozFyN5YUNmW6/NIYt1ZL0anNUcZVNFGgHxpTxWnoihnvs?=
 =?us-ascii?Q?2P5FJhRHQNHrtRxiakORnYA0rtQosrwW/i/lfL8V0bOYJW8znLNI6Hcok8eE?=
 =?us-ascii?Q?ivKJCOP5h1aLhw50NL0boe4pXpmxoF+Oj7SKROcN?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85243b69-2c33-4e7c-66b4-08ddf692aebc
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 09:06:41.7875 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qXuitXouOlyy/z+E0pf6h7gdxMCKWsaD4OarEXVkgwTH8727iMNgpZH+Sw6I4ULoeHtpG5NE+88FIDKVs9gBSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8128
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

From: Ye Li <ye.li@nxp.com>

Since PQC container has changed version to 0x2 in container header,
update the header's check.

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Acked-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Jacky Bai <ping.bai@nxp.com>
---
 drivers/usb/gadget/f_sdp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/f_sdp.c b/drivers/usb/gadget/f_sdp.c
index 647001d8dd0..f72e27028b7 100644
--- a/drivers/usb/gadget/f_sdp.c
+++ b/drivers/usb/gadget/f_sdp.c
@@ -765,7 +765,7 @@ static ulong search_container_header(ulong p, int size)
 
 	for (i = 0; i < size; i += 4) {
 		hdr = (u8 *)(p + i);
-		if (*(hdr + 3) == 0x87 && *hdr == 0)
+		if (*(hdr + 3) == 0x87 && (*hdr == 0 || *hdr == 2))
 			if (*(hdr + 1) != 0 || *(hdr + 2) != 0)
 				return p + i;
 	}
-- 
2.43.0

