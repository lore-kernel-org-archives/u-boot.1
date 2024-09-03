Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42D28CD3446
	for <u-boot@archiver.kernel.org>; Tue,  3 Sep 2024 15:54:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 954AC88A0A;
	Tue,  3 Sep 2024 17:54:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Shmtid1S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E17D88AE8; Tue,  3 Sep 2024 17:54:40 +0200 (CEST)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E686188754
 for <u-boot@lists.denx.de>; Tue,  3 Sep 2024 17:54:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-20536dcc6e9so25416145ad.2
 for <u-boot@lists.denx.de>; Tue, 03 Sep 2024 08:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725378876; x=1725983676; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Q8FJ0lzkmWPQLy8jA/QYvtR98GYEPFwnKJyJ8lFo5kQ=;
 b=Shmtid1SIMURlq2Jo7/wYsVfzi68CNgzhfCir/gG2j5lNa9iFVCIXJXlSfPHTFtZGV
 NooSWDEqh/V8J5flpdz7OlLAcpa1YztRDMj4bhYBA1hSKsHXxN7JJD7z4YcJBrIaf7mp
 sALWkqrlzDL526WEK8igduaX5wWTp3O6k2AJw7z3GNPVE9nUNf/+4fKeGxA+b9SpUCSy
 l2iBATtvFQbAQ5BWdKJ37Sh+f5+0t19mjjMSJUeHJIIeOF9N6JzNqv+R3bS+2Hc9M90C
 naLqKsg4RZZuXTOAYgeU2mG0+3MhxwUPWeI4AbeM2kT4z6jSUqeq7M9mfzKDHYJOGjsJ
 HvAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725378876; x=1725983676;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Q8FJ0lzkmWPQLy8jA/QYvtR98GYEPFwnKJyJ8lFo5kQ=;
 b=Hsj1K0czxxTEevcbloRRpGt6rURvhHo7cKd9C2ckUr4gk7evkPaiynewXEingu3e4h
 dEv0wSyVchKJ7QuZ5BvdBGBKTr/1lAt8ux8Jggpn9NXrhOGlHJX6mj6t9WnYxhXOmcsP
 iolDRjnLkrY+WDG2TlEOAXnDa4WVTd+ac1yGmU5oxVJliGITVeH/7fNb6Oxd4X1K6dwb
 P0BBui4g1/oSHO2KqfvSe5xfnC7r5aoEoXixdEd8FdmXcsWjTkqB+PAmC4CMSR4B2vxW
 VEGNP7sDBPI5NV5ZxhKU+sqvOBN+s6Hf0XGu7nPhVKR5AMjI1hyKjtrXjBcZg+gWoNKs
 8Syw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvkzSMVX7VHzkppNExEwjd42Hne3lfhRYN978Wfjyl7WuEHc85/tkVNmO0w12nHr8m9qPt9xw=@lists.denx.de
X-Gm-Message-State: AOJu0Yy1mhX4u9oQ0hn2YjT3VHcFB+w4OjTCT6czulmCsYNCQI2nLOuD
 JkZm1vR7UAOcgl/WLrIBN2gBNLW9zUoEUgSmfnXIG765oLC20Ll7MQTgnjzMgrhx1LV6MB91MV9
 /eCxnj6dUDgWKUgNu3/pbgdRv7NhYckKVqtOy+w==
X-Google-Smtp-Source: AGHT+IGYS8WtlDPLWNAgsk0jYX0St6omcmHoe0FRBbfmxLFKU6+8av5RWWrM32obk0MHa6oSAvLmQxW+dZ3Awp0SB4U=
X-Received: by 2002:a17:903:1109:b0:203:a0c5:fcfd with SMTP id
 d9443c01a7336-2050c215d63mr179984715ad.3.1725378876346; Tue, 03 Sep 2024
 08:54:36 -0700 (PDT)
MIME-Version: 1.0
References: <20240816214436.1877263-1-raymond.mao@linaro.org>
 <20240816214436.1877263-8-raymond.mao@linaro.org>
 <CAFLszTiWFD2dpb6z_5cibDe0aOpuPYug-mrC-ZiZ7v+SEDFhdQ@mail.gmail.com>
 <CAC_iWjJpfrK+-o_0x8ZJbWxhG4O-tprf1-oQvWmLZWOf=5qZMA@mail.gmail.com>
In-Reply-To: <CAC_iWjJpfrK+-o_0x8ZJbWxhG4O-tprf1-oQvWmLZWOf=5qZMA@mail.gmail.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Tue, 3 Sep 2024 11:54:25 -0400
Message-ID: <CAEfUkUKD4CC4YkU58zehmVdkUA9UwTGk3=Prpw=JHMNMYwHcHA@mail.gmail.com>
Subject: Re: [PATCH v6 07/28] hash: integrate hash on mbedtls
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 manish.pandey2@arm.com, 
 Tom Rini <trini@konsulko.com>, Stefan Bosch <stefan_b@posteo.net>,
 Mario Six <mario.six@gdsys.cc>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>, 
 Andrew Davis <afd@ti.com>, Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Sumit Garg <sumit.garg@linaro.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>, 
 "Leon M. Busch-George" <leon@georgemail.eu>,
 Igor Opaniuk <igor.opaniuk@gmail.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>, 
 Alexander Gendin <agendin@matrox.com>, Jonathan Humphreys <j-humphreys@ti.com>,
 Eddie James <eajames@linux.ibm.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
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

Hi Ilias,

On Fri, 30 Aug 2024 at 05:37, Ilias Apalodimas <ilias.apalodimas@linaro.org>
wrote:

> Hi Simon,
>
> On Thu, 29 Aug 2024 at 18:01, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Raymond,
> >
> > On Fri, 16 Aug 2024 at 15:47, Raymond Mao <raymond.mao@linaro.org>
> wrote:
> > >
> > > Integrate common/hash.c on the hash shim layer so that hash APIs
> > > from mbedtls can be leveraged by boot/image and efi_loader.
> > >
> > > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> > > ---
> > > Changes in v2
> > > - Use the original head files instead of creating new ones.
> > > Changes in v3
> > > - Add handle checkers for malloc.
> > > Changes in v4
> > > - None.
> > > Changes in v5
> > > - Add __maybe_unused to solve linker errors in some platforms.
> > > - replace malloc with calloc.
> > > Changes in v6
> > > - None.
> > >
> > >  common/hash.c | 146 ++++++++++++++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 146 insertions(+)
> >
> > I am not seeing the benefit of replacing U-Boot's hashing algorithms.
> > They work well and don't change. Also it seems to be making the code a
> > lot uglier, with an uncertain timeline for clean-up.
>
> A lot uglier where? It adds a few wrappers that fit into the current
> design and callbacks.
> I don't think what you are asking is possible. To do assymetric
> crypto, signatures  etc -- and in the future add TLS support in wget
> mbedTLS relies on its internal hashing functions for the cipher suites
> it supports. So what you are asking would just make the code even
> larger. Raymond can you please double check?
>
> Digest is the basic library of MbedTLS, I don't believe we can disable it
but only use the ones for certificates, unless MbedTLS makes changes
to allow hooking external digest libraries -  as I mentioned in a previous
reply,
I don't think this is what MbedTLS wants.

Regards,
Raymond
