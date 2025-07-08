Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C07CC8303C
	for <u-boot@archiver.kernel.org>; Tue,  8 Jul 2025 13:02:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 04B2183327;
	Tue,  8 Jul 2025 15:02:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pbZ4wYMa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68CF7830B4; Tue,  8 Jul 2025 15:02:15 +0200 (CEST)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2062b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::62b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6543C83323
 for <u-boot@lists.denx.de>; Tue,  8 Jul 2025 15:02:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YRoQ3nxfKlprsvOXVVqyDPxA50FajL3Y9DncrtYv4GlLhJKIJmG3Kzx0AxTH++Vyj92ytMXHoaKFhKscN/5IPMsIqPk09nqolcS0e/0GypJ69+T28XgsYGBFD8d5srvuM+1W3y+iKaE+QosPNgMZljhm+Yv0/YHbrlR3Htyws0gcUgYRS4PMrTLU8q64rRj7u05M0qtuA7VaP9236dCO9mAPLWxg9cSvmDIYso9D2SocRYXmH2Sc5OsikXfGmXg87y5nWOaoZGp2dryMk8Z6sm6W4n0QckhO9iEeL/rlh8uOC1nJAy/VKBvrV58e5SuJo5185Za1nfCZfDxwYmYc5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p+ZTcu2ocqiTWmbHRsL27Pjp//4pH0+vbkj7lh2aWQ4=;
 b=RSiCZIoone/+R/PHZU/+L5YzvwMBFMOq8PH2cGAAtz8n4q/A+vzuefwhFLVKu7eHLchwK+zO9WtS8nKjzfHR2eIpxyP4TPJLgjGPA3tWHL1JtIcEBoMVVOlHb88Gth5SuHtmi3+nemCOAqtfqzY0r6Qyd8pmZAr1hl5huDA1WUFpXSu5BaE4SD8r0lYeoURxjlXa8qclae3WJM5+cvfgyCiFbYrdPU1eMVghXVJFPmvmwKYvQ7/orqvXEKYBCrQy2pkXorRfq3QlEOr3HVGZVGRAu7qnT+EoyKlG59Dd4+FkSK777bw5cFMoR1bJ5IK+5FdOwEWZPN3fngn6LDvV9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p+ZTcu2ocqiTWmbHRsL27Pjp//4pH0+vbkj7lh2aWQ4=;
 b=pbZ4wYMamEI/yfElU02VNui9JskeK9WyS/d9umYhBP0LBaQ42eXtaUn8WSsKHT7Mjl7Kwtv/8vCpgTvtjjCrMsZxd+WjFlcCMB7cEoRvPGja0CV/sQzI/FP8rcvGK7QEB8xbzJYONbfoDWl/xroZrY9w8qO24PMO4C7OiOG4Qhk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by CY8PR12MB7537.namprd12.prod.outlook.com (2603:10b6:930:94::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.25; Tue, 8 Jul
 2025 13:02:08 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.8901.024; Tue, 8 Jul 2025
 13:02:08 +0000
Message-ID: <85d7bb9a-de8c-4d35-9a18-699e25dbd64b@amd.com>
Date: Tue, 8 Jul 2025 15:02:05 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xilinx: zynqmp: disable CONFIG_SPI_FLASH_BAR
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Cc: git@amd.com, Prasad Kummari <prasad.kummari@amd.com>
References: <20250707043738.795179-1-venkatesh.abbarapu@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20250707043738.795179-1-venkatesh.abbarapu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR03CA0030.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::43) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|CY8PR12MB7537:EE_
X-MS-Office365-Filtering-Correlation-Id: a4984cb1-9e49-4074-e18f-08ddbe1fa564
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Z1V4TDM0RzltUVpKV2lGR09jdk9xcTdqeXIzWEJNWCtWZURGV1k0bU5WWStU?=
 =?utf-8?B?MENzeTJZK2pvOWx5MGRRUUx5ZzMyQUVBVU80TjM1RGFpOWQzMEN3YzA0UFBM?=
 =?utf-8?B?cUNsWnNiNHc2cjJ2cUEyR0RpN0JqUUNDUFBBSDJhd3JTTXAxRFRJYmlZY0M3?=
 =?utf-8?B?aGtKMittMXIycXlyaHdFcGUzMlRIcDhpZEI0ci9qUjZtaUxiVkdaSElhenJo?=
 =?utf-8?B?WTRIT2NGOVpKZlJxbHJpSzNSZml0VE1Zb0MwbVNhd3ExSlB1M3RJKy9vY3NV?=
 =?utf-8?B?STdEc1RiKytLU1lXdHoyb2xCVitHQ0l4VkpoQ2d3eDhBWUJaWnc3TjJEeFRS?=
 =?utf-8?B?KzFXWTJqTXZKSlZCVFVwcGdXcVBabjJocmJJK3hlTkIvSGFtV1QyV1pQbU94?=
 =?utf-8?B?dnFGNHFsMVlhQy9oVjNmTnZkRUxhWVVJTURQQWM4UjNOZEFXMit6bVMzajB6?=
 =?utf-8?B?aEhCK2Y1WVV4T3F6eENmZmljaDJTMlRXREhEWXNQSHNnaDRBSUhvNXBYZWZs?=
 =?utf-8?B?VnYrU0VZNDNKZE1Ha1RDbGxTT0htcStJTzg2VldHemZlbkxFMGRmdTRvUnho?=
 =?utf-8?B?QWswdkJKZGljdkdSVXdWL0FnbElzN0IvNUhVVlA4dFNDclBXaGc0Lyt1QlA0?=
 =?utf-8?B?NlkwL3d2ckNIYThNVjM0NkdJQmgwRVBQREloaUQxU01JdE5XV3R0aXBBS2Jz?=
 =?utf-8?B?NHN0T3o3cEM1SVcxdW5VaW5zdnkwL3EyR2hkOE9ZT01zdjNOOEZVU0lPd0lq?=
 =?utf-8?B?Y0VsNElsY3RNcFZFRkkxWElIRHQrS1A4OHhYMGNYelZWeDladjhiSXNzQUlq?=
 =?utf-8?B?YU5kMnp0eDAweVJ2UExiRVZ2RnVYMWxGZUZBbmpZNFJlTjBBOW1CQXc2RURV?=
 =?utf-8?B?dzllZmJuQ20yZS9ZNHBoOW1jTGtEK0xCYWpFOVJZS2F4TVFWQ0VrWXFVdkNa?=
 =?utf-8?B?QUNDUVdhQXNRWFRRaVNISG9rekVpWHRYYm5PdnBzYWJFQ2pTeGdNdWxtTGJj?=
 =?utf-8?B?N25EZnZVdG85QTVpNkhUTEdVSGxUZmtHaEJyZHhuOXIra2Q0aldJUTRNbW40?=
 =?utf-8?B?blRyTmVuai9KYk54eVUwMUwveGxHYUVJNnJPQ3Q4TVhyd0RIbVJEN3NFWFM3?=
 =?utf-8?B?NkpXcCsrdXp6NkxIZFEwT2s4cTg2Ukh6ajl4ZzA5Ri9ub2p4a0pZK1lEblZh?=
 =?utf-8?B?V1hGTGoxSHgrZmU5dGRQUDdCR2FXQ2g2REVwM2FyY3U4NzJGZjRzS3dyajIy?=
 =?utf-8?B?MmtWM29PeTlJejZEdSt0Z1dXMmRSWmtzQ1JTM1RONXJaQ1YwZ1NhdWlQWDlJ?=
 =?utf-8?B?cXNNU0VHOGQ0c0J6aFRNeHBXQlBKYjFHWFVpUDVIZVlUUWJFRUs0dXhLTG1Q?=
 =?utf-8?B?K0kzUW1NZEZOV2VsbjBIWDlZN2FYUVgyeEtLb2srNTZMVDNjc2NYWEdib29N?=
 =?utf-8?B?U09DM1IrRjRHZ3pSbFVnV3ZnVGs2M2h2VGhaeTY5L2JjSHdCa1Bkc3NkajN0?=
 =?utf-8?B?UWJaTkRlOWZ3K0tIaEtEL2xJbTUxaUpzcXUyRG1iK1RGTkFkbjVFdk5JMGFE?=
 =?utf-8?B?MmF3Q0d6WmtmaVBWNUpSZU0vNWJubi9ZVWdKNmMxMUNoMGtzem4zN0J5Yk9S?=
 =?utf-8?B?SUI1N2pvd0xQRy9zQ1FxKzZSU01xV3lORWdYK1lnMWw0dyszZmRKVDQzdnpF?=
 =?utf-8?B?VXFuU1I2L0YydnROL25nQmlqOVhsSzExOVBodlluZEFFNCs3RXlvR2h6V281?=
 =?utf-8?B?bmF2L0FUeWFJR1QvMkJaanZTZG9KM0oxczNVVlVXVncvQzZtb3hzb05YRkNy?=
 =?utf-8?B?di9KTk9QckhSNDNnd1NYT3NPamEyWGlwN3UyMUpLOU9YcU9UdFJQUTZMY1Rq?=
 =?utf-8?B?YSs0TTlJWVpUVjBuZ2VHTDVOdWt4Z3VNWmgzc2JQUENMODVsTjVoY25vS3ds?=
 =?utf-8?Q?6jB28W9m0DE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUVmQU9GSVgyTUJaQ2trN1M0dVhaN201bVpGVmoxUWt5b1UwRVMvdDBqa2pJ?=
 =?utf-8?B?OTlZbkNQYXo5L0VJV1JrN2lQcUViOTBQeEFjV01waUg5d1N6ZmYreGd1TTkz?=
 =?utf-8?B?WUU1SUFSc2lwVUxQVEw2eDZnNXRtdzZxNUNmd0EzUjA3dGl1dWM2ZG9ZMTlE?=
 =?utf-8?B?RlBybjNDc0h4enVFNHBCS2Z3bVVQbEwrY3J2VEFEVUZ6QWZraU0vU0hMaUd1?=
 =?utf-8?B?cGpHRW0xa1hhL1JwVitUS053blBvMzF2TEMwTG4zeE04Z1c4TjkrY2FlM2JN?=
 =?utf-8?B?SElVVWRYa3ZocDdoVFhHNitBcDNNekdwM0lYMDArVUFvcHljQmswditCSXRN?=
 =?utf-8?B?N1Q4dG9ISWRJREo3MzFjSDY2bHprYmhEa21IenFHNEJqdUM5L3pGblg2U1F6?=
 =?utf-8?B?aG5aNFZQVU85akdXdlFhUzNiQWprLzRINjRPSUlnWkxYQTVKUTRkYTgyUGpu?=
 =?utf-8?B?SGN3QnVkWTNEczdzSzBsOEYwa1F0Qm9YTVdiMmVtb1BMY2swK215aGswbkM4?=
 =?utf-8?B?UmRuNWMrVEJoZmM5a04xUkU2QzA0b2dSM3JWUnFZN2kwYzhMcEZzbUVtWXJF?=
 =?utf-8?B?WWJLU3Fpa2pMQ1pqdVhlcEVQRyt1OEU3M3Q0b1NyU3IveWtmYTVLOUt5bjc5?=
 =?utf-8?B?NlAycTVweHFOcFY2SXlQeWthUCt6Yy9sV0s2N04zV0w2U0lPL2V1MWVOdngx?=
 =?utf-8?B?aTl0WW9XU0NZM2x6SEgyeFdZb2VKdCtRcDFYQ0VPbGlSMlVHdi96bytid09V?=
 =?utf-8?B?R0VVV1ozZ28vcW9NNVVKUkQzMFRGRzVUZGN2eUdWTklhVnJ5Ums1TTFBQUgw?=
 =?utf-8?B?VmNCcmpOVTY4VXhkTnJGdSs2M1R6RmpuNFloRm53VXhhd0xCR0F6eWtSditi?=
 =?utf-8?B?cmIzQnRFZHRKLzRkc0lmMnNtRDRMc01BVm40V0c2WlplMEQ1ak5WSlNPYVZX?=
 =?utf-8?B?ZTZmTCsvRTB0SFBZN2o5RHJtbHk2OCt0TTE5R2Yvc2d2UlV2YzltcEQzYmYz?=
 =?utf-8?B?Ly9lcVY1akhnV2RvcU40QU02UDg0YkZXWkZZMTBqemdyTFFFMjYrWEVXb1BQ?=
 =?utf-8?B?K0Rib2tsMVNTOXRTUEZsN3ZXOEMvOXM0WHRlQ1pqa2lmbUlsNXJRaS9nYW0x?=
 =?utf-8?B?WTFBdk1BdURTc3pmZFM1NjJZVFJSMTdDUXhWeWpoaUU5aFBUWkdQU2swTk53?=
 =?utf-8?B?RFFRYVJSalRKOFlFQUp0N3pOZU0zcGZRTE10YkFKZjdTNTJ2b292WVlZcitC?=
 =?utf-8?B?TDFVUzRDYlA2K2lDL0J6RGh3SzM0Y2JLYWg3dDduRUlWZmhQY3ZubzhMRGZ4?=
 =?utf-8?B?WExiZkNhUDU3WmFrWDRzcWtkVjYraXg3eEdFMFdXSHNydXRSNXVqckJ2VUhU?=
 =?utf-8?B?eEhlZEZoTDZnempsZDdEL1dWYXJBalF2RGNlTGpyL01PL0xiU3dlUlpkb0xR?=
 =?utf-8?B?SkJKWVNuMUNhNEUyVUl1MWdGSTdsbGdCNzM1aVptamRud2ZFWGpxRlNjdWs4?=
 =?utf-8?B?dlBxL25BU1FTWnZKMHE0VGFwVmFjNFRoYWx4c3l3ZFg5SFRuMTltaW1VL0l2?=
 =?utf-8?B?RWl1d0VBSzdlZ3dYM2xHMUJmY2ZlMndsYzFCOUl6VWljdGpMbTgxS0lVRWlK?=
 =?utf-8?B?QmU0T1lTQUV5MVdwL2ZvbEdEWE9lQnQxVGFCZG9ZMFIyTmZLV3RRTzhaMVRG?=
 =?utf-8?B?cWRLS0puZk16T3lGa1hWYjJ0S0dvZHpXS3p2M1pLajZXUnpnSEd3U0VHRVVn?=
 =?utf-8?B?OXNwUzhQZ2ZRMmREUTVMZEl5cnJUVTgzTk5yZ2dPUDFlT3Y2R0pRZTNNUWxS?=
 =?utf-8?B?d0RaVUJraDhxd3FlMCtGQTFsOExYSzhhY09EWktwckRIRjJsZ2JtbG5MZzJR?=
 =?utf-8?B?T3prdG5GR3Uxdzk3bG56SEZTTmRaSVRrV3Yva01McWVVbDh0L3lqOW5kdHBh?=
 =?utf-8?B?cjdHK3ZSdDI2aUdrTE8xam52OG1tOW5pQVhSbmk5OUdIT2R1WnhEZmx1VFA0?=
 =?utf-8?B?eXVoL3BTWmlFcUI2ZTg3cEZoNkRoOEJNK0dmNnpQSUdVT0hheXZDN2FWN2ho?=
 =?utf-8?B?K2hMV3ZvQm1FR04xbEFvWWJ5MWJ5ajVrWnRTRWUvOWtkK215U1BiT3pBMVVB?=
 =?utf-8?Q?mtMbNsd+8/X+tPnNRZjoB53NJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4984cb1-9e49-4074-e18f-08ddbe1fa564
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 13:02:08.5424 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7IWhWSTK7Nl4XT6ebGdlr5Y26vMzYlN9RSAJZSg5+DZCuMBEuDLp2X1pSVL1rmgY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7537
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



On 7/7/25 06:37, Venkatesh Yadav Abbarapu wrote:
> Legacy SPI flash devices used a 24-bit (3-byte) addressing scheme,
> limiting the addressable memory to 16 MB. To support larger densities
> (256 Mbit and higher), extended addressing schemes, such as 32-bit
> (4-byte) addressing, were introduced. If the flash density exceeds
> 16 MB and CONFIG_SPI_FLASH_BAR is disabled, the device will use a
> 4-byte addressing mode.
> 
> Signed-off-by: Prasad Kummari <prasad.kummari@amd.com>
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> ---
>   configs/xilinx_zynqmp_virt_defconfig | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/configs/xilinx_zynqmp_virt_defconfig b/configs/xilinx_zynqmp_virt_defconfig
> index 7807f6240e3..3d6ffd87af1 100644
> --- a/configs/xilinx_zynqmp_virt_defconfig
> +++ b/configs/xilinx_zynqmp_virt_defconfig
> @@ -163,7 +163,6 @@ CONFIG_MTD_RAW_NAND=y
>   CONFIG_NAND_ARASAN=y
>   CONFIG_SYS_NAND_ONFI_DETECTION=y
>   CONFIG_SYS_NAND_MAX_CHIPS=2
> -CONFIG_SPI_FLASH_BAR=y
>   CONFIG_SPI_FLASH_GIGADEVICE=y
>   CONFIG_SPI_FLASH_ISSI=y
>   CONFIG_SPI_FLASH_MACRONIX=y

Applied.
M
