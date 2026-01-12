Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32966C9EC7C
	for <u-boot@archiver.kernel.org>; Mon, 12 Jan 2026 12:04:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 25C87838A5;
	Mon, 12 Jan 2026 13:04:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="h9pDvayr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 49A63838E6; Mon, 12 Jan 2026 13:04:21 +0100 (CET)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EAE8283678
 for <u-boot@lists.denx.de>; Mon, 12 Jan 2026 13:04:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=daV4RZwLWf8HsJUJlmypBuJp6XQ+SD8nQP6Lqb0tGq/pBOgf3RLHfkT2ZbPBsqVYcyVXQNvvN6MQFyBpRz1RGZxCz0yh5MhBWWfk1uESpsK9IHEO83JKnHuHEOZIbPspzp6JrdmcQ6sogCZHLYexeFjEzVPteTWXpVkxfV80udAHa979HtjjMRG9X98nrjSvDANgajoaR+ta2+xuTnf/tyYHb40aAG+eDPbpRXnDffqXQwGPo8gs11MfPiK7C4Ll+Wqs/tVBEmZZ1pzn3neKkcqAACLb7aKJe4w6eYq0pvhCt/YainSMbtbvFBRVeDtR4Sp+wBKAK+OyEkOUu4skNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fwrE70cv20Sn7m7de9UViarvSRqbura/CouvIshj3Dk=;
 b=MPu3hsq3dKlDbDAb6S31jLrerlxt6EkTkXpGobOkFAgO+ybnpwLucqEyZdvs+a6alb19+3L7XgD+q89MLgNztPaw/bbFz3N/WLws6BPZmlJkOIV5QDyViOY31qS8+OEeLqF4aiOEa4cnxyy42oA3FCEcg6QpsLrjy+LcVZqQKkFsEsOg48qgPXTmVLApu8+jYS769JryR4OEQhtObuaWNQR5CP0HMB93Iu2jAbBd+j4qrsZYZh24WF81Aazz2j2fREosKxVq8oQ0egbnsOhOlbHcyVH3/vHOMYMaS0cFd/9SfNCedm69A9Me8SVHXe1HortdY0H48pbJNUytBTkGdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fwrE70cv20Sn7m7de9UViarvSRqbura/CouvIshj3Dk=;
 b=h9pDvayrBktKG+WP4liYd4ZoN3D6a7Ik273NvRTM20RY4sPR5xb3x/sCnQ5LFq7iJBpgsYCJ4vNkaZvr0rSBpu6LKWmh198D4BTnsuoKyPsQTyyZNUgZH6/qkOJdJEv/OdBK1ywiDybGB/uXhggrLjl22XAVHoMDtnCS4scqI90=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by SJ0PR12MB7458.namprd12.prod.outlook.com (2603:10b6:a03:48d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 12:04:12 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.9499.005; Mon, 12 Jan 2026
 12:04:12 +0000
Message-ID: <1579435d-5a6b-46dd-ab40-6c0aaf06d6b1@amd.com>
Date: Mon, 12 Jan 2026 13:04:09 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] arm64: zynqmp: Remove ina260 IIO description
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@amd.com
Cc: Nithish Kumar Naroju <nithishkumar.naroju@amd.com>,
 Rohit Visavalia <rohit.visavalia@amd.com>, Tom Rini <trini@konsulko.com>
References: <138720bf2ff976974f5ce3566446ecfd93b9259d.1767787961.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <138720bf2ff976974f5ce3566446ecfd93b9259d.1767787961.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0151.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::6) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|SJ0PR12MB7458:EE_
X-MS-Office365-Filtering-Correlation-Id: 5de842d1-4532-4f6f-3c93-08de51d2b360
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b3h5THNRbVhJaGh5aUhNeE9HRG1US0psYmZ4SkJkYUE1aFY3VmN0K2hlQWky?=
 =?utf-8?B?VXZZY0UyV0syODMrQmQ1RVZHR0RZR1p5U2YxV3UyRm9JVGx3OEJIZlFkNkpt?=
 =?utf-8?B?cFdnWWVBVUgvOW5QUHV6SzV1ZXRraURxdXpnTzcyZUYxNytudlp4RWo2Sk9B?=
 =?utf-8?B?MTVVMXhKN3NiNlZqLzZHNTJRU0c1citCRWF2TEhuQVRLRUx2QU0raUtnZGta?=
 =?utf-8?B?eE5HQzhRclhjZFQ1N2lNSWdCV0wwMUwyZmNqQmo1T05ITlBxdmVkMW43RVlD?=
 =?utf-8?B?UE9XeVI4TkNSV1Nab2x3UFNuTmxxT2pPNitmSndaVjZwZUJzNnVTeEF2YVhD?=
 =?utf-8?B?SE5QU2FtYktjdkZ3T1M1MlZPdWZvWU5IRlJrcWdFQXhTQ1hQb0ovL3dWaXAr?=
 =?utf-8?B?R3hrOUNSWkxKMllRb2pRc0JyenJROTlySGxHSHo3L0NzZkFBSlZmQlRucURN?=
 =?utf-8?B?UDVvMGFoTGtOS0JIKy9GY0pYUkN3NzNpOG5GZTA4VmhmbU1zTWQyclY5WlIx?=
 =?utf-8?B?WDExWHNmWk1yUHVtZUNtbmt5cytQUndGcHY3QVc1ZFo2OXN2cmhqTTZBdDM3?=
 =?utf-8?B?SUQ5SDNlYlJubXZlUFZNY0QvTTIwenk2WnYrbTZXL3F4b291Y2RUQWM3VzZY?=
 =?utf-8?B?WGtaZmQ4Zlh2cTcrak1tb0VLdTUzNGJTeStPcm0zelJ0VnlGVnZyS1ZjTllL?=
 =?utf-8?B?ZVhYMzFvdG4yTE01dWRKTUNvK1YvVUkvYlFxYmRBSS9FVlAwM2FuZ3NrM0F0?=
 =?utf-8?B?YXVEbXJseVJVSEliV3RmVnZUaXdQaG1FRHB1b04xL0krSS9SNHZ6Z1lOcHJP?=
 =?utf-8?B?eVZrT2tVYWVVM3dLUXEyTXN2M1ZOeE1CVUlKWXlPN2tUeTF5VzlxdEQ1dFZa?=
 =?utf-8?B?eU5nVlpyNXBGdURzYk1hWFVNOWpxUUdJQThPcjdxQVVjakEzQ3pqWG9PRjl1?=
 =?utf-8?B?ZkltczJwWDljY3IxR2RqazM1cDJmNGtvK1RmTFNTUEZnTFM3dE1wdnVhbzk1?=
 =?utf-8?B?MXNNTFNmWTVSNUN5SVUvMkpsKyt1VWFMVGdSQUlDV2xnRkdnc280cTNkTTI2?=
 =?utf-8?B?eEpNemdhQUk3RFdOMmRLVW5WSmJKZlJ4NW9RdmtPYnBUWGJSYjVMOHhMRVJn?=
 =?utf-8?B?bXpjVUhXYWVPOCs0ZjVrQ2hHK3E1WisrK0VDWWxYaU56dWNmc2VnalE4Ny9Y?=
 =?utf-8?B?djV5SGMzOUZiRHhJRDFVZHovcHpyUk9yUmREN0QvSlpGRGdJQjdpWTlxY2xr?=
 =?utf-8?B?SWdzMUp5SXhQNEtDbU1pUms2WmQrRmk3bGdBWXpITmhlYUEzMXJiVjJZd1Bj?=
 =?utf-8?B?QXBCVDRKeVJhb25QWFl6ZVlNQ2dRZkFUTVBxQXpqemhCTDZ3cWJHaWk2Q2FO?=
 =?utf-8?B?QWpYeFk0WFJhNkdaWVp3T1M5V2RWY3pKQ0swb0VpMnQ3T1VoZTBoMXhpZ2Rt?=
 =?utf-8?B?WGlMZk9venMwYlZ0YmZpdisvQzZkQlFGVkFQOUF1aXBNRU1TOXNFNUI0TlpN?=
 =?utf-8?B?c3NNRjJaS3ZsQzNieHJpUXBDeFRmOUhOSkJRM3FWWURyOW9CMERQWWZjOURZ?=
 =?utf-8?B?alJ0MXpncytGdWtOYXYxbnI5UXJFRDF4eGhITmdDL2ovL2FpaXI0Nkt0TUlC?=
 =?utf-8?B?V0FRM2hKMk9RY0xnUWM2Nkk5Q1JuYlVwMXpHem8rNGRPTmR0Q2lnR0g5ZUxM?=
 =?utf-8?B?dWlhb1IwQUQ3RU8vT25paUpaRHhISWVpaXc4TVRkMENJRERmaW1ONmQwUVV0?=
 =?utf-8?B?Sm5pQTJxVzJnRXlaRVNWY01GK3oyWUFvbzAvdmlGVW1OdUh2WEFOeHFMRzRL?=
 =?utf-8?B?SHJ6dFAvQytVcnJ6b0NWa2FycUZQTGh6am5MdjVLQldsWUdGUEFHdDBXMlZx?=
 =?utf-8?B?ZFV1eEMySWZneGhmMUw2UThaUnZSOGhoeWE1bjBnQ3ZSNGR3aStOOGlleDJ4?=
 =?utf-8?Q?A6EPYxev6FM8nh8gi5PtTrG0XLO/7Xyr?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QnAzZFFVbytNcWY0YnNNdXg4cjNCVTRYTWFIZlVRS2dyeTJ3Zm13TWQ1eE90?=
 =?utf-8?B?cVJQdmFKZDdKQ0lhWlc5ZmtodUMrV25EZGtwTFBOWFY2STgrOWZhb25ad0g2?=
 =?utf-8?B?TVNIbWp2cWJCY2ZVQ3lsamcyOUlpVEFaKzBYQ0ZmdndsaWREZGhRZnlDOTdE?=
 =?utf-8?B?UXpnbzVlTHR6VlpEVkFpbFkzbVc2ZHhjNkJiZ2lxQlkwK0ZyNmtCcTIvZUwz?=
 =?utf-8?B?dE9JOGhOdktVK1hseFNURWpPLzREODRJMVJMSW8vd1h6ZCtqUS8zNW9CMmxI?=
 =?utf-8?B?TmZXN1RxYmNBbzJseldIYU83dWNCQzBVV0VGR2hZb3hIVU5aZXI4ZTFoS3dI?=
 =?utf-8?B?Y21VWlJtR0lwVmJhcTJVMWVmRDN2RWpYYXNYQUQ1dU80NnVoZElvQUZjd2c0?=
 =?utf-8?B?L1dPTCtrOHpzdi9wRmZRVWZQZkJGL2RTRTByYmh2alBndlkzWnZ2aDBaVHhp?=
 =?utf-8?B?ejR6Mmt4R2loWGNXZkpPamdOd0hjdzdld1lUMnRqbVdHNUlSRS93dW9tb3VZ?=
 =?utf-8?B?VlhmL2hyUWtKUGlubDBOU2lHTW9ROHlwazdZSmVFaVZDdi94NCtaeGxVdHlz?=
 =?utf-8?B?U2l2a3U3cjRCMzFKWjFMRElMSzVxTXhEc0J0VENFMXBvYkdjUTNReWl3ZGdU?=
 =?utf-8?B?K3grZmh2RW5WTEx6ZUJISThoRGNkR2g2WnNOZ3puU0I5QTlXaFlSL2dCYlV1?=
 =?utf-8?B?NUZOSi9UcFZuSFJaVnVySzcycDZhYTIrQ0dJM0xFaWI2WGlUWEFlWStEd3dm?=
 =?utf-8?B?WVA2NzJHUFJtSU1oRTBFVWhqS05FOEZsMHVINkZHM3ZZaVJnTmJ1Y2ZSQ0dP?=
 =?utf-8?B?eDdQd3YxQ1VEM05IczBzVWpKRjhXM1VsblBZcnhhMDZMZW9ReDdZeDhiTzFz?=
 =?utf-8?B?bmF1K2R2ZFJyS3ZPWko0cFBveEVvS3F2ZWV1Q1B3cHZxbjZrVHJXV3Fka1d2?=
 =?utf-8?B?TmF6YjVPTjJtY00zU0N2SU15WnczeUVnbEF5RUI0YS9MWjNzVTV0dG5mM2tU?=
 =?utf-8?B?UndGUG4yT0tEc0xiaDlWSnlRRG54ejFIVVoydUwvbjdjRkY0V1JaUy9UM25W?=
 =?utf-8?B?eWV3di9lZkJWQkNBZTN5VW1tWFFmZmI2eVFOMWlLMHN3QjNKa3JDVFlodVlP?=
 =?utf-8?B?dzNTU0N3Tm5EVTROM0hxajlYckVJMjFBM0F0UnZDQnhpLzRMUTRERFRzMFh5?=
 =?utf-8?B?M3B3S054RGxZbUhMUmVlcENWVXJtWTQvYWVocEVSZ3JXcTcwSE13Y0dEZ1Vj?=
 =?utf-8?B?VFBsUFBsMzlPelYvUE9LbmxkZ0dKNWtWazU1cGRCbkZTRTdQS09mS2w1VzlT?=
 =?utf-8?B?Sk9PYkhLVFlYMTEybnpzdXpYSVpDakh1N3Q1ZHJBaytVWXlxOEV6K0F1UldP?=
 =?utf-8?B?NDUvaHdJMDNqdmsrenBuazViVEg3UmhaYW84SldYRUJGOXFPbkNMMmV5Wkhw?=
 =?utf-8?B?c0xEMmt6aWNmK1FWbE9jWnZPbldQVlBiMHYxT0lGTndKc0tiZ1lhU0FNbTMw?=
 =?utf-8?B?WnNXMHNYWEkvdG5CcXUvcU91ck5TdGVya0lYZWc0ZFdKY1JHOWVTTjl2MWU3?=
 =?utf-8?B?U0NlMHJKR2loRGVXSitZMEhEckNhaWh3dmx4NmFKZCtVb1JoMWlISldlZ0Mv?=
 =?utf-8?B?dC8zamgrNlJjWUlJTUE5L0FWd0F3SkJxenlOS05WNUV1Um9pcmtWblRVSGlG?=
 =?utf-8?B?MVZ5Z1hFY0NxLzdVVUYzd0RkL2dtOWIySll2KzU3OGQvU0lxQ2MxVUF2S0Uv?=
 =?utf-8?B?SGlqM2ZYUGZUTGRJc1R2Z3BQWFRFTWdhWTM3amdxVTVURWxvZkhLaUhnOGwx?=
 =?utf-8?B?Y0IxK2RQSHRJNHJTMXB6UWRkV1pibXJIRVluK0cvbk1ZKy9FSXJlQzBKV2x3?=
 =?utf-8?B?V3NxUEE0RWJieWh1VXVHVG5hSFhBZDVGczQwSVNBbGh5eWRKMURjZGZ2ZzNN?=
 =?utf-8?B?V0p4Wjkzc0FvQndEcWlYVHBuNGJWWE9jOEQ1SitNcUdtekczc0lpOUhxekdN?=
 =?utf-8?B?SGhrSXNhWEU3TGxkYnFvQ084d3JwTkZXY0hBTUdOUU8vTkpITDRaUVA2djRp?=
 =?utf-8?B?ZTJmWWljZmFsRnBsYjMrMmhOMWVVMUNaNFZsd0pXMWhyemUxY0VxbDZKMm5p?=
 =?utf-8?B?UTN0eDJMQldOenQ5aStmTW1VRXRFc1E5T2FSdG9aSFZUSEkyRFBNU3RsaUVL?=
 =?utf-8?B?RVJ6d05xaGFvTkMyM3ovV3ZwcjZwM3dQWDhmdlFoMU9WSlZDVHRrMTFqRWla?=
 =?utf-8?B?R0liWUpYRm9mUmRZUVp1NE55UFlCTWpjeDJlOVBFT2FybjFMc2ZHQ3Y5VDFm?=
 =?utf-8?B?QjVpaGJKaU9pdWczc0NFUUdnb0RsVVh3WnZwQ3UzK2R0QWxPQVkrUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5de842d1-4532-4f6f-3c93-08de51d2b360
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 12:04:12.8669 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LAk2MnlSQ8/r2gQCuhrtxCPETEfvTZ7wnCoblNW0dwTRFdMLa9EaXDiVAwlERsdS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7458
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



On 1/7/26 13:12, Michal Simek wrote:
> Kernel has hwmon driver that's why there is no reason to wire iio to hwmon
> converter.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   arch/arm/dts/zynqmp-sck-kd-g-revA.dtso | 6 ------
>   arch/arm/dts/zynqmp-sck-kr-g-revA.dtso | 6 ------
>   arch/arm/dts/zynqmp-sck-kr-g-revB.dtso | 6 ------
>   arch/arm/dts/zynqmp-sck-kv-g-revA.dtso | 6 ------
>   arch/arm/dts/zynqmp-sck-kv-g-revB.dtso | 6 ------
>   5 files changed, 30 deletions(-)
> 
> diff --git a/arch/arm/dts/zynqmp-sck-kd-g-revA.dtso b/arch/arm/dts/zynqmp-sck-kd-g-revA.dtso
> index 02be5e1e8686..832dc5ab2458 100644
> --- a/arch/arm/dts/zynqmp-sck-kd-g-revA.dtso
> +++ b/arch/arm/dts/zynqmp-sck-kd-g-revA.dtso
> @@ -26,11 +26,6 @@
>   		ethernet0 = "/axi/ethernet@ff0c0000"; /* &gem1 */
>   	};
>   
> -	ina260-u3 {
> -		compatible = "iio-hwmon";
> -		io-channels = <&u3 0>, <&u3 1>, <&u3 2>;
> -	};
> -
>   	clk_26: clock2 { /* u17 - USB */
>   		compatible = "fixed-clock";
>   		#clock-cells = <0>;
> @@ -67,7 +62,6 @@
>   
>   	u3: ina260@40 { /* u3 */
>   		compatible = "ti,ina260";
> -		#io-channel-cells = <1>;
>   		label = "ina260-u14";
>   		reg = <0x40>;
>   	};
> diff --git a/arch/arm/dts/zynqmp-sck-kr-g-revA.dtso b/arch/arm/dts/zynqmp-sck-kr-g-revA.dtso
> index 88396d089f43..532f6bf92bc5 100644
> --- a/arch/arm/dts/zynqmp-sck-kr-g-revA.dtso
> +++ b/arch/arm/dts/zynqmp-sck-kr-g-revA.dtso
> @@ -25,11 +25,6 @@
>   		ethernet1 = "/axi/ethernet@ff0c0000"; /* &gem1 */
>   	};
>   
> -	ina260-u14 {
> -		compatible = "iio-hwmon";
> -		io-channels = <&u14 0>, <&u14 1>, <&u14 2>;
> -	};
> -
>   	clk_27: clock0 { /* u86 - DP */
>   		compatible = "fixed-clock";
>   		#clock-cells = <0>;
> @@ -95,7 +90,6 @@
>   
>   	u14: ina260@40 { /* u14 */
>   		compatible = "ti,ina260";
> -		#io-channel-cells = <1>;
>   		label = "ina260-u14";
>   		reg = <0x40>;
>   	};
> diff --git a/arch/arm/dts/zynqmp-sck-kr-g-revB.dtso b/arch/arm/dts/zynqmp-sck-kr-g-revB.dtso
> index e041a962d89e..458d79e81192 100644
> --- a/arch/arm/dts/zynqmp-sck-kr-g-revB.dtso
> +++ b/arch/arm/dts/zynqmp-sck-kr-g-revB.dtso
> @@ -25,11 +25,6 @@
>   		ethernet1 = "/axi/ethernet@ff0c0000"; /* &gem1 */
>   	};
>   
> -	ina260-u14 {
> -		compatible = "iio-hwmon";
> -		io-channels = <&u14 0>, <&u14 1>, <&u14 2>;
> -	};
> -
>   	clk_125: clock0 { /* u87 - GEM0/1 */
>   		compatible = "fixed-clock";
>   		#clock-cells = <0>;
> @@ -96,7 +91,6 @@
>   
>   	u14: ina260@40 { /* u14 */
>   		compatible = "ti,ina260";
> -		#io-channel-cells = <1>;
>   		label = "ina260-u14";
>   		reg = <0x40>;
>   	};
> diff --git a/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso b/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso
> index fbbebbea80cb..e7417af8ae01 100644
> --- a/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso
> +++ b/arch/arm/dts/zynqmp-sck-kv-g-revA.dtso
> @@ -32,11 +32,6 @@
>   		ethernet0 = "/axi/ethernet@ff0e0000"; /* &gem3 */
>   	};
>   
> -	ina260-u14 {
> -		compatible = "iio-hwmon";
> -		io-channels = <&u14 0>, <&u14 1>, <&u14 2>;
> -	};
> -
>   	si5332_0: si5332-0 { /* u17 */
>   		compatible = "fixed-clock";
>   		#clock-cells = <0>;
> @@ -96,7 +91,6 @@
>   
>   	u14: ina260@40 { /* u14 */
>   		compatible = "ti,ina260";
> -		#io-channel-cells = <1>;
>   		label = "ina260-u14";
>   		reg = <0x40>;
>   	};
> diff --git a/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso b/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso
> index 87f94f8ef9d8..7a05180e58b4 100644
> --- a/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso
> +++ b/arch/arm/dts/zynqmp-sck-kv-g-revB.dtso
> @@ -27,11 +27,6 @@
>   		ethernet0 = "/axi/ethernet@ff0e0000"; /* &gem3 */
>   	};
>   
> -	ina260-u14 {
> -		compatible = "iio-hwmon";
> -		io-channels = <&u14 0>, <&u14 1>, <&u14 2>;
> -	};
> -
>   	si5332_0: si5332-0 { /* u17 */
>   		compatible = "fixed-clock";
>   		#clock-cells = <0>;
> @@ -92,7 +87,6 @@
>   
>   	u14: ina260@40 { /* u14 */
>   		compatible = "ti,ina260";
> -		#io-channel-cells = <1>;
>   		label = "ina260-u14";
>   		reg = <0x40>;
>   	};

Applied both.
M
