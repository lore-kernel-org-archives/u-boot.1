Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E8D5D1813A
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 20:20:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0F7F8917A;
	Mon, 14 Oct 2024 22:20:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="g7s8A/Vd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 990908913A; Mon, 14 Oct 2024 22:20:56 +0200 (CEST)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 728058917A
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 22:20:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3e4d78300c2so2626701b6e.0
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 13:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728937253; x=1729542053; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=rFBccG6mKD/BY7LF624WUJWM+CRHaSJ+UzWme7qv/Dc=;
 b=g7s8A/VdAn9r1+ZKUiB6ZPKNa9wlHKSAJCAYiMVjEwKEMQYfR0zCDaHHxbMxAFgdNk
 Lx+35NJMzc3kQMx3LttvwXzu3up9helcZjPfasuiCiEibGh5dXFCuVy+JlMegGZ9fbJZ
 YB9EAc4tnH/aLYIfdNeAJ/752TJMgEJWsplak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728937253; x=1729542053;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rFBccG6mKD/BY7LF624WUJWM+CRHaSJ+UzWme7qv/Dc=;
 b=tMCVM/fLXtMXXFBnNfRgeYmiKAMBRN3gU6tpu4tLC63LzClcLOhCg1JwEO1RifKcbj
 tK90iN9rt3PQ6MoWoy0xa/J6ORwT0OBH2cS2EPfkVLQqTS9Ckrc0fTPMA2meRJOTZwf8
 CXwgEHEwv7bBkjwONh6lLP4wddvM4T3WkO2OoNT885PvtHFlhKsx8DXwsCYteHbuohhI
 OR6NruWSGfkN8G7FWJDxNV/pOz/zxyY7DRRlMf7XTt7i3cWrkj6waRjWqc3EQuui0YV2
 5y4EgDchcoMlu6U9yOTV9JBELCsMMY++OdPINJzP8SepE324RAB0ExAzO9QdiaoY9cnS
 hIkw==
X-Gm-Message-State: AOJu0Yyp1Rve1PDeJX+ukYAYwDhTnr5BqDdkgNZcOhZ91fhsvhZ3piIJ
 sc14CqE7EbEVpewVr0vU5lZrhxS/zOvylQrZKj7Szqx9mnu/dL2VXQPBAVnB/Y7Z4cpMMxd+qPs
 yhpHwXRfWuXtw5iOovv2Dk1bluJOLPMSEvoq2AiOTRN/rMF0=
X-Google-Smtp-Source: AGHT+IEf23VvgGEYGxlLZX6dV4jKeBMFzBbXg8ELHUFB0WAKD4e72RXYSwqNSb+9SBwOdPpABiNP5c5ovDJCyjgXHx4=
X-Received: by 2002:a05:6808:15a6:b0:3e3:a7f0:103a with SMTP id
 5614622812f47-3e5d220ddc2mr4105143b6e.15.1728937253266; Mon, 14 Oct 2024
 13:20:53 -0700 (PDT)
MIME-Version: 1.0
References: <20241011212126.747741-1-sjg@chromium.org>
 <20241011212126.747741-2-sjg@chromium.org>
 <20241012012004.GD14210@bill-the-cat>
In-Reply-To: <20241012012004.GD14210@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 14 Oct 2024 14:20:42 -0600
Message-ID: <CAFLszThqX2T0uGmAYvacpPhM_O_JNG9A+wtd0jxmn4ynAuHUzg@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] efi: Drop the memset() from efi_alloc()
To: Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Masahisa Kojima <kojima.masahisa@socionext.com>, 
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

On Fri, 11 Oct 2024 at 19:20, Tom Rini <trini@konsulko.com> wrote:
>
> On Fri, Oct 11, 2024 at 03:21:22PM -0600, Simon Glass wrote:
>
> > From my inspection none of the users need the memory to be zeroed. It
> > is somewhat unexpected that it does so, since the name gives no clue to
> > this.
> >
> > Drop the memset() so that it effectively becomes a wrapper around the
> > normal EFI-pool allocator.
> >
> > Another option would be to drop this function and call
> > efi_allocate_pool() directly, but that increase code size a little.
> >
> > Move the function comment to the header file like most other exported
> > functions in U-Boot.
> >
> > Comments were made in v3 that another project uses memset() when
> > allocating memory, but that is not required by the spec. In any case, as
> > above, from inspection, none of the users need the memory to be zeroed,
> > as they fill the entire region with their own data.
>
> The other comments made in v3 about another project (EDKII) is that we
> want to remain implementation compatible. This is a case where (a) if
> needed, we can reach out and get the spec clarified to say zeroed memory
> and (b) even if it's not, this is a case where real world
> interoperability is more important than strict spec compliance. If
> there's an app out there relying on the zeroed behavior and it's fine on
> EDKII and not fine on us, it'll be a problem for us because we
> stopped matching behavior. So unless in the end Heinrich and/or Ilias
> drop their previous objection, I don't think this is a good idea.

This is a minor point, so I don't mind, so long as we get the
memory-reservation tidied up. But I'll note that the effect of this
patch is zero, since every allocated byte is written anyway, by
current users.

I certainly don't want to be implementation-compatible with EDKII.
Where did that come from? U-Boot is an open-source bootloader with
lots of boards supported in mainline. U-Boot has very different goals
and users.

Regards,
Simon
