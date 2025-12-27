Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C833E8FDCC
	for <u-boot@archiver.kernel.org>; Sat, 27 Dec 2025 14:24:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF16483BC4;
	Sat, 27 Dec 2025 15:24:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Dy0pw4pn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2929783B8A; Sat, 27 Dec 2025 15:24:49 +0100 (CET)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com
 [IPv6:2607:f8b0:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F028083BC8
 for <u-boot@lists.denx.de>; Sat, 27 Dec 2025 15:24:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-7aa2170adf9so5972274b3a.0
 for <u-boot@lists.denx.de>; Sat, 27 Dec 2025 06:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1766845485; x=1767450285; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Hffhs1D7JqD4imcBb7X7sL9MNDIF3RICzWmwWETJsxo=;
 b=Dy0pw4pnjojKYHYphLw/+mtlUTiEVX76yypJ8OtyE22s/QkVzCgflkgzssukGASx9W
 S9UcPayVu1P12i8EPe8BufA/qnZYDTxC4ud8rjkDPHd2GYInq0+ct1l94M9PZQkMiUjy
 AQvSEd0XMUO2Ya7SV3LXxqgLcr7r+1h2OlfLo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766845485; x=1767450285;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hffhs1D7JqD4imcBb7X7sL9MNDIF3RICzWmwWETJsxo=;
 b=ZGUlTlGhugmkWWPZDtiemp/3mysgGCmGn/y/RyTQAHurBWdmcnmgxQZDbA7RgHj/JV
 8VggxsWtnXUK/LQGGPdshZE/7z1DKreeYhUomsvjb0CLCDDI+6NgzIArPZN3XkESoAkg
 f299hrw39Ff2hnci8PN98VaAQJDPBYQ5Y318ComLiZGH5/+eQUXLU57x+jaHdRszk6z0
 qeF8a7hzlF7RdJrhapvRFczEYpx00WLmocmbeOYcG0JP3t66Hh5k/gBtLzhPcN8Oo6Q7
 pViEMe9PldRgqXwOwZi7XexaW6jkpp2/9sIqk+RtseZyG5pAbaCxeaIcmvL6wA+sbhzO
 QWug==
X-Forwarded-Encrypted: i=1;
 AJvYcCULyrLZcO2ihWC/DOj55alrJSTtnEMGGDYDISZoOrjviDUO0+U1GLBao1wq/2vqLUdkaV5BPZk=@lists.denx.de
X-Gm-Message-State: AOJu0YyTDhPdLUpM9902vXglkhvQJGYtOVbyb82LDpH8ZdK1t6O0WvpQ
 XeaAMevyIw97gmtZxjpXtPBwhJAqAr2N8i5D+6Yugg8OuA/Els8Rsf7SOFdEIfz8lvKUkPoX2pY
 lqu3X7LegHD1ZHhHbG27T76g1bMeeUJ5KdIzryePS
X-Gm-Gg: AY/fxX4rP1/g3AGgF9HwrVud7LcYD0l7Sy5OtBMLI5+lCfw7oTmJqgXEG5qt3N1ToL1
 lCYmz1Sljnf5vr5fIsZtQgT0AjY0zLiDJFnPlw797SEY4eVFcTw+VOjJxzJ4MMMCZte8pC3+nsm
 Y+vGENEuTMc0KKox6A9IuOqn8RQ/bNrX69g3yWeLI/hlU3PGcGAtciG9erAKi2xCW02jZtpAeHG
 36IaSFg9+o7zOgD6Zorf0tK/ab9VAiEh23qGmpckHbcH44PHprdZ49nZizgoEEDMZGK3Q==
X-Google-Smtp-Source: AGHT+IFZR6eY0hdb/qXwCHJCw0MLGGrqw+G6khXJkeki6vWxGprE7Tu0fKjnalVKnGmo1YlnEm+D5UHG4Tes4wSQ+0s=
X-Received: by 2002:a05:6a20:1590:b0:364:86a:46ba with SMTP id
 adf61e73a8af0-376a94bf564mr25235599637.38.1766845485434; Sat, 27 Dec 2025
 06:24:45 -0800 (PST)
MIME-Version: 1.0
References: <20251221015859.738112-1-heinrich.schuchardt@canonical.com>
 <20251221015859.738112-9-heinrich.schuchardt@canonical.com>
In-Reply-To: <20251221015859.738112-9-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 27 Dec 2025 07:24:26 -0700
X-Gm-Features: AQt7F2oz8SMVg53x8DSsEAVS0bhXgFTzGuHvMEOoI6vFlqo9aRo9iEct-PHo26w
Message-ID: <CAFLszTg93oU-4c0hXVX+y3Ja23qx35RfNAuuNnd17Wmo-7vhTg@mail.gmail.com>
Subject: Re: [RFC 8/8] test: clean up test_trace.py code
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Shiji Yang <yangshiji66@outlook.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Yao Zi <me@ziyao.cc>, 
 Raymond Mao <raymondmaoca@gmail.com>, Sean Edmond <seanedmond@microsoft.com>, 
 Heiko Schocher <hs@nabladev.com>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>, 
 Rasmus Villemoes <ravi@prevas.dk>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, u-boot@lists.denx.de
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

On Sat, 20 Dec 2025 at 18:59, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> * Add module doc string
> * Correct sequence of imports
> * Correct long exceeding 100 characters
> * Remove unused variables
> * Remove module level invocation of check_flamegraph
> * Add encoding to open() calls
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  test/py/tests/test_trace.py | 35 +++++++++++++++++------------------
>  1 file changed, 17 insertions(+), 18 deletions(-)

Reviewed-by: Simon Glass <simon.glass@canonical.com>

Thanks for the clean-up.
