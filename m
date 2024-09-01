Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD16BCD3420
	for <u-boot@archiver.kernel.org>; Sun,  1 Sep 2024 20:11:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F25D88B3F;
	Sun,  1 Sep 2024 22:09:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WMNf0Icl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5EEA88A7F; Sun,  1 Sep 2024 22:09:58 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7BC7588637
 for <u-boot@lists.denx.de>; Sun,  1 Sep 2024 22:09:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-70f6e65d605so1168634a34.3
 for <u-boot@lists.denx.de>; Sun, 01 Sep 2024 13:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1725221395; x=1725826195; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NmwgUtG4wNtC/IQZudIGDO+tywj0cF5nMcDzO6BRUv8=;
 b=WMNf0IcljajKahe4Xfic1hGgr/ouFxltV+/dkb29j2iqSeh7ohZTNTgyb9iz1S9sKW
 MgyrssEUBSH1L5KW5Rcb3dqFQ4AsKrDtXDI8lvbx01jrI6VSIuc8L/zMfm3JIleyxUaP
 QSjaL6via3B0jM/si227eXatXldzXD1suhGd0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725221395; x=1725826195;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NmwgUtG4wNtC/IQZudIGDO+tywj0cF5nMcDzO6BRUv8=;
 b=rRYbGW9McGCETY2k/sULOJfUONwtu/3Z65MAsKPfBhFtbnEuaQG+xqFroAkcy2akgA
 d0k2wlD2ueReAFLwY+qBwSbk6csV2FYVWWX7gmxz0lm3Qdilgie0DB1vY5D0ilgAhu/m
 T2tjugqqRwPW6m5cK9PfCrQQ9oRSyIkW8w0UI7QMfP82OTKHiLDZCbnUeE85Q2Zb2CCB
 /TjdzSBDXt4+hxdaralZPgJC+LBICshQ4/NAOhxnNWAnEvwJwy8RUDepQH4Vr1zmJh/r
 rdtdYRpVZ66aqL3Egj5MIYXiUVOGo8/2cYpcav8sCbcxP98TLYSko7gotxskZlPfuzc8
 AY6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQPGyzQWrxJ6aNAb5w9IsF50S8ZfowuuiiDVsX9Sb5a/2knchDkgMmsTS217oINMyPjJXd6sY=@lists.denx.de
X-Gm-Message-State: AOJu0YzLG3ySJ5CLWUnwePdu9099UHp5nGXI+AaaDoXxB0aQ+hC35CZg
 VR/RlDqQNp6sZMgK1psjFUUA5HyisjX50PJqGeF4jZAzEsJA1w2djyigDG3dL6OYHzSbTZF5mOj
 kIOrChS8+1p0TTZZjI3BhinbNoPN427+V7sBS
X-Google-Smtp-Source: AGHT+IHQCEXe0IQC3tyPHTuP34EiagYsc6GYwXpFZ4v6t0AImbldsvxoObpz8Rz8fw8nJRrVNbntPr9AH4Gk697KgzI=
X-Received: by 2002:a05:6830:368d:b0:709:3a05:36c9 with SMTP id
 46e09a7af769-70f5c491cedmr14919155a34.29.1725221395308; Sun, 01 Sep 2024
 13:09:55 -0700 (PDT)
MIME-Version: 1.0
References: <20240816214436.1877263-1-raymond.mao@linaro.org>
 <20240816214436.1877263-8-raymond.mao@linaro.org>
 <CAFLszTiWFD2dpb6z_5cibDe0aOpuPYug-mrC-ZiZ7v+SEDFhdQ@mail.gmail.com>
 <CAC_iWjJpfrK+-o_0x8ZJbWxhG4O-tprf1-oQvWmLZWOf=5qZMA@mail.gmail.com>
In-Reply-To: <CAC_iWjJpfrK+-o_0x8ZJbWxhG4O-tprf1-oQvWmLZWOf=5qZMA@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 1 Sep 2024 14:09:44 -0600
Message-ID: <CAFLszThL=Z_=Qome2ZzwdqcUxX4bVg7MsMKMgk05TkrV2wcMGg@mail.gmail.com>
Subject: Re: [PATCH v6 07/28] hash: integrate hash on mbedtls
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Raymond Mao <raymond.mao@linaro.org>, u-boot@lists.denx.de,
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

On Fri, 30 Aug 2024 at 03:37, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> Hi Simon,
>
> On Thu, 29 Aug 2024 at 18:01, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Raymond,
> >
> > On Fri, 16 Aug 2024 at 15:47, Raymond Mao <raymond.mao@linaro.org> wrote:
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

It's really just a case of dropping the hash calls. It should not
cause any other problems, so far as I can see, but I have not dug in
in detail.

Re TLS is relying on its internal hashing functions, is this what you
are talking about?

$ git grep mbedtls_sha1_free
common/hash.c:          mbedtls_sha1_free(ctx);
common/hash.c:          mbedtls_sha1_free((mbedtls_sha1_context *)ctx);
lib/mbedtls/external/mbedtls/include/mbedtls/sha1.h:void
mbedtls_sha1_free(mbedtls_sha1_context *ctx);
lib/mbedtls/external/mbedtls/library/md.c:
mbedtls_sha1_free(ctx->md_ctx);
lib/mbedtls/external/mbedtls/library/psa_crypto_hash.c:
mbedtls_sha1_free(&operation->ctx.sha1);
lib/mbedtls/external/mbedtls/library/sha1.c:void
mbedtls_sha1_free(mbedtls_sha1_context *ctx)
lib/mbedtls/external/mbedtls/library/sha1.c:    mbedtls_sha1_free(ctx);
lib/mbedtls/external/mbedtls/library/sha1.c:    mbedtls_sha1_free(&ctx);
lib/mbedtls/external/mbedtls/library/sha1.c:    mbedtls_sha1_free(&ctx);
lib/mbedtls/sha1.c:     mbedtls_sha1_free(ctx);

I see this in psa_crypto_hash.c (not sure what that is though).

> > Can you do the rest of the integration first?

I believe this is the best approach. We need to permit using crypto
acceleration too (via driver model), which is obviously impossible if
mbed algorithms are using built-in hashing.

The biggest challenge here is that common/hash.c needs some love, as I
mentioned in an earlier version.

Regards,
Simon
