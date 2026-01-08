Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5B95D185F8
	for <u-boot@archiver.kernel.org>; Thu,  8 Jan 2026 13:38:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AEFE384246;
	Thu,  8 Jan 2026 14:33:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="THyJKfrJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 25F1A839A5; Thu,  8 Jan 2026 14:30:44 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C368A83980
 for <u-boot@lists.denx.de>; Thu,  8 Jan 2026 14:30:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c/rYEnR+OOKOxOX/mqex0v6/DsI4QVucaQ64VLy/7JNPmy0HsJ2mkVRHZBiyoc8SjbutMToVpFEybFm2vc/82wqPacQ9s9h1E9U9rvtYOoUOhPklH9mc10s8Rs6/I5nCsKerA15mhmr/R+dL9vxff1rweVAHbiQxRU1XzjIK/viCczZJcNhcm5qFoVIwTcirbrI19Qx6M1Qdm/BTvsywXh3zDfxCKZT8bm8BtKubrBn9vBlULUef4yORYn+Gd7VeTIcbSs4n2PpbRE50yp5vywdMAqxa6VIwnSxr304+Ba01y1rfRFueUD/2YxtAMvVdh2eW1Sua1TGEhW7jvvf9gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ahcvldcSPgB9j4SzedEG+7bNT4Wol9Pm7wPq1AAuOeM=;
 b=lOG8zg9z/uuslGkaz/LDQQD3xM52+jUqsfOMF5COoS7j6SrGAWn4TnrLEb7h2KNQ+5P+cIH0Cys61B/kjtWiWgTK2yFBIbcBCt6sOSTLaS/Dk8Hl9iikDOf66DelQn97pda4NfDoAUyh52khdejV66veibn15zBJX1YabKZppj9TlwbDpyPVCCBPhOQSfTHU8cRdVo0NkTR6MLSGkK5a+bOEeFTSm3NL5YoG2KcnXcmtj/XPh5GASuoZuQgvqBH448EDLqVE6ij1v1siMH13So9GAlK9aZvVDbAlrkt3ON0h7kDU0jjuiYI7OVDQekyvZC2ZXVqHijju2S3ckSIC2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ahcvldcSPgB9j4SzedEG+7bNT4Wol9Pm7wPq1AAuOeM=;
 b=THyJKfrJkL2zSHqHiOZ0MnFyY8uxEU7ZmOOqv8Kx2jj7fZ17vCingmO6wPGMxKDhUh4dv5yWfD+mBHIQ+1wTldP+CZSc6FR6hpD/rxzXbySJxS5KHJRn5WggkeddeU07CHeCaKnaI4GuZEeP/SEUCzMIKxrOeO8xF0fpY9B8P3RJoyW1VJI49Pbg08Bis2PM9qnncyHbndJUVm7fuqXIrFJVGlFlGbao9pO4IQtm80KPfwXVr0wqtiV+hLoMpi5EjekNzFdLfBj3CRDWPTrJjlQKRZiJUmM9pbrxU8svdKHPYuw5PV3k7u5IlFEEI3JV/Yj/btVYxzYp+ByQQpfSGw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
 by AM7PR04MB7064.eurprd04.prod.outlook.com (2603:10a6:20b:118::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 13:30:37 +0000
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197]) by DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197%4]) with mapi id 15.20.9499.003; Thu, 8 Jan 2026
 13:30:36 +0000
Date: Thu, 8 Jan 2026 21:32:09 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Christoph Stoidner <c.stoidner@phytec.de>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] mmc: Fix missing 1 ms delay after mmc power up
Message-ID: <aV+x2ThABNMJnkov@shlinux89>
References: <20251031145951.535376-1-c.stoidner@phytec.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251031145951.535376-1-c.stoidner@phytec.de>
X-ClientProxiedBy: SG2PR04CA0170.apcprd04.prod.outlook.com (2603:1096:4::32)
 To DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8461:EE_|AM7PR04MB7064:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a187324-5bc6-4d84-3500-08de4eba1b3d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|19092799006|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ajnHfYDUeE86W8Nl+a0Qy5h09x4QVIRtc1EZ+fgnK+m2MCmWEGufMbr6pp2/?=
 =?us-ascii?Q?vUSZfc+uswUHL8W5Hp6nOOWKI7MEddra/Od1odLbddsjuQZg1qnyC13XzikH?=
 =?us-ascii?Q?NFHskPmjqRDPNk6w0cciRPmWJ4idCOL/LEvvyncTXI4MWMoAvl4y50rmvAQ0?=
 =?us-ascii?Q?m8kQafOSLiCdexJ6f4+0hrLS00L4Z3ZTbY/Bqi1mjMM/JPwYde6Uuja8+xgm?=
 =?us-ascii?Q?BzeMzRCkXCVna/WaFP4HkB5lMR6pOym7WUXg1Xqekn72gSgU+/KwViVf17s0?=
 =?us-ascii?Q?RxjOu1TG1y8LDvroo6eMK9tY56FpYcfd7WRXsTwp+v4AQaEGpIopdKHC8ZQx?=
 =?us-ascii?Q?P33H7vSVnbVMQGlzVA0LiDA/JXys9AtSGXv+dgDBFA0hIqQSk5D6+wlffnUV?=
 =?us-ascii?Q?zoVh9ee2Wuum62/NArpTeaMrUxm3MhtnvlSDFoNAprF738HbtI6SFXtUC0gc?=
 =?us-ascii?Q?aDlv+DU8N8E55mE3IjF5N54g5E8W9Vk7RiKvd4c4A5iY5DdHwDbUWYjwMXSV?=
 =?us-ascii?Q?86cmf1V3z63JDNVeXuIgK3hAN+jB9PrXT+6H40KPRr/vkIrhX2HQ4u2pCXGK?=
 =?us-ascii?Q?KmvQO6w+o+UP8tDU5uTki8UpDEkvCPuIyp9MyXnmZRRfF+vTilI0zNC7SdMZ?=
 =?us-ascii?Q?D/MQh21YeKjAs+YjaQA8F24uvjkNZr+bfUjRo0rlwNPOgJE/XhnELF30c1ke?=
 =?us-ascii?Q?yOe8JMlgvjm1Xu7klrR7r6JRvjfDbHupwwDklde5WSubX7QGkspNQuDuKGrB?=
 =?us-ascii?Q?RhGr8QZq+ZyQ8wRBh98Tt5zsF/3ruQ0hZcITc6YePsdTdfGsZ4QPo7Nz0Xb5?=
 =?us-ascii?Q?98ZsZKbcWrLNMJsgICAmWwLNi9WJtm/4wxgPLyD5rTWXFLfYW79SnhbTFCiw?=
 =?us-ascii?Q?zz1jZ2qjYn0EzLKeDU4j9uCcvoyOhGDGA8zRTdQpPPcqVbROyqIOhPekJ6eQ?=
 =?us-ascii?Q?Zdw9onriC7buxAwEHdfIMM0h2ggKxoDaFNstPbWULdYq036lTZRQTVXinIxD?=
 =?us-ascii?Q?ojR5Q2GqmVSe6RUBEpYcflrDerUHlBou9RUrEbRl9bexyolmiJTllIkKG5Tx?=
 =?us-ascii?Q?dGzWlMN7gKvTVxqO0aLm4JUUo87t5FA4pJFEYDbCAcMlL1o65T6PwFbur+ji?=
 =?us-ascii?Q?nWB5zILLHzlZrW9wSmqSpBxcZFL3ESoo/65AqM2SVCxhRa6FhjkLJfOL7zIE?=
 =?us-ascii?Q?JnBR77Gq1aAuY/abKbqVsTVWV6jv170iYHpP+fLIbA9YTax1NvzKTxwpaKAs?=
 =?us-ascii?Q?GFOSl/mgVluelXE5oYlu743wlBe7BTpCnfrukXeqPnfZEIpRT6N1TWlkmgWA?=
 =?us-ascii?Q?rCBuUWot0f2CmgjXHc5d4V6iSv3crBf6crJW8MVD8lyvVkpO1sqJHkLuXU3h?=
 =?us-ascii?Q?Od+028A9wfVkoUxSxWctf5mP9OtThOYWXR+eEsZaeYRSJDeWP6GBErkQGwDH?=
 =?us-ascii?Q?fF9mcVjl2W2OlkJTW/3LZaZjnh2buV4CNSOH2eaIRnotjCxxFCoKmFfah3jk?=
 =?us-ascii?Q?pP2hCWY+soKtiV30hb0KUwf0qU0ihqHa+yrZ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB8461.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(19092799006)(7053199007)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3dHtTyR9QAJ1CugIowTQH/jYd2VN8ZAnPVPQg44FR3BoAGQSeJkab3slxkwo?=
 =?us-ascii?Q?ZBl3ezX2P7zt2qELlWFvozSmRvN0dbi4SIkZwsHbVAK0Wo1q47zbkuvvywqB?=
 =?us-ascii?Q?0m+vkB63e9Q+YkZgMwdtG26GizXrgwfrNNZKEsgXdH385OPe+GU7J5pi+1iO?=
 =?us-ascii?Q?R8M9WBwKBcfR/E9eW7ZMMxfWVOOjPyus3fWdjGjXFMlJN+BVFoVj3e6Q9waj?=
 =?us-ascii?Q?TQEdU56jSvsRMdLBESVEbfAGbVfG8r+UztvU0CrB4JvlXR2PtBh7KaVCptnf?=
 =?us-ascii?Q?ahlLKlM4an27dg9ytWNW2pZWr+pQ/OgBPeRZQF9nkFZ8xmdhkuOgEb8PXfka?=
 =?us-ascii?Q?WaOhTYnSEBRS20KjFvmJU+GEioYzVlM//6evcc3cG8JB+w9yfqGPtQf0lN7j?=
 =?us-ascii?Q?/ljok8C8TJnOUIgROPftZdB5vXkjYmheBrsi2/qNbcE0Ssl7STaDUrim/T+h?=
 =?us-ascii?Q?Eza05fN0DdJXvy9UhHASjmu1Dzy2vdLOl+KN9DXPwA8YbiU0WUsyPt3A0VHb?=
 =?us-ascii?Q?6BpOjNo5xOlqB7nqFz7aykH04a6AAVwBwGiPG7VpSszmnAoiSGhRlgRnVRnZ?=
 =?us-ascii?Q?3y55rdzOcAYlNBQkHBeA0iWETIlfJ8MICNNc4oWYkLf1iOv2Y43LVUcPCgkC?=
 =?us-ascii?Q?pktt3O+3IFCXRKez3CFmTRDw7c/HnhyrZlHq3U9UGUE9zCrrpx9qUqR2DcOC?=
 =?us-ascii?Q?A2T2Hgfp0PS0EnJ6zB1Zl49MxiG1pLSuWluu0dzsPXLkQD9xTRnoI3IU+Oxd?=
 =?us-ascii?Q?J8hIfgfAkKWBR8dFKDExQzrWnr0U54Sb9plSM8Dhr4Vo3+J7UvEBkTE9r5mN?=
 =?us-ascii?Q?Ic6m1sEr3ygx8YoGlu+s5a75Ruc5Q3tCAjA+PMAyVmgjcVs6+Hso/uMkwMvy?=
 =?us-ascii?Q?EWRp3ARa/NU1g0GrjahpinnKUWNbZjO+XYgt8uNMamxlrpca0Vv+q+Wd/WXI?=
 =?us-ascii?Q?jV43P5uwmAy0ezOLQ4Gs0LVtxX/roj+uvO75DP3X9OgL5K6l89Q2/G48ymRG?=
 =?us-ascii?Q?z7vNr9q5MP0aXT4SbfEpl8U87NCl9tyE6fMr8yp1cjC8OfA3Pldpj13tE8m0?=
 =?us-ascii?Q?8czsyRRJsdxqsU8f07OMVYB8MKgLd7NuHNLO/P2srjpi9GvwdUkZqOxX4eOp?=
 =?us-ascii?Q?dNq7kJyy+cSYfuflOuT63jYU7O83PQJD+dbZVypg6pu/+LIqK7yRJC//w7Df?=
 =?us-ascii?Q?cN3Ri0fHXn24Zjxd5Rfihf/7cV0gh3JO9JBfYVZcdLaaI0MmuBbmeA+nxi+/?=
 =?us-ascii?Q?L7vMY1L872UvRZhK+8JdYKdG3RqFcRh8uTNLJnrGKk21sTe77T2CdfL9A36T?=
 =?us-ascii?Q?GHGXThrXVc+az7OfvMSEH65CV20rcqwnex/flWVsYbcWuVHwWyGarST9NzkP?=
 =?us-ascii?Q?D1Sx0GEyOm9agVuvIiAd2jZINHMu2kM5euOvA4q/vTGSHLUqIWC+nejWLKFU?=
 =?us-ascii?Q?QL0J4iT57qYCtyVxd1ZSyVYY6a8Dmi3X+KcxDG2/S5QyaOTjaTxVgX1HmKhT?=
 =?us-ascii?Q?1XtIvroz4AfMRYZLdMh0d+WW91zkPtRZ4qxIBZZtXdM02w2mEU/QTimXL5Hx?=
 =?us-ascii?Q?96+VykqiwhhDhgoerF2+qz3i5CPDaH3QfsXtDNej+bFPhMp4bXYfejWgrncK?=
 =?us-ascii?Q?tB7B5O0L4DB86y2iSbZAk69Eivcqv8yDERP08B/JHO+au3NNNe14RLst8UK0?=
 =?us-ascii?Q?QLz0LRhlgtWv32mS9/DIidWeeD3zVCFaUUhBOLSYnjJ3oAgSB6//UbHbCxyb?=
 =?us-ascii?Q?xY02L2zd9w=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a187324-5bc6-4d84-3500-08de4eba1b3d
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8461.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 13:30:36.8437 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ylXIljNCXcUVelg14irgJ4USdQJlVjQSakc5LBtIzCG9KhUInNEyPWVX3X8RpLH5ihKYPHpBGSlYgLm3aKXs8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7064
X-Mailman-Approved-At: Thu, 08 Jan 2026 14:33:28 +0100
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

On Fri, Oct 31, 2025 at 03:59:51PM +0100, Christoph Stoidner wrote:
>mmc/sd specification requires a 1 ms delay (stable supply voltage)
>after vdd was enabled and before issuing first command.
>
>For most sdcard/soc combinations, the missing delay seems to be not a
>problem because the processing time between enabling vdd and the first
>command is often hundreds of microseconds or more. However, in our
>specific case, some sdcards were not detected by u-boot:
>* soc: NXP i.MX 93
>* sdcards: SanDisk Ultra, 64GB micro SDXC 1,
>           MediaRange, 8GB, SDHC
>* measured time between vdd and first command: approx. 784us
>* symptom: both sdcards did not respond at all to first commands,
>           u-boot mmc subsystem ran into timeout and stops to
>           initialize the cards
>
>Signed-off-by: Christoph Stoidner <c.stoidner@phytec.de>
>Cc: Peng Fan <peng.fan@nxp.com>
>Cc: Jaehoon Chung <jh80.chung@samsung.com>
>---

Applied.

Thanks,
Peng
