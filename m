Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68713CF395D
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 15:51:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA13F8918F;
	Thu, 19 Sep 2024 17:51:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wf0VnXpm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C2F138919B; Thu, 19 Sep 2024 17:51:30 +0200 (CEST)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com
 [IPv6:2607:f8b0:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 53AFF88A24
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 17:51:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-71798661a52so868735b3a.0
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 08:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726761087; x=1727365887; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9K+DRgzJC0AHWWxB0o3I1feKxNMj3cRZAvYDM6X/a2g=;
 b=wf0VnXpmS3KGRGHdcOUKkgYRq4M4CMz1Rnd/xoFJ0KlObySBa5wqhDTb7UdmkPhZpj
 m5jMcLE0n58aysmijh+31yaLcuE6snn2uiFLdBA2gRAnnwVqct8STVk/OQOSLxVL8aYG
 we4QVoN69KVlWU5iKqRDptRBt80DD3o6t1qTbzJe2kbWX4vinhWNDgDjVKqqfRFPhnRS
 wVwcWUTR3gQ5MCpu5WDEn1Tx93VBC5PqmEWb2F+9EYA4t2l0Htm0k07kukChcaT0khnM
 FHgOaeWE8wpKReKvsdgxdxI4cRkegKGEYe+20TiiX9QJ3D37wPoW+3tFY3z9ZvY9Aipu
 OseA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726761087; x=1727365887;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9K+DRgzJC0AHWWxB0o3I1feKxNMj3cRZAvYDM6X/a2g=;
 b=RxHdXt+SZIDULgIXpH5OnPLLnAZR/5i5dEocrSyczvxpeXPHBaQLYGBDDBJm8Ig1zB
 XGcfp7AsEKuq9BpPHmu66cK9ljUIlxkl/vTyUNX98j8O3V3nTIdLkQLvfsIMtCvumEWK
 KmMzCwcJLFFz6oOCl2u/LghqlWo10Vvu6rNOYQvTUFh1ZGbh1na83BIlkRgTUFOHhlzW
 uXomMsZGs92zGbZEPhm9KSG+DVjYlJPBAfK+2MiDpQYI5bnAxHVG1mvbRUfuTAaGGkpR
 8/RqW8G2HsXVz4eNJ0oO+Ry1V4iOQa6D3kGzjUn7uWgjCLGpG1oCc1diW3kioRwZRXiJ
 Mh6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXwlQp7yBBn/46O8TF8RGkOXqS2MnXG9vUNzekj5pKjhiR7bAAUTJCMDqt4TtbRDPHIe8Wa5jo=@lists.denx.de
X-Gm-Message-State: AOJu0Yx1gPUhl4apEZjO1yO7WxvyQdcdZpKr3X4lY8d92P2rQ8yhCA5g
 J+cme5X/yJwUabvpM72d/rz50o95nNMa5t86Th91hoP6P3uY7F6gM8u5ysJWCbePYARa/YILtrw
 xqF7RFKpAlTvLp0AFroDB4ZpicwH5maxmdhBkVA==
X-Google-Smtp-Source: AGHT+IHcwKrIbxgoK4Yxl9wnwMFum2Gdy1TiFvWPzWGlypdIG2qW/Wpu1DNwwltkOMJsAs7P5T/ITgQ0pQ7uOgIwJ00=
X-Received: by 2002:a05:6a00:893:b0:712:7512:add9 with SMTP id
 d2e1a72fcca58-7199b14d47emr27599b3a.13.1726761086786; Thu, 19 Sep 2024
 08:51:26 -0700 (PDT)
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
In-Reply-To: <CAFLszTghAmCGoiHq+iBwBRC99ucBOUGG+mjq8HEjUVkPAJu-ZQ@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 19 Sep 2024 18:50:50 +0300
Message-ID: <CAC_iWjKLODdFV701vo-ECEo+_U6NQoLS=HsrgmS+RyDHd5pi0A@mail.gmail.com>
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

On Thu, 19 Sept 2024 at 18:39, Simon Glass <sjg@chromium.org> wrote:
>
> Hi,
>
> On Thu, 19 Sept 2024 at 17:37, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > On Thu, 19 Sept 2024 at 18:19, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Hi,
> > >
> > > On Thu, 19 Sept 2024 at 17:13, Ilias Apalodimas
> > > <ilias.apalodimas@linaro.org> wrote:
> > > >
> > > >
> > > >
> > > > On Thu, Sep 19, 2024, 18:05 Heinrich Schuchardt <heinrich.schuchardt@canonical.com> wrote:
> > > >>
> > > >> On 19.09.24 17:00, Simon Glass wrote:
> > > >> > Hi,
> > > >> >
> > > >> > On Thu, 19 Sept 2024 at 16:32, Ilias Apalodimas
> > > >> > <ilias.apalodimas@linaro.org> wrote:
> > > >> >>
> > > >> >> Hi all,
> > > >> >>
> > > >> >> On Thu, 19 Sept 2024 at 17:20, Heinrich Schuchardt
> > > >> >> <heinrich.schuchardt@canonical.com> wrote:
> > > >> >>>
> > > >> >>> On 19.09.24 16:10, Simon Glass wrote:
> > > >> >>>> Hi Heinrich,
> > > >> >>>>
> > > >> >>>> On Sat, 14 Sept 2024 at 18:06, Heinrich Schuchardt
> > > >> >>>> <heinrich.schuchardt@canonical.com> wrote:
> > > >> >>>>>
> > > >> >>>>> For measured be boot we must avoid any volatile values in the device-tree.
> > > >> >>>>> We already delete /chosen/kaslr-seed if we provide and EFI RNG protocol.
> > > >> >>>>
> > > >> >>>> Could you explain a bit why this is, and where this is checked?
> > > >> >>>>>
> > > >> >>>>> Additionally remove /chosen/rng-seed provided by QEMU or U-Boot.
> > > >> >>>
> > > >> >>> Measured boot relies on creating hashes of artifacts and writing these
> > > >> >>> to TPM. If the hashes don't match the OS will either warn or refuse to
> > > >> >>> boot. The device-tree is one of the artifacts that are measured.
> > > >> >>>
> > > >> >>> If we have random values in /chosen, measured boot will fail.
> > > >> >>>
> > > >> >>> When an EFI RNG protocol is provided by the firmware, GRUB and the
> > > >> >>> kernel will use it instead of /chosen/rng-seed and /chosen/kaslr-seed.
> > > >> >>
> > > >> >> There's a comment on top of that function that explains what happens as well.
> > > >> >> In short the EFI stub does not even look at the KASLR seed and never
> > > >> >> randomizes the physical placement of the kernel. It only does that
> > > >> >> when the EFI_RNG protocol is there.
> > > >> >
> > > >> > OK thank you. I suppose I am more just wondering why it got added in
> > > >> > the first place?
> > > >>
> > > >> For booting via the legacy Linux entry point adding kaslr-seed allows to
> > > >> randomize addresses. QEMU adds rng-seed instead of kaslr-seed.
> > > >
> > > >
> > > > Not the kernel physical placement. It randomizes only the virtual placement
> > >
> > > So, are you saying that U-Boot adds this field into the FDT and then removes it?
> >
> > Yes. As Heinrich said, the rng seed is still usable for some
> > randomization. If we boot with EFI and have an RNG protocol, we dont
> > need it and it also messes up the TPM measurements, so we remove it.
> > But the code that injects it to u-boot, or the prior bootloader that
> > handed you over a DT,  does not know if you plan to boot with EFI.
>
> I'm actually surprised that this works. Normally, removing a property
> does not drop that property from the string table, so adding a
> property and deleting it is not normally the same as never adding it.
> But perhaps that has changed?
>
> Anyway, I think we should add the property when we know it is OK to do
> so, which is just before we boot. If you agree I can take a look at
> that.

Sure, but we won't be able to remove this code. There are still
first-stage boot loaders that might send you a DT over a bloblist,
that has a kaslr-seed

Thanks
/Ilias
>
> Regards,
> Simon
