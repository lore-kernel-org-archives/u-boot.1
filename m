Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B617C61DC6
	for <u-boot@archiver.kernel.org>; Wed, 26 Aug 2026 06:47:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E029D80BD4;
	Wed, 26 Aug 2026 06:47:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3OFOzJqyiG4z; Wed, 26 Aug 2026 06:47:25 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787726844;
	bh=Xj3A4uiuUX8bScD3/SOVPc+RQQ5kOZ6AKiglf7ZUwVQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TXUR0oYQTiqvk0R2bJ6Hds8uJlK1Za8Cww+6D2NfPqVQsSrvBdGesimciFVADZHda
	 9mjjdatFgVrtvV+O8B7G924CkbmpEehSFC1DzzIJvT7FZEaQBU35WcY4Xd4VRzGiIj
	 dbog9wFFQO4TmquySm3vOUTCabm6dcnCytK1g9hMM7Ae0htGCv99B+63Pq6JqwUmuv
	 evUHq8U02VChyFjpJYn2ayrZH+bF4wi1cuxAXTwecbTwnbGNsuqpbqKoZ+7ezPhDaG
	 /rI6JEG+Jt703tPUmMPOdEV+KSlD/x2wKfTasojj6lbDBb07UeeGzSLqsxhhuLe4Lt
	 9C6ENM6wbouEw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6E78580BE6;
	Wed, 26 Aug 2026 06:47:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4A11539E
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 06:47:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2F92C40556
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 06:47:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id m1aIKzdCWQl1 for <u-boot@lists.u-boot-project.org>;
 Wed, 26 Aug 2026 06:47:20 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20f::7;
 helo=osppr02cu001.outbound.protection.outlook.com;
 envelope-from=frieder.schrempf@kontron.de; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kontron.de header.i=@kontron.de header.a=rsa-sha256
 header.s=selector1 header.b=t/KnLrgu
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20f::7])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2D8D8403FF
 for <u-boot@lists.u-boot-project.org>; Wed, 26 Aug 2026 06:47:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WOpbu+el7G8K94ZhLi2C3x7xyESDRB9xlpVwrO8W/vWIVijkQEZluH0D1mamk6kxuJ5/26rLkG/oVtxAwU0KL4ESjAITxhfGPIX7zvXs3xNqICngymxtr+bgYEgwXU+KQjqc7rAi2VDG+w1F/kYiU0a5slqeC2mYtq7RLHxm0N0WiMtQvXvTW4s/pdWF00zR3G/0cppu/FzhnGw8pzcZJUAN6W2lxBSuTyPBDot5htSzkfgTGhFztOzCm2PPFh2x53aQwCb6xt+lLFxNBmip2oYR02SM8pMMQmdmqxaV2s0akoEtxSw6nHyGXC/rE7PoYYtwINa7Tzfy/iKCDulsLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xj3A4uiuUX8bScD3/SOVPc+RQQ5kOZ6AKiglf7ZUwVQ=;
 b=MWZ+VTIpiLFW1YsB2UgFysuqomme5vLXFwjmNqBFnjBg0a9SmE3zR0C5C4GMZ3/jvHp9l8u4K4mn8NxH0uDKiaLi5Lq6/kVFgrN8kTs4rJZ1oKckfiomAalD5UZ85s9VPZnQ+MOUFogdpp73pWgnnGsPY+VbPiIRWW0jMNJBISOjAlFQPPNvI+kwa5uiKsWjoxIVnAxRHNmdq3VcM7odynbnzyEOfE5ADKxUiUNJNhXuxTHV1+pseSgeyiiBKFIaAX4RNBbsNkXKgh1BDHsf4VmjwOk5e6uYEzgPL9PbOY74Ca7nDH/7Lz9Gf44KJyXKzhIsb40EsTUqWjvq0zamng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kontron.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xj3A4uiuUX8bScD3/SOVPc+RQQ5kOZ6AKiglf7ZUwVQ=;
 b=t/KnLrguoNN2sFooFFKEcMzNIdHPNh1GtdbjoGbZZTtfJIW2o1PB4raOL6zs7JO00ymecddYv7ooDINT403JK/y48rQDxTaukjAGoxivQgk4k0BoxWtr9XpglKd9MBx+umLbSEufE15b08ucOa0RIMvZ/1uU0du6EcCjeuJif3DD1FgC0mXq9QKYNS5iAIA50ISl56AU/eygMxAWVcQAnKkzB8M62bNtDjk6yARZJnLEeTreZmLe3nvoiTiQCX1Yd6u0OBbXRd2XCnrSWAtgxGuSWOA6vhAtU1yzkt+rTCukpK/r1/OoRxe5Wo0WHa16SUR1Dsqi6MEjcLyQG9QyEQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1fb::23)
 by AM0PR10MB3265.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:18c::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.9; Wed, 26 Aug
 2026 06:47:11 +0000
Received: from AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a276:4ad7:962:da22]) by AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a276:4ad7:962:da22%6]) with mapi id 15.21.0360.006; Wed, 26 Aug 2026
 06:47:11 +0000
Message-ID: <0db3e5e9-d54f-4571-99a1-9e5f34bde685@kontron.de>
Date: Wed, 26 Aug 2026 08:47:09 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 05/12] mtd: spi-nand: add EN75 BMT bad-block management
 support
To: Tom Rini <trini@konsulko.com>, AK Sharma <maskachoska@yahoo.com>
Cc: u-boot@lists.u-boot-project.org, Christian Marangi
 <ansuelsmth@gmail.com>, Daniel Schwierzeck <daniel.schwierzeck@gmail.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Jerome Forissier <jerome.forissier@arm.com>, Marek Vasut <marex@denx.de>,
 Michael Trimarchi <michael@amarulasolutions.com>
References: <20260825224330.713151-1-maskachoska@yahoo.com>
 <20260825224330.713151-6-maskachoska@yahoo.com>
 <20260825225908.GG523975@bill-the-cat>
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <20260825225908.GG523975@bill-the-cat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0020.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::21) To AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1fb::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4277:EE_|AM0PR10MB3265:EE_
X-MS-Office365-Filtering-Correlation-Id: dabc0ae1-97c0-46f9-98a1-08df033ddacc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|10067099003|18002099003|22082099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: E8qgHaBol86DQyeLN3d1IOB/0MbO6bEZ4RqxCwZN5zHpUaI73OwWOeLro54AlR6VUAQkMZOiXHwYN6yJPAFEeYrroKijNyEAwIgxOVBqvFiewVWQLNR27w+mwocYMQTOdgCaiRisaP0yJYF5yb4CgebNXVkLlzgMxq7uEvAuQCl1FnRE9oTXhcDGTs+N89nE5x6NqV77eHbBOeSkIHLxCA1Tz2nzHT4fJKZ9nU/pwBSeG5x0Ssm2dIUasNEkAKKdrwgrGPY3PQvIC1DW58o/LWQcUoWmdjiidUXho4O7pHtSspvxM2l1VGW0z7ivVmU7tEm6bije0pmy9fgGIuY8n/AEE8VCLwjm4q10Ps8BloHwgqZG5bWl8YuSoSjJXu5IC0ZZPIFmFhldoHDJzUEjPDqCA4AI+nZIJgP+UKXJL+74iAXenCIEO6YQsEZHIWFvRW9gRqKG0aklvipM8ebNuPtUfbyhswufRhGYofoXNrBgBxy+M9yPXRzOeC7E3uPHsMFBBAcM91+WAY76GXa0YU6+CGWrV44QK/NWzsuVkVuENa4gX3NVgtY+ugq2un+Rf7jcOuJBPygyRkbP8xhglTh/gTKhcmiacHOWMDzjaA23hBHAF3nCfc7yxu6UbaDCQTZG3HSyNvV1rj62ey8a4KY3mK6/nlIfD6COVqrqTBs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(10067099003)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Sy9rajdJYnliVzU2YlE1d21oOTdkajIwWmxkdHZZa085TjladW5pV3RSb3J2?=
 =?utf-8?B?Y1NaelplbjlLcGxYYjNqaGJ3UmZManBQaFc1bE9PVnA0RFd1RzJ1K2xkVkpt?=
 =?utf-8?B?Y1htQXliZVVlOW1yVmo4NlFIcmhiZm5iUEl3ZWVoWVJnOU03MEphNk0yeUs5?=
 =?utf-8?B?QTJNTUhxNXRoZVhTMGtiUEJJcjMrZVFQN3AxNG1zajJFUis2RnFyUkNlRU11?=
 =?utf-8?B?eTJkbm96MzgzOEFFOUFtYmc2UUxlVjBxNEZNK1V0aUhPc3FBYVdBU2RWejl6?=
 =?utf-8?B?SFpNN3l5RTV4eUJaSk85THJlRkE0cGlLNHVUT0MySGk0cHZuem53bWJVcFhz?=
 =?utf-8?B?NUJiVDQ5NC9VK0pnTVpMRnBKanJsT0ZsbEdqWkU1bnVwZ1NYYXhQS1FoQkVn?=
 =?utf-8?B?NlpwVDVndTRETHVGYXJJVFZkZFBZZzVNSWtod1ZiazY4QXdFT28yTnMwTEpB?=
 =?utf-8?B?ZUhHeWpsdS9XV1J3R2RpMGsyQjl5UloxOWJEaG5FN3RsSkYvQTRpVi9GeFpK?=
 =?utf-8?B?YktRS0Z2Nmh1bjNGcnJ6Y3gwYllvaXIvSEp5aGhYVFF4QkVhN0xMWnpYU2ZK?=
 =?utf-8?B?MUdqVDljK1d4T2RFaWlRK0NTUngrNHVNVmU0eXJ3TTFvdkJCaWFYSTdwS2s1?=
 =?utf-8?B?NUxyeitOcjQ5NFF0RFE1YjBReVNhS3hIMThJb3loQkV3Zi9sc3haOGMyMVZR?=
 =?utf-8?B?SFBVYkh2TXJGTzhIS29ZS2lLeUpobzAvQ1NpTzRkaFFRSVg4bUdaeGlLVnVC?=
 =?utf-8?B?ems3b2tXeWkzL0F4cC9tN2hDYk5WZzVxSjBTc3R2NEdjWDZxN1djSjFnR3dI?=
 =?utf-8?B?TmdJZU9MaDkwVk96OHc3VC9SOFBETVdOQWpnUitJc2lkSjBuL1hwVkQvMkR4?=
 =?utf-8?B?WXpRSmRzZ2hCRjErNkhnZW1KeTdVUlQ0aFV1NzM1MWFzM21DQ0VuWE5wZDgz?=
 =?utf-8?B?KzN3NWpBNFhUUmNtSUx4TC9QTGg0RlFxMGQ5bXJTTnV6SWhWVUhWQlNTWm9k?=
 =?utf-8?B?VFgyMFVRYUtHRjJScjZSR20yaGVMdUhWelhEaHFOcndrT21UdkpOY21INDk4?=
 =?utf-8?B?cTE3UFRsSFM5bWRCbldNN0hLQlo0OGk4Qk5rQmVYNkNOcWF3UkRHUHFIUFc2?=
 =?utf-8?B?OGNtalJXWUxucVVUdWxjTlRWVG1SL2d0UkRFa2dQMnlHRFhURDlzWTI1NTdl?=
 =?utf-8?B?bnZPTXd1bG9zNjRKeVRxaTZta2FPeXJsaDgrUWg1eGVIMmhpTHBBbVBtaHM4?=
 =?utf-8?B?cU5mSUFWbGVSMi9OK3lFM0NEaXZqNS9YenJ6VFR0cVBjZ1hHRUFoL1o2djVM?=
 =?utf-8?B?Y3JEUVZ6MGRkTWJSZ0kvNGFlVEhNdWVlVTdGMm5zSmVXWW1kZTBadWVQVzdn?=
 =?utf-8?B?U1JtSzR3UkRuKzBzbGJnSzF6WGdDMDBmMlNqUEhEMWFmbTM0VlhqOXRNYmdL?=
 =?utf-8?B?Yk8wb29nL3lLVy9NaWlpc0tJR25uQUJMcjdNK0JvUFB5S1FWZWFQV2hGeVlz?=
 =?utf-8?B?enlTWGU4Z3ZTLzUxVjh0WEllUmJWcWJwWUllYjBTVDZJOXNSMnhBbW1ZbGRV?=
 =?utf-8?B?Y20zNWdidGRTc0t2SVIvajA1TWJnNWRUZkxMUEtyY1padFFYWWl1cTR4dXJZ?=
 =?utf-8?B?UVJjM1M2eXZsR3VCQmJISTYrZVlvQ3F4SmNCbS9TMHV4YXNtZDBOa0FVMkRQ?=
 =?utf-8?B?Vk93MnZyaG51VDhLZnhkM2M4OVlrYVVQNU9lMzhBSlU3VlZOaFMyMjd2b2gw?=
 =?utf-8?B?dCs1QU9sRXR0R1RtcFJXb2NTYzJEWXZMb2djdkVEUWQ0ODFYWTc3alI4UmE2?=
 =?utf-8?B?blpFSUdUZDZDcHRMKzhoSmc5WFlsOXdqSlZHTDJrODUxMUM4cHROMUY3SE9M?=
 =?utf-8?B?UW00bzFHbkJhcy9UemsxMndJSFRtbit6VFlwdFRRNzdqWUlWUGxDd29FZWlJ?=
 =?utf-8?B?LzhiRkREaGh1RmhvQjl3eGlnc2tMcWR0RVV0cGY3eGcxUHdsa3MxdCtxaC9S?=
 =?utf-8?B?eUhlbnBFSVRQRDI5QUNKa3Rpd3d1cFU5MTV0ZU9lRXdPWXdJK1R4VlFJUnND?=
 =?utf-8?B?WURwd1RhTDJJZmp1TDRCb0dCZnA1M2FqRHUyMnVHVHFLRlJ0WGVQOVpDOUtH?=
 =?utf-8?B?OXh1OXJEY0MwdHk0MmdCQWM3UEhjVXRlQVhOcDliTGI3Tlo1QVZkZkx1U0lr?=
 =?utf-8?B?RlA3ck9UelpJU3hPenhZOEo1c0JnTVBza1pMWm1nRHZPU1BHbWIyVGppRUZn?=
 =?utf-8?B?RjJnRlpJY25pci83ZzR5cERyRXJJSGZ5N3VYUlJic2I4NE40ZHZ3WG8zb01s?=
 =?utf-8?B?dUVmb0lIZ01UZGR5Y1BvTnF1U2YyQXB6Sjkxa0FaZEpVYmdHZDFtNGxmaE1a?=
 =?utf-8?Q?VNhXT+hplBaimGiA=3D?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: dabc0ae1-97c0-46f9-98a1-08df033ddacc
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4277.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 06:47:11.0175 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CxVP51aBX1TuoMFVeQQNSTF3yipUuQh+Kz2ZxMAt7LOr2FkgCXGGg7SjAtwTmXI/7L4V2O38gifND+WDJAeFn4e97jJPh8rzl3jie/0QyVo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3265
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On 26.08.26 00:59, Tom Rini wrote:
> On Wed, Aug 26, 2026 at 04:12:00AM +0530, AK Sharma wrote:
> 
>> Add read support for the EcoNet/Airoha BMT/BBT (bad-block management
>> table) layout used by the EN75xx vendor bootloaders, so U-Boot maps the
>> SPI-NAND logical blocks the same way as the vendor firmware.
>>
>> Signed-off-by: AK Sharma <maskachoska@yahoo.com>
>> ---
>>  drivers/mtd/nand/spi/Kconfig    |   8 +
>>  drivers/mtd/nand/spi/Makefile   |   1 +
>>  drivers/mtd/nand/spi/core.c     |   9 +-
>>  drivers/mtd/nand/spi/en75_bmt.c | 665 ++++++++++++++++++++++++++++++++
>>  drivers/mtd/nand/spi/en75_bmt.h |  24 ++
>>  5 files changed, 706 insertions(+), 1 deletion(-)
>>  create mode 100644 drivers/mtd/nand/spi/en75_bmt.c
>>  create mode 100644 drivers/mtd/nand/spi/en75_bmt.h
>>
>> diff --git a/drivers/mtd/nand/spi/Kconfig b/drivers/mtd/nand/spi/Kconfig
>> index 1124dada..09531914 100644
>> --- a/drivers/mtd/nand/spi/Kconfig
>> +++ b/drivers/mtd/nand/spi/Kconfig
>> @@ -6,3 +6,11 @@ menuconfig MTD_SPI_NAND
>>  	select SPI_MEM
>>  	help
>>  	  This is the framework for the SPI NAND device drivers.
>> +
>> +config MTD_EN75_BMT
>> +	bool "EcoNet EN75xx vendor BMT/BBT translation (read-only)"
>> +	depends on MTD_SPI_NAND
>> +	help
>> +	  Honour the EcoNet/Airoha factory BBT and BMT so logical NAND
>> +	  addresses match the bootbase and Linux. Read-only: never rewrite
>> +	  the tables.
>> diff --git a/drivers/mtd/nand/spi/Makefile b/drivers/mtd/nand/spi/Makefile
>> index a7a0b2cb..20aa718d 100644
>> --- a/drivers/mtd/nand/spi/Makefile
>> +++ b/drivers/mtd/nand/spi/Makefile
>> @@ -1,6 +1,7 @@
>>  # SPDX-License-Identifier: GPL-2.0
>>  
>>  spinand-objs := core.o otp.o
>> +spinand-objs += $(if $(CONFIG_MTD_EN75_BMT),en75_bmt.o)
>>  spinand-objs += alliancememory.o ato.o esmt.o fmsh.o foresee.o gigadevice.o macronix.o
>>  spinand-objs += micron.o paragon.o skyhigh.o toshiba.o winbond.o xtx.o
>>  obj-$(CONFIG_MTD_SPI_NAND) += spinand.o
>> diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
>> index 14af4264..29fdefe2 100644
>> --- a/drivers/mtd/nand/spi/core.c
>> +++ b/drivers/mtd/nand/spi/core.c
>> @@ -33,6 +33,7 @@
>>  #include <linux/mtd/spinand.h>
>>  #include <linux/printk.h>
>>  #include <linux/delay.h>
>> +#include "en75_bmt.h"
>>  #endif
>>  
>>  struct spinand_plat {
>> @@ -1703,15 +1704,21 @@ static int spinand_probe(struct udevice *dev)
>>  #ifndef __UBOOT__
>>  	ret = mtd_device_register(mtd, NULL, 0);
>>  #else
>> +	ret = en75_bmt_attach(mtd);
>> +	if (ret)
>> +		goto err_spinand_cleanup;
>> +
>>  	ret = add_mtd_device(mtd);
>>  #endif
>>  	if (ret)
>> -		goto err_spinand_cleanup;
>> +		goto err_bmt_detach;
>>  
>>  	plat->mtd = mtd;
>>  
>>  	return 0;
>>  
>> +err_bmt_detach:
>> +	en75_bmt_detach(mtd);
>>  err_spinand_cleanup:
>>  	spinand_cleanup(spinand);
> 
> I am concerned about generic code path changes here, how is this handled
> in the upstream kernel?

I agree. I don't see any justification or explanation for adding
chip-specific code to the spinand core.

Also, would it be possible for you to upstream the support to the Linux
kernel first and then sync back to U-Boot?
