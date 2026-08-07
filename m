Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72AE4C5AC7A
	for <u-boot@archiver.kernel.org>; Fri,  7 Aug 2026 14:47:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 24E8540A69;
	Fri,  7 Aug 2026 14:47:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GtRDvh42ravj; Fri,  7 Aug 2026 14:47:24 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4DFDD40A07
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786114044;
	bh=zCkJHa1sEVzEnmqVuhFNjUudaJrqCsL1g+Z8k9MrZA0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0JgobehIbBaHBIIdTD+L9CQ0xYAIFu3ZI4xEQmtBf6JGZkK5AuzRnVaiu4rOf6JQ3
	 u2FSCLB4Z0R9jCddvZzGkm8HB01UBd2pO9kauxxvmZksc3GP++czGcJ+8qcNHKEx4G
	 U6s3IB38/2KkI5UWlkRb8qApqTQrLAoSN9aAZt5RG3rbD0ZCn5UmRWN12d51/DsrfM
	 Hrxyy4irs+VRK1YQs29oMYMvvWUHdyyD37FMO90oGinziqK4RE0yngNAHaaxNZhWyl
	 rbFPLW+pei4VY4Zskk9Uwa8ayH2yUa8eKSwYg+yAqUmOzsRI4ah2NWywrh6ZrOaGTi
	 0sfJVyhfJuYbA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4DFDD40A07;
	Fri,  7 Aug 2026 14:47:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 24D5FD3
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 14:47:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0B6CB8130D
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 14:47:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id R-OxVU81rvVO for <u-boot@lists.u-boot-project.org>;
 Fri,  7 Aug 2026 14:47:21 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::632; helo=mail-ej1-x632.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org DE48781322
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DE48781322
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DE48781322
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 14:47:20 +0000 (UTC)
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-c2055573c8cso363743866b.3
 for <u-boot@lists.u-boot-project.org>; Fri, 07 Aug 2026 07:47:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786114039; cv=none;
 d=google.com; s=arc-20260327;
 b=f7NpVeYg+wJoraRAVZUIoVQwY1O2nAdNci7grYLZlA2uCWSJBhRB8FwixQwiBvfeX5
 xbhk49qm4wqca2YvHPfOA+ldx00/QXP4v+4TlSkq87pYRGuYugz7I59u0iJ7R2qCAYZD
 fFptBCrQFzFdDKQVAeSESCSurmE4AkBsjY+p+Q9k1i1sw8vodaP5yNpcvnHVIl3UFQ8R
 xd4FDGheULf7BkVBB0okdltZsXLHRTsw4TsjwB8CSzIt/YF+eGOcz9Gfficysu8gwbq1
 xopeSkx86GItD3VcGbPqf1b4E5VNrrJk4UsLtVAF2Dczex2S55hZ18pY8ChYHi8Utf80
 Ijbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=zCkJHa1sEVzEnmqVuhFNjUudaJrqCsL1g+Z8k9MrZA0=;
 fh=Fcvzwn6crQPM6oHJvfgrovooJSB/EnfcBw72RqLWri8=;
 b=e0C1an7f+xfIQk3omwb7ebpNnIMELwYamyIh7DsufClpP/thMajyIZyzLD9xOVR93V
 Gj4s+q6wv3wwsg7Pr1nO+tqAdOR8qRNBCLLdXAxZN5LGSHjnIpMuACxdmj7/oilVvHWS
 c6u4VDAWXjkJ+7ntUBzZDnNbsSWSpEbte3vDv7aAmhpUQ3qQFk/oLLDh0RkYdLBkdXMm
 mFudTLlbAMFc9OmkxPfvlWxYjSOhkkg9HddomE7yXsqRfKI4CFRSLqRPBWplKhfeZZMv
 TUWoM5bpFauW/somnBEU2loqGNg2OX2ICOO9Bmsie6bPHsKOB2i+MoIGVVpjUq1y+UKh
 2NaQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786114039; x=1786718839;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zCkJHa1sEVzEnmqVuhFNjUudaJrqCsL1g+Z8k9MrZA0=;
 b=O7oDo52XuyTKuxrVvv+XxPec80M170Pjosng8HK6TJDhSAYk33VlOCjOBWT7cz2ApX
 u08+CTn5X7HuuMNDs3rjs/rubVR25j6KW1veaCvj/Y2ScbCphxlxBuyL5vXWvj/btjb1
 O6uCW4rq/D0Kjr9mcs0FtrGKjWcAb2Cs0gp91sTX/6XbOfCmz/zxEYtuTDliiWiUM7rK
 B2WO4LrlCGArjDPQ8xv77upvRQ3SAM4Gv3b8cFUTsyA8Jcb+zOyVUi2TgdgiRkltw4vT
 UhkJzq0uS54dqbjsAFYIxATBVCB5KNdfD3GjQrR+lKPQnG6BYCBULBmGGmKBCnn3CxyF
 3Byw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpAmJXCdl/T5npsx2zQ226OJ92Y+1SFXfCcZ8jmCA/3UkZzrf3IIiloOFXVRrWsN1GBSdNQLXU=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YzBbXBRL7JGsuTK+DariXZsfo8EMjuu37KwC5+Wf6l8wLBlIHID
 R2HMc+2FVBbG7GXMZnVsqSRwrRXj33Lgr/+GQY6ISaQ6zfOPn2paBXOOEpStSHTu0uOuEUhVHMr
 nB8gWDEyPAcWB+vABaQYXrxW2q1sZiIUcPy24O82tNV7/NoJQqFcaiEvVSA==
X-Gm-Gg: AR+sD10uxkExc7sDPDae56e5LDcxyJDfIgocawtedxfT9NWtfuqn0mqIE9d7p0QElAb
 tdPnwr9hDN4GEgKVt9mOuFJFOT7qZbmoaLyb3pyeS8QOTI/NDFb62UEZ8kSKClZL1jsaqKVjLvr
 167l8R127n+sFarn7NsQ7jGIi3GEEVhuO+3WM0EuBAEz2HV/qqcFrSb8ogq76uHVqDUctt+jxEt
 AOcjp7K1qjlQH/Ez6S9A5IMUxdlou5A2rOdremuaWAUf+0sYFaAj3nOLumrixeaGPmrcLAGlm8P
 elvn/2OTJ5s8LAkRfwdl3heUNmFS5DeuKFMZuz7ZXjQJaZcrbfkbEcPP9Feo/Lfj+lWn23Kj7ZY
 fjjtzNGGu2XA2y2mMh1Tw63jPqJNMx64bWJ1NVHc2eyNSOBOFPn9KijccUWZGZo9sTlHhG7q1IZ
 U=
X-Received: by 2002:a17:907:e1cc:10b0:c20:83b0:92d8 with SMTP id
 a640c23a62f3a-c2083b0934emr113934066b.0.1786114038870; Fri, 07 Aug 2026
 07:47:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260805-mtk-tphy-v3-v1-1-f1d6268b8d89@baylibre.com>
In-Reply-To: <20260805-mtk-tphy-v3-v1-1-f1d6268b8d89@baylibre.com>
From: Julien Stephan <jstephan@baylibre.com>
Date: Fri, 7 Aug 2026 16:47:07 +0200
X-Gm-Features: AUfX_myPX6LF5VUK5RDKsE1XVL6nyEiY4axTUMJj7nh5vIaE6Chryzod3Vv6_yQ
Message-ID: <CAEHHSvYtM_e+ZVsm+d0QVxS36dUVH5Nix-vrk81bPKKxZEMxmw@mail.gmail.com>
Subject: Re: [PATCH] phy: mtk-tphy: add v3 hardware support
To: David Lechner <dlechner@baylibre.com>
Cc: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1786114039; x=1786718839;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=zCkJHa1sEVzEnmqVuhFNjUudaJrqCsL1g+Z8k9MrZA0=;
 b=CviPNYtveMKYamqvKn31+iisElqOCgmd1UzsY9V+K+8nDc904X17gSV0Oc9oTPKuo9
 Dr7KPjXJJ/2aF6g1ZZiRRVtDZGZEuULDuyiK1ZFu+L8fsUecRQUplbEPJeAf3/WY6AEy
 /GaOxP7cHq8naSQm6V9DIlbhZ7znlHcBaJZrf/07LLBMTCUTVE18pHqDUV9Q1cK0hlQl
 2W28MoTUiGvJKZAsFl2AjBhuKsrwyG8RoJii7udoc+iItFv+C129a1CK00UjtA/PBamn
 7xCbtKefanXJ12uAiJbejCVNe4JrhLUepYvK8+5LJt8V4yFSST51LMtbXEfHvrow0rqZ
 z+kA==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=CviPNYtv
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Le mer. 5 ao=C3=BBt 2026 =C3=A0 21:20, David Lechner <dlechner@baylibre.com=
> a =C3=A9crit :
>
> Add devicetree compatible and match data for "mediatek,generic-tphy-v3"
> in the MediaTek TPHY driver.
>
> According to the Linux driver implementation, the only difference
> between this and v2 is that v3 doesn't need to set slew rate. There is
> one register write in the U-Boot driver that gets skipped because of
> this now.
>
> Also, according to the upstream devicetree bindings, mt8195 is also
> v3 TPHY, so it gets updated as well.
>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>  drivers/phy/phy-mtk-tphy.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/phy/phy-mtk-tphy.c b/drivers/phy/phy-mtk-tphy.c
> index 0a45dc58629..05172f220e6 100644
> --- a/drivers/phy/phy-mtk-tphy.c
> +++ b/drivers/phy/phy-mtk-tphy.c
> @@ -228,6 +228,7 @@
>  enum mtk_phy_version {
>         MTK_TPHY_V1 =3D 1,
>         MTK_TPHY_V2,
> +       MTK_TPHY_V3,
>  };
>
>  struct tphy_pdata {
> @@ -331,9 +332,10 @@ static void u2_phy_instance_init(struct mtk_tphy *tp=
hy,
>                         FIELD_PREP(PA6_RG_U2_SQTH, 2));
>
>         /* set HS slew rate */
> -       clrsetbits_le32(u2_banks->com + U3P_USBPHYACR5,
> -                       PA5_RG_U2_HSTX_SRCTRL,
> -                       FIELD_PREP(PA5_RG_U2_HSTX_SRCTRL, 4));
> +       if (tphy->pdata->version < MTK_TPHY_V3)
> +               clrsetbits_le32(u2_banks->com + U3P_USBPHYACR5,
> +                               PA5_RG_U2_HSTX_SRCTRL,
> +                               FIELD_PREP(PA5_RG_U2_HSTX_SRCTRL, 4));
>
>         u2_phy_pll_26m_set(tphy, instance);
>
> @@ -813,6 +815,7 @@ static int mtk_phy_xlate(struct phy *phy,
>                 phy_v1_banks_init(tphy, instance);
>                 break;
>         case MTK_TPHY_V2:
> +       case MTK_TPHY_V3:
>                 phy_v2_banks_init(tphy, instance);
>                 break;
>         default:
> @@ -900,8 +903,12 @@ static struct tphy_pdata tphy_v2_pdata =3D {
>         .version =3D MTK_TPHY_V2,
>  };
>
> +static struct tphy_pdata tphy_v3_pdata =3D {
> +       .version =3D MTK_TPHY_V3,
> +};
> +
>  static struct tphy_pdata mt8195_pdata =3D {
> -       .version =3D MTK_TPHY_V2,
> +       .version =3D MTK_TPHY_V3,
>         .sw_pll_48m_to_26m =3D true,
>  };
>
> @@ -914,6 +921,10 @@ static const struct udevice_id mtk_tphy_id_table[] =
=3D {
>                 .compatible =3D "mediatek,generic-tphy-v2",
>                 .data =3D (ulong)&tphy_v2_pdata,
>         },
> +       {
> +               .compatible =3D "mediatek,generic-tphy-v3",
> +               .data =3D (ulong)&tphy_v3_pdata,
> +       },
>         {
>                 .compatible =3D "mediatek,mt8195-tphy",
>                 .data =3D (ulong)&mt8195_pdata,
>
> ---
> base-commit: baa64b2f892890f00a377eac4a3e685472bb56b5
> change-id: 20260805-mtk-tphy-v3-4cba8b8965ba
>
> Best regards,
> --
> David Lechner <dlechner@baylibre.com>
>

Reviewed-by: Julien Stephan <jstephan@baylibre.com>
