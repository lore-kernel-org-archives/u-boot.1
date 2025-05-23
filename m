Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA09FC54ED0
	for <u-boot@archiver.kernel.org>; Fri, 23 May 2025 06:43:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3D8D831C2;
	Fri, 23 May 2025 08:43:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hDJ4n6VK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E41D0831C3; Fri, 23 May 2025 08:43:30 +0200 (CEST)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on20607.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:240a::607])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 28DF98310F
 for <u-boot@lists.denx.de>; Fri, 23 May 2025 08:43:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KHFAeY+1ZfoSq1PkfR3Iy7V9MAFW2rGimaLudOTfdmzfIA903GOAJFpB6p8DL2iascKngrbafuylxF7bkvT8v0ihF/fMFvG2563B2vqyhK63OsPXmkfe4RyCNmh8MgVOP/xG2ApdUU+d7dzMSWIMuvZ6Y3eaHptL1gsIQV4O++gk/VTByG2JwOOAPrM1WgJemDnCA0K45WlVgHjaUP8Tc5XEQ1yj2ASBt4kC1C35sti1xsGGnKwVRo1kOSXY8fXKO27Yd9zzpvfHzNjRkG6zh4itPiptK5s98FROug3m99XOfErrQBZYrxBmtL/QJdnv6mxglrL9M/4ZIC2syiEN2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M6lmiQ0qTGar2ZXkqo5jPDm5kqBnG5EOdHBfgO5zYpI=;
 b=C7MM73sC2kACLHaO7OLdbAuvZXuR4L1/+U6iEP0KceYPihyMkKJwfcDhKhopXyMxK1SSU1jS4OjaZNArF4vjDx2zDf/D3zpy3nHShiuIm4PApEjA3OG/mWd/OKj7QIh2AzLzYRmsJqmWoyQPKYme87FTCi+zk50ouF2tPHSfB3ydfi++tJH+H9GL9MWSjMhTW/dQ7uIFALMD6LaNUiruA+M/OTBUf9IeflRP7ROoZ02fujA2cpzO4f5L5fhxtj6hCla6KT4POUmQgZ/Kh7v298RKyPUAMA1lzyWpEvksWMUylvmSX7sL5jqGdgH5n/jjIGRrS9fdrYuBMhIiQCK/Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M6lmiQ0qTGar2ZXkqo5jPDm5kqBnG5EOdHBfgO5zYpI=;
 b=hDJ4n6VK6UiIyt7do0tae62N7ceO/Q7fkiYX4qKxyp16NfgGxN3JjeewCWYIbPjdwXXIwZu5PVYQpOU17IvLsZBTEdou+Vh3cgavpKrT8RNzIZFy5WKVoGSDf+mP+/QlHupnZLk+VtKA4cYo+3VGcsWfAB2pdS2aYrYqLCxdjOU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by DS2PR12MB9688.namprd12.prod.outlook.com (2603:10b6:8:27d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.22; Fri, 23 May
 2025 06:43:25 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%7]) with mapi id 15.20.8769.019; Fri, 23 May 2025
 06:43:25 +0000
Message-ID: <7f5d4d2a-6a1d-44d7-a7e0-d828649bf846@amd.com>
Date: Fri, 23 May 2025 08:43:22 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] phy: zynqmp: Fix sgmii clk ctrl GTR lane bit shift
To: Frantisek Bohacek <rutherther@ditigal.xyz>, u-boot@lists.denx.de
References: <20250522060703.4863-1-rutherther@ditigal.xyz>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20250522060703.4863-1-rutherther@ditigal.xyz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0166.namprd03.prod.outlook.com
 (2603:10b6:a03:338::21) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|DS2PR12MB9688:EE_
X-MS-Office365-Filtering-Correlation-Id: 97296965-c3e9-457a-0a32-08dd99c51e12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QTdqek1Kczg1Y0hLVFZJTmtobkZ4WXlUUU5DRjhNb09WUkJFUC84VVBNdlh5?=
 =?utf-8?B?K3ZmUWFDVFhMb2N6OTBIVDJUejVyWkg1empJb2xGOFMvMkgybjdZZXFYNWxL?=
 =?utf-8?B?NFI3ODlXSDdONnhKWDJ5dFBOajNtT0JKSW40QUVHbVQwT1V4R0IxakJXYW9K?=
 =?utf-8?B?anRtTmFrV1FsdkMvcHVwdzhvYnhhVlBWN0hoWmE2ZFlsVTF1OHJjaERjTFU0?=
 =?utf-8?B?MWVrN2hTQnJmN0E2NUJaT3RuZkVFM2tjVDU1NFpGcEgyUEF3M0hzSW5oaGEw?=
 =?utf-8?B?cjdUOC82dlo1S1l4NlNJZk5mWG44SENzcUZlb1JRTTZqQXVYU2VGQlJxQWt1?=
 =?utf-8?B?L05tRWFmZ3J4Z3c2V1dKSlpsSXFkZVdlMzFPNWtyWUpycnRiUWtZcnR3OVhB?=
 =?utf-8?B?d3pCWTlJemFMTXVGZDd1emR5bm9OS0xLU1JwL0d2dlRZbytONHAwelFMUnJL?=
 =?utf-8?B?M0FiUDFDT21oRXNRTG52VHYwU0xQdmFhL1gwU00yVWQvR2RqZkg0Z0hYenZL?=
 =?utf-8?B?R0c3TWdFQjJ4d1hpNmRGd25kalRTNnZncUwzaHdyWGpaQUpzWHZRTk9mQk1K?=
 =?utf-8?B?SzJuc1hkVVJodTV1RjN1dmo2Rk4vSG5NeGFXaHEwWHJsQXhXYldlVnVQZW44?=
 =?utf-8?B?TFUwSVh3dmFjb0lIalNmTU8zdjBSNFc4Y2ZXcXpZTE01b2JNaitlYS9qbGpD?=
 =?utf-8?B?MFl6N0l0TFU4aDRZSDdPazJXRmVWdlpLa29kaktDOU9ua1VyanJ0YU5NM2xZ?=
 =?utf-8?B?azc2M1FsYVV1WVZWNG1YKzlvaWhlUXJjMTRWQXJxby9rekdyYUF4dzRGRWlU?=
 =?utf-8?B?RVliWUdlQUxQQXI1TUxKQURrSmJaUXlYNEZwT05rdUN1VkZ3cG5VZHRvOEx3?=
 =?utf-8?B?Rk4xbks3eGpLZnNwbEo2Tm1qU1hmSm5lMXpDU0R3cDZTamlMUFdqRm5zWk8w?=
 =?utf-8?B?TUtGWXJVdWhxbURzM1craEFORkZ1bGRlY3YreXpFV28xVDhSZ1NTcUg0T0dV?=
 =?utf-8?B?NjBNcEtZNFdBUlBjRzh1YVRKbHljWWQ5aEdjOFBqZzJTYTRST1EvY01ncjNZ?=
 =?utf-8?B?K0ZHemFBTitJTDFYMnBmUElweFZ1LytNQlRQWWFMRlJPQ1lKVytSY3MyM3l5?=
 =?utf-8?B?dEw1MjdMYUJqZlpXTGFSZEE5R1NwajdDZFJuR0N6V29YOUtENUZOUkRjWXJK?=
 =?utf-8?B?b3hKQnRaSnNBblRWTDFvSGV2RXZ1MVNUaEVwLzNkMHc0WUFlYlVkNFNDNmQy?=
 =?utf-8?B?UzlRZWRJZUVKQzBlNVdIcmF1dFM2bHhpdFNMNEFXcDh6RGxGVlgyakpJZXlQ?=
 =?utf-8?B?MHIwWm5nY2ZadXd0VDNDWi8yeU85OW1zL2UwaTRpbFdWOUxYZktIYVhhZ2ww?=
 =?utf-8?B?NTZrZUpGZm5VVFZPRFRvVjZjVHpxTkE4azFwZUpxMXRPZ2VSZEIxSUdmNDda?=
 =?utf-8?B?U05hVi9EOHowalVZQlVyVGF6NENKdTNFTFJqU2IzUllQMnBoczhpUHJWYldN?=
 =?utf-8?B?YXR1djRBUFR4c2drcWl0SGJER1pIZjhFVU9TL0swMTNXc3NpMVpjSEdnRjk1?=
 =?utf-8?B?NXlNcGMrOVI3VVNpcWpqOW82d0lGYWhyVUZDaHdpQitUYkl5NVduNHE5UTBa?=
 =?utf-8?B?bWJhbnFOa2RjZEJnNi9McDFETVo0YTlLVDdlM1F0UjhIS05wa1NwNkErNVdL?=
 =?utf-8?B?M1V6eFFTVFdyUXUweUVMME81dEtCNzFLTVJsOFNpTUMzUUtlSW9GbTFOWnZr?=
 =?utf-8?B?ZXFvK0VlSjlZL3ZsaFlDTEZBTnpLOUZHVHlFM2NtQ3NlMExtYUpMT0oyYzAy?=
 =?utf-8?B?WUNiVXFvaHJLbVJ4RXB2b0twajR5SFcxN3dxVUNQWThYR3pnRHgxWHVnRHBp?=
 =?utf-8?B?dDZkOHd4YXA3YmJZd1l4ZzlvSW8yeW45dTJac0paNGxIT1VRNkJuSUw4Y0oz?=
 =?utf-8?Q?kEAVWdorbaA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QThRRDBCS3E3WGtFNkNvSlVlNS92dVVKUk9kWTNRUGpxVFR5VmVFSThMd05h?=
 =?utf-8?B?UGxDK2EwVC9IUlRPWG1HNEhEREgvczlHdzFBbGdTZUdNNmNhZElBbXRyWGlC?=
 =?utf-8?B?UGlkOS9KTmwwY3pSU3hSeUlIbjVTOUN1ZC9jZUZYWjBsZUU4ZG5YYTRhK1pL?=
 =?utf-8?B?eklCQUR3Tm93cDRZVVJOaDExNVN6angralBoVlhrWWNyR0xKRENFU2ZNUy9K?=
 =?utf-8?B?NlNvMDRYK09QYXpZUHp6L0llQyt5QlFPUklsakFlOWQ4MlQ4ajFkR0lHWDR2?=
 =?utf-8?B?Skp6WUl2Q2MxbmpURFFmMWRkUzg4MGxBMXc1WlpZaDh1ZFE4cjBaVHdsZStY?=
 =?utf-8?B?WVlVR0FzaWsrR1pCK0E3QmVEOVU2YURWM0thZ004clBvTTRzcXhka0tJb2hV?=
 =?utf-8?B?bndIOVpuM1lWNHZDcTdOMzVGVFVKMjA5Sjc1dCtPeXhaT2pJbDVzaC80Zlk4?=
 =?utf-8?B?T29MWG1jOGFlRGdjRDBoWExJZVdLbWZDdENmWWNMMTM0dzBmWlg1SVJkUUNq?=
 =?utf-8?B?M050Q1ZDWFZtNGVQLzY2VGorbmkrdFJZTisyWTVwejM0ajJJcEFaVVZMTTBn?=
 =?utf-8?B?ZnA1NEpCdzFGS2JnbDAzUFFHTE1wOG8vLzVQM2I3SGVsVHd5VmJ6QXdmUkNB?=
 =?utf-8?B?dVdvOXRSRHVSaiswMXVPSTJpeVpuYUp3QXNCeGg4NjhoYzBHSHJNOTZQR1Jm?=
 =?utf-8?B?WG1kVmdwMWZxTS84czJrUUhrU0VidlAzS3hXUU1lWHlXSksrb0E3NGt0WnZ0?=
 =?utf-8?B?SlRGOFllOXkyM2lKQWVWKzliVmVmMHl5ZytmdjZyMUtJL0Nya2NUUjdHUHBF?=
 =?utf-8?B?bmlZMVJNUFlQL3J4L29KL1ptcW5za3FkaUNKR2VIMTlpKzlrZmpvVFMxR0NY?=
 =?utf-8?B?YThIazFXVnZVU0JQVHV3azBIOC9TQklNSkdBQzJsVTErVGZ1Q1VQMnNzbXpD?=
 =?utf-8?B?TVB0YW85NEdzeDVRRytOdjVMRFVsNWFVMkNPenc0NFRGVGRGdzVXdkx4SGZL?=
 =?utf-8?B?WlFJMHJkY2tLRHpKaDhDR01ZdzZjMkc5WG5DRGhDckhnbkNKZU5pTFUxczhR?=
 =?utf-8?B?cG15MXFEWGhsMGEyZ3k4dE9oaEJWYmt2Z2FQYWhHaTNqWHYvMkNpWE8xVEpS?=
 =?utf-8?B?TmtMdlUyeEFrOVZsVmhzYy9sd0NjRVJ2RE1tT1dwWWJWR2VnalE5TkdWTVc0?=
 =?utf-8?B?cGV3akcvZytQZ3RBS3F3Mk9RWm9PSlJROWhqVGNLSlQzdGpUTTJQamlQZ0VF?=
 =?utf-8?B?cWxGRi92R2dCNWZBOFJKMFJhb0ZDNjlnUGJWZHY2UU03L2xFL3VQL1N2KzQw?=
 =?utf-8?B?YkJSN3JiZ25KWFl4Vjhmb0daemtRM2FnREVxUWkrV3ZZUk5ndVN4bG1GdzN3?=
 =?utf-8?B?Z3B4QnNtZEkrOVRDNmNkYm1Wb3VvdUhQcTdzdWxlNlQ5QkM3UnVaTkZiaFZI?=
 =?utf-8?B?VFZha0p5aWFxNjBVQ09lbExNeFdtM0QzK3FvTUgwb3BBYmJRb3Y2WlhxVW90?=
 =?utf-8?B?MlN6Ykx0TkhwdFkvNzV2WjJyN0p3ZWZRVTJGUzhOd0owMkM5M1QyK1RMUnZq?=
 =?utf-8?B?SGM3KzdDUlRiRDZxZFhzVHNmOXorRjlmK3JkYlhOakc4bkluRjRVcHBCaUUy?=
 =?utf-8?B?TjBreTJSRHFEMjFVNFR3bzdRR3hBc3BlNlVVaHFGRFpiVjQ4bjY3MGQ2TUY1?=
 =?utf-8?B?R0F2dnpDc0wrM2pBcjdmRlEzam13Y0c1WUlHclFXNjhiMXFCdE5vMVl3T3c5?=
 =?utf-8?B?ZG5VSW1TbHNTUkdyMXpscXcxVk5GY0NwSndYOTZmM0RTNUc5STJRb2ZBbmxF?=
 =?utf-8?B?THc5WWJtbFJhTC8wUU1jRVdyN1E3cG43ang3WFRzQTJySExRcG9QSzRHZ29t?=
 =?utf-8?B?WmFXSi9NNEpqbmtrVGg4VEZjeDB0SWluZ3RRd0Q0Tnl4dHUvR2xRa1dmcUQw?=
 =?utf-8?B?WHp1L3pUOXp4emJtc2tzM05JdHJvREQrUERtSkgzckRKSmtkNm1halpLSWlC?=
 =?utf-8?B?VElQT3VIcGkzdjM2QkRjQ3ZiSnQ3OEhYOE5ySU1BY3BJZVVGVERaRkJaTDY0?=
 =?utf-8?B?eUphY1pEUURieXpNM1VYNmFVYmZOZUY0UWJTdUNTUGRKZld5Z0lkcWFoREhw?=
 =?utf-8?Q?Zn1ouVEN/z2OghbuB3fdPslat?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97296965-c3e9-457a-0a32-08dd99c51e12
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2025 06:43:24.9666 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jhWECi/7HOAmWzrZVZvfh8EsBF5+ngdVhCkWjHZqsEoJDyfGENJzZV21NcdQ6eyy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9688
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



On 5/22/25 08:07, Frantisek Bohacek wrote:
> The bitshift in GEM_CLK_CTRL register is five bits, not two. There are
> four bits for each GEM, and one bit reserved in between.
> 
> This has caused that using more than one GEM is impossible,
> additionally corrupting the GEM0's configuration, leaving GEM0
> unusable as well (ie. if GEM0 and GEM1 are used, GEM1 configuration is
> going to write to GEM0's registers wrong value, leaving GEM0 unusable)
> 
> Signed-off-by: Frantisek Bohacek <rutherther@ditigal.xyz>
> ---
>   drivers/phy/phy-zynqmp.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/phy/phy-zynqmp.c b/drivers/phy/phy-zynqmp.c
> index 7049e740d56..9649e660220 100644
> --- a/drivers/phy/phy-zynqmp.c
> +++ b/drivers/phy/phy-zynqmp.c
> @@ -138,6 +138,7 @@
>   #define PROT_BUS_WIDTH_40		0x2
>   #define PROT_BUS_WIDTH_MASK		0x3
>   #define PROT_BUS_WIDTH_SHIFT		2
> +#define GEM_CLK_CTRL_WIDTH_SHIFT	5
> 
>   /* Number of GT lanes */
>   #define NUM_LANES			4
> @@ -400,6 +401,7 @@ static void xpsgtr_phy_init_sgmii(struct xpsgtr_phy *gtr_phy)
>   {
>   	struct xpsgtr_dev *gtr_dev = gtr_phy->dev;
>   	u32 shift = gtr_phy->lane * PROT_BUS_WIDTH_SHIFT;
> +	u32 clk_ctrl_shift = gtr_phy->lane * GEM_CLK_CTRL_WIDTH_SHIFT;
> 
>   	/* Set SGMII protocol TX and RX bus width to 10 bits. */
>   	xpsgtr_clr_set(gtr_dev, TX_PROT_BUS_WIDTH, PROT_BUS_WIDTH_MASK << shift,
> @@ -417,9 +419,9 @@ static void xpsgtr_phy_init_sgmii(struct xpsgtr_phy *gtr_phy)
>   	 */
>   	/* GEM I/O Clock Control */
>   	clrsetbits_le32(ZYNQMP_IOU_SLCR_BASEADDR + IOU_SLCR_GEM_CLK_CTRL,
> -			0xf << shift,
> +			0xf << clk_ctrl_shift,
>   			(GEM_CTRL_GEM_SGMII_MODE | GEM_CTRL_GEM_REF_SRC_SEL) <<
> -			shift);
> +			clk_ctrl_shift);
> 
>   	/* Setup signal detect */
>   	clrsetbits_le32(ZYNQMP_IOU_SLCR_BASEADDR + IOU_SLCR_GEM_CTRL,
> --
> 2.49.0

Applied.
M
