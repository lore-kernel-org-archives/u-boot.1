Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C14B7CCD1BE
	for <u-boot@archiver.kernel.org>; Wed, 22 Oct 2025 07:22:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 48435835B3;
	Wed, 22 Oct 2025 09:21:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="qI+pumnu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 277D18323A; Wed, 22 Oct 2025 04:04:06 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3917082B20
 for <u-boot@lists.denx.de>; Wed, 22 Oct 2025 04:04:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a3IG2ZpnT3vhqKk2SndqKoTuSZd/yEeEtXbf9XcHPAcdUeu/CkH9sGgInYT4sC7M0TBoeUcKPRbsQ7KoQtlkrILjvfoppJSeVaiH5HWHVacEQ9IR6c9J9NMWlNWA2t7IS53YxM4nZngGswf9LxcixRISDtc7fQtvDwqiDv1H7zR4V1n0yIk0Nnr58d9DFJWt6dl/jiEtape7UkCfbkTy0m7o9sGwWLH/lCqo3ZtvPB4VURMzeqXuL6dn3aO7Tiy4Ptyw9ePO+tWlyaZbbg6ajG8wxCb6Gz+2qf4xFnhYlbN9+3ytQuRvaQDLIJLuLNOe4FdbvEKEIV0E6sddYkrscg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OInUyqYnuqKEkcX/LLzAmPk5/4Yww2Ckbj1qDDUMv3g=;
 b=hyllSfMIxNNAXiPDiUwAAHiTbHK8RRMfVuFJeKuyVv+i2KCE4b31CVMA3pXZrjSo1kr832teloCchWHdawHZZyPnF99vAw1r3/4isqZWnPWcyXh2WX9SX9xc4yq6laIZ3zrmTB9E69wJdGGBEm4HF1NynmfT/Ri0i2wz1lOU6T9ptk1YDLGhDuAZM3rRvtGMMqVPdBgMIDKxJcQTfnmIdZXb+P4/TjGjuJjyrQId1ERIcmSFHbHeYGOJnieLPbwwk0HUoBcJ1CbY3JKt9eq4+m9/pQHGKwD95/4gjAQ/ck6wwIZ+Hb/52qIk34eEqmJYYrRkFZzuXAvD+pJtBs0xdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OInUyqYnuqKEkcX/LLzAmPk5/4Yww2Ckbj1qDDUMv3g=;
 b=qI+pumnuEda4qiwwqKYXAiGbzrn/ttCPobNZJ8vlafZJBcF5SSb3C7+ygfZlMmpbxlfo5z82cTArHc97Ctu5fQH8ObvQYN/tum0tWSgT0ticFhFMki5yR8UOG495M455LbOsu7DXquwyHlgYH5XT8QbauAlbKlgdeGfkbOgwMObIQYQIPOpv+vlAx2YBkb4Hm/mJsYWLX1EQmha5Q6R/KPIFc+////Tv2aiyrAKXqrq4saWuoJYBPYoZ7DPuelSpqRWMqXFL4yVIF+UxFnNYgXzKm9gqwP6Rk01Wb/JeMX77TzsS0+7rmNQUe4f9wx/8ufmz4or9IrsdUjA6faC7yw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
 by DU4PR04MB11435.eurprd04.prod.outlook.com (2603:10a6:10:5ee::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Wed, 22 Oct
 2025 02:04:02 +0000
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197]) by DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197%4]) with mapi id 15.20.9253.011; Wed, 22 Oct 2025
 02:04:02 +0000
Date: Wed, 22 Oct 2025 11:16:13 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com, peng.fan@nxp.com,
 jh80.chung@samsung.com, marex@denx.de, tien.fong.chee@altera.com
Subject: Re: [PATCH] mmc: sd: Handle UHS-I voltage signaling without power
 cycle
Message-ID: <20251022031613.GB15054@nxa18884-linux.ap.freescale.net>
References: <20251021204526.22701-1-tanmay.kathpalia@altera.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021204526.22701-1-tanmay.kathpalia@altera.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: SG2PR03CA0119.apcprd03.prod.outlook.com
 (2603:1096:4:91::23) To DB9PR04MB8461.eurprd04.prod.outlook.com
 (2603:10a6:10:2cf::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8461:EE_|DU4PR04MB11435:EE_
X-MS-Office365-Filtering-Correlation-Id: 5245e056-7c5e-44c3-b030-08de110f4581
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|19092799006|366016|52116014|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9iwKg1NkqU3s+L16+uiHtUeczLZVATjEl6XrmA9daDigbx+yoBbF7pSpwML0?=
 =?us-ascii?Q?SpFKIgfzC4DB8Aemh0wB+r2cAdMa1GdsKkC93ts/V0xLl+iSPUwWelZke7Ls?=
 =?us-ascii?Q?C3+sEJ3uo4Xj6HmVlivdShMwzG9kPvzeLl7HbGuX7fdHgJZ21mYfJwU+OhxX?=
 =?us-ascii?Q?G4+F6Q6CjGjGRd+cBoaCKisPkxY4HwTpxP6BGGTe03/gOrAwtS0FBMc+xVf8?=
 =?us-ascii?Q?LtRDWew5cm8ZMVIfnz58FHznN1blp9mFNdxf2ABVCExpsXimkOhOL3gIv3ux?=
 =?us-ascii?Q?Sol4ytqhL2T9ZWW6u8oOftVC2gfY8EpZCB+QZeJLifoqoLaxX/3+hTyB4hEM?=
 =?us-ascii?Q?IPMNwY2uvcmsOIH8BXj5oe/fSCzmfqoi6ZfVgyrdS/HxLon+JGrp0zeHm0fF?=
 =?us-ascii?Q?CH8mlQurjSnqwBvEfSOSWMIbCh9rIKBs4Ts8m0Et7OCZr7gmTMdKZProwV3M?=
 =?us-ascii?Q?Ah4a+j2RQwnsq9sRmslWx4sCmjutoVNTiSrrvtSUhXUwWcgwN0DKyJK7odxA?=
 =?us-ascii?Q?ZnTbJcFUIKqAHRFZtWJXOGaTtGHIwhP/MJbSpX+uVJHJv9+5mSF7v/VgzsZr?=
 =?us-ascii?Q?kEaqr2vOZonCBsL94XQwwgU82YVjDuirmNRgM9UvacerMlJduf8Zre+UPoi5?=
 =?us-ascii?Q?7SkhzNezJFKe4oLMRfSM6OXvRPaAd0pVvrWQxfxD8cBb2gAfGbKqgRUlXvuK?=
 =?us-ascii?Q?0nltk0RwHC280n9kyjeh+IByN+oG1v+ZWOI+K9oBrE5fo9K5qUgxrafJZ++i?=
 =?us-ascii?Q?nKe+d46tE3fK6yB6iDpEktqJNKVG98Vxc7Ha9a/ybUa5CceQagf29hGng3ZT?=
 =?us-ascii?Q?QnwvkoJzl97d64jcTxwzRl3W63LlhOPrzBqAyFLTkic4nYJrD52KemT6qp22?=
 =?us-ascii?Q?BN533GKYbiRk62lfcrMlxgawzGUDI1AYCRtuTWjltXrgdqwm4fpTsIsiXHsh?=
 =?us-ascii?Q?jh34xlRDLsZDfV07gizAx+1u6MEBPTufIAgjo2RYel7geZGrS2X38Ikq4P5k?=
 =?us-ascii?Q?XjKxC/cL8bITttD4VnQP+8OfGUxwYlgTqY2U6X0cT//JOjvfigJbDfzZ6vX1?=
 =?us-ascii?Q?uumIGQhxHijYyiX0BV4mkctXBeWAwDgMpqS4Dhmx0gYByWBhkQLns6DANoQ5?=
 =?us-ascii?Q?uWh7BDwtwWjb0CmO48dmF54WQcFhos8kPSiNySRQmhKF4ryPGglNM4MSeOsn?=
 =?us-ascii?Q?hFqrkBeEdrD6CZasnPVps/cFzRZMaQnE//15esKEKuK7tsvO5uqtbS0/HGM9?=
 =?us-ascii?Q?fqtX+HS1jtjHSA+Cs011jCEchwX9fXM0HzSyypgqf+iIg9Gv1sVpdN9ue/ji?=
 =?us-ascii?Q?gjXmlenlp/Ml4DEfuaXUoDyb/bD/Buk/7g3rMKTykirt7A2blBVrnE+Hd1Dk?=
 =?us-ascii?Q?MwCx0jQYmLJE/59RXPC4TKriIlzhStZMKAVHkbvNM/5Y+vbikRouPYXazLvW?=
 =?us-ascii?Q?GrCkC6fA+JpIdgnOZfjz3e1VqkhX/uv9QrEvMlq+0N2KkOSHAlMANXdrRvzd?=
 =?us-ascii?Q?Bd0m+yJpmzXiApw5XtIYK2kUeYRDXxid4rm7?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB8461.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(19092799006)(366016)(52116014)(38350700014)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?t9XbxKidVBQpxlW3LFAuGDDWn1CgRsvU7KRq88KtFbtu605eW6PVwAsO+HYk?=
 =?us-ascii?Q?1lqLvZWwQb7d4nqOEQWFaY8pPv9vVEVv2FPAsUiD82N4L96kSR5cYMCYLXlK?=
 =?us-ascii?Q?SqDGgB+CyeNB/KuUgc15YfWeYK5OkCn9yQAEfO/BDzAl4Plrq2SuJhQHW1QB?=
 =?us-ascii?Q?2D+WSkrFl35xFP9TKNbxCmRafCeShhTHuNQmJrkgVWOtOBuSu5xLZ7eQqX0+?=
 =?us-ascii?Q?v2r9RJzgRIEcHYA6rJMWYkDnVbWoEjKGXrNJX+v3LWyxbX07506G9WjvsWfY?=
 =?us-ascii?Q?NXkjxi3adWoojxz0HB1wD6GNbkQYYn9Nrnvt5pi4RU5aR5mNwcylLbCUEV1t?=
 =?us-ascii?Q?pdMQFjn8Df8486Qtvz8BAUdL+rbAg8OpBvG9HHlloLuRYnY2DbFmH7fyDRbF?=
 =?us-ascii?Q?K4bP1uvWrKCzUgH0SAgSH5oqTSiRy4eACLYEjNdDm5gBkJaUOoEwOVrWcFEx?=
 =?us-ascii?Q?N108HfjfHohkjtT0J3CnnK++ak2G8vl3uuSMfTkek1aU1pv7bnRLLHvQrieD?=
 =?us-ascii?Q?ony+FKWNkooJem1M5WEOXPOpAm7XXyo7ToFPKWmsKkM7xZ4O1ZJ/KgdGGoKG?=
 =?us-ascii?Q?FOivit3TfmiClqc1yPjnl3qVtPi133qTCfRo+Clzke+eUgSdGZiGedOprzyK?=
 =?us-ascii?Q?YJCr01f/KSf1GM/5Q7tjuATH8NPOXkIBHqHw/5jvvqNj1BfxOjDM8DU+8hep?=
 =?us-ascii?Q?XeMWoL2M3XSfZuMnLzQywfVFl1T14yIO5H/tRiM90cmPJzwpiAWwiTLByhhn?=
 =?us-ascii?Q?id4H0ernv9j1lHGzeDS4QaJsDTE6x3nzCzXznt/ZAkAZ8XY6yTVcwEv/wbVa?=
 =?us-ascii?Q?CuuB8Fj6pzxEJaN0aSFfWYeudKOZAauJ8/r9FknLj+HIuSmhv54ZbNQvkKzi?=
 =?us-ascii?Q?y37ePmf1lK1JUAshJ/Of9AZgdaVVAN0KHPdd92CvJWvZi8PJB9LRAhA96Ycm?=
 =?us-ascii?Q?Dz8JBZIdsxll7N6TswrMCqtzu2hbxmB1gLGl05baugRXmDvwvMjCRP6MBppW?=
 =?us-ascii?Q?LyLIeJfWnXNDuX6RlVJWjTYaZJlX7nZf7KBo4ekN6MIC2KXJGquUUxGxzmmc?=
 =?us-ascii?Q?6+1tYpfRjjZRNJk5W+8PrtJ/agFvnhVa1Yy4CjWtNjFTwix27GLNxuHHmCuh?=
 =?us-ascii?Q?DhOrvkm/Mt7gOlCOA93zkdRik4ZOBMqndhI9GKst4BFdoaU0FhYK8kPTFfmE?=
 =?us-ascii?Q?zAmBaLkh9pZsG6ylpq5BG6TITrD2zbGPleaUGl/YhvSMtRV/2KtqSL0SOX8j?=
 =?us-ascii?Q?Vwox+eOnPhoOAYdcwngL28dts0TEmyV2Hqn31krkQ83X8kik4XgSMtbsuNpb?=
 =?us-ascii?Q?L/PRzPH1O7L9AdWBCFobqbc+ThEfOxi+3v2PXrpAuiHqTZpDsDyC8+49+I9q?=
 =?us-ascii?Q?q9mM70XpwMZGdOAj/D3Na5U1fyi9uy8RU/aqQ2n8pbQw97lN+zNEqAaRyXyb?=
 =?us-ascii?Q?0cERIqKTQUWvk9hvzB6QFVS/1XsVIAsjngraBWuPS+4Uvy7nPpUVd6cGeWxm?=
 =?us-ascii?Q?5/b9oD/4QevCaMdcmf8JgqXZPRh+QUWrBxgikon9ulcIdT0hoIR8jWY3Iyz4?=
 =?us-ascii?Q?MfkZ6tc7nVgovtZiU6FusjGmsXOCm3ez0OFPnByE?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5245e056-7c5e-44c3-b030-08de110f4581
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8461.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 02:04:02.3352 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xoW+8oMbdzC/QtISgd5AzISqAoHqJl1ySOvLKiyWSsDvwdYzKv+cHYFgaOYmsMKZQVtpMJ5SKmHWMNg4OymulQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB11435
X-Mailman-Approved-At: Wed, 22 Oct 2025 09:21:43 +0200
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

Hi Tanmay,

On Tue, Oct 21, 2025 at 01:45:26PM -0700, Tanmay Kathpalia wrote:
>Some boards have SD card connectors where the power rail cannot be switched
>off by the driver. However there are various circumstances when a card
>might be re-initialized, such as after system resume, warm re-boot, or
>error handling. However, a UHS card will continue to use 1.8V signaling
>unless it is power cycled.
>
>If the card has not been power cycled, it may still be using 1.8V
>signaling. According to the SD spec., the Bus Speed Mode (function group 1)
>bits 2 to 4 are zero if the card is initialized at 3.3V signal level. Thus
>they can be used to determine if the card has already switched to 1.8V
>signaling. Detect that situation and try to initialize a UHS-I (1.8V)
>transfer mode.

Actually a power cycle or reset is required to make sure SD card to work
correctly. Some SD cards may work in your case, some SD cards might not work,
without a power cycle or reset.

Thanks,
Peng

>
>Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
