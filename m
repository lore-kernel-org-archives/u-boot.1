Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1299F8D77A
	for <u-boot@archiver.kernel.org>; Thu, 16 Apr 2026 21:02:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73F488407E;
	Thu, 16 Apr 2026 23:02:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cGmdA7ir";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9EC42841C8; Thu, 16 Apr 2026 23:02:32 +0200 (CEST)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com
 [IPv6:2607:f8b0:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2179A83EEF
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 23:02:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2addb31945aso51720115ad.1
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 14:02:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776373348; cv=none;
 d=google.com; s=arc-20240605;
 b=j/JI/BJu9qdIiwc7/hO03lLWjRurdLA+fBxaD7RpshWL9h73glPlhTS8UgiByE5wFB
 hmT+3QECdiRKfJe8QO01Jc2Y5JvXx93P47tz+FNcY/9NYMURkqzhjU6gS36wgx3OudQR
 0to6QILPHHcw+OjyKoZtghC0DtI/GB/Z3vhpfb9bjAgXdtKG7226Mnz6AKQEl5o+mqPH
 mOpg7pi9WZGCd8BbfIw0KW/nIa4k65Up5UuhkqMcZhyjn/CnAvkliB0+g5GVco6CV0Bw
 UC/qvy2sfKbUzrxY283LJKnTioG6B8Yy57zzlzOJZ64OghxZ//b/slek6zeXq+yHyCOv
 nqxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=6YzkFwBIJ9Ub6NJ4jjSt9mtxqJRk7+vyA/dDikkArVI=;
 fh=IHA3M8IfT6H5Vrn+JZXI0g18BlOci2kWnOa9/5wXAoo=;
 b=hVJRhJHUs59Cel0507M8HhWxTMjcSk23yBUMf9R61JCO2vTlsD7OahR1gJtgIMMPjx
 jtBhgBQg0ckuXgjlsBM4ibEPaBwlPhLuiliO5DHP/domk7t/BaMrEA+GeU5UNyXAZ2Gq
 BA5d7MK8FfMPQf32IRn5r6n6YcqZpUhAtopklFVjOFo7r/chxLituwK2aOtpreB9uL1J
 Q2ou0i/D3LVynEWayWxwo6vVSOXs0XW9F4Em6LHcw2gT34YGzpaeyGs+TxYrDeC4JRDq
 P8P5hmbpKlt+hMEIYoCOM/ddRrE/uxbUybm5a3RsTMmNLNEUadmneg99sIOyFdNXudSK
 rpeQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776373348; x=1776978148; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6YzkFwBIJ9Ub6NJ4jjSt9mtxqJRk7+vyA/dDikkArVI=;
 b=cGmdA7irlrLXTTRC2PTX0PD1aO1gjjyGUvhrhdGyijQ9zTbLYR0gH/pvwgDbWTaQVx
 g7gj2tWezi/PIbZR/hpBk5E/tAUze81jFXYyEWXKdTlWWkAzOKPG8vtOt3gEiHVfWWJL
 RIT5WIkUyM2Nen6TwyMQ+SFzwvAECt5oMDeKo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776373348; x=1776978148;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6YzkFwBIJ9Ub6NJ4jjSt9mtxqJRk7+vyA/dDikkArVI=;
 b=GFcrWSeyRo6zK9A7dZj+r0HRUYzGP4B/OhQVcQcXFwYARfGlMI/0U8TQ+JplCsc+l3
 1+3lgm/pjSVq1SCORovTYDEPicrzEQ+xZEkRxlcyrDK+Qb6+1tNziW1L0xxLKn9UpSIZ
 7ZkbRIj12DNfRvJjnzAeBNRUWJTWPjknTB1VwUyyT2VjDmeOL7k1fAm4p1lDwMux5TlN
 NiEG5eNkmK9fjKcHezHKI9tSXtU12eh4oxyoFxGobKTGTxDrKf9fGCXdPG/hKUPNaguV
 yuUWl+YbKN1BGHaQv4jziGTrseP3+8Q4UaYcCIhdC6qpOgEplcUTcuR2EjD+FBlBotHw
 Gpng==
X-Forwarded-Encrypted: i=1;
 AFNElJ+Q+MUxk2rAJsM7doFc7aAeAmfvYHO1HTcW9Q3e2rjtNV7KnGGV/BqaOosAQrGuhqUCeNxMlEU=@lists.denx.de
X-Gm-Message-State: AOJu0YziHmMn/sSZPs0GoWn1qvdOcLg/udy6uSW6kH6G3j0SRLRNkBQ+
 fUG2rgIqksDVaU/FTBir3JSpNUxn7qeFNjmSP1SayDDSEEeIa2pW3PyxmjVVmjI5rkOBEoUpZ40
 A7xakADNKUy2pwuOXCA7ZuVENcklnmFryBCTnu3nR
X-Gm-Gg: AeBDieuFWrLRmjzHM9hl052jn4jbZQqI41g0l03c/JkL/OZEpQIPRaf/yLH8uJuFUr9
 hMy2rPIHZedMugKp5rhsHl6GC0LEcC2U1QfyVL5MMWi27yN+uL6Jm7bV71PsUZaeI61FVjoM2ZH
 GRk1GLso9yrkhCm9LOx+blCXb5S9+5OGVQpRy1Qe5kB1kThOC5gF1AGfgSbs3fJZ7mDMPjCQQFm
 OhuMPqzRv54ARHqeiHoFoyq++jPjT1E44ZeDvhRK5OjMSpx+J3ur9T59Pa5nauIMoA3jK67XVOI
 AU3ZiBs0l0lKHPKQZlja
X-Received: by 2002:a17:902:ebc5:b0:2b0:62dd:3a80 with SMTP id
 d9443c01a7336-2b5f9ee30aamr165515ad.17.1776373348505; Thu, 16 Apr 2026
 14:02:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260413203555.1990337-1-rs@ti.com>
 <20260413203555.1990337-3-rs@ti.com>
In-Reply-To: <20260413203555.1990337-3-rs@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 17 Apr 2026 09:02:14 +1200
X-Gm-Features: AQROBzBrpQqodpo4pTTdVPo7Y2C4dG8q85fO6K81P1CN2xLmrR56TXLld_IA9is
Message-ID: <CAFLszTiUDtH14YTn8tPifA4cjOV=2h5MEkOGiGm6x6sQuJ-AZA@mail.gmail.com>
Subject: Re: [PATCHv3 2/6] lmb: add LMB_FDT for fdt reserved regions
To: rs@ti.com
Cc: robertcnelson@gmail.com, ayush@beagleboard.org, 
 Erik.Welsh@octavosystems.com, anshuld@ti.com, bb@ti.com, trini@konsulko.com, 
 afd@ti.com, xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, 
 u-boot@lists.denx.de
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

Hi Randolph,

On Tue, 14 Apr 2026 at 08:36, <rs@ti.com> wrote:
>
> From: Randolph Sapp <rs@ti.com>
>
> Add an LMB_FDT bit for fdt reserved regions, so we can reclaim them when
> parsing a new device tree and properly warn people when a reservation
> overlaps with an existing allocation.
>
> If we don't at least warn the user of these reservation failures,
> there's a chance that this region could be freed and reallocated for
> something important later.
>
> This useful warning mechanism was broken in:
> 5a6aa7d5913 ("boot: fdt: Handle already reserved memory in boot_fdt_reserve_region()")
>
> Signed-off-by: Randolph Sapp <rs@ti.com>
> ---
>  boot/image-fdt.c |  5 ++++-
>  include/lmb.h    | 14 ++++++++++++++
>  lib/lmb.c        | 33 +++++++++++++++++++++++++++++----
>  3 files changed, 47 insertions(+), 5 deletions(-)
>

With bootstd we maintain a list of images attached to each bootflow,
including the address when loaded. Could that provide a solution here?

Regards,
Simon
