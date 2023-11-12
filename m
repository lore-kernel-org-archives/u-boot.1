Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 176BBC4332F
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 03:10:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B502C8747E;
	Sun, 12 Nov 2023 04:09:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="N2QgrmmQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D81687546; Sun, 12 Nov 2023 04:09:02 +0100 (CET)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A719E871A2
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 04:08:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-9e2838bcb5eso507336666b.0
 for <u-boot@lists.denx.de>; Sat, 11 Nov 2023 19:08:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699758537; x=1700363337; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1HyKOWfxB1QzUFw4GQoL7wQXtb3ELgQtCzxNJGa1Zkg=;
 b=N2QgrmmQRXfCjda26kuSmhIyQ/tyO5TWDGvwI3e8vpBAjeUvOYObMEQLMvO2Kg7Hi9
 Od1/cCyyRFVAh6qX7y8VhlTqf58NNyS8g/6zoEc6oiUoddcg/05gWUCZ+ibk64BTWtAL
 5odhiHenKPJ4nlsjfYlZQnp2Ta13oy56KCzcA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699758537; x=1700363337;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1HyKOWfxB1QzUFw4GQoL7wQXtb3ELgQtCzxNJGa1Zkg=;
 b=SAwogeODNyzCnvkPRrMaK24uPDDgrVTC4b70fx1qFmG+CIuuIBQV9augqkCAanGMDb
 VG/j5Q9/9IBZ6x46BckwqmDwjmvORUnn+Bgle1KAZTU05+bgsOjew8tizF5SRv00xqbT
 rmK/MP49Tqynw83dl6MmNzW1Yyf+EU+L0J0o77u0c9S/NURaed3vfERa8O+EunIa4M1S
 q7XdlZ0qixAyLZdobz5tASSjP+zBsEVj02X0s2pPrhBEb0rXRQbyKtSiUwNnOVVzpzbI
 bk+SWtfmiQWvKSyVstCaLGBbD5mp/56MnolW6pUVGzF0kqYXtFdE/Tuq4SR/8BBLvv1H
 OIHQ==
X-Gm-Message-State: AOJu0YyzOmsL9hCtK8DUOMQiO0tRa6vqKBtHm0oElBnFjwe+xYOdCbgH
 5/3uu2vgLHrHYRFGiildAPV6HLfdR3sC/rHCAdwU/w==
X-Google-Smtp-Source: AGHT+IHNbiLPv6s9gqvD4siD+Cfy8onCdXXka979PXaivOEonZpZ6YRCWLXK5kYVUd/viMbg0fJd/2m7+6tPh7cYnUc=
X-Received: by 2002:a17:906:84c:b0:9ae:6da8:1819 with SMTP id
 f12-20020a170906084c00b009ae6da81819mr1848353ejd.48.1699758537185; Sat, 11
 Nov 2023 19:08:57 -0800 (PST)
MIME-Version: 1.0
References: <20231111134112.165377-1-heinrich.schuchardt@canonical.com>
 <20231111134112.165377-4-heinrich.schuchardt@canonical.com>
In-Reply-To: <20231111134112.165377-4-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 11 Nov 2023 20:08:39 -0700
Message-ID: <CAPnjgZ2uFY8gHZwHqdxq83vi-sQh3kV-ePsB6VbXDiv=O87cHA@mail.gmail.com>
Subject: Re: [PATCH 3/3] test: dm: adjust ACPI test
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Bin Meng <bmeng.cn@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, u-boot@lists.denx.de
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

Hi Heinrich,

On Sat, 11 Nov 2023 at 06:42, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Adjust the ACPI test to match the changed output format of the 'acpi list'
> command.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  test/dm/acpi.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>

Ideally this should be in the commit which made the change, do avoid
test failures on particular commits.

Regards,
Simon
