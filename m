Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2096FD2505A
	for <u-boot@archiver.kernel.org>; Mon, 12 Jan 2026 09:30:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8E26F83CBD;
	Mon, 12 Jan 2026 10:30:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="W1sWiH6f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E69B283D00; Mon, 12 Jan 2026 10:30:44 +0100 (CET)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 85D7383CB9
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 10:30:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XsC+7rKu6PZLqvuhOzcYlG48DkWLpM2mj/FJGA//jj3U+Xiuyk/HZ3z4wf4P/dFixaPsFydGsuJqXtRoMXnV/bEIwMPlwDORvc+vWHamqedEZwIhGLbWdgKEnOcPFNFyYl6phl+hHtUhu6ocevwhXKiaEoivmyBcVEjWU2QNlU3HOE5W1dom2m/qTNFCgKfA5CR4fPUHJGS2EahA1rCkVPxRdw+B+kzpQIAlTRDCPUuIwYO755yRqmrzTQYhbnWx2EOZz9HRpxyTZ/r622fMsNRYBgx0ErRlndGHSHjGxyh7KGhWE3HuqygzzwitOvYBhqkbzSGnIOW/TYi18TKBHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ArRq623mIwHz/rCGXGVIHfHDqQFyqrI5RFFGYndB07E=;
 b=c2uErsu/jOHAFoTlZSrU8dLZ+kjsiAnrLOrZFkZiLC6WjYtKCGGwWINo4p4FvnCl+hp5Q6EGSP56pgr8o4ks7GzesPYoDkniRPbEBjpkoVJkA/KD/OMFWT6UxkqOU4JVApPvHN9EyRU0mkEKHUsKTQ2LVHYey2fQN/Mfwe0ZcgHoJMt3riDss+UcEuzgZ7Up5tm032luDQ87tY0+Q8rW33rOyqDJRp9FKuImD9v1zGDMyH3xtVOjPk3CmvnqkQHiD9caX2sxtTX/itV/nCOanfkmI8BWIU7Qqpim0jJB1WRgGdUFqaSB+tkatnzyUwCrTEJgW7dlstvF1Hi1CnauUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ArRq623mIwHz/rCGXGVIHfHDqQFyqrI5RFFGYndB07E=;
 b=W1sWiH6fArNsMdCfxwn0dkhamJP4FxbJOt5m5cU1czGqFPJAGFm+qJos6gqMYUSLo5L9bne6BhrRxTJGfQps8k5K8GGZf2Y5IS/AESSa1icqiYz+C0dP9tOhaJBsI07CuQ9pvmWbtd4D+QReYnwW+kFbN8WVVJndgy67wkjK6UU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by PH0PR12MB8029.namprd12.prod.outlook.com (2603:10b6:510:26c::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 09:30:37 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.9499.005; Mon, 12 Jan 2026
 09:30:37 +0000
Message-ID: <35182375-579a-4077-bfa9-37ef68757f91@amd.com>
Date: Mon, 12 Jan 2026 10:30:33 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ufs: amd-versal2: Fix clock name with binding
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@amd.com
Cc: Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Neha Malcom Francis <n-francis@ti.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <eadc8d159b6d822077549722c9ec5a96a4d16c2a.1765973221.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <eadc8d159b6d822077549722c9ec5a96a4d16c2a.1765973221.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH7PR10CA0024.namprd10.prod.outlook.com
 (2603:10b6:510:23d::13) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|PH0PR12MB8029:EE_
X-MS-Office365-Filtering-Correlation-Id: ab0a63db-cc10-4637-2e15-08de51bd3e90
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UDV6SENsMHVhYVZIVHBJUmJINVJvbXFlVHNKZWtnb3YvZW00Z1I4NnV5T1lJ?=
 =?utf-8?B?OTdxMWxBNHhhaHM1RElzQUIzZHJQbzA5SnBWeE1ORHh2TzFTOWxlNElIYmRk?=
 =?utf-8?B?LzhEVFBCR2FaTkk3K1JoV0M5MjNlYWJBY1psd2Yxc3JwdVdOeEw1OTNldE9k?=
 =?utf-8?B?YmhtQlVSNU9vR0kwV3B6bVpiMEVQVzByNGI3VWloR3hKMEpKZU5KbUZPYTZu?=
 =?utf-8?B?R1I4amQwQVlFQTZnVjJYYmxEUGtjQ0JUVzUwQ0Y5SWQwSVBVaTRFTnJKSjFB?=
 =?utf-8?B?QUs1N1ZCZytCRS9FVkd2NENhZEt5NVVPeEt4cTRLUkRLSGk3aVFWV21FUEtv?=
 =?utf-8?B?bVRwbmVpdUdkWllKcDFLajZ3SXkrTmppNjFTNWlROVRWYWhTTEpxWXNYZCsz?=
 =?utf-8?B?K2JyYnp1RmVENWxkeW9ZM3RCZzFVaUdKa2lRSm42RUMrRFQ1WEI2bGttNWd0?=
 =?utf-8?B?dHpPVHRyVkU2SXlHbUVrdlFqd1U2azI3RjFKWjNSTW5JeTJLVTlOT1E3Y3Ux?=
 =?utf-8?B?SGhGR0RUU0YvWDhTVkNCdkJkVUZFdUsweHpZeVdsSjNHckhBT1VTeFhuRnZM?=
 =?utf-8?B?bm8rcEkvZEF3SzVYMmNYRUNBb21rckVXNXdId3kvV3NjV1BVOHNwdUM5aklV?=
 =?utf-8?B?cWNzbVRrMlI1clRKOU56WE82dm0rV0VSOGxOWlEzbmpQRzV2QVl3Z0w5U040?=
 =?utf-8?B?d3dzRVVoRkFDWFJOR2o5N3dNOFZCVElRc0d1bTRtZSszemthbjVNN0J1aUds?=
 =?utf-8?B?UkdaL3BRODBvN09XMm10L2ZVT280ckJXVUc3QWc5cEJTUkJqMTlLWTBHSmk1?=
 =?utf-8?B?ZjF2SnFkTzltVHhrR0dxNnVzMGNxU3g4TzBlM3lzak5VWXdvanU4dUowQVlZ?=
 =?utf-8?B?Y2k2dEdMNktwWTZaNHRCWmNqT3hDKzFaWWc5VDNJdlNtdGkrYnorbVdRSTRZ?=
 =?utf-8?B?SkEvaGt3R1A5ZVlUZ2ZrbHVqSnFiZ1puMUFXVmtnNTkyaGIrOFFiVit1aXo2?=
 =?utf-8?B?QURRWTI5cll0NDlKenhkMTgrb1BaS0xNaVFUVlg2aGJPN0FVTkFqZGl5dGky?=
 =?utf-8?B?c0JiK3ZKcGIzanphNEk5SUkrZjBhNlRKQUp6dDVOazZGVkNwSmo3VkUrOWpx?=
 =?utf-8?B?VVV4MmpNdUIvMTBsNzVNVnNqNllRNnNWTzRxOStjMjZId0lSU1IzRzVIbEdz?=
 =?utf-8?B?STBQcUp0TlZKUnIwakxmRzh1WVRwTlRlWTRKNDh6RFFxUkdTTTB5Vmp1b1FD?=
 =?utf-8?B?Q24vVDh4dS9TWG5reWx5ekJMZUVHRG1hOUxGVTRUdjJtdWs0ZEM1NnJqSHBE?=
 =?utf-8?B?eEFKVDVvM21sZHFRQ3pQc1cyNkc2Ly9iUGlVL29id3ZPVDZQMHB5QVluSkFJ?=
 =?utf-8?B?bVdZYWJvZ2dCM0JxTGJ5RkNIN0hvRm4wWk5STWkvWXo5YzlYY05oelVYYXlJ?=
 =?utf-8?B?QkJIK0h5WmEzbWhKSEJRMzl4YUZoS2xQZ0Z2alhTV0l6RUhhLzhyb3VNNXQ0?=
 =?utf-8?B?UjdPRmF6MEZKSVB3Y1ZJc0ZSRmpVdm9iVWg0eHhpcnFOd21KWDY4NkU4N3hN?=
 =?utf-8?B?dDh3UCttQzErQmFlUlRkTGFQdlgwUERnaDVialNCZlh1ZE5remNjKyszZHV3?=
 =?utf-8?B?czZZcWRoUEJpV3p4c1FrTGJJeTVHd0wvV2xTaWFJSzREclpXbFd3dlhuUmx6?=
 =?utf-8?B?Vm43NGVNZWFuYXByR1J1cjNRcE9wRkpGaDRQN0c5a2UxeXFwODJHSVFxVld3?=
 =?utf-8?B?L0NlSS9sU1ZXUFUwVE1rY2xDclMycmVTOUtvODNWTGMzbHh2dTlNQUp5eXEy?=
 =?utf-8?B?Mmw1V2JLVlZzQWdrOTI5cDVKVDRJRkpCSWVTRDM5Zy9xSWx5UXhrQ0lvU2g2?=
 =?utf-8?B?ekNwV3E2d3ZOZFF3SVprV3dZRzRqUExXMHFFR3BxU1VQZWc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RlJLdjRscmlzOTR2VDd2d1JLTmtFSlh2NytSR1BYek13aFJSU3A0T3FtQWtp?=
 =?utf-8?B?YWgxUnJTUFRVY0xKL1pQOWFkOTZzYS9uc1FuUWxuZ0lyYldiZStidGNMZU5D?=
 =?utf-8?B?ZTQ0NGdBUFNSM1g5SnVCS1pVSTg0cGNsaVRzeDJ5OGVsS0ZTeWtTUmFyQmQ0?=
 =?utf-8?B?c0xNQmcvTlRDa3MzTGlDYUx0MEwvcGRUSEdaeStmVkw1MXRaVXFRZFlick9T?=
 =?utf-8?B?T2NsaVRVNVp1ZjJUVWJ1VUJ1SGxRZDNMNk9ibExhL1JIZmg2amxJTkp0a3hX?=
 =?utf-8?B?UGdvclJTUDdJS0c0RVBsZWR4cUhjN1o3MitkckRVeG1XeU5WN1ZmM3dUQ3Ew?=
 =?utf-8?B?NTVLR2pYRWlvczJoLzdWclVYdHAvZmxJc2o2bFhhd0pVTzZMTXJqWjJTT0Mx?=
 =?utf-8?B?SXlZckJrZTJUUnJhRURLV1ovb0h0Y0pENlJTa0x3VS82VXFDOUtwNVY3Zkgz?=
 =?utf-8?B?ekJLRHhIUmFoQ3RMdWF6NjgzcFVmUEtGSmZNQ0hnbDYza3F4OUc5K21JWnpy?=
 =?utf-8?B?ZXF3T2daRmZ4eHdvMnpXUFJJU2lTaEpER3NNdlF6NmxTTFRNU1d4T1Y1cG90?=
 =?utf-8?B?TW9zeWZBSXJvYk80WjJOcnFlcGx2SnMrMmI3dUU1eUpGMlplUVRGbTEwRyt0?=
 =?utf-8?B?eXo5ZktGOXV2YnZ5SFB2WWRTZXJuNWNCV01jQmdFVVpZSFJVTXc4QkxYY1Bv?=
 =?utf-8?B?eXhaZkhuYkYxc0VicGVYTFlsMFdSTVp5MHdocXMwTUtvWHV1NE1FQWs5ZWJ4?=
 =?utf-8?B?L2FLU1p5UHFsRGRUQ1JmR3BvaktsdHVqL2hCR0JrSDhjZElERTZIZmkzVDhT?=
 =?utf-8?B?NVhveHkvMll5V0xGKzh2Q1VxbXlidStlNGE3SHJ3MEJsR0NHa1JRcDU2Y0Nz?=
 =?utf-8?B?N3RHZlh2TUhZcHkzVEI0SFNwQ0VRdHB0UWMxRzFjY2V1VTRYY0h6TzNXNmVn?=
 =?utf-8?B?STJaZU9lUFRNb0Z1Zk1rQjRvVnZLazZjK0t6NXFjY01sZmJXaTdtczFVbWJP?=
 =?utf-8?B?WEFvcHloZ2lHdG9vVUZSTlFGeVRRUUJQUU5ycERSTThDZ3NTZ3N5anJURDVq?=
 =?utf-8?B?bWFVN05tQ1RMRCsxVklTMzcrNTYzTEFqWE9iREJiMDBLVG9mQ3RmRmVDUkov?=
 =?utf-8?B?b3cvaVpRSHZBOTlNOTRIaWxCZXlNUHpsZGdiSWFwS1hPSXBscGNrbXo2RnFn?=
 =?utf-8?B?Zzk0MklBcTJTTVkyRzA1bjRuc1ByR0h0N2RzV2pZSVE3b01DNnhFRzhJNldH?=
 =?utf-8?B?ZmdRbnlnL0RicEFYMlJuOW1ITDlSYnpocG9GQ3pTdVUwZjJ2TWNaS2lsUm5V?=
 =?utf-8?B?NFNtNDBTVkVod1dHTkRCanBKZnVSTkFsc2MwVnBNR2VRZzROUEQ1RHNCeVRy?=
 =?utf-8?B?V2dxdmsxRFNBYVZzS3lEbS9rcGIrQW5IaFpOTkhkUFVsVE9UeUwxdW9VQmZk?=
 =?utf-8?B?SUcreEE4TGZXWldweEx5aE9zckIzRHZBZ0twZVJudis4bTEwS2VyMzdsN09x?=
 =?utf-8?B?bW5OcmV0M1I1VElSbitjN2N1OUgrdW1vSjRBMmwyZ2htQ1FrKyswRW44UXVB?=
 =?utf-8?B?N3ZJbVcxVmtkc0tCc2ZpYVpXR3JGVUJzUVhLUUg3VzJvYU1ZSGFiSzBiUmR4?=
 =?utf-8?B?dkpwblQxQ2ExK1k3VG5pUWkyeFNFOHN1RlVzeHZ5TnJ5TDRqaXNacFZITjlY?=
 =?utf-8?B?WU9vVmNoMWxXRmM5bE9SeVltUTBMQmpWSjZwNi9melJCR011K2FFMmhaTDNC?=
 =?utf-8?B?dWd3K1lhbmZCQXBUMXBzTVZ2NHFReWFpV3JTZHRFTnA5ay9rbnFQM1hoTlZk?=
 =?utf-8?B?ZzdsWGlnZjdjRFFlZUcxK2E0V1NLK08ybE95U1NlRjNNS0tETEtyTCtvSTVn?=
 =?utf-8?B?d3h3eU91dEVFRmxKR0xMVE5PQnBPNytWTVpiTTk2ZzhLN3hYTEZyMUVoL1BL?=
 =?utf-8?B?bGIzMEkxY20yU091SmNJRVpOYXlYaVVndlpYc042czNqNi9pcTlsUnd2eGJk?=
 =?utf-8?B?b1U3TWo3UDVTemtYR3h6ekxxSGQvKzlPZU9FcWY5ZzhuMXhZYWY0VTRXODBs?=
 =?utf-8?B?RE45VHl0RUxnMzg2SlgzNWNFRHhEMEVqOEFyblFNT01TWndqT2xkUHhQTjJE?=
 =?utf-8?B?dGRhYXNvUWxMRzYyT2hnZEpnRThKeHRjRk90Q0grZFRvd0lVektjQ0p5d3BH?=
 =?utf-8?B?N2szZGRrRGVFVXJkbTdQY2oxb1JOelB0UGZzaFVLYmsxdWxWVkRIczIvR3Za?=
 =?utf-8?B?cWZuYVZpRjF3MTZXZ0tqcUNGZ1VxNDRsYldsTmt2a3FqWEgxVDkvc0RSUEFk?=
 =?utf-8?B?TEdPdXBlUkVFZGdVR2trWEJJTnl5SUQ4eTZYeWxEZCtDOFhOVTd1QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab0a63db-cc10-4637-2e15-08de51bd3e90
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 09:30:37.4805 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ld4VR1OyNJCT6CeNuv0WjZ9iIl0whP5c5u0aEejdN425Y0PXAGws/JGOEl9zMvNN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8029
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



On 12/17/25 13:07, Michal Simek wrote:
> Align clockt name with DT binding.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
> Binding is available here:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/ufs/amd,versal2-ufs.yaml?h=v6.19-rc1
> ---
>   drivers/ufs/ufs-amd-versal2.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ufs/ufs-amd-versal2.c b/drivers/ufs/ufs-amd-versal2.c
> index 97de0756f70a..dd62c9819ba1 100644
> --- a/drivers/ufs/ufs-amd-versal2.c
> +++ b/drivers/ufs/ufs-amd-versal2.c
> @@ -305,7 +305,7 @@ static int ufs_versal2_init(struct ufs_hba *hba)
>   
>   	priv->phy_mode = UFSHCD_DWC_PHY_MODE_ROM;
>   
> -	ret = clk_get_by_name(hba->dev, "core_clk", &clk);
> +	ret = clk_get_by_name(hba->dev, "core", &clk);
>   	if (ret) {
>   		dev_err(hba->dev, "failed to get core_clk clock\n");
>   		return ret;


I can't see it applied that's why I will take it via my tree.

Applied.
M
