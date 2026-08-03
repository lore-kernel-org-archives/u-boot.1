Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18F25C55175
	for <u-boot@archiver.kernel.org>; Mon,  3 Aug 2026 09:31:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1349680CC8;
	Mon,  3 Aug 2026 09:31:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id abC-sm_8YWg3; Mon,  3 Aug 2026 09:31:00 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A475B80C69
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785749460;
	bh=1XGsASI5u2+eFKOq1vQGD3PZtx5Rhc7mjg38eaRjTt0=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=b1LAkH0ws5jHlFQ6XRcoe+P3YOFpBWnDVNoxMxftnvRBTmapyPCOT9moLUUblioL2
	 PputZBQfd3etm/wqOyE+kT7FMGYsjAH0ZoOQ6Mtunb1vQ7Y+2CXD+jP8/C9CL6SG5i
	 a1FMU3NGPAvA62/N8awFVh6m7eGCRKI6pGrAYKIuCPjIhkCEoiNEyVpRMwjxRAjr7A
	 bQY8N6O2BaKRHiEOk/y2buX/Yrf3VnvqZyGfNHl4LMf8essgeEnqBPJWKGUJpqWtbZ
	 ilkxqWsPYAZ3pS431nGYp2yj97SKSP4J7ibcfbb1rvEPHw04aJpN7GWKDhcFs/vjOv
	 b8IkvyaKEX3fQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A475B80C69;
	Mon,  3 Aug 2026 09:31:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 26EE836E
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 09:30:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0D65940077
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 09:30:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hOC385-QmaK3 for <u-boot@lists.u-boot-project.org>;
 Mon,  3 Aug 2026 09:30:58 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=tien.fong.chee@altera.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org DC69040024
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DC69040024
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DC69040024
 for <u-boot@lists.u-boot-project.org>; Mon,  3 Aug 2026 09:30:55 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id 617C3846E2; Mon,  3 Aug 2026 11:30:53 +0200 (CEST)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4161A80087
 for <u-boot@lists.denx.de>; Mon,  3 Aug 2026 11:30:51 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F8PtTeuA8lQIpelTfDDgA7IFnJBhbTKj+ERbGP/F16wHSqepMUfSclfmWipWyJVqrG1LmGat136hd2NlGUO/cMeH0whEquNOP2R6wmPTcmxI9q7B1tPSdT2I5+yzMzPGyknvi7Ra42Jj4pmRR5vqQLFeC9MAwwHKL7pDfmWF3/QDzQmp2+PICi6fM1mz5fNoqR4GTnfiuu4XZP2SKkoNsb2JA/++c5C0ZRCu7o6y/TsHFSf5hv6znqhoe2hJ3cmDmd6GhQCSD2BIx3TOH3KNy9y3oteetVWlCiqHs9//lb0MQgnD/OEMz4ee7+Vh5NMsC59+muNxZztZ3keorJgI6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1XGsASI5u2+eFKOq1vQGD3PZtx5Rhc7mjg38eaRjTt0=;
 b=WMkCRyPkB6283iUzzqvCDANO6GtAe6QkXLEnWZTbN3NAxk/toV7ojPYCdoNHJEYNDjTFY4k+o4HWeI87dSMuDW7e6IObPku9uW9s32EAGKC7wSKZvKgcngat3RLE4JYmCo6Pu206mT1O1l+xiHCC//2/19LE8UqmG7gkhwnKaW8e5xX7CJWAwiWaC/pWREOxo4RQvzNuXmzmElw1kdhtBwhrTL9n7/K30Gl7S6UczTdExpFV+ht/YTY7dmrLNADWUYeqEd59NZdj28rlSHuk+NNxjzelK3wEqonz0p1GBi6BNYFG4x18OZRCK/PzDGqxtRsgsXHaKicqV5xJT8/E9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
Received: from SN4PR03MB989351.namprd03.prod.outlook.com
 (2603:10b6:806:1ec::5) by DM6PR03MB5306.namprd03.prod.outlook.com
 (2603:10b6:5:243::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Mon, 3 Aug
 2026 09:30:47 +0000
Received: from SN4PR03MB989351.namprd03.prod.outlook.com
 ([fe80::5d69:ce74:a67c:71bd]) by SN4PR03MB989351.namprd03.prod.outlook.com
 ([fe80::5d69:ce74:a67c:71bd%4]) with mapi id 15.21.0270.016; Mon, 3 Aug 2026
 09:30:47 +0000
Message-ID: <6d676a87-3618-40b3-91b5-37add5159371@altera.com>
Date: Mon, 3 Aug 2026 17:30:40 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: dts: socfpga_n5x_socdk: Enable watchdog0
To: "Maniyam, Dinesh" <dinesh.maniyam@altera.com>, u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tom Rini <trini@konsulko.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Chen Huei Lok <chen.huei.lok@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Boon Khai <boon.khai.ng@altera.com>
References: <20260507005505.3917-1-dinesh.maniyam@altera.com>
Content-Language: en-US
In-Reply-To: <20260507005505.3917-1-dinesh.maniyam@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR06CA0002.apcprd06.prod.outlook.com
 (2603:1096:4:186::10) To SN4PR03MB989351.namprd03.prod.outlook.com
 (2603:10b6:806:1ec::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN4PR03MB989351:EE_|DM6PR03MB5306:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a92c4d8-f37d-4af8-1a18-08def141e63f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|10067099003|11063799006|56012099006|22082099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info: Lrv8ctarxhyJrFXrwAoXDeXdYIUcwbYHKE+3RGLAmGuPZKrWILGA+bumHEqS/BWqOQujjJponO8nyp36//8f0SJTaedCnKwZQBjwy62YNaDiYiqhlnY/ctf9iECx5XDSxDaRydNqgp3moO90ImT3qmYp4e0vBtEiEG7a9L4hqQebS0lXdWl8LaLIGI+nABodMsq2oJDs1ac02no1CBSqG7aBgf1bGkOBmcufAAuRPTLh5ZEdJAA2gDfv36BAlUTMKwd3ZyrEu4O6NgbH44Hy0FtxrSUS+lh3vIBVIiGoCTW+wK5/peGQ33R9EVEWj4T+F0BmXUM3w0fyQLO1Tqsc6VDKY2TdGFJQIRWcCs8Mox/yCF+iX4xHnUJ7nNzdZPqvKqLyqVY7UusJW9FJbeKeZhxT/VSvNFhSbmU+XjfS6W8d6RxmfFx3FItQzbBhU2Dt6XKIoGajVQBnMlFL/vh10S/ppn/3XrDitdTFMkx2TJGFn5/HG68JPw6poAhMo+/dJzu8bZ392v3lbz7it6ww56FCV02/nEzssmMHbiKtrzswR/CUmbR2S+AyXhPlBJCNXoSmh3DM+Q0ZNV17L2DFDHTEhsDUTyv1Y+HVmPj4VHffbQrXbgsIxDaOhNlKDqu/XLjJtiYUMfsCHXOj4aBi1piRU9KPP9wJWZvl+EC+CiE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN4PR03MB989351.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MTBNdWkzTGlUTk1PRnVkYmdrR0JTcGVoVS9IUEFNdEtGdGRGN2xrQm8zaWYx?=
 =?utf-8?B?eVZDTGM0SDVwVVF2dmdPSFBZWEZJN1MvSFZ2d0xKYkx0RWpBN2R0QXN6cHJD?=
 =?utf-8?B?NmpLbjM4MkhUY0pLOERRVC9YUWpoK3dnaURLejV3Z0hXbnczT2ZkMWNDcTln?=
 =?utf-8?B?aUFGWXlOK2hOUXF4cDhwQW11azlHSjJKSCtMNDJMUU82YXNvVzlZN3d4RUt0?=
 =?utf-8?B?VEFmNkxmM0hsTEhYdHZQZHB4ZE5IMVl4Z3pxOFRIUC8wbC9DVXVhTUNDYWw0?=
 =?utf-8?B?QzBZU1ZBMmdSQTVKTmwvMVBDUWQvR0U1azMrbGJwK2ZBZTJKc29LTXI4Q1Nx?=
 =?utf-8?B?dFBxWTM5cm1oV3B6bFAxRWhTRExHaXphNm1yWEJ4RThNL0NwZ0FLRjRqZ3k2?=
 =?utf-8?B?cnJDbTZMTUlNQlJIRHVxTUZOWndueitxT0NxaFJXQ2cyN2xZTXQyZi8wcFc1?=
 =?utf-8?B?ZmFoNnEwd0JpSjV4amwvYXQrN25RVHdWT3kwRlV4dHpsS050QWM2c0hvY0Fs?=
 =?utf-8?B?Y3B3NVprU28yZ2tSZ2Z3dTF3enowQjhjTTJhQ3Vrei9oUTd2UUEzazJqNDNL?=
 =?utf-8?B?NkVvWTlRZ2NzWVJYVjNhYnNwZmxMREJMc01iSi9oWmhVenBkSFFGUmNrcnJJ?=
 =?utf-8?B?ZFJUZ2NWUU02VzNFYlUyL1o3WEVlSWVtZ3VLa0JKUEJkTHFMSzI2L2ZxN0VI?=
 =?utf-8?B?bUZyaGtHUnFXVzBvU0w1MXZMVnhxazBFYWVOMVBxSEsyZDVSWk43QjRjTFpj?=
 =?utf-8?B?YjNOQ3A5cVVjckhrQ3NFdTh0NGVoOHNFMURPZWduVURzcWFzTVVzWXBHMkF6?=
 =?utf-8?B?TjU0MFpIaFZ1QXM5c1dYay9XNU41SHh4M1R4Z29QZGxzT2RrWlRINWQvdE51?=
 =?utf-8?B?Wm5NZGsycEpRekcxNUpQK3FqeHlHa2JzdnlZQzFHVVh1dE5qYy9BdTN3ZmR4?=
 =?utf-8?B?c1ZtSFlvQUNWNGhqUlgyTis1cVpaOVZjQ25QZFBEekIyWmZodWxxOC9SZ3pP?=
 =?utf-8?B?eUxQbEk2VFIzM0FmVFpGL3dHRndjTE5ZTVlUV2tSTEJwYmZraDcySUw0aHVV?=
 =?utf-8?B?ajk5OWkxWHVmT09HcHNKb1N1dmNFYXI2VjZRQTAycUNHRkpJTnk0SkxwYk9y?=
 =?utf-8?B?UWxCeEx0MXRZUllacmxqSytaM3QxVzl1azNTc28vdWM1YnBjaDNaTGFtZHJj?=
 =?utf-8?B?NVFSLzcwSG81dUM5VzNkOVh4VTFLZlNZdGI4ZlN2NU13MDQ3dUZGQW4rUUFj?=
 =?utf-8?B?bytqQUNWMkN5dkNwTVN1dU1VQWlYbHJNWkpYdXZ4MnZPNnVBQloyclBBSnlH?=
 =?utf-8?B?TEFHT254eXFzcUsrVlRqK0t2Mkp2bXVWZExsdVJDbnYxVlA0amRnRWxWdksy?=
 =?utf-8?B?T29rRDByejI1cXhDQmgwMURKT2FCMGJqY1dZVnFBWFA4UStUKzhaMlpudTJ3?=
 =?utf-8?B?V05EVmZnUFRBV1A1K2tmaHdGc2lZRXBSdisvRjNoQVIyZGREZTRJWDFJZHRn?=
 =?utf-8?B?c29vVkRsR3NpeERobVJBN2tXSGJwdjJUTUl1b29HU1FQYXFlN0Y0NU52Qk1i?=
 =?utf-8?B?NWR1NzJyTE1qMlhYVkRnZmVpaFYybGpaa2NtRWlCVTRTSis1VllRQ3hVdTZN?=
 =?utf-8?B?eTVRU09rcnM0dGsvMGs0ZFN2NU9aVHVudFFvOURhK0ExakdsNE8zd3cyTnJW?=
 =?utf-8?B?dG1jejMzbElBSDJaRzNNaVRrYWJIanBFT1JUYURJRXFHeVJBclRRVzhTQTJv?=
 =?utf-8?B?VWhndWMxS1dwMWIySlFoRGJoYy9KRzU1UzFJL0Q5WUtzaUliVXV1ZFdzVW9x?=
 =?utf-8?B?Y2Z5dVM0RkgvRkhTbVJ2UjB6aG5tSzRGOHJJRnpVZHlmTlFOQWFCYStHU0Zk?=
 =?utf-8?B?RVVpQ01QNVNHQTBnTjBlUkc2SFJMNFJhUFYrVFF3UW5RRzF3VGYzM2ZxcytV?=
 =?utf-8?B?UmoxOWRBWkpjUHM1MVdlSTFHMU9CUEU5WWExUFpaZllWMkljSGhFblZ4SmQx?=
 =?utf-8?B?bnFVQmx3R3FWK3lucjk4YVRZRFVFQm1tUUVXclNWUzNxZjlRS2NrdSs3NDRk?=
 =?utf-8?B?RXZUNEk2SFRYTU9vVU9QNWxnNzVZM2Jhd25TNGhRSXJQenNiOWlmby9CT1g1?=
 =?utf-8?B?SndnR256N25BbmFQZExFNldyTlJldGk1RDgzRElveE04QjdtTVVpZFNzR3pR?=
 =?utf-8?B?Sy9KT2ZzVlZzSDlScENJMFgrZ2w0WHNGaDZVTkI5WWc4NEFLdjRHUDF6OU15?=
 =?utf-8?B?N0ZPV2VpLzhodmc2a3EyREVNczNTc1lOeElVVUZIc1UxV3ZWUWNTWDJtS1Iz?=
 =?utf-8?B?QU9LcGt3TGNLcWprRjhsbnVTaC95RStTS1UwUndUdjlIR3R6cS9yWTd1cDl0?=
 =?utf-8?Q?V3KLndACQcsfehBY=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a92c4d8-f37d-4af8-1a18-08def141e63f
X-MS-Exchange-CrossTenant-AuthSource: SN4PR03MB989351.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2026 09:30:47.4886 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qmCAGG6+Ca8GWdd5UVNJsUJFqsfaAi13WuFTUkROPZTfJANkGF/olVYI8FJafDUlv0F+4ERzrTc2mR8Dh0rSs9u9K6tAgTYW2WLd9tJrMyg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR03MB5306
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=altera.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1XGsASI5u2+eFKOq1vQGD3PZtx5Rhc7mjg38eaRjTt0=;
 b=D6snmysgs4n3l29sxnmW8rKpyDKqYx09py3Si9blD9MmrYr15sHRcLOw6HrS6F/7tn5hDL0bUZ5w1L6AL7JAgSOBgPYJ1mx/WfFNRgGBiv41IfWAgZRHPFZOeFJzYi++S+SoD64VtRb2MFKzBEJCA5OSUC4VmViCc5s6UxVPinmdb3lDnLckxhjscP3kgCPCpyGT675CYhxuPx5OMoNGEWctWmhlE2aQf20c6H1hiAp/E1QgTfaOCrclKhG4e9u73U3eeb4WdcvrAM1dHxbAnRCEhIW8CWPxzWutsszZgFf3Ce2rmxtNaLPd9VVYkF7gTfyakli7m2m0pXY6UJi9RA==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=altera.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 spf=fail smtp.mailfrom=altera.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=D6snmysg
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none)
 header.from=altera.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=tien.fong.chee@altera.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=altera.com header.i=@altera.com header.b="D6snmysg"; 
 dkim-atps=neutral
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
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
From: "Chee, Tien Fong via U-Boot" <u-boot@lists.u-boot-project.org>
Reply-To: "Chee, Tien Fong" <tien.fong.chee@altera.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Dinesh,

On Thu, 07 May 2026 08:55:05 +0800, dinesh.maniyam@altera.com wrote:
> Enable watchdog0 so the DesignWare watchdog can be probed and serviced
> by U-Boot. Matches the existing Stratix 10 SoCDK enablement.
>
> Signed-off-by: Dinesh Maniyam <dinesh.maniyam@altera.com>
> ---
>  arch/arm/dts/socfpga_n5x_socdk.dts | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/arm/dts/socfpga_n5x_socdk.dts b/arch/arm/dts/socfpga_n5x_socdk.dts
> index 915b8f6380e..f98e87bb87e 100644
> --- a/arch/arm/dts/socfpga_n5x_socdk.dts
> +++ b/arch/arm/dts/socfpga_n5x_socdk.dts
> @@ -120,3 +120,7 @@
>  &usb1 {
>  	status = "okay";
>  };
> +
> +&watchdog0 {
> +	status = "okay";
> +};
> -- 
> 2.43.7

Looks good to me. Thanks.

Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong
