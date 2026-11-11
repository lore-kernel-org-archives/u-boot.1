Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7602606A8BB
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 16:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=nSK09DgJ;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=ET7VLkNX
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BDE4D81338;
	Wed, 11 Nov 2026 16:29:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4CMj6-Mh5TBL; Wed, 11 Nov 2026 16:29:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 00B45812B3
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794414568;
	b=J7wZ9eHT7/rnydb3qBt6lug4D4BumNmKvC9IyDU7ysNp3TBaJZMhlc9wmODk/zaP7uJ1
	 7YJdIHMKzgO9+OaThww/PfiJgs2izYqFiOe5Ai7CM26GvLTujHseXq2dKJUV1cmKxxYW+
	 DyhN4glxbIqHAnfmTm9SCb4ZSShoY3jJl7meDFrtTROkK6NKq3t/Rnz8+Zg6q3Mv7Jp9L
	 MZqOLEceH2zBt28o0iAtvfXXfD48cPrpDmsmT/ja3CWaECNdZezTAQf1vX9Dbux0tOPqp
	 s5K6WyN22CNHiv9LI7pYbJx14Xi31+T87fpT7TJMOqrXRhCadyv3CP3eZxCrBvz0joQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794414568;
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
	bh=+PCFI0mjATnYxIkHTLl8GOswQ4XSE0QDKv4O4TITl+4=;
	b=lxLArOY1RhneWiRLWXbgKYAC4LezOIEj4dQ/VQ69F86raNZsz4JETRcsrC8qWOFAsdl3
	 I/lYMTmne7U/1ahcg4SLfK4Ld2fcdZxhyJHCw3HkshjJU8u4XW/755KOvE+XHr08H9ic/
	 Q00ZGNg12+FMczFMM3b8DyKqIB/FER+nPftfhZDwcrHapwiZdJkFiM4zkhdC1ZPKC1jyi
	 Zt9fbUxeEVwbGBkWep2eCOocFunSXy1TB0uylSwN67U3NCR7oZbf/IeymhnDDp9q1oyS6
	 wJ22ulkHs55062X1VLyoKBDN3myDqX/6MWM4nCzn2aC4W7yufQQP+2Tz9asteARZq8w==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=cherry.de;
	dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=ET7VLkNX;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794414568;
	bh=+PCFI0mjATnYxIkHTLl8GOswQ4XSE0QDKv4O4TITl+4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nSK09DgJlMfURno/+AYwHhEjHo9uJUT/zCgm4h9QLiJTLVyWFQoEtvzUA4NPKxoge
	 0TfjvcYlxskF4V/+BkKMt3Sx/v2jMQJZqfxoMejjZgcLazyeWMozbMw4wvJzivXIum
	 VBAoASRl3xjc4GWpKhvshIE+086btjOreWe0p9G5YfpdXH7ljAIzJ2XZ9Ss+jFOvVx
	 8/H7S4UOePoz1oCuth6LkTGNsM7bZJSb1HiPIJ7e7mN3QeI2TX1PNBGrOiOS/MuwiR
	 yxOEnbVTpQHFwPaeZy2noSVLObTLGeP4QcadTPEeVq/rajE5goId5EIMhvzP8A3fgG
	 hKymcJCEQVKbw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 00B45812B3;
	Wed, 11 Nov 2026 16:29:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4F293E09
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 16:29:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 333C8812B3
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 16:29:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WyZph_1ps0rw for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 16:29:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 18DD18122F
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::3;
 helo=du2pr03cu002.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=ET7VLkNX
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 18DD18122F
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 16:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+PCFI0mjATnYxIkHTLl8GOswQ4XSE0QDKv4O4TITl+4=;
 b=ET7VLkNXscwWsH4Pk9XCArdq9ab0Wq55xZ9rrKHYAiKdMzCIWJcJyPjzwXHltHs3PimQGdpXthQ3CeFtHNYWGbbsnWq8XtH7rVXTyRFN2obsZIPdcg6yweRV+I4hZ4FphjqS1mPoXmSK1WUhMdWFrP7kCNcqzCCOVIVLRzHkZbg=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by AM9PR04MB8506.eurprd04.prod.outlook.com (2603:10a6:20b:431::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 11 Nov
 2026 16:29:19 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 16:29:19 +0000
Message-ID: <753f4bfd-c02e-49eb-88b2-c26efd978828@cherry.de>
Date: Wed, 11 Nov 2026 17:29:18 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/12] test: Pass location of built tools to binman
 code coverage test
To: Andrew Goodbody <andrew.goodbody@linaro.org>,
 u-boot@lists.u-boot-project.org, Kory Maincent <kory.maincent@bootlin.com>,
 Linus Walleij <linusw@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>, Tom Rini
 <trini@konsulko.com>, Anshul Dalal <anshuld@ti.com>,
 Alexey Charkov <alchark@flipper.net>, Francesco Valla <francesco@valla.it>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Carlo Caione <ccaione@baylibre.com>, Yao Zi <me@ziyao.cc>,
 Michal Simek <michal.simek@amd.com>
References: <20261110-qcheck_fix-v2-0-1c76e0b68f29@linaro.org>
 <20261110-qcheck_fix-v2-9-1c76e0b68f29@linaro.org>
 <4d2d71bf-0c53-45b0-bf75-60473d6274be@cherry.de>
 <0fd9744f-e119-4ea5-9026-f86673ffd0d5@linaro.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <0fd9744f-e119-4ea5-9026-f86673ffd0d5@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0023.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c9::9) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|AM9PR04MB8506:EE_
X-MS-Office365-Filtering-Correlation-Id: 95c659b9-0bab-4af1-6b8b-08df4010ef98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|23010399003|366016|18002099003|10067099003|6133799003|22082099003|261021121427099003|11063799006|261102130727099003|5023799004|261021123027099003|261026121527099003|4143699003|261022105027099003|261102123227099003|261026140227099003|261028144727099003|56012099006;
X-Microsoft-Antispam-Message-Info: oaKFIDTAFlerXhmWZiBiOj3w267md3peU1pQRB09tJQ29FpanNqOvsWx4IqBy0t+LwwDSQoPvKr0qHdNPXXQXv5udxdWQMbCWTanAIHo5pQvRRWquLgR3eEdhD8uvjirjQZlARMtGhH+tw7TITp+W/Ass0Bqqe0kgg8auo0u6h8XI41Z4PS8cVAC/yiKnqo+lHFYdgAHsn2fZVXdHYQ3947R/Y7b4iEbJcS+uyhkpkC0UQYXiKGZq/emVjjDetABljSArmAwrd19uOX4kAaBcYBVM6cx3bzTM8laTW8Em6kjADNuFGYx35IB0cw7rOIJaQnGJaC+BWJbNgAKPkHTLUYuJPAs62vxH2LRDdw25haR4/NnyexvnIf6DsbsNgn3DZOydVCZDLNs8qZyF2yLKto/nbmmGbbLDGr9kMYjlJ17NuQ0UJI4V19NbBoxsynqNvdVrTZu5Y6BkuDeXB9iZpufL37dY2P6RjjD/1QxEXX/rQFOaL/fd/+trAEf7XTEV3Vg0CcqxxERQNxF9jhYcRBxHxiIAElIF8MPJg+/kTtZNw8ox1JdMwAjNxa9rMTSyOy4ATXU112EOk1rEDJbPoxPo7JmUBFqdguZDI1Pni9G7PTmQtj+55G8hvcQnuPr5rn/xlshd4rcmtM21kyGiDkzmPs2fXkZ102xWdZV/Os=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(18002099003)(10067099003)(6133799003)(22082099003)(261021121427099003)(11063799006)(261102130727099003)(5023799004)(261021123027099003)(261026121527099003)(4143699003)(261022105027099003)(261102123227099003)(261026140227099003)(261028144727099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NHhPdUY2V05uUW1MOHpVVUR5NFhiSXdZN0RwYU1qak83Z3NiVlJNVEEzWS9s?=
 =?utf-8?B?S0ZmUXhvVktHSDd0RWxFREpoZC9vNW05N3VWVnIvZHBvdTlxT3lDUU55MXhS?=
 =?utf-8?B?UXpqQjlNK09zektUSVd2OFFZOGVJOGV0Z2tMbUgwR3M5dFV3VnVHU053dWsv?=
 =?utf-8?B?anRsVjBYQ0xqV1lVYkJZWXVGSm1PelpNbGpGdFJOT3JxVHViSURKR2ZDeWQ2?=
 =?utf-8?B?ZklubTNyOFFWcDlFNlM4YUI4NXdva2NRUTFHUVNHcHhWQXJIY1RDcG5tRlhw?=
 =?utf-8?B?bE5YYXYrMENpUHNnSlJyV3hFenJrSHNSa2FURmxlM2U0MEpidlFtMDAzaDZN?=
 =?utf-8?B?NmpZaWw0WVEzZTlXcDQ4OWRORGx1bU1SNmNiUlpQK2JOVll4VlVqRTVITm9J?=
 =?utf-8?B?VlAxYlB3Ti9rT2Q2Qi9BbDRnK1VuU244QkJYMjZvTFlVa3AxZkhMM3pLYTlY?=
 =?utf-8?B?RU15S01KM1NwWUJlR1d2aUpIc0JNekUrSlZZc3BRRWRnOU94YmFaZWMxQ00z?=
 =?utf-8?B?TWQra1NhM2lsUWxCTkxMSXlBMEY5aHVDWTVMcndqZk1TQjNrZEYyWmhqWklC?=
 =?utf-8?B?MitUbTJTWU9xb1g1ZVk0L2FkY3Fqbm1LUzUzdzIzeUV0MFRSdkJ6WWQrVWda?=
 =?utf-8?B?dGcyMXMzMDFlc2VPMUR3L3ZON3BtKzhNekhUMHVRZlFvdFVOelRobUNXTFE3?=
 =?utf-8?B?ZkFDS3Npbkd1NGVSYWdsN21lRDRISlE1amJYWUVTUE5SRlVTMkUrZUt5TVpB?=
 =?utf-8?B?NXBwTnZIRFJ6UmJzbm1xQnhvZE9HRjM5a0tObFRBNFoyc21sWkxYNlJKcFVl?=
 =?utf-8?B?MjYrcCtrSnNsVU5FU2dpWUFrdUV6OXFKYks4WEl5UW5Dc1RZWlFmU0lvVDNT?=
 =?utf-8?B?KzZXN2o3WE13b3hQRjN2bUcwMGZDUDFVRFdQc1pGL0xYWGhGVVdNS2Ryam4z?=
 =?utf-8?B?SzJNZHVFcERub3dLckxNNysxZE1vY3lxb3B4Nk5neHJqNi9yMVhPbnkyY0xw?=
 =?utf-8?B?cklTbzRXaXpoeUVHTU0zd3Rma1VvUUJ3d0RxWmJHYTJMb0dlNHFOL3FrTDMy?=
 =?utf-8?B?RlJHQW5oTGxtMkh0QTBCc0dseSs3Mmkyc0lnQnNUcVN3Vm1OMmlXWGZDR1U3?=
 =?utf-8?B?NGwxclJoRHFsZlhVQmFhczdrZjNzSWFGRzIvMUpNNFRXVGpRVzQ5VDVlQlJP?=
 =?utf-8?B?Q21jOTFhQVFNbm9hNUVMdWEzVWgrOTBBMFhmL001cGlkTzJyeHN2dWFBbmRQ?=
 =?utf-8?B?RHZ1YlJFbXZHaG0vdisvdjdmN1dzNXc3blJSZURINzl0b0ZzWGxsSUkweTZT?=
 =?utf-8?B?ZHhESUhMRmhJdkNrSHFlQW9sQjgzNGZFZUIxWjNDYy8ySG8zNGJiNGk2UmR5?=
 =?utf-8?B?cUx5ZTViQ3kxMFhrNE5vb3RVa21OYWx3Z2QxTU0vaHIzc3NHdi9tWDF3MDdD?=
 =?utf-8?B?TWNBb0s2eUh4SzZKeWhjcXpRekc1WVlBWlU4dzI1N3A1VEZYQm9LdlVGblFJ?=
 =?utf-8?B?MkpacG5qS2Q4dGJMcFFEODFvL09KMmkvY215UGtkN0E2RHdqdC9RdDVpbWtm?=
 =?utf-8?B?Vno3WjIzZlFtaXdtbmt4RUJJbHl0Vkx1dDhwNTkrSWhFSC85ZGszMlVTbnV3?=
 =?utf-8?B?b1haZlRVVmNBcjMrTGRHY0ZPU0FCZit1UHNPVFYxVllrbmd3bThkaWdxNlNu?=
 =?utf-8?B?Kzh5VTE3VzE5Z1FBYWZpYmNYdExIYmR5RklIQWl0OWpDaVlOckYrL3lPSUNQ?=
 =?utf-8?B?eXJRVWZDVmVhT1dqd3h3NVErd3J0dENlVzdHR1ptZWFuUlQ5YU0xekdybFZZ?=
 =?utf-8?B?UkZlbSthZG9rc0o4dW1oNWJ6cThoK2NveDZLOFFDT0hXNks3UTZUbEhJWnJQ?=
 =?utf-8?B?VTFxMi9WdkF5NVQ3TDB4QzBDM1FERjN0aGdDYWZlSms0aStVNDI0aVlYM1NH?=
 =?utf-8?B?S0tIbVNyVGxDUWJvTFoyNjNYTGRXZXVBOGhJQTVWaTMydFR4eEJXMzVhd2xt?=
 =?utf-8?B?ZFBvVEkrYVpJY1FQaWdadkJxWUlXK2x0Sm96bFlGKzlZVGF6NTlnZkRMR0cv?=
 =?utf-8?B?ZmFSQWQ2K0J6eHRWQzgzZHJvZ29nYmJjeDE4TldZc3N0OVRLU0JFM3IxaTBO?=
 =?utf-8?B?TGxEYVBjOHl2NGxsUW9FbERBc3BlSnpQdGtPWGxMN0xrQVY2STRQV0tJSW1p?=
 =?utf-8?B?T09WQ0xCdGYwYUhqU0FWTkRZUEdUMVFlcmorc2Z4NklIUjZMUGpXWTEwaTFM?=
 =?utf-8?B?QkFLS1FqSEdsN3RHbVBubGs0cENtQ3dHV1JWVmhvTDQ4ZVJSSnBLKy90OUxu?=
 =?utf-8?B?Um8zTkFYQVB4ay8xUlFWYi9SbGIxSENSaW9zeGdiUG42L1ZyQVdVQT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 95c659b9-0bab-4af1-6b8b-08df4010ef98
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 16:29:19.5004 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /qdYte93mvkkBKBOG6cSnwPhExZ3l+CNPB9wjvdaX3Syz7JAW0ldXaZ91OGdcSjgLOS3oQUA4YMUR8WB8xlnnO5dn8e6tOYT5vNbto9jzRs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8506
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
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/11/26 3:34 PM, Andrew Goodbody wrote:
> On 10/11/2026 15:06, Quentin Schulz wrote:
>> Hi Andrew,
>>
>> On 11/10/26 1:24 PM, Andrew Goodbody wrote:
>>> When running binman for code coverage tests and invoked by 'make tcheck'
>>> some tests can fail if they use system installed versions of tools
>>> instead of ones built from the tree under test. Ensure that only built
>>> versions of tools are used by passing the location of these tools to the
>>> binman test being run.
>>>
>>> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
>>> ---
>>>   test/run | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/test/run b/test/run
>>> index d1654dffb5f..0857fc14c9d 100755
>>> --- a/test/run
>>> +++ b/test/run
>>> @@ -93,7 +93,7 @@ run_test "dtoc" ./tools/dtoc/dtoc -t
>>>   # Code-coverage tests cannot run in parallel, so skip them in that 
>>> case
>>>   if [ -z "${para}" ]; then
>>>       export PATH=$PATH:${TOOLS_DIR}
>>> -    run_test "binman code coverage" ./tools/binman/binman test -T
>>> +    run_test "binman code coverage" ./tools/binman/binman --toolpath 
>>> ${TOOLS_DIR} test -T
>>
>> question: Quickly reading the code, I'm not sure this "ensure"s that 
>> only built versions of tools are used? binman's code is very 
>> convoluted so it's not easy to figure out what --toolpath actually 
>> does without digging deep into it. But if you say so, then fine with me.
> 
> I can reword the commit message along the lines of "Use the toolpath 
> option to point at the locally built tools so that these built versions 
> are chosen before system ones.
> 

Yes please. Otherwise this implies that a tool we somehow forgot to 
build but is present on the host, would not be found, but as far as I 
understood, it will be found and thus this is misleading.

>> question: Don't we want to (also?) start PATH with TOOLS_DIR instead 
>> of end with it?
> 
> That is actually an alternative fix. I chose to add the toolpath option 
> to make it match the invocation of binman a few lines above. With that I 
> can drop the change to PATH and make it all a bit more consistent. There 
> seems no need for both the change to PATH and the use of toolpath.
> 

ACK.

Cheers,
Quentin
