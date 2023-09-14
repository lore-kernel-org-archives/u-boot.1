Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 598CFEEAA7D
	for <u-boot@archiver.kernel.org>; Thu, 14 Sep 2023 23:52:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6BAE986679;
	Fri, 15 Sep 2023 01:52:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="J3iGCdkI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5CEA886741; Fri, 15 Sep 2023 01:52:34 +0200 (CEST)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com
 [IPv6:2607:f8b0:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 361DE8660B
 for <u-boot@lists.denx.de>; Fri, 15 Sep 2023 01:52:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=masahisa.kojima@linaro.org
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-68fb79ef55eso1418220b3a.0
 for <u-boot@lists.denx.de>; Thu, 14 Sep 2023 16:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694735550; x=1695340350; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UHPvkeUuk9EmQ8js9iGy4EauLX0D+z+/I+13SK4L3PY=;
 b=J3iGCdkIGX9Ypph+eSFRfRR9O5/dk+VXXyDIL/DRcVbBZmRRbMsM8L/CAupAjS7Cs+
 th9NJzuMYiGGXrXcttM4Infx3WhVO+ffMUvOpyf1F3NMAYc6cX6nTs0nNb37h3AsMEoq
 L9rqY6eYPusyA0cHmv++ea73Nd0MfN/UhNgZSNzDlElbWKRE+vv139uWKhghh/gUQ5RZ
 oQNioRiJ7DQ3616fbWEHzY8UfUZ2h1WaZXY7fDVjB40gaKb0Ym4oXWFUhL/3AFeZ7KLk
 CrncQlV/TQbzNXwdCEhfF+uYt6kiLkealiEXTbkhiOfRRshRxwTXBvFxAqI8EDPfb1Cr
 Fa7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694735550; x=1695340350;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UHPvkeUuk9EmQ8js9iGy4EauLX0D+z+/I+13SK4L3PY=;
 b=gM+eOj5TU2wf619Yf4gtO1lX5U2t0KpAu/bkOJzG3HR9FkV8BV9hTR5Pajdza0IeAG
 fqp9//NySzfuNbZ3pyF7fOqOIg1dCv4VzPH5XYq9J6qriQg8e5waCEYhmAK6aeeM+oCM
 xVxf1LjSMEaM/rQ57r98h+MT3n/jTmWhut9bOUghZrY0MoQZ1u/82RizywMvoJsqnn1K
 uhR5u+2pSYkxoZywbhZVzoYpXcuCsNPyKIOSszEv3tH+WnxA2MsfJMLubGIXU5//dZmw
 dZzGrqy9ssk1u6u8F7/1376oOqIQgygIwu1MbDGJ1y0YF2v5jZVhKjgZaWgR1G7nSse5
 jLTg==
X-Gm-Message-State: AOJu0Yw2oLMoUzAJ7EwfA1FTZvrEIYHx8TIZlbb60KOpKu7DjwfNhpzN
 DwdunKzDXhXHivutdwZBVjBqydS5FoUol03EPQwRpQ==
X-Google-Smtp-Source: AGHT+IFzvYVzI6xaJlQduEo6HYUtjKura2sQ33IdzRP6XHp2V4faqqTPJgdOShgD4lFnX0XDYNkY2OxtfN78FqsH8+o=
X-Received: by 2002:a05:6a20:938a:b0:14e:9092:4291 with SMTP id
 x10-20020a056a20938a00b0014e90924291mr373469pzh.7.1694735550409; Thu, 14 Sep
 2023 16:52:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230901102542.609239-1-masahisa.kojima@linaro.org>
 <20230901102542.609239-7-masahisa.kojima@linaro.org> <ZQMRRQ4zOnKUU4WK@hera>
In-Reply-To: <ZQMRRQ4zOnKUU4WK@hera>
From: Masahisa Kojima <masahisa.kojima@linaro.org>
Date: Fri, 15 Sep 2023 08:52:19 +0900
Message-ID: <CADQ0-X-NCj03ghuGj946KtO-2nO+BdXUt5HcDz8dH5ez2WHghA@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] doc: uefi: add HTTP Boot support
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

On Thu, 14 Sept 2023 at 22:57, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> On Fri, Sep 01, 2023 at 07:25:42PM +0900, Masahisa Kojima wrote:
> > This adds the description about HTTP Boot.
> >
> > Signed-off-by: Masahisa Kojima <masahisa.kojima@linaro.org>
> > ---
> >  doc/develop/uefi/uefi.rst | 21 +++++++++++++++++++++
> >  1 file changed, 21 insertions(+)
> >
> > diff --git a/doc/develop/uefi/uefi.rst b/doc/develop/uefi/uefi.rst
> > index a7a41f2fac..fd87bb1edb 100644
> > --- a/doc/develop/uefi/uefi.rst
> > +++ b/doc/develop/uefi/uefi.rst
> > @@ -594,6 +594,27 @@ UEFI variables. Booting according to these variables is possible via::
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
> > +host ip address by dhs, then download the file with wget.
>
>  dhs -> dns
OK.

>  what happens if it's an IP address?
Current implementation tries to resolve the IP address as a host name,
so the DNS process will end up with "host not found".
We need to preset the "httpserverip" env variable to proceed the wget.

For this series, without a lwip port, this limitation should be noted here.

I could take the ip address format check code from iwip or other projects,
but I did not do that since there is a workaround(set "httpserverip"
env variable).
In addition, when the lwip port lands, this case is properly handled.
If the IP address is used as host, the DNS process is skipped.

Thanks,
Masahisa Kojima

>
> > +If the downloaded file extension is .iso or .img file, efibootmgr tries to
> > +mount the image and boot with the default file(e.g. EFI/BOOT/BOOTAA64.EFI).
> > +If the downloaded file extension is .efi and file is PE-COFF image,
> > +load the downloaded file and start it.
> > +
> >  Executing the built in hello world application
> >  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >
> > --
> > 2.34.1
> >
>
> Thanks
> /Ilias
