Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B114CF6497
	for <u-boot@archiver.kernel.org>; Sun, 29 Sep 2024 16:55:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA13488901;
	Sun, 29 Sep 2024 18:55:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1727628956;
	bh=GQ101h7JlX1B+h78UAoYw6kcd88oF43CgvzdDFwVytM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=j5ibs1cz04QthdCXl2MKTMslvzjNCVf1EG7VAPlwCHBi5G87wSERUafsFQ9XrDZEk
	 2gzOZfdO0NPTolzeBuZ2gQweelY3CNkURwxKseK0ZLneX7mjv+/MDDJ6WJ7TIkQ4IF
	 aqSwPiqtewwBMCEU6BiuIjbnRRRjIsOnv8QlPl0X2og2/mHcY9d0hSP+DAUlnWgCHl
	 njeo79gTzaExCsiTB4+HcaDlok9EhzQmyV1j13U8C6fJgItcEHq0y8/P+QO+bPyzPu
	 2yOK8qxERePnlaNdXWmeg9GwcOEEnv/Hb+teMNuRbdjbN9qqmfYh/Zcq2yvHywkrQH
	 AM7jsBrm1JL9g==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 08E9988753;
 Sun, 29 Sep 2024 18:55:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1727628955;
 bh=GQ101h7JlX1B+h78UAoYw6kcd88oF43CgvzdDFwVytM=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=CdobpLHfTaGdFDu8v/jSjrLy9Mwvdm4QVkNPVwxNyJ/3x++HYsg2FsNouxvO+FlW8
 yE/BgVx2froI+UtF4i5uD+AaSIl3cy/KzyMA01IwDFjQQWh3R5K6H4wjjar3DvxtRx
 rbsUYDklVZRNQGedxYn2XB2f5/WG53vJD+8ZsF6hNhgMVYcpEY8+n3JzPWnZXksip1
 KQglN48k3QWIREsemaIvVWKhSyAtEpAubTiGBG1txU7Sn0jsNur/vsunJV+Wi/Kf4v
 2hX3Gr8GYknpVQ+moUKCDPP7Fl2ybGPLiMBOp2RA6Qa+JSzmZrPRmCr8clq/zMm71L
 jNFF8BHBQMLZA==
Message-ID: <ac106ee6-d8b8-45d5-a344-85aede3e7c1c@denx.de>
Date: Sun, 29 Sep 2024 17:20:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] ARM: dts: socfpga: add Enclustra Intel AA1
To: Lothar Rubusch <l.rubusch@gmail.com>
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
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <CAFXKEHYvNC5WKphy2LZ=w5tSv_0W3DM4BjSgT821RY5wsYB1jQ@mail.gmail.com>
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

On 9/28/24 12:47 AM, Lothar Rubusch wrote:

[...]

>>> Ideally I like to setup some Kconfig choice for base board selection
>>> and one for boot-mode.
>>
>>> 1.) In the documentation control.rst I read that the u-boot.dts is
>>> combined of several elements. Is there a way to take this base .dts,
>>> then add a base board .dtsi by Kconfig option, and similar a
>>> boot-mode?
>>
>> The -u-boot.dtsi is preprocessed by C preprocessor, just like all the
>> other DTs, so you can have a -u-boot.dtsi file which contains C
>> preprocessor conditional statements in it to conditionally include other
>> .dtsi files:
>>
>> #if IS_ENABLED(...)
>> #include ...
>> #else ...
>> ...
>> #endif
> 
> Going through the include list setup by the Makefile made me find my
> mistake. Currently I may use u-boot specific stuff in arch/arm/dts and
> include generic .dtsi fragments from dts/upstream. Note: I'm not
> setting CONFIG_OF_UPSTREAM since I'm using the regular include list
> which already contains dts/upstream/src/arm/intel. Is this ok? Or,
> shall I try a different approach, which involves having
> CONFIG_OF_UPSTREAM explicitely set in the defconfig?

I'm not quite sure I understand the question. Once this platform DTs 
land in mainline and the DTs get synchronized into U-Boot, you should 
then set CONFIG_OF_UPSTREAM. Until then, you could patch the DTs into 
dts/upstream/ to test the result with OF_UPSTREAM enabled .

>>> 3.) What would be the best possibility to have a u-boot.dts with
>>> handoff setup in arch/arm/dts and append .dtsi files from the general
>>> dts/upstream - in case are there other boards are doing something
>>> similar?
>>
>> See above, maybe some of it helps.
> 
> Yes. This helped. I can set base-board and boot mode now by Kconfig
> option with a generic .dts file. Note, it may still take some time,
> since I'd like to test the stuff still a bit on hardware before
> submitting something to the list.

Sure
