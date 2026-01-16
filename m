Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10843D4A60A
	for <u-boot@archiver.kernel.org>; Fri, 16 Jan 2026 07:55:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 79F1382BF2;
	Fri, 16 Jan 2026 08:55:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CiuMykPg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2206B830E4; Fri, 16 Jan 2026 08:55:20 +0100 (CET)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6668D80077
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 08:55:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x9V3Ta9xIdNRm6vYBAJcCU5VdH4W9KAuW0pEa2oI3XS6svJhYkim2B1YgJG6ph4WVb0dZfslRIBTUrE0ntML66fdHHPi1CfEJvyatiJe93o/hKgGAuo6zTZko4KvoMBnupmf4lRJPk3Kc1+n+Oa8+KS8kJ4bybX6HscZ1qTZ9he0mQx2o06M0+A3JstF+SQIjkU1DuyclHAqFLKhEXIyVNF7JEOn/8DtT8Ztt2HxlStR2BsJSWdkmBDjVNqbTCYAItc2jV15qmuWHXeNcceYpgKxmqOvgcgYOKVUM34B0cwm/i3NnixKyVCylyJH1hK7AV8zJ9QRjyjTWS3Of+hv1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IEVIVUMkkJIHq+flA4NEEiJiukswMNzXVjPY6Nyiwzc=;
 b=xL6cCNGi+e5p+ulIdhcMeoBfFKDLjveL5slL+PrA79rzv54LM0WMNHqlN7JE7eK3UHqKe4LYXom1F7EnmsFquMzI7EXKIgqPKY1MDlTgf5qc07HCCuYU61+C7TE/sgfhgrnOXAxOSOhtsMw/rf7P8pqNjzutmZq1Lyge20ABiZGsswv1vLHZXmaiTPw1Gn34P2SwZJMAR+dNFMHlVAS/IUXz0ihe4ma7wHhK67H/ZYgV2KR74JkATS8XEYx4shvkcpb4DEq1ELEuc5IPlgzinXq6T81NhTNdRYAxx8voLilSUaHlCNxT1fN1Xi9Sjbtw/wRrW33/5G8yhn+l3hK9pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IEVIVUMkkJIHq+flA4NEEiJiukswMNzXVjPY6Nyiwzc=;
 b=CiuMykPgH7Y7zxnHqcyH85QAY1NnepfX4pLi3KprNnOArxGTw2wr9CRmB69xF1KdIJjREnvO8cbvoySoUEJqkm3XiEmg+lu7wBFEkD6uqQezvWpVG2JNUNRtpu4mMMX3SoNBvrzvDZZbQpX5Ez/ZzFZSnff7aJVxGPgijGpIuYg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by IA0PPF7646FEBB5.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bd3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Fri, 16 Jan
 2026 07:55:12 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.9520.005; Fri, 16 Jan 2026
 07:55:12 +0000
Message-ID: <b6caab58-46da-4349-b45a-1fc18ef0ac17@amd.com>
Date: Fri, 16 Jan 2026 08:55:09 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: versal2: Fix emmc boot mode boot_target issue
To: Pranav Tilak <pranav.vinaytilak@amd.com>, u-boot@lists.denx.de
Cc: git@amd.com
References: <20260113060107.1136297-1-pranav.vinaytilak@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20260113060107.1136297-1-pranav.vinaytilak@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0009.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::14) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|IA0PPF7646FEBB5:EE_
X-MS-Office365-Filtering-Correlation-Id: a716b88d-5a37-4483-841b-08de54d493d2
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TlhMSVZRWkVQaEF1T3AwalYwNWRtM3MxQXQ2akppME9rOWxOcWcvb3FCK3Zm?=
 =?utf-8?B?QmI2SHVCZU9ickh0cm9UVmRmRzMycmpjYnFnOUFhK1NQSHNWcU1uWGxzVUlC?=
 =?utf-8?B?MDZBT3B0RGIremhjdVpZaE1oUnNaeE5JVFkxYXFRY0k5aXV0bmpnNjg1aUhI?=
 =?utf-8?B?WVF0N0o4VGdUOEVlcHNNazMxMTlvTGY5Uy92RnVRU04wcjV1ZC9IRkFKdUl3?=
 =?utf-8?B?NGFpQ1FBTEpDZ1FzK2d3ejd3S0lDZVpEUHdZUTZGd29RL0Y4QWFXMjczQ0VO?=
 =?utf-8?B?alhReTNua3kzQy9rQ25aem1QYWtBRyt2dkhzTCtjWGlzeUloTnJiVVd3U1hO?=
 =?utf-8?B?Y3lQRlRTZFFXWmVhcmFFSm05cjY0RDEzejlpSXdKa1NJWllWbVl6aktMZkZF?=
 =?utf-8?B?MmpLdDlhOXp6WkxTRjNxLzg2SDFUTmZwU0NucW5SZHVBRFhQS3d6ekc5dnZQ?=
 =?utf-8?B?UW5rYlo2OUNjclNxKzY1d1VhN3FvTHNLaDc0UngzMEdmR2RVR0hYNXVVejJh?=
 =?utf-8?B?RFNtSzkrdFV5OVpFMDUvQjFXbnAzMVFmaEdIVkVWakU0RkttZGhHWS9uZnZQ?=
 =?utf-8?B?YXBBYUtLR1JIdmNQQmljMEszL01NMVdlV0FGaUVPd3BOVHhmMFZNOFpwT2lh?=
 =?utf-8?B?TG55a3o3RHE1OXJ2NzVDZldVK3ZwdkEvemFRcG1wMmZFWnVuK3YyOVpvVElZ?=
 =?utf-8?B?elRnMHNuL3EzU1Q0UHRFQUUxWm9EdllSVjFhUVdkWUNwb283Wm9uUHQrMnM1?=
 =?utf-8?B?WWkrL1o4QzV4bUxVSjJCSmoyY1BYMVJFa0YweE9INFgzcXhXcUZ4Nk5sSVZs?=
 =?utf-8?B?WFYrbEpHV3ZFcFZ0QTZsbXpKS3JpMlJrcjZrRS9HM01Yay9hS0NQbm4xRW1U?=
 =?utf-8?B?VkZrVzFGYUg4bXZHVXdsb2xISjNJbFZHV0l0aTBkN1QwdndLbmp5Rno0MzBU?=
 =?utf-8?B?MUxFeFJMRDdQbmVlMDZhUy9IMkw2VVVlakFQekZ1aE1iaDNtNTdZTE1IRE0w?=
 =?utf-8?B?eXBHUy9UTWVFV1d3ZlFQN0s1cU4xYWp5Y1JabmhNS3hrUUFDQVlnbXJ3bG1M?=
 =?utf-8?B?YTZRR2h3a05aK3QreXhwTkM0aTc1SVhNQTlNbEU1ZUlBa3Bqa2FOc2hFY3Qv?=
 =?utf-8?B?ZFh5eGZpb2tOSlBGZXp6QlpjcUE4SWxKUS9Xd3R2aU1yZmFxQ1NJdDRvVHRM?=
 =?utf-8?B?akNsZEliQXladHVQWklIZ3JObnNmTzlhNnFjd1BodFdFMmRkT3JiRjI4dkhr?=
 =?utf-8?B?a25jNGhPOVJTb0N0Z29rLzdKcjA2ZDViR3l1Rzl0ZXA3OU9TUXF5aVhOY1Zj?=
 =?utf-8?B?ZVBnUXl6WkdRd2tyTGpweGM1RkxZZXdIVHFMQnRYRXRaYk85bm96SGFPWi83?=
 =?utf-8?B?MklvTHpvb2Rpd2ltbnNCZTVFMTBRNGw2eEVobk45NUErTml3MW9RTmF2U1RD?=
 =?utf-8?B?eTYzYytRVTZ1bGhiZGJlVURiaEk1SWI2d0JOSVdwZ2lEc09KNHlqdmxQUCtM?=
 =?utf-8?B?b0tQVXBDSjVQQWtIY0VtR3NPVGRFalB3VTBkUjIyOXMwMlJwTGZYckd4WG5l?=
 =?utf-8?B?S1lWSkE4STlGcm5nTEl5c3hWckNGb3F0SmJmdjlPQ0k5aVJ1MHhXMU5nYUNi?=
 =?utf-8?B?K2l3cmxOT3lHT3ZJalpLeWtNRUFvYloxcmdvRjZxMG5DaTczODcyUEZsRFRP?=
 =?utf-8?B?bGFuQmQyQytFMmNRUHY0blo1U2IwNW1DR0I1ZzFRVzJXYWticm42UzdmWjVB?=
 =?utf-8?B?eW9rbVU4MHBEOVg3cVNoUlBYVjcwMHBvQ0dJUjN4dXZvT3FZUmtyQ2E4aGsz?=
 =?utf-8?B?L2hRSWlGU280UG53RUZQNU9HQmY4NWgycmpMWnJac0VjemdIczlaeHRCZFB0?=
 =?utf-8?B?amdsRGR6YnRmbks4UHlDRjhpeUQvZUQ0MG8wZHhTSWJQeDQ1cUFBT3dmTllX?=
 =?utf-8?B?ZFhCV3kvWjBHbFdaTWtjRThoNmRJa251RFQ2TDB0bUVsSXJqc1FZL29aWFNx?=
 =?utf-8?B?M2JrMVZJUDVKSzFkVHlWS3REMEc0S29WNUNpU3RpRlV3d0xkVisrUmZia0ZZ?=
 =?utf-8?B?Z2dPeU5qYWtjUFFMOFJ6YjNQMDhoZGpoQUVNbWpxdUUrQzBKTFpZSUN1UFoy?=
 =?utf-8?Q?wjcw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGZtSlNldkdjVWhKQW4rSlhYQ3JGSlZ3UEZTYTlQWFJ2VlVGQ2pqQUFuK2VN?=
 =?utf-8?B?blB6NXdvM1hqb1NnQVRKOXpLMEpNN21BOGVsUytOWWxzZWFGd29INy9YbE41?=
 =?utf-8?B?Vnljc2dmbnRnNitockJKSjJueTFVT2laUFBpWXpqRmZ6M1NyaGhXdnVtY2FR?=
 =?utf-8?B?SHBkQkJxVVB2T0tabFhvb21QYTQycnFKR1RmdU9FODl0Umx1dUNqLzNaWVBN?=
 =?utf-8?B?ZUJidnZLUkUrVDBUYVNveFFGRWxTMGh2UmVZYWpzc1FFSjVIZGlSa3QxdlQz?=
 =?utf-8?B?N084UFhzZFRlVGE0SjBUazVQYXF6b3Q5ZTRBWU1CbmhndzFzMHJMODR6Rklr?=
 =?utf-8?B?aGZFR0k5aHpTaUdFNk5iVWNsUzFkemoxSE5Ea0ROa1IvaEMyWWFveHRGOTdp?=
 =?utf-8?B?RTVDOCtoZXR0ZkVDUERYVnN4Y0g5K0ljeUYwTHkrR2pmQXFyYUZwaVZmOGhS?=
 =?utf-8?B?TmJyRy9OcmJVL3B4dk1nM1plLzVWaGEyRG5GYVRXVm1XUEVmckoxSTc3SFdy?=
 =?utf-8?B?SHNmYmY2TGJuOE5zZkc5VXpRTkZ3VVp0WU9CK3FVRkZBK0FCanc4aEg0SUpo?=
 =?utf-8?B?ZExqQXhaZFpEOEVFck4rNDEvVmEvTUdTZmEyb3hCaWhYeUFFbFl3U09hdXVM?=
 =?utf-8?B?L0xMZFRYN0huckcrQytONFZaS0FYdGxBUlRvNGFCRlVyOTlwdFhTNDdwbTNS?=
 =?utf-8?B?cU9IaDVyd3RsR0xPYVhzREl0VGJWMzJDbmFoRzZqcmQ2R1JnNGo4K3BjRWVR?=
 =?utf-8?B?UUhVSHNOWmkzL05VdmZzd2pZMmZ0dUxxKy9zQXdnRUVEdFFrL3FSQlFLejNt?=
 =?utf-8?B?cFI3TnUrVERuRnlnV1VxTzR0RjlsUDZrQThIUm9RMVJ1SlFhUnEyMTBGV0lS?=
 =?utf-8?B?Y0VOejdNSlBrbUo3L0QrT2t4akcyQ2xmWFp4dGVVVCt0RWI1OHpNQldydGgx?=
 =?utf-8?B?RnlneGRrM3pTTDdjYy9kdzBkM204a0haWVpSajJJZEduR1hERDNMZUNOU3ZL?=
 =?utf-8?B?ekp3SWhpend5VFBoSG14QVpDdnM1WlYrMGZFSGoxSXZTemhjbmppSEVsek51?=
 =?utf-8?B?VmhCSllRUjVMdkI2U0hXb2V1L1YvNDhZNW4zaXAxeXpxRjVxMGNuNHdWWFEr?=
 =?utf-8?B?M05YRjBaM1NmWGl6NGFiQmlFSXNmZy9zemd1ZmQvWFNCaTFnemRQa3NQTHhG?=
 =?utf-8?B?QzlvdE5JRnhiQm4yM2xQc2FsNFF4TlovMjFlNjJqQmtibmRWeVFWbDVCYith?=
 =?utf-8?B?Mng0QnVNM2N2ZFcxRUo3WEp1TE5EZVJFcUsvZFdYNngwbENxZjZNSDZvUTYv?=
 =?utf-8?B?R00rMXVFYk9DVVNlN0pKNUZ0UWFHTEZpWk5OT3llajRtcVdEb244ZDN4bFI2?=
 =?utf-8?B?NmdmQnUwSW5EUzhubGtlQmloOHNrVUpPdU5FT1lUb3pNejRGL2xnK0FmRVBw?=
 =?utf-8?B?dXRjc3hjcm1kRVRkZ0NkMGNiUU1zRmZFOTRnTGFQU3IwS2NINzJ0ajUxU25j?=
 =?utf-8?B?QUVzUXBNM1ZsNnpNR3ZncHNNaTVicm1KRmwvdmJrSDdiSStrL0M2MkhvdkpH?=
 =?utf-8?B?ZCtNSldSWXFBRFEyK0NuNWoyY2ViZlpPUW5CT0xhbEx4ZkdwdXZvUTVQTTdT?=
 =?utf-8?B?bGdlbXU5ZnFjQVJxWTQvelRmT2NDbjBtUTNXQ3dnUlFkR2RpUjZaMVNSaFZl?=
 =?utf-8?B?NFk2WlFpWEQ4cGx3dVkyd0NFc1owVU9ONk1Ua2FxSk11VVBiZVlKVGo4emEy?=
 =?utf-8?B?Nm9BSUVwSkhsRTZ4UmYzMDNYTDFoelZ3bEZQZ1B1OEJlek5qNEhxTzdzZXlL?=
 =?utf-8?B?czd5dzFUbGwzTWpVUFpXNitaRWV4ZkNvM3lWQThQRVY3T2VGRk9ScFdkdkdh?=
 =?utf-8?B?MVB1ZUFSUWxZQjVMWE1neFBoYU04engxOUV1YnJLQm1SamRpK2NicEdNTFFY?=
 =?utf-8?B?eWJwMW1LbkIvZTN4L0xZUExLK3NyTDNRWjA3bnZrc2RGVUROYmFhQXN1ZUth?=
 =?utf-8?B?bjZ5aTBCU0NEeGlhS1orTEJzRUtGTWhMWTYyMHl4TEoyT3NNNE1KZUUvSmQ2?=
 =?utf-8?B?SWtkank4ZXAvSGFyMVJSUDkxS0NHOWFXdFZrajJzd08wekN1a2hMYjFoK01r?=
 =?utf-8?B?dy8zUTZZc0l0bEhKVDZ2SnBPVk02Vlh1SG9idFdYRFRCZ3FoSGUxdk9keEZN?=
 =?utf-8?B?d0FTbFJ3TlQ2Z3FaY0VrL1Mxc1AwL3hUNGlPeEIweis5dGdUeHhEY2ZSNmxB?=
 =?utf-8?B?M05qTURGRWtFY1ZuWEoxK1lZSmNpYldxNnFHVWhWSkVMU2NnUVZFTUtZdVpC?=
 =?utf-8?B?L0lzeVRndG1oWEF2RHUwc3o0ZVdjTXV0K3JyR2MrM0FPVWVDWCtNZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a716b88d-5a37-4483-841b-08de54d493d2
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 07:55:12.4052 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fLlS7wonED/u/+3VT4xAqi/Kmq2bici9xx7hoDEWwXvK5aqjt2Xvj0tcB+P1WXTm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF7646FEBB5
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



On 1/13/26 07:01, Pranav Tilak wrote:
> The eMMC boot device controller on Versal2 requires device pointer
> initialization before accessing its sequence number. The EMMC_MODE case
> was using dev_seq(dev) on an uninitialized pointer, causing corrupted
> boot_targets entries (mmc7f7fbfbf instead of mmc0/mmc1).
> 
> Add uclass_get_device_by_name() call to properly initialize the device
> pointer before reading the sequence number. The dev sequence number is
> determined at runtime based on DT aliases.
> 
> Fix boot_targets corruption in eMMC boot mode, allowing proper boot
> device selection instead of falling back to JTAG mode.
> 
> Signed-off-by: Pranav Tilak <pranav.vinaytilak@amd.com>
> ---
>   board/amd/versal2/board.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/board/amd/versal2/board.c b/board/amd/versal2/board.c
> index 1fd05a1157a..d8079c1cee0 100644
> --- a/board/amd/versal2/board.c
> +++ b/board/amd/versal2/board.c
> @@ -253,6 +253,12 @@ static int boot_targets_setup(void)
>   		break;
>   	case EMMC_MODE:
>   		puts("EMMC_MODE\n");
> +		if (uclass_get_device_by_name(UCLASS_MMC,
> +					      "mmc@f1050000", &dev)) {
> +			debug("SD1 driver for SD1 device is not present\n");
> +			break;
> +		}
> +		debug("mmc1 device found at %p, seq %d\n", dev, dev_seq(dev));
>   		mode = "mmc";
>   		bootseq = dev_seq(dev);
>   		break;

Applied.
M
