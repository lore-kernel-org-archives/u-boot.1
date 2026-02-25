Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B069F55439
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 02:11:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF77983D8A;
	Wed, 25 Feb 2026 03:11:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XWd3z9me";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 94D4583DCB; Wed, 25 Feb 2026 03:11:10 +0100 (CET)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5003383C39
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 03:11:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=promsoft@gmail.com
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-59e65b8e268so6363447e87.2
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 18:11:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771985467; cv=none;
 d=google.com; s=arc-20240605;
 b=kFquSs4SymGPN5hrvS0Zwj1sqcklvrcB31unfuRCxJty/LEutilYe+c7LpOgPaoHDM
 cYt9SIU+ZbnrSVbFOssOtcuN/k9yAdYDTpbHe66unNOdrjwduSvuRayWQSTkjg9DZTjx
 BnIrC+ifAvHCRSzNrQ4Cq/cmEqVCws7ztkO7u5CzXoOXWjodAp6PJIyJSidBqz7uulzj
 MpGGMbn+e5uXn7/o0X4GiSnAfsKICmgXIAVByzY1Rx4DWIqKkz2sxs4QxIOuE3wMDaui
 KuUdQVV6dFiz8TIbMc5bqDnr+vMR17UNbTYUj57TAkblOPaNk/UiOGol7CkCX8vpu/Zy
 m1IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=T9DgXH0tIKGwGlWyV4CXioovLCTk31acg66El+Pdssw=;
 fh=aavfnXacPzGMlWFMAegE47Ir0j69hy01IrlJMb2/G9g=;
 b=aYOshcm8x1jeMspafcUbz/p0LUp0Nf/MbDtXnKNDHyu5XlAiIYYfhwVNUhcabW84WY
 XIJi5KoFbzRq3T4M7cbND9GtaBIrHOSRxia05vi8EC3qRmmeVzzO9yh6cSYmMKfRa8Co
 eFCauo3so0Sv61neriDI7RCV3zM4GmOYkb8SwQXLWzR536bQY5pZ9NBYkWFLOxgKyvpM
 7+J8Yil3rFMlP/ylsesVjwcaH9hHZLvgbw3Rl6AgV+0POvm4fdL83LZTM5oGMe2yK9PY
 yRsDop5se6Qh2nFwMsTa0bcOCsuX9cdD3L5NXF2a+fY1g4+HtpVmtpZ9jMdlm1kgCl/L
 oAIA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771985467; x=1772590267; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=T9DgXH0tIKGwGlWyV4CXioovLCTk31acg66El+Pdssw=;
 b=XWd3z9meE5o8l7zooCZv/chOs2snqOPR8QA2gT1kiSPVHxdZ5ttyEN/3/2t1ajkj2Q
 ZbqslQEQ/roNundYn64eYwT6wORF7uO2xBvQL/uiokvPbb0i4E31pBUcuH1YDdsvIyyc
 Gjmis+pX+lYpGJ16k7ulEOJxNkh52/XGMpLE1dq14XdA5vFTIHju/haSI8kHFl55HjDs
 uEddkjIYGy0EWFo4qOA7Vnyd37sYX4gra7JE/Emb9jAiecjYdKS6Vb+YA8vsfUF/w2XC
 gFX+jv7EzDzd4kYodWV4TKpHNtfCzUoUOQsXzvY2XQyAEv9H6p+MMk2+MI7HhCzVMfvy
 aKIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771985467; x=1772590267;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T9DgXH0tIKGwGlWyV4CXioovLCTk31acg66El+Pdssw=;
 b=vTews1/CCGfEX2M2VYaPE8y3rmquZ8ZR06RcKcfvxYzZQReoLvQ8dGs2XhI1nJ7x1t
 SG4kKwxsjDy1wkwtDq6jCEW9NTGMP+ZkCWo1NIC+wQtNU2oJprbYqSTvbXbsZjgNRNK2
 AAr4FrvkziGWaQ5HpiU/yImfAI7e8JQLDsux8zuAgOA17f0JwaJgeg0JpBEWDi23Yecu
 ir03n9/G8XzI07OzPNAg4wIZS2GdNhkqis6WptG7D6zFiXNT8wromsH9Z1gAanaf0ZSr
 5MB3hnH+JdP/ry8ioMFo7KK85AJlwyct6aBmAfjM1mgA2Ju6+aX6ddNdljW8DLFPKFkJ
 uDKQ==
X-Gm-Message-State: AOJu0YxYEZadQFA3vVypEOx3VmozE1IciSyaiQJmaxsoeLE+WrSbBJnu
 xC2MAy5tPQ+oxhTyW8VgBwXRjUSDhTJlXLkk89bJhmMeGfSFvntakLUsxahV5xCWA4vdBaWG4Q8
 jFmoP/yBf306Ej2T2g1xCMWdLo0MAhm8=
X-Gm-Gg: ATEYQzw/6cSXNGPeTX4HYvoQcxo/F68flHddDLUrvu+8GArkUGNlm9eSuc7H9IAr+L5
 zweyVBBg/j/MkWLbCQiqNH1CaxlM72f90D4ebF0toO1MMJLG3XV5uc006AS/rDwIdbdZIsdEz4s
 TaxSfr/fXzWY+DLTlOyP9vpLjHfOIv5CIgIZzsLBuuJnXI4kZhB6KLuO/XbDC0NCFvbpptyTi0B
 XeejzE4kDkb6YcMXGOACXmSSHA3X7g4Ug+GW2SR0WxoXpNIk880RCf/NAl97lWoW1bTI5liRZnm
 MJzD+bXAC8on0KcqSA+zBXstQM0=
X-Received: by 2002:a05:6512:31d6:b0:59e:4785:c43e with SMTP id
 2adb3069b0e04-5a0ed87fab5mr4800445e87.10.1771985467245; Tue, 24 Feb 2026
 18:11:07 -0800 (PST)
MIME-Version: 1.0
References: <20260224-exynos-blkmap-dfu-v2-0-742cb9f27842@disroot.org>
In-Reply-To: <20260224-exynos-blkmap-dfu-v2-0-742cb9f27842@disroot.org>
From: Minkyu Kang <promsoft@gmail.com>
Date: Wed, 25 Feb 2026 11:10:53 +0900
X-Gm-Features: AaiRm52YoQs7ZbKxHRZrHaivGDXhnnG7DTpdtWOzUNI_hqLXosO8QOR9LIAb5sQ
Message-ID: <CALrBrZ1ufCAKthmJ_bTW7ByHj0HQyk5bKJJC0MJvk2Yr9abQJw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Exynos Mobile DFU and blkmap additions
To: Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini <trini@konsulko.com>, 
 Minkyu Kang <mk7.kang@samsung.com>
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

Hi,


2026=EB=85=84 2=EC=9B=94 25=EC=9D=BC (=EC=88=98) 00:55, Kaustabh Chakrabort=
y <kauschluss@disroot.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:

> This series has two additions for support for blkmap and capsule updates
> via DFU. The blkmap support is due to booting from sub-partitions from th=
e
> userdata partition.
>
> The series also has a patch which fixes U-Boot builds from failing due
> to the lack of a default fallback device tree.
>
> This must go through u-boot-samsung. Would be nice to get this accepted
> in this cycle itself.
>
> Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
> ---
> Changes in v2:
> - add patch which reintroduces DEFAULT_DEVICE_TREE option
> - Link to v1:
> https://lore.kernel.org/r/20260224-exynos-blkmap-dfu-v1-0-cfe615b68c88@di=
sroot.org
>
> ---
> Kaustabh Chakraborty (3):
>       board: samsung: exynos-mobile: use blkmap for booting from userdata
> subpartitions
>       board: samsung: exynos-mobile: add EFI capsule update support
>       configs: exynos-mobile: add DEFAULT_DEVICE_TREE option
>
>  board/samsung/exynos-mobile/exynos-mobile.c   | 69
> +++++++++++++++++++++++++++
>  board/samsung/exynos-mobile/exynos-mobile.env |  5 ++
>  configs/exynos-mobile_defconfig               | 11 ++++-
>  3 files changed, 84 insertions(+), 1 deletion(-)
> ---
> base-commit: 11198fa347390eb449c2a0939f5f00cf510fe285
> change-id: 20260223-exynos-blkmap-dfu-244b6f487783
>
> Best regards,
> --
> Kaustabh Chakraborty <kauschluss@disroot.org>
>

applied to u-boot-samsung.

Thanks,
Minkyu Kang.

>
