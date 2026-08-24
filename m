Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F885C5DF9C
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 13:01:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2200E80AB2;
	Mon, 24 Aug 2026 13:01:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JrUvRWe1czLO; Mon, 24 Aug 2026 13:01:26 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787576485;
	bh=8aufkQEztgqHKqqqiuyiZhAHIJSkdXnuAw9Xl6TbdqI=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=cPRPJEl6cs+NAZU7xHbKqG/UCsdlUNIkWyOu0C5E5GtRuzlJZ4xrRc6kznWT5KGGk
	 ujndmxwAnZLM9YAM6itdcwyWcDv4eucmt2WbbsMkCnCA/YDwSOyXqKwgragsLskJ7+
	 Nk7yP+Zhm2HVTfcGNuJuIneNwWBe/7QwtrkKsXtArumgZcoMCARgfR3H0EY1py5zwE
	 GgkqDPR1/OKDhJnGfqct7Ys9PJF5DSc+skgy3agRRvHnRF3tO88s26D4yEfnE2kdZ7
	 wSRQVgCxCGXEz/aF99dAXC6+0GiHzI9/ANBJzzvYCjfsRg/zzYTPv80ryanXuXPNXM
	 Il4Wukhi+pr3A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C8A25807A1;
	Mon, 24 Aug 2026 13:01:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 567A2386
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 13:01:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3C56F605E5
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 13:01:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id auRZEwwu-1ar for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 13:01:23 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::430; helo=mail-wr1-x430.google.com;
 envelope-from=neil.armstrong@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=AMKqablJ
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 50347605D5
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 13:01:22 +0000 (UTC)
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-47fe377a217so1620811f8f.1
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 06:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787576481; x=1788181281;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8aufkQEztgqHKqqqiuyiZhAHIJSkdXnuAw9Xl6TbdqI=;
 b=AMKqablJZqMlhAoC8sFmJW71cQ2+E0oVp7+2Lk/q1FJRVj1B/lbkLwd1gQzLkUPsTa
 LTjiyf8Ehpg0ae3jtD457DDpqdRAkfUdtorVwwK7Rd+Ne1uYR+kvOYQTxnEn3Y9xw/nv
 ER7VBrr/y9PhKqF9t4dg9xKezGVe27lrXtL5f66Nna7Z3yg5xRjft8KGq8J4hKPz3MOq
 Q5BuGsjhk8OyFTyPTW3R7qu2AbXwbV1Aa68iMQlPtsGL9ijCVVsPKkpnjONk+IYRJDWY
 22TdZB7i4nSEJSvtRyeeh7gUbz3T7JeOX1KKOlyaTpuI6nf4QJ0JfodRN/mcTHsvVnNE
 YUBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787576481; x=1788181281;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=8aufkQEztgqHKqqqiuyiZhAHIJSkdXnuAw9Xl6TbdqI=;
 b=FFWNIl8HPcD89DC08n1DDYxw9GnY7Aze6uUx+JHMpH7k83dT345SKOeXSDvFly6bWi
 q1+koXUGFewHrhphZ2u6wR55xZt/pNJussYV/ulqyWQWZKmbZTp37VrUT/pprTq6hpyp
 wTlslzJMhvLlVnGqRhm5pn5rt5J/Cr/MhC7ZFTB3WGs4WNnbIEYnO6Ecsrt3MKTHn+co
 AOxkIB3UM54GVxqYxnAycFPPwiEFsEPq7aqeFlGsRKYVg8k4PJurv33eBayqyySrJQAe
 ygVCFDgZPegVSlgQ55a5ln1kYFoyuhpogxAv1/XbbumrY/lLQCWmg5eqyTsnLyuHGMLW
 QXDw==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro4E1OkdyllluT8SzywPlwcWbX0V7oIe/sPkymXq1JXTGVSfgYEJabPM+MuX0G9ORPR815lfEU=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mFIqnne3wGlW6bRrdWqRtO9wKN3lGsUn87NucGiVIA7rii/V39
 nA+If8JHKbakFjF947h0YY2cIPKHmPkEU/yva+6LXfvW1cb0QJe9Jm0ECN2WknZMhhw=
X-Gm-Gg: AR+sD10S6HS/whWs+D8gAXld42p+BabMYUf5Y6qb6qB1eWOtSTXav2c100TImQThmUY
 qLoGbmq1GxZpLUCbz0leaxQ48he16+5t8KsdbNBxDWisXpahe2ox/H5wzD5CRFK+7SWoNSQdGjl
 4W6STyjGrOLi6Ix/0sd0e80vSf5516jBfviGeoKEDxeScCtdqSzGSLfz24yBjcR8cKLNN58oRRC
 4NBcKw0gI8MjyoGIDTBY5qxv81N2YWAgjRLb7nU3pexgLBkgDXF4mcSBsA5TxVSLDzHZDOXrU/G
 iSxK7PwedZdTsHI2UoEtE7j99H0KvZK5K0S3wHqofIu0IKu66BMegK6i0FtrHLZD0SbN5M9T1kz
 flawBb9TDxZUuL7VBoywzkidN7Q+FAMn/Nt5O+KhY6tmHucW5mjmhd+zLNqoZRtOVTySmmAiwaC
 sSA3hkGo5LAQpc/9OZumu1kaCk1qCacsfNPzM6C0X/b31ic8ZaBnHU/uS8qqCiIhGAd2pwOhXvp
 jcjb7IpNmwedsHgg0pPJUnr7KQjRumrLjGfKu+F2w==
X-Received: by 2002:a05:6000:2309:b0:47f:9447:62bf with SMTP id
 ffacd0b85a97d-482c0b54855mr31826012f8f.2.1787576477812; 
 Mon, 24 Aug 2026 06:01:17 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:a2ce:e3d3:a5a2:273?
 ([2a01:e0a:106d:1080:a2ce:e3d3:a5a2:273])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482c9c0bef5sm8344261f8f.31.2026.08.24.06.01.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Aug 2026 06:01:17 -0700 (PDT)
Message-ID: <56b25fc4-cee6-4ca6-862f-481ba3c0454d@linaro.org>
Date: Mon, 24 Aug 2026 15:01:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 1/2] pinctrl: meson: a1: Use gpio regs for ds
To: Sean Anderson <sanderson@brivo.com>, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, u-boot-amlogic@groups.io
References: <20260817170313.1940219-1-sanderson@brivo.com>
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
In-Reply-To: <20260817170313.1940219-1-sanderson@brivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 8/17/26 19:02, Sean Anderson wrote:
> On newer SoCs, the drivestrength registers are included with the rest of
> the GPIO registers. Linux has a rather complex system that uses a helper
> function to fix up the registers for each SoC before registering the
> pinctrl. Instead of that, just fix things up in probe.
> 
> This silences warnings like
> 
> meson-s4-pinctrl pinctrl@4000: drive-strength-microamp not supported
> 
> which I encountered on s4 and which I assume affects a1 as well.
> 
> Signed-off-by: Sean Anderson <sanderson@brivo.com>
> ---
> 
>   drivers/pinctrl/meson/pinctrl-meson-a1.c | 12 +++++++++++-
>   1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pinctrl/meson/pinctrl-meson-a1.c b/drivers/pinctrl/meson/pinctrl-meson-a1.c
> index 7e9ac6390b1..e9a7522ce50 100644
> --- a/drivers/pinctrl/meson/pinctrl-meson-a1.c
> +++ b/drivers/pinctrl/meson/pinctrl-meson-a1.c
> @@ -856,11 +856,21 @@ static const struct udevice_id meson_a1_pinctrl_match[] = {
>   	{ },
>   };
>   
> +static int meson_a1_pinctrl_probe(struct udevice *dev)
> +{
> +	struct meson_pinctrl *priv = dev_get_priv(dev);
> +	int ret = meson_pinctrl_probe(dev);
> +
> +	if (!ret)
> +		priv->reg_ds = priv->reg_gpio;

Please add a comment on why you're doing that.

Neil

> +	return ret;
> +}
> +
>   U_BOOT_DRIVER(meson_a1_pinctrl) = {
>   	.name	= "meson-a1-pinctrl",
>   	.id	= UCLASS_PINCTRL,
>   	.of_match = of_match_ptr(meson_a1_pinctrl_match),
> -	.probe = meson_pinctrl_probe,
> +	.probe = meson_a1_pinctrl_probe,
>   	.priv_auto = sizeof(struct meson_pinctrl),
>   	.ops = &meson_axg_pinctrl_ops,
>   };
> ---
> base-commit: d3e8597e46b635ec556a057bc42f0b0859654bdf
> branch: s4_pinctrl
> 

