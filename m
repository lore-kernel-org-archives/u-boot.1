Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B8BCC4828F
	for <u-boot@archiver.kernel.org>; Thu,  1 Feb 2024 15:13:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1101879F6;
	Thu,  1 Feb 2024 16:13:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=outlook.com header.i=@outlook.com header.b="YI7Nt2rq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F28A875FA; Thu,  1 Feb 2024 16:13:50 +0100 (CET)
Received: from APC01-TYZ-obe.outbound.protection.outlook.com
 (mail-tyzapc01olkn20801.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:280c::801])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8EEA879F6
 for <u-boot@lists.denx.de>; Thu,  1 Feb 2024 16:13:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=forbidden405@outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RKnKB0ll/laRRZK0AjrKp+EHPpcHuAJFBkLTvsf/AU8jj0AqXkLe4zA3a14M+IxysMWSfgpLN9tGkOlzbqAQEAXicE1eiSDcYkf69sSo495XG9YlvVhoVYQCxM8Xcgco5Ij3jC50t1E+NWkknX47+qPvEAepbWLqDSWM8CmazOdflJNDnFI57FqRmU9vJr4jqSphMiG5JerWIXWzOObKT7eXMFKYvLGKBZIVMUqdcJFHAjNWHBYijk3oMDDIaPSRfueA99NRpHsBWonmFvTkKaQshLkGVmmLbI0weabiK88cqFQ8KK4LGrQ9cTGF/0tW1ChYOM2je1/QNc1/EigZYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fTv7BrtRXwkrVXtYDsPKQ15cOIK1AR4gt1ST0DIDpGI=;
 b=QwgbK6Ft25Km6tzdVvQDtExsOYhsswMQ99G8HSNDboWZjTz6VO39fzMDZXdNSf5OvR2HXp138PAh5t3zT7IQ/LM65AP8ZtftUZYia2B+SPf39FiRj+CAXyCR5sXyXDioXeZLF9PflzT04+w9KTa8bn6n1w6MD41Kf86+g+F4d+L8TdplCdF7IyQi/6snj4MyJ/Rx3s/azOpcwg0Vr/+yepH67mBTlQ7OjyonlhOV3Q4S6ZFssDkDqG9t5IRdO0mBkNxX7GWHlD7oRknRPzKLYT+qg61/n/iCzDo3ELKMuhafEIzpTrlumDRfiZ5QPuIrzigkcPn5jPlfv2SBIcGoVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fTv7BrtRXwkrVXtYDsPKQ15cOIK1AR4gt1ST0DIDpGI=;
 b=YI7Nt2rqc4M38FQE3ENWuQ+uamkWox9f+QZbt8UIrK+QUmWyAPO8VeKkf1ZeuSbFLkHoARSlIA/ky43ZB2PPst2VmYk2dr+TbWOccI8ndjPMGF4qfoSqNK1lu25B5yZIqb2DI7F/Ly/G//vfPupWtqUbECJKAqNWvPgQLOrupnpwNRw9gAOpQGbghZXDeieNeH/d7fx6hZnelIligfu07eF9bJdguoQ/qxiv5JQS+AWG949C8UOA/nGJxJ/oPJ2rnpyOtiQa/lWm5LJPXywnrY+FMG1uIcnhGasgvDctU+luQEaWZ7Il7RVnWGhv4eUN9OpYFT55I+fRuSW5ZLnA2Q==
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com (2603:1096:101:1ed::14)
 by TYZPR06MB5528.apcprd06.prod.outlook.com (2603:1096:400:28e::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Thu, 1 Feb
 2024 15:13:42 +0000
Received: from SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::9a6b:d813:8f4b:cba1]) by SEZPR06MB6959.apcprd06.prod.outlook.com
 ([fe80::9a6b:d813:8f4b:cba1%4]) with mapi id 15.20.7249.023; Thu, 1 Feb 2024
 15:13:42 +0000
Message-ID: <SEZPR06MB6959D921192C471349A8B0FD96432@SEZPR06MB6959.apcprd06.prod.outlook.com>
Date: Thu, 1 Feb 2024 23:13:35 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] usb: ehci-generic: setup a bulk of phy when possible
Content-Language: en-US
To: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de
References: <20240201-ehci-v1-0-bb506cb0f64d@outlook.com>
 <242c7bbc-42e0-48cc-90de-f57ae6c7cf59@denx.de>
From: Yang Xiwen <forbidden405@outlook.com>
In-Reply-To: <242c7bbc-42e0-48cc-90de-f57ae6c7cf59@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN: [vx1IzWbEUALM4OMLWrmL2AH5bFfTJPA2z/7o6sEEw3qXOCMqMqBbZMerD0UhXK3h5GL6OF7obmE=]
X-ClientProxiedBy: TYCPR01CA0092.jpnprd01.prod.outlook.com
 (2603:1096:405:3::32) To SEZPR06MB6959.apcprd06.prod.outlook.com
 (2603:1096:101:1ed::14)
X-Microsoft-Original-Message-ID: <83b0a92a-84f3-4ed5-92d9-93283b835f40@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB6959:EE_|TYZPR06MB5528:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a7858cb-e8c1-4905-f799-08dc23385f40
X-MS-Exchange-SLBlob-MailProps: Cq7lScuPrnoglIEyuVXoO0AQZOvbKem9XC9prIL0h9IzX/109ozz2JeibCTwrX8iarYVcOw6DEwtvyZ2LdGxtHIdDZx5cbH1yEee/1p2wSg9vlWM/r0K6A9EfIBm4G+bBYwqBsfC7qShdWFO1TjA7bXk6Nlcm1vnB9TNmNeqhQayl6bwgK+9WhOGqkqsz9hB4RqJm93N3LId8FdmDlJOwyLq2K9qRELdpxwp3ufQAC+Hmb8DO9B4ipPLWKhMSoPvpgFvdRMRy7xOTSnZfsPjvQJkwlqzTijnr5m3HXSqW+hyVODulbGzOQiMfJh2BLwOqzwGE1EdESStmVwOZ+pIkXYp6wcgCgqWmDujmHGv1Fp9aUl8T7vXXiXV5Q7/lljGLkAXNsFc6iWpZfkC1U5mw2YT35w9W+wkaZs2mKOjo49+gRphe4+P4h4LI57vgboAJN+Y42fZe3gfON8gL5NoQLfQAdjcIz5gPB+rLVKriAkRqG1huBJXHzF/ab5Q3BLg4LIOdPuk0m0s0jKQ/qVyKvE6cxTzBBFU7k9EWUC6ByjK1SKt9CcQWS04T50NFgydpCuDTm6YMR2v1oyMd1gFy+pK3JgDT4gMIaEUue5WG5DQd9WHKND31cy7OUYncW8snWkgjjuvEyQahnCxe7GpulhxGc9h0q/UhXguwOD+DuI5jN9l9as/2oittAwhIJUHL8TnS8RIks2EjEZb7Y5jMOPU7HP+eZgdDAPA6AujJtFkLus8+/Ks/x2GwVReUXPCGL8EjMfF4cw=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CtjyLKYYOFlyH5OdqX0wGDLntOwx29PzsvrtV/HPdGTGyeBYnazyTO4jhYOHQAvEnIOZHb6lEog2EluPBozY3UgA41PKjr2474cG9CROyyomb27ncP1rzKvB0cS3OGmffyouD9iMu4O+kxpe3q1C0lMN7FViDcT7dtDr/kNtOyPL18l9UcpNCKQ9V92+vwGVxqkNG4z2GlQhspZwwMRzIEtgQ0cKhgRylg8RBIkRcJuq4NNu6cyTWSfFT/ES2DgB/AmvpXlseQ0I7RltDeIPoAHU8YC4rLAXv15hNLyPPO2cxcR2MAfGXDWh7TOPy8gVWLpJllVLQQpEJBMQNfJ5vdkxhutrjNXYOLddFqzI3Cn8qQ/RfeaxfjyvPTDmsEf4egOZMZfFxfGySPB92KOW+Fj6z57KOmWg/dlc2Y6P4d98/k/WWD12ykumWCRSOB4mSzF6l/Z5ONzLGyk6w+3a/ypCihU93NLn1F7F53/057nWBktE/YMTsOt5k3jEWSX050jYgGqJyAVWq6+ASXSBbRinD3y1P3b5H0qlWdM6mFXxWwyEspNRsiaeMofa4tRV
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TUE4L2p6eVF4Wno3L1N0MThoa2EwTTh3TjhBT00wcGVvK2YzNnJkOGU5OCt6?=
 =?utf-8?B?RWxQNGtmQW4xYWF5WnlDVHFqVkNUMmt0Rll6RmVuUW9nVHRwYWtMVjFOUUtN?=
 =?utf-8?B?UzVkM0diUG13aG1BZlMrc2kvRW0vU1N0V0hucXhiL1lpcHo5Z2piRE5TRGxP?=
 =?utf-8?B?R3RUZHdKWktYMnFoZG4vUFF2ZnVrNjlrb2thRStWOHBIQVpCempDVk5Wcmto?=
 =?utf-8?B?Sm9zREc4VStmSEM5YndCVS95TU80ZG5ML3huRnM3S3dtcm82UFNsaDVxcXVT?=
 =?utf-8?B?d3BHRzNhRzNBT0NkWVZEMUJVbzVIMDNZSDh4bjEzbS9ZVWs4VEJHOUFuU3pX?=
 =?utf-8?B?S3JDd1h5ZmdaWGY2U3BoS29RejVWVlhja0Z6TE0rR214MnNQTWl4MDJXclF0?=
 =?utf-8?B?ZGxpd2JQQmtvVGlMck9pNGFUbXJnM1B1SDEyeHlwUWhtSlc4UXc4QW1WNUcy?=
 =?utf-8?B?MjZia1NOVXd1VkdPaGZsdEFxdDBVaGk4RXRrTzMyYUJEb1JqMlpIeXp3VjRm?=
 =?utf-8?B?SkhqaFZiUE9vUUh3OVAwSnB1NVhCT2oyZXl0Q2dBZ3UrR1JJNlZxVWJ6alNW?=
 =?utf-8?B?YVVWcm8xZlU5eWxiMS95eXVYTEIzQS9mV3ErdnpudXdpM3hYdTZQZVo2d3Vn?=
 =?utf-8?B?dlVmYUx4UVVBdzFiR2FXYVNGcE13TklXSEJqOFFNbWFFQ3RhWkhDSklNYUIr?=
 =?utf-8?B?M09UZUxJYk9ZMVhHZ09VeVJ4ZklEdUoxL0p4bnpubFRKUmFiWUYvMVRwYk8y?=
 =?utf-8?B?bU4yWFV3RitkMnhFSnRCWXRyeURwRUhkVXhzOElwUGpiejRkYXg2Y1plY0w5?=
 =?utf-8?B?a25jblZrSHJTbnRTMnJLNU9RNU14cVh4V3JnSFBKbkg5bFFRdWJEQ2owWHdD?=
 =?utf-8?B?dnJMV1hPallVMlFBVmV3Sk9JTWV4OWU3TXJpRWhWTHJUKzlQekhYUWZWVWM3?=
 =?utf-8?B?bUc0cUc2M3ZmQmNUZk1URnNkZExpZjNjblNNblE4dFBnNjlUdHNiUERqNi96?=
 =?utf-8?B?cmUrcVkyWUlvcG8rVVBDR0RSZ3h5OTJ4djdNWlBIOFl4eFFaU01Bc1lTZHFY?=
 =?utf-8?B?ZFJNNHhZS04xbHpHSmFqQXhJOFJEeS9uS0lyS01sb1ozVHY4bGZmZ1dqQ3Vm?=
 =?utf-8?B?STBGRnhMOUFOMk4zbnNJa08wWGg2RnY0SjdvUkVUS2dyN2RhTVBNN1JYYXJ1?=
 =?utf-8?B?NG11VkNNa1hIMDhReXF3UWpMQ0hPM1MrSkgwRzl5OXJVN2IxWHI4NE1pMU1T?=
 =?utf-8?B?QW9hOGdVNlBjWWFrelJEOHhPanFZK2NKbFM5bzgyYkhGUVVHZ1JkdDlkYWkw?=
 =?utf-8?B?bS9IZEpqbERoYUtVRnVKMkc4QjJUTHJFdzlGeU5Na1FkakxBRThIYTdnM3FM?=
 =?utf-8?B?cUdkcEo4TWpnbTlldlVRZ0ZzaVRjRVhyVU5uYkhhUkQ1R2lZWTZsNXEvNHJB?=
 =?utf-8?B?UGQxZHRHcnVlMER1cTFiSmM1Ty9raTExMWxyUHlZYmk1MkNTb05CS2Rubmxi?=
 =?utf-8?B?azNoS1c1MFhYaEdqSEhqSEt2RldzR3FqSVFlK29wUFpEUmJVYmZxNGdzaTVJ?=
 =?utf-8?B?SVp4bzVUbTlxa1NCWTUrV0g3ZFBHWSsvWEtDREhhMVhRSGpSSjV0Q0diZE1M?=
 =?utf-8?B?SFFWaEYxb1ZUY1M0TXNCMHg2bFJ2aHh3bU9oNVYyek1aL3hyaUZyRnR2Mkh0?=
 =?utf-8?B?YVJLbUxkUHVLVDNTYmJEZE83bVNySkdOMHJkL0RiUEJQWGk4MnhxamVnekhX?=
 =?utf-8?Q?gzigRuyOS045kiFeSU=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a7858cb-e8c1-4905-f799-08dc23385f40
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB6959.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 15:13:40.8714 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5528
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

On 2/1/2024 10:07 PM, Marek Vasut wrote:
> On 2/1/24 14:16, Yang Xiwen via B4 Relay wrote:
>> one USB controller can have multiple ports specified in dts, all of them
>> should be setup to make use of all possible ports.
>
> Is there an example of such a system ?
>
I'm going to send one, but not now because of some stuck patches. 
Running `grep 'phys = <.*>, <.*>' arch/arm/dts/*.dtsi` in the dts 
directory gives us some existing examples, though not very much.

-- 
Regards,
Yang Xiwen

