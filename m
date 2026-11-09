Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1085606A321
	for <u-boot@archiver.kernel.org>; Mon,  9 Nov 2026 06:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=qcPEV80U;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=liI+Ps3S
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 27556606A0;
	Mon,  9 Nov 2026 06:36:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V-moGOSvb_ZM; Mon,  9 Nov 2026 06:36:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 1F42360621
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794206193;
	b=dLLRD1Cs9fcFmV4Vfru07TKG3UusHwwjS3RUlLqTbDp90BwaqDwW/uBJv0o7SZWLtQZv
	 t6ePhNhmDlr643IV4d4/sNhkwSmEWgPOLuk3dCmtCVbO+LaCu2rfjH2UbZHuOUp1NDS5B
	 Jv5H2N9F0r5eD+7nOAMe0KHrbZS72ae70bL2k4XLR8usguFtv1TCvDXfJ52P012/2dAvV
	 //1Wta+BNaYwB1vO5uvNxTlgxyQCm+wQZKP726uIAueho3GON9UoNGgdZZFdFB8EsidxF
	 VBcI6zfZaTTQFvFCEBXBK0CeUanaRaGrfPhGBf7phsQj9gjyMyniEKnQsXTmzNYjc2w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794206193;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:Content-Type:Content-Disposition:In-Reply-To:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=+gKVEREIo0bGS7rmSf3rRL84UqPOaoqS01+wuT+XHVI=;
	b=QkFbdQ8k62812YdjPW1Ut3vfKoO+3O/mgWE8aSiHK+qSVxUD2wKPMoN91E3to/kcTB1/
	 rxzB1LNiy1rm4FGaD9w9oN9XDIFn79gSEBYp0MwfyiM4VK2DMsgMQ2m0XLxLIUEKXtRlq
	 LjMd+cSwbySUNBD/VNf8HDCV46q4qkGraFl6yg6+Lv8zHLtogBXCjhQBDv89bCS3DoBrD
	 5Bo4j39oYmQBWFn/d8I1OcpYZ+If6PHoFEkCdZg6y/tlBV0P12b79qol0TSUn28AOOF1Z
	 SR2376rMgHrliW9Nas5rq8L3kWOr27/u/+VPNMP1+tm77KQlqSg/Mr05f+hO1V3xgfQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794206193;
	bh=+gKVEREIo0bGS7rmSf3rRL84UqPOaoqS01+wuT+XHVI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qcPEV80UepTvfkQyerYUR30oafbzrTneiXvuexAQVjGLcGHE5CsBQcZvMZN9xF/ZH
	 MpwyekWpemPYZEvclOPBDG1k7l6xH0uU2LvrUmHuEof2dOPw+dPiL2pwIxY2C5h0r/
	 ltHHGKpQGAS8kYWB/lTijx3j70kcxfXxNyQDdgdbErxSoefSZK7ue87281pMav67K0
	 RA8lTZUPgLtGxoWfoqy+GMV2V8g2rQyF0DbX9VHaYRWxfc0F8IlFWsQpOJUInyJv9h
	 8UFxsTubLbcocoHzi4BRyGP50+VhRHXZG8HqgG4BfyjukPxPvSMrE/HSWmI/xvJG7d
	 bqb5Mi0Xk0LMw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1F42360621;
	Mon,  9 Nov 2026 06:36:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id B49D02AC
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 06:36:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9A71340111
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 06:36:31 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 9Zhyfsk5TxYf for <u-boot@lists.u-boot-project.org>;
 Mon,  9 Nov 2026 06:36:30 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 8F046400AA
Authentication-Results: smtp2.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a01:111:f403:c200::1"
Received-SPF: Permerror (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c200::1;
 helo=db3pr0202cu003.outbound.protection.outlook.com;
 envelope-from=peng.fan@oss.nxp.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=fail (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com
 header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=liI+Ps3S
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8F046400AA
 for <u-boot@lists.u-boot-project.org>; Mon,  9 Nov 2026 06:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+gKVEREIo0bGS7rmSf3rRL84UqPOaoqS01+wuT+XHVI=;
 b=liI+Ps3SsQ2LPgyqnRfHX/8TrNN52kKt+aRDNd/ezxkxsNrn4ozsm8VEbq0tAHoe9GjhZPsQbH8u5x7Cch3i2RLbH6n2JuKnZnubHGlOzqZnzBsvXtxN313YX+FKBhaY8LTj8CT8UroHvUKJV7uxMIzFUU7jxEs3z5Dqg/1qGIVGQAZR3cUOxtHhTJDw7EVgefbwnIAZ+jdzuE+/cTAvuenEjIYQLQtIvX9cKYi2RY67bokXsPJqHHEPVwJWNPVDgi2NF4w4e5vcW2I9uHpXsspYZ796s0t4eS/zOV9neD5tin417BUHMV5mR4x3sS4UNgkOdUknXkDtOq4bJ5PuXQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com (2603:10a6:20b:24d::9)
 by DBBPR04MB7849.eurprd04.prod.outlook.com (2603:10a6:10:1eb::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Mon, 9 Nov
 2026 06:36:25 +0000
Received: from AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9]) by AM8PR04MB7874.eurprd04.prod.outlook.com
 ([fe80::ac38:1699:6f18:c5d9%6]) with mapi id 15.21.0592.012; Mon, 9 Nov 2026
 06:36:25 +0000
Date: Mon, 9 Nov 2026 14:32:55 +0800
From: Peng Fan <peng.fan@oss.nxp.com>
To: Yixun Lan <dlan@kernel.org>
Cc: Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Tom Rini <trini@konsulko.com>, Eric Chung <eric.chung@riscstar.com>,
 u-boot@lists.u-boot-project.org, u-boot-spacemit@groups.io,
 Dave Klotz <DaveWK225@protonmail.com>,
 Zixian Zeng <sycamoremoon376@gmail.com>,
 Hung-Chun Tseng <alan.tseng.cs@gmail.com>,
 Anand Moon <linux.amoon@gmail.com>, Raymond Mao <raymond.mao@riscstar.com>,
 Huan Zhou <pericycle.cc@gmail.com>,
 Guodong Xu <guodong@riscstar.com>, Leo Liang <leo.liang@sifive.com>,
 Tim Ouyang <tim609@andestech.com>, Yao Zi <me@ziyao.cc>
Subject: Re: [PATCH v3 0/4] mmc: k1: multi-block SD reads in SPL and a probe
 failure fix
Message-ID: <avFpF-5tuHYkOOcO@nxa18884-linux-1.ap.freescale.net>
References: <20261031215452.16013-1-tanmay.kathpalia@altera.com>
 <20261105222737-GKB249737@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261105222737-GKB249737@kernel.org>
X-ClientProxiedBy: SI2PR02CA0044.apcprd02.prod.outlook.com
 (2603:1096:4:196::17) To AM8PR04MB7874.eurprd04.prod.outlook.com
 (2603:10a6:20b:24d::9)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7874:EE_|DBBPR04MB7849:EE_
X-MS-Office365-Filtering-Correlation-Id: fd85b321-b5ef-4089-a7d2-08df3e2bc700
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|23010399003|19092799006|260925022911599003|260925021311599003|10067099003|11063799006|4143699003|56012099006|261021121427099003|261022105027099003|261009223027099003|261026140227099003|261028144727099003|261026121527099003|261102123227099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: QayuiYkucrHYiQxy1gemz+/ra8Sq7MQt1xWmftDXkvCcKAolroxZ1vKJ072Ltp18XCapTJFIBuLFa89EE3wOlkM/g06d/6+Pji/20gucRe50HhCvJ9SK4YwTbbwlmpdgZVyGwrIIM6Bx6TeUeTeMQ/numT1akoQV4h++1lXt6kJYUmM+CtHLnUSBNm447O1Ar/FsDjJvLXl5AE0SaMRF1p/ibKYr/n+5UM4brLOt8V3R5+EcKEXaa3XB5z9JSEOe+IHzT2QjHQTZgUCRUHtHKyoeuY1v5VXur5qUvovdG/cKWEEzF8MpMjAtY/OFwmZWHm1oUtA4UjkNOU0GkN/uBjCbz+r/gSLX4acJpVIQGnc6RPph2W/ME6DSfRf+j1z64ykr4c0Cloe7S1WKeVq+qO+MvxwhpVXaWubYqAN4dgVg8QGleyOcDSFZ2GiS1qC3WYrj7iV1wof9BlJYWJ0FTi7x2I93UXqLAyBxD35mf8FuuWc1Wu6GQudk0+/aseMzkP6lu27zarvgAo3oGasCD4xMJyd1vJKRO7O9F676HPkjIOZhqC8MGVLGmMwVJNCqwJpXMg/90A10jHdA1pC8ab6iJfap0cnWKKy0JddHXQk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM8PR04MB7874.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(23010399003)(19092799006)(260925022911599003)(260925021311599003)(10067099003)(11063799006)(4143699003)(56012099006)(261021121427099003)(261022105027099003)(261009223027099003)(261026140227099003)(261028144727099003)(261026121527099003)(261102123227099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ox7mUwIKdYBro5i505ppi29zO+hXE+wDNIW+zbeBArz4ssNFhOu9wBKDGsO1?=
 =?us-ascii?Q?RqOxaG9JJP9HwL/slTYNxEwJ4L0+btJPmecEjYTzO204ijFWK98WB6x3VC8F?=
 =?us-ascii?Q?OMckUNI3phTByLr4X7RK0FcMADi6oJfRyVdk9rJrCqn4ArCSKQzHJRZLaYmK?=
 =?us-ascii?Q?zsR2efL2xyWxlcHoYSb7WQ3x2oiaurBMrd3nqVv6EyQKos8LoKthZ6x8UmBX?=
 =?us-ascii?Q?QS+Z3Th2ShyGn4qWTfcDxgHjNNnu2rmoYdVPFEWGu9COzQSzFmEVSvn2XvC5?=
 =?us-ascii?Q?DBB3gcLR1ydtRO2JPH2f9t70zhE+IAzu9vJYmQhnzIBMPggLlcJNRDifM9Jk?=
 =?us-ascii?Q?JSMytoXuib+ri912yCOf5MUjUekRowJoMAZJNMt6nBJ3RZqcjEY1qJ0TrMRs?=
 =?us-ascii?Q?DSNh6NHDsl1lgzlP8h5ucNT80LDKrXvmGvf6qi1zIqc7oLSIm46CDFrqnNBy?=
 =?us-ascii?Q?bIv2q5yoQAE68QVv0dkb8MWYKXXjF8jKgRfZSZlqBdMJRAdTFf9bsigTIQGd?=
 =?us-ascii?Q?/sgbUJp/dGu1bAUYDI4Mb7c/518u7d3i1uUrxUNuaDt7Wjt0e+V0uFfjU6nG?=
 =?us-ascii?Q?o2Gk9O7xwzDk8RU0GAYKVT0XiGAoLLZbYwZL/1sOBvukZ+ayMQxir/VHPFLr?=
 =?us-ascii?Q?hfWZkqWQ74ilhKqZpPPYKGTIYKm/2TmJffxO0h5sIfqI8mcKxJTTinkHljs7?=
 =?us-ascii?Q?UIO5ew1hk3agXQxeJ2nHi+i/ovKYA7R2bMIKGZv/PUNgVtIvQtA5dx/SKiOv?=
 =?us-ascii?Q?oJ7Tun9SZTD1qfavBDpmbAHYG2TXRpkyd9KqI5RPhgJUDO/01d1/3M1UuwzM?=
 =?us-ascii?Q?T0trLYe0zo8kdzSPenVfkVkqMOfX7TIlvzhB1B+iJofqkRNwH8G3Ds7hcOtH?=
 =?us-ascii?Q?hNI9d6ng2B7kJXJxalCmjsQk+ozBy4xEoq18ktRPDVscM/WKty1EbREOw6zR?=
 =?us-ascii?Q?VlF4eHZNxpBgEK6u68ZRGEDHyVDCUK+fN1IPYUKMDPD46+lgqcCEgzLNcu2C?=
 =?us-ascii?Q?/OlNZDPdikEWbQ8im8JH02rJ9wK3C0yQAzQJ5LNe8OSt48oHU7HloR8HAaQ8?=
 =?us-ascii?Q?DCj5f5kSo0IgAoxUloY58t3GZphEWEj2SZkGdHWewci1LRb9rKs3Rs6U0UfE?=
 =?us-ascii?Q?7cz03sRg7Mrh30wOkg3gUiIHFwh/xETP9d35bp54boVWWVHZy+umkdglaXoY?=
 =?us-ascii?Q?oRRg/KWuDlxs7MdKzrLuayOIDjUN/7G0n5pnqDSnebKJaBDdQJDpFGbHfgoB?=
 =?us-ascii?Q?55v54as67+lgr57H55H9Xfi2oGQpMlaQ/2lsHPK5CAdZBzrgo0Zkjgbgksfy?=
 =?us-ascii?Q?21pZqrmkdcJv6aBuuPEeveLNeNslOVpONyANTtxiUMvwnHX4qi9fhj6tBSdT?=
 =?us-ascii?Q?L3UDpKvpkKXWrBJQp9wwLx+0aquPJ9zy6oMnIfh89kfQXKA5KfTL8zhjEcxb?=
 =?us-ascii?Q?fQvmWyEsWE7JsaUNfwAlUsQ0pZk8wczFCxTzxWCOWMvdrZ/7HwXGYTaOL4Xs?=
 =?us-ascii?Q?YXIcQREsuySbzgCfjp/BhZKvoeYLfwVhR8hn69yCFZC4XC9D8lzfxhYJSCSs?=
 =?us-ascii?Q?+sJJrnLel3h0OzQslMLLAYEWCm6TvGGV+Lh6LL9fJyJmEKThsvhHgQRNUeXn?=
 =?us-ascii?Q?bDp4RUlw2y1/lTvl60GDdbIUUHgiadeLuz2uNSFUDD2MFZDHgoPJw+asxPZw?=
 =?us-ascii?Q?QfdP0SKjk9yMrSgsaPAyh93iWNXirekfEbkFmB4qPJY0XHAfymHEtVu1qnXj?=
 =?us-ascii?Q?qC1hdoV19FvP1SCW5nGJRWjy43ogE5mYuXOm7OME38N6fGmZdg/r?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd85b321-b5ef-4089-a7d2-08df3e2bc700
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7874.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 06:36:25.8154 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dTOKGLHFpPo9mfzziy2kP84XCqy3B2tGR95YG1naQ/MreDfdD30cuRa2IxubBk7sKoIE1n6PfOltd3F7Dz3VoJo121z0bXtgybIsTs56RUaQclDgbnxpTr0sImpFvtkY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7849
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,FORGED_SPF_HELO,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,T_SPF_PERMERROR autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 05, 2026 at 10:27:37PM +0000, Yixun Lan wrote:
>Hi Peng Fan,
>
>On 14:54 Sat 31 Oct     , Tanmay Kathpalia wrote:
>> I am taking this series over from Dave (thanks, Dave).
>> 
>> Testing v2 2/3 on a Banana Pi BPI-F3 and a Milk-V Jupiter showed that
>> multi-block SD reads in the SPL fail because the SD I/O rail (PMIC
>> aldo1) is at 1.8 V: set_vdd_mmc() sets it, and without
>> SPL_MMC_IO_VOLTAGE the MMC core never sets it back to 3.3 V. Patch 1
>> lets the MMC core set the rail, patch 2 drops set_vdd_mmc(), patch 3
>> is Dave's multi-block change, and patch 4 is Dave's probe error path
>> fix, narrowed to the resets because, as Yixun pointed out, the clocks
>> are reference counted.
>> 
>> Not in this version:
>> - v2 1/3 (missing max-frequency). As Yixun suggested, the io clock
>>   should be set up with assigned-clock-parents/rates in the DT, which
>>   also works for Linux; that will follow separately. Hung-Chun has
>>   withdrawn his matching RFC.
>> - SPL_PINCTRL. On its own it links no K1 pinctrl driver into the SPL
>>   (there is no SPL Kconfig symbol for it yet), so it would not program
>>   any pads. It will follow separately once it has been tested on
>>   hardware.
>> 
>> Testing: I do not have a K1 board, so v3 itself is build-tested only.
>> The changes were tested piecewise in the v2 thread, and in each case
>> multi-block SD reads in the SPL worked: Zixian enabled
>> SPL_MMC_IO_VOLTAGE on a BPI-F3, Yixun dropped set_vdd_mmc() alone on
>> a BPI-F3, and Hung-Chun set aldo1 to 3.3 V on a Jupiter. Zixian,
>> Yixun, Hung-Chun: a Tested-by on v3 would be much appreciated.
>> 
>> Thanks also to Anand for testing v2.
>> 
>> v2: https://lore.kernel.org/u-boot/20261005T135220-0400.mmc-v2-0001.DaveWK225@protonmail.com/
>> 
>> Changes in v3:
>> - New: configs: k1: enable SPL_MMC_IO_VOLTAGE
>> - New: spacemit: k1: do not force the SD I/O rail to 1.8 V in SPL
>> - v2 2/3 -> 3/4: commit message explains the BPI-F3 and Jupiter
>>   failures; code unchanged
>> - v2 3/3 -> 4/4: keep clk_release_bulk(), only drop
>>   reset_release_bulk()
>> - Drop v2 1/3
>> 
>> Dave Klotz (2):
>>   mmc: k1: let the SPL read SD cards more than one block at a time
>>   mmc: k1: do not assert the shared AXI reset on probe failure
>> 
>Generally ping for mmc patches, would it be Ok if I take patch-3,4
>through spacemit's custodian tree[1], I'd genuinely appreciate an
>Acked-by if that's fine with you..

Acked-by: Peng Fan <peng.fan@nxp.com>

>
>Link: https://git.u-boot-project.org/u-boot/custodians/u-boot-spacemit [1]
>
>-- 
>Yixun Lan (dlan)
