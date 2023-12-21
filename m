Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B88DC35274
	for <u-boot@archiver.kernel.org>; Thu, 21 Dec 2023 16:32:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 928BA8789A;
	Thu, 21 Dec 2023 17:32:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Z1hjfxND";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1265878B7; Thu, 21 Dec 2023 17:32:20 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 18CD2877E5
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 17:32:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-40c6ea99429so10913625e9.3
 for <u-boot@lists.denx.de>; Thu, 21 Dec 2023 08:32:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703176337; x=1703781137; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=Z+btlkLqvsAjM9SZfO0tU6PKBeRqApYP5DdH8f9hx/A=;
 b=Z1hjfxNDI3fBSOUBHEpthZF4wOz7A+euToBZb0kiaPzhl4TGOi2FlfRPas9RBU+PIV
 Z6U+Bz4uat6sl/XTPQkrtbOfgxWpOyXlRUdV/OlDr8IGns3fzd64Ughuc9gtbqv5yfrL
 CvETDnv+7+k3md7PPushfaM9AdwMlRGAgyQdiqntaXXnNkl85XEmephiPUqR6JD228BZ
 4P/XFj2w1GMa3OXe55ru3ho9X/tvKvhgGcKNfuFqb2PXjss84hAnQ4p3gEBksnGE0rEW
 RoBdgtbxKOkj4YXAeoYiEvF/PDfTIXihXoQdxO9k6MjxcZFrzCCsUSuLYEnh0+PiPQY3
 CF9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703176337; x=1703781137;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Z+btlkLqvsAjM9SZfO0tU6PKBeRqApYP5DdH8f9hx/A=;
 b=dqNRwj8lG5iVwTVqYPXI2g5TNAn+uEHICYLY5b3zfXq0V8XY1SWGr9FnqLdBciJ0Jj
 vYKprrAnQIqtxcYXUIOMNC35yWmAxdWA/qu6UTrQ8w9JIYU1Z+cCExEtmAwSM8JmPKlt
 3Xrl5ODsKhuabhzWoXI3VJtYTJvyb6G+RLB0B6C0j0Yn+2dUfyOg+sAZPCGhhbreBHpQ
 cWPu/yHxW0o+pZB1Shx8O535uMHNRs/t/AJmZOPEY+nwadbkPnqBBbKXK+qiTL04B8oK
 8V4lYXM24fidPU/ZVPqwped6vy8PoJCcx2AUiZWF4Dlfnfwg8ZeGx+9PV9Za24fEeh7I
 d27A==
X-Gm-Message-State: AOJu0YyfJN7rrNXqs1K3gacz9BJWn9XEikjLeoTwQEjvfE5yCNaL4+NV
 SvLzO/VnItqQFb5e89rH6y9g4A==
X-Google-Smtp-Source: AGHT+IHripu9adhb/Wj04VFPqeWtoMWtm0Vz3ioWWbf/0mO/1CFBf1AlWL4cxDCWI42mTvmErAODBQ==
X-Received: by 2002:a7b:c399:0:b0:40c:617b:16ae with SMTP id
 s25-20020a7bc399000000b0040c617b16aemr662210wmj.67.1703176337396; 
 Thu, 21 Dec 2023 08:32:17 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:a430:aed0:d0bb:a5ed?
 ([2a01:e0a:982:cbb0:a430:aed0:d0bb:a5ed])
 by smtp.gmail.com with ESMTPSA id
 s12-20020adfeccc000000b0033687672e48sm1857398wro.75.2023.12.21.08.32.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Dec 2023 08:32:17 -0800 (PST)
Message-ID: <6061f08b-5f57-465f-81df-7288f3b7fb27@linaro.org>
Date: Thu, 21 Dec 2023 17:32:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 17/32] mach-snapdragon: generate fdtfile automatically
Content-Language: en-US, fr
To: Caleb Connolly <caleb.connolly@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Ramon Fried <rfried.dev@gmail.com>,
 Dzmitry Sankouski <dsankouski@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>,
 Stephan Gerhold <stephan@gerhold.net>
Cc: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
References: <20231219-b4-qcom-common-target-v2-0-b6dd9704219e@linaro.org>
 <20231219-b4-qcom-common-target-v2-17-b6dd9704219e@linaro.org>
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
In-Reply-To: <20231219-b4-qcom-common-target-v2-17-b6dd9704219e@linaro.org>
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

On 19/12/2023 17:04, Caleb Connolly wrote:
> With just a few basic rules, we can generate the $fdtfile environment
> variable to match the format used in Linux. This uses the root
> compatible property inside u-boot, with specific handling for the
> Dragonboard845c which is a special case, and for the qrb robotics
> boards.
> 
> This is known to work on supported platforms, and lets us avoid having a
> big lookup table.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>   arch/arm/mach-snapdragon/board.c | 101 +++++++++++++++++++++++++++++++++++++++
>   1 file changed, 101 insertions(+)
> 
> diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
> index b00f536d38b4..752166ea7563 100644
> --- a/arch/arm/mach-snapdragon/board.c
> +++ b/arch/arm/mach-snapdragon/board.c
> @@ -113,6 +113,106 @@ int board_init(void)
>   	return 0;
>   }
>   
> +/* Sets up the "board", and "soc" environment variables as well as constructing the devicetree
> + * path, with a few quirks to handle non-standard dtb filenames. This is not meant to be a
> + * comprehensive solution to automatically picking the DTB, but aims to be correct for the
> + * majority case. For most devices it should be possible to make this algorithm work by
> + * adjusting the root compatible property in the U-Boot DTS. Handling devices with multiple
> + * variants that are all supported by a single U-Boot image will require implementing device-
> + * specific detection.
> + */
> +static void configure_env(void)
> +{
> +	const char *first_compat, *last_compat;
> +	char *tmp;
> +	char buf[32] = { 0 };
> +	/*
> +	 * Most DTB filenames follow the scheme: qcom/<soc>-[vendor]-<board>.dtb
> +	 * The vendor is skipped when it's a Qualcomm reference board, or the
> +	 * db845c.
> +	 */
> +	char dt_path[64] = { 0 };
> +	int compat_count, ret;
> +	ofnode root;
> +
> +	root = ofnode_root();
> +	/* This is almost always 2, but be explicit that we want the first and last compatibles
> +	 * not the first and second.
> +	 */
> +	compat_count = ofnode_read_string_count(root, "compatible");
> +	if (compat_count < 2) {
> +		log_warning("%s: only one root compatible bailing!\n", __func__);
> +		return;
> +	}
> +
> +	/* The most specific device compatible (e.g. "thundercomm,db845c") */
> +	ret = ofnode_read_string_index(root, "compatible", 0, &first_compat);
> +	if (ret < 0) {
> +		log_warning("Can't read first compatible\n");
> +		return;
> +	}
> +
> +	/* The last compatible is always the SoC compatible */
> +	ret = ofnode_read_string_index(root, "compatible", compat_count - 1, &last_compat);
> +	if (ret < 0) {
> +		log_warning("Can't read second compatible\n");
> +		return;
> +	}
> +
> +	/* Copy the second compat (e.g. "qcom,sdm845") into buf */
> +	strlcpy(buf, last_compat, sizeof(buf) - 1);
> +	tmp = buf;
> +
> +	/* strsep() is destructive, it replaces the comma with a \0 */
> +	if (!strsep(&tmp, ",")) {
> +		log_warning("second compatible '%s' has no ','\n", buf);
> +		return;
> +	}
> +
> +	/* tmp now points to just the "sdm845" part of the string */
> +	env_set("soc", tmp);
> +
> +	/* Now figure out the "board" part from the first compatible */
> +	memset(buf, 0, sizeof(buf));
> +	strlcpy(buf, first_compat, sizeof(buf) - 1);
> +	tmp = buf;
> +
> +	/* The Qualcomm reference boards (RBx, HDK, etc)  */
> +	if (!strncmp("qcom", buf, strlen("qcom"))) {
> +		/*
> +		 * They all have the first compatible as "qcom,<soc>-<board>"
> +		 * (e.g. "qcom,qrb5165-rb5"). We extract just the part after
> +		 * the dash.
> +		 */
> +		if (!strsep(&tmp, "-")) {
> +			log_warning("compatible '%s' has no '-'\n", buf);
> +			return;
> +		}
> +		/* tmp is now "rb5" */
> +		env_set("board", tmp);
> +	} else {
> +		if (!strsep(&tmp, ",")) {
> +			log_warning("compatible '%s' has no ','\n", buf);
> +			return;
> +		}
> +		/* for thundercomm we just want the bit after the comma (e.g. "db845c"),
> +		 * for all other boards we replace the comma with a '-' and take both
> +		 * (e.g. "oneplus-enchilada")
> +		 */
> +		if (!strncmp("thundercomm", buf, strlen("thundercomm"))) {
> +			env_set("board", tmp);
> +		} else {
> +			*(tmp - 1) = '-';
> +			env_set("board", buf);
> +		}
> +	}
> +
> +	/* Now build the full path name */
> +	snprintf(dt_path, sizeof(dt_path), "qcom/%s-%s.dtb",
> +		 env_get("soc"), env_get("board"));
> +	env_set("fdtfile", dt_path);
> +}
> +
>   void __weak qcom_late_init(void)
>   {
>   }
> @@ -142,6 +242,7 @@ int board_late_init(void)
>   	if (status)
>   		log_warning("%s: Failed to set run time variables\n", __func__);
>   
> +	configure_env();
>   	qcom_late_init();
>   
>   	return 0;
> 

Nice, hope it will still fit for all future boards!


Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
