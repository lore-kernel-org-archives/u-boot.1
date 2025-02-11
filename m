Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 136BDC0219E
	for <u-boot@archiver.kernel.org>; Tue, 11 Feb 2025 04:34:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 682B98043C;
	Tue, 11 Feb 2025 05:34:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="Or9AjslS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3FEB805D7; Tue, 11 Feb 2025 05:34:42 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on2071c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::71c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7152980EB0
 for <u-boot@lists.denx.de>; Tue, 11 Feb 2025 05:34:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oBhqtNUGOOBNTbjBX/8xlw33bI0zTnfNp/JvVx0IuQqP74F5CwKdPI6M1tVqLF2GLX8g6Hym8YEiJ3+Xu+yhV4xaKz4r8sKpS9Qbc16r21lkmYKm8vBEODGKJyOM4FIMfRp4decEaDWc4r936WwR9izYkut39Fal0nDcm7xKCdqoZ9ILp2zYFKcMSLl9GZW00ylGSeGBCuv33EwBKubynoLtCjbz3uWLW8TlBzcztmJgQ1BM+0RZSx8nAv9V/36YGY86T/acxMTbVJPBDT1bRmVPKPnQnXia+7e3ncgoSJcn9CWPhf1XNFIliAmJZJu4uvSM+1GLRIlGbxUWRPITgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4umMBA2xK2rd9GaVL9SBZr9INXlq3pugtsKZgG574e8=;
 b=e+HtCaFbw6XIH9YGNxy1MWWU4CM+lZxibG23LkF7ZDf4GzJ+VXABpTFNuTXVM7N6in3Djxc3lcG9Ib8HfQgxZ48kh1KHAE/gNZGZcWkz2Sx+1khrh+eI8eVWmTyKDQvw8d5TZ8FmI/UdyytXw21ujMohdLlXtdEy7yl3v1ea8/kDfczdWPOgluV0qCf1S8MIdbzJus6V8DYshkXzXex3KDOj7ESrkAeaVtsaG5yka3JMkA3cuSiePLGmjQOfpnqX/6CuI7ZYF00dgHLnHbcdFPQop2PZZQbT5f9VqJezEMr+mp1fo86JBsmziefgz9han+DkrHNiIijpWmajwC/Bmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4umMBA2xK2rd9GaVL9SBZr9INXlq3pugtsKZgG574e8=;
 b=Or9AjslSqcQKl89SemNg10ybA8s7+RU/2mdHtNTCM88yH1yYH4cn1utiO5gU24+z8YKyLN6ywGQ/R9KDVPQdj3HH8rTBAVNWBzSGeJRIgkugftI/sa7deLFXve52/NDW2GBa5iHzvXERUnqRJPkWO0QpJirMeAr3erK1Kfvk72ylrgiMzcsw8O9WZTxKN6y7gvoza3tF0Io25kUEbMQUbJsKSzjtzwkLaFdehOc9dddfdAtdZWnsaT2uZ/uWvt1EA8U5q8g0xuBoze2ef72nAkSNnAlX1xBYkiY47rgewSOs8O462raq3mgP9xAPWgQtipmcX9C01qVNOgIusP9Lfg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:4b3::21)
 by GVXP195MB2556.EURP195.PROD.OUTLOOK.COM (2603:10a6:150:1d8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Tue, 11 Feb
 2025 04:34:32 +0000
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::369c:a760:5bf9:8d4a]) by AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::369c:a760:5bf9:8d4a%6]) with mapi id 15.20.8422.015; Tue, 11 Feb 2025
 04:34:32 +0000
Message-ID: <e133071c-4511-4b7a-9e21-c65289c2fb33@phytec.de>
Date: Tue, 11 Feb 2025 11:34:25 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] arch: arm: dts: k3-am625-phycore-som-binman: Add
 custMpk to all images
To: Daniel Schultz <d.schultz@phytec.de>, trini@konsulko.com,
 u-boot@lists.denx.de
Cc: n-francis@ti.com, d-gole@ti.com, nm@ti.com, afd@ti.com,
 upstream@lists.phytec.de
References: <20250210073623.2994856-1-d.schultz@phytec.de>
Content-Language: en-US
From: Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <20250210073623.2994856-1-d.schultz@phytec.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KL1PR01CA0117.apcprd01.prod.exchangelabs.com
 (2603:1096:820:3::33) To AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:4b3::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4P195MB1456:EE_|GVXP195MB2556:EE_
X-MS-Office365-Filtering-Correlation-Id: c26cb2c8-1674-45ce-3f43-08dd4a556110
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?THNVVS9KQkxLTjJQQlBIT1M4cnI1azJsc3RESjF6WGlPc21NTXgzZHJVeWl2?=
 =?utf-8?B?T2RPZHlZUXZsTFUzWVc0MXRHZTZrcDhMWEZBVnBCa3hXemwrRTQvZndPTzhm?=
 =?utf-8?B?SjhRR1p0SU14b0dEdWRjYlVFcklOSmpZRjlETXhOUVE5T0hOYi9aUGV2bTcx?=
 =?utf-8?B?eWpUK2V2aDI0SW1kekkvQ1pjV1h6bDErVXZlQ2N5TzVLaVdRNDRZakg3Zys5?=
 =?utf-8?B?bnErNnpaL2hUcklnTVBZY09RblJGU3Z2YXZ3TzByd2o0dXFMSktMODl4ak5O?=
 =?utf-8?B?UklaekRQSFBOMFhPZGtCdDRtalhWcm9PNmlMemZhMGtZcHZtSEsxQ3pGZXpF?=
 =?utf-8?B?ejBTY2xjVWR4YzErdkEvaEh3TlFGNFgwNzZLRWphU2w1VElEWXpEd1JqSFkz?=
 =?utf-8?B?aGZkcFlvRW9ZRDRzWnhjUFEyRXJGZnZvYmV5eDNkcmt1cld1MGorcnMrYkdm?=
 =?utf-8?B?NnY0V3Y1MGxON1lxY3JvWDFWM3pkdTdJRzU3SkpYWElIY2dYL0VrMkY3OVVX?=
 =?utf-8?B?ZjRJNkgxMzlOdjgrNXV2L2pITXZ5bjF6OHIzR21NclhJNGZEWS94TXQyNklu?=
 =?utf-8?B?N09qS1l1YnZ6OTE3MXBTQi9lM3JBYzZYZUZHNGp2RU5rUGVrcXl3ckszeEdN?=
 =?utf-8?B?dkRCeGt1cjB5MzJKaUhXakZ5WTV5TVUyOTNmbFpOMVZRSXRWVldjbWxiNzUz?=
 =?utf-8?B?UTVoWFcxNlpLYTZ0Ykp0VEJ3ZTVMMFFlQndxakNSc2VEOElNd0czTGNGZ0VM?=
 =?utf-8?B?b3NyaXliWkFkNDdaZDJCWUloUXp6U1pkcmdvcWhjVmR4Z1dMUEl0cjB6SktY?=
 =?utf-8?B?dnhkRzM3ck0vTWtGUGY0TExmUzRHU3FDb29rQm02cFVycTduZEVDNlpDazU5?=
 =?utf-8?B?cmw5ak5JR3U1c0hDcFNXVWZUdzllMjZ0amdIUzkya2s3S0FCNkY4Q0hLRFdq?=
 =?utf-8?B?WkNnM0dnVnk5WXlIYTRZdzlFYlFqQzdINWNtbTh3VmRJSm9meGZXTmw3amVz?=
 =?utf-8?B?ZmJVcjN4MEMxVERQbDcxQkFWTFN5bGJ4akF1bkIzZ00yV2RsWWJSUmhGY3gx?=
 =?utf-8?B?U29IVnNsdGFEU0pvTE5lczNaakVJK0lMdDR5N1hjdHN4U0R6SmlsV2pkRThy?=
 =?utf-8?B?YnV2N3FKUGl1aTBENk5Iek9qN2Q0VzIwOVV0Qk42SFJ0ektaQ3M0TW9ramZj?=
 =?utf-8?B?aWlCU1ZxZTZUc2lJd0dKY21XQUJJQy9EZkdZS3dkMnlLbm5KdnluVnU1TnN6?=
 =?utf-8?B?b3lOK3doSmJVb1daR283U2FsR3ZrdmMvakpvdVBKNUlqajJBWjRZYVBVUnpa?=
 =?utf-8?B?MzVzMGhLU1l4NDFlZ0tLQm8vb0pUNjNtR1lERVJUWVRRS0dIVk1iY3JROUxZ?=
 =?utf-8?B?bWtTalA3c0EwMXJya1E5NVRpVlhwNTIvSlhHTktNaU5ZWElmY2JEN2VTeFI3?=
 =?utf-8?B?U3E5SXJXTWZVNG4zVk81U0Y1Lzgyakl4d2JGc1NLNXdNSjByY05FV082MjBq?=
 =?utf-8?B?bTVRdURPbVNscnJuRHdFeGJZKytPRDM1Ulp2WGdHOTRPWWg4VzdFUFlncWZx?=
 =?utf-8?B?azV6YUN2V2toTlZSamJXRzJkTmpOaEhuN240T2VNWjVOZ0hXWlRkdWFhdWxT?=
 =?utf-8?B?dFJiNi80RWczck0zT1Zzalh6N3RjSDZkQWw1b1VXMUI0czZ6YTJudDZEMVpM?=
 =?utf-8?B?Q3U5dlBiQktrbldGR1dKOThaQ2lnZktPeEU4dVBoS3JZUEJUQWYxeVFSWi82?=
 =?utf-8?B?VG9wcWVrUDNXQkRIVkptckFHcVM5T1VRZkpYalFkZUNFb3FwTldXK0hwcHVy?=
 =?utf-8?B?ekdJVzlxUllvd1ZqdEhSZ3h6bFI3Vm5vVC9maUVJb09qd1I4N0xKRDMxek5I?=
 =?utf-8?Q?VKsfgOlqeOLlE?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4P195MB1456.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TzdvTHpYWW5iRjA5S1cxZWh3UG5pK1pFR01nWVF5RjVveWJLd1RtSnczaDlM?=
 =?utf-8?B?WFhDUnZXSnU2RzU2bWdUN0k5TmYzSTluUWx4RU1zRU9ueEdBU1pVOStDSno2?=
 =?utf-8?B?V3V5R0daTWJWU2ZNcVJWeGNlK3RNSE1MYTZTaDM4WDIycHNYd0NRSEtGa2oz?=
 =?utf-8?B?VXRxeDFSZ0RGbjV5N1VlY3l4TDkvekNMUGpMMEdxMHdteFk2a2F6RUhSNFlY?=
 =?utf-8?B?czg1cG14RTlEWHAyaDM4WXBpSXpHNUgvWFMzOUtKaFdTNGxBeDdIbkRKZmkr?=
 =?utf-8?B?UzVLNUVWZXI5Ulp0Q20xL0pYWDlBSjU1WUpyc2V4b253aGtvbFBXYTBYY2FT?=
 =?utf-8?B?SXBCN3owREdYUFp4WXF1NU5RODc0ekVFVGk1bUtpSzFiOGYxZ0taaGVMcGVQ?=
 =?utf-8?B?THl6T2ltQWxvK0FDVGNWZ1ptQ3JwdWlpQk9mdGMySzQ1ZXZjSjQrY0xKaWpP?=
 =?utf-8?B?YnVhM0p6TXhxbUdLTU5EellCMmZIWnNwaEV6ZVI4WFJhQ2xOTmFISGVSZ0Ru?=
 =?utf-8?B?d1UyYnFxNTVJYis4THNsUStrOG5LZDA2MlpxYmMyczVVQS9NUkNSdldVTm9m?=
 =?utf-8?B?YVhpdStnNnowZzlUVVBLc0tlUUpScVlmay9heStjcFpmSDllVVNXY2gybFBZ?=
 =?utf-8?B?dmZDeEpwb2wwMEZ0eFRMRGRlenpNZU11eFZxZzBpWGVnRDFvWHFrZXJIdnVN?=
 =?utf-8?B?RmhZa1AxWTIrMllpbnB4RTdaYTNqNEErSkZUTzFVRDl2UzVGNDNVRFlQNHBY?=
 =?utf-8?B?MkRia1RWM2wwZkhtM1ZlaUtnZ2RCZWJRNDN2QXVDOExDMFQyWTMyZ1VkL2cv?=
 =?utf-8?B?S2dHYjFMeUVOcERUSUlNS1R5SVpNUWZoNjBvK0dYcDdxNTBrcE1CRTFlZk1X?=
 =?utf-8?B?VlFUUk1neVFIZlkxeTJwMnVZVHcyWXRMOE9nY25hVkdkQi9Edk1Dbmdqbm5Q?=
 =?utf-8?B?Q29UOEtHR3c5ZW1YK0hZdTNmamtUdFlsMjVuT0orRnJUbzZCcFBZckhZYjkz?=
 =?utf-8?B?UE5xUExjcEpmNVVQMnNROXVCVjJORS9PaDJDVUpCNUszek1PeFVrNEx0VVZD?=
 =?utf-8?B?Vy9HNm1xWHdPbTBBTC85enZkN2VQZlZ0SnhFSkUwc2VNSm1qdmdEUzRlQjVV?=
 =?utf-8?B?K2lkRlo5ZUdkaWRZaE1jdVFtZzNoaWFQMmZVbVdGaHEyQzdWcVh2d2ROd2tj?=
 =?utf-8?B?ZjVCdTFNZzhyeGhUY0QxODFJRVkxd040SFpMS0t1bHpuYm5RbW1wazhNZ0pN?=
 =?utf-8?B?TmYzdmUrc3B2ckc5MzhGdjZabWNyOHFTcDVtajBubDAyOXdKSi8xeFBKKzQv?=
 =?utf-8?B?M1R1UUliSm9WY2YvTUs4NFlqbFJSekFtT0RFYUUxRnE0SFkyTjJqVjV4elJF?=
 =?utf-8?B?clFxdFJ5YUF6REs4ditsRWFJNzEyVm1WdDlyMkFzMjJLalJtWEZPd3NKUEh1?=
 =?utf-8?B?bkI3NzZTVGJQT25iOWRKWmNiOXNDTTkrUVpuaFB6N1J0OHhVVTBRZ1FkR05t?=
 =?utf-8?B?WlFqcHh3ZjdBRFpNU09OQ2lOUGVuRUd3TWNHVVhCRmU1VzBpVEFWdkM1OTF0?=
 =?utf-8?B?RCtrSmp3ZzVlZmxZbTI4VGJJRysvUkZUaVdFZkFtVDRaU0lnZTJOSXNGUENS?=
 =?utf-8?B?RTJYZUM4YTM4Q1IvVDEyamF6cnZCaUV0bjdDbHFlbzJaTmwybXZkcklBd29o?=
 =?utf-8?B?ZDB1ODdwdEhxVEZYSDYwdm1kL2pNb0NrZHlWRnJiK1ZFbzNRL2ZnMUFuYWla?=
 =?utf-8?B?Q1NiS0VTTzdHU3A1WXN2RDd4QXJ6L0FTSVlaRW1pOHpUWFRDbUhJK3ZJOGhV?=
 =?utf-8?B?UldpVUhVNUxMMWZScjVLV1RzM3lVN3ZSNm41dWVXTCtPUUx1aFdPdGY2dmxF?=
 =?utf-8?B?SHRzbXp6WXFHdjdxOEVwRGEyN2JHTlE1VFF4dGs5eVlEdnJuY1U4RlZlWnhO?=
 =?utf-8?B?ajNpdUt3SjczQ2NWcmZJNFN3NkxvTFhnUmsvZkM1eTBidU1QZGZKZSs1cHRV?=
 =?utf-8?B?VzVMQlhTMWpta0hmQkJRbDBSVXdpZlQrSmJuS2JyTnRMUjMwV3ovWDZXemYy?=
 =?utf-8?B?VHJ6Sm1kSUdQdmhwVDlPdzVmMW9ZaDI5Z01iVjh1Y3BjbGhsZThNZDZOcVAr?=
 =?utf-8?Q?yI88sDDg2FbBGvy+WIhWhdHdZ?=
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-Network-Message-Id: c26cb2c8-1674-45ce-3f43-08dd4a556110
X-MS-Exchange-CrossTenant-AuthSource: AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 04:34:32.0399 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dXBVzVXx/D7tAMK5ktaPuviGm2EDGyAezjV1kTgj/4AUbxQl8ljJtxMbB0zAT3UPVvAD4ycTdev5lKzd2JOV7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXP195MB2556
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

Hi Daniel,

Am 10.02.25 um 14:36 schrieb Daniel Schultz:
> There are some device-tree overlays and firmwares with missing entries
> for the keyfile. Add them to sign all images in the U-Boot FIT image.
> 
> Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
> ---
>   arch/arm/dts/k3-am625-phycore-som-binman.dtsi | 49 ++++++++++++++++---
>   1 file changed, 41 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm/dts/k3-am625-phycore-som-binman.dtsi b/arch/arm/dts/k3-am625-phycore-som-binman.dtsi
> index 31456d23167..7c72da6deda 100644
> --- a/arch/arm/dts/k3-am625-phycore-som-binman.dtsi
> +++ b/arch/arm/dts/k3-am625-phycore-som-binman.dtsi
> @@ -227,6 +227,24 @@
>   		fit {
>   
>   			images {
> +				atf {
> +					ti-secure {
> +						keyfile = "custMpk.pem";

I don't think you have to define it here, because we are making use of 
the ti_spl_template from k3-binman.dtsi which is already defining the 
keyfile.

Regards,
Wadim
