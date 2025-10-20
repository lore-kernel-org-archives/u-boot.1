Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12CB5CCD199
	for <u-boot@archiver.kernel.org>; Mon, 20 Oct 2025 07:40:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 91B8883211;
	Mon, 20 Oct 2025 09:40:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="RJLC0lJI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 87462807C0; Mon, 20 Oct 2025 09:40:23 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8731B8334F
 for <u-boot@lists.denx.de>; Mon, 20 Oct 2025 09:40:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-47114a40161so43855215e9.3
 for <u-boot@lists.denx.de>; Mon, 20 Oct 2025 00:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760946021; x=1761550821; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=blbc/ufR6n+sfNqM3ac3iZbVayACCnw0cMfcOhwwWgk=;
 b=RJLC0lJI5GBMRRjD3+LcFkw8aTG1Y4qyd4B5QNZt8P194Yv4C4d0rZjdcENSm5RIsT
 FB0k3k4Xnohymd8q6pFgjzlKpjmelbtEWFazCciHo+96a1prUU/ChfVVl8DTnvANhE7P
 wtcUvLBGkH5ebDp02fhK78j5RhYpqiSzCilWCwp7GAIEqD5EQqp8I7eHXZnMLCb6fUzi
 UXprO+9GAAXhJqrHdyjS8D4Ts2kMPjKXMGA5MGkiCv+cpoPkvD+YRNcHSUteviROSjGg
 O+e4BeZuyG6ZAUBBaCQQAVHC+XPoJ5D6jJJ1dWBNh5urI/NmH4yK9UhDwZwA1BU2BBjy
 DdkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760946021; x=1761550821;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=blbc/ufR6n+sfNqM3ac3iZbVayACCnw0cMfcOhwwWgk=;
 b=LOJ7uNSiekq2Hd7PwXfQq5FRkmgVwPxP5zGzhyRGPoz1DiTsFVL4QLqRYafRHO2Jol
 t81NWdVUSAYlLmE7rV1QclO3OU/4MOajmur0fFt5pYFMo3PnXzjpiR90zOQWyfTib4Qx
 BLb+cmtcs9S7biUcK9HeJPki2V9ZOkKvLAKQnbGpMGwnRdCohZqnGApqZp/Kq0QY5NSj
 uryIGOBEbOV6l695C4oKhrCFMVReGu1bxR7+ZW5J3jMubVmrWqF1tz7gKvZCqM/tz1CD
 XVJS6/hWXAMI0GTzrdg4RE+zHZ35JAFycxWVcyV/0Rtd7vN/BEHXRNoK4xmKf+zF+oIK
 vqLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVfUFQZx5D4LhJBuWwZJpN4l+ZpolgkL5ExZdgvBrOpm9dIr8cwnAVt7mSGwdfVcjCBbWXsGFk=@lists.denx.de
X-Gm-Message-State: AOJu0Yx9d7GC8M6bbjdaJj/7n1Id0wDgsah+W/RXVnmhj3lWGxD8X8be
 iItC/U0fO6EVmR59EBFhCbrZmCQ2PZ+UuJLnItnKgfieTaK7MqAH5kqHoIlwf/5jfwc=
X-Gm-Gg: ASbGncvrVxtErw95Fgr+8IJZBJM8iFjiFjaUnb/3WjV4hKCf50vn/nZElIBKajIoQ8/
 /GJDF2Tz5fgJ0HzAq+ZJFKHtDUJWBY5k20xznqNlcXtSe8mEwCULRcNmbOMrYPu72xkXRNeutgj
 TcP4BR2FBROwxyGiz6y8WispjOl7MxgLbA495CxseitFmh7BHDTRn3rxn8JUcaC+3GyE7b52RGF
 0YyBYHhvgzTKXItLRRWqJ+Pj5psmXGWVoAffDJRoqWHz4rew8edYD1zo9WJMG05Xy1d+zV3UKhJ
 9XWb8xLCi3J+fQ2bIiS3PO9AAczim6P4WaH15XkBPfLHeBrPtJd8sOCIschOvt6P8OgurggLKus
 XSpqytUJENIQhL9EFKaWuAZiJNZKTRyFfm3yvmvJPnyZE7TCyE+vvYfcgkC0gmseXTf2PVrXHje
 yXWSAcAL55JDZjKkFp9UBlfwW8dHq/TQZIueyTyNL3jDL96boP32ysiyWYwf6I
X-Google-Smtp-Source: AGHT+IG4mLASjykEwGFsC6bmyi/iCxw/qyvg5SrVJd+ZlbejFYDjsuz7e8C6xD0mYprNwfyw6UOtdg==
X-Received: by 2002:a05:600d:4395:b0:471:a259:cdbe with SMTP id
 5b1f17b1804b1-471a259d086mr27449325e9.23.1760946020835; 
 Mon, 20 Oct 2025 00:40:20 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:4f9c:f978:568:7b9c?
 ([2a01:e0a:3d9:2080:4f9c:f978:568:7b9c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4715520d753sm130889715e9.13.2025.10.20.00.40.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Oct 2025 00:40:20 -0700 (PDT)
Message-ID: <b39a87cd-2d36-41d9-bd42-a40939749310@linaro.org>
Date: Mon, 20 Oct 2025 09:40:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 1/2] ufs: core: Add ufshcd_dme_enable() and
 ufshcd_dme_reset()
To: Shawn Lin <shawn.lin@rock-chips.com>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>
Cc: Kever Yang <kever.yang@rock-chips.com>, YiFeng Zhao <zyf@rock-chips.com>, 
 u-boot@lists.denx.de, Heiko Stuebner <heiko@sntech.de>
References: <1760923754-47718-1-git-send-email-shawn.lin@rock-chips.com>
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
In-Reply-To: <1760923754-47718-1-git-send-email-shawn.lin@rock-chips.com>
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

On 10/20/25 03:29, Shawn Lin wrote:
> In order for host drivers to use.
> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
>   drivers/ufs/ufs.c | 30 ++++++++++++++++++++++++++++++
>   drivers/ufs/ufs.h |  2 ++
>   2 files changed, 32 insertions(+)
> 
> diff --git a/drivers/ufs/ufs.c b/drivers/ufs/ufs.c
> index 57e6e8c013b..92cd9ad239f 100644
> --- a/drivers/ufs/ufs.c
> +++ b/drivers/ufs/ufs.c
> @@ -368,6 +368,36 @@ static int ufshcd_dme_link_startup(struct ufs_hba *hba)
>   	return ret;
>   }
>   
> +int ufshcd_dme_enable(struct ufs_hba *hba)
> +{
> +	struct uic_command uic_cmd = {0};
> +	int ret;
> +
> +	uic_cmd.command = UIC_CMD_DME_ENABLE;
> +
> +	ret = ufshcd_send_uic_cmd(hba, &uic_cmd);
> +	if (ret)
> +		dev_dbg(hba->dev,
> +			"dme-enable: error code %d\n", ret);
> +
> +	return ret;
> +}
> +
> +int ufshcd_dme_reset(struct ufs_hba *hba)
> +{
> +	struct uic_command uic_cmd = {0};
> +	int ret;
> +
> +	uic_cmd.command = UIC_CMD_DME_RESET;
> +
> +	ret = ufshcd_send_uic_cmd(hba, &uic_cmd);
> +	if (ret)
> +		dev_dbg(hba->dev,
> +			"dme-reset: error code %d\n", ret);
> +
> +	return ret;
> +}
> +
>   /**
>    * ufshcd_disable_intr_aggr - Disables interrupt aggregation.
>    *
> diff --git a/drivers/ufs/ufs.h b/drivers/ufs/ufs.h
> index 0337ac5996b..ebbd5d6cad7 100644
> --- a/drivers/ufs/ufs.h
> +++ b/drivers/ufs/ufs.h
> @@ -435,6 +435,8 @@ int ufshcd_dme_set_attr(struct ufs_hba *hba, u32 attr_sel,
>   			u8 attr_set, u32 mib_val, u8 peer);
>   int ufshcd_dme_get_attr(struct ufs_hba *hba, u32 attr_sel,
>   			u32 *mib_val, u8 peer);
> +int ufshcd_dme_enable(struct ufs_hba *hba);
> +int ufshcd_dme_reset(struct ufs_hba *hba);
>   
>   static inline int ufshcd_dme_set(struct ufs_hba *hba, u32 attr_sel,
>   				 u32 mib_val)

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
