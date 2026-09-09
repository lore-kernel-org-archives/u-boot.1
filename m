Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C371BC79F8C
	for <u-boot@archiver.kernel.org>; Wed,  9 Sep 2026 05:29:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5A86D606AF;
	Wed,  9 Sep 2026 05:29:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4TWC7C-SZedK; Wed,  9 Sep 2026 05:29:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org A8828606CA
Authentication-Results: smtp3.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1788931757;
	b=cbftyoCMIkQi/HbDlCluJYrlqc2rF1rjarttieAIxm8TMOt6K4THvgq2tce5OD5h1iEK
	 vxx1/pKUBDbfEgg4LBokWz/+BweJI4buCLIWWRJkMS9NRHXDPR3REQHtskUFGlSjpEhJD
	 kpC+hYvCuEOWfLkUNXCKHWR9V+GWpKA49T6oll55IxdPECeum5Nxrb/0KHq3lvDZG3n/M
	 KXWhebpfvwyauqd1J0uYsRadF3JmUys3sUYgoRlygXypvec3hEXvVJpXcRUyMEvTLwDKw
	 767cuxsoRnVHro+eh5jsILPexOKfKBstER3a38WOgZl5dR/v4KGNoR/HwJyFZ36MSpg==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788931757;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Message-ID:Date:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
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
	bh=mbsi6+IXfg2oZ+bt2Qoqc9moxJ/GtjcN7pb3a8LKYp4=;
	b=Ivw90si5tPj53hp6tRWYDGZ3c8iBMwuGEkNGLMXKLZ53D3CzzQRFflwtKuyaxlb9xSG6
	 us4dvNxCcFGgjRDBsNWMZHMn2Og5xqaKFCthSjGjE1QoNk5o6VSUSGVTRYSw/6cy+WrdD
	 9zyi+YEa7I+J7Ar58hwRlMuq9dw9DB14Mvb5vETpqJP9q8YUpIv0+/F56P3XIuAiNvKZ6
	 8ALPnz7o1mZ1uZ3Q0yxR773E+B58ClVkua8hvXggPO2k9pppGsw2YLPSDUfsM55bvXvwl
	 0skRMQX2ZyQLWliXtQD3kkuMI5j0WY4PkQoz1rg0RVU8HtM85icNjecXa3EESQP3AeA==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; dmarc=pass header.from=altera.com;
	dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256 header.s=selector2 header.b=DoGSk5CR;
	arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788931757;
	bh=mbsi6+IXfg2oZ+bt2Qoqc9moxJ/GtjcN7pb3a8LKYp4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=R0ZA1SFzuzHqelLk4CbJk9k0lOqKnpKRNr4p7u2ZGbUGCvl/RWdHIgmGapuKMXsJv
	 ClDCIXXOhGUYdDcLUxLRU/LC6SavK86LiKQ2tHgEcNpRqu5cGZkoqHxxiW3A04Ata5
	 vPt4X9IxtLzBDMFk8sEJv/QCVNP2rweHV1WFNDTkL/bIr6Ti8yVT9PiVF6Vx1eauYa
	 qU37Sj5AY7FwDpj29BQgAnQOEfF9AOTxnS9kIid61Onjum6crBXxr7dPdyECc7boZu
	 S2pDy+xgi9/DIk3dpSHfcRxT6nNXhfRByeJGfiDf/pepV973GPuRTUzxAtn5Wl9NtF
	 DBE7/+CC5mszw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id A8828606CA;
	Wed,  9 Sep 2026 05:29:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id B5A7A29B
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 05:29:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9B6EC606CA
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 05:29:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ipWqQ8wQtmlb for <u-boot@lists.u-boot-project.org>;
 Wed,  9 Sep 2026 05:29:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org B85B8606AF
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c107::1"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788931755;
 b=NhQvVwKOa3XKqsQNenAQpSDMoarFXYZOURegEza5n7DWYPWcIKXVh4IF7UYUNNu5yqg+
 dJ2u27k/NOfbB/dzaWy1Vhp4ch33uxAHGTyrnguBi+QtA7vrLL1btS/uVmYxmjXQpG7kl
 BmGgZd1NjVVIhpBfBeXCRUkZQVEM2I45A9QvW6gS0HSK48Xw5yy2WSu4DXT6CvDclYKMf
 T8FEs3mRC4MRmdx7PZAfTPiEnqbc+tLgss7FQfsY/0xXr+nvsR7HgJ+lqisUNuWLu2loN
 1s2UkTzL2D2tZhVf85v52mT0LwHSsg8FYyYGnsiCRx47ulzMNtHuh0tqhvzqrv8NWgQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788931755;
 h=Received-SPF:DKIM-Signature:Received:Received:Message-ID:Date:
 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
 X-MS-Office365-Filtering-Correlation-Id:
 X-MS-Exchange-AtpMessageProperties:X-MS-Exchange-SenderADCheck:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=mbsi6+IXfg2oZ+bt2Qoqc9moxJ/GtjcN7pb3a8LKYp4=;
 b=tYJJj7P8wnuW011He6VJ58/ny8mCwrh+xvlqpBpE4JeO2YPBMR9wDiTazRJhejn0UJF0
 jslU3mkzEYjyGVwhCsm2sa25hoSsLRrHYNq8rZ6GMffHYWXbrzLNdb3DLsT5AHUJiosxz
 8Lbd4a4z4DTAKkQalfzklnx7/5tTEmBfL4r0TrShWvTx7ssAkHzKDYG9rhrUogLRlVkaa
 vKeoDawckfrEo1FKmTIeZPqhU8RQVNOknlTAyNXNpHMVNj/E2GzhqNSVcJISS1yh/6LH2
 hw1qJO0XI9eyKaAesZeLL018bZiqL/CsTukvLyM4Xg8hZgJsyJ9Nm1hdD9Zw/YPPH6Q==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=altera.com; 
 dkim=pass header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=DoGSk5CR; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c107::1"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c107::1;
 helo=ph8pr06cu001.outbound.protection.outlook.com;
 envelope-from=tanmay.kathpalia@altera.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=DoGSk5CR
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B85B8606AF
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 05:29:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TEskXfokX1bw7YmOXBYWcXYt1NzF8wOrW5Bo2KtF22lYgLh+1j2o2xHJKeCdTDm3ek1wLLVkfuPnrEw1+MZNLvky/hgWyL3rdlBI984u6eJ3hR9XxA7n9q/LzmG//8Vub+g+5cYy/tUAXrCSQVd43QpcaGug/V6uDdLLz0t1HZOe65SaBWGYP4IzJheCjaE8WJHgjqTgFp+FhdMlLP4ZReqXOP5NKRewx/t5EPflGnfm9zZ8xe2dhrUS4OgSgcOvFjT5r5vRB2E+0mHn8uRRQvjiUAl+dBFZwlK5U1HpeE9u7gcvOSzNX4oRtA0yi9UnYj6k8TdBrnodQbMf9e4XzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mbsi6+IXfg2oZ+bt2Qoqc9moxJ/GtjcN7pb3a8LKYp4=;
 b=iBRGY6xEnsEBmSAVNtKjUIGZbos3lOgpflYdmen/1yLCiiLgLVaFlsN420QDbUrjsNsXpCgzD3RrNP7d6cq0RnOIEbDXa/Y54jtOxu0g45lC6kUvxzSzVhN5EFjCR/r9FNsJUsP2BaurmQe5q7s4zPBxgnQgCzpERcc8vcBprgyqZHcpzPi4MkLhRMDs688wjsLuLVShUik5rilUIqjKHCVEEupT091qeIvhfrlUJl25g33wghpdJxf0Zdpc4N9w7bGhtqrNQx1OUryYLmjQwNbB6f1Tf4psdqjJsY/pivIX/ofkQIbLrfergliUDIttZz5mZQtNid84VlptR25Fwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mbsi6+IXfg2oZ+bt2Qoqc9moxJ/GtjcN7pb3a8LKYp4=;
 b=DoGSk5CR2g8Qvt1fWGI90rlbQioydmKpHJz66kSYW1ojC65OzSIOIsvtwYSYgSg8KbcRvxCgAAf6c3G14Wz6sWOxT1Hc7k5B/ulhf91gZ60Sh1wz4yFBVZJ3d4YUZGhUCu1iz1842oUR3+LcPz5J3ZmjIYUEB6FpPrsW9NEtbt0M93EzCUMcZ5YU9g8XMsVOiIqdf5rzUAvvA5GAwPWn4GS+7x+gzmi2L2XwGDNww2Ezci3w2EaDVz0Qwh9RNDmLXTlmRsrM4zVhfnzguSDCur8bqrUPGf3vuWV+3vriFPEjtoPSNMRC2A+rFXCy8TKhK/SJCgaf/fiodnBawh/Rkg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by SA1PR03MB989317.namprd03.prod.outlook.com (2603:10b6:806:4f1::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Wed, 9 Sep
 2026 05:29:07 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%3]) with mapi id 15.21.0406.005; Wed, 9 Sep 2026
 05:29:07 +0000
Message-ID: <480e5a19-e0e3-4b85-a09c-c4f0cc1760f9@altera.com>
Date: Wed, 9 Sep 2026 10:58:58 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] mmc: Make "MMC Device not found" a debug output
To: Jan Kiszka <jan.kiszka@siemens.com>,
 U-Boot Mailing List <u-boot@lists.u-boot-project.org>
Cc: Jens Wiklander <jens.wiklander@oss.qualcomm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sai Sree Kartheek Adivi <s-adivi@ti.com>,
 Alexander Heinisch <alexander.heinisch@siemens.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>
References: <cover.1788879818.git.jan.kiszka@siemens.com>
 <3c69f2bdf4a455ab8f0fe686e19e2c1a24c10721.1788879818.git.jan.kiszka@siemens.com>
Content-Language: en-US
From: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>
In-Reply-To: <3c69f2bdf4a455ab8f0fe686e19e2c1a24c10721.1788879818.git.jan.kiszka@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0233.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1f4::14) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|SA1PR03MB989317:EE_
X-MS-Office365-Filtering-Correlation-Id: 65f22af9-424a-4733-fff5-08df0e3344ab
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|10067099003|55112099003|4143699003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: pPpfooew3xAVbAbHnMVpKiP/ns43BcCK+xfaP1Wt0KK6G0Qv7WcvW6SFu0WW1Boi+yLkGV1eb11JjZJDGkIAacDH3HmkOIqI8zC9zIokiJm/0WDH26RJgL39n+z9NeQe0bKLDyB8udY4Qmh9EceZ3kNrHl+lvLtlmoctAMiMsp9ozuStXt5Q+w0C4Fci59Uw1M7ppJGbwd/eSlH+w/ialtfdHUc8XX51E7Tzu+9Y76HHSi/F/u7jMlOeRxOXMxwWZI/AmOjEB0I1AM1cYmfxaErVHOGjRsgz6xqUXDblsN2gX3DecwIq8PgxgaHOsUbKoZ02pMyhT9m7AQv6OUjvYH8PLxSoL/cdTXWn8fo+kzycv9pp4Dap/E7Q4c/jsse7HJBBaI2qClDQin3i/WoR2Jdca1MhkCeDEHCSFaEOm3vXAsLRWUsNpptYwFtMVJl8zdrcmNMd/E+MOzEKMVQlAmi2vkZDRWC3SADSokenfaHdLZ6we/lcMy1GNdQgafVeBq2sr4lN+ZzTkYNAuIl0/uaI484yMKRgqfcbccBdQt1z4oXKyaOXWsGspV5kH/rCmtkxGkv6q6bLH3vg952B27WOjTXAbpwh7EWVC83lHZO1N0rJ70Ou9VwY06bMqIfOQpXRNg+PsjT4NQQBbtlV3cJkaDbDLpOl9JVEcXGTQH0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR03MB6208.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(10067099003)(55112099003)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dnk4MTlYaXhRTTMyYis2THZCayt3aEYyT1NUMTlpQmZIMHZRa0V6T29EMUZL?=
 =?utf-8?B?ZU5hb2dyaFcvTmxJZy9FWlE3RWZMM3loZ1JUTklMQ0tQRkRqVnVwVlpKNzdy?=
 =?utf-8?B?Y1h5bDM0RTh5SzQzQlUwK2xFWCs5dDV6bVlrOUowYW9RZk1FdlJOMmNPVTE0?=
 =?utf-8?B?NUtuQ3lXTHo1Mk1YNTZiN3Y3SWgvR2RML2tCeW5NRmxNaW9uOW9kNnZRcDg4?=
 =?utf-8?B?Qk9wV1VSUzhISjErN0NMOFRqZ0hIOEVRajVGOW9FejhjcWcvWG5qSXJBVSt2?=
 =?utf-8?B?cmVha3d5SCszR2xDSjBzM2k1cmxtRThhd1FUN0lLOU9DNmJHVVNTS0lTcHpk?=
 =?utf-8?B?NHkzaEFmSkNERVZ6aTdPN09rOCs4RFpXb2dVL1Fqa1VHK29vWDlqN3RGWUVY?=
 =?utf-8?B?Zk5ENm5CdEF6SThkQTdYZDlVbkZzb2RWQlUwWjBON0RTd0hiU3ZadGgzU2Jk?=
 =?utf-8?B?aHRDTmFjMmJjYXZhSm9wR1ZZTTlNSi9TbXRKa0RaYnR4TlVHSjVrVUcrdVhH?=
 =?utf-8?B?TjdTWDVGdWJKd2ZWSmZmZ2wwR2JOVS9UNkVqTGlNbWYwNXpEcXBhODFVb01x?=
 =?utf-8?B?RnRkRDJpaElKZi8wQVdOS2dQUmR4b29lZWZVU1NSSlNMK2VtU1VsUnlHVHNG?=
 =?utf-8?B?THNTNHJLM2xSWmJ3dm1mYWtJRkxsZVFFcVdWc1h2bTZDMFZwSXp1T2hhN01m?=
 =?utf-8?B?Q0tlSVF0Uy9PT1BVTHRZSTc2OHdDaXhRSWJVT2hYbC9yR3k3SlllY1pEVktk?=
 =?utf-8?B?UkdlN2JIa0FLZXEyVVJXcTA3aHYxaW4wcGZvSEFkbzJrS3FMQjlzSERuR2ZV?=
 =?utf-8?B?dmxYbHBYMm8vMmNBZ1hwVW9GbVM1dUZPQXRyWWtFUUo1R1VteFVrQ3VxcnlN?=
 =?utf-8?B?NVFKL2IxdDNSSWI0a0VkT0VaRTlEZUxGTjlQNjJhajVxc2Ruc1JDbm1hNVdM?=
 =?utf-8?B?VGE4bkVDUEw2TE9NZW1ha0kyeDlkOVFPTU91UUtlcml4cE8waUZaOTVFTzl1?=
 =?utf-8?B?MDg0eTFINGI4eEpzVlYyTTdoUkIyOFplNjA2RVc4K0k0b2E4NmRKUTE4dGRJ?=
 =?utf-8?B?VGhlQ0NNRXdpaUx1S0cyN0FqcXFyNWxMUE0rZ0NObjB6M1piTThydWhrTlFp?=
 =?utf-8?B?UUVrcFN2SzJSQUN4SWdEWjNsZmJteEZXSGhlbWpQUE8zWW5tVHVEam9nNzVD?=
 =?utf-8?B?d2dyK3JFbTdQT2ZHVFlWbjlBdHBZYi9DT0hZNk5oNDN4RGQyb2krZUQ4N2pM?=
 =?utf-8?B?NnhzN1Z5c3BYL1hRTmFwV3d3Skt6Y1l1aXJKbXJsNTlSaXo4VFdQSXFqSnBU?=
 =?utf-8?B?SzFQSkVETmVadUdlTGdHTnhMbTAzY2tNVE50cnljZGkvTVNKeDVCbEtJMVFW?=
 =?utf-8?B?QVJxbXVvUnh2dHJNVURjZkRLM1hHSjRQbnRUMGc3Mk4rYXdLd2pVeUhhbkU5?=
 =?utf-8?B?Zk82d0R2bi8zZ01KaVo1YkI3Z3JpTCt1UFJsRGIyVWNLOEEvek9XcWNKRVk0?=
 =?utf-8?B?d1BXbW5IanVKd1NKTUQ0R0RMT1FwS21tL2dkcWpsbWl6RHlrclRRdkJVK3Vk?=
 =?utf-8?B?RENsRU5nMmdOenkwTHNLU2g0R3NETjJjMEUvZlJjOEJwZ01yamxlUE14bkt6?=
 =?utf-8?B?NEgzaG9KNkV3dlVtMGNNdGczcER6bnVEQTE0L0NpVWZxbUJYWFZ1RWNNZFpk?=
 =?utf-8?B?R0NRQ2NYNWlkRmRteG55NFd3MTh4MkNXN3BQOUhmVkFtM21FSDRiZUtDQlor?=
 =?utf-8?B?ckJ2Snpnb2hSZGhXVGRiNGRSdlRuSWZFK0VRUno0dHV1d1JaeXdaMFZ3Z01I?=
 =?utf-8?B?bXZmZmZVT0cyRVM0Y0NNaG9iRU16aDVoL2JJUTBaR1dZaGlsQlJlSEdnQXNG?=
 =?utf-8?B?SDVJSmgySDBXOUVwdlpMOXlYbXBqbGhPbEpoKzlreGEzN3NvbDREc2tEYUdp?=
 =?utf-8?B?bWlxRzEvSTlENmZDU1FPSVNFeklGek1Fb3BzVyt1UDN0N2hiT05wc0YzZzVx?=
 =?utf-8?B?cFZRZmNVS0R2bEdlWWdvNE9oa3NCOGVkZGlXTTY3U2J4Q3h6clg4Rjk4RXlF?=
 =?utf-8?B?T1c0enlKM2FiaGlnamdURE85aFoyL1RxWThsWTBCSk9SMVZKR2hTRVZiMlZr?=
 =?utf-8?B?UFpTQStlUTU5dVNYVEhjNG94WThYcmVaMFFqZURuajIxUVpGRHl3cUFaZWs0?=
 =?utf-8?B?bzE5azkxazRYV1hlV1lPZ1RkVTJ5bkFFSUtCS2xqME9ua01tVU95QWNmZERQ?=
 =?utf-8?B?d1FLdjVYV1ZSOWg4Vjl6WVRkZ2xyUGJPZFBuZjNXQUZlTUV4YUNDYVA2Y2ox?=
 =?utf-8?B?emJjKzZ3VmF4Q3dlTkdIYk8xU2JraFlDb1hlQkpiWE0rZW90bjNCVmpucFlR?=
 =?utf-8?Q?pqZFxUeGJ5Yqbq+I=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65f22af9-424a-4733-fff5-08df0e3344ab
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 05:29:07.5670 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ANR9pmwJjuWTRkuB+ELWqmLKDJjeBiqb0IHwvsbSXxhUTUSeChpLY7X5b8hy9KO0PAiE/PCvq4cWuZEaGDMR1lo5MNRTHy37Y47ung0FXVo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB989317
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


On 08-09-2026 20:33, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
>
> Callers of find_mmc_device are generally processing and informing about
> errors already, e.g.
>
> => mmc dev 2
> MMC Device 2 not found
> no mmc device at slot 2
>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>

Reviewed-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>

