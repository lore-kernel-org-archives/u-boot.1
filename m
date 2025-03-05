Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78801C19F32
	for <u-boot@archiver.kernel.org>; Wed,  5 Mar 2025 14:16:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6412808B6;
	Wed,  5 Mar 2025 15:16:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JalE7/i/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D110808B6; Wed,  5 Mar 2025 15:16:12 +0100 (CET)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D74588083E
 for <u-boot@lists.denx.de>; Wed,  5 Mar 2025 15:16:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5e50de0b5easo6031323a12.3
 for <u-boot@lists.denx.de>; Wed, 05 Mar 2025 06:16:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1741184169; x=1741788969; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HzLW/q66v6fHAdKQNLqVdGykobLqxLqZWL82CIShhLQ=;
 b=JalE7/i/16oX4vrDzm5iZkrDQuPS0HtriSOo44n8aNrdZ5pMFT7/xQlPmfZAPDp3Ps
 d3OHUWNCe9FNINITk33Z8Qre8AE+IzRXbcZWKnGkMDGm/+iBaSdxJnBkV62A+io39zir
 C3+f48Io7oTvOzbXHweuZgMnS3kw7XndpleXE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741184169; x=1741788969;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HzLW/q66v6fHAdKQNLqVdGykobLqxLqZWL82CIShhLQ=;
 b=cj5n47e8kAwMDbmVxQDrllMjKwhkZQsP1jDq6jra8ssGKPuSE7tnPcYirQkG6EkIJA
 mqGqhfg7ssm7HgBHS31KTEe88xLTxK0G7nBbovcj5nk/98rbEW1spDhDKaIRjs4Lu3jC
 b2LK2nlXX+pilmJRK+NPvMuAH+hYuCNftrCScylYdSnW76h53saNfhscz3YpEjTgy/GV
 KWa8CZpl37cLj3zjb3v6ryPqTY8cKGdbjbqUO4RdY04Yt8ZrfZ//ZZ/xmddkYiVJyJ0i
 UGp9V+LaodGlkHntbiIjK9om9JVVug/2EzStMNXTu+roItvzoUY3laQVrm2Hu+ydThu7
 5djA==
X-Gm-Message-State: AOJu0YybFWHZOO1kLUlkWL6QRm712gceQhGsr+zyVT7lclkCJ12sA+sJ
 i+PhgMw8NsWpIKm/lHKspRuYWXCNnjRrMnK8tzmxvSh5UOCbbFO6CL1DHlm40jfBV7mTfm7vmce
 HLRfT0k8SI+gOdF0skF651KH1CVz6Tq14Imxo6m8gErZ2Ck8=
X-Gm-Gg: ASbGncuz1maQQeIPNk39rbIYgWUr4nQAkg0NQ3xm5aoMQTrEFr2v6r2u77Ng3tuVWB/
 fULuxWxknz2CPGbXFWWUBJi7z9jl71lALeNPMgegbxCooiUTDPd/NsHkkclvHdH/J/e8CsKG/Rb
 vheqmiZLvfJbZ3mhr4shitiwd3+Jk=
X-Google-Smtp-Source: AGHT+IEtWbENz2nGE/z3v92YCbIHY7cGqlKb1ikN1iObhXVjgT95Pfa1NeCSvaIEoO9x8w809yKk4Zk3f3Q1iJPjxA4=
X-Received: by 2002:a17:907:6ea4:b0:ac1:e332:b1f6 with SMTP id
 a640c23a62f3a-ac20d15e9a9mr317204566b.0.1741184169297; Wed, 05 Mar 2025
 06:16:09 -0800 (PST)
MIME-Version: 1.0
References: <20250304204116.2834889-1-trini@konsulko.com>
In-Reply-To: <20250304204116.2834889-1-trini@konsulko.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 5 Mar 2025 07:15:50 -0700
X-Gm-Features: AQ5f1Jq2GKTxpgBHSOl6_GWGJlIGNBn_LKnh2gydH50C5ayhOusR9XyZh_PIUaw
Message-ID: <CAFLszTgzPq8Sdmk0Fqh19n-TkNBAJ+JwscNfYchRzE1kWQjrXg@mail.gmail.com>
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

On Tue, 4 Mar 2025 at 13:41, Tom Rini <trini@konsulko.com> wrote:
>
> It is confusing to have both "$(PHASE_)" and "$(XPL_)" be used in our
> Makefiles as part of the macros to determine when to do something in our
> Makefiles based on what phase of the build we are in. For consistency,
> bring this down to a single macro and use "$(PHASE_)" only.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Simon Glass <sjg@chromium.org>
>
> This leads a little bit of dead code in scripts/Makefile.xpl that I
> didn't remove as this is an RFC. This also omits expanding on our build
> documentation slightly.
>
> With the following patches applied (which are correct regardless of this
> RFC and so separate):
> https://patchwork.ozlabs.org/project/uboot/patch/20250304203235.2834031-1-trini@konsulko.com/
> https://patchwork.ozlabs.org/project/uboot/patch/20250304202436.2783784-1-trini@konsulko.com/
>
> There's no change in the resulting build before/after this patch.
>
> We could do the other direction and drop $(PHASE_) in favour of $(XPL_)
> but that would require updating the logic of how XPL_ is defined.

These are not the same thing at present:

XPL_ refers to any xPL phase
PHASE_ refers to a particular xPL phase

Since it doesn't change the build, it must be fine. It's just surprising, to me.

Regards,
Simon
