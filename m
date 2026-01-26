Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A826C88E41
	for <u-boot@archiver.kernel.org>; Mon, 26 Jan 2026 02:13:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D4D8B83DFA;
	Mon, 26 Jan 2026 03:13:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="MNXhw4P3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F42483E63; Mon, 26 Jan 2026 03:13:33 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 98E0283CF5
 for <u-boot@lists.denx.de>; Mon, 26 Jan 2026 03:13:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=faqyVE/IeJ8WQ/qw90iZuSBNqkF52Cf8WoGid2vdALluNhgBJrA/OAjpQFLAmv9LKvgVRHVAKBXJPRkX7gyfTVP9EC+6rP2tOXfy01n2tWsKf7sjV+5Mvhk8FTQDOdZE30pDnf1Se4YeTS1DRkzXCEmJTXgz2gD7paLTo9yjoV882tltudJw1SUya+Xcba7gnnCtc60ocf5Y7C0T4Pu7RfNxZdsAfzuFYIqgAHHUCl7+e9uX1iRgGffQ1WRf0DPHxU7ru2ed0kUJu9DOsORweM1j1IycP/G+iHCq/G/E/rBNFrlsG4w86UUiVp8Z3ZcZjNZ2xvDI04ZiNAN8vqy9sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V4nXWzyXCkIRO84izf4fW3/XZG64F3m+gdAQPwjz3lU=;
 b=e9jrrRuXhEUcV3UbCOd6pmZJuO/o8WryO/Drn0+EM8a1JJFPTU1xg3sgUA7/PO18HmK7BVRMS85SX1cSagfLJtO/0M/IS6p0VAbNCkT5IBoAXwBq2emeIqH1ii3NmBXFmoKcucXk38XOg2J5NX8vfQcIKKovAs1i4IUQpL5VerQwbFBlV35SoTzhqetzmrudIUuAoXEXmzgN1Jw3+1PhZ1HCi/BGiKiCQae4DLr0nJ78TJESnOJG8p4rzMU8v/PMGBDnU5jA5CPUsQMaNQ6zDiHjJ/Vx+mEKhJxFbs4qLtInmHTVX9D2SLOzZPaSktJWeeM+4pMIQ7/bPUV5urqbtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V4nXWzyXCkIRO84izf4fW3/XZG64F3m+gdAQPwjz3lU=;
 b=MNXhw4P3wmp/dkX8rsjRlmA0WCDUb4W8z5RDc8crCrGcAVrJO+Mf8WuKgPA+rkecSGe/zxXQWtIhEdFStuLowzwKVSzNIhzFpSiZR+1ceGzFQHd9Y8+ubQAo0e645xkw52LJWaLms68/VZxPgu339lPVSLrbsjhXFkBod3JBAB2sizJFGUG5CVvV3dFoiVutQ+WaljugkopvhP0AV/1HVUVWHIT/OIqLP54wS7xoHfjC+XeQX7eTOn+KQXIDfLlR5t3jgq+cu+cCRUJT7BpqcMEsqqLIOdU6XmgVkrbHZEexf98l0iTX+d0s6CVUUJFwoddoe2Met/C4LsOsqhcxCg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com (2603:10a6:10:2cf::20)
 by AS8PR04MB8328.eurprd04.prod.outlook.com (2603:10a6:20b:3fc::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 02:13:30 +0000
Received: from DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197]) by DB9PR04MB8461.eurprd04.prod.outlook.com
 ([fe80::b1b9:faa9:901b:c197%4]) with mapi id 15.20.9542.010; Mon, 26 Jan 2026
 02:13:30 +0000
Date: Mon, 26 Jan 2026 10:13:27 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Subject: Re: [PATCH v2] armv8: u-boot-spl.lds: Place binman symbols at end of
 binary
Message-ID: <aXbNxxNqePSlVUeq@shlinux89>
References: <20260122172057.3212673-1-jonas@kwiboo.se>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122172057.3212673-1-jonas@kwiboo.se>
X-ClientProxiedBy: SGBP274CA0012.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::24)
 To DB9PR04MB8461.eurprd04.prod.outlook.com
 (2603:10a6:10:2cf::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB8461:EE_|AS8PR04MB8328:EE_
X-MS-Office365-Filtering-Correlation-Id: d85a223c-ee60-4788-4b25-08de5c807fbc
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|366016|1800799024|19092799006|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8h9rCsYRGZ1iAvpD0AIV63ocjX0V/9EaKrpB4MifiIOzJG+d/tVSHTCcLNAQ?=
 =?us-ascii?Q?eMtk/OMr8ame54eMvYrhziF3oQRnAlM4Ekzp6zatxW0K4Rj8ok8i5jMSKMQp?=
 =?us-ascii?Q?PVnFc5sOePFFZcWAFyjrWlsP+bnKkwpFd49NCRu1LtiCNLWbAvVFn/Tg+Ojr?=
 =?us-ascii?Q?MyRbyLJwZlA/pVaD2yvXwrXn+gA+UEXX7s26P3h+0sALmS2fgn4MvJE4h57N?=
 =?us-ascii?Q?hdCLKI+Nkr2/6Yc7es7Q2K7Iv1j3sF9v2/qBY6n6rvglpPW0aBC7xOjOE91k?=
 =?us-ascii?Q?XmDBuy3NIiWzUOx86DdOBbBhRKvf3dxThyTfMSZZbGb+Iky2OKwap6TiXoG9?=
 =?us-ascii?Q?Azno/HELlUJ9Vob4UCTaRisagsuCrRUWkjvFf895k9YIdYelcux4ZJpZttid?=
 =?us-ascii?Q?7kYx0b6q2nmi2h7iAi42xH2ZqcD2aCmfqHbmF7xjIqjYoPopBIMjU2aJAyO4?=
 =?us-ascii?Q?QCqXZMH1gIrWb0hHFA9gy6FDDJc6WE04K57Fe3LTHdNNtHJbWmUPRqcZ6FFm?=
 =?us-ascii?Q?e/3d2dTah/pFc/cpsatb3zfdfxJGL+WSvl1yWg8nTB0VhnbunZviCf4fvOTm?=
 =?us-ascii?Q?9nn2+wt/FqBnAINrb9+LmJxUtaH3oi+WuJCN1CkzlSbPb2fSxx4vDqUPI4LJ?=
 =?us-ascii?Q?B7rAs+UAC1BRI5pnViUo5Ab90rAigsU5CvwA0JwlDRncN/0GKqNZImxdb5PO?=
 =?us-ascii?Q?xrVx+a4xpbw+OWQPXC1WBVFnT1aZ1FQ4B1TkvtULUAmQg0dr3QLjE4FqonCz?=
 =?us-ascii?Q?cb3FCE8lKnn0XdDedSeZPVfmOI5BP/b3r4Ff/GSYip9lspJSbq70GUP+wenh?=
 =?us-ascii?Q?9jOmE7BHUQZNsr3B+Q6LRFNHUMQ80EY9LhvazFqyNVzAtvvZaVkZ621Sfckd?=
 =?us-ascii?Q?mYUBi+eydTWxGcDtJ5o23x7VyWlU301xGgSlifY01L4RiHDgnBsyZ0ZzG1UM?=
 =?us-ascii?Q?oFIPm+2t6RqzE+6Fe+qgZt/eqguNlzAkRSIlHW3McO/GGeiWkrsh7AgrVxwy?=
 =?us-ascii?Q?CiulXvdkImHyGhhzKIqXkSjIH70REhL/TyU08H0JEGNVTJ2vySVNLe4dyiwT?=
 =?us-ascii?Q?uCZ7u7KcS3PUqY3k7G5fvXUG8xXDhXqb3Y8EhA/laQXmJq6k23/b9kgu29AU?=
 =?us-ascii?Q?bxkpYUsGXo7EW6IVVlX2KPNTCyqGfEALudTvbod4GkbX9XXXGLLlsYF596Dq?=
 =?us-ascii?Q?0AOppwrVs7s/M9UqQhbQi++i1WIaorpbDq7ZhExNtnGpLbNWKWmGg/kxnAcE?=
 =?us-ascii?Q?potUfYwKE8GKYa82tNmbhz8dMaJFlUBgCP2YnkJKINongqKqtzC2Dn7v2KdN?=
 =?us-ascii?Q?MExhrYZbr/QqLiO3hf6rM0xfz5S01S24N7JnWGK2Jea3Cj14AY3ETcncu0ql?=
 =?us-ascii?Q?QgQ2LzMtBK7/f976FMyOcq9eMEI2AbPh/pFdDg6ym+v85tCHNvfUT23S4JQJ?=
 =?us-ascii?Q?AwOqSSB3JLbXlD1apFuR0u/7kTctAK7VUJzGRJKO16cPthdWtkJnZWZVLPMP?=
 =?us-ascii?Q?JAZHXM94Dlsa/G9GUVaWbRmfTautr7PWeKFW7oT199yIjb8UIev8OhD6ePqf?=
 =?us-ascii?Q?qNDV3t/IyGhY/Jscnwh6VctEsSLBakz0DRtVUB9h6khw+9fFO+KfJTsNDyom?=
 =?us-ascii?Q?xMocwI/q57XT976nGQr7xE0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR04MB8461.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(366016)(1800799024)(19092799006)(38350700014)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hzptOYbbAa5jDzug8Iua1A3StxnTs0OcgqfoNIHVaXpy+IGJ1MoXgNwnW7j6?=
 =?us-ascii?Q?S7PW4eUCD4pu3aPHSuyxdvxLcONLH0s400SNXOnkRcIx9f/fNaWsxgRAK/bl?=
 =?us-ascii?Q?mu4DXGroox4s89AT+T+VAZGwjYh39t2VroIZSNgrnIZsc1JH/dCOLaLUTCC8?=
 =?us-ascii?Q?nGqHOkBSLuoouH9nVaMuc6i60xEj8e7kWEXcqFCX8TR2nmU6KJ4ID0CU7TX3?=
 =?us-ascii?Q?mwpIXvhCS2mNHOuuuo8MHo3RC20ps9S/Oj8LDJKIYs/fX1O78vWuVuBi6VWy?=
 =?us-ascii?Q?jVGr0yewR6SVF3yK3f6lF3jjXVvuY2UX06j/AbyFHICpw5lveLn1If6dilsJ?=
 =?us-ascii?Q?dCbCoJGhioCM2f66mRHL9doSwKWkuuig1Jj1aV3/awecIDsb8m0zK4inM001?=
 =?us-ascii?Q?q03+kKnIGjgwOxK+Cp6Npi8zJyDJCWOKxEwncPAKwRyR0aaqABOM1wURZqo+?=
 =?us-ascii?Q?0bKTv0D4fQ3jkjjF69/+tlUg/9Gzu5qoqsOWEEkNBUU/b7E+ccaIgf1L6awz?=
 =?us-ascii?Q?aDbn/8Qo0+vtmIOSqmfde2l+WRzrMmxRffR1ZoXHyCnIfMiS9Rua+hs6x+HY?=
 =?us-ascii?Q?Zf9qq7D6bzjXJ2M/tSSffhqLkpcWZEim9R/hif9aoYHgU7f47CHnKTO0WV6y?=
 =?us-ascii?Q?PwN+6r1ihJ8YWy62pAdARvHKNwzXDX7r/T8APy5TPzx10ZFsQEdBh8GnRU+I?=
 =?us-ascii?Q?MnxsVDlHty5SCevPfNOrrbgsvAFtY2iqBbcZpVTXCsq6JiRVPv4pMhzI1d9r?=
 =?us-ascii?Q?NBmn9gt2s0S6PXyQCAJvslXg72mOcQW3HhvtwS9lcYtJBHgWPBiMk7ur74AN?=
 =?us-ascii?Q?UH3FGunjX6fcjyu5XoAwT07zCTPHvKhxmomadfe9dg0ywNuy/S0sdNaV2B3+?=
 =?us-ascii?Q?pTQeG7bLNI1gcOpn4YipwH4AAO7C1MV91dmwCdQim6I193t/VKhQ/rCKEf6N?=
 =?us-ascii?Q?SX/xu0FzvmPMJOj9wQbgsisSSIbb8uroVO0iww9Jjr4LFPBSdvtQkMI8nN0I?=
 =?us-ascii?Q?QR/12y+DyQtlql/90Fm5FZagDW8YRrIMT5aaIodTmhelzPdoOuOLWXNrUQCD?=
 =?us-ascii?Q?MvQEPicdsmB9B4NfODrdSoKDHQ/dUXFQzwm/K6RyQTkZV46bylU3irgq2hPv?=
 =?us-ascii?Q?1GuZrdQ36U1xSBnRF4B5Ip+opHt8jrLUrSoQvphiF2JIUc6piHF7bgwdPrmG?=
 =?us-ascii?Q?lO1kU0SP4suet/8BF9x/dkbrUkmx/SnGUQeGL53Z6IeE3CZ2HV+l7YlTGUOi?=
 =?us-ascii?Q?OP6ziXX8BM6r0Sz3Ws8zIa7aaZQxuNBw5EZAdQNMyQhS7AAsudOF3DsI+I8t?=
 =?us-ascii?Q?RvbzpQMuZExsHn+mbgpVRBzyIhQvkQk9twWB2IBxX3vNJiD8+n3rhtt+gS2e?=
 =?us-ascii?Q?+YiHEjcc7oxhXqgTIoJF28K95LxBZQIU9LEYZwBvSZannrOazF2AvLI1Ik1L?=
 =?us-ascii?Q?ycaRst/CkX24WARBmEIMOsIp0WZAtaBkMitey790cwzOLH1h53BwuBaA87CN?=
 =?us-ascii?Q?z3VZixgbKgqLmsnnV/pLZsH2uwanDFqNChyPJDkpBm5jkeV+p327F4fbje+J?=
 =?us-ascii?Q?caNzQxphZ30O4JWdiFSCg40wJ39t7gZ5T1rWs0pyyMQ1twejMkMh2ZRfMtXz?=
 =?us-ascii?Q?fZceHVbVhaWr2/PfHXZdERL0SfHUFBZCxh8DWEWnb0jHTMHOrFTWUw0DN9qg?=
 =?us-ascii?Q?rvHgttDgvVRjBOAHdBOboAkXrfMlU3l/KKJm2/mP6D5hexfQrMOLDGVadt1U?=
 =?us-ascii?Q?3DGHhvDONQ=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d85a223c-ee60-4788-4b25-08de5c807fbc
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8461.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 02:13:30.6171 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wFkfiTTlXEiSF/oQFG/Mbvm0l8RxX04OJppFISLsn5T9+iqsQbMo84RsO5WfI2b5OxgOXWBEGt0x85FXq6fe0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8328
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

Hi Jonas,
On Thu, Jan 22, 2026 at 05:20:54PM +0000, Jonas Karlman wrote:
>It can be useful in xPL to access symbols from binman, such as the
>offset/position and size of a binman entry.

Would you please disclose more details? What it will be used for?

Thanks,
Peng

>
>Place these binman symbols together at the end of the xPL binary for
>ARMv8, similar to ARM and RISC-V.
>
>Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>---
>v2: Rebase on master after "arm: Update linker scripts to ensure
>    appended device tree is aligned".
>---
> arch/arm/cpu/armv8/u-boot-spl.lds | 8 ++++++++
> 1 file changed, 8 insertions(+)
>
>diff --git a/arch/arm/cpu/armv8/u-boot-spl.lds b/arch/arm/cpu/armv8/u-boot-spl.lds
>index d9963846c4f4..b732133ce76d 100644
>--- a/arch/arm/cpu/armv8/u-boot-spl.lds
>+++ b/arch/arm/cpu/armv8/u-boot-spl.lds
>@@ -55,6 +55,14 @@ SECTIONS
> 		. = ALIGN(8);
> 	} >.sram
> 
>+	.binman_sym_table : {
>+		. = ALIGN(8);
>+		__binman_sym_start = .;
>+		KEEP(*(SORT(.binman_sym*)));
>+		__binman_sym_end = .;
>+		. = ALIGN(8);
>+	} > .sram
>+
> 	__image_copy_end = .;
> 	_end = .;
> 	_image_binary_end = .;
>-- 
>2.52.0
>
