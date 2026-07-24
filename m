Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE036C531D0
	for <u-boot@archiver.kernel.org>; Fri, 24 Jul 2026 03:40:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9238D40A95;
	Fri, 24 Jul 2026 03:40:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9mZkNTINTUcV; Fri, 24 Jul 2026 03:40:06 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0A63A4099B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784864406;
	bh=wl309xMSs/9QhMH4Xt7X2J0LivnmOMXB3DxmpXbvOxo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0W9aPn+JUqXQ9Q5csi9l6fQ+1fIVtUYnOsGLyobwed2hBh5SCMf0RzJUikUO1z84R
	 eokehObNrTYNvbS4DUItPdwv0QR4QZCCOR/ulGZGcsRl7BPaVaMCrHoFdjwnhk6t7Z
	 V9/hDIx9/j2wkKf08jfnqFh0MJvc+O6AoKkonHndPMAZmajRM2RWjSzO5zgFgZusty
	 FEvWfUBPDSza2Yl075KMx5infznqc7U/weki1Z3wKVee2FcSX3DeqyEyzTJwV4DCMM
	 JE2G0ned81rqNq4es6cskFoIZssqxY/hV8UzQ7ylr2xqD7EQdV/oHFxgPSoQHoOTdO
	 zszdrbpl7Gypw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0A63A4099B;
	Fri, 24 Jul 2026 03:40:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 511B22E5
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 03:40:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4336C60B10
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 03:40:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 61SgD-6hDvUU for <u-boot@lists.u-boot-project.org>;
 Fri, 24 Jul 2026 03:40:03 +0000 (UTC)
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::1;
 helo=db3pr0202cu003.outbound.protection.outlook.com;
 envelope-from=alice.guo@oss.nxp.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 94E6160AA9
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 94E6160AA9
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 94E6160AA9
 for <u-boot@lists.u-boot-project.org>; Fri, 24 Jul 2026 03:40:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NA8Xi4cCAr63IQAsOdJsv6+rk5Nee/2Bh3Qc2dQ3jfUBFB/M885SEKP2yiXoB27yibPpF6V6qH1qmjqXj+nLv1SlwuHBX2E07EM+5oeEg8piOI/zIGW0h1fQuLRUZQYhmE+hz2ZrQQsY6XMB0C7BrEFHLWvtgbWZF6yS8QMzh49sntZHVIum+OiNH/clV98M/HJwHK2i+ukqIum0JQUxEaSoQTwDCGRaXoV4PR4EHAcLjFeK7W7Zn+UmM0xrVDoxM/Qs9OntL+8tle4oE5eakUcMx1LOsHQi989PS5XJD+ItqOZcp5WxNAuxbPiBS8uCf5B6c0LedsTpxAjniPNh2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wl309xMSs/9QhMH4Xt7X2J0LivnmOMXB3DxmpXbvOxo=;
 b=XjeLT67AiDXmEZyo8GZQGJd85aP6aUoo+W1U7/4A7dFVxUPsgHZ9L+qpZ0IyZHMI5Um0OgCQwaFht3Scl0u5o4YEijxj9GD0VoEB3whuDaqf779sz/f8Q/Ud4AeSTxxoojlNI+kdTSKg+K2KLI6NGjwNFfNPXaFi40uQmP0k2AtbMLdXCP48oa/7gXq1exC0USJ4IEZi+Y2E+/GDbMVpCE6z/9o9QfWzimab/dN+8T59bYfQ43e/UyC/Zm2nb4bw2C7iT4JgN1k+5yWJIAOdrXre005oE1D6Hs6+LfaX5OFEVSDMeX4amRyOi57vKT8yuPom1eYbytCCr6sBMHkujg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
Received: from AM9PR04MB8114.eurprd04.prod.outlook.com (2603:10a6:20b:3b7::22)
 by DU2PR04MB8645.eurprd04.prod.outlook.com (2603:10a6:10:2dc::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Fri, 24 Jul
 2026 03:39:59 +0000
Received: from AM9PR04MB8114.eurprd04.prod.outlook.com
 ([fe80::cab0:e4b0:6be:b1d1]) by AM9PR04MB8114.eurprd04.prod.outlook.com
 ([fe80::cab0:e4b0:6be:b1d1%4]) with mapi id 15.21.0245.010; Fri, 24 Jul 2026
 03:39:59 +0000
From: alice.guo@oss.nxp.com
Date: Fri, 24 Jul 2026 11:43:23 +0800
Subject: [PATCH v2 1/2] net: fsl_enetc: xpcs_phy: access PMA/PCS via
 MDIO_MMD_VEND2 on i.MX952
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260724-imx952-v1-1-bb060ca157e8@nxp.com>
References: <20260724-imx952-v1-0-bb060ca157e8@nxp.com>
In-Reply-To: <20260724-imx952-v1-0-bb060ca157e8@nxp.com>
To: u-boot@lists.u-boot-project.org
Cc: Jerome Forissier <jerome.forissier@arm.com>, 
 Tom Rini <trini@konsulko.com>, Ye Li <ye.li@nxp.com>, 
 Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: MA5P287CA0199.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1aa::12) To AM9PR04MB8114.eurprd04.prod.outlook.com
 (2603:10a6:20b:3b7::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8114:EE_|DU2PR04MB8645:EE_
X-MS-Office365-Filtering-Correlation-Id: e7075870-1c84-4597-1b89-08dee9353bbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|376014|23010399003|1800799024|366016|6133799003|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: ehV7JOKkkw9Vb/2oktLZXfQy1jUgsG7jgyTxtH6R6RpJRwVe/i59JkUaaBHwT/z6hjTlHJfNu5uhkl2Dj1ZcQ75eoVlPRBOYwpg3RJByZA+o7w4BpHmczh7ntAuD+ZgzBliP7quzoAPeezw1y0CZdJlGttVWdARKeFE6EaoWLszMIVR26qYww5vqYz1l1dYdiDkOf7J3n2jGYT8Y9ts55M70Af0H4GXk7dvrokzxFaIdEwsvDo3yUn9D+th8F+SSigUEoD0e0x9wQLJqkSyEnUk6moDjrmUeqq0kNPDJGY28Q5tMR8jhbqm6OEpWvFwf4r4BQ+Rnu3+8htHgHYpbZ6XwoaheUpCr3nYXRqATIm++BS9IPRKd2akYYeAZ4D4jBASXORHv2DqBhvFn7EExNOvuCKAs1U5Ml8BnVbMgch1eE2YsofiA/DxE+XRzPjak3xbacyZAQ/50NXSxcS0zGMu0/VSIeSDc3RtllmW6nxD6jEZ6TZujqHXnZH0aMubXxvqZe7lwBkZZtvJ/eozOOmFF+DW0Z90mqAY56g7dM7dLGzOFYtN72TbsPLBvCtYio+h+rOVPcbstTwPlJbSqsVWGHAwB2EYt4pmBA0yXfKo9k6TZxfiiygJCCoYXBmTJKWTK0APjTJBwlwiWNLtere9vDCmNsS5G9xoOQ26bOyA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8114.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(376014)(23010399003)(1800799024)(366016)(6133799003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eUdaYVBQdmhDWGJvclBHSTN0cnJzMzhwcVRaaXZ0QnZZUnJ1cmhxcHlySTl5?=
 =?utf-8?B?UVpMenZGbml2L29oVmVrbzZVbXBpcFhHTlZFTTltMGFOaHN1MXFpMnl5OEhl?=
 =?utf-8?B?YUZRY1dqS2xzOWl1bEVpU2Q2NFBjTFdUMFBaRmlQTWcvSlhIRzNvNzVaU2JJ?=
 =?utf-8?B?NHZ2dHY4dVZPMzFydkV0UXdlL1BUZFZQaWNkYUMwSXdLMVVEQmxvZGxlQ21S?=
 =?utf-8?B?SCt6TzdoajN0VkRwZitNMFZSM3FkclBNWktCVUtKOXNRdWpTaC9LWDFUYjdN?=
 =?utf-8?B?VDltcyt5Y0Yzc3ZFSmVPS1pYQ29kQTVRZ2Y0cGxjdGtFakFHL3J5VXV1VS9q?=
 =?utf-8?B?dHdxWko3RHhZbk51THdaRThjWTgrbXRzUVhyM3pIK2hnZDZNaGZrb3hPZnQz?=
 =?utf-8?B?WkFqU0hNRGdwYVcwWlYwS3dwdVdwNjlQMnZTSzFkSWpBWXhZak1hdFNZTkM0?=
 =?utf-8?B?aldXdFl6NWpKVWNiYnpiSWIxOVNMbWI2c1Fjcm1IbFdOams1dnJoL1J6Nm1v?=
 =?utf-8?B?VVlLOXVWZFBoZ3pSS0Y4bHpWcUxHbC8zaGxZUkZCRUZaVWp3ZEU1MVRHT0Ny?=
 =?utf-8?B?enBQTWFneUo4NDIwTHdYUXpZSENvUjJRWTgvRk9XVGN0SDVXREZyTE10NGJQ?=
 =?utf-8?B?WGFDNzJuZlpLaTB2VVdnSVNTODBsOGwwekhmazk5VllTZVRPczdJMGx3Vy9r?=
 =?utf-8?B?UWZNU3F2S2djOWZHOTBYOXVzcHhJVWxOcDdqZmZhYS9uZGk4QmhrQkRJOExB?=
 =?utf-8?B?TnA1RjIrVkZRdzNDTkFRb1FuWUxkeFVXRTR6NE53YmxjbWR0RjNIV0JxRC9y?=
 =?utf-8?B?T2VQNVFLelhWRjBvOVByb2hFbWdpQXE4eElkeHJKTDdWUlYrWXN3VTVkNFAz?=
 =?utf-8?B?d2RGczRHQUcrYUtSc2J6MGM0MmFrTGVyTlVFTnlKY3MrWHJJYWw5RGdoNVdV?=
 =?utf-8?B?dzg3YUFQS1Vlbk1IR1dJYUZDVXFSa3FQQVFqUDVuR1NMS0lXNXErRW14aUM5?=
 =?utf-8?B?Q3lDY1NGNXNDRUNha1FjVTZScXNyRkRIeCtjWUgycEhtR0tkcEJYTG9oMUMv?=
 =?utf-8?B?UGtoZnFwWS9KcG16NlI4b1AyMFBjSHpEUzhDWm5QRmJvMmVXZWtYM1l6aXZD?=
 =?utf-8?B?d0JsVit1d1l4eVIrL3FDUlZTd3o4L0dhREM0amJVSHdBckVrbERYNUhBVFM5?=
 =?utf-8?B?d05KTEdkMlc5Ukd5QVZLTTVYM29lN1cwVHF5ZEhPN0V3U0g5NnNwczdqZzBm?=
 =?utf-8?B?VlpBRXh1cjhwT3FVc1JwTzJHdlpnNGhKaklTaEcvbjR5YUhEd0tVSEVXUFJp?=
 =?utf-8?B?Uy9td3BweUhWVENlRmFwUFlEL0pObnV2SkxDVnNoT2pTM1VLUjBCZktXQ29I?=
 =?utf-8?B?Y28yRmtsc0psRVhVc3lOcjRjdkhuQ0hsQnBwWmlrbEhZNVRPQ3B6WTN5M0ZU?=
 =?utf-8?B?UzR1MVp2SHFWZ3NlYUdIWnh6WEluSUJEWGdsZHkxV1BLN29BS20remJQcTJu?=
 =?utf-8?B?YVJuZW4yRTVBN3F2dU1PWlFyaVFRdnZwUkI1V0JYeXBlb0EveUNzNWg0QnBG?=
 =?utf-8?B?YW9BMTBkV203UlBqanBtYnBKSmZrQjVKUlhkNWtETWNDV3JTSHZHbTNQRmpx?=
 =?utf-8?B?ZE84NlJZeFpQZTZGaTExVmlaQTdNcFZEcXVPMnUzR3kxVldjSWh0d3FJS0lq?=
 =?utf-8?B?dnpMdi9ZMjZ5Ty9Mclp6QnNUWGZML3VpMndqVitIc0huLzdCZGx2NE5NYWZP?=
 =?utf-8?B?dEtWSFZEcHZXUHRBQThQM0VnbzBkRGxhVk1qYUkvUzZyQXNMQlBVVHBwVCtV?=
 =?utf-8?B?OEtFS1RiamlaOCtGZGlqTjFCcEtlWFV6SVh6OGdRa2k3SCtnSm5LOURZeHN6?=
 =?utf-8?B?ekxIVzlvL2FnbUhPUTYwNDFqaXNRMjcwQ0lxQzgrdEprVXdhei9BaXhUenZL?=
 =?utf-8?B?TkJheHd2OWEzSEpoQ0Q1TzBwUFU3SC9XQ0d5eWdyWGlKQUdjNXZEOXNCeHAy?=
 =?utf-8?B?bmRkL2tBTXpVejFNZW1Zb2E5cXd3c1QwWmh2T2ZmVitpbUE2Z2N3Z1p4ZExW?=
 =?utf-8?B?WVphYTg2bXE1dHNDOVg0bUFZbjNaMnhMZ2MwK0RZUkR1Y3FHMGxXTUxjZzlH?=
 =?utf-8?B?Y24xSzRpam04N1FiMzdDS21zc0xleVdQYXNDb1IxOWdzanNJSlNjTGxacVZp?=
 =?utf-8?B?QlBXa2diRGp3TUhTeTJpNWN4Mis5T0UweCt6ZjVxbTlWd2UrcjJBejhBWlZp?=
 =?utf-8?B?dkY1NXlRN0hRV2VkUVd1aUZ3Ymt6SWkzcUh4VjRleU5WQ0dUK01PSzdoWXhO?=
 =?utf-8?B?UzRvN2pLNFZlNXNqK0VpNFZ3bHZITGxMSEo5T0xoMnA2Tmt3MDI2eTRkOFpV?=
 =?utf-8?Q?qFrGe/QvzfekTNO3IU4uIEf+CStuwDJ3uICST?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7075870-1c84-4597-1b89-08dee9353bbb
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8114.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 03:39:59.5841 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 03dnaR/bCS0N5+IUBbQWjETYhLMY929te6+nGHsXXM19h4ionZsnvVUJ+mVWb7TqpeCqz5kEU83TEwjl0WuRrHhGyHxxRIbydMDgU9IUxG8aVNEPgq0xJIXXE4HALK1j
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8645
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wl309xMSs/9QhMH4Xt7X2J0LivnmOMXB3DxmpXbvOxo=;
 b=AI5sUmTBcxhhAjJCp5Z6HQAVkPCfBtT+KqoD4IrEgMyVvugTf+xN+jEGkjY/3cnuTiogSTed0wnS2S2ZcZDlo/6lSJ0WQLeo3hqJHlab9C8ToCpva/f/tGIQb+mcoV4UXh2ruEHqTHnLco4tsIYCH6z+9DWwpo9juX0qz25WLswviYqhCLVNZ3qmUvi6NWZSVGN8+WhaSIH7ZShIMTyRWuY9yBakcoy0fxMrgaNTJXcbfKTkeQScL/+aYBfPHrEngpNveaHpOfHW4Jr4p63jKBUy33R+xVcCd0PmO7gZrWcnjetdMxPDD2p+pN0oORudTMAZGItQiriTtfYVjlJ60w==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=oss.nxp.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=AI5sUmTB
X-Mailman-Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

From: Alice Guo <alice.guo@nxp.com>

On i.MX95 the PMA and PCS registers are reached through the
MDIO_MMD_PMAPMD and MDIO_MMD_PCS. On i.MX952, the same registers are
only accessible through the MDIO_MMD_VEND2.

Add a per-device "without_pcs_pma" flag to struct enetc_priv and use it
to select MDIO_MMD_VEND2 instead of MDIO_MMD_PMAPMD/MDIO_MMD_PCS. The
flag is set on the i.MX952 SGMII configuration path, so all other
platforms keep the previous behaviour.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 drivers/net/fsl_enetc.h          |  1 +
 drivers/net/fsl_enetc_xpcs_phy.c | 16 ++++++++++++----
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/net/fsl_enetc.h b/drivers/net/fsl_enetc.h
index bcab6f252a0..aab69d0168e 100644
--- a/drivers/net/fsl_enetc.h
+++ b/drivers/net/fsl_enetc.h
@@ -193,6 +193,7 @@ struct enetc_priv {
 	int uclass_id;
 	struct mii_dev imdio;
 	struct phy_device *phy;
+	bool without_pcs_pma;
 };
 
 struct enetc_data {
diff --git a/drivers/net/fsl_enetc_xpcs_phy.c b/drivers/net/fsl_enetc_xpcs_phy.c
index e7fed59a0cd..060fe3ffb34 100644
--- a/drivers/net/fsl_enetc_xpcs_phy.c
+++ b/drivers/net/fsl_enetc_xpcs_phy.c
@@ -258,12 +258,18 @@ int xpcs_phy_write(struct udevice *dev, int devaddr, u32 reg, u16 val)
 
 int xpcs_phy_read_pma(struct udevice *dev, u32 reg)
 {
-	return xpcs_read(dev, MDIO_MMD_PMAPMD, XPCS_PHY_REG(reg));
+	struct enetc_priv *priv = dev_get_priv(dev);
+	int mdio_mmd = priv->without_pcs_pma ? MDIO_MMD_VEND2 : MDIO_MMD_PMAPMD;
+
+	return xpcs_read(dev, mdio_mmd, XPCS_PHY_REG(reg));
 }
 
 int xpcs_phy_write_pma(struct udevice *dev, int reg, u16 val)
 {
-	return xpcs_write(dev, MDIO_MMD_PMAPMD, XPCS_PHY_REG(reg), val);
+	struct enetc_priv *priv = dev_get_priv(dev);
+	int mdio_mmd = priv->without_pcs_pma ? MDIO_MMD_VEND2 : MDIO_MMD_PMAPMD;
+
+	return xpcs_write(dev, mdio_mmd, XPCS_PHY_REG(reg), val);
 }
 
 static int xpcs_phy_common_init_seq_1(struct udevice *dev)
@@ -1270,6 +1276,8 @@ static int xpcs_phy_common_init_seq_2(struct udevice *dev, bool an)
 {
 	ulong begin;
 	u16 val;
+	struct enetc_priv *priv = dev_get_priv(dev);
+	int mdio_mmd = priv->without_pcs_pma ? MDIO_MMD_VEND2 : MDIO_MMD_PCS;
 
 	val = xpcs_read(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(MII_CTRL));
 	if (an)
@@ -1278,9 +1286,9 @@ static int xpcs_phy_common_init_seq_2(struct udevice *dev, bool an)
 		val &= ~MII_CTRL_AN_ENABLE;
 	xpcs_write(dev, MDIO_MMD_VEND2, XPCS_PHY_REG(MII_CTRL), val);
 
-	val = xpcs_read(dev, MDIO_MMD_PCS, XPCS_PHY_REG(PCS_DEBUG_CTRL));
+	val = xpcs_read(dev, mdio_mmd, XPCS_PHY_REG(PCS_DEBUG_CTRL));
 	val |= PCS_DEBUG_CTRL_TX_PMBL_CTL;
-	xpcs_write(dev, MDIO_MMD_PCS, XPCS_PHY_REG(PCS_DEBUG_CTRL), val);
+	xpcs_write(dev, mdio_mmd, XPCS_PHY_REG(PCS_DEBUG_CTRL), val);
 
 	val = xpcs_phy_read_pma(dev, PMA_MP_12G_16G_25G_TX_POWER_STATE_CTRL);
 	val = u16_replace_bits(val, 2, PMA_POWER_STATE_CTRL_TX0_PSTATE_MASK);

-- 
2.34.1

