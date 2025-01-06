Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2447CE77188
	for <u-boot@archiver.kernel.org>; Mon,  6 Jan 2025 08:23:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F328801DE;
	Mon,  6 Jan 2025 09:23:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IbnvfFSa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45C74801E8; Mon,  6 Jan 2025 09:23:39 +0100 (CET)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2062e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::62e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5059580137
 for <u-boot@lists.denx.de>; Mon,  6 Jan 2025 09:23:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TCyJydMxmGdQ6zg5/YAW1m2f10CiRh0nA/Apf96T1iTFKeiOWp2hC1xoMhPeQzqR/0GsnINFN2buOsWr8rQkNyaJiQtKbsPBNsTjj24/7YGE721N+3AYZkYiNBBoIIISCemkbA2jQY/oi9vdQejpDesncqppLnkpmm8ieXJlWp3rWsyTP0p1/vNcCDNSCOHLIQ4zUgJWxZfpaJHXs7U88XIGTHhGXsXzK0sxkQVtc2CmF4DpVJ9EyBJm6WEn94mVeluioV+8rQJwd+ApVK94FZKm/5fupDxzLQrtC840kZC8AuQU1OdYpK7QyVSZefKBCV4jdCB1R3ltQY+/vvnJdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HblJ2nwW0HnkfBkvyHV00g/IanPX349QnNUsTuZpjcM=;
 b=hcsHA9+0WRuWoOQ3veRm1qHNVT/lwu/A1jxPj7PhzTxAl8B3mTbhYNTbXsGXjeBvB2jjYTgiz1gG7hLtORn1Hcd1pULwqepMRIXuxGFDOEPQoJlibLuRSTdAoSFYOegYrP09xReUEXdp9xcRMRyG2mBIryf4CMqgaVxD3CB9nJCFvSjbODj0jPqQGfMq+24gk0h2pRkCJP3VJm6M8hkc2fKXT2/iJwpqdjDOtUf5l5P9gCWNueB/xam742rLHjo7degyAjMeMhM/8fR/6h0+9GaE+flJxw+z/UVLwng7mptJdmQ7DXkuE8dHRAcEg8gz1KJY70b3AH7ztpdDmIc/KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HblJ2nwW0HnkfBkvyHV00g/IanPX349QnNUsTuZpjcM=;
 b=IbnvfFSa+kkTTWaqciL+fhfneNsCMcsCgTYrZlCGI20KoSg7qQ7yDbn15oeVn9Sc0jQJxtC6iAFMrUrN3p81wC+/y+pfLdOnGvFmDKy1BviXKNJUwhCvPD5h8VJTkv+CwomSLARGZSCyUDpgxgk5w1msxIM8Ux+4NkDvADbsWik=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by CH3PR12MB8211.namprd12.prod.outlook.com (2603:10b6:610:125::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Mon, 6 Jan
 2025 08:23:28 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%3]) with mapi id 15.20.8314.015; Mon, 6 Jan 2025
 08:23:28 +0000
Message-ID: <b5f2825c-5c97-41c3-ad45-19e8e35ffd0e@amd.com>
Date: Mon, 6 Jan 2025 09:23:17 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] zynqmp: Remove usb init initialization for Kria
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@xilinx.com
Cc: Love Kumar <love.kumar@amd.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 John Vicky Vykuntapu <johnvicky.vykuntapu@amd.com>,
 Shubhangi Shrikrushna Mahalle <shubhangi.shrikrushna-mahalle@amd.com>,
 Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <96e9c80aeeed4e9664858bf236476997d17a9914.1734522042.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <96e9c80aeeed4e9664858bf236476997d17a9914.1734522042.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0102CA0106.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::47) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|CH3PR12MB8211:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c702da0-6ea8-4173-df65-08dd2e2b65f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aEQybjNFQ0QrWkdXdDJkN2FuTXhNWGVQVzhyVW9xVE5CZ2xkRUFYN1oyWVVm?=
 =?utf-8?B?d0tMNWJzeFJldmNYUDB2THpidFBsZWg4Wk1Nb291bm5wbjdDUitKS2wvSDJR?=
 =?utf-8?B?cW1pb1dCTzFCd2t2Nmo4Sy9qcGdhWnE5TFFlSmZObW0ramtZbGZEb2lEN25G?=
 =?utf-8?B?WTBrV05ZQWZVa3hlTGs0WVczZEl6aUxjRm02TDh3dEdDTDJtUmhXYWFOaUF3?=
 =?utf-8?B?c0Z5bEdrT1FaamRtVXpqbG93emlJemRJNEc5dDRWUTZuM3ZPa0pQbnlaaGti?=
 =?utf-8?B?dXgzZzJMc004RXRnNXNnOURCTUtDWWpveW1XeEIzYVpRRlJmaGxBalhKbnNH?=
 =?utf-8?B?cGtNSFN5TDdxVFBTWmdUMys5S0Qzbit1SXRGMGpTMHZWSk5ONi9yNit2eXBy?=
 =?utf-8?B?N0QreTUyNWVpSlIxWUNBTEJSMXVsdWtzaWN5cEd3ZFduSVZqNXdJZnJFSFRT?=
 =?utf-8?B?djJkWEE3T0N0b0RYSCtxdy8wYzVlUjFVd2c4TndkenNpajk0OW1xU09tajdS?=
 =?utf-8?B?VTR0V3R4MGZUVlFsTE1LUkIwZWtVdXBoMUxOdGNnSmVRNWhLcER5SFJGb0ln?=
 =?utf-8?B?cEF0YnlMd2hPNW5FYW4yNDZ4THVEYU1PdVRlN2Y1TktNUVpWS0owT0tiQWZ6?=
 =?utf-8?B?MnVjM1pNL2pZSGgzbFFzaG42bXR4WkhMclRaM1R1TmZDaUlQNnFScUZKUjR0?=
 =?utf-8?B?YVBsZmJCNHFNVDRaNW1FbTA3UEUxaFB1K21JcG85b2Y5TVBZYjQvSy9TMSsy?=
 =?utf-8?B?WGFOUU5mcWFxWUg5RElCT0FRZTdlbFNKTHBiSE1DZ1lSdTBFNFlRRENlb0k4?=
 =?utf-8?B?aEg5SHY4TDY2czl0TCtzRUk4MndYMHNja21wWUtHZW1QRExCQUYyRFduNThH?=
 =?utf-8?B?UHo1ZC8ydVVqUUlWNXlseFFNZEpISDc5YjdkMWRDRWp2bWFGMHlUcVA1bThV?=
 =?utf-8?B?QUZNT2hMeFFFU0cyM2pZUDhtNDJHQllTS3ZudDNuOXczZTlQeEJiY1NsYldt?=
 =?utf-8?B?dU9GQS9kUVpWTG9vYUZhdWpWVTQxNXpXb3hSZzZvTE11TEhhMTlKaDc3aE9Z?=
 =?utf-8?B?RDMrOFZKTnlMY3REamRENi9GZlIxVGlVM2dlTk1yYTl6M2ROeE56bWd0cUpp?=
 =?utf-8?B?aklRMTd2VWNDOFQrbnpoOFoxNnJiMEdQSDVpWGNpR1JZK3JJNStKdUloTHRq?=
 =?utf-8?B?b05Kc1p5KzNCb0tNSHl6OHVodWFRQWs1ZTgzZVQ3clA0cTB4aC9xQnpvc2E0?=
 =?utf-8?B?WDVLL3cxYzZhcjYyQkNKUklGaTYxS3oxNVJZd0dwRHRETVl3Qlg2ODVJejVI?=
 =?utf-8?B?U1FTQ1BTd3E4ckhCN05QL1p0SzVoTEFNT0tDNlBPZzFUc0Z3WWcyQlMwY0I0?=
 =?utf-8?B?cE5QbHZqTUxLSWpIK2JRdnZsaHc1UGVYdHBML0NDK0hTTjY3V1BjdlpVVUha?=
 =?utf-8?B?cFJkYUFUVUtyRnE4UkJRSzV1TklEWk5NOVFMSXNJUFFLcnlSL0Z1TFh4cUF3?=
 =?utf-8?B?Wk9ZMnJKelR5K2pUS2tiRUJ2Q0MzeWx4UytNUVp0ME8yZS9IZlVWVzZ2UUda?=
 =?utf-8?B?UW5JTjB5VDRMMkc3U3VEOTFQWHFGOG1xQ1gyczlvakdzUWU4OSszVFdUZkNL?=
 =?utf-8?B?dmx2T1dEOElvckI2eDlCdEpNOGRPdDAvcmZ5cC8wWjJzWUNEeHBFaTloOHVQ?=
 =?utf-8?B?ZkJZVldaalA2VFlpYnp5QkxjakhjaXdUUUxOVUFQK2dyN0xhNllMVDJCdERJ?=
 =?utf-8?B?aGIySUJ2b05pNlNpSVJyU29PcllOQlY3UzNPZ1IzQVAyR3BIMkhadjhSQnhi?=
 =?utf-8?B?MHljMVB5K0V4TlNIdkIzcGpkWFQ2VzFIYUE2ejFxNWczN0Mvb0czVzkxMXY3?=
 =?utf-8?Q?4dK6CKhrteA0v?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZWU3aFJsUkg0OXlCK0tUR1hKajNUWWd0ckJnd1poTVpEMzhwbnYzaHNvY0lx?=
 =?utf-8?B?ZlllNFViRTFmU1Y5T2hmV25icDRYUFc5M1BUWjFQVU81VUNaekF1eElGaXhs?=
 =?utf-8?B?QzR0V3Z3akZsMFgxSXFmRTFaOFQ2cE9GYjdjc2VLTHU2UEkvZUx0bFRiSE54?=
 =?utf-8?B?V0RoeDNqbS9mU0hFK01tV0k5bGNpRVpBN25KK1NEc3JmdTUwbldyREI4RndK?=
 =?utf-8?B?VWdVRnZVbVN3ZE5uSEVMOEtzU1ZmWG80UGVPKzBoZjZYM3JCS3U1M2s3OS91?=
 =?utf-8?B?Nkk1MVhtbC9oNThHYjJDK0VSZzhhellEaUxmTEFVc2o3WjhTTXQrdzNBcGUw?=
 =?utf-8?B?NW1QS0h0ZHBjVVBzREtoMUxkT2Q2bWgzai9IM1hyMVE4dUw2cjNQdmxaaDh0?=
 =?utf-8?B?NGZSanFzU1E1aWszTFVjNHd3MFlCN25TZ2g5dXVSeFV3akxKN2xqVE9vYlZv?=
 =?utf-8?B?a1NRTmdYaWxnSC94MmcxZmVNQTlUWWltZ1ZpelBYZFlNbWJvVWVxaHFBc2Fl?=
 =?utf-8?B?WUVQVzhUeS92UTZvalJUSWdMeUFtdTZCclNZd1dSdnhYY2cyVVpRUU5mMXVp?=
 =?utf-8?B?ZGZVZG9oenl0TXF1aVdvZUw3WVUxUXNGdmVRbmVMOVZOYjI4RTVVLzI0Wk13?=
 =?utf-8?B?Q2hJbEQ4SUtUQW1zeGNzbk9zS1hXN0xHQXRKRXp6MXdYK0hxVi9GVnBwN09p?=
 =?utf-8?B?OU15VXdKQUxRcngxUzhaR2tHYjBsVURnSVhuQUxvZnhUaHMxL2RPUWJJTmdC?=
 =?utf-8?B?bTJxZW1aT2JDZ1llUml1TjZxWmNpRy9KckFXU0tQQ05mczZZOFpQTEhqaGtj?=
 =?utf-8?B?WTZlRFFERk1qVElGUnhZWWovdk9paU1RV2x3Nnl5V2ZIVkRJMmxCakt6VHZC?=
 =?utf-8?B?b0IyTTBCT1FDNXEzRUQxQmdvN1l2TlRsTGF3TTBtZFg3dmZOZWlYL3VWZDdq?=
 =?utf-8?B?VDBCRkNJejhLTitZSG9GbnRQMktPbzZwckc1T2o5M1kxOGlOeVlsOWdzTWVY?=
 =?utf-8?B?bmt6Q0ZQc1ZESStCWUFzZUsxb2JNbEZjdTVnc0xSQ3hERTlmUlpNR3UzQlVo?=
 =?utf-8?B?SHJuZmt4V294VVRzMzF5cGZwb0FxdlRSWGdEQ1FCZzZRR1p6YzJHQ2NzTDI1?=
 =?utf-8?B?R2pHSWQ4cjdOaThXczJ3MGxxYjRVSTVzMEFNMlM1N0ZWbUF0V3pnbE1qSVUr?=
 =?utf-8?B?SnhaU2tzaVB0UEdZakp3TFVOdk9NM0M0S2ZvcTM4T0tLUm5NMGZCMGx3Ymdi?=
 =?utf-8?B?cit0ZEFsYWJDa3l6N2dUY3dpNzhab1hzNFlvTjZmVGRwTmd6azR2eEdKaDRy?=
 =?utf-8?B?NmgrQS9JZjhZWGxxekVoSE83Y1FucWhsanlDbFpMTWdWMEQrUXZQTjlhdTBk?=
 =?utf-8?B?dkR6ejEyYkg3QTdxYXVyK01UM2JLSDcybktjTUV3cGpZeDdVZG9YMGxubGV5?=
 =?utf-8?B?Ri9vSyt5bVVqaC9kbUFVSXF1aWRWWDZkSURNU1dTOTVlT2JPRTJvNHRkcmNj?=
 =?utf-8?B?eXJBVllUMmgweXA0VVduYTRzRUhDallxNXV0WTYyN3prb2txN2lGdENpVmNh?=
 =?utf-8?B?Q1R4WXJ1cE8ydHdHSmhFRzVIeVhuckNzM09WWFNqR0tJVkN5d254RFlHaC94?=
 =?utf-8?B?UTVaZmFoL0RlMzM5RTdoS0hSbE5BWU9MMkRtbFZmTjBZSGMwVFR2TnJNcGd1?=
 =?utf-8?B?VHdka1RQc3VzVDRDMG9JaVJIdFFHZnUrT09MdWFYREN5Zi9JRkVYZDNwTURS?=
 =?utf-8?B?Q1l2WHZndnRWQWJkMktTVFdRTnZJVFpJNlRnQnVzSjhVZ1g5dUU3eUw2UXZB?=
 =?utf-8?B?NksvRElNZTZHei94bHpQWGFSdEE3SFh3NEczcWJOMG8vUWdRSkdxVDJ5WUE1?=
 =?utf-8?B?Zng0bHVVbm1YaXBES21waHJpU0JoNXc4TG16R3hSVStCWXhQVkExaGpLVUUv?=
 =?utf-8?B?VzNlNzBEZkhBNHBhQkJER2xKaGpaZi9LV25wMW44ck9mWkhSdTI4OHhRVUF3?=
 =?utf-8?B?ZWE1dktEWUpsNUhENmk1bVlOWml3SFhpcHNLdWFjT05HZ2ZSbzEvVkQ4RnRi?=
 =?utf-8?B?TUpFQ1VkVXhXMVVtclJQNTZkOTVBY0F0ZmQxOU5hcE1meE5HN1FQcXM5b01i?=
 =?utf-8?Q?kMidZ/pFHAmwh0GmgEmNRMHeY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c702da0-6ea8-4173-df65-08dd2e2b65f0
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2025 08:23:28.7790 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PjJvSRNGRrIJUc/UzKfdTphQfYw9Og2pLazhn+8vGu/ZDQzy4uH4hsXvUjjj4quJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8211
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



On 12/18/24 12:40, Michal Simek wrote:
> USB hub initialization is done by driver introduced by commit 09f557e106ef
> ("usb: onboard-hub: Add i2c initialization for usb5744 hub") that's why
> there is no need to do initialization via variables.
> 
> Reported-by: Love Kumar <love.kumar@amd.com>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   board/xilinx/zynqmp/zynqmp_kria.env | 14 ++++----------
>   1 file changed, 4 insertions(+), 10 deletions(-)
> 
> diff --git a/board/xilinx/zynqmp/zynqmp_kria.env b/board/xilinx/zynqmp/zynqmp_kria.env
> index ff3a0924de7d..b0c2ac6f2e86 100644
> --- a/board/xilinx/zynqmp/zynqmp_kria.env
> +++ b/board/xilinx/zynqmp/zynqmp_kria.env
> @@ -62,14 +62,8 @@ bootmenu_0=eMMC Boot=run som_mmc_boot
>   bootmenu_1=SD Boot=run som_cc_boot
>   bootmenu_delay=5
>   
> -usb_hub_init=mw 1000 0056 && sleep 1 && i2c write 1000 2d aa 2 -s
> -
> -# usb hub init
> -kv260_setup=i2c dev 1 && run usb_hub_init
> -# usb hub init
> -kr260_setup=i2c dev 1 && run usb_hub_init; i2c dev 2 && run usb_hub_init;
> -# usb hub init with enabling PM nodes for ...
> -kd240_setup=i2c dev 1 && run usb_hub_init;zynqmp pmufw node 33; zynqmp pmufw node 47
> +# Enabling PM nodes for uart0 and can0
> +kd240_setup=zynqmp pmufw node 33; zynqmp pmufw node 47
>   
>   tpm_setup=tpm autostart;
>   tpm_reset=echo "!!! For TPM reset a full power cycle or pressing the POR_B button is required !!!";
> @@ -79,7 +73,7 @@ tpm_kd240=if test ${card1_rev} = A; then run tpm_reset; fi
>   board_setup=\
>   rtc dev 0; \
>   zynqmp mmio_write 0xFFCA0010 0xfff 0; \
> -if test ${card1_name} = SCK-KV-G; then run kv260_setup; run tpm_kv260; fi;\
> -if test ${card1_name} = SCK-KR-G; then run kr260_setup; run tpm_reset; fi;\
> +if test ${card1_name} = SCK-KV-G; then run tpm_kv260; fi;\
> +if test ${card1_name} = SCK-KR-G; then run tpm_reset; fi;\
>   if test ${card1_name} = SCK-KD-G; then run kd240_setup; run tpm_kd240; fi;\
>   run tpm_setup

Applied.
M
