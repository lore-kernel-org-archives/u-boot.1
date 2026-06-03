Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BF32CD6E6C
	for <u-boot@archiver.kernel.org>; Wed,  3 Jun 2026 10:48:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 10F978469D;
	Wed,  3 Jun 2026 12:48:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="jSMN+Ub0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B420C83FF5; Wed,  3 Jun 2026 12:48:56 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4BE98056B
 for <u-boot@lists.denx.de>; Wed,  3 Jun 2026 12:48:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H2G8Auo70uvJmSOh7cm6BPiMUisF9MYz7NOK5IznpHPC4YXmWVTsqJTxTMfaRK9hjq4HFiHhWb7YzrABikBT26H3Um5JtELHnpw1IpYTigMaHfhi+z4ylaHGl4GaHR5WRw0EUEsDHXLkLsePgjIM7UD84XaNu2L+icTu2w+BBt3t/CP6XjF34zA8/R01NT8gkKOk5KbWyjpHnSezI1dC+g0nuu26NfX14a5EVlTNOzwQlsTGePdvTT0KYUm/YemgFzuUVJDPe4xg6m4wXF2sqaNLmp2ADgcyCkZR4vOqlPShK+SNEc9ADTXQ+3Z9/+jQtHFSLirFOmKYXe/eL/TPJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aN+IA9JCJBgsS+Hr8YcTn1NdHf94DYIx2pBHttE3PHo=;
 b=s40fxLKo62SKmq7+Rdub508mARcHygJQXrjyx16fjCpoz7yKs9Whe0tBSOCOQhaGYPXe+cdTwUIoWZMbUfuCEL3fwAstidj7hRt14+TWaCuYGkngP8lexMTOVtjRn9ClZYbTa+zLV2qITlBIsAkC0FueF2yvhYK5d1jCj07ajLoISaUE4QihMgKjw0/HSKkDpYSTdPXNFthLczusnj4SHKIjneX0HD/rnRs7Oot2+Pm6XTE+ujh+uQQe64X1b5XuvI4EndMhBC4+JGsGLpcKGXBmlgGQRx8o07pAbcB9vbDfj+dOteMYpBJs3ZBZcumzKTe9+de8epfaKAKN02oW+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aN+IA9JCJBgsS+Hr8YcTn1NdHf94DYIx2pBHttE3PHo=;
 b=jSMN+Ub09fcseEHo2UeMPWLY2pvg7jhEgOGjL/Z/fJnQ9sAFAgWmpd+OOqJ8Vi6HQfi2Td8OKAgJv//NMgeSTSATr3iPd8KEU4ekWcJCLctKtsfKS6Lp0ZM7xiu1Fx8elUY8i+4F9Mp3+mmyG1xF75fr4huDAm2uCtCMG4q8v2frd+61IjBb4FFl33aL+DCZXU+lrQGkxpUP8PlFw2DxJPOd9TeuapGKY+75LQqN+R3hXvqj7lSfbTyRRRBr7+5bQG8BhAwyeh2qumDMXimqPDPzuF44jjgq2XhnmnogI8DgnTgAMu3R0TQmH92t0PVkrXDJy5zZLeBP+3eFPLQAJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by VI2PR04MB10267.eurprd04.prod.outlook.com (2603:10a6:800:225::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 10:48:52 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::cf3:c5b0:7a0c:d11b%4]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 10:48:51 +0000
From: alice.guo@oss.nxp.com
Subject: [PATCH 0/3] net: fsl_enetc: Add SGMII 1G for i.MX95
Date: Wed, 03 Jun 2026 18:51:49 +0800
Message-Id: <20260603-sgmii-v1-0-c4a0af0d5d3d@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEUHIGoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDMwNj3eL03MxMXVNzkzRTU/NkE0MDcyWg2oKi1LTMCrA50UplhkqxELH
 i0qSs1OQSkAFKtbUAIPznRW0AAAA=
X-Change-ID: 20260603-sgmii-574f557c4107
To: u-boot@lists.denx.de
Cc: Jerome Forissier <jerome.forissier@arm.com>, 
 Tom Rini <trini@konsulko.com>, Ye Li <ye.li@nxp.com>, 
 Marek Vasut <marex@nabladev.com>, Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: SI1PR02CA0028.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::6) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|VI2PR04MB10267:EE_
X-MS-Office365-Filtering-Correlation-Id: 99d72b3c-6439-4b41-0747-08dec15db328
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|366016|1800799024|52116014|376014|38350700014|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: szT8BcDdRnuxaKZLts/UoSoBq9+pFOIGJvv2isK5+e/q/iTpwIUv9XLJe/HqZ0+96WubpssWW05gsBacwgJ6V+1bdvgJ9CQgnp8cnHjL7aUZhr1rKpGzUCjUc9hNUG4OPiADV/OmjbWrvyMZuR59VP3IOkQN+SvKvrRc4BMfkjR3TBfCJ+xc/Gnq5bWGVwpIVbBKZDZ9dKIMkXrABIgcmRn/MQBRum4e0hFgOm6Ag7olBBiySWOZLY6FY5OTE3/B8AROgMu12xigAv3kwU3c/JCuciGKjdcxgQggHVIPOdPG6xnMsAlDjpWzR+G7ASTSONd6Bodj8JVFKAqR4PnyKk4OVRuYIhFW/H8AABk9dD5iKixg3XjGjB1XDgC+7lWCfPj83aWp0gUQZSmfVYgVUhXelBPTw/A2y/67gtWoorCJ3EfoU3V7gARqZAW1rFDXnFK10Pt9XG7WjxsSBDuvazvouXqT9dZEUlN9FwqdPaPBKqVhyJCkVpwX/DJ5udlMXhTGOdNrZlh6tdSq/1RGv294GKutj6zkXFSgPU9kHaRFIQvGxHvKRNAxUa9e6JaBUKLmahfpsCquxTO2OCj/1ykU10pDGi84xRC6r9NQQHY3boIcyQ8cyYjmUpWAOndgSKD7SL3t/TRKy5wUb79PTD0AvRzJLqiO36JbR0vS+3tQZjcp/AO+Z3kIoSpbyVkYMDnldRZnFMhxQJkOaN2b21QT0he85bHpe9nlEFWGwvoxq6IxSkdk5y/WNZ7U/9vw
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(1800799024)(52116014)(376014)(38350700014)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VnZ6dXVDZGNWQ0xOc0xEaFk5OFN2a2tlbGYrTm93UXVMVVhIOGcvUFRNZDlm?=
 =?utf-8?B?SkFCZk9CblpLbndFWThpd0NQWkIxTWk0ZEtWMExPU0pJVTcwWDFQWGUvUmo1?=
 =?utf-8?B?ZFhiTGhhTEFWcDZvTk50YmdtZ3plYTFjc2d5N0Rnamg0Q2R6QkZnVno1T2U3?=
 =?utf-8?B?RXhlY3dzaHRodEdrOVNSSTN1NXlGUGY5L2pXRVA4VUFDdUROZjZOejl2c01C?=
 =?utf-8?B?cEtZb2Z2L3RXVndwYWVzZ0JmRFBBdjJZTGVPbFhZM0k4Qno2ZWxIQktaaGN6?=
 =?utf-8?B?ZGRUVFJucE1xWjZ2bGtFRUJXZ2pEUE94b0ppR2tEQmJzMTBWbUV6VW5xOVhs?=
 =?utf-8?B?Tmw2T1FSK09scXhlNTFnZ0JxeklGVTRJaVBwenBINzFpZk0zVjJ1REQ2TzNN?=
 =?utf-8?B?L0lLYWtpVkNXU093ZERqMC95QWFpdXVMdGlYR3VNclEwcUZyb1dDZG8veE81?=
 =?utf-8?B?V01KMHZNcERnQjFrd3g5MTFjMlhsaWJmWm1UckhpM2tGUHczNzZQNzhCQ0lV?=
 =?utf-8?B?Y0tubm1Hekc0L2l3VmErZGhvdFBrZllUdVh6ZlFFKy9JdGluVTRTQ09uYStv?=
 =?utf-8?B?YjdlU21qeW5oOEd4SUNHS3cwZWhYZ2hScDd4UVNiako2N00vK0xoMTB4T0Vs?=
 =?utf-8?B?VmdKTzVFemVDZTRkb3c3WnJpRmlweUtKV1B2S0NpYVNndmpQa2hXcUJEWCtX?=
 =?utf-8?B?cTVITjVrWGIxYVBEQnE2QXdZalRoQkFkMmllWXZ2T1ZKR3Iyd0RveGxnNkth?=
 =?utf-8?B?dkRBclhnV1dhM3MxN0lmaHdEMGN5Yk9zbEdZR0ZUS0F6YjJsZUpmdGc1SzdX?=
 =?utf-8?B?MmgreWlEREhiekJXUjZVRnAyMGVWem52ajE3Z2E2RHc3UTVHQkZXTWZYdTA0?=
 =?utf-8?B?RU8xdDdVVkNjSXBPV25pZFYzK2FtVnFZNWovQlNpc0ZLT1k0VXJsbzRVSURw?=
 =?utf-8?B?QysySGJZNm8wVGxTTDM5Z2RyY1hHQkc0YnNBaU1PcjZJYlMyRUdDc0Z1d2Fn?=
 =?utf-8?B?Y2o5MFUyTjRKWGJ2UkllWlhpUm5ESC9ydVpncmcvb2VSUzh2YWovVzJWeU9J?=
 =?utf-8?B?cTA5WkdkWUtoaGVkSk9Qb0dvaytrZ2I3NHRIYkVPdU1TS3oyRkhockQ2eS95?=
 =?utf-8?B?Y245UTkzMityV2w2bUJNdXhDS2YzaktoTXNRR3ZRaCtoUUVDZitOdU5makxB?=
 =?utf-8?B?QXJqTGhCekNtT3JUeDhSUDRHU3lUazQrZ2Fib3pVSnZNajdGYWNZby9nNEpQ?=
 =?utf-8?B?Ylk3RzYrR2l6dnhiRFdrR0w1UVgxY1Y5Z0dpdXMzbUpTbDVQZG9qWHNkZ09Y?=
 =?utf-8?B?Uzd6Q01IRS9Hd0s5cTh1STNOanlsK0JsUXdIbEcvUGtzVHM4WkhwaXZGb0pK?=
 =?utf-8?B?UitNRVRLL0lOY0x2T0NsVThBaURsN0x4dGJ6Uk05YkNKTk95c0M4Mnl2UTFD?=
 =?utf-8?B?WWI4SENjb214cjhoOUFubUo5NHpmK1JTN2NrTG1kQkkrUnlId2E0QlUydi9G?=
 =?utf-8?B?SFhueUNzWjN6UVpJNitjKzhodnZ0ZVA4UTNFd2plK2tHQkROZ1FXbEFxRDVD?=
 =?utf-8?B?R291N21MbXJ1bUpvWFpMM3QxeFNHZnI2WTlLcWhnV3JSVk0xeitCOG56MXlQ?=
 =?utf-8?B?VlM4L2tuN05EdVNSdkdEbEhWN2FIdFBsM1VVQm9RMC9ka09CeGR0UkhZU3I3?=
 =?utf-8?B?WXZiaFpmam9FUlp1cE13M3VHaU5HdEdKUTZOWGxqK1JSeGVYMEpZK1dSQ25X?=
 =?utf-8?B?UmRZU0c0dGFNcFJ5ZU0xditvaU5SbnFWVyt6ZkpXeVpudDhjaW5pU3Bha2JC?=
 =?utf-8?B?Tjh5Rkh0MG1DczA5RlF1dE9Vd2NvRUg2bDJ5S3ZreS9DMWZQUmdObXMxRjQr?=
 =?utf-8?B?ZW1Velc0enQvQ1pFVTNSMlFVZWtJUnJ6Vk0zeUEraExGbXk0Ymc1azcrU3h3?=
 =?utf-8?B?Y0Vpa3IzV25qYzI2bDlzNmVsczBaMG5XMWVhZ21JYzd4TEdFb2QrNVhCWE1n?=
 =?utf-8?B?OGV5MWhaOU1TZko3U0x6czgvbW1sQkxjZmxNT1F5SGFZYmtiSit3bHkvalpY?=
 =?utf-8?B?bUFLTThZL0FJZXVnVW1zbnp3SDc2QmNvaGo0dmRWZ2NFZ3dpUnUxVjY5VXpy?=
 =?utf-8?B?Qnp5VStIbnRNSkgzUUdEemovWGxFbmVudG02NUhtTVh1aSt6RXFhUHo4NDVI?=
 =?utf-8?B?L1NKV1oxZEhSVU1KOHI3eldBVVRLWXBSb3hPcGQrVU5sK2JMTWh3UzF3Rksw?=
 =?utf-8?B?dENkMDVYeGtEcVZGb0NKY3FVN0c5V050ek10TXR0YWVDMWJwdjU1bERIRUtC?=
 =?utf-8?B?MzRwc2pxd1JEaXpEMmhNelMydGx3NG9yY3ZQMVlqUzdEWVRlbjRCdz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99d72b3c-6439-4b41-0747-08dec15db328
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 10:48:51.7582 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zI+/QwephNmkam54h68+x7NFtWFB1OdeX4kAck2bJQo+3sNgycl+/ZDk9mquHyAE5vuqNTvzjZeAG17BHH0Lww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10267
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

This patch adds SGMII interface mode support for the i.MX95 platform.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
Alice Guo (3):
      net: fsl_enetc_xpcs_phy: Extract common PMA MMD init sequence into helper function
      net: fsl_enetc_xpcs_phy: Add SGMII 1G support for i.MX95 XPCS
      net: fsl_enetc: Add SGMII support for i.MX95

 drivers/net/fsl_enetc.c          |  10 +
 drivers/net/fsl_enetc.h          |   1 +
 drivers/net/fsl_enetc_xpcs_phy.c | 693 +++++++++++++++++++++++++++++++++++----
 3 files changed, 641 insertions(+), 63 deletions(-)
---
base-commit: 30b77f6aa146c96b831cb4ece038130b655b6a41
change-id: 20260603-sgmii-574f557c4107

Best regards,
--  
Alice Guo <alice.guo@nxp.com>

