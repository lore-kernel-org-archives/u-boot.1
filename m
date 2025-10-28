Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2E80CCF9E0
	for <u-boot@archiver.kernel.org>; Tue, 28 Oct 2025 08:19:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4EC4F839D6;
	Tue, 28 Oct 2025 09:19:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PyJXzPeB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 51C5483A24; Tue, 28 Oct 2025 09:19:56 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44AD9839A1
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 09:19:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4770c2cd96fso19547445e9.3
 for <u-boot@lists.denx.de>; Tue, 28 Oct 2025 01:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761639594; x=1762244394; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=BaJt7FXU7tQZ+xYaBA1FppP/Llve2J3rcUdQEUl4/lE=;
 b=PyJXzPeBHZm9nfrZVExMjA6X3/dBedRwWBYCdZKN0OlKGWw6mdVotLHU65nIF8YYCT
 RuaAHi2RZG6r5E+p5uzqvuyoyiqQO7jH4eYnHwgKfwWJc3cz4M/pn4cWXcKgOgW1Z1rt
 O1kG5I1GdKnx02BNmCnQX00XE2GkjXjVVXkCCCtyQtXcG4juelGOnvurWUCsH4jh5uxt
 XOPwo5Inb5kRnIRKNfYV5PAWTu5Fftj6ICV3WkRKEEMT73ESmSIDOwb0NgxuaN0tB4wq
 fgUfnNKOZdzB00dj2XbjK6W/ZBHWi1msS9CUFAJBI8+Rm3/aFUUHASalhsBD7R9LLAbO
 rfvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761639594; x=1762244394;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=BaJt7FXU7tQZ+xYaBA1FppP/Llve2J3rcUdQEUl4/lE=;
 b=BBplVfuj5pkX/M4bIf9kKrhwHWYbPvMrClEMsST2+K/0yB12V8MOmqKQL3f153RbR2
 RpRfLx5E7jEYTFyNyNf/zEPa8YndmkMs/NYvjNFKgHOxfdpf4KHWRdVSF5l3TlBzLhpW
 GCWMIY0q3GlRnX7I8iAIQYoypTGiX4iqUGI8pHmfBeK5W/uM/5NwZ2iQtanWx9pO38EO
 IDgbPz/AEzCcEVzHIMEJKxIXBHiz+O/IOtfW/bKv0A1s/AqKqXBaFcIDz8N5FVa0ciVq
 7ZLu/Z5r6QVJgR0uPr+lm4Zpgc9NQKGBnPJaqD+C6ObmNGDtxNc0KgAB7Mnriklwfizi
 ogUw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhfEipF4IMpJlHYWb9voZHRS8A2gdT8LMpVh6RafLXYsEC8GfBoiYbyaAjj1aOt9GYXODqpHU=@lists.denx.de
X-Gm-Message-State: AOJu0YzITI8LY3amuURQzlKNnNzeJr98bPtAnbUk2fYiSgXTBLZuB6/r
 F74DMiE7XSP6kAdLxr3zUTAhB30pfhpj+qFNJbh4YNpNx9S9MfE3Qn9eVxN5EdIfowc=
X-Gm-Gg: ASbGncvIU1HCiITgaehLiccnXvYgyWcm5j3RqNwJKql4bhCtvU9/uAY++qUYPflrjYN
 Dpe2ciuQYEwVGkiWu4zljuBvHbHetIOGuNv97DRuUaOwWB35H3MgT5lWYEmS7ibaUHlc7NVifi4
 hGISdCGoMYc2y985Zmm/pH48Rr6Wu0T+d/NuoAYps1ZvIiAMdXVOvmonvIhKNBaYADR9qAhRgq7
 xiRd4uEny5Wu0SRtfs4miRmWNk8QvlCILSVSBrkf/ZKhYv8SeVb7s+FNj3VVbc+q+ftG/W5iuTq
 aQK3V+TISHyDUROQN8tHauzHjvkCBReB06RiCbAiRuJDU9NDpu7n1GuE9RX52beUp7UiCJvsdsO
 lYdFTXEyXEMLXVQu5o0ztQP1MM9nu6jMMT0MNq7wGhrGOEtUwKOny8hyz6qZRdQ+L/o1zmikg3d
 LibxsjhMxnpIKJRWqAI/w7VC7Zmq15jUEcLNgV4vkYlZK7BhzdAg==
X-Google-Smtp-Source: AGHT+IF20+63K7NQgN50Nhj4+/yOhJuRpHFfbsPyB+jmpFiUCfj9nflK71UJvDQWHSEEcCygTO47Nw==
X-Received: by 2002:a5d:64c3:0:b0:427:9d7:86f9 with SMTP id
 ffacd0b85a97d-429a7e8a9c8mr2145492f8f.47.1761639593570; 
 Tue, 28 Oct 2025 01:19:53 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:cad:2140:ebe6:df10:d28d:aa5?
 ([2a01:e0a:cad:2140:ebe6:df10:d28d:aa5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475dd47853csm183345875e9.13.2025.10.28.01.19.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Oct 2025 01:19:53 -0700 (PDT)
Message-ID: <5e94dba5-b922-4536-aa29-bbdd7aeafb0d@linaro.org>
Date: Tue, 28 Oct 2025 09:19:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH RESEND] binman: fix mkmbn integration and tests
To: Casey Connolly <casey.connolly@linaro.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20251023133850.3686431-1-casey.connolly@linaro.org>
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
In-Reply-To: <20251023133850.3686431-1-casey.connolly@linaro.org>
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

Hi,

On 10/23/25 15:38, Casey Connolly wrote:
> Add the missing cryptography requirement to binman so that mkmbn
> will work correctly, fix a pylint error, and adjust mkmbn to properly
> integrate into binman rather than writing the output file directly.
> 
> For now skip testing u_boot_mbn since it has some weird requirements due
> to how mkmbn works and can't be easily integrated into binman.
> 
> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
> ---
> Resent to fix my name
> ---
>   tools/binman/btool/mkmbn.py      | 9 ++-------
>   tools/binman/etype/u_boot_mbn.py | 5 +++--
>   tools/binman/main.py             | 4 +++-
>   tools/binman/requirements.txt    | 1 +
>   tools/qcom/mkmbn/elf.py          | 6 +++---
>   5 files changed, 12 insertions(+), 13 deletions(-)
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
> diff --git a/tools/qcom/mkmbn/elf.py b/tools/qcom/mkmbn/elf.py
> index 86f12d1f4e5d..7737adc6a4e2 100644
> --- a/tools/qcom/mkmbn/elf.py
> +++ b/tools/qcom/mkmbn/elf.py
> @@ -171,11 +171,11 @@ def _align(i: int, alignment: int) -> int:
>   class Elf:
>   	ehdr: Ehdr
>   	phdrs: List[Phdr]
>   
> -	def __init__(self):
> -		self.ehdr = Ehdr()
> -		self.phdrs: List[Phdr] = []
> +	def __init__(self, ehdr: Ehdr | None = None, phdrs: List[Phdr] | None = None):
> +		self.ehdr = ehdr or Ehdr()
> +		self.phdrs: List[Phdr] = phdrs or []
>   
>   	def total_header_size(self):
>   		return self.ehdr.e_phoff + len(self.phdrs) * self.ehdr.e_phentsize
>   

I understand all the changes.. except this last one.

Could you elaborate ?

Thanks,
Neil
