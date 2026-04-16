Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C6F1F8D762
	for <u-boot@archiver.kernel.org>; Thu, 16 Apr 2026 18:37:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8654884227;
	Thu, 16 Apr 2026 20:37:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XDVWIJOd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6B6184228; Thu, 16 Apr 2026 20:37:02 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 178FA841C8
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 20:37:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-b9382e59c0eso1459224166b.0
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 11:37:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776364619; cv=none;
 d=google.com; s=arc-20240605;
 b=ZYpbEyxBv3K9l48XQv1YEcksHYb5+kENQt1gxnSrUXEyXX3SJEL+sqlBsgZDG9pBj/
 kVBg+Ni/T6egmrfy3nyCHuQ3KsZAHSQc2kJHn8tlM/xY4cGlluUkGJObYIFohXw5tNTU
 HXq60hBm1ifYK9Bv1RHbyNjP/T3OkeaiF8KApmk+OqCJW6KNWUl/vZomuDhGPGNHcCUy
 k7HsExu6Pl2WGFesudUtXHtGgYj62LUubxldFOEbdGfzW/3jCLk03vWk2MDC5LD8Mw3w
 a/bwxMdIzE3SE1/Tz+FVoUd9Y+aS4DbkMn2k0eMzrRItoy/hdhOgxboG2a9La/Qxbk56
 8Skw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=AC892Vyq1U09R81UVl3VogxN4SmPkVCKgYrRje8cpp0=;
 fh=1L6vZ7sPlbPu6y+g3mNCPeF2C6+dBJkeSiSHnCxwzC0=;
 b=OOwXmbvdYiRKZQJJQ+sO1j4EmkN9R7SdFOZ/f4WrLjDpexNXPhu2M3tWrFw+ELAGwg
 xGNfmZHfi5soABjm0Xoej7x1dCk+haIrT15Ugwj2W02y3gCqDP9p3fg5Hl+rGjKZxTHP
 aRAaX/2h+zJMa2JXbhkp3lyV1LocrC1vKchOQHfJ3cv8TrK3k1psanwS0rcjnKoCa4uc
 2kz7kmsCTlrltOzsebthmNqw1sSOP3MMU8ZI57qJULHBVQL4QwP/pzn/GVoeqTM75nFX
 koLj1VxSCTyKuY44rysbQLjbZFMqis/JPaN1kmHEI/Fb9QtJDVZ5tm+E+E8xPsxbw3hK
 csTg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776364619; x=1776969419; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AC892Vyq1U09R81UVl3VogxN4SmPkVCKgYrRje8cpp0=;
 b=XDVWIJOdBmKfs/nhsExEDLQipUyD9qjsI8ni9owfkTRmkhYBUL81IhtXDjYF1jG68o
 pqtAXBktAcI35D1PUlIi38YFw3rqu6jQXuP7X8OwuBY0I24EAfYZYQ2zqA5hYXkM3In0
 4hXCV6XAk9Dr8VnItmlMclbgE1wLKHUXJfBkQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776364619; x=1776969419;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AC892Vyq1U09R81UVl3VogxN4SmPkVCKgYrRje8cpp0=;
 b=Uqn5N1tn5+XYCIUkm4/LMpOOXUmt/Gerr+9Vl3YcovdCMFmWROVM6Uf20q9UdX6R6f
 WDUJhe9r3RrrKt5UjTW10MFhpF+wgfPrGQB7SWPNmr85XK6Bgg2rVB5ohlpkADPdFA2H
 1HN0JaaOE9xR0/K5WFQQuSPzYPT7tsYw2P8xfrHWb7DxMcsxYPnceOK92Gg6Cc322THD
 GSStyP0zN5gvRa/EtcZT0Tey3D3NwRIpFa77jttRcZmq//C9/9JC1GVvIMatpXUYmbyl
 644HvLLqWg5gUhey4cwjmwXw1rAtJjXiaea71e1HZ1i4zp778CKAFtyWC7HVZakzR+2y
 Og2g==
X-Gm-Message-State: AOJu0YzmKu7QiMQunarJsauf6/TvqBGI4TmbcO2aWEFLYzcrpBOuq2f5
 MfyM9z3kwZifmmFE+NkTXdDoHgG/Q5nntuj/0DnwxflmCe8N6Cp4X3URq15rgPohzCDTS9nfj9X
 d/DR0nH0zbfVlCcfdv9i1WfW5OdJlZ4CnluhKRVFC
X-Gm-Gg: AeBDiev/W9lj0POYcfWBcX8yszIX1iwEA2Zh7kn5G31b3QyDhRFefjAirHTgSqg/ijH
 VUJcJceOP93X98y7LvDjvLDSE1JT3KAlM2WThNEReWChcZTQDaCIw8kTCzRd1rOhiyp8fQiegyX
 VXj8mnY0KJSWABmi1TqbpEh7YKSsq6Ja/HvA22wN/KO+OVJig2XErQyAUrDpeQe8PVo3yMXaC+1
 bz8M4LQcxti0pbFEGmv4Od1vFSGXsXb3NQy9Az9wrUaZ3rzfi/kzc7v9VoF3Q9Y7usJ9CQCSM2o
 4C3WA64cX4yAD9C6EO0A
X-Received: by 2002:a17:907:e92:b0:b98:3b5d:e148 with SMTP id
 a640c23a62f3a-ba3dcc7cb1emr29153966b.11.1776364619473; Thu, 16 Apr 2026
 11:36:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260416-ui-cosmetics-v4-0-b843ba661b3f@postmarketos.org>
 <20260416-ui-cosmetics-v4-3-b843ba661b3f@postmarketos.org>
In-Reply-To: <20260416-ui-cosmetics-v4-3-b843ba661b3f@postmarketos.org>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 17 Apr 2026 06:36:47 +1200
X-Gm-Features: AQROBzBmB8DPIUK493waiXXMBk-EXUw4Djv_lmDqxp01fex_3O6YtNQwtEL3NfI
Message-ID: <CAFLszTiWiGGhU=un2zcEzAMMNtD4DOkKjSJELYeXELxGT6bP7A@mail.gmail.com>
Subject: Re: [PATCH v4 3/4] doc: usage: convert autoboot README to rST
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

Hi Ferass,

On 2026-04-16T14:57:40, Ferass El Hafidi <funderscore@postmarketos.org> wrote:
> doc: usage: convert autoboot README to rST
>
> Convert the plain text autoboot documentation into rST, so it is visible
> in the public docs. Also decouple CONFIG_AUTOBOOT_PROMPT from
> CONFIG_AUTOBOOT_KEYED in the documentation to reflect previous commits.
>
> Signed-off-by: Ferass El Hafidi <funderscore@postmarketos.org>
>
> doc/README.autoboot    | 162 -------------------------------------------------
>  doc/usage/autoboot.rst | 149 +++++++++++++++++++++++++++++++++++++++++++++
>  doc/usage/index.rst    |   1 +
>  3 files changed, 150 insertions(+), 162 deletions(-)

> diff --git a/doc/usage/autoboot.rst b/doc/usage/autoboot.rst
> @@ -0,0 +1,149 @@
> +    so it may contain '%' format specifications, provided that it
> +    also includes, sepearated by commas exactly like in a printf

Please can you fix the typo sepearated -> separated

> diff --git a/doc/README.autoboot b/doc/README.autoboot
> deleted file mode 100644

After deleting doc/README.autoboot, boot/Kconfig still references it,
as does doc/usage/environment.rst - please can you update these to
point to doc/usage/autoboot.rst

Regards,
Simon
