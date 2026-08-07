Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5DD8C5AC7A
	for <u-boot@archiver.kernel.org>; Fri,  7 Aug 2026 11:12:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5110840A58;
	Fri,  7 Aug 2026 11:12:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Bp0LPkFOrhGs; Fri,  7 Aug 2026 11:12:56 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5383440A5A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786101176;
	bh=lZ1VBmLVUbN9gxSx3j/y+C6BiyWlPKqVKjS/T/VBqFQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hzHOEteYfZH99TU9B56BajJHWkvzjX8XgFQR4w3fe8ByifZ26SAbgDxoMt+G4AMyw
	 AjMtTxRi9WKQpd387Ewd12Mha+kXpeeNb/VL5XxLpWyqPH4GvI5pnQ2Eb8y1+ieQMS
	 KO33UdZ+pRJfl9T310FRMIV1ZrIUVF91og1bt+oOv0i7L4T8VrWVueVtFsiP8bZZNf
	 pkX0twLYUkphW6nyrhsiWxw3iM24GgjyjZkV/vsYWY5dLFD7xT6bMYbu2IcP8ocnho
	 APIxdqDRLseXFUt5LAydIxtN8VmciZ0RFuNIB4la5i1HQi0IJ1snxavIShSqmAXW4f
	 MyKgehSdD7NkQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5383440A5A;
	Fri,  7 Aug 2026 11:12:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2C47F10E
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 11:12:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 12A9560A3D
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 11:12:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4R7EmA9s51ub for <u-boot@lists.u-boot-project.org>;
 Fri,  7 Aug 2026 11:12:54 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62b; helo=mail-ej1-x62b.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org D82F060909
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D82F060909
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D82F060909
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 11:12:53 +0000 (UTC)
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-c1712a04ddaso479236466b.2
 for <u-boot@lists.u-boot-project.org>; Fri, 07 Aug 2026 04:12:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786101172; cv=none;
 d=google.com; s=arc-20260327;
 b=bFo8FRuaCg1FSzrXpA1knNbpAIew+YFeZ17zMa1HThOIpDJL8SoL9YSykCZXI7m71A
 ftmV67dQ9GaF5YJO3epNt4W2MQ5BC7KXrmBVU6oTsYBOKJKtX+UmSzj2QkVG31Ei+/Qp
 FNIrdkkVWbxYSHox2hkN0rM2E0tt8zqcNiDvdagThkodqs1jRq7JcdBcICjn68YeFzsX
 Yzw7PmpaJP4PtleSdKuAM4CzwDlJkFCjsDQmzDtJxh1WSqMDEyC/Pz2wSYH5cTYuLs0L
 enZQYI2vVJc5rPIvIXwvbJqajuk9ysl8fbZhCmU+vdiB+4uKmdvdivq4zf6R8jKqd8mr
 3B3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=lZ1VBmLVUbN9gxSx3j/y+C6BiyWlPKqVKjS/T/VBqFQ=;
 fh=mXGFv/A62Gy8HL6sBKabIdPwUwR3yPppTGkemUEsOlc=;
 b=GDpc3lzj/QD/VCiaF3Cpxj6HGBXFRDWpchniD3SdtFoac0X8SiE6HnuU80hEH3SLUM
 9LehPQuKg+5wVH8rrTklbpW3d7piARYrk2U+/j0kUFksc/h95BqpFLFHHUytDcLx8EU2
 ubPR2CXQt9jRs0pk2ygi804kTWn3PZ0osXhaPmN7sDqh3A/GpVRzfAEF/E47SrLKmq0V
 y3N90G7YwgzXXsfeER2iogB5ztqKyPkc4pFAsOxsqOU0mHhW8wK/F5hFd9GAPbPswFiY
 CsXo2XuZgwa8SGhhdYi00/1D7x39f1v/hld5gtsUN2ccSti89pu28GaWD4vd2h8bvAyo
 rcDA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786101172; x=1786705972;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lZ1VBmLVUbN9gxSx3j/y+C6BiyWlPKqVKjS/T/VBqFQ=;
 b=KD53XC9LurDE/IpWXf87oa0GU2+gI4Sod5aKTUKZ2WHMoR6bJY/ULM4MNMWqevMITR
 NMpef3JTc4+JqT9NMm09wqPNfNtJDbul+h9Arvb7f+WCIqQm+FDgGWhTE5/+ZYzqUlxK
 6zai/fvhIb69D1qiUSCGkc/r4H062Es1Gb1NpDdrCL+5v8BB21wSFqot/luPrn9ewwJx
 B0E6Zs2VbuZwSHBehsT3fH1dMsQfMnk3AGEcUKq9SUL31lWSqr2vbwYt8OEmLV3NcLXg
 pnuzglgD6mt7OfLMJXHfFnALS2tsHlxpM5dwa2Xyt8R3mFVYECP3cRFeeBDTDpE7Y6Ts
 tESg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq9GSnxhAo0/5qRp4OKNI61uD8uU5tOjrze+W1sEQzOUja106e7v1XcpmhCqUSLb0yjwcZb9w8=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YyzB+XiS0sV4Xqhbt2313zZvi5GYGDU3rQRf0IyFF2SCQ4ptCpZ
 jtNf1/82oqrrDCWwjRe+j7VqRfscR51FGDzPzG1j3sXW23ZNrrmtw9gkvAMvww5nb4kgBvRCkXE
 3pW7PfHhuzv+RGH5vqMgvETIlIVmjBSy2AlQ6lP12r/ka3WV16X2kji4MQg==
X-Gm-Gg: AR+sD10tjDJQXOBngHAFAet4QqBlGVi1E/pKP4Q/BMotVoDW3T5+vP8IXcfc+s3KlR6
 Hd5xxSxrINivY7YKc7FFAx/nBrADle8yM4XWYf46CXXNUS0VCkZAVJ1XH6Omuv+whhzVppSSgMb
 dDAhlKoZiQ5eFNljjfmnV1FwVbSR+DRW3BO+dcaHxN3FTingute8pQeJ1S5FElqWC9Cu3lX/Abg
 Oyti5CMba7yUCw7F565YAoRYFcv1rL183RUqQCD5W96QVf8a5tFjO3LPNN/bfLuoCa3NneSbuaL
 u8Xni8eNYagrdpytbKnMtLdxsaC5W60AKJ6yaRBeoMc9wUpNqwuR0c4A0bFWfUmQbqYyRMCpO1a
 Vg1SBH55IhHG4VR0WMD8z3HdSQ5olaD+pPhSZjnhCnRkXkSAVy2ftUZpXufQ6NQw=
X-Received: by 2002:a17:907:a683:b0:c20:1265:99b2 with SMTP id
 a640c23a62f3a-c2039d3cb4amr1235505966b.31.1786101171581; Fri, 07 Aug 2026
 04:12:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260731-serial-mtk-clock-fixes-v2-0-022110a9ec3e@baylibre.com>
 <20260731-serial-mtk-clock-fixes-v2-3-022110a9ec3e@baylibre.com>
In-Reply-To: <20260731-serial-mtk-clock-fixes-v2-3-022110a9ec3e@baylibre.com>
From: Julien Stephan <jstephan@baylibre.com>
Date: Fri, 7 Aug 2026 13:12:41 +0200
X-Gm-Features: AUfX_mzL2GcuF2OIvBzt6FKhR3lCYFAnZFRiw_Zo-rdUFnP5T0SNnhBlegwwilI
Message-ID: <CAEHHSvbEW2DEKgK98gBS9SNyrBT-G1tN-hRypjEtPxaxTnDY3w@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] serial: mtk: return error value from clk_get_rate()
To: David Lechner <dlechner@baylibre.com>
Cc: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Carlo Caione <ccaione@baylibre.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1786101172; x=1786705972;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=lZ1VBmLVUbN9gxSx3j/y+C6BiyWlPKqVKjS/T/VBqFQ=;
 b=Nswg6VNLdFiaFhqcbOIds5tIjWfv8PZFftT3tYsyiab24eBl4QIMNGEKsjAG+8EZc+
 FGixY7tQZaaeWtCI+P4Rt3+m03Q4IaoEGpUbarHZL84xhKN4DQ7Hh4L/pC7BpNqnd1RW
 ivz2S4ONJ5yCfe32IbvC+Kq12psMklIqn6HQ+0Vdnz6IWgngKVnvicFpTp6pqocGFRL9
 P5RUvKdys1f5IiDf+oNx3W6bg6DL4EhhQKOl+zMzQWrx1GRLzX6knp1P85P9LkMyAoaS
 xjtqGgkzVA6T7VMmLelcVpBm2bal1P0u+Y+5CYmWo26zRs9KgAP/5dQAOV0brI3qBfsj
 UpbA==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=Nswg6VNL
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

Le ven. 31 juil. 2026 =C3=A0 21:39, David Lechner <dlechner@baylibre.com> a=
 =C3=A9crit :
>
> Pass the return value from clk_get_rate() instead of changing it to
> -EINVAL. These return values are either ignored or logged, so it should
> make debugging easier in the cases where it is logged.
>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>  drivers/serial/serial_mtk.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/serial/serial_mtk.c b/drivers/serial/serial_mtk.c
> index fff2f639cf6..b20e84fe63e 100644
> --- a/drivers/serial/serial_mtk.c
> +++ b/drivers/serial/serial_mtk.c
> @@ -218,7 +218,7 @@ static int mtk_serial_setbrg(struct udevice *dev, int=
 baudrate)
>         if (priv->clk.dev) {
>                 clk_rate =3D clk_get_rate(&priv->clk);
>                 if (IS_ERR_VALUE(clk_rate) || clk_rate =3D=3D 0)
> -                       return -EINVAL;
> +                       return (int)clk_rate ?: -EINVAL;
>         } else {
>                 clk_rate =3D priv->fixed_clk_rate;
>         }
> @@ -291,7 +291,7 @@ static int mtk_serial_of_to_plat(struct udevice *dev)
>                 clk_rate =3D clk_get_rate(&priv->clk);
>                 if (IS_ERR_VALUE(clk_rate)) {
>                         dev_err(dev, "invalid baud clock\n");
> -                       return -EINVAL;
> +                       return (int)clk_rate;
>                 }
>         }
>
>
> --
> 2.43.0
>

Reviewed-by: Julien Stephan <jstephan@baylibre.com>
