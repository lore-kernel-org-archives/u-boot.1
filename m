Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61285C001B0
	for <u-boot@archiver.kernel.org>; Wed, 16 Aug 2023 10:26:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34D688671F;
	Wed, 16 Aug 2023 12:26:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="m0cSHLHH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E837E869C6; Wed, 16 Aug 2023 12:26:46 +0200 (CEST)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B6FC833F5
 for <u-boot@lists.denx.de>; Wed, 16 Aug 2023 12:26:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-4fe1489ced6so10268909e87.0
 for <u-boot@lists.denx.de>; Wed, 16 Aug 2023 03:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692181603; x=1692786403;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=d7IaW9pzYsmp3H/QoKpvRMTCJf0lidxpUlOpNYMmJcw=;
 b=m0cSHLHHgy8ivOlt+v7DC9I3iH21YaJ+eHYKlpGZxuqjonz9N7k8K+OM5jHlGKJhHL
 3bTcUN+FDnfge/ElkW6PVje0vlO4gfP/srVL2CKEo8Bp3z1TxrJ7G+K7MawyP3WKp8td
 tuxdHGOsh2eu3VTK0cDL1fhmEyPSMrF4EyvXuacaESj8K4JDWrwzQw41g6cqu0m5/Cf6
 uhH6yzvVLzMOO/B1H4Lt2baIAt6yMfB5+wvo5Z298Byas90AczSaR1tF2I2ibNJKyBj9
 btxqKdP4iZWsoTJJcHerJdyWTn17acLUOOWQewHVGBWP5c1NljjPzFK3kT98fFX1gGgo
 TKrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692181603; x=1692786403;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=d7IaW9pzYsmp3H/QoKpvRMTCJf0lidxpUlOpNYMmJcw=;
 b=PODciyfrJ63fwDyK4le2jejGU81dMlpMUKXU2qx0eFxxFv5sRX51vJzF0o/8tnoDE9
 GpfFI6jxB8MsodH1+wV6KlI8616LOVfEcYL6yw2z3IiAowlf3MxRmxW05f+7VdSSyz/Y
 jd/I0WovqRa3Z3Rg8jDTUgTBhS2k9zD1tqe2PvfGt/UFOMzhGQAjwNPUPM1KQ5NBMv7F
 o26svQJZJSamkPTo4ZJZUo71LraZXSNdvSiYqdb/YlnS/OX3aOo/BSBmdpdh5a+kCvlj
 h4GXLvaIvwCDLRaZWbsjrlwn5PZmXyfYZqteZBdWKeweXvugajtULUoHWAp2SiCLKS7A
 9MlQ==
X-Gm-Message-State: AOJu0Yy6pYH6tml2+UBjGZV1OQHMO6C0WcAb5Q5+Ps3GAgmkWrI7zRPU
 9GU3oVLcunoTuLo/6eVJ3oQT+VLVXEWQc/U+Srgg8w==
X-Google-Smtp-Source: AGHT+IHvezIYTYvKDyR1QEDRG8MF72sfYnIPD/pwmlRFTDtBAlndFOywl51VSoQg6S8LNficqW8BXxHf9Wyx2MpJk9s=
X-Received: by 2002:a05:6512:716:b0:4fd:c884:51fc with SMTP id
 b22-20020a056512071600b004fdc88451fcmr1080363lfs.58.1692181603532; Wed, 16
 Aug 2023 03:26:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230814133253.4150-1-maxim.uvarov@linaro.org>
 <20230814133253.4150-4-maxim.uvarov@linaro.org> <ZNo3+qhKIEqmdMTh@hades>
 <CAD8XO3a-C1oiZdcy_sk0DOzKwPEq7pBW6CsDeSHM-bmLE=RXHA@mail.gmail.com>
 <20230815144249.GM3630934@bill-the-cat>
In-Reply-To: <20230815144249.GM3630934@bill-the-cat>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 16 Aug 2023 13:26:07 +0300
Message-ID: <CAC_iWjJm=95uNW1y=FLkEyMpcubYa29ZLM_CZooPRT8mt+jWVg@mail.gmail.com>
Subject: Re: [PATCHv6 03/14] net/lwip: implement dns cmd
To: Tom Rini <trini@konsulko.com>
Cc: Maxim Uvarov <maxim.uvarov@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, u-boot@lists.denx.de, 
 pbrobinson@redhat.com, joe.hershberger@ni.com, rfried.dev@gmail.com, 
 goldsimon@gmx.de, lwip-devel@nongnu.org
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

On Tue, 15 Aug 2023 at 17:42, Tom Rini <trini@konsulko.com> wrote:
>
> On Tue, Aug 15, 2023 at 06:42:14PM +0600, Maxim Uvarov wrote:
> > On Mon, 14 Aug 2023 at 20:19, Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > wrote:
> >
> > [...]
> >
> >
> > > > +/*
> > > > +* This function creates the DNS request to resolve a domain host name.
> > > Function
> > >
> > > You need the name of the function as well.  Please have a look at how the
> > > rest of the code is documented.
> > >
> > > > +* can return immediately if previous request was cached or it might
> > > require
> > > > +* entering the polling loop for a request to a remote server.
> > > > +*
> > > > +* @name  dns name to resolve
> > >
> > > @name: etc
> > >
> > > > +* @varname (optional) U-Boot variable name to store the result
> > > > +* Return: ERR_OK(0) for fetching entry from the cache
> > > > +*         ERR_INPROGRESS(-5) success, can go to the polling loop
> > > > +*         Other value < 0, if error
> > > > +*/
> > > >
> > >
> >
> > Is there any command to check all the files for the comments style?
>
> I suspect if you included them in docs, htmldocs/etc would note
> problems, Heinrich?
>

Yes 'make htmldocs' blows up on errors, at least for the EFI subsystem

Cheers
/Ilias
> --
> Tom
