Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 046E8C83F1B
	for <u-boot@archiver.kernel.org>; Thu, 17 Jul 2025 11:09:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 602B3833D1;
	Thu, 17 Jul 2025 13:09:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="s0CZIZ9R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 50787833DB; Thu, 17 Jul 2025 13:09:23 +0200 (CEST)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on20602.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2406::602])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09121833D1
 for <u-boot@lists.denx.de>; Thu, 17 Jul 2025 13:09:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=naresh.kumar.ravulapalli@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MbLnFQ9GImV2q8GV5+XkgoW5weAhhmTyjW1LhR5OdaxlNRBwBXvoYDwcV/t7fTIi/wN4iv/d8IVpvy/ScpDyLJGAfCVSYm6yjURpH4dMVlmRI558QyKKETk9A68Vfyl2tfziPSjd7YLNZA9QbZdVwVQxn/+SnZAWThMFNlgGwn1GoDUkoKt4hworMXiFE7nAm/cZbMGHtIOlx26FtUiAOZ0p2/xP+b+wHG1P668fCfXpJzFsCfu51R7KE4OkR+V8uolKzWclee3GLn7VDDxO/FLveXkjKjfh9iTj2pcGUqHCEG0GT4Vv/j+sXGhuxY4ABNMYGMirq0iwZvUdI2XSXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3bSNMHQ2Wvz+aM+qJ+hXcdwznGsjbUxVdG4NVw8cTQs=;
 b=yAU9Ru8cyNrsIMY9/zDsgcXCZBxqoEDp1Kp8PX2N0e6LsmxyYiaJgyeClF8xhvm1uH6SK+mCs6xsN8H5MCCjrvWhqLSZC0roRxzdchw1z35XVzCbqGpc0lzff/iiQcbpRwLt8ZNXyyL3ezPHr3O5j17YVTP+1t5PU2r7ceFiryYZkPEPkSemxvx5+YPzu/QcvuxoXxRKSz2ltHfJ9LgPfuEcmT55R+qvSQGswpvgQ6JZnCEr2NdZO4MR2Kcv3xyGjC19uKpI/EHyQH4IM+3OSlqrxSEqLEm0NNlOjsEFrpWc0cfrFscvEpFeujk13pbYX3Xg3L9wue+/YHD6shevzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3bSNMHQ2Wvz+aM+qJ+hXcdwznGsjbUxVdG4NVw8cTQs=;
 b=s0CZIZ9RPp+mQvd6N9KbCMH/1F/wy38YoBC/uKvOtExJk8sVJVLooBTxsk+ujj1cugTN56BgU9BwvypNjGuypAyntDLzk9lKabLPLs5HYKEll57Cl9srOLXqaIbjPYxD6jyQlLEPGS+na3+6dJ4ct2FBOAcXVHqhyyabFykoWuvtu/asIPxp9bwbW4dbxw3ieSnPezBsmuCUaW8fSKNluU5Z/j0xbjc8rAqKrK2jwVZw83QzikXfiwbA/9Tq6slzUNEuhxd6Mmk//k8T+sgiEgm/FuzSOxTD94/553fWhub7gaV3d55KfU+bmE7pV2X0gptA3GiF9TgdUPHg7wo+mg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DS7PR03MB5542.namprd03.prod.outlook.com (2603:10b6:5:2c5::16)
 by LV3PR03MB7588.namprd03.prod.outlook.com (2603:10b6:408:282::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Thu, 17 Jul
 2025 11:09:17 +0000
Received: from DS7PR03MB5542.namprd03.prod.outlook.com
 ([fe80::c3b6:3b8d:4383:ab7c]) by DS7PR03MB5542.namprd03.prod.outlook.com
 ([fe80::c3b6:3b8d:4383:ab7c%3]) with mapi id 15.20.8943.021; Thu, 17 Jul 2025
 11:09:17 +0000
Message-ID: <173ca3dd-a283-4d37-92af-249bd41fb101@altera.com>
Date: Thu, 17 Jul 2025 16:39:09 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drivers: i2c: designware_i2c: Remove clock disabling code
To: hs@denx.de, Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
References: <20250701045218.8403-1-nareshkumar.ravulapalli@altera.com>
 <a18b47c1-f872-4364-8c14-f18ec6d59384@cherry.de>
 <68f95dc4-a1fb-256d-7911-38bfddee6e6c@denx.de>
Content-Language: en-US
From: "Ravulapalli, Naresh Kumar" <nareshkumar.ravulapalli@altera.com>
In-Reply-To: <68f95dc4-a1fb-256d-7911-38bfddee6e6c@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0054.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ac::6) To DS7PR03MB5542.namprd03.prod.outlook.com
 (2603:10b6:5:2c5::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR03MB5542:EE_|LV3PR03MB7588:EE_
X-MS-Office365-Filtering-Correlation-Id: eacb62e1-4dab-4f1a-9593-08ddc5225ece
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R0lFQjg4alptbFZqVUVKSVFDMEprZDRSL1JOY08wcEFhNFA4L2ZGRGZOakU1?=
 =?utf-8?B?VU1mMWxpd3Z0eDc5ZjlKNEh1WnVjNDdvdDEzd1VUUXZ4SEJRNEpIaVFXd3RE?=
 =?utf-8?B?QjZWRVhmdnAzaHZBQnorbTNiYlB5ZkZYZXJTeU8wQlh6MzBneHlNd1M3RzRm?=
 =?utf-8?B?bVhNMWc0YXNLcWhYYTF5UnJjOWJ3ekN6TUVGVkdvRVA0TVB6UHZGeERSUjRR?=
 =?utf-8?B?MDIvODJxUWNPbU9Wbi9CVHdrcFNZaFoyM01uZzV3UmtCdHlJeGZNQm00NUFP?=
 =?utf-8?B?SDlPSzY1a0NQRE1Sd0JvNE5oSUhRMlFBMUdmRCthR2xncStMSndRdTdacnJN?=
 =?utf-8?B?WUtkL1didDhvVjhmdDVzS2hEejJnSkYxTlJScHl4M2c5eFMyb3FuZkRDU1ZV?=
 =?utf-8?B?RTdGOVdocSs2dVlLTU5TeUNwQmhQYXdXVmdvaFRvWDBDdHpKRWR4S0NQclBL?=
 =?utf-8?B?VnpPUUw4VHhBS0lJSFFHbTJ5eWs5RlBpZ2ovbWIzdktmMER1d0JqOFEva0JC?=
 =?utf-8?B?bHJpQTRVS1hSWS9YRHBUVlB0VFVhcURoN3VSTHg5YVZwdW9mSXlLSXJOU3R0?=
 =?utf-8?B?QUwza0tQSmJmcHVZd3hLRFk2THRDT0w0SGRWeHB6aGNRbXQycnd1ZjhnTXV6?=
 =?utf-8?B?R2h3VUd5TUlWQ0FUeHBWVGV5YW10VDhyYnUvbWQzcE9jY3lKUDQxYTdsSVdM?=
 =?utf-8?B?cHRubGNoR25hQThNRDBDVUlpdUxxQXZUcnEwMW15cVFES0pyS0ZWQUFyTlpn?=
 =?utf-8?B?MUU1clBiT0hadThnMmd5bmhOZ0FIalk1QUVRc0J1Y3QrOXpTaVZVTHFsR2Rt?=
 =?utf-8?B?VElTcUlxbkRtaUF5Z0FZdUUxOVNUTHN4NkxyOWtJcU1PTXdLUEJxNHNRL2hz?=
 =?utf-8?B?bitHK3lucDRIYzVwMWZuYmRJdCtOaHpLKzJnbkJEZ1lQM2ZWM01lbmhLTGtx?=
 =?utf-8?B?Vy9WNTZKUjVZR1c4cVA3Um5SL2h6allLVlFqaUo4UkdPT3pIdCthVFNqTlJk?=
 =?utf-8?B?TFFwL0R5SmRJTkFUTVNRcFBhOGNublpjdE9UUkM4a3Z3RTBtNmFTSkQvelNT?=
 =?utf-8?B?N0pUVkhKT2ZWWnZhR0UyMzVmY1JYdXJVRFN1MUoyNnRIa0d1RXpIc3BIZmZn?=
 =?utf-8?B?NlVCOXNUOXZKMDRLRXFjYnpjTXpFTVU0RWhPaTRoQnlqVHV0UHRIU0QzV2xl?=
 =?utf-8?B?WEVTTzhqNnU5L1dMUWY1a0xlS3djMm5NZmRBcHRzTVdjUUN1czRlUUN5WWtE?=
 =?utf-8?B?aEVFUHZOZ3JmVkVtb2hNZitYa2NXMC9JSjMxdzg0THZGVGFWOFJqbWNoNVNo?=
 =?utf-8?B?OXVCZDRRaHN3bTBTejFmYVc3VnUwYkI1YXlNWnd2ZjNqdDh5UTZENW5ydnpD?=
 =?utf-8?B?aFI5VlFOVkM1SWN5c0J0akVtNFdkR1Q1elkvOGR1MVVIa3NsOGRiV1BOSnJG?=
 =?utf-8?B?bmJMVk5nbXJiSFlieU0va09COXVOelQySThkOXRvMjhnMTNid1V3WS9Hd2JR?=
 =?utf-8?B?MEc1bjluVjlDWk1KQW0rUGsyWm1VR2dRdEh0b0FLdHE3TmJiaDVTTklNeXBq?=
 =?utf-8?B?QTVCYU11TTk5Skd5a01Md20yNnpOV2pxdjcyNW56Y1ZQZWxUSHR3aWZFaHdF?=
 =?utf-8?B?ZnF3cHhhMlJ6RHc0ejF0bVgwRFBHUUJVaWo0Ti9oNWZlWmc1Q2RFS1pFdUQ2?=
 =?utf-8?B?OXlVVHpUZ2FmY3ZIWDFKeFkwU28wTXc5SVY4L2Z6ajZITjJrRGk3TzFES2hy?=
 =?utf-8?B?VzlDVkdwYjMzYm1LblNVclZUa0RvWXAyaUFITS9HSXJCYTNuK3dnRjdaM2ZR?=
 =?utf-8?B?R1grTzUzUzYzUEk1eEhPK0RMWnlwaGxUWklkNkVOTmxMM1R3MUl1ZTdDaWFS?=
 =?utf-8?B?NFZvbmR4dENhc0ZDQm1WdEpZdGl0OUlZa3dNWTRLWGhVaXc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR03MB5542.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QndsSXVYVmU1VkJyZHN4UjJXOU9TWEdGRzJYR1JwcTNMRFdLYlJRSmdQblhF?=
 =?utf-8?B?ZmVKeTRPTGhRTmR3QWFJWU45RHBaVEpTR2o4dUMwMGRJcC9Eb05YcmRqcXJ2?=
 =?utf-8?B?YWZrMUtaUU95RWhIUXp2VWFVTllOeUJMc3B0MjJPd3RpaGhkN3lhK2JObGw1?=
 =?utf-8?B?UlRIbWVSUm84VVhXNHF0S05ZZ3l4akVWVUZ2anU5ZGtuU2Q0eVk2L2hReE11?=
 =?utf-8?B?TXJLQWRiMkU1a1k5MnNMTG1GOWl2aGVROUlabUJZS3ZOWjRqS2VKelpYVUFG?=
 =?utf-8?B?Nm5nK0dBcTNKZnRPL2NiaUFZSFhzQ3lkemxUVDJwVHBtdWlxc1pPRWZENjZ0?=
 =?utf-8?B?WE9vWm5Jdk43UGtYUmxpMk9qVEZFVUp4RDRDSmNDdjFBK1E1K3VQQWplaEhP?=
 =?utf-8?B?VmhocUJuaWZicUNwVXJsdXJtbUhQMFozS3QxWWhvVkJjdStVcWhrclFRZ3lG?=
 =?utf-8?B?U29tckNXMHA5VjRkazlvSzhSSHdENG52UGdkY2o2a0FKVEF1aFA2SG42Um5z?=
 =?utf-8?B?TmZMaHdabU5FenZBaVJoOVN3SjNKQm8yT0FvSmVpZzFKUGFmYnBvQlpXYWtT?=
 =?utf-8?B?M1FHN05JM0x5K0l2RVBLUTRIeERQZkJOVXNNdU10RVdvK2RSdHIvSkM1QThU?=
 =?utf-8?B?a1Q4dC9VN013SUZVZS8zemZ0ZStLTlJoS042dDVvTk5XVmVpVzhhSG42MjNV?=
 =?utf-8?B?RitFdmlCYVkxU0YwbXN5Z0RTZDUvM3Uzak5ndzVRcWtmUTZKU3RBODFBRGdQ?=
 =?utf-8?B?L1IwWXdnQU1wVDZROEtYY3Y2bkhvSHdQa3hRWDY5WEJqRE5DRWU0aXBWMjdi?=
 =?utf-8?B?dXpvUUNwWHVFQkFhNU1LMmFmcHB1SC90bVBqSDBrUEJreFpHVVdGd0FyRXdY?=
 =?utf-8?B?QmRWSGUxdDJTNkNWQjB5N3RiK2JreHk3bENTQ3B6ZVJIQklYK0JJWEptWE9w?=
 =?utf-8?B?OUk0c3RoNlZUM0NsT0VZQU5nRndYRFRjdFNISnJJYkc3ZzRBZVR0QkpTSHNB?=
 =?utf-8?B?ejM3cUFIQzgyVEdjTFBVNFBsMkhMWmJlWDZUYS95amlXbDdkckJ2MGhBeXcw?=
 =?utf-8?B?R3pvZDhqMlBySDBVNFlyNC9tTERkOE1yYzBEWnV6YU5wc29NNk9McTZBcS9N?=
 =?utf-8?B?b2V2TmJ0VHJEcDlaMkM0d2E5V05jYjB3Rlc5bjBINEtxdktnYjJXU2QweHdR?=
 =?utf-8?B?SmhFcGpMWGhiVmcrNkdoUGRyK3VoMXJGUDhCL242SFpLNzRnMmc4d0RWaFFE?=
 =?utf-8?B?YUNObm4wR0pOY3ovbWRhWU1BTG9TTFZ6YkRteXJuc0hTd1VVaDhRdUFyRXE2?=
 =?utf-8?B?cm96NUZSdndzaDlPeW5qWHVPZUxqQnpIT2c0SGRIOHBETEV6K1VzT1dFM3ZW?=
 =?utf-8?B?SWJ0bGFZUXRVMFNPbUlPdkVxOUNFekdyUGE1RkNHQVBzRWNzUjdFWGo2ajRw?=
 =?utf-8?B?Yk5MNTFOeTJ3MFgrK1c4aFV1OEVSSDM5ZEpkbXJ0OXgvcUFPZThldzkxL080?=
 =?utf-8?B?WHIvT0JLalpESXRGZ2x4RWhiVFJzYVRVaGpleWI0cW83Z0lPWlFGbEJJbXQw?=
 =?utf-8?B?VXFaV1REY2h0d3N1TW56c2NHSjUxR0pHRi82STZKNEREWHdtNU9IZlE5ZUxv?=
 =?utf-8?B?ajZQbU9lMWxpb2w3UXJCbW5kK2d3UklVR0p6SGhnT2dITFIrVE5kVXkxSGFQ?=
 =?utf-8?B?SnhTT2I3MWRZckx4Q1ZXR1kvaE5DMW1RdUVWR0dXMEt4TitzRk5nNUVpWHMx?=
 =?utf-8?B?ZE1VdXhKSDBnS1FrVEF0WnJ5djZaUUdoRnVTelBTNXFHWGdsRCtLenBwd3pt?=
 =?utf-8?B?T1RwT2xkeHZlWGhMV0wzaFU3dlIyb0xZUHZsT2Q5Rms0RFpSV1ljcUNLNE00?=
 =?utf-8?B?dXhRdDNFUjZwdkRDNkNoMG0rMmk5QWt2SjZJQVpRcVFQVUttSE9tRmFqZTNh?=
 =?utf-8?B?UkJZNGQ5c1U2QlIySm5qSWFLREtKYkNBRjZDUkpaTm5jT0hsQmhUUGZqdEhM?=
 =?utf-8?B?a3ZGSzZuMk1FaGw3cU12VlNuME1SYmQ3NVNFMTg1L2VFeHlLNkZMM0JrTHRt?=
 =?utf-8?B?QXNJeFFtZUVKWGtOSHRqVWJuNnBXT3dGUnIvVnUxQ3NFemo3d2ttMG9wOWVI?=
 =?utf-8?B?WURFckp6SytuNjN6aUh0bmltZ0NBRFFVSWttUW15bUJ0T2RlSEVEUjI4WjVw?=
 =?utf-8?Q?nBVOJa+pMTO/Oryp5y1zcn8=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eacb62e1-4dab-4f1a-9593-08ddc5225ece
X-MS-Exchange-CrossTenant-AuthSource: DS7PR03MB5542.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 11:09:17.3044 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +N+XJhdftI+iIj0HvMIY7Ayb6wtYljcjufsEQFySL/znK681Sf95n2AUH9NAdJ91oUz/ysmlFycjszR2Tn7dpZ2QSc5aokvivkPsgQxqhqSvrVms9NaNLWolH3fkcPU5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR03MB7588
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

Hi Quentin and Heiko

On 16-Jul-25 12:58 PM, Heiko Schocher wrote:
> Hello Quentin,
> 
> On 14.07.25 11:59, Quentin Schulz wrote:
>> Hi Naresh,
>>
>> On 7/1/25 6:52 AM, Naresh Kumar Ravulapalli wrote:
>>> When i2c device is removed, l4_sp_clk is disabled; this would cause
>>> unexpected behaviour for peripherals still running with l4_sp_clk.
>>> This patch resolves the clock issue.
>>>
>>
>> Shouldn't we rather have those peripherals enable the l4_sp_clk as 
>> well so that the refcount is
>> higher and the clock can be disabled whenever there isn't any user of 
>> that clock anymore?
> 
> Yes, thought this too... Naresh, could you take a look at this, please?
Sure, I will look into this.

Kind Regards
Naresh
> 
> Thanks!
> 
> bye,
> Heiko
>>
>> Cheers,
>> Quentin
> 


