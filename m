Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77F23D1CDC7
	for <u-boot@archiver.kernel.org>; Tue, 22 Oct 2024 09:23:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 14C0888D9C;
	Tue, 22 Oct 2024 11:23:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KLLb3pCN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A24588FBB; Tue, 22 Oct 2024 11:23:26 +0200 (CEST)
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com
 [IPv6:2a00:1450:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A67388D9C
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 11:23:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2fb5111747cso60236021fa.2
 for <u-boot@lists.denx.de>; Tue, 22 Oct 2024 02:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729589004; x=1730193804; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qsgy+zOEnaYsn1Vd6gb3KaQdMCBmepfBuWEXBZpniYM=;
 b=KLLb3pCNwryMaKRI7/1V2kwOnoGWZHYHAxQbTf265pO9aL+GN2dS5ugKxfFKdYFLy2
 ozRM1cyIjvkFaqjaxeYChV9wfbiCAFDIBKKGwVvXHa7E8LJiVagsDxZBmf7oz4dgQvTz
 7qxfLffhf2xo6HSnR0++lpUgdypk8/MBMQeAWFf+Agvtga8ZymQOVQfQcbg/U2nxZsxC
 EtWKQ1QlWjFrEY6kkjj0qrBc7C1dsn9nINmIFR1fPFQUfTJEmeeITlHlzhsAAa1TI28w
 h2kC+VY95S1Y9NRm+KbBtDVcvOP+ZQcBxzh4RWA2l0Cxf7BJA+mNrXDdJTn375GNMFWz
 CO2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729589004; x=1730193804;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qsgy+zOEnaYsn1Vd6gb3KaQdMCBmepfBuWEXBZpniYM=;
 b=Cy6TpM4x87LTH3IjHMBxJVDf1SIvRZdxPLxnDG+0m77wOUh3gX6h0TUguKZBC4VDZO
 Uac/6Zv07foKB/Ng6/Zp4IMRm2WgQGXZkG0sVGPis3gXQguS3rwKjHs2FF648jnkuPTR
 oD3sltYMG5RvHRbZYiLcTZUBovOFdUQOm4RXijUEdtsvrhgqt4UahdJ5J66pj3ed1aep
 5svkItvWtGrolZbd8eMS6+r7K/Kf9VVYUY3Dck0xNHaMIMQwk6THUGX5TONUZgeVeryk
 P9Nbs0JYYhqJy5NGnKZc80hFqwPISenyZ0T8co3oD/BsnZx0DP4NhQeVnsFsxfL5/aCp
 OHfw==
X-Gm-Message-State: AOJu0Ywe3B7XLXETtcBHyLL8eghrkLxei0FRFflhnX/eldUj2ZcmzmYt
 VCenO/Bn4xJilOJbM8VAufpLSqZAakEqN4OkXC9E2ZIl5+yImIfEdyE/Hl/uAaQQQosS9XQbhfT
 5SVYP3ou4Pp0Baic+JnbAv3txh+s=
X-Google-Smtp-Source: AGHT+IGAwrxD5LgEUckU5kUWOOSg83/4wW8UjazftAciuy/39+0FSlsdQzO20n1cp22NmUTk6WyiW3ajroSOD0RGdyA=
X-Received: by 2002:a05:651c:199f:b0:2fb:5a7e:5046 with SMTP id
 38308e7fff4ca-2fc932e1d70mr8332611fa.9.1729589003454; Tue, 22 Oct 2024
 02:23:23 -0700 (PDT)
MIME-Version: 1.0
References: <20241021155133.29557-1-sjg@chromium.org>
In-Reply-To: <20241021155133.29557-1-sjg@chromium.org>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Tue, 22 Oct 2024 10:23:12 +0100
Message-ID: <CALeDE9NCZn4rq-FVUDOCSkXWHLX3xoDr52cwPr91iZ-RL=xhqA@mail.gmail.com>
Subject: Re: [PATCH 0/3] Adjust how autoprobe is implemented
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Marek Vasut <marex@denx.de>,
 Svyatoslav <clamor95@gmail.com>, 
 Artur Rojek <artur@conclusive.pl>, Caleb Connolly <caleb.connolly@linaro.org>, 
 Christian Marangi <ansuelsmth@gmail.com>, Devarsh Thakkar <devarsht@ti.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>, Jonas Karlman <jonas@kwiboo.se>,
 Pavel Herrmann <morpheus.ibis@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Raymond Mao <raymond.mao@linaro.org>, 
 Richard Weinberger <richard@nod.at>, Sughosh Ganu <sughosh.ganu@linaro.org>, 
 This contributor prefers not to receive mails <noreply@example.com>,
 Tom Rini <trini@konsulko.com>
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

On Mon, 21 Oct 2024 at 17:02, Simon Glass <sjg@chromium.org> wrote:
>
> This little series makes a minor change to how autoprobe is
> implemeneted, as discussed on the list

Please add a link to the discussion when you mention a discussion.

> SPL is left out for now, but we can discuss how best to deal with that.
>
>
> Simon Glass (3):
>   common: Drop check for DM in initf_dm()
>   dm: core: Simplify dm_probe_devices()
>   common: Move autoprobe out to board init
>
>  common/board_f.c    |  9 +++++++--
>  common/board_r.c    |  4 ++++
>  drivers/core/root.c | 27 ++++++++++++++++-----------
>  include/dm/root.h   | 10 ++++++++++
>  4 files changed, 37 insertions(+), 13 deletions(-)
>
> --
> 2.43.0
>
