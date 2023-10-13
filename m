Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45673CDB47E
	for <u-boot@archiver.kernel.org>; Fri, 13 Oct 2023 15:16:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE6FB86D62;
	Fri, 13 Oct 2023 17:16:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="TrHxt/9u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F14C586EE0; Fri, 13 Oct 2023 17:15:26 +0200 (CEST)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C65B986EDB
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 17:15:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-9b9faf05f51so345408566b.2
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 08:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697210113; x=1697814913; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/2fvHORxI2jW4iN7X+Mz9DTct8wfcRsNL966iY5VoX0=;
 b=TrHxt/9ugqtizGeL79jHqRt9QTtI9z0uNHKUmv0D/cE8Ma7UV3bhBvCGWkt8WYzAWD
 dPLfaacuGhtxzfFsHOwhA+Vb6VdrpI37hu8giO978qY7shVAWMrfVIa3zAnEOiNfAXFE
 JfjAO7EU07M1zkgUMHAFeK08RJs+1xNnXoK/o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697210113; x=1697814913;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/2fvHORxI2jW4iN7X+Mz9DTct8wfcRsNL966iY5VoX0=;
 b=duuuYVuDJRsLQnk+pokh1zovMOjaKb90pRESrNDLm3xnl3URTeKKmVOjXNlQ4R/8vu
 K1/OhL9ntfN/bvDZo/m/tl5nq6Vbxe1b/rcGRRm9cx2iWR2xsRkUyLLNZyXRlg5pGtbg
 HjjrmqpLsQjAS7cCVOK6aE6LF/8D6/ZteDqY8NCZnLZx4miLa829z4VOdgUqKggIVwA0
 y8NzTeSIkYtMlVfAu021q83PPdkOai3wRavTut2RSrWeyrvTxLorVP87R6iGf0TgMHET
 iibT/cIlLOyP9F9/YexgivnSPB4+ivRrBfZsdCY6MvsrD/EIoZAapL5RppleVcQLuw3N
 WJZg==
X-Gm-Message-State: AOJu0Yx1+tByaXiZqKyrYYfRGukiRGN25gpNBuSA0ObEwMUarOI/9x96
 V6rt+15wwzTg1fnPCc6vD8Pcyf4o0otAgtEOOOJmaw==
X-Google-Smtp-Source: AGHT+IEj8pgYU9iHvxqRXtkKJQomUwbyU8W4p4Stf6lhzbmCGarl7uTVRlrMjYCyo2fnPgD7m478AtLdaZ2osGUyh48=
X-Received: by 2002:a17:907:2cd4:b0:9ba:3f18:8ae5 with SMTP id
 hg20-20020a1709072cd400b009ba3f188ae5mr8532245ejc.60.1697210113103; Fri, 13
 Oct 2023 08:15:13 -0700 (PDT)
MIME-Version: 1.0
References: <20231012230359.2005249-1-trini@konsulko.com>
 <20231012230359.2005249-2-trini@konsulko.com>
In-Reply-To: <20231012230359.2005249-2-trini@konsulko.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 13 Oct 2023 08:14:59 -0700
Message-ID: <CAPnjgZ21qUp46c5mUBQNN6pXL2fKepFRjORhKZrz=N9MTGh3_w@mail.gmail.com>
Subject: Re: [PATCH 2/7] include: Add <linux/types.h> in a few places
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

On Thu, 12 Oct 2023 at 16:04, Tom Rini <trini@konsulko.com> wrote:
>
> These files references a number of types that are defined in
> <linux/types.h> (and so forth), so include it here rather than rely on
> indirect inclusion.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Simon Glass <sjg@chromium.org>
> ---
>  include/bootstage.h | 1 +
>  include/cache.h     | 2 ++
>  include/cpu.h       | 2 ++
>  3 files changed, 5 insertions(+)
>

Reviewed-by: Simon Glass <sjg@chromium.org>
