Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7521D2E9E4
	for <u-boot@archiver.kernel.org>; Mon, 11 Nov 2024 13:03:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17D3288FCE;
	Mon, 11 Nov 2024 14:03:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="K81O5qDW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 30A3289339; Mon, 11 Nov 2024 14:03:38 +0100 (CET)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15ED989300
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 14:03:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a9e8522445dso806620966b.1
 for <u-boot@lists.denx.de>; Mon, 11 Nov 2024 05:03:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1731330215; x=1731935015; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NzFvZ5hhhTuIczt84vn19unX4oQ4JlFlaDTyu7Flv2I=;
 b=K81O5qDWcCjW2k5KdZqRRhn6NydI+udGsmSm0w6PvxL8nhvvt6PuvOCqLUAU9XNoQV
 Hb6zZFhmQCZ0vgy8DJGV7rMWu6Y2qziJT0g/Jk/0E4MT28qP0knuUguol1SkATEAWuJc
 /TRHfMM2uWn1yAahJtBgdrNs9qHDO8tPY3iko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731330215; x=1731935015;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NzFvZ5hhhTuIczt84vn19unX4oQ4JlFlaDTyu7Flv2I=;
 b=MwOTNvUTcMZPX9cM2TtrEoucBV3La0sgVAZgwpvoOEPwxlWyjr9I6HfnQV//CeWGML
 AXJhv2pwUilVVtISTTXGIobkUQZpDGUuTXSVPDrck+0RAkICCSdAA1j9+SrRWKmdcKk/
 3U917ch/OOH2PJHPflZorMiU9OZ6acfJru5YNTD1z8qW1fNnE9ChnWYhm9I25a/vrZLe
 UeKWCqhDgWipYx1o2xUn+vmZebXjTr5sDdDqoKwfpBZopm3O3FL1wdVhrqR+CIGgusBg
 cyPjGiTe+UDID+Meg6gKiyzYS1kGszEpbEbUa1QvzsXsfxi6OMmmXEGhqpOhZN7zpTtZ
 kipQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXnAbrvoE24nWO0OKUKEWWiiktfv4cu7bKc+tV3fYhT9xno/62kzXp9z2B5gn2LRj/svD5P2Xc=@lists.denx.de
X-Gm-Message-State: AOJu0YwDn2ZqhhUc9OczLHttQPSO4/dvZ2k6sQ9UDqdP2FxDI9ANQvis
 r2xG/byw0aoek/XIqJVpjnErDhkAOTv1VIcCp07cw/K3GDND3MJZoZGcktzftZj3/pB0BPwGKy7
 nfaEUmh1vcGYcP8YeWvCekb9wdOe09psfMJln
X-Google-Smtp-Source: AGHT+IHSIH0fUayXoOFiB9UI7mcQ02FSoLqmAMKilnZZCqdaGLFcnDwgJKvAse+twCutNffGy69R9BNo7iQMU5UbrwA=
X-Received: by 2002:a17:907:3f8a:b0:a99:4136:5b07 with SMTP id
 a640c23a62f3a-a9ef001c671mr1054343966b.60.1731330215393; Mon, 11 Nov 2024
 05:03:35 -0800 (PST)
MIME-Version: 1.0
References: <20241111-io_lmb_apple_dart_iommu-v3-0-32c05da51d72@jannau.net>
 <20241111-io_lmb_apple_dart_iommu-v3-3-32c05da51d72@jannau.net>
In-Reply-To: <20241111-io_lmb_apple_dart_iommu-v3-3-32c05da51d72@jannau.net>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 11 Nov 2024 06:03:23 -0700
Message-ID: <CAFLszThZ=RJcpSc++tTjYANd5v8sAbiq=PK-6=LmTVmWONL_=g@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] lmb: Add basic io_lmb functionality
To: j@jannau.net
Cc: Tom Rini <trini@konsulko.com>, Mark Kettenis <kettenis@openbsd.org>, 
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

Hi,

On Sun, 10 Nov 2024 at 23:56, Janne Grunau via B4 Relay
<devnull+j.jannau.net@kernel.org> wrote:
>
> From: Janne Grunau <j@jannau.net>
>
> These functions can be used with struct lmb pointers and will be used to
> manage IOVA space in the apple_dart iommu driver. This restores part of
> the pointer base struct lmb API from before commit ed17a33fed29 ("lmb:
> make LMB memory map persistent and global").
> io_lmb_add() and io_lmb_free() can trivially reuse exisiting lmb
> functions. io_lmb_setup() is separate for unique error log messages.
> io_lmb_alloc() is a simplified copy of _lmb_alloc_base() since the
> later has unused features and internal use of the global LMB memory map.
>
> Signed-off-by: Janne Grunau <j@jannau.net>
> ---
>  include/lmb.h | 51 +++++++++++++++++++++++++++++++++++++
>  lib/lmb.c     | 80 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 131 insertions(+)

This lmb wrong-direction is really getting out of control, IMO. I hope
we can resolve this before too long.

Regards,
Simon
