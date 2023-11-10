Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E921AC4332F
	for <u-boot@archiver.kernel.org>; Fri, 10 Nov 2023 07:21:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19444877CE;
	Fri, 10 Nov 2023 08:21:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="I2gla1Ig";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2FC6C870AB; Fri, 10 Nov 2023 08:21:17 +0100 (CET)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8DBF386F69
 for <u-boot@lists.denx.de>; Fri, 10 Nov 2023 08:21:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-53b32dca0bfso3600036a12.0
 for <u-boot@lists.denx.de>; Thu, 09 Nov 2023 23:21:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699600872; x=1700205672; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ejBqfShOPC8BrZ1gHVTzyq8ygvhU+8oKfp+wsn84rxQ=;
 b=I2gla1IgrAMzbRuHavc7C7QshQfbOrHXIrinyXwDcBTOF8fwjODyAfQUv6gbBW91Ig
 NAYTK9LwWb4pjPrRGV20C5PeZNs4gcqbZ0n2KHVfXOKadn2eR1tjNfhVLvCHLE0L8tBr
 9RKjpJ7enxTMbkUgULbdBf32sH+CQx7roZaQpjIbCECsKWa+NnVLkTZhfJJvJeISRp3J
 fbJkwnJdvN8PPo9BFHMfrIDR00JdupdxH5RT8+nrjcG1WJd3Ct467ydrNkSU/efZc5RJ
 vgPmsM8Ga3g4dh+P0ewG9KtYwPYU7SDy10QQiun/3uFVB6mn6QxQWMRLjuDVRYr4RCFD
 jhAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699600872; x=1700205672;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ejBqfShOPC8BrZ1gHVTzyq8ygvhU+8oKfp+wsn84rxQ=;
 b=Vf01EKtQrOPOU6oGPQp1RteNSwgdEoNd3GkpisG1VYsrlw1Re/jFCgzzkJjQUvNZh6
 V9yrm5udEwHKxi2zkCRvVLAtKYqSlB6uHFBc/wsFR7H3mlln5k2kpkSos3nXM7hAm8Zk
 Bx2wjhHp70TQwUeDuMkE9vKGoBk2KO+/KJGmkNSyMU8zHQDDVeeyXQVcOJ5JUtZfatdL
 AXy8J0rrJVeebjIK+5Jlopy+fFNr4Q3NSfhSqdQnA7+AR5xWabNtgqarnM3FOQVm7KRe
 cqRD2yhD4XyPQoXiDMaoBmzWmXjrFtNpxpuwZSugZ7uvbTiJjg3Qdq5JNY5twx8GACrW
 wG7w==
X-Gm-Message-State: AOJu0Yyq8H2zDefTZFK7HTen/H4FrTTJ1OIJx3SwDHqYs5sGAkPUIKAs
 /++9dU9CwnwG9lZ85PIpyKkULBAwOAUgrddNxsaQLw==
X-Google-Smtp-Source: AGHT+IH0dagh2v2Pdxt4EY8ZDix07JtFkFi/1IegtRrPaquFlvpFM+04+fx48pz+uMVgRBHoHU/e0erONHAVHH8K9kc=
X-Received: by 2002:a05:6402:455:b0:544:3d4d:db15 with SMTP id
 p21-20020a056402045500b005443d4ddb15mr1262525edw.19.1699600871942; Thu, 09
 Nov 2023 23:21:11 -0800 (PST)
MIME-Version: 1.0
References: <20231110042542.3797301-1-masahisa.kojima@linaro.org>
 <20231110042542.3797301-10-masahisa.kojima@linaro.org>
 <CAC_iWjKOfqFMb+-FXqTNjAzf2nggqmhyiDbWhDjHx9FQbp=PjQ@mail.gmail.com>
In-Reply-To: <CAC_iWjKOfqFMb+-FXqTNjAzf2nggqmhyiDbWhDjHx9FQbp=PjQ@mail.gmail.com>
From: Masahisa Kojima <masahisa.kojima@linaro.org>
Date: Fri, 10 Nov 2023 16:21:01 +0900
Message-ID: <CADQ0-X8to98NJUcT1vNcr5Wtr3LnxRUhAyMWLbvn9YQ+er+hUw@mail.gmail.com>
Subject: Re: [PATCH v12 9/9] doc: uefi: add HTTP Boot support
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
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

Hi Ilias,

On Fri, 10 Nov 2023 at 15:58, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> On Fri, 10 Nov 2023 at 06:27, Masahisa Kojima
> <masahisa.kojima@linaro.org> wrote:
> >
> > This adds the description about HTTP Boot.
> >
> > Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
> > Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > ---
> >  doc/develop/uefi/uefi.rst | 30 ++++++++++++++++++++++++++++++
> >  1 file changed, 30 insertions(+)
> >
> > diff --git a/doc/develop/uefi/uefi.rst b/doc/develop/uefi/uefi.rst
> > index fb16ac743a..ca9a573669 100644
> > --- a/doc/develop/uefi/uefi.rst
> > +++ b/doc/develop/uefi/uefi.rst
> > @@ -642,6 +642,36 @@ UEFI variables. Booting according to these variables is possible via::
> >  As of U-Boot v2020.10 UEFI variables cannot be set at runtime. The U-Boot
> >  command 'efidebug' can be used to set the variables.
> >
> > +UEFI HTTP Boot
> > +~~~~~~~~~~~~~~
> > +
> > +HTTP Boot provides the capability for system deployment and configuration
> > +over the network. HTTP Boot can be activated by specifying::
> > +
>
> Since we changed depends on to select this needs to change to
> CONFIG_EFI_HTTP_BOOT which in turn will enable ...
> Again, I can fix that on merge

Yes, you are correct.
Thank you for fixing this.

Regards,
Masahisa Kojima

>
> Thanks
> /Ilias
> > +    CONFIG_CMD_DNS
> > +    CONFIG_CMD_WGET
> > +    CONFIG_BLKMAP
> > +
> > +Set up the load option specifying the target URI::
> > +
> > +    efidebug boot add -u 1 netinst http://foo/bar
> > +
> > +When this load option is selected as boot selection, resolve the
> > +host ip address by dns, then download the file with wget.
> > +If the downloaded file extension is .iso or .img file, efibootmgr tries to
> > +mount the image and boot with the default file(e.g. EFI/BOOT/BOOTAA64.EFI).
> > +If the downloaded file is PE-COFF image, load the downloaded file and
> > +start it.
> > +
> > +The current implementation tries to resolve the IP address as a host name.
> > +If the uri is like "http://192.168.1.1/foobar",
> > +the dns process tries to resolve the host "192.168.1.1" and it will
> > +end up with "host not found".
> > +
> > +We need to preset the "httpserverip" environment variable to proceed the wget::
> > +
> > +    setenv httpserverip 192.168.1.1
> > +
> >  Executing the built in hello world application
> >  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >
> > --
> > 2.34.1
> >
