Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DCFCC54E60
	for <u-boot@archiver.kernel.org>; Sun, 17 Mar 2024 09:38:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9DD3887C68;
	Sun, 17 Mar 2024 10:38:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="Jbg0lqEP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7288387D06; Sun, 17 Mar 2024 10:38:39 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D6B40878AA
 for <u-boot@lists.denx.de>; Sun, 17 Mar 2024 10:38:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1710668312; x=1711273112; i=xypron.glpk@gmx.de;
 bh=quZ9ulg0gtRF5OngK46PhmlB9eI4jziVw5rrMddIuVo=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=Jbg0lqEPn6YPsY1dZDyoKf9Ihr+XtGIKik6N9zsHGA3g4mPrhtRV20aNH27w8JI7
 1v4AaInuMlQTHeh5PUCtw2NB1g95IwIjkZtSIr1fRsot/z9h+/dBnMqmWNS9cTH8u
 RmNYrjH53nj8oFibuR83huRD7zHmyEnihVWwV8eKLQggb6pOtMUG8exhnGyCNjFMm
 Yh4VEoTEXvD+Ar+F8sH9HOm8c/ncZTEjk5ISIhFLe7tnXLQDVdbfewlBNyLwUIlbc
 /GK1MGCPIjryQYzYiQXr+ZJvpiaDMM/fvyLMGSCmdgKbnVPzGdGRRhnPIQJm9Nh4O
 hzVHDBe1NfWsOFbFKw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([62.143.245.32]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MKKZ3-1rV4w43n6l-00LlVk; Sun, 17
 Mar 2024 10:38:31 +0100
Message-ID: <15282646-74e4-4829-b5d7-3fea24e01cad@gmx.de>
Date: Sun, 17 Mar 2024 10:38:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/7] efi_selftest: Add geometric shapes character
 selftest
Content-Language: en-US
To: j@jannau.net, Anatolij Gustschin <agust@denx.de>
Cc: Simon Glass <sjg@chromium.org>, Andre Przywara <andre.przywara@arm.com>,
 u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20240316-vidconsole-utf8-uefi-v3-0-4e8a3d349447@jannau.net>
 <20240316-vidconsole-utf8-uefi-v3-6-4e8a3d349447@jannau.net>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240316-vidconsole-utf8-uefi-v3-6-4e8a3d349447@jannau.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aEBkxllK95NiUqd1Wm2qt4rpY/kely97RTTIz8E2bFSA8XdXSoi
 BACIvSKm1BcWYKC5ioDQyT9MSLV6G71mkSKM7TaQKqmfhwgpv64PH+FJGu/Of6DNhzSqDNm
 /XeF5xzVVgacBj6gQuCl6oYydN5boKj6ugEs0kauru0ZjqsHPyxFIm7KnIzqIex9/LPESl2
 ySfWHXICm67AYPgGWRbrw==
UI-OutboundReport: notjunk:1;M01:P0:OZmWooGg51c=;Ra7Zano+qWWy+mwFKG8hV2u8soo
 7NT4IvivmoYRn8Fxd0x2ZHkXQIwmWoF7mBOV4G8C7oxk/v7giiT1DCk6bgoTivZMmGidtUmWY
 RFSFHqc59CswI0KOykYFIBVqPzL9ImflhcFZLdroJF9f8c1axYvsB1BtAE8Vj+HNS6eOcd8Rb
 C3CtiFeY6LEcVOoZUiTKOtk7XkPxyuWEoRgt2PtcFFkPcmmD9/UxrbMfX+DxRdJqju5pJW6Ns
 a8BK4H9hQcKDE/ZpyagJuFsbT02WsRO8Bbix0zR2JUEk+Y1saig6pQyvOglXAwraaWe5Df+cH
 eogHkJuDfAJJZeazPjh10hKI4fHf+2RpAQ6Gor2TRVEr8eJuukNq+tzVx0ln4/Q/Q5d2s4nMZ
 3QqCtcPtTdaa+POegJAw0wC4o9HcujvnuY/PQp/3MAiDDeh9NlWriPnD870e64dX0CpqPql4X
 6ZOkw/MRhu+XM4Dc7DcDbF2G2v5qwMMWMPgNAHA5w7ZVuGCYR8pm8hPuyj+7iFCGtR5n+H5oz
 8g0o4i4HJ7oz5vqBwCwMp5+yYtaPRch0JG1T/V532ZI/ZESwtcuIkugHhxzjvMdh9i1h45faJ
 1E2iKWBNdwSDhzuLTQpc6KQ2DH4F1wOKvtEKijKXSCgoe91G3rszvg1xx3MHiyYKa21LM8GsF
 wKCAfMciE3lMr/nKT/YSFxhYLoHwLPGDoU+SJ9a+9JFGcr1UPdF8FTCb+MOfN4CF5lg+QIEVh
 nDV7lzSkx9xNWADb7nSHnmAHXWs5WOd6MQ+6gJZySlKM7ZXsjP7gcXJH7h/5WD52k/2ZVm/pw
 vIeNDdq3l7eqecDduSo8vCJTiUHtSrKcdwKDDaqedO3sM=
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

On 3/16/24 22:50, Janne Grunau via B4 Relay wrote:
> From: Janne Grunau <j@jannau.net>
>
> Draw symbols from Unicode's "Geometric shapes" page which translate to
> code page 437 code points 1-31. These are used by UEFI applications to
> draw user interfaces using EFI_SIMPLE_TEXT_OUTPUT_PROTOCOL.
> The output has to be checked manually on the screen for correctness.
>
> Signed-off-by: Janne Grunau <j@jannau.net>
> ---
>   lib/efi_selftest/efi_selftest_textoutput.c | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
>
> diff --git a/lib/efi_selftest/efi_selftest_textoutput.c b/lib/efi_selfte=
st/efi_selftest_textoutput.c
> index b56fd2ab76..2208a9877a 100644
> --- a/lib/efi_selftest/efi_selftest_textoutput.c
> +++ b/lib/efi_selftest/efi_selftest_textoutput.c
> @@ -60,6 +60,13 @@ u"\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2=
500\u2500\u2534"
>   u"\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500\u2500"
>   u"\u2500\u2500\u2500\u2500\u2518\n";
>
> +	const u16 shapes[] =3D
> +u"Geometric shapes as described\n"
> +u"U+25B2 \u25B2 - Black up-pointing triangle\n"
> +u"U+25BA \u25BA - Black right-pointing pointer\n"
> +u"U+25BC \u25BC - Black down-pointing triangle\n"
> +u"U+25C4 \u25C4 - Black left-pointing pointer\n";

Please, indent the strings by two tabs.

Otherwise

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>


> +
>   	/* SetAttribute */
>   	efi_st_printf("\nColor palette\n");
>   	for (foreground =3D 0; foreground < 0x10; ++foreground) {
> @@ -160,6 +167,12 @@ u"\u2500\u2500\u2500\u2500\u2518\n";
>   		return EFI_ST_FAILURE;
>   	}
>   	efi_st_printf("\n");
> +	ret =3D con_out->output_string(con_out, shapes);
> +	if (ret !=3D EFI_ST_SUCCESS) {
> +		efi_st_error("OutputString failed for geometric shapes\n");
> +		return EFI_ST_FAILURE;
> +	}
> +	efi_st_printf("\n");
>
>   	return EFI_ST_SUCCESS;
>   }
>

