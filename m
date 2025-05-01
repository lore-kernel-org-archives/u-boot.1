Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA366C3ABA9
	for <u-boot@archiver.kernel.org>; Thu,  1 May 2025 03:22:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA2988059D;
	Thu,  1 May 2025 05:21:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WmkUFyp0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4948D8081A; Thu,  1 May 2025 05:21:58 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 473648056A
 for <u-boot@lists.denx.de>; Thu,  1 May 2025 05:21:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5f7ec0e4978so1069743a12.1
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 20:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746069716; x=1746674516; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cEKZpQrKHVDVmAVwKljGm/m7QHR4qeRUupSSfk7vbNY=;
 b=WmkUFyp0K/fN2ly3tqV373pA5b9ob+ObX8IJbG8GXj9Cqw03S6ApOxXQbNPlUZqysb
 Gv9Swqi5h9e86KrqxJMH8jB+UvemnM652ejlLrGCIxUakNio//05brMVIG+tkt81uzC/
 4ln5UFIxo1kyv5L5e2auciFU1bLnYMK78SYT9dVYAFUbNMUbGvMXRZ80rPa9eDu/YNSK
 yd8smqJwbMwTb1b6UliWY8iIE/SDOGjJDm+KajN5ZR//u+oiL8jNazt8AfzjC/NWDNhg
 odtTgzhhUPXrssoaoAdq+PnT7qmtMjcSHwUemNiZ4NxpWmLovLwBZ2mm4GjEEO8oh1Z5
 MaNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746069716; x=1746674516;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cEKZpQrKHVDVmAVwKljGm/m7QHR4qeRUupSSfk7vbNY=;
 b=Vico7fTUdp4gKdDDQiIoUx3xS79+nuU7ZzrxXaW24sg1D/S/2ogsTNDy8hmH12Y0aw
 IKQ7brwWSeX3AMKcaPgCR45SclY/7+KBijaA4KqaBhOxn5ZYdTGRsOscMjAOyAtTe6xj
 PbG5dKIraPM94ec408NB5Mw37qavo4Q0hAiD/yiZQQ4/N1W7qYpjv6l1dK6xrk7eD7cW
 R702sxvFDORaMZNFD29XGGOSZFzAE5pguosTBY+iYzE60zwCSJXBkVKu0x/D8Tj2aZlu
 99vznfiof9TmqUU2LuCZ7EG4wmB/asJ3lKoVtODSx8rB99VYWoxeQYBvU5bcPu+Ug/I+
 nmFQ==
X-Gm-Message-State: AOJu0Yzhsc/HgiUgyPxoQteMjSyAh+Dguxy7ZpnNiCo8EN/DGnWhozHB
 d9d1rR4WwiK6UtRS+8vJ/kexbxU7BXE+YsmgNOCKU7FhFNF0dVaPQon/SNarPgsjRV9uu1cvN3/
 5ykzCU8/ZkbwkTc4HiKYAe/D17kA=
X-Gm-Gg: ASbGncsQilE7whNq/gyQS0PqijLMrmfXfxk9s10wvZ+79ckzdLfifYe4iX8ecWebT7u
 5RugpZZvgEBgK21NqT+ZdhM6pRG3sooI6Uzzj2opiyfuFGsiDkBfBfopC6R/PHPVX7XoW3iZMZp
 wDxsaIqy1ZEjbZTgzZLua4ung=
X-Google-Smtp-Source: AGHT+IHEtvYCfvhKIY5WTE/mp4J/Sh72f05ajQYTTzdMIIYy9Ckshn8NWQY5kavmFJTEgbRbM5Axqq1zUMO2mwo97PI=
X-Received: by 2002:a05:6402:1e90:b0:5f8:504a:88d5 with SMTP id
 4fb4d7f45d1cf-5f912498b19mr1403023a12.7.1746069715495; Wed, 30 Apr 2025
 20:21:55 -0700 (PDT)
MIME-Version: 1.0
References: <20250501010456.3930701-1-sjg@chromium.org>
 <20250501010456.3930701-12-sjg@chromium.org>
In-Reply-To: <20250501010456.3930701-12-sjg@chromium.org>
From: Tony Dinh <mibodhi@gmail.com>
Date: Wed, 30 Apr 2025 20:21:38 -0700
X-Gm-Features: ATxdqUHXRR93BjwOTqw_P2GD__n_lk8aO71sfYax6GrMpiVz4hUcyzNNnvE3eQk
Message-ID: <CAJaLiFyXZPrK23O=ZPm2z7p4W05DfG0wniVR9GYYutzpWNP-pQ@mail.gmail.com>
Subject: Re: [PATCH v2 11/22] synology: Include env.h to permit reading the
 environment
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Jerome Forissier <jerome.forissier@linaro.org>, Phil Sutter <phil@nwl.cc>,
 Stefan Roese <sr@denx.de>
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

On Wed, Apr 30, 2025 at 6:05=E2=80=AFPM Simon Glass <sjg@chromium.org> wrot=
e:
>
> This file reads from the environment but does not include the correct
> header. Update it.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Tony Dinh <mibodhi@gmail.com>

Thanks,
Tony
> ---
>
> (no changes since v1)
>
>  board/Synology/ds414/ds414.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/board/Synology/ds414/ds414.c b/board/Synology/ds414/ds414.c
> index 1a4cea87e1a..02d6a4a1ea8 100644
> --- a/board/Synology/ds414/ds414.c
> +++ b/board/Synology/ds414/ds414.c
> @@ -4,6 +4,7 @@
>   * Copyright (C) 2015 Phil Sutter <phil@nwl.cc>
>   */
>
> +#include <env.h>
>  #include <init.h>
>  #include <miiphy.h>
>  #include <asm/global_data.h>
> --
> 2.43.0
>
