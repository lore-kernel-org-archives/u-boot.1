Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A139C83F33
	for <u-boot@archiver.kernel.org>; Tue,  5 Sep 2023 05:58:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 67040864EA;
	Tue,  5 Sep 2023 07:58:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7245A8654D; Tue,  5 Sep 2023 07:58:25 +0200 (CEST)
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com
 [209.85.219.45])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8D09863C3
 for <u-boot@lists.denx.de>; Tue,  5 Sep 2023 07:58:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=fedoraproject.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dennis@gilmore.net.au
Received: by mail-qv1-f45.google.com with SMTP id
 6a1803df08f44-64a5bc52b0aso13166396d6.3
 for <u-boot@lists.denx.de>; Mon, 04 Sep 2023 22:58:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693893501; x=1694498301;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Fcg58Jf+gMwczYI/PYCHLS4Q9izfS3k7xycwLCtuUBs=;
 b=f9xHJOXKP7i6Q8bN7NulZ8tPpC5TQn7vw01GCZtDJwYz3pMDDv/8wr0QVLUmqGpe9A
 jptrA8P97qs91fP3UoLjQMcPqFByaWe7qj+ZsDh+0Qx24MDUrIWOAdQwdk6EpKWbp1KH
 lBwvrTnAzMScvkjeE3HYQMPIrnTO2re/M3kfG9dod+UCt3ROEcjStvkvKRkkQCHMiWCR
 c2GYhrA2a3RGdEw/UdG3LC7thyVCgnmnctjjw/hrAhj0LVqLpvUsZ8X7H71l2Ve7hqZc
 AicRFCVcUeL0XGFDw14GDMOTFeH4WTxC53YNu2Eg5jBrUo2qYc8jgsJDpvF9gtQxFsYD
 tLdA==
X-Gm-Message-State: AOJu0YykxmbFjFwtKyYF+8sP11/7dw/Vua/5Qb/8fISIt9K9GZbv1p4f
 dxPXE6znqDl7oh05z1P+Y9AxoVMExmlCosnC3LyYBPS59UQ=
X-Google-Smtp-Source: AGHT+IGUhxZg6BEdYU1gvqF54vFY+OOW7AJi21rv6GEaP2PlXJKkhvyJSxyOjsRqUwcQ7rUG3phGbg==
X-Received: by 2002:a0c:db92:0:b0:64f:36b3:5620 with SMTP id
 m18-20020a0cdb92000000b0064f36b35620mr12654834qvk.46.1693893501215; 
 Mon, 04 Sep 2023 22:58:21 -0700 (PDT)
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com.
 [209.85.160.179]) by smtp.gmail.com with ESMTPSA id
 g25-20020a0caad9000000b0064f778c8165sm4165483qvb.64.2023.09.04.22.58.20
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Sep 2023 22:58:21 -0700 (PDT)
Received: by mail-qt1-f179.google.com with SMTP id
 d75a77b69052e-4039f7e1d3aso15746321cf.0
 for <u-boot@lists.denx.de>; Mon, 04 Sep 2023 22:58:20 -0700 (PDT)
X-Received: by 2002:a05:622a:1f87:b0:413:3384:d43f with SMTP id
 cb7-20020a05622a1f8700b004133384d43fmr14387281qtb.11.1693893500643; Mon, 04
 Sep 2023 22:58:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230822143357.2818-1-wiagn233@outlook.com>
 <TY3P286MB2611C9AD6E5BB3756A959E89981FA@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
In-Reply-To: <TY3P286MB2611C9AD6E5BB3756A959E89981FA@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
From: Dennis Gilmore <dgilmore@fedoraproject.org>
Date: Tue, 5 Sep 2023 00:58:09 -0500
X-Gmail-Original-Message-ID: <CAABkxwswTJaxC-E7RH0Zxj-wRJ9kY6kTL2Bgb6__Kgzfm5FiBw@mail.gmail.com>
Message-ID: <CAABkxwswTJaxC-E7RH0Zxj-wRJ9kY6kTL2Bgb6__Kgzfm5FiBw@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] configs: starfive: Enable PCIE auto enum and
 NVME/USB stuff for Starfive Visionfive 2
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

> Although PCIE driver already exists, board defconfig isn't configured to
> enable PCIE enum on boot, thus USB storage device and NVME drive are not
> supported by default. So modify defconfig to enable PCIE auto enum, then
> start USB subsystem and scan nvme drive on boot.
>
> Signed-off-by: Shengyu Qu <wiagn233@outlook.com>
>
Tested-by: Dennis Gilmore <dennis@ausil.us>

> ---
>  configs/starfive_visionfive2_defconfig | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/configs/starfive_visionfive2_defconfig
> b/configs/starfive_visionfive2_defconfig
> index e9b63e5b84..3002c96f0e 100644
> --- a/configs/starfive_visionfive2_defconfig
> +++ b/configs/starfive_visionfive2_defconfig
> @@ -30,6 +30,7 @@ CONFIG_SPL_SPI=3Dy
>  CONFIG_SYS_LOAD_ADDR=3D0x82000000
>  CONFIG_SYS_PCI_64BIT=3Dy
>  CONFIG_PCI=3Dy
> +CONFIG_PCI_INIT_R=3Dy
>  CONFIG_TARGET_STARFIVE_VISIONFIVE2=3Dy
>  CONFIG_SPL_OPENSBI_LOAD_ADDR=3D0x40000000
>  CONFIG_ARCH_RV64I=3Dy
> @@ -43,7 +44,7 @@ CONFIG_SD_BOOT=3Dy
>  CONFIG_USE_BOOTARGS=3Dy
>  CONFIG_BOOTARGS=3D"console=3DttyS0,115200 debug rootwait earlycon=3Dsbi"
>  CONFIG_USE_PREBOOT=3Dy
> -CONFIG_PREBOOT=3D"setenv fdt_addr ${fdtcontroladdr};fdt addr
> ${fdtcontroladdr};"
> +CONFIG_PREBOOT=3D"nvme scan; usb start; setenv fdt_addr ${fdtcontroladdr=
};
> fdt addr ${fdtcontroladdr};"
>  CONFIG_DEFAULT_FDT_FILE=3D"starfive/jh7110-starfive-visionfive-2.dtb"
>  CONFIG_DISPLAY_CPUINFO=3Dy
>  CONFIG_DISPLAY_BOARDINFO=3Dy
> @@ -124,4 +125,9 @@ CONFIG_TIMER_EARLY=3Dy
>  CONFIG_USB=3Dy
>  CONFIG_USB_XHCI_HCD=3Dy
>  CONFIG_USB_XHCI_PCI=3Dy
> +CONFIG_USB_EHCI_HCD=3Dy
> +CONFIG_USB_EHCI_PCI=3Dy
> +CONFIG_USB_OHCI_HCD=3Dy
> +CONFIG_USB_OHCI_PCI=3Dy
> +CONFIG_USB_STORAGE=3Dy
>  CONFIG_USB_KEYBOARD=3Dy
> --
> 2.42.0
>
>
