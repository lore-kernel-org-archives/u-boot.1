Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A520C4332F
	for <u-boot@archiver.kernel.org>; Tue, 12 Dec 2023 15:24:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8ED158746C;
	Tue, 12 Dec 2023 16:24:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="f/1aFfNO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8648C871CE; Tue, 12 Dec 2023 16:24:22 +0100 (CET)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9BC8A86FD8
 for <u-boot@lists.denx.de>; Tue, 12 Dec 2023 16:24:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1702394658; x=1702999458; i=xypron.glpk@gmx.de;
 bh=qjrKsPbu0dIuE44ib1Ab94zTGDEiv2CoOv8qbOhMges=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=f/1aFfNO3eI1uW06O8q9R0zvZdX7wY8sahpTSGD2oVvPqN+0z5nlTDhlrNDZ3gIW
 iXKroWjLITet0FqYs1ftBksc7/gb5PMKZmeZqIHK4giPS7g6eZh9yTBZnGSc3AES9
 MyxvH7rCXARA1PgnPYJ6KVIOIk31HeG+8W0+jw5YPEFbyUqpt9XH45Qyy0lxVUwPO
 rAlflXkouz9zYS2d4kdiTpLs+2DFuvIlREm98bunCY37Ms+i7fPHQRwvVEQtolpbj
 DzlHeNbrKgUh3/Ex/bR4hGfbGSl4fCFG6SU+dD9A/F8HiSqz1ChKf5nOj/u3O/jTi
 onXEvvtfdBgAGD09XA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.123.67] ([178.202.40.247]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M3DJl-1rCF8p2o9d-003dKP; Tue, 12
 Dec 2023 16:24:18 +0100
Message-ID: <a2555b3d-564d-42c5-85dd-66bb8dd0cfff@gmx.de>
Date: Tue, 12 Dec 2023 16:24:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] cmd: printf: forward '%p' format string specifier
Content-Language: en-US
To: lukas.funke-oss@weidmueller.com
Cc: Simon Glass <sjg@chromium.org>, Lukas Funke
 <lukas.funke@weidmueller.com>, Roland Gaudig
 <roland.gaudig@weidmueller.com>, u-boot@lists.denx.de
References: <20231212085236.2730768-1-lukas.funke-oss@weidmueller.com>
 <20231212085236.2730768-7-lukas.funke-oss@weidmueller.com>
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <20231212085236.2730768-7-lukas.funke-oss@weidmueller.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OsLoC4gHiQEDg22iKfk+/6IQISq0TPMq41IgerTLrle9PnlD56P
 T2s+jnC58qJoC21DccBy16vbnLZPG4mUgXfTV4OffA1YR5AIsCxX57BLJ8pY3nJ5jZLt0Uu
 enX0/Hv/DP9XsMoP6vSVRj7GihzsRoHilDc7U1UwJJ+jP5hroJngIL02I9ZQRhnWkfUFE/I
 K6Cz+W/6GEuZ7x8eQqHsQ==
UI-OutboundReport: notjunk:1;M01:P0:9fGXjuXSRP0=;Mx3ydBqUbF11wFQF23OHcBBEkCy
 d1M76ejBFZC7VBSVAim6mTxs6MN+AI2v4AGB7+8P89OwbiGreiLsmlLLogqSCEYNUpXNk/hAX
 kLOyUQyuEAixYkyKsMD/XdCvoeBUTn+ttsMVQtdmXrSWbAIcpN3Og1HOiQqP8OcHdTIF+vxLH
 +FNp7g7BsF8gFB0GEEM/BdjwfPeMMJHqZuLjT8RBhHHyc5fffTLk5J9IZ3XNT2wuPv8wPVJR7
 bGVu42mAtJmpb01lN7yATrB1dQ3IFzhBqOTBd5ePZJud6Pq2jLoSeermV9NgTREy4rWxm1iRH
 DLXyWwC/YK1vgOot7FYu5IF7XINFxRuwRvJSck5JhZywuxjX16uQhec7t0q2ub375+Jj+0S42
 fZpyjT+Eph+4yX68Z3DdXBhjY5vY3vaU3dhLwmgs/WEPy0BfVNzmigY1jjVaRqpcRd2s1fO/f
 tDozh5v9PFPMKFlWhBJlGWrTfIQLE6AaabKLQ42q8Qiu2qCafxHomIv1F3/4oGUJYakPvpvPe
 Yi4SEZbTBi/duXZg9/b25UEyxj03ZUoK2J5lCRaM4sPKVq9BZClwEzatuclGSiFaA3FcajLNt
 CoWO5qg6Bnz4DzsvU+1RyzO+hCTpTC/AWGfV1ylWN9oEyjC9ZVbHgiArctuWol7s7Sl+s3t2y
 dCYr72xKXw0kq0iTs5hUKraWtNRfU6MoP08BX/+xRNF0mYWh/4Q4iZd1MWiLItE3erqKPPgJQ
 FjI/ut96Kbb0ruC0sq54VculvLbErAi3hIVkAjpuZMt5N444Zj0GKAQiSIjuk1e5wQldxXt/1
 hVjuuJ5t0d8ZqJQk46RBG8+cGJrFLbpz+R3FnzHeCi2kRMPfVpMp9w4CKTzh9Vv7hUwL/Q4nd
 2RBBCAZe97Gido1HPBaaGxNRPSItU8mOqvUpON0oLvW4yguigdpBVjHq3VWwCBs3k28K18n8x
 mzSmvvVETmlz4DqjAtVufNzURq0=
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

On 12.12.23 09:52, lukas.funke-oss@weidmueller.com wrote:
> From: Lukas Funke <lukas.funke@weidmueller.com>
>
> Forward '%p' format specifier to the underlying format logic in order
> to print pointers, especially bitmaps.
>
> Signed-off-by: Lukas Funke <lukas.funke@weidmueller.com>
> ---
>
> (no changes since v1)
>
>   cmd/printf.c | 29 +++++++++++++++++++++++++++++
>   1 file changed, 29 insertions(+)
>
> diff --git a/cmd/printf.c b/cmd/printf.c
> index 0c6887e0d6..a90c923871 100644
> --- a/cmd/printf.c
> +++ b/cmd/printf.c
> @@ -90,6 +90,7 @@
>   #include <stddef.h>
>   #include <stdio.h>
>   #include <stdlib.h>
> +#include <linux/bitmap.h>
>
>   #define WANT_HEX_ESCAPES 0
>   #define PRINT_CONVERSION_ERROR 1
> @@ -476,6 +477,16 @@ static int get_width_prec(const char *str)
>   	return (int)v;
>   }
>
> +static int print_pointer(struct print_inf *inf, char *format,
> +			 unsigned int fmt_length, const char *argument)
> +{
> +	u64 value =3D simple_strtoull(argument, NULL, 0);
> +
> +	printf_str(inf, format, &value);
> +
> +	return inf->error;
> +}
> +
>   /* Print the text in FORMAT, using ARGV for arguments to any '%' direc=
tives.
>    * Return advanced ARGV.
>    */
> @@ -536,6 +547,24 @@ static char **print_formatted(struct print_inf *inf=
, char *f, char **argv, int *
>   					}
>   				}
>   			}
> +			if (*f =3D=3D 'p') {
> +				static const char ptr_format_chars[] =3D "bl";
> +				++f;
> +				++direc_length;
> +				char *p =3D strchr(ptr_format_chars, *f);
> +				/* consume whole format token */
> +				while (*f !=3D '\0' && *(p++) =3D=3D *f) {
> +					++f;
> +					++direc_length;
> +				}
> +				if (print_pointer(inf, direc_start, direc_length, *argv++)) {
> +					printf("`%s': invalid format\n", direc_start);

There are different error codes. PRINT_TRUNCATED_ERROR does not indicate
an invalid format.

Best regards

Heinrich

> +					/* causes main() to exit with error */
> +					return saved_argv - 1;
> +				}
> +				f--;
> +				break;
> +			}
>
>   			/* Remove "lLhz" size modifiers, repeatedly.
>   			 * bash does not like "%lld", but coreutils

