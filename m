Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9106AC7EE31
	for <u-boot@archiver.kernel.org>; Fri, 27 Jun 2025 09:35:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0BF9182E52;
	Fri, 27 Jun 2025 11:35:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3InJF3oq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A17A82E9A; Fri, 27 Jun 2025 11:35:09 +0200 (CEST)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20609.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::609])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 41D7D82E35
 for <u-boot@lists.denx.de>; Fri, 27 Jun 2025 11:35:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WIBisymls1jQlyZY6ZJi8sAJ3k8M06BMa1O0qCxKwpnhEaYgKbZ6pKaXnfmp4oKp8eK9t2w1KXaPU96zhFeO2y2Jd/ako3ATkl4llys02Elby7uvu4jy5b6E78/r7cCQTUiL+nOp03iCH0wDR6+ZLJNJ8OrypaI1/KI6YSIdWTdqSqTVe8JbDo+X5n6hcTtzyhAtcfF2U2eURnua7r5JKD/e3me651jwACQFa8x4d/pkqCBiGX+IgY3h1BbtdbN5MD8UfiQLN429cp024KMCeCCmlm3kunmLHsVOf8rDBERwXrYmyICpWnmCZVyzEmHHh8sNV4zQFktyFiNiaV216g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x3CFs+U25V/bx5ytsomeRIhdvk6v6XMVhhRYGkdo8iA=;
 b=mFxoaQHQ7fJReAojuOGS9X6pNXsrzMh2rPGpuB2RKW7beKpLDdBKqEKX26lgIsK2SrsHXaEH0Bfcc5dzr9WqhwpE4afNtc0jjFUMBYYqOSdcI2/dMChq9hoj68RuOHpwQYr7Dqe4ybfhtPMv1+PsVGjz/6EE1vBqlZ0ML6bC7lJ9FPThkCpIh9Dl9Wcy+mCs8nx4lr9MhvA3OcYbYy2ClB4q4sDONJw0WxA1uBsZNtDVKVrBNNquchbRYOvV+r1WibxZVdYEV2E3++bQU9lpKmuT7nwXRv1MQaJ7Ry1LYSSPMDhh/ylfEyx19t4redgzYowl5H7P73WPtqcKKG6AJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x3CFs+U25V/bx5ytsomeRIhdvk6v6XMVhhRYGkdo8iA=;
 b=3InJF3oqU2cUTELpjss+yqyMkVk9B0jzg4SKAQm5pRWP+FUR5WeBFfQ95HRBUwnWmnSONjOmFo7ZB1q4ziOfPyNx8dD/x7ev86zWFp3z6nvWb0SVfGQSZRr93V2ZdDAZGTuyHp5j38aDo1kE4X3vyK+RQIOZBrliHfwzvhC+UqY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by SJ2PR12MB8848.namprd12.prod.outlook.com (2603:10b6:a03:537::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Fri, 27 Jun
 2025 09:35:00 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%7]) with mapi id 15.20.8880.021; Fri, 27 Jun 2025
 09:35:00 +0000
Message-ID: <06b1c855-67a5-40dd-9b08-b01c3f58ef5e@amd.com>
Date: Fri, 27 Jun 2025 11:34:57 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: zynqmp: Add support for dpll clock source
To: Padmarao Begari <padmarao.begari@amd.com>, u-boot@lists.denx.de
Cc: git@amd.com
References: <20250618094329.296731-1-padmarao.begari@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20250618094329.296731-1-padmarao.begari@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR20CA0003.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::16) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|SJ2PR12MB8848:EE_
X-MS-Office365-Filtering-Correlation-Id: 36ad2a83-1f6b-41e8-5997-08ddb55de313
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZUlnN3JkWGNKdjhMRzIxcSswWkowakw2VTUrYUM2TTZhbFlLLzBQZnNBeEF1?=
 =?utf-8?B?WWlWY0RiTVdaS0VxQXduS0RKcHZ2bDgwbXU2TW83S0QxeGE5SG1PSkpFUzRC?=
 =?utf-8?B?cm5BekFJdnlZMCtQVUJLSjJWelBHMHRmenFCVVN6bnBZMnZCb2JGTGVrVG90?=
 =?utf-8?B?Q2J6TEdra1hFRUI0QzZFMDBUbDZrZzR3S21BcmF6ODhldWs5ZFAyUjJqWEhP?=
 =?utf-8?B?STQ1bFozdHJ6STErQThVSlpBcmRCYXVIcytheGFPV3RQdVVjV3RncTRrNEF1?=
 =?utf-8?B?NXY1TU5nNnF6NVlVM004dm9nZzA0ME9jQVZqNlpSa3lJUmN0Sk11WGVTTW5L?=
 =?utf-8?B?ZWM0NFFOODBpRkVZNlYvRDZ3alIvbzhjdDF1V3BVdjRNZ1FqRGNUTHlKNm5T?=
 =?utf-8?B?VDVNcEs5VkJZdmM4T1B0ZnIyOWlmMkt0TXlmS0pHeEdJeWxGbFJUclVwNEVz?=
 =?utf-8?B?OTQ4WUIvdUdwVWFBNW1LeEl6WGwwalkwT2FGTXBJTmFNOXIzaTB1TXdMK1VB?=
 =?utf-8?B?VDQxTDV3WFJzUlVwcVBkdmlYQ20vVDR0Z0p0b2sraFpsYjlxZlpCUHlJNFRz?=
 =?utf-8?B?cUdSY3FieW9sUkJBWjZUWXpqL0ExNzlqTkxzTmV3WnN5ZXRPNGRxR0FsN2s2?=
 =?utf-8?B?eURUeklPb1JCUDNFUWpWRjBqRWpYdzloNktVbzZQQmJvR2ZkNFdsK3gwcFVS?=
 =?utf-8?B?WVdEVXgwaDQ0QUxudisvTnpMOG9RQ29mZUtOck9scUZVaGtMSWN5TjF0SmFX?=
 =?utf-8?B?YkNGQU82WW9EbXFHbytPTTFSWEg3eTRKOEFPNTk4ZHhUNVY2K0hzNGl0aDZz?=
 =?utf-8?B?YWVWNkJDdFp4STE5S2JGNDFTOHMxMVo3YmJsQm9WdHkvaDhRWnJxZ2sraGRt?=
 =?utf-8?B?a0xENmxid0psK2xQOTBreUM5R1MvcW5VNWZHMzFib1NTWjFvSE0wZWRld2hq?=
 =?utf-8?B?UXFVSlo2ek1pV2ZPTExpS1dTNDRRNUxpTFdudktiTUhKYmlNQko2eExGMkc5?=
 =?utf-8?B?MXFvT3crQlU0QnptQ21paUZLdGJUWC9Eb2ZENkxvUCs2OHc5Y1ZIbzdWRWJD?=
 =?utf-8?B?Wm90K1VLdWVsTVo2SUFBTHlhKzZTRWZGMjhvTmxoUVFWMXA5aGJaNHVtTUdi?=
 =?utf-8?B?SUE4emVLZ2JQVkJ1U000K241T0E4VXBqVy9Ya0liMXpCS2R1MnpDUEN0NXo4?=
 =?utf-8?B?OGVsVFFHcHA5MS82dmxxaDgrbHZGbEo2a08zTkZSOW10VExkNUJlM2sza2JD?=
 =?utf-8?B?ZE9wRG9mYVM1RDJuVmova09ac3g4TWRFQms2c0cvcHBsamwrcE5SeVNJWGFY?=
 =?utf-8?B?ZlNoWjdEM296c1p0YUdZc2lrTXN5TGw4QVh1RkFBWURzN0YxUDZYL2QrRXFC?=
 =?utf-8?B?My9CZWVKL1B0OXZWNGVZeDg3ZWk2emhHeXB2ZzdLYWU2bTdMcVRJZ0VrR0RU?=
 =?utf-8?B?M2pPZVA0RWcrdDlta0Z5Wm9IM2JsY2l0NjdCOU1xWVc5NFFJWGtKR0FWRGxQ?=
 =?utf-8?B?cy9lUWxkRGJka2ZBWXZ1Z3FJSVV1Zi9KeDNTbFlRakNGdzN3WUlYZ2lsN0Jn?=
 =?utf-8?B?c0QvVi9vVkZMd1ZjcWJ1MGpmMUhiK2ZWMDZFNjQ5b0EvdW9ncFpneXhFdXFM?=
 =?utf-8?B?d04rUmpaNm9EdFFGbmVrMDBpOHc1SVVjeHBmSmN3SXMvN2tBbUZXUDBSUitJ?=
 =?utf-8?B?Wlg3MldYNWdjL0dQY0Q2L1ByNVRkTDd2VXZpckY5OFhNcFVMZnhvT0FiL1pC?=
 =?utf-8?B?RDBXUzlBeDZESllJN0I5SWdXM0NGb1hWVXdPamhnOTZRanN6NjVXTjRYSEcw?=
 =?utf-8?B?UFV0aEtWVzdTWGdtOVFwYkVFYUxyOUJyT2ZqeWNDT21BWHpzejhsV1BhOTZm?=
 =?utf-8?B?VTFsdlZwVG8wZXlnaHM5SGp3cHBETjRycFVhWkZZcm5nbldZYkNsc3NlS2Jw?=
 =?utf-8?Q?a6H8XCtLvNQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZXdmZDNQbStORld4dERkd0JMalRmU0NZb0lMQ2ViVHVGcmNxOUNQTC9sUHdt?=
 =?utf-8?B?cWRyYzcrUndZWVdyQiszcnh2TG1mZlBGclErTC9mT3Bvc0QvQlQ1RS8zUnNs?=
 =?utf-8?B?bHpsSHhSSGdzUHdJeHBJQWpsMjN1VnVlZEJPc1Y5K3dVVnZBSklsOUdqaXZy?=
 =?utf-8?B?Mmd3ZlBrVlpNRG5KMVczRG5HVUhhOW1wY1lYeFBRZnVvR2hucWdaZklPZnBu?=
 =?utf-8?B?OTVKNTJzMnQ4N0FRSG1GMEtMSExXb1RkaldHaVBOTVJlTk1QUTU3ODlNaVN5?=
 =?utf-8?B?ZFI5UTVCTERNTWJiNE1iZElqWDArYlRKeUlJdzk2cGhLU29KMDJvd1hBTXRm?=
 =?utf-8?B?Umd1M2VqRWs1Wm5pbHF2SzNmTWthWTFEelB0bDN3QkdyNThGVnNWL2tjZktB?=
 =?utf-8?B?b0tRZTVWZFNhSzU0OHhTMDltQWxoTmZHUExiRTRoeTZYbjJ2MFA2MmNaZmZp?=
 =?utf-8?B?Z2RKTEZzL1Y4Wmc0WHVwQlR1RWxudmlGckZBUXNjcVFUYTJqR25pUVJNQVVs?=
 =?utf-8?B?MUtPcStTVUtvRkZwYnBpWWY4TjM3NzAwc1ZpZTJ3SzFqZVNEcStlZW54Y1Y0?=
 =?utf-8?B?V3ozc0JRMnppb01OV1g2OVlYZWFScTJQUFlsV3hNN1p2T2w1dzdGVm9lQTdr?=
 =?utf-8?B?OTg5Ky8veWkySk5yZ1QzUjBwZUtCRFJEWGRkN0VMdkthcHdWUS9TVXVJTjZp?=
 =?utf-8?B?ZklnTDhROFo2OFBCcWprb0lPdkhVTTBVV3VFTWEzeHFCY2ViOXRnNEdMWTFI?=
 =?utf-8?B?SlFIOStHMjJLRHFhYmI4WWRzdmtJNnd2MzFHdVhkZFQ4andrQ2tJLzMrdmxk?=
 =?utf-8?B?YmozeFUvaEU4SHEySmdPOXN6VUxZN3pkaEcxZGE4NHg0UUREMUcxMDBuRmZG?=
 =?utf-8?B?b1cwSmVvZEVOdndZaG4yVHozYks5TTRHaXBmL1l3ZGhTYXR2RGoremsvY0x3?=
 =?utf-8?B?NFpXZGtpMmJMcjVZdzZQZER1anZneHlJOWFRd29MYVJsbk1kZXRrNDZaMGVs?=
 =?utf-8?B?N2Z4bExnZXNFR3pzN2g2Y2NxVENqSVhaZUJDK3NFTnYySm82OFd4SkxMZWtP?=
 =?utf-8?B?Qk1hWWhxdGFEcS9OdnNLYnlkN3paa1NwU1RUUG5PNjdObWd6cko0eUJ4THFy?=
 =?utf-8?B?T3U3bVkzUE9uZERMN20yUVhxaVBQVWRFYVdoSUJFKys1M0VuSUNMNkl1V0hV?=
 =?utf-8?B?YTlUQzh2K3pxMDdQYXBjVVFhQ1Vpd0hHSjNuNW9MclZyZGFPRmdBaGhBdjVM?=
 =?utf-8?B?eGQ1M3U0Mjdmdlc2YXhYTXBKdlprYW0zY3ViYU9wVDdWMllIcDBNQzh2TnN3?=
 =?utf-8?B?bk14YjRBaitpNENJeGxKVUZ4a0JTZzJua3d5bjYvZVVNSHNxelVKVW1XbE04?=
 =?utf-8?B?SmlKOVFNZXBpUXBsNVhzeHBjaTdzci9ZZTZwdWpUWXk3OUE3ZnVKRnhMcmxT?=
 =?utf-8?B?V3hWSHhUOG9RbWxvZDVuVWZONzRETjdzamZCOTBmUmhqRUV4cGQ0RFhydkwz?=
 =?utf-8?B?bllON3dHN0dqSm1mZCtOM2ExdlFING9WOFVRNExvU2F0cmUwcFplNEsyeE9P?=
 =?utf-8?B?d0tJZWF3aS9zNXduVXZDSGsrbHZrZExBWVN0M3FXQkJuMzBnbnc3enFjT1Zq?=
 =?utf-8?B?VEhqZC93eFZ4Y0NVTEQ2TnVRWnF5ZytLdGVYTVgxOXJrTVhzZ3hzTUpYdStx?=
 =?utf-8?B?TEQ3SDc2WWJuQTVqK2FDSW81L0xmOEdrS08rcTdERGVtQmVsbUJ6NmlvUFg3?=
 =?utf-8?B?MGtJdm5MTk9keGlIVWpUUTlHVHRqL0wrVGU3c05ETTFnTXlhRzR4aHdxVlk0?=
 =?utf-8?B?eUFYWkFQNWF3VDBaeUVwdkRBSks3dE02WUx0K3hKY0xyN3VWclpkQnYvNWNw?=
 =?utf-8?B?QXl2Vml4S2F2a2k2K1JIUUlzZkpkRVA5eTBKdXMxOXl6RkZ0S3pxRnVPdUxx?=
 =?utf-8?B?Mm4rVUttaVRiZkREakRoSTBIOE5jVDZCaUZaZTlUdTk3S2R5SWRHY1JhQkgz?=
 =?utf-8?B?Z2FGN01FT2ZWTFZkWnM0WFUrMXNOdnhNZUViZ2ZuWnEvQTZWa2NaQjdjcTdt?=
 =?utf-8?B?S3BscktUUWdnM1RlU05odldxZ2Mza2hkY3lEMWFYVkhGdndBemtLc3ZybXlH?=
 =?utf-8?Q?dhndkpa+PBVlh60PIxaT2h3la?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36ad2a83-1f6b-41e8-5997-08ddb55de313
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 09:35:00.4091 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mSe+4u+ERF8TrhiE4k5ceSoJTkY+QLsYTAAVh9nCExNfS8/bytt7fOVaRxJKYjWl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8848
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



On 6/18/25 11:43, Padmarao Begari wrote:
> The clock driver fails to correctly calculate the PLL clock
> rate for peripherals when using the DPLL as the clock source.
> The DPLL operates within the full power domain, while peripheral
> clocks reside in the low power domain. To ensure accurate PLL
> clock rate computation when the peripheral clock source is set
> to DPLL, the DPLL-to-LPD cross divisor is used.
> 
> Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
> ---
>   drivers/clk/clk_zynqmp.c | 20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/clk/clk_zynqmp.c b/drivers/clk/clk_zynqmp.c
> index a8239e228cf..4f67c958d0f 100644
> --- a/drivers/clk/clk_zynqmp.c
> +++ b/drivers/clk/clk_zynqmp.c
> @@ -108,6 +108,8 @@ static const resource_size_t zynqmp_crl_apb_clkc_base = 0xff5e0020;
>   #define PLLCTRL_POST_SRC_MASK	(0x7 << PLLCTRL_POST_SRC_SHFT)
>   #define PLLCTRL_PRE_SRC_SHFT	20
>   #define PLLCTRL_PRE_SRC_MASK	(0x7 << PLLCTRL_PRE_SRC_SHFT)
> +#define PLL_TO_LPD_DIV_SHIFT	8
> +#define PLL_TO_LPD_DIV_MASK	(0x3f << PLL_TO_LPD_DIV_SHIFT)
>   
>   #define NUM_MIO_PINS	77
>   
> @@ -334,6 +336,8 @@ static u32 zynqmp_clk_get_register(enum zynqmp_clk id)
>   		return CRF_APB_TOPSW_LSBUS_CTRL;
>   	case iopll_to_fpd:
>   		return CRL_APB_IOPLL_TO_FPD_CTRL;
> +	case dpll_to_lpd:
> +		return CRF_APB_DPLL_TO_LPD_CTRL;
>   	default:
>   		debug("Invalid clk id%d\n", id);
>   	}
> @@ -397,6 +401,22 @@ static ulong zynqmp_clk_get_pll_rate(struct zynqmp_clk_priv *priv,
>   	if (clk_ctrl & (1 << 16))
>   		freq /= 2;
>   
> +	if (id == dpll) {
> +		u32 dpll_lpd_reg, cross_div;
> +
> +		dpll_lpd_reg = zynqmp_clk_get_register(dpll_to_lpd);
> +
> +		ret = zynqmp_mmio_read(dpll_lpd_reg, &cross_div);
> +		if (ret) {
> +			printf("%s mio read fail\n", __func__);
> +			return -EIO;
> +		}
> +
> +		cross_div = (cross_div & PLL_TO_LPD_DIV_MASK) >>
> +			     PLL_TO_LPD_DIV_SHIFT;
> +		freq /= cross_div;
> +	}
> +
>   	return freq;
>   }
>   

Applied.
M
