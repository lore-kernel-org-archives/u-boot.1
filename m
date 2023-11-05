Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71FFDC4332F
	for <u-boot@archiver.kernel.org>; Sun,  5 Nov 2023 14:12:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1541986CB1;
	Sun,  5 Nov 2023 15:12:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="D06NU+uT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07E5286CB1; Sun,  5 Nov 2023 15:12:09 +0100 (CET)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 694458642D
 for <u-boot@lists.denx.de>; Sun,  5 Nov 2023 15:12:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bmeng.cn@gmail.com
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-9df8d0c556eso53364466b.2
 for <u-boot@lists.denx.de>; Sun, 05 Nov 2023 06:12:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699193523; x=1699798323; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xTgPsB/x2sJaemWvOMYepXasZ3stUuhX6/T7Tb60EwA=;
 b=D06NU+uTtnc7N4HvtEG6zzH6XtH6eIbFR4rbgiwSwaElH/iXlT/vdjYDF935z6jv9G
 ppjPOa2ozU9Dx6HRtdhqcw2ODjyFmq6GhASt+fw/EsMlwqFo4ujBhEPV21MWEJ+IKaYk
 jqkKHq+/+Rnq7N9/REn6mXaikRkQQDQb4y+ggmkEgYJAjN6zjgw1os9iDPYmaf0RBAB+
 m2ofCtuwP5iQXcFcSTdcGN6ITol1CqtExum0WYLvibVa49pyU+bAJT+lU0JpmIHjkxFI
 sWGrx8Dq/PnkXuef7gHkFaCviVYFqNtQZwdL9KGpjGvAuVdg/c3O6J6CIlw2CmBDaRUK
 87Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699193523; x=1699798323;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xTgPsB/x2sJaemWvOMYepXasZ3stUuhX6/T7Tb60EwA=;
 b=tEeR94vHuQYYOPILmnitIFxbwoo1/HRzFTgfxPYV0dCKPJ/iWz88X2D2gft+PU2foe
 YqJZ/aVPmLsPHKhgqIamntusCqfXDYxr2hc1XTAVyfRWC+9J0yYXzrIotqYPjmeohraV
 jtuOZ8ckIQYK0IwR2ukKab7pPxP/Ob2LLND2H2n6+TicEMh2qvyGAUuJkNTr3BofXIWN
 A8+yrW32oKtiOkp+RZHHKh9FF5+z6kyADzBWj5YTIuvP7CXDIl4npQ5i//wcq644lBbU
 wUERqUdzU8WhwNg6SaqqBq7CLs7aIc9pKPDyWCVBBTy71iZZhyl24sdJxoj6LwY2O2vf
 2q4g==
X-Gm-Message-State: AOJu0YxsshShd6K3CV4mrFZKTeqIbzOcikfJQbn+KEWSzFX6ox6qvbk5
 jIiyDLFkxi1PO1IKAf/cG6OHtfZFTdEtHp6PbM4qPZ0E
X-Google-Smtp-Source: AGHT+IHnOGi2+izkGEX9F9aajlTxo9GTxfdCHHAaJsn6NJAnz7GSICGCasKGRF7OZ3PvvcdzbQJ3VQTZ+X2+cwOkBw8=
X-Received: by 2002:a17:907:94c8:b0:9cf:f762:1911 with SMTP id
 dn8-20020a17090794c800b009cff7621911mr11001718ejc.66.1699193522655; Sun, 05
 Nov 2023 06:12:02 -0800 (PST)
MIME-Version: 1.0
References: <20231101180447.99361-1-sjg@chromium.org>
In-Reply-To: <20231101180447.99361-1-sjg@chromium.org>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Sun, 5 Nov 2023 22:11:52 +0800
Message-ID: <CAEUhbmXAQ2a3LRbTkEv+X6kE5_q44kX16p9QXy1NdYDreZJ1Nw@mail.gmail.com>
Subject: Re: [PATCH v2] x86: serial: ns16550: Allow the UART to be silently
 disabled
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Andre Przywara <andre.przywara@arm.com>
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

Hi Simon,

On Thu, Nov 2, 2023 at 2:04=E2=80=AFAM Simon Glass <sjg@chromium.org> wrote=
:
>
> U-Boot normally requires a UART. When booting from coreboot it is
> sometimes just not available, e.g. when no sysinfo or DBG2 information
> is provided.
>
> In this case we need to continue running, since the display can be used.
> Add a flag to disable serial for this case.
>
> This allows U-Boot to start up and operation from the display, instead
> of hanging on start-up.
>
> This could perhaps be hidden behind a Kconfig option to reduce code
> size.

I think using a generic Kconfig option and filtering this out in the
generic serial probe code is better than what is proposed in this
patch.

>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
> Changes in v2:
> - Drop RFC tag since there were no comments
>
>  drivers/serial/ns16550.c         | 17 +++++++++++++++--
>  drivers/serial/serial_coreboot.c |  1 +
>  include/ns16550.h                |  1 +
>  3 files changed, 17 insertions(+), 2 deletions(-)
>

Regards,
Bin
