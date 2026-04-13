Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 686FAF34C5F
	for <u-boot@archiver.kernel.org>; Mon, 13 Apr 2026 14:58:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A6350841C2;
	Mon, 13 Apr 2026 16:58:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FJoNSTj9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C8DE684227; Mon, 13 Apr 2026 16:58:33 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DDA8B83DC9
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 16:58:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-b9e00649769so73198766b.3
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 07:58:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776092311; cv=none;
 d=google.com; s=arc-20240605;
 b=bWCdU/5/aggzlBMZUXZBKl+nb7FX4hI9FWu8aIIC9+HMI1oeEHpH12Da/pcPK/aDo6
 MevKz+h+XIR2WsN1H4IXMR0P88ZOdmyT8UOQfnQh8O2Tm0GszHMpkYWKQu3kA/PM1mgB
 6tEpG/WseY9KcVT67VQ6Ntn+LQlZABKeZXX9F3Gs7GhLAVE9+BL7lxXU0OKwcrGCYGrl
 PuIR/EyA/8U05vJU7bOcrnZwv+Vse5/gPHTY0v6vGFpRE0V9TPsjlrG9RyMXXnurAZGh
 bI5O/qk/xEpPVRmZk2D8yXv5AGbsp5vqi2CL5Jq1LIPnbeptWUXRCFW8x80YTdP5Cmlh
 +iSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Xudkgl9s/oECjWJll9DS9vDCWUIVBz67i6pjE9OdJ9M=;
 fh=dF+eCHOIT6SIbAzI5tBwPFZclvSQgQQ7Zo1JXO6SSnQ=;
 b=ffXjipKlRGOZGryWRn4A7ozobA77NOdPgrSzYBXzWTZ9oPfmDVbWr9ShuLIwCXYUyY
 aIFp7ocZpf0s/D6fDALL6exn9I/zd0wuWeyrMIR753bnUJ8e8+E55FitjcO8B+VgcMFN
 qzwr+uJMCzG350hG6Ws5sesW4eeJlhwfb6bUrg5me4yRN8cIbauivkVfpgdeprxdx7qy
 2QHq88vqRv6jr61jFJouSuclaFE4yPVGVmzHwuUj3Lp9HOS7T+HFVsxOgheAhMGUcEMU
 g1uysISnBOhkSt5M+P4vl2vGwx2bhKtabcrfpM4V3REcP8usxYkDr8OrZcM1Cmv4Bu2H
 Ko3w==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1776092311; x=1776697111; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Xudkgl9s/oECjWJll9DS9vDCWUIVBz67i6pjE9OdJ9M=;
 b=FJoNSTj9xOm+rE5RusZ65AF6Lj/w6X6lQtK58zfDMQqPKaBA5JkMT0noaOZEUXA1wj
 nJYASFpLt+41o48qpXz9UBCCOwx2EYryqT7WdgGhHB0VIX+8XBTGqSqqmCSCY0hlC10A
 vY+EZYT42et14xIg5Yw7ETr8VXoYYFxGhIDh8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776092311; x=1776697111;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xudkgl9s/oECjWJll9DS9vDCWUIVBz67i6pjE9OdJ9M=;
 b=lkuajO9HTvIu2BVFVEC4EF+9T6AVEg4HTmHPymtl6VK8jrHTvItDOFQSzUnx8kRoO9
 UCIzvU1ZSPnQSq2B4Gvr3dYjLDk4D1VQghlCaKYq9JaDnBN8thNgfxjieAcc+P2MiVPM
 nwW8IgSTYi2gyF8cwKuPu+Y0rLeFCr2KBwqfP0pRpuMnkCQJFD/HCngxv6K+pdzIA2FO
 7OVqpAcydbzf5HUCngz+rdBYHLw2oWVKE59cgCxoZrC1jl/j5zHOWndkOdTBkhGFNqw9
 ilOSTH9h5+ehvY9FCF2k5FE/J8zplXgDwluX29QdhNI56QZFZx8QBFF2ktdSvOgiPcLo
 1R4A==
X-Gm-Message-State: AOJu0YzdcV2cpKNUenSqLF0pl1/YuDCbp5l0wbNp6vDGz//2VJh/s9Wy
 LwT+HFoEy0mEaQi0qaM8qNzw2Yo0V5ZeeFklOgxRXH+MJU3m7hXcOnKjTR272FKoCv4eEWzbu97
 G6jhSaca7GTNmlt7cpt+OtAO8nfomJfDhs9MBFvF6
X-Gm-Gg: AeBDies9CDK5OVaiwR5YHBPw1xzCs6K2CZSgM4wr8R9IsMGqsiol7ffBx82dDejD//H
 g/gz8kK8uvloOjT7Kqvm/hsd5VQgMvqMQ9KmFy/1IOVbXX/1pBTmHcYLMPqXBtlKW4WiyzDv5Al
 BMmRY3RDsJq3QFCKC6b/lcmoUTCKxiVTjtr6gbHTzMjE4JGfjtB3YaaatV4+IpMtaEOYQGdMPLH
 teWXQVoYXrW2vMzjBB6xvgOsBxKjIgkzyvXxrjV3ylQnFimooqj8K946A0QA6403MeGE+KASPtd
 xgJwXg==
X-Received: by 2002:a17:907:e106:b0:b98:595c:a76f with SMTP id
 a640c23a62f3a-b9d7279304cmr481666866b.16.1776092311194; Mon, 13 Apr 2026
 07:58:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260412195947.1982729-1-ravi@prevas.dk>
 <20260412195947.1982729-5-ravi@prevas.dk>
In-Reply-To: <20260412195947.1982729-5-ravi@prevas.dk>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 13 Apr 2026 08:57:15 -0600
X-Gm-Features: AQROBzANCGKSlz5V9Ao3YdNmX_5Z6-xn8vUezppu7HOmN5cTOyydKsJBT4x6Seg
Message-ID: <CAFLszTiqQYNt_g1h=UjfN=jhnitSPznV9PENpHwcdpYAyn=ymg@mail.gmail.com>
Subject: Re: [PATCH 4/8] lib/string.c: introduce memdup_nul() helper
To: ravi@prevas.dk
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>
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

On 2026-04-12T19:59:41, Rasmus Villemoes <ravi@prevas.dk> wrote:
> lib/string.c: introduce memdup_nul() helper
>
> This is completely analogous to the linux kernel's kmemdup_nul()
> helper, apart from the lack of the gfp_t argument: Allocate a buffer
> of size {len}+1, copy {len} bytes from the given buffer, and add a
> final nul byte.
>
> This pattern exists in a number of places, so this helper can reduce
> some boilerplate code.
>
> Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
>
> include/linux/string.h | 13 +++++++++++++
>  lib/string.c           | 15 +++++++++++++++
>  2 files changed, 28 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
