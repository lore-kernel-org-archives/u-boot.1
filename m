Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DDCFC4332F
	for <u-boot@archiver.kernel.org>; Fri, 10 Nov 2023 11:50:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8ED5E8761C;
	Fri, 10 Nov 2023 12:50:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ksobZahM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D692875E8; Fri, 10 Nov 2023 12:50:44 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0CFD4875AA
 for <u-boot@lists.denx.de>; Fri, 10 Nov 2023 12:50:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-9c41e95efcbso322105166b.3
 for <u-boot@lists.denx.de>; Fri, 10 Nov 2023 03:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699617036; x=1700221836; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FSkTq7EOYt0EfcgBZLPJtTroCsVvyGdrMymhgKrQsaE=;
 b=ksobZahMeF8JpZ74DSWj1sDaiN1g68ct66KvEoM/29g8TFZZc9iOGQrQSeKznfzvk3
 zEqKw6QLf9Gd5X7l3zDTkZiLY+5bbZZA6BC96Y2MZ5mohhL0o4jd+BVuVj1OZvbKTxyu
 i9nQQyuhSifH1HjmKBef1/h+DIa1lv1ZWlrtM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699617036; x=1700221836;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FSkTq7EOYt0EfcgBZLPJtTroCsVvyGdrMymhgKrQsaE=;
 b=GIrTNMNMnY3DweMaYreFoqJIvDf+ExETAHDyF7D8Aq9DhnxKIAp4Mfe796NRYUgH+s
 upu3fZQgpuNQvzeVLGS/qoZL9r0IcOwWCdmS75UeFtzZ4XpOQQxKP8m/ux8Kk7F3yHxX
 EVhy2xVLOWqZnu4kIANDN8PQzp2sOLOrmMGkYPsWOoIr+GhkkSAFUzE4ttsHbg/I3eE9
 eWo2uQVHEMCNjMlJ9G3HnvwCvTBS08i1dQJFveVUhFTpY6ZrMRTdlfu4Mzg/EERy16Pe
 ArH0yg6qmzAfjh1ZUZTFtl0sIs1z3TG7rWSh5JzRnYp0Eo6NmCN4m935dh33w0O8x0g6
 TiWQ==
X-Gm-Message-State: AOJu0YyHBomOICjs/JLQfL8UfgG/u9VZAcC+LG5fCI8jZL+XfCAUyfrI
 Ysk4lVanxnrKRr50NHy0YI/Mj4oA52nOCmEDd7GOyw==
X-Google-Smtp-Source: AGHT+IEjyT/h0zT5/IundIegRo4mn3e3DUaORCUTfv0hnCiZYy45cybTy9CHk7PcLaF2DHaccx4VHqOctjHfpolrA3E=
X-Received: by 2002:a17:906:fd85:b0:9c7:5667:5649 with SMTP id
 xa5-20020a170906fd8500b009c756675649mr6579825ejb.73.1699617036134; Fri, 10
 Nov 2023 03:50:36 -0800 (PST)
MIME-Version: 1.0
References: <20231107-audible-undoing-293506af3890@spud>
 <mhng-6682c062-a0e0-4811-8315-54a653c0e540@palmer-ri-x1c9>
In-Reply-To: <mhng-6682c062-a0e0-4811-8315-54a653c0e540@palmer-ri-x1c9>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 10 Nov 2023 04:50:17 -0700
Message-ID: <CAPnjgZ0Z-Ge=LDcz9-xyM4KRCVVkJRWvtoWjyigSC-Xc3V1RDA@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] rng: Provide a RNG based on the RISC-V Zkr ISA
 extension
To: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Conor Dooley <conor@kernel.org>, trini@konsulko.com, robh@kernel.org, 
 andre.przywara@arm.com, heinrich.schuchardt@canonical.com, rick@andestech.com, 
 ycliang@andestech.com, apatel@ventanamicro.com, merlew4n6@gmail.com, 
 chanho61.park@samsung.com, sughosh.ganu@linaro.org, u-boot@lists.denx.de, 
 Peter.Hoyes@arm.com, avromanov@salutedevices.com, ilias.apalodimas@linaro.org
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

On Wed, 8 Nov 2023 at 10:38, Palmer Dabbelt <palmer@dabbelt.com> wrote:
>
> On Tue, 07 Nov 2023 15:12:16 PST (-0800), Conor Dooley wrote:
> > +CC Palmer
> >
> > On Tue, Nov 07, 2023 at 05:38:37PM -0500, Tom Rini wrote:
> >> On Tue, Nov 07, 2023 at 10:27:50PM +0000, Conor Dooley wrote:
> >> > On Tue, Nov 07, 2023 at 05:10:23PM -0500, Tom Rini wrote:
> >> >
> >> >
> >> > > further clarify or not
> >> > > the RISC-V ISA thing that's elsewhere in this thread (and part of the
> >> > > kernel, not a U-Boot thing).
> >> >
> >> > TBH, this a bit fragmented across threads, and as someone that hasn't
> >> > been following it it's a bit difficult to tell exactly what is being
>
> Also just kind of jumping in: I don't usually follow u-boot stuff, but a
> few of us ended up talking abot this.
>
> >> > asked for. Would someone be able to ask it as a direct question?
> >>
> >> Sorry for being unclear, and thanks for asking. What I think the U-Boot
> >> community would like to know is, what is the device-tree based way to
> >> know if a RISC-V platform has the Zbb extensions
> >
> > For this one, it's pretty straightforward IMO - if riscv,isa-extensions
> > contains "zbb", then you are safe to use those instructions. My
> > understanding is that relying on getting illegal instruction traps is
> > not a sufficient test for usability of standard extensions, as a vendor
> > extension could be using the same opcodes as a standard extension.
>
> Not just could, but we've got systems that actually overlay
> vendor-specific behavior onto the standard encoding space.  There's a
> lot of small offenders for things like errata, but there's also stuff
> like T-Head where huge chunks of space reserved by the ISA for standard
> stuff gets reused.
>
> >> so the RNG opcodes,
> >> similar (in concept at least?) to the ARMv8.5 RNG feature.
> >
> > The ordinary extensions that are instructions - like Zbkb that provides
> > bit manipulation instructions for cryptography you will be able to rely
> > on riscv,isa-extensions also. Zkr is actually a CSR acting as an entropy
> > source and is a bit more complicated. RISC-V Cryptography Extensions
> > Volume I, Chapter Four [0] is the relevant thing for use of the CSR
> > provided by Zkr, and it says "The seed CSR is also access controlled by
> > execution mode, and attempted read or write access will raise an illegal
> > instruction exception outside M mode unless access is explicitly granted."
> > My take is that either the SBI implementation needs to provide S-Mode
> > U-Boot with an accurate devicetree (including what extensions are valid
> > for use in S-mode) or if the devicetree is provided as part of the U-Boot
> > binary then it needs to match what is available at that privilege level
> > on the platform. In this case, you would also be able to rely on
> > riscv,isa-extensions for that detection. There is an existing dt-binding
> > patch
> > <https://lore.kernel.org/linux-riscv/20231107105556.517187-6-cleger@rivosinc.com/>
> > that adds Zkr, and my proposal would be to document that the presence of Zkr
> > explicitly in riscv,isa-extensions means that the bit in mseccfg.[s,u]seed
> > has been set so it can be used at the current privilege level.
>
> FWIW, that seems generally viable to me.
>
> > If that's not acceptable, and people think that having Zkr in the
> > devicetree means that the hardware has the extension, regardless of
> > usability at the present privilege level, then IMO we need an SBI ecall
> > defined to request entablement of the CSR & report as to whether or not
> > that was possible.
>
> I think we can start without the SBI interface, but I'm not 100% sure.
> I was worried about writes to "seed" somehow resulting in an information
> leak, but the spec says "The write value (in rs1 or uimm) must be
> ignored by implementations." so I think we're safe.
>
> > I'm not sure how any of the above lines up with the ARMv8.5 RNG feature
> > unfortunately.
>
> All I know is what's in this patch set
> <https://patchwork.kernel.org/project/linux-arm-kernel/patch/20191019022048.28065-2-richard.henderson@linaro.org/>.
> It looks generalyl to me like the RNDR bits in
> "cpu-features-registers.rst" would coorespond to "Zkr" being set in
> "riscv,isa-extensions" -- we don't have ISA-defined feature registers,
> hence why all this ends up shimed in via DT.

Thanks for the info.

What is the hardware architecture of the RNG? Is there a single RNG in
the SoC or does each CPU have its own? Is it configurable in any way?

>
> >
> > Cheers,
> > Conor.
> >
> > 0 - https://github.com/riscv/riscv-crypto/releases/tag/v1.0.1-scalar

Regards,
Simon
