Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3AB6C83030
	for <u-boot@archiver.kernel.org>; Fri,  4 Jul 2025 02:34:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 35C428091A;
	Fri,  4 Jul 2025 04:34:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bUthydYw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CC06081D5D; Fri,  4 Jul 2025 04:34:44 +0200 (CEST)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83D68803DF
 for <u-boot@lists.denx.de>; Fri,  4 Jul 2025 04:34:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-54d98aa5981so649685e87.0
 for <u-boot@lists.denx.de>; Thu, 03 Jul 2025 19:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751596482; x=1752201282; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s8AWSYbu9rbT3uU6hFFiDKzPhR79Lmy4HCtJ2CK2z9k=;
 b=bUthydYwSAgx6Q3ig0bpSIa/tmG84HW9r5QWGa9TyNgv2qn4hIe+9YWAxvvCIlQ/IE
 GhAmqPh9nDOJ4wAZKHD5r1Hvvt0a7eNxJc9N9iwDBBBPItY0Dgtyt/l21zKvo91eUo5b
 vKiEZpyssUQi0kSDDHLoinQAyibxEmz2TpKIyTJaRSmOTJg7FhdCzl+5cKNPu5oKsWMZ
 UCJNL6fuKPUZ2/aHS+jAs5iC0831QmYFRdrrz7Oc8lWpNBxOSsP7euSCZkQDWelJ42vF
 8Se3n/YCpQoixZ/ydk22a/jPk1+2GOGRRDvGB/2fsMAd1RvYRa4TESsHv7vG6WOF1Mg1
 0BLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751596482; x=1752201282;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s8AWSYbu9rbT3uU6hFFiDKzPhR79Lmy4HCtJ2CK2z9k=;
 b=E2NWIDvJh7LxpWC6wHgI1YJP11qEt/+E4hKDAbC7xX+g9xW9Y64nj1+swEqc4bu3DS
 ObdSzY6uz4OZE5fRZbyGlIQa2fnNsn7xmFo4IxrHImf5tFD2mtN0upbx6n16ngHL4Sds
 dGHz0v4TOkL1h3haAjNRLphqzKx4dnaT5LVDsahubn3BEv7AkcAF/MMjwqEY7LrkUu68
 ciWsGnwLxnusM9Jk0Kv6blqYPlQ5jkWYlCojDvjN6KJXuN7rPeFKkHCeYD4v82PDvqjR
 n5fpGic3CHFT1vNcQucJrvkdDCCyK1XcC4Dpc0i2jwwAq9Kcitem2gy6vqMrfEh4Fmis
 HqUg==
X-Gm-Message-State: AOJu0YyL6e3ttv+gl87gv96QWVgNbrFlaj3XVO1IlO5zxZPJRrfhQUkH
 VJ+ogZYipDRTGFjEigjVpjTK910CeHrq+tNudLNyB+KO4QO5DGbDRLoD1s1cnwqgDxhexMlvLj+
 t0lFIB3HZysw86IcDt3wUG0O/rSL+UEoh+w==
X-Gm-Gg: ASbGnctPqwORrzBsaDo38G3BWeMBzWAueh9dsF+GFQ29RAhzlVZgm9V0Y+sOCwkNOEW
 MHJinb5OAkV6EIHnA3XeN6KAN+90FLNoekY37IEmzSuXCDWZxxYS9NiBgHGSGW/oWW937sBYYsi
 s3TolvafaTzeKsV118d5jRd1NUwDsRnXHL8Y4cqj8hKuLniFhulmDeXah9GRLuOwTVDwnU0EKel
 /8=
X-Google-Smtp-Source: AGHT+IGUR1KJ+f5bIx+e14z/M31bs7YIZJk+KPJ/BQsnMqzgiB4/V3LVZRqsmnNIV/+YiYRQ/vmhT7VO9HNxA32SOQk=
X-Received: by 2002:a05:6512:1250:b0:553:2e99:c20 with SMTP id
 2adb3069b0e04-557a9faf9femr40516e87.34.1751596481391; Thu, 03 Jul 2025
 19:34:41 -0700 (PDT)
MIME-Version: 1.0
References: <20250404135038.2134570-1-jerome.forissier@linaro.org>
 <CAOMZO5Dhs2GRgvjDCBbwsxxZadsVCrpXaWm4qToYfpak+CAKuw@mail.gmail.com>
In-Reply-To: <CAOMZO5Dhs2GRgvjDCBbwsxxZadsVCrpXaWm4qToYfpak+CAKuw@mail.gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 3 Jul 2025 23:34:29 -0300
X-Gm-Features: Ac12FXw3FxI6LCKYgO-l-TODScTsJlurRxaM51A6MMMa2yQw0miyarSbTT4RYis
Message-ID: <CAOMZO5Bjxx5tjj75Bo8A4WJWBnV3Q8h1UHK45_xZgOavig0C9w@mail.gmail.com>
Subject: Re: [PATCH v6 0/3] Static initcalls
To: Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Otavio Salvador <otavio@ossystems.com.br>, dl-uboot-imx <uboot-imx@nxp.com>
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

Adding Tom.

On Thu, Jul 3, 2025 at 11:33=E2=80=AFPM Fabio Estevam <festevam@gmail.com> =
wrote:
>
> Hi Jerome and Tom,
>
> On Fri, Apr 4, 2025 at 10:51=E2=80=AFAM Jerome Forissier
> <jerome.forissier@linaro.org> wrote:
> >
> > This series replaces the dynamic initcalls (with function pointers) wit=
h
> > static calls, and gets rid of initcall_run_list(), init_sequence_f,
> > init_sequence_f_r and init_sequence_r. This makes the code simpler and =
the
> > binary slighlty smaller: -2281 bytes/-0.21 % with LTO enabled and -510
> > bytes/-0.05 % with LTO disabled (xilinx_zynqmp_kria_defconfig).
> >
> > Execution time doesn't seem to change noticeably. There is no impact on
> > the SPL.
> >
> > The inline assembly fixes, although they look unrelated, are triggered
> > on some platforms with LTO enabled. For example: kirkwood_defconfig.
> >
> > CI: https://source.denx.de/u-boot/custodians/u-boot-net/-/pipelines/255=
14
> >
> > Changes in v6:
> > - Rebase on next branch
>
> This series breaks the boot on an imx6dl sabresd board (mx6sabresd_defcon=
fig):
>
> U-Boot SPL 2025.04-01075-g3c9c3d852e00 (Jul 03 2025 - 23:23:12 -0300)
> Trying to boot from MMC1
>
> (Hangs here)
>
> I ran a git bisect from 2025.04 to master, and that was the result:
>
> 8c98b57d72d5e5b94ed064fe1041e51216165334 is the first bad commit
> commit 8c98b57d72d5e5b94ed064fe1041e51216165334
> Merge: 739ad58dbee8 bbee3d41b33f
> Author: Tom Rini <trini@konsulko.com>
> Date:   Mon Apr 14 08:59:45 2025 -0600
>
>     Merge patch series "Static initcalls"
>
>     Jerome Forissier <jerome.forissier@linaro.org> says:
>
>     This series replaces the dynamic initcalls (with function pointers) w=
ith
>     static calls, and gets rid of initcall_run_list(), init_sequence_f,
>     init_sequence_f_r and init_sequence_r. This makes the code simpler an=
d the
>     binary slighlty smaller: -2281 bytes/-0.21 % with LTO enabled and -51=
0
>     bytes/-0.05 % with LTO disabled (xilinx_zynqmp_kria_defconfig).
>
>     Execution time doesn't seem to change noticeably. There is no impact =
on
>     the SPL.
>
>     The inline assembly fixes, although they look unrelated, are triggere=
d
>     on some platforms with LTO enabled. For example: kirkwood_defconfig.
>
>     CI: https://source.denx.de/u-boot/custodians/u-boot-net/-/pipelines/2=
5514
>
>     Link: https://lore.kernel.org/r/20250404135038.2134570-1-jerome.foris=
sier@linaro.org
>
>  arch/arm/include/asm/system.h             |  22 ++-
>  arch/arm/lib/cache.c                      |   5 +-
>  arch/arm/mach-kirkwood/include/mach/cpu.h |   9 +-
>  arch/sh/lib/board.c                       |   9 +-
>  common/board_f.c                          | 223 ++++++++++++++----------=
---
>  common/board_r.c                          | 247 +++++++++++++++---------=
------
>  include/initcall.h                        |  49 +++---
>  lib/Makefile                              |   1 -
>  lib/initcall.c                            | 102 ------------
>  test/py/tests/test_trace.py               |   8 +-
>  10 files changed, 297 insertions(+), 378 deletions(-)
>  delete mode 100644 lib/initcall.c
>
> Any ideas?
>
> Thanks
