Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DF5ACFC535
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 10:21:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC92A8902D;
	Mon, 14 Oct 2024 12:21:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="Snt2wYl8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F7BE890B1; Mon, 14 Oct 2024 12:21:44 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2062d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::62d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E42D8904A
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 12:21:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rpl3mZ1fn/oTUqh7TA+8k13WFUyhY1D9I1UE4084JA9W8kpKUcibKa/A/jJmTNhPSbzz/RxZJ4dEC/hZyHv7IwCtQFrz9f/IbR+LL2fyOkSBOZIzQJ4T+IJqfrr9K7KA2Rx09uDGxkTc0qY552Pfum7heXeHPHJvVeEpqylDAO8Ls2Cv/ehu7+CcOBI+y5khT2hScRIm73iVbMbCRtemQi5p3kwvl/dhmx0hq84teQqPBMS6VeDv2q3gtrYBv6QMDqSKqCpl3JoE2crarPaWC+FHK8vb/tOTYa0g57tgtPokjQMD95xN8xFvGEdj0lOq+UR8YiGfJjq0pitI9gosCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kc23Ee46eqrg9v1f3Nnh/AIkkGMw0woQxyjjQJeHGPc=;
 b=JsV/uRsc47tKFkZBG0o0jWri/R2cc1p3ggs+bnQJE2pCveC9x9A4O6+/cugRPFfvbgFn006UaKhahCTizTSA7h/pDcDfq8azoQ7IFsnhRMxzzazzVM7lGPhdKMG9EZ+I5VfBJV9WcZXpsTQMhzMTrddK4nzldJ8CLEUPpBXwfQB81NXEOyPLN6vLYXlVhsA7IqQCgp5OJUwQC/fDP9NfIot389VI4PMzO3x7OGWbR9YyfsrrQGf5SMBEEXwAUpsqh/ZS1V6F5/q4/MzbRMQBjgWXdj3IpSTa7T/rNV2BAqcq/kFGDdZubrsPsjat8H1dSK4LaROd7pSZg9pvQMaIiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kc23Ee46eqrg9v1f3Nnh/AIkkGMw0woQxyjjQJeHGPc=;
 b=Snt2wYl8zP44F0jjILxQirbUwT/hVDi7mZTeudkC+bePDyeLh91VLDzA8WB1fjLVL7VT9KWQ/reBX6upcchevIq1oEcgN4THYKlsnBqP4HJJzl0AFj7+x/uXe0w2qYwXdMN/QSUDSDcDJfnFCnHk8WWfhjKxNeOqltONz1dPvzE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by PA2PR10MB8550.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:421::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.16; Mon, 14 Oct
 2024 10:21:39 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9fcc:5df3:197:6691%3]) with mapi id 15.20.8069.009; Mon, 14 Oct 2024
 10:21:39 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: Heiko Schocher <hs@denx.de>
Cc: Peng Fan <peng.fan@nxp.com>,  U-Boot Mailing List
 <u-boot@lists.denx.de>,  Fabio Estevam <festevam@denx.de>,  Fabio Estevam
 <festevam@gmail.com>,  Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Marek Vasut <marex@denx.de>,  dl-uboot-imx <uboot-imx@nxp.com>,  Rasmus
 Villemoes <rasmus.villemoes@prevas.dk>,  Stefano Babic <sbabic@denx.de>,
 "tharvey@gateworks.com" <tharvey@gateworks.com>,  Tom Rini
 <trini@konsulko.com>
Subject: Re: [RFC PATCH v1] dts: imx8mp-u-boot.dtsi align flash.bin
In-Reply-To: <aeec07bf-6a3d-08c5-2786-5a7c2bfe92b6@denx.de> (Heiko Schocher's
 message of "Mon, 14 Oct 2024 09:44:45 +0200")
References: <20241010082831.19983-1-hs@denx.de>
 <DB9PR04MB846127A928CBE4AB1F373DFE88442@DB9PR04MB8461.eurprd04.prod.outlook.com>
 <43ea1972-ee4f-ab25-aa98-2ae3fc4f20fb@denx.de>
 <DB9PR04MB84613CEEBFE7ECE0B249DB6A88442@DB9PR04MB8461.eurprd04.prod.outlook.com>
 <aeec07bf-6a3d-08c5-2786-5a7c2bfe92b6@denx.de>
Date: Mon, 14 Oct 2024 12:21:42 +0200
Message-ID: <87a5f7assp.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0046.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::20) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|PA2PR10MB8550:EE_
X-MS-Office365-Filtering-Correlation-Id: bd7b2e41-92e1-4b00-f791-08dcec39fd9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|7416014|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7xJ3eOlZyNEUQgNCcxikTNlu71NEAzlE9nAOeUTCG3IP5rLBtKZZtqF5cZay?=
 =?us-ascii?Q?DGRvkNGyMFMdjAQ5koAvERU9wlJcL4pWskI/3Dxfp4SINf9BdXtZUyoZd19I?=
 =?us-ascii?Q?LraK/uZsWOb6cffJR3mN8wvEEcbUtK+rkRjnpm49WHzRw/C88nX8KSjSMntN?=
 =?us-ascii?Q?GC5414scT/vdXXwUA5RuHOzpYtF//wN+iLaAmkX6w6uKgkaVK2YtgaQxg9V1?=
 =?us-ascii?Q?dbi8kGh1EaH7VmauUmdli+vsgMcu/aWuhIcbMTKahM42le0kQB0KSVH5rb77?=
 =?us-ascii?Q?3l2UA5byobZKTWbn15MN8GTd9yF3RKZd9w++VaYs9Ufng3QEqVYbdA2quG7N?=
 =?us-ascii?Q?Ns+cHWVVUD28EuZHN9i2MoYymhe/eZuYABGSbQbf+7JF1JAV+W45LiBmaGHe?=
 =?us-ascii?Q?u4zSZx5Dw945QZxiSLg0Q0x5YES7MFStzKi+TkLonuCR/SDfKII1/h86l/ku?=
 =?us-ascii?Q?hTC+jrANoJP6K8SI9zjGYyhJz+hbZJyRXV0pxtAKr+BQRmbIw1XlHz+j/wM/?=
 =?us-ascii?Q?OPAV+73LRZMaYF0EMeZMAwZAdsL/t5u2QA7iORhaln274NQjhd9C9hMRAIxI?=
 =?us-ascii?Q?GhyUezsRVgW3EG/iPBnsQeaHheuYooRfIzGlb9504606Az71fm1oX9S0h663?=
 =?us-ascii?Q?3iQ6LEE0SRssH1zGgc82nCrVp+b8fUD8StFqXJHqNob+o+ADxeTWIH3OQWjA?=
 =?us-ascii?Q?E7HsPjs+AROAueI8N0F31eCYYaxkWZgQJ+nkUYeC+0UaPEZH9vTr0lRq/2y8?=
 =?us-ascii?Q?BGW8A8j1r6/na3Knt6Xb8SaxEBN4WZ5jsh4lZ7aBS3/VTf+7RJXTFIZsVIFy?=
 =?us-ascii?Q?NxmoAS9ui0ZgNE+QBLB+/N/S+LnL7LVBzQD7GBZ9nMDncihhyYGOpaLriuhi?=
 =?us-ascii?Q?oO8amnN2T0rCHvn5q7VIciiOiXdJq7RyxvIB4zLRXRl73BEZe3o3LJrq0icc?=
 =?us-ascii?Q?HgN11BDIsG+yYtUJFodAzJVS275tTkw7dIqB53jO5lc1/dgrqxlycnvcti4m?=
 =?us-ascii?Q?j2RmitFf4fbupmr2urpBECj4JXj885+ItqsbfVdCDWFlGB4/iFYCdA+raAk4?=
 =?us-ascii?Q?B4yZGJciJD4qxrEo6GgyYO1rnBVP/cU0ITeJXATIYJpXelHEHT7vH204q7gE?=
 =?us-ascii?Q?wHdE6lEz57RTlzM4k4I8b2/GhSar394t+jC6EJlfjoLN/KFUQBvfnfO72WLv?=
 =?us-ascii?Q?fAwKksvKRO44nha47odrvmbyUoF4BLGgNqHjM6TLwjRYSim+7qINJEvrsCrU?=
 =?us-ascii?Q?mqAt5go/pfkVxT+GjxrpoFnnM6coQVrlvFmAppqpHXgD5E0l1ttJ9RYtH1Ms?=
 =?us-ascii?Q?ykFskfr6/sQh0YzH44n+15yp?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(7416014)(1800799024)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Gfw3wiIdWbpg/r7QrRDWMOk2KYNvDJJew0OUC3i+G4xRp+Ags39nXQEG8s3e?=
 =?us-ascii?Q?x2DSD77YPB40E5nEe/Sjn20tpqfjvJRL30jC6ayIZIYg1jjkZPlzjW4O5kXX?=
 =?us-ascii?Q?6rqOPD+YXbWPoC0uEnwfBXhU0P3slNYHa2X2fcXaiOKuEapEQDuP9MCZ4BJr?=
 =?us-ascii?Q?XuI3GLLa1BzTsk3lt/NLDNXJSDv0isV4EeZjZ+u+YQvnEClM2RLbH06Hy0k4?=
 =?us-ascii?Q?3UC2oZO8hiX3tTmT0Ibi1P+qFGF38SAoFEFmduaskr2eCjK9psJ9wdhFO+Ho?=
 =?us-ascii?Q?Eq1MwdfCR4jBAVgykH3UkjDWNhOk/wrdfGcSpGJDmDdVQz1m44MsByxyeEAx?=
 =?us-ascii?Q?1r7uYHHJMHLFTFb2QHggJhvhwzY7xziIJYNbCVrdtECURq/B+wj2xg8BIJJJ?=
 =?us-ascii?Q?6wroedTuo0NwlAZKD1nFFIy3cgAwJw0g2lNDe3S61u+46ftKLy2seyIIPsRj?=
 =?us-ascii?Q?twM91ZLf3nWSyQXBtAwLX2Dod5g4pSHbNfxg/0ktW0cxm+tNLME9glstlSuu?=
 =?us-ascii?Q?8T+f8Elh5KiODwlRvX9CThM7p+tSvCqs1lgZnTLvSea8oZeaOZ/NxC6Unlkn?=
 =?us-ascii?Q?81encAx4o7cJquzeZDB5+mV+wfIUILaOg+KZenbuRU10+1iyjVNNkIp326Q0?=
 =?us-ascii?Q?ohPfa4KPUiKgIm2pspQqNsqEn9zvxNW48qPiEul08tEwhvVoktE9V0sC5I8W?=
 =?us-ascii?Q?HV5DdmyX1plj7H9t8sdAmd7ld8QzRqm1+NZm0gaSuBdBO45/hppn0qS6Sygg?=
 =?us-ascii?Q?ADR+eJ+hf+BWIfAgXrRwtTM7dQK3oWSCy5yPBtMmKXFPwrEkFkinFJiT4OzJ?=
 =?us-ascii?Q?7k1ewfh1f2pWAcOjQkB1VPfPp9hVAVcBK7phJtKBZ36oizsfaGeIGzcfW8H+?=
 =?us-ascii?Q?shWWNAc4DzAGwUcxhxo/qhrwW9Zs0TowjNsK5w27c9+ZWh+3IInDmpstVkSz?=
 =?us-ascii?Q?CRfb4LEiuVbXTOYMhE1ftrflZIagbwXbiu9PTmtL0rgid6UEBfCN1Rr7zb9L?=
 =?us-ascii?Q?Fq8JRLo8C81WT6o+SAjEPLkpAOCLmIGW671hxjp91Kuu51oSHUuM74ZFfEVZ?=
 =?us-ascii?Q?hDNrkxlIG0fO29K/BCZYeqY/V9Qm8Q56q/Xu+0OAVFQI7dNEzANcEdmslO9p?=
 =?us-ascii?Q?vwNhX+lK9BDje+usM0eFjbB4COljSWmQCb4Yx8c2nhKk5CMBLraOHQXmvvL7?=
 =?us-ascii?Q?VrdFCcPZfrTylw5KYrnywqLm4s+cWvp+OgnqV7CYwF4ijsCitPNIfoOwATg7?=
 =?us-ascii?Q?+UUdzQq4KbqCuY4+uLlQhmPM+sifBt2zVWNBrC20TnE1GsphOJ3lNJg5o/oX?=
 =?us-ascii?Q?nmxZz+iJCH54c2B0f/DQOF59dDpdcDe3T3batlqZGpsgccfSh7sfIVaIXS5Y?=
 =?us-ascii?Q?ScU9JTxA6+Gad5yGPCF1kCCThkTPhRqhn7WKqHElJY0NMny35fZ1AqApcpx5?=
 =?us-ascii?Q?r1qpS7fwhcpa0tWYAIzlawt3DKx+73SlCX5m9LB0KjWsAJv3scp2Rd6nSk25?=
 =?us-ascii?Q?Cl0sZaouv14o57yPO0CL3iglRv5T0KmhWHzCU6wPwy6MsbAiPzqrzzwBlx7e?=
 =?us-ascii?Q?6FPe1AOHztCDGWdMZrZvpUxf1zD/4ciHrq2FhXCoZixUiwSrO1cjsMpXyFIf?=
 =?us-ascii?Q?Qg=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: bd7b2e41-92e1-4b00-f791-08dcec39fd9c
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 10:21:39.4083 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: flHNBMh30a47vKkBaX3sHrXP4z3Lhb46CVUWuNLSTIeTB9EyvYq4izQB2lqKHljvqqFB+LWqkUSevmqcY1LCy07SLTcMC7DK7XQ2JYODB5o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR10MB8550
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

On man, okt 14 2024, Heiko Schocher <hs@denx.de> wrote:

>
> Board boots fine from emmc, sd card. Booting blank board with
> uuu works with posted RFC patch, as it seems to me code in
>
> spl_romapi_load_image_stream()
>
> waits for more bytes than flash.bin currently has... appending some
> zero bytes at the end, and U_Boot begins to boot and works fine, uuu
> tool ends with errorcode 0.

Sounds like exactly the symptoms I fixed with commit 89f19f45d650. 

So yes, you really do need to ensure that flash.bin (or rather the
embedded u-boot FIT image) has a large enough size for what the rom api
expects, and that number changes when HAB is enabled.

Rasmus
