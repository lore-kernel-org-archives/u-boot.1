Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FB41CDB483
	for <u-boot@archiver.kernel.org>; Thu, 19 Oct 2023 08:24:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C2FD871BA;
	Thu, 19 Oct 2023 10:24:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="rxqPu3gg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 42C5F871C0; Thu, 19 Oct 2023 10:24:38 +0200 (CEST)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com
 [IPv6:2607:f8b0:4864:20::1031])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9EA3A871B7
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 10:24:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-27d0acd0903so5036739a91.1
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 01:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697703871; x=1698308671; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Tvgqd3QABZCmQWO1qLlITLp4URQ1qtCvo7E7FbVqMEI=;
 b=rxqPu3ggVbWNdbK8wGauqIAVIsZDq2XPEAemY/6dgOXVnXoMls5+Ki/WvPZEcBXZtT
 Vz9gFV4RR+TFz29UiBMooZjkVSbmNJIpjqIuIbIiUV3UF3X4eiK6Xp4VL4bFXWSZqa7t
 NQr90yr85zlfumDgUefIzjLIhVmcYS0jUcuU61Fevy/2wIj41gvVevg8IJlL4GmAZCha
 qskDdErsDLTQmRqDNcGiHrz/NMynrXdsJX+kKtCDti6QO2zj0GnCoQFlV+QU9J/lpoPL
 EMsH4EkYeORKXl6MxPM94hd0Apvd/ODjWIu40gxt6x+UG/kkgO3YkX3srhPTM7KAcXzO
 Mh3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697703871; x=1698308671;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Tvgqd3QABZCmQWO1qLlITLp4URQ1qtCvo7E7FbVqMEI=;
 b=KD0xpdd1j2GuZ8s1jXfwDhQY2MihYi6zTzkjrGefWVxh7wnS5x1efQBR4CO9IqaPun
 oK3nBbCxUh0vz2qTPvIRyHJRc212X37wDUSjKOufQYwAUPIgCnJZ0uKhISG9+YGrPR2I
 iUBfJk5tcsXAG1qyEJZb4BKY/Ra1S4hZVmbznoLcCNi9WYJnzweGnsgAN0P2x33qODMQ
 rB9Tg38Bpa8hGMQ6ov+43uwW3bTvGp2Z/L94YTZTUhsQVDqkN21aHojby44HeMYhBVr3
 MNKcfjI+Ze0PQLWrkI5w8fMaaOO41GhO9/ZWsqJ+Gm4gWEkrVJRQorzbe6d7oS2Wxs24
 9KFA==
X-Gm-Message-State: AOJu0YzzTdabb2Je1+5n2MS/M5n7f3nI/9NgGYrYnz0tVpSO8C97qpCO
 xevsFl5B+1y9ErM3PjwKn06pZ2TB8WvLZF5WwIqp9A==
X-Google-Smtp-Source: AGHT+IFjn5i9n90k0qr+Shaka210G2i/4MG2IYgTLK8KHWvkRx4DMzuh4Vx+JHRRi4D8UEMKAU0Y8VHX0TPQNuKjgl4=
X-Received: by 2002:a17:90a:678f:b0:27d:2ecd:6a23 with SMTP id
 o15-20020a17090a678f00b0027d2ecd6a23mr1378709pjj.14.1697703870926; Thu, 19
 Oct 2023 01:24:30 -0700 (PDT)
MIME-Version: 1.0
References: <20231016064526.2410856-1-masahisa.kojima@linaro.org>
 <20231016064526.2410856-5-masahisa.kojima@linaro.org>
 <A2082A91-A1CC-43E8-B151-968D7746B906@gmx.de>
 <CAC_iWj+koNjVBR7TCJH_u_PvY5xDHgtBGRTHBRRgAx_aDeC8-A@mail.gmail.com>
 <ae12d900-fe7f-4f7b-9eb1-018aa719174f@gmx.de>
 <CADQ0-X8XGiek9oBEFeDtXaR2vcBsQS-NhJK5mL9TRLK+9gTJ2A@mail.gmail.com>
 <050e8bea-771b-491d-8d66-14fadcff0487@gmx.de>
 <CADQ0-X9n24HVJ_AoMszTUQy1wk+q=TfZG915mzd3gd=GScxjMA@mail.gmail.com>
 <CAC_iWjJccjJPEWpiBKOA+ue21JAcosVHsgQH7QJvMzcRBASkAw@mail.gmail.com>
 <CADQ0-X8ndi2UmqWTkcfp=1UsPRnZKDi3RJfFVJb7A6FsMZ4=Vw@mail.gmail.com>
 <CAC_iWjL8n7Zkm3qa7MHzjS9gi1ap9EJdezFML4bSmzFDUpMW-A@mail.gmail.com>
 <CADQ0-X-H4YQiANnSveqdub_-N8cz23wBkzq32DOUOxb0XigJwg@mail.gmail.com>
 <CAC_iWjK59UppeLyp=F4agWVEaxQi-Kcz3GrTysOdUP3kd0z6RQ@mail.gmail.com>
In-Reply-To: <CAC_iWjK59UppeLyp=F4agWVEaxQi-Kcz3GrTysOdUP3kd0z6RQ@mail.gmail.com>
From: Masahisa Kojima <masahisa.kojima@linaro.org>
Date: Thu, 19 Oct 2023 17:24:19 +0900
Message-ID: <CADQ0-X8LjTJwdzKPUn7+OkfRvqkpVr5O6U_0TpUQ_zNS8HnRkw@mail.gmail.com>
Subject: Re: [PATCH v7 4/9] efi_loader: create default file boot option
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de, 
 Simon Glass <sjg@chromium.org>, Takahiro Akashi <takahiro.akashi@linaro.org>, 
 Michal Simek <michal.simek@amd.com>
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

On Thu, 19 Oct 2023 at 16:22, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> [...]
>
> > > > > >
> > > > > > According to the EDK II implementation[1], the boot option is
> > > > > > enumerated with the following order.
> > > > > >   1. Removable BlockIo
> > > > > >   2. Fixed BlockIo
> > > > > >   3. Non-BlockIo SimpleFileSystem
> > > > > >   4. LoadFile
> > > > > > So boot option for the fixed device such as HDD is also automatically created.
> > > > > >
> > > > > > [1] https://github.com/tianocore/edk2/blob/master/MdeModulePkg/Library/UefiBootManagerLib/BmBoot.c#L2150
> > > > > >
> > > > > > >
> > > > > > > >
> > > > > > > > When this boot option is selected, Fedora installer automatically starts.
> > > > > > > > So EDK II is searching the default file on the fly.
> > > > > > >
> > > > > > > What is shown if you attach a medium without Bootaa64.efi?
> > > > > >
> > > > > > The same boot option is created.
> > > > > > UEFI QEMU HARDDISK QM00001 : PciRoot(0x0)/Pci(0x1,0x1)/Ata(Primary,Master,0x0)
> > > > >
> > > > > I went back to reading the spec and I think Heinrich is right.  We
> > > > > don't need that check at all. Going through [0] paragraph 4 says
> > > > > " This search occurs when the device path of the boot image listed in
> > > > > any boot option points directly to an EFI_SIMPLE_FILE_SYSTEM_PROTOCOL
> > > > > device and does not specify the exact file to load"
> > > > >
> > > > > So we should *only* add an automatic variable without the default
> > > > > application.  Our code in try_load_entry() will search for that
> > > > >
> > > >
> > > > Thank you for checking the UEFI specification and sorry for
> > > > overlooking the above.
> > > > So we will go back to the previous on the fly default application search.
> > >
> > > Yes, I was about to suggest that.
> > > The problem as I understand it that the current patch not only
> > > disregards disks and partitions that dont have a default (i.e
> > > bootaa64.efi) file. It also *changes* the default boot option we add,
> > > and instead of the disk it adds a file.  That is the part that's
> > > against the spec.  On top of that it changes the behavior of efi
> > > bootmgr and we never call the expand_media_path.
> >
> > What do you mean by "we never call the expand_media_path"?
> > Do you expect we search the partition whether it has a default file,
> > then load the default file with efi_load_image() only when the
> > partition has a default file?
>
> I mean, that the current patch also changed the behavior of the added
> boot options.
> Instead of adding a device path and using expand_media_path() in the
> efibootmgr to load the image, we explicitly added the file path
> instead

OK, I understand.
You explained what the current patch changed the efibootmgr behavior.

Thanks,
Masahisa Kojima

>
> Regards
> /Ilias
> >
> > Thanks,
> > Masahisa Kojima
> >
> >
> > >
> > > So my suggestion would be
> > > - Drop #4
> > > - Adjust patch 5 and instead of loading the boot entry directly, scan
> > > for the special autogenerated boot option and look for that file there
> > >
> > > Heinrich would that work for you?
> > >
> > > Thanks
> > > /Ilias
> > > >
> > > > Thanks,
> > > > Masahisa Kojima
> > > >
> > > > > [0] https://uefi.org/specs/UEFI/2.10/03_Boot_Manager.html#load-option-processing
> > > > >
> > > > > Regards
> > > > > /Ilias
> > > > > >
> > > > > > Thanks,
> > > > > > Masahisa Kojima
> > > > > >
> > > > > > >
