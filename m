Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90572C43458
	for <u-boot@archiver.kernel.org>; Thu,  2 Jul 2026 20:05:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2F34584A67;
	Thu,  2 Jul 2026 22:05:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="L+1SIZgn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8BD6784A6B; Thu,  2 Jul 2026 22:05:06 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0EFF849F0
 for <u-boot@lists.denx.de>; Thu,  2 Jul 2026 22:05:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-6984169c126so4182833a12.1
 for <u-boot@lists.denx.de>; Thu, 02 Jul 2026 13:05:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783022704; cv=none;
 d=google.com; s=arc-20260327;
 b=QG+0+yDyOV0ZFf5HcCmDgl2J7bpJwYPmzthxohF3xNU3XFzdQ9CVPXFIx4+ffdGl+R
 Aaodz0WUbwvZWCIHDFqf+eAtiMXZ6VlLM9lX7u7Kgqe1BcBK8QlKZo8CdHKjkobeAkCR
 8IO7w9Z6jqhQRlSakJdaBpav+8HdEHuOcgpmYZP+avfNm35K28TRS9VFu7gZSfZYyWli
 jLKAE8E0qnM6HsMpMfXIbsJe2HsxhR4+lofJM+vSh9M1gSib9xd1AQtXipKaPLNrglpK
 4tFAnzlHligPZicTrqaN2i+q8XIIwy0GUXuC2h1zVn/19Qoh0J9wOqJnaTjdKNHmNuAl
 35og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=lCPCamKDz7DE1PgjAh6FHU2TcwAO3uhrJXXGvyqlfHo=;
 fh=cUvyJb4D+kj2oTP/PJL+Wph5jk5uSDSbTftJmAV/1Mo=;
 b=WhXon95qxIH9yrUszKe/Xf83d5VZjE/MwoKWA3bgU0WbUKvlpFzR40yhWu/vAwwrCe
 Ox7EF1bwZmdkC7CMCIsc2eoIDuxlwNvmu3KtVSHaFYjlvWmkE5ezgqlL/CPcg3yVq3uX
 pWsjOHCAghAKgTm0Eqv4BpbDA2mziCkwAvIoHNXjfuypQxv5YMuK7WST6i6jLQlzVAQv
 3OimFPHvj81hUUY8i1dqqk9bvQEGjr2khjvQKQJRWR13zx5LhThmXx9qf+95/niFKnB7
 gpxie6yOlb7tBkSd4soj7BihZMFtiSsbw2/RAWQOJ4KOPMlE9TUIVnUIO3p31NOB7sp8
 x3bA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1783022704; x=1783627504; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lCPCamKDz7DE1PgjAh6FHU2TcwAO3uhrJXXGvyqlfHo=;
 b=L+1SIZgnVzoCU4CFnGG2rG+9LVBbIhUR9l+fUFpn7yB+M0CvyJM0M9HcKT58OY/RdY
 iprcAt8feA7ZSoYHObVjekbmO5vShOyS8ey131vBr6Qrrs7nlFRsCna/E7c1vh0YY6fl
 3zvofcSBJIpDvK6clwRq/W8EyzQLlRoXssE+M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783022704; x=1783627504;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lCPCamKDz7DE1PgjAh6FHU2TcwAO3uhrJXXGvyqlfHo=;
 b=NqTDZYaEYw3T4GVn9cTyqD9u5mcUiLcgdkILUNrCnA1aS4ee4+buHaf1Z0AYwXrB2S
 MxdJrzX8BbhhVetpbfBNsH76J0MkDuJ7bltr4QReXsUJOBcVK4S1ZrOgU+vCKNCWyt4c
 mRfTMhoefHkiwwWXp5dm+oMGGPtB3RD/KGnSzXSD0zK+/rE2OjNfrnC3SRHmhoNyNi4N
 ytA2uHR9O41l3DBxxAZKq2BjfYu9m31EaiBQLxUYI97cDeoobVFYzO7eQOQfOooc5QYk
 h72W7eIka6g0XWBkmWAj97jWHxdfswV7UTUYjaC+m+g+AZZSjUT/b9EBAIewBa5j8amp
 Wrog==
X-Forwarded-Encrypted: i=1;
 AHgh+RqZ/aIlb4rwL5f4YQutKu0z0DDIxbjkMGN1IfUSIm1ythohZhurXTIfd0MsG41Mru++7+N/t0k=@lists.denx.de
X-Gm-Message-State: AOJu0YyS1zECySt4c4ZpkcYQ5d0eQ2PHHDUoSaCAH3I5oes94qNGg50o
 S1PcEEAhmNk2PbURSoQgiHbllLtgIw1EvVAtI19+/pnUnQkFEyHDp40KI6Cnlgk8Kgpe9YBFLus
 QZ5lVC+SXwt5L4mcsggigcVSd0bReKLosLKPp0mTI
X-Gm-Gg: AfdE7cktINWIo2Z9/FEpZTfYJ4Z4GQaag9M3qnaWfQAUP7nM8dq5EupULy6d4g/2v5q
 OgBiIa9X5nbDLC6HTF8Be2aQY0HQ+XqG0jEE69gx6rl8yzlttcLrLi7q022DEv1G8VhS5A/zyq8
 mYQmCcgS16oQs0TPiZlkJUcO8Tnoxw1w/NoZE7oEYglDV6avsrZmETZtLdJHAjz+Dy8JHxnA73O
 VZyYTVfM1ydTuWbxo1HIpX7Is4XrUATWKQ32BETZpvUJgK1fLrBFgt1RZ9P0iF8iHsDh2ACIdH/
 LmfvFzkZ
X-Received: by 2002:a05:6402:5242:b0:698:52b4:c2c8 with SMTP id
 4fb4d7f45d1cf-6989f374a6dmr3913057a12.34.1783022704060; Thu, 02 Jul 2026
 13:05:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260625-tristate_fix-v1-1-95e16153d752@ti.com>
In-Reply-To: <20260625-tristate_fix-v1-1-95e16153d752@ti.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 2 Jul 2026 21:04:49 +0100
X-Gm-Features: AVVi8CdHBemV85vij_24H1xlHuBRW43HjiwTSvDYoP8YE0Qqq_E-n2R2erGg0to
Message-ID: <CAFLszTj4f3SUdsf19JEenHJai7L9cPN_68gJjPbMHOPfqfKusA@mail.gmail.com>
Subject: Re: [PATCH] treewide: Kconfig: use bool instead of tristate
To: anshuld@ti.com
Cc: uboot-stm32@st-md-mailman.stormreply.com, u-boot@lists.denx.de
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

On 2026-06-25T03:17:06, Anshul Dalal <anshuld@ti.com> wrote:
> treewide: Kconfig: use bool instead of tristate
>
> U-Boot does not support modules, so having tristate options is useless.
>
> Therefore this patch does a blind replace of all tristate options to
> bool tree-wide.
>
> Signed-off-by: Anshul Dalal <anshuld@ti.com>
> Reviewed-by: Romain Gantois <romain.gantois@bootlin.com>
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
> Reviewed-by: Heiko Schocher <hs@nabladev.com>
> Reviewed-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> Reviewed-by: Neha Malcom Francis <n-francis@ti.com>
>
> board/st/common/Kconfig      | 2 +-
>  cmd/Kconfig                  | 4 ++--
>  drivers/cache/Kconfig        | 2 +-
>  drivers/clk/Kconfig          | 2 +-
>  drivers/firmware/Kconfig     | 2 +-
>  drivers/i2c/Kconfig          | 6 +++---
>  drivers/i2c/muxes/Kconfig    | 6 +++---
>  drivers/i3c/Kconfig          | 2 +-
>  drivers/i3c/master/Kconfig   | 2 +-
>  drivers/memory/Kconfig       | 2 +-
>  drivers/misc/Kconfig         | 2 +-
>  drivers/mmc/Kconfig          | 4 ++--
>  drivers/mtd/nand/Kconfig     | 2 +-
>  drivers/net/phy/Kconfig      | 4 ++--
>  drivers/spi/Kconfig          | 2 +-
>  drivers/ufs/Kconfig          | 2 +-
>  drivers/usb/cdns3/Kconfig    | 6 +++---
>  drivers/usb/musb-new/Kconfig | 2 +-
>  drivers/usb/tcpm/Kconfig     | 4 ++--
>  19 files changed, 29 insertions(+), 29 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
