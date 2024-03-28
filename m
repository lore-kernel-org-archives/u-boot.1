Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0ABCC54E64
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 08:37:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDCC8880D6;
	Thu, 28 Mar 2024 09:36:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=lexina.in
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=lexina.in header.i=@lexina.in header.b="Y/iOo1W1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8DBB9880F4; Thu, 28 Mar 2024 09:36:59 +0100 (CET)
Received: from mx.msync.work (mx.msync.work [62.182.159.68])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DABA9880BE
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 09:36:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=lexina.in
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=adeep@lexina.in
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 56E7317913D; Thu, 28 Mar 2024 08:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lexina.in; s=dkim;
 t=1711615015; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references:autocrypt;
 bh=cI9w2dwfw/CwwiHbKzqsE1ygN9Rde29YETYWMdaU/Sk=;
 b=Y/iOo1W1LkgcEd2Tls0MSP5taDXbgry6bNHu0zw/QTTlAEHTN1Ffx7r7Op9QM6ftQ2uRmr
 5iJYhh0+lnRytPehboUgl/NDfTdGCzZRerVI/Qgvznwp2kdYoSK8Xk2RQXULk8zS7Zo/VJ
 EGIUa+9nAYS97a5ji9H8/fIXAfWeMeKxzWWwWUoJmAh0kE8OzyKRfMDJL9mrhDO8EjuDbt
 xA18PJicrv276ftP/9Q4yL5mPNa83mpxTDBhejA2XWuyxcEuTE/H6vsTN96McaAH4cSgH8
 Pf9ptrMmx3fQTfp6WGssSWOXBT+niuCqPgnZq/hwJrMeZ0c9wU83jtOSZzU1AA==
Message-ID: <7dbe9b58-6b5b-4c61-831b-f0fd30736f42@lexina.in>
Date: Thu, 28 Mar 2024 11:36:51 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] arm: meson: Switch to using upstream DT for GXL, GXM, 
 AXG, G12A, G12B & SM1 SoCs
To: neil.armstrong@linaro.org
Cc: u-boot-amlogic@groups.io, u-boot@lists.denx.de,
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>,
 Christian Hewitt <christianshewitt@gmail.com>
References: <20240319-u-boot-of-upstream-v1-0-f82bc9fe69c0@linaro.org>
 <045a8bb4-e061-4727-9f07-a55825a99518@linaro.org>
 <3a411122-fefa-4193-b988-ba3b35449946@lexina.in>
 <f8fce939-f095-449f-816e-39a96f8e298f@linaro.org>
Content-Language: en-US, ru-RU
From: Viacheslav <adeep@lexina.in>
Autocrypt: addr=adeep@lexina.in; keydata=
 xsDNBF+1fsQBDADh4przgt1LU4l+B6rIWel42Mg3hgdgbZ2nlIkKnaaNLXkm5rK0EJJeStd7
 8sxsdk9n7UQFB3mkmgjc89zyAG+CDG/+KZQMWOsc5IvWlDebKlefieyvf9yvV4qcQTeudr3C
 CgUxq8qsp1fDX9jdSjz5/OMJKrxCElMxLxJTFF+FHtWvUIMr4txesE8NP7f7VnIYILEeMM8q
 gvptNUrWQr6KTv4XnRD/BvsRZJWnQ/a5MzMGQWzw7LeT4vhV4lYqJsXmxbGLUOKi+5ZpslR3
 Ffby2kdL1Xyq6Y7Gi70RhUpKP0xGJ6gDVs6SjFSb9UxgrjwNBWZcFeSJkc6pR5JbgbYMRvdA
 W5CNnA8TzdfhPgO3HEDFlsVqberSBI/tMiwHWPze7jkv7ttx/Wg9+RZybFfCkGm4XvKh7aP4
 jG3Td43mqhyHGzOd/EUxNITebqxqpEJTmRCisgpjr3M76aht4UFz11tP/QEuCrpDX0bOMPYA
 4aohmhw5FLyWUPg0JllH6kEAEQEAAc0SIDxhZGVlcEBsZXhpbmEuaW4+wsDwBBMBCgAaBAsJ
 CAcCFQoCFgECGQEFgl+1fsQCngECmwMACgkQ7jaxEAJajfrgvAwA051C6jUKS6Wp4oy2Or0i
 B1HXCDDaCS2zgWDCa+nuI+8qVDzTx0TAlurt+S3AUv8+DHjkc4XjEHtDdigabp2nGsk51w3C
 WyGD7NKUQz8/mpN7Fb2OV79etE3PTMayUrXRZh7ZuvQ7vkUemKM8rRw0PFPu3kqwZPDPapYH
 rPyJZjnNFuvFULli/xIcc8+WklaYgOKg4nmsVBT4NigiV2Y4Mb4yVBWl58mErRH5pv08NYb4
 1JFD2FZnTGhEeumQDl9p6Kd+rZETRgkMEHw+HMwdXl5ZXv5ci4NTigiH77UvfN8FetuAdl3x
 6EM+1bJkgab6TMyWdNPPmF6e5BPHtBduk9gzmU5+xUlTbur0gun662oFi1oWwbAqhBDueDyL
 xCi8qjycOJaehBcPRtksQeTZrp+fDYne7hq3ywMBdlqhdz4Sfm7urLHvA/bApgJKlWylkqkl
 sG82QPh63ZnNw2lORTGEQTO3tBMY5RLKnrvZjtZR7W06pVZXyQQXZceEmpCazsDNBF+1fsQB
 DACy2kiiKt2bTSl4u/z1en+BhP16c/RbjnDXVkbapyZRCf3OmjfpRXprje4Z0+HAHReWgnOc
 sC6vNk+SWimoE/qyXQTNnUDS7KYdFaof14UmU2rA9pf1oXHOgMRzlwinCe+6NCgkjsqOr3e5
 8XNo+cxmQy1bhHt1LDwixBFU6v65umJpZAVUd1F624wU+UeRZCjymMB80ePxF9ppnfcYc+Yp
 aM70LFwDzxCmeLGv0uMb0jfgJ8j2k2LS5nOQ4AX+WoOb98vFuqW7oYA9oCCKDG0Gp/w9QxG5
 RKjMytZIUxQA2JDq0jUN90pK0mtZJn7/Dr8GRM+W+UpeKiK7wW9iTFH+hTIRtbCC8vO8JDGz
 umW65BFtZfH2cEQDU2nbdsf/SstszPDMuyDiCHmxh8MKN/fn55osvJvjXgqpsH48tz9O7262
 P5xK4nMpsWWj7W6OhHGTQTHgMrKsiYoDx9+5NGt8n+MbLO5DUvyOSvfAiE+hRaf97R9vtoSy
 BoyahDXmCH0AEQEAAcLA3wQYAQoACQWCX7V+xAKbDAAKCRDuNrEQAlqN+ra3C/95TV1Fjy//
 t6FvNIgLy0e+5LnTegejiCaGbxklGFIWkGamX/DOm3QF+ZaKsoXUf/kmpL10dnsExiGHTeGw
 7zR8+rOkVnK6fq0ady43a7RxKP5nW0pDVclTvsAWr1CcdFrCVpH2idj7fjtAmZlMbuiEMXoo
 kaDXdhJtS60VrwS4xUlw4ZPQjMZdQdvpu4vGtZUfJr+8vJ757d9N3EGpFUrk+5QWozjktLVm
 gdQ0nlD9ji3RpwjhQWCIoi6GmdWpfdj3LzDO/DwWRLlz8iAdZG3pHSGsCmM2MJ16HbPnsSxr
 YrKwM/HVpqTSVsprnQogPL/xM0AH11uAbqNvIvm6sUkEmx2kdBzTKjY0YdSkpUgTauWn13bg
 Ay+0xfqxRvYBSsHpWpnSnsI12861OVGnYsnB8gJlJLSQjOl3Kwq36MeWbAg6Bs4PnNU4i+uO
 rz9PJ4vHmMYfmMDJLYWJI6pcLyAoZSE/bSTLaRV73/zjtlX85mtEL3fvh6G342uRCvAwqgI=
In-Reply-To: <f8fce939-f095-449f-816e-39a96f8e298f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean


Builds and run ok.

for related:
Acked-by: Viacheslav Bocharov <adeep@lexina.in>

28/03/2024 10.50, neil.armstrong@linaro.org wrote:
> Hi,
> 
> On 28/03/2024 07:58, Viacheslav wrote:
>> Hi, Neil!
>>
>> With this patchset I got wrong fdt link in env with double prefix:
>>
>> fdtfile=amlogic/amlogic/meson-gxl-s905w-jethome-jethub-j80.dtb
>>
>>
>> but if i remove "amlogic" prefix in config it does not build
>>
>> --- a/configs/jethub_j80_defconfig
>> +++ b/configs/jethub_j80_defconfig
>> -CONFIG_DEFAULT_DEVICE_TREE="amlogic/meson-gxl-s905w-jethome-jethub-j80"
>> +CONFIG_DEFAULT_DEVICE_TREE="meson-gxl-s905w-jethome-jethub-j80"
>>
>>
>> Error:
>>
>> make[2]: *** No rule to make target 
>> 'dts/upstream/src/arm64/meson-gxl-s905w-jethome-jethub-j80.dtb', 
>> needed by 'dtbs'.  Stop.
>> make[1]: *** [dts/Makefile:54: arch-dtbs] Error 2
>> make: *** [Makefile:1166: dts/dt.dtb] Error 2
> 
> You're right, I forgot to remove the fdtfile prefix, can you retry with:
> 
> =====><===========================================
> diff --git a/include/configs/meson64.h b/include/configs/meson64.h
> index efab9a624d..65fa5f3d6d 100644
> --- a/include/configs/meson64.h
> +++ b/include/configs/meson64.h
> @@ -120,6 +120,12 @@
> 
>   #include <config_distro_bootcmd.h>
> 
> +#ifdef CONFIG_OF_UPSTREAM
> +#define FDTFILE_NAME           CONFIG_DEFAULT_DEVICE_TREE ".dtb"
> +#else
> +#define FDTFILE_NAME           "amlogic/" CONFIG_DEFAULT_DEVICE_TREE 
> ".dtb"
> +#endif
> +
>   #ifndef CFG_EXTRA_ENV_SETTINGS
>   #define CFG_EXTRA_ENV_SETTINGS \
>          "stdin=" STDIN_CFG "\0" \
> @@ -133,7 +139,7 @@
>          "pxefile_addr_r=" PXEFILE_ADDR_R "\0" \
>          "fdtoverlay_addr_r=" FDTOVERLAY_ADDR_R "\0" \
>          "ramdisk_addr_r=" RAMDISK_ADDR_R "\0" \
> -       "fdtfile=amlogic/" CONFIG_DEFAULT_DEVICE_TREE ".dtb\0" \
> +       "fdtfile=" FDTFILE_NAME "\0" \
>          "dfu_alt_info=fitimage ram " KERNEL_ADDR_R " 0x4000000 \0" \
>          BOOTENV
>   #endif
> =====><===========================================
> 
> Thanks,
> Neil
> 
>>
>>
>>
>> 22/03/2024 12.03, Neil Armstrong:
>>> Hi Viacheslav,
>>>
>>> On 19/03/2024 15:42, Neil Armstrong wrote:
>>>> Enable OF_UPSTREAM to use upstream DT and add amlogic/ prefix to the
>>>> DEFAULT_DEVICE_TREE. And thereby directly build DTB from 
>>>> dts/upstream/src/
>>>> including *-u-boot.dtsi files from arch/$(ARCH)/dts/ directory and
>>>> drop redundant files from arch/arm/dts directory. Only *-u-boot.dtsi 
>>>> files
>>>> kept in arch/arm/dts directory for these boards.
>>>>
>>>> Keep A1 DTs locally since the architecture is still young.
>>>>
>>>> CI built & tested at:
>>>> https://gitlab.com/amlogic-foss/amlogic-u-boot-autotest/-/pipelines/1219273552
>>>>
>>>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>>>> ---
>>>> Neil Armstrong (4):
>>>>        dts: meson: Switch GXL, GXM & AXG to using upstream DT
>>>>        dts: meson: Drop redundant GXL, GXM & AXG devicetree files
>>>
>>> Could you run a test run on your boards so make sure is still boots 
>>> fine ?
>>>
>>> Thanks,
>>> Neil
>>>
>>>>        dts: meson-g12a: Switch to using upstream DT
>>>>        dts: meson: Drop redundant G12A, G12B & SM1 devicetree files
>>>>
>>>>   arch/arm/dts/Makefile                              |   36 +-
>>>>   arch/arm/dts/meson-axg-jethome-jethub-j100.dts     |  361 ---
>>>>   arch/arm/dts/meson-axg-s400.dts                    |  602 -----
>>>>   arch/arm/dts/meson-axg.dtsi                        | 1957 
>>>> ---------------
>>>>   arch/arm/dts/meson-g12-common.dtsi                 | 2493 
>>>> --------------------
>>>>   arch/arm/dts/meson-g12.dtsi                        |  385 ---
>>>>   arch/arm/dts/meson-g12a-radxa-zero.dts             |  405 ----
>>>>   arch/arm/dts/meson-g12a-sei510.dts                 |  566 -----
>>>>   arch/arm/dts/meson-g12a-u200.dts                   |  308 ---
>>>>   arch/arm/dts/meson-g12a.dtsi                       |  140 --
>>>>   arch/arm/dts/meson-g12b-a311d-bananapi-m2s.dts     |   33 -
>>>>   arch/arm/dts/meson-g12b-a311d-khadas-vim3.dts      |   41 -
>>>>   arch/arm/dts/meson-g12b-a311d.dtsi                 |  149 --
>>>>   arch/arm/dts/meson-g12b-bananapi-cm4-cm4io.dts     |  165 --
>>>>   arch/arm/dts/meson-g12b-bananapi-cm4.dtsi          |  388 ---
>>>>   arch/arm/dts/meson-g12b-bananapi.dtsi              |  521 ----
>>>>   arch/arm/dts/meson-g12b-gsking-x.dts               |  133 --
>>>>   arch/arm/dts/meson-g12b-gtking-pro.dts             |  142 --
>>>>   arch/arm/dts/meson-g12b-gtking.dts                 |  163 --
>>>>   arch/arm/dts/meson-g12b-khadas-vim3.dtsi           |  107 -
>>>>   arch/arm/dts/meson-g12b-odroid-go-ultra.dts        |  722 ------
>>>>   arch/arm/dts/meson-g12b-odroid-n2-plus.dts         |   31 -
>>>>   arch/arm/dts/meson-g12b-odroid-n2.dts              |   15 -
>>>>   arch/arm/dts/meson-g12b-odroid-n2.dtsi             |  303 ---
>>>>   arch/arm/dts/meson-g12b-odroid-n2l.dts             |  125 -
>>>>   arch/arm/dts/meson-g12b-odroid.dtsi                |  445 ----
>>>>   arch/arm/dts/meson-g12b-radxa-zero2.dts            |  489 ----
>>>>   arch/arm/dts/meson-g12b-s922x-bananapi-m2s.dts     |   14 -
>>>>   arch/arm/dts/meson-g12b-s922x.dtsi                 |  139 --
>>>>   arch/arm/dts/meson-g12b-w400.dtsi                  |  425 ----
>>>>   arch/arm/dts/meson-g12b.dtsi                       |  146 --
>>>>   arch/arm/dts/meson-gx-libretech-pc.dtsi            |  447 ----
>>>>   arch/arm/dts/meson-gx-mali450.dtsi                 |   61 -
>>>>   arch/arm/dts/meson-gx-p23x-q20x.dtsi               |  324 ---
>>>>   arch/arm/dts/meson-gx.dtsi                         |  675 ------
>>>>   arch/arm/dts/meson-gxl-mali.dtsi                   |   17 -
>>>>   arch/arm/dts/meson-gxl-s805x-libretech-ac.dts      |  319 ---
>>>>   arch/arm/dts/meson-gxl-s805x.dtsi                  |   23 -
>>>>   arch/arm/dts/meson-gxl-s905d-libretech-pc.dts      |   16 -
>>>>   arch/arm/dts/meson-gxl-s905d.dtsi                  |   12 -
>>>>   .../arm/dts/meson-gxl-s905w-jethome-jethub-j80.dts |  247 --
>>>>   arch/arm/dts/meson-gxl-s905x-khadas-vim.dts        |  237 --
>>>>   arch/arm/dts/meson-gxl-s905x-libretech-cc-v2.dts   |  313 ---
>>>>   arch/arm/dts/meson-gxl-s905x-libretech-cc.dts      |  356 ---
>>>>   arch/arm/dts/meson-gxl-s905x-p212.dts              |  134 --
>>>>   arch/arm/dts/meson-gxl-s905x-p212.dtsi             |  213 --
>>>>   arch/arm/dts/meson-gxl-s905x.dtsi                  |   18 -
>>>>   arch/arm/dts/meson-gxl.dtsi                        |  940 --------
>>>>   arch/arm/dts/meson-gxm-gt1-ultimate.dts            |   91 -
>>>>   arch/arm/dts/meson-gxm-khadas-vim2.dts             |  424 ----
>>>>   arch/arm/dts/meson-gxm-s912-libretech-pc.dts       |   62 -
>>>>   arch/arm/dts/meson-gxm-wetek-core2.dts             |   85 -
>>>>   arch/arm/dts/meson-gxm.dtsi                        |  216 --
>>>>   arch/arm/dts/meson-khadas-vim3.dtsi                |  534 -----
>>>>   arch/arm/dts/meson-sm1-bananapi-m2-pro.dts         |   97 -
>>>>   arch/arm/dts/meson-sm1-bananapi-m5.dts             |  221 --
>>>>   arch/arm/dts/meson-sm1-bananapi.dtsi               |  435 ----
>>>>   arch/arm/dts/meson-sm1-khadas-vim3l.dts            |  113 -
>>>>   arch/arm/dts/meson-sm1-odroid-c4.dts               |   48 -
>>>>   arch/arm/dts/meson-sm1-odroid-hc4.dts              |  140 --
>>>>   arch/arm/dts/meson-sm1-odroid.dtsi                 |  449 ----
>>>>   arch/arm/dts/meson-sm1-sei610.dts                  |  616 -----
>>>>   arch/arm/dts/meson-sm1.dtsi                        |  550 -----
>>>>   arch/arm/mach-meson/Kconfig                        |    4 +
>>>>   configs/bananapi-cm4-cm4io_defconfig               |    2 +-
>>>>   configs/bananapi-m2-pro_defconfig                  |    2 +-
>>>>   configs/bananapi-m2s_defconfig                     |    2 +-
>>>>   configs/bananapi-m5_defconfig                      |    2 +-
>>>>   configs/beelink-gsking-x_defconfig                 |    2 +-
>>>>   configs/beelink-gt1-ultimate_defconfig             |    2 +-
>>>>   configs/beelink-gtking_defconfig                   |    2 +-
>>>>   configs/beelink-gtkingpro_defconfig                |    2 +-
>>>>   configs/jethub_j100_defconfig                      |    2 +-
>>>>   configs/jethub_j80_defconfig                       |    2 +-
>>>>   configs/khadas-vim2_defconfig                      |    2 +-
>>>>   configs/khadas-vim3_android_ab_defconfig           |    2 +-
>>>>   configs/khadas-vim3_android_defconfig              |    2 +-
>>>>   configs/khadas-vim3_defconfig                      |    2 +-
>>>>   configs/khadas-vim3l_android_ab_defconfig          |    2 +-
>>>>   configs/khadas-vim3l_android_defconfig             |    2 +-
>>>>   configs/khadas-vim3l_defconfig                     |    2 +-
>>>>   configs/khadas-vim_defconfig                       |    2 +-
>>>>   configs/libretech-ac_defconfig                     |    2 +-
>>>>   configs/libretech-cc_defconfig                     |    2 +-
>>>>   configs/libretech-cc_v2_defconfig                  |    2 +-
>>>>   configs/libretech-s905d-pc_defconfig               |    2 +-
>>>>   configs/libretech-s912-pc_defconfig                |    2 +-
>>>>   configs/odroid-c4_defconfig                        |    2 +-
>>>>   configs/odroid-go-ultra_defconfig                  |    2 +-
>>>>   configs/odroid-hc4_defconfig                       |    2 +-
>>>>   configs/odroid-n2_defconfig                        |    2 +-
>>>>   configs/odroid-n2l_defconfig                       |    2 +-
>>>>   configs/p212_defconfig                             |    2 +-
>>>>   configs/radxa-zero2_defconfig                      |    2 +-
>>>>   configs/radxa-zero_defconfig                       |    2 +-
>>>>   configs/s400_defconfig                             |    2 +-
>>>>   configs/sei510_defconfig                           |    2 +-
>>>>   configs/sei610_defconfig                           |    2 +-
>>>>   configs/u200_defconfig                             |    2 +-
>>>>   configs/wetek-core2_defconfig                      |    2 +-
>>>>   include/dt-bindings/gpio/meson-axg-gpio.h          |  116 -
>>>>   include/dt-bindings/gpio/meson-g12a-gpio.h         |  114 -
>>>>   include/dt-bindings/gpio/meson-gxbb-gpio.h         |  148 --
>>>>   include/dt-bindings/gpio/meson-gxl-gpio.h          |  125 -
>>>>   include/dt-bindings/power/meson-axg-power.h        |   14 -
>>>>   include/dt-bindings/power/meson-g12a-power.h       |   13 -
>>>>   include/dt-bindings/power/meson-gxbb-power.h       |   13 -
>>>>   include/dt-bindings/power/meson-sm1-power.h        |   18 -
>>>>   .../reset/amlogic,meson-axg-audio-arb.h            |   19 -
>>>>   .../dt-bindings/reset/amlogic,meson-axg-reset.h    |  123 -
>>>>   .../reset/amlogic,meson-g12a-audio-reset.h         |   53 -
>>>>   .../dt-bindings/reset/amlogic,meson-g12a-reset.h   |  137 --
>>>>   .../dt-bindings/reset/amlogic,meson-gxbb-reset.h   |  161 --
>>>>   include/dt-bindings/sound/meson-aiu.h              |   18 -
>>>>   include/dt-bindings/sound/meson-g12a-toacodec.h    |   10 -
>>>>   include/dt-bindings/sound/meson-g12a-tohdmitx.h    |   13 -
>>>>   116 files changed, 42 insertions(+), 21511 deletions(-)
>>>> ---
>>>> base-commit: b145877c22b391a4872c875145a8f86f6ffebaba
>>>> change-id: 20240319-u-boot-of-upstream-46454fded5ea
>>>>
>>>> Best regards,
>>>
>>
>> -- 
>> Best regards,
>> Viacheslav
> 
