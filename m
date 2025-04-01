Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A773C36010
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 15:52:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AB57D80FDA;
	Tue,  1 Apr 2025 17:52:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ZlHCvYFQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 300EF81782; Tue,  1 Apr 2025 17:52:10 +0200 (CEST)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com
 [IPv6:2607:f8b0:4864:20::102a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE6B480584
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 17:52:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-300fefb8e06so9352509a91.0
 for <u-boot@lists.denx.de>; Tue, 01 Apr 2025 08:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743522726; x=1744127526; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8DO+zZZClVyGzOqjz2xXsCIa0dkJYK57LmG+WeRmKBg=;
 b=ZlHCvYFQP0fXiBVrCp8oJ7gYxMto8YS/20fLqql0fLVbgaFjqUPtceOn0pnzO18smb
 XezVRTqDx+RvBH00fyMuaI8Od6x6c7MOmbe/+WYWIy8dFs6PgtUvZb1ObtBp9yBfJYnQ
 AQGT9O3KDVCK7x1EwjIFSKNCwqLd2UUj0IIB0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743522726; x=1744127526;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8DO+zZZClVyGzOqjz2xXsCIa0dkJYK57LmG+WeRmKBg=;
 b=JRjFR+TEhYPhnd6ldy6JWe614BknKIkb1A1XEsfdMjRYndssjn/PB3kKGRypODlw7O
 tOGM/NRa7dDqUkv0HFxDF6+k1NtHhEIUHZTkHLGTyzQAii4I+IjcX/RJkBk44fYehInN
 aylOJOzaNIvybSgsOqTcil/tpM7UiPqZz4IoVKDCuXutLTqyVwdtfwrUP9CIJuGnKqdc
 6P2Ot03dHCI25a5qiEYg7RL0RNpjtazHW55Pg35G5zRcepyzc11UvBFIJQ7f4hjwPOCq
 4lWQhQ5WdnAJ/nG+eSQn+8KiOeYO5Uam3nyBr800Gm703gmii5ZhCBhR04E/bxkmdmsL
 D7pw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5X1feOemZtN1NtRrXc5qosGbvJ9gUqlwRtHQqJOd4GALG+PgLx5aqtEyOQADNz4d3HMeATKs=@lists.denx.de
X-Gm-Message-State: AOJu0YxpvoquX/VMgYSmKpzXsV7tabcYmrdVCoAz8KPfB2Ty3G77UFsq
 uU0EFJBUxtZiYfWSJfim5Cni8IKq5XtLDofruqLPeWYGews+/OAwAS4HO3AGwcQ74NBqgH1Mu+K
 +CPUyKVAlIsQZtX7KlhgYwynnFOeM1mR/rAmQ
X-Gm-Gg: ASbGncvlnwvMqjo2eyIB1/kCmWknPu/7/SlFdZAKQlVSjTbSHKfhxec4hK9cJv90sjf
 IljtAJb16Xu4By0YaViYegEqGzUN5B0ImtMZWEwbRPR998wW04hJO5Qs9It4qfqwXwlGo74HdP6
 QbDF0gxKTNVZcrxzB7GzBVivWzyyNp
X-Google-Smtp-Source: AGHT+IEWI1pNIyMPyoABFLu1bIWGpSrz3t6lRoDOdvfzyO4O4lxNjB5TBVm0s4pWf+khsJpJoFg9ygOIfjRxRip3JxU=
X-Received: by 2002:a17:90b:548e:b0:2fe:b907:3b05 with SMTP id
 98e67ed59e1d1-305609667femr5703770a91.29.1743522726415; Tue, 01 Apr 2025
 08:52:06 -0700 (PDT)
MIME-Version: 1.0
References: <20241220003447.2913443-1-sjg@chromium.org>
 <CAFLszThUo1u58Vwy77UEQZG79f7-BB2ysB5-oq-DHbP4c_ciRQ@mail.gmail.com>
 <CALeDE9MFGFEUmOHyOFFyLL4TeaZKjDSt+LBEfNEGgHSdtwDetg@mail.gmail.com>
 <CACr-zFCecvu=VGp9ncHSF1QY6U-hu_NgxLoij6O5n8nsjao-Mw@mail.gmail.com>
 <CACr-zFCzVpnstegc6yr-BSJ7SsveOBSqVVHEpWRAA4abEz99=w@mail.gmail.com>
In-Reply-To: <CACr-zFCzVpnstegc6yr-BSJ7SsveOBSqVVHEpWRAA4abEz99=w@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 2 Apr 2025 04:51:44 +1300
X-Gm-Features: AQ5f1JoQyKY1u63MYQLjfOjvVmztBI5SCtOe6cplBU1H5AnyooxJ8q5oR8PPphg
Message-ID: <CAFLszTjKXu+LH0Pjv0Sjp3mwgz9fOyMyujU6T3AWMY9XXiHoAQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] rpi: Tidy up booting
To: Christopher Obbard <christopher.obbard@linaro.org>
Cc: Peter Robinson <pbrobinson@gmail.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>, 
 Stephen Warren <swarren@wwwdotorg.org>, Stephen Warren <swarren@nvidia.com>, 
 Matthias Brugger <mbrugger@suse.com>, Tom Rini <trini@konsulko.com>, 
 Caleb Connolly <caleb.connolly@linaro.org>,
 Francois Berder <fberder@outlook.fr>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 "Ivan T. Ivanov" <iivanov@suse.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, 
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Robert Marko <robert.marko@sartura.hr>, 
 Sam Protsenko <semen.protsenko@linaro.org>, Sumit Garg <sumit.garg@linaro.org>
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

Hi Christopher,

On Mon, 31 Mar 2025 at 04:03, Christopher Obbard
<christopher.obbard@linaro.org> wrote:
>
> Hi Simon,
>
> On Sun, 30 Mar 2025 at 14:29, Christopher Obbard
> <christopher.obbard@linaro.org> wrote:
> > Side note: It would be quite nice to add kernel_comp_addr_r and
> > kernel_comp_size to be able to boot compressed kernels; I will put
> > this on my TODO list for some day.
>
> Please disregard this false information. I looked at the diff again;
> you already added it in your series. I also tested it; works well!
>

Thank you for testing it.

Regards,
Simon
