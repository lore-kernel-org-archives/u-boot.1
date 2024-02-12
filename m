Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3AACC4829B
	for <u-boot@archiver.kernel.org>; Mon, 12 Feb 2024 12:38:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D144878A1;
	Mon, 12 Feb 2024 13:38:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="ABlMGdWN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A435287775; Mon, 12 Feb 2024 13:38:31 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7504287EBD
 for <u-boot@lists.denx.de>; Mon, 12 Feb 2024 13:38:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1707741505; x=1708346305; i=xypron.glpk@gmx.de;
 bh=yp8d7SKJU2kQwh8n7sLzwDrKzhpOQupmZ9gf/gItups=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=ABlMGdWNxvABVdfTdcorWcKtBjxZ9VGXtnhNzfsMWgOGQ3YVXuWhRwQdT8fdxQBv
 Q6KqmNEHZrh/t8ZBtuUeNaRC4YQsMOR7Q82eDC8o/h1KRYMUERie4FHYwxdfCb2qr
 fbmIK3qed706Swhucvgd1H7zguMx8aG6Gt28fYBHJpqLLZPQD2pL6+xj5eGo+4OfA
 oF6Ia9xVHCnWJX+X1ScOnqiiu4Y1TALXWOq81Z268bcr9VWZwhyr4RpsSWYiZDMRn
 glqw09vH/2rZcj7jgu/OtdPI/IOWeGhEDQ08phMSoeBwU30sZryKLilmbTTN9Wzij
 WJ0ZkOWcLEBomU3c9Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.67] ([178.202.40.247]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MA7Ka-1rfbSd0Syo-00BbM6; Mon, 12
 Feb 2024 13:38:25 +0100
Message-ID: <ec57adb0-527f-451d-a243-9987a67e6bfd@gmx.de>
Date: Mon, 12 Feb 2024 13:38:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] lib/charset: Map Unicode code points to CP437 code
 points 0-31
Content-Language: en-US
To: j@jannau.net
Cc: Simon Glass <sjg@chromium.org>, Andre Przywara <andre.przywara@arm.com>,
 u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Anatolij Gustschin <agust@denx.de>
References: <20240210-vidconsole-utf8-uefi-v2-0-88c03db60de2@jannau.net>
 <20240210-vidconsole-utf8-uefi-v2-3-88c03db60de2@jannau.net>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20240210-vidconsole-utf8-uefi-v2-3-88c03db60de2@jannau.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9oHGelV0880Dk5us021TMZObZRxLUdUcDpU7gmL85t21aVX6ry6
 kfo2s79P+mJOnZAPnAl49GWiJCcO50TBBMxo6+FilMPv2rqWOSVfVB7w03yooi5CXqCU2Uj
 cAquZt7QlOf3qirt9F3dOosqFgwK4Gf9+DSdM6V9r795YgLgyrxBhI4VHKuzuNS0rPAizMH
 n9uz84vzwcP6QrykxW47Q==
UI-OutboundReport: notjunk:1;M01:P0:/ks701LnNyM=;X9QbXiS1ozP+J+HvIjnHI6hBDF2
 8wM1ukqPkMPMSqN0l3u/66g19td4XfZPg6/+LUX6kAyznMVLbIN3wgzLDapNH2P6grE6xGA7/
 Fc6spJw2E05ef559EnsZR/lLWip8M2cOfSgiyIMVyWVzeC8Y/YZxn4u9w56Wbhh+0j5ZO80n3
 erXY76lfCaw6b7y1ShJCNZflBix165ZWFR9jIpbERlMZ79yfkKl2wP0wJb8UkwZvo5ZY0sC2W
 lCkwEwLo1uZz3hKRz8XqTABKu2B6LJMHrA5AL7f00ATPNhW/HdZcbJvoxIRi5iw2xMcvCpVnm
 LemBYxxM/BIOYi/CDzy6BUYDet+8rhskhJxwNMbg95bxvu4o3ne5zOtF5HxIRau+llKahMq6W
 2/taKFrG0e2e1K9rVwLmucDo1IYlXpTIIIwh1lWy2ZBLSX2K64lEf0D2LsimBvuhh+fHiMaF0
 8k4rEfweS3msPe8jHMrr0D7Cw0S1vuc+uvWwizLW57Bs96BNIK7RGysqzaYZkQl/FHFsffQ1y
 nbX3nESOr6fyUfaJnOzvwxzobytBW3Mirkwxig44v40yLrrTTYB3pR0Q1fnSW/ESSp52aaIvJ
 sYyWPr5gst9yP2tZ19Vp7SHxw22szQJuKlLhdNpnOUfsDDg/lh1hFM/GDnaudW3lmMVgje9bt
 j2L3b7sCEcS3GOEBWNxPr5a8IVAGLH1H/9RroyX04pLDtcE59nk/Jy/auVhVlyT2VA95qwtQ9
 z+RF+8AWfyLbDDWfZMP5v3w6UCGowkVd3x6yPJGrC0X9UFtTEHS9iSfX1CCe695qWTosa+Asx
 KzaScGQoObySwFoeXbJh49gvPWXiFJ7LOjmK8fg8WLTmI=
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

On 10.02.24 13:46, Janne Grunau via B4 Relay wrote:
> From: Janne Grunau <j@jannau.net>
>
> Code page 437 uses code points 1-31 for glyphs instead of control
> characters. Map the appropriate Unicode code points to this code points.
> Fixes rendering of grub2's menu as EFI application using the
> EFI_SIMPLE_TEXT_OUTPUT_PROTOCOL on a console with bitmap fonts.
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
> index f1050c903d..348bad5883 100644
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
>   #define vi  { \
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

This functions is used by the implementation of the Unicode Collation
Protocol.

In lib/efi_selftest/efi_selftest_unicode_collation.c, function
test_str_to_fat() we should test that the added Unicode characters are
translated to '_' and not to control codes (< 0x20).

Best regards

Heinrich

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

