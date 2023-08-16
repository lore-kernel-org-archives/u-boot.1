Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08962C04A94
	for <u-boot@archiver.kernel.org>; Wed, 16 Aug 2023 12:25:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C8F386380;
	Wed, 16 Aug 2023 14:25:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="TrCexZYx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 74D4D84702; Wed, 16 Aug 2023 14:25:04 +0200 (CEST)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9F3DE866D0
 for <u-boot@lists.denx.de>; Wed, 16 Aug 2023 14:24:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-99c3c8adb27so879397066b.1
 for <u-boot@lists.denx.de>; Wed, 16 Aug 2023 05:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692188698; x=1692793498;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pecrsmtV5lVMsQ/rnskKJeF55d89TUE4j7Uj46gSmjg=;
 b=TrCexZYx2skd+ZCa/1tfqrNgPzl0+FdxB255+VFGo+ULHyJp07FkwUPhjqFszftKee
 HoRes0ary8am2nG0y8qnqlcSIETmW6Pr49LOcl3QMbM/bl+lO1Gnidq9DmzsaH7mPd6r
 GTi5Vyj+UXAHzpNqOyDktJv5ZM76FdwsqQMckD331Biw/gpH069fxm0uoSga5DjlSH/H
 /xGTcWoMjIBq9IoBmabGGGSsPx8Z3KH7khhm9l1BjAlQL7ZPojQDkF8RtMn4XmRGMn+Q
 gN5cFcUYctJ6+qEJ4R4LjlFktpM5BDkBCnu3WsZakyhCz73vHyzNeoW0QNiOuvQlPg9U
 xwZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692188698; x=1692793498;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pecrsmtV5lVMsQ/rnskKJeF55d89TUE4j7Uj46gSmjg=;
 b=MxWjFDMU4klmDiM3BWzLcYTqDQ3ta3WgHZMAiKdbfe3VteWt3jnAhq4V0BFtFvNeDV
 ZOiuLOIe1C7pfE4h72y8Yse9/7HNwp0oUtVvQjOH10bVwxH511KSwDbopmFIGA1OQBeZ
 HoN5d1o/cMCQ+dKPzub3PWrI7rqyUMDiT76UlRij/96tgz/OdKaiyKV8oOyOriHDQGJI
 gi+Fj6uhov/Fs0OUs4kwMT0W8Bt1LTK2KwkMPIhGpRIZUTZeBL5hqWSpje0HEbe0c4+P
 OaWINZ3h6QOb1eaadS2mj+VCB/74giRfTG3YtRbFTsSmeMaNNo/dqTnwcx5/vOxDNB5e
 cGxw==
X-Gm-Message-State: AOJu0YyrgAufuKw5WybUR1DKkC1fFPN2OPlUsRrys2Lwu5j5V4wWzZZ/
 pLaH6ODoGTapc2OF6Qhbl/IANdzvt2Ok9+sY/kQo4A==
X-Google-Smtp-Source: AGHT+IE/alSSD5GiSr1pQq5C7NHIN2Q/hRotSoOj2wfiaZTcS9MClXRfrshCywKU0mmZqM4BY/CyNzMfJCMTo+6AvJk=
X-Received: by 2002:a17:906:209e:b0:99c:b65b:54e2 with SMTP id
 30-20020a170906209e00b0099cb65b54e2mr1470488ejq.55.1692188698184; Wed, 16 Aug
 2023 05:24:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230814133253.4150-1-maxim.uvarov@linaro.org>
 <20230814133253.4150-4-maxim.uvarov@linaro.org> <ZNo3+qhKIEqmdMTh@hades>
 <CAD8XO3a-C1oiZdcy_sk0DOzKwPEq7pBW6CsDeSHM-bmLE=RXHA@mail.gmail.com>
 <20230815144249.GM3630934@bill-the-cat>
 <CAC_iWjJm=95uNW1y=FLkEyMpcubYa29ZLM_CZooPRT8mt+jWVg@mail.gmail.com>
 <CAD8XO3a2euUOpM-JHN2p3taL=Eh=-51wyjkoDNqNFmX6pvNXfQ@mail.gmail.com>
 <CAC_iWjLXDCCx6oksQgOy+OBrrVCWwJkRMbEo8+gr0btdY5D6Jw@mail.gmail.com>
In-Reply-To: <CAC_iWjLXDCCx6oksQgOy+OBrrVCWwJkRMbEo8+gr0btdY5D6Jw@mail.gmail.com>
From: Maxim Uvarov <maxim.uvarov@linaro.org>
Date: Wed, 16 Aug 2023 18:24:46 +0600
Message-ID: <CAD8XO3bCckd-42zixaPZ3V_7Bj0HHgVVUhjSmExLb4ONPd5DAw@mail.gmail.com>
Subject: Re: [PATCHv6 03/14] net/lwip: implement dns cmd
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 u-boot@lists.denx.de, 
 pbrobinson@redhat.com, joe.hershberger@ni.com, rfried.dev@gmail.com, 
 goldsimon@gmx.de, lwip-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

On Wed, 16 Aug 2023 at 17:54, Ilias Apalodimas <ilias.apalodimas@linaro.org>
wrote:

> On Wed, 16 Aug 2023 at 14:01, Maxim Uvarov <maxim.uvarov@linaro.org>
> wrote:
> >
> >
> >
> > On Wed, 16 Aug 2023 at 16:26, Ilias Apalodimas <
> ilias.apalodimas@linaro.org> wrote:
> >>
> >> On Tue, 15 Aug 2023 at 17:42, Tom Rini <trini@konsulko.com> wrote:
> >> >
> >> > On Tue, Aug 15, 2023 at 06:42:14PM +0600, Maxim Uvarov wrote:
> >> > > On Mon, 14 Aug 2023 at 20:19, Ilias Apalodimas <
> ilias.apalodimas@linaro.org>
> >> > > wrote:
> >> > >
> >> > > [...]
> >> > >
> >> > >
> >> > > > > +/*
> >> > > > > +* This function creates the DNS request to resolve a domain
> host name.
> >> > > > Function
> >> > > >
> >> > > > You need the name of the function as well.  Please have a look at
> how the
> >> > > > rest of the code is documented.
> >> > > >
> >> > > > > +* can return immediately if previous request was cached or it
> might
> >> > > > require
> >> > > > > +* entering the polling loop for a request to a remote server.
> >> > > > > +*
> >> > > > > +* @name  dns name to resolve
> >> > > >
> >> > > > @name: etc
> >> > > >
> >> > > > > +* @varname (optional) U-Boot variable name to store the result
> >> > > > > +* Return: ERR_OK(0) for fetching entry from the cache
> >> > > > > +*         ERR_INPROGRESS(-5) success, can go to the polling
> loop
> >> > > > > +*         Other value < 0, if error
> >> > > > > +*/
> >> > > > >
> >> > > >
> >> > >
> >> > > Is there any command to check all the files for the comments style?
> >> >
> >> > I suspect if you included them in docs, htmldocs/etc would note
> >> > problems, Heinrich?
> >> >
> >>
> >> Yes 'make htmldocs' blows up on errors, at least for the EFI subsystem
> >>
> >> Cheers
> >> /Ilias
> >
> >
> > O! Ilias thanks for the reference. First patch for
> doc/develop/net_lwip.rst needed direct references:
> >
> > .. kernel-doc:: include/net/lwip.h
> >    :internal:
> >
> > to force Sphinx  to generate docs for these files. (as I understand for
> .c files it does checks and for .h files it generates docs).
> >
> > Without specification syntax is not validated. It will be good to do
> something to check all U-Boot .h files for the common syntax later.
>
> You need comments that look like this
>   /**
>    * parse_event_log_header() -  Parse and verify the event log header
> fields
>    *
>    * @buffer:                     Pointer to the start of the eventlog
>    * @size:                       Size of the eventlog
>    * @pos:                        Return offset of the next event in
> buffer right
>    *                              after the event header i.e specID
>    *
>    * Return:      status code
>    */
>
> Cheers
> /Ilias
>


Yes, I added html generation for these files and now I can fix style.


> >
> > BR,
> > Maxim.
> >
> >
> >
> >>
> >> > --
> >> > Tom
>
