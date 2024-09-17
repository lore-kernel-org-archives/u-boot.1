Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24957C3ABB2
	for <u-boot@archiver.kernel.org>; Tue, 17 Sep 2024 02:32:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 492DB88E50;
	Tue, 17 Sep 2024 04:31:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="H21ueVOG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A41788DB4; Tue, 17 Sep 2024 04:31:05 +0200 (CEST)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03on20607.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260d::607])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69FA888DF5
 for <u-boot@lists.denx.de>; Tue, 17 Sep 2024 04:31:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=snjZyYcVed+G2y7kZguwcVCx8UBQ3yAfzizy5h3hIiR5cdPms8DkYfEo+eVg7rlvHCTGwoJwkIba7hvrUSSh6w92Hfw0/PXjZCkPtKlrQm2FdkF2Dghqug72sV6rwgxD6qNYyjcNPt365qREU3WYW98T2m+JFHvoRMMTBTh7wFwkvlM3+QZbMM4hGzbr4Gm8vOCVHIXVkB9+M0QUO/Mvy703ENYrNLTCeNmnxJE0hvkgg6Vork5fk9MJtDXv0OYgysWIM7BLTVzJYPOm/PyPKfMB6zG2H13JAmP15kylF4+cdp+qMVOcmOrDQb4Jn4lhX1x4iToWhhObEDEaBo77Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LHag+QCeqXKMX1Swj7HvoYCvke/INxX4N4Hr2P2nx/8=;
 b=f25EYob4PshYDZz/q1euC5a4xGZNiA+0QU/gLvsnlEPKH843wSXyvaPo1UqJPaIyJmqcEd8a3S/nd8EZ720HaJMBSF9sSdOuLqT81iG2LiFHoLXiorMBpGrVNUgnxHwbBYhATzGdkcrkUgonIR8WrXexyDz7izI+8aNjCWMa2TuojWM5W5DKaCGAstnJP0my+Y99kHmgv3NMCPFN0nRtFfRF64ZOsEXQhQcO2qS5MOIolb+MHXtW7ayZFF8IYv/JEMM8wgzzCzSeErrpJySztm2hX7WIhuFu5UdkCdPf2IB++MVoGB3xc3LU+eVa4SEIV8eqvyGOLx78NHFMrzOesQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LHag+QCeqXKMX1Swj7HvoYCvke/INxX4N4Hr2P2nx/8=;
 b=H21ueVOGs0JZLejf7GJYPfALkaLiehiM15yVpFAzBcIURnnhI1lAOL/Yu0IEfA6KW/heBj2GtOUMuw8+Wv4HM3SosmYMMdERn+2jE4VZESUKm54LDK33hhsElw3WzmyReaO4yPSYaNeLa3vMnS8rWbElagQomgSMz6mZh1S+ptAI+G3z6IrqujhkgzMtPArUN1LV0Ne53vyvgdCZFM/akGy/nIOGKPaUP0JWpbI4f2NFRfKzyAwi7YjCQmMofidlpyvn/QoMB0utbeQ4AUVvlGQR61MhNlskrL0s0fhjsn4zLggmiDCPAx+p7TcCw9HuYH7lZEuGZ0Oifg47R+BN2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI1PR04MB9739.eurprd04.prod.outlook.com (2603:10a6:800:1df::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Tue, 17 Sep
 2024 02:30:58 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.7962.022; Tue, 17 Sep 2024
 02:30:58 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Tue, 17 Sep 2024 11:34:01 +0800
Subject: [PATCH 09/21] imx9: soc: Mask the wdog reset in src by default on
 i.mx9
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240917-imx9-update-v1-9-4fe8effc937e@nxp.com>
References: <20240917-imx9-update-v1-0-4fe8effc937e@nxp.com>
In-Reply-To: <20240917-imx9-update-v1-0-4fe8effc937e@nxp.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>, 
 Jacky Bai <ping.bai@nxp.com>, Ye Li <ye.li@nxp.com>
X-Mailer: b4 0.14.1
X-ClientProxiedBy: SI2PR01CA0009.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::18) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|VI1PR04MB9739:EE_
X-MS-Office365-Filtering-Correlation-Id: 45ce9686-49f8-4207-3567-08dcd6c0c365
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MjE3RVdNckE3ajRVRU91MFI4aUY4Z2UxRmltbFJSdFFTSkt2ZUVqV3NkSDVk?=
 =?utf-8?B?YlpJYlE3MWt3c0NJWXQrQkhNWmxxZWJENFY4Znc4dXpzVytMd3BVSzg4VzBH?=
 =?utf-8?B?WXd3M0RVUWRwTU1mZXYveXJ3L2p3ZnZBR3JjK0RLVTg5V2UyMGZha3lHbHFP?=
 =?utf-8?B?RXM3T1Q2eFNMYzFkM2x0ZXY4ZGhhZmZTR3NYN2p4MlRucmZic2VMZXkvRGFR?=
 =?utf-8?B?Lyt1bUJXbUhQSlptb0ZsVkR3WU80V1UvK2tjWm9jNTR6c3FGWGlBYkpIUmFs?=
 =?utf-8?B?UFNsOXJ2dHd2SWdIcWJOQnpDeGlpWWhOd1JiWjY2dnoyRitVdGpONU9NYzgr?=
 =?utf-8?B?cUR6ODJUV1JZd0QxNnZVdUQyMC9tazFUbFY5eE1XUlZwYWd2Z0FGQ2VueWFx?=
 =?utf-8?B?T21vYlVIWGcyU1ZFYWtGeXdKMnlENEJyeW9TSzRqTGVQU0dvVFAxWEROdkJy?=
 =?utf-8?B?V25MY0FoTGNxNkVNbXBLYkJPZ1VRb1pTZ0lZM2xGMFBCK2hYUzJDa0xMSkZ0?=
 =?utf-8?B?R3UzSGtqanExVEdjbEQ4QW5hUExMczAzd3JaT0txV3lIT3JWUWxMUnhtdHpK?=
 =?utf-8?B?UzM3NDhQNWFjL0U1cnBndGwzd2JyRzl4UHNTUzJSQU9LVWV5MElwSTU5cWh4?=
 =?utf-8?B?QWMrNDR0dmdEaWNzN0xYTEx3cTVQbHMycnJwNzI0SENLZTFNTllPQkxCSGdG?=
 =?utf-8?B?TzdsTmwxaGhzcm41YkpVbGNvdHB1cURlMkJtMGVpVHZ4bk41L09tS2FoS0VG?=
 =?utf-8?B?d2FhQnJvNHRXc3VJdWZXc2RYalhZTWRuOWNQWU1RUEpKZVZSSC8xZUJIK3JH?=
 =?utf-8?B?d3JuVnp3eGxBSllra3JBbjJ1ZVNReFA4OGcxSFpGVmtVVVllVXlJdGpxa3NH?=
 =?utf-8?B?SHVtUm84YmxuVnhSenNwQ3dzM3ZjRCttSHcrMi9pMlJnY0w2aTVJck9lUGY5?=
 =?utf-8?B?dmQ5TjhheXUrUzZGNTQxYzBMT2RhWnloTzdSejhxa1FIVFRMREFGVUtlbjVR?=
 =?utf-8?B?aDFhb0RPY0NCYjNBbnMzY0FlaGhENWdkdHF5amR4Z1piY2FCMHJWTFRYMDZX?=
 =?utf-8?B?SGI1NlNkVjcydEQ2REtGdnExa1ZyUE5zc0lDck1SNHptVGlTS2xkSGYzODNr?=
 =?utf-8?B?eUV4eWVIZkpYemdMeHJFdGYzTzlIZ1NnTXp0R08vMkRKeFRVMXVUbmNiOFFj?=
 =?utf-8?B?Z3RLbHpqNVh5b1BxQUVNU1ZjdnZaTUxBUlpZbWVKNlRGT3MvK1lxdVFMSVE1?=
 =?utf-8?B?OGFpQTUzOEFHenM3NVpROUVBeGFWL09IRFo1UktPSnNtVjhKNVBtc1ZNQ0RK?=
 =?utf-8?B?b2FxZlF1eURoSzI2MEZYNGs3NXBTWXJuVXZtdUFoWTNDTlc3RFRpMFpJd1Rk?=
 =?utf-8?B?alpZUndxVklJK3V0M1U5c1drZGhNY0p3eXJnOUlwZkcvQ2MrSXp1TUoyVHJF?=
 =?utf-8?B?MG83VUlZamoxRDZ0TkRLSlpiYjNKUHVqd0c2TzQzZzhJT2RhS0Jpb0hmYUVS?=
 =?utf-8?B?N1IwWUttd1ZMMEhZS0ZqY25BZFZlaDkxbko3SDZtN2RKbzkrWFJ1b1luN1Ru?=
 =?utf-8?B?R1ZpU3RtblQzWStLZ1daYzBkcEp0YUpLNUFzNDl6UGVnRUhaaW0vTGh1OVhJ?=
 =?utf-8?B?R29vQmpNVW9MUXN1ME44QW02ZWlzcFdSMFNKQVh1ZkFCMG8rMW9CNEhWZjM5?=
 =?utf-8?B?eFMwelFSTW9vN2lJTkpMYm1IbDlzTFhaYnIvSzVsS0NpRXIyNnlxRG9wN0R6?=
 =?utf-8?B?MjJkREVIQ2wxWHcvZlkyZW4yM1p1WUlYT1FHSWY5bm5ZeUQybXhSWGVaUnFy?=
 =?utf-8?B?djhHQTJsdkJjNkV4eXdmRXpxcSt0K28rOEV6cDdnZjczQzhibHZueXlpSE02?=
 =?utf-8?B?RmM2SnJ6UlpnaSs4T21YSmkxbUVRMWQrU1JtSlhKNVFzUkE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V0R3SVhXN3NyY2hEbHQ0OGlaajhscGNkOTdKTHdTTzN2dnJyblA1TVlmS3lO?=
 =?utf-8?B?bTRiWm1kdWZqUWtaeVVnTml1eGN5bFpsSE1wc3JvZWxwR2t5THRBYUt1UW40?=
 =?utf-8?B?SEI3ZnJjVTBUOGdzaENXM2lpRGNEZ3FvWFhKZlZtME9rZjJhTWFyMW5vRkVk?=
 =?utf-8?B?QjY5Q1cyNFNEbGJ2LzNZenIzVkJzdnN5cXE5azdKZy8yZ2NuTlMxRmJLbXVE?=
 =?utf-8?B?UmRpc2xCM2RRay85elRyZnNndFRTY29NVC9PVHdlT2NmdEhqSTZLN2NMYmtD?=
 =?utf-8?B?NEdZL3J2UjE5SnRad2JSbm03b2lHN3I2V3VVaGE0V3Y0WXgyaG1YQ1lSWEhX?=
 =?utf-8?B?M0k1SHZ1OEdoRHJuN2o4L0xCSHR3WXJYOGpSbDdzYXJYQzVQcXZiTWtuaGts?=
 =?utf-8?B?KzNGejJna3NJMlhrdHd4L056NlpjcFFodnB4V2Q0WmpWVG9OVUpHZkhnMXcr?=
 =?utf-8?B?UkJ0TkdnekMwcjVPelVxKzhobWpXUDNoMW0rT09xaS9LK3VNeldzSUJxcmV4?=
 =?utf-8?B?WWExMTRNSGV0TEg4blo5ai8za3hiOW1tWFJobWEwcEQ3ZVRGUzljd3JxK2xk?=
 =?utf-8?B?aHBjcjVidnFjMjVyT1RvYjBEeTRkZ0tNcEFiRGtWWFE4d0FRUGsweFFxcEF2?=
 =?utf-8?B?M3pGSmw5ZUVvOEcwSnBuUlhVZjJCSmFZMC9wRVRob1BvaFd4WHk5di9iTHY0?=
 =?utf-8?B?QldtVTN5bS9VeXdRdHRReXJ0VzhYQ2xxeGV1cFBqZEFHakpITnNSOUhxZ2Zl?=
 =?utf-8?B?TVowamVtcUtaMUFEeEdscEZrMUNNbGEySlZNZE1DMU1XNjl5eEJYempLVlBG?=
 =?utf-8?B?YUxrbUhnL0h6K1dEd09TZFQ3cHZjMG51MjVMSVdaaGZlbmtoNVEzeGdPQmNp?=
 =?utf-8?B?aWwrZlh3Ulo4R0xPOVk3dGNlc1l6YlNsVm5QdVRuL0FiOEZYUmM5UWJkNXI5?=
 =?utf-8?B?b2tlaXc4cXpVditLVERSbDhwL3ZPbStPV21IQ3ViNWRwcW05MzJ6Nlp0NER2?=
 =?utf-8?B?LzZCdkdqYTFpZHU1N2dMY0ZtS2w3RDM4Ty9SSWVHNVhKbUNMNXR1eEtzckJB?=
 =?utf-8?B?ZUFsWDRoMndPLzVIU1M1Z09iUXNyZXR6MHVCNjVqbTJwUStQSE5vQlVoWW5n?=
 =?utf-8?B?S1ZiNlhWKy8wL2pReGpCV1luTkhJY3dOMXQ0eHlkaDloVkpiVjhRMDdSUHZ3?=
 =?utf-8?B?MmlnNWhlSWFNOUEzOGlySDZ1M0pFNmNzMmZrbFhGWGd1c2ZCMW5UeGdNZ3pB?=
 =?utf-8?B?RmZGRU1FRVVyZnBubjB5MTA3d0ZvT3Y2UnM2MHNCaWNuVE9XZ0Juc2RaNUJa?=
 =?utf-8?B?ODdqTWZ6V25DQVJVd0c2VU5Fem1IWEtKZzJPbEFjdzRDUktsUTZ1L21sRWFw?=
 =?utf-8?B?ZmVtWHRpZ1lCczgvOWtxUzY2NEMzSTlpWENSVVlGYWJMYlhxckNGdFFheTFH?=
 =?utf-8?B?TFF3OUc0ZjNIN0dwQmZpTlFMRXROdkR0MGF0RXVLU0NBM1FqN3NRVGRhb2c3?=
 =?utf-8?B?emRDLy9uTHM2MEVlOE5YNUpROVdqbXo4amgwTGUvT1BKYUhlakFBdU50MDR4?=
 =?utf-8?B?U0Y4dTVmSzYxM1hzOU9jV1I2SU5JMVk1cWFMeS9TSDJNV2twQmlUK0J1b0hN?=
 =?utf-8?B?NTFJSk1LcFk3UWQ5RktGSVJpdWpLZDJrdy93MWNZdUE0RUs0TVBVdGpBMDFH?=
 =?utf-8?B?WDhpY2gxbEdIQWNQY2Y3bGFNc3B0aWoyNzE2d0lWR0t1REpINndtZzBVelBp?=
 =?utf-8?B?KzMzU2MzYXF0d01vR1NNMFNvL2lYQlNIcTdUV05Pbm5IVG9XUFZyUFFFYXJI?=
 =?utf-8?B?enlMYStLblFyczY2Zm1oWGxBUEpnMi90RFJtOHNDTkxXUitaTHFUenR5dm1w?=
 =?utf-8?B?YTdsTjd4VUw4YVBzb1FUVUpVOGVHbXNrd0FjdW0vMDRnbHZPNGZVanlrMXBr?=
 =?utf-8?B?d0RrNjFFcFE4QnhqaTNWcWJMWThGNXBWc3NJbHhLUmZyczJ3R1RnSTZoY1Zv?=
 =?utf-8?B?Q25oSHJLcm5GanovU1k3bjlNZ1pRdXIzaTk0RnFIeGVtZzN2emlraTB3SDZE?=
 =?utf-8?B?ZDdTRlF6RXFkMnhITEdHZ1lWQmVDQURjR0RsaFhnNzB3TXArT2tpTkpBVkdM?=
 =?utf-8?Q?+JrZOsFHaDgoV/V8rlbgDk1dK?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45ce9686-49f8-4207-3567-08dcd6c0c365
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2024 02:30:58.0776 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IrgKTK1o3/KOlv4V5Rhii8yJ8bR8NicSbUeTTXgbMKl6XoAi/dBbZf9jhQ8PajG3pZHgShIow2BfZWQBSeC4Yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9739
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

From: Jacky Bai <ping.bai@nxp.com>

Normally, the wdog will be used for trigger external PMIC reset
through the WDOG_ANY pin. If the PMIC chip has debounce logic for
the reset signal, in some corner case the wdog can NOT trigger
external PMIC reset if the SoC has been reset internal before the
PMIC captures the WDOG_ANY pin reset, so need to keep the WDOG3-5
reset masked in the SRC to let the PMIC to do the reset safely.

Reviewed-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Jacky Bai <ping.bai@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/mach-imx/imx9/soc.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/arm/mach-imx/imx9/soc.c b/arch/arm/mach-imx/imx9/soc.c
index 8a577b98255..a73e73adfe6 100644
--- a/arch/arm/mach-imx/imx9/soc.c
+++ b/arch/arm/mach-imx/imx9/soc.c
@@ -232,15 +232,9 @@ static void disable_wdog(void __iomem *wdog_base)
 
 void init_wdog(void)
 {
-	u32 src_val;
-
 	disable_wdog((void __iomem *)WDG3_BASE_ADDR);
 	disable_wdog((void __iomem *)WDG4_BASE_ADDR);
 	disable_wdog((void __iomem *)WDG5_BASE_ADDR);
-
-	src_val = readl(0x54460018); /* reset mask */
-	src_val &= ~0x1c;
-	writel(src_val, 0x54460018);
 }
 
 static struct mm_region imx93_mem_map[] = {

-- 
2.35.3

