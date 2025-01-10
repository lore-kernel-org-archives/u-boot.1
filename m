Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24319E7719C
	for <u-boot@archiver.kernel.org>; Fri, 10 Jan 2025 14:15:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73428801F5;
	Fri, 10 Jan 2025 15:15:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XLFEI7UM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E64128036B; Fri, 10 Jan 2025 15:15:34 +0100 (CET)
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com
 [IPv6:2607:f8b0:4864:20::b36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4FE87800D0
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 15:15:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-e4a6b978283so5136634276.0
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 06:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736518531; x=1737123331; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gEGoBThx+W4OgK02wHNbhTvaOaRXMqGkS9Kkp1xIeos=;
 b=XLFEI7UMnYnSTpF0y5yEBqwvjgQWCLW9z9cLKr9YBsprvUlbw1OIiqxpFEiFpAxzYm
 zl0T8LhYM/X2fNcmJgVwXfkmlry8VkYMTJcYdQr74i65KernDgt5cGSPOLq/SXTsQ4wV
 gyJBHVUUD4Szz/WEY9q6YHMsWZBFmDsDFC4UEHBs2wvcc9eTrOz+iA8McAO8iS9UJzQS
 TbS6TLnRy86EVfDgNLo2kTL2bRlsuxVOW2a1VmoOS6xU4CfK8ZeP6FsY2V2HYi+K3NuV
 hKoz1YngPRJrHjqy9rEo0Axc97z25XJBB6ig/gBvUNvTCB8smICg7DAgsbNnhsgzYMAJ
 ENZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736518531; x=1737123331;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gEGoBThx+W4OgK02wHNbhTvaOaRXMqGkS9Kkp1xIeos=;
 b=j5Q46pSiEzLN7ZDvkGQJXbfNp4bXBo3kU98Qg/x4cstYwgXGgAYlVfs7zdBB92PeQ2
 jUueABWAfgfdaETteDPOBmCBuRLF2dWPr4+YcGaGWn4aD2fGTjW+whPH01kB1CJe3Nn6
 e6GC2Lp7mB7wHKEyyJAL9EZ565m7xqeam3P2VkMxWKwI++5IpHInwZ4XLUxVCXF35iSa
 SMrU160DUHk56miJuJWM1xW7fJ6eAQ7WmzdIH79GfEHZZq8PHqnOuHjksFg1H1b6z1+A
 IPxNIBoOyJnEPTbfWoKjuen2MBwIr0uodPgv+FROzAfw2Svx2zc3tdJl/nPQB/ihHfbc
 ITEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpFPoUTGsvuxvUg++tnm84Yb2tP8+1DkIKr7W6337CmeoK46ZYC/F0+1VhJx2dWIs73inhR6s=@lists.denx.de
X-Gm-Message-State: AOJu0YxusYgVX3+PORIPpBkkCXBr1pbQJVAWyOBJVba1QZ7EQJ2MRF+I
 WfDCJyIjBrBPeV8FSvB2q+yETrvm4eknENaDhViI7PaJED6leMQVap2R+tZcdHVnCr/MWSDR3kW
 PcTd+9hnrXd1dseUzAVyzOOV/aaB/5xIlrAtCRA==
X-Gm-Gg: ASbGncvtTwF3g5ulj/8lDk0y2OVXlYszK8xTy4mOioAXxl6UPSE4kNgS7FiaZh6vm/0
 N8N9ziVfxt/zmsvQje2lEzqQiKNNl40IEgVXyLA==
X-Google-Smtp-Source: AGHT+IFEvUVBamvX+5twC1wWXSEWDd0P2a5P3nXzFxComWbBAJKVdgfbPWdvjfghnoyU53iNbt+wjA29LUla4cWotBM=
X-Received: by 2002:a05:690c:4b0b:b0:6db:e1e0:bf6a with SMTP id
 00721157ae682-6f5494cc418mr46019597b3.7.1736518530909; Fri, 10 Jan 2025
 06:15:30 -0800 (PST)
MIME-Version: 1.0
References: <20241206173033.2403998-1-adriano.cordova@canonical.com>
 <20241206173033.2403998-2-adriano.cordova@canonical.com>
 <9cc4a4e0-1a80-4bdc-9fd7-a04260ff7cb7@gmx.de>
 <CAFLszTiH9+avmapq8CEEr-tqybP9mWZGzqp52mVHsM87FGTfhw@mail.gmail.com>
In-Reply-To: <CAFLszTiH9+avmapq8CEEr-tqybP9mWZGzqp52mVHsM87FGTfhw@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 10 Jan 2025 16:14:55 +0200
X-Gm-Features: AbW1kvYp2KcdiYanI_LdPgrH8tOz4n8QnX_0C2QA6Amz0I3Q02QeLVaJjQolrZg
Message-ID: <CAC_iWjKmzfbWGD3URheJS4w0Bhr8K_Unwi0KpFV56b4gwwO3pg@mail.gmail.com>
Subject: Re: [PATCH 1/2] efi_loader: efi_setup: Add efi_start_obj_list() to
 efi_setup.c
To: Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Adriano Cordova <adrianox@gmail.com>, joe.hershberger@ni.com, 
 rfried.dev@gmail.com, jerome.forissier@linaro.org, trini@konsulko.com, 
 Adriano Cordova <adriano.cordova@canonical.com>, u-boot@lists.denx.de
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

On Fri, 10 Jan 2025 at 15:41, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Heinrich,
>
> On Fri, 3 Jan 2025 at 12:55, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> >
> > On 06.12.24 18:30, Adriano Cordova wrote:
> > > The command bootefi calls efi_init_obj_list to do the efi set up
> > > before launching an .efi payload, but efi_init_obj_list is called
> > > only once. There are some initializations which depend on the
> > > environment and should be done each time a payload gets launched and
> > > not only once and can now be done in efi_start_obj_list(). A motivation
> > > for this change is the following order of events:
> > >
> > > 1. Launch an EFI application (e.g. bootefi hello)
> > > 2. Change the ip address
> > > 3. Launch another application which uses the pxe protocol
> >
> > Hello Adriano,
> >
> > Thanks for addressing this issue.
> >
> > There are a number of events that can lead to updating the IP address:
> >
> > * EFI_PXE_BASE_CODE_PROTOCOL.Dhcp()
> > * EFI_PXE_BASE_CODE_PROTOCOL.SetStationIp()
> > * EFI_HTTP_PROTOCOL.Configure()
> > * command set env ethaddr#
> > * command dhcp
> >
> > All of these events require:
> >
> > * Updating the relevant ethaddr* variable.
> > * Updating any other references to the IP address.
> >
> > When not only considering EFI applications but also EFI drivers
> > installed via the bootefi command all of these events can occur during
> > the runtime of EFI binaries.
> >
> > Function efi_init_obj_list() is used for setups that are needed only
> > once before accessing the UEFI sub-system. It is not able to handle events.
> >
> > If we need to update any internal UEFI data structures, we should do
> > this instantaneously when the event occurs and not when executing a UEFI
> > related shell command.
> >
> > U-Boot already has callbacks invoked when variables are changed. These
> > are set up with U_BOOT_ENV_CALLBACK(). There is even a command 'env
> > callbacks' to list these callbacks.
> >
> > You could define a new function to handle changes of the IP address and
> > invoke it via U_BOOT_ENV_CALLBACK(ipaddr, <function name>) or
> > U_BOOT_ENV_CALLBACK(netmask, <function name>).
> >
> > With lwIP we can have multiple network interfaces. Each has a different
> > variable ipaddr# assigned to it. We will have to extend the concept of
> > U_BOOT_ENV_CALLBACK() to allow for wildcard matches by adjusting
> > find_env_callback(). With CONFIG_REGEX=y regular expressions could be
> > used for this purpose (cf. include/slre.h) but we should better avoid
> > the code size increase.
> >
>
> I have been saying for some time that EFI_LOADER should make use of
> U-Boot's existing tables, rather than creating its own duplicate ones
> with extra info.
>
> This seems to have been understood as 'hang the EFI tables onto
> existing data structures', e.g. efi_disk_create_part(). But this leads
> to duplication.
>
> Perhaps the EFI_LOADER init should be quite small, and be done each
> time an app starts, to deal with the 'current' state of U-Boot?

That would break all the command line tools that use the EFI subsystem
-- e.g printenv -e, efidebug, eficonfig etc
/Ilias
>
> Regards,
> Simon
