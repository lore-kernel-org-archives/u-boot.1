Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05EDC60A2602
	for <u-boot@archiver.kernel.org>; Thu, 19 Nov 2026 16:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=vRp7wE0j;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=mJe2jHY9
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D17FA81456;
	Thu, 19 Nov 2026 16:50:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hf8hqTnKme4f; Thu, 19 Nov 2026 16:50:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 33DA88144E
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795107053;
	b=JWxVRTUs6NmoWPDaDJwlwYgkbyYpFTjnJmI1sIcigF+RbLtEh727BuiXVE5pkJZ/NUO3
	 6ImYbeAnUseTxAof3+9BQ9IqdHAm/4zP55628FcHTGM0TDy2RYv0W2u4lD/AmPkMpB2mJ
	 Awo62s9QBZIRVl5O22T1FIpGX/YFwpxLQM1Pq8CviOlc1YnK04DkjlvHY9iznvIac3ZJF
	 U6ZpJcDuMuZ74i/rbLWvIMITVH8iaJmdVLNVkLNWqlO6AWu7vEvpKkUP2uiKL7rLfPt3l
	 DTbL2wKsTJtFRin/uvZVcQwD2NZH2OKMqLTPNgZUxfU7gLn0CKBDt2s/yRzbVDCTXeA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795107053;
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
	 X-MS-Exchange-AntiSpam-MessageData-0:
	 X-MS-Exchange-AntiSpam-MessageData-1:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Ye5gpFsbdCmgMeJqqD1RFwlDcMbbPo7rwmNT18BopJM=;
	b=Dhrsji3GMrQlgzjWYxgUHWbRv5neXEzz2uhXkdZOGI7rW8+wB80Uks5zY9JqcSClmKZO
	 HORnhOA3R1y1bk5A936wDsEsPhcbCRANCLOr2BrsunSLu5A90AeELrl28Am0N1zayI3n4
	 fISHs0agsuo8qNi5N1zKSm2GJ47tYHv9nS7HMT0ynyDmF+3d9f4N4wz4gD6bO4wBZ1fIR
	 r3+i6qWG1Yuus9pdDo/bNQHMQeD1IkbF2TA2jYlZbwmDIi4HPl09H/uKIb5Ite07KxVyK
	 ljMg3ifSdHcIjUQ6ASVpWn6ONU7XHIgevEoQTAyX2Da4kZaJvXGvtw/xUa3RyN1f5Fw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=cherry.de;
	dkim=pass header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=mJe2jHY9;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795107053;
	bh=Ye5gpFsbdCmgMeJqqD1RFwlDcMbbPo7rwmNT18BopJM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vRp7wE0jNKJgGU75Z+Z2eUaC7eYD/7VpLFARD6TomQUfcMbLk7JS6sjFdAxEU8tia
	 ZP2vqh8r70CVsEhpToZBVg6vD5jD1FbU38z1nMooYYmmHDbzIf5NhcWuygngcb2sIl
	 Gq6shWFyCek3bruT5zRhM2SlDHJpHaA+po4NTkuv/oYd6Jn+Wa/Ro0Fn2+TajTX1o6
	 8BNZqL26OjjMpFXX5QoQ/u9HdjwzfktzKiC9O6RR0mmcsiNWX068PSjBiA4fwzwEzt
	 0rP1cl2wr0MCLySu1/rf39op0xKo8X1tBu2n9/CglYH4xwpk9NE6kR0XOcVci/rdAQ
	 laxRLR8ZLEvRw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 33DA88144E;
	Thu, 19 Nov 2026 16:50:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 4A6EB3A8
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 16:50:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3B3E08144E
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 16:50:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ctStVrusiMKu for <u-boot@lists.u-boot-project.org>;
 Thu, 19 Nov 2026 16:50:50 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4C7638142A
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c207::3"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c207::3;
 helo=mrwpr03cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=mJe2jHY9
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4C7638142A
 for <u-boot@lists.u-boot-project.org>; Thu, 19 Nov 2026 16:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ye5gpFsbdCmgMeJqqD1RFwlDcMbbPo7rwmNT18BopJM=;
 b=mJe2jHY9mK8TJg8/pPgpN58G554YOhuxcjkoYQb9cUtdglVNHUp1KFpD10QQ+S3U+rwyToOElcN7JLRCIcsUQKYlSayH8kpqKXRqZtFyDdD+ohywT9EjABYtRHjQQpT6jYOPdGn6LxLwF3Pw7eyNfriwLuLOY1OOBsgqnAv9RCU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by AMBPR04MB302649.eurprd04.prod.outlook.com (2603:10a6:20b:81c::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Thu, 19 Nov
 2026 16:50:45 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0639.010; Thu, 19 Nov 2026
 16:50:44 +0000
Message-ID: <4d9cf178-2e99-4a05-9808-b2f29adf66d3@cherry.de>
Date: Thu, 19 Nov 2026 17:50:42 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/15] binman: bintool: Do not add empty argument
To: Andrew Goodbody <andrew.goodbody@linaro.org>,
 u-boot@lists.u-boot-project.org, Kory Maincent <kory.maincent@bootlin.com>,
 Linus Walleij <linusw@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Anshul Dalal <anshuld@ti.com>,
 Alexey Charkov <alchark@flipper.net>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Carlo Caione <ccaione@baylibre.com>, Yao Zi <me@ziyao.cc>,
 Michal Simek <michal.simek@amd.com>, Marek Vasut <marex@nabladev.com>
References: <20261116-qcheck_fix-v3-0-b6cf7e96944b@linaro.org>
 <20261116-qcheck_fix-v3-2-b6cf7e96944b@linaro.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261116-qcheck_fix-v3-2-b6cf7e96944b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI4PEPF0000011D.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:808:1::8a5) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|AMBPR04MB302649:EE_
X-MS-Office365-Filtering-Correlation-Id: a833565e-13d6-426e-dfd0-08df465d4105
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|7416014|376014|10070799003|366016|22082099003|18002099003|6133799003|3023799007|4143699003|5023799004|11063799006|261026121527099003|261021121427099003|56012099006|261102123227099003|10067099003;
X-Microsoft-Antispam-Message-Info: UmgDRuyF9YGZ7lRLDWk2MzEuRB5GK5CK/HsAON+GMkaInBHi2HaFfSAwS1J2uuKUgmnFE9MpC7EM/yROiQaDP0W/a/zKeFsr+JybqhjrRU2pPf/A6pK5qOPmQC/56U8xPeJwLmTtW/jnPB9e9QMR9cf/xDmZCjbzZps/IoeNU/iGCa/6C+hQOhGHtbI/rkbVD0Qbt+gEX4faIrzsBWG+5OXhxRagJyIYbbercXwvk0/hSvg4p48qRyOzgfTmYuCkCRvRfuW9fn1FSjUIwxD25928Ny3Kcrzy2CSbWZ5d4zPyYo7oLB8vXfsVh6XXzQcpPH3uBEKKuyzxF9krBSvEnck+aIcj2Oa658SIAacSA8rmrEVoj/AxcoCfR77XZ+qA1mMbA/BIktOLXHQOZp1bHWwJIYM/KaOO5g68oNGERzE8sO58MPXDScGWPgIr66A6M+q2sCusGOHPsufsWAGNJ8986+42I/tPwbbnxWaarLTDsv3VXzdkl94LkrV7y7tdOow5ENLTdpc+6odNxANNvqdNENUbaGwRAh2XJd0WFkECaFxN28fCb3pW0bxoRmqdWRCxL9VIfJqDjVoPNoogvbNiobMcUQeE8/5gRuq1bmtPY9n40f4dN+8lxUXZw9Ri/U5mRYLLbh2j+nGZx4qzdgyQglYLlDsqdjUhleUWX/Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(7416014)(376014)(10070799003)(366016)(22082099003)(18002099003)(6133799003)(3023799007)(4143699003)(5023799004)(11063799006)(261026121527099003)(261021121427099003)(56012099006)(261102123227099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SU42Zm5LMkx5VTI5eWljOHNnTE5YM2czdXV4SmRiazhER1dvYnA4YmFWbVlD?=
 =?utf-8?B?TmlydXUxcjExUnVaUUpZbW1NM3ZkaG5KYkZ1MjI4MWNYS0dKRkxwWm0ralZz?=
 =?utf-8?B?ZlRmVUFLWlZXOE05ZjRweG1xMVp1cWpzalo4YWVZdTdNR2xqZ0VpNFlpMGlT?=
 =?utf-8?B?MlJkaVFUZTJ2RmVZVElZSDQ1cGRXYU5LbzVuVzZQQzc3UDZmTUU3SFlBemJ2?=
 =?utf-8?B?Ynp3N2lwVzZTOS9NaTg5Y29tSjRQWnhteHcxaUgwZHJXMzR4d25DdnEwRkl2?=
 =?utf-8?B?U25maEFCUGtOZXVXb2RXYzhGRzZncmUxTENNWVQ1Zm5xSlFrN0U1MnE1cFdW?=
 =?utf-8?B?N0wvQUFJaUlGa3JCMklvY1pUOWpQQVRlSThjKzVWVnZEUWNVNkI0a2FOMk5J?=
 =?utf-8?B?RkUxUTdIcFNQdU1VU0JqdVZBRVpuOFNwcWR0Q3hUWXZqd1M1YVlaQlU2V2lk?=
 =?utf-8?B?dlVYZDIwYVZzMGkwY3dMTGppeS8yWDNrV1MrK0pNa0g5bzlseVorMjFhSXFP?=
 =?utf-8?B?UisrT0EvOVN6My9EUWhjeEFVYTVvSVZmTUlka2RjU0xiVmMyVmlxQlMwRGJU?=
 =?utf-8?B?UmQvbnpQaEZtZnBmMWFseDl2RnRjSmM1SDU1L21EN1MwcU9URG11NXp2NkMz?=
 =?utf-8?B?ZTkxQ2RHRTNpMGZiMHdpaml2K3B5bVJ2dXNMcHp3cTFVU21EY0o2QmMxS0x3?=
 =?utf-8?B?OUtJanhveVJVZStaWmFQY1dKczlZZVZoVkFWTXVzZGVBL0NCMzNKY2hUTWRE?=
 =?utf-8?B?VEdYdlNVeW9NZ1laZTEzT1cxNkM0NkRReHlnVVdmUzBCN3pEQ2YzTENPa2Fu?=
 =?utf-8?B?Q1doNmpVUDBuQ2FHZzB4MnBDNXJiU042RVpHZGQrdEFTelhNV1VmZVo2bHpS?=
 =?utf-8?B?ZjNmOWpDZU1ObnEzQWZrSktiYjRRQ2QzZjZnbXc4eE1UU1NMTm5sVlc2Vkw1?=
 =?utf-8?B?bEIzU1BHMHpodTdiN2tEVksvbEZ5eW9sTkxjSVRWWVh3eTVXY3dobU44b0xh?=
 =?utf-8?B?YWlrejkrSnJnV2xzcytrZm51SUJjZERoZGprTFdvNTBHM1plQjcxUlNuaHkr?=
 =?utf-8?B?R0MzWVpPNU15V0t5YUNjTVRRZjR5aG1EU01Dc2R0RFRxVHBPc2twV1RmN09m?=
 =?utf-8?B?cXJPUFREUm44NElnUEZCdjVJSktJZ00rV2hZVEd2NldYNURtNG5qUktlS0Vu?=
 =?utf-8?B?VVo4MWl0dXRVNkVwazFkcEJzQVI2ZnVlSkJhVVYrcHFUTDRpNXJrTUZrQXRX?=
 =?utf-8?B?K1oxK21wOUVCNWRYR2VmYitVMXJjTkhtWHNwMEQ4OXVZdHQ5RTRwUit5NStR?=
 =?utf-8?B?NTB0SzJHL0pTck1aTHlVQU4rRVpqQVZkd0VqaXRaVWEzcVhVaW9VWUtoZ3hB?=
 =?utf-8?B?WEcxTkdLTGllYUNGM0dlSy9wdGw0OE1sdzBBZG45WUJxdnhoNzhncS8zRFV1?=
 =?utf-8?B?cElQdHcwNzlJS2Rjaml5Zi9BNFloZi84aWtKakFNUnJFUHBHQWF1Q3VXa0Zq?=
 =?utf-8?B?S0NGNjRiNitGT1QwOVNlYUhIa3RYdFNsN2NMRTV6eDRXb1oyTE9xVzlOZy83?=
 =?utf-8?B?SGk1MVN6SjdPSVN4UzRHV0N6RjFKK1NaWWFFTGZkYU5wUkM3YmRPUHlUQy8w?=
 =?utf-8?B?VnA0YjBBR1NrUC9KN3BLMitYSzJ6cDludFBSZkFVeU9OdU5KbUlQUWtncGcw?=
 =?utf-8?B?U3lvd05hemFqb2FYQ0NVM2ZxbmJ6eUVPK0Znc0ZoSzUyRjV5MlcvKzloSWhG?=
 =?utf-8?B?UmZsRTltbWh5UDIrblNpSTMxVXpGWnh5TWplTm1QY3RzNU9yTGJXR09FUStW?=
 =?utf-8?B?aUhNZjFJQ0s0NXdNWDZ6bUZ0MEVsb0haako5VktDLzFieFZ3ODVIZHFFekVz?=
 =?utf-8?B?TllMQUVuY1Z4QmVMaFpiK1llMkZ4NXNzSU96ZVFMWGJVVzhJWm9rekZYWG1R?=
 =?utf-8?B?UTZWemw1K21xa2hLVGl3dnVtTE5TY1ZmclVadGhJNFI0ZjlzV2htSkJ2M0Q4?=
 =?utf-8?B?Z28vSzk0ZnZuOG5lbktiWUJUTU5BVGxEc0ZKbGorOElqQ3JYT1NBQjBIRjlz?=
 =?utf-8?B?U0dKUzNYVFNOckNlTWZPNHhFdkM5OWYrY3FWSTNVVTc3QytzVFRFcUJFTHdY?=
 =?utf-8?B?TUJPOXFXb0VrQVVSOVZ1V0ZwTml2MWFBczRvZ1k0bDBNSFVJdDRnQUFvT1Vv?=
 =?utf-8?B?UC9NSEMxTGFRSUJBQ1dkRlFhZWhjTzNXOW1EZHNiRmtpSEQ1NS9MVi9SUDdU?=
 =?utf-8?B?cWhLQWM3NU1ubVlFeitiRXJMcHBxQlM3YlgzU01JbWVQQzVaV2lZQWlzR3Nv?=
 =?utf-8?B?djB6eWNYUFJuMkJiTlNZY3gzcmxOVkw3VHRPNFg2VzJpWVdyNllMdnFSeVR3?=
 =?utf-8?Q?1MFMin/ONO4w1frYDtcmuvkNBW7lHkKf0wrIJ5HFAJw4a?=
X-MS-Exchange-AntiSpam-MessageData-1: fJM2ks8NlefDJh2zv1JoNRyLkGyppa4aUhs=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: a833565e-13d6-426e-dfd0-08df465d4105
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 16:50:44.8903 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aLXyhhek125gDTi0uBtsUI7cDAI8E5GSlC2J+Ztgh4vmmIBw7nNguRPcbMERN4m5cdHvuWAP4uBfEelY+vmYg61H40d5uasEHMZqJwnwUns=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR04MB302649
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
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Andrew,

On 11/16/26 11:59 AM, Andrew Goodbody wrote:
> If lzma_alone is invoked with an empty argument it will emit a message
> to stderr. When 'combined' is used to examine the output of this command
> the content is not deterministic in that stdout and stderr may appear
> out of order on occasions. To prevent this situation do not add an
> argument list to the command when it is empty. In this situation no
> error message is emitted only the usage and this is always sent to only
> stdout or only to stderr depending on the version of lzma_alone.
> 

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
