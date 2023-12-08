Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00B72C4167B
	for <u-boot@archiver.kernel.org>; Fri,  8 Dec 2023 12:59:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15B97874BB;
	Fri,  8 Dec 2023 13:59:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PJFagcmw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C1B6874FB; Fri,  8 Dec 2023 13:59:40 +0100 (CET)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61B2D8721C
 for <u-boot@lists.denx.de>; Fri,  8 Dec 2023 13:59:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=pbrobinson@gmail.com
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-54bfa9b3ffaso2958458a12.1
 for <u-boot@lists.denx.de>; Fri, 08 Dec 2023 04:59:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702040378; x=1702645178; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CXBAN8ZEOQBglZ7M3FqUvTr+cAYlLcO0SuaFKWgjnsU=;
 b=PJFagcmwtnvxKi8zRlXbaFpsjGB28p6ZlUfIA8L2zY+yoOy2qeT1uDHjv1AfYN9ief
 hB8VXlAh7LB+9yYtUdHtgZ/MDEJp0JBd45sNmqICXrFhEsPfU/aI4wExsrD+TL4vkLbu
 1TLlrwH2PcPNId+3qs0SXu+IO3alI9EFPgXsPMIq2aQ35mt3B2M2j8WGlu1/AR375AXs
 uww+8W6TAgGiA9F9FByQmkDltPOpopTqUPdM/rscsk9NMZEnrfGBCOb5HJL+3bBBm9Cq
 aVdjRBr8UYo96UluWqYqhwH2g39vJFlmYUR023aih+ptSb7RSmGw3yw+PnSglbJOVr7J
 Yl/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702040378; x=1702645178;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CXBAN8ZEOQBglZ7M3FqUvTr+cAYlLcO0SuaFKWgjnsU=;
 b=XJ81MHLo1poThHQX6sqTJB9cQXu8YFQWZgSTr0Cfi2MruZ3qo5KktPu82KHP4wKFyk
 8VktFtDPVV+c3AEVelIRwr4a6p/Nv1vbOd7xR9j/qh4nrgsZ8+54yb5U7Y0PkgiDUG7O
 DDI6qQifc087e74RUM01uzZoP7/39+viWAbL/HGVHE6Wh6gAdk4UhssKM0WZOWx/TdOa
 m2i00/LzO6Z3BO+MN78R7TUO8DP3ZUabg5ziuj6epOFrV91rf1dmRnRxrx9iimDjjusS
 49tx8udpc5/YmvgBvLxTD1JFKUOeVmZGMHlap5T6BxNKJomHWDKyVKsGfIU6GaP+FIbK
 FdkQ==
X-Gm-Message-State: AOJu0YzvmqBwheuA3aEzpJpudSPTRwNbZGkZ3oTpNEuj/TXyHt2wmg4G
 w21l16lc8MlHD/lsFndNuk87209aZbTRX9XLWqY=
X-Google-Smtp-Source: AGHT+IFZ+GXtfjLLX59evafCvPKUZTgC7bIgjIq7HZN1D+fGbkvHshl4SIeFmcbYxsZ22SvYNULsrjv1uGFpc0GgnL4=
X-Received: by 2002:a50:99c4:0:b0:54b:be9d:5c12 with SMTP id
 n4-20020a5099c4000000b0054bbe9d5c12mr49623edb.19.1702040377618; Fri, 08 Dec
 2023 04:59:37 -0800 (PST)
MIME-Version: 1.0
References: <20231119172310.1307942-1-i@shantur.com>
 <CAMty3ZDK3jcscgNfMZj4SySK6Kd9L1ZJ6nwaM3eJU_VTBA7yvw@mail.gmail.com>
 <CABEcMwXQaxfW9T9-Grpdf8jjjLn=4c=oV-e3cxgwd9wgerG5Sw@mail.gmail.com>
In-Reply-To: <CABEcMwXQaxfW9T9-Grpdf8jjjLn=4c=oV-e3cxgwd9wgerG5Sw@mail.gmail.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Fri, 8 Dec 2023 12:59:26 +0000
Message-ID: <CALeDE9NgZ_zRGgxo2kBaKYAKF-8tKmt-Eoddxf=8U2Q=T29Yjg@mail.gmail.com>
Subject: Re: [PATCH v3] arch: arm: Kconfig: Enable BOOTSTD_FULL for Rockchip
 SoCs
To: Shantur Rathore <i@shantur.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>, u-boot@lists.denx.de, 
 Simon Glass <sjg@chromium.org>, Bharat Gooty <bharat.gooty@broadcom.com>, 
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

On Fri, Dec 8, 2023 at 12:52=E2=80=AFPM Shantur Rathore <i@shantur.com> wro=
te:
>
> Hi Jagan,
>
> On Fri, Dec 8, 2023 at 11:13=E2=80=AFAM Jagan Teki <jagan@amarulasolution=
s.com> wrote:
> >
> > On Sun, Nov 19, 2023 at 10:54=E2=80=AFPM Shantur Rathore <i@shantur.com=
> wrote:
> > >
> > > Rockchip SoCs can support wide range of bootflows.
> > > Without full bootflow commands, it can be difficult to
> > > figure out issues if any, hence enable by default.
> > >
> > > Reviewed-by: Simon Glass <sjg@chromium.org>
> > >
> > > Signed-off-by: Shantur Rathore <i@shantur.com>
> > > ---
> > >
> > > (no changes since v1)
> > >
> > >  arch/arm/Kconfig | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > > index d812685c98..fca6ef6d7e 100644
> > > --- a/arch/arm/Kconfig
> > > +++ b/arch/arm/Kconfig
> > > @@ -1986,6 +1986,7 @@ config ARCH_ROCKCHIP
> > >         imply CMD_DM
> > >         imply DEBUG_UART_BOARD_INIT
> > >         imply BOOTSTD_DEFAULTS
> > > +       imply BOOTSTD_FULL if BOOTSTD_DEFAULTS
> >
> > Yes, but better to give this option to specific board vendors as
> > defaults are enough to boot 1st bootflow and what ever media's it has.
> >
>
> Yes, that's correct it is enough to boot but by default there is no optio=
n
> to choose what to boot from.
> This was discussed in an earlier version of this patch [0] where I was
> explicitly enabling only for RP64.

What actual extra functionality does this provide, what is the impact
on the size of images? You've not provided reasonable justification
outside of very vague statements, it would be useful to know what the
added options actually solves.
