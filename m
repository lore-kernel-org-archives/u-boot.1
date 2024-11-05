Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBC13D31768
	for <u-boot@archiver.kernel.org>; Tue,  5 Nov 2024 17:03:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E85B488CD9;
	Tue,  5 Nov 2024 18:03:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="D7S3mAeA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A11A8904C; Tue,  5 Nov 2024 18:03:54 +0100 (CET)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32FDD8855C
 for <u-boot@lists.denx.de>; Tue,  5 Nov 2024 18:03:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-a9abe139088so841495866b.1
 for <u-boot@lists.denx.de>; Tue, 05 Nov 2024 09:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730826231; x=1731431031; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=U3UnbBOoO3ihOFFR/clQ4yBZ/ky7AyAfEbhBCwGMFi8=;
 b=D7S3mAeAyqhUXzF4csGgriBZqeDkmyxpyeQH59Cdz3S3335HdNtkY4vD0IcJL66I37
 SprYuQut9y5TE6G3/PB+YQS2x8U6okigUJ3xmAJY5JL3kL4s+MvHntVTNvZEYgaVSU0w
 ySq/2OSpBtaJMaQfCzyCZCBqjtK2p7mDMUZsw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730826231; x=1731431031;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=U3UnbBOoO3ihOFFR/clQ4yBZ/ky7AyAfEbhBCwGMFi8=;
 b=IYfCnWZ8ZTVtIdsZCPVRAGM1q0qkplbTrpjd/eG+3Z1GtDHCn56g9yVJSUZlS+Mzf0
 wBuOoRkRkU3D7RVJ2xyQ4egnuiGeWvdY2N1P1hdRmBy6v1qAJ4ghWU9kqd32G1TpJeqA
 0L2p4ZflTc4OfGvGt4oooCCRsaIkgDfooIKCmUHQ8gXJVJoW8y3eV6lNgZKx2q2i43uK
 DL6nQ030QqGDlny3x/zfdrEnYZDG0LW2dfjUllI2AedB8mfaAI5IPN7CH27CynNi6a0d
 jOsfCqQLqiqxYO9CpuYJJ+or/P2uTMEijyCRrTfRvOt17/0cly9bzyIBXq3JsPAn5wqB
 ObEA==
X-Gm-Message-State: AOJu0Yyj/uAOxzQHEMfJAoD9aJhZvHIOPUP2xsyCwVaDhDdeA4yd02v5
 wKhm2jFhfexR5oEKZhPfawLOc1CCjgr96t0CzZ8WIElaNqHtIiL6CGUF45A5n7WqUkSqCgcqCXT
 SIOU16o4eg7zJkZ6G/y5Tu8olW9oEmoQS9UHX
X-Google-Smtp-Source: AGHT+IFWUE50VDA5Fze/6k5htlSQSRHO56RshIIw/MmWcBmEJZAavs2yJStPAEOnQpH+cQg97qwiDKl0qBKugFpkOQI=
X-Received: by 2002:a17:907:60d6:b0:a99:fb10:1269 with SMTP id
 a640c23a62f3a-a9de5ce4ad3mr3867678366b.17.1730826231424; Tue, 05 Nov 2024
 09:03:51 -0800 (PST)
MIME-Version: 1.0
References: <20241105165357.620796-1-trini@konsulko.com>
In-Reply-To: <20241105165357.620796-1-trini@konsulko.com>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 5 Nov 2024 10:03:39 -0700
Message-ID: <CAFLszThU2T2A4DG-=isO6vP=149Lw6jQaB3vs8ggJ2H8CcDwBg@mail.gmail.com>
Subject: Re: [PATCH RFC v1] Dockerfile: Have "sandbox" build with i386
 toolchain not x86_64 toolchain
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

Hi Tom,

On Tue, 5 Nov 2024 at 09:54, Tom Rini <trini@konsulko.com> wrote:
>
> A long time ago, we had to use "i386" and "x86_64" toolchains for our
> x86 platforms, depending on the target. We then moved to being able to
> use the single "i386" toolchain to support all x86 platforms. At the
> same time, we had been building sandbox with our "x86_64" toolchain in
> CI. When x86 switched to being able to use a single toolchain we did not
> update our CI buildman file to match. Do this now as we want to ensure
> that sandbox is built with the same compiler version the rest of our
> platforms are and not the host one.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Simon Glass <sjg@chromium.org>
>
> I'm posting this as an RFC to start the discussion as when I mentioned
> this to Simon on IRC, he was very much not in agreement.
>
> My main argument is this, sandbox needs to use the same toolchain that
> we compile (virtually) all other platforms with as one of the points is
> to be able to catch warnings and compiler behavior changes as soon as
> possible in our CI. And just like how developers can use
> distribution-provided toolchains today, nothing changes in that regard,
> we only make CI be more consistent now.

OK, that makes some sense to me, actually. It isn't the toolchain that
people will be using, but catching things earlier seems good.

The main concern I have is that we are not testing sandbox on the
toolchain that everyone will be using. But I haven't noticed failures
in CI which I cannot repeat locally, so we can cross that bridge when
we come to it.

Reviewed-by: Simon Glass <sjg@chromium.org>

> ---
>  tools/docker/Dockerfile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/docker/Dockerfile b/tools/docker/Dockerfile
> index 967ac89fbde8..e158bab6e570 100644
> --- a/tools/docker/Dockerfile
> +++ b/tools/docker/Dockerfile
> @@ -280,7 +280,7 @@ RUN /bin/echo -e "[toolchain]\nroot = /usr" > ~/.buildman
>  RUN /bin/echo -e "kernelorg = /opt/gcc-13.2.0-nolibc/*" >> ~/.buildman
>  RUN /bin/echo -e "\n[toolchain-prefix]\nxtensa = /opt/2020.07/xtensa-dc233c-elf/bin/xtensa-dc233c-elf-" >> ~/.buildman;
>  RUN /bin/echo -e "\n[toolchain-alias]\nsh = sh2" >> ~/.buildman
> -RUN /bin/echo -e "\nsandbox = x86_64" >> ~/.buildman
> +RUN /bin/echo -e "\nsandbox = i386" >> ~/.buildman
>  RUN /bin/echo -e "\nx86 = i386" >> ~/.buildman;
>
>  # Add mkbootimg tool
> --
> 2.43.0
>

Regards,
Simon
