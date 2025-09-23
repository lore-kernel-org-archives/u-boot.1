Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E86E9CAC5AA
	for <u-boot@archiver.kernel.org>; Tue, 23 Sep 2025 02:17:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E62DE83621;
	Tue, 23 Sep 2025 04:15:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Tk91O+cM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C6154835CB; Tue, 23 Sep 2025 04:15:49 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B9EE48363C
 for <u-boot@lists.denx.de>; Tue, 23 Sep 2025 04:15:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GI6TFredZGwxHFvMbsOuso85dVGdC72f9zyP+ZbVoTiptWcYLoAJaj9A6zmrXqbP3QbXIPHFH6y9rwmzAHRrQh/8FmZHZ6aaPz5otZkZ8JjC5Ay/4jwtp+WKgNHXviDXJsJECAgmr0MDsdP8FVU9dAxzT+9ZpTPpDd3FNDQeEMPwd4ThDnjMsekbro+taqAMNYdrQ20Z2r7Ce6PKnJ9H5k0x2RiQag1No2Hazf4Ej62h1+C31ElrPffWD3bT6FGdaY3Jnsdb0d/SelQTLayQ4Kb09EspnCLFROmRYfH4b1uaM0FqdLFk1vJ4NpI+KHAQq5PCdOPddhYAfweH+rWj8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=97yR0oZdeWBY653FHZAS2K8uzo3dRdwN3TLjWCSYh0Q=;
 b=FGGOsl/6jkS4c3nh/4IOo5X6SPkNFLPegARXnADYQROtR8NunrgEG7wreZZW2SCXu3Fftjl4zQHtN4MIksWycD07R5HBL2WyZZSADr2UguQvhVTWIUJmTCfeYrncIuXV1/Eq95LQgJ5x3UyjOnaqzat7AsXm5SLVxv4wu6ze+ggcWJutyLyWDFLgGWPYpt7giypx7TrwlW3Co8MI3csWpUAn2EjChFYexgT0LoVh2SgdlKejWICH6H0c22mV9lmz3r6YFgh6OHL4KEMCvzOd144NkiFQurFXz+19E8eXgczXaPTWlajVzaj4Tl2VT0qwogpfgYYarzo5smZ1bAwGpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=97yR0oZdeWBY653FHZAS2K8uzo3dRdwN3TLjWCSYh0Q=;
 b=Tk91O+cMHbQf1+QehqCOKxwyEXv2EbQKV+ZrRt7be9WhcK7On4jccvc2SuNQg+X4Y/2J47isu17KGimIKxgDGBgmUWy8HxxRfqwqhnxrFf6cWVXJReGku1+vCA/N2R0c0YCLx/jMcyR3LxWOejLQGF4dRcSsKDB4DLVBe2Tdv0kO7GSsE3Te8Qa4I0PKlv18YP2Advu7W9XPL0gyKu35xlk0VaODH2IXeo4p45bZiIC9S3fgNDFrYGGSolqPjpM2HHJ7zrns9nM+C2DfcnuX6RzaUVwwYPu36C+zyx96Kj5bRsBM8TWJFKqBmxJHo8g2dBvdAhk5XE28RpR50dh28w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by VI1PR04MB9835.eurprd04.prod.outlook.com (2603:10a6:800:1e1::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Tue, 23 Sep
 2025 02:15:45 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9160.008; Tue, 23 Sep 2025
 02:15:45 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Tue, 23 Sep 2025 10:15:03 +0800
Subject: [PATCH v3 11/12] arm: dts: Add i.MX943 EVK board dtsi files
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250923-imx94-v1-11-cb3b65169048@oss.nxp.com>
References: <20250923-imx94-v1-0-cb3b65169048@oss.nxp.com>
In-Reply-To: <20250923-imx94-v1-0-cb3b65169048@oss.nxp.com>
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>, 
 Alice Guo <alice.guo@nxp.com>
Cc: u-boot@lists.denx.de, Ye Li <ye.li@nxp.com>, 
 Peng Fan <peng.fan@nxp.com>, Jacky Bai <ping.bai@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR02CA0037.apcprd02.prod.outlook.com
 (2603:1096:4:196::8) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|VI1PR04MB9835:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ab3aa6e-5daa-423f-25ef-08ddfa471ac5
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|19092799006|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NzBValdVT1poWlcyT2VwOVV1cHdXL2I0NnZOSWJDYk5JSVFvZFlkMXVwWEor?=
 =?utf-8?B?UFlWWnoyUTlCUTBQWTJKOVBIK2p1Sk5OZ054ay9OTFFCcXA1ZUhYM2pTaE02?=
 =?utf-8?B?K29sblE0YlRWZGdLZXduQnpIc2Nyem14SW02MWhJdWMzYzAxOW4xeEhNajF1?=
 =?utf-8?B?Wkk0THZmaTN2Wjg1YWppZFBaZVprMENmUlkwL0hlcFFWUnQrR3E3eit0V3NG?=
 =?utf-8?B?SjA0aHcxWmRiaW5HSTVVWlc2ZVB5cTlCamR4VnNUTGxSRktGbkNYUHJmU05y?=
 =?utf-8?B?cUZSajhaSENTNHA2MlIzY3ZwYW8xN3czVVZPNkpmK0FVOGVRdXVMdGpuSzV5?=
 =?utf-8?B?V3NQbklGQ0Jxd0NDbktTbjVuZjY1NmxLVSt2QXo1ekhJNm9yb09PWXEyY1VX?=
 =?utf-8?B?S3cwc0V4d0grU0N4bHA0UTAvamZsc0ZOb2xIU2F4OUNacjNXWG1WQ1pScVVB?=
 =?utf-8?B?K0VGWHB2dUdjMkZsUG9jUkNPOVhhRGhsTndHS1FrcUxXbjVEb3lFc1pwbW41?=
 =?utf-8?B?cUlvdGdBbElGR1VXWmZUazI0d2x2VmRUbUJMUHpqQ2V3aWoxSG1jUmh0bEd1?=
 =?utf-8?B?UFc2cjlZTC93UTIwWVc1RnlvS0ZDTVRzR3FGaW5mTUtHekhKWU5SdW9pbHl3?=
 =?utf-8?B?U0NCOHdQUmZ4MFZpbG5JUWFEN2Q3bGt4L29SQjRiV0RDWisvK2J2eFA5b3Fj?=
 =?utf-8?B?aFRkMk1EUWt5N1RiUkJsRFFkUnc4b1FXUm4zMkwxT2QwNjVWbUF5eVp1M0Js?=
 =?utf-8?B?RThkbW9RUVVET0tTeFdrMTRPdC9sRENBODZGbytwdTVrNlFGNk5JVTRkT2tS?=
 =?utf-8?B?aWtmV1N4WjdhODlRblpyS0NrM2pqNXA5bFgvNWpqWEl5WEM5cGthZi9aMnRx?=
 =?utf-8?B?VFB1QklsTWRHQmhZMCs0d01JelR5akVVM1IrZ1hpd0x3djRtTXhJdDk1SnNF?=
 =?utf-8?B?VFpSQ0dRRnFWUVZOZGVibkpVMzd2QXZHZk53MEd3eisxSGtna1FnVUlkbFc3?=
 =?utf-8?B?SGdabE1QMHRhaCtLSG5tZ0t5bmg4RE0va25DQjJpM2NsdWhNQS9TRWJ3STM5?=
 =?utf-8?B?QktvNWJScllUb3IwSjRzUHRsT1lsTXRpNnRqdm42R1dTRGptYWtPekkyYkt5?=
 =?utf-8?B?alFEU1F4clBadTJxOHdoWmRpTGFlR1FoaWo0T2FjUkQ1SzcxY3NoMmNiaWlk?=
 =?utf-8?B?RTRuWSsyNlcvN2oyaGFnc3R3OVpqUVlqY0xvallnampDS3pYeVJEYzFrblJs?=
 =?utf-8?B?Z0k1ZFZ0VGdLMllWS0NFSnE3MUpBc2Rad2tiQktaY3E1cnRBWFI3K0lHOVNZ?=
 =?utf-8?B?N25TVWNYT1AwNUZadHkzaVk4VWNLSUF1eklPM0JMUkVCNWs4MVVWOG9yRW5C?=
 =?utf-8?B?OFVXUlNmb0thdE44Q28rcWp2VjNVa2tkaW5ndGlEM3ZCa0M5dTB5akFpSWxa?=
 =?utf-8?B?RXk2N2RGaEc0QWwzZmVyK1d1WVl2N2h1eGVFbTJCMTcxRzFpNEtwZ2ZqcjFR?=
 =?utf-8?B?OXJkSlREVjYwTjM5QlRtbmlSdTBaeUpPYzUrTS9SODZhUjBNNEt6eUVrZldR?=
 =?utf-8?B?eERLNU03MGsvanpLMFFra3ZSVXBpUm0rbGhwRCtMVE8yQUJWR1RQYmNQSEdC?=
 =?utf-8?B?N2dKS2RSOFlFcFMvQ1JTNFFvcTE0Vml1SDh2Qkp4azdGa0Z5UnE4M3lqdkgx?=
 =?utf-8?B?UHBidnViNGEzbFJHOHdjcDhYSnFIb3VYZlZ6ZXNMS1FoTGJKQWtoZHpRdGxy?=
 =?utf-8?B?TENiRStUb3JjV1BPR3lkNVpSU0NXK3hoSzNBbGswQ3hsc0FERFF0WkFxV1lt?=
 =?utf-8?B?QVB4VTJIc0JuU1owUzUrMDArcW00TENmay9MUDNsRFF1NmJXRVlheUZnNmxV?=
 =?utf-8?B?VHdkNWx0L0U5R3B0UDF5cEkvemtDTDVSTlZJbExxdVZIUFVCbzVvUlZESFVJ?=
 =?utf-8?B?d0JvK2JFNWZkTzZqY3V1NVByUEFuUTRrVW5jcEFSa3AzSXBuamVTemdOSC9a?=
 =?utf-8?B?Wjc5cGFGNk93PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(52116014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TlVkOXhrOThNTk93YmNFcmJsOWVQQm1kUnZEREpqZmRyT3dYd3Z3NDYyVVoy?=
 =?utf-8?B?Zmd3MFhlR0NXUm5BMFgzRXBhNnV3L1pLOVlFejZTMUVlbUNYMk03ZHpXbGxO?=
 =?utf-8?B?eitJOU1YUzN2eVFDaVE4TGc0TDZHOS9Mb0lKTjltSEpXdnhzejhaemIrd3RC?=
 =?utf-8?B?UThRMDFzZW5sS1E1TnZtckQ2aEc5NkpoVzEwT2N4MW9LMTZONDk3SmdCN05N?=
 =?utf-8?B?ejFMbFZld1RESEgvMzdaN2JSZjc1d2lOWjBWRHN5eW5STTFPV1cvQ1RNdk9y?=
 =?utf-8?B?Tk9SVXF5TzRBVTNrcVdpVHlkUXV5TWJQa0JKenFPY0hSMkdzU1EwR2pYaUNh?=
 =?utf-8?B?ZjBYZ2NKczN2UnlPL3lGd2srVU5tZ0NIVUdGMit6VmJ0Zlk4akIxRkhjaTNR?=
 =?utf-8?B?TjVjREwwL1VnTjZvVUVvU3lzdjVIdWJkU252RXZEYUtvK0JBWm0xTEdGU3V6?=
 =?utf-8?B?L2U5dy9vSFNyeWM4S3doMmNDTTM5L0tXVlNpazdBa0hTQ0RoaS8xb1o5R0o5?=
 =?utf-8?B?cFc3TXUwdmZFMzNscmZoUHF2SmQ2YXB6Um5RMTJWcUg5eVdIeVZOaGpOTSts?=
 =?utf-8?B?KzJ2QTRGUUxJa1ZDekw0QjhKS0ZLOUpFcGd2VjRUSTBFN20zcy9kaHJWYWlJ?=
 =?utf-8?B?RUlrdWdiTUJDUkJCN0l5Rkw2QTNSMkFiQ0tuV2dFa2w0b0x4YzFuWlg5SXp0?=
 =?utf-8?B?bWhRZmJuZDV2RlppZ0Rzd3B2dXlqOWliQmJCeDV3WWJ3T0NRSUh6QnduK29m?=
 =?utf-8?B?V3J5QWxpU0NCQ0ZhaCtwRlhIdmdlRGlOdkNlNThaYmFRTzBkVGRPQmVpK2tr?=
 =?utf-8?B?UFdqNkR2QXJ0cjA5OS9YNWJkNjh1YW50dmVodUZNVnA0Z3NMcGRVelY4K2xW?=
 =?utf-8?B?U0VSVDhtbEVOYjZRNXNaWnFCOTJwMGk0V1UzSEtTK1kvZnBpcVJUZkhCSTgx?=
 =?utf-8?B?YS9veFJJdFdYVzlkTmJTMkNKS21OVHFXQ1ZCWG9vTVNpTnd4eW5IM2JZbXp2?=
 =?utf-8?B?c0F2UVB6OGdydmJzRzhqZ3lybjU2ZGlabFE4TnYvS0gxUngwQ2F4K1BIcE5U?=
 =?utf-8?B?WUF6bnpBUXF6RHJqczlBZHV2bTNScmo2eWE1RU16MU95YlNxaDhjZGJMSzcy?=
 =?utf-8?B?dE4vV0Z0cmMrTEVRMU5haVNnekZSWTVtZ3pEek1XcCtnZVBNb0xnemYrVHJN?=
 =?utf-8?B?RnBJbzUxT0tLcGdzQ0VXVWNCUUkxWjMrWEpEYzhLVGM2cWJYazE3L2hJejZs?=
 =?utf-8?B?cEZMdDljS2oyZXFiRGplTmhmYkN0VFBPOG05eDZRM0oySlc5MGpDVjFiL01m?=
 =?utf-8?B?NWdTa2R6NmV1NDFiOXBNdEgwL0Z3cmJ6NC8vZnhpSVFhVnFSYWJqT0RFY1hE?=
 =?utf-8?B?Qk1EYllGY2JpWW14WU8xVWZaL1k1RmJPUnozR0wvSjAzNkR2SUlGdU5uS2Uz?=
 =?utf-8?B?R014M0tjRm0vcTNXcTVQbEtaU2gvR0FQNWZtOXl4TVlIL0czeU5MQi9DSERF?=
 =?utf-8?B?Z3U3MGpnTzlVeTR4L2ozRUxkcHhhQjlHZks0c0JzdVhpVi9mWThVRVFqMzUr?=
 =?utf-8?B?YW9oVnlORjZ1cjZKZzZlY28xbTZkcVVwQVV0SnkrMjc2enEzN3R1RURzQnV2?=
 =?utf-8?B?Yjl6VW80VnNHNVZSUUZ5OHdHcXhlcmJISjdIdTNadFQycFV5dGdiK1BZUjVC?=
 =?utf-8?B?YmxoKzRhWS9EbEU1QlJVb3NFRFdLR3BsNWNZVGZOQVRDUHNuSWlPOGdwbEor?=
 =?utf-8?B?Q0ozR2RTM3g4MWdsUG9LMlRaUDc5MWtjTnk4WklmVFlialNCMUlZejN6SGFY?=
 =?utf-8?B?SktGZEI4dC9MUDY0ZEttRVkwRDRiaXFKQTZoT1R5WGt6UXc4dUpQS1FxYnVx?=
 =?utf-8?B?dXoyRzU4SWVMOTQ0TGtJWUo2bll1U3FxYWZKYytZSktmdERQY25aOGNEUExL?=
 =?utf-8?B?UklvT0FEclJJUWhzTzE4TFZid3NENytQeU5ILzk1ajFORUJLK0xSbG83bVFG?=
 =?utf-8?B?TlpmMHNva2N2b1FuMVcyUzRTeVlWMzBCWGtmeWpHSE9zZU5xQm1CaC9KTng5?=
 =?utf-8?B?Q253WmhiTUcra1ovejgrMFhsUVZMSDI1L1pNS2FhbGdPVFc3cVRpbkdTMnpn?=
 =?utf-8?Q?E01D8TKMjqgGYCMK8TH4rW7G5?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ab3aa6e-5daa-423f-25ef-08ddfa471ac5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 02:15:45.7989 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jctvOJCvwmkTO5FZnqICVhKx4I0oCfgZQqO3YFqHm67i8Q/bjxvKhLefjJ3d2Cwb3yx1kxdOypYqths0W1wQwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9835
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

From: Ye Li <ye.li@nxp.com>

Introduce the base dtsi files for the i.MX943 EVK board. These files
define the essential components such as messaging units, uSDHC, GPIOs
and lpuart for board bring-up.

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Acked-by: Peng Fan <peng.fan@nxp.com>
Reviewed-by: Jacky Bai <ping.bai@nxp.com>
---
 arch/arm/dts/imx943-evk-u-boot.dtsi |  62 +++++++++++
 arch/arm/dts/imx943-u-boot.dtsi     | 212 ++++++++++++++++++++++++++++++++++++
 2 files changed, 274 insertions(+)

diff --git a/arch/arm/dts/imx943-evk-u-boot.dtsi b/arch/arm/dts/imx943-evk-u-boot.dtsi
new file mode 100644
index 00000000000..5496385dc4d
--- /dev/null
+++ b/arch/arm/dts/imx943-evk-u-boot.dtsi
@@ -0,0 +1,62 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2025 NXP
+ */
+
+#include "imx943-u-boot.dtsi"
+
+&lpuart1 {
+	bootph-pre-ram;
+};
+
+&reg_usdhc2_vmmc {
+	bootph-pre-ram;
+};
+
+&usdhc1 {
+	bootph-pre-ram;
+};
+
+&usdhc2 {
+	bootph-pre-ram;
+};
+
+&wdog3 {
+	status = "disabled";
+};
+
+&pinctrl_reg_usdhc2_vmmc {
+	bootph-pre-ram;
+};
+
+&pinctrl_uart1 {
+	bootph-pre-ram;
+};
+
+&pinctrl_usdhc1 {
+	bootph-pre-ram;
+};
+
+&pinctrl_usdhc1_100mhz {
+	bootph-pre-ram;
+};
+
+&pinctrl_usdhc1_200mhz {
+	bootph-pre-ram;
+};
+
+&pinctrl_usdhc2 {
+	bootph-pre-ram;
+};
+
+&pinctrl_usdhc2_100mhz {
+	bootph-pre-ram;
+};
+
+&pinctrl_usdhc2_200mhz {
+	bootph-pre-ram;
+};
+
+&pinctrl_usdhc2_gpio {
+	bootph-pre-ram;
+};
diff --git a/arch/arm/dts/imx943-u-boot.dtsi b/arch/arm/dts/imx943-u-boot.dtsi
new file mode 100644
index 00000000000..9c4882f7d79
--- /dev/null
+++ b/arch/arm/dts/imx943-u-boot.dtsi
@@ -0,0 +1,212 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2025 NXP
+ */
+
+/ {
+	binman {
+		multiple-images;
+
+		m33-oei-ddrfw {
+			pad-byte = <0x00>;
+			align-size = <0x8>;
+			filename = "m33-oei-ddrfw.bin";
+
+			oei-m33-ddr {
+				align-size = <0x4>;
+				filename = "oei-m33-ddr.bin";
+				type = "blob-ext";
+			};
+
+			imx-lpddr {
+				type = "nxp-header-ddrfw";
+
+				imx-lpddr-imem {
+					filename = "lpddr5_imem_v202409.bin";
+					type = "blob-ext";
+				};
+
+				imx-lpddr-dmem {
+					filename = "lpddr5_dmem_v202409.bin";
+					type = "blob-ext";
+				};
+			};
+
+			imx-lpddr-qb {
+				type = "nxp-header-ddrfw";
+
+				imx-lpddr-imem-qb {
+					filename = "lpddr5_imem_qb_v202409.bin";
+					type = "blob-ext";
+				};
+
+				imx-lpddr-dmem-qb {
+					filename = "lpddr5_dmem_qb_v202409.bin";
+					type = "blob-ext";
+				};
+			};
+		};
+
+		imx-boot {
+			filename = "flash.bin";
+			pad-byte = <0x00>;
+
+			spl {
+				type = "nxp-imx9image";
+				cfg-path = "spl/u-boot-spl.cfgout";
+				args;
+
+				cntr-version = <2>;
+				boot-from = "sd";
+				soc-type = "IMX9";
+				append = "mx943a0-ahab-container.img";
+				container;
+				dummy-ddr;
+				image0 = "oei", "m33-oei-ddrfw.bin", "0x1ffc0000";
+				hold = <0x10000>;
+				image1 = "m33", "m33_image.bin", "0x1ffc0000";
+				image2 = "a55", "spl/u-boot-spl.bin", "0x20480000";
+				dummy-v2x = <0x8b000000>;
+			};
+
+			u-boot {
+				type = "nxp-imx9image";
+				cfg-path = "u-boot-container.cfgout";
+				args;
+
+				cntr-version = <2>;
+				boot-from = "sd";
+				soc-type = "IMX9";
+				container;
+				image0 = "a55", "bl31.bin", "0x8a200000";
+				image1 = "a55", "u-boot.bin", "0x90200000";
+			};
+		};
+	};
+};
+
+&cpu0 {
+	clocks = <&scmi_clk IMX94_CLK_ARMPLL_PFD0>;
+	/delete-property/ power-domains;
+};
+
+&cpu1 {
+	clocks = <&scmi_clk IMX94_CLK_ARMPLL_PFD0>;
+	/delete-property/ power-domains;
+};
+
+&cpu2 {
+	clocks = <&scmi_clk IMX94_CLK_ARMPLL_PFD0>;
+	/delete-property/ power-domains;
+};
+
+&cpu3 {
+	clocks = <&scmi_clk IMX94_CLK_ARMPLL_PFD0>;
+	/delete-property/ power-domains;
+};
+
+&aips1 {
+	bootph-all;
+};
+
+&aips2 {
+	bootph-all;
+};
+
+&aips3 {
+	bootph-all;
+};
+
+&clk_ext1 {
+	bootph-all;
+};
+
+&dummy {
+	bootph-all;
+};
+
+&{/firmware} {
+	bootph-all;
+};
+
+&{/firmware/scmi} {
+	bootph-all;
+};
+
+&{/firmware/scmi/protocol@11} {
+	bootph-all;
+};
+
+&{/firmware/scmi/protocol@13} {
+	bootph-all;
+};
+
+&{/firmware/scmi/protocol@14} {
+	bootph-all;
+};
+
+&{/firmware/scmi/protocol@19} {
+	bootph-all;
+};
+
+&gpio2 {
+	bootph-pre-ram;
+};
+
+&gpio3 {
+	bootph-pre-ram;
+};
+
+&gpio4 {
+	bootph-pre-ram;
+};
+
+&gpio5 {
+	bootph-pre-ram;
+};
+
+&gpio6 {
+	bootph-pre-ram;
+};
+
+&gpio7 {
+	bootph-pre-ram;
+};
+
+&mu2 {
+	bootph-all;
+};
+
+&osc_24m {
+	bootph-all;
+};
+
+&scmi_buf0 {
+	bootph-all;
+};
+
+&scmi_buf1 {
+	bootph-all;
+};
+
+&{/soc} {
+	bootph-all;
+
+	elemu1: mailbox@47530000 {
+		compatible = "fsl,imx93-mu-s4";
+		reg = <0x0 0x47530000 0x0 0x10000>;
+		bootph-all;
+		status = "okay";
+	};
+
+	elemu3: mailbox@47550000 {
+		compatible = "fsl,imx93-mu-s4";
+		reg = <0x0 0x47550000 0x0 0x10000>;
+		bootph-all;
+		status = "okay";
+	};
+};
+
+&sram0 {
+	bootph-all;
+};

-- 
2.43.0

