Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4421CC83F2C
	for <u-boot@archiver.kernel.org>; Tue,  5 Sep 2023 05:58:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B1A7A86611;
	Tue,  5 Sep 2023 07:58:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6AC2886824; Tue,  5 Sep 2023 07:58:53 +0200 (CEST)
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com
 [209.85.219.44])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AFC40863C3
 for <u-boot@lists.denx.de>; Tue,  5 Sep 2023 07:58:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=fedoraproject.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dennis@gilmore.net.au
Received: by mail-qv1-f44.google.com with SMTP id
 6a1803df08f44-649921ec030so12375046d6.1
 for <u-boot@lists.denx.de>; Mon, 04 Sep 2023 22:58:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693893529; x=1694498329;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QeUYUVKXsReQYLGWUNK9Hu5Jy+dwvqvXDt6aP0RPnzI=;
 b=EAMbxSI2oZwGpBdNmO8cAd+rogf2bZt8zaqUN/pPQNbApmxNbMbnjxCe9HvEFj1gue
 JuxEMLojXBvtvjutQ0nKjaPvzru/eo1HuIDN4gy5BU7Ec28tBctlsemLgvCS9unVYh9M
 TGmhrIK/e/Bz1UPmO8u7kEwisG/JLnoPxVoFM3Kn9i3TzOJg2iC/42hD3YMsjeRNk1lV
 wO8uEpEVUOMyo1Sy9r5kMut5Rbu01MP9lwFLiwexEL70hNKq2g2A706E+I04FyhedMpT
 kpDsv9kO+ClYg4Gvplju54mlO69DT543L9j53DvzuRllDaQ7rMrh/eT9F9rW5pO+t3du
 n74Q==
X-Gm-Message-State: AOJu0YyRMvMlUv7fnSopYXHdNiXaWBoIKB5mKi5liD12K1sk3m99p8CC
 JgTGGpO56mHBDxJgxH1RgxtAIlwYOLd+LxERI5ZRnX9eNlA=
X-Google-Smtp-Source: AGHT+IGoSdvmrwzYhGs0HKWZntrQwIPzAXJdD1toKDhI3pHVCyoaLWqvGs6pO+JOhpwj7khkRdWtXw==
X-Received: by 2002:a05:6214:4507:b0:64b:e16:a3c3 with SMTP id
 oo7-20020a056214450700b0064b0e16a3c3mr10403648qvb.24.1693893529400; 
 Mon, 04 Sep 2023 22:58:49 -0700 (PDT)
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com.
 [209.85.160.173]) by smtp.gmail.com with ESMTPSA id
 w6-20020a0cc246000000b00653589babfcsm3253555qvh.132.2023.09.04.22.58.49
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Sep 2023 22:58:49 -0700 (PDT)
Received: by mail-qt1-f173.google.com with SMTP id
 d75a77b69052e-4107e6fb0e8so14297881cf.3
 for <u-boot@lists.denx.de>; Mon, 04 Sep 2023 22:58:49 -0700 (PDT)
X-Received: by 2002:ac8:58c9:0:b0:412:1aa7:784 with SMTP id
 u9-20020ac858c9000000b004121aa70784mr17744728qta.1.1693893528861; Mon, 04 Sep
 2023 22:58:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230822143357.2818-1-wiagn233@outlook.com>
 <TY3P286MB26115DF6D963C38835BCBE30981FA@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
In-Reply-To: <TY3P286MB26115DF6D963C38835BCBE30981FA@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
From: Dennis Gilmore <dgilmore@fedoraproject.org>
Date: Tue, 5 Sep 2023 00:58:38 -0500
X-Gmail-Original-Message-ID: <CAABkxwsSTm0WMWwWMkgcX9ynGXMH0m0-_D85=nFNOrgZ1M4xDA@mail.gmail.com>
Message-ID: <CAABkxwsSTm0WMWwWMkgcX9ynGXMH0m0-_D85=nFNOrgZ1M4xDA@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] doc: board: starfive: Add more info about
 supported driver
To: Shengyu Qu <wiagn233@outlook.com>
Cc: xypron.glpk@gmx.de, chanho61.park@samsung.com, ycliang@andestech.com, 
 yanhong.wang@starfivetech.com, u-boot@lists.denx.de, mps@arvanta.net
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

On Tue, Aug 22, 2023 at 9:34=E2=80=AFAM Shengyu Qu <wiagn233@outlook.com> w=
rote:

> Since PLDA PCIE driver is added and VL805 support is enabled in
> defconfig for Starfive Visionfive 2, modify the document to keep
> consistent.
>
> Signed-off-by: Shengyu Qu <wiagn233@outlook.com>
>
Tested-by: Dennis Gilmore <dennis@ausil.us>

> ---
>  doc/board/starfive/visionfive2.rst | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/doc/board/starfive/visionfive2.rst
> b/doc/board/starfive/visionfive2.rst
> index 941899a0a4..460f23aec3 100644
> --- a/doc/board/starfive/visionfive2.rst
> +++ b/doc/board/starfive/visionfive2.rst
> @@ -20,6 +20,8 @@ The support for following drivers are already enabled:
>  3. StarFive JH7110 reset Driver.
>  4. Cadence QSPI controller Driver.
>  5. MMC SPI Driver for MMC/SD support.
> +6. PLDA PCIE controller driver.
> +7. On-board VL805 PCIE-USB controller driver.
>
>  Booting from MMC using U-Boot SPL
>  ---------------------------------
> --
> 2.42.0
>
>
