Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 571B2FF885A
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 09:57:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 966B08394E;
	Mon,  4 May 2026 11:57:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="Itr0qbMR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9CB783EF9; Mon,  4 May 2026 11:57:01 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32A2480F0E
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 11:56:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bvO/71x2w7ndtzbIHMkIX3Cboh8LzMKXcHcrMKJ7UkLFZEOp744GAmm/D8GUFQg13etzZEUu6JYonIZH/9+0T6vpHUU7vwetDyulXfRz3otrV7wkzNHc5zSgTxgJP1m9Pb2zjnebirIsId0qO6KawbE9C0EYZ6/7gJli/zIwaHvhIHwI/fp1SsCcFQaOo5SegI1K8MyTFiYSVGuP1ZyCWCbkfL+iVq7XF/YTBGN1V600s+8jcMcaQlURuS6RlIPnZXg/9w0Mt7zUYaK8Yx4CkTqN0eR65WllG10xXtcqJlJxyWGN2/KUih0Qvu+rYucpSiLXtR40RZMoW6h/HJsR6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OnUZDnZjYNll4/WUg+eJPY32TZPU768qj6Wvj2086rI=;
 b=nNO0pBkXxSl2ghpEgKaFUdSQAM8uXokP72X2niF7ZC0tJQbykSmzBExcS622sRV+VlEkXW538DWWRf+d912vXURjzzxYEBZb6M7UgqOEx+r9FGi9PXJ4TiKTR/VRsUivbOzR7MECWj9bp+aXC8/5bxc7XPcetGbZ8zZOU37T82YEC6gU+W8mX1JRJ9KfTnim4Z5HfLpKNuot8w8HgN/GVgUwc9DJvDtp3OcW6IqOiUBdKqrDC5+ZrkUTU9uLPzZyq6dft45bkILNdDkMAocxN0h2ES6Bd0JIUV0/5WpRgyLJbKk5leRtMCBGZPqvRY8vP2dZNIB6UNzwbnbXdWgJnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OnUZDnZjYNll4/WUg+eJPY32TZPU768qj6Wvj2086rI=;
 b=Itr0qbMRF5OvV1MHDd/ueT3/15dKMPAn1J8Q083ORYuc327xBwytP4gm/wPeBJ5qaXANuuQMf/N9mMpVCdT3XUX0ARWlcPyb5Bei9JeEoIAamTrkPOIriF12nFg8E8hC4yea/N9z3GZMSGSSnW8q1k7EED4/GvLihOk2YSaA2yo5ePYRsljblnDBNqJ4IcnUJyc7N2FA/0wFWLx00rWLSXkv1OCvo2sqs0Twdf+1LavAOUKp+7IaqGcQhI90zwQwjwzmBxYTHfqoQO/bzOALcOLxE5+aa9CH7SU0fCC50I4bMKMfD7xhsxcIEM6SidR4zu2Ufsv6aCMDhqkwgTI9TQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com (2603:10a6:10:49a::20)
 by AS8PR08MB9766.eurprd08.prod.outlook.com (2603:10a6:20b:615::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 09:56:54 +0000
Received: from DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc]) by DU2PR08MB10037.eurprd08.prod.outlook.com
 ([fe80::3c7:6d2e:8afe:e4dc%5]) with mapi id 15.20.9870.023; Mon, 4 May 2026
 09:56:54 +0000
Message-ID: <f21e84e4-b20e-4da6-92f6-274a9835c807@iopsys.eu>
Date: Mon, 4 May 2026 12:56:44 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/9] pinctrl: add support of Airoha SoCs
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Tom Rini <trini@konsulko.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Simon Glass <sjg@chromium.org>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Anis Chali <chalianis1@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Sean Anderson <sean.anderson@linux.dev>, Yao Zi <me@ziyao.cc>,
 "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>, Crt Mori
 <cmo@melexis.com>, Richard Genoud <richard.genoud@bootlin.com>,
 u-boot@lists.denx.de, David Lechner <dlechner@baylibre.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Markus Gothe
 <markus.gothe@genexis.eu>, Matheus Sampaio Queiroga
 <srherobrine20@gmail.com>, Benjamin Larsson <benjamin.larsson@genexis.eu>
References: <20260504003421.2545713-1-mikhail.kshevetskiy@iopsys.eu>
 <CAMuHMdVaVHwZahnZvJ6XBiRZnCm8CSpJNZgUksLR3TBYwvqrjw@mail.gmail.com>
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US, ru-RU
In-Reply-To: <CAMuHMdVaVHwZahnZvJ6XBiRZnCm8CSpJNZgUksLR3TBYwvqrjw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: GV3P280CA0053.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:9::21) To DU2PR08MB10037.eurprd08.prod.outlook.com
 (2603:10a6:10:49a::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR08MB10037:EE_|AS8PR08MB9766:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bc1ebff-1597-4c8e-b75b-08dea9c37881
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 21mei1k2uPRPTgH0nLwrNzbnIs+LYVUuDz9jTQV8VwbzBTd/50bDb7UO4UOEOpZJDoW39jiJK6FmV0PzqtSTrjZ4+3nvnmX1QB/5n9CPG8AGxyBUEPSZCTLriqnF8tj4Nwb3H9BEVlu8hR2bIllfxb7CEBgLMG1aAy1D7ZaBssgMJCED35OPKbib5F4gisJKbUINEbQ4g4EDTcfx6569y/+ow005UDX/Jr5w4kb7LVMPunTuDfi0ueuYM3k4+w+fQ1XwxKZm7BpdrIqalYonY//ewOWf/2ohXBU/23EWekwg8+nXcOvFe6mORo4lEv4pLLEYhvWniQ0i8rR1h7uA7M/gaVwzQQn05LltoImwVMVc+1K7AAVj5NTgpiB5cBMyP3mMdClR9GSBpqwm3EOdDWg3cNMmrn7TiWCibDAEBx7uhZl3wNKPQaAjn9qq7NDDBrREYIVqf5JIz+2Ks/zp9BYrUFfZw4k77I5eJFfq1F1rIGfIdf++5EObFOdm1aGXD2cVn/9xf7/Ldz96SeaNakz+AYAdIotbMzrLzaDuEwrlntkz0wCBd36fHPY3FU3o7UVmCxlR9XSBmOIjVgii8uYgT/2zy7+yAsigrLXRQ2SAcmPgYZuC3sViIisKJkkB/H2kbntMCuLE9haKguQUPw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR08MB10037.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VE51YTU3SlNtaTFkaTNobE01UTRicG1HbHg2b1R4ZE1EWU1HYkhmekRDeGdr?=
 =?utf-8?B?cGV0MW1YQ3JTQXp0QldrK3ZGVjJCU0djQlAvQi9NZkk1ZzUvYmtha3BqbVFI?=
 =?utf-8?B?OFZydE1FY0Rxb0NnV0JCUGdzMXBMUGlGL0F6c0MyWnlaNUtpT3lPazZ1UzVr?=
 =?utf-8?B?c2loL0czMm5vbWRIc0c5QXlLQ0RrNFBNK1ZKS1EydjdNWlZDVVEzYXluejJH?=
 =?utf-8?B?b3o4MnNMdXFmdFQxRlBmSXJxSmxtS1U4aUhqa0JqQzA4dXNXYktoVCs3ZmdZ?=
 =?utf-8?B?ZFc5aXE4QnVvVmZlckU4Wm5YbFo3ZDl2a095VWt1OU5ISFdCWGxIMlE0Ynpt?=
 =?utf-8?B?UmJoWmlLclc5OHA4bXE4dTVNN0thZm00bG9EbjNVTGdCL28xNE1wUjF0V21I?=
 =?utf-8?B?Vk5kLzZJbnBIMmFGR3pCbTRPQnJmM01JMGk0aXRpTDE5UHdWbXNnVGVjV2hY?=
 =?utf-8?B?SWd4UWszRTJGR0hNMHdHMDhkTmlQZ1YzdlBFRG44RjFmMERvZHhOcWRwOVFh?=
 =?utf-8?B?WUIyZ2FENS9YSlZQTEo2VlZON2g1WFlnUzFTYko2a3R1WVltMEZIT2pKRTV6?=
 =?utf-8?B?OXN6YmJpY3IxWWRpNHhSN2pOeDhnUUZxcHhYdWw1ZnNGZzk2YlY3VVJ3T2I1?=
 =?utf-8?B?eU9IeXRVYXNEUDlNK002bHhUUHlqQWwwSnVKQVhIL1FEaitkL1hGaG1helhn?=
 =?utf-8?B?clcxcmMweVJod0N1bXpyT2EyUVY3T0tWU0VLZUgwTExkeWIyVmVZNm52eUQ4?=
 =?utf-8?B?TTZCWEtRZWdrY29NK2pmSHYvcDdsQjdWMFovS1R5WHlHcVpvc3Z0eWx3cjhH?=
 =?utf-8?B?OE5zeTFQT2J6bDNpRllOV0VBamZyeFR5bXYrUEtsdEg5U1dEUUtXSWtzc3FF?=
 =?utf-8?B?aTlDNS9zdFJOUWZVOHlzUHQrVGxCZnVWenBJSFZrQyt0S0RITUFKY2Qzb2pi?=
 =?utf-8?B?Y0xYVlVPa3ZqR21KTHIwSVlneTdGaFlrUmZ0Z05ySUtvTSs2Z2c4ZmxnaGR1?=
 =?utf-8?B?Si9qQTFPdTVmNG9YRVkrNWFFREs5YTNZOTQyTi9kM2VTWEtmamFCbkM2ZktI?=
 =?utf-8?B?aXlvOGNEckZUVXVIaGllVnVWNGhJOFA1NTJPdGlRQ0Y1QmJrQ2xCV2xzWjNj?=
 =?utf-8?B?ZzYzeHB2ZkVvYWYrTnpoSWpncmdIQnd1cnVNZWhWTFZES2RKQUxkV0tKM09O?=
 =?utf-8?B?YythV3ZoR1EvTzBmTnEyNkhFK1NCZ2MrWVQ4OXk3czYyWFZsRlVub3BET3M4?=
 =?utf-8?B?b1FDTzRqNkNzenF3MzUvVTVHTTlzaHdZSkxuZHl1UkpkT0wyOG9pbzVLUnIx?=
 =?utf-8?B?NEkweUZTN0lNdWtHZjNZOVRSRzE2QU5ReFJabjR3cTFTbHVGbXhrNGdBekU3?=
 =?utf-8?B?eDIwNkVhVkdmUmYyd0QyTDk0M2xaT0R2NTlLN2RQWDBSUnN4N1RFQWQxbEdC?=
 =?utf-8?B?KzRSMUZuM3V4YTFZV1RwMm00aHRGYjl2SFVEeEdwVmNibDQzOW96dTZ5a1Y5?=
 =?utf-8?B?eXdZODhweW1qdkY3R2Q3U0xqQnB4bnR5TkphZTJyWEo5SW1DWjk0STRPKzV3?=
 =?utf-8?B?WEVpWmg2SE0yVEpLcG9qblYvK21MOXVDRXIvRFJrTEh3L1BiR2J2OVJ5ZDVu?=
 =?utf-8?B?YUdIdUZ5OEcvT2tYTFh4dytIYnZZUjh6d09DdzcwQWNPSzBjMk5reHBndjBh?=
 =?utf-8?B?eXhMa25jWnhIa2loZDJpYXV2L3JrdXB2SVAzaW90eGtEWk9aUmVnS09sNFVD?=
 =?utf-8?B?ZUlWZkRwUFdvSlhCdjVsajBNM25Oa3ZLQVFzK2dJTVNyOGl1K3BHUXBHMnZG?=
 =?utf-8?B?b1ZYTUYrTUw0TFdxMGpWVHRDdTFFQlNYQ3B3aytwQllZU1RNTkFzR1hCR3cw?=
 =?utf-8?B?YXREU3BoNFJ1TUJ6dzdRaTcrVzhWMVlKbGV6U3BUZUQyQ1V5UkpUWDN1ZjBZ?=
 =?utf-8?B?Q3VtY3M1bDg1OUJqK3dKVW9OUHpjbWpCMk16TmZQdEl0dXZFS3FQZ3ZiRFFs?=
 =?utf-8?B?TVl3cll6bE1obllMaVo5eDdTU3RNVEkzc3c4R0Q3eWNkVjFNRDdxd3ljNzdk?=
 =?utf-8?B?eUd3czBYd0tJQnZuUEFRLzRocVIvWFFoZWxNb3JKV0luVHJ3ajhtVW93QW1R?=
 =?utf-8?B?ckoycWVKNnlPdy9ZdXExZklnWDVyR28waHNWbmZ4amtEMGFpOXVEM2RYQ2lM?=
 =?utf-8?B?U0NpazFqcU9YcmV4Qmo2YUt6T3lrYlFWR2liOWxvQWtFcHF2SXQ2UVhndDRY?=
 =?utf-8?B?anJoQWpVaEhQdDdRcytIZFBPQzRVN0F4T1RwUUplazFtOEUyM2xRZDhEVDMw?=
 =?utf-8?B?UXp2eVh6N2R0akNlNDRlOU9McURsQ2hnR1RRcjBWd0RtbngzbGc0LzlOcDU3?=
 =?utf-8?Q?mAfld2np2OqCjRkQ=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bc1ebff-1597-4c8e-b75b-08dea9c37881
X-MS-Exchange-CrossTenant-AuthSource: DU2PR08MB10037.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 09:56:54.1655 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 24L9L7mKzJfaEbb9RR6AlnWpBcN6QBLK0LvQSenzG1E2AxGWbHFdRW4J5KZsSgxPcyHC+XbzYFlSC7at3UXvWV0JIPxrYTJPHWpYGFTi+cY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB9766
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


On 5/4/26 11:03, Geert Uytterhoeven wrote:
> [You don't often get email from geert@linux-m68k.org. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
>
> Hi Mihail,
>
> On Mon, 4 May 2026 at 02:34, Mikhail Kshevetskiy
> <mikhail.kshevetskiy@iopsys.eu> wrote:
>> This patch series add pin controller and gpio driver support for EN7523/
>> AN7581/AN7583 SoCs. The driver based on official linux airoha pinctrl and
>> gpio driver with Matheus Sampaio Queiroga changes.
>>
>> The original Matheus Sampaio Queiroga driver can be taken from the repo:
>>   https://sirherobrine23.com.br/airoha_an7523/kernel/commits/branch/airoha_an7523_pinctrl
>>
>> Additionally in the EN7523 case the patches removes existing gpio dts nodes
>> and replaces them with pinctrl node. It should not be very dangerous, because:
>>  * No official EN7523 gpio support present in U-Boot
>>  * Legacy Linux EN7523 GPIO driver is mostly abandoned
>>  * The same driver is planned for upstream linux/openwrt
>>
>> The patches were tested on EN7523/AN7581/AN7583 boards.
> Thanks for your series!
>
>> Changes v3:
>>  * add non-constant field_{prep,get}() helpers
>> Geert Uytterhoeven (1):
>>   bitfield: Add non-constant field_{prep,get}() helpers
> This is commit c1c6ab80b25c8db1 ("bitfield: Add non-constant
> field_{prep,get}() helpers") in v6.19.  Which tree are you targeting
> with this series?

This is for master branch of U-Boot. It have the same or almost the same
include/linux/bitfield.h file as in linux. Your linux commit fit
perfectly for u-Boot as well. 


>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
