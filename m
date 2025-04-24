Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B726C369D7
	for <u-boot@archiver.kernel.org>; Thu, 24 Apr 2025 06:36:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6DEC182045;
	Thu, 24 Apr 2025 08:35:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="JxFVCJlu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9F8AB80944; Thu, 24 Apr 2025 08:35:07 +0200 (CEST)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur03on2062a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260c::62a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E7A582045
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 08:35:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dsAHdktiC3k4n4+P6eQ4DnWzx6dNC0uVGEy3K7JpHcbp1CJyDETKYEubGQ75XMGliCAB/5/yNTenfDSgeyhvzvgzdf1p2qPiYG0iJFG1hMe6KuzZpmSYR1hJm/6EJebRNq+2V1220Xy7yGBsfivZXekacEG1UXamD3DQNZvvuYKHsZ9JT3Pvsz68a1/AYxf+od1umshGbu5g2R43kdkiuehtD9qI9XPw1K4nTl0cxMdDxZT+UGijdWvE6IQ8xCSCOrcgLyx5OWfwe1QpAW5Xp2pImuOMmzVrvY/79k6iZukgXlOPyhrMPXbXgTEuNjFfVcIUaNloX0/FoP/kuD+NEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m4xJB2bKHRzugnT9lrCxPxT7n67lChTPQ9RaxMOBUyk=;
 b=yyL48Fc8heHb1BMoAZj/G9gyKTRkf/u4hXvdnWBv4MRkJRBbPjWkeY9UYmZ9CCdBDx1gE9CAz+rDjJ7ezx2b/wA2dhuSw+HwrldVg4BwS46KE/NNj8zawq5tc8MIm8qob0qamORA8Po9316Ay8bGuW7WzoaTL2tyf9JwOBOEA9O9CbWS5uJCaa0fjl47W/U/iac5L9GAe0iz16sUEA5rvN5h+8SLX1RdPSZaNggaTBmXfcDTlkqmYe0chUhNRj+lqjm7IKs5aUSp8IgrE4Z1ChCBO3rB8lkXX5Ox1YJu7p3Q+lRH6Abizdd3w4ags+6ZiuJuPXrNEEDOIu38mcTSOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m4xJB2bKHRzugnT9lrCxPxT7n67lChTPQ9RaxMOBUyk=;
 b=JxFVCJluFX5UTDzymzx6iJ3QnN/NSP7CzMwHDyWlsLaImRNhIfSiSWdRs/V8ORAdDhziEd2FeYGXFdsdz1z+W2ieatT5EH1/hYTsHyu0Dcolabh9RhVIZVeDPA6xSaQEmUGayUkF/C4RfjXrl9OqWJwLWcXARrKYunexeqdo0QOA+qXPTQjtm8g8jBDIbTzTV4wKknAXx1t+GKd1vWLMHhsk/hLcxVmihkOdpl6IvCMF3knzRsrI/iBCrKYPB2DevkJlkumudPEFYiqmdRApXgmcoqRH65ZAOTcTo2eGH3C2fPLNamyhUnCrH/epI802d+FI0WTez24eSoiDsnnP8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by VI0PR04MB10661.eurprd04.prod.outlook.com (2603:10a6:800:265::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Thu, 24 Apr
 2025 06:35:02 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8678.021; Thu, 24 Apr 2025
 06:35:02 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Thu, 24 Apr 2025 14:33:14 +0800
Subject: [PATCH v10 18/21] imx: container: add V2X container support for i.MX95
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250424-imx95-v1-18-10a8449b1e5e@oss.nxp.com>
References: <20250424-imx95-v1-0-10a8449b1e5e@oss.nxp.com>
In-Reply-To: <20250424-imx95-v1-0-10a8449b1e5e@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Simon Glass <sjg@chromium.org>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>
Cc: u-boot@lists.denx.de, Marek Vasut <marex@denx.de>, 
 Ye Li <ye.li@nxp.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SG2PR01CA0140.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::20) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|VI0PR04MB10661:EE_
X-MS-Office365-Filtering-Correlation-Id: ea66532d-5ed5-42da-e76b-08dd82fa24a4
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bkpJcFpHZmVwb0thOHdBdW5PN2NnODBoNkV4Y3N2RXJoZXpXNW9ZQU9INmJ1?=
 =?utf-8?B?cGdranNNdVV0a3AvZU9VbEV1S0t3ZCtLWUJZL2tmaFBLSVJsZVpSS2VzTDcw?=
 =?utf-8?B?Zi9TMlArV2NrUEo2SXp4UlFITjFOazhpY3lzVkdkVFNoN3VIa0lUakVLU1Nm?=
 =?utf-8?B?cTIxQUowRzZ2NmJRYVJjTXFPUkNYMXpPdjdYeit6NWVESzdYMmRYMkFiQjV2?=
 =?utf-8?B?ajY3Y29pN2I1S3FnaGNsNDRadUZmYTgvZXlsT3lUb0FaSFFtRVR1YnFSbm9F?=
 =?utf-8?B?ZkJtOWduRmI2cHlUMUFONm03Sk02em1VY3pGdGdOYlR2Vm9BczBlQ3BVQ1hN?=
 =?utf-8?B?UmJWR0t0VUdvbGQ3ODZWS1JBeFQwWjlNNzlNT1h6K0V4SUJSUk9hcmdhYWd3?=
 =?utf-8?B?S0xBRS90M2ErTW5sNjNUakpxR3VUWGI5cGQ3eHYrSU1URzhwbHEvK0N5MWov?=
 =?utf-8?B?SVRsb2VoNS9OYXpaVWpGaUZUQkczNzlOYWJNYkkwNEQ2bXViVGJzSE5ZcS9y?=
 =?utf-8?B?YWlxelpGNkxXTTdpSXZ4VmhKL3JwUXBkbTZ3eFk2aXppVWR4a09PbUVZV1FJ?=
 =?utf-8?B?R3JtS3Y3VWNSMEtNQTZESklzdjRHZHl1UUR0TFl6c2s0SEJXV1pVeDMySGV0?=
 =?utf-8?B?NW9nTWpwTStBRVBvZTFsY1l1YU1kSkJLYlNmL1lKd3U4TTRZdG1NSWY3NDVt?=
 =?utf-8?B?ejFrMW1BWXlVMHBJTWZWTmpQS2lKTGJ1eFNYaWdZdXo2NnRsRmNmWFh3dTUv?=
 =?utf-8?B?SStiZnozbndjcVhkNHpTQW1DWXkrdUlGbER6SktaZG84K1pRSkhPODlXdDFn?=
 =?utf-8?B?cXgveXdmdVNyemhnUHN0a2lQL3ovcWwrL2ZtUFlQclRDVk1kMTBVKzNwbC8z?=
 =?utf-8?B?Yld0eWlVZis3MmVudElYOTVnSmQ0N2g3M01iNUoyOTVpam9oVHpDek5iSUpG?=
 =?utf-8?B?TUJPYWNYQ0s3R2k5NGIzUjNEK1MwbFcyTWt6MWtxTGVLRHgzOUNLcndNMm85?=
 =?utf-8?B?dVZHZjI2VEFCYzZMWGxFQzZEUVRSRDZ2a1lITW8vR01SWjcwbVBWTUVLN3Ny?=
 =?utf-8?B?N0c5bllueGZINzBSalpVL2lZZU9nSndTeVhBdGpqNTRzNDJzTDNXeHlONUFO?=
 =?utf-8?B?VlNVWklMRnNKcjZqTjlQeEJIVEpQZTUrUUt0QjlPNkFPWHoyRzdmWHRuek5B?=
 =?utf-8?B?WXk4N0ZPUENxSXkvczVINmh6emRxZ09qUDNhSDA2WWc3RHBPUWRsaWExTHlu?=
 =?utf-8?B?K0NrbFh6TnhXVXRYME9jNTAvUlFUT2Rzakhwd1BrZzdNYllmRDlOdEZrTTJC?=
 =?utf-8?B?aXhadk1XR2dseWhDVkdyUDAxTnBlMkVGVTdYanlSOHRkUGV0OG5YTWhDSEhR?=
 =?utf-8?B?OGpMbDBDRmNwczZkd01XTVMrVDB4WllnRWZodW5qKytLY1RLYUZVcFZaRCtr?=
 =?utf-8?B?bFNoRGlLZkZKK1NrV0xUTEFkWUNSOEpkR1YvLytSUW81ZUR3Z3Q3ODNwMmpD?=
 =?utf-8?B?aTJPTGNVdVF6MVJFN3hVOExYbDFPaEdvRXRJTUp0dk1NZ1h0L1BRK3ZtUTYy?=
 =?utf-8?B?Tk45RmZOSzJnZ1B3bmZGbytIMXorUmVVSDZycmhVSURNb2ZRekE3eVVyZlZI?=
 =?utf-8?B?VGRXeXZEdVBEaU9wRGhLVElwclI0RmNWVzRSN3pwLytsTmJSUDgrU0hobEVs?=
 =?utf-8?B?eEtSQ1BHbkZ6Y29tOHBnV1R4dmJKeEZPbzNtUkwrQWV5TVNmUVV6Ylp1d083?=
 =?utf-8?B?VXVSeEJMMThmUFNrSHR4V0RkYTRQbGp6Z1VWWVhacitQZzJGQ3MxdXpyUEVC?=
 =?utf-8?B?MThlcENXQURkTnhrWDliNjdreUlQWkFWaXdid3M3dk8zT1Fxbk9tSUtyRnl0?=
 =?utf-8?B?MGc1Y3N6ZTQyVG1lT1JVbDA1NDBoTlA5OHVxWStMSWtkeWZEUkhvUXZZRXpE?=
 =?utf-8?B?dElYZmQrN1hxTTFoTVZNZ2R1VlJJVHlHaXJFb0pzNTRQQlYzT2Y2enk2aGZH?=
 =?utf-8?B?Zi9zQUNZa2FBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(52116014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RVlTRTU4MWYvaXlOUzVON3h1c3g5YkhGUUJRN0lyODJPVWh1akVyNzc2bURN?=
 =?utf-8?B?QnhPdlk0S2pGT1lKdVZvQkVieVZvRnBHc1hEaFNDUER0YW51TVJjWWFmQU5G?=
 =?utf-8?B?WWxMNEFPaVdQNGtCZ00ycWVsOWIzNFRxOU5CSytzbGVaY1BHN29VMzBaWXF2?=
 =?utf-8?B?RzNzUDJsdzJqMUdKWnhxWExrVElFcXpFUFV0UzJ5b3lwU2toWlk0RXBwbmdl?=
 =?utf-8?B?TGhJTldKYVZGelZSU2dxVUVPV0lxY3cyc3FUejh4cnYydGh0Sms0eWlhNUlq?=
 =?utf-8?B?RXNCYWVBQ0Q4L1ZEdCtuV2NpU0NMaGtrazEvR25hNGVkc2FEUmYya3NrUkRV?=
 =?utf-8?B?R2hYNFdLdUIrVEhqc09aL0JaZUJvOGhqclBITXdSQXlIb2h0THl5SmZoRC9T?=
 =?utf-8?B?YjlvTlViUEMvN05hblNwczB0Q0Nzelk3bE1jbjUvYlVHWFBjdCtlMXB2WElx?=
 =?utf-8?B?bTdLZEVTaXNXTkNLUGFmOHNMQVFaUytvblFSOVUxU1JMSkE1VjNUc0JpUnRQ?=
 =?utf-8?B?UVY4WCtYVVVIZWMzcm5uRHZPakVLbTI4dXEzRG5aU3NvY241OElVZGpxYWpZ?=
 =?utf-8?B?TUdBQ1JvZUJuNFo5UDB1SjduUWc1UE0vZHcreDd3OXZHaW1YT0FiQ0tGL1FV?=
 =?utf-8?B?Tml5NlRWakFhWWtvV2V4Rmt6R1R2dk4vTGNqODBQWGRMUEs1WkUzYkN4WjA4?=
 =?utf-8?B?cHlvZU51OElDd0hWY2JzWUgvZmo4ZFVIMk1IMmRvb0ZVTklGK3NDWU5Ld3Vh?=
 =?utf-8?B?T0UrS0JrMVQ5bTY2UTdjMkJpTFQ3eUVQTEpEeWx5MDZoNUVOZXpnSUhYSW85?=
 =?utf-8?B?WVcvNmtMWkdnMnd0ZnB0Ung2NnB0NjNhbGZpREtRWDFLVWRPYU9FU2tHenZ1?=
 =?utf-8?B?UWVaQ3FQRHF5SFI0OXh0c21LTUtSUGk5R29Wd3JxdC95UHNUTkIzVWI5VzUr?=
 =?utf-8?B?K2JtL3FrN0ZSUDduZEZQRXNaTitYM1N3ZVljdnBuaWRSWU5qVWJqVlhaMU8x?=
 =?utf-8?B?eUlkc3NXOU0zR3RzOVdjdHVDWFMzM05Ea3dtYWo3ZU1qd3AzUXA4NjhGdi9s?=
 =?utf-8?B?bVo1QXY1cDUyY1BFOXJKWXprdmhuVEFXdWh1ZGJud3kwcWtNV3c4RW52b3lm?=
 =?utf-8?B?N2FjeWZCTW5STUp2a0xNUC8xWVpCalFzMmpOc3gyQnJrbUdubHNOT1JIY3Zo?=
 =?utf-8?B?Yk1CMUlwekVTb2c3RHQwYWRNMVhYdFVockp0ZjJzK0k0NWtVL25adE9HNjNE?=
 =?utf-8?B?UUdPcElIYkpOWFBjdWcvY1hOeEFjUkI4WWdFam4yK1FNbzdERkRIRXZsdWtB?=
 =?utf-8?B?WjlpWjJMQUpHTFFpODNKeU42VTB5ZWhuNFd5MVVBUjhuRzR1WGFDZVhwZDBw?=
 =?utf-8?B?R3pBYjdMNzVvMTZra0hzR2NVVUVRdGJldEErUUZFQlo5b0JyT0FqOWgwenZq?=
 =?utf-8?B?Q2d2OHVBQTQzWDZrWUZvYWdJYTRuK0ZTNkU4d2t2SFcyc0xjODl2ekI2QXBv?=
 =?utf-8?B?L0FsUFhEbEtJamhqTjFCOWRZcHpiT2tCNmNuUDVrdHZ5Z0N3bHgrbmwrWERR?=
 =?utf-8?B?UmgwcFZaL29YSWZFaXduQUd3d1YxK1FOZ2lhbDRBdXllOTBDNEZmdU5ZcVor?=
 =?utf-8?B?c3ZwVnR5Vmc5L2Z4U2JETUw4Q1FIejBkY0h3MU9ya0RUUFIwenN0RXM3RUR5?=
 =?utf-8?B?RXdoT2Yra2w2QVMyU0dUMTAxRy96czlOaE56VzEyN0FVWlZrN0tyaXNiSjBv?=
 =?utf-8?B?SlJWQjgwL1ROaGpyWlFiendVTVBrVkszc04wVEoxVTNnMEI2LzN1TjlrYlZa?=
 =?utf-8?B?U2N0TmRSYzREMVdGUDNvS0x0MEJZWVRLN3d2N1k1SFFFQS9hWVBieVB6N1ZN?=
 =?utf-8?B?VFpOYllPQnIwZVRxRkxXazNFTFBnVEVRZ2ZEbDcxQWRWNkRuUnRkSnVKRW1Q?=
 =?utf-8?B?WU1tOXAwSEpPR3R3cEo2cHdIZzFuSkYreVcvZXZ3b3JDT2oyeXlqN2hmNlJa?=
 =?utf-8?B?aXNaNmFLWTRkUTBDMk1lWmRZaUNMblN2Y3Q3KzU4b0VQYnAzL1VqaWducTFw?=
 =?utf-8?B?amdDeHk2cFE5Vmlnbk9kaisrYXB3RmFWVWJGM2FQLzI0TkM0OTFISWJ0VTFX?=
 =?utf-8?Q?IuVbccGnG/0XcaIy9l9BeFg/8?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea66532d-5ed5-42da-e76b-08dd82fa24a4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 06:35:02.6952 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3l4I5C0woR0rLtoqlclgHOrNn5QKy5+d/E55IHrTlBwcjUcbPtgAubtG8qBWI6LIMkbg3AKFyrJ1u+03NugB3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10661
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

This patch adds V2X container support for i.MX95. Since V2X container
may not be included in ahab-container.img of i.MX95, check if V2X
container exists in order to get the correct image end.

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/mach-imx/image-container.c | 119 ++++++++++++++++++++++++++++--------
 1 file changed, 95 insertions(+), 24 deletions(-)

diff --git a/arch/arm/mach-imx/image-container.c b/arch/arm/mach-imx/image-container.c
index 2afe9d38a06..f84e23f4b2a 100644
--- a/arch/arm/mach-imx/image-container.c
+++ b/arch/arm/mach-imx/image-container.c
@@ -41,6 +41,52 @@
 #define FUSE_IMG_SET_OFF_WORD 720
 #endif
 
+#define MAX_V2X_CTNR_IMG_NUM   (4)
+#define MIN_V2X_CTNR_IMG_NUM   (2)
+
+#define IMG_FLAGS_IMG_TYPE_SHIFT  (0u)
+#define IMG_FLAGS_IMG_TYPE_MASK   (0xfU)
+#define IMG_FLAGS_IMG_TYPE(x)     (((x) & IMG_FLAGS_IMG_TYPE_MASK) >> \
+								   IMG_FLAGS_IMG_TYPE_SHIFT)
+
+#define IMG_FLAGS_CORE_ID_SHIFT   (4u)
+#define IMG_FLAGS_CORE_ID_MASK    (0xf0U)
+#define IMG_FLAGS_CORE_ID(x)      (((x) & IMG_FLAGS_CORE_ID_MASK) >> \
+								   IMG_FLAGS_CORE_ID_SHIFT)
+
+#define IMG_TYPE_V2X_PRI_FW     (0x0Bu)   /* Primary V2X FW */
+#define IMG_TYPE_V2X_SND_FW     (0x0Cu)   /* Secondary V2X FW */
+
+#define CORE_V2X_PRI 9
+#define CORE_V2X_SND 10
+
+static bool is_v2x_fw_container(ulong addr)
+{
+	struct container_hdr *phdr;
+	struct boot_img_t *img_entry;
+
+	phdr = (struct container_hdr *)addr;
+	if (phdr->tag != 0x87 || phdr->version != 0x0) {
+		debug("Wrong container header\n");
+		return false;
+	}
+
+	if (phdr->num_images >= MIN_V2X_CTNR_IMG_NUM && phdr->num_images <= MAX_V2X_CTNR_IMG_NUM) {
+		img_entry = (struct boot_img_t *)(addr + sizeof(struct container_hdr));
+
+		if (IMG_FLAGS_IMG_TYPE(img_entry->hab_flags) == IMG_TYPE_V2X_PRI_FW &&
+		    IMG_FLAGS_CORE_ID(img_entry->hab_flags) == CORE_V2X_PRI) {
+			img_entry++;
+
+			if (IMG_FLAGS_IMG_TYPE(img_entry->hab_flags) == IMG_TYPE_V2X_SND_FW &&
+			    IMG_FLAGS_CORE_ID(img_entry->hab_flags) == CORE_V2X_SND)
+				return true;
+		}
+	}
+
+	return false;
+}
+
 int get_container_size(ulong addr, u16 *header_length)
 {
 	struct container_hdr *phdr;
@@ -83,7 +129,7 @@ int get_container_size(ulong addr, u16 *header_length)
 	return max_offset;
 }
 
-static int get_dev_container_size(void *dev, int dev_type, unsigned long offset, u16 *header_length)
+static int get_dev_container_size(void *dev, int dev_type, unsigned long offset, u16 *header_length, bool *v2x_cntr)
 {
 	u8 *buf = malloc(CONTAINER_HDR_ALIGNMENT);
 	int ret = 0;
@@ -150,6 +196,9 @@ static int get_dev_container_size(void *dev, int dev_type, unsigned long offset,
 
 	ret = get_container_size((ulong)buf, header_length);
 
+	if (v2x_cntr)
+		*v2x_cntr = is_v2x_fw_container((ulong)buf);
+
 	free(buf);
 
 	return ret;
@@ -231,45 +280,67 @@ static unsigned long get_boot_device_offset(void *dev, int dev_type)
 	return offset;
 }
 
-static int get_imageset_end(void *dev, int dev_type)
+static ulong get_imageset_end(void *dev, int dev_type)
 {
-	unsigned long offset1 = 0, offset2 = 0;
-	int value_container[2];
+	unsigned long offset[3] = {};
+	int value_container[3] = {};
 	u16 hdr_length;
+	bool v2x_fw = false;
 
-	offset1 = get_boot_device_offset(dev, dev_type);
-	offset2 = CONTAINER_HDR_ALIGNMENT + offset1;
+	offset[0] = get_boot_device_offset(dev, dev_type);
 
-	value_container[0] = get_dev_container_size(dev, dev_type, offset1, &hdr_length);
+	value_container[0] = get_dev_container_size(dev, dev_type, offset[0], &hdr_length, NULL);
 	if (value_container[0] < 0) {
 		printf("Parse seco container failed %d\n", value_container[0]);
-		return value_container[0];
+		return 0;
 	}
 
 	debug("seco container size 0x%x\n", value_container[0]);
 
-	value_container[1] = get_dev_container_size(dev, dev_type, offset2, &hdr_length);
-	if (value_container[1] < 0) {
-		debug("Parse scu container failed %d, only seco container\n",
-		      value_container[1]);
-		/* return seco container total size */
-		return value_container[0] + offset1;
+	if (is_imx95()) {
+		offset[1] = ALIGN(hdr_length, CONTAINER_HDR_ALIGNMENT) + offset[0];
+
+		value_container[1] = get_dev_container_size(dev, dev_type, offset[1], &hdr_length, &v2x_fw);
+		if (value_container[1] < 0) {
+			printf("Parse v2x container failed %d\n", value_container[1]);
+			return value_container[0] + offset[0]; /* return seco container total size */
+		}
+
+		if (v2x_fw) {
+			debug("v2x container size 0x%x\n", value_container[1]);
+			offset[2] = ALIGN(hdr_length, CONTAINER_HDR_ALIGNMENT) + offset[1];
+		} else {
+			printf("no v2x container included\n");
+			offset[2] = offset[1];
+		}
+	} else {
+		/* Skip offset[1] */
+		offset[2] = ALIGN(hdr_length, CONTAINER_HDR_ALIGNMENT) + offset[0];
+	}
+
+	value_container[2] = get_dev_container_size(dev, dev_type, offset[2], &hdr_length, NULL);
+	if (value_container[2] < 0) {
+		debug("Parse scu container image failed %d, only seco container\n", value_container[2]);
+		if (is_imx95())
+			return value_container[1] + offset[1]; /* return seco + v2x container total size */
+		else
+			return value_container[0] + offset[0]; /* return seco container total size */
 	}
 
-	debug("scu container size 0x%x\n", value_container[1]);
+	debug("scu container size 0x%x\n", value_container[2]);
 
-	return value_container[1] + offset2;
+	return value_container[2] + offset[2];
 }
 
 #ifdef CONFIG_SPL_SPI_LOAD
 unsigned int spl_spi_get_uboot_offs(struct spi_flash *flash)
 {
-	int end;
+	ulong end;
 
 	end = get_imageset_end(flash, QSPI_DEV);
 	end = ROUND(end, SZ_1K);
 
-	printf("Load image from QSPI 0x%x\n", end);
+	printf("Load image from QSPI 0x%lx\n", end);
 
 	return end;
 }
@@ -279,12 +350,12 @@ unsigned int spl_spi_get_uboot_offs(struct spi_flash *flash)
 unsigned long arch_spl_mmc_get_uboot_raw_sector(struct mmc *mmc,
 						unsigned long raw_sect)
 {
-	int end;
+	ulong end;
 
 	end = get_imageset_end(mmc, MMC_DEV);
 	end = ROUND(end, SZ_1K);
 
-	printf("Load image from MMC/SD 0x%x\n", end);
+	printf("Load image from MMC/SD 0x%lx\n", end);
 
 	return end / mmc->read_bl_len;
 }
@@ -312,12 +383,12 @@ int spl_mmc_emmc_boot_partition(struct mmc *mmc)
 #ifdef CONFIG_SPL_NAND_SUPPORT
 uint32_t spl_nand_get_uboot_raw_page(void)
 {
-	int end;
+	ulong end;
 
 	end = get_imageset_end((void *)NULL, NAND_DEV);
 	end = ROUND(end, SZ_16K);
 
-	printf("Load image from NAND 0x%x\n", end);
+	printf("Load image from NAND 0x%lx\n", end);
 
 	return end;
 }
@@ -326,7 +397,7 @@ uint32_t spl_nand_get_uboot_raw_page(void)
 #ifdef CONFIG_SPL_NOR_SUPPORT
 unsigned long spl_nor_get_uboot_base(void)
 {
-	int end;
+	ulong end;
 
 	/* Calculate the image set end,
 	 * if it is less than CFG_SYS_UBOOT_BASE(0x8281000),
@@ -339,7 +410,7 @@ unsigned long spl_nor_get_uboot_base(void)
 	else
 		end = ROUND(end, SZ_1K);
 
-	printf("Load image from NOR 0x%x\n", end);
+	printf("Load image from NOR 0x%lx\n", end);
 
 	return end;
 }

-- 
2.43.0

