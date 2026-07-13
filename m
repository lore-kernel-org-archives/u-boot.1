Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46DF8C44507
	for <u-boot@archiver.kernel.org>; Mon, 13 Jul 2026 14:29:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C342084C56;
	Mon, 13 Jul 2026 16:29:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DwMcOFyN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9AD7F84C5C; Mon, 13 Jul 2026 16:29:26 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF34184C55
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 16:29:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-c165a41a52bso39394366b.3
 for <u-boot@lists.denx.de>; Mon, 13 Jul 2026 07:29:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783952964; cv=none;
 d=google.com; s=arc-20260327;
 b=NaroFam8DN3sI6Uphl1ODtWKuhJW0eEsgEBNRYab0H4CfS5NbSQRhyzqyl7cFFEUZo
 15HsPeA/00+l+4t398dcqKgsPrHtIPOetTrDaQ9MiQEqq5poTJl1X7ukWhBuyfHU5J/t
 05HDgCNo7f9EYk2t/JJHWOlMBK+q9TmMQ88e/hKkzBocOjVmAT9gvZCOXTOuewqxNArB
 XYwejOiRVaZjsc0egIk8LhsKCRkFcEjVrFAL5pJXyC1eMcDVsUUlrQOk6VwjcKWZ+R4H
 +AvmMQi31H/trp7hXyAlxFcPEPmIQ86yE0BkIpU63XbpOcM2+v0Pxk2z4nSKpfWmCQm+
 cbfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=h0Pa/HeZkyoHGlWrwkc/oBn6EzdXXEqG0s0Q406HZGM=;
 fh=BPbJXPvbnFXv1FsvaaL2Uxh2ezIiO8M31mBnn2yMbVw=;
 b=rDuzpj09AXRsLkPBQmevERFljBcr9qki7yqq8CKOk8KY1txsdwk7cnaiF/DcDATvUe
 scR2uG7uPgmtnqJrlXSbjwjguQb8R+tdgyg2oANt3rbmHM3fwTa0aoTFDONK0Fu3MfHC
 HptLlQgAtFWGfflNFYNehh/lnR5DVp/Tb4neOersIqjYn2+BtlwkaNCdNsGA4TPf0vLF
 k3XRpN5MPkSMo3CDHcZVoOo/OmFOyViIlPgEhZwON7mhN+PInmXYPMYAQdT4uBWvjIrz
 HQSlBiXO7b6pGyZnzF4AEd9meQlHQXiZD9smJxcnVSjjh9rqgiwvC10APCZttD0UpVmS
 51dg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1783952964; x=1784557764; darn=lists.denx.de;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=h0Pa/HeZkyoHGlWrwkc/oBn6EzdXXEqG0s0Q406HZGM=;
 b=DwMcOFyNLhsSbcW0OQaFtWoQeU9GBMrAiPgqVzJwxRdVyn9ugINwBv+C7c6IbhXMuX
 Gz1zENarBDab2COln4W60wq7Lv4Ji2WraZxzSi+Sh5TQCnwCEUs2Sna9K+U+Cyvz1t++
 W3y8qd0fOrcYYTUWUJ8ymEcjyepUKOYDUXFo4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783952964; x=1784557764;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=h0Pa/HeZkyoHGlWrwkc/oBn6EzdXXEqG0s0Q406HZGM=;
 b=rnESqrtgKCd9Kglj5/Sm3y6d5ifKiTLY7P/LhglF7+pEH1LHAwPFb/E9bgduWV2Obm
 jhi6S7nHOcnyl1xVGv6KLaCd82IO4ETrLulkZG2LqqHcLYpx+LbnM2T5KAGaP5UoHCD6
 zixqJphhczT1VpkRUlb7dRopxPbiWkJcTYqAspSXscK4kcGCYcZBaVH1mgQ3Dy2ak8qQ
 Vhf5whK49k5nee6D4AjHXwUp87l4I7+JvYymOXF2R8pRT7cpfvdn03I5RN/MF7kwie7N
 CebxWGKhtecOWzEz7sp2ulAPGV/g2V2zESU5WoOpMEyFh6xvoBc0yzly+VTQDKeAJSLE
 CIxw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqlwesFbaLRaFUOI+obhsamEbPq92xn8NNtSSow6tbqErsUKuFIBlmQSnzVJseGUg0X3F1Jh8Y=@lists.denx.de
X-Gm-Message-State: AOJu0YzqUXNMuKEImjankEp0tScIXXye2IKr6HZPqiIxLmlCoRWdFVCQ
 r9s4Y0BPLGzGtskdzw+8KVHqDVWAJ1V0+yHbTuRhiQUgx7OVEDZ0XcpL+kU0edLP6mss8qULk4R
 334Dn+rXjKioC9gbDAcq38VccloBzy6JyxQbq4QKL
X-Gm-Gg: AfdE7ckvb/vJqSoYCGNxnsrP2SGk3+r2YryzcXRRcRMc8oLz7aSBV0BbnbUKhcU9SwB
 b3+oQdvMNiL+KKBm1o7LwEwglC/vK4MC+AbuNcfWFQPdPyGOOu2YJ2LsP9zlzDNuJhW7ZKWpE+9
 Rqq2phe+GeWY0i+xWx+3AiutvJoMfaM65lVmZ8YPunMtDR6lzbWMCzYS+vS5gs+ISOXML0AmR2y
 XJxozn11o6MG0QorYmVEYGB88RNwR3v9SFA9RvEJghklau+x13dKnvVeiteNf0RZF3Ws0g=
X-Received: by 2002:a17:907:706:b0:c16:55de:60e4 with SMTP id
 a640c23a62f3a-c1655de94c1mr88974866b.50.1783952964318; Mon, 13 Jul 2026
 07:29:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260708220540.3368825-1-jonas@kwiboo.se>
 <20260708220540.3368825-12-jonas@kwiboo.se>
In-Reply-To: <20260708220540.3368825-12-jonas@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 13 Jul 2026 08:29:11 -0600
X-Gm-Features: AUfX_mxLOH7sdFpsKzaR0wFS2IHRtaP8qgH3Kpgzc4v3W78wDzTWXbtZjo35Tfw
Message-ID: <CAFLszThDZTQbO6xPntwXUuECFR3EoisCD-9koqyyobUdJUcQ2w@mail.gmail.com>
Subject: Re: [PATCH 11/11] spl: Use CONFIG_IS_ENABLED() for LIBCOMMON_SUPPORT
 checks
To: jonas@kwiboo.se
Cc: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, u-boot@lists.denx.de
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
> spl: Use CONFIG_IS_ENABLED() for LIBCOMMON_SUPPORT checks
>
> Use CONFIG_IS_ENABLED(LIBCOMMON_SUPPORT) instead of directly checking
> CONFIG_SPL_LIBCOMMON_SUPPORT when guarding printf/log calls to depend on
> correct xPL_LIBCOMMON_SUPPORT symbol. Also change to use IS_ENABLED()
> for the XPL_BUILD symbol checks for consistency.
>
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> Reviewed-by: Tom Rini <trini@konsulko.com>
>
> boot/common_fit.c        |  2 +-
>  common/spl/spl_usb.c     |  2 +-
>  drivers/mmc/mmc-uclass.c |  4 ++--
>  drivers/mmc/mmc.c        | 16 ++++++++--------
>  drivers/mmc/mmc_legacy.c |  4 ++--
>  include/spl.h            |  6 +++---
>  lib/hang.c               |  2 +-
>  7 files changed, 18 insertions(+), 18 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
