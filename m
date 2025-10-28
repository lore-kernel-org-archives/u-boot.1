Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0983CCD1BF
	for <u-boot@archiver.kernel.org>; Tue, 28 Oct 2025 13:03:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6CED883710;
	Tue, 28 Oct 2025 14:03:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zqGYMzRO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 59CF483710; Tue, 28 Oct 2025 14:03:13 +0100 (CET)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0FABA82A9E
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 14:03:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-4285169c005so2772805f8f.0
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 06:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761656590; x=1762261390; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=l0AF6t0D6qIdNelC88Fnh8/azVYr9wpCsEXWFWxq4Jo=;
 b=zqGYMzRO5mjMKWGR2uzGBW8/8QDfc/5qxbU2hd64cRGOm97ahTxQJh7E9Rjs0D4W13
 FOBTZxtyUdVC8yLeig/V0qD4viwzXcdNuQosP5j9ld8yJPHn6+im3sh3S6LWLIbxrTEW
 GyqKbhqy9KQEYXzMykt8xK3wtxQlUW/y7ZoGbitxZpAJx+PuSaRd1eShHgtP0hjRTj++
 RidIrZ+L/bUTflWloECtAznv+3FD/XOVvsXG2TNvfJGB1NCGn0zuIY2diFBuumAZUtCj
 2RhqBSxwlOOQBI3LbcwYktvdYbv9EnXyBhRvgEDIBfggOx5LrqhNrVoSQ0Q6eehEPKqj
 TJ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761656590; x=1762261390;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=l0AF6t0D6qIdNelC88Fnh8/azVYr9wpCsEXWFWxq4Jo=;
 b=hUK38LSlgvhDNVTYP0P5qTZ0VDCrd69MOeScbJ1juXxfpT/UE0CuSd0YeWDT/Vvswa
 Ysw4LdSRCZZvHyC2eI+LaYbwcrNphvGpJWwVqfzTqKzqPk/BXBWWeI3Lzr4akf92W8rv
 UwnKqPwnywupnxcin9Ia4r//I461/2S+CNIUe4kevYDz886sl27vqM5IOtxcNnHj4DR5
 iUtrknuZoEfLjiEgyl4rG3Xqe57RTHOJGKJOpD8BbVGiXDG74F0D/2b0RmeIIHrWDII5
 3Xo2/+cgqTM5vD4Pof0eGi+cDhkf6y8YDcWMQT/Ze79rifUX9irtEXlmkw37MwsXHuBg
 w/Ag==
X-Gm-Message-State: AOJu0YwiioQeoAv1AmC+WtJIm3JUgLZYzGydaw9Hr9NBKyaAJ8wV5/li
 iviN6vvJeeg0A66xjLYU70QeKiysjka7XoHAiXZuQ9/0orFb6OljLkxmiwf2Slrr8JASsI46nQ+
 pnLb35+s=
X-Gm-Gg: ASbGncujCaptpwc1L380i7BacZohI/peH9BRjpMKlt/6B3gOIKAdjjd+hn9STryBIJj
 9MjDkOuwcLv70bczTCyhEa9PWK2mIyoIbGTd+oKlVN4KH3655KMLOra3nitRcBJb40suHgvgIjs
 tjUd50HntrEr2QpDtqvdlg4fdVa7PoFQExDXH6nOJsNNZIiQB/RNtIRqWSByZWgD1OvdioO47yc
 MI0H8K/Z8vG6Jaxd4Iay25JPhoe5WKDypB5h1sTpLwt4Ob/qyvfYiUtYAEZdyOefHAm5M3avoB+
 hvFbjD51jSIS+Tmj6eQS59d4vN4qJM4FUwWJOHIvRr78/5fa8tZeFm/UMcXQx/NV4SPUGT5LuJ/
 A37To4Z7MlhbQVI1JXc6b0bCgpI9kC8oAKLazHxd/emhlRSyDLPCxo1twchZTxaqU09pcTtg3Bp
 JKlQ4VXA1GoF0d+Y7MyfyXspSVmukvjvHRy/jKQekDmeAYtZjRYQ==
X-Google-Smtp-Source: AGHT+IHpnhs551TFM4p7I4uE86nGISK/ORo9PSfsSiM/VLcG/TMw4SstHYcaKGiDdlXnMw6hQSzUJg==
X-Received: by 2002:a05:6000:491a:b0:429:a81a:a77b with SMTP id
 ffacd0b85a97d-429a81aa96emr2456693f8f.31.1761656590313; 
 Tue, 28 Oct 2025 06:03:10 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:cad:2140:ebe6:df10:d28d:aa5?
 ([2a01:e0a:cad:2140:ebe6:df10:d28d:aa5])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952df5c9sm20316021f8f.41.2025.10.28.06.03.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Oct 2025 06:03:09 -0700 (PDT)
Message-ID: <cd06e85d-8c66-45f8-a149-a6021394a272@linaro.org>
Date: Tue, 28 Oct 2025 14:03:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH] binman: fix mkmbn integration and tests
To: u-boot-qcom@groups.io, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20251028111604.2510314-2-casey.connolly@linaro.org>
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
In-Reply-To: <20251028111604.2510314-2-casey.connolly@linaro.org>
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

On 10/28/25 12:15, Casey Connolly via groups.io wrote:
> Add the missing cryptography requirement to binman so that mkmbn
> will work correctly, fix a pylint error, and adjust mkmbn to properly
> integrate into binman rather than writing the output file directly.
> 
> For now skip testing u_boot_mbn since it has some weird requirements due
> to how mkmbn works and can't be easily integrated into binman.
> 
> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
> ---
> Changes since v1:
> - Remove mkmbn elf class fixup, it's a separate patch now
> - Link to v1: https://lore.kernel.org/u-boot/20251023133850.3686431-1-casey.connolly@linaro.org
> 
> ---
>   tools/binman/btool/mkmbn.py      | 9 ++-------
>   tools/binman/etype/u_boot_mbn.py | 5 +++--
>   tools/binman/main.py             | 4 +++-
>   tools/binman/requirements.txt    | 1 +
>   4 files changed, 9 insertions(+), 10 deletions(-)
> 
> diff --git a/tools/binman/btool/mkmbn.py b/tools/binman/btool/mkmbn.py
> index 232e2b442a16..c1439977833e 100644
> --- a/tools/binman/btool/mkmbn.py
> +++ b/tools/binman/btool/mkmbn.py
> @@ -12,18 +12,13 @@ class Bintoolmkmbn(bintool.Bintool):
>       def __init__(self, name):
>           super().__init__(name, 'Generate MBN (signed ELF) image for U-Boot')
>   
>       # pylint: disable=R0913
> -    def run(self, infile: str) -> CommandResult:
> +    def run(self, infile: str, outfile:  str) -> CommandResult:
>           """Run mkmbn.py
>           """
> -        args = [infile]
> +        args = ['-o', outfile, infile]
>           return self.run_cmd_result(*args, raise_on_error=False)
>   
>   
> -    def get_path(self):
> -        path = super().get_path()
> -        return path
> -
> -
>       def fetch(self, _method):
>           return True
> diff --git a/tools/binman/etype/u_boot_mbn.py b/tools/binman/etype/u_boot_mbn.py
> index e470b31fa318..6268397fd122 100644
> --- a/tools/binman/etype/u_boot_mbn.py
> +++ b/tools/binman/etype/u_boot_mbn.py
> @@ -31,10 +31,11 @@ class Entry_u_boot_mbn(Entry_blob):
>       def __init__(self, section, etype, node):
>           super().__init__(section, etype, node)
>   
>       def ObtainContents(self):
> -        self._pathname = tools.get_input_filename('u-boot.bin')
> -        res = self.mkmbn.run(self._pathname)
> +        pathname = tools.get_input_filename('u-boot.bin')
> +        self._pathname = tools.get_output_filename('u-boot.mbn')
> +        res = self.mkmbn.run(pathname, self._pathname)
>           if res is None:
>               self.Raise('mkmbn not found or failed!')
>           # Exit code 61 (ENODATA) indicates that an MBN file can't be built
>           # for this board. This is non-fatal since it may not be required.
> diff --git a/tools/binman/main.py b/tools/binman/main.py
> index fa5ad79ca0e8..bfd6e990d2e4 100755
> --- a/tools/binman/main.py
> +++ b/tools/binman/main.py
> @@ -102,9 +102,11 @@ def RunTestCoverage(toolpath, build_dir, args):
>                'tools/u_boot_pylib/*'],
>               build_dir, all_set, extra_args or None, args=args,
>               allow_failures=['tools/binman/btool/cst.py',
>                               'tools/binman/etype/nxp_imx8mcst.py',
> -                            'tools/binman/etype/nxp_imx8mimage.py'])
> +                            'tools/binman/etype/nxp_imx8mimage.py',
> +                            'tools/binman/etype/u_boot_mbn.py',
> +                            'tools/binman/btool/mkmbn.py'])
>   
>   def RunBinman(args):
>       """Main entry point to binman once arguments are parsed
>   
> diff --git a/tools/binman/requirements.txt b/tools/binman/requirements.txt
> index 7db72e888e3e..51b8ecd73478 100644
> --- a/tools/binman/requirements.txt
> +++ b/tools/binman/requirements.txt
> @@ -3,4 +3,5 @@ importlib_resources==6.5.2
>   jsonschema==4.23.0
>   pycryptodomex==3.21.0
>   pyelftools==0.31
>   yamllint==1.35.1
> +cryptography==46.0.3 # for mkmbn

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
