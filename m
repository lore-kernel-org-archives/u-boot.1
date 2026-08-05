Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9D85C55ABA
	for <u-boot@archiver.kernel.org>; Wed,  5 Aug 2026 13:51:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6D2B4607C6;
	Wed,  5 Aug 2026 13:51:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id quzQQibu4fg2; Wed,  5 Aug 2026 13:51:34 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D2355606FD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785937893;
	bh=NdVnTAIDW1POx1E8fS4D4u6sR3V/wka05vb5Vs2KseE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PNQg2Y3FbQLeJnC35XIHZpUWwTSPmFBpJELewQbLiwLDkQjQozCbATyXeZfkt8wP4
	 B452SzQ9QZIbDP8i0Hc76zs8CxZYB7coRrKA8Hu7WLUHGtOQOHUme7MRwNlc/Hp7XD
	 cja1u04xCzw5kRrMTqUVR2RkzcTqU8VJUW978WdLytvwbj5zD75Q7h+dc0rqOlCyQ+
	 85EJnblrmvu9i31vmHd1YyaJC0p+wGbWZi+5uK86v3Y/Aiwr9FVA2bk4tTS8ZwqBkd
	 g1gdh3xYxdws3mxi6ROcOvrbUEjDOEKc9wqhe3FDxayY6tgWPCcF1zzkzPJwcE2hB3
	 5/P5bokN5Q72w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D2355606FD;
	Wed,  5 Aug 2026 13:51:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id B8559218
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 13:51:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9EFB7606EC
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 13:51:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id w7sk2cHqgvy2 for <u-boot@lists.u-boot-project.org>;
 Wed,  5 Aug 2026 13:51:31 +0000 (UTC)
X-Greylist: delayed 2573 seconds by postgrey-1.37 at util1.osuosl.org;
 Wed, 05 Aug 2026 13:51:30 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org C74D4605F7
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C74D4605F7
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=148.163.135.77;
 helo=mx0a-00128a01.pphosted.com; envelope-from=caleb.ethridge@analog.com;
 receiver=<UNKNOWN> 
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com
 [148.163.135.77])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C74D4605F7
 for <u-boot@lists.u-boot-project.org>; Wed,  5 Aug 2026 13:51:30 +0000 (UTC)
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
 by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 675C3AsS647478; Wed, 5 Aug 2026 09:08:45 -0400
Received: from bl0pr03cu003.outbound.protection.outlook.com
 (mail-eastusazon11012041.outbound.protection.outlook.com [52.101.53.41])
 by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4fv397ghp0-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Wed, 05 Aug 2026 09:08:45 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fd3BCSe/kLaKiLx4kaTVkLPTo/4yszys+UNpwkVjXUorB1tCX3KsDbQMelb277VWFGphENpV0LtFyTrw5AAF8UFLEznRQ/vrchXAnC4gICeOV8WB4oHDb4KxvyRjDLISVuDlpIHg5GUTRQ2PnedC6NePF2x+guZVILDw2ob0DOQp3rBKEhi1Fo0lvgxmtdQu13avU9LA76/ma4ZyPoMWRYIWk1HgtxfMqqCYSm3VkiVeGewDoQUDbFjLIoh2LNoxuQhDwufCJKGdfNUATI00rAAr/1mLYC65wCgZ5whhuftxdpcyuOqMRZtIsa+rHmxYQY/Sx1m+Gb2BawxSYR+4dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NdVnTAIDW1POx1E8fS4D4u6sR3V/wka05vb5Vs2KseE=;
 b=x1oBgL0z7JXfwWmi77nGFRgwD86wYP/aaccg7ZzhWV2v/AysSGpqIcg76lFPW4LedPn9uXoB9krlHDgoOrqdtrn+hNB123jSvZj8O2jkZcfzg1ojNfATw7budK70a183pCRA4qZDJal2UO8pkk0u+6Y/bmviGAT5Q2xy6aupYLhWg4q/yXHVTbGo0r0wkuHCMkO9fUItslYZJX5EBiBU6QvZkDf7eyg7qSBB4oK9llsWEe4rktEw5+YjSJm4G6UmQn24d8uSbirIT/FkgLXzLd0D9cNFMx3NobkI/Z+CydeoIILzm9dDg9j9Vn2syAwlWRUnZGkPUfvdNDiIP1Gzjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from LV2PR03MB989102.namprd03.prod.outlook.com
 (2603:10b6:408:37c::8) by PH0PR03MB6445.namprd03.prod.outlook.com
 (2603:10b6:510:b8::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Wed, 5 Aug
 2026 13:08:41 +0000
Received: from LV2PR03MB989102.namprd03.prod.outlook.com
 ([fe80::1d72:5cc4:f10a:1e3e]) by LV2PR03MB989102.namprd03.prod.outlook.com
 ([fe80::1d72:5cc4:f10a:1e3e%4]) with mapi id 15.21.0292.015; Wed, 5 Aug 2026
 13:08:41 +0000
From: Caleb Ethridge <Caleb.Ethridge@analog.com>
To: u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, malysagreg@gmail.com, linux@analog.com,
 philip@philipmolloy.com, Caleb Ethridge <caleb.ethridge@analog.com>
Subject: [PATCH 1/2] configs: adi: sc598: disable CONFIG_EFI_LOADER
Date: Wed,  5 Aug 2026 09:07:58 -0400
Message-ID: <49e3dc8237a789f7088852fde2a31fef22ff6895.1785934620.git.caleb.ethridge@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1785934620.git.caleb.ethridge@analog.com>
References: <cover.1785934620.git.caleb.ethridge@analog.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN1PR14CA0030.namprd14.prod.outlook.com
 (2603:10b6:408:e3::35) To LV2PR03MB989102.namprd03.prod.outlook.com
 (2603:10b6:408:37c::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR03MB989102:EE_|PH0PR03MB6445:EE_
X-MS-Office365-Filtering-Correlation-Id: f76f518e-1557-42e0-4f0e-08def2f2abf6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|6133799003|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: eoGUayLxaTCQXkSXZ7ni45hx50bj16UssuYpel8gMGl5deRb4+dgM+yoTG2yL//d/SJvK9V6XjK27eVjCLzFsaLWV6rhn4RJ1SfCH/tUSa8VKpqjROg+EQ+RHyUA6zTHpi5sdedIPA1UbX4nMFb+uLsQ5K6sYc1bRhQLEnDofcRhJhxx9NRv7oCebIalvr8F2OigqCVuQ4UfyvxSiU24oS0G9IHgHqYGq9JlOBu0Be1jBLYoLkadawkPJekCcVBLzqosnH3RQPTv1XOGbn5FxcINPb7bwTOIsZQ6uv0BmeKdbmsz+PfJWIntWMcw7W0UrNSHSCtdWtc5cBAFkYBZ6WAPsPZ5/pZh6qUKGjUrSdldYTuD9nlehftM1tEToJ1Pk0O7rt/RvxNDg70LfkbM9kRSqz8YY6nY4iqNAwFM1cLPfr0wSq+XfFzN6ChytlkKUWryFhOMt5me3tUQywAgv+B23ybHwJOVdg6wOx7NPhTqsJQTNczmara8RClAwG3XyK8yzGGSGfLvDpbeWXxi9k4WfufQFsImEItSUNPH5jKieoTQkQDlepKXJysndMBZeRRtLpDTYr27+UyLcdUdjRWZbFHtVt6liB3+/vmBEDZz2uwJtA/QMJscxdDjTAbhl8Xla9Mw9Bulmnfl4ZW6wbfGZPBBA5HlPji15B7m6I4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV2PR03MB989102.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(6133799003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0Atek6kkwtFECuBnIjQV2KqEIfN3VrFmiN8GtDm6Y2YcQJo3FB3PPAZ2R357?=
 =?us-ascii?Q?4OZtmYyNAp2wVCvPLUg6y+AgKq91lRxmkNuzHzRq3LNK/YUEWDMBoY9IC8nK?=
 =?us-ascii?Q?BkiK/o8uqKts12X9KM4EB7S94GPPRlMpsHnab5GUMCd4gmY7Tmxx2w0ffch3?=
 =?us-ascii?Q?k/dJ/J7shjv6Fh+RD+4z21I0Rby0Cmn3sZSVRfuctM0CQ5TZpO8DRtLfcSng?=
 =?us-ascii?Q?Z/G2PHQU1l/XIJz4e9MLNDBbgfjcf9AMBRp7qB849f1IlFTcifMtD6iMGuHF?=
 =?us-ascii?Q?Pe4VsK04/dSai8hWvQ1RM8fkoSqS0rE/6xVOUaa4SEsWUhypBA1o+rpN+5tg?=
 =?us-ascii?Q?krJfBcV7BVEzMMPLmtg5DzFjskFR9Oie0Ped/zzAA2gNMMLAPS30pVDiNpgN?=
 =?us-ascii?Q?qj+CWVzRQqNFmuXk+2T+hVr/dIHtoiWkE3lW/3YwBVtg1cLbB8QroPVgl0e8?=
 =?us-ascii?Q?OBDhY4EwKdG3XH0xI6VumcyWBzDgcTfuGq7bzKO8nQnw5I5k6GNmYw8axeyz?=
 =?us-ascii?Q?kf3GM1xu7q7bEUXy2ptxLXWsj8t8pzmGTcmddRg23/REneUhatfnovzMxmYD?=
 =?us-ascii?Q?grv1f2XdLbZkAC/1IJfOkkQ7+5XKIWlXWocDCQ2DPYbo/1U5tgQpGwc62jtm?=
 =?us-ascii?Q?Q1yaYjGVh37z11CUkoowCnlCU/H87wwWDJgFo5c2W/4d40LonR2lpuEqJ0jj?=
 =?us-ascii?Q?Ju4yM1wMhkl7UPOTTU5niJK0EQVHfROl+34VMiv94gFW0T0T8ZZ2DJ2STXBC?=
 =?us-ascii?Q?6PlJEk02cshse7RfkcF0vkauMEFeV5Tr3oixJCdn48Jkmyk4ykdFrPfHADdS?=
 =?us-ascii?Q?eGB24+Korw1UTuA4rSiJi0ynuchN2Om7NOn5jobyZDwepFT+fMXS6lXn93Rw?=
 =?us-ascii?Q?nMbjSXIHbdvoHgSEluzcOC6ge8kkRVGkbBLb1u0bi5Lt4swhbZ9dqOrUC+W6?=
 =?us-ascii?Q?W7+f+4j85HpLKNyAz8bwIHO904E2E/kv5GYe0TzEPZFbtRu73aSzwYQdMFZs?=
 =?us-ascii?Q?tS33If6rSd8A8JhmOjMmd2h7zMNyzSVDS/Phrs3GS0YqCCdOqjWFm8VzJmKW?=
 =?us-ascii?Q?USVyu0sM2J48Z2GmXu6mc3KlXWp8Cl0ye2h0hUqhd/o9nHOmxHEs9TNw1j0t?=
 =?us-ascii?Q?TxYQFK3PiHdEFd/9+IoU2Ph7n29oTaxl4uDjcoGmhGaMbupZ4opgxdSFhgtk?=
 =?us-ascii?Q?AR83jd9N00KkWyVngocffim2EDt61n5liDNQ/Zf8gJNYc5fZX9GDSXuJt4H4?=
 =?us-ascii?Q?/RE/FhuSwbg4Wr8Sys/l96cVHu1AvqUAJ4cjPYM9l0jqQk0NOAFuNykydEwm?=
 =?us-ascii?Q?fLVCyxXylQ3/AqFBZd3BOgef9wafGAfODm0wnhESvBomkKbxdvN1siaqdM42?=
 =?us-ascii?Q?ijuGg9IeJyeuj9Pwx20ht7DGWJPAP3Bc9iUD9Vt5M18hgHDpWQGpoTy1wou8?=
 =?us-ascii?Q?EEITCJL1j22ThfWOHyA44DaSKMosjmyEoD9j6T7KXDRbnREb/9L7i/Lau9Tz?=
 =?us-ascii?Q?EqsS6qIJh1ZSiIVMBhDYQpS6g694Yqpv3shYbsTx+ziqquvgDLzEXhPScQer?=
 =?us-ascii?Q?2jKcWtnGPEimNac5oGZulx2fnqIIBeCPTwFBaSoUST84hh5B8P9/hoz6jH6t?=
 =?us-ascii?Q?7gXJJI7GpLwqTqfXGZcqH1yYufSaUSgqZrHuRa8hlK9t8xzMhGawbehSeCzt?=
 =?us-ascii?Q?5pGWl318J5HjxppFtnEgictUUmR5CdvQJxS9SiKwjdI92EGPey5OLoZPCQmU?=
 =?us-ascii?Q?t7cM/AbsvWyjAJqALKoTcdbtxHhksd8=3D?=
X-Exchange-RoutingPolicyChecked: tD5lIyXPPZ3KXPhk3OXiajyuZ5/ZF/jPwgyyBte9w4Q0UNpkwpr3iVvAOpsp/cT/QnDU1eT+Gizbd1yf5EfM5LfYB0kiY0kjiXcZ2ib7H2OawLlQ+XXwDHz0oX4m+NPeLOlXOP2Z1wU+wwifrGSsKVL2qlUp1kvXE4lrb3pFHAGACsSs46x/5jdvb84BV4uU9zIhTR51wRxL1KC0qn53epJ9k+rtJYFV+Wed9fbnxbEqJzTmB3SbFecFLlHCIouobQ58REB7Hcora8jI0SlATlGcifT71MglAKL46Yd6oV9cfIKnYBWJhzwB6XU9F4N5YmjAVwCX05TZVH4p0oGSag==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f76f518e-1557-42e0-4f0e-08def2f2abf6
X-MS-Exchange-CrossTenant-AuthSource: LV2PR03MB989102.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 13:08:41.4919 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j9gFnjPcZ4cpxpa/SZqRysn+LGTNPnmLw+ae6OU+BUydRxQJNBwTypHlmHzRglIvqE46ewI2+kgONUThXrxCZVboSDlP0q0M5h3QjMi+NPI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6445
X-Proofpoint-GUID: Z2P0w-WCdZ5ZCyZKkN88UROLGQ7LFv_N
X-Proofpoint-ORIG-GUID: Z2P0w-WCdZ5ZCyZKkN88UROLGQ7LFv_N
X-Authority-Analysis: v=2.4 cv=Qv5uG1yd c=1 sm=1 tr=0 ts=6a7335dd cx=c_pps
 a=yZuzC5SkKTYVmguxKPWuow==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=OmVn7CZJonkx5R5zMQLL:22 a=gAnH3GRIAAAA:8
 a=PHwNFRM_nU-O8OdgQzEA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDEwNSBTYWx0ZWRfX5GnESWdDg2AV
 qp9vDyrvzBT5/lpgJGn9/ap6hzNPMhRTzC+jSFbRYkNxropRhZ3nWZHxUcvwLWmyJwBbeweJ+pt
 RqzDFGiayAl5g4iL3KPg4TA7qGDean776uw6CGa+G9+TSy7QDBIq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDEwNSBTYWx0ZWRfX84sVUOZMiU/p
 I8dDxtR1MlUfv8uAf31frSquRPXISA6uTkkf0hcrjNL7ygTDhqQjI57shvF52yjfJ6tVt3t3/tl
 bnucTrv9dRGP00zy4p7G6b82g05hJJZkChG/Q+hlTZzeNHIPyQlQlJfpXzIkDzUtpU/XlrHYERM
 WSXPAYhXZTexAQmindVDQsQrnMu7TagDuJNfN0v0qPWO/xhmfdm9YWJgbo1++mTkFwCi8YaaptK
 3DDIEglrrR3YIpa36h48YMI3b0z9503LbmqTwGRcog/mboxjfLA52cJhx9lbw+4z7B43cZ0DXpe
 2EiaGCKKR+Hovq9Aw2QJO0PBOZA7SipJOTi/u3F2MnnldAUqyG1zEWFmXgh2QCVfDPGS1ZyLcJd
 6ZGnEw6brBuCwW32ydOIzjlQ6EYIwmlWDDnGxpKeEjBv2ByhigWoMK/Knk1+5qVIRdcHGQ2mSFb
 6bNwQm60CygRc9DmyEQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_04,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 suspectscore=0 clxscore=1011 impostorscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608050105
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=DKIM; bh=NdVnT
 AIDW1POx1E8fS4D4u6sR3V/wka05vb5Vs2KseE=; b=BeVk712uS+JRwOXYGXE47
 0yWULcDZsgm7EMVIa2aFrGnZbSQSC3jzNm1p6zdxI6sf7D+1vkk8nco3OOBrE0+g
 645siuBZzCN0AO5FVbaA+zxK8ZQF5J5L/oKUzF3OAZafs+0Woy+07/ESVK0stI0g
 Df+YnBKqyItpLcEcf3KBM+rYKptjKV36bThl3jzAaRDNxpgMd6t3nKEIn5s36hZ6
 32/IR1t8G+In3JP4koVwh4st0fl1homefhnUYUbPv3RQ9+5BC69QmjMyZdqpwoOU
 lggo4kmekHZyTEolWWCHyWs7dVDJqHKOwDnSheuRmn0IJT1G7el1FqPzK3VwFPRZ
 w==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=analog.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256
 header.s=DKIM header.b=BeVk712u
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

From: Caleb Ethridge <caleb.ethridge@analog.com>

The SC598 boards do not use UEFI support, so CONFIG_EFI_LOADER brings in
unused code. Disable CONFIG_EFI_LOADER for the sc598-som-ezkit and
sc598-som-ezlite defconfigs.

Signed-off-by: Caleb Ethridge <caleb.ethridge@analog.com>
---
 configs/sc598-som-ezkit-spl_defconfig  | 2 +-
 configs/sc598-som-ezlite-spl_defconfig | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/configs/sc598-som-ezkit-spl_defconfig b/configs/sc598-som-ezkit-spl_defconfig
index bf001459831..1c6e4ea613a 100644
--- a/configs/sc598-som-ezkit-spl_defconfig
+++ b/configs/sc598-som-ezkit-spl_defconfig
@@ -32,6 +32,7 @@ CONFIG_CDU0_CLKO10=5
 CONFIG_CDU0_CLKO12=1
 CONFIG_CDU0_CLKO13=3
 CONFIG_CDU0_CLKO14=3
+# CONFIG_EFI_LOADER is not set
 CONFIG_FIT=y
 CONFIG_FIT_SIGNATURE=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
@@ -110,4 +111,3 @@ CONFIG_USB=y
 CONFIG_USB_DWC2=y
 CONFIG_USB_STORAGE=y
 # CONFIG_SPL_CRC8 is not set
-# CONFIG_TOOLS_MKEFICAPSULE is not set
diff --git a/configs/sc598-som-ezlite-spl_defconfig b/configs/sc598-som-ezlite-spl_defconfig
index 09fda4f4ecc..b3c347c6804 100644
--- a/configs/sc598-som-ezlite-spl_defconfig
+++ b/configs/sc598-som-ezlite-spl_defconfig
@@ -32,6 +32,7 @@ CONFIG_CDU0_CLKO10=5
 CONFIG_CDU0_CLKO12=1
 CONFIG_CDU0_CLKO13=3
 CONFIG_CDU0_CLKO14=3
+# CONFIG_EFI_LOADER is not set
 CONFIG_FIT=y
 CONFIG_FIT_SIGNATURE=y
 CONFIG_LEGACY_IMAGE_FORMAT=y
@@ -108,4 +109,3 @@ CONFIG_USB=y
 CONFIG_USB_DWC2=y
 CONFIG_USB_STORAGE=y
 # CONFIG_SPL_CRC8 is not set
-# CONFIG_TOOLS_MKEFICAPSULE is not set
-- 
2.43.0

