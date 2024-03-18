Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEACFC54E60
	for <u-boot@archiver.kernel.org>; Mon, 18 Mar 2024 02:17:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F2FBD879E2;
	Mon, 18 Mar 2024 03:17:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nGppHxxR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1F63A87F24; Mon, 18 Mar 2024 03:17:51 +0100 (CET)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86F1087666
 for <u-boot@lists.denx.de>; Mon, 18 Mar 2024 03:17:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=aford173@gmail.com
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1e0025ef1efso6920775ad.1
 for <u-boot@lists.denx.de>; Sun, 17 Mar 2024 19:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710728266; x=1711333066; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/ZbLYKZ/2KgxLKChRHnM90s7nG3g5qBrHBGYL1JNwPM=;
 b=nGppHxxRvQPSon/YfNOZUvVcGldyEgZ0OvotNKwWcO1S+QIlsGtrB8Sq3QCpUZNyRK
 RDmH6ll2t0k5qAE++U8s/lHnnH+yomJn7CsAENhzJYkkFY0lD6Xx/d6yxq3rLWDAdfG7
 EXqKxZFyaFiWakutGKiQ4khRcDx5d49geWPaU40DsEDPTpnXMks+gNA1R46ccmPzecb+
 kwWsWM2V7v+6EFiKuDxRAMmLcagYoBGnU5biMyn3b+YPQeUlbe/XEKvDIQ2nKqU0vA93
 vttnfq4881M2f9SxRrjxErEs+p6kr4f5AchZ055klL7+WOoZH4U3fY0D24y1/Hhd4TMa
 SSsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710728266; x=1711333066;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/ZbLYKZ/2KgxLKChRHnM90s7nG3g5qBrHBGYL1JNwPM=;
 b=dD644ww/3Qer24CnXN269z5/a/tpxsVQTPdR0IRHjYdrRb8MoSXhzHD6vw1F4vEA3T
 OdXyMBz8JacKWBgkDEliRDwGN2V+YcKj3JdXzca/cJdaOpli93XNHr93b9E6kOSU6Exr
 JvN1wgrSZTpGhujkCfsiv+xh7sob2rPbAqeJ3Khk3jwB1ondjpZpNIPIqDVy8YoQpMlK
 n3HvH0//ZWZJlvPU462ghdq8oIbGTJ4ca5neAv/CTSWJJX++uqKFzezBUTEzNOPj+MW6
 szcg0fwJzoEx87uXfGiaQSFEPv4zqleu7N1K8DQG9oqVBxSzvo+eT3YQJMSba3BWqrjC
 nCzA==
X-Gm-Message-State: AOJu0YxGxU6e1pFn8kh9h7isybMJfJVJ2pgHLpmrZhaEyzB0utXCLOds
 UrTB6qQcn7Gf8UP61ggMOkFZCL8t+KlD09/pNo1u6rnk819V+VRlaYCXzajVSW9OGceCVSS8DZb
 BcRVGsvCCmXOvzgDR/bo2qT3UCh4=
X-Google-Smtp-Source: AGHT+IGjh7p7L6Dn5CocAl/7PgOhaphWZOfNBEuS6FofgISmQwOff6KfFM9S8EK4PaqiBEskFXwvyWGPrdkn2rCL378=
X-Received: by 2002:a17:90b:3ec6:b0:29b:cc7d:40da with SMTP id
 rm6-20020a17090b3ec600b0029bcc7d40damr7735394pjb.17.1710728265678; Sun, 17
 Mar 2024 19:17:45 -0700 (PDT)
MIME-Version: 1.0
References: <20240317062353.655840-1-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20240317062353.655840-1-marek.vasut+renesas@mailbox.org>
From: Adam Ford <aford173@gmail.com>
Date: Sun, 17 Mar 2024 21:17:34 -0500
Message-ID: <CAHCN7xJaX9RWVK5sOQL7LxvLabBSm9AtP8cgVhauN3H8hjxKDQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: renesas: Stop using the -u-boot DTs for build
To: Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: u-boot@lists.denx.de, Biju Das <biju.das.jz@bp.renesas.com>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Ralph Siemsen <ralph.siemsen@linaro.org>
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

On Sun, Mar 17, 2024 at 1:24=E2=80=AFAM Marek Vasut
<marek.vasut+renesas@mailbox.org> wrote:
>
> The U-Boot build system can automatically paste -u-boot.dtsi at the
> end of matching .dts during build. Stop emulating this behavior and
> rename the -u-boot.dts files to -u-boot.dtsi, drop "#include...dts"
> from those new u-boot.dtsi files, and update board configuration
> accordingly.
>
> The rename, '#include...dts` scrubbing and configuration update has
> been done using the following script:
> ```
> $ find . -name r[78]\*-u-boot.dts | sort -u | while read line ; do \
>   git mv ${line%-u-boot.dts}-u-boot.dts ${line%-u-boot.dts}-u-boot.dtsi ;=
 \
>   done
> $ sed -i '/^#include.*dts"/ d' `find . -name r[78]\*-u-boot.dtsi`
> $ sed -i 's@-u-boot@@g' `git grep -li renesas configs`
> ```
> The Salvator-X and ULCB board files have been updated manually.
>
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Seems like the right thing to do.  Beacon should boards do this already.

Acked-by:  Adam Ford <aford173@gmail.com>

> ---
> Cc: Adam Ford <aford173@gmail.com>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>
> Cc: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
> Cc: Ralph Siemsen <ralph.siemsen@linaro.org>
> ---
>  arch/arm/dts/Makefile                         | 58 +++++++++----------
>  ...boot.dts =3D> r7s72100-gr-peach-u-boot.dtsi} |  1 -
>  ....dts =3D> r8a774a1-hihope-rzg2m-u-boot.dtsi} |  1 -
>  ....dts =3D> r8a774b1-hihope-rzg2n-u-boot.dtsi} |  1 -
>  ...-u-boot.dts =3D> r8a774c0-ek874-u-boot.dtsi} |  1 -
>  ....dts =3D> r8a774e1-hihope-rzg2h-u-boot.dtsi} |  1 -
>  ...r-u-boot.dts =3D> r8a7790-lager-u-boot.dtsi} |  1 -
>  ...t-u-boot.dts =3D> r8a7790-stout-u-boot.dtsi} |  1 -
>  ...u-boot.dts =3D> r8a7791-koelsch-u-boot.dtsi} |  1 -
>  ...-u-boot.dts =3D> r8a7791-porter-u-boot.dtsi} |  1 -
>  ...u-boot.dts =3D> r8a7792-blanche-u-boot.dtsi} |  1 -
>  ...se-u-boot.dts =3D> r8a7793-gose-u-boot.dtsi} |  1 -
>  ...alt-u-boot.dts =3D> r8a7794-alt-u-boot.dtsi} |  1 -
>  ...lk-u-boot.dts =3D> r8a7794-silk-u-boot.dtsi} |  1 -
>  ...ot.dts =3D> r8a77950-salvator-x-u-boot.dtsi} |  1 -
>  ...b-u-boot.dts =3D> r8a77950-ulcb-u-boot.dtsi} |  1 -
>  ...ot.dts =3D> r8a77960-salvator-x-u-boot.dtsi} |  1 -
>  ...b-u-boot.dts =3D> r8a77960-ulcb-u-boot.dtsi} |  1 -
>  ...ot.dts =3D> r8a77965-salvator-x-u-boot.dtsi} |  1 -
>  ...b-u-boot.dts =3D> r8a77965-ulcb-u-boot.dtsi} |  1 -
>  ...-u-boot.dts =3D> r8a77970-eagle-u-boot.dtsi} |  1 -
>  ...-u-boot.dts =3D> r8a77970-v3msk-u-boot.dtsi} |  1 -
>  ...u-boot.dts =3D> r8a77980-condor-u-boot.dtsi} |  1 -
>  ...-u-boot.dts =3D> r8a77980-v3hsk-u-boot.dtsi} |  1 -
>  ...-u-boot.dts =3D> r8a77990-ebisu-u-boot.dtsi} |  1 -
>  ...-u-boot.dts =3D> r8a77995-draak-u-boot.dtsi} |  1 -
>  ...u-boot.dts =3D> r8a779a0-falcon-u-boot.dtsi} |  1 -
>  ...u-boot.dts =3D> r8a779f0-spider-u-boot.dtsi} |  1 -
>  ...ot.dts =3D> r8a779g0-white-hawk-u-boot.dtsi} |  1 -
>  ...oot.dts =3D> r8a779h0-gray-hawk-u-boot.dtsi} |  1 -
>  board/renesas/salvator-x/salvator-x.c         |  6 +-
>  board/renesas/ulcb/ulcb.c                     |  6 +-
>  configs/alt_defconfig                         |  2 +-
>  configs/blanche_defconfig                     |  2 +-
>  configs/gose_defconfig                        |  2 +-
>  configs/grpeach_defconfig                     |  2 +-
>  configs/hihope_rzg2_defconfig                 |  4 +-
>  configs/koelsch_defconfig                     |  2 +-
>  configs/lager_defconfig                       |  2 +-
>  configs/porter_defconfig                      |  2 +-
>  configs/r8a77970_eagle_defconfig              |  2 +-
>  configs/r8a77970_v3msk_defconfig              |  2 +-
>  configs/r8a77980_condor_defconfig             |  2 +-
>  configs/r8a77980_v3hsk_defconfig              |  2 +-
>  configs/r8a77990_ebisu_defconfig              |  2 +-
>  configs/r8a77995_draak_defconfig              |  2 +-
>  configs/r8a779a0_falcon_defconfig             |  2 +-
>  configs/r8a779f0_spider_defconfig             |  2 +-
>  configs/r8a779g0_whitehawk_defconfig          |  2 +-
>  configs/r8a779h0_grayhawk_defconfig           |  2 +-
>  configs/rcar3_salvator-x_defconfig            |  4 +-
>  configs/rcar3_ulcb_defconfig                  |  4 +-
>  configs/silinux_ek874_defconfig               |  2 +-
>  configs/silk_defconfig                        |  2 +-
>  configs/stout_defconfig                       |  2 +-
>  55 files changed, 61 insertions(+), 90 deletions(-)
>  rename arch/arm/dts/{r7s72100-gr-peach-u-boot.dts =3D> r7s72100-gr-peach=
-u-boot.dtsi} (97%)
>  rename arch/arm/dts/{r8a774a1-hihope-rzg2m-u-boot.dts =3D> r8a774a1-hiho=
pe-rzg2m-u-boot.dtsi} (91%)
>  rename arch/arm/dts/{r8a774b1-hihope-rzg2n-u-boot.dts =3D> r8a774b1-hiho=
pe-rzg2n-u-boot.dtsi} (91%)
>  rename arch/arm/dts/{r8a774c0-ek874-u-boot.dts =3D> r8a774c0-ek874-u-boo=
t.dtsi} (95%)
>  rename arch/arm/dts/{r8a774e1-hihope-rzg2h-u-boot.dts =3D> r8a774e1-hiho=
pe-rzg2h-u-boot.dtsi} (91%)
>  rename arch/arm/dts/{r8a7790-lager-u-boot.dts =3D> r8a7790-lager-u-boot.=
dtsi} (91%)
>  rename arch/arm/dts/{r8a7790-stout-u-boot.dts =3D> r8a7790-stout-u-boot.=
dtsi} (91%)
>  rename arch/arm/dts/{r8a7791-koelsch-u-boot.dts =3D> r8a7791-koelsch-u-b=
oot.dtsi} (90%)
>  rename arch/arm/dts/{r8a7791-porter-u-boot.dts =3D> r8a7791-porter-u-boo=
t.dtsi} (92%)
>  rename arch/arm/dts/{r8a7792-blanche-u-boot.dts =3D> r8a7792-blanche-u-b=
oot.dtsi} (89%)
>  rename arch/arm/dts/{r8a7793-gose-u-boot.dts =3D> r8a7793-gose-u-boot.dt=
si} (91%)
>  rename arch/arm/dts/{r8a7794-alt-u-boot.dts =3D> r8a7794-alt-u-boot.dtsi=
} (96%)
>  rename arch/arm/dts/{r8a7794-silk-u-boot.dts =3D> r8a7794-silk-u-boot.dt=
si} (91%)
>  rename arch/arm/dts/{r8a77950-salvator-x-u-boot.dts =3D> r8a77950-salvat=
or-x-u-boot.dtsi} (96%)
>  rename arch/arm/dts/{r8a77950-ulcb-u-boot.dts =3D> r8a77950-ulcb-u-boot.=
dtsi} (97%)
>  rename arch/arm/dts/{r8a77960-salvator-x-u-boot.dts =3D> r8a77960-salvat=
or-x-u-boot.dtsi} (96%)
>  rename arch/arm/dts/{r8a77960-ulcb-u-boot.dts =3D> r8a77960-ulcb-u-boot.=
dtsi} (97%)
>  rename arch/arm/dts/{r8a77965-salvator-x-u-boot.dts =3D> r8a77965-salvat=
or-x-u-boot.dtsi} (96%)
>  rename arch/arm/dts/{r8a77965-ulcb-u-boot.dts =3D> r8a77965-ulcb-u-boot.=
dtsi} (97%)
>  rename arch/arm/dts/{r8a77970-eagle-u-boot.dts =3D> r8a77970-eagle-u-boo=
t.dtsi} (96%)
>  rename arch/arm/dts/{r8a77970-v3msk-u-boot.dts =3D> r8a77970-v3msk-u-boo=
t.dtsi} (97%)
>  rename arch/arm/dts/{r8a77980-condor-u-boot.dts =3D> r8a77980-condor-u-b=
oot.dtsi} (96%)
>  rename arch/arm/dts/{r8a77980-v3hsk-u-boot.dts =3D> r8a77980-v3hsk-u-boo=
t.dtsi} (95%)
>  rename arch/arm/dts/{r8a77990-ebisu-u-boot.dts =3D> r8a77990-ebisu-u-boo=
t.dtsi} (97%)
>  rename arch/arm/dts/{r8a77995-draak-u-boot.dts =3D> r8a77995-draak-u-boo=
t.dtsi} (94%)
>  rename arch/arm/dts/{r8a779a0-falcon-u-boot.dts =3D> r8a779a0-falcon-u-b=
oot.dtsi} (94%)
>  rename arch/arm/dts/{r8a779f0-spider-u-boot.dts =3D> r8a779f0-spider-u-b=
oot.dtsi} (95%)
>  rename arch/arm/dts/{r8a779g0-white-hawk-u-boot.dts =3D> r8a779g0-white-=
hawk-u-boot.dtsi} (95%)
>  rename arch/arm/dts/{r8a779h0-gray-hawk-u-boot.dts =3D> r8a779h0-gray-ha=
wk-u-boot.dtsi} (95%)
>
> diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
> index dabd3b91859..b6da94ab04b 100644
> --- a/arch/arm/dts/Makefile
> +++ b/arch/arm/dts/Makefile
> @@ -1140,41 +1140,41 @@ dtb-$(CONFIG_ARCH_IMXRT) +=3D imxrt1050-evk.dtb \
>         imxrt1170-evk.dtb \
>
>  dtb-$(CONFIG_RCAR_GEN2) +=3D \
> -       r8a7790-lager-u-boot.dtb \
> -       r8a7790-stout-u-boot.dtb \
> -       r8a7791-koelsch-u-boot.dtb \
> -       r8a7791-porter-u-boot.dtb \
> -       r8a7792-blanche-u-boot.dtb \
> -       r8a7793-gose-u-boot.dtb \
> -       r8a7794-alt-u-boot.dtb \
> -       r8a7794-silk-u-boot.dtb
> +       r8a7790-lager.dtb \
> +       r8a7790-stout.dtb \
> +       r8a7791-koelsch.dtb \
> +       r8a7791-porter.dtb \
> +       r8a7792-blanche.dtb \
> +       r8a7793-gose.dtb \
> +       r8a7794-alt.dtb \
> +       r8a7794-silk.dtb
>
>  dtb-$(CONFIG_RCAR_GEN3) +=3D \
>         r8a774a1-beacon-rzg2m-kit.dtb \
>         r8a774b1-beacon-rzg2n-kit.dtb \
>         r8a774e1-beacon-rzg2h-kit.dtb \
> -       r8a774a1-hihope-rzg2m-u-boot.dtb \
> -       r8a774b1-hihope-rzg2n-u-boot.dtb \
> -       r8a774c0-ek874-u-boot.dtb \
> -       r8a774e1-hihope-rzg2h-u-boot.dtb \
> -       r8a77950-ulcb-u-boot.dtb \
> -       r8a77950-salvator-x-u-boot.dtb \
> -       r8a77960-ulcb-u-boot.dtb \
> -       r8a77960-salvator-x-u-boot.dtb \
> -       r8a77965-ulcb-u-boot.dtb \
> -       r8a77965-salvator-x-u-boot.dtb \
> -       r8a77970-eagle-u-boot.dtb \
> -       r8a77970-v3msk-u-boot.dtb \
> -       r8a77980-condor-u-boot.dtb \
> -       r8a77980-v3hsk-u-boot.dtb \
> -       r8a77990-ebisu-u-boot.dtb \
> -       r8a77995-draak-u-boot.dtb
> +       r8a774a1-hihope-rzg2m.dtb \
> +       r8a774b1-hihope-rzg2n.dtb \
> +       r8a774c0-ek874.dtb \
> +       r8a774e1-hihope-rzg2h.dtb \
> +       r8a77950-ulcb.dtb \
> +       r8a77950-salvator-x.dtb \
> +       r8a77960-ulcb.dtb \
> +       r8a77960-salvator-x.dtb \
> +       r8a77965-ulcb.dtb \
> +       r8a77965-salvator-x.dtb \
> +       r8a77970-eagle.dtb \
> +       r8a77970-v3msk.dtb \
> +       r8a77980-condor.dtb \
> +       r8a77980-v3hsk.dtb \
> +       r8a77990-ebisu.dtb \
> +       r8a77995-draak.dtb
>
>  dtb-$(CONFIG_RCAR_GEN4) +=3D \
> -       r8a779a0-falcon-u-boot.dtb \
> -       r8a779f0-spider-u-boot.dtb \
> -       r8a779g0-white-hawk-u-boot.dtb \
> -       r8a779h0-gray-hawk-u-boot.dtb
> +       r8a779a0-falcon.dtb \
> +       r8a779f0-spider.dtb \
> +       r8a779g0-white-hawk.dtb \
> +       r8a779h0-gray-hawk.dtb
>
>  dtb-$(CONFIG_TARGET_RZG2L) +=3D \
>         r9a07g044l2-smarc.dts
> @@ -1184,7 +1184,7 @@ DTC_FLAGS +=3D -R 4 -p 0x1000
>  endif
>
>  dtb-$(CONFIG_RZA1) +=3D \
> -       r7s72100-gr-peach-u-boot.dtb
> +       r7s72100-gr-peach.dtb
>
>  dtb-$(CONFIG_ARCH_KEYSTONE) +=3D keystone-k2hk-evm.dtb \
>         keystone-k2l-evm.dtb \
> diff --git a/arch/arm/dts/r7s72100-gr-peach-u-boot.dts b/arch/arm/dts/r7s=
72100-gr-peach-u-boot.dtsi
> similarity index 97%
> rename from arch/arm/dts/r7s72100-gr-peach-u-boot.dts
> rename to arch/arm/dts/r7s72100-gr-peach-u-boot.dtsi
> index 0ae9f91fbe8..34fba29e859 100644
> --- a/arch/arm/dts/r7s72100-gr-peach-u-boot.dts
> +++ b/arch/arm/dts/r7s72100-gr-peach-u-boot.dtsi
> @@ -5,7 +5,6 @@
>   * Copyright (C) 2019 Marek Vasut <marek.vasut@gmail.com>
>   */
>
> -#include "r7s72100-gr-peach.dts"
>
>  / {
>         aliases {
> diff --git a/arch/arm/dts/r8a774a1-hihope-rzg2m-u-boot.dts b/arch/arm/dts=
/r8a774a1-hihope-rzg2m-u-boot.dtsi
> similarity index 91%
> rename from arch/arm/dts/r8a774a1-hihope-rzg2m-u-boot.dts
> rename to arch/arm/dts/r8a774a1-hihope-rzg2m-u-boot.dtsi
> index b735e972214..3ad619bdb90 100644
> --- a/arch/arm/dts/r8a774a1-hihope-rzg2m-u-boot.dts
> +++ b/arch/arm/dts/r8a774a1-hihope-rzg2m-u-boot.dtsi
> @@ -5,7 +5,6 @@
>   * Copyright (C) 2021 Renesas Electronics Corporation
>   */
>
> -#include "r8a774a1-hihope-rzg2m-ex.dts"
>  #include "r8a774a1-u-boot.dtsi"
>
>  &gpio3 {
> diff --git a/arch/arm/dts/r8a774b1-hihope-rzg2n-u-boot.dts b/arch/arm/dts=
/r8a774b1-hihope-rzg2n-u-boot.dtsi
> similarity index 91%
> rename from arch/arm/dts/r8a774b1-hihope-rzg2n-u-boot.dts
> rename to arch/arm/dts/r8a774b1-hihope-rzg2n-u-boot.dtsi
> index 0bdc6909bfb..6f2f6c71c2f 100644
> --- a/arch/arm/dts/r8a774b1-hihope-rzg2n-u-boot.dts
> +++ b/arch/arm/dts/r8a774b1-hihope-rzg2n-u-boot.dtsi
> @@ -5,7 +5,6 @@
>   * Copyright (C) 2021 Renesas Electronics Corp.
>   */
>
> -#include "r8a774b1-hihope-rzg2n-ex.dts"
>  #include "r8a774b1-u-boot.dtsi"
>
>  &gpio3 {
> diff --git a/arch/arm/dts/r8a774c0-ek874-u-boot.dts b/arch/arm/dts/r8a774=
c0-ek874-u-boot.dtsi
> similarity index 95%
> rename from arch/arm/dts/r8a774c0-ek874-u-boot.dts
> rename to arch/arm/dts/r8a774c0-ek874-u-boot.dtsi
> index 8fa6d8074b3..dcdddd9aed6 100644
> --- a/arch/arm/dts/r8a774c0-ek874-u-boot.dts
> +++ b/arch/arm/dts/r8a774c0-ek874-u-boot.dtsi
> @@ -5,7 +5,6 @@
>   * Copyright (C) 2021 Renesas Electronisc Corporation
>   */
>
> -#include "r8a774c0-ek874.dts"
>  #include "r8a774c0-u-boot.dtsi"
>
>  / {
> diff --git a/arch/arm/dts/r8a774e1-hihope-rzg2h-u-boot.dts b/arch/arm/dts=
/r8a774e1-hihope-rzg2h-u-boot.dtsi
> similarity index 91%
> rename from arch/arm/dts/r8a774e1-hihope-rzg2h-u-boot.dts
> rename to arch/arm/dts/r8a774e1-hihope-rzg2h-u-boot.dtsi
> index 03a17bac7ec..8e57e03c899 100644
> --- a/arch/arm/dts/r8a774e1-hihope-rzg2h-u-boot.dts
> +++ b/arch/arm/dts/r8a774e1-hihope-rzg2h-u-boot.dtsi
> @@ -5,7 +5,6 @@
>   * Copyright (C) 2020 Renesas Electronics Corp.
>   */
>
> -#include "r8a774e1-hihope-rzg2h-ex.dts"
>  #include "r8a774e1-u-boot.dtsi"
>
>  &gpio3 {
> diff --git a/arch/arm/dts/r8a7790-lager-u-boot.dts b/arch/arm/dts/r8a7790=
-lager-u-boot.dtsi
> similarity index 91%
> rename from arch/arm/dts/r8a7790-lager-u-boot.dts
> rename to arch/arm/dts/r8a7790-lager-u-boot.dtsi
> index 28b8b604c37..ed1891706ce 100644
> --- a/arch/arm/dts/r8a7790-lager-u-boot.dts
> +++ b/arch/arm/dts/r8a7790-lager-u-boot.dtsi
> @@ -5,7 +5,6 @@
>   * Copyright (C) 2018 Marek Vasut <marek.vasut@gmail.com>
>   */
>
> -#include "r8a7790-lager.dts"
>  #include "r8a7790-u-boot.dtsi"
>
>  &scif0 {
> diff --git a/arch/arm/dts/r8a7790-stout-u-boot.dts b/arch/arm/dts/r8a7790=
-stout-u-boot.dtsi
> similarity index 91%
> rename from arch/arm/dts/r8a7790-stout-u-boot.dts
> rename to arch/arm/dts/r8a7790-stout-u-boot.dtsi
> index 85bcb787613..3b393045e36 100644
> --- a/arch/arm/dts/r8a7790-stout-u-boot.dts
> +++ b/arch/arm/dts/r8a7790-stout-u-boot.dtsi
> @@ -5,7 +5,6 @@
>   * Copyright (C) 2018 Marek Vasut <marek.vasut@gmail.com>
>   */
>
> -#include "r8a7790-stout.dts"
>  #include "r8a7790-u-boot.dtsi"
>
>  &scifa0 {
> diff --git a/arch/arm/dts/r8a7791-koelsch-u-boot.dts b/arch/arm/dts/r8a77=
91-koelsch-u-boot.dtsi
> similarity index 90%
> rename from arch/arm/dts/r8a7791-koelsch-u-boot.dts
> rename to arch/arm/dts/r8a7791-koelsch-u-boot.dtsi
> index c5a1332131d..541c4191d69 100644
> --- a/arch/arm/dts/r8a7791-koelsch-u-boot.dts
> +++ b/arch/arm/dts/r8a7791-koelsch-u-boot.dtsi
> @@ -5,7 +5,6 @@
>   * Copyright (C) 2018 Marek Vasut <marek.vasut@gmail.com>
>   */
>
> -#include "r8a7791-koelsch.dts"
>  #include "r8a7791-u-boot.dtsi"
>
>  &scif0 {
> diff --git a/arch/arm/dts/r8a7791-porter-u-boot.dts b/arch/arm/dts/r8a779=
1-porter-u-boot.dtsi
> similarity index 92%
> rename from arch/arm/dts/r8a7791-porter-u-boot.dts
> rename to arch/arm/dts/r8a7791-porter-u-boot.dtsi
> index bfec1fc6d62..cbf2c5265d8 100644
> --- a/arch/arm/dts/r8a7791-porter-u-boot.dts
> +++ b/arch/arm/dts/r8a7791-porter-u-boot.dtsi
> @@ -5,7 +5,6 @@
>   * Copyright (C) 2018 Marek Vasut <marek.vasut@gmail.com>
>   */
>
> -#include "r8a7791-porter.dts"
>  #include "r8a7791-u-boot.dtsi"
>
>  &scif0 {
> diff --git a/arch/arm/dts/r8a7792-blanche-u-boot.dts b/arch/arm/dts/r8a77=
92-blanche-u-boot.dtsi
> similarity index 89%
> rename from arch/arm/dts/r8a7792-blanche-u-boot.dts
> rename to arch/arm/dts/r8a7792-blanche-u-boot.dtsi
> index 1f33df81cef..8c36a3e5850 100644
> --- a/arch/arm/dts/r8a7792-blanche-u-boot.dts
> +++ b/arch/arm/dts/r8a7792-blanche-u-boot.dtsi
> @@ -5,7 +5,6 @@
>   * Copyright (C) 2018 Marek Vasut <marek.vasut@gmail.com>
>   */
>
> -#include "r8a7792-blanche.dts"
>  #include "r8a7792-u-boot.dtsi"
>
>  &iic3 {
> diff --git a/arch/arm/dts/r8a7793-gose-u-boot.dts b/arch/arm/dts/r8a7793-=
gose-u-boot.dtsi
> similarity index 91%
> rename from arch/arm/dts/r8a7793-gose-u-boot.dts
> rename to arch/arm/dts/r8a7793-gose-u-boot.dtsi
> index dd0932ceca9..41c4361c6e1 100644
> --- a/arch/arm/dts/r8a7793-gose-u-boot.dts
> +++ b/arch/arm/dts/r8a7793-gose-u-boot.dtsi
> @@ -5,7 +5,6 @@
>   * Copyright (C) 2018 Marek Vasut <marek.vasut@gmail.com>
>   */
>
> -#include "r8a7793-gose.dts"
>  #include "r8a7793-u-boot.dtsi"
>
>  &scif0 {
> diff --git a/arch/arm/dts/r8a7794-alt-u-boot.dts b/arch/arm/dts/r8a7794-a=
lt-u-boot.dtsi
> similarity index 96%
> rename from arch/arm/dts/r8a7794-alt-u-boot.dts
> rename to arch/arm/dts/r8a7794-alt-u-boot.dtsi
> index 0a39039fc97..e156b4c93c7 100644
> --- a/arch/arm/dts/r8a7794-alt-u-boot.dts
> +++ b/arch/arm/dts/r8a7794-alt-u-boot.dtsi
> @@ -5,7 +5,6 @@
>   * Copyright (C) 2018 Marek Vasut <marek.vasut@gmail.com>
>   */
>
> -#include "r8a7794-alt.dts"
>  #include "r8a7794-u-boot.dtsi"
>
>  &i2c7 {
> diff --git a/arch/arm/dts/r8a7794-silk-u-boot.dts b/arch/arm/dts/r8a7794-=
silk-u-boot.dtsi
> similarity index 91%
> rename from arch/arm/dts/r8a7794-silk-u-boot.dts
> rename to arch/arm/dts/r8a7794-silk-u-boot.dtsi
> index 3fcb535a3ac..e448ea7e146 100644
> --- a/arch/arm/dts/r8a7794-silk-u-boot.dts
> +++ b/arch/arm/dts/r8a7794-silk-u-boot.dtsi
> @@ -5,7 +5,6 @@
>   * Copyright (C) 2018 Marek Vasut <marek.vasut@gmail.com>
>   */
>
> -#include "r8a7794-silk.dts"
>  #include "r8a7794-u-boot.dtsi"
>
>  &scif2 {
> diff --git a/arch/arm/dts/r8a77950-salvator-x-u-boot.dts b/arch/arm/dts/r=
8a77950-salvator-x-u-boot.dtsi
> similarity index 96%
> rename from arch/arm/dts/r8a77950-salvator-x-u-boot.dts
> rename to arch/arm/dts/r8a77950-salvator-x-u-boot.dtsi
> index ba7cf521d0d..23f12543746 100644
> --- a/arch/arm/dts/r8a77950-salvator-x-u-boot.dts
> +++ b/arch/arm/dts/r8a77950-salvator-x-u-boot.dtsi
> @@ -5,7 +5,6 @@
>   * Copyright (C) 2018 Marek Vasut <marek.vasut@gmail.com>
>   */
>
> -#include "r8a77950-salvator-x.dts"
>  #include "r8a77950-u-boot.dtsi"
>
>  / {
> diff --git a/arch/arm/dts/r8a77950-ulcb-u-boot.dts b/arch/arm/dts/r8a7795=
0-ulcb-u-boot.dtsi
> similarity index 97%
> rename from arch/arm/dts/r8a77950-ulcb-u-boot.dts
> rename to arch/arm/dts/r8a77950-ulcb-u-boot.dtsi
> index e371cde349f..c65c2e6406d 100644
> --- a/arch/arm/dts/r8a77950-ulcb-u-boot.dts
> +++ b/arch/arm/dts/r8a77950-ulcb-u-boot.dtsi
> @@ -5,7 +5,6 @@
>   * Copyright (C) 2018 Marek Vasut <marek.vasut@gmail.com>
>   */
>
> -#include "r8a77950-ulcb.dts"
>  #include "r8a77950-u-boot.dtsi"
>
>  / {
> diff --git a/arch/arm/dts/r8a77960-salvator-x-u-boot.dts b/arch/arm/dts/r=
8a77960-salvator-x-u-boot.dtsi
> similarity index 96%
> rename from arch/arm/dts/r8a77960-salvator-x-u-boot.dts
> rename to arch/arm/dts/r8a77960-salvator-x-u-boot.dtsi
> index 2a9f0aa2180..84a28bf885c 100644
> --- a/arch/arm/dts/r8a77960-salvator-x-u-boot.dts
> +++ b/arch/arm/dts/r8a77960-salvator-x-u-boot.dtsi
> @@ -5,7 +5,6 @@
>   * Copyright (C) 2018 Marek Vasut <marek.vasut@gmail.com>
>   */
>
> -#include "r8a77960-salvator-x.dts"
>  #include "r8a77960-u-boot.dtsi"
>
>  / {
> diff --git a/arch/arm/dts/r8a77960-ulcb-u-boot.dts b/arch/arm/dts/r8a7796=
0-ulcb-u-boot.dtsi
> similarity index 97%
> rename from arch/arm/dts/r8a77960-ulcb-u-boot.dts
> rename to arch/arm/dts/r8a77960-ulcb-u-boot.dtsi
> index 79042b20852..6372f953956 100644
> --- a/arch/arm/dts/r8a77960-ulcb-u-boot.dts
> +++ b/arch/arm/dts/r8a77960-ulcb-u-boot.dtsi
> @@ -5,7 +5,6 @@
>   * Copyright (C) 2018 Marek Vasut <marek.vasut@gmail.com>
>   */
>
> -#include "r8a77960-ulcb.dts"
>  #include "r8a77960-u-boot.dtsi"
>
>  / {
> diff --git a/arch/arm/dts/r8a77965-salvator-x-u-boot.dts b/arch/arm/dts/r=
8a77965-salvator-x-u-boot.dtsi
> similarity index 96%
> rename from arch/arm/dts/r8a77965-salvator-x-u-boot.dts
> rename to arch/arm/dts/r8a77965-salvator-x-u-boot.dtsi
> index e5421f9ca8f..d9a28fe9bab 100644
> --- a/arch/arm/dts/r8a77965-salvator-x-u-boot.dts
> +++ b/arch/arm/dts/r8a77965-salvator-x-u-boot.dtsi
> @@ -5,7 +5,6 @@
>   * Copyright (C) 2018 Marek Vasut <marek.vasut@gmail.com>
>   */
>
> -#include "r8a77965-salvator-x.dts"
>  #include "r8a77965-u-boot.dtsi"
>
>  / {
> diff --git a/arch/arm/dts/r8a77965-ulcb-u-boot.dts b/arch/arm/dts/r8a7796=
5-ulcb-u-boot.dtsi
> similarity index 97%
> rename from arch/arm/dts/r8a77965-ulcb-u-boot.dts
> rename to arch/arm/dts/r8a77965-ulcb-u-boot.dtsi
> index 969911d89ce..aa5de3d0465 100644
> --- a/arch/arm/dts/r8a77965-ulcb-u-boot.dts
> +++ b/arch/arm/dts/r8a77965-ulcb-u-boot.dtsi
> @@ -5,7 +5,6 @@
>   * Copyright (C) 2018 Marek Vasut <marek.vasut@gmail.com>
>   */
>
> -#include "r8a77965-ulcb.dts"
>  #include "r8a77965-u-boot.dtsi"
>
>  / {
> diff --git a/arch/arm/dts/r8a77970-eagle-u-boot.dts b/arch/arm/dts/r8a779=
70-eagle-u-boot.dtsi
> similarity index 96%
> rename from arch/arm/dts/r8a77970-eagle-u-boot.dts
> rename to arch/arm/dts/r8a77970-eagle-u-boot.dtsi
> index eb868eda414..c7971b9e9ce 100644
> --- a/arch/arm/dts/r8a77970-eagle-u-boot.dts
> +++ b/arch/arm/dts/r8a77970-eagle-u-boot.dtsi
> @@ -5,7 +5,6 @@
>   * Copyright (C) 2018 Marek Vasut <marek.vasut@gmail.com>
>   */
>
> -#include "r8a77970-eagle.dts"
>  #include "r8a77970-u-boot.dtsi"
>  #include <dt-bindings/gpio/gpio.h>
>
> diff --git a/arch/arm/dts/r8a77970-v3msk-u-boot.dts b/arch/arm/dts/r8a779=
70-v3msk-u-boot.dtsi
> similarity index 97%
> rename from arch/arm/dts/r8a77970-v3msk-u-boot.dts
> rename to arch/arm/dts/r8a77970-v3msk-u-boot.dtsi
> index 6ee06d7c000..c7b2e07793d 100644
> --- a/arch/arm/dts/r8a77970-v3msk-u-boot.dts
> +++ b/arch/arm/dts/r8a77970-v3msk-u-boot.dtsi
> @@ -5,7 +5,6 @@
>   * Copyright (C) 2019 Cogent Embedded, Inc.
>   */
>
> -#include "r8a77970-v3msk.dts"
>  #include "r8a77970-u-boot.dtsi"
>  #include <dt-bindings/gpio/gpio.h>
>
> diff --git a/arch/arm/dts/r8a77980-condor-u-boot.dts b/arch/arm/dts/r8a77=
980-condor-u-boot.dtsi
> similarity index 96%
> rename from arch/arm/dts/r8a77980-condor-u-boot.dts
> rename to arch/arm/dts/r8a77980-condor-u-boot.dtsi
> index f4a3b43b8ff..34a735ae5b2 100644
> --- a/arch/arm/dts/r8a77980-condor-u-boot.dts
> +++ b/arch/arm/dts/r8a77980-condor-u-boot.dtsi
> @@ -5,7 +5,6 @@
>   * Copyright (C) 2019 Marek Vasut <marek.vasut@gmail.com>
>   */
>
> -#include "r8a77980-condor.dts"
>  #include "r8a77980-u-boot.dtsi"
>
>  / {
> diff --git a/arch/arm/dts/r8a77980-v3hsk-u-boot.dts b/arch/arm/dts/r8a779=
80-v3hsk-u-boot.dtsi
> similarity index 95%
> rename from arch/arm/dts/r8a77980-v3hsk-u-boot.dts
> rename to arch/arm/dts/r8a77980-v3hsk-u-boot.dtsi
> index d083df65f9a..2901d0e7b57 100644
> --- a/arch/arm/dts/r8a77980-v3hsk-u-boot.dts
> +++ b/arch/arm/dts/r8a77980-v3hsk-u-boot.dtsi
> @@ -5,7 +5,6 @@
>   * Copyright (C) 2019 Cogent Embedded, Inc.
>   */
>
> -#include "r8a77980-v3hsk.dts"
>  #include "r8a77980-u-boot.dtsi"
>
>  / {
> diff --git a/arch/arm/dts/r8a77990-ebisu-u-boot.dts b/arch/arm/dts/r8a779=
90-ebisu-u-boot.dtsi
> similarity index 97%
> rename from arch/arm/dts/r8a77990-ebisu-u-boot.dts
> rename to arch/arm/dts/r8a77990-ebisu-u-boot.dtsi
> index fc1c4a79294..b6b7b8f3609 100644
> --- a/arch/arm/dts/r8a77990-ebisu-u-boot.dts
> +++ b/arch/arm/dts/r8a77990-ebisu-u-boot.dtsi
> @@ -5,7 +5,6 @@
>   * Copyright (C) 2018 Marek Vasut <marek.vasut@gmail.com>
>   */
>
> -#include "r8a77990-ebisu.dts"
>  #include "r8a77990-u-boot.dtsi"
>
>  / {
> diff --git a/arch/arm/dts/r8a77995-draak-u-boot.dts b/arch/arm/dts/r8a779=
95-draak-u-boot.dtsi
> similarity index 94%
> rename from arch/arm/dts/r8a77995-draak-u-boot.dts
> rename to arch/arm/dts/r8a77995-draak-u-boot.dtsi
> index 41ceae1da77..1922c40a438 100644
> --- a/arch/arm/dts/r8a77995-draak-u-boot.dts
> +++ b/arch/arm/dts/r8a77995-draak-u-boot.dtsi
> @@ -5,7 +5,6 @@
>   * Copyright (C) 2018 Marek Vasut <marek.vasut@gmail.com>
>   */
>
> -#include "r8a77995-draak.dts"
>  #include "r8a77995-u-boot.dtsi"
>
>  / {
> diff --git a/arch/arm/dts/r8a779a0-falcon-u-boot.dts b/arch/arm/dts/r8a77=
9a0-falcon-u-boot.dtsi
> similarity index 94%
> rename from arch/arm/dts/r8a779a0-falcon-u-boot.dts
> rename to arch/arm/dts/r8a779a0-falcon-u-boot.dtsi
> index 9d28791c605..3b8a017cb41 100644
> --- a/arch/arm/dts/r8a779a0-falcon-u-boot.dts
> +++ b/arch/arm/dts/r8a779a0-falcon-u-boot.dtsi
> @@ -5,7 +5,6 @@
>   * Copyright (C) 2020 Renesas Electronics Corp.
>   */
>
> -#include "r8a779a0-falcon.dts"
>  #include "r8a779a0-u-boot.dtsi"
>
>  / {
> diff --git a/arch/arm/dts/r8a779f0-spider-u-boot.dts b/arch/arm/dts/r8a77=
9f0-spider-u-boot.dtsi
> similarity index 95%
> rename from arch/arm/dts/r8a779f0-spider-u-boot.dts
> rename to arch/arm/dts/r8a779f0-spider-u-boot.dtsi
> index 26fc8bcf440..2fc7e7789a2 100644
> --- a/arch/arm/dts/r8a779f0-spider-u-boot.dts
> +++ b/arch/arm/dts/r8a779f0-spider-u-boot.dtsi
> @@ -5,7 +5,6 @@
>   * Copyright (C) 2021 Renesas Electronics Corp.
>   */
>
> -#include "r8a779f0-spider.dts"
>  #include "r8a779f0-u-boot.dtsi"
>
>  / {
> diff --git a/arch/arm/dts/r8a779g0-white-hawk-u-boot.dts b/arch/arm/dts/r=
8a779g0-white-hawk-u-boot.dtsi
> similarity index 95%
> rename from arch/arm/dts/r8a779g0-white-hawk-u-boot.dts
> rename to arch/arm/dts/r8a779g0-white-hawk-u-boot.dtsi
> index bd756036645..a102639010d 100644
> --- a/arch/arm/dts/r8a779g0-white-hawk-u-boot.dts
> +++ b/arch/arm/dts/r8a779g0-white-hawk-u-boot.dtsi
> @@ -5,7 +5,6 @@
>   * Copyright (C) 2021 Renesas Electronics Corp.
>   */
>
> -#include "r8a779g0-white-hawk.dts"
>  #include "r8a779g0-u-boot.dtsi"
>
>  / {
> diff --git a/arch/arm/dts/r8a779h0-gray-hawk-u-boot.dts b/arch/arm/dts/r8=
a779h0-gray-hawk-u-boot.dtsi
> similarity index 95%
> rename from arch/arm/dts/r8a779h0-gray-hawk-u-boot.dts
> rename to arch/arm/dts/r8a779h0-gray-hawk-u-boot.dtsi
> index 935ba9465dc..92c13151613 100644
> --- a/arch/arm/dts/r8a779h0-gray-hawk-u-boot.dts
> +++ b/arch/arm/dts/r8a779h0-gray-hawk-u-boot.dtsi
> @@ -5,7 +5,6 @@
>   * Copyright (C) 2023 Renesas Electronics Corp.
>   */
>
> -#include "r8a779h0-gray-hawk.dts"
>  #include "r8a779h0-u-boot.dtsi"
>
>  / {
> diff --git a/board/renesas/salvator-x/salvator-x.c b/board/renesas/salvat=
or-x/salvator-x.c
> index 8c47246ae8b..afb3b63582b 100644
> --- a/board/renesas/salvator-x/salvator-x.c
> +++ b/board/renesas/salvator-x/salvator-x.c
> @@ -79,15 +79,15 @@ int board_fit_config_name_match(const char *name)
>         u32 cpu_type =3D renesas_get_cpu_type();
>
>         if ((cpu_type =3D=3D RENESAS_CPU_TYPE_R8A7795) &&
> -           !strcmp(name, "r8a77950-salvator-x-u-boot"))
> +           !strcmp(name, "r8a77950-salvator-x"))
>                 return 0;
>
>         if ((cpu_type =3D=3D RENESAS_CPU_TYPE_R8A7796) &&
> -           !strcmp(name, "r8a77960-salvator-x-u-boot"))
> +           !strcmp(name, "r8a77960-salvator-x"))
>                 return 0;
>
>         if ((cpu_type =3D=3D RENESAS_CPU_TYPE_R8A77965) &&
> -           !strcmp(name, "r8a77965-salvator-x-u-boot"))
> +           !strcmp(name, "r8a77965-salvator-x"))
>                 return 0;
>
>         return -1;
> diff --git a/board/renesas/ulcb/ulcb.c b/board/renesas/ulcb/ulcb.c
> index 8f5de216995..cda6976602d 100644
> --- a/board/renesas/ulcb/ulcb.c
> +++ b/board/renesas/ulcb/ulcb.c
> @@ -70,15 +70,15 @@ int board_fit_config_name_match(const char *name)
>         u32 cpu_type =3D renesas_get_cpu_type();
>
>         if ((cpu_type =3D=3D RENESAS_CPU_TYPE_R8A7795) &&
> -           !strcmp(name, "r8a77950-ulcb-u-boot"))
> +           !strcmp(name, "r8a77950-ulcb"))
>                 return 0;
>
>         if ((cpu_type =3D=3D RENESAS_CPU_TYPE_R8A7796) &&
> -           !strcmp(name, "r8a77960-ulcb-u-boot"))
> +           !strcmp(name, "r8a77960-ulcb"))
>                 return 0;
>
>         if ((cpu_type =3D=3D RENESAS_CPU_TYPE_R8A77965) &&
> -           !strcmp(name, "r8a77965-ulcb-u-boot"))
> +           !strcmp(name, "r8a77965-ulcb"))
>                 return 0;
>
>         return -1;
> diff --git a/configs/alt_defconfig b/configs/alt_defconfig
> index e4007ab8f71..06e9e11f297 100644
> --- a/configs/alt_defconfig
> +++ b/configs/alt_defconfig
> @@ -16,7 +16,7 @@ CONFIG_ENV_SIZE=3D0x40000
>  CONFIG_ENV_OFFSET=3D0xC0000
>  CONFIG_ENV_SECT_SIZE=3D0x40000
>  CONFIG_DM_GPIO=3Dy
> -CONFIG_DEFAULT_DEVICE_TREE=3D"r8a7794-alt-u-boot"
> +CONFIG_DEFAULT_DEVICE_TREE=3D"r8a7794-alt"
>  CONFIG_SPL_TEXT_BASE=3D0xe6300000
>  CONFIG_ARCH_RENESAS_BOARD_STRING=3D"Alt"
>  CONFIG_R8A7794=3Dy
> diff --git a/configs/blanche_defconfig b/configs/blanche_defconfig
> index af7622a88af..c392055e5a7 100644
> --- a/configs/blanche_defconfig
> +++ b/configs/blanche_defconfig
> @@ -12,7 +12,7 @@ CONFIG_ENV_SIZE=3D0x40000
>  CONFIG_ENV_OFFSET=3D0x40000
>  CONFIG_ENV_SECT_SIZE=3D0x40000
>  CONFIG_DM_GPIO=3Dy
> -CONFIG_DEFAULT_DEVICE_TREE=3D"r8a7792-blanche-u-boot"
> +CONFIG_DEFAULT_DEVICE_TREE=3D"r8a7792-blanche"
>  CONFIG_ARCH_RENESAS_BOARD_STRING=3D"Blanche"
>  CONFIG_R8A7792=3Dy
>  CONFIG_TARGET_BLANCHE=3Dy
> diff --git a/configs/gose_defconfig b/configs/gose_defconfig
> index 1eadf7c14d3..35edc677c48 100644
> --- a/configs/gose_defconfig
> +++ b/configs/gose_defconfig
> @@ -16,7 +16,7 @@ CONFIG_ENV_SIZE=3D0x40000
>  CONFIG_ENV_OFFSET=3D0xC0000
>  CONFIG_ENV_SECT_SIZE=3D0x40000
>  CONFIG_DM_GPIO=3Dy
> -CONFIG_DEFAULT_DEVICE_TREE=3D"r8a7793-gose-u-boot"
> +CONFIG_DEFAULT_DEVICE_TREE=3D"r8a7793-gose"
>  CONFIG_SPL_TEXT_BASE=3D0xe6300000
>  CONFIG_ARCH_RENESAS_BOARD_STRING=3D"Gose"
>  CONFIG_R8A7793=3Dy
> diff --git a/configs/grpeach_defconfig b/configs/grpeach_defconfig
> index eef3bad4e65..0c581b634a2 100644
> --- a/configs/grpeach_defconfig
> +++ b/configs/grpeach_defconfig
> @@ -11,7 +11,7 @@ CONFIG_ENV_SIZE=3D0x10000
>  CONFIG_ENV_OFFSET=3D0x80000
>  CONFIG_ENV_SECT_SIZE=3D0x10000
>  CONFIG_DM_GPIO=3Dy
> -CONFIG_DEFAULT_DEVICE_TREE=3D"r7s72100-gr-peach-u-boot"
> +CONFIG_DEFAULT_DEVICE_TREE=3D"r7s72100-gr-peach"
>  CONFIG_RZA1=3Dy
>  CONFIG_OF_LIBFDT_OVERLAY=3Dy
>  CONFIG_SYS_MONITOR_LEN=3D524288
> diff --git a/configs/hihope_rzg2_defconfig b/configs/hihope_rzg2_defconfi=
g
> index a2c7e78cb86..88c7ed1b98f 100644
> --- a/configs/hihope_rzg2_defconfig
> +++ b/configs/hihope_rzg2_defconfig
> @@ -7,7 +7,7 @@ CONFIG_SYS_MALLOC_LEN=3D0x4000000
>  CONFIG_ENV_SIZE=3D0x20000
>  CONFIG_ENV_OFFSET=3D0xFFFE0000
>  CONFIG_DM_GPIO=3Dy
> -CONFIG_DEFAULT_DEVICE_TREE=3D"r8a774a1-hihope-rzg2m-u-boot"
> +CONFIG_DEFAULT_DEVICE_TREE=3D"r8a774a1-hihope-rzg2m"
>  CONFIG_RCAR_GEN3=3Dy
>  CONFIG_TARGET_HIHOPE_RZG2=3Dy
>  CONFIG_SYS_MONITOR_LEN=3D1048576
> @@ -40,7 +40,7 @@ CONFIG_CMD_EXT4_WRITE=3Dy
>  CONFIG_CMD_FAT=3Dy
>  CONFIG_CMD_FS_GENERIC=3Dy
>  CONFIG_OF_CONTROL=3Dy
> -CONFIG_OF_LIST=3D"r8a774a1-hihope-rzg2m-u-boot r8a774b1-hihope-rzg2n-u-b=
oot r8a774e1-hihope-rzg2h-u-boot"
> +CONFIG_OF_LIST=3D"r8a774a1-hihope-rzg2m r8a774b1-hihope-rzg2n r8a774e1-h=
ihope-rzg2h"
>  CONFIG_MULTI_DTB_FIT_LZO=3Dy
>  CONFIG_MULTI_DTB_FIT_USER_DEFINED_AREA=3Dy
>  CONFIG_ENV_OVERWRITE=3Dy
> diff --git a/configs/koelsch_defconfig b/configs/koelsch_defconfig
> index 963e02d6b54..ad411b45141 100644
> --- a/configs/koelsch_defconfig
> +++ b/configs/koelsch_defconfig
> @@ -16,7 +16,7 @@ CONFIG_ENV_SIZE=3D0x40000
>  CONFIG_ENV_OFFSET=3D0xC0000
>  CONFIG_ENV_SECT_SIZE=3D0x40000
>  CONFIG_DM_GPIO=3Dy
> -CONFIG_DEFAULT_DEVICE_TREE=3D"r8a7791-koelsch-u-boot"
> +CONFIG_DEFAULT_DEVICE_TREE=3D"r8a7791-koelsch"
>  CONFIG_SPL_TEXT_BASE=3D0xe6300000
>  CONFIG_ARCH_RENESAS_BOARD_STRING=3D"Koelsch"
>  CONFIG_R8A7791=3Dy
> diff --git a/configs/lager_defconfig b/configs/lager_defconfig
> index 605909e812f..f60d4db5ec2 100644
> --- a/configs/lager_defconfig
> +++ b/configs/lager_defconfig
> @@ -16,7 +16,7 @@ CONFIG_ENV_SIZE=3D0x40000
>  CONFIG_ENV_OFFSET=3D0xC0000
>  CONFIG_ENV_SECT_SIZE=3D0x40000
>  CONFIG_DM_GPIO=3Dy
> -CONFIG_DEFAULT_DEVICE_TREE=3D"r8a7790-lager-u-boot"
> +CONFIG_DEFAULT_DEVICE_TREE=3D"r8a7790-lager"
>  CONFIG_SPL_TEXT_BASE=3D0xe6300000
>  CONFIG_ARCH_RENESAS_BOARD_STRING=3D"Lager"
>  CONFIG_R8A7790=3Dy
> diff --git a/configs/porter_defconfig b/configs/porter_defconfig
> index 021e521745f..f05a0baf215 100644
> --- a/configs/porter_defconfig
> +++ b/configs/porter_defconfig
> @@ -16,7 +16,7 @@ CONFIG_ENV_SIZE=3D0x40000
>  CONFIG_ENV_OFFSET=3D0xC0000
>  CONFIG_ENV_SECT_SIZE=3D0x40000
>  CONFIG_DM_GPIO=3Dy
> -CONFIG_DEFAULT_DEVICE_TREE=3D"r8a7791-porter-u-boot"
> +CONFIG_DEFAULT_DEVICE_TREE=3D"r8a7791-porter"
>  CONFIG_SPL_TEXT_BASE=3D0xe6300000
>  CONFIG_ARCH_RENESAS_BOARD_STRING=3D"Porter"
>  CONFIG_R8A7791=3Dy
> diff --git a/configs/r8a77970_eagle_defconfig b/configs/r8a77970_eagle_de=
fconfig
> index 62fa7e1133c..a3f695e4238 100644
> --- a/configs/r8a77970_eagle_defconfig
> +++ b/configs/r8a77970_eagle_defconfig
> @@ -9,7 +9,7 @@ CONFIG_ENV_SIZE=3D0x40000
>  CONFIG_ENV_OFFSET=3D0x700000
>  CONFIG_ENV_SECT_SIZE=3D0x40000
>  CONFIG_DM_GPIO=3Dy
> -CONFIG_DEFAULT_DEVICE_TREE=3D"r8a77970-eagle-u-boot"
> +CONFIG_DEFAULT_DEVICE_TREE=3D"r8a77970-eagle"
>  CONFIG_SPL_TEXT_BASE=3D0xe6318000
>  CONFIG_RCAR_GEN3=3Dy
>  CONFIG_TARGET_EAGLE=3Dy
> diff --git a/configs/r8a77970_v3msk_defconfig b/configs/r8a77970_v3msk_de=
fconfig
> index b34087293ad..05c8d0e3868 100644
> --- a/configs/r8a77970_v3msk_defconfig
> +++ b/configs/r8a77970_v3msk_defconfig
> @@ -9,7 +9,7 @@ CONFIG_ENV_SIZE=3D0x40000
>  CONFIG_ENV_OFFSET=3D0x700000
>  CONFIG_ENV_SECT_SIZE=3D0x40000
>  CONFIG_DM_GPIO=3Dy
> -CONFIG_DEFAULT_DEVICE_TREE=3D"r8a77970-v3msk-u-boot"
> +CONFIG_DEFAULT_DEVICE_TREE=3D"r8a77970-v3msk"
>  CONFIG_SPL_TEXT_BASE=3D0xe6318000
>  CONFIG_RCAR_GEN3=3Dy
>  CONFIG_R8A77970=3Dy
> diff --git a/configs/r8a77980_condor_defconfig b/configs/r8a77980_condor_=
defconfig
> index 8a501950364..9e11c1b27ee 100644
> --- a/configs/r8a77980_condor_defconfig
> +++ b/configs/r8a77980_condor_defconfig
> @@ -8,7 +8,7 @@ CONFIG_ENV_SIZE=3D0x40000
>  CONFIG_ENV_OFFSET=3D0x700000
>  CONFIG_ENV_SECT_SIZE=3D0x40000
>  CONFIG_DM_GPIO=3Dy
> -CONFIG_DEFAULT_DEVICE_TREE=3D"r8a77980-condor-u-boot"
> +CONFIG_DEFAULT_DEVICE_TREE=3D"r8a77980-condor"
>  CONFIG_SPL_TEXT_BASE=3D0xe6318000
>  CONFIG_RCAR_GEN3=3Dy
>  CONFIG_TARGET_CONDOR=3Dy
> diff --git a/configs/r8a77980_v3hsk_defconfig b/configs/r8a77980_v3hsk_de=
fconfig
> index 8d67b7f6bfe..f61574dd02d 100644
> --- a/configs/r8a77980_v3hsk_defconfig
> +++ b/configs/r8a77980_v3hsk_defconfig
> @@ -8,7 +8,7 @@ CONFIG_ENV_SIZE=3D0x40000
>  CONFIG_ENV_OFFSET=3D0x700000
>  CONFIG_ENV_SECT_SIZE=3D0x40000
>  CONFIG_DM_GPIO=3Dy
> -CONFIG_DEFAULT_DEVICE_TREE=3D"r8a77980-v3hsk-u-boot"
> +CONFIG_DEFAULT_DEVICE_TREE=3D"r8a77980-v3hsk"
>  CONFIG_SPL_TEXT_BASE=3D0xe6318000
>  CONFIG_RCAR_GEN3=3Dy
>  CONFIG_R8A77980=3Dy
> diff --git a/configs/r8a77990_ebisu_defconfig b/configs/r8a77990_ebisu_de=
fconfig
> index 28fa30e31e5..fe4134226ac 100644
> --- a/configs/r8a77990_ebisu_defconfig
> +++ b/configs/r8a77990_ebisu_defconfig
> @@ -8,7 +8,7 @@ CONFIG_SYS_MALLOC_F_LEN=3D0x2000
>  CONFIG_ENV_SIZE=3D0x20000
>  CONFIG_ENV_OFFSET=3D0xFFFE0000
>  CONFIG_DM_GPIO=3Dy
> -CONFIG_DEFAULT_DEVICE_TREE=3D"r8a77990-ebisu-u-boot"
> +CONFIG_DEFAULT_DEVICE_TREE=3D"r8a77990-ebisu"
>  CONFIG_SPL_TEXT_BASE=3D0xe6318000
>  CONFIG_RCAR_GEN3=3Dy
>  CONFIG_TARGET_EBISU=3Dy
> diff --git a/configs/r8a77995_draak_defconfig b/configs/r8a77995_draak_de=
fconfig
> index 644320632a9..a964d4ea51e 100644
> --- a/configs/r8a77995_draak_defconfig
> +++ b/configs/r8a77995_draak_defconfig
> @@ -8,7 +8,7 @@ CONFIG_SYS_MALLOC_F_LEN=3D0x2000
>  CONFIG_ENV_SIZE=3D0x20000
>  CONFIG_ENV_OFFSET=3D0xFFFE0000
>  CONFIG_DM_GPIO=3Dy
> -CONFIG_DEFAULT_DEVICE_TREE=3D"r8a77995-draak-u-boot"
> +CONFIG_DEFAULT_DEVICE_TREE=3D"r8a77995-draak"
>  CONFIG_SPL_TEXT_BASE=3D0xe6318000
>  CONFIG_RCAR_GEN3=3Dy
>  CONFIG_TARGET_DRAAK=3Dy
> diff --git a/configs/r8a779a0_falcon_defconfig b/configs/r8a779a0_falcon_=
defconfig
> index 04a5600960d..6681cb0088f 100644
> --- a/configs/r8a779a0_falcon_defconfig
> +++ b/configs/r8a779a0_falcon_defconfig
> @@ -8,7 +8,7 @@ CONFIG_ENV_SIZE=3D0x40000
>  CONFIG_ENV_OFFSET=3D0xC00000
>  CONFIG_ENV_SECT_SIZE=3D0x40000
>  CONFIG_DM_GPIO=3Dy
> -CONFIG_DEFAULT_DEVICE_TREE=3D"r8a779a0-falcon-u-boot"
> +CONFIG_DEFAULT_DEVICE_TREE=3D"r8a779a0-falcon"
>  CONFIG_RCAR_GEN4=3Dy
>  CONFIG_TARGET_FALCON=3Dy
>  CONFIG_SYS_MONITOR_LEN=3D1048576
> diff --git a/configs/r8a779f0_spider_defconfig b/configs/r8a779f0_spider_=
defconfig
> index 54e0928debb..942e0184412 100644
> --- a/configs/r8a779f0_spider_defconfig
> +++ b/configs/r8a779f0_spider_defconfig
> @@ -6,7 +6,7 @@ CONFIG_ENV_SIZE=3D0x40000
>  CONFIG_ENV_OFFSET=3D0xD00000
>  CONFIG_ENV_SECT_SIZE=3D0x40000
>  CONFIG_DM_GPIO=3Dy
> -CONFIG_DEFAULT_DEVICE_TREE=3D"r8a779f0-spider-u-boot"
> +CONFIG_DEFAULT_DEVICE_TREE=3D"r8a779f0-spider"
>  CONFIG_RCAR_GEN4=3Dy
>  CONFIG_TARGET_SPIDER=3Dy
>  CONFIG_SYS_MONITOR_LEN=3D1048576
> diff --git a/configs/r8a779g0_whitehawk_defconfig b/configs/r8a779g0_whit=
ehawk_defconfig
> index 1489c327c41..4cc6203e54d 100644
> --- a/configs/r8a779g0_whitehawk_defconfig
> +++ b/configs/r8a779g0_whitehawk_defconfig
> @@ -5,7 +5,7 @@ CONFIG_SYS_MALLOC_LEN=3D0x4000000
>  CONFIG_ENV_SIZE=3D0x20000
>  CONFIG_ENV_OFFSET=3D0xFFFE0000
>  CONFIG_DM_GPIO=3Dy
> -CONFIG_DEFAULT_DEVICE_TREE=3D"r8a779g0-white-hawk-u-boot"
> +CONFIG_DEFAULT_DEVICE_TREE=3D"r8a779g0-white-hawk"
>  CONFIG_RCAR_GEN4=3Dy
>  CONFIG_TARGET_WHITEHAWK=3Dy
>  CONFIG_SYS_MONITOR_LEN=3D1048576
> diff --git a/configs/r8a779h0_grayhawk_defconfig b/configs/r8a779h0_grayh=
awk_defconfig
> index 84401eb9309..7368708195d 100644
> --- a/configs/r8a779h0_grayhawk_defconfig
> +++ b/configs/r8a779h0_grayhawk_defconfig
> @@ -5,7 +5,7 @@ CONFIG_SYS_MALLOC_LEN=3D0x4000000
>  CONFIG_ENV_SIZE=3D0x20000
>  CONFIG_ENV_OFFSET=3D0xFFFE0000
>  CONFIG_DM_GPIO=3Dy
> -CONFIG_DEFAULT_DEVICE_TREE=3D"r8a779h0-gray-hawk-u-boot"
> +CONFIG_DEFAULT_DEVICE_TREE=3D"r8a779h0-gray-hawk"
>  CONFIG_RCAR_GEN4=3Dy
>  CONFIG_TARGET_GRAYHAWK=3Dy
>  CONFIG_SYS_MONITOR_LEN=3D1048576
> diff --git a/configs/rcar3_salvator-x_defconfig b/configs/rcar3_salvator-=
x_defconfig
> index a69bb4381ca..c76cbec76d4 100644
> --- a/configs/rcar3_salvator-x_defconfig
> +++ b/configs/rcar3_salvator-x_defconfig
> @@ -6,7 +6,7 @@ CONFIG_SYS_MALLOC_LEN=3D0x4000000
>  CONFIG_ENV_SIZE=3D0x20000
>  CONFIG_ENV_OFFSET=3D0xFFFE0000
>  CONFIG_DM_GPIO=3Dy
> -CONFIG_DEFAULT_DEVICE_TREE=3D"r8a77950-salvator-x-u-boot"
> +CONFIG_DEFAULT_DEVICE_TREE=3D"r8a77950-salvator-x"
>  CONFIG_SPL_TEXT_BASE=3D0xe6338000
>  CONFIG_RCAR_GEN3=3Dy
>  CONFIG_TARGET_SALVATOR_X=3Dy
> @@ -48,7 +48,7 @@ CONFIG_CMD_EXT4_WRITE=3Dy
>  CONFIG_CMD_FAT=3Dy
>  CONFIG_CMD_FS_GENERIC=3Dy
>  CONFIG_OF_CONTROL=3Dy
> -CONFIG_OF_LIST=3D"r8a77950-salvator-x-u-boot r8a77960-salvator-x-u-boot =
r8a77965-salvator-x-u-boot"
> +CONFIG_OF_LIST=3D"r8a77950-salvator-x r8a77960-salvator-x r8a77965-salva=
tor-x"
>  CONFIG_MULTI_DTB_FIT_LZO=3Dy
>  CONFIG_MULTI_DTB_FIT_USER_DEFINED_AREA=3Dy
>  CONFIG_OF_DTB_PROPS_REMOVE=3Dy
> diff --git a/configs/rcar3_ulcb_defconfig b/configs/rcar3_ulcb_defconfig
> index 5bd36979423..701dfcb7a0e 100644
> --- a/configs/rcar3_ulcb_defconfig
> +++ b/configs/rcar3_ulcb_defconfig
> @@ -7,7 +7,7 @@ CONFIG_SYS_MALLOC_F_LEN=3D0x2000
>  CONFIG_ENV_SIZE=3D0x20000
>  CONFIG_ENV_OFFSET=3D0xFFFE0000
>  CONFIG_DM_GPIO=3Dy
> -CONFIG_DEFAULT_DEVICE_TREE=3D"r8a77950-ulcb-u-boot"
> +CONFIG_DEFAULT_DEVICE_TREE=3D"r8a77950-ulcb"
>  CONFIG_SPL_TEXT_BASE=3D0xe6338000
>  CONFIG_RCAR_GEN3=3Dy
>  CONFIG_TARGET_ULCB=3Dy
> @@ -46,7 +46,7 @@ CONFIG_CMD_EXT4_WRITE=3Dy
>  CONFIG_CMD_FAT=3Dy
>  CONFIG_CMD_FS_GENERIC=3Dy
>  CONFIG_OF_CONTROL=3Dy
> -CONFIG_OF_LIST=3D"r8a77950-ulcb-u-boot r8a77960-ulcb-u-boot r8a77965-ulc=
b-u-boot"
> +CONFIG_OF_LIST=3D"r8a77950-ulcb r8a77960-ulcb r8a77965-ulcb"
>  CONFIG_MULTI_DTB_FIT_LZO=3Dy
>  CONFIG_MULTI_DTB_FIT_USER_DEFINED_AREA=3Dy
>  CONFIG_OF_DTB_PROPS_REMOVE=3Dy
> diff --git a/configs/silinux_ek874_defconfig b/configs/silinux_ek874_defc=
onfig
> index 0f0aca36ee6..93902e009b2 100644
> --- a/configs/silinux_ek874_defconfig
> +++ b/configs/silinux_ek874_defconfig
> @@ -9,7 +9,7 @@ CONFIG_ENV_SIZE=3D0x10000
>  CONFIG_ENV_OFFSET=3D0x3F0000
>  CONFIG_ENV_SECT_SIZE=3D0x10000
>  CONFIG_DM_GPIO=3Dy
> -CONFIG_DEFAULT_DEVICE_TREE=3D"r8a774c0-ek874-u-boot"
> +CONFIG_DEFAULT_DEVICE_TREE=3D"r8a774c0-ek874"
>  CONFIG_SPL_TEXT_BASE=3D0xe6318000
>  CONFIG_RCAR_GEN3=3Dy
>  CONFIG_TARGET_SILINUX_EK874=3Dy
> diff --git a/configs/silk_defconfig b/configs/silk_defconfig
> index 939ccc9c478..40ac8759d08 100644
> --- a/configs/silk_defconfig
> +++ b/configs/silk_defconfig
> @@ -16,7 +16,7 @@ CONFIG_ENV_SIZE=3D0x40000
>  CONFIG_ENV_OFFSET=3D0xC0000
>  CONFIG_ENV_SECT_SIZE=3D0x40000
>  CONFIG_DM_GPIO=3Dy
> -CONFIG_DEFAULT_DEVICE_TREE=3D"r8a7794-silk-u-boot"
> +CONFIG_DEFAULT_DEVICE_TREE=3D"r8a7794-silk"
>  CONFIG_SPL_TEXT_BASE=3D0xe6300000
>  CONFIG_ARCH_RENESAS_BOARD_STRING=3D"Silk"
>  CONFIG_R8A7794=3Dy
> diff --git a/configs/stout_defconfig b/configs/stout_defconfig
> index 1022ee9e71a..428a0241986 100644
> --- a/configs/stout_defconfig
> +++ b/configs/stout_defconfig
> @@ -16,7 +16,7 @@ CONFIG_ENV_SIZE=3D0x40000
>  CONFIG_ENV_OFFSET=3D0xC0000
>  CONFIG_ENV_SECT_SIZE=3D0x40000
>  CONFIG_DM_GPIO=3Dy
> -CONFIG_DEFAULT_DEVICE_TREE=3D"r8a7790-stout-u-boot"
> +CONFIG_DEFAULT_DEVICE_TREE=3D"r8a7790-stout"
>  CONFIG_SPL_TEXT_BASE=3D0xe6300000
>  CONFIG_ARCH_RENESAS_BOARD_STRING=3D"Stout"
>  CONFIG_R8A7790=3Dy
> --
> 2.43.0
>
