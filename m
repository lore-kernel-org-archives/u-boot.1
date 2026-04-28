Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FA8EFF8868
	for <u-boot@archiver.kernel.org>; Tue, 28 Apr 2026 14:40:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B6B5684119;
	Tue, 28 Apr 2026 16:40:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="mJl/hBZ2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CDC1484255; Tue, 28 Apr 2026 16:39:58 +0200 (CEST)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 139F7803C6
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 16:39:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-ba699316b42so1452790466b.3
 for <u-boot@lists.denx.de>; Tue, 28 Apr 2026 07:39:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777387194; cv=none;
 d=google.com; s=arc-20240605;
 b=Nbn9hl3Buc8nZryQBgTdgCD1wJhS3pQVmLQ/1tdO/uO6bgUM+M66F04zH/vWKwceTZ
 i1LXtVfePhZXuA6iNXO1TzPHUJi5CfEsVqE9M6dQ5t/SarHXtFZRLmRGRiNd3YR83h5o
 MBchhUcxV5bxnKosYeezwi0a2AS+fyUMScTpq1lP4bOBf/Fb6Od4OB5p4S5QZ8SMLFA6
 qnG300nD9MBtGVwStLhYs+vC1lPd8KWy4B3JwqFesrHMR5Jjo7YPF3s0qhSmp6jOo99E
 JzYMolcqZJRpgNvx+QDPOpOblAgniczq0mFtxOyBpe+FaeUgGY1DBoBeRyZEAJL2xNxl
 k79Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=WFHEjcSYE+tdaREwgkCwnw65nrw115qtqmaTUD42D7g=;
 fh=BH0lx9EgW3uAyUEN+eAHgw48qgbH3bt7qNYj70hwWE4=;
 b=iyCEH9DDRfax+gFSfCEww8a23T7355u85HMeVCsUyS36DfHjI+TnD8B+q8aPxhSkRt
 C0hYs5k/OI21wm837E/wWRnWavYGhTrc2OFB07mRcHQq6w6zlRBZrBKD40chb7Iub+v5
 M1cF0zSHWyTQl/sl9q2Q4eCFFdPQ7IJNQ17B9dlWm8m7MlkIQ86fyUol4fKFomwyO8Or
 fB/vCp6cIS7/Hm5emXfQeimi7Zu3ZBNecFP46aWpmbmSrS5LQIrRSvCfca0tcYNbxpfh
 5yJI8Hv3s1EN5AS8XaufmldiLSsF28qZxxMYsX8CQctEFE2An2ttU+B3G+4d0/oxhraB
 eRBQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1777387194; x=1777991994;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WFHEjcSYE+tdaREwgkCwnw65nrw115qtqmaTUD42D7g=;
 b=mJl/hBZ2VhQC2nJeiI1EroRnB/VFjvEb8nmtGfvr6R6FuOSat5G0qWKBUQDQ4Uq2H+
 hDlmmRDGD5A6zT8R4MhZNlxSVThJa/V60eccaW5FAUxu1Xobbpvgj3JOlsVR/5IDdE/L
 n8d8FYhRigFxmvnt3HtsbXcnXkJdfAxnbYHJE8VhUB3o76igxdILrdVhNnZQguHr5G0I
 sFt54A5bglnq5Yzgva5F5aU7e5HzksZKoA7oIAaqm3F04lJJDUZEpXXcLoZm9FLAvR9x
 nwD1Tc5FvqGDFLXrBQcs6Wdi5Mti0rMVCUELDNVMqnmbUSmMF8RoOwndC0Rr1cGcmUPX
 JwZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777387194; x=1777991994;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WFHEjcSYE+tdaREwgkCwnw65nrw115qtqmaTUD42D7g=;
 b=L86uMf+XRFqeHApqhxiCF1nL3+LXgk/cnAQI+jH6hFD9YBeQigWwsDMLP7w4tQhgWU
 Cjy05fCriATITcnGkxaZGB0IOMvkxOgToJTdzEBYOmlNOgpvhWDUXKRaInnFHniCZ1G6
 3wqiRydg7ocJP+RQ0dPvtq1J0hC+Pm7fwfRvCapnP3yCytRoIshDvBSKPjMMo0Sdw1Lg
 L1p6XxPChkmx8kRNge2PJ3aHkrwUAmEW1lYRjuuHLvCvSGIUyy6GdTjv2ofHgMS9zndA
 F2n63ZaFUATRboKTIPqy5QcQiJwxHcqhuaZM0Qao9PTV+k685+zCvn8iL2egfvznE6/S
 J6Uw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8GUCdOt7dyaoX1jNzVjx3/QwPo/tXJBfuI1oVWjRB1sHp10My3ajVdH01X1D6vhzS0QKDX7sY=@lists.denx.de
X-Gm-Message-State: AOJu0Yx0GFzVxfMkbLmQt5sDdCD+TeOidhyOTArpE4xcMPO06xLP9Ik3
 NC1HZL2DxrFZqSjtBotHLLPEY4cE5efKMcMEE4zYcmuaTfxvX/SYIMyrAFZpqSJeb3xFntmp9H8
 FJNIORRr2V9Vn+doTWGdo55oUzornWyeTOROZuefzyQ==
X-Gm-Gg: AeBDievQYL4pc3eteYfa2cQ5o1UFzsLiKLU3XJs9KPteyxI6EGfdM4TRsLbMt54GWwM
 lYPVNOqSX4P1mzb0C/jsAJq9vvFR6L4/ntOU4PSIH5Oz6S80y2QdodWAEoWyh0YA6tuRdsnf1rp
 bnMGBfPvk9s3EzaGa3o07Frb1/XClvmrsrcSWThKWSR6JooGWBpZo1Yn2H7Nqv74cEUqvbrKPDq
 gEe7/wBZNEnwIhxp1Q1i9aOvWlY1vSRx/+XazMLkWWcRhhGZPcwouew7JBT+oCqnk9oXKmSNGtG
 Rgnc4JOwKziLqyrkmETXIIJ8+ewZlq/gX/savA5mIlVi9LT1Bnj0zJlzWHNj5hrNwoXudvnkd0x
 lfLxzueRKgs8kIySZNrS8pvLrqQz+57EgULTxHqciwMaI1Ws=
X-Received: by 2002:a17:907:84e:b0:b98:411a:116f with SMTP id
 a640c23a62f3a-bb8014e779fmr192918466b.2.1777387194381; Tue, 28 Apr 2026
 07:39:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260421-mmc-mtk-sd-fixes-v1-0-5b840c546af2@baylibre.com>
In-Reply-To: <20260421-mmc-mtk-sd-fixes-v1-0-5b840c546af2@baylibre.com>
From: Julien Stephan <jstephan@baylibre.com>
Date: Tue, 28 Apr 2026 16:39:39 +0200
X-Gm-Features: AVHnY4JcoWrXy_61AsVVzp_CuKIOiEUfEji0p-f-6ZiWRwEyd5YD20AZz-I78x4
Message-ID: <CAEHHSvad3ogQTzcMzg9Bv6Nme-5fEo=cqYPV3RWVK3XM5TvUeA@mail.gmail.com>
Subject: Re: [PATCH 0/3] mmc: mtk-sd: fix HS200 mode writes on mt8189
To: David Lechner <dlechner@baylibre.com>
Cc: "ht.lin" <ht.lin@mediatek.com>, Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Tom Rini <trini@konsulko.com>, 
 Simon Glass <sjg@chromium.org>,
 =?UTF-8?B?TWFjcGF1bCBMaW4gKOael+aZuuaWjCk=?= <Macpaul.Lin@mediatek.com>, 
 u-boot@lists.denx.de
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

Le mar. 21 avr. 2026 =C3=A0 16:24, David Lechner <dlechner@baylibre.com> a =
=C3=A9crit :
>
> This series contains a few fixes to fix HS200 mode writes failing on
> Genio 720 EVK, which uses the mediatek,mt8189-mmc compatible controller.
>
> For example, trying to save the environment to MMC would fail like this:
>
>     =3D> saveenv
>     Saving Environment to MMC... Writing to MMC(0)... MSDC: start data fa=
ilure with -5, INT(0xa000), rawcmd=3D0x2003099, arg=3D0x0
>     mmc write failed
>     failed
>     Failed (1)
>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> David Lechner (2):
>       mmc: mtk-sd: enable DMA on mediatek,mt8189-mmc
>       mmc: mtk-sd: enable async_fifo_crcsts on mt8189
>
> ht.lin (1):
>       mmc: mtk-sd: fix msdc cmd ready check
>
>  drivers/mmc/mtk-sd.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> ---
> base-commit: 71176c454f59b3f9ad166ee3b807bbef712e8d37
> change-id: 20260417-mmc-mtk-sd-fixes-e31112f733e0
>
> Best regards,
> --
> David Lechner <dlechner@baylibre.com>
>

Tested on genio-520

Reviewed-by: Julien Stephan <jstephan@baylibre.com>
Tested-by: Julien Stephan <jstephan@baylibre.com>
