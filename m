Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3642C677C4
	for <u-boot@archiver.kernel.org>; Tue, 10 Jun 2025 18:47:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A6FE982B18;
	Tue, 10 Jun 2025 20:47:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Iy3ODGX4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C61C82B20; Tue, 10 Jun 2025 20:47:46 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 23BD682B07
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 20:47:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3a4f379662cso4809070f8f.0
 for <u-boot@lists.denx.de>; Tue, 10 Jun 2025 11:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749581263; x=1750186063; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=7zkgUk0aPA7oS5zUZiu/PgP8MY1evOgnF8MjscHJ764=;
 b=Iy3ODGX4OAXgxs7NjRvCLx1yDioz4+MoD6tJfOZkKlSpytKUpwcjrFA7oicGrU3ZQd
 lIKhW4wAGyUi4Pu5cscbRU7BL5H8cJyIDfIMW1qkVuMBabXLrWrkdESjDyEBeoKti9hW
 KZ64keQJwMsehufkdSVRjyeVoals/0c977a/aBEs2dxzSmE9nl/8F7YQrbpkaGrae09n
 mfPERzLE2b5GkPHYQsdK27r4TW+v1Dw7KuFByT79FJxErMpbgGB8hZUish8yIroUbypG
 H8UfGWQ4lmgCMhdZWqUzw11/IwyAdWafAu3OJB3Gj1YWKmIgK35IIjYshDiqaF7i9x19
 LaIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749581263; x=1750186063;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=7zkgUk0aPA7oS5zUZiu/PgP8MY1evOgnF8MjscHJ764=;
 b=eeY536IBtiMvtv0WO3Gjwcwevd8rX4Rk1NLw+y/Vn15Zmxo10Iw7XLIpasflBne43P
 LstIJ6kb/QEmt4mCMAx7OBjLEwIAVcgXxcMD7I/ZXAoDJzHRCa205epNCb3wHHdg19K4
 GEWAu3+DRnWFDwvLDJlDdb12AuDvOxna4jIRmDIseRSQRp7mlR9do2JFGAkVfGF8SomS
 wsPuGw91HtDI1P28Hgg0tMfWAAps23AeH/GaH5WIS0Ihhyq87Xmk7LTkbhL+jcKHqZCP
 5p9+jgp+av7Jbgiw8kQI4PABszUY5iayGrr1Zg4IMYPK6nY3S9W+kz+pwLy4hTJuuQ4/
 z6gw==
X-Gm-Message-State: AOJu0Yw/rzAwXvP94nvItoyIybzFGj4+/oR10mzqFvqqeOIhmSpXRQNU
 TrNW+0hYq0I57bWLbFJrE2HwfZUMgnuax9eu52WLYFoY955fF82qBg1uN01PFJ39Ufk=
X-Gm-Gg: ASbGncsKfaUID/Qme9GUCZQrfziC70mnnPVb9QeYyODJCYOrBUrwERHI+CCK2IgOvvE
 hKyIUnFLFwlWrYzmyZN4//xJmwARgjwTNFR8M4OaY3lj/C21Fh+PEGJP/dNvVEEKnXFSyMDIlcZ
 1LQXuGrQ03EoHbBh9Ib10e8UH8libKIOU+R9s3RBYl/Wu/p4jVPzrcWJov7J0kpbCrwd2aqPYNm
 7Kz5ApqZ1JC/SfEJBjUDtdIR1zaeu1F58x37ZUOrTCux7N1OXmwJY/+j/ntOjaNwz7l+u+N3ihA
 n49ykBf2tjLWyirSCWYAKzC4zfWCc+So6a7rWrWV+azXM904qgt83O3Soq+//CnY+mbRXo8Bv7y
 +E9h7n44lnpv5lY+ovm8A86stm4LAXJAPIsi8
X-Google-Smtp-Source: AGHT+IESuY5mudCcEjgT4ZXbD/ayKe/Vsa6BK9Zve+jzvqISEML8ImQJAXdEweqUX9bXmtLDCAhkNg==
X-Received: by 2002:a05:6000:381:b0:3a5:27ba:47c7 with SMTP id
 ffacd0b85a97d-3a558a319efmr114086f8f.48.1749581263535; 
 Tue, 10 Jun 2025 11:47:43 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:f0b:a9b6:d508:9d14?
 ([2a01:e0a:3d9:2080:f0b:a9b6:d508:9d14])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-453247cbc8dsm1939895e9.12.2025.06.10.11.47.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Jun 2025 11:47:43 -0700 (PDT)
Message-ID: <77152c78-a719-4310-a354-d829d054787c@linaro.org>
Date: Tue, 10 Jun 2025 20:47:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH] Qualcomm: maintain trogdor so CI passes
To: Casey Connolly <casey.connolly@linaro.org>,
 Greg Malysa <malysagreg@gmail.com>, Igor Opaniuk <igor.opaniuk@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Robert Marko <robert.marko@sartura.hr>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@kernel.org>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250610165958.152573-1-casey.connolly@linaro.org>
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
In-Reply-To: <20250610165958.152573-1-casey.connolly@linaro.org>
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

On 10/06/2025 18:59, Casey Connolly wrote:
> Add chromebook_trogdor_defconfig to MAINTAINERS. This is a Qualcomm
> board so for now I'll maintain it under ARM SNAPDRAGON so that we can
> get these fairly invasive (but very useful) patches in which improve
> Coreboot for all ARM platforms.
> 
> Hopefully someone who owns this device will be willing to take over
> as MAINTAINER.
> 
> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
> ---
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d62dd35a385b..789e6f0c37b8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -670,8 +670,9 @@ F:	drivers/serial/serial_msm.c
>   F:	drivers/serial/serial_msm_geni.c
>   F:	drivers/smem/msm_smem.c
>   F:	drivers/spmi/spmi-msm.c
>   F:	drivers/usb/host/ehci-msm.c
> +F:	configs/chromebook_trogdor_defconfig
>   N:	qcom
>   N:	snapdragon
>   N:	qualcomm
>   

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
