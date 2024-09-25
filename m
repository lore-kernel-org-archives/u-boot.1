Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDF17CF9C6B
	for <u-boot@archiver.kernel.org>; Wed, 25 Sep 2024 14:23:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF2B0889E9;
	Wed, 25 Sep 2024 16:23:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="vRE7gYB1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82B5388B5F; Wed, 25 Sep 2024 16:23:29 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD45287E30
 for <u-boot@lists.denx.de>; Wed, 25 Sep 2024 16:23:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peter.maydell@linaro.org
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5c5cf26b95aso2668830a12.3
 for <u-boot@lists.denx.de>; Wed, 25 Sep 2024 07:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727274196; x=1727878996; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9p0DEDIzaZpXd4+a2jLmosJz947kX64boWCC3n3PSUg=;
 b=vRE7gYB1MiIxL3+DRWKk5lyxKMlFBtkbH/Fuw0HfMOtF4YLT0aq+88YAEVt4D0yjTr
 GTlTlcVSsaYyl8YxmcBzX7I+ZEO1ZYnrDB9R0XrSsTB7a3nJTy35GxPO4v4zGxDYRgT8
 EFNkOSs7XoavSQZrE6ookALiRd7gTGRTz5oHpu2BlQMsAUYDYc1YdCDKEs+5uZqxVYXZ
 g7Zh8YPnZh5eMWJ/f3mQDrXtvXhqGbxAzqhV2SYS9VD8I21QIpNVPBWDn+Cusrj4U59E
 tB0tX+toI8gEpxM5Gr0GLo2JC7MBLxiJxZ5oRu8kEZMEM7hilBOsCxEV13juw91kki0F
 uiiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727274196; x=1727878996;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9p0DEDIzaZpXd4+a2jLmosJz947kX64boWCC3n3PSUg=;
 b=T+ahAVdAAcg28URc2rOEqtd1DH0oHJ+Z/VSgKwv3tvrqZeaxqXD5VFbSJYI8WCFqX1
 5t+GkwRKb+aZqm+h0Q0mlD5DfrHjYJcKe2aRWM4nHc3JB9FpwJco5UxMjcTgGQvx3rMk
 b0rGlq7eqZPmnK819isqrkDWBta/eJKbtrBlqCyQb5KgWH4gWnhxWfC7CtlWTDv7G9Hz
 T8Cl0ku3qKQgysTfaKf3PpYRvoV6L9scp0123b02JJ7soEgV4vF4oBROmki/mLMLWr3A
 fsAM3MTd/P/PyL0oaub4OWyrBRO/M+/u4JTdTqWj8wp4HS875fYwIih37taRdFj9aInM
 x3zA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRQxVn2hB7TjAPpEGkvqvOaDTbFqaMvt8DQAmGDAFdQQSRdGi/yRHM0l+S8tP80P/2RoiMgW0=@lists.denx.de
X-Gm-Message-State: AOJu0YzdnFsEbSBKsVMZR69ofhvPbgkRiPSn7flcI0uShzEJUNq/fTWD
 P2U8Tgx3gzd+uHlaRrFnNVCJfQyO1lt5uwV3T7jFHnZlVMa8YnqATulvtdnvLMs0xyawJhCljYf
 jzA+BILvxt7dQjHA8M3xz6zo92EI59j9x1SAn/A==
X-Google-Smtp-Source: AGHT+IEWXyvM5+AQDNQDcRpGzhx5ycxioE0wqy3AiDFKq+fEy406qNx/FeK66kPl/dySmOQHZsFYBFlGnW6d23Aqgag=
X-Received: by 2002:a05:6402:90e:b0:5c7:227f:3990 with SMTP id
 4fb4d7f45d1cf-5c7227f3c42mr1107452a12.31.1727274195931; Wed, 25 Sep 2024
 07:23:15 -0700 (PDT)
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
In-Reply-To: <CAFLszTi-dVVKRA9=8EROWphf3xYP+XZVW3Zb-ca_y8OPo135WQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 25 Sep 2024 15:23:04 +0100
Message-ID: <CAFEAcA8SqQsA-wFEYfxRMa2WCKSHnSQbkee41Lv4dSY=rGA08Q@mail.gmail.com>
Subject: Re: [PATCH v3 22/30] board: emulation: Add QEMU sbsa support
To: Simon Glass <sjg@chromium.org>
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

On Fri, 20 Sept 2024 at 16:59, Simon Glass <sjg@chromium.org> wrote:
> On Fri, 20 Sept 2024 at 12:29, Patrick Rudolph
> <patrick.rudolph@9elements.com> wrote:
> > On Fri, Sep 20, 2024 at 11:37=E2=80=AFAM Simon Glass <sjg@chromium.org>=
 wrote:
> > > On Fri, 20 Sept 2024 at 09:54, Patrick Rudolph
> > > <patrick.rudolph@9elements.com> wrote:
> > > >
> > > > On Thu, Sep 19, 2024 at 4:10=E2=80=AFPM Simon Glass <sjg@chromium.o=
rg> wrote:
> > > > The QEMU generated FDT contains a bare minimum of nodes and isn't
> > > > suitable to boot an OS.
> > >
> > > Yes, I am not very pleased about that, particularly as my patch to
> > > allow passing a proper FDT to QEMU[1] has still not been accepted.
> > >
> > The SBSA ref machine was designed that way, to make sure that only ACPI=
 is used
> > to boot the OS.
>
> Er, but doesn't firmware run before the OS? It seems like a strange
> design decision.

The sbsa-ref platform is supposed to be a reference platform
that works like a real hardware system. On that kind of
system (as I understand it) the firmware knows exactly
what hardware it is running on (subject to some minor
variations, which on real hardware it can query via
a board-management-processor subsystem and which on QEMU
for the moment are passed to it via a cut-down device
tree format). Anything that wants to be first-booted software
on this QEMU board should know (hard-coded, in any way it likes)
what the hardware it is running on is.

The general assumption is that that first-booted firmware
will be the usual OP-TEE + UEFI stack. But if you wanted
to write some other firmware to run on it there's nothing
particular stopping you, same as there's nothing inherently
stopping you from writing your own BIOS for your PC. (Though
we do make revisions to the board occasionally which the
firmware has to keep up with, in the same way that the BIOS
needs to be aware of new motherboard revisions.)

But if you want more detailed information about this board
you'd be better off cc'ing qemu-devel and the listed
maintainers for it, not me personally: it's not something
I actively use.

-- PMM
