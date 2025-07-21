Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82C33C83F27
	for <u-boot@archiver.kernel.org>; Mon, 21 Jul 2025 06:22:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B6D7A8304F;
	Mon, 21 Jul 2025 08:22:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="i9nr5cxL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9831583093; Mon, 21 Jul 2025 08:22:02 +0200 (CEST)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BC81183013
 for <u-boot@lists.denx.de>; Mon, 21 Jul 2025 08:21:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-7183dae670dso36399137b3.2
 for <u-boot@lists.denx.de>; Sun, 20 Jul 2025 23:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753078918; x=1753683718; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gabnE3YZYGDf+rO3oELiACmUJ9XzR7UM3KRNbVkeMJ0=;
 b=i9nr5cxLjRzambe2tGO+02c9CXtt3Csho4pOWB5SXH/5GOPdEAf09kjLmYBEzFbPFU
 sedHP2pv8FVocmmvJFeoiVzFuBkLnvYRb37e4OR/qMV23JpLrxYZennlxtsxvU/fssu5
 DmQYIAVVuXix73TW9H14CqYFsTPi9L1QM/oFEpvblm+uK+JUiWAQ09BFmR8qndgozCEH
 dX3zuSaYBwIkDZgg1FT+VVhoiV+X20ckPr5XfvaDwZt+9PDwSptVIiUkwD2QvXpgp4PH
 dpBMFAVQSx3tX5o/fozwJDK1rZas1ADaKgMHu7AKnGXc37PRNQvBBiIKF6u8fw8Fed/D
 2f+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753078918; x=1753683718;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gabnE3YZYGDf+rO3oELiACmUJ9XzR7UM3KRNbVkeMJ0=;
 b=bIRXItTcR/tFPZPjiI1AYvkNCt8suM/sSFOnLT3I9PjjuS8E2BnPecL78opgAh2ued
 Z++er5iX/C5QyRqm+ORPexuvtPSQeopnYl/TYt/hiyYDghCnzkMyd6PEhbUBhlDvz1iF
 KPz7wB0nt90NhCEtpsTjNz4eZ6aBE69kJcTR6K951c2oCLF+Fe1ltwLU6mSZBojk5GUU
 p4Vl9kSrmw5quaZSmy6H+d3rpL0bCKG/yV3tKeJymL1L1hFXQU/G1oZIS/NlHM232MKM
 w3RzpU+YzpHrMUfMMTCMIEUajpGCt6KsjozvVN17DMEM+kgUK8GAALsSDZZ2pkS+3KwI
 wylg==
X-Gm-Message-State: AOJu0YwN0/vDS8JCo1VpAo42f2KSK4dP9TCe489TBuuO9i02bdgRNfbe
 EDIz4yr78vxt4OgX/jIAtR0w4oyMbve4ftZraSYokpt+v4vTpsA1Mhji/omwyVc3MHFOaa0Kon+
 hhJl+0TGUlAllxPDo0LwyysxqM74C3Zpv8uX9Z0nGBg==
X-Gm-Gg: ASbGnctgAJ93cvLv6Ml9cbwq6DAxY1Ygu1y4fU1gILoU3kJCVVFEwX3zLHSfCtCfEJJ
 gZrs9uvTjhgN6DxnEEtumsCVH7w9G7L3eVNv6mscFnC7a4Dm/AvdHL3ZXuwXu61YROBzpRWb1q8
 1LbCaANHEgJT2UwPejj8tgk/nkQMIFBI5jLqcIAvHS7EHkiS7NdbBidwlJ3eqc+ZLB+u8MWHdt/
 zkXK3g=
X-Google-Smtp-Source: AGHT+IH0NRFRLF/kFMA9nuBngULslWQpDgq2SBZKNB0cXHKjGFR5CwAeGX9LR+ZJxypLsloEGEPYyg07FizF8vegRi8=
X-Received: by 2002:a05:690c:650a:b0:710:f5c5:c9bf with SMTP id
 00721157ae682-71836ca2a21mr239577107b3.15.1753078918440; Sun, 20 Jul 2025
 23:21:58 -0700 (PDT)
MIME-Version: 1.0
References: <20250712104558.77355-1-kettenis@openbsd.org>
 <175286780960.1647311.4448267827855078528.b4-ty@konsulko.com>
In-Reply-To: <175286780960.1647311.4448267827855078528.b4-ty@konsulko.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 21 Jul 2025 09:21:22 +0300
X-Gm-Features: Ac12FXy-ze5wZ9azbxoSlmpKp_tN94ymSfMmLaM9vvkO-OOuLFrj9yjvlxGDSnY
Message-ID: <CAC_iWjKq6b9WR+Nh09uwxFPDAp1-Wd3U7bT_e=L1ubV8ZUabGg@mail.gmail.com>
Subject: Re: [PATCH] kbuild: Don't mandate gcc as the host compiler
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Mark Kettenis <kettenis@openbsd.org>
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

I was on PTO but fwiw this looks ok to me

Cheers
/Ilias

On Fri, 18 Jul 2025 at 22:43, Tom Rini <trini@konsulko.com> wrote:
>
> On Sat, 12 Jul 2025 12:45:58 +0200, Mark Kettenis wrote:
>
> > Systems that use clang may not have gcc installed.  Set
> > HOSTCC to cc and HOSTCXX to c++ like we did before to make those
> > systems work again.
> >
> >
>
> Applied to u-boot/master, thanks!
>
> [1/1] kbuild: Don't mandate gcc as the host compiler
>       commit: bd0ade7d090a334b3986936d63a34001d99722ad
> --
> Tom
>
>
