Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23958C3ABCA
	for <u-boot@archiver.kernel.org>; Fri,  9 May 2025 07:57:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8A7282958;
	Fri,  9 May 2025 09:57:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="CwYmZkTJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 85C138294C; Fri,  9 May 2025 09:57:11 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 976BF806D8
 for <u-boot@lists.denx.de>; Fri,  9 May 2025 09:57:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3a108684f90so871934f8f.1
 for <u-boot@lists.denx.de>; Fri, 09 May 2025 00:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746777429; x=1747382229; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=FBjTLfQ4AhJpzJkA5Qo6kqbiHyIan+7HgHTbezLqgaM=;
 b=CwYmZkTJYh44tkhPfMreSyzH17mIMOfxZd7F7kMj89HBCPOG3tPYH7Szueoz/ULu9c
 XtmOZFVMIP44v+4v2HUCSwHJ07qNN1KOBfcnMoFHOcpK5m3KvJ2/pst55MwWdCA6LJ6R
 PIvA8w2lP4zIF+wf8KiqFmaqus7JjOtz1JtncKN9k9a1qjDHHZty4u2K6lO+7gyzJeaS
 g5IE05rpy7tJRUVIWOiGAjPw/aVBAVMZ58giVHhC6tiL6HSf1eGLyd7ub+GNHv3wkoxh
 VENrFboteex26aocFDV8NAWKm7zMQYnf5duF6l3bk24fg7IHqgEJ/PU3vdwYrBGJ2JNz
 DCEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746777429; x=1747382229;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=FBjTLfQ4AhJpzJkA5Qo6kqbiHyIan+7HgHTbezLqgaM=;
 b=mPHdygnDDU19ObzpJSGfAWYI7nR8eBsquTnh3x9UQ7GLrmPeqZ+BSgcMv6qQ7fXiyT
 fs3IoN+r0UL+tyxaiPhet2OP85/UpCIdKtvAVBuZ0bqm2fflRyAr/wm/ikCAag3SOioG
 02rFAbtxnFSL1Fhk0iVRMQP+NazYaxVya3sM5UigKOLa23a9qGF9mBOADeEGHMximP4S
 BEAErxxYgkflpQdk5AL32DrihUKENIeLiw5uxzgr9dg/xplnTuSNBdBqbe7zTl743NtM
 Q5HWeingExv/Hw2dUwLJEjqd26hnJWUhTjjVJxMNVUXB2a6g3Y0wyEO41L/zv2S0Mulq
 4d2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1hQ/anXHjAmV0yWjXTg4p5WNld2sMCy7Nwt1FcKVOUMR2LP5ryVr0Tf3BIVYUxNVX74mQnx8=@lists.denx.de
X-Gm-Message-State: AOJu0YwRBXR+n8ChCJU121mOyPAG/Knh3xwzDKogQ+Ogbb4WN+yTeC5S
 ezPzLjV+1KQbbK1Op/PdXEtZ/VCpDr1WOlSqovPTpYqtsf2a4VifAjAbL6GFXUQ=
X-Gm-Gg: ASbGncs7hMcqvh2JNTPtKcmVskjNkd8x2+KjnmggY4Q1RDLMy4RFNaKUAa17aeH5FXU
 e9svjhwqorAUiQMBec8ZcQU17IG56oy2ZWwcmmgtsFLAo1QGeFJIHy9cor7NVg4t1BPax66r9Ql
 ZsMYSNCRQOQRbAQPKJRBYjO0ffvPxZCnhOmmLNaH/bUaN2MPNdy/1043YcAVNy4xdwL+goQiP7c
 RvK0SqJmNml2J7puEEE/39Uw/3K8Lu6ZQzrAiErHzGG8unGRzC5axp3WOnSO+V037PJgyBnWe5W
 +tYZZyU8jlbnYob4hE1MKU2vYghoOxnPnzPmbRgkx92d2TP94qd7D57PY7in4jcO62WfU4SL5z4
 xAI/tfsbjmnou7Pj1KHfJjz9n6A==
X-Google-Smtp-Source: AGHT+IFluptaWC2Si9dtFIGgSWzThEXrDpBy61T+VHt4xpRZ4zIXhNmx67A/Kv6G9dvGgW9MtJ3d/Q==
X-Received: by 2002:a5d:59a8:0:b0:3a0:831c:dff6 with SMTP id
 ffacd0b85a97d-3a1f643115bmr1952428f8f.18.1746777429029; 
 Fri, 09 May 2025 00:57:09 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:22d7:71a:9f62:f7e2?
 ([2a01:e0a:3d9:2080:22d7:71a:9f62:f7e2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f57ddde0sm2485222f8f.14.2025.05.09.00.57.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 May 2025 00:57:08 -0700 (PDT)
Message-ID: <8a57e0d5-bc7e-47a4-a901-1e16ff686ce9@linaro.org>
Date: Fri, 9 May 2025 09:57:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [RFC v1 6/7] configs: odorid-c4: Enable Oboard HUB driver
To: Anand Moon <linux.amoon@gmail.com>, Tom Rini <trini@konsulko.com>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Marek Vasut <marex@denx.de>, Patrice Chotard <patrice.chotard@foss.st.com>,
 Michal Simek <michal.simek@amd.com>, open list <u-boot@lists.denx.de>,
 "open list:P200" <u-boot-amlogic@groups.io>
Cc: Wayne Schroeder <raz@chewies.net>
References: <20250509070258.5077-1-linux.amoon@gmail.com>
 <20250509070258.5077-7-linux.amoon@gmail.com>
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
In-Reply-To: <20250509070258.5077-7-linux.amoon@gmail.com>
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
> Enable the onboard USB HUB driver to power the
> Via labs VL817 USB 3.1 hub on the Odroid C4.
> 
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
>   configs/odroid-c4_defconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/configs/odroid-c4_defconfig b/configs/odroid-c4_defconfig
> index cc3d7fc7484..3c5e53828a1 100644
> --- a/configs/odroid-c4_defconfig
> +++ b/configs/odroid-c4_defconfig
> @@ -64,6 +64,7 @@ CONFIG_USB_DWC3=y
>   # CONFIG_USB_DWC3_GADGET is not set
>   CONFIG_USB_DWC3_MESON_G12A=y
>   CONFIG_USB_KEYBOARD=y
> +CONFIG_USB_ONBOARD_HUB=y
>   CONFIG_USB_GADGET=y
>   CONFIG_USB_GADGET_VENDOR_NUM=0x1b8e
>   CONFIG_USB_GADGET_PRODUCT_NUM=0xfada

Same as patch 2, with that fixed:
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
