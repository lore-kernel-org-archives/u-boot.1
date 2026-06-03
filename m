Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CD67CD6E4A
	for <u-boot@archiver.kernel.org>; Wed,  3 Jun 2026 11:26:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C1DA98486B;
	Wed,  3 Jun 2026 13:26:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wV1pbkYS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B97038486D; Wed,  3 Jun 2026 13:26:19 +0200 (CEST)
Received: from mail-yx1-xb12d.google.com (mail-yx1-xb12d.google.com
 [IPv6:2607:f8b0:4864:20::b12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7BF1584857
 for <u-boot@lists.denx.de>; Wed,  3 Jun 2026 13:26:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb12d.google.com with SMTP id
 956f58d0204a3-6608c1a4215so859388d50.0
 for <u-boot@lists.denx.de>; Wed, 03 Jun 2026 04:26:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780485976; cv=none;
 d=google.com; s=arc-20240605;
 b=h2zzJD3r7qu305kMhJd8EQgM5nNTgR1y/f6l3C8U7r0bTn3CH22S69Kk5NStADKDL5
 9dTeV3bcMROFsw6N0nN+Vc4q4Qck4c0K/YzPMLMZefqPedzkER5Ed9F4/36Fr4f6jici
 SEg2o2D+0iGraxJS/ExeswnXOyLUI8zjqvtmBPMkefxhHMqZ4YyJez7ReRp89NnvxPnu
 taAjegOtrSeGn+6GLByyFjLzug9csQ0S6tB9zCIK/yxqGs481hBuTpAmoEt3ViYdLe1J
 C6MMiDSrKEQ2UBa5pWcs7CYatXYlk+W+9vB28zZpwBVDii9wpM0ljz4GtipaA6hYfWAu
 rDGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=wq/EUsrsvdofpjMHgrBd8WMGUgophcfg6Nk2id/Ukds=;
 fh=zulEIcySSOrmDHsbYADkx+xn9Gp8MLYGF+tnMaYS6c0=;
 b=Kzd6D1QjGPqNFhm+HAVfBboTjSnmons9DO+zmr/CELsbsRVVn+H8b/dHlS7uU3e6uP
 UUClYAap27IV9DzTFpuaDrmys15lN3k7TMu2MkqAM8DKMk90qHppw4/eObTG8oBRGUfh
 BTbzuIDyJFlW7cGMXe9UIteo2ANUvGjP+SLvkitRow8pK7PNKL4hQWPDouz/hafBzSf1
 NaXJj04jDkF4El7aqzWnmiKqiTcHwzdYcNJlziwTBSWbq6P1mQo3+3nAjcM7EJkrX2Li
 1PfblJAVEWnOhPjQEHf9pcDnYVu10kNc5i7DXFzjdksY9UVd6RykgNtuDu9nJbfI1Ipk
 XqNw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780485976; x=1781090776; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=wq/EUsrsvdofpjMHgrBd8WMGUgophcfg6Nk2id/Ukds=;
 b=wV1pbkYSc1egz14lPucwUq8KVvvtG8SvPFbiVAFp2Un/VdYpASXg5S6KdSBTuPquw9
 mWU1haXH2XWJ+gDp7poOSsINZJaKyAfXgecYlB1MFcvH1sX+1rfUkLkCRUHoPFf/krOI
 miz/myGxEyQx1UHnVwkY9XyJeLI0v0NVjgB0cGcXvMi9qGg6a3h6RrTRaNsH4gKqlQvt
 pOIrxPw1MKmIwgLfDsNBiAAty1qOh9QM9PWz9uxxDr0GtbjqPYpXIlzOk/9moLXyJimQ
 Z8Bp+qW5ROZoBUa4iGkVoWL6L5gXJVuYihtxA8B3drlysDC6QYylNIGJFlElRJxF4bY0
 4jLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780485976; x=1781090776;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wq/EUsrsvdofpjMHgrBd8WMGUgophcfg6Nk2id/Ukds=;
 b=iQoPEXfZD00oF+s8/BoC079/LcvbQyX08DIhsjHHAV7WNmwCcmSBJwDmea15IWs62p
 /Ut7KA+ryBGJh8/IVwYEpFUGL88iDoz6kkBp3SXkv51t6CWooweQpkHnEcJWoGLMyzCH
 JV74I6uEfbnN5/TN9QgXGC2oDv/pGKD5m6bnWi8Wuyr7EVnMlnnROdCjVFBs+Ty60Tdd
 6D8ObDFelurCJlWih3CkdJattqL6LDqtHaZnEDxwTbdCxF/sjMyTPkzt86X8lL2+0dvq
 LWKCwTT6wSMcofQ5WPCtYGont2unK8UJtXXhdXq7umEvFT4dYj9GJ60CWB9cP1iP6CHS
 qDtw==
X-Forwarded-Encrypted: i=1;
 AFNElJ94djCzi7En5hM3tmUBu7uPOaUMdZHhUfZHjrbnAWbtN2t/RIvu2ArzMB14O7d2OXY/X4C3fkw=@lists.denx.de
X-Gm-Message-State: AOJu0YyeMm1cFILS4xAVNAl1Mo3iCrWZu/unL90qu5g3mRxeub3omLcN
 p3mYcNBRYk1DlX5XmjwHBFLUDRGYhyZwGXv0q1fE+sy+wtc4j1O/WvG5PfyUg7Fxpnovx/1B6Hv
 qgzGnjtDVV1Hu3Tofp3OTWDJq6xcQqa4tYrRSi1A4Uw==
X-Gm-Gg: Acq92OFRsQXvjpps6J+rFPLyNUOLVkMQ3qii6sH6tUdTRhm66xPkGFVGgVbSO/XghLn
 bmOrdyL5Ef7LmNBq+iRZYxffCVmVCzTPsOAyFkldoIwFcyBOXNpCqXHFRl6CMs+IGiPEPk+wOn2
 bXKjCCVqYHaK5xFmNwr8Ws9JfbTfKAokqBmuJS0XBdvJzSIuCzAmjfDyiX6MsFIPvKAcLElwuGj
 XyGfW+wDFOhBGLmpKQxAQ7yxB0cegDnHkDtAAJIS4Ur8myvnViW1Mis0eszmJJWJr7g25qNZaZC
 l7cixK2sfb2SDG5LbRb28GoYLg/zoiEN8P3yWraUKu8cpADFRGipFdC3Kgzmq0uNjGAf6w812sW
 xueyrj2w6C7x/rzKvgj9vlevOq/CcT+Cf3xi0FENAlBdi1eH8PZY12lW8zEZegzAchLc2OWxxB7
 oBdMv605AeDncJTecQ9k06qE8Oonp9MfJZGRsJIEl27QeEsjCX3Jktu496dIB/CcI6ni+sNCZK0
 1TOrsFYW0Yxsm7OzQYU0Jb2/pAsGkImBvD8dmJgCQO9umPYebJBEsGVZO+iTI7qqS0Kmd3zOKn4
 Iv72XaMeCbsGfWpf9YNKsFrQro1bRyYadJegx+ezxZK41P/207z2WEbVPGC0jyVndOl+h5q+sSS
 3D0Fkc+wE2hHLBtr7
X-Received: by 2002:a05:690e:b8d:b0:660:56f4:8ee8 with SMTP id
 956f58d0204a3-660dcc01648mr1892504d50.42.1780485976197; Wed, 03 Jun 2026
 04:26:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260530144604.71190-1-marek.vasut+renesas@mailbox.org>
 <8e28ea5f-039e-4620-bb88-8e992290da58@mailbox.org>
 <CALeDE9O4G21o2Onc=OpdwYO7o2PB7eS9u9JfE4nQjRFfRO4SrA@mail.gmail.com>
 <2604d7ca-1336-42af-b5ab-99fed506d63d@mailbox.org>
 <CALeDE9Nf5WPdf6VdaJGdWOJyo67DwNVp3L7eEiwkMPppLxVw=w@mail.gmail.com>
In-Reply-To: <CALeDE9Nf5WPdf6VdaJGdWOJyo67DwNVp3L7eEiwkMPppLxVw=w@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 3 Jun 2026 14:25:40 +0300
X-Gm-Features: AVHnY4IDDcOcnOquiU1oqbH8eVizgZo2WVS5a2wmNblPR1VoLp4cV8j6ByS0noQ
Message-ID: <CAC_iWjJv-oQ8Z92kDpnX5mecvknBd1MsuEB2MVvDwpwAjRmozw@mail.gmail.com>
Subject: Re: [PATCH] [RFC] lmb: Optionally limit available memory to 4 GiB on
 limited systems
To: Peter Robinson <pbrobinson@gmail.com>
Cc: Marek Vasut <marek.vasut@mailbox.org>, u-boot@lists.denx.de, 
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 David Lechner <dlechner@baylibre.com>, 
 Heiko Schocher <hs@nabladev.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Holger Brunck <holger.brunck@hitachienergy.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@arm.com>,
 Tom Rini <trini@konsulko.com>
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

On Wed, 3 Jun 2026 at 14:20, Peter Robinson <pbrobinson@gmail.com> wrote:
>
> On Wed, 3 Jun 2026 at 12:12, Marek Vasut <marek.vasut@mailbox.org> wrote:
> >
> > On 6/3/26 1:02 PM, Peter Robinson wrote:
> > > On Sat, 30 May 2026 at 16:06, Marek Vasut <marek.vasut@mailbox.org> wrote:
> > >>
> > >> On 5/30/26 4:45 PM, Marek Vasut wrote:
> > >>> Some architectures can not DMA above 4 GiB boundary,
> > >>> limit available memory to memory below 4 GiB boundary.
> > >>>
> > >>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> > >>> ---
> > >>> Cc: Andrew Goodbody <andrew.goodbody@linaro.org>
> > >>> Cc: David Lechner <dlechner@baylibre.com>
> > >>> Cc: Heiko Schocher <hs@nabladev.com>
> > >>> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> > >>> Cc: Holger Brunck <holger.brunck@hitachienergy.com>
> > >>> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > >>> Cc: Peter Robinson <pbrobinson@gmail.com>
> > >>> Cc: Quentin Schulz <quentin.schulz@cherry.de>
> > >>> Cc: Simon Glass <sjg@chromium.org>
> > >>> Cc: Sughosh Ganu <sughosh.ganu@arm.com>
> > >>> Cc: Tom Rini <trini@konsulko.com>
> > >>> Cc: u-boot@lists.denx.de
> > >>> ---
> > >>>    lib/Kconfig |  8 ++++++++
> > >>>    lib/lmb.c   | 20 +++++++++++++++++++-
> > >>>    2 files changed, 27 insertions(+), 1 deletion(-)
> > >>>
> > >>> diff --git a/lib/Kconfig b/lib/Kconfig
> > >>> index 77ebc79e1db..29911068a69 100644
> > >>> --- a/lib/Kconfig
> > >>> +++ b/lib/Kconfig
> > >>> @@ -1295,6 +1295,14 @@ config SPL_LMB_ARCH_MEM_MAP
> > >>>          memory map. Enable this config in such scenarios which allow
> > >>>          architectures and boards to define their own memory map.
> > >>>
> > >>> +config LMB_LIMIT_DMA_BELOW_4G
> > >>> +     bool
> > >>> +     depends on LMB
> > >>> +     default y if ARCH_BCM283X
> > >>> +     help
> > >>> +       Some architectures can not DMA above 4 GiB boundary,
> > >>> +       limit available memory to memory below 4 GiB boundary.
> > >>> +
> > >>>    config PHANDLE_CHECK_SEQ
> > >>>        bool "Enable phandle check while getting sequence number"
> > >>>        help
> > >>> diff --git a/lib/lmb.c b/lib/lmb.c
> > >>> index 8f12c6ad8e5..a8a988eedc0 100644
> > >>> --- a/lib/lmb.c
> > >>> +++ b/lib/lmb.c
> > >>> @@ -611,6 +611,7 @@ static __maybe_unused void lmb_reserve_common_spl(void)
> > >>>    static void lmb_add_memory(void)
> > >>>    {
> > >>>        int i;
> > >>> +     phys_addr_t bank_end;
> > >>>        phys_size_t size;
> > >>>        u64 ram_top = gd->ram_top;
> > >>>        struct bd_info *bd = gd->bd;
> > >>> @@ -625,8 +626,25 @@ static void lmb_add_memory(void)
> > >>>        for (i = 0; i < CONFIG_NR_DRAM_BANKS; i++) {
> > >>>                size = bd->bi_dram[i].size;
> > >>>
> > >>> -             if (size)
> > >>> +             if (size) {
> > >>>                        lmb_add(bd->bi_dram[i].start, size);
> > >>> +                     if (IS_ENABLED(CONFIG_LMB_LIMIT_DMA_BELOW_4G))
> > >>
> > >> This conditional should be inverted.
> > >>
> > >> Peter Robinson , can you test this change on RPi ?
> > >
> > > That doesn't fix the problem for me on a RPi4 4GB or a RPi5 8Gb.
> > Did you invert the if (IS_ENABLED...) conditional ?
> >
> > Was CONFIG_LMB_LIMIT_DMA_BELOW_4G enabled in your config (maybe the
> > Kconfig entry "default y" part needs to be tweaked to cover these devices?)
> >
> > If both conditions are met, that should behave like the old code.
>
> I dropped my revert and applied the patch, checked the new config
> option was in the generated .config (I mean you could test that with a
> "make rpi_arm64_defconfig" and checking the output).

You need to invert the logic of IS_ENABLED() for this patch to work.
Marek obviously missed a !

Cheers
Ilias
>
> Peter
