Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFE4FCDB46E
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 14:45:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 03B5685DE0;
	Thu, 12 Oct 2023 16:45:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="V4nXX8Nz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 314FC86C61; Thu, 12 Oct 2023 16:45:54 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D83E985DE0
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 16:45:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-406650da82bso10690375e9.3
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 07:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697121950; x=1697726750; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=RQmvVMs1lpKB7yKsOR+g1RA9u6SfgTKAAqZIoZf4Wcw=;
 b=V4nXX8NzUUF6/lC8vhCwTV7bT95v2g+D/6Kp7brqb8yXQukvU4LHmMSbde3qg4EXYy
 zxQx5827a4+yrOgE556b9bx8meJ2lrE8A9/JtVL3on50dkuCx5+dv7Rbk+O2DBdrlt2o
 O7//TdtLpmWi09kTrz4Moy/PYV80K7JT72eW+KgVgDzjN334bCwyCxRTVzmfkKU9C1lO
 LcUJszutI3eJ86L7AkSG8vTt8NgdMNJmHeWDWlut4cSwDtThVkADtdlZcOXYM04nVvax
 oYtHU2ZjjSplD3X+o264Umw2+j8FlZ/v84IENeQZYsE6imTl8HIXnToXLnTy55KXBEZv
 +y/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697121950; x=1697726750;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=RQmvVMs1lpKB7yKsOR+g1RA9u6SfgTKAAqZIoZf4Wcw=;
 b=b9UVSTS8qcH3k1RoG0GPdVn7ELkVCcINsj8j1nsfsSWDbY4GBklcE4JqVJJ/ovzUoc
 2c9zLiz4ZCUBH1fGFSCWruh2sOvTUAbBBOxkHZ9ifKyeeTR3BXcJrE137CaMbnL5XB/P
 6TLH4lrtwcE3wkXIvMc0VPeOkxEDv+SaWCW0tNkftMhU6o1DQKojOwtO/nkPrbRvCGrY
 /u3H+tjShhlfvx1zbT4Uhu1PTR90LUmy0fpYdV0iaKFZN35b9ADvWz9G9xPDPm8Jt6GP
 Nh4+Ljly3Ql/Qr4ehH9u8qPvuDEDTje7alDTr8Fi5k4xSfkN3oSN3+5BRXBooK3leZ3/
 1FMQ==
X-Gm-Message-State: AOJu0Yz4mexkpq16uQ/lIYjbd5dOprUuWHaKoRx9TPrS0wR/Uq2auCqE
 Qh9zznTEApkNL5hOMKJwfon5yA==
X-Google-Smtp-Source: AGHT+IFFrAJoMELUKze5PydgjoRb5eegygb5r63fmYXvuvBrYrhOHSdpotJG8YBgWfSuMxQJU5ccLg==
X-Received: by 2002:a5d:484a:0:b0:320:1d1:71c4 with SMTP id
 n10-20020a5d484a000000b0032001d171c4mr21313209wrs.23.1697121950186; 
 Thu, 12 Oct 2023 07:45:50 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:d423:df8b:7f17:7909?
 ([2a01:e0a:982:cbb0:d423:df8b:7f17:7909])
 by smtp.gmail.com with ESMTPSA id
 bq6-20020a5d5a06000000b0032d895d24desm4223559wrb.65.2023.10.12.07.45.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Oct 2023 07:45:49 -0700 (PDT)
Message-ID: <c6a96994-71f7-4b27-8d95-42f6003512c3@linaro.org>
Date: Thu, 12 Oct 2023 16:45:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH v3 0/8] Add SM uclass and Meson SM driver
Content-Language: en-US, fr
To: Alexey Romanov <avromanov@salutedevices.com>, narmstrong@baylibre.com,
 sjg@google.com, takahiro.akashi@linaro.org, ilias.apalodimas@linaro.org,
 post@lespocky.de, marex@denx.de, msuchanek@suse.de, sughosh.ganu@linaro.org,
 jh80.chung@samsung.com, paul.barker@sancloud.com
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de, kernel@sberdevices.ru
References: <20230921081346.22157-1-avromanov@salutedevices.com>
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
Organization: Linaro Developer Services
In-Reply-To: <20230921081346.22157-1-avromanov@salutedevices.com>
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

Hi,

On 21/09/2023 10:13, Alexey Romanov wrote:
> Hello!
> 
> At the moment, there is no single general approach to using
> secure monitor in U-Boot, there is only the smc_call() function,
> over which everyone builds their own add-ons. This patchset
> is designed to solve this problem by adding a new uclass -
> SM_UCLASS. This UCLASS export following generic API:
> 
> 1. sm_call() - generic SMC call to the secure-monitor
> 2. sm_call_read() - retrieve data from secure-monitor
> 3. sm_call_write() - send data to secure-monitor
> 
> In the future, it is necessary to completely get rid of raw
> smc_call() calls, replacing them with the use of SM_UCLASS
> based drivers.
> 
> V2:
> 
> - Add SM UCLASS
> - Add SM sandbox driver
> - Add test for sandbox driver
> - Meson Secure Monitor driver now based on SM_UCLASS
> - Fix include order in arch/arm/mach-meson/sm.c
> 
> Also, during the discussion in V1 of this patchset, it was
> discussed to create MESON_SM_UCLASS, but I considered such
> a uclass to be too arch-specific. That's why I suggest
> SM_UCLASS, which is not so arch-specific: secure monitor can
> used for whole ARM devices, not only for Amlogic SoC's.
> 
> V3:
> 
> - Fix typos in commit messages
> - Use uclass_first_device_err() instead of uclass_get_device_by_name()
> - Return -ENOSYS instead of -EPROTONOSUPPORT if SM_UCLASS option not
> implemented
> 
> Alexey Romanov (8):
>    drivers: introduce Secure Monitor uclass
>    sandbox: add sandbox sm uclass driver
>    sandbox: dts: add meson secure monitor node
>    sandbox: add tests for UCLASS_SM
>    sandbox: defconfig: enable CONFIG_SM option
>    drivers: introduce Meson Secure Monitor driver
>    arch: meson: sm: set correct order of the includes
>    arch: meson: use secure monitor driver
> 
>   MAINTAINERS                 |   1 +
>   arch/arm/mach-meson/Kconfig |   1 +
>   arch/arm/mach-meson/sm.c    | 116 +++++++++++----------
>   arch/sandbox/dts/test.dts   |   4 +
>   configs/sandbox_defconfig   |   1 +
>   drivers/Kconfig             |   2 +
>   drivers/Makefile            |   1 +
>   drivers/sm/Kconfig          |   9 ++
>   drivers/sm/Makefile         |   5 +
>   drivers/sm/meson-sm.c       | 198 ++++++++++++++++++++++++++++++++++++
>   drivers/sm/sandbox-sm.c     |  76 ++++++++++++++
>   drivers/sm/sm-uclass.c      |  55 ++++++++++
>   include/dm/uclass-id.h      |   1 +
>   include/meson/sm.h          |  19 ++++
>   include/sandbox-sm.h        |  18 ++++
>   include/sm-uclass.h         |  72 +++++++++++++
>   include/sm.h                |  67 ++++++++++++
>   test/dm/Makefile            |   1 +
>   test/dm/sm.c                |  65 ++++++++++++
>   19 files changed, 656 insertions(+), 56 deletions(-)
>   create mode 100644 drivers/sm/Kconfig
>   create mode 100644 drivers/sm/Makefile
>   create mode 100644 drivers/sm/meson-sm.c
>   create mode 100644 drivers/sm/sandbox-sm.c
>   create mode 100644 drivers/sm/sm-uclass.c
>   create mode 100644 include/meson/sm.h
>   create mode 100644 include/sandbox-sm.h
>   create mode 100644 include/sm-uclass.h
>   create mode 100644 include/sm.h
>   create mode 100644 test/dm/sm.c
> 

This serie breaks other boards:
+binman: Error 1 running 'mkimage -d ./mkimage-in-simple-bin.mkimage-u-boot-tpl:./mkimage-in-simple-bin.mkimage-u-boot-spl -n px30 -T rksd ./idbloader.img': Error: SPL image is too large (size 0x3000 than 0x2800)
+Error: Bad parameters for image type
+Usage: mkimage [-T type] -l image
+          -l ==> list image header information
+          -T ==> parse image file as 'type'
+          -q ==> quiet
+       mkimage [-x] -A arch -O os -T type -C comp -a addr -e ep -n name -d data_file[:data_file...] image
+          -A ==> set architecture to 'arch'
+          -O ==> set operating system to 'os'
+          -T ==> set image type to 'type'
+          -C ==> set compression type 'comp'
+          -a ==> set load address to 'addr' (hex)
+          -e ==> set entry point to 'ep' (hex)
+          -n ==> set image name to 'name'
+          -R ==> set second image name to 'name'
+          -d ==> use image data from 'datafile'
+          -x ==> set XIP (execute in place)
+          -s ==> create an image with no data
+          -v ==> verbose
+       mkimage [-D dtc_options] [-f fit-image.its|-f auto|-f auto-conf|-F] [-b <dtb> [-b <dtb>]] [-E] [-B size] [-i <ramdisk.cpio.gz>] fit-image
+           <dtb> file is used with -f auto, it may occur multiple times.
+          -D => set all options for device tree compiler
+          -f => input filename for FIT source
+          -i => input filename for ramdisk file
+          -E => place data outside of the FIT structure
+          -B => align size in hex for FIT structure and, with -E, for the external data
+          -b => append the device tree binary to the FIT
+          -t => update the timestamp in the FIT
+Signing / verified boot options: [-k keydir] [-K dtb] [ -c <comment>] [-p addr] [-r] [-N engine]
+          -k => set directory containing private keys
+          -K => write public keys to this .dtb file
+          -g => set key name hint
+          -G => use this signing key (in lieu of -k)
+          -c => add comment in signature node
+          -F => re-sign existing FIT image
+          -p => place external data at a static position
+          -r => mark keys used as 'required' in dtb
+          -N => openssl engine to use for signing
+          -o => algorithm to use for signing
+       mkimage -V ==> print version information and exit
+Use '-T list' to see a list of available image types
+Long options are available; read the man page for details
+make[1]: *** [Makefile:1124: .binman_stamp] Error 1
+make: *** [Makefile:177: sub-make] Error 2

PLease see: https://source.denx.de/u-boot/custodians/u-boot-amlogic/-/jobs/710823#L2912

Neil
