Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7093FCCF2DF
	for <u-boot@archiver.kernel.org>; Mon, 19 Jan 2026 11:10:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EAF018313B;
	Mon, 19 Jan 2026 12:10:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="ke1B3MQz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C54C800AE; Mon, 19 Jan 2026 12:10:57 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 975E783956
 for <u-boot@lists.denx.de>; Mon, 19 Jan 2026 12:10:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ElDfd5WYkKZq9FCY4ET09N2Bx0WhAHnBJTZoNDDRQmhDznG1hhQ1gBjerlMkSk8zoDGOT/xssF8hRSmuYevXiiqzmUWiMVwc/zoxFXsqavq1SjxAWPNY8bhsxswZ0ekcOh22yYIuybzB77Fdcm1APTCKcCF0L+L0GKBvfEdPULcvuncB0FRyT27lUBuGL7IhfQ6K2+Mt0L7cZG/DnwRtmZo9oKflJRBjp6WoVyf7s/PBF22G5sc3QkfG7Rl2LS/+ufrPcQZVpWNXyoOLvaMankRzNVV8b+2CH6B9M/AfySO2/CBYADgoOnJfYkdAYve+5WSJe9tvopJelH8D46p7tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wQCUSkeBVD2VytH+98zOJRlIF3Qhk7fr+cKZv4LsAUg=;
 b=YI2fG6iub4ipsbJ+iWY236oiOe9+3ZgMsPN0oVRF+IQV2PvBHl2O3AUxP5MYNQsQ8gDsjgb4OEZet+xNWYEdQSUqLAbpfovTbHor3B4jDdZInAmm8Rqh9dyXt2fKXZ8OdmF+js0rAPKz7NBtiLlNpbeYOZpO3wdWY37rA0BBROk2L3W9xdrC4dbNyuYA5NUZqOsPbNneUOyMBPughAZ/6nuGv4X44fe6Jd6aFZc5eZ66s5asX8YkAtGavTxD8Vlx3MzMq6i12qv7BWxh2FI6Dg/LySROeLdUWrOGSvnqxmBwnxnbC+PmYQg/3wye8HSF0cJ8/+UDoUAxL9Mx00IGzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wQCUSkeBVD2VytH+98zOJRlIF3Qhk7fr+cKZv4LsAUg=;
 b=ke1B3MQzvkPiODeD4FdP5LluW1ML25H7yugGec35O8pbqTxdBeTm9APxtiwOarJa4Ol22XRoxrYrWn1Q/juyqL1kFjz287KV4W1kC2lA327PvgjZNIZ7pZ3al68tQCvubniAc/JmadxpjUYwCMXWk6YFVTgVsneSpJdh1hhRJPY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by AM0PR04MB6801.eurprd04.prod.outlook.com (2603:10a6:208:18d::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 11:10:51 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9520.011; Mon, 19 Jan 2026
 11:10:51 +0000
Message-ID: <94b961fc-658f-4e20-8a9b-80fa116ca286@cherry.de>
Date: Mon, 19 Jan 2026 12:10:45 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drivers/clk/clk_zynqmp.c: get rid of compiler warning
 for !CONFIG_CMD_CLK builds
To: Peter Korsgaard <peter@korsgaard.com>, u-boot@lists.denx.de
Cc: michal.simek@amd.com, lukma@denx.de
References: <20260119095437.2775081-1-peter@korsgaard.com>
 <20260119095437.2775081-2-peter@korsgaard.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260119095437.2775081-2-peter@korsgaard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0007.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::12) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|AM0PR04MB6801:EE_
X-MS-Office365-Filtering-Correlation-Id: 4609f728-318c-4516-234d-08de574b6831
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|376014|366016|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NGVwZ1pwZ0ptZ0gvRHRDdm01UTR1TjBKSDJkRWp1SDB3RW1zaUcyR0dmMGF0?=
 =?utf-8?B?OWxuNmVYOHlsUEkxbVBzY0oyMmQ5QVlHTGZsSUpobGh4WFZWUzFaSzJmSVhG?=
 =?utf-8?B?a1RxbVlqWUNDYjgyVU1sYnBsZUZBMnV1OWFiVkdBZE8vVHBaNFBwTTdLTzBL?=
 =?utf-8?B?VHQzYVcrbXJzZGJGa2J3Zy9iVmROeWV3M0Q2dURaT1N4VitVVHhlcUhCazU4?=
 =?utf-8?B?amxkSHpzaHpSbDZoYUJkSTRTb3N4aUNNMUR1MTdyOXMyemxQUHBiZ25paitE?=
 =?utf-8?B?WlhrNGNNK3ZaSWtJd21aajViY0dVVW5KMGlMWEk0Y1cwODVUbVo4WFc0V1pn?=
 =?utf-8?B?SUcyOEpBeGsyK1dCWTBSRzRRSWV6OEdzNUhvRDVXWXhLdy9nOFkxMGltcnBt?=
 =?utf-8?B?eGRwVXM5UFpLcUFML1owUUxXM01jT3JmM3ZEZ2h1cUx1ZllxT2R2U2V1WmtB?=
 =?utf-8?B?bFkrZ3duVVJpdGRWUEVFK1pyOC9aNlp4RFZqNUFXTHhWd2tnb2MyalVWRkE0?=
 =?utf-8?B?WUlWcUllL1pJSWhBWnVPejQ1Q2JpZmVTTWloRGlxQTRDN0ptelQ2N045QmJi?=
 =?utf-8?B?a2VZSDZlTFQ5ZTN0c2xBeTlrRmp5aVc1MjB2NStmK2xkMGpYQXZ6MUtlMC9W?=
 =?utf-8?B?eVlJNTNpb0JZODRYUDlYZ0wxTHQvMnlEQzFOMkxiYyticVZtWlloVDhNR1Nx?=
 =?utf-8?B?TGFkWWFucmtEYjVzamptQmw1WmVUb2w1V3VhUjU2VkladnhTcWhLanlaK2d5?=
 =?utf-8?B?cGR2bmV0b2YrRlR3QnlXTzFTeUovdDJEd3YxcCt6c0g1MWREaENFaTRwcytV?=
 =?utf-8?B?SVFCMnNHTXllTlZickJ0R0ZYL0h1VzJCejFkL3BJSnNwSWk2SDJiaHo3TTNW?=
 =?utf-8?B?dXZoSlN2SDJqTW9IL2RsZm5KMlV3WitDZzc4TG40KzZPcktvZmJkTDUwdGY2?=
 =?utf-8?B?QWNNNjdjM2t0VlovWHlPOU9wMTJSTUVESlF0SjVMVHg4UlBORmpVOFVuZXpF?=
 =?utf-8?B?ZXJjd3NwcllOa1V1Y3VIWU93SjRrNXZGd1RTOUlHOTY4MUlnbnZNWjl3QzJR?=
 =?utf-8?B?dGU1dEM1V3o4M2MwNURwSVVEL2YwV3V0aisyN3FwQTZQSTRXeG5DZ2oxbUxY?=
 =?utf-8?B?OUJzWHl0TGdtRnhIRzlyUUl5c2NVb0xFT3lUSXMxeGx6SyttWFh6QTJMSGUz?=
 =?utf-8?B?Vll0WUtUcFBzdS85aTdCQVZFUGxILzRuaTQxc01hanVuNjBBYzQwYmZYcG02?=
 =?utf-8?B?cmhJVDFVNFJacHkvUTlxZGMvL0ZPblZpbXNLcVJrUWRldVFkcWRESjM0RXdW?=
 =?utf-8?B?cjBZNkJ5cThEYW9USlNJZVZwRG5EQXdEL1J3a3ZFdmQ4YXhuNzlHaS9BN0da?=
 =?utf-8?B?eUhrRU5SU3hCQ2hrWHZwTW9ISXg0ZC9YbWU1eFhkbkM3RFNkaVozem5uc2sz?=
 =?utf-8?B?ZjZlZ2FsckMwalBnbDRBODljUG5La21wMXNiQmpzN0NsTVdFME9tZklqZ05a?=
 =?utf-8?B?Nnc1d1UyOS9DSC93M1Bqbk9reVAxSG8rbWg1ZGJuV2dNS2Z5UTFsNFFkMTAv?=
 =?utf-8?B?Q1VRTWZ0Y3NGZFBYZ3ZHL3BXSE96NFRiNzMxUlRQbGhHWWxLRDFzMG1nUHFJ?=
 =?utf-8?B?OFNvOTFPSVVVa0IwbzhzVTk2aGwzUlJpT1pNVkx1OUxiR0ZmYWhheXhQR3NG?=
 =?utf-8?B?WGlkem13NmMyWFJDNHBOd2VoaC9hLys5M3MyU3JycEFDLzZWV0s1UHdkWjA4?=
 =?utf-8?B?VThZV21PbW5pdi9uNEdsQjY1cDNvZnNvVzZjWm1qckpya2NGREV2VlRveWYv?=
 =?utf-8?B?RXhYMGx5MThTRnNveWloQXNuV3lRNzBaVkkxUmZ5d1hOYVVkK2JzRjZVU0RW?=
 =?utf-8?B?dG0rRlFPUjNBalRSUWhrbnA2SWpPa1JtVWNMTjBUY2MxcElVYmZvUDYxSHJv?=
 =?utf-8?B?dnBpWVFPWFVpTk9ZSTgxYTNZWWdYN0ZzRHJPRG0xT3dyaWM1UXdJbmdUbDNX?=
 =?utf-8?B?SXFVbERXNGRTMW9zUXVXUmVOUFVTWXBsb0ZKcm1XcC90RnovbGprRkpJWkNx?=
 =?utf-8?B?V3NQNjh0LzRsOCt4NnhWUVF4Z1lZY1R2SnF3a1dtZnlSeDlLZHkrS1lXZTFp?=
 =?utf-8?Q?Wy/E=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(10070799003)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a1pXRFk2VVJnQ1Z5eStYQU5Va29yS3BadnlHaytYcXVMcG5NUjlpRUs5eXJ5?=
 =?utf-8?B?MWdYb3JUd0c5Nk1kSjU4UHlFNUlwQWVkVlhKYnZ4cWY0dHd3ZElaWDZxSS9C?=
 =?utf-8?B?ckl3ZldnYk1DNmsxanVaWjA2UFlSL3U3eDBEUHpIZEtZSzZQN2NQTi9ZL2R2?=
 =?utf-8?B?RDdxdjBnSnVGVHBOL3gwc3RNbEZ2eGpMaGw0NnVqdlc2L1IyYzVRS1BORzFC?=
 =?utf-8?B?a001Z2dEcGttd0pDTVdZUEYrV01sN1d4VXFla1NVbmhUVUFIL0pZRzZhdGhv?=
 =?utf-8?B?RWJYU3F2d0I3UE92aXpBeG9aU2VialVOdkY1dEl6d2dqcUVzc2g3NDlRUEpM?=
 =?utf-8?B?TlpUWnB3eFk0SG9KbGFDdC9jMUJXSlR1NTQ0K1lFSmtEeGFuemFvT2kzamwx?=
 =?utf-8?B?TmcrYmw4Wis5UVRyU3U0SkhiOXMzYVhOT1p6eXNkY2JKbmszejZEWm8wVGJF?=
 =?utf-8?B?OGJzMU1neWlmdVh0dXhmcHpZUkpjSEpnNHpBbVliV0lDc1F4T2d4UlA3UURw?=
 =?utf-8?B?QnJOSDE1TGlQL0d2UTVrOWg0M3VUODcxVUF2NGFuNWRvYng2eG1nU1c0dzB3?=
 =?utf-8?B?bjFUVm4zcFR4REd1WTdYZjZlRGE0c1NDTk1iNVBUQy9MclJCWXUyRDRJQVZw?=
 =?utf-8?B?YjRlWEo1R1pWb0xVc3RuS0J2R2srMWM5Si8rcTdJcmJ1UWwybUt3aHFYMllp?=
 =?utf-8?B?eFhwbndBM0F0UUkyN0dCdk5FK1hJNmVSTDIxVjRGM3J0NW1GMWhsc09adVp2?=
 =?utf-8?B?ZG5CWkVBOCtVakZtTVF0QlNCTG1tWlBzSG4yR09sbU1yZU1OQTdjNkpOU0hh?=
 =?utf-8?B?bzJVL1VXcGNKekVleXFhbk5Ia1F3TWtGRGVPK0RaWWw0VFZrMGdyeW02TGc3?=
 =?utf-8?B?T3VINXgySzVDd3poQzBrSWZBc1lxOG1lOEhUbFBXTVk2a2ZwWXBCME8xQnhD?=
 =?utf-8?B?ZHk0OVowenZWazFURjlJeWs0Nk5oQWxPYUViSzJ6ckdyMHZUSzF1WWE1ZCtU?=
 =?utf-8?B?UWdJSHhHcjJjaXZPanh5eHlHREpKbmtjQVRkQzNRcDh5ZUZhTkhGajNDRFNW?=
 =?utf-8?B?aitrNkNIUjNJUTZSQVZaQi9WTkNqd2JSK255VzF5dFZlR0JjeUhnWXBZUXVX?=
 =?utf-8?B?MXgyMC9JTVI5SjI1STBaNkxrc2JqTlVOamJvK2JMR2FEaVV6NjJRRXhUM0di?=
 =?utf-8?B?KzcvSzhodHlISDRlZ09MM2FMdDc1eURZNG51ZzFZbVlrUmJuc3RpRXEyek5q?=
 =?utf-8?B?VGJ0M0F1TkI0NjdNcTY2b25ybkQ0UlVIek5uMmlPdkFVMFZrWnF3ZVlOek1L?=
 =?utf-8?B?d1IraUFJT1U5RFNHQVBLMUFDOXFVWmJwY2NCd2VacFJxK1E3bXYxdEtQNXNl?=
 =?utf-8?B?MEFLWlA1d3NjNEhubklBcERJWGhtZTNYeE0wd3oyVzRwTTBtTFd5ak04ZHJH?=
 =?utf-8?B?am5EakE4M1l1bUp3NVZNYitBbXBoR2dmWnZlcEhoUFR1MCtDR0Yxb1Rod09p?=
 =?utf-8?B?b2RjRGRZWnVDWXFlSUkxcUZmM3hqSHFBaGpTenY0aENKZ2JrbTd5azhOT3BZ?=
 =?utf-8?B?NjlpVDcxOUNycjVtdFB5b0NFL3BJSXFpS3AveWVJaVNublJsbVFvcy94MUtv?=
 =?utf-8?B?TDV6NDBVOE42TTg3QnBlVklLUmpxYXEzZE9oQ3ZiQVJ1aVRVbnFjU1J1ay8y?=
 =?utf-8?B?akE0QTJBYjNHYldrbkM3OHBUaEJ0Z1RGYkFmMTlFTnJuS2VDL0E2UXBEZ0ly?=
 =?utf-8?B?YThEcDlSMGZ6RTlQbUlnNDBXdXJxNHlaMmhoNnpKNzlxN3VsVCswdzFGYS8v?=
 =?utf-8?B?RFI2aUFoeFh1U3g4RFh1N2FyQW9IMHFRbnk5djRhLzZPQmFJblQyQnRPWFBS?=
 =?utf-8?B?eXN1SGtQUVZJT0dveDl3U0huZ2dIMzlPVE9PODJyOWZlNG95M0hpdVpNTzJC?=
 =?utf-8?B?b1VERnN4dDEyYnM2anplWWNNS01maFQwK0RrVHNJMmdwVEFQMnBWZkxOYmky?=
 =?utf-8?B?UkNSLzNlbXFPYkJCcnZlQ2tCQW9OZ25CNy9yL2tRTmRMaWVaWHNTMmJBRGNm?=
 =?utf-8?B?WGI0V0VIYUk3YmxRTm94V0dXZlVIMzFrYWlNYnNlOGRVQjZjbkJvaHdISDdx?=
 =?utf-8?B?VVFWa2ZKTlpkczF0dFhuR1FaNHBpbnlTYXROTE94RTZFWnZsYWYxVW9CM1ZV?=
 =?utf-8?B?d2RCRE9lZHFpMjQrQzFlelFXK3N1M3loczFwQWV4Q1kwMCt3cFJZRU16b0Er?=
 =?utf-8?B?OCtQL1ByN3U4aW5RT0NhVkZjUmVzdS9SL0psNktYR2NqNmZyTTNxNHA3K1JY?=
 =?utf-8?B?cWxoVFBOZUx2WW9QbTcxVUdGL3hVT3pJZG5TUHdxSll0TWJETDJGeVMwK1Bp?=
 =?utf-8?Q?zWYepnDcD8EPco+Vt6sGz9JYHbWSIE6VmVd03?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 4609f728-318c-4516-234d-08de574b6831
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 11:10:51.6847 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6m2Jp2N/Ru8WVdLDT5zdnna3uRdVReeo+hvGLPXWDuiXyNtlFTydn7jhDyLYeYzjNeZ+uWoIH5G8bTUDmKCH0/qzVsfShULFAGUq9aBypR4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6801
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

Hi Peter,

On 1/19/26 10:54 AM, Peter Korsgaard wrote:
> When built without CONFIG_CMD_CLK, we get a warning about the unused
> clk_names variable:
> 
> ../drivers/clk/clk_zynqmp.c:153:27: warning: ‘clk_names’ defined but not used [-Wunused-const-variable=]
>    153 | static const char * const clk_names[clk_max] = {
> 
> So also guard it with CONFIG_CMD_CLK to get rid of that.
> 

Considering it's only used within zynqmp_clk_dump() which is already 
guarded, maybe we could put the static array and its user next to each 
other?

In any case,

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
