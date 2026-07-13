Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72312C43458
	for <u-boot@archiver.kernel.org>; Mon, 13 Jul 2026 12:54:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E334284B02;
	Mon, 13 Jul 2026 14:54:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=prevas.dk header.i=@prevas.dk header.b="KO9IW/Aw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79D8E84B06; Mon, 13 Jul 2026 14:54:18 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10F4384AE7
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 14:54:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=prevas.dk
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=rasmus.villemoes@prevas.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qSHVgG3m+4h6NAqHM1CXV+6rG9PLs2j2FSI7VAWDakp04jkGJ279bwFBCszjx/M3RIgi9AviWNp3yG2pe/f6SgthJAInKIDlOaKlFhTRRwxjvDdI8Zf1J/R2Q5u2AA6qiN+W08yQU8SC8GwKnHfiXctKabvZk2MMMEpxb+Uqi6ihNRtaTh3C2C7f8r3jC5VJqZ1DLW0q5uRWliSjay7uqzDB2rlFeF097HrM2KMl21g79l0p2ripIRdoGDnSF/gb2eF1iMXDp6wU9cNmpGIMPrNiXb4OstkLbdrpVD+P80jc+7srouCStVB1L91dyzys/bUjthPjElFa9vskwXChog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lv5cJ19ELaZHWrtu7GN+k4Tlp9oZjfJcfYsLbZjoqx0=;
 b=yydhJmmbbXw9+VN4JCkIJnEZ2Y9rnBmnZhO7jQ/g0aVFsplS/jT1u33oDNul2ZFPGv+q+iAEHIarHIMgshKbm1JpNk0+A4R93eSVD3tmJzAonMRtMkMwmcUZ0AD/nhdcGmnOdZ1qasBMyZ2fANwNvJtvNBAJBm8mTgZrUKignQAwOCGQcRiZYnrIdSWzVSEKJ5qWOaoFI3E/lgKFjeRSOAGh1nmFPheuU6lH/vIvrJFkcXyACVMxrG3Mq6T+SNlX+5B6g3W5Buq5QBqDR+Hl4UkQb02Mm+9s27J2R+VIckX5lV7LGzjutgopzC+ZAc5EJH21E91muOPDYSEQ6T3w7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lv5cJ19ELaZHWrtu7GN+k4Tlp9oZjfJcfYsLbZjoqx0=;
 b=KO9IW/Aw00dgpbmCQJG6jhxnzxxMdaLYddX9KDOxm39Pck06lrB51gLbOhctD4bMsQ718XoAubfBN1K+TC258jTUcHEsEZ8VLilEUgaC+rTFFpVjoGA2yxKAmqehhWigZ07qJLq4lTBhzpBHTcHa7KXGmmEmIcy2H0bO8YjhksM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:681::18)
 by AS2PR10MB7686.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:645::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 12:54:11 +0000
Received: from AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8]) by AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ebc6:4e0d:5d6b:95d8%6]) with mapi id 15.21.0181.019; Mon, 13 Jul 2026
 12:54:11 +0000
From: Rasmus Villemoes <ravi@prevas.dk>
To: "Anshul Dalal" <anshuld@ti.com>
Cc: <u-boot@lists.denx.de>,  "Neha Malcom Francis" <n-francis@ti.com>,  "Tom
 Rini" <trini@konsulko.com>,  "Simon Glass" <sjg@chromium.org>,
 <francesco.dolcini@toradex.com>,  <w.egorov@phytec.de>
Subject: Re: [PATCH 0/6] k3-binman ergonomics
In-Reply-To: <DJXFSHTRFW0L.O5673KW71NI8@ti.com> (Anshul Dalal's message of
 "Mon, 13 Jul 2026 17:49:48 +0530")
References: <20260710123618.2036728-1-ravi@prevas.dk>
 <g1ZugeI2t3GXZ4xFujgjTQBGM503GAuDUGRY2aBWTF_BAHnHY6kpC3gTKdcpsZMT3w_MYo98bOXeJBBQbcwOdA==@protonmail.internalid>
 <DJXFSHTRFW0L.O5673KW71NI8@ti.com>
Date: Mon, 13 Jul 2026 14:54:10 +0200
Message-ID: <87wluzrqx9.fsf@rasmusvillemoes.dk>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: CPCP307CA0012.DNKP307.PROD.OUTLOOK.COM (2603:10a6:380::13)
 To AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:681::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR10MB8243:EE_|AS2PR10MB7686:EE_
X-MS-Office365-Filtering-Correlation-Id: ece3c5c9-5418-4a61-f05a-08dee0ddd5ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|6133799003|18002099003|22082099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: OEakULQIO6IvPR9HXDAvoR96LGMHUE5JjjKoXMjOFOYqprCwk0ZFnjt4uhdicA3O0B3NTEAITskHDb21gj+g+vBBgM6eOBzc5CwPQNBQU1eiqiR7ZKJTbSyN5QQbG4uxvko53gT2ROng7naOIc8bpTY++y58Fw4I35dOW2ehHSTKIh5/ZSq5g0NhDu3j9nUM+9C0jJjqMad9A1cU0Fbg1ZcV5InWuhDGdJaeOvbfxuZGADNae2nSfRk0zyzGwBonLEDdD9uhoFERYuxnW92rA3CiNKG4ThRfzgyYe9O9fOEOQoyuE6+WuMhBYzh9b3v/j7HVXmaFh8cptGPP7b8C2l502Zto2D8wqZujCx/8BQr646+mYSJVwrvuZ5/Z7/LPuTLv1d/zj4BBwShtOmh90uyCALcNRqW9gg3CxMHzIZFoe/v3LBPaFr1SBaZIejcu7bCCHzxWVjbvGVofq4DYCNkYs7DvXQAWT7jt7GodgZTTSWs4wHMm7F1jlJPYtUpznmBq9a+AQHAbFq6ltAbhT+T58g9b0hGE058HcMU4TOpgTt4c/rPygNB1sQUyBIgAD8oRTDDi0IUXKfVrCk5F7fjZPZS6pBZdn9WopXtV7gSrs7BD+lWhe1ahMVHDf6bK7o3Av1dBMniqjR3/+tnrM6vy4k+xzKjNYjYmD+UfPcA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(6133799003)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?s385DhR5ZZR2LiyHiVZPZEVpVP8dHl5PqTETIuRPxZTfTrOrxuCYMdVhXwOz?=
 =?us-ascii?Q?p6zp27KsTKdHWu79ce2KG/guYNRmlAfwG7ZXPLa/3k2CIFseW1Ac9qtjRQ9z?=
 =?us-ascii?Q?nTOH+AM0anXiGu0aQfVoEfxpzjuPU8XMlN65Gitq41B7yHab7KaBxxZvvu/v?=
 =?us-ascii?Q?6oGZRvh3064IUhZ6bQUvf2GgZgRiqOlO5DvbYQdE8BOY3chlH1QeQxCtsfrL?=
 =?us-ascii?Q?6psXHy/vHKXURoOkphLhXULppcCq2fBS+i+WQ2v82bEnX2qlUiN9UZSrApd1?=
 =?us-ascii?Q?bTNlgUI0daG3Pe0jQG+5oID7tKqan81js69jEOI4/TWr0mdz3peEtyYNcWHY?=
 =?us-ascii?Q?rCGAWqLqH6DPxRXCuUcI7EErOUUaH0GtgXJEOOybTKhrLaNzWJ1evQjCRS4j?=
 =?us-ascii?Q?dmKpTuFDQqGwthGCcmfN30JHzckM2EwhzPZW7yFGKNrmDl82WHsIymppu32U?=
 =?us-ascii?Q?9wiCO2a20wvGMB4T1xA3eTHhk70rez+Q8mA8AKDgMdpU/bkg5+Ke0DBXCnt1?=
 =?us-ascii?Q?FjqwxrTUsjITstdpfoPJevC8xc3BGeoii1tlerUDn5FAO/sj3Fj0cl8CJz3Z?=
 =?us-ascii?Q?OeGbfxepvKX58o+vgjlMHHAKamdphSRbfxNVOzdqBdsj2kdnnFQn8cF1ji2l?=
 =?us-ascii?Q?HDSjr/mR/mMdLX9J9wAVs1czKUL7JuJpBtlDTGwnt17SWX4kPzLWO4iE55oX?=
 =?us-ascii?Q?DusOHq+hhJ8mJAj3FkoSo+0/bd8Re3de2UUaNRHOTVKH46kIROVeqyd9gJIJ?=
 =?us-ascii?Q?/9Y0Ny574oB5qvyoQ6f2Hi+r9XkNrBcZx/OU3fhQcPM/jxHPlNKDVIlfXrEt?=
 =?us-ascii?Q?YdYWRbXMd5Aj8peLWdhUOuPEwlCUms8rZqarYDgbKOKKrLc2xwj5bHm7VWAK?=
 =?us-ascii?Q?/6ElxU73K43WUg0nO7jgsJajNJxlICei+U9IXLJIodDkwQ5+MMyCjT/PpkFb?=
 =?us-ascii?Q?mc8bMNBOfIiCpK1SjqKA6i3gxzYbFBkgD/uYbe4+t79OHu2bTrwtiEM9BZRk?=
 =?us-ascii?Q?XdtPmDDRCERi8cOiIVQntQ726RgNzakGTDS35P1eU0Uky5rGsODkfCS1gtDG?=
 =?us-ascii?Q?Ihf0JSUhChx5CCkzVW+pqfaqqU1k/oJteKR95+6SnMTlg96zil8BKRWrRaV8?=
 =?us-ascii?Q?iJQseh9ASV1fX7Gg7DAhOyVfLe5XfgsOKAKlw3teMhTi/clb93YKGoHb/xIQ?=
 =?us-ascii?Q?tObE/U0Hs5NUiCjRR+ahnXYsF9WVHT04M+wdnq/LSfDZoQKJqH88u8qZl2Se?=
 =?us-ascii?Q?eQHAh/RsR/+s943fErO/AsvKRRhfrzquNcRqHrsbRljZXZT0mCs3WDzR4yDx?=
 =?us-ascii?Q?pzFByASVjF8U0Li0GAd/9ZsxBK9Xn/EXC12N3woTrogp/2lzPr0dIcSA1CSI?=
 =?us-ascii?Q?GO3s/SRfOnqZr3gXs27gvyUu2wW3+OWqAdCN7qrADLczuJSF7Cuwa/ba9ZzQ?=
 =?us-ascii?Q?A4F1KU+sYgZbW7GGs9CmCTGz0V4ghuzNI7NoqQnbkd8EaHfGDKbWBQ99iHVr?=
 =?us-ascii?Q?JMIeImpHSE0rbqyVxozrf/XaQfNY03y5FJdJtDfZQQ65XtyeGxw7iHfx7mIc?=
 =?us-ascii?Q?AUcTgQ69YlMnvfCpNvviHcYX2iFtSgomMvmMRNjXQ3ddObOFalRx95sSAgwm?=
 =?us-ascii?Q?mWkDGItUsPqBcW55LlsqoP8ZgvJOeSoe+jXqjZ5itKEG+XlM24oEL3HsvKDX?=
 =?us-ascii?Q?mtTbSWr2k+MUS//im4Cq4jc0kbCMnIXjPK+SXuMK3czz4mq6n7V4IYXoa2Si?=
 =?us-ascii?Q?cc4cidscgyTKLCwAd2ZZHggwDo9OiTU=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: ece3c5c9-5418-4a61-f05a-08dee0ddd5ef
X-MS-Exchange-CrossTenant-AuthSource: AS5PR10MB8243.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 12:54:11.6731 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JmY/zl2HTm2ayhcy1tO9g11S1EcDmk4bFWorI4mYFkX5yuR74rndOIZmvMDjxUzdinLrqunKCUbg3P50YTZwuy75/cnlvroxEAMcjf6QCG8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7686
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

On Mon, Jul 13 2026, "Anshul Dalal" <anshuld@ti.com> wrote:

> On Fri Jul 10, 2026 at 6:06 PM IST, Rasmus Villemoes wrote:
>> When trying to hook up use of a customer's own signing infrastructure
>> for some am62x devices, I found it was more difficult than it should
>> be to point at the right key(s). One has to patch in the keyfile=
>> property in way too many places, and if you miss just one, the build
>> succeeds using the generic custMpk.pem for the one you missed, but of
>> course the resulting artifacts are unbootable.
>>
>
> The default value for keyfile i.e custMpk.pem is generated via binman
> from the custMpk node in binman (defined in k3-binman.dtsi), modifying
> the filepath to your custom key should work as a single line change as
> is.
>

No, because I don't have and will not have the "key" as an actual
file. And nobody who really cares about security should expose their
signing keys to the build environment. So I cannot simply change how the
custMpk.pem key in the (top-level) build-directory gets generated from
the one in the source tree.

I'm using a pkcs11:object=... uri as the keyfile property - that
works just fine out-of-the-box with a suitable OPENSSL_CONF in the
environment, so that openssl picks up the right pkcs11 provider module
and gets a signature that way.

So I really need a way for having a single place to set keyfile =
"pkcs11:object=..." and have that be used in all relevant nodes. Yes, I
see that I should have emphasized that use case more in the commit log
for patch 4, using that as example instead of "/path/to/own/key.pem".

[In my concrete case, the signing is done by a remote service, but it
would really be the same issue if one were using a yubikey or some other
local HSM].

> Perhaps this could be made more clear by the use of a macro instead of
> hardcoding the string "custMpk.pem" in all the places to make it more
> obvious.

Sure, we could introduce a macro and do

#ifndef K3_KEYFILE
#define K3_KEYFILE "custMpk.pem"
#endif

at the top of k3-binman.dtsi, but since binman already has the template
mechanism, that seemed a lot more appropriate to use.

Rasmus
