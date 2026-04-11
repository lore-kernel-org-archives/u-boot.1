Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A03DF3ED40
	for <u-boot@archiver.kernel.org>; Sat, 11 Apr 2026 13:34:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B35C8841C2;
	Sat, 11 Apr 2026 15:34:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kg1O5x+d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3EEEF841D5; Sat, 11 Apr 2026 15:34:26 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 58AD4841C2
 for <u-boot@lists.denx.de>; Sat, 11 Apr 2026 15:34:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-b97f9587e6eso391832866b.3
 for <u-boot@lists.denx.de>; Sat, 11 Apr 2026 06:34:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775914464; cv=none;
 d=google.com; s=arc-20240605;
 b=YE6nMi23v6Rrc/8JNMboIabSyD+nDULNXk+82nW/PKePlFlwzCrzgKh3Tq7jCgxZec
 dbFKWAG8lkc5ClM6dbQ9uJI2jS1JtCYHGUlks3Wg9DO/mepN9QAD5K+ycru2sSogw4FW
 0bfpuEMmOT3slM630hk/E5jCVmqEI6jUyAqWhDMA9Dz6vZ5blbqaj0ZRbbXK1oSuQH9b
 ra9yRLPssw9zsEO44+27p5gucd/cAOSlCoRVlcX1+AOVOr2VcjnnJcwWimn3MnCeIIxH
 GbMFeOfgt+1STMeSbMnk+Jq0OGMjWwyXXiAm29BvZZlNM1H8ygPY0O/pgf92dUW1lZQ8
 2xrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=+JbrtQByn8NbVWu9qitDKMyGJqCyCLEmfNCXrLyGNsA=;
 fh=1L6vZ7sPlbPu6y+g3mNCPeF2C6+dBJkeSiSHnCxwzC0=;
 b=VUfc2I+pDNs8UQl4YEflXCX5EYVHt4/BixQg3iO0rA1FhoaVvnbv8qESGJy9ZBcEbl
 54OQgHvHX1e3Vzsn0kJHT60rKkx9OpqvIwpqwbHEKN+rv+aRhW32J7IvsIeIfJTaibP2
 mpdyDaNxfFEXT04CBI2uytMP1SaD17p8wDLApeAynfCASn90cnTQI9j2QLRhW2WoDqMF
 UJnVpajICRKR8usklC+ZmMeolAUy+KbZyjXlvLrzclZXhBcr24iSmE3Z2sVLkgCifVqH
 Dq0fhOl+YxdRehZN3ylf99dSCrX+/OOPvbAf6LeVKnA8BH9kcaadEdOlvZzShaHLy5vC
 XOrQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775914464; x=1776519264; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+JbrtQByn8NbVWu9qitDKMyGJqCyCLEmfNCXrLyGNsA=;
 b=kg1O5x+dTOIUaRKCQkmJzXycYig/QtB+pD1GVdn3pDh6U/AEA6OASvEIgWdEVmBbe3
 Uc1VOzXxB2uot2UlcYWzqc5Uz7GpLUJURJXGYb+Z26stBhegcr3i+vDqQKCEMU4oGqTj
 THjt/O6fP6+kfPyiwW9tJjub0ydkBFkiriwis=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775914464; x=1776519264;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+JbrtQByn8NbVWu9qitDKMyGJqCyCLEmfNCXrLyGNsA=;
 b=klga6FOfHco7ms8aRUnzCyb9wItjBpOwDwNRULXj89u5EJy/SP9Rzx8ooAKnH/55dD
 Dl3DMrZKpSYokL+wPYkO1H2NhdhRzdsJi8et3VyZFdBxh+JvAJWw3Cd1+Qhs5Nfa+7Yn
 FJvRgFxm495I/1+IRJmh+44YS8Cnud/GDJrm+gza2jfflfxJQmxuiaId2mUEcNcES9WE
 DwAaTm3x64gb4o+c4mDElCesyIVyOwyC1W0LofCQ5EHIVQ4bOkT5fh7g7JAqcwVhHPHd
 7+Mh4n1F1/qqtRNnlF5kj/eq52ybBJ75GJalqKtNQWq7VuetgkOiMW3IsEbdWjHE+9fN
 vM+Q==
X-Gm-Message-State: AOJu0Yw81ATrraFfiqCAcFeJI2+0ekC+tRUtmJsbuaMaXW/SKRfVwM30
 cio3x08TtP6qgGabttvEzhcmZ3f1rzV22WlqeFkRW8RRa9Q0/Kbb+Bvx9EhthkRVuFEhTKjXE9+
 SHvQJqoubsgnqJ5FxbcEGS36QmVk84mL/L2Ok6TPw
X-Gm-Gg: AeBDievNHiZRw8oldobKnMX1WXZp6VMcoazeWA7wc2lGOxDy7/0AdO0SFqPrINf6IVH
 S7D+S6NHlGlsuIvZitPYys6m5JJvnCW2jbCnWYgH+9nsshqt4bZff4SB9ZAOo+VpHC6DuVR3pbn
 fTz9fMv9qqmiGuqzqHIC/9RYKilfblRdfqlp3WyJng98ZpSNK6DNyJ9YvIpHSk7uy9rY91Sui6e
 mDoxwwDKuIbHM58WIqaK/yrETjQb8VQ6kDE5cZblAWED95DmL2oXjlHh2hLDeYicRKM2DKAdrwP
 L1z8fQ==
X-Received: by 2002:a17:907:c30f:b0:b8f:ae35:cbdf with SMTP id
 a640c23a62f3a-b9d72833480mr380338866b.48.1775914463684; Sat, 11 Apr 2026
 06:34:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260408-ui-cosmetics-v2-0-721dc6d2116a@postmarketos.org>
 <20260408-ui-cosmetics-v2-2-721dc6d2116a@postmarketos.org>
In-Reply-To: <20260408-ui-cosmetics-v2-2-721dc6d2116a@postmarketos.org>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 11 Apr 2026 07:34:11 -0600
X-Gm-Features: AQROBzCRaTDidROq4GHCQ55hsQw5qIb2d7teBax12Q8xUYTrBpfVm-tytETIHSw
Message-ID: <CAFLszTjZeaH4=3HHWdNf6H+eNPDVv0+bqxFA0heiaZ2q0-6FJA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] cmd: bootmenu: ANSI_CLEAR_LINE before entry name
To: funderscore@postmarketos.org
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Simon Glass <sjg@chromium.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, Anshul Dalal <anshuld@ti.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Martin Schwan <m.schwan@phytec.de>, 
 David Zang <davidzangcs@gmail.com>, Sam Protsenko <semen.protsenko@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>
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

On 2026-04-08T16:34:55, Ferass El Hafidi <funderscore@postmarketos.org> wrote:
> cmd: bootmenu: ANSI_CLEAR_LINE before entry name
>
> This has the effect of highlighting the whole entry when it is selected
> (on vidconsole), which makes it consistent with eficonfig too.
>
> Signed-off-by: Ferass El Hafidi <funderscore@postmarketos.org>
>
> cmd/bootmenu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
