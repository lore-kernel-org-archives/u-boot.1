Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 058CCFF885A
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 20:36:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5632D846CE;
	Mon,  4 May 2026 22:36:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cZwHnJS+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE1A5847C5; Mon,  4 May 2026 22:36:09 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8935B8394E
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 22:36:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-67be871ed3fso4642146a12.1
 for <u-boot@lists.denx.de>; Mon, 04 May 2026 13:36:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777926967; cv=none;
 d=google.com; s=arc-20240605;
 b=JZ4EXbopMD11c3+SsGuZlk65AeIBslcz/KXWTn68TxENV+KCbdO5Bv0L8PXJcQ7CCk
 w0Ou7ZxnxdkOGMRWEyVFwr9dPwfcMwCszmDpfqPWXkfvRRteAe6gMQkJWSTnbuf2+wlW
 7iBSzb5ezLTmU719GZPh+Lm5K6ajDZth6D6uVuXwWMxoQGW6Oun8vzaFD32YQtPt3syW
 6u1KpW0KRmYwzMnv8NUuUczAGFhVfJR0uHwxabSIfbDpVp/DX5n9vh6s2JBaoypIurmj
 fdndvmgNONFj5Bex7aOtN10O2THeOCLecWs9IedPj1gbtxV+LeZpJDXUwePgGyzSQ1TS
 lZnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=2DOF6RZhgUvN++2zJIHL2CSnqgfzL8vyXpb5CnxveOU=;
 fh=JDmMtl5m1ONTYAIDZy3RW95Kei7pwM4OcFAim19m6HQ=;
 b=i9a1awaZ+7WWE8kPo9pqHFqwP/5S/NKLBqSYsvnpp0gKLRfDoV6QmhvR1kvXhNypEX
 IvVgskm9My2CBg6tzn3oXKi/ZUztwULQS88hvd022n1HWb/hDFKcVmpGZw06gq81yCRJ
 7NUv6cPS3t5j6J/KJdrAiKMQn294izENhoHImmRrJus/1qVjNaXmro4XiCi5QfcXK4Wo
 P52n9rJgX0+CZeliC1RU39HAG0AY0FYe8BiGUMFWwWHb7cmpKhJKY7xBwu9yzmyNPzg+
 kzEyf3hP0z2hmeo0VF4t/jA0oddO1tMWwSnGnBtHFxnplb4KGdCFU6e9ZWLZL42NSbfU
 xKZA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777926967; x=1778531767; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2DOF6RZhgUvN++2zJIHL2CSnqgfzL8vyXpb5CnxveOU=;
 b=cZwHnJS+Lv+LYv61eDD+JHx1QeyFbcnS1rGZRCgI2AdqBtpXrdR6KCrGB2QxIh4ifK
 /5cCJgPd+05TE8jVtssU2jW+ET2N54GmB/pTfxtOy3r/aJsBgYToIMqG5iknZmx48oAF
 gTwWToJ1k/VMbKemfHF7NQ/KkHDphPKSR9LF4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777926967; x=1778531767;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2DOF6RZhgUvN++2zJIHL2CSnqgfzL8vyXpb5CnxveOU=;
 b=KwBEW0xRMXNaQ2TyDBIroO1veHnqi68OMLFq9TT7UCvKpJO5GZAKZzvU9V3qi15J5h
 s5hdB0CEiZ+RKF5+NxFj3C9IIc7NHPp05YjM4wh0jRiOkmyddtLCxEPBbCeflEpZisDt
 ENuE/Ya7N4xbdbMu6ADe/XEHvBHe4k547hBQ0P96g+fPc6BLzabxnpZCwZii0oN6qSOO
 BDImhqm4UUsDEYAbS9Dr4oGvdDcPyjMvAQ5nBRQ+fDt+4QVuPuUkOX95mpo8zftzjjJL
 cg2hXHdSnIIU12VWA5BmsfXdEDy/SvVz8HMTpt/hucSQ88qV53zgaJ2K8Hm3p7bA07p6
 txqA==
X-Gm-Message-State: AOJu0YwtRutU/zNcM0rIIGP4oXMcV3SbnsZbAwuFplGoJDtTm0XMmBUI
 qJ0cSiZTuCAXnlo/crSseEyEgxbR5yIfX1NPh7mEZiL0pj+xF1iUwYABiXx6uYlCwwPNTWZI3h9
 nPTauSgIEcIYnw2tRq1brjZvojL2EpHtQi8RXSd9u
X-Gm-Gg: AeBDieu8vEr+XHvQgq9AWO2NpLJRlYsJ6Fb3uISOFY8/JqaWNQ/NX9C6eKjx7VCyZsS
 XX6FYMxhQnPY6OkWWT4VhHQWBPW/1QF9v6dsk9eOAmz2rUwXHaGdi0+3YYRFPWZ7wFiPNbRDyQf
 Eiw79DTL/VdYD/trHV9DvKMZ8EyM1L8udSTlH6NoeC+aaAf0+wD6HFmh5VFogUIMCUdF3XPl7X+
 87WCG1M/3ehLy/p4jPpWqhb+slQTQ1Pu7vf6OtDsUXBXYffkbQn8qoBVfd02CBc4J2vgNyAR+0m
 2vX48/9MyB6IJvGO
X-Received: by 2002:a17:907:198c:b0:bae:3bbc:f290 with SMTP id
 a640c23a62f3a-bbffb23ff46mr650563066b.28.1777926966907; Mon, 04 May 2026
 13:36:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260504-extrawarn-sync-v1-0-b19301d1948a@cherry.de>
 <20260504-extrawarn-sync-v1-16-b19301d1948a@cherry.de>
In-Reply-To: <20260504-extrawarn-sync-v1-16-b19301d1948a@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 4 May 2026 14:35:54 -0600
X-Gm-Features: AVHnY4JYUa6hyyh-uY3lZIavNWlOmWByzjm9fQ8y5cpxPiHx3C4KtoL0EYOZyzg
Message-ID: <CAFLszTg5-JREp8E5R7sYwssgmUYYL9zV9NYFvHyObV82dHBxYg@mail.gmail.com>
Subject: Re: [PATCH RFC next 16/18] scripts/Makefile.extrawarn: Respect
 CONFIG_WERROR / W=e for hostprogs
To: foss+uboot@0leil.net
Cc: u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 David Lechner <dlechner@baylibre.com>,
 Jerome Forissier <jerome.forissier@arm.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Simon Glass <simon.glass@canonical.com>, Raymond Mao <raymondmaoca@gmail.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>, 
 Adriano Cordova <adrianox@gmail.com>, Sughosh Ganu <sughosh.ganu@arm.com>,
 Yao Zi <me@ziyao.cc>, 
 Rasmus Villemoes <ravi@prevas.dk>, Quentin Schulz <quentin.schulz@cherry.de>
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

On 2026-05-04T13:20:27, Quentin Schulz <foss+uboot@0leil.net> wrote:
> scripts/Makefile.extrawarn: Respect CONFIG_WERROR / W=e for hostprogs
>
> [ Upstream commit 7ded7d37e5f5b36b4acd74380156cf07b6640c5b ]
>
> Original commit log:
>
>   Commit 27758d8c2583 ("kbuild: enable -Werror for hostprogs")
>   unconditionally enabled -Werror for the compiler, assembler, and linker
>   when building the host programs, as the build footprint of the host
>   programs is small (thus risk of build failures from warnings are low)
>   and that stage of the build may not have Kconfig values (thus
>   CONFIG_WERROR could not be used as a precondition).
>
>   While turning warnings into errors unconditionally happens in a few
>   places within the kernel, it can be disruptive to people who may be
>   building with newer compilers, such as while doing a bisect. While it is
>   possible to avoid this behavior by passing HOSTCFLAGS=-w or
>   HOSTCFLAGS=-Wno-error, it may not be the most intuitive for regular
>   users not intimately familiar with Kbuild.
>
>   Avoid being disruptive to the entire build by depending on the explicit
>   opt-in of CONFIG_WERROR or W=e to enable -Werror and the like while
>   building the host programs. While this means there is a small portion of
>   the build that does not have -Werror enabled (namely scripts/kconfig/*
>   and scripts/basic/fixdep), it is better than not having it altogether.
>
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
>
> scripts/Makefile.extrawarn | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
