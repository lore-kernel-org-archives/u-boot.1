Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA4F9C55162
	for <u-boot@archiver.kernel.org>; Thu, 30 Jul 2026 15:38:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B80BB81111;
	Thu, 30 Jul 2026 15:38:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GqDtyLHeWAbS; Thu, 30 Jul 2026 15:38:02 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A229F810F1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785425882;
	bh=zkPTKc/nNDbBfdHvv77Uls5i0o0KkB1wO+ZBM/oew8E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XKc3UOy9Ilsi92cyqEIdBQvNm0yCUoNXhCMEbpitADNb98QiCgLtphWmkHV7lv6uc
	 RMeXdXbriXDBooRP1mKpFCY9holmz2jHcEVFi/QNeIksevfR68S6NeDEXkFspeqCt0
	 7Hy6reJcCoKMfzfsYV88p1nVH+QhOZXxwCaVRo7QHbd1f6pizAhTkBnexghNfCuVLJ
	 1FgHxhE+mITAMrEpRodGlLI4KjD+JA0Nz/MfDtVjbDo/CTJYnT1aZsYTyDBlIXKIja
	 6aLP+6HTF3gtqH5wDhS2ruzJtWzB/PPKi9ZJblEKY37XZiMmTYiTDDG1WpjNNXn90x
	 LvrVcaENy3JwA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A229F810F1;
	Thu, 30 Jul 2026 15:38:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 81AA92CE
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 15:38:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 67581810F8
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 15:38:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6LBut7upBgYv for <u-boot@lists.u-boot-project.org>;
 Thu, 30 Jul 2026 15:38:00 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c20a::7;
 helo=pa4pr04cu001.outbound.protection.outlook.com;
 envelope-from=quentin.schulz@cherry.de; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 240F9810F1
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 240F9810F1
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 240F9810F1
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 15:37:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AfbaMog8cN6fNm0B3PbI4fuonTKzk2ImxEtCawbRDF+YmbEoae5/w2nTE+Ak/0BbI5gcuoZHAKgYEdN6EX9aDwwJOOE5f36o5Hkf1GkZl6Fn57CJ9uutCPMNMK58FbN99LISs/d7/O0GmG0evhMZXop2Gr79s7TaS7lIAQkgYem/SLOpugwY57SPm8NjBSeDbJ61DjwmiN0wPS6J+zu0cOPQT0TVLd6/7MF1x3dM18wUB5Lak1ZYQjr2cI2rGOWDEOcB1OQ+bLkPaGyBqXxmjE4V8n/p/CZgs3NQHirTOy2TcXze/XfAWfIcBLVrj+rvgz4WjytAe2Nx0SsbBvCVVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zkPTKc/nNDbBfdHvv77Uls5i0o0KkB1wO+ZBM/oew8E=;
 b=TsmVd+WJbPJCbzJz224ZPbU6r6j4jd4g2US7x50S87UEGzro1gwnwsv9zWxvIrcR7ZpfIK2gftUot7YL6K2qywJehfzX46lTWSLe8JiTDBIQkFM6XHKF2izPGU4klzRASrXoUjhIYFv6jo/+bEWHw6c23JJ7kDCi7xaPBDiaAznRIIXXkq2ubb5X78+rPFz9NbQdbNCEsq15kGt5X27bmj8hHi/kkOjr8caaIdJXni1nKz/jXS2S/uhbFZXINkrv37onEOwgQ/DP5TnxJxmDBsXopa8gECK+dgZuFSCl7WtNTQflpq3/iRhaK/jDsvhI27hQI/WwFA6nrj3qcwvBbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com (2603:10a6:102:b8::20)
 by PA1PR04MB11383.eurprd04.prod.outlook.com (2603:10a6:102:4f7::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Thu, 30 Jul
 2026 15:37:53 +0000
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7]) by PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7%6]) with mapi id 15.21.0270.012; Thu, 30 Jul 2026
 15:37:53 +0000
Message-ID: <75f48c14-bad9-4250-a4b5-321cc17bc1ec@cherry.de>
Date: Thu, 30 Jul 2026 17:37:52 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] rockchip: spl: replace ifdef by IS_ENABLED for
 timer_init() call condition
To: Johan Jonker <jbx6244@gmail.com>
Cc: kever.yang@rock-chips.com, sjg@chromium.org, ilias.apalodimas@linaro.org, 
 trini@konsulko.com, u-boot@lists.u-boot-project.org
References: <cded3ae1-b908-49c6-af92-30b931d160c1@gmail.com>
 <c6530788-e823-4cb4-905a-5473d9c00914@cherry.de>
 <6e43369a-832e-40d3-af23-a0981af84d75@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <6e43369a-832e-40d3-af23-a0981af84d75@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: AS4P195CA0044.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:65a::7) To PA4PR04MB7743.eurprd04.prod.outlook.com
 (2603:10a6:102:b8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7743:EE_|PA1PR04MB11383:EE_
X-MS-Office365-Filtering-Correlation-Id: 3aa520bc-63b5-4a35-36af-08deee50856a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|4143699003|6133799003|11063799006|4133799003|56012099006|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info: T1CYDi5+gGD045ZurhM24Cr/FXKAFZraBBUqs5QsgZR+XRQUifc+y+LUItoEdyCwfvI/yOgyXZYrKnJOjk6zFsx+PoZMVx4+zTRZULKtX0IiEgtK8VrEiM8Ukqz75n5/fF92/6Wr0qA+cnMb8EWvtNx8/t+upt/HXh2GTY/+GcS2c1UjO3UPgvBXYidVn3UO7PwuP9k8dms9aXFB1kl/t98E7rNDiCD5xWsl0S0ybRmCm9kuwyn8dKcwQ0E7GyHuKf2Xu2cr7sJ3HNDaoe2gFws47CcKR11bA6YbZ7z0b5vk7FnVp1lg/pCESMo3YvDFIiXtxE42Vqmt4y8LpGeMDI4iMCPFszoRZ1rxJql713GbtkNb4/EyyumHjxAfDzYvZbMHm0gZ5vWfY6NV/CGxB/uxfPbK3oJa+dKVW9uK5luAU9iJrgJfgGq4Wrsoulg5R7VNfFwZk30t+kgeFjw4zOMHm0RIZYbqdm+6yH697MOvmaIY/TH1zjKaUUJn4vo3Lh+iTuD4foUAVXhQqrv09BkrLT47WN8rTPV55lJa9/f9t4zlleXPyWffyIQTyPeg3SFVtpnmoGksJbr20aoxMpXS6EVr8D39u01OTOGzpAVS9VY2rlKpu7RI0IR+NzsgW/Qk4KHOy+017AdOdVbyYFkvOKVhExhO5PP3AA7J/Ec=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB7743.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(4143699003)(6133799003)(11063799006)(4133799003)(56012099006)(22082099003)(18002099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Sm1aOHgwWlkxVVBWQ2dPZExONk1RS2d5aDdKc1c5dUxMd1czZVYzbjRnUFhO?=
 =?utf-8?B?dGlCek5RYjBjTHBURVcwNi9PSUJBMkEreHliQzZzeitiZE44cUpBTUVieXVk?=
 =?utf-8?B?a1NYc2EzVHpMdzJtMGVOM1kwYlBIN1ZqenplamxJb2hJSVU1clRrQk52dnBa?=
 =?utf-8?B?Y2JpSnFpKzhSWTN6U0lEN1cwTHpLcm5Rell6TTVIRk1vWkNjWk9OZ2tjL0U5?=
 =?utf-8?B?NHE1MmFkVFlWYjgvcTAwZ2JGN0YxclRYRFFRWjQyMmN1N0hhRGFZd3V1bnJ1?=
 =?utf-8?B?eHZYU1JLYkYwbVN6ejlUN1V4SVArenhRbyt2OXlvWkd2c2ZIbWFwQXpPSTBz?=
 =?utf-8?B?cEc0K0JIbkloN0oycnFKSWt6ZmFnVGZUTUZkMDE1dk9pZVdsbCtWU3JXR2ll?=
 =?utf-8?B?N0dhMW94T3p4WVoxRFUzUGxyaGVHRzNvQjlBdDZSNUpsbHFwRUROR2pyVzBF?=
 =?utf-8?B?MDBjOCswTDlnbmVNekV6aHkrb2NCUTBsbDU0YmFQOG9ad0Urc0xJWklScXZm?=
 =?utf-8?B?QVRyR21EUENsSHRNZGNWRVpnQndsZ1RvVHRtYkE4aDJNWG03OGxWc2ZwamJq?=
 =?utf-8?B?dVVZSytqOVZ4UFpWMFR1U29aL2UwNDFhVGJXc25EVlkrRm9lUktzc2NpNjFF?=
 =?utf-8?B?NW9RQk9JTHF3TE9iTEdvT1VxYytvanMwdXdmcll5Qm52UnVqRGUrbWNFZWRL?=
 =?utf-8?B?a0Rxa2oyLzlIeDlpeFRlci9Yam51cEp2b0JzZ09NUE9XYWtzN0d4cjZaTzdx?=
 =?utf-8?B?YTRtVWl5YlFzYUt0em5SVUh1WWk4TGExK0Y1SHhKbnIrNDc4UUlVcmxNZEti?=
 =?utf-8?B?Qk13a3VlRVJ2Q25wWGJ1Z0ZaNnZMclpzakN0TU1hVTBFeG53WlVTVUFuaVJt?=
 =?utf-8?B?UUlzdGlpVkNkeUVSQVdPeC9PTThnczhhNjhya0pxNmNreU9HNUROZm5BTzls?=
 =?utf-8?B?Y3FPeWJ5K294TmhWQ0o2VndLMFJ3UW9XUmpFSFJFQTR1U3R1bjZUTjU0NVpu?=
 =?utf-8?B?ajkrMDQ0S0FGbzBEYzdlakV2bzFScXRjditZTk9qcUM2TXJYMXdmK2FYN3JQ?=
 =?utf-8?B?Y0Y3ZHQ0N0lNdnNvQnlBQXdZRVVZOG9FTFcraXpkcGdBUVNNM0JmWW5pMG5K?=
 =?utf-8?B?eGlWRmRwV1g2VWw3QlJRVktHY0ZRUFZvVStrTFFpODlkNlFEanBSSFJSbEtN?=
 =?utf-8?B?cjd4RmRjZ00zdmdJUTk1Ty9Cb1lPYVozd0d5bldIT0wvRjI0d3RqV2d4di9S?=
 =?utf-8?B?S3VVNFhJTElIR2xXbjVEc1BqVWxJZmR1TzEzY0IzeDd1RzVpNHJZNmUzSysw?=
 =?utf-8?B?eE0vVk5ZZXNVRFkyZW04Z1hGSkxtMkNMbzA0NmJ6Q1VVdGZKU0J3YVlmcHAv?=
 =?utf-8?B?cVF6M3E3UzkyVGtQZ1JMaXQ5ZUdCZ1g5dno2UldmTDM1Ym9mUkJLQzh6Rlp3?=
 =?utf-8?B?UlhWdWNDZkU0MFB6YXA2L2EvcitBQ3ZxSDJwSkYrK3N2K1k2UTZrU2U4QjVl?=
 =?utf-8?B?cEtqTDZEemJoRk5Hbzg0T05UWHJJS2JYQUZuOHhneHhoK1NOb1R6dEVNdk1j?=
 =?utf-8?B?WWY4a21kd2VhaWNUM2JyazJLY3lYc3l2YlhUSTg2ZDREWWRrM3EweTh0QUxs?=
 =?utf-8?B?OHdZN2pmcjlXYXJsNHZ3cTUzb1kzY2cxOXhmcGlBalJVM051b3RKazJJbUla?=
 =?utf-8?B?cUFxRFh6dis1UFozelVOOGI0S0RJZlhsVkNzaTFLMUMxRnVkM3ViUUp2Zis0?=
 =?utf-8?B?TXRyRGZUeURqUjFmTldjYkwybllCL09seE10VzBqVXVDV1lxd0o3bWdRUWNq?=
 =?utf-8?B?K3ZaSjhkaHdVazdhVVVkTU9qeWc2QThib3E3UVA5amRsbjhCUWdKeFRiakJi?=
 =?utf-8?B?Mnk5eEg0N1BEWWdCcW5EaXZxd1BMNUx4bUFwa1g2QVNwNUZXNEc5Ym9JT2Uz?=
 =?utf-8?B?Rms5dm5OM2xKRk53d3VZTWtGL0N3YTRlSkhpd1l1S00xaVQrT1I4QStZaE5m?=
 =?utf-8?B?RHV3TTlSNW8xWUlvWXlHRWxZM3dmZDR3emR6M0RGekRXRzZxbE12d1lCUG9i?=
 =?utf-8?B?TUtDNDZzZUxRbzFCN0hDTXpqS2RlbEdvYlAyR1FSdkwwNjBEMVhhTkFWRTB0?=
 =?utf-8?B?UjM2MFh0SDdpUG00ajNVZWtrV25lbEF4NEowL3FpWGdBZTNHaC9TbmZSeUFY?=
 =?utf-8?B?YXR6dkxLSUxWTEJLemNNY25sRmVPZTE1aUFTSUdXQ2taZHpMcFBBTTZjaFE4?=
 =?utf-8?B?dEl2QWdFMDM4YWg4UFdqL3B4RWFENlduTmw4L3B6UDJ1dGphZkk0RW1EcWhx?=
 =?utf-8?B?dGRqUWE4eENveC9OUzFYem5zWWJ6QTBHeUVGdUduN3hQazJVcjZtdz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 3aa520bc-63b5-4a35-36af-08deee50856a
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7743.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 15:37:53.8196 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MAfB5aSurZALbDtzEE+IeKnUKrxT0KM2WZScKSWmIZQlU6gaxVTbEqBxn8PsZZoqSC+oukdCTau1aUTDk/rBfZcLedhuDc0D+g3ZwH3Ldss=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11383
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zkPTKc/nNDbBfdHvv77Uls5i0o0KkB1wO+ZBM/oew8E=;
 b=h+w9G8UI2JvV0cqrn1nXF+3osHvKqEtKqGBJ4mh0o6BOuEGJ1eBTeqCdRkSvF3WUGk6ZzvxuRIpGDYni+fIsUHDoXLVhaq9/8WlPelmqoTzFGB4LCKUyLpxg8dbwxt8IQZGVuxB7+Txwmd/ZsRN/SJi3QUAVewIHFQr36SCOkT8=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=cherry.de header.i=@cherry.de header.a=rsa-sha256
 header.s=selector1 header.b=h+w9G8UI
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Johan,

On 7/24/26 11:53 AM, Johan Jonker wrote:
> 
> 
> On 7/24/26 10:45, Quentin Schulz wrote:
>> Hi Johan,
>>
>> On 7/24/26 12:17 AM, Johan Jonker wrote:
>>> Not all Rockchip SoC models use the ARM arch timer.
>>> Call the function timer_init() only when
>>> CONFIG_SYS_ARCH_TIMER is available.
>>> Replace the ifdef call condition by IS_ENABLED
>>> to increase build coverage and make the code easier to read.
>>>
>>> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
>>> Reviewed-by: Simon Glass <sjg@chromium.org>
>>> ---
>>>
>>> Previous version not needed for serie, so resend separate.
>>> https://patchwork.ozlabs.org/project/uboot/patch/20220403230659.12039-5-jbx6244@gmail.com/
>>>
>>
> 
> Hi Quentin,
>> You didn't answer Kever's question in the linked patch and I have the same question.
> 
> Yes we end up the same code. But...
> 
>>
>> This is essentially the same code, so what's the benefit, are you trying to fix a specific issue? How does this improve the situation?
>   > How does doing that increase code coverage... etc :)
> 
> This patch originates around the time this concept as introduced.
> We are changing all code to the new norm and we leave this as it is...
> Fix this as well as a favor to Simon as part of the review. As we are there then fix them all as this is the new norm.
>    
> https://patchwork.ozlabs.org/project/uboot/patch/20220403230659.12039-6-jbx6244@gmail.com/
> 

This doesn't point at what Simon could have said that prompted this 
patch. The pointed patch did actually fix something, and instead of using

#ifdef CONFIG_SYS_ARCH_TIMER

you used

     if (IS_ENABLED(CONFIG_SYS_ARCH_TIMER))

which is absolutely the correct and "modern" way of doing it.

> The concept:
> 
> Currently with #ifdef the compiler sees this code:
> =============
> 
> 	rockchip_stimer_init();
> 
> 	ret = dram_init();
> 
> =============
> 
> Now the compiler sees this code:
> 
> 
> int timer_init(void)
> {
> 	gd->arch.tbl = 0;
> 	gd->arch.tbu = 0;
> 
> #ifdef CFG_SYS_HZ_CLOCK
> 	gd->arch.timer_rate_hz = CFG_SYS_HZ_CLOCK;
> #else
> 	gd->arch.timer_rate_hz = read_cntfrq();
> #endif
> 	return 0;
> }
> 
> 
> 
> 	rockchip_stimer_init();
> 
> 	if (IS_ENABLED(CONFIG_SYS_ARCH_TIMER))
> 		timer_init();
> 
> 	ret = dram_init();
> 
> ============
> 
> By using IS_ENABLED and CONFIG_IS_ENABLED the compiler is able to look further into code and catch possible errors or warnings.

I don't know anything about compilers but I'm surprised this would 
actually do anything different than what we currently have.

If CONFIG_SYS_ARCH_TIMER is not set, then you get

if (0)
     timer_init();

which the compiler will (hopefully) see as a non-reachable branch and 
discard it.

Otherwise, it'll be:

if (1)
     timer_init();

which hopefully the compiler will simply replace without the branch:

timer_init();

Maybe Simon or someone else can teach me something here because my naive 
view on this is: does not make a difference. What kind of benefits do we 
have, what do you run to see those benefits?

> There is even a warning for it in ./scripts/checkpatch.pl
> 

I'm aware, I quite often trigger it :)

> ============
> __weak void rockchip_stimer_init(void)
> {
> #if defined(CONFIG_ROCKCHIP_STIMER_BASE)
> 
> #endif
> }
> ============
> There are exceptions like in rockchip_stimer_init where certain defines are missing, so that's still allowed.
> In all other settings we use IS_ENABLED and CONFIG_IS_ENABLED.
> Hope that explains your questions.
> 

Not really no, sorry.

The commit log is misleading and needs rewording. As far as my 
understanding goes, it's clean-up. Maybe there's something helpful for 
the compiler but you need to prove it because I don't see it (I'm 
interested to know if it does, so please tell us!).

Cheers,
Quentin
