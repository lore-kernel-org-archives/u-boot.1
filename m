Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A46A7CF042D
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 01:53:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C5118903C;
	Wed,  9 Oct 2024 03:51:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Y5nXyvZo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0391189063; Wed,  9 Oct 2024 03:51:39 +0200 (CEST)
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com
 [IPv6:2607:f8b0:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D2ABA8903B
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 03:51:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-7e9ad969a4fso3942265a12.3
 for <u-boot@lists.denx.de>; Tue, 08 Oct 2024 18:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728438695; x=1729043495; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bqLBCifbMznPq1/MScGG98NOlqP3ZVMj00IY9NauynY=;
 b=Y5nXyvZo4WTHK53bxk7SXaoLC74I9MXWYD6k9Zy2jccZy04yKlGbrOyLzkcL3oxRvw
 VgGdt2BYAPUTK0vbNfEqOBYGyju6j7tM64SfCkSITeyIDpWbK7aRLo2s7KgofcdXoKyL
 1yit1xuF1XIKXf4QTj/9fMPFUjbR1J+UvbQVo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728438695; x=1729043495;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bqLBCifbMznPq1/MScGG98NOlqP3ZVMj00IY9NauynY=;
 b=pUnMvr1vRRQLtHGQZmec+cfiYl62GwoG/2FeUt8umLlFx8C+nJzdMq2J9w0E9N68p8
 hsXSzhf8uRq2LETSUyPdtLUI26LBPA5tUFfyUgGezHSZHiIivgfrhZi0uFnkJIQZ36GR
 6g2WDqNwjEeDwVvDiBV9Td95n8WJ00B+fPSpirRRB/x+7Uvg9IXbkw/zP+XRY7yqUgSB
 wY9Wd44h+C2Ei2dAt+TFC01UN8AzM12PP9Q/VuokMTjVpQkcMsXZb80a5Kq4YNn14jHa
 xNf7tqL/mo0WtKA6l68NhIzjFrbBAUt0t4yvrNVUdDIEBD3cLVicQ4Uw2R83hfOlir5h
 +mMA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWCmX770dd6lQYW0uqAkk7SNqWjIc4u9wCmGx2YyxuT6Gb9eZ4lDeWcL8evTk7peYpjUcoqx5E=@lists.denx.de
X-Gm-Message-State: AOJu0YzvjqHhCDc3kfdAHbUCQWHr8qtY6z7Sod+MQZWs/72dEhEihJQ/
 O34xECshkZq/HHPCbH3N3nliuQ9ZIOTLlhHsOKQoROvFpCadt6S+4Qll2phmM8VBYjbhddv1Yy3
 Y3ycECGXlOFMjqIrGX+21TvPHbXZ7ecqYNt3/8r0GQYIBGlcGwg==
X-Google-Smtp-Source: AGHT+IHAyicvgni9pUgmFWj0CF66LD6KWb/LXsupeQnNMOIHd1NgHg91KeCJtJpk4/Nye5YMPpxvXkhXT782vmgwLjI=
X-Received: by 2002:a05:6a21:2fc7:b0:1d7:c3e2:4e1f with SMTP id
 adf61e73a8af0-1d8a3c2f0acmr1308648637.25.1728438695386; Tue, 08 Oct 2024
 18:51:35 -0700 (PDT)
MIME-Version: 1.0
References: <20241002132633.246942-1-martyn.welch@collabora.com>
 <20241002132633.246942-2-martyn.welch@collabora.com>
In-Reply-To: <20241002132633.246942-2-martyn.welch@collabora.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 8 Oct 2024 19:51:02 -0600
Message-ID: <CAFLszTjjQHJEtxgkJp9qBApB=H8QDf4Cr3D_rSsVh_e-NhDc+Q@mail.gmail.com>
Subject: Re: [PATCH 2/4] boot: Add logic to enable booting from fallback option
To: Martyn Welch <martyn.welch@collabora.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

On Wed, 2 Oct 2024 at 07:26, Martyn Welch <martyn.welch@collabora.com> wrote:
>
> The "fallback" extlinux config option allows us to set an alternative
> default boot option for when it has been detected that the default is
> failing. Implement the logic required to boot from this option when
> desired.
>
> Signed-off-by: Martyn Welch <martyn.welch@collabora.com>
> ---
>  boot/bootmeth_extlinux.c |  2 +-
>  boot/bootmeth_pxe.c      |  2 +-
>  boot/pxe_utils.c         | 14 +++++++++++++-
>  cmd/pxe.c                |  4 ++--
>  cmd/sysboot.c            |  2 +-
>  include/pxe_utils.h      | 10 +++++++++-
>  6 files changed, 27 insertions(+), 7 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
