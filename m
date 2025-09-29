Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D148ACAC5B0
	for <u-boot@archiver.kernel.org>; Mon, 29 Sep 2025 06:50:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E8C9835B9;
	Mon, 29 Sep 2025 08:49:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="V89C2aFs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D68780819; Mon, 29 Sep 2025 03:53:06 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4D28800B1
 for <u-boot@lists.denx.de>; Mon, 29 Sep 2025 03:53:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pb6KE6zsMtwhfsaiXjeIg51gBKmr/lONKFHsFQzxr3TnhVF6ikp23+Ts8F/a4gHkddtyDFXSHCMwwCtBRF2BJvksH8G275F4YFxgPtnsch9SuywfGsXzytu7QUfd8hvCrWieh4JJzkfbfmzXpZquIKWfesNFz5zeaPq0FtPtmrzFa85Qi1bMbx1un2Rm0nr380ZCIA8cLuD1reOzOEnq+LHDHPM47+J1KKIvmd3qyd8J8bi8wPbaRSiGlXSf2d4uV2W+yV0ikRvIfhKAozuAWlaKFQ4CKiqSSKjIzvMcHEGDBnSaAhBPldAO461VJFzl553+r44RCNKl6KchIKnE1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0d/rKJeMKCm4IPvEAYsri3dSCa3Y5YVly6n06GZS080=;
 b=sEn1Cn9IkQhT/rHrYWU3Tk5+syMYL/2reA4D3F1IFBUSgTjClajxEoU38Rhq7cCcSydSKeBxjp2NCRSQWQr8TBdTKltsY5FqvVdVOcNSrNUlx441+X5gvNp1CsZs/TMh+7k1d5HGEC+3331pjgM9J2vwlCNGYfN6SyWKAZpSA9uomoodC2H7DNvcxIWI/3JxGSj+GPyoJkF7P9MM1ix+zocgPXQRVpz+spGWYTTHgr3jQxJyGoaFNY7hkUZOyiFVNm3kDAFUSwuS7O29i559AF8MwalKjRaVfMjStFRZCyIvbQb1DFgiCt9OYL9K0B03QlmvEYn4CUmoTNKTwEKUpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0d/rKJeMKCm4IPvEAYsri3dSCa3Y5YVly6n06GZS080=;
 b=V89C2aFsQJhncPcSGBSO2sGDmDvd5UOQ4JSCUZIc/gyYg+XsongspCc/pxvk/7Zb6Hl+D/XWiT1Flv7QcE7loyGb5dnUlKJRPM6JlxDcYo7LfWMyUeotr1G2rUUpZiZOJrMVeJwrgB6AB1fI9Uqynpr0z1+9CNx0aev306ywA+K7KNB9N0FLi8EyzUz3Jt4T1gC6b3TUEYLAbJlxjk2dbG3kMdcA/v1VjGvKaWJk2Qcl6PZgIzgcoySlUThJTZobMeZqAhNAH1RwPBQDfWvV4El4v2V8/aYljTg9WuF/qFiqj+jUezLxKz7cRBFdhOETcEMULbKWBQSuQ6V45NU7pA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by MRWPR04MB11520.eurprd04.prod.outlook.com (2603:10a6:501:75::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.15; Mon, 29 Sep
 2025 01:53:01 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9160.015; Mon, 29 Sep 2025
 01:53:01 +0000
Date: Mon, 29 Sep 2025 11:04:55 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Tanmay Kathpalia <tanmay.kathpalia@altera.com>, u-boot@lists.denx.de,
 peng.fan@nxp.com, jh80.chung@samsung.com, trini@konsulko.com,
 kuanlim.lee@starfivetech.com, weiliang.lim@starfivetech.com,
 yuklin.soo@starfivetech.com, e@freeshell.de, marex@denx.de,
 tien.fong.chee@altera.com
Subject: Re: [PATCH] mmc: sdhci-cadence6: Fix DT property value endianness
Message-ID: <20250929030455.GH4184@nxa18884-linux.ap.freescale.net>
References: <20250928183816.25623-1-tanmay.kathpalia@altera.com>
 <f5d9836b-2b88-4903-938c-fb72b317bd0d@mailbox.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5d9836b-2b88-4903-938c-fb72b317bd0d@mailbox.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI2PR01CA0017.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::19) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|MRWPR04MB11520:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b9dba80-a5d4-4803-94db-08ddfefaebeb
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|19092799006|7416014|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WAg3KPg/K/Ns+i/OBVey9fiohB6FDT8S4lJwgqn4/v0qCzDnYD9D/KTQ0nFK?=
 =?us-ascii?Q?iV9iM1kCMokqdwzCxpQiOYyMlPnRxDyAtFEzWjqemsr9D9kBWqE/btYYyPgv?=
 =?us-ascii?Q?n4Vzsj72oVmV45JEl1+O2J097vrs71YWvuAPfTaUvUn37kXSID2z9h4VjZlR?=
 =?us-ascii?Q?8nT447O/WvQrUQfa+fNXSKmxV/rjEKqpSb2GwS2Rqg5OTkYju8eI6loM/0/e?=
 =?us-ascii?Q?6vdMOQWnKo1I+YqKd3HNlmMQZCl8thcfifLXPQJAF8jo4JpB4BpSkGfITWKk?=
 =?us-ascii?Q?8Y8mlVRsEuEnqUwfSwWuktF9XvgMUwe739zMxURbXNIlIm+YBCS1D1A2NMV/?=
 =?us-ascii?Q?e7/WWlkcQEWt6o/PKqSlvQ4dHCVE08HfbnhmvbF7YpDW6QeayeXJjuOyHc1U?=
 =?us-ascii?Q?WFM/SLnLa/PdW9GYPrjnMxZG3vasGzbnTPi+/mImytsHnulj/4slvoEVwJuy?=
 =?us-ascii?Q?/4y1BfMHGIEIzrdmg7J3bqTmkW8ZTRW5uU4i1MF5GeRp9cabH+abtzKqRov/?=
 =?us-ascii?Q?z5BNaFnhod2dwOwRV+zMJggKrHFSKQvVyFDQSXgtGOb0gPvxKuZQ7yQfgOnh?=
 =?us-ascii?Q?PBhM7LtgG+fcwlnRM0t1RTxHMO+S626FlPrO/STkOKzr1bNCxjBuUhImR69q?=
 =?us-ascii?Q?XqzwUrtHdu3geYi/MFL3YZwSRAkyCe0tYWnSDNVdu6ZNb+bnHDQdWXWlEtMe?=
 =?us-ascii?Q?gD11Jdz81TjvR0v+yY/xtFKxa3AiwqlOfM0OX7IgTx1BDFOs7/2KTrPC7jQw?=
 =?us-ascii?Q?QW+ZqVEryErKrcLPMhWe+5a5uXVE08nznAVjj0ga7HYbAunytX7sgpuCjgOe?=
 =?us-ascii?Q?Ednr5BN5pAiqndCtHRmGLzPiz4uu4N8EIqpKKql3mArUqyLrf0GhmDTDI9eT?=
 =?us-ascii?Q?lmcLU/aPxKD7FNj9LEC+4vsEpTH2l//+F8qn3uY1WqARKHBEHV1as0qe6WqS?=
 =?us-ascii?Q?fo6zFqSGMv+f6oR0GB8z6yzZibt6HydL2UyjJ8eD7eyijg7pF12FqFA6mjlv?=
 =?us-ascii?Q?uvV+q4KnqhrJCvMcNZRfWyV4eBOeHPetDmEPNCK8HKoa2xqBo4eUJcmFLRw6?=
 =?us-ascii?Q?0LXPwc+Wj7WoDWDoKm7+Wg9aUjOL8VOCIDLirxcWDELzXA9OA/Jqfg0U1/Ur?=
 =?us-ascii?Q?zr3mkeDwKH41mdSJZt+oGh8swkdZzjmLLPG3Va+o3NDS8LjHr5ESc75iK+Kl?=
 =?us-ascii?Q?8xIPZlhDbAJA172gJe8sQOk6bRsa2qyQwyeu3dUFDF9WKmIRp5Mps5KdozC0?=
 =?us-ascii?Q?XrdYjoZJRtQ2vj+dcSjbzaFjYFzo0dhLpIafzLM1Fo0gzOtsAmXcFcSMvmz+?=
 =?us-ascii?Q?yJBSKZVXZiJx8BY+MXN/eTKqD1h/mNTpA7Xn7yP1vcCjMvuVqRXD3wevRiAM?=
 =?us-ascii?Q?sDl244DckDm9DUhNSg3e02Ijx5HLdQiukNGxsByWr++kYBCiALz24KjtqeWw?=
 =?us-ascii?Q?hX+q/YqQw7IgCMYtRXomZLtPBzb7WBdCsuHxLe/SNd47FyZEaI8L0+hXLae3?=
 =?us-ascii?Q?prZ4JVkbX/ggHlyKwn4gAmbdNTkpXY1rrAk5?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(19092799006)(7416014)(376014)(52116014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mtdi4g4TryK5KCvLVRCQMM4LZQL2qeJ7AMyqYmp7VyCCs6afcdl4NI0NdzIw?=
 =?us-ascii?Q?y9uDBsF7HadwoTmkHj23G8kOSpdLZNCeJJp6bzJIPKdfRezpvUF9yCybB5OL?=
 =?us-ascii?Q?Rl7pCm40yNehjcs6YRREOZtdBXky0QmkOzGJbWFBwI2gvFR2VRIkfJV73GGn?=
 =?us-ascii?Q?AY7x0WT1Nwjo8nLZaTvGSZtIFRL2VvTBAc6Wj6NH97dTVISIqvf4f8MIeuQI?=
 =?us-ascii?Q?8q911H/m9+3ueGmpZ+f55StVc+D1teb0X8fw2queTeWJWin3qukC6wb41tLf?=
 =?us-ascii?Q?DyVY+COjdvbbR+LnhnEFXf+wUE9WznZ94HkwhzZ/Enh59iicC5UuK5JNEYVB?=
 =?us-ascii?Q?56nJZ2JGIw0wZOr0TFcP3L7tIzYkuhPoZp/rIYQIPdw5LkPrK9YrfBCLbXYD?=
 =?us-ascii?Q?dRUFrKjbP3k9nct0zC3Ht99I1OUj/zoSwsD0ULP5JE21kQd75yI7Qf0Xtj42?=
 =?us-ascii?Q?UiopSLbhizx169xZ/TuqcLTh+o8iljsFUQI2IzIOoqfO4fg9hUGK0FUvQjE/?=
 =?us-ascii?Q?gRpfyoMMLokqJej+eUVRZPXi6EovuMGYD7NOfXf2OqDLEQvM83LUothTSAzw?=
 =?us-ascii?Q?q/nLwNDB41omrk9vu7yfYjavr41m2ZJ7oRaKEP0+5g36Dze74y8ZAl0+xs9v?=
 =?us-ascii?Q?giBzoRJSw0bK1eRgBQLYudxZECoY4tJN4TxxuPVAQcd9O5Rt21wzRDIKr0O7?=
 =?us-ascii?Q?dOWalESh+RPna1Zy+s2r8IujOxEvxqNHERBqiud4vesamzzC6dLwC/J1KGTS?=
 =?us-ascii?Q?ZzIoIL+o9AkFFRIOlG1OCihMITzaENJj4aEHOT1PFGBlVrwOtyfxotUMm3g5?=
 =?us-ascii?Q?9kqs6/nN35NeMZWZv4Jue8bv1/QF+xulnrSOzj8VTYc4s3u0f84k6fJKqL7/?=
 =?us-ascii?Q?NTJuzw8CDP8OwHrrRE/AqYiMO0SQmIbf/oCgxZZtpXHtoFkErBayONh9b94q?=
 =?us-ascii?Q?/QK/BIDl47qL1iIkut4nq31D7a2T1jmctctq3PQqpqkl33Ux4okG2C4jTr8e?=
 =?us-ascii?Q?vYuG4kvBCNUtewAoBWAEN8o0tYcmrugCPW3jfnh0fbrgdw/0Zd2O16pi1loc?=
 =?us-ascii?Q?DZZKNo67lcGeU50Z3r7tkmhe+2yF1F5MQ6HmVjgqOUKeboRvhvdbp2sNQQv0?=
 =?us-ascii?Q?0GUhdbWC9W8wCB3ohK8gjB9kY3zDFMYr5QKyJrRjla2xWGmYvXYwRF2kDGK8?=
 =?us-ascii?Q?E/tQOnOs82TtQhysFdjDbocO0MRF20Qgn4on1nFyGc0UlIzShlAkrzM9/gjr?=
 =?us-ascii?Q?vTeLFiRWheODAGnjriYZZnn6/9HxrJzUekjmr8IJeMsoUJkE9ebpLXamEowq?=
 =?us-ascii?Q?fmpsp4Z1B6E/2mGq/Acl7OL/oEfSDuqiKxeLTU2Sl0fXtQ8f9agYwRDRSp6u?=
 =?us-ascii?Q?z3PxlbbljqQrkTcxCLQbSG/nfXm1qFnlPlzPC+crCeNKk5cyjBCdzdN/Tqd/?=
 =?us-ascii?Q?U114E6LCpJ8LuVPT3Qm/UJ+QaaOORkDplcbooZkIAQQYmFB9+x7jNaALNfDG?=
 =?us-ascii?Q?yUsK+RpFV9t0Ce3iKgTimSAkgMf4sGrMJtpCY90WCTSIjIwQ4XaNEoTC4OAh?=
 =?us-ascii?Q?GaRTluqk5OTxHDX9Z25dAh/XP+iv4Jolb8cX6rgA?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b9dba80-a5d4-4803-94db-08ddfefaebeb
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2025 01:53:01.3463 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oA3cMKf9camJiCWppseRS76sC/0wNDKc8xYSYyRKR0KLovhh/to3BXox8IpA6XJMSjg2uvXwFOZ3zs1E8hoZIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRWPR04MB11520
X-Mailman-Approved-At: Mon, 29 Sep 2025 08:49:07 +0200
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

On Sun, Sep 28, 2025 at 08:54:44PM +0200, Marek Vasut wrote:
>On 9/28/25 8:38 PM, Tanmay Kathpalia wrote:
>> Convert device tree property value to CPU endianness using
>> fdt32_to_cpu(). This prevents incorrect values on platforms
>> with differing endianness.
>> 
>> Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
>> ---
>>   drivers/mmc/sdhci-cadence6.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>> 
>> diff --git a/drivers/mmc/sdhci-cadence6.c b/drivers/mmc/sdhci-cadence6.c
>> index 9a92b8437a6..6f60fee6df4 100644
>> --- a/drivers/mmc/sdhci-cadence6.c
>> +++ b/drivers/mmc/sdhci-cadence6.c
>> @@ -220,14 +220,14 @@ int sdhci_cdns6_phy_adj(struct udevice *dev, struct sdhci_cdns_plat *plat, u32 m
>>   		prop = fdt_getprop(gd->fdt_blob, dev_of_offset(dev),
>>   				   sdhci_cdns6_phy_cfgs[i].property, NULL);
>Use dev_read_u32_default() or some such function from drivers/core/read.c ,
>that should greatly simplify this code.

+ 1

Thanks,
Peng
