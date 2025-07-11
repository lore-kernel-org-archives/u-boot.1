Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A42E5C83F17
	for <u-boot@archiver.kernel.org>; Fri, 11 Jul 2025 02:44:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E638836EE;
	Fri, 11 Jul 2025 04:44:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="vZCYYRiJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F35583741; Fri, 11 Jul 2025 04:44:11 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2358E836E7
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 04:44:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g6jzSPFSH16rvDZG5Fm2OKZ2qEV+GSr6rm9W8ZNusk+/7Y10yKHcK/JyZXnk0v5uRCejk1/AwPQ3IUOsXFQAqhmPXB+DJuYVOZrRZuce9edPCwg4feq7isxVjolU7DZ0FWibQii67zZAdnHMSAZiM80/3r04EXk7G6fBAblY0sc7rADKLqfFCyjRYdUC23E/3g/qlGnS38mDwJnCzXORFN2i76NqkUt8rQmBlk/4pzCf5m8T8oNrUNCe8qKfX65/43Y8zn0OXCeUOZBUbmd90eI4Zy8M3h5SyOoYMO3MUI1jdxrAyIETOW+z27bWvRmh8xvaZpIO3fivU11Q/WjTsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EV1pB9P2SJaAr0evp+5I+jChgwNs3EFg/VvZ1iKTRZ8=;
 b=b9hr4E6dhha7AZIdjnGEacBy+xLu4IROa2INYEpSKX9kKEluwEgp8w+wDeygEfKBrcyk3tYvp+UAAM51PvTrMQ/iHR7ZaOblHX1XCmQkBKsCvcmLO5iTUS8JwBXYNdHarAu19wvOg4AYoEq1FXzwCD3uqB/eCx+un6IkHujEZTXB4tJ0eP0NFsoNvXvQMLhP7oghMSOs4UHJz8RhFSSFIDAu/5DaNrdsSW+TJHm4KJWsP7rO7ihhSkLc9tIeh6LJJCadrz0RaDCMhvrZitl/LLM0jOC1ES+s6XlUosxyTJazm36999rh4tfKx4Wtanjeg0LVBgzaPQ64wKVxGbOnjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EV1pB9P2SJaAr0evp+5I+jChgwNs3EFg/VvZ1iKTRZ8=;
 b=vZCYYRiJ0fJDQ8bjEoH92K4XxeNqVzkSShKlnAwMGJ4PcIaWf6DQ1ijRavfZOfY5PcWQCWEFYwEZ6sojSS6DzSbWsfjog4ltBCXK6J+t5ksS57dTJYzL9mfwuOUyWUEGBCNunmoaxj4ncCMMYofVSK1uzBUpg+/Xhv/CyQdZ6ZefSWZjODmEjBPfBMmA2wDEFVAl9cTqftNImyX0gkVdUtKIeqx05Suq2RriRrW1gEh1OQ/D8v7NY3qnqaX/asBYhOxBpP5Gz8E/Bhm8veznY5YznAtBd9pKEu7tbydmx9ekwb8NV+okTZDdGk73WCb87V49/z9RpnEgxZNgieZ5aw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM9PR04MB7521.eurprd04.prod.outlook.com (2603:10a6:20b:2df::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Fri, 11 Jul
 2025 02:44:07 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%7]) with mapi id 15.20.8901.028; Fri, 11 Jul 2025
 02:44:07 +0000
Date: Fri, 11 Jul 2025 11:54:25 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: dinesh.maniyam@altera.com
Cc: u-boot@lists.denx.de, Marek <marex@denx.de>,
 Simon <simon.k.r.goldschmidt@gmail.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Tien Fong <tien.fong.chee@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Boon Khai <boon.khai.ng@altera.com>,
 Alif <alif.zakuan.yuslaimi@altera.com>,
 Jit Loon Lim <jit.loon.lim@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@intel.com>
Subject: Re: [PATCH] configs: Relocate malloc and bss address
Message-ID: <20250711035425.GB1654@nxa18884-linux>
References: <20250710041253.74712-1-dinesh.maniyam@altera.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250710041253.74712-1-dinesh.maniyam@altera.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: MA0P287CA0004.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:d9::14) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM9PR04MB7521:EE_
X-MS-Office365-Filtering-Correlation-Id: 6eb6edac-229f-4c39-7cf5-08ddc024ce72
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|19092799006|52116014|366016|1800799024|376014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EQ818/rchqDx0V8XUp5hXd1DZDe3bkQ/FRvKv6Z3MSO0zEvMmgt2SYIvvOZz?=
 =?us-ascii?Q?OQXQj7irSRvRJEY5c1b8g7vHkoGseTEFrpahtVglIqXu9XaVTpAmGHR5PGYa?=
 =?us-ascii?Q?dZYIaUkGT4P5eAmfmKVuRiucMRYg5BS35nXZTWWdWBEwZqwPn69r/xai3oxu?=
 =?us-ascii?Q?lPjXcH0Y8GkhPj/wtI51jwWd+6iEJlczVGa4W4g+4xd56/qMfEO5fCUdDlLE?=
 =?us-ascii?Q?vGDL+rbBs+aehRZL0eayBsb4pGeEMiKJgDQ6X34y8FnvEDEScXLKpS1AlQjc?=
 =?us-ascii?Q?mWgCZabvPqbAHBRre7mCPMaph7TX6PWwJoa93t+c1590AAR4XtsI4G+Z/TVr?=
 =?us-ascii?Q?afbQLraz6yL6jCrBP4POdZpR+nVrEX9h+804nbvZEF7m4c9W6whzkQgCwwle?=
 =?us-ascii?Q?9tUx2hXWz0izfTLrx4bjT2CoAb3UQwyulX0e8StDp7aivvW10csdCpZ6w47a?=
 =?us-ascii?Q?ZJrNEZh8hJuAJTDEKxt0NFTPGtzntiH9BYoXX/ShuMxExydDD62CwwmwR3kv?=
 =?us-ascii?Q?RwcRGIMymUSHSeDiV3jckVjWbh4YbFgP/jxucReAo0F+me4gT3KWhtgOZpGr?=
 =?us-ascii?Q?7x3GxV20eHKhGXPBFmx0bu8bP/ubIYVZQBCy41iaC3LNVCU33RiPplh/F0/Y?=
 =?us-ascii?Q?B5VBvrz3bMKS9whnPr9M9Y+Ct/nq5/TWktdqUXSIy3ttwq5YNsdsVWXolehk?=
 =?us-ascii?Q?m4Wkx9ZpB0iW6ZvXJbkrFYyXuwnvW9WmtXvxDr5YJTUxid02Vz7Efvj3lPwL?=
 =?us-ascii?Q?gD9EhP8dr6IEmrZygqj7U5cs+6PE7htmZvK2Xo3urcozjHOMn9kex4Hk1p25?=
 =?us-ascii?Q?qH6QvQ/+T/hw3VW42jeUbCqfR6sdCx7nuh2K5H6cB4EUfBa2j1UsipEsHRCN?=
 =?us-ascii?Q?Y/hSn0d1OOoa3L7v7lHgo9Le8LSvuVGf4woi+G2qz37KTVRXF8hsPECMMUF9?=
 =?us-ascii?Q?HssXp2HKobj5sYFOrj0us0FI8SuW2e9ySJ91o630lwXclmehTQYLY4Nik+CG?=
 =?us-ascii?Q?KITY74dI1VwiZk+jadSvskzEBxPRjHqFiuJ5C6cuBrAi4WMogKcxKEKfs+CN?=
 =?us-ascii?Q?AgA235/9s/aF5EzN4yzdWPNJKUmvq0i8V9hbGZYBNlcc02aKIW9dYhC38UQp?=
 =?us-ascii?Q?5T5btkihlWzn+0iB/fdAaFdBdsxwXSVocKqHq7QlhMvQYybTFTsl64G3GiS4?=
 =?us-ascii?Q?V6Zx4kMwZuBfPllRs0ktJja6ZzjJ/jFZHfBWkmpveY6FKC7YCdOt71Y6urQR?=
 =?us-ascii?Q?Thgc6/9tU4D3RmViQwHZtMuEFrGNJUtobc4QjY/6xhQYX4NQ81PfiyiWMjHM?=
 =?us-ascii?Q?EBkzoSsd1w7MB1cfexXO8dT1ed8iE8syXwn1Rx4cvEmoiJgYwnl5LVoIIU0X?=
 =?us-ascii?Q?IjAr5qMaUPAO+mI+q2Kg5sh4Wi1jFkuqh2R+NLuW/lL0SmR5TQWLwKQEzh8D?=
 =?us-ascii?Q?M+Ws4s2rresUK9nunI6GSbbexy2AQfiwrWPv1ltmto3nVLyAMuIiaQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(19092799006)(52116014)(366016)(1800799024)(376014)(38350700014)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RTUSJ75Ff518MAqjvd9cpiNY83JLfFpPozpWxfvtZGDgkVseVsT5haNWNpvD?=
 =?us-ascii?Q?pV0Qpk/hrkXo3+l616AGvRnEduxSsYPTdi08b2eqtpB5pMJerfjLXGqUAFaF?=
 =?us-ascii?Q?neWO2RR0M3qgNw3H28R7cxPbeuXuDfvc5k/CjmfCmXHbdxrVPUCuH3R/GcYS?=
 =?us-ascii?Q?GIm+6RoTGtdlPf3F5MvotxwKslEk2KK0IFjRjtB4+QljdZnNMlcdbYLd+fph?=
 =?us-ascii?Q?gZ6lbck+cFWOjc19AvDr+P2rg4+5zMlTEJQbSas1sWulfxqRlWFABEurkfSC?=
 =?us-ascii?Q?kvwyIYGNOEjtl9W2pzVnB4MOx9o/FxgYtObl3HKheIyrUOgK4xWNVh2cmOKg?=
 =?us-ascii?Q?+3Wo8miQKp3fj0mFhnnZehxs04ayKSw0n0va70tJ0iPwjJfHBfI1MHnImK23?=
 =?us-ascii?Q?JsHxSdRCpaTLx2HYlV1R9T7ps0q6sD5H1mNDSmv3zfAnyLYIyejbc9gxm2ZG?=
 =?us-ascii?Q?PreNkf+NUioXoUi1Ap4LzgPyJIWYhtxhP7RQoqWl0drYG65M5G40+8QQIEjN?=
 =?us-ascii?Q?rHIzq4RQ/XIj8MXiKXsd5x5TAzqDadd6o2qiu+k2c0pu4MvN3GWDA4gtPyGL?=
 =?us-ascii?Q?5qxiWm4d2uR+Uye05CNtV3Ln4eln1fNVHItNxeQ7u3vRWUz/+t5weAd2meAL?=
 =?us-ascii?Q?zcr0JDwQ5X0U73vprnrRcIOKkLBJ/ds9Domve4V1to/dz7PA6wjYKX5c41pQ?=
 =?us-ascii?Q?K/eZKL2IC8ihLdbtQlvqu83AyAF7f1uh0uJc8QFTc6Bkm7YVbfEGrS3/uFsD?=
 =?us-ascii?Q?0aPyWyUy4Bo8rwgxrs4qoD8lEtoZ3LuRDgWGcjmB+fwNgRrBpNL1PIoENcIF?=
 =?us-ascii?Q?rK4Guhoj92nJtGP0NV+UdUVyCUf3bKVms7dPmHbjYptDGYqtl65AmjWpXK9W?=
 =?us-ascii?Q?NPaASvxZ7TNtsjlptpZhL7PDKq5kFqsTBGSWgj5pgWEkOeCnDW5R3Z7CtVxF?=
 =?us-ascii?Q?N0Sjj5ZeJBU+TGUeBfaoGBkE4XiX84/viAY0Dxjf7oK+jjowVrmmPrQkw3t9?=
 =?us-ascii?Q?cVxAWhHFJLksIFm6j0mo6U542I/wIddWRF1nZoCYRvjQdqFmUqT2HkhipW6H?=
 =?us-ascii?Q?HS61L3WPWmQ2Oekmx6kBfC7xwY8V62MygRiwHZ6dZFCEOv52+zmc+rpY/iI7?=
 =?us-ascii?Q?+T60ETC8i4Dld9hbXYsdhMjr7CWhrFlR0X2y+X2Df9dvmw01W/lZP2xBBBCA?=
 =?us-ascii?Q?lwhevqrgEKmOjABFzsMutZCsZFUKIqjahJNRRJHGoSEMaS0qRIFEgR6zo/qD?=
 =?us-ascii?Q?+YNjeHJ0UKE+DdlIeuCOFXhEc4xrZpZ02QKVdEzvgKo02zUqqzR28FIy4h2S?=
 =?us-ascii?Q?V/jPzvzGmt680jxlvAXFUfXEPAkOEavD11nCzg38VgKl446XjQR4gJS+WedV?=
 =?us-ascii?Q?9GeEY8K6xGaTL89omfS7QdE3Bw9SnqpJAxu5WhXaucWQvcsM394sM0MjqIja?=
 =?us-ascii?Q?T5dzRhMrFhPIXebrNnDKmmMSm2FZOx0z9RULu0ap/o0k86pNRTw37PQhjsM3?=
 =?us-ascii?Q?XdQIW+xyzYKMj15PUX9wHO7Jo/WYJFT3+kuMSMopPTo79UjEHGhBDDzrErSV?=
 =?us-ascii?Q?ItEooi+1IT8jPdYGfRU1NafvlqZfNx0c3LLg646b?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eb6edac-229f-4c39-7cf5-08ddc024ce72
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 02:44:07.5421 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kNLg8j3DlCQp+CXBSYYIk1yCOdw6qlS2tBzZc23oCE6Hj32QBHhvY6Lgq5vrNMFx7ClgBoXMUa7CZwnS/8RUEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7521
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

On Thu, Jul 10, 2025 at 12:12:53PM +0800, dinesh.maniyam@altera.com wrote:
>From: Dinesh Maniyam <dinesh.maniyam@intel.com>
>

Nit, update subject with socfpga_agilex5: config:

>With Inline ECC enabled, the bottom 1/8 of DDR is reserved
>for ECC parity bits and must not be used for general data address
>allocation. Previously, the SPL bss and malloc addresses were allocated
>inside this ECC parity region if the DDR size is 1GB.
>
>This caused ECC hardware to detect stale or invalid parity bits,
>leading to data correction attempts and DMA polling hangs or failures.
>
>Fix this by relocating the malloc and bss to the usable 7/8 region of DDR
>and is fully ECC-safe.
>
>This change ensures reliable ddr address operation and
>prevents unintended memory corruption.
>
>Signed-off-by: Dinesh Maniyam <dinesh.maniyam@intel.com>
>---
> configs/socfpga_agilex5_defconfig | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)
>
>diff --git a/configs/socfpga_agilex5_defconfig b/configs/socfpga_agilex5_defconfig
>index 4ac0a5d9b99..01c5ac88015 100644
>--- a/configs/socfpga_agilex5_defconfig
>+++ b/configs/socfpga_agilex5_defconfig
>@@ -12,7 +12,7 @@ CONFIG_DEFAULT_DEVICE_TREE="socfpga_agilex5_socdk"
> CONFIG_DM_RESET=y
> CONFIG_SPL_STACK=0x7d000
> CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
>-CONFIG_SPL_BSS_START_ADDR=0xbff00000
>+CONFIG_SPL_BSS_START_ADDR=0x9ff00000

Commit says bottom is reserved, but here bss start is moved to low address.
ECC area is at top area?

Regards,
Peng
