Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0437C71153
	for <u-boot@archiver.kernel.org>; Mon, 28 Aug 2023 08:32:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2995F864B0;
	Mon, 28 Aug 2023 10:32:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="umifnYS5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35E15864CD; Mon, 28 Aug 2023 10:32:07 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 95A6F86498
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 10:32:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-52a4818db4aso3814383a12.2
 for <u-boot@lists.denx.de>; Mon, 28 Aug 2023 01:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693211524; x=1693816324;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QGPLN+YcdA0JDyv7I8lAawbMOfRTG3SQYVzfb+gur/0=;
 b=umifnYS5Ag0tKVLXX6F6u2wgMhWv3n3jWjSWuaf8HNipy3dxNypByS6t1+7It8Rdpd
 hUpxkckVQuO/V0b4rY5ZSNyfPVtw32Hi62IJaEtb0BcAGCodkgb3b5d+WZh6OHPUbjVi
 Ev60ubHhYjsBfU+bTXHgyReyA3jkiDPX+12YghkC6fsOjK/BgyA8pL8PQ80TRRZnOets
 PmjamDCIZH/JKOudFpzLSYBL+u85rsHPISUZDMCYXlmz83FOdPccXEVmcn23BqTosDmY
 DXnz9Tm5Ab8KD7NBVHTJhcx7eXmsG6ZXQFEdtHLPcsXXdSBFaCjlcOLinNVNJxQbUx8f
 KLbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693211524; x=1693816324;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QGPLN+YcdA0JDyv7I8lAawbMOfRTG3SQYVzfb+gur/0=;
 b=Esdo65KnpGhBNOCjyQqNjrg2BeXKyLomEpR6RxQvw7xzN+g95UpcNNm0064WVYnStJ
 oXu0jWGogRZAvVum7P9098nZjtGmGzL31MAUqiif1GcYaOiKK/L2LXEtWBmFTGkNdc3x
 BxvhYCeaSmbBsCMf0o5J0OGP7RPjRbBI0cg076lftjGo+Dgr0MOu6eA8cFys27mZmJUD
 +2ybjO3x1aUybkFoUYOY95a4jtleg8PVtKoZwhfDu2IBjQLPBMcGPRNHgiKOpoTpSm0c
 2Q6xvOAFiiDaovF2axug46BLxIBQgq/Ly237PQiGomaihvYfhzqcAApNNoKB6dw47xyd
 O8aQ==
X-Gm-Message-State: AOJu0YyWCapybUpWgSS46fU6SqpJnoTmHLpfRXdykRHTINVnBMuAVLUe
 OQl2pD97N215gI94BWAjnCoibXXTA/RDVtpbGpEHDA==
X-Google-Smtp-Source: AGHT+IF/5jsJ+D/krAu5Rs9+tmwHbJjAkyJjaXIjvxwAkyFqX0bncAUlgxct62MW2+5WhzzLXrZeh6optiyVjr4L5pk=
X-Received: by 2002:a05:6402:1206:b0:525:7234:52b7 with SMTP id
 c6-20020a056402120600b00525723452b7mr20168421edw.19.1693211524144; Mon, 28
 Aug 2023 01:32:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230826090633.239342-1-sughosh.ganu@linaro.org>
 <aca7e6fa-2dec-a7c5-e47e-84c5ffa6f9b7@gmx.de>
In-Reply-To: <aca7e6fa-2dec-a7c5-e47e-84c5ffa6f9b7@gmx.de>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Mon, 28 Aug 2023 14:01:53 +0530
Message-ID: <CADg8p97BpFnmiqRwxzvRJPFAQrdvOL1KOfDjmSRdg+tJe_F_3Q@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] Allow for removal of DT nodes and properties
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
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

On Sat, 26 Aug 2023 at 15:36, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 8/26/23 11:06, Sughosh Ganu wrote:
> >
> > Provide a way for removing certain devicetree nodes and/or properties
> > from the devicetree. This is needed to purge certain nodes and
> > properties which may be relevant only in U-Boot. Such nodes and
> > properties are then removed from the devicetree before it is passed to
> > the kernel. This ensures that the devicetree passed to the OS does not
> > contain any non-compliant nodes and properties.
> >
> > The removal of the nodes and properties is being done through an
> > EVT_FT_FIXUP handler. I am not sure if the removal code needs to be
> > behind any Kconfig symbol.
> >
> > I have only build tested this on sandbox, and tested on qemu arm64
> > virt platform. This being a RFC, I have not put this through a CI run.
>
> We should have a test for the new functionality. E.g. add some
> superfluous properties and nodes to arch/sandbox/dts/test.dts, delete
> them via the DT_PURGE macro, and check that the device-tree passed to an
> EFI binary does not contain these properties and nodes.

Yes, I plan to have a test in the non-RFC version. I was thinking of
adding a command and then using that to test the functionality.

-sughosh

>
> Best regards
>
> Heinrich
>
> >
> > Sughosh Ganu (5):
> >    dt: Provide a way to remove non-compliant nodes and properties
> >    fwu: Add the fwu-mdata node for removal from devicetree
> >    capsule: Add the capsule-key property for removal from devicetree
> >    bootefi: Call the EVT_FT_FIXUP event handler
> >    doc: Add a document for non-compliant DT node/property removal
> >
> >   cmd/bootefi.c                                 | 18 +++++
> >   .../devicetree/dt_non_compliant_purge.rst     | 64 ++++++++++++++++
> >   drivers/fwu-mdata/fwu-mdata-uclass.c          |  5 ++
> >   include/dt-structs.h                          | 11 +++
> >   lib/Makefile                                  |  1 +
> >   lib/dt_purge.c                                | 73 +++++++++++++++++++
> >   lib/efi_loader/efi_capsule.c                  |  7 ++
> >   7 files changed, 179 insertions(+)
> >   create mode 100644 doc/develop/devicetree/dt_non_compliant_purge.rst
> >   create mode 100644 lib/dt_purge.c
> >
