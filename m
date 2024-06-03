Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D4AAC25B75
	for <u-boot@archiver.kernel.org>; Mon,  3 Jun 2024 15:08:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF1C1882ED;
	Mon,  3 Jun 2024 17:08:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DIIuXDq9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C876882ED; Mon,  3 Jun 2024 17:08:32 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2062c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::62c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 117F487D2F
 for <u-boot@lists.denx.de>; Mon,  3 Jun 2024 17:08:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DSFXC3lTy0sGWp/ejEWpQCMQzKwGsRZN0hg/kVUmGXbyuu01Q4nRz1URPhijuLoGhSzxZotqnYJqU8JDIHYgRUVKyjhh1XCNUZ6M2fAjgKMrKMeOi5TPOl5I5FHqg41rQHxv3c5yOZRvbsL0WE8rm57k6bw5LK8VrnHOozpxH6s64hYUr+LIlTVnPrWIX9qNjBaRGjz6B5tCuCnyg1e6I3XDPz/HVRTYJFXndZUi3Bq1aFbt2U9/EExwGVGeOFM1o3gZTCw13jaj+TPvYb9aimhi3T7v+4gKHww/RpT9Z1qKkkLtvKfXP4Gzoci8D6o2FFbrKH8igrqHLRStU5tfJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UYusGp1NIzgVaYjxGs3gKeokDG7pt3jffJCsv0ZjjMQ=;
 b=WeX/9MWhxi9xL3Htt+Q1syZAGaB9d3NNMDWxe16tiAh+VZuWQCtSbtP2/RFv9UnWQe/o/0DGebuwjXseJIh15R/1+ywksZKANOXExhBHG+9vhlMxqlsT2mjxBGFRMb2K+ihRhYsiVUJwd1MYphpTU64R47eVKHFkbm4lzuP0yVeN0yPDLXj+dXFtHCslAsPURYxdkNeOii+9eF1AzIpUnO+xSSh5Rfns567iznlfw4hbFaPvnLaPjjt2TzFmM/+k11t3O8fIhYlnqOWqdEw2/Z3GQN90/rYW7mHEQ8YY6HaApAtZTYR99ggXhBkzDSeE05snvoADs3mklRu+6WT5QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UYusGp1NIzgVaYjxGs3gKeokDG7pt3jffJCsv0ZjjMQ=;
 b=DIIuXDq9VVmKbdwvAT8pk1mLX9sw3Tw60JoFzei1JEhz0BjrW6SHluzBBV5gjkofOZJyRrzS0+SDe6r/GgpYII4tqUWRIm40JKOgv7E9l01cD4mEQIq9RQAQR0R7Lrtv+ei5SJaiSoahamP359uAASYt/AOz342AVDuieIdegRQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by BY5PR12MB4065.namprd12.prod.outlook.com (2603:10b6:a03:202::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.25; Mon, 3 Jun
 2024 15:08:25 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%6]) with mapi id 15.20.7611.016; Mon, 3 Jun 2024
 15:08:25 +0000
Message-ID: <aa82531a-3629-497c-a442-1c3a2715ca51@amd.com>
Date: Mon, 3 Jun 2024 17:08:20 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] xilinx: zynqmp: Enable reset_cpu() in SPL
To: Lukas Funke <lukas.funke-oss@weidmueller.com>, u-boot@lists.denx.de
Cc: Lukas Funke <lukas.funke@weidmueller.com>, Tom Rini <trini@konsulko.com>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <20240603133447.173402-1-lukas.funke-oss@weidmueller.com>
 <20240603133447.173402-3-lukas.funke-oss@weidmueller.com>
 <d0489c83-7225-4127-9ba6-e9b29165d2b5@amd.com>
 <efaa2184-d082-41c6-8e8f-682d60771e8d@weidmueller.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <efaa2184-d082-41c6-8e8f-682d60771e8d@weidmueller.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR21CA0025.namprd21.prod.outlook.com
 (2603:10b6:a03:114::35) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|BY5PR12MB4065:EE_
X-MS-Office365-Filtering-Correlation-Id: f24d4882-7533-4dd2-cabf-08dc83df0438
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MnFJMzhucUdKVHhDVDlZdjBrVG9WcEZnQW1pQTliampXNUZEbTlvRGhaTnBU?=
 =?utf-8?B?MG5YTlBBRWdNcDN0U0VwYTA0aVBkckZ4U2pxdk9wZURsZUtZbE5FWUtOdkVt?=
 =?utf-8?B?eFhKNXBvOStXZUtGN250S0xhcnhpN09xeFhGS0JCc2NHUWdlZzZCanBXYmpI?=
 =?utf-8?B?NlN1Nng0YUZzdis0aElITURXNlBFRng1eGxXNnZiOVozbXNVZW1TVmRjcisw?=
 =?utf-8?B?Skxxd1dMNWRxZkxVZkNJRWkzWUlZSWVENVB1Y3RYdTl6S2hMQk5nSmNBeW4w?=
 =?utf-8?B?Tk5vWmFDQ2VhWWZ4UWI5Tzh3Tng1Q1RlbGRhUW5FSWlqaWZid09HOWZCTHkv?=
 =?utf-8?B?R0VmYnpFbjBCenJnQzlBdlBOWXB6MzdMdTNhdE8wNHgrQmN2cDhKZmtMM2h2?=
 =?utf-8?B?N3VFTGpFeEJkdG4wVkFTeFRlaDNib2hMem4yaWZoZlBYbTRUZnRoNDM4dVI2?=
 =?utf-8?B?ZEI3ZDlUWWhpWlkvRXFIVjZEWWpvQjducWx0TUtGcTVha3NWdnVhazF2WW1K?=
 =?utf-8?B?YUhPQWQyM0EyelNNd252TllPL1o5OXR1dERicGl6djE4WTBxTXZjY2lWRHRL?=
 =?utf-8?B?MUNCNjIvMXNSTFNVeXI3a2F1SUNkNEU5MURTaUI3YkZGQ3VkQ0ZJM2xiM2h3?=
 =?utf-8?B?eVQxbzk0NHhOOVBTRkVlR1NjWER5cEdSWFNwOUlKcGZqaHh1YklwTWw0bVRt?=
 =?utf-8?B?Q3FZTkxKUW9yb01SVHBhTHNpNHRVWlEyeTllY3RCYVpGd3R3UlNmVkJQRUk5?=
 =?utf-8?B?djNEY2Z1ZjZlNW93UXk0Z1RmNEdTTXhFMGxiYlZTemNRV0RxNWZwWFpoNVM4?=
 =?utf-8?B?VStiR3ZzWDU4RnYzNTFVdy9LZy92RUg2Mml4NERCK0xPVHBxRTZTaVJucXE4?=
 =?utf-8?B?VzB3TTBleTk0U044WWc2bGFtUE1ZVkJWclNubDh6OEZlWUlFbndQbmRveGFi?=
 =?utf-8?B?RlZ1Rjc2YUVDN0dtYmFBSUN3SWlRM2UvYi9HM0FITWsyOVRINER3cEYva2J6?=
 =?utf-8?B?VnFScTQ0THZPZSthWjd3QWw5NXVqbDkrREhzYjIzY1AwcU9hTDBGWG1JUmpy?=
 =?utf-8?B?ZXpMYWNsUnluMmxidjVVU1pLWWpRODhpNTN2NTlrZnBZUWRzTU5ncjUrcTZq?=
 =?utf-8?B?TzVLbHYzaXR4WFFFSG5tcW1nZHRoOU9zNVRZODdxVWZpQXNjSEd2NkFPSjNI?=
 =?utf-8?B?cWlSU0hrU0RzZWdaZDdnd21zR2U0L1h1cTBiY0NIbkUzOFFXWUdqVjFnQ1lP?=
 =?utf-8?B?L1czMllEKzV2OXRBc3JCMFdiNzFabWlUbUw0dEp1TmlnMVlvOUUvUjQvWXdI?=
 =?utf-8?B?MEpHZjBadUMyUDhLVVZlZHovaHRTaXRQa0dzSkppVmZHMlBKVXhSWXlOQTFx?=
 =?utf-8?B?RXZ5VmpraHpKUXJzcG5LUC8wbHVVWmR1ZUtyZWY0Q1VmdXhucXljQXlEczJR?=
 =?utf-8?B?dkJhMy9hajVEYmYwLytWY290QlZ6SUFJb2JoWERLdyt5b2dYY3Vpc3pTcEJh?=
 =?utf-8?B?c0JURit3RnBEaFJzOU9kQnFUUmY2VWNHTUd0RjJrV25oZDYvd0RBaE1DZ04v?=
 =?utf-8?B?RGlEMGdnb1ExSjYzNFNjRms3NUcwdkk4b1FhYXNOU3ZPWnc3aGxIZ09LM2xQ?=
 =?utf-8?B?UlpPdjZ2SjlpbzRQYzRLaWZWV1NFbDl6SXpyY0s5Nkg2dzhNTUlRdEIvZmVp?=
 =?utf-8?B?RmxhUlVjNitjRXZpZUhYMllndHVWZlErOHhnY1BDNXhkOHdjc3RoOXFBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SmxmdHkvZmNJYWxzSlZSb0hwNE5GZmZsd0I1Q2JGN2lEZHhSWDFlVFBIQnRV?=
 =?utf-8?B?NExlN09sU2Fwd3JqWjcxNWhPdjE2aXVPdFdRMGN3L1MzTm1kT2pKL2VmWWZr?=
 =?utf-8?B?M0xmYmw0bDNiS2oxb2pLTmhaRXFySWJMY3dwWjUyeEExQk9BVWJ3dytjSVZZ?=
 =?utf-8?B?SXozRmVrMkZRMys5MmpqUjJKVWlETUEvQ2dqZVZSNldOcTRJNm5zbnlFdXpi?=
 =?utf-8?B?QVdDY0VBeG9SV0w3OVBRSGdSYVBwc3FPdHk3NHRidkhTZ3NsL3pWWDUvbVkr?=
 =?utf-8?B?T3Y0WWtVdWZnR3FlUFN1ekR2WnhIK240STRPRjFvT1B0YkIyL1E3Sm4yVjhx?=
 =?utf-8?B?Q3QzcUh3Sm80aUc2OHhPOGdkSjFIM3hjWE9nazhUSHo3N0xZd1NmVkg1ZWhh?=
 =?utf-8?B?U0Nhd0w3NjJvVUl6Uk9IZC82OGhqeTBhdEE3OGdGWi9uQ0pjd0ZNNXVWMldB?=
 =?utf-8?B?bGF4UzNLY3dxWFNmQ0JLYkpncE85MGl5NG5BQkZlRFE2VmpqeGNORGRBVkdl?=
 =?utf-8?B?THV0WnZ0SzhQYVRmckhpTHB5eXAwMWduanVjdXV0ejBjalhadC9YVjF5V3V4?=
 =?utf-8?B?a3VlUXVRb1hweFhVejF5SUxiMkR5NWl1UTJIR25qaFpsNjk3L2JRaUU1L3po?=
 =?utf-8?B?YzdZZzNlT3hGbG1WbmFlN3VtNDhlcFhkUUZxVGIyZTNKOURhZXpSR2VaZ1J2?=
 =?utf-8?B?U0ZISitzVVdmSVlBdjZLMzUycFNXeXBnaVEzZEVkU242bzBXeG9CYW9PTEs2?=
 =?utf-8?B?emZLcHd1TXNCT25TRk5TcitMU2U4cTltaDV3YlMrSkNCUS9GRk9wTTVRR3Ju?=
 =?utf-8?B?K2lQc1dDc2c2OWkvWUIrdFdvZDZOeUFPeTl0ZTNYQVl3bFlCTnpGTFJ3OWR1?=
 =?utf-8?B?aW5sNW5jTU9oUHBpeHlXeEhUdXZ4YkM4VHVNUEMyaXhHV2dIQTNJdWgzQ2RO?=
 =?utf-8?B?UEVvUFdnVEgvTFpJcWMrdytSN05sYVVhZFpHZnY0T1B5MjNMTmFrT0dkbHYy?=
 =?utf-8?B?OEowTHl0YUJyL211UzVOaUsxcmt3U1JYR2x1NVlpVktvd29WU2ZpVndqbkRO?=
 =?utf-8?B?VlV4emcyekpSanFIL3ordlA4Nk5pdzhibE8zVDlXTnVPMkp3aXM3akQ4OVpQ?=
 =?utf-8?B?TTlRNW9CQjVTYlJ5OTM2SlJNMnNpb2t2b000OEozQ21pNjFleVR6a1dhOE10?=
 =?utf-8?B?eWdneG1qK1BQWFQrbVFzdUtRT2tDMVZNMEQ3YmV4QmJrM2JvNnhUemQ3Lzd4?=
 =?utf-8?B?cFFidE84TzVMcmVUSGxPMDdOa3lINjlMUkQ1TDFMSWFrVnZWZFJ1SFZ0ZXIy?=
 =?utf-8?B?K1VoUjJ4U0ZHT1k1MTZzZlpiUTk0a0ZkcE1DRExaMTdIKysrUU5EQURsV0FK?=
 =?utf-8?B?Q2tzVjdZMDh6cXRrWFFHVlNybzNrSFFYM0FQSTVMeSt3MnlMcXBGN2t6ZzRM?=
 =?utf-8?B?Mktoa0tpaUZIa3djSnIvWlI1eHY2RVlZQ2pxemF4bWh3Q3UyN25Zc0RGNHcx?=
 =?utf-8?B?SWhNeW82cUE0eGs2akVYbk1nQjY3VTlEcmlwR2ZkdjVMcURBWFRDYXhISGk5?=
 =?utf-8?B?bExCTWo0a1JSMjNicHI2R3laVmlPa1BtQUp0L2RvQ2l3UC91LzhvbTloN1Iw?=
 =?utf-8?B?alpTRlloeUcyNktGZW1EMS9uY3U1Wjg3MTNqYW95VFZJMllvdWhGcjdBSTF0?=
 =?utf-8?B?dERMSWZySVc2ZHFqZWx2cWJHOXNBZ3FtTjFFWUpUWGZ5TnlPQkd3OW1WRGV0?=
 =?utf-8?B?Z1ZEYkRKZktjL1pyaUovZzlGMlVqNTVLWGtyUmdPNE9sdWp2TmZpbnp0cHFG?=
 =?utf-8?B?eGRKMHJPTHZoQ0RKZjlIR2R3V0dKMmpkVlB0S2JCWWhHS05RWjk2V2Rzd2Rx?=
 =?utf-8?B?ZUxMMGJLVGIwVEluenNRSW9LMmY4UnhqVHhiY1J1cjJQcU1zWVpPUXZCc0pF?=
 =?utf-8?B?UlpzRnVPMDcxM0NqMEdrbzJ4Z0hCaFkwWUg0K1BQY1o2WlkwVng2TmUwcDBQ?=
 =?utf-8?B?ZWZkQ0pRTVBDaDFHbUZBLzIvNW43eHlDN0V2dlYvR1NhSEJEbHFVWFVGN21P?=
 =?utf-8?B?WjJ4S2JtM1A4bmliY09QUDRTc1V0TEpmRkhmQVBGN3lVenloRm01SUxqb3dy?=
 =?utf-8?Q?3FECPEoXbFj0sQ7M9Lv5sv6Zu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f24d4882-7533-4dd2-cabf-08dc83df0438
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 15:08:25.2727 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZeMSC7dNaDix/4fBe5IG+SEP5So5DHK/mzy01STL+aaQzel2tV9HUTB55vWbtBV/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4065
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



On 6/3/24 16:50, Lukas Funke wrote:
> On 03.06.2024 16:32, Michal Simek wrote:
>>
>>
>> On 6/3/24 15:34, lukas.funke-oss@weidmueller.com wrote:
>>> From: Lukas Funke <lukas.funke@weidmueller.com>
>>>
>>> This commit enables SPL to reset the CPU via PMU-firmware. The usual
>>> reset mechanism requires bl31 to be loaded which may not be the case in
>>> SPL.
>>>
>>> Signed-off-by: Lukas Funke <lukas.funke@weidmueller.com>
>>> ---
>>>
>>>   board/xilinx/zynqmp/zynqmp.c | 9 +++++++++
>>>   1 file changed, 9 insertions(+)
>>>
>>> diff --git a/board/xilinx/zynqmp/zynqmp.c b/board/xilinx/zynqmp/zynqmp.c
>>> index 95a134b972d..99f5c178c1d 100644
>>> --- a/board/xilinx/zynqmp/zynqmp.c
>>> +++ b/board/xilinx/zynqmp/zynqmp.c
>>> @@ -40,6 +40,7 @@
>>>   #include <linux/bitops.h>
>>>   #include <linux/delay.h>
>>>   #include <linux/sizes.h>
>>> +#include <dt-bindings/reset/xlnx-zynqmp-resets.h>
>>>   #include "../common/board.h"
>>>   #include "pm_cfg_obj.h"
>>> @@ -285,6 +286,14 @@ int dram_init(void)
>>>   #if !CONFIG_IS_ENABLED(SYSRESET)
>>>   void reset_cpu(void)
>>>   {
>>> +    if (!CONFIG_IS_ENABLED(ZYNQMP_FIRMWARE)) {
>>> +        log_warning("reset failed: ZYNQMP_FIRMWARE disabled");
>>> +        return;
>>> +    }
>>> +
>>> +    xilinx_pm_request(PM_RESET_ASSERT,
>>> +              ZYNQMP_PM_RESET_START + ZYNQMP_RESET_SOFT,
>>> +              PM_RESET_ACTION_ASSERT, 0, 0, NULL);
>>
>> If you disable ZYNQMP_FIRMWARE xilinx_pm_request() should fail.
>>
>> we should likely fix it in drivers/mmc/zynq_sdhci.c:114
> 
> That's an odd place for a default implementation. I'd like to move the functions 
> to a common location but I've no idea where. That's probably why the last 
> developer moved it here. Any suggestions?

static inline to include/zynqmp_firmware.h?

M
