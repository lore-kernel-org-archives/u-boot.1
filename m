Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC9EBCCF9E0
	for <u-boot@archiver.kernel.org>; Mon, 27 Oct 2025 06:03:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4381A82A9E;
	Mon, 27 Oct 2025 07:03:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="IbUYj4ji";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF3C982C7F; Mon, 27 Oct 2025 07:03:39 +0100 (CET)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D6FE80422
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 07:03:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-78488cdc20aso54106707b3.1
 for <u-boot@lists.denx.de>; Sun, 26 Oct 2025 23:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761545016; x=1762149816; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3h1jKY5jG6GySfl+DiGwAXtMQ5CIpfbYO1B6aMB+/e0=;
 b=IbUYj4ji3OhvwYXOUNdXYPpSfvDSLAkRLH4ezsF+SZ9xF/g9KfZ6tGBpC8/2w66OYX
 gBmOQdO0NtyVmr/Qe3QM2328MVg4WCrfV2o8IRJj5jQMWvOWxE54AXHL1sxCLCmjGKkm
 cNfhME/Zq3lwIHMgg3qp2Uyvf/ULLbjKtEae0bSfIKBsZDtJXVtuAdEM5i40iR3rQVBZ
 GtA1MdKYmwRawuT/GUfLGhk5wFze2+A3qBk+M5DfvQlVHklxslxXqDQLvBYbXK5cNUvZ
 YgnqYPFua3EV/AeKzydWyflKUiNZFLEJBpi+hrD4A1WJmdUmneTyyim/sEjvuP5MwUOn
 alTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761545016; x=1762149816;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3h1jKY5jG6GySfl+DiGwAXtMQ5CIpfbYO1B6aMB+/e0=;
 b=ETHh4SaDNpLahhXdJo+0o1lHsMzBv+ujZXk267nFQyW308swyd8Y9TNSc34O0X2dcz
 uJDqfK9SenWiOuHDaoac8YHjXqSQriqNGyR1JGClp2h5yWFoPd+IuHFppWEGmlugmVwJ
 B8Ln+N8Y5WG0NnGlrp4QgIOiYFsr+rYx2uIEjAeQE3CdYZXruJfmH3bnCjnvCfkQy7rN
 sevRZ0iS01kboMf+FdGJXS5yU0rYBvrTWes0qGLo4Sy1REpTL7f5qrkv/JrAuiVWuCEP
 iBwgcHCv3GAeMwY7J+NeMvoY2HOkEYiNCoH2HyzkZt7dFfHbRrM4kVmix3/M39o0dqJE
 Oi2Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZD6AK1v9DoYnMJ+O44xssXAmqG6eMWGVIokkMiUg+kmqM3bsGPLabkJWTdDaM+gzbu2DIG74=@lists.denx.de
X-Gm-Message-State: AOJu0YyXsDwjIXKL2ohIcI1+UIKz1CvFRl7TevndZuXSsF7IQ5Gtz+z9
 uDdzZLeA4erQyIyMCDpKm5aRWHhlOJ8ui7DnIccPGiLX9qngK6Uun6Fmc45VBKLwDz69VhDTbUQ
 98Xk7W5Tl67IsxdZijFUdQrIUd1ONQiVRzBvMmlI8XA==
X-Gm-Gg: ASbGncuCLDUX2OK4wMQTOE8ZZLoqtnfdYSNx3zJRQTEG6oRkvmYu6KYcBd6SjKNcV73
 xXlaeFQZdNEiRN2GbDFsMLoDIoSu5UjQf4nB01VO1tWZALppp7ZKBI1e4di1NUGZaOoDj8RVj06
 Yi98eNLiB8yK71HzK2popvGw2MgvLYiCGGePZvYx3ElMLd/0vClrfc+LqVk1zmbZk65zqoFzgME
 wGiCOe32dw2fGB2orq468nYajwDaGNvMVmThT9Jqp4wpdc1dKqQYLQvDhkdG8RgvwZBGEfpmm32
 CNd4pmAiemY8naugwZi+lMCPEqPiw36SVeSYfu1+
X-Google-Smtp-Source: AGHT+IHhrzZqDE4lwKbZKS0FhPCuJ65EKYbP33+ox0di8V29STHWsqnqxot3qHWyfbOCxR30TZfqliAft2y2lE3xLOs=
X-Received: by 2002:a05:690c:4c08:b0:783:7143:d812 with SMTP id
 00721157ae682-7837143e14dmr286838907b3.1.1761545016278; Sun, 26 Oct 2025
 23:03:36 -0700 (PDT)
MIME-Version: 1.0
References: <20251027055105.720-1-semen.protsenko@linaro.org>
In-Reply-To: <20251027055105.720-1-semen.protsenko@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Mon, 27 Oct 2025 01:03:25 -0500
X-Gm-Features: AWmQ_bmXuvNQF4wlLqCD2k00yJS25bDMoR5w1c_JufqtRD3MtP4_Hc762u2AyCg
Message-ID: <CAPLW+4mRPNoW=mqZyG1cSJXYuwmS=FwCajoAtNjQp5sppmE7wA@mail.gmail.com>
Subject: Re: [PATCH 0/5] board: samsung: e850-96: Support USB boot
To: Tom Rini <trini@konsulko.com>, Minkyu Kang <mk7.kang@samsung.com>
Cc: Peng Fan <peng.fan@nxp.com>, u-boot@lists.denx.de
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

On Mon, Oct 27, 2025 at 12:51=E2=80=AFAM Sam Protsenko
<semen.protsenko@linaro.org> wrote:
>
> When U-Boot is executed during USB boot [1,2] on E850-96 board, two
> issues happen:
>
>   1. eMMC fails to initialize
>   2. Attempt to use USB PHY driver leads to abort
>
> It was identified that issue #1 happens due to enalbed Flash Memory
> Protector bits in MMC block registers during USB boot, and it's handled
> in patch series [3].
>
> Issue #2 on the other hand happens because ROM code expects the
> bootloader (U-Boot) to download remaining binaries (LDFW and TZSW) over
> USB using SMC calls. Before that, the access to USB blocks (USB PHY and
> DWC3) is disabled, probably because corresponding TrustZone domains are
> configured for access from Secure World only.
>
> This patch series implements downloading LDFW and TZSW firmware over USB
> during USB boot, which makes it possible to use U-Boot for flashing
> images to eMMC using fastboot and DFU protocols. That in turn simplifies
> the U-Boot development, as one can use `dltool' [1] to run U-Boot binary
> during USB boot, and update U-Boot on eMMC this way (e.g. using DFU).
> It's not possible when using LittleKernel bootloader, as it expects
> non-standard Samsung GPT partition, but in case of U-Boot we use the
> regular one.
>
> Once this patch series and patch series [3] are applied it'll be
> possible to use U-Boot during USB boot. The two series are independent
> of each other, and can be applied in any particular order.
>
> [1] https://gitlab.com/LinaroLtd/e850-96/tools/dltool
> [2] https://docs.u-boot.org/en/latest/board/samsung/e850-96.html
> [3] https://lore.kernel.org/u-boot/20251026010658.19271-1-semen.protsenko=
@linaro.org/
>
> Sam Protsenko (5):
>   board: samsung: e850-96: Keep public functions together
>   board: samsung: e850-96: Add routines for checking boot dev
>   board: samsung: e850-96: Split LDFW loading and init
>   board: samsung: e850-96: Add routine for loading images over USB
>   board: samsung: e850-96: Load firmwares over USB on USB boot
>
>  board/samsung/e850-96/Makefile  |  2 +-
>  board/samsung/e850-96/bootdev.c | 99 +++++++++++++++++++++++++++++++++
>  board/samsung/e850-96/bootdev.h | 23 ++++++++
>  board/samsung/e850-96/e850-96.c | 65 +++++++++++++++++-----
>  board/samsung/e850-96/fw.c      | 75 ++++++++++++++++++-------
>  board/samsung/e850-96/fw.h      | 10 +++-
>  6 files changed, 239 insertions(+), 35 deletions(-)
>  create mode 100644 board/samsung/e850-96/bootdev.c
>  create mode 100644 board/samsung/e850-96/bootdev.h
>
>
> base-commit: fd976ff3a233ae7c6a9f5bec790b02bbbf57bb24
> --

Oops, a minor mistake was found in this series. I'll send v2 shortly.

> 2.39.5
>
