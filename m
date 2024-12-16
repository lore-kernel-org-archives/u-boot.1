Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20554E7717F
	for <u-boot@archiver.kernel.org>; Mon, 16 Dec 2024 12:48:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9692A8005B;
	Mon, 16 Dec 2024 13:48:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=softathome.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=softathome1.onmicrosoft.com header.i=@softathome1.onmicrosoft.com header.b="OzFV5/SW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ED206801BF; Mon, 16 Dec 2024 13:48:45 +0100 (CET)
Received: from PR0P264CU014.outbound.protection.outlook.com
 (mail-francecentralazlp170120004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F7468004E
 for <u-boot+nodisclaimer@lists.denx.de>; Mon, 16 Dec 2024 13:48:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=softathome.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=philippe.reynes@softathome.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ALe48taYLcs64MnmFPJpw+bAf5ok/SqC/IxhN1+p3lpxNgOxHPH1stO9ttVkaaUW1BazJaQGlZ8kwWT9dZmI1G0K2LXIykV7QVA8H2r4JqK5bjwqMZwOIF7WWaQTR5q6nOF32MaeXmQM6XMkujpeINcLxy5yzZttf/8A4hVaJoSU938WjPnLQjed7Zp+fC3KixTI58+jB7sldGIWnPevBMvs0p6sPUmg864LsMkcZwGS4+BN3MZfgKob0VJoYzEg1crhPRaOk+VzDso+LTE286+yjC6ucgKhOzDBohaJO4JYGxkSRDbeyzFR8y5w3vwph4fAx5LOhqwoZKyqWGlSFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WFBsmaup3/ta2N02b0jS8CVLKmA4h9lffLwpHsuZihM=;
 b=ikJsIh3Q3OVllq62kGeaBVuzSEl/epqyafl+jYFIu6j9qVvM11mamZ36erWPxBmMGnRCVkIL059cHoutaLRRCiOPIwGU+GTIzmrTZ3qxJoc25U2gYQGg6b81cXoylaVWizwG5f7mHWhVOyraiSaf242n8UV0aDmBFhdzLlCn7t/bEASjQg32IdN+/piDyzV72wGCTQb2BfqL0f4vi4KMjmh6JJAN2hAfIvt3Rh5/sOPcytQnj/P/iEcjpW9TGbyFjqZD18QEtgziVW4+5YNLAxvN3fF1esRxLhodfpCUW0Nb2QnvYweSTq8//pz1pI9NMUua92StAiMmvqNPNN+IgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=softathome.com; dmarc=pass action=none
 header.from=softathome.com; dkim=pass header.d=softathome.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=softathome1.onmicrosoft.com; s=selector1-softathome1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WFBsmaup3/ta2N02b0jS8CVLKmA4h9lffLwpHsuZihM=;
 b=OzFV5/SWeSix3CfWUlTahdRMDltdpfKe3gXf49+9vby6G+r5Hw1133x6gFXEvaq7hWYqtXQ1L/0FQx/oCzys2/hKaZOoW9FLO015LTAjI85j7y8549EtLuDaUG/IyB/Vd37xAwChJ8mdNGwDY3V5W2eF68Q9wWLQ9oYDvrwXBOmZKbvZ+rddl9vWVlu0HSKKcNbjFwg8kqKBMwHXhjAIe+EUUDinpvseqpVLOd2RGI5++lRNtmm4MigjQ8KuIuPz0Q8QbenUMBjOpICf7Eh8X5j212yZ++ADtJRfQFOD3+CaJTOFYRdwF+4qgVTXBFmdIPTlPBub3SUdBcycEfmwUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=softathome.com;
Received: from PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1d0::9)
 by PARP264MB5615.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:4bb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Mon, 16 Dec
 2024 12:48:42 +0000
Received: from PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM
 ([fe80::28e7:f006:fbc2:3f27]) by PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM
 ([fe80::28e7:f006:fbc2:3f27%6]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 12:48:42 +0000
Message-ID: <255d5a83-f8b9-4d13-9b76-efb6b8dc18de@softathome.com>
Date: Mon, 16 Dec 2024 13:48:41 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/8] lib: sha256: add feature sha256_hmac
To: raymond.mao+nodisclaimer@linaro.org
Cc: sjg+nodisclaimer@chromium.org, u-boot+nodisclaimer@lists.denx.de
References: <20241212133710.172404-1-philippe.reynes@softathome.com>
 <20241212133710.172404-6-philippe.reynes@softathome.com>
 <CAEfUkUKiV1dy4iOjmo_46Wg=Dg0Pt93XYJJNB4UFD-08__zxbA@mail.gmail.com>
Content-Language: en-US
From: Philippe REYNES <philippe.reynes@softathome.com>
In-Reply-To: <CAEfUkUKiV1dy4iOjmo_46Wg=Dg0Pt93XYJJNB4UFD-08__zxbA@mail.gmail.com>
X-ClientProxiedBy: PR0P264CA0215.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1f::35) To PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:1d0::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR0P264MB2741:EE_|PARP264MB5615:EE_
X-MS-Office365-Filtering-Correlation-Id: 23387b21-5363-443e-e7b6-08dd1dcff878
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|376014|1800799024|366016|8096899003; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SDNxUURLU2J4TldqcGFrTE9neXduVmxZZnRYcnhVSFNPOGVJa3pmdXVPOWFE?=
 =?utf-8?B?VFMrQXpHWHhwUDAzb1BrTkc1enhRaGdseElZVXY1Znp3UkRRRkJjbmFqMmFN?=
 =?utf-8?B?c2hxVDRpU0hGR3ZZcEpVekxlYnE5QTJJamd0TWwxaXBZOTZ2ZXowM0ZYNlo4?=
 =?utf-8?B?WURmN0RoRkVCbm9mTGFCRkNBbmN6bVhnVWpWWm5BYUlsSEFjSlVIaktObXdQ?=
 =?utf-8?B?SUJlVE9rVmJJc1FXN2hVMENkenpGTFJmQWQ4eUZhMHJuQ21oajBpYXpIRG16?=
 =?utf-8?B?cE05MHozMTQyVlpkS3lLU0pXMXNrVEsvdEtQczNOS2Z6d0M2VUhLN2hrWEJK?=
 =?utf-8?B?VzI0QUlLcmlRdnlhSE1DbHg5dkhzSmhuNDFjTEZwNnR4SEtTVjd6RGdzSkhD?=
 =?utf-8?B?WUJHQU9KakhNSDFBcmRJZ1JkVks3Y1NWQldHazdnK1FGbEJuZnRBSzY5Skda?=
 =?utf-8?B?TWV0R3FuTDFnbEcvK3hlUFdBbk5jS3U1MGhENHBuZXhhU1BNZ1ZHenpSN29o?=
 =?utf-8?B?S1h0TkpvbXlqYTFHcXlqN3c3RDMySXp6VGRCUzRHWVRQaGxLb1BvYzlFS3Z3?=
 =?utf-8?B?U2JvOXFQdG5pUXAybTlLd1FjNWF0cVI0Mi83WGdnRmI5emo1RmtqK0haZHl6?=
 =?utf-8?B?MHJWMXhMdmJ5SzdMNXRWTDJ0bGJNNWNQT1B1WHhYS3l3M3ZrM1pmdUI2V2pQ?=
 =?utf-8?B?SjlYRmUrRzM1YnpkSXA2WFJ3NExtQkp6cWhTamVjZGdqZXdaOHNhdnlSODk3?=
 =?utf-8?B?UmY1WHZPTVpJOUcxVUFpc2p6V1dGazBPemNOOTY1V0JlUzgyQURYcENjdlpj?=
 =?utf-8?B?c0ZWemhRNzlCK3k2MElFd0EzeCthV0JKMnVZUXpaWmZ1TjFhTVM0VThrM1Vo?=
 =?utf-8?B?T3BPRHU3Sk5NQ055a3oycWxsVWRZb2FxcFQzY2tSK1lOaWN2T1pKV2FmQ3p5?=
 =?utf-8?B?WFRHS2hWczJJTkZoZkxBN29hQ1p6Q2JEd1hQNmR2U0ZnTlRSbjlhZStGUkdC?=
 =?utf-8?B?NlY2MlVONHhKVCtzSmVwcEtZQVhTUUd5WnZ0TFNCTTZKeURDL1hyNHYrcDYv?=
 =?utf-8?B?WmNka3FrazhDYm02d2I3MmtuaXo3OFBkeHFXYzZxRTlmMnZ1WVdTSGZBSnY5?=
 =?utf-8?B?OVNSVlMvZ2cvZTNLSS8rZUVyd0NFd0FlK2xUcU10RHBJNnJ6T3pXR1VWbUV2?=
 =?utf-8?B?QU9peVl2UHV2TGFrRzArRGxPdkZXZVhEZkZ3VWYwL00rTHdNUWdIbDhGcjdR?=
 =?utf-8?B?UVo3ODJFblRmbmwrTG9ySUdIN1Y3b3ZyRkNsZkpwbEtFOEpYaTJlZnlWUzdC?=
 =?utf-8?B?TjhSbFhUNG5CczgrdjRLdGkyb2VTN0k0dnZob3cwQXZ2SkxOUWZFc1R1QzBN?=
 =?utf-8?B?aDczUFBaeStiait2LzYvYWovOWFsQ21sYVE1VHdZa0p2cis0VnBWRkFoUUNi?=
 =?utf-8?B?VzM0NWdWbWM4V3pBMWh0YzlLTG1nMlh0S1hGMTJad1ZyYXFFZm5ZT1BDcjVo?=
 =?utf-8?B?bnhJeG5iWFdXUzlzTUdPNlhxVzFTVkx6Zm01N2YrTGsrRmlReXNudnFXWmhE?=
 =?utf-8?B?TmQyVFFkK3dHM1V5QjlWYjNXempRcUV2UFEzWkZvd0RCTmNvY3g3dkwzWmJ1?=
 =?utf-8?B?NWwzSk8zZTJvVE96WW9vcWNwZ1ZZNTFPYnV0VWFlTmJtVWhJZGdBekRhN0Vr?=
 =?utf-8?B?NzNwVFZweTcxSG5SckgzaFVpNmxaUzlsemMvOFVBc3YyVENxN2tGZkR5M2U2?=
 =?utf-8?B?aEhwaVRLbXNOUkgxRGFEZGwyQ1dLYjhTSlNuemV2VWJ3MXlURWtnUUNoN3dD?=
 =?utf-8?B?MVJFVXo1TjZ4T1hmdEtCQ2cxdFZhbGkzV0U3SkhpaExOSTFwK3NGWmpwbEpr?=
 =?utf-8?Q?Jn11emZqXBmsG?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(1800799024)(366016)(8096899003); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZHdOVUJwRHVZSEpJd2J4YUtDZ1k0NWcvaHV0ZlNzQzhlalpPUFJ2dlFOTkhW?=
 =?utf-8?B?U1FJT2M1blFKWUc1Zi9Bblh5ZFB1YTRUa3NMVG9QRmJVVklGZXZEbkF1Ui8r?=
 =?utf-8?B?S3FuMm1MUThqajBtbUJaWHV1ZHUrZ3M2WUFiVUFweFdqaVpqenI2dnR6c1lQ?=
 =?utf-8?B?YUxPcDJLUGFuekVPWnJMWW00LzEzV2dMM2pmb3IrNjlsVXNoa0c4VGRpN0Uv?=
 =?utf-8?B?ZGxjVFhyZTRqVEVqMTFZSW4rVTN6Njg0YS96aDZnK1VzRm4xVUcyYzFTbXc0?=
 =?utf-8?B?b2dkcnJBWjRRUFNVQnJOWjZ6eDArNkorcTNLdUJiZkJLVElsRE41UDgydTh4?=
 =?utf-8?B?VFJrT3ZjaTlIWnJCSUhUZmtMcUxMTEE1M2JUNmN0S2U5VkwycWpOSEl0T2pr?=
 =?utf-8?B?anNnZkM4UStDUmhxZXhsLzQ4NnM5c01aaU9QSS9YcXpHN0dHakNZN0dOT2ZY?=
 =?utf-8?B?cG5QQXFaUk13R3dkaEtaZFI2RWQ3K1psZDNaUjZWSEgxd1hLY3ZMbE5sRnV1?=
 =?utf-8?B?RWRlRHMyUnBNcFQ3S1ZCdXNRR2haajJMTFdxVVNPSG5wUjFNd3Z6T2NZc0lO?=
 =?utf-8?B?RGtTUUZYNGxpK3dXMjhKdUVSMUhwMTVvSm1CdUlxY1hYK25MeSsyY1dWcWVV?=
 =?utf-8?B?WWVDRm1XTVJoZE44alA0RlhwdWtkU3JINy9HQk5jazBVUGV6TjVOWjZhK0ZZ?=
 =?utf-8?B?QjR4K0FCWFJmZTFONFpQL25oWUMxeDYrQmJWRGIwaDhsR21UMkVaYlFZUko0?=
 =?utf-8?B?Nm5aMWxTdGd1cjhBdkpzc2RwTUtWMDkzd3BEazZ1V0RYREVLSW9aNjFVWWlH?=
 =?utf-8?B?YW43UXplaGRWMjlFK2wzekFtMDh4aElWNGRZRkZCYk1TY0pmY09VSUFZTXZU?=
 =?utf-8?B?cW5GMzlUMjVMbXhnUGdhc3BLdGltQXBOSUtYLzRyYW1rU0NTMnVmcEFCWFln?=
 =?utf-8?B?aEsyQkxEayt0YWRGQzcvNnJVQmliSVQ1NjNOOGFJTTV2aVdCWkptMnh3Qnhj?=
 =?utf-8?B?T3lwWGhWQkZvQjZ0K1JmMkd3NDFFUVBwQmlwcEVWeTlIeVltaXp6M3BjTFJ6?=
 =?utf-8?B?ZW9jdEU3YU1ibG02S1lBMHFmYUNqNlYrNEkwYmNDRFU4eFhtdld4NXFmRHg3?=
 =?utf-8?B?Yks0c0I1dU03SEo2YmNOVmJITTlGMG9VMnZUNU9ZRzNrWFk4bHpwQ2dsUm9t?=
 =?utf-8?B?S2lWNjVZOWFRL2g5Wk1hSlEveU5iK2JYYlBBUlRMellXLzh3ZVpZMmZUYmxQ?=
 =?utf-8?B?d083QlR6d2FRcUhWc2xWWDlXUmVqbFNHbUR6NzdJbFRiUUNyTnV6Y0JtTi9Y?=
 =?utf-8?B?YUxZQ2M0MXNuOEp2UnFxVmtTM0FvWUdpVUl5TzAybTRIamtmeXZ2WHkxemtj?=
 =?utf-8?B?L0JGNVRQNjRqSHhNWXJoZHZiZzA1RFFEYTE2SFRONTU4bThWUGZWSDhwcFNG?=
 =?utf-8?B?ajZueXRZejVHWTJJUmhYSE1YMGhZZEw2ajJqU01NTHUrK2hQdjFYS3YxTWtZ?=
 =?utf-8?B?cEU1dVpxdkhpaTNwR05ZaG9reGZsdnQxQmx1ay9Gb2lDK3paZGN3MHh6NlN1?=
 =?utf-8?B?N2pIa3BLanZqRStzNEpzZ2hLU24zdnM3aUw5d2tPc3lpRzRFT3l0eGEwdTMw?=
 =?utf-8?B?ckQ1cG1rNjRjUG1oTGdDUmZ3MGhjMlRSdFNqN2tWQ2VNdzlGUmUvdC8yWXU2?=
 =?utf-8?B?WDNwaVFhU2RLeHBQTm5iZWQwZmJieDBPOTVrTUhqd0tNaXRZM0RXL3hFb3BP?=
 =?utf-8?B?Mk5hTGJ6QUlId211RUtGVFNtbUNqZ3YvckhZZytMYTNLdHVyUW9UYnZEdEFH?=
 =?utf-8?B?amxhM0dkWU5uUng2VUJuUnJWMFdlWWQvUldaNTBpYUJWN001ZElqZmp1eUQr?=
 =?utf-8?B?M0RDSjhrQVVBRXNBNVNSWXR4eTg1dzNWNW1LSDhlYUJlSGxiV0FveEhHUTBY?=
 =?utf-8?B?d0lVYVBCdmUwMmxsNXIrbHlxZXQvem5pUE95QTN1UG9HRVYzemovcjhydHhi?=
 =?utf-8?B?Y0hDcFZDSnkzZHNlLzhPd2VrVUxhbWlIY1VqalA5emNWTDJDUEF1VzFvUlpT?=
 =?utf-8?B?K2k3eFBpeVVQRTVqSStLeU82dzd4dGRwem03cVlMbUhqcWFzU3dNeGUyOFRR?=
 =?utf-8?B?cDJQVnp2NUN2MDBSaERnWUtjTm5FdXR5bzRrYnBhUG0yUHJzK1YzUXh6SHNW?=
 =?utf-8?B?cmdVemJDZWVBUitqamlHSmZZMjMzNDBmQ3JOalJUTStTTENweUlGbHFjK1BZ?=
 =?utf-8?Q?FG3o83DJlzI52pz/79ciCFtJw2hCJMOg5mqwlkD5eg=3D?=
X-OriginatorOrg: softathome.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23387b21-5363-443e-e7b6-08dd1dcff878
X-MS-Exchange-CrossTenant-AuthSource: PR0P264MB2741.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 12:48:42.2300 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aa10e044-e405-4c10-8353-36b4d0cce511
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0nAH2eAEp3yK5+291u3GeRAhonXDDKRfqoSV3ohdNZMzCfEcAx2bP57zJyj0Yk7oxIYlDRdMP/vAIW0ftVKIR4WhqvsWV7adgqlxcNOwDY8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PARP264MB5615
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Raymond,


Le 13/12/2024 à 17:49, Raymond Mao a écrit :
>
> *This Mail comes from Outside of SoftAtHome: *Do not answer, click 
> links or open attachments unless you recognize the sender and know the 
> content is safe.**
>
> Hi Philippe,
>
> On Thu, 12 Dec 2024 at 08:37, Philippe Reynes 
> <philippe.reynes@softathome.com> wrote:
>
>     Adds the support of the hmac based on sha256.
>     This implementation is based on rfc2104.
>
>     Signed-off-by: Philippe Reynes <philippe.reynes@softathome.com>
>     ---
>      include/u-boot/sha256.h |  4 ++++
>      lib/sha256_common.c     | 48
>     +++++++++++++++++++++++++++++++++++++++++
>      2 files changed, 52 insertions(+)
>
>     diff --git a/include/u-boot/sha256.h b/include/u-boot/sha256.h
>     index 44a9b528b48..2f12275b703 100644
>     --- a/include/u-boot/sha256.h
>     +++ b/include/u-boot/sha256.h
>     @@ -45,4 +45,8 @@ void sha256_finish(sha256_context * ctx, uint8_t
>     digest[SHA256_SUM_LEN]);
>      void sha256_csum_wd(const unsigned char *input, unsigned int ilen,
>                     unsigned char *output, unsigned int chunk_sz);
>
>     +void sha256_hmac(const unsigned char *key, int keylen,
>     +                const unsigned char *input, unsigned int ilen,
>     +                unsigned char *output);
>     +
>      #endif /* _SHA256_H */
>     diff --git a/lib/sha256_common.c b/lib/sha256_common.c
>     index 7041abd26d9..46262ea99a2 100644
>     --- a/lib/sha256_common.c
>     +++ b/lib/sha256_common.c
>     @@ -48,3 +48,51 @@ void sha256_csum_wd(const unsigned char *input,
>     unsigned int ilen,
>
>             sha256_finish(&ctx, output);
>      }
>     +
>     +void sha256_hmac(const unsigned char *key, int keylen,
>     +                const unsigned char *input, unsigned int ilen,
>     +                unsigned char *output)
>     +{
>     +       int i;
>     +       sha256_context ctx;
>     +       unsigned char keybuf[64];
>     +       unsigned char k_ipad[64];
>     +       unsigned char k_opad[64];
>     +       unsigned char tmpbuf[32];
>     +       int keybuf_len;
>     +
>     +       if (keylen > 64) {
>     +               sha256_starts(&ctx);
>     +               sha256_update(&ctx, key, keylen);
>     +               sha256_finish(&ctx, keybuf);
>     +
>     +               keybuf_len = 32;
>     +       } else {
>     +               memcpy(keybuf, key, keylen);
>     +               keybuf_len = keylen;
>     +       }
>     +
>     +       memset(k_ipad, 0x36, 64);
>     +       memset(k_opad, 0x5C, 64);
>     +
>     +       for (i = 0; i < keybuf_len; i++) {
>     +               k_ipad[i] ^= keybuf[i];
>     +               k_opad[i] ^= keybuf[i];
>     +       }
>     +
>     +       sha256_starts(&ctx);
>     +       sha256_update(&ctx, k_ipad, sizeof(k_ipad));
>     +       sha256_update(&ctx, input, ilen);
>     +       sha256_finish(&ctx, tmpbuf);
>     +
>     +       sha256_starts(&ctx);
>     +       sha256_update(&ctx, k_opad, sizeof(k_opad));
>     +       sha256_update(&ctx, tmpbuf, sizeof(tmpbuf));
>     +       sha256_finish(&ctx, output);
>     +
>     +       memset(k_ipad, 0, sizeof(k_ipad));
>     +       memset(k_opad, 0, sizeof(k_opad));
>     +       memset(tmpbuf, 0, sizeof(tmpbuf));
>     +       memset(keybuf, 0, sizeof(keybuf));
>     +       memset(&ctx, 0, sizeof(sha256_context));
>     +}
>     -- 
>     2.25.1
>
> The sha256 hmac common implementation now sounds good.
> Do you have a comparison of performance with the MbedTLS high-level API
> mbedtls_md_hmac()?
> I am wondering if it is worth using this API specially when MbedTLS is 
> enabled,
> since it significantly simplifies the implementation.
>
I have done some test, and the legacy implementation is the fastest.
To do my test, I have run 1 000 000 times the unit test for hmac.
here the result:
common + legacy => 7 seconds
common + mbedtls => 17 seconds
mbedtls => 17 seconds

I have kept common + mbedtls for the v5.
But I may use a pure mbedtls if you prefer.


> Regards,
> Raymond


Regards,

Philippe
