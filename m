Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E288C52D7C
	for <u-boot@archiver.kernel.org>; Sun, 18 Aug 2024 15:47:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C054788906;
	Sun, 18 Aug 2024 17:47:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="f3YZqHNe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D906288908; Sun, 18 Aug 2024 17:47:15 +0200 (CEST)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 687E088852
 for <u-boot@lists.denx.de>; Sun, 18 Aug 2024 17:47:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-6bf66fe9d8bso18477026d6.0
 for <u-boot@lists.denx.de>; Sun, 18 Aug 2024 08:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723996032; x=1724600832; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yeaCw9SDAHWl1jFzyFs8LzEYISIskMB1Dfz9qWOdJ1M=;
 b=f3YZqHNeYxcWmPFXvjHLCA6TcbkbxTTUwtydr11aIvV8uMVL5qCfgbC4dab8ZWn9fQ
 xUA7UYQblPl1P85iAulPZUik7w4o16u9qEzCrgUrD/iHcjGF3QVr9TeQIwD3cZ7PgwZc
 gMhIzEHWR7IF/IBuWQoJ/lMI1ZLoc4KD5Z7rI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723996032; x=1724600832;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yeaCw9SDAHWl1jFzyFs8LzEYISIskMB1Dfz9qWOdJ1M=;
 b=HiOId+NJ7ZONg3pPoxehAQSboqWR3FcJghgNGvTUMQ1URCpehN+8EgFYzI9p0DtzZv
 qyl7LoECZPchS61iEOgcHMz30HODNFAXKGIpz+7jB6dY+iUeOaowCSVxvHBCXX0AOleS
 wtFOn7fVNiVJD0EUHGHCF8wZ893aEq1aQBu1YZNUHS/LvQ0/KIA/b6dxsvivdGL4pK0b
 WXuP65PTPWGHM164vA9tl3CWktIXXbzr5GmYfyTwOATrN0P7ozvAzY+fYJxgFE9QjwG1
 r5UrENSvrI/efDs05zPNYvVX1r5ZIVN8UzjT7UD3n15OiWziY6T1x03kQitBu0PQhHer
 CIUA==
X-Gm-Message-State: AOJu0YyWcc73C1DFqBT69Er3FjosOKTKBbvEHMSucFnrODZs8BTZiffH
 IRP3Z4Kw9R9US1+bYZ8QPh/3a6aD7tq2YBighOyiO5ATwJKsC3R5TKukkJdI+b3byJr6N0pJxhu
 09oc5NYTXWQ470DVLbtzC5cow1v1/bIsFcrDy
X-Google-Smtp-Source: AGHT+IFi1Vyud7fGqxo6cuG5iQMDry1j3CiCwX73ErtMVMWyyYcJyRjanFC9Fqtd/LWP2R3Sf5zvLocuEgavPTCi+mM=
X-Received: by 2002:a05:6214:53c2:b0:6b7:b286:e826 with SMTP id
 6a1803df08f44-6bf7ced5756mr74437226d6.38.1723996032336; Sun, 18 Aug 2024
 08:47:12 -0700 (PDT)
MIME-Version: 1.0
References: <20240802093322.15240-1-richard@nod.at>
 <1796341.KUTt5R2Mg1@somecomputer>
 <CAFLszThjZKm+=J2oBGeTUYt_fZxbu5KXzGYXXJnnuXaCD2322w@mail.gmail.com>
 <3292219.QWXsJ6tzlI@somecomputer>
In-Reply-To: <3292219.QWXsJ6tzlI@somecomputer>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 18 Aug 2024 16:47:01 +0100
Message-ID: <CAFLszThXOBKECTPy9nCLR5VYHVz6iauOVFYK9ZCai5CJZa2U3g@mail.gmail.com>
Subject: Re: [PATCH 1/3] test_fs: Allow running unprivileged
To: Richard Weinberger <richard@sigma-star.at>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Richard Weinberger <richard@nod.at>, upstream+uboot@sigma-star.at, 
 Francis Laniel <francis.laniel@amarulasolutions.com>, 
 Guillaume La Roque <glaroque@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Christian Taedcke <christian.taedcke@weidmueller.com>
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

Hi Richard,

On Sun, 18 Aug 2024 at 16:37, Richard Weinberger <richard@sigma-star.at> wrote:
>
> Simon,
>
> Am Sonntag, 18. August 2024, 17:25:37 CEST schrieb Simon Glass:
> > > So, can we please have mkimage inside the Docker image?
> >
> > Sorry about all your trouble. Perhaps we should add a comment about
>
> No need to worry. :)
>
> > specifically what the code is for. Also, once you get all this in, we
> > can perhaps remove the fallbacks. I still get errors from qemu-img on
>
> I hope we can remove all these fall backs.
> IMHO, unit tests have to behave always the same way.

Indeed.

>
> > Ubuntu unless I chmod a+r /boot/* but presumably you don't use that
> > tool.
>
> On recent Ubuntu releases this should be resolved:
> https://bugs.launchpad.net/ubuntu/+source/libguestfs/+bug/1673431
>
> > For mkinage, it would be better to use the version that is built in
> > CI, for sandbox. That is how the tools tests work.
>
> True that!
> Off the head, I don't know how to achieve this, but my knowledge of
> the Azure pipeline setup is limited.

In that file, this is the line that builds the tools:

          ./tools/buildman/buildman -T0 -o ${UBOOT_TRAVIS_BUILD_DIR}
-w --board tools-only

and this adds the built scripts/dtc to the path, but you could just as
easily add tools/

          export PATH=${UBOOT_TRAVIS_BUILD_DIR}/scripts/dtc:${PATH}

Regards,
Simon
