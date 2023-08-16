Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAC73C001E0
	for <u-boot@archiver.kernel.org>; Wed, 16 Aug 2023 11:01:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF053869CA;
	Wed, 16 Aug 2023 13:01:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Hynq2+bP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 40142869CC; Wed, 16 Aug 2023 13:01:26 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 49ED3868FC
 for <u-boot@lists.denx.de>; Wed, 16 Aug 2023 13:01:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-51e28cac164so15316852a12.1
 for <u-boot@lists.denx.de>; Wed, 16 Aug 2023 04:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692183683; x=1692788483;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=o3uusestfs7GkgB9kKZg4q6giFFNXhJvJ6nPpB1xYCc=;
 b=Hynq2+bP70lT7vMSF+k201vinWSiw1H0ELvwFymAKR6va0bmTuqhmIUMnAlfn28Tal
 qjJVWyavRKHSs8771jS/0llHRs/JUkMYlfRx8VMYxZ+vPScnoLAm94VYaS8Umu999++j
 aYCtwS4RoogIuyRIRdNh6xyRJc9EvsKsY3LQgO3ajkEEqgLiO2HzeLbgF+lpPrueZRcG
 9QXNXjkMF6tcPum/pZXNfuZj7SEnHX2oups/9uCkXoDN42fUOZ8bx8Fo4Ps43+ahD+57
 7O9duw9qWT1dawRybeZ2ydw6e7LXVtWR8a46sha5lD/Um8F4Z7BI8izp0rBuJvNliE7/
 xVPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692183683; x=1692788483;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=o3uusestfs7GkgB9kKZg4q6giFFNXhJvJ6nPpB1xYCc=;
 b=NFptFrPBrgiiBFhkaZMf/edHljn7lFF4/xW8pO1lflYXlu19/KPfbHpMe1JPG9b5Wm
 Yks9BJvU5DmAbRZg0Ko4yFBd4jXtXKe9PAWByf6GgHYQmE48BtxppIb4ka7aP4cC+DD6
 DsAXOnlmoBeW2uDTV9BpcVNfpLn/e9AkzvaBIsjK7UWYTfiyYgWYxOdtPgFecRGAwKUc
 gzjxerNmEuKqe/h3Xv96ky+e1AOZtRmU7yGoSIVKIJ/cfpRgwfbiKY7FAXF9dktdPPfv
 TzOkBkrZkb3gn1uPPzLXdKMVmgh2Urez/+UD0h4BtBhhVYx868LNpIPGNRbV7JORcyfy
 wG/A==
X-Gm-Message-State: AOJu0YycFkGAiBD/qq2rd/ff9vZAHjmeuaXi7l9eL6VtGSU5FhAJHsJq
 maYCzPaHWjt8PgFS7F4rPs4745OtSWSGF7NF/xyoxw==
X-Google-Smtp-Source: AGHT+IHzM9WtqlRsUThSUu+4n8OBEU+f7QRon3ZI/BsVzZTZPckftRekWCxXjRMOpz54xgTGzQWJN24Csf9SyThKq4E=
X-Received: by 2002:a17:906:3297:b0:994:1880:dc32 with SMTP id
 23-20020a170906329700b009941880dc32mr1949457ejw.17.1692183682733; Wed, 16 Aug
 2023 04:01:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230814133253.4150-1-maxim.uvarov@linaro.org>
 <20230814133253.4150-4-maxim.uvarov@linaro.org> <ZNo3+qhKIEqmdMTh@hades>
 <CAD8XO3a-C1oiZdcy_sk0DOzKwPEq7pBW6CsDeSHM-bmLE=RXHA@mail.gmail.com>
 <20230815144249.GM3630934@bill-the-cat>
 <CAC_iWjJm=95uNW1y=FLkEyMpcubYa29ZLM_CZooPRT8mt+jWVg@mail.gmail.com>
In-Reply-To: <CAC_iWjJm=95uNW1y=FLkEyMpcubYa29ZLM_CZooPRT8mt+jWVg@mail.gmail.com>
From: Maxim Uvarov <maxim.uvarov@linaro.org>
Date: Wed, 16 Aug 2023 17:01:11 +0600
Message-ID: <CAD8XO3a2euUOpM-JHN2p3taL=Eh=-51wyjkoDNqNFmX6pvNXfQ@mail.gmail.com>
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

On Wed, 16 Aug 2023 at 16:26, Ilias Apalodimas <ilias.apalodimas@linaro.org>
wrote:

> On Tue, 15 Aug 2023 at 17:42, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Tue, Aug 15, 2023 at 06:42:14PM +0600, Maxim Uvarov wrote:
> > > On Mon, 14 Aug 2023 at 20:19, Ilias Apalodimas <
> ilias.apalodimas@linaro.org>
> > > wrote:
> > >
> > > [...]
> > >
> > >
> > > > > +/*
> > > > > +* This function creates the DNS request to resolve a domain host
> name.
> > > > Function
> > > >
> > > > You need the name of the function as well.  Please have a look at
> how the
> > > > rest of the code is documented.
> > > >
> > > > > +* can return immediately if previous request was cached or it
> might
> > > > require
> > > > > +* entering the polling loop for a request to a remote server.
> > > > > +*
> > > > > +* @name  dns name to resolve
> > > >
> > > > @name: etc
> > > >
> > > > > +* @varname (optional) U-Boot variable name to store the result
> > > > > +* Return: ERR_OK(0) for fetching entry from the cache
> > > > > +*         ERR_INPROGRESS(-5) success, can go to the polling loop
> > > > > +*         Other value < 0, if error
> > > > > +*/
> > > > >
> > > >
> > >
> > > Is there any command to check all the files for the comments style?
> >
> > I suspect if you included them in docs, htmldocs/etc would note
> > problems, Heinrich?
> >
>
> Yes 'make htmldocs' blows up on errors, at least for the EFI subsystem
>
> Cheers
> /Ilias
>

O! Ilias thanks for the reference. First patch for doc/develop/net_lwip.rst
needed direct references:

.. kernel-doc:: include/net/lwip.h
   :internal:

to force Sphinx  to generate docs for these files. (as I understand for .c
files it does checks and for .h files it generates docs).

Without specification syntax is not validated. It will be good to do
something to check all U-Boot .h files for the common syntax later.

BR,
Maxim.




> > --
> > Tom
>
