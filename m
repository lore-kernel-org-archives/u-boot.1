Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56B0CFF885A
	for <u-boot@archiver.kernel.org>; Mon,  4 May 2026 20:31:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B7417846F9;
	Mon,  4 May 2026 22:30:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kKJldvwg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B975584704; Mon,  4 May 2026 22:30:56 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 880D8846F4
 for <u-boot@lists.denx.de>; Mon,  4 May 2026 22:30:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-ba67b332bbaso649273366b.0
 for <u-boot@lists.denx.de>; Mon, 04 May 2026 13:30:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777926654; cv=none;
 d=google.com; s=arc-20240605;
 b=kwZyxnxSkkcguBiCPy5FqdRp0zuaT7MySrxeheu95B8RWqAmRsMKqw7JMPFS8+8n0x
 xBTWFgj1euD2aUT0Rmx7TNUPS7YANF4NlQWaEfwXh3IPoRyTYjNnaQyoS3kbX1DDNzyJ
 xrj3o5L7EkXhrKrktvurCZ6RmrVbStDxPmDE0Y3/8S4Y3JmEuyZHPsXy1u2UH9DpcOeu
 COA11D+zktJi3WbgEaQd1dx78P2Bc8gmGKa/l+kF6ct5+SBQM92sujgX7ndqy4zqxz62
 xg3+l4xdTvuxthna4Yb8L9ye6+iIjqelUKztTRXeG+6OrlPMeLtjI998fB1di1oN/efC
 ueAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=UXYTN+dlQg1sWL+vMpyYX3hlM/RayIVNZ3Flb0pXg1g=;
 fh=JDmMtl5m1ONTYAIDZy3RW95Kei7pwM4OcFAim19m6HQ=;
 b=FyLVmkEFGMRQm/C9nolWbY+5FQQrZltoyc4eCPlyo1eiPApIaqPvTIHwB1AYSKie4k
 LbopV97A9uXthzf5/cetncL/4uJ0k2annGPb6oRXVYicZooKCYbY1ULmf7VWEL9r93Xh
 Sjwl+c+6cO96TyldvX9D8Qytx5B4JMcCVLfTCkHJmukbTYXM3kkJbvAzgPKG37MBSL40
 ujQjzFdP+DiQe2rqcYqL/ilxQ+lmv7Hv1v4ecefdVstTzmBZtCupuRYYkhYK83+hOBNm
 j3ENjIp/np261f0a0qTyXliyZJxQXBRjYctr+4uSj9RDKFPfq5IrOE+K7y2Ik+E226Al
 rclA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1777926654; x=1778531454; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UXYTN+dlQg1sWL+vMpyYX3hlM/RayIVNZ3Flb0pXg1g=;
 b=kKJldvwggjjFPrxTobGKUq4L/nPKOq2CFFQYHrOYFnw8OpBJY9s9IvIhjAeg5IcvdU
 fgKOhpmUgb6aBGDo5tZIJkrL3sLLiMniGDT3OQY0y2EFh3o/VjquE78czDCFLuROAWQe
 aEcMqUz1uijztNhcl6kgLLWe5fPsBZP5+FRZs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777926654; x=1778531454;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UXYTN+dlQg1sWL+vMpyYX3hlM/RayIVNZ3Flb0pXg1g=;
 b=JjKZPxPz9ZMRbhl3HX4GYSjklqop3hywcILmdqGK+6L5Gj271vtrZwRLSLROcGb0JZ
 JxPsL6rQbTD1AJ4PwocTGUQWi/W3QHboMZkLZ+J9EE0qHbIz4rq7tCKcwemJb/5VrFrZ
 6MGOzncyH29BkiChJY9LwA8qTON/70NBT/XiMMfFgLQ8SUoe6+eecR3Jx2AcnKNfOqC9
 vgVtHXFFTQgwc0iyr4qpPF6tDeLOz3VNOq7G5zNEAD7mCf+dCLy3Z8yfwQWyxMspgvUp
 3W/gic35kz+7SQ6a+60ADpuRxPS+cx+fc5A9euj/Ou+3hWQy6GviMu00XKIK/wc1MLUH
 t0AQ==
X-Gm-Message-State: AOJu0YxOy/w/CFuEIxZIXuIZWGvKNsMw0D3zMRDyFpm+j/fFuZ/63OhS
 4mu7M+/e3Pci+t8ethFLozDbVZT0jCBTeJgbkTDVOukqSmrsGEJriZoeuB/h1tHq06xODKC2sKp
 Bat0+WN2EUQsoUG09mkRGDWcWfRr9bGJRt3HBmmgO
X-Gm-Gg: AeBDiesMMFtoxkId4xGFDdD2ElWhmfOqwNjMAoQ00/6uJkrQYhZ7Tvt5KmuSa8uiHxF
 bSvNYKAwcxEaKj5RfDjKC4q23QhBmBNKBj0XoNTzix9Cdn5JpuSlghuDj8aDuS8Grr1BIY9EOE1
 r9OBmJpMK5OQoPjWLoI1ugj2oCuTNj8utP1lUaPHuIq3fqzqfUNNPKolBKzzGitBDWw3srDEbYt
 WA10osKVYadLnf3PWySrI98F9xkdUBQFRskTX/1oaDiSpfFWgA8brIX1VMBi1mOr7G6lv0+GEaw
 t+hYLL+shi35fq1wFmtqy8B1wZg=
X-Received: by 2002:a17:907:7b97:b0:b9c:b682:83bd with SMTP id
 a640c23a62f3a-bbff8dc8694mr659546066b.4.1777926653855; Mon, 04 May 2026
 13:30:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260504-extrawarn-sync-v1-0-b19301d1948a@cherry.de>
 <20260504-extrawarn-sync-v1-5-b19301d1948a@cherry.de>
In-Reply-To: <20260504-extrawarn-sync-v1-5-b19301d1948a@cherry.de>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 4 May 2026 14:30:35 -0600
X-Gm-Features: AVHnY4IUCW5GgkhBPjGrB7YPDgHmFC6j0FPEM-Lu7KMTyLg0xBAcJJkhtvNsuLs
Message-ID: <CAFLszTj_FfPuhL-adQxviRP-96YSFa8kTR1QpKUcWE=9M-3+OQ@mail.gmail.com>
Subject: Re: [PATCH RFC next 05/18] kbuild: Don't try to add
 '-fcatch-undefined-behavior' flag
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
> kbuild: Don't try to add '-fcatch-undefined-behavior' flag
>
> [ Upstream commit 7eb8e5f073051eebbf55fa6b90ed2246c2274552 ]
>
> Original commit log:
>
>   This is no longer a valid option in clang, it was removed in 3.5, which
>   we don't support.
>
>   https://github.com/llvm/llvm-project/commit/cb3f812b6b9fab8f3b41414f24e90222170417b4
>
> [git conflict in context due to commit 52ee1a0294e8 ("global: Disable
>  deprecated-non-prototype warning with clang")]
> Signed-off-by: Quentin Schulz <quentin.schulz@cherry.de>
>
> Makefile | 1 -
>  1 file changed, 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
