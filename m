Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 458BEE77188
	for <u-boot@archiver.kernel.org>; Fri,  3 Jan 2025 06:46:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3660480488;
	Fri,  3 Jan 2025 07:46:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="kd0w/E2L";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42D0780488; Fri,  3 Jan 2025 07:46:00 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::601])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8B6C803F5
 for <u-boot@lists.denx.de>; Fri,  3 Jan 2025 07:45:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q6RZ7i10yklVpQsttPOX/7stb6BCHt1ftKyX/WbPUjm6UaZjtgfVTk0m3X5/AqVhZIlLqMezu/MO3AhD6AfNvzupFRQG5l/2bCg9y/ni9cgdHnhez6fyDPF9m8FgsCr2QtQDoZSz1orLbOw6Lbo2oTeXelxvjNIsmMuE4GP6JEPkl7x/o3Ox60vCIvw0GcF4mSbx1kmLgC0EVk+dMwuVRYWp7HTZ4rvr/4bK/CLCUDnaLbLPmprFJMcf2M9nQEAfcQIviwpaLJ6uM/jRuU+oW6LKm+M0KQhvmxT6v+TvqyqrBjuld2pncF1IrFwILdWE95uG+E1b37HaVqWSeUnaRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iHH/BeJixfFAaRGnZvP5XqAcoUrFQBpwmuK7FnFL5A4=;
 b=eNiNmMJYDHbpd2+M3R3SQ0BfTuwNw5oo8LrRycw7IT5n94n6JmyvtHVW1Mh21FJ/Y0hK/7GTBtkQJ0Y4QUgC+2UCq14CSGAXKGGgMWQaBFheze8EFGfeeaNhi003FZu907TQlBVGM2pcUWbccTQVPE52kGBCYB4xtMoOJ445ajhYejjAxDh8Jyil6PJw9dZYefPzYWouyCnDazL4E0EbahIwlSHLLsQWmjW6HesjjRH08CFejRTvdxERkA4dGo5okcuNli7YnTEODIVcShbv2uXueGwrUrs6Bxk9G0YUNkIimAS4GrgU9TGMieYwIaQYURaGBBo7aGYGla7IJu+nPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iHH/BeJixfFAaRGnZvP5XqAcoUrFQBpwmuK7FnFL5A4=;
 b=kd0w/E2LAlCFl4Y+QoEiqJRqaGJMIPq6pfb7qy9UldqPBHMYopJ+WiE/02Xoi6EPpSRmqJULgUBjM04+1ITcmPgUMq/Xfu+ZEEO7ROZ6+IWip4UGismVLTZkA9/47Kz5IgZR+fYdj+QIuAoJkkbK30GH0tPpHlnwNJgjC7kHUbsDUGq6Sp8yBLkUmURILZflzMtBO1wtMdRtjF3vjkZuqgUdHN2YmbkhqBR/0OW1l67GSXDj8xPKE4SOzL+cBSX9hISiB0r+mpf2K8mSGtKnDUkmmrKVY8ewtNvq4611T1bMC3aO8fXAyDW2rjhOKQaehbeg7ko4kSR9d3miUWXdpQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by PAWPR04MB10054.eurprd04.prod.outlook.com (2603:10a6:102:38b::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.13; Fri, 3 Jan
 2025 06:45:52 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%5]) with mapi id 15.20.8314.012; Fri, 3 Jan 2025
 06:45:52 +0000
From: Alice Guo <alice.guo@oss.nxp.com>
Date: Fri, 03 Jan 2025 14:45:36 +0800
Subject: [PATCH v3 01/17] mailbox: add i.MX95 Messaging Unit (MU) driver
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250103-imx95-v1-1-6744df5dc020@oss.nxp.com>
References: <20250103-imx95-v1-0-6744df5dc020@oss.nxp.com>
In-Reply-To: <20250103-imx95-v1-0-6744df5dc020@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>
Cc: u-boot@lists.denx.de, marex@denx.de, tharvey@gateworks.com, 
 Peng Fan <peng.fan@nxp.com>, Viorel Suman <viorel.suman@nxp.com>, 
 Ye Li <ye.li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1735886747; l=13832;
 i=alice.guo@oss.nxp.com; s=20250103; h=from:subject:message-id;
 bh=c8AVN6wT7IEHbfMf/SIFbMZZ703OWRYFC4tbMQjjxQs=;
 b=djWcZu0VGEc+CeeMafo1donb05w2XCB3/9+5h9EwkcIznkNt39/nHaMlfFGWC6Rfbilb9uKt5
 Ka2KXWEDgxfDwak5kc25BFMBCcL0j2aSZOpGSaZWhm7drC5Q5w1mkDo
X-Developer-Key: i=alice.guo@oss.nxp.com; a=ed25519;
 pk=6RXhk/KbIrPIkIaZWptZot1vwQyfwwp597Dp3Ydq+kA=
X-ClientProxiedBy: SI2PR02CA0014.apcprd02.prod.outlook.com
 (2603:1096:4:194::19) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|PAWPR04MB10054:EE_
X-MS-Office365-Filtering-Correlation-Id: c4ab84b4-834d-44d0-5bcb-08dd2bc243ef
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|52116014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?anJ1TXNXQ1lmeHQyeFVnZFdHR3BNSUt6ZUY4OEdsMDFRN3NFQjRLaXpHZEJ2?=
 =?utf-8?B?bFd2SjFFQXlXdXpHcmJUckVhcFp0Q0JCbm5vRldIcFpaZ29hTGhkcC9SeDFJ?=
 =?utf-8?B?SDhVK1BLMlhsclN1SU9taVFPK2h6N1hnYlFBaXNzVXJDZDhDY1ZPRTJGYVhX?=
 =?utf-8?B?WGR3QTZCT2NNWEFESVBUMERFMXRlbDBsbG9CSlFOSDhJanhJdzhBakpoSnBJ?=
 =?utf-8?B?U1ZwOHcyek1iczY4VzQ5d0FSdGdKREdFZjc5RU1mbjE1SHJqelVXSktNK2dq?=
 =?utf-8?B?UFVHdW00Rk9sRHFWZHprbFhXUXZ3NVBHNkU0VjE0QlM5bEIrcEtPMEtXNlBY?=
 =?utf-8?B?RWdXTzNRR05tUFkyMEkzb2Jhc3crbTlvN2NvMkFHNkJNK2RxSGxnZnJJQUdB?=
 =?utf-8?B?ZVExQzJIa1ZTbHFGb1Q2b092MjdMb1ZYNjVFL1p0SnJuSENPRkdhRllhSVVp?=
 =?utf-8?B?UzExM1R3NUs2clk1NTQ5SEQ0WjZpNVdqNHNOTjRhd294MzU3WXZHaW5WQnho?=
 =?utf-8?B?WmhNS2FtY2thNEFlQ3V1RVhKSTdBU3RSQ1NyaGFCamFyU2lHV0hrR3FPMzY3?=
 =?utf-8?B?akNITHA0MFhyY25hWUY4bkU0bjdsaDViZVNreFQ3SlFBMWR6bkh6dnozNUQr?=
 =?utf-8?B?b3pOY1UrZzYyZzFtZVRaWEEyUll2YXFWOUZrSGNscW41a0srMzNVMkRDNkI2?=
 =?utf-8?B?dkxNdXQvQmVxK3pEelgwTW1yZXFRRWYybVVjQUxOWW9PYWpsQ1pJZVgwaUlz?=
 =?utf-8?B?NHFVOG5aM0FTWE5xc2hRVnNYU1JrRHUxbzNnTnhaQzFQSzNmRXBYQngvd2ZF?=
 =?utf-8?B?M2J3RTNpKzdSSGJuaHhJemJyekVWQlRvc2s4MjlFT25wZU1GY3BoU2VldW4w?=
 =?utf-8?B?Yy9aTk0zODJ1MExUUXlES01pTkMvTVlMOXpNS1lSZ3dXSVR4U3J5eFdGK04w?=
 =?utf-8?B?WUlRenZWelJJYnVGaXBRTThWY29vUEU1VzdWcjFFdWVFVlRLT2ZJSzFPWjNr?=
 =?utf-8?B?RkUyUkdUNDZzU3EwOFZJZ1J3MUZ1Z29mcm9YUEhpclVCZWxnNlVtdERicnZG?=
 =?utf-8?B?MmhvdXFETHBtZUdUTitJQ3hVYW1RTjEzdEVSOTVSMjNwbTBDZXJRQXRReVlT?=
 =?utf-8?B?bm02NVg0dzhHcnJZNWdKNlpoWW1hVkpCeXBUeDZYT0FlcGxGY25rbTYzbkIy?=
 =?utf-8?B?djBHS2xMVHpCODdnQThaeXhEa1NlMU1XYmFKL3NwYklvMURBSWFIK2lrbGUw?=
 =?utf-8?B?MDl6K3hYNVBuZE50bWJhSzd2NU9HbmUwTi9MZzJDVGVzSEplQ1hoclZKamlH?=
 =?utf-8?B?ZWpYOVRSUGNrYnA1bWlIOHErK3dobVlHRDlrdVdTSXZPRVFsc0FDcVRaaXM2?=
 =?utf-8?B?U2dtelhCMVU4N1NIWmhWRXZSbVFGV0hjUDN6Q1lIVkZxMEZkdzJHblZRY3Ra?=
 =?utf-8?B?OVVxSy80ei92ODAxQzczOTM0SStjSjlZYjhIbk0zUmNzOXVKTTVRUm9zZWF2?=
 =?utf-8?B?dWxQVzJPRUlNL3dBOUVjUHEyM1hZTHVFbm1RcjM3d3Zab1ZncCtETmM3ckZM?=
 =?utf-8?B?cUxUcTJGWVhHZmtHN0o4S3dlNkxNUWRYZG04ZHNMekhRNjAxVVZ6WHgwTHhC?=
 =?utf-8?B?dTZxcmRrTlFMOWJvdUVQZFo4TW0zdm1EU0NWODdVZ3JBSEIwWkVnYXVpNnB1?=
 =?utf-8?B?dHZZL2h2dU1IZVpCSVI4UEh3OTBuZGY0SkJuYm5rNUpIVS9QVmxXR0FZSzJl?=
 =?utf-8?B?UTFJaXExV1Z1SVcwNHpKNzNQckJPM1M1S0ZMdEc5Vmp2bEVVNDlUbXRITUJK?=
 =?utf-8?B?SUsvcHdhNU9EMWJ0M0oxV0QvWG1ZMVZmVFlLSE5FOU5ZK2NBY3ovZlVybEE3?=
 =?utf-8?B?MXFFeXdIK204UFJObXJFdVRuTW1YQVlzR0R6UHZYZ3ExT2g1NDhQaUs3Witt?=
 =?utf-8?Q?2NRx+6aOCQijJfMGa/tCI6e3vkQE8rY0?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(52116014)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RnFjak9UcXJRYlFxVnNHVENRWGVpakhjVi8vMkhPZ2g3KzVpbnhRdlA5YzNy?=
 =?utf-8?B?UE1XMEk4UjJRNUZ3VGxEK29Ib012N1FFQU11ZXRKNTRFM1RDd043Rmc0dHFX?=
 =?utf-8?B?Nnd5eDJwaHUzL1NqUjFLRVc4ZnJlRHNxYzZPKzRBWmIvalVPa0VhQ0g5T01o?=
 =?utf-8?B?OW40NFNKeVBuSUR5TFZFYzJSMTcyZmx2eUx4YzZyTnBndkZpT2tBOVR3dGMv?=
 =?utf-8?B?OXd1endYNFBGcWtGcnJsd0hGbmdWZG1Qa0U2cDhVVzVvSVJUNWtLbVM3a21F?=
 =?utf-8?B?enlnbnNseUlCZFVXS1pDdDl0clVWTDZHSFhKckFqS3Q2WDhzVVBQZkExTUpl?=
 =?utf-8?B?aFlGNUdCaUF5V3VyQW5WdEhUbUNLSkxoWitMS0pwb0dYZ3dwKzB2YXlFYUMz?=
 =?utf-8?B?bmtHQ0ptdkZ3d1hwUVE0UjJaVlNtcDNTeUhtTE1iTk9GRHM0SEd6aFdBYk9s?=
 =?utf-8?B?YWl1OHFMY2NOUE5tS21LcWJHblNKenhlYkN5dlhCYWxoZjVYMlZpTVYreTVH?=
 =?utf-8?B?OGlYdEJ4ZDM3ZWhuVE9oWm1aQ29ibWxwaFpvNUZXdjRQblMwWUhEc3pKUmdE?=
 =?utf-8?B?N3FRbXJnT3JXaWRJVTU1dytGK2IzT3NEN1N5aXpKb0p1clAxQmpIRzhHZjhk?=
 =?utf-8?B?bHU2eDNCeS8vYWlETWtMakpvdzJBY1ZYT2Q3elE4U1V4akp2NmxHTHVTRmFz?=
 =?utf-8?B?aUNzaHVBbDMzUnpIbUs0SUpOU3RCWExjWk9tcVlkd1owdWphUEE0QlJVbm5l?=
 =?utf-8?B?bGw2Z3J5b0p5eGxkM3NSdjdIcGNSMUVvWVA4alplWmNBQ2JyeEhxcm1kTG1W?=
 =?utf-8?B?aEt0U0ZOaWlNOVJjaWlQd25DMGt2WlJsVFU1dVRMZTI4MVJTVXQzMDBMemFD?=
 =?utf-8?B?U1MrQXRwM0VndGNublZITEVrYytKVmpURUVBQVJuK3pJL1EyS1gzaUlBbXhp?=
 =?utf-8?B?U3grOWYybHo4TVJLcUxBRFRTZE1CdVQ0aHdmM1AvMFdmQitUS3lLZVhxYWFS?=
 =?utf-8?B?UFh2cmVIWEFrZXorakx0QXlXbjNQNGxHdm1YcjJPNXRUL2EwNnkybVFhekpn?=
 =?utf-8?B?RFNtNWR3TkRZTXlpNnVwRXUyTGhwbzUzZXZpdUdlUzNwR1RJSGtjbW41Vlp6?=
 =?utf-8?B?Y1RnSFdwVkY2SVUwTkxMcXVrSVp4Zm42bTdFTXpMWENqdjVGc2F5anlaVE9S?=
 =?utf-8?B?SjFTL0t2U3ZxSDQwT3psRWRqYjE1SUFKVE1pK0YzcWdBRys0WW83bm0yUVMr?=
 =?utf-8?B?OEdtRkJTOU1HL3p4NzJKYlFXVm5PTEh0UUs4NEZ0RWVMYUg4N3U4dDFXblZG?=
 =?utf-8?B?Y040c0REZHExVlBlYkxGV1kyVU9sRVNUUTlzNElzVHNTWWZ3OEluVFhrOHlT?=
 =?utf-8?B?clFlNUJWa2cyNUhFSTFrdSt4Y1F6Q2lYU2pHaGlaU3BlbjNrUDdTbzArRk8w?=
 =?utf-8?B?N0xqOUtXcWVYTGs3a1gya2pTeXdKSDl3cEpxdDN1RlNLYkVGWUtGUkNEOHVy?=
 =?utf-8?B?QSt0TmJySVRwV3VTR0I1R1dKMThxb2NIcm9xNXZxdzBGakdIb0dBVlFvUVVl?=
 =?utf-8?B?cnZBZFMzRHpoZk52UWhSZTc0Rm1NcUMxN2QxdkdyVmVjeWs1aFE3SzB1OXZ1?=
 =?utf-8?B?bHljQ2lQdFM5SmZiRW1oNmRBOFVVU2FRcXpFTUI2blFZV0FlVEZTdmdEbDR4?=
 =?utf-8?B?aUtScjdKbms0RlNURFFqY2NFZlYrZkJTQVdidDdtM0NQRDN4L3JwbExLMURF?=
 =?utf-8?B?bHFnWWtPQ2M2SllONGJTejFSKyt3dURxRkFUZ2hyaDNmSWxxdm1mVmZ6bXRy?=
 =?utf-8?B?YkIvUlZtL3NWaHYrSlJFNW0xMWpMYldKMUx1SWJxTzRkMCtDbURwUks0MDVC?=
 =?utf-8?B?Y1VCR21aSTg4MjNOZE02cTllY1dEYUtLMlBmclovcXhFNkJpSnloU2pueDZI?=
 =?utf-8?B?U3k1SUxBK3dPRUZTd0pPZ3BXRmltcTQxNll0cnUwaUduZTJhVEh5RlNvOGx2?=
 =?utf-8?B?Zml6WWhSZUVXeWZmNGFIMWkwSGxta3ZwYW9ZTHMzbkJpZWc2NTZZbmNZQmZM?=
 =?utf-8?B?YWJtT2xBN3JHd0ZMQllwSjU0d25ycld2aGpnaWduSS9velNhMVR3V2E0allo?=
 =?utf-8?Q?FoNQCZGIWkkZkHhPCAnPpIv7h?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4ab84b4-834d-44d0-5bcb-08dd2bc243ef
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2025 06:45:52.0813 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: es/HLDUcN5/jLYNDbB3ii+WY1/BBweP3NPhBAdUtbva4hYRqP4KT8k8HaqEvm5dx4m0IBsWfvmzYUpKj07MlGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB10054
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

From: Peng Fan <peng.fan@nxp.com>

i.MX95 Messaging Unit (MU) enables 2 processors on a chip to communicate
and coordinate by passing messages (e.g. frame information, event
notices and requests) through the MU interface. This patch provides a
driver for i.MX95 MU using the common mailbox framework. Currently, SCMI
exchanges on i.MX95 uses a mailbox transport with SMT format, and the
hardware used is this MU.

Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Ye Li <ye.li@nxp.com>
---
 MAINTAINERS                   |   1 +
 drivers/mailbox/Kconfig       |   7 +
 drivers/mailbox/Makefile      |   1 +
 drivers/mailbox/imx-mailbox.c | 417 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 426 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ba31f86feb6da266cddd160a041d0594ac86d274..5ab2b72d0f93afaf70c4c2dcb8fc48210683b749 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -313,6 +313,7 @@ F:	board/freescale/*mx*/
 F:	board/freescale/common/
 F:	common/spl/spl_imx_container.c
 F:	doc/imx/
+F:	drivers/mailbox/imx-mailbox.c
 F:	drivers/serial/serial_mxc.c
 F:	include/imx_container.h
 
diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
index 67d5ac1a74228ccd82b2725c0bb745354d099948..4d9f004ebad7f57034a6cdae3bff9645fa0ee67d 100644
--- a/drivers/mailbox/Kconfig
+++ b/drivers/mailbox/Kconfig
@@ -21,6 +21,13 @@ config APPLE_MBOX
 	  such as the System Management Controller (SMC) and NVMe and this
 	  driver is required to get that functionality up and running.
 
+config IMX_MU_MBOX
+	bool "Enable i.MX MU MBOX support"
+	depends on DM_MAILBOX
+	help
+	  Enable support for i.MX Messaging Unit for communication with other
+	  processors on the SoC using mailbox interface
+
 config SANDBOX_MBOX
 	bool "Enable the sandbox mailbox test driver"
 	depends on DM_MAILBOX && SANDBOX
diff --git a/drivers/mailbox/Makefile b/drivers/mailbox/Makefile
index 6072fa1956b793636c35aa0d1419c9dcaae27095..574add60005fe73d2beba715a12e0157fe4b0552 100644
--- a/drivers/mailbox/Makefile
+++ b/drivers/mailbox/Makefile
@@ -5,6 +5,7 @@
 
 obj-$(CONFIG_$(XPL_)DM_MAILBOX) += mailbox-uclass.o
 obj-$(CONFIG_APPLE_MBOX) += apple-mbox.o
+obj-$(CONFIG_IMX_MU_MBOX) += imx-mailbox.o
 obj-$(CONFIG_SANDBOX_MBOX) += sandbox-mbox.o
 obj-$(CONFIG_SANDBOX_MBOX) += sandbox-mbox-test.o
 obj-$(CONFIG_STM32_IPCC) += stm32-ipcc.o
diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
new file mode 100644
index 0000000000000000000000000000000000000000..082c7740f4fc0155dce0e0ce861fec27f7a24ccc
--- /dev/null
+++ b/drivers/mailbox/imx-mailbox.c
@@ -0,0 +1,417 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2017-2023 NXP
+ */
+
+#include <asm/io.h>
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <mailbox-uclass.h>
+#include <linux/bitfield.h>
+#include <linux/bug.h>
+#include <linux/iopoll.h>
+#include <linux/compat.h>
+
+/* This driver only exposes the status bits to keep with the
+ * polling methodology of u-boot.
+ */
+DECLARE_GLOBAL_DATA_PTR;
+
+#define IMX_MU_CHANS		24
+
+#define IMX_MU_V2_PAR_OFF	0x4
+#define IMX_MU_V2_TR_MASK	GENMASK(7, 0)
+#define IMX_MU_V2_RR_MASK	GENMASK(15, 8)
+
+enum imx_mu_chan_type {
+	IMX_MU_TYPE_TX          = 0, /* Tx */
+	IMX_MU_TYPE_RX          = 1, /* Rx */
+	IMX_MU_TYPE_TXDB        = 2, /* Tx doorbell */
+	IMX_MU_TYPE_RXDB        = 3, /* Rx doorbell */
+	IMX_MU_TYPE_RST         = 4, /* Reset */
+	IMX_MU_TYPE_TXDB_V2     = 5, /* Tx doorbell with S/W ACK */
+};
+
+enum imx_mu_xcr {
+	IMX_MU_CR,
+	IMX_MU_GIER,
+	IMX_MU_GCR,
+	IMX_MU_TCR,
+	IMX_MU_RCR,
+	IMX_MU_xCR_MAX,
+};
+
+enum imx_mu_xsr {
+	IMX_MU_SR,
+	IMX_MU_GSR,
+	IMX_MU_TSR,
+	IMX_MU_RSR,
+	IMX_MU_xSR_MAX,
+};
+
+struct imx_mu_con_priv {
+	unsigned int		idx;
+	enum imx_mu_chan_type	type;
+	struct mbox_chan	*chan;
+};
+
+enum imx_mu_type {
+	IMX_MU_V1,
+	IMX_MU_V2 = BIT(1),
+	IMX_MU_V2_S4 = BIT(15),
+	IMX_MU_V2_IRQ = BIT(16),
+};
+
+struct imx_mu {
+	void __iomem *base;
+	const struct imx_mu_dcfg *dcfg;
+	u32 num_tr;
+	u32 num_rr;
+	/* use pointers to channel as a way to reserve channels */
+	struct mbox_chan *channels[IMX_MU_CHANS];
+	struct imx_mu_con_priv  con_priv[IMX_MU_CHANS];
+};
+
+struct imx_mu_dcfg {
+	int (*tx)(struct imx_mu *plat, struct imx_mu_con_priv *cp, const void *data);
+	int (*rx)(struct imx_mu *plat, struct imx_mu_con_priv *cp);
+	int (*rxdb)(struct imx_mu *plat, struct imx_mu_con_priv *cp);
+	int (*init)(struct imx_mu *plat);
+	int (*of_xlate)(struct mbox_chan *chan, struct ofnode_phandle_args *args);
+	enum imx_mu_type type;
+	u32	xTR;			/* Transmit Register0 */
+	u32	xRR;			/* Receive Register0 */
+	u32	xSR[IMX_MU_xSR_MAX];	/* Status Registers */
+	u32	xCR[IMX_MU_xCR_MAX];	/* Control Registers */
+};
+
+#define IMX_MU_xSR_GIPn(type, x) (type & IMX_MU_V2 ? BIT(x) : BIT(28 + (3 - (x))))
+#define IMX_MU_xSR_RFn(type, x) (type & IMX_MU_V2 ? BIT(x) : BIT(24 + (3 - (x))))
+#define IMX_MU_xSR_TEn(type, x) (type & IMX_MU_V2 ? BIT(x) : BIT(20 + (3 - (x))))
+
+/* General Purpose Interrupt Enable */
+#define IMX_MU_xCR_GIEn(type, x) (type & IMX_MU_V2 ? BIT(x) : BIT(28 + (3 - (x))))
+/* Receive Interrupt Enable */
+#define IMX_MU_xCR_RIEn(type, x) (type & IMX_MU_V2 ? BIT(x) : BIT(24 + (3 - (x))))
+/* Transmit Interrupt Enable */
+#define IMX_MU_xCR_TIEn(type, x) (type & IMX_MU_V2 ? BIT(x) : BIT(20 + (3 - (x))))
+/* General Purpose Interrupt Request */
+#define IMX_MU_xCR_GIRn(type, x) (type & IMX_MU_V2 ? BIT(x) : BIT(16 + (3 - (x))))
+/* MU reset */
+#define IMX_MU_xCR_RST(type)	(type & IMX_MU_V2 ? BIT(0) : BIT(5))
+#define IMX_MU_xSR_RST(type)	(type & IMX_MU_V2 ? BIT(0) : BIT(7))
+
+static void imx_mu_write(struct imx_mu *plat, u32 val, u32 offs)
+{
+	iowrite32(val, plat->base + offs);
+}
+
+static u32 imx_mu_read(struct imx_mu *plat, u32 offs)
+{
+	return ioread32(plat->base + offs);
+}
+
+static u32 imx_mu_xcr_rmw(struct imx_mu *plat, enum imx_mu_xcr type, u32 set, u32 clr)
+{
+	u32 val;
+
+	val = imx_mu_read(plat, plat->dcfg->xCR[type]);
+	val &= ~clr;
+	val |= set;
+	imx_mu_write(plat, val, plat->dcfg->xCR[type]);
+
+	return val;
+}
+
+/* check that the channel is open or owned by caller */
+static int imx_mu_check_channel(struct mbox_chan *chan)
+{
+	struct imx_mu *plat = dev_get_plat(chan->dev);
+
+	if (plat->channels[chan->id] != NULL) {
+		/* if reserved check that caller owns */
+		if (plat->channels[chan->id] == chan)
+			return 1; /* caller owns the channel */
+
+		return -EACCES;
+	}
+
+	return 0; /* channel empty */
+}
+
+static int imx_mu_chan_request(struct mbox_chan *chan)
+{
+	struct imx_mu *plat = dev_get_plat(chan->dev);
+	struct imx_mu_con_priv *cp;
+	enum imx_mu_chan_type type;
+	int idx;
+
+	type = chan->id / 4;
+	idx = chan->id % 4;
+
+	if (imx_mu_check_channel(chan) < 0) /* check if channel already in use */
+		return -EPERM;
+
+	plat->channels[chan->id] = chan;
+	chan->con_priv = kcalloc(1, sizeof(struct imx_mu_con_priv), 0);
+	if (!chan->con_priv)
+		return -ENOMEM;
+	cp = chan->con_priv;
+	cp->idx = idx;
+	cp->type = type;
+	cp->chan = chan;
+
+	switch (type) {
+	case IMX_MU_TYPE_RX:
+		imx_mu_xcr_rmw(plat, IMX_MU_RCR, IMX_MU_xCR_RIEn(plat->dcfg->type, idx), 0);
+		break;
+	case IMX_MU_TYPE_TXDB_V2:
+	case IMX_MU_TYPE_TXDB:
+	case IMX_MU_TYPE_RXDB:
+		imx_mu_xcr_rmw(plat, IMX_MU_GIER, IMX_MU_xCR_GIEn(plat->dcfg->type, idx), 0);
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static int imx_mu_chan_free(struct mbox_chan *chan)
+{
+	struct imx_mu *plat = dev_get_plat(chan->dev);
+	struct imx_mu_con_priv *cp = chan->con_priv;
+
+	if (imx_mu_check_channel(chan) <= 0) /* check that the channel is also not empty */
+		return -EINVAL;
+
+	/* if you own channel and  channel is NOT empty */
+	plat->channels[chan->id] = NULL;
+	switch (cp->type) {
+	case IMX_MU_TYPE_TX:
+		imx_mu_xcr_rmw(plat, IMX_MU_TCR, 0, IMX_MU_xCR_TIEn(plat->dcfg->type, cp->idx));
+		break;
+	case IMX_MU_TYPE_RX:
+		imx_mu_xcr_rmw(plat, IMX_MU_RCR, 0, IMX_MU_xCR_RIEn(plat->dcfg->type, cp->idx));
+		break;
+	case IMX_MU_TYPE_TXDB_V2:
+	case IMX_MU_TYPE_TXDB:
+	case IMX_MU_TYPE_RXDB:
+		imx_mu_xcr_rmw(plat, IMX_MU_GIER, 0, IMX_MU_xCR_GIEn(plat->dcfg->type, cp->idx));
+		break;
+	default:
+		break;
+	}
+
+	kfree(cp);
+
+	return 0;
+}
+
+static int imx_mu_send(struct mbox_chan *chan, const void *data)
+{
+	struct imx_mu *plat = dev_get_plat(chan->dev);
+	struct imx_mu_con_priv *cp = chan->con_priv;
+
+	if (imx_mu_check_channel(chan) < 1) /* return if channel isn't owned */
+		return -EPERM;
+
+	return plat->dcfg->tx(plat, cp, data);
+}
+
+static int imx_mu_recv(struct mbox_chan *chan, void *data)
+{
+	struct imx_mu *plat = dev_get_plat(chan->dev);
+	struct imx_mu_con_priv *cp = chan->con_priv;
+	u32 ctrl, val;
+
+	if (imx_mu_check_channel(chan) < 1) /* return if channel isn't owned */
+		return -EPERM;
+
+	switch (cp->type) {
+	case IMX_MU_TYPE_TXDB_V2:
+	case IMX_MU_TYPE_RXDB:
+		/* check if GSR[GIRn] bit is set */
+		if (readx_poll_timeout(ioread32, plat->base + plat->dcfg->xSR[IMX_MU_GSR],
+			val, val & BIT(cp->idx), 1000000) < 0)
+			return -EBUSY;
+
+		ctrl = imx_mu_read(plat, plat->dcfg->xCR[IMX_MU_GIER]);
+		val = imx_mu_read(plat, plat->dcfg->xSR[IMX_MU_GSR]);
+		val &= IMX_MU_xSR_GIPn(plat->dcfg->type, cp->idx) &
+			(ctrl & IMX_MU_xCR_GIEn(plat->dcfg->type, cp->idx));
+		break;
+	default:
+		dev_warn(chan->dev, "Unhandled channel type %d\n", cp->type);
+		return -EOPNOTSUPP;
+	};
+
+	if (val == IMX_MU_xSR_GIPn(plat->dcfg->type, cp->idx))
+		plat->dcfg->rxdb(plat, cp);
+
+	return 0;
+}
+
+static int imx_mu_of_to_plat(struct udevice *dev)
+{
+	struct imx_mu *plat = dev_get_plat(dev);
+	fdt_addr_t addr;
+
+	addr = dev_read_addr(dev);
+	if (addr == FDT_ADDR_T_NONE)
+		return -ENODEV;
+
+	plat->base = (struct mu_type *)addr;
+
+	return 0;
+}
+
+static int imx_mu_init_generic(struct imx_mu *plat)
+{
+	unsigned int i;
+	unsigned int val;
+
+	if (plat->num_rr > 4 || plat->num_tr > 4) {
+		WARN_ONCE(true, "%s not support TR/RR larger than 4\n", __func__);
+		return -EOPNOTSUPP;
+	}
+
+	/* Set default MU configuration */
+	for (i = 0; i < IMX_MU_xCR_MAX; i++)
+		imx_mu_write(plat, 0, plat->dcfg->xCR[i]);
+
+	/* Clear any pending GIP */
+	val = imx_mu_read(plat, plat->dcfg->xSR[IMX_MU_GSR]);
+	imx_mu_write(plat, val, plat->dcfg->xSR[IMX_MU_GSR]);
+
+	/* Clear any pending RSR */
+	for (i = 0; i < plat->num_rr; i++)
+		imx_mu_read(plat, plat->dcfg->xRR + i * 4);
+
+	return 0;
+}
+
+static int imx_mu_generic_of_xlate(struct mbox_chan *chan, struct ofnode_phandle_args *args)
+{
+	enum imx_mu_chan_type type;
+	int idx, cid;
+
+	if (args->args_count != 2) {
+		dev_err(chan->dev, "Invalid argument count %d\n", args->args_count);
+		return -EINVAL;
+	}
+
+	type = args->args[0]; /* channel type */
+	idx = args->args[1]; /* index */
+
+	cid = type * 4 + idx;
+	if (cid >= IMX_MU_CHANS) {
+		dev_err(chan->dev, "Not supported channel number: %d. (type: %d, idx: %d)\n",
+			cid, type, idx);
+		return -EINVAL;
+	}
+
+	chan->id = cid;
+
+	return 0;
+}
+
+static int imx_mu_generic_tx(struct imx_mu *plat, struct imx_mu_con_priv *cp,
+			     const void *data)
+{
+	switch (cp->type) {
+	case IMX_MU_TYPE_TXDB_V2:
+		imx_mu_xcr_rmw(plat, IMX_MU_GCR, IMX_MU_xCR_GIRn(plat->dcfg->type, cp->idx), 0);
+		break;
+	default:
+		dev_warn(cp->chan->dev, "Send data on wrong channel type: %d\n", cp->type);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int imx_mu_generic_rxdb(struct imx_mu *plat, struct imx_mu_con_priv *cp)
+{
+	imx_mu_write(plat, IMX_MU_xSR_GIPn(plat->dcfg->type, cp->idx),
+		     plat->dcfg->xSR[IMX_MU_GSR]);
+
+	return 0;
+}
+
+static const struct imx_mu_dcfg imx_mu_cfg_imx95 = {
+	.tx	= imx_mu_generic_tx,
+	.rxdb	= imx_mu_generic_rxdb,
+	.init	= imx_mu_init_generic,
+	.of_xlate = imx_mu_generic_of_xlate,
+	.type	= IMX_MU_V2,
+	.xTR	= 0x200,
+	.xRR	= 0x280,
+	.xSR	= {0xC, 0x118, 0x124, 0x12C},
+	.xCR	= {0x8, 0x110, 0x114, 0x120, 0x128},
+};
+
+static const struct udevice_id ids[] = {
+	{ .compatible = "fsl,imx95-mu", .data = (ulong)&imx_mu_cfg_imx95 },
+	{ }
+};
+
+int imx_mu_of_xlate(struct mbox_chan *chan, struct ofnode_phandle_args *args)
+{
+	struct imx_mu *plat = dev_get_plat(chan->dev);
+
+	return plat->dcfg->of_xlate(chan, args);
+}
+
+struct mbox_ops imx_mu_ops = {
+	.of_xlate = imx_mu_of_xlate,
+	.request  = imx_mu_chan_request,
+	.rfree    = imx_mu_chan_free,
+	.send     = imx_mu_send,
+	.recv     = imx_mu_recv,
+};
+
+static void imx_mu_get_tr_rr(struct imx_mu *plat)
+{
+	u32 val;
+
+	if (plat->dcfg->type & IMX_MU_V2) {
+		val = imx_mu_read(plat, IMX_MU_V2_PAR_OFF);
+		plat->num_tr = FIELD_GET(IMX_MU_V2_TR_MASK, val);
+		plat->num_rr = FIELD_GET(IMX_MU_V2_RR_MASK, val);
+	} else {
+		plat->num_tr = 4;
+		plat->num_rr = 4;
+	}
+}
+
+static int imx_mu_probe(struct udevice *dev)
+{
+	struct imx_mu *plat = dev_get_plat(dev);
+	int ret;
+
+	debug("%s(dev=%p)\n", __func__, dev);
+
+	plat->dcfg = (void *)dev_get_driver_data(dev);
+
+	imx_mu_get_tr_rr(plat);
+
+	ret = plat->dcfg->init(plat);
+	if (ret) {
+		dev_err(dev, "Failed to init MU\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+U_BOOT_DRIVER(imx_mu) = {
+	.name = "imx-mu",
+	.id = UCLASS_MAILBOX,
+	.of_match = ids,
+	.of_to_plat = imx_mu_of_to_plat,
+	.plat_auto = sizeof(struct imx_mu),
+	.probe = imx_mu_probe,
+	.ops = &imx_mu_ops,
+	.flags = DM_FLAG_PRE_RELOC,
+};

-- 
2.34.1

