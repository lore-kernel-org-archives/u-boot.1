Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EFD1606A321
	for <u-boot@archiver.kernel.org>; Wed, 11 Nov 2026 10:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=cjBzO5ZO;
	dkim=pass (1024-bit key, unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256 header.s=selector1 header.b=gjOJs/7+
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4931681132;
	Wed, 11 Nov 2026 10:07:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id zCRokvuj0wQX; Wed, 11 Nov 2026 10:07:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0C10F81110
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794391672;
	b=TWIwQozUrYv84obTvumnxfsLw185G6OGetGdLSU6lzVM3Ss7lHybwqBVoDnFRh0HFKWq
	 4uXiAx0yJmVrugk6wmYdrzpHIGzqeb63Eluxb77Jxsk/sjcvhPFjJ2AiSGyyIMY1BpQlA
	 p+QDroPeSh6fgJyfOe+pSpsnkrprhBxFRFh/Fep4Ch83B7E0HUdXiTFxrX3LNVbD0brJE
	 B+rfAu5oFto6WoUATZXwSS036NNh/QvuwVKz0oal/qcgTQgoox9OGI88huPq0+nqt1dFu
	 eFoQuqtOKxstodUxsRRcDjIED6BCAv/B3kqc155RYEAVGDyn0P9g+EY32emUXM7dGFA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794391672;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:References:Content-Language:From:In-Reply-To:Content-Type:
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
	bh=RtvfnlCEzgKHWp6u5C4+GOub6A7EjCntiCtgeJWNoLQ=;
	b=JpO6K6cBXWgkNR1n0/O7XwkeWDi56qq9Ds5treBAFKRkxDymJruqH31mtGIbASsQkcvt
	 GOr1x38b4eVl49WPjChNAsylkp3LGDSfreOHDGZo9vUfHKz1qIWLpv3Wftpcm+7peYTBQ
	 n3KqtXUxronrMAQllb+rZgj/E2LLqrZk3mjDRStsw5h4q+jO4o429Tfk3M48QbFnaVWMS
	 CJPDiDMAZ1rRZZetINurcioqD2GIMk/rQVFz8rD/Nwqh5xUQxWdXNYWvyLWNIXsMOPo5y
	 Smte1sNav3sKfFelBwPG+cSgJ+Oh6Rl6jep6nGVN9GdJHtJAZ8p0nNtj6KCsDoJ53mQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794391672;
	bh=RtvfnlCEzgKHWp6u5C4+GOub6A7EjCntiCtgeJWNoLQ=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cjBzO5ZORp+16cgmCKMTnvhMF8IsPKzoaITgWYl8rDauK3H7xUKjvjYOud0c+uFed
	 y+qUVyEVYyXx01Ur1Zg2HZbHEO19IMc0skOjYTERB+yvsyDrsjayagwlQWiDzVgrNq
	 E8/repIsN2iuCUSLYJSQEkbSaFZGRjDSPnQ8Vvp/MZfR1GPU7ux3WXz8brPS4ayCEi
	 IvlFQ9sYFGNZaYIZpWJfIFiRMyporDyZc5XTWHVMTLBfIpifzoZgQFgapppDraSKSs
	 gJWhV6ehTOj4Xrr8g2yId7Y5IqRc1wcCDy/+VvpJdQzKiwzUW1nR2pLv7bGnZ8bHh6
	 HfIfi1kTPrNig==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0C10F81110;
	Wed, 11 Nov 2026 10:07:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 1219E31F
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 10:07:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0318A606E0
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 10:07:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aQU_kNPnXIok for <u-boot@lists.u-boot-project.org>;
 Wed, 11 Nov 2026 10:07:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 2123060793
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c20f::7"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20f::7;
 helo=osppr02cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=gjOJs/7+
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2123060793
 for <u-boot@lists.u-boot-project.org>; Wed, 11 Nov 2026 10:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RtvfnlCEzgKHWp6u5C4+GOub6A7EjCntiCtgeJWNoLQ=;
 b=gjOJs/7+T7eDotxPb1ZPYTnJ6Q962C1UMANnvBw4vArgjik/OJES3tBeMSuDmQtbXeel61dEBPN6QcNoQbY/yGHCHxnpWuExRESV0q49O48mD2FASsFtJFw9mscNt8tz8TO95DIyD3om2NYTjK0QkAC2GEMi0/OAw7BVBlEECu0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com (2603:10a6:102:4ab::7)
 by VI2PR04MB10978.eurprd04.prod.outlook.com (2603:10a6:800:27e::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 10:07:43 +0000
Received: from PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d]) by PA3PR04MB11153.eurprd04.prod.outlook.com
 ([fe80::6b02:c0eb:95a4:3c3d%5]) with mapi id 15.21.0615.007; Wed, 11 Nov 2026
 10:07:42 +0000
Message-ID: <3cdb390d-51fc-4a36-93ac-6f0ef0fb0648@cherry.de>
Date: Wed, 11 Nov 2026 11:07:41 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] Update maintainers and mailmap
To: Peter Robinson <pbrobinson@gmail.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org
References: <20261111091728.3388905-1-pbrobinson@gmail.com>
 <20261111091728.3388905-2-pbrobinson@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20261111091728.3388905-2-pbrobinson@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI6PEPF0000022A.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:808:1::8e6) To PA3PR04MB11153.eurprd04.prod.outlook.com
 (2603:10a6:102:4ab::7)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA3PR04MB11153:EE_|VI2PR04MB10978:EE_
X-MS-Office365-Filtering-Correlation-Id: 9206eb79-4715-4805-db50-08df3fdb9ffd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|13003099007|261009221227099003|261009223027099003|10067099003|261022115727099003|261028144727099003|261102123227099003|261021123027099003|261022105027099003|261022075727099003|261021135927099003|261021121427099003|261026121527099003|261026140227099003|56012099006|11063799006|4143699003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: SkVTgePMk428hUA9DjhBH/34Giw0gYwC0safkg1DZih25VJWY/sjphZkDuE+YsmeuR93kN2cFBby8EGdzlXAf2wQBl92TEnwEsTrtJBxG5RZyXs+HxSuTCMMpGx7hN8T+XFsAOoZ1mEFVNAx8SQ9HgZhlY5z8XqwS7E696QKO7WKyqVoWNhAjMi8FOnqch4G+uoTBsl20ZMRh++HWtIJ5QmJtkA0pXneVVY47QUKc/6Iw/sXTrq62GvNZnrNwydwn7gRuANEOKP88hLUnUhmB5nYKFSurVLGVU89+uDHUIRZRsIpD4I8K0t7Iwv/9cqVY+9VTSPNTWwDHVg4HAduEmgtyc2CuPfOnPAeKQlEBiPGXC7H3aP+wQbjSu/LY7pBGorPREfvzt/HkvtSBo2njj9/pxL/byIimu95ZF993HjbOpr7PWb+N8P8vnbAvan19VZqAENvyVyICdPzS1cfzOloD1wTOaWFfRZIUJlTx55IrIcrVFxIwNkGhEPyxainnLu18BEqExpJgF6Zbbdd3oPVr+9bq+DULnVegccroGrrZ32f+CjGEOP0kOC1cfAYhpASLigUNZnYFGkILVvEQeth5UO1dqiKPJLnKAV5n0Uchn3K4qim8z06Qk0x/fne
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA3PR04MB11153.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(13003099007)(261009221227099003)(261009223027099003)(10067099003)(261022115727099003)(261028144727099003)(261102123227099003)(261021123027099003)(261022105027099003)(261022075727099003)(261021135927099003)(261021121427099003)(261026121527099003)(261026140227099003)(56012099006)(11063799006)(4143699003)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZjE5RDlVenlQSmcvckEvS043eWVJZ1R2am1GcGtTR0RHamJseUp0YzVWVTRP?=
 =?utf-8?B?eDVyUzMyMnNwR3czY0FLV0xqcEladnRCdXJrUVhQTGo4cFhMSjRmOEx4clpZ?=
 =?utf-8?B?WUxBQUlWbysvVlI4dktyVFI0S3htZHVHUWtLL3plaEJHMW9CU0tMQTd0ckV1?=
 =?utf-8?B?UzRuWVJaQStSSXJLb2dpQmdVM1UyZTBMaFV1WTJyTExGRHh2TmdidUszaUNn?=
 =?utf-8?B?eUtab1N0TDdqc2ZGZVBKMjhoeXhmdnp1K0p4T2JPM0pxajkyb1lRbFZCSVoy?=
 =?utf-8?B?Wmt1Zy83ZUVPQjNpMnhEdlhiSkZFRGQ0VkZhUzNiZldoSkJhR3lQelJTc0Zy?=
 =?utf-8?B?bGVna3N2NGJuajBXOGsvazRnNDk4TFlxUGhibG9jZ2N0SEc4d1F5bWpYY3Bt?=
 =?utf-8?B?dGMxdjhNU1gwRC9NZ3ZaaVdqR3ZRMDRqTEEvbUF2SjdCNXVjMmRRK3NQUkxP?=
 =?utf-8?B?NDVzSml5bWJFYVVYT1lFeVRoOXJJYkJFNnlrNjZLQk4vcVc2RzhQS2cyUUpL?=
 =?utf-8?B?WVZweXQ5NGR4M2tYdEdmSFRsUzlNbUozK3A0ZlBqWXp5WmRibUJ5TEhwL0ho?=
 =?utf-8?B?YWdwZGxDV2ZnbXM1MFR6L3lyZjBDK2V2S1BKUmx2dFIzS0JkZGNyOTYwRHdO?=
 =?utf-8?B?ajZHR0twa0t6SEdaUFp1Wis5dmpLbHhDamZPTXByRUNNbktDM0RJVlYvTDgw?=
 =?utf-8?B?c0RLS1c2OVVLbEFDaUMyeGJvODczMlh4VkJ5MFp5elVzdk4yMXhScU5HT2ZO?=
 =?utf-8?B?VHVxOGx0OWt4Tm5sQ3R3T1dETHpWMjFla0VmdDhsQVFOMzNKeStXWVJSVEgr?=
 =?utf-8?B?QnRoQ3RRNUVGTm9CQnNRM3FVOFpTckJ4Z29OU2NIMEI0Tit3Rm0rVEdsOWxi?=
 =?utf-8?B?NmVPM0xCNmhrY0xJcWhBeHVjMUZyMEg2b2hlYllyZTRUc0czVFAzMTRMb2hn?=
 =?utf-8?B?ZDFHenFoSFFXSGZUaVhocDdzS2N4MHd4N3RVQW0zYW9jRWRzZk0wM3dIK3RQ?=
 =?utf-8?B?U2FvSWhFY1BUL1d5M05NK3J5dlJoR3h2bDZud1NwbVludUVhNUJuQTdRNWU5?=
 =?utf-8?B?VHQ3aVdnKzJqUFRRM1lQQTI1VkI4K1FNenRZZ2dDNmZ4YVlUTi9SRlpEbG02?=
 =?utf-8?B?UVJoU2E3M295Wk5pd2ZJK0c0NStuMFBPMWQ2ZHJHUTk1UkovamVQbHNNZ09S?=
 =?utf-8?B?clVsSEJXODFUR2d4ZWF2UlNvZTFZVmJvS09HMTNobW1TSFY3TUVqaWtOYU81?=
 =?utf-8?B?K1dnRHZVZXNZN3FuRGNrTVd3Y0hqN3N4cDkyekJ5MnZBa3VlbUVRV2ZzZkU2?=
 =?utf-8?B?VVNQZWVQN0daZ2FNbFk1YWZMTXdpZXlsdk9wejB1dHN3bDNwS0RRVGhrU0RQ?=
 =?utf-8?B?VjhmdklMdG1FRnRlU0Znd0hUN3B5dnM0VTJEM2hzWEt5MEhUR3R5aXVXVFY3?=
 =?utf-8?B?NERIL3ZNSENYUUhTM3RoaDNFY0ZUWWEyUGNQRTcvQno4RFMxSmo3RTNzcHgz?=
 =?utf-8?B?ZmdvR1VHREdLRDJIeHB4L2V1Z1Q4dkNzWWlZNGdTVzZJYm96YStNdTlGajcz?=
 =?utf-8?B?dkhFQytJRVpqQncvRDNoVlJYQzc2TjlZUkNhMGUyRFdNV3orNHlZOTYyNVkx?=
 =?utf-8?B?QTRFY3lDWkhXaFEzRzFiWG9VMnRWMzRYaFgwWXFnWGtnYUM2LzNKUjYxK25w?=
 =?utf-8?B?YWVYQitqSlhLNWhQR3JOWUQwWjB0OWY2UVJVZ1dRb1dlZzN5MUpCOFNUV2g1?=
 =?utf-8?B?STVwcnp0Sk1oc3QzNzF0R3hhWmJkVlBXVEcyMHg0T0Zqc0FLYWFnMkdza0lV?=
 =?utf-8?B?U0VscHc4NWFMUjNkRDFxYWFnTzFkTHE3cmVhSG1HUmNBNmJPRjg1c2NYcVdx?=
 =?utf-8?B?U1lUV2ZtVUEwWHVuN1Btd3J5VEJqZGd6WFZRODVKa2o5VW9RUTJlZm96cHpT?=
 =?utf-8?B?YXM3WGJOaDE0VVljQnREQkVHUjU5MVZwYVVwT21UVHFZendNK0pUQUg0SWpn?=
 =?utf-8?B?VkZQRkxiQmdZUHBqTWpxcUpkZThoaU1iWWpPRzdJZk1ZelVDYWNURExZOTlZ?=
 =?utf-8?B?U2k2eDdaRkcxcy9sM2NmUTlQVmlVbEhpZDZRRHdQbklYd0xnKzhoaEh4V3R2?=
 =?utf-8?B?SnhUMm8ySVczRDR0bURMZTVWeXU4V3BHbWovL1NZdHJQUXN0aXlrTzkvYXMw?=
 =?utf-8?B?RCtBeVQ2Y2R6cjNZeGtWUndRWTR1ZHBlMlFqd1c3bm1mSzRwTytGTkZ2UXo1?=
 =?utf-8?B?WkpSU0JYaTBrTVBsOUcvY1NPNlhlTTl0SUZnajhXU2NjbmUzMVhQdk11YjFw?=
 =?utf-8?B?YmRJcC9SQmkwSjJoYmFyQTVkSGlTNGtXemsrUEdHN0xuc0Iybm5EZz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 9206eb79-4715-4805-db50-08df3fdb9ffd
X-MS-Exchange-CrossTenant-AuthSource: PA3PR04MB11153.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 10:07:42.5909 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eIH1arZ73ZcTA4DI0KWPL0WB9nzJ49WYLx9zQa/Cv4yz+d+hDie69Ws+zxRZT7Wy+w+xckUEGhkn6Xdqk6i+1qGpZXZx1SqEHaqMHCVxIe8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10978
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-22.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Peter,

On 11/11/26 10:17 AM, Peter Robinson wrote:
> With the departure of Simon update the MAINTAINERS file
> to reflect the current situation of various subsystems.
> 
> Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
> ---
>   .mailmap    |  3 ++-
>   MAINTAINERS | 32 ++++++++++++++------------------

Simon is also listed in many other MAINTAINERS files:

board/bluewater/gurnard/MAINTAINERS
board/coreboot/coreboot/MAINTAINERS
board/efi/efi-x86_app/MAINTAINERS
board/firefly/firefly-rk3288/MAINTAINERS
board/google/chromebook_coral/MAINTAINERS
board/google/chromebook_link/MAINTAINERS
board/google/chromebook_samus/MAINTAINERS
board/google/chromebox_panther/MAINTAINERS
board/google/gru/MAINTAINERS
board/google/veyron/MAINTAINERS
board/intel/minnowmax/MAINTAINERS
board/radxa/rock2/MAINTAINERS
board/samsung/smdk5250/MAINTAINERS
board/sandbox/MAINTAINERS

>   2 files changed, 16 insertions(+), 19 deletions(-)
> 
> diff --git a/.mailmap b/.mailmap
> index dffeed3238d..5632778fbf3 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -147,7 +147,8 @@ Sean Anderson <sean.anderson@linux.dev> <sean.anderson@seco.com>
>   Shaohui Xie <Shaohui.Xie@freescale.com>
>   Shravya Kumbham <shravya.kumbham@amd.com> <shravya.kumbham@xilinx.com>
>   Shubhrajyoti Datta <shubhrajyoti.datta@amd.com> <shubhrajyoti.datta@xilinx.com>
> -Simon Glass <sjg@chromium.org> <simon.glass@canonical.com>
> +Simon Glass <noreply@example.com> <simon.glass@canonical.com>
> +Simon Glass <noreply@example.com> <sjg@chromium.org>
>   Siva Durga Prasad Paladugu <siva.durga.prasad.paladugu@amd.com> <siva.durga.paladugu@xilinx.com>
>   Siva Durga Prasad Paladugu <siva.durga.prasad.paladugu@amd.com> <sivadur@xilinx.com>
>   Srinivas Goud <srinivas.goud@amd.com> <srinivas.goud@xilinx.com>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9fc6614e519..0ee3ef000a8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -63,7 +63,7 @@ F:	net/9p/
>   F:	test/py/tests/test_9p.py
>   
>   ACPI
> -M:	Simon Glass <sjg@chromium.org>
> +M:	Orphan
>   S:	Maintained

issue: I think this here isn't right

Isn't it supposed to be:

S: Orphan

with no M: anymore?

>   F:	board/emulation/configs/acpi.config
>   F:	cmd/acpi.c
> @@ -77,7 +77,7 @@ S:	Maintained
>   F:	drivers/net/phy/airoha/
>   
>   ALIST
> -M:	Simon Glass <sjg@chromium.org>
> +M:	Orphan
>   S:	Maintained

Ditto.

>   F:	include/alist.h
>   F:	lib/alist.c
> @@ -820,7 +820,6 @@ S:	Maintained
>   F:	drivers/spi/spi-aspeed-smc.c
>   
>   BINMAN
> -M:	Simon Glass <sjg@chromium.org>
>   M:	Alper Nebi Yasak <alpernebiyasak@gmail.com>

I believe Alper Nebi Yasak hasn't been active for years now, so we'll 
eventually need to reflect that here too, in a different patch though.

>   S:	Maintained
>   F:	doc/develop/binman_tests.rst
> @@ -836,7 +835,7 @@ F:	include/blkmap.h
>   F:	test/dm/blkmap.c
>   
>   BOOTSTD
> -M:	Simon Glass <sjg@chromium.org>
> +M:	Orphan
>   S:	Maintained

Same issue as above.

>   F:	boot/bootdev*.c
>   F:	boot/bootflow.c
> @@ -870,7 +869,7 @@ F:	fs/btrfs/
>   F:	include/btrfs.h
>   
>   BUILDMAN
> -M:	Simon Glass <sjg@chromium.org>
> +M:	Orphan
>   S:	Maintained

Same issue as above.

>   F:	tools/buildman/
>   
> @@ -901,7 +900,6 @@ F:	drivers/clk/
>   F:	drivers/clk/imx/
>   
>   CPU
> -M:	Simon Glass <sjg@chromium.org>
>   M:	Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
>   S:	Maintained
>   F:	cmd/cpu.c
> @@ -939,7 +937,7 @@ F:	include/linux/usb/ch9.h
>   F:	include/linux/usb/gadget.h
>   
>   DRIVER MODEL
> -M:	Simon Glass <sjg@chromium.org>
> +M:	Orphan
>   S:	Maintained

Same issue as above.

>   T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-dm.git
>   F:	drivers/core/
> @@ -947,7 +945,6 @@ F:	include/dm/
>   F:	test/dm/
>   
>   EFI CLIENT
> -M:	Simon Glass <sjg@chromium.org>
>   M:	Heinrich Schuchardt <xypron.glpk@gmx.de>
>   S:	Maintained
>   W:	https://docs.u-boot-project.org/en/latest/develop/uefi/u-boot_on_efi.html
> @@ -1005,7 +1002,7 @@ F:	tools/env*
>   F:	tools/mkenvimage.c
>   
>   ENVIRONMENT AS TEXT
> -M:	Simon Glass <sjg@chromium.org>
> +M:	Orphan
>   S:	Maintained

Same issue as above.

>   F:	doc/usage/environment.rst
>   F:	scripts/env2string.awk
> @@ -1020,7 +1017,7 @@ F:	include/erofs.h
>   F:	test/py/tests/test_fs/test_erofs.py
>   
>   EVENTS
> -M:	Simon Glass <sjg@chromium.org>
> +M:	Orphan
>   S:	Maintained

Same issue as above.

>   F:	cmd/event.c
>   F:	common/event.c
> @@ -1065,7 +1062,7 @@ F:	include/fpga.h
>   F:	test/dm/fpga.c
>   
>   FLATTENED DEVICE TREE
> -M:	Simon Glass <sjg@chromium.org>
> +M:	Orphan
>   S:	Maintained

Same issue as above.

>   T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-fdt.git
>   F:	lib/fdtdec*
> @@ -1169,7 +1166,7 @@ F:	doc/kwboot.1
>   F:	tools/kwb*
>   
>   LOGGING
> -M:	Simon Glass <sjg@chromium.org>
> +M:	Orphan
>   S:	Maintained

Same issue as above.

>   T:	git https://git.u-boot-project.org/u-boot/u-boot.git
>   F:	common/log*
> @@ -1207,7 +1204,7 @@ S:	Maintained
>   F:	lib/mbedtls/
>   
>   MEMBUF
> -M:	Simon Glass <sjg@chromium.org>
> +M:	Orphan
>   S:	Maintained

Same issue as above.

>   T:	git https://git.u-boot-project.org/u-boot/u-boot.git
>   F:	include/membuf.h
> @@ -1398,7 +1395,7 @@ F:	configs/o4-imx6ull-nano_defconfig
>   F:	include/configs/o4-imx6ull-nano.h
>   
>   PATMAN
> -M:	Simon Glass <sjg@chromium.org>
> +M:	Orphan
>   S:	Maintained

Same issue as above.

>   F:	tools/patman/
>   
> @@ -1567,7 +1564,7 @@ F:	cmd/rockusb.c
>   F:	doc/README.rockusb
>   
>   SANDBOX
> -M:	Simon Glass <sjg@chromium.org>
> +M:	Orphan
>   S:	Maintained

Same issue as above.

>   F:	arch/sandbox/
>   F:	configs/sandbox*
> @@ -1821,7 +1818,7 @@ F:	common/spl/spl_ufs.c
>   F:	drivers/ufs/
>   
>   UPL
> -M:	Simon Glass <sjg@chromium.org>
> +M:	Orphan
>   S:	Maintained

Same issue as above.

>   T:	git https://git.u-boot-project.org/u-boot/custodians/u-boot-dm.git
>   F:	boot/upl*
> @@ -1870,7 +1867,7 @@ S:	Maintained
>   F:	test/lib/uuid.c
>   
>   VBE
> -M:	Simon Glass <sjg@chromium.org>
> +M:	Orphan
>   S:	Maintained

Same issue as above.

Cheers,
Quentin
