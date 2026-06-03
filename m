Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 709BBCD6E55
	for <u-boot@archiver.kernel.org>; Wed,  3 Jun 2026 16:16:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E45F584874;
	Wed,  3 Jun 2026 18:16:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="fAXy76Mk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D0E2884878; Wed,  3 Jun 2026 18:16:08 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B24298469D
 for <u-boot@lists.denx.de>; Wed,  3 Jun 2026 18:16:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-490a76757e5so30683525e9.2
 for <u-boot@lists.denx.de>; Wed, 03 Jun 2026 09:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780503366; x=1781108166; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:to:subject:reply-to:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=qhu4j24H8RaKaeuibl0yUFYkGkdZ+Y2luKeeuD68g1k=;
 b=fAXy76Mk9bvo2sfH+Ra2osjE8FBkRHTKckBGgS91sYLoFsIkldmtwhuQgW+bblEJ6V
 PsWY4twMolaJWLafH+pQYrza0hkFJAxO3OaaFmfOAL8GIkuHU/791HIzwQtfpzdjh50T
 sVFBKJO2/5Pp5vv2Ww0+BwGeYhLQBpe74QyjGvhHZNVD0IZP+5c5W9MjfL4pyG2w10JE
 nkAhUOlbljEzaibTYEt1w+Cp0mNaUXs0JhXqzBPuFRNxukF8bx1ejwmbWjL2Ws4QNqMR
 rXYO6Aw7lw+KnsIPpETwqayWuKSdQIQt/d4WdDo8ABZfkv/gsxXrYETgTxc1pw84GPQn
 RrgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780503366; x=1781108166;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:to:subject:reply-to:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qhu4j24H8RaKaeuibl0yUFYkGkdZ+Y2luKeeuD68g1k=;
 b=TeFIrCfA6mWRwwq/eCUhh5RA2ZiD7ep+0AIZWZbvXOacN1RmAPZzl64gcHjPbkrRfX
 Rfw+c/BDrT7+If1so7ckeKryaBvf9Ni12fgcwm0N/Dj7c6q1mxgxPKRBi0IAWn5Fhqbr
 QQVTwVhYHTfeNDvSSw59YxAqvhImevEAWSXfkk3s1UA6DxPZVjbjGjZGJXbnrCStjafV
 X7sHzPMOn++ZT5aRW7Y3jBeh49Fu4WQWAAVxCweqLJrPpVYbmMXYONJcP/H3g+LiJNpN
 5h+x3MfrhiLIVsj90AXI2/xoAdUau0JrecHXUIn2SdGI3bb/FIw9vJWFotAiBAFRgRze
 K3vg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8EN8SXlH2gYrgShNMyB7PqrRskSTBFpIfVoBPfxSqXfKiJz1lztUNoRXjbNmaQ4/gJyNWWVKc=@lists.denx.de
X-Gm-Message-State: AOJu0YxzyXuuS0tR9YO8ISIoaXVSSG293UW+N1hQImZH/dTlTSARaoyQ
 fswi8P+79hVuEZaK+3ABiCQw8s722z0BdcyXPCIBvbh431Teo4MlZxtuRRsEb0qAVLbMA7tUwW1
 C85D5
X-Gm-Gg: Acq92OE71PbL7QuwUW4Ykach+PC4Ir6zp3RNGiEenLrEGy3xMUa6v+PgY/KFdTvdQg1
 DJBmMOAqNakGztNQjSr2+sYs4bw0Tw+2ir8NHIrmSxtq3GZiXb0dEt7Pgtu0TepQkR/HzkITPQs
 QeGy32ISlEK8Vuty53tYgfXyBLXCt5qg+Y4GoCmP2wBx9LJnHNaJOiAEOhC6OvA7Bnvh7p07kGM
 rhIaQfjtnrZt9IH9i8XyJqivE8/oVKSlrizcyQNSpjVMr4VaA6hT8SghXvfNCEhdsK1JAyroznd
 WqK8IqkeextQYj3+cYNrG1lfzXX1cunnO21hYqmWgSfHmwFULrQsL+3w0BlyVaC9bxsEvgyRvZQ
 /VFcBEIVddNQY8JIAlhMQQ5uQ18l+dZhFgUth93l8XdOg0iNqZ5p8CPqZM/WLZrT5ghFDH4wlEu
 Wy3CH0M8k4sxCkJAdYisgyKCETEpQSqmW5U6wVILeAlZpk+cL5OBLMW7gguon85CZjlYBNRaca4
 eSuJLZL/WHNS+tn2A==
X-Received: by 2002:a05:600c:c84:b0:490:389:7644 with SMTP id
 5b1f17b1804b1-490b5fe0e36mr69138375e9.17.1780503365849; 
 Wed, 03 Jun 2026 09:16:05 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:a2a0:317e:910e:9ac9?
 ([2a01:e0a:106d:1080:a2a0:317e:910e:9ac9])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490bc3a8632sm5078815e9.8.2026.06.03.09.16.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jun 2026 09:16:05 -0700 (PDT)
Message-ID: <d5acf6b7-9ddb-454c-9b6f-d3a9f4ff23f0@linaro.org>
Date: Wed, 3 Jun 2026 18:16:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] ufs: doc/README.ufs
To: Raz Ben Yehuda <raz.benyehuda@mobileye.com>, u-boot@lists.denx.de
References: <20260603124553.3763516-1-raz.benyehuda@mobileye.com>
 <20260603124553.3763516-5-raz.benyehuda@mobileye.com>
From: Neil Armstrong <neil.armstrong@linaro.org>
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
In-Reply-To: <20260603124553.3763516-5-raz.benyehuda@mobileye.com>
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
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi,

On 6/3/26 14:45, Raz Ben Yehuda wrote:
> Documention of the ufs tool.
> 
> Signed-off-by: Raz Ben Yehuda <raz.benyehuda@mobileye.com>
> ---
>   doc/README.ufs | 217 +++++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 217 insertions(+)
>   create mode 100644 doc/README.ufs
> 
> diff --git a/doc/README.ufs b/doc/README.ufs
> new file mode 100644
> index 00000000000..bd9f5cd2856
> --- /dev/null
> +++ b/doc/README.ufs

This should be reStructuredText and placed in the right path like doc/usage/cmd/ufs.rst

Neil

> @@ -0,0 +1,217 @@
> +			ufs_tool
> +		**********************
> + The UFS tool provides utilities for querying, displaying, and modifying
> +UFS device configuration and descriptor information.
> +
> +Features:
> +- Query and display Device, Geometry, Unit, Configuration, and Power
> +  Descriptors
> +- Display LUN configuration and calculated capacities
> +- Modify LUN, Configuration, and Device Descriptor fields
> +- Configure WriteBooster-related parameters
> +- Query common UFS runtime flags
> +- Commit configuration changes or clear all LUN configurations
> +- Decode and format descriptor contents for easier debugging
> +- Clear
> +- Provisioning
> +
> +The UFS tool header definitions are based on the JEDEC Standard JESD220E:
> +Universal Flash Storage (UFS) Version 3.1.
> +
> +--------------------------------
> +Usage
> +--------------------------------
> +
> +Query descriptors:
> +--------------------------------
> +
> +    ufs query [lun] [idn]
> +
> +Descriptor IDs:
> +--------------------------------
> +
> +    0x00  Device Descriptor
> +    0x01  Configuration Descriptor
> +    0x02  Unit Descriptor
> +    0x07  Geometry Descriptor
> +    0x08  Power Descriptor
> +
> +Configure a Logical Unit (LUN):
> +--------------------------------
> +
> +    ufs set_lun <lun> <parameter> <value>
> +
> +Supported parameters:
> +--------------------------------
> +
> +    lu_enable
> +    boot_lun_id
> +    lu_write_protect
> +    memory_type
> +    data_reliability
> +    num_allocunits
> +    logical_block_size
> +    provisioning_type
> +    context_capabilities
> +    lu_num_write_booster_buffer_allocunits
> +
> +Modify Device Descriptor fields:
> +--------------------------------
> +
> +    ufs set_dev_desc <parameter> <value>
> +
> +Supported parameters:
> +----------------------
> +
> +    descriptor_idn
> +    device
> +    device_class
> +    device_sub_class
> +    number_lu
> +    boot_enable
> +    descr_access_en
> +    init_power_mode
> +    high_priority_lun
> +    secure_removal_type
> +    initactive_icc_level
> +    queue_depth
> +    write_booster_buffer_preserve_user_space_en
> +    write_booster_buffer_type
> +    spec_version
> +    manufacturer_id
> +    periodic_rtc_update
> +    device_version
> +    psa_max_data_size
> +    extended_ufs_features_support
> +    num_shared_write_booster_buffer_allocunits
> +
> +Modify Configuration Descriptor fields:
> +----------------------------------------
> +
> +    ufs set_cfg_desc <parameter> <value>
> +
> +Supported parameters:
> +---------------------
> +    length
> +    descriptor_idn
> +    conf_desc_continue
> +    boot_enable
> +    descr_access_en
> +    initpower_mode
> +    high_priority_lun
> +    secure_removal_type
> +    init_active_icc_level
> +    periodic_rtc_update
> +    reserved_HPB
> +    rpmb_region_enable
> +    rpmb_region1_size
> +    rpmb_region2_size
> +    rpmb_region3_size
> +    write_booster_buffer_preserve_user_space_en
> +    write_booster_buffer_type
> +    num_shared_write_booster_buffer_allocunits
> +
> +Query UFS flags:
> +----------------------------
> +    ufs getflag <flag_name>
> +
> +Supported flags:
> +-----------------------------
> +    deviceinit
> +    permanent_wpe
> +    pwr_on_wpe
> +    bkops_en
> +    life_span_mode
> +    purge_enable
> +    fphy_resource_removal
> +    busy_rtc
> +    permanently_disable_fw_update
> +    write_booster_en
> +    wb_buf_flush_en
> +    wb_buf_flush_h8
> +
> +Examples
> +------------------------------
> +
> +Create LUN 4:
> +    ufs query 1 1
> +    ufs set_lun 4 num_allocunits <size_in_alloc_units>
> +    ufs commit
> +    scsi scan
> +
> +Update WriteBooster configuration:
> +
> +    ufs query 1 1
> +    ufs set_cfg_desc num_shared_write_booster_buffer_allocunits 100000
> +    ufs set_cfg_desc write_booster_buffer_type 1
> +    ufs commit
> +
> +Clear all LUN configurations:
> +-------------------------------
> +
> +    ufs clearall
> +
> +This command clears luns, and commits.
> +
> +Provisioning
> +------------
> +
> +To simplify UFS provisioning, the tool displays the memory address and
> +size of the Configuration Descriptor (IDN 0x01). This allows the
> +descriptor to be exported from one system and imported on another.
> +
> +Provisioning workflow:
> +
> +Source system
> +-------------
> +
> +1. Display the Configuration Descriptor:
> +
> +       ufs query 1 1
> +
> +   The output includes the Configuration Descriptor address and size.
> +
> +   Example:
> +
> +       Config Descriptor: (0x00000008ffffc610)
> +       Length                          : 0x0e6
> +       DescriptorIdn                   : 0x01
> +       ConfDescContinue                : 0x00
> +       BootEnable                      : 0x01
> +       ...
> +
> +2. Save the Configuration Descriptor to a file:
> +
> +       tftpput <cfg_desc_addr> <size> <filename>
> +
> +   Example:
> +
> +       tftpput 0x8ffffc610 0xe6 luns.bin
> +
> +   This exports the current UFS configuration, including LUN settings.
> +
> +Target system
> +-------------
> +
> +1. Load the currect Configuration descriptor.
> +    ufs query 1 1
> +       Config Descriptor: (0x00000008ffffce00)
> +       Length                          : 0x0e6
> +       DescriptorIdn                   : 0x01
> +       ConfDescContinue                : 0x00
> +       BootEnable                      : 0x01
> +
> +
> +2. Load the configuration file onto Configuration Descriptor using XMODEM or TFTP.
> +   Examples:
> +
> +       loadx 0x8ffffce00
> +   or
> +       tftpget 0x8ffffce00 luns.bin
> +
> +3. Commit the configuration to the UFS device:
> +
> +       ufs commit
> +
> +   The imported Configuration Descriptor is written to the device and
> +   becomes active after the commit operation completes.

