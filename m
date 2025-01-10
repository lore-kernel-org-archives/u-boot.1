Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE7FFE77188
	for <u-boot@archiver.kernel.org>; Fri, 10 Jan 2025 13:50:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 588A2801F5;
	Fri, 10 Jan 2025 14:50:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="IkVhqgtR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 86A458036B; Fri, 10 Jan 2025 14:50:46 +0100 (CET)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4532800D0
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 14:50:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-38633b5dbcfso2103114f8f.2
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 05:50:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736517043; x=1737121843; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=19dZ0vvC9UHMg3CGyyhDaeLs4xds3eo7VpvKyDa6RiM=;
 b=IkVhqgtRpKkcM59RvmZnEH9mrUlH/ibRpuONERcpThopxbQ77XQZlL3sXav+OqFDK6
 qpDfJodJds71nrE5na/dOotYkJY3yHHPNCUT+GR2+EQ35kItYTDQC7scaYsH4sX5oeTD
 aUwdFX0tYPCWra3Id8Y1XPQpa8DBeMtux/xrAJVzMq24n+W7xPoqUeona0PPE0wqFxy4
 EI4zwKgY1/8dog/XcbI4MjcLWiiDmxIf4GUhpLuJJeKSHDJGL3nwIeiSAPT3ivNo3z5g
 9Uh+3ebTMEpeJLOQwO/2dnyWoIDpMdfwojkuXv3gC5EODxD+S+K8YXuTQ6lhGpi78GEm
 JcgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736517043; x=1737121843;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=19dZ0vvC9UHMg3CGyyhDaeLs4xds3eo7VpvKyDa6RiM=;
 b=RkYcoScU5KndWmMU6aInOZOXna8eutlnKIy4u8P+/DoYi2fnGwRMmmk0ZX86zkt8XD
 Imc1l80Sxeu0S7nJWr7XoPCouDxl583aAFYy0B5slNUh7Z5MuT8WFbMyyPSSWXkAAXMX
 I48d90gIHOwj5FAl+iVFnogyIwcTU+Q1erppCpNZYDvAk7S0QX4P4IgeZ9CDEesCnyFL
 zt8hV5GSAEES1B8HxrZcc3aOPvdjX/oeu0Ezci/UeW7TlVtf+ogIpYqGYLZQEDEaidvP
 gF4LXplEPaFs1TON04vUBsJtLmVAUTO9nwB9QD8YZSr9CiL05Gb33TJzd1lAeEbxgu2D
 Oc/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCU30XIkr5sdggIh28xXDCZM026hjsiN4ETk4MXVteILpg4VAO6OngOiLfSMSSzqVZ8BtprSVhA=@lists.denx.de
X-Gm-Message-State: AOJu0YxrAQlpr1RrFbW0pRvGNxFV2NssvFYa6m200UET6TQMdSjO5LnT
 JdqM4JCngo8cAqYH2L16IERk7nO9Qk+b/DKMN2DkluZdb7s5zFjj8epPyXldEyo=
X-Gm-Gg: ASbGncuFGPXBtQLtvU87u01+qUyMep5o9bqbPGhsdltw+auL3D6WMLjhdnD++zpPg0J
 dXvaOEiCBnhNLyJXpyDt0cErF+h3uHQak7N+mYNqL6Dx8pPOLfWeQvxf+zZHLmObwickSfAMkYw
 cRW+rAf+sqAc2vRp8yUa8Pl014Z5d511mSk6LTSMsp+9Spr6uIDV+58Ne87D/FsFp8rw3o86w1G
 6GuxLih4Pd8VT/uksNdgnjnXyjGXi6emrUGIJv+WtMFsKR6TOHDBCF/pDatVcySdG/FRcV74UpI
 7NjwCuzVz8ZpeewIbAzNSg04GSuiE7KFmQ==
X-Google-Smtp-Source: AGHT+IF1/kW2WEsbM9xyHRkyN9eWb0jwtARBK0ITq8iZ9fN0Cci8gwFM+mm7fkjEiOVL2CAgEQASHw==
X-Received: by 2002:a05:6000:186e:b0:385:dc45:ea22 with SMTP id
 ffacd0b85a97d-38a87338d84mr11847897f8f.39.1736517043289; 
 Fri, 10 Jan 2025 05:50:43 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:bf4e:5758:59ef:deb8?
 ([2a01:e0a:982:cbb0:bf4e:5758:59ef:deb8])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e38ef6asm4708475f8f.60.2025.01.10.05.50.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jan 2025 05:50:42 -0800 (PST)
Message-ID: <095fd831-8ce3-4edd-a722-c0fde2f50932@linaro.org>
Date: Fri, 10 Jan 2025 14:50:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2] board: odroid-n2: Update docs for signing
To: =?UTF-8?Q?Baltaz=C3=A1r_Radics?= <baltazar.radics@gmail.com>,
 u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, u-boot-amlogic@groups.io
References: <20250110111335.9221-1-baltazar.radics@gmail.com>
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
In-Reply-To: <20250110111335.9221-1-baltazar.radics@gmail.com>
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

On 10/01/2025 12:11, Baltazár Radics wrote:
> The previous instructions resulted in a bootloader that wouldn't fit in
> an MBR gap. I have updated the docs based on upstream's build process.
> 
> Signed-off-by: Baltazár Radics <baltazar.radics@gmail.com>
> ---
> 
>   doc/board/amlogic/odroid-n2.rst | 15 +++------------
>   1 file changed, 3 insertions(+), 12 deletions(-)
> 
> diff --git a/doc/board/amlogic/odroid-n2.rst b/doc/board/amlogic/odroid-n2.rst
> index 883720f8fb..5222a21c80 100644
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
> @@ -74,12 +73,8 @@ Go back to the mainline U-Boot source tree then:
>       $ cp $UBOOTDIR/fip/g12b/bl2.bin fip/
>       $ cp $UBOOTDIR/fip/g12b/bl30.bin fip/
>       $ cp $UBOOTDIR/fip/g12b/bl31.img fip/
> -    $ cp $UBOOTDIR/fip/g12b/ddr3_1d.fw fip/
>       $ cp $UBOOTDIR/fip/g12b/ddr4_1d.fw fip/
>       $ cp $UBOOTDIR/fip/g12b/ddr4_2d.fw fip/
> -    $ cp $UBOOTDIR/fip/g12b/diag_lpddr4.fw fip/
> -    $ cp $UBOOTDIR/fip/g12b/lpddr4_1d.fw fip/
> -    $ cp $UBOOTDIR/fip/g12b/lpddr4_2d.fw fip/
>       $ cp $UBOOTDIR/fip/g12b/piei.fw fip/
>       $ cp $UBOOTDIR/fip/g12b/aml_ddr.fw fip/
>       $ cp u-boot.bin fip/bl33.bin
> @@ -113,7 +108,7 @@ Go back to the mainline U-Boot source tree then:
>                                             --level v3 --type bl31
>       $ $UBOOTDIR/fip/g12b/aml_encrypt_g12b --bl3sig --input fip/bl33.bin --compress lz4 \
>                                             --output fip/bl33.bin.enc \
> -                                          --level v3 --type bl33 --compress lz4
> +                                          --level v3 --type bl33
>       $ $UBOOTDIR/fip/g12b/aml_encrypt_g12b --bl2sig --input fip/bl2_new.bin \
>                                             --output fip/bl2.n.bin.sig
>       $ $UBOOTDIR/fip/g12b/aml_encrypt_g12b --bootmk \
> @@ -124,11 +119,7 @@ Go back to the mainline U-Boot source tree then:
>                                             --bl33 fip/bl33.bin.enc \
>                                             --ddrfw1 fip/ddr4_1d.fw \
>                                             --ddrfw2 fip/ddr4_2d.fw \
> -                                          --ddrfw3 fip/ddr3_1d.fw \
>                                             --ddrfw4 fip/piei.fw \
> -                                          --ddrfw5 fip/lpddr4_1d.fw \
> -                                          --ddrfw6 fip/lpddr4_2d.fw \
> -                                          --ddrfw7 fip/diag_lpddr4.fw \
>                                             --ddrfw8 fip/aml_ddr.fw \
>                                             --level v3
>   

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
