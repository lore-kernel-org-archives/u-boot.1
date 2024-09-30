Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CAE5CF6497
	for <u-boot@archiver.kernel.org>; Mon, 30 Sep 2024 05:47:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C2F888D78;
	Mon, 30 Sep 2024 07:47:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="vQ1cEaOG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8661888D5D; Mon, 30 Sep 2024 07:47:29 +0200 (CEST)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on20629.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260c::629])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B95D588DC8
 for <u-boot@lists.denx.de>; Mon, 30 Sep 2024 07:47:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RrQ1mvY5hd7RefPZRBlmcEfQ2/DG15gcfJtPydtiNQyWZjeUfU59zA26cHWM4fMwAJlKlMoytjghL0BvELGIdSIhn436NjliURnuGMBmEHyCxShvEgbNk6YdR4+L40ylPnhkOAZa/psXVdL1F+yX8MVaLtx54gFXBP3ZU1/IqQC6urdlJ/jf0pMDLM3V8Zk4uveODz1qvC210jcRQhpQN1KKEX0yqL+T0dxldR2kOIf64Pbw1LDwG/UR+WOjx3vGAM5Ab5BwEwxfjHohCirFamLHh1Rd9GdhCN9mXn/2rJdtjybpSygFQOkxPVPRhlzAPLAFR6dxI6vStNBpjRBdxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PZCdbgxSGYdNuBQTDA07yvm6mfIF+pw7zB/KtUfkb2M=;
 b=yFwvqceoc7iNX98a6SOLH8IFtDPsQoKeZ/sU+1b1tFMC/5f6TVYtOsWJHf3GFj8vQhWOcu4QqPVoLAPDCyd+ADqNHhiodzDBBtJBezrp1ciqK+TAxB9B4zHT9YMKiAoHR4DPknRBQFc7wgXz5xRVUVIBVSL7IAUOk9lTQEdwFjG6uAxfB8GpQteEAOiy1RVl+IyNn/wdi3hAF12Hm3FfeiE6vlCVCmxP8TtfGHTOq7J7aBj7IqVaodQofpuPzv8ubr3ra9Zym/fYKJWaIR89TsLXokuUWqrUk/fY7eVUmx6JOrofmEn7bOPzbyRh49PHNrFilRBJ4vcAgs07tuiHzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PZCdbgxSGYdNuBQTDA07yvm6mfIF+pw7zB/KtUfkb2M=;
 b=vQ1cEaOGEUR85gtY+Thcwa6OLdOXRVWZc3vpMKYSz3EPIcufhMDBEAk3Q2ciexPyf5KMLfEPkbObb9b+lXOy7aTvRPEhXR2/fGLbgQUvEKW1IojMAaocJwNA8OeVIR6WNFxAyJCAEwxiHfTtsk8sHi75v4EBG4bOfMmLmLDR6D3CeZDzSZrAnapFtWd80PKpCJ1xN2KD1MOP/h/gKA8hUmNMzezgXAyLRhYamx0kz9dC3lzo5XoGdyjqwhJNwX+53/DsmYjofL/pDHMQj56UAoAUYJCSj9IhOXC0M77/Kr90HCwaFtXI0DdJ/nuufKUss0ss7wFIXk8Exw1HXH8oiA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM7PR04MB6805.eurprd04.prod.outlook.com (2603:10a6:20b:dc::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Mon, 30 Sep
 2024 05:47:24 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7982.018; Mon, 30 Sep 2024
 05:47:24 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: festevam@gmail.com, sbabic@denx.de, u-boot@lists.denx.de,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>
Cc: uboot-imx@nxp.com,
	Ye Li <ye.li@nxp.com>
Subject: [PATCH 4/5] mmc: fsl_esdhc_imx: Avoid resource leak
Date: Mon, 30 Sep 2024 14:50:40 +0800
Message-Id: <20240930065041.5554-4-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240930065041.5554-1-peng.fan@oss.nxp.com>
References: <20240930065041.5554-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0025.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::10) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM7PR04MB6805:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d2e475e-4e6e-488e-39d9-08dce1135bbf
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|366016|1800799024|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mq/T2lZ3qfK/GBILgeAJAkAQR9LH3vw3LxoqOQsq8s6MEUrzMoXjEsRXqO2X?=
 =?us-ascii?Q?qaHbvtjB9TNLoK26bquKz7905e3+bEgt/Im6IXesPe05MWScRLIEFwVhKhXN?=
 =?us-ascii?Q?tqn/YOW1wjeNUk3YemxaOnoXLKFlOP4wa1+EIdM0ysOuxgCVmLYWUK583jo3?=
 =?us-ascii?Q?BU337JyoppwVRDMIjZol8csheoRDrRi0Ei4hBCgp4cENgbyLWuOAGZ1srEBt?=
 =?us-ascii?Q?usRu2a4WB8E58uABY2PpHxYRZN5B0rdNogB6SfgFuVOANYemv32zzZWiAa5l?=
 =?us-ascii?Q?sz70vbNifKUV5JalDH2pha08pvF1G1150cCfgzIBkPMmcr9DzLgCyUjnUeS1?=
 =?us-ascii?Q?A9brcAtyJF/vwdZ0H3aHm47nQRZQS8F50YSRtcNkR/vFwNLq+X57npf13Pk5?=
 =?us-ascii?Q?119x8g6TFd8ZYD64/yWwBlZzanwM/i/0NYDX3Off4m9RyZ0Yzc43VNPUtKT1?=
 =?us-ascii?Q?EUbW5OgQl/W5UeF65mUpppaG0s7JsHYyG8C7/Qc/akUa/j6avtfv37NSftoz?=
 =?us-ascii?Q?eV+7ydoJYKabjJ4ap8hZIyXPCUKysPj475QPZ2jh6ua434NTC5uBRCMn1Kt4?=
 =?us-ascii?Q?jm+S87kKrHD2j9xtbIxOoz46v0+/HrAdcZZnf0+ffzQsfpV+atR9et/4t+lJ?=
 =?us-ascii?Q?AZGi4uB6JkuMGD5WDy2ulsY9Bfn1YliT3s1BYD1JMzEEsU6rdw08SYJ7/zUL?=
 =?us-ascii?Q?hhbKXhOC5dLu743yl7wm1AHGHNylh1sYwTUxoCPLby5Q9YyovRnM73etpP8o?=
 =?us-ascii?Q?Rhi3uUhxheZuDscftP99QaL+uOVBl98mXcb7x4qXMYA1myK16pAPdfOncHLS?=
 =?us-ascii?Q?/7Hul/iGV809Qev8jbq/Vs2WFCypkN/84dOOM8pXnGNW+zf2mo84mJlPiDMb?=
 =?us-ascii?Q?eiVcDZbP+CKkeriqY/uNIJ+Lj7hnYmAyVhCPa7nl0y/Ad2XWWc6jiFCa3EwV?=
 =?us-ascii?Q?+GHWzlcRhD/xJubdnBKOPiGGqFr9d4uPNV9CorbsYPBWeZC+/NERzI6CxcpG?=
 =?us-ascii?Q?rVAFBveSb9BVTUt3nrEaBXo7W0ZmYdscyFDdF9oBTMn4YzyYDZQZcrFtlPza?=
 =?us-ascii?Q?iOxpJn71dltSTipj2Sg0psh4sXFemui+KtK5bmg/rvjShAN+eVnlC1wNvhhv?=
 =?us-ascii?Q?lbBT7ucr5Ln+Z2GArNMWiyyHXRr3GSte6c9gdnCrSzGE6PG6OAwrIR6WqR7w?=
 =?us-ascii?Q?016pIEyvFNNvQT79ydXFtQIQqiUd8BC/uNphDc3MMri36CP/tl2dNhxibpRn?=
 =?us-ascii?Q?+RP9CqcB9G+S8wvCwkrukFLDovE+A3WuJqvEsf8mXd7uGgHBpn3p+xFxkKhh?=
 =?us-ascii?Q?QehmF7RWpQf81GaTAykRySYRTg2d8E5PZrkoOhbvIcCN8KfO8ds+D/NwZTLa?=
 =?us-ascii?Q?P2eo2cs6xCs9lTexq4e5X4Q8qy2ngag4I85FoXYJio3hpfvC9A=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(366016)(1800799024)(376014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Lgg4QVkv835hps8oJjq99IunABLSDkpEFVntw/ai7cUW6rLID+tXemCcaXKq?=
 =?us-ascii?Q?B4npHonYg+7ptuAQJ3jT2+NfkU+Nj2vmLHT7HENbgj6dzOI/lKXY5d7CngNo?=
 =?us-ascii?Q?f7RhsqfCHCNnWH4A3ahUeFKUBdRNq1mCVek0HFkyWu/SDx6qRWDl/uMdLjoS?=
 =?us-ascii?Q?Aex0Ba9gmo0+I2E6/y3SPQaCoJOhyOCVw4rBLUk2Ek9kd1JLi6z2p4ehOf6+?=
 =?us-ascii?Q?xF6BPNP1hQ1S1XccaN/ZlmJGI4GxCF8lb9so88w/d/oj8aLcWMHctmRDHvOd?=
 =?us-ascii?Q?PKKd0v01n9LMemgI1wmmmp8gtJChGvgJEh0AqAO9AX2Cx76hzgiu9PISo4qP?=
 =?us-ascii?Q?y12cKNa3gSKGBRLKatq3oS7GB1WmF0n8CzG9OselP2I0qAM8cSUsXvmR7CvB?=
 =?us-ascii?Q?lPUoddPirSnn15ecTzbA6w9Z86pE5figfWIvXa9O+DLITNlSgebiROibuN/x?=
 =?us-ascii?Q?IRZXP5x4leCMWs7soranQQRA64zQHmZEUGcHWB/rThWljE1B3yj1/kNABxh/?=
 =?us-ascii?Q?A+AiSYCsuoByiCuX1QGJtkETaYEtpuVF2pHSoK4z+XGXUGRx+i+3NT3gb0mA?=
 =?us-ascii?Q?bh32H1T3iQ/LarGkaFdm8mQ9WRN5VIEUozYgxQDekgCw69FvRjVh9VIKUnFy?=
 =?us-ascii?Q?AvwqdXlDW122XeMt+JXlGRudEwENRRjang4qQ8IC+thD9fbvunlQ4/iAL4cn?=
 =?us-ascii?Q?qww7i1/2vt9mDR25ixPR/rYSNobuXXc60PRbyUsLgsykhp+m3ewChJxeeP/G?=
 =?us-ascii?Q?vW0Rm9Q3BMaib6z7yZTPEbvEXqQ88Uhtdeywx0Lo87G6YAHlUC4wPexJy5ok?=
 =?us-ascii?Q?pgmA6+G06qhAsnK0NpPY3t+L9Eyqx7WCBZchBp4GlfxU/+J9bYL46e0huBDv?=
 =?us-ascii?Q?bc45gykHg0CHDTUQ5wLAAT5upiOMzFqLk6da5fpSZZC8ReD0d6A6/YQOm21m?=
 =?us-ascii?Q?IWft2dmK3oRBBksJJplR51j7G1CJKlJl4ecOZOQjQwGUMFIQgF2qeDAV01IK?=
 =?us-ascii?Q?Oq40g6GUC/HxUGlyww4qvKZWJxdHupiGWEZDD4xKJEMeWVFFwtpbfFAYbL5j?=
 =?us-ascii?Q?0aE6hdv65M3b3DyFHQ4NbVp+/475seZuVBdhyGyTOII8CRaekrzRf4V6da0F?=
 =?us-ascii?Q?J+h0tqkZxd0JNBn60pEDn5mjpndrl2sTeayLGiMWaX6gAOoclcupNs6lhfYg?=
 =?us-ascii?Q?WdhDmQdnW3b/eJKkrdH2JlMTQOoFUjeqwGi/6nm8VhK1Ddmu1796RR7zX+HP?=
 =?us-ascii?Q?ZpVcQye3f81DVqPBvgqA6ZuP3qLdnEIqwXO04blGEEW9XnLtMUSoPTVDDv1R?=
 =?us-ascii?Q?OLrctk5GU8iqy8/1A06SU4UzG2z0/KKk6Yk8bEOVqLKc1yAp5bDLyHEwimcp?=
 =?us-ascii?Q?nphmInrGn9H+KvYodtNgmVIR6/vAlWP4QxLWyVMuQ6Cd0+WXPHs/qoIha3yg?=
 =?us-ascii?Q?uXz57ctvnS0Akeys0ayVr5SB9DQpTcVGeLgromZ5Lwt8mUj03OYEU1/PsODR?=
 =?us-ascii?Q?trR7TNV/e3AIOoBUO+uWV0djHnX7hu5Kh0phCcVEbOKTpmcwooAikm6BT/I9?=
 =?us-ascii?Q?ny4SMUWmCyDjCcUMo17WjvsiOqF6lNMdQJUgJ3Ku?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d2e475e-4e6e-488e-39d9-08dce1135bbf
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 05:47:24.5168 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QyXgcD8BDLSNM3Yptg+rkqMf+6VWUtUFSbTHqSkPZTeYBOh38QaTb10Jczqp6+YVkBNx/7tHdFCgDsj9DQiZew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6805
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

The memory of priv and plat are leaked if max_bus_width is wrong.

Signed-off-by: Ye Li <ye.li@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/mmc/fsl_esdhc_imx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/fsl_esdhc_imx.c b/drivers/mmc/fsl_esdhc_imx.c
index e371b32d2a3..2413bafc32f 100644
--- a/drivers/mmc/fsl_esdhc_imx.c
+++ b/drivers/mmc/fsl_esdhc_imx.c
@@ -1328,6 +1328,8 @@ int fsl_esdhc_initialize(struct bd_info *bis, struct fsl_esdhc_cfg *cfg)
 		break;
 	default:
 		printf("invalid max bus width %u\n", cfg->max_bus_width);
+		free(plat);
+		free(priv);
 		return -EINVAL;
 	}
 
-- 
2.35.3

