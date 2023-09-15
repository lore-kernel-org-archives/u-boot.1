Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 141E3EE021D
	for <u-boot@archiver.kernel.org>; Fri, 15 Sep 2023 06:10:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D6D67864D4;
	Fri, 15 Sep 2023 08:10:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="CtbJLsbF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24DDE866DA; Fri, 15 Sep 2023 08:10:15 +0200 (CEST)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F94386466
 for <u-boot@lists.denx.de>; Fri, 15 Sep 2023 08:10:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-5029e4bfa22so2930080e87.3
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 23:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694758212; x=1695363012; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1YcsMcLBe/ey94wZJNZ8ZleXQ6eV5wrkChHI97YZeG0=;
 b=CtbJLsbFSzVasFTDk2vB93B16F0H5mFlPw8TIlFsDoqWmwSxE75tJslBpD9Q36IR5/
 UV4PIjW+blI0Tczs8eO8Kv8LAoPGp5udAAqg9gLK60S+msA1VluJMGEMvedt2DNVg+qT
 GYY/lLpZ4p/s5agSviw8YgiR+32lrdyal6ABIaHJvC6b+X+TGbdB68EW5F1lHbQqYD3J
 xWWWuNjHF6o42VbLiIG71radxt+q/b8Ie6hHxgkxcl2LHcDqOJooGT1ksp/te1FzW8Wg
 CclX+0p8YuL4eoaA1h8vLm3P0IOpbVj9DdNDW0bR2oM8Fc87xaM1Nl66cbCPNVbQD4/c
 /C5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694758212; x=1695363012;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1YcsMcLBe/ey94wZJNZ8ZleXQ6eV5wrkChHI97YZeG0=;
 b=IlVwvT6zbYadCkJUUiVj7Ygg/oilJq/SK1Mej5kvpKZAP5Qnel+iG+ZgBbrddG12j2
 W2EAFbvF7dDML4IjodcPkVtYmUh+pdepORfv0SZoOdCYYjkxNa2OrT0MIkH8aZUnrnd1
 DhIZLEWD57PyKdZ9l7oyk53NtWAOoWBYPs/I1NbdWalfXPbpE28LIo1Z2MJuV35/+CLT
 j5egKxdU8oc77le+cyDfbpKnqcyNk2hE0fQ7jTRFaU+T53RtQasHPTBJpqoBvoASO0fl
 ARCGnUcYzapNLTbn1YIlLoh4cW0aanjXNP3xETbCVa5evi0NjJ7UG3PWgdn5ThBvWIg0
 4AWQ==
X-Gm-Message-State: AOJu0YzYwS5ENBSBVbRnLy0zJcsLN8+VMIR/x0hsFKJLCcUDHKf3jTpv
 ncYWtvgBtmEMMwQgSwO2dHrC5DYsjf9vQH/tqF4nGA==
X-Google-Smtp-Source: AGHT+IG9H+svBNQRpK5HTpa/kF5gBVZIiDHDX5eblf8XdurWeR3vAcwg7P6gKMzmLcHfoKyo1u9siueqC1sfprBZaYU=
X-Received: by 2002:a05:6512:559:b0:4fe:279b:8a02 with SMTP id
 h25-20020a056512055900b004fe279b8a02mr507970lfl.67.1694758211762; Thu, 14 Sep
 2023 23:10:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230901102542.609239-1-masahisa.kojima@linaro.org>
 <20230901102542.609239-7-masahisa.kojima@linaro.org> <ZQMRRQ4zOnKUU4WK@hera>
 <CADQ0-X-NCj03ghuGj946KtO-2nO+BdXUt5HcDz8dH5ez2WHghA@mail.gmail.com>
In-Reply-To: <CADQ0-X-NCj03ghuGj946KtO-2nO+BdXUt5HcDz8dH5ez2WHghA@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 15 Sep 2023 09:09:35 +0300
Message-ID: <CAC_iWjLwEetNVqyCoNNaAusFMJym+ku2v5zez4hUFMOBDEadeQ@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] doc: uefi: add HTTP Boot support
To: Masahisa Kojima <masahisa.kojima@linaro.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Simon Glass <sjg@chromium.org>, Takahiro Akashi <takahiro.akashi@linaro.org>
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

On Fri, 15 Sept 2023 at 02:52, Masahisa Kojima
<masahisa.kojima@linaro.org> wrote:
>
> On Thu, 14 Sept 2023 at 22:57, Ilias Apalodimas
> <ilias.apalodimas@linaro.org> wrote:
> >
> > On Fri, Sep 01, 2023 at 07:25:42PM +0900, Masahisa Kojima wrote:
> > > This adds the description about HTTP Boot.
> > >
> > > Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
> > > ---
> > >  doc/develop/uefi/uefi.rst | 21 +++++++++++++++++++++
> > >  1 file changed, 21 insertions(+)
> > >
> > > diff --git a/doc/develop/uefi/uefi.rst b/doc/develop/uefi/uefi.rst
> > > index a7a41f2fac..fd87bb1edb 100644
> > > --- a/doc/develop/uefi/uefi.rst
> > > +++ b/doc/develop/uefi/uefi.rst
> > > @@ -594,6 +594,27 @@ UEFI variables. Booting according to these variables is possible via::
> > >  As of U-Boot v2020.10 UEFI variables cannot be set at runtime. The U-Boot
> > >  command 'efidebug' can be used to set the variables.
> > >
> > > +UEFI HTTP Boot
> > > +~~~~~~~~~~~~~~
> > > +
> > > +HTTP Boot provides the capability for system deployment and configuration
> > > +over the network. HTTP Boot can be activated by specifying::
> > > +
> > > +    CONFIG_CMD_DNS
> > > +    CONFIG_CMD_WGET
> > > +    CONFIG_BLKMAP
> > > +
> > > +Set up the load option specifying the target URI::
> > > +
> > > +    efidebug boot add -u 1 netinst http://foo/bar
> > > +
> > > +When this load option is selected as boot selection, resolve the
> > > +host ip address by dhs, then download the file with wget.
> >
> >  dhs -> dns
> OK.
>
> >  what happens if it's an IP address?
> Current implementation tries to resolve the IP address as a host name,
> so the DNS process will end up with "host not found".
> We need to preset the "httpserverip" env variable to proceed the wget.
>
> For this series, without a lwip port, this limitation should be noted here.
>
> I could take the ip address format check code from iwip or other projects,
> but I did not do that since there is a workaround(set "httpserverip"
> env variable).
> In addition, when the lwip port lands, this case is properly handled.
> If the IP address is used as host, the DNS process is skipped.

Ok, then update this with information on how to use an IP address
instead of a hostname and once LWIP lands we can update it

Thanks
/Ilias
>
> Thanks,
> Masahisa Kojima
>
> >
> > > +If the downloaded file extension is .iso or .img file, efibootmgr tries to
> > > +mount the image and boot with the default file(e.g. EFI/BOOT/BOOTAA64.EFI).
> > > +If the downloaded file extension is .efi and file is PE-COFF image,
> > > +load the downloaded file and start it.
> > > +
> > >  Executing the built in hello world application
> > >  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > >
> > > --
> > > 2.34.1
> > >
> >
> > Thanks
> > /Ilias
