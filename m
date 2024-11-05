Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B9DAD2C122
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 15:15:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2087891AF;
	Tue,  5 Nov 2024 16:15:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="U0SZJspc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B9A7F891B0; Tue,  5 Nov 2024 16:15:25 +0100 (CET)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4C2B891AC
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 16:15:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5ced377447bso3381505a12.1
 for <u-boot@lists.denx.de>; Tue, 05 Nov 2024 07:15:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730819723; x=1731424523; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=q473R5jaMrqdRWxfbFHZIGP//+7iD+VGBHeca0Oyhnw=;
 b=U0SZJspcTBZx3hVy1ChZYRlNBDUNz91c4AAeZ763dO0sDETy+8duQzcGDy+xqPcCp0
 +asGwsoFwm/Ie2oT3I8pYF0bUvBggpOTM3kpDIY9MF9TH3MaO4P20aKivFJXSEfkNTFT
 6vG2OSk+5lKIWRttdx7MqNu8hZw+WEWQ04vLE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730819723; x=1731424523;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=q473R5jaMrqdRWxfbFHZIGP//+7iD+VGBHeca0Oyhnw=;
 b=vtOtN9x5zhnzDnUKCE3b99XSMLtrlV4YNTWSxjFfut6/kHJToRIkWIzSOrZbYttBjf
 aHS8xG/hgdjHKZYwQTCw9hJD084eNdqkTi5xpmjU1Hn+dAM6BqsuLVUYAPpFykYVuQzk
 SYJ8PLgjwcYhyKYONKz8INCkN8tEtpKw2yAP6Mjh1nl7xj3Fi2sAQQqh+fPCufFML66N
 iO+QZSdLzP/CAkRxXDVz/YRPL+vm0ccxpo+NQEXU5y24a2nPxMyTMth1dLrY06s7AOE8
 QmAebrDTr5220ErBiJ6pLX1TeLrVChWKyj2G4tzYeOUVZvfxItuYAySrxrxo4k7zhYfX
 ysRg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWoedn3L2J85E++wModnD2eBKotGB0OV9cHhuNBJSkQ1R9szBAzPumrosUwgwHIlFZ2eAf+PRQ=@lists.denx.de
X-Gm-Message-State: AOJu0YxqsC9BwZ3qrSWtfC4NlJHTmpLNFjumVsJqDX7aA892LC/EPdTG
 iZ2ge4obtYhcdahLYERPIh7j0LVqCyHgyJeIS02msar9dzUhZFu5/8khjJcHmrM+jRDkOexGW2/
 FD7xzuY20gGS+BVQ7CasYRLBtdyk+y/O0JTjE
X-Google-Smtp-Source: AGHT+IG6WblxelFOOMysI1xPlswNPvfiGea/veAMXHoAaxqhREVpPE76Z+hLdqPLsCcsgPhK7nR2l0/OuHSKM3uefhw=
X-Received: by 2002:a17:907:d851:b0:a9e:b08e:3de1 with SMTP id
 a640c23a62f3a-a9eb08e4023mr315104966b.36.1730819723187; Tue, 05 Nov 2024
 07:15:23 -0800 (PST)
MIME-Version: 1.0
References: <20241104133954.840994-1-sjg@chromium.org>
 <20241104133954.840994-7-sjg@chromium.org>
 <39dd14ea-6c35-48c1-85b8-80d7c23de8a7@gmx.de>
In-Reply-To: <39dd14ea-6c35-48c1-85b8-80d7c23de8a7@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 5 Nov 2024 08:15:09 -0700
Message-ID: <CAFLszTg1PGfo01GuukpMtrapjaVKRu-ozNRs92F4NwBW97DJtw@mail.gmail.com>
Subject: Re: [PATCH 6/9] docker: Drop tracing for arm64
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi,

On Mon, 4 Nov 2024 at 14:22, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 11/4/24 14:39, Simon Glass wrote:
> > This doesn't build on arm64 at present, so drop it for now. This can be
> > revisited if we wish to support arm64 for the sandbox trace-test.
>
> I had no problems building the trace libraries on Ubuntu 24.04 arm64.
> So the problem you experienced should be easily fixable.

49.20 /usr/bin/ld: /usr/local/lib64/libtracefs.so: undefined reference
to `trace_seq_vprintf'

I agree we probably want to support this, but I think we can sort it out later.

Regards,
Simon
