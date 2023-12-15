Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D49C3C4332F
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 17:49:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF01D87C4E;
	Fri, 15 Dec 2023 18:49:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="h58ebZ1S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D626887C4E; Fri, 15 Dec 2023 18:49:26 +0100 (CET)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5CE4A87C48
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 18:49:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-548ce39b101so1134921a12.2
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 09:49:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702662559; x=1703267359; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6rzXgT3JcpU0ZCA6+S2yPIvOipigaSEBKDN+yUqTsvg=;
 b=h58ebZ1ShSw97Fj/i8ddCnfrKH3faK++2AuaAq+v32Hos7TnUzM9T5GHHS5Tnd4k+V
 Im/aIC6GesimxWEIo8q33ZdY9rmvNo04QEqAnTgmMhpVgj5jcd+wmp6wVrquCzkG+eJT
 qcHMH8YZeZ0AfijmcXMNjl0JOJ9hGvjivnH7k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702662559; x=1703267359;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6rzXgT3JcpU0ZCA6+S2yPIvOipigaSEBKDN+yUqTsvg=;
 b=RtpgPAE6UA+aw+5kY3A+wGWXEmw8pVhC3yqW9MbgTJJgB1Olcr1o44N8BZfpcEPy+p
 hehDHd3H+QiSDHgOeqnPsNcNuqnD8fqQQ5OQRS9i5jQTAHhvqsSABaUsoXDCq325nUeX
 SCTKljqy1Fmtv2crGPJKExu/kn4MZQ2ScXSAPoDhN276Gfhwr/Xw+ozAhRgiROco8bRV
 XAfKhBdPhobkkk3agdM6EXeYS4RACK+GGoY+LAFXpsj1ETKgfbUu8kGAc9jYIIo0urXN
 14xn8QSMZSKWcRJZX7m77jRXPlYoRlHvcD2sU1WhyNxn0J30JbeqrfS3ArBs+jvpE+jE
 xO/A==
X-Gm-Message-State: AOJu0YyKVXzMHTyVRLaEDxhiIW1/9Qea2byDmdAo3fgz5jxfYbfELyQT
 0+3jFu0hKkLokTE+A4qL4l4AIjOvNgNoOpI4dOEk2g==
X-Google-Smtp-Source: AGHT+IFGyjippZKneYe2oPqMVPZIWZetxzhKdSmHw3rnig95CWjWegT3W1yLLPwKdDLfomV+Xkr/qW8ZkBq3FlbPYB0=
X-Received: by 2002:a17:907:2d12:b0:a19:9b79:8b45 with SMTP id
 gs18-20020a1709072d1200b00a199b798b45mr6021135ejc.86.1702662558615; Fri, 15
 Dec 2023 09:49:18 -0800 (PST)
MIME-Version: 1.0
References: <CADL8D3ZWoZpMidBTy+iSs-KOB6+LRAFVcDa-n_fVqvd00Z0=nw@mail.gmail.com>
In-Reply-To: <CADL8D3ZWoZpMidBTy+iSs-KOB6+LRAFVcDa-n_fVqvd00Z0=nw@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 15 Dec 2023 10:49:02 -0700
Message-ID: <CAPnjgZ3mbGA3_C1O1+rbWUdRSxagKoZRpbjg8TowwmjmVpGK+A@mail.gmail.com>
Subject: Re: [PATCH v4 1/8] binman: ti-secure: Add support for firewalling
 entities
To: Jon Cormier <jcormier@criticallink.com>
Cc: alpernebiyasak@gmail.com, Neha Malcom Francis <n-francis@ti.com>,
 Davis <afd@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, u-boot@lists.denx.de,
 Udit Kumar <u-kumar1@ti.com>, 
 Praneeth Bajjrui <praneeth@ti.com>, Kamlesh Gurudasani <kamlesh@ti.com>,
 nm@ti.com, Manorit Chawdhry <m-chawdhry@ti.com>
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

Hi Jon,

On Thu, 14 Dec 2023 at 14:49, Jon Cormier <jcormier@criticallink.com> wrote:
>
> Hi Manorit,
>
> This commit added a possibly unintentional dependency on python 3.9+.
>
> I ran into this while trying to build the soon-to-be-released 09.01.00.008.
>
> Build failure on ubuntu 20.04 which uses python 3.8:
> "binman: 'type' object is not subscriptable"

Thank you for reporting this. Yes, we should not require python 3.9,
even though I feel it is reasonable to give up on 3.6 at this stage.

>
> This can be fixed by:
>
> diff --git a/tools/binman/etype/ti_secure.py b/tools/binman/etype/ti_secure.py
> index f80eb542c956..872c6d38ff46 100644
> --- a/tools/binman/etype/ti_secure.py
> +++ b/tools/binman/etype/ti_secure.py
> @@ -16,7 +16,7 @@ class Firewall():
>      id: int
>      region: int
>      control : int
> -    permissions: list[hex]
> +    permissions: list
>      start_address: str
>      end_address: str
>
> > Hi Manorit,
> >
> > On Wed, 11 Oct 2023 at 23:02, Manorit Chawdhry <m-chawd...@ti.com> wrote:
> > >
> > > Hi Simon,
> > >
> > > On 11:54-20231011, Manorit Chawdhry wrote:
> > > > We can now firewall entities while loading them through our secure
> > > > entity TIFS, the required information should be present in the
> > > > certificate that is being parsed by TIFS.
> > > >
> > > > The following commit adds the support to enable the certificates to be
> > > > generated if the firewall configurations are present in the binman dtsi
> > > > nodes.
> > > >
> > > > Signed-off-by: Manorit Chawdhry <m-chawd...@ti.com>
> > > > ---
> > > [..]
> > > >  tools/binman/btool/openssl.py   | 16 +++++++-
> > > >  tools/binman/etype/ti_secure.py | 90
> > > > +++++++++++++++++++++++++++++++++++++++++
> > > >  tools/binman/etype/x509_cert.py |  3 +-
> > > >  3 files changed, 106 insertions(+), 3 deletions(-)
> > > >
> > > >  from binman.entry import EntryArg
> > > >  from binman.etype.x509_cert import Entry_x509_cert
> > > > +from dataclasses import dataclass
> > >
> > > What all python versions do we support in u-boot? I see that dataclasses
> > > are in-built from python3.7 but for older versions we would need to
> > > install them separately, do I need to add this in buildman requirements
> > > for those versions?
> >
> > I would prefer not to worry about Python 3.6 if possible. There are a
> > few workarounds in buildman for it, though.
Regards,
Simon
