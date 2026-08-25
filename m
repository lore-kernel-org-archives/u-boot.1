Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBBFEC61DBE
	for <u-boot@archiver.kernel.org>; Tue, 25 Aug 2026 12:38:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 873E9405A2;
	Tue, 25 Aug 2026 12:38:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1sF9j-QsFKBQ; Tue, 25 Aug 2026 12:38:52 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787661532;
	bh=1WCR1R9j1FSsIjJV+B7letwki7aRi5KaiMTADvxDR7c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JKnA8+Xp4mrkxScWYBHgwN63b+S0DJTjucr5VKcPBLkRTOIHUMl0hXZKPaTqo2is3
	 SRfG01/nQJqpyyZvGmRul0ExZD7tlDO4hw6xymoxDTgpYQtah9xxB1S5z/WD05/ZFn
	 EMBpwHMp3dd/o6uZ3VG3h/NvUKRDJnnb0S0OA6B3ByCXCrEVd2X6D524i0QDA1pxRN
	 vIKhmYil1qPaAKZwAzPkM5wLZgrnDvsLfux6WWPum1Fxv76IUgzsc8jBJfjvUVVyKe
	 lr2F5N3yUcDjslR3OWyqTtUQrBr1KQj3PXdkqS/5R9Rhk8spbLlcvXnEjdL4pge6SU
	 hmfi4czt6WguA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 667354051A;
	Tue, 25 Aug 2026 12:38:52 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id AC5461465
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 12:38:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 921F36060A
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 12:38:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id U_JuO0YzuPUj for <u-boot@lists.u-boot-project.org>;
 Tue, 25 Aug 2026 12:38:49 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::634; helo=mail-ej1-x634.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=N3CHowHn
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 517D960606
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 12:38:48 +0000 (UTC)
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-c2022323c37so733243766b.0
 for <u-boot@lists.u-boot-project.org>; Tue, 25 Aug 2026 05:38:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787661526; cv=none;
 d=google.com; s=arc-20260327;
 b=EF8Eg3XDrRssfLrsO3Eobok7IKUD8+DTi2KHADxAKdQE/tZWVT7HAN0n2cm5Dx4rv3
 To8y7tEDvfBDdemqOroZvgWpUd3wCf7b+h42s7zrAJw8Z/4ze1Up86aaTHXHHu3Yh+Vx
 xQEHlNkHX5RzZGS57HPI91wG3bX4YaUYpplz+p3P64V2jTiw4TwaEoMiAYvh515jjie4
 dHvLPnOqnw+CCDplqqFkwWWuK79du67T5KHGvPSYn6/5u9+NYgUPKsC/WMYyGKOGT7zc
 ukDTo03v/pujdHujcPCftHwuDlgJTRN6mSyNS/kkw4KFOPBmCS0qrHk7LvmSf0IG3SVC
 ZfwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=1WCR1R9j1FSsIjJV+B7letwki7aRi5KaiMTADvxDR7c=;
 fh=GIeehlQdLciZCfOgfwMhSyAH/gPgtJ1yl2k1o0vVsK8=;
 b=kzQekgbf+vOHitRAvt5JyGKp5QyoerEIOjOFI6XESRe8qNeMhnPR8l9LjEcRWoDuhK
 wBO9CLt6LEt0WFTwj2nfQg6vXm2FD0Lsy48D+4S2Z4AYc/Cjuce5maukWO6111z8FnXx
 S6aUf9ekPVmJYtNeWxQUbv9H1zkpspKmeJWEAYApfoW2Pje/A61W5XgHcXPrnyhJMOXp
 bGgO1DC6JxQxv7HcrefJI9FtqVq1G5Vt4a4dAUkI8nHerpkywSTSdODxTB/syAa0DqyB
 ZgqRbtKzoCs3WpzE5c4Q7NqHNyJTOVwWg4KDE7NJiyaPmwO0amjL7MXd4CM0Ih5GRB3o
 Lh2g==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1787661526; x=1788266326;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=1WCR1R9j1FSsIjJV+B7letwki7aRi5KaiMTADvxDR7c=;
 b=N3CHowHnf+cv8QRQS2vO0ozNmuL7eVWpZgJWKtpy4ROcxgN3yOnvWEFPxreUXC9VZL
 A9m0fonufVeEF/Z0RTjlOlN1S45LnBLZ0y/dA8JVl6lgfdBGcwjYEPF35iTRcaPv75hH
 nKS9kZLXZxQ5u6OdgPdckQTpxb/if5DVahkO0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787661526; x=1788266326;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=1WCR1R9j1FSsIjJV+B7letwki7aRi5KaiMTADvxDR7c=;
 b=EUFPvCYwd2dWEqAd3a5eA/py9QC56WLaMGYKChnpO8GtncQwFp+d/mjzzm83/p6nmf
 2JHDlcVjldEq0pXG0QoHcgrK5KVm7vI6n17TgWqrjhkJ9up4Q8ez5aDZaA0an4VQ/wsC
 zPompU045l6Lnjh329z2/YppmvFTRmQdOb+25fFuHg4wgxvm018LBcYPgO/6/zi+TlIi
 cM7Agcd8o3nsm4xbhICUntKUB7N8pF8JGTdsAU2XszMQOVyjKUmIm64+n7mkl9QoqhUi
 fiJU2JooUrZgNdnPeOu4snlJEgnkjtwRIg5cuue59TmDTHieaVO9g+1zgQNWFa9FoqE5
 Ke/w==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpqma7HdDAuVIPffsf6M3So7aLlWLBXrizS/9wGLfcAEYwTXXIF5qagFYLD90qlxfSbNIYiohs=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++mGo8kYTzP8nW1rYJEt70zzepitgzAGlG8StXFZfuuHwVHwLZBE
 0eidob+IaWYUyHPCecc1IldrCU4tJTJ6NGbltkZcDl3tffEsl4JqxGw+s2U07T/alsEoyhhD7Yd
 vJQw3UTabsFmoyTnWPmCFJcajXUAXJlzbMc1E9QaW
X-Gm-Gg: AR+sD11J1s6FOQeozockGguq1tExyDfI94OOfxF8R2fDy6FTpP+S13MZkVZyZqTirT8
 kw9wYL59rhunaGBZEF2xv+mauowI2gwX9NKhVBQqJtHTuljW/pBlBl6oSUaDEnaAzxY+WpwhQa4
 TIOon17sq7nluUfB/re/X0ZRcU7EjWbVi/K9hBabic8JM4Hii3iaa/LApCeou+KOCwIXEh3Nhl3
 goxxpnJp4h5lhSz/MPYDF8sf/qGmyxnREP+TJqMjUqDQJI1ADSBz7lgI2kd9rXIUGUgXl9/r0Pd
 t3+S5aQfq8KydHyzytTgRfXh1XF3DjAFknDb00F1T6g=
X-Received: by 2002:a17:907:8995:b0:c24:4128:c19d with SMTP id
 a640c23a62f3a-c24e584dc37mr625993766b.4.1787661526220; Tue, 25 Aug 2026
 05:38:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260823101128.87329-1-xypron.glpk@gmx.de>
In-Reply-To: <20260823101128.87329-1-xypron.glpk@gmx.de>
From: Simon Glass <sjg@chromium.org>
Date: Tue, 25 Aug 2026 06:38:34 -0600
X-Gm-Features: AcwNN1V0l0wC3ATuJfiTT_yp8rjhNuDQk94TQhD5-Nr1sIbReBaIpd82K6T_yLc
Message-ID: <CAFLszTggKtXxv_-5tYXSY1YdbTxwO9XQLbEcGn+HbQ1uwTpNCw@mail.gmail.com>
Subject: Re: [PATCH 1/1] disk: drop Amiga partition table support
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Tom Rini <trini@konsulko.com>, Aaron Williams <awilliams@marvell.com>, 
 Mario Six <mario.six@gdsys.cc>, Stefan Roese <sr@denx.de>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@oss.qualcomm.com>, 
 Casey Connolly <casey.connolly@linaro.org>,
 Daniel Golle <daniel@makrotopia.org>, 
 Pranav Sanwal <pranav.sanwal@amd.com>, Johan Jonker <jbx6244@gmail.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, 
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Richard Genoud <richard.genoud@bootlin.com>, 
 u-boot@lists.u-boot-project.org
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

Hi Heinrich,

On Sun, 23 Aug 2026 at 04:11, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> The AmigaOne is not supported anymore by U-Boot.
> There seems to be no need to keep support for Amiga partition tables
> anymore.
>
> The usage in sandbox*defconfig has been for compile testing only.
> theodorable-x86-conga-qa3-e3845-pcie-x4_defconfig and
> octeon_ebb7304_defconfig support GPT partition tables.
>
> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> ---
>  configs/octeon_ebb7304_defconfig              |   1 -
>  configs/sandbox64_defconfig                   |   1 -
>  configs/sandbox_flattree_defconfig            |   1 -
>  configs/sandbox_noinst_defconfig              |   1 -
>  configs/sandbox_spl_defconfig                 |   1 -
>  ...able-x86-conga-qa3-e3845-pcie-x4_defconfig |   1 -
>  disk/Kconfig                                  |  13 -
>  disk/Makefile                                 |   1 -
>  disk/part.c                                   |   1 -
>  disk/part_amiga.c                             | 385 ------------------
>  disk/part_amiga.h                             | 137 -------
>  doc/usage/cmd/part.rst                        |   2 +-
>  include/part.h                                |   2 -
>  13 files changed, 1 insertion(+), 546 deletions(-)
>  delete mode 100644 disk/part_amiga.c
>  delete mode 100644 disk/part_amiga.h
>

From a brief look I could not find the source code for a real board.
There is code for the QEMU version here:

https://github.com/qemu/u-boot-sam460ex

The board was removed in 953b7e62919 ("Remove AmigaOneG3SE board")
about 15 years ago.

Reviewed-by: Simon Glass <sjg@chromium.org>

Regards,
Simon
