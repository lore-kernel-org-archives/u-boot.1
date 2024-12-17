Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E11DE77184
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 19:49:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1094180316;
	Tue, 17 Dec 2024 20:47:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="D8qpKGnj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43107802C2; Tue, 17 Dec 2024 20:47:50 +0100 (CET)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 532BF80374
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 20:47:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2ef748105deso4110239a91.1
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 11:47:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734464866; x=1735069666; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=AcI+S+V0v2e6kcMe/CCipxgQgvD1NNhfVAvCiQoL9mg=;
 b=D8qpKGnjp7F3AOWA89v11JX4WP5PM2EKaxiFUb92FaVbbLu6ijL0ny6nHda6e/9quf
 SaAGEIi0G8NSX+oLOLGVQB1nUqRxR/q2DuAR8KNUuDYOSGGo6AduAYwRt26aRKG/sE1K
 5YDXqnCSmTVPhGQ0QQNZZC2onl2JtFfAW3PKY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734464866; x=1735069666;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AcI+S+V0v2e6kcMe/CCipxgQgvD1NNhfVAvCiQoL9mg=;
 b=uVD3ADrftbBoO+i+XXCimRE4EFhpkgfuM1wsGQkPhQmC1OERStyO3YUGNjY6ZIQFq8
 KhyILWnypBir8k5o4ElQxXUBsPkegSLwas91+SiCQDYGKO8qTUjj84CPgVsq7k0IWY8u
 G7ExJuUKZQfJRp8ONlITNpay6ADarPr55xCZksFNYhEs/RuXg/B5B4CiLgTRuftcmRKZ
 54/S+8Mvu5jCYGw1QnKxHXU6eZKj2SPXgvOXhDGnPffJSHdwW+jqPQPd3O9saBU3Jxlh
 ZTim6Q4L9U+vzIbd2uedx/cCdfrGzOuIaErfhvA/Q/ODylfhl+DTGQfs/13Q+VBZuJKV
 XvFg==
X-Gm-Message-State: AOJu0YwnpEJwGH+VUK4V6Q2/8zSWBMpNy9QayaqOHI8aeWhbQs4t8qpf
 b5mCrEJXNP5kWy9HT18mJYtua10tH9wnEg5gwfTNF5UM/hr8Rc1egnAMhvherk7J9kGBVuvsHtG
 MBKEMsdBmpwXo6acWqR61xkVr5NEnUl4qwrmu
X-Gm-Gg: ASbGncsYBQHRp4Ng9tKDBBmk6SJzM/HYtvbblHNZCloDZ0I6VUNucwNyuSNYF5ZPBsR
 moVqXzBH+egALCB3j8SPgF/1awuHz7EehON0lxZ4=
X-Google-Smtp-Source: AGHT+IFWUrwR4YSUqIiTrPRpazmcJzRltKe/aXOaqhsAYkkxjDnVNEtWvomXJ/7JsdLJMbZ+JVJY/zWfbymy0jGgQOw=
X-Received: by 2002:a17:90b:1f91:b0:2f2:a664:df19 with SMTP id
 98e67ed59e1d1-2f2e91c4c6cmr207647a91.7.1734464865820; Tue, 17 Dec 2024
 11:47:45 -0800 (PST)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 17 Dec 2024 11:47:38 -0800
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <CAC_iWj+JjfM5hhFHaukxuiAaM18qP1_1eVmogBTCDCgZkerWJQ@mail.gmail.com>
References: <CAC_iWj+JjfM5hhFHaukxuiAaM18qP1_1eVmogBTCDCgZkerWJQ@mail.gmail.com>
 <20241211135418.563803-1-sjg@chromium.org>
 <20241211135418.563803-11-sjg@chromium.org>
Date: Tue, 17 Dec 2024 11:47:37 -0800
X-Google-Sender-Auth: z9zV6BV95ncAInjd9gZSXasYWG0
Message-ID: <CAFLszThkxZ64H=F243nhsQ_MxraDzZNH7p4-x+=oYxVtQ-rHgw@mail.gmail.com>
Subject: Re: [PATCH v5 10/23] efi_loader: Drop reserved from priv_mem_desc
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>
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

Hi Simon,

On Wed, 11 Dec 2024 at 15:54, Simon Glass <sjg@chromium.org> wrote:
>
> This field is not used. Drop it and set the value to 0 when the
> memory-map is requested.

Looking at the spec the reserved field is wrong. Instead you should
just remove it from struct efi_mem_desc

Thanks
/Ilias
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> (no changes since v1)
>
>  lib/efi_loader/efi_memory.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
Applied to sjg/master, thanks!
