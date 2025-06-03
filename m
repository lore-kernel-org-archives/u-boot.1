Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B210EC5B552
	for <u-boot@archiver.kernel.org>; Tue,  3 Jun 2025 18:06:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A15882AF6;
	Tue,  3 Jun 2025 20:06:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zjLvW8Sk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F9A882CA0; Tue,  3 Jun 2025 20:06:04 +0200 (CEST)
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com
 [IPv6:2607:f8b0:4864:20::b35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 147BF822D7
 for <u-boot@lists.denx.de>; Tue,  3 Jun 2025 20:06:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-e75668006b9so5520020276.3
 for <u-boot@lists.denx.de>; Tue, 03 Jun 2025 11:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748973960; x=1749578760; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=jXGfsM875MjRhvyiNySx5Bdh4ZEh3kayK79Tp2ZH4jM=;
 b=zjLvW8SkjPTDHNaBpDltusHwedP4iywAX3J9eZrIOKDzsZZqI4yNp7EmMAvdo2RQ8j
 q7haZpRlJBAQ5TGkzwP6K2tiqxKc60E1B2OCjfLPu1x2fJN93aapu2qht+UyXzI0Hcfh
 ocqwRYm5e9iFTRKuq3hrxuA4oUhSdv61aaUXE8kHhgRgEJxYGTdk+rXUU1RClkoRenai
 dIx3b7cB6fkWTXO4VALfa6Kkp9CLDlEvoaWXl2lkP0S9xPBwC7R6uJ98Wtc9RbmUl5d3
 bKc58bZ+7kdJRia2mOtyzi3SboiG026fdHOKnQ7X9HrCm6z448HAuNa3LZP0ftT3OvAJ
 ogig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748973960; x=1749578760;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jXGfsM875MjRhvyiNySx5Bdh4ZEh3kayK79Tp2ZH4jM=;
 b=Qst0Ie/ZRVXCKgX8jf986iPSS5YqWT9TfJlB8lJiTnz9z9laA11/pvsCioY6oIN7Dw
 TqW5uWj8EFp3tKd7tiG/mPzr/J6YbPvmuyewk1w5/hi5PQLlNenxMDzpx8DOpi7bOYKt
 MFz7hWjwojUJ5Ntn3Gt0VHDU8LWrXicbMTQ/U1szagjdQBtoZYATTNO8Q6Ax6G+zr1zd
 vyvx8DoWVeQ36n/gj0Vidn748xpIMWLYYpFMFC9i8NwMhBvMPR1y27YxMBafnr7sF2ep
 bt5q0EHZPiw6JjtbpJS9doogcbUgARnAqfwFYlZQWL4mgFkxk1i8ce3EGJw1bRnB0bU0
 aIcw==
X-Gm-Message-State: AOJu0YxxSROcHZJNAthlQbpKYX0qXO2CyMNBvVQDqWwwpgqXVpB4/swr
 sSP74HwiXtdau014975RTB6C8JXDg1vx7PokTVvMQ6846U1q3/V9U1cWOxa83+TJd9dReuuBbln
 H+7Qf5h99Hmex9TxySjKdOnnG/pGWUVaYuHlaetkxJc3zs+CPagze
X-Gm-Gg: ASbGncuPB35O6kAZLJq+Bq6mzjSeFF25BWlU976nekskI5L6gPP0lZ1Fr47+TI41nK+
 2bnhe+mf1sR++rLsi18KfopD2y2z0YgBUnV4uYjnGFB3jIKMpFmOwRGcA4GtRvtBRtZKdZcsQxr
 ZXqPQyUQXyRZHEQkEq8whKrFT5TpX8dAKYqNP71LUqNzZM
X-Google-Smtp-Source: AGHT+IFrbLTSWKz1agybDoNKD6UNnB4+c8uZ2BWEhOSN5tj5R2rehj0CUzXaVa5tTChFrS8sE+yMoOwcYBpXKIU4HIg=
X-Received: by 2002:a05:690c:6f0f:b0:70d:f3f9:1898 with SMTP id
 00721157ae682-71097e6996bmr192464777b3.35.1748973959707; Tue, 03 Jun 2025
 11:05:59 -0700 (PDT)
MIME-Version: 1.0
References: <CAFLszThunmVcg_HnF+UJotswTvGj1uX2+huWJjQnKXysdrRqkg@mail.gmail.com>
In-Reply-To: <CAFLszThunmVcg_HnF+UJotswTvGj1uX2+huWJjQnKXysdrRqkg@mail.gmail.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Tue, 3 Jun 2025 21:05:23 +0300
X-Gm-Features: AX0GCFtUPekvmI4hJ3xc-haXjktPW3sYlkyEn868izd6_rvdBH1iYiOmkhBlyv0
Message-ID: <CAC_iWjJyG9Zm1mFu76rtdBAj-NZqnFCrjmFek0B7XOUpFZYz0Q@mail.gmail.com>
Subject: Re: TPM result
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Simon,

On Tue, 3 Jun 2025 at 18:22, Simon Glass <sjg@chromium.org> wrote:
>
> Hi Ilias,
>
> I finally picked up the TPM you recommended (LetsTrust [1]) and
> attached it to a rpi4 and used the instructions at [2]. It seems to
> work fine in my CI - see [3].

Thanks, I'll try to queue something on my next PR.
FWIW, i was running these locally, on the rpi4 with the same TPM. It
also works nicely in QEMU + SWTPM

Thanks
/Ilias
>
> Regards,
> Simon
>
> [1] https://buyzero.de/products/letstrust-hardware-tpm-trusted-platform-module
> [2] https://github.com/joholl/rpi4-uboot-tpm
> [3] https://sjg.u-boot.org/u-boot/u-boot/-/jobs/69998
