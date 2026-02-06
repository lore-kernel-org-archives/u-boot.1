Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86899ECD9AA
	for <u-boot@archiver.kernel.org>; Fri,  6 Feb 2026 00:39:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E29E0831AC;
	Fri,  6 Feb 2026 01:38:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="YxGKPici";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 040A683B1E; Fri,  6 Feb 2026 01:38:57 +0100 (CET)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2BDF283015
 for <u-boot@lists.denx.de>; Fri,  6 Feb 2026 01:38:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZfXORUePPB3kMGrPeUNN2NoTQtk/OnkN3k8RyRmq2iUcknh746EbaepBlsNdvkuASZ8CQtDYNDPVxvgVd95RJ4YMOCcag1JpQRDOD9HOb7lYPyA+5z69ylWc3FSWxmFFqioK1A8tHbG5Y2yhJddKP7sh144ygBMtBUBqsZgPN7oAgH32ZztevAwEKwXGsWZ0N3uheAcLMEZGEAkcADc/hXpn8e3NYe/MPaqFxmlrF7x64LwxMuZ2IqqEbEuAIu28Bdbe+wsbSj3BCTvFLYXqmr9VEcXcyTCPbV/rGIQQdYmoMauBMRWmGRevZKOoldCZJF2FqEMj6TTetRuz5C0Jtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mb8OBiMJJJY0HMhwcuNPEGFpWd8rbsotyS2he89GHQQ=;
 b=FI/KuzphZwnnd5zCViqo0srzmCG31zHga4NHSGb5c1obS355aU5xzKc2Hg7KBPw8YNt6oT8qzx9ceik4Uv2eC+aN5VSDiOH9vXSVWjHAzovgj4iXJqYQewY1IZbcwFVMkCun0b3MR6m+wUOuHHIcRrDuZe9Xm74xIR21H1bmd8N37EZgRfRrwvg1/BqsCP7PfVp2fSrANr821dzSR8T5n1hW5y36HP3a4WgjO5dYW8rVA8NgN/POCxrIP6/DejhopV4SVG19Nghfw2X4wyFUNBf/qQMLmSmC8Z9Slv7QyoRUuIlFCvbJOv5kw8ZaobJqxHw4hkdKHhIaGG2xIPh7qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mb8OBiMJJJY0HMhwcuNPEGFpWd8rbsotyS2he89GHQQ=;
 b=YxGKPiciv7WK9xL85wzXYv6O++d52C+j19uOrHBPQhf+kxbJhP34IvJBUqCsK7vxcFGn/gAwxsmII/xaLjkANljdHb2YLL8XeeF8Pkfx8WqWDEMLQ85xnKYrPegJTqSZ4pbzyaPUhChbkC/oKFqZANNQwkrsxfe1enDbBBHGV9pT2pGfiMo/AEwMV+gt1r5OqePo6YZ9PTNs9ZFht6xauqfDpg0THfiK7vLoHO5NR1Ix6M3b8/zf6r8YBY0krrGKfKVg7crY/MSA6ANtZmfWAX0C5GZIXiPjkRrLJKoqSv6SWJ6lpKl+TlvMlgSchJEZG6FyBdaHj71XVOQTJtzA6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DB9PR04MB11598.eurprd04.prod.outlook.com (2603:10a6:10:60f::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Fri, 6 Feb
 2026 00:38:52 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%7]) with mapi id 15.20.9587.013; Fri, 6 Feb 2026
 00:38:52 +0000
Date: Fri, 6 Feb 2026 08:40:29 +0800
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
Subject: Re: [PATCH v1 06/12] imx: container: Add i.MX952 support to
 get_imageset_end()
Message-ID: <aYU4fYfkyHZGVAOh@shlinux89>
References: <20260205-imx952-v1-0-2103d0222a0b@nxp.com>
 <20260205-imx952-v1-6-2103d0222a0b@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260205-imx952-v1-6-2103d0222a0b@nxp.com>
X-ClientProxiedBy: SI1PR02CA0028.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::6) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DB9PR04MB11598:EE_
X-MS-Office365-Filtering-Correlation-Id: 861cbb30-498e-4387-7957-08de651819c7
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|19092799006|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0mrcuywFhlyny1ZRs2bLnHRLuvv84FPwUQTsr2f9sGKCVH0V4nobODIo3dAL?=
 =?us-ascii?Q?yAMcN/fXgCdvyhM8Nn4/A8/+B3PFSY3Bx1XloQXF2L/xbM064pL2NZWQrctZ?=
 =?us-ascii?Q?DPdxBFcEkQd4i8kInuOc3Rj21EdWn/p3JW7gD2nn0bOQKnGUeo891bD0Mnwa?=
 =?us-ascii?Q?fZxdgEF0eRjJ4AZ3r8QBovXKW8HmA+q3Qa81HO+g4HXusrtb5zwMT6Q2Zeif?=
 =?us-ascii?Q?ZpQBvWOp71pZ2tTG5Q1BJB3btYff49G8GUyqGhy3nPTvf9SoaPPiibP/w0AW?=
 =?us-ascii?Q?fd46XAPUW2nS2eSZTk9KTw5kMnHnehYehxn46v8qi2ZpxxFVdzKg+/UZhj0w?=
 =?us-ascii?Q?3e7NqkjXq3x2EA0tjTq+DzihXQV7S6dme4jFQEReA3Vgh2eJNCl1CK2Syik7?=
 =?us-ascii?Q?Vt2zPtgC9H5N0r9VfHm+nx2GZx9pyMzwf/qQUjjxIRWgk76gMdHkJcEl9XRS?=
 =?us-ascii?Q?m7gAmdVjwchC9a5dSOdbivXRiMLuWKFHbYupec7rgOfOADDlMmEYGjv1ZU7h?=
 =?us-ascii?Q?GAWTZMFPGijFHiaGL9v3zhnz2yRNX2D1yotMm9KUz/xV799WM/qyyUJXZ8nS?=
 =?us-ascii?Q?rGuB8hjUS3QaqOPyEFJMnBzHrRzI5dc5/853SgJMGbM4M+geB0gAtYAadrm4?=
 =?us-ascii?Q?1E/frGFIX8HWPaCB4NtEOOTLk0roQ4a6sBQaTwowGYiaXQwO6F5OCNnmy/8X?=
 =?us-ascii?Q?SG2oefWnTH9yhpWC4su1vKYnNYjSI/UYck8rNIFJv1Zjf26h9GWPhY9Kj2mG?=
 =?us-ascii?Q?1garc2fr3iyW8QBlvfnhdTJvkGKO4ttN3o/J4LaJ0KsG1GZ1YXGT83+Sj7Ks?=
 =?us-ascii?Q?M1eJOvtfYZyNi1fz/qGVLjSbzkkyimq6qvTkk3LEeNWHoZfYvWyPhqcg8BmS?=
 =?us-ascii?Q?rCNg0mxjOQyzXYDZfhGi7nzfLoK2AGJ5oNOcbrL4zxWlAw/vQDtNab3Gf5k4?=
 =?us-ascii?Q?yWwDtaDeb+wNqh6DPJsgRBgKNNStpQY65QrmWXJQ0pgq/Usx2s5yfQbXLxmE?=
 =?us-ascii?Q?/p6eQE4L7agLQwsavcWx+/emicm5rwcwnyYcPGVFYLN0qYeekrFyok8Vx4rx?=
 =?us-ascii?Q?+L2wJVW44JHXT6BclGhAjy9fjEupAqB6Ne54m8X+TWff+1bo5Ys4Gi9BCu54?=
 =?us-ascii?Q?Qeyn8343j+bAWmYqfUmbJChCxqGGqKiF/KSERodhayaOCxGo80oZYAAKzS8R?=
 =?us-ascii?Q?fha6aUds5hFg6d0Hhzsrb99kTE2NuTGuk6ZjtgxjockPxGL5OBDpk0PaAblD?=
 =?us-ascii?Q?79gyw349eS5TpvkWkIVjQZe1G/bsmA0uajJ8kBQGQtL9S6DKeGyh0PwsnNpj?=
 =?us-ascii?Q?MjwpKR2r5BnJutWdMhS3Cdg0BjFOTZ8mbiU99K9eIt3DuotdHLIgw70YR5Mr?=
 =?us-ascii?Q?Xcd+vY9lMAcYzabIBqZ8C+vEIr89QR5nzM1VVqJ3IhMGT+1/iupfTLgvW6Zr?=
 =?us-ascii?Q?4ZsKko1Y4HLNRUZih6rwvJejfZAulTdhSi8UFuwko2l8VMz0Nf7mZTsi4zQv?=
 =?us-ascii?Q?m0Yqlt2RsgU9TfjyLMP6BqgJc7j2bTqr314YDjP6HD+A3uCsXfDSht/7Rf74?=
 =?us-ascii?Q?4LK8mEXcJLYA30rDuzu/VkMJZypOkqCXcH/JxcC1Zq7Ss1b1IFlz5WvmbJQx?=
 =?us-ascii?Q?+GAlsiTn0LU3DPZpkPT6vkg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(19092799006)(52116014)(7416014)(376014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6KMRpEPesXzPhRD1iCuZQinByFrP0Jogny8NKgVjxji2iVtVDnsLBA4eWwFQ?=
 =?us-ascii?Q?IUIz++l58YmKK0Jm7GzyGz4bBsTzpS4xKV5IFWmJ6JtHMTN9Pz6pa7BNtfLW?=
 =?us-ascii?Q?ri7fOfY62g9gCyrzx4CrK2BX/YVYoSUijX6RUowfp2E6l+HIaU3gSXrkeOsW?=
 =?us-ascii?Q?snblCPJBz+g2Y4mVb5XfBLqBR/lCwHu7Qmol7vDXfcQa4NSI8NFJuClbNkwJ?=
 =?us-ascii?Q?uKXRBASwZXORFtQBFXfTbWce2dAQs8g2d2UNCxgjVC0v5vG8vcJ3yvOY5ah1?=
 =?us-ascii?Q?2oqrS73bcUzkg/gLBi3OScHwexpHXExhRpC+FBKsaquwOcfEv/SAsllkFd/m?=
 =?us-ascii?Q?A4OfL5ZRHRSBsmgb3w2Z2rAIYUAb0aXvxtY0UnaQUL8zZUapB/ZGMKdeuJOO?=
 =?us-ascii?Q?6clEisj6z/W/Ys/3NZMUXy6iuY3Mho67wwMNx/T3ADq+c8kyeIuoPzehCCDm?=
 =?us-ascii?Q?DpwdG/NebINfXR81FzbEumKgQyVZwYENqafh+eE7t2PJatT9PEf7SSBrM4WN?=
 =?us-ascii?Q?QUv9yX0hI/YFM1PBppKkWtbb4Gs6CGK9kliaF1QTvKgAIxXanBLTVEoI+6ND?=
 =?us-ascii?Q?uRlgXe/CRFmX5D8TdpIfgsvKv/4WGOfRdS3d0hs5lMfyvIA+dN4ULTSNA2oD?=
 =?us-ascii?Q?PVygIs5pwPgGY+2bSI82RrEGkv83pV4Fr9ZetGrOpcj7m7rPuqqD06hDbfq/?=
 =?us-ascii?Q?wPyD1jhY0L6nSNBlQD+nxWoPZTsubQ5ZURgJ63xdRukGiPYWeRsG7wFMYAzm?=
 =?us-ascii?Q?d4r2EIlxJxp7M0GpS3AH3yQ/o8iFBLwEIZHS+sg8t9y7u+dpM9LzVPA2BrOp?=
 =?us-ascii?Q?Df9Wh4SQ7z/8rqeoC9k/omSU1bnPbJlOmMFUQ39VYjmVi5ls9DWHMPE2XpMS?=
 =?us-ascii?Q?8NE8cr69GvupVNJ2DraF2QShMYYbUErGKFeQhdeZu2g7q+2/dSeCvRBug28t?=
 =?us-ascii?Q?FeVWIrO6m/9XseK0IunHLjsEaGhkPez+2TpOrkSAkzYdvp+msRatoTK+/g7K?=
 =?us-ascii?Q?9pAE6cvL4hwBl6My8XOR8R+GXyDnHMbOCOdcR1DpBiyx1EhX2wxxLEX7uqOE?=
 =?us-ascii?Q?pwRmzLkVTNEzgq4kxyopfLDPz+UXxy1YlzbFndWq6wflsDU2N/irHU7BMSEX?=
 =?us-ascii?Q?oXMF/YhU9aSb1InLDXrkwq255Wsf06mwwdz+R1PDEtZByUcEMs/Q+8LO+YTn?=
 =?us-ascii?Q?32thyxWpUoUkHiZZn4C9PeAgbTRMGk1jtP9DwgN/1eHy3bWES7Cl/KYK2NZV?=
 =?us-ascii?Q?mpEYhtdyQODbzzX1rHKz+NjmPpGm5dFI+hMUFs8ArZ2n9hAsqN0MkRLC3UVF?=
 =?us-ascii?Q?JSBAGKm3vXFXYo30+7+V0nBSCDULtdDXBZ6v6KL/qlA8OflmnoOGNyFjVS85?=
 =?us-ascii?Q?Zmrkqw697L4kwY0EqqBOHuwN1SPbknuv10C1P/+jqw8xmp0Nm/Xt9x78r5EQ?=
 =?us-ascii?Q?NTxA3w4PUkDhhyOWnbrLTgjpHBfUw/ksJ/fV60DQslA4R51jtvlUrrcNXE1C?=
 =?us-ascii?Q?TwQ1Klpb0hDppiaWt/b75r1+ULBMprNQbRsT8aRA9q2qDghYbeDlKiCzX6e+?=
 =?us-ascii?Q?M81a/GUCqsT3JCL6DeJxXjZpSnlOz5PmxwwbbUjBTV5eyNEWe1Z1qt2Xm3Xb?=
 =?us-ascii?Q?u9MHFxQc7lRgK52w3eLfCnQdjiSwP9rKauaAj6Rx6oL1P2Z0hCawlE5CkuAQ?=
 =?us-ascii?Q?jsnZEilCN3SXPmZutzInRKUgGCDKuxt+CEb1cv3fPamDqSg1AcX+1k5jWMmO?=
 =?us-ascii?Q?vyDJYbnQxQ=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 861cbb30-498e-4387-7957-08de651819c7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 00:38:52.2479 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pxgDdV9dYwRObuepjeTTSR72b7QgD7MDyxQqOeBe/psWT/3TPjDejFyhV6lX+9vUApfaj2QSQcyYhXGFekjE8Q==
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

On Thu, Feb 05, 2026 at 09:55:12PM +0800, alice.guo@oss.nxp.com wrote:
>From: Alice Guo <alice.guo@nxp.com>
>
>Extend get_imageset_end() to handle i.MX952.
>
>Signed-off-by: Alice Guo <alice.guo@nxp.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
