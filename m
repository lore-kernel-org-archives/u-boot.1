Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2298EC35FF3
	for <u-boot@archiver.kernel.org>; Fri, 21 Mar 2025 07:16:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 430B081C67;
	Fri, 21 Mar 2025 08:16:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="mrUk/3sK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8524E8198A; Fri, 21 Mar 2025 08:16:09 +0100 (CET)
Received: from AS8PR03CU001.outbound.protection.outlook.com
 (mail-westeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02A0F805C8
 for <u-boot@lists.denx.de>; Fri, 21 Mar 2025 08:16:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a7Ghs4Ut4wAB7F6EPBWoUOrgDu3wTSoflWpKWZ7aYcJ6xO93itth9hRY6iL0D4h077O8FhPmEcISLgb2qjGhwQWjCrWkS5jt/6QXW0M09bakIYXaohZSydXhi2re91J4eLRYa/vw5KI2BnjlqfhnNlUFo1BkAxPpLF1CNZIcc0PXNj3NV0g7Le4AUQNoURY3hAC9Oh6pPi39TeCdUfF6BmfIaqu+CxC87OMPToV8OqjR6geLKceWowhpii0UFwLIFo7VAQzrwwCdhY2pR+HnrhFvUcFURwMkbWCTp3w8xY+Hyn8eEehZiFb1Pq8hK8Sgxujc3Unm81k+C5P2nTfznA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mRdmxU8IAMEIoxs9Qgkk7p80FK69iX59y1fJJ2JtD8g=;
 b=e0pAtYF2ZUMlmls8+hGmcFwqWUHdlIiSffb4AzHteWM/7VORjdNUsSn++nE75vI4zpgLRxvlwajSODtfboEM+NcDewiNaWQLqN5xRYb1eHS5SNPrj367KH6MZV0xXDEpoO7Ispl3V2515DdrDTvSnPs+T39atsBU5MVJA//hJ3gtlwEs2cAxs7uo13rQ76fIG6iGqMhJfX09ExdU6jjqSIFS/q8f6WQy8yN8RCdVfAdr/WX+iIv/dpV1r9p2MEvADv4NyIckFJXKsH0TUyk3hEckPU6AwxKXp7fbeI1Y2tegX9HfAP8nnWM27Bcysk0jSrG9RRKnCc34gw1hsEjOzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mRdmxU8IAMEIoxs9Qgkk7p80FK69iX59y1fJJ2JtD8g=;
 b=mrUk/3sKNPzM3s0aODK2Njq2VfU++lBucsJHg2IIRRRp03iWp+GQAiK5DLJ7loFpr57rE4rXVPp+5AWo9zHfRCTnIEXM0j0GkYhxeW3UyPpgb8zCzuzv5gfr60TBWJFmoGPFt/NXWXy3FoEehZiZ4Lw38AB6zeLTaTlpNdHx1J/VCtyYyC7Dx6IHl81i46RZ1EuRmlI53W6SMYA+Ck9Hrae/QhOP9AmX2QQ5pFnD0/6wfbbMw9bouExepa4XrLqVxbOZR6xNMqtZhwK5K4yOGxFro6cDtMWPQCm04yriARRv6WtMARNgn3eClLyS+GqCxUMmG0Beo5wwifcaa1iwig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AM0PR04MB6836.eurprd04.prod.outlook.com (2603:10a6:208:187::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.37; Fri, 21 Mar
 2025 07:16:05 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8534.034; Fri, 21 Mar 2025
 07:16:05 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Fri, 21 Mar 2025 15:15:17 +0800
Subject: [PATCH v8 03/19] firmware: scmi_agent: add SCMI pin control
 protocol support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250321-imx95-v1-3-f2c8ba815f89@oss.nxp.com>
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
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AM0PR04MB6836:EE_
X-MS-Office365-Filtering-Correlation-Id: 551843b0-e200-4011-86a3-08dd68483e8c
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|376014|7416014|1800799024|38350700014|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K3pTaHo4akJxU2pIT3hpaElIUE1NNWxRZmQrL01mcXp3VUhxRmJQem11bFdx?=
 =?utf-8?B?NkdDZmRxT2huMnI5aEcvSWJOOER1VkQ1SDl5RWhNaFREQ01RSlByS2xNd0VO?=
 =?utf-8?B?SWNqZUljaWVOU0xkbEd2ekVqWDQxNEdHdFk1cnNxenRyM2tEVWR0UUN1YkVV?=
 =?utf-8?B?YkZCWkFlRlIwcFlGdnh0UTFHQjVPdi9xaVdhT1hiU0l4T2E4WnBmMGFIMGRy?=
 =?utf-8?B?bVRuYWxscktoUTl3UXR2KzVlc0pkZVQ5NEtkNFZMUVZxK0loUDE3czVxd1pJ?=
 =?utf-8?B?MU5zeXA1MjFhVURXWmFDMnZkREZwWkR3b0lQdHMwMHdYOGFQN3JETFNvMkg3?=
 =?utf-8?B?SWpaMDBLM2tRWlVMaURkSUczR0w1R3hPRU93M01kbjdLT3Z5aVdsR2dtUUNy?=
 =?utf-8?B?MHJsemcxbFYrZFo3TVA2cUNkRVNkU0FacGFQaXF4MEVlNkdvbit3d2Jlb2Ur?=
 =?utf-8?B?UWw5cENhR3FHZHM0RTYrT2tDWU5oZTZwK1pRMlN2cXV3c0tDTmRjS0JYUW5u?=
 =?utf-8?B?c1FxNmFYeGhrcEIyRTFkbjd0aG00dk85alFqTkV6dTBmVDhQbGRjWHcwdzhV?=
 =?utf-8?B?VUQwWVdmWitGSzBYT0szcHhBUklhQlNDekdKNnJqcjV4R2RFY1d1NWdpUDR1?=
 =?utf-8?B?QlFtVjBHRVM1L2NrTEZIQUpHWkw1azdtbHBkZTV4dlY4RzUyWnZxbzcwK0N6?=
 =?utf-8?B?ZFF4eGVjemdsZ3hzaThMN3pKT09LZEFxaWVVSlVxZUNTOTVsL0Z3RmsrYVJT?=
 =?utf-8?B?U3JjZURSVDk2aUsxRXNmVFI5Sk1xZ3BqcEFTdm1Qc24zSlZrS0hTajJFWDky?=
 =?utf-8?B?cjRqT3BIcmFVUmZaUURIQ3FqNmlET1BJVnVYRTJrNlJjWDBRTWU5UWl3NDBX?=
 =?utf-8?B?dldnbjk3bGZvbStldzd5TlU3N2Z0NDJRbHZtNEpPMTNvTkcveFJWQk5GUFor?=
 =?utf-8?B?bWVBU3czWDFrUDlZOVhtU01hZXVSdnZGWS80SDgvNUJtWU4wUjJ4cllRM2Qy?=
 =?utf-8?B?TXoxUlhKR1RjYnlKQnpNdEZQeitJc0lETUpKV3NIeWZmZ1p3ZHBHNm9IVWtL?=
 =?utf-8?B?VVZOTUhKa2NnaHNWNHVWWUU4Y1NNcDR1QmEwWTY2Ym1IVzNVWlZiUWFTYjlQ?=
 =?utf-8?B?eXBNTFJRTTM1NDIzN1FmblRlSkJ1TnlJdS9zQ210ZkF2SjhOUUZqWEZpTlI3?=
 =?utf-8?B?MlVYUk05Z29adDM1clZIcTR1eTZhQWdYUnFRbmxhVzlZc25tcisvQk9LVHZl?=
 =?utf-8?B?cVUrOFAvdldIMGtTY094NTNZbDIyaU9FWXlZelp0Skl3ekdjWEVYaHAvOWFt?=
 =?utf-8?B?cmJldVg5QnRjUHVXMkxSalBkMHloVkFZY1dJeWRmdDhPb1R5dFdGTno5Ymlp?=
 =?utf-8?B?Ynh1S3ZHOWlKNElMbk0rL00vb2JkSUY3cnhCWkJqTHZ4NlI0cmlyQzhNa1Fz?=
 =?utf-8?B?K0VuTVQ4S3U3cTREZ24vWTBhT2xleU8rTmo2UVFGRXlmWEdRYkxkRngwRFkz?=
 =?utf-8?B?YTJuYVBhalFLemhvaThMakZibkR2WW1NQVhrVUdLNzBJQlJiV1FtVkpmck0v?=
 =?utf-8?B?WTBYeCt4bml2MWREc29oWk00R3FZTG13bE1NeE9JYmgxOTk0bXRrTE9sZTNS?=
 =?utf-8?B?QUEzRWJub2ZZMUlidk84VDA2VkZiczZwVDhVV2lDZEptNENIckxiallWNE0w?=
 =?utf-8?B?YzRrVURkU2RncEZhc2o0WFlkNDJ6Um9HZVBSWDBua2xtMTZDR3psQ3hQOU0y?=
 =?utf-8?B?dldVQXdoS2czRWZJOUhQTXhLR3FKK0l2cFcrVCtCRTlhN1hSU2hkOWY3YUZC?=
 =?utf-8?B?UnJpM2d1K1pNS3N1Nlc1aitzMUhVOEN3Ukoxc2FkNlRsQUxWUXZxVVJxTFgv?=
 =?utf-8?B?WDk1RTFOUGlMUFJYRlpMV2VTSGdUcTM0M1JHUjVxb041RFE4cmUxNXFUaWFJ?=
 =?utf-8?B?MStLMmFmTFhQbUV2bDBrazMrYWFkbmQySk5sV00rMXIwT0Mva3hRbzFnU2k4?=
 =?utf-8?B?QWY2U2VIWllBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(376014)(7416014)(1800799024)(38350700014)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QktvNGdJYjNBRndPWENDcjJJSHJ5dnVIdnJjSVY5UUozT1RjQWJRUHpYWVFq?=
 =?utf-8?B?ZmY3YXpEZUlqcjR4dWQ2RjY4TEk0UmF2RVAzWGlFQ2h4enlMNUQ4U2RkZTBY?=
 =?utf-8?B?SnFNMGFqQzdHRHMwOS9KZ2lOcngvUktOSDU4RmQrZVM2dE5jbnpocmhQSWZ4?=
 =?utf-8?B?YTB4SHpPVWFvVkxTQXp0Q3BINEY0STlSZWtBNVNMSnhhQWJhR3RJUnF2cG9u?=
 =?utf-8?B?dTFkYUZLR25qTmcrYjlHRHo0bGo3cXlWblozbTlJaWlScjVRZ0pWVDlDMFdL?=
 =?utf-8?B?SWg3SlkwQkJnN09JYVF0bFNHcHkxbDVoZkc1OEVLQTZSQ3I1QlRodHo4K2ph?=
 =?utf-8?B?N0RIZy9ycHpad3NRcDR3SmtYQkZhaVplT2NUYlNMc0VRWUZyanliaS92aDFY?=
 =?utf-8?B?QkR3NHhGS01rcTJOS2pzQ0MyMElBcm1VQUpySExsTUdxc2pVUTA0TFFqK2lh?=
 =?utf-8?B?cjVqcEFMTEl4aHdER1hQR0lHaGd5UEgwSnhMak5IQkRCeVFmMXRqYUFEUE5J?=
 =?utf-8?B?Q1YzMWFISklQMjVtcEFYNHJ6dTVrckEwcEdITjlJSEpQWHk2WnBvY1B4WEZ3?=
 =?utf-8?B?emZDZkNmMlF5NzJ5dVlMakk0UGlTekpmcVdKVkhvaDdUZHBxTXVRdkt5aUJ5?=
 =?utf-8?B?dDFPNXZtamNNcEltTDhUeFVYT3BjdGhzV0F3ck4yMytrd3hsS0lnZU9Xc2U4?=
 =?utf-8?B?ZGMya0tCaXI5anoyUW43N09jR2MxUlZOUzc4Y29sTDlwcHdXUWs1WXFucUZR?=
 =?utf-8?B?UXBSNEVxYUtTN1JUVHlDckdlNHovR2p5eGJ5amd1VU9KRDFweTNRNDNhNWFT?=
 =?utf-8?B?K1hVVXdETS8xUFY2RFJlVHk3anZQKzVVUjI5VXhRTzI4aXJuRVNUQWE3cVZB?=
 =?utf-8?B?UEV6c0RVVXQzTmZ1dUJkMm9mZ3Z2TmJLUTJscFQ1YXVlVW01ZFU0YlpFMUJ2?=
 =?utf-8?B?VUJqaVRweEVFVEZ4WEM3M2xpS2dqSkZ6SjYyeHF0ZXVtWEcvRGsyd3QzdU5k?=
 =?utf-8?B?VXhsWmJrNUluWm9LUWhrL0Q4aFZLMkVrMzBHVTN5Nmd2T0M2dmcxK1pYRDcr?=
 =?utf-8?B?QW1xeWtnSTEvdkFsQkFmNk8zUFVrcHl0eDNyOUZ1M2NDNTJVMTZoSEtiaXlB?=
 =?utf-8?B?ZzFpSFU1MVZUL3JZU3dSdWpCQ0JlZWk4dDhYNUFGQ3NvY2ttN1FnZWI5bnBP?=
 =?utf-8?B?WjVDNEdXOGNyVGxQQUY0UHRnWGxEY3ZJbVZ2d21PakNkWHJGRWNOQmVQNyto?=
 =?utf-8?B?V0F6WG45SDV2MFNTSXZLeWdtMUkyaTBwaVh5UGJTcjB1eC9OWWkvR0FlbzUx?=
 =?utf-8?B?NnRmRnZjcHNUYXY2UnkrMm1rR2ZMOFluNEUraXRDTEJGcjZKMUdvTnBBR0VR?=
 =?utf-8?B?ZjlwdDJEZkc0RDJKempGRVJ6eHBVQkM1U2RFc0VxWkREemJhVjJsaUJrTTBN?=
 =?utf-8?B?N0FqOFo0Y1ZOdzZHZzZza0pyL1UxcWx1UzBlZ3ZmYzlnQ1pmY1IrR1pMeCsr?=
 =?utf-8?B?L2JZWXFvc3FwdFFPV0d1R1ZhaktQWGxhQ0hDUVFRMlozRTRxa0RPMVErMlE1?=
 =?utf-8?B?NjdueTJtbUNubDFwdU9OQWYrSkIzYTV1ZnlOOXYzbG1UREc2elZrQ0pFWnBY?=
 =?utf-8?B?WU1pbWNYbXdFS1lIV0JvZGlyRGhJOWFNTlUrQk1EY3U0STJnZ2VjK1lZMCtU?=
 =?utf-8?B?dGRCUVZJd2NrZUptU1EvK2NHdFRvRTJ3VnBDMktvSTRPZHBkcjk0R0JKSHJo?=
 =?utf-8?B?c0tuMUl3WndxcU1jUFNyRkpkWHhhUDY2TzFKbElaMVhxWkZiNXJtZCtQdy91?=
 =?utf-8?B?NlZpNVBIVmc4akE2bGttbWlNbnBDa2hlZUg4Wm9PbW5mZmZSWXUxaThsK0lm?=
 =?utf-8?B?dTRnNlZheHJJUEY0d0c3M3k3QzhrWU9zRDZJZVV3ZkdMamI5Uk1MSnFaTG81?=
 =?utf-8?B?OXR1MjliSkhmSWo0L3owTlZQay9QM0ZBVU5tWHJQU1NhOS84QTJQbTZYYkFF?=
 =?utf-8?B?b2Nud1RLbmcxcFhYZitvTWlONDQ1M3FaM0lpL0JLSGJ3ZjhhYW93eldtbnIv?=
 =?utf-8?B?YzIvR1hQNWVkakJaaG52N3pyYXE3M3poR0phbW5VM2lJeEFJQ1lVb3RYeHor?=
 =?utf-8?Q?ci1e4ZFV+wa2bv4YRyJ01yioZ?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 551843b0-e200-4011-86a3-08dd68483e8c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 07:16:05.3675 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BZYrYKsrQEdhDhmfbKobXFN0ZP/0SDydKe82sN+FVOzqbPJgySR3iilN57VU7xTbbg14+0MWPf0D3BPouTPNZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6836
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

This patch adds SCMI pin control protocol support to make the pin
controller driver based on SCMI, such as
drivers/pinctrl/nxp/pinctrl-imx-scmi.c, can be bound to the SCMI agent
device whose protocol id is 0x19.

Add U_BOOT_SCMI_PROTO_DRIVER() so that the SCMI agent device can choose
which SCMI protocol driver to bind by the bind function of struct
driver. This can avoid putting i.MX related code in scmi_agent-uclass.c.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 drivers/firmware/scmi/scmi_agent-uclass.c | 25 +++++++++++++++++++++++++
 drivers/pinctrl/nxp/pinctrl-imx-scmi.c    |  7 +++++++
 include/scmi_agent-uclass.h               | 17 +++++++++++++++++
 3 files changed, 49 insertions(+)

diff --git a/drivers/firmware/scmi/scmi_agent-uclass.c b/drivers/firmware/scmi/scmi_agent-uclass.c
index 8c907c3b032..2ffdd5c881e 100644
--- a/drivers/firmware/scmi/scmi_agent-uclass.c
+++ b/drivers/firmware/scmi/scmi_agent-uclass.c
@@ -97,6 +97,9 @@ struct udevice *scmi_get_protocol(struct udevice *dev,
 	case SCMI_PROTOCOL_ID_VOLTAGE_DOMAIN:
 		proto = priv->voltagedom_dev;
 		break;
+	case SCMI_PROTOCOL_ID_PINCTRL:
+		proto = priv->pinctrl_dev;
+		break;
 	default:
 		dev_err(dev, "Protocol not supported\n");
 		proto = NULL;
@@ -147,6 +150,9 @@ static int scmi_add_protocol(struct udevice *dev,
 	case SCMI_PROTOCOL_ID_VOLTAGE_DOMAIN:
 		priv->voltagedom_dev = proto;
 		break;
+	case SCMI_PROTOCOL_ID_PINCTRL:
+		priv->pinctrl_dev = proto;
+		break;
 	default:
 		dev_err(dev, "Protocol not supported\n");
 		return -EPROTO;
@@ -352,6 +358,22 @@ static int scmi_fill_base_info(struct udevice *agent, struct udevice *dev)
 	return 0;
 }
 
+static struct driver *scmi_proto_driver_get(unsigned int proto_id)
+{
+	struct scmi_proto_driver *start, *entry;
+	int n_ents;
+
+	start = ll_entry_start(struct scmi_proto_driver, scmi_proto_driver);
+	n_ents = ll_entry_count(struct scmi_proto_driver, scmi_proto_driver);
+
+	for (entry = start; entry != start + n_ents; entry++) {
+		if (entry->match->proto_id == proto_id)
+			return entry->driver;
+	}
+
+	return NULL;
+}
+
 /*
  * SCMI agent devices binds devices of various uclasses depending on
  * the FDT description. scmi_bind_protocol() is a generic bind sequence
@@ -436,6 +458,9 @@ static int scmi_bind_protocols(struct udevice *dev)
 				drv = DM_DRIVER_GET(scmi_voltage_domain);
 			}
 			break;
+		case SCMI_PROTOCOL_ID_PINCTRL:
+			drv = scmi_proto_driver_get(SCMI_PROTOCOL_ID_PINCTRL);
+			break;
 		default:
 			break;
 		}
diff --git a/drivers/pinctrl/nxp/pinctrl-imx-scmi.c b/drivers/pinctrl/nxp/pinctrl-imx-scmi.c
index 0ed971369a3..dbd6ff437e5 100644
--- a/drivers/pinctrl/nxp/pinctrl-imx-scmi.c
+++ b/drivers/pinctrl/nxp/pinctrl-imx-scmi.c
@@ -9,6 +9,7 @@
 #include <dm/device_compat.h>
 #include <dm/pinctrl.h>
 #include <scmi_agent.h>
+#include <scmi_agent-uclass.h>
 #include <scmi_protocols.h>
 
 #include "pinctrl-imx.h"
@@ -150,3 +151,9 @@ U_BOOT_DRIVER(scmi_pinctrl_imx) = {
 	.ops = &imx_scmi_pinctrl_ops,
 	.flags = DM_FLAG_PRE_RELOC,
 };
+
+static struct scmi_proto_match match = {
+	.proto_id = SCMI_PROTOCOL_ID_PINCTRL,
+};
+
+U_BOOT_SCMI_PROTO_DRIVER(scmi_pinctrl_imx, &match);
diff --git a/include/scmi_agent-uclass.h b/include/scmi_agent-uclass.h
index 33e0e18c30d..d6586eb3ff9 100644
--- a/include/scmi_agent-uclass.h
+++ b/include/scmi_agent-uclass.h
@@ -27,6 +27,7 @@ struct scmi_channel;
  * @clock_dev:		SCMI clock protocol device
  * @resetdom_dev:	SCMI reset domain protocol device
  * @voltagedom_dev:	SCMI voltage domain protocol device
+ * @pinctrl_dev:	SCMI pin control protocol device
  */
 struct scmi_agent_priv {
 	u32 version;
@@ -43,6 +44,7 @@ struct scmi_agent_priv {
 	struct udevice *clock_dev;
 	struct udevice *resetdom_dev;
 	struct udevice *voltagedom_dev;
+	struct udevice *pinctrl_dev;
 };
 
 static inline u32 scmi_version(struct udevice *dev)
@@ -115,4 +117,19 @@ struct scmi_agent_ops {
 			   struct scmi_msg *msg);
 };
 
+struct scmi_proto_match {
+	unsigned int proto_id;
+};
+
+struct scmi_proto_driver {
+	struct driver *driver;
+	const struct scmi_proto_match *match;
+};
+
+#define U_BOOT_SCMI_PROTO_DRIVER(__name, __match) \
+	ll_entry_declare(struct scmi_proto_driver, __name, scmi_proto_driver) = { \
+		.driver = llsym(struct driver, __name, driver), \
+		.match = __match, \
+	}
+
 #endif /* _SCMI_TRANSPORT_UCLASS_H */

-- 
2.43.0

