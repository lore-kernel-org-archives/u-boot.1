Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56598C43458
	for <u-boot@archiver.kernel.org>; Tue, 30 Jun 2026 02:44:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73398849F3;
	Tue, 30 Jun 2026 04:44:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="J+i/3xqC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43CC5849FB; Tue, 30 Jun 2026 04:44:29 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50E35849C5
 for <u-boot@lists.denx.de>; Tue, 30 Jun 2026 04:44:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kb4hEGtvCDoQdocVKlPplFZdpV1HqoGGPjek9voweD5GO+8BGxZM5TALrFSUa3ZXSaoylAxU83pHNJ2De0n9AYFzoeaul3Y+mmFyqzc/90/Fn/T++ZEqd7Jsa1GtQawiHkndOUQiDD5gnD+mmpQTTsw83KNlBQn5F9YXRrRJhpW506T2+g/0v5j6+whAVymKYqVUDAXrJQZGZW/FSAjQaPfMvNZN7TxO9gbM9xmc7op2SCclqWjziMbZKi8MODBoftkT+IAaURUi9/b70MOal2j1TTb6N1MuYJBxV6DRZNtigLCJ8r8uXYI0kEkHUfU+PSJjF/8okKFQQhRyDS+TmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iSgpFWVRar4+R8PkDDNyyuVTrqz50+AF2Fw4BBEROo4=;
 b=cCsZT9tW7TbcVg0DeIdHzWguSqkjwdH4+uOniwwrL982anoRPn+x+Cc03nZt7tWgGquZC1TGuRllt2Br1BUjkzbWl8dOJ7jExqedjE6Jke3qcRlIsF2F783qx6Jnaw+BnZlhHM8rMUbY2wNGC8ffw3f8U4kLp4t0UsabQnD+ahMgvfteODfDRsSx2Ebj1WFLzRODL8CwWxDj05Lob0erC6TFBamkPUWvoOhZlduyCVMoPG+bgneUOAsibw9XVQU9iMh+kVm1hw10VtN9yYy8z4PL2GEkxRxEW8DcoCqlDCZuXV8flXbngBkWZczDISTRbdb5Sk+dHL/QmtE/kW/m3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iSgpFWVRar4+R8PkDDNyyuVTrqz50+AF2Fw4BBEROo4=;
 b=J+i/3xqCxN6TiF/vXBr2BCcpnffbLR6KHy0NLJ8Gcvi1lGcCLP5N2GYLoVSivacmnAB3ELIaP/uSNBKvAZ2kSANNvkBN5t/gehPB2KnW4v+pEj6q8DwJqoA8wnAZ4U3QlRQyu82wml4IzffQ57mUATbeEkDZlWZ2MM5uZAgdJ24rWhJ2Ae1E9LuRxWs/e7/fwe7fCr/II/XiMIBs8m11vcbmub22yxOpGGsvrBrDeXu1wFq6xBWAc5WIUrKfd0E/7dEOASfvzFM0H7tb91sc2cTQ8mWLJsCQfqX0i3KAcvZRp0Awjn1dBedt6s8Hv2czP/m96vtpGNGw3oDzQh4NZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by VE1PR04MB7373.eurprd04.prod.outlook.com (2603:10a6:800:1ab::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 02:44:21 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%3]) with mapi id 15.21.0139.009; Tue, 30 Jun 2026
 02:44:20 +0000
Date: Tue, 30 Jun 2026 10:47:44 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Eric Chung <eric.chung@riscstar.com>
Cc: u-boot-spacemit@groups.io, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>,
 Huan Zhou <pericycle.cc@gmail.com>, Raymond Mao <raymond.mao@riscstar.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>,
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Kaustabh Chakraborty <kauschluss@disroot.org>,
 Han Xu <han.xu@nxp.com>, Yanir Levin <yanir.levin@tandemg.com>,
 Christoph Stoidner <c.stoidner@phytec.de>,
 Balsundar Ponnusamy <balsundar.ponnusamy@altera.com>,
 Daniel Palmer <daniel@thingy.jp>, Anshul Dalal <anshuld@ti.com>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Johan Jonker <jbx6244@gmail.com>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Sam Protsenko <semen.protsenko@linaro.org>,
 Guodong Xu <guodong.xu@riscstar.com>
Subject: Re: [PATCH v2 v2 2/8] mmc: sdhci: add quirk to enable CMD23 for
 multi-block transfers
Message-ID: <akMuUIkPhIK33vZa@shlinux89>
References: <20260629-m4-v2-0-cbc91c6b83d8@riscstar.com>
 <20260629-m4-v2-2-cbc91c6b83d8@riscstar.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629-m4-v2-2-cbc91c6b83d8@riscstar.com>
X-ClientProxiedBy: SI1PR02CA0043.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::19) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|VE1PR04MB7373:EE_
X-MS-Office365-Filtering-Correlation-Id: 400969d0-0809-4c65-ef3c-08ded6517cbc
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|19092799006|7416014|3023799007|18002099003|22082099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: lLjjmTziSkWXdLoW6yZNcsiPYCEZUsFhZhC+ZK78NEwGnwriiRxiueycQGlkNNG2TMqjFedU1TPNv2FgiBizyfpaNS+2Z+iyjSXfB6EwE/duFH/ztqe2OGLDs/a3nCdkyzpIR24ylU9psEkutR/ulQX4veTRX4pz479g66UQp60OIK3J4VXV5lD7C3RAVBYtCWmeCRZojngfeZGlftDgVCLbGnQm6q30pyFoiNL54iUVj7fK7XvwMrjo62Y7Rguq3+sNAON02GiV4f84q/AiVUobWk9knKW2QblRWL8KnYLVHLvlGu4P8LALykOpOd1kDMcxeiHpgVg6f0422xmbGB1TtfJqlSHsmnwTw4qNThhMVffYCXxiotZKiYZWrLIZSg4rRMeIzS36gRWF0xZ7NYcEq4mBJMEvC9Kpc2lXSC7EV9Cr1nFNRiuoXOyaqKchXHsKJ67E2alL4lMau2fMN3MtMkuqUuR7k4kLq4HQP6MKeQpmP41KOgK2wJlyJUHvpUg/t6PbIDuZyJ5lsht4out6zn/xpPdUxOttqQSPfYwmCx5klme3eTIVmYzt4aWPNdaxstWaLG9IYiaVyhEtX6k5/aj1Vzz6Iyhzs18eaz6CzGpCDY+9V3x2Fm2R6k8rKP9cQr8ML1cJnjFHR2uWPxP9nl5DgVx6IA/4nebY9hQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(19092799006)(7416014)(3023799007)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mYvk9FghxmoAuJwN9/sB19+rutmXQNfUM+EW9k8K2lzpriquS4GTMhWXj5nv?=
 =?us-ascii?Q?9+EGBZ3ndfXlZdXNMi0cSIYXiPfR6fs1/yBDsePIOqxHmfF3OvrFx8qsHARc?=
 =?us-ascii?Q?lIPLnE9mMs4zemYnnBCV8c3rqJaknEpOrP2G/TtMYRxGdqXAuUnJUKhwqtBH?=
 =?us-ascii?Q?/5JiIyCJn+Ra/vk1NDKJ9KK7THxcSI6j8uvYsfxGyhj+wWUIhZdvmNeJBqlY?=
 =?us-ascii?Q?RoccOvoquxEAbau3wrpzyYz8SVnSNk0s1+IxrqbWkch23XMwHyz/7LbDa3FD?=
 =?us-ascii?Q?Nv+Q60wpP48bDINCXyNLPxQULCBmqykbsqBoMZTL8LUHD4eFT+10cEwSdRNc?=
 =?us-ascii?Q?9WKKNnfceqoGPSmDOaVzZMMTRIsHcQP5Vby0rMa87ZKRHgJr+GKF3FGqE3zE?=
 =?us-ascii?Q?6a3vZvvND34+gySifwnarkEn40/PpdVzrZL/syeYbt8CE6pGdE6GYOLmHwF0?=
 =?us-ascii?Q?bLa/M7w0dUxStYJ5AkGR0vCRVH4BKWBj4KiCG/y8iVwz4+Vpwa3i2fER3aPk?=
 =?us-ascii?Q?N2AdCm2qUZNyN89ORbkimR7Lu+8fqVxA8WlmCulnrDDJv+9oFradAIjVBzqH?=
 =?us-ascii?Q?cBwUppjA+OnXB033vfBwcbz1H6IEtg8pi3aWAh+2OUCNxwSiJPXQ6G+klGrX?=
 =?us-ascii?Q?SCa1KIbbNQnGgQjkfPllbmaHMCVbl8QKjAAoOvQlp9u5CSHGaxe+pqvQX4gd?=
 =?us-ascii?Q?mZrX90h9kuwh4C9XufsS8ehHhxdXCgpFNAHlfgjpBqAVpQyW8NlqtWM8Zbkc?=
 =?us-ascii?Q?AVSBB6k52mzZgjOUTGhYyv/SO9o9Fg/kj4rpxT9NSWRmTODmKw2ZJdh9FfzG?=
 =?us-ascii?Q?dCCMsFjEstgwFr1RqqbxUygdwTqDwYmVRXgo7SOe8ygruUPDaGqxqTvRiaFM?=
 =?us-ascii?Q?/9lqOTx5qTkiHoiFerVdJMl0klemErUY3WAQhmweTnmGbS+VZ8fXoxHIYbeT?=
 =?us-ascii?Q?WQWdLe+EBjz3odfKUVOMwnNjUhStbn/+a52jsnZ6gi3TLZ42MTCQvnThTtiN?=
 =?us-ascii?Q?0v1tNTdr7hLP2CO2c1VdHoROdo0Lq5AgLkUF22tAlJbWwVhmE8K3VFIh8GVC?=
 =?us-ascii?Q?rKhCpht99SYhCR+Dja489D/JefBQTDTFSyYiDY76NsAZpFk9tKzUt52Jmyea?=
 =?us-ascii?Q?r6X496W6cOWFbzIIzmBop3JCD8YgehdugkrmbHvIzoeyxQkOEGki41aeU5No?=
 =?us-ascii?Q?2c0PqxhfCq3s5f9OV1x01IcC+XGDjpvRo2fPdvzxccNqJgI4aIehU8fW8nTO?=
 =?us-ascii?Q?9SDwN2wICWLoN6MbH7rYhwv0GHTakwKnmHVRYcfoi7spLfI5jVXSFRK4sACg?=
 =?us-ascii?Q?JuijB9fDQ/aYp/5R46NrfsDLtXK/nZ44upZrUl0GvKeSAr4AmJcvfHYAFZTz?=
 =?us-ascii?Q?E8y6VLIfhFlheRCoAMkgdwOYCn5WXzKLvfIl2+xXR4l6ur/0Z0rgEDuPEt2O?=
 =?us-ascii?Q?MiBU9KA2/B86HWVEtraO0ITVPdvX5OaXmltZtUhihbxNvHMf7ai5u1AkRPoY?=
 =?us-ascii?Q?4B74gET/v/uJUo4AIMGQ/DQXT/LvdUr2bEkyzJ2eW4WNz2IO7CcZ1NBymPT4?=
 =?us-ascii?Q?2ChtDiPHU4eFpPEjJhDbTZyFbe2wrE+6xegi7tLfWMIKkerYOjgfNf6AKfiP?=
 =?us-ascii?Q?TAQU2qGAdlMM3ky2HUBJLm1j2IlbFAHNjkgb4mmBbmopyG44D2DtAGiltNYB?=
 =?us-ascii?Q?KoIseXcNZsBGcLH/71PUxFU3D5Bk5yqKBTg8byL9NBSdJsKqAxdp5YLddLRn?=
 =?us-ascii?Q?2P0L/vhztrTPoyWioz5GzQAJ080+HAxJFklEF4nn1QOwXTSpMfQq?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 400969d0-0809-4c65-ef3c-08ded6517cbc
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 02:44:20.8287 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tYN+e1exEcazGhGnoAsiyDzNg/xMgv1mHxilbxSP/NIhfoU2dJnA6kgFI+oNeBqRv4PX7hWunvmxaMTCM6Qs9S+xwRwxj7eApvzpV2LI2gpD5LOfiZ4jS37jZPUZ7ILM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7373
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

On Mon, Jun 29, 2026 at 11:51:16PM +0800, Eric Chung wrote:
>Introduce a controller-specific quirk to select CMD23 (SET_BLOCK_COUNT)
>for read/write multi-block operations instead of the legacy CMD18/CMD25
>with open-ended or pre-defined block counts.
>
>This allows SDHCI host controllers that support CMD23 to improve I/O
>efficiency by reducing the number of CMD12 (STOP_TRANSMISSION) commands
>for multi-block transfers.

This is a misuse of the quirk mechanism.

CMD23 (SET_BLOCK_COUNT) is part of the SD/eMMC specification -
it's the standard defined-length multi-block transfer method.

Quirks exist for hardware that deviates from spec, not for enabling
spec-compliant behavior.

Regards
Peng
