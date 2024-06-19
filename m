Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A1C2C27C4F
	for <u-boot@archiver.kernel.org>; Wed, 19 Jun 2024 03:02:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A45F883CD;
	Wed, 19 Jun 2024 05:02:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fgZ3i79P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3C65E88408; Wed, 19 Jun 2024 05:02:05 +0200 (CEST)
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com
 [IPv6:2607:f8b0:4864:20::72d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B30E883CD
 for <u-boot@lists.denx.de>; Wed, 19 Jun 2024 05:01:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x72d.google.com with SMTP id
 af79cd13be357-7954dcf3158so363859885a.3
 for <u-boot@lists.denx.de>; Tue, 18 Jun 2024 20:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718766116; x=1719370916; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/4VUzLOtPvKcjhtWQiFYOzrdssuoZsXJCItIEHiaeHc=;
 b=fgZ3i79P78kiqLVC9VHdErgw87wIS1j7VM/8g7iFf0uJjUSP5GNQRhE45cVgKSlukA
 9iJXfUdjuTOhlcT8IlcpUA3hT7KzR9BsfMwmmIUo03lt+Cg0vYc9Z0RwXRgvVh0e/2an
 DekYkbTU/E85cgQqDacUsSMT2LidREOiFVQrA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718766116; x=1719370916;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/4VUzLOtPvKcjhtWQiFYOzrdssuoZsXJCItIEHiaeHc=;
 b=MjGsxxc3MsQbjVnJ7FYfxbAnseufoubtO5YyYUs18RsWNaCEF7tbY07dugjTlklDFd
 wUMNNmnTNQJGkGtLGb6VehOoVlNFpeAxVNfPYMKh/beRn7XSJR7WtPCsWnwiFTVCEml8
 lU3QA7AcxgDVCl/UDy2aQPU2TZSN3/tSq4NhFlIlQ52WnLcJXlEsI7EhZ9/pn2Z10Crw
 I6gs7gjtZWEDcu5XAUACYhpX5q0GVWOwb5XqiII8ZJyYHkNjDNHJ45BtYuQBmYKTlhqy
 BLkBB5GQHnQErZcgFeMSnE3o5UEzyCit5yvZaeI8dXFUgDicJdkH2nzI1b2eeLvCjuuB
 0auA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWU8leixAKrbSPngejiStnEDZYZkJJBvgWwc8qTGY08we4yfzdSrF/s8PljWFhJo61f/KXhjP8Cq4WsK5WTBqVdwS+ZEQ==
X-Gm-Message-State: AOJu0YxqHJiQmP/LrCUBxPtfwMPoq1WtsE0LDg2r/nlk+s/rzYwtZ9MN
 82BUXJuWjbJCTf6+YAcN4kXDmZT9iUdRCR3xnzKTFHhhzxOv6jcrfqrW07WlHVkZnJLZ/XsITnC
 htZkTFRi7YOGyG6Ss+tF2qH0ewA6ta29fdTII
X-Google-Smtp-Source: AGHT+IEhkYJ9utl6MfOdyIrdSYbAFriOTtIZ5j4sQRZnAlcLbJOGAIdAccwJ0XsXtVepSErqW3p+RvIS3yF8QGWv2gY=
X-Received: by 2002:ad4:4306:0:b0:6b4:fdfd:fece with SMTP id
 6a1803df08f44-6b501ea3bacmr15422456d6.44.1718766116362; Tue, 18 Jun 2024
 20:01:56 -0700 (PDT)
MIME-Version: 1.0
References: <20240607185240.1892031-5-sughosh.ganu@linaro.org>
 <CAFLszTjQW72_Z8Dx4g1mVx5Y=wq9xeXYVBffxLUto6sDp6CMbw@mail.gmail.com>
 <20240611210145.GM68077@bill-the-cat>
 <CAFLszTjd4Sf=_um7QbkpbLAO9=2=vX_LkHv6br=9FPAPFhbH5Q@mail.gmail.com>
 <20240611225554.GO68077@bill-the-cat>
 <CAFLszTi1ZR+qeEuEbGUE2Fv3h1ahX3S_2ySBPQjgkfruiW8Xtw@mail.gmail.com>
 <20240612172244.GG68077@bill-the-cat>
 <CAFLszThj1wmF4zOLDjSjHX1cg8RfiHMGgpbRccJ-VJu2dtihNw@mail.gmail.com>
 <20240612214001.GI68077@bill-the-cat>
 <CAFLszTiZSu+aN53kAPd2GXosXv09Ams+jFDi2xGU0wh+faO=dg@mail.gmail.com>
 <20240613154206.GO68077@bill-the-cat>
 <CAFLszThvhYKpxLhJOgXOkW244Cj6Au=+LqhzHTtYHtri_+tmEg@mail.gmail.com>
 <1604c2a7-d72e-491f-806f-da29d14f0a17@gmx.de>
 <CAFLszTjMnxN-pNLxe=pamC=OQpKtPRAL0Xrr17x8Sn+oU+8gQA@mail.gmail.com>
 <0397EEF3-D89D-45CC-BBA9-961DE973249E@gmx.de>
 <CAC_iWjKxkQrcZ9oEfe=t21ox8eooemk3QnHsVg00zgpebTQHPQ@mail.gmail.com>
In-Reply-To: <CAC_iWjKxkQrcZ9oEfe=t21ox8eooemk3QnHsVg00zgpebTQHPQ@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 18 Jun 2024 21:01:45 -0600
Message-ID: <CAFLszTjV_arXOT27wBemqh=g=PM_NEOkhD9Z5sWPiQvyD7DCZQ@mail.gmail.com>
Subject: Re: [RFC PATCH 04/31] lmb: remove local instances of the lmb
 structure variable
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de, 
 Marek Vasut <marex@denx.de>, Mark Kettenis <mark.kettenis@xs4all.nl>, 
 Fabio Estevam <festevam@gmail.com>, Tom Rini <trini@konsulko.com>
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

On Thu, 13 Jun 2024 at 23:58, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> On Thu, 13 Jun 2024 at 23:11, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> >
> >
> >
> > Am 13. Juni 2024 21:05:58 MESZ schrieb Simon Glass <sjg@chromium.org>:
> > >Hi Heinrich,
> > >
> > >On Thu, 13 Jun 2024 at 11:32, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> > >>
> > >> On 13.06.24 18:59, Simon Glass wrote:
> > >> > Hi Tom,
> > >> >
> > >> > On Thu, 13 Jun 2024 at 09:42, Tom Rini <trini@konsulko.com> wrote:
> > >> >>
> > >> >> On Thu, Jun 13, 2024 at 09:22:15AM -0600, Simon Glass wrote:
> > >> >>> Hi Tom,
> > >> >>>
> > >> >>> On Wed, 12 Jun 2024 at 15:40, Tom Rini <trini@konsulko.com> wrote:
> > >> >>>>
> > >> >>>> On Wed, Jun 12, 2024 at 02:24:25PM -0600, Simon Glass wrote:
> > >> >>>>> Hi Tom,
> > >> >>>>>
> > >> >>>>> On Wed, 12 Jun 2024 at 11:22, Tom Rini <trini@konsulko.com> wrote:
> > >> >>>>>>
> > >> >>>>>> On Tue, Jun 11, 2024 at 08:41:39PM -0600, Simon Glass wrote:
> > >> >>>>>>
> > >> >>>>>> [snip]
> > >> >>>>>>> Also IMO there is only really one LMB list today. We create it at the
> > >> >>>>>>> start of bootm and then it is done when we boot. The file-loading
> > >> >>>>>>> stuff is what makes all this confusing...and with bootstd that is
> > >> >>>>>>> under control as well.
> > >> >>>>>>>
> > >> >>>>>>> At lot of this effort seems to be about dealing with random scripts
> > >> >>>>>>> which load things. We want to make sure we complain if something
> > >> >>>>>>> overlaps. But we should be making the bootstd case work nicely and
> > >> >>>>>>> doing things within that framework. Also EFI sort-of has its own
> > >> >>>>>>> thing, which it is very-much in control of.
> > >> >>>>>>>
> > >> >>>>>>> Overall I think this is a bit more subtle that just combining allocators.
> > >> >>>>>>
> > >> >>>>>> I think this gets to the main misunderstanding. The problem isn't
> > >> >>>>>> handling bootstd, or EFI boot, or even assorted scripts. Those are all
> > >> >>>>>> cases where things are otherwise (sufficiently) well-defined. The
> > >> >>>>>> problem is "security" and that a "carefully crafted payload" could do
> > >> >>>>>> something malicious. That's why we have to do all of this stuff sooner
> > >> >>>>>> rather than later in our boot process.
> > >> >>>>>
> > >> >>>>> That's the first I have heard of this, actually, but a bit more detail
> > >> >>>>> would help. How does the payload get loaded? I'm just not sure about
> > >> >>>>> the overall goals. It seems that everyone else is already familiar -
> > >> >>>>> can someone please take the time to point me to the details?
> > >> >>>>
> > >> >>>> Well, the short version I believe of the first CVE we got (and so
> > >> >>>> started abusing LMB) was along the lines of "load an image near where
> > >> >>>> the U-Boot stack is, smash things for fun and exploits".
> > >> >>>
> > >> >>> OK. I am surprised that LMB does not catch that. It is supposed to add
> > >> >>> the stack and various other things right at the start before loading
> > >> >>> any file. So even if it clears the LMB each time, it should not be
> > >> >>> able to do that. Having said this, the code may be buggy as I don't
> > >> >>> think we have tests for U-Boot's overall functional behaviour in these
> > >> >>> situations.
> > >> >>
> > >> >> Right, LMB does catch the example I gave (because we made all of the
> > >> >> load from storage/network functions init an lmb and we always make sure
> > >> >> a new lmb gets U-Boot stack/etc). The next thing we didn't catch was
> > >> >> "what if EFI does the loading?" and we've kludged around that, and in
> > >> >> turn had some of the thorny questions. Some of that is what I think
> > >> >> you're asking about in this part of the thread, to which the answer is
> > >> >> "EFI spec says you need to place X in memory", so we just need to
> > >> >> reserve it when it's asked for, so that something else can't come along
> > >> >> and smash it maliciously.
> > >> >
> > >> > OK I see. Of course it isn't just EFI that has this issue. I believe
> > >> > the answer (for small blocks) is to use malloc(), which I think we do
> > >> > with a few exceptions which Ilias pointed out. For things like the TPM
> > >> > log and ACPI tables we should probably use a bloblist, as we do on
> > >> > x86. For large things (like loading a kernel) we should use LMB. I've
> > >> > been thinking about how best to tie this to boot, as opposed to random
> > >> > allocations in U-Boot itself, which would lead to fragmentation and
> > >> > strange behaviour. I think bootstd is a great place to have a
> > >> > persistent LMB. It can be attached to bootstd_priv.
> > >> >
> > >> > My hope is that EFI is just another boot method, where
> > >> > already-allocating things are presented to the OS. Apart from the
> > >> > Ilias exceptions, I believe this is how it works today.
> > >> >
> > >> > Where I think this heads in the wrong direction is using
> > >> > EFI-allocation functions before we are booting an EFI image. EFI has
> > >> > no concept of what is 'in empty space' so it leads to the lmb
> > >> > conflict, the subject of this discussion.
> > >>
> > >> EFI binaries can return to the command line interface.
> > >> EFI binaries may be drivers that stay resident and run in the background
> > >> after returning to the command line interface. They might for instance
> > >> provide block devices.
> > >
> > >Hmm you mentioned that before but I'm still not quite understanding.
> > >Do you mean that the EFI app returns back to U-Boot, leaving the
> >
> > There are 3 types of of EFI binaries:
> >
> > * apps
> > * boot time drivers
> > * run time drivers
> >
> >
> > >driver active? If so, how does U-Boot use the driver? I'm just not
> > >familiar with how such a construct could work in a single-threaded
> > >U-Boot.
> >
> > We already have code for EFI block devices. See lib/efi_driver/
> >
> > When U-Boot reads from such a block device it may end up in an EFI driver that for instance uses U-Boots network drivers exposed as EFI simple network protocol to read from an NVMEoF or iSCSI server.
> >
> > >
> > >>
> > >> Device-paths must be created from EFI pool memory as they may be freed
> > >> via FreePool() according to the EFI specification. And these we create
> > >> whenever a block-device is probed.
> > >
> > >The implementation of pool memory rounds up to pages and uses that. It
> > >might be more efficient to use malloc()/free() instead, given that we
> > >mark the malloc() space as reserved when we call the EFI app.
> >
> > We have requirements on which EFI allocations may reside in the same page. See the ARM chapter in the UEFI specification.
>
> And apart from all Heinrich mentioned, EFI memory has to be marked and
> preserved at runtime for runtime services and data.
> Using malloc for the variables, the eventlog etc, would just
> complicate the EFI code, as we'd have to copy those just before
> ExitBootServices is called.

Since malloc() is marked as boot-time memory, you can just leave them
where they are. Lots of things are in the malloc() region anyway.

Regards,
Simon
