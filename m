Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4000CFD376
	for <u-boot@archiver.kernel.org>; Fri, 28 Nov 2025 12:39:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5B8B584522;
	Fri, 28 Nov 2025 13:38:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="F7wbJ/zN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9180A84522; Fri, 28 Nov 2025 13:38:57 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 30F9A844EC
 for <u-boot@lists.denx.de>; Fri, 28 Nov 2025 13:38:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=C.Stoidner@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J5b2l2YEZhlh8u2JD88bCtlVwsjOV8P46rsf0i5NXG+3Z1BSvvAcx0M8/Vh8KJPgRhwNdrD4Aio9pZ0B52mBYo0Kz+I1OsLTTgnqWaZ3K645tqvJmGVfCHxC5rh2/vpONAEr83bodhg2axSMTSkD7IIRK3thvSLOSUVIe7M0g82tWEa0Tv6LJbhpV+k9ivKtc5qbM5CT777pWyDFqrMTIkr1kLmaPzjypvSJIWHO0a3eTVE+NR6I8xcII8qcs5FUxG+2VW10zaBday7tGOrn+c2mhLmv0cdme9udnjZmp9uDS4G6mMwX2JkEdf9zWZnt+cihVejnQ0kBMbxZBMjd3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e9kR7eWok72lr5L16/enToc2tw7HxBpvHoDnXTpTd8g=;
 b=jVSM99oVeW58/b+tnnd0KsheDii2sWMASkqBkQQVJ9DCyStfbI/LlzuvMn7r+bmxYYBJAmn3AxW4OBWzPyUpAUdZ18Rihl+EyzblBKfHBiXzopboDkDVlKFnpGYncXapO8bHj2iXw6AOujSvwPzqOjI8D+2pjjRsoqVW/GK/edR5X/Tm5H7typ+WxHV7SRECAIpWzBIwoKeXWaiLXAY+aUiMC14PDC+UH4GrcOerDHWVzj1C/2We96SrDZiVExe2QUVxpD3epHSHv3ctX1HQNOlTU5R9JmaAUBR4w6khsNzW0LBFLmZTJNC9sO9JBmiH4hv4goYBqzYLQESUldw4PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e9kR7eWok72lr5L16/enToc2tw7HxBpvHoDnXTpTd8g=;
 b=F7wbJ/zNgpV95zMp82ZopMZZvbgDkgLsd1h8ysi3VYY6pvvL/9JdIdO+K79Zb+0WB5yzJsZsL1Sdgq5fNJm9shiNS/ROfHF0oyGyNAB/SH/6j+NkDRILiI8mq45phh5R40lDLrjddj8LWyFZJ8hDoN0zY4MWWVMhiFda48JcKazdJKNuE/ad2HNRc3mk4eosJFw2yzD4YxLC2rN7VERvX/fP+afmGaMTxY+ydwQ47AQ1WK4cBmMd9NyOd62ioI5oV+zg3qPFF++KSo0IJcIi5qkAOD7qDIFtJwz3b1fuZz/cPG2kaikK4umIxJmyBwvQvKisB0zmlc76s8mHsIltcw==
Received: from DB9P195MB1212.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:294::16)
 by AS4P195MB1961.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:582::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.13; Fri, 28 Nov
 2025 12:38:53 +0000
Received: from DB9P195MB1212.EURP195.PROD.OUTLOOK.COM
 ([fe80::2d26:fa56:5972:5247]) by DB9P195MB1212.EURP195.PROD.OUTLOOK.COM
 ([fe80::2d26:fa56:5972:5247%4]) with mapi id 15.20.9366.012; Fri, 28 Nov 2025
 12:38:53 +0000
From: Christoph Stoidner <C.Stoidner@phytec.de>
To: Peng Fan <peng.fan@oss.nxp.com>
CC: Peng Fan <peng.fan@nxp.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: AW: [PATCH] mmc: Fix missing 1 ms delay after mmc power up
Thread-Topic: AW: [PATCH] mmc: Fix missing 1 ms delay after mmc power up
Thread-Index: AQHcSncZNZsJS+1bXEyYkUZGyGb30bTiNqIAgAo2ozGAC404gIAQOHwA
Date: Fri, 28 Nov 2025 12:38:53 +0000
Message-ID: <251e74d80063d4a63a48d5c4d8ebacac006da029.camel@phytec.de>
References: <20251031145951.535376-1-c.stoidner@phytec.de>
 <PAXPR04MB84594BDB0690A1C0285F90A588C4A@PAXPR04MB8459.eurprd04.prod.outlook.com>
 <DB9P195MB1212DC55E27674A4194719C497CEA@DB9P195MB1212.EURP195.PROD.OUTLOOK.COM>
 <aRv8gc0FNwulrsRm@nxa18884-linux>
In-Reply-To: <aRv8gc0FNwulrsRm@nxa18884-linux>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9P195MB1212:EE_|AS4P195MB1961:EE_
x-ms-office365-filtering-correlation-id: 0150fbfe-69c7-4a10-96b7-08de2e7b1703
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?NEZDVER6QUV2TFRzY1NzaWxmSW9od0M3Ymc0dFcrZkRONU1hNEJwZlVKbHFi?=
 =?utf-8?B?Um9JcFo3K2ZoVUpST1pxcmVhV0tsUHRWYXZGRTIxVk12bGt5OWQ0VHJybDdl?=
 =?utf-8?B?czVpOG42dExmdWlFVk9FTlhOZ3VvaVpQcHdmS2E3bHRDdVkwUlQyeXZHb1E4?=
 =?utf-8?B?Wm5CM1VQaW5uZHNnbit0WEkwWUcyMVBhNjd2ZEx2MEZHNkpKakJPclBiODZt?=
 =?utf-8?B?N0tSNEJvQ2Eyci84OGF1cjN1aGw2aVZ0MkUrTXR4UGtZazhOVEJGeVhUS3ZU?=
 =?utf-8?B?dXRjdEFET3dJVTJKakVnKzZIdGxWYmdFYjBtTFFRZVdybmg1MmhBbGp2UWRq?=
 =?utf-8?B?VngwN2MwTE0ydzVsZEFLZ0s3VjN2ZTBaTHU0YTlRUzJxMHYzQWRPR2FIUita?=
 =?utf-8?B?aXRxcHREbnJOWkl5RHdLcDRlNUtRRkwwblF1dUpBSGxpRUEyU1JDTzZ1THp2?=
 =?utf-8?B?NjN0SGFGUmthcFhJRjhCRWpKcDFDYXRyNG1PT1ZTVUMrd1Y5YUlvczJSSzk4?=
 =?utf-8?B?YkRQMEpMMk1UMTM3NzdxS0R2Vk8zdkt5cW5kSXNHWmRUelB3TktoanNSTkdV?=
 =?utf-8?B?cXlhZU9PYnN4bHJOVlpRRnJkSkFJVDRTbWVKeWYvQzdUSzcxcXJSUUJodmE4?=
 =?utf-8?B?aE9yYTkyYzVqL0NzRmJBYndtdDBhZDhRUEl1SWlWV280eW9MTElnVXh1anZC?=
 =?utf-8?B?NDRsQ05OZkpCekU4VElVZ3E1RW41emdaa2xTa0FWYVVDQVRtK0dqWXZTeU5H?=
 =?utf-8?B?dEJmSHZ3M2Z5T2dZSHFDQnA0eUhvR29LdUVqblNJVlE0eXhMS1cxSmFmNC9a?=
 =?utf-8?B?bHo3czNhU0xwWTdrdWxsbHBkQ1hnbHFMaVhCZStDblkxMFM5YVcvYUlQNU9v?=
 =?utf-8?B?RjZQcjlnUGVGYU5NczJTelV1T3BUZDdsaUQrVnlpZXBiZXVHZnYwQWVtKzNI?=
 =?utf-8?B?dmFDWEdaVVAxMlg2WHlwcDNCYlU5Vk42bk9abEZmclBQb2RzUWd1RXc4UXVW?=
 =?utf-8?B?azJiUVlKdkRPUDhWNnFCcmtRS1RxQUZxYVlyM2NGTWtabW1YQ29GV3Y1Y2hE?=
 =?utf-8?B?OTQ5ZzdWMStuNSthTkRIdWZwRnpNV3NDWlkzUGxldHU1QWp0L1JLS09hWkdV?=
 =?utf-8?B?emdnajJIcmdaNlZMTFMwRXJuaGNuTDNpQTBIRFlEZ2w5b0RhRmJ3WmV6bmdJ?=
 =?utf-8?B?NEpSVmIxWk5KS3ErNFpNS2hoVU9FeHJ2WStpL29jQTNQWHFDZFhCL0czYnF1?=
 =?utf-8?B?YTZjTVRFNllsbDdidnhGR1hMeGdHZmgxK2pkSmZVd2JyWHphb1BWSFl3T3ZN?=
 =?utf-8?B?R3hYTVBITXBBdVpRaFBoRE9wYUZvOHVPbFgyYTh5L21ZWVVFQ3R3MllkUWg3?=
 =?utf-8?B?WllMcGJCbTZYRUhSMjlMZzFmbkdGcnpnZGVOc0dPR1RyN1BqZlZOUStGVEdm?=
 =?utf-8?B?VldIT0VxV1dNMXVOU0U1R2RpVndrRU83M0tYMVJGUnFRSXNoVmtFZEE1eGVo?=
 =?utf-8?B?eEdwMFhISVZRYWQ0dlEzNWJFYXQ4cUxoeWZOdkFrSU0xYk5oMG0ybUpxQm5s?=
 =?utf-8?B?RFNrM3NnSlM0M0hJdityRFN5ak00aEF0RkgvckxKNGM3c2dWbXRrSEtZM25E?=
 =?utf-8?B?T2ZFcEF0dnR3b0xTd1I0aTNiQkpMTTdiVWlBdWxCdHZpQVIybnRSRFpLOXR4?=
 =?utf-8?B?YzFhamtWZGZXcStnUUNxL3JQK2NlV1NMVzVIbyswYU8rcTd6UlI1TzhSZkZ1?=
 =?utf-8?B?UEhHd25EK29jYmtqbU44ZXpYNzRrNTJ2RGxZOVBxUG1jY1VXTGEyT1F1VUVq?=
 =?utf-8?B?QmJnd1o4RTd5aC9yQi9sNkFsWDdZTGNYMTRDeGFhVWc5dnlzOEtDR3djbDd2?=
 =?utf-8?B?Vll3SVlnVzNYWjBOQ3U4ZHFIaGRXeGU1WElIeVRUakFuSGRhNDJtNWRLTzVR?=
 =?utf-8?B?QzNJNWtGQ3Voak0wWjBxdmJHQXArWHpBbkhudGp1Wjh5ZjhWcjVqS3RrZVor?=
 =?utf-8?B?NUF5WS9pUjJBK1MzQVJGV1BNZHRIQzlpcVRrMTltVVpZNi9Pay9DaUllM2d2?=
 =?utf-8?Q?UqKhmg?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9P195MB1212.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MWd3RVdzVzNJcjViQVRIaklCQjB1c3FkcHcwN1g2ZWxEWGZyakpLUlZGcnVG?=
 =?utf-8?B?eUpzb2h0VXAySldGeFpCcUF6TmJjZk5aWGdjVzU0OStWS3pYTVA4aE5oK2RU?=
 =?utf-8?B?UndNclpPR0xaQitDMUh6T1dYVWI3VndXNzRwT1crSFczUjBtQUtYMkdHUXEy?=
 =?utf-8?B?ZmZsOHpMN0orc0t0dWY5OFFPckJqYnJJU1BHNURISjJLUzRTOEZMbjB5TDVR?=
 =?utf-8?B?MnQ0VmEydkw3dm52N1BuN0xyd2QrNWdkUUl2VzRUWmk1WVZnTXNhRVpoSTlD?=
 =?utf-8?B?VXZQbUJQS1dMZnJXTjJ6c0p2dXdYQVZrbGg2ZEh0NkIvWXlQSjlCZ0Q1dENa?=
 =?utf-8?B?ajI1VVAySENzNDEvcWNvODBEMkpWdElJT2VUSCtuTm1MenV1QnZ0c0VoMlNJ?=
 =?utf-8?B?M2xYd014dUF2M1NDRVJUd2QwT3I3bjV4bFpPQ01nTEJDdFYzOEZXckxwc2Fq?=
 =?utf-8?B?QTA5OWtXcXptK3gyc1dFQ1RLMGo4M2ZraEQ4S1NHWUdCZnp5Tm9CcmxZU0Fx?=
 =?utf-8?B?UHNtYUVVdVRyQ0ZrQWQyMnYyZmh0QjREN2dsakhhRzBoMzVsbmtOam5xRzVm?=
 =?utf-8?B?a3BjMmhQbENZZTM5bTlTYlZrVnh6cDV2dlhmekJISFFMOG9Xbi8xNVlLa1BK?=
 =?utf-8?B?eHk3bG05OHJzRVNDQ2J3Sngya3VXQk11ZFlJRzVRRUJFOXRjYXk5TFV1QndW?=
 =?utf-8?B?TE5XNWp6R2NlMlYxTWNNT2c2ZWFvWjREMlVLUzRNL2RPUFdzRnduNE0rNnhw?=
 =?utf-8?B?WjZnd0dZbkhkWU9QRDhESHpLcmVtNWJ3MmhqY3RjaXkvZ2V5c3hsSjM3U0hm?=
 =?utf-8?B?Z052cHlqa2lqaWpHY0RLVmF1bXd4aVhhOUNZQ1I2TllRWXVkYjhHVGl1NWNz?=
 =?utf-8?B?VE10WS9KUXgyWU9ydk94b2lGNnh5TkU3RDRJVE5vL25nS2ZmbHR5Y1dlaUxE?=
 =?utf-8?B?alo1eUFUQUhQQVZUVEZrOWUvbGp5UWo4WjZ2d000dWQwdEZvZFYya0lGNXdS?=
 =?utf-8?B?TDhWK0NZQ0NGazVGREFmTHlBc3RtMGNTWUZOS0crdlNlcHU0TlNUdEdmZW5Z?=
 =?utf-8?B?UXZibzkzaHhCZnlzdmpacldTckNPY3A5VHlqK1JEY0daM0RTUTRyUWJ3amlw?=
 =?utf-8?B?UTVGc0VzYk1Ob2x6SjdBSmUvZXVyOUtSVFBFN3dpWTNwNllrSlVycVFQa3hs?=
 =?utf-8?B?TUVGSWtHU05rWWpCZGRKY0lLVVE3MGxqRlBPdzFxa3kyWjNhSTdrZk0xTUNH?=
 =?utf-8?B?M1lqOUZHWCt3VG9OKyt2ck9zR01CTUM4MHMyQ1YxSkg3RTFIUE45UWtoeVEr?=
 =?utf-8?B?WUthSjJlKy91UWQ5cVoyT0w5ekh1ZmRjZ3hjbU5nbHNwU0M0NGsvUzFkd0dN?=
 =?utf-8?B?QmFLczN2dnBScndXbjJCTGlsMjFYT3VrbUJNNUlKUjVuL2lmWVJIUGxid0FS?=
 =?utf-8?B?b0Jqd0w1RDBzQXZKV1EwV21FUjd5alpxUTJtZ1JmWGY5N0N2bVI5WUFOUFJh?=
 =?utf-8?B?Z3lIUXRYaWtOcVRHNHM2bUdiSGVPU3pZYys5UWRQekVSSnRaQjBmRWR2NEdW?=
 =?utf-8?B?R1lBdWhINXhJNnNBL1p6bkYxMTBiUlA5dFNrQUpuWk85cFBOMTNRVkhxTUVS?=
 =?utf-8?B?ZGFUb1BWU1lnazNPR0N6MVY0TlY4eTk2dGhLZlJwQnhvM2xMdUVWNE5WUWhT?=
 =?utf-8?B?eEZPc0ZaTlQyTVhINFNjUy9pYUtUcDQrNEFzT0hwOU9VWXB1S2dicklnL1Ro?=
 =?utf-8?B?SGNEWU1WcExsbndOMUtHUHJjYVd3Y0NyR3hEb2N1aFdXSWl5TzRSUWM1UzhB?=
 =?utf-8?B?R1ZrNzNlOHgwR09SUmJkZGk3a09tS0ZhUUpJbU5Tek1ST3VKV0tSVjBBaU5J?=
 =?utf-8?B?dUdEaVNRKzZLMFFhd0FMOUJUNll2VHVmZ2RZMUpwOTN6d0gwUzE0OW1DUHRG?=
 =?utf-8?B?ZXZabjgwMkdWSWpTakdTVHl2VUczRmxwekpTalJ5c1ZsbXZrSEpnY0dvZ0hl?=
 =?utf-8?B?bGlrQ2ExRm0waEFIWXIxQ2VRK1IwcjFCc3YzcjF2a1YrYWN6aktPaXNpN0dm?=
 =?utf-8?B?Rkw4QmRFb0VtZzBsVnIzOWQrR1JiQzYwNHdXUHJpOExPS1I2TmJOZDZKWTgx?=
 =?utf-8?Q?Q4XFf/ovVEdkGf79WB/EvxXiL?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B212E2C394E9A144A74A72223696F5E2@EURP195.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9P195MB1212.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 0150fbfe-69c7-4a10-96b7-08de2e7b1703
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2025 12:38:53.5131 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CbMCoPpKZpkX0m11GxjgigV5/BJDODdRd3DN1JOD5ROEIWQktgVvUF8T014o6qymsQuftmNXHZZeyPPvWZXoqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4P195MB1961
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

SGkgUGVuZywKCk9uIERpLCAyMDI1LTExLTE4IGF0IDEyOjU2ICswODAwLCBQZW5nIEZhbiB3cm90
ZToKPiBPbiBNb24sIE5vdiAxMCwgMjAyNSBhdCAwODo0NjozOVBNICswMDAwLCBDaHJpc3RvcGgg
U3RvaWRuZXIgd3JvdGU6Cj4gPiBIaSBQZW5nLCB0aGFua3MgZm9yIHlvdXIgZmVlZGJhY2suCj4g
PiAKPiA+ID4gSGkgQ2hyaXN0b3BoCj4gPiA+IAo+ID4gPiBUaGFua3MgZm9yIHlvdXIgcGF0Y2gu
Cj4gPiA+IAo+ID4gPiA+IFN1YmplY3Q6IFtQQVRDSF0gbW1jOiBGaXggbWlzc2luZyAxIG1zIGRl
bGF5IGFmdGVyIG1tYyBwb3dlciB1cAo+ID4gLi4uCj4gPiA+ID4gK8KgwqDCoMKgIHVkZWxheSgy
MDAwKTsKPiA+ID4gCj4gPiA+IFBlciBzcGVjLAo+ID4gPiBGcm9tIEZpZ3VyZSA2LTQ6IFBvd2Vy
LXVwIERpYWdyYW0gb2YgQ2FyZAo+ID4gPiB0aGUgMW1zIGlzIHZvbHRhZ2VTdXBwbHkgcmFtcCB1
cCB0aW1lLCBzbyBJIGFtIHRoaW5raW5nIHRoZSBmaXgKPiA+ID4gc2hvdWxkIGJlIGluIHlvdXIg
cmVndWxhdG9yIHNpZGUsIHNheWluZyBzdGFydHVwLWRlbGF5LXVzCj4gPiA+IHByb3BlcnR5Cj4g
PiA+IGluIHlvdXIgcmVndWxhdG9yIG5vZGUuCj4gPiAKPiA+IFRydWUsIHRoaXMgY291bGQgYWxz
byBiZSBoYW5kbGVkIHZpYSB0aGUgcmVndWxhdG9yP3MgRFRTCj4gPiBwcm9wZXJ0aWVzLCBhbmQK
PiA+IHNvbWUgYm9hcmRzIGFscmVhZHkgZG8gdGhhdC4gSG93ZXZlciwgZnJvbSBteSBwb2ludCBv
ZiB2aWV3LCB0aGF0P3MKPiA+IG5vdAo+ID4gdGhlIHJpZ2h0IHBsYWNlIGZvciB0aGlzIHBhcnRp
Y3VsYXIgZGVsYXkuCj4gPiAKPiA+IFRoZSBTRCBzcGVjaWZpY2F0aW9uIGRpc3Rpbmd1aXNoZXMg
YmV0d2VlbiB0d28gZGlmZmVyZW50IGRlbGF5cwo+ID4gKHNlZSBGaWd1cmUgNi01ID9Qb3dlci1V
cCBEaWFncmFtIChIb3N0KT8gaW4gU0QgU3BlYyA2LjAwLCA/Ni40LjEpOgo+ID4gCj4gPiDCoCAx
KSAiUG93ZXIgcmFtcCB1cCIKPiA+IMKgIDIpICJTdGFibGUgdm9sdGFnZSBkZWxheSIKPiA+IAo+
ID4gVGhlIGZpcnN0IG9uZSAocG93ZXIgcmFtcCB1cCkgaXMgcmVndWxhdG9yLXNwZWNpZmljIGFu
ZCBzaG91bGQKPiA+IGluZGVlZCBiZQo+ID4gY292ZXJlZCBieSB0aGUgcmVndWxhdG9yP3Mgc3Rh
cnR1cC1kZWxheS11cyBwcm9wZXJ0eSBpbiB0aGUgZGV2aWNlCj4gPiB0cmVlLgo+ID4gQnV0IHRo
aXMgcGF0Y2ggaXMgYWJvdXQgdGhlIHNlY29uZCBvbmUgLSB0aGUgInN0YWJsZSB2b2x0YWdlCj4g
PiBkZWxheSIuCj4gPiAKPiA+IFRoYXQgZGVsYXkgaXMgY29tcGxldGVseSBpbmRlcGVuZGVudCBv
ZiBhbnkgcmVndWxhdG9yL3ZvbHRhZ2UtCj4gPiBzdXBwbHkgb3IKPiA+IGJvYXJkIGNoYXJhY3Rl
cmlzdGljczsgaXQgaXMgYSBjb25zdGFudCAxbXMgZGVsYXkgYnkgdGhlIFNECj4gPiBpbnRlcmZh
Y2UgaXRzZWxmCj4gPiB0byBlbnN1cmUgY29ycmVjdCBjYXJkIGluaXRpYWxpemF0aW9uIHRpbWlu
Zy4gCj4gPiBEZWNvdXBsaW5nIGl0IGZyb20gdGhlIHJlZ3VsYXRvcnMgd291bGQgbWFrZSBib2Fy
ZC1jb2RlIGRldmVsb3BlcnMKPiA+IGxpdmUgZWFzaWVyLCBhbmQgY2FuIG1ha2UgVS1Cb290P3Mg
TU1DIGluaXRpYWxpemF0aW9uIG1vcmUgcm9idXN0Cj4gPiBhY3Jvc3MKPiA+IGFsbCBib2FyZHMu
Cj4gPiAKPiA+IFdoYXQgZG8geW91IHRoaW5rIGFib3V0IHRoYXQ/Cj4gCj4gU29ycnkgZm9yIGxh
dGUuCj4gVGhhbmtzIGZvciBleHBsYWluaW5nIHRoaXMsIHRoaXMgaXMgcmVhc29uYWJsZS4gSSBh
bSB0aGlua2luZyBpdAo+IG1pZ2h0IGJlIGJldHRlcgo+IGlmIHdlIGFkZCBpb3MucG9zdF9wb3dl
cl9kZWxheV9tcyBmb3IgeW91ciBwbGF0Zm9ybS4KCnlvdSBtZWFuIHdlIHNob3VsZCBpbnRyb2R1
Y2UgdGhlIERUUyBwcm9wZXJ0eSBwb3N0X3Bvd2VyX2RlbGF5X21zIGZvcgptbWMgYW5kIHRoZW4g
dXNlIGl0IGluIG91ciBwbGF0Zm9ybSdzIERUUz8KCkJ1dCBhIERUUyBwcm9wZXJ0eSBpcyBhY3R1
YWxseSB3aGF0IEkgd2FudCB0byBhdm9pZCwgYmVjYXVzZSB0aGF0IGRlbGF5CmlzIG5vdGhpbmcg
cGxhdGZvcm0tc3BlY2lmaWMgYW5kIHNob3VsZCBiZSBzb2x2ZWQgYWxsIGZvciBvbmUgaW4gdGhl
Cm1tYyBzdWJzeXN0ZW0gZHJpdmVycy9tbWMvbW1jLmMgaXRzZWxmLgoKV2hhdCdzIHRoZSByZWFz
b24gd2h5IHlvdSBwcmVmZXIgYSBEVFMgcHJvcGVydHk/CgpSZWdhcmRzLApDaHJpc3RvcGgKCj4g
Cj4gUmVnYXJkcwo+IFBlbmcKPiAKPiA+IAo+ID4gUmVnYXJkcywKPiA+IENocmlzdG9waAo+ID4g
Cj4gPiA+IFRoYW5rcywKPiA+ID4gUGVuZy4KPiA+ID4gCj4gPiA+ID4gK8KgwqDCoMKgIHJldHVy
biByZXQ7Cj4gPiAuLi4KCg==
