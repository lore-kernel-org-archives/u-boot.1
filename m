Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E9EFC369AB
	for <u-boot@archiver.kernel.org>; Thu, 24 Apr 2025 06:34:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9CCD4815D1;
	Thu, 24 Apr 2025 08:34:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="HvjF6vC3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C32D5819FC; Thu, 24 Apr 2025 08:34:10 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20630.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::630])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BAE9381FC0
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 08:34:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yYFL2Xm9VRwm34tjqgTmfFOG3H5ayjlVW/7TTfSElrpPcnJHBS++EMpDutmUmuERht6L4edihga5zpyQzc/vV3CCl1VyTXuaACgpeSjXhRWNBndroqCyx6KCfljAaogAWmCaYn9HNSje6kVHA4H5oplXS6hba+Njo/7rol/e6w5Qm4PMzKlwza/gQglrjXg6CEgsjgqROxzKW3P8j2chVqldspX/SDb0vX6G/2B8tYLJafbLPUkD/9+36dNt88WCrOolfLCz+6HAQvHQL2TdG0eAxZ+1ymQc49gquL74/rMKL856N4Q+7dK1zIYE6DTOWQSIo7yckPZMrV7sms3ohg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Powlx5EXxw6qes7NWi7d9Bi9N3K8J1nsnQHXNc8j+b0=;
 b=ByNMqeU0PbjZDzSmv32fbX3JWik8STO8r5RuqLbC24R7fHW7VHNWIeXdtJe5ayk7JNMHgXOZeORrwU72dColLtqwDlm86Yt9IUzkwL4+C3FdHSaYxcEbSlHvhvoEa+NU5vK9xn3sJQ02pieqaqdcCX3UGPfUsM+GZR84+Hvptj3O6qY0E2uBlfTdm4ZgdxJryeHTkaewkE3C7a+p/tZ2t5fdiuzxP9laBKqA9iEglT2FTiJMqltfy5rt3Y7pyIb4jypJpP9tkNdZZHSzp4G7yqxuzaXdXk6WOZjDNY0FQcehPLRXaRSjZIEBGm2S1J/JNWzO2yT/ZBZHXUOBTFExNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Powlx5EXxw6qes7NWi7d9Bi9N3K8J1nsnQHXNc8j+b0=;
 b=HvjF6vC3DyW4OyPUXnDmZTPHrEfPr/hWo4e3LTBUziohl6BSq0gxpTrOZM+6cZ+AZZBRmzSK/nNnPyIkxZryh1ZM9Q+RQ9ZcigijJMR/E9/7aAppU39gI+Fj02/tHp5uwTWHv9muq2GwLnPZQYXNeTwmd5jkWFfH+ASoJHuAtvu0KltkmPr5DDzjYS29beyezz0A2gdwjHRTSnp3CeGrrzPikHg8db11jakIKnTlegGcDyNBaCJ7MxOSrRmV6w7G66dQqkR0G3JuJlMHPC1pBxZWTAMA3esiCts1NOluhQkKOjrGEHVBLzaOkohG7x79NLZ1dLPrRq5rFXl0fTZyog==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by DU2PR04MB8965.eurprd04.prod.outlook.com (2603:10a6:10:2e0::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Thu, 24 Apr
 2025 06:34:07 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%6]) with mapi id 15.20.8678.021; Thu, 24 Apr 2025
 06:34:07 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Thu, 24 Apr 2025 14:33:00 +0800
Subject: [PATCH v10 04/21] firmware: scmi_agent: add SCMI pin control
 protocol support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250424-imx95-v1-4-10a8449b1e5e@oss.nxp.com>
References: <20250424-imx95-v1-0-10a8449b1e5e@oss.nxp.com>
In-Reply-To: <20250424-imx95-v1-0-10a8449b1e5e@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Simon Glass <sjg@chromium.org>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>
Cc: u-boot@lists.denx.de, Marek Vasut <marex@denx.de>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SG2PR01CA0140.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::20) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|DU2PR04MB8965:EE_
X-MS-Office365-Filtering-Correlation-Id: 1518fdb4-d087-4796-3d63-08dd82fa0373
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|7416014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TVV6amlOTlp0ZlFCWXRvVEdDN0xmeFQyMEdvV0hXcWhITjJGaHVHRE5MZUVX?=
 =?utf-8?B?MHMwNVJQeHVHT1ZuaForMGJNLzVzejc4NkxGaHVBek1IcUNlbndIdkRvUUti?=
 =?utf-8?B?aDJnZWgyRHZHVjRleGlxeTlyVnp3SmViVjUxWG5tMjZWb1cwaHUvU3MzZjBu?=
 =?utf-8?B?S3huNXRTRkh4YXhLRU5vNFRnd256WllzUmxRSzVFSHhSOHNoMHd5dFl4NW5V?=
 =?utf-8?B?VmF4bGZJaWF3T0ttbmZVa1NyWFRSM0hRNWlYNllRWVYxZ1lmSGdGM1JmWUZH?=
 =?utf-8?B?MmFMSlpnWlY4VjJxeTIya3duZGN4T240WldrVmNWdDUwSThwZFNKbmMwL2dG?=
 =?utf-8?B?ZFpNV2c3eTlCMVdGSzVHb2cvMlcrSzkxQ0lYNDR6bHNHWllBK0pYK3FGZmtB?=
 =?utf-8?B?M1d1K0pVbE5CN1dJTWtneVN2aitFamVYR3podHlrL1NEblFEVTkzbi85RGN1?=
 =?utf-8?B?YTZ3SlJyQnpoVlR1YVNjRnROQ3h6djJ3ZDZaYnVKQWdHdlZmRm84ZGk1U1RV?=
 =?utf-8?B?cWN3dTAxeHpnb1FEa3NaZjJWNHhUSFJZNyt2RGlFU1hyaFhBRnN2Kzgra1JT?=
 =?utf-8?B?QmREVzk1Um15eXM1dHpObERlYXJoUmZiSEV6S0Z1ZktGSjl0Y3FHUkxzNlFT?=
 =?utf-8?B?WnpyUkpmLzMxdG80K2pvVXI3MTQ0VnBsUnhHRkY2WldmbHR2YWp6YlZ5cjh3?=
 =?utf-8?B?ZzdocmlqQjdIR2FCUjdsaDM3eTZBNlBETU12Wk0yRHM3UFVvcVR6blNqRURG?=
 =?utf-8?B?YlJXZnhLWVRPRGpCUU5zNmM3K2JGb1IxQ1VTN1JwRzRMVzNEcGNUb28vcXpn?=
 =?utf-8?B?QWxBaDE5Ym5HWUZ0NUNzdDJTSFZYQlFBb3ZqNm9iKzlQNWhNL2FjcWg0WE4v?=
 =?utf-8?B?a2ZNbUZUMVNBczVkUWZlKzh2QkZzK0pVTlRxTFBrN1pacWt1VTdqMWVYVzBX?=
 =?utf-8?B?TnU3dS94Q3FDblAyTENydi9sSnRpanlFWU1BNU5VTmNueUJoTkkxc2Vkd0RT?=
 =?utf-8?B?TzFteTFBS3RzREwxVHd3cU1LTDhkNmh5Njl0ckxIbVJ1VlNUd3JMc3ZldWpX?=
 =?utf-8?B?eUpNSnpaMldPT0FCSmVDNS9ocEFRcmxQVENnYUV3Uyt0OEVZWTQvY0FLUzEz?=
 =?utf-8?B?dkhScnFuMjRQMG80bXVMRklQLzZxZEZYRDZLVTJodkJQOTN2Mm5SRkNhMzdn?=
 =?utf-8?B?N25NTWRzQXJXWlpMVmovRnFCTjgvS2VkR0dLZnZGeWZIQ2ZSbTBxWk40Tjhi?=
 =?utf-8?B?Y1A2TVdOaHJqTmZNQmlhT0JQNHZzSWhtNFBVQitITmZoQTR4OThQaVFsclBF?=
 =?utf-8?B?QVM3MUpvY3REV2hsbkxEaUFFa2ZuWVcyYyt0dkNkM1lIYVJYRG5FdENwc0lP?=
 =?utf-8?B?ZklJVHVOSDkrQWtzZU1qYlZoWUZEWnJNeVlLRUIyYlVvblN1TlkvZXQ1M2Ez?=
 =?utf-8?B?SnpoK01yS3ZyVWgyOXVqcTZoRDZPT1EwV2FIZktWVnArem9FRnJ4dzBmZGR0?=
 =?utf-8?B?d2Rxa3QxYXRCZDFzZ0t4YldhMDhNeVNRRnJVQTZUZmRXSWNaOE9uUWJ2MDFq?=
 =?utf-8?B?b2ZhSDNvWkZBVElqZEMvdUIrL3dEdzh4Rnl4MWsrRjY1Yllnblg2d3hSSjJX?=
 =?utf-8?B?Zytyd24wdXMxL0xUN3NxQXR3TUhEUmJoS1dndEI5K2JBZjlsWmkwT1QyeWtz?=
 =?utf-8?B?YnRsSEh2OEk5N3VZbGc0bzhwMTBSSXRYUWpIRUtEbmtjeWNJLzhhZU81Um1Z?=
 =?utf-8?B?NGxPRm43b1pjM25TRk02ZWwyZXpmd1RUMkVnU2RDbFU5ZCs3NmZwNGJleFVR?=
 =?utf-8?B?UWtyUHdxeVhZemRSS2dpZUltL3cvWWdrRkR6QmpSSmUrMzVBVi9IWUFlNXl1?=
 =?utf-8?B?QjhjZlMwZzVBWWc0MVpaQ1lCU0dRbGdXdHNlSk1hYjFBMVV4WEkwcHdqKzBr?=
 =?utf-8?B?YXNwb1BjenYwZ2JidGE0Q25ZYytsVXpZTlJVM3VYOXNrNitFWkNzRjBGTHFu?=
 =?utf-8?B?alIyMXNXYitnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(7416014)(366016)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S05Pb2psWUFKWFlGS1Y3L2NlVDRrVkFhalNxVEtRRStYQnBtbFlIUTgwVFFn?=
 =?utf-8?B?VFZicnVpbkJEZXE1MUU4SnhWcUxpQmwzSzNPWEVKQTZhRG0zQTJ1dGovZkYr?=
 =?utf-8?B?U2lkaEtCenNBMTdGSUpCRzdadSt1dGUvSUsvelVuSzZjdkZzd1o5NzBEcFc3?=
 =?utf-8?B?T0xIYldGazR4U0FqWWl0WkZDU1VLQXdFNFRpL01aWm9Eemg3ekxON1pPTU1i?=
 =?utf-8?B?czdZeitxTnNhSVlnYjArRXQ0bytXVktsTEVoVklDbE9DdnpjMGxFY1BGOXRt?=
 =?utf-8?B?SEdHVDJHUyt6WWJFRGhKZS9TNVJZNW83Z1BnQmttQVdHaE9Hck1SbEtySkdL?=
 =?utf-8?B?MENaRUF0dDZWRFhhNjl0QjRSaktJcnNRYXprNSt3NVdnTGlPeGUvcUUwQ0hV?=
 =?utf-8?B?eTBWK0czbkRUdTFvV25qQjdaSEw4NlhNWjFJQ2MyY0wyY1B4RWxOcjRwckVN?=
 =?utf-8?B?VVRHQWYzVVZwb2swU1h1dGlTRDEzcm85RVNzeHgyRVdmSHBjZTE3bHViQStK?=
 =?utf-8?B?VHVWeUFPYTlCNkdsWlJNS01TRXZ4TlpOTEVLTVpLRmI2bk41WU9yeDJjYnM0?=
 =?utf-8?B?dTdPTlRXYmxoMGlpMFpoQndnQXhncTV6L1Jza21TVHJKaXVvZFMyaElkWUs5?=
 =?utf-8?B?dytEVjJoK2pNQzZaR2lodWZScmZyaEZjci9MRklxbjlMOWloUENnMnVFZE5X?=
 =?utf-8?B?dGZDWitpTjc1Ykgzdzh6V2l1TkdSSkFFUnN5ZUp1Tk1jYjhXS0ZiakExS3Z5?=
 =?utf-8?B?ekQ0ZDkyTHMrb0E5WVJSdnBmMmdDQ3F4VEF3UHpSZ1ZOV2E1enJNVmRLaFE2?=
 =?utf-8?B?NjFXNFIzOGJiQTdlTnhqY0ZhamYyRVBEblArVmhTUWxuSERFME81QWNoNXI1?=
 =?utf-8?B?dlFLUzF2R0pqSzF5MFVzalV3QmhaMFdRV09ZL0RxUDhhVEJNcElzOG9uanpz?=
 =?utf-8?B?aHRCbXFUTW1STTRxd1ZNWDJKOFFObWFDMjB3dWgvTWhWNWo1cXB3OUU3eGlj?=
 =?utf-8?B?NnRadFhjV3p1MHRTMWc2bjdGTG43OGlTcWJxdDMvb3FDNDlOdDNjV1NEY3Nt?=
 =?utf-8?B?UnZtOWpMY0F3L3pUVXFTeDArb1ZiTW9sL3ZxUEc1RlhUNERRY0ljdUI0bEtR?=
 =?utf-8?B?RnE4QUZ5V0xBQU1XaUM3WG9mTGw0akVIVndHRTA0dmpaREN6ZFR3N3U1VHVZ?=
 =?utf-8?B?Wk9EUllxSWEwWGFaMlZQZCs4RnRNSEVVOTdOOGlvZ3A2N1FHTFMreEFNaFVP?=
 =?utf-8?B?QnF4VmdHMmkrZnozWEdKbzhwbEJmUEgxMDlIc2VUQXBkSXMyMUJ2YjhQM05x?=
 =?utf-8?B?ODhuRjFIUzVDWFJWT3FqUjlncExaSFN3QkhOMnZpUEZMMU1qcmllMm5pclN4?=
 =?utf-8?B?OEZQYmZnRVFUdFpQSHAwRTk2MWo2Y0E5d3hVU3lSVnBldVpzNDB3WEdyVWov?=
 =?utf-8?B?Z2xFK2MvQW9RbXk4bzJxdFBnV212OEVjM2R3KzlSTTNpZ1lFVXVFbWNYSFdi?=
 =?utf-8?B?NklOSmI5aDVKdjQ3a1I4THFXSmlZRFFteHI4NWJjL3F5OXg0STNHWFlLM1NZ?=
 =?utf-8?B?ZmpmRUNWVUYybC9pQTlkdFZGWm5UWW43N3hXMm5aOGYyd3dyUm4wNDZhMllB?=
 =?utf-8?B?MzFMb3M5dDJNS0dWaUtCd2VXcVRXUlppSWpSUld6YXNqcWVIYjlQajBSNmtH?=
 =?utf-8?B?QkxNZUhsSk5TNDhLT0c2M1ZSWVpjeVhQTjVzMjBQakRVSVJqYmpFNjl1NklX?=
 =?utf-8?B?UHVQeXFwMTVRZGZaM0UxTHJqTjNMa1ArK0ROQmxPNHdQU2lyUzB5WENaNW9W?=
 =?utf-8?B?Tk5NZ1l1SnpSZG5vejZNME43ZzdxaGxDRm11NFJsT3ZxK1BML3c3RFExeXMr?=
 =?utf-8?B?UGQ0QUlXcHVGZWIweHZlT05wejRUVHFYUWNwTHZtK0dHNm5oRjczbmxSbHpq?=
 =?utf-8?B?b2hFZWZxR3BlOWdld1pWNlJtbXlwak96VmJNbzRWNVZEZS9BY2hoMWxRQ1cr?=
 =?utf-8?B?Nnc5N0l5d3FlUlQvQ1lJU1BUeTB5M0FORjRuMmIxSXh4UWpJNUwyMGE4MFJn?=
 =?utf-8?B?azBCZnd3cjE5cVhPYzBrNkIyMXNUbWRhMjF5ZDlBd3lJY0FrRXNLNS9Za0Yv?=
 =?utf-8?Q?WfSqbrjVf0rtG/uJEXNkfsm79?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1518fdb4-d087-4796-3d63-08dd82fa0373
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 06:34:06.9340 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gPkrBfQkUejU0+YSk7H9xzF6xvtaV5RK6L+IuvIzS5BxO0jAT4cVeRJJtNxJ2hawkRclGEYZ+9PY/IGAx938Rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8965
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

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 drivers/firmware/scmi/scmi_agent-uclass.c | 6 ++++++
 drivers/pinctrl/nxp/pinctrl-imx-scmi.c    | 8 ++++++++
 include/scmi_agent-uclass.h               | 2 ++
 3 files changed, 16 insertions(+)

diff --git a/drivers/firmware/scmi/scmi_agent-uclass.c b/drivers/firmware/scmi/scmi_agent-uclass.c
index cc3f31d881e..e7ec2c108e6 100644
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
diff --git a/drivers/pinctrl/nxp/pinctrl-imx-scmi.c b/drivers/pinctrl/nxp/pinctrl-imx-scmi.c
index 20ea55d40ae..cc92dd89466 100644
--- a/drivers/pinctrl/nxp/pinctrl-imx-scmi.c
+++ b/drivers/pinctrl/nxp/pinctrl-imx-scmi.c
@@ -9,6 +9,7 @@
 #include <dm/device_compat.h>
 #include <dm/pinctrl.h>
 #include <scmi_agent.h>
+#include <scmi_agent-uclass.h>
 #include <scmi_protocols.h>
 
 #include "pinctrl-imx.h"
@@ -152,3 +153,10 @@ U_BOOT_DRIVER(scmi_pinctrl_imx) = {
 	.ops = &imx_scmi_pinctrl_ops,
 	.flags = DM_FLAG_PRE_RELOC,
 };
+
+static struct scmi_proto_match match[] = {
+	{ .proto_id = SCMI_PROTOCOL_ID_PINCTRL },
+	{ /* Sentinel */ }
+};
+
+U_BOOT_SCMI_PROTO_DRIVER(scmi_pinctrl_imx, match);
diff --git a/include/scmi_agent-uclass.h b/include/scmi_agent-uclass.h
index 842c56858af..d6586eb3ff9 100644
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

-- 
2.43.0

