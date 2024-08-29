Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF59EC83F2C
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 14:22:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7195C88C17;
	Thu, 29 Aug 2024 16:22:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jZ6shkHO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0414688C40; Thu, 29 Aug 2024 16:22:52 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E5A488B88
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 16:22:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-37196681d3bso455562f8f.3
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 07:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724941369; x=1725546169; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=zB6f8368YsesH1OuP0NKiKNGKFYUgCW/dZ+5mkg3mrA=;
 b=jZ6shkHOsHojhwL9eAKUR0i34UkRgIz0YMT5udLYWb/KX3hG3raDBolFRiBoGXYAO6
 0H84W1EnvxpdIvWCIOTvOOH03uo1PakPaonbUygO24pch6SmJtNcenG5XY3So5XUMeER
 nAch/tV5McnuzALbxgUksUFf5oCuXs3XkB6950ZNh+reP0/Vk3HCDRo3Y6LdKh5DikCS
 wxvrQ9Z7iF5YyD5ZvBwhFkFYYxF1U06jj0nHsuw7eLTtaPFi8NFw560Nddzyp4jSdPqt
 Ewcdxco6XFRqYiC3OjF0LsQfRpz84bKR0y9/E2hDBuTlI/B4N9dpwxGO9FzRei7UGytP
 Vgdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724941369; x=1725546169;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=zB6f8368YsesH1OuP0NKiKNGKFYUgCW/dZ+5mkg3mrA=;
 b=brpLhIm1uEIjoR87QhJtUj56/PKzvyIN8vbo+f5JmzSRweBO68NvmGXreSndDsbGew
 jXSsRVlrpCp3xUqsXYNT+I3DXzYLsJvUu4mWUs2ymdQtvCSNKl5IDdgfwPXysW8Yg8Tk
 tpgDpoYTIj35cA2fPjbi4JMnHIEUgc4r1ECsUsuKsxCYPjhugkla9zoboXAFOFFxdw8w
 x7gM9on8EasE/DQ/rljW/Hct/44ELLJaq9sIKufu7kWcYAg2CiaZXWX9BS+9hup4BowQ
 CdWHR9YH3jeruaA8tnNYcAPOEI+PVuUTxXNbet9vE6e/P4E+7YOvT3+c2LjNBmT2Np5L
 HDiw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWegD+JRa117TwOZTvEmPgrYnyJKfhmDYGiQcRVRrnRloDnUZLcLx1ICkqnZUutviXoB9SQ3eU=@lists.denx.de
X-Gm-Message-State: AOJu0Yx1hyJehCx/ItGMGxju0x5JEtnkj1sB0hlKMwN0almdIEym3gOr
 zjwO7kCYDoJkwqOhUrNYjjog5i16asbFSNYiK1LKuFIQ/ng52ZFGhnXrypDMO6j/KCn179gL6cO
 5
X-Google-Smtp-Source: AGHT+IE34q58xKS3IUJNvQE8Tj330FTk8F2+wK/RuSO9SGYwJCQiebXFzHIkCl757BD1F/MuEhWreg==
X-Received: by 2002:adf:efc9:0:b0:371:87d4:8f23 with SMTP id
 ffacd0b85a97d-3749b585a68mr2073052f8f.58.1724941369160; 
 Thu, 29 Aug 2024 07:22:49 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:12f5:c9c:a0e1:6915?
 ([2a01:e0a:982:cbb0:12f5:c9c:a0e1:6915])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bb6e274c1sm18987835e9.36.2024.08.29.07.22.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Aug 2024 07:22:48 -0700 (PDT)
Message-ID: <b2a176a0-f3fc-440c-ba59-8bb97fb858dd@linaro.org>
Date: Thu, 29 Aug 2024 16:22:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH v5 03/20] test: Pass stderr to stdout
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>
References: <20240828220846.1205813-1-sjg@chromium.org>
 <20240828220846.1205813-4-sjg@chromium.org>
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
In-Reply-To: <20240828220846.1205813-4-sjg@chromium.org>
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
> Some tests may output things to stderr. Ensure that this output is not
> dropped, by redirecting it to stdout

Can't you make sure to output all labgrid output to stdout in the hook script instead ?

> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
> (no changes since v1)
> 
>   test/py/u_boot_spawn.py | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/test/py/u_boot_spawn.py b/test/py/u_boot_spawn.py
> index 97e95e07c80..81a09a9d639 100644
> --- a/test/py/u_boot_spawn.py
> +++ b/test/py/u_boot_spawn.py
> @@ -10,6 +10,7 @@ import re
>   import pty
>   import signal
>   import select
> +import sys
>   import time
>   import traceback
>   
> @@ -59,6 +60,7 @@ class Spawn:
>                   signal.signal(signal.SIGHUP, signal.SIG_DFL)
>                   if cwd:
>                       os.chdir(cwd)
> +                sys.stderr = sys.stdout
>                   os.execvp(args[0], args)
>               except:
>                   print('CHILD EXECEPTION:')

