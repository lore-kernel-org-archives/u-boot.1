Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86A1FC02183
	for <u-boot@archiver.kernel.org>; Tue, 14 Jan 2025 13:25:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0636480657;
	Tue, 14 Jan 2025 14:25:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="KkQ329Ph";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 659E3806FB; Tue, 14 Jan 2025 14:25:50 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20625.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::625])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6ACBA8022E
 for <u-boot@lists.denx.de>; Tue, 14 Jan 2025 14:25:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pWZ4G/iIgDLrlRWbcMwKrfBjqjYtr5+GRo72ELWRKusrOcS16qbPvffSV4ASqIqP5hzt5deIkQo2TSZY984+m1oo+tnLucrduiVpw+G0VK7RrUduMFD+tboELypTiB967aqclwyPwnjxJWOUsT6gRrqPvr7J06KPf62nqq90jKHrJNOBBek16lGGPFY/jUq6DJwo1O6OC8kYZoFldC9TgLJGkiNApquiXHUUsG6hfhZhFeKBeslZ4VaeGa1KCqEGehe6sXdJSkACONowF+ZUEbESDlTAck6h7vjG3JYgpWiueYwdTeqI9HgUget77g/bqClu7mRDvGXyPpdTxf3MLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LMdBczIAQ0ZGbeD6BvtL1UA2W05uagUQ5/YvDEQ7sME=;
 b=FG9vms9RBm34fGIMBl0YBW5Dj38+Noas3PyofUbDLB7H8F1zpJuRTVOz6td7fz0d51BcLGBuaFGJBV8XqBA6TRgjm2IC6A24GQ2AGTTDcBCWXR7aJQpagVo4GUjcH5R9TR+fHSEp4yhJ05JoyTWKlUTJ5S8pRcwniXnopgDOdy0UAPexVV6b+xlfE8n7KPryBnVY8yWSUVPzuwugqwvBiu1hT7JSYPDI1cF/VxKU0tdyKEy1K4y9iwY0G8WpdyJe6zLyf0Ipk3fgEsH09TfxlBkp+dEZlw4RnXhHeaA0meR4xi1ymD0K9+191/kKIyt2BNzYp+WtRD2bsZkkSMBD0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LMdBczIAQ0ZGbeD6BvtL1UA2W05uagUQ5/YvDEQ7sME=;
 b=KkQ329Ph+1XrPKjqF1QWSpz01wR7mGR7rxRr5MF8Rrh81aRA8qGUHB8LQ3L8O4304VZdPAKVId5AhYAcorHPaCWMz3Ul5/kBSckYv5khQi5BtA5bCZRTZ6kMAEwYd0Ppjccq2y8PByWspCTACUQJ17CNkt/4RSgLYX4+WN6dkzw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by DU2PR04MB8582.eurprd04.prod.outlook.com (2603:10a6:10:2d9::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.12; Tue, 14 Jan
 2025 13:25:46 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%3]) with mapi id 15.20.8335.015; Tue, 14 Jan 2025
 13:25:45 +0000
Message-ID: <4bc57e54-50ea-42ef-bd77-983cc1740764@cherry.de>
Date: Tue, 14 Jan 2025 14:25:45 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] drivers/mmc/Kconfig: Remove extraneous BLK
 dependencies
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20241220222612.1757884-1-trini@konsulko.com>
 <20241220222612.1757884-2-trini@konsulko.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20241220222612.1757884-2-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0255.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::18) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|DU2PR04MB8582:EE_
X-MS-Office365-Filtering-Correlation-Id: ef277f18-e5ee-47f0-999e-08dd349ef3cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NnB3VXo4YjlydXNCNjdUWi85NnZQcFVVUmJUNEUvb1ZFcS9PTlBqMWRON1Zp?=
 =?utf-8?B?K0FmMWFQcWtjTVRTOThDUGZPRi9IczB0eGNNdEY4UEdod3lLN25RRUJsTmdQ?=
 =?utf-8?B?VDFFSjJmS3h3M0tHWUtQdXE1WWltS1M2aXpIU1pTMUJaMmYxdDBWUDd2Ly93?=
 =?utf-8?B?Q0xBY2ZqVVI3OTBoS2t3VUZ6WEFLKzhDQWhybzk0aUpLY3pQUGZOdTEyZjV6?=
 =?utf-8?B?aWtNWFRvbmJqaXlhQS9xVmd6WWlWam9oREJHOEtweVZ1dExvU2k1SEhEOVBw?=
 =?utf-8?B?TWcySGh1L3VmR2FiaitLbFl1ekNEM0xXN2NVVGJ6N0dIVFZheUhUN2ZmSElY?=
 =?utf-8?B?L1lOdThHOXA5SElvVC8zeDVBNW9NMjZILzBGczdaelJtWk9Mek4vdGIwbFRP?=
 =?utf-8?B?c0owbkFzQk0xczU1RVU3amtKZ3FiUmJsdW4wZ0dPS1VMKzljS1p4ak9sS3k0?=
 =?utf-8?B?SW50ck5aUnlSVFFsVlNuVjZPSWlWR3IxSldRZ1Z0RU5ubTdzMjkza0lLNDdO?=
 =?utf-8?B?b3Byd1ZJWTRMN0xhK1hJc0lmcmdWdTdNTEladlp3MkZHbGVBMGdFTG9VcTNl?=
 =?utf-8?B?U3hLZzR1RzNDaW1uWVBJVGNGZUJaL2xsaHR5blFZaDZabjlZR0NMZWFmcGdI?=
 =?utf-8?B?S01TSmJWZDhHcmV5a1BTL1dLM2RjWFZOSnVZYzIwbFVGTklPdTF3ZUlxU3pI?=
 =?utf-8?B?TG14V0dRanJ4NkFlb2laQzRLcW1QZUJjRzJ4Z1p4aytHeHBNdHErdG5zY0Jn?=
 =?utf-8?B?OVZsVDR3ajFHU05Wbng0QkhEWFhTNXdKbnRCeldHdmY0VkV0TEI2WWV3VDhU?=
 =?utf-8?B?UFA1WW9HR0pva1F6M3M0VXNSS3FlQ3RWc3ViaFVqS2p2M0xVNWZxVzhFa0Mw?=
 =?utf-8?B?aDZGQndGaEdvNVhEUFJueEJJOWY4cnJaWWhPTWx2bGhXWmlhaVMrSVczdGtj?=
 =?utf-8?B?alZHNGxvdFFza1hwYWNLL3VEUEcyMmVzNVRvWXpEOWJGUnFRTlRzMU1tcHB2?=
 =?utf-8?B?UWRNQ2tYNnJ3c0FWeWJZSVlLejRQN2d3Y0RzeW9udjQycmhRYTNIYlAycHBL?=
 =?utf-8?B?bi9uL1RidFl1ZVZLOURkRnFJb2ZlaFA4S2VzcWJWRzZyZG5mTVpZYlFGNmw4?=
 =?utf-8?B?T0haaDlST3N0ckM3NEVlSXVjaWVpWEFnR2F1WTVXRHVQY2pYSXMyajF1cURj?=
 =?utf-8?B?eWtjSFhwUFVMMVdLQ1JTVkh0U1RVd2xVa2dsTnU0T2p5NlhOVHZ1OVZXdUMv?=
 =?utf-8?B?SVBDamlxbmpOYmphc0FZZ0MzcFF3a3J0Z1VDRENSNXhmWlNqMmFZcjAydm9M?=
 =?utf-8?B?NWowa0NWcVhyVlI3dklvMlpxdUNzQXE3WTBpS1hVUDVIR0RScU5jcVF1eEto?=
 =?utf-8?B?K29mVDRwSDRFNTI3WEd2MEFwSkxBTVcxSDd0SkI5RHlSaktMUE80b3Q3eDVF?=
 =?utf-8?B?NGNsZmdUMXV0b3VDemJEVjNrUmsxVnRZVDVjSFp0UjkwZ05OOFJBSWU4RmJt?=
 =?utf-8?B?bVdhaWZMWjg2TnVxVCtobzJGSE5hajY2N2lXTUtoS0NiQTAwUmRwTG5lUHBn?=
 =?utf-8?B?WjhHMDh4T0dGTm9iVzRSS0dudllNUXFXb3JmM3pWNHdtWjZ4a2hLUjl6UmM5?=
 =?utf-8?B?S280T3BLYkYwU3oxTmRId2I5bHMvMzllcUdDd0dycGlvaW1PYkFYSEI1S0pR?=
 =?utf-8?B?THlueDhOLzNoLysvM09tNFJnWENPYmVVQzBIdHREWGw2Y2FxSHI5UFUvV2VY?=
 =?utf-8?B?U2JaNFVzNDhRSXc1ZFVwOFlSaTlzVE1odmVVOWplV05SRTYwc1JDWkgvb2Nk?=
 =?utf-8?B?SFVNNzNQcEp1NWpkd0RaV2pST005ZmZoMHcwUE5YcldDaGowakh3MnRrOHFK?=
 =?utf-8?Q?vToogfivT1ofp?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ckN1MzJjVytyWHRkQ2QyaFNpWEVkZGJVSmg5MVNqUkpEYW93ME9sZTNFL2Fn?=
 =?utf-8?B?UXBGYTFBVXJDcmVWcUxEcCtYUXoramVBM2JCb1d0UDNHS1FGVCtIOVY2YlYr?=
 =?utf-8?B?R3M1SithbmYzZlVXK3RQMjZ6cndMUW43VFNtdWduaUxkYndXYjBNODVKbWVi?=
 =?utf-8?B?RUg0RDFKUVJYTlRvbFdGWGhBN2Noa1lwTzVoNllyTEx2SFYydGNXYXZiRHZT?=
 =?utf-8?B?aVp6c3ArelB1Mjg1bkhIVEJMVkxSdUIrRjVUeEpTdVVYRVBjdG5ZTzYveUQ3?=
 =?utf-8?B?MWdTT1FabDNHRzltZ1hvR3ZYaU42dVRIYkM4dW5KaWVxL29nTTY0VmltY0hs?=
 =?utf-8?B?MUptRDJyNWdnSGF4dmtoV0xXaXRkZEN6MG9wakNPQlZucWhnTHZxMzRRY1dU?=
 =?utf-8?B?bU10YkFuL29ZZGdlbDJ6d3crR0c3NFQ1dG5IODZub3BpZ2l5RHRhYXNmMmRH?=
 =?utf-8?B?TGdEVUppejFNS2RuM2dJY1JHbzZLL01adnVGRFhGenBhYXpWOHlJL0JYWndB?=
 =?utf-8?B?OWtiaFV0THBnSUV2NTBMQ0NlWnNGRWY5SWw0Ym9ucTRtbTNDK3FSK2RRWnl0?=
 =?utf-8?B?di9YTW54MGc1VEVKNXdJNlJaZ3JROTdCNlVnQkkwTUtSTi9JdHpKNVFjRE9y?=
 =?utf-8?B?WE5JMzF4RlJacVNtdjlZcmRvZWJySDZvcmJuZkg5OEN1a1FINXozVndMSnpp?=
 =?utf-8?B?ZVkyYzRoaGhVaXNnaitkUnNlRXh3elEvUUpPQVFlMFZXNXZhSU94bkI4SnA3?=
 =?utf-8?B?VzR0UUlRQzNHblA4YWlFZ0Y0RlZ3TmE1U1pCUmM4cE90cDBlU09QY2V6ZkUz?=
 =?utf-8?B?MnlvL1pRRWdDcVp4aHZGRFFpVVRvSjdQZFVSeFpRUDh6VWhDRWxJNGZDaXJu?=
 =?utf-8?B?ZkdmV3lTU3VUQW12YnlwTmZTbG8ySjRGVy91T0hvVjVPVnYwSXhKSVZVeFht?=
 =?utf-8?B?elV2dWNuTWs2alVoWjFCYlllN0dUR3hyMjdIbExjamRvbUlsZnd2UzVnWDU2?=
 =?utf-8?B?NDIzS0ZTNWdTWWpqdGc2UVQ5Y2ZYTzBETFZiM05vb2JzVnVnL0xpa3RhbWZ5?=
 =?utf-8?B?d3RabWVQcklQU1dMTVFOaTRZbkhBanRhanl5SG5SQ0N5dVljdXoyNHdqTDBC?=
 =?utf-8?B?R1dIbDRzOWFsNHFFR2JKUGJHRkRIRDIrcG0ySzF0OXdZdVMyVlkrZWx2M3J0?=
 =?utf-8?B?WUhGUUt6a0NZaDFYcDg1Sm1lck5lNUY0RERscGVLM0RvZWM0V1pBYW5SanNh?=
 =?utf-8?B?dk1VdURVZkJWbnMwVHluNTBKVlpHTDFDdTgwcnV5N0lEMEhkdEl4c3BickFt?=
 =?utf-8?B?U2psSDRKOGZiRnZJc0FTKzlSUDRORW5tQXRaVzg2NkZaVkhES3dyeVdFUy8x?=
 =?utf-8?B?WVE2aXRhT0ljQU9VcTF4dFBnaXl5bXQ4aStzd3MyQVovT1Nab1g3aDF1UDFL?=
 =?utf-8?B?VEluRFFvQ1dQNGZTTlJwbFBQYkF0cENqQ2UrV1VLN0lHdHlyWUNtN1RaMkZ4?=
 =?utf-8?B?TDJFdnVjOHdLSUpUUWUrbG15RXg0TG1hQlNoVGl4ZFY3Tmw5bm5NeDlrY2ZZ?=
 =?utf-8?B?ZEdvRGJrSWFRc2N5R2ltT0ZxNnJrWEhYRXJQUythaWs0L3BIcWNrRTZFU1Vv?=
 =?utf-8?B?NFlqUUE4WVloL045akMxdUFvcmJxc2Z2RnZGRzZkeldXRGNHZXpJTXdRcHd6?=
 =?utf-8?B?ZWNIWUtPcVlMZ3o4N2lua0w0RGVyTW1CV0VNb3pMK05WMWJaUTJCUENDT2d1?=
 =?utf-8?B?eTZ1Y3NBT01NOTQ5WXIxY0FubkZzdi9wUG9kUzc2MHpkTXZFeWJzdWlLYWE1?=
 =?utf-8?B?R00xTjdVeWVaYTZiaXZjQWloVVdRUGtiblZXZUlpSEFZVnVGMVZOMXNBVEI3?=
 =?utf-8?B?eW1nWUtBalkrb0Ftd3hzSUE0eHhVZ3puSzQ0VjVyNks4RkNQYStGMVZmZlZW?=
 =?utf-8?B?LzBYbFA3THo5ZExhdTFKRmllNmRIV3RZcW81VmUrelE0blpSM0dBMVpGdlpo?=
 =?utf-8?B?MUlwdmxDRGFlOFFUNTRVSTQ5SVloeUpmbi9laWVCdGV4ckw1eGRPaGw4Y2Rp?=
 =?utf-8?B?aVhmaG1vckNDS0VjMkRrbXFiWWtqNGo5U2M3VC9CL2crYWVkVlJIV1E3djRP?=
 =?utf-8?B?bWo3ajQxTlBybmREQkR2Vjl4WFNBZGgzNDZGUDZEZWZVcUdNSHFtZitJZzFq?=
 =?utf-8?B?UVE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: ef277f18-e5ee-47f0-999e-08dd349ef3cf
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 13:25:45.8106 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5yzHY0hSPNePUCTHieKRYnyFiJxtIpzKqf8Wd2fu8svA1/e2DQdThDYbw1loPHHcDoAw3qT+I2D7lpf7X3N5dG68OEIlQxI4hW2Yh1Ie5Ms=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8582
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

Hi Tom,

On 12/20/24 11:22 PM, Tom Rini wrote:
> At this point in time, MMC will always have BLK enabled, so we do not

This was not clear to me as to why until I read the definition of the 
BLK symbol. Could you please reword the commit log to make this clearer? 
Something like:

At this point in time, BLK defaults to enabled when MMC is enabled, so 
we do not

With that,
Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
