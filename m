Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85B24C54E64
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 08:38:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 133A0880F4;
	Thu, 28 Mar 2024 09:38:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="KkJfelry";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A470880FE; Thu, 28 Mar 2024 09:38:35 +0100 (CET)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D446880BE
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 09:38:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-341cce3e5f0so612127f8f.1
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 01:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711615112; x=1712219912; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=M0I2xWEYlN4DS45LtKc2khRJltrbjzOrU8ViMIJb4KY=;
 b=KkJfelryokE1JTSPHf1zACLntBVjSgrk7MgcZ25OncoiDzqwg0c3SrbGflS/W41mdD
 Ratk8Jef1a/dx0M6zwSjrM2ePRoQTpj4q+9F45Uan5U4wzNopwKgp4dmLSuFeomyFtE3
 f/Cx19DGdZWc+vVb33dwzfp6nfTCpMw94FndRpKb5Tf42rsXe4GVwjoFVqCk0xKM28/Q
 QcDBoipkVB1JMmyJvyqZujhSEMQtIpKmMHWD2KmvlWvBArS4gE6gBf0JSEu2RXxjgV+M
 X15JuHwDKdmez8kiShxVbzTKtrLwRaOmKgodiFfxd3NLNxmsvBtY9EvYxvZ8z58XRBfX
 y/3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711615112; x=1712219912;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=M0I2xWEYlN4DS45LtKc2khRJltrbjzOrU8ViMIJb4KY=;
 b=v2UysGlJglJpt5AUDH6ejz5Q41Mrjfe5695wYSbojHCj8ougc/YQ2LeqHEuDyDlHb8
 5fqjrE2oTvlEMadI5MT2uLJ4Bmcg4LThBqCZW/whXu+HkuNjGta20NxzRx7SDWQqMSub
 BW8ztE3VnFQX+xE5LwZVkyWNJFYjiyIuwLYKISxL1M5AMd2YtgpNJk0/JhuYPqCmSGHw
 karbdxoSO4Ljh7kqfHadcUHMGUbElcTzeLN0dCf8e9Nj2ultUKT9rvBKbq01pMDvTt12
 3CnkdRFaBPq8EvrJE2LTC0qJSlhL2kd7HvughDHdyie/Mr9WVOK+mURwv2y5yXZD2hMY
 d9Ew==
X-Forwarded-Encrypted: i=1;
 AJvYcCXON+AoYXAkirHd/SUtA0E0crP0zik5vb/on6rNyTg9RJyfGhRMDN45JPVIoYQGs+uQ76+XthkDYPsHv7e1PlxUlJ9DZA==
X-Gm-Message-State: AOJu0Yx8dLG35tWABgCDNCxqPCTEzo6cyZ1SAvsWhNFnZoLPH8BTZYR6
 GQLZtidU3M4mzpjUdMReWhbp3h0XVoHIuMHFDNSZpCW3cC9tGSyMnHZVKRievCI=
X-Google-Smtp-Source: AGHT+IHAZggwpPnPwPKP2l+/lEgPePnumwLIz6DlC43P6E90osc55Dq251aMw69ePwAX7gOFzP3EmQ==
X-Received: by 2002:a05:6000:2c7:b0:343:2e09:3597 with SMTP id
 o7-20020a05600002c700b003432e093597mr1137307wry.64.1711615112263; 
 Thu, 28 Mar 2024 01:38:32 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:6306:1c7a:72c2:892a?
 ([2a01:e0a:982:cbb0:6306:1c7a:72c2:892a])
 by smtp.gmail.com with ESMTPSA id
 c3-20020a056000184300b0033e91509224sm1138684wri.22.2024.03.28.01.38.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Mar 2024 01:38:31 -0700 (PDT)
Message-ID: <690e698e-0d1e-4fef-b77c-b1f895455bdb@linaro.org>
Date: Thu, 28 Mar 2024 09:38:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH 0/4] arm: meson: Switch to using upstream DT for GXL, GXM, 
 AXG, G12A, G12B & SM1 SoCs
To: Viacheslav <adeep@lexina.in>
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>,
 Christian Hewitt <christianshewitt@gmail.com>
References: <20240319-u-boot-of-upstream-v1-0-f82bc9fe69c0@linaro.org>
 <045a8bb4-e061-4727-9f07-a55825a99518@linaro.org>
 <3a411122-fefa-4193-b988-ba3b35449946@lexina.in>
 <f8fce939-f095-449f-816e-39a96f8e298f@linaro.org>
 <7dbe9b58-6b5b-4c61-831b-f0fd30736f42@lexina.in>
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
In-Reply-To: <7dbe9b58-6b5b-4c61-831b-f0fd30736f42@lexina.in>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 28/03/2024 09:36, Viacheslav wrote:
> 
> Builds and run ok.
> 
> for related:
> Acked-by: Viacheslav Bocharov <adeep@lexina.in>

Thanks !

I'll send a v2 with this fix and your ack!

Neil

> 
> 28/03/2024 10.50, neil.armstrong@linaro.org wrote:
>> Hi,
>>
>> On 28/03/2024 07:58, Viacheslav wrote:
>>> Hi, Neil!
>>>
>>> With this patchset I got wrong fdt link in env with double prefix:
>>>
>>> fdtfile=amlogic/amlogic/meson-gxl-s905w-jethome-jethub-j80.dtb
>>>
>>>
>>> but if i remove "amlogic" prefix in config it does not build
>>>
>>> --- a/configs/jethub_j80_defconfig
>>> +++ b/configs/jethub_j80_defconfig
>>> -CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-gxl-s905w-jethome-jethub-j80"
>>> +CONFIG_DEFAULT_DEVICE_TREE="meson-gxl-s905w-jethome-jethub-j80"
>>>
>>>
>>> Error:
>>>
>>> make[2]: *** No rule to make target 'dts/upstream/src/arm64/meson-gxl-s905w-jethome-jethub-j80.dtb', needed by 'dtbs'.  Stop.
>>> make[1]: *** [dts/Makefile:54: arch-dtbs] Error 2
>>> make: *** [Makefile:1166: dts/dt.dtb] Error 2
>>
>> You're right, I forgot to remove the fdtfile prefix, can you retry with:
>>
>> =====><===========================================
>> diff --git a/include/configs/meson64.h b/include/configs/meson64.h
>> index efab9a624d..65fa5f3d6d 100644
>> --- a/include/configs/meson64.h
>> +++ b/include/configs/meson64.h
>> @@ -120,6 +120,12 @@
>>
>>   #include <config_distro_bootcmd.h>
>>
>> +#ifdef CONFIG_OF_UPSTREAM
>> +#define FDTFILE_NAME           CONFIG_DEFAULT_DEVICE_TREE ".dtb"
>> +#else
>> +#define FDTFILE_NAME           "amlogic/" CONFIG_DEFAULT_DEVICE_TREE ".dtb"
>> +#endif
>> +
>>   #ifndef CFG_EXTRA_ENV_SETTINGS
>>   #define CFG_EXTRA_ENV_SETTINGS \
>>          "stdin=" STDIN_CFG "\0" \
>> @@ -133,7 +139,7 @@
>>          "pxefile_addr_r=" PXEFILE_ADDR_R "\0" \
>>          "fdtoverlay_addr_r=" FDTOVERLAY_ADDR_R "\0" \
>>          "ramdisk_addr_r=" RAMDISK_ADDR_R "\0" \
>> -       "fdtfile=amlogic/" CONFIG_DEFAULT_DEVICE_TREE ".dtb\0" \
>> +       "fdtfile=" FDTFILE_NAME "\0" \
>>          "dfu_alt_info=fitimage ram " KERNEL_ADDR_R " 0x4000000 \0" \
>>          BOOTENV
>>   #endif
>> =====><===========================================
>>
>> Thanks,
>> Neil
>>
>>>
>>>
>>>
>>> 22/03/2024 12.03, Neil Armstrong:
>>>> Hi Viacheslav,
>>>>
>>>> On 19/03/2024 15:42, Neil Armstrong wrote:
>>>>> Enable OF_UPSTREAM to use upstream DT and add amlogic/ prefix to the
>>>>> DEFAULT_DEVICE_TREE. And thereby directly build DTB from dts/upstream/src/
>>>>> including *-u-boot.dtsi files from arch/$(ARCH)/dts/ directory and
>>>>> drop redundant files from arch/arm/dts directory. Only *-u-boot.dtsi files
>>>>> kept in arch/arm/dts directory for these boards.
>>>>>
>>>>> Keep A1 DTs locally since the architecture is still young.
>>>>>
>>>>> CI built & tested at:
>>>>> https://gitlab.com/amlogic-foss/amlogic-u-boot-autotest/-/pipelines/1219273552
>>>>>
>>>>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>>>>> ---
>>>>> Neil Armstrong (4):
>>>>>        dts: meson: Switch GXL, GXM & AXG to using upstream DT
>>>>>        dts: meson: Drop redundant GXL, GXM & AXG devicetree files
>>>>
>>>> Could you run a test run on your boards so make sure is still boots fine ?
>>>>
>>>> Thanks,
>>>> Neil
>>>>
>>>>>        dts: meson-g12a: Switch to using upstream DT
>>>>>        dts: meson: Drop redundant G12A, G12B & SM1 devicetree files
>>>>>
>>>>>   arch/arm/dts/Makefile                              |   36 +-
>>>>>   arch/arm/dts/meson-axg-jethome-jethub-j100.dts     |  361 ---
>>>>>   arch/arm/dts/meson-axg-s400.dts                    |  602 -----
>>>>>   arch/arm/dts/meson-axg.dtsi                        | 1957 ---------------
>>>>>   arch/arm/dts/meson-g12-common.dtsi                 | 2493 --------------------
>>>>>   arch/arm/dts/meson-g12.dtsi                        |  385 ---
>>>>>   arch/arm/dts/meson-g12a-radxa-zero.dts             |  405 ----
>>>>>   arch/arm/dts/meson-g12a-sei510.dts                 |  566 -----
>>>>>   arch/arm/dts/meson-g12a-u200.dts                   |  308 ---
>>>>>   arch/arm/dts/meson-g12a.dtsi                       |  140 --
>>>>>   arch/arm/dts/meson-g12b-a311d-bananapi-m2s.dts     |   33 -
>>>>>   arch/arm/dts/meson-g12b-a311d-khadas-vim3.dts      |   41 -
>>>>>   arch/arm/dts/meson-g12b-a311d.dtsi                 |  149 --
>>>>>   arch/arm/dts/meson-g12b-bananapi-cm4-cm4io.dts     |  165 --
>>>>>   arch/arm/dts/meson-g12b-bananapi-cm4.dtsi          |  388 ---
>>>>>   arch/arm/dts/meson-g12b-bananapi.dtsi              |  521 ----
>>>>>   arch/arm/dts/meson-g12b-gsking-x.dts               |  133 --
>>>>>   arch/arm/dts/meson-g12b-gtking-pro.dts             |  142 --
>>>>>   arch/arm/dts/meson-g12b-gtking.dts                 |  163 --
>>>>>   arch/arm/dts/meson-g12b-khadas-vim3.dtsi           |  107 -
>>>>>   arch/arm/dts/meson-g12b-odroid-go-ultra.dts        |  722 ------
>>>>>   arch/arm/dts/meson-g12b-odroid-n2-plus.dts         |   31 -
>>>>>   arch/arm/dts/meson-g12b-odroid-n2.dts              |   15 -
>>>>>   arch/arm/dts/meson-g12b-odroid-n2.dtsi             |  303 ---
>>>>>   arch/arm/dts/meson-g12b-odroid-n2l.dts             |  125 -
>>>>>   arch/arm/dts/meson-g12b-odroid.dtsi                |  445 ----
>>>>>   arch/arm/dts/meson-g12b-radxa-zero2.dts            |  489 ----
>>>>>   arch/arm/dts/meson-g12b-s922x-bananapi-m2s.dts     |   14 -
>>>>>   arch/arm/dts/meson-g12b-s922x.dtsi                 |  139 --
>>>>>   arch/arm/dts/meson-g12b-w400.dtsi                  |  425 ----
>>>>>   arch/arm/dts/meson-g12b.dtsi                       |  146 --
>>>>>   arch/arm/dts/meson-gx-libretech-pc.dtsi            |  447 ----
>>>>>   arch/arm/dts/meson-gx-mali450.dtsi                 |   61 -
>>>>>   arch/arm/dts/meson-gx-p23x-q20x.dtsi               |  324 ---
>>>>>   arch/arm/dts/meson-gx.dtsi                         |  675 ------
>>>>>   arch/arm/dts/meson-gxl-mali.dtsi                   |   17 -
>>>>>   arch/arm/dts/meson-gxl-s805x-libretech-ac.dts      |  319 ---
>>>>>   arch/arm/dts/meson-gxl-s805x.dtsi                  |   23 -
>>>>>   arch/arm/dts/meson-gxl-s905d-libretech-pc.dts      |   16 -
>>>>>   arch/arm/dts/meson-gxl-s905d.dtsi                  |   12 -
>>>>>   .../arm/dts/meson-gxl-s905w-jethome-jethub-j80.dts |  247 --
>>>>>   arch/arm/dts/meson-gxl-s905x-khadas-vim.dts        |  237 --
>>>>>   arch/arm/dts/meson-gxl-s905x-libretech-cc-v2.dts   |  313 ---
>>>>>   arch/arm/dts/meson-gxl-s905x-libretech-cc.dts      |  356 ---
>>>>>   arch/arm/dts/meson-gxl-s905x-p212.dts              |  134 --
>>>>>   arch/arm/dts/meson-gxl-s905x-p212.dtsi             |  213 --
>>>>>   arch/arm/dts/meson-gxl-s905x.dtsi                  |   18 -
>>>>>   arch/arm/dts/meson-gxl.dtsi                        |  940 --------
>>>>>   arch/arm/dts/meson-gxm-gt1-ultimate.dts            |   91 -
>>>>>   arch/arm/dts/meson-gxm-khadas-vim2.dts             |  424 ----
>>>>>   arch/arm/dts/meson-gxm-s912-libretech-pc.dts       |   62 -
>>>>>   arch/arm/dts/meson-gxm-wetek-core2.dts             |   85 -
>>>>>   arch/arm/dts/meson-gxm.dtsi                        |  216 --
>>>>>   arch/arm/dts/meson-khadas-vim3.dtsi                |  534 -----
>>>>>   arch/arm/dts/meson-sm1-bananapi-m2-pro.dts         |   97 -
>>>>>   arch/arm/dts/meson-sm1-bananapi-m5.dts             |  221 --
>>>>>   arch/arm/dts/meson-sm1-bananapi.dtsi               |  435 ----
>>>>>   arch/arm/dts/meson-sm1-khadas-vim3l.dts            |  113 -
>>>>>   arch/arm/dts/meson-sm1-odroid-c4.dts               |   48 -
>>>>>   arch/arm/dts/meson-sm1-odroid-hc4.dts              |  140 --
>>>>>   arch/arm/dts/meson-sm1-odroid.dtsi                 |  449 ----
>>>>>   arch/arm/dts/meson-sm1-sei610.dts                  |  616 -----
>>>>>   arch/arm/dts/meson-sm1.dtsi                        |  550 -----
>>>>>   arch/arm/mach-meson/Kconfig                        |    4 +
>>>>>   configs/bananapi-cm4-cm4io_defconfig               |    2 +-
>>>>>   configs/bananapi-m2-pro_defconfig                  |    2 +-
>>>>>   configs/bananapi-m2s_defconfig                     |    2 +-
>>>>>   configs/bananapi-m5_defconfig                      |    2 +-
>>>>>   configs/beelink-gsking-x_defconfig                 |    2 +-
>>>>>   configs/beelink-gt1-ultimate_defconfig             |    2 +-
>>>>>   configs/beelink-gtking_defconfig                   |    2 +-
>>>>>   configs/beelink-gtkingpro_defconfig                |    2 +-
>>>>>   configs/jethub_j100_defconfig                      |    2 +-
>>>>>   configs/jethub_j80_defconfig                       |    2 +-
>>>>>   configs/khadas-vim2_defconfig                      |    2 +-
>>>>>   configs/khadas-vim3_android_ab_defconfig           |    2 +-
>>>>>   configs/khadas-vim3_android_defconfig              |    2 +-
>>>>>   configs/khadas-vim3_defconfig                      |    2 +-
>>>>>   configs/khadas-vim3l_android_ab_defconfig          |    2 +-
>>>>>   configs/khadas-vim3l_android_defconfig             |    2 +-
>>>>>   configs/khadas-vim3l_defconfig                     |    2 +-
>>>>>   configs/khadas-vim_defconfig                       |    2 +-
>>>>>   configs/libretech-ac_defconfig                     |    2 +-
>>>>>   configs/libretech-cc_defconfig                     |    2 +-
>>>>>   configs/libretech-cc_v2_defconfig                  |    2 +-
>>>>>   configs/libretech-s905d-pc_defconfig               |    2 +-
>>>>>   configs/libretech-s912-pc_defconfig                |    2 +-
>>>>>   configs/odroid-c4_defconfig                        |    2 +-
>>>>>   configs/odroid-go-ultra_defconfig                  |    2 +-
>>>>>   configs/odroid-hc4_defconfig                       |    2 +-
>>>>>   configs/odroid-n2_defconfig                        |    2 +-
>>>>>   configs/odroid-n2l_defconfig                       |    2 +-
>>>>>   configs/p212_defconfig                             |    2 +-
>>>>>   configs/radxa-zero2_defconfig                      |    2 +-
>>>>>   configs/radxa-zero_defconfig                       |    2 +-
>>>>>   configs/s400_defconfig                             |    2 +-
>>>>>   configs/sei510_defconfig                           |    2 +-
>>>>>   configs/sei610_defconfig                           |    2 +-
>>>>>   configs/u200_defconfig                             |    2 +-
>>>>>   configs/wetek-core2_defconfig                      |    2 +-
>>>>>   include/dt-bindings/gpio/meson-axg-gpio.h          |  116 -
>>>>>   include/dt-bindings/gpio/meson-g12a-gpio.h         |  114 -
>>>>>   include/dt-bindings/gpio/meson-gxbb-gpio.h         |  148 --
>>>>>   include/dt-bindings/gpio/meson-gxl-gpio.h          |  125 -
>>>>>   include/dt-bindings/power/meson-axg-power.h        |   14 -
>>>>>   include/dt-bindings/power/meson-g12a-power.h       |   13 -
>>>>>   include/dt-bindings/power/meson-gxbb-power.h       |   13 -
>>>>>   include/dt-bindings/power/meson-sm1-power.h        |   18 -
>>>>>   .../reset/amlogic,meson-axg-audio-arb.h            |   19 -
>>>>>   .../dt-bindings/reset/amlogic,meson-axg-reset.h    |  123 -
>>>>>   .../reset/amlogic,meson-g12a-audio-reset.h         |   53 -
>>>>>   .../dt-bindings/reset/amlogic,meson-g12a-reset.h   |  137 --
>>>>>   .../dt-bindings/reset/amlogic,meson-gxbb-reset.h   |  161 --
>>>>>   include/dt-bindings/sound/meson-aiu.h              |   18 -
>>>>>   include/dt-bindings/sound/meson-g12a-toacodec.h    |   10 -
>>>>>   include/dt-bindings/sound/meson-g12a-tohdmitx.h    |   13 -
>>>>>   116 files changed, 42 insertions(+), 21511 deletions(-)
>>>>> ---
>>>>> base-commit: b145877c22b391a4872c875145a8f86f6ffebaba
>>>>> change-id: 20240319-u-boot-of-upstream-46454fded5ea
>>>>>
>>>>> Best regards,
>>>>
>>>
>>> -- 
>>> Best regards,
>>> Viacheslav
>>

