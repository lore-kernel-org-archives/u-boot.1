Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5B8ACDB483
	for <u-boot@archiver.kernel.org>; Wed, 18 Oct 2023 07:43:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A070480F06;
	Wed, 18 Oct 2023 09:43:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XVBumOhU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 614A980F06; Wed, 18 Oct 2023 09:43:34 +0200 (CEST)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3B285805F5
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 09:43:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-323ef9a8b59so5999500f8f.3
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 00:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697615011; x=1698219811; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=i0vCf29nLDwhqFZbNKESsa8maKdStWsuI7dK+fyv8HM=;
 b=XVBumOhUnCkXsAqtM4IeMRAAFVW1Wp190L8UzDUo8dItWj6AtnxbC3HlgcilXkeJBN
 1Gmmt4fasffILCjJidEb7+5HKNYRG5XlM6YwU8U6UdXJbYtzj+mUjw/crz+58QvsSInn
 iN5kC6y82vzVxLo0NbnG8tkasV9T6dwrkCknm7HY07T4GSpxum51Vy9Eem/zJ+K6T/D9
 izvigzT5Y5nuNuWKDVKY3GhODJSqV5Hw2CWm1UE4eeAwSRyUhOFvZ/B/oCrWAvVYPj81
 j+X6AFSnnlaTUe7n0tr3Kg3wThAOISo1BSeK+z8Zj4bvap3VYff91pBzm4VRWsk/T5YY
 OL/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697615011; x=1698219811;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=i0vCf29nLDwhqFZbNKESsa8maKdStWsuI7dK+fyv8HM=;
 b=WtiV+swClNQYtieeiWjzyLyoG+t3RRXDl0Olo7mw25fuAjY6z3cvChHAHoTOeth1sM
 omrYB/fw0k5mPPzaPCcKgcSFJsxjik3eM2ML3muH6JcMlFYjIhVJSSbL4+GrEBNVU0ym
 VrkwDjgffhd23plSpOiItf+vFxzq7ORsukU3xDXl3S89hjVRxRRRV+F0QBOjQy9/8r+L
 HN1TG+UDIY8GZWIkv02WMssC9Cl9L9UZpxSkC4+PTLR/SF1XUZw740/BeUOSiTL7QDP5
 mvXrkw29K4JzfUUc4lDwuLxGUG7apRF+aPCyojM4GcKi3apZ5NhNQB1nctwyXtzbCN8D
 fY1g==
X-Gm-Message-State: AOJu0YzWS3ymcNLY2TQzDD01KV6R9GrNWIefzkqw1/ONXXAofYAyvAZp
 1x/r99aB5cDFaKuy6+6ASNHq1g==
X-Google-Smtp-Source: AGHT+IGUGZp1xd2h62gSe7PHhS+N9Sy5XgZABjdi0pGyFp31gW/ywAhxeyKHoHICJL0fbHnebjtQXQ==
X-Received: by 2002:adf:e691:0:b0:31a:d9bc:47a2 with SMTP id
 r17-20020adfe691000000b0031ad9bc47a2mr3825023wrm.53.1697615011648; 
 Wed, 18 Oct 2023 00:43:31 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:5d8f:701:423:3d05?
 ([2a01:e0a:982:cbb0:5d8f:701:423:3d05])
 by smtp.gmail.com with ESMTPSA id
 f4-20020a056000128400b0031c5e9c2ed7sm1457010wrx.92.2023.10.18.00.43.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Oct 2023 00:43:31 -0700 (PDT)
Message-ID: <ca225ffe-c524-4312-8a65-30e0c36c4ae7@linaro.org>
Date: Wed, 18 Oct 2023 09:43:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v1 1/2] serial: amlogic: Add UART compatible for A1 board
Content-Language: en-US, fr
To: Igor Prusov <ivprusov@salutedevices.com>
Cc: prusovigor@gmail.com, kernel@sberdevices.ru, u-boot-amlogic@groups.io,
 u-boot@lists.denx.de
References: <20231017213211.121550-1-ivprusov@salutedevices.com>
 <20231017213211.121550-2-ivprusov@salutedevices.com>
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
Organization: Linaro Developer Services
In-Reply-To: <20231017213211.121550-2-ivprusov@salutedevices.com>
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
Reply-To: neil.armstrong@linaro.org
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 17/10/2023 23:32, Igor Prusov wrote:
> Add additional compatible to allow using serial driver with A1 board.
> After compatible change in DTS [1], serial_meson driver should still be
> able to work with console device.
> 
> [1] https://lore.kernel.org/all/20230705181833.16137-8-ddrokosov@sberdevices.ru/
> 
> Signed-off-by: Igor Prusov <ivprusov@salutedevices.com>
> ---
>   drivers/serial/serial_meson.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/serial/serial_meson.c b/drivers/serial/serial_meson.c
> index 934de2ab23..be5f380f85 100644
> --- a/drivers/serial/serial_meson.c
> +++ b/drivers/serial/serial_meson.c
> @@ -232,6 +232,7 @@ static const struct dm_serial_ops meson_serial_ops = {
>   static const struct udevice_id meson_serial_ids[] = {
>   	{ .compatible = "amlogic,meson-uart" },
>   	{ .compatible = "amlogic,meson-gx-uart" },
> +	{ .compatible = "amlogic,meson-a1-uart" },
>   	{ }
>   };
>   

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
