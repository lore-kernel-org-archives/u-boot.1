Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A47C5C19776
	for <u-boot@archiver.kernel.org>; Fri, 28 Feb 2025 10:56:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A83968129B;
	Fri, 28 Feb 2025 11:55:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="JepcUFaD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 733168128D; Fri, 28 Feb 2025 11:55:39 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2062c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::62c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C5A48129B
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 11:55:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hsYKrzhVkmzuIS3e3MSM7dpbW3iadmaQIS2sgmo+ZbScCTRBOdO5K8KJve0uvVGcc2OGX/yyrbf8La+d/TlnrVzrYxPf61KMGYfx0ZALcTLPUs8QwoUya2t+lpKhrvzmB5rQXrdEzyh33qNYDeileEz/0Fg2dVOhfDW89eEMAWNLq6z7hHgZdzugIdgBeuZ8L5tC0bSXhfptEBEFjbvcsCkaoQJBvifkyoWGNUyy6kx+i9yGDci1sqdWq6iOVgMQot/Fwju7XNhzWOG8Rhba1IgPLWOrvmPIr0PHZhDi0Ws1feEsg4Jkemhkkg1VjLBnLA061FmCJDD8Dcm+ucif5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VIaf6yzWUjw7XaWYBQEr9Pt6gMmmNMERUdqi7TXWFx8=;
 b=QVoHLP6bqf1/zzD8s8+Ca0i4GHUAhz4QsFfGrHn9tsGoJrnYL30xdhjHometbNw8vsnIxSctbny5fQPt4lBBcEw323zgdQoj78RAgYu0J8p+qTvo2u+tapD1f3ZWtwz6shl+3CAMOWkduIq5fcCuWLYCU9IFcuTZlOXXWUvX1+0RWtigMuEzG3wSzhIAFQjI7Ea6eaco9YF+4xPBk98MYEe2sm8B3Db9LXD+e6InI/iDKDCP93Yfk9xYYi8ECAXWANr8YUSKwCN9RF/39QBba9V765yStMd0B3z3R8m8GmiVTF4gxP3kvmrMN99qW393IjuayKb3hWyUHzHIh9ii/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VIaf6yzWUjw7XaWYBQEr9Pt6gMmmNMERUdqi7TXWFx8=;
 b=JepcUFaD4no0NJuXha5i77JfOAwsXgv24oUqrqymU4eT+2TQJaCm+q4fCaKRRJaco0qEQBJPPFAMnGEvTwpImua+8eiIT50vcO4zNHF4jLl0F7F+ojDnp9wR6+fxQwl0sv4yYQQR7W4V7rR4m6Cry+BR/1vRva8OfTuBCcfxXJwBrHjbZ7L+Nt5+Henee5q5VY0h6VvApEN9xRR8qImcvMEzjd+5Lj8jh0YuHTWFh6iGVoSx9qvE2h7nhdmOXrivqZ6N4rQ1rYnXZ6qi516I0UCrBGFO5gnfkuXyU8o8Zho1SBtUf4m8i+kzI94CthdJfE73lpzo6URwX6NPfj8VUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AS8PR04MB7845.eurprd04.prod.outlook.com (2603:10a6:20b:2a7::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Fri, 28 Feb
 2025 10:55:36 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8466.024; Fri, 28 Feb 2025
 10:55:36 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Fri, 28 Feb 2025 18:54:06 +0800
Subject: [PATCH v6 15/20] binman: add a new entry type for packing DDR PHY
 firmware images
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250228-imx95-v1-15-09594e93cc9b@oss.nxp.com>
References: <20250228-imx95-v1-0-09594e93cc9b@oss.nxp.com>
In-Reply-To: <20250228-imx95-v1-0-09594e93cc9b@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>, 
 marex@denx.de
Cc: u-boot@lists.denx.de
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI1PR02CA0002.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::16) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AS8PR04MB7845:EE_
X-MS-Office365-Filtering-Correlation-Id: 19e0dd76-81bb-4569-3def-08dd57e66e43
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|1800799024|366016|921020|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dDVyZEpFV1pEVHRCOEp2Yy95ZjByazVUdnNZRkxyOWZvdDVINFVBU05LOVhq?=
 =?utf-8?B?UmNiYk1MbFJVeWhFWk1pMDIvMVZiaHRIU0ljM2UyQ21Ub3BwVW9pWkhTeTAw?=
 =?utf-8?B?VXJhaUIwUEdmY0tLN3dEZ2tTVmlicXl5aTBBRSt0dFF0dHRMZ3gvdUd5Wmlr?=
 =?utf-8?B?eXoyUEZUbDNVWGZBN3hiR1d6UW1KbHB1U2tRc1BqaHZ0Nlc4WW5NRmhick84?=
 =?utf-8?B?U0NHSWlRc3JqelM0MHlqb1BDOUQ2eXpOOXhsN21LczFPOGNGMU51NkFIRUhW?=
 =?utf-8?B?UjZrbjNJQVdiT0QrZ2twcURGaVZHdmZMMHQ4WExpTEdiL05ad2J4ZHdIK0FO?=
 =?utf-8?B?cW5sTkJ5bnU1c2c4Ti80RzJtc2p4alR1UWYwWTU5ZEtCMTVHR0l0QVM4S3Nl?=
 =?utf-8?B?TUNqR24vdENMeDlYQUI0ZEFvNERvbllNaHI3QnFWUnFwTzN4c3N6cUtRa1hM?=
 =?utf-8?B?U0psV3k4UkhnQXRrZVoycTVUK3JqVVROb2FvOGVuenhwWURvemhqVGIvbXVO?=
 =?utf-8?B?ZFM2dnlPUlNteVBmTjllRURHTDA0YUhRSDBjdzQzenJ2c2JhL1BpRHFadWR1?=
 =?utf-8?B?R2JMencvVC95ZU10VVpWZFFSNlZITnV3UUp6STROL0NTdWRlMW5Nc0JydUJx?=
 =?utf-8?B?aTdwRVQxVU1NMjJ2Q2FEdU4wNVhGK2FJSzBlalVlUStPMzNhUEhaZ1hTZjla?=
 =?utf-8?B?cE52M3ViWjVrbThHc2dka3ErS21XSDFPek9vMVhVYytSOUFkczAyVk0wbm9V?=
 =?utf-8?B?WmpRbDB2T1BBT2o3ZlZpdzU4SzRjUEdmTXI1Ukp3YiszZDFnaFVOTnpMWXBB?=
 =?utf-8?B?eFZZQkdnckJFQWRjdEh1dWFNU2lCU0tCNmJpS3l2YmhZUTRUcDdmUUJWWEtT?=
 =?utf-8?B?b1NMYk03U3JoR3RiZmE1ZWx2c1ZmckwyWWM0UWlJWXFKQk5jVloreG9heWJz?=
 =?utf-8?B?SDFhYllaalJBYjBhNDZEZDdGL0piQ1J0TUhyRlFrc0ZncFRUOTRERlRvWHc2?=
 =?utf-8?B?QjJYZTI3dEF5eC9UUmUzeUMxb1RGNWl2dTJKV2RSaW1GOFhYMG5SL0pUQkJY?=
 =?utf-8?B?THBmN2JWL2xRaWgrLzgvQTlEOEpDVlUwMjVvdlcxdzk3bWpFWkpEUERFaS9s?=
 =?utf-8?B?Q1NNa1l5T3FRYXVtekVxUER0aWRkaitYZ1JWN2tUU2Y4aWozMERHYUltVHlJ?=
 =?utf-8?B?bTA1UURybWczQ2h2T2dXT1d5c1o1aE40anNaOVMwNWdGZlNnREJ6OUw3cC9h?=
 =?utf-8?B?eUdiSW01eW1UU1Jib1RpdkNsMmRFdklKc3g1NTNEdythQ2wrTTdsbzdkd0cw?=
 =?utf-8?B?SW42czVHL2lLRGx2c2VMMWpORE03b1d2cEJYS0d1YXJBRUN3bDhtajRTUHlj?=
 =?utf-8?B?UlR6Vm5oOFk4ZnY1TEg1MGEwbmZNQ3lLNHdXOU9DeU5mVmNxVjVHRjlBUlhY?=
 =?utf-8?B?NnUrNHhGYlZVeUU2aUN3cnFYeW9XMDRhRURRYTU4Z1hlYVh3SU1FdUl4c2xo?=
 =?utf-8?B?aHMxclRnR1FzMWRvTEE3K2RwcERFcGFITUN3aUhIK1NkeThneU4wQTNvSEgr?=
 =?utf-8?B?bzdjaDRCaEVMdlpqY0NtenVXdENWamlkcHZZUVJ1TnFpcS9selBZTXV3ZGZw?=
 =?utf-8?B?eVQzRW5ucXpTSkZCbE03aWwrTVNRMWg3WGRNY1VMOGY5V1JmSlplL2ZCQkZp?=
 =?utf-8?B?STc0MTV4eXhFWGkxVW16YUVXb0R0a2NrTkNOSldoNEg4UHZqVTVYeGZFOEs5?=
 =?utf-8?B?U3cvdnBDU04xZGpOSFd0NWpCU2hHWkZGSjR3OE9MZU0vSFhiN3RPYkwvNkt3?=
 =?utf-8?B?dTVKMHdscThudjBlaTJBRTZZWXRUZWxnRW02SlliQ3lwb2lxa0lZelYxRXhx?=
 =?utf-8?B?eTUzUmlMNmV3eTZ2eTV0djYxd2VWS3BQSlBSSG5xaHJ0bEQrdGdlMUUrc3hZ?=
 =?utf-8?B?MmJ0UGVIeDVaK2xTSnk5NTRNN0dFdW1abzY5dGVZQTlkV3U4OURjT3loVml6?=
 =?utf-8?B?OUloY1FoRWh3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(1800799024)(366016)(921020)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bEtQNHUycDJRMmNkem1wQUNDU3BxaEhHMlUreXlIS1RiWWtnU3VseHNIdFBx?=
 =?utf-8?B?QzB2YUpvNURSNWVidVJ1WXZIUTQ1ZU9IY3MxbDdhTWtGRytzWXpTZlBXN0s5?=
 =?utf-8?B?U3htUk4xblZ0WFFpWUVReEVqOC9nd1dncHRBaVd0UGtGWWJGUEpvQmF6OE94?=
 =?utf-8?B?SDJWdmVIUlBoTmRHSkpndkJaOGdLODA1OGI4VTFiRlErNlBLL09WSnQ2eHF0?=
 =?utf-8?B?OVo3N2lzUkRFbDdpOHBkYU9MK3V5YVY5emR6VVhPaERkaE1rdW5vMm5RNTQv?=
 =?utf-8?B?aFlkY2hLcGJ4MlV4dVVhOFF0Tk1FSS9qU3lidEZuWmcvWVRuMmd1ZkhDamw4?=
 =?utf-8?B?Szd2VWNCVW1YWUdQWDdtVU1QVlV5OUN0dnNBdHEwaVhFOFBXNm1pbGZvaTY3?=
 =?utf-8?B?cmpNQy9ueWhaMitmS0ZjNXNMZFVHT09WdGhUdE15WEZSb1lXRlRCV1pGY1Zh?=
 =?utf-8?B?QnVFMlcrSTI5WlViMUpLbGRNQStCb21zZlZaWEhxMUxNUEVZaVo1eWxza0o5?=
 =?utf-8?B?OGRxQUhjNWxFVVJKdnc3amJBWUJnS0dvUUIxdkl1SFFvRUFjSDM2SHdSalpT?=
 =?utf-8?B?bUZWWkFCYXBsY2ZReWk3ZjlsQW9HVTBWbm1iNkJ0SUFuRDNXQXJYSzBBYUow?=
 =?utf-8?B?QWRyVm4rWlo4K2ljZEhjUGRXREFFL3d5ZHBiTlNNYW5jd1R6WnNrME9XL1pW?=
 =?utf-8?B?OG1aRUZsNnJJM0s1TlIrVTRJcWdkMWNCVmdmamlDNk1XeDRRR2NmR0YrQmRR?=
 =?utf-8?B?cFhpUHVMWTczVUY3Tm9kT2ZuMEZYWUlsc3UvV3ZZMUZoZXdZdmhiR1E4MURl?=
 =?utf-8?B?Wk1zNUhPT01kZWFjQ3NobllhNXNzU2grSkI1ZU1LVFFZL2NEL3F5dC8xc05p?=
 =?utf-8?B?eXA4SlNmMitPQW9DL1dPSWFwNXFSRlhoRlhhZzVhZ0Z6eUxObTNVdU10MnFY?=
 =?utf-8?B?dWNseFlncmkyN3N1emFicXl2QmFjemxqQVR4THF6b0h1U2c2ZURBZ25QRGZo?=
 =?utf-8?B?Z0pYaFRnYTA5NGpUa0g2QW1UL2VOdVRCUWdrWHNadmFMSzBLZTRrK2pRN1p5?=
 =?utf-8?B?T0xpL2p1TFN2N24xZXBnU0hXM1Q2UHdwczA5SklsK1o4UDNlckE2QXZsOU1h?=
 =?utf-8?B?dHRnNnljV0pjd2thd0FmcG51dysyc083K2l6ZTJzYk9aOTQ2bHVpU09ZZGly?=
 =?utf-8?B?UmYyU3RkeW01Q1VBcjFYdXE1a3liUnBIeHF5VzZ5OTFjazdORmlPSnVXME54?=
 =?utf-8?B?MmFQc2dDamJvekNuU3lpY2tiNG0wU0FjcjJzR2hJdDBSU0doM1B0ZVQyUDV0?=
 =?utf-8?B?WkozaWJKelhKV2s4bkJDaVJNQ2taNi9EczUvbW9NTVRsVHlFOHRhQlg2SEZ4?=
 =?utf-8?B?azJoZW5xZ0dHMnB5aUdQencyNDF3SHM5Q0Y5RUo5TVg5aW96Q3czMzd3OUto?=
 =?utf-8?B?UjJkMmhvcy93aVVycHh3V2tQeHRablJFWk5FeHJmYnU5aEIwRGlGUHNEVm5K?=
 =?utf-8?B?cU0yclhnTHI0MFplRDNhaHdXKzAwV1BBb0NtUVlTZW95VUdZUHFRMVRMb2o3?=
 =?utf-8?B?R3lvVW4raHMwNzRXN2I3ZHZBZHdUcmRTTEwzeTFXTmlSa2huR2Vqeit3V2cv?=
 =?utf-8?B?Vk9peG91Y1o2WnJRU0ZLZ1ZnOWl6bWNTS092R2QwVFZrYU5uZnZEK1JKODJj?=
 =?utf-8?B?dEFLSWtWRFlGcFp0TVZ2M0pxcEF2cXhFaCs5cURSMExKNCtDZjVqOGNZZ1Yz?=
 =?utf-8?B?NDJHOVo1ZmF4L2t3R0tKTC83bUF4SXJidno1Y3pEMGxpMjZaWm1xcTcxSGk4?=
 =?utf-8?B?aDhySjFhS3VLUERHSmZ6WmdZeHRPOXd5UUttZDA5WUI2S0d0aXZ6ZzVJSkdI?=
 =?utf-8?B?Ti80eEpueURZZDlrb3cyeDdzWXhkWE1YcXBvSlJ6cDFFaVZrZ3ZDNjhCM3Vp?=
 =?utf-8?B?K2pQbXVXRGVpTGZieWRQaUU5ZHpERUR4ajFFemNjaENlL0drQmJsWWlyM1k5?=
 =?utf-8?B?TnlQc1pCMXBPTkwwM1p3bVA0WW9rQUptbkpWSVN3T096akw0L2lVdHlJZ3Er?=
 =?utf-8?B?M215VlQwK1BFME10aU1mOGk3YTJSQkIxYnBlQkgvTmZJeU9LVWhlOUl3SUE3?=
 =?utf-8?Q?mAFpMLqWfrFJ6r+X3arR1iT3M?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19e0dd76-81bb-4569-3def-08dd57e66e43
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 10:55:36.1709 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: krByJpjkFEaiZyo0Q4MFIOQmgR7WB7f4xPVFibrbRs2whpzm0sQ7FoXYvOeXSpXQQbIqQsAUVRX4I2EGm9nHRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7845
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

i.MX95 needs to combine DDR PHY firmware images and their byte counts
together, so add a new entry type nxp-header-ddrfw for this requirement.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 tools/binman/entries.rst                  | 10 ++++++++++
 tools/binman/etype/nxp_header_ddrfw.py    | 29 +++++++++++++++++++++++++++++
 tools/binman/ftest.py                     | 11 +++++++++++
 tools/binman/test/346_nxp_ddrfw_imx95.dts | 24 ++++++++++++++++++++++++
 4 files changed, 74 insertions(+)

diff --git a/tools/binman/entries.rst b/tools/binman/entries.rst
index 780e9817fb..6da3f0b904 100644
--- a/tools/binman/entries.rst
+++ b/tools/binman/entries.rst
@@ -1663,6 +1663,16 @@ Properties / Entry arguments:
 
 
 
+.. _etype_nxp_header_ddrfw:
+
+Entry: nxp-header-ddrfw: add a header to DDR PHY firmware images
+---------------------------------------------------
+
+This entry is used to combine DDR PHY firmware images and their byte counts
+together. See imx95_evk.rst for how to get DDR PHY Firmware Images.
+
+
+
 .. _etype_opensbi:
 
 Entry: opensbi: RISC-V OpenSBI fw_dynamic blob
diff --git a/tools/binman/etype/nxp_header_ddrfw.py b/tools/binman/etype/nxp_header_ddrfw.py
new file mode 100644
index 0000000000..655699e6ff
--- /dev/null
+++ b/tools/binman/etype/nxp_header_ddrfw.py
@@ -0,0 +1,29 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright 2025 NXP
+
+from binman.etype.section import Entry_section
+
+class Entry_nxp_header_ddrfw(Entry_section):
+    """Add a header to DDR PHY firmware images
+
+    This entry is used for i.MX95 to combine DDR PHY firmware images and their
+    byte counts together.
+
+    See imx95_evk.rst for how to get DDR PHY Firmware Images.
+    """
+
+    def __init__(self, section, etype, node):
+        super().__init__(section, etype, node)
+
+    def BuildSectionData(self, required):
+        section_data = bytearray()
+        header_data = bytearray()
+
+        for entry in self._entries.values():
+            entry_data = entry.GetData(required)
+
+            section_data += entry_data
+            header_data += entry.contents_size.to_bytes(4, 'little')
+
+        return header_data + section_data
diff --git a/tools/binman/ftest.py b/tools/binman/ftest.py
index d2802f67e2..811f6514eb 100644
--- a/tools/binman/ftest.py
+++ b/tools/binman/ftest.py
@@ -104,6 +104,8 @@ PRE_LOAD_VERSION      = 0x11223344.to_bytes(4, 'big')
 PRE_LOAD_HDR_SIZE     = 0x00001000.to_bytes(4, 'big')
 TI_BOARD_CONFIG_DATA  = b'\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00'
 TI_UNSECURE_DATA      = b'unsecuredata'
+IMX_LPDDR_IMEM_DATA   = b'qwertyuiop1234567890'
+IMX_LPDDR_DMEM_DATA   = b'asdfghjklzxcvbnm'
 
 # Subdirectory of the input dir to use to put test FDTs
 TEST_FDT_SUBDIR       = 'fdts'
@@ -202,6 +204,8 @@ class TestFunctional(unittest.TestCase):
         TestFunctional._MakeInputFile('fsp_m.bin', FSP_M_DATA)
         TestFunctional._MakeInputFile('fsp_s.bin', FSP_S_DATA)
         TestFunctional._MakeInputFile('fsp_t.bin', FSP_T_DATA)
+        TestFunctional._MakeInputFile('lpddr5_imem.bin', IMX_LPDDR_IMEM_DATA)
+        TestFunctional._MakeInputFile('lpddr5_dmem.bin', IMX_LPDDR_DMEM_DATA)
 
         cls._elf_testdir = os.path.join(cls._indir, 'elftest')
         elf_test.BuildElfTestFiles(cls._elf_testdir)
@@ -7827,6 +7831,13 @@ fdt         fdtmap                Extract the devicetree blob from the fdtmap
         """Test that binman can produce an iMX8 image"""
         self._DoTestFile('339_nxp_imx8.dts')
 
+    def testNxpHeaderDdrfw(self):
+        """Test that binman can add a header to DDR PHY firmware images"""
+        data = self._DoReadFile('346_nxp_ddrfw_imx95.dts')
+        self.assertEqual(len(IMX_LPDDR_IMEM_DATA).to_bytes(4, 'little') +
+                         len(IMX_LPDDR_DMEM_DATA).to_bytes(4, 'little') +
+                         IMX_LPDDR_IMEM_DATA + IMX_LPDDR_DMEM_DATA, data)
+
     def testFitSignSimple(self):
         """Test that image with FIT and signature nodes can be signed"""
         if not elf.ELF_TOOLS:
diff --git a/tools/binman/test/346_nxp_ddrfw_imx95.dts b/tools/binman/test/346_nxp_ddrfw_imx95.dts
new file mode 100644
index 0000000000..889f6f2986
--- /dev/null
+++ b/tools/binman/test/346_nxp_ddrfw_imx95.dts
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/dts-v1/;
+
+/ {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	binman {
+		imx-lpddr {
+			type = "nxp-header-ddrfw";
+
+			imx-lpddr-imem {
+				filename = "lpddr5_imem.bin";
+				type = "blob-ext";
+			};
+
+			imx-lpddr-dmem {
+				filename = "lpddr5_dmem.bin";
+				type = "blob-ext";
+			};
+		};
+	};
+};

-- 
2.43.0

