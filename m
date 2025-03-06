Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 539AEC282D1
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 13:57:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA370812D9;
	Thu,  6 Mar 2025 14:57:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ogId/ohb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07ED981335; Thu,  6 Mar 2025 14:57:26 +0100 (CET)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AAC4C8003E
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 14:57:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-aaf0f1adef8so116008266b.3
 for <u-boot@lists.denx.de>; Thu, 06 Mar 2025 05:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741269443; x=1741874243; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UBca7ZgplAIChfkIwZ288cBphRr2UqWcW7LD7LsPDuo=;
 b=ogId/ohbZh/aMQ71VVe2iW7z4oBgJIPIDmIVvKWso+AQhKKAjBeMumjZRq5hoq3xI8
 aqEkBT5Ax2Ghgcxsiebn95lWFiig6rF2vTWNTZ6A9JuE0eO56ecuDItWEdo5x8xjlMcP
 vUPurlKzATEtRvKFdfwEYQzveTvRVswzW6tgU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741269443; x=1741874243;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UBca7ZgplAIChfkIwZ288cBphRr2UqWcW7LD7LsPDuo=;
 b=MJxMEkGWtk1MujHvOFIPtEUB85w6XeLiDsY7HrfENtwpiIW79B2eue+Bt4hcAJx4fV
 lidnxykn2nOBmm0RVlQq1ul8rtWML3DwCXssoYvBRmjEyBZB8zRyITGi5GNBpMDADxid
 CxV4BtIxAaL4mkoL+qk9LLtJsDkkarFVRiS3llumFvzmMP9kFCMyg0IUO/37awYrjMEG
 65A3FaCamu0PXWXkwz1xx92zltVP8n7W1puYS9OwWApWflvoxDjtBpghrP+9ZDPJaVI2
 T9rtWPdl0fEROdhafEwCexvbhsD5e21TURvU3JC/g/Q+Oyi4I1wbjlUvN8+6KH0gGW1s
 kvww==
X-Gm-Message-State: AOJu0Yz5ge1leiqBUbLH6lOROBZgcjqh5E53ViyqBcbgGj+8XQDHLgnX
 kumUPH7rMgsYxE4HwZNpm3Lk609x3RWw4DbXQYvyOzdw5SYafIfifr4Mh1b72mdOOVJgEWSO32x
 dfqectOJyqw8KGhBF5v9kqZKLctjFOGuZbWOgIIggaF9BAVY=
X-Gm-Gg: ASbGnctXyX/lGlseLErVcQ+NimTmbf/SvbR1sw/QMvXZsOm5OMbsPJ1qWYvXweCUSiI
 gxS8rWe64ZptbP0bsOgXKUrWoBKd8xh4b/Ev7/aD9T6kRFbGArW2C3sXujF+DGRun2BF9SAaJa9
 Cjz4JRZmI2Ti5Rlx9PdPK9U4XXgL8=
X-Google-Smtp-Source: AGHT+IGF3jq738VwEOqzIU5jg9Yr/JCF3k4XbLMpFSBgzgr1EIoM9x4iIvJQ5/eT06Zu2HKKYFmkTbruLjLYTaBjnPU=
X-Received: by 2002:a17:907:3f0a:b0:ac1:e6bd:a556 with SMTP id
 a640c23a62f3a-ac20db00619mr750825966b.54.1741269442941; Thu, 06 Mar 2025
 05:57:22 -0800 (PST)
MIME-Version: 1.0
References: <20250304204116.2834889-1-trini@konsulko.com>
 <CAFLszTgzPq8Sdmk0Fqh19n-TkNBAJ+JwscNfYchRzE1kWQjrXg@mail.gmail.com>
 <20250305154953.GQ2640854@bill-the-cat>
In-Reply-To: <20250305154953.GQ2640854@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 6 Mar 2025 06:57:11 -0700
X-Gm-Features: AQ5f1JpsAPtGkxzqlYnahGvb0uMXhHiSD22unz6Ss2M_Jxd6pyjknvJO0vbXJ5g
Message-ID: <CAFLszTj98k8RroqGaBk0RA+tW0HjsU3=nzyd2JR7Y0u7AHvjaA@mail.gmail.com>
Subject: Re: [RFC PATCH] Kbuild: Always use $(PHASE_)
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
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

On Wed, 5 Mar 2025 at 08:49, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Mar 05, 2025 at 07:15:50AM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Tue, 4 Mar 2025 at 13:41, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > It is confusing to have both "$(PHASE_)" and "$(XPL_)" be used in our
> > > Makefiles as part of the macros to determine when to do something in our
> > > Makefiles based on what phase of the build we are in. For consistency,
> > > bring this down to a single macro and use "$(PHASE_)" only.
> > >
> > > Signed-off-by: Tom Rini <trini@konsulko.com>
> > > ---
> > > Cc: Simon Glass <sjg@chromium.org>
> > >
> > > This leads a little bit of dead code in scripts/Makefile.xpl that I
> > > didn't remove as this is an RFC. This also omits expanding on our build
> > > documentation slightly.
> > >
> > > With the following patches applied (which are correct regardless of this
> > > RFC and so separate):
> > > https://patchwork.ozlabs.org/project/uboot/patch/20250304203235.2834031-1-trini@konsulko.com/
> > > https://patchwork.ozlabs.org/project/uboot/patch/20250304202436.2783784-1-trini@konsulko.com/
> > >
> > > There's no change in the resulting build before/after this patch.
> > >
> > > We could do the other direction and drop $(PHASE_) in favour of $(XPL_)
> > > but that would require updating the logic of how XPL_ is defined.
> >
> > These are not the same thing at present:
> >
> > XPL_ refers to any xPL phase
> > PHASE_ refers to a particular xPL phase
> >
> > Since it doesn't change the build, it must be fine. It's just surprising, to me.
>
> Erm, this is what we have in scripts/Makefile.xpl today:
>
> ifdef CONFIG_XPL_BUILD
> XPL_ := SPL_
> ifeq ($(CONFIG_VPL_BUILD),y)
> PHASE_ := VPL_
> else
> ifeq ($(CONFIG_TPL_BUILD),y)
> PHASE_ := TPL_
> else
> PHASE_ := SPL_
> endif
> endif
> else
> XPL_ :=
> PHASE_ :=
> endif
>
> Which is why I sent the two fixes first, for places that relied on
> CONFIG_SPL_FOO=y in a TPL (PowerPC and their spl->tpl->U-Boot chain) or
> VPL (sandbox didn't set TPL_DM_I2C but did set SPL_DM_I2C) phase of the
> build.

OK. I believe this means that we won't be able to say 'build this for
any xPL' without adding a separate Kconfig for each phase where we
want it enabled. Is that right?

If so, that's fine with me and I would prefer it.

Regards,
Simon
