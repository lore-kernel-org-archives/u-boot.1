Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5A92C2BA1B
	for <u-boot@archiver.kernel.org>; Wed, 12 Mar 2025 05:22:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B23E805D7;
	Wed, 12 Mar 2025 06:22:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Cl+Ka+M1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 224CE807D7; Wed, 12 Mar 2025 06:22:15 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20618.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::618])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0CB858003E
 for <u-boot@lists.denx.de>; Wed, 12 Mar 2025 06:22:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NYF3Ffj0I9ulIyDRVvjBLOrEdaxE/2q7RzhJRyXYUcbiIw8NtAXBu0MjMOwqMatq0bV/verAsaVXdSBUcZFScwpfoeBhvZjV30vFk/Xgz0Q0wjvxNDFkwDEuG4CySOmgFSccg2SXWPN3a64kyYkoKcyZl2CdV3hps6L+XNjF3VT8+eCIeripOdIq2HxNp2JRSX4KVJhB84UjM3rRxsd2uKpeA9YPvFKqrhbLpyHPeJTWrFqTS6d0E7icID1UklpHTJHUPgiWtszyV2iQLTaGLexkuRZZo2BUOTV2nZ1aHF3rm5z3wlb+3wskaAxT9+DAce2YwDG16Tt3fh7itp29mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aB4/OVheInU/b5LZw1NcisF8akiKi0dj3Nb7vX9pjUk=;
 b=qfJxY2/p4E1OMJwgPIv1+7XFQ/t52KsjOxuzxuRJF+rVsRWxi3Ig+pAZsN20O7cXWj/Pa3xzNV18TRdizRi78sGYlx2YJH4RKA63IUjaEZxD7Q+EVm1j47tgdrO6ca6BthKhRAsWt2WBikIQWtkRFnZUU6MJxAhbRD+quQTjWOARWHnkxZbBA6BwJdoqvi72yPLDM8qB/rSJGEmyce1rh0BvAlnro0xxNFniKD+kEsafzxiu5nC4es09m05qMIA1bu/TdlQvEJjRqG1o6gW7iv36wssgEcKZ8/y9MVId9LBFWhfsxrb+xNj8gRSi3SR8edoLvebzwFI4etQ8pUVwCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aB4/OVheInU/b5LZw1NcisF8akiKi0dj3Nb7vX9pjUk=;
 b=Cl+Ka+M1TohBoZ2X6Ijwa9H7aXV1whI0eGt5wxkBb4VJ7gIPfTiNIWngY7LAIRoBrUflvoc1MaQRUSSuY8d6LxRacVn2LiyoRAlmaS7CDOOJo3bvhjS7jYl7/1w11glzFNltvNHliBZPPzzsun8n5RNjuWM3TWNZbIc3lVJQzwoRutChnSQhOeppXC4js72vznUzHgOB99HRrvhB2PJ9Cb98TMuNDWKN9+50M2bINNajclKT15MKnMZd+EREyfZHsn/jO0rUiGeszEmpty9BaakoSjYZiiyn3UowUNbF5giTjO5RymsGgu2tBqlS8vgLV+rYP9NtxIn+syjAbNRUjQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DB9PR04MB8268.eurprd04.prod.outlook.com (2603:10a6:10:240::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 05:22:11 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 05:22:11 +0000
Date: Wed, 12 Mar 2025 14:29:50 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Adam Ford <aford173@gmail.com>
Cc: u-boot@lists.denx.de, aford@beaconembedded.com,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>, Stefano Babic <sbabic@denx.de>,
 Fabio Estevam <festevam@gmail.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Emil Kronborg <emil.kronborg@protonmail.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, Tim Harvey <tharvey@gateworks.com>,
 Peter Robinson <pbrobinson@gmail.com>
Subject: Re: [PATCH V2 06/10] board: beacon: imx8mm: Let clock system enable
 UART clock
Message-ID: <20250312062950.GE11991@nxa18884-linux>
References: <20250312003041.110023-1-aford173@gmail.com>
 <20250312003041.110023-7-aford173@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312003041.110023-7-aford173@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SI2PR01CA0034.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::9) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DB9PR04MB8268:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a29f7c3-208d-4365-4cb1-08dd6125d743
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|52116014|366016|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0/TKP2zwRAEzl4R9THfnUniJX4pump5uZqo966ADz5ADleOTeDBxhQpIsrxn?=
 =?us-ascii?Q?SW0N5qb+k9aZbzxveZBCn/zXhXzkJDT7B7hs2DSBekLy88gO55AxqAR96eMG?=
 =?us-ascii?Q?h2SRNT2fbaLbCIgYYNwcQweIHmzRAq2ESAC58nVHH6hv3eZvPEqPP4ae7SKz?=
 =?us-ascii?Q?WTxf6/C2FSwLHAdyc15eqGx6MVRlxlSA/3wb8BrSEbcWoIgpi7HL4aoHqLuw?=
 =?us-ascii?Q?G80I+Y1yU+uV22VfO5cqsJfdP+US5GRwFv7fkydjdKy5EDJ+GC80mLkuc4pK?=
 =?us-ascii?Q?XLP5ethLS+mwQw7OV+ubSoXsxwOBAaMO47e1fYrW1Dbq/L7yB5SlpN9FbD9G?=
 =?us-ascii?Q?qvuRquogtI3Wfs+L697Kv5g1UYA+uPsxcuHdLAOB4Hl6flB5u1jSVQ5ICnVD?=
 =?us-ascii?Q?/Gv1Dl3JN6P8a3mvG86hZC/84q3sqOFTGkVI0aY8+x97fqzOyT+LhaC1zOlF?=
 =?us-ascii?Q?k/l7uMF1NyVVAgGzmOsD3su8gIcgyTuv6qM6RObtC2fdTkad+mVbtwPXc0yo?=
 =?us-ascii?Q?7ODE8PbmdAGrf9CEL0eaZB/vDgyTiB6ZaWxWb0//KI8oJEiXFxH6CEbOKfxM?=
 =?us-ascii?Q?AWWsrks1Efi3Rr9vX/gCaLQt4ttUodhYq+kJ2zmtI/pd98sBfN396M818qAA?=
 =?us-ascii?Q?96En3qPkevj85BFa6d/zURoo3Doh+S0WgCARSJiC1kiVw5fMCk0CLsCY8EI3?=
 =?us-ascii?Q?Ga5BHzfcJCaD3fv0G6MdHUxuoZh4+B5Zh71gSIO9wU4noq0nFEGwg66opjLF?=
 =?us-ascii?Q?svd/oqzd/2mJ4YFxIO5DyHN0PrC94CCUfO8gyISx2omCujiJngYFTtQL3sah?=
 =?us-ascii?Q?NZyKVnguIdZYd7VVABIt5jXe3wggs2rOJc+L6Xg4+Yv3jFcOKZhkCVML4/K8?=
 =?us-ascii?Q?JWFrD0taxlomEJ0w5xEfqgn8E7s/lwrU3XS5Go50riLUQeXOJd2J87Wcl5wv?=
 =?us-ascii?Q?MJuSJD3vYlK+tZ/zqLDO0a5CF+nuDRD2ZuPbtYwvw4bOpc2RsyNLEx67lqRn?=
 =?us-ascii?Q?hYt9pnlB7kCqC78Wnv4do8xxP1yqnVcmJgN0cr2mO5SiCd6y5SiMRyNuHrmQ?=
 =?us-ascii?Q?zJZQPBkqe8pIv11vlBeaIf6MXYSm0sa31ZHe57WqOvOBpQXb7xVkpYunf9A6?=
 =?us-ascii?Q?dGt82c5PcgqewSRz6ny8ziOjiwKb6zgTAXt3WVmd8I495jJ/PVTqKo2KbS3U?=
 =?us-ascii?Q?XarBCcjV/lhNiGFMCmYbkLlKhXHt+bjlJbRxo8IOFJ6n3uQ9aDezss0fnPhb?=
 =?us-ascii?Q?2sgLHQFArISWzOxcWhMvOwZAZBJ5TQxTD8u+Q3glv13Ku5fpBkx88Vul5dv6?=
 =?us-ascii?Q?ObtPbWTOFP7kWPyUEvsT7OD1V4kVMqKwFYSGbwk9VsO6j6sSu1NGJSOq4MUN?=
 =?us-ascii?Q?oABkZM1owlX1wC+LpZzSDjpwnOE6QdY1lKwpQQJTrxzpJztKJcj7VGLp8YOz?=
 =?us-ascii?Q?1jDS0x49l9SmbvrisDRFNArARu7k4ILn?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(52116014)(366016)(1800799024)(7053199007)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cTv2Mx7C0bQFEKpPrjPknrG1VTUdqIe4q8KtFvPg08GBhCD6KK/3+Xm2ax86?=
 =?us-ascii?Q?yyR47uwdDvmaMAP8g5X/KCZ4yjtZMn96Hfo+iEcUZoeXOaJQ3PxzddQY45rd?=
 =?us-ascii?Q?B/f9zqzbcFiYrDTPMpbZz5DSsJfqYMNLBpm4+qj+f7SEBD+JXv6d0VJFrMn3?=
 =?us-ascii?Q?cpXdlFRF0dxPsNHLgfMTR7QR5ghg40CH5Q0uBSYR+LZzkkXTLbNvsIRar6Ie?=
 =?us-ascii?Q?duzIIzynfNxRNk4rQ3klQJY83LuuQIKXYQ48RAWENGaKNmmyHSW1bLRyM5yB?=
 =?us-ascii?Q?zq2DA4etu3TbSg8L+CcxNbIWngG7nwQf+v1onR05VOr8C9GauCD5V1Ahixyx?=
 =?us-ascii?Q?dvYiljbeUgET5/54vGoAJKR2fMsmdE6s2pPIP/fkPcRo2ZAeZhetubjD/ng+?=
 =?us-ascii?Q?1NVOQSaFVp1Tk9ZfDxqKL+CPMn1ZGHbIcQfRhFS1dViNwgcH9+OLwv0R7Ssp?=
 =?us-ascii?Q?GKC8ps349kcyh29FE1YjuHiV98e82jy3x/Ub4axXfAKB021UhHBDcWsQwB6p?=
 =?us-ascii?Q?pNzbvNvGsjicbEn9L2LhPhrMiPf1ylvgt5aZUblpzI/9uhGgkhb7rHsuTfxM?=
 =?us-ascii?Q?mqTLXxK2AzYL/oW6C+PtZ0FD8yEH+igGMuJ2in25WlLaRf1rzxHu1rPooiKh?=
 =?us-ascii?Q?IR/5oS3r71We+x3lvT6Tda98CSle+ayFh3HS0mb8JjV0m/aMRv3GzfvXCya5?=
 =?us-ascii?Q?LZnKXSeKqHZH8TwfHsvLKR+0tj8/HjiHee+brHweONo5tLUxcAXUmpKjHepF?=
 =?us-ascii?Q?gYKpEiaj34NBDUs8+inaPkEj8VOv/XQYXF8lL5cpIJExQfff+L4ch387DwbI?=
 =?us-ascii?Q?UBDlroYpuoI7T0K+cbFPA68yV+KaynPtIayKLPA4NOEDIU/x+wCIN+85X7Zh?=
 =?us-ascii?Q?DBruLzzGPk4NmkPOaMohkmmFArg7qH/h2OImrwtDaw/SsZvKBRvwDOH6fQ0m?=
 =?us-ascii?Q?dXhqqDglwAeBtZIXJR5nHa7V+GHfNaFl7E0xkEJ9enhvffkIJH5+VwuAI172?=
 =?us-ascii?Q?CeehdWAUuoemZtctURW/fpPsUTm+uFr1uGGOXYLSlABIPGDdM8AysxS/HcI/?=
 =?us-ascii?Q?KY85p6weBsvCNA2LQWVGaxtB/7ttH/6b3fA75EdIqGz+APtBmN5AFhRiv1VR?=
 =?us-ascii?Q?7dNLcqsQS1ZD6Bt/I3FtPSVFhOgDF71irIUw4trK+bZZWFZJBeWOIfQ6rnE9?=
 =?us-ascii?Q?VOALMUWB+IO7JLv0uqIgopT0GvsyEEw19kwr57XIGavTwI5yr2qozf7ps0kO?=
 =?us-ascii?Q?q+gsssjY6Vutb9bbaz4UKa4rnkYRzuhezjDwgvkaKsEULHS39CcOCjCgqVRU?=
 =?us-ascii?Q?0U4uoNmi/01zc7H16mZOjbjgQOSZTuXm73BEnMF6TikSkWykPxPY0yotSOAC?=
 =?us-ascii?Q?jO6hGnizPtQjiYaTatGueqpkH8ecEySpSjwmWewDbpy2d/qjwGlvHw12pE6q?=
 =?us-ascii?Q?4RY4OrnDNhf1wh8T5DF5xTPZb0LaW1xn0sM2x0RmsDADNG0/BQ1V4rzGX0Hi?=
 =?us-ascii?Q?DKWIkUWu3D6XQckuMY8O9EeFKs07Fic7rB247O0En/3uKjrtrv2/ZSMpv6qL?=
 =?us-ascii?Q?UGrJzRgZadYintViTwztrtjVYlLApQBlqaSuF0wZ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a29f7c3-208d-4365-4cb1-08dd6125d743
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 05:22:11.2119 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u4xN+FyeEzdT9MqmPMh0zknjma3najswg9jxoYCLUxwATCL5HALSvxhIHceoRuUoWnyopsJEHa5lAtQPZ1xMIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8268
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

On Tue, Mar 11, 2025 at 07:30:26PM -0500, Adam Ford wrote:
>Now that the UART driver can enable the required clocks, remove
>the hard-coded clock enable.  This requires a small re-order
>of a couple functions.
>
>Signed-off-by: Adam Ford <aford173@gmail.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
