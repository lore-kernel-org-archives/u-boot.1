Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE98FC54E71
	for <u-boot@archiver.kernel.org>; Wed, 21 May 2025 14:31:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 562E482F67;
	Wed, 21 May 2025 16:30:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="x1lnafga";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5986582F8C; Wed, 21 May 2025 16:30:58 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20611.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::611])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 29A1082F66
 for <u-boot@lists.denx.de>; Wed, 21 May 2025 16:30:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VhGzvNC/16aUNp0P3MQpykqlYkrUn1HxKUMp2V3U7uJe4HY3VGvilXegAOm7vej3eLsLInWPVxQbNXMNvZWDnMPTHqzKklNs6O3H6ELijIMGR0EfQn5szWzkE6iHXRPM6BN4CSowHMkdkBZDazC2QDySF2kKquEUPtfUKm/JHqhvigWKAjMWn0XyRUmi6EnmKEDQxjp83CSslCgfHkpGLzDyOoE6tLUAtkb7vlc0F0ngm7iaOfbgelU9fl2ayWdNf2iUWsuvOaFYmOSHVTUduvfwuChjW5qT6JsQh6TMzbdcLhZdqdCTchsSHkBaLTzJ4k6ig3dqylSkXyJb4lJrmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lx7DoHlJAROBkhBgaofTHa+HT1sy4lXfS5FtYUddEjY=;
 b=SRUcwNk8Ge/NZxQNy6b+a6imrzJmL4QWNdszSHmebnyCAR+ymG5VILkWevK4CyHIeDbxdBTrg0Bxg1hUBwte8FhAl/OCEWjW7ghQVYnXYXKqK64bSfudbhNLzRzaoBSIlGQrafxaR6IUyVBx/aEZrbdGR03x1vddWMtNVnmQisY9DVITLoXVc1Y7rxY8WO68Zdx4qjU7ybVwncDUSzUY8/hGeH9jx4gMEQn4rrW5DYDlwfjpnGT1wl6VbqpGkLG52FQx+3a5ZVr/if9Y53+WVHgVVaNe3y0hEJNQNeOCJ4AN8y8GMtzPV7PWF3sp3jGTxnix5v7F6JsBomE29fSAMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lx7DoHlJAROBkhBgaofTHa+HT1sy4lXfS5FtYUddEjY=;
 b=x1lnafgaLDfWkDXTSeut2tiwMqnPDa/FJzB0knsX113paaMtT54GGNDIHT94WEu6XnZV2IkjfkNtoU2mFpxQopmvuGOH4uIQNhOm9uX6w1CEc5AxiOL8vCBhZhnVT6I4u7RRIDYhiQVtoo2frnrG5UIZs1AiVUYi4NPjEKjk0Cs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by LV3PR12MB9165.namprd12.prod.outlook.com (2603:10b6:408:19f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Wed, 21 May
 2025 14:30:52 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%7]) with mapi id 15.20.8769.019; Wed, 21 May 2025
 14:30:52 +0000
Message-ID: <cfe66dbf-5127-4bca-90de-a92d3a6c380b@amd.com>
Date: Wed, 21 May 2025 16:30:45 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] phy: zynqmp: Fix sgmii clk ctrl GTR lane bit shift
To: Rutherther <rutherther@ditigal.xyz>, u-boot@lists.denx.de
References: <20250509144053.17647-1-rutherther@ditigal.xyz>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20250509144053.17647-1-rutherther@ditigal.xyz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0102CA0008.eurprd01.prod.exchangelabs.com
 (2603:10a6:802::21) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|LV3PR12MB9165:EE_
X-MS-Office365-Filtering-Correlation-Id: f6c566f6-8927-4fe0-e155-08dd987416e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NFZ5aVVNc051dUpwVGRiTHJoOXFzclFXR1RTeXhwelp1c0dEZyt0R3lWTm8y?=
 =?utf-8?B?RTV1WVFwbVZYMGlCZmp5bnVOb3BXbUxDZGZtMWNnWnM2czU5VkQ4eklCdGxD?=
 =?utf-8?B?MTNrS242VmVIdVlaMmVwUDI2TUJqY3RwdEIyRk5sdzdhWkdYUkJBMnhVT1Zy?=
 =?utf-8?B?dmJBeXVoaEVvS0I2c1I3dktPb1BIVzgyemhIYlBnTG44U05qQ3ZkR3JxTUJ1?=
 =?utf-8?B?MjA2Nm9FelZqWEV6YlFwMXdyaXVEdW9SU0YrczhGV2pCYUozcFgycUVXV0dl?=
 =?utf-8?B?bTFqaFNXd2o0cCt3MUE3dlYwTnUxdzYweStLWFNCMG1OeDlnZDZnM3o1R2FO?=
 =?utf-8?B?TTB3bWEyY2pDdzA1TE9pOHo1ZXlQOGhzZUFPVEkvYTQyQWFIaVJya0hKMGk0?=
 =?utf-8?B?V3BXUjBobEZWNkdBQjhyQXlBQ1g2SEVYUUJ3cWIxN3RJalg1Sm5xRm8zU2g0?=
 =?utf-8?B?alRpRm9yM040WkZ4d3dlWHJXeHhrd3ZPVERKQTE5Mm5pVjV3VHJYVGdhalBD?=
 =?utf-8?B?QldORjBCSW9YQ05hUnA3ZEpCRXZUbWE2RkwzekV6di9VWUpJRkhVcWxHOHAy?=
 =?utf-8?B?Z0dNWnUxQmY5cDM1NzVFVkpnTDB1US9RdzV1bTZ5akluYnUxMlBraDdGT0FC?=
 =?utf-8?B?YnlpejZLNWtUQWE0QUNudW1uVWVzMEhLWW5RWERheksvNXFDT25iYU5pNXRE?=
 =?utf-8?B?eEdKcjdxM1ByNE1iMXZiTWVxT3ZxK2x3eEhoQzdaSGtsN2NHbUZpUjF4dWYy?=
 =?utf-8?B?elpnVlVmL3RIMHE2V0Iyc1ZFUHoydEhBR0o5NHY1Q1A0YmpUVmlRU3hndVAz?=
 =?utf-8?B?SnVoWUlMWW1MZUkrT0F3aVF4ZFRDQnN1OGNvNHg5Rm55MDUzMVBUMDgwTmZK?=
 =?utf-8?B?eTBhUy8wUm14WnBQUXIzYk11RFZCNmxYdXNSQkgzakRYUzdkRVQ3R2hHeDQ2?=
 =?utf-8?B?WVBsZ00xQWZHTlRRNURNaDdWTmtDTTUrMWVHWVMrSmRYU1R0T0VRTnM5dnBQ?=
 =?utf-8?B?NGhHNi9Da2RvN09IWURQRmNueGtCVThDQkxZQTcwRkdackQ5YW42RE9KVlV6?=
 =?utf-8?B?ZVRUSUs0OG05Um5jdHlOQmxXYzRDT0hCd0QvS3FYdGNEUWRDbEFudGpRYWpL?=
 =?utf-8?B?aHVISUNXcFBZanBXdmh6am90emgzclN1TDZVZ00yMW5peHRsMklxU241bXhT?=
 =?utf-8?B?YUJZUkxYMHNSTWIwa0RES1dzekxvTEJsbWpzWTRiUTBrSFVuVFFYakhybUQ4?=
 =?utf-8?B?TTU3cFMxSGJPTk5uNkxDT0gyMTM2OVI0Q0ptaFhuRTNoODlRRUNwelR3RFRk?=
 =?utf-8?B?NzVvUjUydFp2V294ZUVZRzRjcktTKzExYWM5MGNWa0FxSm1CbXdKSkRWR1ZZ?=
 =?utf-8?B?Y1BlZ1Nyd2pkU2l6ZmZDQkoxckszMTNwNGppT3JYZjJFVkhJWGNxS2hPRk41?=
 =?utf-8?B?SWZyNUg3S2NpdlkwSGllQUs1Q1ltdGRNb3BjWlNpa2EwWEZ4SmVuZXpHb3ZQ?=
 =?utf-8?B?ZDF1cURwdktvQldNYVllTWI0bG9Md2RQUkxJMDZNU3BOQUsrTFZHS0c0eXlq?=
 =?utf-8?B?YmVLb2lDVWZuMVdTL0FxZXd3TU56ZFdvdXphd2JpZnk5N1Y2eHIwdmRqWmxQ?=
 =?utf-8?B?NnBLQlZYRGt0YUdWNVZ5OWR5cnh3dFlDelJnY1I5Witrekg0cFFFVlN2c0px?=
 =?utf-8?B?a0F1OUo2MHFyOGdYaFFJckJEMnArNHlZTlZ2LzJpclZpeThvZGsxWWNacVpk?=
 =?utf-8?B?cTVqdVdrSTJ0Tmp0cURVdjFKTmhRb29NYmZtYlJtUDZoV3NReTZwdllHZEd1?=
 =?utf-8?B?SGtITFViU0JsUDZRa2NpTlhjMWJCV0hha2YyQ0wvZ0ZlR3FvV1QxZ1ZEbGtT?=
 =?utf-8?B?UkU0Nm8wb3lTdVpVOGZVR2lCcjJnTk02ZzV1T1ZwTkx5Y1R4VjlTZjgrRThu?=
 =?utf-8?Q?W3jy7qYmM3M=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ck5INlRGUGJMbnl6RVNad0RRYnBSdjVkcjVtRGtoSHdlYTZIM2FqbWhzMUE0?=
 =?utf-8?B?cnRKLytzM0cwdnZKVVJCL0s2VFhKVXJpQm1OMWRwK0x5VmlCc2NaYWpVNG9l?=
 =?utf-8?B?TjkwdUZRRFhjeGsxbW10Ry94Z0tPUlZnMGlrdUN6MnhwbkN1NnEwL21MbkVz?=
 =?utf-8?B?ak9ud0ppbWFmOGYvSFJCRCthWUZBclJ5c0t2aDZneUhwTjA5ajVZR05zQ25v?=
 =?utf-8?B?Q2RkQTM3Y1hJZEdGMm9veTlydlc1VHI4YWhsaGlzSHR6MzJCc2M3WitmRGEv?=
 =?utf-8?B?Wk10RUo0L29ldGU2dzNIMjRxc1pMV0liQ2ZXYVluUXA2MlZyRE9ISEJoRmdP?=
 =?utf-8?B?UzVPZEc2WXNyeDJ3azlVMytOODRrQTJadGdoN09OZ1RhSldmZDlBaEZXS1J4?=
 =?utf-8?B?S1VFNytzcUdpeElpUmZTUWhyT2RjRVVaWkNKWHovUDBBWGtWa0kxN3JUVTY0?=
 =?utf-8?B?OE5QVFp5Tmgxbis3UVJGUDBZY0wwTlhrV3lVV1dScitPdW95VHVzOVFwYkRB?=
 =?utf-8?B?TTZCNWQreXBBeU55ODhYUm8yaDdiUVI4Ylo2cVBkK2UzWHZ5WW42eTF1SkZs?=
 =?utf-8?B?YkZDQjc1aVhKOGRiaDdoRFdnVlpaWmtFNG0vWEJhZlFZMTV4TVRDRElrRzl3?=
 =?utf-8?B?Mi9uVmEvakVGWFVxNExnWnJERlZLbUdhQmlhL0toeS9TdHFheDFaa09kUlZh?=
 =?utf-8?B?aXJzbGpvN29PSHRuSFRqZ1BQS1VndzZCK0NvZ3BaYW8xWDU2SVUyZlZ5bHNP?=
 =?utf-8?B?MDZpOWNLSmFUcSs4a3NWbTZaVEVHZXZGVGo1dWgwN1p5Q0Qva01lTzFIblo3?=
 =?utf-8?B?ZGdXNVlSbXYyZ2RqTzVkODlHMGJtVlFFRlRReFJ1Vk5keFhTTWQwSzRjN1JW?=
 =?utf-8?B?ZWVGcXpiNHVGM3ZPUFNZb2dsRkE3MlpSdE5hYjhaUjBteXNkOHBkSlQzUHFS?=
 =?utf-8?B?QVdrRTE4Und3dEVBT21mTmFmN2VBQmFjQUdWQitFNkJnZTdPOU5kN05IN1ha?=
 =?utf-8?B?d0RoWE9PR0t1dHhLdnBwLzUwajRwR3dlR1lNTHdwNnU3UU1ucldqNVh3MFBH?=
 =?utf-8?B?ZEFuRm5pckhYT2VQby9GY0JLbWM4Z2JmQm9RNkxiTy8vQUI2b0ZZZWJkeUll?=
 =?utf-8?B?azJDRHlyWjc4VXZCYWJRTW1UUlN4Q0VsSzlhSzVITEt2aXA0cThCZG9GVlJi?=
 =?utf-8?B?U25EbURoVXJwTTMwMmtDMzVQbXF4QTZnbG5Ea0N4S2daQkIzT2ptZVU0b3JP?=
 =?utf-8?B?bDY0M1ZURjZaMHhtQ2Y5ZWlKMllacTlzUjlQRmU2RkxXdDNhQWY5QUs2cFZM?=
 =?utf-8?B?ZFlzSXh5SmN2QnVLQzJkeWN3cGgzYUY0MHhWUDkvY2xTbS9GNXRBMXA2dkFS?=
 =?utf-8?B?K2lVbEtDQm4waUo5L3Z1R3VSNTFqeGluK2t4cWF4RzNCS1hoQVZOZG5VUXR5?=
 =?utf-8?B?YnprYWlzZ1orREEreHlqSEZ0ZUNCdVc3YTNMdHFaYWtxaWRxYml4WjZBSFNF?=
 =?utf-8?B?eFBwckp6NFRZWGdiWGtnMEhrYW04eEhNS0lzeE85Z1A2V0hlY3RNNDhQbS9y?=
 =?utf-8?B?RTlWTHhRYkxVWDREYXp1ZG0ydnZ5RjNscWEzazI0THpOYlNGcmF6OFlsTzkv?=
 =?utf-8?B?SDFpTlJjRGNnaWdjd3dyU1BTZXFFZ1Q0NjZwM3o2UHpqTDhKdmdveWVtVVZ6?=
 =?utf-8?B?c3d4RXZMazBxQ0ZnQW1JZzJMUG1uM1RCRTJFakk2ZWdicHY5TWdIL3MxTFZL?=
 =?utf-8?B?dTFld2ZVdU80VFRheXc1TnVUNC9Vb1BieHZRSm5PV3hPZ2EySlp6cFhVQkl4?=
 =?utf-8?B?Q3dxUkJsVkJadm8rZUZub0NUSXpDS1o2Q1FPblhlV1RJUkpHK3BnUGVEenhh?=
 =?utf-8?B?UUZNdGxIRWpDZm9RUTZtOWlMVi9sNk41T0EvMkNKakUxZkFFNnBvV1JBV3dh?=
 =?utf-8?B?aTU4TjhEWEVyNXlvemZkcGJMbDFWQ1JLeGdYOGtaOHdOZllyWHplMDBWQURP?=
 =?utf-8?B?ZFVtRU1KdGorMENDK0xYN0x5VGhqUlNqQmRZN3NtMXBwU3k5d1J4Zy85SUlh?=
 =?utf-8?B?WTQ5OS8xQkR4ZHFtY01POXlCZnpSY0dmeC9hYmRUdzZrNjhhLy9iUmZreGI1?=
 =?utf-8?Q?BPobsOhTZkTtmTn/zpe52oVkR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6c566f6-8927-4fe0-e155-08dd987416e1
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 14:30:52.7445 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RWusRKKn8645SzEst6UPz0Z69gDjW5B8GSYmthl1keNi7Gw2qOZfZf1emNlb4dSR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9165
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



On 5/9/25 16:40, Rutherther wrote:
> The bitshift in GEM_CLK_CTRL register is five bits, not two. There are
> four bits for each GEM, and one bit reserved in between.
> 
> This bug has caused that using more than one GEM is impossible,
> additionally corrupting the GEM0's configuration, leaving GEM0
> unusable as well (ie. if GEM0 and GEM1 are used, GEM1 configuration is
> going to write to GEM0's registers wrong value, leaving GEM0 unusable)

The patch below is correct but I am only missing your SoB line.
Can you please send v2 with it and also use your full name.

Thanks,
Michal

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

