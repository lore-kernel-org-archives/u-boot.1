Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 668F5C2BB3F
	for <u-boot@archiver.kernel.org>; Thu, 16 Nov 2023 01:43:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 783D28745B;
	Thu, 16 Nov 2023 02:43:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TY6ifgpW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D2B5180422; Thu, 16 Nov 2023 02:42:42 +0100 (CET)
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com
 [IPv6:2607:f8b0:4864:20::112d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 52B9B8729D
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 02:42:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-5be6d6c04bfso2817117b3.3
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 17:42:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700098946; x=1700703746; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4GxHMTUOuAfUw+lk1aCDtroTUrAMSwG79dynbIa4QdQ=;
 b=TY6ifgpW6sZB4WSYqv9hG/csdCvgfqeQprgruzEEUZdj6mOnaYHpKV6rTpkDpatnbs
 rfzkYFzuW9CX51ey+qP3V7HthcqirKLeDpKz2GAy7ncM+mc2DeHCsFZRNMd8INJ5I/+u
 tYVVu1Zj/UckTIbm6sKgIy4nANojvp+Ul3uhc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700098946; x=1700703746;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4GxHMTUOuAfUw+lk1aCDtroTUrAMSwG79dynbIa4QdQ=;
 b=dKdp54VA9qy6uKsUQcgWRt3h6oYMuE7V119o45MymfoBVf7Bis1a/eA4szNeoovaUz
 NcxbPAeVAHU41/9TQhMuRAkzYHUZE2sR4aeRP9+dEgzFTJxP/tz9dgfMEx8hkKpw1syW
 RfOMdemhREObmEvfiVUFoFCvhciJS4h5cNWMTjispXW+AiIkQVculo6D1jHFzQuL0rP4
 I9NRbTA05xQk3tiEaAVrglcJtp2d0PWxticPtgqw6Xmo+Zo3WmSqTqWhsKe5ijtn9acU
 Jrch20zkaJzMkp5D/AzNxELUmdFvQm19p3y6gxs+tjbe2rkzMOcyA/9KyUgGue7MGLp2
 wFIQ==
X-Gm-Message-State: AOJu0Yw+dkdDPrZNt0VHU5JMwO+MbBt0tDRV70NMDqIJrizlD+7uyjKx
 XqLiiOVKE8lFhtJV/cYfowX5gxbJrwxwdOp5Ne86H1yqgjSvguXrKp8=
X-Google-Smtp-Source: AGHT+IEwKEaMl9WleDiGi2mA/OhcBTsm6flJp/mLHjhR9bw+PY8+gBMoBM4eFlLxVHda0E/D79MtLy6wcGErM9aHJCI=
X-Received: by 2002:a81:844f:0:b0:5be:94a6:d84a with SMTP id
 u76-20020a81844f000000b005be94a6d84amr13279047ywf.20.1700098946115; Wed, 15
 Nov 2023 17:42:26 -0800 (PST)
MIME-Version: 1.0
References: <20231112200255.172351-1-sjg@chromium.org>
 <20231112130245.v4.5.If206027372f73ce32480223e5626f4b944e281b7@changeid>
 <3F7DFCBC-D5A1-43C4-AF00-11C27BFF7508@gmx.de>
 <CAPnjgZ3wEzHNqzpsF1zU6U4WBAm=oMYEzRRR-UuqDEwXB24rLw@mail.gmail.com>
 <43EF5E14-0AE3-456A-B9D4-67B8F4405555@gmx.de>
 <CAPnjgZ2t-wF=nGWtdEgWRtUrzFyERnoGwqF8urJjNgEP2b4Qrw@mail.gmail.com>
 <58076384-d164-4d7a-bc1f-c78574b481b5@gmx.de>
 <487c3e73-ce21-4e45-9cf3-44314e78fd1f@gmx.de>
In-Reply-To: <487c3e73-ce21-4e45-9cf3-44314e78fd1f@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 15 Nov 2023 18:42:12 -0700
Message-ID: <CAPnjgZ1-DBbt7caZRwvEWO+OcCZtJ821ZkVr--NPZGg1wE1R=Q@mail.gmail.com>
Subject: Re: [PATCH v4 05/12] usb: Avoid unbinding devices in use by bootflows
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Eddie James <eajames@linux.ibm.com>, 
 Fabrice Gasnier <fabrice.gasnier@foss.st.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Marek Vasut <marex@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Safae Ouajih <souajih@baylibre.com>, Shantur Rathore <i@shantur.com>
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

Hi Heinrich,

On Wed, 15 Nov 2023 at 18:34, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 11/15/23 17:23, Heinrich Schuchardt wrote:
> > On 11/15/23 16:50, Simon Glass wrote:
> >> Hi Heinrich,
> >>
> >> On Sun, 12 Nov 2023 at 16:35, Heinrich Schuchardt <xypron.glpk@gmx.de>
> >> wrote:
> >>>
> >>>
> >>>
> >>> Am 12. November 2023 22:20:50 MEZ schrieb Simon Glass
> >>> <sjg@chromium.org>:
> >>>> Hi Heinrich,
> >>>>
> >>>> On Sun, 12 Nov 2023 at 13:32, Heinrich Schuchardt
> >>>> <xypron.glpk@gmx.de> wrote:
> >>>>>
> >>>>>
> >>>>>
> >>>>> Am 12. November 2023 21:02:42 MEZ schrieb Simon Glass
> >>>>> <sjg@chromium.org>:
> >>>>>> When a USB device is unbound, it causes any bootflows attached to
> >>>>>> it to
> >>>>>> be removed, via a call to bootdev_clear_bootflows() from
> >>>>>> bootdev_pre_unbind(). This obviously makes it impossible to boot the
> >>>>>> bootflow.
> >>>>>>
> >>>>>> However, when booting a bootflow that relies on USB, usb_stop() is
> >>>>>> called, which unbinds the device. For EFI, this happens in
> >>>>>> efi_exit_boot_services() which means that the bootflow disappears
> >>>>>> before it is finished with.
> >>>>>
> >>>>> After ExitBootServices() no driver of U-Boot can be used as the
> >>>>> operating system is in charge.
> >>>>>
> >>>>> Any bootflow inside U-Boot is terminated by definition when
> >>>>> reaching ExitBootServices.
> >>>>>
> >>>>>>
> >>>>>> There is no need to unbind all the USB devices just to quiesce them.
> >>>>>> Add a new usb_pause() call which removes them but leaves them bound.
> >>>>>
> >>>>> As U-Boot must not access any device after ExitBootServices() it is
> >>>>> unclear to me what you want to achieve.
> >>>>
> >>>> I can't remember exactly what is needed from the bootflow, but
> >>>> something is. Perhaps the kernel, or the cmdline, or fdt? It would
> >>>> have been better if I had mentioned this explicitly,  But then this
> >>>> patch has been sitting around for ages...
> >>>>
> >>>> In any case, the intent of exit-boot-services is not to free all the
> >>>> memory used, since some of it may have been used to hold data that the
> >>>> app continues to use.
> >>>
> >>> The EFI application reads the memory map and receives an ID which it
> >>> passes to ExitBootServiced() after this point any memory not marked
> >>> as EFI runtime can be used by the EFI app. This includes the memory
> >>> that harbors the U-Boot USB drivers. Therefore no drivers can be used
> >>> here.
> >>>
> >>> Starting the EFI app via StartImage() must  terminate any running
> >>> U-Boot "boot flow".
> >>>
> >>> After ExitBootServices() the EFI application cannot return to U-Boot
> >>> except for SetVirtualAdressMspsetting which relocates the EFI runtime.
> >>>
> >>> Bootflows and U-Boot drivers have no meaning after ExitBootServices().
> >>>
> >>>
> >>>
> >>>>
> >>>> Also there is U-Boot code between when the devices are unbound and
> >>>> when U-Boot actually exits back to the app.
> >>>>
> >>>> This hang was 100% repeatable on brya (an x86 Chromebook) and it took
> >>>> quite a while to find.
> >>>
> >>> We need a better understanding of the problem that you experience to
> >>> find an adequate solution. Why does removing all devices lead to
> >>> hanging the system?
> >>
> >> Are you able to test this? With your better knowledge of EFI you might
> >> be able to figure out something else that is going on. But in my case
> >> it causes some memory to be freed (perhaps the memory holding the EFI
> >> app?), which is then overwritten by something else being malloc()'d,
> >
> > The memory for the EFI app is not assigned via malloc(). It is allocated
> > by AllocatedPages().
> >
> > Reading "some memory freed" does not give me confidence that the problem
> > is sufficiently analyzed.
> >
> >> so the boot hangs. It is hard to see what is going on after the app
> >> starts.
> >>
> >> This patch was sent almost two months ago and fixes a real bug. The
> >> first few versions attracted no comment now it is being blocked
> >> because you don't understand how it fixes anything.
> >
> > Do you understand why unbinding the devices causes the problem?
> >
> >>
> >> I can get the hardware up again and try this but it will take a while.
> >
> > Digging a bit deeper seems to be the right approach.
>
> Re: bug - bootflow: grub efi crashes when bootflow selected explicitly
> https://lore.kernel.org/u-boot/CAHc5_t1H39YV=HSSa7TCEdzRctAX+zibkx1vsuwEW-raOL9TcA@mail.gmail.com/
>
> points to a probable root cause:
>
> https://github.com/u-boot/u-boot/blob/master/boot/bootflow.c#L470
> free(bflow->buf)
>
> In the EFI boot bflow->buf points to $kernel_addr_r which never was
> allocated and therefore must not be freed.

Yes, this is the root cause of the crash.

However, this patch should still be applied. I can update the commit
message if you like.

Freeing the FDT and kernel before booting them is just not safe,
whether EFI or anything else. Freed memory is not guaranteed to hang
around for any length of time. For example, with truetype fonts,
malloc() is called during any console output and will likely corrupt
the images just as they are being booted.

We should leave the devices bound when booting.

Regards,
Simon
