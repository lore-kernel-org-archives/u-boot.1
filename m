Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BF70C83F2C
	for <u-boot@archiver.kernel.org>; Thu, 29 Aug 2024 14:19:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 707B488AD7;
	Thu, 29 Aug 2024 16:19:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="SN5xv3qi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8BF1988B23; Thu, 29 Aug 2024 16:19:23 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E00E888DD
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 16:19:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-429da8b5feaso8327675e9.2
 for <u-boot@lists.denx.de>; Thu, 29 Aug 2024 07:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724941161; x=1725545961; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=WDYZpA18SeFFlRYaobNMaRatjCqDhsHNvMCjWINJVrI=;
 b=SN5xv3qi9/bZc5qVhTOdHvOEsZIRxwhFeaTGoyt8lwVxDHqrgHAbqICxnF+HyrR6hR
 pZdEF1j8lC/PhauaxO3YV50Whvs5WK1j5+un45mGmSoMoYq48ijeUb+5DhmjtA+IqnoD
 wfXcLotSg6LdTOY6SZjJp///D69BKb2CTo1e/3fg+djaFLj4n6/yEW31CLXkAXn9x8w2
 vJKHjUp5kK3+JU2an1dbRrKx8KR/wOMhIUvhgbH3NVVQV4CY9tzhfHNUOSKwMexowHIy
 w/IzkzT3U3QSJZm416nJrh0bFUeEKpGOjRyVPRFW//6boFKCiVCmJCDlwAbJqmGN+Rce
 hbQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724941161; x=1725545961;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=WDYZpA18SeFFlRYaobNMaRatjCqDhsHNvMCjWINJVrI=;
 b=LumUXHXuWi6VMt0TWjouac4bO3VuYHYL/K2yyKqonA7DU9VwyCDFcRASrd6XXIjSAU
 luHdGNJHJ4rBzAA8qG0kMS/MpnA8aV1eqrdZTH1XYf5+b/qOGXVgGLni9Gre2CGrhCDs
 POqCDtzKTW7gbj4X2blsdVkoQUL5ncjZpZ7mumSfKCFjkYH/heIn2UP1poznBhePWs7V
 un3qy8544ThGhrBtYR0khW2fGS6WCguySkGXny7R5s73AOHPTlE5T8WYOQTMgsBJsOO1
 z468jPWctl9MFCo9I4ThBbZRvtaD/IjzMS3kfCFYDy0W2hb03XVp5TWIbjKx3Asyq1UY
 alSg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUu0TkR9Bm5/Fi9YcEg0RANUnSkBAcA2jcl3LBfktzcil70LqIrW7VrMBkSBmhXdLUquoTC06M=@lists.denx.de
X-Gm-Message-State: AOJu0YzqJ9ZqtGlCkcMOG9m4qCsapi0BBosznFv732i+ow0I/T33Gb4X
 gi1obSpG6o0mMA+wJx38hEU0fEZXL2wMiUJsdnpKwnxkypy8bhTi4VqBNrbTqus=
X-Google-Smtp-Source: AGHT+IFM/K5/R9pzaNV4L8uS4r5ExD1keveMnY0t7U2FwNbL2q6tFCmOo200sjbK2ja3VnIFpIKgzg==
X-Received: by 2002:a05:600c:4f07:b0:428:f0a:3f92 with SMTP id
 5b1f17b1804b1-42bb01c1d40mr32236395e9.21.1724941160218; 
 Thu, 29 Aug 2024 07:19:20 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:12f5:c9c:a0e1:6915?
 ([2a01:e0a:982:cbb0:12f5:c9c:a0e1:6915])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bb6df1066sm18839965e9.18.2024.08.29.07.19.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Aug 2024 07:19:19 -0700 (PDT)
Message-ID: <4ab84c7a-c129-41e9-aa1e-6e802fdd6f87@linaro.org>
Date: Thu, 29 Aug 2024 16:19:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH v5 08/20] test: Introduce the concept of a role
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>
References: <20240828220846.1205813-1-sjg@chromium.org>
 <20240828220846.1205813-9-sjg@chromium.org>
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
In-Reply-To: <20240828220846.1205813-9-sjg@chromium.org>
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

Hi,

On 29/08/2024 00:08, Simon Glass wrote:
> In Labgrid there is the concept of a 'role', which is similar to the
> U-Boot board ID in U-Boot's pytest subsystem.
> 
> The role indicates both the target and information about the U-Boot
> build to use. It can also provide any amount of other configuration.
> The information is obtained using the 'labgrid-client query' operation.
> 
> Make use of this in tests, so that only the role is required in gitlab
> and other situations. The board type and other things can be queried
> as needed.
> 
> Use a new 'u-boot-test-getrole' script to obtain the requested
> information.
> 
> With this it is possible to run lab tests in gitlab with just a single
> 'ROLE' variable for each board.

Can't this be in the hook script ? I mean allmost no CI system have a 1:1
usage of board_type & board_identity, but we use those fields and transform
them accordingly.

u-boot-test-getrole is labgrid only, all script receives board_type & board_identity,
so why add some labgrind specific python here ?

Neil

> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
> Changes in v5:
> - Add a few more comments
> - Comment out the debugging, which might be useful later
> 
>   test/py/conftest.py | 38 ++++++++++++++++++++++++++++++++++----
>   1 file changed, 34 insertions(+), 4 deletions(-)
> 
> diff --git a/test/py/conftest.py b/test/py/conftest.py
> index 6547c6922c6..03dfd8ab562 100644
> --- a/test/py/conftest.py
> +++ b/test/py/conftest.py
> @@ -23,6 +23,7 @@ from pathlib import Path
>   import pytest
>   import re
>   from _pytest.runner import runtestprotocol
> +import subprocess
>   import sys
>   
>   # Globals: The HTML log file, and the connection to the U-Boot console.
> @@ -79,6 +80,7 @@ def pytest_addoption(parser):
>       parser.addoption('--gdbserver', default=None,
>           help='Run sandbox under gdbserver. The argument is the channel '+
>           'over which gdbserver should communicate, e.g. localhost:1234')
> +    parser.addoption('--role', help='U-Boot board role (for Labgrid)')
>       parser.addoption('--no-prompt-wait', default=False, action='store_true',
>           help="Assume that U-Boot is ready and don't wait for a prompt")
>   
> @@ -130,12 +132,40 @@ def get_details(config):
>               str: Build directory
>               str: Source directory
>       """
> -    board_type = config.getoption('board_type')
> -    board_identity = config.getoption('board_identity')
> +    role = config.getoption('role')
> +
> +    # Get a few provided parameters
>       build_dir = config.getoption('build_dir')
> +    if role:
> +        # When using a role, build_dir and build_dir_extra are normally not set,
> +        # since they are picked up from Labgrid via the u-boot-test-getrole
> +        # script
> +        board_identity = role
> +        cmd = ['u-boot-test-getrole', role, '--configure']
> +        env = os.environ.copy()
> +        if build_dir:
> +            env['U_BOOT_BUILD_DIR'] = build_dir
> +        proc = subprocess.run(cmd, capture_output=True, encoding='utf-8',
> +                              env=env)
> +        if proc.returncode:
> +            raise ValueError(proc.stderr)
> +        # For debugging
> +        # print('conftest: lab:', proc.stdout)
> +        vals = {}
> +        for line in proc.stdout.splitlines():
> +            item, value = line.split(' ', maxsplit=1)
> +            k = item.split(':')[-1]
> +            vals[k] = value
> +        # For debugging
> +        # print('conftest: lab info:', vals)
> +        board_type, default_build_dir, source_dir = (vals['board'],
> +            vals['build_dir'], vals['source_dir'])
> +    else:
> +        board_type = config.getoption('board_type')
> +        board_identity = config.getoption('board_identity')
>   
> -    source_dir = os.path.dirname(os.path.dirname(TEST_PY_DIR))
> -    default_build_dir = source_dir + '/build-' + board_type
> +        source_dir = os.path.dirname(os.path.dirname(TEST_PY_DIR))
> +        default_build_dir = source_dir + '/build-' + board_type
>       if not build_dir:
>           build_dir = default_build_dir
>   

