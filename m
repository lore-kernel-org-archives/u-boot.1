Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0A12CF58E4
	for <u-boot@archiver.kernel.org>; Fri, 20 Sep 2024 07:37:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35C7F89357;
	Fri, 20 Sep 2024 09:37:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Rgui2Vnf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BBB0289381; Fri, 20 Sep 2024 09:37:43 +0200 (CEST)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4DC1589351
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 09:37:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-206aee40676so16068775ad.0
 for <u-boot@lists.denx.de>; Fri, 20 Sep 2024 00:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726817859; x=1727422659; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=R8CZ6tdFrtblPr+fuTAxjNn95+xnPmwTSatxNFn0Khc=;
 b=Rgui2Vnf04SSeThuRnfSxxFJ7dldJmFEq28BCuGnRRNF0WNTYFRRlygEd2/TFWpToa
 gOR/OGWYYczB+JDiJx8GGWZfIOGEw++0jV4/qUYyn0db0I5TkzHfvO+NkQ4a2yo0AiAT
 ZCRb/JI75Og0QqnivpDh/kMinjGywn6CFJhcVhJLrfNhT/DXJ3opLWy2yvPrDKBts2ba
 4OAjrbSsHjVBq5AIgyQccsV2V5e0eTc62utTPZPF6flAvfCcKtQR1luIgfI3cTgOrS+U
 aPbJa37B/IoSi3ob3zlQUiGrVp5XC9mK0dMoW79yMQVvjHK3RQk8VPExWruJDxwbEYeI
 ankQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726817859; x=1727422659;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=R8CZ6tdFrtblPr+fuTAxjNn95+xnPmwTSatxNFn0Khc=;
 b=dGPV4LhC0N7ZSdODYiqCP4fhgqBX8FpSRkPnfeaq9kVqNv7jRC8lLhHW7ge3jNnFD9
 m9zy4ecoARN3Npd9Nbxy7eiWEUF7LS77EZigPnrI40VABjo3WFle6f09COFHQzSIOSic
 eJJyU9Jqu/0/cSTClEWK6jxBAzp+Dca+d9aDUVFaJptZR7JTcqumUonOD+YPsKm694PC
 Dg8/Fpfjs+hAF9w2qGfn71qGbhRR2v0EAGwBOc80MshfpzB9WaK+ySDHa6CbHW0Y4/qv
 aV9f4H0/zFid+vnZrk2OhhJF23IDnFCH5iGrJFJO07HxkwemyoyWxxGqhE+iGlQuT/MN
 XwjA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVu4iO96WaLpvZl94ttRQgwGudcuaoU0e7TBcfTJho64n+c/CIGgCvebbFSygCMlWMITGuyCD4=@lists.denx.de
X-Gm-Message-State: AOJu0Yy4dsm/VDva7xeEMHfuRXIGGvYKXBASuB9CXPUZ9ntCMlzd2oGR
 FolwzTZpVBloI97z6Y2ZRy8Maxa8i7I7Zjssi9b8wIjw4Pyumh62BHFkHE4EunHztQq9LOasDF7
 /rflNdLV4nKONVs9MA9iNiPEqo4xkHsM5R/VvMtflfwbL+5ja
X-Google-Smtp-Source: AGHT+IG/UNBbhpfMiqXRtwogrbo6Ee7WaOY8jRKNra7vKscUqxZqb9vaMzf7ljeFW3wZLgBC/ZAOGqpvjAsTqpe50OY=
X-Received: by 2002:a17:903:230e:b0:202:4640:cc68 with SMTP id
 d9443c01a7336-208d843c1a7mr27871115ad.59.1726817858592; Fri, 20 Sep 2024
 00:37:38 -0700 (PDT)
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
In-Reply-To: <CAFLszTits7gXaCfCzwvOOwLcYOtHSPBTh8H+5o5jgZ2wh4eNuQ@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 20 Sep 2024 10:37:01 +0300
Message-ID: <CAC_iWjKetz0BUriZ__khwQaPshadFFNsdZXyN8rtPe8VpkkVwg@mail.gmail.com>
Subject: Re: [PATCH 1/1] efi_leader: delete rng-seed if having EFI RNG protocol
To: Simon Glass <sjg@chromium.org>
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

Hi Simon,

On Fri, 20 Sept 2024 at 10:25, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Ilias,
>
> On Thu, 19 Sept 2024 at 17:51, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > On Thu, 19 Sept 2024 at 18:39, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Hi,
> > >
> > > On Thu, 19 Sept 2024 at 17:37, Ilias Apalodimas
> > > <ilias.apalodimas@linaro.org> wrote:
> > > >
> > > > On Thu, 19 Sept 2024 at 18:19, Simon Glass <sjg@chromium.org> wrote:
> > > > >
> > > > > Hi,
> > > > >
> > > > > On Thu, 19 Sept 2024 at 17:13, Ilias Apalodimas
> > > > > <ilias.apalodimas@linaro.org> wrote:
> > > > > >
> > > > > >
> > > > > >
> > > > > > On Thu, Sep 19, 2024, 18:05 Heinrich Schuchardt <heinrich.schuchardt@canonical.com> wrote:
> > > > > >>
> > > > > >> On 19.09.24 17:00, Simon Glass wrote:
> > > > > >> > Hi,
> > > > > >> >
> > > > > >> > On Thu, 19 Sept 2024 at 16:32, Ilias Apalodimas
> > > > > >> > <ilias.apalodimas@linaro.org> wrote:
> > > > > >> >>
> > > > > >> >> Hi all,
> > > > > >> >>
> > > > > >> >> On Thu, 19 Sept 2024 at 17:20, Heinrich Schuchardt
> > > > > >> >> <heinrich.schuchardt@canonical.com> wrote:
> > > > > >> >>>
> > > > > >> >>> On 19.09.24 16:10, Simon Glass wrote:
> > > > > >> >>>> Hi Heinrich,
> > > > > >> >>>>
> > > > > >> >>>> On Sat, 14 Sept 2024 at 18:06, Heinrich Schuchardt
> > > > > >> >>>> <heinrich.schuchardt@canonical.com> wrote:
> > > > > >> >>>>>
> > > > > >> >>>>> For measured be boot we must avoid any volatile values in the device-tree.
> > > > > >> >>>>> We already delete /chosen/kaslr-seed if we provide and EFI RNG protocol.
> > > > > >> >>>>
> > > > > >> >>>> Could you explain a bit why this is, and where this is checked?
> > > > > >> >>>>>
> > > > > >> >>>>> Additionally remove /chosen/rng-seed provided by QEMU or U-Boot.
> > > > > >> >>>
> > > > > >> >>> Measured boot relies on creating hashes of artifacts and writing these
> > > > > >> >>> to TPM. If the hashes don't match the OS will either warn or refuse to
> > > > > >> >>> boot. The device-tree is one of the artifacts that are measured.
> > > > > >> >>>
> > > > > >> >>> If we have random values in /chosen, measured boot will fail.
> > > > > >> >>>
> > > > > >> >>> When an EFI RNG protocol is provided by the firmware, GRUB and the
> > > > > >> >>> kernel will use it instead of /chosen/rng-seed and /chosen/kaslr-seed.
> > > > > >> >>
> > > > > >> >> There's a comment on top of that function that explains what happens as well.
> > > > > >> >> In short the EFI stub does not even look at the KASLR seed and never
> > > > > >> >> randomizes the physical placement of the kernel. It only does that
> > > > > >> >> when the EFI_RNG protocol is there.
> > > > > >> >
> > > > > >> > OK thank you. I suppose I am more just wondering why it got added in
> > > > > >> > the first place?
> > > > > >>
> > > > > >> For booting via the legacy Linux entry point adding kaslr-seed allows to
> > > > > >> randomize addresses. QEMU adds rng-seed instead of kaslr-seed.
> > > > > >
> > > > > >
> > > > > > Not the kernel physical placement. It randomizes only the virtual placement
> > > > >
> > > > > So, are you saying that U-Boot adds this field into the FDT and then removes it?
> > > >
> > > > Yes. As Heinrich said, the rng seed is still usable for some
> > > > randomization. If we boot with EFI and have an RNG protocol, we dont
> > > > need it and it also messes up the TPM measurements, so we remove it.
> > > > But the code that injects it to u-boot, or the prior bootloader that
> > > > handed you over a DT,  does not know if you plan to boot with EFI.
> > >
> > > I'm actually surprised that this works. Normally, removing a property
> > > does not drop that property from the string table, so adding a
> > > property and deleting it is not normally the same as never adding it.
> > > But perhaps that has changed?
> > >
> > > Anyway, I think we should add the property when we know it is OK to do
> > > so, which is just before we boot. If you agree I can take a look at
> > > that.
> >
> > Sure, but we won't be able to remove this code. There are still
> > first-stage boot loaders that might send you a DT over a bloblist,
> > that has a kaslr-seed
>
> But then I don't see what problem that causes...I'm just going to
> leave this madness to you :-)
>

The problem is that in theory, we need to measure a DT as early as
possible, but that's not doable in U-Boot yet. The TCG specs have no
guidance on measuring DTs, but do have on ACPI tables and we basically
copy what's done for ACPI.

The DT is more fragile though. As Heinrich said if you decide to
measure it, you can't have random values -- whether that comes from
U-Boot injecting those or a previous loader is irrelevant. The result
is the same, if you have random values in the measured DT, e.g a mac
address or a kaslr-seed the measurements we take on PCR1 will be
different and as a result kind of useless.

For the reasons above, measuring a DT is not in any default config.
It's up to the user whether he wants to measure it or not. But for the
kaslr-seed, since the kernel does not use it when booting via EFI and
the EFI_RNG protocol is installed, we remove it.

Hope that clarifies things a bit

Regards
/Ilias
> Regards,
> Simon
