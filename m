Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9572C54E60
	for <u-boot@archiver.kernel.org>; Sun, 17 Mar 2024 09:24:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0880287A80;
	Sun, 17 Mar 2024 10:24:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="nmk/menG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CFBB387C2D; Sun, 17 Mar 2024 10:24:20 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 438EE878AA
 for <u-boot@lists.denx.de>; Sun, 17 Mar 2024 10:24:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1710667452; x=1711272252; i=xypron.glpk@gmx.de;
 bh=w3fHF//t+k+mSa+6NH4xzBo17WE3hAmVq1nH9t/g3P0=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=nmk/menGEfNj6XtSsj11Vy+rwXBNax7f2udZJKJA3ks8HyqcJ0Y0VRMPz4woLcr0
 /YYSg+oWtX0UdpczsUN8VYmG0tdgtjiVCI4D2GWnxlwThqR9vIa2dqZGxGAD4FUwM
 zzIkfJC+nuhCH8DCSHgwXBgBXCHWgzp0iSgEwEEYbw3eNqqOcPpE3O8Vlz1loYD/Y
 b6et21XU2X3D7huhIC+WzxbKbRZcYuT2wx/14Pa6cXbvc2XNMrcGWu0isl/XH6JtW
 oZLdmZaIcRpdg2BhN/WPHXDQO5QS/Eq7NRF/dgCL0B8pra35pBEn0M96xITceqaL9
 k7bBWgvsYkEapISyew==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.161] ([62.143.245.32]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MtfNl-1qvkQN2NV1-00v6i4; Sun, 17
 Mar 2024 10:24:12 +0100
Message-ID: <4630a614-70d0-41f7-8f40-d28d0966c4d2@gmx.de>
Date: Sun, 17 Mar 2024 10:24:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/7] efi_selftest: Add international characters test
Content-Language: en-US
To: j@jannau.net
Cc: Simon Glass <sjg@chromium.org>, Andre Przywara <andre.przywara@arm.com>,
 u-boot@lists.denx.de, Anatolij Gustschin <agust@denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20240316-vidconsole-utf8-uefi-v3-0-4e8a3d349447@jannau.net>
 <20240316-vidconsole-utf8-uefi-v3-4-4e8a3d349447@jannau.net>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240316-vidconsole-utf8-uefi-v3-4-4e8a3d349447@jannau.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:EJvqGT/dNj2qsmG+/oWgv6373WZVrxuFC6anMP1SvgJic3NhEsI
 0BArf7GxoY9TbUJuen34dU5f9IjW7NKWaBtOU3eCa0WPOZfzlYaghg/kRcIL0EJaBDc4Dwz
 SYkk/8veZ0eeI0p04viBSMnmzLAl0X+zMpmGK7t9LNAHQ15ITel0eHzvpqQVnMab4XHJhaA
 xk6SK0O+qxb+uua6lAA5w==
UI-OutboundReport: notjunk:1;M01:P0:nYCKcPKMM+U=;PpvJIi8irU7N3F2UzQvPqGBhwVC
 53motH+hY71+iE8Ir9gp/nJs5JwOUTlimsXwgzXjP/3R9Yxi/UiSjKVhZCXNqQVDqGqXEhoVe
 wQ84DEauibgZvVeazK85vJ198UL/Im5/dy1GywLlvlAQXnBwW0l0TH9CfyNyoGSq01LG+VIid
 Yw84hLNqRL7JNsaXtEbaExJKyauSsxHvV0c/SurUpxfLVDWw/VrWTw9a8+Qk1BLiULfeKpOvx
 zIaNHwJXr98JpBYRjmka8U5u0QAp2OpJSWVxn/qR/guEvSk5huw40C1XrQ0+Wj2tG4WyK+rQK
 dQLeF+LiQt2J0dzfZUGOXj2hwqaea02cASinGleY0nqMS95/KbSso9G+GDASTm0SChWFA15qn
 ocDD3NIfVsx70cJwM6WekE692lQ/mJcrsSH1I3PY/0lSGPuzBfhvu7pVuilwuvUrFDU3o5bJ+
 s4oYyWm+JcgoNc6RkYSzKKtPe2iMZrXg/mU3B0+fdmuvmzkXoe/13cvqnvoCiEB1ngKbuKpTc
 s6b+1HvP/iuI2b0yLh78xLEzlVTPuHuafV/vunm/0hp0NRLPeWGOEuUpMEtXPbbQlV2xtqxcz
 AThtiSzdRO5zxVqu1trExdScpFxo2/+YsGcdnYnW12NXNzI3SMk1PC7qa1JEk5rmo3/BxXl6N
 HWzodDeioybLyLW/TBsLvS7G81qy/6HjoF2TDEYYQENhoB4ZY5y6L/oTruR+1guF8CZ7Q3J0L
 vsA40q9axLH7DoRUAgJZxlndPXX/iA+aj/ivGUpcOr3fYUG/4TM69MS32A3xA1iHWrDv/7xHT
 5d5mNBfVqy8Ujo7UryS8iQ9XvK/IXXNPzua9RuBcutqmE=
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
> From: Andre Przywara <andre.przywara@arm.com>
>
> UEFI relies entirely on unicode output, which actual fonts displayed on
> the screen might not be ready for.
>
> Add a test displaying some international characters, to reveal missing
> glyphs, especially in our builtin fonts.
> This would be needed to be manually checked on the screen for
> correctness.
>
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> Suggested-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Signed-off-by: Janne Grunau <j@jannau.net>
> ---
>   lib/efi_selftest/efi_selftest_textoutput.c | 21 +++++++++++++++++++++
>   1 file changed, 21 insertions(+)
>
> diff --git a/lib/efi_selftest/efi_selftest_textoutput.c b/lib/efi_selfte=
st/efi_selftest_textoutput.c
> index cc44b38bc2..917903473d 100644
> --- a/lib/efi_selftest/efi_selftest_textoutput.c
> +++ b/lib/efi_selftest/efi_selftest_textoutput.c
> @@ -31,6 +31,21 @@ static int execute(void)
>   		0xD804, 0xDC22,
>   		0};
>
> +	const u16 text[] =3D
> +u"This should render international characters as described\n"
> +u"U+00D6 \u00D6 - Latin capital letter O with diaresis\n"
> +u"U+00DF \u00DF - Latin small letter sharp s\n"
> +u"U+00E5 \u00E5 - Latin small letter a with ring above\n"
> +u"U+00E9 \u00E9 - Latin small letter e with acute\n"
> +u"U+00F1 \u00F1 - Latin small letter n with tilde\n"
> +u"U+00F6 \u00F6 - Latin small letter o with diaresis\n"
> +u"The following characters will render as '?' with bitmap fonts\n"
> +u"U+00F8 \u00F8 - Latin small letter o with stroke\n"
> +u"U+03AC \u03AC - Greek small letter alpha with tonus\n"
> +u"U+03BB \u03BB - Greek small letter lambda\n"
> +u"U+03C2 \u03C2 - Greek small letter final sigma\n"
> +u"U+1F19 \u1F19 - Greek capital letter epsilon with dasia\n";

The strings should be indented by two tabs.

Otherwise:

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

> +
>   	/* SetAttribute */
>   	efi_st_printf("\nColor palette\n");
>   	for (foreground =3D 0; foreground < 0x10; ++foreground) {
> @@ -119,6 +134,12 @@ static int execute(void)
>   		return EFI_ST_FAILURE;
>   	}
>   	efi_st_printf("\n");
> +	ret =3D con_out->output_string(con_out, text);
> +	if (ret !=3D EFI_ST_SUCCESS) {
> +		efi_st_error("OutputString failed for international chars\n");
> +		return EFI_ST_FAILURE;
> +	}
> +	efi_st_printf("\n");
>
>   	return EFI_ST_SUCCESS;
>   }
>

