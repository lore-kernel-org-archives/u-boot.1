Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB4BAC36018
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 18:12:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 736F182F65;
	Mon,  7 Apr 2025 20:12:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="CZ0FGYzm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B82C982F65; Mon,  7 Apr 2025 20:12:29 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 93EA482F08
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 20:12:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43d0782d787so32362155e9.0
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 11:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744049547; x=1744654347; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=OwOArh5pmnvBqwueMMh2wdNHAkdXUJ3g89H3voSywIc=;
 b=CZ0FGYzmQC2lhZEqyJKqqy3AggooGgDSsgKhk6RieAIPh4Sjm2wyDcZta5dR7VZMd3
 vjvk2KoY7TnlreGQJLmHBhJ8xi3iJ9tg1IWHY8zlJRe3gpvqzJB+uAPY/DupBaqYnyfM
 OAx5be0/n9Y62zcutSeUV0ihvU5kYWUUqQlJf0JocWwyBeuWcepIGoLS9tZ3NuXidp+T
 kdxriWuTKBG1CYSYPOE+uwVDKlSCzpW+CvFCG8ARm9pIyP76IpYdcsMJ+ud0xFSVsit+
 sPAR+XkIObYNzHJcYc2eAkwBkbsCfV0LOIJ0cvRFotAbpBRF5wF475VwI62PfEKJe1CE
 UsPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744049547; x=1744654347;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=OwOArh5pmnvBqwueMMh2wdNHAkdXUJ3g89H3voSywIc=;
 b=a6fH2BTw3yf9nKQSdzAxsQELL3PjBBDyBXl5mKUPix6ZSfCBqhvLBV/lS1jj6GoPWc
 zv8EAvuqNfm1F6eOM7tnsk/vDswymgNfhAzyUsCVyb/jEoah/OWoneuh0edxKh8LOk2s
 mc9YQ2t/4XVvCp3cZ6JJMGUyQmgqN8eih3GEmY1AZSV+45c5Nyv/S75BBfDIXqvTKUVx
 RKZ/dCza1aY9vd+58htN8RaaDu1Nc6gr5CO4AxNa01V8FhxiMeuThb2UcIhSRlGT//I5
 7KxRRDraiqXxyx/NSp/J81nfTt/gdY3zbMY+bnuht4iD6q+tLYa52mFEJoikJhb0u1Bk
 Bf7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3IOQE9dMy62tFjx1qubU+UxRBOQ2BY/1elipjRov8/GQqJPB8aJ/mlqXycGZG7A2PR/L4s2o=@lists.denx.de
X-Gm-Message-State: AOJu0YwRiD9yH5usLgB7lC4btaSjll28MgfhlvqnP8bPpyh4xz4Noz9P
 PcR/yuXST+qQKUCzeX/jEJHUhOtOga7brhc9HijWkPSqx5Z7tLWbcez6oGLQQz0=
X-Gm-Gg: ASbGncv1lsUPUtqSUJULHnl0KBtOIxycFp/jYw0jZ53xbSKDfqeYMGXNZVPEvx3Hbmc
 aY6OiVIPFZKS1kzkU/RNGpAW1UxYWdyMeK5Pmdrg7Gv4mZcvvj3rH6rIyOKd/XF94pFenI83eSy
 +YtTyvH5OI13gTt7zyhsv0QN3doXYMjvlHtVw0PMAX3iRtk0ri0awEw/zK+eVNb8X61PgtFDZr1
 5CU0+tG82pttsRGi/1Twe3W7J4o/G9+ObU0z5Tv6qa9IbVyiEv/CRJTqeXXRWK3iU2IRaxaJwK6
 Nk0ID2KpkJ+R8HpGmxrceFICcW7rYmYNhS1MgWCbvNV8YA4Jc8a4dBxCFBgao9cmJy7QftnbqL8
 JIwgtxqF3Tii3UjWILR78xA==
X-Google-Smtp-Source: AGHT+IHzKoqQzyphZ0sbXB5XXUhPdfplN7oURQCTt227X04k1U9ZojuJXZ+/iJ7z1vFouR7UlLEXCg==
X-Received: by 2002:a05:600c:4e09:b0:43d:83a:417d with SMTP id
 5b1f17b1804b1-43ed0bf6c17mr121529995e9.12.1744049547064; 
 Mon, 07 Apr 2025 11:12:27 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:f2a4:b974:cba3:a605?
 ([2a01:e0a:3d9:2080:f2a4:b974:cba3:a605])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec34af0e6sm139361485e9.16.2025.04.07.11.12.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Apr 2025 11:12:26 -0700 (PDT)
Message-ID: <d830d22b-6cb7-4971-b87b-51d5a2da21ed@linaro.org>
Date: Mon, 7 Apr 2025 20:12:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 05/13] board: dragonboard410c: Drop reflash functionality
To: Stephan Gerhold <stephan.gerhold@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Ramon Fried <rfried.dev@gmail.com>,
 Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.denx.de,
 u-boot-qcom@groups.io, Sam Day <me@samcday.com>
References: <20250407-db410c-fixes-v1-0-524aefbc8bb4@linaro.org>
 <20250407-db410c-fixes-v1-5-524aefbc8bb4@linaro.org>
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
In-Reply-To: <20250407-db410c-fixes-v1-5-524aefbc8bb4@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 07/04/2025 18:59, Stephan Gerhold wrote:
> This is broken ever since we switched to using U-Boot as first stage
> bootloader. Since no one seems to test this actively, let's just drop this
> entirely. There are other tools available for re-flashing the DB410c.
> 
> Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
> ---
>   board/qualcomm/dragonboard410c/dragonboard410c.env | 26 ----------------------
>   1 file changed, 26 deletions(-)
> 
> diff --git a/board/qualcomm/dragonboard410c/dragonboard410c.env b/board/qualcomm/dragonboard410c/dragonboard410c.env
> index 9d9a575a0c3f7a4739e4fb77a980d742e10510f5..57a30031f743f43d4a6389286b426b404d2f371b 100644
> --- a/board/qualcomm/dragonboard410c/dragonboard410c.env
> +++ b/board/qualcomm/dragonboard410c/dragonboard410c.env
> @@ -1,30 +1,4 @@
>   /* SPDX-License-Identifier: GPL-2.0+ */
> -
> -/* Does what recovery does */
> -#define REFLASH(file, partnum) \
> -part start mmc 0 partnum start && \
> -part size mmc 0 partnum size && \
> -tftp $loadaddr file &&  \
> -mmc write $loadaddr $start $size &&
> -
> -reflash=
> -mmc dev 0 &&
> -usb start &&
> -dhcp &&
> -tftp $loadaddr dragonboard/rescue/gpt_both0.bin &&
> -mmc write $loadaddr 0 43 &&
> -mmc rescan &&
> -REFLASH(dragonboard/rescue/NON-HLOS.bin, 1)
> -REFLASH(dragonboard/rescue/sbl1.mbn, 2)
> -REFLASH(dragonboard/rescue/rpm.mbn, 3)
> -REFLASH(dragonboard/rescue/tz.mbn, 4)
> -REFLASH(dragonboard/rescue/hyp.mbn, 5)
> -REFLASH(dragonboard/rescue/sec.dat, 6)
> -REFLASH(dragonboard/rescue/emmc_appsboot.mbn, 7)
> -REFLASH(dragonboard/u-boot.img, 8)
> -usb stop &&
> -echo Reflash completed
> -
>   loadaddr=0x81000000
>   initrd_high=0xffffffffffffffff
>   linux_image=Image
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
