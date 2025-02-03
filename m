Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DAA5C02192
	for <u-boot@archiver.kernel.org>; Mon,  3 Feb 2025 16:18:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B5A0F800CF;
	Mon,  3 Feb 2025 17:18:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="iVfQOAYE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5DA3800CF; Mon,  3 Feb 2025 17:18:17 +0100 (CET)
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com
 [IPv6:2607:f8b0:4864:20::b36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56A8480079
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 17:18:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-e53a5ff2233so4757750276.3
 for <u-boot@lists.denx.de>; Mon, 03 Feb 2025 08:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738599494; x=1739204294; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Q5LboFVt1FUHNsJ4f9+Va6Isf3/iBl9cYkzb5TLjrFE=;
 b=iVfQOAYEKLcjiTZtfajWx+kJJrAU6oFRV2SKgWWDSVwtIxq5NTJlZSyHl4BuVp390O
 G8vIt0ahrFK3uzFkf1paw8vWnSRziK3+KSKuLh5ECHX1QB2lq+V6cFvsEDavIl5km6xu
 zVjraxHRGtyJFkvpfHkW5C89G3CAprzluT+rAGNFfiadbVDANj4OT9J+xr1qUZNVfIs1
 H/zUHbEsPadmmEidlB7V+sdyRx+YgLOGQLyk6A+b3x1GvOiv6y1WZBLllLPbVewxNcPl
 g6IT/CJ8ra90655rWuj7+prvXK5IqtuUyp7o1lyf+stEHBIoACJnVxSzQSIydzF2lwSM
 Qe4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738599494; x=1739204294;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Q5LboFVt1FUHNsJ4f9+Va6Isf3/iBl9cYkzb5TLjrFE=;
 b=chwKGTqWT4KrWVoxLL1739nNCpGmyzIv8f50Hm2Np1uEm9u2S1fJ6i0QwOqgbIevIK
 v+Zl6Ce4Z4jYeD4UYqF5ztgdSEq299gyPgRwUi60xjcvvaHZpPVNZCDFCSTsQp5OB296
 SMNu08HrsUbr+SAEr3WjreAAJg9ijgrMP2syljqJJcwVJlfYkNIHyJDE8pDo8Msy5CiV
 7ql+uHVDWAwQdfHzVDk6mxcZhZ7wz6XjzP55vBVPdX+BmgIR9Zb4I5whflk4PqSoY/6z
 2SlN/dRxeceAi+4+qXGqCmDqY7fwh6kcqbGHiNucW75KmWYPzcoSsyeGE7rHI6JeEnCa
 +Z9g==
X-Gm-Message-State: AOJu0YyYO3YMUGG8eHlXo742jYIi7ZIsdUtrmvzdz+pySxgItqBMC4pJ
 Nd2wTp9KHMD7zMp7HFrBWe1ZggmVEHhIauXvmX4ukBttS078uNXlyvKR3z3v/iAYAf+FVxsd3hV
 OEwARSMTOE2VmL9XEZNfW5hW04XiUmuWh4YpzLg==
X-Gm-Gg: ASbGncu9GpSNThnMFClpfKGEON4GjQ9zb208RtaNh9jxmVub8qXEKDZLCrC5nN7TdqA
 7w22aVwCgSCTrAoLiAaCILHy5NCfB7B88KE7KdcMM8pMGz9WjOrL/istThP+JNSHJSKnGMVrm
X-Google-Smtp-Source: AGHT+IHiRzTGu4f3gP1gPHNg6j/bFsBYJqrn/5/Fc5W7LceWW7QbjbYLawQ4+GBJTml/dbt0lLik8VOO638p3lcKYMg=
X-Received: by 2002:a05:6902:f84:b0:e58:1501:23a6 with SMTP id
 3f1490d57ef6-e58a4bb016emr15194381276.43.1738599493994; Mon, 03 Feb 2025
 08:18:13 -0800 (PST)
MIME-Version: 1.0
References: <a594ad9352a4935df53d664a951473a2b1f5fafb.1738594978.git.michal.simek@amd.com>
 <CAC_iWjJ05Ge10G8KgXEqb7zuRboYxH7KVQC8FdrjptTfTpZ74g@mail.gmail.com>
 <dfc58bae-06c7-484f-be1b-a3c5acf58cd3@amd.com>
In-Reply-To: <dfc58bae-06c7-484f-be1b-a3c5acf58cd3@amd.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 3 Feb 2025 18:17:36 +0200
X-Gm-Features: AWEUYZmSgm088RanMUCuSqrxaRp-ocuBlR9ZklOiQEte23FsxTyHYWNGMByBGok
Message-ID: <CAC_iWj+7mE1LmxpwV4tWTMXx_UBEcNFfT60Kk+7963ctUxm6Ow@mail.gmail.com>
Subject: Re: [PATCH] net: Kconfig: Select DM_RNG for LWIP
To: Michal Simek <michal.simek@amd.com>
Cc: u-boot@lists.denx.de, git@xilinx.com, Adriano Cordova <adrianox@gmail.com>,
 Anand Moon <linux.amoon@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Joe Hershberger <joe.hershberger@ni.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>
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

On Mon, 3 Feb 2025 at 17:23, Michal Simek <michal.simek@amd.com> wrote:
>
>
>
> On 2/3/25 16:13, Ilias Apalodimas wrote:
> > Thanks Michal
> >
> > On Mon, 3 Feb 2025 at 17:03, Michal Simek <michal.simek@amd.com> wrote:
> >>
> >> LWIP wget.c/mbedtls_hardware_poll() is calling dm_rng_read() but dependency
> >> is not recorded anywhere that's why select DM_RNG when LWIP stack i used.
> >>
> >> Signed-off-by: Michal Simek <michal.simek@amd.com>
> >> ---
> >>
> >>   net/Kconfig | 1 +
> >>   1 file changed, 1 insertion(+)
> >>
> >> diff --git a/net/Kconfig b/net/Kconfig
> >> index 24508026200d..6c684624fd6f 100644
> >> --- a/net/Kconfig
> >> +++ b/net/Kconfig
> >> @@ -249,6 +249,7 @@ config WGET
> >>          select PROT_TCP if NET
> >>          select PROT_TCP_LWIP if NET_LWIP
> >>          select PROT_DNS_LWIP if NET_LWIP
> >> +       select DM_RNG if NET_LWIP
> >
> > There's a WGET_HTTPS symbol, I think we should add that there
>
> You maybe right but there is only WGET symbol used.
> obj-$(CONFIG_WGET) += wget.o

It only enables HTTPS if CONFIG_WGET_HTTPS is enabled.
The whole machinery for adding https support (and calling  that rng
function) is protected by an #ifdef already.

>
> It means likely wget.c should be split to HTTP and HTTPS version or add some
> ifdefs to that file.
> I of course prefer to fix this issue which is visible with microblaze
> configuration which one of my patch does.
>

What is missing is a check in wget_validate_uri() and forbid https://
if that symbol isn't enabled

> Thanks,
> Michal
