Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88746E81813
	for <u-boot@archiver.kernel.org>; Tue, 26 Sep 2023 03:03:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C97C386B8F;
	Tue, 26 Sep 2023 05:03:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="S+J17wNy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D231D86B8F; Tue, 26 Sep 2023 05:03:13 +0200 (CEST)
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com
 [IPv6:2607:f8b0:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A97628691E
 for <u-boot@lists.denx.de>; Tue, 26 Sep 2023 05:03:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-577fff1cae6so5746853a12.1
 for <u-boot@lists.denx.de>; Mon, 25 Sep 2023 20:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695697390; x=1696302190; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HUse6J/YrHtwGEwreMGCMbbbre1vzy3/FI1fqXueRn0=;
 b=S+J17wNy7ETe7MKYiKWFoMlCC1k+m6zlkikYJEUkHJ/1OSx57lzSa81EEbBIC/NTIt
 plK+NCsWAWqdQVmOmoWXp1pJXNDiE4TSv/zDc8Rx+5hNZ/aj6768tGndNp7sdm5NeSl2
 2bZN7zGDZZiyg/LSnE53kJ+6E9e2PGln3T95Wp/OifIFqiFjKCA3JnIgl15J4IOYHc9L
 zOlLrWC8O6oW8itdZg6pq+3WWXlv2qSWDIBOFwpijpjRMBn9BHDiyKuhR3lI8SjMrNNo
 cj40JWLllHVsnrkj6VNg4bU/gky4HAaf+1ITyn7txKZhJxD+gvi31WUyoqSsMxsrriIX
 yH/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695697390; x=1696302190;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HUse6J/YrHtwGEwreMGCMbbbre1vzy3/FI1fqXueRn0=;
 b=E7Q7dmkd9fpzCNIp4sZAEy04GQ2qeIioPJKRFzmPjIdj7nd6A3IAS3+RTVO/sbBGbp
 8J6nHXx4orZohasmm8DIYgaPj6gcMWc/M6ocljfLCFqIDDSrnAj5OiyjU/6QRvKP65NT
 7oLAUAWM1SqPFo/eTDhnBv1z1nJUIYh5ySEfGs02YfJyV9b8ZjiYDSJIF+386WDHCZ0B
 sORqKSTIZS1o6codJ+324qasw3iGw+cb/GPzbZbPU/42XyRcDaiBXQyGEYndglRBdiJP
 skd9jJcvjHoFXIp57XS2KtKVJQvfdWQMTmgEbQUgKvmXMB6T33oS12xvRSe1kec088ch
 yDGg==
X-Gm-Message-State: AOJu0Yz0xD2UY1R4KY6dXz2g/GmsYEss1GkG3KqjCwYdfYcq4RGus2yv
 UGOyGihHJfLARJdLOYXJBPVbzzTHGMj+jlAnBvZFJggIbP03fyd8
X-Google-Smtp-Source: AGHT+IHp/z9673M6WDyGhZ1htXiJtKLZLuRbztBlYsHeyfXo6+L5leV8X7hTT5nHXDHo7lAKwsUMnDS3RIGnUTsKa+A=
X-Received: by 2002:a17:90b:2346:b0:274:8752:8fa7 with SMTP id
 ms6-20020a17090b234600b0027487528fa7mr2167254pjb.9.1695697389965; Mon, 25 Sep
 2023 20:03:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230922071119.1439482-1-masahisa.kojima@linaro.org>
 <20230922071119.1439482-8-masahisa.kojima@linaro.org> <ZRF5GbIuNg07OY7K@hera>
In-Reply-To: <ZRF5GbIuNg07OY7K@hera>
From: Masahisa Kojima <masahisa.kojima@linaro.org>
Date: Tue, 26 Sep 2023 12:02:58 +0900
Message-ID: <CADQ0-X_f9YY1nY=J=fVN6cYxSHdCH6LGcgsfLPTVhTsv2Ao1Ew@mail.gmail.com>
Subject: Re: [PATCH v4 7/8] doc: uefi: add HTTP Boot support
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
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

On Mon, 25 Sept 2023 at 21:12, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> On Fri, Sep 22, 2023 at 04:11:18PM +0900, Masahisa Kojima wrote:
> > This adds the description about HTTP Boot.
> >
> > Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
> > ---
> >  doc/develop/uefi/uefi.rst | 30 ++++++++++++++++++++++++++++++
> >  1 file changed, 30 insertions(+)
> >
> > diff --git a/doc/develop/uefi/uefi.rst b/doc/develop/uefi/uefi.rst
> > index a7a41f2fac..65eea89265 100644
> > --- a/doc/develop/uefi/uefi.rst
> > +++ b/doc/develop/uefi/uefi.rst
> > @@ -594,6 +594,36 @@ UEFI variables. Booting according to these variables is possible via::
> >  As of U-Boot v2020.10 UEFI variables cannot be set at runtime. The U-Boot
> >  command 'efidebug' can be used to set the variables.
> >
> > +UEFI HTTP Boot
> > +~~~~~~~~~~~~~~
> > +
> > +HTTP Boot provides the capability for system deployment and configuration
> > +over the network. HTTP Boot can be activated by specifying::
> > +
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
> > +There is a limitation that current implementation tries to resolve
>
> Remove the 'There is a limitation that', use The current implementation ...

OK.

>
> > +the IP address as a host name. If the uri is like "http://192.168.1.1/foobar",
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
>
> Other than the nit above
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

Thanks,
Masahisa Kojima

>
>
