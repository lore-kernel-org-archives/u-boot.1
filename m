Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74F23C3601E
	for <u-boot@archiver.kernel.org>; Sun, 13 Apr 2025 21:13:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD978828F8;
	Sun, 13 Apr 2025 23:13:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RU8OX85b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2FE582952; Sun, 13 Apr 2025 23:13:53 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5539982845
 for <u-boot@lists.denx.de>; Sun, 13 Apr 2025 23:13:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-ac6e8cf9132so686592866b.2
 for <u-boot@lists.denx.de>; Sun, 13 Apr 2025 14:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1744578831; x=1745183631; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GEMGaIpztNqbRKA2SYlZhIfSWkETo0wxKdha1zn4jp4=;
 b=RU8OX85bzWxCVu3hLaEi5fj0ORsP0Qkn5Xz6qOtuzbVPa6RezBhKa2whPBBhqqa/KF
 JaEDbz3MzQtmCfpoQNeN7JnDEDHEGHrr0ijStIMh9H+QldhA6Z5VyychBijlz0KOBbFQ
 +qrYvPvKut8I/VPVSwplv7PiaP/NXuBVMvRbs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744578831; x=1745183631;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GEMGaIpztNqbRKA2SYlZhIfSWkETo0wxKdha1zn4jp4=;
 b=xAr3X8HIoANH+qn3JvqK37Uj0Qh2+7IG01QmGVBIcdA4WFqWsJXhmyelrBz8bCRBWG
 woEoVFQV9hNi+LjaUIvj9ofOgiGaphoIzIQXQ0giMsLFjNMnOXB32ygkA5v5oJlahmb2
 F+BwHy5HV/3qtiTpH5aFoeUosCvWo21O15wcyzFjWMmOa+fZXPEmMMhRAevht4XnFseJ
 AVMlWLsCa6fEptMMljQX4Z8bA+FfkFQgN9hEle87HoeGkCcLsdHZontrQnADNYgsnuAw
 l+NmFAG2yI3SzFAhuVXHQy1M839ekgzv6rFIZcbTIvgpN/fifj0ZG/HzTmhqSJVSjZc2
 glYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUcIjByqPbZt0Qzhb84lEgY+05fDBGJp9CpITgh93OzIgdXpMYhw3WNgG2FduQ0DwBo/urJZgk=@lists.denx.de
X-Gm-Message-State: AOJu0YyK2kFJgGV943NxsTQhlIX0K70pstAelqNtBJHYVFXYcuSIuXWr
 hjiK/EgUqx1csEGi2U/E2ApbEVuHuEAChDwsYrpZm//IxVUBgMgRyEw+AuJrmy3oS1DjqcuuJdr
 aYdrOTEpOgew0+ttUTHCEnbQDsWneaOXEBwZt
X-Gm-Gg: ASbGncvCMG1VIaUZ5+xT5Rs305CaF+BcoBPL0PEynIpYIjquNtjtQCNNN1bybdbviPX
 vQW/JRpPEwyw0QU5hNpcOVtl+v5UPyMdwZX0mFhe2OFxollJWtUoYYq4K+CmJiYho9kA4sm3bo3
 buWQryHcQ/TBo4Di0mcZV/G+g=
X-Google-Smtp-Source: AGHT+IF54zaGrMMu2Fgg7NM2H+FjWqvmUN1U3bcUubTaUQ7axpbnR4WSgfkMvXWgIXm4o1YQW/UYOzRyEou6jz4wEt0=
X-Received: by 2002:a17:906:71d6:b0:aca:e6b3:6fa5 with SMTP id
 a640c23a62f3a-acae6b377ccmr451720366b.14.1744578830479; Sun, 13 Apr 2025
 14:13:50 -0700 (PDT)
MIME-Version: 1.0
References: <20250328154401.3563921-1-sjg@chromium.org>
 <20250328161845.GB93000@bill-the-cat>
 <CAFLszThKn0xTmLdR7Hs_oKO_paYTtr-Y1xA_eoNY2rcjeuHX9g@mail.gmail.com>
 <20250329000211.GH93000@bill-the-cat>
 <CAEfUkUJo6AA_SESSYj6Bgq=tUHRc5MQ+sAqtURkbNRafK+=SiA@mail.gmail.com>
 <CAEfUkUJOu_nw0j3EvSpAgrSZ+wy_g=CLdY5yo9uWuc6j3NfnbQ@mail.gmail.com>
 <CAFLszTjo8HEzKbZAbO=neF57e69vGbWYsDVV_dD=kO6j_VH39w@mail.gmail.com>
 <CAEfUkUJNUhoyRY6S9-eYV5i9RT_GgYLRs+HRWocch8jYfVj2Lw@mail.gmail.com>
 <CAFLszTj-pQSK_aKNoLUcLFBk+wAjgC_5=-5YRPGt_7DDFRL3Dw@mail.gmail.com>
 <CAEfUkULcgK9jY902Ccf_mNNCHf5m1BU=ecLK7cuviv7TdABukQ@mail.gmail.com>
In-Reply-To: <CAEfUkULcgK9jY902Ccf_mNNCHf5m1BU=ecLK7cuviv7TdABukQ@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 13 Apr 2025 15:13:38 -0600
X-Gm-Features: ATxdqUHGemsF-z6pffYoixpTDr2b-muBZRRQIDPH0b7lbc8U63Uu4gdi5Jem_tE
Message-ID: <CAFLszTi7CmWL7pxAp08gy5euD8vKs1qN5DOzi-J=9c2dZ7hFMw@mail.gmail.com>
Subject: Re: [PATCH 0/4] bloblist: fdt: Clean up the code
To: Raymond Mao <raymond.mao@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Evgeny Bachinin <EABachinin@salutedevices.com>,
 Harrison Mutai <harrison.mutai@arm.com>, 
 Jan Kiszka <jan.kiszka@siemens.com>, Jerry Van Baren <vanbaren@cideas.com>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Levi Yun <yeoreum.yun@arm.com>, 
 =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>, 
 Matthias Brugger <mbrugger@suse.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Sumit Garg <sumit.garg@kernel.org>, 
 This contributor prefers not to receive mails <noreply@example.com>,
 mason1920 <mason1920@use.startmail.com>
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

Hi Raymond,

On Mon, 7 Apr 2025 at 08:08, Raymond Mao <raymond.mao@linaro.org> wrote:
>
> Hi Simon,
>
> On Sun, 6 Apr 2025 at 18:06, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Raymond,
> >
> > On Sat, 5 Apr 2025 at 07:09, Raymond Mao <raymond.mao@linaro.org> wrote:
> > >
> > > Hi Simon,
> > >
> > > On Fri, 4 Apr 2025 at 13:40, Simon Glass <sjg@chromium.org> wrote:
> > > >
> > > > Hi Raymond,
> > > >
> > > > On Sat, 5 Apr 2025 at 03:49, Raymond Mao <raymond.mao@linaro.org> wrote:
> > > > >
> > > > > Hi Tom and Simon,
> > > > >
> > > > > On Fri, 28 Mar 2025 at 21:00, Raymond Mao <raymond.mao@linaro.org> wrote:
> > > > > >
> > > > > > Hi Tom and Simon,
> > > > > >
> > > > > > On Fri, 28 Mar 2025 at 20:02, Tom Rini <trini@konsulko.com> wrote:
> > > > > > >
> > > > > > > On Fri, Mar 28, 2025 at 11:38:14PM +0000, Simon Glass wrote:
> > > > > > > > Hi Tom,
> > > > > > > >
> > > > > > > > On Fri, 28 Mar 2025 at 10:18, Tom Rini <trini@konsulko.com> wrote:
> > > > > > > > >
> > > > > > > > > On Fri, Mar 28, 2025 at 09:43:54AM -0600, Simon Glass wrote:
> > > > > > > > >
> > > > > > > > > > The bloblist code took what I consider to be a wrong turn a year or so
> > > > > > > > > > ago. As discussed with Tom, this series proposes a way to arrange things
> > > > > > > > > > so that it is simpler to understand and manage.
> > > > > > > > > >
> > > > > > > > > > - Unwind some of the nesting in bloblist_init()
> > > > > > > > > > - Avoid needing to init the bloblist just to get the FDT
> > > > > > > > > > - Create a deterministic OF_BLOBLIST option rather than using guesswork
> > > > > > > > > >
> > > > > > > > > > It is to be hoped that we can get a platform which uses OF_BLOBLIST into
> > > > > > > > > > CI at some point. In the meantime, the standard passage series[1] could
> > > > > > > > > > be resurrected to give some coverage.
> > > > > > > > > >
> > > > > > > > > > [1] https://patchwork.ozlabs.org/project/uboot/list/?series=281465&state=*
> > > > > > > > >
> > > > > > > > > Based on how it's documented to be run in
> > > > > > > > > doc/board/armltd/vexpress64.rst in the next branch, have you confirmed
> > > > > > > > > that platforms using the handoff spec still work?
> > > > > > > >
> > > > > > > > I believe so, yes. I don't have that board to test it though. Raymond
> > > > > > > > may be able to test this series on QEMU?
> > > > > > >
> > > > > > > I was pointing you at the docs so that you would have access to testing
> > > > > > > it. That's part of the docs, running the emulator.
> > > > > > >
> > > > > >
> > > > > > I can help to test the firmware handoff on qemu.
> > > > > > I have all the necessary changes and unit tests for the OP-TEE repo
> > > > > > qemu v8 build to test this.
> > > > > > I will try to find some time early next week to review and test this
> > > > > > series before turning back to you.
> > > > > >
> > > > >
> > > > > Just a follow-up on the testing with TF-A and OP-TEE.
> > > > > Unfortunately, the patch series breaks the transfer list handoff to
> > > > > U-Boot completely and just end up with below error when U-Boot boots:
> > > > > ```
> > > > > No valid device tree binary found at 0000000000000000
> > > > > initcall failed at call 0000000060097bcc (err=-2)
> > > > > ### ERROR ### Please RESET the board ###
> > > > > ```
> > > > >
> > > > > U-Boot test version:
> > > > > 'next' branch + this series + my patch [1] to point fdt_addr to gd->fdt_blob.
> > > > >
> > > > > [1]: https://lore.kernel.org/u-boot/20250331224011.2734284-2-raymond.mao@linaro.org/
> > > >
> > > > I suppose the FDT address in the register is not being read correctly.
> > > >
> > > > Do you have a test case for this, e.g. in QEMU? Even if it is just
> > > > binary blobs for now, not suitable for CI, I'd like to get it in my
> > > > lab.
> > > >
> > > > I did create a test back when I did standard passage, but that series
> > > > seems to have not been applied. I'll see if I can resurrect it.
> > > >
> > >
> > > I am using the OP-TEE repo [1] qemu_v8 build to test. You will also
> > > need my patch [2] for enabling transfer_ist in all components.
> > >
> > > [1] https://github.com/OP-TEE
> > > [2] https://github.com/OP-TEE/build/pull/821
> > >
> >
> > Tom's email seems easier to follow. I got as far as building:
> >
> > build/fvp/release/fip.bin
> >
> > But I'm not sure how to run that in QEMU. The docs mention some sort
> > of FVP thing and running FVP_Base_RevC-2xAEMvA -C which I don't seem
> > to have.
> >
>
> If you want to test with QEMU v8, just simply:
> $ repo init -u https://github.com/OP-TEE/manifest.git -m qemu_v8.xml
> $ repo sync
> $ cd build
> Apply my patch https://github.com/OP-TEE/build/pull/821
> In kconfigs/u-boot_tl.conf, remove 'CONFIG_BLOBLIST_SIZE=0' and add
> 'OF_BLOBLIST=y'
> $ make toolchains
> $ make run

Thanks for the steps. It seemed to complete OK. I also found this:

https://optee.readthedocs.io/en/latest/building/devices/qemu.html#qemu-v8

But I'm not sure how to actually run it, or even what was actually
built. Do you have the QEMU cmdline I should use to make it start,
please?

Regards,
SImon
