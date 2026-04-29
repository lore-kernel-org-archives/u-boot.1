Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A9D5FF886F
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 02:23:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA8C6846AE;
	Wed, 29 Apr 2026 04:23:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="QMNa+0ME";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B029846BA; Wed, 29 Apr 2026 04:23:29 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9EBBE846AC
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 04:23:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GJWSyog7EmK0p/YnHv841Zf4Eo6aIAoow6SjiSQsEY24CRi9kIonNWK00QDKkVlblUFHht+feJb1C6m5YZ9Q6NZkO689ysd17hll/bMcQ9DwHUuWgH6Ot9jWL8XYbk8ex91c7YyMzpoC7F/YAYUTVfLgzZX5T3be3kqP4f0G3kubXnIQX1kgpL4+/054P9kCBk2kmBfDYxw3Xxta+5YXPJY9o0M42yggLPyyj4Eov5C0niTGsnN1qXpGRIZo3YqHQFV0MYgeadu6x9XNM2hice/IQR4RigxDvuf36Y1VGYNFNqDYyS5y68xLC3eSR3phXRlzdTO+AKhwRm2LABqlWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vCqItEIHBXAzqQJ3VoQQcYycDujmLtkty9hPl78pyUY=;
 b=RTKgAO5hMvNIYqljHndNGLuPpkGdjrNoMHRszApq5zpW8MbtCdQKvxNsjjUO4zsgptlD4q2NjVaMO50qAM4hl8tZ8V5/lJ5T5D9whaPoRftTgdlC528UyJ2r/bL5CLnmJ1hK1Ds+MsABcS2u2qlGGDJygIqyzioj+EjwOw5hTLbyYYafI4i8H+61CMFOkxoG4aO4/GqRFvM5h+umRpS3Pkg5tSCCXngfTCSdfmOaLAXsZKe+tag7YPV5Ql+5Zi8HvTHG1JHANs3zyX+qNFRrh26bn1FviyJkzp/DJkB9rn7hf57/x3AgWIS+/gw5jXA+c8iAZjNQpt6sFQiCynxJkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vCqItEIHBXAzqQJ3VoQQcYycDujmLtkty9hPl78pyUY=;
 b=QMNa+0MEEpMagcCFglDyHfqQdBl/YY2LusHQ0q2ahZeb22lQZ0DEXj8ERe8CTjvPkOOsYVYGh0atzjrS7ipsskDlVZKjFmRKuyVnyNVY7kFpi5yPgCXuOJRUOVEGLQ34aTpO+jn1IZsN6NUVvVjwP7qlcOEII/l5j4foc3eobWflIe84yr02Z9knB3tTPuXj1FlkCL+cB1gndiDqNPUlm2i++lJZGplOi9jcOsTmUeHLQOM+zj40jl5X8Onmw9VSvxuu8T6GXtuC7rvOVKDPoOk9WCs8y1yFtX3h92Y3CSTuGf91N4ecVCqsUXgXBBiv5O5esL/GQh5hP0t3duQOjw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI1PR04MB10076.eurprd04.prod.outlook.com (2603:10a6:800:1e0::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Wed, 29 Apr
 2026 02:23:23 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%4]) with mapi id 15.20.9846.025; Wed, 29 Apr 2026
 02:23:23 +0000
Date: Wed, 29 Apr 2026 10:26:02 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Ye Li <ye.li@nxp.com>
Cc: festevam@gmail.com, u-boot@lists.denx.de, peng.fan@nxp.com,
 uboot-imx@nxp.com, ping.bai@nxp.com, ye.li@oss.nxp.com
Subject: Re: [PATCH] imx8mp_evk: Fix the ND mode VDD_SOC voltage
Message-ID: <afFsOv98zCYskyq7@shlinux89>
References: <20260428090517.1808814-1-ye.li@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428090517.1808814-1-ye.li@nxp.com>
X-ClientProxiedBy: MA0PR01CA0088.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ae::13) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|VI1PR04MB10076:EE_
X-MS-Office365-Filtering-Correlation-Id: 7970ceea-e6a2-48c7-0a99-08dea59649c3
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|1800799024|366016|19092799006|56012099003|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info: JGHL8TOAEjzMyjRiL29hHiVrrp8zk9n4taBS0a2wreALaXRzzG/PH+ewiDRt8HEp7w9mu0tzb2ooCpnBO+vK2VOrnMihuYC1JywdMyn6p/I9TB0svWWJMZmxyBiGShT26Hfrs8sRCWaj3Qd714h/Ce0ivLCNg8dA4xmv5q8HXRpVWZpZh4p0Tavdw/EPhVv05Lb+KCgpS4OUKGTp1NDqioxJ5O1L+olxzPbXTib0gphE2saWPBVV28joUrT5OvrNn4HW8NzMeVNV0kjio3ryNu8L7nGHnAOfwvn2cC9PCkI3mlmt7Avsk3hhNXakP7614JZi1seVbXhlzA/PEpQRC3nRG3o3LX4kfhMaBYbl/1xe7gRrXZgcPpd/O2AlQLPtnPQ/rRPD2vFQvmbMwJmxRfoy8YVFVL2MZOhvPOLDFzyJqo6BE1ASVAWXJuP2FUocBdLPdnjGTJm8xuUWQVY7Ai/TDig7wVLQIujLObZc9CAZLSbmCQLAL62zknoXtVOtMqUhP3UJWqvRwrkY7q67T9L1vLrosiD5y3simQSgfl94/VcRjo0lyb8I9McJPa+yUNqm2VDmitPzUzYBzJ5OqV0o7z5ZM42OXP0LJISaH1peTfIQr/OfCG+8fd3v8MIuu83M6+gfNXrWUnywykXbyPab7psCKjYloDvVhGxcerpua/xCVL9MZKo6L5QnOl9K4EIzFK0AlFXzf0jdRQ7sBv6nNlOcPTSOvTSVLkD2VPSwr+KU5GO2X8UWEIAB2If3vNSoiNH8kpyM0spkBnkGnqBAH2sytxuzp0MYaOsgh0c=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(1800799024)(366016)(19092799006)(56012099003)(18002099003)(22082099003)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?R6aI95YSBmH6C9SqD/21O1BU6gKD7WCyZT6+JykfEfES3pEr10zifz2xG7ze?=
 =?us-ascii?Q?jAkeOUCO/MbZn/106PNc2alDibs975NnNXJKvQhHPcn4epw1T2OYEVHu30d8?=
 =?us-ascii?Q?y4QonFNKjv7xWsrrAY4MyKBCmMx3x2P4Jun5ATEVOMGTf6SpFEud3kIUq8/Q?=
 =?us-ascii?Q?BuRWfshYKSAW++hjnh8szKE3XpjvTyS35hd070ywuyVxSmZywVxpPlTI1pKF?=
 =?us-ascii?Q?BHYC5zaYTcEZsbgctnvZsaRDKEYtp8W53oMMpHx5vzNV0dl5qznoGKMNUCTE?=
 =?us-ascii?Q?iHXSmy05rEhOVhPlKnuFg/qYVozvcNzz/oo8ij8ceVgsBamqzJt90ugBiezb?=
 =?us-ascii?Q?5gEg4/z9x2DE44jsa1FRKMpNA+mIfsEjtrZFoJW2K1ncKlhvFYq1fkk6FqOU?=
 =?us-ascii?Q?E5OKiJ4drm4cwbx4jAZA6zTuvuTDWb9Ei3undYTNHO7nDaimSdCcmluUdnRz?=
 =?us-ascii?Q?DT8AFdZI65jjy2QWGFlxcSl0ln6y3GyeOb6m2HrJbYiv93e3ZjkBRaBOigqz?=
 =?us-ascii?Q?dLSk/C42xbZMt1U/4adehMlyB30BALoRcjtjoEA0bPNIE6j0V5Lp4Oq/bXsS?=
 =?us-ascii?Q?pfYOwgw7VYKdhzBpv/UeaV+dUUccX3B0u/I0QWeiaPh/76ft9+oNquNe2kcJ?=
 =?us-ascii?Q?3xA+7L9JCReJfXOcW3El0MmjVw43gRt+c8KTi5qAFwS6iw34UJRpqpYATZEi?=
 =?us-ascii?Q?AHd0c2abD15jomVjZ1OoOeBlrWqhL3IeplXu7Mbcoys8h9BPv861KalnYMEl?=
 =?us-ascii?Q?Fl5iZcwQVu4G8GQPhZgQ2qhh2DrkRXwSfBe3yKExegBvCWkKHJEjguxT1u6h?=
 =?us-ascii?Q?YSP8auzwX9uxonQgEoQTG10wxxXbz2crV2CorIZtmy29KlaosIbueB/K1R79?=
 =?us-ascii?Q?11TKdH/RIK5JKWv4oilYjL/z7ATVNQ+Q2MNa2PdrI9qveO4Yrf5QEEe15nG6?=
 =?us-ascii?Q?DgWmgdrh5MWOnoZqkB+BGvtyfEnKT2/6lfO9OSz/l8f9MF7iyNz6ae4MmjGt?=
 =?us-ascii?Q?5fECZ25t5yBF0qxcngWyxI3Ti/PJ4YrkwJUkq3BjwmEMWUnHbS4kSo8XXbWt?=
 =?us-ascii?Q?s8gX4YjeYe/rlBvufNRI7NElBLhvyxa8diKLq1a/iVw7ps4Yjn8a7wzKQrCH?=
 =?us-ascii?Q?w/ZL32QzZDX5+YHVBUCOSU1ThDngd+KWSC0eYHlwIXGj8AroQkJHDggWAJ7v?=
 =?us-ascii?Q?xjHce/j+UZFpwyNCKq2I9cbUt+7RkKW5XH7beLHSreccv8RqpQXwsITggY7s?=
 =?us-ascii?Q?2m/d0Mxdw1RuHd7UFkJCll7PijAo+X88B/LJtN4HKBEOWvF2tuQHZLttwbPP?=
 =?us-ascii?Q?rx9/+R3WYLf7nzM8ib2eivZgAYSka/8JRZQvvSzMccti9KFszhWVgkycInHK?=
 =?us-ascii?Q?yNhDtmfOqfaMj3VsV3rMhTqTOaTKu04pL2ezt8RqtOfuLBfQB+aoN0AIxJcK?=
 =?us-ascii?Q?8egASg/UKxxY4yCTE3xIfMjw7jTwakoUIQA1HV+nKSwlHBKz8bwNgbbOigZ1?=
 =?us-ascii?Q?K9MsFI8QM9aSNyHPGE1RcJ1YR/c4wWaclZmnKxPkWNLrD1BnTpsO2SK1ChAG?=
 =?us-ascii?Q?f8HfIKlPRg0Wjbk6zvuKIJ7N7O0c5WEhmpO9wwLU1qpfTLvgRX5bLe/INGOK?=
 =?us-ascii?Q?WbxEKVqkglVWpZBCOiFI2sB+yQlpSe+EuhA/NHj/cqciWD1nvKi63w4D+CZV?=
 =?us-ascii?Q?u2dy1WV8o0cW9h3gAezTeviw1O3cErtVMWqd020s5AC6NyX0rDV1DGo//Y8N?=
 =?us-ascii?Q?ISQwk7yciw=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7970ceea-e6a2-48c7-0a99-08dea59649c3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 02:23:23.6149 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sQJbGHvgGKEdQFePIDSQ7K7MUW5HMAT9nHDCVfyySes3y8gBPeAby0YWaripv/djpvrEPPWVWoPV+xymHVOyeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB10076
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

On Tue, Apr 28, 2026 at 05:05:17PM +0800, Ye Li wrote:
>From: Jacky Bai <ping.bai@nxp.com>
>
>The 'CONFIG_IS_ENBLAED' check only works when there is a
>CONFIG_SPL_IMX8M_VDD_SOC_850MV config a option is defined and enabled.
>So use the 'IS_ENABLED' macro instead to fix the ND mode VDD_SOC voltage.
>
>Signed-off-by: Jacky Bai <ping.bai@nxp.com>
>Signed-off-by: Ye Li <ye.li@nxp.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
