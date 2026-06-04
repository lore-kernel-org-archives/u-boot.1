Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF6F1CD6E6B
	for <u-boot@archiver.kernel.org>; Thu,  4 Jun 2026 11:28:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 276A98486D;
	Thu,  4 Jun 2026 13:28:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=nokia.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=nokia.com header.i=@nokia.com header.b="qc4wzPxG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F63184874; Thu,  4 Jun 2026 13:27:59 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 127518486A
 for <u-boot@lists.denx.de>; Thu,  4 Jun 2026 13:27:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=juuso.rinta@nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DfQIQ0JN83akZQzjXEdkWxZfsQ+btEoBLfJDWFPjeKqKuufe7cFv6JkVSuVP30NoIP15ztw90710o1YcaCMorVTX5YXeUOeO1LCx+z169I8bsdVhl5ftSyaKCq4q58Mn7IJIvdSCoUzWhfYrABxHs9fDywbBeDpZAWhm+1fj5mUG+xvHPJAFBgOkYemEhq6IwWonfiDrXkrP0obcz7zlTCLVtQ9dBKrc27rGp6j0+tSbV6n2Rio07FPE3BuRjM17obG6cPxNAmtvxlLhgvUUoheuzCwnMxgi0cEUrlHHbp1vW27xuz6evpesmSUqevybX/UaGBF5JEG9WNfPCl84EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aRY14GaiLpXzKlOg60o/Nh5yJC7qoOwWy87foiWxLO4=;
 b=DpVeyIJXQ74h4Srxupi0reFhrCrlN3Xbz0Vh2TXmYLrEmBSfLCPreUiVtO+w2glma05O1tIKCuLWqEBHRejG4Q1Jl7aUZLdUuRA7/+4yvJGTOX8FW0z7aj9UgWGeaxf79cLlReTCT4hd82NV4cPhB1sosq4N6FBZ/xseNtXxMvxWv3mRCsSjclEbQIFpFfDtYHy6iy35PJXPJMAb5rPcDxnuxlMbYt9vgkDJVsTevrbswIh68o/imN1bfB+gku1yQtsDBHC1uSaA82EdBf30V+ieLbuo33XzgAh9fw5QefVbWsop+kVfXenNLRpY4WmmHsq/lcFr4BuNztaT/Yr+PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aRY14GaiLpXzKlOg60o/Nh5yJC7qoOwWy87foiWxLO4=;
 b=qc4wzPxGSoy+yhtmX/Y5vQ6ljHvPOl558CkO5uwUhRowo0jCNeuWDnNRhMhTUQwWyXwaU3DlOfosb+/UxuJtSrz9k5ekJkiykLilxRh/8eIr3kp2Q26TMxB3X7AFvOISeagSrfNY+VaDBn6gAsJdyfqp5zT4QryXDREA9DJTRmyU6xfYJvgSYIUTQyaPhTjM0zbdfCIPeMrrever22Fc2YUd00tU1uwby3ZwkLF6AxwOT/J+dUsdoqx5a9ZYATX58XGX0F3XhgCjtNM72H8XZhP+JrvhEsMAZ8fsk49dvntigcG9U4I0bB0RyKC/XT6pAs8MpQvSpCW+wWLqhZycuw==
Received: from VI0PR07MB11748.eurprd07.prod.outlook.com (2603:10a6:800:316::5)
 by MIYPR07MB12205.eurprd07.prod.outlook.com (2603:10a6:290:7a::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 11:27:54 +0000
Received: from VI0PR07MB11748.eurprd07.prod.outlook.com
 ([fe80::7e64:11a0:892b:90fa]) by VI0PR07MB11748.eurprd07.prod.outlook.com
 ([fe80::7e64:11a0:892b:90fa%4]) with mapi id 15.21.0092.006; Thu, 4 Jun 2026
 11:27:54 +0000
From: "Juuso Rinta (Nokia)" <juuso.rinta@nokia.com>
To: Stefan Roese <stefan.roese@mailbox.org>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>, Patrice
 Chotard <patrice.chotard@foss.st.com>, Yao Zi <me@ziyao.cc>
Subject: Re: [PATCH RESEND] watchdog: sbsa_gwdt: clamp WOR value to hw max
Thread-Topic: [PATCH RESEND] watchdog: sbsa_gwdt: clamp WOR value to hw max
Thread-Index: AQHc26lKkqgiG357Zk2tLm07WbEs0bYECiAAgCpnY54=
Date: Thu, 4 Jun 2026 11:27:54 +0000
Message-ID: <VI0PR07MB11748B24539E06B1A55E6EA95EF102@VI0PR07MB11748.eurprd07.prod.outlook.com>
References: <20260504-fix-sbsa-timeout-overflow-v1-1-87de9b44112f@nokia.com>
 <6cf43fb7-f39a-437e-bcdb-23a4d20d2b10@mailbox.org>
In-Reply-To: <6cf43fb7-f39a-437e-bcdb-23a4d20d2b10@mailbox.org>
Accept-Language: en-FI, en-US
Content-Language: aa
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI0PR07MB11748:EE_|MIYPR07MB12205:EE_
x-ms-office365-filtering-correlation-id: defc9779-4baa-47f4-8d1d-08dec22c51fe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|8096899003|13003099007|56012099006|11063799006|4143699003|22082099003|18002099003;
x-microsoft-antispam-message-info: ngPyrmaeRjXoMpbyq2OCPpcUzVSIUSk+2bUcZ2kKS1sp8SVR7FFKMVzW1KOS7uek6W3vt6k9A/h538qZaL/8SkTTbJJBm952AkzN3Tx/ntPHfzB0WuyjVRMEernIfHIMGPr+ZyjUkDOIbnTpNH9Z9GR4/U9077MwqXCZcV8oqE79FBiar9sNzhiUlEngDLhPPcNqp0xHHCr9LE++czo2JLo1FOco/6I5+DCuhV9PYAAEu8Oqocww/hC6Vo1/K7AGihWjgcJjOcy71EjGG3+I8HjsMn0LMLYG+dkQHpN9rg3HeFPerd/bv5H3eTSAtIV0mfHc4nJQ5uMh1tz4F3THwzzt3vmM/QJ58C/jm6YSvrbUo3y+eavJBMODqpg6FcIUTPRVSYjTtk7CoL+K83qUvvzkri/YRZ0EAkAZ+3ijB2hF7D7VWzMdbmkjxNkRvneias1G3MeAEZCiuGOfA/++u90mqtoQoJilov5/dHpwUDhSa7iJVWoOgQhq6vbHlFb4QAo9AYtIEjqFppvaZ66q04mv6+qLsLh93iZNClxQVSWLSW+SE4UmzZ7VBFQuDfHsUtq6h3M/xu+db6QQ7gTxb6tmderwR/n2WZUpBL0jCOq5g3KtCTWVtkS/Sj6AgpsPmYFua6ewWCDpBOfQ5FNWWZwUdhhA2cRWyDdipdmPXmCJNjinuBu2zLS1sDkz/7v/wIvAXn/YoX71Qmwc0e3Nk84Yg1yfCnBjca0dMvahCv/rPO9nFGKnVG0ZLefr3nhK
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI0PR07MB11748.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(8096899003)(13003099007)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?d5QIDeRssxxR2Kj5Greg3M56e0TNq89+1X8AlvMbz813jpJhLLiVYTCmzLBz?=
 =?us-ascii?Q?mvyMHJ+zc1b8a8PGiR90QsBXVWu0ImtYX3id7AZ0yZjHYA7mfukv8VXL+DKR?=
 =?us-ascii?Q?GvEZ69TR6l/kEyQX6OO1wzQZHIWYCANsT8/6oGQUouM/VDqA2KcuZrpxb8mP?=
 =?us-ascii?Q?QARvt0PEbGQVfm4HBSBWg2htYQYWFaRHAQzU1Vqr/4tO9znOxN+YgZmgXlqf?=
 =?us-ascii?Q?ML3OQRuyKVa5EOCDRUJ2PKEDSqfyAJODx0Xkx6WnbbVCH4vBqNoNFEsE5lY1?=
 =?us-ascii?Q?R2xjTJvFR7WnAhQBuyE3ycsxYcVjx7JbkWSXGIH+NzQvE2Rm1hYSPEJjZdAY?=
 =?us-ascii?Q?mQbLsXz5oeMvVfpBjBz/REUPVlAJvzWpaPVM+Ch6fICmToZS//LuCqwpSugg?=
 =?us-ascii?Q?LY9JqnSaQdrAyvSjsCVmAFTPJNKdvrMvjG1noWLuHe+l6HDZ2a5MN3a0X2F9?=
 =?us-ascii?Q?zBmudzFaxWorYMi8wgvPrx4xrhxozG425Pjck/p1v3zOTm9dRxWKfC/wY0Sd?=
 =?us-ascii?Q?0FV5/rPb9dWt14xz3o5M+G9DK12po7Br3ikGfhlPJ/rjHf0D+A+1RkT9cT3H?=
 =?us-ascii?Q?JHoU3TP/f1hWgCTKsmBZFdgolK1gdSbhCGDnFDx5hy5drjnATiXaaIc/ard3?=
 =?us-ascii?Q?zOX2B+de0qOv5Vixt9VjXhgdgSLQ74u6C+wwk4ReJHOxFGTTSTGDgb9YZNr/?=
 =?us-ascii?Q?2bgmk8+SuT6m5ksA8GJS7Wmot1TzmkeX/NHjzerfss7OH2pEM2LhrQqaDz4/?=
 =?us-ascii?Q?Xgf/oQk+Purz22kh1zpJ9YyVIqgitQ2uQ9o3nWHV5dKKBdUcC71TQTCtz1ZH?=
 =?us-ascii?Q?AbM6i/lTMEedBtE4dfaNntZPsTnOMmApFGA20G3DGOK2Q1uVUrqZqGeiq2Nv?=
 =?us-ascii?Q?0qFUkHHwWX81vWXtMlTRtaCOs3zoL/B+YbofebFWawcxppq7zLS5ElU7Wl1a?=
 =?us-ascii?Q?jNUZ/gup+Q7jVRtpTX9YncBQE1bBFil4yiqP0HZCB3075BDZnXWk65s7oEuK?=
 =?us-ascii?Q?Q/p++IchkxpJ2PWd1Q29cqC/Za3p3HV9vkeMeGZuRmGoFk7ngmaF7yM0mGb+?=
 =?us-ascii?Q?iB1TVeDCyoOMWMb2mB04PLpeEqWAj7fX4Fy1eWH47atVEL2kFQKeQSCEeRaG?=
 =?us-ascii?Q?eqRbzoXI2a0yMGRhFu76DYeu2FghdcvbnAqrkK9bcdo0VMTE93E4yOz+2YDg?=
 =?us-ascii?Q?LSDmubXPmxJi2e2RLjtb+ejpZTz16gZXp+ObUjNsqO/8EVRwGWS85HxH1E+J?=
 =?us-ascii?Q?Dekq5nIc5T2xy3Qf9xiOjpes980qaQXiuN26ixSs/KDvWrwhXsIeJeDMidGH?=
 =?us-ascii?Q?+fyPAoM+9xdLPTflT7Wd+HX5anghpc8ox/D9qk9yHLexS2Ie9T6AKmeS0CQ1?=
 =?us-ascii?Q?CUTABX9FAKKIFY/PVF2PPXNMC7SHCa183dwOQX0p5T2WOmfSOviy4Kgr3EtW?=
 =?us-ascii?Q?whbiZLFIxYBlUzYMT5eUaej8tHE/DOnkcTeUnSTvS/u89t92X0of7YGXhCZB?=
 =?us-ascii?Q?Q1racL/ToUDYWYmmLkKyRjrc03qMRMeThQBTgt4OYlIPAemOV4pFJbqgq3JS?=
 =?us-ascii?Q?ehE1F0g4ia8HtceGRWBYUeuWEx+WE/gFwC/D7b9/90LwpDITZ5HL4EBV8Sjk?=
 =?us-ascii?Q?s12WTWEWWvqZ1kCwDTcBqXpe6hYPXGMPTN56eHOxBJfztb4ud8MZ0mpyBsWy?=
 =?us-ascii?Q?LFAlYeTpHOLMdlY7OUDDvsOjE2ibPNzo5ibFLCT/Z6w6l3Mb?=
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI0PR07MB11748.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: defc9779-4baa-47f4-8d1d-08dec22c51fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2026 11:27:54.3076 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HCspTx04DcEWWcFVIHnwdPvoPvHQaNy+CidwWzAr1FtBn73RtFpHPq6h18LWzdn66OGdu02UnOsQewdWGbWezA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MIYPR07MB12205
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi,

Just pinging whether this patch is all good or if something else is needed =
to be merged.

Thanks,
Juuso
________________________________
From: Stefan Roese <stefan.roese@mailbox.org>
Sent: Friday, 8 May 2026 14.49
To: Juuso Rinta (Nokia) <juuso.rinta@nokia.com>; u-boot@lists.denx.de <u-bo=
ot@lists.denx.de>
Cc: Peng Fan <peng.fan@nxp.com>; Tom Rini <trini@konsulko.com>; Patrice Cho=
tard <patrice.chotard@foss.st.com>; Yao Zi <me@ziyao.cc>
Subject: Re: [PATCH RESEND] watchdog: sbsa_gwdt: clamp WOR value to hw max

[You don't often get email from stefan.roese@mailbox.org. Learn why this is=
 important at https://aka.ms/LearnAboutSenderIdentification ]

CAUTION: This is an external email. Please be very careful when clicking li=
nks or opening attachments. See the URL nok.it/ext for additional informati=
on.



On 5/4/26 11:34, Juuso Rinta wrote:
> The WOR register is 32 bits, so any tick count exceeding U32_MAX is
> truncated by writel(). A large requested timeout can wrap to a small
> value causing the watchdog to fire sooner than requested.
>
> Clamp the calculated value to U32_MAX prior to writing the register so
> over-large requests will be set to the maximum timeout value.
>
> Found by code review.
>
> Signed-off-by: Juuso Rinta <juuso.rinta@nokia.com>

Reviewed-by: Stefan Roese <stefan.roese@mailbox.org>

Thanks,
Stefan


> ---
>   drivers/watchdog/sbsa_gwdt.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/watchdog/sbsa_gwdt.c b/drivers/watchdog/sbsa_gwdt.c
> index 807884c5bc7..3a924cb2b9a 100644
> --- a/drivers/watchdog/sbsa_gwdt.c
> +++ b/drivers/watchdog/sbsa_gwdt.c
> @@ -50,6 +50,7 @@ static int sbsa_gwdt_start(struct udevice *dev, u64 tim=
eout, ulong flags)
>   {
>       struct sbsa_gwdt_priv *priv =3D dev_get_priv(dev);
>       u32 clk;
> +     u64 tout_wdog;
>
>       /*
>        * it work in the single stage mode in u-boot,
> @@ -58,8 +59,13 @@ static int sbsa_gwdt_start(struct udevice *dev, u64 ti=
meout, ulong flags)
>        * to half value of timeout.
>        */
>       clk =3D get_tbclk();
> -     writel(clk / (2 * 1000) * timeout,
> -            priv->reg_control + SBSA_GWDT_WOR);
> +
> +     /* if requested timeout overflows, clamp it to u32_max */
> +     tout_wdog =3D ((u64)clk * timeout) / (2 * 1000);
> +     if (tout_wdog > U32_MAX)
> +             tout_wdog =3D U32_MAX;
> +
> +     writel(tout_wdog, priv->reg_control + SBSA_GWDT_WOR);
>
>       /* writing WCS will cause an explicit watchdog refresh */
>       writel(SBSA_GWDT_WCS_EN, priv->reg_control + SBSA_GWDT_WCS);
>
> ---
> base-commit: 4433253ecf2041f9362a763bb6cb79960921ac7e
> change-id: 20260428-fix-sbsa-timeout-overflow-20cf84fa8a6b
>
> Best regards,
> --
> Juuso Rinta <juuso.rinta@nokia.com>

