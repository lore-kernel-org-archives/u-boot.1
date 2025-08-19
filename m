Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7879CA0EF5
	for <u-boot@archiver.kernel.org>; Tue, 19 Aug 2025 08:40:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E746A80FA1;
	Tue, 19 Aug 2025 10:40:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3K9g1SNm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2529082BF6; Tue, 19 Aug 2025 10:40:41 +0200 (CEST)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::601])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96D78802C1
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 10:40:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZNSm8H9vVUFnhS5gxJS7oUrrVc0lZsxnPA5jU7z6azviWMqzUVa4/5H3KEGwzJ3uUazrtLXTnIOWQpDpfyCw4H4R3BhGY90wb2rhUQVv3PfJUnrO9jsLygGpUOPk4qOIaYQOgYOgeo+H4n18kOmU0UsfroN5J/xvEEB0L8vGbk85xThmo3hFx6MRwD9+VZuIhJP+bfYWU/IWJ3AcErtvEVaeTMy98Ff9UnUhApFhY0Zs/Y6tLE8qDSsZ46YRk+X/eQYn7VZNgCJ8EXE8ydlyoVaRedRiea8tCcjYsAYsLFjTpH+YD5jRNFbuMyeUKWN+7K07IxozNPwy7imlW4Pgfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EphUBYOTMhSqppIRW5XKtwiGCOUOXu2wnGOfzWsMLBg=;
 b=td6Im88f/qedkIbBbASM6HzXAZr7+32pCCZoZvc4NUMN1zRvRxJTlueKl/OZvQUVApyEsevMFnf6rmt/8nV1WwMEoCNeb2mZcNaJeROZbWWbsd+U0iQ7O8KKhTDORXwlt4rPA0+jUdJKk3EbXkA33PdhDMK3twIhVWRO8D7BIGilXy2lKg//cJGCJXAVIeQQOWKhDHbF+KfeETFxAGl13nwgVU5/DCj+WWXBF/4Gp7mMM3Jg3JvLSdSowVELdUu7apqbD0CZEcYaM9Pk+N6999spWUJBPgr7nr1liQyTw2lgJ1Ru7iz3GpiQWvnb5Bq3wbos1GcgCk21Rn/hOfOyFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EphUBYOTMhSqppIRW5XKtwiGCOUOXu2wnGOfzWsMLBg=;
 b=3K9g1SNm6U00V0XGPiqO5f9slJysu/m6KOH824wMkvYkWuV3H1NJeNgc6BvRa+gQktLyThCLN+ZcvODIlfslDu9MPp1K5OQgy/V/o5l4iG4g9CDZBxzgo6inhx3Jgz6emOoxcWJPA0MNVXqVCzC0pr5leE8dYIa6lwD1oZnuovg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by DM4PR12MB6423.namprd12.prod.outlook.com (2603:10b6:8:bd::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.24; Tue, 19 Aug 2025 08:40:32 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.9031.023; Tue, 19 Aug 2025
 08:40:32 +0000
Message-ID: <27673c57-3c9a-4246-a870-a68cacb26c7d@amd.com>
Date: Tue, 19 Aug 2025 10:40:28 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ufs: amd-versal2: Configure RMMI and M-PHY registers for
 HS mode
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Cc: bhupesh.linux@gmail.com, n-francis@ti.com, git@amd.com
References: <20250724044402.260149-1-venkatesh.abbarapu@amd.com>
 <cb7c9a99-fd0c-4393-b6fb-89415e2941f4@linaro.org>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <cb7c9a99-fd0c-4393-b6fb-89415e2941f4@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY5PR04CA0015.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::25) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|DM4PR12MB6423:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b46f028-e90a-4d46-a236-08dddefc0eec
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TjJIQi9NTTlNamYzbGdaNVF1WGpka3Ryc29xSmtnUTBrd0o5aHpWWHVSSmNY?=
 =?utf-8?B?Nmk4dUVBa2JwNlBUNWdTMnF5eC96amtUdWwraGZQUjNYSmZEU21ydDVSWDZa?=
 =?utf-8?B?akhHbTlNb0lOcVh3bFdwcWVTQUkxaUF3VmtXSmJEZndBOW1xREphTmUzNWlH?=
 =?utf-8?B?bGo0Mi9BbzNSbDBRQ01TVWJTUTU1V3NveHN3YmRra0pEQTV4eDBpQzE0WUt6?=
 =?utf-8?B?WU4zcG9BWkE3MnF3akF1MXJta1E1US9vZnRzdFh6M0t2QU9mNVhONWVxNVFM?=
 =?utf-8?B?T3JValJwZ0RMTGo2aVN5cFRRSlRyS3djVXFpVWZGODJ3UWQvdzhlTlQyUUtZ?=
 =?utf-8?B?aXJOM0gzZngyNDFrd0VtTDdEOU5GZ3hsV3huc0cwM0V1MEhnUm9lUnVza2Yv?=
 =?utf-8?B?NE5Qc0Z4R1NpTlFlMURvZGdGVU9FY0lOK3M3ZkIrUFcwSDBjTVhiUnZza3VL?=
 =?utf-8?B?ZzVvSVNhckNGWU9xMTJSZ0VoZWlrV3RZUGRGOXZuWXFEL2JiTnFNWjVMZmhm?=
 =?utf-8?B?SnJRbmRQNHg3bjVvd0hPNm9reHJ1NERLR29PN2puMWpnQVJFd0VxaFVlNnpM?=
 =?utf-8?B?SXlBbm5zVWMyYzd6YkZvVTZYbStaVUdwaTRZbHl4elQ4RkhOT0lPYVZGaWxF?=
 =?utf-8?B?ckpnbEpxVHFyekwybFhaYStGUWhQUXBvandWZHJBeDREQ1hneTR3Z0hVQ2V1?=
 =?utf-8?B?M05UdWNKbE9NTEdNMEZrWXNoZGtiZEZkU2FrWTJiLy9xeVRDa3FWREluUW1Q?=
 =?utf-8?B?YU1nYlpON29TUFdzazB6VXp3QzljYWp1MWhpMFJHUnRxL29lNDE0eGhSbHJv?=
 =?utf-8?B?QkZUUlA0NGN2ei9heGcwSFlHb3NGdVlBNmtSME0wL09JZFNIbEFEams1VW9Q?=
 =?utf-8?B?R1NTd1BGaUdvd25hOURidkZpNklQRGJEdEVITnlqV1YvMk1jZDh3K1BLbWl5?=
 =?utf-8?B?UTNUNldTcFBxNGlFamhMRjlxNTI3VDMzS0lRYTdpaGNkS0l3b0ZjYUlET1Jr?=
 =?utf-8?B?NDlJNHpBa0lrSk5URjlKRFhiOEI4S0lUcm5rMVNQYzF4a0wyZHk0N2pDYVh1?=
 =?utf-8?B?VmEwNkpNK1I2ZVQ3RzZuMEpLdXk5ai9UV2M0dldZWERDQy9Cc2hhNXdTK29D?=
 =?utf-8?B?Q3dLV0RWNEVPNEwyWnRZVC9hRHI4R1kzQ05VUWtrVklCV0c4a0IybU5LcjlM?=
 =?utf-8?B?c2VuZ05DdWpJQkdITVVqY2NSN3JYbG1SK1VWTnM5SGY1Ly9uNXY1ak01VkFI?=
 =?utf-8?B?enhQQzEvL3JlbUkzQlRiNGNFVzUwY0dSc3M2aW83UGc3YkowYVQ2dlc3UC9K?=
 =?utf-8?B?a1hreU5zU2xoQUdYK3JkazNtOGpCcGZWL0o5QTBqdlYzOHBPUFZOUnVUZ0Z6?=
 =?utf-8?B?cm9BcDVxN3B3TURUTHpqTXNiN0NWQmdxT1FERko3SktwK3ZrcjZqdjc4SnZU?=
 =?utf-8?B?aTdNTXNZUUM4bDNyellqRnlhK0c5NkpJKzd1eHJ3Z0E4RmdQZVF3L1VZbTJZ?=
 =?utf-8?B?RmpEZG5yN0huNW4rNnA2TmRMTEE4V0RxaHJqREpYeXg2SlJJelhGbkRLVXk5?=
 =?utf-8?B?N29HVzhaNEdhV3VnWW9sRG1wM1RzR0ZMajJyc21ESWdBNXNobkZiRHF1SnNt?=
 =?utf-8?B?MVd1SU1sbitWODF2Y0tsL2NtQ3gwdHRPQjZrdnhNby8reDloalNObUNUTkN0?=
 =?utf-8?B?UnRhRjZVQUp1NGVtNjZDNC82dWtqVzdiV3ZDYXNucjA4djN2MkljSGZNWWsw?=
 =?utf-8?B?VFMxa05UcFViTmhvQXlhMDlybGF5R2l4NTJDK3hjWDBrbU83UHdFcWtJODZn?=
 =?utf-8?B?OU1aQnJXQldWUWxXbzc0WnE1dmVhNVo1MEhJYXY0NGFiU3RQV1hJRi91dk5C?=
 =?utf-8?B?dGlCSG5idldFaHNVRW8xVHZHZU01THRLaWU0NkVuOTc3Y1dWRFZ6VmV4UHV4?=
 =?utf-8?Q?iPpR8BDL0L8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QTZzU3MxUVMydmN4VTNsSUdaY254b3JHVHZBNkU1TGF0ZWRacjIzNE40b2NI?=
 =?utf-8?B?YWpGNjVlc3M0d3FCZlNscFVnYUJzQ2RQaXBjN01YMVFISVl0b1dRZ1dTMUk0?=
 =?utf-8?B?V1JSUksxNFd3Y1hIb2FZdkRldWJTK0JHNVJkVHR0NTFOVzl4QmZ1UUdFbEN5?=
 =?utf-8?B?UzFSVTFxdmlPYmRsMDBodmJsWU9RNVFhbnc1UlMxdkQzNWY5VWV4Ni9sL0c0?=
 =?utf-8?B?MkpvckQ3d1cwZzZWdmVEaVlIZjJNZ3BCRUtTNUxCWllkZEhEMVF1cERrOTV6?=
 =?utf-8?B?Uy9NSk5QVmlReU81Zk85K0pkTy8rS24ySVlITWxIRHdLYUljQXVIVnVsMTYw?=
 =?utf-8?B?c0oxR1ZmN05lcFMzLzZTTUozNHdDNHRKQXZBa3ZVMnM2LzJlZE5NZEFoZ1dy?=
 =?utf-8?B?K1B3bXhKaUJwcVlWSXhzRFpCZGJSdVRzL2RFZWI4QVNpaWRiSmhyWU9YWDla?=
 =?utf-8?B?NE5ZRmRoSnRrU0lzQzRoYkxWaFpoNk83bnRJQkhKUHoyaXRkSWhpdHFaQ2xh?=
 =?utf-8?B?d2UzUXF2YlQ0aXovVk4rWnRPaFRBb2VURmFKSFFVUytNZ2hJMXFRSGpqZ0RE?=
 =?utf-8?B?WlRYZ3BZZlh4L2tEUkp2Y1EvNWxTWkU2bmVDTTErQUJtNENvNTRYMnBiTStO?=
 =?utf-8?B?Y0ZZZlpBMmhCdUh0dmZFeitZc1hPYWtOcnhIdVRIbHhXcHg5M3d3c1AzSklS?=
 =?utf-8?B?T2JRUkxsdmJ1ek5ZYlFCREtnTmh5UEU3ek4wZHEyT3lwZ2kxTVEwL2toaytE?=
 =?utf-8?B?WnBMSVN4Zi9mL2N6cThTQ2ZCS3VHejhxc0Zrb2VJUjZCVC9IZmxFZU9MdVh0?=
 =?utf-8?B?YkNuakN4bHd1MTRxZkc0Zk4veEtnbWEySVVMVGh4RTU0eS9oRW1NQjhCTE1q?=
 =?utf-8?B?amh0cWduem5VYkFzazBYM1pZaU1DV2VOMFJwY0VtYmJUSlJvRURtTTh1ZjlW?=
 =?utf-8?B?NUpLQVFJalZrVmxTRDdKaXFNWUxvblM2WGVCSzBrTEpxWkR6bjdVTkprcTJF?=
 =?utf-8?B?SU5xUzlDNldpd1YyU29uWkF3NCtWWG14cVBDcjFWYVR5MWZaV2dyQTFaTnFJ?=
 =?utf-8?B?WnFCWkVRZ0V4MWdQeEdMaDhxL0Z1TE5ycDNHNUlTR2VmMlVTay9aRm1ZTDlX?=
 =?utf-8?B?TFlESnR0UXRkT21Vb2Fnbm5xSmlneDNacGlPVW56N3hIaTRlb3VZZDhrS1RC?=
 =?utf-8?B?ZGZKVjFLdmlDbXBrSWRmU0I0VGRGVEw3TlcyT3BVTDlvTzhMS202TThzVWZL?=
 =?utf-8?B?eUxyQ1NpZStBcG9ZcnpJb1BXSWZZOEcvZWFkbFR0STFIRVRIZEVvRGxLQU1N?=
 =?utf-8?B?ZHk2MnZKNG1UeFpUYy9JZUNnNnk4RHNZV3FXUFZqOFg4TlF5b2tKQVd1YlpJ?=
 =?utf-8?B?U05YVFN4YUlUbVVoL01kR1dvbm5pSE5hYXA4dGorVUhRL1Rjd1ZzT05MaVhZ?=
 =?utf-8?B?MVBya2F2Q3ZkV0xQdVBkZkMvVUJyZ00rNzVlN0xiMGZJcjlNeWhodWgreXhW?=
 =?utf-8?B?VytjOWVTYkhDeFNjcktjc1h3dmxoRTZxYU5qWnNhYy9OWlhCYlkyTUk5K0I2?=
 =?utf-8?B?U0VhWU9TVWo4UURqcFJYOHd0R1FpcllwcUtXQmxwTVQyZmZPK3Z3RDB6MHdL?=
 =?utf-8?B?NVFKQ1U3L3ZxVHE3eldGQllYQWUrdVkrSWU0M0twdEoyQUcwYUJTZng4YzFo?=
 =?utf-8?B?ejdrN3Z1Z0hvN1phaFduUHdrMkpyMTB2azFUMEIrejVzVlIzWWhLdkpoVGdL?=
 =?utf-8?B?ZWRtcTA0bG1JTVZ6RzJ3YVNaWFV1RlIrZjNoWTJCTjJJK3lxeEhjUTJnL0tE?=
 =?utf-8?B?Qkh4QlhrVmxkbXFTVjdnYnpSR0EwUCtpcUxQdlE5aVZWUlVzbzFOMmVUMVlu?=
 =?utf-8?B?MVZsNEFYZGRxRGE1bEhlOW1LajRYTlpOWjlBTGFiRmxhVWpEL0hhL1FFR2F1?=
 =?utf-8?B?c2JVUU90RTJId2J4RENpSjJtQ3pNanBWSm92Wko1Q0lqR0RwZlhIcWgzMXVI?=
 =?utf-8?B?WGdlNTJlN1BZbXllcW9sbVRhbHpBYno2ZnFFN0V5K3RxMmtlQWwrV2Z6TjI5?=
 =?utf-8?B?N25ZZUxoOS9aeEU2bTlieTlwUzVoQTZuOXRuR3pIZitaYUFoaDIwcExxS1Na?=
 =?utf-8?Q?HudEVOykssrEx+sJbsDV0xdiA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b46f028-e90a-4d46-a236-08dddefc0eec
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 08:40:32.1356 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tF+PAiZqqbpRifQUiMcfX8sujJbMguyGoFzp9YVrsNAXFvEKDzTTsWSBa6GkNHT7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6423
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



On 7/24/25 10:22, neil.armstrong@linaro.org wrote:
> On 24/07/2025 06:44, Venkatesh Yadav Abbarapu wrote:
>> Configure RMMI and M-PHY registers for HS mode required for selection of
>> bit rate series A or B. If it is not a calibrated part, then switch back
>> to SLOWAUTO_MODE and skip all these configurations.
>> Implemented below sequence as per the DWC RMMI databook.
>> 1. Override RMMI CBRATESEL with the desired rate.
>> 2. Set TX_CFGUPDT_0 to 1'b1 for one TX_CFGCLK_0 cycle.
>> 3. Override PHY rx_req to 1, then poll on PHY rx_ack register till it
>> goes 1(both lanes).
>> 4. Override PHY rx_req to 0, then poll on PHY rx_ack register till it
>> goes 0(both lanes).
>> 5. Remove PHY rx_req override(both lanes).
>> 6. Start the LS PMC.
>>
>> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
>> ---
>>   drivers/ufs/ufs-amd-versal2.c | 112 ++++++++++++++++++++++++++++++++++
>>   drivers/ufs/ufs.c             |  15 +++++
>>   drivers/ufs/ufs.h             |   3 +
>>   drivers/ufs/ufshcd-dwc.h      |   3 +
>>   4 files changed, 133 insertions(+)
>>
>> diff --git a/drivers/ufs/ufs-amd-versal2.c b/drivers/ufs/ufs-amd-versal2.c
>> index 1c5ed538370..896dda2de4e 100644
>> --- a/drivers/ufs/ufs-amd-versal2.c
>> +++ b/drivers/ufs/ufs-amd-versal2.c
>> @@ -26,6 +26,10 @@
>>   #define MPHY_FAST_RX_AFE_CAL        BIT(2)
>>   #define MPHY_FW_CALIB_CFG_VAL        BIT(8)
>> +#define MPHY_RX_OVRD_EN            BIT(3)
>> +#define MPHY_RX_OVRD_VAL        BIT(2)
>> +#define MPHY_RX_ACK_MASK        BIT(0)
>> +
>>   #define TX_RX_CFG_RDY_MASK        GENMASK(3, 0)
>>   #define TIMEOUT_MICROSEC        1000000L
>> @@ -422,10 +426,118 @@ static int ufs_versal2_link_startup_notify(struct 
>> ufs_hba *hba,
>>       return ret;
>>   }
>> +static int ufs_versal2_phy_ratesel(struct ufs_hba *hba, u32 activelanes, u32 
>> rx_req)
>> +{
>> +    u32 time_left, reg, lane;
>> +    int ret;
>> +
>> +    for (lane = 0; lane < activelanes; lane++) {
>> +        time_left = TIMEOUT_MICROSEC;
>> +        ret = ufs_versal2_phy_reg_read(hba, RX_OVRD_IN_1(lane), &reg);
>> +        if (ret)
>> +            return ret;
>> +
>> +        reg |= MPHY_RX_OVRD_EN;
>> +        if (rx_req)
>> +            reg |= MPHY_RX_OVRD_VAL;
>> +        else
>> +            reg &= ~MPHY_RX_OVRD_VAL;
>> +
>> +        ret = ufs_versal2_phy_reg_write(hba, RX_OVRD_IN_1(lane), reg);
>> +        if (ret)
>> +            return ret;
>> +
>> +        do {
>> +            ret = ufs_versal2_phy_reg_read(hba, RX_PCS_OUT(lane), &reg);
>> +            if (ret)
>> +                return ret;
>> +
>> +            reg &= MPHY_RX_ACK_MASK;
>> +            if (reg == rx_req)
>> +                break;
>> +
>> +            time_left--;
>> +            mdelay(5);
>> +        } while (time_left);
>> +
>> +        if (!time_left) {
>> +            dev_err(hba->dev, "Invalid Rx Ack value.\n");
>> +            return -ETIMEDOUT;
>> +        }
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +static int ufs_get_max_pwr_mode(struct ufs_hba *hba,
>> +                struct ufs_pwr_mode_info *max_pwr_info)
>> +{
>> +    struct ufs_versal2_priv *priv = dev_get_priv(hba->dev);
>> +    u32 lane, reg, rate = 0;
>> +    int ret = 0;
>> +
>> +    /* If it is not a calibrated part, switch PWRMODE to SLOW_MODE */
>> +    if (!priv->attcompval0 && !priv->attcompval1 &&
>> +        !priv->ctlecompval0 && !priv->ctlecompval1) {
>> +        max_pwr_info->info.pwr_rx = SLOWAUTO_MODE;
>> +        max_pwr_info->info.pwr_tx = SLOWAUTO_MODE;
>> +        max_pwr_info->info.gear_rx = UFS_PWM_G1;
>> +        max_pwr_info->info.gear_tx = UFS_PWM_G1;
>> +        max_pwr_info->info.lane_tx = 1;
>> +        max_pwr_info->info.lane_rx = 1;
>> +        max_pwr_info->info.hs_rate = 0;
>> +            return 0;
>> +    }
>> +
>> +    if (max_pwr_info->info.pwr_rx == SLOWAUTO_MODE ||
>> +        max_pwr_info->info.pwr_tx == SLOWAUTO_MODE)
>> +        return 0;
>> +
>> +    if (max_pwr_info->info.hs_rate == PA_HS_MODE_B)
>> +        rate = 1;
>> +
>> +    /* Select the rate */
>> +    ret = ufshcd_dme_set(hba, UIC_ARG_MIB(CBRATESEL), rate);
>> +    if (ret)
>> +        return ret;
>> +
>> +    ret = ufshcd_dme_set(hba, UIC_ARG_MIB(VS_MPHYCFGUPDT), 1);
>> +    if (ret)
>> +        return ret;
>> +
>> +    ret = ufs_versal2_phy_ratesel(hba, max_pwr_info->info.lane_tx, 1);
>> +    if (ret)
>> +        return ret;
>> +
>> +    ret = ufs_versal2_phy_ratesel(hba, max_pwr_info->info.lane_tx, 0);
>> +    if (ret)
>> +        return ret;
>> +
>> +    /* Remove rx_req override */
>> +    for (lane = 0; lane < max_pwr_info->info.lane_tx; lane++) {
>> +        ret = ufs_versal2_phy_reg_read(hba, RX_OVRD_IN_1(lane), &reg);
>> +        if (ret)
>> +            return ret;
>> +
>> +        reg &= ~MPHY_RX_OVRD_EN;
>> +        ret = ufs_versal2_phy_reg_write(hba, RX_OVRD_IN_1(lane), reg);
>> +        if (ret)
>> +            return ret;
>> +    }
>> +
>> +    if (max_pwr_info->info.lane_tx == UFS_LANE_2 &&
>> +        max_pwr_info->info.lane_rx == UFS_LANE_2)
>> +        ret = ufshcd_dme_configure_adapt(hba, max_pwr_info->info.gear_tx,
>> +                         PA_INITIAL_ADAPT);
>> +
>> +    return 0;
>> +}
>> +
>>   static struct ufs_hba_ops ufs_versal2_hba_ops = {
>>       .init = ufs_versal2_init,
>>       .link_startup_notify = ufs_versal2_link_startup_notify,
>>       .hce_enable_notify = ufs_versal2_hce_enable_notify,
>> +    .get_max_pwr_mode = ufs_get_max_pwr_mode,
>>   };
>>   static int ufs_versal2_probe(struct udevice *dev)
>> diff --git a/drivers/ufs/ufs.c b/drivers/ufs/ufs.c
>> index 91f6ad3bfef..57e6e8c013b 100644
>> --- a/drivers/ufs/ufs.c
>> +++ b/drivers/ufs/ufs.c
>> @@ -226,6 +226,21 @@ static int ufshcd_send_uic_cmd(struct ufs_hba *hba, 
>> struct uic_command *uic_cmd)
>>       return 0;
>>   }
>> +int ufshcd_dme_configure_adapt(struct ufs_hba *hba,
>> +                   int agreed_gear,
>> +                   int adapt_val)
>> +{
>> +    int ret;
>> +
>> +    if (agreed_gear < UFS_HS_G4)
>> +        adapt_val = PA_NO_ADAPT;
>> +
>> +    ret = ufshcd_dme_set(hba,
>> +                 UIC_ARG_MIB(PA_TXHSADAPTTYPE),
>> +                 adapt_val);
>> +    return ret;
>> +}
>> +
>>   /**
>>    * ufshcd_dme_set_attr - UIC command for DME_SET, DME_PEER_SET
>>    *
>> diff --git a/drivers/ufs/ufs.h b/drivers/ufs/ufs.h
>> index 53137fae3a8..0337ac5996b 100644
>> --- a/drivers/ufs/ufs.h
>> +++ b/drivers/ufs/ufs.h
>> @@ -428,6 +428,9 @@ enum uic_link_state {
>>   #define ATTR_SET_NOR    0    /* NORMAL */
>>   #define ATTR_SET_ST    1    /* STATIC */
>> +int ufshcd_dme_configure_adapt(struct ufs_hba *hba,
>> +                   int agreed_gear,
>> +                   int adapt_val);
>>   int ufshcd_dme_set_attr(struct ufs_hba *hba, u32 attr_sel,
>>               u8 attr_set, u32 mib_val, u8 peer);
>>   int ufshcd_dme_get_attr(struct ufs_hba *hba, u32 attr_sel,
>> diff --git a/drivers/ufs/ufshcd-dwc.h b/drivers/ufs/ufshcd-dwc.h
>> index fc1bcca8ccb..f7d27736f44 100644
>> --- a/drivers/ufs/ufshcd-dwc.h
>> +++ b/drivers/ufs/ufshcd-dwc.h
>> @@ -17,6 +17,7 @@
>>   #define CBREFCLKCTRL2        0x8132
>>   #define CBCRCTRL        0x811F
>>   #define CBC10DIRECTCONF2    0x810E
>> +#define CBRATESEL        0x8114
>>   #define CBCREGADDRLSB        0x8116
>>   #define CBCREGADDRMSB        0x8117
>>   #define CBCREGWRLSB        0x8118
>> @@ -32,6 +33,8 @@
>>   #define MRX_FSM_STATE        0xC1
>>   /* M-PHY registers */
>> +#define RX_OVRD_IN_1(n)        (0x3006 + ((n) * 0x100))
>> +#define RX_PCS_OUT(n)        (0x300F + ((n) * 0x100))
>>   #define FAST_FLAGS(n)        (0x401C + ((n) * 0x100))
>>   #define RX_AFE_ATT_IDAC(n)    (0x4000 + ((n) * 0x100))
>>   #define RX_AFE_CTLE_IDAC(n)    (0x4001 + ((n) * 0x100))
> 
> Looks good !
> 
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Neil: Are you going to pick it up or should I collect it?

Thanks,
Michal

