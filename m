Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56926E7FDCF
	for <u-boot@archiver.kernel.org>; Tue,  3 Feb 2026 19:59:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7DD4F83D3D;
	Tue,  3 Feb 2026 20:59:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="U7iNBGrZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8920483D2E; Tue,  3 Feb 2026 20:58:58 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2833B83C39
 for <u-boot@lists.denx.de>; Tue,  3 Feb 2026 20:58:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QpnydyPTjuJixdteIUr8uVs76wMEa8tt24EncIrMI9MApJmXbTyoGi2Vf4L6cGxEv+u2s99H5itNoOG7uec93ahCnk2l/9qKFm+JGdxaWFzpbD23EzDA9eTBd1FY1mLVJ2WlY+6bC6FcOwfgoK+hKYAw+g+bqby9Rne3PP97Ib/kGv1ub+P+I5bZtlyF48BNJPkonKz3c2K74zu73lbpse5CvLpkLBARTGDbY3XqKsnU9gdZP+/sxGRDevj7tUUqPrO659u1jsuKLqhBSQD1x1SDad99vYpTT9c2RQi2ZCAyHxiNpNhI+kQanfSwevwyr+4BY7KV7REwRKTmsuEJ6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hlrrZR03PXdhSrbwoODIEW4c8LhQzqKglXS1ANP1tYU=;
 b=LT9c4TetdIFy+S+niE+2Cst02fXBLZOw22mQVw0SeT+Syn0Q4gdm5+6T6LDl+2K+VH42zxpF9fw6siPbIIAUppqvGFQYR70a2iUavwvH31OhiP0au/CPjgHsBpr9QqrRbzeGe6h64rcNTa65fWllJh4iUz6ilGgZ4Qq63TqiFFDhJ2FTmK/2eKFeGpMMnb7GB5ZtBr36mF6Qz7LZrU1ezdnsKlnMLKvMzNo0H/f6BikV3/RD38yzKHujC+0us3lIAbrf97rZpEPOehtKbtLrPARR0Y7mKUaTEXbjE0KiT2boFwLcpzasMR6wsfWKkgVFnPGj7x9qmyH5VhM1EPx7zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hlrrZR03PXdhSrbwoODIEW4c8LhQzqKglXS1ANP1tYU=;
 b=U7iNBGrZ/DnAZwtybMQLsV9Ck1DfjfX9lGIUbq4d9sEl3Hzwqs58j4JMERnDmRmi79XFq73RNXwIJEuoDxb3m3mrEqHr4RLD4jDTKroNyA8J8K6/mVVM1imr7/OfOclAY0oyoLaUW668hbwUiEGFZ15uTvdtw0VjQzXRtiXOv4o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by VI1PR04MB7022.eurprd04.prod.outlook.com (2603:10a6:800:126::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Tue, 3 Feb
 2026 19:58:52 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9564.016; Tue, 3 Feb 2026
 19:58:52 +0000
Message-ID: <379af4c2-082e-4437-9d64-bdf9f52c326d@cherry.de>
Date: Tue, 3 Feb 2026 20:58:44 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] doc: develop/process: Clarify name usage in the
 Signed-off-by line
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20260203191620.1476575-1-trini@konsulko.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260203191620.1476575-1-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0182.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::13) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|VI1PR04MB7022:EE_
X-MS-Office365-Filtering-Correlation-Id: b8cd53c1-5664-4969-a5bd-08de635ea79c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|10070799003|366016|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eDF6SHZUUFVIMW1mQk4xMjZMeWJpZjQwQnYrTFBmRWIveGY1MHJQRTFPb21U?=
 =?utf-8?B?TTMzUGNYZ3MwTnBycHlRa3NaNHY5cFNPNWhoVUZCSXR2MERVdHVGZTdHWExX?=
 =?utf-8?B?N2o3eXdJdGRxZlFuNXl1aXJwU2c4VVA5UGxXVnBhSUJzZVJWNmZHMWZvMDNo?=
 =?utf-8?B?d0J1Z0xmTDBhVTMxcmliVTBNcmpuRmhOY1lyWVlnMW4xWU45RitLQWFFQkZG?=
 =?utf-8?B?TlZkUGdLemIzNTdJaVN1dUJtRWRTWWdndlVxbkxRZzFzaDVTNkpkZktncHQy?=
 =?utf-8?B?Q0xQaGF2K0Z4RmN2R0VNR0RvS3Z3eXliZ1IyUUloSFhPQnJsYkdPblE3NDJo?=
 =?utf-8?B?ZGJWdnJjVURJcGhLMnVkaU5xaHNjdWtvdEtDOEk2N3hFZHR6aFVnZkJITEdH?=
 =?utf-8?B?ZzhlOG9NVjVjV3kyQnFFRkZKS3l3eUtrTGR5UVplZWFpSVV1bklZckhPYjUw?=
 =?utf-8?B?UzZOTDVNQmlRbmM0MkZITkZvb0ZSSzgzNCt1N3dObTJ4VHZYcHhPdXJpaE9T?=
 =?utf-8?B?OUdpb285Wm9FdS9EQU12cEVCTk53bTdwckxXVDF6c1JlTkdhSGVoKzJhV041?=
 =?utf-8?B?aXcwZlA3YmFuY3d2VElZc2Ivend0ampyUkI2Y3ZSS1dVM0QxTmozeU9xc1NI?=
 =?utf-8?B?VE1jU3dIdVRoa0lzWDhMbFZyaTI0eC85T1FKd29iQ1pTZVAxY3dLWjMzd2c2?=
 =?utf-8?B?WVo5bEZtVENyODRMdkxWU2ptOTFoQUdnY2Z2NWJudlVYVXhNMm1SbXJQVm0r?=
 =?utf-8?B?ZTB0RE5ORWlpODZodVZQZEJnVkExT1pEK3FpcWFvWmNkTGhaM2p3SzJmZ3FY?=
 =?utf-8?B?SloxYmxZOVZHc0tmblZ0UnhoT0p4UWUxbFF3Y3Rjc2VhQVEzZ3NxcGF5UnY1?=
 =?utf-8?B?TzJlZ2Uvb3B4cHFrcVh6UUh1YjlCUUNuVEcvS0FYVU1FSHFIQWo3OFJrdVBE?=
 =?utf-8?B?WHJqaC8vV0ZFKzExS0RyTGZxWVRJZ2ZkSEhTMk9WY0Z5Y00zODQwRXZhN3lE?=
 =?utf-8?B?anZCL3NBdXM4YWFmOXk3M2NrcXY0QThUQ3J1V2E1dTBUYVpXak9IaDduRWRG?=
 =?utf-8?B?Y0tZYzdKc0h0OXJPVGlyakNJR1ExWHdTeFNxRHlmS0V2Ky9MK2RkUEk3L0la?=
 =?utf-8?B?aHVobHpBMlQ5R2YvZ3ptUlA5L2FkOWJ3ZjJCM0hoK3huVVRRYW1CTExlYytP?=
 =?utf-8?B?MkJIYVkzSFVhbmxObjlWeEVBWXFMNS9aOXIwZWZkOXFZV2xkME1YZVB3ME5Z?=
 =?utf-8?B?QWwvbG5TMjNLMnNXd3hkME9WcTVDMlhIdzRYdHZ0YWtLeWszd0dKM0RrMGYr?=
 =?utf-8?B?R2dCMXlGYTAvN2UrTDJxNWNYNmZ0bkhTazloZ0lnSWRTZ1ltVjBlRkkxZXlz?=
 =?utf-8?B?c0VXQlhMdTBDNzYxcFNQRWg3aFIrNndUcUlwMFhtWEVrWHFXNmdiOGRoWXpK?=
 =?utf-8?B?aDB3ZzM2dmNPN3B6c2kwcUUwV1h3eFM1YjRTc0lQM2pMRlMvNzA2dnkwYVV6?=
 =?utf-8?B?VWNkdFJzaFFHaDdNRTFhUnk5aHBwNmpVQXFlc3FidEg0MGlEc1ZyUnMxM0RZ?=
 =?utf-8?B?VUlEMlV0SzI0SjhUY0hSZ1FCZThaS1I5ZCtNbmh0RWV0WW9USHMrd0dVM0s3?=
 =?utf-8?B?MVZwdTBFZThjbndpQWNGRW9tNXVIRUVrby9IcktSaVAyODFlem1EZWhreHQz?=
 =?utf-8?B?Nm9IejJyZk9YN0ZFWDBELy9lTzFuMGpRaTVUOEROT2ZIaHpINE4rOWQrWENu?=
 =?utf-8?B?b1BSeU9BbDZkdnp0ZHplbDFsRS9NOGNiTkJ5clY4dHRRMm1OVy9aMzhLR0xu?=
 =?utf-8?B?TEk2UTg0cytVOVVPRFFZdzNCakJyUlVMQWw4ZDA2MWRoNDBGTms4YnJCOXJ4?=
 =?utf-8?B?RFJCWFJqVllNN1gzUm1RTzNlY2xFaGs5aElWWDAwOWFYNmtvREp6U3dlQ0Fx?=
 =?utf-8?B?am13ZTFZd0lxeEp4OVhHV0hjTHR5TWtEV0paZnJJajdLNTdMSUs0RU1hekhQ?=
 =?utf-8?B?NUVKSUN4NXhlTStWbmJsVm8vMG9pU2hxc3ZlNUY1bzR1YnczUDZtc0p6WlNG?=
 =?utf-8?Q?X54DZQ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(10070799003)(366016)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aG1JS0hxVTY0dzlEdWVaWEFGdmNXbzV3ZjYxcC9vT2JkOTZtRFd6UTdJNHNl?=
 =?utf-8?B?NklIRmI4dDJ4SVZtbUd5SE5yTkE0cmtaSG0yQjlrdVZ0enIvUWoyYkhmb2kx?=
 =?utf-8?B?WlJobXVkTUVQS1V6MXNhcXVEVDJFZGJOdlZtcGxlZWdZUldlaEdWZ0FjWDlj?=
 =?utf-8?B?NStCZWI2L1dkVkR6WjJWLzFnM1NqNVk5UURRUjJ1UllSY2pYZXdybVU2VUht?=
 =?utf-8?B?d0t3RlUrWENTN0hNdEgyQWlWcDlEeU9XaDV1S3Y3VWVVdXk2Uk80RWRydWVi?=
 =?utf-8?B?SExoN1ZqamdMcDNsRUs3NkovYW9UV25vUU9ZWjU5dThKZSs2cmE2Zlk0MjBy?=
 =?utf-8?B?TnhTQTIvQ2VKajc3R1o5TFZrZG5neVV0YTdnR042WXMvcnhyK3NXUll3ODRD?=
 =?utf-8?B?c1NpbTVDZUNqbUc1Qm03TjNsRzV4ZGpFVWN1QmczaHl2b2ExYmxqdWZDREc1?=
 =?utf-8?B?Wm1GZGVDak5Pb2o1QURjLzRybU5yZjgxamlqS1pnSThNdjBCMmNYZ21VSlJE?=
 =?utf-8?B?UUlnd1ZUNkxSb1E1UmNlRTVzN3dVK3NFRzJZbFc1dVMrNTV1bFZzZWxLOCtN?=
 =?utf-8?B?eFpzVjhIVjBtUDYwYUJKcDZ6WnR6MWxmWkJrNkhIb25TcldWb0IrSFBKbE5B?=
 =?utf-8?B?ZVZjSXc4bGpxTmRGUHZ5bGJ2Q1l0Yk92czhHSGUzR3NaaDJyek81ekc5U0N1?=
 =?utf-8?B?dHdnb1NFMTVPakltckRPcVRxWWZ2aEZIYXd4d2wzVzRHTjdyWVhFUUh1V2Nk?=
 =?utf-8?B?UzNlbzR6SUlxVmtJL0VoemgzckU4QncyMXl5eWFvSDlEK2tVcERHdXkzenVF?=
 =?utf-8?B?dkZGZ3BGdm83elJNN3o5cm5PYVhkdG56dDA0Q0lscWpraG5jbnNhWGNaeWJM?=
 =?utf-8?B?dG92UUJEdUhBeWFsTGFPdUpFWHFRc2c1a1VVRExnTFFRSzJrb2JiSEtKUHh6?=
 =?utf-8?B?WldvZnhiNjNSQTNnY2pUbkR3a1lVVkdoQk1QZlVyd0F0ZEVMeUtTUlNmOHhS?=
 =?utf-8?B?M0tadmhPY1E1RWZ4b0Z1NGJhSURaekNCcjk0RlNjaTFTQWo4eVM5RDdjWk5J?=
 =?utf-8?B?bDBwOGlxZUdJSm1Edk9XR2sxSTNxbUNGbjEzU1RwaVVSQmp2RGZyMzZIbkVy?=
 =?utf-8?B?UC9rSjhWdUhocVhnWVlPVWFDSGhSYVBmL21WT05DR2xEYk1UR1pOTmVYOTVz?=
 =?utf-8?B?amx0L0VXaFR1VmlCV2NSMFpRYkZVVGFCU0w0cTZETUk1S0IxR0tFNDQvcjRn?=
 =?utf-8?B?cTNUUm1JdEp2dzZPeEdvZDJrZ1pxdGx0QWIvVWNVU2k3NVFKNUN0ckpEMVVr?=
 =?utf-8?B?dlJXanJaYytUaHZTSlBRTGxZYm9Jb2dqWlNrdzc2cmFJd08vYml5MG1pUlp0?=
 =?utf-8?B?bFhaSThVSG1wc04zYlBUS2c2elB2OC96bGFtRENOQmptMFRPWDhQd1VpcnZO?=
 =?utf-8?B?eTFpT3FiYk1paUJQbmdUUkZvbGloWkRkVmttTDJYbjZ0UFYyc0M3R0cvR2I4?=
 =?utf-8?B?TmhTc0lEdlB4azVkTmM2cFdheDdaYnNOMmUvajRLTFZkMHNFaW44ZHorbHV5?=
 =?utf-8?B?aVE2dUs0MlR4OXFTVEpHT0xFeE4ySFZkRXF2QXZHY2dFTDlEalRPdlpKQ1g1?=
 =?utf-8?B?bVVrUE1taHdZS1V3Q1dhUzN2N0ZQSFNXSldkajIyaWxCK3pXZFdhQXdkbmMw?=
 =?utf-8?B?ZENHL0s1WUpLcGgvNGpiT2pBWmNSOUxDczE4VWM5SzU2OG5XMlFobW5MQlBD?=
 =?utf-8?B?d1liaHZVOVB3R25GTHJTU2k4UDNlaUhuNnlHalEvNDc3ZEM4QzNxaytUQzRy?=
 =?utf-8?B?dCtHaWVsYXkzOFIrcTlmd0FIZ29xMGRTNXZlSnFFZWpNcTRhYlg0NDZDV0pI?=
 =?utf-8?B?Vm5YRG1nb2lPQUJPcWR2a1NwZG4vVERGNmEzbjBHcHhBZWVZd2FZRmx2eFFQ?=
 =?utf-8?B?RmNJTXZQWnVXWGdnTFIvajc5R0xpNno3WVIvZTNOUHB3MGNIVmY1dFZENHJp?=
 =?utf-8?B?T2RucThuRG4xczBpWmNVdGRaQmZkdzlHR3lCWGNSMHo5Qm9sQXYydFBIK1RV?=
 =?utf-8?B?NFZPYTlyMUZuOW1ORVUrZGE5dHliUWwwNzcyQmE1dVZvTTRET21Oem82TldH?=
 =?utf-8?B?eDFhcERuTUJvUVVOdGpPMWVaK29GZTFja0pPRGlpa3BTMXo0WENzQnFEY1Zm?=
 =?utf-8?B?eUxpWnVrZ3FwUy9rdmh5ekhWUlIweWNiTUZaWFh1NFZyQVNpWG94blo2Tlhs?=
 =?utf-8?B?ZWlURWRkenAyaXdjeTJMNkZKVE5GMWhaUFBtYVNzRUxmbHVqaloxVm5tM0pz?=
 =?utf-8?B?RDdHTHNmQm1HZCtzR25XMXFiMklOVjhST3htaXhUcVg0eEsvOUtxU1MreFBP?=
 =?utf-8?Q?2hELB4j7HX+mcKu30RogcxvfqimfEms9hhAGT?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: b8cd53c1-5664-4969-a5bd-08de635ea79c
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 19:58:52.4432 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EnbUJqMld0ep+zRL5SWXeC8HaK+Uo7ZR/bgWNX7bYog77xG+Y0jNtJBz7LbHY52sJVIYd2uB9yDMdR+Kzr7ohcWPGDNx91qBvJT+j9BMWGo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7022
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

Hi Tom,

On 2/3/26 8:16 PM, Tom Rini wrote:
> Long ago we took the Linux Kernel documentation about adding a
> Signed-off-by line and adjusted it slightly for how we organized things.
> In 2003 Linus clarified the intent and then re-worded what the name
> portion of the Signed-off-by line can be. Mirror that change here.
> 
> Link: https://git.kernel.org/torvalds/c/d4563201f33a
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
>   doc/develop/process.rst | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/doc/develop/process.rst b/doc/develop/process.rst
> index fd81d9c5ebd4..3c783ed5a0e9 100644
> --- a/doc/develop/process.rst
> +++ b/doc/develop/process.rst
> @@ -139,8 +139,7 @@ document.
>     message by which the signer certifies that they were involved in the development
>     of the patch and that they accept the `Developer Certificate of Origin
>     <https://developercertificate.org/>`_. Following this and adding a
> -  ``Signed-off-by:`` line that contains the developer's name and email address
> -  is required.
> +  ``Signed-off-by:`` line using a known identity and email address is required.
>   

Just for your information, the kernel docs also have an additional note:

(sorry, no anonymous contributions.)

Not sure if it's a necessary distinction but it's there. See 
https://www.kernel.org/doc/html/latest/process/submitting-patches.html#developer-s-certificate-of-origin-1-1 
(a bit lower).

Looks good to me in any case.

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
