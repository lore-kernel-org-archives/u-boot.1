Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71386C43458
	for <u-boot@archiver.kernel.org>; Mon, 13 Jul 2026 13:34:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07E1B84BEF;
	Mon, 13 Jul 2026 15:34:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="fws5MJL7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC3BA84C0C; Mon, 13 Jul 2026 15:34:47 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EA89284B93
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 15:34:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fopphZfItOucEcrGLur1SFSIcznWwT7wDZ0JYjZSQojdBTRsVvIyzOIm9pwGBBRQhdvnNiDO1NhDAoRPIYgRGrn5IA8EGXaufDJPpINhIu9xItmH5MiGIAeljNUuYEzweFYZyWrKzMDm1D1wr7A6ZB+o5zzacU4TVK3ouU5R0JR9LxMdPVlk3KM6vAWLV+f6g7e8AWjK/uSB7vyqEBilLFTDpGjgbTE840sXGMXHjoHWvXurcMv8A1k9Bs0SQj0mR1sVjLqJJOWAGRZvVg8vUwRvsh+wDBJoz6a1uw0jKFoOqaLHMyg9N9jt7P059Wb3hxxRvqnOTz8R3gyD/vVQ1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wi/WfUUPUtzpwbMuymT8EcllOqwk8iRk8wDSMAyBhdM=;
 b=BwGZ/qYkqdZhpI6uSLXP6mdnhaR6tUgSpGhc92JzEGt3Uob72vJxGd4k+ov5gSZO+DlNPA0r5Yv6oPjh8rvZBxRdCDU6Lr8X1aUx/uNVZc3/4/Ifi65TxZXF82qj2XGB7kgxabkG1N70rh/8n5N/EcprvLopFeeIgbLsRLlPuYH+N6RYq9wjaR7AUHx8j3k6uq25azoblqLJfEnwzVISSW4Kp3R1VgqSg7yjdrdJFvOeWsJwWHtlA3gOcBHwRfPvQF6eEpTVQ+duOOi31wKyt1Ua1KoVz8nmN60yXZj/MziVYuwl4Xl5h+EaVEHH3dq7Y5pPgu5+jnYr27O6eaGiXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wi/WfUUPUtzpwbMuymT8EcllOqwk8iRk8wDSMAyBhdM=;
 b=fws5MJL78Hb/GBnl2zxTu/XuCO+W4JGQExCJhXLchXckfcSvmzHiKqLgF3pqk1Yi2zYJUTZVfsakUJ8U4vvGWq6iZn0FrJWKbIRZ4biBxpjH2SX1WhR8r6IUKAcighvk24z1kcTjfHoHS6RdZOvDzXqN4Bk18jtRs0x8Q+gdut6Mw3PA0N75TcFgiVr7mvs1ODhpyogZ7WuMHevk7QKsQQyZacGc4daul9BCjSRDOugna6RuXDGbGMkKsjEWCT2DSfQa1pp7DcBS+lWxoR1QdTLDThv6p87pxZr++t9fPxF2dJwSpbSpd//xRzTQAM7M36qtn2mIrD8/rOjZi6zuzA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by AS8PR04MB9011.eurprd04.prod.outlook.com (2603:10a6:20b:42f::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 13:34:44 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%3]) with mapi id 15.21.0202.018; Mon, 13 Jul 2026
 13:34:44 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Mon, 13 Jul 2026 21:32:53 +0800
Subject: [PATCH v2 2/5] mmc: rpmb: fix tautological condition in
 RPMB_REQ_READ_DATA validation
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-mmc-fix-v2-2-b0ba3b4a8d97@nxp.com>
References: <20260713-mmc-fix-v2-0-b0ba3b4a8d97@nxp.com>
In-Reply-To: <20260713-mmc-fix-v2-0-b0ba3b4a8d97@nxp.com>
To: u-boot@lists.denx.de
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>, 
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>, 
 Jens Wiklander <jenswi@kernel.org>, 
 Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>, 
 Yanir Levin <yanir.levin@tandemg.com>, 
 Eran Moshe <emoshe@gsitechnology.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>, 
 Christoph Stoidner <c.stoidner@phytec.de>, 
 Tanmay Kathpalia <tanmay.kathpalia@gmail.com>, 
 Jimmy Durand Wesolowski <jimmy.wesolowski@mobileye.com>, 
 Iulian Banaga <iulianeugen.banaga@mobileye.com>, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: SI2PR01CA0038.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::20) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|AS8PR04MB9011:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e828edf-1e50-4c31-9c46-08dee0e37fd4
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|366016|1800799024|19092799006|23010399003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: nIY2043KkuRd6yc7zxzGXtrEQNRWXB/9oJFOGcTLor1+eC1qyULe4SFmv4PWTmEikkPfPtjcwfyxtzRNTHvVMGfuGmyPdZZ+3AFYeCFJWkIrT+tGb2iMYyQ4AB2JRhorryEmdFVqtynztURO0sPQDGnDuDugzCOV6QvCoicjq64VM33fI/J/jX9EwCR+XhHsaTH8IxsGvMjsx2IPD9L7gtlKhSeA6MpU/Q+UCnzDuMlTBwEuVU33UXBoRRkSSL4jMcPth0ow7VH+fC2hYWWUdlH9qI+OZh/wq6UmlVLQtsV9BSzHSWVHduRsNtuBC0/WcGhECtSD1iwKQYudgYwKj8xlPKJQqww+vVbC5/LZSuVCk8do3vZ50DxxxUvSj8nzIIGssGzQB4KhZIBnPG9hj4c6Pmzvw0Z10T6DvD9CehNgx1AlXOva3o4lHKefBzL0HHYF7Hkr/7d5RaKuZ0IdLGstSyhZRmaf3O4R3j3qV4Wb7XC9I+DEUy9BcGn6e7yjssELKQnK0ZReTI2EV9tS2/eOoDo7QxRAt/y3rVwKOlxulpRyCWWdaI662giTejDr8vwGbf2rgPMjkdRCouu9na23ft2e32LBzEudiSu7/0jR5sBTBfDsuBubIQ42zRAP3G/2o2yYV4alDOdLIr/Y/JDA25kZ7sR4st8zNAtChpM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(366016)(1800799024)(19092799006)(23010399003)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WVl0STNVVUs4QnBQVGEzZHViVGRXbzFOQ1VKclhkc2FtRFpVM2swdnF0ZVRz?=
 =?utf-8?B?T0o0WCtTMkxEbWgzcTU1WStmQU1lQXJMaUtTQUx6aEVMbzZzZ3g1eGl5SUVn?=
 =?utf-8?B?SnZqQUF5SEhOUmVQOHpMNkk0ek4wSlhGSytGQVdxNnFxY3V5Q3pXbXBKeC92?=
 =?utf-8?B?SnVrV2t3bzdSYSs3ZkVLaDdHS0czRTY5MWVCSGN2bFZUTlNteExXc2FYWWVl?=
 =?utf-8?B?c3FSdTNhRll1S0pTWGFxUUtmaHlIUmFMTENtcHZ3T0g5alJVcU1xeWFWNHlp?=
 =?utf-8?B?Vk11UnJZaWxPUFg0QnZOcG84UUEvZEE4KzF0WEtibVFJYjgweTZFSGlRNEdN?=
 =?utf-8?B?dlB6YWhMM2E1MmdNRFVZL29zYmEyYnllNzdqRWNnUStJMlJmcWFCaHc0NmNu?=
 =?utf-8?B?b3hhTUtUYW5uVFY5MElyNmRYRmVtZHpKQ1EvZnhid2x3SFB6R09NbE5MNWFm?=
 =?utf-8?B?VjZOWGxNUnRadEplNlcxZ00xNkpwSTdtRGZLVDNJblJDUnBtRHpzVHBSYWJW?=
 =?utf-8?B?eEFXOW92OXBJWS9ST2U2YzFFYjFidHdVV0pjQjhDSG9nTWIrVG4rM29SeGFY?=
 =?utf-8?B?cWEweXU0dCtiSUdGQStUdytBTDhyRlVKMUoxd2dUOERiWlQwM3RWYXFUcjZn?=
 =?utf-8?B?ZXoyemRnUDFmS2tqSGI2d2ZvM3NRM0lIU0tzL0hOOGZaSmVzbjlTVHNFZ1BV?=
 =?utf-8?B?eCtMeWRZOWIwQmRhekwzcVVnczNsUnhWNHRvMkY5TzgxWUxXTW85ejZlbVJF?=
 =?utf-8?B?d3VxSG5Pa3RRNXkybEFmVlhNZk9UZjU4dE4zdmZiS2F0TnYya2V4YWtQOENW?=
 =?utf-8?B?WXc0VHlKd0JPSVNlTEdIczZLNVY0MmRoL25sT1hRbndxd2VTN3haemhua2Rj?=
 =?utf-8?B?Tlo5K1dDbWtsSVpuRGVPTFppb3ZTenNZTnZtMmdhV1hOYi96QTdKalJIUjhX?=
 =?utf-8?B?bDU4eXBpSWJ0T0Y0dDB2RFZxSWRHUUtPQmhkMkJwazZUK29HNFgyZTNlZUQr?=
 =?utf-8?B?SG5JMkdzMzExUElKQS9RUk04bHFqdlJvaXlKOGVrRzhRMmJKaFF2ZVZnbEtl?=
 =?utf-8?B?SlZFZDUwRFJrYml5T0tZb2w5Y2luWXZqSHJQS292Z1ZMaVh2SEc1SGMvbzNX?=
 =?utf-8?B?ZTZGQUJUc28vOTJrTm4xdDFOdEZKNWFGeWV5SWlTRkVGOUdGZDlrNWdVT21C?=
 =?utf-8?B?SlVPWWtEYkhzZXA4SVE4SmQ5L2hoRURBdWxTV3lqbllPd2tuUHE2Y3h5WHN6?=
 =?utf-8?B?cUJRT2dyK3Z3dk5OTXlOc2ZVZDJBdGQzekRPbEQ0akFySzNReVFIVitualZO?=
 =?utf-8?B?Vnc5eWR1RUhVVU4xU0FCcVcralR5TGNIR1ZOOFNnY0Z2dy9iUWlGODZNL00r?=
 =?utf-8?B?VnRlQmtYRkwrVGplR1l3eTQrS2NrRXlyMzI2dzN5MUdvUUxGRm9GREIrNStH?=
 =?utf-8?B?SmtydFFYN2d1NFg5TjYraVVsVmtUdkMyZGxxYkJXRm9RSUNWYXlHYUxJTzlj?=
 =?utf-8?B?YnYzb1lCN05nMG9ETmlmQVlibXkzZEltZmNRcGxFVXZjL1NGa3YxSk9PNlJX?=
 =?utf-8?B?YWU1OWVRVmFnaUd2b0xHS2tVdXNFeW5ZeE9NUCtYYzgxSFc5ZWFubWYydkli?=
 =?utf-8?B?Y3RreUE2NG1HbmxyeEZGa3ZqN0pKeVEvS0FZaythSFFrSkVDNjlVcWNZbUVr?=
 =?utf-8?B?L1g3S2ZFVHpGZndaOTJ6K3NESDBFWmEvVDlsTzJYeUh5dDJ1d3RaaVZCZVc1?=
 =?utf-8?B?aENOdjhwaGhzNCswTnJiRjdkWnk4ZldOR1VwZ2d4VkgyWHlmV2ZTa1B2ekYx?=
 =?utf-8?B?Nm9KaTVtTTJMR1RwY29wUFBIc1c5QUxySTZRUWVJM2pwVmhMYStCa1RBY0dL?=
 =?utf-8?B?clhtd2Mwc2F1OWNxM2p5dUFzd25JbkN5empSbXQ3NTBXaXpoOHJaVHJVKzlB?=
 =?utf-8?B?blpYTUY0QzdHbVpuUlAvbXlvaHlFWjk4MW9nKzBWMm8xdVcxeWY5cDI3ZkVx?=
 =?utf-8?B?enM3cHh0ZEFxeVFzc00zQndSVCswWnNWSlp2N01YcEhPMFVUb24zUWwvRGFr?=
 =?utf-8?B?WHJObTlFaGlpdGpoWlJ2bkhzL0JMRFk0eThYNk4rSkpibkVGM3RHUzd5VFpt?=
 =?utf-8?B?aE1ZblBZV2FoOUd6VGVqRE5ZZUJ6RGlaR1puSHBHNS9SdW5LQ0tUWkhuckg4?=
 =?utf-8?B?K3UvMUJyd2pvam8zb25FaHQ0aWN0RlROdzdvR05UaXg3aDJGcVNINmRubFhK?=
 =?utf-8?B?dWJHSW1iZGZ3M1NJQW4zSEdEWnR2c2J1L3BXUmNuN2VlekUwNjFRY012Rnl0?=
 =?utf-8?B?REJUL0lNT3ZiQmtqOGpJejliN21UbkhjbTBRZ0o4QitYUWVkbTJsY05Ubkdl?=
 =?utf-8?Q?9oXARPctLi66KI2vSsCwoqDk2l2gBLPNAosA1?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e828edf-1e50-4c31-9c46-08dee0e37fd4
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 13:34:44.2743 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nz6IyretF+Q02NipXXGdRmV7Rpo26BlTVl6LwHDhOysIAHBwn/Xk/0x0RsbYOUaBWG2TdMxJZ5VgWKmMIXHG8zDUfwwKfGWuMXVZl+XxPJlOIaW+odERkpnWs6URHbly
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9011
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

From: Peng Fan <peng.fan@nxp.com>

In rpmb_route_frames(), the RPMB_REQ_READ_DATA case checks
"req_cnt != 1 || !req_cnt" which is tautological -- !req_cnt (req_cnt
== 0) is always a subset of req_cnt != 1. The second operand is dead
code.

Based on the pattern of all other cases in the switch (RPMB_REQ_KEY,
RPMB_REQ_WRITE_DATA, RPMB_REQ_WCOUNTER) which validate rsp_cnt, this
was meant to be "req_cnt != 1 || !rsp_cnt". Without this fix, a caller
could pass rsp_cnt=0 for a read request without validation.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/mmc/rpmb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/rpmb.c b/drivers/mmc/rpmb.c
index 8bfdffd56f5..26d2262ef45 100644
--- a/drivers/mmc/rpmb.c
+++ b/drivers/mmc/rpmb.c
@@ -452,7 +452,7 @@ static int rpmb_route_frames(struct mmc *mmc, struct s_rpmb *req,
 		return rpmb_route_read_req(mmc, req, req_cnt, rsp, rsp_cnt);
 
 	case RPMB_REQ_READ_DATA:
-		if (req_cnt != 1 || !req_cnt)
+		if (req_cnt != 1 || !rsp_cnt)
 			return -EINVAL;
 		return rpmb_route_read_req(mmc, req, req_cnt, rsp, rsp_cnt);
 

-- 
2.51.0

