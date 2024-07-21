Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB400C3DA61
	for <u-boot@archiver.kernel.org>; Sun, 21 Jul 2024 10:09:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1622787E2E;
	Sun, 21 Jul 2024 12:08:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Qhuq0oqZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3916887E96; Sun, 21 Jul 2024 12:08:48 +0200 (CEST)
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com
 [IPv6:2607:f8b0:4864:20::b33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D0B087E2E
 for <u-boot@lists.denx.de>; Sun, 21 Jul 2024 12:08:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-e0875f1e9edso975757276.1
 for <u-boot@lists.denx.de>; Sun, 21 Jul 2024 03:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721556524; x=1722161324; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Yrn/xHbene/++yF2ZbZrJf4DFuoATGQDCfEw7MgC91c=;
 b=Qhuq0oqZRlkOP5Oc3t29Ky75XXm3i8DYmk8pCFQpljAqe8SnW+/20r6c7rDRg6zwpz
 iXksWOOr5+4n153ij12Mb3XDzvtu0tiJBS0EGKMZ+lE92SX1X7q8WNBjnO6LiqOCaYBn
 wg5b19KOaz2AEssryo6Nhr8YTL27qQigStH1I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721556524; x=1722161324;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Yrn/xHbene/++yF2ZbZrJf4DFuoATGQDCfEw7MgC91c=;
 b=liKda4DEhbzJ6pKlCJu/uuFSFXY/i66nZPzl/Oa/URBKCzgxwBjDQwstCPeg6HlHWL
 U0gMFwNJiosnohNcqby/3xprNujLABOqLfU4jkxLDOwalJ0zTtZ/erqWfNLqGA1FtbBm
 Ciue2FCTkU9Vfq1z9XyKcHCoWNPbxQj9Q34YpxvAHCP+3MXRi69yk67LPQffl+ZYiA3F
 wOZA7/wEGe7T+mlyUFYEhSGuAaP2qJho2H8ImurJTcycHpn/S8VA/ABEdmWqC4dLjd/Z
 gvvf53sE8gDgrZa9yicHPc/Rvrzg+egz942G/Z5SyCmYBg97Ui6aClAfiR7AG17ktD9C
 OP+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXbG6b5rGzu51S0zbky6enK6rO3Lxv+acJB+qHsDR/o5MaNJLqK6Vmmcw/gKDCHnN/dXvdxc5kRFHEDc9EBlB1030Ghsg==
X-Gm-Message-State: AOJu0Yxl8f4mIAlky4WKamjV6WGjMiBE6yexwuZknldJP042vf/0+q3z
 sCQrAo8vx6Ri6/L58t2Vsx2HjHx94V7ltncYzNYf12MFWERIR2QUqwjWrmEClaU57tptil21C/w
 Scu/mtD3/qZqkih3egSgJaTAjoVHHJvMatPyk
X-Google-Smtp-Source: AGHT+IFo+rdDTSrStr3PReGtDRT4en1TmThAtO+A02De7EZqUcOOIPzjmPeWO1yvT+t9woTphByslAjvRHQ2JLtPc40=
X-Received: by 2002:a05:6902:2511:b0:e05:fc91:8940 with SMTP id
 3f1490d57ef6-e0870181352mr5172530276.22.1721556524377; Sun, 21 Jul 2024
 03:08:44 -0700 (PDT)
MIME-Version: 1.0
References: <20240702182325.2904421-1-raymond.mao@linaro.org>
 <20240702182325.2904421-9-raymond.mao@linaro.org>
 <CAC_iWjLxSbtcSwM1iQjj7DG3sJLY5Q=3fnuOphkJKXcQyO4TtQ@mail.gmail.com>
 <CAFLszTiezZ4hx-ToVT+CzE6aAwvjea_5-=VuqBWcGjAqOoH2Mg@mail.gmail.com>
 <CAEfUkUJ+U87Pb0YC9m18BpUgc94n0NcqTAEqoP3f5j3SkoB4PQ@mail.gmail.com>
 <CAFLszTg+Nx43kB2rMYTyHS36mKjkQc643p2Gd8Dax5ivwOtokw@mail.gmail.com>
 <20240719152540.GB561963@bill-the-cat>
 <CAFLszTihZMPK124jAVvbnm7CT1SZ8wFJq920C9vMF2vz8jmpnQ@mail.gmail.com>
 <20240720171314.GF561963@bill-the-cat>
In-Reply-To: <20240720171314.GF561963@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 21 Jul 2024 11:08:33 +0100
Message-ID: <CAFLszTjifbwGWVqgLyOT=Ee-09YzMn=PbDUYhi36_7ybGrgziw@mail.gmail.com>
Subject: Re: [PATCH v4 08/29] hash: integrate hash on mbedtls
To: Tom Rini <trini@konsulko.com>
Cc: Raymond Mao <raymond.mao@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 U-Boot Mailing List <u-boot@lists.denx.de>, manish.pandey2@arm.com, 
 Stefan Bosch <stefan_b@posteo.net>, Mario Six <mario.six@gdsys.cc>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>, 
 Jesse Taube <mr.bossman075@gmail.com>, Bryan Brattlof <bb@ti.com>, 
 "Leon M. Busch-George" <leon@georgemail.eu>, Sergei Antonov <saproj@gmail.com>,
 Ilya Lukin <4.shket@gmail.com>, 
 Igor Opaniuk <igor.opaniuk@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Bin Meng <bmeng@tinylab.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, 
 Alexander Gendin <agendin@matrox.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>, 
 Eddie James <eajames@linux.ibm.com>
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

Hi Tom,

On Sat, 20 Jul 2024 at 18:13, Tom Rini <trini@konsulko.com> wrote:
>
> On Sat, Jul 20, 2024 at 01:36:02PM +0100, Simon Glass wrote:
> > Hi Tom,
> >
> > On Fri, 19 Jul 2024 at 16:25, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Fri, Jul 19, 2024 at 04:05:09PM +0100, Simon Glass wrote:
> > > > Hi Raymond,
> > > >
> > > > On Thu, 18 Jul 2024 at 17:46, Raymond Mao <raymond.mao@linaro.org> wrote:
> > > > >
> > > > > Hi Simon,
> > > > >
> > > > > On Fri, 5 Jul 2024 at 04:36, Simon Glass <sjg@chromium.org> wrote:
> > > > >>
> > > > >> Hi,
> > > > >>
> > > > >> On Wed, Jul 3, 2024, 09:56 Ilias Apalodimas <ilias.apalodimas@linaro.org> wrote:
> > > > >> >
> > > > >> > Hi Raymond
> > > > >> >
> > > > >> > On Tue, 2 Jul 2024 at 21:27, Raymond Mao <raymond.mao@linaro.org> wrote:
> > > > >> > >
> > > > >> > > Integrate common/hash.c on the hash shim layer so that hash APIs
> > > > >> > > from mbedtls can be leveraged by boot/image and efi_loader.
> > > > >> > >
> > > > >> > > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> > > > >> > > ---
> > > > >> > > Changes in v2
> > > > >> > > - Use the original head files instead of creating new ones.
> > > > >> > > Changes in v3
> > > > >> > > - Add handle checkers for malloc.
> > > > >> > > Changes in v4
> > > > >> > > - None.
> > > > >> > >
> > > > >> > >  common/hash.c | 143 ++++++++++++++++++++++++++++++++++++++++++++++++++
> > > > >> > >  1 file changed, 143 insertions(+)
> > > > >> > >
> > > > >> > > diff --git a/common/hash.c b/common/hash.c
> > > > >> > > index ac63803fed9..96caf074374 100644
> > > > >> > > --- a/common/hash.c
> > > > >> > > +++ b/common/hash.c
> > > > >> > > @@ -35,6 +35,141 @@
> > > > >> > >  #include <u-boot/sha512.h>
> > > > >> > >  #include <u-boot/md5.h>
> > > > >> > >
> > > > >> > > +#if CONFIG_IS_ENABLED(MBEDTLS_LIB_CRYPTO)
> > > > >> > > +
> > > > >> > > +static int hash_init_sha1(struct hash_algo *algo, void **ctxp)
> > > > >> > > +{
> > > > >> > > +       int ret;
> > > > >> > > +       mbedtls_sha1_context *ctx = malloc(sizeof(mbedtls_sha1_context));
> > > > >>
> > > > >>
> > > > >> Why do we need allocation here? We should avoid it where possible.
> > > > >>
> > > > > The API "hash_init_sha1(struct hash_algo *algo, void **ctxp)" is passing a pointer
> > > > > address and expecting to get the context from the pointer, it is reasonable to do the
> > > > > allocation.
> > > > > On top of that, this patch doesn't make changes on this API itself, but just adapted
> > > > > it to MbedTLS stacks, thus you can see the allocation is needed by the original API
> > > > > as well.
> > > >
> > > > Oh dear., I see Now I am looking at the code. It is full of #ifdefs
> > > > for different cases.
> > > >
> > > > The whole thing needs a bit of a rationalisation before adding another case.
> > >
> > > If you're referring too the hash_algo struct, I'm not sure we can do
> > > something different that doesn't in turn increase size globally. And
> > > long term some of this may be able to go away if we can remove
> > > non-mbedTLS options.
> >
> > Well, at least using the existing functions rather than writing
> > entirely new ones would help.
> >
> > The real culprit here is the hardware-acceleration stuff, but making
> > the software side messy too is not nice. Hashing should move to a
> > linker-list approach for the implementation, and probably driver model
> > for the hardware acceleration.
>
> I'm fine with looking at that, after mbedtls is merged and we're looking
> at what can be removed / cleaned up. Perhaps we'll be able to shift
> most/all of the hardware assisted algorithms to being handled within
> mbedtls, I don't know.

So long as the same person does the clean-up straight afterwards, that
sounds fine. Otherwise, no one else will take it on as this series
makes it harder.

For hardware-assist, I think we need a driver model solution with a proper API.

Regards,
Simon
