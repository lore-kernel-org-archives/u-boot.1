Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D6CEC4167B
	for <u-boot@archiver.kernel.org>; Mon, 11 Dec 2023 16:28:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E609F87775;
	Mon, 11 Dec 2023 17:28:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="P5/kbvAM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14B8C8777C; Mon, 11 Dec 2023 17:28:01 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B04A3876E2
 for <u-boot@lists.denx.de>; Mon, 11 Dec 2023 17:27:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1702312075; x=1702916875; i=xypron.glpk@gmx.de;
 bh=IcCgWNhrqLlRDpHhgZ7w3iAoTBJE1g+pePi5g/h/xyg=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=P5/kbvAMRCHwrTYsjbzbsbWgItyQwxgtV7qn25jzMHJOsYGAtF+evSGfs1N6zuKK
 yJwKePhv8/P/S1XuliS8kI/6jguja+KgHYCg1ZtTo+s0EMmExEY+EjH5rofT8Pa6E
 K21j3DqZMwRvd2lvCJAK8m+q7atDuyuRAMpeJ+JXujMm26B7PaztUAl2ugapZeYLi
 gJEk/9v4200tLe7it3MzxfmDALC0bWPApNkOuNwUW3tso3SwDlD4hPVs693BNt/tq
 aeLpbEizcZAGqKqkpGlfnLEeav5bdTmfvhBXSm09O5HLhuAewg+gj2pe4CXH0SqG1
 1Na5ZC9lUwG2AHemDA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.67] ([178.202.40.247]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MNKhm-1qsQKX2muQ-00OpuY; Mon, 11
 Dec 2023 17:27:55 +0100
Message-ID: <951ffe69-9b87-45ee-a16c-0397bd49eb24@gmx.de>
Date: Mon, 11 Dec 2023 17:27:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] lib: vsprintf: enable '%*pb[l]' format specifier
Content-Language: en-US
To: lukas.funke-oss@weidmueller.com
Cc: Simon Glass <sjg@chromium.org>, Lukas Funke
 <lukas.funke@weidmueller.com>, Bin Meng <bmeng.cn@gmail.com>,
 u-boot@lists.denx.de
References: <20231211122051.1240855-1-lukas.funke-oss@weidmueller.com>
 <20231211122051.1240855-5-lukas.funke-oss@weidmueller.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20231211122051.1240855-5-lukas.funke-oss@weidmueller.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:06xUbz9oABMTn/vGLVAurKSlDYb9vh4gIuhBnbRzyGnxyr9xjF7
 NywAyURH4vKe3ufYwIVGsF6f97NL9ScLVOjY1RKkv6Vi9NhtJeoXg9N5dgXCefKYRQmR7ZS
 Wd1HFE6UYAWj3ElLFleMHNo6OWbtVHDS99k+pq08wypAYqO/YQbIDp1eOqNntHjCGOg9a7L
 BquCmdK+ZeXVZLZCYuG6w==
UI-OutboundReport: notjunk:1;M01:P0:xdvZBYQGS6Y=;KRKAo1ASlrVQDvB4n2DXS8UBaR3
 OykHYNfkNmbK3jjK8T1HsBdSZ7lyNvguuo8FH0G5JQhsphtoKXXF5LAMvBYLRUp9ldQNrj21x
 G7hUn0fYhEvSdy2ZbbdlfzUONulvMnRiFmDtY9ZiLWCAfr5t1ktEQYk2zkMfNcou3GIrM8KaQ
 TH2rorxaJvK3I6yjI8+WT0noJmaJOvXOZmbAHiEHDRGFYC43+emh/MauyRQmkxXvJGfJ1eRQX
 SjXgBnbs6St89t9NvXaikBfVfPs9LA4GdGFmVQu3azqSfcmHBEFOjZcjhwAHG7M7UbpWNU+q/
 mawTrl5kV5kfZW5dkwFDgeNL2MQF7ApZsBfQ/ooL7tQIGSVignkzmOuyyB7YFnwu4l7pDadhh
 8Y/WRV9vKJhhGDqALYNIV+Lv0pazjDyyFd1vp570sCws33+xaKPKGPA9XsIbODDeHYfXgmkgG
 4pV6C+v2SEt8nfhyFjcQyrCrj+m/LdSYVp88O5iWGwzyR5bgTsAsbHO/YAeZQbqYwzkVOgbzL
 yazJiqTG2EIFh010ifvXCEsgkUO9DrgtFfMvpGwAaSjJPaAh7zX3hEgYiOMB7UsYOloHo1M9J
 XmkWHaE8IotQNOTA3Ato+RqK+DGzlpRylPNAudLm7Vg7lIHZ3jSQOKfwYM2Ta7jrGCfFItwVM
 4X4B0Tdu8hC52gt5vD8OMaHbuc8yInlGB+o7sKyYFeZVIDQqbFX2Nk/MxaUvgHn2E6e4UXkC5
 I3Vaka1jScPkeB61TrGLamfvaR+poELSaiTKzU1znox4PN7i9BKzzi06N9rZxcr3bwGS6J3R+
 ve2P2AuLwdcF01X8e1lR+qMvOIeYKkyT4lWWOaaXfmEifBIOrlQBH+AdtxRK+yKMVTVnv19nI
 LsP9eWNdT82zJOwb+2VlO5/YXLSLsImW6CDNa9J5FgelgcnwHEGr7nyUFNTVIlddKWHk/KPS3
 Mq/GDB1iyqK2qMA4TPFY1beNEeg=
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

On 11.12.23 13:20, lukas.funke-oss@weidmueller.com wrote:
> From: Lukas Funke <lukas.funke@weidmueller.com>
>
> The commit enables vsprintf() to handle the '%*pb[l]' format specifier
> in order to print bitmaps and its derivatives such as cpumask and
> nodemask [1]. This can be used to derive kernel boot parameters from
> bitmaks such as 'isolcpu' or 'nohz_full' [2].
>
> [1] https://www.kernel.org/doc/Documentation/printk-formats.txt
> [2] https://www.kernel.org/doc/html/latest/admin-guide/kernel-parameters=
.html
>
> Signed-off-by: Lukas Funke <lukas.funke@weidmueller.com>

Please, add a change for doc/develop/printf.rst to the patch describing
the new format.

Best regards

Heinrich

> ---
>
>   lib/vsprintf.c | 75 ++++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 75 insertions(+)
>
> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> index e14c6ca9f9..abbd80ea9c 100644
> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -25,6 +25,7 @@
>   #include <linux/err.h>
>   #include <linux/types.h>
>   #include <linux/string.h>
> +#include <linux/bitmap.h>
>
>   /* we use this so that we can do without the ctype library */
>   #define is_digit(c)	((c) >=3D '0' && (c) <=3D '9')
> @@ -390,6 +391,71 @@ static char *ip4_addr_string(char *buf, char *end, =
u8 *addr, int field_width,
>   		      flags & ~SPECIAL);
>   }
>
> +static char *bitmap_string(char *buf, char *end, const unsigned long *b=
itmap,
> +			   int field_width, int precision, int flags)
> +{
> +	const int CHUNKSIZE =3D 32;
> +	int nr_bits =3D max_t(int, field_width, 0);
> +	int i, chunksz;
> +	int first =3D 1;
> +
> +	chunksz =3D nr_bits & (CHUNKSIZE - 1);
> +	if (chunksz =3D=3D 0)
> +		chunksz =3D CHUNKSIZE;
> +
> +	i =3D ALIGN(nr_bits, CHUNKSIZE) - CHUNKSIZE;
> +	for (; i >=3D 0; i -=3D CHUNKSIZE) {
> +		u32 chunkmask, val;
> +		int word, bit;
> +
> +		chunkmask =3D ((1ULL << chunksz) - 1);
> +		word =3D i / BITS_PER_LONG;
> +		bit =3D i % BITS_PER_LONG;
> +		val =3D (bitmap[word] >> bit) & chunkmask;
> +
> +		if (!first) {
> +			if (buf < end)
> +				*buf =3D ',';
> +			buf++;
> +		}
> +		first =3D 0;
> +
> +		field_width =3D DIV_ROUND_UP(chunksz, 4);
> +		buf =3D number(buf, end, val, 16, field_width, precision,
> +			     (SMALL | ZEROPAD));
> +
> +		chunksz =3D CHUNKSIZE;
> +	}
> +	return buf;
> +}
> +
> +static char *bitmap_list_string(char *buf, char *end, unsigned long *ad=
dr,
> +				int field_width, int precision, int flags)
> +{
> +	int nr_bits =3D max_t(int, field_width, 0);
> +	int first =3D 1;
> +	int rbot, rtop;
> +
> +	for_each_set_bitrange(rbot, rtop, addr, nr_bits) {
> +		if (!first) {
> +			if (buf < end)
> +				*buf =3D ',';
> +			buf++;
> +		}
> +		first =3D 0;
> +
> +		buf =3D number(buf, end, rbot, 10, 0, -1, 0);
> +		if (rtop =3D=3D rbot + 1)
> +			continue;
> +
> +		if (buf < end)
> +			*buf =3D '-';
> +		buf =3D number(++buf, end, rtop - 1, 10, 0, -1, 0);
> +	}
> +
> +	return buf;
> +}
> +
>   #ifdef CONFIG_LIB_UUID
>   /*
>    * This works (roughly) the same way as Linux's.
> @@ -503,6 +569,15 @@ static char *pointer(const char *fmt, char *buf, ch=
ar *end, void *ptr,
>   					       precision, flags);
>   		flags &=3D ~SPECIAL;
>   		break;
> +	case 'b':
> +		switch (fmt[1]) {
> +		case 'l':
> +			return bitmap_list_string(buf, end, ptr, field_width,
> +							precision, flags);
> +		default:
> +			return bitmap_string(buf, end, ptr, field_width,
> +						precision, flags);
> +		}
>   #ifdef CONFIG_LIB_UUID
>   	case 'U':
>   		return uuid_string(buf, end, ptr, field_width, precision,

