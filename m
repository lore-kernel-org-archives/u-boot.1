Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87065CF9C58
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 15:59:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 09BA188ADC;
	Fri, 20 Sep 2024 17:59:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="O0FOC7Fs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6AD788A9D; Fri, 20 Sep 2024 17:59:11 +0200 (CEST)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66BEC88883
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 17:59:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-6c35a23b378so12955696d6.2
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 08:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726847945; x=1727452745; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WuCXv6Pu++eCK5RSJ/ipYSc9UpOTfuLy+NTe6bxFMF4=;
 b=O0FOC7FsbuQzIpxa/B9UwTimb6AftOB0Vth2eQoUm6uI8kTcuEZVO2rNbAAstxQy9O
 Vl6NZhgZ7GczTsiUpTCXKanpkoGvKPCoaIOP5kqs+nemaMZKatClvDO8hMmwjCmFodyW
 KXOEqyllz58jx40G4YfPkfuoFvmxa9Ut9p6y0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726847945; x=1727452745;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WuCXv6Pu++eCK5RSJ/ipYSc9UpOTfuLy+NTe6bxFMF4=;
 b=mQDNNWEOt7L3uH383dlB+/mwTDnMoN3gHubRrOKwUZAdMawBfm2yLw49XoWXvixSN5
 I2UPVOpPAJappuXs1yLibGNpnuEabfikAkNz72WL7sI9IM4O82co19PuDqfjZLoX2jqx
 K8s3FKeRvpkV6/xdiSYCYTzo98y07WwTWl9hDO7zWbfOR8GTEkLYkiZm9r/KixRUtI4w
 etXEhPqYv9z86008nEH+fk9WyZiaU+5lwJq1B4hwSFsodspvee3V5+T0Kq50OcqFMIjV
 MPl4zm/Y4Ly42LIGBTKU/BEsbx/0fd5Kr9R/Oeg+vcScNCle++dX/Myf2SPkJZ8rf1w0
 jsKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhJEkFL6L8FuSg7os96SPJQXMHhiSKNHd60aBMfLgyd5GLngEh807e6CZYFHMW7cTy5wEZ138=@lists.denx.de
X-Gm-Message-State: AOJu0Yyy/SmlJwd657Bel1foSy62FwxyELunoD+veTWRghsOP213pQC9
 OUgGwBUHgyhJTLuFjnxZLd0l7aw9KsX8g451p161lYum1iK0d0hm5gk7WV0Xy5HHCDzqolDMXvQ
 Vlwj7C21TRLLQoRZ38DTbNxQJQpUZsAaWFDRyeRyq/Ygc3RwF1HdI
X-Google-Smtp-Source: AGHT+IFWqGt6/kn/WGqXZsO9l0qvLYuh1oqVM+4GdDPyKMgaxBiT5/v4Mkh7vBfZNAbTmhqczdrSoWjYDa6V3wFJKrs=
X-Received: by 2002:a0c:f407:0:b0:6c5:3122:ffac with SMTP id
 6a1803df08f44-6c7bc8076ddmr30020356d6.45.1726847945190; Fri, 20 Sep 2024
 08:59:05 -0700 (PDT)
MIME-Version: 1.0
References: <20240914160548.42551-1-heinrich.schuchardt@canonical.com>
 <CAFLszTjL46Gb03MS7znLujAKC0VkgOrUaZMy7XPw-jpw3TELTA@mail.gmail.com>
 <d95b95d2-7afb-42f2-9a01-75d601368be9@canonical.com>
 <CAC_iWjLCnUpnVGuVYnhzo4EaUmKMSZPws3hSzOOvQqirC71hfQ@mail.gmail.com>
 <CAFLszTimJuwFKp6DaRDJ22=0tbNPYbcLMT9hcFrC9Rca6vzAyg@mail.gmail.com>
 <b8d1cef7-4e56-49c6-aeca-b471a82870cd@canonical.com>
 <CAC_iWjLY9Oea-AryLyrQJ3zXX+Bihza5B8R5UpXh58K3+Ff=Xw@mail.gmail.com>
 <CAFLszTgASXx5t7=T+yLtC0W9dwo=FkQPF5T6eYD2uyFUWE6D_A@mail.gmail.com>
 <CAC_iWjJL2tHTe84iqOkzDxANed-TdOObDYoW2jUwe3T=x=cyqA@mail.gmail.com>
 <CAFLszTghAmCGoiHq+iBwBRC99ucBOUGG+mjq8HEjUVkPAJu-ZQ@mail.gmail.com>
 <CAC_iWjKLODdFV701vo-ECEo+_U6NQoLS=HsrgmS+RyDHd5pi0A@mail.gmail.com>
 <CAFLszTits7gXaCfCzwvOOwLcYOtHSPBTh8H+5o5jgZ2wh4eNuQ@mail.gmail.com>
 <CAC_iWjKetz0BUriZ__khwQaPshadFFNsdZXyN8rtPe8VpkkVwg@mail.gmail.com>
In-Reply-To: <CAC_iWjKetz0BUriZ__khwQaPshadFFNsdZXyN8rtPe8VpkkVwg@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 20 Sep 2024 17:58:53 +0200
Message-ID: <CAFLszTgL-S3jeXK=OWTaqGKtSQDMo=JjiHT3w4+xup+d4Qr4kA@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi_leader: delete rng-seed if having EFI RNG protocol
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Ilias,

On Fri, 20 Sept 2024 at 09:37, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Simon,
>
> On Fri, 20 Sept 2024 at 10:25, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Ilias,
> >
> > On Thu, 19 Sept 2024 at 17:51, Ilias Apalodimas
> > <ilias.apalodimas@linaro.org> wrote:
> > >
> > > On Thu, 19 Sept 2024 at 18:39, Simon Glass <sjg@chromium.org> wrote:
> > > >
> > > > Hi,
> > > >
> > > > On Thu, 19 Sept 2024 at 17:37, Ilias Apalodimas
> > > > <ilias.apalodimas@linaro.org> wrote:
> > > > >
> > > > > On Thu, 19 Sept 2024 at 18:19, Simon Glass <sjg@chromium.org> wrote:
> > > > > >
> > > > > > Hi,
> > > > > >
> > > > > > On Thu, 19 Sept 2024 at 17:13, Ilias Apalodimas
> > > > > > <ilias.apalodimas@linaro.org> wrote:
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > > On Thu, Sep 19, 2024, 18:05 Heinrich Schuchardt <heinrich.schuchardt@canonical.com> wrote:
> > > > > > >>
> > > > > > >> On 19.09.24 17:00, Simon Glass wrote:
> > > > > > >> > Hi,
> > > > > > >> >
> > > > > > >> > On Thu, 19 Sept 2024 at 16:32, Ilias Apalodimas
> > > > > > >> > <ilias.apalodimas@linaro.org> wrote:
> > > > > > >> >>
> > > > > > >> >> Hi all,
> > > > > > >> >>
> > > > > > >> >> On Thu, 19 Sept 2024 at 17:20, Heinrich Schuchardt
> > > > > > >> >> <heinrich.schuchardt@canonical.com> wrote:
> > > > > > >> >>>
> > > > > > >> >>> On 19.09.24 16:10, Simon Glass wrote:
> > > > > > >> >>>> Hi Heinrich,
> > > > > > >> >>>>
> > > > > > >> >>>> On Sat, 14 Sept 2024 at 18:06, Heinrich Schuchardt
> > > > > > >> >>>> <heinrich.schuchardt@canonical.com> wrote:
> > > > > > >> >>>>>
> > > > > > >> >>>>> For measured be boot we must avoid any volatile values in the device-tree.
> > > > > > >> >>>>> We already delete /chosen/kaslr-seed if we provide and EFI RNG protocol.
> > > > > > >> >>>>
> > > > > > >> >>>> Could you explain a bit why this is, and where this is checked?
> > > > > > >> >>>>>
> > > > > > >> >>>>> Additionally remove /chosen/rng-seed provided by QEMU or U-Boot.
> > > > > > >> >>>
> > > > > > >> >>> Measured boot relies on creating hashes of artifacts and writing these
> > > > > > >> >>> to TPM. If the hashes don't match the OS will either warn or refuse to
> > > > > > >> >>> boot. The device-tree is one of the artifacts that are measured.
> > > > > > >> >>>
> > > > > > >> >>> If we have random values in /chosen, measured boot will fail.
> > > > > > >> >>>
> > > > > > >> >>> When an EFI RNG protocol is provided by the firmware, GRUB and the
> > > > > > >> >>> kernel will use it instead of /chosen/rng-seed and /chosen/kaslr-seed.
> > > > > > >> >>
> > > > > > >> >> There's a comment on top of that function that explains what happens as well.
> > > > > > >> >> In short the EFI stub does not even look at the KASLR seed and never
> > > > > > >> >> randomizes the physical placement of the kernel. It only does that
> > > > > > >> >> when the EFI_RNG protocol is there.
> > > > > > >> >
> > > > > > >> > OK thank you. I suppose I am more just wondering why it got added in
> > > > > > >> > the first place?
> > > > > > >>
> > > > > > >> For booting via the legacy Linux entry point adding kaslr-seed allows to
> > > > > > >> randomize addresses. QEMU adds rng-seed instead of kaslr-seed.
> > > > > > >
> > > > > > >
> > > > > > > Not the kernel physical placement. It randomizes only the virtual placement
> > > > > >
> > > > > > So, are you saying that U-Boot adds this field into the FDT and then removes it?
> > > > >
> > > > > Yes. As Heinrich said, the rng seed is still usable for some
> > > > > randomization. If we boot with EFI and have an RNG protocol, we dont
> > > > > need it and it also messes up the TPM measurements, so we remove it.
> > > > > But the code that injects it to u-boot, or the prior bootloader that
> > > > > handed you over a DT,  does not know if you plan to boot with EFI.
> > > >
> > > > I'm actually surprised that this works. Normally, removing a property
> > > > does not drop that property from the string table, so adding a
> > > > property and deleting it is not normally the same as never adding it.
> > > > But perhaps that has changed?
> > > >
> > > > Anyway, I think we should add the property when we know it is OK to do
> > > > so, which is just before we boot. If you agree I can take a look at
> > > > that.
> > >
> > > Sure, but we won't be able to remove this code. There are still
> > > first-stage boot loaders that might send you a DT over a bloblist,
> > > that has a kaslr-seed
> >
> > But then I don't see what problem that causes...I'm just going to
> > leave this madness to you :-)
> >
>
> The problem is that in theory, we need to measure a DT as early as
> possible, but that's not doable in U-Boot yet. The TCG specs have no
> guidance on measuring DTs, but do have on ACPI tables and we basically
> copy what's done for ACPI.
>
> The DT is more fragile though. As Heinrich said if you decide to
> measure it, you can't have random values -- whether that comes from
> U-Boot injecting those or a previous loader is irrelevant. The result
> is the same, if you have random values in the measured DT, e.g a mac
> address or a kaslr-seed the measurements we take on PCR1 will be
> different and as a result kind of useless.
>
> For the reasons above, measuring a DT is not in any default config.
> It's up to the user whether he wants to measure it or not. But for the
> kaslr-seed, since the kernel does not use it when booting via EFI and
> the EFI_RNG protocol is installed, we remove it.
>
> Hope that clarifies things a bit

Yes it does, thank you.

IMO measuring the devicetree should really be done using a hash of
only part of the tree, for example excluding the /options node and
perhaps /chosen as well. I just looked to refresh my memory, and
adding then removing a property does not result in the same DT as
before the addition.

There are several reasons I have this opinion:
- The DT is used for things which don't relate to Linux, such as /options/u-boot
- The DT may have overlays applied
- Some DT nodes may have been 'fixed' up by U-Boot

So if we want to 'measure' the DT, we should probably provide in the
DT an indication of which part is hashed, so Linux etc. can take that
into account. Also we may want to have multiple hashes, to deal with
the case of additions being made. We have something similar to this
with FIT signatures, but that mechanism is not suitable here (although
it could perhaps help inspire a solution).

Regards,
Simon
