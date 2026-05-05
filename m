Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83663CD13DA
	for <u-boot@archiver.kernel.org>; Tue,  5 May 2026 05:44:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E05748469F;
	Tue,  5 May 2026 07:44:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Ca+bSD4x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D9BF84683; Tue,  5 May 2026 07:44:08 +0200 (CEST)
Received: from mail-yx1-xb136.google.com (mail-yx1-xb136.google.com
 [IPv6:2607:f8b0:4864:20::b136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 372AC846BC
 for <u-boot@lists.denx.de>; Tue,  5 May 2026 07:44:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-64d5a7926cfso4670327d50.2
 for <u-boot@lists.denx.de>; Mon, 04 May 2026 22:44:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777959845; cv=none;
 d=google.com; s=arc-20240605;
 b=PLfOPpF4cb0hTXYQ/aEQEfnCJqoHMN0j3X/yAHsTEvhmd38pYeM7CqLnKQiWHh+9uF
 jppYdOEwYezPYk+NjyFadZrGq1uc6TCkrzD3a11fEvlK7HgW4OcuPS0qhM1cKPuW+x6b
 RNveV72+JDew/6H9thj0T7dA2/GQlu07hnERdzataXrApZ2A9muWPfKb6d2hP5cfUy76
 r7lyzsRwHImA4BMB8ahFjS5KFWWfdzAdIp4q750IvXu+DlLxaW5yns9A18gI8wA86B+K
 HX9K2aoBVxMo6v8pDrD7+MZ62uawMZ/j7DgCjFy0Yoi8bpUAcuz2LQP4jeXWGU/Rq0l8
 oeRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=E4oe6M9rihstniz1TzgCYpSCt3OBA1x0ImiMuje+Y5w=;
 fh=Jg1GwjOEZ1S4lNqzrPlyRpppkKciiPaSkBs16SCT10U=;
 b=AFSKmv8gMjrmXYCproibUTnAdzbJbqcI5pPSIb/8y/84brFkn1YqOefE9+rut2vEVq
 py5vq+FaFOJstQcR0GAwA3Iqkvw+craCICLev9QSzy9pM9sjBpitFz8J77ndbLwOQCYB
 yITuMclFF5RUxNWea2ayXA3Kpt5lCcvj7inT9UtajYQv6+QUNo2IitjAaZtfa9y0X1p7
 OwK4zSfL6kkDhob12F0T1EyjIeDU2sP2WL+GsRGFFaaeFOAuRNeljRG3a2DBkfldxz6B
 jLCWogEsO/4//pJF1lGUtLTtVDM5x4h2wrmx4X6DhPc8YW1z82NubMuLmFbXdQOiBhIx
 e7nA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777959845; x=1778564645; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=E4oe6M9rihstniz1TzgCYpSCt3OBA1x0ImiMuje+Y5w=;
 b=Ca+bSD4xJWtvPbPCBwAPBAdtsrw9oZx1mJVWATmNz00xRQj7RCVmjt4E/0DpV3Gh62
 q9E92c4k/IoTWZeGOTLwUBl3XfOVKLKioKjxE4OCFQhm+6xAISQ6tJE7bQBwTQ0dBENp
 ZAkGfh+AFTD4DLls+QXF0OLnZfxh1Sg5Agg0yxxIYSuusptWf1z0wcnNt1F1nDyt+jNa
 6vpQ0bmQu5ytCAdLK4Po3JoJXTcD7NS4cOIZ4LH9ROpHK8ZNn4Owu3K0vvZenoVx9wUn
 ijbTi+yCmLVt4qbpoTRXWakgcvLmaQWbSw7nwDadD0AzRyqaF2/BBZNMaAF/UeQK/yaO
 3FXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777959845; x=1778564645;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E4oe6M9rihstniz1TzgCYpSCt3OBA1x0ImiMuje+Y5w=;
 b=X4PRqv+ksEV3RbbUrGKOKTgo0Y8v5Q+z5HqgdUJgpAcKpdsaJyWF6mVdsQBfnfe8zY
 wtksh6112tvwEO+z7yfBwNIdioZag451bOL9LqQ+Qk3ykvYtoNqTfUTOf4XlxL50aW/M
 VzT3bDVplUAhi+XmezmYM496G5uXqyFlg2uM77epdomgXdESpI6iSGIg9Xroxbflhj9K
 g9dzDJ9RQ8PXsKPDjMP1DfDKudYRmYvmvtgMkI9UKwPRO7i11/3NaBg5XVP5Z7J9PcYT
 X7mp86fH7UT1aUbmCYKqid1ddX1oczP5k6HLm6xgIlbKb8HQ5CL4HFiL4Ms1Zj0jLuxq
 8vhg==
X-Gm-Message-State: AOJu0YwlWAPgOSkkHSv50jN0aRx256t2MDNFK5Jaox/ptfnZ7X2SAfV9
 tQ0Qvzz8rCeLsviUegYfOvCkvA9liiAX643UE5zjONMRRoS8dsPoAo1V3OcHl502VaGcPVKAhXG
 J9XzwGycy+2v9K5q7DB87OT3Yu7CNq809eyeIZOqlnQ==
X-Gm-Gg: AeBDieuQjW2nvtMJsLhTltIZpdYf1cQIFPZ9zC/7tLk8kd6wp1A6UTzeGZyOQR0UQ/0
 5ZhXR6yXqSbd/z0uRhaJE02rGKO4lPxXvdLNPNl+kKrMAye3+UPrJskuSGrb/pXDMG9vaje6Atv
 Kh7Dmk5JYwZtZHyMFbR5iv5c3OIb3qqaBYomTyoHJ/TQV+8MntX3EXTKuB5d+IETubAHwcFFvvX
 wgnRyLQUaKr6pSUgrWNx4mZ/AnqF9hL2+YpCL/MhhJ+rv+TFoG0lEFU4WSVHQMuPQg3XUgr7SSs
 tOMpYr53/6SasCZpEvy6zEtwmBe5nNB25Daawn1cNFs0n9vqP8aN4xV3FVm3HDOueDOfNg4re6S
 BCKCgaxXlgqJlhQZ4M91/JAygHOM9ixBKxvwiAZvWYQ2UpYheplEzdhJLHNu8U5RkDFhoAfsVWU
 rUr4SkVHo1hP6D5X+mdFZCCwWcihLtVjwwoWWr15OT1oyJ/+fbGGlMwLqFqqG0U426aZfUNcBKU
 grP/YZClChUJ4io+V8gIH+HNTRg7L6efg4mobndWLmL6h/2ET8crhocvzWP7ZCdJzNfxdxH+aeF
 L8EcaPOgbiZGz4+tF0m1E8ooL14vCJbbjLpKN8aW5QjZhTaXZPPNWvbO+qVrUvUfBzU6vPn3xPO
 /rHPvrGZZM3y68K9S
X-Received: by 2002:a05:690e:168f:b0:651:c268:479 with SMTP id
 956f58d0204a3-65c3db188a1mr10675611d50.57.1777959844907; Mon, 04 May 2026
 22:44:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260504-extrawarn-sync-v1-0-b19301d1948a@cherry.de>
 <20260504-extrawarn-sync-v1-13-b19301d1948a@cherry.de>
In-Reply-To: <20260504-extrawarn-sync-v1-13-b19301d1948a@cherry.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 5 May 2026 08:43:29 +0300
X-Gm-Features: AVHnY4Kd3c8ThPqfIQwyCizAsUHfLxVhVQVRBdQUxZvqBlfXd9MEWyMJnRPRdyI
Message-ID: <CAC_iWjKz_HgtRsmL2uOCSBYy5R2WSZ6RLRWY_OboZa_7+AB2og@mail.gmail.com>
Subject: Re: [PATCH RFC next 13/18] kbuild: rust: move `-Dwarnings` handling
 to `Makefile.extrawarn`
To: Quentin Schulz <foss+uboot@0leil.net>
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 David Lechner <dlechner@baylibre.com>,
 Jerome Forissier <jerome.forissier@arm.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Simon Glass <simon.glass@canonical.com>, Raymond Mao <raymondmaoca@gmail.com>, 
 Michal Simek <michal.simek@amd.com>, Adriano Cordova <adrianox@gmail.com>, 
 Sughosh Ganu <sughosh.ganu@arm.com>, Yao Zi <me@ziyao.cc>,
 Rasmus Villemoes <ravi@prevas.dk>, 
 Quentin Schulz <quentin.schulz@cherry.de>
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

On Mon, 4 May 2026 at 16:20, Quentin Schulz <foss+uboot@0leil.net> wrote:
>
> From: Quentin Schulz <quentin.schulz@cherry.de>
>
> [ Upstream commit 592b571f20c5b905c47a1370210456f9f90ce04f ]
>
> Original commit log:
>
>   Following commit e88ca24319e4 ("kbuild: consolidate warning flags
>   in scripts/Makefile.extrawarn"), move `-Dwarnings` handling into
>   `Makefile.extrawarn` like C's `-Werror`.
>
>   No functional change intended.
>
> [git conflict trying to remove KBUILD_RUSTFLAGS from Makefile, which we
>  don't have in U-Boot]
> [U-Boot doesn't build anything Rust so this is useless except for the
>  fact it allows to backport patches from Linux kernel easier]
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
> ---

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>

>  scripts/Makefile.extrawarn | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
> index b5b1a762cdc..2af90af594e 100644
> --- a/scripts/Makefile.extrawarn
> +++ b/scripts/Makefile.extrawarn
> @@ -104,5 +104,6 @@ endif
>  ifneq ($(findstring e, $(KBUILD_EXTRA_WARN))$(CONFIG_WERROR),)
>
>  KBUILD_CPPFLAGS                += -Werror
> +KBUILD_RUSTFLAGS       += -Dwarnings
>
>  endif
>
> --
> 2.54.0
>
