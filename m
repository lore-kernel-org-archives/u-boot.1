Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6B6DC36014
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 08:23:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C1D481F7B;
	Tue,  1 Apr 2025 10:23:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="lXw0qsw5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5972D81FAA; Tue,  1 Apr 2025 10:23:14 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 99D9481F0D
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 10:23:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4394a0c65fcso50346655e9.1
 for <u-boot@lists.denx.de>; Tue, 01 Apr 2025 01:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743495791; x=1744100591; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=baP6azleLuQo9zcxdVSWHWf7exQ5fsxWfzkin0ksS6U=;
 b=lXw0qsw51YUz1C9rM0uhZL5ZcVXhZiNqR4dDOkmAthwIMzS0XB/WcEVlSKnETIVwm7
 3IWMVBnolqsP/iXMbLkO8JIogqmNY71YQ5hWB7or1xzsjtwJJU81ubYdUDQNnM1OXdLJ
 iB3j2iXzHdtWZEKueycFmky7B7x+eCJDDkNim+k5F7eLsJt+/dbhgf5DPB3h1lyMJ5Ba
 qegfr27yy2wRTuyjPMY/NN3J7o7EH/UCgJbkQ34vXX63EZKi9wONVtI+6EomJAgOb9RB
 ILmHijZLa0SaD96jLy78ipvB52KS5uBgdome7ivyhFKlPnwbqA+ki/noQ8kr+Ct/i3VQ
 liSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743495791; x=1744100591;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=baP6azleLuQo9zcxdVSWHWf7exQ5fsxWfzkin0ksS6U=;
 b=abvFb0Z/ljaiZgiLFJkVx6N4GEzjdxIRcFktGzzfMtTgEYfvBEcehQ48w5pkZagY7f
 b0F/GxnDohHBwSlbQWaCc6dIIx6mfTXfZ9MJ/TrnZsiAK6EZR/E4YGl+LvqffsQx583y
 WFCsGvegiLFbIEFBR6tNfntI1lPRVwQyv6Ecjymr+FLglhj6NWNyrx3Z6ZV3queXLP5Q
 s7tAS5BRTSqQ9OoDoRTDLrLsRIWtWr7BC62vmp3ueoXnanqDt/h8uXl0oVvNYZeHa7Eq
 vaucFM4U2qB6za4uCb4CFLWLJjs0lNXuyFBk4p8XxwR3KGE2/B+z79y7mqNTde5MES/4
 aa0A==
X-Gm-Message-State: AOJu0YzgJ8rJyFt7Hb+v47Xnwg5rFvkAkaWvwK3NaC2UBAhoCgL6Lb9n
 SWiS2M8mZ1szh1cTZsLqB0hTOweDlDcK8l5N6XTS7qgRTPp2eJ+ak9EBjz0ixr8=
X-Gm-Gg: ASbGncuvk06ovmAYnLNooE0eiOpZxH3zAkTE0cla2txyjWYPjq5VElQiZscAP80AZMq
 kMyulc9SdlyggeFb31ENxYx3pbnyVDKkWCCGHhxfRDR+G/bc19vBz/BP3ReP5LBmNsKVOMHfLzt
 ZoMENcZ5DCj5QUn3thsiuh7eaRaVm/Iga1iDm5bMrTJ0SOh/EcpaSmvMtMGViXHVq9+eoyD9zOD
 B6npnlzN/qHVqhExkza+0eg68BZKkZAYa7qApChIbar9UJGYBZuTeHAwRMsCArcV4XDE0QqODfG
 jU6GMp+3zU3MeCAR+8DSlJC+/h+YljHbfEpJAu+lOVvaDYAJJQVxoMdTuxRob3BKIfCTizcQeP1
 iUZsHdw4WgDUuGg8vhO/HFA==
X-Google-Smtp-Source: AGHT+IHVbYkdm9CclW6PoEtwi6KN/3VkoRTSLduu42bhBYL2G0L+OcXE6aKFhJn62vvzaCe+I9loDA==
X-Received: by 2002:a05:600c:4f4f:b0:43c:fcbc:968c with SMTP id
 5b1f17b1804b1-43db6228823mr102500675e9.7.1743495791041; 
 Tue, 01 Apr 2025 01:23:11 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:9580:69fe:d5fd:c1a0?
 ([2a01:e0a:3d9:2080:9580:69fe:d5fd:c1a0])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ea9a346e3sm8742725e9.1.2025.04.01.01.23.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Apr 2025 01:23:10 -0700 (PDT)
Message-ID: <eb506671-c8be-4a00-9341-5db15cdc5d44@linaro.org>
Date: Tue, 1 Apr 2025 10:23:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH 2/4] fastboot: blk: add block device flashing configuration
To: Dmitrii Merkurev <dimorinny@google.com>
Cc: u-boot@lists.denx.de, rammuthiah@google.com,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Simon Glass <sjg@chromium.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Ying-Chun Liu <paul.liu@linaro.org>
References: <20240306185921.1854109-1-dimorinny@google.com>
 <20240306185921.1854109-2-dimorinny@google.com>
 <f2e90ccc-424e-4ab7-93d9-7ca4aaa5a600@linaro.org>
 <CAOWkq4mgzqdAjU+a3iFc7_UnsP03NTNp+TdK94t4g10tD2DOuA@mail.gmail.com>
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
In-Reply-To: <CAOWkq4mgzqdAjU+a3iFc7_UnsP03NTNp+TdK94t4g10tD2DOuA@mail.gmail.com>
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

On 26/11/2024 00:41, Dmitrii Merkurev wrote:
> Hey Neil.
> 
> Will do it by the end of the year. Only tested it with a virtio-block though.

Ping, did you find time to resubmit a new version of this patchset ?

Thanks,
Neil

> 
> On Thu, Nov 21, 2024 at 12:44 PM <neil.armstrong@linaro.org <mailto:neil.armstrong@linaro.org>> wrote:
> 
>     Hi Dmitrii,
> 
>     So you plan to send a new version of this patchset ?
> 
>     It would be very useful to enable fastboot onr UFS/SCSI based devices.
> 
>     Thanks,
>     Neil
> 
>     On 06/03/2024 19:59, Dmitrii Merkurev wrote:
>      > Signed-off-by: Dmitrii Merkurev <dimorinny@google.com <mailto:dimorinny@google.com>>
>      > Cc: Patrick Delaunay <patrick.delaunay@foss.st.com <mailto:patrick.delaunay@foss.st.com>>
>      > Cc: Simon Glass <sjg@chromium.org <mailto:sjg@chromium.org>>
>      > Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com <mailto:mkorpershoek@baylibre.com>>
>      > Cc: Ying-Chun Liu (PaulLiu) <paul.liu@linaro.org <mailto:paul.liu@linaro.org>>
>      > ---
>      >   drivers/fastboot/Kconfig | 20 ++++++++++++++++++--
>      >   1 file changed, 18 insertions(+), 2 deletions(-)
>      >
>      > diff --git a/drivers/fastboot/Kconfig b/drivers/fastboot/Kconfig
>      > index 5e5855a76c..460c5e98d7 100644
>      > --- a/drivers/fastboot/Kconfig
>      > +++ b/drivers/fastboot/Kconfig
>      > @@ -87,7 +87,7 @@ config FASTBOOT_USB_DEV
>      >   config FASTBOOT_FLASH
>      >       bool "Enable FASTBOOT FLASH command"
>      >       default y if ARCH_SUNXI || ARCH_ROCKCHIP
>      > -     depends on MMC || (MTD_RAW_NAND && CMD_MTDPARTS)
>      > +     depends on MMC || (MTD_RAW_NAND && CMD_MTDPARTS) || BLK
>      >       select IMAGE_SPARSE
>      >       help
>      >         The fastboot protocol includes a "flash" command for writing
>      > @@ -109,12 +109,16 @@ choice
>      >
>      >   config FASTBOOT_FLASH_MMC
>      >       bool "FASTBOOT on MMC"
>      > -     depends on MMC
>      > +     depends on MMC && BLK
>      >
>      >   config FASTBOOT_FLASH_NAND
>      >       bool "FASTBOOT on NAND"
>      >       depends on MTD_RAW_NAND && CMD_MTDPARTS
>      >
>      > +config FASTBOOT_FLASH_BLOCK
>      > +     bool "FASTBOOT on block device"
>      > +     depends on BLK
>      > +
>      >   endchoice
>      >
>      >   config FASTBOOT_FLASH_MMC_DEV
>      > @@ -189,6 +193,18 @@ config FASTBOOT_MMC_USER_NAME
>      >         defined here.
>      >         The default target name for erasing EMMC_USER is "mmc0".
>      >
>      > +config FASTBOOT_FLASH_BLOCK_INTERFACE_NAME
>      > +     string "Define FASTBOOT block interface name"
>      > +     depends on FASTBOOT_FLASH_BLOCK
>      > +     help
>      > +       "Fastboot block interface name (mmc, virtio, etc)"
>      > +
>      > +config FASTBOOT_FLASH_BLOCK_DEVICE_ID
>      > +     int "Define FASTBOOT block device id"
>      > +     depends on FASTBOOT_FLASH_BLOCK
>      > +     help
>      > +       "Fastboot block device id"
>      > +
>      >   config FASTBOOT_GPT_NAME
>      >       string "Target name for updating GPT"
>      >       depends on FASTBOOT_FLASH_MMC && EFI_PARTITION
> 

