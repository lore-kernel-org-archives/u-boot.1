Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02EA8C54ED1
	for <u-boot@archiver.kernel.org>; Sat, 24 May 2025 15:29:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42DE582B0E;
	Sat, 24 May 2025 17:29:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="NG4q5mja";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E3D382B70; Sat, 24 May 2025 17:29:20 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1974482A9E
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 17:29:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-601609043cfso1257918a12.0
 for <u-boot@lists.denx.de>; Sat, 24 May 2025 08:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748100557; x=1748705357; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pDY9HcjQFZpPMIv+1X5tUwwozGB7pLwkiZxxvsTcrGM=;
 b=NG4q5mjaA8nJbeXVqyGO6GdRC+5fUdRQmMzP78B/Ia4/nQgsPuNJor5NdGRpheg2sN
 PWbKpxh+llrUzdadjFJ9G31S1vrvNgPYghbDux6+hXMld1vU7qaZaeWn98845IeJJbTo
 Ft1aroag/pDP2QAajDKTPAx8vfZ0bNggNaEpI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748100557; x=1748705357;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pDY9HcjQFZpPMIv+1X5tUwwozGB7pLwkiZxxvsTcrGM=;
 b=sFFyGVHJe8Wjbg4DoEEx1xhyVtuUs0ZQyVNN5A/9A22i9ugcunJon8pjogPoiGPTac
 UOQPXPLLC9jzndOwHFCGBgCdDSXOrQPKbu2P2XmIW5miwg+nbM43DWf0A87BZeByo1UI
 /NIBcY6xHaJtRv9BoYLsLPFwSifrw9hgJiDGGCMref7iq/SQYaY+J45gXJ2wVi99u4cl
 YNwBqaJDYdQaPeV72BPZVKUYVJJaXC0mgG0V36+68ji3H42QbJwyFxGtMob7Fh/AbSKm
 55YpZDR8eF0Rm1UZug6v6uC9agDTT+W0IbJdv3IJKW+Q2rvC9uimB9wEvQ/wmuk1/hrb
 Taig==
X-Gm-Message-State: AOJu0Yxv2IXbJ/l1t3L7indWLbnYboXmtXqJQCcE0+/cLdkDvl+PJkI6
 HzyJEMj15hjV8OxVzlLLibHliUxW6g6nTarrAsEtCJguQFMjwH662rKxiOqWO6rGXYKqfbxTsyY
 SzIGWDCQvwyoM2zHvMl0nwIUwbvsKHIEK0efPY/Mo
X-Gm-Gg: ASbGncvOu8d4oftCKKoF50vw5sCv/KBFY0UfMZIxViPKnUqkPDE59P5crNYpst70p+W
 z/DLmGp5RKpriBLIQq2o6zzhA3YDEQrrzfNZGG84jVEiPNxep7ojEe6lD7x3Mpag2Mw2KhSexO0
 5XA9unoglRvOoa1nEOWEiA3CjaJUFXskk=
X-Google-Smtp-Source: AGHT+IHEYsQgaz8qU+BL1GW/pUfy83zOxmWsOuwUSQ2X8OEz3QrIB1wHoMyFQTgRvVFpq9EiZQYkAwsf4u9Jf2d7Pco=
X-Received: by 2002:a17:907:961a:b0:ad5:58f7:6c8 with SMTP id
 a640c23a62f3a-ad85b2a3b4dmr243822966b.49.1748100557500; Sat, 24 May 2025
 08:29:17 -0700 (PDT)
MIME-Version: 1.0
References: <20250510134253.1581164-1-sjg@chromium.org>
 <20250510154214.v4.9.I56d9d06e5d74724c963eaffbbe1c2aa400b60bb8@changeid>
 <20250514215821.GD603748@bill-the-cat>
 <CAFLszTg2vMEVSR--ksh9cVRHBQWxzC++Nf83iDq7utUwku8Hrg@mail.gmail.com>
 <20250515205413.GD100073@bill-the-cat>
 <CAFLszTgHg6VfuJbTwdbkfAu4s-ZG0EpZ+6W5i13vC5iu=c+16w@mail.gmail.com>
 <20250524145313.GP100073@bill-the-cat>
In-Reply-To: <20250524145313.GP100073@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 24 May 2025 16:29:05 +0100
X-Gm-Features: AX0GCFuWmqFyqxOBMtvlVhGGnm3FdTulpMtH0wS0LmXQF820Rn1Y93n68L_2Ank
Message-ID: <CAFLszTh0+8eDAwu7AxcZ28W_sSEGPGSKufh9PY9ZDr=U-F-a1Q@mail.gmail.com>
Subject: Re: [PATCH v4 09/22] passage: arm: Accept a passage from the previous
 phase
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Raymond Mao <raymond.mao@linaro.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Bill Mills <bill.mills@linaro.org>, 
 Andrew Phelps <andrew.phelps@canonical.com>,
 =?UTF-8?Q?Fran=C3=A7ois_Ozog?= <francois.ozog@linaro.org>, 
 Albert Aribaud <albert.u.boot@aribaud.net>,
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Xu Zhang <423756212@qq.com>
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

On Sat, 24 May 2025 at 15:53, Tom Rini <trini@konsulko.com> wrote:
>
> On Sat, May 24, 2025 at 03:31:08PM +0100, Simon Glass wrote:
> > Hi Tom,
> >
> > On Thu, 15 May 2025 at 21:54, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Thu, May 15, 2025 at 09:26:42PM +0200, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Wed, 14 May 2025 at 23:58, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Sat, May 10, 2025 at 03:42:07PM +0200, Simon Glass wrote:
> > > > >
> > > > > > Accept a bloblist and control devicetree from a previous phase in
> > > > > > registers 0 to 3, as documented in the Firmware Handoff
> > > > > > specification[1].
> > > > > >
> > > > > > Note that there is currently a weak function called save_boot_params()
> > > > > > which happens to save the same registers as are needed for this
> > > > > > protocol. But it seems better to implement this feature as a first-class
> > > > > > citizen, if for no other reason than that many boards have their own
> > > > > > version of save_boot_params() which may not happen to save the required
> > > > > > registers. A weak function is not a good basis for an API.
> > > > > >
> > > > > > [1] https://firmwarehandoff.github.io/firmware_handoff/main/index.html
> > > > > >
> > > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > ---
> > > > > > While some efforts were made to encourage Intel to adopt this
> > > > > > specification, this has not yet been successful. However I do intend to
> > > > > > use my proposed x86 handoff in U-Boot, once this series is in.
> > > > > >
> > > > > > Changes in v4:
> > > > > > - Update commit message to indicate this can only be for ARM at present
> > > > > > - Update commit message to mention why save_boot_params() is not used
> > > > > >
> > > > > > Changes in v3:
> > > > > > - Add support for aarch64 also
> > > > > > - Update registers to match the Firmware Handoff protocol
> > > > > >
> > > > > > Changes in v2:
> > > > > > - Use three registers instead of two for the entry
> > > > > >
> > > > > >  arch/arm/cpu/armv7/start.S | 10 +++++++++-
> > > > > >  arch/arm/cpu/armv8/start.S | 12 ++++++++++++
> > > > > >  arch/arm/lib/crt0.S        |  6 ++++++
> > > > > >  arch/arm/lib/crt0_64.S     |  6 ++++++
> > > > > >  4 files changed, 33 insertions(+), 1 deletion(-)
> > > > >
> > > > > This is what makes me think you aren't actually working on my feedback
> > > > > about taking what we have in-tree, now, rather than just forward porting
> > > > > your old series and deleting the current code.
> > > >
> > > > Well, yes, I sent this v3 series because I had thought you were
> > > > willing to allow me to maintain bloblist. I certainly appreciate the
> > > > work in this area, though.
> > > >
> > > > >
> > > > > We have save_boot_params doing exactly what it should today, including
> > > > > saving off a standard passage and making what was saved available later,
> > > > > in an intentional fashion. If, hypothetically, Pi needs to override
> > > > > save_boot_param because a future new-firmware-blob does standard passage
> > > > > but at run time we want to support both, that's a good thing.
> > > > >
> > > > > With commit ea3348ebc215 ('Merge patch series "Handoff bloblist from
> > > > > previous boot stage"') we already implement the specification in [1]. It
> > > > > is not a "which happens to". It is intentional.
> > > > >
> > > > > I guess the overall challenge here is that you want to do things which
> > > > > are a superset of the firmware handoff spec itself?
> > > >
> > > > Yes,, much of this series relates to putting some structure into
> > > > things which are passed via standard passage, including validation.
> > > >
> > > > I actually don't understand why you would be keen on using
> > > > save_boot_params(), a weak function, used for board-specific features,
> > > > to implement standard passage. We should build standard passage in as
> > > > a first-class citizen. I certainly don't want to try to implement
> > > > things that way on x86.
> > >
> > > You seem to have misunderstood a lot of things and perhaps need to go
> > > and re-read the feedback. Nothing about a weak function implies less
> > > than "first class" and "maintain the code" does not equate "delete and
> > > replace functional code with the same thing, but I wrote it". And if you
> > > aren't going to do that, please don't bother posting a v4 either later
> > > this week. I feel like I'm having zero progress with you taking my
> > > feedback on anything at this point.
> >
> > Are you completely set on the idea of a weak function here?
>
> Am I completely set on following the general architecture and design we
> have and not making needless changes? Again, you seem to have either
> misread not not understood feedback and are intent on doing what you
> want anyhow.

The save_boot_params() mechanism is ARM-only and is not suitable for
standard passage, IMO...

So can you just tell me whether you are willing to have the registers
saved in global_data early in startup, in assembly code? I want that
before progressing with standard passage on x86. I don't need to say
yes. I just need a clear answer, so I can decide which path to take.

Regards,
Simon
