Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD802C3DA6E
	for <u-boot@archiver.kernel.org>; Thu, 28 Dec 2023 06:55:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B89D876BF;
	Thu, 28 Dec 2023 07:55:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ldkLwJSr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 807DA878D3; Thu, 28 Dec 2023 07:55:47 +0100 (CET)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B07A874DD
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 07:55:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-50e7dff3e9fso2606552e87.2
 for <u-boot@lists.denx.de>; Wed, 27 Dec 2023 22:55:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703746544; x=1704351344; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=M/j8u86UnHou9JYpg8ELSgkOrd6QoIIUwKKrZnDzYW0=;
 b=ldkLwJSrkJz+BoqqW8K1TSs+MOx61zlLd3fq1nrItFRinz8H1Frj+tpQHCEh0yGS5O
 1rHOcu77YnQJnzldu5MwSgMnd4GXssQuSKkL/ZODXk4DZYmBq+/p614OIHLW6dJoiUAh
 aSb6I8e3MnvJaRTYAdG21LPzLnPTfN+tjC8DIgB6qpQ4m2ixLNEzVVDB47r9Ei6T3gUV
 bEFNHqhXaVmRNhIKG0ljPO8P0IWuyyPPELId08D/BIrM/rNqIb2WyjHjYyfQEpXuhgIX
 gK+3mK9ogJTI3LhM0WtHEKCBlC8exGL5DxL48Ct4PssdpRwWqySvBJtbjqyzclSiIMFJ
 hwJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703746544; x=1704351344;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=M/j8u86UnHou9JYpg8ELSgkOrd6QoIIUwKKrZnDzYW0=;
 b=vPFT2TFexOjUa9Qp0cBKhfb/QuEtA+ulBeXJ+Gze4rstqBrwwmr3qfhPapIPZTKa9U
 aGzHt50Nfntj3B0m/HUgQBORsYYpNcbT2enUoh7EJZj0OzTDn9tKlQ8dhF3d6XECnxW0
 oCNDnObEvC/h6yOaR1sn7IggbW7UYVth1ehzPCXflS72PFfA/U5f3mXil2FR3iAQbKDf
 CDLzXL1l5CfsTnfjmRz7bMJLE1BeF9LxsRO3naVawjajh0veiTFxwrIKhDaLi22GZ3BX
 R5gfHoXgslS4PQB3Ba812ZJqv+sLdM9pkK1aKj8RpcuiDftMWVfHmyhSU3ekSvMF19LR
 ZHoQ==
X-Gm-Message-State: AOJu0YxnuEK+AtmAuhHwybq1XgXpUyl+3jlO8H1CCnnf3pVDJeXE8xdz
 xd9uK+clP2OHXE7vLE0qO2KgDk1SemEnVF9C2gpDMFumcwTd6g==
X-Google-Smtp-Source: AGHT+IGzfKYHBbv56sjL1SWtuFEYOvGeTCYvtiPbFuguWZvrYAftLhhjwanSRgjHyJLhZWlMLfL+4TmrSigR8QJRJJ0=
X-Received: by 2002:ac2:5def:0:b0:50e:630d:7364 with SMTP id
 z15-20020ac25def000000b0050e630d7364mr3669500lfq.28.1703746544653; Wed, 27
 Dec 2023 22:55:44 -0800 (PST)
MIME-Version: 1.0
References: <20231226094625.221671-1-sjg@chromium.org>
 <20231226120710.GH2652760@bill-the-cat>
 <CAC_iWjLy1E9wEW3zX2waN9mc=tz7PTKE0gJ4RucqMmZR2cA6_Q@mail.gmail.com>
 <CAFLszTgqS9TF1F-RxO1dpZPZGG6QBiKm0n_e0yVHAume+xT3eA@mail.gmail.com>
 <20231227201130.GV2652760@bill-the-cat>
In-Reply-To: <20231227201130.GV2652760@bill-the-cat>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 28 Dec 2023 08:55:08 +0200
Message-ID: <CAC_iWjJ1Sh0c4KLks4JuGn_QfXSOObvUFaUTpDMWePo2GmXwjw@mail.gmail.com>
Subject: Re: [PATCH v4] fdt: Allow the devicetree to come from a bloblist
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>,
 Marek Vasut <marex@denx.de>, 
 Raymond Mao <raymond.mao@linaro.org>, Baruch Siach <baruch@tkos.co.il>, 
 Bin Meng <bmeng.cn@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Jerry Van Baren <vanbaren@cideas.com>, Michal Simek <michal.simek@amd.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Nikhil M Jain <n-jain1@ti.com>,
 Qu Wenruo <wqu@suse.com>, Sean Anderson <seanga2@gmail.com>
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

[...]

> >
> > No, but that is just a straw man. The DT is special and U-Boot reports
> > where it comes from.
> >
> > >
> > > This has been going back and forth for a while. I've lost count of how
> > > many times I repeated the same proposal, but here it goes again. We
> > > have OF_BOARD and BLOBLIST options. The bloblist and its properties
> > > are scannable at runtime. Can't we use the combination of these 2 can
> > > be used to imply we expect things from a bloblist. If we want to be
> > > stricter in the future and explicitly expect the DT from a bloblist,
> > > we could add a Kconfig option failing the boot if that's missing.
> >
> > I would like to have that Kconfig option now, not later. In my mind,
> > the boot must be deterministic, so that if OF_BLOBLIST is enabled, the
> > DT must come from there, or it is an error.
>
> Determinism doesn't require a CONFIG option, it just requires an if/else
> tree where we say what the "correct" priority list should be and then
> set a flag so that we can tell the user where we found it too. This also
> means that we can get whatever is going to use this mechanism to
> migrate over, and have less of a chicken-and-egg type of problem.
>
> > Also, repeating it doesn't make the proposal good. We agreed that
> > OF_BOARD would eventually go away, so building on top of it is not
> > setting us up for the future.
>
> I wonder if OF_BOARD will ever go away, and I'm not convinced it will
> either.

It won't :) -- ever. You will still have hardware that reads it from
an EEPROM for example, or something like that.
People usually keep the first-stage bootloaders simple, so adding more
drivers to read something is usually deferred to later, richer
bootloaders, unless necessary

> Unless you just mean re-naming it and making a few ad-hoc
> standards more easily re-usable, which also will need to happen
> regardless.

Yes, that was what I initially suggested.

Thanks
/Ilias
>
> --
> Tom
