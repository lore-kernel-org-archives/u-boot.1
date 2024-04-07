Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A50FFCD11C2
	for <u-boot@archiver.kernel.org>; Sun,  7 Apr 2024 11:22:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7F0A87EBD;
	Sun,  7 Apr 2024 13:22:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZYyUjQ6Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8003587EDC; Sun,  7 Apr 2024 13:22:17 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4DB7F87DF3
 for <u-boot@lists.denx.de>; Sun,  7 Apr 2024 13:22:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@gmail.com
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-34584c783acso148719f8f.1
 for <u-boot@lists.denx.de>; Sun, 07 Apr 2024 04:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712488935; x=1713093735; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CiI9qvISMccjFr8eMtR0uzgCzC6YBAtq8ozWmzYxTyM=;
 b=ZYyUjQ6ZBqk4ToxiX7+JRVhktj5AddXdcbU45taD+nAJyISk2SqATRrT3IkplUkPNe
 ejaocG3AdcgsZGhhTUGZV96CgAuFwedtShTCwjS9byd04tUMdaeQfvPlFJdL52QHqrJP
 IGVqZsf7O0yH7ay1w0Qm6oTLE/g/1vY0aGS9LBg0skvPTrZeujz1BvPj/p4ffUvoHl2O
 EEn5qq+10YhwU9Utpy8oUPKVpPdVdHDIBAjIRWgEBZj93nUivHVBMn4VYkfJGaLhJrpr
 PtFHcl0glcOgo+4uEg0RrV6V4geH1FAsMwbA554hEs49CG0yo+HSxsvrh/uY7BGZzjrk
 zAuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712488935; x=1713093735;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CiI9qvISMccjFr8eMtR0uzgCzC6YBAtq8ozWmzYxTyM=;
 b=ec+RcLgNPei/l7e+JiiHi1Zp9nsPYz7+J0RQOtt47+nV1Ru5I2lf9K17YJv7U0Ax0X
 51iGGW5TUx+uLQGOg/WGx9L01Yy3SRB6xnSQBMMMPZamkIKRvv5ZexSGR4gYuGO4+50k
 3qIkY2pdvdFTp31mFql35WHturgbEY31SOc5B1Dwej0HiSUWgq61ZNKvDsByKaSYn/Wm
 9o0KVkuhQqKLV5gbSRE82Vf5ZML3qBbzkUWDUmN7YHp7g9D6/WD9YuO+hA1BEtAsr6p9
 Z/yQ1dBOCvjMtYmvnPE1irpHrZVvqG+/oO7TFM4jxF2OsyOWmPYLJBWOAVj7fbGLRZ+b
 XoaQ==
X-Gm-Message-State: AOJu0YznxCqxT+RSpcl4jIylDquZUsS8RED/6pjjcu4kaREMJ9vV701S
 6+Q0hYtHr7wqEDV2/epO4SxGSNiRgcbdUL1ER0evWgvh7v+z1KqplBLPwSinsGW3WHsDShaRwlq
 zYJ0G4DjimKxh1HkcueokvnTRh2AYCfaW2LdnTbaf
X-Google-Smtp-Source: AGHT+IE3ZNwZW+/U08KVkDFDCta2fnzkWumFuDfDBKcpaRi/02AzBp9gm4TYRpqTmOv+/poF7n0VhhxQwhkKcnWjeHo=
X-Received: by 2002:a5d:64ec:0:b0:343:b5f0:f510 with SMTP id
 g12-20020a5d64ec000000b00343b5f0f510mr5182169wri.1.1712488934376; Sun, 07 Apr
 2024 04:22:14 -0700 (PDT)
MIME-Version: 1.0
References: <20240407014743.13872-1-mwleeds@mailtundra.com>
 <20240407014743.13872-2-mwleeds@mailtundra.com>
In-Reply-To: <20240407014743.13872-2-mwleeds@mailtundra.com>
From: Igor Opaniuk <igor.opaniuk@gmail.com>
Date: Sun, 7 Apr 2024 13:22:03 +0200
Message-ID: <CAByghJb7nkhZqeGqJxbs9DujSJP02tvCmD20zor8U5KhwD9PMg@mail.gmail.com>
Subject: Re: [PATCH 1/5] zfs: Fix malloc() success check
To: mwleeds@mailtundra.com
Cc: u-boot@lists.denx.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi Phaedrus,

On Sun, Apr 7, 2024 at 4:00=E2=80=AFAM <mwleeds@mailtundra.com> wrote:

> This code was hitting the error code path whenever malloc() succeeded
> rather than when it failed, so presumably this part of the code hasn't
> been tested. I had to apply this fix (and others) to get U-Boot to boot
> from ZFS on an Nvidia Jetson TX2 NX SoM (an aarch64 computer).
>
> Signed-off-by: Phaedrus Leeds <mwleeds@mailtundra.com>
> Tested-by: Phaedrus Leeds <mwleeds@mailtundra.com>
>
It's an abuse of the Tested-by tag. If you are the author of the patch,
that obviously implies that you tested it before sending to ML.
Signed-off-by is enough in this case.

---
>  fs/zfs/zfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/zfs/zfs.c b/fs/zfs/zfs.c
> index 1fec96cd5c..14779dee32 100644
> --- a/fs/zfs/zfs.c
> +++ b/fs/zfs/zfs.c
> @@ -648,21 +648,21 @@ dmu_read(dnode_end_t *dn, uint64_t blkid, void **bu=
f,
>                 if (bp_array !=3D dn->dn.dn_blkptr) {
>                         free(bp_array);
>                         bp_array =3D 0;
>                 }
>
>                 if (BP_IS_HOLE(bp)) {
>                         size_t size =3D zfs_to_cpu16(dn->dn.dn_datablkszs=
ec,
>
>               dn->endian)
>                                 << SPA_MINBLOCKSHIFT;
>                         *buf =3D malloc(size);
> -                       if (*buf) {
> +                       if (!*buf) {
>                                 err =3D ZFS_ERR_OUT_OF_MEMORY;
>                                 break;
>                         }
>                         memset(*buf, 0, size);
>                         endian =3D (zfs_to_cpu64(bp->blk_prop, endian) >>
> 63) & 1;
>                         break;
>                 }
>                 if (level =3D=3D 0) {
>                         err =3D zio_read(bp, endian, buf, 0, data);
>                         endian =3D (zfs_to_cpu64(bp->blk_prop, endian) >>
> 63) & 1;
> --
> 2.44.0
>
>

--=20
Best regards - Atentamente - Meilleures salutations

Igor Opaniuk

mailto: igor.opaniuk@gmail.com
skype: igor.opanyuk
https://www.linkedin.com/in/iopaniuk <http://ua.linkedin.com/in/iopaniuk>
