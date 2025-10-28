Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEEA3CCD1BF
	for <u-boot@archiver.kernel.org>; Tue, 28 Oct 2025 08:38:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E54983A32;
	Tue, 28 Oct 2025 09:38:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="o3zF+L25";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7245983A3B; Tue, 28 Oct 2025 09:38:10 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E236839DD
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 09:38:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L+64WFf17iq/wPAvAwUD7EaNCbWiWqR7k6JlTyUqtGs7DkXMVOr+MTgF1tfKVI7kEoWONWT1gFooE++cRF3/5JY5Or3JSBGFPI7eQbboL9Li4jiQIqpeM/+KlbftPgTzmya4NpVsMxHZROsQ8VI/k24ossL0AsXOCtXHLiuL99rxRFkgq1MuPc4JulKIpefjACBZwIEivzrVmw2vIElMp+ETrbhcbIbd7jaWL7e71kyE43DvVQTjYVbPC97GKKXTdw2V5VjuDp1tF4KAX1pVJv/Kl3m0F0M/kydWg9zVdPLcAkHoG6K9k45maMAElNPCWWte05IzohaWq718hkHcNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=js5LJCisXx7ZSQ0rMjYIFaNE3YdSbgzcrIiE/wPgENI=;
 b=ukGpRxm8HzuwhKcJRhkTj9vIQ3WtQ8InYgM5TA7DJ0ZGQOczT3oDTwA2h1pa1l7cQC8x3gRbVMep9j8JroIZp8WP49R9K0XXTfKD2GfZUfegG1rqScjAG0XU8jv6nZ1r3UtlcyZk6P5ADvPcsl9CMJX4lRQaRRXA39QlDC0jysfnqAYkEASi8GD5Ruzwq8xG9Ly7U+EZUea7EI33OwXQLZhIAptmV6yWIRQvdnC62FIjt7sYtLcR+b/8J8N9/ytzGjuuvpVs9LXPqSyG9KNrbB33v5jITCB72gksvsM9M5YDURVxm+fxfNEuECfVMoF3TOXcTY52VTbKuIcEP7Rg+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=js5LJCisXx7ZSQ0rMjYIFaNE3YdSbgzcrIiE/wPgENI=;
 b=o3zF+L25s1XJboRfs3k7nnk5aQdo+qIrOAs5Z12Fq32nfWC1KpajipwyHR1xBLugmA06Ng+2PcLQJWXV/yXsfsS6jl8f69qS/RToE7iB+bxkC3L+Cib7x/ea3n6UK6hosAf8xMQIHxIytoSRqqz4jeMkl6fCciQnI+1ClWfKembQkVbADihCQDl7ORtKavpAAezx4Sz9rKDUVMee6kMK5N2fAD6hkidNZ5EJmq+znCNsTWBnGn8IyqfYa743Bb4ZymW9rTqep/Op6xjtUfjo4aGyQMWoDJffIEC+8rCCMTeJG9T+6c6ZIOSj4cFbjEKSru1+W5Ic/WrNZIi1jcLUkA==
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by VI0PR04MB11481.eurprd04.prod.outlook.com (2603:10a6:800:2c8::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Tue, 28 Oct
 2025 08:38:06 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9253.017; Tue, 28 Oct 2025
 08:38:06 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: Alice Guo <alice.guo@nxp.com>, Patrice Chotard
 <patrice.chotard@foss.st.com>, Peng Fan <peng.fan@nxp.com>, Tom Rini
 <trini@konsulko.com>, Valentin Caron <valentin.caron@foss.st.com>, Ye Li
 <ye.li@nxp.com>
Subject: =?gb2312?B?u9i4tDogW1BBVENIXSBmaXJtd2FyZTogc2NtaTogRml4IHVwIGNvZGUgY29t?=
 =?gb2312?Q?ments?=
Thread-Topic: [PATCH] firmware: scmi: Fix up code comments
Thread-Index: AQHcR+YuA+nbfbr780eqCPaO62IPgg==
Date: Tue, 28 Oct 2025 08:38:05 +0000
Message-ID: <PAXPR04MB9644894FE99A83CD8352D25EE2FDA@PAXPR04MB9644.eurprd04.prod.outlook.com>
References: <20251025223456.253958-1-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20251025223456.253958-1-marek.vasut+renesas@mailbox.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9644:EE_|VI0PR04MB11481:EE_
x-ms-office365-filtering-correlation-id: d291baa8-bc97-4e6e-a8bb-08de15fd50d6
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|19092799006|366016|1800799024|38070700021; 
x-microsoft-antispam-message-info: =?gb2312?B?WXZFN29qMHJ3bFFRR0g0N3hSR1VBbDlNVEJVc1BwZXNvSE1lY1FheWJpQjZl?=
 =?gb2312?B?VXpkSElna0RtVThnQ3ZNSWRuSFArRzgrQVVBTmtGVDNJRFBBajRRZWVodEp5?=
 =?gb2312?B?cUVOY2NGZTdFeDBiTWFBaVRDY2FDOVgzMEIxMlYwSWxQdGErdm5kOFY1MjRU?=
 =?gb2312?B?aHg2UHFML0sxNXVDWE1xd1dQRlVGd3N4SDlmcGVKbitMYmNzNXdVaFBtMy9n?=
 =?gb2312?B?cUJUbDcrdnhiZW5sMmxMK1ViNE5aelRZbGZFNFJOMEJmK0JWd2puYzZvZ2Vz?=
 =?gb2312?B?b0J0cXA5ZnZreW9Id1J2K0ZMYitVemNFQlpIUWo4aEMxd2lIL216bVYrVURl?=
 =?gb2312?B?ZFVMZlVhdlNlZ2lXTUdNZDdhbkttYW9SRW5MUHJPNW1aZEpOWlVDSkFIMFBl?=
 =?gb2312?B?dXBUQTh5RG1xQVZsUHozbGtDQ2tlUm5ML0srUjdaSE5oK0xLZzFBMFdHU3h3?=
 =?gb2312?B?QU0zOElOSTR5OUp2TnFzQ0dSd3VzMmphTUgyalBrcXRFRmJHbXJseXdkdUV6?=
 =?gb2312?B?MHpjb1JBUVhnVTRIcmZaR0JXeFEzL3A4clpPTCsvZytPR0FscTQvT0hTdmhm?=
 =?gb2312?B?OTQzbjNXYjNnSU9hUE1vRk9UOGo5UU9ick1uWC9IL2lJRU9EMWJNcWN5Q0hM?=
 =?gb2312?B?TmdZNkMxQlY3Vkh1WWJJeElacUU3SHJTYnRBL0dac05Rc0F3MkMwRGxWTis3?=
 =?gb2312?B?YXRabFFza0tqTmJidk1BeG4vRCt2TkNCdE9LWDRKdmFlMlY2YUpIbVdud2Yw?=
 =?gb2312?B?cmpYOG9MZWh5R3htcU5aQVNYOEFqU2FXa1hrbmdqdmE2d0RNRnYwUWZ6dmM0?=
 =?gb2312?B?U291bUxRWHZYZnZBK3gyTlk4c0dXekR3TjdKOFFUOFNtY2dhK3N1NVdkV2pz?=
 =?gb2312?B?aFQ2WmZPS1JWUy8ycWdhS3lGby9tV1V2YnpaTnJreS9ZUk81N1JmUkltYlMz?=
 =?gb2312?B?R2lYbStDVDZhK293V29DS0x2ZmVpZEIwS3RTeEJiVUFQS3ZNci84QkVvU0hk?=
 =?gb2312?B?QllhUjlkb0k1bllxVndYakVaZlZJc2NwalNFTVo4N2t3dGk3dEEybVBOV0l2?=
 =?gb2312?B?NW9pRkFFYzJhVUVacEM2OUc2Z3NHRU5YQ1FSR1pLUW1KaTZkeEJrTzdsY1Rz?=
 =?gb2312?B?clZBYWN5Sk5wOTczcWYvMFpHUWc1N1RFTFJkampTd056NmhFNEM4SjQ3RkxP?=
 =?gb2312?B?WHVZQ1prQ25pWWc1b21rUkxuZURuelpVcGZBVFBtSU1sQTFRaU9oWWFEeWFT?=
 =?gb2312?B?VDB4b3hXaHNXbENsTHpPWE1qeDJtdktyMHp1d3FpRURVWHVVQkZ5NDFsMmJm?=
 =?gb2312?B?Q2JzSk10QjAxL2tHV1Z3NHNSbWlzZFhneEtIeG8xU1FnT2JrNUxhbzFGd3la?=
 =?gb2312?B?UkloSjhRK3pwZnpmV1RZMEF2c0o2ckxWZ2pPZWpKZzViTDlaclNxOGZ5V1dh?=
 =?gb2312?B?c01YUThYS0Yyekw1STduTkIwZklxU0VFVW91Vlo4WFBzU29jS29IOW5HQ3Mv?=
 =?gb2312?B?SEduU0xHVHhyRmM4N291UVk4OXFhdTZPTkIwYmdha3dOVGVYRkNEeXh3ZkVU?=
 =?gb2312?B?REJDd042MEhNYkpXVm9VaC93NWprTDRGdXlSM1E1OW9xWXVua1cxNjdPSlB4?=
 =?gb2312?B?b0grWFF0NWZONXZXQnE2U1RTVlBRZkkyNXZkSGFuVnpvVXBxUDRjS2VjdXhv?=
 =?gb2312?B?Y2I5YzVzVytubnJLL2JWQm9zVUl2REU5dlVHNFd1MGJHN1MyYm9qcE9nLzI0?=
 =?gb2312?B?ZkUwTW93RkhQbzFCU0dGZkFnVXJ1VEIvb1ptUU82aENVaURXYVJFUzBkbHNq?=
 =?gb2312?B?RXFaNmpUTHBXay8rU21uVnlGeGJ0TnpkSjJsaERnLzlZSklKbWcrL3QyNzBp?=
 =?gb2312?B?SnZJWnpOazRoNmw4R2g3amVPaGw5UCtVVCsxL0I1RDZxLzdlbU05Q0FUYkQ5?=
 =?gb2312?B?Y2I2WUV2TXFPWGpDMDZmWEphaDlHYW4wbHA2NGhiM3R0cmQ4bTdWcncvUmt6?=
 =?gb2312?B?Ylc0L2cxZWdDL0ZacGFWSUFxbWFxQlFoMTV4dDNHaWJPNFc0bjVpVENNc2xV?=
 =?gb2312?Q?uIwTjl?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-cn; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(376014)(19092799006)(366016)(1800799024)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?MTdkWkQ1WC9lU2wzRzJ5TCtkRXFqVnZGRkRjN1pNY1o0RWp1TlVmV3NwNW8z?=
 =?gb2312?B?YWpmbnRQL0lwVXFGVDgwMnZZWDFwaFNTWGI1Y244N3V3VDNqOFZKVHhldjQw?=
 =?gb2312?B?UVpROG16MUQ2ckJPcWFxNVhSMG4xQmIwbkNnT1JNWnY0UTllSVN3L1hMRlhv?=
 =?gb2312?B?aCtpYTJ0Z3JuN2ZlWktXaTdOWlZWMm9HaThiTGZCTDZXUndiODQzYWdFN2pn?=
 =?gb2312?B?VDArV0dsNDRwVlBLNkNqclRjZW5nbjNOY3cwSmZ6UjI0cEJGUGZmN05sWWxw?=
 =?gb2312?B?QVl0UFBnNjVraktQaURnTW1ZY0N2Q2hrWXIya3pQVDkxQzdOWW9tQy8zSmxK?=
 =?gb2312?B?ZnlCc3JXa1pxOURoRjN1NVdzWTNtYWJQUnQzb3pRaXlXR3dDRk5mQ2g0MlB0?=
 =?gb2312?B?VWdadXdScTRMdEowSWxMRFJPV1E2aVBZVm45dytZTERneDdtS3kweDNjYVE5?=
 =?gb2312?B?QTBtd0xtZkNYNTFPTWt4d1F4Smhycm9STnFOdFFqYUlHNTRpWDE2Ly9zcXZI?=
 =?gb2312?B?RkVDdGdSK1ZIZUJwOU1vdUZQcjRhdjd2L0d2RlRZZXNmUEpKZ0JSbGpmcmM1?=
 =?gb2312?B?TWRUdy9OS3pZMTAxY1pMK3ZaWldWOEpMNDcxR0tDUHc5ckhnbFJ0QWRRZjFH?=
 =?gb2312?B?RHRZVGJ1YVRNa3hMRDNkU2MzSnc2ZncwK2VxR0RSTVc0YnBXaDdJZmIwQzUv?=
 =?gb2312?B?UzAxTURLb1dHbDJqV2N0b3Z2TjNFODNCYXBJNWZPRTFwRWlQRDVzMFMwQ3hv?=
 =?gb2312?B?Q3JMK0lvNTRQMzI2OEhoVnVMNDVwWWFETnhIVTlUZ0pPUUUyb2U3dUVQVGxh?=
 =?gb2312?B?NHJycGdaeFNzTXlFeEUrcUZWeTErQWR6VGVFMlFVUGN0VDRXa2hSWlVLSjJI?=
 =?gb2312?B?SXlHdDJvbG9Kdk5HaFUyTmNuMFhPRU5SWkJ4N0pVZWdyWkYzUVZrdytYQkdh?=
 =?gb2312?B?eENWeVl5V2dua09kcDJVcFlzcmQ2UDZZT3UvODZ5eGs5blBHTnAxNFFyU1Vu?=
 =?gb2312?B?YkRRZklxTE5oQWZkbFZ0MHZKZCt4WXUrMlNLakl4UnlhQnczV3NZdFM2Q3dC?=
 =?gb2312?B?Qko4VW5PdzFiekE5M3dpRVUrYWJpVEJNV1IzVjIraERXWHhsZ0xJMXJVTG9h?=
 =?gb2312?B?RjhFYXhERWM5Nzc4ZHVTc3UzTURqTmFQYy85d2tPMmkrQkZBRkIrRDgwRWFS?=
 =?gb2312?B?enZqa3BpYW9HRnU4Q3lMOEVWYzhMSmxzazZycU1jV3FKL2tYVHJhcXdLb0c1?=
 =?gb2312?B?Mm1CUGQyNllHdVdHaVppQ2o0SWNrUDNOeXU3ZDg3TGRiN1hVNlh3Zm1yZmtY?=
 =?gb2312?B?QUF2OHRKK1JIcXZYRzNBdHZKbVdPQUZPSDNrRmNRZVZzbENZVlI1eEZqdmZm?=
 =?gb2312?B?OWdkRndJb0Q1OEkwRldNOUdzcHltUEQrMDFvdk9vZFk0SnNxV1ZxVzhQQTE5?=
 =?gb2312?B?eVEzaUV2TXJGOTNRUHRpL2xjTnZRZU5McFprOWFacDNHempXMXQ0REVCb1Jq?=
 =?gb2312?B?Ym8wNkptU2U2WmdDVXgxZnQ3WGN5T21xaGdNcVRFcjhQV2VHRlRlNHdPSmlT?=
 =?gb2312?B?NkdkRi9IZzZhNmo3Y3Z2S2hjM29aTnBFaXFsVHNjMDJOOGRCQXdrWTF3eFJ4?=
 =?gb2312?B?cUNiVVFYWEpLVTN6K2R0UVgyeG51NjIyeGlUTC9mUU9hcFozd1QwK2ZsWmpS?=
 =?gb2312?B?L3oxcmcyRzk2dDdlU20wemIvRVYwMFBPcmVqOEV4TzBNOE5GRzBILzl1RG45?=
 =?gb2312?B?L1luc0I4N2hJVmRZT0tqY2pheGQ1RE1naWRPN0tLaER5Yzc4RHlQbk5Pc3I5?=
 =?gb2312?B?VHNUdVQvYnIyRllrR3IvZ1VJangzZ0JLK1dmRUtLWTltQUR4ZjEvVjN0ci9L?=
 =?gb2312?B?bFl0VTlmMlhENXkybkFsaUtKMEpzR2QxT3h3cGVHOXFlQURZVHMzUmdadlpW?=
 =?gb2312?B?TkFVVVlrTDM5cmJCRVM2M2JGd3pUU3JhS3YwT245QXh6S3diMUxpUE9tVW5M?=
 =?gb2312?B?eFNKWlZIeklseExRMTkrNmMzdzdiaUZFUlRWMmplUE5oQ3QvZmdIeEJTZnEy?=
 =?gb2312?B?ekYyN0pVZDlmV0lEMWZ2L25WeVZXL1Framw4VW05MkFGSVBzWEhrc3FqVnVF?=
 =?gb2312?Q?c5k+rcyshyj2iwmuaMPq/4jOv?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d291baa8-bc97-4e6e-a8bb-08de15fd50d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2025 08:38:05.9843 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: trSC0kWwIZhjG6OQ08jikd/cb33BZbi0c57QFwZZ2kcGlDTn5+E9hbXvl+OyNarBwYIcAXQXIe9Vl2IBP0GYIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11481
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

PiAtLS0tLdPKvP7Urbz+LS0tLS0NCj4gt6K8/sjLOiBVLUJvb3QgPHUtYm9vdC1ib3VuY2VzQGxp
c3RzLmRlbnguZGU+ILT6se0gTWFyZWsgVmFzdXQNCj4gt6LLzcqxvOQ6IDIwMjXE6jEw1MIyNsjV
IDY6MzUNCj4gytW8/sjLOiB1LWJvb3RAbGlzdHMuZGVueC5kZQ0KPiCzrcvNOiBNYXJlayBWYXN1
dCA8bWFyZWsudmFzdXQrcmVuZXNhc0BtYWlsYm94Lm9yZz47IEFsaWNlIEd1bw0KPiA8YWxpY2Uu
Z3VvQG54cC5jb20+OyBQYXRyaWNlIENob3RhcmQgPHBhdHJpY2UuY2hvdGFyZEBmb3NzLnN0LmNv
bT47IFBlbmcNCj4gRmFuIDxwZW5nLmZhbkBueHAuY29tPjsgVG9tIFJpbmkgPHRyaW5pQGtvbnN1
bGtvLmNvbT47IFZhbGVudGluIENhcm9uDQo+IDx2YWxlbnRpbi5jYXJvbkBmb3NzLnN0LmNvbT47
IFllIExpIDx5ZS5saUBueHAuY29tPg0KPiDW98ziOiBbUEFUQ0hdIGZpcm13YXJlOiBzY21pOiBG
aXggdXAgY29kZSBjb21tZW50cw0KPiANCj4gRml4IG11bHRpcGxlIGluc3RhbmNlcyBvZiBjb3B5
LXBhc3RlIGVycm9ycy4gRmlsbCBpbiBtaXNzaW5nIGhlYWRlcnMgZm9yDQo+IENMT0NLX0dFVF9Q
RVJNSVNTSU9OUyBtZXNzYWdlIGFuZCByZXNwb25zZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE1h
cmVrIFZhc3V0IDxtYXJlay52YXN1dCtyZW5lc2FzQG1haWxib3gub3JnPg0KPiAtLS0NCj4gQ2M6
IEFsaWNlIEd1byA8YWxpY2UuZ3VvQG54cC5jb20+DQo+IENjOiBQYXRyaWNlIENob3RhcmQgPHBh
dHJpY2UuY2hvdGFyZEBmb3NzLnN0LmNvbT4NCj4gQ2M6IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAu
Y29tPg0KPiBDYzogVG9tIFJpbmkgPHRyaW5pQGtvbnN1bGtvLmNvbT4NCj4gQ2M6IFZhbGVudGlu
IENhcm9uIDx2YWxlbnRpbi5jYXJvbkBmb3NzLnN0LmNvbT4NCj4gQ2M6IFllIExpIDx5ZS5saUBu
eHAuY29tPg0KPiBDYzogdS1ib290QGxpc3RzLmRlbnguZGUNCj4gLS0tDQo+ICBpbmNsdWRlL3Nj
bWlfcHJvdG9jb2xzLmggfCAxMCArKysrKystLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNl
cnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvc2Nt
aV9wcm90b2NvbHMuaCBiL2luY2x1ZGUvc2NtaV9wcm90b2NvbHMuaCBpbmRleA0KPiBjZTc2NzEx
NzU3MC4uYzg4OWY2MjQyNGIgMTAwNjQ0DQo+IC0tLSBhL2luY2x1ZGUvc2NtaV9wcm90b2NvbHMu
aA0KPiArKysgYi9pbmNsdWRlL3NjbWlfcHJvdG9jb2xzLmgNCj4gQEAgLTc1MSwxMyArNzUxLDEz
IEBAIGVudW0gc2NtaV9jbG9ja19tZXNzYWdlX2lkIHsNCj4gICNkZWZpbmUgU0NNSV9DTEtfUkFU
RV9ST1VORF9VUAkJQklUKDIpDQo+ICAjZGVmaW5lIFNDTUlfQ0xLX1JBVEVfUk9VTkRfQ0xPU0VT
VAlCSVQoMykNCj4gDQo+ICAjZGVmaW5lIFNDTUlfQ0xPQ0tfTkFNRV9MRU5HVEhfTUFYIDE2DQo+
IA0KPiAgLyoqDQo+IC0gKiBzdHJ1Y3Qgc2NtaV9jbGtfZ2V0X25iX291dCAtIFJlc3BvbnNlIGZv
ciBTQ01JX1BST1RPQ09MX0FUVFJJQlVURVMNCj4gY29tbWFuZA0KPiArICogc3RydWN0IHNjbWlf
Y2xrX3Byb3RvY29sX2F0dHJfb3V0IC0gUmVzcG9uc2UgZm9yDQo+ICsgU0NNSV9QUk9UT0NPTF9B
VFRSSUJVVEVTIGNvbW1hbmQNCj4gICAqIEBzdGF0dXM6CVNDTUkgY29tbWFuZCBzdGF0dXMNCj4g
ICAqIEBhdHRyaWJ1dGVzOglBdHRyaWJ1dGVzIG9mIHRoZSBjbG9jayBwcm90b2NvbCwgbWFpbmx5
IG51bWJlciBvZiBjbG9ja3MNCj4gZXhwb3NlZA0KPiAgICovDQo+ICBzdHJ1Y3Qgc2NtaV9jbGtf
cHJvdG9jb2xfYXR0cl9vdXQgew0KPiAgCXMzMiBzdGF0dXM7DQo+ICAJdTMyIGF0dHJpYnV0ZXM7
DQo+IEBAIC04MTcsMTMgKzgxNywxMyBAQCBzdHJ1Y3Qgc2NtaV9jbGtfc3RhdGVfaW4gew0KPiAg
ICovDQo+ICBzdHJ1Y3Qgc2NtaV9jbGtfc3RhdGVfb3V0IHsNCj4gIAlzMzIgc3RhdHVzOw0KPiAg
fTsNCj4gDQo+ICAvKioNCj4gLSAqIHN0cnVjdCBzY21pX2Nsa19zdGF0ZV9pbiAtIE1lc3NhZ2Ug
cGF5bG9hZCBmb3IgQ0xPQ0tfUkFURV9HRVQgY29tbWFuZA0KPiArICogc3RydWN0IHNjbWlfY2xr
X3JhdGVfZ2V0X2luIC0gTWVzc2FnZSBwYXlsb2FkIGZvciBDTE9DS19SQVRFX0dFVA0KPiArIGNv
bW1hbmQNCj4gICAqIEBjbG9ja19pZDoJU0NNSSBjbG9jayBJRA0KPiAgICogQGF0dHJpYnV0ZXM6
CUF0dHJpYnV0ZXMgb2YgdGhlIHRhcmdldHMgY2xvY2sgc3RhdGUNCj4gICAqLw0KPiAgc3RydWN0
IHNjbWlfY2xrX3JhdGVfZ2V0X2luIHsNCj4gIAl1MzIgY2xvY2tfaWQ7DQo+ICB9Ow0KPiBAQCAt
ODM4LDEzICs4MzgsMTMgQEAgc3RydWN0IHNjbWlfY2xrX3JhdGVfZ2V0X291dCB7DQo+ICAJczMy
IHN0YXR1czsNCj4gIAl1MzIgcmF0ZV9sc2I7DQo+ICAJdTMyIHJhdGVfbXNiOw0KPiAgfTsNCj4g
DQo+ICAvKioNCj4gLSAqIHN0cnVjdCBzY21pX2Nsa19zdGF0ZV9pbiAtIE1lc3NhZ2UgcGF5bG9h
ZCBmb3IgQ0xPQ0tfUkFURV9TRVQgY29tbWFuZA0KPiArICogc3RydWN0IHNjbWlfY2xrX3JhdGVf
c2V0X2luIC0gTWVzc2FnZSBwYXlsb2FkIGZvciBDTE9DS19SQVRFX1NFVA0KPiArIGNvbW1hbmQN
Cj4gICAqIEBmbGFnczoJRmxhZ3MgZm9yIHRoZSBjbG9jayByYXRlIHNldCByZXF1ZXN0DQo+ICAg
KiBAY2xvY2tfaWQ6CVNDTUkgY2xvY2sgSUQNCj4gICAqIEByYXRlX2xzYjoJMzJiaXQgTFNCIG9m
IHRoZSBjbG9jayByYXRlIGluIEhlcnR6DQo+ICAgKiBAcmF0ZV9tc2I6CTMyYml0IE1TQiBvZiB0
aGUgY2xvY2sgcmF0ZSBpbiBIZXJ0eg0KPiAgICovDQo+ICBzdHJ1Y3Qgc2NtaV9jbGtfcmF0ZV9z
ZXRfaW4gew0KPiBAQCAtODYwLDEzICs4NjAsMTMgQEAgc3RydWN0IHNjbWlfY2xrX3JhdGVfc2V0
X2luIHsNCj4gICAqLw0KPiAgc3RydWN0IHNjbWlfY2xrX3JhdGVfc2V0X291dCB7DQo+ICAJczMy
IHN0YXR1czsNCj4gIH07DQo+IA0KPiAgLyoqDQo+IC0gKiBzdHJ1Y3Qgc2NtaV9jbGtfcGFyZW50
X3N0YXRlX2luIC0gTWVzc2FnZSBwYXlsb2FkIGZvciBDTE9DS19QQVJFTlRfU0VUDQo+IGNvbW1h
bmQNCj4gKyAqIHN0cnVjdCBzY21pX2Nsa19wYXJlbnRfc2V0X2luIC0gTWVzc2FnZSBwYXlsb2Fk
IGZvciBDTE9DS19QQVJFTlRfU0VUDQo+ICsgY29tbWFuZA0KPiAgICogQGNsb2NrX2lkOgkJU0NN
SSBjbG9jayBJRA0KPiAgICogQHBhcmVudF9jbGs6CQlTQ01JIGNsb2NrIElEDQo+ICAgKi8NCj4g
IHN0cnVjdCBzY21pX2Nsa19wYXJlbnRfc2V0X2luIHsNCj4gIAl1MzIgY2xvY2tfaWQ7DQo+ICAJ
dTMyIHBhcmVudF9jbGs7DQo+IEBAIC04NzgsMTkgKzg3OCwyMSBAQCBzdHJ1Y3Qgc2NtaV9jbGtf
cGFyZW50X3NldF9pbiB7DQo+ICAgKi8NCj4gIHN0cnVjdCBzY21pX2Nsa19wYXJlbnRfc2V0X291
dCB7DQo+ICAJczMyIHN0YXR1czsNCj4gIH07DQo+IA0KPiAgLyoqDQo+ICsgKiBzdHJ1Y3Qgc2Nt
aV9jbGtfZ2V0X3Blcm1pc3Npb25zX2luIC0gTWVzc2FnZSBwYXlsb2FkIGZvcg0KPiArIENMT0NL
X0dFVF9QRVJNSVNTSU9OUyBjb21tYW5kDQo+ICAgKiBAY2xvY2tfaWQ6CUlkZW50aWZpZXIgZm9y
IHRoZSBjbG9jayBkZXZpY2UuDQo+ICAgKi8NCj4gIHN0cnVjdCBzY21pX2Nsa19nZXRfcGVybWlz
c2lvbnNfaW4gew0KPiAgCXUzMiBjbG9ja19pZDsNCj4gIH07DQo+IA0KPiAgLyoqDQo+ICsgKiBz
dHJ1Y3Qgc2NtaV9jbGtfZ2V0X3Blcm1pc3Npb25zX291dCAtIFJlc3BvbnNlIHBheWxvYWQgZm9y
DQo+ICsgQ0xPQ0tfR0VUX1BFUk1JU1NJT05TIGNvbW1hbmQNCj4gICAqIEBzdGF0dXM6CU5lZ2F0
aXZlIDMyLWJpdCBpbnRlZ2VycyBhcmUgdXNlZCB0byByZXR1cm4gZXJyb3Igc3RhdHVzIGNvZGVz
Lg0KPiAgICogQHBlcm1pc3Npb25zOglCaXRbMzFdIENsb2NrIHN0YXRlIGNvbnRyb2wsIEJpdFsz
MF0gQ2xvY2sgcGFyZW50IGNvbnRyb2wsDQo+ICAgKiBCaXRbMjldIENsb2NrIHJhdGUgY29udHJv
bCwgQml0c1syODowXSBSZXNlcnZlZCwgbXVzdCBiZSB6ZXJvLg0KPiAgICovDQo+ICBzdHJ1Y3Qg
c2NtaV9jbGtfZ2V0X3Blcm1pc3Npb25zX291dCB7DQo+ICAJczMyIHN0YXR1czsNCj4gLS0NCj4g
Mi41MS4wDQoNCkhpLA0KDQpXaGlsZSByZXZpZXdpbmcgaW5jbHVkZS9zY21pX3Byb3RvY29scy5o
LCBJIG5vdGljZWQgdGhhdCB0aGVyZSBhcmUgc3RpbGwgYSBmZXcgZnVuY3Rpb25zIGFuZCBzdHJ1
Y3QgZGVmaW5pdGlvbnMgd2hvc2UgbmFtZXMgZG8gbm90IG1hdGNoIHRoZWlyIGFzc29jaWF0ZWQg
Y29tbWVudHMuIEZvciBleGFtcGxlOiBzY21pX2Jhc2VfcHJvdG9jb2xfYXR0cnMsIHNjbWlfYmFz
ZV9wcm90b2NvbF9tZXNzYWdlX2F0dHJzLCBzdHJ1Y3Qgc2NtaV9jbGtfYXR0cmlidXRlX291dCwg
c3RydWN0IHNjbWlfY2xrX2F0dHJpYnV0ZV9vdXRfdjIsIHN0cnVjdCBzY21pX3BpbmN0cmxfY29u
ZmlnX3NldF9pbi4gSSB0aGluayB0aGUgcmVtYWluaW5nIGluY29uc2lzdGVuY2llcyBzaG91bGQg
YWxzbyBiZSBjbGVhbmVkIHVwLg0KDQpCZXN0IHJlZ2FyZHMsDQpBbGljZSBHdW8NCg==
