Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AE3BE936EC
	for <u-boot@archiver.kernel.org>; Wed,  4 Oct 2023 23:49:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2D908755C;
	Thu,  5 Oct 2023 01:49:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ba9GFYpX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 169EB87595; Thu,  5 Oct 2023 01:49:56 +0200 (CEST)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com
 [IPv6:2607:f8b0:4864:20::1032])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 504E4833DE
 for <u-boot@lists.denx.de>; Thu,  5 Oct 2023 01:49:41 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-27909dabf1cso74467a91.1
 for <u-boot@lists.denx.de>; Wed, 04 Oct 2023 16:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696463379; x=1697068179; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eFt+Bg8jTcjnu/WQJMafXuny5VA1YphzPt4681If2zc=;
 b=Ba9GFYpXThKCzYYIKyy8tygimTvJrCuHzg53+3y/cJ0BniuOleShSIt48aUbNPm7a2
 JRSwu1V1W0qKU4KBhd1T8MAcwHxUjKCHyK19HQXjQcR61m1SmBM67VxpuyFjQaWJdVRX
 cJ9dbmkSesNduUi/sMlUOOkqxqJchkHWMH//uUfuMx2HFAJtWThD9ZEZq/ABRBL/50oV
 79XDP8RQrXyL+EeKx39HpK0/6BNAvj+9DwLfSicHdv9NYh/EIT1cNHr6lT3Zv+PjbnsT
 K1t8RdoI9YaEW5UJZJB7p+puXEvd8P2M2XSmrcUKkwUbLfybo8HOTbtCEVBdiPcyX4cx
 sbfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696463379; x=1697068179;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eFt+Bg8jTcjnu/WQJMafXuny5VA1YphzPt4681If2zc=;
 b=n4ZxFkmr4yPbrtFEjJgz/TE9df4BBU1GGyYeRpuhJlEq1wwZtPMF/gEgpJ+nPkehW2
 JASK3xjFt3Y2P8C+oH9We/Bhk/n6Pftbziuu21O7Gvoj10rjPXpQFfIxOI2n4hmBwjlp
 LkxqmOXnLGUK4KN99/XqmQ3GVuBzVyrkX2xT+kEDAGElBuW95WHH5e5adUeIjeFGiZeo
 2kgSKwA7fQ8dtqyJ/RtJCI1UUNTN6YdduMWoFufatZXoPummqzHQV86IyCx6TjXPBBGT
 L4Qms9YV1CFps9fpXh74eKUJyKUEGVSvas8bb2UIp2LmTHmmGaa09oujQCgiduNGV56z
 FjPA==
X-Gm-Message-State: AOJu0YyECGv8DtWJfkpjowIbddG53N72dDjg36uBkYlKjpBlp17hKKCp
 3dDrXDOQy/YXnAVWrFDwk5haysOnkQVYsOJS9k6X1Q5fslU=
X-Google-Smtp-Source: AGHT+IH8T3WV16qWiT30KvFSmLQtvRXnN2NUOsJnhiJ57822/CBbWMUJMS6zdTjbIMw/WvohrNrB/rb+H/n1R03GCdc=
X-Received: by 2002:a17:90a:13cd:b0:279:9611:1020 with SMTP id
 s13-20020a17090a13cd00b0027996111020mr3422784pjf.1.1696463379235; Wed, 04 Oct
 2023 16:49:39 -0700 (PDT)
MIME-Version: 1.0
References: <20231004233453.508-1-egyszeregy@freemail.hu>
In-Reply-To: <20231004233453.508-1-egyszeregy@freemail.hu>
From: Fabio Estevam <festevam@gmail.com>
Date: Wed, 4 Oct 2023 20:49:27 -0300
Message-ID: <CAOMZO5Cy931S=5y55K64d6EEnacfMK7mFJ+UEMKYh3Zui3m=XA@mail.gmail.com>
Subject: Re: [PATCH 1/1] [u-boot][master][PATCH v3] pico-imx7d: add baseboard
 SD card boot detect
To: egyszeregy@freemail.hu
Cc: u-boot@lists.denx.de, otavio@ossystems.com.br
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

On Wed, Oct 4, 2023 at 8:35=E2=80=AFPM <egyszeregy@freemail.hu> wrote:
>
> From: Benjamin Sz=C5=91ke <egyszeregy@freemail.hu>
>
> Take over codes from Techenxion to support mmc autodetect boot for pico-i=
mx7d.
>
> Signed-off-by: Benjamin Sz=C5=91ke <egyszeregy@freemail.hu>

I wanted to test your patch, but there are several issues:

checkpatch complains:
total: 5 errors, 7 warnings, 5 checks, 214 lines checked

git am complains:

Applying: pico-imx7d: add baseboard SD card boot detect
.git/rebase-apply/patch:41: trailing whitespace.
.git/rebase-apply/patch:58: trailing whitespace.
.git/rebase-apply/patch:61: trailing whitespace.
warning: 3 lines add whitespace errors.

Then when I try to build:

board/technexion/pico-imx7d/pico-imx7d.c: In function =E2=80=98board_late_m=
mc_init=E2=80=99:
board/technexion/pico-imx7d/pico-imx7d.c:173:9: warning: implicit
declaration of function =E2=80=98run_command=E2=80=99
[-Wimplicit-function-declaration]
  173 |         run_command(cmd, 0);
      |         ^~~~~~~~~~~
board/technexion/pico-imx7d/pico-imx7d.c:150:14: warning: unused
variable =E2=80=98mmcblk=E2=80=99 [-Wunused-variable]
  150 |         char mmcblk[32];
      |              ^~~~~~

board/technexion/pico-imx7d/spl.c: In function =E2=80=98board_mmc_init=E2=
=80=99:
board/technexion/pico-imx7d/spl.c:261:33: error:
=E2=80=98CONFIG_SYS_FSL_USDHC_NUM=E2=80=99 undeclared (first use in this fu=
nction);
did you mean =E2=80=98CFG_SYS_FSL_USDHC_NUM=E2=80=99?
  261 |         for (index =3D 0; index < CONFIG_SYS_FSL_USDHC_NUM; ++index=
) {
      |                                 ^~~~~~~~~~~~~~~~~~~~~~~~
      |                                 CFG_SYS_FSL_USDHC_NUM
board/technexion/pico-imx7d/spl.c:261:33: note: each undeclared
identifier is reported only once for each function it appears in
make[2]: *** [scripts/Makefile.build:256:
spl/board/technexion/pico-imx7d/spl.o] Error 1
make[1]: *** [scripts/Makefile.spl:533: spl/board/technexion/pico-imx7d] Er=
ror 2

You clearly haven't tested your patch.
