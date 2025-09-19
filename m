Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB65FCAC59A
	for <u-boot@archiver.kernel.org>; Fri, 19 Sep 2025 14:47:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FD3283314;
	Fri, 19 Sep 2025 16:47:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="csR+umvh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2AAA801DD; Fri, 19 Sep 2025 09:46:15 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8DF0182C84
 for <u-boot@lists.denx.de>; Fri, 19 Sep 2025 09:46:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OgxhGusJM3OPPQFLspnWpoeiI3qYwciWLUbPkUTGoltUznfftJqjFWgqQLGfoKKOtKc61G2IBZRoQkqxffOEkeytWnOwtFu+Joh/aXtVnmiPUvdGvZR5dRmTsMLli6kjhFd3VN2vVTqFSCCOIVZ1frlvQsg+CTtgV3NYspt7rl8h2tqEE1OFBmnqMQoNqTy/5GrEgtM8WUMLFNcQi7mLPRAki4jeayw4/qPXIxUNSKqyoOo/46BuVjU321No8sosaxymqlsSOX3nM+TCMBGavsvUYNj/gELQnDhRfbSHujF8GjxJBaIyBhGZ0fJSy9S6Sb1zzvpuTWyjX2Sw2pnjkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uh5EeyS9GuLFYckG84rSxy8Fz9JCZ3ugew7fF817Ib8=;
 b=PZKz9BeFtGXXd+53tyoiJcZTKZ9/5ILVdzi/dhk5eMsBcjqxAtv4FruPf5CsmC7HeqCFurk7ePik79/yXVTVgbNLo2QBvKBe5nY366ik3GPf4OjlJlRbnuHm61FLN7HF+BbfiGxpGjv/vMucbIklcwe58srznM+phSsjU+zALMGTcT1O9FWiTv9X4o4pJ2oRmODFZPESLG46b1q32FowLJhCXId2SSpclUPostMCXBUz5QHfqMrSnTbzsiBD3gKk1ghJzQOD44oGqCc0g1kyGUjknSpnNZdkikYuhc0Qx3Scxbc9Z+rEw1bWjSBIWTIeYyfJ9a0XCl/G+xfSNrrhFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uh5EeyS9GuLFYckG84rSxy8Fz9JCZ3ugew7fF817Ib8=;
 b=csR+umvhfTrLKlm9AHvmallIMqzX0yAzjpIdN6CZqPhifV4hio9lIeP82vXG35a6NN9kFh06Gqohzj3J2YJrVWwHgY1VIqccJERnLu22l++ZBKSNH8j3hF2wDunDxwzgm99V70FX8qzwUjTmtlNNPv/1o46g3yXhzqN1iP7Vl/ioslls8D7fMRTixh5e7obb8iIiZazBxtbhFSmlZz22Rf8lH+Hz4sF0kE6lGb76AasPFSLH1+6yeBhSjb++Ef9T0sE9cP9D26Xs2dhclU6bCYbZRUTxHPLWTUq0urjLs01SbHcSvSTmLj/6lHEMpdXG62+yseVsfMMBymLE1IWzSQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DU2PR04MB8792.eurprd04.prod.outlook.com (2603:10a6:10:2e3::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.16; Fri, 19 Sep
 2025 07:46:11 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9137.015; Fri, 19 Sep 2025
 07:46:10 +0000
Date: Fri, 19 Sep 2025 16:57:51 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Ye Li <ye.li@nxp.com>
Cc: u-boot@lists.denx.de, festevam@gmail.com, peng.fan@nxp.com,
 uboot-imx@nxp.com, alice.guo@nxp.com, ye.li@oss.nxp.com
Subject: Re: [PATCH] imx: imx8ulp: Call DM post init function for init_r phase
Message-ID: <20250919085751.GI9196@nxa18884-linux.ap.freescale.net>
References: <20250919065834.1497068-1-ye.li@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250919065834.1497068-1-ye.li@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI2PR02CA0020.apcprd02.prod.outlook.com
 (2603:1096:4:195::7) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DU2PR04MB8792:EE_
X-MS-Office365-Filtering-Correlation-Id: db674fec-a941-4283-1e28-08ddf75099d0
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|19092799006|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?l3Ay7/s0gbql8ci22zKgc0kzXdzqWS9GRnzfdzsItcegst8YjOxJ3Pa/P3+e?=
 =?us-ascii?Q?mwT59DkPB7rfOYQU+SzOVHURVsCQVFbBztd1TwVdyB2DpjIP288WeJAtQCdG?=
 =?us-ascii?Q?EcDxowvtqjYndpYxCSrhimZ2CuEsol9coNkqyqpJrpQAalZFQ19GN4ugUeMB?=
 =?us-ascii?Q?INXs4Ug/jLDHXmbaAqMiiG2WhVDDN6aCjR06gB1c+TwPCKxwIwoCiRyIu6Bs?=
 =?us-ascii?Q?pv4ILSA1lMziiCcLofXPKVe1fUyiOCOt00wqK/zGUy7ocjWxGMhrs3+bppPm?=
 =?us-ascii?Q?flj704Lh/aw/dgEuL8SB7rFPgtTerK9zJDOhjgo6vxIilm/jX2AtKlgmBCjt?=
 =?us-ascii?Q?vlCxjPj3SoLoGZ6kV+3vyoisCBaSBlVgFPY0IR5u101GP01sN+Eye2/tDF06?=
 =?us-ascii?Q?1r2FdCkYSfLcLcTEA2FdVUBXdHORy/2v6ovaTIPnD2QIXVq8vWsTjWu6xRLR?=
 =?us-ascii?Q?txe0oeQ9l4XnoXTxtnBxA1C/zb8cUxoH0L46dAOn8NvZHwRX4aNhsOw7d6/F?=
 =?us-ascii?Q?Q8kl4xvU6Nkw+Yrzl7YoRVk7dC3g9zbpBUYHsjtvU+wAOGyHj9/DW0IY7a6T?=
 =?us-ascii?Q?fUzJia+rwv7RQgkv8hNMFpKSaG7DhF4Avc7DLEh5migw4Z4+mFcBp1/buctZ?=
 =?us-ascii?Q?/Jo4LbNljc7nU0jgxz9Q7MK+PCTr1MJ3rdfkfHi/zvYPsraPdx9v2mEDOdi6?=
 =?us-ascii?Q?JV63bSLxSRyP8dRUf44Bb5BLsGhmSUSXS8zVwDsqWOHo9nEY2lsqKIkd1VWz?=
 =?us-ascii?Q?lmPrfTGSGBfVhBCOHs9DBibLgUxjm8G1mCFSGGPQVffAqQrLrS3bjIEfxrqh?=
 =?us-ascii?Q?ZpvQPzQffBEtLUsn4J6LfSqDb/6bKZMMF15Z+i8evE1dZJQmWVR2O0hpcN44?=
 =?us-ascii?Q?GlHuLUqVa315t85G9T0+o/ID7L0EvPq9hz2hmH4HmB6S+SEiLeYE0MFMk86A?=
 =?us-ascii?Q?WRNgKn4Rh5NPFaZCw9U3SzhS2OTYPyfb8BLk0PHM8e7hJbAXbSgGAd6AhEte?=
 =?us-ascii?Q?Jgp6djUSB+SG9PrH2jdb9Yk+99fv0CTKKL68xkZvIvqlEtwZiMGmGjSGGmSf?=
 =?us-ascii?Q?ULwjyHJ1f6f5yv+tpKY2JxKSOMANGsaVNHgK1Owf5AhVcQ1t8o8aZoX1bAaD?=
 =?us-ascii?Q?BtiS2AIPhwJeDSQpxcflLCXvgr+X6NzW1uoCWC4DpN6ikMtPW8k1nqtEq62g?=
 =?us-ascii?Q?Apv8ZOiv0iys+YsjsRJRPgkwU9lbCcMptk4qo96bjnDz7yC5Wk4NVmE3Jlgn?=
 =?us-ascii?Q?Tq1phZh+2m+R3YabUQ/7YN7d1UWl3gJIUtIgRsKDL5qfx4ABFUIRq/+jKWqT?=
 =?us-ascii?Q?HYs4bYNba9/mAgyvwM8izM6FaN3cP6LJylIb8wDu9XtvhgXoSL6o/W7CvPZ9?=
 =?us-ascii?Q?mG4P7tzdGRkU+PKkl6lYlBhweI/jTpHhC9xQGQBUkX2pTHAL7uR2fllKQHef?=
 =?us-ascii?Q?hckeDHGl2htrPVH4U4EGPAclA4cNnUM1ti3D5pA784D2TZWSEI039A=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(52116014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bnK8FiLte2n7XyJvvyTMgLL56EClU+Nc7vgiTvO5k+bJintCxepf+9JEyMNx?=
 =?us-ascii?Q?Nf8GuYHyHlg0ft5H9uhU6rwZ0J6+LK4wSf1poEIuy9p0dphvQ6m/6Qr8f60o?=
 =?us-ascii?Q?kShCcp3eN57CKBlYeVcwwcRKBTW+1HpI8K+e0csrs/gOD0zRtV8tSP5iUUiQ?=
 =?us-ascii?Q?0UFwhcP5+RcQUj8Vt6ekVbnNIeb6sSZZs7JwV3T3z6zs9gyxszXBoocXrR9n?=
 =?us-ascii?Q?gD7HHhzWR+5Eys/4ahYTScE4jwv5N22U1TQ1ycbt3Vmgo9+kdoToGIFHbEdY?=
 =?us-ascii?Q?EwhNNH5X5XaxBYJV7Wh7tlAUMJy8vTcAFDxAQ7hiBqEwHdVo8sonof76NQi1?=
 =?us-ascii?Q?ywqMD53bTmVNAfuyzjgV/W1u6od9AV1hH32fEls6TjHYRoTLog6ebOO9TkfP?=
 =?us-ascii?Q?Omy9UH48A4sQCKsJ9kdOC0pZCCJKP7SY3SiffWdFoO8nooUQ9R436H3j+iRI?=
 =?us-ascii?Q?E5bN/tWiEinqc7nK3uETV8O0Jttkqm1c9rghxVUWy6CnaUHC0Pe/mXffaluK?=
 =?us-ascii?Q?FPlji8jcsZQucKQO3uyEQ2wpTDUY9soA/N6Ns8IX6828XwiFH/4+qjBGkVN6?=
 =?us-ascii?Q?cTsydc11J2AYmALecg0EVa8A/XshTDn5vnC/rnx2C2OWztMuH3hYv38GarbP?=
 =?us-ascii?Q?6kn3ksNEWnWRKGq80u4kKjlaVok2oCenzjxfgtuygUw6NPz67CzEmIs9wIgf?=
 =?us-ascii?Q?0JYgiM+k/xmi4cpeliRuvmmYZrcjv9G33+kNhkuSJREx3CWP9MLg7BarFVm0?=
 =?us-ascii?Q?sebmz4TzV9f6lX5saSx1eDqUtBBQu2Ttva1md3mYbT+TO61yHzHvXRkuOB/G?=
 =?us-ascii?Q?SpD7olYgVGSzBBo9JjMX4J52+qQCPvpCEofhPIBma6yXYMcnd3t/ObtQKz49?=
 =?us-ascii?Q?T9WsWa+xWGu1xhZTVjQpz9QQfA+YSYiAl2186baGjLz4QQCG/6iP42ne8ldb?=
 =?us-ascii?Q?QVBvbQQ2Mp/8aJ3I9lb1HL8Adbl8NGG8x7PWch0tK08zIDtZtXNJQaOw9Sbx?=
 =?us-ascii?Q?/+IskQLzh+29imz46doS9UtwFgIUUtjQTWHYL5ccIcEln0wFjBIPwkaCvlQt?=
 =?us-ascii?Q?TmNooUMmDMtdm5rRmQ/pADdRgbaP9QlTp1ZbSHtUD5mM1YTL4TKPbOs5q8nm?=
 =?us-ascii?Q?3e61H7GPxJWn13A9bNWadKSMyfbuEFWWwXasgewU3qCgydx8n0qavIExwoZ3?=
 =?us-ascii?Q?1LhwbeMh14hcRFnrFMC/d+E7ixeMctRr9cGZm9UbS7RwSzqrR5YGfj7wI5mz?=
 =?us-ascii?Q?nMiomrpxU24/GJJSbkoylTHgaZ7RGXhtgBYnAz/KU3oIeauX9iRY7Cdcn+0Y?=
 =?us-ascii?Q?gWdZ4TGtq/cDRYWFcIe5+bgk8T8VkmG9KC/S4MPxpDiWHAJTKuFJbZZhJK/1?=
 =?us-ascii?Q?OsVFrDSBRC+208Yxxnt8MX+GwhPHWgWg0BNAf1A66WryBcNPUa2BLTN+yn7S?=
 =?us-ascii?Q?BYH1aIahxwUecyNjT6N8skt4j7clE41Y6aq2SoVuLeRUjhlMKjfX1XCPgd0x?=
 =?us-ascii?Q?2WUQbypAHEnHF97f7KBdKJ+/bHJ9rAt4YDiz/79XOcGCGdprOqw+KOOSArI7?=
 =?us-ascii?Q?DFgFJfCC1WZTV8PoKFF7iuUv2Z4PC5GCTE78K37q?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db674fec-a941-4283-1e28-08ddf75099d0
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 07:46:10.8812 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rYzFgm6qZis6vyQqXTDRBXU+EihI6tjTMCPIe9R1+zEI5untyg1byqeZS+Dx3Z59MlDCSRZBIS/U9n7MjY3h0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8792
X-Mailman-Approved-At: Fri, 19 Sep 2025 16:47:28 +0200
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

On Fri, Sep 19, 2025 at 02:58:32PM +0800, Ye Li wrote:
>The ELE MU driver needs to be probed at init_r phase as well because
>some ELE APIs will be called.
>
>Signed-off-by: Ye Li <ye.li@nxp.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
