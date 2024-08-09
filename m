Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F508C3DA4A
	for <u-boot@archiver.kernel.org>; Fri,  9 Aug 2024 15:38:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C472886B1;
	Fri,  9 Aug 2024 17:38:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=marvell.com header.i=@marvell.com header.b="fM6Ede2h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E9D288B36; Fri,  9 Aug 2024 17:38:31 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 384B788670
 for <u-boot@lists.denx.de>; Fri,  9 Aug 2024 17:38:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rminnikanti@marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 479CJQLH000601;
 Fri, 9 Aug 2024 08:38:25 -0700
Received: from nam10-bn7-obe.outbound.protection.outlook.com
 (mail-bn7nam10lp2043.outbound.protection.outlook.com [104.47.70.43])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 40wdpxhrx8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 09 Aug 2024 08:38:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n5UbRTOuGWy5lQ0U7nZucCeQig9pqmBw1Ct35h85Y1VUDfAnhPemESGRhth0c86HVoDeWY327NAy0sqsv1EQEUavI9f6qZdmJ9b0FeoLnmM+sGBLYBscKCOEvoTLPCIJjAg4uDZRCz67WgK3L9z1fvefo7/yjhRvo7xy/htgjwvHzZzvVmKOZoPYmQr8kpHHyJXA5t8MU00S0RyZWbV4FQSt0JrVlKv1xF3GS4+8wmkPU68+c/a9dWLtU9Q/Ql1fq7b8FjbHwF/+8+76+bvocQONE5RIPSqVHaxyatV9GEBaNzWniinaP/kWhjfIV8GEGCxsKktV44aOjae2fcgcSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m+ML6wAQRnb1sCCwbrwB97J/Khg3+AQK1lLvKJAFJvM=;
 b=OS0dAgUqaV/6B9HfcxDNrWojyQhSLIx+F7Ux2nQgM6YtbNDMMpcHjkvN9O/K8XbFgu2FLfY67N5+kPKgzCCEm/PGJmnBvnkwUMkYaSiHX0FEK0QpBX9XQ+E81gkgSmnlWY7FynE8RTIsbGLBBFrGxa2sKmfaJWNuRk49je5eeCALrZkipeOcI/Ucw3QvspnjMdUHp624lu2IwG5+DQkmlDcVhpJ4VOKiBrrd6cK2gYFtqYalVCqIy9xB82wOz8G5bD0H/I2W/GAWVseMSRYasa+KrTwXjxaanOqojEB6DoH0KW58ngKIEmbxqDH5KxagUSeeW5Lt3rBXg0WO0FF3Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m+ML6wAQRnb1sCCwbrwB97J/Khg3+AQK1lLvKJAFJvM=;
 b=fM6Ede2hqzkTHT9/FrG+Rbq2DcJQ3CvlUMgUrhLEI4VmcHDG1rOwXsDutWo4CICBdrOCJW3behhhEIMGotjc6MTiASWuXezgA2tTIylsbi9rOVNLn2LqTh7ai76l/aaSsXpeOsgbwivt3q5OpWR/rHOSZSGIWxBVFsHzpG7T68o=
Received: from CO6PR18MB4451.namprd18.prod.outlook.com (2603:10b6:303:138::12)
 by SA1PR18MB6035.namprd18.prod.outlook.com (2603:10b6:806:3eb::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.14; Fri, 9 Aug
 2024 15:38:21 +0000
Received: from CO6PR18MB4451.namprd18.prod.outlook.com
 ([fe80::4c2b:70d5:95ac:1d6c]) by CO6PR18MB4451.namprd18.prod.outlook.com
 ([fe80::4c2b:70d5:95ac:1d6c%6]) with mapi id 15.20.7849.015; Fri, 9 Aug 2024
 15:38:21 +0000
Message-ID: <03cdd29b-331c-76b0-f6d7-a064552ffd67@marvell.com>
Date: Fri, 9 Aug 2024 08:38:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: en-US
To: sjg@chromium.org, Tom Rini <trini@konsulko.com>,
 quentin.schulz@bootlin.com, U-Boot-Denx <u-boot@lists.denx.de>
From: Ravi Minnikanti <rminnikanti@marvell.com>
Subject: [PATCH] env: remove vars that are not in default env
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0105.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::20) To CO6PR18MB4451.namprd18.prod.outlook.com
 (2603:10b6:303:138::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR18MB4451:EE_|SA1PR18MB6035:EE_
X-MS-Office365-Filtering-Correlation-Id: 06453833-4776-4b3e-168d-08dcb8894c73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dlBSeW5QTktzV0VteWRMQ2phUkpoU3hDQXlkczB3Zmg0eUdReGFZZGlCdjc3?=
 =?utf-8?B?cXFNdVhKc2o5WnN0WDRVMmRNTFJiUExqYjhDSENEcFdvZ0VraFhaUGZwUmVP?=
 =?utf-8?B?Q29WdEZzTy9iV3d2enE4SjZhb2NCYmNYS3NCQVFmRytCZ2UwTmJvdVZNa3Qy?=
 =?utf-8?B?ZExaUjh1aE41L0U5REJPeDZoNWhzdjRCTTdXZTUyZ24wK0dickU3WDZaWFhH?=
 =?utf-8?B?RnBzR3pNeWFxODVUMnN6bk5Qd3ZhUk1jTGd3WGRHbGp6ZnpuSndOSXF5NzZP?=
 =?utf-8?B?QmNMcUtINXZUS0l2Rm94cERpRXVBKzk0UEQ2TGlhTnlKVkliMDNmRERMa1Ny?=
 =?utf-8?B?aGNBNm5jNmgrcE9SWUJvQkhyb09scExHcWdzMjNFTXhZMFFPRDdLbkNnWUw1?=
 =?utf-8?B?THR5ZWJpS2pkVFh1RnJJbk9oT2dDOWd3aEhGYzh1ODViQXcyNXVxYStwSWpv?=
 =?utf-8?B?Ri9Zb1RyYlQ2OXdjUEI3eVBaaFM5SmlhMlh3Z1REWW1wb1pLZTd6azVUUzdI?=
 =?utf-8?B?L252YmdPekN4dmJVeTRPQzYxL21EcVRHQ3g1bjJZdTVvakNUMzZORERGRDFO?=
 =?utf-8?B?YnVOQ3J5ZWJlc29HUTVaR1VnOHZmSmxoTk8yWlY5Z3FNVlRTRzQ4M2MrZVZH?=
 =?utf-8?B?Vmw0aXU3K3pDQlJvZDJkYW1NQnRGeSt3YTNXL0UveFFzWElqS3Y3Zk9oVjEr?=
 =?utf-8?B?MTM0VUZGN1ZkNlhSRFZ0R3NGa29uVzVSaHArRTRlcFhPN3Qvbkpua1RRdVhW?=
 =?utf-8?B?aFVtRzVhRzZIOUg3STZjSWdjWDlBd25ONjFrMUxoK0tvbzR3MGQ4YS9iVUpi?=
 =?utf-8?B?dlVvc05WOFc4SG5Qamdhb1dPUHdnZ1dISkRsMW1tSm9WYWtSemlseXMycHdX?=
 =?utf-8?B?Uk9YWWZnTXpubE9kQmRaN0JXblBTUEtpTnBFT05HNUR2RmlCeXk3eC83MjAz?=
 =?utf-8?B?a0Z6Z2VqaHFuVjhsNmxaOVcvSmF2V1VYUndhYldHQ05aaXh1NWk5WmhxYktK?=
 =?utf-8?B?WnpGb3A1ei9tZ1pXaytVWVFNODdKZTlRdWd6UkhaSCtHQlBkd3Rwd3ZmclNn?=
 =?utf-8?B?MXplK1E0ODRCbFBsY0s3SWc1K1ZYWU5rWWZyWk1CWE9NQlAzbTdFS2JrZEVN?=
 =?utf-8?B?UVBXZmowVVlYZEJBVVFWM1BCbkxWODhJK250VUlpZXdkVGN4QXFDSDZmSzRz?=
 =?utf-8?B?VTlFbWwyakViaFloL080eTlmUVVPUE56cy9jeG9rM2h5Y2d0Yzh2Ri9wczd3?=
 =?utf-8?B?NFhMMHVXemVzTloyTGlveUhYOGhnRkRpQW5vR0Yrb2RNY25LVTVMejFlNGNq?=
 =?utf-8?B?VXN5NE0vcXVBSVJLNlQyaFhZbEF2SUhYTDFMVkJqTk5RZkFRVjdVMVZkek5q?=
 =?utf-8?B?T1l4ck5tQ1BVeHFHaXlSYU5sbE5XZTl2ZGVwSDJoY0JTVFlzK0FSczhKa3Bj?=
 =?utf-8?B?NjFLSHZKNXliTXRuYkRSYjNMSjBqT2grQXk4SjlNTnQ5MURTV2dCdGN1THVm?=
 =?utf-8?B?SHJ3MzVDazBvWHZlQU8vdjNiaXpVdW1tMU1Nc0xYRUhaYmQxSXdyY050cytQ?=
 =?utf-8?B?REloNU5xenkwQnlTdFNZRy81bUVaU2lmb0ljREdDZ3JjbThZOW1yOStpOUph?=
 =?utf-8?B?SlM3L2pnSW1aL2ptM3RWVGdZdElDNU5oZlY2WlYwMlhiR3RPR2FMYkthSGdv?=
 =?utf-8?B?Tkhib2xVbmtyV0VGZ2V1SlMydjVLQjlUL1VOK1BQbzhBSWpJQWY0b1E2d3ZV?=
 =?utf-8?B?dFJvWnkzalJoWGlxZm9MZEExaGk0U3BBRWNIeGNINnFrcXhWcXV0Y3FVVm41?=
 =?utf-8?B?RTB3RjBoaTJORGJKN1czdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR18MB4451.namprd18.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MDhqb0RYNzBHd0U3YTZPYmxqTnEycjhqblJMK3ZmTXlCcG5lSFdNQkh3U05u?=
 =?utf-8?B?YkZLQkMvbENrL0NKcFlBR3JqUSthbzEwWm9TNVhKekZXbm9Bc3d4a3kzN0do?=
 =?utf-8?B?Qy80L0pIMyt5SnVWN0hoZEs1L2hiNWVJTnNGWWN6YVNaTVdSZllUWmxUNlN5?=
 =?utf-8?B?UkRKUVBKaHdkUGp4M0xpeVY3bHcyWW8zd1Q5dUFBeTdmWUhxM01lNDFJUExS?=
 =?utf-8?B?UjdZK1hKcjlzdVdtbnlxbllZNzVWMDVxVEY3djgxcUhWRmh2dS8zaUxnWU15?=
 =?utf-8?B?eE1tYjM4UlVGaStkNVdYdFowcFZaK0F3TkN3ZWJKTm1nY0ZwbHNrQXZWb2Vj?=
 =?utf-8?B?RXFsVk81Q2NURXpKQmlES25DZ051aGZ6ZGRMc1gvZllYcllYZ2ZSKzQyNytF?=
 =?utf-8?B?b2JhWHFmOEpseC9qK2RkUTQraUI4dE9tMWVMb2FpalhlbjN5WjQxbVhYcC9M?=
 =?utf-8?B?c05NTktWYVAwWlVIMHRSRDhPc0pqaTRZamgwWlFzbURqWmFHU0huQkRYNjda?=
 =?utf-8?B?RWVvVDNKQ0Y2TXNzOE11WUV4L2hjYjdWbjFMWWYybUw5TWFDdmdsRkoyT3My?=
 =?utf-8?B?c1lJUEZsUk9WUHVrRmx3WTJqbUVORjRHUUY0WWJWUnFMdFFKajJNWGpLaFBX?=
 =?utf-8?B?TkEraURGTnhKVzZCZnJ0NDhyYUdjNCs2MUxUb0FuS3M4SFZhdXBwTFptUXA5?=
 =?utf-8?B?d2JCUVQ5RnBQZFhCU1Z4MHlNVkJOZ0ZDa0cvK2FsSFJuVERaWDBwQ3g1S3JX?=
 =?utf-8?B?WkVyVVFrS3VIeFlDMHViNVQxRTlpSHZVNE5qdC9sMklSd0d6VWhSNGx1cVFm?=
 =?utf-8?B?ZVRRS2JydVNuTU9URWhVMmRiWVhwbDJQU05jMEh1QUVmeTZpTWpUZERDTXlx?=
 =?utf-8?B?c2lrd2RVVGhpbVlrQkZHZXVtQWFzcjBzV3h5WnpuMmlzMjhXdW9wbmhvVTFM?=
 =?utf-8?B?L1pYM1o1YW42NWVoWUNTbHVmL0ttR3NEeGEveTJLSmcya1JKakREdjJXdXE3?=
 =?utf-8?B?R2VkQlpTeU5aK05yV2RsZW04ZG8vM0RHMnB4WmVmM1phcTBmT1gvVFg2Snd3?=
 =?utf-8?B?OEROb093bTZHZXdpWUhXVHNxWVRTekJrMnllQnB0WldMeXZ3TlZYakczMFo1?=
 =?utf-8?B?UkNMeGZxcXFyVzVVZVFkakZvZ2g0Q1U4cEd2MnRaakJWcFMzbVI2L1hFUGdh?=
 =?utf-8?B?NEEvN3BUT3pQdjlKNG5jWTdHUElXQ1F6ZnkvUHZYSVlQalNnczlxRUJ2N2lY?=
 =?utf-8?B?VE5mV05UVFhxSytrSVR4bjJES0k3dk14cXVEMk16bEE1WHdFcys2bnhhZGpr?=
 =?utf-8?B?RzVkT1N4aG9kbmhCSUJxTThkTFhldzR6TTM3VENsaHp4a2NuOG53TkJMdEZU?=
 =?utf-8?B?RHZWVmtFN01EcXB6emtpK3dBSXorQUhDcCtJZFJxWlBvSzZFazZHNlFIcHgx?=
 =?utf-8?B?aGNSRHhySENKN0tEMmJ0K0QwdmUyNFE1TVBuNnlCbDYrWEVjWnkwbmhWbU53?=
 =?utf-8?B?Mll5NmRUcUJoZEVEQXZkcUF1Z0tFT25VNUtzUk8xUi9YK1VGVzF5eEpmdHda?=
 =?utf-8?B?VDJKUXBkOFdvdFdsa25VWGdpRlNweGdOTGUvY29ha0NzOHNYVms5SC9CYmlk?=
 =?utf-8?B?b3RtcUFqZEV4R2YxR0hTaW8zRXFDWXNPU1FDcTBEdzBJbUgyTzdFb2V1RVVV?=
 =?utf-8?B?NTk3a2l6ckJHNEtBZkJLdmdXeXZKOXpwa09Nb3RoVzZNZjUwamQrcER1SWJo?=
 =?utf-8?B?dlRsVlZJdUdnKytlRFhpLzBOOGRoblFhYTRBaWlBem9KV2VvNUdxYU83bkpw?=
 =?utf-8?B?ZWFlblBCN2RDb0o5SnRaRTBvOUxCWGxWTHVzK1lNazdDNXNpeDh6MkhSaWNR?=
 =?utf-8?B?Z1NJd2s3OVpKcTVGRVFaVGRLdWREcVdIYkIwSWRyWXhqbVY3WG0rV05xWERl?=
 =?utf-8?B?OUtVbE5XcWhvUFNxaVRXeVhTbDhleVVZcDNaRG8zbVB1Y0F0LzBoSUM0QkxS?=
 =?utf-8?B?clRCVmptLzByTldaM0xBOXlmbUJGSjRYMUlkSzN6TGplS1Q1aDY5bkhEWGwy?=
 =?utf-8?B?cHpBdmJhU2JBWE51U1dQQzEwdCtGdFVaeG1ac2c3anEzaDFBZG1oOHRPdVNI?=
 =?utf-8?B?TGlmWUd6bThjU2RUYWhieXhERWlya2h0Nk9OK2srcERqeTBwM0crMjN4ZGJG?=
 =?utf-8?B?SVE9PQ==?=
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06453833-4776-4b3e-168d-08dcb8894c73
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4451.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 15:38:21.3956 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8o0Iv4qJYe0JHq3BKBw/VI7Lei33htVkTFCugPPIKnI4JX0dL1qA6PCD46FxuPVc2AYo8c/wBwcSVx58g6O2Nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR18MB6035
X-Proofpoint-ORIG-GUID: yK-861I8bl5tpzeklul8JsQkxjdhgOQC
X-Proofpoint-GUID: yK-861I8bl5tpzeklul8JsQkxjdhgOQC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-09_12,2024-08-07_01,2024-05-17_01
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


current env_set_default_vars() doesn't delete
var that are not in the imported env. hashtable
removes vars that are not in the imported
env but present in the current env only if H_NOCLEAR
flag is not set.

This change is to avoid passing H_NOCLEAR flag if
specific vars are passed to env_set_default_vars()

Test:

Without this change:
Marvell>> env default boot_mode
Marvell>>

With the change:
Marvell>> env default boot_mode
WARNING: 'boot_mode' not in imported env, deleting it!

Signed-off-by: rminnikanti <rminnikanti@marvell.com>
---
 env/common.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/env/common.c b/env/common.c
index 8d47d72605..2f783e3a69 100644
--- a/env/common.c
+++ b/env/common.c
@@ -401,7 +401,15 @@ int env_set_default_vars(int nvars, char * const vars[], int flags)
 	 * Special use-case: import from default environment
 	 * (and use \0 as a separator)
 	 */
-	flags |= H_NOCLEAR | H_DEFAULT;
+
+	/* 
+	 * When vars are passed remove variables that are not in
+	 * the default environment.
+	 */
+	if (!nvars)
+		flags |= H_NOCLEAR;
+
+	flags |= H_DEFAULT;
 	return himport_r(&env_htab, default_environment,
 				sizeof(default_environment), '\0',
 				flags, 0, nvars, vars);
-- 
2.25.1

Thanks,
Ravi
