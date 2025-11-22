Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72CCCCFC538
	for <u-boot@archiver.kernel.org>; Sat, 22 Nov 2025 14:31:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8DCBF83AB8;
	Sat, 22 Nov 2025 15:31:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="R4j3PGeL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F0A683AEF; Sat, 22 Nov 2025 15:31:44 +0100 (CET)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B175683A2B
 for <u-boot@lists.denx.de>; Sat, 22 Nov 2025 15:31:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-64074f01a6eso5236354a12.2
 for <u-boot@lists.denx.de>; Sat, 22 Nov 2025 06:31:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1763821901; x=1764426701; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5SxHoRWwPkdET0s7hpH+a56Gvg0wwOFoibxD95G8xwk=;
 b=R4j3PGeL7h6Yq2G/x2zD7TRFHYbe6sKGZ6oy+XcLS2blbqGq9N/PxxUcHZ+rh4PX/3
 DMgoGsLC2zaBuaq93P0K7aPwZ7uCwiTRTA2rW1Q//0gycXmVI6Lj5lH69VLwwQrRIfzh
 I59WNcL1cmkXZ4j8d2vXR1D8huxMm+D0fRZiI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763821901; x=1764426701;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5SxHoRWwPkdET0s7hpH+a56Gvg0wwOFoibxD95G8xwk=;
 b=jYMRQz5HUWkbRKEMdzSy386ErAnp6otZQeZXDOZz8Q94RiPlsaOk/D7moFzdfxuOq2
 fhnmYgseTTSTo8T2lytFAj4wSRnJ+anjUiLUtbhoVd5p7+4yxk2IcbO7s/UhCaialPAQ
 In+bEHFiw0/LJ0X+QJRihvRGFYEFBRt3iH28Rf0CYuWY5QA7qashVE1Ts02wdd7F8T2/
 EnojjtUqrqdy5GfXmoVzk4cFndG/94h6XNNOtIgNBGqGmY4oqn7crG7Tohq/n+sebnpn
 hI5Akm0WOHJ70MTIFJmWbd0cO7NgFMxagmsUo0ZTu+iIIkB6FLYbZKwmjja4jUpITHe/
 U6yQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX7uxnDwI+V4ixzo1Ot1Cp+s32AzSk+NaDz4Z+p88R9flt+5vJCJV4wv8ScLykakCXP+LL2ta0=@lists.denx.de
X-Gm-Message-State: AOJu0YzztXlADJAQN8oYbFiR90lzmdg2yS9Jlm/A26WogGXFh8tx+0f0
 RjrDdguAlMz/cbNpRYXQKAkDphfivsnlYdyHzantlukTSDHp9I1NqiwAkCISO6RWQHl/4gkSV7e
 +Gvr4ecGVWyGJTq2MT+usZjJy1W6pRGUmSSlW2yBfBQlmN0qekLU=
X-Gm-Gg: ASbGncskxFhuLpFyC8X0o3uzAotKWOFrusGbpvNDZ4SDYH0APU64NvCMzEShnpG2dB7
 a8E/P0f+L3FblDYiUBWJ21q7pwjcQffKLwUSnYkrjDoddxjsyT7qLHEQhO2bUHfoUIxTEZRqIJN
 DyE4E4RpDc1Y1+Tk5n3S5IaSmCg7TFMkBYqUdxC2e82PXJ7mFtDO6ictPVz7QJcj79aKNL+UlLt
 CgN+wZziqmvcqQA2BaT737yBcfZbYwM/zK35PJ02KejpGOP6dqfITUhYw4n1QoRETSw8g==
X-Google-Smtp-Source: AGHT+IHdpxVXc5hpDPg92iu8TIoOmUs1mwUSNfh6gL4MBskCxq9pt/GCXPDgQUI0V5s+f7Vv2ro3aOQ1hU17Fb3Q/nc=
X-Received: by 2002:a17:907:9489:b0:b73:5acd:4650 with SMTP id
 a640c23a62f3a-b76717016dcmr600400066b.23.1763821901056; Sat, 22 Nov 2025
 06:31:41 -0800 (PST)
MIME-Version: 1.0
References: <12ddeda7-f0a6-4cc8-8728-ba979cf6cc49@mailbox.org>
 <CAFLszTghtOKZWaVZH+hYdWvwUWZUTVPZ_mqkW3MCHRH6wRN0iw@mail.gmail.com>
 <b7063159-f5d0-4f8d-be35-2e7fa5f8f750@mailbox.org>
 <CAFLszTjyXo9yh6Jzdaev9GhN8OZ4Z5xz9phgNHnKCvA0ASzbaA@mail.gmail.com>
 <60b12c96-4e63-4cf1-8c27-25eabead529c@mailbox.org>
 <CAFLszThg+6LdxHXOYy9x8-nat+bsspbUT8Dg_vqnmx62aO0a2g@mail.gmail.com>
 <a8fa7ff0-1324-4213-b45b-b4df637e6bee@mailbox.org>
 <CAFLszTgLjRT_x1+tX0xpBzTy9bDJSYXw=5gOBvvNSqdOZDiZoQ@mail.gmail.com>
 <c75bacd5-532a-4783-9f1f-02884eee7918@mailbox.org>
 <CAFLszThKSE7v6TJhfeP2jGTS=GkpVuDpYHNHh_fMFL9TSjrnqA@mail.gmail.com>
 <20251121192359.GC2125796@bill-the-cat>
In-Reply-To: <20251121192359.GC2125796@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 22 Nov 2025 07:31:27 -0700
X-Gm-Features: AWmQ_bmL8bTS7mw90k9gLk89feu44QSYPlgNc7MmW7MtaG-PYCL53SGwlNLRJsg
Message-ID: <CAFLszTh2o9uMgGcRPfNU4TDRZEqy8rpe75w3q6352PrN9bX=ZQ@mail.gmail.com>
Subject: Re: [PATCH] i2c: sandbox: Avoid calling dev_read_*() if
 CONFIG_OF_PLATDATA=y
To: Tom Rini <trini@konsulko.com>
Cc: Marek Vasut <marek.vasut@mailbox.org>, Heiko Schocher <hs@nabladev.com>,
 u-boot@lists.denx.de
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

On Fri, 21 Nov 2025 at 12:24, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, Nov 21, 2025 at 12:09:21PM -0700, Simon Glass wrote:
> > Hi Marek,
> >
> > On Fri, 21 Nov 2025 at 11:01, Marek Vasut <marek.vasut@mailbox.org> wrote:
> > >
> > > On 11/21/25 6:40 PM, Simon Glass wrote:
> > >
> > > Hello Simon,
> > >
> > > >>>>> - create a new VALID_OFFSET assumption (split out from VALID_DTB)
> > > >>>>> which checks offsets in fdt_next_tag()
> > > >>>>>
> > > >>>>> The latter might be best. It would likely be very cheap in terms of
> > > >>>>> code size. In fact, I should have thought of this at the time.
> > > >>>> Wouldn't it be better to not misuse libfdt ?
> > > >>>
> > > >>> It actually isn't a misuse. It is perfectly OK to pass an invalid
> > > >>> offset and libfdt has defined behaviour in that case, absent any
> > > >>> 'assumptions' we force.
> > > >>
> > > >> It actually isn't OK to pass in invalid offset if we compile FDT with
> > > >> disabled tree validity checks.
> > > >
> > > > We are saying exactly the same thing, if you read both of the above :-)
> > >
> > > What I wrote is, that it is NOT OK to pass invalid offset to libfdt IFF
> > > the DT validity checks are disabled. This is yes a misuse.
> >
> > Yes, of course. It IS OK if you enable the validity checks.
> >
> > >
> > > >>> Remember, in Linux these checks are enabled. We added the 'assume'
> > > >>> thing to reduce code size. Here you have found a situation where it
> > > >>> breaks stuff, so we should back off the assumption a bit.
> > > >> U-Boot also has those checks enabled, SPL does not, and things break
> > > >> when OF_PLATDATA is enabled and there is no valid node associated with
> > > >> the udevice.
> > > >
> > > > Right, so add SPL_OF_LIBFDT_ASSUME_MASK for SPL and check the code
> > > > size. If it is too much, add a new level FDT_ASSUME_EXISTS before
> > > > FDT_ASSUME_SANE and use that for the necessary checks (there will only
> > > > be a few, from my reading of the code).
> > > The SPL assumes the FDT is valid, and disables FDT validation in libfdt,
> > > to keep the code size low.
> > >
> > > U-Boot does enable that validation in libfdt, and grows its size a bit
> > > because of that (and also because the DT might come from outside), but
> > > SPL can not do that (and control DT does not generally come from outside
> > > in SPL).
> > >
> > > That is why these few fixes actually repair the misuse, instead of
> > > re-enabling the validation in libfdt.
> >
> > Enable basic validation if !OF_REAL ? Create a new level of 'assume'
> > for just what you need?
> >
> > It just seems really odd to disable validation and then try to not
> > call the functions in case they will crash. The next person who comes
> > along will have an unexplained crash. It's just too brittle.
>
> You seem to have missed the entire context of the problem here. Today,
> in upstream exactly one platform disables validation in full U-Boot.
> Exactly zero platforms enable any form of validation in xPL. Upstream
> dtc has made a large number of changes since v1.4.6. Whatever we have
> been assuming could be done cannot be done anymore.

I took a look at what I landed in upstream dtc, we have
ASSUME_VALID_DTB, so we should just use that.

It has very few checks. If we want one more step that really just
checks that fdt is not NULL, I could try to do that upstream.

As to my missing something, I am aware that we don't enable validation
in xPL (I still recall writing that code), but also that with
OF_PLATDATA enabled, we need some sort of basic validation if people
want to call dev_read_...() functions. My attempt to show that was to
add assert() statements in some of the ofnode functions. As part of
changing this, we should really remove those, or perhaps make them
dependent on the 'assume' value.

The key thing is not to solve the problem at the right level, rather
than adding lots of checks to avoid a mine.

Regards,
Simon
