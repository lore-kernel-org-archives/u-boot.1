Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09DA4E8FDD9
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 07:53:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 319D386ADA;
	Wed,  4 Oct 2023 09:53:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="E2riy1q6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A8CD186AE1; Wed,  4 Oct 2023 09:53:08 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3956086A4C
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 09:53:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-9adb9fa7200so140037866b.0
 for <u-boot@lists.denx.de>; Wed, 04 Oct 2023 00:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696405986; x=1697010786; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8MksrFUO3diDivAWJtFcnWoiN3rxETsJUTYG4ZyFk4c=;
 b=E2riy1q6jyXbbF37jKL9rDa7w0fja8ohOlUEZtFCtTqaFohv7XMd7gSB1ikhHIc6x/
 wa4TwjMGWRALLf7EERoLkI1iQwCjX7bZPGqiQyVl1o3j6/Pf47y8PQWmqBgciMMKbm2d
 D1v2BZ1Hlx/OBOHpqImlJj01uF9tnyHQBBCFlipMeZAObYZ4+C9k7YPXNadLCAdT5pJF
 QgQ00Czkfly7ClDjLOenOvErsBfrrpiDJarNcFOZ90AGfPO7oT/bzMjmaGW3bUZYyvhi
 sFwW2tO+jFjbkU1fc1NgCht3Lg0OaoKMDJgvbbyo/0jnYhKI/6j9n88B/zTvmFRJ/u8x
 E8/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696405986; x=1697010786;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8MksrFUO3diDivAWJtFcnWoiN3rxETsJUTYG4ZyFk4c=;
 b=MwkP5EN9iWbjSbsX87zZ9DUrSKEVczSjBhbAueU14pKJbb0PfRpwidph98uojw4X6l
 wjvQIlpz/0pwmsdZVatymInoRIPGvoafAnxPUBCjKZMGmC7gjKM5Qp67VMdA2NDi+er0
 UUtOZw5bAeMsmkjbt38wBRXbpQ6Gyy3A1GaYIAznrTxqR40tOjfarqoxgex4OibEv5I0
 kahxZzol7WNwJdAYbbx3sH22AuofY53mC1HbIxJNYoc9PVqjmF9ouJ733CaD33NN0OLk
 hDsb/wEoI3ESRRRwhyHQhllzhGM7U73hY08XHucBFfyF+DA9bte/GmQKz6u2oLrclkxX
 2uoQ==
X-Gm-Message-State: AOJu0Yw1DlZ0MIJfAq+7YVQ4chbLrJseAnRvoHMDCfyLBPanlG3zN1Au
 i1peeSgbEZFEvPbHtIQwQAW+yKryfSV5zXeW5XMNNA==
X-Google-Smtp-Source: AGHT+IGnKGcM3eZ82djLIfK998uKozBNPllKiL27penTIGOevxPB5zu1qIqGlWGRclYV7poQwyL+ncexZx/F1HL64Vk=
X-Received: by 2002:a17:907:2cf7:b0:9ae:5513:e475 with SMTP id
 hz23-20020a1709072cf700b009ae5513e475mr1320345ejc.9.1696405985644; Wed, 04
 Oct 2023 00:53:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230926094124.7024-1-maxim.uvarov@linaro.org>
 <20230926094124.7024-2-maxim.uvarov@linaro.org>
 <CAPnjgZ2OV8ug3+3ji8nEnK7cwONu7KFa2zSyP5urKWUkQvMqJA@mail.gmail.com>
 <20230926134149.GS305624@bill-the-cat>
 <CAPnjgZ1iAG8Rw3jVZvFs16AvnGkO=gCsCM3dF1c30biFk4t2xw@mail.gmail.com>
 <20230926141936.GW305624@bill-the-cat>
 <CAD8XO3aifH+f_NZ1g_nJrxKu_tDmuW9H=Pk2o4v8yTAAn1nfdQ@mail.gmail.com>
 <CAD8XO3Yy1ppSgvUQ3ZZOmVzK2puxruHu2Q4UiCDPUzsWuKA8Vw@mail.gmail.com>
 <CAPnjgZ3aqSjChJqCHQfrO5kxg0=-BR-KV4aC6jquC4ZRTovi0g@mail.gmail.com>
In-Reply-To: <CAPnjgZ3aqSjChJqCHQfrO5kxg0=-BR-KV4aC6jquC4ZRTovi0g@mail.gmail.com>
From: Maxim Uvarov <maxim.uvarov@linaro.org>
Date: Wed, 4 Oct 2023 13:52:53 +0600
Message-ID: <CAD8XO3Z87tOqMx4gmipRfwnMY-U9Sr0Bf21GtKCgq=Ay+Jtakw@mail.gmail.com>
Subject: Re: [PATCHv10 01/15] submodule: add lwIP as git submodule
To: Simon Glass <sjg@google.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, pbrobinson@gmail.com, 
 ilias.apalodimas@linaro.org, joe.hershberger@ni.com, rfried.dev@gmail.com, 
 goldsimon@gmx.de
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

On Mon, 2 Oct 2023 at 20:46, Simon Glass <sjg@google.com> wrote:

> Hi Maxim,
>
> On Mon, 2 Oct 2023 at 05:23, Maxim Uvarov <maxim.uvarov@linaro.org> wrote:
> >
> > I found what was missing. (reproduced with CI docker.)
>
> How about adding a script that copies in the lwip code needed for
> U-Boot, that you (or whoever the maintainer is) can run each quarter?
>
> Alternatively, I think just sending a patch with the code would be
> helpful, so we can see what you are wanting to include.
>
> Regards,
> Simon
>

Hello Simon,

That might also work. lwIP is a little bit special library which we can not
just connect as an external library from the repo, because it has
platform implementation specifics (U-Boot here).
At this time I'm trying to pass all CI tests. And even if they pass for me
locally CI has some interesting combinations where the test fails and I'm
not even sure that it's related to lwip code.
Once CI will pass all the things I want to take more attention on submodule
support or patch support. I really hope that submodule will work for us,
but that also will require Makefile and CI changes.

However, review of lwIP code here might be helpful. But I think the mailing
list will not allow me to send such a big patch, and it's almost impossible
to do a review project in one email.
I guess it's better to do a git clone
https://git.savannah.nongnu.org/git/lwip.git and see what is there.

BR,
Maxim.



> >
> > On Mon, 2 Oct 2023 at 12:34, Maxim Uvarov <maxim.uvarov@linaro.org>
> wrote:
> >>
> >> Can somebody help me to understand and reproduce CI errors?  I can run
> locally 'make check' which runs a bunch of local builds with binman and all
> of them are fine.
> >> It looks like some dependency is missing or addition 'git config
> --global --add safe.directory <path>/net/lwip/lwip-external'  is required
> for the submodule directory.
> >>
> >> https://source.denx.de/u-boot/custodians/u-boot-tpm/-/pipelines/17916
> >>
> >> Building current source for 1 boards (0 threads, 24 jobs per thread)
> >>    sandbox:  +   sandbox_spl
> >> +fatal: not a git repository (or any of the parent directories): .git
> >> +make[1]: *** [Makefile:1875: initsubmodules] Error 128
> >> +make: *** [Makefile:177: sub-make] Error 2
> >>     0    0    1 /1              sandbox_spl
> >> Completed: 1 total built, 1 newly), duration 0:00:06, rate 0.17
> >> Traceback (most recent call last):
> >>   File "/builds/u-boot/custodians/u-boot-tpm/./tools/binman/binman",
> line 45, in <module>
> >>     from binman import cmdline
> >>   File "/builds/u-boot/custodians/u-boot-tpm/tools/binman/cmdline.py",
> line 11, in <module>
> >>     from binman import state
> >>   File "/builds/u-boot/custodians/u-boot-tpm/tools/binman/state.py",
> line 14, in <module>
> >>     from dtoc import fdt
> >>   File "/builds/u-boot/custodians/u-boot-tpm/tools/dtoc/fdt.py", line
> 14, in <module>
> >>     from libfdt import QUIET_NOTFOUND
> >> ImportError: cannot import name 'QUIET_NOTFOUND' from 'libfdt' (unknown
> location)
> >>
> >> On Tue, 26 Sept 2023 at 20:19, Tom Rini <trini@konsulko.com> wrote:
> >>>
> >>> On Tue, Sep 26, 2023 at 08:16:35AM -0600, Simon Glass wrote:
> >>> > Hi Tom,
> >>> >
> >>> > On Tue, 26 Sept 2023 at 07:41, Tom Rini <trini@konsulko.com> wrote:
> >>> > >
> >>> > > On Tue, Sep 26, 2023 at 05:37:25AM -0600, Simon Glass wrote:
> >>> > > > Hi Maxim,
> >>> > > >
> >>> > > > On Tue, 26 Sept 2023 at 03:43, Maxim Uvarov <
> maxim.uvarov@linaro.org> wrote:
> >>> > > > >
> >>> > > > > add external lwIP library as a git submodule.
> >>> > > > > Use STABLE-2_2_0_RELEASE tag.
> >>> > > > >
> >>> > > > > Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
> >>> > > > > ---
> >>> > > > >  .gitmodules            | 3 +++
> >>> > > > >  net/lwip/lwip-external | 1 +
> >>> > > > >  2 files changed, 4 insertions(+)
> >>> > > > >  create mode 100644 .gitmodules
> >>> > > > >  create mode 160000 net/lwip/lwip-external
> >>> > >
> >>> > > Do you have comments on the rest of the series?
> >>> >
> >>> > Not yet, but I should be able to review the rest in a few days. My
> >>> > main comments before were minor - return codes, tests, error
> checking.
> >>>
> >>> OK, thanks.  I don't know how exactly I want to proceed with the core
> of
> >>> lwip itself, but that doesn't block reviewing and testing the rest of
> it
> >>> as we'll move forward with it one way or another.
> >>>
> >>> --
> >>> Tom
>
