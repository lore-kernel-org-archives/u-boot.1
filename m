Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEAD9CD5BC9
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 15:33:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D59D84910;
	Mon, 25 May 2026 17:33:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Ak+b69LH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 89F05848BD; Mon, 25 May 2026 17:33:38 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81DFF8490B
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 17:33:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-676a89de629so15741120a12.1
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 08:33:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779723216; cv=none;
 d=google.com; s=arc-20240605;
 b=WcTRRMw4lNsAEjJO3fdUVdOh778RwXDxduzTzzMbd+tgCMijJjcRd2EaGJj9bRPywL
 XoMSMEG1G6XQQsAWOtdTzNmreSOclLoPFVudn6ZjUsqpUMTU9W9cLNrF0mbsBikMXGbl
 gtZ87c4tEKElx3dtCEGwueeEQg14rHdtPAjuohFDApQ39WnQca645BFDtUwJDsAUgbkG
 xNXAWixJ3NiAFRH+HRO2syxhacFzR8wKaRAJVfY2p3RDtrRseSkwO3EbPB/SVDeEvLgc
 Gvh1yOuCBKxQ0vyjs8f7IHQLmGaet8HsOwNhRbssfYP1Yexhw1C7OYQW7F9BsLI3Q7FQ
 XoIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=9ktOh4vMsUI2cLvobyqjENpK9s3ZvKLAG4VGIaCAy8g=;
 fh=MOD6hw9Djui+qXsuEGlmQPnf0OPxFD99Ag3W5f9wWHc=;
 b=NJXGagW8kw27GY70JKm131VLACNhU3qWZAQAaNN0r7Beka7H8ydIdnoFMyd0T4QVwF
 iDJwq8uUA9LJTT3ZBM1RBJm8iENVjeV0qJ3z4l2OlfJTW4NhPi6AtBCPXaMvfnbQliFa
 x5NyDZBldHSCScugrxsjYpmFXfDN3hnCxlqtoJt4QwkwI5dnub2jNHdQU5yOCH7virx2
 yXH7WhMiyS7l4T7x7isumgWc25JZcSHnPw/unjk37bkR6hWYCdVvqnDD+mlkxhLCh2dE
 yz2Kb/S1+5REB2iceHFea9C11IY+Xu/tONr6fWmUfIwprDHjPsVQi/ZJrC8GecuFDBJb
 QDMw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1779723216; x=1780328016; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9ktOh4vMsUI2cLvobyqjENpK9s3ZvKLAG4VGIaCAy8g=;
 b=Ak+b69LHLAMJbe0t7JyrzXBnkF6dZ7VapeJ7zfNcNrXjew51bNcdfjsWCEJipgxEGN
 ZBgLS7EAkOHltrevJ6fHT7GqHF7YX1c4iFnr+KbWLR7t2snCNKQkejz9iHCVyhyMeELQ
 QTwRPZePK+KvGSHp/7VteNLxLaEfxMVDeBV08=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779723216; x=1780328016;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9ktOh4vMsUI2cLvobyqjENpK9s3ZvKLAG4VGIaCAy8g=;
 b=AgyBehRsvjeUk/RWrm4RVrHc2CB3HN+IGEQE8N2bgThDdJEX0VgPnQ9H4Xw8Yg0J7t
 dxLIRGJImoKCuqt4RKmkOM4p80Sp5RsS76YtC26gkyQu09Qthw1ZcU6C6oNuI6DZq/oF
 KQ7BAMv+GkhR9JD4uTRQB3hQrFdL1fM2Pf5UsR5KMHPC/q4FLYEvmIe8yGqsCXe8M4Hn
 s30dlLd0Rj/N8zTaQn2IF4L8h6MzpgLnYvK2tcgM0Ypa9h7fntW6uQf66vcSohsvYvoW
 f79Vw2j+kwvO+8PQuofBKEceuzPJ2mQISjGU6apeJR41eo8+db5ARC+PJTrWsrSJ2983
 6kfQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8ZcRUV0vxey7dQeeYQjXGtcepXjcn3pFF17LjRa2uc5yONgpAiGXKO7yrDOT5mVNbsOhhzOSI=@lists.denx.de
X-Gm-Message-State: AOJu0YxbP6OfMOZ4HMrW6W62XmqZ8sBojsu/LCHpTnz1i3Mgz906Xc0F
 zkk2RHR3+stAc12hIxEQ50Oirpvfw9gSD5h4GQMOg3tFgQdUeBLb4QQJEu3+lqiy5P797a9qQ0u
 sL82JcUqiL3eEQizLv2c3x019Eg8LJiu6uCux63zm
X-Gm-Gg: Acq92OGXb4xvYEiYSmmzew05cmgDgjJaj2mXu9mhwDv/t0KtpS7KFiMymP+fRAEEEEV
 vuH1mopANBKtYED+S1d2C59vARYuPacOEYLGnFPGMANgE8eUpdZb4sRrxxQaDHre2q0X+vU5XtX
 nAp7yNldTQsbgZ26rsrueeHcB4AUjbyhhJWL3DFfuzvymQePR8H5N81NCGkDVockxPAOSw/gzOa
 1DMIwfyftKYdXNBJTr7vWD0UNAFXsPkToxDfEMTps8+V2YC0D0HOq7yTNxvQ2vJajTXjQp7GtQT
 pkQav2F2NeGO3LVYWsROVL2OtT4=
X-Received: by 2002:a17:906:9d0b:b0:bde:4dd2:6312 with SMTP id
 a640c23a62f3a-bde4dd266cemr476027666b.37.1779723215838; Mon, 25 May 2026
 08:33:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260522212756.3169222-1-ravi@prevas.dk>
 <20260522212756.3169222-3-ravi@prevas.dk>
 <CAFLszTgmEKG7+8RJnXbdfy67pJ3U8u15-NcmT2Y1K2L5uSt+8g@mail.gmail.com>
 <20260525152254.GM1858239@bill-the-cat>
In-Reply-To: <20260525152254.GM1858239@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 25 May 2026 09:33:24 -0600
X-Gm-Features: AVHnY4Kq1CGEoygolMCIIcP_I4kZ4JsYyG9w7X9CPqr4g84yyM48EVnewzc_F28
Message-ID: <CAFLszTg5QevFu2C9GvMazd4ioi9msvjiFy_rK4on_YfXHki2zw@mail.gmail.com>
Subject: Re: [RFC PATCH 2/9] linker_lists: Do not set "unused" attribute
To: Tom Rini <trini@konsulko.com>
Cc: ravi@prevas.dk, u-boot@lists.denx.de
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

Hi Tom,

On Mon, 25 May 2026 at 09:22, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, May 25, 2026 at 09:02:02AM -0600, Simon Glass wrote:
> > Hi,
> >
> > On 2026-05-22T21:27:48, Rasmus Villemoes <ravi@prevas.dk> wrote:
> > > linker_lists: Do not set 'unused' attribute
> > >
> > > Whenever we declare something to be in a linker list, we want it to be
> > > included. This is why all of our linker scripts have a line similar to:
> > >         KEEP(*(SORT(__u_boot_list*)));
> > > to ensure that any linker list found in any of the archives we are
> > > linking together makes it to the final object. Remove the places where
> > > we set an attribute saying that it is unused, or maybe_unused.
> > >
> > > Signed-off-by: Tom Rini <trini@konsulko.com>
> > > Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
> > >
> > > include/linker_lists.h | 9 +++------
> > >  1 file changed, 3 insertions(+), 6 deletions(-)
> >
> > > diff --git a/include/linker_lists.h b/include/linker_lists.h
> > > @@ -69,7 +69,6 @@
> > >  */
> > >  #define ll_entry_declare(_type, _name, _list)                                \
> > >       _type _u_boot_list_2_##_list##_2_##_name __aligned(4)           \
> > > -                     __attribute__((unused))                         \
> > >                       __section('__u_boot_list_2_'#_list'_2_'#_name)
> >
> > The commit message conflates two unrelated things:
> > __attribute__((unused)) and __maybe_unused are purely warning
> > suppressions; they do not affect whether the symbol is emitted, kept
> > by the linker, or seen by LTO. The thing that prevents removal is
> > __used (and at the linker stage, KEEP()).
> >
> > The real reason removal is safe is that none of these declarations
> > would have warned anyway - ll_entry_declare()/ll_entry_declare_list()
> > produce non-static externals (no -Wunused-variable for those),
> > ll_entry_start()/ll_entry_end() take the address of start[]/end[]
> > inside the same statement expression, and the symbols from
> > ll_start_decl()/ll_end_decl() are referenced by the caller (cmd_ut.c
> > is currently the only one). Please reword the commit message along
> > those lines; the KEEP() stuff belongs more naturally with patch 3.
>
> I don't think your analysis is correct. They are not unrelated things,
> they're very much related and were really incorrect at introduction a
> decade+ ago (and pre LTO) but I don't think it was worth adding a Fixes
> tag.

I mean that the compiler will warn if you declare a static symbol but
then don't use it in the same TU (hence the need for 'unused').
warning != inclusion/removal. I haven't quite figured out whether
those warnings have gone away, or something else has changed. It will
be easier to see when I can build this branch.

Regards,
Simon
