Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22EECD49779
	for <u-boot@archiver.kernel.org>; Sun,  1 Dec 2024 16:12:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94F1D89515;
	Sun,  1 Dec 2024 17:12:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mZk5d5/j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF12789491; Sun,  1 Dec 2024 17:12:50 +0100 (CET)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 64482895D7
 for <u-boot@lists.denx.de>; Sun,  1 Dec 2024 17:12:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-aa503cced42so510052966b.3
 for <u-boot@lists.denx.de>; Sun, 01 Dec 2024 08:12:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1733069565; x=1733674365; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=NA7AtRmmS0pzGRgipx0cb4EeoCohlUQ/EWhs97hT2i4=;
 b=mZk5d5/jci13k3/VFtnYAa0mgi3viAyXRbiLwLzd/xXePuO6Qf2VFLeEn+oYfN1Q1Z
 QAkrg/mNyYxDR9Yf3y7XRnJqmTDiOyUxoZdqT8cx+ZaQ0qT+vQmp/6id56toxrgMO4Yp
 likonuK48WTO0wF9QJy1EFPLVQ4OazZTKAmXo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733069565; x=1733674365;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NA7AtRmmS0pzGRgipx0cb4EeoCohlUQ/EWhs97hT2i4=;
 b=ekgKwrExGvDuGUD0AtvSNjzp0revlVpEKtdnl+u8eNz3yhoabjJ052PJUhUpzkE2Jg
 A/RJxseSBf8ahwKSMbDJrFJCDbkcTWOiPOMg/JPX0EzYpwQaMQarOQCBISGCZ0F/sFg4
 oUHEvYU6FJNGTm2XlO7xRnz+oQMkH/M0+Hene6LHnuK9kmVF2DZVufFk3omKIrSgS46j
 X+o7StZly+EUPSYI+XBV9oo0o0MfXL9QtT0tAGUeUZH/kWua98ZYVUd3Uk7KM++E7Kjv
 oAMenera+KZpubh3utv4RMDf2XGn4tZ8n8T3A6pTcHCmirgziQoH28DeciyWf2CdikkI
 fXaQ==
X-Gm-Message-State: AOJu0YwPcfaG2YhEPDH097wwYqfj0vuT4LaljP/tGfPG48NOHBEcAF6p
 VaAxiEMlSQUjnR+q46onJcn4LfnEijKMIJ8HlvKZDp+J6Zls9WsUZG4tjnm02gG50gzw2IsCcEp
 QfNw7gVpWhBWdHv1nd9giQatDdv62/2633x2V
X-Gm-Gg: ASbGncvrpIVw598vmawQdaFF8LnYMY/niSyEDe8IMJIXwKgIvsWsrJeBsP13a4UjXKT
 YTPAwuQ7kt5WVywhRk/ww5ct/QXPDAQ==
X-Google-Smtp-Source: AGHT+IE7zbJzBLoYdhh8MSfiOx4HkDc9V2kEgvCKVu+Vc+6Oly88t/1m02cKV4p00j6einM35LXXPuUD7K71RkWWAg8=
X-Received: by 2002:a17:906:315b:b0:aa5:427e:6af4 with SMTP id
 a640c23a62f3a-aa58104104cmr1758735466b.47.1733069564827; Sun, 01 Dec 2024
 08:12:44 -0800 (PST)
MIME-Version: 1.0
References: <20241123195616.305687-1-mjg59@srcf.ucam.org>
 <20241123195616.305687-2-mjg59@srcf.ucam.org>
In-Reply-To: <20241123195616.305687-2-mjg59@srcf.ucam.org>
From: Simon Glass <sjg@chromium.org>
Date: Sun, 1 Dec 2024 09:12:32 -0700
Message-ID: <CAFLszTh6R_bnyz0RNGXmB_uNDrpgcwftVc-1tdy5C8PY9pSj-g@mail.gmail.com>
Subject: Re: [PATCH 01/10] Add EFI handover support to bootm
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: u-boot@lists.denx.de, Matthew Garrett <mgarrett@aurora.tech>, 
 Bin Meng <bmeng.cn@gmail.com>, Caleb Connolly <caleb.connolly@linaro.org>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>,
 =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
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

On Sat, 23 Nov 2024 at 12:56, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
>
> From: Matthew Garrett <mgarrett@aurora.tech>
>
> We want to jump into the EFI stub in the kernel so it can perform
> appropriate init and call ExitBootServices. Add support for doing that,
> including ensuring that we copy the kernel to somewhere that's not
> currently being used by the firmware.
>
> Signed-off-by: Matthew Garrett <mgarrett@aurora.tech>
>
> ---
>
>  arch/x86/lib/bootm.c | 49 ++++++++++++++++++++++++++++++--------------
>  boot/bootm.c         |  5 +++++
>  include/bootm.h      |  6 ++++++
>  include/efi.h        |  1 +
>  lib/efi/efi.c        |  1 +
>  lib/efi/efi_app.c    | 36 ++++++++++++++++++++++++++++++++
>  6 files changed, 83 insertions(+), 15 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
