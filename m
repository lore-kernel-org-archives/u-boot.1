Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 721A1E77180
	for <u-boot@archiver.kernel.org>; Mon,  9 Dec 2024 15:01:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDCA289768;
	Mon,  9 Dec 2024 16:00:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hWZbKQPW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E2EC0892A4; Mon,  9 Dec 2024 16:00:54 +0100 (CET)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F0FBE8976A
 for <u-boot@lists.denx.de>; Mon,  9 Dec 2024 16:00:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-aa543c4db92so48332066b.0
 for <u-boot@lists.denx.de>; Mon, 09 Dec 2024 07:00:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733756452; x=1734361252; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=iFeKZyiHqsqQwndarBAw7Qwif0QmVrvgPH/u1VUdnoQ=;
 b=hWZbKQPWsQNh3pr2swpDg88ot9inurisajhvNf0PHT2rH/N+rT9bDC2jMInN50mkZX
 jDONSL6TM8nNxSXrcE6QXFJ3mu9QNbv81TlNRurQG02VT/OfPeOmMB0UAPBESmecEUMn
 EjwQZEqC5XW/3Gdn0N6uL/PiJcLMaNNrnritQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733756452; x=1734361252;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iFeKZyiHqsqQwndarBAw7Qwif0QmVrvgPH/u1VUdnoQ=;
 b=Jq/blhvh41j1SPZxnCFQ3CRYyHwZqyDxBrreT3oiY5ZlwOO6kwjbC5rTyht75VbvKe
 umRJubSFGGtI7AKal2i1kVViL8wikTjCFIVJaIB7jCXyCa+wnuzIxmkEcJJAI1tor2NH
 YGIsV04IfP5gHs+2Bj4hW7Tv3E/r4N0EWYah+uLYQGnPVUPlY6mrNoajjnD+m1O61AfJ
 Odx4D8MF+ju+uUbiuPP3GiOHHA2HIQ0s+ONkeU3S9PdE6F7/f9kqtyxM1AKxLcJ9l785
 KKrWwlDzbaJ6udJxeSev6M6TUu9uRjBKa6qus/4t3qpHnPFbKmpi8P7sLLyf6ZVx/ySc
 pdxw==
X-Gm-Message-State: AOJu0YwW9xyUhsGiS7PXg4tA3Yoye+VQV6nPHXI3Pogjnsgd2uxwzohn
 pl30kcvIkkluIZ8D//+xfaNUU6pzcPKxjrEfzgv7/irjN1yOHLPW/pQhTAig8l05vf9469xN/B2
 J6b7LFyQ7LPi40KjcOe+xqk6zTnY1JMOv4CaDAsiyg23Iuvo=
X-Gm-Gg: ASbGnctQ8ICGQPWFV1pV3vZkoNcFY+QAUT+M64MLE/wE0j+wOVu3S9fN98K557nmrIS
 3kQyoLO9+CYmquvOzEAwmUu/FJAiX+38m
X-Google-Smtp-Source: AGHT+IFxhQqrZdQt4AgcHBit5xUDRCf/eUNa8oClKuG/rWwF10gSo0S7+ZqVWqfsGK8GpbLy8fugq/d1ZW40raEyt+A=
X-Received: by 2002:a17:907:770b:b0:aa6:6ee6:1b81 with SMTP id
 a640c23a62f3a-aa69cd35c3amr80695466b.18.1733756451808; Mon, 09 Dec 2024
 07:00:51 -0800 (PST)
MIME-Version: 1.0
References: <20241208190741.4192601-1-trini@konsulko.com>
 <20241208190741.4192601-8-trini@konsulko.com>
In-Reply-To: <20241208190741.4192601-8-trini@konsulko.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 9 Dec 2024 08:00:38 -0700
Message-ID: <CAFLszTiZsV9b_tzre9rPA6j+GUBYZe3XTrHymrVxL=DUjPJLKg@mail.gmail.com>
Subject: Re: [PATCH 7/9] docker: Prefer the kernelorg toolchains over "root"
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
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

On Sun, 8 Dec 2024 at 12:08, Tom Rini <trini@konsulko.com> wrote:
>
> We should always look in our downloaded toolchains first and then for
> host-provided toolchains.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
>  tools/docker/Dockerfile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
