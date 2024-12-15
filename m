Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEBD1E7716A
	for <u-boot@archiver.kernel.org>; Sun, 15 Dec 2024 00:57:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 286328006E;
	Sun, 15 Dec 2024 01:57:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="dliGszok";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2AF2F8006F; Sun, 15 Dec 2024 01:57:54 +0100 (CET)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on20622.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::622])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA4C88006D
 for <u-boot@lists.denx.de>; Sun, 15 Dec 2024 01:57:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HZZvAIGdok2CJmb7obeUrhTyl2XiTr1cL0R7Wdm8okp+C5ti84EahX32Et/eokql8iRT5a3WBW/rczXX3ObUfQxnDovHKgbBcxinTGa+zhImTA6duAnyP/OgV+CfSBeo0WcOcYOs2Pxap0mWRMWF/Nx+m8AGRGHyguouE6gkHfZtJ6uBon5G0TCdqANI5alQB/nnApC8KGYzeIlzdBUHuE1Ne0awE+AEmNbpQKh5Clf7zqYyo40La8r1TQ0roBNeN2iJm4La/oXe5OsTqKwEw0ptB2uKv7gk9AEV6NOLH7qCb13xSwComQppfUKypv81GPIJ1hc6mUQbLj/orB+xfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bINErZPiggfv/wjoQaxV0XR4HE2kjM1uksoAoPIeHko=;
 b=HvUlRSgnxw/pF+w/fQiG7zoQpK3Vdqq5pbMWrSQguZapEkVT5ZFDmOv5NxmLXqUfQJsEeYRqVxpOzFRkn6b7ASwEzcJhlt89s2FNm9FGeMIEda6VG5/PRHBJEamsQxxtsBgJ/8RbZnGLGwxplqU/f9uMjlUxKoQPN8l/SecEQRuc3S84iPM0YExaP8D6XBfEXtkkKHZYaKCpcmLLKd+PpwKcm+IKhoPjPHEFjkFIIhHPWd26CIkJMZggNxPd1XwOqKiWKWHOvG7mFi3/XfVWQe4fKX6FmbSc+5b8nIRkO2yHXHhDX5z5QOgHLPmMlP60oWvK89klAoBmGHLd9Gu2kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bINErZPiggfv/wjoQaxV0XR4HE2kjM1uksoAoPIeHko=;
 b=dliGszoksCsSQfbeOCG4XAR3pkzBdocp0DfcgJxEz5SSO9haA75VVhGQoTBNzvvDYpGIXr01Z96dpUqcHFR4+2KRZ62kDQlVtvbBxQxTyQ4/KcLo0dJ7W9qz0xCWl23FS1F6iUFIQVszTOCchi1eI71ioPz/njdovL1hq2/jR3Fy/mVZwjs0gdr3dBxNiSfA4+nCUR2DKtOavwq1Jq8zYocOecUCFeNl9VheCmXqWawXEVNeFFyEAaI45UIuSL9qblvkLdstNx+EVNSO3DT7iLbxquBNZCdAJaLuixpyOmxJV+TRc5fG1fcfhrHwQOTIoMWtqclaFuIB4QLENirLNQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS8PR04MB8165.eurprd04.prod.outlook.com (2603:10a6:20b:3fd::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.19; Sun, 15 Dec
 2024 00:57:49 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%5]) with mapi id 15.20.8251.015; Sun, 15 Dec 2024
 00:57:49 +0000
Date: Sun, 15 Dec 2024 10:03:10 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Joakim Tjernlund <joakim.tjernlund@infinera.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH] FSL DDR: Errata A009942 clears board cpo_sample
Message-ID: <20241215020310.GA20741@localhost.localdomain>
References: <20240919140027.409614-1-joakim.tjernlund@infinera.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240919140027.409614-1-joakim.tjernlund@infinera.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: JH0PR01CA0086.apcprd01.prod.exchangelabs.com
 (2603:1096:990:55::11) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS8PR04MB8165:EE_
X-MS-Office365-Filtering-Correlation-Id: a38c21cf-e168-413e-e9da-08dd1ca37f01
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|52116014|1800799024|7053199007|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7PRsMmodFF/q6BRCyVvORu4Fg7rHkH+ehtl2lDVV1qv8yXZZVplCQ4JoUeiL?=
 =?us-ascii?Q?+DlFSzONGHTrfaLe6jDsiSmqJfv3/28bsyeG63YJ0CjIZXc+IUqlE1ne9wvG?=
 =?us-ascii?Q?cQ3Nm6EFZsjULklmTcxbEYH9uRhxbYhs9RKVbS9WehrKDXW65jB8RMdz9Nqn?=
 =?us-ascii?Q?4/D9hMNnCaWswl8R8DNpJ5GzLMlclo9HiYIpUtXKlYUY7abamfRpyosrfeLN?=
 =?us-ascii?Q?Eqa0Zq3hfbpnwSJwJz3Qgk/7t+4IjjhKCwgzjrGNXYYRw/BwKeX5bScO8oSA?=
 =?us-ascii?Q?MwVBHjhq7ws5K7u27qICO+xhomU5mPmCg5Aqcie1WGi49p5oFjZsisPRZQWJ?=
 =?us-ascii?Q?WuiwLOKQu97944fQJbBE7T77mh7fcNAiFfLcv5HVtQnFw3GggCOOY0LZpjiQ?=
 =?us-ascii?Q?AmxYPki3sUAZKSrErpOJt0fmJBFckiCjdldusS0R9IrVmtZh0ZWXrZ0TLsnD?=
 =?us-ascii?Q?JM/lpcZyzfaNvBY6wL9FggAdl1kbf2uFg2VE6QHQJ1Gxg97Z7+6xp36cm1ea?=
 =?us-ascii?Q?YqczoHucjhH9M62X3SIQNhXHKChF1Enye7DLeqHJv+5oPWuI2KcRFvj6KhU0?=
 =?us-ascii?Q?JnhjNOdIMSJHOSTbtmkx77CcHGBAORkR/eUX1/LRZIzfP45ftID6UON+rHpH?=
 =?us-ascii?Q?0jlYf2qNwB6rqLP3S2pq9au9JQbkxibFVmc6uC1LOCdrP2NHFwXUG3nfsfIY?=
 =?us-ascii?Q?nmpIUp702WyOs7gdRoxaq/NJ6jpD5Cjhfb543I0DnhBqc1NZEZOPRfa68JXV?=
 =?us-ascii?Q?16vuonHZ96PoqZ//qM2aKQ3gDzw2ODnelxmr6sokbGogPbFnXjRmf3XIrSXo?=
 =?us-ascii?Q?C7yp2Bstu+Ghwj9dYuzFq5y/bzZ6KzTDlAwv3XbIN9fe8HZ8UBrMsieLsS+3?=
 =?us-ascii?Q?C3bjE9KLELfK4es5GOCPWfq9RtwC80blJuZoloLGLBX6+S+HpqbI2lkRyODV?=
 =?us-ascii?Q?DzRY58B5+4DR1FLrMgd2TpwrwXhB5eWhlQ0mU6Ujqpd1xvC9RUZ+OU/QJQ9a?=
 =?us-ascii?Q?KXepSFfzqHoocVgzRqD1zOaTxQ0sPi6nWOLb5ZPfNWjfaDB7mRCCb9kPlwqg?=
 =?us-ascii?Q?nvuBrNiEokBchJGKI4oJST9h4eBuYM9ugFVvUXqHefSNwWlYjxkgezEiMm6g?=
 =?us-ascii?Q?S8PwKpafIC/MKmofWsTaRlc5XKakdoAfzFJxwTyrCKGuy8rx+ZH/3SYN1ofU?=
 =?us-ascii?Q?SCJTHSsoIA4HwO8cjRHdYP9Babi/cy2cJg54TnrKXltt7hC0senZXZxymnOG?=
 =?us-ascii?Q?UdTvKigDoCVgBRhCGzTj0rMMLwlRld5oZNWyc2OJWkR+7RwqbgLlxmcokv20?=
 =?us-ascii?Q?IABJivuugQTFQQM/U4uGqRQKbCDfleku0do7mPg19cVeq4mMOwSFgVWtWcRD?=
 =?us-ascii?Q?fOYgOsc+e4/PgXyed1ytv9AuSoodHB0GPXutb8ljew5ZWT2mPIXwYX1P/NtB?=
 =?us-ascii?Q?JkXLYU3BOC33jP0qy7Mz2n97mMn/Bpzj?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(52116014)(1800799024)(7053199007)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0i/gwxB5zUPmRxHDbiaCnhgEm8rNrAJNVUEtaBiBCgI45EwdMBfuI014kalD?=
 =?us-ascii?Q?MvQc/QF6z4pXLIm4beCh1RFpwdIpu2+W6tbtObo1w1YSYBW65X8nXx7KWL+l?=
 =?us-ascii?Q?nnUgev6g2K7d/3LR6SJHJAulCN+rz8uOZJpcgxIwfGtE27aLDpxQKNsFOPoe?=
 =?us-ascii?Q?ZXF26ZNw3ZUFA3dgWR7dzwaF3awSJuk1PRaVhNLi+PF0krn/41VqY+Xa7saI?=
 =?us-ascii?Q?LeXCKffwmA3xHUUnDW1ZnsJA7DMkCZjw4Am1fzuH3qBi26HY5yV69Sc209gD?=
 =?us-ascii?Q?5djpo2/LXnfuXYXK5PFu0xSKhFc/hsT8xr4TOHtwP/AaqWOetIdXnL9mWGqM?=
 =?us-ascii?Q?ty2+P1YA04bRmlXCCd1T5d9fCCrrO8bHD7yAZp6o2R1QO/XFcmOo98rw1iYU?=
 =?us-ascii?Q?/tVZuzMn04eSLFoA7RrzDShBOVUdBdxuBHPppoccp0eBvzjHCL3EY3kYRYLB?=
 =?us-ascii?Q?hyymzGBmGQAl3MbJyyAE3Go1/lLFE5BZoNNMweOm8iIKX3SfbuOmAekvDBAf?=
 =?us-ascii?Q?7cimunbC3KCY/kf9ZBwEDBxBSZzamZvvhRhC2wN54TuONWHTXLq8fMo9/N13?=
 =?us-ascii?Q?/k44n8wSR9s6n9n7JyLUnroE8mXKFruBP8MmrkG/mzGtKqQGHJk7l0E24AEJ?=
 =?us-ascii?Q?yYoM82hy6qk0yISVDka46tGEje8kZTBMy5ZSiIV5JuwzbJBMJpfg4eTknA5l?=
 =?us-ascii?Q?dFKXdrrWjGVb0Eio54X5YGy9w3lhXfNgwYJELnHa1VeTfoBd2BWDqRr0cG90?=
 =?us-ascii?Q?cQWRjhrbZN/38WgHPs7QwjttOu0KLoDpOzqGSTTjQNd/lOYFpnvuLUAR8pse?=
 =?us-ascii?Q?t5cWPvw7s/xV1QC6JSdyBdxQMeiKS43etnK924sTTKSX2VJvCAo/wgWSrMB0?=
 =?us-ascii?Q?Ldj8SIEDUUOesuV7G0qrMxtfrZlwAKUFVZrXr4rZ0cB4opUpaVaija3uHQ0y?=
 =?us-ascii?Q?C1GGeoOrb0FIso+MsmrFjGWD75UlLDALFMaEoAs8DN7kRI3G/Vcs2zjGk6H7?=
 =?us-ascii?Q?8FIOndCzCH6iYC2OD8JG/RMSCXVLRcE9kP0nKOvcl3QnyYCCesr4axt28IK3?=
 =?us-ascii?Q?0ibl8DtrU2WQg7ZTpcme3NUylZ3mWAxFtao0VLIJKvms4fcTSrI2jtFL3yDA?=
 =?us-ascii?Q?0Gl3uCL1j/TgV1gcYUMlU8RHK5ian1Umej5BOVbBTvDxtA1jMQeaAYUfhca6?=
 =?us-ascii?Q?+AV/yo4sUg157HkQeoojB5dEr2RjQnVqGmC8pMqq/T8Gt4ZTFf0mKLxWXQIV?=
 =?us-ascii?Q?QnSSbfntHSSxg12fVGPOfWAF1RCYFVH71X5c06m1k9TSYNENgk+LVW0IZ0F3?=
 =?us-ascii?Q?b8juiGjwlDMYVNswWCWOxlEYvBWVzg+YYfmzDoEtOZrmza45FyGjXc1QjGzz?=
 =?us-ascii?Q?3TFs6CsaNLiGxyNbg6fnNd2nPWNbt/8chPpLeekDXkVa2g3yuJ64sIdragA5?=
 =?us-ascii?Q?fbP0HRNiKUg/pXpEdsawsHhHUjDP0+1/vD6GeZL2tzI6pLBkoyNm+wXszGjc?=
 =?us-ascii?Q?5fbZOZ+IePeL2HXG5P6TCfDaGV0ZMFxq12BsN3EIkCpRz4cmHMk6Y6LMhg1S?=
 =?us-ascii?Q?w9Gs+kTm+vS9SDl7hij7Ymcu+OCPmA2b5jXJWQvI?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a38c21cf-e168-413e-e9da-08dd1ca37f01
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2024 00:57:49.5115 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UUonm1PRT9aHT851eWGQxNrASwH7MNJbppa8+Ce6/f49/YlfjrBSYTvGgJWfMArURApDv30dWJYR2PugK/p05A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8165
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

Joakim,

On Thu, Sep 19, 2024 at 04:00:16PM +0200, Joakim Tjernlund wrote:
>LSB in debug_28 register is cleared here so
>previous setting by errata A009942 is lost.
>Save and restore LSB in debug_28
>
>Signed-off-by: Joakim Tjernlund <joakim.tjernlund@infinera.com>
>---
> drivers/ddr/fsl/fsl_ddr_gen4.c | 4 ++++
> 1 file changed, 4 insertions(+)
>
>diff --git a/drivers/ddr/fsl/fsl_ddr_gen4.c b/drivers/ddr/fsl/fsl_ddr_gen4.c
>index 31c58d9a8e..1f8ff87a8b 100644
>--- a/drivers/ddr/fsl/fsl_ddr_gen4.c
>+++ b/drivers/ddr/fsl/fsl_ddr_gen4.c
>@@ -477,6 +477,8 @@ step2:
> #ifdef CONFIG_SYS_FSL_ERRATUM_A009942
> 	ddr_freq = get_ddr_freq(ctrl_num) / 1000000;
> 	val32 = ddr_in32(&ddr->debug[28]);
>+	temp32 = val32 & 0xff;
>+	debug("cpo_sample:%x\n", temp32);
> 	val32 &= 0xff0fff00;
> 	if (ddr_freq <= 1333)
> 		val32 |= 0x0080006a;
>@@ -487,6 +489,8 @@ step2:
> 	else if (ddr_freq <= 2133)
> 		val32 |= 0x0060007b;

The upper will set new value to lower 8bits.
But your code will make the 0x6a/0x7b be
restored.

I not understand well on the rational, would
you please give more details?

Thanks,
Peng

> 
>+	if (temp32)
>+		val32 = (val32 & ~0xff) | temp32;
> 	ddr_out32(&ddr->debug[28], val32);
> 	debug("Applied errata CONFIG_SYS_FSL_ERRATUM_A009942\n");
> #endif
>-- 
>2.43.2
>
>
