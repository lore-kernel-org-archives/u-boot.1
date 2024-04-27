Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFE08C4345F
	for <u-boot@archiver.kernel.org>; Sat, 27 Apr 2024 00:09:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3568A882FE;
	Sat, 27 Apr 2024 02:09:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks.com header.i=@gateworks.com header.b="OrAoYgFH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 05E21882FA; Sat, 27 Apr 2024 02:09:02 +0200 (CEST)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B87FE882FE
 for <u-boot@lists.denx.de>; Sat, 27 Apr 2024 02:08:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-51d20472133so21367e87.3
 for <u-boot@lists.denx.de>; Fri, 26 Apr 2024 17:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks.com; s=google; t=1714176538; x=1714781338; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z50E88vs15STnFHHCHRd5qxUDmikMMx8zG1R866xF98=;
 b=OrAoYgFHx/JyTIeK09dc0rGPy+qMJEgrg63B/UrxaAs+o9lAu+X+7Z6oO6jsCzzJy4
 yT+cCL0NYzuN5DZnBz0PXnneNfFkBecPfu75ZJ2EEUVaHU97nxU12IRb3UR0Jjbhh1sc
 MKvJ5La/EKo9uyJTAP6lhJzpLxY9yWEl0EvDCXetlKsWRGd3GKJaHCH4JAzUdZzMX81l
 1HN29hpv3ruAMYbP/lJluwmRiIN5YCl0t942VxyJkj6DVCql1jPg0z7JCEEVL5As7Ya5
 6INiWUOVwGsq2TFM/8ME3EIFPVx0+4SuV/wCIDN+pvlZVO2V/MAGmXESGwu4NW4b0iGb
 qxog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714176538; x=1714781338;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z50E88vs15STnFHHCHRd5qxUDmikMMx8zG1R866xF98=;
 b=cv0c1CaC8m7iYOaIn3mNETpQsfLa7xllVxfbha4ZFVCKQtXam2sQGbyc6wl2Oalp+k
 N8Cm1bG86a8dvyQyvXkjnKppNmtCDPHnF6357NmOguVo7f2Kv182gaJE12WEFJ7vpazb
 iXUxjNkPvss+wYxhJ4xuE4rMkB+rYAnf87Zo8iWMI4HUlx0xyb5xgXZ8BlBswT6yaNcy
 pdRfrTt+sCZhvkN2XewUXz/Z+L/RqmSut6vzQNR+cOR0i14p4kpXozsu15yOwYjjfJ7P
 rPM0OUWO68lI0ZBF8By3cJS+fPPgCdvdMwvFGv23nsO6hWn63U4L6JvHDCK7Q96GwV0S
 RPSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXq+vIRpejW0RtoKdTjns7kJeCq13rv5Y6cbUnjhUyNvcxtXyy7n5vbC+WjP6QKy8RcsjfK6j4A3eg+oJDz6qcNPqhyiA==
X-Gm-Message-State: AOJu0YyMLxS56hJxclVscw89CsR7K6RGTv1iLJoJS54TFUI0/oPJLW7X
 ZnCGmUJ2r30RREccm+pshSW/1RDj5KigX7zAAlAcW9uPdaHl6XGpv+J08dxNTQ20uqHUpf2okr7
 KLE3IXyGRvObm8fnZV10IzVQRwTzOge7r8v8JtQ==
X-Google-Smtp-Source: AGHT+IEMI3eCRMnPiWvNM4olL0HYJM5psWTvHIgyyNs9E4AyCGWhyrpDxRv2oK/yI2/HnIttiXTsklnvkRy2LXy1ki4=
X-Received: by 2002:ac2:5049:0:b0:518:6d2:2a8f with SMTP id
 a9-20020ac25049000000b0051806d22a8fmr2313451lfm.24.1714176537656; Fri, 26 Apr
 2024 17:08:57 -0700 (PDT)
MIME-Version: 1.0
References: <20240426165554.1376497-1-tharvey@gateworks.com>
 <cf40b1dd10eb915984717a9ae2247003@manjaro.org>
In-Reply-To: <cf40b1dd10eb915984717a9ae2247003@manjaro.org>
From: Tim Harvey <tharvey@gateworks.com>
Date: Fri, 26 Apr 2024 17:08:45 -0700
Message-ID: <CAJ+vNU0oS6zdwYxzkKt2QTzneSg1M1xhx8H7nYN1AEJaHKX3qg@mail.gmail.com>
Subject: Re: [PATCH] venice: show emmc boot hardware partition
To: Dragan Simic <dsimic@manjaro.org>
Cc: Fabio Estevam <festevam@gmail.com>, u-boot@lists.denx.de,
 Marek Vasut <marex@denx.de>
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

On Fri, Apr 26, 2024 at 12:26=E2=80=AFPM Dragan Simic <dsimic@manjaro.org> =
wrote:
>
> Hello Tim,
>
> Please see my comments below.
>
> On 2024-04-26 18:55, Tim Harvey wrote:
> > To aid in understanding what emmc hardware partition is being
> > used to boot on power-up, display the hardware partition name in the
> > SPL.
> >
> > Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> > ---
> >  board/gateworks/venice/spl.c | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> >
> > diff --git a/board/gateworks/venice/spl.c
> > b/board/gateworks/venice/spl.c
> > index 3b0f11f2fd0f..531bad260b6d 100644
> > --- a/board/gateworks/venice/spl.c
> > +++ b/board/gateworks/venice/spl.c
> > @@ -366,9 +366,25 @@ unsigned long
> > board_spl_mmc_get_uboot_raw_sector(struct mmc *mmc, unsigned long
> >
> >  const char *spl_board_loader_name(u32 boot_device)
> >  {
> > +     struct mmc *mmc;
> > +     int part;
> > +
> >       switch (boot_device) {
> >       /* SDHC2 */
> >       case BOOT_DEVICE_MMC1:
> > +             mmc_init_device(0);
> > +             mmc =3D find_mmc_device(0);
> > +             mmc_init(mmc);
> > +             part =3D EXT_CSD_EXTRACT_BOOT_PART(mmc->part_config);
> > +             switch (part) {
> > +             case 1:
> > +                     return "eMMC boot0";
> > +             case 2:
> > +                     return "eMMC boot1";
> > +             case 0:
> > +             case 7:
> > +                     return "eMMC user";
> > +             }
> >               return "eMMC";
> >       /* SDHC3 */
> >       case BOOT_DEVICE_MMC2:
>
> Your other patch on the mailing list does something similar. [1]
> Perhaps this is a good oportunity to extract and unify the logic
> that produces the names of eMMC partitions?  That would also allow
> other boards to use the same logic.
>

Hi Dragan,

Fair enough - I will resubmit both patches with this in mind.

Best Regards

Tim
