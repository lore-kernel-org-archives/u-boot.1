Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 626C7C44512
	for <u-boot@archiver.kernel.org>; Wed, 22 Jul 2026 03:57:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8BFF380D89;
	Wed, 22 Jul 2026 03:57:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id X-DYlx3B24Q0; Wed, 22 Jul 2026 03:57:06 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8E2F780D4B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784692626;
	bh=VZcPtAGSv35pkbGj2TznB8PmleEdWjx6g1n3D70dR4E=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=by1y/uIffxKPu/mb1+K2j0sAhRCpGpr4Aempow6aARKooApMWcydkMK5DolRS1ECc
	 HSMZHK5JpCV2AKDA1hvWjmbKp0ZjMbpXj/X4Dck1H3ZDzBMw2/KiVUwIWWNkVq6DMI
	 9MZKTf6y6YOl1E6LATGApi4QN6FMWKJ9jxMC3XuqHTHkxdTZScLQpt72nkH7Tjq7u9
	 yPZtipYtK0EBbvbsQ4EMI1etA6wH4yw/LVMRc5hxeHYfey0b041xhkVAL6rkLbcGGo
	 KdgkIDG2DyZ17SUPZ9ny5UIODxKoqoRp4bdpy9vIxx+Mr+P+7sFYngN6tFGROnh5Oy
	 u/5VY1BKnfXGg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8E2F780D4B;
	Wed, 22 Jul 2026 03:57:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id EC9529E5
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 03:57:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D2F9D60611
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 03:57:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wRs5ymVIxJf3 for <u-boot@lists.u-boot-project.org>;
 Wed, 22 Jul 2026 03:57:04 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=dinesh.maniyam@altera.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org D074260632
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D074260632
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D074260632
 for <u-boot@lists.u-boot-project.org>; Wed, 22 Jul 2026 03:57:03 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8F3084949; Wed, 22 Jul 2026 05:57:01 +0200 (CEST)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7F07803F6
 for <u-boot@lists.denx.de>; Wed, 22 Jul 2026 05:56:59 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e8AKrtlOxIr4C3lt4dgg9Iuh3APSDwRvZE4+jzlpGv+Z4TF8REZv7Dzk8Y4QErMyc6EbgZNVuA/Z4jDo8aTnA6vddzeiAyCsQ9LTa0GN+dGCf2b9MxJvEFzAMnCk5r0cAD9m8BlxcR+VdX+Nly7eDVTQ0b8RsT73cOKfVcm4z7MTfEU2TQRr7jzMztdSHGR2bbnAQJu+1QKY+B5J92eFVe0tEiYbNyoOSOESjXGWC8CZ5n/Sa0SIUpZfts3gCAzcggw/Vog9J3SFfhNwSiNyT8V9zyFK802JFqpHB5jvGQYIL8nqHwh8F1bpnb8XqcCeNQdHJBmCZku9XzXQDZJveQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VZcPtAGSv35pkbGj2TznB8PmleEdWjx6g1n3D70dR4E=;
 b=LD3yTfh32pAjr4pfS77UR7IRkGBzLflDxlclrmZdvGgWc0kj3euIlnT/WMOOgCTaD+Y6BNtNAFOhUBDhXtnYPrQjuBhVGWL2NbiZEpYCNnJZryde5xS3p+ZZ7Cn5wzqeitiFG8KwJ3aWMVL0AEJA2EsAcNNbQjfUPOSZrRoRPv8uIsFxdGIIGiTbodWqgq+Ozo364EMHKEdbH1JXuxmm3oJTnH5pOSaUjvCImrQe9s9Z5VtkqyKzEYnOVzXpqYAcSYSVPV7wisenKMKuUIxjyAZt7hW9VVDVc78jHUgOaQ+SB0pD7VgBpB37gCo5BQQ1Gq0VcZWuiU1pGvk4UX22Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by PH0PR03MB989364.namprd03.prod.outlook.com (2603:10b6:510:11b::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 03:56:56 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::8f8a:2a94:f5a8:ea1a%6]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 03:56:56 +0000
Message-ID: <d0788bac-8527-4236-91d0-476479a92fb3@altera.com>
Date: Wed, 22 Jul 2026 11:56:49 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] i3c: dw: fix slave device setup and probe issues
To: Michal Simek <michal.simek@amd.com>,
 Pranav Tilak <pranav.vinaytilak@amd.com>, u-boot@lists.denx.de,
 Tom Rini <trini@konsulko.com>
Cc: git@amd.com, padmarao.begari@amd.com
References: <20260709091357.1860417-1-pranav.vinaytilak@amd.com>
 <5c6ba716-263c-4a79-aaaf-ccf714050b75@amd.com>
Content-Language: en-US
In-Reply-To: <5c6ba716-263c-4a79-aaaf-ccf714050b75@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0001.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::15) To PH7PR03MB6942.namprd03.prod.outlook.com
 (2603:10b6:510:157::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR03MB6942:EE_|PH0PR03MB989364:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c735a44-f7a2-45d9-fb33-08dee7a5460d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|56012099006|11063799006|4143699003|10067099003|18002099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info: 2NWzhqE0xzrFb2nj5sOTO2ppNIxrhWDVlvQweO2YSsp8KEoonTbj6LzSdoy2c5i2x4YLiZPTvVG1d4Mrck+lquZsCvWg/iBU3e3W3CqxETazdPZadmarhDOQVf8eeImBD5Ti2o0V3eqfQjb5VjtUqXsh5xhWKN6IP373uA1gXaNrckePFzqJoz6peVbzn4ugS69MrFd1U6hMZHX/QoUqnNF/EEBVhzBpMpkD5pcYCRgwG8R6kqRVJtTnsLNDMEfJ2qqtaBQzD2tqqrrFU1obbZS8wCrcqabvmHpbmoBEKNzLyO59zl+GWrhh4LLnGhjvO/M4PvV0iIMlj8HnhWR+mKCipcxT/KODJVHdyKmwbtR6iU3vvjOvRydSgLj07fvOQUgZ3DGkuRTLsOS2lIRaG987hjk1eT3InLQaCk9RF/8qTAKStfNwFh8mnlXs8ZBj41WMfYl7IO4GPyBJ7VwQNO1JSx/DtOFx6pIRcQIS+myp4bUl5i1sk/TN+CKxPb9Ouaux2dvS6ulAVq3XAK5Qym9h9o+F5cR5ldkanUKFoIlaIH5XAbJYiKYAUgXZj0LmdLo8/hX9m/GrrrIrXBQrIFu0bI2b5Pbi6t6VUhSPFAf564Sr1LuTTcZOc8JCQV6tBalTzxl8qmvfZyQDRrTLe8otZgQce5Q0PmRMihRQ0PI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(56012099006)(11063799006)(4143699003)(10067099003)(18002099003)(22082099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U2FhS3NqTWVhcVpwdWRKN3F4NHE1U0I5UWQ3SklKNndxUTgyYTBsT25WWHVN?=
 =?utf-8?B?SitBd0RPVnlKZlJCc2xqNEFGNGZoQUlLVWZHby9nOU5pc3Z5NkFOVm8xWUNU?=
 =?utf-8?B?Zm8wTis4Y3hCMTN1TzRCZ0x3eFJqQU05M0ZFRUEyV1NRTEh4ckdWOUw0MEZD?=
 =?utf-8?B?NGN6N1orMkpyR2x1Vlp4MlZpZnI3MkI1Y2w1d21OMUlnNUVuZ0NSNHljb29a?=
 =?utf-8?B?SCt0cUFXNUxBRTN4NFR5dGl1SWtUdnpaYVlaZXlxK2FkVERSTmZ4U2MrUTVz?=
 =?utf-8?B?cDZ1ZzVpNFgyd1AzWnhSRDhTRmllNjdMTEJIZTBzdkx5UUU1VkI0ekxucEsz?=
 =?utf-8?B?c255b3hKbVlldGZGb24wbW55S2lsQ2tSZWxRelVuRWxwYkUyZUpWaTZHeVVE?=
 =?utf-8?B?NlZ1N1hlVFNjaDFsNmhwTEFJWmNhd0JKQnM1U29ZckxLTGJNZkNjN0c3clY0?=
 =?utf-8?B?cXdaM1JWdTQ3R0pUQUtvVzhNRXFndUxmS3grczlQTUZIVmZlYWJGV1pYL2t2?=
 =?utf-8?B?LzBqS1B4RkVHbFphbHhhSUlYNlc2Q29ITkhEODh2UElFRDFiSklob1JIazBO?=
 =?utf-8?B?VE56N3BiLytMV0VPNkNQR2tmNjdYY1ZCb094NmtXdDE0OEpRWW9UQmIvSmIw?=
 =?utf-8?B?MndKVzRWR1M3K1Yvb21JRDluWERaTWduelF5RlNXcDJ0K0pzWFZMMDduVkxN?=
 =?utf-8?B?TGVJbWVaYWxHbDA2OWZIVHB4MjlwbDRSdHlBMVY0OVg1ZmNFalBJNnFqVTkx?=
 =?utf-8?B?Rlg3N2lnUDBLcXR2c2hES1UwRk54eEpuTkZGL3d4VjZiZ2wyejBpOUFGcGRP?=
 =?utf-8?B?QWZ2aFo1Mk5ZcHRYR0RTL3l2Q0lRaHQ0WnJES1lsU3NacmI3WmVvRFJ4V1hG?=
 =?utf-8?B?TUR2UXlLbGJrbVZsWW44WGUzOWRMUkMyOVk2QTRQSTBkc1UzVTVLL1IxZnRL?=
 =?utf-8?B?SGJnSzEwYlhaZFlNUTFiN2x5R2ppUC9iMWRNOVFiWkFsUWVQSXFxYVFNc0Fl?=
 =?utf-8?B?MTRRb2ZFOXB0UmhhYjROZDJIcjVSaVFBRGVuRVFUUlIyM0tTL0lwdEV1Qzhq?=
 =?utf-8?B?YzhwK1psOWdYMjJXdHk1NVdZTGNQUUppMTdYK0t4U2dnamdxbnRBemQxc0I5?=
 =?utf-8?B?R0ZBV2hFNlJKWEwrVTFwdEhLMEVOSkQzR01WdHIwM3F6Q01xTktTZWhzZWZo?=
 =?utf-8?B?aS8xUzIwZ0RZSG1Pc2xGMXhicDI1Z1BFR3pwa2xaMDkrWGdvM2hmYmhSeWVR?=
 =?utf-8?B?WFowMUw5Rk5WVmFFWktpR2FsODNnd0pIbmw5c2QrWFp0WWw1K2xBWk1va1JV?=
 =?utf-8?B?OE5VQ0tmS0VMNzJ4Ym0wZUl1UzZTU0liMmYyM1hKSUxBL2YxWm9FLzlJQUNF?=
 =?utf-8?B?cFNtVTh4N3RBa3hVdFFJOUp0UmU0eU9WM0xIRDAvRXh5MWZ0TnVLNjRSVFRv?=
 =?utf-8?B?a2k5emd3Q2VXOU5EY1NIVUV5endIaUZRQXBWMXdSN0FtTDlXSHNvUWJ1Qk0r?=
 =?utf-8?B?eHc2a04yNGRqU1hIa0JjRlhkUzZ4MjhJS2VGWjBEenhhWVVyV2grbkIvZlpW?=
 =?utf-8?B?Wm43MGg5RUh3WGMzU2RhQi9rc1VEcjhGWlhTSlU3L0ZTa1JWK2trRks3dEtI?=
 =?utf-8?B?SEdmREhNRHBrSGxFNXVxUnZiQktmVGxUNkEyN1pIckl1YXZIaTh4SEhlUjdU?=
 =?utf-8?B?OWNrc0FFQytIaHQ3YnpMby9DVlAxenhsemVSbENZTGhEUy9EUTFTblBvNVpa?=
 =?utf-8?B?SG53TUw3aWxNODNpTVdHcmp5eC9rR3JoY1NMbTJnU0MwUVhHSzJqK3pxZHdH?=
 =?utf-8?B?cXZ4UXFwcFZNeEhPZlFHa0Fkb1FiNnJaY0dIOVZBMWFkbVE4d2swYkNHb2pD?=
 =?utf-8?B?RWdjRFhlR2JGZnltZTJvZmEvUHhBTWJIQjQwU081N3RHQURFQ3AvTG1yRW1k?=
 =?utf-8?B?M3grcUhnTFBENDlMRVZPVTZSR3MyeVBOdElPcEFLdmVrbURwSU9QZ205Y1Zn?=
 =?utf-8?B?aUVVbVNIaXFvN2ZWTHM3bTMwNjdMNGF5OGxEbUJWbFhUQk9MT0N0YkdOemRO?=
 =?utf-8?B?YjJIWUhSV3hDQ01KemJSTWVHNTFMRm5PUEorRUxoWFNWcU9MUXNRNkFzb1VZ?=
 =?utf-8?B?dVE4MXlOcUIzeVBMdUpteFpKaUtmZFpWWXNucHZrTy92S2RLekI5SUlxVTRl?=
 =?utf-8?B?OFNXd2dWSlozd2FXeTlXYXovZXlwTnBQb05TbTNFb2l2R245Zkt0NzdXRUFZ?=
 =?utf-8?B?WjY5cHhBYnZldWh5SnFXbGFjS01QWGhSVmx4N2hJZXByK00wbm04M2kydVJr?=
 =?utf-8?B?SkNSeGsyTWRPK2ZEa0VTcHc2Y3VJS29PYkxpR3l2eWkwOXNvL29QSjRaQ3B0?=
 =?utf-8?Q?qy9BYMn1psqzzUoI=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c735a44-f7a2-45d9-fb33-08dee7a5460d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 03:56:56.7037 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QH4CTuxC2dQvpTLIyGt7P+mI8iecWPWHT7wPwa1anQr0RTtTM9oipt0R5zB0H11SyQpAft4cAkaUAfsMcQcT7Y2JakIN3YMRFPMUZ2exRqE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB989364
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=altera.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VZcPtAGSv35pkbGj2TznB8PmleEdWjx6g1n3D70dR4E=;
 b=IecC0gS89A8v7S0oB6FWlqn8IVSLwjFkUVYt0dtnp/sYU2fPcTABBmYzLongsw0VJ162g0LIP6KMzS9D9qqX+12oVp/vZNpRMt2Q+UV7v3duVxBN36/YDUQGrzpoNPIqFaMU8zvYfsTRCGfXHREB29ZlBCxUa7sRz/VVloBawGZoL2AZiYtf9Rd2js6g3h8jajGOFCg1SDxMRI46H4L8sVLcOpsBeot6WFjhjUNaL2bnG5ib6/M96E4xpD20aM3KOm1VIa+phUcsqmCAi2gMaku+r38D3S3WbdxlTLpfRBZ9EaHcunZoqlkEVG/pje0X4MSoBk+UT+zm1OCk7uBixA==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=altera.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=IecC0gS8
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none)
 header.from=altera.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dinesh.maniyam@altera.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=altera.com header.i=@altera.com header.b="IecC0gS8"; 
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
From: "Maniyam, Dinesh via U-Boot" <u-boot@lists.u-boot-project.org>
Reply-To: "Maniyam, Dinesh" <dinesh.maniyam@altera.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Michal Simek,

On 21/7/2026 4:07 pm, Michal Simek wrote:
> [CAUTION: This email is from outside your organization. Unless you trust the sender, do not click on links or open attachments as it may be a fraudulent email attempting to steal your information and/or compromise your computer.]
> 
> Hi Dinesh,
> 
> On 7/9/26 11:12, Pranav Tilak wrote:
>> This series fixes several issues in the DW I3C master driver and
>> related infrastructure that prevented I3C read/write operations,
>> and enables I3C support for Versal Gen 2.
>>
>> Changes in v2:
>> - Use -ENOTSUPP instead of -EOPNOTSUPP as the reset stub in
>>    include/reset.h returns -ENOTSUPP when CONFIG_DM_RESET=n
>>
>> Pranav Tilak (4):
>>    i3c: dw: make resets optional in probe
>>    cmd: i3c: fix list and current needing pre-selected controller
>>    configs: versal2: enable I3C support
>>    i3c: dw: fix slave device setup after DAA
>>
>>   cmd/i3c.c                          | 11 ++++++-----
>>   configs/amd_versal2_virt_defconfig |  3 +++
>>   drivers/i3c/master.c               |  1 -
>>   drivers/i3c/master/dw-i3c-master.c |  7 ++++---
>>   4 files changed, 13 insertions(+), 9 deletions(-)
>>
> 
> Dinesh: Can you please look at 1/4 and 4/4 patches?
> 
> Thanks,
> Michal

Reviewed. Thanks!

Regards
Dinesh
