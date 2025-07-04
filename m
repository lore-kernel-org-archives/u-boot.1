Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A0F7C83030
	for <u-boot@archiver.kernel.org>; Fri,  4 Jul 2025 02:34:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D89068091A;
	Fri,  4 Jul 2025 04:34:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BFdykRFj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 96EC381D5D; Fri,  4 Jul 2025 04:34:05 +0200 (CEST)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3592A803DF
 for <u-boot@lists.denx.de>; Fri,  4 Jul 2025 04:34:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-553b3316160so621676e87.2
 for <u-boot@lists.denx.de>; Thu, 03 Jul 2025 19:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751596442; x=1752201242; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2r+ie31Il8zetEzAdJta1TqRGN6HhT5xgbxkC5ekf1o=;
 b=BFdykRFjf9uQPbNgrTswkU3gcHezqSZhs4Ww+1WUCL0AoMnd07vFmcKT6OtxlghrZR
 Xie5s5dmCFZIQtrELRMNG6hwB1teJRXVSDkd9RTj4BWfc68YIy2N2Vznl+nW97WQ0ENa
 rLu3xSpe7EChAGEihPb8Si+X7gy5uvIwFhNyEX2rqddl0XMy3zN7rdZbg1GWGve83Zv6
 yvnPU22CnqFNTLAO6/0fMd8ju/eHlEeqJ3kcul3QSixRvchf6EuCz3htfBGQfe9KSBC+
 hU1XmWy+R+mxNYJSUmQl2hyioc23kXrelcuj5Ck2I4gcKGWALRBAKNapVfGpztH2CFD9
 sxUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751596442; x=1752201242;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2r+ie31Il8zetEzAdJta1TqRGN6HhT5xgbxkC5ekf1o=;
 b=WpD3zikMDZSCBYeaM9baUfViqbP/78zBVHJ8UHZDsSPdimjqkLiuWZvz/Qjp4ZFDsT
 w4tYuAH/bSGvDHVxX2/8ropQajsDV7OlSpp6WPZzjE9ZFfhMLR0QjijBYWXg4HMI2lIA
 48Ta7NpXprKLBuwL5NzZou/dSzV0oW7oFKj4RkXRGPxXoy+dkpQGq1YatlBn4yKXX5rJ
 TW2n1v2VhTO680cIqSWmcWttUVEBWyAwXYhqv/x6FohzJZMkh0H5QtR0Srk7Bvo+CPlw
 DhPRtcAat1PYnWgFsmlQpvSXVll1HUNASBktTsoXQ13txHO4niWeWXn4z4MxRP2QMT6w
 d0jA==
X-Gm-Message-State: AOJu0YxhCJzSzAqClRwT2d/jeFPxwOQ4Wdc+K6A1t+Z//8h4mx8Y2lPp
 chPns9lw+ixFxJshx75Ygsc2LYjFfNu7hxTLRaVG0vidhwCNWoPi6GR5NMSWwiKNbyxt3waiMwQ
 D3ZZX0fQ3M7TjneRHC8AAK7YpNv9W0v8=
X-Gm-Gg: ASbGncvwLZk6nnTM4ThUaoJxYMCvVhpMIzBAb10laH/4+4QwowQ2+AKfU2V3gsA71Mk
 2oBIo9jnBmA1iJB0BsA+TBnONZfRSplYd7U5StVHafd1R9LAQDwtWZSVznqQmU6x6IZCYpTLGEk
 ji1rMQr2pa/nJeWaPi0Yp7IOTeUTAihZI2y5VeYtB+Go7f9WHscAfomtxXHSGo/zsnFCjE28zoi
 LU=
X-Google-Smtp-Source: AGHT+IHRfy4dgY1IdfrTNdwegg75C6VjWLEymyXs5jeMsdYhI7M6DsYnL/2N/MFTziwuxKWCg5u+jPS6Nus6ZQvNxE0=
X-Received: by 2002:a05:6512:3e1b:b0:553:2438:8d02 with SMTP id
 2adb3069b0e04-557ab1125cemr66611e87.47.1751596442015; Thu, 03 Jul 2025
 19:34:02 -0700 (PDT)
MIME-Version: 1.0
References: <20250404135038.2134570-1-jerome.forissier@linaro.org>
In-Reply-To: <20250404135038.2134570-1-jerome.forissier@linaro.org>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 3 Jul 2025 23:33:50 -0300
X-Gm-Features: Ac12FXzey8p5R580fVP1SkInn_NBf2ocOxiREQuUEgfElOCPbqI0ebgjlmvUuL8
Message-ID: <CAOMZO5Dhs2GRgvjDCBbwsxxZadsVCrpXaWm4qToYfpak+CAKuw@mail.gmail.com>
Subject: Re: [PATCH v6 0/3] Static initcalls
To: Jerome Forissier <jerome.forissier@linaro.org>
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

Hi Jerome and Tom,

On Fri, Apr 4, 2025 at 10:51=E2=80=AFAM Jerome Forissier
<jerome.forissier@linaro.org> wrote:
>
> This series replaces the dynamic initcalls (with function pointers) with
> static calls, and gets rid of initcall_run_list(), init_sequence_f,
> init_sequence_f_r and init_sequence_r. This makes the code simpler and th=
e
> binary slighlty smaller: -2281 bytes/-0.21 % with LTO enabled and -510
> bytes/-0.05 % with LTO disabled (xilinx_zynqmp_kria_defconfig).
>
> Execution time doesn't seem to change noticeably. There is no impact on
> the SPL.
>
> The inline assembly fixes, although they look unrelated, are triggered
> on some platforms with LTO enabled. For example: kirkwood_defconfig.
>
> CI: https://source.denx.de/u-boot/custodians/u-boot-net/-/pipelines/25514
>
> Changes in v6:
> - Rebase on next branch

This series breaks the boot on an imx6dl sabresd board (mx6sabresd_defconfi=
g):

U-Boot SPL 2025.04-01075-g3c9c3d852e00 (Jul 03 2025 - 23:23:12 -0300)
Trying to boot from MMC1

(Hangs here)

I ran a git bisect from 2025.04 to master, and that was the result:

8c98b57d72d5e5b94ed064fe1041e51216165334 is the first bad commit
commit 8c98b57d72d5e5b94ed064fe1041e51216165334
Merge: 739ad58dbee8 bbee3d41b33f
Author: Tom Rini <trini@konsulko.com>
Date:   Mon Apr 14 08:59:45 2025 -0600

    Merge patch series "Static initcalls"

    Jerome Forissier <jerome.forissier@linaro.org> says:

    This series replaces the dynamic initcalls (with function pointers) wit=
h
    static calls, and gets rid of initcall_run_list(), init_sequence_f,
    init_sequence_f_r and init_sequence_r. This makes the code simpler and =
the
    binary slighlty smaller: -2281 bytes/-0.21 % with LTO enabled and -510
    bytes/-0.05 % with LTO disabled (xilinx_zynqmp_kria_defconfig).

    Execution time doesn't seem to change noticeably. There is no impact on
    the SPL.

    The inline assembly fixes, although they look unrelated, are triggered
    on some platforms with LTO enabled. For example: kirkwood_defconfig.

    CI: https://source.denx.de/u-boot/custodians/u-boot-net/-/pipelines/255=
14

    Link: https://lore.kernel.org/r/20250404135038.2134570-1-jerome.forissi=
er@linaro.org

 arch/arm/include/asm/system.h             |  22 ++-
 arch/arm/lib/cache.c                      |   5 +-
 arch/arm/mach-kirkwood/include/mach/cpu.h |   9 +-
 arch/sh/lib/board.c                       |   9 +-
 common/board_f.c                          | 223 ++++++++++++++------------=
-
 common/board_r.c                          | 247 +++++++++++++++-----------=
----
 include/initcall.h                        |  49 +++---
 lib/Makefile                              |   1 -
 lib/initcall.c                            | 102 ------------
 test/py/tests/test_trace.py               |   8 +-
 10 files changed, 297 insertions(+), 378 deletions(-)
 delete mode 100644 lib/initcall.c

Any ideas?

Thanks
