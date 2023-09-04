Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71F25C83F2C
	for <u-boot@archiver.kernel.org>; Mon,  4 Sep 2023 09:22:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D8B6086918;
	Mon,  4 Sep 2023 11:22:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AOl8EuIW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E811A86915; Mon,  4 Sep 2023 11:22:09 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B99386500
 for <u-boot@lists.denx.de>; Mon,  4 Sep 2023 11:22:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=bmeng.cn@gmail.com
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-52e297c7c39so991907a12.2
 for <u-boot@lists.denx.de>; Mon, 04 Sep 2023 02:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693819327; x=1694424127; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p6tDt2PS9aFeSW4jtOms+0cTfZSrBnbPu4YGs7F8ipY=;
 b=AOl8EuIW8rfMU/Q00faNjlGxwA+ZSxAn6N2P0OsFURGbgY0TJ8Jpb8Z/CMSvjj2iLu
 PYA8v+kb4njZVuNd9BjNpxxR7i8tKicBs7CMwnGD+ueromzs3TToGfHCfGijITL+WbMx
 vNEIjd+CFsNRXPjc08f/xy/gRF5aQ632rsn6PKCspRATJNB1XxAZxADKH1c/mvwafOgb
 V7K0k4aFLC2HOjt9tf8nw0iCEFSDlCTNGcxX1RlrUJojePHkirgsSwqo7edXX1WlA/F2
 1Nspe/G/+oCI1oa5YCOw+DnkEivmrXfc+oZpyfl6NsKLP6LaLjbMsoo7nr7n2z9jqMTC
 7sbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693819327; x=1694424127;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p6tDt2PS9aFeSW4jtOms+0cTfZSrBnbPu4YGs7F8ipY=;
 b=EGdMBgV9DifYRu09ClZ7xAXVEVV60DML0Z9b47JYUpzvqKmvffpgmQRKaf1NEuNDIC
 jwSAhCgyScCUmRb/4uR/R5Whwta9CLXPSbBRRuo1GxnFydpUDoBa3/+BoRgrmx3bFNGr
 WxjnfCb5l3xMilEc9W/D9XR9JphVoPAp/DFAU67Z9vpSaptSQjYvIvpZgvHztMpnHEhC
 HoN1W5arsdgnu/e8Y9+fup2QpNL+ciChd2Trr70LSbVTg5C91WbqVw7qtIQ0xCyOB9rX
 JKwwv2FwJ2rQPcpmhsUdw/BdckqK9bb71ZcVMF2xEeStuDIYOViGJl5en75xBC8wfFg+
 MPXg==
X-Gm-Message-State: AOJu0Yy1tdb893/MOfanH8FbP3xReKLHsQ3fcz07F5EC1cti9qMjmYWI
 0iayzdgw2zJiswFcN/c4SaQ+VstiTOSjyHUdSYX7/8kUxk4QnA==
X-Google-Smtp-Source: AGHT+IEwm8NjAXfkeIuhHtNl910gYgu8TZo7XqPL2KgvAZuEW0U9pcjQaBEb8Cnqxwk65lCErcQS3WIA71Ej4RW8CXM=
X-Received: by 2002:a05:6402:2035:b0:52a:5848:c674 with SMTP id
 ay21-20020a056402203500b0052a5848c674mr6634104edb.12.1693819327053; Mon, 04
 Sep 2023 02:22:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230823184746.842091-1-sjg@chromium.org>
 <20230823184746.842091-4-sjg@chromium.org>
In-Reply-To: <20230823184746.842091-4-sjg@chromium.org>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Mon, 4 Sep 2023 17:21:53 +0800
Message-ID: <CAEUhbmV2quMh_x6Nsy=MRqPwaB56QK-TgcfO7_rkEpmOrUBZBA@mail.gmail.com>
Subject: Re: [PATCH 3/8] x86: samus_tpl: Correct text base and alloc sizes
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
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

Hi Simon,

On Thu, Aug 24, 2023 at 2:48=E2=80=AFAM Simon Glass <sjg@chromium.org> wrot=
e:
>
> Make sure that CONFIG_TEXT_BASE is the same as CONFIG_X86_OFFSET_U_BOOT

The commit message should say:

Make sure that CONFIG_X86_OFFSET_U_BOOT is the same as
CONFIG_TEXT_BASE as it is changing CONFIG_X86_OFFSET_U_BOOT.

> since this boards boots into U-Boot proper in flash, not RAM. Also exapnd

s/boards/board

typo: expand

> the SPL malloc() size a little, to avoid an error.
>
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
>
>  configs/chromebook_samus_tpl_defconfig | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/configs/chromebook_samus_tpl_defconfig b/configs/chromebook_=
samus_tpl_defconfig
> index 4cfaf4bc5c7..6fefe2ddc25 100644
> --- a/configs/chromebook_samus_tpl_defconfig
> +++ b/configs/chromebook_samus_tpl_defconfig
> @@ -1,6 +1,8 @@
>  CONFIG_X86=3Dy
>  CONFIG_TEXT_BASE=3D0xffed0000
>  CONFIG_SYS_MALLOC_F_LEN=3D0x2000
> +CONFIG_TPL_SYS_MALLOC_F_LEN=3D0x2000
> +CONFIG_SPL_SYS_MALLOC_F_LEN=3D0x3000
>  CONFIG_NR_DRAM_BANKS=3D8
>  CONFIG_ENV_SIZE=3D0x1000
>  CONFIG_ENV_OFFSET=3D0x3F8000
> @@ -19,7 +21,7 @@ CONFIG_HAVE_MRC=3Dy
>  CONFIG_HAVE_REFCODE=3Dy
>  CONFIG_SMP=3Dy
>  CONFIG_HAVE_VGA_BIOS=3Dy
> -CONFIG_X86_OFFSET_U_BOOT=3D0xffee0000
> +CONFIG_X86_OFFSET_U_BOOT=3D0xffed0000
>  CONFIG_SYS_MONITOR_BASE=3D0xFFED0000
>  CONFIG_BOOTSTAGE=3Dy
>  CONFIG_BOOTSTAGE_REPORT=3Dy
> --

Otherwise,
Reviewed-by: Bin Meng <bmeng.cn@gmail.com>

Regards,
Bin
