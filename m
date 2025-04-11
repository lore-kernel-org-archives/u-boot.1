Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5270C369AF
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 14:11:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 782F18407E;
	Fri, 11 Apr 2025 16:11:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="sdbLnc5k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 328D484081; Fri, 11 Apr 2025 16:11:15 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 03ADC84003
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 16:11:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-39c1ef4ae3aso1276879f8f.1
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 07:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744380672; x=1744985472; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=RD7UU1noJodALdOr2P6N6mPNgJnpCtb7/wq8Syk6bjs=;
 b=sdbLnc5knW94wJMp1e+3Dd+tZbti7sc1KCheYoFJPqw7JiInfqBDbHfLbW8lV86/4d
 wiQGRwJjIX6H5DXzAKroRwYi3ZgYGAYngAi+ruTv4bQCSE6nU/Kkkleliswk8dGXMoWJ
 rOWlMCOLCaTDnO3RBzK58thK7bNgL1Mx+TfH1QU5KgJcclPctnNirTcHLPUKltFrcpFX
 u+I/m6rRCKJqiso2f/bTBeUUxzmW/KZTXSHsdxFJcpvUfj/pNOS326rnwx8zzdJh3d0q
 AuZqrz6Hji/WNdfQEtofGspfm0J2uOKpn7xP6tgqRfu9qnM4x1mg8ou3h0r8Um5aY990
 yK5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744380672; x=1744985472;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=RD7UU1noJodALdOr2P6N6mPNgJnpCtb7/wq8Syk6bjs=;
 b=BDsuLGBiQeywVfxhRVMSrddFtGObsNhlUtdLXVzIBDe4bz7/goJctytLMvpbB7qxFx
 sNp2nNHsU5b0oycQfLRz5kjV+fX3M/YAKoGOM5leojz8ViF11EQlEDhYBdcXJg/46zeJ
 kIjCI++KGnzvrbeyl7KhM6MAsFdJF6swBZj5szdy2iHTU8fNPf5VJEQ9ccV2ORRUrofY
 hACMRpYwYKX0DimV2URmfTBBa+5peTnx3cqMUUOA9jfTSB8EIdnqhVGoQ7jyFtmvgkti
 GW+BM1M8grnvDD4Htxy88Pg6NVuQV6SAnN9DIhASAKH2mtP7BZULQW4M20ASs3sRHM1w
 ATcg==
X-Gm-Message-State: AOJu0YzFgLRCGkzxoBLV/6U9ZYgNtZS4ensCkXilvO6ig6EF0TwDZx6K
 hXjrVaMrGlKkJbymomkt/N1EVXbkbGUTai2kyFhR3XnQVCA0R8//+knOQalY4Qw=
X-Gm-Gg: ASbGncvwQC85+qDUR4bq2VMxTfdVWyqodJ4zi/7spetsV3FY9F9fCg6D2592Zfbdv6G
 R69cgdeY6V04LEKL2JSDhDGM+ZjZel9OV/RKCq87BgtHNYu/skV3wjiObv8EGqKdwasjwwM9NK4
 r8PkP1S7RaVKIqn9V/ZFkYPYYrIayx0yeLAxDQ0eoeMyxI2xxR9yTp7JPkrcZoy2sPnI9Zpey8B
 3a74CRRRXQbDwxQuOxQaoX2hFx68CixKWKrKbccUC12nFdYAer+W6cJQLqbi3IfXbclKiPUzF/q
 B8nfQ5p2w1A4QNPhTh3TfrynnWK7ODkg4HfdXRdJuoDD3WSf9IARMzAEs9Cr/dNfRHYjQYLqD/Q
 A5LKhNhKyb9pJa8tTYQ==
X-Google-Smtp-Source: AGHT+IFT7bpkvBMx0JxcLxM8qLEA1gENKsN3lXio2gnLFG2FZSH7hZpB2Ql0PyFY/8/jwdbMrl85OA==
X-Received: by 2002:a5d:598e:0:b0:38d:df15:2770 with SMTP id
 ffacd0b85a97d-39d8f21d531mr5982782f8f.0.1744380672269; 
 Fri, 11 Apr 2025 07:11:12 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:f77b:949e:1d61:69a8?
 ([2a01:e0a:3d9:2080:f77b:949e:1d61:69a8])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39eae9640fdsm2100467f8f.7.2025.04.11.07.11.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Apr 2025 07:11:11 -0700 (PDT)
Message-ID: <d7684e37-098a-403f-b6be-70a49ef993d6@linaro.org>
Date: Fri, 11 Apr 2025 16:11:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 1/8] event: signal when livetree has been built
To: Caleb Connolly <caleb.connolly@linaro.org>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Sumit Garg <sumit.garg@kernel.org>, Lukasz Majewski <lukma@denx.de>,
 Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20250411-livetree-fixup-v2-0-1236823377bb@linaro.org>
 <20250411-livetree-fixup-v2-1-1236823377bb@linaro.org>
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
In-Reply-To: <20250411-livetree-fixup-v2-1-1236823377bb@linaro.org>
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

On 11/04/2025 14:47, Caleb Connolly wrote:
> OF_LIVE offers a variety of benefits, one of them being that the live
> tree can be modified without caring about the underlying FDT. This is
> particularly valuable for working around U-Boot limitations like lacking
> USB superspeed support on Qualcomm platforms, no runtime OTG, or
> peripherals like the sdcard being broken (and displaying potentially
> worrying error messages).
> 
> Add an event to signal when the live tree has been built so that we can
> apply fixups to it directly before devices are bound.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   common/event.c  |  3 +++
>   include/event.h | 18 ++++++++++++++++++
>   lib/of_live.c   | 11 +++++++++++
>   3 files changed, 32 insertions(+)
> 
> diff --git a/common/event.c b/common/event.c
> index dda569d447851f559a83f98fb7b1f3543156eab5..8d7513eb10b61919e1e784481dfdcc076be14986 100644
> --- a/common/event.c
> +++ b/common/event.c
> @@ -47,8 +47,11 @@ const char *const type_name[] = {
>   	"ft_fixup",
>   
>   	/* main loop events */
>   	"main_loop",
> +
> +	/* livetree has been built */
> +	"of_live_init",

"of_live_built" ?

>   };
>   
>   _Static_assert(ARRAY_SIZE(type_name) == EVT_COUNT, "event type_name size");
>   #endif
> diff --git a/include/event.h b/include/event.h
> index 75141a192a48b0931667632f41be8ff4d6139f7c..1d267f1d10547642d381fa287ab4981a2bf03543 100644
> --- a/include/event.h
> +++ b/include/event.h
> @@ -152,8 +152,17 @@ enum event_t {
>   	 * A non-zero return value causes the boot to fail.
>   	 */
>   	EVT_MAIN_LOOP,
>   
> +	/**
> +	 * @EVT_OF_LIVE_BUILT:
> +	 * This event is triggered immediately after the live device tree has been
> +	 * built. This allows for machine specific fixups to be done to the live tree
> +	 * (like disabling known-unsupported devices) before it is used. This
> +	 * event is only available if OF_LIVE is enabled and is only used after relocation.
> +	 */
> +	EVT_OF_LIVE_BUILT,
> +
>   	/**
>   	 * @EVT_COUNT:
>   	 * This constants holds the maximum event number + 1 and is used when
>   	 * looping over all event classes.
> @@ -202,8 +211,17 @@ union event_data {
>   	struct event_ft_fixup {
>   		oftree tree;
>   		struct bootm_headers *images;
>   	} ft_fixup;
> +
> +	/**
> +	 * struct event_of_live_built - livetree has been built
> +	 *
> +	 * @root: The root node of the live device tree
> +	 */
> +	struct event_of_live_built {
> +		struct device_node *root;
> +	} of_live_built;
>   };
>   
>   /**
>    * struct event - an event that can be sent and received
> diff --git a/lib/of_live.c b/lib/of_live.c
> index 90b9459ede313e492e28c8556c730f3bd8aaa9df..c1620616513c2e32448b4a6d156a9162d97c76b7 100644
> --- a/lib/of_live.c
> +++ b/lib/of_live.c
> @@ -10,8 +10,9 @@
>   
>   #define LOG_CATEGORY	LOGC_DT
>   
>   #include <abuf.h>
> +#include <event.h>
>   #include <log.h>
>   #include <linux/libfdt.h>
>   #include <of_live.h>
>   #include <malloc.h>
> @@ -320,8 +321,9 @@ int unflatten_device_tree(const void *blob, struct device_node **mynodes)
>   
>   int of_live_build(const void *fdt_blob, struct device_node **rootp)
>   {
>   	int ret;
> +	union event_data evt;
>   
>   	debug("%s: start\n", __func__);
>   	ret = unflatten_device_tree(fdt_blob, rootp);
>   	if (ret) {
> @@ -334,8 +336,17 @@ int of_live_build(const void *fdt_blob, struct device_node **rootp)
>   		return ret;
>   	}
>   	debug("%s: stop\n", __func__);
>   
> +	if (CONFIG_IS_ENABLED(EVENT)) {
> +		evt.of_live_built.root = *rootp;
> +		ret = event_notify(EVT_OF_LIVE_BUILT, &evt, sizeof(evt));
> +		if (ret) {
> +			log_debug("Failed to notify livetree build event: err=%d\n", ret);
> +			return ret;
> +		}
> +	}
> +
>   	return ret;
>   }
>   
>   void of_live_free(struct device_node *root)
> 

