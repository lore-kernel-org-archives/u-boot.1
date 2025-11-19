Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6A9CCF34AB
	for <u-boot@archiver.kernel.org>; Wed, 19 Nov 2025 13:16:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5427B83EF2;
	Wed, 19 Nov 2025 14:16:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gU8Vp/v9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7DEDA83EF9; Wed, 19 Nov 2025 14:16:27 +0100 (CET)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9235183EF2
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 14:16:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-b737c6c13e1so768324666b.3
 for <u-boot@lists.denx.de>; Wed, 19 Nov 2025 05:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1763558185; x=1764162985; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lhPTd17sVzU1kh2YmM0P0Hto7T27Es2BZ9PpuX9A2WM=;
 b=gU8Vp/v9I37iAx0NGyUaMJTv5XKlMWkpjdaCyMKKRzNxpmgbkfMCzZ6wQD3zhFIaLd
 5bMUGRhm16q202lxy4xgZCzppMT0RqexfQ04rF/9r5eGmQgn0scV+uOYLlw9JVAIKakb
 okapkVcfPapr2rAouJDVOVbML8YvF1vbiZWYo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763558185; x=1764162985;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lhPTd17sVzU1kh2YmM0P0Hto7T27Es2BZ9PpuX9A2WM=;
 b=T2r/xJyHyXd5BicQHi8wjTBGyTVnq5xZvrkt2Ya0KCyRCr0baoUzP7HP+SKsPNSkgl
 uj5ARjoZ7lDaVw0bbxj3LqV2p42A+rXj2/TLfDY3TmLo/CHAqTQtypRnl2xpxocjAgNE
 0sfwT0/jurE0V9yPiMWdvpML+W7l0uuT9F7K1Kq2535ru/QZvf+XSJZkD/WSvkmhWKWn
 Ox+/lesd4VpD+0COinpoC3NhHY8Lsg0rL8XruAeHpLva+uM+IN/EYvmYuKdLE82NyFiW
 SZJWvoDiihxEy+15XdF/0C6VuukW13Nsx6WMNL+SRGQhMq86g0r3tjhciVz3KfW7Wj1b
 Ukaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2xcqL90EYsPPFey7PBl/fGnY71l/aEgYdK73N6iwIObCh/K0SgUCrHWyH4xjx17vOa4nRYX4=@lists.denx.de
X-Gm-Message-State: AOJu0Yxhy8MxrgR0f2ttfZqcfa70OE5w5lsSWLFfJRl9y9VET/eIYSf2
 upNc34HHNwSNG1i9S+uaFJal8wC3ZIK+xenZBZcsJyVLNzoZQ+NiZYzel0fw3T5zklwxOz6zRvk
 Q+AiM1W9u1v+hdH4RZsQKuVFQ+KeGqBAw6H0AAP6a
X-Gm-Gg: ASbGncu2wuX/OsTB249UF5vr7dNHA7tB9lzRBaRjHOWL3UlvxsMuTcrfg0FYKgASsKL
 lZcBxtYpTgu9SWp1yjgsAcCx1gDUeaLmQbjfdhsU9BjI7lSgBuxvyJw92QXw59Q9CcukBy6azPD
 GEp0A4xF10N1hx2xz9yHjWBCXJiiuffn/yDtSeSvAjd+9NN51AlDEF6d5nYrNowEKu45dHrSvaM
 t73c3Savdu52Sy+4SWRI8ya2R8MhmSfVbrpF+pr4aiHG81JA1PZAYqL10PejuEMMVNMA+XhrkOn
 /BZh9weLwRDIMUE=
X-Google-Smtp-Source: AGHT+IFxHBW7Ca3QZy0r3D8+QGFTqsUi2VXmeQPjDYw8H0LcFU9VrTNj9mPhAP5v2SE4wZSkXAbUv4eKL6zyZrylD/g=
X-Received: by 2002:a17:907:7f10:b0:b73:b0eb:16f5 with SMTP id
 a640c23a62f3a-b73b0eb26e2mr850928766b.31.1763558184841; Wed, 19 Nov 2025
 05:16:24 -0800 (PST)
MIME-Version: 1.0
References: <20251118201733.67297-1-heinrich.schuchardt@canonical.com>
 <20251118201733.67297-3-heinrich.schuchardt@canonical.com>
In-Reply-To: <20251118201733.67297-3-heinrich.schuchardt@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 19 Nov 2025 06:16:09 -0700
X-Gm-Features: AWmQ_blVnkazW3DNRKnKJY7AAld6hFdgu6qCcaGOptGSa9Vp7MJkSL7XOET-YTc
Message-ID: <CAFLszTjR61Qvz4cud8YeosGJ1kyFB6uTQzZYBxDOPXZenxVTaQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] test: document ut.h
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Tom Rini <trini@konsulko.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jerome Forissier <jerome.forissier@linaro.org>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de
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

On Tue, 18 Nov 2025 at 13:17, Heinrich Schuchardt
<heinrich.schuchardt@canonical.com> wrote:
>
> Add missing Sphinx comments in include/test/ut.h
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> ---
>  include/test/ut.h | 159 ++++++++++++++++++++++++++++++++++++++--------
>  1 file changed, 132 insertions(+), 27 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
