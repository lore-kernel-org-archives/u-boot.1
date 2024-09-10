Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 942DAEDE9AB
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 18:44:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0250F8910F;
	Tue, 10 Sep 2024 20:44:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RoNbmjGG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D518D8910A; Tue, 10 Sep 2024 20:44:29 +0200 (CEST)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6634F88CE7
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 20:44:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-6c358b725feso8167856d6.1
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 11:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1725993866; x=1726598666; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=S7IJo9Ws2Gq4hy2COe2L/KYKBCMPcAcaJYRB7+qtOyw=;
 b=RoNbmjGGXWgTQQW2kBMuibQDrAGTXU8PQuBJnsINZDjhnn+zNpJ8Ye+ZJF3C0xOhyP
 7nQ5KJuTiJikof8wn/bOEzdCw/BEsblM1GynfPd8yf/D7fYUp/ZcGmjDtwNWl7utL6RR
 4oDoRA1HVph6B/REN/Wg0fxv7d15ITt2YKsUY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725993866; x=1726598666;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=S7IJo9Ws2Gq4hy2COe2L/KYKBCMPcAcaJYRB7+qtOyw=;
 b=IlpH/OaqWsdyxQhjyMvyPVciOC/M5eHpQ3prpXrBUqUZmMtPveGcR4yvxr08EXv1Hf
 d6gJdV2hAZgniL4fT9/KQlTax9wXtuxeQnHGZeLJF+1LXr7ZFavf8LHjF48o2aufcHCo
 DzjFbhSrA42HSpneC7q52LQz9Jt4xfg2n0nyrW18rNdkTWiBswvwQ7aLTbEtKrw6JYMQ
 9eBRD11mZ4eisOqe7D/MTaIT+qPzN2KCZztU6cTTiGqgKAnX1qD4ZZr7eCLCeDxGsywc
 9ZQS/Akev5DjbpYgZnetGwo2MiGvOMROEm9tpdlKre938lcXkOrRa5Xhbd5BIBDfv4ui
 h4tA==
X-Gm-Message-State: AOJu0Yyjl8NuB3uKgHeC16ytpWzRoHkjJdyQ6GVC3n1am3vHGI/uISad
 tGA6rCLBQqgRrvZQVXJd2IowhpSTl+GU8l9qM54METOVipWr5gh4Af0Eab+6sfvPodY0m+EkWw1
 /VW0JCrm+w9u30yi2GyFjxqPnka2tbZJRbR8X
X-Google-Smtp-Source: AGHT+IF2pX94ZRW5CTK8RJrO96eIsuYtMxszps7uqACg1hb4f5dwwTtDOpJLv2dP3Hd37VcfQAUeCtCqxSHQJQLJF3I=
X-Received: by 2002:a05:6214:3281:b0:6c3:5946:ea0b with SMTP id
 6a1803df08f44-6c55f9eae55mr5207496d6.11.1725993866270; Tue, 10 Sep 2024
 11:44:26 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1725012294.git.jerome.forissier@linaro.org>
 <e2f0809aa4b9d81cf1709a6b82d803a21ea1fac7.1725012294.git.jerome.forissier@linaro.org>
 <CAFLszTgPCkaSrfzcT1i=4pH-VS4mqBfOa2Tw6Ow02J=rc+V3aw@mail.gmail.com>
 <e2a3445f-00ba-4261-84f2-8d061ad6710e@linaro.org>
In-Reply-To: <e2a3445f-00ba-4261-84f2-8d061ad6710e@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 10 Sep 2024 12:44:15 -0600
Message-ID: <CAFLszTh+_23Jd+EZr=h28Cs-2Gek52hYUi+coG0VXfzehrVf2A@mail.gmail.com>
Subject: Re: [PATCH v2 01/16] Makefile: detect HOST_ARCH properly when
 CROSS_COMPILE is multi-word
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Peter Robinson <pbrobinson@gmail.com>, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Andrew Davis <afd@ti.com>, Sumit Garg <sumit.garg@linaro.org>,
 Bryan Brattlof <bb@ti.com>, Jesse Taube <mr.bossman075@gmail.com>,
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

On Mon, 2 Sept 2024 at 09:21, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
>
>
> On 9/1/24 22:09, Simon Glass wrote:
> > Hi Jerome,
> >
> > On Fri, 30 Aug 2024 at 04:17, Jerome Forissier
> > <jerome.forissier@linaro.org> wrote:
> >>
> >> When CROSS_COMPILE contains multiple words, HOST_ARCH is not properly
> >> detected and the sandbox build fail. It typically happens when using
> >> ccache. For example:
> >>
> >>  $ make sandbox_defconfig
> >>  $ make CROSS_COMPILE="ccache x86_64-linux-gnu-" \
> >>         CC="ccache x86_64-linux-gnu-gcc"
> >>  [...]
> >>  In file included from boot/bootmeth_efi.c:16:
> >>  include/efi_default_filename.h:33:2: error: #error Unsupported UEFI architecture
> >>     33 | #error Unsupported UEFI architecture
> >>        |  ^~~~~
> >>
> >> A similar error occurs when the build is done via buildman and
> >> ~/.buildman contains:
> >>
> >>   [toolchain-wrapper]
> >>   wrapper = ccache
> >>
> >> Fix the issue by considering only the last word in $(CROSS_COMPILE).
> >>
> >> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> >> Reviewed-by: Peter Robinson <pbrobinson@gmail.com>
> >> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> >> ---
> >>  Makefile | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > This patch[1] seems to fix the problem you mention, for the CC part at least.
>
> No, it fails with buildman:
>
> $ git log --oneline -n 1
> 454b2b2e6ed (HEAD) efi: Use the same filename for all sandbox builds
> jerome@builder:~/work/u-boot ((454b2b2e6ed...))$ ./tools/buildman/buildman sandbox_noinst
> Building current source for 1 boards (1 thread, 24 jobs per thread)
>    sandbox:  +   sandbox_noinst
> +arch/sandbox/lib/reloc_sandbox_efi.c:10:15: error: operator '==' has no left operand
> +   10 | #if HOST_ARCH == HOST_ARCH_X86_64
> +      |               ^~
> [...]

Hmm, I can't really dig into that...

>
> > For the CROSS_COMPILE bit, why is it valid to use a cross compiler on sandbox?
>
> Why not? "CROSS_COMPILE=x86_64-linux-gnu-" should result in x86_64-linux-gnu-gcc
> being used which is equivalent to gcc on a x86_64 system.

Because it isn't a cross compiler, is it?

Why is CC= not enough? After all, sandbox never cross-compiles.

>
> >>
> >> diff --git a/Makefile b/Makefile
> >> index f90e48f58a..dc7bdd7942 100644
> >> --- a/Makefile
> >> +++ b/Makefile
> >> @@ -21,7 +21,7 @@ include include/host_arch.h
> >>  ifeq ("", "$(CROSS_COMPILE)")
> >>    MK_ARCH="${shell uname -m}"
> >>  else
> >> -  MK_ARCH="${shell echo $(CROSS_COMPILE) | sed -n 's/^[[:space:]]*\([^\/]*\/\)*\([^-]*\)-[^[:space:]]*/\2/p'}"
> >> +  MK_ARCH="${shell echo ${lastword $(CROSS_COMPILE)} | sed -n 's/^[[:space:]]*\([^\/]*\/\)*\([^-]*\)-[^[:space:]]*/\2/p'}"
> >>  endif
> >>  unexport HOST_ARCH
> >>  ifeq ("x86_64", $(MK_ARCH))
> >> --
> >> 2.40.1
> >>
> >
> > Regards,
> > Simon
> >
> > [1] https://patchwork.ozlabs.org/project/uboot/patch/20240815202424.766778-9-sjg@chromium.org/

Regards,
Simon
