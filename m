Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB671C47074
	for <u-boot@archiver.kernel.org>; Mon,  8 Jan 2024 00:16:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70DE487A4D;
	Mon,  8 Jan 2024 01:16:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="l1jfFn3t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4FC8A87A3E; Mon,  8 Jan 2024 01:16:14 +0100 (CET)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3524A87935
 for <u-boot@lists.denx.de>; Mon,  8 Jan 2024 01:16:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-680285e7ce8so14538186d6.0
 for <u-boot@lists.denx.de>; Sun, 07 Jan 2024 16:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1704672967; x=1705277767; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6Ha583ILIsyFKxAbupjn+w1QvtPH5d9sy/W6bRVEET0=;
 b=l1jfFn3tiP4SnJOS43GFDthELy0BfjhbdS2xJ+dZVwJNkHstFM7mHrjWzHa0smAyZ6
 AaVnZbmfNMoTt6QqH2+wOg7DSMOedkaDjKxhN27OsSxeQdofuiCP31LuvwGIMn3S2fCx
 bSfoBOtLTR0TcNjtlGjvCqN1kI9AZ+RZoAdfI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704672967; x=1705277767;
 h=cc:to:subject:message-id:date:references:in-reply-to:from:sender
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6Ha583ILIsyFKxAbupjn+w1QvtPH5d9sy/W6bRVEET0=;
 b=pW34oHUN9Qtn7xT6HbHnLOOot+270nQg8H8mYVTVOEwSq7IHA0pcbtSWLe5iXKoNJa
 ZHQQ96emFLasIKQs96Vqn2eqf1pSYnNbfAiE9FGuIzTYut1N2dSS7uIlxQQjPVlFoiIJ
 YHxcmgfmyeRjik1nOwBiTAD4ia6/bDjP7AF9Ohdo1NQPeSrAxw5JWTF+l15NnTSYOBnD
 qctVX5sEbZoEhrrXrl1skstuPHcLDz7fCXr69BPfgOhj6OAhrjcGsrD+dM5vB3uQWlkO
 5u71n84SBcJck5gE/tc1SX3KyAsoxQyjx/PrKEsB6yiSfFbAacFTrbeRAT1oChtMxKqb
 RG7A==
X-Gm-Message-State: AOJu0Yy3CW8tS8n/19IEieNHKDos7VNZbxgWME9aIYkY8lhPN4YcaVbm
 Z4IbmYFQULZEZ+ZC/DrblynlP8AaafuES+FKLlMugFPfnLw5
X-Google-Smtp-Source: AGHT+IHX6XsdxDnqFdTJOF7S+I4RJj4Hf3BPUZmU1iIS49SGqkjNnIjNp0B/2JRBDvmB9Oc7qQAOS9pP1SKu4C9bAGo=
X-Received: by 2002:a05:6214:23c7:b0:680:b6ec:ea05 with SMTP id
 hr7-20020a05621423c700b00680b6ecea05mr4161822qvb.62.1704672966821; Sun, 07
 Jan 2024 16:16:06 -0800 (PST)
Received: from 798914943136 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 7 Jan 2024 18:16:06 -0600
MIME-Version: 1.0
From: Simon Glass <sjg@chromium.org>
In-Reply-To: <CAC_iWjJ6=NjqwcFzVvV4DzMWy5nY_QAeD=vfQrRSjodLbVqroQ@mail.gmail.com>
References: <CAC_iWjJ6=NjqwcFzVvV4DzMWy5nY_QAeD=vfQrRSjodLbVqroQ@mail.gmail.com>
 <20240104014919.413568-1-sjg@chromium.org>
Date: Sun, 7 Jan 2024 18:16:06 -0600
X-Google-Sender-Auth: xiGUh4BqV1z1wN9ga9_00lTEwlg
Message-ID: <CAFLszThGA1LPNgvwe7zqcQHRxR_p7oy-UGWNkR6+pbv7Y68+CQ@mail.gmail.com>
Subject: Re: [PATCH v7] fdt: Allow the devicetree to come from a bloblist
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Raymond Mao <raymond.mao@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>, 
 Andre Przywara <andre.przywara@arm.com>, Baruch Siach <baruch@tkos.co.il>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Jerry Van Baren <vanbaren@cideas.com>,
 Johan Jonker <jbx6244@gmail.com>, Kever Yang <kever.yang@rock-chips.com>, 
 Samuel Holland <samuel@sholland.org>, Shiji Yang <yangshiji66@outlook.com>, 
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

On Thu, 4 Jan 2024 at 03:49, Simon Glass <sjg@chromium.org> wrote:
>
> Standard passage provides for a bloblist to be passed from one firmware
> phase to the next. That can be used to pass the devicetree along as well.
> Add an option to support this.
>
> Tests for this will be added as part of the Universal Payload work.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> The discussion on this was not resolved and is now important due to the
> bloblist series from Raymond. So I am sending it again since I believe
> this is a better starting point than building on OF_BOARD
>
> Changes in v7:
> - Drop use of OF_BLOBLIST
>
> Changes in v6:
> - Don't allow bloblist with OF_EMBED
>
> Changes in v5:
> - Make OF_BLOBLIST default y
> - Make OF_BLOBLIST optional at runtime
>
> Changes in v4:
> - Rebase to -next
>
>  doc/develop/devicetree/control.rst |  3 ++
>  include/fdtdec.h                   |  6 ++--
>  lib/fdtdec.c                       | 44 +++++++++++++++++++++++-------
>  3 files changed, 41 insertions(+), 12 deletions(-)
>
Applied to u-boot-dm/next, thanks!
