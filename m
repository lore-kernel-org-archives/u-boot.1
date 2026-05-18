Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72743CD4F3C
	for <u-boot@archiver.kernel.org>; Mon, 18 May 2026 08:02:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F180F83FEE;
	Mon, 18 May 2026 10:02:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="RtRQKHk0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6419984150; Mon, 18 May 2026 10:02:10 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3902983AA9
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 10:02:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-48ff4f8ef0dso22140845e9.3
 for <u-boot@lists.denx.de>; Mon, 18 May 2026 01:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779091326; x=1779696126; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:to:subject:reply-to:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=UA5BWW1eY/k6uXhVi5Vfp91r+VRdy5jIs3HtyF0BZcU=;
 b=RtRQKHk0IQDOs1rkSehFpV5iKIiidKDvgefadw7NDePGGx64revTpekoqWCWzpbYDY
 lZbrDlNt4h17itLJkihN4lykd8fZ5HKYaLxDUmELxA11wuRqYOPukvaSD6oMJXbReXn+
 aMFC5wdAgXRBDwfDU3Ww/jklflkwuK1lszQxpstZQH9rPSPPDdMNKqu7LrafgYK2kSpc
 Sx+223rCHO4EkqlWyTt0l2oaz22vEArhx61tSZ4Sq7dysQg4jhYZySp5n4zQyMqAYd8k
 NXxAZuuAJnvu7gFXzlHJP6XsGKw1KSH6n480XYdKHsRIhMpP9FrTY4Q9V9X58qvz1uJJ
 VzCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779091326; x=1779696126;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:to:subject:reply-to:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UA5BWW1eY/k6uXhVi5Vfp91r+VRdy5jIs3HtyF0BZcU=;
 b=orTyAwkS8cM6yDWTfauSGC8uxU9l31wjbsJLPzZFz0rIdkj05JSIOCZLR4dFHjx1qX
 nMS8oVh6iE9s9AsHkgN2fAqFfnZWY3cPNvdZeNEnd65KwhBKXR85F5wd0rBm5zglaoZC
 nlPgUZcsQN8GcnjZPGJO76PvnS2BQ1zxXXFdP2DO55pGZz8kI2s2DlIEeKYem7jInsuq
 yNN9+6+w3qEgdyf2t91Arevz5rWMB5JPS7OI1tEEQUgutAaJunOUpl41kzlNYIIqdNB1
 goHoCywwAX1wPkS3gbm2xq+JgfQ/KQAxAO2hedSjgUJdAQZmbYC9tqG6aYHJyQnJRSEA
 oObw==
X-Gm-Message-State: AOJu0Yw0YLCXP8YyRHElWd8+MjIAfFwzDkaBZuwzdzbUUq6cwLaPntvJ
 H5+TNrwqhOWK4NEn8QiZECwPecBpod7WPOMbYPQSvpAUF7sCDHNcEEIg/LjkAtr59Oi+c/TeweL
 hQPAK
X-Gm-Gg: Acq92OHwE57QBBWTeccbJ1JIAinlB8t6uq8lqN+QvgP7MxzwpAqzwjuzaVCJxKcw4iq
 AJwSz1VEIDbhSM1jEve/Oj6E6YG5nj+5dM4bZ57wNp6gyvddfg73IsBim99Wi4rlPm9fHnaoaIW
 admntC9SaeFBqz76dH8Hu7zXfq74tmkzGQCJadN92TuUs274Z5oh/O8zZjD84uRCiAROQYBn2w9
 gj5Rp4wfAeJfKtZDpUFENzhMMOf4bcQbFzHwYIWvmfzeYqSL+WPL+SG6a60jK9OTkgC+oXwIyGn
 cUPuSBsnAb5zbqHAyvzWrC97izovjR5wpsEd+CH7SS47VSRJi4xGxcaNJO+nbPgViB+aihdGvS7
 w2D8dJrARalHurmmRjbXJyOMpzJULr+zObehozjDKcnnXbWienVMrmjLCqmxq8fmv+Y7RtN57+D
 CrmQwEInJV5qTsyrymF81zf9p7SF4OZUrhDFCUNy0cc6qsBGuV6ugmcoVi9RPUT35+u9UqX7ddL
 caR
X-Received: by 2002:a05:600d:10:b0:48a:568f:ae6d with SMTP id
 5b1f17b1804b1-48fe60e7d79mr174906365e9.8.1779091325227; 
 Mon, 18 May 2026 01:02:05 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:106d:1080:64e2:72b:b9ed:6dcf?
 ([2a01:e0a:106d:1080:64e2:72b:b9ed:6dcf])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fe4c8344asm409480185e9.1.2026.05.18.01.02.04
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 May 2026 01:02:04 -0700 (PDT)
Message-ID: <431cb228-c0f2-49e9-a3cf-9869fc954d1c@linaro.org>
Date: Mon, 18 May 2026 10:02:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/9] ARM: RPi5: Enable PCIe
To: u-boot@lists.denx.de
References: <20260516113940.647CE68BEB@verein.lst.de>
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
In-Reply-To: <20260516113940.647CE68BEB@verein.lst.de>
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

On 5/16/26 13:39, Torsten Duwe wrote:
> Basic PCIe support for the RPi5. This is the prerequisite for PCIe
> slot adapters / HATs and NVMe storage. Those might require their own
> supporting drivers or changes.
> 
> Changes from v2:
>    - fix wrong subject prefixes
>    - make reset drivers only found on the RPi5 depend on ARCH_BCM283X
>    - some patches Reviewed-by Peter Robinson

It seems you completely ignored by comments and review on v2:
https://lore.kernel.org/all/bcad697e-56f8-4256-8d24-41c5ef644ff8@linaro.org/
https://lore.kernel.org/all/f46be233-e35e-4a42-8663-342e9913e784@linaro.org/#t
https://lore.kernel.org/all/5ba58555-78cd-454f-9fcc-5aaec5fd4205@linaro.org/
https://lore.kernel.org/all/0d1c9e66-62c5-491f-9fba-97f262a1153d@linaro.org/
https://lore.kernel.org/all/fc11057b-edd2-428b-a67d-1cc22bd79492@linaro.org/

Thanks,
Neil
> 
> Changes from v1:
>    - fixed inbound window rewrite, which broke RPi4
>    - series Tested-by Pedro Falcato
> 
> Andrea della Porta (1):
>    pci: brcmstb: Fix PCIe bus numbers
> 
> Torsten Duwe (8):
>    ARM: bcm283x: Add bcm2712 PCIe memory window
>    pci: brcmstb: Support different variants using a cfg struct
>    reset: Add RPi5 brcmstb reset facilities
>    reset: Add RPi5 rescal reset facilities
>    pci: brcmstb: Get and use bridge and rescal reset properties
>    pci: brcmstb: Fix iBAR size calculation
>    pci: brcmstb: rework iBAR handling
>    pci: brcmstb: Adapt to AXI bridge
> 
>   .../mach-bcm283x/include/mach/acpi/bcm2711.h  |   7 +-
>   arch/arm/mach-bcm283x/init.c                  |  10 +-
>   configs/rpi_arm64_defconfig                   |   2 +
>   drivers/pci/pcie_brcmstb.c                    | 391 ++++++++++++++++--
>   drivers/reset/Kconfig                         |  16 +
>   drivers/reset/Makefile                        |   2 +
>   drivers/reset/reset-brcmstb-rescal.c          | 103 +++++
>   drivers/reset/reset-brcmstb.c                 |  97 +++++
>   8 files changed, 590 insertions(+), 38 deletions(-)
>   create mode 100644 drivers/reset/reset-brcmstb-rescal.c
>   create mode 100644 drivers/reset/reset-brcmstb.c
> 

