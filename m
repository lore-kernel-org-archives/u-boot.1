Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A99AC52D7C
	for <u-boot@archiver.kernel.org>; Wed, 21 Aug 2024 08:19:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DDD5A88B52;
	Wed, 21 Aug 2024 10:19:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="A6Cl4N6G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A33A88B9F; Wed, 21 Aug 2024 10:19:53 +0200 (CEST)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E0FF588B4C
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 10:19:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s1ftDKZkQcgP2pz1HrZXz2FozkBVi2Q3itUG6byrKzGkhOU3IhLoGGRpNbDPFc/LW+FXKEzhbszRmEvr3HfSPCa5j0uZaCfQrs/WuOJfk1NvrSzZ82NFcRLFxvzKGu/e60u57uZdRaGkv5NZuWR2u4d8gI5vw0MqkQbHMeCrkGmLC64WstTgMJY+9qx/f0xpnM1ZpP86YoxZzlHWGcs0L5xfAuEiEV9V5JK5kwdTUzB9Mulf9RcqxyFZr0RRVZb9rwhmCpdiNcZxwTFqrBu9nq3lT/dmHGbaeA+0ddThFlwdYAdH7fvxl9Stdm4I/W0qz0xK4FS8apm4P2zWr+ogyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xrrLzJnu+GvDBMhLmCNxHHk2dPP18mZdLkVFeoCP098=;
 b=iy7PWa7/iB+4F8CiqjZCCqtSC2gD//IDqsA5Bw3contI2v/i7O70ryQcP3pTyi5nHflstF86p496tAyMhdB8eyFnGn8hqFIb+6x30DWMg7JpqhsjaXI9fCEhH6sbRgNoLsomkT1jRwsM5g9nXbvKH4VVqaWGnr8idkUWlZrVRHNF19kejkeHqHehP8/sN7nAtarZJ2l7qaUGLfggc6sw+Fh7Ev8IDvxdyGJ1kCDSAorvy/giiBvwNhVgOLrZalXwtDBeV/tWj9g1vZ0TUsRo0eA8N80pX3foTIb6V1TaPrPlN2Ag3tOav+uh3ZytCif0j/Am1uQ3qqd4mtSGTVhaRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xrrLzJnu+GvDBMhLmCNxHHk2dPP18mZdLkVFeoCP098=;
 b=A6Cl4N6G0qg9v+aZMz2/8csIK/ygbU4VVuw4wVOgxRTVCxfXkYy3NrUzk6inl6AyZ9+zNk3qArc5XzE4AtLs907K+ZfEjhk2KLFzMJsAmmI2LswgcpdrcksHqr6FxjbxCDe2ue+Jqj6HDNaFFPii6dnqB0maDNsB/NX1IHQ9TU0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by GVXPR04MB9901.eurprd04.prod.outlook.com (2603:10a6:150:113::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18; Wed, 21 Aug
 2024 08:19:49 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%5]) with mapi id 15.20.7875.019; Wed, 21 Aug 2024
 08:19:49 +0000
Message-ID: <5b8e78ff-2a72-4af0-a286-065f312cbb8f@cherry.de>
Date: Wed, 21 Aug 2024 10:19:48 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: clarifying i2c_get_chip_for_busnum()
To: Simon Glass <sjg@chromium.org>
Cc: Sahaj Sarup <sahaj.sarup@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <CAKZ1LvNcW7y0SnHwye98m1UrL53cqsErtKjFbGp0z+doiU+9aw@mail.gmail.com>
 <77a23ada-f1c2-4542-a4c3-55c71a1cc49b@cherry.de>
 <CAKZ1LvPSLRZJ0HnUtSvwOMw5ax-Vre_m94MaDrfhYmKYK_0KGg@mail.gmail.com>
 <6bc0ccf4-66ef-467c-a3f2-e39d3d54f7cd@cherry.de>
 <CAFLszTggctZ-iRj0PS7zgCbUM8y3VUGky4aheg0HGw4RQvUsOQ@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CAFLszTggctZ-iRj0PS7zgCbUM8y3VUGky4aheg0HGw4RQvUsOQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0131.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:7a::8) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|GVXPR04MB9901:EE_
X-MS-Office365-Filtering-Correlation-Id: 524ab5b3-a93f-44dd-1f8c-08dcc1ba065f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QnMzUzhWWlBTRlU2OUkvcFAzcWxVTThzTnZxblBlTC9JOXdTVHRHY2FhRzUz?=
 =?utf-8?B?VGJlTTAweHdTRksrclZuOUljeXhadi9uZEV2ZDk1MTI0bzdMZnZVa3EzSWJz?=
 =?utf-8?B?Zk1FVURqdndCaEFWaERORTl2NWg2Q1F0VS9ZakZZR0tEK1JjNERQOGZCY0dT?=
 =?utf-8?B?ajJTeC9VTDM4ZXU5L2gxUjYwVXJIbk1OdWc0WmV4TmpnYXM2Nzd3QUJrMnJK?=
 =?utf-8?B?SEFyN0lGSFFVdit1R2REU0MrTXVCeWtjeGdiS1NCUmVmdFhvY3JCcVNmNlZr?=
 =?utf-8?B?NFhSMWViaWFFQ3JoeHptUzEzMlBPM2lxenRsdVU4OWRDcGcySFR0dUVLQk1z?=
 =?utf-8?B?VXJXaUU3WFdZUXo3bHJVeHhFaXQrVGNzMlVXOEI3S2V5NjJQc1pjdEhoZm9n?=
 =?utf-8?B?TVA5eTlrOGlGR0JGUDV1MzVqUHBJekZoWm0zQXlFMmI5dUw5VU9BTnphWERD?=
 =?utf-8?B?cER5VS9YSGVNTy81WXV6azV1MStvTEpjUzBiNk5JMmdpbjRFWXBkVitsU3R4?=
 =?utf-8?B?bFdWQml6OE5tTlM2RFV4amN5TldhK3NaZTB3Wk1Zd0JhVlBMRjZyUUxTdGtx?=
 =?utf-8?B?M3pmNjVZZjBPNmR1bEVEaXlwaTVHSHlMOG1FdTZJcC82VGJ4NS84WElyaG9N?=
 =?utf-8?B?WndhTk1wT3kxMDdJUmZEaXd3aldPbngvc0xWeE84cERMWnl4ajBKcVhycEtj?=
 =?utf-8?B?U0hnVmtrL0YxVWVmaWRoZ0NXR1plL0NqTVAxRXFvRmJValRXRG9uWDhZVmlN?=
 =?utf-8?B?OUtFbU1nL0xHZEp2T1JVMUpCMUJLRUJyVG90b3IwVGVKSnJVWk43N2tvR0pk?=
 =?utf-8?B?NGVLUTNZKy84dFB5QjNuandMa2dZeUE2MG5ZVko4SDMrVkFzQmtSRTN1VUh0?=
 =?utf-8?B?d2lzUXd2cGlVOS9ETlVrZkVYaDlsSnh0RzdHUEZ6ZVlMVHE2ekhzSGhDRHhO?=
 =?utf-8?B?M1o0OFFKTzRPenJuVTdhYXBvN0NQcW9NdXpNcEJnc3BKTDJCeWIwdkZtMTNw?=
 =?utf-8?B?eTMwRFlKSkVpdVUwWDQraDNxUkR5ZHl4bmdvRlhtQThhdTdPUEk1enRIc3JX?=
 =?utf-8?B?VHNXODZwTjJNZ09yR3FvQUlxenV2UDUvWG0rVE85OGpWTkZ5QkoxalFmYlQx?=
 =?utf-8?B?VWtlbFRGMnh0dVFucFdRMHVpZUg2aEZ1dWg5aUZWVjNodjdXRnY1UjQ1Vkpp?=
 =?utf-8?B?czFBTFplTWJmWFpjSHVjNzRRTVJvN3BkQWgyQU1hL05YblBsa2VFZEJrbUti?=
 =?utf-8?B?QUhvOUpsK2VkcDZnQy9KL2JhYlN4V2VCMHFVZzkySkU5N01ibGhYRTJXTjBo?=
 =?utf-8?B?ak9GMkZlS1M3VVJWelZEU3l5bXQ2djg4K20yOHhSdWp1YVF5ZWJpbTlCa0J0?=
 =?utf-8?B?Y3BhT0U3QlpadGc4d3YvR0dBNUZNdUt1WWk3aHVTZjJTTnkyaDJrQ00xMjl2?=
 =?utf-8?B?dmtMT3JxUkcvbS9XTlRjV3BUK1hjWjRYeGdURkwxS1VoN1BBVVc3aUY2K3dq?=
 =?utf-8?B?bEU1RERhUUF5NU5pMEs0aTczN3RMeFRZaU1zSlMwWUV6WjBBQnFRV0pCWDdI?=
 =?utf-8?B?RlM3RnRnSnM1cTRVeW9DQ0MwS0FtNGxwalBHaFA0YXl3TVN6R1R3Z0RtOFNU?=
 =?utf-8?B?YVA1K1lyaG95UzdsL2ttMDNyUDFCS3FiT2lPMlZWSWpyM0diL2pkRU5oWldJ?=
 =?utf-8?B?RWNaRFpkKzdUYXJCZ3VQb1REQmx4NXhFVnVKSXdib2VJNzd4Mmg1SGdIcWtm?=
 =?utf-8?B?KzQ2aE53QXRtaEN2VnFpQ0doUlQvSm9LYUVUaWt1Y1N2TE5HRHptdVdqeGJk?=
 =?utf-8?B?QVZGdzhma29hOGZTWCtXUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?djZ5QllmT0JaYVZ6czBtWlg4ODFyMi96SnB1Y1B0M0NJL21sNTRQa0F6SlpV?=
 =?utf-8?B?dzdYc0ltdHpSVFhSVFRaT29FMzBHWmc2SGFGWXNkU0hNNjQ3VFpnTldhbWtY?=
 =?utf-8?B?VzN5Z3R2eUhwMXZ3MVBscVFqMFNDM053YVlOUEZMQ09HNlErV2poRjc5dkZ3?=
 =?utf-8?B?ekRaTVhPSlFlN3RaR2NvMm05WGpEOVAyVzR4QzFWV3VtNHB3WUk4QlRLZEpK?=
 =?utf-8?B?RWxJdE1Ub0ovRVJWZzM5bmh4aytYRnE4cEY4MzMySUlrVk1wMnh2bDA1VDNv?=
 =?utf-8?B?TmNUNktJMnRTZXR2MjJiT2JIYnQwZzE0Mm8rVU52Y09Ma0xYK2xHcHl3K2lq?=
 =?utf-8?B?MitqMVNzQ1hyaFhjd3B6MEVmWGJFWVJ3RFR4WXAxUUtXMzF0aFdjb01YSndk?=
 =?utf-8?B?UGJzR0pyaDRIMHVBZ2MydEo2cUxxWjJmZGZUelpHQnZTbUlZaGcvMTNqRUxx?=
 =?utf-8?B?UHEwTkNqc2dDeGFGRnI0ODlxeHN2V3NLQlB0SFgzU2ZrZlF2VHYxbVN3dkVE?=
 =?utf-8?B?Yk1aSzU3SURVdWp1WEZXU3FWd0RmNG9CTWY3bWRlS0hZZVhHbERQdVZVRk9H?=
 =?utf-8?B?cXJvemxKRlNTUk9yUE5uME9JZFl1SDd3WlUyd21hWWJxN0FWUFliRkFIdExB?=
 =?utf-8?B?RFJGelZRRjBReGlKSGtlekZvYUR2em9YTGN2VEtwbTEwaEZ2MEVlSjZhNDVu?=
 =?utf-8?B?UnRpdExBcmdHU2toMUV3RlhaUk54eHhLeWl5d24wK1ZyeHduNjhNS2dKTHNR?=
 =?utf-8?B?ZVR0elFMMnJ2M0sxMEZ2YmxIMS9sTjA5cmx6OFZRSmI0ZHFBRTg0aWV1b0Fq?=
 =?utf-8?B?VTZtMTR1ejJhcFJHRTlzdmxiSkJhYXlkbnU1dnluUk95eEtlODIrME1IUnB4?=
 =?utf-8?B?L0s0ZWhiMDk4K2QrNGk5dEs5dGxXZW9oVDYwMVdaMlZSYzF3cjc5TzlKbEcr?=
 =?utf-8?B?VyszQzRNaHV4SDBlUElleVRDL2VUaHllbkpUNHJac2lMQ1NHRzVzMHRKTXds?=
 =?utf-8?B?bDgzK0F6cEo5K0JtZS9DdHJmZHBhQ0lPdUE0dG9JWDBPSzM2dzYxVlRpa09C?=
 =?utf-8?B?Wm1mb0g0ZTJmUnVTWUQvdnkwWXJmNXpSSHR5UGVTNkFOdWdBblZRN2VpUW1Q?=
 =?utf-8?B?N0VsMnZ3d1loOW1PWStWaGdJTzFKamJrOHhqQUtSVy9rUHpjYjdPV0taMjA3?=
 =?utf-8?B?WVk4N0FpajRnVWlmazRPSU40T0hSazNDZmxUalZPTjhnL3BwczdOb2lVZDVR?=
 =?utf-8?B?OU8zSzlSWUxjNXdFUjNIQzYreCt6M091SmhEajArQTJOR1Z1MStYZEsvZThv?=
 =?utf-8?B?VUppeUdGUFlSWmJQMndyQXllU2tFbSs0MTZWT0VuamV1dWlUTlRjYXFhS0Z0?=
 =?utf-8?B?M0FRS0ZzNjhIdEpDTC8rVXpwQjJuN2RTa20vOTQ4SkNyZCtVdXRuNmpyQ3Vh?=
 =?utf-8?B?VzdvNWdkWGFBMFNUNDJlSjEvZXd4RFF2Q0Z6Mi9wZyszT3R0QjVwR2doRkdu?=
 =?utf-8?B?UUl0aW1jbC9nN0pxbVdTV052R2Y1VEVMR2hPSHpoQlQwS3hMcEtQUFF6K3BY?=
 =?utf-8?B?cVJwQ3U5anZsU0hZV3pId1hBQ2NhN1Fkamt0RkZWK3IwSU1jNVZWUUpFUHpT?=
 =?utf-8?B?Q0dCZDVVV2JxcCtTc1lpbHp0ZUU1TzJ4cU51TDlNZDVzU0FhWFBENDRJOWE2?=
 =?utf-8?B?UnZnSzZRNzhIa2FGZ3M5WGN4LzQxNU5DNmZyQkg5U2tFYkV6NlJvRC9wQlpS?=
 =?utf-8?B?cDQyanpEN2U0VGJRWVpuSkZGcVFFVjdPbTF3eGdMOXNpWFpiMTE0dmt1b3Bp?=
 =?utf-8?B?eXpKNURTSFA4T2g1V1R0emZzOGlENDdMUDIvUFlDUWU0Y05QVUE0VEE1RDZZ?=
 =?utf-8?B?dnJ6cnRSTkJmR1hFTTk1aklKeGtxb2dyeEJaamZXNHRNU0FLN1ZIRGJqbmdS?=
 =?utf-8?B?ZWhPYTJXQ2ZBT0NqZ0M1d3Rzcjg0RVl5TXBRSzNBdWlUOVhHbHFYVXFIQlJ6?=
 =?utf-8?B?ZHloaTh3SG00SUlqZEdtdUlaRysvWXFWY2JaMHV6aVpMZUlIVTYwSlV4Z1dn?=
 =?utf-8?B?Vk9TL08rTGQ5eE1OWTRjcVVkRmZGa05sMk1XcjY2RWlqYitpc3VNRXJtRHZQ?=
 =?utf-8?B?QzA2U1FsSDZYYU9Fd2JMaWpvQ1J0UlRBc2ZFRXlkU1BEaEg1UXdLeWwzdnZq?=
 =?utf-8?B?UlE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 524ab5b3-a93f-44dd-1f8c-08dcc1ba065f
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 08:19:49.5640 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ocR/v/qzXi78yry3EbStURlZZEuVVGWQ92ICxnmID6lX3EHc0uYReN4XfzSHV7Xvklj47sgc9MPXG07u5pVlTIRugg+u4mx+VuksqLeGTak=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9901
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

Hi Simon,

On 8/21/24 4:11 AM, Simon Glass wrote:
> Hi,
> 
> On Tue, 20 Aug 2024 at 07:34, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>>
>> Hi,
>>
>> On 8/20/24 3:01 PM, Sahaj Sarup wrote:
>>> [You don't often get email from sahaj.sarup@linaro.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>>>
>>> On Tue, 20 Aug 2024 at 17:21, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>>>>
>>>> Hi,
>>>>
>>>> On 8/20/24 11:12 AM, Sahaj Sarup wrote:
>>>>> [You don't often get email from sahaj.sarup@linaro.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>>>>>
>>>>> Hi,
>>>>>
>>>>> In `include/i2c.h` , the udevice pointer and return value definition
>>>>> seems to be confusing.
>>>>>
>>>>> ```
>>>>> /**
>>>>>     * i2c_get_chip_for_busnum() - get a device to use to access a chip on
>>>>> .
>>>>> .
>>>>> .
>>>>>     * @devp: Returns pointer to new device if found or -ENODEV if not
>>>>>     * found
>>>>>     */
>>>>> ```
>>>>>
>>>>> Should this instead be:
>>>>>
>>>>> ```
>>>>>     * @devp:   Returns pointer to new device or NULL if not found
>>>>>     * Return:  0 on success, -ENODEV on failure
>>>>> ```
>>>>>
>>>>
>>>> For the @devp part, seems like it as uclass_get_device_by_seq sets it to
>>>> NULL and i2c_get_chip only modifies it when a device is found.
>>>>
>>>> For the return part... not sure. We don't overwrite the return value we
>>>> get from functions we call, so not sure we can guarantee that only
>>>> ENODEV will be returned?
>>>
>>> make sense, devp can't return -ENODEV, ofc, and Return returns 0 or -ve.
>>> So it can be closer to:
>>>
>>> ```
>>> * @devp:   Returns pointer to new device or NULL if chip is not found
>>> * Return:  0 on success, -ve on failure to find bus or chip
>>> ```
>>>
>>
>> Nothing guarantees we'll return a negative value either though, c.f. the
>> if conditions in i2c_get_chip_for_busnum(), where we only check for ret
>> (i.e. ret != 0).
> 
> That is pretty common in driver model. Few things return a positive
> value. Mostly they return 0 on success or a -ve error code.
> 
> Note though that *devp is generally not assigned if there is an error.
> It is left unset, so it could be something like:
> 
> @devp: Returns pointer to new device on success
> 

I assume you're suggesting

```
* @devp:   Returns pointer to new device on success
* Return:  0 on success, -ve on failure to find bus or chip
```

?

It isn't clear to me what's the path forward with this patch, hence the 
question.

Cheers,
Quentin
