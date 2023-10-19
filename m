Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BE1DCDB465
	for <u-boot@archiver.kernel.org>; Thu, 19 Oct 2023 07:22:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EAA5B8717B;
	Thu, 19 Oct 2023 09:22:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="sO6CikZc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E39787183; Thu, 19 Oct 2023 09:22:42 +0200 (CEST)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com
 [IPv6:2a00:1450:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E9F887178
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 09:22:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2c4fe37f166so96455341fa.1
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 00:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697700157; x=1698304957; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=n4UXbkSoDUrt+8AfND/Ts0s9jr/O+Lf7ZjnHbJQUi9U=;
 b=sO6CikZcPtaEpgksB7umwCc4zpTuOBvvuOC3gmDEgZkdsVt/UiMUPYOHTlidIulOJp
 bI/9+Y7O/tnURziIdp4m5c8BjMoy5LMqCRhIkr9MVa+XkqHenyMYOeDuUWosXrq9IpkT
 GraKcbU9pRL1kuWZdmOGcHsDqjKUNpA8Vre4qt3vCJMflheYDiSaONWWipJvgXtzy/Kj
 ICozMMAGdZsHRORxAf3fUPWE3GZ11miTZS5HG/EdwABeoHPevD1r8ZC5OSz9BDj+V1pD
 jBR5h0g7Eh7cjsBmssWtUdk8X25Qywg7p3+YgONF6K1hs3FPAJ+nucYkb7IuHVn5uHlM
 RZRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697700157; x=1698304957;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=n4UXbkSoDUrt+8AfND/Ts0s9jr/O+Lf7ZjnHbJQUi9U=;
 b=Ihv/eOSjMeeb5y/X9fCZf9uoWFOgvMj0sTf4OuuBs50w5dBG/cOcNdBXtxPC+jMVpE
 y8uRI0eesww4FHrlIDvlhEhMCp3VV6rTn/u7LXSC7PCemTdaVwWFFVb9BKk40BXVGhAi
 SqzVMj5o6V6GhOsnTjXFXdQLBpS7wwffPEtB/hPeeTg6enp61gEQTDaSEZMjn3cRoGWe
 OpeBgECk6J0/ruOuUHePGqBfO/CPx03ATNfON8pAeBQB8LfRdRlvpP2Pmy7Us8rFqwnB
 OuOPHB84WNjyYuo8io/ycu3RXCSsUrKyisYup5NuTWbzhFF1Pst4e2AkKF6nyANYxxua
 wCig==
X-Gm-Message-State: AOJu0YyL9YFNT2XupwK2CYqDsVOxmdk9QqWKB2wHpbhORFmNml5HfCJg
 mvjlnA2KB14QaJrRBeuRO06wnQqzuaK7JV7kASXAVg==
X-Google-Smtp-Source: AGHT+IH12NAHQnog+IqMtL6nSfySRO4YIS9j1yPgMg8Wr8EtARaQ/YZXFZaaakhnK1Xe1BljCGvT7RDNzsgJBGxccEk=
X-Received: by 2002:ac2:4c0e:0:b0:507:aa44:28fa with SMTP id
 t14-20020ac24c0e000000b00507aa4428famr813073lfq.26.1697700157585; Thu, 19 Oct
 2023 00:22:37 -0700 (PDT)
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
In-Reply-To: <CADQ0-X-H4YQiANnSveqdub_-N8cz23wBkzq32DOUOxb0XigJwg@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 19 Oct 2023 10:22:01 +0300
Message-ID: <CAC_iWjK59UppeLyp=F4agWVEaxQi-Kcz3GrTysOdUP3kd0z6RQ@mail.gmail.com>
Subject: Re: [PATCH v7 4/9] efi_loader: create default file boot option
To: Masahisa Kojima <masahisa.kojima@linaro.org>
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

[...]

> > > > >
> > > > > According to the EDK II implementation[1], the boot option is
> > > > > enumerated with the following order.
> > > > >   1. Removable BlockIo
> > > > >   2. Fixed BlockIo
> > > > >   3. Non-BlockIo SimpleFileSystem
> > > > >   4. LoadFile
> > > > > So boot option for the fixed device such as HDD is also automatically created.
> > > > >
> > > > > [1] https://github.com/tianocore/edk2/blob/master/MdeModulePkg/Library/UefiBootManagerLib/BmBoot.c#L2150
> > > > >
> > > > > >
> > > > > > >
> > > > > > > When this boot option is selected, Fedora installer automatically starts.
> > > > > > > So EDK II is searching the default file on the fly.
> > > > > >
> > > > > > What is shown if you attach a medium without Bootaa64.efi?
> > > > >
> > > > > The same boot option is created.
> > > > > UEFI QEMU HARDDISK QM00001 : PciRoot(0x0)/Pci(0x1,0x1)/Ata(Primary,Master,0x0)
> > > >
> > > > I went back to reading the spec and I think Heinrich is right.  We
> > > > don't need that check at all. Going through [0] paragraph 4 says
> > > > " This search occurs when the device path of the boot image listed in
> > > > any boot option points directly to an EFI_SIMPLE_FILE_SYSTEM_PROTOCOL
> > > > device and does not specify the exact file to load"
> > > >
> > > > So we should *only* add an automatic variable without the default
> > > > application.  Our code in try_load_entry() will search for that
> > > >
> > >
> > > Thank you for checking the UEFI specification and sorry for
> > > overlooking the above.
> > > So we will go back to the previous on the fly default application search.
> >
> > Yes, I was about to suggest that.
> > The problem as I understand it that the current patch not only
> > disregards disks and partitions that dont have a default (i.e
> > bootaa64.efi) file. It also *changes* the default boot option we add,
> > and instead of the disk it adds a file.  That is the part that's
> > against the spec.  On top of that it changes the behavior of efi
> > bootmgr and we never call the expand_media_path.
>
> What do you mean by "we never call the expand_media_path"?
> Do you expect we search the partition whether it has a default file,
> then load the default file with efi_load_image() only when the
> partition has a default file?

I mean, that the current patch also changed the behavior of the added
boot options.
Instead of adding a device path and using expand_media_path() in the
efibootmgr to load the image, we explicitly added the file path
instead

Regards
/Ilias
>
> Thanks,
> Masahisa Kojima
>
>
> >
> > So my suggestion would be
> > - Drop #4
> > - Adjust patch 5 and instead of loading the boot entry directly, scan
> > for the special autogenerated boot option and look for that file there
> >
> > Heinrich would that work for you?
> >
> > Thanks
> > /Ilias
> > >
> > > Thanks,
> > > Masahisa Kojima
> > >
> > > > [0] https://uefi.org/specs/UEFI/2.10/03_Boot_Manager.html#load-option-processing
> > > >
> > > > Regards
> > > > /Ilias
> > > > >
> > > > > Thanks,
> > > > > Masahisa Kojima
> > > > >
> > > > > >
