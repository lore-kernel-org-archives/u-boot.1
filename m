Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE62EC001DB
	for <u-boot@archiver.kernel.org>; Mon, 14 Aug 2023 22:51:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4130486989;
	Tue, 15 Aug 2023 00:51:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="B5taCLaq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3589086993; Tue, 15 Aug 2023 00:51:29 +0200 (CEST)
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com
 [IPv6:2607:f8b0:4864:20::b2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 255D880748
 for <u-boot@lists.denx.de>; Tue, 15 Aug 2023 00:51:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yb1-xb2f.google.com with SMTP id
 3f1490d57ef6-d45caf42d73so4939034276.2
 for <u-boot@lists.denx.de>; Mon, 14 Aug 2023 15:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692053486; x=1692658286;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Cy6+LHBSTVMmbc/8PWD7KcipdZXWwm1NGoxyRz396QQ=;
 b=B5taCLaqc91GcaOdoSdFCjagCep410w/0Fjk+cA9mRyt9+Axvj9RaQQveU1qXbl63y
 UY0jlTQu/E1SltyEl1EnPGFBFwyLV6X0PnwhK3Q6RkdLzVGBSYVf02PlGfZVoHbVk2jP
 mJsubYOXLrCp3PwLZZrLDGtpjlv7zVEUJYbcY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692053486; x=1692658286;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Cy6+LHBSTVMmbc/8PWD7KcipdZXWwm1NGoxyRz396QQ=;
 b=FdEp9+yZfBDaqXSSq4O1M8LgaNukpMq70dAtqM97cWs7GpR5sqiLirg6TOb+nJNgtK
 lft5cX4p3v8qLH5D2yuZlXhdQexBe39JNHGdqZooIystNimWFAgW01Mfh+nR9dE80pVX
 0TM6zqrUR9fZVWcRP76N0zdhPS+H/hcSdeA0cQkOu0wcHa4159U048PQIyGyah0yR5gS
 Qs30CBKIirYf0sDW6Q5om1HbjcznU+zdxlXGIs9H1rpZ7qc7c0TFUIJxtmmNzAGWNIrK
 zdId4KkZTkZBP9Lg+gPan5HztidBYhE3MIctxLm+kk8wrKqRlTlFJVWErtFRHf1TiNl3
 9PSg==
X-Gm-Message-State: AOJu0YwT/oXZE5QEXNVVsX8IuKCwM79FaqGCX239cb0s4/QkZSdq/XZN
 FmMh30yMmc4+R/iia1S+V6FpDdjUsCkjREJsx0bxIQ==
X-Google-Smtp-Source: AGHT+IFRAFcp1jCPeheFxVKmVkdVR1iHpq4geKYDxEoA/9dPUaE08Z4zD0kem2u6aBEHuzDZHQ1ilQv3jBxIqZh8CsQ=
X-Received: by 2002:a25:6908:0:b0:d47:d267:26fe with SMTP id
 e8-20020a256908000000b00d47d26726femr12434760ybc.21.1692053485657; Mon, 14
 Aug 2023 15:51:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230812055725.252424-1-sughosh.ganu@linaro.org>
 <20230812055725.252424-9-sughosh.ganu@linaro.org>
 <CAPnjgZ2uxYuOuBDS9Uf2ntwcNh=yWdyDVvE+-m_-ra+dsiEBSA@mail.gmail.com>
 <CADg8p95WCjvui2j1f_4o_CL9Zn8ULbUeC3oHEamQvLVmvHNdLQ@mail.gmail.com>
 <CAPnjgZ3PxxOcTs9u5AzxpRJDtWiY19YzhJkTiC-vgmXGp4kymQ@mail.gmail.com>
 <CADg8p95GXbc5cWGK3jtwK1=zsRDV_6h3z_BCj71MrW5LZJOnZw@mail.gmail.com>
In-Reply-To: <CADg8p95GXbc5cWGK3jtwK1=zsRDV_6h3z_BCj71MrW5LZJOnZw@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 14 Aug 2023 16:51:13 -0600
Message-ID: <CAPnjgZ2pTsvL8GhiDHyEchGJkiMMQCtLt+hfaK3tNxbHPTVnhQ@mail.gmail.com>
Subject: Re: [PATCH v9 08/10] sandbox: capsule: Generate capsule related files
 through binman
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>, 
 Malte Schmidt <malte.schmidt-oss@weidmueller.com>,
 Michal Simek <michal.simek@amd.com>, Tom Rini <trini@konsulko.com>
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

Hi Sughosh,

On Mon, 14 Aug 2023 at 02:17, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> hi Simon,
>
> On Sat, 12 Aug 2023 at 22:33, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Sughosh,
> >
> > On Sat, 12 Aug 2023 at 09:40, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > >
> > > hi Simon,
> > >
> > > On Sat, 12 Aug 2023 at 19:55, Simon Glass <sjg@chromium.org> wrote:
> > > >
> > > > On Fri, 11 Aug 2023 at 23:58, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
> > > > >
> > > > > The EFI capsule files can now be generated as part of u-boot
> > > > > build through binman. Add capsule entry nodes for the sandbox
> > > > > architecture for generating the capsules. These capsules are then used
> > > > > for testing the EFI capsule update functionality on the sandbox
> > > > > platforms.
> > > > >
> > > > > Remove the corresponding logic in the test setup which was used for
> > > > > generation of these capsule which is now superfluous.
> > > > >
> > > > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > > > ---
> > > > > Changes since V8:
> > > > > * Build the capsules for all sandbox variants.
> > > > > * Remove the type property by renaming the capsule nodes as
> > > > >   'efi-capsule'.
> > > > >
> > > > >  arch/sandbox/dts/sandbox.dts                  |   2 +
> > > > >  arch/sandbox/dts/sandbox_capsule.dtsi         | 315 ++++++++++++++++++
> > > > >  arch/sandbox/dts/test.dts                     |   2 +
> > > > >  include/sandbox_efi_capsule.h                 |  21 ++
> > > > >  test/py/tests/test_efi_capsule/conftest.py    | 155 +--------
> > > > >  .../tests/test_efi_capsule/uboot_bin_env.its  |  36 --
> > > > >  6 files changed, 356 insertions(+), 175 deletions(-)
> > > > >  create mode 100644 arch/sandbox/dts/sandbox_capsule.dtsi
> > > > >  create mode 100644 include/sandbox_efi_capsule.h
> > > > >  delete mode 100644 test/py/tests/test_efi_capsule/uboot_bin_env.its
> > > >
> > > > Reviewed-by: Simon Glass <sjg@chromium.org>
> > > >
> > > > One way to reduce the files is to put all the capsules in the same
> > > > binman image. You could have 'size = <0x1000>' so they are all the
> > > > same size.
> > > >
> > > > Then your test could check each one by iterating through the (single) file.
> > >
> > > This won't work, as the UEFI specification defines a particular format
> > > of the capsule file. For multiple capsules, the individual capsule
> > > files need to be present under the /EFI/UpdateCapsule/ directory on
> > > the EFI System Partition. The spec does define a format in which a
> > > single capsule file can have multiple payloads(input binaries). This
> > > is planned to be supported once support has been added for generating
> > > capsules through the config file.
> >
> > We continue to have challenges getting confused between testing and real world.
> >
> > For testing, we can do all sorts of things to make things simpler. We
> > don't even need an EFI partition, etc. We can have a test which checks
> > that U-Boot can decode an update and apply it, The current tests rely
> > far too much on an end-to-end, black-box approach, as I might have
> > mentioned.
>
> Okay, but I am stating the constraints on using a single combined file
> based on the way the tests work today. So if we were to generate a
> single file consisting of all the individual capsule files, that would
> break the tests. That was my point.

Sure...my point is that the tests could use a bit of rework to make
them easier and faster to run.

Regards,
Simon
