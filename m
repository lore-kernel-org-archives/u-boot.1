Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F217CF9C71
	for <u-boot@archiver.kernel.org>; Tue, 24 Sep 2024 06:28:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F051788356;
	Tue, 24 Sep 2024 08:28:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="RCcXrlOb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1187588663; Tue, 24 Sep 2024 08:28:44 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100000.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B300880D8
 for <u-boot@lists.denx.de>; Tue, 24 Sep 2024 08:28:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fetqGlEvtxAPAaRtFV451Dm7XMeVLEzJKhyriTyYlOepP4ELJAbkgZac4jkw+2umE2FH/0WdBzqJSir0WwgtGFnFUHaPjpWgdrhUDQHNV2V07tTV112iZ7z4QvIVnU+5YsTZQizWz+4tsL19ivZdpQMYiJVK5W4G3FIhf2TfeGlVwNCRaPFaAbTM/Z0Ipwe7sapqzmZNtgeE6xirYomCA28EsEXD6ru5805N2tucsQZ2gLntge/PckNFQv6/cTwvgW/7HQqo8KhgWSqSFEhjxokX/ZZ3R/pEi9e/dDHDBnfILlRgHpFV5PUWxhVqdX7p4w9sjL7Bz1BPAvL/E0KDKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3M23tF/ooi0Y4vopaHYjyTh75Qt4ZndFRZyHLAgJZJU=;
 b=T0oxzqxn/ksvb/IezwNn6XFr+EOGzLxYPQeC6MFfBUSdUaop8QSlY9yvDqgTEwXlQfWS4MPFgSvTop0Vqn1UE6cbwh8JMngvte2ibDZLabH61+ANODGKYxxmD366NIdoaLbjpxpFuBE8HQzrLzO8dANws6WIzASt8BWzjUXQhSw7uLpMH+lXRsmn8QHUgfFCk0bP8CcTfVrtXECbjlwNsEkeD0PAoy6/bh5k+rLCG8h6+fJPO5b3aekmDDwioQuBvaQcXtwGW/5T9yTYt15a7UC3SDVYV3ZjgOvwrA3f3Oe8vgXqpLbAPIIc7lJ1MsbACpyy7/0SH57qIpTJbQx4Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3M23tF/ooi0Y4vopaHYjyTh75Qt4ZndFRZyHLAgJZJU=;
 b=RCcXrlObv/sKdsXQ+MqIWg3x1sfENU1phrBGscoBjIZHi1MdhJnNmwKgSlGZDPxWyR4Uvc0REyZQyEiNdO1MY0qvXfbZuqZZquMMfdfxwou8Mm17U/HwqQeNj5+qcD+IAxaB2qfelBjCNzTK+Omh2JfzoC21xUAmBjQbWfRn3KunJs9B/A9Aim4ytSfilXa1xjb9+QiKLIuS1/cbrnEgfExLDaSE4hmfP6oHCkRBk6gvCqkGf2tUda+MBeu1Ppjfnd1zfJeeX+NACCbyf+EdbpH4azuiEHp+GPHXivDeR1VhNIgm4uTzxHmMTxd3+y/vtb356cI1tvFUkftN1gMe4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM9PR04MB8633.eurprd04.prod.outlook.com (2603:10a6:20b:43c::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Tue, 24 Sep
 2024 06:28:40 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7982.018; Tue, 24 Sep 2024
 06:28:40 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: festevam@gmail.com, sbabic@denx.de, joe.hershberger@ni.com,
 rfried.dev@gmail.com, primoz.fiser@norik.com, Tom Rini <trini@konsulko.com>
Cc: uboot-imx@nxp.com, Ye Li <ye.li@nxp.com>, Peng Fan <peng.fan@nxp.com>,
 u-boot@lists.denx.de
Subject: [PATCH V2 2/2] net: fec_mxc: Skip recv packet process when fec is
 halted
Date: Tue, 24 Sep 2024 15:32:00 +0800
Message-Id: <20240924073200.27578-2-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240924073200.27578-1-peng.fan@oss.nxp.com>
References: <20240924073200.27578-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0185.apcprd06.prod.outlook.com (2603:1096:4:1::17)
 To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM9PR04MB8633:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cc4cb15-fe58-412b-af40-08dcdc62210b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZuaX3CWzJsFtOrMo4epbBTVSaiOM5nCv9YAlupHdyRXoR599FAseHauWAJvw?=
 =?us-ascii?Q?Bj4qFEAomV2o6ymtsamPXa24Sxt4jEkdcUU/OIMI3yRI2z2EwjvAGa3u+309?=
 =?us-ascii?Q?a5gvK9IWu0IegI4bicSvjvmET3dq3O8kE8GbOlegW0zNbhd0v9wWeqQlAXOW?=
 =?us-ascii?Q?wpFnNqzI6ZJ7T7uW4EwQlgRh2CIwiGLPUfTkWGfEkQKiBqJJ+1APVbVJiTj9?=
 =?us-ascii?Q?H6XYS03DoK4XEy1tanhiRc/CEfYbwwBtkWsYt2Ccx6f1/HKrHqBTA1dLURYq?=
 =?us-ascii?Q?edZfvn4K/xF429Kkgx8AarwUe94PSB7OEUBHlcZbhpDNAiylQIl+0M9PZth4?=
 =?us-ascii?Q?x3eytVMeUwuqIKUhG/xd34/ujM/XxOmI26qMVS49DQphD+5nOfAEv5OIPQ5P?=
 =?us-ascii?Q?wgFBtCydDunUK6wq2kJpHuLAq45q0Apr3Rdh+Hhbm3hWv2S7DlVFqa65qX6H?=
 =?us-ascii?Q?l6OxS4Vz2eZzQ1m5jzlG6jml9hEmGj+Vin3shcClGAUGE1vKS6f3tdRrr8ME?=
 =?us-ascii?Q?tRIpm4UjTH1z737Uu5UCkP/hMYDtU6muwQa8of2/429co8R8Iw3y7An2p/Dj?=
 =?us-ascii?Q?/mj1/kxAuPFLYjjtfO1XVyQC6YtF4cwWf28DTBYLbKa74VorXIBrbZAxE+kG?=
 =?us-ascii?Q?fodwJaT95bSZ/c9/y68eztJ54ROwYB5/y8aTiURTKqduo4YI09FasrA9b8Br?=
 =?us-ascii?Q?DX1Mwry90IwLkwGy+qDLNA48h1/vr+s99t8SECgW3o2vhrQQOy7B3ellPxb9?=
 =?us-ascii?Q?V2iP+Sd98yDJQhj7ucgFrFwv3b6FLqTys5PMekPgb2aa0DCnCINmZaw3Iqot?=
 =?us-ascii?Q?KJyWul9Pq49UAbI+FoRSbyEOAWx9+vnWKIwv3+mo7jNUE5LQKz1Z6n9CssXY?=
 =?us-ascii?Q?X1FHNeiMyXFavtV03nTBEOeUNytO1b9FzmsQAooAot2WcXO3j2qXvkEuWtRF?=
 =?us-ascii?Q?2uye9IB3MH3ptT50TD/HMfIbhDOGz3BlGlMqiG5Gh5x0l6XT7GcAo6ozKBgp?=
 =?us-ascii?Q?fYVlRFx7A+MjFzUizNHfhmD0ikNnd/JryKXgHqQg8VSHYAZgaHkE4qkMiliD?=
 =?us-ascii?Q?sfSA3kVDnpg81LPUgGgNo7MD3DmR38ytBcXceF0fK7RoLfk+9ZPEirG5XqXz?=
 =?us-ascii?Q?f9Z+BdmYHNe+8LHTqRecX3a9cSuvOjCcR4cI8pkE1A6vNvjOIgn7+w9dgTSw?=
 =?us-ascii?Q?DeDdKPPf4xruNyvnNGSkTanWOqQJAt0N3l90rT+6G5WjPRDLIzn4SQYdviBs?=
 =?us-ascii?Q?f86srp9RV8Sq1F4x0eqhaaEGIA9epyfQrXuUweDG+RZm7FaWh5isUPoE4/zv?=
 =?us-ascii?Q?d6tkNYo1PZCDFbJw9SNpmvpN0fjkJSIKUZBj3OaBGYefmjR/uIB57xu2DRuY?=
 =?us-ascii?Q?+6zdPYG+foA6qliB6IjZKnmEJ9DI9YnaEB0A42vtr6ZMMOXtRw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KsIwBw3xrpgc+PcdE/WwLa4qqagBFMXvL7AkC4MePdlhkWixQVkJRJnAhm+O?=
 =?us-ascii?Q?CO9TQD0c++9blWN+qI/spqUL2N0lddGo4VJEav/xQ9aW2XHlHWrkuL8yhoxA?=
 =?us-ascii?Q?yCgXYhrUOZTvpIGbREgbeA9i7/oysyqyAK/CG41oHe6R4kY2/oUKZntgyZ0j?=
 =?us-ascii?Q?4kvPQ0iLayOxLp5wPrWB6WCYHZw39M/lrMNZAea/lkotXoc8G0Qvydk0jXup?=
 =?us-ascii?Q?OUZALeVUuE3ynWo9fwqCztgRtwSJ4IufIpCEP0tH1tZ3SJHiWUrv2vQ2lnAj?=
 =?us-ascii?Q?z2pir20iZ6GOMkaaGqgp7CYUAUmCWfjzdVfxOvDJooF/KoQ4zFKhdTBeRGzT?=
 =?us-ascii?Q?JVXeW0M2dYwjxdlg7x4A9Lm0MG/iobv++N8D1nHOMHo1XUMqShvDgHqUarCL?=
 =?us-ascii?Q?KSbra3z8kc/VN3t3Mn0wV2dm4MgSCwZ/lMrFPwSk1KzMRJkyUDaFa0CpOx0c?=
 =?us-ascii?Q?GwVDZvrDvlQJso28tvJg25OEYZ4EhmA7yzKXvr7r5CZz3LF0Wxrg227fiYPL?=
 =?us-ascii?Q?HShSw7+doxhtY6Ro6x73odxmm5JUnQKXDkSgIm7biReyAHDOmuy0ErTG7Jly?=
 =?us-ascii?Q?aL/YdgCCJPx3gPSxEdaiHKp45ft2O9uq6tSm+dx5lZoYa173o4u9ayJcnJGT?=
 =?us-ascii?Q?LYkLgrkRs3+LogdPw08A7rX4CujQAGiUBvaeLVXGqOAxUBEJ9fs6pKpyAWoj?=
 =?us-ascii?Q?hEg1DkCuVMfldBa0rSxlRJWVdTtXc9bozaz3IGcgZwbzTmFx2iJOrolrYmni?=
 =?us-ascii?Q?BMqAYvaoKqwZgS6afryXQwmKrC0IFN+VfuHUnppzzcUFLb1uZiMPzs8Yyuik?=
 =?us-ascii?Q?Qn71CepsIsT7wa2JXvwDejLt63JpK4ow9Agun3DWyV9eIZs01cdH/0cYNY0W?=
 =?us-ascii?Q?QE85+m6cNjoKJfXZHgn+LkFSIjU45JqoUNlI+dUPyb8wk8giWB6W5YnGSamH?=
 =?us-ascii?Q?t/pBB3rKrfN0tod5M9bX8UBWTPvDfxEGLvGS9swZSbiwOvTpNvYzZpOyR92d?=
 =?us-ascii?Q?zuoqDmrjYZ5/FtXfzBTNAaTvlx8eq7yN1TMEFELdhTmVsmKAQdOLit07e9rw?=
 =?us-ascii?Q?y8l3NublgKmaFMug3QJ5NHNuE/eHNUEs5o3KuaKaSYVAmAY+sOaOG/ydkM6L?=
 =?us-ascii?Q?Kb80fyq3W1QdW0QY4RA9vK3D0thI3XXR/gohpTcCFwPosaTnJfd6Mm/NXVn6?=
 =?us-ascii?Q?KUtJda+X+u4MgWLhLef4kMRSf5UpNoi6TjZ3vP8W+vKDTZeC8bPAPuJ5bLzL?=
 =?us-ascii?Q?8NSdm8b7ia3xeKUkPVgeQlFXn4uxFyewkJ03z96bvQGPYVc/voc3YBlebHyV?=
 =?us-ascii?Q?XuhsK4++qK28Kkg5bOEKWbpQt78KceAiRkHB+T/4wQbclWuAn4wZy8dVLqLX?=
 =?us-ascii?Q?vogd5m4fi+mIaxyplYZVgBVlOyzzAMiHkItQQ48ihlcPgnVGHHJX5wS3hzpy?=
 =?us-ascii?Q?N0+/daCGISDvvS6uoMmWn023kaPoY28JhhDKMk/Lkx7675gA/oKHL6iJDVsv?=
 =?us-ascii?Q?eZ36pancQiqGEhxkNWhGUobu9h/BD3i6wnbdokCuN0mrcuVy1STL2YHhxlTj?=
 =?us-ascii?Q?r6KM0knNXA8h/dzaKVNT9ZtIpsp5u7Fc4OT2594a?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cc4cb15-fe58-412b-af40-08dcdc62210b
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 06:28:40.2253 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0Z1/gRK4+7+ldiDAdnRI+orAQP7gHAq7hXjfKnPp9JWdmKmwjMonSzZTJ2buI4rYqKvP7GgBfK7gDO53XuUsjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8633
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

After FEC is halted by calling fec_halt callback, we should not continue
receiving packet. Otherwise it will process previous pending interrupts
on EIR register and uses wrong rbd index as this has been reset to 0.

The GRA interrupt which is triggered by issuing graceful stop command to
FEC transmitter in fec_halt is processed in this case. It causes wrong
receive buffer descriptors be used by FEC in next time.

Signed-off-by: Ye Li <ye.li@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V2:
 None

 drivers/net/fec_mxc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/fec_mxc.c b/drivers/net/fec_mxc.c
index d0590fd137b..50edeb4b5b6 100644
--- a/drivers/net/fec_mxc.c
+++ b/drivers/net/fec_mxc.c
@@ -818,6 +818,9 @@ static int fecmxc_recv(struct udevice *dev, int flags, uchar **packetp)
 		return -ENOMEM;
 	}
 
+	if (!(readl(&fec->eth->ecntrl) & FEC_ECNTRL_ETHER_EN))
+		return 0;
+
 	/* Check if any critical events have happened */
 	ievent = readl(&fec->eth->ievent);
 	writel(ievent, &fec->eth->ievent);
-- 
2.35.3

