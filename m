Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3312FC25B7A
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 14:33:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8EEE388378;
	Wed, 22 May 2024 16:33:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="XznvXoa1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8BED987E13; Wed, 22 May 2024 16:33:16 +0200 (CEST)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C3F388378
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 16:33:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PAr6rw4l43DTZFnhTISLsr046KUtNoldJfYRnO7BQt0A1662bWZCz753O7bZqSddmphEpUVSH7W2q9iaVDy+mbMHal8jHjBGYh9576Cn2cN5pUs7eVkRwUVAtjLLFs0YCjRBgCmjOPD4IHyFxdwAX0DItKkFCV9C/qwpn7AB5vVRKYLAdOEkat7HGuEDFpiNy775cvqIRopL2T4ocC3EmMcs+yZ1d8BJ0sF18Eog5M/HRCG2zgOtTUzOLXJckT3rG1mVCS+BkaJB1O8IgZ4rUJ/8z/bbxdzkHVgYfG7SDE2PfYLI0EETWbXIvoAHJJln6e0ccbZy5yFaSkhKHZF/Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/UfZ8YMpSCnTar87ROR4WROo0NWfDHjEyBvDqyX90Bw=;
 b=BpXGlIGqLyl7MYVitgIcePtuJVwRlvhBfb0iclFRm/ChvQIciMHfKKU27CORIBFx81IGJRFxbDaw93fFh8csyvqjgIww6gzzo4cHTfm/q4lJXcDYAapZNA2dbEWz7sIUBKGibj2xwd261lthbc5GRwKpNzf8D7OENWusY0ocHQNLew+V8kNx/4fX+IFRO4GUR9dQZU/9+IxP0FUY8P5bdmX6Ddbp1jdFv06l8pscN+ETw40A2KZ48oauvGeiT8jTrIQ9nDhVYVQTHsGYzSKKX9htDL2L9RiBcV+gfWKZQsV1Lq7LpRWkNKN/cK6zhNj3vBFWMir0vrAZxsiUUvLY4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/UfZ8YMpSCnTar87ROR4WROo0NWfDHjEyBvDqyX90Bw=;
 b=XznvXoa1ZQL0Bo4O9EOdNRSOnMleCp/QHwPecUDn0RyQr2L4vx9x/a0EWUybL6xIOBqK+KZNY0YmhK0Nh+m7542xmz5+4poZrWA3zdPvBhkrDWOBRKlEF/0nopfaI/ZQadARKp9MiAcsO/z1SG5La3yP5nhoEa0EOgCznXD86kw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from VE1PR04MB6589.eurprd04.prod.outlook.com (2603:10a6:803:128::25)
 by VI1PR04MB7165.eurprd04.prod.outlook.com (2603:10a6:800:125::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Wed, 22 May
 2024 14:33:11 +0000
Received: from VE1PR04MB6589.eurprd04.prod.outlook.com
 ([fe80::8476:1b2f:f236:db31]) by VE1PR04MB6589.eurprd04.prod.outlook.com
 ([fe80::8476:1b2f:f236:db31%6]) with mapi id 15.20.7587.030; Wed, 22 May 2024
 14:33:10 +0000
Message-ID: <561b07a0-94f9-4c96-b945-a859d7c31226@cherry.de>
Date: Wed, 22 May 2024 16:33:08 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] clk: rockchip: rk3588: Set SPLL frequency during
 SPL stage
To: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
 kever.yang@rock-chips.com, philipp.tomsich@vrull.eu, sjg@chromium.org
Cc: lukma@denx.de, seanga2@gmail.com, quentin.schulz@theobroma-systems.com,
 zhangqing@rock-chips.com, jonas@kwiboo.se, u-boot@lists.denx.de,
 Heiko Stuebner <heiko.stuebner@cherry.de>, Andy Yan <andy.yan@rock-chips.com>
References: <20240522121559.1024535-1-heiko@sntech.de>
 <f04e4d06-82ec-43ab-a077-592685fd7d56@cherry.de> <9330720.rMLUfLXkoz@diego>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <9330720.rMLUfLXkoz@diego>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: WA1P291CA0009.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::20) To VE1PR04MB6589.eurprd04.prod.outlook.com
 (2603:10a6:803:128::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB6589:EE_|VI1PR04MB7165:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fd18afe-3019-489c-e4e2-08dc7a6c1af9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|7416005|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M1p3QlE1UFhRVHdBNjFEYXhSeXpIcnhRSUZCQ3l6RldNLzVKeGJNa3NUOC9n?=
 =?utf-8?B?NVVoODVKQ0RNcThKQXkrd29xaHJ3VlhxNHRlYjhDNkIweVdGV1RFdHdUVEZ3?=
 =?utf-8?B?Q3kwbDVrUTB0VlFuTUZnZFRkL2RPY3VENTF3cVFkaTJNc0Rqc01Fa3Zrb21q?=
 =?utf-8?B?Y0pFa3BoY041VmZmakJUN1lWVGpEQ0RaTUxRVWRXV1BGU2ZxMnBEUUczNkx5?=
 =?utf-8?B?Wnhac2lYNm13MTVzcFQvUjkvZzFWUDlWWkFaNlFPN2F3VnV4ckJKVnczR1NP?=
 =?utf-8?B?aFN0OG9hNEhub1I1RzR4V2JiQkJ5VWNLd1Y3cGg3SHU1aStuUHBJdEJ4aHo3?=
 =?utf-8?B?RlpqQ2diQi9mdzFuVkY0aVorYVJEdGMxUzcydkw3eGJ0TmpsZzRHTU4xaDZk?=
 =?utf-8?B?YTV1T2p4dVBmd0h2dVpzY0prOHNOS1VwUHFZM3NJS3RZSkh2ci8yUDNscnRF?=
 =?utf-8?B?OHRHa3dmaGZLS0t4bmJwMEp4RXJQSVdKdHdNQXp1ZE1TaVN2NFhXNUNYbGFV?=
 =?utf-8?B?MlAwOVFKSnRyUTBUanFxc1I0ZzB5RE9TTng2QnNVWjZXTlBJTzkzbDd3Zmh4?=
 =?utf-8?B?RGtqUE4vajRtdnF1d3MyZ1B4blVKLzM2ckpWQmFOazgxa1cwdXNHOW9xT1cv?=
 =?utf-8?B?MkdSRDl2WVZvdkRsNGt6VDdTbnpOWHlaRFk0YmtKa3RnS0lNYlZJS1FzQ2Vu?=
 =?utf-8?B?NU1FSXNZVE1iOFU5anRjU0hGSDhsNU04Q2htTHNGWUY0OWo0eEVFZkR0ZWxj?=
 =?utf-8?B?bDYyOHpmNWlmaGtubUdkMGh5QnU2MVhYa0Q5RExlS1NBSGIrVW0yeTdtRVZm?=
 =?utf-8?B?eFhoR1dERDcvSUt2NkhYcnMxaFQxVW84UlRHcXBRdE5mMmtxaWZLVlorTlFj?=
 =?utf-8?B?aFcxTXFSTGFOZG54WDNBVFV6QUJxT0FVS3piV0lKTnJzNytyQ21iNEg3d1RP?=
 =?utf-8?B?cW84dWZhT3lCT281WUsyU2doWU1WcnY4M0RsYnBPdHFHT3Z1L2IvSjRVejFv?=
 =?utf-8?B?cEx0aGpzaHI0OUFFQXE0a1h4aUtZeE5ZSi9La2N1NE9jUm9Dd2tXYVpLSUFG?=
 =?utf-8?B?ZHR1d3BDZWF2UllSeGxjbnpXM09EWExSenE1ZHFoUnVsM1czNFoxZVV4UDVo?=
 =?utf-8?B?RDhPc0t4L1g5L2xFZ1pQWTRyU1V4c2pTVHFEZ2MwNktha28yangrZXdLWVJ0?=
 =?utf-8?B?ZU4vOTVJQkpVZlFSSjcwYm9tN2ZqTjFpRDhBWGx3QTdCd2xRQ2RwcXFjcVFY?=
 =?utf-8?B?Vy9vQ2tSVUpvQkQ0WDBxOTJBdnRGWGxlYSs1WGJOUTJKYzl5MDhnaDRhR2l1?=
 =?utf-8?B?djUwQjFRUzRFQ1dMYVNhelFwSzJaUzY0dTB3Q3ltWXBSdWpZbVFsM0xQeDVl?=
 =?utf-8?B?cmw0QnFCNGk1TXdEWW5JSUlTcUJCdXNGNWNYRXdjNTZMNWVqRFVJRGdMK3Mx?=
 =?utf-8?B?M0ZRa281L21uTVJiY2c4T0NtTEJQaWxqbHdYT24wckthTlR1UUZCeWE3NFo3?=
 =?utf-8?B?OFZITzlEMjdYN3Z1cmRpUXZ3M2U0NWorU2ZoSDJRRGY0c1FyNk14SGxzSXF4?=
 =?utf-8?B?TndxUWRiS3N0cDBmWTNCRG9UTWYydXlyd2xwYnIwQzZxZGhmNks0NEJnWG1P?=
 =?utf-8?B?YW81OTdFR1cvVG0vK2NjYkszdzlBQW4rL1ZHaSs5WDhUS1NLN2ZuMVVETnpp?=
 =?utf-8?B?ck56Y2R1WEhqQWxYRFp3Y05MWncwc1BmUGNsYm11Rk1MK0JiTlBDRU5nPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VE1PR04MB6589.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(7416005)(376005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?elNpVFhKZ2hTMEZ6aGY5QzNLMGl6REg1U1lYWHNyUnJxbmhaZm8rWEdmaFAw?=
 =?utf-8?B?NmlJZ2xlWEZ2VWFsSzM0ZXJ2VE5lbnVPRm9LN3NSSFNvQ0REZ1JWdjF2T1Yx?=
 =?utf-8?B?SERYaUljT0xtM3VsZWk4NW9KZVZzbVJ6bnJIaWdWWTVrNWFGbFNiRTdmTlZl?=
 =?utf-8?B?Q01hMy85YW5XVkk2TWpUS1BZVjZpbDJlOWFCd0o5eEloRDNXU2Q0U3d4cmFy?=
 =?utf-8?B?aFVUdGk5WGRVSjNlQVljRXlxUUl5Q2pKbXF2OFRET09BZG0wM0ZsRkZ5Rm4r?=
 =?utf-8?B?bkUvbm45VHNtRGFVZi83NTE0RXptNFpwNGZ2YlJCYzVSakQ3TGRLMklGV050?=
 =?utf-8?B?elBMWU1RR0JRcWNpeDgyYnU5MWMzMXl1cmlaalU5U3RMMmdOK1ZGcjk4Mmpv?=
 =?utf-8?B?ZG1RV3VqZWpiOE9TNW9sT3NaN1p3eUs4VWx1K0JyM3pzYkJnU3l3QlVZSVN5?=
 =?utf-8?B?Q3VqOFVOczJuYmkrN1ZwMSt2T1h6Mm1aTUNyamo1STRuOVU1M0VuTGRlcFhZ?=
 =?utf-8?B?dzdOeTRSQzFzT2pqMVIyRWxYc3dyQXRnK2U2NEFmRlNJTUhyZDgwYlczWmgy?=
 =?utf-8?B?cW9ic25Vd0txd0doK0xQUkVveTZXT1NXL0ZWWFFDOG4xNHVZVGtUQ0dBK1Bw?=
 =?utf-8?B?empZckVBSll0c3F6KzBGOWx6aVVQQ2IxK3Q1d2pCMWo4OGhXTStFdG8vN2NO?=
 =?utf-8?B?c21sdnpDSlpRK2hZV2tQQkJvSVM5RVphTExpYVlCTDBrRnh1YjlyTkx0UUl1?=
 =?utf-8?B?a3FQQU9Yc2doeUd2eU9iWm9wMUdOQTNMcHk3cGljVjRQYWRLcks5eXV1MGtB?=
 =?utf-8?B?clZ0UEpqMm5mQ2g4WjBpQzl6MXd6c29hckRxSVE3enIyeUVGRi8zcWNlQ3V4?=
 =?utf-8?B?eWl2SEZUclNJd2hUZnNBdlVCNm5KNEtHN2VxSk04WHR0MGkzcTBSbXZUNWRZ?=
 =?utf-8?B?NmJtMmdPNi81V2MzSEdwVTB2MCs3ZHErczc5b1F5M01LbzNwZGhRcFRVK09q?=
 =?utf-8?B?ci9tSTkzRkt3Qlg0OGZPMnluWTNURFQ2OW9TQkhRb2ZIc24vN0pvNHBrSldY?=
 =?utf-8?B?eVFwUU5zSDVlQ3lsME5WT0pCc1FLK1JMZVlCWEZOWVNoTTNLd1ZqbXo5b1V3?=
 =?utf-8?B?R1hlRFhlMkF0U0pEY0dORy9aM0xnbnlzTXJkMVB4Z1JzUTlSdm81VFpKUm52?=
 =?utf-8?B?dmRzTm9SYm10SlIvNytmVEdjVkVOcVVDdlEvSXVwQTJjb3FSSDBMOUZ3NEgw?=
 =?utf-8?B?d3Qwcld2NXFuMjdzMjFzRnppTzNRems2bXBpVU44K2J0Y1VTbHd1bjlwdDFQ?=
 =?utf-8?B?SnBXZ1lSOU5EbjVTYWJJSzVZWHBVTU1aN2RDVWJMdjFVNWlUV25VS2xEM3Ey?=
 =?utf-8?B?Skc3ejkwUWZ4WFE2RVIySVF1YmhXaDBEc0xVeHZMWnRPazRJa1hBU3FNeHRr?=
 =?utf-8?B?cnd4TmNtR1ZzK2t6VDBpMWVqc3VjYXNtL0pYRTMrSUVibUhya3RCaXIzU0My?=
 =?utf-8?B?ZDFZSjcyVmVROVJHallMdHB6czdiL3A4RHNQYWNubHBEalA4di9YSUJ1TXhk?=
 =?utf-8?B?ZzdhQVpnajhQYWd1K0pzaFlVeEdWVnFXbU55bzkybHQ5VWhFMnRpUmFNZS9X?=
 =?utf-8?B?dTRjOTd1ZzBuVTVVUFFsWUlJdGlMZWM3bW50RmxGVDlITnNteVQraVp0MXMr?=
 =?utf-8?B?TjFDcGJVMTIycE1KRmRsWGlzaXVkYzRBSlRqZWpmQlJFcDBLRWU4TjRpOVRE?=
 =?utf-8?B?a29sc2FSVXFFZHpqaUdWSHlUaWpST0QwbTFQOUxlaWpCZDVJZXZ0S2NRRmV4?=
 =?utf-8?B?aGdQOUM3YXJGSmhlazE1eXUzWUhRYy9XZHM1R3QzQ1EvM0tXSmdKVUVTQlJu?=
 =?utf-8?B?UFJQRFFHSlp5YVUxdGc3YkoyRDJXWEFBMkpCalFIZUJndS84Ri9GSm1OMUpy?=
 =?utf-8?B?QXZjbmVXVm5QOTNwOTBRM2RTMlBPcUZHYnN1aytXYkpZd0l2b243OFVZRWtR?=
 =?utf-8?B?aEdCcGJmMGw1NWdPTklNdHRPQ2MxRDNXM2R4U2Z2bWdENXRrbGJrR0VETHpH?=
 =?utf-8?B?NURRWXQzWVdpaWdOUW5raG1EVDNsRXo0MGhYRmMrZlFiSkU1OWdLM2JrZGVJ?=
 =?utf-8?B?UXVJVjc4Tnp6RW5aYzI0dUlLQS94WTk2MGhhM05ZVUU3KzkzWEtTSUx1Ymt1?=
 =?utf-8?Q?PMEzMtEq19c+xDi/Hu+rNU8=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fd18afe-3019-489c-e4e2-08dc7a6c1af9
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB6589.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2024 14:33:10.8912 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wLicj2dnknjXGuGPQL3bUWdRS2DDteD1cwnNj2+4DVwSLGfghJCyKxCTNRV/Y2LqumoL9VzoUSiA7C8cHI1ws0g3bY9g/5+/WQTRme6ghW8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7165
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

Hi Heiko,

On 5/22/24 4:18 PM, Heiko Stübner wrote:
> Hi Quentin,
> 
> Am Mittwoch, 22. Mai 2024, 15:59:24 CEST schrieb Quentin Schulz:
>> On 5/22/24 2:15 PM, Heiko Stuebner wrote:
[...]
>> I'm also a bit wary of defining SPLL (and for that matter also V0PLL to
>> PPLL) with offsets relative to a different base than CRU (SBUSCRU for
>> SPLL for example) while all the others seem to have offsets relative to
>> CRU, c.f. RK3588_B0_PLL_CON(x). Specifically, it seems we are calling
>> rockchip_pll_set_rate with priv->cru which is the base of CRU. I am now
>> not entirely sure anything from V0PLL to PPLL is actually working since
>> we use offsets relative to some xCRU but call the function with the
>> CRU_BASE.
>>

I checked again and they are actually using proper offsets.

All in CRU are using CRU_BASE, others all add the offset of their base, 
e.g. RK3588_PHP_CRU_BASE for PPLL, RK3588_BIGCORE0_CRU_BASE for B0PLL, 
RK3588_BIGCORE1_CRU_BASE for B1PLL, RK3588_DSU_CRU_BASE for LPLL.

>> So... wondering if we shouldn't have:
>>
>> #define RK3588_SBUSCRU_BASE        0x18000
>> #define RK3588_SBUSCRU_SPLL_CON(x) ((x) * 4 + 0x220 + RK3588_SBUSCRU_BASE)
>>
>> and then in the probe of the scru driver, use CRU_BASE as the base,
>> otherwise we're doing some mixing and I don't like that too much. Or....
> 
> At least for the SPLL we're calling
> 
> ret = rockchip_pll_set_rate(&rk3588_pll_clks[SPLL],
>                                     (void *)BUSSCRU_BASE, SPLL, SPLL_HZ);
> 
> so no mention of priv->cru there at all and the pll-function internally
> only hand down that iomem pointer. The scru-clock driver also is
> very specific to the SPL, as it the whole thing will be inaccessible
> after TF-A has run.
> 
> Doing some janky maths on top of a different base definitly sounds
> a lot worse than just having a comment above the PLL definition
> stating that it belongs to the SBUSCRU ;-) .
> 

The thing is, everything in that array actually uses CRU_BASE as base, 
so for consistency-sake... doing the janky maths makes sense to me :)

Up to you, at the very least please have the comment.

> 
>> What about making this handled the same way as other clocks in SCRU,
>> without actually using the table? Or... Have another table just for SCRU
>> in SPL and migrate existing clocks to use rockchip_pll_set_rate with
>> that new table?
> 
> The rk3588-pll getter/setter relies on the pll id to do even more special-
> case handling. See all the pll_id == x checks in clk-pll.c, hence the PLL-id
> is sort of global over the whole set of PLLs
> 

Yeah... an enum for that would have been nice as well. Still nothing for 
this patch :)

Cheers,
Quentin
