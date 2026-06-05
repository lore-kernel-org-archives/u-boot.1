Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44E9DCD6E74
	for <u-boot@archiver.kernel.org>; Fri,  5 Jun 2026 08:06:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9AEF084879;
	Fri,  5 Jun 2026 10:06:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="YC+kGkWp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E59A848BF; Fri,  5 Jun 2026 10:06:19 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5FDBD838BB
 for <u-boot@lists.denx.de>; Fri,  5 Jun 2026 10:06:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-46013161068so784719f8f.2
 for <u-boot@lists.denx.de>; Fri, 05 Jun 2026 01:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780646776; x=1781251576; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=mgcEqEEATw1N8v+XXVmdeOJ1VjVWW/kOYIpBQijdx3Q=;
 b=YC+kGkWp1dcUlF7Srpsfju8bD0IEcneuXbKZspRdweWB6kSdRrBGlMD4QCaZUP98VI
 6UVuLxMu77fWOGd9677x8cKiXDXyZsTPEYFjgylJTFCoTm/fHZw1pP6Bfh4zz3CFl+jC
 acpg3SLvzDu/VJOyj1ca9gVNt002EN3oxRcLk698Beaq9vP4KcXXiGLc4HW6GyhQyW1X
 +iF4BR7vA/IUmznKLDeT8Ip5ylfgXVOcUiFyUVK5mgxUBbC40G1vFm+NzFoRObewxszh
 qX60cvzdZlFgfYmZ5wpIjgdoWK2Q02BZkcIzhikqfA0JguAuxRn6e2l795o69xnZAcD+
 4moQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780646776; x=1781251576;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mgcEqEEATw1N8v+XXVmdeOJ1VjVWW/kOYIpBQijdx3Q=;
 b=a9Oqt6kznVZg5ZrirlWH1fMUw5ZPs/57hLuKtgTddv5YQU/BJMcn/M+/HWy7uV3gom
 p3s2TO+IeO5pCmssMCPvnOC+jf7Pd2/jxBGYzn9204FTeDS22nrjo0JmhAgZ1/DbAdaX
 /i1/HE6O9ZqVS0BAzUiDfFXlJY27ey8ozYO9woboYl9dHFwSG3rGrUkVKXW/zQlWgcAU
 /mCf1feqZHmKCMtGBMlnaRtn1O8GXTeHF1fLbjiC1a7qsKgtw9+fdR+v5XOv7wMTrJ+z
 XvJ6hdA4Fw4mxjh84P+EdXPsg2bqOfuZMahGqMzhya9R3tlZGgTpmHFYQOpwheLy7l0X
 QSJQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/byYsbzdlobksYvvY1eDGDyKCwT+n0UTWIcanjYHm3v9aMH8CSwENCe+qe8ozcbkg/MKY3ZOw=@lists.denx.de
X-Gm-Message-State: AOJu0YypTpiKHXnaPcDkCN1Fn0HjRhwRAlPmdskWNikgMzwGK8FgVy8Q
 yh/a5+7tq7LJFeHwXsvXKNVJZCh8dX0pbSy4fQ3kh04FIZsNCj1WaHOuURTNyED3DZA=
X-Gm-Gg: Acq92OFhG+cDNJnlJJFy4DAi8aN8c2TGJnRZrjGqTKr+m6WCrNSVn07asI4mepQj3Ex
 8fiIlIxl26x55izZcnBzmPg0OaGDLa8APgZudHJ9l10fMz2jYM0Vsksp3ooniHjmNuqC97IfP2p
 YA+Lh5+P8CHDctVEUkR+BlOCBs12K9pjRkZXCG3y1lZ78T6OAuFvj2dGFFu+JiL8x79ik/VE6Y5
 J9X6athSOMQiRU/QmpuvPtPM4GT5nf5gmC6B4RBHkLNMvsBeDjdXrAM3523Shal6p1aNLEvjXfQ
 YUsQ9V7BhM2kHiNgbL79d0rh23/ud8AQkgk+jM9PIhNzejp3o5n/IbKMnMmN9IvebGTYkGsp7Dw
 yA6JXE9CsR0nMTeaEpqr/jAx+edw6K2o+3c3egW8UE8xvL2fU8RcAZSJJCczJB+ov3JpbyEvA3e
 KMqA5wrPpkk6CLvm4XM0AIuy9Mos/K56GbOSVKbfOLnGKQ6L/4Qrw8shY2zaeCKk0w+OTJgmCja
 eRsonYXw2TcNbl09A==
X-Received: by 2002:a05:600c:45c6:b0:490:b1ab:e41a with SMTP id
 5b1f17b1804b1-490c260d1f2mr34958175e9.32.1780646774903; 
 Fri, 05 Jun 2026 01:06:14 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:b06c:5480:fdc5:c668?
 ([2a01:e0a:106d:1080:b06c:5480:fdc5:c668])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490bc3a87dasm122973565e9.7.2026.06.05.01.06.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Jun 2026 01:06:14 -0700 (PDT)
Message-ID: <4c060578-ab4e-40ba-9f92-5d85fb11e818@linaro.org>
Date: Fri, 5 Jun 2026 10:06:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 05/11] power: domain: meson-gx-pwrc-vpu: use
 dev_read_phandle_with_args for hhi-sysctrl
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
 <20260604-devapi-v1-5-961aded05ff4@nxp.com>
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
In-Reply-To: <20260604-devapi-v1-5-961aded05ff4@nxp.com>
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
> amlogic,hhi-sysctrl phandle. This is cleaner and avoids the intermediate
> phandle value and ofnode_valid() check.
> 
> No functional change.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>   drivers/power/domain/meson-gx-pwrc-vpu.c | 13 ++++---------
>   1 file changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/power/domain/meson-gx-pwrc-vpu.c b/drivers/power/domain/meson-gx-pwrc-vpu.c
> index 325296b0dd7..e08c0fac49a 100644
> --- a/drivers/power/domain/meson-gx-pwrc-vpu.c
> +++ b/drivers/power/domain/meson-gx-pwrc-vpu.c
> @@ -283,24 +283,19 @@ static const struct udevice_id meson_gx_pwrc_vpu_ids[] = {
>   static int meson_gx_pwrc_vpu_probe(struct udevice *dev)
>   {
>   	struct meson_gx_pwrc_vpu_priv *priv = dev_get_priv(dev);
> -	u32 hhi_phandle;
> -	ofnode hhi_node;
> +	struct ofnode_phandle_args args;
>   	int ret;
>   
>   	priv->regmap_ao = syscon_node_to_regmap(dev_ofnode(dev_get_parent(dev)));
>   	if (IS_ERR(priv->regmap_ao))
>   		return PTR_ERR(priv->regmap_ao);
>   
> -	ret = ofnode_read_u32(dev_ofnode(dev), "amlogic,hhi-sysctrl",
> -			      &hhi_phandle);
> +	ret = dev_read_phandle_with_args(dev, "amlogic,hhi-sysctrl", NULL, 0, 0,
> +					 &args);
>   	if (ret)
>   		return ret;
>   
> -	hhi_node = ofnode_get_by_phandle(hhi_phandle);
> -	if (!ofnode_valid(hhi_node))
> -		return -EINVAL;
> -
> -	priv->regmap_hhi = syscon_node_to_regmap(hhi_node);
> +	priv->regmap_hhi = syscon_node_to_regmap(args.node);
>   	if (IS_ERR(priv->regmap_hhi))
>   		return PTR_ERR(priv->regmap_hhi);
>   
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
