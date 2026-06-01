Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF36ECD5BD1
	for <u-boot@archiver.kernel.org>; Mon,  1 Jun 2026 13:55:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4B41B846E6;
	Mon,  1 Jun 2026 15:55:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="q6klSR1m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C81184868; Mon,  1 Jun 2026 15:55:37 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4A57E801A9
 for <u-boot@lists.denx.de>; Mon,  1 Jun 2026 15:55:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-45eedc94d37so1973748f8f.3
 for <u-boot@lists.denx.de>; Mon, 01 Jun 2026 06:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780322135; x=1780926935; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:to:subject:reply-to:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=5zFG1NCRqMY3kYRWK17wIoTbZK4q6PNbNRMXHyVXnd8=;
 b=q6klSR1myq4qws2c26ZHNDs13ABYDN47f/cUXVyQwOHlrHcAIltzqC2YsDpKCDTaRl
 7uPqvGiIVd7Q8vLib7Q/5bff5M5I8e1Dz7n5GFqKCbbAKDLT1r3B4sm6byfFtxCZW2Aq
 ZdqURPyKqtkq+PN/KGDsQ/hFjQowKKBGHjf0ZshabDNx2HaZmX3/1JKck9ugXa9AcCMT
 I4ETXT4lmn9VUWr2s83TmGvY4dNqmgTOXk55YQ2D+/p5GZNHFPfLVOtKf4R1NxRsw/JO
 xcXBmTI2eNIfoUK9EUexp8iHizoSaGtwsaatXPkVothX5j9mRBKpdFuMNpCylYmYOC7M
 FbpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780322135; x=1780926935;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:to:subject:reply-to:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5zFG1NCRqMY3kYRWK17wIoTbZK4q6PNbNRMXHyVXnd8=;
 b=XEkT93MaADSvCPNrsxaQvdyKvtCYm/DGjmFgjr4jzTNO8fv1lZtCsGVTTRxarfGSOQ
 ZV6hSsPou1vmLZqQNl8VmfYjrHGyFbaj0/ZYkALQbT51pBiVigUx4d3iANu746YWgIiW
 aHHs7F8S16B6u0185it3zIsb3Sm+Pt56XxTsKcPN5lkOOm+m3kDfFO5ERprQBV0Q6E9U
 qoqjaWQWMJr+NoYywxWTOIIFPIPbfa9ppZ+m9vpi2NwZAqhg2K2m4eax+eAwCA2Q4PXS
 42SoqS7ZHB7X3eQsFTILq70NupeOrQZf+2xJYxR2Ct4HFBJkVpp816WO+Qpa8sUKttsJ
 A/yA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/GbOnnN3++q8sdkeQYYD80dAvJw8ZdPunsoWNHooX8BwkTUtjOqYAFrHzzDPCKsCregJMybDY=@lists.denx.de
X-Gm-Message-State: AOJu0YzqJs2QRjz03QhvJS4shzK9dcD3mhlPQEJVJoJsWvPMwUva/OfG
 DNc/m2OsqxEmMlfRqDL6VwGFkQI+liNjB5t3MDQe3dq3hGm3iU5hgzh8mXrtvLct9WMZ1P6mz0X
 KYx8CjMg=
X-Gm-Gg: Acq92OGu9uMZGJm6nP51kC+LDtMBBfFF+EBxuunk6mNWZqG3W3ogXllwiKlCE06TO1n
 Y6BFwkAhsZ/9Cxls7xgbFXnP5scsFezv/WVwoZJESt+YAT9dZMv9ocCdtp5v0mKNkHrJ0dYfg+d
 CsDjQBMBzXDB1bZWD2scY1uRaaeRVWkl5DHLd/DRwj/MeBlLJXPTw/ffbtpzj91OJ1hRW899G1S
 20PrvBdBhge1IIGNV7IbYZth17QwySca1gKY4NroQFR+PDg+y+vKoze7YfUBCqiBNSvjnNvMZCh
 2zTQH3/Wi0c34syFatrNQhNBhE/UGg9rty6bR8K28sU+jczKvcxH19ddyjlCEcaAppFcx4YO8AX
 rkpl80EG6Cu8v0Cf2ciyLzh6qdZGRkPCvJltLq68Atm3137uhjVZ2QNP/fRTYLHfwNc5e+PL9r/
 xGlhkZXuJkqDBJ/aPhwaXJ3Hc4xffHo34lYUl0S5ZQYA7C0NwbO/TPiny5C3arkPjVbnVjz0dZJ
 EGQzxnmSCOVVxHXYPFSbGYVf1/u
X-Received: by 2002:a7b:c3c3:0:b0:490:5191:6e26 with SMTP id
 5b1f17b1804b1-490a2941d7emr128330685e9.18.1780322134530; 
 Mon, 01 Jun 2026 06:55:34 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:16ad:add5:5f53:d8d4?
 ([2a01:e0a:106d:1080:16ad:add5:5f53:d8d4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909ca72cfbsm239704815e9.8.2026.06.01.06.55.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jun 2026 06:55:34 -0700 (PDT)
Message-ID: <349a932a-ca58-489d-bffa-4c06ce43a95d@linaro.org>
Date: Mon, 1 Jun 2026 15:55:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] ufs: Extend the ufs user interface
To: Raz Ben Yehuda <raz.benyehuda@mobileye.com>, u-boot@lists.denx.de
References: <20260601112606.2278753-1-raz.benyehuda@mobileye.com>
 <20260601112606.2278753-3-raz.benyehuda@mobileye.com>
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
In-Reply-To: <20260601112606.2278753-3-raz.benyehuda@mobileye.com>
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
> Provide a user interface and help to ufs tool.
> 	query [lun] [idn]:
> 		(0h) Device desc
>          	(7h) Geometry desc
> 		(8h) Power desc
> 		(2h) Unit desc
> 		(1h) Config desc
> 
>          set_lun [LUN] [parm]
>                  lu_enable
>                  boot_lun_id
>                  lu_write_protect
>                  memory_type
>                  data_reliability
>                  num_allocunits
>                  logical_block_size
>                  provisioning_type
>                  context_capabilities
>                  lu_num_write_booster_buffer_allocunits
> 
> 	set_dev_desc [parm] [value]
> 		descriptor_idn, device, device_class
> 		device_sub_class, number_lu, boot_enable
> 		descr_access_en, init_power_mode, high_priority_lun
> 		secure_removal_type, initactive_icc_level
> 		queue_depth, write_booster_buffer_preserve_user_space_en
> 		write_booster_buffer_type, spec_version, manufacturer_id
> 		periodic_rtc_update, device_version, psa_max_data_size
> 		extended_ufs_features_support,
> 		num_shared_write_booster_buffer_allocunits
> 		write_booster_buffer_preserve_user_space_en
> 
> 	set_cfg_desc [parm] [value]
> 		length, descriptor_idn, conf_desc_continue
> 		boot_enable, descr_access_en, initpower_mode
> 		high_priority_lun, secure_removal_type, init_active_icc_level
> 		periodic_rtc_update, reserved_HPB, rpmb_region_enable
> 		rpmb_region1_size, rpmb_region2_size, rpmb_region3_size
> 		write_booster_buffer_preserve_user_space_en
> 		write_booster_buffer_type
> 		num_shared_write_booster_buffer_allocunits
> 
> 	flag [flag name]
> 		deviceinit, permanent_wpe, pwr_on_wpe, bkops_en, life_span_mode
> 		purge_enable, fphy_resource_removal, busy_rtc
> 		permanently_disable_fw_update, write_booster_en
> 		wb_buf_flush_en, wb_buf_flush_h8
> 
> Examples:
> 
> To create lun 4 please:
> 	use ufs set_lun 4 num_allocunits xxx to set size
> 	ufs commit
> 	scsi scan
> 
> To change some value in the configuration descriptor
> 	ufs set_cfg_desc num_shared_write_booster_buffer_allocunits 100000
> 	ufs set_cfg_desc write_booster_buffer_type 1
> 	ufs commit
> 
> Signed-off-by: Raz Ben Yehuda <raz.benyehuda@mobileye.com>
> ---
>   cmd/ufs.c | 94 ++++++++++++++++++++++++++++++++++++++++++++++++++-----
>   1 file changed, 86 insertions(+), 8 deletions(-)
> 
> diff --git a/cmd/ufs.c b/cmd/ufs.c
> index 790dab50f18..bb0e2fd3a67 100644
> --- a/cmd/ufs.c
> +++ b/cmd/ufs.c
> @@ -8,31 +8,109 @@
>   #include <command.h>
>   #include <ufs.h>
>   #include <vsprintf.h>
> -#include <linux/string.h>

Why ?

>   
>   static int do_ufs(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
>   {
> -	int dev, ret;
> +	int dev;
>   
>   	if (argc >= 2) {
>   		if (!strcmp(argv[1], "init")) {
>   			if (argc == 3) {
>   				dev = dectoul(argv[2], NULL);
> -				ret = ufs_probe_dev(dev);
> -				if (ret)
> +				if (!ufs_probe_dev(dev))
>   					return CMD_RET_FAILURE;

Why ?

>   			} else {
>   				ufs_probe();
>   			}
> -
>   			return CMD_RET_SUCCESS;
>   		}
> -	}
> +#if IS_ENABLED(CONFIG_UFS_TOOL)
> +		if (!strcmp(argv[1], "query")) {
> +			int lun = -1;
> +			int idn = -1;
> +
> +			if (argc <= 3) {
> +				printf("usage: lun idn");
> +				return CMD_RET_FAILURE;
> +			}
> +
> +			lun  = dectoul(argv[2], NULL);
> +			idn  = dectoul(argv[3], NULL);
> +
> +			return ufs_tool_query(lun, idn);
> +		}
> +
> +		if (!strcmp(argv[1], "set_lun")) {
> +			int lun;
> +			u32 val;
> +
> +			if (argc <= 4) {
> +				ufs_tool_help();
> +				return CMD_RET_FAILURE;
> +			}
> +			lun  = dectoul(argv[2], NULL);
> +			val  = dectoul(argv[4], NULL);
> +			return ufs_tool_set_lun(lun, argv[3], val);
> +		}
> +		if (!strcmp(argv[1], "set_dev_desc")) {
> +			const char *name;
> +			u32 val;
>   
> -	return CMD_RET_USAGE;
> +			if (argc <= 3) {
> +				ufs_tool_help();
> +				return CMD_RET_FAILURE;
> +			}
> +			name = argv[2];
> +			val  = dectoul(argv[3], NULL);
> +			return ufs_tool_set_device_desc(name, val);
> +		}
> +		if (!strcmp(argv[1], "set_cfg_desc")) {
> +			const char *name;
> +			u32 val;
> +
> +			if (argc <= 3) {
> +				ufs_tool_help();
> +				return CMD_RET_FAILURE;
> +			}
> +			name = argv[2];
> +			val  = dectoul(argv[3], NULL);
> +			return ufs_tool_set_config_desc(name, val);
> +		}
> +
> +		if (!strcmp(argv[1], "flag")) {
> +			if (argc == 2) {
> +				printf("usage: flag [flag name]");
> +				ufs_tool_help();
> +				return CMD_RET_FAILURE;
> +			}
> +			return ufs_tool_query_flag(argv[2]);
> +		}
> +
> +		if (!strcmp(argv[1], "commit"))
> +			return ufs_tool_commit();
> +
> +		if (!strcmp(argv[1], "clearall"))
> +			return ufs_tool_clearall();
> +		if (!strcmp(argv[1], "luns")) {
> +			ufs_tool_print_luns();

Make the UFS device selectable everywhere, and return the ufs_tool_print_luns error

> +			return 0;
> +		}
> +	}
> +	ufs_tool_help();
> +#endif
> +	return CMD_RET_FAILURE;
>   }
>   
> -U_BOOT_CMD(ufs, 3, 1, do_ufs,
> +U_BOOT_CMD(ufs, 5, 1, do_ufs,
>   	   "UFS sub-system",
>   	   "init [dev] - init UFS subsystem\n"
> +#if IS_ENABLED(CONFIG_UFS_TOOL)
> +	   "query [LUN] [IDN]\n"
> +	   "set_lun [LUN] [parm name] [value]\n"
> +	   "set_cfg_des   [parm name] [value]\n"
> +	   "set_dev_desc  [parm name] [value]\n"
> +	   "luns - prints luns\n"
> +	   "flag [flag name] Query Flags\n"
> +	   "commit - writes luns configuration\n"
> +#endif
>   );

