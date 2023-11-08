Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 101BEC4332F
	for <u-boot@archiver.kernel.org>; Wed,  8 Nov 2023 04:28:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 797068771F;
	Wed,  8 Nov 2023 05:27:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="D3IstS+K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D298D8768F; Wed,  8 Nov 2023 05:27:00 +0100 (CET)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8FACD8774B
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 05:26:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-5b3b17d36d5so3802057b3.0
 for <u-boot@lists.denx.de>; Tue, 07 Nov 2023 20:26:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699417612; x=1700022412; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yUMeVsx3TLe1t+IGIF10643iP8yaPTtML6d4xe086CI=;
 b=D3IstS+K1B/QhgEM1Uu/tKAusRMoCu5IrrUDRAhzHWtz8MenviqdWDEOdApJ9hqKU8
 fR5zdJNLD43mX8xd01/RNQKFNoFD2uGfYlyCQhDQJAeYlDgm2iiIkZXG4r203aCPgIIa
 xFLUCQbMWlFnmDek6oeaTPOPH61W9vC32u2xI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699417612; x=1700022412;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yUMeVsx3TLe1t+IGIF10643iP8yaPTtML6d4xe086CI=;
 b=tIMPkhswzSu32ba3CyunexMJu5rsdoiOtfp5hAhfp4jXA9bm6JjjUYDpyMEySckyAh
 +VS94VMMPQGFoMT20hMfV4p3La3qixpg+PW6Cr/Ght/onczw7HxRt7Jawqtk7LDJn0Y9
 OujiZooYhdiMhaZylDRjT7OsR0ZOc4niOg1RiRyRlchfbkbJZcRAa3pm+jC3mNfaqSDh
 snWOlBg7DlyhW/TEXsuf/fM2qIFPfjP76srqJQwbgq4v8dMoaDowm3c9L8GxxFAXG/Ge
 oHWEdtWuuVXn3PuG9+D+8WeZm8rrYhE2/GHCNdL/YAXIEBlMEKQd55RN5BpaaAlMK/CZ
 pE+Q==
X-Gm-Message-State: AOJu0YxSzhF6Kj0ChCC3ZrXpPDyOKXK3EE2tnUx67tFEUkNE2/nQUniR
 ut0syZW/iBNoYSqS4hXaHwxAVtT2HXuGNHc/KWV9ew==
X-Google-Smtp-Source: AGHT+IFw7CdmtYcnUSAzwhyXaVy7TXESiDCcMGKd6iDuU64MvZdeTwLMdxfBEvq1jGD0B6K0RX7wlWGBkRuDomClbck=
X-Received: by 2002:a0d:e64f:0:b0:5b0:4055:73dc with SMTP id
 p76-20020a0de64f000000b005b0405573dcmr3224836ywe.14.1699417612117; Tue, 07
 Nov 2023 20:26:52 -0800 (PST)
MIME-Version: 1.0
References: <20231011-binman-firewalling-v4-0-a08085d300e9@ti.com>
 <20231011-binman-firewalling-v4-1-a08085d300e9@ti.com>
 <CAPnjgZ3NG+8-VLi5i7+h4t1aP_qa1Va1ZJdhiJzfVyd7jrHPmA@mail.gmail.com>
 <20231012054600.d26hx63xaedl3dsk@ula0497581>
 <CAPnjgZ0uw0AJC55F6hkrMZmwXt=VdKr21ngw_CSP-m_zzgJfmg@mail.gmail.com>
 <20231107094003.isopuizzblaaayp2@ula0497581>
In-Reply-To: <20231107094003.isopuizzblaaayp2@ula0497581>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 7 Nov 2023 21:23:45 -0700
Message-ID: <CAPnjgZ0b457Db2xqS7+EMemtuH=CiUQGkU=oPB_M4=VMy6chyg@mail.gmail.com>
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

On Tue, 7 Nov 2023 at 02:40, Manorit Chawdhry <m-chawdhry@ti.com> wrote:
>
> Hi Simon,
>
> On 08:29-20231012, Simon Glass wrote:
> > Hi Manorit,
> >
> > On Wed, 11 Oct 2023 at 22:46, Manorit Chawdhry <m-chawdhry@ti.com> wrote:
> > >
> > > Hi Simon,
> > >
> > > On 20:41-20231011, Simon Glass wrote:
> > > > Hi Manorit,
> > > >
> > > > On Tue, 10 Oct 2023 at 23:25, Manorit Chawdhry <m-chawdhry@ti.com> wrote:
> > > > >
> > > > > We can now firewall entities while loading them through our secure
> > > > > entity TIFS, the required information should be present in the
> > > > > certificate that is being parsed by TIFS.
> > > > >
> > > > > The following commit adds the support to enable the certificates to be
> > > > > generated if the firewall configurations are present in the binman dtsi
> > > > > nodes.
> > > > >
> > > > > Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
> > > > > ---
> > > > >  tools/binman/btool/openssl.py   | 16 +++++++-
> > > > >  tools/binman/etype/ti_secure.py | 90 +++++++++++++++++++++++++++++++++++++++++
> > > > >  tools/binman/etype/x509_cert.py |  3 +-
> > > > >  3 files changed, 106 insertions(+), 3 deletions(-)
> > > > >
> > > >
> > > > Reviewed-by: Simon Glass <sjg@chromium.org>
> > > >
> > > > I'm still a little worried about the error reporting if the user
> > > > leaves out a property. Does it do the right thing?
> > > >
> > >
> > > I did make a test also along the lines that would check all the
> > > firewalling properties and just auth-in-place isn't checked at this
> > > stage and people could end up adding the firewalling node without
> > > auth-in-place. Do you want to cover that test case as well? Regarding
> > > the other firewalling properties ( immitating the test by removing
> > > "id"), We get this:
> > >
> > > [..]
> > >   AR      spl/common/spl/built-in.o
> > >   LD      spl/u-boot-spl
> > >   OBJCOPY spl/u-boot-spl-nodtb.bin
> > >   SYM     spl/u-boot-spl.sym
> > >   CAT     spl/u-boot-spl-dtb.bin
> > >   COPY    spl/u-boot-spl.bin
> > >   BINMAN  .binman_stamp
> > > binman: id can't be None in firewall node
> >
> > That's a bit vague...at least it should show the full path to the node
> > that failure, e.g. use self.Raise(). Also, I assume the property is
> > missing and the None refers to the Python value for the var. Better to
> > provide a nice error.
>
> I was working on this so I realised that Firewall class that I have is
> not an etype so I have hacked a bit around to get that self.Raise in but
> hoping that shouldn't be much of a problem..
>
> Does this error look okay now?
>
> [..]
>   COPY    spl/u-boot-spl.bin
>   BINMAN  .binman_stamp
> binman: Node '/binman/ti-spl/fit/images/atf/ti-secure': Subnode 'firewall' is missing properties: id,region

Yes

>
> >
> > Any possible user error should ideally be checked, to avoid later confusion.
> >
> > See Entry.ensure_props()
>
> I was thinking of using this as well but I noticed that this gets called
> in the beginning itself and since the Firewall class that I have is not
> an etype then I won't be getting the information that all this is
> failing in firewalling related node and might be confused with debugging
> in ti-secure hence thought of updating the dataclass only with the
> function only as you suggested below. Thanks for the suggestions!

That's fine, so long as you have the node path as you do above...it is
pretty easy for people to understand it when you have that.

>
> Regards,
> Manorit
>
> >
> > You could add an optional argument - the list of props to check. If
> > present it could use that instead of self.required_props
> >
> > Hmm better might be to have a new function which tells the user that
> > since the firewall property is present, it needs these others ones
> > too.
> >
> > Regards,
> > Simon

Regards.

Simon
