Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC9E9C87FCB
	for <u-boot@archiver.kernel.org>; Tue, 12 Aug 2025 09:45:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE57F83285;
	Tue, 12 Aug 2025 11:45:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kontron.de header.i=@kontron.de header.b="LBGwYYEK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ACA598328F; Tue, 12 Aug 2025 11:45:03 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 763FD83285
 for <u-boot@lists.denx.de>; Tue, 12 Aug 2025 11:45:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=frieder.schrempf@kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nywOcBl+r9QjMHi9bPVJ5m+HBx8mcXDR7MpOEJiJE+gH+DLs8ujK0z9QCghSG793RUUv+mQdYgy11IR6ojf1gDRWyMT1Dl97L0nNbz0uYnQkd9n2yNRAYO2GLQX0j/wgFsyrOqJR2nsZUiWprOZj0IGo1DVECTGFme8j59HOg9E6/0YdAV9nczjR4jOrFwE9+8u+8mOVNxGBlL8LTdH5ZIcXCmg+csdwzWNypJcw3zIYPFZ+K9Th+zk8L/w/d8mQOYSduHt0814ko68Ek4MUjtYd2MtpPAj2FmjFjBAyew2EBXgk0VPB6Z5Hilo0szlIBOi6M6W54o6GlbNeac//xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xGHvMbc2QFbiN+XHbnAEvg7dJDwWPmISCl8f8bIlAjU=;
 b=gmrweroItlSm9lJRp5pZRVmPblIqxQH0ngaM7JCbJVR7z2CS2fvUKk1oPACdMwJ7OBA/QttV53UW464brdvfcj6e0ntY7N4bKdZaVclL6QSwHsAwJ2tkXM1Ti7tlH3Vu/alfiqhftMT9mE7n8JQtS3lxlPTJNgcPsCeiDFGKZ1hekT7IB9GWwHGmuD1AkdmF6z2VC7cvmJME3fAZ8GTTi+XIjt7fPXVi5Rr1H6DpqiqIzrNNy8OtaTLBCfxm6QZfVPU/G1Y/NEaKVHbGmn6w/9pJZb5njoc0RVbiit1QVYOqiN+tO8ZZzKuZEy7rpZUU96jYYpMYsDRvQV0Szw0rQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kontron.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xGHvMbc2QFbiN+XHbnAEvg7dJDwWPmISCl8f8bIlAjU=;
 b=LBGwYYEKWDRpGxSbCzLgL5aDbz9K4yKNKuuMYr20sH3FuXvlWc9Tmtemzf2dLLcaqQ+VipCxU6t4XsWvksf/96U2Ai6pC9QBOXipmo/mMqASwqsML3J5tbwDJ4tsKr4UxCUJETu3Dy6g+URW1FBPvj/2OvwZxTNFGsISK9CxDglP78ERt/9lWjqmA1Quvimcjmm/gsNKp9k3yuglD8jSxaXN7XKiVeiHMD4tUN0rl0Zy2xL43bcHp+YYj0Gu5bziBOKhR5ZEjkEC3R+gnjrcTml2SRiBvGPt+E9xTn2H55aSBNBFlVxUJMbKIrmJQLhPQJ0X2Ij6tLapnmJ2IlhvfA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by DU4PR10MB8974.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:562::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Tue, 12 Aug
 2025 09:45:00 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19%4]) with mapi id 15.20.9009.013; Tue, 12 Aug 2025
 09:45:00 +0000
Message-ID: <bf4d2853-9fc1-42f0-aa50-1dc0a7af4a64@kontron.de>
Date: Tue, 12 Aug 2025 11:44:59 +0200
User-Agent: Mozilla Thunderbird
From: Frieder Schrempf <frieder.schrempf@kontron.de>
Subject: Re: [PATCH v4 07/24] mtd: spinand: replace enable_ecc variable with
 disable_ecc and update corresponding logic
To: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Tom Rini <trini@konsulko.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Cheng Ming Lin <chengminglin@mxic.com.tw>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Chuanhong Guo <gch981213@gmail.com>, Christian Marangi
 <ansuelsmth@gmail.com>, Alexander Dahl <ada@thorsis.com>,
 u-boot@lists.denx.de
References: <11f6f79e-0622-42e2-901e-16335ad73409@kontron.de>
 <20250809010457.3125925-1-mikhail.kshevetskiy@iopsys.eu>
 <20250809010457.3125925-8-mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US, de-DE
In-Reply-To: <20250809010457.3125925-8-mikhail.kshevetskiy@iopsys.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0211.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::6) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|DU4PR10MB8974:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a2b50cf-ca7e-4e1e-d00e-08ddd984e7aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|1800799024|7053199007|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NmFXcDVkaWtKSk95bTRRM21YcjBqd2hReEo5K2lKbUxwYmpVeWpGNDU4ZVNI?=
 =?utf-8?B?czM2SU9mSjF0UFdvTE5TaVpMR3RzYVo2c013eE0xeFRXYWprbXh0NUpJalhj?=
 =?utf-8?B?MWFMMXphNUdQZjBhcW5TSWptbEJHdUZJb2cyLytybnA0ZGloclA0WWhENWVz?=
 =?utf-8?B?S0VNUFJ1R3g2VVpxMVJKM1Z1WkxObjR6YkttcTQ0eU00d2l6K0ZsckhDQlM0?=
 =?utf-8?B?VnA2VUE1cWR3VEcrOWROcFZ6N2RXcTBpajJ0TnRXRy8vanpSTFNTV3pYYjUr?=
 =?utf-8?B?blNkRTRXMHphR3BYVVJ3dDYxY1hKWUFyYVpFVlloV1V1eEtuUW5YK2dmSEUz?=
 =?utf-8?B?NFIwRVVDazJUUUZ6bEJtampvbEFJZG8xUFdFL3lVSkhIZTJjSFFNdkt2Wmpl?=
 =?utf-8?B?WUFRS2JPNzV4S3NEeW83VUxZMm9NT2E2VWdQTUtTc3drTHhoMUlVUjRXNWt5?=
 =?utf-8?B?c2VyZDNRZ1BhaUk2TnZQeFlLM0VXTHNVaS9IdDluN1lYSjFOZGJ3QkdybU40?=
 =?utf-8?B?ZXU5cUhYT21kUm81OUJDY1VnQnExUzN3eElERXgybSt0eGxST1dHL3IxbTJ0?=
 =?utf-8?B?UkNRZkdJM2dPTGhkeFpCTUx6aEF0bndBc1BwOXBUZElnWHJGandtdjRsUytB?=
 =?utf-8?B?OWNYVjRjUDJ0WDNBU3dNN2JBOUMyS2QyS08vYy80d0kzREVJWlgveGhlT1ND?=
 =?utf-8?B?K25ZQnhSUlRGMzlYVFdCZ0FHZnFncG9GVVB5WWV2bDFGMjFnTVpOaXNCQ2ZX?=
 =?utf-8?B?dm5kVk5hSHhJMGw3djBxN2dMOXdmNnhpVlhOVjBNVFlqT1p5VTd4bGo3QU9w?=
 =?utf-8?B?dEdTT0NaR1p2eEVITjZBWFBNd2FTeHRrUDZUQ3hRZlJkSThzTFpKS2xBR1JF?=
 =?utf-8?B?d0lEVmtmQmpoMkg4ZUVjVGYzQzcyYldXQUpxVC9qVUtDYmRyMXcySzBmQ1Rh?=
 =?utf-8?B?M0VHb2loWUZzNHV1ZlplYmpTaGlmQWlGbDdhOGloUEtTaUgySzN3QUVvdmJR?=
 =?utf-8?B?SlJGKzlFd0dIVklGY3cvR2UzZjhzdDJaMC81M2laaTZYMlFqN00wQ2hvS0Mr?=
 =?utf-8?B?RGFuZGVXMG84TEY0WTdhZi80Skt1TnZUM1U2Y1p0ZGNMQVA4dXliSFlVVjZp?=
 =?utf-8?B?MHVZNFZ1VWt3cGdVOUdWcEtHUmVrd294U2ZEVG5Odm1wbzFJd0Q0SUREYmYv?=
 =?utf-8?B?ZUY5TU41Vm16blM4SG1zR0hBR1hTWUwwb3lnYmpqSThXSDNBbC8rN2ptZjMz?=
 =?utf-8?B?T3pzZm1RS1RwdDdjY1VWcU9QWExKdlNvQkxzQ3lBR2VkY0VlV0NzbjFKTlQ0?=
 =?utf-8?B?U281eVpYMk80N0lPOWdYUndDMnRXdytZNkQ3dElHY0VBS0FHQ0RGbk44anIz?=
 =?utf-8?B?dnkzMFRZbGRPbU5CanVtUnJrYk96c0NiK3hZV0o1SHVNZDhWT3hYSXdaWHdI?=
 =?utf-8?B?Mmc2bDh4M2pYcDJtd0J4TTh0ZU55OVdxV3ZkNmEzdzhRcHduU2hqNTUrUVo1?=
 =?utf-8?B?L3cxZ1ZPSm9xOUdMMXJqTDZaRDE3MCsyQW1uNkNvUmVzUC8zYWt5SzdqeFBY?=
 =?utf-8?B?RzVaRUpuamxaR0NSdVdtM3I1NVhiMnNKK2IyMC9mUHR3ejhSQitqeDJtcDZK?=
 =?utf-8?B?UFg5d3JuOFZKNy8wa01FOGFBNGhKUHhmeE5SK3dRVHpwbDhWeTdmaVdxdzFy?=
 =?utf-8?B?NFdQdG9wQUJ1aHpva3hGc3p5MHUyWDJWU3Bsd1pndkhhYWRzUFA0UzM5U0Fn?=
 =?utf-8?B?REc2MC85L296RnpCZGVNUTJOVzYyZFh3MVFCTkU3Z2pPWTNMSEtvRGxFMWh3?=
 =?utf-8?B?NHM4KzB5bVUyQkdWZEdRUHRzVURMUHQrcjlxU1NoNFJGM2diNlFpQ3FFTnFN?=
 =?utf-8?B?Zm5IempwQmRhVzV5bmNFb2hlNm5jOHR0Q0tNMGE0cnZLSUpndGF1RnpPcnB0?=
 =?utf-8?B?TTBoeVhlenErVDNLT2lOVzdEbGVNbWpQWUc4QnR2MGZneXprcFcxOHViZ2E1?=
 =?utf-8?B?WS8ya3lrQ3FnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007)(921020);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dlVnVHBvZTBPdHVsdWN6aGQvNE1Wd2cvQ1JZUHZReHBUOVNUZHdFV1NRRGlq?=
 =?utf-8?B?MUtoYWRpWmV3WE5zTFplWHBGWHNRejlES25EeGx0NVRESHBtYVdXV25XNGYr?=
 =?utf-8?B?ejdaZ29EWkthRVltMEloaFB3bHN5QVMvTmR1d2dHWDZOL3VQRGt6MTY2VzlP?=
 =?utf-8?B?RXJIV2o0WkhMVmc3S1M2WFlDSDgxSDBibU93L0ZEZFBPOW9CQ2J6UUV0Zitp?=
 =?utf-8?B?OE5tb084YWJldnJCNnUvV0VMQ3pGNk9PNzIwU0FqU0RabWgxWVJTYjhTSUJv?=
 =?utf-8?B?SkYwcThSQVU3c0R2RzVEaEN3dCtrQzVhcWdNZENsUWlzK1EwNjZFSDZyWGFj?=
 =?utf-8?B?WnBtcWF3aXFXQlh0MUdnbndxcG00MVVXSFd5TWdYR0lVdUxjT2N0cE4rajJi?=
 =?utf-8?B?QzViVkxCTkZPRDdIQ3IvZCtPTWMwMTkvekpiYUFUUnVMdVBPdzY2VWhleHpw?=
 =?utf-8?B?dW5yWDBBTGhyckh2Yks5dWdyUHVIZTA4TmtJMmdhMzlxVTRGeXk2WlVnMGo1?=
 =?utf-8?B?RjgxR1V4SnRzZWY5bmVVNHN1Mzd0QzFxQmZPUXZmbm9sNVh5dlZ3K1FwS1di?=
 =?utf-8?B?R0RwN0orS040WUlRMHA0K3UrYk5naHBJdnBEYi9rdldPMG5wcDVOVVpNeTcv?=
 =?utf-8?B?K2wxZ0F0Tk91a3V6MldnRWVhWVQxaXpUUmRtN0o1c2dhUE0zdG4vVXJFSHY2?=
 =?utf-8?B?UmhVOXdGU3BDK1ovR0prcjZvbjFQcTBFVFBpaFdaSnpGT3NlTm1TUVNkRWpi?=
 =?utf-8?B?WkdvbEpFUDE0Z0ZES2p4QUVjamZGemN1VFFRcVpyYkZsb1JMRkh4c2ZaeGc5?=
 =?utf-8?B?VWkvSG00MElyN290UlRGS2RzL2Y2eW5sSTZ3THBVNVpoNWdzM2pTQkgwanBS?=
 =?utf-8?B?OVhDUC85RjZEVzVDclA5WkRSVkJXc0ZwaVJRMkRUdXNkT2p5aTh0U2ZmQXZq?=
 =?utf-8?B?NUNTL1FoWkozU042YmJTRzdURFBtc2pxSTUybDRBU0tBbGhNOTJ1YXF0bWV3?=
 =?utf-8?B?b0k2dlhtNlAzaC9aVGJZdkdXUXg0ZVpBUW9hUndNc3VHdmN2ZENRUW9mSnJU?=
 =?utf-8?B?endlVlFrRldiQTRkMHViSFk0ZlllZGNaWkFtclUxR0h1UUtsakJNZ1h3Y1FC?=
 =?utf-8?B?ZFZwcFFRUWhPWmw0WDlYK1JnMEkzYVl1dU9Wa21YajdRNlRaK0NGREI3akF3?=
 =?utf-8?B?NFZkSm94VGkyKzl3bUZZbXhXWTdHT1d5MHk3NGpESVdabGlzUUJVMDhXRjk5?=
 =?utf-8?B?amVaVUhjMDR5Qnl0Y1d1R1RWaUFaN0dmbk80c1AyWVhFRk1OaVFKL2xKUjdZ?=
 =?utf-8?B?cENDMC9RUm10NkxLUGRYUTRYY0gxQTdoak1tN3NoYXk0QVlNRkVRNU9pNHRo?=
 =?utf-8?B?NllZZUwwK0grdzRiKzI5VTU3RjIra0hwNS84cE5Bak1IK2RmaGxyZDBkNkZW?=
 =?utf-8?B?akEwcVNKSExBcHFoUjh2QjY0N0NudDRHbWM0SGFFbDJhMENCOCtmazJHd3Fx?=
 =?utf-8?B?Ni93c0htOTJLb1VCTFIyM2YxUmdOQm11MFllcDRXS09yM0JFTWFQaXhzK2oz?=
 =?utf-8?B?NVJXNW51dG95YWpxSFd5YzVBV3NzL2tubWYyWU5QRVU1U0JVMExiTmpSYzZv?=
 =?utf-8?B?aTRRY1pSVUlhZWZTaHVUTUMySHJIOHNRMDcrUkZuZUhoMHRUK2xLWWgvdHFw?=
 =?utf-8?B?cS8rNXp6eVN3NDFlL0xCMVcvclNHZ0pRTENWTHU0QzRYbEZSd2Y4KzhERDQ2?=
 =?utf-8?B?elYxOEt6MW9pcG9STU05eVduNjZBZ0V3eTh0YkFZenBzRHZBNXNmdktXYmtz?=
 =?utf-8?B?aTlIT1Q2TXFQbGxwMGpySFBTMndSYkZac2pEazR3MjFLMVI5eVlDWjN0WmpM?=
 =?utf-8?B?V2psUDlhZlVLaUtaUklqYTdLSGE5WUFOakwrdVlob3VqRzAxQ0I4MjJGeFFF?=
 =?utf-8?B?Y3VCRjlKUnFlVXhHKzg5N1ViYU40YUZaSHdmYnFSdTNpcmVzUC9obnhHTW5n?=
 =?utf-8?B?eFBDZVV3a2N5RllzVDNLRW05QUFFUGhvbm5idVUxTVpBN2ZlM05DVkFVMjVu?=
 =?utf-8?B?ZkpiTEJWRXNDRXZmUDVFb2JaRi9yY29JZ3U4VFcxS2Ruam5URnRxWEpoa0Zs?=
 =?utf-8?B?bkhoRG51Zmh6MnMwSSttbnRSeXNVdFROTlRBc1l5Y3BSS29iT0ZvQ1JmeWdV?=
 =?utf-8?B?N3c9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a2b50cf-ca7e-4e1e-d00e-08ddd984e7aa
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 09:45:00.3622 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WqYZMwrfBBBMGCZtp6BbvGG61HSe53AptbYyyazS8x4p7gpT4Lo+D6BoFo0GsvetZ0AGNMrEwsrSWvLGDQ/s07QIJ8hiCFYJOSkQZDZCZEw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8974
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

Am 09.08.25 um 03:04 schrieb Mikhail Kshevetskiy:
> This makes code closer to linux driver.

Nitpick suggestion for subject and commit message:

###
mtd: spinand: Align logic for enabling ECC to match Linux kernel

This aligns the logic to match the Linux kernel implementation.
###

Anyways, this is also good as-is:

Reviewed-by: Frieder Schrempf <frieder.schrempf@kontron.de>

> 
> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
> ---
>  drivers/mtd/nand/spi/core.c | 24 +++++++++++++++---------
>  1 file changed, 15 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
> index c16d3954245..098ed0c4cd2 100644
> --- a/drivers/mtd/nand/spi/core.c
> +++ b/drivers/mtd/nand/spi/core.c
> @@ -530,12 +530,12 @@ static int spinand_mtd_read(struct mtd_info *mtd, loff_t from,
>  	struct nand_device *nand = mtd_to_nanddev(mtd);
>  	unsigned int max_bitflips = 0;
>  	struct nand_io_iter iter;
> -	bool enable_ecc = false;
> +	bool disable_ecc = false;
>  	bool ecc_failed = false;
>  	int ret = 0;
>  
> -	if (ops->mode != MTD_OPS_RAW && spinand->eccinfo.ooblayout)
> -		enable_ecc = true;
> +	if (ops->mode == MTD_OPS_RAW || !spinand->eccinfo.ooblayout)
> +		disable_ecc = true;
>  
>  #ifndef __UBOOT__
>  	mutex_lock(&spinand->lock);
> @@ -543,15 +543,18 @@ static int spinand_mtd_read(struct mtd_info *mtd, loff_t from,
>  
>  	nanddev_io_for_each_page(nand, NAND_PAGE_READ, from, ops, &iter) {
>  		schedule();
> +		if (disable_ecc)
> +			iter.req.mode = MTD_OPS_RAW;
> +
>  		ret = spinand_select_target(spinand, iter.req.pos.target);
>  		if (ret)
>  			break;
>  
> -		ret = spinand_ecc_enable(spinand, enable_ecc);
> +		ret = spinand_ecc_enable(spinand, !disable_ecc);
>  		if (ret)
>  			break;
>  
> -		ret = spinand_read_page(spinand, &iter.req, enable_ecc);
> +		ret = spinand_read_page(spinand, &iter.req, !disable_ecc);
>  		if (ret < 0 && ret != -EBADMSG)
>  			break;
>  
> @@ -583,11 +586,11 @@ static int spinand_mtd_write(struct mtd_info *mtd, loff_t to,
>  	struct spinand_device *spinand = mtd_to_spinand(mtd);
>  	struct nand_device *nand = mtd_to_nanddev(mtd);
>  	struct nand_io_iter iter;
> -	bool enable_ecc = false;
> +	bool disable_ecc = false;
>  	int ret = 0;
>  
> -	if (ops->mode != MTD_OPS_RAW && mtd->ooblayout)
> -		enable_ecc = true;
> +	if (ops->mode == MTD_OPS_RAW || !mtd->ooblayout)
> +		disable_ecc = true;
>  
>  #ifndef __UBOOT__
>  	mutex_lock(&spinand->lock);
> @@ -595,11 +598,14 @@ static int spinand_mtd_write(struct mtd_info *mtd, loff_t to,
>  
>  	nanddev_io_for_each_page(nand, NAND_PAGE_WRITE, to, ops, &iter) {
>  		schedule();
> +		if (disable_ecc)
> +			iter.req.mode = MTD_OPS_RAW;
> +
>  		ret = spinand_select_target(spinand, iter.req.pos.target);
>  		if (ret)
>  			break;
>  
> -		ret = spinand_ecc_enable(spinand, enable_ecc);
> +		ret = spinand_ecc_enable(spinand, !disable_ecc);
>  		if (ret)
>  			break;
>  

