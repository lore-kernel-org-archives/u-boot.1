Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0972BC5DF81
	for <u-boot@archiver.kernel.org>; Sun, 23 Aug 2026 14:32:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 65A9340689;
	Sun, 23 Aug 2026 14:32:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0w7CQMr_MxPc; Sun, 23 Aug 2026 14:32:01 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787495521;
	bh=rl9fmNgw0lQIIrdx4JdFUSj4rmpk+Rp9bdwjPd2f4NA=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aWp1TdESdzfZdNHxcQF+DcJN1vgITgxtuyi3y5ATajGb/5YOdqXnT7BDIRWtVKynX
	 pQC/XGIVWZZRdlhQzkjK3DDQHmuqsUAN4079Hwe+yM3glliNwsuCkuEiWbFNpMv8oE
	 3j0pstVC5USJnQm7yXCC6FnajAXn4Fz2+OipQY7O42OEYlvBAdJ/X2xtewRF26OjQ4
	 eWDULHSz5SAYFNNReE3Ei9uYQ562Scqbj8PA3j3pY6rTjaX42/GyDJ9HV0rOTPWqVI
	 Fs+2gFEQMI/svvVvSctte0Shk11eXq5CW7CG013wMs+bXBKSjtkAe8RrUDCMh7rFM+
	 q5V5OMvVRWg+g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7372F4067A;
	Sun, 23 Aug 2026 14:32:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 473C4386
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 14:32:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2D1464067A
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 14:32:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iAZaq8xGerVA for <u-boot@lists.u-boot-project.org>;
 Sun, 23 Aug 2026 14:31:59 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c100::f;
 helo=bl2pr02cu003.outbound.protection.outlook.com;
 envelope-from=tanmay.kathpalia@altera.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=sSpPkiL8
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazlp17011000f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c100::f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4643E40675
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 14:31:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I8DZE7L92gv7lQzQsQKB+eSWQebVdY3/UTBE+sPwJC5GjfZxJPGlQ0LDNgPq7oLgyGUYiG/LoS0Xb4RtMMCYqF6KW7zkQVmwruHz+oSzTuyDu3fAwxBDNQPZ0MthNeqoVfL5/8Xp9PeuAGR77c0TMeVNrjEqV9e2XaBYX0qyM3e7h51vnvc3c5b08xDIaIKFgsgwlxgkyG1bUCrmrbA5KksA8BBnjtV4q4kOiIKi+eaBDYiJoDXTJRr0SbINc2IMpyVSEPJnSUQUHsTR2WR9CAylDIZopGILFVdT913KhL/75eAWwqTQvS23fIebwRlU/ANZqiUBotuYe2VMiEJ/eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rl9fmNgw0lQIIrdx4JdFUSj4rmpk+Rp9bdwjPd2f4NA=;
 b=XgLyL0CKywVR+1m+f5xAUUUVOmvVsYp9OI2igOZL3T31wlv2VMZufJgUNdMYb61UvNdid45feyZlCKlxMoq8zkrQShhKLjkrAI4zWKx2wk4rpTbO9CsaVuw49DPyLZEWkFjyJKJwWIClRcfefok5CQ/ln8UtO3x0obH3RIDkKYBuRVf8u642Sg8hJWGBCHc426PJGNLL2uK2Ho9ZwqENWFt/LRYfxeWxUgLxSStENOmRaPMEHG8KnxyJVbnUD5trT/RFDA71huWuGD1OdiUbuF6BkKZyYCo3QCcZ0/STapQCIx/lt598pNJPx4whWtxV05yMekBKMewbdxmHUyBXbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rl9fmNgw0lQIIrdx4JdFUSj4rmpk+Rp9bdwjPd2f4NA=;
 b=sSpPkiL8LBiuYy73sreWQZdO2qMsZSTHmHtEJN2Ymew1yoJ/CIa+r3zoJgUyfYaNP3Fc16QXGD7exx0JYSWfzqUNgS58/9S9mU49j3NtvunSmjfxR7ctwdBACmi2rGHB6vwL6TSBsBJ4LrvjlEP09Jd2CeSyHBZPW64UovrwxvbLj1AwSILguygJfY2hQhDz56PQTr9yGicb/Cj0HQLKY7+zFYT8ZgJeQNSXkvs07DQunNseisRKYpEPIyG4PXKaKWOLWnZ2X4sl1T2qfHApyD3QDwlwa28wy3TBqMFC7525Y25NElLdjAg8mhwNpGee3UEec/RO/1YKD4Tw8I2kUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by MN6PR03MB7670.namprd03.prod.outlook.com (2603:10b6:208:4f6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Sun, 23 Aug
 2026 14:31:52 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%3]) with mapi id 15.21.0339.012; Sun, 23 Aug 2026
 14:31:52 +0000
Message-ID: <495e9da4-cbcd-40ad-87aa-b8a156dc9022@altera.com>
Date: Sun, 23 Aug 2026 20:01:42 +0530
User-Agent: Mozilla Thunderbird
From: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>
Subject: Re: [PATCH 1/4] tee: optee: Add support for enumerating services that
 only need RPMB
To: Jan Kiszka <jan.kiszka@siemens.com>,
 U-Boot Mailing List <u-boot@lists.u-boot-project.org>
Cc: Jens Wiklander <jens.wiklander@oss.qualcomm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sai Sree Kartheek Adivi <s-adivi@ti.com>,
 Alexander Heinisch <alexander.heinisch@siemens.com>
References: <cover.1787304541.git.jan.kiszka@siemens.com>
 <bfd9927ca141783a9f73f82a10eca75699222e1d.1787304541.git.jan.kiszka@siemens.com>
Content-Language: en-US
In-Reply-To: <bfd9927ca141783a9f73f82a10eca75699222e1d.1787304541.git.jan.kiszka@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0038.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:175::7) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|MN6PR03MB7670:EE_
X-MS-Office365-Filtering-Correlation-Id: 954495ae-205f-4df2-be22-08df01234586
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|366016|6133799003|3023799007|10067099003|56012099006|5023799004|11063799006|4143699003|22082099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info: on9ybE5mOgMNl7/AIx6GZpASjjEdWHz6BB2zdHKClbVRDk2RHWzVx2GW9ipivUs1VhaF0KvtZsENaGztjEZEmFUTWsJJabpM10RIUZnjRZ4+iLai2Uk13eqlsWMdsG/pxrl+ZtYYUmTfv3XEhS2c9qfnNxnRwCywgeqOwuRS4uqPhpKOash0aXUGXP9n2QJyd1+Lemox/Rh7yv3dAX8dCHvGbwKYbgealSEAzENQjvHxqkqLtg1ZoTxwojXfYr/ZHv/FYf2LooJc2rOEamaXTsFHZyT29zhVlL9Z+L67J0BrnZsEZot10hxf9ftPmF7bAo9gPoKpf3J4Tn5jDOJHDOv00dOm5hN0bT9U3ZaukrPwgWIZdCx/8bFukXv0sNAZLh6l81ULCZKixv8wndX53B/bJ00L/2dMq5kn76E7iHSFvrLawrTIELHIjE/aWAz0TkMMs1CELjrso8l5Dk/f10Zby7VL1etxpmZ/Y9zYvluRsJ7necjeZIB1W0wQ2mDMHYsJ1FzviKW0RlSWyGgrhwzhhmkYOipmX0PJwcyjEeU1KCDKK4P2Jv5qJEF2Q12f5YE1ecQJKaJmyt8cJoQj8RwH54DaeXNzEPGMrRsvVO76gRJd5VUOwpy9Z1xyBzXg581ZK0Cspg8Gs/AisWIzLTgDUkoAm8xo7Npc3vZw5Dk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR03MB6208.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(6133799003)(3023799007)(10067099003)(56012099006)(5023799004)(11063799006)(4143699003)(22082099003)(18002099003)(55112099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?akx0eUE0RFB0Y0kxQmsvS29mbFJSQ29BZS8xdWl6ZkNOTjU0QVIwRjFvUmV5?=
 =?utf-8?B?aTNZSVdnNlFYeit3Vjh2N1NtaDR5REZkSXVyalg0Z011SlF6SmpyRGpMRm1x?=
 =?utf-8?B?Z3ZtdlBxOFVmamxxNkREZmRJU0Qxb2ZZbUhlcEJndUMzMXl0OGRxUTNhWXRo?=
 =?utf-8?B?Nk5WeUxZTFdtNXVCTnV1QzVwSlJFaXRQbk14UFI4eG9QeTJwWDhNUWZWN0U1?=
 =?utf-8?B?RnFyYVBUK0ZEOWpuWVYyRnRvcDBFbHJqSWY3M01Ca05palRKdjhPdDlHeW9V?=
 =?utf-8?B?OTdBTUZwM3Vqd1Avb3pRazJqZ09mQ2kvd1FxNUovSXhwd2kxNVZ2cm00dVBB?=
 =?utf-8?B?SkgzMyt2d0Z4emRDSktReFN1dGovMThTTTVvMGhBVzkvUFoyOUMvRitLZW44?=
 =?utf-8?B?aHpIUkoxdERiWjVWa0QvRGdQQm1ZRy9rZG80UWpneTVYUlFvRit3TzdHSDJj?=
 =?utf-8?B?UHBJK3pFeXhNaW9HMFFsYzBhZGlVQnJUNlo5a3NhcEl0M0lPWklxUzVEYTN2?=
 =?utf-8?B?ZTJscXIwL2c1aUZNTHF2MDdkeFhXb2EwbWFJdVQxTEFQakFjdHZKelc0RTU0?=
 =?utf-8?B?TEI3WVA0Z2NHbnFGc0ptQUZ5blV3S2tRc0xXS0FFNVp1bUxrdDE5THJzVVA0?=
 =?utf-8?B?Z0hDS1dIWXFVeWZzdVNvMGczMFZENHdnOU9JMFZwTUtxbWNEb3NTYWMrQm5S?=
 =?utf-8?B?NGpZaDFjWTNnY3djb2VQYS9lcTg5RCtvZ1YrY0d4NVZwbm9xTUhwZUxHM1Jl?=
 =?utf-8?B?c21BaDU0b2hCTXdFYTlJVDVpYktacFlnTUhPQlV1Y0ZENGhsYUZFLzdiWUsx?=
 =?utf-8?B?dnkxaE9PSzlnVFpXWWlZWEx6aXA0bDdrc29vUWxiQ3hBMDNOS00wYXdiSDRL?=
 =?utf-8?B?RFAvNFNRZWFiMy9wUmh5NlZGeXpqTWIxd1F2WXJUSFpiOE1rL0wrWmp1STRO?=
 =?utf-8?B?UkQ5dVhhUXdNY0NzWkErODIwczVVRmN3Q3kvc0VyZFRnUkEwRXZyTWZiYk41?=
 =?utf-8?B?VFRnTG1adTBEM2RMUFdiN2ZIdG5ZdmpRR1o3SjRPbCthODQxS0ZqTTJUTDVt?=
 =?utf-8?B?TDFGYm00NFZSUDFPUDJyMTJlY3BpUjlMeFYwWE5MWlFMY3k5UHY3cW9LUmtX?=
 =?utf-8?B?Y0I2REIwOUw1QjM1bGhDRWxWVmZPNjNIZlVjbEk5dHIvVjR2ZHF3TGxLMjBh?=
 =?utf-8?B?UTlZSWo0MnlhOVNnRWIrOUlXbHhRYmxVN01EaWpRTlVNUjI2S3N6OTYxUTNi?=
 =?utf-8?B?dHVqYzNJZmpadWZ0dGU2UDROQldBazJCdGNIdXRMa3JkSGsremdBSjVtbVZs?=
 =?utf-8?B?cHMybWdyTTlOQTRWVzlOY1ZNSU1YaWpkdmVJc1RFaWdCWXFYSkd0SmNWWHZQ?=
 =?utf-8?B?bDdzZGJFMDhPTEV4NHREcHVVQ1NpQStGRkNwYmo4b0RhZkN3UjJ4SHZRVm9x?=
 =?utf-8?B?a3J0dzJSbXl1azNzOWlNK25ubXZtQ1hRMXBxbmV1ZWZGMGd4M3J4UksrUjA1?=
 =?utf-8?B?QUFwZzdoUnpDZWF1UldpSFBsQlZUUGhISjhtY0xSNWxXci9BK3QzWUNheU55?=
 =?utf-8?B?YWIzdGJnK0VMTCtlOTVSQkFRYS9sNjEreEs4elFBTSsvLzRnUUlWdmQ0a29U?=
 =?utf-8?B?SGRVMzZReXFqSGI3RHU4b2dRTnRqTUZhcUd3czJ6TU9lNTVESGhZandHNGlS?=
 =?utf-8?B?dkMyaUI0b25ReWt4aVJubzVvOXE0K0xlU1hmelU2UTJGdlUzS1RYUmJkaXNl?=
 =?utf-8?B?eDM2WHNVeTcwOVNMYXBid1hCajl0VFBjdjBKOXNYQzIvczloQVlmZ29pTzc2?=
 =?utf-8?B?WlRGTFZzSmQ2cU5UQnNSQTEvbGZBZ1owNm1aaEEvcW9xMUZaQ3E0MXpJYk1N?=
 =?utf-8?B?M0NxK1JoOXZOaVc0NFlCZk16QXBVczR4blhnZHg4cmgxNjBJRElZdUZPS3I1?=
 =?utf-8?B?Qi90bjdXRXh4NWYzNVJvWnltVGNZMEh3ZG1Ec3BXQ05ENmZ0Q2NkS2xPM2Q4?=
 =?utf-8?B?aXZSRlVJL3RJdDltRGQvSHZybHlwY0MxazZ5djNkS0ZRZGgwU0VUZlByekIr?=
 =?utf-8?B?M0ZvZGFYY2xBUzFhK1AzbGdobjkzMUhtQk9hMHRKekZLRUpIbGFkSHYvdzdL?=
 =?utf-8?B?WGJyVTltSFhnL0dNbzhoWGhXc1FXNU9jb3grLzN6TjVQbE14b080ajNBcTAw?=
 =?utf-8?B?ZHIvR0RxZG9LT29ORFZWdElzc2ZwTVNqeENyOEppaUxrZ250YkR6aUFZSndV?=
 =?utf-8?B?ZWh4cWhmTldYL1UvcHJoeTdVbXRlOVlpc1dya1VGdEVuR1NSSVU5Yi9RUGJq?=
 =?utf-8?B?aTIxSjdnY1ZZd0sxbnhWV3prR3VKNmMxSjZWeldFbDlQdW00d1ZIbDg5cHRy?=
 =?utf-8?Q?OINpffaqGUciKJ/U=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 954495ae-205f-4df2-be22-08df01234586
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2026 14:31:52.6480 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +hy6Z7tmNu1af0v+DgGdwPWzMm8NPZaAl7oX6s5P6kbQq1v7O4raYi2eaE46lJ8W/EvEZjiMDSGcI4Q54JqAp06xFI4yCuXa41F93pdUQl8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR03MB7670
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

Hi Jan,

I am not an expert in TEE, but I went through this patch while reviewing
the MMC side of the series and found a few issues.

On 21-08-2026 14:58, Jan Kiszka wrote:
> From: Jan Kiszka<jan.kiszka@siemens.com>
>
> Up to OP-TEE 4.4.0, all services that needed a supplicant where returned
> by PTA_CMD_GET_DEVICES_SUPP. Since then, services that only need a
> supplicant for the purpose of accessing the RPMB are only enumerated by
> the new, separate PTA_CMD_GET_DEVICES_RPMB. U-Boot so far lacks support
> for that, thus no longer finds such services, e.g. fTPM.
>
> Perform the separate enumeration during probe but, as that may fail if
> the MMC is not probed yet, also provide a callback to trigger a retry
> when another MMC device becomes available.
>
> Signed-off-by: Jan Kiszka<jan.kiszka@siemens.com>
> ---
>   drivers/tee/optee/core.c          | 32 +++++++++++++++++++++++++++++++
>   drivers/tee/optee/optee_private.h |  2 ++
>   drivers/tee/optee/rpmb.c          | 11 +++++++++++
>   include/tee/optee.h               |  2 ++
>   4 files changed, 47 insertions(+)
>
> diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
> index 4d67c948ec1..5600d5a4c7d 100644
> --- a/drivers/tee/optee/core.c
> +++ b/drivers/tee/optee/core.c
> @@ -41,6 +41,13 @@
>    */
>   #define PTA_CMD_GET_DEVICES_SUPP	0x1
>   
> +/*
> + * PTA_CMD_GET_DEVICES_RPMB - List services only depending on RPMB support
> + *
> + * [out]    memref[0]: List of the UUIDs of service enumerated by OP-TEE
> + */
> +#define PTA_CMD_GET_DEVICES_RPMB	0x2
> +
>   typedef void (optee_invoke_fn)(unsigned long, unsigned long, unsigned long,
>   			       unsigned long, unsigned long, unsigned long,
>   			       unsigned long, unsigned long,
> @@ -210,6 +217,29 @@ static int bind_service_drivers(struct udevice *dev)
>   	return ret2;
>   }
>   
> +#ifdef CONFIG_SUPPORT_EMMC_RPMB
> +void optee_bind_service_drivers_rpmb(struct udevice *dev)

This function is only compiled when SUPPORT_EMMC_RPMB is set, but
optee_probe() calls it unconditionally after a successful
bind_service_drivers(). optee_private.h stubs other functions for the
!RPMB case, this new prototype has no such stub, so for
SUPPORT_EMMC_RPMB=n should fail to link.

> +{
> +	struct tee_shm *service_list = NULL;
> +	size_t service_count;
> +	u32 tee_sess;
> +	int ret;
> +
> +	ret = open_enum_session(dev, &tee_sess);
> +	if (ret)
> +		return;
> +
> +	ret = enum_services(dev, &service_list, &service_count, tee_sess,
> +			    PTA_CMD_GET_DEVICES_RPMB);
> +	if (!ret && service_count)
> +		ret = bind_service_list(dev, service_list, service_count);

A dev_dbg print would help here.

> +
> +	tee_shm_free(service_list);
> +
> +	tee_close_session(dev, tee_sess);
> +}
> +#endif
> +
>   /**
>    * reg_pair_to_ptr() - Make a pointer of 2 32-bit values
>    * @reg0:	High bits of the pointer
> @@ -852,6 +882,8 @@ static int optee_probe(struct udevice *dev)
>   		ret = bind_service_drivers(dev);
>   		if (ret)
>   			dev_warn(dev, "optee service enumeration failed: %d\n", ret);
> +		else
> +			optee_bind_service_drivers_rpmb(dev);
>   	} else if (IS_ENABLED(CONFIG_RNG_OPTEE)) {
>   		/*
>   		 * Discovery of TAs on the TEE bus is not supported in U-Boot:
> diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
> index 1f07a27ee4b..b5a58df5b96 100644
> --- a/drivers/tee/optee/optee_private.h
> +++ b/drivers/tee/optee/optee_private.h
> @@ -79,4 +79,6 @@ static inline void optee_suppl_cmd_i2c_transfer(struct optee_msg_arg *arg)
>   
>   void *optee_alloc_and_init_page_list(void *buf, ulong len, u64 *phys_buf_ptr);
>   
> +void optee_bind_service_drivers_rpmb(struct udevice *dev);
> +

Please wrap this like the other RPMB helpers in this header (#ifdef
CONFIG_SUPPORT_EMMC_RPMB plus an empty inline stub), rather than a bare 
prototype.

>   #endif /* __OPTEE_PRIVATE_H */
> diff --git a/drivers/tee/optee/rpmb.c b/drivers/tee/optee/rpmb.c
> index bacced6af6c..f4a66641755 100644
> --- a/drivers/tee/optee/rpmb.c
> +++ b/drivers/tee/optee/rpmb.c
> @@ -191,3 +191,14 @@ void optee_suppl_rpmb_release(struct udevice *dev)
>   {
>   	release_mmc(dev_get_priv(dev));
>   }
> +
> +void optee_rpmb_available(void)
> +{
> +	struct udevice *dev;
> +	struct uclass *uc;
> +
> +	uclass_id_foreach_dev(UCLASS_TEE, dev, uc) {
> +		if (strcmp(dev->driver->name, "optee") == 0)
> +			optee_bind_service_drivers_rpmb(dev);
> +	}
> +}
> diff --git a/include/tee/optee.h b/include/tee/optee.h
> index d1194493780..c12fda3cc73 100644
> --- a/include/tee/optee.h
> +++ b/include/tee/optee.h
> @@ -74,4 +74,6 @@ static inline bool is_optee_smc_api(void)
>   }
>   #endif
>   
> +void optee_rpmb_available(void);
> +

When OPTEE=y and SUPPORT_EMMC_RPMB=n, where the call is made to
optee_rpmb_avaliable but the symbol only lives in rpmb.o. Either stub when
RPMB is off, or you can gate the MMC call on SUPPORT_EMMC_RPMB.

>   #endif /* _OPTEE_H */
