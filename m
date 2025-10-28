Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C16D2CCF9E0
	for <u-boot@archiver.kernel.org>; Tue, 28 Oct 2025 13:11:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC89B838C8;
	Tue, 28 Oct 2025 14:10:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="N3G5PQx6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F7CC83A03; Tue, 28 Oct 2025 11:48:50 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BBDD083A13
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 11:48:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tfIon/LiUyz0P99KbVqWJ3uECE9h85FTdrNR82RfYscIExtR3pBmuhh/qest4fSKd2yP1BAilLKwQ+BQdVdgj6KfLgg/66gZqWCUtuZMg0Hyi+BiRLTW4nFtIudNfgtQZRipmgemPjFCz1GNZpuOy8N/rWFHiyVlhLKwMAHlCpvTTvzpwht9VPsAVTeHEbOY3M7K82zfmfQCGZrh5PjiuYcL0BMvFZfSuGCq2IHExVwmd5WUse1xS4GeAA3alBAhc0ohQ9vHF1lYdoyQXvAlIU9+zVM/mY3xCGQccB0jB7Bn3iSxqexh101LsJ19rDU92vYVS4qC2CuZW178O4frNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CNmr/HMZn1nb6xbLqCY7yLLi2ZjxTGsgiDJ6+nvDTX0=;
 b=hmmPA1HVv4x5iOEi1GOA2YQ3hzjTm0Mv3NSL+RxAZI1tkryO8ehnLqdt2s4GoamgyfaLhlm6FOyuDQom96K56gcQ8mNmGSiiG+1Vst1VVmb2GGJQ3I7qbvE+vntt69VJ2J21OgfPjt8Tw+mY5suVk4j74RYeCKk3gHL3QLz7sXZkmJ3+IP//NKzBgFaTIMnv00BLh5PWc9QuElSCwLbpes9ENFjGauCPwWOxTaTHrINXQfpF2Rs4sKJdn3h3v6eFgadMxfJJMgGogex5CHJZa/+RdrSLgxnMIrPEWUZ3aeoKCEYE1TyygKq9w95OU6KZGwTP2nXJucY3R2D+AExHjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CNmr/HMZn1nb6xbLqCY7yLLi2ZjxTGsgiDJ6+nvDTX0=;
 b=N3G5PQx6ipnbx+HcF4qyj2biXNgdoT+6Is+86c4q+ZNMTnumu5qzuDbSYlxHN3a/SH7pXIctPvwxXzj2LMEM2NUNRe6SmBU0UYjcFz3MNSjlpeIVVuWq1By3nypLgMONLhefSaJMDFqUFE52aFtxu72l6H+Urf7XT8eWLsFV3GYmCgj17Th4rSJuMBLaWMy6HKC+iiHfz+DPGCajA/muqZuhinW+XPYem0LdYeo9hgi5+gJLYezvs2Gq89BsjZtLMaVczmGdXT2Grwq7k1CMCoEndCKchqVDuR6n5I6GPuasOGFj62iA7wrL94n3Y2OpvrGSMAsHU3YN7150Wl86PA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DU4PR04MB10362.eurprd04.prod.outlook.com (2603:10a6:10:563::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Tue, 28 Oct
 2025 10:48:46 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9253.018; Tue, 28 Oct 2025
 10:48:46 +0000
Date: Tue, 28 Oct 2025 20:01:09 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Alice Guo <alice.guo@nxp.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Peng Fan <peng.fan@nxp.com>, Sean Anderson <seanga2@gmail.com>,
 Tom Rini <trini@konsulko.com>, Valentin Caron <valentin.caron@foss.st.com>,
 Vinh Nguyen <vinh.nguyen.xz@renesas.com>
Subject: Re: [PATCH 4/4] clk: scmi: Defer issue of SCMI_CLOCK_ATTRIBUTES
Message-ID: <20251028120109.GE9371@nxa18884-linux.ap.freescale.net>
References: <20251028034225.260469-1-marek.vasut+renesas@mailbox.org>
 <20251028034225.260469-4-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028034225.260469-4-marek.vasut+renesas@mailbox.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: MA5PR01CA0175.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1a9::14) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DU4PR04MB10362:EE_
X-MS-Office365-Filtering-Correlation-Id: 390eb7c7-3ace-4934-55e1-08de160f91ee
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|376014|52116014|1800799024|366016|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GsYfIMkL2AMOQT8QBMPAn0cXwVBFTKGuCS9kgcV1XLL+1xGuOmXWWmzKHJIz?=
 =?us-ascii?Q?MtYH1Xq4EdHMbDH2YPOay025bpCT19mhpgLmUO5GG5bo1m3avOLAEQnVGOU0?=
 =?us-ascii?Q?ZhOAbvwptQIRZcdV7hi3UjX18cstWTVenIAQZUHB0cH3yPqxkINXmhClTwUV?=
 =?us-ascii?Q?yYNdJZEJ4M4qVpfSWmfJUBAAUt7jKpwBR2Kj7o+CQbYZwx3Ce4a73lbZ+xvj?=
 =?us-ascii?Q?uSDEqzxUKAJXn8nOod0WfuMbxLBLEkF1gGDIGg4K8yTYM2FTrn9jUHqSDyto?=
 =?us-ascii?Q?AJ9R6hkdYo+CHuc59CpY5vuxM7lbWANrJmlv9FNaRhVGlxncelucwRDwnSBr?=
 =?us-ascii?Q?E9IOmrVcpQ8aCdUeOddSbOZQABer5hlN0yHXh2ZGIzp0x4lte69GzTU5wXxW?=
 =?us-ascii?Q?3sSakV42UT1+79f/Sp7D5wrSpNNOGnWjeBz5mfJCa1k1nC0xcW1ivvMgCMky?=
 =?us-ascii?Q?vAZ9Sp5QKiVxmZPKxpSv9u/8x4vBmA3bXqw0GtDEG/FDdmyon234TIjVoZJ6?=
 =?us-ascii?Q?AadIUi82ofmSiC+10/Xh2njiaR4CnnUqFowlKB92GVfm0oY0ZGrFfMFJwIP4?=
 =?us-ascii?Q?Ly1ACbviNT8OEJfjBAjuFIXJnrdMUi8w1CUtfqNO9Do9WJNImPXE9Kn/wGKx?=
 =?us-ascii?Q?rmM5kBccLoaCR+QTe8C8wfrbaLI8leCs0n4wf5OiU/V/tVesOv0Y8pTQR0Sg?=
 =?us-ascii?Q?TXzeJuZP0JiXN9lzTvkvnLopCa0pO7U8PplMVcHpcxJZrZZ7HgqKWFdrpYow?=
 =?us-ascii?Q?nViFku03BmjAnQY3sCtaegHxVdsFD/RYOvWfZEM6le1cA1UocDhdQDq5r3sG?=
 =?us-ascii?Q?DGQrN/8WuE9Sde4FIFirOiYLNdoJ80fl/dNNzBf1Jtp0Wi3xlI0hG7ZDdmd5?=
 =?us-ascii?Q?UkV5ll/Jk4mBl7ZcZcVGwF00kX4gYXJCIsJaqqTYtyG2TFotarVhqZ3zV3WG?=
 =?us-ascii?Q?P9Ue3m5C4ZD7ZbRldh0hOh0iFRqUXYwpeGhwCKRlry7sGbnrIU5gns1F3yMT?=
 =?us-ascii?Q?PafhqqxoEalHUkr3hvL4Vl9Wtqr0jkqtCVO+Vvbyugo9SIdJtPufb0OFyTgU?=
 =?us-ascii?Q?tnoB6yzRRWxBnHLayLdltPfpoJbi7WtrSStploGHAHRZ72o6Zj5u3oHX+syH?=
 =?us-ascii?Q?2sL/AL92tskeanuyYeK36Wl14jBd1QDIKBawhY0KJS2fxrqXEvkbXFflJbq2?=
 =?us-ascii?Q?uMJN4Kw5SkA4/tGtGmlf/tUz1QPbwjNkmeIJsuqjyvF9qshfttSU9IhKZBB+?=
 =?us-ascii?Q?4bU4OOwlbQRdWEHb68R3zH90GeCSB1hpvfP0N7g5RFVY8qX/6W3hV5qyFmEv?=
 =?us-ascii?Q?IE0FZLcXQHbgajWkIsOjtGwoPp/JQfRYpYP3pvbjqZiL8p8JQIxD3CGu5w9l?=
 =?us-ascii?Q?KEhUhpjb0NTE0ynIu6RVL4Kc6iVWCCd/ZfiFU5CiqYD/+yZohn1dVF4H62KR?=
 =?us-ascii?Q?AJmezMdC68tUxWU+ribZdP8nB2Zfb/wF1vNXsy3LVkNxY+1Hj0cmz3Ac7TKo?=
 =?us-ascii?Q?vBuu4MFwPA8/DArCGiUHaybB0zrVkvyAABDX?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(376014)(52116014)(1800799024)(366016)(38350700014)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PyxsAVmozoVQvzDokQlwEReHNoGW8eA0zTCbovKFVlCu4/lD1zp8O31BsPg5?=
 =?us-ascii?Q?WVUrE0csRqY2PydrAvGDo90s+WZIPCkcSvUT1kkbMw3FQR3FCnC2UEWcsjRA?=
 =?us-ascii?Q?5Uj01d8SorRhC+Z0Frxs7se2YhbB0d/ho0XiOdrA7Gy2JPLlLOIpeyCvqXmO?=
 =?us-ascii?Q?NnTLeh8jnzyfJA6NI0Btpg0F8wK8Qc5eX5apJ2Rnb4axpJBkD9KaXsZgoKoB?=
 =?us-ascii?Q?RT2KMZGzXpuzTbCVxcTANi9lLQJMAypyz3WS/xQwIHFqJTPAzVnjVBO3+udh?=
 =?us-ascii?Q?TtdYlEOS7ztfPDm0E5gpP1YCePbxTElZ8AXA6SBHUshoFaXfv3TOOOnStFSY?=
 =?us-ascii?Q?gAnI6SizDQL2jZthDgXnh5wCvwBrXqeuCtU/al9DtFCrkLXA9lO95g+p7SQw?=
 =?us-ascii?Q?0PwSxRovQPgCb6rft7CWQCToMnPZe9QGLmSoY6MKb87EBcSIyaLo0ht4ky8o?=
 =?us-ascii?Q?Rv3Yw9LMHYlht6n6GRaI6JJejeaK80rufpuIRfA5+P/kMyiRjLeLAqznCOm+?=
 =?us-ascii?Q?LwstbMnYozTr5h/qHydp1OQFBqQdbBO8ZPqDDVYxOYs4Oh0kxHt8Gq0uSHsI?=
 =?us-ascii?Q?EN9V3fytNroml/KfPTaTj5t423ceK/E5P03tyMsTNoOoP4tMmFdzn4LjRvn+?=
 =?us-ascii?Q?5Hw1GKyy6X99TDxis9qRrdQ8oHkAFvr5Gyd9jq4sq+o5ZYg8k86nEcGuMf11?=
 =?us-ascii?Q?zi+CGcsmbN57D9rMDqppO+1rbdvgL2D1YQyH86bnhW5EhYy3eYGSMJH1NmHL?=
 =?us-ascii?Q?cJbpEQziC4kyHP1OGZK9vKDvnVe6mqX6HaG11HEiu+wYxRGu8AoL7FX0NjnT?=
 =?us-ascii?Q?Hi/ykCgj9K9q6Hxp5q7x8XqS0zEis5dkcyUmBCiJzAvwsyTL4J6aqhUe4XRL?=
 =?us-ascii?Q?E7VnQAGOwjvsVwdYHOecL4EXUdiCW5rhzsLlPEOkNbnfvNDS4BVQATkRe0h+?=
 =?us-ascii?Q?fPaLbGYnSLQcV2rH82ipem2smDRClBkpEF6ac/tqUebYSpiTph5o1p4Wx0CZ?=
 =?us-ascii?Q?AaMO9sKNVc9rgWpZypVBIdnkoL+bHhhIOAVzwcrEXUrWrGvcyXkrHmoRRt8P?=
 =?us-ascii?Q?zr6o5yQa0u0nqB0byZdjT4GOhPjSXu7oBARDvlI8ewiMPDhyqBA+yRGBtAx/?=
 =?us-ascii?Q?g/QfHXJ7nG6SikridOw0DYbZcQtiUZX07UQGe3/5mw2SYc4PIeeFUcHm/SaZ?=
 =?us-ascii?Q?rZGFGu+2YzKExxQB+RxagvLb/IX/AL5JQ7L3NdRk7RPrxbLOrZd1khD88KwR?=
 =?us-ascii?Q?5uMpkI5DHnHeAiag4fgjENii+1CptlKo3gvsyFNtFYMn8WYgpuaK5Y5qdITo?=
 =?us-ascii?Q?PMjODY/po+tnKtg6/K4lfKQpWBMb2QVeuAhNDiPNysAvb9bvK+ny1r7ISP03?=
 =?us-ascii?Q?IFs2f3DsigE4UHwp8XNLQF9MnMubQFtOpP4CgDg3/6NDbU/IpUb/DU3NbDCD?=
 =?us-ascii?Q?nLVpHjQmCz6jlCtBQfGA+7f3g0XV3KlejR9L8wHHSj/H+CcDVES7e016sVqa?=
 =?us-ascii?Q?Q2JesEdYc1g1Xes979tZRKoENtsKYRO0V3VejPknPFJpfBD93fvlvSXNwWb0?=
 =?us-ascii?Q?pdbr1OsIyn7BhegY1DPc/qQqkI3KtdiVXPR7Jf91?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 390eb7c7-3ace-4934-55e1-08de160f91ee
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 10:48:46.3913 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y8SaTw+GUZYuKMkGGlHVhG9/p0xgnnEKajCozO4OGrh2PSRvHnI8cNknuwNQfWMCIR/M1FX4KaOFFZb5k6PFEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10362
X-Mailman-Approved-At: Tue, 28 Oct 2025 14:10:51 +0100
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

On Tue, Oct 28, 2025 at 04:41:06AM +0100, Marek Vasut wrote:
>Instead of resolving clock control flags using SCMI_CLOCK_ATTRIBUTES
>during probe for each and every clock, resolve the clock control
>flags using SCMI_CLOCK_ATTRIBUTES when the clock control flags are
>first used. Because most clock are never used by U-Boot, this allows
>reducing the amount of SCMI_CLOCK_ATTRIBUTES considerably, and this
>improve probe time of the scmi clock driver and U-Boot start up time.
>
>On Renesas X5H, with 1700+ SCMI clock, the boot time improved by 1.7s .
>
>Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Reviewed-by: Peng Fan <peng.fan@nxp.com>
