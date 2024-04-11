Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0D6BCD1292
	for <u-boot@archiver.kernel.org>; Thu, 11 Apr 2024 06:09:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B36488137;
	Thu, 11 Apr 2024 08:09:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="LmF8eOeA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F92A881CF; Thu, 11 Apr 2024 08:09:38 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2752588137
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 08:09:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-56e509baddaso4511769a12.1
 for <u-boot@lists.denx.de>; Wed, 10 Apr 2024 23:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1712815775; x=1713420575;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kbDa/AJE2PjhvNrIotV6ILgqwhL0g7j3a3MTSfnrTqY=;
 b=LmF8eOeA+aPGpg+qkSaGrUY7RzaIXsXJDaUiRRwyUHYYjGlsdfyLbydZYU+X72CG43
 SxwB6wmBoJHd2yjaGyA9t0b5TvMrq1cp/1j0U7mb5cnEFlgWAaKnqEVc+PMk3PaUnLQm
 gwQMF3glyDtxDjNGJzaMbxaurvznst+1VOSEo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712815775; x=1713420575;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kbDa/AJE2PjhvNrIotV6ILgqwhL0g7j3a3MTSfnrTqY=;
 b=bVvO2pdviboPak8BqCod7sE5tsqijWemlRcqjYxGnLACescHxTA9B79/wyiRuoyosf
 zGL0AvQkwOMOSjlL2dqzV0EZlSxxoksoOi+C31M/U8wQXx2K7RaJwisfhG93o2kRT/Lc
 5roQHS0DFpeqQTVhqJx+VxmkkMmk/A9MwMnJnFo4FWmJB3hnkt00udiM5meaA6d0zg4p
 3GlNJTGaTRQ8UynG9nCc+Aw/fFFHkAnuricbdctG68MLlBSu0YcHFPmQdQ7WTeg+8nm6
 NO1DpTAUS+1IRSoBuMCV1U8N2wk7sCQ0/K3vMi16wjqpQakVYamPofHce5rOwFn8++m8
 XFBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0lHHrO+4+Q9a1N/8J8SGvXZU8w70WknYyvUhYmQcRMSj7N8t4E2eMVe2NWnr2BqEK0NucajQXeTBJn3XE/3gUmmKUOA==
X-Gm-Message-State: AOJu0YzV7kFlClflQjD6XycZtSVgFV/CPajnhMuwg/mMotnnel/6xsUC
 /2LaxP+41jd1zK49fNrmW9XxyRzUdsKtpfgXvks8v7ylPPIQjqIBZLZlJSIIn6S6lSfAzG4rzAE
 T0as6t9pmPSWq7tVmBjhe/rnuNDpPZgeL/iamTw==
X-Google-Smtp-Source: AGHT+IFzvab37N1XZJE0nVhZr2vlt5ktRIjJWlUhE269Gg+13gb2ehlkuwIT9Dl/d8LEhhGeWUrJBjQ5gOjzuE6CJPg=
X-Received: by 2002:a17:906:c14c:b0:a51:da1d:c0e1 with SMTP id
 dp12-20020a170906c14c00b00a51da1dc0e1mr3424780ejc.50.1712815775433; Wed, 10
 Apr 2024 23:09:35 -0700 (PDT)
MIME-Version: 1.0
References: <20240411-mtd-v1-1-fe300f6ab657@jookia.org>
In-Reply-To: <20240411-mtd-v1-1-fe300f6ab657@jookia.org>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Thu, 11 Apr 2024 08:09:24 +0200
Message-ID: <CAOf5uwmcrh6M-GGYwZVk3D4LzZRnk8fE+88JJgtOAHJ_X2=P2Q@mail.gmail.com>
Subject: Re: [PATCH] ubi: Depend on MTD
To: John Watts <contact@jookia.org>
Cc: Kyungmin Park <kmpark@infradead.org>, Heiko Schocher <hs@denx.de>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

Hi

On Thu, Apr 11, 2024 at 7:06=E2=80=AFAM John Watts <contact@jookia.org> wro=
te:
>
> UBI required MTD to build correctly, add it as a Kconfig dependency.
>
> Signed-off-by: John Watts <contact@jookia.org>
> ---
> While working with UBI on my SPI NAND patch series I found it was
> possible to enable it without enabling the MTD subsystem.
> Add a Kconfig option to solve this.
> ---
>  drivers/mtd/ubi/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mtd/ubi/Kconfig b/drivers/mtd/ubi/Kconfig
> index 5783d36c04..fd446d6efb 100644
> --- a/drivers/mtd/ubi/Kconfig
> +++ b/drivers/mtd/ubi/Kconfig
> @@ -9,6 +9,7 @@ config UBI_SILENCE_MSG
>
>  config MTD_UBI
>         bool "Enable UBI - Unsorted block images"
> +       depends on MTD
>         select RBTREE
>         select MTD_PARTITIONS
>         help
>
> ---

Reviewed-by: Michael Trimarchi <michael@amarulasolutins.com>

> base-commit: 777c28460947371ada40868dc994dfe8537d7115
> change-id: 20240411-mtd-d2e811e17cc8
>


> Best regards,
> --
> John Watts <contact@jookia.org>
>


--=20
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com
