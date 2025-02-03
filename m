Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46642C02193
	for <u-boot@archiver.kernel.org>; Mon,  3 Feb 2025 08:01:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 83D9E801DE;
	Mon,  3 Feb 2025 09:01:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uSR+P5qL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 886DF80214; Mon,  3 Feb 2025 09:01:19 +0100 (CET)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20605.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2413::605])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B5106801BE
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 09:01:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CO6eBgoPaL2ho0vLN7nsYzwEa3vPgAAwywzWejLN3CDdlEhZ8qi9cEG9OfFGRloXrnKh4hL8uR4Dfrtn2pNRFtzB/4uTyznUhJZPbb4JmRn1Gh2a5TEz3PVgSkD7ACPpqNme4BjM9Q5rliNX2iCitC/axg5cdkWLYeWCdM6CC//D+KoHB1EOUbKLfv6Sc/sPlrNfereTZU/ZHK+CsmStODpSvLp9tfqp+2qKRZhwkQmqtKZe4iLqRj1VEpQsIB0Jg54OROk0Djj4rvNpsz9ViXDHvL859Yex4iI3yqAUD8adOD/ukdRnW1Vk0+ULYOhssju4/xwNpkJUc+5ZUP3K3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8T1Krs/WDlYFGiQnnP5/Pul0EnaKjWhpFipmufq7YPI=;
 b=LXF5ByJ9ohR0ST9TgdaqcqEx+tr5jmMDvsDG+5TXknDkToyKiHYhyk3PybNrhK+H92ZwyuiCyNHUQAi6ThdTAXZskcAI8+mSEnvmBqVB+6aRBxiz7aA/SP5XbdcVtxS6OWtrf1UAIN2lol+EZbeVqL0SKWlqY4Q0QnK7oRaIWv3hR3aIzGLiiFIFCtBNrq7nYbbVhMj9EpGRwjuhCYo9gvQHzfGeIMJo2JlnHXMJETIHAowLwvTGR4YSpc0hdpKuw5rCvJ4iEL+JQZ2J0BlJVwFRjyqyBb+DuV5lr42mlcdA1jKS0P8pVOv3NNsZ2N7CPN8y0uf3m12mhVl8tZSjUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8T1Krs/WDlYFGiQnnP5/Pul0EnaKjWhpFipmufq7YPI=;
 b=uSR+P5qL/ypHNvziG+pb1t7Wq/eI3FiUgmqisBFxRbB/BZpztCbVs7Tiln815rIhTBxUQndAVdAN+SNmeYpNMovk8151RaIZ7PaoFSmHSn6P7hiRPT+tgUAIhKCoe69C3EzDGQcVnrqBM7JHp2Ulgbsh2tM3l6xsp3RsvLYBQ7g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by PH7PR12MB7794.namprd12.prod.outlook.com (2603:10b6:510:276::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Mon, 3 Feb
 2025 08:01:13 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%3]) with mapi id 15.20.8398.021; Mon, 3 Feb 2025
 08:01:12 +0000
Message-ID: <118d7b2a-2550-4795-8b93-50c92f5fb8cc@amd.com>
Date: Mon, 3 Feb 2025 09:01:04 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] zynqmp: Dynamic setting mmcdev and mmcroot
To: egyszeregy@freemail.hu, u-boot@lists.denx.de
Cc: love.kumar@amd.com
References: <20250201140611.1798-1-egyszeregy@freemail.hu>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20250201140611.1798-1-egyszeregy@freemail.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR07CA0268.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::35) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|PH7PR12MB7794:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b18ec38-8ec7-4cc2-1e8f-08dd4428ed44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dTY3TGdvUzd2QVdidTBtZDlqY3F5alhUVjVxSzBsOGhnNHNpOFBKOUdyTjAv?=
 =?utf-8?B?R1BReG5aLzVOVzZxQVp2cEZZUk9xTExPd0xkYW1zU0RwTUpjTTdwOWxIeDl0?=
 =?utf-8?B?bS9DSjhjTWdZUHZDdk0yTjZFL2hHdWxrMExsVWxPaFN4WmxtZWtiL0wvNUFT?=
 =?utf-8?B?aHVDc1RxT0NqVGhKckQ4RjVVM3NQcEVpOTUwUkR1eGhZRDhpemM5VGF3dURm?=
 =?utf-8?B?bktnMmR4QWhOSkZaVEx4RWJqSENiNlJrV3grZVZyZTVXNEw1WXoybVpKWjNX?=
 =?utf-8?B?OWFCWC9jbFlPYnl2U25aNkhIWXF4Sm5xWlhFNHV6bERZRnVWcEo0eTQvbGlX?=
 =?utf-8?B?TnR2YzQ2cGNVWTlTV25ZcVh3cmxUY3V3aWl2bUZyVHBXVmxoc29MQXdSWFpR?=
 =?utf-8?B?TmJsVFVoUS8zRVAwb0FlcUxRY051OVJxbk5nOEJubGhBSTRpYWIxNWdBY2xu?=
 =?utf-8?B?QlJSV3kyYUJCbW53REs4enRlZ2ZSbGx3KzlnbWZWcTdyUHlZajlmWEFnT3JY?=
 =?utf-8?B?V01Hbk54SVlJSXYzZFJaZGZTVWl4Y2ZkTmk1aTJSSEVOaDZhVzc0NStEUVVX?=
 =?utf-8?B?dHRpTUQ4TmJxSVBwN2cxNElrT2dIVnhDMk9rSXNXbytyRDZrQjRaVEdKSisw?=
 =?utf-8?B?QmFyMHl5UHpCVmhJVmtBRHAxOWIrR0dIb2xjL1RZWkpnd0Yvc1ZaeHBUR1U3?=
 =?utf-8?B?bk15bkZsQnoyU2psTitkb1kxRjhhejBub1ZSTnRrMEFoTSswS1R3UHlRWmJF?=
 =?utf-8?B?Wll0YVZydS9FaHlzck1XQ3pDK0gyUGNPblUwVnJjZFRUbGVrRXprU0hhZHpV?=
 =?utf-8?B?ZldiTE13ZWFWOW1WK3pCcHFpM0pXNUNDRHAzZnpCakdia3VVd1JIRFMrZGg2?=
 =?utf-8?B?eklIdDJCeUtNRVFQUzgzT1Q2cTY5VjVNL3cwc1E2Nnh5Y2lQYnUyR3FheHZo?=
 =?utf-8?B?b1ZwM21iMXVJU0FpR1N3bi9pTXlXWWhlMUlUMnhZdjcxU1U0VnphYXFEVXJW?=
 =?utf-8?B?cTNwR3V3Y2pXb3NFa3FWVjJLSUVUY29UZVdxc2Q3ZE13Ujh0NFRMditwVHVW?=
 =?utf-8?B?L1dkRUNoaG1OK1d4WGRyOHA4Uzg4SWZKYThtbGJVcWJwbjNrZ1NJN1F3Z2dP?=
 =?utf-8?B?ZUM0blJHL1FqdmY0UEl3NWladWs5Y0VUMDNqaE1FSE1XM1hlSTk1cG8xT3lP?=
 =?utf-8?B?K1cwNlpCOHdsKzdLMzJibnR4VGM0SXY3QS9XNzRLU0QzalRFUWQ3Nmovd1U4?=
 =?utf-8?B?dnFRQzRCWUlubVRUOVR0TzFoUlRJeTN0c05MZ05pUUtZd29aMXNPekNMNnRi?=
 =?utf-8?B?ZjNNeDVQUFlTa0pyMGJBTGErT2djVlREbjA4NjBtVXBVclcveURvU0hDTmdD?=
 =?utf-8?B?aW5WK0tETXRaY2pYSnpIdFhEazVWZFhRK3dqUTZvM0Z3S0dwM1hhbnYwbHI4?=
 =?utf-8?B?b25RVjdkZUVWRDRMWHp6NFNRVDFJQThPZ2NIUmJ4bmpVbmFoM1RqWS8zMVBE?=
 =?utf-8?B?bVRLSmVYV3FqQjY5czRpMVBoRWgwaDZiNkJyekxEdjgzYjV6UjNTb2s0UEE5?=
 =?utf-8?B?SzVzNDd5aEFZbm84OXdQejJkdnQyS01wOVlOTGxxeXY0M3RmQmpxaC9nYWhl?=
 =?utf-8?B?V2J3K0liWkhLTmJlSjM1NzhZRnRDVjJmTXd4Z1kwbDU3VXRmR1N4K0JvNFNw?=
 =?utf-8?B?Q2JYa2FmNm5jU1h0aGxCaWZwK09hanQ4VVU4WjBQNDRQU3kwZGJMMjVGSDVi?=
 =?utf-8?B?a09Ua0VMRll4eGZCc2czSmlybDJ2cHlIeXRsVkdOTWxvTzBsOWRRaElLSTdO?=
 =?utf-8?B?Z2U2VlhuQU5CeEVpOWY2WUREZTFUL29LbkEzTGNEcWNKMCtSMTRZK1UyUUdK?=
 =?utf-8?Q?GbIzUi8ZuOu3a?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUt5a2dWT3NBSVBOcXM0RlJpQmc0dTA3aHljYVNRQ1dWa1V5TkdSWldUeVBM?=
 =?utf-8?B?OGl3N2JDR2ZmdGh4N1dwNDZBcnFMOGxRUHJVZmo4SlRkelA2TDR2b0ZBazRH?=
 =?utf-8?B?NlFqZjBUbVd1Z0l1NGsybkh4VzlKRjhHNFh3RWU4ZVVFOTJZY0wvU1hndjMv?=
 =?utf-8?B?N014RUVmRzl5TXRJR0tWNXlQQlNxMm1WeGFSWEdjSkZhbUZGTTFJalM4VFpU?=
 =?utf-8?B?OUVROS9uNVJ6Unp6cmZoOEdzQW9yRWpkM2cyU3JHWXZaVldvbHVHcEJJZHFI?=
 =?utf-8?B?VTYxR0xLa3I2N0E0ZjZ2VzR5VGNSRXJlc1FCUm4vNVM3NUNNU1RVMVEvOXdy?=
 =?utf-8?B?ZWN5WE5iN1VLZkEyK3dCRXh1azZ0YnpZZWdaa1VpK1hsNmZja1plSFl0NHBv?=
 =?utf-8?B?VS9td1R0aFVjdjVsQk43OTQvSU84TldBZ2tsaEJSblJZQSttWkFxZFpJYjJM?=
 =?utf-8?B?dkVjeDE5c3BlZXZBQUk3enRNbDd3SDk2SUJ0cFV2Qlh1c1kxNzN0QnNqQUQ5?=
 =?utf-8?B?Vm5tcFZibno4dkpRc2R4eUdYbHBHamVtUDlBdGYwWGt1Q0xwTURqV1JOUlVM?=
 =?utf-8?B?aTZNMTFBaGYzWUJVUXhsUmE1cGpSdW9naGJSaWZoWW9ZSFllU3BrdGtlL1JR?=
 =?utf-8?B?Sy81UU9UUXRmVkxtOEVaZ1JNcnAyc3FjeS9FMDUzMGFFRmRuaGgxMDkzeWQ0?=
 =?utf-8?B?aEVZN3p5VHZTTEZrSXFEWHNCM3hHdlVqWC9OVVA2b0liczFqQWZHYy85VkFO?=
 =?utf-8?B?R1V1Vk11YVhuS3UzV1lKa0pYUGZ3TFFuWUFMeXFOcmEzYnJaVm9nV3ZKZDEw?=
 =?utf-8?B?RzE2eG5nSVd5V1F4dHhHWnFxU2pXOHltVmoxT1FucVZoYlhvNzB4elUvNWZa?=
 =?utf-8?B?djc1S0NqeXZrU0N2NHZNZnRROG1GWjhIRWtOUlZtVE0zK1pqRWpxbGRyOEda?=
 =?utf-8?B?cTZiQXFsZzBYNVdVSkp1NGJwTmRJdlExZVJub3lkcy92M1FuYnZaNndOUlNK?=
 =?utf-8?B?WmFKNFVjNlZvSDgzMnR5YlZnNWZLdURqSjhPS2pMLzhEdnA1WEgzNis1K1BG?=
 =?utf-8?B?Y3I1dXE3WlNxN2E1MHZMRWFVaFdkeUFKOW9Ka2lkODRFbDZNS2xFWUxKZ1NV?=
 =?utf-8?B?dmo3UWJ4OUtRVW9PaFNUVVkxSHpkK2lJYlhWajdxcFBER1Q4MHNZTzc3dGQv?=
 =?utf-8?B?ejh6U3N1dFhFRnpXd2h5NFRMakd0RGVVT1NtNStkYzZNSE52WFBNMWxUR0p1?=
 =?utf-8?B?T0QvQ1NxdW13d1NTSXJwN2ZVZXNYWVdkNk9NMTZXdzFGVDNIbnhsTC9CS3Rv?=
 =?utf-8?B?aWRZZElFL2RoY0ZVQlJMT29qdmxlSW0wSmlITXpUdm9xRkRrQVg5bDA1T0pS?=
 =?utf-8?B?emljaTR5U0I4UjUvemVmejJBM3NsT004ZDB5UFFEaVBmN2pzdWRvajM4R2Fx?=
 =?utf-8?B?aURZUkxVcFBocy9paDhuZ0NCMjV1eEZReTBFc1hLZGMrZnFXdXJxN0c2SWdV?=
 =?utf-8?B?Z2lNT0ZpTUwwWDhiMVlPd2xnczFrcU16bGZnNUNhVU9iOFRTV0pKZStMNjdF?=
 =?utf-8?B?NlFGczlrQlVZb21FYXh6NVVKMGFNMVU4dHRydUpXZGFnckk3KzVQUksyQi90?=
 =?utf-8?B?d0phQnhraDhKeXE3aWYzL0xadUx2RnV6QU1vTEgvV0JQOUhiV09ZTjdXT3Ju?=
 =?utf-8?B?T1BFT1ExcTRMRUVkK09WNjZhNmdGazdsRUV2NTJyZ05oKzZmbTNFUkpzSlcx?=
 =?utf-8?B?TFV4Z25UVUpKUUg1cVJGdDJ2U1lkRFVVTzgxR2ZFR0lTalBOem9JMnFEdG5i?=
 =?utf-8?B?VHZEYlBOV0JmbzF4eGRBT2hDRnI3TmxlSjUxeDFwQ0VEcTd2L0o1TnNVbXEv?=
 =?utf-8?B?Z2tOaGovZEo2TmhkZ29hcEtYSy9ISVdVQm9LY1FkUTd5WlNaZWNFK3BTSkVK?=
 =?utf-8?B?TWxWY2lGQ1lUdHkwTFJpYU5yKzlXVkZvSVJ6eWpIRElsZVZWUzVITmpPTSs4?=
 =?utf-8?B?UjJCRFl2eUd5ZHAzbkVJZGUrQitTSkpqN3FndjY5MXd5Q0t5L3llR2FmRVFF?=
 =?utf-8?B?REhaa3Z1VDF3NlU4VHpSRkJFdnl2clAvN0dXNlFQRkNFWVlDSERvZ2loaHp5?=
 =?utf-8?Q?QUECJfnQKWr5Ib+itrbcPokcA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b18ec38-8ec7-4cc2-1e8f-08dd4428ed44
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2025 08:01:12.8900 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lFhUvNg8hXGqbZ34ZKOZsulAmk4b9OhQYC9ZX2MOuWCqhw3OpozkPZaE51AAlud2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7794
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

Hi,

On 2/1/25 15:06, egyszeregy@freemail.hu wrote:
> From: Benjamin Szőke <egyszeregy@freemail.hu>
> 
> Dynamic setting mmcdev and mmcroot.
> Then when boot linux, we can have correct "root=/dev/mmcblk[x]p2"

This is source of the problem. That root partition is second is only your choice 
and doesn't need to be choice for others.

There is no reason to write this logic to C code.

We are exporting variable bootseq which you can use to determine which 
controller was used by boot device and can be used for rootfs.

Here is how you can compose your bootargs.

ZynqMP> setenv bootseq 50
ZynqMP> setenv bootargs root=/dev/mmcblk${bootseq}p2
ZynqMP> pri bootargs
bootargs=root=/dev/mmcblk50p2

Or you should look at devnum which is setup when mmc boot is called.

bootcmd_mmc0=devnum=0; run mmc_boot
bootcmd_mmc1=devnum=1; run mmc_boot

Thanks,
Michal
