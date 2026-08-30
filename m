Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E1C5C61DB9
	for <u-boot@archiver.kernel.org>; Sun, 30 Aug 2026 10:57:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 20CD66061D;
	Sun, 30 Aug 2026 10:57:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ToIkACo2-F5O; Sun, 30 Aug 2026 10:56:58 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788087418;
	bh=U2+J/Sq0fJJMwK99iBoa+J0PFsTf7G+bmbTvhmBfUhg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YAnOb/i0TsVN+ZFFfcuAHuhgWLWWnMcKHe8mvjRg8M+0u8C68s39rLSqr447cBcEP
	 kUBF+adGCh68so2pWcoYQyBMejyyCxVsVlgdIlj4J7eVZvyRkYiC3yNoNbPlWXvxvp
	 YP7LnAcBMOgbS8hM1veAH0juMQAp0kmKeNEIt57gCm6RXx0LHGSHgDsHuguxyngUef
	 Pp7TWekQxgfzkbBCKkRqQu7t8xf63ApKxCgOFAoWM4jI1cj8dJtKTud0XJBKAcbAX8
	 jsNdw/njeg/kaK80e5R4FabvsfkeQa6LOZnjpyZD9kq7grcmzQit7L2feHMsawHfY0
	 yiplCflfd3FLA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 12678605DF;
	Sun, 30 Aug 2026 10:56:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 2E790230
 for <u-boot@lists.u-boot-project.org>; Sun, 30 Aug 2026 10:56:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2030A80DCD
 for <u-boot@lists.u-boot-project.org>; Sun, 30 Aug 2026 10:56:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DCEZqbLNCSdc for <u-boot@lists.u-boot-project.org>;
 Sun, 30 Aug 2026 10:56:55 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::f34; helo=mail-qv1-xf34.google.com;
 envelope-from=pbrobinson@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=cv6s840C
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 25C8D80DCC
 for <u-boot@lists.u-boot-project.org>; Sun, 30 Aug 2026 10:56:54 +0000 (UTC)
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-90e7c71f86eso4307276d6.1
 for <u-boot@lists.u-boot-project.org>; Sun, 30 Aug 2026 03:56:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788087413; cv=none;
 d=google.com; s=arc-20260327;
 b=qw1+UppKD0/1NZTpVU3qlMJnWmi/h6McFC2ZDKC4xkKt66lnLSVs8brQ/Zv4VeJJu6
 Sj3sM2eq5gGBjv2y2KIA/wNAp6RMvQrsfKiflBYAg33VQhtNKyW4mYyR3RnxaG8fvmFo
 +fMUi5RC7GeBCKBepXgf5eWRC5H0SeARpXNkRR4FXemyTt3o8o6iExbMwzlZPlozgLIW
 l76aMS9X9+zCMCFDCWgHD4qkEe6xi0oGlglDbkTUNs+tqCa0o2+BqyPPdggAXyvW5seX
 z+rm8cuvi3a4+Ypi807PWRO7wCPU6IVyXfY+ymjMIm7rHF29wgdgGOVNBVl/v0fHy5+i
 O8+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=U2+J/Sq0fJJMwK99iBoa+J0PFsTf7G+bmbTvhmBfUhg=;
 fh=dvM9ICcfIcwF1MRE7lQGoMRE4wFDudmYlb0Z2dEscBA=;
 b=rwnusXghA3nsU2BAVD8GvKbjbLEa/Q7IeHN11F4kSK4FVuqj/ZLUay2WC8elgHmSrj
 IIpCarenka8fpis5DirNPodWtoT39FPI0BC8sgweU4ZlnKyMBw8TBJPeJfpKqwRKIxqf
 /DMr7ubff85/YcexGvbJT3kdccDMvAsMfe7lSBJ7r3OieIxRRoxuRDwJr51+CqIY+J8K
 RNMXaj8b7wtlbH3anSQgpLhVP4LypBvxJqma1lRZqbBjbwK+zPvczJWXyFJPtxK0Ozi4
 /UkzmSMhT0U1sL/i+eW+qZPWrUXJB0DA6LQLDrmIJEDqE+wYYMHIpa7CyxohizV/MCGG
 A+mw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788087413; x=1788692213;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=U2+J/Sq0fJJMwK99iBoa+J0PFsTf7G+bmbTvhmBfUhg=;
 b=cv6s840CdPFBHTeX9h0f/7QsGkaYEGaY1MQQw2zSrSzTwwhe5X38Q9DJpg7MEVGxv6
 b5w+5MmVboGm8ErhA0wgQlGJqnRPd/qogLu7ybBoJudrvb8S7QU2lkTDWc8LP5D+p238
 iuUdTRwaHHoNt1oWs7xDp3Xpv/EWW0i0f6rXuIDI2PclMQcpjZ5YBJki6+JPsXJRcpd5
 LhBfd+nI6hwRguCb9ewuHrtdLqYXqMhVqPsKVinexMle3wXNom/RDJBH6jXgg872aVkW
 nz701hIHWtUfJu+r4flzFpp+KEHIywHkzsBzcZs3iqx1HYayEGrFf9HO0+Q9Rowz94gx
 688g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788087413; x=1788692213;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=U2+J/Sq0fJJMwK99iBoa+J0PFsTf7G+bmbTvhmBfUhg=;
 b=Qdpjjzo6U0NbmBjzhXLmiYU1cF1gJHQokd82F77pH687Ec11nIoaB5F1jNBh1FEQ/h
 UMmjQtfMv2w9P8SFxSanozKzzq/GE1BfAWKQJHy2uFR1x75jf5AHrLgIllNZLLZFVTm4
 mPIQeF+6+WiuIo5e6g3wzxLBUSyHVH8Pxg2I9NYvMnOR8e8jEz1Mz8Qe2xNNFSM10UFs
 KsK65nVAV7AG8PE98iWGmO2xfw/vQSmLWzzw+mS2h72YkPPJmKMyLydA55ZSF3ASNE4c
 H+QoPHhBdb8qFEB64wDuqROQNiNPUTG2BkW6+owahDYov63LJwwZFaukapIcqh0H1qTb
 b8vg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwg8Tc80SZ36f0Ru5iQSjkbSGogs23Qoz59iea75s+aFXnZmqgHmFEhLqamsMbdoyQwW1GEiCo=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++lSOscWpB47oxLiCRFpvYPes9iI7wvtMnckmob7IoeEVCLAt7Lh
 9YIewrLnl6oC4S60TXy1dGWxOcMytS15/T1zgrfNKKrjxUzXDKUjFkAeawILkEN3HGwCAZh7GFW
 etmpTpEE2O9/22HNstcvUNvBasIAaXsc=
X-Gm-Gg: AYBFou0zOqYvq7c9Qmicz9jt/JWjYeIQF80DD4h9RsQ1iRl8tXML2Q+08wA6RkYpQaq
 FPjjGl7szI8XX3vjfCphTwotWzd3j2n+/5RbKZ0AgY1fgG3tyeVOAIjr6dsxnSWuuBTb/gAmT9r
 72E27XCX8h0dSuBAJFJPwlElSZA7nogdZUUIGAleOJz4WPPCXmlPkhfbbormC0ianNE2LawnLCi
 DG5XHqmexPMiTzzI1b5pH/P5U4gvqc+CwvY0cn3SpUZVfhWdFZmsy8xTVU71ZmPTRO6CpatwAQd
 ga0QcPSGEPuJJO88l6Dwu+iutwwouJlnOccjz5DQmuXplcQFEzIbNSgbCMJTclYAWf8PJATcqDR
 P8UZe3dBBwXTBYCtuSUnlfLdea4T5TcwZFVabnEXCE3rqTJAm2bDC7A80NDaLNGINlPtmFb8hsf
 lcln39q0wZnaGZm7g6PZXMz1I8QpYQySqKJP74ao8=
X-Received: by 2002:a05:6214:d6d:b0:8ef:91c5:8edb with SMTP id
 6a1803df08f44-90ce0c5b40fmr216408746d6.10.1788087413500; Sun, 30 Aug 2026
 03:56:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260830-ccaione-upstream-mtk-fdt-prepare-v2-0-f9cfce2ed42a@baylibre.com>
In-Reply-To: <20260830-ccaione-upstream-mtk-fdt-prepare-v2-0-f9cfce2ed42a@baylibre.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Sun, 30 Aug 2026 11:56:40 +0100
X-Gm-Features: AcwNN1UGJmybLfWLqVdAGcCEowZ6tc7mrqht1h42q4QAFk0PBBXGPbvYamx8wO0
Message-ID: <CALeDE9O3Taz2Q-NgEM4Prjn_Q=z6mXduMR7y_iSvwgBR6yKGXw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Add RITY devicetree preparation support
To: Carlo Caione <ccaione@baylibre.com>
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 u-boot@lists.u-boot-project.org, 
 Tom Rini <trini@konsulko.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 David Lechner <dlechner@baylibre.com>, Julien Stephan <jstephan@baylibre.com>, 
 Johan Jonker <jbx6244@gmail.com>, Macpaul Lin <macpaul.lin@mediatek.com>, 
 Chris-QJ Chen <chris-qj.chen@mediatek.com>, 
 =?UTF-8?B?UGFibG8gU3VuICjlravmr5Pnv5Qp?= <pablo.sun@mediatek.com>, 
 Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>, 
 Vincent Jardin <vjardin@free.fr>, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 =?UTF-8?B?UmFtYXggTG8gKOe+heaYjumBoCk=?= <Ramax.Lo@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
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

On Sun, 30 Aug 2026 at 11:18, Carlo Caione <ccaione@baylibre.com> wrote:
>
> RITY images select a base devicetree and an ordered list of overlays

What's an RITY image?

> through the storage, storage_dev, dtb_path, boot_dtb, fdtfile and list_dtbo
> environment variables. EFI boot needs the selected tree to be assembled
> and published through fdt_addr before the operating system is started.
>
> The environment interface, source-discovery rules and appended-image layout
> form a MediaTek-specific RITY contract. The referenced data uses existing
> U-Boot image formats, filesystems and storage stacks.
>
> Add MediaTek support to consume that interface. It locates the selected
> source on GPT block partitions or on the RITY UBI/UBIFS NOR layout, loads
> the base DTB, applies list_dtbo in order and publishes the completed tree.
> Both raw and authenticated DTB and DTBO inputs are supported.
>
> Expose mtk_fdt_prepare for interactive use. Retain the dtbprobe and
> fdtprobe command names and positional arguments used by RITY EFI boot
> environments. Also provide bootembedded for legacy boot. It locates and
> runs the appended RITY boot script through the standard source command,
> leaving the legacy policy and authentication to source and bootm.
>
> The command entry points live under cmd/mediatek and are documented under
> doc/usage/cmd. The implementation uses existing block, MTD, UBI/UBIFS,
> libfdt overlay, image verification, source and bootm services.
>
> Signed-off-by: Carlo Caione <ccaione@baylibre.com>
> ---
> Changes in v2:
> - Clarify that the RITY contract is MediaTek-specific and uses existing
>   U-Boot formats and storage stacks.
> - Move command entry points and command configuration under cmd/mediatek.
> - Add documentation for mtk_fdt_prepare, dtbprobe, fdtprobe and
>   bootembedded.
> - Rebase onto commit 658fc6aee957 ("fs/squashfs: fix directory table integer
>   overflow" series merge).
> - Link to v1: https://patch.msgid.link/20260828-ccaione-upstream-mtk-fdt-prepare-v1-0-bf80b489eb0f@baylibre.com
>
> ---
> Carlo Caione (3):
>       arm: mediatek: add RITY devicetree preparation
>       arm: mediatek: add RITY devicetree compatibility commands
>       arm: mediatek: add bootembedded compatibility command
>
>  MAINTAINERS                                      |   3 +
>  arch/arm/include/asm/arch-mediatek/fdt_prepare.h |  10 +
>  arch/arm/mach-mediatek/Kconfig                   |  25 ++
>  arch/arm/mach-mediatek/Makefile                  |   1 +
>  arch/arm/mach-mediatek/fdt_prepare.c             | 501 +++++++++++++++++++++++
>  cmd/Kconfig                                      |   1 +
>  cmd/Makefile                                     |   3 +
>  cmd/mediatek/Kconfig                             |  31 ++
>  cmd/mediatek/Makefile                            |   4 +
>  cmd/mediatek/bootembedded.c                      |  59 +++
>  cmd/mediatek/fdt_prepare.c                       |  65 +++
>  doc/usage/cmd/bootembedded.rst                   |  51 +++
>  doc/usage/cmd/mtk_fdt_prepare.rst                |  90 ++++
>  13 files changed, 844 insertions(+)
> ---
> base-commit: 658fc6aee95784139f070f9945cb3bc5da8d7d22
> change-id: 20260827-ccaione-upstream-mtk-fdt-prepare-68f51a5fd2ea
>
> Best regards,
> --
> Carlo Caione <ccaione@baylibre.com>
>
