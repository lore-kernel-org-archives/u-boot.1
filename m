Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95D63C46CD2
	for <u-boot@archiver.kernel.org>; Wed, 24 Jan 2024 06:54:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 57A9587BC3;
	Wed, 24 Jan 2024 07:54:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="RUNvaIrF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1D7687BA2; Wed, 24 Jan 2024 07:54:12 +0100 (CET)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40019877CC
 for <u-boot@lists.denx.de>; Wed, 24 Jan 2024 07:54:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sughosh.ganu@linaro.org
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-554fe147ddeso6798454a12.3
 for <u-boot@lists.denx.de>; Tue, 23 Jan 2024 22:54:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706079249; x=1706684049; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WqFzncI9zkNz1iLxkszzUD+lfmd2iv0ZRtkemTCuqzs=;
 b=RUNvaIrFIj6jyu+9WTSiVdK6stIbKJpqaaVcr9Nwm+acp+xo/wL6je5KP7OVtEjbEx
 iOyaq01QkhVK/6F9lMOqPoE7uQqmsz59K27oz8sDCIFd/29clm1y2qgR/mE6h294JSdv
 FdPsPlCCDdS4gNxFVC006NZHzqCfoAuRF6XD5rkAAo4AtqiiE0M6OD5kIgXXRItZdL+Z
 n69JOyLADyJp+UewmuCWAqyW9kbONocWlzeKVLXOc2Ib0yaY8IoybsujzQymlBAEOccd
 w/7j9KraCDU/pilD3hkZQ2sOF13FRrXGTer9tzBj8UM8ti3tzZmp0qOtpOJk2lYXC8C4
 SlAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706079249; x=1706684049;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WqFzncI9zkNz1iLxkszzUD+lfmd2iv0ZRtkemTCuqzs=;
 b=Vy+6pFOUyOz0tPsbHo9FavUtul20kGO+0oZrYnq7lmxNKLY9A0cr5IdmAm3KSrYmAH
 dgQblirXPzY5MC77XFnuWFfZr30Tm7ZNHpVH9V6ywKTvdl9rQlX+3we62hxKUCUkPyp6
 VlWtcJWep91zYVT8AiQh5mnsmMMojI8/mhNU+HV/YtiQrUgr8EG+bNw/hoLQrbouRPHu
 2KoW/1pgn6VWZbAGwErLy8xFnAn6Ezd6AQAB3/9WeK+dBxK+HTx+uzMGAx4eZBW5TbUD
 SjGH7NfXXedJoS8jVIkX4+gN5wQ/20DB7BjtnGNI/icK/SSXl+LwYPAXbXn1PQMMS771
 OfJg==
X-Gm-Message-State: AOJu0YxPMThJ+A6n3piqAUrkp4mlzOUaQjfWecUuthP6SjJPr5fHgA2y
 lAbLjvqLgtoHAybR6X7tPXg+BoXQ9zmzl9bQSRGVFoA9VDcwBeSHHMRSdS1l0Byaa2wNtTq6atD
 n905nasLn33HPDquj62S8lElDK5Tw7RHWdivtrw==
X-Google-Smtp-Source: AGHT+IGJYVBT47bs/qgPW+Qfo3prECyddxfNNSNipN96Pmg2tx2Si+O859E275YE80bGNwD2BoqMa6xeE7cMl78rssE=
X-Received: by 2002:aa7:d958:0:b0:55c:c3f9:cabd with SMTP id
 l24-20020aa7d958000000b0055cc3f9cabdmr122496eds.55.1706079249624; Tue, 23 Jan
 2024 22:54:09 -0800 (PST)
MIME-Version: 1.0
References: <20231121070028.2614095-1-sughosh.ganu@linaro.org>
 <20231121070028.2614095-3-sughosh.ganu@linaro.org> <Za_n9JVSFxnj7Mo_@hera>
In-Reply-To: <Za_n9JVSFxnj7Mo_@hera>
From: Sughosh Ganu <sughosh.ganu@linaro.org>
Date: Wed, 24 Jan 2024 12:23:58 +0530
Message-ID: <CADg8p95ttT9ORbjM6RvRr94_fmuqOg+eRmk7=zbMJ-Dk09qz9w@mail.gmail.com>
Subject: Re: [PATCH 2/4] doc: Document capsule generation through a config file
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Tom Rini <trini@konsulko.com>, 
 Masahisa Kojima <masahisa.kojima@linaro.org>
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

hi Ilias,

On Tue, 23 Jan 2024 at 21:53, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Sughosh,
>
> On Tue, Nov 21, 2023 at 12:30:26PM +0530, Sughosh Ganu wrote:
> > The UEFI capsule can now be generate by specifying the capsule
> > parameters through a config file. Additionally, the capsules can be
> > generated as part of u-boot build, through binman. Highlight these
> > changes in the documentation.
> >
> > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > ---
> >  doc/develop/uefi/uefi.rst | 70 +++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 70 insertions(+)
> >
> > diff --git a/doc/develop/uefi/uefi.rst b/doc/develop/uefi/uefi.rst
> > index fb16ac743a..b9a9ed5491 100644
> > --- a/doc/develop/uefi/uefi.rst
> > +++ b/doc/develop/uefi/uefi.rst
> > @@ -318,6 +318,76 @@ Run the following command
> >        --guid <image GUID> \
> >        <capsule_file_name>
> >
> > +Alternatively, the capsules can be generated through a config
> > +file. When generating the capsules through a config file, the Kconfig
> > +symbol CONFIG_EFI_CAPSULE_CFG_FILE is to be used for specifying the
> > +path to the config file.
>
> This sounds a bit weird. The tool is compiled and used by distros. How are
> they supposed to use the config file?
>
> Briefly looking at the patches, we use those config options on testing.
> Can't we add a flag in the tool itself that can be used for normal use
> cases and limit those Kconfig flags in our testing only?  Or alternatively
> the paths for the config files can be hardcoded for sandbox and we get rid
> of the config options entirely?

It is correct that the Kconfig symbol is used primarily for testing.
We can indeed use a fixed path for the sandbox based testing. That is
the approach that was taken for the public keys used for capsule
authentication. Will make changes to the patches accordingly. Thanks.

-sughosh

>
> Thanks
> /Ilias
> > +
> > +The config file describes the parameters that are used for generating
> > +one or more capsules. The parameters for a given capsule file are
> > +specified within curly braces, in the form of "key:value" pairs. All
> > +the parameters that are currently supported by the mkeficapsule tool
> > +can be specified through the config file.
> > +
> > +The following are some example payload parameters specified through
> > +the config file.
> > +
> > +.. code-block:: none
> > +
> > +     {
> > +         image-guid: 02f4d760-cfd5-43bd-8e2d-a42acb33c660
> > +         hardware-instance: 0
> > +         monotonic-count: 1
> > +         payload: u-boot.bin
> > +         image-index: 1
> > +         fw-version: 2
> > +         private-key: /path/to/priv/key
> > +         pub-key-cert: /path/to/pub/key
> > +         capsule: u-boot.capsule
> > +     }
> > +     {
> > +         image-guid: 4ce292da-1dd8-428d-a1c2-77743ef8b96e
> > +         hardware-instance: 0
> > +         payload: u-boot.itb
> > +         image-index: 2
> > +         fw-version: 7
> > +         oemflags: 0x8000
> > +         capsule: fit.capsule
> > +     }
> > +     {
> > +         capsule-type: accept
> > +         image-guid: 4ce292da-1dd8-428d-a1c2-77743ef8b96e
> > +         capsule: accept.capsule
> > +     }
> > +     {
> > +         capsule-type: revert
> > +         capsule: revert.capsule
> > +     }
> > +
> > +The following are the keys that specify the capsule parameters
> > +
> > +..code-block:: none
> > +
> > +    image-guid: Image GUID
> > +    image-index: Image index value
> > +    fw-version: Image version
> > +    private-key: Path to the private key file used for capsule signing
> > +    pub-key-cert: Path to the public key crt file used for capsule signing
> > +    payload: Path to the capsule payload file
> > +    capsule: Path to the output capsule file that is generated
> > +    hardware-instance: Hardware Instance value
> > +    monotonic-count: Monotonic count value
> > +    capsule-type: Specifies capsule type. normal(default), accept or revert
> > +    oemflags: 16bit Oemflags value to be used(populated in capsule header)
> > +
> > +When generating capsules through a config file, the command would look
> > +like
> > +
> > +.. code-block:: console
> > +
> > +    $ mkeficapsule --cfg-file </path/to/the/config/file>
> > +
> > +
> >  Capsule with firmware version
> >  *****************************
> >
> > --
> > 2.34.1
> >
