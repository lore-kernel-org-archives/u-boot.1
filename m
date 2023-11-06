Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95E4FC4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 17:25:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2309E87098;
	Mon,  6 Nov 2023 18:25:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="as1TRard";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F82D86FFA; Mon,  6 Nov 2023 18:25:32 +0100 (CET)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2DCE486F9A
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 18:25:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5431614d90eso7835604a12.1
 for <u-boot@lists.denx.de>; Mon, 06 Nov 2023 09:25:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699291520; x=1699896320; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MYpu3hniukptTdI+gE4Syqlg+Z7zlpttBMt1qLU6aZw=;
 b=as1TRardIV6Lap5LYav0hVXs0jXALgsLiHBzjvdaF+y90+EVQoAxNOq7wAe4c+sGsB
 Aqq54tW7/6+WooSODui3HpTnoAhW3LH378ThnurIFcQHPnuqTl9skb5+tbfhlTYNUDUw
 uc4Wr027q1J5FTiqfZyLqaT6bxNsfSXlcBXyU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699291520; x=1699896320;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MYpu3hniukptTdI+gE4Syqlg+Z7zlpttBMt1qLU6aZw=;
 b=ov3VhpxTV+IEDkU8la6YiFxADdrXd1V3voJjolAmPfiFawZJJeqQiLnW/LzpVVnxji
 M2hyLk2zuaj2kPIXIb692DfrqD7JESUApTM7MSQg7x6FJ+K2HSDJuQH6uWaZr1T97dZy
 pA5NhYCgjiFfdVBUJFoANo+YYw+nz52WB6jw+ulkX3Hem5U4ju07BkK/CRWCz+/wBH9K
 ZXg24KzApxAy9bmlVeAJv6IUcJG8vn3rKiftd2nLAv4ArSp16ikFl6WnW8Gc4au0267n
 q/AUFYwty3apM++vIGTEBjVi6KfpLWYXIj1JXWgxOcNJaMliKvAGAkCUmO+yuiKehuuN
 nP/Q==
X-Gm-Message-State: AOJu0Yz+srrWjnoRXA66ufAo3ulubiTENM0EIoQcKPsY8CipsxZJa5Od
 66yb4tfiVhLt1WOaU7F9EKQx/uUNjD8xc0vpzRclJQ==
X-Google-Smtp-Source: AGHT+IHodzjvbRfm7bj1bnawD5aewk1Q4Ytednncaqrzd1LV/0qBZcrnBv/Slr3tdanQjHttC43FwDuzmwFssyUBUGQ=
X-Received: by 2002:a50:aad8:0:b0:543:6444:ef2a with SMTP id
 r24-20020a50aad8000000b005436444ef2amr14148892edc.32.1699291520112; Mon, 06
 Nov 2023 09:25:20 -0800 (PST)
MIME-Version: 1.0
References: <20231031125552.26698-1-heinrich.schuchardt@canonical.com>
 <20231101170559.680ab493@donnerap.manchester.arm.com>
 <50ff2080-5831-4963-937d-331248b59973@canonical.com>
 <CAPnjgZ1gPRQiEq8=tVCtC6wznOWXX2bLaimSwd73=74oEWAXYQ@mail.gmail.com>
 <20231104171212.3d041a4f@slackpad.lan> <20231106164627.GA496310@bill-the-cat>
In-Reply-To: <20231106164627.GA496310@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 6 Nov 2023 10:24:54 -0700
Message-ID: <CAPnjgZ2yknNDqhnjdi5Jyo41mOxZqSwi7xKxu54TtWXMY8Q6Mg@mail.gmail.com>
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

On Mon, 6 Nov 2023 at 09:46, Tom Rini <trini@konsulko.com> wrote:
>
> On Sat, Nov 04, 2023 at 05:12:12PM +0000, Andre Przywara wrote:
> > On Fri, 3 Nov 2023 13:38:58 -0600
> > Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Simon,
> >
> > > Hi Heinrich,
> > >
> > > On Wed, 1 Nov 2023 at 14:20, Heinrich Schuchardt
> > > <heinrich.schuchardt@canonical.com> wrote:
> > > >
> > > > On 11/1/23 19:05, Andre Przywara wrote:
> > > > > On Tue, 31 Oct 2023 14:55:50 +0200
> > > > > Heinrich Schuchardt <heinrich.schuchardt@canonical.com> wrote:
> > > > >
> > > > > Hi Heinrich,
> > > > >
> > > > >> The Zkr ISA extension (ratified Nov 2021) introduced the seed CSR. It
> > > > >> provides an interface to a physical entropy source.
> > > > >>
> > > > >> A RNG driver based on the seed CSR is provided. It depends on
> > > > >> mseccfg.sseed being set in the SBI firmware.
> > > > >
> > > > > As you might have seen, I added a similar driver for the respective Arm
> > > > > functionality:
> > > > > https://lore.kernel.org/u-boot/20230830113230.3925868-1-andre.przywara@arm.com/
> > > > >
> > > > > And I see that you seem to use the same mechanism to probe and init the
> > > > > driver: U_BOOT_DRVINFO and fail in probe() if the feature is not
> > > > > implemented.
> > > > > One downside of this approach is that the driver is always loaded (and
> > > > > visible in the DM tree), even with the feature not being available.
> > > > > That doesn't seem too much of a problem on the first glance, but it
> > > > > occupies a device number, and any subsequent other DM_RNG devices
> > > > > (like virtio-rng) typically get higher device numbers. So without
> > > > > the feature, but with virtio-rng, I get:
> > > > > VExpress64# rng 0
> > > > > No RNG device
> > >
> > > Why do we get this? If the device is not there, the bind() function
> > > can return -ENODEV
> > >
> > > I see this in U-Boot:
> > >
> > > U_BOOT_DRVINFO(cpu_arm_rndr) = {
> > >
> > > We should not use this.
> >
> > Agreed.
> >
> > > Use the devicetree.
> >
> > No, this is definitely not something for the DT, at least not on ARM.
> > It's perfectly discoverable via the architected CPU ID registers.
> > Similar to PCI and USB devices, which we don't probe via the DT as well.
> >
> > It's arguably not proper "driver" material per se, as I've argued before, but
> > it's the simplest solution and fits in nicely otherwise.
> >
> > I was wondering if it might be something for UCLASS_CPU, something like
> > a "CPU feature bus": to let devices register on one on the many CPU
> > features (instead of compatible strings), then only bind() those
> > drivers it the respective bit is set.
> >
> > Does that make sense? Would that be doable without boiling the ocean?
> > As I don't know if we see many users apart from this.
>
> I think we have a similar problem with how we're doing with DM_TIMER and
> armv7-a/armv7-m/armv8[1]. We shouldn't need the drivers in drivers/timer/
> to cover platforms where SYS_ARCH_TIMER is (or should be!) enabled. But
> in turn, the code under arch/arm/cpu/*/*timer.c doesn't implement the
> uclass side of things, only the regular API. This is because there's
> nothing to probe even because we don't support the kind of multi-arch
> binary where it'd be possible to not have the feature.

The difference here is that there is only one timer device, at least
in hardware I have used.

I am leaning towards NAKing this and any future use of
U_BOOT_DRVINFO(), in favour of a proper DT binding. It's time we
stopped making this so hard. I'll reply on the other thread.

Regards,
Simon



>
> --
> Tom
>
> [1]: We do have the problem of armv7-r not having this feature so things
> like say TI K3 platforms need the platform driver on the Cortex-R host.
> A similar issue is the pre-ARMv7 i.MX platforms.
