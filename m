Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6F4DC021A4
	for <u-boot@archiver.kernel.org>; Mon, 24 Feb 2025 10:13:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4466980079;
	Mon, 24 Feb 2025 11:13:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="GekNA2Hf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8DEB2805C3; Mon, 24 Feb 2025 11:13:38 +0100 (CET)
Received: from AS8PR03CU001.outbound.protection.outlook.com
 (mail-westeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34C2A80017
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 11:13:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tLIVroJfiinbVHEyCLfgYJ/VdiC2f0Vjg40JUpyw/p/v9vKLqIu6zpFo8UpwGoyBUVYflsnntgPwHn/fL5AZDcKJqeKTlxdk65okXAF6dDT59CbjIXE6eWfFC5gVQkKxL7zTZ4lz/XDyXMroP2IvzKwfBSOZhLQvsLJREtEEcVVHUDdwwoG/ISXGmLRUCLXiGPhb7WAkLgu9t61cHqptr6BXcjoZDKGfThThnuTZMCRzlZA+72ZU/1EgIt4V5nL+MYqwThT3s3qgyMf9xpvpdtGr+wyKkpwM7EXq6SEjEi5BoQ3Qx9Yq9tALSuI84rK7dv+8R2XF/o38EdRvp3e1Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5H0SRZjdMNLIQFuyzqQag7UEAiGsFzEXNlsc37mchxw=;
 b=CAsTioJQAjLepGUTfSVuqgPSmOD506A5AqBrUBy4+HGhNDL+swWztErgwkZBcegvn+4mWGvCjUI+V4SqcfS0IT3a6KsHPsCnKnFo/mMskxz31N/vd9S1+BwXNvEXvDDRv+IIB7LncKwZHIu4SVL5xK9t9i9+rUtSIKJbI8JEaF13JhaLuSnuQodVDhC8EyzQm1N1XGVyPRClisnW315NXh2QG80tawaRGBVujfQ33ClwZhtqMokm8RnAsbXrryJiChiL8EaQ5ElxyTRvyUoXcGUdZDLu1haKlTUeGSX9UKkDHJdEhdT83SMbSys1TKSkxZzBzAE0yVZfK9vLIQQwzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5H0SRZjdMNLIQFuyzqQag7UEAiGsFzEXNlsc37mchxw=;
 b=GekNA2HfZxz5mWgSPmPNiY6SIWKUKiB5kvyU3uQ6S9txMtJkrrRw+6ztAkJNrsKCSoDYuVlG1j6GE6Vhr/tiNsDTC5S+iDyGPtANgLw/La0n2dnKneW1Kgzq5i+Aew3gILCxCYRpu0dfy/pw6hV6dxzIOw50BQ4yBjx7N9Pv1uI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by GVXPR04MB10898.eurprd04.prod.outlook.com (2603:10a6:150:214::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 24 Feb
 2025 10:13:32 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%6]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 10:13:32 +0000
Message-ID: <71463425-b3da-4d3f-a1dc-80822e28687e@cherry.de>
Date: Mon, 24 Feb 2025 11:13:31 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: Orange Pi 5b defconfig
To: Cenk Uluisik <cenk.uluisik@googlemail.com>, u-boot@lists.denx.de
References: <CAAWLpRuxUZcnnYXCR4ACLv-oc09Ru0c+0J3y_8yzi8tYTsd0Gw@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CAAWLpRuxUZcnnYXCR4ACLv-oc09Ru0c+0J3y_8yzi8tYTsd0Gw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0412.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d0::20) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|GVXPR04MB10898:EE_
X-MS-Office365-Filtering-Correlation-Id: d79a84be-2a25-4abe-a6d8-08dd54bbe41a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OWZRVFNSYTliMEx6OW5CTS9WSzcxODNCMmRSQm9RakU2M0RPWE8wSEgrSXgy?=
 =?utf-8?B?dHA5ZEhaRnkyR3NUbzJjSWcySHpBb3M2a2NaajBmbjU0VitXUENsbklRbTl4?=
 =?utf-8?B?K3B2dGJZTWJQOXJBYTRwdlpXdC9xYXE5eGZqTDA0ajBYSjgxWkMrODJCUXFN?=
 =?utf-8?B?NzdZaUErTjFXTG52alprMkZXS3hiNEtsOUdpLzlWVFJRbHFzSnhTT3FIU0ls?=
 =?utf-8?B?ajJDNDVYUk1QNFRiRnRub3RtK3k0REpjWHlmSzRmOTJGTGRyL3grSTMzS1JW?=
 =?utf-8?B?alZ3RkdYSWltNXZpVFZzN21zV0NjWTN0dEtUUFpmcmo2V0M5L01DNGJaNmda?=
 =?utf-8?B?eVRDRHFUMUVGYVkzTEdva1pTSnJEZTVCdEdhSnVZWUlHU21yYkxmc3hoTmk3?=
 =?utf-8?B?ZVdyMnk3K2pGWHRtVGlrZ3B3dVBXY3VhRXhwTnVCWDJ2ZXV0Mm9UTUZ1Y1Nr?=
 =?utf-8?B?RE9hRExzTnNvSlZ2dTFMSXhtWFpUa2pPTWhQZUdQWjdMbEUzVHVLS1hwcmll?=
 =?utf-8?B?WDZtb0hSWUoxdElqVFE3b2Fia3REaXgxbDk3UTk4bkZHQWhpT3ZuK2cvK293?=
 =?utf-8?B?R0V0V2d6enZiaXFpb3dIL0c0WDRmSjN1VW1VdGlyc2VuQi84aE9qZjlDN2JG?=
 =?utf-8?B?U3NFRnl0eUpBRkpEeVBFSFZ2cHZSN3AvYmVhUUxMaTRlbUVudTIvK3ZvL0VJ?=
 =?utf-8?B?NDEzUHdqZDVwTnc0WXQ1SmVuTStWWlhndmZjN3d3ZGpJdWVlRnlkOElPZjVF?=
 =?utf-8?B?WnNJSzBJY3pmNVoxbmZqZFgzNkt6S0UxVnEyUVcyV2hka3l2TC83ajl4M0VO?=
 =?utf-8?B?OG93amNuUWpTS0xYMHpsckY4c1R4alNJaTVwZWh6Ym9YbDhZRnlGSFRLMjI2?=
 =?utf-8?B?S0F6QnFNWC9iOVBBdlBzTTVjY28vaUhPUGIyWkVCU3BiQXRLRUVFS0U5T1ZE?=
 =?utf-8?B?ekdCUEt1di9HS1F6MCtiY05YQTl3NGRsOWNmdEFWR29KTTlWMFQrUFRnT1hF?=
 =?utf-8?B?ZThOeGNHVEVhUGtEbzBjTUxEcDNoSTh1TjVNSUFSWlJnWDZDd1ZMS2RZakRs?=
 =?utf-8?B?bi9oeFNBdUluSG5TUGpZZ0VUY3pzRitCTGtmZUNIZUtpMDFscWEzT2dORWcx?=
 =?utf-8?B?a3pMQVB0VnNFeVBmbDUrd0djRmtiUk4rUWo3MTE3RGV4WklIVmZWbU5yYXpo?=
 =?utf-8?B?ckV3UlNnSmMrSGZhQnBlY1ZjRnFWdnJ0bmVMcEhyMFRtTFNFU1VLSEdDVThY?=
 =?utf-8?B?ckRoSm5PVGNJMU9ZU1VoejA0czJ2d1RJdFZXM1Y2dWVReFpySXR1bHR3Z2F4?=
 =?utf-8?B?bHoyOW9JTk5VK3pXc2ZtS1oyLzVZWHlxRXZncU9IclVmZ2YyTDJHcXRXVGk3?=
 =?utf-8?B?aFIwREtYVFRIWVZkTlh1K201M29xNjRjV1E2aG9FUk9XTUIvRUxkaVFSOEQy?=
 =?utf-8?B?UEIzWlBUdmZjRmNhaEFwODZ3d1pmdXprQWt5ejZ1TGNJZTVrRkUrSy9RbkpO?=
 =?utf-8?B?N1lheUxzRFFjeVhDUWRycDBENDdoY2RYY0Z3U3JEdDE0ZzBsb3I0Rm92Tkl2?=
 =?utf-8?B?SVZ0alozUHNVZTYrano5V0orSm1CUFRUT2kyL0NsZXQ3eWZPdmwraEZ2WWM1?=
 =?utf-8?B?Z3NEVTZXeXlzM2FIdmNTdEZFcjNIWkFBVzQwaEJhclVGZEl5dXBQS09QODlN?=
 =?utf-8?B?Ym1Pb2NkM0R2S3B3RHpHSTRWblFkWTZSeDNzYUJ6Z2ZkZHhzblQxaEQyTGpk?=
 =?utf-8?B?SEwvejlkaHM0MTlzRVFHV2RIRnQvR1A4eEQ5bFVJcE9xOUFvNUlRRzJGc21S?=
 =?utf-8?B?Z3d2b0QwVlhPZGd2YUV1bmR3ME5NaEVBa1NrRzZoYi9DQnUwbWNpMS8xMTAz?=
 =?utf-8?Q?0pq0PYWbjx8JE?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aHZpNFJTVHZmTlJHZXBPd1U3VXRYbE5BRE5GcUNTdVZuMVR5TFc5OGRnWVlB?=
 =?utf-8?B?eW5pYTdUNjNCdXZsWjk5cG5nY3E1bXJiMmJBaHNnNWtuMi9lazEwS0pGRXF3?=
 =?utf-8?B?clkvcmRiZ0MvZmlnZWFCcGJtbDQ0K0h5ZU13NzFTVHRnTndLOTF5WDZCbzN2?=
 =?utf-8?B?c0JtSWpOWDhnNGlLbjdrRksxdGtIVFhEYngyTld3SlRta3E0aGh2VGhyOUsy?=
 =?utf-8?B?cDh1Qkk1VnE4WWVEVEQ2OEtuOXM3bkVlTTZabzduWTBoOEJyR0d5eTRQaWx5?=
 =?utf-8?B?WkdiRmJ4U2hGUHVCVGxWbG15SUVoODJTM0h2a3YwVFBhMVlLa1VCUGtLZ2d1?=
 =?utf-8?B?OUdzWlc4NGFxN1FuN3F5ZFpNb3JFTVZONlhNYUNHdW1BcW5nOWl2UWh6c09r?=
 =?utf-8?B?UEVsMytIa042U0dyVVlnWjZ0R2JleHRheml5UTl5NDAvWkVmT3diYVp4NW9S?=
 =?utf-8?B?MGN1UUlZSVBtOE5UZUFRY256M3BYY0h0RWJja3hHVUtkZ0JudlFhd2tIc3M0?=
 =?utf-8?B?azV4ejdrMUU4U0F5WTh4Z0ptUDlwdzAvN1ZQempuNStOSmFOdHlYR20xRFp3?=
 =?utf-8?B?OWVzYS9GZ0xaeVV0M1kvWVhQSHNiVWJ4RC9SQU1tZVFGN01vcnhMQmRhRGtq?=
 =?utf-8?B?Nnhibm5MYjRZTm5BSW5Pbmdmc3FZVGFUQUJOdDRySTB3aTluT0dIWjVlOHVp?=
 =?utf-8?B?MzFmQ2NoTldtVStCdEoveDdoYVBjTk4rQ1hORS9ERWVUWVNZVEgySlcvMmdr?=
 =?utf-8?B?OHRTZGlQZU1wcEF5emdPU2EzSnFHdUtobVpJVkhTOUlrZ24xUkNpZGdzTlFG?=
 =?utf-8?B?Rm9kUUtkQ2RVL1ErZ1QzbmtuY3VNOTc0TG92VjMwTWpZVmlydjlWRkJmWjFC?=
 =?utf-8?B?VVhiZVl5R0I4UWFRZlBXb29GMTJ3SGRRUnBoQjdialFuYWMvbHdQNVZ4T1Yw?=
 =?utf-8?B?aWVRRkltVnVuVnRiWmZ0YS9iazhyVDRmMjF0aFl0end1dlVCbFAzQ3lXSmg0?=
 =?utf-8?B?MGttTW5qSGNqVmlpOTJXOUhwWGNTOWRLdkxTWXE3czgvbnZJZTVLbDM4SkZW?=
 =?utf-8?B?b3dnUCt6T3NFbm1uMnRPc3BmSXdhWTRUenpDSTMxaUtWRytIbEtHOWxBTWN0?=
 =?utf-8?B?ZmdqUzR6Zkp3dmhKZ2xQb1dmcmlIM3RWOEZzY1hVbVdUODlZVFZERHYwZGdR?=
 =?utf-8?B?WXJyVmpRR0VJNjVaempGZUJEcGtCZU1iVGJPSENKd3dJQVRSS3FIZi9FcGk5?=
 =?utf-8?B?d1NUZi9OWm8rTkowSXNQNG41SWRzcEx5Y1ZjUEtqY0hxRGhHcGlUV1NXRml3?=
 =?utf-8?B?cmtkYTI5cHp6WDhCN0ppK0V5NndiZlErbHA1RWJIbkRwTUR5T3g5QmtGRTJF?=
 =?utf-8?B?bmFJT25IRGYxdkRrYWtqbTFKR2VYV0R4cERVcS8wSjJVemFNT1pneDBmZEo5?=
 =?utf-8?B?S080RWlSdWxsTkVJSFpna1RLT1M1RE9QTFFUbUQrVCtJSitjdlFqYWI3eVdI?=
 =?utf-8?B?Uld5a2FVUE9KSm9zVlEvcmR4Rk94VmtYbWJkVVphTlRObXlBRnpWTVlBQkNa?=
 =?utf-8?B?aHFMTDh0cDhFTC9uOFVUVkVFcjZrSWh0V3NyWnIxYkM1bFVxOVNsbDdYS3Bi?=
 =?utf-8?B?djdDVlpVdGpWbkMzQ3JUci9rSlhTdzBQTU9YaTY5Ym8rUE00YXFqOW55OGoz?=
 =?utf-8?B?OEo2M0UwTDl2d3ZOZlRySWQ0cHpUclVyUTZ2dWl3MElkT1kzdTBSOXh3c09a?=
 =?utf-8?B?a0R4RlNMaldlOWxSVnFEcGhMeGNkaHh6YUFlekR3M29WQ3JRT1cvZFVSRW13?=
 =?utf-8?B?M0dwL2FOaDU5S1BZOTBGbVdNSm9ieFlwMzlvK0pQeDhKSjhjMUYrZGIwT0p3?=
 =?utf-8?B?emtyY2RnZ0lUV1B3S2xCQ3hlc21LSm9hVGQxQVBzZUh4NDZwRjhiRmtKUFRK?=
 =?utf-8?B?WlVWQzlYejAxc2RmditwdjhWM25pWWlPRCtXQUlqWjFha0h0aitQaTU0N0g5?=
 =?utf-8?B?RGlMVDhtR0U3VmNtOCt6a1FBWTB1TjF3Tk45MUdMSjV1NWg0THY5cWR0WW54?=
 =?utf-8?B?TEJqaDFFYnB6TzFFUERWRlBDZHFSdU5ZcXRDczEwY2pLR3YrdVB4MUVKa2Fw?=
 =?utf-8?B?NW1MMTJ4OE5yRnp5WFVsUWpZRFE5YWNOTHBMam1Yd0F1Z2VBL1crWW5lNC8v?=
 =?utf-8?B?elE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: d79a84be-2a25-4abe-a6d8-08dd54bbe41a
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 10:13:32.1170 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KcekB9rUMyOqiQ4TRzADB0fRg7NVWtw8XI1ihzUqNol2PRWGx6k5w4qsO/ybCSnCc4kOcZNxDRP0syE0PEILUhMMwGo0Lm6V/Wl20qZKU0c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10898
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

Hi Cenk,

On 2/21/25 10:47 PM, Cenk Uluisik wrote:
> [You don't often get email from cenk.uluisik@googlemail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> Hello, I have sent a patch for a defconfig for the Orange Pi 5b, since it
> differs a little from the Orange Pi 5. I have picked the e-mails by hand,
> because I was having trouble setting up patman here on my NixOS.... Maybe
> they were the wrong ones.
> 

Can you tell us when you sent that mail and what's its subject? Does it 
appear in https://lore.kernel.org/u-boot?

If not, we never received it.

I personally would recommend using b4 for sending patches: 
https://b4.docs.kernel.org/en/latest/contributor/overview.html. That's 
what I have been using for the last couple of years (though I have never 
used patman so cannot compare).

> Is there any possibility to apply my patch and have a defconfig for the
> Orange Pi 5b? Since I would also make a commit on Nixpkgs afterwards to
> their u-boot packages.
> 

Do you know if there's a way to know which variant of the Orange Pi 5 is 
running at runtime? I don't see anything different for SARADC for 
example, even though that would have been the ideal way of detecting it. 
The point is that we could avoid having defconfigs for each variation if 
we can auto-detect it at runtime and just change some values based on that.

Cheers,
Quentin
