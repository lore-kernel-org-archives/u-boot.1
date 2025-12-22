Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50483E674B5
	for <u-boot@archiver.kernel.org>; Mon, 22 Dec 2025 13:55:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DCF5B83EDF;
	Mon, 22 Dec 2025 14:55:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FAKWSG8K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8715683C94; Mon, 22 Dec 2025 10:22:04 +0100 (CET)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 231A583B99
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 10:22:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=visitorckw@gmail.com
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2a0bb2f093aso38612425ad.3
 for <u-boot@lists.denx.de>; Mon, 22 Dec 2025 01:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766395319; x=1767000119; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=jsBuU0mgFol719I2sVhbLZ37dg4dSR+6XzgF410nLm0=;
 b=FAKWSG8K7kPbJZB44u1v3N9vtRSa4KuHdHwJ+RRlMqE4/MjIbuPl9Y7Fvxw6b8h5B1
 hHv5CeoQCy+grQEVAl4G44ScaPrRtEORiKpl/Q5UZoO127C5GBXqY6IfUpuR2PWtr0Hi
 7BiwTOAT9XRtndWkgjGkLsZ7BmOOagp7p9IWeuCU5UlbQzKXPWqh1kNZVUoiZwKUryrm
 lBLaM6Z4tqJf8yhu0HS28vFnWkFOKv95yQvL8f1YUIsmSRSsEFaIbU2aJobdfv5K/1jX
 peOenskz2R/NRIMZUbBd/6wtsf9F9Py/AyBUJXs+jjPWsFrHAYP10tn/N0WaF5oMwUvT
 xnRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766395319; x=1767000119;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jsBuU0mgFol719I2sVhbLZ37dg4dSR+6XzgF410nLm0=;
 b=FJsn5eYfiJsywukXqoGSIWWkj2VNYRdofkCXBLHzJ3UBdrCIuYA+K9RLthIGiyRFxJ
 1qsIWNqFdmQciKz038VfC63BzFELVqCZiSN6CuIrxxUsnj5k2ZmkmXndMVxhkp3RCOGi
 AHrgx/AEV+bii8LPjl4Bd5dljFaRomuXkSiBAaJPb2gL/jF/TP+yIdkqTxbD020BYg/Y
 x9t/MdJ0JS9j2LFLeo5Mz3xelXiwsuPoZm4BaUl8ORjA5tNTpwta3Qox0MGEkGNPH3Il
 xAi2mQGIamhcnGMAbg7idrcV16r6HqR5vb4sEKkwgaMUyoTlRriERTlxrOu4AZDy7fEF
 kScw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2nWsjpy7w5QBTiOb34hF6XIUgLHacfpWrWWnL2RGE3H8oFICfP6Q+/PBmOQ1zjAjBXO4+exg=@lists.denx.de
X-Gm-Message-State: AOJu0Yy1aFgcL7QZt6smeEpKD+Oc72rt3wTG7p/AwCaL8Ftzau7wVp6S
 92kXhEXTvTclPfl7qgis16HjBpOC8e/X4LdW2aAjkZsLQq3pm0LNnlCZ
X-Gm-Gg: AY/fxX5oknoN3ids2WN0uuM3sZUB4gyIEsIMZysPLoKbTg9HaaS8dlziqih7dG03xTL
 tFbYIfUMwWzO+zmlkDV1b/f79+70U3fvafC0kT9YWeNSO/UnBB8KyL6fznyof2g18/gVeXmUVrG
 6KHo6B6Cv3YPnU+lpPZslW9CwADC+4jQttV850GfmViboxWbAlpB17CZD6td3fJmChgg8/PBYvb
 FGuyqS+rd5Ty8c5+ATLDsMtipUJlJa0dnJ5Avmxu+4EANV0kpKx6Uv7UQF8aJ5lwaKoNyX+A3+L
 VBqEqC8Q5smgK+9CSvDsUi+hBHZTROlE3hNbGC8EfVY6WEHbJbbb/lSFjZBcjUNREZOOcU0FJLX
 nPzbKmYQBhQ5RzoXdckvaAVag9wEKn6mdzNs7ToZf6pGPMb0G3u7YwXr2SjX0GIOGJNxBLGNgkz
 MCO1A3BcsgkDg7seg9F7A=
X-Google-Smtp-Source: AGHT+IFUMP995VeLnZoBaxDT5GXw3L5Rp0RiIVz2eDNMOJ/clKj4c0IFxL08xmgVZVMq1+I/86vBzQ==
X-Received: by 2002:a17:903:2a8b:b0:29d:975a:2123 with SMTP id
 d9443c01a7336-2a2f2a4a33dmr83191555ad.60.1766395319405; 
 Mon, 22 Dec 2025 01:21:59 -0800 (PST)
Received: from google.com ([2401:fa00:95:201:c4df:6c40:67fe:ebe3])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a2f3c666d5sm90520905ad.21.2025.12.22.01.21.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Dec 2025 01:21:59 -0800 (PST)
Date: Mon, 22 Dec 2025 17:21:56 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Daniel Palmer <daniel@0x0f.com>
Cc: alison.wang@nxp.com, angelo@kernel-space.org, trini@konsulko.com,
 jserv@ccns.ncku.edu.tw, eleanor15x@gmail.com, u-boot@lists.denx.de
Subject: Re: [PATCH 2/3] m68k: Add support for M68040 CPU
Message-ID: <aUkNtKvooP4Ivblz@google.com>
References: <20251218185252.957388-1-visitorckw@gmail.com>
 <20251218185252.957388-3-visitorckw@gmail.com>
 <CAFr9PXmwBpQW60jZDFf+iqCaSbW4z25=OMN5XXBkBMH5AW-t_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFr9PXmwBpQW60jZDFf+iqCaSbW4z25=OMN5XXBkBMH5AW-t_A@mail.gmail.com>
X-Mailman-Approved-At: Mon, 22 Dec 2025 14:55:13 +0100
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

Hi Daniel,

On Sun, Dec 21, 2025 at 01:53:40PM +0900, Daniel Palmer wrote:
> Hi Kuan-Wei
> 
> On Fri, 19 Dec 2025 at 04:06, Kuan-Wei Chiu <visitorckw@gmail.com> wrote:
> >
> > Add support for the Motorola 68040 architecture. Currently, m68k
> > support in U-Boot is primarily focused on ColdFire (MCF5xxx) variants.
> > Introduce the necessary infrastructure to support the classic M680x0
> > series, specifically targeting the M68040 as emulated by QEMU.
> 
> For all of this: It really needs to be split into the bits for all
> classic 68K and then the supplemental bits for 040 (basically the
> cache stuff that you only have stubs for).
> That way if your parts get merged I can rework my support for 000, 030
> etc on top of that.

Yeah, proper split is definitely needed for the long term.

Here is my plan for v2 to address this. Could you let me know if this
structure matches what you have in mind?

1. Create a common directory for Classic m68k (non-ColdFire):
   Possible path: arch/m68k/cpu/classic/

   I plan to move the following generic parts there:
   - start.S: The entry point, basic stack setup, and exception vector
     definitions (likely shared across 000-060).
   - bootinfo.h: Since this is standard for m68k Linux.

2. Keep 040-specific code in arch/m68k/cpu/classic/m68040/:
   - cpu.c: Containing 040-specific cache handling (or stubs for
     now) and specific initialization.

3. Refactor arch/m68k/lib/Makefile:
   Instead of using ifndef CONFIG_M68040 to exclude ColdFire files, I
   should probably restructure it to clearly distinguish between
   "ColdFire common" and "Classic m68k common" libraries.

Does this separation align with your requirements for layering 000/030
support on top of it later?

Regards,
Kuan-Wei
