Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1E8CC072A2
	for <u-boot@archiver.kernel.org>; Thu, 16 Nov 2023 02:35:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2396C87285;
	Thu, 16 Nov 2023 03:35:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="T9a/qL3U";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2451786F85; Thu, 16 Nov 2023 03:35:49 +0100 (CET)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45EFC87447
 for <u-boot@lists.denx.de>; Thu, 16 Nov 2023 03:35:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-9d0b4dfd60dso42226566b.1
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 18:35:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700102145; x=1700706945; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jpg9h8NTFDwFIe/LDwiXqsLXfzVcYwzpFkQ9HjPTx/8=;
 b=T9a/qL3UfYjOTTMSZAzWOZRu4Ybx0aanPOWJIIhUeaOufMx38l0zzo0tRZOau+TXsH
 HI31pT4zjZ/jUDQH8RNX5++lHoejpj+vs+J+csH8OhXU8+L5mNf7pPYzO4JijjVzw4Us
 mVrrY6Q3dmwTzMlcXFxIVp09uPb6hwJWrdXKE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700102145; x=1700706945;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jpg9h8NTFDwFIe/LDwiXqsLXfzVcYwzpFkQ9HjPTx/8=;
 b=klhB43eLFjfJe4M/EcdJ4nTx7nN4bncePSCszfNt731boj2RD0ACp4ck5C1wSGlw1/
 hoct9M/BVAcs5g17mJ9TzuVxTZJvYaNdht77YCm4pHIBa0FdErUVUJJPU/hzZjpQFZQg
 ICOd4jrq4iDQh9vnKhL2oNnGjpaxG7TNmx9jQpBKzocpQ/7vRVmKswf8swFNgqsNuIUA
 Z/UapCpWoGsUtNx1aeJwXt0nMFMLOJ1ww7b7F6CWq5sEfqnmlIr6nA5vMW/t8GVtAOTJ
 AolEZ/HF2B72OvZv7iEb52qWdS1PaSVB539iV9KSBNKgbOLaI/ZvfO4WKRI+NQFkIQx6
 6eNw==
X-Gm-Message-State: AOJu0Yw2zsa5myQpz0BWj02fhFnqjwEcC5CNSRHI/qaxkkektaePkPip
 kcvBfm8PXgvJVtx2cMRJ11ljd4HnD8V6qlKIyfIG1g==
X-Google-Smtp-Source: AGHT+IGllDTWS1bwVAFIjG6qTlWlhGGk96l5UkdJz6v/ujxAz5BDrRbutcTgfBU358qEhsco5VnpKOShJn4STnWHqr4=
X-Received: by 2002:a17:907:6d07:b0:9e8:de5e:911a with SMTP id
 sa7-20020a1709076d0700b009e8de5e911amr11669548ejc.73.1700102144609; Wed, 15
 Nov 2023 18:35:44 -0800 (PST)
MIME-Version: 1.0
References: <20231112200255.172351-1-sjg@chromium.org>
 <20231112130245.v4.5.If206027372f73ce32480223e5626f4b944e281b7@changeid>
 <3F7DFCBC-D5A1-43C4-AF00-11C27BFF7508@gmx.de>
 <CAPnjgZ3wEzHNqzpsF1zU6U4WBAm=oMYEzRRR-UuqDEwXB24rLw@mail.gmail.com>
 <43EF5E14-0AE3-456A-B9D4-67B8F4405555@gmx.de>
 <CAPnjgZ2t-wF=nGWtdEgWRtUrzFyERnoGwqF8urJjNgEP2b4Qrw@mail.gmail.com>
 <58076384-d164-4d7a-bc1f-c78574b481b5@gmx.de>
 <487c3e73-ce21-4e45-9cf3-44314e78fd1f@gmx.de>
 <CAPnjgZ1-DBbt7caZRwvEWO+OcCZtJ821ZkVr--NPZGg1wE1R=Q@mail.gmail.com>
 <f3b89670-8e6b-428a-b391-a1d70b2af30f@gmx.de>
In-Reply-To: <f3b89670-8e6b-428a-b391-a1d70b2af30f@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 15 Nov 2023 19:35:33 -0700
Message-ID: <CAPnjgZ3z=CUoCqWw-7QSAJ9UoFso+ZngdXSTP7w4sOkPTba2CQ@mail.gmail.com>
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

On Wed, 15 Nov 2023 at 19:06, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 11/16/23 02:42, Simon Glass wrote:
> > Hi Heinrich,
> >
> > On Wed, 15 Nov 2023 at 18:34, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> >>
> >> On 11/15/23 17:23, Heinrich Schuchardt wrote:
> >>> On 11/15/23 16:50, Simon Glass wrote:
> >>>> Hi Heinrich,
> >>>>
> >>>> On Sun, 12 Nov 2023 at 16:35, Heinrich Schuchardt <xypron.glpk@gmx.de>
> >>>> wrote:
> >>>>>
> >>>>>
> >>>>>
> >>>>> Am 12. November 2023 22:20:50 MEZ schrieb Simon Glass
> >>>>> <sjg@chromium.org>:
> >>>>>> Hi Heinrich,
> >>>>>>
> >>>>>> On Sun, 12 Nov 2023 at 13:32, Heinrich Schuchardt
> >>>>>> <xypron.glpk@gmx.de> wrote:
> >>>>>>>
> >>>>>>>
> >>>>>>>
> >>>>>>> Am 12. November 2023 21:02:42 MEZ schrieb Simon Glass
> >>>>>>> <sjg@chromium.org>:
> >>>>>>>> When a USB device is unbound, it causes any bootflows attached to
> >>>>>>>> it to
> >>>>>>>> be removed, via a call to bootdev_clear_bootflows() from
> >>>>>>>> bootdev_pre_unbind(). This obviously makes it impossible to boot the
> >>>>>>>> bootflow.
> >>>>>>>>
> >>>>>>>> However, when booting a bootflow that relies on USB, usb_stop() is
> >>>>>>>> called, which unbinds the device. For EFI, this happens in
> >>>>>>>> efi_exit_boot_services() which means that the bootflow disappears
> >>>>>>>> before it is finished with.
> >>>>>>>
> >>>>>>> After ExitBootServices() no driver of U-Boot can be used as the
> >>>>>>> operating system is in charge.
> >>>>>>>
> >>>>>>> Any bootflow inside U-Boot is terminated by definition when
> >>>>>>> reaching ExitBootServices.
> >>>>>>>
> >>>>>>>>
> >>>>>>>> There is no need to unbind all the USB devices just to quiesce them.
> >>>>>>>> Add a new usb_pause() call which removes them but leaves them bound.
> >>>>>>>
> >>>>>>> As U-Boot must not access any device after ExitBootServices() it is
> >>>>>>> unclear to me what you want to achieve.
> >>>>>>
> >>>>>> I can't remember exactly what is needed from the bootflow, but
> >>>>>> something is. Perhaps the kernel, or the cmdline, or fdt? It would
> >>>>>> have been better if I had mentioned this explicitly,  But then this
> >>>>>> patch has been sitting around for ages...
> >>>>>>
> >>>>>> In any case, the intent of exit-boot-services is not to free all the
> >>>>>> memory used, since some of it may have been used to hold data that the
> >>>>>> app continues to use.
> >>>>>
> >>>>> The EFI application reads the memory map and receives an ID which it
> >>>>> passes to ExitBootServiced() after this point any memory not marked
> >>>>> as EFI runtime can be used by the EFI app. This includes the memory
> >>>>> that harbors the U-Boot USB drivers. Therefore no drivers can be used
> >>>>> here.
> >>>>>
> >>>>> Starting the EFI app via StartImage() must  terminate any running
> >>>>> U-Boot "boot flow".
> >>>>>
> >>>>> After ExitBootServices() the EFI application cannot return to U-Boot
> >>>>> except for SetVirtualAdressMspsetting which relocates the EFI runtime.
> >>>>>
> >>>>> Bootflows and U-Boot drivers have no meaning after ExitBootServices().
> >>>>>
> >>>>>
> >>>>>
> >>>>>>
> >>>>>> Also there is U-Boot code between when the devices are unbound and
> >>>>>> when U-Boot actually exits back to the app.
> >>>>>>
> >>>>>> This hang was 100% repeatable on brya (an x86 Chromebook) and it took
> >>>>>> quite a while to find.
> >>>>>
> >>>>> We need a better understanding of the problem that you experience to
> >>>>> find an adequate solution. Why does removing all devices lead to
> >>>>> hanging the system?
> >>>>
> >>>> Are you able to test this? With your better knowledge of EFI you might
> >>>> be able to figure out something else that is going on. But in my case
> >>>> it causes some memory to be freed (perhaps the memory holding the EFI
> >>>> app?), which is then overwritten by something else being malloc()'d,
> >>>
> >>> The memory for the EFI app is not assigned via malloc(). It is allocated
> >>> by AllocatedPages().
> >>>
> >>> Reading "some memory freed" does not give me confidence that the problem
> >>> is sufficiently analyzed.
> >>>
> >>>> so the boot hangs. It is hard to see what is going on after the app
> >>>> starts.
> >>>>
> >>>> This patch was sent almost two months ago and fixes a real bug. The
> >>>> first few versions attracted no comment now it is being blocked
> >>>> because you don't understand how it fixes anything.
> >>>
> >>> Do you understand why unbinding the devices causes the problem?
> >>>
> >>>>
> >>>> I can get the hardware up again and try this but it will take a while.
> >>>
> >>> Digging a bit deeper seems to be the right approach.
> >>
> >> Re: bug - bootflow: grub efi crashes when bootflow selected explicitly
> >> https://lore.kernel.org/u-boot/CAHc5_t1H39YV=HSSa7TCEdzRctAX+zibkx1vsuwEW-raOL9TcA@mail.gmail.com/
> >>
> >> points to a probable root cause:
> >>
> >> https://github.com/u-boot/u-boot/blob/master/boot/bootflow.c#L470
> >> free(bflow->buf)
> >>
> >> In the EFI boot bflow->buf points to $kernel_addr_r which never was
> >> allocated and therefore must not be freed.
> >
> > Yes, this is the root cause of the crash.
> >
> > However, this patch should still be applied. I can update the commit
> > message if you like.
> >
> > Freeing the FDT and kernel before booting them is just not safe,
> > whether EFI or anything else. Freed memory is not guaranteed to hang
> > around for any length of time. For example, with truetype fonts,
> > malloc() is called during any console output and will likely corrupt
> > the images just as they are being booted.
>
> Please, observe that malloc() and efi_allocate_pages() use completely
> separate parts of the memory.
>
> When reaching ExitBootServices() the memory used by the EFI binary
> (relocated in efi_load_pe()) and for the configuration table with the
> device-tree have been allocated by efi_allocate_pages(). These addresses
> cannot neither allocated by malloc() nor freed with free().

OK...

To my reading, efi_load_pe() pulls the image apart into memory
allocated with efi_allocate_pages(). So that is separate memory? In
any case, it would end up in a 'struct bootflow'.

IMO the EFI memory-allocation functions should be called only when
booting, not before. I do worry about leakage...

[..]

Regards,
Simon
