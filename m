Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC0E0C369CA
	for <u-boot@archiver.kernel.org>; Sat, 19 Apr 2025 19:22:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C88A8820FE;
	Sat, 19 Apr 2025 21:22:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="KlSOuaKI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D525F8210D; Sat, 19 Apr 2025 21:22:20 +0200 (CEST)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F147E820F6
 for <u-boot@lists.denx.de>; Sat, 19 Apr 2025 21:22:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=heinrich.schuchardt@canonical.com
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 5C2CB3FE57
 for <u-boot@lists.denx.de>; Sat, 19 Apr 2025 19:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1745090536;
 bh=rod5apMTrVygfcAixBGO+C8j6sew5xfydTYA+PTnybA=;
 h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
 To:Cc:Content-Type;
 b=KlSOuaKIqatoRsi0QN/LeOtE86SNC7dFGvFXrZV3N+5MHSeqpafLWTl7NcFhzCXs3
 cWhy/le8e3vjZ8mgRNIiMAhsVBHHGD3R6u2jYUQxFCf1ffMFwcUuKRGSGsetynyhjG
 EAEcBGpvozH22IG+6fe+3kaJOEZ7e9OocgXmhCl3sqQPDPAaQYDGlmq1pVoCNMq/LK
 q5eD0prkt4x4oEL0+SwM28uRIYv093WmKevXpSAnyueKVKsNQuArXoST0DklnuWU/C
 K7sqWEoYv2pjiw9R32Qg05lO1FvhbhxdA+kUBmH3igPW7rsewIUxFUMB1t1lR9dOXN
 TyGo9y80nuhxw==
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2240a96112fso42527075ad.2
 for <u-boot@lists.denx.de>; Sat, 19 Apr 2025 12:22:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745090534; x=1745695334;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rod5apMTrVygfcAixBGO+C8j6sew5xfydTYA+PTnybA=;
 b=D+FuReF2f6hAmuDJkDOJE+W4CTtTkkOkZJxq9Wrql9cPD4LPi1jTzQsJpFebqRFI1L
 4fPWzNvQj7EtkMkzf7BGodAQBa2TXYVN6Nt4ODuziIs80hLkqitL4fhq9rtiuuOf53jS
 5NRAwqw96qdGxaTWa0QRn3C8avTsP2PaV645xYyk5T63Hzm4p0vpuLEo7CG08Ods9PM7
 JYpPXHNYax2/FRHslOkVfx9LysP4qcdy0WkzHkbyZ9yYisMAC8l6UEP3QevR7CSIGFDX
 NEK2AZ4mroYvzpr3YMsXGhpL0Li+uaQ5kIKaCNCi7Tk8D2fX38fELf5Z3oVg77KFVl2e
 1INw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUCzswtH1cTMlrSxtlCOomCkuBq9J+OtyAgKHcFLdil1mzNrXDu1pJMYHjdj9n3gVYbF27lA9E=@lists.denx.de
X-Gm-Message-State: AOJu0YzesCoFFW1r3uZxTEyThHv63rzdDch+Lamgr1UG0JxOF2VjuUzQ
 Oihq7nSlggnNfrc85QmCmDmqpyhG91BtWH3qVlAG94DZnIyoJWegN7ZM59gt4nnUAlYoV9aKjdS
 FNepHTlWc37zaTVStKWdYqKhfavlw2odzLgiRENn26TJY4rdBq86mpXu1XukujrlgaqJEid5Te6
 XTjO635jPIdMEzZSHuwigjxf+2qZIInguSCxlPWilCkw==
X-Gm-Gg: ASbGncsbagfAj9VGTsE0BMMArNdQ7W5nyAXZkvqISijYSAQGGvISyygdPX1NgvetTHY
 wD62slS5+bUFkzpUsAmrKRH78y4HoYff44XBxRhUbglokhp0HS/nsHg3RrFR+HUtoRw==
X-Received: by 2002:a17:902:f54c:b0:216:3c36:69a7 with SMTP id
 d9443c01a7336-22c5361b628mr80616265ad.45.1745090534314; 
 Sat, 19 Apr 2025 12:22:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGaR+k8gf+dEOqPxILquH+UFv9qRwGTDhgi2iFvsTdmtBvlTUPWG4dW2hQ/Q+TpIqTXxhGTQY4P4GsYfAEQ/ow=
X-Received: by 2002:a17:902:f54c:b0:216:3c36:69a7 with SMTP id
 d9443c01a7336-22c5361b628mr80616015ad.45.1745090533827; Sat, 19 Apr 2025
 12:22:13 -0700 (PDT)
MIME-Version: 1.0
References: <20250416224032.144791-1-heinrich.schuchardt@canonical.com>
 <20250416224032.144791-2-heinrich.schuchardt@canonical.com>
 <d8f9a58a-10cd-4366-bd6f-85f4effc747c@cherry.de>
 <CAFLszThDLbf3fQySO_8u6OD3-BK2abE6NFVhvviRtrNs=PKdsA@mail.gmail.com>
 <d448af91-ebe1-432c-ae20-3e8eb2efddf1@canonical.com>
 <CAFLszTh29kgQ_bE8_gnORWH0PQ=H94=q7757mFOfiopCUL3eTg@mail.gmail.com>
In-Reply-To: <CAFLszTh29kgQ_bE8_gnORWH0PQ=H94=q7757mFOfiopCUL3eTg@mail.gmail.com>
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Date: Sat, 19 Apr 2025 21:22:02 +0200
X-Gm-Features: ATxdqUEP1fBkJoKRfIotjg-SEvnAdebF6uiewo1gI64wjfHCheknzApmiXoKMPc
Message-ID: <CAM=mAOnLTX3ZB6ioyPOoR+wyNKoA2VnxCKFMUHrZyM_wpuGzOA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] buildman: allow specifying configuration fragments
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>, 
 Brandon Maier <brandon.maier@collins.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>, 
 Quentin Schulz <quentin.schulz@cherry.de>
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

Simon Glass <sjg@chromium.org> schrieb am Sa., 19. Apr. 2025, 16:14:

> Hi Heinrich,
>
> On Sat, 19 Apr 2025 at 04:20, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
> >
> > On 4/18/25 13:39, Simon Glass wrote:
> > > Hi Quentin,
> > >
> > > On Fri, 18 Apr 2025 at 05:27, Quentin Schulz <quentin.schulz@cherry.de>
> wrote:
> > >>
> > >> Hi Heinrich,
> > >>
> > >> On 4/17/25 12:40 AM, Heinrich Schuchardt wrote:
> > >>> Currently we are no able to build with configuration fragments in
> our CI.
> > >>> With this patch buildman gets a new argument --fragments for passing
> a
> > >>> comma separated list of configuration fragments to add to the board
> > >>> defconfigs, e.g.
> > >>>
> > >>>       tools/buildman/buildman \
> > >>>       -o build \
> > >>>       -k qemu-riscv64_smode \
> > >>>       --fragments acpi.config
> > >>>
> > >>
> > >> What about using:
> > >>
> > >> --fragment acpi.config --fragment fragment2.config
> > >>
> > >> ?
> > >
> > > Yes that could be useful. It would also allow wildcards, although the
> > > code would need to drop the config/ directory prefix. Also, I see that
> > > -z is available so perhaps that could be a (bad) short option?
> >
> > Hello Simon,
> >
> > What do you mean by useful?
> >
> > --fragments a,b conveys the same information as --fragment a --fragment
> b.
> >
> > We are not passing any config/ directory with the fragment names.
> >
> > Using wildcards in does not depend on how fragment names are passed.
> >
> > As maintainer of buildman, please, clearly express how you want the
> > fragment names to be passed. "Could be useful" does not indicate any
> > decision but let's me hang in limbo.
>
> NAK
>
> We need a file which lists the valid boards for each config fragment.
> Buildman should parse that and it should be possible (with an argument
> like --build-all-fragments) to build all fragments for a board (or all
> boards), to make sure that things actually build. See [1]
>
> So until that is done I'm going to NAK the whole concept[2].
>

Building all possible permutations can easily result in excessive numbers
of CI builds.

We have been breaking ACPI builds multiple times and now you block testing.

I am not amused.

Best regards

Heinrich


> Regards,
> Simon
>
> [1]
> https://patchwork.ozlabs.org/project/uboot/patch/20241108152350.3686274-9-sjg@chromium.org/
> [2] https://lore.kernel.org/u-boot/20250329002537.GN93000@bill-the-cat/
>
