Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAEFFCD8C8E
	for <u-boot@archiver.kernel.org>; Sun,  7 Jun 2026 14:56:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6468846A3;
	Sun,  7 Jun 2026 16:56:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="w5Y5UUNp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 083EC83EF9; Sun,  7 Jun 2026 16:48:33 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8207801A9
 for <u-boot@lists.denx.de>; Sun,  7 Jun 2026 16:48:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-490b2b037d2so29970475e9.3
 for <u-boot@lists.denx.de>; Sun, 07 Jun 2026 07:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780843709; x=1781448509; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+vHgED7S3GQFbDhylHFr78mB/dSmuJ1JqNS7bDPruHQ=;
 b=w5Y5UUNp701BshsbKRbEH31PMfPuxqVekZXW0eB4k2qR65ml9RBuu2h06qfI/t1QNN
 6jm2iWwwZ35PtEEEFZeaZbpT/Xzn47kTK0qXVspO3RCWnEzb+DJqlbSwfdyJblMXAslV
 6nctS/HHClaiH8DLBHAhoEMtTYzBFcCgNXOijkf2ZW4L5VijUA1zrLnurqlNFr4T98/H
 8rMwytmO757Tq3gMedOCjLlyeqJiNaVVJCmsbzNvcqsu7/h7UcfU05nkjuXexW1m9tKk
 5gXFjOi8+UUXaqMVQCsbaRWtyXc0jJUS9QEuhM60P60Nu1j5stKWcx282AoaNccJmQh4
 3Ycg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780843709; x=1781448509;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+vHgED7S3GQFbDhylHFr78mB/dSmuJ1JqNS7bDPruHQ=;
 b=JkU8cihThMo9MTS3GQC59XujfPgmho51LOuog/Jh7mCxA5G8fRjKzkWWLD2BDg4C9P
 OVeI2TcKzYuJd1mgMrvHvGIqbXEFe8SYJeF04+ZCN/3BqevxsK7+6GTE79YkJXdK013H
 1r5M8fTFuFVRcEAadxTXzDBqpQtzU9DNDOLSYlQtgB2Jtsxf/1mv4/P8XdwuLCn9D2qL
 K/Yq/CmrHHpaCSoMWXUYXj0Ap4OK4Ub3WBntctjF8tXiWhLc06/uffKLwPYaNhdwQLiW
 +8lONz4KBGLo7d2GLuP/iPCVh6tuUGSyEQpP0U6JRamS+Hy08KotSjEuqGq/bLBpEa+h
 WIkA==
X-Gm-Message-State: AOJu0Yx3XJ4rFdnYRR3lrj/Ie0eSUVM3T6yHgL8HSYDs59t2iinBeQC6
 /floIC5NVLqm5oxYGWdPdK/RYEXmyNwME3hJuDni2Skt1XgrNzn0yAVL5X0mE4e96FU=
X-Gm-Gg: Acq92OGhsdJWcaOTGimQDqmBFcC+zSHKAwUTrVYF3rymjQMgmlNlJiwiT1ZRQphVFA3
 w4QG4NsCAb+5lIoayvc3pxO2K1Nre+xO6wN5VwYJUiQAIj9zm9O8JYbBazaWOgjN/0T3X9a3Tgn
 SS9r0pk5JL7CVq+jWEJYEx3+WMHrVArEYcCNMXm1VjZHq34EqnSSKWMe5fTBy1gIVO2nPcBsSTx
 fnqXzN8NqEo616g/dPnA+xQuW3onZCVEfJ+15binuSNX6UC++3qYc0aPcRG34ruc2xXFVLQny7W
 FOGsyDUAsJjW0kNhz3rD5ek1F+zz9SDibn3fh+ThXZOhCArJ2uKrwtg27OgJjptVcUCflNpwQJU
 v2QUMotckRXW/DudphHNEVyFDFL+eQbqpMGm2CcAJmizBWS3BnNfcCFY3aYvSsMxyJNGXlzDwaK
 AzZcZ3VXvuMBvVkX+ZY99kqqhz9RVRhWPCtIqOGVO2+9Cidrgur4B+c/O3GmVNp8CfSNkSzwndS
 xkeqSWuDcBAYedcXf3Q2te4
X-Received: by 2002:a05:600c:4708:b0:48a:6fd4:d3d3 with SMTP id
 5b1f17b1804b1-490c2604735mr192755595e9.20.1780843709222; 
 Sun, 07 Jun 2026 07:48:29 -0700 (PDT)
Received: from [172.18.178.88] (195-200-21-10.mclarenap.oninferno.net.
 [195.200.21.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490bc39eb04sm321768155e9.6.2026.06.07.07.48.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 07 Jun 2026 07:48:28 -0700 (PDT)
Message-ID: <bd859b0f-45df-45e5-abb2-99076d503a59@linaro.org>
Date: Sun, 7 Jun 2026 16:48:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/13] Generate Android boot images with binman
To: Sam Day <me@samcday.com>
Cc: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>,
 u-boot-qcom@groups.io, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Bryan Brattlof <bb@ti.com>,
 Yannic Moog <y.moog@phytec.de>, Wojciech Dubowik <Wojciech.Dubowik@mt.com>,
 Yegor Yefremov <yegorslists@googlemail.com>, Denis Mukhin
 <dmukhin@ford.com>, Rasmus Villemoes <ravi@prevas.dk>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Javier Tia <floss@jetm.me>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Peng Fan <peng.fan@nxp.com>,
 Anshul Dalal <anshuld@ti.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Tingting Meng <tingting.meng@altera.com>, Alice Guo <alice.guo@nxp.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Minkyu Kang <mk7.kang@samsung.com>,
 Kaustabh Chakraborty <kauschluss@disroot.org>,
 Henrik Grimler <henrik@grimler.se>
References: <20260606-android-binman-v1-0-c7a3c14b8a3d@samcday.com>
 <e21e557b-1573-472f-9666-2bffdb0f4e86@linaro.org>
 <tIT4bs5x6xJ7santHOgWRakaoZ-AJjcaxOX4BW8jop3rcmOLVy8kooUuTmH1QJViVTgyHjeSiP9TvRiH_zcwYTMB63CogsgYT61ORUBllYA=@samcday.com>
Content-Language: en-US, en-GB
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <tIT4bs5x6xJ7santHOgWRakaoZ-AJjcaxOX4BW8jop3rcmOLVy8kooUuTmH1QJViVTgyHjeSiP9TvRiH_zcwYTMB63CogsgYT61ORUBllYA=@samcday.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Sun, 07 Jun 2026 16:56:44 +0200
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

Hi Sam,

On 6/7/26 01:05, Sam Day wrote:
> Salutations Casey,
> 
> On Saturday, 6 June 2026 at 10:03 PM, Casey Connolly <casey.connolly@linaro.org> wrote:
> 
>> Hi Sam,
>>
>> On 6/6/26 02:52, Sam Day via B4 Relay wrote:
>>> U-Boot is seeing increasing adoption on pocket computers, many of which
>>> (sadly) have fused bootloader chains. Many of these bootloaders have a
>>> very rigid definition of what a "valid" downstream payload looks like.
>>> Sometimes it's just a boring old v0/v2 Android boot image. Sometimes
>>> it's something decidedly more grotesque.
>>>
>>> To date, this last-mile packaging step has been trapped in downstream CI
>>> pipelines, blogposts, documentation, etc. This patch series aims to
>>> gather up all that esoterica and institutional knowledge and codify it
>>> in U-Boot's build system, using binman.
>>
>> Awesome!!! :D
>>
>> So happy to see this being worked on, it's a huge benefit to have this
>> here in the build system.
>>
>> That said, I think we need a bit of discussion around binman, I
>> previously worked on using it for teaching the build system to emit .mbn
>> files (see [1]), in the end getting binman to co-operate was a bunch of
>> really annoying work and I wound up with a sub-par result.
> 
> Yes, I saw that series. I tried to engage you on Matrix about it a few days ago
> to get a sense for why you felt that binman was unsalvageable. I should have
> engaged you properly here on the list, that's my bad.
> 
>>
>> The new approach which made a whole lot more sense is to use a vendor
>> Makefile fragment to add a custom build target, skip dealing with binman
>> and just have the necessary info in Python (since adding a table entry
>> to a Python script is really no different to adding a binman DTB node).
>> That's in [2].
> 
> I would prefer to use binman. It's already well documented. It's already in
> use by countless other boards in U-Boot. I prefer maintaining DTSI's for the
> configuration DSL than some Python dicts. Also, at some point once enough
> devices have their native Android boot artifact described, there will be
> clear patterns that can be neatly tucked away into shared DTSI fragments.

 From my side, binman is a no-go for a bunch of reasons, polluting the 
device dtb being a big one, the ability to debug and maintain it is also 
not something i feel particularly confident about. Hence having a 
standalone tool would be the appropriate way to go for this, I really 
want to avoid having to learn this bespoke overly complex build tooling 
when it's selling points aren't things that have much value for Qualcomm.

> 
>>
>> I'm really not in favour of adding a binman node to the DTB that U-Boot
>> uses, and I think it's kinda dumb that this is the only sensible way to
>> configure binman today...
> 
> I see nothing wrong with that. Can you expand on your concerns a little more?

It really just goes against the goal of using upstream DT. Previously I 
managed to get binman to parse its config from a separate DTB but that 
was hellish to integrate the tooling for.

Having this random node at runtime for completely unnecessary arbitrary 
reasons feels just wrong to me.

> 
>>
>> The way that mkmbn works is it just has all the device-specific config
>> in a dictionary where the key is the compatible string, it finds the DTB
>> in the U-Boot image and gets the appropriate mbn config from there.
>>
>> I see you've clearly put a lot of effort into this, and I hate to ask
>> you to do a lot more, but I'd really like to avoid using binman, would
>> you be willing to rework this to put the config in Python and just have
>> a custom make target like in the mkmbn patches? You can probably base it
>> on top.
> 
> I'm definitely not interested in doing that. I would, however, be very willing
> to address any specific concerns you have with binman.

That's a shame to hear>
> At any rate, if you want to NAK any binman usage in the qualcomm side, that's
> fair enough. Please let me know if you see absolutely no path forward, and I'll
> split the series to just focus on the binman etype impls and their usage on
> the Exynos side. That would be a bummer, but I'm intending to maintain a
> long-lived close-to-mainline downstream anyway, so I would continue widening
> the support there and hope that your opinion on binman changes in future :D

I don't feel comfortable depending on binman for Qualcomm, so we'll 
leave it there.

Kind regards,
// Casey>
>>
>> This way it avoids the need to add stuff to the dtb, you can just parse
>> `u-boot.dtb` to determine the device and pick the right config.
>>
>> [1]:
>> https://lore.kernel.org/u-boot/20250722-b4-qcom-tooling-improvements-v5-0-df143f1247fc@linaro.org/
>>
>> [2]:
>> https://lore.kernel.org/u-boot/20260511-b4-qcom-tooling-improvements-v7-0-0c06346e79a9@linaro.org/
> 
> I wonder if maybe the ELF wrangling in particular was cursed? I had absolutely
> no issues using binman and getting it to produce native binaries for a
> half-dozen disparate devices.
> 
> Cheers,
> -Sam
>>
>>>
>>> Put differently: an overwhelming majority of these pocket computer
>>> devices have a "canonical" payload format that U-Boot currently has no
>>> support for. Let's fix that.
>>>
>>> The first patches in this series introduce an `android_boot` etype. To
>>> begin with, this is a "typical" abootimg, as defined by canonical AOSP
>>> sources and reference `fastboot`/`mkbootimg` implementation. There's
>>> plenty of devices out there with a sane(-ish, nothing in Android-land is
>>> ever truly sane) bootloader that will happily chain a U-Boot rolled into
>>> the kernel section of an abootimg.
>>>
>>> With that out of the way, the cursed bootloaders are next to be
>>> supported. Binman etypes for Qualcomm's "QCDT" and Samsung's "DTBH"
>>> formats are implemented. These are non-standard vendor-specific
>>> devicetree containers, which the previous bootloader uses to pick a FDT
>>> to boot the downstream with.
>>>
>>> In both cases, these vendor-specific formats are tacked on to the end of
>>> a v0 abootimg, with the header_version being hijacked to encode the
>>> length of this following payload. Thus, the android_boot etype is
>>> retrofitted to allow these shenanigans.
>>>
>>> Binman configs that produce flashable boot artifacts are introduced for
>>> the following devices:
>>>
>>>    * google-sargo (vanilla v2)
>>>    * oneplus-fajita (vanilla v2)
>>>    * samsung-a5u-eur (QCDT v0)
>>>    * samsung-gt510 (QCDT v0)
>>>    * samsung-j7xelte (DTBH v0)
>>>
>>> I also successfully tested a vanilla v0 on my samsung-expressltexx, in
>>> conjunction with the qcom-armv7 series already on the list. However,
>>> since that work is still in-flight and the expressltexx DTS is
>>> downstream, I opted not to include it here.
>>>
>>> Signed-off-by: Sam Day <me@samcday.com>
>>> ---
>>> Sam Day (13):
>>>         binman: Android boot image support
>>>         .gitignore: ignore binman-generated blobs
>>>         arch: arm: qcom: google-sargo binman config
>>>         qcom: arch: arm: qcom: sdm845-fajita binman configs
>>>         mach-snapdragon: enable BINMAN
>>>         binman: android_boot: vendor-dt support
>>>         binman: Add QCDT support
>>>         binman: android_boot: SEANDROIDENFORCE support
>>>         arch: arm: qcom: samsung-a5u-eur binman config
>>>         arch: arm: qcom: samsung-gt510 binman config
>>>         binman: Add DTBH support
>>>         arch: arm: exynos: add j7xelte binman config
>>>         configs: exynos-mobile: pull in BINMAN
>>>
>>>    .gitignore                                         |   1 +
>>>    arch/arm/Kconfig                                   |   1 +
>>>    arch/arm/dts/exynos-mobile.dtsi                    |   5 +
>>>    arch/arm/dts/exynos7870-j7xelte-u-boot.dtsi        |  24 ++
>>>    arch/arm/dts/msm8916-samsung-a5u-eur-u-boot.dtsi   |  39 ++
>>>    arch/arm/dts/msm8916-samsung-gt510-u-boot.dtsi     |  39 ++
>>>    arch/arm/dts/qcom.dtsi                             |   5 +
>>>    arch/arm/dts/sdm670-google-sargo-u-boot.dtsi       |  27 ++
>>>    arch/arm/dts/sdm845-oneplus-fajita-u-boot.dtsi     |  25 ++
>>>    arch/arm/mach-exynos/Kconfig                       |   1 +
>>>    configs/exynos-mobile_defconfig                    |   1 +
>>>    configs/qcom_defconfig                             |   1 +
>>>    tools/binman/etype/android_boot.py                 | 408 +++++++++++++++++++++
>>>    tools/binman/etype/dtbh.py                         | 173 +++++++++
>>>    tools/binman/etype/qcdt.py                         | 160 ++++++++
>>>    tools/binman/ftest.py                              | 127 +++++++
>>>    .../test/vendor/android_boot_seandroidenforce.dts  |  22 ++
>>>    tools/binman/test/vendor/android_boot_v0.dts       |  29 ++
>>>    tools/binman/test/vendor/android_boot_v2.dts       |  46 +++
>>>    .../binman/test/vendor/android_boot_vendor_dt.dts  |  27 ++
>>>    tools/binman/test/vendor/dtbh.dts                  |  29 ++
>>>    tools/binman/test/vendor/dtbh_bad_model_info.dts   |  19 +
>>>    tools/binman/test/vendor/qcdt.dts                  |  20 +
>>>    tools/binman/test/vendor/qcdt_bad_msm_id.dts       |  17 +
>>>    24 files changed, 1246 insertions(+)
>>> ---
>>> base-commit: a4c8728f225b0d7d591fb9199ce7efb72f48290e
>>> change-id: 20260604-android-binman-ad7a43f4e99d
>>>
>>> Best regards,
>>
>>

