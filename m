Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E01BCD6E57
	for <u-boot@archiver.kernel.org>; Thu,  4 Jun 2026 02:01:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70F5F84895;
	Thu,  4 Jun 2026 04:01:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="s9ee2PEW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B86A8489D; Thu,  4 Jun 2026 04:01:29 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F24884878
 for <u-boot@lists.denx.de>; Thu,  4 Jun 2026 04:01:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B306YNrSCJo2ONDLwkskU9kOzxqdFuaBtiPE72CksEKZX6P8H7ILRlcJ/GJVHe3QnyKtr3xymNBja6bEQO0q+JHenExTKl2/kggQ56Z1G+QBSchk+taYFhsKSwMhu83skmhU0w1oEx89OZHgnFB5ZOOsvc1mLxRknOMpmyA0IuqpOMO+OFNO8TLCH7kgeTQR2COBAWwzPRsOu2Qgj2Gs2Uplu24jbroQWIpZNuiobclFmYhqp4rqK7MJoaVzBBuGjg5u5ejShy20vNJedanzH5NjDS1QDZb3nzGBclK9JRD624XP3Ew61b1VXHNtCrA9qIeS3W2GlIZuernZBvU2vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g7ZPhoVo1VxjYhFQpVslRzvaHHpVsBv5u8B9MkLmajM=;
 b=Sc12mJxd03xLiDg3T1OgoUAVh4dieEzsViApSQBteDUT4+0kYR25uA4W6zOy3hTvq2cksAmLL4GqZ9tAsm8Mc7Ch/469yEgDRPwqbfwng36V/2Eb2hDi+tyGnyF4Ohn1O1gzeKRNnQgeEkXg+56+gSMOJa+Qb0cpjUI0N+dNyLpKRPAdci56Q/TZSc6G+GAUQMKbTcJwP9vWZMUAk/MaClIIwF8wZWcx9P3lqWNek8Y4xPKVS8jtm16Q/b6Y5DZaT/cpxnzfvgYyxmvA+KazHt1NK6YrYNfcjvPwwK08ATSzo3l3wJDPHyc0SzsYDotE5uL8ZxyWdM3HZKpCuQsMMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g7ZPhoVo1VxjYhFQpVslRzvaHHpVsBv5u8B9MkLmajM=;
 b=s9ee2PEWCM0ErFnVeGCJgo2Nja4fFBe6Un4kM86YNn9RYKWSbVArDcPbIbsEkXO/F7ThjLn6Jblay7KAg+EK5s2ArZVnhLk0dvT1zHqbGZNXoCCfCj7QA2kWzt9KQSHYrqQEWEl3tPjicRuJVVNpkPjaWXsO5FFvXa1iO9oNBW+NUQCbDlw8P5z0lsYSduJgut6bCddPg3OXElwmuCfpGfBGET4oxY/1s0eTBia9QVkvcEXwRxmvYuXRp8d8ExcOY3HqG6snotkO2Z3T3xFbMojQPtDm74QM2k3OfD3PjHzMEYxEAtidw6+EQpjnQMpYei9x6W/XS9kdl4WAfP60bg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by PA6PR04MB11803.eurprd04.prod.outlook.com (2603:10a6:102:523::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 02:01:21 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0092.006; Thu, 4 Jun 2026
 02:01:21 +0000
Date: Thu, 4 Jun 2026 10:04:20 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Ye Li <ye.li@nxp.com>
Cc: festevam@gmail.com, u-boot@lists.denx.de, peng.fan@nxp.com,
 uboot-imx@nxp.com, ye.li@oss.nxp.com
Subject: Re: [PATCH 1/4] imx9: scmi: Fix temperature range for Extended
 industrial parts
Message-ID: <aiDdJAkDpcc3J3uJ@shlinux89>
References: <20260603055159.414338-1-ye.li@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603055159.414338-1-ye.li@nxp.com>
X-ClientProxiedBy: SI2PR01CA0019.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::12) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|PA6PR04MB11803:EE_
X-MS-Office365-Filtering-Correlation-Id: 38503687-ce87-475c-1155-08dec1dd2c96
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|52116014|19092799006|56012099006|18002099003|22082099003|11063799006|38350700014;
X-Microsoft-Antispam-Message-Info: NWvk+vsHyf+v2xvZXEQlTmLr4/z4SEUk+WCdyHMu1Ewwkq5OchMtizES5F5yKXMpKQtQlweaUJlPBwFtBkbXKjBMkjiEZ6N4H0dXuMPu3rM/4VHy4KaZ0ztZjOrxGNDhqStOtMWwX4RSOtJoJYru2vHLEILNKensJd2jKaCfgNYCn+YKtM9kga/1yc+6/tmE/Kr1h4TCW9cAqvw+vbgG53koQ3FY/m6O5/1nfVwDu7PyyzLPQnyt37x1VwwcTLc1GqIsjAk+XPzR4SxajDk2Z3m6Fix39Tq927nF7GbYO3LtOiLDaJVI7uTJFZhFghEtAlvMe1WlIuPk9MYEowNuajIOY+An7ONS4/UGF4WaBLFAL2ehwwz1WOyhU6OfR3nmN6H600cknGEUQpiKWqMGJ65q3j5QyPk5OOtSgx3yr0IeC8sch+NttiF1HPx6Bm9sAyhzvICmzN53pBIMl02bx89oRVFJVHb2csXLgowU3XWFgZxfD5keQT3uqHDC7sQbrQ86+ANOgT4JE5LSUCiVemE6QbNu7qVHtWo/Ltk2YdEvmTE2kvlYRdp0F0aEGKV7aWvfjfzh7gmjUhLs+j7kMZWomrXktt5CbykAHPPZxPkKLxdYaclRjJQQPSt4Gh7g51+6HxylZZc4Ub2oarOUj8Hx0TiiPkpF/GNKwGwY0Hdpd625TL0XU/dMJmJ3HZeHvyXtYFHaen4iynEWthopKUh6PCLkY4EcnQGN9yDE6rTCat2Y/IWupOz3/GCNz5+Q
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(52116014)(19092799006)(56012099006)(18002099003)(22082099003)(11063799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mVLsJPfKAc6mi6bsBXTQvL5+4+PNRq1Vvc1oKC62lF6RQpBTM+cW560JoU/Y?=
 =?us-ascii?Q?Hnt+njmgxkW6+U443mWgKqVD23xk61zFFjyly2mKw8tRpj1wyHq0P0Vd16EE?=
 =?us-ascii?Q?R0ghRKFznjM1GVPfe46OsnpZ2D6zCOGMvIzMded/HJI/t3GsJYKU4vyFvytw?=
 =?us-ascii?Q?DybNOsfj7OLur32a5dT7ihjqu9YmlioVt0uaosSCi150jp3ufufBFiu2cyof?=
 =?us-ascii?Q?l8qMojRZl1OdO9hJnpxthDgk0WbVffFJ74jdoCMdn/9ou2B2zr9jgYjoX0KI?=
 =?us-ascii?Q?fbcZsQwN38TUjfzC7Vt6Gz8/sFSGUEqYB8khv6YvAaTC9v01ZzaB+YqnYnCQ?=
 =?us-ascii?Q?zvwsA9JtKwmKIebBLhhzGeaDM4EpEs3h75miZJ6l9Eh7uGn02RsXtkOwTRBb?=
 =?us-ascii?Q?kpUicHFJ65yD5k51gL/Jk3Umr8DPh5NE/Ny+pzvqmPp+POgfqCwvMCRtN0D2?=
 =?us-ascii?Q?29NCgp3o2P5yQHpxduHSAvmcEaxnLX/FtieE4DolMNbvir5+WoaU2RZzftb6?=
 =?us-ascii?Q?fNmHxHFhEhbF0rJnFn0e4Zu+LqnxEbD9+BLAagnh2Zk1IoizzX6BgoyIrjCn?=
 =?us-ascii?Q?Tey1pZsqXgtKhfThnn7FmAo2kkkrg0Zo/B9uzc2ZmsUmS6vXMltDwJZeycnJ?=
 =?us-ascii?Q?3VvOqEM1SixEvDoMJCq4N1qNCHCRGJhF+mYpC1XGcuEl7ueW7QgS7zNp/dHA?=
 =?us-ascii?Q?gYx+fx96qSwGdh6uQHLaWC8neAoiYCPXDteu5F5krDHp15YPox1ay5ng2Yr2?=
 =?us-ascii?Q?ZyNWDBckDVAidmLS1Ewihr/GwdkEVWoidspeOr1n7kDaoryg1EsQmr7rPGEz?=
 =?us-ascii?Q?WmdESk4d773tj+pu9XYzZl6s9dQvviIguCxp4hmkkMSUQZJzRZRubtQjS8XB?=
 =?us-ascii?Q?5FvW9rREwWZwCibDujoU82zZTx7Fg/+vjHNt+IFZlM5ozzPolqdB8N5UrLp5?=
 =?us-ascii?Q?KTTBeQ/EUZJhl8OIolxS/yBenKeKc3oVnXIYpFfJ1zLpDg0d8UaIVRqNtkSM?=
 =?us-ascii?Q?DrkSpwoF4b3tIteJCoB98jO15pM25tGp2HBfY4O7gTK3Lt2WU4rYfIXb4s1P?=
 =?us-ascii?Q?XRfADWgxhAgxF4WFEbVSfoDVSph6GbInDtQQcCKMBdW0uIQi8CO+C9U9WOvv?=
 =?us-ascii?Q?10uIZ/bD/3G1GzNIgejHdAe+hGQ4CF19KuHj8RcpkFvVsxy6Uwpgh8aowo0W?=
 =?us-ascii?Q?fIPZEAgOOePT8YL9E6X24+XRL+bS5FQNlt7ohofoq24/9U/B3uhs1Te/vg5X?=
 =?us-ascii?Q?gKng1wwZVF6rk0d82rKZqE7oWFwtdVOAm0R/PhWweU7fo3cGrCmB6X1o4dj/?=
 =?us-ascii?Q?f7204CxuAX6UFnf6l+qbLU9DZMs6ZMVFKulS54JP0bisJ0Wa2/f5ne9J+Ioq?=
 =?us-ascii?Q?TvFACKlt16/EjYZOrZzSz156bJqAx/hsjKYFUxAmryLunHbQ+zfpO8rVY6OR?=
 =?us-ascii?Q?cXkDOPSqoR7BSuD34EeSBtNvpGH3LjOx7PjBkCcHMyglkMPgCeuLRG/7ZgDe?=
 =?us-ascii?Q?jVEEjfMpvFhPDLo+Co2cbLInLSxiWTeH7karlUgQ2bVpFSdGVfMXZpqOBdXN?=
 =?us-ascii?Q?9n3X1MErbjW/gFwKNi3fYdl/DUnKGFTjN22+DzFRUZT9Me8ohTV8FTE6yRLN?=
 =?us-ascii?Q?ZnyyZvNr9Dcu6NoH1oyho+BlmRjbZDH0PgovN42OyHyOKR/Ljp+J90wW4Af3?=
 =?us-ascii?Q?TRxHcVq2TIm6oVVCkfym7Vq9zuXu4CBMt204UIxn8zbOmpJpIx9krqT53nwR?=
 =?us-ascii?Q?UYVjudyICQ=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38503687-ce87-475c-1155-08dec1dd2c96
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 02:01:21.6930 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vhGqbfHrLb/6ZfLmnvL8YXU3y8yRnFHClAyZNd/ViXVSiASPnkv9JXBbgfJITBHzk5a4rJL5t6ppzssoyxXZ7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR04MB11803
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

On Wed, Jun 03, 2026 at 01:51:56PM +0800, Ye Li wrote:
>The value '01' in MARKET_SEGMENT fuse is Extended industrial on
>iMX95/952/94. Fix its temperature range to -40C to 125C
>
>01` - Ext. Industrial -40C to 125C
>
>Signed-off-by: Ye Li <ye.li@nxp.com>

Acked-by: Peng Fan <peng.fan@nxp.com>
