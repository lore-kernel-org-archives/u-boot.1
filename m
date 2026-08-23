Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F39C1C5DF81
	for <u-boot@archiver.kernel.org>; Sun, 23 Aug 2026 14:39:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9CC06406AE;
	Sun, 23 Aug 2026 14:39:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HhucggUQf9bz; Sun, 23 Aug 2026 14:39:51 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787495990;
	bh=CLN/oZMWPeoE6bicOqSM/q/8cK2Fr/5XN1YiTdsC8EQ=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EGlLy464Zdcr9QaoOU0T06HgFiF2usP2gjZrmKMIPGwSzlm5UATaNyP9IcfdI+xRv
	 W9Oto0bwHhkgUpq52Phqo+rr+sTnvTPpZDtvDdL94CmEdmxkuTYWQGoCMVXKv/Pqz3
	 d6yvXv2avNqQmO4Ztsnm8nKr93KluKldtpMmaDvRAj2sMC/4SoZMbhPAnwLFjzUGz1
	 JYcnzNcLjjhAVkvLff323r3UdSLi5SHh4by9pzHDRLdgsiA+8HHstqdYI/jdkRdcUY
	 mdPAFYLZVcO4DK6eqAe3SH0fBYzgnTen3nnm2gclNgyVnqjM7z7hXeHcqP/TIusURf
	 tFmU+/JvngItw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C26014068F;
	Sun, 23 Aug 2026 14:39:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1BE712FD
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 14:39:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id ED47E80D96
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 14:39:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QZ5Xd7hCRDYe for <u-boot@lists.u-boot-project.org>;
 Sun, 23 Aug 2026 14:39:48 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c000::1;
 helo=byapr05cu005.outbound.protection.outlook.com;
 envelope-from=tanmay.kathpalia@altera.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=altera.com header.i=@altera.com header.a=rsa-sha256
 header.s=selector2 header.b=gXiXLX2o
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c000::1])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4A77280D92
 for <u-boot@lists.u-boot-project.org>; Sun, 23 Aug 2026 14:39:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yPMWqFtXeV7OMiwh3KshsfGq6/0IhCqKQ2We2cf7rIh07DvXB03+z7Be6GpMLtVMJxIWC2xiO60mMoJq34gUTOHZiLmhdivuQCFjNOZQai+MoARW/wOpszhGGeWMAYNe/dOgdJs03OSF1jSziMuBgKwmvxIrXYK2ITe04haLJncO3/3z0M/756K3NAEnEuNolwC1paF/k7UtVmoZmJwZp/OVy0h8XCGyoi2tcBvjhnOSd3MQNO/S8atvsEMSp5hu8bWeP2CVvpcVCtl2+/WzJQOChRoPVwXqTS9NzobjXO7cMwlrAzdCNQpe8bD6sHJgspdP5TNzrzsKFjH3CKNhZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CLN/oZMWPeoE6bicOqSM/q/8cK2Fr/5XN1YiTdsC8EQ=;
 b=EVcx7HKCu0vngiNJRrxRSXSs1xQ5bbVVGpEV6ZMm5sYOMONdJvsd15KEgflLe8cvOAGb6bcKhP04c6ckFBu+VyZxOP+WijQEvw+Bsdp1YTbWJasKQ9vlxobbeZtRkbH8KHpbqScCjcXhA7ajWJvZ0dmXqcjYAw4ql38QeLLSYaCd6ihq7H/aqhFlaPy/42i9vDM08OVt/WImK/wQqmjouNWs7NKgTQfonWjVd73S42rVH2SaYEb0hZXtcE4k3AV5P1jO+jH1XgcBIkWePHMGbiQIKMBSoBk7SUhWYNHf8lo8IxD3jaUiwru4hWcZQSfYKAr4DKS6qSpwfiTvC43qxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CLN/oZMWPeoE6bicOqSM/q/8cK2Fr/5XN1YiTdsC8EQ=;
 b=gXiXLX2ogP2ky8x0y+syOhBmIb0i0TXkN3JjgTHEL6B+paC/xMAzrmHO7XvUWouXu69snwjEM4BEeaeAERcXTnOE0aGwHR6rhlVHQzylvrx2gb2BiEPnrzzbl2JNn5Vuqn1K38rDnvJDm7Y4uoT4wFk2bCd0UNYq0AKazIZUEbDbU0JHEkzQyJvguwJWkB20beCYAG1sUneKTrE6kdFrVYk3d/MbCYIsR1M7A2QROzsDjT8jdW1JBEZ0U+CyqWuh6cWH9MT99mfyVZPDayuiS8mwOHAiX8hIsDWo4zkt+MtJC7NPtwzOdkdxU9sdL0Bc8knF+gwAAh31JXngJSUhew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by CH4PR03MB7698.namprd03.prod.outlook.com (2603:10b6:610:244::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Sun, 23 Aug
 2026 14:39:43 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::2216:93ef:67b:9e04%3]) with mapi id 15.21.0339.012; Sun, 23 Aug 2026
 14:39:43 +0000
Message-ID: <5b98ee84-4a9a-45a7-927a-c2f98191d312@altera.com>
Date: Sun, 23 Aug 2026 20:09:35 +0530
User-Agent: Mozilla Thunderbird
From: "Kathpalia, Tanmay" <tanmay.kathpalia@altera.com>
Subject: Re: [PATCH 2/4] tee: optee: Do not warn about
 TEE_ERROR_STORAGE_NOT_AVAILABLE
To: Jan Kiszka <jan.kiszka@siemens.com>,
 U-Boot Mailing List <u-boot@lists.u-boot-project.org>
Cc: Jens Wiklander <jens.wiklander@oss.qualcomm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Sai Sree Kartheek Adivi <s-adivi@ti.com>,
 Alexander Heinisch <alexander.heinisch@siemens.com>
References: <cover.1787304541.git.jan.kiszka@siemens.com>
 <d85ab654b884cd830512b9807a7c1734316a0d0a.1787304541.git.jan.kiszka@siemens.com>
Content-Language: en-US
In-Reply-To: <d85ab654b884cd830512b9807a7c1734316a0d0a.1787304541.git.jan.kiszka@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0042.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:175::10) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|CH4PR03MB7698:EE_
X-MS-Office365-Filtering-Correlation-Id: e4b8cb4b-83c9-459f-c3ba-08df01245ebb
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|10067099003|6133799003|3023799007|22082099003|18002099003|55112099003|4143699003|5023799004|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: a1IWnFjpAqYIjJSoaAL7301UbYAbycw45m86LCe8w4uxkgzZZxOK0sxXB3/ZOrbdS4cRzvkblKbjVI+ryj/PRY3VgXGAzpH3cjANAUKAYQ/VahTULHdHU+XLKrnwbSPsmxcsPMn3g5UPlQklF4SroIZjw4cot1s8pSHxcfJqz+gSVsyt4JzLYh8U7aVngui2o483c/bqRMhoag6zOi3qKDITw2fiehXkjS5mVnMG7867kFKGaCAdDCMQwFSJ1cxm4Rx69h8i8WalUJczFMGNHc7BTZ3ajOEHtuxM4Nruu0XbCRR1PA1mv0yZVO9ejvLhtqSLvzp/HXiak6/iQWKbE4VtWAmkae4K+R7W681p2u8swT9DIgJu33UtxW0AFKXFFjNquw8bzqcw2GfyDwpLEhYcum/pFmzOjaSPxS8MaR47tzBNdDTua22tvc4LLW3gwx6f68QT0/0WdDemWyPgWxnEY9+yBzfZe6qlt0RmXPcqvYwQUg9UmC40DEfXImfP7vV/NFwDkRXxdV1h1lBGlQa3rs2QHOJx7IyzDOd8yhHCNb151FRUGVct/A0yG2Z+uBlm1AZZlRZBMtUVtQUU4AK1HuDZ5IPtRm0ApaWq+Aocp0TYsbUeLc90ZHawJbWcwvKXPtlcq0Z8/rOsX5Fl4L+YV/bE9OjGjIj/AaFUe3k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR03MB6208.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(10067099003)(6133799003)(3023799007)(22082099003)(18002099003)(55112099003)(4143699003)(5023799004)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OHZBeHRHNXNFTnVIeGVBbS9ubVc5dTR0QUthUDZNQnBmTVRRTjY0N2Nyc1Mz?=
 =?utf-8?B?STdVQXV2RnFPcG82SitUWW5LNitOR3l6dWs2b0RXSVdYYTQ2Z1N3bndkbTcy?=
 =?utf-8?B?c1NSRFFtbTlpUmVLaFRQY2dXS3p5b3hyMUlwdnlLd3pjdjdqWWJsRHd6bXFo?=
 =?utf-8?B?S2hTMjk1amRWVnpuK3RwblAzQU1VWjNJTkFtZWZTeFVpcWVZYjYvbTMrRlF4?=
 =?utf-8?B?TUxSVUVQOW5YOER4QmVUUytHM2doWkVENlJpdHo5cmdJODc2Uk02SDdJR1Vq?=
 =?utf-8?B?VHhJdHBJa0hZeElYOUpJUUMwWEEzQ1N5S0lFSWVIaTdkNG5NOEc1WTZFbGUz?=
 =?utf-8?B?RXYvQ0wrZ25UdFlHRDFHSy9ZVi9SOS9kY25BenBQcXVUNTh6TjZNQ3lqWmph?=
 =?utf-8?B?dnFiWjJxREM0Y3dGdUpSWTRldStkSENMWkQ0SThvZWNCY0E2eWtDUmNENlcv?=
 =?utf-8?B?V3R6YnBDbXFNS1IxM3hGLzVjT0dUdW80SUc0T2hZTit5ZllWOTQ5UTZlRXpi?=
 =?utf-8?B?bEQ2RHlNTHEvMjJRU3M2U2FvSE5sU0Z5SkoydzNDbTJCWlJhcVlpR21KSytT?=
 =?utf-8?B?dDJRY25IbDdheGxuT1EzaHpha2lqb3YxUHJ2dHBtNFBTWHphYzhuT1htdUgz?=
 =?utf-8?B?SDIrSVNBWFZkWkZ5Q1BqVTB1cHM4WkpML2FPWEloOTFVQzZGWkN5R2hwbytJ?=
 =?utf-8?B?eE9OaFNWcjNGRG5zZU13SWdzeDg3OU9lVVpCL0t3eER2a0ttK09hbGtFbkVT?=
 =?utf-8?B?cG1lMTJWR2ZXS3FwZjlrYlhja0tySk4rYkRTSVpyR2dMaUZkdU9mcjdGT2No?=
 =?utf-8?B?UUFVWTJXMDZRZmh6TEF1U0EzT3B5TXRRLzZCRUJRZnpHbk1kVWNGUkN4VWpF?=
 =?utf-8?B?dUNnTy9YdURLTk9palF4aG9oSzlKQ0R3QmVYZnI5b2FHZmRTUitXYVRQdmU0?=
 =?utf-8?B?Q291VGtKcFRORGVIa0JxdkpPcTFaUk1pVUpzYkRvSWV5cmJhZjJQSVNvSDFG?=
 =?utf-8?B?ZVFVY0YzdkFGdXFlaGNpZG03QkxhYUpvNUY1eGVqWmhCYndsNVpZU3FWUUNQ?=
 =?utf-8?B?di9DYUZjN2kyYzc1NkJaZUJXV2RsYU11dzRWb3RySmoraXZZczJzVit5QXBZ?=
 =?utf-8?B?Y0JueHM3cjRxUzlobW96VnFSRmVLa0llUFd3d2I0V1hkeURGZG9UWEpQU2My?=
 =?utf-8?B?K1RZb2k5L1hpUVo0VGkrQ25LS1htbGFMZ2RwOE0vMms5eXloS0Zncis5Mjli?=
 =?utf-8?B?djBtWjA3aU5HRmIyNHRtMzMwWitCbHA3dlB3T2xOVEEzWFY1dUxxYU5pRDNS?=
 =?utf-8?B?dWdsdzlja3huaGJTUDY4T2s3L1BYWDZmNktUM0JoQkpnM1ZidUZNaWtsZDcr?=
 =?utf-8?B?RnJMcmozMkh4dEh6c1UxVGxYcXl5Sk9TbzJMRzNBL01jZnB4eXQyQTUwNEhu?=
 =?utf-8?B?bnRtOWt4Q05NZlJQRDVMcUVqY1Nmbk9lMjk5MU5WUCtTdmN4MHVHK1hLekxG?=
 =?utf-8?B?RklRMkVwVWwwMEVDWTJkUmtYY00zWDBhS3dLLy9ncG5KSlhFWHpKWk10d0Nm?=
 =?utf-8?B?WGhEME42cmxzTDJ0aUdNNVlnMHVrMTE0aVRDSGZYZmY5WjJ2ckhhL29zNzB4?=
 =?utf-8?B?V2JXLzRpS0NvS25hclduTlpuTEJOZHFESGxPSlAxaEh0L3VERTlScUcwNVpG?=
 =?utf-8?B?cWJnNEtkOUF2dTJ5ek0xd1g0MytNZmI5YkVZMFJBWFl5S1VlWGZRckUvbHNB?=
 =?utf-8?B?K1VXWWVBaUd6a2picnpWSjR6dWRmbk5WY290cUh4d01yUU1WaWNETlY3dzVI?=
 =?utf-8?B?WmF5WTVTWnRXRlVZWnJ5aHE0REdLNlZ3RnZaMXJIS095UnY5RzN1SWRsVWVO?=
 =?utf-8?B?YlZKeWU0WS9tZ1B5MGdvSkpHQjBiTEw2QXUwYlZ6bTVmTnUzWmV3aUVxMWlV?=
 =?utf-8?B?eW9QMGJZNVNVQ0FGUEFRQzQ3UlZOOWJmdDJzcUFHM3NaV0kzZVVLaThmUnVR?=
 =?utf-8?B?VzBaMEpMTHIwTUFTYUFsYjhDVkpiV2U3bkovZ0dpSWZla0h1KzJOTkRMRW84?=
 =?utf-8?B?S05NUDcxbmd4STBhUFArWXM3MTV1TVdKcWlnbGI2UVlyT040OVBWQ08vUE82?=
 =?utf-8?B?UXQ1OERKUlRDVDE2aUNDNmpPQm9zaGhUZGJKOFNSU2oyM0JaZXRpamRYSnlh?=
 =?utf-8?B?ZzBMYjZMWFpJbkYxMm9MeGFGaHpUWHhkOTFUaXdiMkdpdExRanV4V0M5ckd5?=
 =?utf-8?B?MmFxM01ZSDgwR09qVHZWOFVvVUFYSkFsVG9ZS1VGblk1b2xmbVF1SmlOMFRa?=
 =?utf-8?B?a1lOU2pBWUZWeml5ck0wbFMwQktsRjNXTHprTUhXVW5MaWo3OGs1VGM1Yy9E?=
 =?utf-8?Q?kHkvoRjbge2rc2gI=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4b8cb4b-83c9-459f-c3ba-08df01245ebb
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2026 14:39:43.4314 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aoW0nGzQ1okOvgeO9W1QaZoKl2ibf+1K8Ak6QHbjnfdNPwunxZUtHoGmPXFDn6s01yDDwzi4kqT3mLZVtI/txW+MYKLGDhLv5eSK8DCDXkg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR03MB7698
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

One minor nit.


On 21-08-2026 14:58, Jan Kiszka wrote:
> From: Jan Kiszka<jan.kiszka@siemens.com>
>
> This is a transitional error that is resolved once an RPMB becomes
> available. Keep it as debug output only.
>
> Signed-off-by: Jan Kiszka<jan.kiszka@siemens.com>
> ---
>   drivers/tee/optee/core.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/tee/optee/core.c b/drivers/tee/optee/core.c
> index 5600d5a4c7d..4b1396b8652 100644
> --- a/drivers/tee/optee/core.c
> +++ b/drivers/tee/optee/core.c
> @@ -126,7 +126,10 @@ static int __enum_services(struct udevice *dev, struct tee_shm *shm, size_t *shm
>   
>   	ret = tee_invoke_func(dev, &arg, 1, &param);
>   	if (ret || (arg.ret && arg.ret != TEE_ERROR_SHORT_BUFFER)) {
> -		dev_err(dev, "Enumeration command 0x%x failed: 0x%x\n", pta_cmd, arg.ret);
> +		if (arg.ret != TEE_ERROR_STORAGE_NOT_AVAILABLE)
> +			dev_err(dev, "Enumeration command 0x%x failed: 0x%x\n", pta_cmd, arg.ret);
> +		else
> +			debug("Enumeration command 0x%x failed due to unavailable storage\n", pta_cmd);

Prefer dev_dbg() over debug() so the device name stays in the log, same 
as the dev_err path.

>   
