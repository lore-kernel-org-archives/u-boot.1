Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29D00C4332F
	for <u-boot@archiver.kernel.org>; Wed,  8 Nov 2023 04:29:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7995687729;
	Wed,  8 Nov 2023 05:27:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HJR7bc5y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 03F2B87718; Wed,  8 Nov 2023 05:27:04 +0100 (CET)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 00D068774B
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 05:27:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-5be8f04585cso1061127b3.1
 for <u-boot@lists.denx.de>; Tue, 07 Nov 2023 20:27:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699417621; x=1700022421; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1/xiJ1uqVFyX1lPcmDtS9yfIULl2Qt0/dkRgm5FkcQM=;
 b=HJR7bc5ywHRzrwx2Re0wuEFCN123rKcU675F3U960FoQWtku0dL2jd9zdTdIJ8OivX
 upImJoIRDQYNmUwvU6Hb02n7FPQNdt8REqAzNoTx2UX5oYPHFxzZuk3lwJ8kKC6gzfEm
 7/OgJOlB/1yDmxVIRmz9nUkS7/vF2GK4J13TY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699417621; x=1700022421;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1/xiJ1uqVFyX1lPcmDtS9yfIULl2Qt0/dkRgm5FkcQM=;
 b=WG89PBvZHlwhjntbO6/1mAwvktY0z48O+fUZop3RAIyM4WfdNdMwdYT5MLRrUB+bWG
 tdClDkZWemRccwdBSSbbPdHbve7Wwoha21+9qJpgc5cXR1FnmsCBpkFgFzhhVq7V9Vxk
 jCGEiy9706fpUV3oCyUVLJ6S1K8G2QqQtW5uKlvVQwSEhR4QQzZKDD2kLHr84fT1oji9
 3Lz+PIND4VV7DIyZHlPFrklLthfxgzFHsCgbW7dCDBX/VZ5msD/8S7BV/hAE2EjOXuxh
 TWi+Mv5cI4TclryFZIRcRjUQGxxGqGoi9qTDUNlWPycBKKlgTP8fhWhLNUJdBtnNTGen
 bOIA==
X-Gm-Message-State: AOJu0YySu6fES+6NmjiPEhzFbjYrU+RbgfnqzuAkktV/PWCCWcbgwJc8
 jYJdDljAORLKTzy/HHhbifZHHXVBYO4j1JWdHLabsw==
X-Google-Smtp-Source: AGHT+IGy6XBOr0yOH2nYSyvp9GPBfb7JAKBwH+BNZfQg9Du5WNqwsGJwV33+D38bcAgrjPMdW6opN5E3G5dciBrDH7U=
X-Received: by 2002:a81:9185:0:b0:5a7:af51:fa39 with SMTP id
 i127-20020a819185000000b005a7af51fa39mr3873429ywg.8.1699417620594; Tue, 07
 Nov 2023 20:27:00 -0800 (PST)
MIME-Version: 1.0
References: <20231106022603.3405551-1-seanga2@gmail.com>
 <20231106022603.3405551-25-seanga2@gmail.com>
In-Reply-To: <20231106022603.3405551-25-seanga2@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 7 Nov 2023 21:24:12 -0700
Message-ID: <CAPnjgZ3e5ODLCKLhWWZ6rdn=m=PB6kem28vqMCQXagUQ17nMqg@mail.gmail.com>
Subject: Re: [PATCH v6 24/25] spl: spi: Consolidate spi_load_image_os into
 spl_spi_load_image
To: Sean Anderson <seanga2@gmail.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 =?UTF-8?B?TWFyZWsgQmVow7pu?= <marek.behun@nic.cz>, 
 Marek Vasut <marex@denx.de>, Xavier Drudis Ferran <xdrudis@tinet.cat>,
 Stefan Roese <sr@denx.de>, =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>, 
 Jagan Teki <jagan@amarulasolutions.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Vignesh R <vigneshr@ti.com>
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

On Sun, 5 Nov 2023 at 19:26, Sean Anderson <seanga2@gmail.com> wrote:
>
> spi_load_image_os performs almost the same steps as the non-falcon-boot
> path of spl_spi_load_image. The load address is different, and it also
> loads a device tree, but that's it. Refactor the boot process so that
> they can both use the same load function.
>
> Signed-off-by: Sean Anderson <seanga2@gmail.com>
> ---
>
> (no changes since v5)
>
> Changes in v5:
> - Rework to load header in spl_load
>
> Changes in v2:
> - New
>
>  common/spl/spl_spi.c | 54 ++++++++++++--------------------------------
>  1 file changed, 14 insertions(+), 40 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
