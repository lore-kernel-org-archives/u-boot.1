Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B11FC369D3
	for <u-boot@archiver.kernel.org>; Mon, 21 Apr 2025 16:52:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7147581FDE;
	Mon, 21 Apr 2025 18:51:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="d/6deny3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 26AD881F0D; Mon, 21 Apr 2025 07:14:48 +0200 (CEST)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 817AC81DE3
 for <u-boot@lists.denx.de>; Mon, 21 Apr 2025 07:14:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tingting.meng@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q4CGsEjpRzrJs0HXo6RJ81lvdXPffl2x90a1+4sZnwckU3vsnmXnYgdYPYyIdo5JX6wX2EV0Kr9NeKCqLqgzAGVHm4KyaT34i6BSt6gUoYvpv2TnwdIeVX8wUCooKubSzjIjIZmHDaSzio39NGQ0YwUdEAm6pqkPOmGvyCXsejMNySXh43fF+n5p3BQGjpHSL00XlmrDq81BJkF8GWMIsRQZPdM3NrLWzvuj7ETKTmZv0iGCD3a2domao3+1glXDMc8Y9jB0famYs6zx9H5QAoNWANUyIj0sfTSAnKVRz/pVPX6IPJeTU7JzhV3n37IDq2iVDbEF7VV2BFwGRNau6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LJk2d2KcxBcReJ91CmSqXOdQ+pYobgMBBkk7hfgjGk4=;
 b=muIPOUcB4d+EeFn+iZqFnmoYZzdIpi0MEMBq7WOmWfz4ea3o+Vs7BwNp8PfzxqZKI81wxNrSQQ1gh9L5ff7QnSJ4wvamg0oFVg9guWlhMUYb9dhx04IY+kVYB/hOLClOlv/77D0rUNESO+rYEgEsa1lqSH22GNl1ogYhX3+IXcaMOQiPAG6chBTl7c/mpO2IIEVEOYOZBluoYguk6N7UFZar3e14MhVurv4z4knO01bucmNOrmmdortS6MqiHBDsVlJO3bu+Ux6iYTzQ1C9ylBh+guf4qUadD1uHICOyKLs1UW66CEwxo8UBR80vEdDxYq3wAQ093GQQZiNh8oScbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LJk2d2KcxBcReJ91CmSqXOdQ+pYobgMBBkk7hfgjGk4=;
 b=d/6deny38lJW5BgZm9qkld8gOiVNGw6X6AQ3DpXtNkscF04pQNw/FO6E8cu9XqFesYRwkP1VqrKcTjBkxreEarXanSxFXKNlozjalsUH1OQv7MWsAz4GU0jRaFz7AGmZgy8qPimkn0lp7q3Wqc516vgHbaAN7FQY+ogsRvJy2fhU1Bl4tWpXJsuDcy7ZaKJXgcrWOB/OKkCFE2UXlvUPclSsqWOECBJ0fo1wfjaXmUGmr9N2UQ2UpzG4wcP+VxtRmJAXmYdm3vCpXH9/r4hhM4mFoM++RD6ORHaEjNp980FaXz3GD1P+NFmvGlL6cBeLQqF236ItTrzvUjNC8K/YQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DS7PR03MB5621.namprd03.prod.outlook.com (2603:10b6:5:2c8::21)
 by SA1PR03MB7099.namprd03.prod.outlook.com (2603:10b6:806:330::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.30; Mon, 21 Apr
 2025 05:14:42 +0000
Received: from DS7PR03MB5621.namprd03.prod.outlook.com
 ([fe80::5337:db99:bde7:e33b]) by DS7PR03MB5621.namprd03.prod.outlook.com
 ([fe80::5337:db99:bde7:e33b%5]) with mapi id 15.20.8655.033; Mon, 21 Apr 2025
 05:14:42 +0000
From: tingting.meng@altera.com
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>, Tien Fong Chee <tien.fong.chee@altera.com>,
 Tingting Meng <tingting.meng@altera.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Dinesh <dinesh.maniyam@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>,
 Alif <alif.zakuan.yuslaimi@altera.com>,
 Danish <danish.ahmad.rosdi@altera.com>,
 Hazim <muhammad.hazim.izzat.zamri@altera.com>,
 Jit Loon Lim <jit.loon.lim@altera.com>
Subject: [PATCH v1 4/5] ddr: altera: agilex5: LPDDRs in-line ECC support
Date: Sun, 20 Apr 2025 22:14:31 -0700
Message-Id: <20250421051431.29206-1-tingting.meng@altera.com>
X-Mailer: git-send-email 2.35.3
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR13CA0033.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::8) To DS7PR03MB5621.namprd03.prod.outlook.com
 (2603:10b6:5:2c8::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR03MB5621:EE_|SA1PR03MB7099:EE_
X-MS-Office365-Filtering-Correlation-Id: acaf3656-71cd-4c23-72a2-08dd80936c88
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YXRZcWYwM1k5bzZ1bmVCSGVlSHZ5VS9lTTFiNzV5YXBHREQrRGpXTDQ0enpC?=
 =?utf-8?B?ZVFwZjNlR005RkdpQUk0cFZ3Y0t4QzBvalBDWElmU1Vud2tnTGdsUzRnMStU?=
 =?utf-8?B?MU9KL2NBYVNrMWttbVhsZzJzdWtDNHE3RWUzNENtL0RSWThUTy9tTEQ4a0JK?=
 =?utf-8?B?dnRFVXhReWpSSnZzN25FVXkwbUhvWXdBSE5hb2tFTURicHF1ZSsreHM5LzVv?=
 =?utf-8?B?VUZWQkQ3VjZhL0tsTEVlWnpDVHV3ZzlUa2JZMzNrUWJZRFd5NlYxMHBHTnZ5?=
 =?utf-8?B?ZjFhWVhOZzJ2bVFzbC84VmFCSGx2aE0wQTJXZElpT2ZTRGZ2NlNuVU85dm95?=
 =?utf-8?B?TW9iZWhoR3NYWWdwSEVIcGV5WFVIVEYzQm1HSDdvcWphM2ZhQklnd2ZvTDRh?=
 =?utf-8?B?ejVjS1VBSlhjaDNmVGY1cnFGV0R1eVViQ3NvbUZhalZDS2pJVVovNHo3UHBu?=
 =?utf-8?B?V3hWTGZMalNNb0xUSjRhNzVuZHFjZlhieEZGck9lT3I1L2IyWWovampRVFNs?=
 =?utf-8?B?dDc4NnJHS0dzV09wa0VENGpOYkxNTWl4UnlGYWZ5d2FjUHpRVjYvcWt0ZlJH?=
 =?utf-8?B?dGxVNW1kZnFMeEtyN1VITnFjYTFvdEFiTGRpZnhEb1NhRzJJQnVlbjhjSnA4?=
 =?utf-8?B?bDRoR3dLOWNtc1M3NkFqTFY1WUpYblU3WE9PampYelo0eEtFcm9zZmIrcXRx?=
 =?utf-8?B?NDB0a1Uwd0pXWm1PQkRHZHZyUDd6SHJBQU5mZC9VaGp4TWhCK3hyb05MSUlW?=
 =?utf-8?B?NlZnZlNnaVF3SW4xcXRYZExDNzI2aE50eHI3dTBCVWR0RXUyQ1k0cnA5bER2?=
 =?utf-8?B?ZmVlZDN6dFNDWHg2TFB0NWNEWGl0OG5JRnVsYlpaNm0xdk5URjJUb2cveHB5?=
 =?utf-8?B?U2ozMHkvNDdveEpHNS9NKzcwY3lxL2RORWpjZ3Y2STFWQXdEaVhGTk14Z3l3?=
 =?utf-8?B?UUVJb01KVDE0dTBnUDk2QkxqVkR0SkJoVjVDRGRBbjRtUEdBK0pGVU11VzhL?=
 =?utf-8?B?dk1ldG9iQW5CK0N0SExNR0pSTjdKRDVLK0w4cHVjNm5CWjJ3b3NWYVliNmMr?=
 =?utf-8?B?azF2RzJiZytwdUVXTE9oQnU5YXRsZTlzRHZxUktiSm80MmZlak5zRFJMelVZ?=
 =?utf-8?B?L1RuMnl1VUFVNmNONC8wWXUrYks0Qzk1a3J3NXpxL21MQU92Mk9TaTBKT2g3?=
 =?utf-8?B?ZGZtRWY5aXYxS200VFBXR0JJREh2ZUcrbklwcHI0UUc5ZEFrR01telVyeTRz?=
 =?utf-8?B?cXZGRXh1OWRKWmxEN1pDSlZLNXRRTnU2ajBmb1JxMDI0eWExRmRZTnNFbHJB?=
 =?utf-8?B?UGx0My9ReXdVajF0eGk4dWI4TmJ2MDNuekVlYVh5VjN5RkZ6SnFFdW1yNlFl?=
 =?utf-8?B?V0MwLysyaldNV3p2aEd1T2lTcUFXZzhVd1RTa2tWdUF6T3ZFOERTRVlteEZ5?=
 =?utf-8?B?QmsvSnhPUWJNZEpvdmt3NkdCUktzNHVDM3dpSW5wam5MNDNMbndFTG5SVmpL?=
 =?utf-8?B?NWFtNmt1YU5yTEJQL0R3VHpLYjUvcUxPTjFrZHhFZVpOMVJxMnJoUlhnWElM?=
 =?utf-8?B?Wjd5N0dYUFBZUkRndW94Q25lRkpSNnMxRmwvVXI2RmQwQkNaTTBKdWZxKzhq?=
 =?utf-8?B?M2t1YUwwYzFIb014L0o5dFprNzZmamYwbFBSUUcwM0ZEdDBVRGtibVoyVERE?=
 =?utf-8?B?OUZSYXdMMFhNM1JhTzJxckRtbWFRR2NveGZSend6cmlzc1o2VTVuR3JDQUZr?=
 =?utf-8?B?MEE4S29ZM2tQTmZFVmZaU1laeDFrZEFaTEZnNkhaMEtMQlFna1AwUXRKK2Nt?=
 =?utf-8?B?TGlJaTdTMjhnOERLalBRZ29mK2VSQXlJY2FPZnJmdkx3UmM1NlNiOUVZcElV?=
 =?utf-8?B?K0luMVd0dDVMSVhwWUU0MFZZSHVsT1I5Q1diL1FLS21qZkJRaXFPOVBNTVU2?=
 =?utf-8?Q?3Csi1AFPKT4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR03MB5621.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TENnMzBGZU1JM1FQdlF6RGxHSFJiT0ptclg0R3hFTzRyS3FVUDUxZXR2Y3Uw?=
 =?utf-8?B?UjFiUjFrTW9Rcy9YOUo0ZStxaXN6SGVmczlFc1FLM1VDNVgzN3Z0OUFjMHBh?=
 =?utf-8?B?aWtSeTZ3WmJkaUttZ1hmUWMxd05NZS9tRnZGdlVPNEhEb2dFdmFEWld2M0lQ?=
 =?utf-8?B?dG1raTVXdmpwa3pzMWE0WHU1TnlFRFZXc1pjS1NmTVVHUndhbXpVS3l0WUNZ?=
 =?utf-8?B?YkliNDl0UWhZTHFNOTdpREY1UU5pa3NyWkdVQldFdEZId25xZXhabjFXYmhL?=
 =?utf-8?B?UDRDRnFtZ2pWZWwxeHNxM1hmTkxqbWJuczVKdUtielEzd3JyaDcwMjBUNGZR?=
 =?utf-8?B?bXV5YjEwdUk3RDRWTWhkOXU0enpvZWNsMDZkQURPSzZkRDNxRG5zNXFTcUNt?=
 =?utf-8?B?eXNVbmlMWVI1eFVKK0llWmw0K0tPd05TMnNFc3c3Wm1kRDNZWGY2WGppVGpK?=
 =?utf-8?B?dm5RRmY2RHJ4dmpuZVZCRDNCU25HYVFDb252Ny95Qko4b1ZSZVNEbENNUGlR?=
 =?utf-8?B?bk90TDRjUXBhR3FqQWs2VkhIV29Sbkh1QUpPV0tNZjc0VmYrT2F1VmUxb1Ex?=
 =?utf-8?B?Y1MyVzZ5ZXVDVjRZcEtzRWg4emRCQ2ZCYjhVSmgzTWhwcUNQR0RkU3dzS3hy?=
 =?utf-8?B?RGR0UXRIYy93QUhKUEhRd1RKekUvSDUxYVFLTDZzWEFZaTA2MVBZWEJiZk1X?=
 =?utf-8?B?NVcyczcyRFNxL1VZeTA4alpyRUxIeWxTWHFpdzdRdVpFcEc3RjJIV0ZUc3Nh?=
 =?utf-8?B?ZEI1dm50UGJMZGRIUmhIblprL3RyUkZJUXc0bVVYYUpQS2FCZ0pTOWUyTWV1?=
 =?utf-8?B?UjdVbXZkczVZRisvcXdZdUJyN3pySktMcmloVXhNNVZDcU9TMzFxMmNTc01L?=
 =?utf-8?B?ZDR6MkkvZUpGbDNwZ0pGRnpqZHR1SVdXSElpZ2FLemUrT2lTbE81UXZJMU54?=
 =?utf-8?B?UTlibmtmQU5nMXBUTTg1UzFYYnJkakRjd3U3ZW1BZmdONlpWc3E3OE1nVWh6?=
 =?utf-8?B?b2d0djcvSm5VeWF3SGdiQk5sK3U5UGp1VThlUFBLN2hQbDJOUElaYU0yanJp?=
 =?utf-8?B?amFOejBMODUzaFFrTjJjSElUQTBhZHpjQWljYU9YUkNybllKTXV2MGlmM3NH?=
 =?utf-8?B?WmVLS3FTM212ai9xTi9Ddk1LLzR3ZUVMRnB0QmZ6bXFwaWJZNEJCZkF1ODVS?=
 =?utf-8?B?NHhPMGJhU0xkR25VbFVvOGRNWEdza0RGb3hGM21rWmFMMHpRR09ORmhFOTUw?=
 =?utf-8?B?Wjl5NXg2OWVMbDdNWDRCcSt6OEFpRTkzVXhML2hDSjEzZ2tMQk1zemd5bTdm?=
 =?utf-8?B?WE1UV1AxNHBWb0cvdE1TUmRmRjZuSE5Ja2l6NG9zZkFmTVdtRXZFMmtyQjJ6?=
 =?utf-8?B?UkN3RnF5UUlVaDFrRnpZbWdwS2xuV1dMUkVCbkNXTkpZVXA5NHg1YlBOM0hD?=
 =?utf-8?B?QWtZLzF6Q2RuMVpxUXRDMlkrdWhhRHBtR1E4dnR1ZkE4SGUyRkdPSkZoSUxp?=
 =?utf-8?B?ZWZiQkk5b1dJaFlwY0o3U2g0RzlzVXpxdzNVdXB5RnNJZ1VmNlJaT0lTc0hD?=
 =?utf-8?B?WldqK01WM3RRcnRzTUFYb29UZHRhOElSMTJjU2lnK0s3Vngybnltb2psbzdh?=
 =?utf-8?B?TDlSKzZCbXBIZXRVeGFmQXFLRWJGYVFXU0l0Y055VW9kMExBUy9jd0JMR05G?=
 =?utf-8?B?MHVKb3hMZ1dJZWdmWjcrejR5cmt4WlhKVnBzMURMM2pCOEVlbjMvajgvOEFT?=
 =?utf-8?B?WjZjZUd4QWdraFJmdzkvRzBMbDRaZ0tXSlE3VTRoVzBWRStiWU9Yc3VhTGRM?=
 =?utf-8?B?allEa3pid0h4bVFoODBBeUhnM0ZSZEFjYW1EcWgyY2tMQXlpNEQ0bTBybGsz?=
 =?utf-8?B?K0toV1VJa2UrWFpMVXJrZk55Y0FWRkJyYlZTeVhXNWk3dzVyMWcvQkRjdTlW?=
 =?utf-8?B?K04vY1Bva1ByWnBYMS9pdE9ETXdFK0NvNE5sK3lpR3k2Nk80eHlMYXRya1VN?=
 =?utf-8?B?STZoSXJYZXJieEZsemZ5RGt0ZUl0dXN4cUx0SWhVcFgvd0hkNnlqdHhDa3dm?=
 =?utf-8?B?TkYvalNMTlBJbXpwRFVpd0dRclhTZDg5QSt4ZjM4aWNhZ05iYlh2Z3FnNXFT?=
 =?utf-8?B?bGRDajdlQmRXY1JHMUpkWWpiUy9aS2NnaktMdVhDSFRoVGhrRkwwaHphUjBr?=
 =?utf-8?B?ZVE9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acaf3656-71cd-4c23-72a2-08dd80936c88
X-MS-Exchange-CrossTenant-AuthSource: DS7PR03MB5621.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2025 05:14:42.7026 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8XAaubJyjY5ZNverdcs8wp7cw/JKHcq4iewE1+1dVqCwd6CuqTCM8mVpe0usdFc6SxKaz3UqcedNphJFC5yyTwqQb3nn6PmqCkDNVhzJTUc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB7099
X-Mailman-Approved-At: Mon, 21 Apr 2025 18:51:44 +0200
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

From: Tingting Meng <tingting.meng@altera.com>

In-line ECC support was added for LPDDR by reserving the last one-eighth
of the memory space for ECC data. Full memory initialization using the
BIST MEM INIT mailbox command, based on address and size, is required to
correctly generate ECC data and enable proper ECC logic verification.

Signed-off-by: Tingting Meng <tingting.meng@altera.com>
---
 .../arm/dts/socfpga_agilex5_socdk-u-boot.dtsi |  26 ++-
 drivers/ddr/altera/iossm_mailbox.c            | 161 ++++++++++++++++--
 drivers/ddr/altera/iossm_mailbox.h            |  11 +-
 drivers/ddr/altera/sdram_agilex5.c            |  19 ++-
 drivers/ddr/altera/sdram_soc64.c              |  52 ++++--
 5 files changed, 220 insertions(+), 49 deletions(-)

diff --git a/arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi b/arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi
index d7ab58267eb..8d7dc0945ab 100644
--- a/arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi
+++ b/arch/arm/dts/socfpga_agilex5_socdk-u-boot.dtsi
@@ -25,34 +25,44 @@
 	/*
 	 * Both Memory base address and size default info is retrieved from HW setting.
 	 * Reconfiguration / Overwrite these info can be done with examples below.
-	 */
-	/*
+	 *
+	 * When LPDDR ECC is enabled, the last 1/8 of the memory region must
+	 * be reserved for the Inline ECC buffer.
+	 *
 	 * Example for memory size with 2GB:
 	 * memory {
 	 *	reg = <0x0 0x80000000 0x0 0x80000000>;
 	 * };
-	 */
-	/*
+	 *
 	 * Example for memory size with 8GB:
 	 * memory {
 	 *	reg = <0x0 0x80000000 0x0 0x80000000>,
 	 *	      <0x8 0x80000000 0x1 0x80000000>;
 	 * };
-	 */
-	/*
+	 *
 	 * Example for memory size with 32GB:
 	 * memory {
 	 *	reg = <0x0 0x80000000 0x0 0x80000000>,
 	 *	      <0x8 0x80000000 0x7 0x80000000>;
 	 * };
-	 */
-	/*
+	 *
 	 * Example for memory size with 512GB:
 	 * memory {
 	 *	reg = <0x0 0x80000000 0x0 0x80000000>,
 	 *	      <0x8 0x80000000 0x7 0x80000000>,
 	 *	      <0x88 0x00000000 0x78 0x00000000>;
 	 * };
+	 *
+	 * Example for memory size with 2GB with LPDDR Inline ECC ON:
+	 * memory {
+	 *	reg = <0x0 0x80000000 0x0 0x70000000>;
+	 * };
+	 *
+	 * Example for memory size with 8GB with LPDDR Inline ECC ON:
+	 * memory {
+	 *	reg = <0x0 0x80000000 0x0 0x80000000>,
+	 *	      <0x8 0x80000000 0x1 0x40000000>;
+	 * };
 	 */
 
 	chosen {
diff --git a/drivers/ddr/altera/iossm_mailbox.c b/drivers/ddr/altera/iossm_mailbox.c
index db9435db657..26602858777 100644
--- a/drivers/ddr/altera/iossm_mailbox.c
+++ b/drivers/ddr/altera/iossm_mailbox.c
@@ -10,6 +10,7 @@
 #include <asm/arch/base_addr_soc64.h>
 #include <asm/io.h>
 #include <linux/bitfield.h>
+#include <linux/sizes.h>
 #include "iossm_mailbox.h"
 
 #define TIMEOUT_120000MS			120000
@@ -87,6 +88,7 @@
 
 /* offset info of ECC_ENABLE_INTF */
 #define INTF_ECC_ENABLE_TYPE_MASK	GENMASK(1, 0)
+#define INTF_ECC_TYPE_MASK	BIT(8)
 
 /* cmd opcode BIST_MEM_INIT_START, BIST performed on full memory address range */
 #define BIST_FULL_MEM			BIT(6)
@@ -107,6 +109,10 @@
 
 #define MAX_ECC_ERR_INFO_COUNT 16
 
+#define BIST_START_ADDR_SPACE_MASK GENMASK(5, 0)
+#define BIST_START_ADDR_LOW_MASK   GENMASK(31, 0)
+#define BIST_START_ADDR_HIGH_MASK  GENMASK(37, 32)
+
 #define IO96B_MB_REQ_SETUP(v, w, x, y, z) \
 	usr_req.ip_type = v; \
 	usr_req.ip_id = w; \
@@ -512,7 +518,7 @@ int get_mem_width_info(struct io96b_info *io96b_ctrl)
 {
 	int i, j, ret = 0;
 	u32 mem_width_info;
-	u16 memory_size, total_memory_size = 0;
+	phys_size_t memory_size, total_memory_size = 0;
 
 	u32 mem_total_capacity_intf_offset[MAX_MEM_INTERFACE_SUPPORTED] = {
 		IOSSM_MEM_TOTAL_CAPACITY_INTF0_OFFSET,
@@ -526,8 +532,11 @@ int get_mem_width_info(struct io96b_info *io96b_ctrl)
 			mem_width_info = readl(io96b_ctrl->io96b[i].io96b_csr_addr +
 					       mem_total_capacity_intf_offset[j]);
 
-			memory_size = memory_size +
-					FIELD_GET(INTF_CAPACITY_GBITS_MASK, mem_width_info);
+			io96b_ctrl->io96b[i].mb_ctrl.memory_size[j] =
+				FIELD_GET(INTF_CAPACITY_GBITS_MASK, mem_width_info) * SZ_1G / SZ_8;
+
+			if (io96b_ctrl->io96b[i].mb_ctrl.memory_size[j] != 0)
+				memory_size += io96b_ctrl->io96b[i].mb_ctrl.memory_size[j];
 		}
 
 		if (!memory_size) {
@@ -536,8 +545,6 @@ int get_mem_width_info(struct io96b_info *io96b_ctrl)
 			goto err;
 		}
 
-		io96b_ctrl->io96b[i].size = memory_size;
-
 		total_memory_size = total_memory_size + memory_size;
 	}
 
@@ -556,7 +563,7 @@ int ecc_enable_status(struct io96b_info *io96b_ctrl)
 {
 	int i, j, ret = 0;
 	u32 ecc_enable_intf;
-	bool ecc_stat, ecc_stat_set = false;
+	bool ecc_status, ecc_status_set = false, inline_ecc = false;
 
 	u32 ecc_enable_intf_offset[MAX_MEM_INTERFACE_SUPPORTED] = {
 		IOSSM_ECC_ENABLE_INTF0_OFFSET,
@@ -565,6 +572,7 @@ int ecc_enable_status(struct io96b_info *io96b_ctrl)
 
 	/* Initialize ECC status */
 	io96b_ctrl->ecc_status = false;
+	io96b_ctrl->inline_ecc = false;
 
 	/* Get and ensure all memory interface(s) same ECC status */
 	for (i = 0; i < io96b_ctrl->num_instance; i++) {
@@ -572,15 +580,21 @@ int ecc_enable_status(struct io96b_info *io96b_ctrl)
 			ecc_enable_intf = readl(io96b_ctrl->io96b[i].io96b_csr_addr +
 						ecc_enable_intf_offset[j]);
 
-			ecc_stat = (FIELD_GET(INTF_ECC_ENABLE_TYPE_MASK, ecc_enable_intf)
+			ecc_status = (FIELD_GET(INTF_ECC_ENABLE_TYPE_MASK, ecc_enable_intf)
 				    == 0) ? false : true;
+			inline_ecc = FIELD_GET(INTF_ECC_TYPE_MASK, ecc_enable_intf);
+
+			if (!ecc_status_set) {
+				io96b_ctrl->ecc_status = ecc_status;
 
-			if (!ecc_stat_set) {
-				io96b_ctrl->ecc_status = ecc_stat;
-				ecc_stat_set = true;
+				if (io96b_ctrl->ecc_status)
+					io96b_ctrl->inline_ecc = inline_ecc;
+
+				ecc_status_set = true;
 			}
 
-			if (ecc_stat != io96b_ctrl->ecc_status) {
+			if (ecc_status != io96b_ctrl->ecc_status ||
+			    (io96b_ctrl->ecc_status && inline_ecc != io96b_ctrl->inline_ecc)) {
 				printf("%s: Mismatch DDR ECC status on IO96B_%d\n", __func__, i);
 
 				ret = -EINVAL;
@@ -673,7 +687,7 @@ bool ecc_interrupt_status(struct io96b_info *io96b_ctrl)
 	return ecc_error_flag;
 }
 
-int bist_mem_init_start(struct io96b_info *io96b_ctrl)
+int out_of_band_bist_mem_init_start(struct io96b_info *io96b_ctrl)
 {
 	struct io96b_mb_req usr_req;
 	struct io96b_mb_resp usr_resp;
@@ -746,3 +760,126 @@ int bist_mem_init_start(struct io96b_info *io96b_ctrl)
 err:
 	return ret;
 }
+
+int bist_mem_init_by_addr(struct io96b_info *io96b_ctrl, int inst_id, int intf_id,
+			  phys_addr_t base_addr, phys_size_t size)
+{
+	struct io96b_mb_req usr_req;
+	struct io96b_mb_resp usr_resp;
+	int n, ret = 0;
+	bool bist_start, bist_success;
+	u32 mem_exp, mem_init_status_intf, start;
+	phys_size_t chunk_size;
+
+	u32 mem_init_status_offset[MAX_MEM_INTERFACE_SUPPORTED] = {
+		IOSSM_MEM_INIT_STATUS_INTF0_OFFSET,
+		IOSSM_MEM_INIT_STATUS_INTF1_OFFSET
+	};
+
+	/* Check if size is a power of 2 */
+	if (size == 0 || (size & (size - 1)) != 0) {
+		ret = -EINVAL;
+		goto err;
+	}
+
+	mem_exp = 0;
+	chunk_size = size;
+
+	while (chunk_size >>= 1)
+		mem_exp++;
+
+	/* Start memory initialization BIST on the specified address range */
+	IO96B_MB_REQ_SETUP(io96b_ctrl->io96b[inst_id].mb_ctrl.ip_type[intf_id],
+			   io96b_ctrl->io96b[inst_id].mb_ctrl.ip_id[intf_id],
+			   CMD_TRIG_CONTROLLER_OP, BIST_MEM_INIT_START, 0);
+
+	/* CMD_PARAM_0 bit[5:0] = mem_exp */
+	/* CMD_PARAM_0 bit[6]: 0 - on the specified address range */
+	usr_req.cmd_param[0] = FIELD_PREP(BIST_START_ADDR_SPACE_MASK, mem_exp);
+	/* Extract address fields START_ADDR[31:0] */
+	usr_req.cmd_param[1] = FIELD_GET(BIST_START_ADDR_LOW_MASK, base_addr);
+	/* Extract address fields START_ADDR[37:32] */
+	usr_req.cmd_param[2] = FIELD_GET(BIST_START_ADDR_HIGH_MASK, base_addr);
+	/* Initialize memory to all zeros */
+	usr_req.cmd_param[3] = 0;
+
+	bist_start = false;
+	bist_success = false;
+
+	/* Send request to DDR controller */
+	debug("%s:Initializing memory: Addr=0x%llx, Size=2^%u\n", __func__,
+	      base_addr, mem_exp);
+	ret = io96b_mb_req(io96b_ctrl->io96b[inst_id].io96b_csr_addr,
+			   usr_req, 0, &usr_resp);
+	if (ret)
+		goto err;
+
+	bist_start = IOSSM_CMD_RESPONSE_DATA_SHORT(usr_resp.cmd_resp_status)
+		& BIT(0);
+
+	if (!bist_start) {
+		printf("%s: Failed to initialize memory on IO96B_%d\n", __func__,
+		       inst_id);
+		printf("%s: BIST_MEM_INIT_START Error code 0x%lx\n", __func__,
+		       IOSSM_STATUS_CMD_RESPONSE_ERROR(usr_resp.cmd_resp_status));
+
+		ret = -EINVAL;
+		goto err;
+	}
+
+	/* Polling for the initiated memory initialization BIST status */
+	start = get_timer(0);
+	while (!bist_success) {
+		udelay(1);
+
+		mem_init_status_intf = readl(io96b_ctrl->io96b[inst_id].io96b_csr_addr +
+					     mem_init_status_offset[intf_id]);
+
+		bist_success = FIELD_GET(INTF_BIST_STATUS_MASK, mem_init_status_intf);
+
+		if (!bist_success && (get_timer(start) > TIMEOUT)) {
+			printf("%s: Timeout initialize memory on IO96B_%d\n",
+			       __func__, inst_id);
+			printf("%s: BIST_MEM_INIT_STATUS Error code 0x%lx\n",
+			       __func__,
+			IOSSM_STATUS_CMD_RESPONSE_ERROR(usr_resp.cmd_resp_status));
+
+			ret = -ETIMEDOUT;
+			goto err;
+		}
+	}
+
+	debug("%s:DDR memory initializationat 0x%llx completed.\n", __func__, base_addr);
+
+err:
+	return ret;
+}
+
+int inline_ecc_bist_mem_init(struct io96b_info *io96b_ctrl)
+{
+	int i, j, ret = 0;
+
+	/* Memory initialization BIST performed on all memory interfaces */
+	for (i = 0; i < io96b_ctrl->num_instance; i++) {
+		for (j = 0; j < io96b_ctrl->io96b[i].mb_ctrl.num_mem_interface; j++) {
+			ret = bist_mem_init_by_addr(io96b_ctrl, i, j, 0,
+						    io96b_ctrl->io96b[i].mb_ctrl.memory_size[j]);
+			if (ret) {
+				printf("Error: Memory init failed at Instance %d, Interface %d\n",
+				       i, j);
+				goto err;
+			}
+		}
+	}
+
+err:
+	return ret;
+}
+
+int bist_mem_init_start(struct io96b_info *io96b_ctrl)
+{
+	if (io96b_ctrl->inline_ecc)
+		return inline_ecc_bist_mem_init(io96b_ctrl);
+	else
+		return out_of_band_bist_mem_init_start(io96b_ctrl);
+}
diff --git a/drivers/ddr/altera/iossm_mailbox.h b/drivers/ddr/altera/iossm_mailbox.h
index 6f794781d30..02d1db28e20 100644
--- a/drivers/ddr/altera/iossm_mailbox.h
+++ b/drivers/ddr/altera/iossm_mailbox.h
@@ -40,11 +40,13 @@ enum iossm_mailbox_cmd_opcode  {
  * @num_mem_interface:	Number of memory interfaces instantiated
  * @ip_type:		IP type implemented on the IO96B
  * @ip_instance_id:	IP identifier for every IP instance implemented on the IO96B
+ * @memory_size[2]:	Memory size for every IP instance implemented on the IO96B
  */
 struct io96b_mb_ctrl {
 	u32 num_mem_interface;
 	u32 ip_type[2];
 	u32 ip_id[2];
+	phys_size_t memory_size[2];
 };
 
 /* CMD_REQ Register Definition */
@@ -53,6 +55,9 @@ struct io96b_mb_ctrl {
 #define CMD_TYPE_MASK			GENMASK(23, 16)
 #define CMD_OPCODE_MASK			GENMASK(15, 0)
 
+/* Computes the Inline ECC data region size */
+#define CALC_INLINE_ECC_HW_SIZE(size) (((size) * 7) / 8)
+
 /*
  * IOSSM mailbox request
  * @ip_type:	    IP type for the specified memory interface
@@ -83,13 +88,11 @@ struct io96b_mb_resp {
 /*
  * IO96B instance specific information
  *
- * @size:		Memory size
  * @io96b_csr_addr:	IO96B instance CSR address
  * @cal_status:		IO96B instance calibration status
  * @mb_ctrl:		IOSSM mailbox required information
  */
 struct io96b_instance {
-	u16 size;
 	phys_addr_t io96b_csr_addr;
 	bool cal_status;
 	struct io96b_mb_ctrl mb_ctrl;
@@ -102,6 +105,7 @@ struct io96b_instance {
  * @overall_cal_status: Overall calibration status for all IO96B instance(s)
  * @ddr_type:		DDR memory type
  * @ecc_status:		ECC enable status (false = disabled, true = enabled)
+ * @inline_ecc:		Inline ECC or Out of Band ECC (false = Out of Band ECC, true = Inline ECC)
  * @overall_size:	Total DDR memory size
  * @io96b[]:		IO96B instance specific information
  * @ckgen_lock:		IO96B GEN PLL lock (false = not locked, true = locked)
@@ -115,7 +119,8 @@ struct io96b_info {
 	bool overall_cal_status;
 	const char *ddr_type;
 	bool ecc_status;
-	u16 overall_size;
+	bool inline_ecc;
+	phys_size_t overall_size;
 	struct io96b_instance io96b[MAX_IO96B_SUPPORTED];
 	bool ckgen_lock;
 	u8 num_port;
diff --git a/drivers/ddr/altera/sdram_agilex5.c b/drivers/ddr/altera/sdram_agilex5.c
index 801a6bbab46..ee66c72157a 100644
--- a/drivers/ddr/altera/sdram_agilex5.c
+++ b/drivers/ddr/altera/sdram_agilex5.c
@@ -291,7 +291,14 @@ int sdram_mmr_init_full(struct udevice *dev)
 		goto err;
 	}
 
-	hw_size = (phys_size_t)io96b_ctrl->overall_size * SZ_1G / SZ_8;
+	ret = ecc_enable_status(io96b_ctrl);
+	if (ret) {
+		printf("DDR: Failed to get ECC enabled status\n");
+
+		goto err;
+	}
+
+	hw_size = io96b_ctrl->overall_size;
 
 	/* Get bank configuration from devicetree */
 	ret = fdtdec_decode_ram_size(gd->fdt_blob, NULL, 0, NULL,
@@ -303,6 +310,9 @@ int sdram_mmr_init_full(struct udevice *dev)
 		goto err;
 	}
 
+	if (io96b_ctrl->inline_ecc)
+		hw_size = CALC_INLINE_ECC_HW_SIZE(hw_size);
+
 	if (gd->ram_size > hw_size) {
 		printf("DDR: Warning: DRAM size from device tree (%lld MiB) exceeds\n",
 		       gd->ram_size >> 20);
@@ -355,13 +365,6 @@ int sdram_mmr_init_full(struct udevice *dev)
 
 	printf("%s: %lld MiB\n", io96b_ctrl->ddr_type, gd->ram_size >> 20);
 
-	ret = ecc_enable_status(io96b_ctrl);
-	if (ret) {
-		printf("DDR: Failed to get ECC enabled status\n");
-
-		goto err;
-	}
-
 	/* Is HPS cold or warm reset? If yes, Skip full memory initialization if ECC
 	 *  enabled to preserve memory content
 	 */
diff --git a/drivers/ddr/altera/sdram_soc64.c b/drivers/ddr/altera/sdram_soc64.c
index 75c6de1e4ec..27fbe80ed41 100644
--- a/drivers/ddr/altera/sdram_soc64.c
+++ b/drivers/ddr/altera/sdram_soc64.c
@@ -185,35 +185,51 @@ void sdram_init_ecc_bits(struct bd_info *bd)
 void sdram_size_check(struct bd_info *bd)
 {
 	phys_size_t total_ram_check = 0;
-	phys_size_t ram_check = 0;
-	phys_addr_t start = 0;
-	phys_size_t size, remaining_size;
 	int bank;
 
 	/* Sanity check ensure correct SDRAM size specified */
 	debug("DDR: Running SDRAM size sanity check\n");
 
 	for (bank = 0; bank < CONFIG_NR_DRAM_BANKS; bank++) {
+		phys_size_t ram_check = 0;
+		phys_addr_t start = 0;
+		phys_size_t remaining_size;
+
 		start = bd->bi_dram[bank].start;
 		remaining_size = bd->bi_dram[bank].size;
+		debug("Checking bank %d: start=0x%llx, size=0x%llx\n",
+		      bank, start, remaining_size);
+
 		while (ram_check < bd->bi_dram[bank].size) {
-			size = min((phys_addr_t)SZ_1G,
-				   (phys_addr_t)remaining_size);
-
-			/*
-			 * Ensure the size is power of two, this is requirement
-			 * to run get_ram_size() / memory test
-			 */
-			if (size != 0 && ((size & (size - 1)) == 0)) {
-				ram_check += get_ram_size((void *)
-						(start + ram_check), size);
-				remaining_size = bd->bi_dram[bank].size -
-							ram_check;
-			} else {
-				puts("DDR: Memory test requires SDRAM size ");
-				puts("in power of two!\n");
+			phys_size_t size, test_size, detected_size;
+
+			size = min((phys_addr_t)SZ_1G, (phys_addr_t)remaining_size);
+
+			if (size < SZ_8) {
+				puts("Invalid size: Memory size required to be multiple\n");
+				puts("of 64-Bit word!\n");
 				hang();
 			}
+
+			/* Adjust size to the nearest power of two to support get_ram_size() */
+			test_size = SZ_8;
+
+			while (test_size * 2 <= size)
+				test_size *= 2;
+
+			debug("Testing memory at 0x%llx with size 0x%llx\n",
+			      start + ram_check, test_size);
+			detected_size = get_ram_size((void *)(start + ram_check), test_size);
+
+			if (detected_size != test_size) {
+				debug("Detected size 0x%llx doesn’t match the test size 0x%llx!\n",
+				      detected_size, test_size);
+				puts("Memory testing failed!\n");
+				hang();
+			}
+
+			ram_check += detected_size;
+			remaining_size = bd->bi_dram[bank].size - ram_check;
 		}
 
 		total_ram_check += ram_check;
-- 
2.25.1

