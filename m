Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BF3EE77188
	for <u-boot@archiver.kernel.org>; Thu,  2 Jan 2025 16:00:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 655408007D;
	Thu,  2 Jan 2025 17:00:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="f585DIKj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A4D480196; Thu,  2 Jan 2025 17:00:17 +0100 (CET)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83CE08001F
 for <u-boot@lists.denx.de>; Thu,  2 Jan 2025 17:00:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-2f44353649aso12807973a91.0
 for <u-boot@lists.denx.de>; Thu, 02 Jan 2025 08:00:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735833613; x=1736438413; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fnKQldvjb3oaBEhtZSf2f5L2sr6kHexZ4w+lK+p3JC8=;
 b=f585DIKjWiIxiT9PjMlILroJQBn7d2nocRXpl88//YF7hAptr/34vd/S5ZAyp9hFC+
 QIXcP7AQRwbB89oPnVYfUm+gC4dDXhqv/ilF4A3jdjCLNaLA/PN5aJtUDtd0gO5wKwtx
 do6cRGBUffV80fDtD7ejeiPfza6dDg7C6fERbl/Jk2grIyXSefT5BAzGfIkjkeREqVF2
 PEGoa0I+APrba0u5F9rLyv/fLQ2C2hsC0DN/MpHbeSbWjiJkoUCl3GOzWeHS1NL5s36m
 Wm2qa6mBdYzvdPvPix0XpRyZKjXP53SUtudmvhyqHfnob3Ffxy4InNzcuJ9iXMri3zRU
 PE2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735833613; x=1736438413;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fnKQldvjb3oaBEhtZSf2f5L2sr6kHexZ4w+lK+p3JC8=;
 b=Pg0/jLIIwxPKnvv5MPQ8lmrH06neyiZRTEPeL3iTWzG2vK+b4Xrtts8aG30MzGTPkl
 qAiOEDh4FdHPLAxxP+lhV1kBbvwmGZWG+WoRuNDD603qbfdFDYEXT8M2wNbmmT+GYOoq
 ZWsQhzBMBsKNaM34KaK8JfU+gafNz3zWh7PzizPz+FjZ9zeLo9/d0HTF8zfY9G4oFNyH
 KwVSaROfUhLsOu7d3CAzasGMUMB5sH4TOADx/XlrDqxChB73SJvUk+6qGqowGYjm9Bu6
 4dqi8ygaf/KQjjjVZkzz6QBX4aIEU6Zu9G9F6y3GddeEBf+mprGMK/mQ6aLrnv92H0fx
 1UWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVPMS2z2QUbGsavrjr3VUbXia0nV0UzCG0QOZeodMIEcH7LbFCADpul8UAd1pdxpzhHJHO2JFw=@lists.denx.de
X-Gm-Message-State: AOJu0Yycv79yMtHxVWFj/ebfE8sqKO4mTIc7Al+Po1+smEa5UBQNslei
 thRKE5/VeraTwA2eL6Eh1HZ3gh/0mXKzr79GfwuzhPRhtYTrAQgY2muIOxxksYTeXzSZ6Igm0KB
 oX5BoOeyDLo3ksw7J8y4I76SeuBvypG5fNOB+UQ==
X-Gm-Gg: ASbGncuQTXWS41/c4jMzLFwZsDbeAZlIg8rGDJ426HnUJ7VpkDXQ5RO9mKV8eIlTyPx
 lLLKJABlCQpo6rHaAqMpK1kU0NYQGcPFXImHiko9VhrYKFSKD88krKDt5pVteAHDzDY8yyZ4=
X-Google-Smtp-Source: AGHT+IF7PMlL10cmSMha7h7u95sD5VoueSYMGukOOThc8bntJpEk2edJL525WyRcpYsXko4j6yqkiUbSfkImS8khKRg=
X-Received: by 2002:a17:90a:fc4f:b0:2ea:5054:6c44 with SMTP id
 98e67ed59e1d1-2f452eeb641mr57951429a91.31.1735833612772; Thu, 02 Jan 2025
 08:00:12 -0800 (PST)
MIME-Version: 1.0
References: <CAEfUkUKA9raUu0dANWf25aw6kBzu-DKshctQxVre57bEiN94kA@mail.gmail.com>
 <CAFLszTh4hjCHAoqkr+zdeBeq5rCoaO3aSjBVvFyCYVLoccPSUw@mail.gmail.com>
 <CAEfUkUJ8MrFoS3k9svxNoiYsZq51SS_=+TpKKeH=x2jPXRjPtQ@mail.gmail.com>
 <CAFLszTgaSGEhRbdwhn=SjPkH1-tEW63D8+H2_1ZUtsfxWfZBRg@mail.gmail.com>
 <20241216183014.GH1505244@bill-the-cat>
 <CAFLszTg3YgBABRqFOmzaz5KT1ipqmuFxTd1NX1x2yQz2rNgjZw@mail.gmail.com>
 <CAEfUkUJsdH=YjcN4V8Fe8Vfa2Sdb4PQJZxKe6y9RaRXcJgX_=Q@mail.gmail.com>
 <20241219163604.GV1505244@bill-the-cat>
 <CAFLszThG6SY-BvZQ_FzZ+AT+w0NSVmS_iS+nvCWaqoxVRvv6dg@mail.gmail.com>
 <CAEfUkUJhuCB-5dXt1+FKMAk1t_N_sO6qAZHMK5NJrV7coGH6MA@mail.gmail.com>
 <20250102154844.GO3476@bill-the-cat>
In-Reply-To: <20250102154844.GO3476@bill-the-cat>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Thu, 2 Jan 2025 11:00:02 -0500
Message-ID: <CAEfUkUJvm-Co4sZLbJEXTey3HPjTdEs33HBZzSY0BrVcMi=rYA@mail.gmail.com>
Subject: Re: [PATCH 2/2] tpm: get tpm event log from bloblist
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, Levi Yun <yeoreum.yun@arm.com>
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

Hi Tom,

On Thu, 2 Jan 2025 at 10:48, Tom Rini <trini@konsulko.com> wrote:

> On Thu, Jan 02, 2025 at 10:25:15AM -0500, Raymond Mao wrote:
>
> [snip]
> > As I said, we need an kconfig here to decide whether a user should look
> for
> > TPM log (and all other handoff information defined by the Firmware
> Handoff
> > specification) from the bloblist or not.
> > We don't have such kconfig now.
>
> We do we need this knob? I don't think that we do. The case of bloblist
> not existing where we looked for it needs to work. And the case of the
> bloblist not having an entry needs to work (or if it *must* exist,
> that's a separate option to add, ie CONFIG_TPM_BLOBLIST_LOG_REQUIRED).
>
> I think this kconfig should not be only for TPM log, but for all general
blob tags which are required to be handed over.
User should have a choice to hand over *all* required handoff data from a
blobllist (if exists) or to stay in each data's own legacy way (from DT or
whatever)
Aka, the switch should be general and "one for all", otherwise, we have to
add multiple CONFIG_XXX_BLOBLIST_REQUIRED in the future.


> > > > There's at least two sets of challenges here. One, being solved by
> > > > vexpress64 right now, is that we didn't have CONFIG_BLOBLIST_PASSAGE
> as
> > > > an actual option. And in that case, there's no U-Boot before full
> U-Boot
> > > > and the bloblist exists for us. Two, U-Boot is what is creating the
> > > > bloblist. The contentious parts are *when* it's created and *where*
> it
> > > > resides prior to full U-Boot seeing it.
> > >
> > > There isn't contention, so far as I am aware. The normal case is that
> > > U-Boot creates and uses the bloblist itself. Pre-U-Boot blobs (like
> > > TF-A, sadly) are not the normal case and should be discouraged in an
> > > open-source project. That doesn't mean we shouldn't support them, but
> > > it is the tail wagging the dog.
> > >
> > TBH, I am confused with this statement which means we should not use the
> > bloblist library from the beginning to hand over data from the previous
> > stage.
> > If U-Boot bloblist only intends to consume the data created by itself, we
> > have to introduce another library to do the handoff, like what was done
> in
> > TF-A and OP-TEE -
> > then finally we can have a standard handoff library that can be used in
> all
> > projects and keep bloblist as it was.
>
> Simon doesn't speak for the U-Boot project, he speaks for himself. I
> don't see why U-Boot shouldn't look for an use a bloblist for things
> that need to be passed from one stage of the boot process to another.
>
> Thanks for clarifying this.

Thanks and regards,
Raymond
