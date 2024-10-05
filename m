Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BB06CF8868
	for <u-boot@archiver.kernel.org>; Sat,  5 Oct 2024 01:44:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7587488B99;
	Sat,  5 Oct 2024 03:44:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1728092693;
	bh=SfkQ7lPnuH681v9ORVLm3QZ7w4UFC+OdZ4Hrm+ixRSw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fmLHGUbxwd5UvybihSp/ZJZbc9B3kdqz73Xy53W8JLA6H7a1TJMARlZ40vsDuam+M
	 frDoiyOn2rbit2/dlW2QdE+ltb6o9vLnAdOSBBgNdsvYwfSEdGEmMYYlGLfPBIY6kr
	 PDV/7+PmePgl3sIBiDPDwY3zeQxnXQJYzXc0e3ddpioc/MKZmLJ/X3k6qmCpkMy7yn
	 Rl5YwdEGWUYk9CyeZUlz2vHT1Fw0YjpqOzIPYr4uP2WOawvsBk/9FsnptPJqPQpon9
	 4MjyLLmo2V/5sHX4sfP6RwvhjWLuQdFJQZnnQrWqW5K3YLN8qDRL5t8XIMfTGw4FrI
	 zDnWnUfEjBWrQ==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id B857D88A1B;
 Sat,  5 Oct 2024 03:44:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1728092692;
 bh=SfkQ7lPnuH681v9ORVLm3QZ7w4UFC+OdZ4Hrm+ixRSw=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=B3jultQ3XQ2CtMLBH8twIKTEMJrprKtJUeMOMHrrL+CcuxwAhwZUu/O9CxFS0TqH2
 3V5RgKxXq5Lw292RGVD1sMF2QuJJm92RB313+9ZHQI5mDu1hLGyhBII22OwYDpAv3m
 syE0Nk89ATKsQQm2eebDrlX43V9rvOgfKJdvbdrnmv6E2/kzRtZRCEBKK66ONqpfLw
 4w7uyqMuhCNcumvnOxTpsvT3y2o0LuAjkGASsjXfMrVyHWd/q5wclzh6qIjwNxBaN9
 Y/6633+I4ucTuYZxn3qxCi2LPDPDwvPP8zGrgsjXXj1TTgRL2RGuOGPRRN7nobb1v2
 6QZACGDuFxRtQ==
Message-ID: <91b1de6d-b686-4f21-86c2-f5a3bef8c56c@denx.de>
Date: Sat, 5 Oct 2024 03:23:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] ARM: dts: socfpga: add Enclustra Intel AA1
To: Lothar Rubusch <l.rubusch@gmail.com>, Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, trini@konsulko.com,
 simon.k.r.goldschmidt@gmail.com, tien.fong.chee@intel.com
References: <20240912060649.190-1-l.rubusch@gmail.com>
 <20240912060649.190-3-l.rubusch@gmail.com>
 <bf99c2bd-f43c-4041-907f-f60b42163cce@denx.de>
 <CAFXKEHbOpv4g5LZ4dkUpwo1OBrRQ7YKZf10=S-2HqMtSK_OE9g@mail.gmail.com>
 <e294ce74-9b77-4de0-b7fc-0d8db9f1226f@denx.de>
 <CAFXKEHZVJiLO_qsy8wtRS9BAs4SG8crTXjoJxwgN45a8GP+JKg@mail.gmail.com>
 <57a00da7-ec38-4c3a-8e5a-b44929358337@denx.de>
 <CAFXKEHYvNC5WKphy2LZ=w5tSv_0W3DM4BjSgT821RY5wsYB1jQ@mail.gmail.com>
 <ac106ee6-d8b8-45d5-a344-85aede3e7c1c@denx.de>
 <CAFXKEHZCtXeJupi1H+V8pgumBe8m1Vgdg5-OrQ870H-_nSbJhA@mail.gmail.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAFXKEHZCtXeJupi1H+V8pgumBe8m1Vgdg5-OrQ870H-_nSbJhA@mail.gmail.com>
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

On 9/29/24 9:19 PM, Lothar Rubusch wrote:
> On Sun, Sep 29, 2024 at 6:55 PM Marek Vasut <marex@denx.de> wrote:
>>
>> On 9/28/24 12:47 AM, Lothar Rubusch wrote:
>>
>> [...]
>>
>>>>> Ideally I like to setup some Kconfig choice for base board selection
>>>>> and one for boot-mode.
>>>>
>>>>> 1.) In the documentation control.rst I read that the u-boot.dts is
>>>>> combined of several elements. Is there a way to take this base .dts,
>>>>> then add a base board .dtsi by Kconfig option, and similar a
>>>>> boot-mode?
>>>>
>>>> The -u-boot.dtsi is preprocessed by C preprocessor, just like all the
>>>> other DTs, so you can have a -u-boot.dtsi file which contains C
>>>> preprocessor conditional statements in it to conditionally include other
>>>> .dtsi files:
>>>>
>>>> #if IS_ENABLED(...)
>>>> #include ...
>>>> #else ...
>>>> ...
>>>> #endif
>>>
>>> Going through the include list setup by the Makefile made me find my
>>> mistake. Currently I may use u-boot specific stuff in arch/arm/dts and
>>> include generic .dtsi fragments from dts/upstream. Note: I'm not
>>> setting CONFIG_OF_UPSTREAM since I'm using the regular include list
>>> which already contains dts/upstream/src/arm/intel. Is this ok? Or,
>>> shall I try a different approach, which involves having
>>> CONFIG_OF_UPSTREAM explicitely set in the defconfig?
>>
>> I'm not quite sure I understand the question. Once this platform DTs
>> land in mainline and the DTs get synchronized into U-Boot, you should
>> then set CONFIG_OF_UPSTREAM. Until then, you could patch the DTs into
>> dts/upstream/ to test the result with OF_UPSTREAM enabled .
>>
> 
> Ah, sorry. I did not explain well. Currently I patch the DTs which
> should go to kernel/mainline into my local u-boot:
> dts/upstream/src/arm/intel/socfpga/ as a preparation for my test
> builds.

OK

> For U-boot I will need to build a devicetree file from archarm/dts. I
> cannot rely just on the upstream fragments for u-boot. Imagine
> settings like initial fpga bitstream loading, handoff file setup for
> initialization, etc. In parts I may use .dtsi files from dts/upstream,
> though, but most of the u-boot particular devicetree setup will reside
> in arch/arm/dts, I guess (you may see later in the patches).

You should be able to use dts/upstream/src/arm/intel/socfpga/ with 
-u-boot.dtsi from arch/arm/dts/ for this purpose, right ?

> I noticed when setting the option CONFIG_OF_UPSTREAM in `make
> menuconfig`, it prepends `dts/upstream/` to the included paths of the
> devicetree files. The resulting path for the .dts was then
> dts/upstream/arch/arm/dts/ and could not be found anymore. When I
> don't activate CONFIG_OF_UPSTREAM, dts/upstream is in the Makefile's
> include list anyway so that I easily can include from both locations.

+CC Sumit

> In conclusion, currently I'm calling a .dts for building the u-boot DT
> from arch/arm/dts. The file includes upstream stuff as .dtsi fragment
> from dts/upstream and handoff from local. CONFIG_OF_UPSTREAM does not
> seem to be necessary in this case.
> 
> This approach currently works for me. If you strongly disagree, I may
> invest more time to find a way (or why there is currently no way) with
> CONFIG_OF_UPSTREAM.
> 
> This was my question about. Anyway you may wait on v3 to understand
> better in source what I'm doing, or if I'm just messing around.
I'll wait for V3, sure, good luck.

Sorry for the delayed reply.
