Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB5A2C2BA18
	for <u-boot@archiver.kernel.org>; Thu, 20 Jun 2024 07:39:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC46E87C7E;
	Thu, 20 Jun 2024 09:39:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="GZrERtTV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0EA8388521; Thu, 20 Jun 2024 09:39:53 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1ADA987C7E
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 09:39:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a6f09b457fdso49883466b.2
 for <u-boot@lists.denx.de>; Thu, 20 Jun 2024 00:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718869190; x=1719473990; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=M6EU4d8LrV/Ueke3iuRp4pl3Ga+6FOrMKGxXcnG9ruk=;
 b=GZrERtTVv+DvLe6Zg7tpjTHfmzOcGmaLygNs/ZeV39+2O2dGekZ4K3xh+vR6OL/lxq
 YlZAcgs884iRiI3RVVg9+iJkoYIjXu9uaRWk0HqsLc4LzIV8pt90+myrQartVf8a68lh
 cBRZQSWBFVOnWAWa8jfo/6Q5TY6I3GORTySwjOT+b5zAa9XmtUst5Mm9zqhIZ0E8VwIz
 97jExk3fza7uTWOv7e79cG0D5XW6Y6j7u0lHdlBcStyL0SXFH+0L3XWxwF9IsGnTiw1b
 Tth+90NvwwysGL3h7HCC3hgaC9EMho4TB4fnwaNf2BAowu6KBa1cb/Y37AuHK+8fcMCk
 jB+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718869190; x=1719473990;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=M6EU4d8LrV/Ueke3iuRp4pl3Ga+6FOrMKGxXcnG9ruk=;
 b=KG4PXj8iKG4C21eWP9HvgjYhF5fGjMTft2GO+CRFxV36JM1RMzaIl1a7Kb+VMZMgtn
 FkfcJjC/SePPMFVGOz5UW8XwQWo3xjccyXcVog7aX3pAqgWzZ8qn7qXFwXqWOtfIbq4d
 ProSuB3AaFg6lpkCNEmwKioTrBzhrROvsku9XIgeP7MPiy4zyL0JigY3NBsh2qtIUftH
 6mm+0wlth81sj8AaI1cviRFv7xb3tvCDk0isg7OHtj9S4xqgHAwqzuTE4Pwuw5zA3OwQ
 JwpqLPFyRfSPWjTSXz73QPVsImxWAMYOdb5dN4zhj0DeQvbyXwod1S0n92t7GLz0dLTg
 CYXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVwyQX8Q5lfeNHDKQtAoTtMlXNSbxziTIGlseT6Fi30mNbbDOkrjLf417RpTSkBGClINxlgvVHaDUJ0jzlaTuEj1x85g==
X-Gm-Message-State: AOJu0Yw+FxJqk3fKBnSmN8FLHeolQ6N0Tx1yoxD1uGr7QHy85bixRBCU
 Wdj0VZ7eU35s8WKFeiX8BjAfA73iB3ObPTHz3yD+ljuI711aPfZ1nSw74Uw0EWo=
X-Google-Smtp-Source: AGHT+IHVIfG9uxE9peIApdgp8lAzabbTupri8C9xaJNkvUnb5Xxk/2En1LFiSwPAtMvYajH1HaCOiA==
X-Received: by 2002:a17:907:c31c:b0:a6f:1378:1329 with SMTP id
 a640c23a62f3a-a6fab607142mr368624566b.4.1718869190507; 
 Thu, 20 Jun 2024 00:39:50 -0700 (PDT)
Received: from [192.168.7.32] (679773502.box.freepro.com. [212.114.21.58])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6fc3f3efb3sm25753266b.15.2024.06.20.00.39.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Jun 2024 00:39:50 -0700 (PDT)
Message-ID: <d8e7d2cb-b402-43fa-8c3e-eaebfaf5b0fc@linaro.org>
Date: Thu, 20 Jun 2024 09:39:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 3/5] phy: meson-gxl-usb2: remove
 phy_meson_gxl_usb2_set_mode
To: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>
Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 u-boot-amlogic@groups.io, u-boot@lists.denx.de
References: <20240618-u-boot-usb-gxl-phy-set-mode-v1-0-6b41efa46e35@linaro.org>
 <20240618-u-boot-usb-gxl-phy-set-mode-v1-3-6b41efa46e35@linaro.org>
 <54c7dcab-8925-4b20-b455-413a9bee8fda@denx.de>
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
In-Reply-To: <54c7dcab-8925-4b20-b455-413a9bee8fda@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Reply-To: neil.armstrong@linaro.org
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 18/06/2024 16:56, Marek Vasut wrote:
> On 6/18/24 9:55 AM, Neil Armstrong wrote:
> 
> [...]
> 
>> @@ -205,7 +188,7 @@ static int phy_meson_gxl_usb2_power_off(struct phy *phy)
>>   struct phy_ops meson_gxl_usb2_phy_ops = {
>>       .power_on = phy_meson_gxl_usb2_power_on,
>>       .power_off = phy_meson_gxl_usb2_power_off,
>> -    .set_mode = _phy_meson_gxl_usb2_set_mode,
>> +    .set_mode = phy_meson_gxl_usb2_set_mode,
> 
> Oh, I see you did rename it here, so please ignore my comment on 1/5 . Maybe just mention in the 1/5 commit message that the rename is happening in follow up patch , if you are doing V2 at all .

Sure, let me update the commit message,

Thanks,
Neil


