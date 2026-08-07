Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1395C5AC7A
	for <u-boot@archiver.kernel.org>; Fri,  7 Aug 2026 12:16:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 949AD812B2;
	Fri,  7 Aug 2026 12:16:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Mbtq3Uz1zeBi; Fri,  7 Aug 2026 12:16:15 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B3D76812AE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786104975;
	bh=T2uecfJ5T1Aq2d9dK68LP3Mo1Y1dp0pOgOuLV3SNnPQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ij6WqzFB2fGOqDTBNHj9WP/2uTXjXIYP7FIOGyQdCOeE5Hk2nIBIl8T3b4OGgUanD
	 +cg85WExID83cVhTYqf34tiXPNQPRnFMb4sAYPWuZ7HRtitr7MgO3Az3PuEYbAsM8c
	 Qmt0DAvgRi+ACMoQOo4Mib3szpXM6j1DCtBAZBoCMNREkgiPZO070SeyPO7Qc20TPe
	 DeWSHcxlFaTepPpRMI7RzG8M+cVF34Ab7o37xenPfht0eEoEtDSYSTL04GaO8E5/LF
	 whMU2vZpg56AlZ4iSHPLbB+a189f6he4r5NRfNG1Na6BfCScfwnZUNfM8VsOWdtrcH
	 ahr9mj4AZnD3A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B3D76812AE;
	Fri,  7 Aug 2026 12:16:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 9F1142F5
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 12:16:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9C99B40270
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 12:16:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0QIPTwx_TkSc for <u-boot@lists.u-boot-project.org>;
 Fri,  7 Aug 2026 12:16:13 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::629; helo=mail-ej1-x629.google.com;
 envelope-from=jstephan@baylibre.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 4D99740105
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4D99740105
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4D99740105
 for <u-boot@lists.u-boot-project.org>; Fri,  7 Aug 2026 12:16:11 +0000 (UTC)
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-c15d47266baso378393966b.3
 for <u-boot@lists.u-boot-project.org>; Fri, 07 Aug 2026 05:16:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786104970; cv=none;
 d=google.com; s=arc-20260327;
 b=QRX0xEDch2MFKUrJSIvHMA/g0GSkMpt1JXZx4Om0bq3YnypxwC1GufSc8FU8TGDT46
 gQR+gucoYFJErFlV02KxUxb+OE/lmkXv5ZYtikmZkcLYrEKH6/IZcoYj5ZNEyAAUh3DO
 K7ltt5fTNX2IgsD68t1WJFzeiwQSFHQbLYhcmfVLf0/EEus1avGEsx58ZCvced1Pd+ae
 8XXVLozmsyyB2Xa0SJIYVWVilIyBbFA0QCFPRdgCaZpHtzHP0t4gmYhEC5iuA2LcWua/
 Umsi3DhJqgTsqTmtXrFVDCBGUj/nqIIBQKkzT0Z/biKyYQSVF0qgbJ4Lec+OHejdYFnw
 NDUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=T2uecfJ5T1Aq2d9dK68LP3Mo1Y1dp0pOgOuLV3SNnPQ=;
 fh=/9tElpopuVjt97ekct089vlr37t5VEgde3LxHlsA6SY=;
 b=MG3w6jDOYz/FLR0EPMbmDA202dP3NG/ZPeYxx9Y4oQXcwQxCZOZlbCrWYsS5b5tynl
 55ZUTiXMX7clCz5S2GZWOBSfQwCrjv7Zw/qUxyqOnnmHdyHLF3ky4qy5Ffd1RgTdFqCM
 xjkIOaAVKv5eejUD1vbyj5E++HGUsGD2xODLaA54ojc6rhkBEv3YIS8AAr4mG+G0QFZI
 08TrgpkdVwgMEL5aY7LxY9NRAnxXemN8aXeodNkWhfPo7FKUBzM1luC3rIm6Qi2vGyOa
 sF+x1GB0/7dFTth83wgN8Pn33b83Eh8/1VB/NM9lOjUpa8B4BaSVXWig3hKTcLxRSX0v
 7BrQ==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786104970; x=1786709770;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=T2uecfJ5T1Aq2d9dK68LP3Mo1Y1dp0pOgOuLV3SNnPQ=;
 b=emE2bU9K11942lrDadgMjsBhOyVFf66xbMRm64ONOPS098PCAX2wGPaAT4SxWJ6Mr1
 HGPKdfXlWofoY6ByZvu/iXVdn+9jKM74ztC71mwyokrRH+GzBqC05p4kSFkQEBcD7cIS
 /GZwWh+KBBsuZx+/3i9BTvwpDY5VqAkeH0w9GTtd6j/8rW02RYB+7rYCMEk6aMzFKST5
 Dk0+InhWfrMTuEzSX0IXvPs7FxEkui9Q0I01aBR8DxfIIP+aqijP1Vra1935m1mkrzNp
 nDhdlsMt4wFZe9wqtWVx+FbCnct8DuNqjQph/b3pFknWLPD9Kt99Zlv3KP1JlGSazj2m
 zrkA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rris35w9ILQ+ouh+Uqgpi6paRd3hOpWxSuRbBGu35lnisqikrR8JhaSSMJzWK0MZ9MW3tzYoLI=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YzZJPskbDC6tpRWBX9JNQpvu+zs8S7Ffa1Qbg8pZ5sQTQIae9KW
 iC/hD+6jN1iOFL8ojO1MLJEFUyaLz7r3a6BCvK12uCDoGcIrVWOzAnBwLRUpB/VmdLv3RWXaB48
 qi70rqDMPLPps1yBWVfVUCMrPPZbT0hCWtXTSxFoing==
X-Gm-Gg: AR+sD129iOUFo55uW1mnjRqX1TlSZGZxyE9JdDnxOB7j+HZZDt9lIenbxhFVg3NLdOj
 tjyDINiT/RWSvCZkludVJcD4K/XdSqHyo3hks3QeCePtcnDTRR8M33ltayVZDbSLa76uNeayiIx
 W9n8Khn9XTdDHEbqHDfaH7qIIlRjjT0q1HZ0m1YOApVhm62UcobXQiz3Wn+7+JKivfaky564pUh
 0/31I2rda7COprtCCC4rJpcBK7Ot3APlnahkVsePnGIUWEmTnN7mrt1fxIAqQXSLDpb73z4MRMl
 KCXroPdKESSZrJXbeezukc8zP9b43FhIYxBFDAQqr5OOqw1+NBJunpRIoWeRV2R+l6AMuvpWN7e
 /USxrxv8lAm8k4tYpV7x84a7PQ4XXOTB6wPoQNXzoWoxPsiD7v7XlpwUHRXYklaQ=
X-Received: by 2002:a17:906:ef01:b0:c20:2b23:71cc with SMTP id
 a640c23a62f3a-c20731e1113mr378925666b.10.1786104969705; Fri, 07 Aug 2026
 05:16:09 -0700 (PDT)
MIME-Version: 1.0
References: <20260803-mtk-pinctrl-kconfig-cleanup-v1-0-fef1ff69d1cc@baylibre.com>
 <20260803-mtk-pinctrl-kconfig-cleanup-v1-1-fef1ff69d1cc@baylibre.com>
In-Reply-To: <20260803-mtk-pinctrl-kconfig-cleanup-v1-1-fef1ff69d1cc@baylibre.com>
From: Julien Stephan <jstephan@baylibre.com>
Date: Fri, 7 Aug 2026 14:15:59 +0200
X-Gm-Features: AUfX_mxmehoNbedaiMPqd_Cx6_gyh9YnZqzYmd0FVwOhBiB3st3giShG7oc1JZ0
Message-ID: <CAEHHSvaNS0P1E=URTzVMSC2YgX7W_xOv_0_hovT9tdu_mpLWpQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] pinctrl: mediatek: select PINCONF
To: David Lechner <dlechner@baylibre.com>
Cc: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Tom Rini <trini@konsulko.com>, 
 Sam Shih <sam.shih@mediatek.com>, David Woodhouse <dwmw2@infradead.org>,
 Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Macpaul Lin <Macpaul.Lin@mediatek.com>,
 Julien Masson <jmasson@baylibre.com>, Mingming lee <mingming.lee@mediatek.com>,
 Fabien Parent <fparent@baylibre.com>, u-boot@lists.u-boot-project.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1786104970; x=1786709770;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=T2uecfJ5T1Aq2d9dK68LP3Mo1Y1dp0pOgOuLV3SNnPQ=;
 b=X0WR3HJQTjSKIzLbQOx4M482K3SDqMv+snoIi338vZ2eDjIwo7K1r+c4WjeAv4A3Y0
 CtrIaqsj320ob8P9nn+nME1ozGwUutezuXxK2lj/Goz+cetaNKLRq2Y8AmKx7K7bYkG4
 w/qeLeSNftC6fPHaPMCrdY4VInq+XseWJOt+Ej2HDjHzdcjxk7pGP7qa5MCgZ9SjMAJd
 jEPzDMOzUF12zhiUlFmBPBkJoVjtLYSme9TBefmfvW5NbKvlmU8Ft9Hku/b8IDDZOBTe
 ubLB3JqlDU1NOrY/wHqRRwZhyLU8Gce5pKitsZ+UN2BPFmvVhSAz6oDQIn+eA6crJ8Zn
 JiCg==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none)
 header.from=baylibre.com
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=X0WR3HJQ
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

Le lun. 3 ao=C3=BBt 2026 =C3=A0 22:57, David Lechner <dlechner@baylibre.com=
> a =C3=A9crit :
>
> All MediaTek targets include pinconf registers so we should just always
> select PINCONF instead of requiring each config to explicitly enable it.
>

This is not true for MT8518 (see diff on patch 4 that removes only
CONFIG_PINCTRL_MT8518).
So after this series, MT8518 will enable PINCONF by default. Is it
intentional? Did you test it?
Maybe  select PINCONF if !TARGET_MT8518  ?

> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>  drivers/pinctrl/mediatek/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/pinctrl/mediatek/Kconfig b/drivers/pinctrl/mediatek/=
Kconfig
> index 5a90d74a9e1..42c7c8b8c80 100644
> --- a/drivers/pinctrl/mediatek/Kconfig
> +++ b/drivers/pinctrl/mediatek/Kconfig
> @@ -2,6 +2,7 @@ if ARCH_MEDIATEK
>
>  config PINCTRL_MTK
>         depends on PINCTRL_GENERIC
> +       select PINCONF
>         select REGMAP
>         select SYSCON
>         bool
>
> --
> 2.43.0
>
