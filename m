Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64F53C54EFC
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 11:43:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2588D60710;
	Tue, 28 Jul 2026 11:43:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id omsfXWk-0Z61; Tue, 28 Jul 2026 11:43:21 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 474FC607D0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785239001;
	bh=JrSrWrLqDQPWbKRCFBxd3LyS7qk+0sXxBsf+jO5eHGM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Zbh7CRIjnapW8gkghKHmeBUrOsSPzzLgAfMPres+PdTP9W6YzHS/izwHy2eGe5SNm
	 hZWgWYMO8GzeRgYA6etaiZ0V9Tk9P0FEATzax9EaLZr+Y8VFJLrDCWZ5mp7gEnjOVc
	 iz8M84rA+FyG2HvYRBA/xDxjkZUV+jZ0mjSrAZ3EeSrBBXAmZj3zGvVFAztqb09pVz
	 Na3P7WI3rDmrxns5CtyrD/wu/07GaN44SqtHFot8tBR0YkhxPvgsSZpYf3YeGjXD3J
	 9uvT5/dae9L1WSxhAB5VG9O6dkg//kIFILG1jCWyK3CdaQDDmIfQS3bZbZ4kssIYob
	 JhhumEus0+v6Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 474FC607D0;
	Tue, 28 Jul 2026 11:43:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id A7E34357
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:43:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 98ABF607D0
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:43:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YYkNhhV2VJ67 for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 11:43:18 +0000 (UTC)
X-Comment: SPF check N/A for local connections -
 client-ip=2a01:238:438b:c500:173d:9f52:ddab:ee01; helo=phobos.denx.de;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 437D960710
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 437D960710
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 437D960710
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:43:15 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9996C8494B; Tue, 28 Jul 2026 13:43:13 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 096C982991
 for <u-boot@lists.denx.de>; Tue, 28 Jul 2026 13:43:11 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sVO2cJGm3MCiNLx9CUraThd7KMliMcPpLomQjh2XdY4XkDcQeW+RAeAZn04iXOV/4QTmjpcEATlzIRFtn6amJ+5cxB8vju1QJX44ZH/+E2Y/s0bU2Q/QsrYMD6mdtWMQDVTn3huHJ7o8Uqr2FUXUfT5rIo12i2QaEG9vccNvtRj732jSAmY5WGS7q9nPDDIANN0eJe0QAcENhg061XKWqmOmu0Io9I3FoPOLullAad5GdqzHQSmkTSQJ0wCPzlJRE063YvjFL8/VPSq2v5PyJ8ZFE8jLi7PcKsDpOxG26lzNNvyTaXgDZ3kuXU0gVtemWjuKzBBmVHtiOKHnOi6lgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JrSrWrLqDQPWbKRCFBxd3LyS7qk+0sXxBsf+jO5eHGM=;
 b=zVKlsAg8K/MX9rUhUNfXZ3b6lL7ED9xdETQ5aRLXyWK1jUnp7O58apBArQhEtb59oQXEOyUQvTHPW+FaRNlzHQEPzBRSIsN7w/yhzKoYMnuUycFo/8zRYJNLD8XARZGysjo86n4pNA/NMH/e9NHu81wmdrGgS7DoJjLqXNKvCyBMWIiyq9c/rMlgHtdu+7/p7AmLoH6ohP+8AtQAYMMO/a20zSQEjPLAbUNVyNEPWqMWQnWe3qlGsybzNl1Ah+hmQnZfl9sNulCtlee6lwFu0XLrgv9mJSqmLRjauzFm/g27CjYrHub0W0li2thGTYitfM3Xq+tC3Dq5Lf3FlYw8Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by PAXPR04MB8544.eurprd04.prod.outlook.com (2603:10a6:102:217::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Tue, 28 Jul
 2026 11:43:08 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%5]) with mapi id 15.21.0245.012; Tue, 28 Jul 2026
 11:43:08 +0000
Message-ID: <5ca38884-d8f1-4fca-b087-7980c2ea96ed@cherry.de>
Date: Tue, 28 Jul 2026 13:43:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/7] reset: Print reset type on diagnostic console
To: Simon Glass <sjg@chromium.org>
Cc: dmukhin@ford.com, u-boot@lists.denx.de, trini@konsulko.com
References: <20260603070743.1268544-1-dmukhin@ford.com>
 <20260603070743.1268544-4-dmukhin@ford.com>
 <4946b40f-21b1-4a48-a01e-6f81548aafda@cherry.de>
 <CAFLszThwW5Ff6JjCd+xX-fKR6phTD3ZoqtfvS6+hXRc-cH1Oeg@mail.gmail.com>
 <90e62165-aee3-4e36-bd1e-3d5cbb991f11@cherry.de>
 <CAFLszThwRges8dceWdr71KioTR8nZ_mbC0me20EKNsBtuYuvrA@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CAFLszThwRges8dceWdr71KioTR8nZ_mbC0me20EKNsBtuYuvrA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIZP296CA0022.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:2a8::14) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|PAXPR04MB8544:EE_
X-MS-Office365-Filtering-Correlation-Id: 96ad8734-439a-4508-ae13-08deec9d64eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|18002099003|22082099003|3023799007|56012099006|4143699003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: wk4HEM0UV1HPwy0mi5G8kNkc1WE0fZFHqnwas7FjStaxy/wKD4Pnv/ti58jTqlRKJT17O0khpgeNTdFPJ0fMrApbCfqr1vRCpNFk8xZY9xUqMulzkbelpQECCSsNO6uTtq1HQo/wLt3LowhWz7KfiN737f4O5WLkz2eolwZVlo9VA1qXnzY1vCHkvpBe5XP2pcBzEEsnZWkzV+2yJ/7oHwccPt6u+ijnPzgbGuPnrw66jeGViEfU9UbIGOWsYdsRBmZ1UGTYHhp9SajnCHmzwMGNfVCwId9ET7b7NW+HpVzUaEbjAdKQNMTz2c5duHL5Iu5noE3vgS3rCxWqp2hIbIx3aUSdyszqGaJifjpUSqKAZ98oQbmSEKyBNvPxr2SBSxrSPL/HCxZNqBSKq1389K3/Xx9n8Ivtj42y77EW/f/pSPaJmzgEkQ4VZzHC3Qa7QHSCXxGmOikueYxPh2uE8zRcQOu3F1Sbh/QMcSpLuphOTluL5GEETji0jE+xcsDczlJdj8jJsLomqqtnze2ETmxPiQv0t5AqFb2UTu75u4UGDx9eZcWX5179R50/iCado250EH4EAvx5D92zOjfzMVJJyOVkY9JMXwXp7JPjcBuxUbjOQxMPhLljhSB3RawGrD+ycWh9AeUwEoS2r0T6td+XpRpy1Gb7NJ4aIISuKY0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(18002099003)(22082099003)(3023799007)(56012099006)(4143699003)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dGhEWEZDTWcyb0lQL1N0OWZnV3RpQzB4S0ZBVDJ1VGc4NHVRZ29QSjBqRUZy?=
 =?utf-8?B?ZDBXN3JiaDM5OXI1YjVoSUM1b0FIYnloaFd0WUwraWgzeE1xZFdyekRJZ2hP?=
 =?utf-8?B?dEVqaHhtMjNqSUppWlUyY3laYm9UYVJXTEpSYm9RdHFpbHRhVjVzSUlNWWdo?=
 =?utf-8?B?TzAwSVRtT29IZWRhY2RXMDlIV2N0T05kTVl4dm9DMmRYRWVkN05pbmdNSU1V?=
 =?utf-8?B?VlVmRjl6aG5TNWtsMTVvQ3ArWTIreUIyZmsrbThHNjh1WDZmN01wdkQybDFw?=
 =?utf-8?B?ZUd3cHlMY3VlODVwY1kzUDdxQUp3am5yTGgwUmZ2aGRmWWN0MjB4eEtFQVNK?=
 =?utf-8?B?bGZNUFVuZ3cxaUFiNW5YZ0JLYjhmbzZrZEhsUGFwaUFFZ3JUYzdOaUxkN3BO?=
 =?utf-8?B?dzJ4aUtBNHdYNm9ySDFaMjNqZGxxeXpFM3RSQkxNNDdxeWxId3BYU3pSWmdE?=
 =?utf-8?B?UkQ2bmN0SGZhcGJLTDJGc2tMQlY4eHFad2hkNUxhaW1zTnU1ZXVDQjYxSkdi?=
 =?utf-8?B?QlNIaHNNUnBPY3JJS1FiNm9sTFlSOUZlKy9xcWxWditSU1A4ckFWeU5IbUJ5?=
 =?utf-8?B?bWxabWVVbmZ5ZDQwVUlqSmJwNmw0bHdhL0gzRk03N0F5SE5GbnVJeEh0SmtW?=
 =?utf-8?B?Mkl2ckcrR1I3VmJyZ2pXRStDR0JKVXJIK2UrSTYzRDA5UmZNZnF2cXpxNzlE?=
 =?utf-8?B?eWtjOTc5NExDQ0lrMlZhZFFHQjB6QVU4NndtUVJNRllRaW5DdWYvc1NwTUdB?=
 =?utf-8?B?WHNzUWhEdlp5Q1V4cWxPQ0xoSkpFR2c4K1JSNzRkMk1Sd2UxZVZxQmNmeDJh?=
 =?utf-8?B?QkFCUmRNaU56eWVBSjRqYnBGdzYvMWl5N0JOTnh6bU5TdTBrOVJaS2ZtYkZI?=
 =?utf-8?B?STRjTUpCS1ZYRmRLMVNjTlFHTVBZYWlDRVBMTjY2VW1kZlpqQU1VMmVXSDRy?=
 =?utf-8?B?SldOY2FSczgwN1hGb1JVZ0ZDeFhzTUxhR04zVzEzVmdpR1NXUGlZckwxbEMv?=
 =?utf-8?B?WFNXUkdMU2dGMGN3b2hzR1JrUUphckpPTVRGNTZ3R1QvL0hJeXpkZUk1STlR?=
 =?utf-8?B?amhaVUp0UTdLZTQrQXVJWFA1Q0g4a0p4a2F3QWg5Rms0WkZSeTdQdld3Q3Jq?=
 =?utf-8?B?MDgvSTkvbmh0RDdHNUpoVnNTdWsydjBsZFY1VkxIRlBENEVMZEJvTUtLU2Qv?=
 =?utf-8?B?NldNcysvTGI3eFgyRlpxcldHOEtoMUpOVzFjNHdNRy9PWGRyMEc1QjV6N0RO?=
 =?utf-8?B?T3lxK21Qa29sdVVpVkdJTFg5cWlYMldGQ3pFWEs1QlNHS1RUQ3B0VmZnQ3p3?=
 =?utf-8?B?SFRrclZJQ0d5LzFJZkR0Yi8zb2dzL0wzSktRRzNwY1NNcmJ1eTFwTkl5ZFcw?=
 =?utf-8?B?a2lVdFJGWGtKL3M1d212aUpHd2VQaWdxVmoxZW0zdURGOWZMcEk1MHNDQ2My?=
 =?utf-8?B?aExYL2I0WmwxM0VVaTNkbko3Yk85OXd3dnlFVDVUdk1MUXVlamlMaGp1a0lY?=
 =?utf-8?B?elJrLzdFQ1NLK1VEdzJ2M094LzRkUTl4QUV1Z3AyOC8rYlpLbldqM0JZNVV6?=
 =?utf-8?B?dElZemxab1FMNkt0ZUJ0NWpJSm5Ka3ZXcFFUVFFQUUFyTXEydEQvM24vZlk5?=
 =?utf-8?B?empUNHFJRFZWY3U3NC9UdkRuWm9CS1d2TnkzRysxdVoxZ3oyZTN4TjVwMDZW?=
 =?utf-8?B?clRkbzhkMTVuc1ladDlwem94a2tIVnA1TGptVXRzTTZSME1GWkVXeG5pUHFF?=
 =?utf-8?B?VDFuOThCQmI4bFJvZGJBUUdBa3BmZWIrNXZvUU9oUmhMSHpJUHJldC9jT1hp?=
 =?utf-8?B?clhYYkx1Y002YkFFU1lvcUdkN2NxRlVzNHVFeUZqRnhZcUJNdGlMVWU0Ylk1?=
 =?utf-8?B?TWhQcEFMS0VCRFJ5UXVIMlU1aTBYdmZHd05aVExWT2NXenNYUnZySWlVcjM3?=
 =?utf-8?B?RXcrZnpGV0cvT0Yxa2VWSFVxQ0IweXlUd285VlVpdEx3MUtkSHNSZFduejI4?=
 =?utf-8?B?enNaMVhVTE5DSzF1eEE3U00yWUxXRERibnpyL3hSbVpvSVBFRFpobjZJRU80?=
 =?utf-8?B?UGJaaS94M3hFaGl5ZjRJdHV0WlBvanhMbHJqdml0L1pMS2tSSDE2MkUvMWdJ?=
 =?utf-8?B?TFVqVHkxQllnSTlRK2VSRldkMndTUnZLOHdFMHZ3QnlVdGM4QjNmUU9FM2ZI?=
 =?utf-8?B?a3ZNTndETTJEVnBvdnc1ZFl1Q3pMQ2l5ZWExVmtzZ2ErcHc1S3dEZ2RXeVpR?=
 =?utf-8?B?NUw0dVBjVVpnTnlkRHF5cXR5R2IzY1M3bndEWUE0S3JKcW8raktTMEJ0djE4?=
 =?utf-8?B?anJRVzVieTc1OGRvQXVsaHhmY0kzN0JLWm40ZTFSQ3F4a0pMN2lpQT09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 96ad8734-439a-4508-ae13-08deec9d64eb
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 11:43:08.4094 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W31YJ57tg/XPnAEZNBr/AtAwfrWfgaC38E/XiII/lLIAdXVO9kEHDvTBltppEaG5U2LysQL5oEEZsgN3prQqpKWUWipM4fuaN7oTYmLPjGs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8544
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JrSrWrLqDQPWbKRCFBxd3LyS7qk+0sXxBsf+jO5eHGM=;
 b=PKtM1pV6myE1fC85XgQTMYyr+wZcUR0KB5PHbiK/F998SucQtE+b8CxfmIaclML9md/JqM/KvVz6RN5Pd0Qvk0rnpnBlvMUeTpMLo/Mfk7Fqsi0y8b+A13RQ14Y/cb7LDr4kXaNBxOpCPGIHrFe13L6hsi60s64kggImKqzi1OA=
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 spf=fail smtp.mailfrom=cherry.de
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=PKtM1pV6
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@cherry.de
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (1024-bit key;
 unprotected) header.d=cherry.de header.i=@cherry.de header.b="PKtM1pV6"; 
 dkim-atps=neutral
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>



On 7/28/26 1:38 PM, Simon Glass wrote:
> Hi Quentin,
> 
> On Thu, 23 Jul 2026 at 10:43, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>>
>> Hi Simon,
>>
>> On 6/27/26 10:30 AM, Simon Glass wrote:
>>> Hi Quentin,
>>>
>>> On Fri, 26 Jun 2026 at 16:01, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>>>>
>>>> Hi Denis,
>>>>
>>>> On 6/3/26 9:07 AM, dmukhin@ford.com wrote:
>>>>> Add a diagnostic console trace indicating the reset type.
>>>>>
>>>>> Signed-off-by: Denis Mukhin <dmukhin@ford.com>
>>>>> ---
>>>>> Changes since v3:
>>>>> - moved get_reset_type_str() next to do_reset()
>>>>> ---
>>>>>     drivers/sysreset/sysreset-uclass.c | 18 +++++++++++++++++-
>>>>>     1 file changed, 17 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/sysreset/sysreset-uclass.c b/drivers/sysreset/sysreset-uclass.c
>>>>> index 1ba698b37285..2b7717857ce6 100644
>>>>> --- a/drivers/sysreset/sysreset-uclass.c
>>>>> +++ b/drivers/sysreset/sysreset-uclass.c
>>>>> @@ -161,6 +161,22 @@ static enum sysreset_t sysreset_get_default_type(void)
>>>>>         return SYSRESET_COLD;
>>>>>     }
>>>>>
>>>>> +static const char *get_reset_type_str(enum sysreset_t reset_type)
>>>>> +{
>>>>> +     switch (reset_type) {
>>>>> +     case SYSRESET_WARM:
>>>>> +             return "warm";
>>>>> +     case SYSRESET_COLD:
>>>>> +             return "cold";
>>>>> +     case SYSRESET_POWER:
>>>>> +             return "power";
>>>>> +     case SYSRESET_POWER_OFF:
>>>>> +             return "power off";
>>>>> +     default:
>>>>> +             return "unknown";
>>>>> +     }
>>>>> +}
>>>>> +
>>>>>     int do_reset(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>>>>>     {
>>>>>         enum sysreset_t reset_type = sysreset_get_default_type();
>>>>> @@ -181,7 +197,7 @@ int do_reset(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>>>>>                 }
>>>>>         }
>>>>>
>>>>> -     printf("resetting ...\n");
>>>>> +     printf("resetting (%s)...\n", get_reset_type_str(reset_type));
>>>>
>>>> NACK, this is potentially misleading as sysreset drivers can end up
>>>> performing something different (see sysreset_walk_arg() just below).
>>>
>>> That's always been the case, but it was silent - do you suggest that
>>
>> We only said we are resetting, not which kind.
>>
>>> it prints a new reset message for each type? Bear in mind that when
>>> one succeeds it is unlikely that the serial console will be updated
>>> before the reset happens. In the majority of cases the requested reset
>>> succeeds.
>>>
>>
>> Indeed.
>>
>>> I quite like showing which reset is being attempted.
>>
>> I don't think it's worth the potential confusion. After all, we may very
>> well NOT do the requested kind of reset. Wording will be important if we
>> really want to do this. We need to be clear something else may be done
>> in the end.
>>
>> We could print before attempting each sysreset type which kind we're
>> trying... I think it's actually a good idea, because it isn't
>> necessarily clear that even if you request a warm reset, you may still
>> get a cold reset (or even a power-off) if no driver supports doing a
>> warm reset. At the same time, we don't have a delay between printing and
>> attempting a reset, so indeed like you said it may never get printed.
>>
>> So, first line in the while-loop in sysreset_walk would say "attempting
>> sysreset <type>" and after the for-loop we check on ret != -EINPROGRESS
>> and then print "no driver could do sysreset <type>, trying more
>> aggressive reset" or something like that. Before return, we check on
>> -EINPROGRESS and tell the user we failed to do any kind of reset. We
>> probably should have some of those messages rather debug messages
>> though, I fear it may be a bit verbose.
> 
> The odd thing is that the last thing you would likely see (with this
> approach) is the reset type before the one that actually succeeded. It
> could be a bit confusing. But I suppose that would be OK, since we are
> resetting and people should be aware that this can result in lost
> serial output.
> 

True, that's also misleading. We could flush() also and then hopefully 
the message really will be printed.

> Another approach (perhaps a follow-up to this series) could be to have
> the driver indicate (e.g. with plat data) which reset types it
> supports, so we don't bother trying unsupported ones.
> 

We're iterating over all sysreset drivers in increasing power reset 
levels until we find one that works and do that reset, so filtering for 
supported levels by drivers... I'm not sure what that would help with 
here? What am I missing?

Cheers,
Quentin
