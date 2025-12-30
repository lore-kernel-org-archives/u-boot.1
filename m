Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 197FCE95A8C
	for <u-boot@archiver.kernel.org>; Tue, 30 Dec 2025 13:56:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1901783F54;
	Tue, 30 Dec 2025 14:56:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="I8sZ3Wx+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7237D83DE4; Tue, 30 Dec 2025 11:37:57 +0100 (CET)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 357EF83B82
 for <u-boot@lists.denx.de>; Tue, 30 Dec 2025 11:37:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ziniu.wang_1@nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BEfSMZRSGW6AbLi7KP8B7S8+yza6NIC76HvUOLEwW9iGm0scskcYdvW5eCrB8UDkut+SUZzl8gRMdj8lfWBrwLKQ8CI2oWmbdZu+D3jr6byheisfsDc8lB/YmRkSl9GyKO5KTx31ih0w5g/WG3vnMBtae3tw6su3WMzCx1rlol8MrIXuWPJOX+ZlW+mx8clbLrYlllWoPtXTbH1E1qt4sC6VzltMqsAs6+gSPHHI5MTSs22HxrWSoIPxKxYeNF4gBxekGySkyXPScBmUagYuHX3IOcDo2YCFIk49aPWj5v+M0Kekon8AdZGaF2aUvx5qHR1qNawSbnx/KeAIsPM/yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NwLZkPR6hzrEDxeEses/uSebWvFXW1n6l/Dkxf59DZ4=;
 b=CuUayB29KqOeykiz7hZh6ISodDWa4hOTb7zQjaT1br5Vfa6VJt7JTTzHuNNmvTweZpabEf9DwLwxitPq2A2CvNSKJ1gtlIbjhxGxNRxGOyMH2+e5sW6G07Cv1FRxFrZujk7O+gw+FgsuIut5OMJTgUMSggKrjyMZZ9jvfI7eHsvK6RUoilyOjM1LPYw690m27dEyjJ9QSn5+EEfpyKEQjE4l2oxcfv5flQ6oFZmCbw5s1RnVIbtoMooi3hE6M0IcrPeAisLD1fZ4EHuBlHe7kxz6IF+iREFKT/9hVRNthgX/wwvjHD8zfMKuu7IrBBG9gduF4EHAEosEaJ0Iy2g8xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NwLZkPR6hzrEDxeEses/uSebWvFXW1n6l/Dkxf59DZ4=;
 b=I8sZ3Wx+9DNkBTmo46ICHn2Dm+5Pw7xkosqgPR26rzWgZcN8jwlR217XAzX95iFwoD+0ywxTWHFCAEQcHRD/pjk+d1lwBlTwVFBy2q13V7uUoecLjxgJJTz7J7VBZQbOaliTu4EZmMPcwKo3bkPB/JLrDr61ROAOc7tBmGptvhHpCvnFpxv2L+fPXrpcqIZFJrksTXLqQuXY4zZNnljinaSAGfFyaaqCUuTJXzhipq8SniWLoDwbQGP7JNvxyPzaFQradMQmIT43oY+JrygvW70DaKcOYFVmbfqqTe0iT2NO3IBhQGDsGlgpHuKvzKdIImiAbFaiKsHgE13CAuAqYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com (2603:10a6:10:2d6::21)
 by PA1PR04MB11470.eurprd04.prod.outlook.com (2603:10a6:102:4e1::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.14; Tue, 30 Dec
 2025 10:37:53 +0000
Received: from DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::32c4:a8a7:1724:b754]) by DU2PR04MB8567.eurprd04.prod.outlook.com
 ([fe80::32c4:a8a7:1724:b754%2]) with mapi id 15.20.9456.013; Tue, 30 Dec 2025
 10:37:53 +0000
From: ziniu.wang_1@nxp.com
To: peng.fan@nxp.com,
	jh80.chung@samsung.com,
	trini@konsulko.com
Cc: marek.vasut+renesas@mailbox.org, bhimeswararao.matsa@gmail.com,
 xypron.glpk@gmx.de, kauschluss@disroot.org, andrew.goodbody@linaro.org,
 tanmay.kathpalia@altera.com, ye.li@nxp.com, haibo.chen@nxp.com,
 u-boot@lists.denx.de
Subject: [PATCH] mmc: Add power stabilization delay in mmc_power_on()
Date: Tue, 30 Dec 2025 18:39:50 +0800
Message-Id: <20251230103950.1543515-1-ziniu.wang_1@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA5PR01CA0236.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1f4::10) To DU2PR04MB8567.eurprd04.prod.outlook.com
 (2603:10a6:10:2d6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8567:EE_|PA1PR04MB11470:EE_
X-MS-Office365-Filtering-Correlation-Id: 8299216f-2e3e-4da0-ff3e-08de478f7c5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|19092799006|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VWTkV08y4GesoUDILdiY5g1SIUCStF+ZFwQTTc8qhh9AunE/5GnxMXeeKhZo?=
 =?us-ascii?Q?ATe68X3IbiHrj8oXQEi+TeAYYPtRRjc0iVoqpJ2PgQILgx6NXQuT/Udoul7V?=
 =?us-ascii?Q?dHpuos2HXK1vbjkXtamHVeAL0dpRZHdlFC19a9R0uqpADbENC+qOgKp1oA+r?=
 =?us-ascii?Q?TVF0U1VQXdSf9fN+rtJEK86ciKeon6kYBZUlHOSbEnnSupbgMc9ZxXPZY3TJ?=
 =?us-ascii?Q?r/0oLfrpX4rBt/oSLrPNvb487bz5ZvTIl9ETDl0dfbDkx9GXoNtGCx1ZH8yz?=
 =?us-ascii?Q?EHwRv6aZZ4t93jq8MkTRIXF5RgHYpv9m2gpn4xmOwwUMDN9SBlotAwOCcrm6?=
 =?us-ascii?Q?apkmVlWCYunu/zlqzAHbUFznKAqeJ+drxVKVhgd3kEVSGnK/YwC1zhJoJYr3?=
 =?us-ascii?Q?cC1cEPgaMvmGE/rE9B2o/jKp5oahyjWIIDDd1XAaPNP3+Ux/u2okmu4QrwSM?=
 =?us-ascii?Q?bGEQuJBIkqnCsv9e1hG8iHOzACSM82R9QdQqKqWcJg4W2MbnFdaiCpgRRAmC?=
 =?us-ascii?Q?HR7bummp2bn7KCo8KzCtFJAHnQGFH9XFY9l8fLOU+w1+xyigEZ8M3kKWHd/i?=
 =?us-ascii?Q?Qux/dWfBde+Ug1oeR02FcnBMwB//MBIiFEN1dg6ZdAmpjLhJIrMmE/YEHGsP?=
 =?us-ascii?Q?QLm/R8WsodoN1j7YiVws5YmH8YzHylgqFDs71AGfkrdNvvDHCN26RH9tpwdp?=
 =?us-ascii?Q?btIRO7kuSR1M4xGzOUuxBZiRWzSw/h+cJnDi1bGiaxqm3T5tocml2wU6WeKi?=
 =?us-ascii?Q?BMiMOeoJNvjmfcwxk96C9Bn0vBlsJVW8wJy7i7kMJSSl63eYPASsjWUyjXF2?=
 =?us-ascii?Q?YJDKPyd7PvKZIzNe97K5lCURHTVpcDyVOLW3QIaQNkS0+PudGL6Cc3ary65a?=
 =?us-ascii?Q?PH3x0D5UzeajTLSDuh6ny4aJ6Bj1tlSRFiJIYbbaV0mcfxwQLC7QD2ZENFY3?=
 =?us-ascii?Q?5e8PUZ1zhybL5GMiVNpakWkRlopBDtBH6PJk/p0ua8gp2CJdyPjl2BHEXnab?=
 =?us-ascii?Q?0zEKHTBtDLmikRPHk0QovJd0Vr3jhN2NO1XR6BOW012ym14DRzI5oKDV4fW4?=
 =?us-ascii?Q?fylRa3a3mfIjBP/2TyDqRLr3zOA9xj88WOVOj4pGfzuI6zQerY5H4dlFeZPS?=
 =?us-ascii?Q?j4xYd7pZU85Ya3Y5IYbO04M39qkNrvwj1dLez83q6kg6grtTpMraNUiSKUVe?=
 =?us-ascii?Q?tq09u4G3pZ0mo3aTUUfFuWEfqgBYtnHf235PUBdr+r+tgv44GcA6Bx6QC2hK?=
 =?us-ascii?Q?US+Svl6YLOq8rN0jfQ4+bCgCb+vvqQvSloIge0FDUvdBTI+W+pD6SEEetOlP?=
 =?us-ascii?Q?Jdb/Dy9YyZmhOu6Aqo08RqL8y/TuKsaipa7TTSRoe/Yd8d1BGNYoksr3+plP?=
 =?us-ascii?Q?TSRq4EqVTeT/tcIAJIleBb/gHVm2bgRPhzJz0OdKPTYS1+QcqhGAcDFAX1gw?=
 =?us-ascii?Q?saiOi6a1R2LXIxRfD+tm2Q8qNXv3/Yp3TUq2Sb49kRnpnnCGqcnSQ2JVmeAp?=
 =?us-ascii?Q?eMluqvxAXf73cU+Ryi2paylK3uxTjroVbtVI?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR04MB8567.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(19092799006)(1800799024)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0fTHYOVAY7YTtITJe6DqAqcyzFqZ4n5LWb7DSB11D5J5PWjj9itPYt9rofTt?=
 =?us-ascii?Q?6myAzfentLxLYKq8iqtlT+6ksgJbN4CozahklFC+O7KNZNfbnH4m0AMwV63p?=
 =?us-ascii?Q?pKbqrq5L1nUKCpJ4tZX5DlNsDW2+ORb80rMkBMVyVD07QBStVm3Bo9QWPQUo?=
 =?us-ascii?Q?znARXcQTXPkLCsVL2HRKx/xm2fgD72bh41zu5E7nIF7Ve3D+1wpwMzewCKli?=
 =?us-ascii?Q?dTDbW7DOmrI8j2yAxmlMr4dwRLvVUtJPxW5JncVhRKwizqgYFr+yDH+Y17GG?=
 =?us-ascii?Q?5mG2YEqIx3A8cS9H1gXLVwA7wOgVPOoiqYKovzR4T7gW8LjLVVGKozNGGT0G?=
 =?us-ascii?Q?+YdgraFHMtSydfLpeaOKORSciSIXUST0K0zeg3xyF+UCgoC2CLDDOBJTi5eH?=
 =?us-ascii?Q?XA+E4f6MtD8U7UdFfAj7ZKLZS22oCzx43qkLAfKmnqFeDfRsfPh9qfoCriB3?=
 =?us-ascii?Q?1d3U3T2G0Sgh+J5gqA1SbIdgbkgpgEU4V7D2qlauOVdPPgrsaA8esAUf2Ocq?=
 =?us-ascii?Q?2yWy64lXhRvUuaAqupeFy9Mn7jMJ7fOBvgDnnMR4Bl5vYKbHL0UoY7wtMXtG?=
 =?us-ascii?Q?Fy17gG+orysVJL1dixrN5RcK1csSq6LnDecEhn/BMmuQmMRt/bjdxzTXbHKX?=
 =?us-ascii?Q?LGDG13xCf2aDwHQzEEVrNDAWT3ud2UKJBE6cKQBCp0RYGgg4zSL/hJZE+Whb?=
 =?us-ascii?Q?VQHJ4Xid6EgtU1kBcvHXjOMOEM5MARmvjsaEi5cCqgG98jxSrOHPxUXE1+YW?=
 =?us-ascii?Q?zQVERkMjgiqcV90s2mvKA/b5I0x/nbtQ9DNGUaktcBSoR/koaosXn4I92fSV?=
 =?us-ascii?Q?z2PPQDNKtE1/B1LPE7+8rFd5BfWuucBW2RP8nULMMbXe50Uv4u7D3y3WJc/R?=
 =?us-ascii?Q?D/bUuKwIJojM1KYCpRMFcKOnj8chFi4oS4RG82jbbyz6vZQDOGVh6r+4KAvI?=
 =?us-ascii?Q?RG7HGAT7NSZB5m7C4SBIS/2jowBI0a2KhoIIoCbp6+wUCz0BCbNcsXE3Wmm9?=
 =?us-ascii?Q?SrWy6gXvdxGjtJApQ9j7EocnrrJMMdipAu71xXfRdiMAI2DNeb36Avb9MKVQ?=
 =?us-ascii?Q?V7XxFyjCj4L11KisBOQXvoS7xdQxXA2afZf6f9yvGOczgi9Ike31sV5oZRvK?=
 =?us-ascii?Q?qBLYpfz6c27lzd2rBXq070rATByCYtzTegUkdI+WSExAz6GI5KjY8WCFMfxQ?=
 =?us-ascii?Q?2HxnaHTLapuq7zgf2VrU9BEzXjCFbdpPAy3eTPUDjXOr2+HeY1+cDkBrF5FZ?=
 =?us-ascii?Q?j4vP8K1qpVKk9YSaVVukVl8A0Hd4aLjAUOQLU+ZJO0FVPqJSB1pxW0+At496?=
 =?us-ascii?Q?q853l/dHP4gpJRNQFbdMi7gpk3LyxiVXMTEI7aEMO+pENNmYrVL41mj1XxIt?=
 =?us-ascii?Q?UOz9/mOEiWmDN/9N2AlrZMKq4aW2FWcX2kXkQ1ZZ8sl2qE6Xp9Bgu0Og8YYb?=
 =?us-ascii?Q?g3UQOBOOrdbOQmGqI8o52FRSjFOgIxC2LY7cdDGdWyKQBkQOgXUsp36/ir4h?=
 =?us-ascii?Q?2ObAZXsb9AkpeKjh6fEsy8JrXB8YysBlac0TUrHlxi8Qp4QMhdWv9CXqK0RZ?=
 =?us-ascii?Q?8A3lv8NDdXOasWgiEtFoE1cv+LovSNMt5QS9QwftX8JCu5n0rrTTHWHaT3h1?=
 =?us-ascii?Q?rinVSnZqJsnosmqrV3lDC5aj2w4oUCLU0GT2tSPEsr+V5IP7/jSs9Zy9otvv?=
 =?us-ascii?Q?gs4gV7THC7dlmMwJ7mwNy+jqH+A4u2ncAoFD6/dk1gGFVqRnPJSE5qyLKkiY?=
 =?us-ascii?Q?L3SB7HjYUg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8299216f-2e3e-4da0-ff3e-08de478f7c5d
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8567.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2025 10:37:52.9704 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ARU/sy2BBe+yvjfDDRP7V9djRqNMGID0dGn3uPKARPK99hb1OBcIFP86Bg+PSJ1vQsgJjUBaSf2TFy9EQqlYkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11470
X-Mailman-Approved-At: Tue, 30 Dec 2025 14:56:24 +0100
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

From: Luke Wang <ziniu.wang_1@nxp.com>

After enabling vmmc supply, add 10ms delay to allow voltage to
stabilize before SD initialization starts. Without this delay,
some SD cards fail to initialize because the initial clock cycles
are sent while power is still ramping up.

Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
---
 drivers/mmc/mmc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c
index bf82c515600..97037722fe1 100644
--- a/drivers/mmc/mmc.c
+++ b/drivers/mmc/mmc.c
@@ -2878,6 +2878,12 @@ static int mmc_power_on(struct mmc *mmc)
 			printf("Error enabling VMMC supply : %d\n", ret);
 			return ret;
 		}
+
+		/*
+		 * Wait for power supply to stabilize before sending
+		 * initial clock cycle.
+		 */
+		mdelay(10);
 	}
 
 	if (mmc->vqmmc_supply) {
-- 
2.34.1

