Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D5F0C4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 09:35:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8DA0E877D8;
	Wed, 13 Dec 2023 10:35:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="SgzcawAi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35F90877D4; Wed, 13 Dec 2023 10:35:46 +0100 (CET)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 03043877EE
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 10:35:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3363397426eso1402053f8f.1
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 01:35:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702460142; x=1703064942; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=N4hKhekNyotkHA0D+EX6nmiYfqOYvHPHBpaAxAOSj9Y=;
 b=SgzcawAifTREOx/BhwX0gdxxp8q2HGPR94zmE86y+y4h89zyuGg94kSXaVrWIYT28k
 HY9zFK4XiMz3IqcLiNEPSGw8aCvvUWYr79txdC5LGEVfDcEGjdaDKgJa/F4d1xIHDSqw
 g1Oq5QgXmTSzBvlItAhoOm2KM6FoQiDi8YswXl/GDgVpLUuKDoidh4SA5YNUkPBwSK1E
 AQuiOSn9pbUR9S3ivBMnpcWLfeE/Ts+kuPsB8h3iSs3qQnelF+vXNfQFN7rvXJnb5G3B
 omB7kFVp2qNVSyQlM4SIr2d4LMkM1Udd4TOIXUxoVQyi/k7OIiGPa5EJHKvxbHFc7Msr
 2PMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702460142; x=1703064942;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :references:cc:to:content-language:subject:reply-to:from:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=N4hKhekNyotkHA0D+EX6nmiYfqOYvHPHBpaAxAOSj9Y=;
 b=guz/iqJJHqRHIfO8dtpgZrOfbExqWv+UpXqrlGO0ZAtLVWEHvKlRV6PXJwOOxQ8mq9
 G6DVD5bnMZC8Lebvwcr+fO2pEK6peY+md0wHNFVNpRTw6Qc+T4Ybp81ycNI3vrGazZGy
 0v8TYoSqJUUnNEydWsTkn9nH0kxp8cPwQtWGARWjqHvgZR+WCACpjFXnX2MmiOL0HFuw
 hbiR/dD+PkCsQVM9cBsFqcFBCia1uZa6nlxfbig0yfMXl3Vsd2AGHtT3Ck40J/MBvTCx
 QUDWZECXPVyLxK7zqbdiiC2TmbbjiSVPtb2R+rPuJTXKKO3YNyMBJuRlCjAKwXNC9NAF
 fiew==
X-Gm-Message-State: AOJu0Yy4BKs5tqqFc3lp3K02CrlCWFZkbghLHGHL7jRPOVwIq4DmafMF
 1OQbYE1git3JzfkhuRu1uQ8o8w==
X-Google-Smtp-Source: AGHT+IGFXBLP1ZIzYHkbt9T/xMp3tLcAl8aeFXYnWV/SxvogAB8t2EBNHsLm8XfScIA4V4tZqWo2Ww==
X-Received: by 2002:a05:6000:544:b0:333:ed:82e7 with SMTP id
 b4-20020a056000054400b0033300ed82e7mr4169144wrf.10.1702460141525; 
 Wed, 13 Dec 2023 01:35:41 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:596e:6d4f:fc0a:ec65?
 ([2a01:e0a:982:cbb0:596e:6d4f:fc0a:ec65])
 by smtp.gmail.com with ESMTPSA id
 o8-20020a5d4a88000000b00334b302e97fsm12743451wrq.96.2023.12.13.01.35.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Dec 2023 01:35:39 -0800 (PST)
Message-ID: <e7e0d6fa-2ba5-4ea0-928b-bb0c0f6b05d3@linaro.org>
Date: Wed, 13 Dec 2023 10:35:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Subject: Re: [PATCH v12 00/24] Modernize U-Boot shell
Content-Language: en-US, fr
To: Francis Laniel <francis.laniel@amarulasolutions.com>, u-boot@lists.denx.de
Cc: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, Harald Seiler <hws@denx.de>,
 Simon Glass <sjg@chromium.org>
References: <20231208223025.55076-1-francis.laniel@amarulasolutions.com>
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
Organization: Linaro Developer Services
In-Reply-To: <20231208223025.55076-1-francis.laniel@amarulasolutions.com>
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

On 08/12/2023 23:30, Francis Laniel wrote:
> Hi.
> 
> 
> During 2021 summer, Sean Anderson wrote a contribution to add a new shell, based
> on LIL, to U-Boot [1, 2].
> While one of the goals of this contribution was to address the fact actual
> U-Boot shell, which is based on Busybox hush, is old there was a discussion
> about adding a new shell versus updating the actual one [3, 4].
> 
> So, in this series, with Harald Seiler, we updated the actual U-Boot shell to
> reflect what is currently in Busybox source code.
> Basically, this contribution is about taking a snapshot of Busybox shell/hush.c
> file (as it exists in commit 37460f5da) and adapt it to suit U-Boot needs.
> 
> This contribution was written to be as backward-compatible as possible to avoid
> breaking the existing.
> So, the modern hush flavor offers the same as the actual, that is to say:
> 1. Variable expansion.
> 2. Instruction lists (;, && and ||).
> 3. If, then and else.
> 4. Loops (for, while and until).
> No new features offered by Busybox hush were implemented (e.g. functions).
> 
> It is possible to change the parser at runtime using the "cli" command:
> => cli print
> old
> => cli set modern
> => cli print
> modern
> => cli set old
> The default parser is the old one.
> Note that to use both parser, you would need to set both
> CONFIG_HUSH_MODERN_PARSER and CONFIG_HUSH_OLD_PARSER.
> 
> In terms of testing, new unit tests were added to ut to ensure the new behavior
> is the same as the old one and it does not add regression.
> Nonetheless, if old behavior was buggy and fixed upstream, the fix is then added
> to U-Boot [5].
> In sandbox, all of these tests pass smoothly:
> => printenv board
> board=sandbox
> => ut hush
> Running 20 hush tests
> ...
> Failures: 0
> => cli set modern
> => ut hush
> Running 20 hush tests
> ...
> Failures: 0
> 
> Thanks to the effort of Harald Seiler, I was successful booting a board:
> => printenv fdtfile
> fdtfile=amlogic/meson-gxl-s905x-libretech-cc.dtb
> => cli get
> old
> => boot
> ...
> root@lepotato:~#
> root@lepotato:~# reboot
> ...
> => cli set modern
> => cli get
> modern
> => printenv fdtfile
> fdtfile=amlogic/meson-gxl-s905x-libretech-cc.dtb
> => boot
> ...
> root@lepotato:~#
> 
> This contribution indeed adds a lot of code and there were concern about its
> size [6, 7].
> With regard to the amount of code added, the cli_hush_upstream.c is 13030 lines
> long but it seems a smaller subset is really used:
> gcc -D__U_BOOT__ -E common/cli_hush_upstream.c | wc -l
> 2870
> Despite this, it is better to still have the whole upstream code for the sake of
> easing maintenance.
> With regard to memory size, I conducted some experiments for version 8 of this
> series and for a subset of arm64 boards and found the worst case to be 4K [8].
> Tom Rini conducted more research on this and also found the increase to be
> acceptable [9].
> 
> If you want to review it - your review will really be appreciated - here are
> some information regarding the commits:
> * commits marked as "test:" deal with unit tests.
> * commit "cli: Add Busybox upstream hush.c file." copies Busybox shell/hush.c
> into U-Boot tree, this explain why this commit contains around 12000 additions.
> * commit "cli: Port Busybox 2021 hush to U-Boot." modifies previously added file
> to permit us to use this as new shell.
> The really good idea of #include'ing Busybox code into a wrapper file to define
> some particular functions while minimizing modifications to upstream code comes
> from Harald Seiler.
> * commit "cmd: Add new parser command" adds a new command which permits
> selecting parser at runtime.
> I am not really satisfied with the fact it calls cli_init() and cli_loop() each
> time the parser is set, so your reviews would be welcomed.
> * Other commits focus on enabling features we need (e.g. if).
> 
> Changes since:
>   v2:
>    * Added a small fix to compile sandbox with NO_SDL=1.
>    * Added a command to change parser at runtime.
>    * Added 2021 parser function to all run_command*().
>   v3:
>    * Various bug fixes pointed by the CI.
>    * Added upstream busybox hush commits until 6th February 2022.
>   v4:
>    * Various cleaning.
>    * Modified python test to accept failure output when the test are designed to
>    fail.
>    * Bumped upstream busybox hush commits until 24h March 2022.
>   v5:
>    * Bumped upstream busybox hush commits until 30th January 2023.
>    * Fix how hush interprets '<' and '>', indeed we needed to escape them but I
>    removed this behavior as tests are handled by test command and not hush
>    itself. This permitted to have the ut fdt to pass.
>    * Fix a problem with how exit was handled. This was reported by the ut exit
>    test.
>   v6:
>    * There was no v6 and I got mixed up with version.
>   v7:
>    * Bumped upstream busybox hush commits until 9th May 2023.
>    * Renamed parser command to change parser at runtime to cli and added
>    documentation.
>    * Added better separation of patches.
>    * Removed code about __gnu_thumb1_case_si as it was merged in another series.
>    * Various cleaning.
>   v8:
>    * Bumped upstream busybox hush commits until 25th May 2023.
>   v9:
>    * Bumped upstream busybox hush commits until 2nd October 2023.
>   v10:
>    * Fixed a build error in commit adding cli command.
>    * Add new CONFIG_HUSH_SELECTABLE to only build cli command if the two shell
>    flavors are selected.
>   v11:
>    * Renamed everything containing 2021 to modern.
>    * Fixed cmd Kconfig indentation.
>    * Set modern parser as default for majority of boards except some.
> 
> Francis Laniel (24):
>    test: Add framework to test hush behavior
>    test: hush: Test hush if/else
>    test/py: hush_if_test: Remove the test file
>    test: hush: Test hush variable expansion
>    test: hush: Test hush commands list
>    test: hush: Test hush loops
>    cli: Add Busybox upstream hush.c file
>    cli: Port upstream Busybox hush to U-Boot
>    cli: Add menu for hush parser
>    global_data.h: add GD_FLG_HUSH_OLD_PARSER flag
>    cmd: Add new cli command
>    cli: Enables using modern hush parser as command line parser
>    cli: hush_modern: Enable variables expansion for modern hush
>    cli: hush_modern: Add functions to be called from run_command()
>    cli: add modern hush as parser for run_command*()
>    test: hush: Fix instructions list tests for modern hush
>    test: hush: Fix variable expansion tests for modern hush
>    cli: hush_modern: Enable using < and > as string compare operators
>    cli: hush_modern: Enable if keyword
>    cli: hush_modern: Enable loops
>    test: hush: Fix loop tests for modern hush
>    cli: modern_hush: Add upstream commits up to 2nd October 2023.
>    cmd: Set modern hush as default shell
>    configs: Use old hush for several boards
> 
>   cmd/Kconfig                            |    21 +
>   cmd/Makefile                           |     2 +
>   cmd/cli.c                              |   134 +
>   common/Makefile                        |     3 +-
>   common/cli.c                           |    82 +-
>   common/cli_hush_modern.c               |   324 +
>   common/cli_hush_upstream.c             | 13030 +++++++++++++++++++++++
>   configs/kmcent2_defconfig              |     1 +
>   configs/kmcoge5ne_defconfig            |     1 +
>   configs/kmeter1_defconfig              |     1 +
>   configs/kmopti2_defconfig              |     1 +
>   configs/kmsupx5_defconfig              |     1 +
>   configs/kmtepr2_defconfig              |     1 +
>   configs/pg_wcom_expu1_defconfig        |     1 +
>   configs/pg_wcom_expu1_update_defconfig |     1 +
>   configs/pg_wcom_seli8_defconfig        |     1 +
>   configs/pg_wcom_seli8_update_defconfig |     1 +
>   configs/socfpga_secu1_defconfig        |     1 +
>   configs/tuge1_defconfig                |     1 +
>   configs/tuxx1_defconfig                |     1 +
>   doc/usage/cmd/cli.rst                  |    74 +
>   doc/usage/index.rst                    |     1 +
>   include/asm-generic/global_data.h      |     8 +
>   include/cli_hush.h                     |    51 +-
>   include/test/hush.h                    |    15 +
>   include/test/suites.h                  |     1 +
>   test/Makefile                          |     3 +
>   test/cmd_ut.c                          |     6 +
>   test/hush/Makefile                     |    10 +
>   test/hush/cmd_ut_hush.c                |    20 +
>   test/hush/dollar.c                     |   226 +
>   test/hush/if.c                         |   316 +
>   test/hush/list.c                       |   140 +
>   test/hush/loop.c                       |    91 +
>   test/py/tests/test_hush_if_test.py     |   197 -
>   test/py/tests/test_ut.py               |     8 +-
>   36 files changed, 14565 insertions(+), 211 deletions(-)
>   create mode 100644 cmd/cli.c
>   create mode 100644 common/cli_hush_modern.c
>   create mode 100644 common/cli_hush_upstream.c
>   create mode 100644 doc/usage/cmd/cli.rst
>   create mode 100644 include/test/hush.h
>   create mode 100644 test/hush/Makefile
>   create mode 100644 test/hush/cmd_ut_hush.c
>   create mode 100644 test/hush/dollar.c
>   create mode 100644 test/hush/if.c
>   create mode 100644 test/hush/list.c
>   create mode 100644 test/hush/loop.c
>   delete mode 100644 test/py/tests/test_hush_if_test.py
> 
> 
> Best regards and thank you in advance.
> ---
> [1] https://lists.denx.de/pipermail/u-boot/2021-July/453347.html
> [2] https://runtimeterror.com/tech/lil/
> [3] https://lists.denx.de/pipermail/u-boot/2021-July/453790.html
> [4] https://lists.denx.de/pipermail/u-boot/2021-July/453848.html
> [5] https://lists.denx.de/pipermail/u-boot/2021-August/458569.html
> [6] https://lists.denx.de/pipermail/u-boot/2023-November/536768.html
> [7] https://lists.denx.de/pipermail/u-boot/2023-May/518140.html
> [8] https://lists.denx.de/pipermail/u-boot/2023-May/518147.html
> [9] https://lists.denx.de/pipermail/u-boot/2023-November/536952.html
> --
> 2.34.1
> 

Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on libretech-ac
Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on libretech-cc
Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on bananapi-m2s
Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on bananapi-m5

For reference:
https://gitlab.com/amlogic-foss/amlogic-u-boot-autotest/-/pipelines/1105162563/test_report

Thanks !
Neil
