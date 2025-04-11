Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90F1CC36010
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 15:11:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1A84384148;
	Fri, 11 Apr 2025 17:11:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=sii.pl
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=sii.pl header.i=@sii.pl header.b="HKKsvZPh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6EFBC8415E; Fri, 11 Apr 2025 17:11:23 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20710.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::710])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 001F5840D5
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 17:11:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=sii.pl
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pkochanowski@sii.pl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ePA1bTk9pGUzPSpeAhVLGGi1Mtn6rdznlhpsxP1bE/2lsbhUDqkxY2ZFojPgW/rEJIZl44VXAUjCp7cno5P1lGdn1T372khVPcdvQrVsyJA9/Z5/eC59dtGoC/D9/icD35MgFQdPOThoh+ed5v1St4DZXL9RO5gO3PjYEQ/d+tShT/XtIJqfKmmMwOt0AZ/JeQB9p0rrf/KmX1D8LGxDLLvJEqZJKur9AyNjzpk2eZHa/gAVSizE7wJIClPmjzhOS8rhyRpN9S+2ReAqTDd/89AKpq/V7taVV7JNAOmkbl4yjqrT8J9gIAgQ3gMsOi4fkDZGsfNQqoOYvakoRqA04A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H8U7cM/ZlAN39Lx43ZGb7rm8+Ya1ReitYixrRnsVTzg=;
 b=Kc0CCfIx76Dcn4fkFc4s5o8j/iE1ZsPOkhC7xRG+kXkHZM7EzAZaAxgQ5di9r2D92uXlL5iHNFjMdwpwfiUZKh+WE4v+OnivbNNNTWPICilW0/DFtXokvPllhFgdIO3jsmWMm+tqyd/P/uNFpXL83RZjk1DFwE8qtkM6Ah63zdy258NlMXfkD9hDV0k9HDDueSVeNQ56DnP3dkamw3LafXwE5hniwbHcqGjCJEP+UEmy2Vcm1+2wYlp+/GxCFhkQOBczl0OAmr+7MJzvzyMp6ZotP8q2dRlI0KBFB1agS6Cd2PD/1dKBCWPRxW0wmdDofJa/PMV9syHr73R35WjZSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sii.pl; dmarc=pass action=none header.from=sii.pl; dkim=pass
 header.d=sii.pl; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sii.pl; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H8U7cM/ZlAN39Lx43ZGb7rm8+Ya1ReitYixrRnsVTzg=;
 b=HKKsvZPhaKzY9ZC+3W0DRPsJmA96ZViN+Nh9bDWl/4ACIqK9jcQ33E0BxnNmQSXqC3/kpGyysitd8eJmK5LL3J4YNCiKeH16CdNZ13C8Y/D0MXl92xPgRYfTYBsAVoRuVFKeueppOKtEdmzVB/TkoufO2ZfaP+b2BogfeOfFPKkZHXvvujQdZsJ95+3iTZM1NzCH9t9hYByRzbxGrQKyByr22C2AVLdeuMfqUGPtMzOiBESzw2FqZsTrA3D14AIiF6aE4pKpK+WQqPNjXmIZNfE+TndkB0BXbmk4eL/hBQlmGgaiJS6CzYYR2D2RUtoUuK57iVjez/fZ7xqcqI35Lg==
Received: from AM8P191MB1394.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:1ea::16)
 by VE1P191MB1120.EURP191.PROD.OUTLOOK.COM (2603:10a6:800:16c::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Fri, 11 Apr
 2025 15:11:18 +0000
Received: from AM8P191MB1394.EURP191.PROD.OUTLOOK.COM
 ([fe80::3b87:5dbc:ea30:3331]) by AM8P191MB1394.EURP191.PROD.OUTLOOK.COM
 ([fe80::3b87:5dbc:ea30:3331%3]) with mapi id 15.20.8606.033; Fri, 11 Apr 2025
 15:11:18 +0000
From: =?utf-8?B?UGF3ZcWCIEtvY2hhbm93c2tp?= <pkochanowski@sii.pl>
To: Horia Geanta <horia.geanta@nxp.com>, Gaurav Jain <gaurav.jain@nxp.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Priyanka Jain <priyanka.jain@nxp.com>, Gabriel Nesteruk
 <gnesteruk@sii.pl>, Pankaj Gupta <pankaj.gupta@nxp.com>, Varun Sethi
 <V.Sethi@nxp.com>
Subject: RE: [EXT] [PATCH] crypto: fsl - Fix RNG generation for lengths
 greater than 16 bytes
Thread-Topic: [EXT] [PATCH] crypto: fsl - Fix RNG generation for lengths
 greater than 16 bytes
Thread-Index: AQHbp7vYj/H+qJ2ybk2H3sZmwaA1kLOZjPCAgAAKHaCAAUgJAIAAr1kAgAMDW/A=
Date: Fri, 11 Apr 2025 15:11:18 +0000
Message-ID: <AM8P191MB1394DFD2583712279E899836A2B62@AM8P191MB1394.EURP191.PROD.OUTLOOK.COM>
References: <20250407124714.177059-1-pkochanowski@sii.pl>
 <DB9PR04MB8409F4CF8E38ED3ADAAB1E80E7B52@DB9PR04MB8409.eurprd04.prod.outlook.com>
 <AM8P191MB1394DE8E57990BF74131AA4CA2B52@AM8P191MB1394.EURP191.PROD.OUTLOOK.COM>
 <DB9PR04MB8409F684D29E823DB780545FE7B42@DB9PR04MB8409.eurprd04.prod.outlook.com>
 <2509286b-a408-4ed4-9923-465eb87376fc@nxp.com>
In-Reply-To: <2509286b-a408-4ed4-9923-465eb87376fc@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sii.pl;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM8P191MB1394:EE_|VE1P191MB1120:EE_
x-ms-office365-filtering-correlation-id: dcb61f11-1a54-4844-568e-08dd790b1c2c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?VU9xTXBaeHp3Zk5xTmtTY1luMktxR1M2ZkFXdFFKVnQwcXNNU2dvbFRTZVZ5?=
 =?utf-8?B?dzU0bXRYQ2QzRUJFbytSVVlJeHFYTEZydG1sZmk5VU5FdTVvam1HNzR3aDdn?=
 =?utf-8?B?bVdTc0xOTmhiV0F6dFV5MjR1L2FVNi9KakVHM0h1YkM4aTEra0haRU93VDgv?=
 =?utf-8?B?b1VKcjRZcEpiYVoxTVFIeWZWT21IQjJJcjEzL0padEtVU0hQZm9SUk5jY1cr?=
 =?utf-8?B?eVllbFhvd2xYM0lPeTFSUFpRNm9OV1pIbm8welRvSmJ0dDc1UjlQWkFucW9T?=
 =?utf-8?B?SU9KYzlURndCSVdIVDNaQ1dQU2RrWlpWcEJmdE0zcm1OMWFQUml6aUJtSXgx?=
 =?utf-8?B?Qy83Um9OTE9VMnNxdU9kQk9BbEVOa0hVN1M1clNjMGJuMkplaTBEWDgvelpQ?=
 =?utf-8?B?dUhUekNqTWZNcHcxWmpvMHNWRGZpV1JZcjR3d3B0LzZWYmdLQzRjUWxhRndC?=
 =?utf-8?B?WG9WakhLNFg1ejkyNTNtWTN6UWV3Rm5OejNsWU5DNDhYRFg5ZWM0c1NVcmhT?=
 =?utf-8?B?bGtXcEc4VnVVbVA5dGV6cmlmRkpUS1JEY0UrMEdKUmlRZW1Wb0JJYXNJVXBQ?=
 =?utf-8?B?bGpsNHU3Z3pPUmsvYndGZmhzeS9yZjFZVS9HUnUyZzVZQWhKWjJNdjh1ejBw?=
 =?utf-8?B?MSt4M2hoeDQ5MGV5enZVUGZpaUluNmErdzF5d3F6UFlJTGdEcFRZdFJJZzBx?=
 =?utf-8?B?elRnd2pDaXBHWEZ1RFU1RElVV1lXRXJTc3hCeHp2OHhvb1UzVmFqNWdtUFIv?=
 =?utf-8?B?dVBseHo5eGZoMnNVNlJRaFkyaGFmSFJRZ05mU2lkMUZleGM5TGErZTQrMmpr?=
 =?utf-8?B?bGh4STZyaWk2RGozdzQ0R0NHY0QrdEl3NWhFWUthamlFck5YdW5XVEVFczQv?=
 =?utf-8?B?bWdIZVJSN1BzTFNDZnpZRVRVRWxHbkppckhJVGF4K3FyQjRMYVlMdEl6YWli?=
 =?utf-8?B?Mmg2dkJ2VmhXbjgrNmJMNVN0VkpvYTNVNEFQVTBoR0VUQ2svaDdpNnRyN1kw?=
 =?utf-8?B?cmpPbGtpbGcvV1J5VUFiODhvWnFVVTFNWTFYTTlCV2EvRXFFLzNLcnZXM0RV?=
 =?utf-8?B?WjVTZHRUUmorbW5IS2RxcTJlblo4R3I3UTZIMXc4ZGNtVVpoVEZXRDVHZ3NI?=
 =?utf-8?B?M0hQdjRFOUU0QS9qUkVaUHV2VHEyblQyZElJZFRMYWt0d2U2VklEQTBNRHZL?=
 =?utf-8?B?SjRGd01DWTFCMnRyUE5COEdFK1ZMZ1lBOHJ3K3F4L0dFTGRWY0hkVUNGTXVk?=
 =?utf-8?B?WTJyemV1bHc0MVlSYlNWZEdkeFNIN2dVMDhEQmo0a05vSjNuREY1NmhtL2l6?=
 =?utf-8?B?Zm9NZkE5cDlWdzlRMDNQMjZzTVBxczZrYjhiYkNxd29VcmhVald0cnRwaHdE?=
 =?utf-8?B?V0VjcldhVm4zQU92ZkprODE5VHNJQUF3SEYvTzZEYzV5T2oxdW8xSEs4aHNw?=
 =?utf-8?B?M1dTYi9XR25MYTFDRnJlb1hCSDUwSHRrNFVLT3FrZGE2c2tlcXdEU2dvK1JJ?=
 =?utf-8?B?eFIreGhiNVZnYXBEdGcwRjNpZHMxODcvRDFUaysxQkFCQjgvQzRBS0p4c1Vr?=
 =?utf-8?B?MnpiMlo4UFpvbE8xOEdLc1NpWjYwZ2ltcmxadGwyWGtDQ3NHOFV4THJ3c2NH?=
 =?utf-8?B?MThGeHhqY2szMW85cnk0TWZYVnQ4SXYyQzlLZ1V2RDRmYmh6bVRuWUowS3ZO?=
 =?utf-8?B?SDdSeUp6VlJnbHdUQS83L1BYbkZsYTQ1dEV4a0xNaFFzU3ljRWRnOVNSYXFz?=
 =?utf-8?B?akdPQ1VQb1hIL2FyNmQydGp1bHZxZG9meUgwd0IzdU0xSWl5YXgwVnllWGNI?=
 =?utf-8?B?c1dUMlhPTFI0bVRLU0poS1dCMk1MeUZveTRrNDFyZlczWDB6amVhMTZZSGgr?=
 =?utf-8?B?bHlHU0Qwc0M4b0dNUkNDSGZJb0xzY0dMbjYwZkszSEs4VHMyekpjbEQxYVor?=
 =?utf-8?B?OXEwUXdybU1Pa1hob0NyeWJyM3NqTDJTZkViT3lYSEtZNEtWRUVVVmQzQ2JK?=
 =?utf-8?Q?S62ptMr2onStxcV7ffWe0W8mUpX8LI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8P191MB1394.EURP191.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WlpQZUtqK2Z3UE0xTlc3d1ZnSXhMR09TemFpbXVoY3pua1dlekU2bnhYUXVu?=
 =?utf-8?B?UFBCbC9WNmhTazNxcjNLSE5KUk9hNmIvdUU2SFB0djFMZnRhdkg2TUlycVZY?=
 =?utf-8?B?Q1k5NU52WmIwWDNtQ20xMmU1d1dETGJsTVJjbkRYVlN0OXNneVRuVkVLTkto?=
 =?utf-8?B?TCsyMEJCYWZhdzBJR2E4eHFkcVE4bWNlMWRHWHlISVE1d1YrZjhVRjdJc0dE?=
 =?utf-8?B?dktFRXZYY0dJcjEvcUk0NUhaUUxNY1hLUUJ2b0EvMzlmdEw2SFVERWhlcXR5?=
 =?utf-8?B?dUd1Q0ZsajBnSGJyNjJZWERxWWdlTDNDMmFDZlNBZ0ZCTWxxSmFlM3RtcXVS?=
 =?utf-8?B?UisvUklNSnFDVjdtTzNjUlJYRVhQdXcxeXJKRXo1aXpsVFR6TktyUm4xQ0pM?=
 =?utf-8?B?WWxXVVNNQVBqaEZPdTBHRGUybmxQQS9zSXJaejRVY0hJZ2xXTjhxLzc0MFlB?=
 =?utf-8?B?bzNubldJWFlhaytZOEdqdmQ0T1BpcU1wSVJ1UVhQUE5taGFZdDJzMXBjeVRS?=
 =?utf-8?B?Tk5qU3JuN0gxWkhSK2pNUzB4anFqOXprS2dNbjlaMDRRc3dxZ3cxZ255SnRw?=
 =?utf-8?B?d1BJdXRPSEI3a2J3WFFLMzl1eW9GQkIwWmcxRmw2cjd6ZS9RLzdSQldYVlNx?=
 =?utf-8?B?dDdKd0xRRGhTNVByQmdPVFRSOW1uSXB4dUJ2ZVJaSGYySDBjc1hKS3JMRzBC?=
 =?utf-8?B?V2JxdURrL2NrTUc3Wm9nMTh4aDMxRnk4YkM0dGllanA0aUR3bUkxbDVsU3RM?=
 =?utf-8?B?alg0bFRuMHBobVJJS290V3kwcXlmREFQb1FEemdNRStHazFhK1ptNzAzcDRq?=
 =?utf-8?B?SCtGR0NnS0MzVnh1bHlGVzlqa3NNUko3dWtXZ2tydXRHREcra3dhTlcyTGJT?=
 =?utf-8?B?aFAzcEdVaVU1RXFIVE5OaENuOEpocjcwdnY5OUFpTmpPeDlUVFFBazdRUTBn?=
 =?utf-8?B?SGpybXNQNVZWS0J0VXVscjJZbllHek9oTjZ0MUJjTlVUWDNQQUcwaUpkQjFC?=
 =?utf-8?B?dk4waDlWeDhqT3JiRmpvaUd6T1pINnlmdFBTbEVXOUY4MCtlWktGa0hxU1Jo?=
 =?utf-8?B?YmlFck4yQjA2K0hKb01Ga2dNbDdiZHIxV25Tb3k2YzlCbThOMENXQjZlcmhG?=
 =?utf-8?B?RzRpcTdlSjdtOThzL284dzdrcXdqWXJjcS84cnJNT3grWm92VWEwTmRJMzVm?=
 =?utf-8?B?UmdjR21RYjVUeitGS0I3cnBxUnN4azhQZmIvbkxMVGRhSUVOdTdYQ1ZES3Vo?=
 =?utf-8?B?MkkwV2lPSFJHVm1GTzJPZG9laFNjb0sxRFY5YjRRN3ZpbmJ2RmR4ZzIyanlL?=
 =?utf-8?B?ejc2ODhldjhsYnZmL2h0S1F2cE1waFR3VmFuWGg0VVpMUVFYWHBBMml6bUZ0?=
 =?utf-8?B?M0dtNnJmTmVOR1dqMFcvYXU1Tmw4N0l2WkJ2UHJJMXUrTW5hZjRPa3pnODdX?=
 =?utf-8?B?TTBvTVlRMlZsbkJtNFlFbEtXV0x4TWN5aUk5QnRHa0htdnJnVjNzVXk2TjVM?=
 =?utf-8?B?VEhDa3Z6WGU4bmVzMzdEcnVPOTN1U3R3VGt4MEVSRnBEMndQaDhVcEExNGhM?=
 =?utf-8?B?cU1abG9DUERRR1dKYTl5aFN5OUxZV1ZiaWxHS2dKQnNLVWMyQlBNSmhZR0U1?=
 =?utf-8?B?c0o5azRETEJKZkt1NU9JdW1OZk5xZVRzMGZ0RWp6aUg3bjJ4cXU1bGpZUUdn?=
 =?utf-8?B?RGdhZVE4dmJ4SGVwZTY0SVl6amxJOVZIeXA1Y2VuVjU2VldQYWhRQmY2bjdq?=
 =?utf-8?B?Rm9TQUZkSTlZcDVscEhNbXRqWVgySjRqZG5URU92NDVrMU1RTnFhYjN1bFJE?=
 =?utf-8?B?NEp6WjZNWHk4Zm1PNUNXWDJ2VzZGMTVFWkVtK3BZaUlHSnl2eWs5czhwVitU?=
 =?utf-8?B?bEN6aHBEYmRmdUNlNzdRRWZMakJvcUh5cHNJWDlhNUJSWjQwQ0hmUWdsTmhX?=
 =?utf-8?B?U1ZGa25Xdm1QbzZWcU1kM0pjRW1PRkVRSUNCWnpwNDhRZkprM0FYM1paSmRz?=
 =?utf-8?B?a01WUU94ekRXdlRRR3h4dkoxUmRHOUNNa2dDcUZTbVgzbU1oR0RhNXlEaWZ2?=
 =?utf-8?B?RTduNS8vN3R5VHlqMDJxNGpvbDZEYnJybTJiS3RDVm5uelJ5allDY0pKM2dU?=
 =?utf-8?Q?DKZmQvpVUDvF5RUyBEMLOctwv?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sii.pl
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8P191MB1394.EURP191.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: dcb61f11-1a54-4844-568e-08dd790b1c2c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2025 15:11:18.0460 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f9bd6df6-c449-481f-abb5-37bd036beb76
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yN+bylrdrOG8LmtbSuKKp6b8cUXJHw157tgblcGQ6KQJFQncROzChZ8H+uT8OR24HXXTByss226FGZnmNf61Aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1P191MB1120
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

SGkgSG9yaWEsDQoNCj4gRnJvbTogSG9yaWEgR2VhbnRhIDxob3JpYS5nZWFudGFAbnhwLmNvbT4N
Cj4gU2VudDogV2VkbmVzZGF5LCBBcHJpbCA5LCAyMDI1IDY6NDcgUE0NCj4gDQo+IE9uIDQvOS8y
MDI1IDk6MTkgQU0sIEdhdXJhdiBKYWluIHdyb3RlOg0KPiA+IEhpIFBhd2VsDQo+ID4NCj4gPj4g
RnJvbTogUGF3ZcWCIEtvY2hhbm93c2tpIDxwa29jaGFub3dza2lAc2lpLnBsPg0KPiA+Pg0KPiA+
PiBIaSBHYXVyYXYsDQo+ID4+DQo+ID4+IFdoYXQgd2Ugc2VlIGlzIHRoYXQgdGhlIGpyX2VucXVl
dWUoKSBjYWxsZWQgYnkgcnVuX2Rlc2NyaXB0b3JfanIoKQ0KPiA+PiBzd2FwcyB0aGUgZW5kaWFu
bmVzcyBvZiB0aGUgZGVzY3JpcHRvciBpbiBwbGFjZSAoYnkgbW9kaWZ5aW5nIHRoZQ0KPiA+PiBk
YXRhIHBvaW50ZWQgYnkNCj4gPj4gZGVzY19hZGQpOg0KPiA+Pg0KPiA+PiAgICAgICAgIC8qIFRo
ZSBkZXNjcmlwdG9yIG11c3QgYmUgc3VibWl0dGVkIHRvIFNFQyBibG9jayBhcyBwZXIgZW5kaWFu
bmVzcw0KPiA+PiAgICAgICAgICAqIG9mIHRoZSBTRUMgQmxvY2suDQo+ID4+ICAgICAgICAgICog
U28sIGlmIHRoZSBlbmRpYW5uZXNzIG9mIENvcmUgYW5kIFNFQyBibG9jayBpcyBkaWZmZXJlbnQs
IGVhY2ggd29yZA0KPiA+PiAgICAgICAgICAqIG9mIHRoZSBkZXNjcmlwdG9yIHdpbGwgYmUgYnl0
ZS1zd2FwcGVkLg0KPiA+PiAgICAgICAgICAqLw0KPiA+PiAgICAgICAgIGZvciAoaSA9IDA7IGkg
PCBsZW5ndGg7IGkrKykgew0KPiA+PiAgICAgICAgICAgICAgICAgZGVzY193b3JkID0gZGVzY19h
ZGRyW2ldOw0KPiA+PiAgICAgICAgICAgICAgICAgc2VjX291dDMyKCh1aW50MzJfdCAqKSZkZXNj
X2FkZHJbaV0sIGRlc2Nfd29yZCk7DQo+ID4+ICAgICAgICAgfQ0KPiA+Pg0KPiA+PiBTbyB0aGUg
c2VxdWVuY2UgbG9va3MgbGlrZSB0aGlzOg0KPiA+PiAxLiBjYWFtX3JuZ19wcm9iZSBzZXRzIGNv
cnJlY3QgZGVzY3JpcHRvciBpbiBgIGNhYW1fcm5nX3ByaXYgKnByaXZgIDIuDQo+ID4+IGNhYW1f
cm5nX3JlYWQgaXMgY2FsbGVkIHdpdGggMzJCIDMuDQo+ID4+IGNhYW1fcm5nX3JlYWRfb25lLT5y
dW5fZGVzY3JpcHRvcl9qcigpIGlzIGNhbGxlZCB0byBnZW5lcmF0ZSAxNkIgd2l0aA0KPiA+PiBg
cHJpdi0+ZGVzY2AgY29udGFpbmluZyB2YWxpZCBkZXNjcmlwdG9yIDQuIFRoZSBkZXNjcmlwdG9y
IGlzIHN3YXBwZWQNCj4gPj4gaW4ganJfZW5xdWV1ZSgpIGJlZm9yZSBwYXNzaW5nIGl0IHRvIGpv
YiByaW5nDQo+ID4NCj4gPiBJIHNlZSB5b3UgYXJlIHJpZ2h0LiBJbiBMaW51eCwgY2FhbSBlbmRp
YW5uZXNzIGlzIGhhbmRsZWQgYXQgdGhlIHRpbWUgb2YNCj4gY3JlYXRpbmcgdGhlIGRlc2NyaXB0
b3IuDQo+ID4gQnV0IEluIFVib290LCBjYWFtIGVuZGlhbm5lc3MgaXMgbm90IGhhbmRsZWQgYXQg
dGhlIHRpbWUgb2YgZGVzY3JpcHRvcg0KPiBjcmVhdGlvbi4NCj4gPg0KPiBJTU8gdGhlIFUtQm9v
dCBhcHByb2FjaCBpcyBicm9rZW4uDQo+IFRoZSBoYW5kbGluZyBvZiBlbmRpYW5uZXNzIG11c3Qg
YmUgZG9uZSBhdCBjcmVhdGlvbiB0aW1lLCBvbmx5IHRoZW4gd2Uga25vdw0KPiBob3cgdG8gaW50
ZXJwcmV0IHRoZSBkYXRhIGFuZCBwZXJmb3JtIGFkZXF1YXRlIGJ5dGVzd2Fwcy4NCj4gVS1Cb290
IG1ha2VzIHRoZSBhc3N1bXB0aW9uIHRoYXQgZXZlcnl0aGluZyBzaG91bGQgYmUgNC1ieXRlIHN3
YXBwZWQsIGJ1dA0KPiB0aGVyZSBhcmUgY2FzZXMgd2hlbiB0aGUgc3dhcCBoYXMgdG8gYmUgZG9u
ZSA4LWJ5dGUgd2lkZSAoZm9yIGV4YW1wbGUNCj4gYWRkcmVzcyBwb2ludGVycyBvciA4LWJ5dGUg
aW1tZWRpYXRlIGRhdGEpLg0KPiANCg0KSSB0aGluayB5b3UgYXJlIHJpZ2h0LCBhbHRob3VnaCBp
dCBtaWdodCBub3QgYmUgc3RyaWN0bHkgbmVjZXNzYXJ5IGluIFUtYm9vdCBhcyB0aGVyZSBzZWVt
cyB0byBiZSBubyBjYXNlIHdoZXJlIHRoZSA4LWJ5dGUgbG9uZyBkYXRhIGFyZSB1c2VkLg0KQXMg
SSBzZWUgdGhlIGFwcGVuZF9wdHIoKSBpcyBhbHJlYWR5IHByZXBhcmVkIGZvciB0aGF0IGFzIHRo
ZSBgc3RydWN0IHB0cl9hZGRyX3RgIGRlZmluaXRpb24gaXMgZGlmZmVyZW50IGJhc2VkIG9uIENB
QU0gZW5kaWFubmVzcyAoc28gd29yZHMgYXJlIHN3YXBwZWQpLg0KVGhlIG90aGVyIHBsYWNlIHRo
YXQgY291bGQgcG90ZW50aWFsbHkgY2F1c2UgYSBwcm9ibGVtIGlzIGFwcGVuZF91NjQoKSBidXQg
SSBjYW4gbm90IGZpbmQgYW55cGxhY2UgdGhhdCBpdCBpcyB1c2VkIGluIGFuZCBJIHdvdWxkIHBy
b3Bvc2UgdG8gcmVtb3ZlIGl0Lg0KRG8geW91IHNlZSBvdGhlciBwbGFjZXMgdGhhdCBJIG1pc3Nl
ZD8NCg0KSSBhbHNvIGNyb3NzY2hlY2tlZCB3aXRoIFRGLUEgcmVwb3NpdG9yeSBhbmQgaXQgaXMg
ZG9uZSBpbiB2ZXJ5IHNpbWlsYXIgd2F5IHRoZXJlIChwZXIgd29yZCBzd2FwIG9uIHVzYWdlIGFu
ZCBub3Qgb24gY3JlYXRpb24pLg0KDQpCUiwNClBhd2VsLg0KDQo+ID4gNS4gVGhlIGxvb3AgaW4N
Cj4gPj4gY2FhbV9ybmdfcmVhZCBpcyBjYWxsZWQgc2Vjb25kIHRpbWUsIHRoaXMgdGltZSB0aGUg
YHByaXYtPmRlc2NgDQo+ID4+IGNvbnRhaW4gc3dhcHBlZCBkYXRhLg0KPiA+Pg0KPiA+PiBJbnRl
cmVzdGluZyB0aGluZyBpcyB0aGF0IHRoZSBqb2Igc3RpbGwgc3VjY2VlZHMgYW5kIHRoYXQgc29t
ZSBkYXRhDQo+ID4+IGFyZSBwcmVzZW50IGluIHRoZSBidWZmZXJzLCBidXQgbWF5YmUgc3dhcHBl
ZCBkZXNjcmlwdG9yIGNhbiBhbHNvIGJlIGENCj4gdmFsaWQgb25lPw0KPiA+IEkgYWdyZWUgdGhh
dCB0aGUgZGVzY3JpcHRvciBzaG91bGQgYmUgcmVpbml0aWFsaXplZCBmb3IgZWFjaCBSTkcgam9i
Lg0KPiBJIHdvdWxkIGFkdmlzZSBhZ2FpbnN0IHRoaXMsIGNvbnNpZGVyaW5nIHdoYXQgSSBzYWlk
IGFib3ZlLg0KPiBIYW5kbGluZyBlbmRpYW5uZXNzIHNob3VsZCBiZSBkb25lIG9ubHkgb25jZS4N
Cj4gDQo+IFJlZ2FyZHMsDQo+IEhvcmlhDQoNCg==
