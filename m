Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8620EB597C
	for <u-boot@archiver.kernel.org>; Wed, 11 Feb 2026 08:34:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47E9E83E3A;
	Wed, 11 Feb 2026 09:34:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="mKRT+Ctc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1957B83E40; Wed, 11 Feb 2026 09:34:52 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 67D45802C1
 for <u-boot@lists.denx.de>; Wed, 11 Feb 2026 09:34:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4806cc07ce7so15730085e9.1
 for <u-boot@lists.denx.de>; Wed, 11 Feb 2026 00:34:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770798888; x=1771403688; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:reply-to:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=oBs4V6Zeg0KTcWMuh+yTMP84EbZtjwejhhkXxbVCQwE=;
 b=mKRT+Ctc4JbTEMToFtwM1vE5jJYTd7KM42URgg5p7ee6XHPE1qalaW8Dt4J8TrAIvJ
 l4E1BMS6LYKKAc/nUNw7uPo0I7anBe3HY/Cf+EFdVzrhvL36Oho9iy2at7VVJq/hOREe
 bp2PIebeSkN/hCR69S7uxVjuHtiO+zuF3HTqtY0S1//mtc/SZkmHVZS7zbHNugn5Wiqv
 6jZuRlD1jdfVUa8NLJiFgL7LAAoMNV8eJnJcea3uteyX9xmPugXPcb9oXyJuVcIFQIqZ
 qkjDiSv5ICZRt2TXeOifOhkM6UXqnOmv8K8uof+xt8kYy5yS/ULunv8hiDx5QBBxxDBg
 +F6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770798888; x=1771403688;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:reply-to:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oBs4V6Zeg0KTcWMuh+yTMP84EbZtjwejhhkXxbVCQwE=;
 b=kGb2puM1wXLzHuqipkhJqZxt50AAGRA5j4+p9h7froP0cJhbSPClJezWCWQYKB4BTR
 4ZT2ZGdxjqv0PndH0D1KAqprjlyZyY1n/DY34OrZWg0WmOtz59vrmec9f/dGzJvlhJWq
 a3FVxOFS/vhDMYWDIY2tQYCoJO0bE1jRgVGqy3eeyhEne+oRopXz97Al+hO2pT5gO1gn
 QRXteiLJQgyLKpYkyqO593PFKsIyAhRkA8n2/sTYcWNwqN5r/vDz6Eg1/jToNsHrkYE7
 i17lxLDTZ0UQTVnxlCnofDoEF98sRpELpZ0H6LFcutgCrc0idX935ZiUTGhECNZb+6oD
 FdqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWW4Pv7Jgqm0xPCTkofEWBGbUlDCQxg+xfWHqv4AmgxuRPLCKwbx5TACl3g4cxqLAEtLIvqyO4=@lists.denx.de
X-Gm-Message-State: AOJu0YzLm2Srp7beq6xEvFwkd2cS2/T1IMBPgf6b/WdEL6hrCHYwGWoi
 VLE2FR9iwqIN/D1gFHj+NQSXmjWAb+XAygZvGl3ICBIZT40uWGr3XVWO04T6YUscCnU=
X-Gm-Gg: AZuq6aLVHIfCw/RsHiD9otUWjXERtUTyR//XU3TbAkxla47ATiamYok8iyxXXXNg6+j
 vlaJQhN9eUm27eNjqNJkXjPFSxNt0uAaNV7v8fiOXsahnmN/8NY0Gyj4N5dpPMEOSd49FSKvE+n
 95HnzaxpsUqauWike/2ExpP5FQm0ty8YVDAwNW6mz/eZfuvYflbunvUrSsWxTApZ7I023e7nil2
 C/gsbxfcitsTC/IaxyPFv/dKgazKCzZv7h5UMD2vTvlFQGtWQjdetaiq3ho6Ju29YCKIcEviMWj
 Dd+CNUPqpVR4ac5qpPiOjfbrbgDH1UDu30LRuu5RdIAQi5A7+qleWs7DWyhPfaPnuuT3X4RidG9
 6u4vL3N1FaSleX39Lxqm2u4qEYOA+qlbqEbyuV1sdCUVKyglYT6KBrktI1aEiOvNeFzJiD4kkg9
 kapXDNFrwT4tvyiqYvoLR7LunGUcXcIt4RnW/SxFK+zUdZi1JDuHs5IkLJrF2cC8Wjas13UtiiC
 gneWg==
X-Received: by 2002:a05:600c:46d2:b0:480:4a90:1b06 with SMTP id
 5b1f17b1804b1-4832022c31fmr250520435e9.34.1770798887664; 
 Wed, 11 Feb 2026 00:34:47 -0800 (PST)
Received: from ?IPV6:2a01:e0a:106d:1080:8cb4:9578:dd36:7e01?
 ([2a01:e0a:106d:1080:8cb4:9578:dd36:7e01])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4836131d52bsm1717515e9.28.2026.02.11.00.34.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Feb 2026 00:34:47 -0800 (PST)
Message-ID: <50e4b2d0-82fa-4bb5-ab18-bef63e6907ec@linaro.org>
Date: Wed, 11 Feb 2026 09:34:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/3] efi_vars: Implement SPI Flash storage for EFI
To: Michal Simek <michal.simek@amd.com>, u-boot@lists.denx.de, git@amd.com
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jonathan Humphreys <j-humphreys@ti.com>, Shantur Rathore <i@shantur.com>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Tom Rini <trini@konsulko.com>, "Ying-Chun Liu (PaulLiu)"
 <paul.liu@linaro.org>
References: <cover.1770119483.git.michal.simek@amd.com>
From: Neil Armstrong <neil.armstrong@linaro.org>
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
In-Reply-To: <cover.1770119483.git.michal.simek@amd.com>
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

On 2/3/26 12:51, Michal Simek wrote:
> 
> This is updated series based on v3 version sent here
> https://lore.kernel.org/all/20231126220836.374956-1-i@shantur.com/
> 
> that's why I am continuing on v4 instead of starting from scratch.
> 
> Tested on kv260 with saving variables to location where User MTD partition
> is.
> CONFIG_EFI_VARIABLE_SF_STORE=y
> CONFIG_EFI_RT_VOLATILE_STORE=y
> CONFIG_EFI_VARIABLE_SF_OFFSET=0x22a0000
> 
> In Linux:
> root@som:~# mount | grep efivars
> none on /sys/firmware/efi/efivars type efivarfs (rw,relatime)
> root@som:~# printf '\x07\x00\x00\x00Hello' \
>    | sudo tee /sys/firmware/efi/efivars/TestVar-12345678-1234-1234-1234-123456789abc
> Helloroot@som:~#
> root@som:~# dd if=/sys/firmware/efi/efivars/VarToFile-b2ac5fc9-92b7-4acd-aeac-11e818c3130c \
>         of=/tmp/vars skip=4 bs=1
> 1352+0 records in
> 1352+0 records out
> 1352 bytes (1.4 kB, 1.3 KiB) copied, 0.380992 s, 3.5 kB/s
> root@som:~# flashcp /tmp/vars /dev/mtd16
> root@som:~# reboot
> 
> Reboot and then in U-Boot:
> 
> ZynqMP> pri -e
> ...
> TestVar:
>      12345678-1234-1234-1234-123456789abc (12345678-1234-1234-1234-123456789abc)
>      NV|BS|RT, DataSize = 0x5
>      00000000: 48 65 6c 6c 6f                                   Hello
> ...
> 
> Thanks,
> Michal
> 
> Changes in v7:
> - sed -i 's/efi_var_from/efi_var_from_storage/g'
> - sed -i 's/efi_var_from/efi_var_from_storage/g'
> 
> Changes in v6:
> - Return EFI_SUCCESS in efi_set_variable_int() when
>    CONFIG_EFI_VARIABLE_NO_STORE is enabled
> - sed -i 's/efi_var_read/efi_var_from/g'
> - sed -i 's/efi_var_write/efi_var_to_storage/g'
> - sed -i 's/efi_var_read/efi_var_from/g'
> - sed -i 's/efi_var_write/efi_var_to_storage/g'
> 
> Changes in v5:
> - Invert logic in efi_variable.c and avoid #if
> 
> Changes in v4:
> - New patch based on review comments from v3
> - Extend Kconfig description
> - Extend commit message and describe efivar missing part
> - use unify methods for reading/writing variable
> 
> Changes in v3:
> - Fixed compiler warnings.
> 
> Changes in v2:
> - Refactored efi_var_file to move common parts out as requested
> - Changed ifdefs to use CONFIG_IS_DEFINED
> - Fixed typos
> 
> Michal Simek (1):
>    efi_var: Unify read/write access helper function
> 
> Shantur Rathore (2):
>    efi_var_file: refactor to move buffer functions
>    efi_vars: Implement SPI Flash store
> 
>   include/efi_variable.h          | 18 +++----
>   lib/efi_loader/Kconfig          | 34 +++++++++++-
>   lib/efi_loader/Makefile         |  3 +-
>   lib/efi_loader/efi_var_common.c | 42 +++++++++++++++
>   lib/efi_loader/efi_var_file.c   | 65 ++---------------------
>   lib/efi_loader/efi_var_sf.c     | 92 +++++++++++++++++++++++++++++++++
>   lib/efi_loader/efi_variable.c   | 19 ++++---
>   7 files changed, 195 insertions(+), 78 deletions(-)
>   create mode 100644 lib/efi_loader/efi_var_sf.c
> 

Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on AML-S905D3-CC

Thanks,
Neil
