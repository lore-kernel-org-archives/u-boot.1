Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CA45CD4F24
	for <u-boot@archiver.kernel.org>; Wed, 13 May 2026 10:49:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C4B6836AC;
	Wed, 13 May 2026 12:49:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="kmB9wCLx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82E44838BB; Wed, 13 May 2026 12:49:56 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4FD618341A
 for <u-boot@lists.denx.de>; Wed, 13 May 2026 12:49:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EKqrqVeFUA26OaUrkRC/8nQyqFL8lYwpV1zQvMpGFrctZQicMr9YnNVW00FJ68K2YV6AeB1KCse2affJUUehY5lwj8zdRPrEeOUl3F2cFTHkALcGvKc8E5gWDBcmxD/yOuX/pnuXtQS23oKwIRuXUFjahBqAqiG/hC9nsHnIxT2FlluBLOiZo+uqzvNEf+rt8ViuvaPOQdKe9iLWjTAUMV0UZyzDC3vODUVSy45E2cDgA25jD7HJ5Xudk8ebFd2tH6bQxFRzt6V0E9kR8dGMnPP09JVfW442s5S7Y9bUaGlyLvYuoJrHJSy+Bs8DFS4BRhqye6a7fUfaUP/Bu7OaQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1J3d64vFh5HXeuWIEMgwuOmRWiU1WLN+JE4RZ777Ci8=;
 b=XZdCyKwVZcFFp9xx9VJh3NUac2baEb6KJdMuBHPI352WD1dl6QnWQLbs/ronQY5Vm0rNlWvY25MYMF8eyEI0/3IMVkmmR9d8J4Mv8LNali9SY81aRxhcwUKWxoz0bxOkrx8r+iOgZkG7mNsWYjOF2CMeeJx1qGP+nzCO3eo6OI+/BooP9p9YwgkEid28LfmiQWNB5NZDCpNF9GAtqJekrUFCqCFFCQ/eccNuBxHZOHF98iRy96HT1dGrn9EciYCJi2DT68vt4fgPWHyuuiWljBm6Af16y3OeMaxs1UCcj3wHj6ZpzVCFmWL7j8rv0VYPm/ISDoA8zMVaInPvL/Fw9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1J3d64vFh5HXeuWIEMgwuOmRWiU1WLN+JE4RZ777Ci8=;
 b=kmB9wCLxevFbsjGG1ebcudscqJ9OWQc4Iu/GkurwMHiWccn1xAeHL2A93c/o+8AABC18yhMXLwYxVhBrcnLbB2JgidDF1/gUFAoO/EfFqqWHnRP5Q7Lxe7emE0ReFft8rVJnbU7cLsLUZb5JkB5LeMz80ADclaizEQA1ue3j+XJc9HpDnv8UwblsxMtXZ3+k1wiMGfzAcs5Ns2UaIMK6nX3JGZ8R8LpMqdh3ssfCJpU80HL5PGFZemgZWQVkXsTY2W0zuWj0cOXKTp803/4QeOtLR88oAHuH9JOqju8aUz8qHCBE6uSYUyuNLoqF70WK0Pxmh+xwS5xWpJQ/PCykAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by PA6PR04MB11830.eurprd04.prod.outlook.com (2603:10a6:102:521::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 10:49:51 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 10:49:51 +0000
Date: Wed, 13 May 2026 18:52:34 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Ye Li <ye.li@nxp.com>
Cc: festevam@gmail.com, u-boot@lists.denx.de, peng.fan@nxp.com,
 uboot-imx@nxp.com, ye.li@oss.nxp.com
Subject: Re: [PATCH] arm: imx9: Update i.MX91 part number detection
Message-ID: <agRX8nCcsX+9YY/7@shlinux89>
References: <20260511074739.3772848-1-ye.li@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511074739.3772848-1-ye.li@nxp.com>
X-ClientProxiedBy: MA5PR01CA0096.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1a8::8) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|PA6PR04MB11830:EE_
X-MS-Office365-Filtering-Correlation-Id: 6605a12d-7a40-438e-25b1-08deb0dd5bd9
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|19092799006|376014|18002099003|22082099003|11063799003|56012099003|38350700014;
X-Microsoft-Antispam-Message-Info: PK44cJPGf5vH0GAwSagUvvf3VRrIpGxVxegcuL1Cp5Badr41ZPDaMuUbkSZoJNWd/tjPldufCAL63JVbBXcSJUyZlNIJYzjEMuc44Frdm3uXZngLC1aEPH2mgkVRGvRCa55O1+tj9XnG0K+IT+YEA6QoaDEJxMtzZeqX1z5pneeIE+QyVBLmBZ1v4wRkvRyLLQG06ccyBi4JPtkpKldfqw0jl9x8C6fM6QEA6jedxc+R4Pq+w/BHcO27FsVK01V8sBGHA3Nj1UytXNo5kYR2g6Rc23WGOAhsEcTw71RrLyF5cVQCMjz6n3Df2fTijLSrWWp4T2EkEJ0JJRDz9G3/wC6CB+5iA/32TwirofpFxK0oLTT//NYwprkRwltT2uDgICC1Ff0cP+/8nCsUx6674/rLLTHg09h2vf0sz8xLiZvo2FWzCgHNzFwNWvTbO0/W9DTMhmEM7BhpDvLUeeQBT8i6C4MXsvYTwL5yJAbNzYvSM87tEvUeok1bUw7GDp5vlkm0sQV+qoGlk48rAzyQFszOWegiirL/EpzakzHamIyG+lraYX0hmaJaDflZ0D5zMAc9Fw93ORNiIKH05ejqhekzvFtDXZbwjpUlmbDcKi+SLkOuWnhRTGYLca9olDGmRVXcfZAAbYUa7Od1H1N93BRAxpYH9EOzXtpqhjOEa7n8a483rMG2pcHpdS0TO0wGvj+vORHMvKiwiw4s1HZcF9ilLTI9NbbUxN5VHgKjFTgVzOWM4tJViNQdLe3lzDfp
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(19092799006)(376014)(18002099003)(22082099003)(11063799003)(56012099003)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?y8VFDtW0UR5KgJJlx2Yi+bzUeh2xytzFXnn/1xRGLT1rEk8hzrPJN7JJak9e?=
 =?us-ascii?Q?DwU08J8ndP2L/H8tDBRNpMv5Cb9iDZae3zMwkHmjVdSk+1TO7KQ7pBMoR4XX?=
 =?us-ascii?Q?8pA881GKiiOXrF9YerSQDB2A8OAYlKEb6d1NBQZOWKPPFfuUrsDmabu+4FAO?=
 =?us-ascii?Q?Whcp/WtZ/vbNoUhlP5+Qg2L4yhQypc0huiO5mtwcW4JwkFfixCF/vv6U/2+v?=
 =?us-ascii?Q?ctrVXG8NjJYED0dscRV7NBqAxCSYxdHzcFVlX48ju3HX5ognJ/xdwUDdMIB8?=
 =?us-ascii?Q?AJz4a/e2wYG9qbs03lJ0i19firTAk+L3scpixOZ3fGv9uoMK7Oy4dgB+U6kb?=
 =?us-ascii?Q?VzfF59o6dMjhNQ0ZZ3jut8XpT5vAIZCOtIyQvpIqlug0HYqkzgSmEqNBGSR2?=
 =?us-ascii?Q?n/36y8CAS1+iy6iladZAlC269B4ysFsdf7+Ekbbb/kGU6Xo8vRjAzCqEhfNN?=
 =?us-ascii?Q?FERuOBvR0hvvBYCLDVbj7uzpT5CjMmNzTFabf+oMmlqvG/dgFwKNKvo4RBct?=
 =?us-ascii?Q?ydH3OHCmXcPA+g3OYjlDZ1/EBpcnL8jD2lsxTPRAC5cZvHLYsT0LuFuQDKV0?=
 =?us-ascii?Q?08sHYPOHe1bMwpYUOyE5q4lDTZ8YeDDCfpEBHSn9wNDPn7DxS8HsCxy6229r?=
 =?us-ascii?Q?VxnG1QW0b0ZkSO2WLiNEO/8dLi5egGvnOqqys45cB73oCLUKBM0coj7/04hj?=
 =?us-ascii?Q?4rlgRlfDpJLTAJBfkeH1ecLyPbwUykc0Zc2GqUV6+GfmEalep9nomfWCwtXa?=
 =?us-ascii?Q?PcZvM5I1lUNN7dbVTX2e4K3NN+EXwO0QCr0O/5Cj9bVaK1JSnoMPJbUjyRG5?=
 =?us-ascii?Q?tYgaPD8A4njCP8014QNnxpmYIn8+lRYWJYV9CpYSHOmdMnrA03PMxuaxCIFp?=
 =?us-ascii?Q?1uUZUpO8BLbcglxA5RvulpndYObH//4yqFMAGrof+WsEN4p1dq6hA4clrf7k?=
 =?us-ascii?Q?JEDKtkzPRVfw+ny7wRdJm7N3KCUgwQ3ibe4LVXYSZAbrbVJlU4ZV4Is60wTz?=
 =?us-ascii?Q?UlsHiyH3Y80CpLHEE0Ctk8vqd7zBSr7+0ty/i8DN2F4iqOfrpGsOCqBq2Cc9?=
 =?us-ascii?Q?QJJQ+QB05fTqbA4M9UqDbFb04zgltFlRo/3EbsF3IgwBx8YCNYRh7mX/Fw2/?=
 =?us-ascii?Q?Hoasx4OZAtqi1Ib9aPhhh6btZUrDU4tI3odRqdsf8PcZFU6l3zO8NQpRyjwc?=
 =?us-ascii?Q?UKXbVxf5Jq1oXuBf8izJEgOtMjEtGqi9Gh+ZYJf66Psdx9crakkvH1XJxsoH?=
 =?us-ascii?Q?7L7qbI6hKHd+bAEj5mdbjt6gw/eTnP8SEjiFTiVc+3oKDEJkoSyxfxTwr7GR?=
 =?us-ascii?Q?Fz4FvHT3C/eJTrsL0fZuj6bSabB9MwluLU6wchgH3EA3h+dtQVJXa4ysJ2Br?=
 =?us-ascii?Q?HmcbaX3gTwqTgwr5Q8ivnpyLxstITDMayF7pU8xiT+UaTC6ZG3teVlX2+bYK?=
 =?us-ascii?Q?d6Sl6Do4Qttjhu0LgKqDjmpYbiMMlfsjpzJsqTaxcun0dK1wJ/tDtkwBTD6S?=
 =?us-ascii?Q?WwC0CdQ8GO9Ut4MFSdq/nJGoI04l/zzpl6/EXdpbUAb3AXFlScT6QEy7dd1L?=
 =?us-ascii?Q?1Yuql+Ap1Z3opqZoGqhOhLoIng6qY7IG5QflXYjPAviRcVWUlacdOnU4cCaL?=
 =?us-ascii?Q?rFA4FvJhFAOdh+qhwehuPh5EgSvokemN6+te2Snd90X2z3q9Zknmg+zZ706G?=
 =?us-ascii?Q?nwWPwxl5WMUeDANUAxs3RY1tCE55xwAYyrbMlYKd0MKDG6ow3EClD635SmRi?=
 =?us-ascii?Q?QDA5LXx+BQ=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6605a12d-7a40-438e-25b1-08deb0dd5bd9
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 10:49:50.9811 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ILrNFfTcbcWC7EZVQYRovN63ai2ewoYp3WgpS2Bg+q/hex8KNzKgmmZ/1Zj3Ccf45Va5bB0oOP4RzK2bIPOaSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR04MB11830
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

On Mon, May 11, 2026 at 03:47:39PM +0800, Ye Li wrote:
>Change to not use NXP_RECOG fuse, but detect part number according
>to feature disable fuses and SPEED fuse.
>
>Signed-off-by: Ye Li <ye.li@nxp.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
