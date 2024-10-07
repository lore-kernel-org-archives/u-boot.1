Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30F97CFB448
	for <u-boot@archiver.kernel.org>; Mon,  7 Oct 2024 15:25:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68F4E88B3F;
	Mon,  7 Oct 2024 17:24:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mLkBo8Ng";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E793288DCD; Mon,  7 Oct 2024 17:24:25 +0200 (CEST)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC16688DE5
 for <u-boot@lists.denx.de>; Mon,  7 Oct 2024 17:24:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-6cb2824ddc2so36814126d6.1
 for <u-boot@lists.denx.de>; Mon, 07 Oct 2024 08:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728314660; x=1728919460; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=J3OJAtLtzmZ5rGDY3PnOo1eygelxfOnEod7KIbR9qQI=;
 b=mLkBo8NgnDzTURISSZ7JtjTjTkS9OItgRSv+bv7NGGkD5h2vqE6owSrYiaXCIpJZgV
 +V8tfcF7rTQDAxHjHg6ylun8AMpp+ftf5aoBUxd+ZoA6odfsXVJLzZKin68SzWlzwtlW
 GbdEO/MFU8gfjK2nPwsrj/rKvQfyCbFTEZhF4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728314660; x=1728919460;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=J3OJAtLtzmZ5rGDY3PnOo1eygelxfOnEod7KIbR9qQI=;
 b=D4ErrRRi2weSgBX/L2bQkMm+PSzKaZxQyhapEOZ0pyQD/hx6k5KRaowGImta1T6AwS
 VY+WG3qfNiErQGzywamMS7ody6a4JYmMKACopBP62luY2C+Ojmy+U6Pv1zUmbMH6+Yf3
 AbqNjj8Yro6AWS9uxN0pUUvE2lds/8vbLwK+BoBXz9ZolbPlGCHPLlUJ3YQF7Umpq5bj
 GYjofSe5X10CQlzv0qEa0zBPyhb2cxhSM1OgV0hvin3U1k+uuUxc5eROcFR6ZYHmneq5
 o+2sLNwHOIGRQch9c4FecMEli9uTzUiRxQjOs5BLIYQELnppNX60k2u5BTkDDBdr5OTr
 wWZA==
X-Gm-Message-State: AOJu0YzjAgxw5qQr8iwCMESEiCsDDEvTGYot8kwramWn2ukmLzPIP1a+
 nE5RT8h5HwRvDzKO9KIWoQFQe95WfAcb1Un4KPl2+5edWQ0WZ1vCRN+banlqmAc3FCkj6QIqf8c
 nXwIuVXVITo5+wCjdaV0o4YPIDyZPCe6pJ3Vh
X-Google-Smtp-Source: AGHT+IFfLvdcjqAW02MLleunyTHZHz6+OAfwS3RO5h5FamSwmdo+j9dbjinSFTXnk4AFioP7Y8cwYsyvfe9cYzGk/o4=
X-Received: by 2002:a05:6214:488d:b0:6cb:7104:f115 with SMTP id
 6a1803df08f44-6cb9a1f83fbmr186120376d6.11.1728314660608; Mon, 07 Oct 2024
 08:24:20 -0700 (PDT)
MIME-Version: 1.0
References: <20241004230756.371153-1-marex@denx.de>
 <20241004230756.371153-2-marex@denx.de>
In-Reply-To: <20241004230756.371153-2-marex@denx.de>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 7 Oct 2024 09:24:10 -0600
Message-ID: <CAFLszTjiuQZc2S+uEppNLCboGVFPc=n-kRZH-Vxw85AUfawsgQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] Makefile: Drop SPL_FIT_GENERATOR support
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, AKASHI Takahiro <akashi.tkhro@gmail.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Peter Robinson <pbrobinson@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Sean Anderson <seanga2@gmail.com>, Sumit Garg <sumit.garg@linaro.org>,
 Tom Rini <trini@konsulko.com>, 
 u-boot@dh-electronics.com, uboot-stm32@st-md-mailman.stormreply.com
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

On Fri, 4 Oct 2024 at 17:08, Marek Vasut <marex@denx.de> wrote:
>
> The SPL_FIT_GENERATOR is long superseded by binman, drop SPL_FIT_GENERATOR
> support as there are no more users.
>
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: AKASHI Takahiro <akashi.tkhro@gmail.com>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> Cc: Patrice Chotard <patrice.chotard@foss.st.com>
> Cc: Patrick Delaunay <patrick.delaunay@foss.st.com>
> Cc: Peter Robinson <pbrobinson@gmail.com>
> Cc: Quentin Schulz <quentin.schulz@cherry.de>
> Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> Cc: Sean Anderson <seanga2@gmail.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Sumit Garg <sumit.garg@linaro.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@dh-electronics.com
> Cc: u-boot@lists.denx.de
> Cc: uboot-stm32@st-md-mailman.stormreply.com
> ---
> NOTE: Depends on https://lore.kernel.org/u-boot/20241004225916.361000-1-marex@denx.de/
> ---
>  Makefile                | 18 ------------------
>  boot/Kconfig            | 15 ---------------
>  doc/usage/fit/howto.rst |  4 ----
>  3 files changed, 37 deletions(-)

Double yay. I didn't know that the last user was gone.

Reviewed-by: Simon Glass <sjg@chromium.org>
