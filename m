Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9368F10F6FDB
	for <u-boot@archiver.kernel.org>; Wed,  1 Apr 2026 22:01:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 14B4F83CF5;
	Thu,  2 Apr 2026 00:01:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XX0uhWHj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0357984011; Thu,  2 Apr 2026 00:01:30 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E2B6D80517
 for <u-boot@lists.denx.de>; Thu,  2 Apr 2026 00:01:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-b8f97c626aaso33684166b.2
 for <u-boot@lists.denx.de>; Wed, 01 Apr 2026 15:01:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775080888; cv=none;
 d=google.com; s=arc-20240605;
 b=IhxU6BhPfH5SvIba5neDRcok6ZiJqxNt7iw1eTpy1SmCrkj7/bIb5P4m7JdxjDHH9u
 7vfT9f2xsRbhP7pknLJqwYjrNJAx1zx7DN5kGCqoLdbIuA6CJFHY/Vx97489Uw8If231
 voaOPxO0pVELdmN066TdjeNpa5eQpwElj3kPvh1cGi7GQ7EJNBYnEmGPcnpgydCRAKHv
 DXZ/tkgFoj1p6MMXCbd6OWMOk7RoSIbV++rOER8s+n/BYOibJDCLvmnG75yrrLViXEdS
 8i1r521+TmdTAfQZpsg2aG6/xitwFYUZ4z7PlbHMdl7hrMVtpgb3k6WH/X3ee+ZkOgBe
 kukg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=xqDoPL8U4JC0Jahw7FHZp8QVxwjKI9+BdQJAdV+/wnw=;
 fh=xMScigplb1Ri6T2TwFiAE85UFm0X4RBg76ppSgahp7U=;
 b=f3AM/Qxj0GBHG7rLtoRJ4fcZmx9bNEDPh3IUncicrAvzMJJ5RsnVLFOYcPe+lZ0YR+
 RndqxMv1jXLFTC7ag2pBFI7B0BiX8QGnk92U+JGStXIhYah9lGkuOKGkjxz/+XMseFol
 4of7nPDCX8blmBgiv4UX0eHUxaFeVFBvhjOGTr6KUpLPyXVvrHIsdEGkwydn814Xf1Ug
 Beqc15+ajJM+AbBkk2B7NSqoNSF6U3DKHkZ9gksxYiWIsUea1cigByJZLL/D2r9TVpUU
 3NmQmuQva08GHU40aFmrrsHcjbaOxk1VbovUPtGuh4DYbckmsPqAP6SB3vyhFU0zs+rS
 aOLg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775080888; x=1775685688; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xqDoPL8U4JC0Jahw7FHZp8QVxwjKI9+BdQJAdV+/wnw=;
 b=XX0uhWHjVk77pUFVCGOspJieScN/vngO1J44keCalTXbG8Qz8GGjBxCa+LwsoCFr+C
 p5Hszdnf+VQi1Dz7ELkP2KvESpr1paE0vQ6/YWDKGxzo8E/YQB3rdUV1Lg9mxP3u9OX0
 AjHPdkWUVa2XPUc3zoOOASLzH4P8Nlm01ihUc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775080888; x=1775685688;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xqDoPL8U4JC0Jahw7FHZp8QVxwjKI9+BdQJAdV+/wnw=;
 b=QPsf+iKjT6dL79E016jYmvOi7ffbU8nEEE4VRSuqymoNEiTzdxB3rpSQ2ldWNkqH0r
 sx4v/E9XQWi2pYl/NaHUKEz2Uz7KI6G5mDJSQ8XZqgKv7Ow99daP+FLCe9f84ix1gYtK
 GF0lk+fS9Dg50pvoRhuTxbVAVQYWC1nT+8RwMtgTwePyr4h0ZGEw7IU8ZGrdZYDGM2Te
 Ll9faLsLK+b5liDg5RXH7r/45dS/hyciU0FgMDxOZuyp2K1bheu7A9RoGP2wgUFxq3/V
 nduTKf/uIBuES30o/yhsRCt+AIVyNCEGOhfPISHC5hrPD4K9sgkle2vhx9P/W+XM3ep3
 SCIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWP3AiDMqv9ptEEGRKOO3QV4UlbR1ugVr65BKtuiSWEVnup9osKg093ejWDFGyof2wL9/q12i8=@lists.denx.de
X-Gm-Message-State: AOJu0YwTqUDhzVsH3/Qk9LREQ3yAcxbts90NCq85WMtpa4Q/7037Yp6L
 DjjaRiA+rlupX45zX1Vdo309GUhUpHl9rybnLo5+JrN7L+ZSEgmjG++ErUhO/Gnk2p1rIB4vml9
 AtOt38JyEGOi0zxbgRNywERhE3/xKUnJ+t/5idn4u
X-Gm-Gg: ATEYQzxb9jx1OjiTOsrM7s4PX6NBZebtKuTTDRkSa256om31u1UrRFf2quGeVXqCwmT
 /uMTWRn+FfN9466+S39EZzzB6GNj9ED8VMBmT/pQXr7bT7teDkSn+GHlcZTQ9tm0AKUh77YOoBc
 B9hwvOaDlJbUobHIrloAbOz1Rcx/QBWKZR4WVI+O53pa8Mg9t73LXJcIPp3NKlLw52HisVdw0k8
 Od57pBw091iVJVuX13JK6XU9LWJ+CfftPiYMkuCr2mFvf6eYwC4Q2YFHnBr02vRHKAsed/mvk/3
 wN1Ovw==
X-Received: by 2002:a17:907:a78a:b0:b9b:2c9b:f9d with SMTP id
 a640c23a62f3a-b9c1379e031mr339681166b.8.1775080888062; Wed, 01 Apr 2026
 15:01:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260331100047.34618-1-philippe.reynes@softathome.com>
 <20260331100047.34618-4-philippe.reynes@softathome.com>
In-Reply-To: <20260331100047.34618-4-philippe.reynes@softathome.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 1 Apr 2026 18:01:15 -0400
X-Gm-Features: AQROBzD3rNwLsyAOFdno6Q_-pCoP8IMKZNI6JQtlr4WocB8LCQBduSBDzxyfGdc
Message-ID: <CAFLszThtwqpeJkjVxqMZyQWEmcNfYUaJUt5GgseyPbT8oSJ+yQ@mail.gmail.com>
Subject: Re: [v3,03/15] test: lib: ecdsa: add initial test
To: philippe.reynes@softathome.com
Cc: marko.makela@iki.fi, jonny.green@keytechinc.com, raymondmaoca@gmail.com, 
 trini@konsulko.com, simon.glass@canonical.com, u-boot@lists.denx.de
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

Hi Philippe,

On 2026-03-31T10:00:34, Philippe Reynes <philippe.reynes@softathome.com> wrote:
> diff --git a/test/lib/ecdsa.c b/test/lib/ecdsa.c
> @@ -0,0 +1,447 @@
> +#include <crypto/ecdsa-uclass.h>
> +#include <crypto/internal/ecdsa.h>
> +
> +#include <mbedtls/ecp.h>

This include appears to be unused?

Regards,
Simon
