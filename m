Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BE77CCFA03
	for <u-boot@archiver.kernel.org>; Mon,  3 Nov 2025 16:48:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D2EA836D1;
	Mon,  3 Nov 2025 17:48:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="ZjM393bY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 994D6838A5; Mon,  3 Nov 2025 17:48:00 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 92D148331F
 for <u-boot@lists.denx.de>; Mon,  3 Nov 2025 17:47:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TuKoFrDCmSCOb1IFyu8zBBPyqQzT4ShC9QICwLBFOK99C6qrhOqVFR2OCdH1sDOZesFxX/I6IN0Vf2WMd0lzf6YWtheIpIGfUu/n0wRQCfNHcrY9/oJVDwGJDWFaWyHYE0CHT3mrTlARTLMHocOLycU3Q88CzkbXJ24Ndq/idhAzdMmhTwQTg6wHxnNi1W9dndquhvws0op4WJEunj0wug0XwNQ4jlg2p5Ja5XIF8hQUNwBrpthXeFSrzw/YyIGBAUNtdU5CtPtaCi9dj+9zQl3vDy/75eoAd68L71AbhnpX0mwm5jpbImFMCXg/XGquPDGoxZCzJl8nn5ZCyOndNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rf3/OISQem9LMwWnvJm+NxAInI7+QCkTijPMMk14q9E=;
 b=WX4F/BiNKdNDavzjAIYRPOWX959efT6QbaVOklMoFdV2LWhjPdni95Du29xOe8+lMpr0/b24n2g5+bTILcrFvfT4zF08tszjIkG2cbNKKfoAt3NQY7X8V3A09fFyO/Q+6IMtJOnWjdksvBJXg4+COlnIltDCI7tctFyFfek6zMBJOG7KSKof5LHiISZdl1DrpOBkfIsaD12JDs+BhepnOQligJq9Zdrm0uF6ngjD5EKddi0da+WexGhN2jhP8mUrxXFQjztqyis1VCtq5bq5y0qA9rMYHBl1N7ZcAURd9xbPvQetmd+UwiO/E23UQ8d8QWLl0LSmJ0j7O/mP+bjtUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rf3/OISQem9LMwWnvJm+NxAInI7+QCkTijPMMk14q9E=;
 b=ZjM393bYRbuKrxRUW6HSCZoIj8Fx1XAM/uzHMWXbT17MO4ga+UqI23c0tGe1q+snbUWhzRXFlgO2lwZGL8F7/Dtk1fHYvBb7RNYrzTa7GFcMwI7YfU50ZtWzDuvdjKRtZf0Wtl5CRBsQNlet8sgQ6bb3jL73zvAJAfDg6VGLfuM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by VI1PR04MB7054.eurprd04.prod.outlook.com (2603:10a6:800:12d::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Mon, 3 Nov
 2025 16:47:52 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%6]) with mapi id 15.20.9275.013; Mon, 3 Nov 2025
 16:47:52 +0000
Message-ID: <d7173975-9308-4767-80d3-3472f9873dda@cherry.de>
Date: Mon, 3 Nov 2025 17:47:50 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] tools: binman: fit: add support for OpenSSL engines
To: Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <foss+uboot@0leil.net>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>,
 Aristo Chen <jj251510319013@gmail.com>, Rasmus Villemoes <ravi@prevas.dk>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Simon Glass
 <sjg@chromium.org>, Paul HENRYS <paul.henrys_ext@softathome.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Shiji Yang <yangshiji66@outlook.com>,
 Anton Moryakov <ant.v.moryakov@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Alice Guo <alice.guo@nxp.com>,
 Bryan Brattlof <bb@ti.com>
References: <20251031-binman-engine-v1-0-c13c1b5dac43@cherry.de>
 <20251031-binman-engine-v1-3-c13c1b5dac43@cherry.de>
 <CALeDE9MYi2+u_ek1Rapmzx2_T9uE_cQcH8paKgxKwZjtGJ2gzg@mail.gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <CALeDE9MYi2+u_ek1Rapmzx2_T9uE_cQcH8paKgxKwZjtGJ2gzg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0090.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::8) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|VI1PR04MB7054:EE_
X-MS-Office365-Filtering-Correlation-Id: c9085b9c-b72c-471d-68e1-08de1af8baaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SVhtc3YvRzVqaWx5N3BwVC9wekgwM0k3OFF5ZzI4ZnZGNmhBeWJ4aStWV2cv?=
 =?utf-8?B?bWdCM0ZCN1hmNUFNcTh3dDM2MUxlY1Z5SjMwU0h0dnhnUEdUdjZGUzRxbE1Z?=
 =?utf-8?B?OHhHYWVlOStvSXI3Y1ViWTUxQjQ2Wi9NdWEzd1pwSWl4YVpBU2p5ZDZMTVBh?=
 =?utf-8?B?TW45UFJudEpBdHJPazhtaE9WZjhRSVo0QXJ6L0xXV0ZsSjUxVlZKTzVOOHk0?=
 =?utf-8?B?eEFyYlU0UjN5WXJocmdjYS9oOXVLb1NUQ2x3NGNTRmlvNDBuMHJWT3EzWW93?=
 =?utf-8?B?MEp0WlBGSEhIVUhTejlYTzNYczlDSWxDYk04bHVNZmhrNE9LZkg3eFNnQXEw?=
 =?utf-8?B?Z1crb09DSWtPcmloTjJ5Z1RTTk12WVc3dU1WSTVWWDFVajJGRTFubU8zZEJ6?=
 =?utf-8?B?UWRseUhXdkxOOUlJQ3g0OVFaR0VGc014NkpsMzRMMytwcGdvdTd1amEyeHAy?=
 =?utf-8?B?Q000MTZIUUJzMzlWSWY2WndMWU1SbHBONkVtajdlMWNzMVQ1d3NtOGpmZG5P?=
 =?utf-8?B?V0JzMm5IcUZSU3FFa3F0bmtWd0JPamVNL1J4SWpmUUxjeC9aUzVMb0JGVnJh?=
 =?utf-8?B?Q095NUlnM0cveGhHNnRmb3k2c1ZjTTlRaDMwNEtXbVNOd1VUcnpsNkRjVUx6?=
 =?utf-8?B?ZEgvVStZb0tONm0xWHhJSTVWT1kya2ViMFFXelF0dVgwalo1Q21CN3plL2Vw?=
 =?utf-8?B?MC9kZUhNL1hmR3hKVzhYMm1GOVZGYlhLUHo2a3EycENIS2VaWWxmS2hNaWFa?=
 =?utf-8?B?ZXlqR0ZmaVRkR0x0d05ha3VmOE1sYXpNa1Vjeko5QXU1akhjdThYUlFiMk92?=
 =?utf-8?B?NU1tRVNqZ05vVnlWMjBGOTZZakt6UWZzeFprQkpGTzNjNkUyRnB5RXhIaXBu?=
 =?utf-8?B?a0Q1QWM0R0tySHNLYm15MmxoaHBORkJlUmN2WnpOV3huOG9DWDN3Q01XeVR2?=
 =?utf-8?B?b2l1SWQ0dERjcWY2QU5SK1d5cGlmMFFjcWV5aXBXVjUzcy9zaCtkbVRaMHBS?=
 =?utf-8?B?ZW9odWVkQmo2TWRxZEFCazhQR3gvZnRzUjd1NENCc2tPMDQyUXA5MlZxa1Z2?=
 =?utf-8?B?QjBUVVk4T0lCYmhTMHRESkdQczYzK01kdit5aVp4b0MxTjF1cGNTV3BCNytq?=
 =?utf-8?B?QVY3bnd3SW9IbkEyWGtoekVHNXRiUnVCNkU1UFJsSkV3MG5vZ3dRQjVhdDdL?=
 =?utf-8?B?RU8xTExuRFRPVzVoRDlpaFd3ZWZOb0kwaW9zWk02YVJGd2pPTlVPZ2hpRnVj?=
 =?utf-8?B?a2lRMUplZE9ZN1RHelh2WXE5RkkxSUVTTHNRQjM0b1p6VnVzTzM2M0tWdjMy?=
 =?utf-8?B?NFFjZ2NxVVFjK256a0NxNSs4Y3Jyd1lWWXRURVd6SXdDVVloZDBjUUFMbkVE?=
 =?utf-8?B?enA4cTFNSWtxTEUxM2cyRlRCVVY0clhybkFWSTdrSWpnZzVHOHg5Z2VVWE5q?=
 =?utf-8?B?dm5iKytGc1hraUE5RHRQUEI2Q0xQOERiZllUSEhuQWZ3T3h5YXNWNXdxcjNt?=
 =?utf-8?B?U3JJTVdubFZmL0JkczdLQUpOYWhId05MU1hiOU5JMis3V20xV1NheFNGYW5D?=
 =?utf-8?B?dHUyYkJNVjRDbVdWdG5BRG9GeTJiK2NnREZVbmY0a1NJa25CdngrTFE4ak9z?=
 =?utf-8?B?SlVlL3d0aWdNWDg3VXlHckNQcCs2WVhrTkYvd0trMlU4SmVDK0ZlZ21Nd1Zn?=
 =?utf-8?B?dGxhQytRVjI3cW0wUGhoTFZFeGtKYzZRSjhyMW92ZGdXQWg4c2JJOGtnUThz?=
 =?utf-8?B?azBlMkd5WFUwb2dTT2NZT0pRcTl6NGx4Z1FWSy9ONy95b1k3cVltZkdRekt1?=
 =?utf-8?B?SlA0Tk52MllvRldQZmZEOEZtWHp0ZmZDbUI3bm9vQzZuU2lMcnRqMDIrY2tJ?=
 =?utf-8?B?NzVnV0w2bUlGRnU5dFl4UDg1UlQxV3Fkem53dVBSOFNwOHc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R2RYRUVkZ0dGMkd5MzFIaGhZellOL3ZqRTB4U2VVeXJtbFB0S1Vndy9JVGFn?=
 =?utf-8?B?a3I4WkNuQldOSDl6NURvRlhsSWNrK1IvVy9FN09vSzBQdmJ4NDRXQ3VPK3p2?=
 =?utf-8?B?RFNDQi9xWE1SaFV3RVM1UHNMY0h3VWNVVnRCVWN4c05EaXlnSEZZOTEyU3ow?=
 =?utf-8?B?bnB6VjZkbXZ3TjlRdlgxQ05vQkxlSm9EQzFJVWdScXVtRkNaSlp0THpib2J2?=
 =?utf-8?B?OVdFdzBDVFhlYUtaYTBBTkxoeU82ejdNU2NVMGVrdmV1ZW1DZm5DRW9GVmFS?=
 =?utf-8?B?dXBPYnN1a3p2OTlibU9LK0U5ZEhRT00wUDdXbW1XTFRXV0RDSE56T2FLdkQ2?=
 =?utf-8?B?ei9sdktDMnMyQ0RlaVl2N21zN0NsOU5VWHF1OUwxUVUya1h6dThuNFAwcldV?=
 =?utf-8?B?ODVGN05nczlzK1JPUmpDdXk2dEVpUHhpdW9Dc0hJWXN0OFQ2OVV0N3FwOE5k?=
 =?utf-8?B?bEpPQ3djVXBDWm5TODhtRnVnN251ekFWQUNQNndTOEEyRFgrRDd6SGMwVVdX?=
 =?utf-8?B?L3l3dGVrazlIdmlZZ29rOGpNZGorblRvVXBSQ2M3ckxNbzNHczVob3VNTXNM?=
 =?utf-8?B?U2xIZW4vTm1xajBtZlFBc3RoNW1RN0toczY4eG1uOGlJVG85UVhwQ20ydnJj?=
 =?utf-8?B?TDh6cmt2dURMWVlWV3pKd0tESWxiU0NVYXRKUlk0ek5sNE8vcU55T1Jtb3RF?=
 =?utf-8?B?amZUV2hiZzcrR0N1T3Qwa3laYkZ3VmxmNXo4R0VVcHBVbm45bGsycjhYOU8r?=
 =?utf-8?B?dEd5aU10a2RmSFhORjZGVy84cENpTFJyMEtxaytpbzB6SEptM1pkN0RROVVt?=
 =?utf-8?B?Zk80ckJQak5haDJROWJ1S0ZhdTdPKzg3R25HL09ad1RpMU5tWlFQSjE4QTNF?=
 =?utf-8?B?cnM5Zis3cit6WnRycG9LZzZLZU1BdU54eXlWalZFZ1ovZzZiNzVRdTFoUzUr?=
 =?utf-8?B?cEJqbkNVdWxsRnhkamQ4L2tadWlzdWgra0MvQ0g3MCtJQnFBVmVhMU9Sa3B0?=
 =?utf-8?B?MkhBTnQwOU1oR1NaY3gzdGNDVlEyNWhURmFSVnlvQjRpQ2pIM3lva0Y4WTl5?=
 =?utf-8?B?UzdNR0ZSVlBEVkVxaEVYTXhHSHpDSnJyQ1l6eTlYSDU3OHR2a1ZsMXh4Y3NT?=
 =?utf-8?B?R2k5WmJLeWJxS1BUaDRualRFR3hOSXQrT1ZQcTRsMUVsdkdEWEZkcUVjVEhQ?=
 =?utf-8?B?WnQwNkQ1VjRpTitlK0JVQVRWN2EwdnlZazZYaGZTMmZ2Qll5REthOWpQZTZk?=
 =?utf-8?B?NWwrVjlWY2FEUjJEUG4rS2l2VmpnaWtCbjljdElQZXNBckY3OEltWFR4OUNX?=
 =?utf-8?B?UVA0TWxHWi9oTlNxUVRCWllmNjA4L25yeW5DYTFYVXVCRVk5djNrZFB1MUhm?=
 =?utf-8?B?RS8wS25HekZTTkxSVkJuRTVwQ3ZQVWpQQ1hJOGZVQUJac2tHQ2VZREtuRWN3?=
 =?utf-8?B?UTM2QW9Yb2tUZGk4WU9KQi9KaXBsNFgxMTVFV3J1VTFrTkJ3TXNSQVNUYjdE?=
 =?utf-8?B?Q2tMTFgwR09mNXJPWFlqUzQ0cFM4b2l6bnEyQk1zK1BOOFdveTBZUzhNZUNu?=
 =?utf-8?B?akRlSDJKZTc3MDRyZHNUZjdNQW90QnNnSVVWL3UxL0U1S2pkUEtEU3owUWlL?=
 =?utf-8?B?TW92a2RBdU1UWmxSUUVLTnBkQmliRGROWHIxNXJlQVZHcm9jSXhsMHdxckZN?=
 =?utf-8?B?eXRUMEEwU3J2WDQ4NGhVdERiNU9wcWNTVm0wdWdtQnBrSG9lbUtpc2RLNVpz?=
 =?utf-8?B?dVp4UWNTeXZqZUlqbnc3NWNkejRCQkZzcDd3NkRLaFZkNEl3aTlmM3dsKzdE?=
 =?utf-8?B?eXdjSC9pMjF0VmdZdXpzajFRZ091S241MFNvcFNTRldNR1ZuL3Z4K3RjZlV4?=
 =?utf-8?B?bTl2cjI5dzRsY1JWOS9iN1RQNnk4cUpEZlZZMXZ1eDYwMlVvbUJ5eFNuemhr?=
 =?utf-8?B?TTA1ZklJK0ViOGpHNktwQ1RXbWNDb2tBRStxTDZpWmN1SE8vZm1kMGY2TFgw?=
 =?utf-8?B?dlpudDYwUWsvTXR5aWpDNlRQYlpOZG14WGk4M3ZXWTZwTngwajRPeUpJM1pZ?=
 =?utf-8?B?bitRaHk2TFBjK0pnUENPTlFGTEN3ZURsd2Z3VTdQd0JlZ0hhTy9vU0NUWXBP?=
 =?utf-8?B?V2M5WXpuVXlsMFhjSWhlUHFzVk44YS9EQzMwMXlEcHV1QWtITTh2RXZDVGRM?=
 =?utf-8?B?VGc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: c9085b9c-b72c-471d-68e1-08de1af8baaa
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2025 16:47:52.4659 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lj/YfNcrKUZC4DhH8fBFHTcDh0GIXfRBGEfk5FStoC0vxM57/CE0lRrBq5+kWbS11c6f2x8O/oH35HiqeRQPV4WVNPY51jGvhBgFjuWiVoQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7054
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

On 11/3/25 5:21 PM, Peter Robinson wrote:
> Hey Quentin,
> 
>> This adds support for using an OpenSSL engine for signing a FIT image.
>> To use it, one should set the fit,sign-engine property at the FIT node
>> level with the engine to use. This will in turn call mkimage with the -N
>> option.
> 
> Just to be aware this should likely be a OpenSSL provider, engines in
> OpenSSL are deprecated and due to be removed in 4.0. A lot of distros
> are already dropping support for engines. There's a patch [1] adding
> support for Providers support to U-Boot, I suspect we shouldn't be
> adding more deps on the Engine support. OpenSSL 4 is due in March.
> 

There is no plan (yet?) migrating my employer's engine to a provider, so 
I have no interest in doing that.

Additionally, Tom said[1] that LibreSSL isn't going the OpenSSL route so 
engines probably are here to stay?

Also, OpenSSL 3.5 (LTS) is supported until mid-2030.

Cheers,
Quentin

[1] 
https://lore.kernel.org/u-boot/20251031-binman-engine-v1-0-c13c1b5dac43@cherry.de/T/#m8002ea155864cf8d1ab2b8bb16b997089f4fac0e
