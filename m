Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E549AC3DA49
	for <u-boot@archiver.kernel.org>; Tue, 23 Jul 2024 12:47:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B0F588792;
	Tue, 23 Jul 2024 14:47:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JEFv1pTK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 21AAD8865D; Tue, 23 Jul 2024 14:47:25 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5CB886DBD
 for <u-boot@lists.denx.de>; Tue, 23 Jul 2024 14:47:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-703d5b29e06so2329281a34.2
 for <u-boot@lists.denx.de>; Tue, 23 Jul 2024 05:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721738839; x=1722343639; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Cw+V/DCdhbQQKbWeBip/fShjrswqxIfLZa58deQMCmI=;
 b=JEFv1pTKfyYQ4E0sDCptJsWmmcx7/ceRFsZEoUFJmKQHaJxYVVTiPtIr6K2O0cZoZd
 UxJIT7fUB7+k0rDfealqkHD7PdIvFntAOnayMuk8wbe+mNjcCw5FKbo/uptlOnBdwNnm
 LuUToud1ool+qp1SyUnCLMSp0NRJVJYGMDLYs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721738839; x=1722343639;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Cw+V/DCdhbQQKbWeBip/fShjrswqxIfLZa58deQMCmI=;
 b=eKJ6oSKyfM1BVtgthYjRYQqh6k7DxNK+LJSig59/Z6TjfMnj5tMsjR4PqJrnLzL826
 XBepr7UIsviDHERuKoBslcw93qb4uLNzRw1+avjamqKOQtiDLi6wsxDREZmwAtPzX8mj
 0ATTcMBK7bYoRKC/72dac9Ea3JB+bE4ewCMlpHFma2AggFtHmZ6lPgkz4wHcYB0OFXsO
 2spyvSmpCZmtfTY2xc3AbqvdZfDermzgmDqo59eR6bo14hHDocjFFXVN4ejBeXRZ+RE4
 f5yrxEVBahxQKYuX1FWa3gj1puZUbRO2IcKiWKahQ9+cONbeDaES9Y6ojefB+GwQfm0D
 jVWQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfnlfl/lyXEoRsLy8QCDWcuA6QHEiL7az+7nErqzX4TKjy9hBiXABZnV9agIlJszfpm8ZIG2yWWvAJkWNXlCMQQvF0qQ==
X-Gm-Message-State: AOJu0Yy1yEhoL4N059SAhhpmQENKYFbpZi7fYO/TY8YULNt7/8ZkG4P8
 fHzWEezFMIGXXRFCQeukRTR36YiYN5gxlpgDcyp0AMe5MrnvGgjF5RD68smAlHXA3UKEZr30H+b
 j0ejXTdCERPsu+QVly3xXvGixxkOg2w72jqjD
X-Google-Smtp-Source: AGHT+IFMisXhRZPWL8bFi8zmfhYl80zun09KgY/xzwkEEeUJPIAelA9jAd3Gx4lzHwNropmJfeDaxgs2cVvI0rW9zak=
X-Received: by 2002:a05:6830:d81:b0:704:494e:fa1c with SMTP id
 46e09a7af769-709008d2da0mr9357032a34.5.1721738839328; Tue, 23 Jul 2024
 05:47:19 -0700 (PDT)
MIME-Version: 1.0
References: <20240704073544.670249-1-sughosh.ganu@linaro.org>
 <20240708140242.GA38804@bill-the-cat>
 <CADg8p968x-UsiHEazS81+DxSXN0DLHpjTEDYDA+0LO=3hGK86A@mail.gmail.com>
 <20240722173325.GA989285@bill-the-cat>
 <CADg8p97bFNApmT+sPPs4MYhyOwzAdK_7M6n__0CaX5iV1MvK-w@mail.gmail.com>
In-Reply-To: <CADg8p97bFNApmT+sPPs4MYhyOwzAdK_7M6n__0CaX5iV1MvK-w@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 23 Jul 2024 13:47:08 +0100
Message-ID: <CAFLszTjsE0hPHZm70R7e1xzz1eL1kOMPcvbJRFiGQLrxmG6QQg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 00/48] Make U-Boot memory reservations coherent
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Marek Vasut <marex@denx.de>, Mark Kettenis <mark.kettenis@xs4all.nl>, 
 Fabio Estevam <festevam@gmail.com>, Michal Simek <michal.simek@amd.com>
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

Hi Sughosh,

On Mon, 22 Jul 2024 at 18:37, Sughosh Ganu <sughosh.ganu@linaro.org> wrote:
>
> On Mon, 22 Jul 2024 at 23:03, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Mon, Jul 22, 2024 at 11:58:18AM +0530, Sughosh Ganu wrote:
> > > On Mon, 8 Jul 2024 at 19:32, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Thu, Jul 04, 2024 at 01:04:56PM +0530, Sughosh Ganu wrote:
> > > >
> > > > > The aim of this patch series is to fix the current state of
> > > > > incoherence between modules when it comes to memory usage. The primary
> > > > > issue that this series is trying to fix is that the EFI memory module
> > > > > which is responsible for allocating and freeing memory, does not have
> > > > > any visibility of the memory that is being used by the LMB
> > > > > module. This is further complicated by the fact that the LMB
> > > > > allocations are caller specific -- the LMB memory map is not global
> > > > > nor persistent. This means that the memory "allocated" by the LMB
> > > > > module might be relevant only for a given function. Hence one of the
> > > > > requirements for making the memory usage visible across modules is to
> > > > > make LMB allocations persistent and global, and then have means to
> > > > > communicate the use of memory across modules.
> > > > >
> > > > > The first set of patches in this series work on making the LMB memory
> > > > > map persistent and global. This is being done keeping in mind the
> > > > > usage of LMB memory by platforms where the same memory region can be
> > > > > used to load multiple different images. What is not allowed is to
> > > > > overwrite memory that has been allocated by the other module,
> > > > > currently the EFI memory module. This is being achieved by introducing
> > > > > a new flag, LMB_NOOVERWRITE, which represents memory which cannot be
> > > > > re-requested once allocated.
> > > > >
> > > > > A review comment on the earlier version was to do away with the static
> > > > > arrays for the LMB lists of free and used memory. This version
> > > > > uses the alloced list data structure for the LMB lists.
> > > > >
> > > > > The second set of patches are making changes to the EFI memory module
> > > > > to make use of the LMB functions to allocate and free memory. A
> > > > > *_flags() version of LMB API's has been introduced for the same. The
> > > > > earlier version was using notification mechanism from both LMB and EFI
> > > > > modules to maintain memory coherence. This version makes use of the
> > > > > LMB API functions for the memory allocations. This is based on review
> > > > > comments of EFI maintainers.
> > > >
> > > > On am64x_evm_a53, the last test in test/py/tests/test_net_boot.py fails
> > > > due to:
> > > > ...
> > > > TFTP from server 192.168.116.10; our IP address is 192.168.116.23
> > > > Filename 'pxelinux.cfg/default-arm-k3'.
> > > > Load address: 0x80100000
> > > > Loading: ##################################################  64 Bytes
> > > >          8.8 KiB/s
> > > > done
> > > > Bytes transferred = 64 (40 hex)
> > > >   1  pxe          ready   ethernet     0  port@1.bootdev.0          extlinux/extlinux.conf
> > > > ** Booting bootflow 'port@1.bootdev.0' with pxe
> > > > Retrieving file: pxelinux.cfg/default-arm
> > > > am65_cpsw_nuss_port ethernet@8000000port@1: K3 CPSW: rflow_id_base: 16
> > > > link up on port 1, speed 1000, full duplex
> > > > Using ethernet@8000000port@1 device
> > > > TFTP from server 192.168.116.10; our IP address is 192.168.116.23
> > > > Filename 'pxelinux.cfg/default-arm'.
> > > >
> > > > TFTP error: trying to overwrite reserved memory...
> > > > Couldn't retrieve pxelinux.cfg/default-arm
> > >
> > > So this seems to be failing because the address used to load the pxe
> > > config file seems to be overlapping with an already reserved region of
> > > memory. Can you please check if modifying the address works?
> >
> > I'm not sure what address you're thinking of modifying but, this isn't
> > overwriting U-Boot itself so it's a case that needs to work.
>
> Can you please print the lmb memory map through bdinfo and share it
> with me. That will give some info on what is causing the issue. Thing
> is, with this patchset, if there is another reservation with a
> different flag(like LMB_NOMAP, LMB_NOOVERWRITE), this would cause the
> load to fail.

I too am interested in what it might be. Scripts in general can load
things where they want, so we need to be careful.

Also, as mentioned I would really like to clean up the 'EFI'
'allocations' so that they only happen when booting an EFI payload. I
am not too sure what the current state is, but I will see if I can
take a look.

Regards,
SImon
