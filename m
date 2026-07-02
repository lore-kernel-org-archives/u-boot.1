Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36AB8C43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 08:30:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 27ABF84832;
	Thu,  2 Jul 2026 10:30:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="c5vCc475";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E463D84CCA; Thu,  2 Jul 2026 10:30:31 +0200 (CEST)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com
 [IPv6:2607:f8b0:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21BFC846A4
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 10:30:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-847a483e344so349573b3a.0
 for <u-boot@lists.denx.de>; Thu, 02 Jul 2026 01:30:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782981027; cv=none;
 d=google.com; s=arc-20260327;
 b=YiyTLjs5xeSYfOwM4ZTyGdYj2+hUohdUC/Ob1iudx2hJjsChy0MvzdymJnLbeWJhWV
 sywxbtSs6LdHGj35H3DpKL1HhP8bU5WId8lKMOmvz2FDpgrKulJ/CS4tEwidUcCBtOkk
 f5bY/uN2oddUswSoZgJ4EDfqbrPMxddzfzp4wiN/xzZ5lBUlCdGKbKiiWMavr+sm1FoQ
 r9snnJ6nuVelQpWSZpiMt8Q5iX7UXz+RoSUVau3kDjjLoYKclLbbrlFmH3irIjzfxaei
 RB1aT1WdNPA6hsAmjalQotDOWw62ApUGjNvF9OBLuh6z1MiKdpU+AYh2qWjHjseqSBOB
 B/Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=yJggQ85DM678AeQx+hLa8A+ftwuK5okLSbZuyeJsCFg=;
 fh=MhAo4QPuXEC/Rh971JORz4rq3nvFSJ8p5JStjvc7R4U=;
 b=bI7T9GaMScuHsdrO8b7YPYfazKgdNBvmcU9dL6+8NCLb7s12/iO8OUbUoEJ6mBYh5Z
 rOUGq6ZV6pn8q2G8QyiDktC6Huw4FeKaJ9a+S8W/Nae8+ocYGJFRd8zx/uUmwKPKE1KA
 yskxtz+Z3uVvTx2xWWCOuE8YeQ2YaB3m3qw0xMRqKEbIr8IGHU0S48+MQwzvYiOffa/1
 uMjTydv3Zd9ejfRO0uUwfganoTwwkfJZFqVbRzlE/WKX9Hr1O/CIqXrJjt0CZllVYcrN
 XPZwCZumR8yUojDIgpddtVMXYLUjqGJGQ9nwbkcTehHFONIp+smPx+wbdqujgB/JGS0Q
 5s7A==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1782981027; x=1783585827; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yJggQ85DM678AeQx+hLa8A+ftwuK5okLSbZuyeJsCFg=;
 b=c5vCc475QAEp7bmq1zYUSnsefw1cwakNtXexbjdoXaX+1r3Grrvy/FrFtfitMz2rCm
 /JJPjDfD3KZSA8Yo9SUuwLcsrI4+uXgii9J9rQeDivyksyg2K8mExGaaOFfw7kG36q73
 p8rLOEZWlvBuQcIti5lUqx9Hhl/0hkRaKlkIQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782981027; x=1783585827;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yJggQ85DM678AeQx+hLa8A+ftwuK5okLSbZuyeJsCFg=;
 b=JUXnaixVTnLrC7dLSnEFGOlC/77K/EzgUAX9JhIb99EO0LJGdGM0v5oat5THuWCXAW
 Hv76iiWVe85m//wH2JipGvSLYXbptCRXBD9wS1QMbGrodH3mConBsGfKWRNst7nnF2dx
 +ABl3JIXH/Knk3DUqoEo9XdytjWQHW6GhNzPtN2LvQyGk1qfSe8lBeMLyEDKrSxGoA8Y
 SXUpsXFLlcJhEPMLUz5JAQFyvTjJI1vCH4nqjzQ0JHGkFMdKDM+t8saAO8A6T3mHwMlM
 POma+/ATUZVdIw4tNELkdXDFnafEbqcVNJhUpFEg0BU03a8xHXhfkXfZMydmYkUVx2J6
 3mVA==
X-Gm-Message-State: AOJu0YyzUaRsRhbFz4nJ55b2n6aPT7emCQ5lLZbwi57ZsjNgXA+keNmO
 HSDNY7xeNNjzD6BCK/J0xh+ElT8BOyh1B14lJS8bwGO8M9+Q60yAhFg3183Vo4GL1AeVXrvkoVY
 qS6wLE7HX+cbsbkmI4w75x+k2714tFiGcG3B+RHQi
X-Gm-Gg: AfdE7cn/lqjn3wJbJDkLZrQJ6l5kZH4D+UtEJQmI8mPJEZzi6U9Xhy0AmX34NsTfVtU
 KYIBqeWug4h/ZSRveS8EnD/2hzllIfhWruIylDzTRpY9rPyoz8o0Xwv+ZyroDZttvcug0TDxxyq
 hJDAB6WbPU0ptc8pgncbGnvEGotVwyMkTn3+xsDZ05kosXdr9G4ZddB39HBorea2NozYk0Ka2PR
 VLHKqfO1R1Skv4HR/rtRMFbLCWhokqp5/v4vQTWL4mzfqTgs6zXeRtY7ZnAI9V5CLz7mLbLqtnj
 Tv6iCVV3
X-Received: by 2002:a05:6a00:4c0c:b0:845:ec3c:548e with SMTP id
 d2e1a72fcca58-847a831f70bmr7561272b3a.25.1782981027317; Thu, 02 Jul 2026
 01:30:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260701171535.906272-1-rv@rasmusvillemoes.dk>
 <20260701171535.906272-3-rv@rasmusvillemoes.dk>
In-Reply-To: <20260701171535.906272-3-rv@rasmusvillemoes.dk>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 2 Jul 2026 09:30:00 +0100
X-Gm-Features: AVVi8CeKEjSppC3wDUgJPwix0udqy095-0N7maUsL3XUSZc0xXBq_ODdL5W575I
Message-ID: <CAFLszTgSJCxscS+ODRg=fMXMKLKnK_d6G+PbSoEfeWQwoYfO2Q@mail.gmail.com>
Subject: Re: [PATCH 2/8] string: correct prototype of strchrnul()
To: rv@rasmusvillemoes.dk
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Casey Connolly <casey.connolly@linaro.org>
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

On 2026-07-01T17:15:27, Rasmus Villemoes <rv@rasmusvillemoes.dk> wrote:
> string: correct prototype of strchrnul()
>
> Both glibc's (where this originated as a GNU extension) and the
> kernel's versions of strchrnul() return "char *", not "const
> char *". That also makes it consistent with the standard strchr()
> function.
>
> Signed-off-by: Rasmus Villemoes <rv@rasmusvillemoes.dk>
>
> include/linux/string.h | 2 +-
>  lib/string.c           | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
