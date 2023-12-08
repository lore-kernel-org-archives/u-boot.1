Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 506BDC4167B
	for <u-boot@archiver.kernel.org>; Fri,  8 Dec 2023 11:56:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9613F87214;
	Fri,  8 Dec 2023 12:56:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=shantur-com.20230601.gappssmtp.com header.i=@shantur-com.20230601.gappssmtp.com header.b="hi8GsOl/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E1048743A; Fri,  8 Dec 2023 12:56:30 +0100 (CET)
Received: from mail-vk1-xa32.google.com (mail-vk1-xa32.google.com
 [IPv6:2607:f8b0:4864:20::a32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1BAE586C8E
 for <u-boot@lists.denx.de>; Fri,  8 Dec 2023 12:56:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=shantur.com
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=i@shantur.com
Received: by mail-vk1-xa32.google.com with SMTP id
 71dfb90a1353d-4b2d08747e7so576685e0c.1
 for <u-boot@lists.denx.de>; Fri, 08 Dec 2023 03:56:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shantur-com.20230601.gappssmtp.com; s=20230601; t=1702036587; x=1702641387;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Aot/ZhZWpS77sjQIZzw8wDKGhZahtzcCf/fZ/sKndpA=;
 b=hi8GsOl/W/1WRbc2uUdfyGV/F7lPYFVKwi+CXL25surCj5F4FNBq/cMLZwfDq8PevA
 M4EWCp/CAjeR27PN7SCu1oKwEPf/pLW2sczDcwgQLOeEbL7mZBJcopnI947gEJweVeHY
 +j8y2DrSQonDIEudBtpixfOneyIGCSBiMLR2dgTAQFMvvKDeLK6bR0+jVLqoxAKzG6PF
 mKAUtOOR6hCDNWRm8s/J3EvA1LIsWkljc+nbBxOPhrRoQF7TzwurFqX52xV3Qf6hEyYX
 hN1nWYOF6U3I0Vrbg4l9ntHLhObmZ8fBP9GFBlZAwr83jauIK3QPPVCmK1eLnBDCb6jD
 LyXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702036587; x=1702641387;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Aot/ZhZWpS77sjQIZzw8wDKGhZahtzcCf/fZ/sKndpA=;
 b=MdQV22s62NWEZ0POgNCW/TgwrjB0g4x5uhu851FwTvojU2RtJhFS0swvXKLYIqC6mV
 aVT+Ru+jSgvUx9xSU8iEv7YpBW3KY5IAXjST5strPtd+CcnBsvuxhYazFOosZoxAPeLj
 IyDTovHu6fHv+4DXc2xpsHQQytVKMyWx93SrhT75BGtVuwY/hdaxheSDsZqndBDf1TFV
 N/+hJNKAiGwSuqCNRLItbWfeRNYtAilsZMtC5CFJzFdKCwr4PWbLXL/a6zrX8CpbJi70
 t72cA6cApkR+46PujaXK9JLN95ha1Ge8+SST2VEOjYNm0v5DrK3Q8hx+mufwwyYnj0Aj
 cz+A==
X-Gm-Message-State: AOJu0YxNm/gSH3qdfVUSJJe96LY96N4VrWfz1rBW0easMoHkKuhylMdH
 XIXzMp8wHEiyqL5SxFuSsaE2Pcg85BfgxztI3IJwYg==
X-Google-Smtp-Source: AGHT+IGbVI47HiXa62uOe18tUEBuZzFTtdeYU5eQzsRAoxUoUwZWi0SVPHtEIdTq+kvxhBw32rheyiXuFsuR5ns0cAo=
X-Received: by 2002:a05:6122:4203:b0:4b3:207c:178f with SMTP id
 cm3-20020a056122420300b004b3207c178fmr2304420vkb.28.1702036586741; Fri, 08
 Dec 2023 03:56:26 -0800 (PST)
MIME-Version: 1.0
References: <20231119172310.1307942-1-i@shantur.com>
 <CAMty3ZDK3jcscgNfMZj4SySK6Kd9L1ZJ6nwaM3eJU_VTBA7yvw@mail.gmail.com>
In-Reply-To: <CAMty3ZDK3jcscgNfMZj4SySK6Kd9L1ZJ6nwaM3eJU_VTBA7yvw@mail.gmail.com>
From: Shantur Rathore <i@shantur.com>
Date: Fri, 8 Dec 2023 11:56:15 +0000
Message-ID: <CABEcMwXQaxfW9T9-Grpdf8jjjLn=4c=oV-e3cxgwd9wgerG5Sw@mail.gmail.com>
Subject: Re: [PATCH v3] arch: arm: Kconfig: Enable BOOTSTD_FULL for Rockchip
 SoCs
To: Jagan Teki <jagan@amarulasolutions.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>, 
 Bharat Gooty <bharat.gooty@broadcom.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
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

Hi Jagan,

On Fri, Dec 8, 2023 at 11:13=E2=80=AFAM Jagan Teki <jagan@amarulasolutions.=
com> wrote:
>
> On Sun, Nov 19, 2023 at 10:54=E2=80=AFPM Shantur Rathore <i@shantur.com> =
wrote:
> >
> > Rockchip SoCs can support wide range of bootflows.
> > Without full bootflow commands, it can be difficult to
> > figure out issues if any, hence enable by default.
> >
> > Reviewed-by: Simon Glass <sjg@chromium.org>
> >
> > Signed-off-by: Shantur Rathore <i@shantur.com>
> > ---
> >
> > (no changes since v1)
> >
> >  arch/arm/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > index d812685c98..fca6ef6d7e 100644
> > --- a/arch/arm/Kconfig
> > +++ b/arch/arm/Kconfig
> > @@ -1986,6 +1986,7 @@ config ARCH_ROCKCHIP
> >         imply CMD_DM
> >         imply DEBUG_UART_BOARD_INIT
> >         imply BOOTSTD_DEFAULTS
> > +       imply BOOTSTD_FULL if BOOTSTD_DEFAULTS
>
> Yes, but better to give this option to specific board vendors as
> defaults are enough to boot 1st bootflow and what ever media's it has.
>

Yes, that's correct it is enough to boot but by default there is no option
to choose what to boot from.
This was discussed in an earlier version of this patch [0] where I was
explicitly enabling only for RP64.

[0] - https://patchwork.ozlabs.org/project/uboot/patch/20231111001329.53770=
4-1-i@shantur.com/

Kind regards,
Shantur
