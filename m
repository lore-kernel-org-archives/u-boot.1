Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27738E7717F
	for <u-boot@archiver.kernel.org>; Tue, 17 Dec 2024 19:49:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8AE31802C2;
	Tue, 17 Dec 2024 20:48:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="h8D7DfXz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C6107802C2; Tue, 17 Dec 2024 20:48:08 +0100 (CET)
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com
 [IPv6:2607:f8b0:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7ACF280384
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 20:48:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-7feb6871730so3888295a12.2
 for <u-boot@lists.denx.de>; Tue, 17 Dec 2024 11:48:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734464885; x=1735069685; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=G15pfSUFgZJz9Q5B4YF3XCK+Ffs/SvVOT+V4B7dpZxk=;
 b=h8D7DfXz6dbKsbCqybutEyjU7rDTZ77IAW1XDwR+o7aELnvVf/B7yDuReY4qJkUyFS
 WP26XOEM6rg6tpHFXeDa1Oar/EPePzK+CzvuNfo8lMdNbAs9xFkybiBgYYx29tkKlFCK
 qVGNcy11G50hn69XvzkjDCtVvO4dtMgL1buSE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734464885; x=1735069685;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=G15pfSUFgZJz9Q5B4YF3XCK+Ffs/SvVOT+V4B7dpZxk=;
 b=hu0+zbWUGWLQGDyc1wNTf7aV3uI3iiovK2w60im6If7K6gXtDB/qfJIrbVyUpM9pDP
 /ETKPKicHpZYi/Tk0szoVwsk0caU6QqRmccy3elkF1IvX15NRo1bd2tHcuNz4U7HXo7j
 Q4H1VjHGKgRiCcx/0YAluO32YCqWVR2KC7LeR144499rQITvUEAlVkPlz5ALqEwBm+5V
 h3buYPB1S8VAzw9fWhxbhq0uDwerkm8AtEvBHkIZubGjoe8swy3Sixf1el7mmHc2vD5V
 XeDEGF+IaLAATTTodVVybRXMoa81nE3rKH1hx9snzUcVEQsPSbOGQeRhOatvdz5MFTcp
 Masw==
X-Gm-Message-State: AOJu0YzStYFfKm2ZJIRoRLdFhy6F25QgY6PKbr3G9Z5nyQaDmfeYpBun
 sgE+DF6QEn9KCqhziAkqPFVCZx2FN4Ppo09Zge18PavJs8bydWrdDKwqoGuEa8F4zNPb9UrZcGR
 OR9C4lyu81SGQbKBFhWZ40rAF9KduxnB2lWS0
X-Gm-Gg: ASbGncttuKGRQ6AsAoKfDGH8w8wasqGarEYUj/C0w3ZUkA9IONs4xRkrXRxDupwY5W8
 bacP/CVTGCGesyZN8gxE/cKw2Vxh4+shV0WnH6No=
X-Google-Smtp-Source: AGHT+IG9IjpysrvAn0iK//YmD7XmVUmMWjmgYerXw/ObiAEiZftpXXj0/tSIxqFxUCYD+wg0AVEvGkcCEKFbADRxpHQ=
X-Received: by 2002:a17:90b:224e:b0:2ee:dd79:e03c with SMTP id
 98e67ed59e1d1-2f2e91fa887mr195224a91.20.1734464884988; Tue, 17 Dec 2024
 11:48:04 -0800 (PST)
Received: from 599480843054 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 17 Dec 2024 11:47:57 -0800
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <CAC_iWjJuwBvfbwUDZXxVkMgrqMWS-FBv_HKrHpUMexd0FQHipA@mail.gmail.com>
References: <CAC_iWjJuwBvfbwUDZXxVkMgrqMWS-FBv_HKrHpUMexd0FQHipA@mail.gmail.com>
 <20241211135418.563803-1-sjg@chromium.org>
 <20241211135418.563803-7-sjg@chromium.org>
Date: Tue, 17 Dec 2024 11:47:57 -0800
X-Google-Sender-Auth: IuQsr6rfD5Tb6CmoirqU-FxScXI
Message-ID: <CAFLszThv8NJ4wZ6FNrBFyZtd+--Bx-vywe-dz85nhF9J5Wzeqg@mail.gmail.com>
Subject: Re: [PATCH v5 06/23] efi_loader: Move some memory-function comments
 to header
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>, 
 Simon Glass <sjg@chromium.org>
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

There was discussion about this and I am not sure what people prefer.
What I do care about is that this has no place in this patchset.
Please send it separately.

Thanks
/Ilias

On Wed, 11 Dec 2024 at 15:54, Simon Glass <sjg@chromium.org> wrote:
>
> Exported functions should be documented in the header file, not the
> implementation. We tend to make such updates on a piecemeal basis to
> avoid a 'flag day'. Move some comments related to memory allocation to
> follow the convention.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> (no changes since v2)
>
> Changes in v2:
> - Rebase on early patch
>
>  include/efi_loader.h        | 77 +++++++++++++++++++++++++++++++----
>  lib/efi_loader/efi_memory.c | 81 -------------------------------------
>  2 files changed, 69 insertions(+), 89 deletions(-)
>
Applied to sjg/master, thanks!
