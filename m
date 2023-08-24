Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53152C27C40
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 14:50:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 97FEE86504;
	Thu, 24 Aug 2023 16:50:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="rrjyGcaF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A2B2486672; Thu, 24 Aug 2023 16:50:35 +0200 (CEST)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com
 [IPv6:2a00:1450:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E03386504
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 16:50:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2b703a0453fso112759881fa.3
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 07:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692888632; x=1693493432;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Roq0PwkIZZJH0Jk4cYXftNPetkb9AhGhzGmbAUAeOp4=;
 b=rrjyGcaFWRgNcVFbg/fkW5220wdEhtAKUcCB6uHtMsekuQ8xhF7iWNLVACIaLqHrE5
 G1H6ZDCil8cpdMRTIZ3EOSWHgtGlVMJ/sOAZcAkloY4NVsCE8D9znL/sREyH4dlLYa9V
 0S95lFVbmSePYZTXaCiDFfvrVJOTgsEtNYCyTAwTwGuKw1AVU+izxENQn6dJ5a+Pqh2H
 TbXARGfcLNBolJjzeaCPT9gI8L8+vbBOT+y4cV2Zt58K/bGKIOXRuvmvfY3yyb/2GsGz
 r3irou1sCPWaJ10bypIpCSdFgkzmBjTUUhGMrO/h9Hi/xsIXEsBkjxeZb4Qx2oLNFCok
 xlAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692888632; x=1693493432;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Roq0PwkIZZJH0Jk4cYXftNPetkb9AhGhzGmbAUAeOp4=;
 b=AYpyN3i9B8n7AjI83/iesrKLTG5OwsUgInMx2O47Ijx290U3C6fyGYkuKrfOjF4kFx
 2NWTBobd2Avh1i/WIG+sqYj7lW42gzzid2iR7aIOOAKJ2rUfR/UXho//OMYGYMWeYh6g
 9yJYkHvqiDJJjrdXt1grQwqU0M8X41rbgo876SCTSCYmPScpH7fjQkdSnNROjfUS/3sE
 mkaKqM5bmOo9qr08RZaUqP5qILNAZIPNXGRstTBo3gqjOTHiQRyuuabjNqpXcv7++bFz
 DSxA1wEheerWA2wJvqSiQwmbGeKf9KSjS0525OgDdJbCTYJacxg0QPBBlp5P6a4iN5Z4
 jj7w==
X-Gm-Message-State: AOJu0Yx2VZAX6NU9eoMHI1pT57STJoEvZ6DyM4pkfezsyMhoDbc4+uvN
 zG6A/sg19qNZ4jWu9aW/SAc6ViwLTiwtmCqF57ujxg==
X-Google-Smtp-Source: AGHT+IEBT+iGZ3fYrGmuzEgcg69sy7Z9az/Zc4hpZeUSMFniff5qjZQybdTX2HL0xc7a1w5JgLqieHgWqfeQXDGYthI=
X-Received: by 2002:a05:6512:12c4:b0:4f8:74b5:b4ec with SMTP id
 p4-20020a05651212c400b004f874b5b4ecmr12777550lfg.41.1692888631667; Thu, 24
 Aug 2023 07:50:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230824142109.2401528-1-ilias.apalodimas@linaro.org>
 <CAPnjgZ0JZCrPOCUZDgL10zXdB+LQQtv2MXZPcpcxXDY+u8MhHw@mail.gmail.com>
 <CAC_iWjLWQhZrZkhK02dS=gQG7Z7y2-cQ6LtKnnrm3tur3J4KPA@mail.gmail.com>
In-Reply-To: <CAC_iWjLWQhZrZkhK02dS=gQG7Z7y2-cQ6LtKnnrm3tur3J4KPA@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 24 Aug 2023 17:49:55 +0300
Message-ID: <CAC_iWjJm9r3cgBX5fuANp_BwJzi4r_jdXgFMDYRw3V=1QYjiog@mail.gmail.com>
Subject: Re: [PATCH v2] efi_loader: delete handle from events when a protocol
 is uninstalled
To: Simon Glass <sjg@google.com>
Cc: u-boot@lists.denx.de, xypron.glpk@gmx.de
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

On Thu, 24 Aug 2023 at 17:47, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Simon,
>
> On Thu, 24 Aug 2023 at 17:41, Simon Glass <sjg@google.com> wrote:
> >
> > Hi Ilias,
> >
> > On Thu, 24 Aug 2023 at 08:21, Ilias Apalodimas
> > <ilias.apalodimas@linaro.org> wrote:
> > >
> > > When a notification event is registered for a protocol the handle of the
> > > protocol is added in our event notification list.  When all the protocols
> > > of the handle are uninstalled we delete the handle but we do not remove
> > > it from the event notification list.
> > >
> > > Clean up the protocol removal functions and add a wrapper which
> > > - Removes the to-be deleted handle from any lists it participates
> > > - Remove the handle if no more protocols are present
> > >
> > > Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > > ---
> > > Changes since v1:
> > > - use the non safe list traversing macros on efi_register_notify_events since
> > >   we don't delete anythig from that list
> > > - Add a comment explaining the code that preserves the handle in case of a
> > >   removal failure
> > >
> > >  lib/efi_loader/efi_boottime.c | 89 +++++++++++++++++++++++++----------
> > >  1 file changed, 65 insertions(+), 24 deletions(-)
> >
> > Is there a test for this behaviour?
>
> Not in -master.  I've sent it in the past [0].  But instead of merging
> that series, we decided with Heinrich that a bigger cleanup was
> needed.
> So we had to do a bigger cleanup of protocol handling [1] [2]
>

Forgot the first link... apologize for the noise
[0] https://lore.kernel.org/u-boot/20230601120625.1843555-2-ilias.apalodimas@linaro.org/

> [1] https://lore.kernel.org/u-boot/20230620061932.113292-1-ilias.apalodimas@linaro.org/
> [2] https://lore.kernel.org/u-boot/a222ec75-32ef-9dce-0855-afde2702c618@gmx.de/
>
> Once the last part gets merged, I'll rebase the test and send it over
>
> Thanks
> /Ilias
> >
> > Regards,
> > Simon
