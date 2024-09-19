Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C305CF395D
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 15:39:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CBAAC891A5;
	Thu, 19 Sep 2024 17:39:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="g2k14ljb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E1B00891C0; Thu, 19 Sep 2024 17:39:50 +0200 (CEST)
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B738888A24
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 17:39:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-5d5f24d9df8so453334eaf.2
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 08:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1726760387; x=1727365187; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=oNMEGpbMCqSqS0+9ZUcWxbddCsWwJqGtLfIIX3NTvQA=;
 b=g2k14ljbed+lGUZZg3jJjQCm9/cUdbmpFhOWPwm8ydUYw4N9/lfI+54f95rqMsVikh
 +Oj0otUgUQW6d6hS3U5HxkgxOK3b5CGsK1k5LCEO9QWhIud9RP/ypOHfw5LukwLahO+V
 UORGG9yGi7tORx+xoKegW7qt/nlCQAIJJe+TM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726760387; x=1727365187;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oNMEGpbMCqSqS0+9ZUcWxbddCsWwJqGtLfIIX3NTvQA=;
 b=vhcwvGTAOusLG2siqleNf0Mpc4Z+hMYMD0K3NpLlNWp/oZcfskr2ndMzv3jch6ykC9
 tyWF5YvwVtQs+XhUbODhOIZBukIwBrwgzVYGLIepIZzP+v2WP9750MNad/siCsR7X8Aw
 9RO6HwgWRTeqPRu3WU7N60V4JRXntNj+KQjaLCQXrq6itU0ehnkW4aISHVSf5Kca7OMH
 pUpDpoD6fTlmnhsm+/sjaDzu2DsyCSahls6n7AiePdmt51XRT4Szs52siMVN58/fzV9B
 oyi9NIefspTHVhqqhqSLTLrR6CgBOczi8MW4xiRl1BC23d/3BWI30McDOvxu3XZE9xcj
 6Uzw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXtZnfTpmVck7Dl9XMJaEtw7XUSnXjZE9HcpGefAEaKdxsL7+czQ8fky0s7h1YU/cgjzwZfmN8=@lists.denx.de
X-Gm-Message-State: AOJu0YxF0gj7tgzfaE+bQFBRSFtnwGbTwlietQH6L0v05HntbSBH9hh1
 ABJaPSLE5TDUGEpYQVzD9agbMAKuqw6gD3z74vecxPmMCUTbBTl4M+2wlHqSSzavR9hBvHZFCXO
 t+DHS5n5/rZNfOnlk4E0xmdllguP6YaeHD21C
X-Google-Smtp-Source: AGHT+IFfzOX7JJzeoIJ7XRJdtSKZ3ofLTaVtnBFLEI9L3hSCP+nwLEhzcOR6195K46V6ATFtSAI8gbcRRWhYgCqDoDM=
X-Received: by 2002:a05:6358:7246:b0:1b5:fa6e:460c with SMTP id
 e5c5f4694b2df-1bc975e9df7mr3510555d.13.1726760387344; Thu, 19 Sep 2024
 08:39:47 -0700 (PDT)
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
In-Reply-To: <CAC_iWjJL2tHTe84iqOkzDxANed-TdOObDYoW2jUwe3T=x=cyqA@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 19 Sep 2024 17:39:36 +0200
Message-ID: <CAFLszTghAmCGoiHq+iBwBRC99ucBOUGG+mjq8HEjUVkPAJu-ZQ@mail.gmail.com>
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

Hi,

On Thu, 19 Sept 2024 at 17:37, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> On Thu, 19 Sept 2024 at 18:19, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi,
> >
> > On Thu, 19 Sept 2024 at 17:13, Ilias Apalodimas
> > <ilias.apalodimas@linaro.org> wrote:
> > >
> > >
> > >
> > > On Thu, Sep 19, 2024, 18:05 Heinrich Schuchardt <heinrich.schuchardt@canonical.com> wrote:
> > >>
> > >> On 19.09.24 17:00, Simon Glass wrote:
> > >> > Hi,
> > >> >
> > >> > On Thu, 19 Sept 2024 at 16:32, Ilias Apalodimas
> > >> > <ilias.apalodimas@linaro.org> wrote:
> > >> >>
> > >> >> Hi all,
> > >> >>
> > >> >> On Thu, 19 Sept 2024 at 17:20, Heinrich Schuchardt
> > >> >> <heinrich.schuchardt@canonical.com> wrote:
> > >> >>>
> > >> >>> On 19.09.24 16:10, Simon Glass wrote:
> > >> >>>> Hi Heinrich,
> > >> >>>>
> > >> >>>> On Sat, 14 Sept 2024 at 18:06, Heinrich Schuchardt
> > >> >>>> <heinrich.schuchardt@canonical.com> wrote:
> > >> >>>>>
> > >> >>>>> For measured be boot we must avoid any volatile values in the device-tree.
> > >> >>>>> We already delete /chosen/kaslr-seed if we provide and EFI RNG protocol.
> > >> >>>>
> > >> >>>> Could you explain a bit why this is, and where this is checked?
> > >> >>>>>
> > >> >>>>> Additionally remove /chosen/rng-seed provided by QEMU or U-Boot.
> > >> >>>
> > >> >>> Measured boot relies on creating hashes of artifacts and writing these
> > >> >>> to TPM. If the hashes don't match the OS will either warn or refuse to
> > >> >>> boot. The device-tree is one of the artifacts that are measured.
> > >> >>>
> > >> >>> If we have random values in /chosen, measured boot will fail.
> > >> >>>
> > >> >>> When an EFI RNG protocol is provided by the firmware, GRUB and the
> > >> >>> kernel will use it instead of /chosen/rng-seed and /chosen/kaslr-seed.
> > >> >>
> > >> >> There's a comment on top of that function that explains what happens as well.
> > >> >> In short the EFI stub does not even look at the KASLR seed and never
> > >> >> randomizes the physical placement of the kernel. It only does that
> > >> >> when the EFI_RNG protocol is there.
> > >> >
> > >> > OK thank you. I suppose I am more just wondering why it got added in
> > >> > the first place?
> > >>
> > >> For booting via the legacy Linux entry point adding kaslr-seed allows to
> > >> randomize addresses. QEMU adds rng-seed instead of kaslr-seed.
> > >
> > >
> > > Not the kernel physical placement. It randomizes only the virtual placement
> >
> > So, are you saying that U-Boot adds this field into the FDT and then removes it?
>
> Yes. As Heinrich said, the rng seed is still usable for some
> randomization. If we boot with EFI and have an RNG protocol, we dont
> need it and it also messes up the TPM measurements, so we remove it.
> But the code that injects it to u-boot, or the prior bootloader that
> handed you over a DT,  does not know if you plan to boot with EFI.

I'm actually surprised that this works. Normally, removing a property
does not drop that property from the string table, so adding a
property and deleting it is not normally the same as never adding it.
But perhaps that has changed?

Anyway, I think we should add the property when we know it is OK to do
so, which is just before we boot. If you agree I can take a look at
that.

Regards,
Simon
