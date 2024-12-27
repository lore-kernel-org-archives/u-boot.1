Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87760E7718B
	for <u-boot@archiver.kernel.org>; Fri, 27 Dec 2024 08:25:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9DFE58036E;
	Fri, 27 Dec 2024 09:25:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="tt0U5THG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75C978036E; Fri, 27 Dec 2024 09:25:42 +0100 (CET)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 548598036D
 for <u-boot@lists.denx.de>; Fri, 27 Dec 2024 09:25:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=linus.walleij@linaro.org
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-53e28cf55cdso6082276e87.3
 for <u-boot@lists.denx.de>; Fri, 27 Dec 2024 00:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735287939; x=1735892739; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TCSsdOcNjnC66JVoscaijN+pIMGOv/QK7x6ArYKcCJA=;
 b=tt0U5THGqvemkKEaq9MU25qpDfIoYDsCkOb48XFD2dfYd9iu7/HEZ6LR1iFaYub9wn
 ulGvrNeRTHg+/3jVyrFaLf0ENmkckRj6Fk0N8Qdwy46J+T2pCPa0iAyS0hyFLTYx2/N8
 /EQ65iTe9YMotVvMXjCF2+QCDz1db2VwYRb5ptBYeTAsuWmW/rn/7W26JAKJPZB9eeMe
 Z1e1bzoHbt50ictee6n7H/ZYoNLeW9x+rBqM0J34S+HXnVlZdvSozy9wIKu3cGHRFsUy
 1X5HhO+2EykTHxIjBFrZkEGsleYzHe53C1JFdldB/k6azegxTGGe3Ol+nTe6vWFoDKER
 eQJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735287939; x=1735892739;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TCSsdOcNjnC66JVoscaijN+pIMGOv/QK7x6ArYKcCJA=;
 b=f4n2EHKdYGUVyPjYOjPQuyoL2cH/r1gf+skGrNOuLGTgkI4Lj/O6VP92p6puOBv+V3
 np7r4URaYPI5li6Bg4LYISh51FIYhNVZ3GKOkyKOXbkj+Uh2sNmS7EH7iwOw7uq6FT4F
 LMRAkF7wM+KcqHgG6kelbK6QKV88WWuw3oe34lOreVZDvWw6vL+QZaAT2e9PIjWxDMCx
 ksYYKWBlL6peJ9P1Lgkd8IIRzdP8bJbZc9mWpEoEhK9BUa61Fm3NMSP/o8UA4JJtP/zd
 Jyo7ukiB9GJmj/9yve3l74aushT/ktcZ91rzts6VqTbyTuzZizPH2kX3pgHvAo6ZoUig
 h03Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWG9qwtY5vDDqDgZXgM7GEtoaVvNK9mqawbaXU/NK0WQDAYm06nSh2eFxvwi4mD4/sSP36imNo=@lists.denx.de
X-Gm-Message-State: AOJu0YwRkmZVTz1+vPL0liDed/Sfyr1axBUOiL+8pGBQQi/NCtVJykEC
 KXb7cygvKypRN9jgclNEghnFZofJWVOKlBi4ztPhXJv6TljYX+0ZICa6g0cCaII6EYfa+6LxJc+
 IJwnGh8VUi9nEM1zQCh5kbBlb5HJnbUKKuvCKVA==
X-Gm-Gg: ASbGncu3Pz6SuZqC0GX8aEu+e4MKH7oJjaDhXX4O+3ClPJRtgs7mDoNo9xpwoG2Ll/3
 8l+eM9I0U8adpH7mnb7wo9aPkGgi3wF45c1ac
X-Google-Smtp-Source: AGHT+IE/o8VC/uFk5rxe8wr5MfODIs0YPZN3vRdiH78fksNfebF/3ytYr6BJjOF+5kUr6QBpSeVKUayVCtRFb9o3CQk=
X-Received: by 2002:a05:6512:1114:b0:540:2567:469b with SMTP id
 2adb3069b0e04-54229533e5amr9263219e87.16.1735287939594; Fri, 27 Dec 2024
 00:25:39 -0800 (PST)
MIME-Version: 1.0
References: <20241218153933.37649-1-harrison.mutai@arm.com>
 <20241218153933.37649-3-harrison.mutai@arm.com>
In-Reply-To: <20241218153933.37649-3-harrison.mutai@arm.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 27 Dec 2024 09:25:28 +0100
Message-ID: <CACRpkdaU6M_cqwDLsSGxKXMJNKg8hNaE_kDF6VJq1FOHw8OxZA@mail.gmail.com>
Subject: Re: [PATCH 2/4] board: vexpress64: default to hardware device tree
To: Harrison Mutai <harrison.mutai@arm.com>
Cc: David Feng <fenghua@phytium.com.cn>, Peter Hoyes <Peter.Hoyes@arm.com>, 
 Liviu Dudau <liviu.dudau@foss.arm.com>, Tom Rini <trini@konsulko.com>,
 nd@arm.com, 
 andre.przywara@arm.com, manish.pandey2@arm.com, u-boot@lists.denx.de
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

On Wed, Dec 18, 2024 at 4:40=E2=80=AFPM Harrison Mutai <harrison.mutai@arm.=
com> wrote:

> When booting into the Linux kernel with semi-hosting, use the device
> tree provided by hardware unless one is provided in the current
> directory.
>
> Signed-off-by: Harrison Mutai <harrison.mutai@arm.com>

This looks helpful to me!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
