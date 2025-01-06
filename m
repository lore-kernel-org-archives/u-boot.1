Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BBB2E77188
	for <u-boot@archiver.kernel.org>; Mon,  6 Jan 2025 10:14:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D7F2801E8;
	Mon,  6 Jan 2025 11:14:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="Sc8bpHw9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D6D7A8036B; Mon,  6 Jan 2025 11:14:31 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20617.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::617])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F36E801DE
 for <u-boot@lists.denx.de>; Mon,  6 Jan 2025 11:14:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S+/0OfU4l2rqngoQnsS6EadPg9NalmBVYNc95pHr2hUz31je8K4qESSdryGikSmjK6I7iDw+9f2E5Wqom4upRdkOkd10QKHghbKv8HqCykcD2gkhlra19wGzWvN9DMWjKALXew54f6mjA1qOfUxjO/yUBJ7r+DN6Nr5WO1mKtBmbIwJrlZR1VcaxApKE6eokUuF1eeU6flC1H7V+MkufdoG9uxHWSyl1ewk/RN1tDSjTQYznYpon8rd7ho2F93mbBmvcBi/aBD24l83jPnwUYKf58ST733zWEt3vl7zI+iu1BmAfk11+NFXp1v1rvz4ZhRaxCwXpsEugeSHFrCw2/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CIRwgjP6mu52EGNnYNaRQNMybvSEKk0HFLqXleO13sI=;
 b=A/byZYbcxVtmbEKeqhOgP9AN0UGVlBJVJ2pmD/AdynxHTRXqF+UoWBOhGx/tbB5XeVFY26rS6lLcuduHQRN1PYxGgotvHk726ezE55KL0ICKKXKBVGuyJ+Tzt+0KjIM0B+QTWwBUP57n9TY4uX9FiG2fyNjRxXZoTbEshsHkLlKEKsZJqsTOh+7pTFPy3caFIAV4JIsjHWZwK6wrvJ8x8FzAFPUd34TplNW1F6UxjTo1o3pB6IDJXX3x7yQ1bYzBgxNWnG/8IRCq3g7LDu1MSRl0cyLlEvgiQDJB/FD6MixFHLxy9QlJjD4ifB5dRFs8SI6RlPFVIGqqc25Ee3qh1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CIRwgjP6mu52EGNnYNaRQNMybvSEKk0HFLqXleO13sI=;
 b=Sc8bpHw9OPYQJg0PZWnkiej+z4GKb4mBYzVVVKiQqThBqMWfutzSouDVUceKphPzygdjZ3Ou67TWKTovoOKc93+i017+nnOi+Rv5r5L77dYijgK9/VB70XRrO6ZunlcisTEswnpJzbpQ99aiUKIEtQGZwXYKKlxg8GPQqZN7zRE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:41::17)
 by GV1PR10MB6657.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:82::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.8; Mon, 6 Jan
 2025 10:14:20 +0000
Received: from DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7e2c:5309:f792:ded4]) by DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7e2c:5309:f792:ded4%5]) with mapi id 15.20.8335.007; Mon, 6 Jan 2025
 10:14:19 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,  Ilias
 Apalodimas <ilias.apalodimas@linaro.org>,  u-boot@lists.denx.de
Subject: Re: [PATCH 1/3] lib: implement strnstr()
In-Reply-To: <196cc091-5031-426e-b5ea-923065b2b026@linaro.org> (Jerome
 Forissier's message of "Mon, 6 Jan 2025 08:44:24 +0100")
References: <20250103232118.711135-1-heinrich.schuchardt@canonical.com>
 <20250103232118.711135-2-heinrich.schuchardt@canonical.com>
 <196cc091-5031-426e-b5ea-923065b2b026@linaro.org>
Date: Mon, 06 Jan 2025 11:14:13 +0100
Message-ID: <87msg41c7e.fsf@prevas.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0009.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::24) To DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:41::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB7PR10MB2475:EE_|GV1PR10MB6657:EE_
X-MS-Office365-Filtering-Correlation-Id: 04955322-a33f-44e5-da4a-08dd2e3ae25b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|52116014|376014|1800799024|38350700014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?u/HDGtS/3P2xiq5koaL6Mkzehr8WEI4sqziKfc8hYBfWeogjkt67KxiwVfwm?=
 =?us-ascii?Q?SxbwIXqu+IzEV3L0cSwd4wo1KmdtvZaqvB8SIeOLC7HRB0UfzJaa9RV0v3Fn?=
 =?us-ascii?Q?QH1zLbbaYnx+BoNUsgQjlDwbqmyKr43fJLCtJZouowvRR4aWuhpDswHzOPkT?=
 =?us-ascii?Q?J8xF3jBbRTou3oH11Q2SZkD4B0VrpQYVq7g75HCwmaACeuL7gUShUzla8nUf?=
 =?us-ascii?Q?k8bhqHnpM0mjHfpj804+yMfbBJU9ctb4ZYKmwSmhHlYIOc1Z76QZq98mfwYL?=
 =?us-ascii?Q?Lw3auV0GPZXRNdi102PT2D3wi/2ybMU0PBUiqwGJpRjgmHl35CvAURFH8819?=
 =?us-ascii?Q?Sh/u/21jpHU7RxSeOzY3jxrGl9HeSzo4tiiocwNkQq8sDJc6oboKTzdV4ivy?=
 =?us-ascii?Q?mSHQyQ7AVMXHCvWSweFHgp+w9qhQvKm5OMvZizNdSnNhf4Q9VNIuJsAy60W3?=
 =?us-ascii?Q?CIQw1DRVmpaFsHge1eESj1Wv4Qxm3/MhOFzZkRpo+o4+UI32nwXWQl1qgZLR?=
 =?us-ascii?Q?m4g2ilOmsGAQN64AKKCwhx7/6WNEA2dK0xvHlQj1LJXprb+gWDDiIsAymEfh?=
 =?us-ascii?Q?qy/PkYSCXcnYJy1d8okminrY9hQUeQeIaQpypXnq3/URIz09suKaCIGZ65vK?=
 =?us-ascii?Q?jjeq5hxFySOxI+GBMop9Ys7cXXOnJzH6UofdH4cik2UCBlQphOyQHVFaDlBB?=
 =?us-ascii?Q?zqdmx6mzvkOBsfgtBDCoKKBbj740BIMQS9IMFHpQR+eU+GFVaO3lib/EQNC2?=
 =?us-ascii?Q?euVwvsHbKesjTkz8vlhusVC6qKNZfxVbc7s0hPR6npViZm6AOic72uf0K7Jf?=
 =?us-ascii?Q?39z5jmZMeje08T0g44XSZ3WLYb/peUJeqdjtHmn9zPLeImahM96uPEcKPWBg?=
 =?us-ascii?Q?DbtZ4wqaRCbwvA7rApEpVCZyJ9+dKfHXcRWIfxWjPHSj7sT10W9fyqDQd0NA?=
 =?us-ascii?Q?VhwPr5+P5uw5hpuJ8wUWQL7NCDqHL0+wnGvRQt1TLrwWKCLbVxAdz7KfgVhw?=
 =?us-ascii?Q?97PfXociugprIhlSvCiVC9KhH54uGgN0vaYdNGa0tiUalikIFn7jWUDj2W67?=
 =?us-ascii?Q?eVZVVDw+S8bqX8r8moA5Kn6Hdb2zYBf5xA3u6aXCEDF4tdnNrsNWUgyyJxMc?=
 =?us-ascii?Q?AyLWq0V28V30DX2qLT8zhUYnNl2nMt6Fi9Wzq599ahEKl37sBt1+W+zPSHC/?=
 =?us-ascii?Q?MXsPmmLMijcX4hfoetQhn2aqiR/kAtS4KmMo/hZIPBIaZosMqmAHP8icuU0q?=
 =?us-ascii?Q?8zcGOuhXUOdcr8YbbDAC4l4cR+2pN2HvaC37stWG+YEVMfxcRcGG2WZj2g1E?=
 =?us-ascii?Q?bCM5baehxCYuX9bgAfpq+/N551KQtxx6Bq3m0ga9qFs+8kcgjDQbiNL7+XU/?=
 =?us-ascii?Q?bHQ1XbN+uM2DUxbUegLYdOkyKkvsZ4tlS6cwJXKfs3bt7/hs3jr5ISmfC5X1?=
 =?us-ascii?Q?/AlH6S7wjbTnXBk95fg9mCaYV5PtxEXx?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YpWSusKDmm9pOoghx/fFvimn9f80uLthatvz1PJJ+05xvSyETNPWSjuFqU0q?=
 =?us-ascii?Q?eVxkZT7lXiqnyrbB94CTjRB7t7mleX69DtkfZZB1izo1gowGbIQOiHFt99a0?=
 =?us-ascii?Q?wtDMOOzeFujX9BPicvG5SMcM4qaeBrZzadbyS6WqEq1JUtGbUqOR737WKGb5?=
 =?us-ascii?Q?X7UkzFIoPbENwuGA8RmffTW4moQmV9n6hvfIgJjMlNLz0u84GoUa3APs45w2?=
 =?us-ascii?Q?85YbBZ9/ifB5KoT23s5C+6jgU1CMH4PBwOltZBCzS5nmOXNiuchszXtdHraO?=
 =?us-ascii?Q?4BrVN+w/w+kDf0P8VDTDiXL1iiNtik+w25yfxde6DKP8b5yK4VoRQ/WlkoSS?=
 =?us-ascii?Q?As1jdEqS9E3VXNRREJ/QAobjRW5FKHH+mZsWuZCV99rggU309S91Ea3BCE/n?=
 =?us-ascii?Q?t7SKayKGRp2y80/6+lijs6WX3RZjk2k92urEN3eBIE+INp6gJj1AnCecsPQF?=
 =?us-ascii?Q?59Ls3/jgyzQAS/gFwa4bh3teAxf090f2qa0DEXMedQ+ZNVrwfbR82wqXSNxI?=
 =?us-ascii?Q?JWHOqfg1VMzBQJKs0tj818mke8sofzOdHa/312rCrf8FBnEpAL9kkoxR1DRK?=
 =?us-ascii?Q?9ruHZd4xUW+g6C9qZbszwGuHQ1hwS3wM0Rz3C+s/PLR4+R4rjPXjC35k78SJ?=
 =?us-ascii?Q?ip0inWceBeMFxNponNnMNxKchmW2EPFLP1c1NpCTZLkQoD4NGhul/LkyM5Np?=
 =?us-ascii?Q?DUdGdL/Ya66jTJNBym4WlTsY1Ap4Nf0EAgAo2Mpi9kCpAG+EriXu65lsrdTw?=
 =?us-ascii?Q?3Ki4/D/tMi/mugziTrUubKP2e7KU1aaI0mTFMX50Vl80dsHAKNoJqMYnOu41?=
 =?us-ascii?Q?PWHfXuYKVcOBVOsV81og3H8+8uOF4VNdZXFDyGTu6lwxbD2nqDh79rOOhfB9?=
 =?us-ascii?Q?n6U0nYZjuRVWqvgMna/6+2Hx/p3X731f1z90QPiwtglE2kPXW1Wo0v02OsDt?=
 =?us-ascii?Q?bCPxhH2B8Ni3J2+e8/rfOQfx0fqy4FBuA59H9iagNoArBuzcsJ90NxVC8nmH?=
 =?us-ascii?Q?ckm1N5no9YDGtkJQ72nrOMBmNkIFkxgEjHSBg7MNZx5jawF3dydS5Z7FKLZV?=
 =?us-ascii?Q?V9qRrr8t2+axnH8rhJAfocgA+K61ffuxm0edypgMscoMoZjzXwd2Vyqh9OGB?=
 =?us-ascii?Q?oEsn/3vXbJEDDomb8zbfbEHsuHjZl9tHTRBVHKh4PO2Oqeh6Tk8w4ADOy+Bd?=
 =?us-ascii?Q?y7uWkwVsPnCToWz/l8i8B4wZxa8rT5Yt36xrhdiwwXC733rMkWVSzR8cda5n?=
 =?us-ascii?Q?NtoFffoPhXR6FKatTwNJ2h0MckBlMDOMuIo64YTe3upzUF+2H5BKidQsmDDy?=
 =?us-ascii?Q?JpaVQSrTpSpFK45FRyqLVg8dv8/UEMdoIcdSL6cLDE0M5bvfyNEc2Tp5OLXL?=
 =?us-ascii?Q?pLguUtVCafgyRlPO7/LwdGr9WL1aaHuILAytWee4AU1VBonNw9r9t0h66sow?=
 =?us-ascii?Q?jW1hWF2cEngexWTYSYplBxVe5MgmBPj5Q+QvoOLwKOttO6wJKWpQAanuG5it?=
 =?us-ascii?Q?+5nnJLfk1fV4df4P0IB8sjIiRbFAyPVQ7YJN8Jzw6R2YKFJbQhi2k532n5dy?=
 =?us-ascii?Q?HI5dHwOCE0Kq2GG4FHvIQIkXQ8Z3bJ3hUhfW78ubw4gbTyLSBS4nPPfcju7o?=
 =?us-ascii?Q?uA=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 04955322-a33f-44e5-da4a-08dd2e3ae25b
X-MS-Exchange-CrossTenant-AuthSource: DB7PR10MB2475.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2025 10:14:19.8799 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I6Ra5tTaQvL7vyQ5RLTV8JIzw7Oj3qmqMl3Zvk/Dh0k1K2qI2KnhKfXWDLWM2vsvn5MXmU6NDr7q7y8MAaHgiNzWthnHyiBqM1hQR6r/1oI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6657
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

On Mon, Jan 06 2025, Jerome Forissier <jerome.forissier@linaro.org> wrote:

>> + *
>> + * Return:	pointer to the first occurrence or NULL
>>   */
>> -char * strstr(const char * s1,const char * s2)
>> +char *strnstr(const char *s1, const char *s2, size_t len)
>>  {
>> -	int l1, l2;
>> +	size_t l1, l2;
>>  
>> +	l1 = strnlen(s1, len);
>>  	l2 = strlen(s2);
>> -	if (!l2)
>> -		return (char *) s1;
>> -	l1 = strlen(s1);
>> -	while (l1 >= l2) {
>> -		l1--;
>> -		if (!memcmp(s1,s2,l2))
>> +
>> +	for (; l1 >= l2; --l1, ++s1) {
>> +		if (!memcmp(s1, s2, l2))
>>  			return (char *) s1;
>> -		s1++;
>>  	}
>> +
>>  	return NULL;
>>  }
>>  #endif
>
> This won't return s1 when s2 == NULL, will it?

Why should it? That's a broken caller. You can't call str* functions
with NULL pointers. It's ok for s2 to point at an empty string, in which
case l2 is 0, so the very first memcmp() is guaranteed to succeed and
yes, this will return s1 in that case.

As passing "" as s2 is likely quite rare, the current short-circuiting
of that case is pointless.

> Why not use a known good implementation such as [1]?
>
> [1] https://github.com/freebsd/freebsd-src/blob/main/lib/libc/string/strnstr.c

Licensing? Also, that's quite unreadable, so please don't.

Rasmus
