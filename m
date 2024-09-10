Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F077DEDE9AD
	for <u-boot@archiver.kernel.org>; Tue, 10 Sep 2024 18:44:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 99994890B9;
	Tue, 10 Sep 2024 20:44:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KWWP0gl2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 720118910A; Tue, 10 Sep 2024 20:44:28 +0200 (CEST)
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com
 [IPv6:2607:f8b0:4864:20::832])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 191D9890F6
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 20:44:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-457cfc2106aso41024671cf.2
 for <u-boot@lists.denx.de>; Tue, 10 Sep 2024 11:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1725993865; x=1726598665; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=R2m/NtscKXJDVyueA8D2gu4T4gNB2/TxCSOCimlyye0=;
 b=KWWP0gl2LeT6oPk6Z/w7iKL+n4kEIrYsIYvg2HHdepNEalcYWzF/7evjPFKz06Vult
 SjuxpvY3GhFBASQ6FXJ7C80EX5cAswaT/fSfjWEVP8WNkAUeIMjzekWtfvRZCdtjiC3s
 pAQDx2ZPhRtBxY/xHCjBr58yFwE6gAYFOShiU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725993865; x=1726598665;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=R2m/NtscKXJDVyueA8D2gu4T4gNB2/TxCSOCimlyye0=;
 b=Jbt5akfsHzkwFnxYVkTY8ughvVjROERo8N96Whivd/IvFqwxvU4W8+/AzkBrjsPXwt
 ohkklI5BklTd0Uc1d/7cnIxEXS8DNVCaJagBOizKP8xmVoqKl6Cd3cScReMqT06KK9PR
 F0lEMjOeh2BPxekohIeEesKJr4Pw1W6eKDs/dZ8alEdxedVuQt+UepAEvcgUPhOSyv9r
 zzTRDkDcIot8me39ro514g/nZQaNzkoXRmnMVj3osoplv0wWeqaWznJnhmJKLgbRAjnR
 2E87GgahQU7gXeKhVs5GSfo4nHm0GLRgLEzKYshdO5r02bB8H+bBmXIpYdcsXRHZ5Q8w
 EfKw==
X-Gm-Message-State: AOJu0Yxn7YI0Rs5XD+Lamn40kYtGbRPjjJb/NHuFeCWH8vxJLeVVYceF
 aYRgWwhRc44lhOyblqu8p8xA72dOVpThugtvtx8RWsm7f5xB2Hefu4wlF5NpIpb073qJsCoAF5e
 /jxuRZWz3TIapULc0XV4lhvkPpzxU/kz7ljas
X-Google-Smtp-Source: AGHT+IGFYeMNFQKehL2CmYNkC3psdnm5iZnwh7GfkiDSiHSE9F2tLPSZH748JWaQ6JLQjXN4bYRNpMIdkz8wWAJRMC8=
X-Received: by 2002:a05:6214:451a:b0:6c3:56e0:5fde with SMTP id
 6a1803df08f44-6c52850db38mr188180306d6.51.1725993864919; Tue, 10 Sep 2024
 11:44:24 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1725351676.git.jerome.forissier@linaro.org>
 <a5617c0cb57624d004c4b4f42861822016edb2e9.1725351676.git.jerome.forissier@linaro.org>
 <CAFLszTgr9fEmdx9No2yh-1tiVW4P1qb+mWFJ=Zk6Om_d_CFuXQ@mail.gmail.com>
 <72a8df61-16b2-4d73-a1e5-db0ef1d5cd07@linaro.org>
In-Reply-To: <72a8df61-16b2-4d73-a1e5-db0ef1d5cd07@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 10 Sep 2024 12:44:14 -0600
Message-ID: <CAFLszTifWxDMmW=G_4w2f5bHU-FOg5nsmd4_EeOhwVSMzHzXFQ@mail.gmail.com>
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

On Fri, 6 Sept 2024 at 09:10, Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> Hello Simon,
>
> On 9/6/24 17:02, Simon Glass wrote:
> > Hi Jerome,
> >
> > On Tue, 3 Sept 2024 at 02:38, Jerome Forissier
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
> >> Reviewed-by: Peter Robinson <pbrobinson@gmail.com>
> >> ---
> >>  Makefile | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/Makefile b/Makefile
> >> index f90e48f58a5..dc7bdd79420 100644
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
> > I've lost track of this, but did you pull in [1] first?
>
> Oops! No I didn't :-/ In fact I could not find the reference to the patch
> in your initial email, then I forgot about it.
> Would you like me to resend the whole series as v4 with your patch included?

I just want to know that there is still a problem, with my patch. So
yes please try it and update the commit messages as needed for the two
affected patches.

Regards,
Simon


>
> >
> > Regards,
> > Simon
> >
> > [1] https://patchwork.ozlabs.org/project/uboot/patch/20240815195746.749042-2-sjg@chromium.org/
>
> Thanks,
> --
> Jerome
