Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1D0BC35274
	for <u-boot@archiver.kernel.org>; Mon, 18 Dec 2023 15:03:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02ECB87E18;
	Mon, 18 Dec 2023 16:02:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Hh3eJPUb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6321787E22; Mon, 18 Dec 2023 16:02:41 +0100 (CET)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 59D7187E2E
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 16:02:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-6da5278c6fbso2482228a34.3
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 07:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702911753; x=1703516553; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/HskKR/fPit6ZjwlrMqCjjo/Dpe/DBKcg9KAVpTZRJw=;
 b=Hh3eJPUbc0ralHLX3XRrMvIkVA9AAixnJ3b10XSfUKME6vDu/DcLa+5mrIbvCjWv4E
 R9SLl7duo4fEjWiBil43xg5EV5CuWgKETnUkBCIc1X9bs5U+IysQxT40qyHddSXctdB4
 SSLJKQNHwrfcAdl1hLlh/UH4joxJNEVtVTYm0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702911753; x=1703516553;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/HskKR/fPit6ZjwlrMqCjjo/Dpe/DBKcg9KAVpTZRJw=;
 b=YdKGOLBqS0vHnIdoXxrwOw91d3IxP4UjY7ddyARAhxS03dq/XEyWfmY22HIG/9YpdF
 iZw+aTRXS8sT8+133951v5wS/GLtiZUE+2oDz9ZVzLz59+s2WhzpeNFj+BrtL6xvK+kF
 QrKK+fKMhQgPVAlCrCmtUsn212A1TzhaaD+oF1Sii9sY7k8k/6aeI99CFtYjqp73X+aY
 sinK+qB5B3faOr+CNSGYlUxGdmpK+jGpujxFdaiL1TcJkZwIayDahqO5BevUwsWIW1I8
 +Rj7yuMgxaFeQnNXqjo2pMPJjlj1rr8JK5V2uGn43qDt6VPx3KqbKPgscOqgi4/Xl1F+
 Qslw==
X-Gm-Message-State: AOJu0YwBrLd9+vVmIQwM9oCFYPA4PVmJrGh5Afb9EVuGoChn7p2eSrLe
 JCk/jaM7T+Ejm8S26+vhKPqjrEbey0Sv6hR6cdFCKA==
X-Google-Smtp-Source: AGHT+IFMH+7nFNV6EHD8kve1Y2a2hmjuuiS9WZW6mRFHygkhsj2RHLlf9UTWTWKDie+A5Nk8mzXVyYz9k/jqbx6vpYs=
X-Received: by 2002:a05:6830:1399:b0:6d9:deb0:d31f with SMTP id
 d25-20020a056830139900b006d9deb0d31fmr15993982otq.15.1702911752815; Mon, 18
 Dec 2023 07:02:32 -0800 (PST)
MIME-Version: 1.0
References: <20231217114457.70128-1-heinrich.schuchardt@canonical.com>
 <CAC_iWjJ+VUY+FVyyh8fib+i=qy3K0fDwvcjTfmJMfJkSW25SQg@mail.gmail.com>
In-Reply-To: <CAC_iWjJ+VUY+FVyyh8fib+i=qy3K0fDwvcjTfmJMfJkSW25SQg@mail.gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 18 Dec 2023 08:01:48 -0700
Message-ID: <CAPnjgZ2gnrdULFVLqHEXAYvb6crBCg_LMzFNC9f62vND6jjJsQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] cmd: CONFIG_CMD_BOOTEFI_HELLO_COMPILE dependencies
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>, 
 AKASHI Takahiro <takahiro.akashi@linaro.org>, u-boot@lists.denx.de
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

On Sun, 17 Dec 2023 at 10:35, Ilias Apalodimas
<ilias.apalodimas@linaro.org> wrote:
>
> On Sun, 17 Dec 2023 at 13:45, Heinrich Schuchardt
> <heinrich.schuchardt@canonical.com> wrote:
> >
> > CONFIG_EFI_LOADER cannot be chosen for ARM v7m. Remove the superfluous
> > dependency on CONFIG_CPU_V7M=n.
> >
> > Fixes: b20bb09b2108 ("efi_loader: restrict EFI_LOADER to armv7 and armv8 on ARM")
> > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > ---
> >  cmd/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/cmd/Kconfig b/cmd/Kconfig
> > index 748b959961..0ae5bcd981 100644
> > --- a/cmd/Kconfig
> > +++ b/cmd/Kconfig
> > @@ -373,7 +373,7 @@ config CMD_BOOTEFI_BOOTMGR
> >
> >  config CMD_BOOTEFI_HELLO_COMPILE
> >         bool "Compile a standard EFI hello world binary for testing"
> > -       depends on CMD_BOOTEFI && !CPU_V7M
> > +       depends on CMD_BOOTEFI
> >         default y
> >         help
> >           This compiles a standard EFI hello world application with U-Boot so
> > --
> > 2.40.1
> >
>
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

Reviewed-by: Simon Glass <sjg@chromium.org>
