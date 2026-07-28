Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 807CFC531F9
	for <u-boot@archiver.kernel.org>; Tue, 28 Jul 2026 11:18:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4E14B40964;
	Tue, 28 Jul 2026 11:18:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FC3TiKXfYnzC; Tue, 28 Jul 2026 11:18:38 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9D0134099E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785237518;
	bh=6+21zlVzOvQQKnD9k7M0ctdnGbW1W+idV+htZ97S0RU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Od5OH2vFZixY5wZ1EzDWzAga2pxFiIsZP6p59tTdTMIb+NhKMViJkbFziE9XneqoR
	 vxsAj9sMkJcX/1OBWhn7Al/HDk0V8i2G/37KvhcukAHgiYaYIZd29NZ2O1skoFpcBv
	 dU/owcfyjfQ6Y594wFMMC1fHoYevWzIDQO6Bf6nhPLYelEXpMrydHTFxvZcdvytlMI
	 figPhrIWg/GLC3BV28Kh4ATVKoWQMGrWYKppcvwFheSfYYTSd2cpPBjgV+u+Ykn+xp
	 VGkx2dO4a9Dhz/eXIvh/RsKbVu/mxSnxHsFq9Pu17Psm+U+3D085HVj+PfoC6z/kM6
	 B6LXQtDS0jmzw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9D0134099E;
	Tue, 28 Jul 2026 11:18:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 130F942A
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:18:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0544581292
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:18:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oqTkzvLpU7j7 for <u-boot@lists.u-boot-project.org>;
 Tue, 28 Jul 2026 11:18:36 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::536; helo=mail-ed1-x536.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org B4E948128A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B4E948128A
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B4E948128A
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 11:18:35 +0000 (UTC)
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-69e2266b07fso5054247a12.2
 for <u-boot@lists.u-boot-project.org>; Tue, 28 Jul 2026 04:18:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785237513; cv=none;
 d=google.com; s=arc-20260327;
 b=qjAtxyXs5D2QG60iZQCbIroAYqqkIOrrT655aPyULHVvppfBgNKuKZ1I0WUVf9tsko
 8GhpxFruxUtBc/xdR7eS+W2xU/uoR+F7oLP8muS5rhaScbWz4HyHJSFhrvtKfOBO4AkY
 QRGQwzCg7nKZuAnHy1uHXc/fjCI6ikmyETlFuF4QwD2AS7DYxhdvdMZSiqFFjrDOwMXM
 o6MHhhpUR7VWYKEcs0Ad+/fJDkrMpkREvpvjBVkUR3gIG1ufdAzpPP4wtI3JlNwijLfA
 Rh6dZf1KWkJk5weFdVSfFtr2MDw/vu0//cwFc83kJzoXzhkaGwjrS7UWIhR1U5EdJ2QJ
 2dyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=6+21zlVzOvQQKnD9k7M0ctdnGbW1W+idV+htZ97S0RU=;
 fh=GWP/HzaNTe/NOwZAWViuNLF/Q4zTK91jF6eNw6VUJ/Q=;
 b=OMDDUunXfxI9B4ZHK2jo7OOK3d7zTHYyK9wHyrapF0NqpwIsS1iV0TQdHlfifTRBaZ
 hWN8/ElOQFkCy54+kBu8FT1IkSJ10cK5BeMACM9ve54nTYdEjtYa0wgNau93RZk9Cts1
 yH+pqJxst/xv6YK91LaLsV2ZPD6KD0C7GDETMKXUzvhB9+HRKDGX0I0U4CEy+io8Dien
 hv7x0C8vifiBt9jXQRYSeAVpexwUic3uBQr6C3kRT/XAwRCa67oDJ/dJjPlg7gD42UaE
 Lnz2ZpbAa0FrYWscV/iybQweJ11MlkSJWHDX3SlXNu7C0+shAqGgqwc5X9v+5MCioyTv
 fnVw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785237513; x=1785842313;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=6+21zlVzOvQQKnD9k7M0ctdnGbW1W+idV+htZ97S0RU=;
 b=mrudJ+40WTj+l0yLSwPcbWy3PSJHHZCPpdVuPctZN5AmPlZS84eAM8iqAojurvkBzs
 NiyRqJaf98cajI0OvqRh4V0bOjqRsC/a9E/XS3IQszkExOR/7wUUwC0ECwwfUpOalnjl
 8+qN5+ZsPaKw99OUV1USqXoybF04VxL1jhM/TO+IRdVl9SJ73cFL1ziegT/EA3yA/11T
 w5ZJwA3ePr/+ZlUwTql+2b75bYeKEJnofTLdaI3rOmjevcQkUAxNlq0LCtX6TbN66chn
 SNjl3sCj8PfY6f/PTRNyJPZm3fSZAX9ETnfINlWFGU5bkwYhbI6JBgiDk7NqilA7t+ia
 U4mg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoID+2FjYimUBqzq8puW7ztYidQq/UmohByNnzYIhux3qNCnpEO9Pg30IHWZaAy2Vj14eDDjLI=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yx9rSIE4e/TrbvH23l1r+/gTEBcGBYoKUkLQkDEXeUDQQzOinfM
 mt0rchdB0FdbmZCZzUwCjys6C/9gNPtxGbckuVYKia/yIrr99MGlACwdpZGTbl5jG0T71Fyly4H
 90IgcCA11TyBv9fDmu526AIAX4MNFXOW27FFVyO1P
X-Gm-Gg: AR+sD11M5sh7309B5kgGWiu42W0JDPf5mj5bg50/2/YkcG7ha9Fzyp8bzic+IXOnrFs
 5FCPLYvStsy4URbKFKMwsw+q25HvIOpvY0iJcjrUZqjdC0jH5X6ttvV3GQYvgyWtghOsZYcdc5o
 fYHRrYbgtl7kSZH8jKWso8oZxqSEkFfIbEP2YUV9uRiDDb/dFtITshO9ESWLz8CnPhZiCbNrcpZ
 pVRCl6mmwGasPD+5M7+bWkR4Qqhc5My7K92M6aKuDqethy81SBuohMjBQwp
X-Received: by 2002:a05:6402:e88:b0:69f:fa13:ed3 with SMTP id
 4fb4d7f45d1cf-6a034a62425mr940933a12.16.1785237513487; Tue, 28 Jul 2026
 04:18:33 -0700 (PDT)
MIME-Version: 1.0
References: <20250914110021.4103-1-aristo.chen@canonical.com>
 <20260721152110.283998-1-aristo.chen@canonical.com>
 <20260721152110.283998-4-aristo.chen@canonical.com>
In-Reply-To: <20260721152110.283998-4-aristo.chen@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 28 Jul 2026 05:18:20 -0600
X-Gm-Features: AUfX_mzTnz-fcDguuE56t4cqb_SRqzXY7gBUsyBrHcsjs4u-jKs8AbkEhP9H_-k
Message-ID: <CAFLszTgvgLK9Mr6C9FSVNhOdj=YWGnkSfg93ZoDLNZQkE+gAMg@mail.gmail.com>
Subject: Re: [PATCH v3 3/7] binman: Fix FIT image overlap issues for
 testFitSplitElf
To: Aristo Chen <aristo.chen@canonical.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785237513; x=1785842313;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6+21zlVzOvQQKnD9k7M0ctdnGbW1W+idV+htZ97S0RU=;
 b=Ce+ZzdL4qx2Gg5AC/xL33W2P+oXff2OtBhddCu7eh/ji79z/1Glx7ebXGWmQBxEJvb
 pzug5UoBgoKOQCffFVDRgG9LTDhCGeuhtq9eGRdwIPwt+NpZ77rUyBx4zOOVmK774bjv
 NmNvGQHGINRgbz7gAeEHImGYLdaEmfsoZEgwA=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=chromium.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=Ce+ZzdL4
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Aristo,

On 2026-07-21T15:21:05, Aristo Chen <aristo.chen@canonical.com> wrote:
> binman: Fix FIT image overlap issues for testFitSplitElf

>
> Fix one binman test that has memory region overlap issue, the test case
> needed to be updated to use non-overlapping memory layouts.

This first sentence is a comma splice and 'needed to be updated' is past
tense. Please use present/imperative, e.g. 'Update the fixture to use a
non-overlapping memory layout so the two images no longer collide'.

>
> Fix one binman test that has memory region overlap issue, the test case
> needed to be updated to use non-overlapping memory layouts.
>
> * Tests fixed:
>   - testFitSplitElf
>
> * Changes made:
>   1. ELF section layouts: added elf_sections_tee.lds with different
>      address for TEE to avoid overlap with ATF address defined in
>      elf_sections.lds
>   2. Makefile to properly build elf_sections_tee binary
>   3. Update ftest.py to use separate ELF files for TEE vs ATF components
>      in split-elf operations.
>
> An upcoming commit will validate if the memory region is overlapped

'validate whether the memory regions overlap' reads better.

>
> Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
>
> tools/binman/ftest.py                  |  2 +-
>  tools/binman/test/Makefile             |  8 ++++++--
>  tools/binman/test/elf_sections_tee.c   |  1 +
>  tools/binman/test/elf_sections_tee.lds | 32 ++++++++++++++++++++++++++++++++
>  4 files changed, 40 insertions(+), 3 deletions(-)

> diff --git a/tools/binman/test/elf_sections_tee.lds b/tools/binman/test/elf_sections_tee.lds
> new file mode 100644
> index 00000000000..84a4123ccfe
> --- /dev/null
> +++ b/tools/binman/test/elf_sections_tee.lds
> @@ -0,0 +1,32 @@
> +     . = 0x00100010;
> +     _start = .;

This is a verbatim copy of elf_sections.lds with only the two section
addresses shifted up by 0x100000. Nothing ties the two files together, so
a later edit to elf_sections.lds could silently diverge. A one-line
comment noting that this mirrors elf_sections.lds at a higher base would
keep them in sync. What do you think?

Regards,
Simon
