Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66985CCD193
	for <u-boot@archiver.kernel.org>; Sat, 18 Oct 2025 21:27:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2741C83768;
	Sat, 18 Oct 2025 23:27:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="J8HYxtsR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B822F80077; Sat, 18 Oct 2025 18:38:22 +0200 (CEST)
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com
 [IPv6:2a00:1450:4864:20::229])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BCE5F80077
 for <u-boot@lists.denx.de>; Sat, 18 Oct 2025 18:38:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-375eff817a3so30469971fa.1
 for <u-boot@lists.denx.de>; Sat, 18 Oct 2025 09:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760805500; x=1761410300; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kuNfjnXdtbYcyk1cmX0reuNnJQqKZfZrtjHOwo6gZCk=;
 b=J8HYxtsRy7m1dEcn4woXHKNyvk/QrPkW+uoGz/2UOAzfI32k4JA71Bfz+oqjndNamQ
 pppgUH4NMJnYZZZTOvO2ujgQt7cV+LmW2IrRBDK66CPyfPZYVihzzJ/dL84iVsGsyhIx
 tBRoKOHMuA5QqTo7uKxvw6khkmMLWLG3vrW7YFLJzev6XGni6GLRUCEQKxRd6b7miS8i
 3x2L0m7VBPrczbMmxixstqPmh+/YsZzw2QARTnR+NYakZrxprGypEQ9xbSiTprXagU0F
 W7eLiXSBLT38UCm8TVrMDEGMTKqpokvzxi6RRtDhNRk276eUQjspo7t6yId85fSuO7Ox
 o+yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760805500; x=1761410300;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kuNfjnXdtbYcyk1cmX0reuNnJQqKZfZrtjHOwo6gZCk=;
 b=wrvB/MYj8HIFqI5xzlvCvB/LTfUuz/YUq5YJhUEbcQxFZEdeuhc1WES9jvgL15CMvx
 9jQSF0BDrptgRZSov+NuQYA/TbLVsMxqgbC6ASA8Db2+vkfXKHXQ1R4sWz9y1cQHeMvb
 xmnXNrVgY8cbY68Vf8mOIPgvsHsNj69s487wZveJKl9I8pXv5rIShQkQpftgy5oAYPky
 98RhFnkWmO+VcRTF91P7hASJAd+WN5GTKMuSXbqfCg4MLZPDAow7GezbIvxFcl7OWGM0
 1aahJnEg8t69b1Fx+amZUkrXvdUzzrjGtaorhHx5uJ64L3/mBvGvKJcm69q4YhbV/7Qw
 NAXQ==
X-Gm-Message-State: AOJu0YzvDQMhIftz44P24+5NOrO455ooGQYKDy1zeMHEydEOxWS+T+d6
 1/at/xsB8NnHTCM/3aKfc25S1bFhVqy4l/SBLIH9DFXkmZDNg37VHAqxJE60vmte14NCyoEi1vm
 Eh5kiKntSztAQsDwCg/XKwOBHA1tgE/k=
X-Gm-Gg: ASbGncuK6411RCmZRwyhjNeaiq0e5K86jfFJ9KX3rkNjwcyjU45uJ7ytEBLCeKDANPy
 jELcTE+PkGEGqhUZX/6sETIzOKzD81aJXabyLJ37TASxWLMIL0FxxIHpBAEkRgp7fEjynNXoaKG
 Dj5JQeOZkr4NmBnKRs4pjFfontk1pEg72hWWkAjIJIU5MBgiTU1eSoUYN2fj4y5rFr0txQhpxnd
 DCIMaecoNfJk+iu5UHDzUjLbctl+WltzTfk0BbgVAv4h+2af65+hO14X00gHIoRNHMGaiSqSXyP
 QQRdQLIcp7n1rHDlFyYJZgRnEMl5XFbd19px
X-Google-Smtp-Source: AGHT+IHoimoUf1sUpcKo1y9COaEfabxXLpyf4ovq+KcNmcpdmY5z/LxXBk63U/H3ch4tEDQnLsdc/kkH1SAA4GBgj8I=
X-Received: by 2002:a2e:a54e:0:b0:336:6c93:9726 with SMTP id
 38308e7fff4ca-37797831023mr20211291fa.4.1760805499657; Sat, 18 Oct 2025
 09:38:19 -0700 (PDT)
MIME-Version: 1.0
References: <20251013-imx943usb-v1-0-293e79d4bc12@nxp.com>
In-Reply-To: <20251013-imx943usb-v1-0-293e79d4bc12@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 18 Oct 2025 13:38:08 -0300
X-Gm-Features: AS18NWDJC7_C03JT8Z5T8_kif7jSyWNa0ydDlQKTHHm90mRavWs0NyzSmUln808
Message-ID: <CAOMZO5AOsUMJfQ9g5vdwrFmtF2cpg+U4z4uWVhj-uQa7ROG+_g@mail.gmail.com>
Subject: Re: [PATCH v3 00/10] Enable USB and ENETC on i.MX943 EVK
To: alice.guo@oss.nxp.com, Marek Vasut <marek.vasut@mailbox.org>
Cc: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Marek Vasut <marex@denx.de>, 
 Tom Rini <trini@konsulko.com>, Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Rudolph <patrick.rudolph@9elements.com>, Alice Guo <alice.guo@nxp.com>,
 Stefano Babic <sbabic@nabladev.com>, Peng Fan <peng.fan@nxp.com>,
 Ye Li <ye.li@nxp.com>, 
 Jacky Bai <ping.bai@nxp.com>, Jindong Yue <jindong.yue@nxp.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Frank Li <Frank.Li@nxp.com>, 
 Simon Glass <sjg@chromium.org>, Lukasz Majewski <lukma@denx.de>,
 Minkyu Kang <mk7.kang@samsung.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>,
 Minda Chen <minda.chen@starfivetech.com>, 
 Tim Harvey <tharvey@gateworks.com>, Paul Barker <paul.barker.ct@bp.renesas.com>,
 Roger Quadros <rogerq@kernel.org>, Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>, 
 Hanyuan Zhao <hanyuan-z@qq.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Weijie Gao <weijie.gao@mediatek.com>,
 Andrew Goodbody <andrew.goodbody@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Sat, 18 Oct 2025 23:27:21 +0200
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

Hi Marek,

On Mon, Oct 13, 2025 at 3:59=E2=80=AFAM <alice.guo@oss.nxp.com> wrote:
>
> Changes for v1:
>  - Adding USB2 and USB3 device tree nodes with required PHY and
>    regulator support.
>  - Enabling ENETC1 and ENETC2.
>  - Updating Kconfig and DTSI files to support these interfaces.
>
> Changes for v2:
>  - Resend patch series with updated To list.
>
> Changes for v3:
>  - Remove logically dead code in imx94_link_config().

Are you happy with the USB parts of this series?

Thanks
