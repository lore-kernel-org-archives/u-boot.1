Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5940FC35FF3
	for <u-boot@archiver.kernel.org>; Fri, 21 Mar 2025 07:18:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C49181EEF;
	Fri, 21 Mar 2025 08:17:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="meNiy3cJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3CF7F81C67; Fri, 21 Mar 2025 08:17:08 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20627.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::627])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D30568129F
 for <u-boot@lists.denx.de>; Fri, 21 Mar 2025 08:17:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i4U3MNrmD+CD3CCwrXhRX0SF0+tKziT7ncCDWHOcuzMuT3xbRWTuHmIF5kd7Ww3qZW9ArTb8RQOQz1SAXydC4Anit1A50d/3sIt/5zwBa2kT1LZOoQ2V/Fq5aRmY3q7lLlfSU2Gjy2ikUWmoIqjDqxY5+j+aVtLnIaemSa4z4tPKTPZzg0rqjFnxn64U4b3gdthbTOo9YmlGx630gKRnTxpLORDm1ZDr6CKvgvVOKAgYpvUcPknDEaD/GZiKpzsy2ETmGMk4wHsw6zXC4FXzzPmniFdekOk901EeWdnh7oGNUpnC4VYpGG9Ht2qHz4hmmtQvdZ5I4vGLnNlyncEP8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JKl8J0d5zTpvtomJ//rF2TLAfp0nZ4qBCJG0OxCcboA=;
 b=xwaCxoKIqShxsRJaTPJq12Wq5E5Ot0Ngg8/OgpZ03d+8wWWsS2jLmX8DBqkQGobwT2oPP8oQM8bXVxeeZO5rnIYzf419plR2r9y4BqLo4qJxfajO18CBrupbQFlNOeJqKmVpFt362xDIrGB4rwsCtQuIrabN7X14pRfOJX26SW+Hg5Nv+dbUuDjZkkKGiOhGrAxwP9XVWIZ0GVCCJQsPLBtLmdvtR+nNB/B1HkFMg+u1sPgBy3Mod/RAMGXP1OpSuExI6UGnlVHEa38RiXh1Olk4fGzjD8ZkPQN02G7LKycRmYYmdMHfzE0Zs4UGHe11QwAw8h5d65c+WSOh0q4gSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JKl8J0d5zTpvtomJ//rF2TLAfp0nZ4qBCJG0OxCcboA=;
 b=meNiy3cJhlN2mYlVqoYtuuerpLM2g6RFl929CeI8znxMXI6XxXrtRtRd/qFz3cZ8CW8w5UmqmJCmTcHzPLIrg4NmcwxMJ8KKqSun3/sFv6Aq8pbl6YFyqw3yPyDAmmxrUQLmhw1CH+ADwZ3+Gcu+OcjJJ+VQljb0mPwsvjKFOe4c3wv7mHBvARq/7Epv3G40hIZRFgcUagKU+GuXpMJ1VtMrCTZD9qUQkRytyWDVTGXmKk+31XgEr3Rn6F1vrE9chm0mhVsGfaP8s1PG2sD2jF47EIsx8vYY5rQwegYeXRRxOC6fWFINVVzC/HJ1ik5CrN6GNh5VYcCbbEAPb/tvHw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by GV1PR04MB10488.eurprd04.prod.outlook.com (2603:10a6:150:1d1::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Fri, 21 Mar
 2025 07:16:55 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8534.034; Fri, 21 Mar 2025
 07:16:55 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Fri, 21 Mar 2025 15:15:29 +0800
Subject: [PATCH v8 15/19] tools: imx8image: add i.MX95 support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250321-imx95-v1-15-f2c8ba815f89@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 937aee41-3a6a-40ab-4521-08dd68485c3c
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|52116014|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VWVVWWluZzNPTUduMXZSaUpjK1RnaDBBZDk4aWZqRWExeUJnK3IxNFpCRStx?=
 =?utf-8?B?amx2bGxiemFaRHpaQWtZK3F6UWxnYTl4c0R3RFBSRVpDUkdQQUN1QzdNc2c0?=
 =?utf-8?B?K0NuRTlkV3hydzAybjBtL0pBS0VpcTB2bXk5ZzdYUkJjSGpKYzhQbkF1cm53?=
 =?utf-8?B?Q3NDNlRDMTFhSmt2TXphYlFHcS9xcVo2cVBaekthRWFISlNNL3lleG03T2tT?=
 =?utf-8?B?WlZMM0g1VEJIYitJMVFSRlJQVVdUUk9YT1FFUCtGYzlpVVRsRTJyY0p6OWJy?=
 =?utf-8?B?TVZYUitMb1lwQy9JcmQ3QVY3WTUwdktzbWVYRUZyZjRlWk9ZVklzakcxd1pH?=
 =?utf-8?B?NUtBOXUxNW1ZM1BKcS91S2trcVFHcFpOcUlzS2hObVZDbkowTFFIKzd1YS9m?=
 =?utf-8?B?V2k4a0tzM0I1am5Nd2RERzNhT0E0a3RVR1JCTXdQNVlubFBWZTYyOFM5bno3?=
 =?utf-8?B?TStLSVpPdlA4QVhwVCtMa3VVR2QzMTQrREE5QmJaQVl4aW9aVGdwZ1RkS3ZH?=
 =?utf-8?B?U25JNy9SZTVnZXVwL0tUNFZZWE51Z05zT3l0eEpTT1RFa3p6YWF5TUZoWW1n?=
 =?utf-8?B?akF5bGFTL3dPTHV1ZnFoL0NmNUFrc0d5TUxHTzVTVU44NkxrWUxTU2dib0dE?=
 =?utf-8?B?TUNrOG83dVR1QytZWjJNMnVmeTlJNTRub0p0VzNQZE92K2ZJZHVrS1VwaFph?=
 =?utf-8?B?V3pCNGQ1eG9zTzZBZGZEN3EvS2hSd1UyTGNEbU1QS3ladDlwWDRucGJGa1JI?=
 =?utf-8?B?NUcxc1NQRjRMUlczS0laYXBJSTQ0YVllenMrT0lVYzEwMVVhbWZpSHNpdDlF?=
 =?utf-8?B?WWFnTGltYk9raHo1OUF2Sk8vQkVValpiS2h0b2xBVnpQL3BVZmFYN2Q4RzRs?=
 =?utf-8?B?Q1RFdGlTMGR1eFdHMGRlY2RJZFBDcGlmSkRWWjUyVm9aTU80MmNUandGd3gz?=
 =?utf-8?B?RzA3OU94ek9ZYlpuV1VvdGlXQ0dxR0IxTTlyaTBFT3JmRE16SFN6N1Y1Y3FS?=
 =?utf-8?B?K280LzFJay9iSEt4VElEQ0lXZEtOSm1jZ3Vhem41bWJrdHY5Nk1ObnAraXRS?=
 =?utf-8?B?YnBQbFBGOEpkUW4vQzRGTjRoN2t6YjlrRUNBNDh2NkZ0UnJGZ21uNXRQRGpl?=
 =?utf-8?B?NWlyME9OZEdaSjloN1puVEduaXR4VjhZRnRiRkFRUUtXWmQ5cmtPT28wejg4?=
 =?utf-8?B?OUEzQWFIakVTWjBsRnpSSmZadmFBb0U3REptckx3ZVVmOHV1L0dPSHVScmlo?=
 =?utf-8?B?aW1nUmdFSllaM3RucnJvZlRnczM4Sm9YNEJGdVZaNmhyTzQrQzZwU3RQZVc2?=
 =?utf-8?B?WkZ1ZFN3WVFWUVVzNVVlMTRHYUJjcEZmakE3YSthRXpzSXh5SWxQaUtSUDlo?=
 =?utf-8?B?VXNNTmt6OWR0NTVta05NUjBYNThZdjd4c1FIeEtwUVBYV2RFWVVwQXh5amxW?=
 =?utf-8?B?Tm5VL1ZGVVljKzN4KythUC9lNE9Kc1dleDh4Q0VvRVNTeHFNVzhJTVFvbG9U?=
 =?utf-8?B?WTNPMnVzbmx1Z1lZU1Q3VHg3cmhaK2Z2THhqZkZRZEwvOENyQkFXRk9wQzBn?=
 =?utf-8?B?MWZqb0JFd2lWMTBaaXVTSWo3QWRiTGRVWFFzK1R3SUk0UWFETkltam9Ncktn?=
 =?utf-8?B?VW83ZnJzZHNaSWVWWi94b0Y2N0haZnpzRUVRV1RQc0grdmpDSExvZ2pEMXZQ?=
 =?utf-8?B?eUVacnQ1eVVwMHhlT0NNTUhBbUg2d29IYURCczR5QjZ0UkVnc25tSE9Jd3FN?=
 =?utf-8?B?OFBic0JLMFFOWVY4SkVCM0o0dnpHcnBxSVR6Qk9seHBHKzkyQjVRWjZUK0w2?=
 =?utf-8?B?ZGV2SFZHRjVMSjZyMWo1OEw0aVN4Smd0cThMWWxkUCtOYnNxTVpVRk1ZcUFm?=
 =?utf-8?B?RTE2MGl4UjJDajk4cEdzSXZlaWRGcU02QlZxWVRoV3VPTTBwbVR0ekxYL0U1?=
 =?utf-8?B?QXBSMEw2Q3VQODJkb0piRm5tcklkbGN5NEFPUDZjeWhJa1c0ZEVzcmtoR0Zj?=
 =?utf-8?B?VHZwcDU1cUh3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(52116014)(921020)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R3VPdHRnUUY4OUpJZ3luZ2dvVzRJK2QxbzRGSnJMZ0NrTCtZcG9Vb29RSm5U?=
 =?utf-8?B?SUtpWkg3WExjMWtWWnpITGJPNmtVcjJtU2hEUi9TaHhDU3lZSno2NkNEWW01?=
 =?utf-8?B?WVlIaTZNVll6RmlFNDdPSXo1NmMwdVdsUDhCOGo0K0JBV3FWQ1hWamxzemhz?=
 =?utf-8?B?S2hOZzhkNW1zNmdiN3Vtdkp4eXNQL2JDZHlXK0lGRnR0OEZUOHJmbU1xZmNQ?=
 =?utf-8?B?bkFXbkRDZFNXLzRkbzFPZDNCNlE2OVE5bHlxTFFTVnZyYzErR2pyN0NZTml3?=
 =?utf-8?B?RUltUnlTYnp0dGVoTVpiTFp6T1JiRFZ0WndhMWlIOGpRQXNKMHV2VDJNdXhs?=
 =?utf-8?B?SmVkRXgyZzNYZXcrQ1dFSHdNQzBZbUFyRDlOSVNOM1pER3JIaGwxMjBsNGxm?=
 =?utf-8?B?Mml3MXp5WlRRakFhRkE2MTBsaHp2dEFGR09YcTRwV1l3MVN2dUNhSlRVbHpW?=
 =?utf-8?B?MlZrdDZoNjdPUVkvQnl5bWhhQWhVYU5wd3VlMVhqMk10bTltdUsvVUtDaG5o?=
 =?utf-8?B?ZmhNd3lCaVN5VjNTVnpCSSt6eUpwaU9YUHNkd2JzaXVlYVN3M0piT04wUDJw?=
 =?utf-8?B?S1NJT1d2Y1ZyeTR5UUxNSHZueTVPM1pGSDBMVEt3Uk9nWGhLVklzZFlwM2pX?=
 =?utf-8?B?b3U4cXYzR0RkSW9xVzlhRjMyeHl4OGk4RUtyN1FrclE0cm9Wdmp3c0QxeWE3?=
 =?utf-8?B?SFFvTXVERU0vS1A3Y25nbXJ2dXd4N1c3ZlpJcXNWS3NOcXVQcWZxWGhpU1J2?=
 =?utf-8?B?QzUxWWRDVFR6Z0o2VE9wWDBqRjNOZ01CV0NDUDdXd1lMTlN4NkhWdzFHM2t3?=
 =?utf-8?B?U2Uvb1gzRmNVZVJlc21rRUVLYmFPRitDVk41cWpISWtpTHZic2xueUp2R1RF?=
 =?utf-8?B?YytCdVVTakJndDZoU3RUS3ZkMllzRGxEVExpS0d0dlhlZUp6bU9rTXBvWkQy?=
 =?utf-8?B?QVorWmtSaTBrbzJtZ2F3YTh5QzMwTzdsVEtBMlluaVJtYmxNakIxcTkwNVlH?=
 =?utf-8?B?ZTMzQnlQeHV0KzhmV1NOeU14dmVGQWhKVXlsQjA3UTNnUnN2V3BLWjBXVGJr?=
 =?utf-8?B?ZkU3MEtYOTFhcWIyaUp6SDl2NnB3eDA1d3Q4ejM4MjNQZW1uYk53ZWswUmMr?=
 =?utf-8?B?SmdUUTE3RjhpNkV2b0Fjc3o2Rjd6MlJIV2Jud1dGUVRod3Ftcm12OGhCbHNQ?=
 =?utf-8?B?aCtpRTkxci9JSVQ1OWFVNG9XR2lESGhyaHU5UlJPaC9zejByaHE0SkpkUzFv?=
 =?utf-8?B?MCtWTzNOQzg3UVY1NTd3Z3lOejhBMVRjOWxpTWpyS2NBaXV3enNESXgzTkNE?=
 =?utf-8?B?S1labW8rdysvNUl2aXBMd0cwTjIxd3dWZm9xVU14RTcweWo1cHVTZitFTEpa?=
 =?utf-8?B?S0hoQlQzWDM1MnpmWnFpejNaVjRUaHNOdnArQVR4LzFHViswdmZlWS9kTmZG?=
 =?utf-8?B?c2xLb01EVzBRU21URll2L1lvYjI1VXJlN3p1ZGJ3bkgrZmYyZ3NXWWxWZUFt?=
 =?utf-8?B?MzF6WXZ0elVTRWJVbEpTVGNOdlJITXQwWjY5Ny9xWWg1YWk3TTBzVlROUUNr?=
 =?utf-8?B?eTM4eW5uVGl6amkveklEN0k5S0hJZUpDT252WUdNMERDU2d3a2MyTnRlRWRw?=
 =?utf-8?B?NU4rZVhjMkZqbWVjTk44UlJGT3dXKzY0emdxL21vY2hmQzU2MTZoRzlwankr?=
 =?utf-8?B?MlRxNlBrbDZKNHJwQjd0aHRSUW4xMmZCOUJXLy9uTjQzeThFYmc0QkhjZXIy?=
 =?utf-8?B?NW16SFBaNkxZbWxXRUdYYTVMNUVCa2RET3JXWURrelpDdExNa1VkVHlxSGVT?=
 =?utf-8?B?eWJIc1pQZW5KVzZaNEhRNlRIMWV5bkNudnJ6d2ZXck1BRE1kZWVvOW0yWVMv?=
 =?utf-8?B?SWhzckVnSTc0YkV4MkRBZEZnVnlMNkY3LzRNYW5zRWtNclhVYW5yRlhpeEUv?=
 =?utf-8?B?aWpleHNlNXN5M1lsUHpSKzlCR3pvSXN2RGRrSmpZWWNPM0w3Yy9TdjYvMVcw?=
 =?utf-8?B?T3JycUlibWtXQ3VEL2gxTmNtWkxrWDgvYTduTXRKM3BzOE50OXZ6OVBwd1pC?=
 =?utf-8?B?RXMvZTRhZmh6dlJLSUJkUGFFRWI1MUVXZ2EzdjZEK0ttdUxGT2plb0xQSE5R?=
 =?utf-8?Q?8WVhkps38N9Gkebz9nH0AzH4d?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 937aee41-3a6a-40ab-4521-08dd68485c3c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 07:16:55.1758 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lca8mNNJtiD3A8A+edmmh7qLqwUZbPmijM//mP+2G2XuTOmCQIeUZwysz+OhH4wnvdl7nhACIvbeB7S0+rM0tw==
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

i.MX95 uses binman to invoke mkimage to create image container. 2 image
containers are needed currently. The first one is composed of
ahab-container.img, LPDDR firmware images, OEI images, System Manager
image and u-boot-spl.bin. The second one is consisted of ARM Trusted
firmware and u-boot.bin.

Because DDR OEI image and LPDDR firmware images have to be packaged
together and named as m33-oei-ddrfw.bin by binman, so imx9_image.sh does
not check if m33-oei-ddrfw.bin exists.

When using "make imx95_19x19_evk_defconfig; make", imx9_image.sh will
delete the line for u-boot.bin in container.cfg. In fact, binman is
always called after the u-boot.bin is built, so imx9_image.sh does not
check if u-boot.bin exists.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 include/imx8image.h |  19 +++++--
 tools/imx8image.c   | 147 ++++++++++++++++++++++++++++++++++++++++++++++------
 tools/imx9_image.sh |   8 +++
 3 files changed, 155 insertions(+), 19 deletions(-)

diff --git a/include/imx8image.h b/include/imx8image.h
index 6b95e93fb50..e0d25c5b6c9 100644
--- a/include/imx8image.h
+++ b/include/imx8image.h
@@ -157,7 +157,9 @@ enum imx8image_cmd {
 	CMD_SOC_TYPE,
 	CMD_CONTAINER,
 	CMD_IMAGE,
-	CMD_DATA
+	CMD_DATA,
+	CMD_DUMMY_V2X,
+	CMD_HOLD,
 };
 
 enum imx8image_core_type {
@@ -169,7 +171,9 @@ enum imx8image_core_type {
 	CFG_A35,
 	CFG_A55,
 	CFG_A53,
-	CFG_A72
+	CFG_A72,
+	CFG_M33,
+	CFG_OEI,
 };
 
 enum imx8image_fld_types {
@@ -208,7 +212,10 @@ typedef enum option_type {
 	FILEOFF,
 	MSG_BLOCK,
 	SENTINEL,
-	UPOWER
+	UPOWER,
+	OEI,
+	DUMMY_V2X,
+	HOLD,
 } option_type_t;
 
 typedef struct {
@@ -227,12 +234,16 @@ typedef struct {
 #define CORE_CA35       4
 #define CORE_CA72       5
 #define CORE_SECO       6
+#define CORE_M33        7
 
 #define CORE_ULP_CM33		0x1
 #define CORE_ULP_CA35		0x2
 #define CORE_ULP_UPOWER 	0x4
 #define CORE_ULP_SENTINEL 	0x6
 
+#define CORE_IMX95_M33P		0
+#define CORE_IMX95_A55C0	2
+
 #define SC_R_OTP	357U
 #define SC_R_DEBUG	354U
 #define SC_R_ROM_0	236U
@@ -246,10 +257,12 @@ typedef struct {
 #define IMG_TYPE_EXEC    0x03   /* Executable image type */
 #define IMG_TYPE_DATA    0x04   /* Data image type */
 #define IMG_TYPE_DCD_DDR 0x05   /* DCD/DDR image type */
+#define IMG_TYPE_OEI     0x05   /* Optional Executable image type */
 #define IMG_TYPE_SECO    0x06   /* SECO image type */
 #define IMG_TYPE_SENTINEL 0x06	/* SENTINEL image type */
 #define IMG_TYPE_PROV    0x07   /* Provisioning image type */
 #define IMG_TYPE_DEK     0x08   /* DEK validation type */
+#define IMG_TYPE_V2X_DUMMY 0x0E /* V2X Dummy image */
 
 #define IMG_TYPE_SHIFT   0
 #define IMG_TYPE_MASK    0x1f
diff --git a/tools/imx8image.c b/tools/imx8image.c
index 0135b190951..a333ded46e2 100644
--- a/tools/imx8image.c
+++ b/tools/imx8image.c
@@ -7,6 +7,7 @@
 
 #include "imx8image.h"
 #include <image.h>
+#include <linux/sizes.h>
 
 static int p_idx;
 static int sector_size;
@@ -54,7 +55,9 @@ static table_entry_t imx8image_cmds[] = {
 	{CMD_CONTAINER,         "CONTAINER",            "new container",      },
 	{CMD_IMAGE,             "IMAGE",                "new image",          },
 	{CMD_DATA,              "DATA",                 "new data",           },
-	{-1,                    "",                     "",	              },
+	{CMD_DUMMY_V2X,         "DUMMY_V2X",            "v2x",                },
+	{CMD_HOLD,              "HOLD",                 "hold",               },
+	{-1,                    "",                     "",	              }
 };
 
 static table_entry_t imx8image_core_entries[] = {
@@ -66,7 +69,9 @@ static table_entry_t imx8image_core_entries[] = {
 	{CFG_A55,	"A55",			"A55 core",	},
 	{CFG_A53,	"A53",			"A53 core",	},
 	{CFG_A72,	"A72",			"A72 core",	},
-	{-1,		"",			"",		},
+	{CFG_OEI,	"OEI",			"OEI", },
+	{CFG_M33,	"M33",			"M33 core", },
+	{-1,		"",			"",		}
 };
 
 static table_entry_t imx8image_sector_size[] = {
@@ -144,6 +149,14 @@ static void parse_cfg_cmd(image_t *param_stack, int32_t cmd, char *token,
 			exit(EXIT_FAILURE);
 		}
 		break;
+	case CMD_DUMMY_V2X:
+		param_stack[p_idx].option = DUMMY_V2X;
+		param_stack[p_idx++].entry = (uint32_t)strtoll(token, NULL, 0);
+		break;
+	case CMD_HOLD:
+		param_stack[p_idx].option = HOLD;
+		param_stack[p_idx].entry = (uint32_t)strtoll(token, NULL, 0);
+		param_stack[p_idx++].filename = NULL;
 	default:
 		break;
 	}
@@ -221,6 +234,16 @@ static void parse_cfg_fld(image_t *param_stack, int32_t *cmd, char *token,
 				(*cmd == CMD_DATA) ? DATA : AP;
 			param_stack[p_idx].filename = token;
 			break;
+		case CFG_OEI:
+			param_stack[p_idx].option = OEI;
+			param_stack[p_idx].filename = token;
+			param_stack[p_idx].ext = CORE_CM4_0;
+			break;
+		case CFG_M33:
+			param_stack[p_idx].option = M40;
+			param_stack[p_idx].ext = 0;
+			param_stack[p_idx].filename = token;
+			break;
 		}
 		break;
 	case CFG_LOAD_ADDR:
@@ -238,9 +261,15 @@ static void parse_cfg_fld(image_t *param_stack, int32_t *cmd, char *token,
 		case CFG_A53:
 		case CFG_A55:
 		case CFG_A72:
+		case CFG_M33:
 			param_stack[p_idx++].entry =
 				(uint32_t)strtoll(token, NULL, 0);
 			break;
+		case CFG_OEI:
+			param_stack[p_idx].dst = (uint32_t)strtoll(token, NULL, 0);
+			param_stack[p_idx].entry = param_stack[p_idx].dst + 1;
+			p_idx++;
+			break;
 		}
 	default:
 		break;
@@ -549,6 +578,7 @@ static void set_image_array_entry(flash_header_v3_t *container,
 				  char *tmp_filename, bool dcd_skip)
 {
 	uint64_t entry = image_stack->entry;
+	uint64_t dst = image_stack->dst;
 	uint64_t core = image_stack->ext;
 	uint32_t meta;
 	char *tmp_name = "";
@@ -558,7 +588,9 @@ static void set_image_array_entry(flash_header_v3_t *container,
 	img->offset = offset;  /* Is re-adjusted later */
 	img->size = size;
 
-	set_image_hash(img, tmp_filename, IMAGE_HASH_ALGO_DEFAULT);
+	if (type != DUMMY_V2X) {
+		set_image_hash(img, tmp_filename, IMAGE_HASH_ALGO_DEFAULT);
+	}
 
 	switch (type) {
 	case SECO:
@@ -580,6 +612,27 @@ static void set_image_array_entry(flash_header_v3_t *container,
 		img->dst = 0xe4000000; /* S400 IRAM base */
 		img->entry = 0xe4000000;
 		break;
+	case OEI:
+		if (soc != IMX9) {
+			fprintf(stderr, "Error: invalid core id: %" PRIi64 "\n", core);
+			exit(EXIT_FAILURE);
+		}
+
+		img->hab_flags |= IMG_TYPE_OEI;
+		if (core == CORE_CM4_0) {
+			img->hab_flags |= CORE_ULP_CM33 << BOOT_IMG_FLAGS_CORE_SHIFT;
+			meta = CORE_IMX95_M33P;
+
+		} else {
+			img->hab_flags |= CORE_ULP_CA35 << BOOT_IMG_FLAGS_CORE_SHIFT;
+			meta = CORE_IMX95_A55C0;
+		}
+		tmp_name = "OEI";
+		img->dst = (dst ? dst : entry);
+		img->entry = entry;
+		img->meta = meta;
+		custom_partition = 0;
+		break;
 	case AP:
 		if (soc == QX && core == CORE_CA35) {
 			meta = IMAGE_A35_DEFAULT_META(custom_partition);
@@ -587,8 +640,10 @@ static void set_image_array_entry(flash_header_v3_t *container,
 			meta = IMAGE_A53_DEFAULT_META(custom_partition);
 		} else if (soc == QM && core == CORE_CA72) {
 			meta = IMAGE_A72_DEFAULT_META(custom_partition);
-		} else if (((soc == ULP) || (soc == IMX9)) && core == CORE_CA35) {
+		} else if ((soc == ULP) && core == CORE_CA35) {
 			meta = 0;
+		} else if ((soc == IMX9) && core == CORE_CA35) {
+			meta = CORE_IMX95_A55C0;
 		} else {
 			fprintf(stderr,
 				"Error: invalid AP core id: %" PRIu64 "\n",
@@ -687,6 +742,15 @@ static void set_image_array_entry(flash_header_v3_t *container,
 			img->entry = 0x28300200;
 		}
 		break;
+	case DUMMY_V2X:
+		img->hab_flags |= IMG_TYPE_V2X_DUMMY;
+		img->hab_flags |= CORE_SC << BOOT_IMG_FLAGS_CORE_SHIFT;
+		tmp_name = "V2X Dummy";
+		set_image_hash(img, "/dev/null", IMAGE_HASH_ALGO_DEFAULT);
+		img->dst = entry;
+		img->entry = entry;
+		img->size = 0; /* dummy image has no size */
+		break;
 	default:
 		fprintf(stderr, "unrecognized image type (%d)\n", type);
 		exit(EXIT_FAILURE);
@@ -709,15 +773,26 @@ void set_container(flash_header_v3_t *container,  uint16_t sw_version,
 	fprintf(stdout, "container flags: 0x%x\n", container->flags);
 }
 
-static int get_container_image_start_pos(image_t *image_stack, uint32_t align)
+static int get_container_image_start_pos(image_t *image_stack, uint32_t align, uint32_t *v2x)
 {
 	image_t *img_sp = image_stack;
 	/*8K total container header*/
 	int file_off = CONTAINER_IMAGE_ARRAY_START_OFFSET;
 	FILE *fd = NULL;
-	flash_header_v3_t header;
+	flash_header_v3_t *header;
+	flash_header_v3_t *header2;
+	void *p;
 	int ret;
 
+	p = calloc(1, SZ_4K);
+	if (!p) {
+		fprintf(stderr, "Fail to alloc 4K memory\n");
+		exit(EXIT_FAILURE);
+	}
+
+	header = p;
+	header2 = p + FIRST_CONTAINER_HEADER_LENGTH;
+
 	while (img_sp->option != NO_IMG) {
 		if (img_sp->option == APPEND) {
 			fd = fopen(img_sp->filename, "r");
@@ -726,7 +801,7 @@ static int get_container_image_start_pos(image_t *image_stack, uint32_t align)
 				exit(EXIT_FAILURE);
 			}
 
-			ret = fread(&header, sizeof(header), 1, fd);
+			ret = fread(header, SZ_4K, 1, fd);
 			if (ret != 1) {
 				printf("Failure Read header %d\n", ret);
 				exit(EXIT_FAILURE);
@@ -734,19 +809,27 @@ static int get_container_image_start_pos(image_t *image_stack, uint32_t align)
 
 			fclose(fd);
 
-			if (header.tag != IVT_HEADER_TAG_B0) {
-				fprintf(stderr, "header tag mismatched file %s\n", img_sp->filename);
+			if (header->tag != IVT_HEADER_TAG_B0) {
+				fprintf(stderr, "header tag mismatched \n");
 				exit(EXIT_FAILURE);
 			} else {
-				file_off +=
-					header.img[header.num_images - 1].size;
-				file_off = ALIGN(file_off, align);
+				if (header2->tag != IVT_HEADER_TAG_B0) {
+					file_off += header->img[header->num_images - 1].size;
+					file_off = ALIGN(file_off, align);
+				} else {
+					file_off = header2->img[header2->num_images - 1].offset + FIRST_CONTAINER_HEADER_LENGTH;
+					file_off += header2->img[header2->num_images - 1].size;
+					file_off = ALIGN(file_off, align);
+					fprintf(stderr, "Has 2nd container %x\n", file_off);
+					*v2x = true;
+				}
 			}
 		}
 
 		img_sp++;
 	}
 
+	free(p);
 	return file_off;
 }
 
@@ -838,6 +921,7 @@ static int build_container(soc_type_t soc, uint32_t sector_size,
 	char *tmp_filename = NULL;
 	uint32_t size = 0;
 	uint32_t file_padding = 0;
+	uint32_t v2x = false;
 	int ret;
 
 	int container = -1;
@@ -861,7 +945,7 @@ static int build_container(soc_type_t soc, uint32_t sector_size,
 	set_imx_hdr_v3(&imx_header, 0);
 	set_imx_hdr_v3(&imx_header, 1);
 
-	file_off = get_container_image_start_pos(image_stack, sector_size);
+	file_off = get_container_image_start_pos(image_stack, sector_size, &v2x);
 	fprintf(stdout, "container image offset (aligned):%x\n", file_off);
 
 	/* step through image stack and generate the header */
@@ -870,6 +954,7 @@ static int build_container(soc_type_t soc, uint32_t sector_size,
 	/* stop once we reach null terminator */
 	while (img_sp->option != NO_IMG) {
 		switch (img_sp->option) {
+		case OEI:
 		case AP:
 		case M40:
 		case M41:
@@ -892,6 +977,30 @@ static int build_container(soc_type_t soc, uint32_t sector_size,
 			file_off += ALIGN(sbuf.st_size, sector_size);
 			break;
 
+		case DUMMY_V2X:
+			if (container < 0) {
+				fprintf(stderr, "No container found\n");
+				exit(EXIT_FAILURE);
+			}
+			tmp_filename = "dummy";
+			set_image_array_entry(&imx_header.fhdr[container],
+						soc,
+						img_sp,
+						file_off,
+						0,
+						tmp_filename,
+						dcd_skip);
+			img_sp->src = file_off;
+			break;
+
+		case HOLD:
+			if (container < 0) {
+				fprintf(stderr, "No container found\n");
+				exit(EXIT_FAILURE);
+			}
+			file_off += ALIGN(img_sp->entry, sector_size);
+			break;
+
 		case SECO:
 		case SENTINEL:
 			if (container < 0) {
@@ -963,11 +1072,15 @@ static int build_container(soc_type_t soc, uint32_t sector_size,
 	do {
 		if (img_sp->option == APPEND) {
 			copy_file(ofd, img_sp->filename, 0, 0);
-			file_padding += FIRST_CONTAINER_HEADER_LENGTH;
+			if (v2x)
+				file_padding += FIRST_CONTAINER_HEADER_LENGTH * 2;
+			else
+				file_padding += FIRST_CONTAINER_HEADER_LENGTH;
 		}
 		img_sp++;
 	} while (img_sp->option != NO_IMG);
 
+	fprintf(stderr, "%s: %x %d\n", __func__, file_padding, v2x);
 	/* Add padding or skip appended container */
 	ret = lseek(ofd, file_padding, SEEK_SET);
 	if (ret < 0) {
@@ -980,6 +1093,7 @@ static int build_container(soc_type_t soc, uint32_t sector_size,
 		/* Note: Image offset are not contained in the image */
 		tmp = flatten_container_header(&imx_header, container + 1,
 					       &size, file_padding);
+		fprintf(stderr, "error writing image hdr %x\n", size);
 		/* Write image header */
 		if (write(ofd, tmp, size) != size) {
 			fprintf(stderr, "error writing image hdr\n");
@@ -1000,7 +1114,8 @@ static int build_container(soc_type_t soc, uint32_t sector_size,
 		    img_sp->option == AP || img_sp->option == DATA ||
 		    img_sp->option == SCD || img_sp->option == SCFW ||
 		    img_sp->option == SECO || img_sp->option == MSG_BLOCK ||
-		    img_sp->option == UPOWER || img_sp->option == SENTINEL) {
+		    img_sp->option == UPOWER || img_sp->option == SENTINEL ||
+		    img_sp->option == OEI) {
 			copy_file_aligned(ofd, img_sp->filename, img_sp->src,
 					  sector_size);
 		}
@@ -1031,7 +1146,7 @@ int imx8image_copy_image(int outfd, struct image_tool_params *mparams)
 	fprintf(stdout, "CONTAINER SW VERSION:\t0x%04x\n", sw_version);
 
 	build_container(soc, sector_size, emmc_fastboot,
-			img_sp, dcd_skip, fuse_version, sw_version, outfd);
+			img_sp, false, fuse_version, sw_version, outfd);
 
 	return 0;
 }
diff --git a/tools/imx9_image.sh b/tools/imx9_image.sh
index ca78a57a19a..6523d1a0ad1 100755
--- a/tools/imx9_image.sh
+++ b/tools/imx9_image.sh
@@ -18,6 +18,14 @@ for f in $blobs; do
 		continue
 	fi
 
+	if [ $f = "m33-oei-ddrfw.bin" ]; then
+		continue
+	fi
+
+	if [ $f = "u-boot.bin" ]; then
+		continue
+	fi
+
 	if [ ! -f $tmp ]; then
 		echo "WARNING '$tmp' not found, resulting binary may be not-functional" >&2
 

-- 
2.43.0

