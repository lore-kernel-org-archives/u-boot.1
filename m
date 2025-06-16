Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CEF3C71136
	for <u-boot@archiver.kernel.org>; Mon, 16 Jun 2025 16:13:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9B88B81E18;
	Mon, 16 Jun 2025 18:13:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="JbQdVgSQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8DA01829F5; Mon, 16 Jun 2025 18:13:20 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0F14881760
 for <u-boot@lists.denx.de>; Mon, 16 Jun 2025 18:13:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4530921461aso40263775e9.0
 for <u-boot@lists.denx.de>; Mon, 16 Jun 2025 09:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750090397; x=1750695197; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JSH89qPky9fXmdmIylKBSeiTaakhE+YkMdyjX8PjdQQ=;
 b=JbQdVgSQ/slPOyz3GdDzkYsDVp6BGrbB+LHZ8XEhwN++vxsM4W2OisqMK+6vYwP5GS
 ImP8OBBSNd1ip9VyxtT9p/h3l1zYRkTMptgMtBwxmZ9yx1aKtLUNAU4EVVEE74mDYaYx
 OWbQ0n1dgjbphRWyrluodmm+dH6NKJ+MEGuFJpABOAW7Gv4zDuvJErv14j7ZgFtwSeIw
 gab5I+FQzMKWHPnrgC78R4ds+xFdDAyWP/Go7s6Q3Ea1I0k6q7m4XX9RCVjHlXW2h9Lc
 MQkorOqQaXcrE/qDMQSEvbxTtkM60Wm/GFAokWspegMXvb61fGc9bptz70Rj3oNGuEx/
 jm0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750090397; x=1750695197;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JSH89qPky9fXmdmIylKBSeiTaakhE+YkMdyjX8PjdQQ=;
 b=IytXfFQ1s8b8uSR/T/tOBxNAS7zblwLyCwb3+cFSH58o9pYgGoIDJT2oFjLL9+gydl
 k7hi8EAkCLjPsylWmgZqN8wgAP5ICCOduthv/Ury1rVWUVuhfMaAmVlyz9bJ+INBP99V
 3nuiqGYg4tcIg1TUbYn90YUSjSLcanvh3Ss2AB1E7EhBKoFURIH1VJxdgw7movmE8mWg
 X6+aOMIDpfu/a0Xoqj74XVmBC9H4G2uwjFFvFJzahg9Ei3veNhDV5H2slHbr7p5UzVNM
 zX7QjvAVT8qNlApG4z+YZmA2cYq59HExUEsc42V+fjDtGo2DGUrO/JkVaaFgVx2r7/d2
 u4OQ==
X-Gm-Message-State: AOJu0YwIBTO1KP55QO150bhn1Hy+MN8UCIaYDDI2fejTji17+bzNvUi5
 6wu4p3495I5cU+HvXd25YYMaWiv1YDZ6BqcNNkUNcIPFUv28Zxu81VUhMlkmcr/ROGc=
X-Gm-Gg: ASbGncuxhU55oZqrWcZCfdas7R+SwR0LGdOu5RwihLy8KQipIab+LRgo70SdHb/fLuP
 Z4xEpL/yZ7Qve+KvLwLNVqdVTrWlilJrm+hyz6Va4ZcZftAeicg0jNotB/QrCccepPhsJNVrbvU
 USDk7tP8N5lLek2OF9gXAKt8jUXHvqdD9fVnI7pQAuBw6Sjm20DEYi9ITuv5g9VReTHOT38W5Ug
 6Uwa+MVdalGDAlG2W0/d0tDVvb6dd7gsRYJxhBg0Y9qJSPN6v6Ksmhjb7Tvi2ppxYppCANJul2X
 1FoKKON/GCCSmHgTb28nucIIMtuRhgpfm0cpF+X51xfeoUoxmY/6YXlx4y5Iw16kMAfJY0HO9gs
 d
X-Google-Smtp-Source: AGHT+IH/HlUyhQDEGGwvsHIvmVIAa4jqssCRdTZ9Oiwz1dOl0NJDzIkTK4iXyIiSBg1+n0llggOgpQ==
X-Received: by 2002:a05:600c:4e87:b0:442:d5dd:5b4b with SMTP id
 5b1f17b1804b1-4533cac57efmr106511555e9.31.1750090397404; 
 Mon, 16 Jun 2025 09:13:17 -0700 (PDT)
Received: from [192.168.1.104] ([213.240.182.76])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4532e224617sm150972365e9.2.2025.06.16.09.13.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Jun 2025 09:13:16 -0700 (PDT)
Message-ID: <aa490fb0-e485-4227-8750-70c66c308bd5@linaro.org>
Date: Mon, 16 Jun 2025 18:13:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/8] Qualcomm: teach the build system to emit signed
 ELF images
To: Tom Rini <trini@konsulko.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Sumit Garg <sumit.garg@kernel.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>
References: <20250613-b4-qcom-tooling-improvements-v4-0-7ea1c68779fa@linaro.org>
Content-Language: en-US
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20250613-b4-qcom-tooling-improvements-v4-0-7ea1c68779fa@linaro.org>
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
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi Tom,

So I've been testing this a bit harder (really should have noticed this 
sooner) and it turns out using binman makes things a whole lot more 
complicated...

Specifically, the new trogdor chromebook board doesn't need binman, the 
U-Boot ELF is used directly since they have their own bootloader beforehand.

But since CONFIG_BINMAN can't be enabled in a defconfig and only 
selected by some other Kconfig there isn't really a nice way to handle 
this. The trogdor board doesn't add any Kconfigs of it's own and doing 
something like

depends on BINMAN if !CONFIG_SYS_COREBOOT

would be a huge hack...

This wouldn't be an issue in and of itself, but binman makes the build 
fail since of course the DT doesn't have a binman node and the trogdor 
defconfig doesn't define CONFIG_BINMAN_DTB (and shouldn't have to...).

Possibly the easiest solution would be to allow defconfigs to set 
CONFIG_BINMAN, or add some additional kconfig we can use to pull it in 
(CONFIG_QCOM_BUILD_MBN ?), maybe the latter is the most comprehensible 
solution.

I think I'll go with that unless anyone can chime in with some other 
suggestions.

Kind regards,

On 6/13/25 19:23, Casey Connolly wrote:
> With several new Qualcomm platforms appearing on the mailing list, all
> of which build U-Boot as an ELF, sign it, and then flash it to some
> partition on the board, we're getting a lot of defconfigs which just
> contain a debug UART and a TEXT_BASE address. This leads to needless
> rebuilds in CI of effectively the same image, and needless duplication
> of build instructions.
> 
> To address this, let's introduce a new tool "mkmbn.py", this is based
> on the existing qtestsign[1] tool but is (currently) hardcoded to
> only handle the Dragonwing and IPQ boards which use MBN header v6.
> Additionally, the tool contains a lookup table that maps from a boards
> DT compatible property to the load address it needs. Since it's highly
> unusual for different boards using the same SoC to have different load
> addresses, generic platform matching is also done (e.g. "qcom,qcm6490").
> 
> With this tool in place, we teach binman to use it and introduce
> a qcom-binman.dts file to describe the image. The tool will emit a
> u-boot.mbn file for supported platforms, for unsupported platforms the
> u-boot MBN etype in binman will print a notice explaining that no mbn
> file is built and to look at tools/qcom/mkmbn/mkmbn.py
> 
> Finally, the defconfigs are cleaned up by moving the debug UART
> definitions to config fragments (since it doesn't make sense to have
> them enabled by default anyway) and remove CONFIG_REMAKE_ELF. Notably,
> the qcs9100_defconfig is removed entirely since the same binary can
> be created with just make arguments. This platform entirely lacked
> documentation to begin with, which should be addressed by future
> patches.
> 
> The Qualcomm documentation is also cleaned up, a new "signing" page
> is added to briefly cover the what and why of MBN signing, and board
> specific pages are updated to explain the new build process.
> 
> These patches have been tested on the RB3 Gen 2, but additional
> testing for other platforms would be super useful.
> 
> [1]: https://github.com/msm8916-mainline/qtestsign
> 
> To: Tom Rini <trini@konsulko.com>
> To: Neil Armstrong <neil.armstrong@linaro.org>
> To: Sumit Garg <sumit.garg@kernel.org>
> Cc: u-boot@lists.denx.de
> Cc: u-boot-qcom@groups.io
> Cc: Varadarajan Narayanan <quic_varada@quicinc.com>
> Cc: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
> Cc: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
> 
> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
> ---
> Changes in v4:
> - Rework how qtestsign code is imported to make it easier to sync with upstream in the future.
> - Actually raise an exception when mkmbn fails in an unexpected way.
> - Link to v3: https://lore.kernel.org/r/20250612-b4-qcom-tooling-improvements-v3-0-76f34cf216e2@linaro.org
> 
> Changes in v3:
> - Fixup Makefiles and add missing qcom-binman.dts
> - Adjust wording to reflect changes to build process
> - Link to v2: https://lore.kernel.org/r/20250602-b4-qcom-tooling-improvements-v2-0-c7d19c0d4a8b@linaro.org
> 
> Changes in v2:
> - Reworked to use binman with a plugin to build the u-boot.mbn file
> - Added some fixes for binman to work with OF_UPSTREAM and with tools
>    in the srctree toolpath rather than objtree for out of tree builds.
> - Link to v1: https://lore.kernel.org/r/20250522-b4-qcom-tooling-improvements-v1-0-8141b8955cfb@linaro.org
> 
> ---
> Casey Connolly (8):
>        binman: add $(srctree)/tools to toolpath
>        binman: support building binman dtb when OF_UPSTREAM is enabled
>        tools: qcom: introduce mkmbn library
>        tools: qcom: add mkmbn.py
>        binman: add support for building Qualcomm signed MBN ELF images
>        configs: qualcomm: use fragments for debug UART
>        qualcomm: use mkmbn via binman and stop creating ELF files
>        doc: board/qualcomm: update docs for new u-boot.mbn target
> 
>   Makefile                            |   5 +
>   arch/arm/Kconfig                    |   1 +
>   arch/arm/dts/qcom-binman.dts        |  16 ++
>   board/qualcomm/debug-qcm6490.config |   5 +
>   board/qualcomm/debug-qcs9100.config |   5 +
>   configs/qcm6490_defconfig           |  10 --
>   configs/qcom_defconfig              |   2 +
>   configs/qcom_ipq9574_mmc_defconfig  |   1 -
>   configs/qcs9100_defconfig           |  10 --
>   doc/board/qualcomm/index.rst        |   1 +
>   doc/board/qualcomm/rb3gen2.rst      |  27 ++--
>   doc/board/qualcomm/rdp.rst          |   5 +-
>   doc/board/qualcomm/signing.rst      |  29 ++++
>   dts/Makefile                        |  19 ++-
>   tools/binman/btool/mkmbn.py         |  29 ++++
>   tools/binman/etype/u_boot_mbn.py    |  53 +++++++
>   tools/mkmbn                         |   1 +
>   tools/qcom/mkmbn/cert.py            | 127 ++++++++++++++++
>   tools/qcom/mkmbn/elf.py             | 238 ++++++++++++++++++++++++++++++
>   tools/qcom/mkmbn/hashseg.py         | 281 ++++++++++++++++++++++++++++++++++++
>   tools/qcom/mkmbn/mkmbn.py           | 154 ++++++++++++++++++++
>   21 files changed, 981 insertions(+), 38 deletions(-)
> ---
> base-commit: 783f365c9dbb5c9e9341753fbad6a44dcdc7a069
> change-id: 20250522-b4-qcom-tooling-improvements-ab40585b11a1
> 
> Casey Connolly <casey.connolly@linaro.org>
> 

-- 
Casey (she/they)

