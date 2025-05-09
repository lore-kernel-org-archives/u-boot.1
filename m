Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43F0DC3ABC3
	for <u-boot@archiver.kernel.org>; Fri,  9 May 2025 07:58:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D292682905;
	Fri,  9 May 2025 09:58:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="w8TKurb/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E8FF806D8; Fri,  9 May 2025 09:58:31 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ABEC48295C
 for <u-boot@lists.denx.de>; Fri,  9 May 2025 09:58:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3a0b9303998so863866f8f.0
 for <u-boot@lists.denx.de>; Fri, 09 May 2025 00:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746777509; x=1747382309; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=YkiRHoKDT6dfwcEIriCYxav2MxpbA3FzZHfgt19y4No=;
 b=w8TKurb/jIgsRHLHzP1pz5TzWezQdu8nmmB1TBz5nbA4orGphVH0Ob0ZtA6jytNrY2
 ZjUDnYGP/ABzaXJokW1xD3ITswxZKC3QQHcFOhd20D/t71D72wQOhOqACpeNqIn+syd8
 lqPJjd9VDd5sbETRMv2W6kpOD71emtIQabT+v0gPv2d7LK8hJ+tEL+FggUPd6cgWSX2B
 iN1XreSKf2ghK4VANX5UB0lMgGx2TIUAOjTK0SaZ0I3dPlfBcyozPzmTDZn8zbxtOt6g
 ynm4UcD98PD4Ri3ybAhhY/G2OJJy/4ejBbZQ+iBnGy8eefHhnleZbLkVZBM73SKwVLOp
 GB3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746777509; x=1747382309;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=YkiRHoKDT6dfwcEIriCYxav2MxpbA3FzZHfgt19y4No=;
 b=n1x3dS01La92+JqdZ4APfzxxEVdm2fZVLCcwUT4RjT23/9ftOjfe/17Rwd42cgQUuJ
 FWmb2ZPvhDNLnFM0GNio2ketHE6NI8dcdyMnlRip79ykbkldW6zVOZU4PPtim1xWeobl
 ZN1OQFQcA4AerBAaV1gc9DwTQpIKtF2Gl3gxMhCaLjYtKKCx1TCd4+6z3wV9iN99yZtC
 FMc4zNsPwp9x4qK0+ovIpYrzOswbwLaMYISc4gP+plPz0lkO3NWd7yp71UPcQOr3WSHK
 pBWkVo8tzsCpAyzfxqx4LmbaiN+VoJHp3CkiWGN3240Ev0mNlqyKp7A4zd/10dMIqc+Y
 x7Mg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVez9ZF9C4xcGOvaiw8taxyqL4trINHhmXzsOyCAwaxiUi4m+ef7kdquUmKeziDqSKkNBYrZ10=@lists.denx.de
X-Gm-Message-State: AOJu0YxJGiQTJ2sMh4KR55T+uee0ZjtQQPRxWnGrUc9CgU00ObRkxXa7
 7Hur1EsE1wcZzMgcGQ1zgrAw/dHLIalaAHnV6ddc/JAnr1hGiv7fscalyqR5jPIyZZ5OGD0a4Hi
 X
X-Gm-Gg: ASbGncvgHvhu1ghMopTrb2UdGVguEH3pcQ5bE5KcwpfjsGD6YVO8PjusmGYvRsCBUK8
 z8HlRXW+wM65RzGNT6mF+aQzQYicJK+JHZ0qahPwMVSIu38elQi8cU+xe4JuXQC9MYuRooGDes1
 XUZly94v+BdgdR7eaLh+EhJM6VpiJrkfypGkIIble03k8M6UFpI7bPRL25XnPP5dXlcryjt1GUV
 KFcP+AQfF1KBQeH8Bxq9W5IYnhGs9J8cEoBNpSpinwEIrRUpNNJBuMtGgz4/T4MAAaAtbS9Oia5
 lG97r/yH7WYjKEYFDR1QtoTTMyfbZi50ym1e22JtGsufLJL9zlDKC2cAzQHIkUG9/JUUr9FOI+0
 U2JGlYVRJD2Rxdps=
X-Google-Smtp-Source: AGHT+IEuJmBM+CdYS5KBJ4IWwiMue73kIeV+s4wAv1ePa9EslYF2wv4iYUn+0nm2jS48gWRHZkAIvw==
X-Received: by 2002:a05:6000:1a8c:b0:3a1:f538:d9d5 with SMTP id
 ffacd0b85a97d-3a1f538da17mr2859321f8f.28.1746777509187; 
 Fri, 09 May 2025 00:58:29 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:22d7:71a:9f62:f7e2?
 ([2a01:e0a:3d9:2080:22d7:71a:9f62:f7e2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f58f28f7sm2408158f8f.41.2025.05.09.00.58.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 May 2025 00:58:28 -0700 (PDT)
Message-ID: <e152f223-6002-41a0-ba64-960fc4d3d9f7@linaro.org>
Date: Fri, 9 May 2025 09:58:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [RFC v1 3/7] usb: onboard-hub: Add support for Genesys GL853G
To: Anand Moon <linux.amoon@gmail.com>, Tom Rini <trini@konsulko.com>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Marek Vasut <marex@denx.de>, Michal Simek <michal.simek@amd.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 open list <u-boot@lists.denx.de>, "open list:P200" <u-boot-amlogic@groups.io>
Cc: Wayne Schroeder <raz@chewies.net>
References: <20250509070258.5077-1-linux.amoon@gmail.com>
 <20250509070258.5077-4-linux.amoon@gmail.com>
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
In-Reply-To: <20250509070258.5077-4-linux.amoon@gmail.com>
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
> Enable support for the Genesys GL853G USB2.0 and USB3.1 Hub on
> the Odroid N2 and N2-plus. The GL853G driver activates the hub
> reset signal, which toggles the GPIO.
> 
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
> => dm tree
> 
>   simple_bus   11  [ + ]   dwc3-meson-g12a       |   `-- usb@ffe09000
>   usb_gadget    0  [   ]   dwc2-udc-otg          |       |-- usb@ff400000
>   usb           0  [ + ]   xhci-dwc3             |       `-- usb@ff500000
>   usb_hub       0  [ + ]   usb_hub               |           `-- usb_hub
>   usb_hub       1  [ + ]   usb_hub               |               |-- usb_hub
>   usb_mass_s    0  [ + ]   usb_mass_storage      |               |   `-- usb_mass_storage
>   blk           2  [ + ]   usb_storage_blk       |               |       |-- usb_mass_storage.lun0
>   partition     0  [ + ]   blk_partition         |               |       |   `-- usb_mass_storage.lun0:1
>   bootdev       3  [   ]   usb_bootdev           |               |       `-- usb_mass_storage.lun0.bootdev
>   usb_hub       2  [ + ]   usb_hub               |               `-- usb_hub
>   clk           2  [ + ]   fixed_clock           |-- xtal-clk
> ---
>   common/usb_onboard_hub.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
> index 39bbc1aefa2..3914e2f773d 100644
> --- a/common/usb_onboard_hub.c
> +++ b/common/usb_onboard_hub.c
> @@ -231,6 +231,10 @@ static const struct onboard_hub_data genesys_gl852g_data = {
>   	.reset_us = 50,
>   };
>   
> +static const struct onboard_hub_data genesys_gl853g_data = {
> +	.reset_us = 50,
> +};
> +
>   static const struct udevice_id usb_onboard_hub_ids[] = {
>   	/* Use generic usbVID,PID dt-bindings (usb-device.yaml) */
>   	{	.compatible = "usb424,2514",	/* USB2514B USB 2.0 */
> @@ -244,6 +248,9 @@ static const struct udevice_id usb_onboard_hub_ids[] = {
>   	}, {
>   		.compatible = "usb5e3,610",     /* GL852G USB 2.0 */
>   		.data = (ulong)&genesys_gl852g_data,
> +	}, {
> +		.compatible = "usb5e3,620",     /* GL852G USB 3.1 */
> +		.data = (ulong)&genesys_gl853g_data,
>   	}
>   };
>   

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
