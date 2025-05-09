Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A92EC3ABBC
	for <u-boot@archiver.kernel.org>; Fri,  9 May 2025 07:56:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6F9DE806D8;
	Fri,  9 May 2025 09:56:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="VziZB4I5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A1D28210D; Fri,  9 May 2025 09:56:02 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7949C8059D
 for <u-boot@lists.denx.de>; Fri,  9 May 2025 09:56:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43cf06eabdaso18234635e9.2
 for <u-boot@lists.denx.de>; Fri, 09 May 2025 00:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746777360; x=1747382160; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=LxnEOfMSdtSDZ2MSZ22NEolidRzi0vam2g8uLH0Om80=;
 b=VziZB4I5dcYjNdiTdmVSFvd+9pqlkpRMQLa1fH9Q40xSlZSiOamKJvEqht6egVYEy+
 Hc17/ug5sOkGHcNeMgsEpJ2CVoHDhT4Lv+vnOVS2ITfCMDg8fxqwKxcarucdrEQC9XbJ
 4aWID2z2QgZPFasNVVq/wbIUfTzDwsKghIwVmIXM2kNHcOrMYJnNLwKrdjp9MADD8beD
 +lPfZO1AghTAnhmttsFy48jWukGnpTY7cpT8UhZBPQ2Zj9OOacTgr9MD0SoICE2qVhVS
 FrZXAbATDi7Yd5g6TTjfCF2ViYb5fERu09YcE6Veijf88cQZ0EagBlmVkSY0pgvFqcVU
 wEqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746777360; x=1747382160;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=LxnEOfMSdtSDZ2MSZ22NEolidRzi0vam2g8uLH0Om80=;
 b=FJ33Quzr8nEaQSwipCuNhXiFg3VmQ4cuofT8ticAyqqGdLNl8yF9poZVJgslrSxYVu
 bl7wcHKAbNgsfjU6N38paoosQblApMkqBtv3N3fIlayZcKXLLfwIFr7fRDWM2DGhhWfA
 UL5NSKzE/16Y5cvW1fJik6z1ReYaGLl0Qg8p6iUhiSwSFvnUTD1TwFpz4EKvH+SQggqt
 pt1fDGDMhFMxUTg9qhaSvP/6IyC8doMqAbkHlz94TJz2DkdWd5RuVSmu8Jh9ExW2TAmp
 BNMEXO8RYrmbC0PqtOd0HxttDYEU52l1FNlHI7ZaGWIfqTh9UCjYwfn1koDVgmLroH2A
 xa/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLVnD+ogmjfcmdNHWGkI8vOInu8Ir2rRz6glPXyY5sAPGyEnONUs/OdxDLEdloHO3anFvUZ50=@lists.denx.de
X-Gm-Message-State: AOJu0YxxFDM7Bt+CmsSRiLKpyVeGA1RRbfqVK+IMFlcMQWLdX9uAUBQJ
 QFZ4phR8I+yOUpT3V4Zk1RdANLUjCOKxC7vFZx1pguNB9ZitMLEE+P8fLcW6Zvw=
X-Gm-Gg: ASbGncvUipHkz/dvAQy/0QSNrFNWTcGNPbZM6oS5yLHJlayNkad0QWnqAKkCQ1Jy+sr
 8Bw9MBGuLsVnsNFZ5UG+TXd4dLM0918DyGpTLhVnVMu/jQEpO7Y5ohi/OF2rh6JHA8877eNp8OZ
 F/1kyiF7jOccmo3+JcgBKoZIN1nvPlLXKT76LWHO/Edl1ALvxLo3BsD8JwwxEewWRSJ5KZnDKwn
 vpFQlDsayk9wcGiQkTsZjW8s2ieXQaTaNjwYXmvh01j7DyAKZewkC4Fp3dQRg0GfVuQFKNZ4Imc
 bUPdNSMjZ9e4U07n8KGAocxsuQgrU+wseS2dQQnPTy9EwrGNK9JoRPBnThvWmK8DVRFQx3a9NAg
 Iy3uBMhiR3C81j88=
X-Google-Smtp-Source: AGHT+IF9pb8nPrtyTDDdVnYfv8x3EqBsFV1lbQQUOmc5MqsrD8OKuk32cSdTKu+oM1gx+nMrz/sydg==
X-Received: by 2002:a05:600c:1d8c:b0:43c:fffc:7855 with SMTP id
 5b1f17b1804b1-442d6d64aefmr17811985e9.15.1746777359759; 
 Fri, 09 May 2025 00:55:59 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:22d7:71a:9f62:f7e2?
 ([2a01:e0a:3d9:2080:22d7:71a:9f62:f7e2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442d77e6943sm8587355e9.2.2025.05.09.00.55.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 May 2025 00:55:59 -0700 (PDT)
Message-ID: <bc9aa7de-66b8-454b-b709-bf5e7f294fd5@linaro.org>
Date: Fri, 9 May 2025 09:55:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [RFC v1 1/7] usb: onboard-hub: Add support for Genesys GL852G hub
To: Anand Moon <linux.amoon@gmail.com>, Tom Rini <trini@konsulko.com>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Marek Vasut <marex@denx.de>, Michal Simek <michal.simek@amd.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 open list <u-boot@lists.denx.de>, "open list:P200" <u-boot-amlogic@groups.io>
Cc: Wayne Schroeder <raz@chewies.net>
References: <20250509070258.5077-1-linux.amoon@gmail.com>
 <20250509070258.5077-2-linux.amoon@gmail.com>
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
In-Reply-To: <20250509070258.5077-2-linux.amoon@gmail.com>
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

On 09/05/2025 09:02, Anand Moon wrote:
> Add support for the Genesys GL852G USB2.0 Hub on Odroid C1+
> and Odroid C2. The GL852G driver trigger hub reset signal
> which toggles the gpio.
> 
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
> Still some issue with USB hub on Odroid C2

What does that mean ?

> => dm tree
> 
>   vidconsole    0  [ + ]   vidconsole0           |   |   `-- vpu@d0100000.vidconsole0
>   display       0  [   ]   meson_dw_hdmi         |   |-- hdmi-tx@c883a000
>   phy           0  [ + ]   meson_gxbb_usb2_phy   |   |-- phy@c0000020
>   usb           0  [ + ]   dwc2_usb              |   `-- usb@c9100000
>   usb_hub       0  [ + ]   usb_hub               |       `-- usb_hub
>   usb_hub       1  [ + ]   usb_hub               |           `-- usb_hub
>   regulator     0  [ + ]   regulator_fixed       |-- regulator-usb-pwrs
> ---
>   common/usb_onboard_hub.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
> index 7fe62b043e6..39bbc1aefa2 100644
> --- a/common/usb_onboard_hub.c
> +++ b/common/usb_onboard_hub.c
> @@ -227,6 +227,10 @@ static const struct onboard_hub_data usb5744_data = {
>   	.reset_us = 5,
>   };
>   
> +static const struct onboard_hub_data genesys_gl852g_data = {
> +	.reset_us = 50,
> +};
> +
>   static const struct udevice_id usb_onboard_hub_ids[] = {
>   	/* Use generic usbVID,PID dt-bindings (usb-device.yaml) */
>   	{	.compatible = "usb424,2514",	/* USB2514B USB 2.0 */
> @@ -237,6 +241,9 @@ static const struct udevice_id usb_onboard_hub_ids[] = {
>   	}, {
>   		.compatible = "usb424,5744",	/* USB5744 USB 3.0 */
>   		.data = (ulong)&usb5744_data,
> +	}, {
> +		.compatible = "usb5e3,610",     /* GL852G USB 2.0 */
> +		.data = (ulong)&genesys_gl852g_data,
>   	}
>   };
>   

