Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9DB1E7718F
	for <u-boot@archiver.kernel.org>; Mon, 30 Dec 2024 10:04:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B65A380583;
	Mon, 30 Dec 2024 11:04:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="j6gwAahB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 340FC80584; Mon, 30 Dec 2024 11:04:10 +0100 (CET)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B29F080570
 for <u-boot@lists.denx.de>; Mon, 30 Dec 2024 11:04:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4363ae65100so94824115e9.0
 for <u-boot@lists.denx.de>; Mon, 30 Dec 2024 02:04:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735553047; x=1736157847; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=mO1cwEgrnLI6HW8gZiTzI9Lup5cyHku7r+TP1Ik0fPM=;
 b=j6gwAahBEk/t6dh5GZQ7xAzAS6YLD494i27SuY+188xZqnb4hp76gT6toFOjX/Vb8c
 V2s74LDq+HRmm5rfj5GpRom12J1zXCideyn9EvzPqYPVeAduwMd3sN395wCfYkftkdEf
 Fi0IxicitNad3DCaBl6nB/LDjnRN6fCurl/7Kws16b5odPB7byiP/uzq/lTDC8Vl3+gf
 cqaCnW7E609yYqk6t/wqBTYGWJi8oGzG/iB4KGQUYC90ATByfpgp6wmYpZu+wujaBmUq
 tKHlRgS4i49BKFp545GetdCgm0h4g89muM6CN8vt+8cUveVxYp+OVJHfSohurCQ+b6h4
 yJIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735553047; x=1736157847;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=mO1cwEgrnLI6HW8gZiTzI9Lup5cyHku7r+TP1Ik0fPM=;
 b=uWfn5n/Rg6iDd9X3yOWexfILVk+O5kmjfbD7asMOHpQQd3o+2tO9t5EF8h8NARd0+u
 FS8QISbcWY0DxA2IHxjrcHmVX76QA377d0XzYTg4bs/cZrEsj+M4Yzqzjtb5NiqEhOEU
 VyG+36uNKA3B3dayRTWQPrgHi5+paR9KQR0v/bVihMpgQKmQ7NIx81xXmoPtQCB9y5Rq
 mZSkxDIHTutjA833rbg3LvvUoEQ+wJosHb3HIdOVw2EqhwQGQcGnHB7L6IroChem2K8S
 VJ2QNULe0JdWjjF79FOOd10+WOksivLH/aPcLCkWIj1AVwbzs/FPiWDyOJx1ampjASVC
 5lew==
X-Forwarded-Encrypted: i=1;
 AJvYcCXWdoI+Hv7DrribJFdClZgdO4v9r5Ebwsc8x9Yxzmk47ZmkZbdvJ1OrYNQBHqxQhRtMI9/PMKw=@lists.denx.de
X-Gm-Message-State: AOJu0YxZ/TYzqf7QjbfixAo5zIBXsFBJtGmtZlPYvxNx5aLuyS5W74fS
 lnPMAAfTrdwRlASl837iAGV+srx+ukDM8zdq69KeXW47bEZB3ZK5pBAsHhF8zJ4=
X-Gm-Gg: ASbGnctkpsFzJtzjcDjazr/C8kN5608nhiWV0eV/daxREWKkdBZrbVWcyiwleEap1Xl
 EEoBeBP6yzwlBqTQ64g0ePFUBaB02qXYyr7Es5jbfDm3m2eGgG4BwW2rxY2Qx0Vgxdc1UBkntMJ
 ykxP3cxukMtdyWaoVJurenOCbc9yBFio3h/Ul2bbWFptZ5Feh3BawghQKlVTTm/xNEwmXWIlRMU
 vgV7A8Tfl1b1LovuDeYg5fmp0wEq8imYu2ovU/83M61VuiFXCyQ7KJ3aD+mO/3VgNOxJKJ6Q/r0
 gJ9xo2jYK5/yUuCtkq43ysYbzGCYIOFSDQ==
X-Google-Smtp-Source: AGHT+IH7B74xnhYgm084KPHYc9gf+O+Fr1fY8Kp0riO+r4BBEdYuBrWMCkJDvPnorB+6LPdbBekjcw==
X-Received: by 2002:a05:6000:4a01:b0:385:f996:1b8e with SMTP id
 ffacd0b85a97d-38a221ea879mr29610149f8f.16.1735553047011; 
 Mon, 30 Dec 2024 02:04:07 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:883b:3c16:2465:ad55?
 ([2a01:e0a:982:cbb0:883b:3c16:2465:ad55])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436612008casm351566585e9.14.2024.12.30.02.04.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Dec 2024 02:04:06 -0800 (PST)
Message-ID: <ee0df15e-0a75-474a-bddd-61fbaa9c8c05@linaro.org>
Date: Mon, 30 Dec 2024 11:04:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] board: odroid-n2: Add script and update docs for signing
To: =?UTF-8?Q?Baltaz=C3=A1r_Radics?= <baltazar.radics@gmail.com>,
 u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, u-boot-amlogic@groups.io
References: <20241223222308.22650-1-baltazar.radics@gmail.com>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <20241223222308.22650-1-baltazar.radics@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Reply-To: neil.armstrong@linaro.org
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi,

On 23/12/2024 23:23, Baltazár Radics wrote:
> The previous instructions resulted in a bootloader that wouldn't fit in
> an mbr gap. I have updated the docs based on upstream's build process.
> 
> Note that the script should be compatible with other g12 based odroid
> boards, but I'm unable to test those boards.
> 
> Signed-off-by: Baltazár Radics <baltazar.radics@gmail.com>
> ---
> 
>   doc/board/amlogic/odroid-n2.rst | 71 ++-------------------------------
>   tools/amlogic-odroidg12-sign.sh | 67 +++++++++++++++++++++++++++++++

I'm not a big fan of moving the instructions in a script,
the script is already avaible in the amlogic-boot-fip project,
so rather could you fix the documentation instead ?

Thanks,
Neil

>   2 files changed, 70 insertions(+), 68 deletions(-)
>   create mode 100755 tools/amlogic-odroidg12-sign.sh
> 
> diff --git a/doc/board/amlogic/odroid-n2.rst b/doc/board/amlogic/odroid-n2.rst
> index 883720f8fb..f81e8222f8 100644
> --- a/doc/board/amlogic/odroid-n2.rst
> +++ b/doc/board/amlogic/odroid-n2.rst
> @@ -54,10 +54,9 @@ image so it is necessary to obtain binaries from sources published by the board
>       $ tar xvfJ gcc-linaro-arm-none-eabi-4.8-2013.11_linux.tar.xz
>       $ export PATH=$PWD/gcc-linaro-aarch64-none-elf-4.8-2013.11_linux/bin:$PWD/gcc-linaro-arm-none-eabi-4.8-2013.11_linux/bin:$PATH
>   
> -    $ DIR=odroid-n2
> -    $ git clone --depth 1 https://github.com/hardkernel/u-boot.git -b odroidn2-v2015.01 $DIR
> +    $ git clone --depth 1 https://github.com/hardkernel/u-boot.git -b odroidg12-v2015.01 odroidg12
>   
> -    $ cd odroid-n2
> +    $ cd odroidg12
>       $ make odroidn2_defconfig
>       $ make
>       $ export UBOOTDIR=$PWD
> @@ -66,71 +65,7 @@ Go back to the mainline U-Boot source tree then:
>   
>   .. code-block:: bash
>   
> -    $ mkdir fip
> -
> -    $ wget https://github.com/BayLibre/u-boot/releases/download/v2017.11-libretech-cc/blx_fix_g12a.sh -O fip/blx_fix.sh
> -    $ cp $UBOOTDIR/build/scp_task/bl301.bin fip/
> -    $ cp $UBOOTDIR/build/board/hardkernel/odroidn2/firmware/acs.bin fip/
> -    $ cp $UBOOTDIR/fip/g12b/bl2.bin fip/
> -    $ cp $UBOOTDIR/fip/g12b/bl30.bin fip/
> -    $ cp $UBOOTDIR/fip/g12b/bl31.img fip/
> -    $ cp $UBOOTDIR/fip/g12b/ddr3_1d.fw fip/
> -    $ cp $UBOOTDIR/fip/g12b/ddr4_1d.fw fip/
> -    $ cp $UBOOTDIR/fip/g12b/ddr4_2d.fw fip/
> -    $ cp $UBOOTDIR/fip/g12b/diag_lpddr4.fw fip/
> -    $ cp $UBOOTDIR/fip/g12b/lpddr4_1d.fw fip/
> -    $ cp $UBOOTDIR/fip/g12b/lpddr4_2d.fw fip/
> -    $ cp $UBOOTDIR/fip/g12b/piei.fw fip/
> -    $ cp $UBOOTDIR/fip/g12b/aml_ddr.fw fip/
> -    $ cp u-boot.bin fip/bl33.bin
> -
> -    $ sh fip/blx_fix.sh \
> -         fip/bl30.bin \
> -         fip/zero_tmp \
> -         fip/bl30_zero.bin \
> -         fip/bl301.bin \
> -         fip/bl301_zero.bin \
> -         fip/bl30_new.bin \
> -         bl30
> -
> -    $ sh fip/blx_fix.sh \
> -         fip/bl2.bin \
> -         fip/zero_tmp \
> -         fip/bl2_zero.bin \
> -         fip/acs.bin \
> -         fip/bl21_zero.bin \
> -         fip/bl2_new.bin \
> -         bl2
> -
> -    $ $UBOOTDIR/fip/g12b/aml_encrypt_g12b --bl30sig --input fip/bl30_new.bin \
> -                                          --output fip/bl30_new.bin.g12a.enc \
> -                                          --level v3
> -    $ $UBOOTDIR/fip/g12b/aml_encrypt_g12b --bl3sig --input fip/bl30_new.bin.g12a.enc \
> -                                          --output fip/bl30_new.bin.enc \
> -                                          --level v3 --type bl30
> -    $ $UBOOTDIR/fip/g12b/aml_encrypt_g12b --bl3sig --input fip/bl31.img \
> -                                          --output fip/bl31.img.enc \
> -                                          --level v3 --type bl31
> -    $ $UBOOTDIR/fip/g12b/aml_encrypt_g12b --bl3sig --input fip/bl33.bin --compress lz4 \
> -                                          --output fip/bl33.bin.enc \
> -                                          --level v3 --type bl33 --compress lz4
> -    $ $UBOOTDIR/fip/g12b/aml_encrypt_g12b --bl2sig --input fip/bl2_new.bin \
> -                                          --output fip/bl2.n.bin.sig
> -    $ $UBOOTDIR/fip/g12b/aml_encrypt_g12b --bootmk \
> -                                          --output fip/u-boot.bin \
> -                                          --bl2 fip/bl2.n.bin.sig \
> -                                          --bl30 fip/bl30_new.bin.enc \
> -                                          --bl31 fip/bl31.img.enc \
> -                                          --bl33 fip/bl33.bin.enc \
> -                                          --ddrfw1 fip/ddr4_1d.fw \
> -                                          --ddrfw2 fip/ddr4_2d.fw \
> -                                          --ddrfw3 fip/ddr3_1d.fw \
> -                                          --ddrfw4 fip/piei.fw \
> -                                          --ddrfw5 fip/lpddr4_1d.fw \
> -                                          --ddrfw6 fip/lpddr4_2d.fw \
> -                                          --ddrfw7 fip/diag_lpddr4.fw \
> -                                          --ddrfw8 fip/aml_ddr.fw \
> -                                          --level v3
> +    $ ./tools/amlogic-odroidg12-sign.sh "$UBOOTDIR"
>   
>   Then write U-Boot to SD or eMMC with:
>   
> diff --git a/tools/amlogic-odroidg12-sign.sh b/tools/amlogic-odroidg12-sign.sh
> new file mode 100755
> index 0000000000..30a81e0374
> --- /dev/null
> +++ b/tools/amlogic-odroidg12-sign.sh
> @@ -0,0 +1,67 @@
> +#!/bin/sh -e
> +# SPDX-License-Identifier: GPL-2.0+
> +
> +error() {
> +	echo "$@" >&2
> +	exit 1
> +}
> +
> +[ $# -lt 1 ] && error "usage: $0 <built u-boot odroidg12> [out dir] [binary]"
> +
> +src=$1 # hardkernel's u-boot tree (built)
> +out=${2:-fip}
> +bl33=${3:-u-boot.bin}
> +
> +. "$src/build/include/config/auto.conf"
> +SOC=$CONFIG_SYS_SOC
> +BOARDDIR=board/$CONFIG_SYS_VENDOR/$CONFIG_SYS_BOARD
> +[ "$CONFIG_ODROID_N2L" = y ] && ddr='lp'
> +
> +fix_blx() {
> +	[ "$(wc -c <"$1")" -gt "$2" ] && error "Error: $1 too big."
> +	[ "$(wc -c <"$3")" -gt "$4" ] && error "Error: $2 too big."
> +
> +	cat "$1" /dev/zero | head -c "$2"
> +	cat "$3" /dev/zero | head -c "$4"
> +}
> +
> +encrypt_step() {
> +	"$src/fip/$SOC/aml_encrypt_$SOC" "$@"
> +}
> +
> +mkdir -p "$out"
> +
> +fix_blx \
> +	"$src/fip/$SOC/bl30.bin" 40960 \
> +	"$src/build/scp_task/bl301.bin" 13312 \
> +	>"$out/bl30_new.bin"
> +fix_blx \
> +	"$src/fip/$SOC/bl2.bin" 57344 \
> +	"$src/build/$BOARDDIR/firmware/acs.bin" 4096 \
> +	>"$out/bl2_new.bin"
> +
> +encrypt_step --bl30sig --level v3 \
> +	--input  "$out/bl30_new.bin" \
> +	--output "$out/bl30_new.bin.g12.enc"
> +encrypt_step --bl3sig --level v3 --type bl30 \
> +	--input  "$out/bl30_new.bin.g12.enc" \
> +	--output "$out/bl30_new.bin.enc"
> +encrypt_step --bl3sig --level v3 --type bl31 \
> +	--input  "$src/fip/$SOC/bl31.img" \
> +	--output "$out/bl31.img.enc"
> +encrypt_step --bl3sig --level v3 --type bl33 --compress lz4 \
> +	--input  "$bl33" \
> +	--output "$out/bl33.bin.enc"
> +encrypt_step --bl2sig \
> +	--input  "$out/bl2_new.bin" \
> +	--output "$out/bl2.n.bin.sig"
> +encrypt_step --bootmk --level v3 \
> +	--bl2  "$out/bl2.n.bin.sig" \
> +	--bl30 "$out/bl30_new.bin.enc" \
> +	--bl31 "$out/bl31.img.enc" \
> +	--bl33 "$out/bl33.bin.enc" \
> +	--ddrfw1 "$src/fip/$SOC/${ddr}ddr4_1d.fw" \
> +	--ddrfw2 "$src/fip/$SOC/${ddr}ddr4_2d.fw" \
> +	--ddrfw4 "$src/fip/$SOC/piei.fw" \
> +	--ddrfw8 "$src/fip/$SOC/aml_ddr.fw" \
> +	--output "$out/u-boot.bin"

