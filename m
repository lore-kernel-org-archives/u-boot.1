Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F678CF042D
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 01:52:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 12CCF89025;
	Wed,  9 Oct 2024 03:51:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IFrEKYhs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A0B328901A; Wed,  9 Oct 2024 03:51:16 +0200 (CEST)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com
 [IPv6:2607:f8b0:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7A0C988FD2
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 03:51:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-71e0cd1f3b6so1777545b3a.0
 for <u-boot@lists.denx.de>; Tue, 08 Oct 2024 18:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728438672; x=1729043472; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/ZDqexTukzdlUdGz/46JOKeAkkrL+Sjz7f893W+Cm5c=;
 b=IFrEKYhsLiHuILNyGM38C0ymRBPlyFY4XkXK4Xmm/Te1jYUzs1sVFwv6+dhOMOWF2z
 tHwdSknJUjandO6Vv0dyn1Luip5v0kunXRMJYvZMS6dotoQP1+6yF3p+pqzC8yZSlz/w
 ZUw25KKeIY4ZcHch5Yuv+UqypNmjZuPP/OFpE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728438672; x=1729043472;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/ZDqexTukzdlUdGz/46JOKeAkkrL+Sjz7f893W+Cm5c=;
 b=uG2UlxmsLpOEQzEbENO4/66I5+hEVBinggyOWamSR1wIsSakEf7Uf4K4WZMvnvL0re
 Us6yBwEKshKerT/ONZxmdWwUfKvL9E4GiF1Xm7rGnYtQuuUJ+JkrsLwTbZ4Xqd1GHCFp
 PGYUTOPXODMDf2lsV/aCqeCJEV2BJAWNG8xKGQpjpOoZygjHIBM82T7D0YMl4lV9VaA5
 2Y77tMoapECOO5ARS3zXNCGdhMLk3MC2O2QlJaV5n9aV8IMDC88Oj28gUSavsLEDdsQ3
 9X7xpzfOb2p2wWGrcJpAUZC+A2NndRM+DN/oWsYEN7IRTAeXdhj4xROejiruSr4FroxW
 pKlQ==
X-Gm-Message-State: AOJu0Yy7t0/OPCbzIpAELrX/m1oQnZiYEkZGZGwcbYQAmim3T1bttBYC
 vg2vLkkq8KG2gPv2ar3rKemgdDo0Cw9eZcyTB3cN6JSVvRgLDENNspCYjtdCFRuqzwyuAH/LCuQ
 WpncGRdPet5wVcI+gFylENMXIM5AoWDyOK8MP
X-Google-Smtp-Source: AGHT+IEgbKW6yMbk0Ise91N3gkAfRP7ZYAyk2rGkQS/fzSODryzyOcF+sdPugnaLKwEnm8eA3Tg1qDXx5lLDhXa9lf8=
X-Received: by 2002:a05:6a00:114a:b0:71e:1722:d037 with SMTP id
 d2e1a72fcca58-71e1dbb561fmr1426711b3a.22.1728438671851; Tue, 08 Oct 2024
 18:51:11 -0700 (PDT)
MIME-Version: 1.0
References: <20240916082446.32082-1-al.kochet@gmail.com>
 <20240916082446.32082-2-al.kochet@gmail.com>
In-Reply-To: <20240916082446.32082-2-al.kochet@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 8 Oct 2024 19:50:57 -0600
Message-ID: <CAFLszTjFVU=M42bj93PiNt1iOd29gUNn4YeV=zGmgLt-3qPOmA@mail.gmail.com>
Subject: Re: [PATCH 1/3] binman: fix passing loadables to mkimage on first run
To: al.kochet@gmail.com
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

On Mon, 16 Sept 2024 at 02:25, <al.kochet@gmail.com> wrote:
>
> From: Alexander Kochetkov <al.kochet@gmail.com>
>
> FIT use mkimage from BuildSectionData() to build FIT entry contents.
> BuildSectionData() get called several times during building FIT image.
>
> Currently when fit inserts loadables, it use self._loadables property that
> contain loadables computed during previuos BuildSectionData() invocation.
> So for the first run it use empty list and pass no loadables to mkimage.
>
> That makes problem for adding signature to FIT image because mkimage
> fails to add signature and aborts building FIT if no loadables provided.
>
> The patch fixes described behaviour in a way that BuildSectionData() uses
> recently calculated loadables value, not previosly calculated.
>
> Signed-off-by: Alexander Kochetkov <al.kochet@gmail.com>
> ---
>  tools/binman/etype/fit.py | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>


>
> diff --git a/tools/binman/etype/fit.py b/tools/binman/etype/fit.py
> index 2c14b15b03..e96222f4b6 100644
> --- a/tools/binman/etype/fit.py
> +++ b/tools/binman/etype/fit.py
> @@ -542,8 +542,8 @@ class Entry_fit(Entry_section):
>              """
>              val = fdt_util.GetStringList(node, 'fit,firmware')
>              if val is None:
> -                return None, self._loadables
> -            valid_entries = list(self._loadables)
> +                return None, loadables
> +            valid_entries = list(loadables)
>              for name, entry in self.GetEntries().items():
>                  missing = []
>                  entry.CheckMissing(missing)
> @@ -558,7 +558,7 @@ class Entry_fit(Entry_section):
>                          firmware = name
>                      elif name not in result:
>                          result.append(name)
> -            for name in self._loadables:
> +            for name in loadables:
>                  if name != firmware and name not in result:
>                      result.append(name)
>              return firmware, result
> --
> 2.17.1
>
