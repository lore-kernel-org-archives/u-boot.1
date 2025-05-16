Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12B74C3ABC9
	for <u-boot@archiver.kernel.org>; Fri, 16 May 2025 09:41:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6327080107;
	Fri, 16 May 2025 11:41:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="ZBs2oUCP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3928C80AE0; Fri, 16 May 2025 11:41:01 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20731.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::731])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD11F80079
 for <u-boot@lists.denx.de>; Fri, 16 May 2025 11:40:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wXIDY+Poj9NDEC77un0WqXIrJBHJZgDk6aQwlDLFKz6DwGaudXexzuj8wkLcMfY5xjOF+avFvQVaU2kfY5FHRL6osN39ig2p/kLLHShOQrb6UueYHf+u4SZ8qI/YlL+zG5p9qDFVyDmwsIhILlDFjg3WtXxDatCbuESU3oN+AeJpeiNh2p2dT940A5PkNUeOt26KPmr24qV6U5I6lImiCbFu7Wl9RyfodK/69CK54IBwZz+LrXmshz0EGu3LdhuRCElmxPBMJjSasrBISoob0MkCK1Ck0UwwuUOaPlfswhBVpXJlhYVYL0iDGMNkS828HTP15xZZuYsjXzrLaHEUIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KpM3IERpKFhhX4Jz3AHBSh+gF1d491BhN7aYQdSbaEM=;
 b=Wpj1l7GTtxc4oI0cgrIgE8298JQQFA2XWeLJ6PqgBrOyW8H4pTPC1smSjx5d5dowTNdeTQ7JV1GjxEs9ZPB2VnrkctJ6Hu9TdIAVF85DwD6RojlKUHQqsmwqg/S8UOZyKa81Zgy07UvTE/+krRK5hpWI+WJo1b7zFqUlGsVXa58E5uTDBgpfZ18j1U9YQr+kKAfNziiVIst0EPI4o/nlSX8PZ6D0APhZyp8GPB4YB3pcneNoeQ0acXLHIiEeLWwgO/kQLo1Cvpt3Izv0j2BDd0itcinZ6BMstUsipfp/PcwMYmplsg4HOc/45kmLxp5er3uPj6xymzNdn1jqEOEwXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KpM3IERpKFhhX4Jz3AHBSh+gF1d491BhN7aYQdSbaEM=;
 b=ZBs2oUCPAtV9N3mZF3dhouSM/JqwyIQWHRUwJ0R8S5kf95qhc1/PJDlS+DHymGqkNSnCgRw9BYZzxUiAWL9EHLSnZVZRctFcMKjTy7mDJZNKSRpIHUJB/kmmeEzf8bZXQTYOiCcDcu6CawGQ7NDS6403r46zur47PFwpHMSFd2Y1d4IbQrHBw1yL7cgNlDO7mQhDJgZg7xZcX+QtZkiqYm4DZQepLqFZaikV0yGp5anYP3Dg86aYqxdpFFtCQgYL+WkQk4v+FNERkQlbZAdVCdgUxhSz34hO/VHPOma3HNKO5pop21WiaX92QFpyz53Izqn56UAstEOx5LQmPDtKgg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:4b3::21)
 by PR3P195MB0864.EURP195.PROD.OUTLOOK.COM (2603:10a6:102:a5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.32; Fri, 16 May
 2025 09:40:57 +0000
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::369c:a760:5bf9:8d4a]) by AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::369c:a760:5bf9:8d4a%4]) with mapi id 15.20.8722.027; Fri, 16 May 2025
 09:40:56 +0000
Message-ID: <a8ad0c0b-f4e1-4c2d-adfb-86955df51f41@phytec.de>
Date: Fri, 16 May 2025 12:40:54 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] arm: dts: k3-am62a7-phycore-r5*: Remove clocks from
 main_timer0
To: Manorit Chawdhry <m-chawdhry@ti.com>, Tom Rini <trini@konsulko.com>,
 Nishanth Menon <nm@ti.com>, Robert Nelson <robertcnelson@gmail.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Garrett Giordano <ggiordano@phytec.com>
Cc: u-boot@lists.denx.de, Vishal Mahaveer <vishalm@ti.com>,
 Chandru Dhavamani <chandru@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Udit Kumar <u-kumar1@ti.com>, Neha Malcom Francis <n-francis@ti.com>
References: <20250515-b4-upstream-k3-pll-miss-v1-0-e38b89f027b8@ti.com>
 <20250515-b4-upstream-k3-pll-miss-v1-4-e38b89f027b8@ti.com>
Content-Language: en-US
From: Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <20250515-b4-upstream-k3-pll-miss-v1-4-e38b89f027b8@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR03CA0052.eurprd03.prod.outlook.com
 (2603:10a6:803:50::23) To AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:4b3::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4P195MB1456:EE_|PR3P195MB0864:EE_
X-MS-Office365-Filtering-Correlation-Id: d78e4172-f2a5-426a-7977-08dd945dc22f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MjR0Vk43RVV5YW1HZHdvNUtSMFFkNER1ZlBmdlVxRGtzM3NEWDFmQ3lNUVQ0?=
 =?utf-8?B?cHRucHZxMUw3QW5JTWR5RUtyNWt1MWJrQ3ZmeGh0Q0hBb1dTV2h6ZVB2YUJo?=
 =?utf-8?B?Q2FQR1lHbVVyRXdxVHJ0RW01ayttTlQ5aXoxaUt3bWhGdGtrcHZEdjRkVHF2?=
 =?utf-8?B?alpVcXBIQUs4VHBDRGdhaGMyUWNYcjlYa0VsSmtzK29YRzBCT0xxQnhsZC9o?=
 =?utf-8?B?SmxpTUFKL3VzY1U4Zkw1cTN0S3ZOSWhNdnhiQjhRUHpnWHlXd0hxNnBaWUxN?=
 =?utf-8?B?VjRHaHBqQ2xnOFBtK1M2SWRDcnRYbTFhZERtbGh6ZUxzaFY5SmlEZjdRSHRJ?=
 =?utf-8?B?dm4yZFlNZHdDWk04LzByTm1kbU9CZUVZTE1reHZCbEZSWm1PR2czc1JRYkVC?=
 =?utf-8?B?U0JTeUNFQlFod0ova3dESVdIa2N5amcwOWJDTWw5NmhWYmJQZFBOTWpIU3lF?=
 =?utf-8?B?azBkRDc2TWk5dGR2S1BXN28zWlVZcys0YVF0SHU1aSs4TVVOWC95NEtQL2No?=
 =?utf-8?B?L3pCMFd4U3pKTlQvZmlRWU1VNGVzRExFci96N2NuNUNGZ0dLVGhOZkhFRFdh?=
 =?utf-8?B?aFhCSGd0d1RmNDVtVmtzQlZNejd4bGUrdk5GSEcrWExUZE9PRmljTUs1L29G?=
 =?utf-8?B?NTVOOHhiZHZ1QUdYN3lEY000dWRPditPRlZKSXJZckNleHJsZzBBL2JtVmNy?=
 =?utf-8?B?TW1oL0lkTk50dUoxRElhVk9OaWlnK0dMMlNpZXdFS3JNdk9FenpycnZ5d25o?=
 =?utf-8?B?NXJPOVU5Z3NGc3piUmZybjVRZ1dxYjA1dkdoN2hVUUhHK2RHaGI3UnpnMXNi?=
 =?utf-8?B?NkkzNDFuVm9kdkdsNDB2SmJNYUpKemNXNWRRZGVVVFRDTjMxMUo0N0JMSDB3?=
 =?utf-8?B?a1dsSGZ1MjAxZVptYXdjZ250c2RTdE5KTHR2U3ZtUGxCY2IyQnJCc3cyU0dy?=
 =?utf-8?B?RU9ITWZ1ODlRY05CTW9ZODgyWU9GQkdiYXVHb1lETTlxTzJ0WHRhYkptMS8y?=
 =?utf-8?B?cFpYOWMzSG95ZjEzb0VpVHEvR0tQcW9vWU12ck1YRzErKzZzaXovemxkUnpJ?=
 =?utf-8?B?TFdiV2plUUh0UkFTKyt5MlRNbHliUjlmZWdXYjZiZXlaTm9NdHp3Z3BIK042?=
 =?utf-8?B?Nlh2U1RzTFFlZGM4ZTJWbjhab21yVVVka0xZRCtyK1VnaDMyVFcvMWsraEhx?=
 =?utf-8?B?RmVPK3o1b2dGMnQ3OWJjL3NkTUpJeTdpRTVYMlFDbnlsVWJaQVVLOFduY1pl?=
 =?utf-8?B?YWFhUWFqTDRsaW04WEN6R2tNakFzZy9QWTY3cllYTHE4MjZKeThxTldNSUh1?=
 =?utf-8?B?M1lLMlRSRkdzdEYvQVRtUHpMWlN6cEdwMitrOVc2bkN3akZQd1h5aGVJc2RK?=
 =?utf-8?B?RDhUamNLT3pGYnE5Z0FCalk5cktWbnorNGVNNC9MQnNmWVluKytGRkdRNGlT?=
 =?utf-8?B?Vk85WDVIMEhrcUFESnpESk55eHA5UFZ6aGtsOGdHdEdNQzBQRmRQYmlmVktp?=
 =?utf-8?B?ZTc1WGxoOTFpVWx2L1JqL0wzSFowN3Fwc1J5UGJ3UzU4Z0Vya0thZEtGNmVn?=
 =?utf-8?B?dTNHeHpQOTVCbjRIOHRwVGY2eUxqOFh5YmlQSjQvQWVTRTVuSFVUQ3FocVdN?=
 =?utf-8?B?QTJIaXVSL1IxM09jN1BGKzdvYnNCMEZjY25FZzRCN2MwcTlHTmtnNStRaWxB?=
 =?utf-8?B?WHBaVzZqNmE4WElrNWJkeUwxSCtMQktTdUVHeUFEZFJ2TlFtQ3dRSXJqVEhh?=
 =?utf-8?B?RXhTczJXazQzalVjNHpWNzlSbWMyWEhMRTk2T0JPd05CV2htbHF6YkFsNFl4?=
 =?utf-8?B?cHg2QmtpZEZTdGJBNGU4Y05wNnZXTVJoNDhBNjBKU2UxUTA4QXV0WktiN1Fh?=
 =?utf-8?B?NnV5Y2JqWHByY2s5NXdjSit6eDErK0oxUVhjY1QwVzEwWFA0Y3RaS0w3MVVS?=
 =?utf-8?Q?Xt9igbAI6ec=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4P195MB1456.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NytVK0lNK0dGWWx5YXQ1TGxuQkw3TCsvMFdLRXpJK2NaM2F0dHIvMlhmd1pV?=
 =?utf-8?B?cVM5Z2QrVkxOaFhWbFBNOUNIZ2lUZ1VURm5MUGlPVFJkQngrTU83WEdiNS9S?=
 =?utf-8?B?Tk96SzlKTktQRzJubzJWSUlhemUydWJ5YmMyS3VQbXJ0d3laUEp5dDhJS1Fp?=
 =?utf-8?B?OE50T1BIODlqUWNaVzFRL3lGbUN0MWlQTngwRlZsZUdpQVJtR0R6dTdNUkts?=
 =?utf-8?B?UThsMDhOeDBROU1EOUtIdVhDVHIxM0FGc0RWRHJCK3JYZjN3N3g4aWZFZmJr?=
 =?utf-8?B?SEVYendaODdLZFd0d3ZqUjlKbk5laE1DSkRucHUxWllaeVQ0Mlc3VFozSW8w?=
 =?utf-8?B?YzlndnprV1ZYL0pjZ2FHTkxzMXoyOUFhMkpkVEZyMXBPOWhBYTU4SFdDOVF2?=
 =?utf-8?B?c01DUFJNdERaR0RwaVFuWjN1UWRjZkFjVWFDSHFGMS85TWxRZjlCeUJqdFQr?=
 =?utf-8?B?OStUaFFLREpSSkM2WFlzSTZTTWY3T0lOVmQyd2tpNGs1Y05pWGdNMkFydy9w?=
 =?utf-8?B?cnF3WFAvWHpsbS9sa2ZpcGFTbVl2ZFpqc3l4S0RUSTFCSVYySXorc3RKdS92?=
 =?utf-8?B?cUpjVnlmeTd2SHUrcnFNaTBoUGoyd3ZRWGpyRzFvVjRYSWp1T0V6NjBIcGRz?=
 =?utf-8?B?Nldaclh1Y0dNYVpHVC9TOGhWckdWL1NtcWV2aEtMSnVNVUxyZUhJQTJNQVo1?=
 =?utf-8?B?aXhwMlBPMEZ3ZE4yZWNxV0tzS01sR0xNbkNuVW9wTzNidll0clE5aHhYUnN2?=
 =?utf-8?B?VHFiVG9Id0dnODIrK0NzOVdXbTA1empjdXJNWWEwLzBROEFFWEtJRy8wVGcv?=
 =?utf-8?B?bGFkaEU3OTVKK3hOYzg2MXc4aW5IK2NlbW5aYnJ4MnVub1FoWEVHRGVtbkVW?=
 =?utf-8?B?VjQzSmp1Y0hHaGhVY3AvOUdRc2dxKzhOTFQreitEY2N6ekkzSlZNV0YwUURs?=
 =?utf-8?B?eVM4Ry9NSVFxME8wZVhUdXp3TnJWNkdBeW9kY3Nlc2l2a2s4ZktVTFV2OWJ3?=
 =?utf-8?B?ejhVWEVMMUZwT0U0eDRXQ0FjWThuWlhDVmZvUEhUaWJmdytkU0VmcldyS21N?=
 =?utf-8?B?cDAzOUZ0OFphbGhhR3JmTEdGN3J6SkcxaTF4UjlPdGZIMTRsYmR0WDN6ZWRO?=
 =?utf-8?B?K0Yyd0ZhbVF1WWkvN2VmbEozTWozUjVYV1ArcnFoMzBQTzhiUDlQdzcxOXk1?=
 =?utf-8?B?VGdINTRFL3FGTU5pR3orREhEVWZhbU5iNVRwVzJYcFJUYUozeTViTHM2aGVZ?=
 =?utf-8?B?VER2ZDFSdWFQWWlxaU1jazNhTS92VG1uLzVITlNOWHVrVUlUajFmQ2p1WmNE?=
 =?utf-8?B?UDA2UUpxenZ4QjlIMGFBZUo2VHpHV2hGTmFudExudkE5N0dxcUFZcGFHY29n?=
 =?utf-8?B?R3YwRVVmVHh3RkZJdWxaQ255eXg0Y0pWTVNKbmc0K09HNzhydjBqMTFIVXVt?=
 =?utf-8?B?VWo3bDRMQnBQK3VnbE1pMnNQV3hpWklHQXM5V0gvRnBac1ZxYS9ONFJzaWo2?=
 =?utf-8?B?cjZlcFBHd3pPYU9FVS9zRFM1c0ppaGJNOXRLKzVTV2xubTBWSndmU3JQWlNn?=
 =?utf-8?B?aGQxRGNPVnN1Wnk0dEU1NmVXZkNneEZOajRXWlZsMUcrM01mZ1pIeGtERy9X?=
 =?utf-8?B?UjNtdGxaWk94UkszUlhmNXZLYUF3NlpHR1ZMcW1qd3NZYWIvQ2ZNOHNMN1g1?=
 =?utf-8?B?NDZJWnJEOGpqYTRxMklmVEVtN2o1U1VOZUVFNDEzVzhQS1ZFUHczVGJYY2Vw?=
 =?utf-8?B?bDZmU21ReGlZaEtkcXhHb3pXdFBjWlNtc3VDTVlpa2dXRVk2T21tdUYwY0Ev?=
 =?utf-8?B?N1ZrRVVWUjNMdlpYK3RCTzJJanRMTHJBMHhMMXAzcHVpV1lhODVyam85Q1pN?=
 =?utf-8?B?ODN3bElEeGs1Tnl5MGttN0ZPRTBZTVhTeFhjTk5DWWdFOER2enVGSlVJTEhB?=
 =?utf-8?B?RGRJWVhmaEhTeGh0a2JIbnpQUmJLZFZEek5wbUFGTDNPMENhcHU0amJQNTRj?=
 =?utf-8?B?QnowNE5BaDdkN1dHUGh6eG9nVjIwbXdxTENtQ3NVMTVRaXhRR2craE1xdllw?=
 =?utf-8?B?NUIwdVBKcnpFeWE0cStmeWxlYXZGUnFPOGNMN3JvQVU0L2RiMkZzZDFUbkxp?=
 =?utf-8?Q?X3TRoR10gydSzB867cA3rsSlf?=
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-Network-Message-Id: d78e4172-f2a5-426a-7977-08dd945dc22f
X-MS-Exchange-CrossTenant-AuthSource: AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 09:40:56.8644 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JfnpzawqENbBwFezAUN4kNxh/846rlY4ALOlj7fZaLvtLW0VeXBDAak7SPbxUifxgYRAXmLLvxYVdU9lH4mQIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P195MB0864
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

Am 15.05.25 um 14:38 schrieb Manorit Chawdhry:
> The commit 79d91e77f4c2 ("clk: ti: clk-k3-pll: Add additional robustness
> steps to the PLL sequence") introduced a change which requires the
> main_timer0 to not rely on it's own clocks which anyways was wrong.
> 
> Fix it by removing the clock dependency for it, also while at it, move
> it from u-boot.dtsi to R5 as that is the only entity that should require
> it as DM isn't up.
> 
> Fixes: 5d1aac358f3c ("arm: dts: k3-*-r5: Remove clocks from mcu_timer0")
> Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>

Acked-by: Wadim Egorov <w.egorov@phytec.de>

> ---
>   arch/arm/dts/k3-am62a7-phyboard-lyra-rdk-u-boot.dtsi | 5 -----
>   arch/arm/dts/k3-am62a7-r5-phycore-som-2gb.dts        | 9 +++++++++
>   2 files changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/dts/k3-am62a7-phyboard-lyra-rdk-u-boot.dtsi b/arch/arm/dts/k3-am62a7-phyboard-lyra-rdk-u-boot.dtsi
> index f922f4b4781d9a3aed543ba5c4ebfb3ab879476a..73255a18e9b1526eda50e43786ccc3e122d54060 100644
> --- a/arch/arm/dts/k3-am62a7-phyboard-lyra-rdk-u-boot.dtsi
> +++ b/arch/arm/dts/k3-am62a7-phyboard-lyra-rdk-u-boot.dtsi
> @@ -13,7 +13,6 @@
>   / {
>   	chosen {
>   		stdout-path = "serial2:115200n8";
> -		tick-timer = &main_timer0;
>   	};
>   
>   	aliases {
> @@ -157,10 +156,6 @@
>   	bootph-all;
>   };
>   
> -&main_timer0 {
> -	bootph-all;
> -};
> -
>   &main_uart0 {
>   	bootph-all;
>   };
> diff --git a/arch/arm/dts/k3-am62a7-r5-phycore-som-2gb.dts b/arch/arm/dts/k3-am62a7-r5-phycore-som-2gb.dts
> index 0060c7a69349a31e142c40806c372ed2fccdf7ea..63b7864a46969f83571269e3db7bf7670228362b 100644
> --- a/arch/arm/dts/k3-am62a7-r5-phycore-som-2gb.dts
> +++ b/arch/arm/dts/k3-am62a7-r5-phycore-som-2gb.dts
> @@ -88,6 +88,15 @@
>   	ti,secure-host;
>   };
>   
> +&main_timer0 {
> +	/delete-property/ clocks;
> +	/delete-property/ clocks-names;
> +	/delete-property/ assigned-clocks;
> +	/delete-property/ assigned-clock-parents;
> +	clock-frequency = <25000000>;
> +	bootph-pre-ram;
> +};
> +
>   &main_bcdma {
>   	ti,sci = <&dm_tifs>;
>   };
> 

