Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FF57C83F1A
	for <u-boot@archiver.kernel.org>; Mon, 14 Jul 2025 12:19:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B193282AC4;
	Mon, 14 Jul 2025 14:19:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=monstr-eu.20230601.gappssmtp.com header.i=@monstr-eu.20230601.gappssmtp.com header.b="yHjcv6BW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7222682B07; Mon, 14 Jul 2025 14:19:15 +0200 (CEST)
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com
 [IPv6:2607:f8b0:4864:20::112a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 493CB805D7
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 14:19:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=monstr@monstr.eu
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-70e5d953c0bso43525237b3.1
 for <u-boot@lists.denx.de>; Mon, 14 Jul 2025 05:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=monstr-eu.20230601.gappssmtp.com; s=20230601; t=1752495551; x=1753100351;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lck/suxyj/2TEHn6TnHiB4ZwaNlQnSEp7yJWsvL7r+0=;
 b=yHjcv6BWTCyEu/zwhW6PJGFaunvPTVtPyq6nv325TfM3cOdzhGJnX4/aJm7qw7Vc7I
 Cp2d7XS2hgo5Bg+vA/HkYYi+JQELLtF/q43qqcApoed4/TysqBsaO6Rd0uFgrvATbpjx
 ecdsln6+C4tR5gIvoL3ZUq3/kkzmMP41SuWbCL1BCEqDhwj1GYIc65nZhkKSk5NZxnDp
 4T14ye1qSp7u2DFFevOMzRQIInsG1MtfAT1Y6rGzk8W2QMWa5+ZwiOzDgL1N4vxG0xbK
 yZX6uDrIIls4jnWHY0G5FgKHhMZnkUTgAktdbLCW8W/vNwaXAIQ2AphkUcIpJ5wIhfnn
 xeVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752495551; x=1753100351;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lck/suxyj/2TEHn6TnHiB4ZwaNlQnSEp7yJWsvL7r+0=;
 b=jW7onwuHFLPkueYJyNWslUiUZQqqJT0Bq1nvgnDNc8Ou20M+M7PiQ1bR1WFr9kKLYt
 legJv8qfdAOVjxJ7G1whhgKy37x+lm6RuNCo9jedShfJX5z8rIyMZYcwtuyX2opg3AJK
 lQyWhKrBXA+OciOKlR2htWzs0o9xbq0xsowvxt0NYJdWV0pxSTyltkgFzOJtgMhL/sHN
 gYWd2Fq+QUBIQ3ZtHTbz8O8qfBGA5A0aqh3EB122G9lny30HbGogft45PdoJGXQb7Ch1
 e6To2h2N/e3FkmiIGyPw3L1HvVA1E5kktUJPtLNubjsPtbplzuSlJXkxHZiQKlL5edw0
 zJDA==
X-Gm-Message-State: AOJu0YwJ/RE0UHA8BEoBcYoWAvABdkH/8N951M1BF0+f9J2JhEOFGkc4
 xv8WM1p3gsSR1DGMdhUBSJl6mhDzHVr7vBHgWidlHue5v0gD1aT4arMzd0pRlxMZuOU3Yja+JNh
 Ax85M33LD2LE9gEB6gGqnG3NG1upykT6QKmpwlmxP
X-Gm-Gg: ASbGnct3qwiyDFyE4Dyd3Hd3c50OuFOuqtHn4fSJtpdHLzMdGT2zYgb21iCiA+2lHVS
 DKGX6yzpv4kJh3BlU72K06heiQB6E8ibsJEUBjyYB3qrsoDHhECQt3ekGucNkd9p4p5pjewPoeK
 cFjlGBWktueZrEQAqTHcavQuZWICJyvC0FPcYdjTnbUMClsg/ar2yvyvkSu8nd29yDrDuKRexnf
 O37xB2q
X-Google-Smtp-Source: AGHT+IHUXgsMMFq9jZb1InhBx1EtlTPHaBiDbcaptDwCkPUA+TWffVOe3oqTtLw0rUYE8xElvYeCDrJfYQANHW1HSPg=
X-Received: by 2002:a05:690c:7406:b0:70f:83ef:ddf7 with SMTP id
 00721157ae682-717d5bb20b9mr196142317b3.13.1752495550559; Mon, 14 Jul 2025
 05:19:10 -0700 (PDT)
MIME-Version: 1.0
References: <20250711144917.1876948-1-abdellatif.elkhlifi@arm.com>
 <20250711144917.1876948-2-abdellatif.elkhlifi@arm.com>
In-Reply-To: <20250711144917.1876948-2-abdellatif.elkhlifi@arm.com>
From: Michal Simek <monstr@monstr.eu>
Date: Mon, 14 Jul 2025 14:18:59 +0200
X-Gm-Features: Ac12FXy0ssIzNjnpHgiNwycF3e-hIptgfgTKw5hVtZ24V03AfIyE3DAqGRpaT-c
Message-ID: <CAHTX3dJgT0FB9f9Ybes=V+xUt1M2wXPXNhqxVtzcAGysNeLJGA@mail.gmail.com>
Subject: Re: [PATCH v2 01/25] arm_ffa: Remove NULL pointer check for ops
To: abdellatif.elkhlifi@arm.com
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Jens Wiklander <jens.wiklander@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, Casey Connolly <casey.connolly@linaro.org>, 
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
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

p=C3=A1 11. 7. 2025 v 16:49 odes=C3=ADlatel <abdellatif.elkhlifi@arm.com> n=
apsal:
>
> From: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
>
> Remove NULL pointer check for ops
>
> uclasses that use ops typically don't check for NULL.
>
> Signed-off-by: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Jens Wiklander <jens.wiklander@linaro.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Casey Connolly <casey.connolly@linaro.org>
> Cc: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
>
> ---
>
> Changelog of changes:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
>
> v2:
>
> * As suggested by Heinrich: The commit is renamed and the ops NULL check =
removed
>
> v1:
>
> * Commit title was "arm_ffa: Add NULL pointer check to the uclass driver =
operations"
>
>  drivers/firmware/arm-ffa/arm-ffa-uclass.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/firmware/arm-ffa/arm-ffa-uclass.c b/drivers/firmware=
/arm-ffa/arm-ffa-uclass.c
> index 96c64964bb7..32dd9458da9 100644
> --- a/drivers/firmware/arm-ffa/arm-ffa-uclass.c
> +++ b/drivers/firmware/arm-ffa/arm-ffa-uclass.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  /*
> - * Copyright 2022-2023 Arm Limited and/or its affiliates <open-source-of=
fice@arm.com>
> + * Copyright 2022-2023, 2025 Arm Limited and/or its affiliates <open-sou=
rce-office@arm.com>
>   *
>   * Authors:
>   *   Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
> --
> 2.25.1
>

That commit message is not matching what you do here.

Thanks,
Michal


--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs
