Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E388FC83F2C
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 14:26:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D33488C4C;
	Thu, 29 Aug 2024 16:26:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Xemy3qBa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 97ABE88C4F; Thu, 29 Aug 2024 16:26:05 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F9F788B88
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 16:26:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-42bb7298bdeso7635375e9.1
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 07:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724941563; x=1725546363; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=A+tpbeNIS358qVbp1PqxnxCo/pHSNlsuyMT/GqdhQpw=;
 b=Xemy3qBaWSENszX1ehkE5bZvLkS/qqgRSazW39w9lN5MWpifIkoLcq0dv532RbMMUW
 2GuMSegiUQSmPdQAWBrl0fZvgCKduO8an4Q1pjJnaWjnYJwHtS+uvdW+fGOur9MCmZn3
 uzRSqBgAkrWTKVFlYYGPBBQEpmsVlk4YubFFddTmY3lMfF8T4JvOU9ZavOIVCxNqwbt+
 kSg6h0mJPNM+o/4+QEG+ZJxKhr+GBtGQcxzHsRAwMjrgBzDrGL3IMFEbZDstctJLaYFK
 6ojDUU/YyjCRODFywyAtMqyD0ysyvJ+0AvJruoKmJ9empx7HulswRL1yQATA8D2JVpHv
 EbPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724941563; x=1725546363;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=A+tpbeNIS358qVbp1PqxnxCo/pHSNlsuyMT/GqdhQpw=;
 b=tBXctXeI76nLuMyH/DWWpmG/depid2iUmyKN4uBDE8zL+0kYmheC/unOoLBOLEp0bj
 SHCvSSlOe0cU3jnLoQiUOK6Sp1ectCSuWDSX0rhYJh1+LNklvyvDBRfmwHPyadNfnVvt
 y+22r29TKWqrIEMoQzz6iMVirofITLl6AtxwnLZ0co5YYGizXdQxblZ/APH8nR5OKnvC
 OkLbQTinETzjwI0qTZ3MgA2InbsntQmdi0hOU3N9oGPGseBqFp8wt3A6ohqgbC8/VIzL
 CXEfpiU3IIPdPaOTAh89YH6mg5NHkRqS7dxyTWvPsvjMxEcWM9Jzehd2v1t/sDWgJvXu
 5XZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZzaQ1JdvOXnnlIOEbblVtBJSMQHgsBycJA9/SywTBzp2ILSSBhPnGumnuUnWk4ASMY8s3hC8=@lists.denx.de
X-Gm-Message-State: AOJu0YyUdpI+LtF4O6btTWIN2emf+qgPF9O233Sl9MiXPFvjmsM78SRi
 CPmxKx+i6y6PocmskX9u1LYOQpKO1TdsZ8YAjnNgiLcHw+YCL+50RNgf1LvDqFBf+KM4fWoo/Nl
 c
X-Google-Smtp-Source: AGHT+IFbzMj/6yuyUnGvnet037ptALCZXtUY3uzwdc9k/ww6RGPkIV2upurKOF7VKT5McyLvJZgTlQ==
X-Received: by 2002:a5d:640d:0:b0:371:7c68:7cd7 with SMTP id
 ffacd0b85a97d-3749b584304mr2489203f8f.56.1724941562552; 
 Thu, 29 Aug 2024 07:26:02 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:12f5:c9c:a0e1:6915?
 ([2a01:e0a:982:cbb0:12f5:c9c:a0e1:6915])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42ba63965dbsm53712405e9.6.2024.08.29.07.26.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Aug 2024 07:26:02 -0700 (PDT)
Message-ID: <1637be2a-2fa8-4686-8868-077ed430ae8a@linaro.org>
Date: Thu, 29 Aug 2024 16:26:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH v5 17/20] test: Try to shut down the lab console gracefully
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>
References: <20240828220846.1205813-1-sjg@chromium.org>
 <20240828220846.1205813-18-sjg@chromium.org>
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
In-Reply-To: <20240828220846.1205813-18-sjg@chromium.org>
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

On 29/08/2024 00:08, Simon Glass wrote:
> Send the Labgrid quit characters to ask it to exit gracefully. This
> typically allows it to power off the board being used.

Sending those characters every time could collide with other CI systems,
I don't think it's a good idea.

> 
> If that doesn't work, try the less graceful approach.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
> (no changes since v1)
> 
>   test/py/u_boot_spawn.py | 17 +++++++++++++++--
>   1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/test/py/u_boot_spawn.py b/test/py/u_boot_spawn.py
> index c0ff0813554..ec1fa465047 100644
> --- a/test/py/u_boot_spawn.py
> +++ b/test/py/u_boot_spawn.py
> @@ -16,6 +16,9 @@ import termios
>   import time
>   import traceback
>   
> +# Character to send (twice) to exit the terminal
> +EXIT_CHAR = 0x1d    # FS (Ctrl + ])
> +
>   class Timeout(Exception):
>       """An exception sub-class that indicates that a timeout occurred."""
>   
> @@ -304,15 +307,25 @@ class Spawn:
>               None.
>   
>           Returns:
> -            Nothing.
> +            str: Type of closure completed
>           """
> +        self.send(chr(EXIT_CHAR) * 2)
>   
> +        # Wait about 10 seconds for Labgrid to close and power off the board
> +        for _ in range(100):
> +            if not self.isalive():
> +                return 'normal'
> +            time.sleep(0.1)
> +
> +        # That didn't work, so try closing the PTY
>           os.close(self.fd)
>           for _ in range(100):
>               if not self.isalive():
> -                break
> +                return 'break'
>               time.sleep(0.1)
>   
> +        return 'timeout'
> +
>       def get_expect_output(self):
>           """Return the output read by expect()
>   

