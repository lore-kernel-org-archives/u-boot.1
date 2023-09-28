Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE855E732D0
	for <u-boot@archiver.kernel.org>; Thu, 28 Sep 2023 14:15:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93509865ED;
	Thu, 28 Sep 2023 16:15:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eXjjqKve";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 057228667A; Thu, 28 Sep 2023 16:15:24 +0200 (CEST)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1CF7F86504
 for <u-boot@lists.denx.de>; Thu, 28 Sep 2023 16:15:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bmeng.cn@gmail.com
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-5041bb9ce51so20745072e87.1
 for <u-boot@lists.denx.de>; Thu, 28 Sep 2023 07:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695910521; x=1696515321; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xYIMVDB+w+QtxK7SovfkBoIqp9clQO92HmINg8Jq0Ic=;
 b=eXjjqKveadq4IIKMFOg06WJneU9SkIAVkDzrQ0ufIxetCfsq6TUh3TLP6SespG/g2U
 HgrROtw3Ciberc/nIfQiLjvBXIL7KOD8zX/Xa9TJzOi45NCHcrmI3JB/zG5nTdFMkOU6
 XtenSZddXV4BnldMTyEJ6QOD8oEh20X9oyPj4vGbsPQDL0SyfegBe1wk1U3OyR7T6N6c
 G7avf0v+nq9excDZaEfXoGOSdHo+oatluv4iEeiT4ekTWHi/H0PqXMXv4QJkKMDZ6jHv
 yE14aTRvTfbm2pRSJbgpaC3fV8Ll4nB8IWrHTGzOoz9PvOAG2Uxwww0Gr3JnRYVw0i2N
 0Aag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695910521; x=1696515321;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xYIMVDB+w+QtxK7SovfkBoIqp9clQO92HmINg8Jq0Ic=;
 b=P9Ouzb5NwZPP9LUnlHTVaCxL5M0Hd7fam5ZJsk1Htyq/jUtUCDZ4IVEipby5k2622S
 rLuTo70/lG9whAg8VnqDJKx5MZ5fUNMcPUF0p82zjgBwWTnDo3SzcJoxbtrKWhsaRXuN
 gTJ17cPjDvOAAf7qJ0c8IXpX3eLfziO45ZQAK50P6px7dQnNC1KdE4JAnicsaD2cXt7w
 ncUZEdDQ2LYSA4nR+8Y4xEarw4Kt2BFOZOXY5AS1SfRxQx4TrtLKfXXvFrMVSLX1Pf4S
 EzrwOurcWr6WSL+gIC9YdwbpCvpeTntFvMisZ1uFh9J7/ItM+yO2EUdnrIuQb4XpZzi7
 ZsDw==
X-Gm-Message-State: AOJu0Yw8adXVDiumm6zH0DUf4dyKM0Cu8mJt4fCED4vnUm+sXYbUkSeQ
 YzEH1ujARLyVmGtjjERzXfLfSDeNYcvyIDAGCwM=
X-Google-Smtp-Source: AGHT+IHVV95NA6I5GU0ozhUGQ8UU9coV10r7vxkSxYI1kbTD01zm7wsJx4hDYtwVNl78Eft7GvWBs69ETR4WB4QCfeo=
X-Received: by 2002:ac2:5e9d:0:b0:503:6b8:a84a with SMTP id
 b29-20020ac25e9d000000b0050306b8a84amr1287279lfq.54.1695910520997; Thu, 28
 Sep 2023 07:15:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAPnjgZ0vKO0YYpQyr_C35bY41un59AdZcY45OT3+ydxkCr7BOA@mail.gmail.com>
In-Reply-To: <CAPnjgZ0vKO0YYpQyr_C35bY41un59AdZcY45OT3+ydxkCr7BOA@mail.gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Thu, 28 Sep 2023 22:15:09 +0800
Message-ID: <CAEUhbmU0t0LE2M+9L-heY3UZBgNsgDuPN-JheFsUwMfBndE+Dw@mail.gmail.com>
Subject: Re: SSE instructions
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, Sep 28, 2023 at 10:41=E2=80=AFAM Simon Glass <sjg@chromium.org> wro=
te:
>
> Hi Bin,
>
> U-Boot 64-bit on x86 disables sse, but when enabling Truetype I get a
> compiler error:
>
> drivers/video/console_truetype.c: In function 'frac':
> drivers/video/console_truetype.c:30:15: error: SSE register return
> with SSE disabled
> 30 | static double frac(double val)
>
> Do you know how to enable SSE for 64-bit?
>

The following patch could enable SSE for 64-bit:

diff --git a/arch/x86/config.mk b/arch/x86/config.mk
index 26ec1af2f0..250d7c9948 100644
--- a/arch/x86/config.mk
+++ b/arch/x86/config.mk
@@ -27,7 +27,7 @@ ifeq ($(IS_32BIT),y)
 PLATFORM_CPPFLAGS +=3D -march=3Di386 -m32
 else
 PLATFORM_CPPFLAGS +=3D $(if $(CONFIG_SPL_BUILD),,-fpic) -fno-common
-march=3Dcore2 -m64
-PLATFORM_CPPFLAGS +=3D -mno-mmx -mno-sse
+PLATFORM_CPPFLAGS +=3D -mno-mmx
 endif

However as Heinrich mentioned, U-Boot codes should be written in a
"floating point free" way.

The fix should really be updating console_truetype.c to use integers
instead of using float/double.

Regards,
Bin
