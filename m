Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE79AC369C2
	for <u-boot@archiver.kernel.org>; Mon,  5 May 2025 07:08:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E35280BAE;
	Mon,  5 May 2025 09:08:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ao00efUP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC3B781F66; Mon,  5 May 2025 09:08:24 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 439308091A
 for <u-boot@lists.denx.de>; Mon,  5 May 2025 09:08:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5e5e22e6ed2so6275725a12.3
 for <u-boot@lists.denx.de>; Mon, 05 May 2025 00:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746428902; x=1747033702; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=EefcPi43hdpDoteS2dFOOBuEtx4kNp0ytu2AhtyOYSA=;
 b=ao00efUPqIbESs/EFnUHAIQ6JJI0z+dfmrzOsszd4S27As23SRgFbTbatVUlIeTKq/
 VKoHve9aCwjQ55iXSgyNTcTRcV62gWrVSsoz7Vb+bacCDrAUnT8dfVS5Lj28GiQDJsv+
 jkJck0fm620xSvaTwrCeP03jYXAUsONjk/TbroWI6ZIwuRn9wx3AKtfnJp1+th2TStrT
 sQRGuI+4P7V9xB/WTsGr0Fnz/q9QPIQsrOUipcfbWRRbEjRQzERR1GqYuACU8f2Q93UP
 e9GcRC6q0RdIsMP5xI1DmT7SvlKTBajvIfDYm3vAkDstayrENNgttLyuGOb9JJyeUBJ/
 LwWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746428902; x=1747033702;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:references:cc:to:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=EefcPi43hdpDoteS2dFOOBuEtx4kNp0ytu2AhtyOYSA=;
 b=Wc2qQuZr+HLr3h9dmecw9OLQuhys0TTmTjC4ffEgIuU0/z0y6W6IaBVZKHfDDKgpge
 Lei5sIM4ND+YMnNQVzHpGutw8Q2BHUx6AuGZs9IfOb4OyBKGeN8hi0ODd4YhrZhI7Uyb
 sCXRu2z7kmXERnbLAGUenSI8Z7FOr4+WfV+TP1hK93ek3JNxulfFtsr3OdStGyvgCU+u
 iqCWCsBpmP3Joz/tmwZ4ReNptHL1clxJwN+nLBAmDIPPdiubZXxYZa9G4LndvTaF5+y6
 RzoCA2A9u5aQIsUGQr8nJC/Ocb69arEhH9Q7vQu3wpapdfgFM8Hq+H7kl78V3NFwFtHh
 QhDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQjeGUEKbqM81p/bDQp7SUZwbcirEKXHNzPUjKMclyaN0ONu+uaLHPlyAiGGFecZg1GSYHXTk=@lists.denx.de
X-Gm-Message-State: AOJu0Yz+yAJrcC7NyrpVSFyRbT+UvR7Fn0b7MzysbbJV9fPI8QilBn+A
 o/gEUgiiSbUtKpmzeeYq3rdtuMqYNKZwvqXPbQSYdxuoX/yjbBA4HER+K1JyUm2Jwff803Nf7hM
 2
X-Gm-Gg: ASbGnculVaT90goo7truqRVlp4AbEhlA5QuSUEZqB54a2M9PU8k5vzqv1qRZz+1O/Zy
 QAp8L3MW9Z9S8OpUNpl2hCup+cubMNAIb/4S0eDiq8LlyBn2L4gXt56s6xTcdzlqAz8htk5+gcI
 Lf4iKaccXKIHM0Sxop4meHh/mZ6C90LYkSl1GCQWwVRRHOYWIkmEqD0gLAIlZkTaJeI9Bc3PG14
 ZKgc1jx2sFYxRY1rP441/zlinMt4vyCLc0vGK9LWHS8UFKGQLO5maqyPGV5SOh7V5gZYgGPgsGC
 0Zcb3ZHMfb3E/CvGRUZYKwgdWDIMMglzhfDcKp1+voIDX49EwIFcIhLMf+16jy+6VmmOsXptyNS
 xnM91TN2aqx9WAwf25g==
X-Google-Smtp-Source: AGHT+IEH/V3EEKCga5kIICirD7LntmkTpxW1xn89E6tdDVz0HicuB0K8YzawYKAFnlMbadwFlcuCKw==
X-Received: by 2002:a05:6000:1867:b0:3a0:8325:8090 with SMTP id
 ffacd0b85a97d-3a09fd7614bmr3860495f8f.18.1746428453436; 
 Mon, 05 May 2025 00:00:53 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3d9:2080:88d3:1ad7:3ae1:56e3?
 ([2a01:e0a:3d9:2080:88d3:1ad7:3ae1:56e3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a099ae79d8sm9261286f8f.42.2025.05.05.00.00.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 May 2025 00:00:52 -0700 (PDT)
Message-ID: <0e3e24ac-a4a2-4b44-8c13-d47a655ce7ee@linaro.org>
Date: Mon, 5 May 2025 09:00:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH 0/3] RFC: test: Bring in the test hooks
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>
References: <20250502025026.4140184-1-sjg@chromium.org>
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
In-Reply-To: <20250502025026.4140184-1-sjg@chromium.org>
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

On 02/05/2025 04:50, Simon Glass wrote:
> During a recent discussion with Heinrich we discussed why the hooks are
> kept in a separate repo.
> 
> The amount of code is small, a tenth of the size of the recently added
> lwip, just by way of example. Testing is a critical part of U-Boot and
> one of the things that distinguishes it from firmware projects that have
> not kept up in this area. By having the tests somewhere else, we are
> signalling that it is unusual, or difficult, or optional.
> 
> The hooks mechanism also needs something of an update to take account of
> real boards in 2025. That will be much easier to undertake if the code
> that test/py talks to is in the same repo.
> 
> This series brings the hook files in as first-class citizens of U-Boot.

So this will definitely remove the ability to have test hooks out of the
U-boot tree ? This is a major regression, and I do not want my test hooks
to be in the main u-boot tree for plenty of reasons, the main reasons is
that I need flexibility to handle my lab boards and I can't wait multiple
weeks to have the hooks fixed in the main tree.

This could be enhanced, but I agree with Tom, it's a bad idea to merge
them in the main tree.

Neil

> 
> If we do go ahead with this, I will send a different series which has
> separate commits (with correct author) in the u-boot-test-hooks repo.
> 
> 
> Simon Glass (3):
>    test: Bring in the test hooks
>    doc: Tidy up the hooks documentation
>    CI: Update to use the hooks in the U-Boot repo
> 
>   .azure-pipelines.yml                          |  15 +-
>   .gitlab-ci.yml                                |  16 +-
>   doc/develop/index.rst                         |   1 +
>   doc/develop/py_testing.rst                    |  22 +-
>   doc/develop/test_hooks.rst                    | 306 ++++++++++++++++++
>   test/hooks/bin/OLI01/conf.mx6qsabrelite_na    |  26 ++
>   .../conf.integratorcp_cm926ejs_qemu           |  27 ++
>   test/hooks/bin/bill-the-cat/conf.qemu_mips_na |  28 ++
>   .../bill-the-cat/conf.vexpress_ca15_tc2_qemu  |  27 ++
>   .../bin/common-config.cros-servo-dut-control  |  69 ++++
>   test/hooks/bin/common.labgrid-trini           |  35 ++
>   test/hooks/bin/console.fvp                    |  28 ++
>   test/hooks/bin/console.labgrid-sjg            |  42 +++
>   test/hooks/bin/console.labgrid-trini          |  24 ++
>   test/hooks/bin/console.picocom                |  42 +++
>   test/hooks/bin/console.qemu                   |  35 ++
>   test/hooks/bin/download.imx_usb               |  23 ++
>   test/hooks/bin/download.l4t-exec-uboot        |  25 ++
>   test/hooks/bin/download.tegra-uboot-flasher   |  24 ++
>   test/hooks/bin/ellesmere/common-labgrid-sjg   |  46 +++
>   test/hooks/bin/ellesmere/conf.all             |  24 ++
>   .../hooks/bin/ellesmere/conf.evb-ast2500_qemu |  11 +
>   test/hooks/bin/ellesmere/conf.qemu-riscv32_na |   1 +
>   .../bin/ellesmere/conf.qemu-riscv32_spl_na    |   1 +
>   test/hooks/bin/ellesmere/conf.qemu-riscv64_na |   1 +
>   test/hooks/bin/ellesmere/conf.qemu-x86_64_na  |   1 +
>   test/hooks/bin/ellesmere/conf.qemu-x86_na     |   1 +
>   test/hooks/bin/ellesmere/conf.qemu_arm64_na   |   1 +
>   .../bin/ellesmere/conf.qemu_arm64_spl_na      |   1 +
>   test/hooks/bin/ellesmere/conf.qemu_arm_na     |   1 +
>   test/hooks/bin/ellesmere/conf.qemu_arm_spl_na |   1 +
>   test/hooks/bin/flash.em100                    |  30 ++
>   test/hooks/bin/flash.fiptool                  |  22 ++
>   test/hooks/bin/flash.flashair                 |  45 +++
>   test/hooks/bin/flash.labgrid-trini.sd-mux     |  31 ++
>   test/hooks/bin/flash.none                     |  21 ++
>   test/hooks/bin/flash.qemu_gen_padded_image    |  15 +
>   test/hooks/bin/flash.recovery_l4t             |  44 +++
>   test/hooks/bin/flash.sdwire_common_mount      |  80 +++++
>   .../bin/flash.sdwire_digital-loggers_raw      |  41 +++
>   test/hooks/bin/flash.sdwire_poweroff_mount    |  32 ++
>   test/hooks/bin/flash.sdwire_poweroff_raw      |  42 +++
>   test/hooks/bin/flash.sdwire_relay_mount       |  34 ++
>   test/hooks/bin/flashair.rpi                   |  47 +++
>   test/hooks/bin/flashair.ti-omap               |  26 ++
>   test/hooks/bin/getrole.labgrid-sjg            |  34 ++
>   .../kea/conf.Linksprite_pcDuino3_sjg-pcduino3 |  33 ++
>   .../bin/kea/conf.chromebook_link_sjg-link     |  30 ++
>   .../bin/kea/conf.chromebook_samus_sjg-samus   |  30 ++
>   test/hooks/bin/kea/conf.jetson-tk1_sjg-tk1    |  38 +++
>   .../bin/kea/conf.minnowmax_sjg-minnowmax      |  33 ++
>   .../hooks/bin/kea/conf.orangepi_pc_sjg-opi_pc |  35 ++
>   test/hooks/bin/kea/conf.rock2_sjg-rock2       |  33 ++
>   test/hooks/bin/kea/conf.rpi_3_32b_sjg-rpi_3b  |  34 ++
>   test/hooks/bin/kea/conf.rpi_3_sjg-rpi_3b      |  34 ++
>   .../bin/kea/conf.zynq_zybo_sjg-zynq_zybo      |  44 +++
>   .../conf.am62x_beagleplay_a53_na              |  30 ++
>   .../konsulko-labgrid/conf.am64x_evm_a53_na    |  30 ++
>   .../bin/konsulko-labgrid/conf.rpi_4_32b_na    |   1 +
>   test/hooks/bin/konsulko-labgrid/conf.rpi_4_na |   1 +
>   .../bin/konsulko-labgrid/conf.rpi_arm64_na    |  25 ++
>   test/hooks/bin/poweroff.digital-loggers       |  22 ++
>   test/hooks/bin/poweroff.manual                |  21 ++
>   test/hooks/bin/poweroff.none                  |  22 ++
>   test/hooks/bin/poweroff.phidgets              |  37 +++
>   test/hooks/bin/poweroff.pm342                 |  21 ++
>   test/hooks/bin/poweroff.ykush                 |  23 ++
>   test/hooks/bin/poweron.digital-loggers        |  22 ++
>   test/hooks/bin/poweron.manual                 |  21 ++
>   test/hooks/bin/poweron.none                   |  22 ++
>   test/hooks/bin/poweron.phidgets               |  32 ++
>   test/hooks/bin/poweron.pm342                  |  24 ++
>   test/hooks/bin/poweron.ykush                  |  23 ++
>   test/hooks/bin/push-flashair.py               | 118 +++++++
>   test/hooks/bin/qemu.swtpm                     |  23 ++
>   test/hooks/bin/recovery.manual                |  23 ++
>   test/hooks/bin/recovery.phidgets              |  29 ++
>   test/hooks/bin/recovery.pm342                 |  26 ++
>   test/hooks/bin/recovery.relay                 |  39 +++
>   test/hooks/bin/recovery.usbrelay              |  32 ++
>   test/hooks/bin/release.labgrid-sjg            |  22 ++
>   test/hooks/bin/release.none                   |  22 ++
>   test/hooks/bin/reset.cros_servo               |  23 ++
>   test/hooks/bin/reset.digital-loggers          |  25 ++
>   test/hooks/bin/reset.labgrid-trini            |  24 ++
>   test/hooks/bin/reset.none                     |  30 ++
>   test/hooks/bin/reset.pm342                    |  21 ++
>   test/hooks/bin/reset.recovery_download        |  36 +++
>   test/hooks/bin/reset.usbrelay                 |  26 ++
>   test/hooks/bin/reset.ykush                    |  25 ++
>   test/hooks/bin/swarren-lx1/conf.jetson-tk1_na |  36 +++
>   test/hooks/bin/swarren-lx1/conf.p2371-2180_na |  57 ++++
>   .../bin/swarren-lx1/conf.p2771-0000-500_na    |  32 ++
>   test/hooks/bin/travis-ci/conf.M5208EVBE_qemu  |  27 ++
>   test/hooks/bin/travis-ci/conf.coreboot_qemu   |  28 ++
>   .../hooks/bin/travis-ci/conf.evb-ast2500_qemu |  11 +
>   .../hooks/bin/travis-ci/conf.evb-ast2600_qemu |  13 +
>   .../travis-ci/conf.integratorcp_cm926ejs_qemu |  27 ++
>   test/hooks/bin/travis-ci/conf.malta64_qemu    |  30 ++
>   test/hooks/bin/travis-ci/conf.malta64el_qemu  |  31 ++
>   test/hooks/bin/travis-ci/conf.malta_qemu      |  30 ++
>   test/hooks/bin/travis-ci/conf.maltael_qemu    |  31 ++
>   test/hooks/bin/travis-ci/conf.qemu-ae3xx_na   |  27 ++
>   .../hooks/bin/travis-ci/conf.qemu-arm-sbsa_na |  27 ++
>   test/hooks/bin/travis-ci/conf.qemu-ax25_na    |  27 ++
>   .../bin/travis-ci/conf.qemu-loongarch64_na    |  12 +
>   test/hooks/bin/travis-ci/conf.qemu-ppce500_na |  27 ++
>   test/hooks/bin/travis-ci/conf.qemu-riscv32_na |  11 +
>   .../bin/travis-ci/conf.qemu-riscv32_spl_na    |  11 +
>   test/hooks/bin/travis-ci/conf.qemu-riscv64_na |  11 +
>   .../bin/travis-ci/conf.qemu-riscv64_spl_na    |  11 +
>   test/hooks/bin/travis-ci/conf.qemu-x86_64_na  |  27 ++
>   test/hooks/bin/travis-ci/conf.qemu-x86_na     |  27 ++
>   .../bin/travis-ci/conf.qemu-xtensa-dc233c_na  |  12 +
>   test/hooks/bin/travis-ci/conf.qemu_arm64_na   |  30 ++
>   .../bin/travis-ci/conf.qemu_arm64_spl_na      |  32 ++
>   .../bin/travis-ci/conf.qemu_arm64_tpl_na      |  29 ++
>   test/hooks/bin/travis-ci/conf.qemu_arm64be_na |  13 +
>   test/hooks/bin/travis-ci/conf.qemu_arm_na     |  30 ++
>   test/hooks/bin/travis-ci/conf.qemu_arm_spl_na |  31 ++
>   test/hooks/bin/travis-ci/conf.qemu_mips64_na  |  28 ++
>   .../hooks/bin/travis-ci/conf.qemu_mips64el_na |  28 ++
>   test/hooks/bin/travis-ci/conf.qemu_mips_na    |  28 ++
>   test/hooks/bin/travis-ci/conf.qemu_mipsel_na  |  28 ++
>   .../bin/travis-ci/conf.r2dplus_i82557c_qemu   |  27 ++
>   .../bin/travis-ci/conf.r2dplus_pcnet_qemu     |  27 ++
>   .../bin/travis-ci/conf.r2dplus_rtl8139_qemu   |  27 ++
>   .../bin/travis-ci/conf.r2dplus_tulip_qemu     |  27 ++
>   .../conf.sifive_unleashed_sdcard_qemu         |  11 +
>   .../conf.sifive_unleashed_spi-nor_qemu        |  11 +
>   .../bin/travis-ci/conf.vexpress_ca15_tc2_qemu |  27 ++
>   .../bin/travis-ci/conf.vexpress_ca9x4_qemu    |  27 ++
>   .../travis-ci/conf.vexpress_fvp_bloblist_na   |   1 +
>   test/hooks/bin/travis-ci/conf.vexpress_fvp_na |  29 ++
>   .../travis-ci/conf.xilinx_versal_virt_qemu    |  27 ++
>   .../bin/travis-ci/conf.xilinx_zynq_virt_qemu  |  27 ++
>   test/hooks/bin/travis-ci/conf.xtfpga_qemu     |  27 ++
>   test/hooks/bin/travis-ci/conf.zynq_zc702_qemu |  27 ++
>   test/hooks/bin/u-boot-test-common             |  36 +++
>   test/hooks/bin/u-boot-test-console            |  25 ++
>   test/hooks/bin/u-boot-test-flash              |  25 ++
>   test/hooks/bin/u-boot-test-getrole            |  38 +++
>   test/hooks/bin/u-boot-test-power-off          |  25 ++
>   test/hooks/bin/u-boot-test-power-on           |  25 ++
>   test/hooks/bin/u-boot-test-release            |  26 ++
>   test/hooks/bin/u-boot-test-reset              |  25 ++
>   test/hooks/bin/wait_raw_device                |  34 ++
>   test/hooks/bin/writer.imx_raw                 |  39 +++
>   test/hooks/bin/writer.labgrid-trini.rpi       |  46 +++
>   test/hooks/bin/writer.labgrid-trini.ti-k3     |  35 ++
>   test/hooks/bin/writer.rk3288_raw              |  40 +++
>   test/hooks/bin/writer.rpi_mount               |  43 +++
>   test/hooks/bin/writer.sunxi_raw               |  36 +++
>   test/hooks/bin/writer.ti-k3_mount             |  36 +++
>   test/hooks/bin/writer.ti-omap_mount           |  29 ++
>   test/hooks/bin/writer.zynq_mount              |  36 +++
>   test/hooks/contrib/src/.gitignore             |   1 +
>   test/hooks/contrib/src/README.txt             |  13 +
>   test/hooks/contrib/src/build.sh               |   7 +
>   test/hooks/contrib/src/phidgets-relay.c       |  81 +++++
>   .../contrib/udev/swarren-lx1/99-ubtest.rules  |  89 +++++
>   .../OLI01/u_boot_boardenv_mx6qsabrelite_na.py |  39 +++
>   .../konsulko-labgrid/u_boot_boardenv_rpi_4.py |   1 +
>   .../u_boot_boardenv_rpi_arm64.py              |  84 +++++
>   .../u_boot_boardenv_jetson_tk1_na.py          | 110 +++++++
>   .../u_boot_boardenv_p2371_2180_na.py          | 110 +++++++
>   .../u_boot_boardenv_p2771_0000_500_na.py      |  73 +++++
>   test/hooks/py/travis-ci/travis_tftp.py        |  31 ++
>   .../u_boot_boardenv_M5208EVBE_qemu.py         |   6 +
>   .../u_boot_boardenv_evb_ast2500_qemu.py       |   5 +
>   .../u_boot_boardenv_evb_ast2600_qemu.py       |   4 +
>   .../travis-ci/u_boot_boardenv_malta64_qemu.py |   5 +
>   .../u_boot_boardenv_malta64el_qemu.py         |   5 +
>   .../travis-ci/u_boot_boardenv_malta_qemu.py   |   5 +
>   .../travis-ci/u_boot_boardenv_maltael_qemu.py |   5 +
>   .../u_boot_boardenv_qemu_ae3xx_na.py          |   6 +
>   .../u_boot_boardenv_qemu_arm64_na.py          |  12 +
>   .../u_boot_boardenv_qemu_arm64be_na.py        |  10 +
>   .../travis-ci/u_boot_boardenv_qemu_arm_na.py  |  12 +
>   .../travis-ci/u_boot_boardenv_qemu_ax25_na.py |   6 +
>   .../u_boot_boardenv_qemu_loongarch64_na.py    |  11 +
>   .../u_boot_boardenv_qemu_riscv32_na.py        |  10 +
>   .../u_boot_boardenv_qemu_riscv32_spl_na.py    |  10 +
>   .../u_boot_boardenv_qemu_riscv64_na.py        |  10 +
>   .../u_boot_boardenv_qemu_riscv64_spl_na.py    |  10 +
>   .../u_boot_boardenv_qemu_x86_64_na.py         |  12 +
>   .../travis-ci/u_boot_boardenv_qemu_x86_na.py  |  12 +
>   .../u_boot_boardenv_qemu_xtensa_dc233c_na.py  |   6 +
>   .../u_boot_boardenv_r2dplus_i82557c_qemu.py   |   6 +
>   .../u_boot_boardenv_r2dplus_pcnet_qemu.py     |   6 +
>   .../u_boot_boardenv_r2dplus_rtl8139_qemu.py   |   6 +
>   .../u_boot_boardenv_r2dplus_tulip_qemu.py     |   6 +
>   ...t_boardenv_sifive_unleashed_sdcard_qemu.py |  10 +
>   ..._boardenv_sifive_unleashed_spi_nor_qemu.py |  10 +
>   .../u_boot_boardenv_vexpress_ca15_tc2_qemu.py |  10 +
>   .../u_boot_boardenv_vexpress_ca9x4_qemu.py    |  10 +
>   ...u_boot_boardenv_xilinx_versal_virt_qemu.py |   1 +
>   .../u_boot_boardenv_xilinx_zynq_virt_qemu.py  |   3 +
>   .../u_boot_boardenv_zynq_zc702_qemu.py        |   3 +
>   199 files changed, 5340 insertions(+), 27 deletions(-)
>   create mode 100644 doc/develop/test_hooks.rst
>   create mode 100644 test/hooks/bin/OLI01/conf.mx6qsabrelite_na
>   create mode 100644 test/hooks/bin/bill-the-cat/conf.integratorcp_cm926ejs_qemu
>   create mode 100644 test/hooks/bin/bill-the-cat/conf.qemu_mips_na
>   create mode 100644 test/hooks/bin/bill-the-cat/conf.vexpress_ca15_tc2_qemu
>   create mode 100755 test/hooks/bin/common-config.cros-servo-dut-control
>   create mode 100644 test/hooks/bin/common.labgrid-trini
>   create mode 100644 test/hooks/bin/console.fvp
>   create mode 100644 test/hooks/bin/console.labgrid-sjg
>   create mode 100755 test/hooks/bin/console.labgrid-trini
>   create mode 100644 test/hooks/bin/console.picocom
>   create mode 100644 test/hooks/bin/console.qemu
>   create mode 100644 test/hooks/bin/download.imx_usb
>   create mode 100644 test/hooks/bin/download.l4t-exec-uboot
>   create mode 100755 test/hooks/bin/download.tegra-uboot-flasher
>   create mode 100755 test/hooks/bin/ellesmere/common-labgrid-sjg
>   create mode 100644 test/hooks/bin/ellesmere/conf.all
>   create mode 100644 test/hooks/bin/ellesmere/conf.evb-ast2500_qemu
>   create mode 120000 test/hooks/bin/ellesmere/conf.qemu-riscv32_na
>   create mode 120000 test/hooks/bin/ellesmere/conf.qemu-riscv32_spl_na
>   create mode 120000 test/hooks/bin/ellesmere/conf.qemu-riscv64_na
>   create mode 120000 test/hooks/bin/ellesmere/conf.qemu-x86_64_na
>   create mode 120000 test/hooks/bin/ellesmere/conf.qemu-x86_na
>   create mode 120000 test/hooks/bin/ellesmere/conf.qemu_arm64_na
>   create mode 120000 test/hooks/bin/ellesmere/conf.qemu_arm64_spl_na
>   create mode 120000 test/hooks/bin/ellesmere/conf.qemu_arm_na
>   create mode 120000 test/hooks/bin/ellesmere/conf.qemu_arm_spl_na
>   create mode 100644 test/hooks/bin/flash.em100
>   create mode 100644 test/hooks/bin/flash.fiptool
>   create mode 100644 test/hooks/bin/flash.flashair
>   create mode 100644 test/hooks/bin/flash.labgrid-trini.sd-mux
>   create mode 100644 test/hooks/bin/flash.none
>   create mode 100755 test/hooks/bin/flash.qemu_gen_padded_image
>   create mode 100644 test/hooks/bin/flash.recovery_l4t
>   create mode 100644 test/hooks/bin/flash.sdwire_common_mount
>   create mode 100644 test/hooks/bin/flash.sdwire_digital-loggers_raw
>   create mode 100644 test/hooks/bin/flash.sdwire_poweroff_mount
>   create mode 100644 test/hooks/bin/flash.sdwire_poweroff_raw
>   create mode 100644 test/hooks/bin/flash.sdwire_relay_mount
>   create mode 100644 test/hooks/bin/flashair.rpi
>   create mode 100644 test/hooks/bin/flashair.ti-omap
>   create mode 100755 test/hooks/bin/getrole.labgrid-sjg
>   create mode 100644 test/hooks/bin/kea/conf.Linksprite_pcDuino3_sjg-pcduino3
>   create mode 100644 test/hooks/bin/kea/conf.chromebook_link_sjg-link
>   create mode 100644 test/hooks/bin/kea/conf.chromebook_samus_sjg-samus
>   create mode 100644 test/hooks/bin/kea/conf.jetson-tk1_sjg-tk1
>   create mode 100644 test/hooks/bin/kea/conf.minnowmax_sjg-minnowmax
>   create mode 100644 test/hooks/bin/kea/conf.orangepi_pc_sjg-opi_pc
>   create mode 100644 test/hooks/bin/kea/conf.rock2_sjg-rock2
>   create mode 100644 test/hooks/bin/kea/conf.rpi_3_32b_sjg-rpi_3b
>   create mode 100644 test/hooks/bin/kea/conf.rpi_3_sjg-rpi_3b
>   create mode 100644 test/hooks/bin/kea/conf.zynq_zybo_sjg-zynq_zybo
>   create mode 100644 test/hooks/bin/konsulko-labgrid/conf.am62x_beagleplay_a53_na
>   create mode 100644 test/hooks/bin/konsulko-labgrid/conf.am64x_evm_a53_na
>   create mode 120000 test/hooks/bin/konsulko-labgrid/conf.rpi_4_32b_na
>   create mode 120000 test/hooks/bin/konsulko-labgrid/conf.rpi_4_na
>   create mode 100644 test/hooks/bin/konsulko-labgrid/conf.rpi_arm64_na
>   create mode 100644 test/hooks/bin/poweroff.digital-loggers
>   create mode 100644 test/hooks/bin/poweroff.manual
>   create mode 100755 test/hooks/bin/poweroff.none
>   create mode 100644 test/hooks/bin/poweroff.phidgets
>   create mode 100644 test/hooks/bin/poweroff.pm342
>   create mode 100644 test/hooks/bin/poweroff.ykush
>   create mode 100644 test/hooks/bin/poweron.digital-loggers
>   create mode 100644 test/hooks/bin/poweron.manual
>   create mode 100755 test/hooks/bin/poweron.none
>   create mode 100644 test/hooks/bin/poweron.phidgets
>   create mode 100644 test/hooks/bin/poweron.pm342
>   create mode 100644 test/hooks/bin/poweron.ykush
>   create mode 100755 test/hooks/bin/push-flashair.py
>   create mode 100755 test/hooks/bin/qemu.swtpm
>   create mode 100644 test/hooks/bin/recovery.manual
>   create mode 100644 test/hooks/bin/recovery.phidgets
>   create mode 100644 test/hooks/bin/recovery.pm342
>   create mode 100755 test/hooks/bin/recovery.relay
>   create mode 100755 test/hooks/bin/recovery.usbrelay
>   create mode 100644 test/hooks/bin/release.labgrid-sjg
>   create mode 100644 test/hooks/bin/release.none
>   create mode 100644 test/hooks/bin/reset.cros_servo
>   create mode 100644 test/hooks/bin/reset.digital-loggers
>   create mode 100755 test/hooks/bin/reset.labgrid-trini
>   create mode 100644 test/hooks/bin/reset.none
>   create mode 100644 test/hooks/bin/reset.pm342
>   create mode 100644 test/hooks/bin/reset.recovery_download
>   create mode 100644 test/hooks/bin/reset.usbrelay
>   create mode 100644 test/hooks/bin/reset.ykush
>   create mode 100644 test/hooks/bin/swarren-lx1/conf.jetson-tk1_na
>   create mode 100644 test/hooks/bin/swarren-lx1/conf.p2371-2180_na
>   create mode 100644 test/hooks/bin/swarren-lx1/conf.p2771-0000-500_na
>   create mode 100644 test/hooks/bin/travis-ci/conf.M5208EVBE_qemu
>   create mode 100644 test/hooks/bin/travis-ci/conf.coreboot_qemu
>   create mode 100644 test/hooks/bin/travis-ci/conf.evb-ast2500_qemu
>   create mode 100644 test/hooks/bin/travis-ci/conf.evb-ast2600_qemu
>   create mode 100644 test/hooks/bin/travis-ci/conf.integratorcp_cm926ejs_qemu
>   create mode 100644 test/hooks/bin/travis-ci/conf.malta64_qemu
>   create mode 100644 test/hooks/bin/travis-ci/conf.malta64el_qemu
>   create mode 100644 test/hooks/bin/travis-ci/conf.malta_qemu
>   create mode 100644 test/hooks/bin/travis-ci/conf.maltael_qemu
>   create mode 100644 test/hooks/bin/travis-ci/conf.qemu-ae3xx_na
>   create mode 100644 test/hooks/bin/travis-ci/conf.qemu-arm-sbsa_na
>   create mode 100644 test/hooks/bin/travis-ci/conf.qemu-ax25_na
>   create mode 100644 test/hooks/bin/travis-ci/conf.qemu-loongarch64_na
>   create mode 100644 test/hooks/bin/travis-ci/conf.qemu-ppce500_na
>   create mode 100644 test/hooks/bin/travis-ci/conf.qemu-riscv32_na
>   create mode 100644 test/hooks/bin/travis-ci/conf.qemu-riscv32_spl_na
>   create mode 100644 test/hooks/bin/travis-ci/conf.qemu-riscv64_na
>   create mode 100644 test/hooks/bin/travis-ci/conf.qemu-riscv64_spl_na
>   create mode 100644 test/hooks/bin/travis-ci/conf.qemu-x86_64_na
>   create mode 100644 test/hooks/bin/travis-ci/conf.qemu-x86_na
>   create mode 100644 test/hooks/bin/travis-ci/conf.qemu-xtensa-dc233c_na
>   create mode 100644 test/hooks/bin/travis-ci/conf.qemu_arm64_na
>   create mode 100644 test/hooks/bin/travis-ci/conf.qemu_arm64_spl_na
>   create mode 100644 test/hooks/bin/travis-ci/conf.qemu_arm64_tpl_na
>   create mode 100644 test/hooks/bin/travis-ci/conf.qemu_arm64be_na
>   create mode 100644 test/hooks/bin/travis-ci/conf.qemu_arm_na
>   create mode 100644 test/hooks/bin/travis-ci/conf.qemu_arm_spl_na
>   create mode 100644 test/hooks/bin/travis-ci/conf.qemu_mips64_na
>   create mode 100644 test/hooks/bin/travis-ci/conf.qemu_mips64el_na
>   create mode 100644 test/hooks/bin/travis-ci/conf.qemu_mips_na
>   create mode 100644 test/hooks/bin/travis-ci/conf.qemu_mipsel_na
>   create mode 100644 test/hooks/bin/travis-ci/conf.r2dplus_i82557c_qemu
>   create mode 100644 test/hooks/bin/travis-ci/conf.r2dplus_pcnet_qemu
>   create mode 100644 test/hooks/bin/travis-ci/conf.r2dplus_rtl8139_qemu
>   create mode 100644 test/hooks/bin/travis-ci/conf.r2dplus_tulip_qemu
>   create mode 100644 test/hooks/bin/travis-ci/conf.sifive_unleashed_sdcard_qemu
>   create mode 100644 test/hooks/bin/travis-ci/conf.sifive_unleashed_spi-nor_qemu
>   create mode 100644 test/hooks/bin/travis-ci/conf.vexpress_ca15_tc2_qemu
>   create mode 100644 test/hooks/bin/travis-ci/conf.vexpress_ca9x4_qemu
>   create mode 120000 test/hooks/bin/travis-ci/conf.vexpress_fvp_bloblist_na
>   create mode 100644 test/hooks/bin/travis-ci/conf.vexpress_fvp_na
>   create mode 100644 test/hooks/bin/travis-ci/conf.xilinx_versal_virt_qemu
>   create mode 100644 test/hooks/bin/travis-ci/conf.xilinx_zynq_virt_qemu
>   create mode 100644 test/hooks/bin/travis-ci/conf.xtfpga_qemu
>   create mode 100644 test/hooks/bin/travis-ci/conf.zynq_zc702_qemu
>   create mode 100755 test/hooks/bin/u-boot-test-common
>   create mode 100755 test/hooks/bin/u-boot-test-console
>   create mode 100755 test/hooks/bin/u-boot-test-flash
>   create mode 100755 test/hooks/bin/u-boot-test-getrole
>   create mode 100755 test/hooks/bin/u-boot-test-power-off
>   create mode 100755 test/hooks/bin/u-boot-test-power-on
>   create mode 100755 test/hooks/bin/u-boot-test-release
>   create mode 100755 test/hooks/bin/u-boot-test-reset
>   create mode 100644 test/hooks/bin/wait_raw_device
>   create mode 100755 test/hooks/bin/writer.imx_raw
>   create mode 100644 test/hooks/bin/writer.labgrid-trini.rpi
>   create mode 100644 test/hooks/bin/writer.labgrid-trini.ti-k3
>   create mode 100755 test/hooks/bin/writer.rk3288_raw
>   create mode 100755 test/hooks/bin/writer.rpi_mount
>   create mode 100755 test/hooks/bin/writer.sunxi_raw
>   create mode 100755 test/hooks/bin/writer.ti-k3_mount
>   create mode 100755 test/hooks/bin/writer.ti-omap_mount
>   create mode 100755 test/hooks/bin/writer.zynq_mount
>   create mode 100644 test/hooks/contrib/src/.gitignore
>   create mode 100644 test/hooks/contrib/src/README.txt
>   create mode 100755 test/hooks/contrib/src/build.sh
>   create mode 100644 test/hooks/contrib/src/phidgets-relay.c
>   create mode 100644 test/hooks/contrib/udev/swarren-lx1/99-ubtest.rules
>   create mode 100644 test/hooks/py/OLI01/u_boot_boardenv_mx6qsabrelite_na.py
>   create mode 120000 test/hooks/py/konsulko-labgrid/u_boot_boardenv_rpi_4.py
>   create mode 100644 test/hooks/py/konsulko-labgrid/u_boot_boardenv_rpi_arm64.py
>   create mode 100644 test/hooks/py/swarren-lx1/u_boot_boardenv_jetson_tk1_na.py
>   create mode 100644 test/hooks/py/swarren-lx1/u_boot_boardenv_p2371_2180_na.py
>   create mode 100644 test/hooks/py/swarren-lx1/u_boot_boardenv_p2771_0000_500_na.py
>   create mode 100644 test/hooks/py/travis-ci/travis_tftp.py
>   create mode 100644 test/hooks/py/travis-ci/u_boot_boardenv_M5208EVBE_qemu.py
>   create mode 100644 test/hooks/py/travis-ci/u_boot_boardenv_evb_ast2500_qemu.py
>   create mode 100644 test/hooks/py/travis-ci/u_boot_boardenv_evb_ast2600_qemu.py
>   create mode 100644 test/hooks/py/travis-ci/u_boot_boardenv_malta64_qemu.py
>   create mode 100644 test/hooks/py/travis-ci/u_boot_boardenv_malta64el_qemu.py
>   create mode 100644 test/hooks/py/travis-ci/u_boot_boardenv_malta_qemu.py
>   create mode 100644 test/hooks/py/travis-ci/u_boot_boardenv_maltael_qemu.py
>   create mode 100644 test/hooks/py/travis-ci/u_boot_boardenv_qemu_ae3xx_na.py
>   create mode 100644 test/hooks/py/travis-ci/u_boot_boardenv_qemu_arm64_na.py
>   create mode 100644 test/hooks/py/travis-ci/u_boot_boardenv_qemu_arm64be_na.py
>   create mode 100644 test/hooks/py/travis-ci/u_boot_boardenv_qemu_arm_na.py
>   create mode 100644 test/hooks/py/travis-ci/u_boot_boardenv_qemu_ax25_na.py
>   create mode 100644 test/hooks/py/travis-ci/u_boot_boardenv_qemu_loongarch64_na.py
>   create mode 100644 test/hooks/py/travis-ci/u_boot_boardenv_qemu_riscv32_na.py
>   create mode 100644 test/hooks/py/travis-ci/u_boot_boardenv_qemu_riscv32_spl_na.py
>   create mode 100644 test/hooks/py/travis-ci/u_boot_boardenv_qemu_riscv64_na.py
>   create mode 100644 test/hooks/py/travis-ci/u_boot_boardenv_qemu_riscv64_spl_na.py
>   create mode 100644 test/hooks/py/travis-ci/u_boot_boardenv_qemu_x86_64_na.py
>   create mode 100644 test/hooks/py/travis-ci/u_boot_boardenv_qemu_x86_na.py
>   create mode 100644 test/hooks/py/travis-ci/u_boot_boardenv_qemu_xtensa_dc233c_na.py
>   create mode 100644 test/hooks/py/travis-ci/u_boot_boardenv_r2dplus_i82557c_qemu.py
>   create mode 100644 test/hooks/py/travis-ci/u_boot_boardenv_r2dplus_pcnet_qemu.py
>   create mode 100644 test/hooks/py/travis-ci/u_boot_boardenv_r2dplus_rtl8139_qemu.py
>   create mode 100644 test/hooks/py/travis-ci/u_boot_boardenv_r2dplus_tulip_qemu.py
>   create mode 100644 test/hooks/py/travis-ci/u_boot_boardenv_sifive_unleashed_sdcard_qemu.py
>   create mode 100644 test/hooks/py/travis-ci/u_boot_boardenv_sifive_unleashed_spi_nor_qemu.py
>   create mode 100644 test/hooks/py/travis-ci/u_boot_boardenv_vexpress_ca15_tc2_qemu.py
>   create mode 100644 test/hooks/py/travis-ci/u_boot_boardenv_vexpress_ca9x4_qemu.py
>   create mode 100644 test/hooks/py/travis-ci/u_boot_boardenv_xilinx_versal_virt_qemu.py
>   create mode 100644 test/hooks/py/travis-ci/u_boot_boardenv_xilinx_zynq_virt_qemu.py
>   create mode 100644 test/hooks/py/travis-ci/u_boot_boardenv_zynq_zc702_qemu.py
> 

