Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB383C5AE5A
	for <u-boot@archiver.kernel.org>; Wed, 28 Aug 2024 15:40:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E46788829;
	Wed, 28 Aug 2024 17:40:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Tkl3UbEd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BB5C588901; Wed, 28 Aug 2024 17:40:09 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6227E88744
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 17:40:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-428119da952so60661145e9.0
 for <u-boot@lists.denx.de>; Wed, 28 Aug 2024 08:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724859606; x=1725464406; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=97h3//BggEyWsSCDJY9xr50ljc2Iz5+BnMLbET6rGbg=;
 b=Tkl3UbEdYhFHeNXci81JKzdt4quMQlUha+Bmlm2bFPcJMD8YQVxYTV538+SCDxER+o
 wI6IzqsEnCYuTW5/n7osdk4eLX2pybD7aanvUi5nw/46kpuVkwhvNA4MBEa2GaOdFW3P
 moaee4m0nRP5iH+pEFiHgDoZz1BZ9juvvAc45WdVdYGGUbxilOjPXJEb4vGHygsBt49G
 iuwHzcFYU74JHR6S6dBP4czZPryunvAV77zSG/R0iNLg46SBflbmgrP8iqW4zGZfq7F/
 VqVFGYAaXgDKAa83r1sN+8vIMqQKFGV0dfHhHgBdxlqnkJWqjStRyxx00NA1Nuf4Vk7G
 zSMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724859606; x=1725464406;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=97h3//BggEyWsSCDJY9xr50ljc2Iz5+BnMLbET6rGbg=;
 b=pBaeP96XGVD66DsxVtKHQaPAbApx5MG7eBgMWxzyClsFyBjg6gPatuH7QCsJbCvxLY
 HZ+wKQ2IXoSMdMLZvoW67TFrDmmY5n2yR2ePc32xK700IWh9Qoqno0nHJApzZuPxLW/h
 6dS3CtJDQITMpv3HqhdgN2J6MV+Uzd22ylnnSAh+htaNl/PdoBRSAPaRRZ66fsW/IoEB
 DnLDiEwPsLc0uigIPAn+US2D/+o35FiZtyjuUedp1+tFWCiRo1pUmiSmQFYsS+v/cCei
 UPDUlbPVYOBvOrh6m3TGloBvgkOpoho/SvAQ9Md/V01nb/ejCyBYgvNO7tDNBGpI/chG
 LldA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmTaTDGNMELTpRU0tRE9gFNC6u0YH6mQ57AQmmvlYwOtgq90DPHsJWDB45ciEsO+BIef+aV0k=@lists.denx.de
X-Gm-Message-State: AOJu0YxmkDEJX2q24ZdK8of0lZTT5pUcggNhjAR1dDwYkeoOvXMBIgGM
 sP/LZo7cp7po6fCLqfxJPHjUq5xryBrvQkKigmHsiTrrNrxRLEG1ZvJCyDWN3CKl7FCfqui3Fvf
 2TX5Q/pFt
X-Google-Smtp-Source: AGHT+IFLukz1rlXa/LhK5kWse516AlgtuBg76M6AkFLc9lDWALGNBq1y6KxcbasGLWe/inLRAkUf3g==
X-Received: by 2002:a05:600c:c17:b0:426:5e8e:410a with SMTP id
 5b1f17b1804b1-42bb032cb54mr272235e9.24.1724859606267; 
 Wed, 28 Aug 2024 08:40:06 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:18ae:f2bf:3df2:e3c4?
 ([2a01:e0a:3cb:7bb0:18ae:f2bf:3df2:e3c4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42ba63d3f91sm25967565e9.31.2024.08.28.08.40.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Aug 2024 08:40:06 -0700 (PDT)
Message-ID: <aeba3da3-b287-481c-a704-4b56884deaaf@linaro.org>
Date: Wed, 28 Aug 2024 17:40:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: imx8ulp_evk build with buildman fails every other time
To: Simon Glass <sjg@chromium.org>, Fabio Estevam <festevam@gmail.com>
Cc: Gary Bisson <bisson.gary@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <980adca3-27ac-440b-93b4-80146d050584@linaro.org>
 <CAOMZO5A2ZBb9G6krUmfNy3qnoNYgwdb2-DUgeNuvONy9VioEbQ@mail.gmail.com>
 <CAFLszTgZ9vFe1rahWG_QiVJXoCBOTc=umAJ=YZwu7ExyXWsuDg@mail.gmail.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <CAFLszTgZ9vFe1rahWG_QiVJXoCBOTc=umAJ=YZwu7ExyXWsuDg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
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



On 8/27/24 17:53, Simon Glass wrote:
> Hi Jerome,
> 
> On Tue, 27 Aug 2024 at 08:53, Fabio Estevam <festevam@gmail.com> wrote:
>>
>> Adding Gary and Peng on Cc.
>>
>> On Tue, Aug 27, 2024 at 11:42 AM Jerome Forissier
>> <jerome.forissier@linaro.org> wrote:
>>>
>>> Hi,
>>>
>>> Can someone explain what's happening with the imx8ulp_evk buildman build
>>> below? It either fails with a mkimage error, or succeeds with a binman
>>> warning, every other time. 100% reproducible. /me confused :o
>>>
>>> ====8<============8<==============
>>> $ docker run -it --rm trini/u-boot-gitlab-ci-runner:jammy-20240808-21Aug2024
>>> uboot@42aa85c2d6b7:/$ cd
>>> uboot@42aa85c2d6b7:~$ git clone https://github.com/u-boot/u-boot.git
>>> uboot@42aa85c2d6b7:~/u-boot$ git log --oneline -n 1
>>> ee2af844ba (HEAD -> master, origin/master, origin/HEAD) Merge tag 'efi-2024-10-rc4' of https://source.denx.de/u-boot/custodians/u-boot-efi
>>> uboot@42aa85c2d6b7:~$ cd u-boot
>>> uboot@42aa85c2d6b7:~/u-boot$ tools/buildman/buildman imx8ulp_evk
>>> Building current source for 1 boards (1 thread, 24 jobs per thread)
>>>    aarch64:  w+   imx8ulp_evk
>>> +WARNING 'mx8ulpa2-ahab-container.img' not found, resulting binary may be not-functional
>>> +WARNING 'bl31.bin' not found, resulting binary may be not-functional
>>> +WARNING 'upower.bin' not found, resulting binary may be not-functional
>>> +WARNING 'm33_image.bin' not found, resulting binary may be not-functional
>>>     0    1    0 /1              imx8ulp_evk
>>> Completed: 1 total built, 1 newly), duration 0:00:09, rate 0.11
>>> uboot@42aa85c2d6b7:~/u-boot$ tools/buildman/buildman imx8ulp_evk
>>> Building current source for 1 boards (1 thread, 24 jobs per thread)
>>>    aarch64:  +   imx8ulp_evk
>>> +WARNING 'bl31.bin' not found, resulting binary may be not-functional
>>> +binman: Error 1 running 'mkimage -d ./mkimage.spl.mkimage -n spl/u-boot-spl.cfgout -T imx8image -e 0x22020000 ./mkimage-out.spl.mkimage': Fail open first container file mx8ulpa2-ahab-container.img
>>> +
>>> +make[1]: *** [Makefile:1126: .binman_stamp] Error 1
>>> +make: *** [Makefile:177: sub-make] Error 2
>>>     0    0    1 /1              imx8ulp_evk
>>> Completed: 1 total built, 1 newly), duration 0:00:04, rate 0.25
>>> uboot@42aa85c2d6b7:~/u-boot$ tools/buildman/buildman imx8ulp_evk
>>> Building current source for 1 boards (1 thread, 24 jobs per thread)
>>>    aarch64:  w+   imx8ulp_evk
>>> +WARNING 'mx8ulpa2-ahab-container.img' not found, resulting binary may be not-functional
>>> +WARNING 'upower.bin' not found, resulting binary may be not-functional
>>> +WARNING 'm33_image.bin' not found, resulting binary may be not-functional
>>> +WARNING 'bl31.bin' not found, resulting binary may be not-functional
>>>     0    1    0 /1              imx8ulp_evk
>>> Completed: 1 total built, 1 newly), duration 0:00:04, rate 0.25
>>> uboot@42aa85c2d6b7:~/u-boot$ tools/buildman/buildman imx8ulp_evk
>>> Building current source for 1 boards (1 thread, 24 jobs per thread)
>>>    aarch64:  +   imx8ulp_evk
>>> +WARNING 'bl31.bin' not found, resulting binary may be not-functional
>>> +binman: Error 1 running 'mkimage -d ./mkimage.spl.mkimage -n spl/u-boot-spl.cfgout -T imx8image -e 0x22020000 ./mkimage-out.spl.mkimage': Fail open first container file mx8ulpa2-ahab-container.img
>>> +
>>> +make[1]: *** [Makefile:1126: .binman_stamp] Error 1
>>> +make: *** [Makefile:177: sub-make] Error 2
>>>     0    0    1 /1              imx8ulp_evk
>>> Completed: 1 total built, 1 newly), duration 0:00:04, rate 0.25
>>> ====8<============8<==============
>>>
> 
> I can't quite explain it but I have hit this before. It is why I have
> been unable to land [1]
> 
> Perhaps binman is writing a file which is being picked up on the next
> run, but is not valid? Or perhaps the file from a previous build
> confuses things? I notice that some of the sections have filenames,
> meaning that they are written and persist between builds.
> 
> You can try BINMAN_VERBOSE=4 or 5 to see what is happening, or
> BINMAN_DEBUG=1 to get a stack trace.

That one wasn't super easy to track down :-/ but I think I have a proper
fix. See https://lists.denx.de/pipermail/u-boot/2024-August/563355.html.

Thanks,
-- 
Jerome

> 
> Regards,
> Simon
> 
> [1] https://patchwork.ozlabs.org/project/uboot/patch/20240623175515.1466908-14-sjg@chromium.org/
