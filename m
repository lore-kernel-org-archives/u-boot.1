Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0F3606A889
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 18:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=yrYEmqsD;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=JsCURKdU
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AF669607F5;
	Mon, 16 Nov 2026 18:00:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sfOmKqj6ZIKz; Mon, 16 Nov 2026 18:00:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org AFD4B607B2
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794852049;
	b=WlewnCgMB2OArn76PiMAeh/jiy6dr3l0KfdA+ptuA1L19u2OVUSgrvbXuNz1aQnKgJYt
	 wKL32GuSXPcjkuztnvZJNAbxJBccKlftzi9R3vktnTwarTbAvdP0TydvPpFClTjnoCiP0
	 W8qQjVutsILpkLSZ7PnVRhWtHSo97/Yo+dv49eRcZiJDAHGcYF7RXsJA4LazqSRgSIm0+
	 YdS0qT1Ep8p7JiWNm4q4t9ZKv/Z1LEOmSIL7/uz5+GmeSKdvhvxQRfJ7s++2fDE11qvX6
	 ZBdHASFYHyOXkrw8p6hJE59CK+AJDUhZGujPej6fJn6fqS6RnNfvuKb+IO0GxmizghQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794852049;
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
	bh=QpepK0wnS+6sCUZqi+00e8/IsB5perRdVHYZxZtbEKE=;
	b=kdqbjz0dnPP50ubNis3v3etKMzAqDGCiKwB3vL+B053xQ04Xs0D71NH3cIn7TVleyaGL
	 JfMYnGvlsqw/LClWzauzKs0lndrBRMil7Sib56ZZS9IcUL0A3WQZrTvVa2YiTwhdx1vsD
	 GWQ3ZeED1jay3bzwFQAeUIxkziQs9rOkI11yTyICwFYgZRkEjIjAtguY+1e1P8Tr7dEcK
	 HhcF2AjtVfxVz/XmJxxXY2Nvgo7gfC88iWqO7XCt6DQ85ZLn7rpOQp77WlvZTAVtUk4TF
	 5iG2gufCic5Bn3Xb197/R/1brOc5PYOd/0YTLyez8AyzOmrBRGhtTPTV3UVA1LlLEEw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794852049;
	bh=QpepK0wnS+6sCUZqi+00e8/IsB5perRdVHYZxZtbEKE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yrYEmqsDwpwwY8zhvZbnwJFy2NaGynJ9pipjg6s0Yp8UlkM1lCNnnwo13I4rCGxk3
	 BgMfcEy2q7NHCdUmzsTWCxFkxM8nEHK4BVpB7PreKZksj4ZeeTV/lbRbUU5xmsIh+h
	 lIPPiSkVN4+t132dNO5So0InNwqX7wF3Z3jRERMBqeBHuXASgbpd7t2Bdgsd9Pk0or
	 qP2RuZzc0qLRG96gaZZXl25Al356THqWMQ9OKZ2e7vF9OMmz5JKScpBYXkiaxjvGlc
	 PZrqzSVVAut5r+LbJkCbEBdQxuSBesBsYWe1vK0vGBswFcFqhSfaBeJODL24D8S/fz
	 IfzPwArl7/fFQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id AFD4B607B2;
	Mon, 16 Nov 2026 18:00:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 5F6314DD
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 18:00:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 507BF80F91
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 18:00:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ir0WEm7d3Dek for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 18:00:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1828280E8D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c201::6"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::6;
 helo=am0pr02cu008.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=JsCURKdU
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1828280E8D
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 18:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QpepK0wnS+6sCUZqi+00e8/IsB5perRdVHYZxZtbEKE=;
 b=JsCURKdUEF7kCA7c2Dxhuf2WwTwJ5ObXqoQBYoquvoirNO/xkVxKUOdhKa4n3vWF7YFePwORqiDTPRX0frTI3bBhpkOxpwU03NkD0gmDKJY8Ng2jeWt7NxEUvqpLvPWoRAT5GLAalIdyDvN162ejTSVXmtRkzWeceyunoYOAJA0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by AMBPR04MB632064.eurprd04.prod.outlook.com (2603:10a6:20b:788::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 18:00:42 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0615.009; Mon, 16 Nov 2026
 18:00:42 +0000
Message-ID: <d26a6d3d-9cea-43cb-8b09-ffaf131e3602@cherry.de>
Date: Mon, 16 Nov 2026 19:00:40 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] power: pmic: Constify driver ops
To: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 u-boot@lists.u-boot-project.org
Cc: Casey Connolly <casey.connolly@linaro.org>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 David Lechner <dlechner@baylibre.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Julien Stephan <jstephan@baylibre.com>,
 Kumara Bhimeswararao Matsa <bhimesh.matsa@gmail.com>,
 Linus Walleij <linusw@kernel.org>, Neil Armstrong
 <neil.armstrong@linaro.org>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, Peng Fan
 <peng.fan@nxp.com>, Ryder Lee <ryder.lee@mediatek.com>,
 Stephan Gerhold <stephan@gerhold.net>, Sumit Garg <sumit.garg@kernel.org>,
 Tom Rini <trini@konsulko.com>, Weijie Gao <weijie.gao@mediatek.com>,
 u-boot-qcom@groups.io, uboot-stm32@st-md-mailman.stormreply.com
References: <20261116174138.3488177-1-marek.vasut+renesas@mailbox.org>
 <20261116174138.3488177-3-marek.vasut+renesas@mailbox.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261116174138.3488177-3-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIUP296CA0058.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:337::15) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|AMBPR04MB632064:EE_
X-MS-Office365-Filtering-Correlation-Id: de0b5aa4-8bfb-4340-a0e5-08df440b8790
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|23010399003|366016|22082099003|18002099003|261009223027099003|4143699003|56012099006|11063799006|261028144727099003|261026140227099003|261022105027099003|261021123027099003|10067099003;
X-Microsoft-Antispam-Message-Info: 9IpVTgCmkNJijBBIl7hoxMiCWYIaNtHAoI1KeXtUvEF4X9xInO0Srvlzoq5HHm817FLBJugxjENsl8M+UuUaMedSwPq81PP8Gc1DxVVy3+LhQ2Wk4xjfaDqypKW1MIKOHuCGAiUUI5Apb7VZynslU74vAMa3lE+QIp0l2mpGzbb2qg36Sl9oW//rXSbuhBYKSY70Mueb7sX8sV+4/lohcDn1V9egd3hem8dtMKci/FfDT7VP2StmHk8DO2H9ejwjLLaA6RCtr0ih45fug+GzunVIvGq3QjJGbgKS1njRG44kzUIqr/AJw3vRf3bL0Y29njlhOKkVAgeaiegkuFdadmEa3Onf+/l+4a/xDVANsaf8UigbB1KW3Mo4DuR58ouJ8wZNJOlClwfXbkzHvhqZ1+Y6wPKPBNVAcmYmCSnW3KuKIt5F4Ju4wN2KuAznoRabgOBwdiqesBDP4G91knwpsLRY1fFzY1R7hB6N7S78+j73bl7aw9xp4zwJ0p66YR1XRx+JikV8Mq+hykCEypliKhnn+/EkFzQBPMKiwWdbP5yw7yDIrO/qayk1VPcnB/grEKx9fcS7K4e/kqab8bPZheJOVX5HSXrf2JnkWvRvz1TORCRnvx5oD9KMlmA3PlKjxcOZid+o6PEW4TspyBK4mBdtnSPRZ3sMMnnr5WxCQco=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(366016)(22082099003)(18002099003)(261009223027099003)(4143699003)(56012099006)(11063799006)(261028144727099003)(261026140227099003)(261022105027099003)(261021123027099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a0M4VC9aRnc3MTRvdk9CQjQ5VWRSTE5mVzRQVjFOazRHS1IvN2x0eTVxR3pF?=
 =?utf-8?B?VDFob3B2RUltUm96RGFpSzJSa1JLVmZ5STdGZElwNmRUZ2JjaWdCalBiNVVm?=
 =?utf-8?B?L0lWbGNWK2RJeTRjQXdOTUtjQ2tzTHFoaG50QS9EWkR1UjdBdEZGbFZFSzkr?=
 =?utf-8?B?L1l2RURuc3UzWFErRDdXeFZWa2hlR3A2U2lKSkxaSnZmMUNtWEtNdGhDcTMv?=
 =?utf-8?B?TXVUN1BKR3BGSzVDUGljRnpGYU1OTTdvamg2Z3JRSnF2QWNBTkZjU2lUZkMz?=
 =?utf-8?B?K0RzV0NjamE3OEVOYXNBS25DVkNjYWxrUFEwMzFmckZhenRUTUNwcDcrZmNM?=
 =?utf-8?B?bUtKTzg3K3lLdEl3R2lBTlVGRXlqYUFVUW91RUJ5ZXRaWTk0NEtScU15eFJY?=
 =?utf-8?B?aTg3a1B0K3JRd2xldGZWTWNzdjdlelg4T2x0ZDNObUpyLzg3a3hDaDRlT1Zj?=
 =?utf-8?B?QVdQdHN6dnZ3MjRqWDZOdHZnczVabzdtMFVxSlk3bklkcVM1OXJla25EM0xU?=
 =?utf-8?B?Ri9WQWFwUm1oMXVOanF1SktqbTdxVFVnd2FIbHhMWUV5Zlk2WlhwdFhhWm13?=
 =?utf-8?B?b0lBcFE5UVZFbmdwUnVpTXpkOWhFWUFvNnZDN1k1YWR5QVFzcVBVZFlZQ1VD?=
 =?utf-8?B?V2oxaHZFckVaak9zMTFvUVZ4Um8wMXhtUkhtT0RLaU9KTGNZOVVEL29pRDVK?=
 =?utf-8?B?N0hhdy9yaktWbnVWczNibzM0OVcra1RSSThpOU4rb1JIZjN5N0w3bE9RcVhB?=
 =?utf-8?B?MnZpMGxVSjRZbE0wQ3p3UWEwQnFwSjZIaDlXcE1vQmtRdGRKQzN2blJlOUs2?=
 =?utf-8?B?WGo5L0NHSVdXUENYdk9SSE04dTgzSWU4UW9qbmUvNVVySGxQK0pwanBTcHdk?=
 =?utf-8?B?U2VoTytmUWU5Nzk5amtvUHU4KzA4Szd0NXlRdVdIcm5XSUwxUThINVR0R0lB?=
 =?utf-8?B?eFF6dnZMM3JKZXB4OXVxcmtKZ1BFYUJDenJJN0ZJb21DQ0lUSy8wVGYyV0tB?=
 =?utf-8?B?THl1b1ZVL2hmSU5zVVBnUm1CaFZqOTZ1Rk1oVm9yYTVRak44clZGdVpJbVNI?=
 =?utf-8?B?TmJRUWswK2JPbWg1cWJUdEZQRlZ4bGVVSjh6QzQ0UFZrT2MxMDhrWVl1VUow?=
 =?utf-8?B?aCtycEcrcGFEanJDN1NJalR0dUNCUmU1dmcrMm5la21iYisvaklUaWQzYmtW?=
 =?utf-8?B?aXFJZVhqU2FiRko0UnJaNmhudmNVWUltRXFVSStPZlBETEZrVjVwUzdzSkpr?=
 =?utf-8?B?VXY1WWRtb2xzM1NsSVdGaTdrTThVL1AyZ2NyRGtWNTl4dDVHRUhJYXppNnlB?=
 =?utf-8?B?QTBWTzZqUlY4aGhtUHRwbERSZ084NDF0alFTeVhHbUJPb1NQa0RFWWhuRlBi?=
 =?utf-8?B?a0VKSW41blBaMUpuVE50Y3B4amtLV0d2K1o0VGFVdjg5cnU5cld3TnorNUNH?=
 =?utf-8?B?VTRlYitGdEFiL2cyMGltUWF1OFI5MnNONVgrQm11RjZHOXpLRlhmY1VRdktE?=
 =?utf-8?B?WEdQd2xKdlJSdzdFTWlmQmRySkVPMml5Yk9zRWF6eUk1WjFnRkZ0SnBIWGZj?=
 =?utf-8?B?a09jWFE2WWtZM3lQRVM3Q1hVZkdhL29WYmJReGI3dDJkWDBBeEVyc01WdGRM?=
 =?utf-8?B?WVRJVWozZUI4cXlPZS85MVZNWk1SbmxYRnVJMk1DSkwzK2F3WGdrYWNKd1lk?=
 =?utf-8?B?TEZYaTlxaTdYYjNwTHNOZlJ3d09RemtybTRtWCsvRHZFV3hVS1lhK05OMndY?=
 =?utf-8?B?ck83NVByV0xOWXpBL2hnWXhYZ0x6RFl6SG1VZnVXWmhHaUsxVWpZV202MHAw?=
 =?utf-8?B?QkFJRk9TUUhwYy9DZWJpbXNlQjVUS3c0MnVQSExKTUtBRzBJM1NaMmxDMGFj?=
 =?utf-8?B?ZVh1c3NwMDNvblZUeGJ4eG0yOHFUbGxwZTE3U3lIWDlxTS9KTGVib3Ntc3Rn?=
 =?utf-8?B?OVcvRVNvYXhUbzhNbkk3cVVGSDFhM0VVd0ZDK0JsU21kZHhINUpOOWl5Tmd6?=
 =?utf-8?B?Qm9tZWs0SGluYmI0WlkrcWpLTm1Mbi9saEpPVGh0YXBOQngwdHdicjZIeENv?=
 =?utf-8?B?VHJVakRxc0VoRk5JZUZsNHQzMkdWaGJwTWU4TEd5Ym5EOTB3cVJkWlQyQTJO?=
 =?utf-8?B?TUZsRDJVemNXTkUyYjBqdVJmT2dQZGFGYmhFWktCQXVBeFNaelVmVkNHeE0w?=
 =?utf-8?B?V25sN0xwU3NZUEIrQlBpMms2cWFiRzJtRU5hd1hCc0JHRWUwMzBSVDd3ZEVN?=
 =?utf-8?B?NlpuZ3FydkRLelhTd1NkVHo3TG5IVHlnMFR5NHRxSlpPTlYxTXBubjdrczI1?=
 =?utf-8?B?My90dS9heEtxaEcwTGVsM1hRZ0d1R05LZzhpdlAvSHBsQVVKT0RoQT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: de0b5aa4-8bfb-4340-a0e5-08df440b8790
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 18:00:42.1043 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X83mV3spUc6UUd91CqGwEogbFc49Ef57zMkBAquqRPRRCmvB00kjJdBeS+PdjGY/P2ksNeupXo3OGFKbvGabfYv2apyptd23Vr3rNMbcjCI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR04MB632064
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Marek,

On 11/16/26 6:41 PM, Marek Vasut wrote:
> Set the ops structure as static const. The structure is not accessible
> from outside of this driver and is not going to be modified at runtime.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Casey Connolly <casey.connolly@linaro.org>
> Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>
> Cc: David Lechner <dlechner@baylibre.com>
> Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
> Cc: Igor Belwon <igor.belwon@mentallysanemainliners.org>
> Cc: Jaehoon Chung <jh80.chung@samsung.com>
> Cc: Julien Stephan <jstephan@baylibre.com>
> Cc: Kumara Bhimeswararao Matsa <bhimesh.matsa@gmail.com>
> Cc: Linus Walleij <linusw@kernel.org>
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Cc: Peng Fan <peng.fan@nxp.com>
> Cc: Quentin Schulz <u-boot@0leil.net>
> Cc: Ryder Lee <ryder.lee@mediatek.com>
> Cc: Stephan Gerhold <stephan@gerhold.net>
> Cc: Sumit Garg <sumit.garg@kernel.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Weijie Gao <weijie.gao@mediatek.com>
> Cc: u-boot-qcom@groups.io
> Cc: u-boot@lists.u-boot-project.org
> Cc: uboot-stm32@st-md-mailman.stormreply.com
> ---
>   drivers/power/pmic/ab8500.c           | 2 +-
>   drivers/power/pmic/act8846.c          | 2 +-
>   drivers/power/pmic/as3722.c           | 2 +-
>   drivers/power/pmic/axp.c              | 4 ++--
>   drivers/power/pmic/bd71837.c          | 2 +-
>   drivers/power/pmic/cpcap.c            | 2 +-
>   drivers/power/pmic/da9063.c           | 2 +-
>   drivers/power/pmic/fan53555.c         | 2 +-
>   drivers/power/pmic/lp873x.c           | 2 +-
>   drivers/power/pmic/lp87565.c          | 2 +-
>   drivers/power/pmic/max77663.c         | 2 +-
>   drivers/power/pmic/max77686.c         | 2 +-
>   drivers/power/pmic/max8907.c          | 2 +-
>   drivers/power/pmic/max8997.c          | 2 +-
>   drivers/power/pmic/max8998.c          | 2 +-
>   drivers/power/pmic/mc34708.c          | 2 +-
>   drivers/power/pmic/mp5416.c           | 2 +-
>   drivers/power/pmic/mtk-pwrap.c        | 2 +-
>   drivers/power/pmic/palmas.c           | 2 +-
>   drivers/power/pmic/pca9450.c          | 4 ++--
>   drivers/power/pmic/pfuze100.c         | 2 +-
>   drivers/power/pmic/pmic_qcom.c        | 2 +-
>   drivers/power/pmic/pmic_tps65217.c    | 2 +-
>   drivers/power/pmic/pmic_tps65910_dm.c | 2 +-
>   drivers/power/pmic/raa215300.c        | 2 +-
>   drivers/power/pmic/rk8xx.c            | 4 ++--

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de> # rk8xx

Thanks!
Quentin
