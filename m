Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 724A4E784B7
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 14:46:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B742286DA2;
	Mon,  2 Oct 2023 16:46:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="SLRvukR+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B68D187163; Mon,  2 Oct 2023 16:46:18 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6ED1986D91
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 16:46:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5344d996bedso15275478a12.3
 for <u-boot@lists.denx.de>; Mon, 02 Oct 2023 07:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1696257976; x=1696862776; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=il0RwgVGNyB5FLHRwE+ROlXwaXef1k6rTNfRoTdte/0=;
 b=SLRvukR+ymIiWWkrOjZ57QBwjuSzyCajfkP+9CdVc2xgZXvxm5LPc76Yizod3bodtb
 ehx07E4olJsqseqOIhobnS0X+KniDP8lCMJoqz6m65ITqXURZ7j/cCjWU1FA2RTA0zNk
 lWF8QheuTJLpF3wYNfrgbbKOtQIB66Mpp9hQfGbZ0SQ30yviLhgpxl65j+V0MJTNw5L9
 szblTr6osTcIsfAOzu2XUmD3v1kOiVzl1f9RI0HKDVdMP7Znzx5ZDPO/yJ/3mcdPPlwR
 MXr6YCwoA5mCwjSLzO6vXqDuPQOqOVY6IJALx2D69V2IN8AFBRdZr99r41vfqdqdXNZQ
 0Waw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696257976; x=1696862776;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=il0RwgVGNyB5FLHRwE+ROlXwaXef1k6rTNfRoTdte/0=;
 b=qayrzDR7Ixj5/KAeY5WI3EyNVbBSdYcPA1myCIgc6Aox5pdsRFobwnss0rcAXslbl+
 teXgLNPvZUiz6Os3HUZkys3FFzIox63s66+NINjsJod9aUI4izObsZiDC/q+1ekOUTUi
 NAf14BoC/r3UvRbmbEpPLoDVYlrI1kyIxk5yx67wdKvYWOpGavstqrmq5YToe4+9sTeD
 zmBxOS7bdRZXCWI5KoS8iRHSD+k6boUsSDC4U7c2UXnqn0gd68b9fBzlHw7CNzLYQ8dP
 J+lX3668bxc0WwO6gcxozyhdNXCOl22rsVXo7+vpTvJK8G+musy7Z77suQEDCKW5rUv3
 Mj+A==
X-Gm-Message-State: AOJu0YxS+7gpXPeLZOPkwJmiW1JBWpoHJ8m+2R2pgVdwqR3UUEEUvKXR
 AItzGshF0Qt56fqcQGXCRGlJNZ+E5NF/MXgN6wr2mA==
X-Google-Smtp-Source: AGHT+IEJ1agqog5huKiqWzVmnYiuekxiVKLUsTNyu8YoxluISJiRNjJaP7XPIr/dYSTajquoXbdRb8aTpL8HoV2kXBk=
X-Received: by 2002:a17:906:9c9:b0:9ae:4f9e:7813 with SMTP id
 r9-20020a17090609c900b009ae4f9e7813mr8736345eje.73.1696257975682; Mon, 02 Oct
 2023 07:46:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230926094124.7024-1-maxim.uvarov@linaro.org>
 <20230926094124.7024-2-maxim.uvarov@linaro.org>
 <CAPnjgZ2OV8ug3+3ji8nEnK7cwONu7KFa2zSyP5urKWUkQvMqJA@mail.gmail.com>
 <20230926134149.GS305624@bill-the-cat>
 <CAPnjgZ1iAG8Rw3jVZvFs16AvnGkO=gCsCM3dF1c30biFk4t2xw@mail.gmail.com>
 <20230926141936.GW305624@bill-the-cat>
 <CAD8XO3aifH+f_NZ1g_nJrxKu_tDmuW9H=Pk2o4v8yTAAn1nfdQ@mail.gmail.com>
 <CAD8XO3Yy1ppSgvUQ3ZZOmVzK2puxruHu2Q4UiCDPUzsWuKA8Vw@mail.gmail.com>
In-Reply-To: <CAD8XO3Yy1ppSgvUQ3ZZOmVzK2puxruHu2Q4UiCDPUzsWuKA8Vw@mail.gmail.com>
From: Simon Glass <sjg@google.com>
Date: Mon, 2 Oct 2023 08:46:04 -0600
Message-ID: <CAPnjgZ3aqSjChJqCHQfrO5kxg0=-BR-KV4aC6jquC4ZRTovi0g@mail.gmail.com>
Subject: Re: [PATCHv10 01/15] submodule: add lwIP as git submodule
To: Maxim Uvarov <maxim.uvarov@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, pbrobinson@gmail.com, 
 ilias.apalodimas@linaro.org, joe.hershberger@ni.com, rfried.dev@gmail.com, 
 goldsimon@gmx.de
Content-Type: text/plain; charset="UTF-8"
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

Hi Maxim,

On Mon, 2 Oct 2023 at 05:23, Maxim Uvarov <maxim.uvarov@linaro.org> wrote:
>
> I found what was missing. (reproduced with CI docker.)

How about adding a script that copies in the lwip code needed for
U-Boot, that you (or whoever the maintainer is) can run each quarter?

Alternatively, I think just sending a patch with the code would be
helpful, so we can see what you are wanting to include.

Regards,
Simon

>
> On Mon, 2 Oct 2023 at 12:34, Maxim Uvarov <maxim.uvarov@linaro.org> wrote:
>>
>> Can somebody help me to understand and reproduce CI errors?  I can run locally 'make check' which runs a bunch of local builds with binman and all of them are fine.
>> It looks like some dependency is missing or addition 'git config --global --add safe.directory <path>/net/lwip/lwip-external'  is required for the submodule directory.
>>
>> https://source.denx.de/u-boot/custodians/u-boot-tpm/-/pipelines/17916
>>
>> Building current source for 1 boards (0 threads, 24 jobs per thread)
>>    sandbox:  +   sandbox_spl
>> +fatal: not a git repository (or any of the parent directories): .git
>> +make[1]: *** [Makefile:1875: initsubmodules] Error 128
>> +make: *** [Makefile:177: sub-make] Error 2
>>     0    0    1 /1              sandbox_spl
>> Completed: 1 total built, 1 newly), duration 0:00:06, rate 0.17
>> Traceback (most recent call last):
>>   File "/builds/u-boot/custodians/u-boot-tpm/./tools/binman/binman", line 45, in <module>
>>     from binman import cmdline
>>   File "/builds/u-boot/custodians/u-boot-tpm/tools/binman/cmdline.py", line 11, in <module>
>>     from binman import state
>>   File "/builds/u-boot/custodians/u-boot-tpm/tools/binman/state.py", line 14, in <module>
>>     from dtoc import fdt
>>   File "/builds/u-boot/custodians/u-boot-tpm/tools/dtoc/fdt.py", line 14, in <module>
>>     from libfdt import QUIET_NOTFOUND
>> ImportError: cannot import name 'QUIET_NOTFOUND' from 'libfdt' (unknown location)
>>
>> On Tue, 26 Sept 2023 at 20:19, Tom Rini <trini@konsulko.com> wrote:
>>>
>>> On Tue, Sep 26, 2023 at 08:16:35AM -0600, Simon Glass wrote:
>>> > Hi Tom,
>>> >
>>> > On Tue, 26 Sept 2023 at 07:41, Tom Rini <trini@konsulko.com> wrote:
>>> > >
>>> > > On Tue, Sep 26, 2023 at 05:37:25AM -0600, Simon Glass wrote:
>>> > > > Hi Maxim,
>>> > > >
>>> > > > On Tue, 26 Sept 2023 at 03:43, Maxim Uvarov <maxim.uvarov@linaro.org> wrote:
>>> > > > >
>>> > > > > add external lwIP library as a git submodule.
>>> > > > > Use STABLE-2_2_0_RELEASE tag.
>>> > > > >
>>> > > > > Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
>>> > > > > ---
>>> > > > >  .gitmodules            | 3 +++
>>> > > > >  net/lwip/lwip-external | 1 +
>>> > > > >  2 files changed, 4 insertions(+)
>>> > > > >  create mode 100644 .gitmodules
>>> > > > >  create mode 160000 net/lwip/lwip-external
>>> > >
>>> > > Do you have comments on the rest of the series?
>>> >
>>> > Not yet, but I should be able to review the rest in a few days. My
>>> > main comments before were minor - return codes, tests, error checking.
>>>
>>> OK, thanks.  I don't know how exactly I want to proceed with the core of
>>> lwip itself, but that doesn't block reviewing and testing the rest of it
>>> as we'll move forward with it one way or another.
>>>
>>> --
>>> Tom
