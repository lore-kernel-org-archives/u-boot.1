Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F336D59D99
	for <u-boot@archiver.kernel.org>; Mon, 15 Dec 2025 05:07:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 01B60801CF;
	Mon, 15 Dec 2025 06:07:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="EnDJ8j9u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0590F8036B; Mon, 15 Dec 2025 06:07:33 +0100 (CET)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84F598003E
 for <u-boot@lists.denx.de>; Mon, 15 Dec 2025 06:07:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a2v4ggHklGCIHDPQ9JxvTTgwIwDwANuOHePwADHEErrmk1KNR2aoCm+uFhZ6B0WkrA03/sTKTxaCmETWaXmXYp/4EYrsnyQ3RWuYF7C1D6xTdW9ssSuRyfy1pvuqajHNN4ZeDg1GDqfW7kC1zbcVgFlsLlDiAb1onWYbVcx7VQHYY/ckTvNqF0GI1+XtRp/8b2iXEo6vGGgVzCkHDOLb0/DJLy3kNmbO1GnbmD/LMnEad5cMsf7EmmlIZZ+QdyeWisEiavpLngfGjJcrKjhZgnJYalCB+HTyZpjGnvY9vbeoWda6HQ25LkBhlIby7KvC7TY+P9RIwbN8VeUxzeTByg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dud6I/WkgK1SCupBY3tgrXyXdnZAmqmtV+yrxq4iWyA=;
 b=q/vUQB8S0T7A7avij019cJtCJumb2mGX3gy4hOF8xzpPBwmzow/aJglBmwnQ/lASNBvy3cq9xE8z3c087aO3zMzjIc6+LCcFSnLYmyxDNdD30UWjdH0F5XYCSbZl2Ns1I8j85x6KcvAp34YYZUEL9ca4daVjO24GJtFdiPjpBk79T4WxqbNH68LR8knrf8FWURBIY7S3Mu66vSwXYoI/FourcTp7hHU1X/9TibuwiILm3pe5j01d+MuSVnCWxnzFnTkRH5q9gjHfO7KBV5a5iQAXxxUrPd8XInuq/hoGdlthuONE+/Xrnr2Tp8oLn6SKQxg81D7z+kIpbAOhNB/h8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dud6I/WkgK1SCupBY3tgrXyXdnZAmqmtV+yrxq4iWyA=;
 b=EnDJ8j9usPYa3Ik4mJ3hGYm8EfZPGuxQzgMFMBhG52sPeOuPyyrHBxjpLfmx9TGfYrSfsn01VNT35Eok2iy/flYyzCwV4SydEnXeNh/+dxLk9hA24WG/I9kGg9BDrwMnOlPYeA1mXhR30oxZ40mpNcNlh3AcWBATx6+HR9XDq+6o8H5WLixg1plzG9Vy0/ikFTZ4VxfiDt3qoBRS20RvCMJaHloycsgaqHKAtFoVp/E3Yjf+ABniV6y6FefO7v6C9Fx8GxaXXiKSspJyuAvzte0JslYFct9PgD3NWopWHIzD5FmAixRq2hlvr94wChT7SI+28x2sPiZcy4mkfZGI4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from CY1PR03MB8121.namprd03.prod.outlook.com (2603:10b6:930:106::16)
 by SJ0PR03MB5615.namprd03.prod.outlook.com (2603:10b6:a03:27a::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 05:07:27 +0000
Received: from CY1PR03MB8121.namprd03.prod.outlook.com
 ([fe80::fe3c:a06b:8724:fab0]) by CY1PR03MB8121.namprd03.prod.outlook.com
 ([fe80::fe3c:a06b:8724:fab0%3]) with mapi id 15.20.9412.005; Mon, 15 Dec 2025
 05:07:27 +0000
Message-ID: <999f2b92-67eb-442f-ab97-2d719c6566d2@altera.com>
Date: Mon, 15 Dec 2025 13:07:20 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] configs: socfpga: Permit EFI booting
To: Jan Kiszka <jan.kiszka@siemens.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>, Marek Vasut
 <marex@nabladev.com>, Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>
Cc: Dinh Nguyen <dinguyen@kernel.org>
References: <0fd50c36-c780-468d-9d00-304946eb28f8@siemens.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tienfong.chee@altera.com>
In-Reply-To: <0fd50c36-c780-468d-9d00-304946eb28f8@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR04CA0013.apcprd04.prod.outlook.com
 (2603:1096:4:197::6) To CY1PR03MB8121.namprd03.prod.outlook.com
 (2603:10b6:930:106::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY1PR03MB8121:EE_|SJ0PR03MB5615:EE_
X-MS-Office365-Filtering-Correlation-Id: d43d6839-c402-4af3-d991-08de3b97d70d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bnhHR1hKUndvVEgzd2F6bEFrZU9oTkRGT3k4Mm94ZVprckh2OWJBbC95RUN3?=
 =?utf-8?B?cUtmSW9xN0Yyd2hXQzBXeHhQdlNuWVdhazhNeTk5cnRQRHp2bXBkS2dHRUF1?=
 =?utf-8?B?TjBlSkxzOUY2blpySTVIYlRCQ2FWWkJlTzV6VjFXTVRSYUphUm9EQUxmWGlt?=
 =?utf-8?B?eDNscEtKTzdqbkwwaExMd3FNOHhMUVlyY2dFVVhXRU5xUHM4dnNxOEQ3NXcr?=
 =?utf-8?B?N1FkZDJUQUtkYUkyWEc3eFhEMVRjaWRsVmNDdWpRMk1ZSHY5WnBEY3hiWnBL?=
 =?utf-8?B?OXFRN1E2RElXcGdUeithSEtjOUdGUWcvTnZEbDJuVUtveFQxZDBTMXJVWTYz?=
 =?utf-8?B?T1lVSmtrVStzeVNpQmNwY2R6YktSZzcwcVliUzdieExrUkYwanN5ZUVrcmFh?=
 =?utf-8?B?ZHNjQ3VuSjVWMTIvQWc4cGxrZDFmNEZ1aXNuTmRxaG13citUbDUyNUluVFRE?=
 =?utf-8?B?MDdlM0ptdWRaQ2JzSkR2SkhoTWJvSTE2YS9oYm5udU1sNEVyYlZ4WGdaeFI2?=
 =?utf-8?B?RCs0VnEzekFBQUVMdDZqNHdnNUZvZG15OHlyaHNZYkNWeW94ODZqK3ZmWUt1?=
 =?utf-8?B?OFVvNVU3My90c25ObFBsNEw1bW5RMGFRWkQ0Qm84aDY2bmRPam1rWGR5TXox?=
 =?utf-8?B?ZmpMTUo5YU9nd2haSDBidEtkOURxVmt1endnNnVMaFR3UEpwem84NzM3azF2?=
 =?utf-8?B?dGVQNGdKczNGNWczMktHcU55dWFxU2FRQ1NMZG9UUG9tMnFCWXgzSGlnVDNt?=
 =?utf-8?B?YTFQZXJuSFZnUkZRelQyRTdWM1VvQnBTTXp4V1dSRmtyU0JzNXJjMktRZEFZ?=
 =?utf-8?B?TGRhQWNFR2pMRUs1TENVQmsyNVNjNktaMWFyNEpUTThuSzhZTTloazZkRGxP?=
 =?utf-8?B?UStVaHR0Zy93bHVpR1VCTTlDdktNNVpPbU1UUU5YWllzR2VSQUw4OTFNL3dz?=
 =?utf-8?B?RnBKUHpUR2NndGllZVJMcGk0bHF2R0FhbE92blM4RkxDVTJBUlVKcDYzVnFG?=
 =?utf-8?B?cDNUUFJSbTg5c2dMOWp2R1VpUk14S1BkVlJKdnJtTGJHQVEzS0duYkxCd1dm?=
 =?utf-8?B?dFZjY0VmMHJlQ3RobkVMK2psamJxeFBCYm8wVm1HZUdiVVdieVhZaXVlL2VN?=
 =?utf-8?B?WjVyczgvQlRueHcvQmVmSUxhQ1g1dGVhUnFSVHZZYncxTzZab1NMbEdrNE1P?=
 =?utf-8?B?RkFUeXZUclJUQmZ4aUdpdmtFZGVzZ1JWL01BdndIRnZDdUtDNlpWMi82ZXF4?=
 =?utf-8?B?WXdqb2NJSUMyY1k0UVJDN3hMZ28vT3ZiYmZwVERVUXVLbEQ4anIvam5pVXA2?=
 =?utf-8?B?bmFZcGExeGJwbkkzeUtleTNjK0FJZjdlOE9CcWE0TkZiSXJZYzUrRjB5ajBT?=
 =?utf-8?B?RENla3MvSGJoOVpkZmpHZ1BlSGxsTElqRGdnZkVBMDFiL1cvOHg0R1N4Witr?=
 =?utf-8?B?TnFJU2NPVDd5Z0RxUWpnUmpDUjg0SzRDMnFJcHBiZ3RKVFNuQlFySE4vYkNx?=
 =?utf-8?B?ZUYyV21xT0dMVFRWSTJWRHJTTHBzV3NmVnBGd1NnSzkvUEs0TmxibXoveDdV?=
 =?utf-8?B?YktDNTFhMXNUWFp0UExEQWNrSFRENlZkSEZkZkk0R2hlOC91M1R5WTBLR3lm?=
 =?utf-8?B?YzR3RGxTMVptZ1ZCdzlaWVNIZGliSlVnOVVOcVQyVE5ib3BhUTNmMUFid1Y0?=
 =?utf-8?B?ODNJa09VR3Q3blp2U3hNOHU5UkdkaklNS281Y0VrRENtZi80RTEzNVVaVTJ3?=
 =?utf-8?B?NXhhaHNmR1ZyczFNcm16WFVTZnIyOC8xUWh6cUQvMUxmdWo3bUR0c1pGTzQ0?=
 =?utf-8?B?Z2pMYnNwdlFtTFFhcjJuZGhKTHZsYnF6TWZyaU9VNGR0WGpMZU9QekRvTjNw?=
 =?utf-8?B?YmdQd2xKNTFIaFJzcFd3VTVnZFFhZTZ6b1NNd1FtWGFHb0VXdGdXa0ZLdG9T?=
 =?utf-8?Q?LhQMj2MxtvMkubCto8xbEHXKsQnME1ZU?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY1PR03MB8121.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?anZISEZTblVkWlNaSVhkdTR2cjgzcVN4MmVqS284aUhBd29aUFc1a0UyVTVH?=
 =?utf-8?B?bmI3SzVaUVhUQVMxL0dRZVpIYW8yaStrWXE4QUp0Wk52OXRFeWxlUDZXdkdM?=
 =?utf-8?B?WFBGSHdpeEpqeXBRLzg3eG9KaGozdlBYWnNFbW1qMVpKKzNpMFhnVTJ3UEVD?=
 =?utf-8?B?TGYrcW9LcHdsNnM2UzhEMzJJUmhLU2xFTE8reU1DVktLMDlTc3BoeldOZUJi?=
 =?utf-8?B?ZElsc2psU1kzb0E4dXRGSkZMdXF4ZlI2K29vbWtubUo4Umk3N0FvNzVjenFj?=
 =?utf-8?B?VWwyekt4Rkd6TWJDbGhJVVgrQ1QvdldPT2JibGVRd2Y5NkgvTC83QUEyODNC?=
 =?utf-8?B?VWE3MEVBcUxHeTNhVkQ1a3E5OXpxRndMOU0zVTNucDJoRTFvWDFzUTZ1TEhO?=
 =?utf-8?B?dGUyQWVoTG9vZk5jbGxyVmRSVUJiSGJJWHJWQXdFVUZIaHVwQWtRaVoySllz?=
 =?utf-8?B?ZGxvZHcwTWhYdk9Zbmh0MXJEdGRLZ2RPalRqOGtDRlBramswNWFnTlkxdkpa?=
 =?utf-8?B?cXV0UzdIaDNwZFpjazIydzJzL0xIM3dLU1BDa0xnMjZkeFhiS0dsdjdiVHlw?=
 =?utf-8?B?NTkzcks2WkRMdU5GWHpKbi9scEE4cE9lZVJYcVRQMjcyaEdjK0pGVGkxYU1F?=
 =?utf-8?B?ZE8yWWZyd0Y5aUZTeGFadVN6SWpRRlNxS0NUVE8wNDJWZ25QTDBZTGlkK3RP?=
 =?utf-8?B?d1VYazNMRnRtUG15ZWdwOTFZUjBkVm9vMk54UDJac1llZ0NsQ2Y2MFZzUzdZ?=
 =?utf-8?B?d2hvNW1FSzhzWTJXalM4OTd2NXhTZGZhTEJSTjZIdnFWOG1wdWc2TDY0Sy9Z?=
 =?utf-8?B?blFvZnVrNjJncWptd1VUQ3NHS29vSHVHdGFoS2NFV0M3Zm9oSndNb0FEdG9T?=
 =?utf-8?B?Vm5jWW1DZVozL1lhQ1hmc1ExcElxcGtXbjhmSmFHT0h3TW9FeFZESW1EOURk?=
 =?utf-8?B?NDF2MEExVFhheFJGcWgxTnpNS3lXendqeVJmS3ZZRGgrQ05PbDFPN0FrOWhY?=
 =?utf-8?B?cXk5Tm1IS3hROHRKRTl0LzZXZ0lTZUpWcVJYanh0VGJjTnI1N0djYVVjdlUw?=
 =?utf-8?B?ZGY0SGVnUml5bkJzWXc2N3JucXNVeTUwUHJmeXF5dXRJK1AzYkpFcFJmNjVD?=
 =?utf-8?B?U2pmMGZvSjBNQldQOU0vRW5WMnVXNm5oUjM1TTFiYTlRUS9ld1RjMHExN0xS?=
 =?utf-8?B?ZFVCanhHaG9KWE5qa1ZEYWJ0VDNpeFp0SHhTME5yWEVYaFRSeTludjJya0Nn?=
 =?utf-8?B?VExEbklJNjRQVm9xZ1BUUEdkcjZVK2ZmYTZzSTB5YTZvMi8wajlGNkZSZ0Nm?=
 =?utf-8?B?U3IydTc2KzVwcnk4TjVtTlM1TzVjRnBScnJmV1pFOGJEMG1LOFBqcTE2bXkz?=
 =?utf-8?B?eTJPd3B5OHNxREF6akxaSjR6SnBKWlNqRVNwT2crYkRuVVVtRUIyT3QxNFVD?=
 =?utf-8?B?L3JBbG85MjJjUGF3bjYyTlA4SlBGTjN4UWx0MXZ4cDA1eU5Ia2t1WHBVRko2?=
 =?utf-8?B?WDQxTFBodC96TDMrSFo3d0NhYVdSZWhpYTNlWTRKVVJlRHVWOG9HVXhnd0Fr?=
 =?utf-8?B?b01pT1N0NWZtVUVRTmlsUFd6Q2hJYTV2RGRIVnRKRFltYnIyVWRCY1ViTWlG?=
 =?utf-8?B?OWRxcUM3R0t3WTJJcjh1aVJ3ak04SHdUckdMeWU2WFRZNkdiNUt0YTVUdDhM?=
 =?utf-8?B?R1VVdWg3NGNhb2dkNURqaXo0enJzc2thNUdQVnFSZjhQdGZ1eVozTjRUMGIy?=
 =?utf-8?B?S0M0S3kvakNlSFNrcmRNdkkvYmovRHZVelFjMWJKMXR4ejYxL3JSWHNSeERs?=
 =?utf-8?B?WnE4dmkwc3l3aW03MDlKMk5wRFRoTTFrMDNxNXB4ZGZWSnhkMmRrUEdoSlYy?=
 =?utf-8?B?VEJJaVBZS2d4M2ppUDNlWllMN0Y5WDhOdDZkdTM1VmxkTXZoY3VkS0Jqemhz?=
 =?utf-8?B?TmZ3Y090empGTmtXK2RQdjNVLzlZTS9jaENPaUJFYTBrRDBYTEd6NTZUdHhI?=
 =?utf-8?B?U1ZJT0hlMGVtaURvaWtDMFhWczMyZVpKZC8vMHppUy9rUjlFN3BySFgxN2h5?=
 =?utf-8?B?amh6N3pZaTlhd00rL01ocEpDVmxpcHJzVzgwamFQeHdFa3ZDVGlwYzlDSFI1?=
 =?utf-8?B?Q0tUQVU5RTgxS1Y4UzRkd3dyRENyMTBueFNGUURsTzBZWXVZN0dWVmNsNmI0?=
 =?utf-8?B?T3c9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d43d6839-c402-4af3-d991-08de3b97d70d
X-MS-Exchange-CrossTenant-AuthSource: CY1PR03MB8121.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 05:07:27.2337 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JuihU2QMWswCautIs+rpdE2Tr+WYSCSPBLGQzpMdx/HmiarJR/jgBcH3cizRMNJA+7zGnUY8djP80v6O+aHvdM13B38jZAF9uo7wfDkB3Ag=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5615
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


On 12/12/2025 12:36 am, Jan Kiszka wrote:
> [CAUTION: This email is from outside your organization. Unless you trust the sender, do not click on links or open attachments as it may be a fraudulent email attempting to steal your information and/or compromise your computer.]
>
> From: Jan Kiszka <jan.kiszka@siemens.com>
>
> Commit f369e1564cf4 turned those off because the SPL size grew too
> large. It also argued that those boards would never support EFI booting.
> The former is correct, therefore keep CONFIG_SPL_EFI_PARTITION off.
> CONFIG_SPL_ISO_PARTITION is default off. What is not correct is that
> those boards are limited to legacy boot - you just need a hybrid
> partition table to make both the bootrom and UEFI happy.
>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>
> Changes in v2:
>   - use Kconfig to keep SPL_EFI_PARTITION off
>
>   configs/socfpga_agilex5_defconfig       | 2 --
>   configs/socfpga_agilex_defconfig        | 2 --
>   configs/socfpga_arria5_defconfig        | 2 --
>   configs/socfpga_cyclone5_defconfig      | 2 --
>   configs/socfpga_de0_nano_soc_defconfig  | 2 --
>   configs/socfpga_de10_nano_defconfig     | 2 --
>   configs/socfpga_de10_standard_defconfig | 2 --
>   configs/socfpga_de1_soc_defconfig       | 2 --
>   configs/socfpga_is1_defconfig           | 2 --
>   configs/socfpga_mcvevk_defconfig        | 2 --
>   configs/socfpga_secu1_defconfig         | 2 --
>   configs/socfpga_sockit_defconfig        | 2 --
>   configs/socfpga_socrates_defconfig      | 2 --
>   configs/socfpga_sr1500_defconfig        | 2 --
>   configs/socfpga_vining_fpga_defconfig   | 2 --
>   disk/Kconfig                            | 1 +
>   16 files changed, 1 insertion(+), 30 deletions(-)
>
> diff --git a/configs/socfpga_agilex5_defconfig b/configs/socfpga_agilex5_defconfig
> index 64f2f1bf115..20fd1e237c9 100644
> --- a/configs/socfpga_agilex5_defconfig
> +++ b/configs/socfpga_agilex5_defconfig
> @@ -67,8 +67,6 @@ CONFIG_CMD_WDT=y
>   CONFIG_CMD_CACHE=y
>   CONFIG_CMD_TIMER=y
>   CONFIG_CMD_UBI=y
> -# CONFIG_ISO_PARTITION is not set
> -# CONFIG_EFI_PARTITION is not set
>   CONFIG_OF_LIST=""
>   CONFIG_ENV_IS_IN_FAT=y
>   CONFIG_ENV_IS_IN_UBI=y
> diff --git a/configs/socfpga_agilex_defconfig b/configs/socfpga_agilex_defconfig
> index 1c3664bc0d7..eb99392f0ea 100644
> --- a/configs/socfpga_agilex_defconfig
> +++ b/configs/socfpga_agilex_defconfig
> @@ -57,8 +57,6 @@ CONFIG_CMD_USB=y
>   CONFIG_CMD_CACHE=y
>   CONFIG_CMD_SMC=y
>   CONFIG_CMD_UBI=y
> -# CONFIG_ISO_PARTITION is not set
> -# CONFIG_EFI_PARTITION is not set
>   CONFIG_OF_UPSTREAM=y
>   CONFIG_OF_LIST=""
>   CONFIG_ENV_IS_IN_FAT=y
> diff --git a/configs/socfpga_arria5_defconfig b/configs/socfpga_arria5_defconfig
> index 3c860f97ae9..88ef2eb0c76 100644
> --- a/configs/socfpga_arria5_defconfig
> +++ b/configs/socfpga_arria5_defconfig
> @@ -44,8 +44,6 @@ CONFIG_CMD_EXT4_WRITE=y
>   CONFIG_MTDIDS_DEFAULT="nor0=ff705000.spi.0"
>   CONFIG_MTDPARTS_DEFAULT="mtdparts=ff705000.spi.0:1m(u-boot),256k(env1),256k(env2),14848k(boot),16m(rootfs),-@1536k(UBI)"
>   CONFIG_CMD_UBI=y
> -# CONFIG_ISO_PARTITION is not set
> -# CONFIG_EFI_PARTITION is not set
>   CONFIG_ENV_IS_IN_MMC=y
>   CONFIG_ENV_RELOC_GD_ENV_ADDR=y
>   CONFIG_VERSION_VARIABLE=y
> diff --git a/configs/socfpga_cyclone5_defconfig b/configs/socfpga_cyclone5_defconfig
> index 992abdbfdc4..0485d20260c 100644
> --- a/configs/socfpga_cyclone5_defconfig
> +++ b/configs/socfpga_cyclone5_defconfig
> @@ -45,8 +45,6 @@ CONFIG_CMD_EXT4_WRITE=y
>   CONFIG_MTDIDS_DEFAULT="nor0=ff705000.spi.0"
>   CONFIG_MTDPARTS_DEFAULT="mtdparts=ff705000.spi.0:1m(u-boot),256k(env1),256k(env2),14848k(boot),16m(rootfs),-@1536k(UBI)"
>   CONFIG_CMD_UBI=y
> -# CONFIG_ISO_PARTITION is not set
> -# CONFIG_EFI_PARTITION is not set
>   CONFIG_ENV_IS_IN_MMC=y
>   CONFIG_ENV_RELOC_GD_ENV_ADDR=y
>   CONFIG_VERSION_VARIABLE=y
> diff --git a/configs/socfpga_de0_nano_soc_defconfig b/configs/socfpga_de0_nano_soc_defconfig
> index 6564cbd03c6..3b021634bb9 100644
> --- a/configs/socfpga_de0_nano_soc_defconfig
> +++ b/configs/socfpga_de0_nano_soc_defconfig
> @@ -46,8 +46,6 @@ CONFIG_CMD_EXT4_WRITE=y
>   CONFIG_MTDIDS_DEFAULT="nor0=ff705000.spi.0"
>   CONFIG_MTDPARTS_DEFAULT="mtdparts=ff705000.spi.0:1m(u-boot),256k(env1),256k(env2),14848k(boot),16m(rootfs),-@1536k(UBI)"
>   CONFIG_CMD_UBI=y
> -# CONFIG_ISO_PARTITION is not set
> -# CONFIG_EFI_PARTITION is not set
>   CONFIG_ENV_IS_IN_MMC=y
>   CONFIG_ENV_RELOC_GD_ENV_ADDR=y
>   CONFIG_VERSION_VARIABLE=y
> diff --git a/configs/socfpga_de10_nano_defconfig b/configs/socfpga_de10_nano_defconfig
> index 4fabd63f2b4..941f9e9f3bc 100644
> --- a/configs/socfpga_de10_nano_defconfig
> +++ b/configs/socfpga_de10_nano_defconfig
> @@ -42,8 +42,6 @@ CONFIG_CMD_USB_MASS_STORAGE=y
>   CONFIG_CMD_CACHE=y
>   CONFIG_CMD_EXT4_WRITE=y
>   CONFIG_MTDIDS_DEFAULT="nor0=ff705000.spi.0"
> -# CONFIG_ISO_PARTITION is not set
> -# CONFIG_EFI_PARTITION is not set
>   CONFIG_ENV_IS_IN_MMC=y
>   CONFIG_ENV_RELOC_GD_ENV_ADDR=y
>   CONFIG_VERSION_VARIABLE=y
> diff --git a/configs/socfpga_de10_standard_defconfig b/configs/socfpga_de10_standard_defconfig
> index 1c9ecbf2bc8..d2b0274249b 100644
> --- a/configs/socfpga_de10_standard_defconfig
> +++ b/configs/socfpga_de10_standard_defconfig
> @@ -42,8 +42,6 @@ CONFIG_CMD_USB_MASS_STORAGE=y
>   CONFIG_CMD_CACHE=y
>   CONFIG_CMD_EXT4_WRITE=y
>   CONFIG_MTDIDS_DEFAULT="nor0=ff705000.spi.0"
> -# CONFIG_ISO_PARTITION is not set
> -# CONFIG_EFI_PARTITION is not set
>   CONFIG_ENV_IS_IN_MMC=y
>   CONFIG_ENV_RELOC_GD_ENV_ADDR=y
>   CONFIG_VERSION_VARIABLE=y
> diff --git a/configs/socfpga_de1_soc_defconfig b/configs/socfpga_de1_soc_defconfig
> index 52ed0ff7ffa..f97b3a4055b 100644
> --- a/configs/socfpga_de1_soc_defconfig
> +++ b/configs/socfpga_de1_soc_defconfig
> @@ -42,8 +42,6 @@ CONFIG_CMD_CACHE=y
>   CONFIG_CMD_TIME=y
>   CONFIG_CMD_EXT4_WRITE=y
>   CONFIG_MTDIDS_DEFAULT="nor0=ff705000.spi.0"
> -# CONFIG_ISO_PARTITION is not set
> -# CONFIG_EFI_PARTITION is not set
>   CONFIG_ENV_IS_IN_MMC=y
>   CONFIG_ENV_RELOC_GD_ENV_ADDR=y
>   CONFIG_VERSION_VARIABLE=y
> diff --git a/configs/socfpga_is1_defconfig b/configs/socfpga_is1_defconfig
> index 45d3b2f0807..4136d22e90e 100644
> --- a/configs/socfpga_is1_defconfig
> +++ b/configs/socfpga_is1_defconfig
> @@ -44,8 +44,6 @@ CONFIG_CMD_EXT4_WRITE=y
>   CONFIG_MTDIDS_DEFAULT="nor0=ff705000.spi.0"
>   CONFIG_MTDPARTS_DEFAULT="mtdparts=ff705000.spi.0:1m(u-boot),256k(env1),256k(env2),14848k(boot),16m(rootfs),-@1536k(UBI)"
>   CONFIG_CMD_UBI=y
> -# CONFIG_ISO_PARTITION is not set
> -# CONFIG_EFI_PARTITION is not set
>   CONFIG_ENV_IS_IN_SPI_FLASH=y
>   CONFIG_ENV_RELOC_GD_ENV_ADDR=y
>   CONFIG_USE_BOOTFILE=y
> diff --git a/configs/socfpga_mcvevk_defconfig b/configs/socfpga_mcvevk_defconfig
> index bff0c41336f..db288a2cf05 100644
> --- a/configs/socfpga_mcvevk_defconfig
> +++ b/configs/socfpga_mcvevk_defconfig
> @@ -42,8 +42,6 @@ CONFIG_CMD_USB=y
>   CONFIG_CMD_USB_MASS_STORAGE=y
>   CONFIG_CMD_CACHE=y
>   CONFIG_CMD_EXT4_WRITE=y
> -# CONFIG_ISO_PARTITION is not set
> -# CONFIG_EFI_PARTITION is not set
>   CONFIG_ENV_OVERWRITE=y
>   CONFIG_ENV_IS_IN_MMC=y
>   CONFIG_ENV_RELOC_GD_ENV_ADDR=y
> diff --git a/configs/socfpga_secu1_defconfig b/configs/socfpga_secu1_defconfig
> index 5fe35fe6eb8..552ded52873 100644
> --- a/configs/socfpga_secu1_defconfig
> +++ b/configs/socfpga_secu1_defconfig
> @@ -63,8 +63,6 @@ CONFIG_MTDIDS_DEFAULT="nand0=denali-nand"
>   CONFIG_MTDPARTS_DEFAULT="mtdparts=denali-nand:512k(nand.4spl),512k(nand.uboot),128k(nand.env1),128k(nand.env2),0x1000000(nand.rec),0x3ee40000(nand.ubi),0x80000@0x3ff80000(nand.bbt)"
>   CONFIG_CMD_UBI=y
>   # CONFIG_CMD_UBIFS is not set
> -# CONFIG_ISO_PARTITION is not set
> -# CONFIG_EFI_PARTITION is not set
>   CONFIG_ENV_OVERWRITE=y
>   CONFIG_ENV_IS_IN_NAND=y
>   CONFIG_ENV_REDUNDANT=y
> diff --git a/configs/socfpga_sockit_defconfig b/configs/socfpga_sockit_defconfig
> index fed1dd83dc2..6dec5758fba 100644
> --- a/configs/socfpga_sockit_defconfig
> +++ b/configs/socfpga_sockit_defconfig
> @@ -44,8 +44,6 @@ CONFIG_CMD_EXT4_WRITE=y
>   CONFIG_MTDIDS_DEFAULT="nor0=ff705000.spi.0"
>   CONFIG_MTDPARTS_DEFAULT="mtdparts=ff705000.spi.0:1m(u-boot),256k(env1),256k(env2),14848k(boot),16m(rootfs),-@1536k(UBI)"
>   CONFIG_CMD_UBI=y
> -# CONFIG_ISO_PARTITION is not set
> -# CONFIG_EFI_PARTITION is not set
>   CONFIG_ENV_IS_IN_MMC=y
>   CONFIG_ENV_RELOC_GD_ENV_ADDR=y
>   CONFIG_VERSION_VARIABLE=y
> diff --git a/configs/socfpga_socrates_defconfig b/configs/socfpga_socrates_defconfig
> index a08c7c0d9e0..3bfb05fa419 100644
> --- a/configs/socfpga_socrates_defconfig
> +++ b/configs/socfpga_socrates_defconfig
> @@ -44,8 +44,6 @@ CONFIG_CMD_EXT4_WRITE=y
>   CONFIG_MTDIDS_DEFAULT="nor0=ff705000.spi.0"
>   CONFIG_MTDPARTS_DEFAULT="mtdparts=ff705000.spi.0:1m(u-boot),256k(env1),256k(env2),14848k(boot),16m(rootfs),-@1536k(UBI)"
>   CONFIG_CMD_UBI=y
> -# CONFIG_ISO_PARTITION is not set
> -# CONFIG_EFI_PARTITION is not set
>   CONFIG_ENV_IS_IN_MMC=y
>   CONFIG_ENV_RELOC_GD_ENV_ADDR=y
>   CONFIG_VERSION_VARIABLE=y
> diff --git a/configs/socfpga_sr1500_defconfig b/configs/socfpga_sr1500_defconfig
> index 7744ff9a888..814b4e8ce1d 100644
> --- a/configs/socfpga_sr1500_defconfig
> +++ b/configs/socfpga_sr1500_defconfig
> @@ -51,8 +51,6 @@ CONFIG_CMD_EXT4_WRITE=y
>   CONFIG_MTDIDS_DEFAULT="nor0=ff705000.spi.0"
>   CONFIG_MTDPARTS_DEFAULT="mtdparts=ff705000.spi.0:1m(u-boot),256k(env1),256k(env2),14848k(boot),16m(rootfs),-@1536k(UBI)"
>   CONFIG_CMD_UBI=y
> -# CONFIG_ISO_PARTITION is not set
> -# CONFIG_EFI_PARTITION is not set
>   CONFIG_ENV_IS_IN_SPI_FLASH=y
>   CONFIG_ENV_REDUNDANT=y
>   CONFIG_ENV_RELOC_GD_ENV_ADDR=y
> diff --git a/configs/socfpga_vining_fpga_defconfig b/configs/socfpga_vining_fpga_defconfig
> index 396b7a9715d..f698b86e59f 100644
> --- a/configs/socfpga_vining_fpga_defconfig
> +++ b/configs/socfpga_vining_fpga_defconfig
> @@ -58,8 +58,6 @@ CONFIG_CMD_EXT4_WRITE=y
>   CONFIG_MTDIDS_DEFAULT="nor0=ff705000.spi.0"
>   CONFIG_MTDPARTS_DEFAULT="mtdparts=ff705000.spi.0:1m(u-boot),64k(env1),64k(env2),256k(softing1),256k(softing2),-(rcvrfs);"
>   CONFIG_CMD_UBI=y
> -# CONFIG_ISO_PARTITION is not set
> -# CONFIG_EFI_PARTITION is not set
>   CONFIG_ENV_IS_IN_SPI_FLASH=y
>   CONFIG_ENV_REDUNDANT=y
>   CONFIG_ENV_RELOC_GD_ENV_ADDR=y
> diff --git a/disk/Kconfig b/disk/Kconfig
> index b0bd02539ee..a58717bda30 100644
> --- a/disk/Kconfig
> +++ b/disk/Kconfig
> @@ -142,6 +142,7 @@ config SPL_EFI_PARTITION
>          bool "Enable EFI GPT partition table for SPL"
>          depends on  SPL
>          default n if ARCH_MVEBU
> +       default n if ARCH_SOCFPGA
>          default n if ARCH_SUNXI
>          default y if EFI_PARTITION
>          select SPL_PARTITIONS
> --
> 2.51.0


Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong

