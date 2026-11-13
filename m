Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA506606B1AE
	for <u-boot@archiver.kernel.org>; Fri, 13 Nov 2026 13:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=qQiQJeiw;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=RXzfpARP
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 50E9940E5B;
	Fri, 13 Nov 2026 13:55:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3vMsdkbvfMQt; Fri, 13 Nov 2026 13:55:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9377A40E39
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794578147;
	b=SAnNspA/ZTnb+6hEMxspGg7FMHG23gcyV01tZedjHot5ac6ZrQS3ldT2JQCJALjJhf8D
	 jT+r2edCmSYir7fGY9Jp3OM+PYle8vAeCFWQ1JeJ/VynOuy3HQrurC01bDgaFKh1styJF
	 eTME4vwX61WAh3deFuklbdq0UqjhIAfUFrw8EDtsRJIl6WwpaATnkA/a0LBz5nIfJ42Mr
	 r7HuLJPo/CxPWv4x+iNhRrl06hT1Do1GXGFmZ+iF0L7XcJGnqR0RynWdhXvcp1saJPTu7
	 U0coAiJRAd688RvMHilZL9vtr4vF+tf4eLKbC5/f0XLrSQUY4uNh5rJja5JLf2bEKXw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794578147;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=18BHokJ8SKKyc6jfWLe20NebV8LytbCg2wbn9u6OT84=;
	b=Njj6xy/6FOsHHdQjkpE8RyPfF2NzzQrAoG0TLDybPBqEUU/c3cK4BBzCS0k2CtZAtZjA
	 MwEbGHSTPpMqNGP5VusVWHhEtJKqXjp8vCREgeMkuYcJ4RLvdriOO/eohK0Xkefid+wfB
	 Y7soEI6pp1eqsefmZnhfCKu4cWzM/ZGS2xxIu+UQm8fo6ElBVqhzMCwLFvvryXfgrHcJD
	 1mWPf00GitfvbQHFbOD+bvO3k3UU8PY9GfBe53SLdyB/pZ/ftybn8bl6PYRD/znsBeStT
	 8qTrqiW1swpQYHPrVeaYyUkLtCk7Es9qCCwdYC3pFyx4TGNfMfJ+LOQS3Nc/zKvtQyw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794578147;
	bh=18BHokJ8SKKyc6jfWLe20NebV8LytbCg2wbn9u6OT84=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qQiQJeiw4zwSIFxBJBxNRoFgpIDTjN4PPcmAdW705QFJxMf2vBJ8OwjbTgf1kvnjW
	 2w+iC/Nwp14MWjk8BEJ5PYPMzISNUXlRDGK0vSCXvJFRY+CRhZpQ5OtFnYRANc4071
	 DvpL6LbC8bqvdaPmhtRSdx4Kg6oLO4iJeD7rtrr2lJEEUV+sKD5jrRBybF1XMionBc
	 FWsljLoEMl81xqTYK0wb5l3VR4D3r/CskSQeGp8FMK5wd8YwRMZjIHrANLaf3bQmY+
	 2vku/oqsnYnQImYagBL8Z5EAwCdmzVf4WEdMLww6Gl1PEaTU6GbCt2HfAgckOqTj34
	 wrc3agq9on6ww==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9377A40E39;
	Fri, 13 Nov 2026 13:55:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 3D5DEAF8
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 13:55:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2E18260A52
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 13:55:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MYJt4KnOZ4Uu for <u-boot@lists.u-boot-project.org>;
 Fri, 13 Nov 2026 13:55:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4DB08606F6
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::3;
 helo=as8pr04cu009.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=RXzfpARP
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4DB08606F6
 for <u-boot@lists.u-boot-project.org>; Fri, 13 Nov 2026 13:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=18BHokJ8SKKyc6jfWLe20NebV8LytbCg2wbn9u6OT84=;
 b=RXzfpARPMis7djfZCb22iZN0T4yF2hZ+G5VTnKk/l+v6Bxa3Kwn1qA4lhntymy+P8eMgdHt0Ts3WGPdNxMAfdBGmezTujN0mAtM37FznKaI9gCgMLXgcu66FJR2tbn2LXiJv0yorngrvQ2OWqGkww9Ge+ZBING+yHHZjYZOx0Dk=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by PA4PR04MB7821.eurprd04.prod.outlook.com (2603:10a6:102:c5::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Fri, 13 Nov
 2026 13:55:38 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0615.009; Fri, 13 Nov 2026
 13:55:38 +0000
Message-ID: <a9128662-a49a-416b-9fc1-baeaba3c569a@cherry.de>
Date: Fri, 13 Nov 2026 14:55:37 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] rockchip: Remove unnecessary clk_set_defaults()
 calls
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>
Cc: Simon Glass <sjg@chromium.org>, Lukasz Majewski <lukma@nabladev.com>,
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, u-boot@lists.u-boot-project.org
References: <20261027224742.2527550-1-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261027224742.2527550-1-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0181.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::17) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|PA4PR04MB7821:EE_
X-MS-Office365-Filtering-Correlation-Id: eb2aa937-bb19-48f7-38fc-08df418dcc22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|23010399003|10067099003|11063799006|56012099006|261026121527099003|261026140227099003|261022105027099003|261028144727099003|261022075727099003|261021123027099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: A5KjJKvre5RG0GFjT9m9L/kN5GytXi7h6gG6OuzTG4G2y3+FtrZZ9cgbhN/J0ompCvLZFYhPPo56+70qAUPIJM32gCrIYcHxj1RrDQs1Dz3hGF/HdMkQhKEZNo9Ml7LRebAEIRY7n0gKyngyWLjgutZYkF+7/Fd2eKjw+9SeAhKir6pCZglZMtW6Yf19Vm7wkDrlxyH8xoNPKIa4XW2qav4IA8TzNnH3uyQVom334QP36EG6YoZ+Wy8jXAsvDLTn/5CpP5R3cqa4cq1e3r9lDLZUEhRzqyUEddTsUWC57w2RqmzWxeqT5lEW7Cg8YMoXJkfkgDJx0rFhz61uM2+8gVbXMyKhRKieoEIZP3ixp9dYuibYFBOD+DtXeZy6PBm/CCtoxxzWA972S6byl2paeTq3we1fzww8mwJWXVPlVhlrfmztz0pqPhdNkys5A8ZKn/tSo3Kthwgq1izAF7E+OF3sc3CUmELnI5AIIJyKeqiH6GCHhUJwuL5tEf64+pFj3vMuIlJy8ozuEk3cayMXIIMyj+Dy5mi9dIl7bLGphpLmDdZ67+MiHxUAvK8qz5IlWTC9zcf9w5ZDUBOYJIFeLB5650CcZR9e97b1fZNg/V1NqqU3wXUw6EU31w6U/8giujqbqJSbQYbMLuvwHAxqldwjnh70NIDA9rqLoE2RWa4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(10067099003)(11063799006)(56012099006)(261026121527099003)(261026140227099003)(261022105027099003)(261028144727099003)(261022075727099003)(261021123027099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?THU5bjlORFhYcEZCT3paZm1Vam5KbmpvQUZaWjloaGtINlpUNnBvUmZhTmdZ?=
 =?utf-8?B?Szd0WXg4NlpVMTRYQ0JMWGJEb1ZLQUpIaG1TOXFUb01XVE8xT3R1THkzUkZL?=
 =?utf-8?B?eUJ5Y0Uvdkk3QnhSRTlYSjRJSXhpOVZFWEFXSTJxOHZEam9Jb0xaME5XQkoz?=
 =?utf-8?B?OUkvOGJ1OXM0SHB4RDI3bUs4MnBvbXZmbXB2Q3F6WHdVZVZibFhHQmR1Qi8w?=
 =?utf-8?B?RlpRVGkvYWdjZUlSNnNWc1MwMVdrRElvTGtzTkNiQjFjQnJQNHRsMk4zeUx6?=
 =?utf-8?B?a2lCdG9IV3RrQW1FcDBhWjltcHdaU0tHNGlTWTVGSHpkbXBsbStOb2JlOGt1?=
 =?utf-8?B?eGxzY0l2MkxUVHpKcndqcTdQOTBPUlhaSW1GTThwT3ROWnhwOVZoM1JGL1NJ?=
 =?utf-8?B?OUdqREVVNVpWeWNBWFNJRng4akNrdi8vNnRiZmpYY1FnWGJLR2lKcktSQTNB?=
 =?utf-8?B?bDcwelM5ZUh0QVNWcUlZTXpSMysvRXBQT1NTbERpdmNGcFBDL0kyR1RzTEFP?=
 =?utf-8?B?eUU3WC90YTlVMFdLUGI3QlhFdW9rc0lNWXhIY29uVzdKQlRGeVZrZzhGU1pa?=
 =?utf-8?B?cVpnOWhkaDd2YjExK2QvK1lZYzI4NCtwV1RZd1AvbmpUbVFRZm5Qd01tU1pI?=
 =?utf-8?B?TVJBaUQ4cjgzbGZLSk5Cb3ZMbnlVSUxyQUdCOUtCNGRwS1FVMjhJcVJwR2Zz?=
 =?utf-8?B?Zms5VjhjcHRsV1BHaHlib3dYZnA5V2w2MHk3S1VOYW9oZE5CWTdjWmlvbDg5?=
 =?utf-8?B?eDU4UFluZXhrQlo2YVlYYzZvaU5LV01EMUZaMGJVNktUOCs4RnZ6UUNmaUxN?=
 =?utf-8?B?bVZhWWNkcGJiRUZPeDhvcDUva1Rna2t4S1FvQm83eUs1OTA3VVhzeklsUjBx?=
 =?utf-8?B?Zm9Vd2s0aG83U1ErQ1JJYUZlOExvYlZobVJkcXlNUVVKeThMa2FpYU9jcWhU?=
 =?utf-8?B?ZlR5WVFzek5aRGtEREd0NkYzVjVvcGd6UHArZjNPV0QwSXJQTnJZQmJvWmNG?=
 =?utf-8?B?VWxlajM1ajl5MW1WWExUeGoxWjlqclN3eVpuUUo3OXhodDVkdEtGcEJ0b2xH?=
 =?utf-8?B?OUJvbzJHcmRJaE5YUjRmZjVGellMcFlodWI1TnBNaVMwaXpJM1VvYzZXM3ZI?=
 =?utf-8?B?djJ1S3dWa0Z0d1FjVXJBTklFTXlkbGc1emFRN0YwS2RSdUZEYzA5blFyOXRh?=
 =?utf-8?B?L2Z3Vmw2amk3TnhrWHY2aG1PRHVCb3pZOFUzL2wxVjVpc3YxbXI4aWN1Q2pE?=
 =?utf-8?B?RUp4OXpPTHVWMmlYVXMwL3ByaDhpV2s4Z3ZJVDhkRG44SjFmQXFJekJzeHo1?=
 =?utf-8?B?bUJsQ1Yrd2ptcW5DQmFDbUdjbGppakZsRWUyRTZTUFhUbjFkUVptK2pjY2xU?=
 =?utf-8?B?Z09XTWZDWnVBU3hUcnlocUtrV1hXNHdFS3EyZmdta3grdWpzYzg0WlFMbE5s?=
 =?utf-8?B?VitsNWtrdmtKL3BzWUNER05yUVNQU3E2NXBaR24wQWNSVHUzYW1QcEpUSEZj?=
 =?utf-8?B?TmY1QisvS0U3QStkMk5GNWM4OSt6Z2dUUjZFYW1XSnEzeGh5cWdLV0hseFJD?=
 =?utf-8?B?VFM4M0dyWlJaRjNtTmVFM1JRb1hKazZ0ZlBhK3R6Skc3NDFKWXdPNTVlQ3Nh?=
 =?utf-8?B?UDBwK05HL1FOSjdMdS9nU0xDRGRVUktLYmVLa1hkVkczNzBQc1d3ZDU2MnF0?=
 =?utf-8?B?WVZyK0VvNlZlcC82RzJabmRiazg0aEpianZTeEpKVHZYbzEyL2l1OUpodDJK?=
 =?utf-8?B?cmZYaGFzOGNkSWRtUTVMMDhBbWI1TUY0WG12Z2orei95cXhlU3A0QXdFc2J6?=
 =?utf-8?B?dEszUjMxNUNpQlVlOEN5d29INXhKbkY1cVRvbVlMODNWS3FXd0ljWEZQam1K?=
 =?utf-8?B?WUh0d05RQm0rK1BidllKbkxMa2V0dzkvdEczOW1WbC9RbGhPbFkrd1piOGph?=
 =?utf-8?B?dTJJWUNpUmhBeUE4TUtlV3JaNEwrcG15K3B2T1dMQ2cwSnhTaVBlcC9xRmZa?=
 =?utf-8?B?K05vbGtZdzA2MkxRbDVPUUVrbkE0dStGWis0N0tZMUtmbnFkSGFpVSs5dTh3?=
 =?utf-8?B?dGRPOVpxTWs5dzdvYytyb0N3d3BOVzJSQUtwOVIvU3dSRDBXU3FkMUJuOVZ0?=
 =?utf-8?B?ZjI0UFNYQWxiaTVYc0ZXR2xPbG5lUlIrQ0JTaW0wTmRJZHBYUTAwYjdmNU1s?=
 =?utf-8?B?cVJBelk5VVpxelFJbHZ1U0RKamFoQUZudjYyUlpjN2ZpdFlXbDkvTXRZNjZ2?=
 =?utf-8?B?bDFWTm5odmdNaTQvTnFiZkl1ZUc5UjZmcUJuVmZmblg3VDFqcnpWTHh6R2U1?=
 =?utf-8?B?ZmVtNnpoNUtNSkJ2SjhuRjZXdENBRUtmSEdPQmhpWVN6enhKanFpQT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: eb2aa937-bb19-48f7-38fc-08df418dcc22
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 13:55:38.3628 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KljiY2CX9qi/iXltTB8xnSfAC/YGQJuSvETY1dWkhofhQYaPXIje40v0OV6ASe3HTfyqUSobjHpxZFsaTQTRhmkonIuurwdlE1YesP0OMYE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7821
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Jonas,

On 10/27/26 11:47 PM, Jonas Karlman wrote:
> The driver model core and clock-uclass will call clk_set_defaults() to
> automatically apply assigned clocks for devices during normal udevice
> lifecycle.
> 
> This series remove unnecessary clk_set_defaults() calls for Rockchip
> drivers. These clk_set_defaults() calls likely originates from vendor
> U-Boot where driver model core calls to clk_set_defaults() was removed
> and moved to just a few drivers with claims to improve boot speed.
> 
> After these changes any CRU assigned clocks is typically still applied
> two times, once for the clock driver and once more for the reset driver.
> A separate series to introduce a driver flag to skip clk_set_defaults()
> is planned to address the unnecessary apply of assigned clocks for the
> reset-uclass driver bound to the same DT node.
> 
> Changes in v2:
> - Drop already applied patch
> - Remove the unnecessary ret variable for rk3576 and rk3588
> 
> Jonas Karlman (7):
>    clk: rockchip: rk3506: Remove unnecessary clk_set_defaults() call
>    clk: rockchip: rk3528: Remove unnecessary clk_set_defaults() call
>    clk: rockchip: rk3568: Remove unnecessary clk_set_defaults() call
>    clk: rockchip: rk3576: Remove unnecessary clk_set_defaults() call
>    clk: rockchip: rk3588: Remove unnecessary clk_set_defaults() call
>    clk: rockchip: rv1126: Remove unnecessary clk_set_defaults() call
>    clk: rockchip: rk3308: Remove unnecessary clk_set_defaults() call
> 

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
