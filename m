Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 078FDCDB46E
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 16:04:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39AEF86EBF;
	Thu, 12 Oct 2023 17:37:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hRJmtJj5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E4E186DDA; Thu, 12 Oct 2023 17:31:19 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A43B86EDA
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 17:30:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-9b95622c620so197470766b.0
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 08:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697124564; x=1697729364; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ylt/luQV8hWj3xGvqWC55CfvvLoaFE8yjReVkjVylaA=;
 b=hRJmtJj58u2cTKM4ZA4ST43K9RtiIpY5k2mlpGjqachUfivw6yPU9EIwOOdGbdI3eg
 4vsQQWHSWP7liuttZFy4v/uzPgGxjdmazxKFYZCfaqfSx9TJOFG18D+N+CwePDyQm7NP
 dGQxFPRAjTjXwVhEchLyLu87KdwKavdFulHos=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697124564; x=1697729364;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ylt/luQV8hWj3xGvqWC55CfvvLoaFE8yjReVkjVylaA=;
 b=mIJHms+WK8oxPBCbn0S5i/szQMbs/uHavT75C5FABT82Y9n0uwhATr5dXDgzoNks2Q
 ibuWBjd5gt8Lk8eC0rL8ownoEfCsh8QAK+bArkycfrO1bUanp1j78fB0sWR4Z4O9+jAL
 g8acAa6qNtoALjKLl8F5RB1hAjXog6Kdq06BiG8at9nPrADOtFoyi0aq2FPIHw8+a3ZP
 YwGzJMFlkLLd9GO1n5h06LU14vEm7VDGLBC7PX/HrW+CUQxdbikqqYJCrRYwU0zH0eES
 a46jsAi3tsyblS0rbmfVXh1JaRiSEJECuwMEV0oG2FksimenQZYU773Hpm1307fYE6V4
 yoOg==
X-Gm-Message-State: AOJu0YwpFI0NzwpM2xoMm7PbJ1B44+eYa6UP2CHRwaqXiRaY/o+UZ7Jw
 AqslTUkMoQbnk40YX53cPt1FfSYkOC+8OXJoCctYAA==
X-Google-Smtp-Source: AGHT+IGiUmTSMQDlIVLmoQfdtLlsj0J1izB4EfJHZFRdiHkE22voKmSW+cBA9JrHgF2XjVBPgVw4tj4Y522ZxQVABS0=
X-Received: by 2002:a17:906:7387:b0:9ba:a38:f2b2 with SMTP id
 f7-20020a170906738700b009ba0a38f2b2mr13524839ejl.41.1697124564170; Thu, 12
 Oct 2023 08:29:24 -0700 (PDT)
MIME-Version: 1.0
References: <20231011-binman-firewalling-v4-0-a08085d300e9@ti.com>
 <20231011-binman-firewalling-v4-1-a08085d300e9@ti.com>
 <CAPnjgZ3NG+8-VLi5i7+h4t1aP_qa1Va1ZJdhiJzfVyd7jrHPmA@mail.gmail.com>
 <20231012054600.d26hx63xaedl3dsk@ula0497581>
In-Reply-To: <20231012054600.d26hx63xaedl3dsk@ula0497581>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 12 Oct 2023 08:29:06 -0700
Message-ID: <CAPnjgZ0uw0AJC55F6hkrMZmwXt=VdKr21ngw_CSP-m_zzgJfmg@mail.gmail.com>
Subject: Re: [PATCH v4 1/8] binman: ti-secure: Add support for firewalling
 entities
To: Manorit Chawdhry <m-chawdhry@ti.com>
Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, 
 Andrew Davis <afd@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 u-boot@lists.denx.de, 
 Udit Kumar <u-kumar1@ti.com>, Praneeth Bajjuri <praneeth@ti.com>,
 Kamlesh Gurudasani <kamlesh@ti.com>, Nishanth Menon <nm@ti.com>
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

Hi Manorit,

On Wed, 11 Oct 2023 at 22:46, Manorit Chawdhry <m-chawdhry@ti.com> wrote:
>
> Hi Simon,
>
> On 20:41-20231011, Simon Glass wrote:
> > Hi Manorit,
> >
> > On Tue, 10 Oct 2023 at 23:25, Manorit Chawdhry <m-chawdhry@ti.com> wrote:
> > >
> > > We can now firewall entities while loading them through our secure
> > > entity TIFS, the required information should be present in the
> > > certificate that is being parsed by TIFS.
> > >
> > > The following commit adds the support to enable the certificates to be
> > > generated if the firewall configurations are present in the binman dtsi
> > > nodes.
> > >
> > > Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> > > ---
> > >  tools/binman/btool/openssl.py   | 16 +++++++-
> > >  tools/binman/etype/ti_secure.py | 90 +++++++++++++++++++++++++++++++++++++++++
> > >  tools/binman/etype/x509_cert.py |  3 +-
> > >  3 files changed, 106 insertions(+), 3 deletions(-)
> > >
> >
> > Reviewed-by: Simon Glass <sjg@chromium.org>
> >
> > I'm still a little worried about the error reporting if the user
> > leaves out a property. Does it do the right thing?
> >
>
> I did make a test also along the lines that would check all the
> firewalling properties and just auth-in-place isn't checked at this
> stage and people could end up adding the firewalling node without
> auth-in-place. Do you want to cover that test case as well? Regarding
> the other firewalling properties ( immitating the test by removing
> "id"), We get this:
>
> [..]
>   AR      spl/common/spl/built-in.o
>   LD      spl/u-boot-spl
>   OBJCOPY spl/u-boot-spl-nodtb.bin
>   SYM     spl/u-boot-spl.sym
>   CAT     spl/u-boot-spl-dtb.bin
>   COPY    spl/u-boot-spl.bin
>   BINMAN  .binman_stamp
> binman: id can't be None in firewall node

That's a bit vague...at least it should show the full path to the node
that failure, e.g. use self.Raise(). Also, I assume the property is
missing and the None refers to the Python value for the var. Better to
provide a nice error.

Any possible user error should ideally be checked, to avoid later confusion.

See Entry.ensure_props()

You could add an optional argument - the list of props to check. If
present it could use that instead of self.required_props

Hmm better might be to have a new function which tells the user that
since the firewall property is present, it needs these others ones
too.

Regards,
Simon
