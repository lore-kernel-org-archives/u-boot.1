Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 966BDCD3446
	for <u-boot@archiver.kernel.org>; Tue,  3 Sep 2024 15:49:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C4A5E88A0A;
	Tue,  3 Sep 2024 17:49:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="k3dR/1u7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A75588B9F; Tue,  3 Sep 2024 17:49:38 +0200 (CEST)
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com
 [IPv6:2607:f8b0:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2D15E88754
 for <u-boot@lists.denx.de>; Tue,  3 Sep 2024 17:49:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-7c6aee8e8daso3912996a12.0
 for <u-boot@lists.denx.de>; Tue, 03 Sep 2024 08:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725378575; x=1725983375; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KEt/PuoS8T4xpHS48avw65Zu07aQchg0NGFGLRr7Z1c=;
 b=k3dR/1u7EzLePtWM7sWwmPf6cxE2mwUpXz4aoFp6yN+tHdP76yZ6lHM4G5rlEtY7aR
 M9Uo0mDnYzE7pRDcOAG005dCzIqqGCHsKxnAJzBdunyvW9gQZpA3Nhws3swhUpl3TucU
 duJyF4WnZx6Tp54xUZGUnIhzO+yMijqOOdf4lY4d0x0naL39x5dLdCeX4If53EEsNtwt
 dQbl1xUxGOYMAP63lJJUDc9pWLeLByDkXrz5r0KBQeO3XfZLBrifHGrtUWh4LMM2Mkcs
 mul4D09mOYbi1774WTDW4yhPJi87Rjunsq957HnKzbeW5Erk2CBx6/LNl6LIO42asmAT
 QQNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725378575; x=1725983375;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KEt/PuoS8T4xpHS48avw65Zu07aQchg0NGFGLRr7Z1c=;
 b=O0jXVLpA7V7qcrpyC5AS4jc7homBupT3TXBwrijRXEmYRpikf8ezfv+e81oe/ncpgq
 yB1VKssKfpDOfu9uKYubZw6W1V6Ni0p9qi18IY19BI5QAVru8KfnVwMY2w5PApAGgaOf
 /XTn0j0VzQTQRlGuXNatieIrC0glhvUukHoZUz4PtMgWcIueyIDJyFBVsilf7CR7QcXk
 u6bhd39p8sg2corq6S5H9y8exoJ/Ccd9ADrDnxPFemFUdJScJN9Gl1nZw+JoHvqkED7l
 lszNaJn/1WQDDzLLOcdRO8djMrV+4Ao7sYgRq5PfAw5QxPuaRhXWbs1niTmwO70xvfAz
 6s2Q==
X-Gm-Message-State: AOJu0YxxZpzYFqPoyiC6ozkPLHbcroqZO9UELnAebwjQYmHeCU1+Xg0O
 Nf0jNrWhOoZQNZOrkF9iO/HpgrrGouNFu7rEw4ORElRxrzp+GniThsmdKNr9Wr8y8vFDhpAZ4y5
 Gy5GmalY4kTv7If9b1Y24IDhq5WIjK6mAg0PI8Q==
X-Google-Smtp-Source: AGHT+IF1l3tUMTtD/04iUdWEjvBe5iv31X7Ug94Im7ZCYBFfFPPv90pRDmXJrh1Y2VIVZOyj/8yS0Ej9UR7oWMLrFMA=
X-Received: by 2002:a17:90a:b304:b0:2d8:84de:5e0e with SMTP id
 98e67ed59e1d1-2d88d6d8bcdmr11646679a91.19.1725378574576; Tue, 03 Sep 2024
 08:49:34 -0700 (PDT)
MIME-Version: 1.0
References: <20240816214436.1877263-1-raymond.mao@linaro.org>
 <20240816214436.1877263-8-raymond.mao@linaro.org>
 <CAC_iWjKNFQA70MMiHbWwP9u-Qxs_O=yfE6QS0PF2TcmPD4MXMQ@mail.gmail.com>
In-Reply-To: <CAC_iWjKNFQA70MMiHbWwP9u-Qxs_O=yfE6QS0PF2TcmPD4MXMQ@mail.gmail.com>
From: Raymond Mao <raymond.mao@linaro.org>
Date: Tue, 3 Sep 2024 11:49:23 -0400
Message-ID: <CAEfUkUKEspx_a8MAG00r9Dhq0jZ5_KMN75u4j0M6K_qT0z00Fg@mail.gmail.com>
Subject: Re: [PATCH v6 07/28] hash: integrate hash on mbedtls
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, manish.pandey2@arm.com, 
 Tom Rini <trini@konsulko.com>, Stefan Bosch <stefan_b@posteo.net>,
 Mario Six <mario.six@gdsys.cc>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>, 
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>, 
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

On Wed, 28 Aug 2024 at 05:54, Ilias Apalodimas <ilias.apalodimas@linaro.org>
wrote:

> Hi Raymond
>
> On Sat, 17 Aug 2024 at 00:47, Raymond Mao <raymond.mao@linaro.org> wrote:
> >
> > Integrate common/hash.c on the hash shim layer so that hash APIs
> > from mbedtls can be leveraged by boot/image and efi_loader.
> >
> > Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
> > ---
> > Changes in v2
> > - Use the original head files instead of creating new ones.
> > Changes in v3
> > - Add handle checkers for malloc.
> > Changes in v4
> > - None.
> > Changes in v5
> > - Add __maybe_unused to solve linker errors in some platforms.
> > - replace malloc with calloc.
> > Changes in v6
> > - None.
> >
> >  common/hash.c | 146 ++++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 146 insertions(+)
> >
> > diff --git a/common/hash.c b/common/hash.c
> > index ac63803fed9..d25fc4854c7 100644
> > --- a/common/hash.c
> > +++ b/common/hash.c
> > @@ -35,6 +35,144 @@
> >  #include <u-boot/sha512.h>
> >  #include <u-boot/md5.h>
> >
> > +#if CONFIG_IS_ENABLED(MBEDTLS_LIB_CRYPTO)
> > +
> > +static int __maybe_unused hash_init_sha1(struct hash_algo *algo, void
> **ctxp)
> > +{
> > +       int ret;
> > +       mbedtls_sha1_context *ctx = calloc(1, sizeof(*ctx));
> > +
> > +       if (!ctx)
> > +               return -ENOMEM;
> > +
> > +       mbedtls_sha1_init(ctx);
> > +       ret = mbedtls_sha1_starts(ctx);
> > +       if (!ret) {
> > +               *ctxp = ctx;
> > +       } else {
> > +               mbedtls_sha1_free(ctx);
> > +               free(ctx);
> > +       }
> > +
> > +       return ret;
> > +}
> > +
> > +static int __maybe_unused hash_update_sha1(struct hash_algo *algo, void
> *ctx,
> > +                                          const void *buf, unsigned int
> size,
> > +                                          int is_last)
> > +{
> > +       return mbedtls_sha1_update((mbedtls_sha1_context *)ctx, buf,
> size);
> > +}
> > +
> > +static int __maybe_unused
> > +hash_finish_sha1(struct hash_algo *algo, void *ctx, void *dest_buf, int
> size)
> > +{
> > +       int ret;
> > +
> > +       if (size < algo->digest_size)
> > +               return -1;
> > +
> > +       ret = mbedtls_sha1_finish((mbedtls_sha1_context *)ctx, dest_buf);
> > +       if (!ret) {
>
> patch # calls finish & free regardless of the return result of
> mbedtls_xxxx_finish().
> I think this should happen here as well
>
> Unlike the other one who returns void, this API returns int.
Why don't we check the result here and return the error code when it exists?

[snip]

Regards,
Raymond
