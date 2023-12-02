Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86408C4167B
	for <u-boot@archiver.kernel.org>; Sat,  2 Dec 2023 18:34:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1136877C8;
	Sat,  2 Dec 2023 19:33:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jBQtoub3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8497F877CA; Sat,  2 Dec 2023 19:33:30 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A1C7F877CE
 for <u-boot@lists.denx.de>; Sat,  2 Dec 2023 19:33:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a1a5772b8a5so129357566b.1
 for <u-boot@lists.denx.de>; Sat, 02 Dec 2023 10:33:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701542008; x=1702146808; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7EeDZQ/DFTlS/jtyuO89MQQ/QJW/ycQxr+/fXfuBIwA=;
 b=jBQtoub3W58PFDffp8OgBT0XSfSxuhF//66RHb4pH210dJm3KXC9Szyw7M79aiYN3a
 77Ul2bex+3+WQvuE+NlW0NuDNHzeSFLgNi3IQ2JhslhNkbqZRTVHQXfGiNDlEwd7mrk+
 DmR+DIS5b5YzbEFTk+0iFbqGM/NB6PQ40jBn8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701542008; x=1702146808;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7EeDZQ/DFTlS/jtyuO89MQQ/QJW/ycQxr+/fXfuBIwA=;
 b=ibmoHZIM/Z/fhx7YD4njfi+mdgBck7iqsBBZiJRcIz5bvM2xCL7vei2hg6PBvdpuvk
 mijwNdf7gQ50aNjRfOBElJxen12bwleFvqP0OSGnsgRGZeglZMeXoST4PYfH5q3s9cQX
 CXRMn4frkEYx+m9scxGwYAYnQEIhEy9VXP7ptXvtHQ4uXV0AH8cyNBEPJwc1c8U43+qZ
 dYgk+oe2F+Vjuc3D71CrNkmKyzvixCxIzCqKYJ5LB3taOSwpZBjNkVuQvPi9xqe3J57G
 O0TqTOC1zLh1GV3l6zwMgGaz4eqG4eBJ/1GOKP0hwaVIkRfFOdkJ303KDexwb4yEoZTO
 ARhw==
X-Gm-Message-State: AOJu0Yy5wU5hadhASfUnisrhLyTkctbZkOJwhKVutGn0dHnfasM91tiY
 EIbuOMqqeV181gnJc5St47e1D4uJ1g14topOePgKpgaHB5HK9pG6yameHQ==
X-Google-Smtp-Source: AGHT+IFfHzg4dZsOlFT4VAA1MAMmyUn7buG9na/9sTHKU11J2awSJrl9XLcfW6IqIe1KGhPL2cPOawd+Gd8FtrFeA0k=
X-Received: by 2002:a17:906:3f0a:b0:9bd:a75a:5644 with SMTP id
 c10-20020a1709063f0a00b009bda75a5644mr1937596ejj.16.1701542007935; Sat, 02
 Dec 2023 10:33:27 -0800 (PST)
MIME-Version: 1.0
References: <20231121113557.800353-1-sjg@chromium.org>
 <20231121113557.800353-7-sjg@chromium.org>
 <07051882-8b13-4878-8f6f-1fe31fe97467@gmx.de>
 <CAPnjgZ3fv_NgDOAA-GdQD084ZTkKi5ZfO2kpUoNDVi9=Ar1iFA@mail.gmail.com>
 <CAC_iWjJSU7sdkOWBdoqn90koNjj1HyxPL4VrDR10FPtPHGA-AQ@mail.gmail.com>
In-Reply-To: <CAC_iWjJSU7sdkOWBdoqn90koNjj1HyxPL4VrDR10FPtPHGA-AQ@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 2 Dec 2023 11:33:10 -0700
Message-ID: <CAPnjgZ2omjthBNYkZP-1sj_14tFr=xBjBRTJmkfv-haKuzDrzA@mail.gmail.com>
Subject: Re: [PATCH 6/7] WIP: efi: Allow helloworld to exit boot services
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>
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

On Wed, 22 Nov 2023 at 00:39, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Simon,
>
> On Wed, 22 Nov 2023 at 00:10, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Heinrich,
> >
> > On Tue, 21 Nov 2023 at 10:17, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> > >
> > > On 11/21/23 12:35, Simon Glass wrote:
> > > > This allows testing of the exit_boot_services call, providing more
> > > > coverage of the EFI bootmeth.
> > > >
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > >
> > > I would prefer to keep helloworld.efi benign.
> > >
> > > Please, create a new EFI binary for testing ExitBootServices().
> >
> > Eek...isn't helloworld already used in tets?\
>
> Yes, but calling exitboot services from it means we need to be really
> careful when/how we call it, since once that app runs the boottime
> services along with any attached disks will disappear.
> Instead having a single EFI app that calls that and then tests for any
> runtime services is more scalable

OK I can add a new app.

I am still stuck on the actual bug mentioned in the cover letter, though.

Regards,
Simon
