Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DD09E77188
	for <u-boot@archiver.kernel.org>; Mon,  6 Jan 2025 09:26:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF9B480137;
	Mon,  6 Jan 2025 10:26:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yvopZQPN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 03F63801DE; Mon,  6 Jan 2025 10:26:53 +0100 (CET)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3E1608007D
 for <u-boot@lists.denx.de>; Mon,  6 Jan 2025 10:26:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4363dc916ceso87807155e9.0
 for <u-boot@lists.denx.de>; Mon, 06 Jan 2025 01:26:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736155609; x=1736760409; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=3QRuu1Co28eyMa3d+CJMZXkgtqaxChKpUO9bokc5j1I=;
 b=yvopZQPNZDJEO35QdLyKLIwOxCLLLVlA8b7Lekc3i1TELzCz5vUTT2B6hW+lHuwr1q
 uofquVgXKGOrRfhsw07oOfgs7mL8IKfW0toTpeyF+HUQW2n1zizApkyTPBETBkmtTUxs
 lGCzacFCpnqHHYq/MsKqu/ygkzxHBJ5gUHhgVTpW02thbwmGKwcB2m1dF7VRau6XG+1O
 4xH8MPs0UlQW8m3a0ozQYcotVWEOqE3Y6AD3Luo2TUOgZjFjLKbyZ/6L6Z7YlSuLIih9
 YP18591fNyfOYDPZfQlIxyo1kJafVpOlkAi2V7zbwdzoOCBGmzTXEuDT3DVDboioz85X
 7BGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736155609; x=1736760409;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=3QRuu1Co28eyMa3d+CJMZXkgtqaxChKpUO9bokc5j1I=;
 b=csVBiAgfdVDMPFDBh1xpPja9vCNgCqzK2KMVAiAftdAdpItFLb5PXvpDNWi/BcYbzx
 uea4rt/FX8HXDGLq8k7hekv7iOZPJ/TRmErlbP7m2b4VbBfMr+bP5EW3OSGamBc+N96i
 iq5Q28F4FeWSYCQ+geMpfA717/Lpmr7lmtTHg9Ip6QLlHtgIcNKbbDsftP8u67vhZk7d
 PdKnYc/fZ5+hJ6PL5NB4PjIUarB7kxPvZxhWsBYEhspPBhCbaTPJdEo9uDUSMdSbJWTR
 GDTAEs6ngrw2cS/vSVZI91cTprEim397+lvFJ4dwUm1102/C2XBbzEdkpfZi6pBCmZR/
 +Y+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXmhwgUJtxNGiphLBtuLdCKJEeaR33fmg9FYstcEzJbx3Zz74bF/z9Enhg7so1RryalqT/SASY=@lists.denx.de
X-Gm-Message-State: AOJu0YzAdt+TSGEGBqupThi0IcaDnKsBh48nzz/RNtbC5cNnSf05KNIM
 p1quScdToWrQUFRf9FTd61k75TO8soVYcwhPumjPZmSIJ80fR7XFlayVtrZ2WD0=
X-Gm-Gg: ASbGncv7bqbZEg2VIz0xir45gq+Vj6ybJalLO5b9tI8wQgj48K/wAajxG+PetXmVD8F
 O9B5pz6xnFJEetsJHueuU1NbSgvD6O93UzLR5W75JF5bQvTtmgg+1Boc7Z5MQAI1O79QFTc7TUe
 LlVOEh0bdn1Nqe2NKC/2PptEkRMViRZ1Qoq6UEhT2LfPW0DrYgvy4zP5x/WnwIXezu7tEWcz7rT
 +P9ND6PiBJ2juL+u20wIFOgf77BdIbHHc2X5laIY1V2imymw0J0cKNkWvd0uJTSqInB0doi3PPJ
 QGikTlOFnsku71LWIfmzJOx3P1yg
X-Google-Smtp-Source: AGHT+IEZ9azMaRxbxr8BdVCdWyEqnRP8BUMhgcyISSuzXMb2mcYaRlD4MxC9r+XRmr/OzIq8vKSSog==
X-Received: by 2002:a05:6000:1785:b0:386:3c93:70ff with SMTP id
 ffacd0b85a97d-38a1a1fdd35mr51711326f8f.8.1736155609360; 
 Mon, 06 Jan 2025 01:26:49 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:95:e905:1421:811c?
 ([2a01:e0a:982:cbb0:95:e905:1421:811c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43656b3b1f6sm602698535e9.31.2025.01.06.01.26.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jan 2025 01:26:48 -0800 (PST)
Message-ID: <6491e671-62b9-45ec-ad28-c7c0d55bc427@linaro.org>
Date: Mon, 6 Jan 2025 10:26:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH 2/2] tools: amlimage: Add support for GXBB eMMC header
To: Ferass El Hafidi <funderscore@postmarketos.org>,
 Jonas Karlman <jonas@kwiboo.se>, Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot-amlogic@groups.io,
 u-boot@lists.denx.de
References: <20250103215904.2590769-1-jonas@kwiboo.se>
 <20250103215904.2590769-3-jonas@kwiboo.se>
 <CAFLszTgehJLKF+ty4jig=JGpb9Z2rBu50+8_KcrX4ZzM4bD-Cw@mail.gmail.com>
 <754d7695-f184-4096-980e-90df66fb2b87@kwiboo.se>
 <D6U2EP1PJ78I.1N5VAOTOWIPZY@postmarketos.org>
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
In-Reply-To: <D6U2EP1PJ78I.1N5VAOTOWIPZY@postmarketos.org>
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

On 05/01/2025 11:24, Ferass El Hafidi wrote:
> Hi Jonas and Simon,
> 
> On Sat Jan 4, 2025 at 10:23 PM UTC, Jonas Karlman wrote:
>> Hi Simon,
>>
>> On 2025-01-04 20:31, Simon Glass wrote:
>>> Hi Jonas,
>>>
>>> On Sat, 4 Jan 2025 at 10:59, Jonas Karlman <jonas@kwiboo.se> wrote:
>>>>
>>>> GXBB BL1 only tries to read boot image from sector 0 on eMMC and sector
>>>> 1 on SD-card. GXL and newer read boot image from sector 1 on both eMMC
>>>> and SD-card.
>>>>
>>>> Vendor BL2 have solved the issue with different offsets by considering
>>>> where BL2 was loaded from to adjust the offset where BL3 is read from.
>>>>
>>>> This provide a different solution to create a boot image that can be
>>>> booted from both eMMC and SD-card and where the offset for reading next
>>>> stage loader can be shared for both boot options.
>>>>
>>>> Inject code, that relocate the payload located at 0x1200 offset in TZRAM
>>>> to the expected offset of 0x1000, into the padding area at offset 0x200
>>>> when a normal GXBB boot image is created. A special GXBB eMMC header can
>>>> then be created that have the payload offset point to this relocate
>>>> code, BL1 will jump to this relocate code when booted from eMMC instead
>>>> of the normal payload start. One effect of this is that the payload size
>>>> limit must be reduced by 512 bytes on GXBB.
>>>>
>>>> Example of how to use it:
>>>>    # Create a normal boot image
>>>>    tools/mkimage -T amlimage -n gxbb -d u-boot-spl.bin bl2.bin
>>>>
>>>>    # Create a boot image with a special eMMC header
>>>>    tools/mkimage -T amlimage -n emmc -d bl2.bin bl2-emmc.bin
>>>>
>>>>    # Write normal boot image to sector 1 of eMMC/SD-card
>>>>    dd if=bl2.bin of=/path/to/dev bs=512 seek=1
>>>>
>>>>    # Write eMMC header, 112 bytes, to start of eMMC
>>>>    dd if=bl2-emmc.bin of=/path/to/dev bs=1 count=112
>>>>
>>>> Or with binman using something like:
>>>>    binman {
>>>>          multiple-images;
>>>>
>>>>          u-boot-gxbb-sd {
>>>>                  filename = "u-boot-gxbb-sd.bin";
>>>>                  pad-byte = <0xff>;
>>>>
>>>>                  mkimage {
>>>>                          filename = "bl2.bin";
>>>>                          args = "-n", "gxbb", "-T", "amlimage";
>>>>
>>>>                          u-boot-spl {
>>>>                          };
>>>>                  };
>>>>          };
>>>>
>>>>          u-boot-gxbb-emmc {
>>>>                  filename = "u-boot-gxbb-emmc.bin";
>>>>                  pad-byte = <0xff>;
>>>>
>>>>                  mkimage {
>>>>                          filename = "bl2-emmc.bin";
>>>>                          args = "-n", "emmc", "-T", "amlimage";
>>>>
>>>>                          blob-ext {
>>>>                                  filename = "bl2.bin";
>>>>                          }
>>>>                  };
>>>>          };
>>>>    };
>>>>
>>>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>>>> ---
>>>>   tools/amlimage-gxbb-relocate.c | 79 ++++++++++++++++++++++++++++++++++
>>>>   tools/amlimage.c               | 37 ++++++++++++++++
>>>>   2 files changed, 116 insertions(+)
>>>>   create mode 100644 tools/amlimage-gxbb-relocate.c
>>>>
>>>
>>> I sent [1] some years ago and would quite like to enable the odroid-c2
>>> in my lab. Is that an older version of what you are supporting here?
>>
>> The amlimage type in this series is only for creating an image format
>> that the SoCs BootROM (BL1) can understand. This image type will most
>> likely only be useful together with Ferass El Hafidi's U-Boot SPL work
>> or for someone wanting to run bare metal code from SRAM on these SoCs.
> 
> I'm happy to announce that U-Boot SPL can now boot on gxbb and gxl SoCs,
> and I'll be sending some patches to upstream that work later on.

\o/

> 
>>
>> Vendor bl2.bin blobs is based on TF-A, is already in correct image
>> format and expect next stage payload to be signed using a Amlogic FIP
>> format. For this you will still need to use vendor tools or open source
>> tools like meson-tools, gxlimg or meson64-tools.
>>
>> The amlogic-boot-fip repo [2] has blobs, vendor tools and Makefiles to
>> combine the blobs with a U-Boot proper u-boot.bin to create a firmware
>> image that should boot for a wide range of boards.
>>
>> [2] https://github.com/LibreELEC/amlogic-boot-fip
>>
>>>
>>> I heard that there are people working on open source tools, but it has
>>> been a few years and I'd be quite OK to just use vendor tools.
>>
>> Open-source tools exist to replace the binary-only Amlogic tools:
>> - https://github.com/afaerber/meson-tools (GXBB, GXL & GXM only)
>> - https://github.com/repk/gxlimg (GXBB, GXL, GXM & AXG only)
>> - https://github.com/angerman/meson64-tools (developed for G12B, should work on G12A & SM1)
> 
> gxlimg now also supports G12A/G12B, but it does not support GXBB at the
> time of writing.

Exact :-)

GXBB is radically different, it was heavily based on the TF-A FIP architecture,
then Amlogic switched to custom headers for GXL and followings.

I would instead support a full SPL boot with associated tooling in U-Boot
source an leave the legacy FIP stuff where it should be, out of tree.

Each board has basically a custom BL2 provided by Amlogic, with sometimes
some custom tools, so supporting this in U-Boot would be an endless pain.

Neil

> 
>>
>> Would be nice if someone would combine those into a mkimage amlfip type
>> or similar (a different format than this amlimage format).
>>
>>>
>>> For your docs, could you put them in doc/ instead?
>>
>> Not fully sure what you want me to put in doc/, please be specific. The
>> code comments and commit message should already document as much as
>> possible until there is upstream use of the GXBB eMMC header workaround.
>>
>> At such time something like following could be documented:
>>
>>    Write image to SD-card or eMMC module:
>>      dd if=u-boot-amlogic.bin of=/path/to/dev bs=512 seek=1 conv=fsync,notrunc
>>
>>    Write the eMMC header to eMMC module:
>>      dd if=u-boot-gxbb-emmc.bin of=/path/to/dev bs=1 count=112 conv=fsync,notrunc
>>
>> Until Ferass El Hafidi's U-Boot SPL work has made its way upstream such
>> commands and information would purely be speculative and will be easier
>> to document in a future series.
> 
> Yes, my tree has documentation on how to make use of images generated by
> amlimage.  I believe such documentation should be documented when there
> actually is U-Boot SPL support as well.
> 
> Best regards.
> 
>>
>> Regards,
>> Jonas
>>
>>>
>>> [..]
>>>
>>> Regards,
>>> Simon
>>>
>>> [1] https://patchwork.ozlabs.org/project/uboot/patch/20211124040954.699821-8-sjg@chromium.org/

