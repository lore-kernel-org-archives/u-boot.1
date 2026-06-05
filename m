Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 135C0CD6E7B
	for <u-boot@archiver.kernel.org>; Fri,  5 Jun 2026 08:05:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 545558486D;
	Fri,  5 Jun 2026 10:05:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="pBqufcsz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B17E8489D; Fri,  5 Jun 2026 10:05:10 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4CF8838BB
 for <u-boot@lists.denx.de>; Fri,  5 Jun 2026 10:05:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-490b9318997so11530005e9.2
 for <u-boot@lists.denx.de>; Fri, 05 Jun 2026 01:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780646707; x=1781251507; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt:cc
 :content-language:from:references:to:subject:reply-to:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=JR2bitoz0QCc1Yap2SKEioLTtT6EY9vPpNJiIckdNts=;
 b=pBqufcszwC/VYwyPvec1qJd5ToUD6FvkhoxaESAtJAjqEuHQeLoCHT71F6b26ovW42
 xk9heXwPE+W2yhmvm0g/sB9mWQ82oHNSPmzB09haJEOQgzrybkdY4bAsjLkSkNXqTOw+
 ypRnW2VUoRXdqk0UW7Ak7N0Q3kX8yVcPmhNyKegzXRWafRM6FRImI5zBOiA/7dmHlQkf
 3drSANhfWntqjhylsf2PMGyaaYtxYZQaenW4uIH5Dhsj7vPAZp0Xk97RrZU9omGmuH3H
 Gka1FUa3Nsw4HXZrBF1Ub7eMReEzM5osqzBbe7pd6p/XBT/PDSb86snKMWGglpBWVCfv
 7/bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780646707; x=1781251507;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt:cc
 :content-language:from:references:to:subject:reply-to:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JR2bitoz0QCc1Yap2SKEioLTtT6EY9vPpNJiIckdNts=;
 b=SVSEKq9hOgUOLqwBBkMCE0Z+PrMV7yaQc6FS1uEWirJDvkIjNqVHBY0my2H6xuvzrw
 OPR2hGtOtibIqKUWhn1yrQwHKCt5/ktY9auTVTKHKlJrzgro/9QZ/iUw+L0R8tbF12Qc
 Lowf+ABxUpqMcaoStDQxIm18PzBs1GFzeK0EuaK9qhuAn0XxNCAZOm3DNU1CPlqVywLu
 718WOCVkmJvqHTrlkFiZ2ALHY1haMvHqtgtNwex1PZy1JPVPOVdbZF8xugpUtIGs5IYy
 ypQQN4msePyeFWTDDqa4Hh6moMvU1nHsFhHhiwgcBVDqWI01THGzXHkhidYK/I+dtieK
 uPXA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8soE8G6GVD/vkV3CG3RPynLk/ArO9hyp5R+9DZHDOB0198zX2Fdhx5j1NtnKvsmwpXiz5u57Y=@lists.denx.de
X-Gm-Message-State: AOJu0YydwiTZfs4rJFVWeCJzhYF7ot79u+mDdyELxlzRTrxK2e2VdrCQ
 mZlxbAlqPbN7D49+aC4SvwhM5AqYKQA5F1Rt7zHg1i27b4BumJhp+SEufUoeeirf/xm9RNNL9fx
 ykuVKhX4=
X-Gm-Gg: Acq92OFkmbK2ykkaSrVUglPA0uq1bIS2rtwgT5TKPU0058WtjUQHXUACTOIJZesou4a
 FaR8+sIAHm7fZcgH7Wq5NVLEiD4QIETejCqdspn7mCqfs3J1Mhj+bpQVXO6IzZLVEQxJyznfylh
 rSvVwVnDahRuOc9NLSGU0GQYRGIM+he3EBRJ5cM5SUdRHAZlskDOj5kzd6T5nb5W3EucGA5RBjU
 YU995YaJT7oCsIaV1aDOn1MbC3JfPfBmi7MG7gyqfYxWrGLbTJHcYJm2NmkwbC1cC4cUnjdF0uS
 rjBuSUscU5f7IpCZKOrbLT0hdrmckCTnmB5tlAfyyJVumJg3LCQPksCutlT6j1Q1Ygv8cUWB79O
 ipSzRX987WHeNaVcVWafCPMF0Jv8udmN2/E5EnHxuTh1d97pF25FQJUowQou76hwYJ06bELjPm1
 IpXiiadlY/hG9nzoptPxbReR6gS57eYwtA3Ntm02ybFw6yGJrQ29YiOPxzfrSacsaaHTpYxBfVz
 /4CX5mL31mOJ0UpdA==
X-Received: by 2002:a05:600c:37c9:b0:490:a296:fdad with SMTP id
 5b1f17b1804b1-490c2600e5amr33841165e9.24.1780646706887; 
 Fri, 05 Jun 2026 01:05:06 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:b06c:5480:fdc5:c668?
 ([2a01:e0a:106d:1080:b06c:5480:fdc5:c668])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2f2710sm18345458f8f.14.2026.06.05.01.05.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Jun 2026 01:05:06 -0700 (PDT)
Message-ID: <a79659e0-d2be-48bc-8a82-8b74847490b7@linaro.org>
Date: Fri, 5 Jun 2026 10:05:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] doc: boards: amlogic: update documentation for Beelink
 GT1 Ultimate
To: Karl Chan <exxxxkc@getgoogleoff.me>, u-boot@lists.denx.de
References: <20260605075617.6690-1-exxxxkc@getgoogleoff.me>
From: Neil Armstrong <neil.armstrong@linaro.org>
Content-Language: en-US, fr
Cc: "u-boot-amlogic@groups.io" <u-boot-amlogic@groups.io>
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
In-Reply-To: <20260605075617.6690-1-exxxxkc@getgoogleoff.me>
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
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi,

On 6/5/26 09:56, Karl Chan wrote:
> fix formating

Missing u-boot-amlogic@groups.io and myself in recipient, and please make a little more effort in the commit message...

Thanks,
Neil

> 
> Signed-off-by: Karl Chan <exxxxkc@getgoogleoff.me>
> ---
>   doc/board/amlogic/beelink-gt1-ultimate.rst | 104 ++++++++++-----------
>   1 file changed, 52 insertions(+), 52 deletions(-)
> 
> diff --git a/doc/board/amlogic/beelink-gt1-ultimate.rst b/doc/board/amlogic/beelink-gt1-ultimate.rst
> index a78a1a2ff25..22afae0ed40 100644
> --- a/doc/board/amlogic/beelink-gt1-ultimate.rst
> +++ b/doc/board/amlogic/beelink-gt1-ultimate.rst
> @@ -30,19 +30,19 @@ U-Boot Compilation
>   
>   .. code-block:: bash
>   
> -    $ export CROSS_COMPILE=aarch64-none-elf-
> -    $ make beelink-gt1-ultimate_defconfig
> -    $ make
> +    $ export CROSS_COMPILE=aarch64-none-elf-
> +    $ make beelink-gt1-ultimate_defconfig
> +    $ make
>   
>   U-Boot Signing with Pre-Built FIP repo
>   --------------------------------------
>   
>   .. code-block:: bash
>   
> -    $ git clone https://github.com/LibreELEC/amlogic-boot-fip --depth=1
> -    $ cd amlogic-boot-fip
> -    $ mkdir my-output-dir
> -    $ ./build-fip.sh beelink-gt1 /path/to/u-boot/u-boot.bin my-output-dir
> +    $ git clone https://github.com/LibreELEC/amlogic-boot-fip --depth=1
> +    $ cd amlogic-boot-fip
> +    $ mkdir my-output-dir
> +    $ ./build-fip.sh beelink-gt1 /path/to/u-boot/u-boot.bin my-output-dir
>   
>   U-Boot Manual Signing
>   ---------------------
> @@ -53,58 +53,58 @@ for signing. However you can download them from the amlogic-fip-repo.
>   
>   .. code-block:: bash
>   
> -    $ git clone https://github.com/LibreELEC/amlogic-boot-fip --depth=1
> -    $ cd amlogic-boot-fip/beelink-gt1
> -    $ export FIPDIR=$PWD
> +    $ git clone https://github.com/LibreELEC/amlogic-boot-fip --depth=1
> +    $ cd amlogic-boot-fip/beelink-gt1
> +    $ export FIPDIR=$PWD
>   
>   Go back to the mainline U-Boot source tree then:
>   
>   .. code-block:: bash
>   
> -    $ mkdir fip
> -    $ cp $FIPDIR/bl2.bin fip/
> -    $ cp $FIPDIR/acs.bin fip/
> -    $ cp $FIPDIR/bl21.bin fip/
> -    $ cp $FIPDIR/bl30.bin fip/
> -    $ cp $FIPDIR/bl301.bin fip/
> -    $ cp $FIPDIR/bl31.img fip/
> -    $ cp u-boot.bin fip/bl33.bin
> -
> -    $ $FIPDIR/blx_fix.sh \
> -              fip/bl30.bin \
> -              fip/zero_tmp \
> -              fip/bl30_zero.bin \
> -              fip/bl301.bin \
> -              fip/bl301_zero.bin \
> -              fip/bl30_new.bin \
> -              bl30
> -
> -    $ python $FIPDIR/acs_tool.pyc fip/bl2.bin fip/bl2_acs.bin fip/acs.bin 0
> -
> -    $ $FIPDIR/blx_fix.sh \
> -              fip/bl2_acs.bin \
> -              fip/zero_tmp \
> -              fip/bl2_zero.bin \
> -              fip/bl21.bin \
> -              fip/bl21_zero.bin \
> -              fip/bl2_new.bin \
> -              bl2
> -
> -    $ $FIPDIR/aml_encrypt_gxl --bl3enc --input fip/bl30_new.bin
> -    $ $FIPDIR/aml_encrypt_gxl --bl3enc --input fip/bl31.img
> -    $ $FIPDIR/aml_encrypt_gxl --bl3enc --input fip/bl33.bin
> -    $ $FIPDIR/aml_encrypt_gxl --bl2sig --input fip/bl2_new.bin --output fip/bl2.n.bin.sig
> -    $ $FIPDIR/aml_encrypt_gxl --bootmk \
> -                              --output fip/u-boot.bin \
> -                              --bl2 fip/bl2.n.bin.sig \
> -                              --bl30 fip/bl30_new.bin.enc \
> -                              --bl31 fip/bl31.img.enc \
> -                              --bl33 fip/bl33.bin.enc
> +    $ mkdir fip
> +    $ cp $FIPDIR/bl2.bin fip/
> +    $ cp $FIPDIR/acs.bin fip/
> +    $ cp $FIPDIR/bl21.bin fip/
> +    $ cp $FIPDIR/bl30.bin fip/
> +    $ cp $FIPDIR/bl301.bin fip/
> +    $ cp $FIPDIR/bl31.img fip/
> +    $ cp u-boot.bin fip/bl33.bin
> +
> +    $ $FIPDIR/blx_fix.sh \
> +              fip/bl30.bin \
> +              fip/zero_tmp \
> +              fip/bl30_zero.bin \
> +              fip/bl301.bin \
> +              fip/bl301_zero.bin \
> +              fip/bl30_new.bin \
> +              bl30
> +
> +    $ python $FIPDIR/acs_tool.pyc fip/bl2.bin fip/bl2_acs.bin fip/acs.bin 0
> +
> +    $ $FIPDIR/blx_fix.sh \
> +              fip/bl2_acs.bin \
> +              fip/zero_tmp \
> +              fip/bl2_zero.bin \
> +              fip/bl21.bin \
> +              fip/bl21_zero.bin \
> +              fip/bl2_new.bin \
> +              bl2
> +
> +    $ $FIPDIR/aml_encrypt_gxl --bl3enc --input fip/bl30_new.bin
> +    $ $FIPDIR/aml_encrypt_gxl --bl3enc --input fip/bl31.img
> +    $ $FIPDIR/aml_encrypt_gxl --bl3enc --input fip/bl33.bin
> +    $ $FIPDIR/aml_encrypt_gxl --bl2sig --input fip/bl2_new.bin --output fip/bl2.n.bin.sig
> +    $ $FIPDIR/aml_encrypt_gxl --bootmk \
> +                              --output fip/u-boot.bin \
> +                              --bl2 fip/bl2.n.bin.sig \
> +                              --bl30 fip/bl30_new.bin.enc \
> +                              --bl31 fip/bl31.img.enc \
> +                              --bl33 fip/bl33.bin.enc
>   
>   Then write U-Boot to SD or eMMC with:
>   
>   .. code-block:: bash
>   
> -    $ DEV=/dev/boot_device
> -    $ dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=512 skip=1 seek=1
> -    $ dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=1 count=440
> +    $ DEV=/dev/boot_device
> +    $ dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=512 skip=1 seek=1
> +    $ dd if=fip/u-boot.bin.sd.bin of=$DEV conv=fsync,notrunc bs=1 count=440

