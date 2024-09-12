Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90F90EE57FB
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 01:02:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C37CF88DF8;
	Thu, 12 Sep 2024 03:00:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="K946yOCD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E6B788DC6; Thu, 12 Sep 2024 03:00:33 +0200 (CEST)
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com
 [IPv6:2607:f8b0:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8439088DF3
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 03:00:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-71788bfe60eso269664b3a.1
 for <u-boot@lists.denx.de>; Wed, 11 Sep 2024 18:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726102826; x=1726707626; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0qVIjpcUkX7n2UJJnxV1o+t1kty146mUXITGSuUXadg=;
 b=K946yOCD7nFfnv4BKPYPKoogv6IMuFZon9SBQCCGdjaMXNUOPHtdRxp0BPW2kNkqzP
 ssuJnOfRSkWeHwhz2/DWzPhmQ5frDQdH7ZwislQSEt/77nU3P0D+rP8DrG+/roFCuxis
 DvQylfYnGUY+MYXqi1UInTHKckKy1CLautJOk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726102826; x=1726707626;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0qVIjpcUkX7n2UJJnxV1o+t1kty146mUXITGSuUXadg=;
 b=neWaMq9QJdKSL7ERQlHaphkuY8JetuFsLoioSyXAaDhSFidIEaHqNWbhSAqcCVAy6T
 51eNpWvlxOspJgo7DmNGGM8FlWk+KzAlsXl04zWV8UymGuzdVeJBr+tH2WyzynxMfcJL
 pNlYd0ntwOwXA6HxX4h+odqOECyeGLp69ck/MNZmT0XMnQOGvYvnFJDi3tO3K0JHAmGY
 QRmTwTP7+uE7xhkMcjX6UFGrOrWb5JISjW0K/GitDlDJFW/drCqKw0EaBWEfH/R6uZrC
 7A9KldRxAHW5F2HNH0m/ogRIZuySQzU5j4vf/QahyEDTtjS+lXvzW01SJhWZorCxBwOG
 j5RQ==
X-Gm-Message-State: AOJu0YywrvtDMYNx0FRx/xi50hDJoMdzD+cnhO9lrIpwtYJVN0Ac6UZk
 jX/DPFZxJ78EWz4R9mrg3S4Jnx64Slm3Z1e/dYKUGTprYeXuZfFCbNwaDrSgrcxNjV0N7DfxCE6
 GaIhItjgqkll9Pb9e855OX2x88eCtRRE7VCb0
X-Google-Smtp-Source: AGHT+IFS+4PjyAJrAIkWEvA58RefSoTon98wMa+EXOVAOGedZ5rDtodudtQEj5Y2AaIY3eSdIuvXAFCeQI7ZTsCwXcI=
X-Received: by 2002:a05:6a00:2441:b0:719:2046:5d76 with SMTP id
 d2e1a72fcca58-71926200d41mr1827513b3a.23.1726102825566; Wed, 11 Sep 2024
 18:00:25 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1725351676.git.jerome.forissier@linaro.org>
 <a5617c0cb57624d004c4b4f42861822016edb2e9.1725351676.git.jerome.forissier@linaro.org>
 <CAFLszTgr9fEmdx9No2yh-1tiVW4P1qb+mWFJ=Zk6Om_d_CFuXQ@mail.gmail.com>
 <72a8df61-16b2-4d73-a1e5-db0ef1d5cd07@linaro.org>
 <CAFLszTifWxDMmW=G_4w2f5bHU-FOg5nsmd4_EeOhwVSMzHzXFQ@mail.gmail.com>
 <f06b0774-d47c-4414-9974-89d2ebbf1902@linaro.org>
In-Reply-To: <f06b0774-d47c-4414-9974-89d2ebbf1902@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 11 Sep 2024 19:00:00 -0600
Message-ID: <CAFLszTjsEKe3PMNtPvqF7nUXkfRMF1jYL1mH2M4GP+VhiC92JQ@mail.gmail.com>
Subject: Re: [PATCH v3 01/16] Makefile: detect HOST_ARCH properly when
 CROSS_COMPILE is multi-word
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Peter Robinson <pbrobinson@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Sumit Garg <sumit.garg@linaro.org>,
 Andrew Davis <afd@ti.com>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Bryan Brattlof <bb@ti.com>, 
 Jesse Taube <mr.bossman075@gmail.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>
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

Hi Jerome,

On Wed, 11 Sept 2024 at 03:44, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> Hi Simon,
>
> TL;DR: I am dropping this patch in v4.
>
> On 9/10/24 20:44, Simon Glass wrote:
> > Hi Jerome,
> >
> > On Fri, 6 Sept 2024 at 09:10, Jerome Forissier
> > <jerome.forissier@linaro.org> wrote:
> >>
> >> Hello Simon,
> >>
> >> On 9/6/24 17:02, Simon Glass wrote:
> >>> Hi Jerome,
> >>>
> >>> On Tue, 3 Sept 2024 at 02:38, Jerome Forissier
> >>> <jerome.forissier@linaro.org> wrote:
> >>>>
> >>>> When CROSS_COMPILE contains multiple words, HOST_ARCH is not properly
> >>>> detected and the sandbox build fail. It typically happens when using
> >>>> ccache. For example:
> >>>>
> >>>>  $ make sandbox_defconfig
> >>>>  $ make CROSS_COMPILE="ccache x86_64-linux-gnu-" \
> >>>>         CC="ccache x86_64-linux-gnu-gcc"
> >>>>  [...]
> >>>>  In file included from boot/bootmeth_efi.c:16:
> >>>>  include/efi_default_filename.h:33:2: error: #error Unsupported UEFI architecture
> >>>>     33 | #error Unsupported UEFI architecture
> >>>>        |  ^~~~~
>
> As you mentioned in your reply to this patch in v2 [1], this is not
> a valid use case (CROSS_COMPILE should not be set for sandbox).
>
> [1] http://patchwork.ozlabs.org/project/uboot/patch/e2f0809aa4b9d81cf1709a6b82d803a21ea1fac7.1725012294.git.jerome.forissier@linaro.org/#3377679
>
> >>>>
> >>>> A similar error occurs when the build is done via buildman and
> >>>> ~/.buildman contains:
> >>>>
> >>>>   [toolchain-wrapper]
> >>>>   wrapper = ccache
>
>
> This problem is still present in -next though (which does have your
> patch "buildman: Support building within a Python venv" [2]).
>
> It is my patch "buildman/toolchain.py: do not set CROSS_COMPILE for
> sandbox" [3] that solves the problem.
>
> [2] https://patchwork.ozlabs.org/project/uboot/patch/20240815195746.749042-2-sjg@chromium.org/
> [3] http://patchwork.ozlabs.org/project/uboot/patch/f4defe07f87f6c9761b401d435da03460b3b0947.1725351676.git.jerome.forissier@linaro.org/
>
> So all in all this patch is not needed.

OK, thank you for digging into this.

>
> Regards,
> --
> Jerome
>
> >>>> Fix the issue by considering only the last word in $(CROSS_COMPILE).
> >>>>
> >>>> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> >>>> Reviewed-by: Peter Robinson <pbrobinson@gmail.com>
> >>>> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> >>>> Reviewed-by: Peter Robinson <pbrobinson@gmail.com>
> >>>> ---
> >>>>  Makefile | 2 +-
> >>>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/Makefile b/Makefile
> >>>> index f90e48f58a5..dc7bdd79420 100644
> >>>> --- a/Makefile
> >>>> +++ b/Makefile
> >>>> @@ -21,7 +21,7 @@ include include/host_arch.h
> >>>>  ifeq ("", "$(CROSS_COMPILE)")
> >>>>    MK_ARCH="${shell uname -m}"
> >>>>  else
> >>>> -  MK_ARCH="${shell echo $(CROSS_COMPILE) | sed -n 's/^[[:space:]]*\([^\/]*\/\)*\([^-]*\)-[^[:space:]]*/\2/p'}"
> >>>> +  MK_ARCH="${shell echo ${lastword $(CROSS_COMPILE)} | sed -n 's/^[[:space:]]*\([^\/]*\/\)*\([^-]*\)-[^[:space:]]*/\2/p'}"
> >>>>  endif
> >>>>  unexport HOST_ARCH
> >>>>  ifeq ("x86_64", $(MK_ARCH))
> >>>> --
> >>>> 2.40.1
> >>>>
> >>>
> >>> I've lost track of this, but did you pull in [1] first?
> >>
> >> Oops! No I didn't :-/ In fact I could not find the reference to the patch
> >> in your initial email, then I forgot about it.
> >> Would you like me to resend the whole series as v4 with your patch included?
> >
> > I just want to know that there is still a problem, with my patch. So
> > yes please try it and update the commit messages as needed for the two
> > affected patches.
> >
> > Regards,
> > Simon
> >
> >
> >>
> >>>
> >>> Regards,
> >>> Simon
> >>>
> >>> [1] https://patchwork.ozlabs.org/project/uboot/patch/20240815195746.749042-2-sjg@chromium.org/
> >>
> >> Thanks,
> >> --
> >> Jerome

Regards,
Simon
