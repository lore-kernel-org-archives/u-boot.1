Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 379ADC982E1
	for <u-boot@archiver.kernel.org>; Mon, 21 Sep 2026 11:26:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DFE2880D3D;
	Mon, 21 Sep 2026 11:26:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eGoxr_wC1R7K; Mon, 21 Sep 2026 11:26:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 1663080D47
Authentication-Results: smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=fail; t=1789989987;
	b=EScN91On53LhepMOgN//4IksqUXSPHrVTTCKY5r/gcirZVGECQ2PDYf+omXfQgCqfPgo
	 V84tYvFRLmAFlKqSQbzpov3ZvsFkDBTZHDIsSuvqpRs3M7b8aakM3nh3HOhQAga4+DVyd
	 Vx0prL56eyc7QIjzmPpQDgI0vF0K7lUmgrBt52uNPCy4y1Il1ECDMIgXaXj71jlnhfXsu
	 sX/rwUuAn+U0xBsssdYSxDNCBThIqCMUayoM5WO9FyAYxGVwQJQCVlmUBoxxLNYY9AlFv
	 Kakhh/1DklMYmOcwXy4w12/Zjgl1AdFuxP4fhstNXS72xm+iY2y/0xwqQe3e5Lj/oiA==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789989987;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:Content-Transfer-Encoding:
	 Content-Type:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
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
	bh=dMPsN4JNTfq2cx9P6PZbikY8VJCNcX0Oo04LSlgRVwU=;
	b=OB++2980l0SySGMhDK3CR2+fdp824QFu35X7ry8BcsET20nUktGcIC0fHIYnNekKkXrm
	 Ft7SS+jFAz131fOog7qh1BFi8NhPWk5noHdGpVF4M1IMdL//Y3d7tYmKnrzH9V3r1vTfH
	 DHAlhVrMxPVM80MUwqEAOTmVtYCH1eJpHiezqVmMDH/YckNQVyrYN1AButjaYD/bw5sb0
	 DVy0XAY/Rr4hB77nai8Ewes6myDQZojMv3RGlC+Hv2WYxFRiwKbAQ3cbjBQ2o12fHwnnG
	 Qvk8q3r4d1a8QoMA6skKe9nqOSDtUWJnorwnzhy9ebZvKcY1aQOkMW/J5EmdaNnu5ig==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=fail smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789989987;
	bh=dMPsN4JNTfq2cx9P6PZbikY8VJCNcX0Oo04LSlgRVwU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0luMi4gsTu7pEiNu1xtB09lgVvw3bd6I3ZXuU3IW2Ad0Lgk3gIdJqx+t/VTybduDi
	 C4jLwHrDRBpYDkd7AhTCFe2scE1zfgEYcX7FRU05haqRS36plP6GlH9SkmLZCMqrsO
	 41tQH74VYSugW2D8NtET0/mSoFrlcIGYZQD5ADZQE6N2q16hXVEMsuV5NLDFObqZBT
	 ENKtHf41QKoUd1WnZNP0lLTfOK7T13CxII8UuY7EV8OOAbYJ6/JpB/CVWdFcPyy1bo
	 S7usg57iGAEN5JSVTMCrxL6FZVj6zzI6K1mStklmTxCeq/rEDYf4fPU9LQ/nu2Fi42
	 2b5XRo773LQJQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1663080D47;
	Mon, 21 Sep 2026 11:26:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6B49C237
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 11:26:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 511E040CC4
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 11:26:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hyM2VE7uT4AZ for <u-boot@lists.u-boot-project.org>;
 Mon, 21 Sep 2026 11:26:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 39D3740CB4
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::5"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789989983;
 b=N3tEcy2azjAPRjy3jfx4S4sb3D4gSNUu8WhqtDDrDXjEMwNPnt61NzGpQOJGut/VQgYQ
 LD0qQ8vJJ/EiCSC9rKMnj0oTH5/5IId+sBIwwiblUkxXcdp6VWb1zV8JzLiv7O7oevuHl
 Rf4qyVRdBDLsCOZ7jfI6Hn5l3/pjF6YKHbZYfifjaPyoFvsMB2yxgY4pyKCDVHllSi8pK
 fbOSVh+5GWXrKZLNzydsOZWurlDD1SntLTZvqKdBTu0uE7ccH5ODIjOu/EFsR+SFfeH5u
 jqqrY3ARDU+pLXtmIabZ09769IN1d79ajjj4ImvQZl7+X471dGfNnHiprQm1H/Ey5/A==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789989983;
 h=Received-SPF:DKIM-Signature:Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:
 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
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
 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
 bh=dMPsN4JNTfq2cx9P6PZbikY8VJCNcX0Oo04LSlgRVwU=;
 b=KkoXDpfIZC0N+F1EzUawppBOxm01XoYYARaP46iPUZMAcYGzg6qP1Pj6zakcDc2XigHh
 TIsmtySDgSzaJVhuHBwWeOEvgVWIwI6EoUifDpoEEL5Sk6QccRqSa6a0nmTtCYr5G42E+
 cg6iHTV/OTRY58kmfo42yzCqK0Gf04dvsLSsgO+Q1y0RPBxSZkFzfrvm9bHj0g2ayQdu1
 dX1VXPUvX8B+2I82ywLOmXQmRqqwGCvP4h8lxvZNfiGr8/quFtQXcBp8G0ZzIxzxv2Ghi
 mksxX2X4936yuW8vq9NjWo+9R1nJDhewP7w0zdcLR5s0JoWDLv9qTTIKriIMulblYsw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=prevas.dk; 
 dkim=pass header.d=prevas.dk header.i=@prevas.dk header.a=rsa-sha256
 header.s=selector1 header.b=RYuNQTcy; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a01:111:f403:c200::5"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::5;
 helo=duzpr83cu001.outbound.protection.outlook.com;
 envelope-from=rasmus.villemoes@prevas.dk; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=prevas.dk header.i=@prevas.dk header.a=rsa-sha256
 header.s=selector1 header.b=RYuNQTcy
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 39D3740CB4
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 11:26:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DDQ4Cnqfp5932yVHxD+NL4sX7Mb5bZtTba4dTSXNsbBe5O3YHwDJDcY3oE29PfBsIQzclDEy/BQ1WLLzr3IUzXTKevQnXPc5I3+3uYeLuikeKdlHozjzPf4YmisdpBVUnrF0TtWJyE8aJVn4+GpqquQkTzGEirZCPwCvDdevtGDPPEO63MAqLhBSH6Pvnr91u0KsBiijnS6qXS3RSCWAGOM8qH809Fds3ycqwcmiC2Zw+BKk/A6XoB5jo/BClblZuLOYGbaISBZHscnNqmepf+IC0T8udWmj+TGsIIZcVB3LDcri60ceNuMEg39hIhI763ZIFQOM9YjicxgLaZ4NtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dMPsN4JNTfq2cx9P6PZbikY8VJCNcX0Oo04LSlgRVwU=;
 b=uzhHhvRPOSr+WsL+RX3/M/UfaQlfowpScMZM07fgRxsak+aebDPgT/Dw9dttQElqVsltbBccUyaZRW+bg6hk3Ef2QcahqfyY1hHWHUcymTEZuMoNVEC3SkMt1T6wGVvuOKoer0Rb1Hen4UabmiQcUeR7VvrKjf2fMZyA4JULUE2EYGK+ctN274t4DNj9iLjYSbHU1G7FF+YzF8JpAQenrQsGIyoV9xF3tWF00Yhrmf7T3vrKZgaXzDgivB4gU2q7Hqx3SAKDXefmfKLgcJVlghJOdbLuS92NFSWxHcgSrM4ZWOtivDCie+l3ojKKp3QJMnnpDfOWowu3XcLHDHz5sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dMPsN4JNTfq2cx9P6PZbikY8VJCNcX0Oo04LSlgRVwU=;
 b=RYuNQTcyMQb/pzZDpF09jfloZZL40Qsz6KyteUz4r4lXArDWTymbvP3tb5xYC11pf1tMZKWamYxKv9ae7Thb2TTq+m65tMG8+t6GM7ZgfJJP5DlX741QBFUVet8iv/M/MGbMwwMVjT9TZK6K7kfUyS8vpbvO4xFiLRHJKkiELew=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by PAVPR10MB6863.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:323::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 11:26:12 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%5]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 11:26:12 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: u-boot@lists.u-boot-project.org
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Rasmus Villemoes <ravi@prevas.dk>
Subject: [PATCH v3 1/5] cmd: optee_rpmb: sanitize TEE_ERROR -> E* translations
Date: Mon, 21 Sep 2026 13:26:03 +0200
Message-ID: <20260921112607.1562189-2-ravi@prevas.dk>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260921112607.1562189-1-ravi@prevas.dk>
References: <20260921112607.1562189-1-ravi@prevas.dk>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0031.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::19) To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|PAVPR10MB6863:EE_
X-MS-Office365-Filtering-Correlation-Id: 697f899e-6b7b-4b2f-3c43-08df17d32455
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|6133799003|22082099003|18002099003|56012099006|5023799004|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: E5Vcp4WCB4H3vOv+NT+anUhoN4j8Qrxm79DNeZUmtI2RCKDUfo3fIM3wJpVvtooWXHbC1oNd7z5aOQRPgxqQpQa9rD761BMToX/e1SLV8FZjN4T4WEbZFgtHcD2rMZ5XhZD07R3LAW4MW7zoxx5lwuojRxtgJpjJwg9uhVoi9H8oMOf+4TXIOL+HN35mv+v9uKpyl1PBMlGq5M5uBuIcGzhf8xlzGTxuq5dvD00uzP6enRa80rG6hhZKtRIng1RA7zLmu0yRIh/1PfVKW5ZU45rvAU4W7NvSJJDp2kIlHjU2iFiSpcs0l0vwpZhpTe38JEVvMw5PlaolQJHzSMAaQWybJUEcWNmqlA3wCxRv8Ua9WaipxpLVsVN5UeUG4/sWCPgPNLS7F8UTktPbe3TfGoQ/rVBbsmSEL9SJC23YVcxxe+JqH7NIAcxMOg/qwtAleC3zTQw8UFUHYLgJZVTQpfNFt1KiPC5/G8nGm4a0wEWssIoKbxsVLxdZI3ibmefMzUSlyQoEVEVJ8Kr/oF/WVqIkGZpYfFVkGb9tXPJsEOCU8ZMt1eMXw1YzbPT7+Otyo1uCwhugyk/M3WDDwQ2lIkvX/EGaU2MKAkyTz4KuK/luq/tXVgvhpV2DEzEAEPKMis1BR0lb9Osw0erpHreD9mDuqic6fNB8LK9Hco8Kcco=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(6133799003)(22082099003)(18002099003)(56012099006)(5023799004)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mbGKpwhhMyJYf4cXUsDkTHW2KxZaIWWR1tFLGi0rLmgdKHcHV1eWUeFRujxB?=
 =?us-ascii?Q?fZ6JRk1VMV3wDZidM8yjFF1SU3gEkJtCeoQaWLPeTGzoDCF00H7mrX0WyLg6?=
 =?us-ascii?Q?CT0s8x0IY2lNCvXB9/hsUIc0HHF/X+eY0GmzexNUy3fqYjqx07UzRN/O+YWb?=
 =?us-ascii?Q?fSCD3Bv8Se3kNHXwfg8p5hYHEBLQggCVpFK7ldJXm8/7ihta7jlEF2UXJ2Qz?=
 =?us-ascii?Q?SvKG4MIjsxlFZtFxjUjSna9qzxQwQdWJ8W2UttIgrJinK+za/Hnxxa0lQbWw?=
 =?us-ascii?Q?WGs/0HfK/G1DOV4MgUWEdPM4+5otPFAuVaK9gW0kvfxwikklBSnC46fpjXXw?=
 =?us-ascii?Q?P1+snJz/Zr+gRWsMhqzRoNqzMySC6ab0Ee47wrN++/VFwjtjPX4faq88FvWV?=
 =?us-ascii?Q?/a4ycbOYHrwBNbDJKPX0BkMruMR8kyRriTL/XZTGYRz3qLetvD8o/qtPU1us?=
 =?us-ascii?Q?FwlvXtyqZsvgkT9Za1JCqnqQNXkloTlNkN3sqWjMJckO9Hg/XA36AIWSd6HQ?=
 =?us-ascii?Q?vyvb8O80h+m6CdRAJXgCyHw8SEA4AmhkA97NkPkvOuqjrvVJcuy+3JiRInf1?=
 =?us-ascii?Q?q6S9180va0o6QPTnDJcTj22u/4Cts3Ujf8GvFoBTmdB9lLpOOMmFGhZcvskt?=
 =?us-ascii?Q?uNlHxxtp455MVa6dGtpH9eBS69gua2c8CUJNVFCQBLlh4Tsj8KUFk0O+J4Pv?=
 =?us-ascii?Q?wwVtcqj1FW+FcemJBN5zoobpy4Cgoh1+28YNq6OsVzcfBZj0eu4eeoYwzZwb?=
 =?us-ascii?Q?ZwIHPBYds6eKgpmkMfAmxQ0pkrs902nze7gIkr7b9fpYcp3u2ungVGlnlWXx?=
 =?us-ascii?Q?xnIoESWKVJLrmX+XoyOPPf4AkblFczRJhGEbpTDKiO7v4uequNl1qXQZK0AU?=
 =?us-ascii?Q?5WTKZewjLnm0d95c8tlNVSWHwfKF8B4wZF9MascGW8kMgM1WuUfT7pKPdrJL?=
 =?us-ascii?Q?0YblFkVGcYvfI3xii/k+gOM0u0SDHnEdqdDwhFbBusy4/SrqInVkxgdd08JU?=
 =?us-ascii?Q?jWbbxmedXnNmqzMySqpG3vV2JMf3iQwybS6Fb8epL2hDXMdnvOeHpIgV5wI8?=
 =?us-ascii?Q?EIhrbLeQI7bO2c2vKx4qGWUDYnEUjf1cjyQTRqhkbK6v8luP+fY2n3dcjEmI?=
 =?us-ascii?Q?8mzu4mZuVIYGIoX3oATV8Geo8qJN/QChdAssPeLwGioTjOu2ogidwumFbBjE?=
 =?us-ascii?Q?NCvO4C80N8vUciExPsVqTzxgBrDMJQaiSQflYeuN514nIX2Zb+BPIP7F/vAR?=
 =?us-ascii?Q?jaIJMGc6M9M5LNbJ7FV8U0hCsdjnMnwnHtTT4dmfi8IRvmvEhrgtcV1tRNDD?=
 =?us-ascii?Q?IBlFGQ2FFKL6eLJedFS5pX8NcVOFSE6fUURVDkbbnqmKa6aaoq3FlRecvY90?=
 =?us-ascii?Q?lqGsDG+o+Z2awmhueBzDPJaDA88jo7mHXDeIdG0t00Ilf5Akci+r3Y2Ps4mN?=
 =?us-ascii?Q?PAkIXZ2ydWbSjD+dSPbKhpjfdaTW12VrbgOoK532trg14PMyaHdIUCaDD2hm?=
 =?us-ascii?Q?TVigzm+SmN8Fg5JQInTcaxgKP9wuFAgpmpllZpC0gZzoxqM/i09A9XmIq64G?=
 =?us-ascii?Q?TqWKt5y5416WW/nO0HSrOMiLlFtRtdXwKCP30IywCADhnnT9EzCanU6Kcj6X?=
 =?us-ascii?Q?SwEKYgmy7ktNhMoYWvTVHwxef0mb6Mun54SDe55W+8DWLllOuqC6ipzKqyaH?=
 =?us-ascii?Q?W4+O6OLWEGm2a5yHtQx+OW4XAXwYoC019gRMOe6++5IapziWeNVL1YM1h49d?=
 =?us-ascii?Q?XpB5sQ9XlMi2FpWTbTLsyomHT08M5zE=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 697f899e-6b7b-4b2f-3c43-08df17d32455
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 11:26:12.6392 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uSJsaauhNuZxxbZJMw9ngpj7JyCGstFlszDQNrLP497SoCrr4l+qi3FOiTq/fpj+AW97ml9EBu1p1IgMuLbgg19P+DXz5GqT81wRgrCvZbQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR10MB6863
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

Do not translate both OUT_OF_MEMORY and STORAGE_NO_SPACE to -ENOSPC;
we have -ENOMEM which is more fitting for the former. OTOH, a new
addition to op-tee returns TEE_ERROR_SHORT_BUFFER in case the provided
buffer is too small to hold the result, so also use -ENOSPC for that.

Similarly, -ENOENT is a better match for ITEM_NOT_FOUND than "some IO
went wrong".

None of the callers currently care about the actual error code, so
this makes no functional change, but we will add special handling of
the -ENOSPC in a later patch.

Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
---
 cmd/optee_rpmb.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/cmd/optee_rpmb.c b/cmd/optee_rpmb.c
index b155278ee2a..9a3274c4332 100644
--- a/cmd/optee_rpmb.c
+++ b/cmd/optee_rpmb.c
@@ -52,10 +52,12 @@ static int invoke_func(u32 func, ulong num_param, struct tee_param *param)
 	case TEE_SUCCESS:
 		return 0;
 	case TEE_ERROR_OUT_OF_MEMORY:
+		return -ENOMEM;
 	case TEE_ERROR_STORAGE_NO_SPACE:
+	case TEE_ERROR_SHORT_BUFFER:
 		return -ENOSPC;
 	case TEE_ERROR_ITEM_NOT_FOUND:
-		return -EIO;
+		return -ENOENT;
 	case TEE_ERROR_TARGET_DEAD:
 		/*
 		 * The TA has paniced, close the session to reload the TA
-- 
2.55.0

