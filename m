Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C941CD4F3C
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 18:35:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E820484865;
	Fri, 15 May 2026 20:35:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="P1WQ6gS5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AE1AB84868; Fri, 15 May 2026 20:35:56 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BD7CB8485A
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 20:35:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-67fd8befac7so379354a12.2
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 11:35:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778870154; cv=none;
 d=google.com; s=arc-20240605;
 b=DTy5MS6DUIa+vF4I5WCWlku5Sa2VyIbPMfd/L4HZ3A0VcdtWfHiUEVHZ5fuH81WxBK
 PdbjQTEMQRUvthrJ3ISzT3RpDJX94C9H09x1R/HSooJwGrhB53uj0NR/jhRrpksw+nwZ
 TA3DP+WBCto1CUlb1ERpoC/k5al2DkcgJENRISEAJXygOs9fZH2YK6vZggYBoYPfQmIS
 D4H0O+6j+UfUZb+JBy+E+akDaVc2YdKcxARWnJjnrO0XNdzKMb3EDw+x+9PiFgJAp5Cj
 dpWqw7CkvHfhCZD3KeJ3Pixne11WI7Vu28LhlZZMBYgO59K1KmOaO+dQ7HwN5Y1uVy+g
 ADFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=/S59lnXssK5uv2aZvLwSo+vEJQIxeuHThh3WEywPXW8=;
 fh=sKlYf1RYFkU7W57k8Hb0RqRH+ropi6os4Aw4ruwQ2Xw=;
 b=aSDA1VKnICtnL/6qpsh/wClKjokpX3lwHvQYOUjyF0UsZFZs/NRIdolwZj9e1jhHeB
 Qh4CZD9/XEfOTfh9sDY5EI1OUBfXA/UVV0I67ihXGuHcOKsMkcPWnqgtHnaY/wW0REbv
 NYjcMaEA7SMPf//76zkoy2hqtYkfZVVp3FZ6q/FZzJMzlYXR0dJZVMAHatnsYo7f/1BW
 Uc1Qyrq2p5wBvcqOEK69c4Yk3weXZCefXnM9ZdBk0CHD0TCmLsztYc7YHJwr71U1WtFy
 by97x7+B8cLFpjhwGNsZANDrVJsbk9hGlaVObHf3t6isxMQwzRYBzqbtaLWNexVjxlG6
 KdzQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1778870154; x=1779474954; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/S59lnXssK5uv2aZvLwSo+vEJQIxeuHThh3WEywPXW8=;
 b=P1WQ6gS5K2dCSK+4qKBp4Vu0UlifVqPj3nJ5wBETaxj3AXMy7zyPalZIxKr1uQomgr
 ZcERCPvEzGbg8fnjQtuR1nJPWvzHucPzk8NaSsbWoUwmjUqLitLv0XHhedzR6y4xDCcy
 PKLHxVhRJ3wCsa3zejveegrZy3KM1hVaUtTLI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778870154; x=1779474954;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/S59lnXssK5uv2aZvLwSo+vEJQIxeuHThh3WEywPXW8=;
 b=G6bQmeFmTcPayYP8J5MM+k8BjMB6F7UozLHXlwAwP/7qUl8rzrkBkYjbgE36Meqj8a
 a9cAlddTdM2F0kMbc0DY43nqWev8G8VVg12wHZUVny5Ln+RQvjcWABSiVKvDbd01uQnh
 oHM8x1n1zxJ6F5gt2JBocCJPqrB0v/YZTlVUzHrYc7Sqbg7RQwVRw8zbfRhpmZXNwSzL
 Hm9EYKlBjVwSl7dQeYD0HjVJ8t/XLEYGT21AM03XoyOOzSb/ao3aD+QOYtWFKH185Xjy
 vPThiOqp7SA30UKjFIQPuzym/gvcAO5FbqiH8GMjqWfQ/vyPXA/U5vfd7sCe1or6MiYI
 4mjg==
X-Gm-Message-State: AOJu0YxTFrEFZ9g+bxLpoS04Hp0P3pb259YGDykebcX1CrUinIQEhymI
 /w/Bi5tzibxI94FvKAVMi2TWHcon2dg01nyP6qMPFQwIgW4t7/85Hh9pqZPBCCROqLNeMi1Yxmn
 piYk1g+Zo0TEKyidQ4ZVz+4zOmV9Gb0zOqjuZ8kCd
X-Gm-Gg: Acq92OFqHwOjJsZKIazSV9Y9OCD8763SOS7uKVCpucgF+gezPICY7S56QLtzg2yWVgH
 WWDUTV/hUe/ocJKh9ckkO8hAueBKEOCW2hHg71AOeRM3fFIEofqMEVhvRNddevxKy4CPSSL0kyH
 GsD2lIz56Ne+XxM/3eWj1mwy0Sz0qmOkhqcZPpOOpGCZOTyjqkbU9A10Q6O278e/Rl+N4NO6kvP
 c0iXRkrZW95G8cafJhAJoSNGyql3k7yQT9PxNyEjsQ6Z1x3rIba8BY5N39N+lpwccqVULWIGkFL
 8CTqh3yeDStAa5mi
X-Received: by 2002:a17:907:e104:b0:bd2:c919:22c9 with SMTP id
 a640c23a62f3a-bd5179311e1mr183179766b.35.1778870154136; Fri, 15 May 2026
 11:35:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260424173151.371134-1-harsimransingh.tungal@arm.com>
 <20260514124924.1804332-1-harsimransingh.tungal@arm.com>
 <20260514124924.1804332-9-harsimransingh.tungal@arm.com>
In-Reply-To: <20260514124924.1804332-9-harsimransingh.tungal@arm.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 15 May 2026 12:35:42 -0600
X-Gm-Features: AVHnY4KfNhLnLGy4yjMzXfgytTOBgVI_pZUWdxloyMms4faehKPBRKsOD8KQVo4
Message-ID: <CAFLszTjosvD4kvLiaDB6BQmFDEae27Nwoq5n35TtFgpcGNr90Q@mail.gmail.com>
Subject: Re: [PATCH v2 08/11] efi: selftest: add runtime variable tests with
 non-volatile storage
To: harsimransingh.tungal@arm.com
Cc: u-boot@lists.denx.de, abdellatif.elkhlifi@arm.com, trini@konsulko.com, 
 ilias.apalodimas@linaro.org, xypron.glpk@gmx.de, hugues.kambampiana@arm.com, 
 sjg@chromium.org
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

On 2026-05-14T12:49:13, Harsimran Singh Tungal
<harsimransingh.tungal@arm.com> wrote:
> efi: selftest: add runtime variable tests with non-volatile storage
>
> Extend runtime variable tests for persistent storage
>
> Runtime variable selftests already cover the volatile-store path in a
> single run, but non-volatile storage needs state to survive a reboot.
> Make that flow explicit by keeping the existing "variables at runtime"
> test for CONFIG_EFI_RT_VOLATILE_STORE=y and adding on-request
> "variables at runtime setup" and "variables at runtime verify" tests
> for the non-volatile case.
>
> The setup phase runs QueryVariableInfo(), exercises create/delete of a
> runtime variable, prepares the persistent test state, and prompts the
> user to reboot and run the verify test. If an old test variable is
> already present, reuse it only when it matches the expected
> half-payload; otherwise delete it and recreate clean state. The setup
> path also performs a best-effort cleanup if a later check fails.
>
> The verify phase checks the prepared value, appends the remaining
> payload, validates the full contents, deletes the test variable, and
> [...]
>
> lib/efi_selftest/efi_selftest_variables_runtime.c | 713 +++++++++++++++-------
>  1 file changed, 481 insertions(+), 232 deletions(-)

Lots of subtle things here, but if it works it seems good to me.

Reviewed-by: Simon Glass <sjg@chromium.org>
