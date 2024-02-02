Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8EB1C4828F
	for <u-boot@archiver.kernel.org>; Fri,  2 Feb 2024 21:16:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF78687E50;
	Fri,  2 Feb 2024 22:16:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=foundries.io
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=foundries.io header.i=@foundries.io header.b="C6UESUI4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D11387E23; Fri,  2 Feb 2024 22:16:54 +0100 (CET)
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com
 [IPv6:2a00:1450:4864:20::233])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5615187E50
 for <u-boot@lists.denx.de>; Fri,  2 Feb 2024 22:16:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=foundries.io
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=igor.opaniuk@foundries.io
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-2d090c83d45so6134061fa.3
 for <u-boot@lists.denx.de>; Fri, 02 Feb 2024 13:16:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=foundries.io; s=google; t=1706908611; x=1707513411; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TDldGXpyVFPp0lYAcoUyEH13ld7qlh1GnYU0GUtnkq4=;
 b=C6UESUI41pHjEk/sdO+XY0UVGn2P6MMT9u8XVP67rxQa43mnB0uxzCI8ElUpWs2SSw
 mWzC9gsJVcbfEZGPPUGryuZMLPGECBCv3thcM/xIkmDhpsCoElNmnj+azPBrzrvZZtou
 R5A9C21DDehLmz4rZ7SZP21C//M6fxpl1Re7kv3SDfNSosD7VbR3bwINn4uV7rwDuTS3
 uRhKR715tl9zgNlvv6fo4IogTIjZhSBMAKwXFDitOzfq0XUkJeR7Ko1XTW0oSZAXDEz+
 hztMibvKaiwZZsZ3TI7T7fVmGEVQKKLBAxbbJCOMbrcIt+vlVpxjKsw4Pv/vp1ndjaq4
 jdJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706908611; x=1707513411;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TDldGXpyVFPp0lYAcoUyEH13ld7qlh1GnYU0GUtnkq4=;
 b=Y0yE7UQpn45Wyetj2srq+eD/jPbHJBIcCNRtkCkaKSseCT18SwQQ9cs+er66aPoS0t
 H5WEYxdD+7HnZqYThi1P8psqt7+MZ4a9DF0bUEZex3/WiPah2EgTU2nj5L5VCl7BZk0m
 0sATSPgtIOn5ciDnkg1VzbYi73Ru3sjYLzUVdzsnH6VufihJBIYnJJyArW2PkpoGn5Fv
 DeNlX3QHmNvQg1HmoiRRbFuIQ+HklKGjcUd6D1JYPeOFoTfWNU2J84p+a8tcOQXM/EUC
 zrmdpHxjlV4e1JdPDFRixYOGPutRsKQYd2tJsrgHX/2/oGsSHfzy9mn72LMWMohjq7Gq
 TxWQ==
X-Gm-Message-State: AOJu0YyaT7vwARfdqQIIq96A4BlRCoU3w1OsneH4B8qdQtnVNKbnSQE1
 6nJL13Lou17/0Sp6oOzX/wTphfBh0hkqFMW6kS1k410ThfkT1mQpLDwc4gF1b4oeXiow6F8Jv2O
 u9vg/E5h3iKntQV6nsxtK1iHvY2gjYEAQ4uLZAQ==
X-Google-Smtp-Source: AGHT+IEnDmFt27mZRSnCol1JtX/JdPezHI6rQLTZpqzTSYrsLFHr/rEhbwacu7SsuJdxjKBlHVFkcX4HA+7+Uxug4UQ=
X-Received: by 2002:a2e:850b:0:b0:2d0:7613:5fd9 with SMTP id
 j11-20020a2e850b000000b002d076135fd9mr1968092lji.31.1706908611474; Fri, 02
 Feb 2024 13:16:51 -0800 (PST)
MIME-Version: 1.0
References: <20240202160405.4126192-1-festevam@gmail.com>
 <CAL6CDMFC0tmQgE1jWP0_s1uKVBpSH_9U9xqs9sPY4Mv2u9R_4Q@mail.gmail.com>
In-Reply-To: <CAL6CDMFC0tmQgE1jWP0_s1uKVBpSH_9U9xqs9sPY4Mv2u9R_4Q@mail.gmail.com>
From: Igor Opaniuk <igor.opaniuk@foundries.io>
Date: Fri, 2 Feb 2024 22:16:39 +0100
Message-ID: <CAL6CDMG0Rawp0BuYvzrA=g5dyYQ3YFgjftymaWKsp31gMXRCyw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] mx6sabresd: Fix U-Boot corruption after saving the
 environment
To: Fabio Estevam <festevam@gmail.com>
Cc: sbabic@denx.de, trini@konsulko.com, uboot-imx@nxp.com, 
 u-boot@lists.denx.de, Fabio Estevam <festevam@denx.de>
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

On Fri, Feb 2, 2024 at 9:34=E2=80=AFPM Igor Opaniuk <igor.opaniuk@foundries=
.io> wrote:
>
> On Fri, Feb 2, 2024 at 5:04=E2=80=AFPM Fabio Estevam <festevam@gmail.com>=
 wrote:
> >
> > From: Fabio Estevam <festevam@denx.de>
> >
> > U-Boot binary has grown in such a way that it goes beyond the reserved
> > area for the environment variables.
> >
> > Running "saveenv" and rebooting the board causes U-Boot to hang because
> > of this overlap.
> >
> > Fix this problem by selecting CONFIG_LTO so that the U-Boot proper
> > size can be reduced.
> >
> > Also, to prevent this same problem to happen in the future, use
> > CONFIG_BOARD_SIZE_LIMIT, which can detect the overlap in build-time.
> >
> > CONFIG_BOARD_SIZE_LIMIT is calculated as follows:
> >
> > CONFIG_BOARD_SIZE_LIMIT =3D CONFIG_ENV_OFFSET - u-boot-img.dtb offset
> > CONFIG_BOARD_SIZE_LIMIT =3D 0xc000 - 69 * 1024
> > CONFIG_BOARD_SIZE_LIMIT =3D 715766
> >
> > Signed-off-by: Fabio Estevam <festevam@denx.de>
> > ---
> > Changes since v1:
> > - Select LTO. (Tom)
> >
> >  configs/mx6sabresd_defconfig | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/configs/mx6sabresd_defconfig b/configs/mx6sabresd_defconfi=
g
> > index a90efe4a7786..d4fb55622cf1 100644
> > --- a/configs/mx6sabresd_defconfig
> > +++ b/configs/mx6sabresd_defconfig
> > @@ -21,6 +21,9 @@ CONFIG_SPL_SERIAL=3Dy
> >  CONFIG_SPL=3Dy
> >  CONFIG_SPL_LIBDISK_SUPPORT=3Dy
> >  CONFIG_PCI=3Dy
> > +CONFIG_LTO=3Dy
> > +CONFIG_HAS_BOARD_SIZE_LIMIT=3Dy
> > +CONFIG_BOARD_SIZE_LIMIT=3D715766
> >  CONFIG_FIT=3Dy
> >  CONFIG_SPL_FIT_PRINT=3Dy
> >  CONFIG_SPL_LOAD_FIT=3Dy
> > --
> > 2.34.1
> >
> Reviewed-by: Igor Opaniuk <igor.opaniuk@foundries.io>
>
> btw, from my experience, the same issue will probably occur again in futu=
re,
> especially when the current U-Boot size is already close to the defined l=
imit
> (yes, with this patch it will be reported during compile time, but still)=
.
>
> Have you considered adjusting the boot image layout instead
> (moving CONFIG_ENV_OFFSET, so unlikely
> U-Boot image will overlap again) to tackle feature problems?
I've just checked the previous patch version, where
you addressed that exactly with CONFIG_ENV_OFFSET change and
following suggestions/objections from Tom, so sorry for the noise :)

>
> --
> Best regards - Freundliche Gr=C3=BCsse - Meilleures salutations
>
> Igor Opaniuk
> Senior Software Engineer, Embedded & Security
> E: igor.opaniuk@foundries.io
> W: www.foundries.io


--=20
Best regards - Freundliche Gr=C3=BCsse - Meilleures salutations

Igor Opaniuk
Senior Software Engineer, Embedded & Security
E: igor.opaniuk@foundries.io
W: www.foundries.io
