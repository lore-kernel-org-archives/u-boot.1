Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 853A7CF395D
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 15:37:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E54C389117;
	Thu, 19 Sep 2024 17:37:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="xhyJ9rTQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AEA65891AD; Thu, 19 Sep 2024 17:37:45 +0200 (CEST)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com
 [IPv6:2607:f8b0:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 577D1887EB
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 17:37:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-71957eb256bso864322b3a.3
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 08:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726760262; x=1727365062; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Bon3ir54wF0sT38Lv/poZ/dQCHoQ4EXU7t4yhf1yh1w=;
 b=xhyJ9rTQRvYQ75AXL+TAv+s9i46Vzh86PD3hPB+FDmwfQIjb8Tu0DgKyQyWmRFiux6
 jD4AAR5n6M+LYMtyVEis2sCAPeulX5btw6ak6RajtTuZ62m0K6NOSkEpvgaeF3PB7VCK
 jzTEFr2m4D6/rA5V9k7rfZeI28YEeQ8rwEY4zujgWjsvVZ/dlGK9gchq0pJIb4UYc8xQ
 /HyttxofF5lch+TC8IilbtnU3rS30qXYSCXGsll3PtIrJVWK2MXOGpxNHhYouIcax2cp
 EAWBziuFEOIB+E08lE2nCy/t03GNJlnJTtEelyRJHrD9zS6/H4JZsEKEDjgP0xxRv0Vb
 LS0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726760262; x=1727365062;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Bon3ir54wF0sT38Lv/poZ/dQCHoQ4EXU7t4yhf1yh1w=;
 b=PMYigrAQzCsVl1vqIMof5ctlBK67i9nCgyEP0gupT5VqkEPrdrTnep8IZYcfMgRjT9
 OjE2rYCm39m+RcOR9UMNSEM3GTG3moDZNK0eAV/d3xau60WIUjQbdnwwpEbA0708J2SX
 4l5kn2y0bwqTBJOaB9juK821BIBOd1w3/hfSf254c/GSpcXUMkVtlsnky3j+Gq3s7YDa
 EB47/1FbFeg/r7XoWdBeOIisj3GdXyp6QqRcF2XHw662yOI/HuCZ5kyKN+YupyHwy01S
 y9yQ9K7lVboHPoF9enLXXy2V6O0tr1ZOatNf9CARBYoUVpbJXcJX3l58bicfUb/9XME7
 CLJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV43RV0dvgtL4TKDXotHhl7Rl+JfdVNgyLGhMdieQxxxlL6+s1UHtBEU5RQyWjYanqfWP1K25k=@lists.denx.de
X-Gm-Message-State: AOJu0Yxx2Furpx3tLCbReMKt2PqzeItTIp/5WHttz51wtW+BfQAeTy4c
 4HHsFG5t9V8n6QoRc2HqrAHzRGE9223k1lcXMZS3oy42eEzLfGZXj5nKRErN5n06fyJbakCM1Us
 9ANGqvKGum4GLRrfvSHPzA3e5pWHMsODgW2HtWg==
X-Google-Smtp-Source: AGHT+IGPOoWGdtCrbwpC+8gHy+rxiiroHaSyV36OFxl09a31TGbyxst/JQj5DXfPmrZX5a4P6x+ThrufmMoYTdk/oXE=
X-Received: by 2002:aa7:88d4:0:b0:70d:2693:d215 with SMTP id
 d2e1a72fcca58-71936a5e771mr34953733b3a.16.1726760261809; Thu, 19 Sep 2024
 08:37:41 -0700 (PDT)
MIME-Version: 1.0
References: <20240914160548.42551-1-heinrich.schuchardt@canonical.com>
 <CAFLszTjL46Gb03MS7znLujAKC0VkgOrUaZMy7XPw-jpw3TELTA@mail.gmail.com>
 <d95b95d2-7afb-42f2-9a01-75d601368be9@canonical.com>
 <CAC_iWjLCnUpnVGuVYnhzo4EaUmKMSZPws3hSzOOvQqirC71hfQ@mail.gmail.com>
 <CAFLszTimJuwFKp6DaRDJ22=0tbNPYbcLMT9hcFrC9Rca6vzAyg@mail.gmail.com>
 <b8d1cef7-4e56-49c6-aeca-b471a82870cd@canonical.com>
 <CAC_iWjLY9Oea-AryLyrQJ3zXX+Bihza5B8R5UpXh58K3+Ff=Xw@mail.gmail.com>
 <CAFLszTgASXx5t7=T+yLtC0W9dwo=FkQPF5T6eYD2uyFUWE6D_A@mail.gmail.com>
In-Reply-To: <CAFLszTgASXx5t7=T+yLtC0W9dwo=FkQPF5T6eYD2uyFUWE6D_A@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 19 Sep 2024 18:37:05 +0300
Message-ID: <CAC_iWjJL2tHTe84iqOkzDxANed-TdOObDYoW2jUwe3T=x=cyqA@mail.gmail.com>
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

On Thu, 19 Sept 2024 at 18:19, Simon Glass <sjg@chromium.org> wrote:
>
> Hi,
>
> On Thu, 19 Sept 2024 at 17:13, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> >
> >
> > On Thu, Sep 19, 2024, 18:05 Heinrich Schuchardt <heinrich.schuchardt@canonical.com> wrote:
> >>
> >> On 19.09.24 17:00, Simon Glass wrote:
> >> > Hi,
> >> >
> >> > On Thu, 19 Sept 2024 at 16:32, Ilias Apalodimas
> >> > <ilias.apalodimas@linaro.org> wrote:
> >> >>
> >> >> Hi all,
> >> >>
> >> >> On Thu, 19 Sept 2024 at 17:20, Heinrich Schuchardt
> >> >> <heinrich.schuchardt@canonical.com> wrote:
> >> >>>
> >> >>> On 19.09.24 16:10, Simon Glass wrote:
> >> >>>> Hi Heinrich,
> >> >>>>
> >> >>>> On Sat, 14 Sept 2024 at 18:06, Heinrich Schuchardt
> >> >>>> <heinrich.schuchardt@canonical.com> wrote:
> >> >>>>>
> >> >>>>> For measured be boot we must avoid any volatile values in the device-tree.
> >> >>>>> We already delete /chosen/kaslr-seed if we provide and EFI RNG protocol.
> >> >>>>
> >> >>>> Could you explain a bit why this is, and where this is checked?
> >> >>>>>
> >> >>>>> Additionally remove /chosen/rng-seed provided by QEMU or U-Boot.
> >> >>>
> >> >>> Measured boot relies on creating hashes of artifacts and writing these
> >> >>> to TPM. If the hashes don't match the OS will either warn or refuse to
> >> >>> boot. The device-tree is one of the artifacts that are measured.
> >> >>>
> >> >>> If we have random values in /chosen, measured boot will fail.
> >> >>>
> >> >>> When an EFI RNG protocol is provided by the firmware, GRUB and the
> >> >>> kernel will use it instead of /chosen/rng-seed and /chosen/kaslr-seed.
> >> >>
> >> >> There's a comment on top of that function that explains what happens as well.
> >> >> In short the EFI stub does not even look at the KASLR seed and never
> >> >> randomizes the physical placement of the kernel. It only does that
> >> >> when the EFI_RNG protocol is there.
> >> >
> >> > OK thank you. I suppose I am more just wondering why it got added in
> >> > the first place?
> >>
> >> For booting via the legacy Linux entry point adding kaslr-seed allows to
> >> randomize addresses. QEMU adds rng-seed instead of kaslr-seed.
> >
> >
> > Not the kernel physical placement. It randomizes only the virtual placement
>
> So, are you saying that U-Boot adds this field into the FDT and then removes it?

Yes. As Heinrich said, the rng seed is still usable for some
randomization. If we boot with EFI and have an RNG protocol, we dont
need it and it also messes up the TPM measurements, so we remove it.
But the code that injects it to u-boot, or the prior bootloader that
handed you over a DT,  does not know if you plan to boot with EFI.

Regards
/Ilias

>
> Regards,
> Simon
