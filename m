Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCE2FC43458
	for <u-boot@archiver.kernel.org>; Mon, 13 Jul 2026 14:23:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E73884C0D;
	Mon, 13 Jul 2026 16:23:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="W8/qRSFk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0DC4784C0F; Mon, 13 Jul 2026 16:23:45 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 213FF84C06
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 16:23:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-69c5f6f7a40so3605957a12.0
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 07:23:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783952622; cv=none;
 d=google.com; s=arc-20260327;
 b=ZbY9F1ghnMRpnJPOEBWp58Z7HRbSHBpcZMkembjCjMsA+v9xkWbde6K/yMUUuA4ApJ
 xt0LoUoiK7hUgg0E77K/pHrbcpZFCCLQC4+Dc24GNFzLAeY7EneWM4sw2SwAJ+LZYU+c
 Rw6AhFRhcQ6zCwpoh0XkwoHx7F+MKDKvPSSAzn2D92a94nhUcQpphwcKnWJCMYgBbbA+
 YO673R8G02ZOxXDyIt/bPPA9WhE6owWU9XFfqC25whgsZ9Tao10YQ0S/VOqvdCbnW0az
 fylqdCNusTPGTSRhi0YPQ95W3qUNPqOj/zM8P02Th8DYwCY4kdJForafeZFaJ1qWywlr
 1jag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=IqNg87T+PLPaksN1EX5ArpkpRNCymh6cf/1zOR8n1OM=;
 fh=hYWYEc33lyW0P16TW8nARMuu/ToCkvaTQSPX2z7kNpw=;
 b=OL2P1/b27WzpM0S4zY5coSoJ/+lpLXJH7QJRnLr/WGlw4HCAR9CclFLtJ6wFVbkSJs
 dMy9tBf4lPCqcyUCHoYkzNmDVMObMyYZIV9HTNEOoHbMS+0QsqVF1+PyKIxo44I8bB3K
 Ns2y5UxZ9xnBZbhRGOVcpujoZkOR/3RxGSar3GLbFgFkzetTui4Ld2ub5wTQe8Do1a9J
 lq3bGtqptl6w932xD2oqIU/corXR04sElOSOPSlk4c8xhkYJv/orrrWfXsChEscDOoQ/
 cL/niXVGmxfPkItQw/RWllegJXdrOaVwac/tq9xPZPWTCjDvhY2C/jaialcwGTHSS5ga
 2aGA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1783952622; x=1784557422; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=IqNg87T+PLPaksN1EX5ArpkpRNCymh6cf/1zOR8n1OM=;
 b=W8/qRSFktoJMwVBfIFohKNgv2eshV/pFi1kKro/6ORCMeTTmH9vCdmq1Y+kbiOMh8j
 1sNbGLMOc/YgDUjYdnsnv3Ea9ILFXRjjL6edkj8XtkAdiwWrNrBZBxBgP7kA3to6J5Kh
 OPnilgWACgeE9yG/r9/gliLMgW543AJVKq1So=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783952622; x=1784557422;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=IqNg87T+PLPaksN1EX5ArpkpRNCymh6cf/1zOR8n1OM=;
 b=h8wdo1X3XVZ9DSVLb2lefovJGBW4gS7P6mvWSa+HwdpfB2rId9/4736glNlxYk4D0/
 WKpONbLDK2iJVUf+/Z4MYo6DwHIrLbv+TA2bNZmsyXGCLcIRP8F7LwGf7n45ZVAqzRs3
 o9bx4DhYcJ2Pl5u/LM9STBIfDup7lsqX6LxjdIOAmjnhW+IfsN0OkeaSjLl696YblKkC
 EEKKp6hxlQUfREdoQYeRiHYKm5c+FebDhiNxeg4QpsmRru+KU8aWC7X0IP/gzaLfAMNm
 hqUsKvpahGQqTtv1jsC/pMjWrB/hckAbh7nquZhKvLL7FrwNJBSkPudneemUA2crlSej
 R6Hg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr4ju0ursl+L/r+QVdnZJLRN6hpdc6w5WMK0EqNjPQM2p7qVyN9fJoqzHuParXRXPm2SC9Z2sQ=@lists.denx.de
X-Gm-Message-State: AOJu0YxaR7uRItCZa8nAEYu6/GHv66sTYS+Gw+Ynz3//qcc4dxlSErVh
 1rfboarSKSqnD1L2eEZZHyHOxIdmCDEEbAVVO2o1Mz8zdsukkdQvhEUy8aojSn56mcc+p5fGz8/
 EoWlD8lb6yfdJ8PyfCStyOq1TmP34bbc+5gH4INSA
X-Gm-Gg: AfdE7ckLmlMJfAK4z+RZkv8klTUeHynFA1JXoeO+RI8WIZCYQ2M3JrODUNwsrPN0U5i
 fdsy3QloDZwbIAwxsJACyelDx85FXZmXQPamQukZ8cldEKWI0H0GvbPYa+2DMMIhNZv1CP4EILZ
 +jcn3m09IEl3dlP3gJY+oxblv3jALycWa/jzHjbfu7DMd30cdAknlhOc6jQRu2Yw8Ob1jGAOaUq
 O5P3HXf6gjk3oL5PzYAhdVxcj548eEP4y/eu12Us6BOwSsdNM5xNQw+TPj/qqicsW03g9V+yTgw
 DnrHow==
X-Received: by 2002:a05:6402:5005:b0:69a:a9c1:c340 with SMTP id
 4fb4d7f45d1cf-69c5f247952mr3872299a12.32.1783952622569; Mon, 13 Jul 2026
 07:23:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260708220540.3368825-1-jonas@kwiboo.se>
 <20260708220540.3368825-2-jonas@kwiboo.se>
In-Reply-To: <20260708220540.3368825-2-jonas@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 13 Jul 2026 08:23:28 -0600
X-Gm-Features: AUfX_mwgs_TzHGCVxXTYRBrNS3zoWwAgDTxpTZJwseLkO-atdv3UIffHokB6IKc
Message-ID: <CAFLszTh8apUuNBw9UgjG4GE6gfWVPXmoUCoVYynv25DXwy2=8w@mail.gmail.com>
Subject: Re: [PATCH 01/11] Makefile: Drop redundant CONFIG_TPL_BUILD checks
To: jonas@kwiboo.se
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Quentin Schulz <u-boot@0leil.net>, 
 Kever Yang <kever.yang@rock-chips.com>, u-boot@lists.denx.de
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

On 2026-07-08T22:05:26, Jonas Karlman <jonas@kwiboo.se> wrote:
> Makefile: Drop redundant CONFIG_TPL_BUILD checks
>
> The XPL_BUILD symbol is set for all xPL phases, i.e. TPL, VPL and SPL.
> Conditional guards that test for both XPL_BUILD and TPL_BUILD symbols
> are therefore redundant.
>
> Drop the redundant TPL_BUILD symbol check from conditional guards that
> also test for the XPL_BUILD symbol to cleanup from an old SPL to XPL
> symbol rename.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> Reviewed-by: Tom Rini <trini@konsulko.com>
>
> arch/arm/mach-rockchip/Makefile | 2 +-
>  drivers/Makefile                | 2 +-
>  drivers/bus/Makefile            | 2 +-
>  drivers/mtd/Makefile            | 2 +-
>  drivers/mtd/nand/Makefile       | 2 +-
>  5 files changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
