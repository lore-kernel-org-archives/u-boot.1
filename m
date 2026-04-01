Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF325D35144
	for <u-boot@archiver.kernel.org>; Wed,  1 Apr 2026 06:46:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1402A84010;
	Wed,  1 Apr 2026 08:46:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="TocwNN7u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC9CE8407B; Wed,  1 Apr 2026 08:46:33 +0200 (CEST)
Received: from mail-yx1-xb136.google.com (mail-yx1-xb136.google.com
 [IPv6:2607:f8b0:4864:20::b136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A18EA83F5B
 for <u-boot@lists.denx.de>; Wed,  1 Apr 2026 08:46:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-6501d32b04bso5679612d50.2
 for <u-boot@lists.denx.de>; Tue, 31 Mar 2026 23:46:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775025989; cv=none;
 d=google.com; s=arc-20240605;
 b=CFYCrV8AghaJTQdvAjZWb8Vui9eHeM9/x0WcN0jTGGR1LNE2t4qvwNiUWlIe47qLGs
 IVLkSK2dJjjPlxpyvyZY9qr2U9KvHbAgMGAhwOWtOvPuxTaXkLE8uWDtVtLd1CriqqPl
 qkkFSc1R1jrSbGgM7YXtuib+cia0OWGj/jHRzpjjKXy/GBvPwjzFnA9oskyVFKQUVPEy
 V614y1yoRebQbZUE3/6pV5TLPo1vrVF4FzzD3J7GE93pMzLY093cvN7HHPqmK6FjpGh7
 quxLcCSFGUcoUgYAFL4dV3/95fJlz3o3iwLszM072fQ4JDwP7u8U8Ud+hxXwt+o4M5kP
 O8yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=ti3U1MzmNGrdfnWD9mSYxfCiKpi0PZKQSBGaTnDH96w=;
 fh=Daf52JUaAIdoTVuKkaT7OpA0KQ4DlZ1vf3ML9NFYNfI=;
 b=L6V97zKnDjEms+OGk/6DZ/WE3/0sWhUaWVN7YBQAn7fg29kvTMflUE8kmbrwxr23x1
 t7PKzwGJAR4T5gsCnWVmuzPEjiHlE0QOhKRO2uKmXig4cP+kB45H/OAKU8EX6/bFKyUt
 FvTNaSkoz5nwWAnSSQ5PEjC/fenKGEX254Ou2Y+Oeccu2NCEC3i/eSw8v5bXduD7bLJS
 5PezOmN4Kw1v76CIimQ9XL7OkPh4EqLGpcvURNGKa0maxe0VAJpr9tw8cmgs50I05+ED
 NmhmjDUb29U+0JIM5YqgC4EfEg5vFvb8Ib2MYkKY6e8gftap+zUrIi+QnatJPDTuzQWb
 ipRA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775025989; x=1775630789; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ti3U1MzmNGrdfnWD9mSYxfCiKpi0PZKQSBGaTnDH96w=;
 b=TocwNN7uqgzQRoWgfmcX2T2E/JvmJv2VDGsJ3Uq6csDWvKwYVYg7udKToBTVPghsj/
 dTIHaXFTzr6wrylfWmTp8D6mUQMALVwU9Bkjpp4Csg3H5Br3pATJ0qkgIBFMLdoKo3DP
 bB9aU4xj1ORwrpLvbgtbjKzTYY1rdbX0HlmmhcAxCDR3KGVCwcVTdUHwha0lJ+hLTmI8
 mNnAc4bYA1eoWDlKBqV5BRuNd6EUT/phQnthFzJg8nR61jhC3pEI474txCGUdHgXARUe
 S0XaPbTcwF4EGYHBXn8slp7Hh48zB4xFttMf9UIKiKUHDLo49ZZ1WQJbUVzt5LwwjfYH
 PV/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775025989; x=1775630789;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ti3U1MzmNGrdfnWD9mSYxfCiKpi0PZKQSBGaTnDH96w=;
 b=Xrr9MKup1pLzm8366KK29vO/H/d/ea0MeKlepZZmBiAxokzvGhLVzh1A6tu69zFxiL
 r2W6pvyQCEUuku7OP42kZldio55xSlfmyOMZmY9fsznC4VX2r0cwETi6UYyPltJeebMn
 A+oy97BypaqhmY7e2Kue3cs6VzMny63VEHamyPJMwYSJXGGg88KRm/ghtQQT4eONltg2
 mpwvDxHqmljcPFyd+ipe2/cNoivI7hOPzdTazuYbBpSLkKSo614DSUBjm63bxuWHVtZ5
 3FjQdVgYcQXQr4HWNqOhg/XONqirvTEZwf5YSq9HcUYuUMBiG9IUFddA/V2NiDTWPAMX
 eD1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1uj5YRQJ6/Qh2DYblhwv0XaMgxuaocyTP6KQorw0vRJL1Epz+EFbPGYxJAldTqPcEBnaxtlM=@lists.denx.de
X-Gm-Message-State: AOJu0YzpzH6XITvRxY3G2r2OmJvR4wymGezRncNlNPpFAWVFmriE/FSa
 wqLwkQ1IgsJFFxnIWD2GJWzt+H5yApzepiuhL/mmsOUF81X7Te8Bi6AByy5cu/WM0ffcx2wGlxH
 ieRR0eORoU4LaqrqovWVUFUmaezpTjzHY15JPvF7FcQ==
X-Gm-Gg: ATEYQzx8AKOk6fkIMCNb8jT2eGllsMcDu2ci0qrN5rva58xOn6cR32DkWYRXDtBnoZ6
 dIzYOHqT3rLY42FsBedK4u0iAFoPazORKgDhfcWzV7orI1CEAom61wDhLFIbT451naqHzvpaz5e
 Ne48XnrPftmhnW6V+K7q7+3ko24RkRsTZIrb2P08D5yXP6D/hYdZQf8evPbJD1eS8eEFplfsYil
 xJJv4Y5BoAjImXFdN32Qq+jq75kLzM1JtudkeBJrYu+qUu4uw1ER/GXcP0fTPZosrAoRQQjR+j+
 iEopiiXeHRSr41BC/P/f/aPjUA1uw8cU41iN563dNAybcZWk2NH262Hew4fdS0EBUi+XNHRVubr
 k4OZIeh9XrgX637k9hUZEZPDdF4jeJiqVRVqyXBFGtwr0G4iDYpSDn83lbnh9PdURSUfXO89l6l
 gXowhk1Cbdxq7lBa0XX+Tc+ABZkiJdD90UtFd68LUhuKn5RRtDzWldpzAHnmq8DrIq4v7mpR4EO
 PLnh0jqxN/xeAvNWkN4KUM0ej3pRnT8QzLH85yy6WGO7hYHNQ0KICCx98J8gGig1b8wfOORCFQQ
 O2WS5Fk1zTZh0vuSVeiF4w9bRMdLq5oTVFd8V5hyVih/
X-Received: by 2002:a05:690e:d0f:b0:64a:ee12:e7c3 with SMTP id
 956f58d0204a3-6502fe689abmr2423251d50.49.1775025989432; Tue, 31 Mar 2026
 23:46:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260331080117.2370092-1-ilias.apalodimas@linaro.org>
 <20260331080117.2370092-5-ilias.apalodimas@linaro.org>
 <29fd4e34-2242-40a0-b8b3-29d1b88c7f95@mailbox.org>
In-Reply-To: <29fd4e34-2242-40a0-b8b3-29d1b88c7f95@mailbox.org>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Wed, 1 Apr 2026 09:45:53 +0300
X-Gm-Features: AQROBzChAaXJKedV6w2p-JjBw7YBJYhFb7_vannYSlNgzhH7Y3DVq2etLhkbyrM
Message-ID: <CAC_iWjL0ArZkRUtvBVGQjFhk-ng9ZGBjQAf1wR6PrLAmRHE-bw@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] common: Allow relocations on the top of the last
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

On Wed, 1 Apr 2026 at 01:01, Marek Vasut <marek.vasut@mailbox.org> wrote:
>
> On 3/31/26 10:01 AM, Ilias Apalodimas wrote:
>
> [...]
>
> > @@ -321,6 +323,19 @@ __weak phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
> >                */
> >               return 0;
> >   #endif
> > +     if (IS_ENABLED(CONFIG_RELOCATE_LAST_BANK)) {
> > +             phys_addr_t old_top = gd->ram_top;
> > +
> > +             ret = fdtdec_setup_mem_ram_top();
> > +             if (ret)
> > +                     debug("failed to relocate to ram top");
> > +             ret = fdtdec_setup_ram_size();
> > +             if (ret) {
> > +                     debug("failed to calculate RAM size");
> > +                     gd->ram_top = old_top;
> This changes ram_size , why is this restoring ram_top ?

Because the actions of calculating a ram_top and ram_size should be
bundled together imho. You are effectively calculating how much ram i
have available and where should i relocate.
So if one fails, the other should be restored.

> Should this also restore gd->ram_size ?

fdtdec_setup_ram_size() already does that in case it fails.

Cheers
/Ilias
