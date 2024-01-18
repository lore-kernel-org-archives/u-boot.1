Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FC76C47DB3
	for <u-boot@archiver.kernel.org>; Thu, 18 Jan 2024 18:33:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5004187B8E;
	Thu, 18 Jan 2024 19:33:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="RaIOs/f+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C6BC87BB5; Thu, 18 Jan 2024 19:33:12 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 26A47865F5
 for <u-boot@lists.denx.de>; Thu, 18 Jan 2024 19:33:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1705602786; x=1706207586; i=xypron.glpk@gmx.de;
 bh=e+StDIy7rGjZ6M3ZirfM1NKUc/BZ4GYofIkDyPel4Vk=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=RaIOs/f+ON3Agv9UdPVoxu+rc+By5WKxPZLjrEWpSReJtZIg1jlfmVbtSPZ7TBVc
 0boLKvwrlubwxzNrFH9tznjFr3SATpXZnM8mTBtOiR7bWhZDShgl9Icv7+6dJ51YN
 btTEflgykO4Dp8XfWDdw/Np/l/vGaLl8wG4++UWcJXd36Uhap3QpSO/Ei+Xf/REBg
 fT37N0m6qWSMJCcAYJPZwLQX20zebc/XwcwXZ9R+SDcHEsBwfNiEAA7dH2BV3bbXG
 fVxgavnERcQpxA6oNUNFxKhteNWZaCtcrPIxeN8wCXvnRuiYxJA/GMWNEZF6dx3bk
 cMQNUWXxkdmWbqdLHA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.55] ([178.202.40.247]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mj8qj-1qwiEG3qzN-00fF01; Thu, 18
 Jan 2024 19:33:06 +0100
Message-ID: <873965b7-935d-4471-a1c7-e2b946468420@gmx.de>
Date: Thu, 18 Jan 2024 19:33:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 3/6] lib/charset: Map cp437 low chars (0x01 - 0x1f)
 from unicode
Content-Language: en-US
To: j@jannau.net
Cc: Simon Glass <sjg@chromium.org>, Andre Przywara <andre.przywara@arm.com>,
 u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Anatolij Gustschin <agust@denx.de>
References: <20240117-vidconsole-utf8-uefi-v1-0-539f7ce74fb9@jannau.net>
 <20240117-vidconsole-utf8-uefi-v1-3-539f7ce74fb9@jannau.net>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240117-vidconsole-utf8-uefi-v1-3-539f7ce74fb9@jannau.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1c/EMpprPtOZTdl/BVjFz3mR9eloussT3iC0jG/de+igLQ6WYwx
 LZiq/0ysUAbeh7+J6yuI1slEiwTa9y/baScnYZA7y0Iuk4jCw6Ov6g2Byh85CGWunMadlY9
 zlpr9yxwTNSZenF13Cb3t+Y37jkdBMjkRGTUYCmkeVG5ThGC8Y+wYPuzYINJcy2W9TzEz0h
 lpi4R0bkN5D8u3xK8/G/Q==
UI-OutboundReport: notjunk:1;M01:P0:q273efBFEXM=;newhJSVxmO6+m7LRiZASzQpU8Ia
 RKjuA5KcobtMml+M/L1VoaJMHTxEu3kHV02hnOZHg8KAGqk+CiLgpsCaX9dcu6Hlk7Tbh0jsm
 O6L4Lq+QtkNjcxTRV47fvjY/C0U69XpWJPhMCzwkzUNgCXMWv7RV6MWUlptTudaDPq0EEbvv8
 pdtEIqzkiVoDNE+0HNCYprVOOq0l1O7nNTleTVW7SPW7ztk6erJXyS8Ctf9sLzdQiopTNjC2b
 uMdXmzYa3e500/k4pTdKSaEFJ2b5Hwhx2tan40qlUUMCIfh3jOgWYScDJPIty/GCjryr4Wdbx
 sSpE+vRVqp5BRyV0DgU0XqvLGjOPzjc4D/qKE224SvwsOhfQKvrnYxWaOz3PuLV/FRE2ZHjlX
 F9qB6IqUDJ36oeWcCUK+AM6Ufj26EgAjvi8xodOt2p3TfSwbfmXyoyajTbEfEeru2OZCWFzGT
 iIyMsoG7mltqbrisWnb+Syx9ir5K61RyJyhtmjCMVaKGoMkjTkYFyUp2HcTVNXav8fQ9ecCXr
 tw2rRMtcdWB/LOcQFGtDV1AQO2aBtPl/Wd8ljQTSVBZX+emTVug3GbBt21uk06+8fBMdwjA20
 7qxeLZxLRDji+Oo0onisCpQaiNSzhyBwccRLqcCV/ngSCN1MfXQna/8vNPERdCFEn4RQSR8np
 SMfEWNY8bfPtXvhAOaxsvAHHKmpZ3gzvgjDnNTBTkbu83Qhjfh0sl2b8oekbjuoX6HKTlUB58
 IAtFHaSs4UP0weUVIl/UVxNxpnkf98Nim6L+g18MQK5KTL7DnK2jgEC3cJWjLxpVxcwu084KP
 Ef0FAKNEFOe/IfldDucvB+RK4xBpMJL5KzmE4u8T28gj45TZi7z2wav/GCUwqXB8uO3kE1Zhw
 YtpB9qX9tQlA/5zblyX45TQo54AnlJWJsM7qZ0caI0e112LrfADDBQ+BhncD0pacpz/cmMpne
 GPUxC3CItsEshxkfmpIo0Q5z7/k=
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

On 1/17/24 23:24, Janne Grunau via B4 Relay wrote:
> From: Janne Grunau <j@jannau.net>
>
> Add mappings for code points 1 - 31 as those code points in code page 43=
7
> are graphics.
> Thios fixes rendering issues of various EFI boot loaders (grub2,

%s/Thios/This/

> sd-boot, ...) using EFI_SIMPLE_TEXT_OUTPUT_PROTOCOL.

Could you, please, explain the reason for the change a bit more in depth.

The applications above produce UTF-16. A Truetype font should not have
symbols for positions 0x00-0x1f. Codepage 437 is only relevant for FAT
file names that might use this character set.

Why do you want to translate well define Unicode code points to
characters 0x00-0x1f?

Best regards

Heinrich

>
> Signed-off-by: Janne Grunau <j@jannau.net>
> ---
>   include/charset.h                      |  2 +-
>   include/cp1250.h                       | 12 ++++++++++--
>   include/cp437.h                        | 12 ++++++++++--
>   lib/charset.c                          |  9 ++++++---
>   lib/efi_loader/efi_unicode_collation.c |  2 +-
>   5 files changed, 28 insertions(+), 9 deletions(-)
>
> diff --git a/include/charset.h b/include/charset.h
> index 714382e1c1..c51c29235f 100644
> --- a/include/charset.h
> +++ b/include/charset.h
> @@ -16,7 +16,7 @@
>   /*
>    * codepage_437 - Unicode to codepage 437 translation table
>    */
> -extern const u16 codepage_437[128];
> +extern const u16 codepage_437[160];
>
>   /**
>    * console_read_unicode() - read Unicode code point from console
> diff --git a/include/cp1250.h b/include/cp1250.h
> index adacf8a958..b762c78d9f 100644
> --- a/include/cp1250.h
> +++ b/include/cp1250.h
> @@ -1,10 +1,18 @@
>   /* SPDX-License-Identifier: GPL-2.0+ */
>
>   /*
> - * Constant CP1250 contains the Unicode code points for characters 0x80=
 - 0xff
> - * of the code page 1250.
> + * Constant CP1250 contains the Unicode code points for characters 0x00=
 - 0x1f
> + * and 0x80 - 0xff of the code page 1250.
>    */
>   #define CP1250 { \
> +	0x0000, 0x0000, 0x0000, 0x0000, \
> +	0x0000, 0x0000, 0x0000, 0x0000, \
> +	0x0000, 0x0000, 0x0000, 0x0000, \
> +	0x0000, 0x0000, 0x0000, 0x0000, \
> +	0x0000, 0x0000, 0x0000, 0x0000, \
> +	0x0000, 0x0000, 0x0000, 0x0000, \
> +	0x0000, 0x0000, 0x0000, 0x0000, \
> +	0x0000, 0x0000, 0x0000, 0x0000, \
>   	0x20ac, 0x0000, 0x201a, 0x0000, \
>   	0x201e, 0x2026, 0x2020, 0x2021, \
>   	0x0000, 0x2030, 0x0160, 0x2039, \
> diff --git a/include/cp437.h b/include/cp437.h
> index 0b2b97132e..5093130f5e 100644
> --- a/include/cp437.h
> +++ b/include/cp437.h
> @@ -1,10 +1,18 @@
>   /* SPDX-License-Identifier: GPL-2.0+ */
>
>   /*
> - * Constant CP437 contains the Unicode code points for characters 0x80 =
- 0xff
> - * of the code page 437.
> + * Constant CP437 contains the Unicode code points for characters 0x00 =
- 0x1f
> + * and 0x80 - 0xff of the code page 437.
>    */
>   #define CP437 { \
> +	0x0000, 0x263a, 0x263b, 0x2665, \
> +	0x2666, 0x2663, 0x2660, 0x2022, \
> +	0x25d8, 0x25cb, 0x25d9, 0x2642, \
> +	0x2640, 0x266a, 0x266b, 0x263c, \
> +	0x25ba, 0x25c4, 0x2195, 0x203c, \
> +	0x00b6, 0x00a7, 0x25ac, 0x21a8, \
> +	0x2191, 0x2193, 0x2192, 0x2190, \
> +	0x221f, 0x2194, 0x25b2, 0x25bc, \
>   	0x00c7, 0x00fc, 0x00e9, 0x00e2, \
>   	0x00e4, 0x00e0, 0x00e5, 0x00e7, \
>   	0x00ea, 0x00eb, 0x00e8, 0x00ef, \
> diff --git a/lib/charset.c b/lib/charset.c
> index 5e4c4f948a..1f8480150a 100644
> --- a/lib/charset.c
> +++ b/lib/charset.c
> @@ -16,7 +16,7 @@
>   /**
>    * codepage_437 - Unicode to codepage 437 translation table
>    */
> -const u16 codepage_437[128] =3D CP437;
> +const u16 codepage_437[160] =3D CP437;
>
>   static struct capitalization_table capitalization_table[] =3D
>   #ifdef CONFIG_EFI_UNICODE_CAPITALIZATION
> @@ -517,9 +517,12 @@ int utf_to_cp(s32 *c, const u16 *codepage)
>   		int j;
>
>   		/* Look up codepage translation */
> -		for (j =3D 0; j < 0x80; ++j) {
> +		for (j =3D 0; j < 0xA0; ++j) {
>   			if (*c =3D=3D codepage[j]) {
> -				*c =3D j + 0x80;
> +				if (j < 0x20)
> +					*c =3D j;
> +				else
> +					*c =3D j + 0x60;
>   				return 0;
>   			}
>   		}
> diff --git a/lib/efi_loader/efi_unicode_collation.c b/lib/efi_loader/efi=
_unicode_collation.c
> index c4c7572063..4b2c52918a 100644
> --- a/lib/efi_loader/efi_unicode_collation.c
> +++ b/lib/efi_loader/efi_unicode_collation.c
> @@ -257,7 +257,7 @@ static void EFIAPI efi_fat_to_str(struct efi_unicode=
_collation_protocol *this,
>   	for (i =3D 0; i < fat_size; ++i) {
>   		c =3D (unsigned char)fat[i];
>   		if (c > 0x80)
> -			c =3D codepage[c - 0x80];
> +			c =3D codepage[c - 0x60];
>   		string[i] =3D c;
>   		if (!c)
>   			break;
>

