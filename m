Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22A7D10ED665
	for <u-boot@archiver.kernel.org>; Fri, 27 Mar 2026 12:24:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A4CC883F14;
	Fri, 27 Mar 2026 13:24:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="iKcRx7u1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7ABFE83FA3; Fri, 27 Mar 2026 13:24:19 +0100 (CET)
Received: from mail-yx1-xb129.google.com (mail-yx1-xb129.google.com
 [IPv6:2607:f8b0:4864:20::b129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B64283DA7
 for <u-boot@lists.denx.de>; Fri, 27 Mar 2026 13:24:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-65003f40a22so93700d50.2
 for <u-boot@lists.denx.de>; Fri, 27 Mar 2026 05:24:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774614255; cv=none;
 d=google.com; s=arc-20240605;
 b=JhOErb1uy9yuuwrNVPzwdoLmKDJQShw763J9OKEC5x82KsqaMiFgTh5LGo1edeJ3Z9
 eTrmkTmkjED/QJz7wC53pX+K6971jbT3Y0sqaiwEwfjVCSpFQ85mDeninBfDYtx0Ft3k
 BaoYI//tvi7LdX/f8t6C5XPZ51+nMYAi5K3yQU3+SgDtR8ql+MK9ZhbbyvC4lXH868lu
 +ZB2PDlqr/Su2MXiGyKEtnDJSpGw+/rG7D+LT+S5MUGCxQqGRPd9H2tbi9lD6Z9uoLJj
 CpqwWofs12MaO1umaeV2gYpsFkSl+N/g2qVMti5pPGOuAVMi1AsIDXBz+wEZtnzRhZ+p
 zm8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=CIsCRaeQiP6JpG9owRiWK63WufcRQ/PkdUerkJTeElU=;
 fh=buw8sXupRMq6VAXiJdRPjqWbN/pDaxlghodT8fmeUfo=;
 b=DIrUYzSFd97bjQQSjv7Fkd4iukla2yWevJAodpIV5o97mdVpurjvxp2XtXFHDhDznE
 U+4vU+ymSTJFF22j5Z/h48VXvCs/QpxfDuK09VYeR89oaRN7t0FVutY02X9pTV1aBgtS
 6dAgLgNqFiawLZyP+cx+OvtqBvh0wzZ13QxDBjtpvpER1xJ4qquVQeMEPwH9xnjeq+IJ
 8PGwATIe28eclhY+9Z+wjbyP2AZXeWmdJ58KupHqF7Uzke2t7JK0mijtBcFImwzoUu9D
 9Fx43QMrMBGEGubq8ur65jEcJxVEh2/jyJJ/U15S+W46MIEtAmbOg2XY6E+j4idGbWC4
 zHCA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774614255; x=1775219055; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CIsCRaeQiP6JpG9owRiWK63WufcRQ/PkdUerkJTeElU=;
 b=iKcRx7u1yhCc8fD2zoRyUGa9ufz0I/sqcV/uWwUdaguWzZa5F+zhg87yDK5ib1m8sJ
 z7sR3BtiTed0zv6i6TFFE7/dFhcP9JpDEHnVD+51MlvqF3cv8w3B8ZcxGjPXOucp0O8A
 /GyEjPMIve7PLU1tqdoq0TAgq1Rtgm12uk/73WsQZ1zKekpkcWiWc4FQW9lw87iywU+x
 Ach46xZXEbbsyuK/iojq/ps3IayjPkqm5SfXTNmMIc+vn3he/gG2Gb+Cn1pqNKwShopF
 Z63oKxfbLfranWpOSgWrr3aGu//nmy5u11JZ8ONtT87x/c105IQVgex1B6dDyyw6kW0E
 9PKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774614255; x=1775219055;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CIsCRaeQiP6JpG9owRiWK63WufcRQ/PkdUerkJTeElU=;
 b=Coq+pFsw71TkAPlUe7Is8dI1UtL3WZUBxTWXf54LLTBGO0IAa2EsfSJDNzPRHChlt1
 1sKucYy/74dUvOB4x5Gq2IoyefejIXbPiazokTSkvP7gNDbvVNEEzxLrKb30lUFtm5Fc
 SI/tl9L4W2V+p9tfwDNB4idUlY3RvNMVKugrIAG0gWZw3V+ZbkC9XjQD8zfPOUzq6PyX
 loGx5NH4Ors0kYmJqqPPVb470RN28ISLjyiCjug8brxRk0bd54jS3EmSbasRXnObtsM6
 W1n9WoHuWeeySoOAyA3UoZqC5az5LlUryWDILgXVrIdpErn4lOy4XM7DbJvG2B7sJ1YO
 FLNw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjazyhf1LOlsPdb0HpxiifeM2FeHYo6N6HbIEdc3SeBMKiKFSMosOcmqBxDo/pZB546BOe2Do=@lists.denx.de
X-Gm-Message-State: AOJu0YzujCN7nSzUclWcXY/apY/m4YvuH7rzc5sHLy1VyPOxKSq7hEym
 sTCa10cOB1oHwbdJdFgpGkK5XqG9Q8yyrTvCWSlwzILJ9MoUiuTFxr0LR6fs5vayDybCUUWnVH9
 KZFFW3CLApti0mxaojycVQi5rnoNX8uHeQzZnQeI9bg==
X-Gm-Gg: ATEYQzypjmQsKWnHXozWb+7zuQ+qWcJORE7BmBcfDCCWLs5cUaOTglAi2ZoMroKXJJV
 Jy5OQktvTo7YHZx/nFp7278O6l9Zix6LaTIkLBCRV08q4AP8LFZ5cJWSJ2B9AtDA6kaNG4ES1MG
 Z4ys0ijZTiZmTjfHwTun1OGM218fUPnA9nLhq9iFx6WrlAHTk/oZM8TTnSXook8F97x8eMbnGTb
 Vd5GbwDQvsPKmXe/+lXA8KRFJzQHGnINyFs0tP8uHX5lBHLvjHRRKfsSBQM/H4VDO6WE6QM7qfR
 c7pIuGHRe83zlOaUm6rjTIpAIl44pp34gz3sGS2tT1ZyGui0faglUVVV0xnOWU6eNi5zQkDsrAt
 eRtHdGAQFXtYQzTuRzkPg9nJbmXyxm/mYnSgBakY/J6168IMMDvZeFv4ZQWkLPDKpAREGT74XJC
 khpPegGOJdbO4xSoDUSV/apFrEac/aQXhwm66Pb9zXWX6Fmv2Rj/NbayIa4EhV7zL8Rb8cicLJK
 wBJvyLc2wlLlXJsm3MTYrS7qY2thCPN8mR+TYW7cKxFY2TIfCMVdk6v87UVlPHQzcMnArmOvGVt
 CQzQWUu1lthhkTuCyPqjkXY3h7+DBUSj2i1dIwWVs0sk
X-Received: by 2002:a53:ec85:0:b0:64f:1278:e7b1 with SMTP id
 956f58d0204a3-64ff720d030mr1516366d50.23.1774614254643; Fri, 27 Mar 2026
 05:24:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260326115111.1631261-1-ilias.apalodimas@linaro.org>
 <20260326115111.1631261-4-ilias.apalodimas@linaro.org>
 <6f6f1fc8-56c5-405b-915f-269d789b43e3@mailbox.org>
In-Reply-To: <6f6f1fc8-56c5-405b-915f-269d789b43e3@mailbox.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Fri, 27 Mar 2026 14:23:38 +0200
X-Gm-Features: AQROBzD73B8cCdlOlNM_XcL6N3aqzKd6MmEIkA4ZoR3NiMkZTPC592hFZ3J46aE
Message-ID: <CAC_iWjK5-5Nn8+-OOQWuPSDwd6ckHyPY2Na-7eGO2tc_1XsLxg@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] common: Allow relocations on the top of the last
 bank
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: marek.vasut+renesas@mailbox.org, trini@konsulko.com, u-boot@lists.denx.de
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

[...]

> >
> > Add a Kconfig option and allow the common code to relocate U-Boot
> > to the top of the last discovered bank.
>
> The commit message should really clarify the current pitfalls of
> enabling this symbol, including the part where ethernet transfers above
> 4 GiB used to work because of the packet buffer built into U-Boot, and
> they will break because the buffer is now relocated above 4 GiB too.

Shall I just add your note from the RFC with a few adjustments? I.e

NOTE: This currently might break platforms. If the ethernet
      controller cannot DMA above 4 GiB, and once U-Boot does
      get relocated above 4 GiB, the packet buffer which is built
      into the U-Boot binary is also relocated above 4 GiB.

>
> > Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> > ---
> > Changes since RFC:
> > - new patch
> >   Kconfig          | 7 +++++++
> >   common/board_f.c | 2 ++
> >   2 files changed, 9 insertions(+)
> >
> > diff --git a/Kconfig b/Kconfig
> > index ce25ea24a60f..b9144878ce0b 100644
> > --- a/Kconfig
> > +++ b/Kconfig
> > @@ -474,6 +474,13 @@ config SKIP_RELOCATE
> >         Skips relocation of U-Boot allowing for systems that have extremely
> >         limited RAM to run U-Boot.
> >
> > +config RELOCATE_LAST_BANK
> > +     bool "Relocate U-Boot to the top of the last memory bank"
>
> You may want to call this "Relocate to the topmost memory address" or
> something along those lines, since "last bank" is a bit opaque.

Ok

>
> > +     help
> > +       When U-Boot relocates, it chooses the end of the first memory bank.
> > +       Enable this if you have multiple banks and want U-Boot to relocate
> > +       to the top of the last available bank.
> > +
> >   endif # EXPERT
> >
> >   config PHYS_64BIT
> > diff --git a/common/board_f.c b/common/board_f.c
> > index df2b0dc899bf..7c3fbeab17ec 100644
> > --- a/common/board_f.c
> > +++ b/common/board_f.c
> > @@ -321,6 +321,8 @@ __weak phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
> >                */
> >               return 0;
> >   #endif
> > +     if (IS_ENABLED(CONFIG_RELOCATE_LAST_BANK))
> > +             fdtdec_setup_mem_ram_top();
> Return value may need checking ?

sure, but should we panic ? Or print a message and silently keep the
old reloc address?

Cheers
/Ilias
