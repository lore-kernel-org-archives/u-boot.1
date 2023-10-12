Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6E58CDB46E
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 03:51:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6923A86F2B;
	Thu, 12 Oct 2023 05:46:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="ezblauMo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BB9E86EC0; Thu, 12 Oct 2023 05:45:57 +0200 (CEST)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8CF5386EBC
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 05:45:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-5a7be61fe74so7067657b3.2
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 20:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697082311; x=1697687111; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=x4MUmRcp81HiMlvyG+EaEgyKF974iljwe89li+2tmPY=;
 b=ezblauMoR16+9WXFLwjViy1j3HlXiTwP68OKtPt1+4U5JrFD559yqyFEmTEZpf5Gax
 G7JUnpVqFHbH9rshUPGyx0914BZPTnyBlbTQBBuqoePIe+bnteBhmUnv8QcnJ4l0B0Dx
 OKybVLyuCvI1I4/f9ccUUOJl8xOlDyASFImV4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697082311; x=1697687111;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=x4MUmRcp81HiMlvyG+EaEgyKF974iljwe89li+2tmPY=;
 b=VO/KRcqGelkZZiUthYwmwpXqGKMAupnBEmxh93dybC03TzPccUxwCBuVEFB1UWqJRT
 3ZnB1gSoL5n1jjnOfQHNo57evzHCPI5cHQZqN4cHSRKqdBMvno1L/tOZ+Ii4BuzB8+jO
 +cfscZnSLvg6CwwYw+fR8ticwbEjhIpSy67MctpbGHtY/CG7TZq0BDiy+PHSQnwQhZ8i
 OrbLIht9cNlWsyG53GStOwj/6mlvRiuHgDJiUL+xus9rmgHFZSYtrbEO1BuIoWM4RKyx
 tjmDvtxZMKP9Gh1asczsdR3ZbGuI2wMwIOCEK+LH6s5Bw3HWqKW9dpmrptmdsuDxx22S
 Mf5A==
X-Gm-Message-State: AOJu0Yy+oBVwmVUZqvqf8Hr18Zg4i7yntVLlwYkgLCb06fv4whKISiYW
 mPS4OObje9gbSGhLRqpxaa6s8CLCfUvYhjtz8A7gGg==
X-Google-Smtp-Source: AGHT+IHSmmbK7qkRnWIUTkHrIygxoIQUagfDY/RgTJFcxGC5TUQsr3PyX4nmUv37bIsyV46Ury95JpJbgoZZFXVf8zY=
X-Received: by 2002:a0d:c646:0:b0:59b:f899:7bd6 with SMTP id
 i67-20020a0dc646000000b0059bf8997bd6mr23280055ywd.36.1697082311103; Wed, 11
 Oct 2023 20:45:11 -0700 (PDT)
MIME-Version: 1.0
References: <20231012015626.3487451-1-seanga2@gmail.com>
 <20231012015626.3487451-20-seanga2@gmail.com>
In-Reply-To: <20231012015626.3487451-20-seanga2@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 11 Oct 2023 20:41:28 -0700
Message-ID: <CAPnjgZ3yoUOWkrji_i3a26foTotrKedRZ6PF=bLs60mekEC_hA@mail.gmail.com>
Subject: Re: [PATCH 19/26] test: spl: Fix spl_test_load not failing if fname
 doesn't exist
To: Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Harald Seiler <hws@denx.de>
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

On Wed, 11 Oct 2023 at 18:56, Sean Anderson <seanga2@gmail.com> wrote:
>
> Returning a negative value from a unit test doesn't automatically fail the
> test.  We have to fail an assertion. Modify the test to do so.
>
> This now causes the test to count as a failure on VPL. This is because the
> fname of SPL (and U-Boot) is generated with make_exec in os_jump_to_image.
> The original name of SPL is gone, and we can't determine the name of U-Boot
> from the generated name.
>
> Signed-off-by: Sean Anderson <seanga2@gmail.com>
> ---
>
>  configs/sandbox_vpl_defconfig | 1 +
>  test/image/spl_load_os.c      | 6 ++----
>  2 files changed, 3 insertions(+), 4 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
