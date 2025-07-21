Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28DA2C83F1A
	for <u-boot@archiver.kernel.org>; Mon, 21 Jul 2025 20:32:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3BF4D831D7;
	Mon, 21 Jul 2025 22:32:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="HcErkgXh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D45D83214; Mon, 21 Jul 2025 22:32:08 +0200 (CEST)
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com
 [IPv6:2607:f8b0:4864:20::112e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 68481830EA
 for <u-boot@lists.denx.de>; Mon, 21 Jul 2025 22:32:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=semen.protsenko@linaro.org
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-718389fb988so46278487b3.1
 for <u-boot@lists.denx.de>; Mon, 21 Jul 2025 13:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753129925; x=1753734725; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UqKK0cZVdrypYegZ7LUsbfcy8zg+dowygwHVWpGFGWM=;
 b=HcErkgXhV1/zdXi4FS+4MkNT32TCydF+od1uq/dBmL23QCYmb0/FCYkRd6NaGHLIKI
 H9OpElKcVIV0YJbEfLNW7L93RJPmGCvROGym0otxN4Jv7LtrS/pF0bu5Rf9wlbM4WDS3
 RPdpv1ao335c4nA0oKErg/yVU4t9RsNH+os2NUNeTjFFWJod+e0VpukSftfpKO1Rpug+
 Nx4OsiBdogJ1PynL1HBxm6PXdbX1YJvCJoCeOA2X5fwJJO7YmL1PnwUTi/iqXk6wyfzn
 1ShIBViytCse8zICX0duD60YkiZZu9rsc0sb7X7zq+Zo+AqtD9GCQIsyR1H8zyG06kQF
 eHgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753129925; x=1753734725;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UqKK0cZVdrypYegZ7LUsbfcy8zg+dowygwHVWpGFGWM=;
 b=gAwYNVvsIeuTVWKvjIVzyHQiXgnJnZ2j7PeSdQR8V/8OXYmu83J7/sgZr4KZhhyJRn
 ITjbLDWfCsDWnUPJT+jby/UoEdL6qUsslc0xTyyfUjxHor/XHcDoaq/9oZevxyiUMLkN
 ZJzl8G1lGzej3e3QW3I0Zjl0P1AVwF1aog/noW+YPI8ICGFwL9AxVJvPHOmDKzr5tY/a
 0D9yXpVSl+GNIoHAp56JXpYh76QMSF/IxDq5eyY7LxATR9yfDGpSuaEit8/DY9oFLWZC
 d9zpzMcK249VITtyQaDbqM+IcAKZgoUJGie9UmqbOenT1o9biJJHCtExJUg6N6aBaF+L
 MozA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVnwmxxcSac62CMo+Etv/Ebsy9YU/l3pXrFCuymeNbrtM2bZKPQ5KownCAVxiYtYpdgHrfarU=@lists.denx.de
X-Gm-Message-State: AOJu0Yyf94IgmV4LFTBRWzIejnXgBD6OaZD/WmVmye0qhbAYogUPGoik
 q4V70GLZCntQ8HbxGv2qeaxO6BQmNZJxHHfJgVsFyoRMrTzIrgewKpaiTEhOKpHwNmEkppbFQoH
 QKD7QAWjj6TS+nBEWxL1rLR2vILA2B76xi4IyKQWuUZxrTtf2ssLORso=
X-Gm-Gg: ASbGncu/J5PbkbNYZW6MUbVMo727TuDIfDL2fM/6wTsU3mTx1Ar1eLHNlmbgxpzvOB5
 PrFzRv8TpOMO/54EKcweWQJTDfQJzC5t3olZAr1bw2w9StpbfmflbdzGMmxVwJP+/rMorGXtqvz
 +4l2EtN2J7poORokAYyg4TpFG86DhKTdG38YRqRgcvbafb5LzQUK15q9gSFK59yGr+ekH6nHo9h
 ULEZ+Q=
X-Google-Smtp-Source: AGHT+IEdBRDafxBrmulSv00TCXs8b0zpabzVUu9lrZev0rkYY/wxGFiFKuQ0/5rexCTxQaZ14uq51WiC0yhrbE47dl4=
X-Received: by 2002:a05:690c:6e0b:b0:710:e4c4:a92f with SMTP id
 00721157ae682-71834f3680dmr235273917b3.5.1753129925206; Mon, 21 Jul 2025
 13:32:05 -0700 (PDT)
MIME-Version: 1.0
References: <20250720-samsung-mmc-fixes-v1-0-cb705abfa594@grimler.se>
 <20250720-samsung-mmc-fixes-v1-2-cb705abfa594@grimler.se>
In-Reply-To: <20250720-samsung-mmc-fixes-v1-2-cb705abfa594@grimler.se>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Mon, 21 Jul 2025 15:31:54 -0500
X-Gm-Features: Ac12FXyN9mCWPHw9IlaQ0z1muokEic5K3-gdYLtT-52roApnZP92dUAqkTyKMUc
Message-ID: <CAPLW+4kEPKRTHYn1q6N6_PNxJo4VR7RnLtcEt4rx67vnoQUHqw@mail.gmail.com>
Subject: Re: [PATCH 2/3] mmc: s5p_sdhci: add samsung,
 exynos4210-sdhci compatible
To: Henrik Grimler <henrik@grimler.se>
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, 
 David Virag <virag.david003@gmail.com>, Minkyu Kang <mk7.kang@samsung.com>, 
 Tom Rini <trini@konsulko.com>, ~postmarketos/upstreaming@lists.sr.ht, 
 replicant@osuosl.org, u-boot@lists.denx.de
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

On Sun, Jul 20, 2025 at 12:00=E2=80=AFPM Henrik Grimler <henrik@grimler.se>=
 wrote:
>
> the Exynos4210 devices in u-boot uses samsung,exynos4412-sdhci as
> sdhci compatible in their DTSes, while the upstream DTSes uses
> samsung,exynos4210-sdhci.
>
> Add samsung,exynos4210-sdhci compatible string for s5p_sdhci driver as
> well so that it can be used with upstream DTSes.
>
> Signed-off-by: Henrik Grimler <henrik@grimler.se>
> ---

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

>  drivers/mmc/s5p_sdhci.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/mmc/s5p_sdhci.c b/drivers/mmc/s5p_sdhci.c
> index b2faecefc00f479f53c2c6156da66a8fe46e4529..c80033d87529b192897560848=
7961b205cc3afbf 100644
> --- a/drivers/mmc/s5p_sdhci.c
> +++ b/drivers/mmc/s5p_sdhci.c
> @@ -226,6 +226,7 @@ static int s5p_sdhci_bind(struct udevice *dev)
>
>  static const struct udevice_id s5p_sdhci_ids[] =3D {
>         { .compatible =3D "samsung,exynos4412-sdhci"},
> +       { .compatible =3D "samsung,exynos4210-sdhci"},
>         { }
>  };
>
>
> --
> 2.50.1
>
