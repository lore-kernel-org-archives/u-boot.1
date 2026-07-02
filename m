Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A458C43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 20:04:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CD5384A3C;
	Thu,  2 Jul 2026 22:04:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Mr+dFCiJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 77C9E84A3C; Thu,  2 Jul 2026 22:04:09 +0200 (CEST)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4548584A67
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 22:04:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-37d82f3a244so1992783a91.2
 for <u-boot@lists.denx.de>; Thu, 02 Jul 2026 13:04:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783022646; cv=none;
 d=google.com; s=arc-20260327;
 b=iHVu6SXUi5ysM6Ax4XORcsxd8dvsow0CwolwvxW8/9mjviS53c3vdgCuwolzO60E5A
 Y53rx1jIu7alS5J2f2RssPuVmidBx5XrJsexIgQC+I29/j2RtN5cfb4pF0gfz60CK5u1
 lnJv9NFwiRkC2WAjYz4KAtNYt6JzN9Ztgx90VE1PnWSgW5ZVqPsC/GAs2esw9F4jau4v
 jHHmyORIdGPiPTUIi3Yo/qTPnVXKNPiQ9OMHpveEzAFwIBQxcphAnlL750aJz8YBnr42
 by+1/OLcMCg3rG6x2FkBdJun/rwkspXhOXF7oNDoAT3f858KkYzLDLyua38+KepSxfHK
 0GVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=nWDW+xlDl8347ncri3k62fYd5t7H8qrQWYN34SykmU8=;
 fh=rg5gh2IKY/qV5ZxZUxmtyRvQx7pq5k0tYzogIrTcUiQ=;
 b=pdoz2x7BXXs5cPo/bGVxfnM4X9azhClfSZehP13cR1WJQK6EESnW9GuXsgaJQ3eo6F
 HBwep1oYBABSwOUBfreo6sFOnVEsidHD+usXTHg6kB6+Z5bFAiRebrYjomCfIck6Gyry
 hsBYXqjaTq1FXsKufvMgD4a37k9BxZ9bG69krTSdAtyh0r/PbmecwwdlhPkZaco3eAx1
 SJglFF1d8P0rphF36sS6bZzmgQGxCwF5FhsangQ+fF4lI9dpRQLb5RZEy+2D7J2xTJ/s
 BZxVLjmm4FIKkfpt0XGV4Qy7ePjiAsm7Atd3GrmmqJCR/REV+BEfyYfPREW87mTgv6jw
 BxgA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1783022646; x=1783627446; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=nWDW+xlDl8347ncri3k62fYd5t7H8qrQWYN34SykmU8=;
 b=Mr+dFCiJsylHmQryHrkZhkHjmiLGw/sWxEgefeeDqNwFrB5yv1ngDDfCtcznBRWf/Q
 qp8Z/AkeySQQhEKjdZNApRumOElYUgOlnlhSuPLFePn1szveX01Di0/JkqeExYYcpaeg
 LQFDXKQsPMYWP0Sx+YdfEGihFrLREJ+j2sKuk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783022646; x=1783627446;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nWDW+xlDl8347ncri3k62fYd5t7H8qrQWYN34SykmU8=;
 b=f/UsZ1i4uUp21leP2YJ70DLBok3U5TyLXIK2L1QkfKjFpj81O/ty87TCu19YcMPX4C
 /fPVEuG3pci57u5caBTxcpnV4x/R7bPM2olIFDzWH0FC+g7DfMfZNKVCOKcAUNstcmM+
 76dz/UcNhu7SyNqilt3WdAMHanwji1OVLbs6gZqjvCzC0gKlCHgR0ItQCmfJIzh/hpAH
 FBD8TcaU2WK+eOdbSmS8/cdTG68pH6N/XTgTojDRUo8e52XhAktbE9Ap3M7ZJjnaC6wD
 fw290D42312wvMQRAj3U/sIrumdZnhxMrZOmef85T4Buez9w+71PnFzxYVPsTWUa/OCn
 Mt2Q==
X-Gm-Message-State: AOJu0YyZKUMXioU4jxfyV+Dlf36/rq1QLWzilL1mTxC1xbUipI7km+Cq
 jYkL090oBk6/D59SaSjEaAMRSrqjNqMA8LEfxGj6l/X0XVo4tELI4iNOspSBpHeAoKO945437vm
 4GQC+4Dmv+UDHvyP1KCstLqmnru3KF7dbS9Ck6710
X-Gm-Gg: AfdE7clngRf288jesLedOe6bzap/t06CRxCHjy7CkNqc5t5t+nWcjK/LSMyBgh3ERyY
 pYy9H6Ad4oNW+G5zfIzl2YHLeYn/Wlf3+ZW/p9gtP7y3IXKcyX8uDT7SGs+GBi7iTI4y/OUgMBG
 LO7kdYLwLiVb79tK0wOvYvAFVwTkE66DVbYIuyEVd761+ZNxgg3243+NBWdf1uBwcPdfWGSAX0I
 ryAhv870WexnTGr2wskmDtpdGY43jul2xf8ePI3xDKk0Fz5RN0TJsL2AJpe8IsJ2e3Ac57znA==
X-Received: by 2002:a17:90b:3a45:b0:37f:9cdf:f0ac with SMTP id
 98e67ed59e1d1-380aa234f58mr7282076a91.27.1783022645614; Thu, 02 Jul 2026
 13:04:05 -0700 (PDT)
MIME-Version: 1.0
References: <20260702014724.1534351-1-james.hilliard1@gmail.com>
 <20260702014724.1534351-7-james.hilliard1@gmail.com>
In-Reply-To: <20260702014724.1534351-7-james.hilliard1@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 2 Jul 2026 21:03:39 +0100
X-Gm-Features: AVVi8Cd6puMbL0xBPMenewAQ1z-OWu2BOizUvKKDpBddnSiwIfqNekASyzMmag0
Message-ID: <CAFLszTh4Lo9_ZXfjv5HfWmTUtKw7hosPHWqKYM8k2B6nnue=3w@mail.gmail.com>
Subject: Re: [PATCH 7/9] crypto: allwinner: add sun8i-ce AES driver
To: james.hilliard1@gmail.com
Cc: u-boot@lists.denx.de, Andre Przywara <andre.przywara@arm.com>, 
 Chen-Yu Tsai <wens@kernel.org>, Samuel Holland <samuel@sholland.org>,
 Tom Rini <trini@konsulko.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Simon Glass <sjg@chromium.org>, 
 David Lechner <dlechner@baylibre.com>, Peng Fan <peng.fan@nxp.com>, 
 Julien Stephan <jstephan@baylibre.com>,
 Kory Maincent <kory.maincent@bootlin.com>, 
 Kuan-Wei Chiu <visitorckw@gmail.com>, Raymond Mao <raymond.mao@riscstar.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Stefan Roese <stefan.roese@mailbox.org>, Ion Agorria <ion@agorria.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>
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

Hi James,

On 2026-07-02T01:46:51, James Hilliard <james.hilliard1@gmail.com> wrote:
> crypto: allwinner: add sun8i-ce AES driver
>
> Add an Allwinner sun8i Crypto Engine driver using the same directory and
> driver naming style as the Linux sun8i-ce driver. The parent device owns
> the shared CE registers, clocks, resets and task submission path, while an
> AES child exposes the standard UCLASS_AES interface.
>
> Support AES-128, AES-192 and AES-256 in ECB and CBC modes with
> software-provided keys. Process direct DMA-capable buffers in 128 KiB
> chunks and use cache-aligned bounce buffers for unaligned heads, tails and
> overlapping cases. CBC keeps the IV chain in software between chunks so
> each CE task can run on a larger contiguous range without losing chaining
> state.
>
> Model the H6 and H616 compatibles after the Linux sun8i-ce variant data.
> Both variants use byte-sized cipher task lengths; H616 additionally needs
> word-addressed descriptors. In SPL, enable the shared H6-family CE clock,
> bus gate, reset and MBUS gate directly because the full clock/reset
> uclasses are not always available there.
>
> [...]
>
> MAINTAINERS                                       |   1 +
>  drivers/crypto/Kconfig                            |   2 +
>  drivers/crypto/Makefile                           |   1 +
>  drivers/crypto/allwinner/Kconfig                  |   3 +
>  drivers/crypto/allwinner/Makefile                 |   3 +
>  drivers/crypto/allwinner/sun8i-ce/Kconfig         |  39 +++
>  drivers/crypto/allwinner/sun8i-ce/Makefile        |   4 +
>  drivers/crypto/allwinner/sun8i-ce/sun8i-ce-aes.c  | 407 ++++++++++++++++++++++
>  drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c | 375 ++++++++++++++++++++
>  drivers/crypto/allwinner/sun8i-ce/sun8i-ce.h      |  61 ++++
>  10 files changed, 896 insertions(+)

I'm going to leave this one to Andre :-)

Regards,
Simon
