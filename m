Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4EBCC83F27
	for <u-boot@archiver.kernel.org>; Tue, 22 Jul 2025 09:15:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A74C83340;
	Tue, 22 Jul 2025 11:15:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kontron.de header.i=@kontron.de header.b="kGxhfMN9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 25624837B9; Tue, 22 Jul 2025 11:15:01 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 162FF8329B
 for <u-boot@lists.denx.de>; Tue, 22 Jul 2025 11:14:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=frieder.schrempf@kontron.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TJljGEt5aOVrTNFCoRjeMwIycYxAt44EPh0FuzyiIMd6VGZQRoBjN6u4HhSW53u5dkXBmeXKuCqPI1zTGjBc7cBfc+Y/XWf4i0WKY4+KORzF0TmAXGM78tivphYw+rOgyOeO+17sTmtLzMXufw95XNKBQzt20ED4ZKsKg8bcIam9QxvltFPgSZtimAAsv4Mz2peSRezOJpk2sq/yFO4oYMDyuOhZO9L0jGFwZNIrQEWpUtzubNqPTQX1wtr4H9c4l5yRQOO4UHlJ4tc8VUSDmUVKy66Q1+41QG1oaUk5i1yxGOkhIm+WPOn0JIoh546nAqpARpwF0NtPC/VKalil9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XPYMfjIR4cFgD9a6+4p4hIGGE/6u+3U0ElzGyI+MD2s=;
 b=oQmmuFqKPOnInmlnJXU5tKBJgPS3DW0Jyjc58X0XJUvZDd7ZEVNG4YML/2MqkhuDsCHHFqb4gn7YWUlTSxp5CPj40QQNIgsqQvZW3np10BzUFaUJk9fZN9SUQQpmJRnL4EGpLS8L6fL2x1vAuA43U0AKRYSwVMxEcsTF3j9GnZeAY1BZoe8Nz7BLE0v+Vz+bcA5KhX8mFnjFeNztVwSYlvtc2AMmloMDq5Z2Ue6Cjb9cT6/Z/wgbFQ79sEwEMEWwzptZUGsmWHI8yu4AEP37h+jKlxOWAI3NxV85UJveU1Fptx316on5TeKXMIoDchhW/GQgh6gHLmXNCkBOvlNwmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kontron.de;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XPYMfjIR4cFgD9a6+4p4hIGGE/6u+3U0ElzGyI+MD2s=;
 b=kGxhfMN9CZn9nLRqT88QdB+wVQDhe1dpWLISohfHaovBkzwEobxQWMdG2gj0hocgdHFHE3XI3WlzpPL+JKkTmcfHclzWFzm7bQp/xr/8yJqdk6TteIX96EKEUETXNWsi3Tuw/JLGRUg8JP0RXhbfvLBzpTsvJGTCRAngtnaY69zQRj5VGvsdS6sGS/c5z2SiJLlrLiQnDzQ8wNQyqwPne5LVkN31JITRXgkCS8jsGB24mgV1qnMRtlz7zDVyfXVpuHIG+n2hZ3Mq2WkLYs95Jt3bGMzfQn9r1dJePRariZV0mjPK6UGrGR/Xdt4z1wtcX8hpalzYWw/GlBmypGrmtg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.de;
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:263::10)
 by DUZPR10MB8149.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4dc::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Tue, 22 Jul
 2025 09:14:57 +0000
Received: from PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19]) by PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::b854:7611:1533:2a19%4]) with mapi id 15.20.8943.028; Tue, 22 Jul 2025
 09:14:57 +0000
Message-ID: <2d78d0bd-3e8e-4463-afca-608651fbb153@kontron.de>
Date: Tue, 22 Jul 2025 11:14:55 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] imx6dl-sielaff: Convert to OF_UPSTREAM
To: Quentin Schulz <quentin.schulz@cherry.de>,
 Frieder Schrempf <frieder@fris.de>, u-boot@lists.denx.de,
 Fabio Estevam <festevam@gmail.com>, Stefano Babic <sbabic@nabladev.com>,
 Tom Rini <trini@konsulko.com>
Cc: Andre Przywara <andre.przywara@arm.com>,
 Bernhard Messerklinger <bernhard.messerklinger@br-automation.com>,
 Fabio Estevam <festevam@denx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Michal Simek <michal.simek@amd.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, Peng Fan
 <peng.fan@nxp.com>, Peter Robinson <pbrobinson@gmail.com>,
 Prasad Kummari <prasad.kummari@amd.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
References: <20250721125148.167020-1-frieder@fris.de>
 <20a08d1b-2b68-451b-b7e3-6e6f2bed7601@cherry.de>
 <cf5d5a08-9ed5-4500-9e1d-b36224d3ed75@kontron.de>
 <4ed7baf3-861c-4d39-aebc-5c4f7d7e2bcb@cherry.de>
Content-Language: en-US, de-DE
From: Frieder Schrempf <frieder.schrempf@kontron.de>
In-Reply-To: <4ed7baf3-861c-4d39-aebc-5c4f7d7e2bcb@cherry.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0170.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::19) To PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:263::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR10MB5681:EE_|DUZPR10MB8149:EE_
X-MS-Office365-Filtering-Correlation-Id: a0f9d72b-0b9c-4969-98eb-08ddc9003a15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?T3lTK1BKWWxDZWJmN3UrTCtTcXJUdkQwV0taQkNXYkJ4Z3hmNEFXbHNIWHZG?=
 =?utf-8?B?ZEdJYUxaVFAwME5zWkNMVXVXbVg2SWx3dHF3OFFWdE11YS9qZXBSU2IrRGJK?=
 =?utf-8?B?VVppdUZGY1Brby8vcGtxd2E1QmdLdENFZTJpcmlwdG5LQkFDY2xmUkJQZUIv?=
 =?utf-8?B?YkJzUmVoTGxmYmNWQWQzbGxlblg0L0dCMWJycUFSNlhhdmZ6TENmZUtFZGNT?=
 =?utf-8?B?L0xDK0psVWF4Sisyb3NkdzJ2RmlzZVMwUmJvSTVQbzlkOHg3MTd1S3ZvWWxD?=
 =?utf-8?B?OVl0QVo1TDN5UnlicDNCY3JwMWdmMExXWmZ0c0tlOGluRVQzT3JMTnI4Lzhn?=
 =?utf-8?B?V1VPbGgydVpQL1FObDQzZWg1ay85YzN1Sk9VUTc1dmp2RnZCSVZSSVpJa3JF?=
 =?utf-8?B?c0puVFBOb2VlZ0lWaGxQNjlXaW9xbFdUSEdhclJKSG9sL3Vob0hWN3dITlFC?=
 =?utf-8?B?VkxMNlU2RGt5UDBIMDJGcW10WWRaZ0xQUWFwVitzdnBaYThpRWxSelBHS0RX?=
 =?utf-8?B?aU95aVlhR1djMTlsTzNQQWtkb1Vjd05VeThLRldqOFNYdW1tcHhYMDEvd1Bm?=
 =?utf-8?B?ZmZMNmlZV1NvK3lSM3g2MlgwcXR6N0pMcXFwZXZyaFoyR01tQTl4R1JpNVNG?=
 =?utf-8?B?a29IM3hrazFEdkhjM2lzQ1AwVkRMWTRrZmhOenVGQStndm83a213VVROT3RC?=
 =?utf-8?B?RTBwYVlDcGcrZzUwcFZrcU43R1VzV3h0cGhsMjQ3Ym10VkViNVNvbm5UZlhn?=
 =?utf-8?B?cGJsRVJSWlBCVlhNTnAvVUtobytwZzk4dzJWZG9XcG5DR2t6Nis1clJoRjVO?=
 =?utf-8?B?MWkydGJVdmFlYS9aUGZIaktjVCtteUNlRGdEQ2lPYmJOakc4SkxJS2NXOHFW?=
 =?utf-8?B?WXNQL2NoY1Y5bkRUbVdzRkNkdDdCUi95Z1lRL3ByQXo5ejNlNWNxZFBTVUJK?=
 =?utf-8?B?ZWE3MG8zaTlDSFhXdGJuK043Snd3RkNxLzk0RnBCbmFxaWFUZU9wWFp3Ump3?=
 =?utf-8?B?amI3ZlM4L05Cc3dLakRKZGJDeE5yUFVMTHkrL25lRm82enRwbGtBcnQybzVY?=
 =?utf-8?B?OGE3eWZHS3ora1ZjaVBOSld5RXFFUWxZTmR6clg1UFBPSUhSZ3V0eGdzQzNl?=
 =?utf-8?B?MGJsTE9jVDdBVDd3ZkFGY2gydUdqVVluVmdJTGFkaytUbWNuc0k0QjhNQlFZ?=
 =?utf-8?B?YTN0akZCNXdHcnZiNzVqZC9OZ29HdGJlNGl6YzI1Nm9jNnoySmtyNTg2a1Vs?=
 =?utf-8?B?VWI5VkxJWWRzRWdJYXZsRjY1VlErQnI1ZEl2MENlNmd6ZXg4KzRuWmh4cndD?=
 =?utf-8?B?ODVvbVJLMXUrcENtckdONU93QlFyVEx0Q21CWExoV2lmZmpLUXVwRWFmcVhQ?=
 =?utf-8?B?bUF0RUIxV1FDQjR0TmxsSUxxQjR6enFaL1RPaDY0dVQwMjAvRHdNMU9pZ0Fr?=
 =?utf-8?B?SW9LQmFFdlNrQjVMWmMzbUtJWW5uaFUzc2FLQzYzeWVDbmdzNVNsYlpJd1J1?=
 =?utf-8?B?UFJ4U2RSR2h5QSsyVWVZT2NKTzBjRjJ0YTJ2LzE0bmp6emZMK1NOZ21TMTNh?=
 =?utf-8?B?VS9xSFg1OW8rZkpkZVUvR2lzT2lSUlFuc3l5V0pkWktQbUkxOWJOblRhWW1x?=
 =?utf-8?B?UmZQcXBJOUZjK0tGbmRXeDZod1AvOE80Qlo0cE5vVGVvMzRWeXdwdFlHZ1NJ?=
 =?utf-8?B?K3hZQ1F3dFZLcDNjYmdWYkdUaG85MzEwQjlhWDF4MGtrbExGZ2Z4bEpiTnhp?=
 =?utf-8?B?NGtRc3d5ZjZZU3U0bTZHWlMxQVBzc0grc3NXRkhBVDJMeUdMQm5odVo0aUk1?=
 =?utf-8?B?WjUrRmVrYjdoRGI2aEZTNDI3UEEvOEdFdk43Tmt5WW5QaVFuVGtOMy9VTFF2?=
 =?utf-8?B?aG9wWnR5a1Zkd3YzUXdnUXdhZTJlZmFMUE5YNzBTRHF6N012cktRZngyRnQ1?=
 =?utf-8?Q?IuzMg9uj69k=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(366016); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N0YzTFcxUkl6K3VRVGk0WWk1dnBKSjlzY1kyWHliV296OFpjMmJHWEF6TkIz?=
 =?utf-8?B?ckVXK1JrbVJiQ3VMVDNGcFNRWkluSFdaSi8vSmR4NXdDN09vamVDYkJvR0NW?=
 =?utf-8?B?UWV1NDlGem5kaVJDOGVMY0gvejBoOUgrRktCd2RKRkM3MFpmamthNU40VUVL?=
 =?utf-8?B?QlNmRkR4RTJYWjk2RG1rUDVPbUk1YlF3V0hYMjJCR3prMkoyWVI1YmVDVzVL?=
 =?utf-8?B?WG1ucXViUkMvZ01WaHlmdXZQaEMwRmJsSkhmWi9aZHdINzYwT2tvQWZuYzlq?=
 =?utf-8?B?YS9Vc0JIVm9yS2xxUVFPdzFCRi9IOUlzaFdSd2ZCVUE5YUFkZXdTZ2VYcUQ5?=
 =?utf-8?B?cms5dFRnQlpkR1pJWC9pSjRsRE84NVowUGZrL0hJb3F2RnFwTWxEMDl2TUhQ?=
 =?utf-8?B?WTJGQy9LQ3lVU3lvbnhHOGhCYW5oWndrdXJXNUpBOEdtb3AzQ1dXckdxb0JB?=
 =?utf-8?B?Qko5clNKSXNUQXAyRGFQVjM2TlprZGtPMUJVOTRVWGsvbTdqVHdwdTJtRzB3?=
 =?utf-8?B?di9tbm5KL2xzZW9SWDlialkvdWRjQ0ZKM3EzVThBcDdrc3ljb2pBWmVid01s?=
 =?utf-8?B?d2l0Q3R5MnJXUmNURzlKdzJ0TGJRR1RWZGR0RWJDakNyYVRicEVza3RKTHJZ?=
 =?utf-8?B?ZnAvQkthRHFEUkc3VUx4Y1hoam04NVlrSC84d21iOVY4dnlqN0dZR2JrQ1Bk?=
 =?utf-8?B?U0pRRVNranpwck9GQzVQUFQ2WHJPMkNBTlJIUWVGb0x3QzNtTUZ3R2lJQ2RQ?=
 =?utf-8?B?c0tzNDZmYjhKb3liUk9qNjF2TXZwcUFOZ0VzalR4TG13Wm5GZUY3aTJ6WlQz?=
 =?utf-8?B?NVpuQ1hodERyVjg3Ymc3K0gxbU1nOGE3dUJaM0dzZHF0UmNBNG9ydFZTUUpo?=
 =?utf-8?B?bDZpM1ozWXZJd2RPQjE4V2UrYmdVeVpjTndSK09TVjUwcTNwZzYzZ3ZaVjdF?=
 =?utf-8?B?S0I1cDZ6M1REZWJZcFZpOXFGYVA4Y1hERkJnNDhjTVNQWVNQU3VFZ0RPSXV3?=
 =?utf-8?B?Qnc2YVllL3grdGMzUGQ3QzVzbG9iaTMxVUJSQXhhemZobUF6Z3JXRDZMTGw4?=
 =?utf-8?B?bVA3Wk9nY0hDWDZTdHJrU3UxTmVkcmlRUHI1ZGN2eWVUVEJXcENFemFFZDlq?=
 =?utf-8?B?cVVSbmZ4Z3BNVlArZUtVSXhoU2ZlMjZGTEhabzVZNUFDSlNnZG00ODhWTzZE?=
 =?utf-8?B?cXAwc3FQMjdmck9EZnB5MlVQUkZsUkpjNEkzUEU3NlI5MDdlYXRKSHFxYVMx?=
 =?utf-8?B?eUVLR29ja2RkaU0zREpjblZCYnNCVDd1d1hUc1ZlUys0VHhpQzk0Ykk3UFU2?=
 =?utf-8?B?Zm56N0pMY0FQT3M0TGdXZG5VRWdpUXd4Z1NhMVcrQlJFRWtGZXI1UklYc2kz?=
 =?utf-8?B?RzhlV2dTUS9hWmFmbzB4MHhzM1dVcGQ5OTV1R0lHN3FGcXNUQmJMcDRHejc4?=
 =?utf-8?B?RC9DZFNDMGVDcGZ3ejRUeHRJMGh1RUtyeC9aTGlsU3pBQThvMzFqUFNkMkwx?=
 =?utf-8?B?NElVUUdFWVlQbWxXY2VrYTZOQXU1cmozUVVvc2Jzcjl1MWVpeTlmaFAyckcz?=
 =?utf-8?B?S3pCbXF4NVFWTXQzc09tZHlLWlNKL2pQRmJkY1FlYW5MNTd2T203N3VzT0xn?=
 =?utf-8?B?RzNlMUxUbk1PNGlaajhBbStEc1F5NU1IQllxa212MzVNcXdlMG1VcG5LQ3Zj?=
 =?utf-8?B?bU81a2pJT250U3BFQXBVM3NrMGNJUHJVWUFqc3dYMWZ3YlFNRHVVRW5uRGxP?=
 =?utf-8?B?K3pVVzc0LzZidWhUTXo5SS9zd1RBK1hHRFFCUGRITGZIdjRYeEYzK3lxbzRR?=
 =?utf-8?B?TGhwdXc5R0FkaDhiM3E4SUl4bXpEOGFFRTR2cWU3UUZ3c2twVHdkZnRVNm4v?=
 =?utf-8?B?WFRnMjlKSW5YZFlYcHlzUCtrUWgyVllsZFIwOWlRdURiOWc3bCt5RXdoMTV4?=
 =?utf-8?B?aHMxM3FjUjlXN0lkQ1ZDa2ZOeEhrcEtTUEwxcjB3WFpPMDZrWHcvTzdpaWZK?=
 =?utf-8?B?NjB3S3Zockx1RitWL1o4b0dpQmIzVUtIL1ZPMDNhUWJwOTNySVMyY1k1N1dN?=
 =?utf-8?B?WlAxaytLYkhWaGRTUllQaGR6WGRYZEcrY3ZTMUs4enYrWTJlM0NxZFBIVFhz?=
 =?utf-8?B?ZW9ZU2ZuaGRtM1hVTWNvZVEvRllJOU8zb3UwMWFrTVNKY3E5OFZGeDdCaERX?=
 =?utf-8?B?b2c9PQ==?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: a0f9d72b-0b9c-4969-98eb-08ddc9003a15
X-MS-Exchange-CrossTenant-AuthSource: PA4PR10MB5681.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 09:14:56.9998 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l2/eIv0WSVE5g/+lSShP5YHd3p7aTwMUCK/+zKK83KOFQ/QZ/veB+idcAtSHKcJILQqsIKlERDcY/sYwbVfg9b9H7O1EgFToZPmy96DYhTU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR10MB8149
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

Am 21.07.25 um 15:27 schrieb Quentin Schulz:
> Hi Frieder,
> 
> On 7/21/25 3:08 PM, Frieder Schrempf wrote:
>> Hi Quentin,
>>
>> Am 21.07.25 um 15:01 schrieb Quentin Schulz:
>>> Hi Frieder,
>>>
>>> On 7/21/25 2:51 PM, Frieder Schrempf wrote:
> [...]
>>>> diff --git a/arch/arm/mach-imx/mx6/Kconfig b/arch/arm/mach-imx/mx6/
>>>> Kconfig
>>>> index 465e258f8e4..0798eac68f5 100644
>>>> --- a/arch/arm/mach-imx/mx6/Kconfig
>>>> +++ b/arch/arm/mach-imx/mx6/Kconfig
>>>> @@ -366,6 +366,7 @@ config TARGET_MX6S_SIELAFF
>>>>           select DM_THERMAL
>>>>           select SUPPORT_SPL
>>>>           imply CMD_DM
>>>> +       imply OF_UPSTREAM
>>>
>>> Why "imply" only here? It won't build without OF_UPSTREAM anymore no?
>>> Shouldn't it be "select" instead?
>>
>> Good question. I wasn't sure about this, either. But "imply OF_UPSTREAM"
>> is used basically everywhere in the tree whereas "select OF_UPSTREAM" is
>> only used twice. That's why I assumed there must be some good reason to
>> use imply. Maybe that assumption was wrong, but I still wonder why
>> everyone uses this. If someone can explain, that would be appreciated.
>>
> 
> I can explain for the Rockchip architecture :)
> 
> We have "imply OF_UPSTREAM" at the *SoC* level so that if someone
> somehow wants to be able to have their board to NOT use an FDT from dts/
> upstream, it is possible (though we wouldn't accept such a patch, so
> this is likely only to be nice with forks or also inherited from partial
> migration of U-Boot FDTs to upstream's (e.g. there is px30-firefly which
> doesn't have an upstream Device Tree, so we cannot move CONFIG_PX30 to
> select OF_UPSTREAM as there are still boards which aren't supported)).
> Finally, we actually make use of this ability to not use upstream DT for
> generic Rockchip platforms. While I don't use this, it seems like it is
> appreciated? We cannot upstream those as they do not represent any real
> HW but it works good enough for boards following closely the reference
> design from Rockchip (which is most boards for typical things used by U-
> Boot to boot Linux like eMMC/SD/SPI).
> 
> For Kconfig symbols only tackling a finite number of boards which are
> all supported by OF_UPSTREAM, it would make more sense to have "select"
> there? We also have "generic" Device Trees for Rockchip boards that we
> cannot upstream to the Linux kernel (as they don't match any actual HW)
> so we need

Thanks for elaborating!

That makes a lot of sense. And for this case where we have a single
board and nothing that will ever be derived from this, "select
OF_UPSTREAM" or moving it to the defconfig is probably more suitable.

> 
> And now to come to think of it, I believe most/all the options in
> TARGET_MX6S_SIELAFF should be in the defconfig instead of under the
> Kconfig symbol? Not sure if there's a tree-wide consensus on what to do
> here, or if it's up to the architecture's maintainer or board maintainer
> to decide. I know the additions I made to the Kconfig in board/
> theobroma-systems/ weren't much liked at the time (but ultimately still
> merged), and this seems similar, so not sure?.

I'm not sure, either. But as this affects the i.MX boards in general I
would rather like to leave that decision to a maintainer and do cleanups
later once there is a consensus.

I think I will send a v2 with CONFIG_OF_UPSTREAM in the defconfig and
leave the KConfig untouched for now.

