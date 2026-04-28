Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E016AFF886D
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 13:59:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43507842A2;
	Tue, 28 Apr 2026 15:59:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="H4orNz6X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 537BB84119; Tue, 28 Apr 2026 15:59:51 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C1471843B6
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 15:59:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-671d60ef9c6so15850556a12.2
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 06:59:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777384788; cv=none;
 d=google.com; s=arc-20240605;
 b=AtyMgTz8dqbVQmTN1xh22rSIq8Di/OWeMUyqB5iPm+mg+jztPlhu5e3MAegtuKsNtK
 jI2ZbVDg9HuwZYvRtAoyRDsLFPTeRZ0hw6dbObTZn7esq4H9rk5p9lDAhtJbOFtoe6py
 YJSAEFrPpBGQVVeWwEUQWoa34rBbl2v1tVfPsoNstNyne+Lxm01NeK4qeDTTj2vx9utE
 eDbZDpg30tSJmluNUbTZ+XlQu8GM9gjZzxGJuKgF8pACLLiSCy9cZJnhdF27wpK+JgFW
 OT2K2BjJMijKTTxLbNHtMGz0e0eI+pvPke5kPkKdiVd+8INyu37zY3zkJoS1aqBFSCHt
 kqng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=1kHx+2zuFfpu2BIdpjj5sFgAS3aUWzFwb5BdBv7jUuI=;
 fh=LyWXhRk7bL3vLuuO414j+hAh1yGFrGrsN40daxgJ+Cg=;
 b=fW8i6ntMooTTfeL+NTFhoQKjw+CDJsU+J8Tg68yXxCP9yTZQV4LxLkP+R+dCh0vLtA
 gIkftgQy2/YuzJVsfP5fUOyr0Vri4pDK3cO4dFLAl9urA/f+Sk5INjYN3NSolpqbGr+T
 FAONcJQSJAW1vdbi+xZlgHPWB+1ePHK8uO65OzWR7tX7MO20k2bC5+aUUmQEvvuer4kS
 x5lltw8sVeLodoK9Rp0gcAqspNhXiK7rk1vm5qpenVnwgVQTJURv44bmk9fJGVUS48//
 6YW8fZY7tgPnA+8m9EqIdcSRdZK/8buStIEmB5N9cXymJJdX7Dns7hfWLHgNhdnIpvPP
 ERQQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777384788; x=1777989588; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1kHx+2zuFfpu2BIdpjj5sFgAS3aUWzFwb5BdBv7jUuI=;
 b=H4orNz6Xq251lDf8zkbMM3S2odsUF7aHKohdQ8GjMCCrD4cT1a4aeFEh7tua4aXsp9
 73KHFCgyGT+1bYzG+uDfJRD2CnnXPqR7g4xw8kNQbkbhIEBN7CmleidKm1WKi/6qY9Od
 eboz7M41K9t88G3Ohj1Ra4Xyd410aFUo5TrKE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777384788; x=1777989588;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1kHx+2zuFfpu2BIdpjj5sFgAS3aUWzFwb5BdBv7jUuI=;
 b=qi5LYYjmKkTmlTGUEn42Qq5BOR8HbrYVupsqkNBq8AIXNntbNmMJzsmzJxMn9NgXJ1
 GXo7/G8IRGCqkZeSS29NgBdmivxQ9rX+iFsqe8F+ywQfLNhcZyed5RIC/mOPoFZBfMi/
 qC6Ylxpf1A7bn0tGsrlGLkiFBv4GG6UGc3a0By+uLyjHxRPC6vtIzXewuaSVMnIJP1kv
 z1G19jTbMELehXGan6hVV706wQVmd1broBODd/WT4s/CMOL7mD4E0hkLPpcCio6qElzZ
 LttenZlS0t36F/Z3SCM8TLuNIzD7oOjC5fd8sw7Wbgs4508iJHF2GSGeybr1ziDRW/0V
 zsxQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+nuL/kKY8KjZsKZi/Mf1dKtU0URGt1+xlDEAzW6K2xvPOzP5lgb4eM00Etk+uvzsGlMuDGXmo=@lists.denx.de
X-Gm-Message-State: AOJu0YzrpiqazNUPggc48NJGgogk6EV6ne4RwTUr9R1sA8CjA3O3KWdq
 SDqVtYtNTf3OmnofF8JphDk8AlwvCSbyvzLkdBGptI97ANTiKcJpMEDJw95Pt+1TNtvc3iThaZD
 88Rc3xNnnZuZzHTGGJpK2OmQwMcXlFXyxNVH6/ksK
X-Gm-Gg: AeBDiety5bfDMVGeYDSdprAqovkLRRMcDarUikvlg9xD9R/7XjyphGEnqTY0Y4IJRed
 7GTCg6cPXsUbvTykTZtTwbKRxhVbrINW75Z3oCapabf6Mb4E4lZwviyWTt+d/JeyS5tGHMrwHwD
 IowR9x74vtfDa9JgRRs3Sklz/r4GiXYMD/kiVB+hLmy5p2dtosQV/H2F5NIRFeLJYVaDa8koPMf
 GZPApAwZ87aBV34G1k/Ow8NH2pV6B79bGZxEzI3i5dqDMQav02Ns9imR2SdVeIjO2N81LZoqMqj
 27s97dz+9998J3+t47VVYDY8isM=
X-Received: by 2002:a17:907:3cd4:b0:ba6:be92:a58f with SMTP id
 a640c23a62f3a-bb804e21da9mr189835966b.44.1777384788152; Tue, 28 Apr 2026
 06:59:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260416093927.602613-1-daniel@thingy.jp>
 <20260416093927.602613-3-daniel@thingy.jp>
In-Reply-To: <20260416093927.602613-3-daniel@thingy.jp>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 28 Apr 2026 07:59:33 -0600
X-Gm-Features: AVHnY4I4Xg8V7S9GhWla9C6U8JWIFIbsSqzwWIymXlDaTHGgUs2XJPLtXWJWFa0
Message-ID: <CAFLszTh+do28YYV76bPb4dpmfEhamRtLqk7VoQsF8NYmJY-ttA@mail.gmail.com>
Subject: Re: [PATCH v5 2/8] rtc: goldfish: Use __raw_readl() and __raw_writel()
To: daniel@thingy.jp
Cc: visitorckw@gmail.com, angelo@kernel-space.org, bmeng.cn@gmail.com, 
 sjg@chromium.org, u-boot@lists.denx.de
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

On 2026-04-16T09:39:20, Daniel Palmer <daniel@thingy.jp> wrote:
> rtc: goldfish: Use __raw_readl() and __raw_writel()
>
> In QEMU, the Goldfish RTC is explicitly instantiated as a big-endian
> device on the m68k virt machine (via the 'big-endian=true' property).
> Currently, this driver uses ioread32() and iowrite32(), which works
> by luck because the underlying readl() and writel() are currently
> broken on m68k.
>
> Use __raw_readl() and __raw_writel() instead to avoid breaking this
> driver when the endianness of readl() and writel() is fixed.
>
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> Tested-by: Daniel Palmer <daniel@thingy.jp>
> Signed-off-by: Daniel Palmer <daniel@thingy.jp>
>
> drivers/rtc/goldfish_rtc.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
