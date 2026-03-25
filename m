Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DD1D103A9A7
	for <u-boot@archiver.kernel.org>; Wed, 25 Mar 2026 11:27:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC91084073;
	Wed, 25 Mar 2026 12:27:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="wW8aT6JQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BDBB88407B; Wed, 25 Mar 2026 12:27:08 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 935F38405B
 for <u-boot@lists.denx.de>; Wed, 25 Mar 2026 12:27:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DEr1bPPi+/dkN2e1Qa0ZWpcLXT0LEBt3rjs7b+WII2/VoX7fdMQFE/hKJWf3QBUi0AtcOfUslaf66hR2X6SLCv4cIafEnazH4XzbOH5V7VE0IWFz+e4EMUpLjdprP7ZtoBkMN/U6bh9uBb5z5Y0meXQl++YhsA3mG91LfhDmlv6Q7n3beoMkGFo4S/a2P7KGF9m277D8VFfdceFEHk5oJze2mryT+mwtpa56S9v4cYa3nG+GgQ8F+jhmEvPKd2M4Tnqyf5eSuAyUta0kKqMwHh9gX/MRpIfDF1Xxu+LBkPdpzlgYdfeBdxMOw1ZyFSuwecSmUFOrbZ2ebtN2Y5OIfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xyloXdCOcXclNqZtV9c54yp/te0MLRagU8NvLcffc5A=;
 b=p2UKHswTEyr7heIwvvBOl89tPeCUsteYVnAW6MkfEJdB5m7Dpir4Vkof5ManvtVCIg9hAktzwRLGB8ez9+Salx1nft2kn9XEBTe/Q4gCObLusbTkfd5A6Rxc73v5hlOa5QmpQ7nX/JW3IFAbE5X8N0EdW8EbFp8kq3X2isFwDVKiNV0cwndkiKrCTwoHheWKvxE9eXfjTAKgcGzph6Be1ujHUnVpp4P/pTu+bOruyXbV/wSErzawssndQrWKsorEIhSVyiwfLfLYEpHCGm7txPT/0qB3HCl2USMfzxPpVRGKB33p4zQHxO09W6uHF0Ms/MGQuTTNX1AVIJxZH49m0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xyloXdCOcXclNqZtV9c54yp/te0MLRagU8NvLcffc5A=;
 b=wW8aT6JQ2hCKlwE53QA+ISn1eAZAYyGq7dSyPLA+SurDWZL0GLOz6LWs+EOj2BBmDAqWsVqgHNxvD2Aov7sl+VR20zSQTdK7qdgnCxe8Rzz3LVGdIQaQDMBvsaEqb7ijrtIVmItIutsTmG5RWt/Olm+6AAGsoY6EcbIezHBQ1+7OaPFWs+kZG6MEik75vvFRfedmf+x7wDJ5XsXFleDpj1dcbQ35n+1awqQNQIrzNF1RgiWgeSYQwhq71flkDthTkoY+mVBrrPk6GubLaqxwxMNb6tcpxfveycfIfZKo4A+O1zeYZcaGhW/Mms3MERPER9Gc+YIPHDvMI9fLbc6XfA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 11:26:59 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::4972:7eaa:b9f6:7b5e%3]) with mapi id 15.20.9723.030; Wed, 25 Mar 2026
 11:26:38 +0000
Date: Wed, 25 Mar 2026 19:29:13 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Alexander Feilke <Alexander.Feilke@ew.tq-group.com>
Cc: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 u-boot@ew.tq-group.com, Tom Rini <trini@konsulko.com>,
 Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v2 8/8] doc: tqma7: add documentation
Message-ID: <acPHCVW+6MJqIqND@shlinux89>
References: <20260325095801.47706-1-Alexander.Feilke@ew.tq-group.com>
 <20260325095801.47706-9-Alexander.Feilke@ew.tq-group.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325095801.47706-9-Alexander.Feilke@ew.tq-group.com>
X-ClientProxiedBy: SG2PR02CA0078.apcprd02.prod.outlook.com
 (2603:1096:4:90::18) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AS4PR04MB9692:EE_
X-MS-Office365-Filtering-Correlation-Id: 5708c385-a4c8-44a9-4345-08de8a61617e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|52116014|366016|19092799006|18002099003|56012099003|22082099003|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info: LA6X6B28NmjnmVOvPJBHD2FaQ03dX/btb1lU7BtPu+hgQD4xunnv97u46Y7f7s/9166zbH5OdGRfH8I6nquM8nCz1VW4MdWTKmo0NOKp1Zcb2fKhAh4WZsCF4PKcz86KWImJ9bVjVMbgGIxX+Hv5VIZ6kMW6+YVZZqEzZPPSMWPiJQ8ZkBJTdI9iSXbBHZ826Olo3nv/7WjRgZYtZXzujVZGN8syGGzV0lULyYfA9KRKF/cDAfaG6rIo5QpUWqnx6NzOzALwZKWGIJS3QpvCJyA9aPOxGXd6DnZhqgPP9QIvTVKVeZxpFgno+tuFZGsXK6jBD4tcF/G2sDxkuWdz/prAFaZQdKbIvQt1rLj/7/NEJo26s6Rf8Twq8HCWU4Ghy40w91jFLO2/ruennfQPAUse1Rri7GPa/u0keFq34ZEn5A4hW556gHqu61TWDChJm7RYVdfCRIDJrSoxMrtAGJ8021M22OJnFjsgc6vJOpo7eYO0rpAZgedUrCmDvYDtZywZrdkBUIQ5cgpeg34AW2DFIf6WRmB5B664HPoTQPo+v4vGG9qiqHUJ3mZtKhsgkS24V8tA0t+4eJtmYyPmPdsGJi1pbeEY6/Gb0jr4yJMHReRaDWQLxI47E0jBftbg4eDxifQxjIm0jM6kwoIzovsAZCiqJNsKEg0Nz0hUccz2PtGjdTTXpcPD5gZj4vRF2D9QVYzgnXjA6fwk/AG7q2TGFTetsn0Vkd3Ty064wGVdA7slkeRIo2TaO+Qd3X0do22m5A1Q4gbi97sUbasJn9SfNqOByb8ypZOxExaHGXY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(52116014)(366016)(19092799006)(18002099003)(56012099003)(22082099003)(7053199007)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8YLAIKlfkAEhB5pgNwGr9xFh93zoFsSNPJjNr+HASOlysDSH8OxsqXwworbY?=
 =?us-ascii?Q?w1uiGFvMCPi8QGJrS/wK6RkOb1lWyxiMI6HeCXgPqAakzRhjd/UV0ILSw6cq?=
 =?us-ascii?Q?UkuLxCTc8GLOYtYpOeBbsJORyyzqG5FlN/YkDknaJZYLR+VPLYlLEMYI3uTl?=
 =?us-ascii?Q?kyHZ9Xb43XEIXd8ibNYuA4sFAjtRWZwXzYxTD2FnafK/mULvPI3POHqJnmft?=
 =?us-ascii?Q?Y2v+pfhSMMRQPCIH/25TyiD98AJ35p2FTAKRvbdyjQSiEioSUg6MnaNpIpmW?=
 =?us-ascii?Q?kAt2Q1wKqW3blazKyA442mXx51qyQBUrUOZBVZbBDGBT8J5Mc5/S9P8tRl0x?=
 =?us-ascii?Q?RRslUvPssrugjMrwQ/9LvUbKXPl1/NWqKHcbeD24w2wYSNzeF1i1TH8DC7gr?=
 =?us-ascii?Q?rVPEYz02/stX2FSanMgrgjqG04W/sP62V5KygM+whE8QuCEdHAK4cLO1fLkU?=
 =?us-ascii?Q?G1FZkbHYnmRqgOCY7/NVJudTiH5k3x0wf4ZiZMC5HxkefNSSblB3+9QpYZCV?=
 =?us-ascii?Q?6AZJxJEPrrIBXR6M3/KQhUos9f4+CIySxDqdnJ1JBkHqKnZNAPKbtlsW2jEP?=
 =?us-ascii?Q?0fjWJi/pR7srOZv+GRvPtWoiEDcdBLLzxOjzdT8IKc9o+77vAS/u4zw5XI8D?=
 =?us-ascii?Q?dAwwtHbJmTUh7C/GUmVATTTaFJxGTFvthzF9xrJWJWMDNCu0x9eQNh9Mz6pX?=
 =?us-ascii?Q?lX5kl41cqW/XO9NMPCu3yj6MFuKfiEBZjuLdt8H1FjlbD2p23BuS9XpQ2aQ4?=
 =?us-ascii?Q?Lh2R4Rq0TmgxEQLc/XxozyuGacAStGD0xN7U0QkDTrQCXmK7z2h45UHPmeL6?=
 =?us-ascii?Q?8PmWjvPPJkm4EHYphSURcsfP430Zo/opbBaWDxWgKXVSbQhBTlLzErr1h8KQ?=
 =?us-ascii?Q?HS6oM28MxHLlURlrpAC5Hz4Vr9iugYU9VZAAL3QRn3YQk9uHyarWysAVQn2+?=
 =?us-ascii?Q?TJ7foyIFmRGJmDXEpJbCnuwm1vaQdKJ4fKldcUgnP7HVENBc9oVb6mDh7a5s?=
 =?us-ascii?Q?litEzZ1Vz6Pg3hNNqrcOvHMnnkmcwkhrnPA/YvDH0oEmK6X/IDxM8KhnAUIp?=
 =?us-ascii?Q?xSAA0V/YrG632qktWRNSEgRgswWoPzPVJ691RjhdP9F0R5y4PRoDHzxkdIIu?=
 =?us-ascii?Q?nuX1HtQxTcuQWeXVtF5nhxOOLAqlYnergth0vgHMo0uR+HY+uYKzlhzz00Tx?=
 =?us-ascii?Q?GEYC9C9fELvzXO+P1GPx4Xugtek32MNiiYENguHmPDRcAk0S1bdZY1L4qtWP?=
 =?us-ascii?Q?KKDM2sQs+bsFiWF39uSOmWZWjXzaSbNsB8RQk9Z2HPmlirI/4xxmCmtzu7A+?=
 =?us-ascii?Q?yc4M0YlJ2DF5O/TtyTOlBBvVdFF5LSBBVJv81xerRnM1XcEfRKJif1D/UJv8?=
 =?us-ascii?Q?a0Zdcb9Tl2yT7xzXehwUqWR/bz/+Etqi7OhaGkAahph8Gq4PhFU3WVU5MK1K?=
 =?us-ascii?Q?IuYaBU4V478M08Dhhdm3oUu3wpfNwJB0f81YuROebVW1hOW7fSpdShB61pyC?=
 =?us-ascii?Q?2dZZlOaH6pF5XumNNdeYg7cWm7qOz06QCd/dawuSpYAO2s27V0WgYG5mMeHa?=
 =?us-ascii?Q?WQ9GfoplSyg+QSn2wG+mJQU03ChJXUAILlkXes6i1tjZXww+NKgwRc3vmMH6?=
 =?us-ascii?Q?2i3exDnDy4au744k/NMxT91l8C1nivujG+zmVEmzfl3bo06Tulp9Y12mjrKV?=
 =?us-ascii?Q?WFCfe+knN1GT0X2P2Ffj6C+IvdlzZVFz6DvkQkYR7P/2NF/pZbjd87FfNjeZ?=
 =?us-ascii?Q?MtLQWVmYfA=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5708c385-a4c8-44a9-4345-08de8a61617e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 11:26:38.6418 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tlpS7H0SXEDD9phvoYlmK8f6wgWokPelsQ0E7E57rFdHfcSj0Ptg5ppu11Zy2CKHOgNkp4wo9TuUQkdQ9sDoVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9692
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

On Wed, Mar 25, 2026 at 10:58:01AM +0100, Alexander Feilke wrote:
>From: Alexander Feilke <alexander.feilke@ew.tq-group.com>
>
>Add readme for the tqma7 board.
>
>Signed-off-by: Alexander Feilke <alexander.feilke@ew.tq-group.com>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
