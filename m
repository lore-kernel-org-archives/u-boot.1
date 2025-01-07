Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DCD0E77197
	for <u-boot@archiver.kernel.org>; Tue,  7 Jan 2025 15:30:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD97F801FD;
	Tue,  7 Jan 2025 16:30:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="O/MPeqrZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66A85801C3; Tue,  7 Jan 2025 16:30:47 +0100 (CET)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com
 [IPv6:2607:f8b0:4864:20::1029])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C135805EA
 for <u-boot@lists.denx.de>; Tue,  7 Jan 2025 16:30:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2ee50ffcf14so20476816a91.0
 for <u-boot@lists.denx.de>; Tue, 07 Jan 2025 07:30:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736263841; x=1736868641; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=10lWihv3LAjy5FA2QzzRIGzBdPEcOeUpXdQznN/BKLo=;
 b=O/MPeqrZWwe4OXnhDFjvooaBRjgSnWEwWtUrmGYwoHmkH0GIPYYHhz3s+grEUTqPO5
 b+Us0BEC3V2fV1m3xlPf1bqRWsLfXUD8BgSZ9kVmUSTjUcFhTwWa2+AxgUwmaFmNrWwE
 ZVMg3Jb0a7imFvUzcq3iVMofPAImoKqTV0sko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736263841; x=1736868641;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=10lWihv3LAjy5FA2QzzRIGzBdPEcOeUpXdQznN/BKLo=;
 b=BNvU5G337nKVPBB9myyz9e1QriBaSYB04UnH3ucjNeJ0M8sW5beN2ZsBcr8VKnATYm
 PhB4wExNjxYT1ZeNsKraflZspuMLIo4GmlvPmZh3HAO7ZtjvqhEcWctO5JbIE5cOWC3s
 vpQPBfom5wUExnVYTL0KORQqC36p5JNFgT13hSUGmieMp+rnGPH43U4JA45Inua7sYCz
 uoyqn64Y9frXhCNfmeC1JyTzYvhB3AcL2+7ZPPdPp7M/pl9wLrSosgabwy2laibtqzln
 hCzCPcUVhLKNZKIGHg8vGJ1vVUqdk+3SDpNQt6Dowi7C3cJmYqaAC2NepSTFNIxh9u+H
 bOQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUAbTADY/uUtI9uVYe5PvqIcF3FWjNQh/nVm8OlzJ0tFwdLgdmNzvTISPXgTQcUooFgBRFyLEI=@lists.denx.de
X-Gm-Message-State: AOJu0YwZZzcFFRSj/jgFjN/a6SnvMTr6AF5wtRIWH+pCA2FGigc2YJLY
 zomE3jSpjisk+03eesu0Wxa5g7V40ymLFCCPICDV1a8IBMXr7U0I+golGncpNTslcGJUcpmcKc9
 c4s5VFkKmfskOulxUZ9I9VucTUj87LQuy18Zj
X-Gm-Gg: ASbGncvKZ3iC/nKcJFEaBtU5vL+M1soZ9Gq8zR2FV208dVsMp4Qr/0QlEctkU9Yni0a
 Sei1eRhJJ2qseQtxQYw/+LfO7awspq39ABfS5DVk=
X-Google-Smtp-Source: AGHT+IGDTzdd6VHGhtvritncwQwPPwGc+TuKWXJEsG/Yu8v4HF3w2zVPm59qq5/rJ4fb0LiMvBSKsf+CP4y+RWoDfgw=
X-Received: by 2002:a17:90b:2705:b0:2ef:949c:6f6b with SMTP id
 98e67ed59e1d1-2f53cc6e0e4mr5364083a91.13.1736263840659; Tue, 07 Jan 2025
 07:30:40 -0800 (PST)
MIME-Version: 1.0
References: <20241124-b4-modernise-smem-v1-0-b7852c11b67c@linaro.org>
 <20241124-b4-modernise-smem-v1-1-b7852c11b67c@linaro.org>
In-Reply-To: <20241124-b4-modernise-smem-v1-1-b7852c11b67c@linaro.org>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 7 Jan 2025 08:30:21 -0700
X-Gm-Features: AbW1kvb1dJTXeFHckkZ53MhBkfnCNay0CirEKSNQpPiiy8JiA2EeawJCaeBR-Eg
Message-ID: <CAFLszTj7R2HnVxQFukOB4MU5fhrXE8gMG2s6cwefh9FyXSbA2w@mail.gmail.com>
Subject: Re: [PATCH 01/15] Revert "dm: SMEM (Shared memory) uclass"
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Sumit Garg <sumit.garg@linaro.org>,
 Mario Six <mario.six@gdsys.cc>, u-boot@lists.denx.de, u-boot-qcom@groups.io
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

Hi Caleb,

On Sun, 24 Nov 2024 at 12:17, Caleb Connolly <caleb.connolly@linaro.org> wrote:
>
> SMEM is a highly Qualcomm specific interface, while having a dedicated

Qualcomm-specific

> UCLASS for it offers a nice abstraction, for things like memory layout
> parsing we need to use it before the driver model is available.

As mentioned on irc, could you explain why that is, i.e. why not parse
the memory layout after driver model is up, but still before
relocation?

>
> Therefore, it doesn't make sense to fit SMEM into the driver model.
> Instead let's adopt a model closer to Linux, and parse SMEM really early
> during boot (as soon as we have the FDT).
>
> This reverts commit 7b384eccc785b596f68448b155cbda26df57fb23.
>
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  arch/arm/Kconfig           |  1 -
>  drivers/Kconfig            |  2 --
>  drivers/Makefile           |  1 -
>  drivers/smem/Kconfig       | 24 -------------
>  drivers/smem/Makefile      |  7 ----
>  drivers/smem/smem-uclass.c | 46 ------------------------
>  include/dm/uclass-id.h     |  1 -
>  include/smem.h             | 90 ----------------------------------------------
>  8 files changed, 172 deletions(-)
>

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
