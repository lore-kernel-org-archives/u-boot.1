Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F883EA3C55
	for <u-boot@archiver.kernel.org>; Thu,  9 Apr 2026 11:23:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EBA26839D5;
	Thu,  9 Apr 2026 13:23:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="e9OYmPlW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B59783CF5; Thu,  9 Apr 2026 13:23:33 +0200 (CEST)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 403DA83693
 for <u-boot@lists.denx.de>; Thu,  9 Apr 2026 13:23:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-6701fb93f23so1130436a12.0
 for <u-boot@lists.denx.de>; Thu, 09 Apr 2026 04:23:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775733811; cv=none;
 d=google.com; s=arc-20240605;
 b=h38v/7PN/9kzEI0mhCtt9eeBG9csCnAKuZ3Na0WAELSMsifGZLly5olOgA9zKKkGwq
 wdYMxW5LlWtR/ob4MmoLTPDleqsGn0CMXsdLjAV+WaFdoq80hpRA2t+EqQmrM/poIjl+
 6f061HIfH24WObxXsjZHSaXy22vtDT+cv+OqJHFxTpfSxAe+d3JxAzBUM6Bvn8s++ohX
 3Q0os8uEARojZpWbozgV+xwE1U5ljCnj/fR8FKDUi9d1zJ35ACAMYILoWA6YTBgEKitA
 GarsAnprgmSnhYl+Etjk/Kryp/Q91VNa4NvhutwDNFYaSPeVLsTkxtiyldRcGisNXfV0
 N/hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=01pC7f/oelZN+k99EsnyykuFmKj1djSakS7FoRMJeU8=;
 fh=Q4E8D5Ml1lxOcrFoI58S5ys7OkxciEB0mbpSv384Em8=;
 b=GIOywx3pTJju63/PrC2o4MzzYYyBLxPQP+n3ffSKzov3tPBqbbXmGsNWBU8mHr+TM2
 n6nzo31Dj09/KdZyL1yVUWA1oksvNz2lDax01DapDC+J1HWfuPXLZ7PiyuxH4XfCV9P+
 9k4ejUVIWPLybFweVrUBKQObcWm9ft6SvAw+k+8Ymnu/Jg7ybUdt3NI7nCyUpS3ytAzk
 gI1Whp10rrxr6QCqk+x26hBRL5pNSscmYj6NPHBOfdgkxGHxX4zpmh862xp3VWpRbNPN
 xf2WBuJFdomb7a06V2zjlzJVyEb76qPUisopU+pFmQkVVP/UXNfp6OBKjwru9SYXZkhx
 50iQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1775733811; x=1776338611;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=01pC7f/oelZN+k99EsnyykuFmKj1djSakS7FoRMJeU8=;
 b=e9OYmPlWLOddTwryj+lJhUeiJY0fmKQXK/2NjEoZ4qGoQs6C6Ku44ynUvVh9KbYh9r
 dPQfoBD15VYhrpWbaUHpoNzJ/d78m2v3qyye7HQ1CESpJG5MrswobsKw4vZXuO59c3xu
 NTC8iRu7U0neZT1/87+r89QaC2NwFTA8etN//QR6dkn02CJ0JgwGHiU06kLYqco7s9Cs
 iH4l+bPSpFlohdQhMVQqVTltG5Lho45SkaPQfach6BScRJ4EAOxted9YhS7cEDolAc+o
 RaafRn3aBcRH2r8EgpVjcStKlV+L+vDEpD1T3dF7QwDdQcNVpMCWlBBnyDmaHuEfxzGe
 akMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775733811; x=1776338611;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=01pC7f/oelZN+k99EsnyykuFmKj1djSakS7FoRMJeU8=;
 b=UzPicF7DpcHaYzjwPDwJFiLQU5omTxQp4DbBm5ymrlhe5VNg/WAurhv5h2IbR1YFJk
 Ce0VZKKQrUxCx85X1+2WrF2momoBaveD0a3XtbkmRPDft4DznRAiuoXxs3iDUwAF43Xo
 GMYMyxF+Ghesj7Slu0l3mKfZ1GYxusCSt6Zj77CcB+Thcl8vGZlVVRWQ/WoUugVjPhX7
 hTDBLM0xACRf52NbfQDa2OFVYe+LFmEIUC9+L5TRd0qg2LeimWMB8sKXcowP1/TDZIaO
 krA8q6VYJj7IyebiGvAjYx62XYmc13w1r4P50CXjOw67NbuS472P8vcvHAtvjLOUgcHz
 n2eg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXxI6gzNhLt3HknjWckU0gBkFYz41UYnalqYvt0aC9R//2Ov5ya21bkbT2Otsyf8gK8I+Sy8JA=@lists.denx.de
X-Gm-Message-State: AOJu0YwxF1B7WWa1aveFi/FkCkIQKWoRPDL8OEFOyFAe8q0APcXiLPxZ
 7/obFXVl6nRmS4N9UgwkXX2m5iFDmwpKQPKjAkMxHrPS11EL+cw6O3dUM5MOZEcEGTUBn0SbVN2
 JVvpsZC/zvV+aTlTaMjkAoitoPWsmTcrrrXXuOjAPyQ==
X-Gm-Gg: AeBDiesvQK0P1hrXAyL5PhSF6ZvCuOkCKJ0FM9BShY4cGnRoV6BpDcC0YbwPBlKJSAl
 Tit0VeKfldk3/why8LpJg+LiyvVaj4nw0TE0guKEOZrGaI252teaaE5WCSrOXsNa7vW+xyWTy8A
 cnyoFSRnegvsMzUO3sXc0HOInldpyf0mYnydndjFz4sTS6FR0dkfAw87KJL8jDG51eWlMuip1Fb
 GVTp9LJP0vuyqWL2D5vGOM3XwMQPNv8WsF8tld4Qsk2rhGNWiWWlRYX4vmaL7QRv0dOyCabkgYy
 hHY5zyoAYeKg900Al+2OB173Zr9oRSytSwuxHcsRU8ZCUDg+2H6JD66YFfnTPT8uLVwE7vhzaXh
 aQt12Oz6aPpqi0UMPWywbLW6Eog==
X-Received: by 2002:a17:907:3e04:b0:b94:1df4:3525 with SMTP id
 a640c23a62f3a-b9c672e4d6bmr1243056766b.1.1775733810556; Thu, 09 Apr 2026
 04:23:30 -0700 (PDT)
MIME-Version: 1.0
References: <20260327-mtk-pmic-fixes-v1-0-ef874ca82409@baylibre.com>
 <20260327-mtk-pmic-fixes-v1-1-ef874ca82409@baylibre.com>
In-Reply-To: <20260327-mtk-pmic-fixes-v1-1-ef874ca82409@baylibre.com>
From: Julien Stephan <jstephan@baylibre.com>
Date: Thu, 9 Apr 2026 13:23:25 +0200
X-Gm-Features: AQROBzDUfPfdyZ3Q0SZEXNA8ZgONWyC_iUH0PQiiROWSUlTo4XGWdjXAEptYlTc
Message-ID: <CAEHHSvbf1JRo6adE8VCYiA5SdHGAYHRse0Lm6yD3qcf1b5EGAQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] power: pmic: mtk-pwrap: add init capability flag
To: David Lechner <dlechner@baylibre.com>
Cc: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
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

Le ven. 27 mars 2026 =C3=A0 20:03, David Lechner <dlechner@baylibre.com> a =
=C3=A9crit :
>
> Add a PWRAP_CAP_INIT capability flag to specify if it is safe to call
> pwrap_init() or not. Not all targets define the registers accessed
> by pwrap_init(). In that case, it is expected that an earlier bootloader
> has already initialized the PMIC. If not, we now return an error instead
> of trying to access undefined registers.
>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>  drivers/power/pmic/mtk-pwrap.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/power/pmic/mtk-pwrap.c b/drivers/power/pmic/mtk-pwra=
p.c
> index 446b78fb0ee..9ff06fdb3bd 100644
> --- a/drivers/power/pmic/mtk-pwrap.c
> +++ b/drivers/power/pmic/mtk-pwrap.c
> @@ -62,6 +62,8 @@ static const struct pmic_child_info mt6359_pmic_childre=
n_info[] =3D {
>  #define PWRAP_CAP_INT1_EN              BIT(3)
>  #define PWRAP_CAP_WDT_SRC1             BIT(4)
>  #define PWRAP_CAP_ARB                  BIT(5)
> +/* To implement this capability, the registers used in pwrap_init() must=
 be defined. */
> +#define PWRAP_CAP_INIT                 BIT(6)
>
>  /* defines for slave device wrapper registers */
>  enum dew_regs {
> @@ -752,6 +754,11 @@ static int mtk_pwrap_probe(struct udevice *dev)
>          * Skip initialization here in this case.
>          */
>         if (!pwrap_readl(wrp, PWRAP_INIT_DONE2)) {
> +               if (!HAS_CAP(wrp->master->caps, PWRAP_CAP_INIT)) {
> +                       dev_err(dev, "initialization is required but not =
supported\n");
> +                       return -ENODEV;
what about : return -ENOTSUPP ?

> +               }
> +
>                 ret =3D pwrap_init(wrp);
>                 if (ret) {
>                         dev_err(dev, "init failed with %d\n", ret);
> @@ -905,7 +912,7 @@ static const struct pmic_wrapper_type pwrap_mt8365 =
=3D {
>         .int1_en_all =3D 0x0,
>         .spi_w =3D PWRAP_MAN_CMD_SPI_WRITE,
>         .wdt_src =3D PWRAP_WDT_SRC_MASK_ALL,
> -       .caps =3D PWRAP_CAP_INT1_EN | PWRAP_CAP_WDT_SRC1,
> +       .caps =3D PWRAP_CAP_INT1_EN | PWRAP_CAP_WDT_SRC1 | PWRAP_CAP_INIT=
,
>  };
>
>  static const struct udevice_id mtk_pwrap_ids[] =3D {
>
> --
> 2.43.0
>
