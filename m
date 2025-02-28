Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 958A2C19776
	for <u-boot@archiver.kernel.org>; Fri, 28 Feb 2025 09:06:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC1F580FF0;
	Fri, 28 Feb 2025 10:06:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="IkfC8YCX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C180B810EA; Fri, 28 Feb 2025 10:06:11 +0100 (CET)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 30915807D7
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 10:06:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mkorpershoek@baylibre.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43aac0390e8so12135115e9.2
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 01:06:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1740733568; x=1741338368;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=84PKv2C2S0y5urlwvu/4WcgZuavvVAG6B1LR/Os3zVQ=;
 b=IkfC8YCX4m2iMZVFYc4l0eKdjGrI6o3a2XFByv9iCscnfswbrBuFcHc9S9Vhe8dGCA
 pG7I8FhTLpm7OLqt05QoHMu/rHqtAzQUqb4X4QwvUZMECQsPM19GfKLDi+rM7s0DhUqY
 YDfNE2Vb4cGWyvLTD+HyY9Zz7rrIoDV5QSZkIXQx5zA/SUXKAlT8pXpMZTiJTX/CcuYd
 dB7Koc4ob/scjxa7C0fV2iB5UU1ulTUnQ5xWlKlhvfNJ1wBDDCZ/Iwl5E/t1QjQ6vEOo
 cnogyK6DU8vXixKZfgfImYiRdaiGroSVfuuPpA7eI2Nhpuo0EkCRSmIHrF7vjv97G2kV
 sdEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740733568; x=1741338368;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=84PKv2C2S0y5urlwvu/4WcgZuavvVAG6B1LR/Os3zVQ=;
 b=a69rpSymBkqsq7jpyeKqZ3Og4bjF9OnwU0Hbp6P2gwHiVluMqmGCmVwfGCGnA9Q1y8
 SNEtJ5pNzsDhZu1I/mx48WLSx+ZiIYpQRz8wgSc5kvo7Phcin9olbyYKcmtMwuxQPNsv
 JBWfxMcG601eyyOst0mh9o+buSfRBrfkbgj7eH21ZVuUDxG2NraRGOA6EUcweJz6yFwa
 7KgCBECsmk+iMKdYq0ryOlBM6SIYukZSTmE2bYb5bKUDDzYNFvYp2qYwx50w5XI/X94O
 Q6c4aIBP72UxR5wZxKpGe1+lOoQaqMASvimnnzIKKWiwzV+6BpV6NI72ZpgF6j6ZectF
 tU4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6iBsP70CnNAlrcCx2eNWzYOOk30Fg/nwbNvV9gdct5T2YatGbV4MieiuPFKVPHIG3Ou5JvBo=@lists.denx.de
X-Gm-Message-State: AOJu0YzVigmCYJdxysKj2SjgUsLfc9ZTgkFns5CqggSQ13zSBgpfvauT
 iBGJD8XbzhtgmpMMA+rQyJ46niUIjX6FxKrYKE294iaac3V2h/OSGPm9DYoXin7akBqvT3X+4pt
 D
X-Gm-Gg: ASbGncuGyq4bT78X7tGJXAv+x+mwlpARz8u/37cVCsUhNaG97Yj59ydbOjz+Loawari
 iIwmysYaTAFZugu2HgQuSnfmVVFZ7Eb9TthHN5w3xl1IILONwIYMvMvdqvQR/CHip/RNKMoxQn7
 cEkcqSBuyhOjsG/trYxRd4d1cLO8JLNhfx/6s3E6VRHSMTP7WUyqA7A/3rAckk7K5K0Sv6EgGLb
 jOXUiXt1bqWF02M6jYpuAEJaBeofIEFXxk756dGtFwvWl9BqqZlyhUqosiMjEQs0wPPPDwwJ5Vx
 0DOLR7zFxu9TbUI+5C9EQBpNnSPuOcLhJyY=
X-Google-Smtp-Source: AGHT+IHtJcHH2UxJxuZAdGv0Moxc4izAzv70dgF3hFNWlH8RC9SvvD1WNtQJvSkiSd/37iudRyKURw==
X-Received: by 2002:a05:600c:4693:b0:439:88bb:d017 with SMTP id
 5b1f17b1804b1-43ba66da7aamr17676615e9.6.1740733568535; 
 Fri, 28 Feb 2025 01:06:08 -0800 (PST)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e47b70b1sm4562501f8f.48.2025.02.28.01.06.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Feb 2025 01:06:08 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH 1/2] usb: gadget: Remove final remnants of
 CONFIG_USB_DEVICE
In-Reply-To: <20250227205101.4127604-1-trini@konsulko.com>
References: <20250227205101.4127604-1-trini@konsulko.com>
Date: Fri, 28 Feb 2025 10:06:07 +0100
Message-ID: <87frjye8w0.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

Hi Tom,

Thank you for the patch.

On jeu., f=C3=A9vr. 27, 2025 at 14:51, Tom Rini <trini@konsulko.com> wrote:

> The lone user of the legacy USB device framework have been removed for
> some time. Remove the final parts of the code that were missed.
>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Marek Vasut <marex@denx.de>
> Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> ---
>  Makefile                      |   1 -
>  arch/arm/lib/bootm.c          |   4 -
>  arch/riscv/lib/bootm.c        |   4 -
>  drivers/usb/gadget/Makefile   |   4 -
>  drivers/usb/gadget/core.c     | 621 ----------------------------------
>  drivers/usb/gadget/ep0.c      | 619 ---------------------------------
>  lib/efi_loader/efi_boottime.c |   2 -
>  7 files changed, 1255 deletions(-)
>  delete mode 100644 drivers/usb/gadget/core.c
>  delete mode 100644 drivers/usb/gadget/ep0.c

I'm always happy to see dead code go. Thanks for doing this!

Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

>

[...]
