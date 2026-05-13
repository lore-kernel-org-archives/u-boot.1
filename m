Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDB37CD37B6
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 09:58:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6555984671;
	Wed, 13 May 2026 11:58:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="e7b4rPzU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1866184674; Wed, 13 May 2026 11:58:44 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 545498341A
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 11:58:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ItNYNJ2ouenu6+WCtnFDLze42gRas1pBVRYA0+BuCEjQk9t3IZLCOQvLlm3Q1Jf3b3nnJp5XIrfDkHoYdEIfpFGWXKX0oFvsXEHA/LhHY3Xfa60QLHFYzVNoIqDq/ZnmoGEk/eacQsl8gjzko5BO9T69RGAaIS1GQlVsogGP4CMEdBKneCD9gkw2qUlq9VhAvbec8+g5h4VnrT1fp5QR35oqLU1GFzBr2W2dHm9GBUI2YyD//uKvQxJCMZdRA+mQjq3wJ4nclMiIVQ+yf4cKShAjNMPtZrYyclRCUYssqVbEFxFiamz4VrdYUlUQs3g469tKpk8TNLtgb5DnMUjoPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XnQvOsr6/OTnP0G+7AM9zRDv0TPDZTpmDmTLIwDC8Vg=;
 b=AK9RFiCv5ckpoXxuKP1j/so+EsNQBxi/Cx2q6VvprMisKjgnhZN4HHuU47gmFCuYFfLhB8A/+7JWPgOqD9tAZ2ECCBXmTq/CjNRCJ1OrfbIlM2J6gtg7pxJ7G9pedp2/LKtVAvSvJw6bcEodNFMtHGS1fM7+L9P1FW60QIuhHH07Zz74NRZ0ZzRylr7TNO+d8P4lCR/SQEUgmw3FzdiYktQ9eyfPPSljKOtWWKNdPOPd14M3No6UJQ2/imRqthqtGK68YmtqhJhkUAft24odYUhjucSqiGBzNFI2ka3CaND2+HPELqhRUNxji37qTVdCtGBjSKBYcWwUXVGPtyjQjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XnQvOsr6/OTnP0G+7AM9zRDv0TPDZTpmDmTLIwDC8Vg=;
 b=e7b4rPzUmOcA6GPbzrpBlvdJ/cmIeEaSzLbonL13zkitjtIjy8e0UqIcvAnHQ7SVr+lNjoahF4X+WlWfCE5uViUR/Z4poyX/mxXGd+neg24XH4Noi151suBXaNPgH6pI2w6s4/DNw685uRfNeMLdgJBLSTG2SinBMvLJQSXHGDUupcKCdQ0vdqQ6HEBjDWjbab7Y40Ks5Zsz/DV4eTSF9PIejklDNoqySNhAiyU2A80nTXyMKAuX31RRoVjXeqUvIIHXvK8Tvk+iqLY7DfKVGdq1CvxZLHaduI0mX8XaggpCSryztj7eajvlJqFB1IUrY+LkkuXPwdPEmmSV0DkmnA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by PA2PR04MB10085.eurprd04.prod.outlook.com (2603:10a6:102:3ff::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Wed, 13 May
 2026 09:58:40 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 09:58:40 +0000
Date: Wed, 13 May 2026 18:01:30 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Jaehoon Chung <jh80.chung@samsung.com>,
 Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH 04/14] power: domain: imx8: Staticize and constify driver
 ops
Message-ID: <agRL+gnQQp10EPKf@shlinux89>
References: <20260508122247.512862-1-marek.vasut+renesas@mailbox.org>
 <20260508122247.512862-4-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508122247.512862-4-marek.vasut+renesas@mailbox.org>
X-ClientProxiedBy: SI1PR02CA0044.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::6) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|PA2PR04MB10085:EE_
X-MS-Office365-Filtering-Correlation-Id: 45cc9a32-23db-459a-0e23-08deb0d635bf
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|19092799006|52116014|376014|38350700014|56012099003|11063799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: PWYmlhDkDjmCE23Hs1qTHauwyMOlT+80PlXD6d/otItXUXWrepLolbGNnhzaLyVjPnhn6zW5roM4np45CX35dJYyae+L1kii9TnGXNnt2DzTCdD+YOCJ5uzY4oniNgaSJrjonOVq+0f7mqmOCgwO20npsp9GAa1EL38PDWapAiLpOoWRSzh5CD++Lv8vuBaB3e0kvrutstddTvAv2A2PNl5znY7ZWT/uLy23ebK1Upc8YPk3Bn+iecKOVTNLBSD80kXvKEepKIJmkklrK/H3oXhku+LFXPWNJGyW4WxSy1b4xPVMHX4GiF4oZPKpZ9sQXFIBm9YatlYZbHd5WHUgN+IQ79t782zuSOhwrMkx0FVsLTr+tw8BKcesor460yAmF9x9Wnw2aHOZCwvWVEpj5i0VvORTRRaObyZYCGF+UBMiwXal+oRApDWxYoL9QSuypbtmSNUgNwTyCFGHt0Eogx8CLT4GUitrd/7ioJ8nTso8cikSFMM7mDHCfoWfHodDAjgiVnet5kGwXsEcv/KX0xOW45RvKGy+oWD0BjlemjlaaE52n2ZcSl5Bv1tgp7cq8wDa5HOiaDqni8q6n7fvwPGn5iQ5MrTW3AGuElLyMMJyQbeQFfLdJKqHU33q3w5hBUQT2ilaNYXKnHY51V7JLp6BBd+j8EQxbN0gXB7Y74MFki+TN6uXvKWt8ohac5ou+D67vM3v6flJty9R4VhuNw3hewDuma3VAebe3PQc4X1MEtcmE5Znd0SaJNSB6M1k
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(19092799006)(52116014)(376014)(38350700014)(56012099003)(11063799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WbLLjteMabUuLjeGBGp8zfc5WbrHv1fkT2G/XNmkYuhAFZcBNAZ1PP0wOhwp?=
 =?us-ascii?Q?NDUuROqaw4qBGkgURfPrc1YFOMMG0zQwKVjJ7LqyTkPRc23T+LnwN7P1pRu4?=
 =?us-ascii?Q?k9JqvUVMKiXvUXpA8CLO5p3kJG0mmyISJGV/srukfoxBt5yX6K7yDmuw9pmY?=
 =?us-ascii?Q?fDsM77k4JP8xVRKp5/HiSJzKkmccvqsPdWjfpr4AUCFkugVE+e/LBVTgmS4Y?=
 =?us-ascii?Q?xqZ44mn+7e5+eCM/HGTm+sFADjQjeF2KIAaX+7etzgJqvu2DFsnwb+LHNSQJ?=
 =?us-ascii?Q?Cq5OO/jZi3lOlz89jSuJ/WS+hkorjzKHw317k5KpspqHoqvn87j4isaM5nIh?=
 =?us-ascii?Q?VsHAW0QyHabYa1jXYQYhB6udtlbvPQJbY9agBTLxt8yWr/pdaeRh3VSyXX31?=
 =?us-ascii?Q?/NZ8hqYmmjZJbxZkjjgZKWogp8ruSD0u35GQcyeuV4HAOWadadSzPBtAjUxy?=
 =?us-ascii?Q?COfNGrGkNWbI6pCg4IdoxWbX97qQCW3uznFhVOmvDCK4XxqqNh8gYoxXe45Y?=
 =?us-ascii?Q?vX8qft8cjw9OMBzgE92WO38v8XcWvVymkveHpWZlaZbYoRsfCQdjsuy8PI2J?=
 =?us-ascii?Q?Ez6CtzWzuXefK7nhrEOJbUVVfA2/rOlGWRs8MFfJlFrtYJJkcYRjAlPlbAus?=
 =?us-ascii?Q?iTis2uxDoVoNjLJLUPYoqq38rrbUQ/ffc2tb6JT/IY0dffNMVLsA0so+m+fy?=
 =?us-ascii?Q?Vv05t3yIzdO18QxQwKgPCxDP4cirtLpzChAAji/suuucMdHMXHELA73MGl4h?=
 =?us-ascii?Q?XMvMEFHlPJaBTauUeT1FYDRUVRR5khooFmx7X1OrjME+GG0RLLemdCd1LYyf?=
 =?us-ascii?Q?c5ZnWnHh8rQ3cX3WRJev6YwdCtjYx+CSigr904s7gxOyR4f6sUZ/em/8Xpqi?=
 =?us-ascii?Q?VtatEE2cjecCZSHkm6TXsyOmHawVYOKWYBZc6aBRzlWM6qJWIba5e4Vemj9V?=
 =?us-ascii?Q?s4Pe6pYqzCil46VUZCx2wo/laZ7RIvN9c/4cLJGqk5ID5rpzN/NhAcNh53A9?=
 =?us-ascii?Q?tCppzKFy/1rrgVzagxvqOuBrkd+PFCkx3aEBQ7ZItXwm6aDsxT+roi3SRa0/?=
 =?us-ascii?Q?fyo6wEoWaoMbYCHeExugtbQwjFl7v+5wsFn6WCjwZfv43PPyCWfPLs79EYDL?=
 =?us-ascii?Q?/CigyiVW1ueKIOLUGYEAXCbmynotwFoWVu1fgkuKCu2c6VVnD3/sku91ujMC?=
 =?us-ascii?Q?oFKr2GfxCLEIAcusSKnDDiHVEN0RfTtQv7XRb3oISpYpwCSzWd4ElGTtxARx?=
 =?us-ascii?Q?YZhbVH0f1+4/rQIe+BLsT+wK2CIcYhzUUiduULjkQKxqDf6mOKOs04pBDi/p?=
 =?us-ascii?Q?NkAmxCm7m3FBioMqhZO4ro3gjzLMbYe8mHVBafDKUATIzdweCZ0qMWlfaYt6?=
 =?us-ascii?Q?b3zOHj40AvH205Z/qDrPBJE3zZ1qzN2JaX/XcmJXg0ENFj1+mXe0qc+2/4LZ?=
 =?us-ascii?Q?2ZqTU1KOL6wjKB0nE1hogNNLLhdoUuCMGIzC+6KPNpCrni3d3Yzo1q3pCDnn?=
 =?us-ascii?Q?pwuR+/6mBStEVWHs16rN8H1lej5X2gVSpQBu7qAs+NNCkp5/QzMsS3+GB403?=
 =?us-ascii?Q?LErJBizu5k1DUB6tKP5vlIqR+Ds7qWY0nawpZSLcthMVX5mNM5eF5q9nefX7?=
 =?us-ascii?Q?dBuhql2WVY0kDGP8bYwIdBkpsarOVfBjIQ/dIMFdcA7o+fFqlfBfGV+4J42b?=
 =?us-ascii?Q?OWMMgC+SpdVTn5KgrHP3wDLqmDx/on4mkw8NYytnaWDw983sNFo6WmL7XbCZ?=
 =?us-ascii?Q?b6nIKQLNFQ=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45cc9a32-23db-459a-0e23-08deb0d635bf
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 09:58:40.5295 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s2TiqfrI/5PwF2qxfkANWgMJPT5YQB1n+L0VFTLyKwz+LxLMNDVe/AO0u+AfDXZansGeoUHxipjjaPBCA0Fchg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10085
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

On Fri, May 08, 2026 at 02:22:04PM +0200, Marek Vasut wrote:
>Set the ops structure as static const. The structure is not accessible
>from outside of this driver and is not going to be modified at runtime.
>
>Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
