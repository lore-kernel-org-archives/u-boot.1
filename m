Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49F41FF8855
	for <u-boot@archiver.kernel.org>; Tue,  5 May 2026 15:16:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DD9DC84972;
	Tue,  5 May 2026 17:16:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lGnwUIsh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 491F684974; Tue,  5 May 2026 17:16:23 +0200 (CEST)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 483FD84972
 for <u-boot@lists.denx.de>; Tue,  5 May 2026 17:16:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-6729c6f0ca7so6947739a12.0
 for <u-boot@lists.denx.de>; Tue, 05 May 2026 08:16:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777994181; cv=none;
 d=google.com; s=arc-20240605;
 b=ZKYXH+AeWQua4P8e0vT3WerwIlf+SDNYaHjVfixaK2/4vBUUN4gTEzD0UyCb1FfN4p
 aptcJXMF6aX0InK0dpDbQ8csKcbx29k0FrXra2s2mEY1t/ofh6qcEL862DpDYEgdp0Cg
 MRrRLz6W4QUZ4yFLMJtHNh/TNo/41+zrQa/jgfbB1OKSmOBGfzLm3DTphu+tcCTfCfBh
 K0d/NPokn53U6Wrgv0ECg7A1aJic4ag9MkkufkWR1M8yVjyp7LjzJp99yvd+BCiraHBz
 Uf5M8JNkOAw10ACivXtroRa4E/SNTRyhTpm60+NwhBVM8TkZ4/bo6/MSKQ4Zrt7YvxVY
 YgtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=XjFZ020MKGkw92E1G62rafWikJK4vEYqWKX1yPZ7fwY=;
 fh=Z+stmjoAd0NaPceKgxqiPrDSFeSlociNQD1YD3GeDpE=;
 b=gAr/lv/YL1TLhb8p3XoUMY8j1XUr+xWKqzfwB6ZEGVdZCq1lbjEKOcEV6mfB3kDa9f
 ZnblZh9iz19cPH3iRG8nJTMxAH/jXrPtNqcSMYtpTbhLtwynEJxRlSBAbtGSrHbcWp8v
 6MV7g7g+WvUCaSGROQAjPkCgJN77eRBApfWQqDuvjp/m3nVJYKZkKlml1wUSVlKQQZbr
 +BlJOuJ6t0gTn3fDy2RXA4Vl5krSqf0I75QRAsjSCbX5gLIAN7bUt/eGwTBVOKayL1jq
 UFDQJgMinUiW+KD990oeR5f72MsHTLk01Ibpph9qEckhnjsumnUqwAHv4vdN801vqe+e
 VBJA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777994181; x=1778598981; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XjFZ020MKGkw92E1G62rafWikJK4vEYqWKX1yPZ7fwY=;
 b=lGnwUIsh99lffetB+f2J1wpKWTq8pByrZP04pbBOfzcwcrncshPGqGnptYfOaxfLYb
 D7NvZRgabar37IHyKwBJ0LU9SBUAKvUhXS6vfhQY7+fMolsD42pI0XPpgzW9q3VZfu33
 01iBU8AZcL+IviLk8FdGyZvHJe4EAHBQSf7yA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777994181; x=1778598981;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XjFZ020MKGkw92E1G62rafWikJK4vEYqWKX1yPZ7fwY=;
 b=knzUmQ5IPasVCz1SPEL3QpuHltZSZBVLBZxs8JIcGlStY4IGnvl63pF4FY3lLV47E7
 nXC0XjZ8GEh+vUfeXyKVEfvlo0irnX3yNNTPTB1FpPlIM1swNXuwMmaiMIb5zh6RX5gA
 3NNNTrQhefzCPKMVTJbGe/in02eBMF0J2ruQValynKTLbna2guK3TIz61E7z19MRFjIg
 vKd8ec6wJUtC/dfOZB5FKEtMeRA9ByW+dmWnieWyVGOqcwvMdXaLaLnx65RaFeodpK+W
 OOKd4kwH0gBZp7W8ch6xjrr0NTvo/Jfphu2OeiXdaN/tBaN1H8sojYfAS9X+0p2GhMqB
 5tSw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/p4R/QBSXZ8FBZhkKFg02XpMObfpdWPueUt2XHjkUgecUwjJcfEVPj1GDDtn50EVulrXCux1g=@lists.denx.de
X-Gm-Message-State: AOJu0YxGX/2WVz/2U5KS+oDkaa3d0usI7dPDt9Fxg/tdlAvDzBjOqn1m
 yo/ZtCsO0dKIUNh790cMN5rKDsRuXB0Fr54SH1OpQicJYOzBWHUdsJPi7i4nSy5W8tsGsIiCb/F
 iUNLkXZ5I7ySt3pNQQDDkcHbSaljMzbA5GKG85o/6
X-Gm-Gg: AeBDieujLLwRTCeo/ewXaxrF1OOpYHocf2qfPah9wuC8bptiDNu8aoTm3rmKvG1krja
 Psm1Y1GFzjcGHYAEla/HNQhfCtzU1RfLy1XmH5/B6cl/GsDoIDUwsxf/nzb5JEpbYz6nC/DWkK6
 BKBJ41EBGZb2KKUmF76ZO7ocWc8zlOM7Y7UnMpbrj3WWjlPZ43dGw7Wlz7vh7/vqGQy6/G1yM9N
 b1EONo3g6Xi/ia7TCkJYjkmgmPQZpvwtAKHztKPiafNHedeguqg6R0i8+W8RAaUuz4IzpptPfkR
 FB59zx5K/C/kP34s
X-Received: by 2002:a17:907:70c:b0:bc2:c4c4:79c1 with SMTP id
 a640c23a62f3a-bc2c4c56452mr439782166b.11.1777994180495; Tue, 05 May 2026
 08:16:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260504-extrawarn-sync-v1-0-b19301d1948a@cherry.de>
 <20260504-extrawarn-sync-v1-18-b19301d1948a@cherry.de>
 <CAFLszTjra2Tcsvki4qKz7h6EBshDccUP0M-6QkHpLMKAUYBw+A@mail.gmail.com>
 <4746bed3-e157-4c9f-9697-d07bab4a0a7e@cherry.de>
In-Reply-To: <4746bed3-e157-4c9f-9697-d07bab4a0a7e@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 5 May 2026 09:16:08 -0600
X-Gm-Features: AVHnY4L2b17Sra16E34htTUH73eUJk-zi5ny1O5oofHITnbjB3X3K7Jo9dI8mNE
Message-ID: <CAFLszTiynBxG4UHZL4aFSXm+qCkUOMwXA-OAGKoSPgE19uJ2XQ@mail.gmail.com>
Subject: Re: [PATCH RFC next 18/18] buildman: set W flag to e to be consistent
 with CONFIG_WERROR
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: foss+uboot@0leil.net, u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 David Lechner <dlechner@baylibre.com>, 
 Jerome Forissier <jerome.forissier@arm.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Glass <simon.glass@canonical.com>, 
 Raymond Mao <raymondmaoca@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Michal Simek <michal.simek@amd.com>, Adriano Cordova <adrianox@gmail.com>, 
 Sughosh Ganu <sughosh.ganu@arm.com>, Yao Zi <me@ziyao.cc>,
 Rasmus Villemoes <ravi@prevas.dk>
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

Hi Quentin,

On Tue, 5 May 2026 at 05:29, Quentin Schulz <quentin.schulz@cherry.de> wrote:
>
> Hi Simon,
>
> On 5/4/26 10:38 PM, Simon Glass wrote:
> > Hi Quentin,
> >
> > On 2026-05-04T13:20:27, Quentin Schulz <foss+uboot@0leil.net> wrote:
> >> buildman: set W flag to e to be consistent with CONFIG_WERROR
> >>
> >> Buildman currently only enables Werror for KBUILD_CFLAGS (via KCFLAGS)
> >> and KBUILD_HOSTCFLAGS (via HOSTCFLAGS) but nothing else.
> >>
> >> scripts/Makefile.extrawarn now supports --fatal-warnings for the linker
> >> and assembler, which are enabled whenever CONFIG_WERROR is set.
> >>
> >> Let's make buildman set this variable to enable even more checks.
> >> KBUILD_CFLAGS and KBUILD_HOSTCFLAGS are kept in case buildman is run on
> >> a git-range where W=e is not available, it's better than nothing.
> >>
> >> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> >>
> >> tools/buildman/builderthread.py | 1 +
> >>   1 file changed, 1 insertion(+)
> >
> >> diff --git a/tools/buildman/builderthread.py b/tools/buildman/builderthread.py
> >> @@ -233,6 +233,7 @@ class BuilderThread(threading.Thread):
> >>           if self.builder.warnings_as_errors:
> >>               args.append('KCFLAGS=-Werror')
> >>               args.append('HOSTCFLAGS=-Werror')
> >> +            args.append('W=e')
> >
> > Please update test_warnings_as_errors() in tools/buildman/func_test.py
> > to assert W=e is present in the make args alongside the existing
> > KCFLAGS / HOSTCFLAGS checks. Otherwise the new behaviour is silently
> > untested.
> >
>
> This test is only available in your fork of U-Boot. I'll therefore
> ignore this comment.

Oh yes, I haven't upstreamed those extra tests yet. I'll take a look
when this series is in. I sent an email about buildman if you have any
thoughts on that.

Regards,
Simon
