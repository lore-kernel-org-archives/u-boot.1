Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F261C5DF86
	for <u-boot@archiver.kernel.org>; Wed, 19 Aug 2026 10:10:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 62F9960674;
	Wed, 19 Aug 2026 10:10:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7gQZzgMGvSkO; Wed, 19 Aug 2026 10:10:39 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787134239;
	bh=xwbEQD+u1x2IC+JsuUHnOtaOutHWWdeD89E5aSKjjA4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MDRU5RI6qaRgCI6GpeqyiEHsZyggfRfFkK4ctqjQ7+WJGPdaaV0fgoLenv9MExVIh
	 okmElAwYuhb7yPQQqIljRGe2frqkXKKQKGsHIImy5HCAZU9oa1ORexjOcahkwqRL0V
	 xWkEEM478oSNT4s1m7Z3J/h2uW5MeI2Mm7D52G9YKmgXlMc9nkIuM4hOrdUz+CFvZ3
	 VfxrMH/S8D7bmDzd4BjfMp941sqh1Gcn3tJfAMWKv17NcLKTcOfT7KQ0YJkKAX7z7Y
	 rpndSjMijjS18nE5haplKtAh37Dbb/n7xVsyHio01oInYVzI6ZfoSkkO11/XZh9y1L
	 RH3xj4EIQJnSA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7EEA260627;
	Wed, 19 Aug 2026 10:10:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id B6F2D2FD
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 10:10:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A8C1580DBB
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 10:10:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id i8iLFc9236Hc for <u-boot@lists.u-boot-project.org>;
 Wed, 19 Aug 2026 10:10:36 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c201::6;
 helo=am0pr02cu008.outbound.protection.outlook.com;
 envelope-from=frieder.schrempf@kontron.de; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kontron.de header.i=@kontron.de header.a=rsa-sha256
 header.s=selector1 header.b=GEM8Vl2Y
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::6])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BC2CD80DBA
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 10:10:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TBRIn6rsZdfZTFcuNR8QpEQa1RJMv/rrxQA5+phnvPrsuefEEFWqfniwH4IKigi1rZVj5jV2aF8LHEYEJuPUQHw2QcvchiiTY0b8E6a9h5L/EdeQS8lHkbtLyuq6BkBpOP6q754yoecpQAW2PMJPzn3ZRM6JaNlL/KVDB8yypZxC6u8uHzw9Bn+F7YY/16Q7IOmUObiXRHKQNV4kBSwynrhTpLIRGliGeGeysRjerzXePZe/QIdaaP5w62ZN4nbKDQoYIJUgO3Wl9F2ZxY4SL5+t6uGW0/5hzoGzaJ4lNk0qu0CnN73Lp8ZE7G09ap0o53WgwR7D3bzqIF9Agab2nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xwbEQD+u1x2IC+JsuUHnOtaOutHWWdeD89E5aSKjjA4=;
 b=lLDtU6tEc6niH3cWHNM9EPhazLpWck0eu1kCD3+p1bhFuwLqg/YgyBU9Zep06KM4PgzKJvYiLgVoYLPLFcWOuWMDTQzTwIqFJuAZumsBJNWECxLw2jBIQelzOekRV3xuXpLLKS592EDJmddiXAWzE42OFmCjgR0Y5mIodGASUX1NpsRr6LGPxIQGIw94f8XymBZbx0FdJ2bTjpGHvoJga1Obdn3+C8rzzsiz1WkcUzetQxa5or2yni4uyVDGHg7Wp5F4W2qgPMYenHMQCvrcu4OJS+or8JUkEKx3YDYcUCbUR/Z4amw4Vb1elbz5bJb3vrv3b+Lk6qMOiklVpRNVJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kontron.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xwbEQD+u1x2IC+JsuUHnOtaOutHWWdeD89E5aSKjjA4=;
 b=GEM8Vl2YepHWlI3LetzQoL0B6olHjGQnCRoqI3l5ScRry7rhL3fIwIP99JH0YvxmK0BBhzKGD/GAyKMGBVeYF/8vFVP50etiZRIHP+xoEvFE0XG0nB4/7Qoq+7xlnR6YZZjrvhaqAbuoHaapc/D8FeqTlAXu4KIIMg1DdIaGWzop4ecjxSTJTsaIrjaNL2uIS9a42ZpwAKV3wzoOQQu75Ozfyvw9WTnaag/ZdKnOzVQlzphhUv9zqRI+pGDloETBtbPQphSe7yqPE4XBvXcYwcHf/OnHUv2dj7rzMTJM06aveEIDOBQ6d/UCO7b6qkLY1Nh3q9cqaBdFiLAVffYnFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1fb::23)
 by GVXPR10MB5934.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 10:10:25 +0000
Received: from AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a276:4ad7:962:da22]) by AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a276:4ad7:962:da22%6]) with mapi id 15.21.0339.007; Wed, 19 Aug 2026
 10:10:25 +0000
Message-ID: <a8be2bf7-aafa-4e8e-9685-5fa100941805@kontron.de>
Date: Wed, 19 Aug 2026 12:10:23 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] ddr: imx: Allow to call ddr init without logging
 failure
To: Marek Vasut <marex@nabladev.com>, Frieder Schrempf <frieder@fris.de>,
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Tom Rini
 <trini@konsulko.com>, u-boot@lists.u-boot-project.org
Cc: uboot-imx@nxp.com, Simona Toaca <simona.toaca@nxp.com>,
 Viorel Suman <viorel.suman@nxp.com>
References: <20260819070758.51350-1-frieder@fris.de>
 <20260819070758.51350-3-frieder@fris.de>
 <b8c844ab-7ea8-4044-95e5-edac173b3c9f@nabladev.com>
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <b8c844ab-7ea8-4044-95e5-edac173b3c9f@nabladev.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0129.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::16) To AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1fb::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4277:EE_|GVXPR10MB5934:EE_
X-MS-Office365-Filtering-Correlation-Id: b9d702b1-04b7-464e-26ae-08defdda162c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|7416014|376014|22082099003|18002099003|56012099006|6133799003|10067099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: k8nGOtEAshkDg1J64EepPJPUMVDy5oH8i8OT827VmBFtiGiSoC6eKWx0pRwA6eNT64p2zwdgGLfPC73YtcUNi0iJq8Ktw5y3+yoj+lfbkMeIfAzsyueIgGV2qZGuY5jsZt1iBpzZgMOWQKgJWJkR5CEz0jDbhlBhq+9xBJCg6x6Bd97ETm32i3oniVCgQ+zhzfJyo08LmqmHnqwk/trdsyGPQjoFb5vsYJuzViM4ooxBmYfOKyBZBF3zI/nEkRn/F2mNRlofOzbdCdyAQwFQFAaqBWcXYjEuSid5u9LqmScKCWkZsLRbH5c30Kf8R2dVImJtQxn9hXIqs1F7lTihhuoFanYnBEwUkh6+R2eCrzgUBJo17JKXBhtOOsywVReW8f0faw6gRdyG0GJusyxmkXy84/dW+52M7yXB5XiFHDJVzbCp2nL7zpcwnia6+OpE7lqriOvtNg1mSlQNr+0AO/GzRCh/Qn3OcaPDozvluj9eoI9rlHCXbXv/1u0FSuvAiUnHFCIvq4OCIu2FUBIwdfw4WVLhpIyhXxGLgYgEkZQ+xddg1LU8tg0K160Z3pMN8bi4ZjPU1nFbui15IMyOARu1FKyRJi6iqaW9hhc5ulySGm2PzdQSLQF6UKlxFDnL
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(22082099003)(18002099003)(56012099006)(6133799003)(10067099003)(4143699003)(11063799006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TTVDcTlpVS9HSHFLdWFJanduR2dUVFVSOVpPUDBKQlgxZWFIMEhPVzhRZW4z?=
 =?utf-8?B?dXdQVHJWL2VEUEQ5TXBLRzVFM2RUSk9scG5VR1pJMWtTL2RZREhMQSs4ZkF3?=
 =?utf-8?B?Z0FtSHhSVk15amtmdkdVZmJRb2o2bkpON1ltUlFLRHdtNWpNcW5DaHFHeFMy?=
 =?utf-8?B?U3VQem5vMHIwN1NVMExzcjFYYnZPalRPYTFTS3JRckxZUUlUbndOWk1FNEc2?=
 =?utf-8?B?Vk90SnpCVlE5dHg0UnQ2MjJsVjR1NGZyTmpMamJCQkxRM2tCM3orYmlxemVW?=
 =?utf-8?B?aVovejluUWEyOEl1R3RrV25zaGQzNDM4SkR5Zlk0eTdaSkFLV3pNMGp2Mk5j?=
 =?utf-8?B?ZmlXNTNVczRNNU1BQStGbjh2bDJzNlRhNXBtSDBuQkZ6eE9yTDZMSmFvUTE2?=
 =?utf-8?B?THlsaVNTTUxseVNaSWpsa0pTeko2WUVSdjVaTHpudDMvckh0ZzllakJVZncz?=
 =?utf-8?B?NGhoenlLNTAyOEhFbUIwdXJ6MmpqKzE0SGdMQkJMUE4xalVNeXpEVHVWOURC?=
 =?utf-8?B?dExaOTdYNTBTWEJ5UXU1cmNxbzhHdnZYNDBDK0M5OWpjUUJjMElURFZ4OUtY?=
 =?utf-8?B?c0N0S3g4SHp3bGJ0d1BMSitUYWt5VE10amdLZnBNclZPM3pDMS9TdFZlVndY?=
 =?utf-8?B?NDhnd3BRbFRzWkk2TmtwS0xteUVuWEZqZDF2bXZFV29kMnZIbTlMbVJ2b0FK?=
 =?utf-8?B?VG1yVmdKS2U5VzBpRGRYWEI0VnBEaExmWVlMRmhVa0wzN2ZBYm0vbHAvYnJE?=
 =?utf-8?B?UjFDblR0MzJEcmxZNjcydVFOTjVOTzRDVDA5R2lyN3JaTVVaRGh4bXJHT1Aw?=
 =?utf-8?B?TXppL1AvdGJQa2pzZndlQS8rbFZucDRwamlmSS9pQVFpbzlnQU53QnJuZHgz?=
 =?utf-8?B?dXlZZ0dlUXkzR1MrcTdIYzFRNmZOU0JyeFRBNHFKNEJvanlDUGZrVUFjS0tW?=
 =?utf-8?B?MjJrTEtMN25EOEZWTE5WL1g0ZkprUTdEWXI1QTNPUDBFdHlvUUxyS1NYL2Iv?=
 =?utf-8?B?SjM2bEFPTTl3SW1PdjRsRTZxT1VjVC9FYTJpRDdkMVUvSFJvejBvdXNFS09V?=
 =?utf-8?B?Tmd3cUI0eUNvUXJVbEZiSTBJaVNuUnBCSVAxOGdHeTBjMWNudnYwK05rMHlF?=
 =?utf-8?B?OHM0MFlSUHlhRjIwcTFIS3QrVEhaajcwV2cyQi9Kd2xmWlV6bUltVGpGdlRP?=
 =?utf-8?B?dG5NaXF3c1FvNVhMQ3I2UjJ3YzBjRDdnSjJSNCtZZG9SQVRDRHZhUnVNU3hM?=
 =?utf-8?B?Y2pZSUJzRFllNkl6ZDkwZU8zRWhpbVduUldQRWNnZEg3UHFCMmNDM3NhSlFt?=
 =?utf-8?B?and3N0FvRkNSZkNzKzN6cFhuYlRsTEtqZGpMTCtwamVVeGdyQmFybExuMStE?=
 =?utf-8?B?RURwVklmZzNJTXlxQi9VYXB6SXFBYXoyaTBnbFJ6eUtxMXZXSFltNjVHRkVi?=
 =?utf-8?B?QmNWNGxiOS9vZEZOQkV0SHNuazcwLzN4ekJkTkdzWFd6RnZZZVlDckg5RUhP?=
 =?utf-8?B?emU4V3dyYWpCQXZrRXNGSGlVOWdVYlVUaWVNbEloSjNJUGhoMnQ4YWhVYmdC?=
 =?utf-8?B?RUpMUUJHaDI5Wng3d0xiSWVTdmFkOTZoaHA4VUlxNlFHblRrVlBma3U3ZTRS?=
 =?utf-8?B?Wk1GNi9McHlIZlpIL09KUGJ4eHBGcWhoQmFOc2FoNERkNVpsSkJML0NFSmcr?=
 =?utf-8?B?dUdaSE5VS0Q4NzluQnJNT0NsMmMwaWE0MjAzUU9PMlJERzVUazZFV2xKdnlv?=
 =?utf-8?B?dHgxcm9tWkdqdFBPc1M2aHl6OXRlKzZMSzhJM0ZWQVpZa1NadFhsU2hYaDBB?=
 =?utf-8?B?dWN0ZEFYS2ZTaWxkMXo4RTdOUlZtOUl3OVpJOS9xdHAreHR5S2tibm9Kb2dq?=
 =?utf-8?B?UWJmd0xhOHpUVXIydmtIVnVIbXROSTcySVhSb05wOXdiS1FVSEgrMDhlK1FN?=
 =?utf-8?B?RXlTMEc3ZjhDOWZVR25QYkZ4K2drN3VML3hKTkZBMndacXpwcU85RFQ0bmlP?=
 =?utf-8?B?a2VicWNEKzU5bFN5MFZ0c2xneVZoU2VBMWk1bThhSEN2RHM2b0NyUVVydEhm?=
 =?utf-8?B?aVNJOVljV0ZEU2lXOUdsL25nRzVRaExCQ1N4ZzBHTXZvcFR2Y1U5K1RyMTJz?=
 =?utf-8?B?T1lrN2crYVlpUXE3VjRhaGVna0F1SGkzVWN3QzZnNUVnSEJuMFpoYVpEUEF1?=
 =?utf-8?B?VW9KODJWQzA2dGlqc0E5RmJvR0JidExHU05oRStYRURTMjdoVkorWTNUZDZx?=
 =?utf-8?B?OE9PRk9FSkRhZmNWbmhHQXNlaFVhcklkdVU3S3lwZmJUNFRFd0dYZGlKcDg2?=
 =?utf-8?B?elRHS3Z0b0VoSG5zak0zODlGYjBXS0k0cE80TmlIR2QvOTVvcjBNWW9qOW9O?=
 =?utf-8?Q?YUtCWRsPdXK4jjso=3D?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: b9d702b1-04b7-464e-26ae-08defdda162c
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 10:10:25.0812 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TrRwZFN1v9ksRzhO8z/u7Iv1e0qol7QNcP9DrM9CWIflOAeK+CushO9KGiOBOSVRsaGyD+d+n9ctNK+MACCJektCAKhh/aRPCgpYJxXoXRM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB5934
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

On 19.08.26 12:04, Marek Vasut wrote:
> On 8/19/26 9:07 AM, Frieder Schrempf wrote:
>> From: Frieder Schrempf <frieder.schrempf@kontron.de>
>>
>> In some cases we need to call ddr_init() multiple times to try
>> different configurations.
> 
> What different configurations ? Details please ?

The detection of different DDR types/sizes on our SoMs has always been
based on trying the init and seeing if it succeeds, falling back to the
smaller sizes on failure. See here [1].

[1]
https://git.u-boot-project.org/u-boot/u-boot/-/blob/main/board/kontron/sl-mx8mm/spl.c#L72
