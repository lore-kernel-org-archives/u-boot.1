Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 414E1CDB47E
	for <u-boot@archiver.kernel.org>; Wed, 18 Oct 2023 03:33:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3F0586F1A;
	Wed, 18 Oct 2023 05:33:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="ZEcBaCmk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A56EB86F1E; Wed, 18 Oct 2023 05:33:05 +0200 (CEST)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8CB2C86F08
 for <u-boot@lists.denx.de>; Wed, 18 Oct 2023 05:33:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2c503da4fd6so68840701fa.1
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 20:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1697599983; x=1698204783; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LTqPTy1OInyrLSQYhEXhAkVsIEehIqq5c7ecEh0VIfg=;
 b=ZEcBaCmk/RFeAp3AzIAQOrFQs8KeW0rkhlJsaDdU2qzSA/CucPx+0VaqB5n+6kBRtT
 TolGuxKDbrn+Yh/YYFtTu7q0q7bf8QRYneycOH+YwErP7eRWx8VEKdCIJ05TjdRBhXCT
 sw0uotoO8eC5yRwHCiSwlkUIA/S9KQnUVR0rkomq3uUxVKuYF2E7T2DE4zHwvaBIV0eh
 /y1X2D8LG5Mk4Cio3Q6aXPtZdmimmW1O+J/GPo64lbMAcI0xWWvXaeaZIAMn3WJtN3f1
 H/YtJ0B0VWilJqdmJDB/Ww1l7iexB70R5ELVBdVBvZXsoM/C4+wvXb+BFY4pyOhDTbfC
 ox7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697599983; x=1698204783;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LTqPTy1OInyrLSQYhEXhAkVsIEehIqq5c7ecEh0VIfg=;
 b=PSpBfqoj4QCVkRWgLdF50UQrYR8V4DGYrod6rmN7raeTpvpvXhrctEii228A0GyyuH
 Tyk1z+ptfEf36Jz048sVp2G4w+YahuntkN+9jaOwnbeltQQMbCecQ/TsEJFN0SjiNcfC
 rD5KfxrmZ5eU5K6WDclugy1AXFcyN5gEzvE589tK5+zj80p4A/iPY7F0FbUju9Q3YN96
 vBgagdcXPEzs49fl2j9PArMm2Fnti09gS7iJRuubeIjOuVZYn5KbutVdJWGestv+FxEo
 trYlIniJo9KEJTnc+8bchko0m238PTuZWUOFJPTqbViwE+ZhGIEb0Jjjxe4T16pCvFu4
 fMqg==
X-Gm-Message-State: AOJu0YzsEBKEY1vEbg0VAuFBMZau1L36TIMUNxNYEqMyzkiruIARArrq
 YGFcW43B6NNIzgR3LCJpcb1a81zzPLc4mbWoVQKHHQ==
X-Google-Smtp-Source: AGHT+IGSu129lWECH1HC8QqMOd0xdEkJwnJ2g7efmQw7gkQV4lDTU+POgAheu+QX9uWjXvnoSBRe7SkDFikkOzmg+fw=
X-Received: by 2002:a2e:b4ab:0:b0:2c1:375a:b37c with SMTP id
 q11-20020a2eb4ab000000b002c1375ab37cmr2766742ljm.40.1697599982456; Tue, 17
 Oct 2023 20:33:02 -0700 (PDT)
MIME-Version: 1.0
References: <20231017105305.417338-1-piotr.kubik@iopsys.eu>
 <20231017163547.GL3119521@bill-the-cat>
In-Reply-To: <20231017163547.GL3119521@bill-the-cat>
From: Simon Glass <sjg@google.com>
Date: Tue, 17 Oct 2023 21:32:51 -0600
Message-ID: <CAPnjgZ0LEG9PK2j3YRRzkxZO_Vxu_J11xFFN21nc+T=efxRNDg@mail.gmail.com>
Subject: Re: [PATCH] bootm: Fix flags used for bootargs string substitution
To: Tom Rini <trini@konsulko.com>
Cc: Piotr Kubik <piotr.kubik@iopsys.eu>, u-boot@lists.denx.de
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

Hi Piotr,

On Tue, 17 Oct 2023 at 10:35, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Oct 17, 2023 at 12:53:05PM +0200, Piotr Kubik wrote:
>
> > Commit <51bb33846ad2> introduced a feature of bootargs
>
> Checkpatch will complain that this should be:
> In commit 51bb33846ad2 ("bootm: Support string substitution in
> bootargs")
> And this is the kind of thing I would fixup on applying if there was no
> other feedback.  However:
>
> > string substitution and changed a flag used in
> > bootm_process_cmdline_env() call to be either true or false.
> > With this flag value, condition in bootm_process_cmdline()
> > `if (flags & BOOTM_CL_SUBST)` is never true
> > and process_subst() is never called.
> >
> > Signed-off-by: Piotr Kubik <piotr.kubik@iopsys.eu>
> > ---
> >  boot/bootm.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/boot/bootm.c b/boot/bootm.c
> > index 8f96a80d42..e96489e549 100644
> > --- a/boot/bootm.c
> > +++ b/boot/bootm.c
> > @@ -778,7 +778,8 @@ int do_bootm_states(struct cmd_tbl *cmdtp, int flag, int argc,
> >       if (!ret && (states & BOOTM_STATE_OS_BD_T))
> >               ret = boot_fn(BOOTM_STATE_OS_BD_T, argc, argv, images);
> >       if (!ret && (states & BOOTM_STATE_OS_PREP)) {
> > -             ret = bootm_process_cmdline_env(images->os.os == IH_OS_LINUX);
> > +             ret = bootm_process_cmdline_env(images->os.os == IH_OS_LINUX ?
> > +                                                                             BOOTM_CL_ALL : 0);

Oh wow that is a terrible bug. We have lots of test coverage of
bootm_process_cmdline_env() and below, but bootm itself is still quite
spotty.

I wonder if we could add something to run_fit_test to check this. We
have lots of tests for bootm_process_cmdline_env() but not much of
bootm itself. It might be possible to add just a few lines there, e.g.
to set the bootargs to something and check what ends up in bootargs?

>
> This gets hard to read. I would prefer a comment and something like:
> int flags = 0;
> if (images->os.os == IH_OS_LINUX)
>   flags = BOOTM_CL_ALL;
> ret = bootm_process_cmdline_env(flags);
>
> As the compiler should be just as smart, and that'll be clear about
> what's going on.  Thanks.

Regards,
Simon
