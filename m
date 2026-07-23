Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF1F2C531C7
	for <u-boot@archiver.kernel.org>; Thu, 23 Jul 2026 09:00:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 02F3C6073F;
	Thu, 23 Jul 2026 09:00:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id w9H-7O-RTqhQ; Thu, 23 Jul 2026 09:00:20 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 80C1560640
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1784797220;
	bh=FxI2daZwvij0IowccQOxjCoZgBAzAzfdsr/9CCrwHrg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gaq6k7HzJX6q4Ry2DrebV4kUL9tZxc6NhmaN+jiiFJYF7Er0PDMEHW8bvCwxN890N
	 qpabdcVUMpmRxdkMdCU+8lByxGvEAkVK80gk8SH0Xn/ySYOh8DQFnDW/ez1R6Xw3lR
	 RVeFN56PmAYM2Zd4VM7vfOKU/IBYrW/Y6vplTcjt6Izr4FT4+SEhr/nx2Ffp882m/L
	 6ZtYe3qNgkCav4u7saKA285LljPsUA8sPyYGBFKiGUqlkQA3KtVeH+O7eBGiH1gDKg
	 1BJ8W/MJ8MktMe8BWRjDvxwPWCSpTU6HRZuK5XTp1Lv5BHjINay04i0DtzowRIL7Gt
	 Xxb7481oRs+iw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 80C1560640;
	Thu, 23 Jul 2026 09:00:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 8C53C707
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 09:00:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 71ECC80DE1
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 09:00:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8lYMdqCNS9JO for <u-boot@lists.u-boot-project.org>;
 Thu, 23 Jul 2026 09:00:17 +0000 (UTC)
Received-SPF: Softfail (mailfrom) identity=mailfrom; client-ip=85.214.62.61;
 helo=phobos.denx.de; envelope-from=briansune@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 5DEA080DD0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5DEA080DD0
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5DEA080DD0
 for <u-boot@lists.u-boot-project.org>; Thu, 23 Jul 2026 09:00:17 +0000 (UTC)
Received: by phobos.denx.de (Postfix, from userid 109)
 id B757C8404D; Thu, 23 Jul 2026 11:00:15 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47FC5803F6
 for <u-boot@lists.denx.de>; Thu, 23 Jul 2026 11:00:13 +0200 (CEST)
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7e9eaf04bfaso149257a34.1
 for <u-boot@lists.denx.de>; Thu, 23 Jul 2026 02:00:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784797212; cv=none;
 d=google.com; s=arc-20260327;
 b=dVu5j8p3fDY7AkDrFLjH8OxIiRDCHePQLKFB/AarZCi02qN+/2EJcP0dvo41wxcYzm
 GFOoWgpxe6Jt0VfdD1VknO1ytA7PXPSb+CZzBdUSPUzBke8Mxd/ckSI5nFd5cn8j5CeU
 YYrunT/VvLzL5iBJbcwP4vNrHapqYASSuYSg1IC3+r3QZf1lfcKioVz69huBovG/8CFR
 dtSLTs+Hj93X3PmP3bMkmhb1zx3IXadX9hyu9gkXIBnxjk1uETUn5LUStX8oOjDRYz8I
 EgIj4a8FFl4WOhFM7lvK5d4cuHvER7tjDm+GwZJdrWS0Ny9HXfHA5dNDpNNnYxFGUraP
 BHSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=FxI2daZwvij0IowccQOxjCoZgBAzAzfdsr/9CCrwHrg=;
 fh=ESG8HHxXX3t1dkgB5siDHB8qd94S+UJ33Jiw6zxlHMU=;
 b=A/VzX8l3yzqKuhIAlvSyMfa4UbNPMxiTr5yS+h50vFaSy1QTFf3YaN36H6IC0ObnIN
 KMGqOw6HfPyZfNBvjipEDkprit92u9clEy9eSyn7FJFMXXO88JpSsHoS+BEFHz2xnCPn
 B5hBvMffpHjGs12xYgR+xMYdiYlQSusoIYPIpK2ONPXnM6znHwiXLqH54nswbH/qcnQB
 OvuMVhN5Yk0i7Us1jwClgXK5xv6+HNbRO2K5ba6t3uhgu0LDFi8vP7WOpBNnrXGc5//E
 ghVqpilND2FpxTW7N/Mlvq417u1fCGAYATxlBzovTcR4ZtZaQZNNZeONBNvAL1ttxMMT
 e1gQ==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784797212; x=1785402012;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FxI2daZwvij0IowccQOxjCoZgBAzAzfdsr/9CCrwHrg=;
 b=ijKM+JA+MsWRtUIr/qqBeQkctDGHVD3X5NPzJ71+d6Ua9UVo0TeS0KTsHMvRmSShO8
 ak33K4qTbPnMe3LSWswzwPdS1ALDFtMxJgLRk206twkBWm4x5mE8XD/gz5NlZnAoXWSR
 Ea7lFBY0d5qPcWDet5LiTuPGHLRTh+df5Ql3xNNUgAOcrj/CIFGiLBbuHpqwar7nHx0r
 SleMO57GodSvJ0jMMYmy4hlkQRXpFf25adGCI3JY4Ci1gomv9jhKgDGVjMArbzz/UmI5
 b3uM5LzUgLNi8jbjNkOb/UyyBKUaxb9wffdteIvPUSFtiNF8DF/uD9JNZ6kNBY0IX+Jb
 CJKw==
X-Gm-Message-State: AOJu0Ywojw0Fi/iQ95dri41IYfcAneNTFaSTcLA2GNPa259invEQfUKG
 SdtSYJwYcqv0gV3zoTTgmxif7sgIkiOJqO1H8hcR8f/FTdmOIJ/mIU2H4x8CitBW2rmXmb9/rsB
 wowPpsOFU7mRgNKV/1xsueckP+QTla90=
X-Gm-Gg: AR+sD10AW++YEDCtLgF2CBiWKgRWye8NEuWCK+W03jVXFTLqH1zfukxU/IRg9QnBfF5
 CrkkwZanKXxAsFHuzZUgx0/QE5rgkPKDwkTe3CvyPjdji2xPSGlg9+A7XTYVbH6MYEfejeGwHr1
 RnE9DMD6xZbHpn79r6bUDHtfjPry7ASCIq3X/oWVIf1UHvIRYzxEONPPs+5awA6WQkfAHXQq2me
 VNnHejmkPVAzp/aB+4XRchfYfUt97h1ZwGesMW80r0wxUgRTzWN/2BTx5os85E=
X-Received: by 2002:a05:6830:2691:b0:7dc:e336:c828 with SMTP id
 46e09a7af769-7ee43edd46cmr1291586a34.10.1784797211679; Thu, 23 Jul 2026
 02:00:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260723024306.9888-1-alif.zakuan.yuslaimi@altera.com>
In-Reply-To: <20260723024306.9888-1-alif.zakuan.yuslaimi@altera.com>
From: Sune Brian <briansune@gmail.com>
Date: Thu, 23 Jul 2026 16:59:59 +0800
X-Gm-Features: AUfX_mydziNi087IQ3bW0OUbIUgjrja-8dl_xyZxXKwXFI7ICTeAGZzVPK9UPMk
Message-ID: <CAN7C2SDhSzVabXx+EswLksHbQSEyK4GxgkgUVG7Z3Kx7RdS6JA@mail.gmail.com>
Subject: Re: [PATCH] arm: socfpga: Rename TARGET to ARCH for SoCFPGA
To: alif.zakuan.yuslaimi@altera.com
Cc: u-boot@lists.denx.de, Marek Vasut <marex@denx.de>, 
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Anshul Dalal <anshuld@ti.com>, 
 Simon Glass <sjg@chromium.org>, Johan Jonker <jbx6244@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784797212; x=1785402012; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FxI2daZwvij0IowccQOxjCoZgBAzAzfdsr/9CCrwHrg=;
 b=nk1JovsWzRMEM7AjIljegBzTNPYNcYptTTZ2DR4TI3svEtaNynxtxPtTU7nNUJBe5j
 P7rM+WntwLZcJCOXNlQ9Ura044I4UhCjnZZDYWVresp1q694UvzA+6H+4ZpQg65PpUNK
 6dPKVOytkMxD6rYrB3Ch2Nwq146F2H9/oNzlNvgoNqw6AzA09kc/JFUul6A8eboo4i83
 FCzRl/Q0FGbePbkvf++f3y2HywOZsxLVlGgHxJoPHyAxiVrR63ut110N96ODALekJ0zJ
 EKA8Ls2bNIGPZmopuyhhrThazLfg/XVFrIPjXGfB0yoaDJJpOxg1sl1M/rCACR1axD2U
 l/Ug==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=nk1JovsW
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=briansune@gmail.com
X-Mailman-Original-Authentication-Results: phobos.denx.de;
 dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="nk1JovsW"; 
 dkim-atps=neutral
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

HI Alif,

Just reminding, duplicated patch:

https://patchwork.ozlabs.org/project/uboot/patch/20260407153650.26404-1-bri=
ansune@gmail.com/.

Which is under reviewed.

Thanks,
Brian

On Thu, Jul 23, 2026 at 10:43=E2=80=AFAM <alif.zakuan.yuslaimi@altera.com> =
wrote:
>
> From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
>
> Commit 62f7a9460209 ("Replace TARGET namespace and cleanup properly")
> replaces the TARGET namespace to ARCH for all SoCFPGA devices.
>
> Some of the TARGET namespaces are still left out, update leftover TARGET
> to ARCH following current SoCFPGA naming.
>
> Fixes: 62f7a9460209 ("Replace TARGET namespace and cleanup properly")
>
> Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
> ---
>  arch/arm/mach-socfpga/board.c | 4 ++--
>  cmd/Kconfig                   | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/mach-socfpga/board.c b/arch/arm/mach-socfpga/board.=
c
> index b202ca258bc..b662afc1ad7 100644
> --- a/arch/arm/mach-socfpga/board.c
> +++ b/arch/arm/mach-socfpga/board.c
> @@ -210,8 +210,8 @@ void lmb_arch_add_memory(void)
>  }
>  #endif
>
> -#if (defined(CONFIG_TARGET_SOCFPGA_ARRIA10) || \
> -     defined(CONFIG_TARGET_SOCFPGA_GEN5)) && defined(CONFIG_XPL_BUILD)
> +#if (defined(CONFIG_ARCH_SOCFPGA_ARRIA10) || \
> +     defined(CONFIG_ARCH_SOCFPGA_GEN5)) && defined(CONFIG_XPL_BUILD)
>  unsigned long board_spl_mmc_get_uboot_raw_sector(struct mmc *mmc,
>                                                  unsigned long raw_sect)
>  {
> diff --git a/cmd/Kconfig b/cmd/Kconfig
> index 35ce42f8397..b724f4f8d49 100644
> --- a/cmd/Kconfig
> +++ b/cmd/Kconfig
> @@ -1911,7 +1911,7 @@ menu "Shell scripting commands"
>
>  config CMD_C5_PL330_DMA
>         bool "Release Reset DMA Channels for PL330 Handshake"
> -       depends on TARGET_SOCFPGA_CYCLONE5
> +       depends on ARCH_SOCFPGA_CYCLONE5
>         help
>           Provides access to Reset Manager Per2ModRst. Enables DMA
>           channels for ARM PrimeCell PL330 via reset release.
> --
> 2.43.7
>
