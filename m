Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 562C9CCF2CF
	for <u-boot@archiver.kernel.org>; Mon, 19 Jan 2026 09:30:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D26183A6A;
	Mon, 19 Jan 2026 10:30:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="eVm5f0wu";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="eVm5f0wu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56ECA83956; Mon, 19 Jan 2026 10:30:24 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB759839DF
 for <u-boot@lists.denx.de>; Mon, 19 Jan 2026 10:30:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Jerome.Forissier@arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=BaGe6VP05qKCcAhU9gdRL6RpCNvxAViNTRV+6kVefXNyHd/RkoeqUSj6rCSBZJK93jtAYX3KAWXoSZY923fXFd65doKW3OqZD+mYpR9zVqfNLfiFJWT1esCW4Iu4gCQK+XUq76/ppqRcrnjsqBotF9ywNJtE9fgiRcM2tJbCHg5ibSR9myLeXY/CAGD2tNy/4R8abevpvius5scpnqnN5NHgXUGR6RXq/hzxbztH2r+gUdDSYjvcWAg2+iij6k1I9M0HojFc02P5r0MqVBMi0waPCatdCN3+G9UiGaHrx2Tupd4Icclz5nsF92hG/yPV+rihVxEk09twtHkENGKZaQ==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i1jKvhdKieZsm51gYjBf0LRIsJMWON8SdLAuwnbEMLw=;
 b=FiaKdSoCGko88Y86j5X1zPsHw931Up09NrJ5ndddSMpJtyH2bCwW4pDkAva/AqzxGAXNvP1/7hZt3fBmYWULdrpkyiHKgHSpryed1r9uzbUUsdiN522eDRO3Oahn2Eh5jrlNnX2p8PVXVrQYzeFcOH9lI/Sfx1Qlxv6ipZDJTGEJkgyqnk3E2R+lA5zhhNzbuPPp2veAOWcjUsYHinU/g7Yu4TtC4DRiRlpD3NnrmlvX6GagFO052JsnpCt2knplvIcIPWEX8fAwZ78mUCdJh9CHPd7v0CRfFvhuxZPEQ63NhZF7kPAPVW5A+j4xYmlTGMWBc+nqbaj+gFEYio90HA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=forissier.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i1jKvhdKieZsm51gYjBf0LRIsJMWON8SdLAuwnbEMLw=;
 b=eVm5f0wuF/OqFTXOswmxF7XJJju4+UBzdgmYH2MxDcLNmz/MCy+wT2Mi7dVAG3lMNeptTQz00s5hpL9x+C6oAktII5Je46vhzzD+xOKtsqr8DBRT/aZ7DA0gXDoXGgLkS/RBHz4FxQpvZDCFAOp8H/dL0raCADnIKB6h/xF06c8=
Received: from CWXP123CA0009.GBRP123.PROD.OUTLOOK.COM (2603:10a6:401:73::21)
 by DU4PR08MB11790.eurprd08.prod.outlook.com (2603:10a6:10:63d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.11; Mon, 19 Jan
 2026 09:30:19 +0000
Received: from AMS0EPF00000198.eurprd05.prod.outlook.com
 (2603:10a6:401:73:cafe::1f) by CWXP123CA0009.outlook.office365.com
 (2603:10a6:401:73::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.12 via Frontend Transport; Mon,
 19 Jan 2026 09:30:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS0EPF00000198.mail.protection.outlook.com (10.167.16.244) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.4
 via Frontend Transport; Mon, 19 Jan 2026 09:30:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WPM883agkNjxbYq36HC0H8tOsy8ed0EjPa8vItg5pdUh1LTVSKvlEbCVUoz3Eh1AS3cYptxXNBjw8t0B613MohiphGiXnkINMK9KpBpsjQnSIQWQpG0d5Cn8ibKSKydFyH4fY0bNacC9JFMhyEK3e4io1pYB9cihrsTOoYvjetCrdPIKDi0rsR04w9PAkxkKCHMuogVNL9mPtUbn/Qf2fIWWB7qd54XQQXlE1aCSCmj48zVV1rlzrbhpn2WP+88M52JuPhpdi9AwNsNX7MTpGyvHGlDBqFa6NE7aNTsB42334IOs91RaCY+dJhf9Ti1giEvMDjwxZYQP2bQWurkYpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i1jKvhdKieZsm51gYjBf0LRIsJMWON8SdLAuwnbEMLw=;
 b=koG7b1F7v+LNpuMnOqpp3MXmfCaDlvFQhyaeDQuiZ9pC2mgE0BnZWV0WTmgM0hJiPyFD9AwU8emvnMPrhKfRrGE70mQ9v1S7XxsRgI0erXQakXjIDH4GK6VKWtocdczp2vnC0uU9Wuf5md7sam0jq3nesKQ/Ai1Fbf1eaIUSADZSHd1Rne1m6Z+P9IWabS2ydQH9ecnm3nfUVRCy7XYkwiLsQvKiy1D05Z1NGpOqPewFtS41+Ivl4SIejfhiqew8b3xtySd5tQMaQ1Wb0phCVaL9pvZY5udu6RLrBfv61saJQDPySmXQNffP3eNXiuxpNL1/QtKzfeoXT9ltUufp+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i1jKvhdKieZsm51gYjBf0LRIsJMWON8SdLAuwnbEMLw=;
 b=eVm5f0wuF/OqFTXOswmxF7XJJju4+UBzdgmYH2MxDcLNmz/MCy+wT2Mi7dVAG3lMNeptTQz00s5hpL9x+C6oAktII5Je46vhzzD+xOKtsqr8DBRT/aZ7DA0gXDoXGgLkS/RBHz4FxQpvZDCFAOp8H/dL0raCADnIKB6h/xF06c8=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by GV2PR08MB7929.eurprd08.prod.outlook.com
 (2603:10a6:150:ac::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.11; Mon, 19 Jan
 2026 09:15:22 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%5]) with mapi id 15.20.9520.011; Mon, 19 Jan 2026
 09:15:22 +0000
Message-ID: <570e3609-604d-4be4-ad3e-45b1167096b3@arm.com>
Date: Mon, 19 Jan 2026 10:14:24 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] net: lwip: dhcp: Save DHCP siaddr field to
 tftpserverip env var
To: Jonas Karlman <jonas@kwiboo.se>, Jerome Forissier <jerome@forissier.org>, 
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, nd@arm.com
References: <20260117002452.1026310-1-jonas@kwiboo.se>
 <20260117002452.1026310-6-jonas@kwiboo.se>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <20260117002452.1026310-6-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: OL1P279CA0039.NORP279.PROD.OUTLOOK.COM
 (2603:10a6:e10:14::8) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|GV2PR08MB7929:EE_|AMS0EPF00000198:EE_|DU4PR08MB11790:EE_
X-MS-Office365-Filtering-Correlation-Id: 8af69ee1-c9f3-41ca-593b-08de573d5c9f
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007; 
X-Microsoft-Antispam-Message-Info-Original: =?utf-8?B?VFhZUk8zUkUrSFRDTkwxVGgzcmZmbDloRzRoNlBrTnhaOEJKdEwrNDg4RFpt?=
 =?utf-8?B?MW9YZVowdXUzbHYyUWZCVFNwVDNCRXVNMWlyajk3MmVSUmdBTVBkaEQvcXFt?=
 =?utf-8?B?dnFFWlBsbG5WY1MyalZJc1ZJcTZGNXhUL2g4NUltRTFueVNkUGtBNHRDckE5?=
 =?utf-8?B?WnFtQy9mL3lMWXRQYnVIRFQ1Nll3a213c0FxOHBJN3ZlRVorMkswcjNaa3d3?=
 =?utf-8?B?bXhZVVpTT2x2YnJJSEVzRlAxUzYzR2xocmlnd1AxV3NTUWJaZzBrMDRud1l3?=
 =?utf-8?B?a0t5VTFZTnZiZDNKR041a2VKRWZnQVlZNWtMWS9pYXVsU1VhaXZWMGlraG1q?=
 =?utf-8?B?b1hlenNSN2w0ZWJOUTdLKzRGQTJEak9ESVNZR1lDTGI3SVhsZkNQdFlJQXZw?=
 =?utf-8?B?dFpQUjJDd0JzeVYyMVFCd0hBT0twZVJ2dGVna24weVpLVzJ1S0FtK1NSbS90?=
 =?utf-8?B?RVhFMjVaZVNNV0QxN0I3YktFRFVVRUlTektPakdzN0RVY0dNaVJ2VHhqb3Jq?=
 =?utf-8?B?VXdpWWFtVDVXTlRSTTEraDNIUElpY3FXYWhSZ3BVVStHelBqdlcxMnNRSVZk?=
 =?utf-8?B?VkR2aGU4d2t2T1VMYzBXWVhvOVRFMTFGTlZXYzVnUnJLVXpmVlR1TElCUURW?=
 =?utf-8?B?b0FBYmJkSlUra2xZdnhqN2lqRVg0eXFrNnQ1ZEFFMUNUS2pFT08zSXIzMG8z?=
 =?utf-8?B?aERyTk1ETjJYQXpJS3lXajlXc1BWYWNNd09aUldkWWIvQWJRVHpjMnpGQzk5?=
 =?utf-8?B?a0hkdU1TYldLL0VlQlNqM2I0NDd4d3oyQmdoRVNOL3lBa0JhTVNoVWdoZDQy?=
 =?utf-8?B?Y3JvbmViZ1hndU5vdHRha3V0R3lNWTZVS2hDWHZHYkdYaWVRU1ZNNWJpbmx0?=
 =?utf-8?B?VEVFaFhrZUZhcWlsTlRwL3FGc3ZQSGpORTUxaUduOG53L3FNdVdqVFZGb1ZF?=
 =?utf-8?B?MTd6djhRbWpVMjViMnQ4Z2JVTTJQMW5NaTFFT1Nma2lNMVpZZXY5Vk1qQm53?=
 =?utf-8?B?UUNUZDQyWHoxUXp2aUtDMC9ZZUpzdEc4NVcwNVpQSllOVCtuQnFDbFVER0c0?=
 =?utf-8?B?Uk1ib2pIQ0tYbkc0QTVHMTdsY0RHaFNGQnRLYmNTd2pRb0NsUFdyTHRzdnlp?=
 =?utf-8?B?MTk1VVNwUGxPcE5YVy91bmNNS2pVaTlsVlJ2VyszUUl2SWRBcUsvS0xMODhK?=
 =?utf-8?B?SHN4R002c2htOHRDS3I2VDhCYXpITVEzaWhkUEE3SGN1c0MvVUJUQVlXRVZE?=
 =?utf-8?B?Q2NjeXhFMnlDWmJPYy8wcnhmdlc2Sk93S3hwR1BZblVZTTVMNXhTN2hYR3Rl?=
 =?utf-8?B?WnI2OURoaWszaVJsTmJML0hmelRyMXkyZkRaSS9PeHV0NU1oTFBlaU56NE9L?=
 =?utf-8?B?TTRmYzVxRklUU3k5TDRVMjRhZUNkZkJUeXpjU3FvM1ROU2NXckdjcFJpQ083?=
 =?utf-8?B?elh2RElmWDhqdkRlVjRSTk9lbkpvNlN6SWdDVmhpT2JGclNiQU50ODRBL1pm?=
 =?utf-8?B?blI3QUZUWWU4ZVg5ZWY5YUtrWUUxVzAzNDQvNVdDOXVTWjhHTFJPQkNzNHF6?=
 =?utf-8?B?ZDJSQUFoTkd1MXBMTmROM1lqd1ViU0lHNWN4N1BBSjBHWWs2c0hMdXlDTmlQ?=
 =?utf-8?B?ckNHd0dEOXJrNmM2VGxaeFZOYVo0TWdHanZyZTUvN1lsQ1lKY3d0YkM5RTJj?=
 =?utf-8?B?S1VKdCs3cmpGajFUR0xyOEVFTTlReFBIVjZtN05MbnZHQVNoZG1kdkhWcFZh?=
 =?utf-8?B?MmZQTFVXNDhlOW9tVlVVeU80dlFmNnoxdHJaVGYwa29xTG1kT0JuWjVCMUZr?=
 =?utf-8?B?cUtpRFdWazZlOVVpUVJhcVY2cDNvYWpOTkxUOFF1Um5jTjRkVnpPQ0Z4aG5w?=
 =?utf-8?B?SzZkV2pqSm53WktLWndtcS9NZDVwdXkwMVo2TlAvUjhld3hoMnZkZWdOL0V6?=
 =?utf-8?B?YzlZYVFaVW83UzJwS2ZRdTJWTm0rVGYyNnN6MTNkVEIwY1p5a1Iyb2JNUmpZ?=
 =?utf-8?B?RmljSzlVMXVycm9nY2wvQWJJVFQrSjhWQVRrc0lLWjBDUDdZMk43YURuSVRE?=
 =?utf-8?B?d1QvVWkvMm5hdGpmWk9UTjRNblpZdXFkL1Vqb1MzZThhcFpoOHJkRmJLTWN2?=
 =?utf-8?Q?iPKM=3D?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE; SFS:(13230040)(1800799024)(366016)(376014)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB7929
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AMS0EPF00000198.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: d49eaa16-835b-478d-5f16-08de573b45d7
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|35042699022|82310400026|376014|14060799003|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eEoyMmZycjU1S2lWUW9yakFTb2RacFNyL3REWk9YVmlOc2RwbVdBTUEwZFlp?=
 =?utf-8?B?clRYblB3K1poTlZxOFp3UkFQNlI0b25wVWZoL3dFUjhLRWVRK0tJUUU5UzFq?=
 =?utf-8?B?cnBWd0g0TWNiK1BJRVRQN2NQTkMrWEVmSjhIU3FqeUh5ZzFueHYwRGx4Wlg1?=
 =?utf-8?B?WHZjRTVleVBRTUZpYzFBcng2cGxqT09vaHI1VCt6UkNUTFNEQ1lUaDZFb2NT?=
 =?utf-8?B?TWdtZFV1d1M5ak03VFlEazVBbVFQQU85ZVFDNm0xL2hHdWp3eU1OVEZHcm9v?=
 =?utf-8?B?SlJOMGFWVmdsZHExTnBsbWxJSjBsOHp5ejZIeUxnQ0FhRDBQbEJyS1BXeGhw?=
 =?utf-8?B?MklIcFRMYXFSajVjT0ZNajNnUXB0enZsU0I1L2tiSjVKR0svaGxDK3pkQUx2?=
 =?utf-8?B?YlJHVE55ejJLSy9GbFNSMTNHei9INHVsaWc4aWZ2eTlaYWJuQ1Jyb0lvdlI4?=
 =?utf-8?B?b216NXpVcVJ4SkcxSUI4NklJVW54MDRVZjBJQndLU2RjU0NobXlvU2tVNUtN?=
 =?utf-8?B?UVpzMzJZM0hETzRRZi83SEZRRFVub3BSV0Ywa3laNjkxMVp5OXg1d2lnb2VO?=
 =?utf-8?B?d2JZQncwTFIrZSs5STdLZ0EvNVRTM3lWUGtCMUY5UW9MelExcFBHSS9STE0z?=
 =?utf-8?B?TnB6ci9XQ3hIMzg0dUhhdVcrL1hFdUdacExpYUFqOGVBbmlEMi9FSDRQYVNC?=
 =?utf-8?B?OFNHL3pwNFlBWDNYaXhkNG9ScjF1akhxc1hkUndqSGF2dno0SnEvUk9XMFNH?=
 =?utf-8?B?Z1VYVjAwYkhaOHhOcDBEVTF4amhmTDZSekI1TmYwNFB1VlJPR091cy8yRzI2?=
 =?utf-8?B?NC9PMkVjV2tUMnVQdXltdjFybWltQS80bU56ZWlnRjJPQjA4U0xWTGlPZmxp?=
 =?utf-8?B?L053WFJnSllOSVpsZDJOR0dWcVVSd2dKZnN1MXRzb3l3RkZoaVdMSUxrY0dM?=
 =?utf-8?B?QnkxRGc2VWY5Tm9yRFpySkd3MUtQVzFtM1RXMWZxOXB2NXE0d3RKbXBTV1ZC?=
 =?utf-8?B?UnRhcFF3cXgzcHFOSTBFRDl2aUlxMi9scFRTKzQwTXFaUCtjU2pNcTlxNnVz?=
 =?utf-8?B?alcxSHRPTS8yY0RZemJqYXYrb0I0d1U4S2FQWXlhbnBiUUw2L2lSaTFIRGxO?=
 =?utf-8?B?cmNPNHRFKzR4cDlkZFlvbDBINTlpWWM2cEFhWlpDSUgzYmJkajFiK0dJenBp?=
 =?utf-8?B?dmVobTRiVkhBOFN4UklaUkdLbGdCMjgvYW5VTFZEOG9yZlFKQ3E2bGRGNmpw?=
 =?utf-8?B?Q0Q2OGlPZWNNWVBWOW9VK2IvTGhlV2RzTVQyUk8yK0ErTFFhMWF0Mmpqc2kv?=
 =?utf-8?B?a2FMTHJPL2NCN0dDUVh2U3pZajF3eTFmWlhCZW5uNk1idzk2R2pjamo0eExQ?=
 =?utf-8?B?YVo3SUFiMTlNVmtIcW1zajQ3VGE4dW12VUJIRk5Pc0I1U3Zsd3RqNG1IUlgz?=
 =?utf-8?B?d1lsT1JoMERTRjR1Y2ZBVmVRSkZjMmFXbFVsNHVNNkhIK1dXNmVhMlBLcHpV?=
 =?utf-8?B?d1FBdzJMZzl3SHFxM2NmeDc3alhCZGZwV0pRMEdwRVhMTXRFaC9aeFJOMXkv?=
 =?utf-8?B?eUhYa25TeFlZclE4WXpVRXVYeUhneVV3RkRtL1g2ZU16OTlTWDE5TGQ4bEx5?=
 =?utf-8?B?UlBQUkNUeHFCd0RBS0xKSTlaWnRkcWtzR3cxZ25WbS9nditjV2RPQXduMFgx?=
 =?utf-8?B?dlRpZDRGcjRUcE5HYXo4dDRYZml4eVdmblZYcElFK1RkK0lreU5TYmZmVWdU?=
 =?utf-8?B?TVlrM2RLRzFhcHJML205b1dmTGxyQ0FTZEZaYSt6MU1TV3NqZXFlcjc0Smcr?=
 =?utf-8?B?amVIZFFSY1AxNUdPUTlKajNYdDJ1bGdFckc3eVdMTS9EUWVtaXhUeHV1bit1?=
 =?utf-8?B?NjYxOEZIcStEbFpkM05YMlcycS95N21nREdYaFk3T1JMamw5SUdSbzZ1aVlz?=
 =?utf-8?B?Nk9MZ2R3MURESmhIaGlPR093cmxPVWRhTEdiZFJCT1FFdXQrYWIvbHBmcSt4?=
 =?utf-8?B?T0ZFVlRnenZFd1diZVNmeldWTFdBMFk4dW5rVG5YelpON0lvcG5UdUY2THVy?=
 =?utf-8?B?UGRsS3Z3amNVQ3pJRG9qU2tPdzVlTUVKTHZsRDNuRkk5T1pkWWI0WGFhOC9W?=
 =?utf-8?B?YVlHTG9nM2RMVkQ5MEg0NnFpSEljb21hU3RqWUtkTTE5YWlqU2Z6SEZRZEw1?=
 =?utf-8?B?cXYzaXcxejhLcFBCODl2L05tL0NNUzc4TDc0Snh4ZTBHU21STlNGeXozd0la?=
 =?utf-8?B?Qm40SGdKMEVJTUNYbGdTTm5mbzN3PT0=?=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(35042699022)(82310400026)(376014)(14060799003)(1800799024)(36860700013);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 09:30:19.0968 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8af69ee1-c9f3-41ca-593b-08de573d5c9f
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF00000198.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR08MB11790
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

On 17/01/2026 01:24, Jonas Karlman wrote:
> The DHCP siaddr field contains the IP address of next server to use in
> bootstrap. Typically this will be the IP address of a TFTP server or the
> IP address of the DHCP server itself.
> 
> RFC 2131, 2. Protocol Summary, Page 10:
> 
>    DHCP clarifies the interpretation of the 'siaddr' field as the
>    address of the server to use in the next step of the client's
>    bootstrap process.  A DHCP server may return its own address in the
>    'siaddr' field, if the server is prepared to supply the next
>    bootstrap service (e.g., delivery of an operating system executable
>    image).  A DHCP server always returns its own address in the 'server
>    identifier' option.
> 
> Set the 'tftpserverip' env variable when the siaddr field contains an
> IP address that is different compared to the DHCP server IP address.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>  net/lwip/dhcp.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/net/lwip/dhcp.c b/net/lwip/dhcp.c
> index 4cd4184c42bb..acdf601d7eb5 100644
> --- a/net/lwip/dhcp.c
> +++ b/net/lwip/dhcp.c
> @@ -101,6 +101,9 @@ static int dhcp_loop(struct udevice *udev)
>  	env_set("serverip", ip4addr_ntoa(&dhcp->server_ip_addr));
>  	if (!ip4_addr_isany(&dhcp->offered_gw_addr))
>  		env_set(gwstr, ip4addr_ntoa(&dhcp->offered_gw_addr));
> +	if (!ip4_addr_isany(&dhcp->offered_si_addr) &&
> +	    !ip4_addr_eq(&dhcp->offered_si_addr, &dhcp->server_ip_addr))
> +		env_set("tftpserverip", ip4addr_ntoa(&dhcp->offered_si_addr));
>  
>  #ifdef CONFIG_PROT_DNS_LWIP
>  	env_set("dnsip", ip4addr_ntoa(dns_getserver(0)));

Reviewed-by: Jerome Forissier <jerome.forissier@arm.com>

Thanks,
-- 
Jerome
