Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F625C531C7
	for <u-boot@archiver.kernel.org>; Thu, 23 Jul 2026 08:50:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 15DF860756;
	Thu, 23 Jul 2026 08:50:26 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cE5sRQ0ZIFzK; Thu, 23 Jul 2026 08:50:24 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 899C560681
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784796624;
	bh=gfUfemrd+EvZui1iXSivbf5sVFYYE2zOxYqNoHfSHVw=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=NVM440rbP3Z9bDyT3Vt9y09cLQvp7zF1x7rwxPSJV3UGHrerAqKAiv52hmkHVtkDd
	 XmUrSh7wY1dVs+9PPbWdpqIrwSUn8IN2ndb10qm+bkagvN7+aFrU/zMyJKwDDKJiQB
	 3tjyW/ZxS2A8jcb1HS7Hp0pwJCwqBfDmyv9LTHzZ/hyy//9ecS4zpbku6BRQDOI/bQ
	 LWSr9N7SPQGsfc/o+2tNkYZmNi9qQ/isUONSegFUlUiQVYc0alwvF8VJ3/kQx/87TU
	 /XUzG2RaR8keqd1td+EL1El6/E7jM0TcTelb22S3EqBZpwzmWVXViyS1P8NlOVxanq
	 d37pxF1q1YYLA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 899C560681;
	Thu, 23 Jul 2026 08:50:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 8EB6D39E
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 08:50:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8CBD840743
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 08:50:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1WIBIr2ilAYO for <u-boot@lists.u-boot-project.org>;
 Thu, 23 Jul 2026 08:50:22 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::42c; helo=mail-wr1-x42c.google.com;
 envelope-from=neil.armstrong@linaro.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 91E854056E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 91E854056E
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 91E854056E
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 08:50:21 +0000 (UTC)
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-47f904e80eeso297551f8f.1
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 01:50:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784796619; x=1785401419;
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=gfUfemrd+EvZui1iXSivbf5sVFYYE2zOxYqNoHfSHVw=;
 b=BBGpMwC4da614qGqVNXeH2dqR1GHFLLO+xhFPineIfndIPBzwYDSwIEJRHLzksWmqF
 gmBvG8PhAegKemY5GQamtCcwFrqKdNBChW1ysWpJGDcd0gUaytug2auDdmlvWG18mObB
 5MoWtiomjaHUUnvGJSpC3/0OE+llGXTDSD7mOzrXRRipIzGoBGu7/ZGNaUAirLTcQ4Vs
 wHbgfQquEtI5XIzy/V/oHex5udzx5NffnOkwl4maxdSWc8b6zLENsc95WsgH0NRgyPsF
 +XP+GZoc2yCmUY/RdRWinmaM+XxITLbgMOqphGCeXO+9DXihSkOW7VrVTyFTvUsyih7t
 dktw==
X-Forwarded-Encrypted: i=1;
 AHgh+RotJZB0ncLl8UU3gN6uIjgngBKtZvlqX4TBkT3WWOXaVuPIEe2wUg1GBr7BCBqpgPocza9PSOQ=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YypmARWxTqC1s6pcT9heytVuZFjRFUuYjj1mtGGDBjiqW6Zbsah
 XL/wTi2P7qxdeTldJmAz52N0oMk1TJPlW0bFoJ90+ta25PNug0lGC5VM6cr/kOs5nOw=
X-Gm-Gg: AR+sD113beMuTzd7OXPA3VITB7d5vG98kTYaBoVqLnLbKKPE70zWiWXg4Xooe6cCWuu
 1myrTqls6doIdszzRLUBuDcrCZBBzfxVWV1yMw9NRkwpRivm7qedaKEykJR1UC0zmxR71moaOoa
 gx2w29XJWQyRgvzRWhHebzWaVXdnJehwm7a1VyLy58UMPV3/LHoDqpha4TUzUt7ACpTqFCH5HZe
 5XbR5k3JByf44c6UKDpeK/KqLFToUrYrJAYiD02K/n/jxUnYhytkcjGX0U78Bp04suQY/0EI3i5
 4mPPKWqO8G/C2ijGk1e3HfKdjMBXiNvwW2Cnz0UhPIxV12j70wWqujGlPspKWo0Yejda6FZ0p6l
 CA0Wi4ltf1QQBu59hyeX/Shdbu90a4I8PiRy4xriLQdOCs0AGqg6Y04aVWj+KAMixsrwbiInO4y
 RP0Z6odADlXitKPRn3YEPN/4T5P4yeC70B9mmSMgjSMWpSY/ALJxaAmetdWg==
X-Received: by 2002:a5d:5d0e:0:b0:47f:86af:8fe7 with SMTP id
 ffacd0b85a97d-47f8d7220e6mr2692043f8f.22.1784796618938; 
 Thu, 23 Jul 2026 01:50:18 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:f234:5e35:82ba:6d6c?
 ([2a01:e0a:106d:1080:f234:5e35:82ba:6d6c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c67339sm14448542f8f.31.2026.07.23.01.50.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Jul 2026 01:50:18 -0700 (PDT)
Message-ID: <9db60818-e50b-49b8-b2b3-3cdb5aaa41a0@linaro.org>
Date: Thu, 23 Jul 2026 10:50:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH RFC v2 2/5] fastboot: use the common handler for USB reboot
To: Carlo Caione <ccaione@baylibre.com>, u-boot@lists.u-boot-project.org,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Tom Rini <trini@konsulko.com>, Quentin Schulz <quentin.schulz@cherry.de>,
 Sam Day <me@samcday.com>, Julien Masson <jmasson@baylibre.com>,
 Vitor Sato Eschholz <vsatoes@baylibre.com>,
 David Lechner <dlechner@baylibre.com>, Lukasz Majewski <lukma@denx.de>,
 Marek Vasut <marex@denx.de>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Alexey Charkov <alchark@gmail.com>,
 Adrian Freihofer <adrian.freihofer@siemens.com>,
 Francois Berder <fberder@outlook.fr>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>, Vincent Jardin <vjardin@free.fr>,
 Casey Connolly <casey.connolly@linaro.org>, Heiko Schocher <hs@nabladev.com>
References: <20260722-ccaione-upstream-spl-fastboot-v2-0-2ba3f71c42bc@baylibre.com>
 <20260722-ccaione-upstream-spl-fastboot-v2-2-2ba3f71c42bc@baylibre.com>
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
In-Reply-To: <20260722-ccaione-upstream-spl-fastboot-v2-2-2ba3f71c42bc@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784796619; x=1785401419;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:organization
 :autocrypt:content-language:references:cc:to:subject:reply-to:from
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gfUfemrd+EvZui1iXSivbf5sVFYYE2zOxYqNoHfSHVw=;
 b=CDT0xb6Xf9GXgBDngzkyJm4hQWfbUvR1fuYmzzOhWZGd99viW34ndQDCxCiRyETdqZ
 DbxlJzbW9tLTVrqFVU+ywKzcnVX/UHQNN4vWJHhDmkElYmKY6nLlPA1BgNJMSluwffQr
 YGIiISp+9KVF7zwHy+Gjv6NYwankhVTXvCHgAT8ZCH6OdlhwRhWusmFYQbMfusBQBj8t
 LzOnORsQt5Bz3gkxCoQquvSqJ6UWo8w5WAM6uKw0GEXxVAcqHSrVyEsIOzCj4Uz0C8iq
 Xjg8j43VDbNscGpPNtHHht7DjKb8AlxRRxP4ql2q2AXJ86Ur/2cf+x4cRvoDrO3Qky7O
 N0MQ==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linaro.org
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=CDT0xb6X
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 7/22/26 22:43, Carlo Caione wrote:
> USB fastboot resets the device directly from its request-completion
> callback, while the network transports route completed commands through
> fastboot_handle_boot(). Keeping reset policy in the transport makes it
> harder to support callers with a different reset interface.
> 
> Send the USB reboot completion through the common handler as
> well. U-Boot proper retains the same do_reset() behavior, while
> execution-phase-specific policy can be contained in the shared code.
> 
> Signed-off-by: Julien Masson <jmasson@baylibre.com>
> Signed-off-by: Vitor Sato Eschholz <vsatoes@baylibre.com>
> Signed-off-by: Carlo Caione <ccaione@baylibre.com>
> ---
>   drivers/usb/gadget/f_fastboot.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/gadget/f_fastboot.c b/drivers/usb/gadget/f_fastboot.c
> index 8df0e3f331d..471c0e87042 100644
> --- a/drivers/usb/gadget/f_fastboot.c
> +++ b/drivers/usb/gadget/f_fastboot.c
> @@ -422,7 +422,7 @@ static int fastboot_tx_write_str(const char *buffer)
>   static void compl_do_reset(struct usb_ep *ep, struct usb_request *req)
>   {
>   	g_dnl_unregister();
> -	do_reset(NULL, 0, 0, NULL);
> +	fastboot_handle_boot(FASTBOOT_COMMAND_REBOOT, true);
>   }
>   
>   static unsigned int rx_bytes_expected(struct usb_ep *ep)
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Thanks,
Neil
