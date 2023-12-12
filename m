Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C674EC4167D
	for <u-boot@archiver.kernel.org>; Tue, 12 Dec 2023 13:17:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4577C8718A;
	Tue, 12 Dec 2023 14:17:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Odbe6awV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F16E86308; Tue, 12 Dec 2023 14:17:29 +0100 (CET)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 89CD48718A
 for <u-boot@lists.denx.de>; Tue, 12 Dec 2023 14:17:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1d0aaa979f0so32304885ad.0
 for <u-boot@lists.denx.de>; Tue, 12 Dec 2023 05:17:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702387044; x=1702991844; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pV5Gp7URmBgdZlgB+NS0fWIKJJH0TZyP4UHnyn2U4Eo=;
 b=Odbe6awVf6nlquXaR7jYiCRdzYW9y82rTIMRY1M8hjEBQ5QP20+SjgeZm0LMZt9pqD
 4NKhV/f+/srOLFojVGSJUpSJ++S54JTJB2mzMLuhcCiQy6dbFEGFIfljHWEbfQ6f+LRT
 aXA2NKlCUHx/6GO08LJOtZY5SueubMfLBaXy1kx7o+L0bJvUpI8MLXQKXTs1EAfkw2r7
 1PZdxWg4yyksEdAYC77sfH0lZs2ctS7PblI3dKKDlE894uUHPsuogA6kCuGUCY6QcpFy
 NgdqmW/2aI4aZFh8dFQU/vryFU23J68sgMLcF/EtDKqezRWxQDGUVb8CYQbQPLxSQQip
 ZKbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702387044; x=1702991844;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pV5Gp7URmBgdZlgB+NS0fWIKJJH0TZyP4UHnyn2U4Eo=;
 b=EmMYliCaOV4shY5nUvxFHQvb8hW34BR3mzww1sbDvyp5bkEgvaBaHuyedhNddHGDBT
 qEyRpGxJ9UEWGIY0o41PuGxwwhJXQVz5Cc0U63oNA4wiAxtH540nZNqM3Fpeu5tRXYBu
 db33Pgq/BJbDUqa0Bey3KNFSGKCybpDQI7h6SsD0l8FsW+5YuOXS8VkDMAyEJoTT3TuP
 NNzaiiT+17h/ENiE21rUkaJTBnfOeo8LySqXaU9ndIP4Bma6l7znEjkKBC4kmuzKSe9h
 wvQv4nlqHz3zFpUBCRxllxWV1XZyMcp/7z6SseQ/xk1dIQegDGJfn8wdxX9bZaqdU6hD
 35mw==
X-Gm-Message-State: AOJu0Yz/Cgn4NH/twNCBp1ApTfdDEtsn4n0SU+60d0ofKG1QxBBaGrww
 tb1BKcUl1RcjiEBoPdY2TG0go8S3/BjxTZgp7aE/uw==
X-Google-Smtp-Source: AGHT+IHrKKJNxGG2Ycq3daHAR/ppDGaJNoqbSGFvP8VsqSZAJGYDGCFHdiAyc2Zay8qQXpSPLkkdWwaFWwrDQNaw6MA=
X-Received: by 2002:a17:903:25c2:b0:1d0:9c97:6fed with SMTP id
 jc2-20020a17090325c200b001d09c976fedmr2664675plb.44.1702387043931; Tue, 12
 Dec 2023 05:17:23 -0800 (PST)
MIME-Version: 1.0
References: <20231130201352.6379-1-semen.protsenko@linaro.org>
In-Reply-To: <20231130201352.6379-1-semen.protsenko@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Tue, 12 Dec 2023 07:17:12 -0600
Message-ID: <CAPLW+4mTfBZ8+Kvh9R3LiyM+gqiYxqa5dtf=FDVwR5GZGh5xLQ@mail.gmail.com>
Subject: Re: [PATCH 0/7] pinctrl: exynos: Prepare for other SoCs support
To: Minkyu Kang <promsoft@gmail.com>, Tom Rini <trini@konsulko.com>
Cc: Andre Przywara <andre.przywara@arm.com>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de
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

On Thu, Nov 30, 2023 at 2:13=E2=80=AFPM Sam Protsenko
<semen.protsenko@linaro.org> wrote:
>
> Some Exynos SoCs (not supported by pinctrl-exynos driver yet) have
> different offsets and widths of pin bank registers (i.e. PIN_CON,
> PIN_PUD and PIN_DRV registers). Rework pinctrl-exynos driver so it
> allows for different offsets and widths of those registers by adding
> the corresponding API. That makes it possible to add the support for
> new Exynos SoCs in pinctrl-exynos driver.
>
> The main patch in this series is:
>
>   pinctrl: exynos: Support different register types in pin banks
>
> Other patches are just related cleanups and refactoring commits,
> required for the clean implementation of the main patch.
>
> Sam Protsenko (7):
>   pinctrl: exynos: Improve coding style
>   pinctrl: exynos: Extract pin parsing code into a separate function
>   pinctrl: exynos: Rework pin_to_bank_base() to obtain data by name
>   pinctrl: exynos: Support different register types in pin banks
>   pinctrl: exynos: Refactor handling the pin related dt properties
>   pinctrl: exynos: Reduce variables scope
>   pinctrl: exynos: Convert to use livetree API for fdt access
>
>  drivers/pinctrl/exynos/pinctrl-exynos.c     | 125 ++++++++++++--------
>  drivers/pinctrl/exynos/pinctrl-exynos.h     |  36 +++++-
>  drivers/pinctrl/exynos/pinctrl-exynos7420.c |   2 +
>  3 files changed, 108 insertions(+), 55 deletions(-)
>
> --

Hi Minkyu,

If there are no objections to this series, can you please apply it?

Thanks!

> 2.39.2
>
