Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0842BC87FCB
	for <u-boot@archiver.kernel.org>; Sun,  3 Aug 2025 08:12:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0C34D83BB5;
	Sun,  3 Aug 2025 10:12:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="bFuzAZEM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A450B83C67; Sun,  3 Aug 2025 10:12:07 +0200 (CEST)
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com
 [IPv6:2607:f8b0:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E39B983B5F
 for <u-boot@lists.denx.de>; Sun,  3 Aug 2025 10:12:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael@amarulasolutions.com
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-b34c068faf8so3541207a12.2
 for <u-boot@lists.denx.de>; Sun, 03 Aug 2025 01:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1754208723; x=1754813523;
 darn=lists.denx.de; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hayk1yNflQc5UUXr2YccUCUe18PpU1HKEwM8SBTIq3g=;
 b=bFuzAZEM9136ILbB6LMiPnDx+RGVbms/ft3iwU52/Vb0Pb2j0slcO3RipTJ2Ndb3xi
 +UqFc0e/o6BdCmVi7qD4+EMBgWyYbR1x3DlfjZ/rUQfJOTKpU/0gF1sHMxnGxrLdEs//
 zIvfMRWb6aWl0YRiFgrKCYv8SIZlx6MA7/2w0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754208723; x=1754813523;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hayk1yNflQc5UUXr2YccUCUe18PpU1HKEwM8SBTIq3g=;
 b=hx3Yz1I95+lN+dVbbTi/NYXgSq/JX3CEdpqny9v4BfNWxB1TqUNJlR2Ke39YiHxuMg
 4Smfv+BbQP8IDDCXK7SOT+TUWW7pNT14aXQucJGDd1JyUHUqHs2bPZ6KU5UUCb81rVyB
 pTKqrPPti55JNIgwZ34qU422eFmy0XT10hnCWi80uhEd6Y8qiFOHroAv1s1m6231DHMX
 jaYMGhkko/WCew2ZLPYTKWv1DUoOuTcuJc1How33Rkxq2fXgO9Rvns0BQQE/xwnJ1NPM
 8ccZUdxzamfmkyLABDGLMbKyiKgyrg6J5LuCL922P9qeyuC6G2FlKdn49j1WDt4w+i8w
 AMlw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUayAcb/bieGMXwFWkUh3VdCOffro6/EurhlVnr+CdKXpuK03trwBxptXQLatHEAQ0p6cNVUAY=@lists.denx.de
X-Gm-Message-State: AOJu0YzhI393pKuz1ODpHXoGnFTX+pIhFE8VGURVkEpKk/RQvYHLeJiA
 6uFw2+/xSiC3LgyA2ElhRqNj+uRN1+cbBxsQzMehyWOAluskXg2/iLpemY9cKXM/dBU3T2eQ+px
 s8AsuiVVU3Rx7I4X7WWWgYXjFZC40PQ7XB4bIMzlv7w==
X-Gm-Gg: ASbGncvo7mQo/+f1gPbfrDOlkGIFjk90HTRaupXvRQt5KdcJs7l6tOCEQ1BvEKgsl2R
 E259ICNX+VdQp4SUrcunQH/K9/xM4YMf+gnJ38dCu1vJEuC7WnUGDMzNU3OvaNeM8/v8Gn+culX
 cTSivyiDzZ6cVvyRxwyczLSHW8gg6amEyYqdUscnfmADnxCBx/oWTf1Q7I9/3TntsK5CQE4uKzR
 +aDfQ==
X-Google-Smtp-Source: AGHT+IGS8+qTnTp6eD8Fw/14Y92bZ65a74kNsvn4/0KOLorjUti//qgVnT6VGzhoHOAMoJubRxErdVsEAzp1b3DN8jE=
X-Received: by 2002:a17:90b:4a81:b0:31f:210d:2e56 with SMTP id
 98e67ed59e1d1-3211630de49mr6886013a91.28.1754208723155; Sun, 03 Aug 2025
 01:12:03 -0700 (PDT)
MIME-Version: 1.0
References: <20250801-mtd_nand_raw2-v1-0-bdabdeb35b46@linaro.org>
 <20250801-mtd_nand_raw2-v1-3-bdabdeb35b46@linaro.org>
In-Reply-To: <20250801-mtd_nand_raw2-v1-3-bdabdeb35b46@linaro.org>
From: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date: Sun, 3 Aug 2025 10:11:51 +0200
X-Gm-Features: Ac12FXwKG0lKXI8lMDVxLNPHnayVxth5FpgWVhwLnWJjbPKvMnawjNj5WgM5xdY
Message-ID: <CAOf5uwnL_O4WGy3-n4QNbziv4X7EC+3N2tnUycDu5WH-6JPBwQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] mtd: nand: sunxi: Free allocated memory on errors
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Tom Rini <trini@konsulko.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, u-boot@lists.denx.de, 
 uboot-stm32@st-md-mailman.stormreply.com
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

Hi

On Fri, Aug 1, 2025 at 12:39=E2=80=AFPM Andrew Goodbody <andrew.goodbody@li=
naro.org>
wrote:

> Add kfree calls on error paths for memory that was allocated. This will
> prevent memory leaks.
>
> This issue found by Smatch.
>
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
>  drivers/mtd/nand/raw/sunxi_nand.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mtd/nand/raw/sunxi_nand.c
> b/drivers/mtd/nand/raw/sunxi_nand.c
> index 34197bb09a1..1ce09b56b80 100644
> --- a/drivers/mtd/nand/raw/sunxi_nand.c
> +++ b/drivers/mtd/nand/raw/sunxi_nand.c
> @@ -1403,8 +1403,10 @@ static int
> sunxi_nand_hw_common_ecc_ctrl_init(struct mtd_info *mtd,
>         if (!data)
>                 return -ENOMEM;
>
> -       if (ecc->size !=3D 512 && ecc->size !=3D 1024)
> +       if (ecc->size !=3D 512 && ecc->size !=3D 1024) {
> +               kfree(data);
>                 return -EINVAL;
> +       }
>
>         /* Prefer 1k ECC chunk over 512 ones */
>         if (ecc->size =3D=3D 512 && mtd->writesize > 512) {
> @@ -1641,17 +1643,20 @@ static int sunxi_nand_chip_init(struct udevice
> *dev, struct sunxi_nfc *nfc,
>                 if (ret) {
>                         dev_err(dev, "could not retrieve reg property:
> %d\n",
>                                 ret);
> +                       kfree(chip);
>                         return ret;
>                 }
>
>                 if (tmp > NFC_MAX_CS) {
>                         dev_err(dev,
>                                 "invalid reg value: %u (max CS =3D 7)\n",
> tmp);
> +                       kfree(chip);
>                         return -EINVAL;
>                 }
>
>                 if (test_and_set_bit(tmp, &nfc->assigned_cs)) {
>                         dev_err(dev, "CS %d already assigned\n", tmp);
> +                       kfree(chip);
>                         return -EINVAL;
>                 }
>
> @@ -1678,12 +1683,14 @@ static int sunxi_nand_chip_init(struct udevice
> *dev, struct sunxi_nfc *nfc,
>                 dev_err(dev,
>                         "could not retrieve timings for ONFI mode 0: %d\n=
",
>                         ret);
> +               kfree(chip);
>                 return ret;
>         }
>
>         ret =3D sunxi_nand_chip_set_timings(nfc, chip, timings);
>         if (ret) {
>                 dev_err(dev, "could not configure chip timings: %d\n",
> ret);
> +               kfree(chip);
>                 return ret;
>         }
>
> @@ -1705,8 +1712,10 @@ static int sunxi_nand_chip_init(struct udevice
> *dev, struct sunxi_nfc *nfc,
>
>         mtd =3D nand_to_mtd(nand);
>         ret =3D nand_scan_ident(mtd, nsels, NULL);
> -       if (ret)
> +       if (ret) {
> +               kfree(chip);
>                 return ret;
> +       }
>
>         if (nand->bbt_options & NAND_BBT_USE_FLASH)
>                 nand->bbt_options |=3D NAND_BBT_NO_OOB;
> @@ -1719,24 +1728,28 @@ static int sunxi_nand_chip_init(struct udevice
> *dev, struct sunxi_nfc *nfc,
>         ret =3D sunxi_nand_chip_init_timings(nfc, chip);
>         if (ret) {
>                 dev_err(dev, "could not configure chip timings: %d\n",
> ret);
> +               kfree(chip);
>                 return ret;
>         }
>
>         ret =3D sunxi_nand_ecc_init(mtd, &nand->ecc);
>         if (ret) {
>                 dev_err(dev, "ECC init failed: %d\n", ret);
> +               kfree(chip);
>                 return ret;
>         }
>
>         ret =3D nand_scan_tail(mtd);
>         if (ret) {
>                 dev_err(dev, "nand_scan_tail failed: %d\n", ret);
> +               kfree(chip);
>                 return ret;
>         }
>
>         ret =3D nand_register(devnum, mtd);
>         if (ret) {
>                 dev_err(dev, "failed to register mtd device: %d\n", ret);
> +               kfree(chip);
>                 return ret;
>         }
>

Reviewed-By: Michael Trimarchi <michael@amarulasolutions.com>



>
> --
> 2.39.5
>
>

--=20
Michael Nazzareno Trimarchi
Co-Founder & Chief Executive Officer
M. +39 347 913 2170
michael@amarulasolutions.com
__________________________________

Amarula Solutions BV
Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
T. +31 (0)85 111 9172
info@amarulasolutions.com
www.amarulasolutions.com
