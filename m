Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14459C36000
	for <u-boot@archiver.kernel.org>; Fri, 21 Mar 2025 07:19:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6BD481C64;
	Fri, 21 Mar 2025 08:17:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="WV0BniVV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A42F81F45; Fri, 21 Mar 2025 08:17:10 +0100 (CET)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on20624.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::624])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC14981DDF
 for <u-boot@lists.denx.de>; Fri, 21 Mar 2025 08:17:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XtSCTo9lmCyvYq5JCIXchqU51d9Jfc7GQ7b11GoX9CeaNxJ0Qzj0g0Z69kWPnAwWo4xA8fbxhPoSAkeqpdCUHUKheqsDmgxM5zRvcUhhCL6r9b463Xh5iv2kDPkabSJE3524zLQZgwBEK592ODik15POScFgyKXV0dxqJr+CV+YjwCWQbIX1AAJdTUQtMLSXXBs3C3DkELK4YrVvIJT4OhHcmn/gXZYaHlrcNQLu0EPdNO9qG+JrHB8uamUTud8+np61aZ2wRce4vhOOal9Uol3MUO8X7ZmgtG4aGqREYDQxbVewl9ymjdyl7F9VvWpp0NL9vCYN04d1AWaBvg859A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t1fVCVg0dzc87boUETT220BFks8DImZRFUt7t8Bnmh0=;
 b=IaGRQTS1Goook/yjhtzpYpgYUw2b6GDhaui4kYHc3FZggMLV8VDbbukeGZ0PH0cJtGDYH3IcuoF/zplT9yN/AYdjgaitQ5YUgEfZimgrf7Dl3zB+t5qsqkSoPYuutxyyIRdZU6arPZ9hl78hODFmKqI1vVm03sz7d4wINnaZt/Rtky5S8NbrsTw5wwEdPK9zJEP+L9c1stl0XRGopaL/4J0Fwho3p121iIO7JHvRcTrJFbA6JFBwjAWfORVcsnXZBptzRXQzDU6Ig1+JxbJC8hhT9blcZJp7FiIrDyVQ5B2ExmEGKQIhSfnH0iBGzhlpiJaIg7887fHrwFGv2ywxYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t1fVCVg0dzc87boUETT220BFks8DImZRFUt7t8Bnmh0=;
 b=WV0BniVVvtUn1Ip74hS4vM+gcl1nBg56pzw69HAf45QufN8DXM+qTtMEX5qpDy9Lx6hpthavLehjhooXfkDBVbzBEIcZTLE7Vxv0YPtLkj6wLNZcV9Ohw4IosLOEIhnQM2liWK+7E5MC6DXkLLHcvs+As5zBjeVU/2rb4+PTh1KIYu3zQpQxtdEEu7eiKgAChpXR5z0pAuXSbPQbbKSrPbI2xZE3RPZvj4Y8gaMC6mGvvG2m6j/VHL7WdRmatFhtYRKPsW3oS/B35aNDlXm6jk08aqtCivz0Y2wvmjbaEELHwLVlFByDJdx1CkHL6OhqzqeELIWYqwGYu28aZTi6/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by GV1PR04MB10488.eurprd04.prod.outlook.com (2603:10a6:150:1d1::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Fri, 21 Mar
 2025 07:17:03 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8534.034; Fri, 21 Mar 2025
 07:17:03 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Fri, 21 Mar 2025 15:15:31 +0800
Subject: [PATCH v8 17/19] doc: imx: add document for i.MX95 Image Container
 Format
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250321-imx95-v1-17-f2c8ba815f89@oss.nxp.com>
References: <20250321-imx95-v1-0-f2c8ba815f89@oss.nxp.com>
In-Reply-To: <20250321-imx95-v1-0-f2c8ba815f89@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>, 
 Marek Vasut <marex@denx.de>, 
 =?utf-8?q?Lothar_Wa=C3=9Fmann?= <LW@KARO-electronics.de>
Cc: u-boot@lists.denx.de
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI1PR02CA0007.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::6) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|GV1PR04MB10488:EE_
X-MS-Office365-Filtering-Correlation-Id: dc576949-39e0-4bcd-5d50-08dd68486104
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|52116014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Vzh0ZExXOXdyc254V0pwZy91Nit3dy85TmZVSFRkSVg0cFFvaEk5U21DYllx?=
 =?utf-8?B?bnEvQ2Q1K3N0TWk4L0Flc0JGaVRkZk9YWE5xZDJhQ1Ruclkyd0dVampiMzRS?=
 =?utf-8?B?OVBYWkNlY3BNNGZYUmFzYVNmQWVlaThaSExSZ2dMRkptSjcxOFgvbjJ0YmtV?=
 =?utf-8?B?UU04T3B5bTlWQXdqZFRDcE1hUXNQMXBMc2JTdkJ4TVJpd2xKSjF1QW1TV2l6?=
 =?utf-8?B?RldzWmpNbkpTa3ZTNStEeFRZeXRjZFkrQTQxei9vUEVVYU1iQW1LU05XUVlj?=
 =?utf-8?B?STl6MW1zK0NtNkxmSlk5dmdoUFVkWXhOMnNrc1VLTXZNZm1EL2JaME1pUmtV?=
 =?utf-8?B?RVZaeG1DMnVMRjN6bmFZSW50bllBaC9MNm1IM051NUZUa1BoamNZRTg2djdH?=
 =?utf-8?B?ZktEQzkzMURlLzkrc25kWDZoNWw1cUpySWNlSHFRUm9BV0dsQTFnenVUR0h3?=
 =?utf-8?B?djlrSklSVTV4SEZOVXIxTjRiTjh1ZkVVM3ZIWUlPNSt0dnc3MmRGTlRwMENy?=
 =?utf-8?B?SzJJV0RyTjB4ejBXZGJqdVYyWGxLcUh3Z0VrVUlzTXRlOFZvVGdMV3RySUtN?=
 =?utf-8?B?dXlHOWpYOWxlL294VzdJTDBUTElzZTVYOHJpMzY4WmFBbUpxSU13aE1nSk5j?=
 =?utf-8?B?cWEyenZrN1hmempOcVd0bktRUlM1OWUrZVhUQUNZRHBOM3BtZk5MdG9NR0VI?=
 =?utf-8?B?M3U3di80YXFva2c1VDRlalg0N0hvTFFBa2FZTVp5b1dHSFF3dm96Q1h0MFZE?=
 =?utf-8?B?VnAzcUxNd2hGdG0xRmdkTE0wVUVpd3U3MWZWd2xEU2VMRFlDTnAxeDhNYm0v?=
 =?utf-8?B?OHlERXNwdkRjR3ZZTmxuQnhzWmpOajlYMHFkOUZqRlBUa2ZUQmRicW1ZTzIx?=
 =?utf-8?B?WmxPSXc0bDVmQVJoYksyNXBqcnVFK2IxelpVcHBoUTM5QTZDTVMvcXFLZXhF?=
 =?utf-8?B?Q0wvUTVZZFdlTGo3MTNNVUhuNDkxRnY5QmM1L3FVK2NybGw0QmhOZjB6MEp3?=
 =?utf-8?B?eExOTkZXRXNDVXVWYWZiNnM4VDgyOG1YdDRRRGlnWDEzTWNhUjR2KysrK1Zl?=
 =?utf-8?B?Y3RnVzNPdzhpK3lhNWNFYzNEVStDMW9MQnJqUmFkaEprY2ZFdEcyNUdyWTI4?=
 =?utf-8?B?VUpCRllhYXB6V3NpR1FUTDZNd3haT0E1WHRieXVsSm9pREVBOGZwOWR0MUtJ?=
 =?utf-8?B?WmEveHVtNUZWemYyN201ckFXYzU5SzFaMXhwWnQvblRUb0lFcVNONDlkbjhZ?=
 =?utf-8?B?NkpmakNLeXlTVXhpQzZwUEZwTWplQ25YVjVvaDZBK0ZZMENYR1RzK0JVN3Nj?=
 =?utf-8?B?a1lDVGFXenFqbmtoTHFxQUsxR0VsODVyR0R0ekZmeG5jWVpiVDZMbVlwUDYy?=
 =?utf-8?B?Rmc5Z24vbHNvZENldzl2K0F6R1RNenE3b3UrWDVTZ0g5ckNOTUMvT0gwWjlo?=
 =?utf-8?B?eW43TERGcDZKNnowNVZtQ28vS2hvVGhYRmxWTjZoOWRzdXYvUm5UenZxeWhz?=
 =?utf-8?B?SGs3eHQ4d0tHR2Mwd1ZLcGJ4a1ZLL2dXNW5OVTNsSnNKYk5HN3NpS2NjNFZ3?=
 =?utf-8?B?UlRmUStCZ2NCcTYydnFOYUpiYmRWOWtlZTAzUkNtcE9XVXBVWnV6Z3FhNEo5?=
 =?utf-8?B?R09nR2tkWnFOQWRTdEVpYVJCTU41bi9LbFRqMHZEZ0tJM3RZS3pqN2RndFJ4?=
 =?utf-8?B?bE5OWlhZTUdmZW4vZHJ4UjBGRS9ObThYV2g5MnA4NFdWektxSUxCcjc5OGZK?=
 =?utf-8?B?OWpxN0dRUnM2REZFYjhRdHhJNVlIc2xwVFBiRnFuRUc5eE42RGNxNk8wekZK?=
 =?utf-8?B?NXBsdEo4b01iSSs1aEQ1WTBnaWNjUjU4SjVISEhDbGh5Yy9IOVR6a2lVMmlp?=
 =?utf-8?B?WEFGOGxkNDc2M3A3M29wd3pKUVBoaHZ0UDgwNWdKOC8wOHo1dWtkWkwzS2xI?=
 =?utf-8?Q?lj4oHgR/gHIeCoQzcrOkflAEe+v1GxY9?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(52116014)(921020)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZVY0R1o2OERWY0tPbmtnRFU3dkxjUjg1L2szaGZtUWNyUTFqdlBlZ3dvbFM4?=
 =?utf-8?B?WHVXTTBIOTM3QkpuNDF3N2ZHcWJNM1BUaUIweTFWRWcwRndSWTRqaEtDUjVi?=
 =?utf-8?B?RktxWHN4bVcxd3F3U3orWWJDcS82SlJCcHM2VWdTVTJsaXJPai9MWk5GMXEy?=
 =?utf-8?B?MDA4UkpXT3dsbXQ2WFc1MGlmZGFNZC9sNTg2MXFiKzVpL09BR3BmOVUwc1ZF?=
 =?utf-8?B?T2lHa21mMElQMElEaGlJZk9KM2hMeG0yMlVvRGhMMitwNTFmTEQ3YWFLWXcr?=
 =?utf-8?B?Tm4rNGlHUkNqcmM3SWFjaGNyelZxNTVYMDArQzRsVHh3a0xLSS9DWVJMVWp5?=
 =?utf-8?B?K3pIanJ5YjV1bVBVVXhNR29aanJ2V1Qvc3IzdllWSE5TK0tmTFcwZFhQNVht?=
 =?utf-8?B?SWVOSmdvOUhEd2F5VFFKV0NJenJhT0Fhbk95QUJzaWtsNVNIL1dJUnpRTFNZ?=
 =?utf-8?B?SUk1bE9kQ0lYbXFGNktvSjB1bmZXZkc5UXUwRGFEYmw3dnBNK25LRi9PaVFq?=
 =?utf-8?B?UWlNU3JvT2pycnlTM3NqQmpabFpkYlBWZzNETGJMclAvQ1VVbmd6WXdXUHNO?=
 =?utf-8?B?VHhSUFFJTjFxU3BYVlZDRkN3WTFYNHl4bzFxTnVzREN6Y2M3Tis5TC9lYk94?=
 =?utf-8?B?eTlqcEd2MGVrQXE4QkpYNGZ2Lys0N1VXOFg3SUpNcEdtaTI2SWpBT1BYZlU3?=
 =?utf-8?B?cDVhS1gzb1BRUlowcG1OM2tNbzJ6UWpQWmkwWHE4dElHWFFST2REUS81Mnht?=
 =?utf-8?B?L0duQjJaa1puVE1CTHptR21WVU1KRjNFbWM1THU3Sy9sWDl5SmxYU0ZrMFp0?=
 =?utf-8?B?RDdVZDcxeFdsR0JrbFphWGh2bW0xaExKbWVKTmJTeEE2dTJ0c0c5WWZ1MGVw?=
 =?utf-8?B?MFV5VkJUMGhZUHl2QU9yRytGcklsak5MVjVVTHZ6UENOZ2czY09UYnB5SXRw?=
 =?utf-8?B?TVg0VkE0ME5HeWt5LytMZC9pNE0zaFBRR0hIYzl1R1ByTm0yOEpRWU5qYnZo?=
 =?utf-8?B?a0RRdzN4MnFZNjhwL0daYkdKYUJiMjc0eFRBekVEL0pDOTJXZGpIY0VTSmNz?=
 =?utf-8?B?aDNxT29NTVhSVG1FK0tsR05FQjN1bEZUR2JsejgrUHo2MlVmUlJVV2hySjFQ?=
 =?utf-8?B?TW11NTRKY3RDaHY4eHl6bWZ0TnliU1h6ckxUMUJUOUU3SERscGZTOE9UMWUw?=
 =?utf-8?B?NWREK3NHSis0TUdhR3ZvRWxhc0RidjBRbWpWbXRGejJ2YTVFR29XclhsQm5Y?=
 =?utf-8?B?ZEdXaSttQytiNXZ1OXVONmhtTDUyam0wc2VxTEVoSGV2eFZIY2plVndpWmNt?=
 =?utf-8?B?UEJCMVQxSkxEL1pqS2NxVzRDaGhaZlNtbjlrR095WFJCbGt3V1BHdEprMFFU?=
 =?utf-8?B?TTgrZy9DYmkyZ25JUkVGUC9DdkVGcGlIeEQxcCtZOWlXVldhdWd5akpBVEdB?=
 =?utf-8?B?SWo1V1U1SGZKR2cvNUY5UnhSRVR1RDBuWExSaTI4Y0RsK3hScS9iVzFtaUl0?=
 =?utf-8?B?Zi82Zk5wc29tUTJ0aWVMOW05NWRiVWNJMUp1VFNTanpyQkg3eGE2dnpnbkc1?=
 =?utf-8?B?Y2VHT2p3Rm5WVzVOTjZwcWduSDkrOFBPM08zOHJIU1dpVjh5OW1ZR21zeE82?=
 =?utf-8?B?TnhUaW40L05sZkxManVCM2hRMTdTVk1hNTFmZTViYmtwZnFYc0hKb0l3ZDB6?=
 =?utf-8?B?QTJKZ3FVTkdGckF0Zy9QaDFaSENnNm1mWG9veGZZY2x1LzQ0R0o2K0lYMjN1?=
 =?utf-8?B?QlREVkd0Z0VGbGg0UXY5bHhKSW1aZnJUVXNFaXpSYk4zbjRESVFrUm1Ea3lF?=
 =?utf-8?B?WCtHV0JRTndhMjZrcTFGeWJUejBORGY2TS9pU3h4VjcrMWNNeTIxdXg1dmc4?=
 =?utf-8?B?eU1nWGNOb0NibGNsNlMvbEMrRTR2Zk9Od0RhRCt4TkVNblJyZy8vQUpGaTky?=
 =?utf-8?B?R25LYnQwY2VaWXNvVmR3MmJBbXJJaW5OVEsrODU5YTd1M3pyTTIrUHE2cmJU?=
 =?utf-8?B?MkxqamFMWHhSTVpPVHBISWR6bDBkMTJjSWJ6OWNOaS92WXdWY2hURUhmVHZG?=
 =?utf-8?B?a2k3dEU0T2FneFM4cTdlVmM2Z3h4clM5b1M3d05CcmpUTDUwV0RCYkZpTjhJ?=
 =?utf-8?Q?t1MehbA/wgUS40yHYkuZPwpyL?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc576949-39e0-4bcd-5d50-08dd68486104
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 07:17:03.2820 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n9feWe1EdZ538jqNNM7I9ofT2zqAZsCz/8g9ZK5ibJiG5kc7TWF9QrySGV330cBxPIYxEZJker6LULfy6eKiLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10488
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

From: Alice Guo <alice.guo@nxp.com>

This patch add a document for i.MX95 Image Container Format.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 doc/imx/imx95_container.txt | 136 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 136 insertions(+)

diff --git a/doc/imx/imx95_container.txt b/doc/imx/imx95_container.txt
new file mode 100644
index 00000000000..2ad57345069
--- /dev/null
+++ b/doc/imx/imx95_container.txt
@@ -0,0 +1,136 @@
+i.MX95 Image Container Format
+-----------------------------
+
+The image container set consists of some image containers, and image container
+contains boot images. Each image container has its own container header which is
+defined in Figure 1. All container headers are placed together in a continuous
+8KB space at the beginning of the image container set - image container set header.
+
+ROM code addresses image containers in image container set one by one based on
+their headers’ order in image container set header.
+
+If ELE container exists, its container header must be the 1st one in the image
+container set header.
+
+If V2X container exists, its container header must be the 2nd one in the image
+container set header. V2X must be combined with ELE container.
+
+The information of boot images are recorded in image container header. System
+ROM code needs to retrieve the information from the image container header, like
+the offset on boot source, the target address in RAM, the length of boot image.
+The order of ROM code handling these boot images is based on the order of each
+boot image information present in image container header.
+
+Figure 1:
+------------------- +--------------+--------------+--------------+--------------+
+          ^         |Tag           |Length        |Length        |Version       |
+          |         +--------------+--------------+--------------+--------------+
+          |         |                           Flags                           |
+          |         +--------------+--------------+--------------+--------------+
+          |         |# of Images   |Fuse version  |SW version                   |
+Image     |         +--------------+--------------+--------------+--------------+
+Conatiner |         |Reserved                     |Signature Block Offset       |
+Header    | ------- +--------------+--------------+--------------+--------------+
+          |       ^ |Image0: Offset, Size, LoadAddr, EntryPoint, Flags, Hash, IV|
+          |       | +--------------+--------------+--------------+--------------+
+          | Image | |Image1: Offset, Size, LoadAddr, EntryPoint, Flags, Hash, IV|
+          | Array | +--------------+--------------+--------------+--------------+
+          |       | |                            ...                            |
+          |       | +--------------+--------------+--------------+--------------+
+          v       v |ImageN: Offset, Size, LoadAddr, EntryPoint, Flags, Hash, IV|
+------------------- +--------------+--------------+--------------+--------------+
+                    |                            ...                            |
+        ----------- +--------------+--------------+--------------+--------------+ <-- SignOffset
+                  ^ |Tag           |Length        |Length        |Version       |
+                  | +--------------+--------------+--------------+--------------+
+                  | |SRK table offset             |Certificate Offset           |
+                  | +--------------+--------------+--------------+--------------+
+                  | |Blob Offset                  |Signature Offset             |
+                  | +--------------+--------------+--------------+--------------+
+        Signature | |                         SRK Table                         |
+        Block     | +--------------+--------------+--------------+--------------+
+                  | |                         Signature                         |
+                  | +--------------+--------------+--------------+--------------+
+                  | |                   Certificate (optional)                  |
+                  | +--------------+--------------+--------------+--------------+
+                  v |                      Blob (optional)                      |
+        ----------- +--------------+--------------+--------------+--------------+
+                    |                            ...                            |
+                    +--------------+--------------+--------------+--------------+ <-- Image0Offset
+                    |                           Image0                          |
+                    +--------------+--------------+--------------+--------------+
+                    |                            ...                            |
+                    +--------------+--------------+--------------+--------------+ <-- ImageNOffset
+                    |                           ImageN                          |
+                    +--------------+--------------+--------------+--------------+
+                    |                            ...                            |
+                    +--------------+--------------+--------------+--------------+
+
+i.MX95 Low Power Boot Image Sets Layout
+---------------------------------------
+
+    Image container sets are handled by M33 ROM.
+
+    --------------- +--------------+--------------+--------------+--------------+
+                  ^ |                    1st Container Header                   |
+                  | +--------------+--------------+--------------+--------------+
+    ELE +         | |                 Padding for 1KB alignment                 |
+    OEM           | +--------------+--------------+--------------+--------------+
+    Conatiner     | |                    2nd Container Header                   |
+    Set           | +--------------+--------------+--------------+--------------+
+    Header        | |                 Padding for 1KB alignment                 |
+                  | +--------------+--------------+--------------+--------------+
+                  | |                    3rd Container Header                   |
+                  | +--------------+--------------+--------------+--------------+
+                  v |                 Padding for 1KB alignment                 |
+    --------------- +--------------+--------------+--------------+--------------+
+                    |                            ...                            |
+                    +--------------+--------------+--------------+--------------+
+                    |                 mx95a0-ahab-container.img                 |
+                    +--------------+--------------+--------------+--------------+
+                    |                            ...                            |
+------------------- +--------------+--------------+--------------+--------------+
+                  ^ |                      oei-m33-ddr.bin                      |
+                  | +--------------+--------------+--------------+--------------+
+                  | |                      ddrfw-header.bin                     |
+                  | +--------------+--------------+--------------+--------------+
+                  | |                  lpddr5_imem_v202311.bin                  |
+                  | +--------------+--------------+--------------+--------------+
+m33-oei-ddrfw.bin | |                  lpddr5_dmem_v202311.bin                  |
+                  | +--------------+--------------+--------------+--------------+
+                  | |                     ddrfw-qb-header.bin                   |
+                  | +--------------+--------------+--------------+--------------+
+                  | |                 lpddr5_imem_qb_v202311.bin                |
+                  | +--------------+--------------+--------------+--------------+
+                  v |                 lpddr5_dmem_qb_v202311.bin                |
+------------------- +--------------+--------------+--------------+--------------+
+                    |                            ...                            |
+                    +--------------+--------------+--------------+--------------+
+                    |                      oei-m33-tcm.bin                      |
+                    +--------------+--------------+--------------+--------------+
+                    |                            ...                            |
+                    +--------------+--------------+--------------+--------------+
+                    |                       m33_image.bin                       |
+                    +--------------+--------------+--------------+--------------+
+                    |                            ...                            |
+                    +--------------+--------------+--------------+--------------+
+                    |                      u-boot-spl.bin                       |
+                    +--------------+--------------+--------------+--------------+
+                    |                            ...                            |
+                    +--------------+--------------+--------------+--------------+
+
+    --------------- +--------------+--------------+--------------+--------------+
+    u-boot-atf    ^ |                    1st Container Header                   |
+    Container     | +--------------+--------------+--------------+--------------+
+    Header        v |                 Padding for 1KB alignment                 |
+    --------------- +--------------+--------------+--------------+--------------+
+                    |                            ...                            |
+                    +--------------+--------------+--------------+--------------+
+                    |                          bl31.bin                         |
+                    +--------------+--------------+--------------+--------------+
+                    |                            ...                            |
+                    +--------------+--------------+--------------+--------------+
+                    |                         u-boot.bin                        |
+                    +--------------+--------------+--------------+--------------+
+                    |                            ...                            |
+                    +--------------+--------------+--------------+--------------+

-- 
2.43.0

