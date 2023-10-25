Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52E91C0032E
	for <u-boot@archiver.kernel.org>; Wed, 25 Oct 2023 18:35:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 24941874A3;
	Wed, 25 Oct 2023 20:35:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="AhhR1r0d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C66DC87A33; Wed, 25 Oct 2023 20:35:26 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on20713.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1b::713])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39CC8874A3
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 20:35:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RNlKgJrzJ6+ADF/RHBVrLfMBzk9MoK0h4Z7Q+HT+VxWa86drVmGntAD6UDOI+hrWXmDoi6Unc/eo2czrT1SnemMtJWRpdASe+SLTO5hh56fdT0EH/vMFssTD+WEBizhiP4xcvb8MOoSqE0o+QGUgCCXUak6gaewJ5XmMeXoKl5ceUPVUybAFeaqMaobR0XSghF6eAoz0FwG1qAKqDbcsPG6BhW+GsHEhqd4+R/6MLm16dVO27pY/+/xTUaTs/KNHvj80jjrIvt+2RW/pvZdy15lvteO+A1RM3AtuEwaiSK5zVwlN0r143xzLWq+AWjRLwcOaMgk2wrPMK5RFXrJbLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AjR8cZGHKq7hHiA6eH7WuFTkYNmTzqbRHt5hfUc3E8A=;
 b=n+DeQwLXAr6KfAzyWjFi3xKHhS5R/OAgzkUE35jFIT7SyWaeAvb4/7pVEjkiIWTePzhi7aNLo36amJG0/raKRqSpNvPfC3o7acmjw3JT1SZ79MmzcxjUm6rK1ZNlncC65ajdgXebNjlOUEJaDe9xxM3RlJ/khL9GtMUxvZOP58+LbEGW/qzHAuuhLU/oCjQjlOBtG10U9VBfSQXjVL7YiNoH0gt4QMNs2uu2B9ME3DAuSo2cbpHQCUcrdmU6HJwDcMMJ7TSCG3yTNo8NDHEp4b9s2j+2nY/Gj6tcjmtOMXpDSe/RjlA5QZaetDGN8SoEOlLPYxLabJGUc/KWZXHleA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AjR8cZGHKq7hHiA6eH7WuFTkYNmTzqbRHt5hfUc3E8A=;
 b=AhhR1r0du82t7IRjh/Eb+xMPmlPJmshuwQD5ur+QsQQ1kBgIzylXfDCKFTeVgLp+Tjllfe56KTHJzobJrcexMQcfBwUtzk3yFZRaSp+2eH3nTBk1CD/Vde2atC+ErJbTcjUrkMCFg6sdnhczIFuG81EJXTSQTEM73bq4Asr9XwI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by PAXPR10MB5759.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:249::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.29; Wed, 25 Oct
 2023 18:35:21 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::52ba:4d74:6ab:aa5]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::52ba:4d74:6ab:aa5%7]) with mapi id 15.20.6907.030; Wed, 25 Oct 2023
 18:35:20 +0000
Message-ID: <3c3ebabe-fd7b-45a4-aefd-13d74b146f30@prevas.dk>
Date: Wed, 25 Oct 2023 20:35:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] imx: spl_imx_romapi: boot loops
Content-Language: en-US, da
To: Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: "festevam@denx.de" <festevam@denx.de>,
 "uboot-imx@nxp.com" <uboot-imx@nxp.com>, "sbabic@denx.de" <sbabic@denx.de>
References: <6de4ef437445c78317e7d8f4f07e47502caed029.camel@toradex.com>
 <cb3e2ea6-b417-4736-9639-b51a04815f7a@prevas.dk>
 <1f86cfc30009f2a04c131ddc06a1d8300dcb1453.camel@toradex.com>
 <e4821c38-ead6-4a51-a442-2c782e638024@prevas.dk>
 <2832e90451ce39c3c7cef34ec5d5c20f02d3a652.camel@toradex.com>
 <4faf5846-9aa8-4396-84fa-8d36c9b4fef9@prevas.dk>
 <2442c84e27ac3271ae17d1e7b272d624cdbf22cf.camel@toradex.com>
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
In-Reply-To: <2442c84e27ac3271ae17d1e7b272d624cdbf22cf.camel@toradex.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0115.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::28) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|PAXPR10MB5759:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ce32038-25fa-4efb-90bf-08dbd5892499
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dnHOVfz0zAKyFf1UKbVfExb/tCoVF9+7UiY3mxUHnYUqU0fh2HScG0EJAyCbb0aj2KXgHlJS6Azr76dh9iNmQtjt+9p7GPb8A5+NbiKK3JjKoHMirqMYMxzZD9FKhcaOiM4jnzDLzTeGXn+tar99yD4Oj/erPJVtCgoeXDrG9tfUO67THBphqDHwYmIP00GLjI2e31j+Vwytvif00ToTniF/biQgKsDOhcoSHRHCljq9eNfKXuEsR+Bj2/oJesRU6ZxsVd7Kg3/jbtiaQgeMbvD67N3A5hcEBwO/s2ooHDikoUgnKYBcwxf1alw6+OaxaOv6aXoS+LxZ/INLmpF9aaDpU2V/dnlNpCZXAUfgJkWSCEEihk3nBs/scFHMeo1QbVufhVKiaKhWAHkglc4M6o7xbOYi1729LZeF9Z1uGxUgOAEkEQ9wVlx287mp8vsA+dOO0hIINTwEtgDVPwSGeEt24gt0UOrO5NIJu2gqRPTwJzlvBqhYWuBBVpfU632vUpgWvBZqSqkNVbjTebvZ6Bl4PyS2XAA0cvSrcGlZFPKYaJJRN0TGjn1C3i9CERlI72ssyW3FZjvbCFUMOx/ckX/e4SG5gF1/+YMoHjcOBoevWUhxgBD52fhWjo7z0i+f13XcDxbjUJKWWca5SLTnrg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(136003)(366004)(396003)(376002)(39850400004)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(4744005)(2906002)(38100700002)(36756003)(66476007)(54906003)(110136005)(2616005)(66556008)(6506007)(478600001)(66946007)(6486002)(6512007)(83380400001)(4326008)(86362001)(44832011)(41300700001)(5660300002)(31696002)(8976002)(8676002)(316002)(8936002)(26005)(31686004)(4001150100001)(43740500002)(45980500001);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aThob2JHWVdRcTdoM3Bzb0ZCaUFCbkJwNXQ2SzNsbWs3NE0vYms2Uk0rNGhy?=
 =?utf-8?B?Z1dtRWc0bXlNV3FrYUl1NG9tUVdGTnBJbFlma09hdUlwQjZ5a3lmLzBlaDBt?=
 =?utf-8?B?Mm5oanozQ1VlV0gxeWFtTUVGS2Y0NkowcW9WTEdKN2tIYnA3M3ZNUDBBQ2J5?=
 =?utf-8?B?ZXRRNzg0K2JKYVFMbDFaWk5Gb3pTbldaNmhvTng1YmZGMUNjV1EzenI2YlRY?=
 =?utf-8?B?SUQxWHEwbmxHOWc3NVUva0RRb293MlVLWnpHQ3l4Rmk1cnY0aWRvblFPamdt?=
 =?utf-8?B?Q3dHRzFpc0lHUlg1NVFXb1ExVGprcGIxU1EwNUNObTBPNUltTHpsRWhtVkhC?=
 =?utf-8?B?TmozRzBKOXY1aWp2TDZqa1FseG12WmY3d1FVdkNZenBidlYya2J2RnVNVVNu?=
 =?utf-8?B?Y2RNYTJVR0xPZmJpdnlnNGJwZHpVOWQ3V1BlSkpYRkJJRnNoSE9Hb2hiU0ha?=
 =?utf-8?B?Qk5NREhhcGJLTnpIZnkvOWRRNDJZM0M1MTVEdGRnTERpY2ZyVFlKeHlFZnZV?=
 =?utf-8?B?VklVQ0ZMbW9aWXowby82aVpXV0FpNm9lWmlBSGxmaE4xYS8zcDVITEJpOHFJ?=
 =?utf-8?B?YmpiMDRWaWlndEdlenB4SnZCanpMdVpVVlRSemFaV2hOWlRQQkpUMmQ5TzhU?=
 =?utf-8?B?cGZPdnp5bW9HaE9wbTBIbzliSUdPcWdhbndYVWIxVmNva0xkb1l1UkwvYkQ0?=
 =?utf-8?B?VHVEUWZhZXRXaEVQUEYxZGtJRXdraVk1ZmZRcmt4WDVLc0lHZTJXcHkxSHJ5?=
 =?utf-8?B?U1NVWVNUaDlHcXNpUDJDbUxtNmdLRTZibzBxZG9JZ0haRHhZRmNRcHpaa0VZ?=
 =?utf-8?B?TlRNZDFHWk1SMjc4UWZyOUs1NUI3S1ZxOVM0QVZqN2xzdjFaMEM1eFphQUJE?=
 =?utf-8?B?eGJIb3Z3ZjgrMmhHQW1ieVp4K1ZJdFMzRnFMK0ZuSGNiREllUVlSdERWYm1W?=
 =?utf-8?B?VVZlZ21SM3FSMFRTU0g0OFZxYjUydDV5KzdHeWxoa0dZYmRkMGhqNER1SWZK?=
 =?utf-8?B?WHEyZ0o3amVEQ1NlL0p0WGdNdVR5RVMyZE83Y3h3RHZUYzNUV3dqOWhUL3ps?=
 =?utf-8?B?N2NzalN4YU1xeG54U0EyTHd6bFJuV1hIejljM1J0WjFJaXN3d2VXL1Q0U2Uv?=
 =?utf-8?B?bTkrVlRFSUltN0UzRzNDczg1SVlvZmtBR0c5UVk4SjJHekFvNkd5MExyMHI0?=
 =?utf-8?B?RFdBNERaYlduNHUvNXdDYW5OTnJsWEJLK2hpcVdPcVhxdDlmYXlLNUFnTElN?=
 =?utf-8?B?WFVxVXNKVUhZUytDRW1wcGIzajE0QVVoRmNIckR0RXNBRnJPYWV3NXRKVVZ1?=
 =?utf-8?B?VW0yTmZkSVRqQU5qWmdDekI4S0JnRkl1T0pVUEVoSHVpekhvVStTaUdHZFUy?=
 =?utf-8?B?SCtOT2E3QWtCYnR3SERQY0pKVWR4OWJIVVVuemFRcWd1WkhtTk1MNDBRWGtD?=
 =?utf-8?B?cVJsNUZYR3ZGczZscjQ3RW9VSkNDbG90Sml4YkpETDBmdWhGZHlmSEIrRXo1?=
 =?utf-8?B?Y1BpalYxYS8wcVl2QkxKTGxPNW1FakczSFFVeXRQN0ZHVnhiamVCMnQ1eGNM?=
 =?utf-8?B?eXdWZzBpSE54VWRMdFJOR0NCUVZSRzExeUEwT0NhbVpNSWlLb24zZzRnUEtP?=
 =?utf-8?B?ZUQyRFkrSUE3dXlYa1RHOUswb0Q0MzdsZFN4VWJVV3FRMFROMEdEWncyMyti?=
 =?utf-8?B?Q2puKzBuUndjMDhhK2hFZzJSYzFGUzRDMk0zSDYxeHVjYkZremVaVUdVMU1E?=
 =?utf-8?B?anJSUkN2RG1ydUlqVnc4VzRVQ0lyN1lqdWJJVjZwcGk3TGowUWVlSWRDSkFq?=
 =?utf-8?B?TWwvSlJLTkVxTmRqa2lLQXZmRGRkWlJmQ094Um5PTmNXampmU2pUZFVmcUxQ?=
 =?utf-8?B?ZnhhQ1FsRHFRRDFDQStkZnR0UjF6UjZrUS9QdUpSeURVcUFYQVYxeGFZaFZ3?=
 =?utf-8?B?eUFvVDlHK1VTN1hDTzE3bjA5QlFkcjVPdzJPV2JVNjRTUVcrbmJYRCsrTk14?=
 =?utf-8?B?MEdWK2NUWTR6V2ZKd1V1SWVobkNNeFcxbStOZE9YMmNEbUhVS3JsSDgrMmxQ?=
 =?utf-8?B?VGROYzBBV3YxRGFPWHB6V2RnSTRrV1V4akFSRXBUbmIwWUlnbUlPOTY4ampi?=
 =?utf-8?B?Q0FVZ1hJak52b0tjSjRlaTZ0ejJSSm1OR2t3YUlCUlgreklsWGo4VnZWRUw4?=
 =?utf-8?B?R2c9PQ==?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ce32038-25fa-4efb-90bf-08dbd5892499
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 18:35:20.6674 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vfFr6pS2HgPo0vU2n/xft3o3elOKZj8LdHxWnf7VQdZpvNL/k9ywZa4Tv4dqUYqWQ39VV2QmV9gXQuMXTX/ygTCxWlMMfyDcjk6GRC9J38Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5759
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

On 25/10/2023 18.01, Marcel Ziswiler wrote:
> Hi Rasmus
> 
> On Tue, 2023-10-24 at 16:32 +0200, Rasmus Villemoes wrote:

>> What am I missing?
> 
> Good question. Some more debugging revealed that we are missing 464 bytes at the beginning of the buffer. Why
> would that be?

[slaps forehead]

		bytes = end - ss->end;
		bytes += ss->pagesize - 1;
		bytes /= ss->pagesize;
		bytes *= ss->pagesize;

		ret = rom_api_download_image(ss->end, 0, bytes);
...
		ss->end = end;

So I figure out how many bytes must at least be fetched to honor the
current read, round that up to the ss->pagesize [which is a no-op in the
usb download case because that has ->pagesize==1, so I even considered
leaving that rounding-up out], fetch that many bytes, but then record
the original upper bound as the new end of the valid data. That can
certainly account for losing something 0 < foo < pagesize number of bytes.

So let's try if changing that last line to

  ss->end += bytes;

works better.

Rasmus

