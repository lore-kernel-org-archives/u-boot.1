Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 596F0C3ABCB
	for <u-boot@archiver.kernel.org>; Sun, 11 May 2025 14:18:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 48F4280ADF;
	Sun, 11 May 2025 16:18:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jxM+Nq33";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB76D80C83; Sun, 11 May 2025 16:18:11 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 12D218091A
 for <u-boot@lists.denx.de>; Sun, 11 May 2025 16:18:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-ad243b49ef1so174365466b.0
 for <u-boot@lists.denx.de>; Sun, 11 May 2025 07:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746973088; x=1747577888; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=aeCj9k2YBa6NdC004Eiv5EdqaJD9EcwvkNY769cjYbs=;
 b=jxM+Nq33hxaI2VfD6Jko1hekEMZnNoVzjbgx4vXlYan1PFsUVW/w/c8Jk76VVQfZmp
 6awgITVIC35BxQZBfVdOdTWTCVA8dz6EVbzG8nnO7HP4KitkPtAyqyNNKYLljtGYYmt2
 3n4pllOFJVg+Z9UWRkxLGkmpWejU0vHsel0Ek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746973088; x=1747577888;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aeCj9k2YBa6NdC004Eiv5EdqaJD9EcwvkNY769cjYbs=;
 b=l1sIpOtXpxhSm2cPrZR8vxtGQN66CQ/V3TAuaQxIktUjaj/t7f/JSGR6IpUOHgcBbD
 JIVenQcgT57tKCN5GvKcWPxU9x7vlEhM65IU0okuMWPIgrmss5TDsFUaeKxcvipAlKq/
 kw09dUAlVDvwzj0voq5J3RZeUwaUPWxzjcH4UGg4WCgV7WO96LEehPRPjTWyBoghro5f
 g9X5ZI5W/HqpoDqudrh8YcFVgLMhWlmJ80xc2X3VU1N/oQjLdHlO6s9ePGmsLIbOrkib
 MyYZrXuQsunlLOEzO6QcKd+CSSKbzHtrE/Q/x/hjSIor7x8ixJlLHVmlVr/jyYuy+ZsK
 kK9g==
X-Gm-Message-State: AOJu0Ywh/n3TjJGXVV411z8AM64yIbycQM9ZEbRVQYlt9JARnoMGCP0M
 FOVK7xkcwnwi20NMeVolgsAzdqpJCldY0AGxYHyARq43GIWK6DriFe9okKgeHqrl5BVeDV1OzvR
 1Je62NkgQcIKLBadsxxBLBZ38gxY/e1NpF0h8
X-Gm-Gg: ASbGncvJDApK75OUE6xNPqsa9bxQDS5xBHbxfg3CnnJm8AC4hbzDi8GUx+9vTkkailq
 NAUmwfnnFrAV/oNYHhhouTBcWPxXb1oHmuj9RnQ8b0z9Ckwdn7sYp3lUXeNl55CbgDQuJwgtp4r
 j1QF3SMKcsMZkhaBYRJ6sUwf73eC225FB0uQ==
X-Google-Smtp-Source: AGHT+IG2AwyYSbEsZ7Zp7ZKR2MNAxTbtUe38QWj592sBIv3/8VeMtx3tSGfGDQuPHEmlnQ3uVPR8HIUEtXuAC8l4QAo=
X-Received: by 2002:a17:906:4796:b0:ac3:3d10:6f with SMTP id
 a640c23a62f3a-ad218e52dd4mr864622466b.8.1746973088449; Sun, 11 May 2025
 07:18:08 -0700 (PDT)
MIME-Version: 1.0
References: <20250510125457.1571220-1-sjg@chromium.org>
 <20250510150523.GL603748@bill-the-cat>
In-Reply-To: <20250510150523.GL603748@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 11 May 2025 16:17:57 +0200
X-Gm-Features: AX0GCFtXQJpXczB8zbzWM_UO9nIGs0XBH66f6LkAYVVcgd2Sg9XSXw6FM2v9MXE
Message-ID: <CAFLszTjBX5kc5dpJF=0y4ZoocHUhUyo-jr+AOhpyt2DSkrC0cQ@mail.gmail.com>
Subject: Re: [PATCH v2] efi_loader: Disable ANSI output for tests
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Mark Kettenis <mark.kettenis@xs4all.nl>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
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

On Sat, 10 May 2025 at 17:05, Tom Rini <trini@konsulko.com> wrote:
>
> On Sat, May 10, 2025 at 02:54:38PM +0200, Simon Glass wrote:
> > We don't want ANSI escape-sequences written in tests since it is a pain
> > to check the output with ut_assert_nextline() et al.
> >
> > Provide a way to tests to request that these characters not be sent.
> >
> > Add a proper function comment while we are here, to encourage others.
> >
> > Signed-off-by: Simon Glass <sjg@chromium.org>
> > ---
> >
> > Changes in v2:
> > - Use the term 'ANSI escape-sequences'
> >
> >  include/efi_loader.h         | 21 ++++++++++++++++++++-
> >  lib/efi_loader/efi_console.c | 26 +++++++++++++++++---------
> >  2 files changed, 37 insertions(+), 10 deletions(-)
>
> Since we keep coming back to this, here's the email where *why* there
> are ANSI escape sequences is explained along with Heinrich's suggestion
> of a fix for your concern:
> https://lore.kernel.org/all/ba46d2c2-38ac-411a-a48c-429295cf6efb@gmx.de/
>
> I assume that this, rather than repeating and reposting this solution
> again is still what Heinrich prefers.

We discussed this and Heinrich pointed me to [1], which does a similar
thing. So I believe he is OK with it now.

Regards,
Simon

[1] https://patchwork.ozlabs.org/project/uboot/patch/20250508183034.3439777-3-adriano.cordova@canonical.com/
