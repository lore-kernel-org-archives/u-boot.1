Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75459C5DF8C
	for <u-boot@archiver.kernel.org>; Sun, 23 Aug 2026 16:15:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 437896072A;
	Sun, 23 Aug 2026 16:15:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Uw5V3TFO2cLM; Sun, 23 Aug 2026 16:15:15 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787501715;
	bh=EVHPuHKABFBKnaWgLytYOiyRFa8PWRIPwIyziu5IbBA=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=r3PwdN4LfTIv5jg0J8jc2QXVlKO8ixjvzVCJYEozSsawtp492QJacHs7W9Ghv5pqa
	 3/9kWPnktKn3HCSK7psdPweg/vvT0wEkipdL3UeiyOGbcpPn8xVMaS/i+9hcYmE01k
	 VR0iEBdnyXkVWPlOPGxWlKGvji+eptC4k59AjBxnjaJHXN7svmOm1Z2yfa/OAyTXMB
	 VRyuJy63jHz2ED1Rfd6HJDUba4asi3XuFwNp90LJbxDu5vPHLcqQThnSd84BPEjzwX
	 wGpKbSRO5wrB2aZx7SFJYp1wejEpgh7XOqZlC1CwcjQzAjMSAvn3unO2CwZDwR41DU
	 K1AWzEoMGg5qg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3979F6061B;
	Sun, 23 Aug 2026 16:15:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 190E63DA
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 16:15:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0B12780B63
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 16:15:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id X4ExM9AlmbcC for <u-boot@lists.u-boot-project.org>;
 Sun, 23 Aug 2026 16:15:13 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::3;
 helo=as8pr04cu009.outbound.protection.outlook.com;
 envelope-from=mikhail.kshevetskiy@genexis.eu; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.a=rsa-sha256
 header.s=selector1 header.b=z28m9yp2
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9586E80B5C
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 16:15:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=phs9oTia8jUnw5q/CMD+OPb3GS7Zy0gVvoVXOwWFFGnX0Vv0q3glSLqiqnvxX4JuXciYwuBD+AkEKvqSDNve05+Z0z1ZrJZoj20dcTgCjApT+S9RIvGN2fH8W9AkOB699zx4oNoWh1wrR348s9dTUm7LRzgOZqpZS5nd7c8tNpQcII0263D7guSQQH4+N1ENlWzqQSOI7wIqQvtKLWIRZhuiG0LOCMdyfppBmOGUriUHofx5V4n2PgZN+YjdhgQFmJBRW/AAknIdxj4xOeRc4DK1jOAgpb4NVTbzO76vKH1G/TsjaPVZyzwMPZrO6hGgeHSSqN+HGsB8G+lWCBePlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EVHPuHKABFBKnaWgLytYOiyRFa8PWRIPwIyziu5IbBA=;
 b=aEaSW9bsR1S4L5LYnY1teUJ+P+jA6XAYEJ2xKQp/uUfh/UxX9fRyumi4dVFNxLBqMocd07bZ2oki0L8JTKH3pACvzz6HRVQLfBf290qeO/PfTFCsWiNUmSaiNb9nsJS+EmyIn+da6M6B4YjCpN2ikQRzFD9cPuKpLTk29xJmHOVA/8nxQ5nulGHlL13eqDp3mas+kVXMu65AtnXg80spypQ9T5jSXd+eEEQOxBvBZ0XZLQ/QWNGDFotaVBYEGol3pcL7VATyvVhCxUU/nY/n5i0/PKIrdsgfhVcuFFPJE2phYcvFQyglt9WNUMMxr1nYfbsm1K+Fk9bdMqIcEzd/Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EVHPuHKABFBKnaWgLytYOiyRFa8PWRIPwIyziu5IbBA=;
 b=z28m9yp2SxFZuvTs9jWkrApDwA//LWzbBZLb/EsaD8J8kfPDgI/yOTJUfr4T5+tGrbChzJk3Qku+NPAB8zgLaGSUB7RIOR023IQTCGoNBiwJCRSfiGruipKvlGzOCpZR4zppJk1+yZXpPjDkr7LvIesTuy7Y1N9b6zvmsnnY34OY3185546nW0Btuup7cYnXPzuPM5pOtMoziiYrLmroeTCaMdR30Iudf1QwZd/N5M+ygw8c8HD9axiXzuSE9zXwjiXuQfjBsp8VCgXK5Rq4rbXUA6D4YBmoeHO8Wgb/mL4rLN83mkjDsdCNtiCLKkS/zouzpipxOcDm8kLLMRQopw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by MMZPR08MB594171.eurprd08.prod.outlook.com (2603:10a6:190:55::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Sun, 23 Aug
 2026 16:15:04 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%3]) with mapi id 15.21.0339.012; Sun, 23 Aug 2026
 16:15:04 +0000
Message-ID: <14ed312c-ff15-4d66-9074-35769a65be42@iopsys.eu>
Date: Sun, 23 Aug 2026 19:15:01 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pinctrl: airoha: sync with linux-7.3 driver
To: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 David Lechner <dlechner@baylibre.com>, Markus Gothe
 <markus.gothe@genexis.eu>, Benjamin Larsson <benjamin.larsson@genexis.eu>,
 Matheus Sampaio Queiroga <srherobrine20@gmail.com>,
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Mikhail Kshevetskiy via U-Boot <u-boot@lists.u-boot-project.org>
References: <20260809232726.2436904-1-mikhail.kshevetskiy@iopsys.eu>
 <178749706837.206448.895471974507405553.b4-ty@konsulko.com>
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US, ru-RU
In-Reply-To: <178749706837.206448.895471974507405553.b4-ty@konsulko.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV2PEPF000239D0.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::1ad) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|MMZPR08MB594171:EE_
X-MS-Office365-Filtering-Correlation-Id: 5889af30-61c5-414b-c338-08df0131b0f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|10067099003|4143699003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: hh7ZLFz9g350IN72v/4aqh++Y57SElcN9RhI/aTmF+Jyvix6Mn/8p4mD+s3JelaZayedtsI9EzwzlZUO7qFwCzSlsAvcH6hoZ9gXCTONABAZLNYVIk91XCKcoSGRkMgVsPN0MjJvBfqiXvrZsDb8Tu2Yo2BnBeS5PUoc9oKOJGGH5Pe1iOPHJgV9QAwP+RJ3jeyYeJCPrXkdZoAPAxrVdc7TFYbYvbpB/Ze4Qers9GzIwzbukBki6Z87bL+hUkuY3WFbtcV5Cv7DDPgqPwijcBT0x9gaI+sVfC2h5jG3o0oYfZxhUT0IwUJrmO0+6NgVMfH2aX9oc2wsgkhItX/5/jhMMkN6r71zb0cE+58Q1Diwzh4P87t4B+/J2cQibGC3j4itfBfOWm+VdkXvDMOwtcEWwEtSIUcukxPDMk2FLfoPo3AJkDdKYYGzSZObVK67C6Mdv9MSGqg02EKS0KXw92dwA/ngUtXq+mjIY3z1vFU1+lRtJm2s6diiYMZnhAkAiGIdaKODsWqrhSbPDa1GZKqFJqPKEh6TRmCvPTYzHrEIeyD/3zA4pNGAevyUK/XpffAhiMldW6hi88uUWnydxbYsmMTNQ1ezw1FPrc93wx/VxxC4kdYHbD6UdBolCWK/iCzQRYzorv715wT8nD7KMUIjke2xc7vXuJvqkWQLbXM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(10067099003)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWxqTWRxNklNTUpDak5QYTJMZktTUkd5WDY4Rk55b3dRZnFBZU15U2tIR1NH?=
 =?utf-8?B?YzEwWDJoSEVGZHhDc0lqZnZERGhTVWpBV0I4N25lTkhyOHdEME5JZjl5cmlz?=
 =?utf-8?B?TXdWMUN4YzZ4UGlkK2QzZkRYbzlQd1RFUlQ1dUFMUjBYank0dnBKMVVtOFFr?=
 =?utf-8?B?V2FyUWw2VzhleWY3NVp3QUFjSGVleTJsbXpBUmhub3dVOVBXWjBRS3BWbkVp?=
 =?utf-8?B?OUhsM0RTK1UweUNMeFloKzJEQnNPUmpMQlgxek5mdTNBUVlPbEVRNnJpd3Qy?=
 =?utf-8?B?aDhMOVpSNER3R21lNjl0MkJqbGhGNmpuaGUwL1loUEtZb0t6cG5SQnRpUm5w?=
 =?utf-8?B?R0NSa1ZWQ0ZsUU9zc3p5MERZMk9tYWpVUFFhVnZ3OE1zK3VJU3VFZ1Z4YVhj?=
 =?utf-8?B?R0Y0dmpQZmVHQi9wZ0l3WFFuRHZrL0JUWGgyQ0ZEYVJMdXlqSkNpMW8zYWxC?=
 =?utf-8?B?SVhhTFVZNnlhZ1FVTVk2R1JiRVBMK0tjL1lCUVRWZlhSbTNBN2FqM3V4Z0Yx?=
 =?utf-8?B?THFaMEZXeGMvZWRYdzhmVXFKYkRiL3ZjYkQ5ZjMwalZsYlpIY2Vxd05ha1JW?=
 =?utf-8?B?OHB2TGd2NE01OXhONHZiTWlFVENRU0poMnBhemhvZjhhZWdsais3bHJkZmIx?=
 =?utf-8?B?UEpzOE10cXlkNHFBUjlDOWhkVnNxaGlQOTZncmwyTk9obldGcmZ4V1dDNHp5?=
 =?utf-8?B?Y204c2JLbk9BeG1QV0lGL2pTdTdMOEw3dWNJTjNwSWJKbXlYNVErQlRpREZT?=
 =?utf-8?B?eUx1NDRQWURyOVQ1TXpZcFpONGM5WTlvVEdJMnJVZFpnVnQ5MTgwOXZNZFgr?=
 =?utf-8?B?TGhJUlNJL3ZNVXZmVVdsMW1KcG5ucW5kZXFpUW1BRVF2b0hCdDk1YzlCV3B0?=
 =?utf-8?B?VFF6NzZzbkh3aXIwQWpJdGRYMWRWN2JmT2NtTzhka0pDUktZT2ZHU2FUM2Fa?=
 =?utf-8?B?akZJSTd4MDc4a1FRRk80bHVQc3A2K2QxUWk4LzIzRkY1TFgrdHpxYlQ2b2li?=
 =?utf-8?B?T1Q0S3JHRkRpR211UC9mQTJKSGtKVjl0dUJxRHZ6NUluamR3YmVJcUVqZitr?=
 =?utf-8?B?QVQ2YVAvOFVDTjJIRHJQVGtrcU5pODVGc3Y4NzR1WUJqVDBSRzE0NElwdXBt?=
 =?utf-8?B?Qm85bExuUS9ib3VJS0IvZ2pmc1l2UVJUNEFycVNXMEdSM3l2RHpDZHFnQ1dZ?=
 =?utf-8?B?TWMvZTRkeS9yclBBWWVLRDZUZ1V0K0R6dTZVUlg1alBQVzFUOU9jOHNaMitH?=
 =?utf-8?B?Vlo1WXAvVFRUZlA0UmwyWjFudHh0dnZhbW1tVWRIdkluU201R29Za1lXR3Z6?=
 =?utf-8?B?dEFKTFpsbmNES1Z5MjUyMWx1WG9qczdoZU5nWG9LSUlQV1k3UmgzUktTUDFP?=
 =?utf-8?B?K1kwVXlpVytYNVhLWnFYZDBsdFJJMzFQWlJzT2Znd29hUkhmNXlkYkNIUUxt?=
 =?utf-8?B?QkMrQTZWM3lBMTBtWXN4SG9ZTEJYZ2JYNTA0Y2hXVU1nYWU0TFlJRVdWUW1H?=
 =?utf-8?B?ZDBaZjRFY2w1YVJqQVF2dFd5SE03N2dNU1NQS0ZhVU56VlJxQWJSUGl2MmVk?=
 =?utf-8?B?RmlyYVppMU5kVjR1R0tXK2RGR25PVnJzdmpwWjQvYW9TS0RKemFvcnkzMzBK?=
 =?utf-8?B?elRtbVpOdlpBdmlHWXdvOEJTRmIrdm5Ma044LzdLcnZVWGxPMklCTkc4R3Vn?=
 =?utf-8?B?MDFWMEJvN3I5NkJCSW9haHFYTEpZcmx5eGFmQ2xiZkhrMEhsZUdjVy8xVGxi?=
 =?utf-8?B?TE94RmN0a2pNNXNla2pqdzhaVzFMbEswOHNUY2lIQXpCUm1DM1krcVdOamUr?=
 =?utf-8?B?MmM1R0FBRTVERzVZOFduSlc0NktuWGxYbk5Oci9HTUlZUzRSMDBGL21tRFFD?=
 =?utf-8?B?MUxCc3hPTkZkRitFNGVaTlU1Z002ZzVPekM0eGY5UXNzZ09rb2ZVZlF6V2N5?=
 =?utf-8?B?d2hWejhsekhEcmlaazBVcEJoMVJybmtQcm0zdnN3c0Z5QStCZTJ5dS82VGtR?=
 =?utf-8?B?a2wwTmsyVmJMcGpNVlhPdlZFaVdZMWxBazlSeHg1YWtuVFowQnZoMUE3aFVQ?=
 =?utf-8?B?RDJzZHN2K3JuZWlJU2RNanhaMUxUV1lBdlFlblYySks5VlY5RkpBSmlVaERR?=
 =?utf-8?B?SFdiMzJUVkpoUkQxRjZJQk9ZUTkzVjAvc21KRDRKYjlyNU1pK3FHWTdGQ3lx?=
 =?utf-8?B?c2ptVWRPL05XaS93N0dxSm10bFZaOUdkU2tqRUNrdytPbTltSXJvVE44alpR?=
 =?utf-8?B?SFBBTnVPMmZobzJ5MytTc1NkOTM3L1ord3RHSEc1cXRMM0h6RGtCMHNzUHJ3?=
 =?utf-8?B?bktPNHVLSENuSTRYQXVCeXRRZzE1RFRzOVNocE1MMzVZWFFNVjRBcSs4R2I1?=
 =?utf-8?Q?zrt9FlQzuIvnCQwk=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 5889af30-61c5-414b-c338-08df0131b0f4
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2026 16:15:04.5867 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n5btQQJaBW0KF56PkCIZIVK4Jc8LLpOOCsr3oiIZiR/ZygHhM3MZL39EMbrusQjmE4dO2aITD/YChQklD31FK0Idy9PkIv0tLDDkzp8D+yE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MMZPR08MB594171
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

IMHO, it will be better merge this to master branch.
This is mostly bugfixes of existing code.

On 8/23/26 17:57, Tom Rini wrote:
> On Mon, 10 Aug 2026 02:27:26 +0300, Mikhail Kshevetskiy via U-Boot wrote:
>
>> The code was synced with linux-pinctrl/for-next (future linux-7.3) branch.
>>
>>
> Applied to u-boot/next, thanks!
>
> [1/1] pinctrl: airoha: sync with linux-7.3 driver
>       commit: 2d379a529c257606946831a6dac1c37de6a3f8c0
