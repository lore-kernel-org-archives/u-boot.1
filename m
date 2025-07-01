Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 486A0C83030
	for <u-boot@archiver.kernel.org>; Tue,  1 Jul 2025 01:45:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95FD981FEE;
	Tue,  1 Jul 2025 03:45:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lt//u1fn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2BB2E81FFC; Tue,  1 Jul 2025 03:45:01 +0200 (CEST)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE7878006D
 for <u-boot@lists.denx.de>; Tue,  1 Jul 2025 03:44:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-553be4d2fbfso3034058e87.0
 for <u-boot@lists.denx.de>; Mon, 30 Jun 2025 18:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751334294; x=1751939094; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cqSTYrtBalzQ0zkT8C8jvdn13iVvTUslkkhFbIRoMCU=;
 b=lt//u1fnh+g0q8JaFOiGXa/pA7G+8nJSth6IBX9UVbWOgRdS0y6vaq9gM2cheyJhQs
 Qt1B230QnKM9NzK7JJZ1rjwiSfgFbIT4dG5kHfXf/Q7aYIK4HYqiYWdxn5cEQ0PqWQP/
 bitx+TOhvsnUPCpjxQkC97ZR5aE96VnnROoTcF6OP7vLYmXAi1+cJ6gBTtrT2f05sXxf
 a0//QGAbYX0kDBc1snPteA8giBW0VXy1xGi6cyeb3jrLONXwG4TEPbePleP1M1jtgB8W
 C0oTS8pTd7Q7nqW7HM29XFyXeKUFmAUOmJIrN6x9CNNJepE7RbfO+XBb5FHj8cXE9gUF
 3mAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751334294; x=1751939094;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cqSTYrtBalzQ0zkT8C8jvdn13iVvTUslkkhFbIRoMCU=;
 b=qcmKh4um5EKwGNZtmJDK8+hzI2laMhQAcxdPpHAdPV8m6pYwv1j7/NxKeVOc3t1sDA
 OuVzZHelDjkWXsO3WSdeP5QD9e795nBPUdxgfcSb2ymmOT4vFjye4XCFHdv8TS/jd40H
 sF5NNygpLRb1J4FTCIU8xvtcJ6gPG6HBp4ERfytztqgzi+ZDQCatZqi90+3QYOztPTwL
 E6A+nqqRbcylcDNKL0Hj12sfVZcoHNvDJolaT92//gYkY9+vYugW+q6rmBlP8hQKQUZ4
 QF7AQEYyTnjt9twRSTqXZwsH9bBRgp1yerGp8lf4ZROOkUW62AmimT7NjiwfcoFHEggt
 W9cQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWotV22H6yBlM2oI/hX3McwtHjMOV+4KQfHJdAoGoMc4Xwtdp01hfIG+OCjezt2QZI9onZnfIg=@lists.denx.de
X-Gm-Message-State: AOJu0YznXrKAR5xLir68H/GRagMcbKZT4KeUKSYCnbh/lkc3Ssl619qv
 464qBdn9uMOmButhz2H6CLn7fdjT+GQObMuzq5t5j9ienb4Q6vSwAyhjXOkPN8vn/KOxTKWTh3J
 31XcA8usapip43e0eTITj1lCnZi36jWc=
X-Gm-Gg: ASbGncv2+K6BVffnGWdFfDups8aKZTbEv/TNGLHIu0Nbtj8E4v6CfOuJb3jzkwAdTTB
 DOIhcVhez+lj98d8KcbA9AKPcbyisIpRRxF+ke4udfIY/a99ms3m97VfPQLX/MdaQPjeo5Y6+QU
 igBCewUGCTeteMwtG0VaOdRYiDujyTwYNKZPtXOSHlqCD6ROnzIrDfz6nuYEIw26R0cYDoYWgRD
 g8=
X-Google-Smtp-Source: AGHT+IE/ZeN9z7MjaG1DQdnBXOZZoz4aGfxnD1MyCkXL9UxuHAkaJRju/yklJFt6yNA4B7XYz/D1g2MJcy+w8JhRF3g=
X-Received: by 2002:a05:6512:398f:b0:550:d4f3:8491 with SMTP id
 2adb3069b0e04-5550b8d2ae7mr5170706e87.41.1751334293935; Mon, 30 Jun 2025
 18:44:53 -0700 (PDT)
MIME-Version: 1.0
References: <20250625155551.1759399-1-lukma@denx.de>
In-Reply-To: <20250625155551.1759399-1-lukma@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 30 Jun 2025 22:44:42 -0300
X-Gm-Features: Ac12FXxNoIwEk1EjAkLnHyhg_volC0BFrAy2ZqxVyEKkc1bpXa98SaTbpNc6GSI
Message-ID: <CAOMZO5Aio4KSEMniMLDffg6ymsXKnsBs0Q-=fTRvzB5houbRiQ@mail.gmail.com>
Subject: Re: [PATCH] config: nxp: vf610: Remove CONFIG_SYS_MALLOC_F_LEN
To: Lukasz Majewski <lukma@denx.de>
Cc: Stefano Babic <sbabic@nabladev.com>, uboot-imx@nxp.com,
 Tom Rini <trini@konsulko.com>, 
 albert.aribaud@3adev.fr, Alison Wang <alison.wang@nxp.com>, 
 Anatolij Gustschin <agust@denx.de>, u-boot@lists.denx.de
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

On Wed, Jun 25, 2025 at 12:56=E2=80=AFPM Lukasz Majewski <lukma@denx.de> wr=
ote:
>
> The commit c69103218ee4 ("i2c: mxc_i2c: add DM_FLAG_PRE_RELOC flag")
> has enabled by default the i2c initialization in the pre-relocation
> phase.
> It turned out that vf610 based boards had too small SYS_MALLOC_F_LEN
> pool size.
>
> As a solution the explicit value of CONFIG_SYS_MALLOC_F_LEN for all
> vf610 based boards has been removed from their configs.
>
> Instead, the default value of 0x2000 is now used, which causes boards
> to work correctly again. This approach has been tested on BK4 device.
>
> Signed-off-by: Lukasz Majewski <lukma@denx.de>

Applied to u-boot-imx/next, thanks.
