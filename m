Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74762C61DD3
	for <u-boot@archiver.kernel.org>; Tue,  1 Sep 2026 16:36:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7993F40757;
	Tue,  1 Sep 2026 16:36:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LydeD2Ub1gnL; Tue,  1 Sep 2026 16:35:59 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788280559;
	bh=hvyNiMWS4QyDaAZzf0SqqbYnm0Hecypi/7pNVDxGqfE=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=fOqMwrDlLlWCflzPlGwUS+jePEljR8Swe9WO124lrNrs1mmtqqT1Aw8pAN7eQFN5g
	 pdaofRIbxPQKACrmGolXTt2G2Kmvluz+pzgRSgusDA0Z4TB+B5bT6y0heOMlT9Zc9U
	 qK5GXLoCv3Fho6q7CWYEQqQrF5UVR8Aoo0W/rtqYyok54qGM5cQou7tWsTnzMxQuP5
	 gsW1Dgs5kxT1S226t9CPQvUD1ZPpwaGIrTeVZS3Hat9CXO9AHCvbqRyGsXtcvXpLkT
	 r34fn0Fld6o3vK73NmLNaOy6b/z56+kQfBUFN60nKZL9EG4WTVIc+kVT0xnCrv2O5d
	 n/rbLX6cJcm3A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9697840744;
	Tue,  1 Sep 2026 16:35:59 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 4A6702FD
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 16:35:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3073340743
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 16:35:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NLsWL_aWzBUV for <u-boot@lists.u-boot-project.org>;
 Tue,  1 Sep 2026 16:35:57 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42c; helo=mail-wr1-x42c.google.com;
 envelope-from=neil.armstrong@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=c0kO/bNu
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id F3B5240744
 for <u-boot@lists.u-boot-project.org>; Tue,  1 Sep 2026 16:35:56 +0000 (UTC)
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-484374f54d0so61168f8f.3
 for <u-boot@lists.u-boot-project.org>; Tue, 01 Sep 2026 09:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788280554; x=1788885354;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hvyNiMWS4QyDaAZzf0SqqbYnm0Hecypi/7pNVDxGqfE=;
 b=c0kO/bNuuGW/fn7wJH6Nl8wRg2FvI71S3T2UgQSwZ26myatPcRFekewxOSVqBOhEf5
 SnCPJv4j+LQ6J90HMTMK/7WBeUrXz46axkMWifIaXEyh9gfI1SVOvt5ah8wDQuQ9D8kE
 ANkTwdfXfdVmDZWq+p7Q/YzGyhdHPI4ay2NkhWM+a5m1KJkpVTCWJR/IFX+P5fUuywBI
 HlcWUfBhRMhuogu6N/PA+yDl8DJPPpDkVT9H/cYLjCWhj50pY/Kla9FfTXQfz1CWQbep
 ekQf5FEbY7/AQAAvsM8PBZv8/uLBuYD0umckw4+8HvASlc5fEuTwEeMG4V7up/FDBfrI
 ph/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788280554; x=1788885354;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=hvyNiMWS4QyDaAZzf0SqqbYnm0Hecypi/7pNVDxGqfE=;
 b=iriiapODM9HmsCAdVq3evDPrH/scdLcMkGmlFzyvDaRnqA/9P5eL9foRP04ewtQZKr
 /jMtmM4gpNE2j8+kuurQzfCfnQCjQgArVCRDprrzppCmKjx/4brYFoev82xBCRJOCRN6
 AOds5QjcNSEuLQ9lrN+bkHJAuL51pXxXF/gLCdDyp8gB8mFcfc/gO0bowdcAq1mforQn
 VP3MR6XWUMgOWHeEObhTEa5xDl6rZzvW/TnQtUSckgUSfWXVnbrUWT43QnT6/sC/W/0V
 tFSwmVMzGwYhPq83mjd4UvpI/KY74NXiuaHyusbOk4fuVOWqF3tki+kDHg4k9kHW/gKy
 kE0g==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr891TYV8rEgtjBbOTiR0jfMI+cS1QQd/h3kAHje1HlpYo4d/NC6lMJ7RrnHLrcVRdTWAuVCwE=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mx/4Y50fHeOMdGxqj9h3TPwXglYDkGuJ95LrKBPubXS5XfeuG2
 /pH3/OYnKXDTaD8J1DJeuyxnJooiPjnC2sIQEL6Hh2VFeIajBpkw4c7PZq5LQSrN62k=
X-Gm-Gg: AR+sD10fcVGENfkWj8TDrMzUzyOxzZWidwKyV7fDtA90O0cwoC+1GYO8Gctv3P8LTAL
 ENefRA/OIsbPDkp3mdF9OUPHPPSyYAW1vJ+U7S7W4412KCMQA1VOu/sUSAJH5ebvrIU+VjSmcjG
 E6HEETxHioUfuiUAgp+fDbKVE7vYfC+6v4gn5rhBJBQKRaHVukcW2qx4CjzgP0sLoqchPes4qN1
 J7Eg02Iugkf0dIZorWab/uuQPqsLmgd14DXB4RV/YmRLbw+Lp6/ssfmP8RdwkbxoejZh+ED5qKL
 z39mZhmaXixKs8SHNJqU9FTkeIh99UI1ek7Cp/A6diCfoR7GL8tlufyqJi3DCLzI655rNOczQon
 uHD6PmzgMFEWW29hh8dNsAeNPnecHny8A7fHMpOmpEenKH64pW1uGpJi0TXqSGGgLOcSsLjqUvN
 drUqLeAr9yciXlRg4Z/j1uGVJe9QNINqiFjikXJTz3rM9G2azIXhMu38GK5JDgQunu7gZWSVAuX
 sT+bh8Kv13VsozFzR1bcoqTr0ebUF583kpTkoBknsrRyK6FEgITog==
X-Received: by 2002:a05:600c:a00d:b0:49a:252d:52f5 with SMTP id
 5b1f17b1804b1-49cdc45253dmr187165335e9.11.1788280521515; 
 Tue, 01 Sep 2026 09:35:21 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:3b72:e9ec:2552:5b90?
 ([2a01:e0a:106d:1080:3b72:e9ec:2552:5b90])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b9266be71sm793470805e9.2.2026.09.01.09.35.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Sep 2026 09:35:21 -0700 (PDT)
Message-ID: <afe6836f-5366-4177-ab57-7563380e8b74@linaro.org>
Date: Tue, 1 Sep 2026 18:35:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] spl: rename DISABLE_ALL_EXECPTIONS
To: =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>,
 u-boot-amlogic@groups.io, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Daniel Golle <daniel@makrotopia.org>
References: <20260901-typo-v1-1-89ea773a9a05@arm.com>
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
In-Reply-To: <20260901-typo-v1-1-89ea773a9a05@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On 9/1/26 18:20, Vincent Stehlé wrote:
> The DISABLE_ALL_EXECPTIONS define has a typo; fix all occurrences using the
> following command:
> 
>    find '(' -type d -name .git -prune ')' -o -type f -print |\
>      xargs sed -i 's/DISABLE_ALL_EXECPTIONS/DISABLE_ALL_EXCEPTIONS/g'
> 
> This can be verified by pre-processing, for example with the following
> commands:
> 
>    make libretech-cc_v2_defconfig
>    make spl/arch/arm/mach-meson/spl.i spl/common/spl/spl_atf.i
> 
> (Adjust as needed for cross-compilation.)
> 
> Signed-off-by: Vincent Stehlé <vincent.stehle@arm.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>   arch/arm/mach-meson/spl.c | 2 +-
>   common/spl/spl_atf.c      | 8 ++++----
>   include/atf_common.h      | 2 +-
>   3 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm/mach-meson/spl.c b/arch/arm/mach-meson/spl.c
> index 28a63f39d36..73445064e4d 100644
> --- a/arch/arm/mach-meson/spl.c
> +++ b/arch/arm/mach-meson/spl.c
> @@ -84,7 +84,7 @@ void board_init_f(ulong dummy)
>   
>   		SET_PARAM_HEAD(&spl_ep_info, ATF_PARAM_BL31, ATF_VERSION_1, 0);
>   		spl_ep_info.pc = CONFIG_SPL_TEXT_BASE;
> -		spl_ep_info.spsr = SPSR_64(MODE_EL3, MODE_SP_ELX, DISABLE_ALL_EXECPTIONS);
> +		spl_ep_info.spsr = SPSR_64(MODE_EL3, MODE_SP_ELX, DISABLE_ALL_EXCEPTIONS);
>   
>   		regs.regs[0] = 0xc0000000;
>   		regs.regs[1] = (unsigned long)&spl_ep_info;
> diff --git a/common/spl/spl_atf.c b/common/spl/spl_atf.c
> index 17acd3665df..cb0604ce034 100644
> --- a/common/spl/spl_atf.c
> +++ b/common/spl/spl_atf.c
> @@ -75,7 +75,7 @@ struct bl31_params *bl2_plat_get_bl31_params_default(ulong bl32_entry,
>   	bl32_ep_info->args.arg3 = fdt_addr;
>   	bl32_ep_info->pc = bl32_entry ? bl32_entry : 0;
>   	bl32_ep_info->spsr = SPSR_64(MODE_EL1, MODE_SP_ELX,
> -				     DISABLE_ALL_EXECPTIONS);
> +				     DISABLE_ALL_EXCEPTIONS);
>   
>   	bl2_to_bl31_params->bl32_image_info = &bl31_params_mem.bl32_image_info;
>   	SET_PARAM_HEAD(bl2_to_bl31_params->bl32_image_info,
> @@ -91,7 +91,7 @@ struct bl31_params *bl2_plat_get_bl31_params_default(ulong bl32_entry,
>   	bl33_ep_info->args.arg0 = 0xffff & read_mpidr();
>   	bl33_ep_info->pc = bl33_entry;
>   	bl33_ep_info->spsr = SPSR_64(MODE_EL2, MODE_SP_ELX,
> -				     DISABLE_ALL_EXECPTIONS);
> +				     DISABLE_ALL_EXCEPTIONS);
>   
>   	bl2_to_bl31_params->bl33_image_info = &bl31_params_mem.bl33_image_info;
>   	SET_PARAM_HEAD(bl2_to_bl31_params->bl33_image_info,
> @@ -149,7 +149,7 @@ struct bl_params *bl2_plat_get_bl31_params_v2_default(ulong bl32_entry,
>   	bl_params_node->ep_info->args.arg3 = fdt_addr;
>   	bl_params_node->ep_info->pc = bl32_entry ? bl32_entry : 0;
>   	bl_params_node->ep_info->spsr = SPSR_64(MODE_EL1, MODE_SP_ELX,
> -						DISABLE_ALL_EXECPTIONS);
> +						DISABLE_ALL_EXCEPTIONS);
>   	SET_PARAM_HEAD(bl_params_node->image_info, ATF_PARAM_IMAGE_BINARY,
>   		       ATF_VERSION_2, 0);
>   
> @@ -166,7 +166,7 @@ struct bl_params *bl2_plat_get_bl31_params_v2_default(ulong bl32_entry,
>   	bl_params_node->ep_info->args.arg0 = 0xffff & read_mpidr();
>   	bl_params_node->ep_info->pc = bl33_entry;
>   	bl_params_node->ep_info->spsr = SPSR_64(MODE_EL2, MODE_SP_ELX,
> -						DISABLE_ALL_EXECPTIONS);
> +						DISABLE_ALL_EXCEPTIONS);
>   	SET_PARAM_HEAD(bl_params_node->image_info, ATF_PARAM_IMAGE_BINARY,
>   		       ATF_VERSION_2, 0);
>   
> diff --git a/include/atf_common.h b/include/atf_common.h
> index 03cfcc69cd7..9ef1ef186e1 100644
> --- a/include/atf_common.h
> +++ b/include/atf_common.h
> @@ -69,7 +69,7 @@
>   #define DAIF_IRQ_BIT (1<<1)
>   #define DAIF_ABT_BIT (1<<2)
>   #define DAIF_DBG_BIT (1<<3)
> -#define DISABLE_ALL_EXECPTIONS	\
> +#define DISABLE_ALL_EXCEPTIONS	\
>   	(DAIF_FIQ_BIT | DAIF_IRQ_BIT | DAIF_ABT_BIT | DAIF_DBG_BIT)
>   
>   #ifndef __ASSEMBLY__
> 
> ---
> base-commit: 3f19667468fb93bcb5702d23aa057b72639e3ac8
> change-id: 20260901-typo-465ee352485c
> 
> Best regards,
> --
> Vincent.
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
