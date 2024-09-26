Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8561CDE038
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 21:35:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CEB8688EE4;
	Thu, 26 Sep 2024 23:35:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="f9BmUkGC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B875D88EE4; Thu, 26 Sep 2024 23:35:11 +0200 (CEST)
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com
 [IPv6:2607:f8b0:4864:20::e2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F1EB988EF2
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 23:35:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-vs1-xe2c.google.com with SMTP id
 ada2fe7eead31-49bd40d77e5so502943137.0
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 14:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727386501; x=1727991301; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zH38WhbS3q90Q3hM+3cMEspIeeKuxSFaDSzR3/N/+/4=;
 b=f9BmUkGCtgE0eRKsyzDUUas5WIytsFjUPXCzvKDqITqzI51YBzfH4n197rKj6FOoJI
 uIFvk/D3nXX7nyyALK0kIBE7ObUpO/TKGsqBoqyVgwI6QoNU/V6nLuEY2FNkAl9C7v2i
 pHGBCQymoZUTB7abfUnq2z86MvDMzdE6RsFok=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727386501; x=1727991301;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zH38WhbS3q90Q3hM+3cMEspIeeKuxSFaDSzR3/N/+/4=;
 b=dQPuB8rygWjkEKmDtYDOCK3bDflCWLTec0KMOFraLzIPc9R1sScLk5ell9lv2TyrwK
 P2s5lLM8/423Qnr6L6rgFyp8XKk5rBSyC5VBGHj8C484OKlJGtmJTDVoh6uM85O7fKnL
 TvD8kQAjeQq3dfrMuKF8BRJJa0IAqoqKKC1jPWpcuDl4ZTb7V+gn6tIqWHAtQYnfuI2W
 wYbIRJbtIn2pazKRLVhb0LR9WbCgTnFOyxpHysrZZd8G2KyVib1ULdZyORsHWKt4Q7DL
 O4NN5k8EXkAwi0Z1HSG11SouIGeoTluyu8xIPEQq2CSaHkPVMdBQCcdvmSCZB/cOTf/2
 DxsQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWPI5sQHOoX/wa5w9eFTQT+1aI6wUKSKEWwHJfGNS1DUCBns6P5HFPyLVOYrN43S/efZJcmnFc=@lists.denx.de
X-Gm-Message-State: AOJu0Ywf7mfvA+wZLEH/QF1VZAJ6LEVG7y7vHi8AE3uq7QYaV5Z3fT8I
 6FjJF5BMsjow8zUebtDyAS5M1SO/JIpt0Fm3kaoY5CdZ1ENCk7Z+wI1EoM0FrYG139kTKySaSzg
 X2fSyOCYr0AkoQq98pHCt2vBqx/ZJ37VjNsJl
X-Google-Smtp-Source: AGHT+IGTg4ooCSfoe/IgfYGuKg7w9h8uyg5a1KuE0f6vMmmi2XP6BJqHhDqItILU8xkHfkWUnln11az5FeT415lXyuI=
X-Received: by 2002:a05:6102:941:b0:49e:94e8:acd5 with SMTP id
 ada2fe7eead31-4a2d8021925mr1328815137.22.1727386501421; Thu, 26 Sep 2024
 14:35:01 -0700 (PDT)
MIME-Version: 1.0
References: <20240911062511.494855-1-patrick.rudolph@9elements.com>
 <20240911062511.494855-23-patrick.rudolph@9elements.com>
 <CAFLszTg0cf_1ojqhO8ZXpkX+MoQYgX_-AFVzUDCyD2yE8U=rcQ@mail.gmail.com>
 <CALNFmy0QJ4HNHhSKzx94dJ6jS_F0i9VoDqUwwVpe2SCeLB=pmg@mail.gmail.com>
 <CAFLszTgf=_jJkfyXhxXDZSieMmM_cm7pss3ysM5yz1EphMYVpw@mail.gmail.com>
 <CALNFmy1oOCNr3Kp8gt6RsjkJT=ShkOpJnQuSwvq2+ftwWtoyOw@mail.gmail.com>
 <CAFLszTi4Jf2QZZqWd2pA35J1HPEZay=tkbbs94_eyFLJMuYOdA@mail.gmail.com>
 <CALNFmy3fyS2+Xw4OUv92jfbP_hCBwY6Fi_79fKV+aJOqSm7jVA@mail.gmail.com>
 <CAFLszThay6_ZixyHXW=1yhKkK_N4Q2QbmF+i=__p26t+LmiddA@mail.gmail.com>
 <CALNFmy1mMFp8JP7ZoRdD2jhPQcDyhCM7023dopQ7VLkoSHVnWg@mail.gmail.com>
 <CAFLszTi-dVVKRA9=8EROWphf3xYP+XZVW3Zb-ca_y8OPo135WQ@mail.gmail.com>
 <CAFEAcA8SqQsA-wFEYfxRMa2WCKSHnSQbkee41Lv4dSY=rGA08Q@mail.gmail.com>
In-Reply-To: <CAFEAcA8SqQsA-wFEYfxRMa2WCKSHnSQbkee41Lv4dSY=rGA08Q@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 26 Sep 2024 23:34:50 +0200
Message-ID: <CAFLszTjpJknXF4RcoKzpVTjjbUvP-HFptteNyfS8N35JY5z3zw@mail.gmail.com>
Subject: Re: [PATCH v3 22/30] board: emulation: Add QEMU sbsa support
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>, u-boot@lists.denx.de, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Bin Meng <bmeng.cn@gmail.com>, 
 Peter Robinson <pbrobinson@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Peter,

On Wed, 25 Sept 2024 at 16:23, Peter Maydell <peter.maydell@linaro.org> wro=
te:
>
> On Fri, 20 Sept 2024 at 16:59, Simon Glass <sjg@chromium.org> wrote:
> > On Fri, 20 Sept 2024 at 12:29, Patrick Rudolph
> > <patrick.rudolph@9elements.com> wrote:
> > > On Fri, Sep 20, 2024 at 11:37=E2=80=AFAM Simon Glass <sjg@chromium.or=
g> wrote:
> > > > On Fri, 20 Sept 2024 at 09:54, Patrick Rudolph
> > > > <patrick.rudolph@9elements.com> wrote:
> > > > >
> > > > > On Thu, Sep 19, 2024 at 4:10=E2=80=AFPM Simon Glass <sjg@chromium=
.org> wrote:
> > > > > The QEMU generated FDT contains a bare minimum of nodes and isn't
> > > > > suitable to boot an OS.
> > > >
> > > > Yes, I am not very pleased about that, particularly as my patch to
> > > > allow passing a proper FDT to QEMU[1] has still not been accepted.
> > > >
> > > The SBSA ref machine was designed that way, to make sure that only AC=
PI is used
> > > to boot the OS.
> >
> > Er, but doesn't firmware run before the OS? It seems like a strange
> > design decision.
>
> The sbsa-ref platform is supposed to be a reference platform
> that works like a real hardware system. On that kind of
> system (as I understand it) the firmware knows exactly
> what hardware it is running on (subject to some minor
> variations, which on real hardware it can query via
> a board-management-processor subsystem and which on QEMU
> for the moment are passed to it via a cut-down device
> tree format). Anything that wants to be first-booted software
> on this QEMU board should know (hard-coded, in any way it likes)
> what the hardware it is running on is.

OK, I see, thanks.

So I suppose it would be OK for U-Boot to include its own devicetree,
just for its own use, to configure the devices and generate the ACPI
tables?

>
> The general assumption is that that first-booted firmware
> will be the usual OP-TEE + UEFI stack. But if you wanted
> to write some other firmware to run on it there's nothing
> particular stopping you, same as there's nothing inherently
> stopping you from writing your own BIOS for your PC. (Though
> we do make revisions to the board occasionally which the
> firmware has to keep up with, in the same way that the BIOS
> needs to be aware of new motherboard revisions.)
>
> But if you want more detailed information about this board
> you'd be better off cc'ing qemu-devel and the listed
> maintainers for it, not me personally: it's not something
> I actively use.

OK, thank you. Patrick please get in touch as needed.

Re my patch, did you take another look? Should I try again on that
mailing list? I would very much like to get it into QEMU.

Regards,
SImon
