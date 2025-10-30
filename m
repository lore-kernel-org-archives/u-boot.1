Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B38EFCCF9FA
	for <u-boot@archiver.kernel.org>; Thu, 30 Oct 2025 08:42:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EE15A838D7;
	Thu, 30 Oct 2025 09:42:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Ldlx8Tvd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C5B0838F8; Thu, 30 Oct 2025 09:42:20 +0100 (CET)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 011FD838CC
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 09:42:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-426fd62bfeaso353658f8f.2
 for <u-boot@lists.denx.de>; Thu, 30 Oct 2025 01:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761813737; x=1762418537; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=w1WJzpl9czm/nyHNivmcSHgKX0csoVLJA9GkMuH8hs4=;
 b=Ldlx8TvdJbQeoKqWQ15xaE/ZVcMfouLLff4ZXdyUGnGAxUIjzTkZsDLD63sMh1l40+
 BUCMpiXj3Uz2/incCv2xf7mj0OIwwIk6D6AFIyqJ4vKJz90ahTqQdOnMRc/TO+QIbM4L
 FceiZ6szrq5x05TnqMb3F/r3OBaN2+ze0xQZ5zm7r+2UHzrGq+gckgc7+AtgtXMM3vUg
 TQk/jIl3k9tNEe66HeMDzVX2LlCwzx0RwiWDTsXjWVfdzcuMSaDdcGvjpOFX97N7G793
 brs2cn0TE19JsBtWWlabfuJZAz7SCFOYHg8NYmTeaVcqHUVFtPBgcaCHgHtUSwzapb6r
 260g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761813737; x=1762418537;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=w1WJzpl9czm/nyHNivmcSHgKX0csoVLJA9GkMuH8hs4=;
 b=cNQ3JecW38bXUbCYQuTEb6yHQKI9c8SEqmwztw55WIoPJZlvNk8ID3NwLn3XJc3yug
 7tkH+4nhLezGQi6Gjjyd8LcH8GoEc0NTu9Y/DyeunmyN3dmBLc6iaHquwISdqjDBoHoM
 2vgXwEyJ/4xEHQQZQOAOcQCMyyoto6HN4t5s9gsZ9nQyQ7HP8+vyEigPyFtr1fWQaXgQ
 jZ0aVlmpTFbM1v9ehkknoTqpiQjqzJv6hOXYpOnSKDZx2JJinv5NgEtbAqfJ+38+MklQ
 9ZW/qISQJ/Zgm9EIro6WkG6boNWPa7tjsW+ZjeIrK6DyhVrxs3exLdqa0FJlh3g8wcOG
 qJKw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/lBmg4A2TcUA05236P8Ixa//aTNQL0/PuXKGnDbSS22uEK1D4+gGx7QER2KshWvCvmVDN3/I=@lists.denx.de
X-Gm-Message-State: AOJu0YxcpMCHCZHL/oNwfEncbRziwLg/X8xKaE01p38w2Hl/DsVDyDY2
 fnM8+obnSlPEBg1E8b/J39Olyiq8DbRi4dgvkNEp7tmgaivVU3wZSMjHS1TEKHbPmrlDqB+JcQD
 imu2r
X-Gm-Gg: ASbGncu8ma4BkYsTqmk66/hoVDexVzoWUZ3U+XUCcNHpKbNA0EpDWOiR8BX+mZo5AZS
 QYDtX0MYcEHwj7xyQgjbgSmBvqFwiW/ZZmCwn9m/2nHHMvhIrp6KMuHG3SxtaP9smIaEPOUVC2O
 FzkKGL8xZknI+GXXFEmjnKs5e8UUB+Ew3Fxn9MSV0/3cRLyx+vFSrEWKcIloBOjp20ZLH1xLVP0
 9qPox/n3HU5aBMS/BGkRDJRJrEoZbpGwh6dovq5M5h0bVu87SJsu8DUTsIH9+3C+y7IpPjaaeqx
 afk15hXoL5IO2jix+OlkRtESg+G1q3gb4H6mm6fP4dK9qV/M2ODMpppZb0/3lfubp50w0Y4yeNE
 P4pxr0Q812/1yTaxYkIGOVczBAXX0PxuBIZESGIAOgISO3uJi7TLk0/BeXtnfB6On/6o138aZbi
 kJy+1DFz4cccVc67jjb2Fv8O3wiPY0bEl4p3rKojHHqrLHjuMjQP0hbJBwazOHl4I=
X-Google-Smtp-Source: AGHT+IFkVII1c8XhmlQE3rUhflKmD+tMS7JouCWlI67cBdDnADIXsu4MvinwZoalk2utym3lW+8JTg==
X-Received: by 2002:a05:6000:240f:b0:3ec:db87:e8fa with SMTP id
 ffacd0b85a97d-429aef830bbmr5092108f8f.26.1761813737219; 
 Thu, 30 Oct 2025 01:42:17 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:cad:2140:3e45:b3e1:4bfc:5477?
 ([2a01:e0a:cad:2140:3e45:b3e1:4bfc:5477])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429b9b43eb5sm1433632f8f.28.2025.10.30.01.42.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Oct 2025 01:42:16 -0700 (PDT)
Message-ID: <60141b41-c456-4ea3-a755-d6b4c546d417@linaro.org>
Date: Thu, 30 Oct 2025 09:42:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH] tools: qcom: mkmbn: fix Elf constructor
To: Casey Connolly <casey.connolly@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de
References: <20251028111334.2508482-1-casey.connolly@linaro.org>
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
In-Reply-To: <20251028111334.2508482-1-casey.connolly@linaro.org>
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

On 10/28/25 12:13, Casey Connolly wrote:
> The Elf class constructor was missing two optional parameters: the Ehdr
> object and a list of Phdr's to populate the Elf.
> 
> Add these back so that the parse() method will work correctly.
> 
> Fixes: 9fe658c97f5e ("tools: qcom: add mkmbn.py")
> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
> ---
>   tools/qcom/mkmbn/elf.py | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
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

This patch is required to finalize the Qcom PR, I guess it's fine, so LGTM

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
