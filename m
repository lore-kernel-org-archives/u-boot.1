Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 571DCD1CDC6
	for <u-boot@archiver.kernel.org>; Tue,  9 Dec 2025 14:58:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C15DA83A94;
	Tue,  9 Dec 2025 15:58:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0M7xc4IY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2BB483C19; Tue,  9 Dec 2025 15:58:11 +0100 (CET)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c005::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F03C8309A
 for <u-boot@lists.denx.de>; Tue,  9 Dec 2025 15:58:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wfD0sXUohH3Kq6XDhpsOsQ1CWXLmg52w+HA5mjAO3/gTKXpbhxwm+G7uIkyizGFr9+XNHE+VA3cBdXp6QdAHPC8qSDywZtetBOMfNOeGJWJ50ZB1eaLyTWW8HVN2zk6EAs2wgZNBh9crkQEIQ6O8q15BJV3fmE/72OSAwOHhMX9UT/hV7aTyZHxhUvCamGa5LHxJDPnwv/tYG6DxesDKa8xQAsN9wpap5g7KSOWBQ2Jkh9dTk6f8TWIQr05k4naLWosTFTG05ZoBoIwypSzmZAYGBC4MqrNzLpVIhriR6kWaXNkHroJL3TRyARvQHvQI2QZUbeEI0AIMmtKx7vg6Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YQIp+7SKm4+I5EFkuJsXrH5Di8+xnKz1i/F69f66hds=;
 b=olbH7GrPF4mXlD6sSGXNGso6JoVonVTOKPNU34iAe8/I3CYzIfYRZ8Nanf39E36jNzw+8IFvJFzkWQyvw+Fml1IV5TjbTZE/mgSAP0GeW7nfUhT+nI8BKN24gnFyVgSL3KJ+YJ/Lbvd2F+wANVSoPGHTapWJdr6GuCnA+V2cCWce901ZONt19X9UdIYaJ7G1gFwyy9OS+cUMUaudou6hGutEIAsZ8Tpy7xkpENdkMac7PJgT5BxRgvVpn3I/5EVrlvWHA3GwwybK2oC0WDhTVfq0I28wjSW3+Wa6WZdxhse4hPukkZItmbgAeDnUmrujORiJbziBZaZ4ZH+GL4hiqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YQIp+7SKm4+I5EFkuJsXrH5Di8+xnKz1i/F69f66hds=;
 b=0M7xc4IYcXll6xWCjflIJHBGfuOLef8mg6JD1v1iXfQm98Nw3Mbk7RtQ60DQMuaZVopX4bcyNTq76GqAqi/csDquDlmhiU/C7Uw6iY4Ia+/bg/nhIsk9JzWrQfwPzgY/EFYmWWb35Uc1EDDvCnFBjsDPLe8rAU9tB9vNkE4JTF8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by IA0PR12MB8930.namprd12.prod.outlook.com (2603:10b6:208:481::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Tue, 9 Dec
 2025 14:58:01 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.9388.003; Tue, 9 Dec 2025
 14:58:01 +0000
Message-ID: <306c06a8-f8ee-4d18-97e2-7f1d21854d6b@amd.com>
Date: Tue, 9 Dec 2025 15:57:50 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: versal2: Populate DRAM banks before page table
 size calculation
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, git@amd.com, Pranav Sanwal <pranav.sanwal@amd.com>, 
 Padmarao Begari <padmarao.begari@amd.com>,
 Prasad Kummari <prasad.kummari@amd.com>, Simon Glass <sjg@chromium.org>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <beb76794e4982085944bf167f242e6f52588dc44.1765289863.git.michal.simek@amd.com>
 <20251209144347.GX303283@bill-the-cat>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20251209144347.GX303283@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIZP296CA0006.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:2a1::7) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|IA0PR12MB8930:EE_
X-MS-Office365-Filtering-Correlation-Id: bf61864a-2f95-447c-405b-08de373358eb
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ODZtVHJYVjRHNVRkeXhGUi9PVjhCVjBsK0wrYW5qcERhemw0WFE3NEI5c1kr?=
 =?utf-8?B?T05KTzQvNTcrNTFPaDBSOVJ2Q0pReElqY2d0UEdIZXEvZWRnRVhhMjFLYkV2?=
 =?utf-8?B?NlhTeWh0NE9pQVIwb0FNTithV2s1NmliWlhwcVNydTdyak1IUGY2RXA1MWpE?=
 =?utf-8?B?Z01nQzJZQ1FGUFR0T3AyTjl2MjVpMkZCZG5jcHNHVTVVY1Y4b1V0d1ZJV3Zi?=
 =?utf-8?B?akRJcWVvUlFjSTIrRmVUUFN4UFNVWUlNQmpsWXNoazhkbVRIbmFPeFNVTjVE?=
 =?utf-8?B?Z0s0OTB1NEc0UlJya3g3K284SGdwbXJFMEd5RFJ1cnRRWW80Y2ZPYnBKZzZT?=
 =?utf-8?B?eHo1aS9LTmpvWHNPVFZJeEgxQjdIc2pSOUhtR1JVcVk3WmpWaElsMzVGTCtD?=
 =?utf-8?B?MDhWQVJVd2oxeW9ubGYvSHgzaWRneGxUNlJDdTkvak0wbkJrWW5USC84YU5T?=
 =?utf-8?B?WlRrNTVia3R5bEp1WmxiTFJMdDNENWRJSEdOSFVDa0phMDFwSXpnUzVyMVNH?=
 =?utf-8?B?N3hoVHdqYng1RnpCU2w5MUpWcXExOEdkY0JkaEJZSkJRcy9VSStaelBkWjk3?=
 =?utf-8?B?SzY2bnRsWTNRcVZaUnpNamxrV3VERWFNeUo1dE5HTzVZbkMzMndTeUxZVlkr?=
 =?utf-8?B?c0RtK1QzUDZWWkRpanVxbWNSUUZQbTc5UVh2QTBsNWpRVWVlWVRJeUJKbmlG?=
 =?utf-8?B?WjZ0bEhSUm9QNXFqY0d3QUtOdUZkNE42TzZTV1EzenN0ZnVWaklENTFZa2cv?=
 =?utf-8?B?ei9DU3BocUJrVk9SYkRKNndjQk5jamU4VTJLTDE4QkhvSVJzdEY0R08yTEMz?=
 =?utf-8?B?ZzBpVkZZa01uTnNFTmt0KzhzUjl1ZEw5bkhDeWJxc25KSFQ0L0Q1bVpDSWdW?=
 =?utf-8?B?S1NkeGxtVlBUWEo3SzJDQzVsY0JiSk52cXBXT3A5Zzc4dktlRkNVTEt0N1hs?=
 =?utf-8?B?MDVEQ2lpbVg4cmdqbDdnbGVjMzFGQWNoM1JPb2ttdkI2MGZlVjFoeHNZdkht?=
 =?utf-8?B?MnovWk52KzlEbmNXRnp6K1pSYmNWWTc0RHgxdzZNU3V2WUxGM0Q3RUdaaFZq?=
 =?utf-8?B?TkdoK1QyRzdpQisyQ2s3Um1xVDBQVGR2UmxkNmNhZzY4NkNPUFdNZ0FlOVNM?=
 =?utf-8?B?WHhTYzZleFhKVHFSdVFrV3V1OWpXd3BERm9XQTZ5S2VWMlVrdnlDb2NiVTFP?=
 =?utf-8?B?Z2o3ODVIdWQ3eTZhdFZUOHgyMFRWZzBJdXR0Y1FhRTZLSHorNlFsQk93d3oz?=
 =?utf-8?B?a3ZRblRBeWJHWmZEcnROa0gxSEdmOHFTMHAvNVE4UHlDTkwxQUxRSVlCOU1V?=
 =?utf-8?B?L1lkd2FUZWtGbWlaTDVVVmQycytBYk5TUkFpdXQvUVdUWmRsUk5vY1lsZXM3?=
 =?utf-8?B?eXQvbUpXYVpoUHNKcENMR1p5K3lkVUdDd09xaEcvYjBTM3lheVFKd1g2VVJK?=
 =?utf-8?B?bmJRS2x4aE5VMzI2VUxQT1VwaHU1Zm95Mk9IWkhaSU5rdzNJUFRacmU1S1FC?=
 =?utf-8?B?a3IvN3gvMXA1QkNGb0d1SlNuZlpaZ1h2Nm9BUjN0NjNnR2d5bjFKZjBuMndZ?=
 =?utf-8?B?aGdMek5UN1ZmWjBBbzhsZ242djA3U0FkUHFPVlVwMHA4YkFwSEtMcmxaWFky?=
 =?utf-8?B?MmFkTzhyQjFwWVgyZzByREkxZmE0RXRjTXFpTGlmYWV4OGFsbjJBUmhjNlR5?=
 =?utf-8?B?ZmVMMXJtRkFwelhUZFVTcmZYbnJKdmVlNnI4d0FRTFp1SFhBUEVLR1drb25D?=
 =?utf-8?B?ZGpyNTIrVzRJMytKajJUYkRraS82dUttaTUwaWV5SDNuQ01SNHBhY3FTM3A2?=
 =?utf-8?B?eUxjYmowYjg5aTVjZkVIOUZSU0dwK2tOcG1NdkdZMTdQZVJSb0JCQnRJWkR5?=
 =?utf-8?B?b0VKY1hTWGRHZkRENW9nMVBnRkd1RkhxYi8xTFJrTGlvWFBWaUxSNjNQSDdM?=
 =?utf-8?Q?tb14bzfQmsMXVfnmv1gSWrhGfYSboP9U?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WSsxZGQ4N2N1T2U3OVVIbGkwaEhObGZTZlFuQWFGWlpZRVBJRUtpbUtWVXNY?=
 =?utf-8?B?OG5CUHN2WStRdTRtcksrMkNtbTc4cnNuV2pxbEN5QlByeU5yYnBzbjV1aEV4?=
 =?utf-8?B?aFdmckE2Y29kUGlYQnNGbkorUnYySkdEa1Z6OWQ1elRudWNUMmtleUU2RUFv?=
 =?utf-8?B?OHc1bDFadzF4bTVmaENrNzRzYmExN3VaSVNUY0VIQ29RYUdWR3c3WnQ5VUtw?=
 =?utf-8?B?MjJnM21VYjM3MjU4ZEFUMXpCTlpxTi85eVE3aDVoMXVNb0ZRTXNRSHNiTGZE?=
 =?utf-8?B?ZWFMZUNrUTJ3VktMNVVDZUp0UG85aDVYNmxlSTYvS2VtTUE0Qis3TytqcTBV?=
 =?utf-8?B?dWpUK3p0QWpuNnNtWTJBc1hxSFlGcE55Nk95aUFCTGJOL20zU1BnUjJZNm1K?=
 =?utf-8?B?VnZ0V09ZZWRoN2phYWU1L0RuME5IWjRTWGpHaFM5bTNCYXFLZkR6WTVVTy9M?=
 =?utf-8?B?VVdSUVdvaU5WUnRoVVExQzRQVFJuZVhRc0RoYjYzMTMzaVk1V2dIdXJaQzNs?=
 =?utf-8?B?bktFYUlmWk9zcUQremthZzRjZkxFVlhxbnJ1MzFPSE1kOTlZMk42NkZYaXp5?=
 =?utf-8?B?YlpDZnlMQVRLdWgyVDVZNE1SSkcyN0tRcnd1TXE3UG5nZUNTUXl5dHBoc1R6?=
 =?utf-8?B?NkhncW1Sa3lOKy9HcFNSMUhYTFFWOUFTbHhoWFRUdFhGcEJlc3g0cHdlWmFJ?=
 =?utf-8?B?T1ZOS1hjOWJHdjBCQm8rVGFESHdHVklHeXpFQmZncld0aUw5aXVScUwvU1py?=
 =?utf-8?B?QXFsS01yM1JQd1ZSSUNyd1JHRXRUU3dha1FUMElsejRWYVJEYmtBUkhPbWl2?=
 =?utf-8?B?bmFObzV4TGpFRTA1blovM3BXR3lOWTFUdEE2YnpSZG8vZUtmRk12N2dubTNY?=
 =?utf-8?B?V1BVcXg3eWZYWHB4dWw5RWtNcDVQOXBxMGFXOEE0Q0tTT2hPOGJKMUxTVUlJ?=
 =?utf-8?B?cEtvaFBmNVZzelNMVFpmQ3UrTlVyNmhvOUZCZzRDSnZ3U2JlUDU1Yi82S1Ni?=
 =?utf-8?B?OTl2Z3prc3M1OUVHc3JDbDFIMFJNd0gxNFRBanQzRVMvUDc0YUhEWDIybERI?=
 =?utf-8?B?NjBtcHFtekZRN0RPYXBVYkwybENBYzRYL284ZnR3c0huODJJbEV5Qk1KQ0hm?=
 =?utf-8?B?V2s1Vjd4TnFETVVLQStqRHlOLzFINks2WFQ5aCtEZ091cGM2VThJMWZNbmZS?=
 =?utf-8?B?eTI0TXBubk1MeG1Hd0d4bDgyOHJSUVpjbEZURk1hNjFBYmEwTm5aMmZ6UVVn?=
 =?utf-8?B?Tk41L0dOUFNOUmtKUHJTaytNSzNzYnkrV0hYYUM0Vmx5akZGeTBKMklSYyt0?=
 =?utf-8?B?Y3dEQlZ1WEw4QUl6QnUySXBhVHNuMzYzS0pmYW80bkRpNmo2Q3o0SlJjak1S?=
 =?utf-8?B?NUpCMVpLb1pvY2xZaHN1RllDeVJrUDhWTk5WNkVwb2RPclhCc2NsaXYrNlhk?=
 =?utf-8?B?Mk9yeXBGb3hjdVJDNWZPbmFYbjBGdUptaStnMlppSkVKYmVkbUpocWhjbWRz?=
 =?utf-8?B?QmQ4b3ptWWgzNHZJUmFxSmFlOGZmSDlkMU5VdkI5b05ISGo1b2IvVWFLNW95?=
 =?utf-8?B?enVUWlI2a0dHTUxUWTM2cE5Oc1NodVRJeW9RdnhJNGRpRXNDTzhVK1JtVHJi?=
 =?utf-8?B?bnp6WFJTMTRmREpXQks0SXNNVGcwc2JRYnF4TnlVNmlndkhKNUdUTmFnWW14?=
 =?utf-8?B?bUZuQmVJU01nNmFUOWoyNDNvZVlRREdSTm1EUXl1Zmw5YkI1Y1o2VVMyb0o1?=
 =?utf-8?B?K2ZjS1M4bFYzcmcrRFlRdURFQTVVODExWitQbmNpeEtPRzBCeW9EUE1GQ011?=
 =?utf-8?B?S0hiSSswUGNqSTQ1RWh3MkozdUltamZRMEx0VHZzSkRRNloyS0FqNG5NV2hY?=
 =?utf-8?B?SjdqTGJyVm9iN0F0SmNTRktyVS9Td2h1Si91OG9ETk16OEh6UStxWkRhd0Yy?=
 =?utf-8?B?VWN5blg3K3JONnArWEVqUVFNZVg1S3ZpZDVMMnpzY2UwSkJycG9OTml3UFFl?=
 =?utf-8?B?TWIyekEvdmgxcGxpTlNoTFJhdjd4TkhueWt2ekM2RkxWTlZheGZGbGxDWHp5?=
 =?utf-8?B?YkVoSlVSbFZyclV0T1NvTDhmaVQ4TGNrKzJ6ZUpIYXdnMXgrblErNDYrYWZs?=
 =?utf-8?Q?N7UUGBcx7APTivi6vWKjsXIO7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf61864a-2f95-447c-405b-08de373358eb
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 14:58:01.0429 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2yyYYOj3PJvbivLlV6cCHZjSQzewnQfTrTHoXG09wM+qS5DvopezcoI7ExS45IRe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8930
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



On 12/9/25 15:43, Tom Rini wrote:
> On Tue, Dec 09, 2025 at 03:17:45PM +0100, Michal Simek wrote:
> 
>> From: Pranav Sanwal <pranav.sanwal@amd.com>
>>
>> Move DRAM bank detection from fdtdec to custom implementation to
>> ensure memory banks are populated before get_page_table_size() is
>> called during MMU initialization.
>>
>> The current fdtdec-based approach populates gd->bd->bi_dram[] too
>> late in the boot sequence, causing get_page_table_size() to be
>> called with unpopulated DRAM information. This prevents dynamic
>> page table sizing based on actual memory configuration.
>>
>> Parse /memory nodes in dram_init() to fill versal2_mem_map[]
>> early enough for MMU setup. Supports up to
>> CONFIG_NR_DRAM_BANKS (36) non-contiguous banks with high memory
>> regions (>4GB) and use __weak get_page_table_size implementation
>> to estimate page table size based on the populated DRAM banks.
>>
>> Signed-off-by: Pranav Sanwal <pranav.sanwal@amd.com>
>> Signed-off-by: Michal Simek <michal.simek@amd.com>
> [snip]
>> diff --git a/include/dm/ofnode.h b/include/dm/ofnode.h
>> index 120393426dbf..5be9513f5238 100644
>> --- a/include/dm/ofnode.h
>> +++ b/include/dm/ofnode.h
>> @@ -1886,4 +1886,6 @@ int ofnode_copy_node(ofnode dst_parent, const char *name, ofnode src,
>>    */
>>   int ofnode_delete(ofnode *nodep);
>>   
>> +ofnode get_next_memory_node(ofnode mem);
> 
> This function is in lib/fdtdec.c and so we should have the declaration
> in include/fdtdec.h and while it doesn't have a kernel-doc comment
> today, it should. If you want to in v2 make 1/2 add the prototype and
> comment and 2/2 use it in mach-versal that might be a good split.

We will do. And do you have any issue with logic in this patch?
Pretty much we don't want u-boot to be relocated inside the memory bank where it 
was initially loaded and we didn't find a better way to do it.

Thanks,
Michal
