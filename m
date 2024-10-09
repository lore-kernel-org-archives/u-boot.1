Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D43BCF042F
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 01:59:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7729B89155;
	Wed,  9 Oct 2024 03:57:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="h2hGB1WZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 909758914F; Wed,  9 Oct 2024 03:57:35 +0200 (CEST)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A2FD885F4
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 03:57:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-7acdd65fbceso494283785a.3
 for <u-boot@lists.denx.de>; Tue, 08 Oct 2024 18:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728439052; x=1729043852; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=inc9DbOOFM/mCOsAsgy3mpPCE5+6FEheJNVKjIGmqbE=;
 b=h2hGB1WZ8KlJUIukutIFP2JHdAXtmFtZTe9VGSHl5jCtcAkWpH2vUlZykS7gHuUM+4
 gp2mPk3uPZcR4deOOEcLQWbMz+YeFoO8wdd846EWM7+nd4f+6wqjWc3qFTz27yDIqNfD
 v0tu4Lh1kwyLMQCfRSU0uN+L2T6O6vzdnBtkY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728439052; x=1729043852;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=inc9DbOOFM/mCOsAsgy3mpPCE5+6FEheJNVKjIGmqbE=;
 b=LREfJZluvpWFIdrpT2NbccXjKAOSzNYDP5sLoGAAqOVG712wnKkLzh5ODvVI8M/kKo
 i8f8VWpHPPtIH4ZIfioJR54pe0D3fhpSSbxQXBuDhgnT66MoRCNkXuQCvNWR1FmsXb2A
 STK6S6VxgndYts2eInS7nXLZT7rHwmLrNVgdoZRCP4ujYduvWDpEKreMyYBkad12f74W
 uEhW0i79WLgF8AxLJFkSgFDSiVkyC3jah0FNaV3D1RN+TxJGRKJtrKZtuCWUWRQ8ccXN
 yQAn8eOiwZTVtFiRlcZGXL5QpEfYA4nvoM65JFKZvcqRwDJZ1hgA6Q5+nSfU/Qcted0q
 mHZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4BtfJAgRTa1qfhenDM9e4IqFAYJvLRpt9bpnJrUckSlnZ5am4b5OkV6tdHUUrG21dV82q8AA=@lists.denx.de
X-Gm-Message-State: AOJu0YxF9kkekgO3Khu9Ztb34uoQhYSBPZkKmCwnMK41R7bWYbggv7Ym
 HFVUN1sdHOT866d99WDBCEL7GRUtpJ1q+yFp/a75/ahx3wXRW2y/iD0cJjsqHc2y7RwD+9X/1J2
 S65sUk84Kp1vWVDo+f9pJHK7VBdxlVe7Rb1QX
X-Google-Smtp-Source: AGHT+IH036+bHAy6I1IXM0LL739mj2uuZhZYgfiTYu+Yo5R/Sx895xJdQk9LVDMWaaTKQvIYDdOv67ZhSxxCAlDcobg=
X-Received: by 2002:a05:6214:4345:b0:6cb:50d0:56ae with SMTP id
 6a1803df08f44-6cbc932ef6dmr16821266d6.29.1728439052257; Tue, 08 Oct 2024
 18:57:32 -0700 (PDT)
MIME-Version: 1.0
References: <20241008191834.2190270-1-jonas@kwiboo.se>
In-Reply-To: <20241008191834.2190270-1-jonas@kwiboo.se>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 8 Oct 2024 19:57:21 -0600
Message-ID: <CAFLszTh-9XqRK1ETioXw=25fmzfdXnsXEwxtqjvUCKjytWJSUQ@mail.gmail.com>
Subject: Re: [PATCH v2] Revert "mmc: dw_mmc: Extract FIFO data transfer into a
 separate routine"
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 Tom Rini <trini@konsulko.com>, Sam Protsenko <semen.protsenko@linaro.org>, 
 Minkyu Kang <mk7.kang@samsung.com>, u-boot@lists.denx.de
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

On Tue, 8 Oct 2024 at 13:18, Jonas Karlman <jonas@kwiboo.se> wrote:
>
> The commit 0252924ac6d4 ("mmc: dw_mmc: Extract FIFO data transfer into a
> separate routine") unintentionally changed behavior of the FIFO data
> transfer routine.
>
> When data is read and size reaches 0 the original loop would wait on
> DWMCI_INTMSK_DTO or timeout. The remaining size to read and buf position
> is no longer tracked across dwmci_data_transfer_fifo() calls and because
> of this an extra call to fifo() and dwmci_fifo_ready() may now trigger a
> FIFO underflow timeout error and slows down FIFO reading.
>
>   Buswidth = 4, clock: 50000000
>   Sending CMD16
>   Sending CMD17
>   dwmci_fifo_ready: FIFO underflow timeout
>   Sending CMD16
>   Sending CMD18
>   dwmci_fifo_ready: FIFO underflow timeout
>   Sending CMD12
>   ## Checking hash(es) for config config-1 ... OK
>
> This reverts commit 0252924ac6d4af69061bb9589d16b30c5bdb7178 to restore
> the old working behavior.
>
> Fixes: 0252924ac6d4 ("mmc: dw_mmc: Extract FIFO data transfer into a separate routine")
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
> Changes in v2:
> - Change to revert the offending commit, both size and buf where reset
>   between fifo() calls, easier to do a full revert.
> - R-b tag not collected because of this being a different patch.
>
> Reading FIT from SD-card take ~20-30 seconds on a Rockchip RK3328 board
> without this reverted, and goes back to sub second once reverted.
> ---
>  drivers/mmc/dw_mmc.c | 103 ++++++++++++++++++++++---------------------
>  1 file changed, 52 insertions(+), 51 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
