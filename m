Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35001C4332F
	for <u-boot@archiver.kernel.org>; Tue,  7 Nov 2023 01:11:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9DF7286F1F;
	Tue,  7 Nov 2023 02:11:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="b4c1tNW8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B1ED7870C5; Tue,  7 Nov 2023 02:11:05 +0100 (CET)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 082AF86C56
 for <u-boot@lists.denx.de>; Tue,  7 Nov 2023 02:11:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-53d8320f0easo8451881a12.3
 for <u-boot@lists.denx.de>; Mon, 06 Nov 2023 17:11:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699319462; x=1699924262; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Zlo3bm8TfLmAqHY1nvhcYBdVrhjXe3dQyW91k+5Bwiw=;
 b=b4c1tNW8sBFeEBDN/Rz7OiRaLWgM09eDMuOkRVYB33BQZZGgdFglS3JLIRBacR5GfI
 fa+sR6YtB4Aw+/2xVhJIAC5jpfDD/SABhxyQrBJpQ7Gc+QcH8/Gq05Narpom8HAF7UQR
 9t1IemdcEgkBkYnf1dss+Bl3PZSdbVQkOAZzw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699319462; x=1699924262;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Zlo3bm8TfLmAqHY1nvhcYBdVrhjXe3dQyW91k+5Bwiw=;
 b=Lxw6gWqKL8nm+t/7rMJ5JaSRDFduLcjjwBmdTeI5golhFCtwB/vRaPVh1paX+BMES4
 R3Z7fg0+2pvWk0hwfBJexxCygqFz0bQRT7b51F0VLD3J0LA2SdGgacsk9ViCNBbDqctt
 BrV8UQCLMC51+hVc5momZtAVJgQssDO5KZirFq3tTYVMNuQy7w17ULxs+Nlee+dVJK22
 LWwVKiCIzUnarYwB7D9FQzaZANTtQj44ODU5SwXKjWSn13++3jzKyHigSqB7QY0ubE0X
 WvBQTJZl5Q6TYB6ek6U3FvrOT6XGrjWLCK5pv6DgRL4+XbCq88KNtRmPhNoFXB9YI0i6
 9QAQ==
X-Gm-Message-State: AOJu0YyE3mDbKpbbCkZR5/GhzdozGr9eXUbLrbylyc6t16KNdtClJ4Qq
 wyBRG8Oi0nXVolQLXAc7tjvy/qwH/DPRzHoq0chbag==
X-Google-Smtp-Source: AGHT+IGtK4+C8caiw8Kfqb5QESEdn1MqSqQZQM12bCt0dRZK9kQu9u83RCSnOCQ6AGMpWPfHMPIvBG7CalTAmacHh0k=
X-Received: by 2002:a50:8714:0:b0:53e:df56:9a63 with SMTP id
 i20-20020a508714000000b0053edf569a63mr18103146edb.15.1699319462379; Mon, 06
 Nov 2023 17:11:02 -0800 (PST)
MIME-Version: 1.0
References: <20231031125552.26698-1-heinrich.schuchardt@canonical.com>
 <20231101170559.680ab493@donnerap.manchester.arm.com>
 <50ff2080-5831-4963-937d-331248b59973@canonical.com>
 <CAPnjgZ1gPRQiEq8=tVCtC6wznOWXX2bLaimSwd73=74oEWAXYQ@mail.gmail.com>
 <20231104171212.3d041a4f@slackpad.lan>
 <CAPnjgZ1X8R4h24pP1zoqEADTbntm5Yo2YqfMTePVqbHoJMx_vA@mail.gmail.com>
 <20231106172601.12c36750@donnerap.manchester.arm.com>
 <CAPnjgZ1v1UfADOFDFFFD9UBo5QcRPNLBk+XLBL4JNbGy9poVJw@mail.gmail.com>
 <20231106204608.GJ496310@bill-the-cat>
In-Reply-To: <20231106204608.GJ496310@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 7 Nov 2023 01:10:44 +0000
Message-ID: <CAPnjgZ28HskiFDBDa=s_k6=WNoPfWu88bAaYCY7ew8dcYXW=aQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] rng: Provide a RNG based on the RISC-V Zkr ISA
 extension
To: Tom Rini <trini@konsulko.com>
Cc: Andre Przywara <andre.przywara@arm.com>, 
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Rick Chen <rick@andestech.com>, 
 Leo <ycliang@andestech.com>, Anup Patel <apatel@ventanamicro.com>, 
 Xiang W <merlew4n6@gmail.com>, Chanho Park <chanho61.park@samsung.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de, 
 Peter Hoyes <Peter.Hoyes@arm.com>, Alexey Romanov <avromanov@salutedevices.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

On Mon, 6 Nov 2023 at 13:46, Tom Rini <trini@konsulko.com> wrote:
>
> On Mon, Nov 06, 2023 at 01:38:39PM -0700, Simon Glass wrote:
> > Hi Andre,
> >
> > On Mon, 6 Nov 2023 at 10:26, Andre Przywara <andre.przywara@arm.com> wrote:
> > >
> > > On Sat, 4 Nov 2023 19:45:06 +0000
> > > Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Hi,
> > >
> > > > On Sat, 4 Nov 2023 at 17:13, Andre Przywara <andre.przywara@arm.com> wrote:
> > > > >
> > > > > On Fri, 3 Nov 2023 13:38:58 -0600
> > > > > Simon Glass <sjg@chromium.org> wrote:
> > > > >
> > > > > Hi Simon,
> > > > >
> > > > > > Hi Heinrich,
> > > > > >
> > > > > > On Wed, 1 Nov 2023 at 14:20, Heinrich Schuchardt
> > > > > > <heinrich.schuchardt@canonical.com> wrote:
> > > > > > >
> > > > > > > On 11/1/23 19:05, Andre Przywara wrote:
> > > > > > > > On Tue, 31 Oct 2023 14:55:50 +0200
> > > > > > > > Heinrich Schuchardt <heinrich.schuchardt@canonical.com> wrote:
> > > > > > > >
> > > > > > > > Hi Heinrich,
> > > > > > > >
> > > > > > > >> The Zkr ISA extension (ratified Nov 2021) introduced the seed CSR. It
> > > > > > > >> provides an interface to a physical entropy source.
> > > > > > > >>
> > > > > > > >> A RNG driver based on the seed CSR is provided. It depends on
> > > > > > > >> mseccfg.sseed being set in the SBI firmware.
> > > > > > > >
> > > > > > > > As you might have seen, I added a similar driver for the respective Arm
> > > > > > > > functionality:
> > > > > > > > https://lore.kernel.org/u-boot/20230830113230.3925868-1-andre.przywara@arm.com/
> > > > > > > >
> > > > > > > > And I see that you seem to use the same mechanism to probe and init the
> > > > > > > > driver: U_BOOT_DRVINFO and fail in probe() if the feature is not
> > > > > > > > implemented.
> > > > > > > > One downside of this approach is that the driver is always loaded (and
> > > > > > > > visible in the DM tree), even with the feature not being available.
> > > > > > > > That doesn't seem too much of a problem on the first glance, but it
> > > > > > > > occupies a device number, and any subsequent other DM_RNG devices
> > > > > > > > (like virtio-rng) typically get higher device numbers. So without
> > > > > > > > the feature, but with virtio-rng, I get:
> > > > > > > > VExpress64# rng 0
> > > > > > > > No RNG device
> > > > > >
> > > > > > Why do we get this? If the device is not there, the bind() function
> > > > > > can return -ENODEV
> > > > > >
> > > > > > I see this in U-Boot:
> > > > > >
> > > > > > U_BOOT_DRVINFO(cpu_arm_rndr) = {
> > > > > >
> > > > > > We should not use this.
> > > > >
> > > > > Agreed.
> > > > >
> > > > > > Use the devicetree.
> > > > >
> > > > > No, this is definitely not something for the DT, at least not on ARM.
> > > > > It's perfectly discoverable via the architected CPU ID registers.
> > > > > Similar to PCI and USB devices, which we don't probe via the DT as well.
> > > > >
> > > > > It's arguably not proper "driver" material per se, as I've argued before, but
> > > > > it's the simplest solution and fits in nicely otherwise.
> > > > >
> > > > > I was wondering if it might be something for UCLASS_CPU, something like
> > > > > a "CPU feature bus": to let devices register on one on the many CPU
> > > > > features (instead of compatible strings), then only bind() those
> > > > > drivers it the respective bit is set.
> > > > >
> > > > > Does that make sense? Would that be doable without boiling the ocean?
> > > > > As I don't know if we see many users apart from this.
> > > >
> > > > I have seen this so many times, where people want to avoid putting
> > > > things in the DT and then are surprised that everything is difficult,
> > > > broken and confusing. Why not just follow the rules? It is not just
> > > > about whether we can avoid it, etc. It is about how devices fit
> > > > together cohesively in the system, and how U-Boot operates.
> > >
> > > A devicetree is only for peripherals *that cannot be located by probing*.
> >
> > I have to stop you there. It absolutely is not limited to that.
>
> It is limited to that if we're going to keep using the device trees that
> Linux uses. Full stop. There's not really wiggle room there either.

That is really the problem, I agree.

But I would be happy with a u-boot.dtsi file to resolve this, while we
wait. I believe a binding makes sense in this case.

Regards,
Simon
