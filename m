Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D23F1CA0EEB
	for <u-boot@archiver.kernel.org>; Thu, 21 Aug 2025 23:43:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D22380548;
	Fri, 22 Aug 2025 01:43:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QI8WUWTB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4928281D5D; Fri, 22 Aug 2025 01:43:44 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 373238006D
 for <u-boot@lists.denx.de>; Fri, 22 Aug 2025 01:43:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mibodhi@gmail.com
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-61c212c3986so25654a12.0
 for <u-boot@lists.denx.de>; Thu, 21 Aug 2025 16:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755819822; x=1756424622; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dKu14kbVeogVvcAlcWJj5IMEV9EBoHwyU4be+Y0GE18=;
 b=QI8WUWTBCO+qfaK1aJ7MoVdoQpwxVLjrZRy97tg+AthVgHcCvt1r82BmjcP7rhk7WD
 eKltM0f+RfxQCii/I7I6P0L0aFvct3xFM03ydWsf5nSIDPFE5n1cfQ6Wzc3b+a2ghGXX
 A3RXYQwOKoRc/ddFj1BJuzqfOrttkrgigxpaoloXpoqKy1Oo6Yzoqx6sfCZ+gPrUJf2y
 q4aCVUzlLtKRGHL9eJb1xlBWLmA4y668DYnDHxyJ5hXdPdeXgeAysQLM9OyyDi7DTlzD
 3N2iHrHZ2vU7hNVkay4HmtGdzDoSbIlu17p1QvbCFBGC4wC8SKSoyD6Gu8i2UdbMjv1j
 s/Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755819822; x=1756424622;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dKu14kbVeogVvcAlcWJj5IMEV9EBoHwyU4be+Y0GE18=;
 b=mBGGabaO7XyOVzKc97LN0IdAPwdn5OK0tI9tuN8xvsCCLj1R8pl7A7WW33+pVWq2OT
 gxyjuKKdRsVUkJHyHsp/eZEtByH+kbDgjNGzcOCTEYZh3voGmHu+jsRR2W37Z8GzUui1
 1HdlApt9pMV1uXdH0P8IhZdErbYnW0HrdtqwPcRd84ahnITOI1t2GR1Z7idRkunjiJil
 GQ4HzOIdv+M8dAxgLPHJYqHmlR9kS7IjjQuhD2l78qXAbM1wd5SQuNgeMWkmJC+JMmTy
 t0lJZsX3/IxNK7qaXSDKZaS9W5RETnZnJseQuIt/ga058j8ITjOy96XU/V9PeTIv8D07
 WOow==
X-Forwarded-Encrypted: i=1;
 AJvYcCUh7QtiZ+wrx24P048Zx2aqJlt8sjDK43UjsAZ1yBtx+1Thkh362kODYhE1Hui9Wm5xBup1hyU=@lists.denx.de
X-Gm-Message-State: AOJu0YwUMIW+F+WPvfXU1goEg7nMeTBqhIwbOIDZlDuuglbyNxm3Rc8I
 Ew7rcJOpbhcNIz3cE+5d5nKUumCSQsG3aCFFWw0cZIZzspKrrNbcfmI/nYTpnW0K5iUXmpMHtCP
 xjfDvmMSXpAaS8D2jUXx9QS27fGACrWQ=
X-Gm-Gg: ASbGncuZcagSUBkC6fBkelOhNc1LLfC/KzptCvvbVvzLhWQDrOOyyDDL2nBXYwSV/nx
 vt2j7+uykyGHjqiWH607p1EEOIJFw/E4TRbSp1ElEqbPYA6X3OIFxLqdFws5B3vCH8So9WPgQoM
 crRF1fZt3wMQAMVOvxlD/zfp4ldEpDIjTS5HQ7yNwf/3mjyEECtpC4+jCe1gJQdxyw4wGkGsqsD
 Y3+LlanWJeSbjrCF3c=
X-Google-Smtp-Source: AGHT+IEqmHciYvBya+smav4KEZbRLgkh0vm6BmvVwM9BqkFrKYX7IDJP2CMeMDN/WnPDx5j7dMSM0DiGS8Yeusqmh/k=
X-Received: by 2002:a05:6402:2056:b0:615:7e88:ef95 with SMTP id
 4fb4d7f45d1cf-61bf98dc1camr2668544a12.11.1755819821384; Thu, 21 Aug 2025
 16:43:41 -0700 (PDT)
MIME-Version: 1.0
References: <20250728-a38x_ddr-v1-1-4102aa87697c@linaro.org>
 <fc2eb511-430e-406a-a9fc-b47e6eb9812f@mailbox.org>
 <0d13343e-654a-417f-9f99-e33a5bc36301@mailbox.org>
In-Reply-To: <0d13343e-654a-417f-9f99-e33a5bc36301@mailbox.org>
From: Tony Dinh <mibodhi@gmail.com>
Date: Thu, 21 Aug 2025 16:43:29 -0700
X-Gm-Features: Ac12FXzUv3GCmBYURK8dxsGuUBo6LtCt6RBvrNFTdxV4FMdGOLar_tjMqg68qu0
Message-ID: <CAJaLiFyNmTQQr-bN_aj4bPCL-4Zb+rakQ7RGiGfvkFupKG3fvA@mail.gmail.com>
Subject: Re: [PATCH] ddr: marvell: a38x: Fix unsigned issues
To: Stefan Roese <stefan.roese@mailbox.org>, Tom Rini <trini@konsulko.com>
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>, u-boot@lists.denx.de
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

Hi Tom and Stefan,

It looks like we have some problem with ./scripts/get_maintainer.pl. I
was the author for the Marvell A38x DDR4 port (Commit 54a08c4), but
curiously I did not receive patch email from Andrew. So I ran the
script,

./scripts/get_maintainer.pl drivers/ddr/marvell/a38x/
Stefan Roese <stefan.roese@mailbox.org> (maintainer:ARM MARVELL
KIRKWOOD ARMADA-XP ARMADA-38X ARMAD...,commit_signer:1/2=3D50%)
Tom Rini <trini@konsulko.com> (maintainer:THE REST)
Simon Glass <sjg@chromium.org> (commit_signer:1/2=3D50%,authored:1/2=3D50%)
Andrew Goodbody <andrew.goodbody@linaro.org>
(commit_signer:1/2=3D50%,authored:1/2=3D50%)
u-boot@lists.denx.de (open list)

Anyway, my regression test for this patch with Thecus N2350 board
shows no problem!
Tested-by: Tony Dinh <mibodhi@gmail.com>

All the best,
Tony

On Tue, Jul 29, 2025 at 6:21=E2=80=AFAM Stefan Roese <stefan.roese@mailbox.=
org> wrote:
>
> On 29.07.25 08:41, Stefan Roese wrote:
> > On 28.07.25 16:26, Andrew Goodbody wrote:
> >> Cannot test an unsigned variable to be less than 0, it will always fai=
l.
> >>
> >> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> >
> > Reviewed-by: Stefan Roese <stefan.roese@mailbox.org>
>
> Applied to u-boot-marvell/master
>
> Thanks,
> Stefan
>
> > Thanks,
> > Stefan
> >
> >> ---
> >>   drivers/ddr/marvell/a38x/mv_ddr4_training_calibration.c | 13 ++++++
> >> +------
> >>   1 file changed, 7 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/drivers/ddr/marvell/a38x/mv_ddr4_training_calibration.c
> >> b/drivers/ddr/marvell/a38x/mv_ddr4_training_calibration.c
> >> index 31b6209416b..84156a1e8ad 100644
> >> --- a/drivers/ddr/marvell/a38x/mv_ddr4_training_calibration.c
> >> +++ b/drivers/ddr/marvell/a38x/mv_ddr4_training_calibration.c
> >> @@ -64,7 +64,7 @@ static u8 center_high_element_get(u8 dir, u8
> >> pbs_element, u16 lambda, u8 pbs_max
> >>   static int mv_ddr4_centralization(u8 dev_num, u16 (*lambda)
> >> [MAX_BUS_NUM][BUS_WIDTH_IN_BITS], u8 (*copt)[MAX_BUS_NUM],
> >>                     u8 (*pbs_result)[MAX_BUS_NUM][BUS_WIDTH_IN_BITS],
> >> u8 (*vw_size)[MAX_BUS_NUM],
> >>                     u8 mode, u16 param0, u8 param1);
> >> -static int mv_ddr4_dqs_reposition(u8 dir, u16 *lambda, u8
> >> *pbs_result, char delta, u8 *copt, u8 *dqs_pbs);
> >> +static int mv_ddr4_dqs_reposition(u8 dir, u16 *lambda, u8
> >> *pbs_result, s8 delta, u8 *copt, u8 *dqs_pbs);
> >>   static int mv_ddr4_copt_get(u8 dir, u16 *lambda, u8 *vw_l, u8 *vw_h,
> >> u8 *pbs_result, u8 *copt);
> >>   static int mv_ddr4_center_of_mass_calc(u8 dev_num, u8 if_id, u8
> >> subphy_num, u8 mode, u8 *vw_l, u8 *vw_h, u8 *vw_v,
> >>                          u8 vw_num, u8 *v_opt, u8 *t_opt);
> >> @@ -659,7 +659,7 @@ static int mv_ddr4_centralization(u8 dev_num, u16
> >> (*lambda)[MAX_BUS_NUM][BUS_WID
> >>       } /* if_id */
> >>       /* restore cs enable value*/
> >> -    for (if_id =3D 0; if_id < MAX_INTERFACE_NUM - 1; if_id++) {
> >> +    for (if_id =3D 0; if_id < MAX_INTERFACE_NUM; if_id++) {
> >>           VALIDATE_IF_ACTIVE(tm->if_act_mask, if_id);
> >>           status =3D ddr3_tip_if_write(dev_num, ACCESS_TYPE_UNICAST,
> >> if_id, DUAL_DUNIT_CFG_REG,
> >>                          cs_ena_reg_val[if_id], MASK_ALL_BITS);
> >> @@ -895,7 +895,7 @@ static int mv_ddr4_copt_get(u8 dir, u16 *lambda,
> >> u8 *vw_l, u8 *vw_h, u8 *pbs_res
> >>    * It provides with a solution for a single subphy (8 bits).
> >>    * The calling function is responsible for any additional pbs taps
> >> for dqs
> >>    */
> >> -static int mv_ddr4_dqs_reposition(u8 dir, u16 *lambda, u8
> >> *pbs_result, char delta, u8 *copt, u8 *dqs_pbs)
> >> +static int mv_ddr4_dqs_reposition(u8 dir, u16 *lambda, u8
> >> *pbs_result, s8 delta, u8 *copt, u8 *dqs_pbs)
> >>   {
> >>       u8 dq_idx;
> >>       u32 pbs_max_val =3D 0;
> >> @@ -952,7 +952,8 @@ static int mv_ddr4_center_of_mass_calc(u8 dev_num,
> >> u8 if_id, u8 subphy_num, u8 m
> >>       int t_opt_temp =3D 0, v_opt_temp =3D 0;
> >>       int vw_avg =3D 0, v_avg =3D 0;
> >>       int s0 =3D 0, s1 =3D 0, s2 =3D 0, slope =3D 1, r_sq =3D 0;
> >> -    u32 d_min =3D 10000, reg_val =3D 0;
> >> +    u32 reg_val =3D 0;
> >> +    int d_min =3D 10000;
> >>       int status;
> >>       /*
> >> @@ -2189,7 +2190,7 @@ int mv_ddr4_dm_tuning(u32 cs, u16
> >> (*pbs_tap_factor)[MAX_BUS_NUM][BUS_WIDTH_IN_BI
> >>                   for (dq =3D 0; dq < BUS_WIDTH_IN_BITS; dq++) {
> >>                       idx =3D dq + subphy * BUS_WIDTH_IN_BITS;
> >>                       reg_val =3D new_dq_pbs[dq] - dq_pbs_diff;
> >> -                    if (reg_val < 0) {
> >> +                    if (new_dq_pbs[dq] < dq_pbs_diff) {
> >>                           DEBUG_DM_TUNING(DEBUG_LEVEL_ERROR,
> >>                                   ("unexpected negative value found\n"=
));
> >>                           return MV_FAIL;
> >> @@ -2267,7 +2268,7 @@ int mv_ddr4_dm_tuning(u32 cs, u16
> >> (*pbs_tap_factor)[MAX_BUS_NUM][BUS_WIDTH_IN_BI
> >>                           idx =3D dq + subphy * BUS_WIDTH_IN_BITS;
> >>                           pad =3D dq_map_table[idx];
> >>                           reg_val =3D new_dq_pbs[dq] - dq_pbs_diff;
> >> -                        if (reg_val < 0) {
> >> +                        if (new_dq_pbs[dq] < dq_pbs_diff) {
> >>                               DEBUG_DM_TUNING(DEBUG_LEVEL_ERROR,
> >>                                       ("unexpected negative value
> >> found\n"));
> >>                               return MV_FAIL;
> >>
> >> ---
> >> base-commit: 4c3b5fcd810081bd7f3c51859fe1b5f0c159803c
> >> change-id: 20250728-a38x_ddr-64c67d8a63a2
> >>
> >> Best regards,
> >
>
