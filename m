Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7173BC02196
	for <u-boot@archiver.kernel.org>; Thu,  6 Feb 2025 10:41:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB67A808A2;
	Thu,  6 Feb 2025 11:41:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="duF2VwhC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1885807E0; Thu,  6 Feb 2025 09:33:18 +0100 (CET)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6029280104
 for <u-boot@lists.denx.de>; Thu,  6 Feb 2025 09:33:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43675b1155bso6659775e9.2
 for <u-boot@lists.denx.de>; Thu, 06 Feb 2025 00:33:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738830796; x=1739435596; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=S9utXQWISkb0fmvoAKliwmI0iDhr636iYPixGX+bHeU=;
 b=duF2VwhCKnekV2fri27WYTIVg1EYNbrCN2AZOYYnarIrZLHud1hpJL3snJm+PpbwqD
 ILDJpfT7P3k3wxZhe8AWyebFMk/bIhx1Bq4MjF0p7beborYtpD5I1cb3yuern2SG7FU3
 LyO0vTbI/nZ3uQUr+G4I0qw/Ie8a+x/5wEn3tyBgmnaFVKKqKMTF0dNPND0zLZKOVlkF
 fdXoifsFflBsK0Xp/WX+6/b+x6zz0Rl5Z+73DEpJYeFIJvBAiss/NY4d4pm2AkXTdlMc
 ec6CCsA8b4ou3NO3zKixoLcv94BcuApeO3DhoK2mLBFkk4HI6V6v8rGsLUO86Juv1doW
 kvVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738830796; x=1739435596;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=S9utXQWISkb0fmvoAKliwmI0iDhr636iYPixGX+bHeU=;
 b=g6T+THHg2Rcd+CeqxFsQGbP2KmrDqzTJOk5saKVCkk1rHn8wLl/BZche2JU5veNBPK
 5GahFCXBXQK7GoZWAHNOQivGg34UfonlUv/KxUV9FiL+tUwKALNme8dACrZsm6KOWIdu
 X72DEOZ+OtQQyNiYmoqFns5UvieUSKcX0oeF8UuFdwkOqbNbSdw4PNFghr/xTpajqGQ5
 boUme5HtayfLKB8+l1ccmvH9XDLpunndfwmbUiHBFSxFNnP7BdqdIkHU9y5jf0EZus5S
 llRQesxuOlgPD/GM4wuPtqBE8RaxtVaCT2CmHR+uVhcCmlQOmrJAyVWOUWlZ+HjupWZu
 TlTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVxD6EcSIUQkeMNzVK38RSR4pMkmMnWGm3Q1DEf7AonyrG2F0crLE9b3m+lazqrvaG9Ou2sz8=@lists.denx.de
X-Gm-Message-State: AOJu0YxgmxPjnj6VW2amwNwd7l8fK90HLXxLR3RQYY6VUOu72wwqznBe
 B7kM12vXC9yEx5oIGWPi1QlF6yOhI27Yh5IqiaQ2ZxzlH/NlM+UxUWVom27T57s=
X-Gm-Gg: ASbGncv6yig/4DDuc5pKHDHt+9iO001zOx8oXcohQaa5CCbl15vXZ+lYt+adQ3P7SNa
 E4uWtAc1u8MdDc/RUgqpEAtzVgfqsnoq/3/+4uU8KE0xf73/BKYa0/VfTZtzqfSK65//0/X1XQx
 qy/J1ONmb5CIwLhWV5WR64wcgnHUWjhCuthrGT2CrdJYfrPrS53RO6CPVsP3ug9fkjRQY1OWe8Q
 hfmDnIEZvtKdlwbZ+kpg3GHZ8WS+xfzRvrJJ9g0Y6yb22+mh5+l4Ya/JR4uS0BLW0MEN7nB52G1
 ahn+flGjn8cyPCVJSTdSxh3SwyQRgX0ATeQr47lPHF7zG38Xq7G1MdCraIHuWMJIJb2L
X-Google-Smtp-Source: AGHT+IHdpDMDXoOndXHkBp8bGQQ4YiiSIUyNszJHyvEITqJyO/WcYxw4sKVvlgP1iLP61shPksSvdg==
X-Received: by 2002:a5d:6c65:0:b0:38c:2745:2dd8 with SMTP id
 ffacd0b85a97d-38db48d5cd3mr4384229f8f.37.1738830795689; 
 Thu, 06 Feb 2025 00:33:15 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:4972:46a2:e0cb:c0a6?
 ([2a01:e0a:982:cbb0:4972:46a2:e0cb:c0a6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4390daf4438sm48452505e9.25.2025.02.06.00.33.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Feb 2025 00:33:15 -0800 (PST)
Message-ID: <406a5c64-78be-4fe0-a3ef-c9846a389972@linaro.org>
Date: Thu, 6 Feb 2025 09:33:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v1 0/6] Fix page permission on arm64 architectures
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>, xypron.glpk@gmx.de,
 trini@konsulko.com
Cc: Alexey Brodkin <alexey.brodkin@synopsys.com>,
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>, Huan Wang <alison.wang@nxp.com>,
 Angelo Dureghello <angelo@kernel-space.org>,
 Thomas Chou <thomas@wytron.com.tw>, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>, Marek Vasut <marex@denx.de>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Max Filippov <jcmvbkbc@gmail.com>,
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 =?UTF-8?Q?Pierre-Cl=C3=A9ment_Tosi?= <ptosi@google.com>,
 Peng Fan <peng.fan@nxp.com>, Richard Henderson
 <richard.henderson@linaro.org>, Sam Edwards <CFSworks@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Andre Przywara <andre.przywara@arm.com>, Peter Hoyes <Peter.Hoyes@arm.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, Sam Day <me@samcday.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, Stefan Roese <sr@denx.de>,
 Joshua Watt <jpewhacker@gmail.com>, Alex Shumsky <alexthreed@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Michal Simek
 <michal.simek@amd.com>, Jonas Jelonek <jelonek.jonas@gmail.com>,
 uboot-snps-arc@synopsys.com, u-boot@lists.denx.de, u-boot-qcom@groups.io
References: <20250205071714.635518-1-ilias.apalodimas@linaro.org>
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
In-Reply-To: <20250205071714.635518-1-ilias.apalodimas@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Thu, 06 Feb 2025 11:41:33 +0100
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

On 05/02/2025 08:16, Ilias Apalodimas wrote:
> Hi!
> This is v1 of [0].
> 
> This is an attempt to map the U-Boot binary properly, but leave the
> area we load binaries unaffected and RWX.
> 
> There's a few changes since the RFC
> - Fixed the alignment of meminfo command when printing regions
> - 'meminfo' now prints arch specific attributes e.g PXN, UXN etc for arm
>    instead of RW, RO, RX
> - Since we don't set the permissions of EFI runtime services yet and keep
>    them as RWX, I removed the linker alignment changes which makes patch #3
>    easier to review. It's worth noting that qemu-arm sbsa was crashing with
>    the efi services page aligned. This is probably due to a mismatch of
>    memory, since the crash is only reproducible with QEMU instances that
>    have < 2 GB of RAM. I'll fix that along with the efi runtime services
> - Defined memory attribute changes properly with an enum for RW, RO, RX
>    instead of the hardcoded '1,2,3' I had on the RFC
> - Enabling mappings is now under a Kconfig (CONFIG_MMU_PGPROT), since
>    peope reported crashes when testing this, which are orthogonal to this
>    patch. We still have places in U-Boot where we define and later write
>    const variables. This will lead to a crash now as const variables are
>    properly managed and places in RO memory
> - Split patches to be easier to review
> - Added a patch updating 'meminfo'
> - Picked up acked-by tags from Jerome
> 
> patch #1 adds printing capabilities for page mappings in 'meminfo'
> patch #2 adds documention in 'meminfo' command
> patch #3 prepares linker scripts, aligns sections in page boundaries etc
> patch #4 prepares an internal function to change the PTEs
> patch #5 adds function definitions & stubs for all archs
> patch #6 wires up the changes in U-Boot after it relocates
> 
> [0] https://lore.kernel.org/u-boot/20250130072100.27297-1-ilias.apalodimas@linaro.org/
> 
> Ilias Apalodimas (6):
>    meminfo: add memory details for armv8
>    doc: update meminfo with arch specific information
>    arm: Prepare linker scripts for memory permissions
>    arm64: mmu_change_region_attr() add an option not to break PTEs
>    treewide: Add a function to change page permissions
>    arm64: Enable RW, RX and RO mappings for the relocated binary
> 
>   arch/arc/lib/cache.c                    |  2 +
>   arch/arm/cpu/arm926ejs/cache.c          |  2 +
>   arch/arm/cpu/armv7/cache_v7.c           |  1 +
>   arch/arm/cpu/armv7m/cache.c             |  2 +
>   arch/arm/cpu/armv8/cache_v8.c           | 54 +++++++++++++++++--
>   arch/arm/cpu/armv8/fsl-layerscape/cpu.c | 10 ++--
>   arch/arm/cpu/armv8/u-boot.lds           | 29 +++++-----
>   arch/arm/include/asm/armv8/mmu.h        |  2 +
>   arch/arm/include/asm/system.h           | 11 +++-
>   arch/arm/lib/cache.c                    |  2 +
>   arch/arm/mach-snapdragon/board.c        |  2 +-
>   arch/m68k/lib/cache.c                   |  2 +
>   arch/nios2/lib/cache.c                  |  2 +
>   arch/powerpc/lib/cache.c                |  2 +
>   arch/riscv/lib/cache.c                  |  2 +
>   arch/sh/cpu/sh4/cache.c                 |  2 +
>   arch/xtensa/lib/cache.c                 |  2 +
>   cmd/meminfo.c                           |  5 ++
>   common/Kconfig                          | 13 +++++
>   common/board_r.c                        | 20 +++++++
>   doc/usage/cmd/meminfo.rst               | 71 ++++++++++++++++++-------
>   include/asm-generic/sections.h          |  2 +
>   include/cpu_func.h                      | 16 ++++++
>   23 files changed, 215 insertions(+), 41 deletions(-)
> 
> --
> 2.47.2
> 

Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on AML-S905X-CC
Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on AML-S805X-AC
Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on BananaPi-M5
Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on BananaPi-M2S
Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8550-QRD
Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8550-HDK
Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8650-QRD
Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8650-HDK

I ran this patchset on all of those board and ran meminfo to check the permissions,
no issues nor crash observed.

Thanks,
Neil
