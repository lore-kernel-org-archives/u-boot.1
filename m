Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E85D6C3ABC3
	for <u-boot@archiver.kernel.org>; Fri,  9 May 2025 07:58:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 816358212F;
	Fri,  9 May 2025 09:58:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xvYPvyL7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC270822D7; Fri,  9 May 2025 09:58:22 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EAA8C806D8
 for <u-boot@lists.denx.de>; Fri,  9 May 2025 09:58:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43cfe63c592so17703345e9.2
 for <u-boot@lists.denx.de>; Fri, 09 May 2025 00:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746777500; x=1747382300; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=sLe/IZ4rXnBdZgnZ4/eWyXuOlnh9tUiYke1zR9KxH1c=;
 b=xvYPvyL7Jiz6lmQeobZgxHEk//2GBjgmhz4FmEwK1ECi/dlDBV9JuD5rCEQBBKl0Rn
 xWLRJDijhwTwMLTVpZrDwxs2Ik4P/7MPGlCsSHAT6Pg6tKP8qrVeoE1YAQmRAOwIuLRO
 WrxLiuoPBJLQCpYNb5j8w36Sq+HXg6bx1Xl//TSRo0O37od8skgFDl3Hh+ufz+bcOLbI
 4vCiBPfmKVjc+3n/KjHnjkmlDn066lbKGDTUa0ggwTU+kWJzJqbT3r7JOpWD/4hH9KFE
 iVDKapjudx3bdiSYRRrDX7sYDwC5rgLGRTIASjZ2ErY5Y/YKjjuoHWIw/rXo7x7rA/jg
 5/Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746777500; x=1747382300;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=sLe/IZ4rXnBdZgnZ4/eWyXuOlnh9tUiYke1zR9KxH1c=;
 b=Y2bB5U3L1r1Ge0dp+WXhIx84dD4Q0AxNErqndRJCGXVxKS6DDnmvboYJiFjBu8ocw7
 7odnMlDNyijMSqh8DuuEBaUf8Ea8nTkft5k8d3w9Kqvc48sAiybS0F8YRfVDOBf3AFBw
 jF/BPxeIrB+t7JJoPjs+HiogFbYhOR7N9Bi+XmlTZGUk/Ti35TX6K/emxaxNzloKFZ5N
 I4fqa+AMgTqexbN9Es8PdmGrH9nxyXRzLoYWy4UJL/CKy5YQoWJ6q7bxWA7shBDmmV+x
 XWlGp+VPv6hsvmdJMrr4ZwUMh9W5TxKXIRdD94o3ptcbihtY0eh0kJ+ShwlNNwitU1oz
 anqA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHgO/FBhDV8LdbgRETImQf8oWi+NZxeTqlAltD7pQzKCU+WbBpHSRiXTjZT+0oAFOyS943GR0=@lists.denx.de
X-Gm-Message-State: AOJu0Yzf6IjHBuMw123nAHAMzYAOU1ovu18rDNhBq8MBdS7pNVR9BlDG
 DKjurkmxfrXXQ6bXjC8rFDdXJ9NVzEj9DtKX+UQXai7u+iO09Br86rnYPZ090zo=
X-Gm-Gg: ASbGncvknLutneJrjEUDSN7cYubtDVmLTwcNzLYl+aXz7TkenQCDmR4Lu0Sjd3fqqIC
 k9VQ1H0ipj9zuko+D2YHVCTwtoSaePuhMV1cbKfdwBF60lq/n5t5NwgV2WjJFlXMquTJXaSAF04
 V5kc0f7czJmFPisYUIYufpy84VbJG3FaARUSyNZWReQS176KAi4xxpnf4arixJQBjlb9wWvmc5+
 Y2u5c/yPzh3VDeWTz6/uqr5oLHO0ciE0RaoLLFwvU2vwXlMHezxVjeFeXow3WDvACLfFHp4Xc79
 OY1g1Wl0G55VnAWbTfx94/XgN3xmZwAC7l/GRskm7ij7z3EzpxqMXzpQ+55nYqDI63h3TqNqOTz
 gsSjjgqK27nMwmO7kziQABkttwQ==
X-Google-Smtp-Source: AGHT+IGurNYMve6HR6jhsSK8a2GA1GX0uhAtMDYOzVLPjYGeG5eoYCcQ6PxJYZKonFoVPI9c/Z0X0A==
X-Received: by 2002:a05:600c:4e8f:b0:43c:ef55:f1e8 with SMTP id
 5b1f17b1804b1-442d6d44d0fmr19199525e9.13.1746777500386; 
 Fri, 09 May 2025 00:58:20 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:22d7:71a:9f62:f7e2?
 ([2a01:e0a:3d9:2080:22d7:71a:9f62:f7e2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442d6bf96bfsm20245885e9.6.2025.05.09.00.58.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 May 2025 00:58:20 -0700 (PDT)
Message-ID: <a51537fe-0960-40da-a039-e112a7d8413d@linaro.org>
Date: Fri, 9 May 2025 09:58:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [RFC v1 5/7] usb: onboard-hub: Add support for VL817 USB hub
To: Anand Moon <linux.amoon@gmail.com>, Tom Rini <trini@konsulko.com>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Marek Vasut <marex@denx.de>, Michal Simek <michal.simek@amd.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 open list <u-boot@lists.denx.de>, "open list:P200" <u-boot-amlogic@groups.io>
Cc: Wayne Schroeder <raz@chewies.net>
References: <20250509070258.5077-1-linux.amoon@gmail.com>
 <20250509070258.5077-6-linux.amoon@gmail.com>
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
In-Reply-To: <20250509070258.5077-6-linux.amoon@gmail.com>
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
> Enable support for the Via labs VL817 USB2.0 and USB3.1 Hub
> on the Odroid C4. The Via labs VL817 USB driver activates the
> hub reset signal, which toggles the GPIO.
> 
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
> => dm tree
>   simple_bus   11  [ + ]   dwc3-meson-g12a       |   `-- usb@ffe09000
>   usb_gadget    0  [   ]   dwc2-udc-otg          |       |-- usb@ff400000
>   usb           0  [ + ]   xhci-dwc3             |       `-- usb@ff500000
>   usb_hub       0  [ + ]   usb_hub               |           `-- usb_hub
>   usb_hub       1  [ + ]   usb_hub               |               |-- usb_hub
>   usb_mass_s    0  [ + ]   usb_mass_storage      |               |   `-- usb_mass_storage
>   blk           2  [ + ]   usb_storage_blk       |               |       |-- usb_mass_storage.lun0
>   partition     0  [ + ]   blk_partition         |               |       |   |-- usb_mass_storage.lun0:1
>   partition     1  [ + ]   blk_partition         |               |       |   |-- usb_mass_storage.lun0:2
>   partition     2  [ + ]   blk_partition         |               |       |   |-- usb_mass_storage.lun0:3
>   partition     3  [ + ]   blk_partition         |               |       |   `-- usb_mass_storage.lun0:4
>   bootdev       3  [   ]   usb_bootdev           |               |       `-- usb_mass_storage.lun0.bootdev
>   usb_hub       2  [ + ]   usb_hub               |               `-- usb_hub
> ---
>   common/usb_onboard_hub.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
> index 3914e2f773d..1242513c631 100644
> --- a/common/usb_onboard_hub.c
> +++ b/common/usb_onboard_hub.c
> @@ -235,6 +235,10 @@ static const struct onboard_hub_data genesys_gl853g_data = {
>   	.reset_us = 50,
>   };
>   
> +static const struct onboard_hub_data vialab_vl817_data = {
> +	.reset_us = 10,
> +};
> +
>   static const struct udevice_id usb_onboard_hub_ids[] = {
>   	/* Use generic usbVID,PID dt-bindings (usb-device.yaml) */
>   	{	.compatible = "usb424,2514",	/* USB2514B USB 2.0 */
> @@ -251,6 +255,12 @@ static const struct udevice_id usb_onboard_hub_ids[] = {
>   	}, {
>   		.compatible = "usb5e3,620",     /* GL852G USB 3.1 */
>   		.data = (ulong)&genesys_gl853g_data,
> +	}, {
> +		.compatible = "usb2109,817",	/* Via labs VL817 2.0 */
> +		.data = (ulong)&vialab_vl817_data,
> +	}, {
> +		.compatible = "usb2109,2817",	/* Via labs VL817 3.1 */
> +		.data = (ulong)&vialab_vl817_data,
>   	}
>   };
>   

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
