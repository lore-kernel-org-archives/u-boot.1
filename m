Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F28D7CCF9E9
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 11:26:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6132A88D35;
	Thu, 26 Sep 2024 13:26:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="BOXujEWM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B20E488D38; Thu, 26 Sep 2024 13:26:16 +0200 (CEST)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7894588CD9
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 13:26:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-20551eeba95so7831245ad.2
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 04:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727349972; x=1727954772; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=PVSZBlMxSgXlgs5+6EtOPSeqmKIr+hD2G22dZJi5CSY=;
 b=BOXujEWM/R9DlEVRa7TclUyuG7/SOZUpbNKZJPjXGr3ImVRt/VUzEWFC/xY5gHf1HG
 uFbwaa8a/3o+azuHHQbiNYmpTmbhNb9K00kKYQThp7ed2CRg0OxcojSenvC3chcTQKfB
 nds0HUbOiy0x/FGTU01RcSOYqBHc7OOBsN/+5A1urM8Y3APYPHJF5UBQIp/7bgkacq6/
 wDPdTycydT9yBaj888ksv36buf8Q0X3dDeXLIJcS2OdTYZhYr8mQkB0aJbUIYm1QF1mz
 OAsxnpG83HTanWsosRSR+ZZ+5kjEQnZV+0x7xqxzZ6wp2Zx00oKYz9nc8dJVJJFnBBT+
 qpSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727349972; x=1727954772;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PVSZBlMxSgXlgs5+6EtOPSeqmKIr+hD2G22dZJi5CSY=;
 b=lgCu15iNnHL08XjNyf8GP6D0AiqGUcGDosF4UPzbKBm7Ej7w+hTXO1mMkeUaQKF3op
 YxevWK4szshBlPB8Dms1DlecKzt/AMvC3Tq8OzPbTrMINhQoj630E37d3xPfKO41C+R7
 Vobbqiju1SSpezoxL5QG5ZG072xR6U7QZPGDilG1FE2eNO6l9kfTvePvaoivdYWT+qOQ
 +jaCe5vNki0ENreEsqzQpYfZ0gYgeyT9duxqTqxAfdWByfn5aWivo5dSV208cBvF4Sj4
 +GQroV1hBdj00xViGnfiU3U7G6XQxceDgjgY2vuwsucPAfoLTWCBkoi1EOV+Wg40s3Df
 OiWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfc0vzEC/uxK2/ww9DlzPHt21ntDLBRCS43AVGwAD0wH90TZ3J4jX1EsTmQA5jnsRoPu6uQMo=@lists.denx.de
X-Gm-Message-State: AOJu0YyTW6p7KhhmKMfHm4uRVMMTkCkwc7oknUt8kJfbqTxSvxzRNDko
 cdGBev62j2bP84kRuBpLnnr5zfduEBWLmSRItIwu1KAMyLNDk2gBXRM+DujVt/aJEyxvfL6wFLb
 y7AKeEK/nXFdmYUFd8VszZAMz0hq1GMHWiVbnEA==
X-Google-Smtp-Source: AGHT+IHGBXiLzLZhm8sNXBt/fuSsairRpo5MykRU2jY1lFXbj+2PxZGip+iNGMWy4pWpkJ7JERC+8dBKIS50kCCsipg=
X-Received: by 2002:a17:902:f687:b0:203:a14d:ed0 with SMTP id
 d9443c01a7336-20afc40d663mr89744955ad.11.1727349971906; Thu, 26 Sep 2024
 04:26:11 -0700 (PDT)
MIME-Version: 1.0
References: <20240918152136.3395170-1-patrick.rudolph@9elements.com>
 <20240918152136.3395170-15-patrick.rudolph@9elements.com>
 <CAFLszTimAFGocvqbnT=JVsA2bjNa=ZfxP6Sy46a9e6VkhtdojQ@mail.gmail.com>
 <CAC_iWjLASm6U8kC68MJ0uZ14MGFS_SSL3Pcd8hcEH=a=W8gvBQ@mail.gmail.com>
 <CAFLszTgYHO7FgbCgfRwqT_yj4KBm31xKdEUrn0pZkhtLzOh=HQ@mail.gmail.com>
 <CAC_iWjKv+Z4K5xPW6MZhBZ67-rDy9iRVaoqfLKmJRwSG9nKnfA@mail.gmail.com>
 <CAFLszThA5eOM_xiMgDu=B4wAcP7wV9bzfc565rES8z6d1F8fjg@mail.gmail.com>
 <CAC_iWjLqmN0uA85RayC2hnMOJfCqumCpiq=waQwakd6ECfbXkg@mail.gmail.com>
 <CAFLszTgaVdgPNSC+vxZoH7ko5n_d6F_QnGfgL-biZ19edaUxQQ@mail.gmail.com>
In-Reply-To: <CAFLszTgaVdgPNSC+vxZoH7ko5n_d6F_QnGfgL-biZ19edaUxQQ@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 26 Sep 2024 14:25:34 +0300
Message-ID: <CAC_iWj+a+HCBr7A1HCcntZW7rvriTm1PvgVDcpbWCjBdRb7NzA@mail.gmail.com>
Subject: Re: [PATCH v4 14/35] efi_loader: Allocate and write ACPI tables
To: Simon Glass <sjg@chromium.org>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>, u-boot@lists.denx.de, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>
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

Hi Simon,

On Fri, 20 Sept 2024 at 19:01, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Ilias,
>
> On Fri, 20 Sept 2024 at 08:36, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > Hi Simon,
> >
> > On Thu, 19 Sept 2024 at 18:36, Simon Glass <sjg@chromium.org> wrote:
> > >
> > > Hi Ilias,
> > >
> > > On Thu, 19 Sept 2024 at 17:20, Ilias Apalodimas
> > > <ilias.apalodimas@linaro.org> wrote:
> > > >
> > > > Hi Simon,
> > > >
> > > > On Thu, 19 Sept 2024 at 18:00, Simon Glass <sjg@chromium.org> wrote:
> > > > >
> > > > > Hi Ilias,
> > > > >
> > > >
> > > > [...]
> > > >
> > > > > > > > +
> > > > > > > > +               if (!addr)
> > > > > > > > +                       return log_msg_ret("mem", -ENOMEM);
> > > > > > > > +       } else {
> > > > > > > > +               pages = efi_size_in_pages(TABLE_SIZE);
> > > > > > > > +
> > > > > > > > +               ret = efi_allocate_pages(EFI_ALLOCATE_ANY_PAGES,
> > > > > > > > +                                        EFI_ACPI_RECLAIM_MEMORY,
> > > > > > > > +                                        pages, &new_acpi_addr);
> > > > > > > > +               if (ret != EFI_SUCCESS)
> > > > > > > > +                       return log_msg_ret("mem", -ENOMEM);
> > > > > > > > +
> > > > > > > > +               addr = (void *)(uintptr_t)new_acpi_addr;
> > > > > > > > +       }
> > > > > > > > +
> > > > > > >
> > > > > > > The tables should be written regardless of whether EFI_LOADER is enabled.
> > > > > >
> > > > > > *Why*? How do you expect to hand them over to the OS?
> > > > >
> > > > > Why - because boards which need ACPI tables to boot should generate
> > > > > them;
> > > >
> > > > Noone argued that.
> > > >
> > > > > also this happens when U-Boot starts up, in last_stage_init()
> > > > > How - it isn't possible, but eventually I suppose it will be, once we
> > > > > have a use case for booting with ACPI but without EFI
> > > >
> > > > Are you aware of such an OS? If not, we can accept the patches when we
> > > > have a reason.
> > >
> > > Which patches? This is how it works today. We set up the tables in
> > > last_stage_init(), so they can be examined while in U-Boot.
> >
> > What I mean, is that until we have a valid use case to store the ACPI
> > in a bloblist, I prefer them being allocated with proper EFI memory
> > backing
>
> I'm going to assert prior art here. If ARM is to have ACPI in U-Boot,
> it should follow the most recent x86 approach and store it in the
> bloblist. That is what the blloblist is for. It also avoids using
> memory below the U-Boot area, which is not allowed.

By prior art you mean [0], which was none of the EFI maintainers got involved?

>
> >
> > >
> > > It is the patches to change this which I object to.
> > >
> > > > I remember patches being hard NAK'ed on using DTs to pass the ACPI
> > > > table address in the past.
> > >
> > > Yes, I believe Bytedance carries a patch locally for that :-)
> >
> > Exactly
> >
> > >
> > > >
> > > > >
> > > > > >
> > > > > > >
> > > > > > > Can we drop this else clause? We should always use the bloblist.
> > > > > >
> > > > > > Both Heinrich and I said the exact opposite. Unless there's a
> > > > > > perfectly good reason why we should keep them in bloblist memory, I'd
> > > > > > like us to do that
> > > > >
> > > > > The main reason is that we should not be putting things in memory
> > > > > between the start of RAM and the bottom of the U-Boot area. That
> > > > > region of memory is supposed to be for loading images. Most boards
> > > > > hard-code the image-load addresses in environment variables. But even
> > > > > if they didn't, we should not be using that memory for U-Boot data.
> > > >
> > > > EFI allows you to request a specific address to use. We can choose one
> > > > that fits the requirements
> > >
> > > So long as it is in U-Boot's space, that is fine. I just sent a patch
> > > about relocation which covers this. It occured to me that this feature
> > > of U-Boot, which I have always assumed was common knowledge, may have
> > > not been noticed.
> > >
> > > > >
> > > > > Another reason is that the bloblist is designed for this, for keeping
> > > > > tables in a small, contiguous area of memory, so that when passed to
> > > > > Linux they are not spread all over the place.
> > > >
> > > > Linux does not and will not read tables from a bloblist though
> > >
> > > Indeed. There really isn't any point, anyway, since there are other
> > > ways of passing the tables along...except for ACPI with FDT but that
> > > isn't a valid use case for Linux so far.
> >
> > What we are trying to do with EFI is to stay as close to the spec and
> > the current OS implementations as possible. So again, please allocate
> > EFI memory for the ACPI tables. The patches to convert it to bloblist
> > allocating them are minimal, so we can do it, once there's an actuall
> > need for it.
>
> As it stands today, efi_acpi_register() does not do an EFI allocation,
> it just adds the existing allocation to the EFI tables. This works
> fine for x86 - see arch/x86/lib/tables.c -

Yes and I've already mentioned that in my original response.

> so I would like ARM to do
> the same. The need for it is (as above) that we should ensure that
> memory usage is within the U-Boot area. This is something which
> bloblist handles automatically. It is also nice to see all the tables
> in one place with 'bloblist list'

Unless bloblist is not compiled.... in which case you still need to
malloc and align.
I am just putting this out there, because your next email is going to
be "oh look bloblist is mandatory now".
For the last time, bloblist make zero sense to allocate data that
arent going to be handed across loaders.

Patrick, my suggestion is to either use efi_allocate_pages() as you do
or malloc a properly aligned buffer since we set the memory type in
efi_acpi_register().
IIRC the reason we set that in efi_acpi_register() is for QEMU which
hands us over ACPI tables, so we can't do much. I would personally
prefer efi allocated memory.

Thanks
/Ilias


>
> Regards,
> Simon

[0] https://lore.kernel.org/u-boot/20201104165743.632571-11-sjg@chromium.org/
