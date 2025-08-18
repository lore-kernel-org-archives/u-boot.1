Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C580CA0EE4
	for <u-boot@archiver.kernel.org>; Mon, 18 Aug 2025 03:22:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0532F833D1;
	Mon, 18 Aug 2025 05:22:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="k7CXakzx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D9AAE833F6; Mon, 18 Aug 2025 05:22:43 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E5DDE833C6
 for <u-boot@lists.denx.de>; Mon, 18 Aug 2025 05:22:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RlY5S0QHCm5+paAJ8Rh4xxVKil59qujApy/g8pYCuQK4oSna4vMKzgea39MiQMD688ZK2IV6wsIXwEK1v6e1o8HK3Sg8hd+RtuSSmxunAKwihNAAYjoxQdonFTFWvxm6Gc1+1UcsnMM2IgmIwU1ShR5h5OiGU3wmnn9r98AqI1tcTrKd23647SEJYyMIEXFYq9HXlxLQklhVVFbPntUzeBEhzlH4L/BPxW6RZJPSCbpfQ/nhg76LA8jqomcxtUqIIPs1ClUk7S387RSEcn5uuOslj1BG+sdur6iZuT1Z5TSKoh4JVImF/OZjSH7QdpzyIzEnwPkjSa6qd9Hov0vYRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ymzXFdspvsZTvQcgy+upgLjwLAJCTF9FTeP6kYofn4=;
 b=BXTYHe8CLzaxbvG2ZG0kro8ywg2LiYzvGxsE61lRXWkMa+0r6re+562h3y69mjApEE6OFNYBgcZ6cyIKH5ZH2eXDoAmOZ1UCvJLen5hf8RBqby8/E3A0g+FIvUMFnz8le0Hz1ct3UMIXbl/54iJ6OsaVnvddAaY6mho+wsjYcal3DKTGGAhubhdE0ivfFROnq5YCWI+7wx+6bldAKEvUrJMvciQKQjcXQZVvBQ+I/i4rXslVjHulPzfchtaqr31jCV1k9eYzg76nOgofOLh9NmBwZfxxpnIc5wifu2EiSCKINMjoplh6rWxUxsh0NWg7a/UXq4JN4Nxrj7B50klKWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ymzXFdspvsZTvQcgy+upgLjwLAJCTF9FTeP6kYofn4=;
 b=k7CXakzxkkLV3UqcDWznpbpkm/mf2kkNFpwsicx+TeRRrEc4bu6WLBV4zw3jUvlx+J3nxPb9V5caii1ZZH/U8TRgDX0Ie4FGyIx3TFO1jcrjhcSgdVVpHyzGA6WYczS9TN5zduLN6NI21FrEt6gSNH7R0gmLxKGQgV4ZMhik42ZcRtGQDO1K3h78MBQGbLrLzvY3w1ATlxxxB3USOFjf+UUSnUk7hF7JOBewyYvjWFmTbRsqZuQYJ/X7jW3ud8sJi1WMcARbu7lW9gJO2hWJIXI4+vKOwSESKCmCIZpfxAC65AlQ+3VwRd1DEadRz+CffH8dq3JLzhPI3AHylrpnhw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by GV1PR04MB10453.eurprd04.prod.outlook.com (2603:10a6:150:1d2::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.8; Mon, 18 Aug
 2025 03:22:39 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.9052.011; Mon, 18 Aug 2025
 03:22:39 +0000
Date: Mon, 18 Aug 2025 12:33:44 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: John Ripple <john.ripple@keysight.com>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "alexander.sverdlin@siemens.com" <alexander.sverdlin@siemens.com>,
 "andrej.valek@siemens.com" <andrej.valek@siemens.com>,
 "festevam@gmail.com" <festevam@gmail.com>,
 "hs@denx.de" <hs@denx.de>, "uboot-imx@nxp.com" <uboot-imx@nxp.com>,
 "peng.fan@nxp.com" <peng.fan@nxp.com>, "sr@denx.de" <sr@denx.de>,
 "sbabic@nabladev.com" <sbabic@nabladev.com>,
 "trini@konsulko.com" <trini@konsulko.com>
Subject: Re: [PATCH v2] imx8: Add ahab_commit command for imx8
Message-ID: <20250818043344.GB13772@nxa18884-linux.ap.freescale.net>
References: <PH7PR17MB613046F296E7C25AFA85DB7D9C54A@PH7PR17MB6130.namprd17.prod.outlook.com>
 <20250715034758.GA632@nxa18884-linux>
 <PH7PR17MB6130D968EB14FCDEAF46BB8A9C34A@PH7PR17MB6130.namprd17.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH7PR17MB6130D968EB14FCDEAF46BB8A9C34A@PH7PR17MB6130.namprd17.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SG2PR03CA0098.apcprd03.prod.outlook.com
 (2603:1096:4:7c::26) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|GV1PR04MB10453:EE_
X-MS-Office365-Filtering-Correlation-Id: aacff1b2-6cfc-441c-d295-08ddde067c34
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|19092799006|366016|52116014|1800799024|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oVihKYKADWBGGHdiTC/zsFiYti2VK/seeIpm/vqY/A76O+cSrChOV1HAxTrY?=
 =?us-ascii?Q?NZfnBNLdbGED93qi7sE4dmLTDmqoX7FtWCGXIhwQTd7OLEduVjia/sRCMD36?=
 =?us-ascii?Q?+W0a3dvKpDFsRg5f2QZQytw2w0vpy3KZP9YIW5r5Mgm6BZxQbAjMS2PC2ZMg?=
 =?us-ascii?Q?zHC1ZdPQEHMPJhMSMFR5SxWK70VczhDvRrDF0D3ss7NQE2UjBRlZUIytCXoH?=
 =?us-ascii?Q?u52N2Fr1qAAzc6lgw47BgeROfsvKe/Y603hrLUG76IKwNjIwzhxK3fsKZ0gG?=
 =?us-ascii?Q?YTGA09HEFfvaCq9J97q907xspmYvjHqVEmzLKsif4rIfWjFx1Fdutm3RXxLJ?=
 =?us-ascii?Q?NgB0epiD8LFg2liROFnCt1Qv7gg2qiIcT4dBrvJ56FuSpzSIwY7OQ+jIRN4K?=
 =?us-ascii?Q?tmYgNRahOqxyC9RWwFmWBdymUIpZ/9o5dl2I+JDfWU2jAV1Ja0MF+44w5RfB?=
 =?us-ascii?Q?1rnmmtDfSy9h9apUTCBXOVsFuTkozX46fXgmqYr4iQtxhBU1JywOvIDq8jcx?=
 =?us-ascii?Q?LCuHlwbRQ5akgx5Mm4CoXN0JvoxG6s7eL23jHYVvrpjg7OzQ18WDSLEvSoac?=
 =?us-ascii?Q?OfI9bOX3WLXhFFCFQJHyy0q3IP4u0HbEtRZlMtTzUM0SG+RnU4lNHCZb2JDh?=
 =?us-ascii?Q?T4EyKaK3rI2+Sm0fYeT9ft4MQhUGe0IB82MqO6hn9XLO16asNozIfx5gX/Po?=
 =?us-ascii?Q?meZ+RGHoSfIItd6Ph/n8vSg0Rge73vRKBwyNJWmVAU6Dz1gQue0oVt++e+ai?=
 =?us-ascii?Q?2Vo5FX8WZ3a/4L19MYzaZ2HSXEzgq0WWxeZKFG19GYFUvdwnKmh5FPHtPOkP?=
 =?us-ascii?Q?PBfhNC6hGfHREtTj6yqyAjwbQ8V7gsSBmf9jkVr/IA3uadBeFRlleufN616j?=
 =?us-ascii?Q?e+8Rlp1aivu7HDcM9Hzud0xlNntVE5AO757dIujoqvxQtugN+NWZ6rrGZv3y?=
 =?us-ascii?Q?uP1tzhkH3z0LU4wq7jmV7gsm+fsdNYnj349KBoKADV+lGhu5mt8FFSqK5Ccr?=
 =?us-ascii?Q?Jua8dtyejU9JsYASQS1LdU/QeZT8FSPdtXZdRxfgd67i7W0W0MfBjMrv6mld?=
 =?us-ascii?Q?aOEsFeeLJO5h/7cZj7yMxlXEc4gFgjdxiZte/TKkU2EFYoVftIL4bnBwcmNx?=
 =?us-ascii?Q?BYhj8BHwEChps3x4QlNdfMnuoWK8roZ6jf2mcrv5DdjPtvAABDdIuMxa+WQD?=
 =?us-ascii?Q?W3xra8oD7F3t5HPqY0i6sfNy8zV5F6lfKCCgImjPFSybE0kDYTnOS8Ru6VKJ?=
 =?us-ascii?Q?NcEOInlG+vlh43tGjVhcp/k+eLXMAxyBh0aIv0f6aapYBB5hNTjV+Wvc/vKb?=
 =?us-ascii?Q?O5/J6FqmkNJDT3FKdNDlkiw0LJPnRQQpyEgl4fOAtjBvKZ5DKqTpNvXEsEss?=
 =?us-ascii?Q?64zurkH7tBNafmnQW+nBzrg2m573H8psa8q0E2f4FN95+jcXg9toneyJqL/L?=
 =?us-ascii?Q?bVAHiK4bGzblvTAw8/Ath/AFQIaXbk2Vyj5i7atCm5acJJFHZbb9jw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(19092799006)(366016)(52116014)(1800799024)(38350700014)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XNCsatx+8sn3NK54J4507W1aMN30J/bgPPgs/MI8mIKyTFDGB9y485OlK1hN?=
 =?us-ascii?Q?PHW7blKqDvk6Cq4qEoquES4NLwGi4UpFfzdO2tku3GFGWEKx3zHCfoUR2Ew4?=
 =?us-ascii?Q?q3imCLgPA0bdiZHo5f1JO+xuhGXFlBxMS/elyaSd3CrsfNvuMEl3Et3d5ZWN?=
 =?us-ascii?Q?CUS0imvltRiQtWTDdzU704rbsy/EUZZ6QMOnBj6v1jPQntI6iG3KDmqo7+d/?=
 =?us-ascii?Q?+8Y12rNjz5uaPAbaEBrEpUY4K15w1qUKQ4R7Rrsb5MP/TIYZVxYK6faCbGhj?=
 =?us-ascii?Q?IDC47/LaJ9A7hY7/LRHHMTkAPC4Uvqo+7ug+LWj40vMFC61LGMJmonE4r3YN?=
 =?us-ascii?Q?KHw76d1L8xE0CZ/OcblG+wxNphZTLdvlmuXC5i7k1ogd2E7cjyob/8q3rSy8?=
 =?us-ascii?Q?RRHrVBtvc8ek6Nl8YM7YppcQSCye6DSKkbUdZjaBGaWkaJfB64kWKIOophGU?=
 =?us-ascii?Q?s/OOv+vcl319S0ZWm0zpIcfq0k4Ptu2fSdisjp4gKYLU++WuFCMIzJn3JouQ?=
 =?us-ascii?Q?SsWcrU0weanny8DchGxFcyvPv5DBNFNfTXosE9qrwotjulaOsT1qcK6wWdXb?=
 =?us-ascii?Q?E5c82EHiGO0NvtzcrJc4m5vMawah2z3ks4dMNm66ULpG6SpQILeXaBIlQ25T?=
 =?us-ascii?Q?oz420RusMiTJBqBfC8aZfZLsFC27XfCsYCqXPHVtNMhA+iA0fRhxQt/5Nt2d?=
 =?us-ascii?Q?tjmq0Rsfal24VpR6JH4lqUfi4nUq707grwFlPVdZyh5XB5vaIVw5+DT/uknp?=
 =?us-ascii?Q?YJOHt7dbY76yliYY6Ogg23aDbaOdWh6eydR8epqgAafr6moySGTujgve+r+c?=
 =?us-ascii?Q?gHtWzWjAEKixYiV3OT+0z3S/SnUQlM2WK59y0MtbyJUdHiWDsMj36zq2TuuF?=
 =?us-ascii?Q?UTNaz8g8cseWwUXJm15+cBuxntsPIFczDLXriLP2imxoo9D18Z6lULYY94Fa?=
 =?us-ascii?Q?cqmVKJcUxFWNEh++ZKDj45SNw69iBE9n/UCyy+mblsSyR5XGoZR6x9Jd0/zg?=
 =?us-ascii?Q?t4tGafbGog+/X7Qa+odSSbcy/z/jrD8RSCFJNpbQwBu8zN8JTnszI48r4tVI?=
 =?us-ascii?Q?CtBWv8Q2UU+WFiIttfyOUz0E0JRJzzqtAgJtaOIp1YSx26IzAb7zAnkUkOu0?=
 =?us-ascii?Q?ARcRh8PFtS7b5motD8al2CgQ1AjUesCtiqo2Xk+NiiJSyGiULIBTuc+M5Xho?=
 =?us-ascii?Q?G0gp7tTnrPVARLQ4mDLQ6Xao9RCkx0sqoqaGbGm/x4y51JJzlZnhJds0v1Rz?=
 =?us-ascii?Q?VNwtYTo3R8tWIs/zyuiySkRI5JH21fPaxDnDohkIn7hntfnuyzTOwM0tkz/p?=
 =?us-ascii?Q?B5xHHF1B1yMs4cKGH3ekBS6SCTIfkd3Z/3GB2YWb4OpX5pmdAAMxG+gvSYWD?=
 =?us-ascii?Q?z5YSR/rVa5UHQ6r2b2Z8eLmRxntldbm3Zl46qYoFZfiwYq2LaiQoy3y6iwuC?=
 =?us-ascii?Q?aEfJqhKbWbF05bEIZ2P6g5ImfEyaDk+ph8vmLVaNGchwbu1IypSh8QjNES8q?=
 =?us-ascii?Q?cV5793G/rULAYbR2GEla6ETZQn6TOedb9ReFwQY4sdOOz0tjeVQ6nx74ml2H?=
 =?us-ascii?Q?hs+7GqNs4iNUSZ33U7c7Jw9soe2njaRamCAbWKxP?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aacff1b2-6cfc-441c-d295-08ddde067c34
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 03:22:39.4675 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rKyHDJawI7YaqK/Gxh/de84gUlb9WA3IGsmM/i6PKlnf8lpGtQe77U5nrB6ePd+nCXgIFo25+JCKaRRpRPPeTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10453
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

On Fri, Aug 15, 2025 at 04:49:07PM +0000, John Ripple wrote:
>The ahab_commit command allows the user to commit into the SECO fuses
>that control the SRK key revocation information. This is used to Revoke
>compromised SRK keys.
>
>To use ahab_commit, the boot container must be built with an SRK
>revocation bit mask that is not 0x0. For the SPSDK provided by NXP, this
>means setting the 'srk_revoke_mask' option in the config file used to
>sign the boot container. The 'ahab_commit 0x10' can then be used to commit
>the SRK revocation information into the SECO fuses.
>
>Signed-off-by: John Ripple <john.ripple@keysight.com>
>---
>Changes in v2:
>- Changed patch name to have imx8.

Please address all comments in V1.

Thanks,
Peng
