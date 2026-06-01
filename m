Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DBC6CD5BD1
	for <u-boot@archiver.kernel.org>; Mon,  1 Jun 2026 13:53:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF7B7848D8;
	Mon,  1 Jun 2026 15:53:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="WMGgPSMg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3EA5F848E2; Mon,  1 Jun 2026 15:53:52 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A31784868
 for <u-boot@lists.denx.de>; Mon,  1 Jun 2026 15:53:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-45ef29c5561so1621642f8f.0
 for <u-boot@lists.denx.de>; Mon, 01 Jun 2026 06:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780322030; x=1780926830; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:to:subject:reply-to:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=+D16LrnRLsCpNq9RQyLAg/h7ug/ikmxuYrdAyE8046Y=;
 b=WMGgPSMgpS4iCjbONuffLjc2r69NC/6Bm9e/9i2UEOrOw9ruSeQww7WNz084rxiXo5
 6MnJOtnowGqLBEBXH9W0B+HDkIVk6J2Cbzwh8VIIP7VIGzSbfFZ/jvZK8dbCfUuZaxMr
 WBS8UOUp69bTp4M84fyo9me0i4/gilyQwgVhe96XXvLtf+XLtkdayvCX7zSpPw3P6Wyt
 av279z6YBcxEyeHp/tXuSWlVBXNyD8bn4G7+Rr5uJBYgo8xfBcqO74TEj5xugTsXv4hR
 j02sws3spGq5BTfVx3QzJmf1CdTBaXLin9L1w9xVapRCK8uR24NKrVFDna8UF5gqFhTN
 lSHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780322030; x=1780926830;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:to:subject:reply-to:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+D16LrnRLsCpNq9RQyLAg/h7ug/ikmxuYrdAyE8046Y=;
 b=TNXlmgSwbdITijAeMI2kN5duewiUfHxjWcSWKkUzS/7fiPUO8bJ4QkYiZ/VfOUKmWl
 I7WAjWU+QguuStnazoji8aowZ5cBMjJl7PRx49muGGJrL2DqBuO6Aq5XffBYXT5LS0R7
 VFrGKOjfwJcetfQM0pCohVRcFHAn+27nsT0IwWCx6aLzhhuzBlnLyYFtXb4cyk4vQqwh
 XyLMaIEGpFzF8Do5JPNWP64SZtv2Cg8VNcBTLa95fvvuN71tV+aBOzpH61mhbSLD8TXI
 6Rc4E2/u2QgzQKBhwQGzIZOJ/7R3jybE9kfopAfsLXs1njM2WN2tQ1NjM8jCG9FtHua5
 1qBw==
X-Forwarded-Encrypted: i=1;
 AFNElJ//fxQ3MOn/TJC0XeUQzpDmbkT+HbxP5P05XxleyQq9iS6zfdCB1RuQNRgvS/Hhc7cBW6l/JK0=@lists.denx.de
X-Gm-Message-State: AOJu0Yxlpl79Fc91zDS7778ODf6MaCUoIIMCrxGrilaSASCkWPOS+hbj
 KoKdVF48Jmx+OzfTi7bHuFTTQAJDnvieBC8BdoaFO7kfA0O5MD8LlZDSJS/Merca3Ho=
X-Gm-Gg: Acq92OEQkAA15x9Yduvl4oVUl9FwqN8E2WgarDApMgOR55PwWLRbXzvPZiqpJoKTiCF
 /qSnDsPIKPp9/YN5vHp+wcxuqq3YLyZRm45lp8xOac4rrLwUBEgUxT5zNqOxSAtYuTDSI2CxfNi
 LTWm4RebNL3BJIpcWSgU+kXoEqpru5JHm+VojMklST8HyAxx7purrCzF92VFPM3qOne9oPsD99I
 AgoPeyljzLN/zwgVQojrVpoFqRWQNStsyaLV+jVcOY1wdNZiKOwNSyvzE2BkApwkNY8fMdcx0Wj
 Xh1/LwUNHKWzZnFpuygng+2SFrbYThgIKRgNUKIEnYLqmEX1CRpsdktDxHCK9BhdbFuhVdMlzWt
 q4xyvvluPmjmyo1ctm8ktYc/HfsqYGMKHxKGNgKjhwxJOAqW8nAcan+aAGNE5ryqZbEOStDr646
 LZPTcg9t1C9UXtiVu6JdBV7HiuRAUguHFPru1EpOSGn8iBo4JfxzAv/A9I5BP0Lte8XXWG3mnUc
 okg6jwOCTf7v3XTtQ==
X-Received: by 2002:a05:6000:4b1c:b0:45e:fa38:c899 with SMTP id
 ffacd0b85a97d-45efa38c904mr17311072f8f.4.1780322029426; 
 Mon, 01 Jun 2026 06:53:49 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:16ad:add5:5f53:d8d4?
 ([2a01:e0a:106d:1080:16ad:add5:5f53:d8d4])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ef354cf0dsm25796853f8f.17.2026.06.01.06.53.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jun 2026 06:53:48 -0700 (PDT)
Message-ID: <534567ca-3f2b-49a3-ab0e-693babca0a11@linaro.org>
Date: Mon, 1 Jun 2026 15:53:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] ufs: add ufs tool the configuration
To: Raz Ben Yehuda <raz.benyehuda@mobileye.com>, u-boot@lists.denx.de
References: <20260601112606.2278753-1-raz.benyehuda@mobileye.com>
 <20260601112606.2278753-4-raz.benyehuda@mobileye.com>
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
In-Reply-To: <20260601112606.2278753-4-raz.benyehuda@mobileye.com>
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

On 6/1/26 13:26, Raz Ben Yehuda wrote:
> Add the ufs tool to the Kconfig and Makefile
> Signed-off-by: Raz Ben Yehuda <raz.benyehuda@mobileye.com>
> ---
>   drivers/ufs/Kconfig  | 48 ++++++++++++++++++++++++++++++++++++++++++++
>   drivers/ufs/Makefile |  1 +
>   2 files changed, 49 insertions(+)
> 
> diff --git a/drivers/ufs/Kconfig b/drivers/ufs/Kconfig
> index 49472933de3..35ef6bb3860 100644
> --- a/drivers/ufs/Kconfig
> +++ b/drivers/ufs/Kconfig
> @@ -8,6 +8,54 @@ config UFS
>   	  This selects support for Universal Flash Subsystem (UFS).
>   	  Say Y here if you want UFS Support.
>   
> +config UFS_TOOL
> +	bool "ufs tool"
> +	depends on UFS
> +	help
> +	query [lun] [idn]:
> +		(0h) Device desc
> +		(7h) Geometry desc
> +		(8h) Power desc
> +		(2h) Unit desc
> +		(1h) Config desc
> +
> +		set_lun [LUN] [parm]
> +			lu_enable, boot_lun_id, lu_write_protect memory_type
> +			data_reliability num_allocunits logical_block_size
> +			provisioning_type context_capabilities
> +			lu_num_write_booster_buffer_allocunits
> +
> +		set_dev_desc [parm] [value]
> +			descriptor_idn, device, device_class
> +			device_sub_class, number_lu, boot_enable
> +			descr_access_en, init_power_mode, high_priority_lun
> +			secure_removal_type, initactive_icc_level
> +			queue_depth, write_booster_buffer_preserve_user_space_en
> +			write_booster_buffer_type, spec_version, manufacturer_id
> +			periodic_rtc_update, device_version, psa_max_data_size
> +			extended_ufs_features_support,
> +			num_shared_write_booster_buffer_allocunits
> +			write_booster_buffer_preserve_user_space_en
> +
> +		set_cfg_desc [parm] [value]
> +			length, descriptor_idn, conf_desc_continue
> +			boot_enable, descr_access_en, initpower_mode
> +			high_priority_lun, secure_removal_type, init_active_icc_level
> +			periodic_rtc_update, reserved_HPB, rpmb_region_enable
> +			rpmb_region1_size, rpmb_region2_size, rpmb_region3_size
> +			write_booster_buffer_preserve_user_space_en
> +			write_booster_buffer_type
> +			num_shared_write_booster_buffer_allocunits
> +
> +		flag [flag name]
> +			deviceinit, permanent_wpe, pwr_on_wpe, bkops_en, life_span_mode
> +			purge_enable, fphy_resource_removal, busy_rtc
> +			permanently_disable_fw_update, write_booster_en
> +			wb_buf_flush_en, wb_buf_flush_h8
> +
> +		luns
> +			list the current luns

Add those in a proper documentation file in doc/ and use a simple text describing the tool

> +
>   config UFS_AMD_VERSAL2
>   	bool "AMD Versal Gen 2 UFS controller platform driver"
>   	depends on UFS && ZYNQMP_FIRMWARE
> diff --git a/drivers/ufs/Makefile b/drivers/ufs/Makefile
> index e7f3c1d30c4..0e472782261 100644
> --- a/drivers/ufs/Makefile
> +++ b/drivers/ufs/Makefile
> @@ -4,6 +4,7 @@
>   #
>   
>   obj-$(CONFIG_UFS) += ufs-uclass.o
> +obj-$(CONFIG_UFS_TOOL) += ufs_tool.o

Add this on patch 1

>   obj-$(CONFIG_UFS_AMD_VERSAL2) += ufs-amd-versal2.o ufshcd-dwc.o
>   obj-$(CONFIG_UFS_CADENCE) += cdns-platform.o
>   obj-$(CONFIG_UFS_MEDIATEK) += ufs-mediatek.o

