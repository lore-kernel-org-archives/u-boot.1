Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC87EECD9B5
	for <u-boot@archiver.kernel.org>; Fri,  6 Feb 2026 00:43:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 61B8983B72;
	Fri,  6 Feb 2026 01:43:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Nnw9E6ZQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 846B183B8F; Fri,  6 Feb 2026 01:43:43 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5FAA683B64
 for <u-boot@lists.denx.de>; Fri,  6 Feb 2026 01:43:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fiQfxTIytDbWrUxcZ0I1nII5dn7NoM3gRz0aIj/YrXV18/rv4eRRAztKp2HOc5nslECE8DPGvyR1AckLR7KYS3M4aqmZ3MvU4GKUas+8x866aQvsgU4SqCUIO6i3gkiqgG12Rx97BEEFsp0ZykaKjp6xc1whjV1H+jujxQJ5aZpJfKjqGMHb5dwhALfvE7SdVKNtuektIH6ei7Edcp4EO4hvbWlXuHJdcsLpqlVvZaHJdmgZ0zOPs1ZKxIujxzLIasydFNila//sFypHn/Twqg1p4FPMndg/BoPctgAy8nSot14f6Ox80Wg1rMjmsZX/KiQ8JyQ68AvSjv6smYLpCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JswDGDqg4avgD/NGnoMSGOpjdwITwy0hwuny+vWggzs=;
 b=mu7vKvzQj25CFdyDZAwqknegHp3SGwUllKC04NCqRJ7UtgjukGZ4nVNPeUgh6ddpz4ZSF48yNvQXMmKxPzWpsmee7TMuuFiWgmaxZMLHq/nrBu0oCtmzCX3BCMJxC9LRYddzfR2x5blRWIg8iY+oK2MlwWiQQvkj2puc65J24pm2N/jalROPEsXSWKIkiuqahXDw4aczNzKcGVBWaaDKaY+NveR/hgW6NKbWkRS6qiHwS2Q0xNDRGHsDOH76xTsISjdUQuwZnteV4GjvM7UJM8d3804wWmPISbvWKrcYbDjtJlMgCPPuZKhDt//SmkUi/uxOqaXDqdfI0H9QzGfB2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JswDGDqg4avgD/NGnoMSGOpjdwITwy0hwuny+vWggzs=;
 b=Nnw9E6ZQpJV6jOxbFndaZxkms6reltQEmsMERFBJRzdoDhlv8Aew2lHFJnkmoV8p3Qh6/i6exhyLJfFsNxHf2b4bvVIn2MSoFPEElfLDd/URfh9roSdzh1EeiYEd9SsK5CzimhZ/gjBl/JZVZprbXrH5MY2+Kb0iIYb0JCaHPNOS1O+zwFle1Nfcw2Ax76IafdOhUHzqhp1HYNuZc1jVDjkEX7KDVAONnV6KAgM1kDYyZkKxZVOgv8wfubP7uhI5827qOMLrIVKaJX/h3We6vuAW8+L3CfoeIHcg1lrhNALJTX8uznJoEhT5oKFwWSjnAdcWJOB4q32CibzBZup0qQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DB9PR04MB11598.eurprd04.prod.outlook.com (2603:10a6:10:60f::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Fri, 6 Feb
 2026 00:43:30 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%7]) with mapi id 15.20.9587.013; Fri, 6 Feb 2026
 00:43:30 +0000
Date: Fri, 6 Feb 2026 08:45:06 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: alice.guo@oss.nxp.com
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>, Tom Rini <trini@konsulko.com>,
 Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>,
 Jindong Yue <jindong.yue@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Rasmus Villemoes <ravi@prevas.dk>, Fedor Ross <fedor.ross@ifm.com>,
 =?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <joao.goncalves@toradex.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Valentin Caron <valentin.caron@foss.st.com>,
 Vinh Nguyen <vinh.nguyen.xz@renesas.com>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Ranjani Vaidyanathan <Ranjani.Vaidyanathan@nxp.com>,
 Ji Luo <ji.luo@nxp.com>, Frank Li <Frank.Li@nxp.com>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>, Adam Ford <aford173@gmail.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 David Zang <davidzangcs@gmail.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>,
 Marek Vasut <marex@nabladev.com>, Joseph Guo <qijian.guo@nxp.com>,
 Tim Harvey <tharvey@gateworks.com>, Alice Guo <alice.guo@nxp.com>
Subject: Re: [PATCH v1 08/12] arm: imx9: Add i.MX952 SoC support
Message-ID: <aYU5ktPPS5hawCkY@shlinux89>
References: <20260205-imx952-v1-0-2103d0222a0b@nxp.com>
 <20260205-imx952-v1-8-2103d0222a0b@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260205-imx952-v1-8-2103d0222a0b@nxp.com>
X-ClientProxiedBy: SI2P153CA0034.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::17) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DB9PR04MB11598:EE_
X-MS-Office365-Filtering-Correlation-Id: 3549c393-023a-4512-2f7d-08de6518bfa6
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|19092799006|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Oe/HDyDw/SMIa7BExK7DVqmYaxfs2z3XjYrdNveYM37sUF0DUyqkQhMG8q1y?=
 =?us-ascii?Q?R3NUxGX9wKn2UehxujhJQaKs+GioqXEMWd6pzpRsJZ2siaddKMj9xnMJPZXB?=
 =?us-ascii?Q?8MadLxhczrN8nfT3slC5xXQ682z17EfkToNq2TSC3b8xO1G7S1taYOLxJeIO?=
 =?us-ascii?Q?ZBmreS2cnaaa8TWt5uS+siqchUtXAyMpQ59dS1rpWHqrtR6kHo76a9Rlf5YI?=
 =?us-ascii?Q?w9rravtZ6sLQ1BE9TJfnpcA6Xi5NBR2qwNkrli6lR8Y4xPTmjOGFn+vhMGKW?=
 =?us-ascii?Q?HsRPdQz/HrZc079vnWHLPd6rLZHwE3g2IfG7RQilg4nWns6U7jV148IBTesJ?=
 =?us-ascii?Q?bzZlvzsOckZDIx0b/oDbyjOOnWKqETqTRbmOKxGebMm3Cud8RU4p3IJRe/J7?=
 =?us-ascii?Q?MLSTHOwWquI0ivOncL3ftBT5fy5A6B11vPFQtxInMwE2zMMYE33ELqTkRjiX?=
 =?us-ascii?Q?vayZp7zCdMxTFnfonHXowEy9OXZ9kQb72pa7pFOmM2xpx6aU+xyfSS9XRcqY?=
 =?us-ascii?Q?LIGcimi/0NK6m2PSspjBtVJwCeTRKCgds/5RXVPQ4zVzZyF/kwqHmt9kgKge?=
 =?us-ascii?Q?PHzuxlLnQAkIB2NupwfvHpCfClee0WwHdgWwInBlwsAZERWvCrvxp8c1Snw8?=
 =?us-ascii?Q?7ab6Ow6luTWK0jeDTDzjsHHPtufX79z0xwUt2rkLBNJ4Sw7UBVzEBSkka3vS?=
 =?us-ascii?Q?/Eskls+RXAv9Wt1gsbYjtgA5ykQsL64/CJadMxnerBBEJREJFriiqrx252z/?=
 =?us-ascii?Q?s/HvxfqvLsDIzlcCB3j03h43USDPJ5JZFlwNlR6y7RKlX+BMznCWnv34vScT?=
 =?us-ascii?Q?NpcStBuz5u6MkUtR6eA5i64dGA/AP4Ej5f5Zr8G9cVAbA1KgcOWGlj17MxXj?=
 =?us-ascii?Q?cuDutjD5VRUIUMjYg++BFyZbtXJaQmYRLGqHg+EmMdrzkpOv5AqLqyJ2trV7?=
 =?us-ascii?Q?BrffJinWsplFwbaJ+5lkDfwwUNrewgaVc4LYJ7iGc8E9DcCOXNV/qjNdZBFf?=
 =?us-ascii?Q?6MyiKCbGtsP+mQ7/PmIkY4ifHJVl1F+AtNgaBDyAaKcCGGVbnE61718LF8q9?=
 =?us-ascii?Q?3hW4ZKQuiuHOfayABDBDyHM6teRpv0+uP6u/NChMf8bERCbGC7RRzCQil5H+?=
 =?us-ascii?Q?ksQANq4QSQ+9lwT5VLbaieB6J/RzWKdCXwnOZ+3cQnGRIpY+r2LMS8Sg2t91?=
 =?us-ascii?Q?/XU8N018Ysfn6s2XKzRTelRNlh4xOe0k1g/IXBzPGc9EqOSRWqQfLEFZQrEx?=
 =?us-ascii?Q?l769fwI1g35gnG6Jwgxbs+YuJE0BN8HAaqPjdmPwhRgTobCf5aejlyGhuGkK?=
 =?us-ascii?Q?ql48H9y0wxNkW8WZbNnAnh4tiQyHmS49YwHt2sf51E0mkJR2AOAg8rKc/LP0?=
 =?us-ascii?Q?v5NIJCSFqHP21w/gE1R8GIvZlB0jyJO5Hz5pqmEx4R3A3zAA30RMkXZ2KSA9?=
 =?us-ascii?Q?k9oB+VlzvY9WWvodJHP557DlYtlYKYQasXurIgNNds3JJWJqWadW2KNEJNZt?=
 =?us-ascii?Q?wFzgHo6jVqM7m8GJs+7pJ/e6Rgydmgo8fGOko99jmWzMo/vHK9bgHq2NB5wO?=
 =?us-ascii?Q?pwpgXGRjmFHL10hgYna4mMk2LvHXRHGCBxfVgmRH1HIWVSx2grH0o6mxCOhI?=
 =?us-ascii?Q?dpO7KttWNrqW7ONhfUuIFew=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(19092799006)(52116014)(7416014)(376014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DhZ0QtXnpgsjUD05wLp2lnpWYbVlI26A5vNv44njKRBhnTtOC8HrUYTau0Hg?=
 =?us-ascii?Q?YD99yYZjz5zgbWbH1PXuV68soPiq1E3TlafwX+tB5qarxoYu4WHzv8wbgUk3?=
 =?us-ascii?Q?ZW/KtAYKTzGOwipowNyyO08aWqGIN4r9/Y0+BFu8vkXGDKLJJoRyD7Emls71?=
 =?us-ascii?Q?TsYiCSY77F42FsRa/EOK81tJHxfGCVtPORyyalE1326bQKq7/QLb3S8CuTFv?=
 =?us-ascii?Q?zJN+FA7oyVPLZ1SraByyJsHF8+hW3UwRWeNsvMlbNV5Jkb5z5BA8O7dwFxIX?=
 =?us-ascii?Q?bIXsk6bC4hMyrfRRZwPISsGpg18LwCJYucLVQWkwz2vWnvohMTQVaiGt00n5?=
 =?us-ascii?Q?q2Y/LFjk65DcSROcLtuugmM+ZZfX8nXCZgVBtkfNGsrVQOGb74udiYHvfyAL?=
 =?us-ascii?Q?vNKsaTO5RjVjsC8BwFkE/InxVUJPKMKmQkIhDQ7ZfY1ZmpPxeUtjrOCAQF5F?=
 =?us-ascii?Q?V7Z0aOfVQWiP6TDifC1ZYC681V7MxG91VligZdxhWw3neWp277KPozWRSetQ?=
 =?us-ascii?Q?XcvgBKHwvsxPwb9ZPEWfpWFzQZFUEAUm4Y4hE+ReE9lb1jKW9Hu2hzilUIcg?=
 =?us-ascii?Q?8DoJwA1pkEqlfXjOIFDdcu8ta43DsRk4SfFrzevtXXNz7ym/4Xg7xVgQfJ65?=
 =?us-ascii?Q?nBvFjscjC32451gjxe4KeZziSz7qDfJRucx5dxZxqXccIDfBBt+434RDP79p?=
 =?us-ascii?Q?dQuSJvkSjuVYY6memzfH3UC5+wQuOJeZq0xilTv1P/BgYpeICmQ/IN+jqEJG?=
 =?us-ascii?Q?GGX2/tO90+hjWBgKwX4ksiHMDesm8W6D0U9NPqEYx2rAgIPt1mXvFwR/eFvt?=
 =?us-ascii?Q?UBftIJuHYAFanRxPx4LyZ/SJpG8/2T655MQ62doKD+4OAk/hqUcw8AkTWFbU?=
 =?us-ascii?Q?srIKykx6KwPJYEJHR+8foU2da1hIyhi8XO+7gxOMchvtDnWL/YlWdAZk5Q/f?=
 =?us-ascii?Q?FlHCnmFEAyYmAN8Ed8RMOFWCjlB5aC36BtWJDLWL5DcALSzP8Qg9QZSfdjFy?=
 =?us-ascii?Q?hWCpfHYT3Q2F82S57QHWPX5bB9xM34Vji5eIeO1nl0iIRIdVx/nMs2tOoPiS?=
 =?us-ascii?Q?0Z6ISAww1RdPjy0Efeh62Xm1ZvnANC9nxTEb5TE96O+3XO9DKrhcJu4rm5JZ?=
 =?us-ascii?Q?iQlmPzCqnpvGdV6yggNVQeQIv5VZ24y19bPGY0pEgb+eRnuAyMLJt4mu8FZ2?=
 =?us-ascii?Q?SLKfieWmm40sRsY8aUKBHRwfvw+FKeXJSZDkhCl8LnXDXlpLbgDUSsRQyTMk?=
 =?us-ascii?Q?1MM2Hro06jPnZnAXIpVy0j3e5GL+4vpbC5nTuhXWhZzev/nxulbIbUirztPJ?=
 =?us-ascii?Q?p7b8EEzJS7e2BJ2pVXZH5aAgjNJ7uo3gH4luUqC47jBK+cdvAgztIa6lGZf/?=
 =?us-ascii?Q?nNL0pNBPmpQrRt8lPwYNH/FNXaLN5fXyLWIst1dyL722usGnSoSqBseV/RR0?=
 =?us-ascii?Q?LNy7FMiYX/5ZALzmbymEVEYcDVFZ3Qj2nqaEaghsNRo/XmoozARtt5XSpKx8?=
 =?us-ascii?Q?5Jf42S4cCw6x3s1TsVQcscfh5zcSHN5cxIEktmvJLVqfkB8MoU4FmoDDOQKy?=
 =?us-ascii?Q?ML85SN4ZuC/eIA05ZfTtAVug9CDUVMl9Y6s1R8VvCo8lrPFvmDBYfvrp53RY?=
 =?us-ascii?Q?9vMab6htYzROJiU6+wGdRSr2rN8XjwuM3GtKoiUh+SbLPFE9VIHm7ncfOFUj?=
 =?us-ascii?Q?h2Yyt4aK9aKwBPVaRlQShn8NPtADSYf+PAT3ASi73ilDBBdSwpBA/Ft3bnL2?=
 =?us-ascii?Q?F3xD+RV21A=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3549c393-023a-4512-2f7d-08de6518bfa6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 00:43:30.5127 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yjU87xrwqXjY22B3jZGoP+CX9D3dlqZ2l8pClpejwYXZyTuWpN9EB8m+rYAfZTkP73Z15VvJY0Csa2jxW909Mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB11598
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

On Thu, Feb 05, 2026 at 09:55:14PM +0800, alice.guo@oss.nxp.com wrote:
>From: Alice Guo <alice.guo@nxp.com>
>
>Add basic SoC support for i.MX952:
>- Add CONFIG_IMX952 Kconfig option
>- Include i.MX952 clock and power headers
>- Set CPU speed grade to 1.7GHz for i.MX952
>
>Signed-off-by: Alice Guo <alice.guo@nxp.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
