Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AF03CFD357
	for <u-boot@archiver.kernel.org>; Mon, 24 Nov 2025 20:47:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7427883EDE;
	Mon, 24 Nov 2025 21:47:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="lBpIKrAD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E520983EE3; Mon, 24 Nov 2025 21:47:54 +0100 (CET)
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com
 [IPv6:2607:f8b0:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C19B83E8E
 for <u-boot@lists.denx.de>; Mon, 24 Nov 2025 21:47:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-b99bfb451e5so3177239a12.2
 for <u-boot@lists.denx.de>; Mon, 24 Nov 2025 12:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764017270; x=1764622070; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JaApKRaG/VRTvCcfTBljn/MRe/vEo+YbAssMmBQoH/E=;
 b=lBpIKrAD1wKYnLrbD6VAI91E2QYVcVUOh1eFZfiYzbzuoSJl4EVXFVtzTQ3h9Vh2kq
 mdHlkjONq3pfEEYFQjg6be0WLUDLTD51WYzVJ7K5G6WRT1xy3wPLV2pRlTDRWsuJeXTN
 mRA3giOPsHt/sU727N+k8b3wTVO2lQUGCjYU6jgREwHirD0v7j/oU53dkbjVDmyEim/w
 KmbqypxVzLxnjI+ERCCn7iCPlGDE+4sD6OWopKjhrSrGCcsEl+ZCmJJkSvhXxTfmGaJY
 OVZhKAlBf5gHnb6/nRu6lJ6hwx242CjepDnp8kovRulzLp2YD0f/zKgB+mQV1T5Fc+ei
 dvrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764017270; x=1764622070;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JaApKRaG/VRTvCcfTBljn/MRe/vEo+YbAssMmBQoH/E=;
 b=QXRsxh7gq9Dke5GPr4O94OV2sNu8fYjPB1RoPrzPUFMMg6O4yneVw/C8oq4FPsrpa7
 gPkumypC1Xwk/O4JsiSpMgC6jYbnWjQZLo/WynadD4ZAEnlAokdSb0Mq3RcrgzKQG6Bv
 NVnHZs0P48m9icA4+220CG7ddwjM9FTkSBbZATsdz/GzYClv0vKCjMAxL8DX8tbvEGlT
 Q3HUXcmFehX3YokO160jEY57RDRnVKuXq3zofa9BjtxyCyQTu9isYf6EBYRMDzDnIq2N
 C9G0NCcP+xsshaIn3PaD2tJBDIYR/E4eWH6fu3rU9m9E8lygrSTRFdU/98gZrEngYmF8
 R1jw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4qaZp05jp3FtK5VzratHfF9XBoD3KQO7FDuHlZ7JigX2zBqfJxxQjenR4WdTSZGb0UOBEPD4=@lists.denx.de
X-Gm-Message-State: AOJu0YxlyWTDy3Shw+Ya06DXQFRJ/b+Rc/k3EYShoIW1AVXV4TKkD8+L
 DinSnXXTwl1S6ZKS1kIHP7XuCLfPqeG0xmdw6FNrwtMsS2CUkD/t7dP/i2v8tVgqn8HLU0ttkAF
 cmE2n35AchbCkWvoYcu1sVV42efO/9g25W7JH2Y62aQ==
X-Gm-Gg: ASbGncuczxaypOepacVHim/NzU7R2AsYOqBBGdi2skLUsk4QTVGcYDIg2IKaAi2LDP0
 zOik/xgjkcfNbUuC00rEF5F20WZtzqQjj+MEacdravpxgHkJ1dB5kxAZuFRbJKXOUiPPqf1JlbC
 Zn8yknaISImxZ3W0tbmxieFZCigphU8iXQv3SRxTrvMxcdtqriOW0eCSuPko4v/cigypmUYvsUQ
 zrKeW5D3FQmgHeiKRDJ3Qx+2cuRiZfWt+nbyukgX2ku2c/cfZlia1C7F7GMLB3/W5KsUrK4Juvc
 SMOsFDCaUSC/ERvqb6aiywDwx1lZgw==
X-Google-Smtp-Source: AGHT+IECYBdVvwTnmUChFjIM7LSPoNuF4HhkJXphR1aF7VpW++Kz8ZbSpiLa9UPNwgLCT0oWnC2pPdu5AsUiko1bQPE=
X-Received: by 2002:a05:7301:7d13:b0:2a4:3592:c612 with SMTP id
 5a478bee46e88-2a9418af972mr252992eec.35.1764017270382; Mon, 24 Nov 2025
 12:47:50 -0800 (PST)
MIME-Version: 1.0
References: <20251118232119.17928-1-semen.protsenko@linaro.org>
In-Reply-To: <20251118232119.17928-1-semen.protsenko@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Mon, 24 Nov 2025 14:47:38 -0600
X-Gm-Features: AWmQ_blbjMsB3sovboJPinhcRokcvNjf16y_LuM_NCjeB8xIaL2A65_OTegsNVI
Message-ID: <CAPLW+4m9eTWDYfJt7rjorHpwZcM2MCKR-aq+uddN6=v=2m0rkA@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] board: samsung: e850-96: Support USB boot
To: Tom Rini <trini@konsulko.com>, Minkyu Kang <mk7.kang@samsung.com>
Cc: Minkyu Kang <promsoft@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 u-boot@lists.denx.de
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

Hi Minkyu,

If there are no objections, can you please apply this series to your tree?

Thanks!

On Tue, Nov 18, 2025 at 5:21=E2=80=AFPM Sam Protsenko
<semen.protsenko@linaro.org> wrote:
>
> When U-Boot is executed during USB boot [1,2] on E850-96 board, two
> issues happen:
>
>   1. eMMC fails to initialize
>   2. Attempt to use USB PHY driver leads to abort
>
> It was identified that issue #1 happens due to enalbed Flash Memory
> Protector bits in MMC block registers during USB boot, and it's handled
> in patch series [3].
>
> Issue #2 on the other hand happens because ROM code expects the
> bootloader (U-Boot) to download remaining binaries (LDFW and TZSW) over
> USB using SMC calls. Before that, the access to USB blocks (USB PHY and
> DWC3) is disabled, probably because corresponding TrustZone domains are
> configured for access from Secure World only.
>
> This patch series implements downloading LDFW and TZSW firmware over USB
> during USB boot, which makes it possible to use U-Boot for flashing
> images to eMMC using fastboot and DFU protocols. That in turn simplifies
> the U-Boot development, as one can use `dltool' [1] to run U-Boot binary
> during USB boot, and update U-Boot on eMMC this way (e.g. using DFU).
> It's not possible when using LittleKernel bootloader, as it expects
> non-standard Samsung GPT partition, but in case of U-Boot we use the
> regular one.
>
> Once this patch series and patch series [3] are applied it'll be
> possible to use U-Boot during USB boot. The two series are independent
> of each other, and can be applied in any particular order.
>
> Changes in v3:
>   - Added PATCH #6 (enter DFU automatically on USB boot)
>   - Rebased on top of the most recent master
>
> Changes in v2:
>   - PATCH #4: Return 0 on success in load_image_usb()
>
> [1] https://gitlab.com/LinaroLtd/e850-96/tools/dltool
> [2] https://docs.u-boot.org/en/latest/board/samsung/e850-96.html
> [3] https://lore.kernel.org/u-boot/20251026010658.19271-1-semen.protsenko=
@linaro.org/
>
> Sam Protsenko (6):
>   board: samsung: e850-96: Keep public functions together
>   board: samsung: e850-96: Add routines for checking boot dev
>   board: samsung: e850-96: Split LDFW loading and init
>   board: samsung: e850-96: Add routine for loading images over USB
>   board: samsung: e850-96: Load firmwares over USB on USB boot
>   board: samsung: e850-96: Enter DFU automatically on USB boot
>
>  board/samsung/e850-96/Makefile  |  2 +-
>  board/samsung/e850-96/bootdev.c | 99 +++++++++++++++++++++++++++++++++
>  board/samsung/e850-96/bootdev.h | 23 ++++++++
>  board/samsung/e850-96/e850-96.c | 71 ++++++++++++++++++-----
>  board/samsung/e850-96/fw.c      | 76 ++++++++++++++++++-------
>  board/samsung/e850-96/fw.h      | 10 +++-
>  6 files changed, 246 insertions(+), 35 deletions(-)
>  create mode 100644 board/samsung/e850-96/bootdev.c
>  create mode 100644 board/samsung/e850-96/bootdev.h
>
>
> base-commit: 91861e5a30d217d8e70130c9124c1646f4afef29
> --
> 2.47.3
>
