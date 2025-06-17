Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC9D7C71157
	for <u-boot@archiver.kernel.org>; Tue, 17 Jun 2025 09:15:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E30D681E18;
	Tue, 17 Jun 2025 11:15:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="s7wTLZb9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B664A82977; Tue, 17 Jun 2025 11:15:43 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4AB7780C83
 for <u-boot@lists.denx.de>; Tue, 17 Jun 2025 11:15:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-45348bff79fso26149135e9.2
 for <u-boot@lists.denx.de>; Tue, 17 Jun 2025 02:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750151740; x=1750756540; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GuzWV4tSF3C5NeXBPto+PaNuvbZR3xzxQJqrKTt+2k4=;
 b=s7wTLZb9DXzG4BZnykOtUlCOwjz1LmUqcIDIWAnimZkS0jZjdttA1B9gvLJS6rLKGF
 KQ4lbqXdBRdtjlT4D1T2iMHHnPEyLhYrBgLdpUWse/xrBhARFyxD/qMaFQSuW5qHGhGR
 TMeHfsWBf97IKqOFyABLIHNZkw2fzdzSu6sc2TgwIb7NOAbC1Q4SBDA2bvNyBxXYE9Xb
 Dp9ROwrocVsofaIoozmeOzgxxq4qV5BoBTZse9+Yts5SnCJH3cbDQCjRFPUdnAshlkFe
 Xj4bC1e4ZCx18U+d03fUKllGJ5DrTwt1pd/jbTz1FMMyWf68DhSMydMwlIDiAHOPBmk5
 WaEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750151740; x=1750756540;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GuzWV4tSF3C5NeXBPto+PaNuvbZR3xzxQJqrKTt+2k4=;
 b=vDZmkJNWzfdQoZdyw5eIKLy3vJiusI4qzTmRzdnjrU5uemAdmyd2BRv2TjL5DUOmfb
 1M9QXG9khtngYCX4HxcEQuSWRiC9nP2K86Gg44BnPyWTqYkmlLcLXrEqgbrNAz7E1Yxp
 6qKgOUNHFgVk5Odg1uBUZof/qlYsgSQAtk7XWgtMa9I762hMoMDHxZ3VfkeiLrMKWCaO
 Yp/tL3F3H8DmWy/LzBn7pnQiEATG7y9cPgaP2IjWkmo/zCrhrpFscQX/4MkJ0UhaODp1
 ikFVCwkVX5vWTfMG0ty0tO/ev2gjIag20/SqgU0l0BvNaoCfxlF2HM+C2DoYpqHcOJpd
 3erg==
X-Gm-Message-State: AOJu0YwWr6XmRkZDn4N8PGJ2fV3pgUIAKlp9ybrFjj9VsAxLRjcjX4fL
 VtBCSRtcAeUxC3WVFfWAnM/bFa3YOB4D0IaPnHyFLUAAvhiurmeL4uQzFX/obRsmrIg=
X-Gm-Gg: ASbGncvSgfGjxlvuhM9OC+lDCE5dd8zgtEvbdbRGr7zWnUDEjl2CswGBjOBuPDyY+Yb
 YoPwhCvHuDAnhuu6JoJj5KLx0G7R6ExpcXiOi84QS8d96LwGX4r6IvK5VyclBzZeZpx8aV6hkPy
 aG/mLS1wo3Ws4HMHOcFydJxOI1wrXKZy5dd/CIrZuNpRMBr9ii8fnc8R4YgbrZbGPqal50DJbzJ
 eXZdX4T+P7zwlCUGtgVuruHy0FQT37lq2H0/FYaMBUT4uNAiZcY+FblRpJCZTs7iZWgYNORYqu7
 LGc/nH///aTzsc5BwQsNw8NFTbDn0NJgGlsh9NPpmJefLMk8/J0zk4lh0HTJ2xeCLaoKnmdZNQ3
 b
X-Google-Smtp-Source: AGHT+IHgf0mIXm9y6DrjBCZt26xKkDibV0LbbwrgkwOZfA9tqZUVIiWSM0TOLX7oZgxGljOLqDxbXA==
X-Received: by 2002:a5d:5f96:0:b0:3a5:2fb2:35ac with SMTP id
 ffacd0b85a97d-3a5723a182cmr10081215f8f.24.1750151739584; 
 Tue, 17 Jun 2025 02:15:39 -0700 (PDT)
Received: from [192.168.1.104] ([213.240.182.76])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4532e172b03sm168731225e9.36.2025.06.17.02.15.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Jun 2025 02:15:38 -0700 (PDT)
Message-ID: <bf53c55b-b554-4a1e-9edd-043a02523e03@linaro.org>
Date: Tue, 17 Jun 2025 11:15:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/8] Qualcomm: teach the build system to emit signed
 ELF images
To: Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini
 <trini@konsulko.com>, Sumit Garg <sumit.garg@kernel.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io,
 Varadarajan Narayanan <quic_varada@quicinc.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>
References: <20250613-b4-qcom-tooling-improvements-v4-0-7ea1c68779fa@linaro.org>
 <aa490fb0-e485-4227-8750-70c66c308bd5@linaro.org>
 <6da50198-445e-4e50-b2ec-97a385c5b2eb@linaro.org>
Content-Language: en-US
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <6da50198-445e-4e50-b2ec-97a385c5b2eb@linaro.org>
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
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean



On 6/17/25 10:26, Neil Armstrong wrote:
> On 16/06/2025 18:13, Casey Connolly wrote:
>> Hi Tom,
>>
>> So I've been testing this a bit harder (really should have noticed 
>> this sooner) and it turns out using binman makes things a whole lot 
>> more complicated...
>>
>> Specifically, the new trogdor chromebook board doesn't need binman, 
>> the U-Boot ELF is used directly since they have their own bootloader 
>> beforehand.
>>
>> But since CONFIG_BINMAN can't be enabled in a defconfig and only 
>> selected by some other Kconfig there isn't really a nice way to handle 
>> this. The trogdor board doesn't add any Kconfigs of it's own and doing 
>> something like
>>
>> depends on BINMAN if !CONFIG_SYS_COREBOOT
>>
>> would be a huge hack...
> 
> Can't you change to depends on BINMAN if CONFIG_BINMAN_DTB ?

No, since this creates a recursive dependency

> 
>>
>> This wouldn't be an issue in and of itself, but binman makes the build 
>> fail since of course the DT doesn't have a binman node and the trogdor 
>> defconfig doesn't define CONFIG_BINMAN_DTB (and shouldn't have to...).
>>
>> Possibly the easiest solution would be to allow defconfigs to set 
>> CONFIG_BINMAN, or add some additional kconfig we can use to pull it in 
>> (CONFIG_QCOM_BUILD_MBN ?), maybe the latter is the most comprehensible 
>> solution.
>>
>> I think I'll go with that unless anyone can chime in with some other 
>> suggestions.
>>
>> Kind regards,
>>
>> On 6/13/25 19:23, Casey Connolly wrote:
>>> With several new Qualcomm platforms appearing on the mailing list, all
>>> of which build U-Boot as an ELF, sign it, and then flash it to some
>>> partition on the board, we're getting a lot of defconfigs which just
>>> contain a debug UART and a TEXT_BASE address. This leads to needless
>>> rebuilds in CI of effectively the same image, and needless duplication
>>> of build instructions.
>>>
>>> To address this, let's introduce a new tool "mkmbn.py", this is based
>>> on the existing qtestsign[1] tool but is (currently) hardcoded to
>>> only handle the Dragonwing and IPQ boards which use MBN header v6.
>>> Additionally, the tool contains a lookup table that maps from a boards
>>> DT compatible property to the load address it needs. Since it's highly
>>> unusual for different boards using the same SoC to have different load
>>> addresses, generic platform matching is also done (e.g. "qcom,qcm6490").
>>>
>>> With this tool in place, we teach binman to use it and introduce
>>> a qcom-binman.dts file to describe the image. The tool will emit a
>>> u-boot.mbn file for supported platforms, for unsupported platforms the
>>> u-boot MBN etype in binman will print a notice explaining that no mbn
>>> file is built and to look at tools/qcom/mkmbn/mkmbn.py
>>>
>>> Finally, the defconfigs are cleaned up by moving the debug UART
>>> definitions to config fragments (since it doesn't make sense to have
>>> them enabled by default anyway) and remove CONFIG_REMAKE_ELF. Notably,
>>> the qcs9100_defconfig is removed entirely since the same binary can
>>> be created with just make arguments. This platform entirely lacked
>>> documentation to begin with, which should be addressed by future
>>> patches.
>>>
>>> The Qualcomm documentation is also cleaned up, a new "signing" page
>>> is added to briefly cover the what and why of MBN signing, and board
>>> specific pages are updated to explain the new build process.
>>>
>>> These patches have been tested on the RB3 Gen 2, but additional
>>> testing for other platforms would be super useful.
>>>
>>> [1]: https://github.com/msm8916-mainline/qtestsign
>>>
>>> To: Tom Rini <trini@konsulko.com>
>>> To: Neil Armstrong <neil.armstrong@linaro.org>
>>> To: Sumit Garg <sumit.garg@kernel.org>
>>> Cc: u-boot@lists.denx.de
>>> Cc: u-boot-qcom@groups.io
>>> Cc: Varadarajan Narayanan <quic_varada@quicinc.com>
>>> Cc: Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
>>> Cc: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
>>>
>>> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
>>> ---
>>> Changes in v4:
>>> - Rework how qtestsign code is imported to make it easier to sync 
>>> with upstream in the future.
>>> - Actually raise an exception when mkmbn fails in an unexpected way.
>>> - Link to v3: https://lore.kernel.org/r/20250612-b4-qcom-tooling- 
>>> improvements-v3-0-76f34cf216e2@linaro.org
>>>
>>> Changes in v3:
>>> - Fixup Makefiles and add missing qcom-binman.dts
>>> - Adjust wording to reflect changes to build process
>>> - Link to v2: https://lore.kernel.org/r/20250602-b4-qcom-tooling- 
>>> improvements-v2-0-c7d19c0d4a8b@linaro.org
>>>
>>> Changes in v2:
>>> - Reworked to use binman with a plugin to build the u-boot.mbn file
>>> - Added some fixes for binman to work with OF_UPSTREAM and with tools
>>>    in the srctree toolpath rather than objtree for out of tree builds.
>>> - Link to v1: https://lore.kernel.org/r/20250522-b4-qcom-tooling- 
>>> improvements-v1-0-8141b8955cfb@linaro.org
>>>
>>> ---
>>> Casey Connolly (8):
>>>        binman: add $(srctree)/tools to toolpath
>>>        binman: support building binman dtb when OF_UPSTREAM is enabled
>>>        tools: qcom: introduce mkmbn library
>>>        tools: qcom: add mkmbn.py
>>>        binman: add support for building Qualcomm signed MBN ELF images
>>>        configs: qualcomm: use fragments for debug UART
>>>        qualcomm: use mkmbn via binman and stop creating ELF files
>>>        doc: board/qualcomm: update docs for new u-boot.mbn target
>>>
>>>   Makefile                            |   5 +
>>>   arch/arm/Kconfig                    |   1 +
>>>   arch/arm/dts/qcom-binman.dts        |  16 ++
>>>   board/qualcomm/debug-qcm6490.config |   5 +
>>>   board/qualcomm/debug-qcs9100.config |   5 +
>>>   configs/qcm6490_defconfig           |  10 --
>>>   configs/qcom_defconfig              |   2 +
>>>   configs/qcom_ipq9574_mmc_defconfig  |   1 -
>>>   configs/qcs9100_defconfig           |  10 --
>>>   doc/board/qualcomm/index.rst        |   1 +
>>>   doc/board/qualcomm/rb3gen2.rst      |  27 ++--
>>>   doc/board/qualcomm/rdp.rst          |   5 +-
>>>   doc/board/qualcomm/signing.rst      |  29 ++++
>>>   dts/Makefile                        |  19 ++-
>>>   tools/binman/btool/mkmbn.py         |  29 ++++
>>>   tools/binman/etype/u_boot_mbn.py    |  53 +++++++
>>>   tools/mkmbn                         |   1 +
>>>   tools/qcom/mkmbn/cert.py            | 127 ++++++++++++++++
>>>   tools/qcom/mkmbn/elf.py             | 238 +++++++++++++++++++++++++ 
>>> +++++
>>>   tools/qcom/mkmbn/hashseg.py         | 281 +++++++++++++++++++++++++ 
>>> +++++++++++
>>>   tools/qcom/mkmbn/mkmbn.py           | 154 ++++++++++++++++++++
>>>   21 files changed, 981 insertions(+), 38 deletions(-)
>>> ---
>>> base-commit: 783f365c9dbb5c9e9341753fbad6a44dcdc7a069
>>> change-id: 20250522-b4-qcom-tooling-improvements-ab40585b11a1
>>>
>>> Casey Connolly <casey.connolly@linaro.org>
>>>
>>
> 

-- 
Casey (she/they)

