Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4CC2D29DEF
	for <u-boot@archiver.kernel.org>; Tue, 13 Jan 2026 09:13:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2D22C8352B;
	Tue, 13 Jan 2026 10:13:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mKgeFsMc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5394883642; Tue, 13 Jan 2026 10:13:09 +0100 (CET)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 334FD80077
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 10:13:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-42fbbc3df8fso3838794f8f.2
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 01:13:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768295585; x=1768900385; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=I2Ccrw7jLtcFa8zVz9dESxfFa4PGtpHY3ZMKWE2z1mA=;
 b=mKgeFsMcu3JnagMGEbZxoKkyg3MmIgJx/k1C4tb+nuQOLyBk9U3hvprw6rbrD6qvGJ
 9rkmzFN19xE8kr8vpzyX4JBNBTMQ9N/K4U6Hk/3UhUG7b9362qnEFTS5w8JKMqOsHtVd
 Go41+WC1MlpsuTWantHJorrmbzJkh6SRPkYIJQq6QSq/HBY89gnVi5Z12JCyUM5tNwN3
 XavAfyuXzJ6Pgdu/ivssTXU8jXn8d5q8lu4lQAJBUS3TEOxihC9WomLVHm6pdqnXIosV
 ZDL7iIv43B6vAz85SwjOi2+xvWyTbvmaQ6Br6tru8xAdllRJUJysNsKr/sWgqq9PEiwQ
 P0MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768295585; x=1768900385;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I2Ccrw7jLtcFa8zVz9dESxfFa4PGtpHY3ZMKWE2z1mA=;
 b=rXc7uq0jkXNlPpUqX4ULz+cIe6+/IUXssljoGcLy/d8Gll99d4B0nY+enpJTa/jnu7
 s1VoOzGy6NKYcvk9bsIfiXbXqjeQARiPXjmMWvoEhCt5VTZgOeXE6xM4mCZ+hZdeP+sn
 crprBSj69he7HmlgE0N1BIqimBqNbUFOozyo6bbnCVX5OQJIwWdeM1/je0z0kVvEQdGP
 B+KQxHPGUoMfIqR4+DcfWg5AKza+9+xtZQhlscVudFhG5kjHNdaLY30VV+biSqn8Bmco
 fEDUV/aqiE0V/yo9M8heOOHA08+IWPGAPrGMnHgBFbuASEGshjKjz8c1SGNY1prHLfgO
 1lTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCxnhyno6NmuccVvh2mJuktGO1TT5v1hM1xxH90YqD+2MfPSqFeyqDCLxjIuvuH2vt0RqYt7I=@lists.denx.de
X-Gm-Message-State: AOJu0YzO+lwWy4UFtdVb8pn/e0OtntXcP1OeoAeZvT2iwUio4r6GBaEF
 6SySuUW6PFUCwrKi5QVAz+8GNnzAX5kYr+ni2USC+c3NQrB6YjFV/CEWbXEDjKN+m7c=
X-Gm-Gg: AY/fxX5G+qZognpCS9zkn5CRgTyNZtSLxDa+Sfz1vD0iL/KtuCvRKPLh+yybkkVXfXy
 LLGM2w9IB+FhTEjatE5DAk+tp7bJSrNxbiSjSI/jz7yTz0HbrMIs3xasRImwvY73S1KM8OkD/0j
 lJLmBFa+ANZdb+PUYldNxCbXhb26q4o1+QTu2f3mS9deGZz0K87tYpuX23lcHCgMRkjwNX5FGfL
 TQGlRW8nFvoAFdRrMo77SOm04BjxWeWqnIhEqhmHESJ+M8gLt0od5KhP4OnDMBqEIVfjyyNUTra
 nnJvqhWBpsfYhU6+jf8CAGKOzKVeFaW8/3GHbP4QPxHds5Mcc1duSgClzIBOppqgMkWkdAYK8Sl
 LbnTbbbkVuNCZKX+U3L2uHpLRJ6/B4gdGiFz1iVUylM21T7QjTQ3GxJAL975v3G6gZvq+/neA/K
 6UuVXtZKa+oynCC1ufoueYaV+O9IbIJGUiPzh3qp6CCniT6/lhCg==
X-Google-Smtp-Source: AGHT+IEa2ns3exk0mKhgRv0OtE95qWdaflH7jeYxOGwT3TYVW6TqGpqLnTtUw92A7Qxo8PWWOWF8yg==
X-Received: by 2002:a05:6000:4387:b0:432:84f9:9802 with SMTP id
 ffacd0b85a97d-432c37a509cmr23522069f8f.49.1768295585304; 
 Tue, 13 Jan 2026 01:13:05 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3d9:2080::fa42:7768?
 ([2a01:e0a:3d9:2080::fa42:7768]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5ee24esm42769797f8f.33.2026.01.13.01.13.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Jan 2026 01:13:05 -0800 (PST)
Message-ID: <4c3e8adb-8270-43a7-8ed3-ce753b7ed088@linaro.org>
Date: Tue, 13 Jan 2026 10:13:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH v2] arm: dts: qcom: Add reserved memory regions and EFI
 memory mapping
To: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 trini@konsulko.com, aswin.murugan@oss.qualcomm.com,
 casey.connolly@linaro.org, sumit.garg@kernel.org, me@samcday.com,
 sughosh.ganu@linaro.org, gchan9527@gmail.com, u-boot@lists.denx.de,
 u-boot-qcom@groups.io
References: <20260113090621.3402096-1-balaji.selvanathan@oss.qualcomm.com>
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
In-Reply-To: <20260113090621.3402096-1-balaji.selvanathan@oss.qualcomm.com>
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

On 1/13/26 10:06, Balaji Selvanathan wrote:
> Add reserved-memory nodes to QCS615 and QCS6490 device trees to
> define platform-specific memory regions that should not be used by
> the operating system.

So, please explain why those are not in the Linux upstream DT which is
synced at every U-Boot release, and why the reserved-memory is totally
different from the Linux upstream arch/arm64/boot/dts/qcom/talos.dtsi ?

> 
> Implement efi_add_known_memory() function in board.c code to
> parse reserved-memory nodes from device tree and register them with
> the EFI memory map. This ensures proper memory protection during EFI
> boot and prevents conflicts with firmware-reserved regions.
> 
> Signed-off-by: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> ---
> Changes in v2:
> - Instead of adding reserved region info in a new
>    qcom_reserved_memory.c file, added the regions to reserved memory
>    node in override dts.
> - Link to v1: https://lore.kernel.org/u-boot/20260107091406.2428132-1-balaji.selvanathan@oss.qualcomm.com/
> ---
>   arch/arm/dts/qcs615-ride-u-boot.dtsi     | 56 +++++++++++++++++++++++
>   arch/arm/dts/qcs6490-rb3gen2-u-boot.dtsi | 26 +++++++++++
>   arch/arm/mach-snapdragon/board.c         | 58 ++++++++++++++++++++++++
>   3 files changed, 140 insertions(+)
> 
> diff --git a/arch/arm/dts/qcs615-ride-u-boot.dtsi b/arch/arm/dts/qcs615-ride-u-boot.dtsi
> index 68fffc70fcb..ec607061ba0 100644
> --- a/arch/arm/dts/qcs615-ride-u-boot.dtsi
> +++ b/arch/arm/dts/qcs615-ride-u-boot.dtsi
> @@ -11,4 +11,60 @@
>   		      <0x0 0xc0000000 0x0 0xc0000000>,
>   		      <0x1 0x80000000 0x1 0x00000000>;
>   	};
> +
> +	reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		hyp_mem: hyp@80000000 {
> +			reg = <0x0 0x80000000 0x0 0x600000>;
> +			no-map;
> +		};
> +
> +		xbl_boot_mem: xbl-boot@85d00000 {
> +			reg = <0x0 0x85d00000 0x0 0x200000>;
> +			no-map;
> +		};
> +
> +		aop_mem: aop@85f00000 {
> +			reg = <0x0 0x85f00000 0x0 0x20000>;
> +			no-map;
> +		};
> +
> +		xbl_dt_mem: xbl-dt@85f40000 {
> +			reg = <0x0 0x85f40000 0x0 0x30000>;
> +			no-map;
> +		};
> +
> +		tz_stat_mem: tz-stat@86200000 {
> +			reg = <0x0 0x86200000 0x0 0x100000>;
> +			no-map;
> +		};
> +
> +		tags_mem: tags@86300000 {
> +			reg = <0x0 0x86300000 0x0 0x1200000>;
> +			no-map;
> +		};
> +
> +		tz_mem: tz@87500000 {
> +			reg = <0x0 0x87500000 0x0 0x500000>;
> +			no-map;
> +		};
> +
> +		tzapps_mem: tzapps@87a00000 {
> +			reg = <0x0 0x87a00000 0x0 0x1c00000>;
> +			no-map;
> +		};
> +
> +		pil_mem: pil@8ab00000 {
> +			reg = <0x0 0x8ab00000 0x0 0xcc17000>;
> +			no-map;
> +		};
> +
> +		secure_dsp_mem: secure-dsp@a0000000 {
> +			reg = <0x0 0xa0000000 0x0 0x1600000>;
> +			no-map;
> +		};
> +	};
>   };
> diff --git a/arch/arm/dts/qcs6490-rb3gen2-u-boot.dtsi b/arch/arm/dts/qcs6490-rb3gen2-u-boot.dtsi
> index 8d4871135fa..cf6de0036d5 100644
> --- a/arch/arm/dts/qcs6490-rb3gen2-u-boot.dtsi
> +++ b/arch/arm/dts/qcs6490-rb3gen2-u-boot.dtsi
> @@ -15,6 +15,32 @@
>   		      <0 0xC3400000 0 0x3CC00000>,
>   		      <1 0x00000000 1 0x00000000>;
>   	};
> +
> +	reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		axon_dma_mem: axon-dma@80600000 {
> +			reg = <0x0 0x80600000 0x0 0x100000>;
> +			no-map;
> +		};
> +
> +		xbl_dt_mem: xbl-dt@80894000 {
> +			reg = <0x0 0x80894000 0x0 0x40000>;
> +			no-map;
> +		};
> +
> +		pil_reserved_mem: pil-reserved@84300000 {
> +			reg = <0x0 0x84300000 0x0 0x16b00000>;
> +			no-map;
> +		};
> +
> +		display_mem: display@e1000000 {
> +			reg = <0x0 0xe1000000 0x0 0x2400000>;
> +			no-map;
> +		};
> +	};
>   };
>   
>   &usb_1 {
> diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
> index 5fb3240acc5..f32d29a9242 100644
> --- a/arch/arm/mach-snapdragon/board.c
> +++ b/arch/arm/mach-snapdragon/board.c
> @@ -19,8 +19,10 @@
>   #include <dm/uclass-internal.h>
>   #include <dm/read.h>
>   #include <power/regulator.h>
> +#include <efi_loader.h>
>   #include <env.h>
>   #include <fdt_support.h>
> +#include <fdtdec.h>
>   #include <init.h>
>   #include <linux/arm-smccc.h>
>   #include <linux/bug.h>
> @@ -709,6 +711,62 @@ static void carve_out_reserved_memory(void)
>   	}
>   }
>   
> +/**
> + * efi_add_known_memory() - Add platform-specific reserved memory to EFI map
> + *
> + * This function is called by the EFI memory initialization code to allow
> + * platforms to add their reserved memory regions to the EFI memory map.
> + * For Qualcomm platforms, this parses the reserved-memory nodes from the
> + * device tree and adds them to the EFI memory map.
> + */
> +void efi_add_known_memory(void)
> +{
> +	ofnode parent, node;
> +	fdt_addr_t addr;
> +	fdt_size_t size;
> +	const char *name;
> +
> +	if (!IS_ENABLED(CONFIG_EFI_LOADER))
> +		return;
> +
> +	/* Parse reserved-memory nodes from device tree */
> +	parent = ofnode_path("/reserved-memory");
> +	if (!ofnode_valid(parent)) {
> +		log_debug("No reserved-memory node found in device tree\n");
> +		return;
> +	}
> +
> +	log_debug("Adding reserved-memory regions to EFI memory map\n");
> +
> +	ofnode_for_each_subnode(node, parent) {
> +		if (!ofnode_is_enabled(node))
> +			continue;
> +
> +		addr = ofnode_get_addr_size_index(node, 0, &size);
> +		if (addr != FDT_ADDR_T_NONE) {
> +			efi_status_t ret;
> +
> +			name = ofnode_get_name(node);
> +			ret = efi_add_memory_map(addr, size,
> +						 EFI_RESERVED_MEMORY_TYPE);
> +
> +			if (ret != EFI_SUCCESS) {
> +				log_err("Failed to reserve %s (0x%llx-0x%llx): %lu\n",
> +					name ? name : "unknown",
> +					(unsigned long long)addr,
> +					(unsigned long long)(addr + size),
> +					ret & ~EFI_ERROR_MASK);
> +			} else {
> +				log_debug("Reserved %s: 0x%llx-0x%llx (%llu KB)\n",
> +					  name ? name : "unknown",
> +					  (unsigned long long)addr,
> +					  (unsigned long long)(addr + size),
> +					  (unsigned long long)(size / 1024));
> +			}
> +		}
> +	}
> +}
> +
>   /* This function open-codes setup_all_pgtables() so that we can
>    * insert additional mappings *before* turning on the MMU.
>    */

