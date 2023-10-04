Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AA38E7C4DB
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 16:06:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2272B87581;
	Wed,  4 Oct 2023 18:06:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="Y3RKumSJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 59B0187552; Wed,  4 Oct 2023 18:06:38 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A61B8756E
 for <u-boot@lists.denx.de>; Wed,  4 Oct 2023 18:06:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-99bdeae1d0aso436262466b.1
 for <u-boot@lists.denx.de>; Wed, 04 Oct 2023 09:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1696435594; x=1697040394; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7U7qfPQ5g3FbWYnfWHHCZZpFybmuqVdTqR+KxdJ0Ta4=;
 b=Y3RKumSJOjFUH36tGtG6tx1UdeEACcrQ8bWOI7h09wzRZBGNzUjj9tHUAvx1Xs0kO9
 KqZiirLXmSsMAGBOYR6IG2FbQ0vZld1gxKp2N0xSvgfSC8QFnkltRMXpiHWkXBgxNcZw
 uqpoEa6DVfdlu6ca/cvaPjEWp/E1UiY9MbzIngYyhJR/ijib3XXQtuIOGYJwRjxEjFNv
 HJdhN35NjsH7hPiaWVnYi9/ivuHIjzesdzo23u/yaEZha5PcrOeZR+mCh8MOCGULfCGQ
 L37Q0Gl+d/1sEAVwdN41NVRam2/PA0vIHGEaBXyA06BkmsbRJ4lkXLjbmIu18crcEK4j
 /rYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696435594; x=1697040394;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7U7qfPQ5g3FbWYnfWHHCZZpFybmuqVdTqR+KxdJ0Ta4=;
 b=pZNBqFAmC0VgLixotoKpWYGCjD1PIvC5e3WdHoFHJeEm1Wxs6iw6RttWkl96uzZN+k
 ITrb8z4/hTlrWJkc4NHhU1L2qAaEZvv+yLvgRX/ceN/tOTePnVp3HuWXuy1rPLyURXoz
 rSfc4/4v6wwEzFT585pHiPd5ZFug5lDXp3TuULZhR8hTCDlF/5aACzpk+IOfB2A/MNHA
 51ByYcz8ka+yubtAuHAvGxBHhGX3/M4IMo2o3av3gsdv7Es6t4y9sY+D4q8N/6O/5Q7W
 dr3SRSgeCnxlXKDuWlx4rZmUaBEGzU1sBmfatVasW3SAT6v3/Ed0qodOE6sLZwroDiuC
 msOg==
X-Gm-Message-State: AOJu0Yy+fdMYDOVqhyQICXkbvcE18Zmw8+DwaMFgOqc8GHXgG5QrFYW4
 fKwAaAfiJy894V1sDvgC5N9oMJSzN1xbxxgORCbYVS9IH6Bx8W7ldiE=
X-Google-Smtp-Source: AGHT+IFk/ncR7csMKH7IG7fsabMBLzeLUsycv15ONqefSErPj+jk9STfKd0O7n1I4asJ7gtQFkO9o9gkMAB8hQ+VsvI=
X-Received: by 2002:a17:906:53:b0:9b2:be4e:4940 with SMTP id
 19-20020a170906005300b009b2be4e4940mr2461983ejg.61.1696435593834; Wed, 04 Oct
 2023 09:06:33 -0700 (PDT)
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
 <CAD8XO3Z87tOqMx4gmipRfwnMY-U9Sr0Bf21GtKCgq=Ay+Jtakw@mail.gmail.com>
In-Reply-To: <CAD8XO3Z87tOqMx4gmipRfwnMY-U9Sr0Bf21GtKCgq=Ay+Jtakw@mail.gmail.com>
From: Simon Glass <sjg@google.com>
Date: Wed, 4 Oct 2023 10:06:22 -0600
Message-ID: <CAPnjgZ3owGdZ8hi4p5FbWw+xh5msLsMCKiisfmW9enrPRKj+Gg@mail.gmail.com>
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

On Wed, 4 Oct 2023 at 01:53, Maxim Uvarov <maxim.uvarov@linaro.org> wrote:
>
>
>
> On Mon, 2 Oct 2023 at 20:46, Simon Glass <sjg@google.com> wrote:
>>
>> Hi Maxim,
>>
>> On Mon, 2 Oct 2023 at 05:23, Maxim Uvarov <maxim.uvarov@linaro.org> wrote:
>> >
>> > I found what was missing. (reproduced with CI docker.)
>>
>> How about adding a script that copies in the lwip code needed for
>> U-Boot, that you (or whoever the maintainer is) can run each quarter?
>>
>> Alternatively, I think just sending a patch with the code would be
>> helpful, so we can see what you are wanting to include.
>>
>> Regards,
>> Simon
>
>
> Hello Simon,
>
> That might also work. lwIP is a little bit special library which we can not just connect as an external library from the repo, because it has platform implementation specifics (U-Boot here).

Do you mean that it has an adaptation layer that we are using? I'm not
sure what you are getting at.

> At this time I'm trying to pass all CI tests. And even if they pass for me locally CI has some interesting combinations where the test fails and I'm not even sure that it's related to lwip code.
> Once CI will pass all the things I want to take more attention on submodule support or patch support. I really hope that submodule will work for us, but that also will require Makefile and CI changes.

I just hit a roadblock with submodules at the weekend. They are not
properly integrated into git (git fetch, git rebase, etc.). Perhaps
they will never be.

>
> However, review of lwIP code here might be helpful. But I think the mailing list will not allow me to send such a big patch, and it's almost impossible to do a review project in one email.

It just gets held up, but is released by Tom.

Yes, the email piece has its limits. Also I'm not sure how useful it
is to review the lwip code, unless we actually plan to submit fixes
upstream.

> I guess it's better to do a git clone https://git.savannah.nongnu.org/git/lwip.git and see what is there.

OK.

Regards,
Simon


>
> BR,
> Maxim.
>
>
>>
>> >
>> > On Mon, 2 Oct 2023 at 12:34, Maxim Uvarov <maxim.uvarov@linaro.org> wrote:
>> >>
>> >> Can somebody help me to understand and reproduce CI errors?  I can run locally 'make check' which runs a bunch of local builds with binman and all of them are fine.
>> >> It looks like some dependency is missing or addition 'git config --global --add safe.directory <path>/net/lwip/lwip-external'  is required for the submodule directory.
>> >>
>> >> https://source.denx.de/u-boot/custodians/u-boot-tpm/-/pipelines/17916
>> >>
>> >> Building current source for 1 boards (0 threads, 24 jobs per thread)
>> >>    sandbox:  +   sandbox_spl
>> >> +fatal: not a git repository (or any of the parent directories): .git
>> >> +make[1]: *** [Makefile:1875: initsubmodules] Error 128
>> >> +make: *** [Makefile:177: sub-make] Error 2
>> >>     0    0    1 /1              sandbox_spl
>> >> Completed: 1 total built, 1 newly), duration 0:00:06, rate 0.17
>> >> Traceback (most recent call last):
>> >>   File "/builds/u-boot/custodians/u-boot-tpm/./tools/binman/binman", line 45, in <module>
>> >>     from binman import cmdline
>> >>   File "/builds/u-boot/custodians/u-boot-tpm/tools/binman/cmdline.py", line 11, in <module>
>> >>     from binman import state
>> >>   File "/builds/u-boot/custodians/u-boot-tpm/tools/binman/state.py", line 14, in <module>
>> >>     from dtoc import fdt
>> >>   File "/builds/u-boot/custodians/u-boot-tpm/tools/dtoc/fdt.py", line 14, in <module>
>> >>     from libfdt import QUIET_NOTFOUND
>> >> ImportError: cannot import name 'QUIET_NOTFOUND' from 'libfdt' (unknown location)
>> >>
>> >> On Tue, 26 Sept 2023 at 20:19, Tom Rini <trini@konsulko.com> wrote:
>> >>>
>> >>> On Tue, Sep 26, 2023 at 08:16:35AM -0600, Simon Glass wrote:
>> >>> > Hi Tom,
>> >>> >
>> >>> > On Tue, 26 Sept 2023 at 07:41, Tom Rini <trini@konsulko.com> wrote:
>> >>> > >
>> >>> > > On Tue, Sep 26, 2023 at 05:37:25AM -0600, Simon Glass wrote:
>> >>> > > > Hi Maxim,
>> >>> > > >
>> >>> > > > On Tue, 26 Sept 2023 at 03:43, Maxim Uvarov <maxim.uvarov@linaro.org> wrote:
>> >>> > > > >
>> >>> > > > > add external lwIP library as a git submodule.
>> >>> > > > > Use STABLE-2_2_0_RELEASE tag.
>> >>> > > > >
>> >>> > > > > Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
>> >>> > > > > ---
>> >>> > > > >  .gitmodules            | 3 +++
>> >>> > > > >  net/lwip/lwip-external | 1 +
>> >>> > > > >  2 files changed, 4 insertions(+)
>> >>> > > > >  create mode 100644 .gitmodules
>> >>> > > > >  create mode 160000 net/lwip/lwip-external
>> >>> > >
>> >>> > > Do you have comments on the rest of the series?
>> >>> >
>> >>> > Not yet, but I should be able to review the rest in a few days. My
>> >>> > main comments before were minor - return codes, tests, error checking.
>> >>>
>> >>> OK, thanks.  I don't know how exactly I want to proceed with the core of
>> >>> lwip itself, but that doesn't block reviewing and testing the rest of it
>> >>> as we'll move forward with it one way or another.
>> >>>
>> >>> --
>> >>> Tom
