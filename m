Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A59C105F7A6
	for <u-boot@archiver.kernel.org>; Fri, 13 Mar 2026 15:20:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B4A3384370;
	Fri, 13 Mar 2026 16:20:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="CpzEcyK0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4DED84382; Fri, 13 Mar 2026 16:20:13 +0100 (CET)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 436DA8436C
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 16:20:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-b93698bb57aso446362566b.0
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 08:20:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773415211; cv=none;
 d=google.com; s=arc-20240605;
 b=jFabHbi13PdTFu1knkjyTdg8imyWoRX5QZGL8C+MAq09lbvX1QjNMXXEF8Nz3r27wt
 wo9a3bME10rDFzUoxC55QleO/QXTXbc3GhGlS/f51t+fRnTdWJgi+PxUOZXJL0Y7zyww
 qDK7xl+Zk49yZQa/XXSL4bbxMu4+uiawABBCUgjT0N1Js1eQoc5SESMGxQuQ3yEiWe59
 0SCv1gcHUmRWN2E4LrO6GioU9Y2ykq1abjlxUWJraZaNwSKj4b9pRalAxmLY3D72FYE5
 HIECgd1yqbSn3SXB/gl8fOWSVVJGph/kjPWHNDIuOQnDOwUJrFvDFUOUPcF7wtbATm7T
 n2oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=b8YZZwDBtorbdHFz23v5j6vEb7bTSU5NzNZKcaW51Ng=;
 fh=BkTneNBeMZ7ye7nZi3/XkuNqlEKKfJpSV3Uk6ZbGqLo=;
 b=UEmBoGxSUdXTWm78vwHju54S3gHF7iw1nMAABx9pxc/NbJxjYBixXkreNLChR2vA9J
 5AhnW9seltQcIRybO6/Z1wo/AxNeKV1+H2FgywUW2RFB6tjzsgnzLFAntBJfTJXbJiET
 pFMh/7hfWW+4bThDI0Z1HjW1VE9rf/2WAv9M0J/wXnirBaq+KarWGedeKbKoIkGQ5wMQ
 /ukUq6+cHzPA+UdCp3EmQ+/v/1KBVAO+d17h5kOWoMhPjEIpfxWxJRHi5YCNjQX+8FLA
 ocdWZTycIAUUZjkS8I6NX0Usld+3YaWU8fuPpZolVOnhEAHVVLW3DHdX7tyr/OoMzFVb
 /Dig==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773415211; x=1774020011;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b8YZZwDBtorbdHFz23v5j6vEb7bTSU5NzNZKcaW51Ng=;
 b=CpzEcyK09JRScpWeI+ZKS8O9pkjozWXtuNqiwhBl8S9YabW7s6iREJ5pKs+JtIZNaL
 5lO81YXqb9ImHw2Q95V+QvzsdPCJWb5P6RlV9539bAVCr+wkinR8OGo+o2mviOh67U8d
 ScgO1PjgRrZwl4jd5jvImnSau76d4IKhyWyiIG0Cf6jF8dZAYWldTbOoMHSoDowCwdsK
 hWSHL05aRFrexKbWwwUjYXlCKv9qawS3yS6Yu0q0QHA9ebKQi0mK4bYvvEPp+xa/PmKC
 IEkA067UAXKsbe87GiFR1QMX4Xp97V3nlRIwJJTVecMokx0OfSbZekWAfyxz2QkXmrRV
 WHvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773415211; x=1774020011;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=b8YZZwDBtorbdHFz23v5j6vEb7bTSU5NzNZKcaW51Ng=;
 b=m//UngBDjV/QdLSKjBv5WVAlbtSup56GlNjsw8TZx712pJUziV4O0jDtYNb1OB68F/
 7KxDvPiHMwW4Io3pkkkUdw8SnCbUjzNLOdvmi9i3p5VjuwdY9wfvhH6XdDD24hpklnEl
 AbjO6OQA9YmK/VktdDCxDymwMmMMQrqo8xoKfdckL4EizzsIysW7OcsuOAyZsoFar3UT
 8ALJM01zVvGaTBkKVvu39w1CWj4bFvhaEXXdmC7eHM1beoc60YcOqcqLJCgdIT6zXiAy
 1vnXS0c1xg4DbsdBUZFGIcIMi1mxAUEeZBTfZDFe/ky4YCpoAsn+OzS749HLS+vpKdML
 exQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZXYbEXR145gfbLBwGyIJ0bkKpRg04NGFdDDT+Y94O6NMaWYZRdhJ2x5ymOvLZmrz9MAutc04=@lists.denx.de
X-Gm-Message-State: AOJu0YzuYvf28Ab3v0RPQhatABwCT/5Ok4XPMITZ7PxqUV/5b6qaLjT/
 p21gb6O6YBPTLNPcVHiD9tqytl6KYx7R6hxt/rPuTE0iOxrqCMF/ngIdBGZG2My8qimPz7ZqFJK
 30BgjEKs3znxWKYxzXpGyMsE1zzKgBei+n8Mu048ohQ==
X-Gm-Gg: ATEYQzwlaQ28lTXdvcxC18FeNsOCz31zrEcWgmc29iBVwE1e/cxHnfZBiiclP2Pcetv
 NM5WXIJyxUrDRpyXstl7WGtlp6LAd4M7x6ak6+nuEeOvLNqoHN0YehQMoBjS9S3G+AE/loK81z5
 gtoPKBZVlFKEtxnrpfYEnAf/Q3a6/eUoLp2tNOrBcONK9+59pWrwK78JTp3G8ATY+WKzocoE0od
 /+2nORQrQWpNaqcgs+qwNaAFnTh4E74fUDYbiJOtUl23K/EXNLmz2pnmAyvi4TC6idc8aXDTaqV
 wgHq9dtZ+I77Xac9q1v5PDdl/GlVt7pPddrVA3CN6j7vgm6g8+QRcRL5Fj4szP5Ixz89vO2JVP3
 T5uWIuk25ktbP7I92SJ43e74xdQ==
X-Received: by 2002:a17:907:1c9a:b0:b8f:c684:db37 with SMTP id
 a640c23a62f3a-b97636960famr224699266b.9.1773415210654; Fri, 13 Mar 2026
 08:20:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260313-clk-mtk-fix-priv-auto-size-v1-1-bc649e1b301a@baylibre.com>
In-Reply-To: <20260313-clk-mtk-fix-priv-auto-size-v1-1-bc649e1b301a@baylibre.com>
From: Julien Stephan <jstephan@baylibre.com>
Date: Fri, 13 Mar 2026 16:20:02 +0100
X-Gm-Features: AaiRm529hCl6Mlno9EbYchRKIZF5d4IIhblx3NzhJM8HNNahxycrdeoBaJWmOmE
Message-ID: <CAEHHSvaZgokusQ5bs1AYa0nwFQUyCj95Bk3LJBv_Xeynany6Bg@mail.gmail.com>
Subject: Re: [PATCH] clk: mediatek: mt7623: fix pericfg priv_auto size
To: David Lechner <dlechner@baylibre.com>
Cc: Lukasz Majewski <lukma@denx.de>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
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

Le ven. 13 mars 2026 =C3=A0 15:46, David Lechner <dlechner@baylibre.com> a =
=C3=A9crit :
>
> Change the pericfg priv_auto size to mtk_clk_priv. The driver is
> registered using mtk_common_clk_infrasys_init() which expect that
> struct.
>
> The old value of struct mtk_cg_priv was larger, so there was no issue
> out of bounds access.
>
> Also replace tab with space to be consistent with the surrounding code.
>
> Reported-by: Julien Stephan <jstephan@baylibre.com>
> Closes: https://lore.kernel.org/u-boot/CAEHHSvYMiCZ4jAXp6jEhg6AhZ5Dv3_Ak-=
8H1mT7S2FPD3_X7dw@mail.gmail.com/
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>  drivers/clk/mediatek/clk-mt7623.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/clk/mediatek/clk-mt7623.c b/drivers/clk/mediatek/clk=
-mt7623.c
> index 071c4cf8a84..87720a93eff 100644
> --- a/drivers/clk/mediatek/clk-mt7623.c
> +++ b/drivers/clk/mediatek/clk-mt7623.c
> @@ -1187,7 +1187,7 @@ U_BOOT_DRIVER(mtk_clk_pericfg) =3D {
>         .id =3D UCLASS_CLK,
>         .of_match =3D mt7623_pericfg_compat,
>         .probe =3D mt7623_pericfg_probe,
> -       .priv_auto      =3D sizeof(struct mtk_cg_priv),
> +       .priv_auto =3D sizeof(struct mtk_clk_priv),
>         .ops =3D &mtk_clk_infrasys_ops,
>         .flags =3D DM_FLAG_PRE_RELOC,
>  };
>
> ---
> base-commit: 9f1059bc735ec2a8d78c1f3e4fcab1fa3f428317
> change-id: 20260313-clk-mtk-fix-priv-auto-size-a2bddd467f41
>
> Best regards,
> --
> David Lechner <dlechner@baylibre.com>
>

Thank you for the quick fix!

Reviewed-by: Julien Stephan <jstephan@baylibre.com>
