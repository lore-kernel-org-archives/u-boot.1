Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41D5ECD8C9D
	for <u-boot@archiver.kernel.org>; Thu, 11 Jun 2026 18:14:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A6C318407D;
	Thu, 11 Jun 2026 20:14:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="kU21+aau";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9042284671; Thu, 11 Jun 2026 20:14:04 +0200 (CEST)
Received: from mail-yx1-xb12c.google.com (mail-yx1-xb12c.google.com
 [IPv6:2607:f8b0:4864:20::b12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F254F839A8
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 20:14:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-6606678420bso150604d50.1
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 11:14:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781201640; cv=none;
 d=google.com; s=arc-20240605;
 b=iyJEqvszfYJVcO6pFSnkpftxs2KHdP8lI133tPY0aYebdO8hd0X+/N2p4mKQpV5Ff4
 smv4ccIEQWfNqNc2ijUXwI3LJOiK8a+tR0M5JKe7qu8wHSsGDqcC1nORvBPUsuXtZ+tH
 ORJQhG13AOz21GIm6e3GEKsC8dGX3pkpe3zJpolRmXTPahdB1nnpATYFtVl0KneCo8p5
 lRo02GH2i+cpcLK67S3BGpeFI5AbHlA1r0ltgA0N5Ox4g/uMSwK/xaSPo7wNB1XFDGI2
 72ZF8Uodssk8g+4iWthgUfJFUY2mTSo3BBp/VsbSVWL/An9Pvxzmm2zW1AsdlUE5T8Ul
 wvbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=5D7/RxLLBFpvnrQugqaaYcX/Pu+88b3SLIhagiL1nEw=;
 fh=F1g9JCAMPZIsmmAfp/vapo88p6hpnQuU8mOv+m+nz5E=;
 b=hoRa3LJ5tQkCKjDO7UilKZLQuKv+ogjZWrfYOuYLoy/T84XYrPAnAn0iyMfZ7iRKH9
 nyRvABlvFgDSX+RKIHeM7w+63Q9mkiV1f6q510/d3FEPKTFdvh2mqg1KuSq499Y0jA3I
 bZDy2714jFqJn8INVNnirN/LpFOaAKsdu6LW2BdPbu72tujGuY0A18CO0eUsiXdnSh3Z
 MUfLU5WhZZsh35rrL+MOWc/xalF8fq14WKsjHAY1OIt4cPPiWXrjLFFYyaWkgT0+uCqW
 lPM4YAlP3a+UehiFOotyqk7hGiBnp8OuZyROMJI16FbbptDDsByzkIqPDHOmdelAOi0h
 Q1Dg==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781201640; x=1781806440; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5D7/RxLLBFpvnrQugqaaYcX/Pu+88b3SLIhagiL1nEw=;
 b=kU21+aauJ/097Gf5zXo3ZwrabS4d3/U8ZIM0/9XJHCVrFLGPzcxhRCdK+yUUo8+m2f
 RAysbEgyghqzsFSzr4W7HAbwPUzuFL0iYdScX0pwx5TloxD+UHg0XvGDzGYjmzBdbA5u
 Yqli6P7700hb7JRXbsSQi4h8kJgVZRHR23hjLDtwzlJmLlQdYnyg9EELuCT92xPzLKkp
 Qu79Df5JQtqft4qiXX+/koZziLYC/VqoA0wPrd0F+scvLo8Eiz37XmCRmZgwAseQ3NDC
 KE76r9FTK3pgR9tVRAWHmwDNYrM6zcZfqs1D7obF7sCbyrVsAG+FEGa1t04h0oTbcxSW
 42DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781201640; x=1781806440;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5D7/RxLLBFpvnrQugqaaYcX/Pu+88b3SLIhagiL1nEw=;
 b=o3I9LSngANfkhOWQdeLGgB3OTEMwslfa/KTWxyody5K+butgsKQn4Z88fjGKfxNZ4b
 GTUYdJLwSCJQeqNZrRDL4AJ0McRJjjWlFs+sN+/3h0uc7P03Lto4REutZ6NgkPrRhKLZ
 f1aHHke+kAZ9UqZvOOkhhwxl2p2M8mtKwdu8yzDqxTuFfMpsDRVw17u6qT4d8eXAn+g4
 SqZhY/zWtnN5Hi5bZK0FOPoOy3sCjjdir/41dLAbl5wP45uceLIAIfU9KIwdV+tiy1My
 sHpOjlN78CDgMknSzPcFKn480So36lO8FE4hdLFGBoBfovrpT6GSmRoiJd4q87ife73s
 qtRw==
X-Gm-Message-State: AOJu0YzxO+JbTXwzoBIOXNoQfklv4OdBakhAn/FvWJph6Gni/mj/Fg3V
 aidUAWA+fHvyO12Xe9UtJ7q7QFLqGiEypjGl8AxoEduMqh5wRuR6dyxHYl76zLkMg/A4edE4gVl
 dITL6rO91HRlkSLvOFTzt3xm1OqzY9vK+zdbrCTvXUg==
X-Gm-Gg: Acq92OHXeNNj4tk+oeM60QmAHejZaS1O3Kc+rGAOXTIN9CQsG/iI5zl/JzDEhSa4JW4
 E3kUWlm2B4VoYXiXsJ96ceQwURL8plUKgg+8LVW4ubaPnjJVsKEnEzOsthXWFJz1Y/gJnB0yZ6/
 YTaByCAeThQ3f5ZTQbmHVnVYW0/YdpW0QyKpZiYoSyU9YubU7C8D83kJnCTPb9XxhRSQVCVEUjA
 Bc7YFkNCOoQUNTevNRLUmqgLfYw7z1X1TqtE2osoq5t0v9OW5TZqnJ1XXIMEYSsvRKediuYXKYH
 6o3tlwx2swikXYFa4piObmPNQbaI9HYFlToPOBA0dz5o3q83Q0OjqQmLaCVtbs+uROdLKQV0t0B
 M9++OdaTiFtJzrhycthQ4a2SGYXrW1oY5qrMxEhygeDKfOBkTDAMgJ0l/4UdQv63P/LbNaaCdy/
 9C0DYEy7mpk0pKHwBj5SNL/EHSQmdftursUbg+hD8yPjj18kgt4DIa9pQbtsDkiugvTE9gSosHw
 jgPiXKvyvttUyb9Y34GU2vKWvP7357OYGgqnDmVNUlh+Y4W9xeX9W7NAXfmTBfOvXKqdGAE5ZO5
 kH3p6aINiQmlvjm4qDqaCkE3LvrjOzj+KL+RY/D4AkpKuAqlny4k0eO2/3kdf/72y3l4fc170lV
 Qlfr7bbg=
X-Received: by 2002:a05:690e:484f:b0:661:75a5:3b9 with SMTP id
 956f58d0204a3-6626999f1b7mr2297861d50.53.1781201639515; Thu, 11 Jun 2026
 11:13:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260610105243.193355-1-ludwig.nussel@siemens.com>
 <20260610125204.v2.3.db7fbeb8b6e8499f4d031c04cb5cd8175873b643@changeid>
 <CAC_iWjKN4URBGikcEeTHp7dQPf7QasESmPOmys9piEnsVt-fWw@mail.gmail.com>
 <500e420f-ccad-4b61-b7f9-e4cb3ed8ac86@siemens.com>
In-Reply-To: <500e420f-ccad-4b61-b7f9-e4cb3ed8ac86@siemens.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 11 Jun 2026 21:13:23 +0300
X-Gm-Features: AVVi8CdmA49TVchy7ZURBOnsdJh4mfGzvPYapuGfZ2PESjKYvRekza3bd2F1e3Q
Message-ID: <CAC_iWjJO6ZK8RCmq4Cu1Z+pr-61m9idDVr2D+cSo0+ceBUviQw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] tpm: allocate tpm event log if missing
To: Ludwig Nussel <ludwig.nussel@siemens.com>
Cc: u-boot@lists.denx.de, David Lechner <dlechner@baylibre.com>, 
 Heiko Schocher <hs@nabladev.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Peter Robinson <pbrobinson@gmail.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, Simon Glass <sjg@chromium.org>, 
 Sughosh Ganu <sughosh.ganu@arm.com>, Tom Rini <trini@konsulko.com>
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

On Thu, 11 Jun 2026 at 19:21, Ludwig Nussel <ludwig.nussel@siemens.com> wrote:
>
> On 6/11/26 11:57, Ilias Apalodimas wrote:
> > The CI [0] fails with this attached. You can run it in github by
> > opening a PR before v3. Also can you update the description and add
> > the use case you mention in the cover letter?
>
> Done. The hardware tests are still pending but I've fixed the qemu
> failures: https://github.com/u-boot/u-boot/pull/985
>
> Is it advisable to file a pr in general before submitting patches?

Yea, it makes reviewers life easier. I will run the CI regardless, but
it saves new versions just because the CI failed.

That being said, I had a lot more feedback in v2 than the one that you
just fixed in v3. Have a look at the comments and let me know if you
need anything else

Thanks
/Ilias
>
> cu
> Ludwig
>
> --
> Ludwig Nussel
> Siemens AG
> www.siemens.com
