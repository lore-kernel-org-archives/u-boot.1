Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C34E0C83F32
	for <u-boot@archiver.kernel.org>; Thu, 31 Aug 2023 10:20:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C94FA8655C;
	Thu, 31 Aug 2023 12:20:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VQsHFwww";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B4DAB8656E; Thu, 31 Aug 2023 12:20:35 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 22D9F8655C
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 12:20:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alpernebiyasak@gmail.com
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-401d67434daso6068595e9.2
 for <u-boot@lists.denx.de>; Thu, 31 Aug 2023 03:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693477232; x=1694082032; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=m4sWkQHAa4Z6ofeDETgOnBbcCGfVfxpvaCqZY7+4P5o=;
 b=VQsHFwww2ejKqnPIHfp5nirGwkZiWNjqgMZ9Oq6KUT2EPKlrCyp4oU2k1fwCnTK4db
 l6Yu6UJn9aiH63dBnr94+kCIOYZefkpVbhr5btZvqbeHnszh+d2dopNzE5mueA7vZLEP
 j845PwwoBnhjb6utDUk+nwS9cYNyP30Wy2+1GU1pPpgtnr7ouMwBFddCwyf+qnde6vJ2
 LE0Hw12rkktajbN4T+N1NqNecQ4LK4UgKKNPae+dHnDgbYiPKPEnqY4Z17f3l0zaqhQi
 nIf08ZxG6KSTjPB97Qalom6huhBOHS5Bs3PthEDu7d34Lks1ZXgagIjSNAyX0JE1IHHP
 m8nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693477232; x=1694082032;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=m4sWkQHAa4Z6ofeDETgOnBbcCGfVfxpvaCqZY7+4P5o=;
 b=hTdaskhkr4BgmwdD2/J9wXit8EA4iu4RCfIoQlHVzjTk3q8rfLXRMomXFlzDejZHBX
 gHQ2KF3LKayeHEa2vWYUn1i5DHmkxt2inUzhtj19znixNgf1GOjZyXxAzS1i/JcqGoD/
 v/f1XQ+JnJEpDvs7S0kEFI/mIhMcbOvN0+rrfDkZ/dAr52+XOCN3d4rrW2Bv1M9NJDP6
 emSbeNOEmleqzLkBmShTtf43BafyLuo25ooShgJrhduhYWApHWgtTiVY+wKkFusUWvJl
 WLFP5rabRc6XOq37CqE7SI0MVMJIyUHd+pCeqn3x3dhfY/WYDPCcCsh9FmqxPp68QiIS
 gLYA==
X-Gm-Message-State: AOJu0YzQSCrqN4nY52TPRYcoXF2xbLJFbotBtaQzVOYwqWQ7yQShsFf0
 +Q3Zkv5a+InoqSddPUSUKxI=
X-Google-Smtp-Source: AGHT+IG6M7KRkvoKt6wjo1NoqAgOf/4/uGrtldDHYF5l8gBOaL+7w9mtPaCYAjKQVxpZdQT5eQqBvQ==
X-Received: by 2002:a05:600c:295:b0:3fb:c9f4:150e with SMTP id
 21-20020a05600c029500b003fbc9f4150emr3872530wmk.14.1693477232261; 
 Thu, 31 Aug 2023 03:20:32 -0700 (PDT)
Received: from [192.168.0.84] ([178.233.24.1])
 by smtp.gmail.com with ESMTPSA id
 u2-20020a05600c00c200b003fe3674bb39sm1497771wmm.2.2023.08.31.03.20.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Aug 2023 03:20:31 -0700 (PDT)
Message-ID: <d4ce17ae-8b84-4c8a-acaa-287549ec23a3@gmail.com>
Date: Thu, 31 Aug 2023 13:20:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] Attempt to enforce standard extensions for build
 output
Content-Language: en-US, tr, en-GB
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Dillon Min <dillon.minfei@gmail.com>,
 Ivan Mikhaylov <fr0st61te@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Kamil Lulko <kamil.lulko@gmail.com>, Marek Vasut <marex@denx.de>,
 Michael Walle <michael@walle.cc>, Neha Malcom Francis <n-francis@ti.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>, Peng Fan
 <peng.fan@nxp.com>, Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Vikas Manocha <vikas.manocha@st.com>, u-boot@dh-electronics.com,
 uboot-stm32@st-md-mailman.stormreply.com,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <20230824030304.1555547-1-sjg@chromium.org>
 <40d6d839-6eaf-4950-bf37-aaad0f2d5e03@gmail.com>
 <CAPnjgZ3ejchoWij6C80nVMVr5iOag3Zazf7O_g_yYcw1U_f+cQ@mail.gmail.com>
From: Alper Nebi Yasak <alpernebiyasak@gmail.com>
In-Reply-To: <CAPnjgZ3ejchoWij6C80nVMVr5iOag3Zazf7O_g_yYcw1U_f+cQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
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

On 2023-08-28 20:54 +03:00, Simon Glass wrote:
> Hi Alper,
> 
> On Sun, 27 Aug 2023 at 13:17, Alper Nebi Yasak <alpernebiyasak@gmail.com> wrote:
>>
>> On 2023-08-24 06:02 +03:00, Simon Glass wrote:
>>> In this early stage of using binman to produce output files, we are mostly
>>> seeing people using common extensions such as '.bin' and '.rom'
>>>
>>> But unusual extensions appear in some places.
>>>
>>> We would like 'buildman -k' to keep the build outputs, but this is hard if
>>> there is no consistency as to the extension used.
>>>
>>> This series adjusts binman to enforce just 4 extensions for output images:
>>>
>>>    .bin
>>>    .rom
>>>    .itb
>>>    .img
>>>
>>> Other extensions will produce an error. With this rule observed, buildman
>>> can keep the required files.
>>
>> I dislike this limitation. We know what files we will generate, they are
>> listed in binman dtb, so we can add something like `binman build --ls`
>> to print their names/paths for buildman to preserve them.
> 
> Yes, it would be good to have that...
> 
> But why do you dislike the limitation? Do you think extensions provide
> useful information? I suppose one problem is that *.bin might pick up
> private blobs that happen to be in the source directory?

I guess my strongest argument is that people already/will have workflows
that depend on certain filenames or extensions, and shouldn't have to
modify binman code (consider that people may be using the PyPI wheels)
to accommodate those when we are already putting the name in the dtb.

I do want some standardization to the U-Boot build outputs though, but
more like a global binman.dts with like u-boot.rom, u-boot-sdmmc.img
images with well-defined TPL, SPL, U-Boot sections that arch-dtsi files
can fill in.

>> Regarding the output directory suggestion, I think the binman outputs
>> (not temporary/intermediate files) should be in the same directory as
>> make outputs
> 
> Agreed
> 
>> , and the Makefile should default to O=build to achieve the
>> "output dir". I'm not sure if that's going to happen.
> 
> I would quite like the 'non-output' file (i.e. things that are not a
> binman image) to appear in a 'binman-work' subdir of the output dir.
> What do you think?

I'd prefer them to go in a tempfile.TemporaryDirectory() and discarded
at the end of a binman run, and a "--tmpdir <path>" option to use a
given directory instead and preserve things for debugging.
