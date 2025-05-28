Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE7EDC3ABB2
	for <u-boot@archiver.kernel.org>; Wed, 28 May 2025 16:35:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D19E8398A;
	Wed, 28 May 2025 18:35:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cRFE4DZy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D373F839EC; Wed, 28 May 2025 18:35:37 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E81F8390C
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 18:35:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-acbb85ce788so948848966b.3
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 09:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1748450134; x=1749054934; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4sIptPDUSpPdE2TaWrp7QTBGeKN0Umb3wAmx/1piwIo=;
 b=cRFE4DZyccLt+AG+TRo1pZmqzcBMKIYypW9z5KvEK4sxiWb1bppiBLV22y1/4D3yWL
 5Qv78OQ6BzOyxD/f944KG8xlygLZ5a2WihupV48xeT+2BsHl95gY5QImxZXYZl7jBzCs
 mN8QIuut6y5GMpgJrhPGm7BFUHXcDvWm7ebic=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748450134; x=1749054934;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4sIptPDUSpPdE2TaWrp7QTBGeKN0Umb3wAmx/1piwIo=;
 b=UlcMOJj1K6aonZm5zP2bplK2PV5KSI5XuAYfzRrt+69F52UYDHEEMn7OCReZKQb0vo
 xn15L+zIEAPaykhQSCePfd59FiYz4yrsJl9GS/0EcVkYefBYs4ayxcpw74I5Stsf88Lu
 nHssCBEGmITOfvkA2FqXSsSZdhTyDxeG6HaeeXsGQf4ClKUputCQbDzg+ABF3uX5y9YO
 sp2BC+gvtgbmqqpGQGIj6R+cQhMM+OnrfqHzWCXusXn1fqQP+CzCir9o0tMl11mHTOIe
 s2k/d20NGR0gpGFJT+1AG2tyIz2YY6ueEKaiEzvuIi7FeyOEoaenoh3QsuC6qQZNBYTT
 DZdQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUyy8wLDPQHOA6kznU5AHgDBiURlEeNSz2bGiiAhsM7/TcUHnoNQDtZlcQm1JD61BRduhZoNUU=@lists.denx.de
X-Gm-Message-State: AOJu0Yy5Za1zQwGGcB8EmNICNHDLZRc7KW2f+NnOjARe3N/EjQeCc3KE
 SaBuM7qu4MCWfK4jTYMGZ6z+5qCrK5AnYD5+EO1VzkktrKKtViZMQ+XwWe4gJU2DHs70Pq9EbzX
 C1OLNbuvrInBLAUxzXpuCkqXi/sKp+QaNfxpwCHq3
X-Gm-Gg: ASbGncuFkmzT9BukzxmSp0cVCsjVZ2/uzWaYsWXoMeksraosIu6sdfD6ojyj8T72q/J
 M3426EJ5W6rhi7jsq7jFGEPIQrpyxiONBQlF+TFS4imU5QDc4BbOu9PSJTsvaJJ9/TgUr7T1zn5
 2d9QVSlBuqoooRUiwYGkhdhAh83Kp5gdpc/PYmL+0/8Q==
X-Google-Smtp-Source: AGHT+IExeNX514q36lwErBo/taKq8a1VnWi70Ylzi7GGcvsHuPcZTLAxKuq0W6P4Q2Gf0LHKTerX5vsCrE31ucLaD7E=
X-Received: by 2002:a17:907:1c16:b0:ad8:a2de:d52d with SMTP id
 a640c23a62f3a-ad8a2ded825mr207947466b.61.1748450134234; Wed, 28 May 2025
 09:35:34 -0700 (PDT)
MIME-Version: 1.0
References: <20250524120904.684977-1-sjg@chromium.org>
 <CAC_iWj+XfkWPj+R1JUc0ZPFatRtpMso-Lw+uYzcgcbuKPuV3Dw@mail.gmail.com>
 <CAFLszTho++gscP4rUUY354iyVWFyPkZeMCpa-TpX0GaWOQzQvw@mail.gmail.com>
 <CAC_iWjKjZ-Q_hreO1Z64AFBWXOHB_YB_+Au_9psecVO+ATE_Pw@mail.gmail.com>
 <CAFLszTi7M335=whLPav5P4+mhunAvs4eue780_eJZNjEG_+YAg@mail.gmail.com>
 <20250528141249.GS100073@bill-the-cat>
 <CAFLszTgLpJ_LauJDANH43rJthHpMDwYfRDgMi1yW9b-EQ1yz4A@mail.gmail.com>
 <20250528150529.GZ100073@bill-the-cat>
In-Reply-To: <20250528150529.GZ100073@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 28 May 2025 17:35:21 +0100
X-Gm-Features: AX0GCFvRVy_agia_YjAPupm5RdBdTLKmFiZDS-afecS8OW5EuE0oxRQPLeP8-Yo
Message-ID: <CAFLszTgJHWKeZvXOgZO826vPkOBgJgtAhZFfxagMndEqjhM6Fg@mail.gmail.com>
Subject: Re: [PATCH 0/3] efi_loader: Move the public cerificate back to the
 devicetree
To: Tom Rini <trini@konsulko.com>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>, 
 Adriano Cordova <adrianox@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>, 
 Christian Marangi <ansuelsmth@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jonathan Humphreys <j-humphreys@ti.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>, 
 Michal Simek <michal.simek@amd.com>, Prasad Kummari <prasad.kummari@amd.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Sam Edwards <cfsworks@gmail.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tim Harvey <tharvey@gateworks.com>
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

On Wed, 28 May 2025 at 16:05, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, May 28, 2025 at 03:32:08PM +0100, Simon Glass wrote:
> > Hi Tom,
> >
> > On Wed, 28 May 2025 at 15:12, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Wed, May 28, 2025 at 08:35:37AM +0100, Simon Glass wrote:
> > > > Hi Ilias,
> > > >
> > > > On Tue, 27 May 2025 at 10:20, Ilias Apalodimas
> > > > <ilias.apalodimas@linaro.org> wrote:
> > > > >
> > > > > Hi Simon,
> > > > >
> > > > > On Tue, 27 May 2025 at 11:20, Simon Glass <sjg@chromium.org> wrote:
> > > > > >
> > > > > > Hi Ilias,
> > > > > >
> > > > > > On Sat, 24 May 2025 at 19:13, Ilias Apalodimas
> > > > > > <ilias.apalodimas@linaro.org> wrote:
> > > > > > >
> > > > > > > Hi Simon,
> > > > > > >
> > > > > > > On Sat, 24 May 2025 at 15:09, Simon Glass <sjg@chromium.org> wrote:
> > > > > > > >
> > > > > > > > A previously rejected patch to move the EFI public cerificate out of the
> > > > > > > > devicetree has recently been applied. This series reverts the change,
> > > > > > > > pending further discussion as to why it was accepted.
> > > > > > >
> > > > > > > I spent a good amount of time, writing the commit message an
> > > > > > > explaining why this patch was sent
> > > > > >
> > > > > > Yes, that is [1] and I did read it carefully before sending my series.
> > > > > >
> > > > > > From my POV there are two things wrong there:
> > > > > > - The signature is not an internal U-Boot ABI.
> > > > >
> > > > > It is, as it is for every firmware that builds out there. EDKII does
> > > > > the same thing.
> > > >
> > > > I mean that in U-Boot's case it is a published and documented
> > > > interface, or was until a few weeks ago.
> > > >
> > > > >
> > > > > >  It is how U-Boot works,
> > > > > > so if a build systems wants to inject a key it should use that
> > > > > > mechanism, not add a new mechanism into U-Boot's build system. If it
> > > > > > would help to have some documentation somewhere which says this, I
> > > > > > would be happy to send a patch to add something
> > > > > > - QEMU is blocked from accepting devicetree additions due to another
> > > > > > Linaro employee's refusal to accept a patch[2]
> > > > >
> > > > > It's not blocked. It has been NAK'ed and IMHO for a very good reason.
> > > > >
> > > > > >
> > > > > > > (which btw wasn't 'rejected', you
> > > > > > > forcefully reverted it back then with no agreements from anyone)
> > > > > >
> > > > > > The original series [4] was applied (I believe accidentally) against
> > > > > > my objections. Heinrich pulled the revert [5]. I went ahead and did
> > > > > > the QEMU patch, to help with your issue*.
> > > > >
> > > > > Heinrich applied the patches initially, and you send the revert, that
> > > > > none of the patch reviewers ack'ed.
> > > > > You reasoning back then is that the RO functionality was moot, because
> > > > > we didn't have it. It's here now.
> > > >
> > > > That was one aspect of my reasoning, but of course we can copy the
> > > > signature into protected memory, make the devicetree readonly, etc. if
> > > > desired.
> > > >
> > > > >
> > > > > >
> > > > > > > and
> > > > > > > why we prefer to do it this way. tl;dr early boot loaders that pass as
> > > > > > > a DT is a problem now.
> > > > > > > If there's a good reason to revert it, please explain it on the commit message
> > > > > >
> > > > > > The reasoning hasn't changed from the discussion three years ago -
> > > > > > please see [4]. There's also lots of discussion on your original
> > > > > > series and my revert, e.g the cover letter. A highly relevant part of
> > > > > > this is that devicetree is where config should be stored, so the build
> > > > > > system has control over what is placed there.
> > > > > >
> > > > > > But in any case, it isn't right to send the series again, under a
> > > > > > different name, e.g. not mentioning device tree.
> > > > > >
> > > > > > [..]
> > > > > >
> > > > > > Regards,
> > > > > > Simon
> > > > > >
> > > > > > * The QEMU patch is still outstanding after three years. Could you
> > > > > > please talk to Peter Maydell and see if you can get this resolved? I
> > > > > > have sent it twice since, most recently in April [7] but there was not
> > > > > > even a reply.
> > > > >
> > > > > Because they NAK'ed it a few years ago, and aren't willing to take it.
> > > > > I don't think there's anything to discuss and for the record I agree
> > > > > with the QEMU maintainers on this.
> > > >
> > > > Yes, I agree that discussion is unlikely to be fruitful. My point
> > > > remains though that your series should not have been applied, given
> > > > the previous discussion.
> > > >
> > > > This thread and the links should provide context for the future, if needed.
> > > >
> > > > One other thing I forgot for the record is that [8] and [9] are only
> > > > needed due to Linaro's refusal to accept the QEMU patch or propose a
>
> ^^^^^
>
> > > > convenient alternative.
> > > >
> > > > For now I've applied this series to my tree.
> > >
> > > You can do whatever you like in your downstream tree, but please stop
> > > implying that "Linaro" is in charge of QEMU. They very much are not and
> > > I don't want other communities to think that you and your attitude
> > > represent the U-Boot project.
> >
> > That wasn't my intention at all. Where are you reading that?
> >
> > I am just pointing out that Linaro rejected [2]. Ilias (also at
> > Linaro) has stated that he agreed with the decision. Do you agree with
> > my analysis here?
>
> And then your analysis here are where it sure sounds like you blame
> Linaro for what the QEMU project is doing. I am 100% certain that if
> Ilias and Peter left Linaro today, tomorrow they would still reject your
> changes on technical, not implicitly nefarious business, grounds.

Not the QEMU project, just the ARM maintainer, who I believe is Peter
Maydell who I believe works at Linaro.

I think it is important to call out this sort of thing, so people know
where the roadblocks are for U-Boot in the firmware world. This is
certainly one of them.

Ilias, re 'obvious violation of the DT spec', DT schema has an
/options node. Linux has quite a lot of stuff which is configuration
rather than hardware - e.g. see
Documentation/devicetree/bindings/mtd/partitions/partition.yaml

We've discussed this a lot so I'm not expecting to change any minds
here, but I am firmly of the view that U-Boot uses devicetree for its
configuration and it needs to stay that way.

BTW I just read [2] again. I'm even more convinced that QEMU needs
this feature and surprised that Peter took the line he did. It would
be an interesting exercise to send a patch adding some bootph tags to
QEMU :-)

Regards,
Simon


>
> > > > > > [1] https://patchwork.ozlabs.org/project/uboot/patch/20250401112729.2181793-1-ilias.apalodimas@linaro.org/
> > > > > > [2] https://patchwork.kernel.org/project/qemu-devel/patch/20210926183410.256484-1-sjg@chromium.org/#24481799
> > > > > > [3] https://lore.kernel.org/u-boot/CAPnjgZ2uM=n8Qo-a=DUkx5VW5Bzp5Xy8=Wgmrw8ESqUBK00YJQ@mail.gmail.com/
> > > > > > [4] https://patchwork.ozlabs.org/project/uboot/list/?series=253693&state=*&archive=both
> > > > > > [5] https://patchwork.ozlabs.org/project/uboot/cover/20210802144431.2396678-1-sjg@chromium.org/
> > > > > > [6] https://patchwork.kernel.org/project/qemu-devel/patch/20250405191352.2597585-1-sjg@chromium.org/
> > > > > > [7] https://patchwork.kernel.org/project/qemu-devel/patch/20250405191352.2597585-1-sjg@chromium.org/
> > > > [8] https://lore.kernel.org/u-boot/20250510134253.1581164-2-sjg@chromium.org/
> > > > [9] https://docs.u-boot.org/en/latest/develop/devicetree/dt_qemu.html
> > >
> > > --
> > > Tom
>
> --
> Tom
