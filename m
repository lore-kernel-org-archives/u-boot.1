Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DB38CD6E79
	for <u-boot@archiver.kernel.org>; Fri,  5 Jun 2026 13:09:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A78118493A;
	Fri,  5 Jun 2026 15:09:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="twAcfs3A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5BA084940; Fri,  5 Jun 2026 15:09:01 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C13A0848A1
 for <u-boot@lists.denx.de>; Fri,  5 Jun 2026 15:08:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-490bc6a7958so18407875e9.1
 for <u-boot@lists.denx.de>; Fri, 05 Jun 2026 06:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780664937; x=1781269737; darn=lists.denx.de;
 h=content-transfer-encoding:organization:autocrypt:in-reply-to
 :content-language:references:cc:to:reply-to:subject:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=36nYAO9JGrWT+6/ChfZFx5kVmLgAWZsFX51Vlvaz46I=;
 b=twAcfs3ASjGUKCz+atznSWDnggmq6UKz+OSUOGla+IMRYc3tHwSDxqXjBE8WC0GoB4
 6JHZCFje+s2RhxVh6o8e3hHaxnbPwWyvQlg5rLQ99DRx3VfpDJ4qBCpfYChtORXYnEQq
 aX/wRH83KD7TnkstHHR3ytuACU+XMK45vZ8XbwKhKgECFxMRQE56Jj5xh9AOXy7Xnt8w
 OOQ/ll5OBXrAnr85Zg4OGpvWAIFH1bA54hY253+fCMRaGWSDriBGlu1dyQ9JzQAMbe15
 hlNRTT0Bt698HgAr7tZA+6KmztGrCXMXOsULhQmRZC/Tz7UgvhqbUlKLvRpcGIYQ6ncR
 agpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780664937; x=1781269737;
 h=content-transfer-encoding:organization:autocrypt:in-reply-to
 :content-language:references:cc:to:reply-to:subject:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=36nYAO9JGrWT+6/ChfZFx5kVmLgAWZsFX51Vlvaz46I=;
 b=NQgXnqCEydSUXOVYL9GCW1FOgCfp6rV6hB1ViKwWfezDkcNywrn2sfk20bdFVbtGET
 lpIV1KuLM1jh0sjkBb+jevxCrpzaA0RNYA84XQ3OdmOCuE080OjL8KwHp5OV/aZ3KoBm
 CI2NdOPdXcHcP3rHYs99Z2/iHu3/Jb4lFBcXk4ZWkva8+vkJVGVZySZJsgTu1pKz6vpB
 tVDMDRQL6/Um4wdbZDI3JKnCS+kJPr7EBPVax/+RHuPjLGWUejZ2oZJ4SA9mcq8yDkgS
 y4UdE2IsdwGhb+wDrXASj+BNVngGvnj0jMPtFdFRlXa80rciy3MxxXic/CMDHWVk6w8E
 Cpxg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+UDrk0wVUCR9zzSHFgbJUDlAjS/RRtK8UYKr5gaUF+y9wdB91NjVhglwa3XD+fI5GQ/DfKVd0=@lists.denx.de
X-Gm-Message-State: AOJu0Yx4/ykfR6fdpTveHG2eR7SSqClE84qHPznMUcP1Q5GQQvra2KjQ
 iBzU2JCafP1iwJtHzHtiBEZnNZbO/0egXcg7rjcZ8WcZQ/jL1/B/RFoLY88Atvn12yk=
X-Gm-Gg: Acq92OGBRaiCPL/9lceblnEQNZdg11QSY60Wzwvl4PMMm3Rh6Pq9MOkL4mSGgCFFGmG
 kvpdjZD90kD9NHcJ5kz1zTIwSk1K8n4x978Ug/prSJfMaG1TcZsdaqTEPDiMQyO+bCwPb1Avrf1
 0sgDyEc4DLT8IgVvJTmftp/L4rTBjANM+wsr0Enp8C3wAJby7UZGbAoZJYQyyJQUsNEIbquHvmS
 AtBf6uYc84BeQwEk7lL+ZCsw8UL7b3QxYdAJTr6/AjUYxyvG5oY7SNJhqyu3eXOt1zsU7dNUVGn
 vJsAVmUg8ed+nhNJr+eZy8jkmLpAMdwyiV4DJhd0MfuL91iJpxxDl1ytpBoED0+uVcYNgQVl1sS
 YTej62OJL26nLrwI4yZU39iQDGtNhLpAWuedKKUK6emNOFEQpJOpvnlkWl578JNsa+12XSK6v9S
 wamK3aAcBCmS2WjBn6ZmzfQbY7ScXuNHuGxDVXLUlywvuUDas3DVI+zHHUFlrNjIDfMnFoXIpOm
 bWPfjBa7v5V/f3mIg==
X-Received: by 2002:a05:600c:8010:b0:490:b4a8:e031 with SMTP id
 5b1f17b1804b1-490c2cba8e7mr36702965e9.4.1780664937021; 
 Fri, 05 Jun 2026 06:08:57 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:b06c:5480:fdc5:c668?
 ([2a01:e0a:106d:1080:b06c:5480:fdc5:c668])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490bc3918fcsm172766705e9.3.2026.06.05.06.08.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Jun 2026 06:08:56 -0700 (PDT)
Message-ID: <c0966d58-7364-4cd1-b914-a3421f537e8f@linaro.org>
Date: Fri, 5 Jun 2026 15:08:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 04/11] power: domain: meson-ee-pwrc: use
 dev_read_phandle_with_args for ao-sysctrl
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de,
 Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot-amlogic@groups.io
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+usb@mailbox.org>, Simon Glass <sjg@chromium.org>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, Casey Connolly
 <casey.connolly@linaro.org>, Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Paul Geurts <paul.geurts@prodrive-technologies.com>,
 Primoz Fiser <primoz.fiser@norik.com>, Yao Zi <me@ziyao.cc>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Peter Robinson <pbrobinson@gmail.com>, Peng Fan <peng.fan@nxp.com>
References: <20260604-devapi-v1-0-961aded05ff4@nxp.com>
 <20260604-devapi-v1-4-961aded05ff4@nxp.com>
Content-Language: en-US, fr
In-Reply-To: <20260604-devapi-v1-4-961aded05ff4@nxp.com>
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

On 6/4/26 14:20, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Replace the manual ofnode_read_u32() + ofnode_get_by_phandle() sequence
> with a single dev_read_phandle_with_args() call to resolve the
> amlogic,ao-sysctrl phandle. This is cleaner and avoids the intermediate
> phandle value and ofnode_valid() check.
> 
> No functional change.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>   drivers/power/domain/meson-ee-pwrc.c | 13 ++++---------
>   1 file changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/power/domain/meson-ee-pwrc.c b/drivers/power/domain/meson-ee-pwrc.c
> index 6361f3a6c59..882238f2937 100644
> --- a/drivers/power/domain/meson-ee-pwrc.c
> +++ b/drivers/power/domain/meson-ee-pwrc.c
> @@ -435,8 +435,7 @@ static const struct udevice_id meson_ee_pwrc_ids[] = {
>   static int meson_ee_pwrc_probe(struct udevice *dev)
>   {
>   	struct meson_ee_pwrc_priv *priv = dev_get_priv(dev);
> -	u32 ao_phandle;
> -	ofnode ao_node;
> +	struct ofnode_phandle_args args;
>   	int ret;
>   
>   	priv->data = (void *)dev_get_driver_data(dev);
> @@ -447,16 +446,12 @@ static int meson_ee_pwrc_probe(struct udevice *dev)
>   	if (IS_ERR(priv->regmap_hhi))
>   		return PTR_ERR(priv->regmap_hhi);
>   
> -	ret = ofnode_read_u32(dev_ofnode(dev), "amlogic,ao-sysctrl",
> -			      &ao_phandle);
> +	ret = dev_read_phandle_with_args(dev, "amlogic,ao-sysctrl", NULL, 0, 0,
> +					 &args);
>   	if (ret)
>   		return ret;
>   
> -	ao_node = ofnode_get_by_phandle(ao_phandle);
> -	if (!ofnode_valid(ao_node))
> -		return -EINVAL;
> -
> -	priv->regmap_ao = syscon_node_to_regmap(ao_node);
> +	priv->regmap_ao = syscon_node_to_regmap(args.node);
>   	if (IS_ERR(priv->regmap_ao))
>   		return PTR_ERR(priv->regmap_ao);
>   
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil

