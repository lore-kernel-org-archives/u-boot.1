Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83522103A9A7
	for <u-boot@archiver.kernel.org>; Wed, 25 Mar 2026 11:23:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0FDA283FC6;
	Wed, 25 Mar 2026 12:23:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Cc5n74Aj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B8AA283FD9; Wed, 25 Mar 2026 12:23:35 +0100 (CET)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB9F483FC5
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 12:23:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=emUvqFUfLqt2CXM71hxwfUyE62bvVfph/01opHWfVX7hGpCYTzwUb/q3A82WmJ0moU/TXj1asMWUWKr9MMQJUMDPrEa8hw6aKz/GucvoabmFK7aQ7bLQAdlL6EnuBpQLKJ00xZ3ZvjKIqcUXUQhnvhLWugiF2F8/bGLBST0eipqjYzLUc3lRRjz2Ufw9KeGpXz0QgkB/hUCBqbwlH43h9SXJgvGF9aOW00bSE+92+cMTN9ckIQf4d1tS6TnBviUyc3ltF6RZJOy7VJYR/jSYDfTI088Ofxt0lvUF3m7Sz6Du99NyLNq7ypZMkPYeZIDsfP0nSgq7QTzHHS592DIbSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ADnbROy7/qlcEhiPNq2SxfUdKxfc6vxJ3HaqqI56C/k=;
 b=d4HloPJkYHo7RJY7f43EKzv6huhhsN6UuvaUMnE9NY0vipBM4QaKDwglv7cHKhKvLqEvEoKOYKaA+Zs1X3ac3JpuG82jkHwnIxDyYXqVcGZ2tAFDTg8EICdmI5y+TWiG3m0Im6RtL+52/4GV5bgija0s+IStoFFdDG35mD1JK9zmREBajnk1A34de/6VNjk14JeUtPOO7PW7qIzPNNcjs4AOYD8K7ai8BfCiHix7CsXtSm0+/2gBIvxRFRF8fPiP+pwqeLH9ztwhP6O70YO71xWjOpzoM2vOQiwrySAsmYGkTwGnI6vH+F+qgYXzhJ+Udi3I1n2cSYVymdomBosv1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ADnbROy7/qlcEhiPNq2SxfUdKxfc6vxJ3HaqqI56C/k=;
 b=Cc5n74AjejBlmfgnEnSlR6pcLoc2rRrHTWYqXk/Cc50YlB8jkTcPigmDccKd78VsKvYzt0hvRO+yp4/yhuqXLcOYWyS/Zoc3r2yJqfNNMXWbKpIsDR7puWloyBlMIJ63O+18Yk92cJx/5k5KoHGvQebjdT+whif1g24yXGR+8mYczFBnGy0pOPYVv5elGBMRkBKIRbkiK0Xecvy8lpiXGBJ9kS5NCU58egACAcHZa98frZB6Yz+b2tZnl+LDblIl4E2nAfSC38rrIGbNBraQr2aj2bkIghToVzJaJQroj1ywd0NxudYgrC9lcZMsvQ+9O98H/cT9Hhxojt9BO4zbPg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by PAXPR04MB8893.eurprd04.prod.outlook.com (2603:10a6:102:20c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 11:23:29 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%3]) with mapi id 15.20.9723.030; Wed, 25 Mar 2026
 11:23:08 +0000
Date: Wed, 25 Mar 2026 19:25:41 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Alexander Feilke <Alexander.Feilke@ew.tq-group.com>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 u-boot@ew.tq-group.com, Tom Rini <trini@konsulko.com>,
 Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v2 4/8] arch: arm: dts: tqma7x: add u-boot device tree
 fragments
Message-ID: <acPGNcy9v7JgzYI9@shlinux89>
References: <20260325095801.47706-1-Alexander.Feilke@ew.tq-group.com>
 <20260325095801.47706-5-Alexander.Feilke@ew.tq-group.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325095801.47706-5-Alexander.Feilke@ew.tq-group.com>
X-ClientProxiedBy: MA1PR01CA0150.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::20) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|PAXPR04MB8893:EE_
X-MS-Office365-Filtering-Correlation-Id: 24958d7f-2ce1-4906-e958-08de8a60e45c
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|376014|366016|19092799006|38350700014|56012099003|18002099003|22082099003|7053199007;
X-Microsoft-Antispam-Message-Info: eyvmSe+EbYIs0PaZpgN9lW03Z8u0PK5R0S34xjs/QNsVKRknohzQ9GiE1NK+YSVQrJfUptKJ4vTeuGjqhBvCeADwzcSQL/uRyLSaTK0tdcKfMd31QIvBaJy/YZOvaHfwhdOKpv1S9haooKc9JIfOD0ZFhatgqHoi1PR8Sk8daVqc36bwhhxil8G8UXh/r4VNz/A3UeghQFdlCzwyrtATxs9Q0I8j3ClUsITeLzA1JtvXZKLDCKmvvNd/KhO4R2yjgspIEys0MS9VWcarqsRcV2wcYX9SP1y+LA45hK8quxlMCz5teB3XEzomFBP3pKLT9tn7KqdfF0xj39RTshzCgHW5oqUB68q3DsLMvE3USr3w8oI16+GFRykKR3ueLvN7uMZtT9/7lq2SnnJ/7+5c3k6+pheTbRACoXGGK5D9Jg+Usc5wENRQNY3mLmoomlYaZFNkDh7ZWJoSvjkOzeNM7s6815g9i+Mr5cqHo3rASvyqpe5J+LGzCbPQmJ/SA+VEQdcFN1WU+NGoOl0cbbh2ITX9A2PayDhmL//UOrrS1PT1PcGjHX/iKMi3o5Bt8V5lRXIwxHCQTPZnukEupGg9DfmIlyNihgIjl//hh+Qm2cnk8N8Gr6FuWLvcvxtB2FiI/WXMSQ55VlkHLDE0iipw4zhXKsWib8MKmEKfHdczI7UjyxBYkPtarb0aT1vSonGGeTbuR8aJD69+DdIpIvim0mXAUwKgmK4CGRFxWzJtPzLhXWkyhtteJf+8Xvll7wxP5fCsncytRJpvu7f+wVMF7yKZvmYgcUX820iPOh8otjE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(376014)(366016)(19092799006)(38350700014)(56012099003)(18002099003)(22082099003)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Jvle9wgITOtyHM4GNXuEGxpN0jlzUxfufDLLIn6QK55tOQp/GwRo3vJPWAeD?=
 =?us-ascii?Q?qW1mrB7/MFTfMAl2e96ppPMlUBQ9gwFaNU+eeq0vX9wJ5xnr0IxozC1/RSXb?=
 =?us-ascii?Q?N02cyHF0gdWy8PU2YE5JVm7Bs4sjXfDpj6vi1OpavrchxgR4PaYq40cBbK85?=
 =?us-ascii?Q?rmadJmPeSK2MDr+ki6SgOmy1rkt1rm6hzvKnYMeG9iXJt6f6WBl5NdmybcoV?=
 =?us-ascii?Q?jV3r6oAFnCxOiuuMyPATRPF6dbZWkBkd23prQI/RGp5Pqy2q5p5+f6mpE42N?=
 =?us-ascii?Q?iKTlPezoF/CNpdDUTDgCcclUXxsdfZg8IBCaRCqeAVWVqhldvocQXwAcjr+o?=
 =?us-ascii?Q?bucsakVbOtNQ/NcWPjhAIbnTYqY4jSvY16OrCdYE9PZSvz0UBMnsILa6JEvt?=
 =?us-ascii?Q?6ZRFnwPV+um7jGhJL4hiVAlifBU8YjMhDjBAj+FL2v6KDF2pdWX3IZmlLtz8?=
 =?us-ascii?Q?gbHXTUsoCXkWpLi7n8N99ETgmp10k+49QaZI387i8Y7wGGwjObwh0H6RKt3U?=
 =?us-ascii?Q?o/B0IAqSTN6KHTxsK+ZUr5udmFHzyXltC7sxvI2gSYl/aVVbBWA+g5den3xg?=
 =?us-ascii?Q?LC6sKGeoEn4hrcFk8hZrHKxuhV2ddANRM+JYF72dXtl6fz6HbKJktetanpmq?=
 =?us-ascii?Q?V+BaFahqPkMPNXpw0iDkkO0AdcxkQtgbSI6RlEhM8/WfqzKT5kYRnXQ3sCgO?=
 =?us-ascii?Q?FqJu6Qd62/Za2fC/e/Cuxo82H8Su16EtE9fRVr1LgHtGW+uvDXBVpC8gWeXQ?=
 =?us-ascii?Q?LytExghQ4Cpz4i6/pYbS9Wr/nB0eY0tB4rAfJMFso22kDCGVmd7SdccofSJU?=
 =?us-ascii?Q?jwtwm5mZN6cmbUCExrJ+j1afTpuuWFj9BU4oJJmlhHMkwk2a3XFPZrneUsa2?=
 =?us-ascii?Q?yxRuspvQCRpYnk42Y6PbjxkU9cBrezVvJdmPoqmTHnwgLz7gE31+ZIqPbAIU?=
 =?us-ascii?Q?BxvcidqFMhMMiR55ig2K4jqYGdEZCfhSyvfA7lkbbAHLjBUibKHGZpuwYCJB?=
 =?us-ascii?Q?hNknwvXMCqDGr1VCSYEZJAv3Z6GVNrAcmm89AR/TaHASK+TMzV8qeftPpGgR?=
 =?us-ascii?Q?dgvyJRUg+N66OkZ0ANSAhzuibI4UFICP9Gt041xqbpFj2bHtpiM4dH0CKJ2p?=
 =?us-ascii?Q?J5sk+It7qGe9biTUBbekZMKzjyhaytBPO+CRA73GNlgSl6DWULoPvyl5wu7+?=
 =?us-ascii?Q?b5ZzESvTy350NCjJ5oFtwuvJ18/j01+frgfoIHCYB+0AUunvHJ/NR1Sb8+l3?=
 =?us-ascii?Q?woGt+cExrYFtX+o6+2unzN0bWUh0XWXDWiejv4X4XWPCvHPDI47af+rNe8xM?=
 =?us-ascii?Q?7rq7QDFvEhmbUL1tNPOIFJzSZ0aPn/JVrqnkC0paLenb9cEDlJwWeuTHNCKz?=
 =?us-ascii?Q?RQITTCzcWiTsqaQ+hQR4/bYr9Hyk/POMLbU49+rlqz4kjhW7qrXxY0iL9YDP?=
 =?us-ascii?Q?/zDmi3MacOkm7ppn4Ajg+sbtnYHnxQd1+Qo16Y1ed0PBOWtFEX1rB+Cr/IVm?=
 =?us-ascii?Q?QBvOiYf+D1XB+hKzH9TJX15zD1EYfir0hCBJgIEx7p2EUdICpmI12XqUIWYg?=
 =?us-ascii?Q?wp98sIyHXMInTH58A8HimN9isTQsNR7YhavKZU8f9eLW5EaF0W7XbzhFtzsG?=
 =?us-ascii?Q?ZWv0xXCnhujux345bVpcdORcUK628YxlZv4Xn6zMdg7xBZ/8weDiKjP2oYdX?=
 =?us-ascii?Q?eOp23fvvve6N5tcJevw2OVT4rECHHo3SkSYnKJ81KfUebUFhCNN+Xi1PWaeT?=
 =?us-ascii?Q?y+fGpXrAhw=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24958d7f-2ce1-4906-e958-08de8a60e45c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 11:23:08.6802 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TwVF7r7CbFSCxOqegohFqCKBqVEpCW8mIONOj7a8H1jZabVYMny38HvCkWGqQussKI0igFBfy3zf9DsgEdZOAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8893
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

On Wed, Mar 25, 2026 at 10:57:57AM +0100, Alexander Feilke wrote:
>From: Alexander Feilke <alexander.feilke@ew.tq-group.com>
>
>Add u-boot specific device tree properties.
>
>Signed-off-by: Alexander Feilke <alexander.feilke@ew.tq-group.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
