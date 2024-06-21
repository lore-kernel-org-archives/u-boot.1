Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4750AC27C4F
	for <u-boot@archiver.kernel.org>; Fri, 21 Jun 2024 14:58:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C07B88551;
	Fri, 21 Jun 2024 16:58:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lZ20ENch";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F3628855F; Fri, 21 Jun 2024 16:58:05 +0200 (CEST)
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com
 [IPv6:2607:f8b0:4864:20::b31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 26DA988549
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 16:58:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-yb1-xb31.google.com with SMTP id
 3f1490d57ef6-e02a6d4bdbeso1974404276.2
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 07:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718981882; x=1719586682; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7DkXpfpvuQHvMLu6UIBKBlJh0lOxXZZHARyEVRGndiA=;
 b=lZ20ENchbN2/tLG+JefX6/YZDiDhBq5UqVcOyS5BV5boQm6ZWYmcHWC6Vv3MYcHnVK
 Bv4qoApmDFtJVZDQXbASSTSEbfibj4EEOqSAbqCePYDA9a5ozvLtmyxqZUvySTKJFWvU
 Vg/LOd10Mma8V+5dfigGfB4zshgQlZ04d4CUE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718981882; x=1719586682;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7DkXpfpvuQHvMLu6UIBKBlJh0lOxXZZHARyEVRGndiA=;
 b=xTqb2W0KkF48go9hniDwxWIS37n1tkaTAQDzdrRkXUzIv2xs/2iXSF9OrC1kDWhObV
 wi5ZToa0EuSASKBy+m1xPpIjdCWezP7Ky0q/iOG5wD1hRhbJv432p8h6iSWo9E0Fdmfo
 P23xeDUnDbd3SKMMUdHjNRkSUHKGvRMatyn0ap5CgZR4AOX5hQ7aNp21iBOdlznlhQpf
 k6gbz6Qw6sC/LAVcnuWiSSTQyATbB8axooec2k2O0gQG1Z2KjtoyIlkmacP9SOkD3jlV
 xyfKwuDDk6gm7d2d6tkbjhSW2iT8k+tA9kwSl84JP9GrpWWVqSxef4Qk5W9EbUUmdYr9
 I8dA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWAn5jsvz9YWQHX0I5aB3w9MFetfnZTZu45kMpAgbFf5XWMyAN6sHYnOlc3B12x6BttDnw7pkW5pUrPC6/nn2B1WtrBag==
X-Gm-Message-State: AOJu0YxEYiOck6owNuWjvh2ZWi9zcOAZUH2qq/NRvPmC733ljfWgq41q
 QbIfd7+8HJ426mH4dDal54KJPTDKaqMbpNBO4Gpyxr5SuntxYO7nsQT3aDFKYw5JtY9r1RW3cF5
 dsnEtOcU6/+xCiKxFbTyC0ATlznzUt25OLZwk
X-Google-Smtp-Source: AGHT+IFVb5lRtkTt2eZB6XgSH1AqxBH8fkuzZ+NHqaM1xZoxpeDGKlYDMX0/F4G5gEPp1GZ8gYKbtFJ39ys3Lv/rF6A=
X-Received: by 2002:a25:d808:0:b0:dff:33f6:c62c with SMTP id
 3f1490d57ef6-e02be22e4e7mr9233289276.56.1718981881907; Fri, 21 Jun 2024
 07:58:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAC_iWjKAQwLobcO8virDKKD8cQ4j7-OAzn2nriNmdGUtMRKXnw@mail.gmail.com>
 <8b6f5ad8-911f-4954-8b48-333986be0bf8@gmx.de>
 <CAC_iWjL-W604ne_O+U6B3_oGXJtQqZwak4N2qVRSnqdsAz=TbQ@mail.gmail.com>
 <CAFLszTigrcPCH3wwZUZAk75QttVS+cPMoj=hZJ9Ko9DqyN5vVA@mail.gmail.com>
 <20240617171623.GY68077@bill-the-cat>
 <CAFLszThO9Hnfv90X4yu49h7LcWCfgMztSGtQdGwrCt9UDH_cGA@mail.gmail.com>
 <20240618141524.GO68077@bill-the-cat>
 <CAFLszTj--0hi4=isy2Zmq9fBDFr5DMciFs+BZtfuvvmFO-9o9Q@mail.gmail.com>
 <20240619153207.GF68077@bill-the-cat>
 <CAFLszTiHSn4Vw7oMBOwOBC1gAHNYQ3Xc4mT54FkT-dfGSb0F0A@mail.gmail.com>
 <20240620231943.GT68077@bill-the-cat>
In-Reply-To: <20240620231943.GT68077@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 21 Jun 2024 08:57:51 -0600
Message-ID: <CAFLszTgA6Gc1T55v07skZQ3U=_JuM7yW9aTxmAtXsoLTbSOtdQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/9] tpm: Avoid code bloat when not using
 EFI_TCG2_PROTOCOL
To: Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 U-Boot Mailing List <u-boot@lists.denx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Eddie James <eajames@linux.ibm.com>, 
 Manorit Chawdhry <m-chawdhry@ti.com>, Michal Simek <michal.simek@amd.com>, 
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Sean Anderson <sean.anderson@seco.com>
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

On Thu, 20 Jun 2024 at 17:19, Tom Rini <trini@konsulko.com> wrote:
>
> On Thu, Jun 20, 2024 at 05:05:29PM -0600, Simon Glass wrote:
> > Hi Tom,
> >
> > On Wed, 19 Jun 2024 at 09:32, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Tue, Jun 18, 2024 at 09:03:37PM -0600, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Tue, 18 Jun 2024 at 08:15, Tom Rini <trini@konsulko.com> wrote:
> > > > >
> > > > > On Tue, Jun 18, 2024 at 06:43:51AM -0600, Simon Glass wrote:
> > > > > > Hi Tom,
> > > > > >
> > > > > > On Mon, 17 Jun 2024 at 11:16, Tom Rini <trini@konsulko.com> wrote:
> > > > > > >
> > > > > > > On Mon, Jun 17, 2024 at 07:53:22AM -0600, Simon Glass wrote:
> > > > > > > > Hi,
> > > > > > > >
> > > > > > > > On Sat, 15 Jun 2024 at 01:03, Ilias Apalodimas
> > > > > > > > <ilias.apalodimas@linaro.org> wrote:
> > > > > > > > >
> > > > > > > > > Hi Heinrich
> > > > > > > > >
> > > > > > > > > resending the reply, I accidentally sent half of the message...
> > > > > > > > >
> > > > > > > > > On Fri, 14 Jun 2024 at 12:04, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> > > > > > > > > >
> > > > > > > > > > On 14.06.24 09:01, Ilias Apalodimas wrote:
> > > > > > > > > > > On Fri, 14 Jun 2024 at 09:59, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> > > > > > > > > > >>
> > > > > > > > > > >> On 6/14/24 08:03, Ilias Apalodimas wrote:
> > > > > > > > > > >>> Hi Simon,
> > > > > > > > > > >>>
> > > > > > > > > > >>> On Mon, 10 Jun 2024 at 17:59, Simon Glass <sjg@chromium.org> wrote:
> > > > > > > > > > >>>>
> > > > > > > > > > >>>> It does not make sense to enable all SHA algorithms unless they are
> > > > > > > > > > >>>> needed. It bloats the code and in this case, causes chromebook_link to
> > > > > > > > > > >>>> fail to build. That board does use the TPM, but not with measured boot,
> > > > > > > > > > >>>> nor EFI.
> > > > > > > > > > >>>>
> > > > > > > > > > >>>> Since EFI_TCG2_PROTOCOL already selects these options, we just need to
> > > > > > > > > > >>>> add them to MEASURED_BOOT as well.
> > > > > > > > > > >>>>
> > > > > > > > > > >>>> Note that the original commit combines refactoring and new features,
> > > > > > > > > > >>>> which makes it hard to see what is going on.
> > > > > > > > > > >>>>
> > > > > > > > > > >>>> Fixes: 97707f12fda tpm: Support boot measurements
> > > > > > > > > > >>>> Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > > > > > > >>>> ---
> > > > > > > > > > >>>>
> > > > > > > > > > >>>> Changes in v2:
> > > > > > > > > > >>>> - Put the conditions under EFI_TCG2_PROTOCOL
> > > > > > > > > > >>>> - Consider MEASURED_BOOT too
> > > > > > > > > > >>>>
> > > > > > > > > > >>>>    boot/Kconfig | 4 ++++
> > > > > > > > > > >>>>    lib/Kconfig  | 4 ----
> > > > > > > > > > >>>>    2 files changed, 4 insertions(+), 4 deletions(-)
> > > > > > > > > > >>>>
> > > > > > > > > > >>>> diff --git a/boot/Kconfig b/boot/Kconfig
> > > > > > > > > > >>>> index 6f3096c15a6..b061891e109 100644
> > > > > > > > > > >>>> --- a/boot/Kconfig
> > > > > > > > > > >>>> +++ b/boot/Kconfig
> > > > > > > > > > >>>> @@ -734,6 +734,10 @@ config LEGACY_IMAGE_FORMAT
> > > > > > > > > > >>>>    config MEASURED_BOOT
> > > > > > > > > > >>>>           bool "Measure boot images and configuration when booting without EFI"
> > > > > > > > > > >>>>           depends on HASH && TPM_V2
> > > > > > > > > > >>>> +       select SHA1
> > > > > > > > > > >>>> +       select SHA256
> > > > > > > > > > >>>> +       select SHA384
> > > > > > > > > > >>>> +       select SHA512
> > > > > > > > > > >>>>           help
> > > > > > > > > > >>>>             This option enables measurement of the boot process when booting
> > > > > > > > > > >>>>             without UEFI . Measurement involves creating cryptographic hashes
> > > > > > > > > > >>>> diff --git a/lib/Kconfig b/lib/Kconfig
> > > > > > > > > > >>>> index 189e6eb31aa..568892fce44 100644
> > > > > > > > > > >>>> --- a/lib/Kconfig
> > > > > > > > > > >>>> +++ b/lib/Kconfig
> > > > > > > > > > >>>> @@ -438,10 +438,6 @@ config TPM
> > > > > > > > > > >>>>           bool "Trusted Platform Module (TPM) Support"
> > > > > > > > > > >>>>           depends on DM
> > > > > > > > > > >>>>           imply DM_RNG
> > > > > > > > > > >>>> -       select SHA1
> > > > > > > > > > >>>> -       select SHA256
> > > > > > > > > > >>>> -       select SHA384
> > > > > > > > > > >>>> -       select SHA512
> > > > > > > > > > >>>
> > > > > > > > > > >>> I am not sure this is the right way to deal with your problem.
> > > > > > > > > > >>> The TPM main functionality is to measure and extend PCRs, so shaXXXX
> > > > > > > > > > >>> is really required. To make things even worse, you don't know the PCR
> > > > > > > > > > >>> banks that are enabled beforehand. This is a runtime config of the
> > > > > > > > > > >>> TPM.
> > > > > > > > > > >>
> > > > > > > > > > >> If neither MEASURED_BOOT nor EFI_TCG2_PROTOCOL is selected, U-Boot
> > > > > > > > > > >> cannot extend PCRs. So it seems fine to let these two select the
> > > > > > > > > > >> complete set of hashing algorithms. As Simon pointed out for
> > > > > > > > > > >> EFI_TCG2_PROTOCOL this is already done in lib/efi_loader/Kconfig.
> > > > > > > > > > >
> > > > > > > > > > > It can. The cmd we have can extend those pcrs -- e.g tpm2 pcr_extend 8
> > > > > > > > > > > 0xb0000000
> > > > > > > >
> > > > > > > > That's pretty normal for U-Boot though, since we want to avoid lots of
> > > > > > > > growth for things people might want control over. We can enable or
> > > > > > > > disable the SHA for the board, if this functionality is used outside
> > > > > > > > of measured boot and tcg2, but someone is enabling the tpm command.
> > > > > > > >
> > > > > > > > > >
> > > > > > > > > > So this patch should also consider CMD_TPM_V2 and CMD_TPM_V1.
> > > > > > > > > >
> > > > > > > > > > TPM v1 only needs SHA-1.
> > > > > > > > >
> > > > > > > > > I still prefer to imply all algos.
> > > > > > > >
> > > > > > > > 'imply' would be OK in this case as I can disable it for that board. I
> > > > > > > > don't think it is in the spirit of U-Boot though.
> > > > > > > >
> > > > > > > > isn't someone checking the growth in U-Boot? Or do so few boards have
> > > > > > > > TPMs that it didn't register? The size growth was 3.2KB on
> > > > > > > > chromebook_link.
> > > > > > >
> > > > > > > As always, yes, nearly every PR (I don't check the ones that touch just
> > > > > > > a single board for example) gets a world build before/after. In this
> > > > > > > case I likely assumed that it was acceptable growth for enabling
> > > > > > > features. It sounds like some of the chromebook boards need to be
> > > > > > > setting the features to cause link failure if a size is exceeded?
> > > > > >
> > > > > > The problem is that some Intel platforms have binary blobs, so the
> > > > > > size isn't known unless you have a real blob.
> > > > >
> > > > > Alright, but can't we put in some limit based on what the current blobs
> > > > > are, or look at the last few blob releases and see if they change much
> > > > > in size and put something in? Other platforms have blobs and size
> > > > > limits...
> > > >
> > > > Yes we can duplicate the entry sizes from binman into Kconfig options.
> > > > But I am not a fan of that...two variables controlling the same thing
> > > > and both can break, with nothing to connect them other than the poor
> > > > user.
> > > >
> > > > I wonder if some magic could solve this, inferring limits from the
> > > > binman image. But that is getting into yet another domain...
> > >
> > > I'm sorry, I just don't see what makes this case different from all of
> > > the other cases where we have to include blobs. We know there's X amount
> > > of flash available, blobs tend to take up Y and so we set
> > > BOARD_SIZE_LIMIT to Z where there's some room for growth in U-Boot but
> > > it takes in to account whatever limits the blobs place on us.
> >
> > The difference is that now we are using Binman, we have the limit in
> > the image description, so adding it to Kconfig a) involves
> > calculations and perhaps guesswork and b) results in two limits stored
> > in different places which may conflict.
> >
> > I thought of a way to handle this in Binman, so will send that in the
> > next version.
>
> I'm still confused, sorry. This sounds like a whole lot more work than
> setting BOARD_SIZE_LIMIT reasonably so that we fail to link and CI
> errors out, before we get to buildman and needing to make this case
> still fail but with fake blobs.

It is simpler for me, since I don't need to reverse-engineer the space
requirement for each board. With the patch I sent, I can just add some
reasonable numbers to each entry and it will do the right thing.

Regards,
Simon
