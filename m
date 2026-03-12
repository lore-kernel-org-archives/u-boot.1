Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEC24105A58C
	for <u-boot@archiver.kernel.org>; Thu, 12 Mar 2026 11:35:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 224158416C;
	Thu, 12 Mar 2026 12:35:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="DDFiHqn9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 301B883F53; Thu, 12 Mar 2026 12:35:19 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E88B8416C
 for <u-boot@lists.denx.de>; Thu, 12 Mar 2026 12:35:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=simona.toaca@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pw32aJrN7HFxE8ob/BYEwGARQRc0Ua/9Sg7aZHqTQjEM1r8EML6jvxMWMBIThtHh8XRRGt+O40oOVqWwj/ubvM6GoFJIyuoLsG6GVuTFpi0lPRn+C134XHdpbpkq9HHUl7hVThgsB3O6SPMtOFp8sfbL0XyCegDN3O4DZ8SbPGvIOtEZOLnv5S/aGotjtX2H0gjH59x54h602oTZjobgSlpU+QY0lHCtEI9Jg/YYBfhS/SqnqUjsaW3pciigRkhCVbsxEZhefXAdSmDJQUxilOQvzd6j6phQPO6msrj6JKlXH/QF+rzc11uxC7deJjHuPyzS/AW5g+D3bDMEnHs8Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FlDcCnlmSdg3kjRhTRE6T10u6KYDtb7WPvWYT2miHGc=;
 b=GDmN5KjcS89FVtr4wZMSeLt03ggle0XyTvbof4aiCHn1SA0UhOmxCX85FyhB5KdvumUT4/GLPbArRGhkXJn65HBkJI1Bm3ZExmoy4qpSWGeIua8taVLrJzHzYT7/P4SbCrJ1VLOjAD0q1hcrmiKNiLpAT7rwlHP2ndI4yVH0u+2CZsNGAyehGSm87FuNQx/Ci0riHi8fH0u8NG/oqXMYl7hSvSAUMJm1q9pPI+fybPvCeUCPKSReF3sDgJkS3AK8JM8CtZww1t742MqimnLLr7nDG7wDiTf8sLy5znn1LG3+v1FNc3JTEWazT5WiLcap6PhRFuRbMcb1lbyQw/i6Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FlDcCnlmSdg3kjRhTRE6T10u6KYDtb7WPvWYT2miHGc=;
 b=DDFiHqn9sngMSi6K0LMdlFBBsUsVLAmDlwFV8Iqdm9GFNSoqnRTX2hycZ/2t67zVPkU8m+RriSngZpINHiYyQeDM7SaNscTgbVYpkI/IhhtwlnUuCHhZByytFoIWXxdNNVf8wKaxepJOukDA0NYpRbcwjnL8H9oY4vhjozqrOxYE6WyPhd9xDJMvrLftzRUCN/Z9XU1M66JYG6wkdYd3lnDCFp3CWGQ/BqjVrRILbfUeuAcr2uzqB+GWkPiDAzdQj4k058yyXYCz6RxFjliAgS55rf5J3d4jc/Ax1R0OyJN/Mxx6SArw7E8ncY5kq4YkmkNah/LW/EONuk4vTIJ+FQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI0PR04MB11917.eurprd04.prod.outlook.com (2603:10a6:800:306::9)
 by AMDPR04MB11651.eurprd04.prod.outlook.com (2603:10a6:20b:71c::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Thu, 12 Mar
 2026 11:35:06 +0000
Received: from VI0PR04MB11917.eurprd04.prod.outlook.com
 ([fe80::a506:3460:d2bc:26e7]) by VI0PR04MB11917.eurprd04.prod.outlook.com
 ([fe80::a506:3460:d2bc:26e7%4]) with mapi id 15.20.9700.010; Thu, 12 Mar 2026
 11:35:04 +0000
Date: Thu, 12 Mar 2026 13:47:01 +0200
From: Simona Toaca <simona.toaca@oss.nxp.com>
To: Marek Vasut <marex@nabladev.com>
Cc: uboot-imx@nxp.com, u-boot@lists.denx.de, 
 Stefano Babic <sbabic@nabladev.com>, festevam@gmail.com, peng.fan@nxp.com,
 alice.guo@nxp.com, 
 ye.li@nxp.com, simona.toaca@nxp.com, viorel.suman@nxp.com, ravi@prevas.dk, 
 fedor.ross@ifm.com, sebastien.szymanski@armadeus.com,
 joao.goncalves@toradex.com, 
 ji.luo@nxp.com, semen.protsenko@linaro.org, sjg@chromium.org, 
 tharvey@gateworks.com, ping.bai@nxp.com, qijian.guo@nxp.com
Subject: Re: [PATCH 0/5] imx9{4,5}: Add Quickboot support
Message-ID: <7y5vmmpzrerguaswwwusw4bl2rfzadlxgwnwovmk3hqfuszzcp@yebfnc4sipsj>
References: <cover.1773137310.git.simona.toaca@nxp.com>
 <d1f9c66c-fedb-4802-94b0-3b043e0b8bbd@nabladev.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1f9c66c-fedb-4802-94b0-3b043e0b8bbd@nabladev.com>
X-ClientProxiedBy: AM8P251CA0006.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:21b::11) To VI0PR04MB11917.eurprd04.prod.outlook.com
 (2603:10a6:800:306::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR04MB11917:EE_|AMDPR04MB11651:EE_
X-MS-Office365-Filtering-Correlation-Id: 747fb799-4fe2-47e7-0659-08de802b673b
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|376014|7416014|366016|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: aQAAZ39RBhBo0KH27zb3EEjHKMKmAbkGkzsdyptmkeRTboXTy8S8RM/N062kPorSx+hfWhHrCf3LAPncPXuljodozADRyJJO+RAW9h/UDy4tOB9cPEWwm2kkSAz9qkEjuSDyufugAZ75D9/p7bGxLIGXQPP75cLNTdiEySOVVjddaDOdiAqTHhdFUDKlcgZEhvxkptC2V9eTXuiJvLMLccKJ7MaK7m2Z3pm8/sIAxB4JTDb9POKOOm6Xd4sltw4/HRYZz2MUxqMf8rDa9RELvcVWGfOPTe8wgnpPR4CkrXFTSuNLIsvcFBchnoQSkC/oD+vUw8OtktcpPCaxye13HL3WAcdCuRGwdVug08jmTq3H670KuYgyXfFdel3qmBOKy+9c4ClWCSL/wS2drHEQMoWWSujpND/VWk7u+EdXFOlcVvI8J3HkuWxErBplhPPnfkM/NvknASMT7i/29VHIwKGexOxyxZK4Ycf+8M1+D8PvwmzmmpKWXWhmFTiRu3Z4RDUnaJWQQxZ4UjyQig1S0yRELvONZe32HrG+6VChtsX/R3yvi5hSbEQx7s/TP02ezQVa0oiGM3RBzuQPhD3KeEpq7jU/8RUDxjG/5EU42ZBeUSwASUvwcfozHrDxW0epiEHIL26E3Er6lQFIW3Mys0n1vqiU0zj9GRGDy90EDuK1Qv1Yd9DGCaFpkRVkOfgOhsN3J7hvvLUZGzixDrwTDHsDzlo0qdfjK9a4kfQFRu4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR04MB11917.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(376014)(7416014)(366016)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qCYwxQLAiaFEqJcIbdryFgxOVAcLLl174ZEy6BRuZ8iAvl+YGLfiV3GiXmU5?=
 =?us-ascii?Q?hjm0q4W8hrIbHEJuK4S2Hh01LkUB1LxmJAeb20xWcPgH9LYvtYSFzzCKz/N4?=
 =?us-ascii?Q?QoEUSFmAMRiRnasZsC3wYSRArLJDEcCsL3B488v9Y3Ui2ls5wF6FiE77R6mv?=
 =?us-ascii?Q?fydfrMrDanwQD7E+j59mVISgRVikJ67/StrJ9ZZX0ODvBSelyhz1hi7YFUzk?=
 =?us-ascii?Q?OEU7GlBQmD8C6R8TrF0QG/FaSoPjLXpTZvKSuBbjzjwdA2tfjHY9fkm/zIn6?=
 =?us-ascii?Q?2LyNvDkFuEwYMBwTz+mlVWvS9ChC5YGrnWqBE8V+KHagjLh/VUCDI2hwklKf?=
 =?us-ascii?Q?1FhnhXlxnFPLi2g19aJFhs7edQYEZ2Freux6cPqOMhAD3RF2Ga328mHUaDy5?=
 =?us-ascii?Q?Ed9O3XFPdX7iyxmWdPkicQe70Js9TfCk44TwShYOv05NK9SnrMHl2La2kbpM?=
 =?us-ascii?Q?98oGFWU5xG2Ewx1rpXIbbFNWadBIZS/v+6kfBiUvgzoItFQb7jNnVDUyovEK?=
 =?us-ascii?Q?SxNVKGSZlUtmPAVE2hKSDf6NThs/DLlg7CbmklAE+iXdHUeuPcC0fmYH8U8R?=
 =?us-ascii?Q?wZE0m0dAIiKvCJI8G4+EYKBLs6KkXfddwL8hlX2ydrFO0ebB+Il0NbYnmbEc?=
 =?us-ascii?Q?5f5Mh0iAhf/IQNMKbT3sXPdk71GjLI2sc7lw+K3MBkxS+pImoxoaDWkXcaKJ?=
 =?us-ascii?Q?Sl1gIR9+5XT5S1SZf8x11F3t/qlGPTQkE7m7zgcaiEQpgw74BQfGu+PPaFdC?=
 =?us-ascii?Q?2wxhBJ96LO1hxKMbza62pUw+NlHm+c/R0VAzbDxIgvGXStY+2F///CSO6qFn?=
 =?us-ascii?Q?w32kj9wR8lUn/sQYhgGL3OU0xKe7dhLLtXjtt0AeG2oXaRiAZdfP7sb0Qbr4?=
 =?us-ascii?Q?nssNREwcT+FR3eWEZ50EGYu1CXr9XJdSND7uEAD2aS6cdwIrDt/UuBo0Tn9e?=
 =?us-ascii?Q?w5VkcfRPrmzx5y9wyCHxvZ719gWclvXF8i0+GHo3uLlovaZ0xqOhgqOL7fMP?=
 =?us-ascii?Q?4IofSl47obpzTxvLpJq5g04ALGhYnfZQy8+xKc5MSZ6Pbtj4ROb5x9ZfdMDI?=
 =?us-ascii?Q?xwHvAfr6paPA1Uxyv4MA53oNlITSe3/e1U4qfnjPgkwSOmuFUfRH353j9jKg?=
 =?us-ascii?Q?LuF9Wf1o6AUY+8uoPB6EceYeXhSgNkqnJw2Q4FGAnq/OIX7z67RzGclUntDc?=
 =?us-ascii?Q?DWdOqm2s0tLzJ7suaQx2ufGGjK3YG7TyV/KfyCr5Ts1R7GsLgu1ZXww4EiT7?=
 =?us-ascii?Q?xQCVbeyiSHPf2jI2l81+ve8Bp8kteM1kmmNrxJC7LlUB7KCCZjSSspBrR6QG?=
 =?us-ascii?Q?cfmL2frUWde0sV+OJ80NqAEp6C+qT4io7RIHC8B95DxDPTK0TAG62kKt97g5?=
 =?us-ascii?Q?fFfi0PCoD+Nwx69hixMvVT46iYVL4skq7iYuFIH0uZJv8WhX7lUf71VA93Su?=
 =?us-ascii?Q?wF8UdZsesk66pDDYiD16WTeBWhoCLSe/AoiFI+ciOaly9z17OVNEH6C9GYqn?=
 =?us-ascii?Q?MTEdTlM4xTNVHsx//AUFKz3NtSlT6gHZVFO82tAmpzrt700sSQ7qblMeA1Px?=
 =?us-ascii?Q?WSa2YfBKvwmf88dnBvbtOq2f64nop7ILaoAuut1cjEokfWy9Uud39vXyKHb6?=
 =?us-ascii?Q?rXZZlN2IEnVIrNAvRVzv0gvazHZR7FvYpK4HKVde5n7+BrfRpjyVY0praajJ?=
 =?us-ascii?Q?+2SYm9jEpclsaxJDM3Zu64HyiddeCRXHpdk0+nGRzV7Tq1QjQtD4k/wA8TbC?=
 =?us-ascii?Q?Bg70yFqgaw=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 747fb799-4fe2-47e7-0659-08de802b673b
X-MS-Exchange-CrossTenant-AuthSource: VI0PR04MB11917.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 11:35:04.2078 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: worPUbbKltzCKBa0BlnsR8FtclsnaFEpOqM8VOEt7ZDzgIV732h1MqGGwykcnDGw8Uos4DmN24tSyC/lnaYB8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMDPR04MB11651
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

Hi Marek,

On Wed, Mar 11, 2026 at 04:42:54PM +0100, Marek Vasut wrote:
> On 3/10/26 12:54 PM, Simona Toaca (OSS) wrote:
> > From: Simona Toaca <simona.toaca@nxp.com>
> > 
> > This patch series adds support for saving DDR training
> > data to non-volatile memory on iMX94 and iMX95 platforms.
> > The purpose is running DDR Quickboot flow on next reboot.
> > 
> > The process is as follows:
> > - OEI runs Training flow for the DDRPHY
> > - OEI saves the data from training to volatile memory
> > - U-Boot can then save it to non-volatile memory (e.g. SD)
> > - OEI loads the data from NVM at cold reboot and runs Quickboot flow
> > 
> > By skipping training, a much lower boot time is achieved.
> How does this interact with authenticated boot ? I wonder if, in case the
> entire bootloader stack is authenticated, the attacker can tamper with the
> saved QB data (which do not seem to be authenticated) and cause bitflips to
> occur in DRAM, which could then allow them to bypass authentication in
> follow up stages which execute from DRAM ?
> 
> Are the QB data protected/authenticated in any way against tampering ?

In U-Boot there is no authentication for qb, it's just the CRC that is used
to ensure the qb data was not overwritten by another (non-malicious) entity.

OEI is the first boot component that runs during the bootflow and is
in charge of verifying if the data stored in NVM is valid or not. With
the exception of iMX95 A0/A1, which use a CRC as well for this purpose,
the other boards (iMX95 B0, iMX943, etc.) use ELE to verify a MAC stored
in the qb_state structure. This provides the authentication part.

If someone tampers with the data and it somehow gets saved to NVM, the worst
case scenario is that Training flow will run instead of the Quickboot flow.
I am not sure that it can have any other impact. Especially in the case where
SPL saves qb data, the DRAM address can then be used for image loading without
worrying about qb or what data had been written there.

Kind regards,
Simona

