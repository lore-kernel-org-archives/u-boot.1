Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B264CD4F4A
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 13:52:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A5DF84119;
	Mon, 18 May 2026 15:52:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sTxl17cE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AAEBE8460E; Mon, 18 May 2026 15:52:33 +0200 (CEST)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1821F83EF9
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 15:52:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E/AVfNRn62oe2T2hMi0YzSOMXhBDYq45JXKs/l9wDOc23eISTYRv7khC+yJKIcsdzptUFT0dEP7MmWKxnsG9EMuwII8Xl4c4T1WBlo9bTAMfxX9kPpRLn6I60qb3zk/qtL2UXIqmjFmou1EtwNrLMTPkTQTMLRjWcXexTIbl7JWHTWZEpr8+PObrBpBkjEcbVSoduD6Oz9i3CgrWFU7hJy5B/5Gen6tF3Y6gvnLZlQbvYxapBrqf6xkEd3ba9v8nGhZaQ7jGp8Xtt73ewtG2kUqT21M/6RcTmaOVzmC8dB2PxeAiyR18GOe86VdCpC+bbgh4klIG3Lhbg2TXQrdVoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2r7KSJ3qoQKxFjhYSIDpf7PcVvR2DIiJm4Glyi5rquM=;
 b=WJbEQKcbPf3uTZeGL+d32INzrKBHsxPKeG7KM5tb1qsl/LJjIG2rHqnder2ahjQaEdfOP85kOzq5ToMmblknyXA0cKQzSk6dZSWXjMON98YpSb+97wA7rOWtiQYqRjHJDgreEcUwy8eH6+hbXkIPPFdffTA6UrrrgnXmTXow3jzqMu8SWyCXnGnnZpsAybtk01dXbAuiK3neBm7Cs540KIiWSTS5ziwpBupDVkUOrxktUIlr5Lh/gJe9u74NoKLe3wtj4ub6Roe83fCR+gr2Q9of2q2I6UPdInve/naPiat8pefvnEeQXqurMx7UB4MBomssG7Y/WlmPnQdQ+FzDGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2r7KSJ3qoQKxFjhYSIDpf7PcVvR2DIiJm4Glyi5rquM=;
 b=sTxl17cEdEe1hEVB3yvDzI1P6AVrU9DeU9bo3RV8unDomDO4EfY1XrpHCBPRW7ogkA48Cu7AQMTuTaPMe9Ii15Uj35Lk7mfQBfxzEYNjAbymnEJgPj37eJlH3U/8eKZPGTrBLvlhaTO+e1VfjUyugpAYgOVbFi2M/OwecLo2PQw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by LV9PR12MB9808.namprd12.prod.outlook.com (2603:10b6:408:2e7::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Mon, 18 May
 2026 13:52:25 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%3]) with mapi id 15.21.0025.020; Mon, 18 May 2026
 13:52:25 +0000
Message-ID: <50aef2c8-562d-44c6-a8af-315a6266f07a@amd.com>
Date: Mon, 18 May 2026 15:52:17 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] reset: Add reset_reset() and reset_reset_bulk() API
To: Maarten Brock <Maarten.Brock@sttls.nl>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "git@amd.com" <git@amd.com>,
 Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
References: <cover.1778665323.git.michal.simek@amd.com>
 <b8229b9f7b357cf6013e8423831a9af1d69fefdb.1778665323.git.michal.simek@amd.com>
 <GV2PR05MB1194140D0CFDB4D8C63BB998183032@GV2PR05MB11941.eurprd05.prod.outlook.com>
 <0f7c82f8-dfff-4c0b-84c5-41f189ee042b@amd.com>
 <GV2PR05MB1194186BCEE688E85977E22FE83032@GV2PR05MB11941.eurprd05.prod.outlook.com>
 <12534d6c-6961-4fb7-80c3-d83c3f8d13dd@amd.com>
 <GV2PR05MB11941B4DBA7BBB814C32BFEAF83032@GV2PR05MB11941.eurprd05.prod.outlook.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <GV2PR05MB11941B4DBA7BBB814C32BFEAF83032@GV2PR05MB11941.eurprd05.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VIZP296CA0021.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:2a8::7) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|LV9PR12MB9808:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fc16b6b-db19-4942-dd02-08deb4e4b137
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|11063799003|4143699003|18002099003|56012099003|22082099003|3023799003;
X-Microsoft-Antispam-Message-Info: Xl67ldcYJ7n+WO33din1i8asOixXo1ltSiipCM2TYi37wuDZfJGmHF+bdiB1pPDdAyulioX00+h4VqiStWUV4x5Z5gPJzt2VF21q7+ELHYR32TBA9O7VLlFf27xNr6VSkLAFG+P+ynGFxCTgdNiNnwzc2rLcckl+goH4sacDSHFm2YY0wnv0N1WBdnq45HFbvTTWIpHUzCUD/M572UjRaJef4x0qTdu6U4hHdc+X9VCOMKpMUkOby/JsApJZk6NYFdhgcqazbcs7jGX6HgU0F4NBAEFoGw0rwh6Yl54tE3insdr+HekzMsGFqpZzLc5UAG5bVC0cqxGlKlYC7TXVZcUGfywMwUHqyxGBVTgGu0OsBq35nmasvjfx1TvrJqG2FiRM2cr4fqayejkUXSYqGmKfkHFnOtFmHpqWpdHjhjZgJamUNbJ6Zt7kP1mNczUUMKkVRz6zSU8p+k9BZra5qepolYwEaqSGkuKKF98IVK65G6/F9WtJ+wyg4jWDBnG4omqgc0xz9nKdVfHshP8DdADxDQyQxo9yUAs7fKNZK0xHb39/H2wY2sNIGt2fp3FWQa4IBO9PbqsFQ7vLE2UB39/DDCHh5pkkbD0tcXgtQMAB2eXBxUMTK/Am0M0cehXkvaCD8Qeor6VeUZDUKM4Q/45BsPz3tzczdpwmxWi9jRnU8Ja7OZEVR/oEj316k1my
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(11063799003)(4143699003)(18002099003)(56012099003)(22082099003)(3023799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZHpuM2JCd0xVVG4vcWUwY1hwTGp1bUtJYU9DZTdEKzJHUHNUN1UvUDZSaTkr?=
 =?utf-8?B?RHV1disxSkVKOWNnSE9ydEVGV1hWblRzWE9GNmxEak5NM1RDRjR5eFhybWVF?=
 =?utf-8?B?WTFmRlFORlN4MENIdnpGUkVid1Nta1JydXExN1psL0U1azRHOHVsRk9aUGR5?=
 =?utf-8?B?bUxIb2ljdjdLMXFCVjJ1bnJqYUtzRFUyTnVycUtHSDVxckdnZjBVRTZNdklz?=
 =?utf-8?B?TEN2QlBST29Td1hzT3hraGFMRG9yT0cvOUhvczh5cHB3ZWw4UWxrTEFYejRG?=
 =?utf-8?B?WVYyYzVETmVwcjNEd1F1MEVPdmk0ZDdJTjcwVjVwRmtCaWMrTEVGYjZZVzNV?=
 =?utf-8?B?WHpHejVydko2dkxOamdTQlpmTitCUVZqdE1uWTVYRXN0cjVqRytQMzY4aTRT?=
 =?utf-8?B?TlBhM2Z3bWxpbVp1Z2JmcHg5NVg1QmI0UnlSaWRwL3I4amNkcFdkZWpQTVk0?=
 =?utf-8?B?YTFnYU83aTBSSlNnbXJCUTVvSzZNWmo3Y0RTdVhQa2J5WllpYmlwRk9qMUxt?=
 =?utf-8?B?eHhnSXRYRUsvTHdpTUZHbVl3MGU5ci9GL3NKTjVXa0ViUjhMZDRkeVQ3cGdv?=
 =?utf-8?B?TG43RWRzaUprWGpiVVdEOEdSUnNzMWE3MEJHZDdOSWp4SmpDNTZ6anFGbmwr?=
 =?utf-8?B?Y0ZTSnUzU1FVdGxJZlNrTkJHUnpoTzVFdVUvRUZwNW40SDFMZyszTTd3Vkk3?=
 =?utf-8?B?M0cxckFQMklvaUQzdGRKOTcwd3F2L01MTW5IRVJVYURaSFAxSDNuYWF6eTBv?=
 =?utf-8?B?UlpQRm43QXdNMXg3c3pJYlNMUTNKdjZqL0RQTVVKKzk1ZU9mZU1QeHpHN0JY?=
 =?utf-8?B?ei9VdGJyNUhTbHJJTVZEWkdzWVZIU2xMTCtrOW5mWksvT2pKS2pnSWRITUZr?=
 =?utf-8?B?dGhFUW5JMmFhZmJJclRrYk5hVS81bHpiRkVpd2tSYnlOakthcVhuYzcxT0tn?=
 =?utf-8?B?My9TWWRvNmNDOC9neCtUWkFZcUIxS3VFMUtmbWpmeGt2ODBzYW1JWjNsSWNt?=
 =?utf-8?B?RzIxc0lUNGdKamo5Q3JucTdjelkwak9TMEFLNW1KcHBwTkhPUk8vVVBSck5a?=
 =?utf-8?B?WGtDVi95emZLZVlwVnBYTUJpTnZwQnk0bWRFaysvcDZXNUlyanhSOEIzWFAy?=
 =?utf-8?B?a1hWaERETjJCRE9kVERZdXQ0MEh0Nks3dGViTWgrbWlrRU4yWjNteVJYcWVv?=
 =?utf-8?B?WG0vSFR0QjR1Ymoxd1Zxc2dvTXFESi9KdTE5QmhJTGN2Qy9aS3hMdTVWMk5J?=
 =?utf-8?B?a3Fkck1JRmsxVHZuTzl5MTYxUmZ3QTBxT1dsMGZmNWo4cysrSGl5UmpSYStt?=
 =?utf-8?B?YlF3aUIzM2VaOFM0QjJxRHhuNk5pT2ZML0JkajdNbi9ZZDZPMk9MaGlYSXZG?=
 =?utf-8?B?VjFIM3ZiYkZRbldnMkpqaWRNVURMaytsWDllUGkyZFJkQmtqSkVLYVZ0Ty9W?=
 =?utf-8?B?VElaaGZGVDlWNFJXS0Uzc2JmcmtXbUlLeE5TQ1pHOXNWNkxJNkxpMlJyOXVl?=
 =?utf-8?B?b2pPbG84cVQ3ZmlNOThzYmJEWUk4NldIbHRKUnR1OWIyWkRCdlhjdTl5cFNx?=
 =?utf-8?B?blEzS3ZqWkdoUVBoNnVuME9ES01Ra3ZPZTQ1YUJEOSs1RzRqQ0hVcFk0aTRE?=
 =?utf-8?B?VDltT3VxRkZ2dGJJMDh6V2xTU29zL0t1VnFHc20xWXcvQm9IZnJtN1p2aG5K?=
 =?utf-8?B?MG51ZnZlYTZqalY5d3B4UEFEdzdNc0xlNmRFV0ZTRzNybVpTVDFWNmQrbkpw?=
 =?utf-8?B?TER2aEFGbXByWEcvcGpTV3lNUzZwRHFnWmdQQldKYWMzb0lTQWhQY1pKQklr?=
 =?utf-8?B?b2xuVENTeXk4OWg5V1BUTzVwOEViaWdQZmV0bWJLemNtNXhmYVJpNVVKTEZ2?=
 =?utf-8?B?Q3NLQlFxWWVrY2xvdUJkWkdHUkdNcGV2cmFLdXdZdkJEM1RSZ2tmOEF4SnRF?=
 =?utf-8?B?WG9IeUwwK3VRd1cwckp3OFBVSmVRdXRCSjJJTGp6R3J1bWpRbDA5Y0FDUW5u?=
 =?utf-8?B?aVFGdkVnU0FwYmV2VEh1WXVGNHlzVnFDNzh4K2R4K2owb2tFQm5VTjFoTGZT?=
 =?utf-8?B?OWJob0hnQ3oxc0dBSGNQTERkbEdOd1FWN01CNVlsZHlHZkQycW45Ymowd0Nl?=
 =?utf-8?B?UkY2NXA1dUQ2UkpicFg0TTR3bjJ6a2Nia3JXRmdySHhzcHIvTFc0bkJwRGdL?=
 =?utf-8?B?M3N4SW1RazN0a2lDTGR4RldJL2ZYSTU1UVcvNi9XczJOMWQxekVKSkt1ajdG?=
 =?utf-8?B?eW5KRGZRb3llbzBsSnUyTnBrODlGV1pvQjI2VVQvWjZ3cTh4WEw3aGxsbTFC?=
 =?utf-8?B?dithMDNqV3RWLzNVVmFjWWF1L3JDTGRQckdQTDFMUGR2NVFRaXV2Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fc16b6b-db19-4942-dd02-08deb4e4b137
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 13:52:25.3283 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OO1fp9S2D1N7xWoUaCZ+6zKG7VYEPWskqE5bAv7Q9EG73UL0ifxPctjAopj1jpA5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9808
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



On 5/18/26 15:40, Maarten Brock wrote:
> Hello Michal,
> 
>> From: Michal Simek <michal.simek@amd.com>
>> On 5/18/26 14:07, Maarten Brock wrote:
>>>> From: Michal Simek <michal.simek@amd.com>
>>>> On 5/18/26 12:21, Maarten Brock wrote:
>>>>
>>>> I expect you would like to do it like this right?
>>>>
>>>> int reset_reset_bulk(struct reset_ctl_bulk *bulk, ulong delay_us)
>>>> {
>>>> 	int ret;
>>>>
>>>> 	ret = reset_assert_bulk(bulk);
>>>> 	if (ret) {
>>>> 		dev_err(bus, "Failed to assert reset: %d\n", ret);
>>>> 		return ret;
>>>> 	}
>>>>
>>>> 	udelay(delay_us);
>>>>
>>>> 	/* Deassert all OSPI reset lines */
>>>> 	ret = reset_deassert_bulk(bulk);
>>>> 	if (ret) {
>>>> 		dev_err(bus, "Failed to deassert reset: %d\n", ret);
>>>> 		return ret;
>>>> 	}
>>>>
>>>> 	return 0;
>>>> }
>>>
>>> That is correct.
>>> And a single delay of delay_us takes less time than N*delay_us (for N>1), so the total startup time is smaller (a.k.a. faster startup).
>>
>> It really depends on other factors and delay time. In our case it is not just
>> MMIO access. But it is SMC to TF-A and then seconding request over mailbox to
>> another firmware to ack it first and then do it. And with above you would have
>> to do twice compare to once.
>>
>> I can do another optimization which is that if bulk->count is 1 then call
>> reset_reset() directly and for others do what you see above.
>>
>> What do you think?
> 
> I very much doubt that all sorts of actions and compares will ever take more time than 1 us, unless some serial protocol is involved (uart/spi/i2c).
> So, I expect that delay_us is always the dominant elapsed time. And N*delay_us even more so.
> 
> I do understand that if the delay is handled by rst_reset() and underlying hardware, things might be different.
> So special handling of bulk->count=1 or *all* bulk resets are handled by rst_reset() could be a good idea.
> 
> How about something like this?
> 
> int reset_reset_bulk(struct reset_ctl_bulk *bulk, ulong delay_us)
> {
> 	int i, ret, soft = 0;
> 
> 	for (i = 0; i < bulk->count; i++) {
> 		struct reset_ops *ops = reset_dev_ops(bulk->resets[i].dev);
> 
> 		if (ops->rst_reset) {
> 			ret = ops->rst_reset(&bulk->resets[i], delay_us);
> 		} else {
> 			ret = reset_assert(&bulk->resets[i]);
> 			soft++;

But this will have weird behavior when you have multiple reset controllers where 
one has rst_reset implemented and another not. Then on that one with rst_reset 
another deassert is going to be called.

Thanks,
Michal
