Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 946EEE77188
	for <u-boot@archiver.kernel.org>; Fri,  3 Jan 2025 01:41:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 31A4F803CA;
	Fri,  3 Jan 2025 02:41:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JdEBsVU5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24AB680196; Fri,  3 Jan 2025 02:41:23 +0100 (CET)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E487803B7
 for <u-boot@lists.denx.de>; Fri,  3 Jan 2025 02:41:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5d3e8f64d5dso20934218a12.3
 for <u-boot@lists.denx.de>; Thu, 02 Jan 2025 17:41:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1735868480; x=1736473280; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EKL2u2HDWtxmeVFtOVgcBmQcrIbRzPZ8HTAyDG2TUmg=;
 b=JdEBsVU5uq07C+kjgX+zzr2k3I6+mvGUH3oZmT1waivROyob8pV+JncJZD/ArouTXW
 lhLFGs5YNQnl0xh+4eYviIbkQ2h6SQ7wjPXwlJl4uVEuNgqWtIA3WJNcSUmHh6vX/R59
 BsvPk10AiM/rxitzXyRxtAip3E57xUC2BjDGU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735868480; x=1736473280;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EKL2u2HDWtxmeVFtOVgcBmQcrIbRzPZ8HTAyDG2TUmg=;
 b=fClUFUn5CpUDYNz4Q2s1Upf6reJUB8m9pi6Xff9LwZ4VwcqQK3KKGN7N1arCuAujaw
 TmwsAszy8RV9U1XDs8qLDJ9ioTU49iVW499hn7gvVeLUdpkRbXxqNdPc7q4pMOu68my2
 72o6e3EqfPfEUq+SX6jMMzZS8MTqAmfJiJ35K0cYG45XtlV7Ow4LRNA4yt0HEI72hLGP
 rIPpFrGIdQ2/tbn0zdRWU1Xzeyr+bfRbIIrXg8HQjaJBJY4hz7VBn7xVhI+u1YHP8UXx
 bGaerR8VicRvtiBMDeXkzx5SrmahtdI07a9/qgxkc5CBBxXYT/GKuXOkdF4UPqJ1zw3W
 ayXA==
X-Gm-Message-State: AOJu0YyezlKv9oj10CbirhfIleLAQEawO16lk9SKfI4x0i8buzFDXF5X
 6hdRJT03nhuuEk+LOyJ6KQCThwhqWDOlAaTXaJyDnsV25xZJGIHIp1xEQf/WAF1rcAaAdK7bHTH
 TOgTNK5D52Vk6YfEXANMnei7t+U0gNXF39SCkn9/BpdIGxck=
X-Gm-Gg: ASbGnctZao51UOCkQoOghfcrPN+pbKuhG51NDoBMFoElWzCr0zeDLMocdmtw/imB2yr
 qrw4znH95ZDrE1d8zRhgQ7HiHGYpQZQFv8o/IzZ3O
X-Google-Smtp-Source: AGHT+IFaTb9zKpQD2thMq6ttI+jbI+tOqJ+Wdh2Y3PLnt74fA0e5IlQoXR3r0wbEqjKS6bkU82jEFoJpxdktkJTgSck=
X-Received: by 2002:a17:907:944c:b0:aac:61b:580a with SMTP id
 a640c23a62f3a-aac3443bfd6mr4713428866b.61.1735868480592; Thu, 02 Jan 2025
 17:41:20 -0800 (PST)
MIME-Version: 1.0
References: <20241231235412.1605761-1-trini@konsulko.com>
In-Reply-To: <20241231235412.1605761-1-trini@konsulko.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 3 Jan 2025 14:41:08 +1300
Message-ID: <CAFLszTh+XMgpjQ8OGY8LCzPZkPE2SWEkW+HfT+mWGh2KntGE0g@mail.gmail.com>
Subject: Re: [PATCH] qconfig.py: Update resync message
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

On Wed, 1 Jan 2025 at 12:54, Tom Rini <trini@konsulko.com> wrote:
>
> When using qconfig.py to resync defconfig files and commit the result,
> update it to say:
> Resync all defconfig files using qconfig.py
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
>  tools/qconfig.py | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
