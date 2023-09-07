Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA4A3EC8759
	for <u-boot@archiver.kernel.org>; Thu,  7 Sep 2023 21:39:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD6C386A1A;
	Thu,  7 Sep 2023 23:39:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cmlx96ff";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E408885FD3; Thu,  7 Sep 2023 23:39:47 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A0CF86995
 for <u-boot@lists.denx.de>; Thu,  7 Sep 2023 23:39:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-99bc9e3cbf1so297121166b.0
 for <u-boot@lists.denx.de>; Thu, 07 Sep 2023 14:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1694122784; x=1694727584; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RUsPVEm9vqSHnjAIkCxOqtiaWXrdTX4yAR2rjyQGs5c=;
 b=cmlx96ffCMPRvKnBtfsbJcjl2Lp5ql9zU6vJ+yUzQ+D3W8EztIHEunpyrY5fnyNB5j
 1WcTV8X+Q3QMszvPiwInUGRaEOcvG0LX0mfNUadWTPXB7yFoD5DGBLtk1yh5go6ndy38
 aLPuyma+zZC8Zg5+SFfdL6rC10Woafli719d4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694122784; x=1694727584;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RUsPVEm9vqSHnjAIkCxOqtiaWXrdTX4yAR2rjyQGs5c=;
 b=NbXTbAcwez3ZJRWxUoAqCqvWAEvYNSckBz5ZltXHudVfaPORpzOpTqtT3SK9CTHna2
 +oL16jO8qKza7r2ivB8feMjA7VedeSaGIMvlVyfZjz8ibvohGTXUdHAMNAQgF3N2LeA+
 MBAMw7+OxgwC8h71aWW7Ys3bd1Qd1WM6OxOcnGNUns3kSCIXEzWaeKTzmflwSoc7o4zS
 iWhX2hn3LtFkZnakTcTLWdZy2xOSr4hm7uPylrohIz0Hsu3v4QGDWghnnJcVEtccyUj6
 rW90A+u1wqF5bZNDDaOw3yJkKfoNdJvK2+ZOfujTmGAPYCxO92QYKC2TVseVCFcwqHxg
 1G6g==
X-Gm-Message-State: AOJu0Ywchkk5pwNgNRhi+eLJc9EOl5C4dmmULgTuxwIFWxavB4x5lArW
 0z0Rddx4XlxjeDoYwbm7Jf5rUqfUnjEyLiRZdXYhgg==
X-Google-Smtp-Source: AGHT+IG9HkF6tjvfcyYQ9aK3TCmIpEMo5frW8roeQ/C24x9BzOzK0WYfUUFR+RLFNjMBTKyWsDxPvOYg16MHOC3hF/0=
X-Received: by 2002:a17:907:97d2:b0:9a9:d7fd:caf2 with SMTP id
 js18-20020a17090797d200b009a9d7fdcaf2mr3942086ejc.38.1694122783644; Thu, 07
 Sep 2023 14:39:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230830231758.2561402-1-sjg@chromium.org>
 <20230830231758.2561402-3-sjg@chromium.org>
 <CAMj1kXG5-aqoOtKdPFEdm=_5SdvgUTOhcDOBP1zdARAvKphJtg@mail.gmail.com>
 <CAL_JsqLx0KnXxFc8mFyT_RmA2qeBEutMXj_3nKo_g==cuSeYuQ@mail.gmail.com>
 <CAPnjgZ1U+Gy0Q_Sc63p0ixkWF9iJEEBLhV8-N9-sh7OGNy-OmQ@mail.gmail.com>
 <CAMj1kXG9vM0haSOu19j7ujQCBEN6CBeXVAH96nm+gixt9FmMrA@mail.gmail.com>
 <CAPnjgZ1oGF0Ni3RhK4fv6mJk40YjqyFVJxt6FfS9AW2rkcs9iA@mail.gmail.com>
 <CAMj1kXEZ4fDvbtgXKjF+L7si-=C-5E0XcjutoEF8pU9a-BGN-g@mail.gmail.com>
 <CAPnjgZ0vv+s00xvY2FqP+Fxb12tHuVWg-nwyWTrvuG+Mo4PaWg@mail.gmail.com>
 <CAMj1kXHGpCt8qkd6XYQF8mMdivQkTnEWjv6NzsFK=+N72LAn=Q@mail.gmail.com>
 <CAPnjgZ1vBaXfBa+FWvASi15=Py0DLbEK5XsRHLrJc02K2Yr_RQ@mail.gmail.com>
 <CAMj1kXFjVPwnu226R8bHbo0i0LZ7jQE+vLPNQa6cvrCYqGD+YA@mail.gmail.com>
 <CAPnjgZ1fVJE=ar_rB_So+vjkOZ_pDjaO5wwPn3pMKe=n3MmBeg@mail.gmail.com>
 <CAMj1kXF0J+eUC3BgCmf_ZNdpuH7gxYTUup8_AkfLEx0Co51LjQ@mail.gmail.com>
In-Reply-To: <CAMj1kXF0J+eUC3BgCmf_ZNdpuH7gxYTUup8_AkfLEx0Co51LjQ@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 7 Sep 2023 15:39:25 -0600
Message-ID: <CAPnjgZ28+eT4ULUPnxcthJef_bi=bfFT93YJYQBT2q65Qm7qGQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/4] schemas: Add some common reserved-memory usages
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Rob Herring <robh@kernel.org>,
 Devicetree Discuss <devicetree@vger.kernel.org>, 
 Maximilian Brune <maximilian.brune@9elements.com>,
 ron minnich <rminnich@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Dhaval Sharma <dhaval@rivosinc.com>, 
 U-Boot Mailing List <u-boot@lists.denx.de>, Mark Rutland <mark.rutland@arm.com>,
 Yunhui Cui <cuiyunhui@bytedance.com>, linux-acpi@vger.kernel.org, 
 Gua Guo <gua.guo@intel.com>, Lean Sheng Tan <sheng.tan@9elements.com>, 
 Guo Dong <guo.dong@intel.com>, lkml <linux-kernel@vger.kernel.org>, 
 Chiu Chasel <chasel.chiu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hi Ard,

On Thu, 7 Sept 2023 at 10:19, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> On Thu, 7 Sept 2023 at 17:57, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Ard,
> >
> > On Thu, 7 Sept 2023 at 09:07, Ard Biesheuvel <ardb@kernel.org> wrote:
> > >
> > > On Thu, 7 Sept 2023 at 16:50, Simon Glass <sjg@chromium.org> wrote:
> > > >
> > > > Hi Ard,
> > > >
> > > > On Thu, 7 Sept 2023 at 08:12, Ard Biesheuvel <ardb@kernel.org> wrot=
e:
> > > > >
> > > > > On Thu, 7 Sept 2023 at 15:56, Simon Glass <sjg@chromium.org> wrot=
e:
> > > > > >
> > > > > > Hi Ard,
> > > > > >
> > > > > > On Thu, 7 Sept 2023 at 07:31, Ard Biesheuvel <ardb@kernel.org> =
wrote:
> > > > > > >
> ...
> > > > > > >
> > > > > > > I'm happy to help flesh this out, but you still have not prov=
ided us
> > > > > > > with an actual use case, so I can only draw from my own exper=
ience
> > > > > > > putting together firmware for virtual and physical ARM machin=
es.
> > > > > >
> > > > > > I did explain that this is needed when Tianocore is on both sid=
es of
> > > > > > the interface, since Platform Init places some things in memory=
 and
> > > > > > the Payload needs to preserve them there, and/or know where the=
y are.
> > > > > >
> > > > > > I think the problem might be that you don't agree with that, bu=
t it
> > > > > > seems to be a fact, so I am not sure how I can alter it.
> > > > > >
> > > > > > Please can you clearly explain which part of the use case you a=
re missing.
> > > > > >
> > > > >
> > > > > 'Tianocore on both sides of the interface' means that Tianocore r=
uns
> > > > > as the platform init code, and uses a bespoke DT based protocol t=
o
> > > > > launch another instance of Tianocore as the payload, right?
> > > >
> > > > Not another instance, no. Just the other half of Tianocore. The fir=
st
> > > > half does platform init and the second half does the loading of the
> > > > OS.
> > > >
> > >
> > > That doesn't make any sense to me.
> > >
> > > > >
> > > > > Tianocore/EDK2 already implements methods to reinvoke itself if n=
eeded
> > > > > (e.g., during a firmware update), and does so by launching a new =
DXE
> > > > > core. So the boot sequence looks like
> > > > >
> > > > > SEC -> PEI -> DXE -> BDS -> app that invokes UpdateCapsule() -> D=
XE ->
> > > > > firmware update
> > > > >
> > > > > So please elaborate on how this Tianocore on both sides of the
> > > > > interface is put together when it uses this DT based handover. We
> > > > > really need a better understanding of this in order to design a D=
T
> > > > > binding that meets its needs.
> > > >
> > > > Are you familiar with building Tianocore as a coreboot payload, for
> > > > example? That shows Tianocore running as just the Payload, with
> > > > coreboot doing the platform init. So the use case I am talking abou=
t
> > > > is similar to that.
> > > >
> > >
> > > Yes I am familiar with that, and it is a completely different thing.
> >
> > Right, but that is my use case.
> >
>
> OK. You alluded to Tianocore <-> Tianocore being your use case, which
> is why I kept asking for clarification, as using a DT with this
> binding seems unusual at the very least.

Nevertheless, that is the goal.

>
> So coreboot does the platform init, and then hands over to Tianocore.
>
> I take it we are not talking about x86 here, so there are no Intel FSP
> blobs that may have dependencies on Tianocore/EDK2 pieces, right? So
> there are no UEFI semantics in the memory descriptions that coreboot
> provides to Tianocore.
>
> So coreboot provides information to TIanocore about
> - the platform topology (DT as usual)
> - DRAM memory banks
> - memory reservations
> - secure firmware services perhaps?
> - anything else?

Please don't widen the discussion as we are having enough trouble as
it is. Let's focus on the memory reservations.

>
>
> > >
> > > As i explained before, there is already prior art for this in
> > > Tianocore, i.e., launching a Tianocore build based on a DT descriptio=
n
> > > of the platform, including /memory and /reserved-memory nodes.
> >
> > By prior art do you mean code, or an existing binding? In either case,
> > can you please point me to it? Is this a generic binding used on x86
> > as well, or just for ARM?
> >
> > My goal here is to augment the binding.
> >
>
> No I mean code.
>
> There is
>
> https://github.com/tianocore/edk2/tree/master/EmbeddedPkg/Drivers/FdtClie=
ntDxe
>
> which encapsulates the DT received from the previous boot stage, and
> exposes it as a DXE protocol.
>
> There are other drivers that depend on this protocol, e.g., to
> discover additional memory nodes, virtio-mmio drivers and PCI host
> bridges.
>
> https://github.com/tianocore/edk2/tree/master/OvmfPkg/Fdt

That looks like Tianocore internals rather than a binding, so far as I
can tell. I do need a binding.

>
> The bindings used are the ones documented in the Linux kernel tree -
> no ad-hoc bindings are being used as far as I know.
>
> But the point I was making before re prior art was really about using
> existing bindings rather than inventing new ones. Since we are now
> talking about augmenting /reserved-memory, I think we're already on
> the same page in this regard (with the caveat that the EDK2 code does
> not actually honour /reserved-memory at this point, but this is
> because none of the platforms it is being used on today uses that
> node)

OK I'll try that patch again with compatible strings instead of node names[=
1]

>
> > >
> > > I argued that Tianocore never consumes memory reservations with UEFI
> > > semantics, given that it supplants whatever UEFI functionality the
> > > previous stage may have provided. But it shouldn't step on the code
> > > and data regions used by the previous stage if it is still running in
> > > the background (e.g., OS at EL1 and PSCI at EL2 on ARM)
> > >
> > > So this brings me back to the things I proposed in my previous reply:
> > > - memory reservations should be described in detail so the consumer
> > > knows what to do with it
> >
> > Yes I can add more detail, if that is all that is needed. But we seem
> > to still not be aligned on the goal.
> >
> >
>
> I do think we're converging, actually - it is just taking me some time
> to get a clear mental picture of how this will be used.
>
> > > - memory reservations should have attributes that describe how the
> > > memory may be used if not for the described purpose
> > >
> > > I still don't see a reason for things like runtime-code and
> > > runtime-data etc based on the above. If stage N describes the memory
> > > it occupies itself as system memory, it should reserve it as well if
> > > it needs to be preserved after stage N+1 has taken over, so perhaps i=
t
> > > should be described as a discardable memory reservation but I don't
> > > think it necessarily needs a type in that case.
> >
> > Well if you can find another way to do this in the DT, that is fine.
> >
>
> It will all be under /reserved-memory, as far as I understand. We just
> need to get to the right level of abstraction.

OK I'll try again.

Regards,
Simon

[1] I was led down the node-name path by this text in the DT spec
"Following the generic-names recommended practice, node names should
reflect the purpose of the node (ie. =E2=80=9Cframebuffer=E2=80=9D or =E2=
=80=9Cdma-pool=E2=80=9D).
Unit address (@<address>) should be appended to the name if the node
is a static allocation."
