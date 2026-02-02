Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94267E73158
	for <u-boot@archiver.kernel.org>; Mon,  2 Feb 2026 11:07:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C268583E0E;
	Mon,  2 Feb 2026 12:07:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="Gk1OGAWL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 705B183E0F; Mon,  2 Feb 2026 12:07:45 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F18B83DF3
 for <u-boot@lists.denx.de>; Mon,  2 Feb 2026 12:07:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rOl2M5dWZV4XtBLC0qpkPGtOXcToaXPvKgFwfPuK6jc/EBNBGzk8QcoZhVu9PWAGdNYYbvKeqaeBPNsCqShh6KLivrDltjMHR+SURjDXFz9vtfh1npuWyu3wbM+Ghjg3xF2HoiNrppU8X74YjVb5bBJKp1EHI/oxjRsYogh09B6EAxajX+7THQl6MHT96Z9bR7ghf5iQfGwCtnpX4ehEOkf1rYzGbFdzaovW9mDrQJx/Ghu8YQn77QlE+PzfMsgmgz1JK1sgGqU2C3vIL2ZvrFtoGRnDkCCTb/E2VZT4oyBIYFMEyiQCjfTceaCrOEpDOOF1Q7+L06YPrEXyWloQWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BhVk/IzWfeOxOoXzVY/YiiJc/VoQN1uiyGFv0u/i9dw=;
 b=OsB3CdZKlfW+a/VfUwWtQO6sN2fbukngDibBN5dlJE/EppKEXl7m5mpB3nwCCZnlsTqOOe4KTJ6C428LzaswwQBOX2vJVYIIq3wX3LwdJYwg/rdvPWHhUhjTmePc/WVLoKS+/jO5/QOZTSfOt3Vu3LyZiioVR6NhST5k6ojvLJF2awMmB67BiJcRVAODu80CA75x2B4iJv9YgnAHqYCYt/TBKZ7TCQgNP5ANOgK8BItdvqW4NYXS2e2VzbZkykH7zNHXfNvIKkyWjN6W0Dq1Qrnvhh4TbbCD0TEkxgsBOdiWbQ7BJlqa/BRt5rZBFXHL3vOMRMSsNz5HHxXYmbwKPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BhVk/IzWfeOxOoXzVY/YiiJc/VoQN1uiyGFv0u/i9dw=;
 b=Gk1OGAWLDyy1DKFq8xcMkBkfwXzujj8r3BHCs5Gf+wwaXW7wYQiJexm7IBiVM15swrYr1VPXGyUkTOmf7fKf1+ejFXU8JyclKTvkwAZARELW+HjpoeDtGTbvnEHs1vLV9GPxjfnUgBjNvoJD883l+XEg/BMWnypGJdRTfKq+Lgg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by AM8PR04MB7201.eurprd04.prod.outlook.com (2603:10a6:20b:1d3::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 11:07:40 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9564.016; Mon, 2 Feb 2026
 11:07:39 +0000
Message-ID: <1f05fa84-0f93-4079-a066-40c733f308f7@cherry.de>
Date: Mon, 2 Feb 2026 12:07:25 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: rk3568: Include all addressable DRAM in memory
 map
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
References: <20260129193153.2232395-1-jonas@kwiboo.se>
 <8bd0b00f-9631-4c36-bb73-280e4943dccc@cherry.de>
 <544c09eb-7eec-40f1-b480-d5a60a88b9cb@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <544c09eb-7eec-40f1-b480-d5a60a88b9cb@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0163.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ba::8) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|AM8PR04MB7201:EE_
X-MS-Office365-Filtering-Correlation-Id: d7b26cb4-35af-4497-5a95-08de624b4748
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bEVyV2pFY1RFVGQrSjRVZVY2bzdhTEppMkM1RS9tWFdYdFRtUlVDRDBHb2dw?=
 =?utf-8?B?MnRQd1A4VmNtZFA3eWFOWTBzUlhzQVFNYkRzTmxaTlZKVDBndEs1MStGZWFx?=
 =?utf-8?B?WmQwMkNaVEhJbE1mQnJlRU90QWRyRVR6aWpvc0E3RlFjV29XWk8rUEVGUTAv?=
 =?utf-8?B?azhzbWp0aFhRNmRYLzErNVZjOG9sVVk2WDZ2MFdISGZUSHRKYTZEZGwydWVn?=
 =?utf-8?B?Zm52a1duckxBSUZWYWFzMkZQM1dCbUdpZ1FyekF5Q2EvMGVqcURVTWR4ZlJT?=
 =?utf-8?B?T0lpWDY2YVB5bXBnOEc2ZmJvUWFuaWN3WDJnaG04NkdUL243MzUvcEhvM1dU?=
 =?utf-8?B?NU5IRnJBV3k0c05qUW5nZU5Ec01JbWgzSmZYRmxuR1Z3L2RrTWhHWjZLS3Fa?=
 =?utf-8?B?bVBGV3d4Y2VuelJFNmNmSGJLbkMzMlNhN2c1ZUMzMjZ4am40ZExMZ2ZYRTdu?=
 =?utf-8?B?S2RDSStyd0FiaFFqLzYzb3I1anVYQk1sRTlaSU5hYTA1Q1BKYXVwY1hkUXhu?=
 =?utf-8?B?Sm9UWmtuTTJQWDdzSHEzL0h2bWw4eUtmWW5qZXlLQkpUVGJERmwzdUlTVTU0?=
 =?utf-8?B?cDgrUm1aOVd4UkJ1TjN6anMzai9PQkE0bjJIc0duQWdvOWtsclNFdys3cXBM?=
 =?utf-8?B?TlMrZ3luZHgxVTN1UGNtMStVQUlsRndGZThGSFZQcXVRaVJGd0g0M1VSVUlt?=
 =?utf-8?B?T0pQNVQ3QkpkTFhxTklYRmdrTjJtS3d3TFZhRHF4M0V6Y3Rad1krSVRzTmE0?=
 =?utf-8?B?TnBqS1M2cEpiazZFN0YrMkRGazV3T0U3UnZTVE5qUDBlMC9wVGowcjgva05P?=
 =?utf-8?B?cmJtL1hHNnJEZVdyNC9BU2ozc25vTWVqZnRRRG1tRVR0NjM0VjZSdWwvQlM1?=
 =?utf-8?B?MDhuWjAvSzAyMXJxZ2wvd25uTi9LK2tldmoxQWEyTnVWZDE1RFc3VHBxMzF4?=
 =?utf-8?B?SXBxdlFYOTVqUTdBbVY5cVRTclRxSTZhOURnTUVZRkdmdXh2QXdoVmtLRFpR?=
 =?utf-8?B?cE1vK0tpS1ZkRTI5QUFidlU5b0VYZElBd0tSSWRFRzZMbE1ncS93Sy9OMEpN?=
 =?utf-8?B?U1JuUU0xdFN1ek1rVTBxRzFkYXVnZ2FReVJpSy9acC9JMUIxaGduMDR0Y1hH?=
 =?utf-8?B?MDlSSVZQcEs1TjhMVEZNWDB1bXRjdFZ4MC9sVUFhZ3NGYWRvTllHZ0dnNVJW?=
 =?utf-8?B?UFQrbkNic3NUWlV3YzNxL1dJREYwcGxjQjUxOTFBS1djMmVxNU05SlI3Mllq?=
 =?utf-8?B?YjNkNG9ja3Vac0xqNUNLQ3RrL2FzcmJNV3h0NmwyV2t4ekt0OCs3VDlRRHFU?=
 =?utf-8?B?MFNGM0krSzJMZElOa2dCQ21TR3pVZUJJRjE4OU9qUEJXOFdVa0c1WkpES1Bu?=
 =?utf-8?B?UWpCaFJDcjVYYWQwZDdxcDh3N3VicER5T2hLOWhJOE9HOVdaWVhmaG5Makkv?=
 =?utf-8?B?a1d5WmhDRjI2dHJXUVl2VysvZHpCOFIxK1p4ZHUxS1JqcDdRMXh2eFlBYk9h?=
 =?utf-8?B?S1E4d2ZRcXFXOGtGNXprc3huVDVBQU9yQ0YrdFZIRWNLSFdBNUluTTZNaFpH?=
 =?utf-8?B?eWlTOHJSdkJ1VlZ0OGNPR1ZvUVpIYkJvaG1mdDdNWEdSalhML0ozRzBWY0Vr?=
 =?utf-8?B?akhZMldtTCtNSDNIeE9LSnpiSjdReFVaU0YrYjl2anRuVDhiT09OTkRwRWRC?=
 =?utf-8?B?NzRNNTlYZW05WDdUamxlOHJFemJZdE1JcE5nYkdSL3BNeUNvOHN0ZmpnVHJE?=
 =?utf-8?B?YUR2N21VSW5tZXVWcFZ4K3ZrcWM5VVB2MDNSeWN1VG5yU2lhcnlnd012bC8v?=
 =?utf-8?B?cFFaV0x0YkROaFlJTk9rTXptQlFheXljWXNTbzZPeDJVQ2NVS2ZNYS9paGFr?=
 =?utf-8?B?LzZGdGpOV0hQM2l2MVpDQzVhOTZrTWpwVEdENTcwMWpkMGwzUElZVm5LQ1Nh?=
 =?utf-8?B?QUFCaGRNWEg4WHBCamtJbnpDS1JuOVptMGkzcUlUV3hvUG01VXpCbVpaZm9X?=
 =?utf-8?B?cjl4UiswSkVaTU9BN01MU3NBWnBzZTBEV0RpUUtNRW5Pcy9SOFNNK2EwbnJY?=
 =?utf-8?B?c1NhSkRoNDdvckZlY0dydFQ0c292Y2Z1KzIvMzZYdWlzNVo1K1RZOGtjTXdj?=
 =?utf-8?Q?tvT4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QTg1am80djYyVjBTVnJUaTIxUERpRUNxdExkampONElTMG8zWEJtMGxKM2d4?=
 =?utf-8?B?K3Y5VER0NjN3SnQ3VE9jRXlwWEJDeU5Xak1PQTlnWElMT1BVSURWMUdOdk9M?=
 =?utf-8?B?ckQxZzBFK05qRjBFZTJTbDhMZ0UybXhGbDNDalFiYzQ1SXZPemhiRFJJY1Nq?=
 =?utf-8?B?M3pIekc1STJsNmxGTUZ0cTJwQm12T2l4eDQzY0NCVnpEellQdE10amROUDdS?=
 =?utf-8?B?YmhWcVY0V3E5OVl4UUQ1SVVQWGVXamdzcTI2T1p4QjNrV1dtelB2c1Z4TnNZ?=
 =?utf-8?B?eUd6bjBKaVNUQU5LU21kTnAycWJkLzNNc1AvcGJFY3psWkhLT3dpRWVLQk56?=
 =?utf-8?B?N1RIalhPRWtFRVJoc0ZMZVhOY0phUEVhbXRiU0JjazJXc0tkV0dOR0Nubmpu?=
 =?utf-8?B?M0tzaUd1S2t5clBaS2lIYkRoZ2FYQVZTQ1FRdVNDRERxdnZLd1JnczROb05J?=
 =?utf-8?B?YzhLblNhMXA1L1BHb0Zzb2M3TFJWZnc0SmlaUnNEM1lVZ01rdTJMM1FBeGFu?=
 =?utf-8?B?VzUyWE5JaksrRGhQOVdlZm1WR2g4RFV1Q002SlZPekJMdCtmSlFRSjQ0ZDBa?=
 =?utf-8?B?dVpQajI4VDdhcGV3bm5KNjVWaFYrSjZ6QVh0NEh1cndZNGl5WXc3czlhWlZC?=
 =?utf-8?B?SVgvcE1SRUtPaG9jV1Vzc28vdnpQd3ZMTU9yNVRFUW44YzhHT2Y4U29udjQr?=
 =?utf-8?B?Njk5WE9PMWk2Y01GdTdyaFdZaVhHQlVqTjRRSlppc1Awc1M1THh4N25LVm9G?=
 =?utf-8?B?N3o0L2dpWGk5OXRVeDI4NTZkSGtDQ3JaQUk1TXlDNGd2cmdSSVNiUHNXanlz?=
 =?utf-8?B?Y0ZDUUlWNUp4aWdzamxCUTVwMzBsOC95RXk3cmxIVCtRTllRdXJyYmFreUJi?=
 =?utf-8?B?N1JUeXBYUkcrb0ZLZWZDa0FZTHI2aVNjT1ozemEvS2lkMDRybnFKV3BwTkFM?=
 =?utf-8?B?YXo1MTB0M1RUREZmeXRjakxkNlpzQmpMWXl4UmZEcDAzVGhxTnVlM2w0Vm9x?=
 =?utf-8?B?dEpHT3NsL25mdU5wNmxnYUlNVnJIQjlXZHp3WVZDd3k5YnpTbkxwNHU1Y1RJ?=
 =?utf-8?B?M2R1TTFxQnVuczZpLy9UNFp6MlptbmJiWEExOGw4N2lwRTBoendRVnZZSGd0?=
 =?utf-8?B?cFVTc2cyaVFGSXZhVWpIRVZlQ3JvK2JrZ2E1SG9CRjNlS0svNU52cW9CdkpG?=
 =?utf-8?B?UjFBTkUxRmdOS1phZlVSRWVLSWZwYjA5WXVIUk1oWVl4dHZiZ1pqcTBYNG05?=
 =?utf-8?B?MUpsNTA0VmpXRDVVQUJ5UXlJbGtsT254cFpReEQ5VzZpQjhPdE9pckJzVjNU?=
 =?utf-8?B?OTVqend4NGdjYVIzanVlWEEvZzFTNXowTS9Xc2ZPMjZZZjVJWHZQdGNvQmkw?=
 =?utf-8?B?eVJUMk1LdkpOY3l6emFpZTNxb2tocWFHTGJBalBSNjh0SVEvZjFkWDMwQUZp?=
 =?utf-8?B?TDRPQ09FR3pnSDNxR0xncEhyQTFZL1cwT2ROSk10disvN1htZkhJa2hQbmxu?=
 =?utf-8?B?SEdyODhxd3FwMlE0ckhlOFduYSswS0YydVNKdHNDWUViSVFJaWE4MjdMWFp2?=
 =?utf-8?B?SklUYzlkS2QvRTB2N29QZyt1a3NrK3U1dkt1QmhuMkpsWDNSYUxUcnVnYXhv?=
 =?utf-8?B?WVFqQWdWbFpBYjFrTUI4OUxZWjM3RlZpVks5NFlveWJ1b3VwYnp4OTREbjBS?=
 =?utf-8?B?ekRRSS9lTHQ0NDh3dUxxaDNOVDIxUGJyMnRVbDA3Q1dpSXJKb0tOOFlLQVdJ?=
 =?utf-8?B?eTVFSnBQeURWZmtUQ3N2K2xwTW9pNXlJMEVCYUhWeko2anhiaCtLbU5NVnE2?=
 =?utf-8?B?ME9UY1IwUnBIcXdrUE16Y2VqcFcvNWNpckpSdzh1VnROMUJGYVMwbnhaRTM3?=
 =?utf-8?B?QkMzTGN2Um5hVk5XdXZCM29mNVJUV256aU84Z0lnQi9nMmNMU0tPdGNUZU9i?=
 =?utf-8?B?ZTlGMzkxNkRCV1JhRkFSQUM5ZCtxbk9PTVZLWVBrbHl0Q1QrT0tsbnVreWhZ?=
 =?utf-8?B?U0VEWFY4UkFDaW85aFRuYVBvdHhQUFp0b0dQL3hLaWZuL2JEaGRQbUNvSll0?=
 =?utf-8?B?bmtWK3lmazFDYWRuQkdNS2dPZXgxcUp1cUtmdmJxcmJkOFMxMVkwY05KREZp?=
 =?utf-8?B?dHJLYVloVERTOEUzU3VJSURtdUNPOGdGeEpITDZDOE5jMWw1TTFVUEtzc0oy?=
 =?utf-8?B?ZEdZdUo1RWh2ZlBQdlduL0hhWlp6L3g3eVJxbGVBdTRCenBXUm44ZHViSFFI?=
 =?utf-8?B?WXdLczVPRnlLaTZVSkVEM3RrSzlUakdZamd4bTRWMTVoa2ZnT3phWXVOSHJM?=
 =?utf-8?B?UHdLOFluaXJQNTFmemZqZ01CQnFnTUs4dUhXcmJkWFRORDRpS1BMdz09?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: d7b26cb4-35af-4497-5a95-08de624b4748
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 11:07:39.2374 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vyZku7muwR/dXp/xhDoINIm8zuijbp1TUSJ+io5qjc7zujk2TWEYlGEo1Hm7wjMVHiGX+xadhyTYrBNcwHPUJf5D+jxx7qi3emdZZoEgjmE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7201
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

Hi Jonas,

On 1/30/26 8:09 PM, Jonas Karlman wrote:
> Hi Quentin,
> 
> On 1/30/2026 7:19 PM, Quentin Schulz wrote:
>> Hi Jonas,
>>
>> On 1/29/26 8:31 PM, Jonas Karlman wrote:
>>> Rockchip RK356x supports up to 8 GiB DRAM, however U-Boot only includes
>>> the initial 4 GiB in its memory map, something that matches gd->ram_top
>>
>> Does it? The first range is 0-0xf0000000 which is 3.75GiB and not 4GiB.
> 
> The 4 GiB here was more meant as the 32-bit 0-4 GiB addressable range.
> 

Ack.

> To be more exact the initial 3840 MiB out of 4 GiB DRAM can be reached
> at [0x0, 0xf0000000) and remaining 256 MiB at [0x1f0000000, 0x200000000).
> 

That's odd :)

>>> and current expected memory available for use in U-Boot.
>>>
>>> Add the remaining 4-8 GiB range to the memory map to more correctly
>>> describe available and addressable DRAM of RK356x. While at it also add
>>> the missing UL suffix to the PCIe address range for consistency.
>>>
>>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>>> ---
>>>    arch/arm/mach-rockchip/rk3568/rk3568.c | 12 +++++++++---
>>>    1 file changed, 9 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-rockchip/rk3568/rk3568.c b/arch/arm/mach-rockchip/rk3568/rk3568.c
>>> index c2b96902d2dd..2b1eafee37c9 100644
>>> --- a/arch/arm/mach-rockchip/rk3568/rk3568.c
>>> +++ b/arch/arm/mach-rockchip/rk3568/rk3568.c
>>> @@ -72,9 +72,15 @@ static struct mm_region rk3568_mem_map[] = {
>>>    			 PTE_BLOCK_NON_SHARE |
>>>    			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
>>>    	}, {
>>> -		.virt = 0x300000000,
>>> -		.phys = 0x300000000,
>>> -		.size = 0x0c0c00000,
>>> +		.virt = 0x100000000UL,
>>> +		.phys = 0x100000000UL,
>>
>> How do you know it starts there? I'm assuming from the ATAGS? If so,
>> please state that in the commit log.
> 
> This range matches the DRAM banks we add in U-Boot proper, it also
> matches some old dumps of rk356x ddr_mem tags I have at [1] and also
> seem to match the mem map used in latest vendor U-Boot.
> 
> To me the commit message it quite clear, we only include 0-4 GiB (and
> pcie range) in current memory map and this adds the missing 4-8 GiB
> range, not sure how to phrase the commit message any clearer.
> 

The missing information is not what you're adding but how you figured 
the content of what you added. The TRM doesn't specify where the DRAM is 
accessible so how's one supposed to review this if they don't know? The 
paragraph above the one I answer to here is what I was expecting, so 
only adding that would be fine with me.

>> The previous mem region ends there but if you read the TRM, it should
>> likely end at 0xFE8C0000 + 128KiB which is 0xfe8e0000. This only gives
>> us an additional 23.125MiB which wouldn't be enough to explain the
>> missing 0.25GiB we need to round this all to a nice 4/8GiB.
> 
> The rk356x only seem to be able to address up to 8 GiB so the the MIMO
> address space is most likely lost DRAM. That extra 23.125 MiB is
> probably not worth pursuing ;-)
> 

"I paid for the RAM, I'm getting all the RAM" :) That would explain why 
RK3399 caps at 3.9GiB (as reported by U-Boot) though. 4GiB addressable 
but this includes MMIO.

> Below is a copy of the rk356x ddr_mem tags for 4 GiB and 8 GiB, please

Thanks, that is helpful!

With the added info in the commit log,

Acked-by: Quentin Schulz <quentin.schulz@cherry.de>

I hope that mem_map can be a superset of the ranges we declare in U-Boot 
proper such that it's not an issue to have a bigger area specified in 
mem_map that is possibly usable by the user. Also weird to have the rest 
of the first 4GiB at the end of the 8GiB addressable space, hopefully 
that isn't an issue either.

Thanks!
Quentin
