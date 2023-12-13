Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63915C4332F
	for <u-boot@archiver.kernel.org>; Wed, 13 Dec 2023 20:46:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C9FF087948;
	Wed, 13 Dec 2023 21:41:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XUA5/zTb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F6A78793F; Wed, 13 Dec 2023 21:41:22 +0100 (CET)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1371087886
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 21:41:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@google.com
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a1e35c2807fso979813866b.3
 for <u-boot@lists.denx.de>; Wed, 13 Dec 2023 12:41:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1702500079; x=1703104879; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hyE8QsejD14+MbYTDHWTlvFzaq0/wgFr/4pqpTS/fmU=;
 b=XUA5/zTbiPXPWwS1mbaGBGm/c07BqT8yPqROcVne6H/u5fAbH2y4NjAYlDYb8No6cE
 trTRdpCxoVSP/nZFQvPte0LWM5OUBGvDmIXS1ob/JLfctAvHL76VvLQZkvj8/20lDjLe
 YEkrmEq8eV1agjwqI9PR/nGvVg//hy4BrbDj0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702500079; x=1703104879;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hyE8QsejD14+MbYTDHWTlvFzaq0/wgFr/4pqpTS/fmU=;
 b=xQdPg7jipX8J5UFkczqnRvYAZbmEaSj1c77vEjFvk3ve1YE64/QvSLtrNbOCeU7Uvd
 AdMc0TrnfGU7sOuNxVHBfGTNbRsEOureLfwVQiVKSBcxW36BPX7qltE1SABOq2WtffIS
 3GhFk0aEV0ri+U9RlBTJh+p0S/lmQpZ/UYnxrZugL6Zp/pNrvRNnT7WaGJvrUFc1yMOD
 wUME0r9i8rTXQYuC7YMS0B+4tTEpb+x8T5aFpqu8SxFB5bv/nR0/Sf4tUwOt6qeFKi0R
 Y7gVHwlNgGc+y/i5Xs+FALcRuE0DqEg5cH8fMkgX1lbR/MC1Kvz1oImFwUvdpDEaJSMa
 0nfA==
X-Gm-Message-State: AOJu0Yw7vj3fSufITLJsjKBSPIgOv2LofkD8vKypmvVW7rF9EU7lKF8T
 6EcBYm0PAymb8+/VgOie3Fak69ktKkilk6TWydc2pmq4fVjUfwzdchQ=
X-Google-Smtp-Source: AGHT+IGTYIhe0UNw4NrJRyZ/yfwmQArJOz8jLF32x8bN0dAo9rITErSlBd6xJG0aJLWX0XcglR6ELu21NVRIdLIScUE=
X-Received: by 2002:a17:907:948a:b0:a1e:f267:3e1d with SMTP id
 dm10-20020a170907948a00b00a1ef2673e1dmr5383547ejc.3.1702500079464; Wed, 13
 Dec 2023 12:41:19 -0800 (PST)
MIME-Version: 1.0
References: <cfad9ff8b9263104cc48aaabe4e1eddb@manjaro.org>
 <20231113112309.730323-1-i@shantur.com>
 <CABEcMwUwDypY090MOYSEtBGMRZOBnTk6hKuM2-OcJW-n+M7OHg@mail.gmail.com>
 <20231211205326.GX2513409@bill-the-cat>
 <CAPnjgZ23x6dAwq8UDvTXBikRgC3mbTfH5PV=KVF45pFPXY3cQA@mail.gmail.com>
 <20231213202951.GH2513409@bill-the-cat>
In-Reply-To: <20231213202951.GH2513409@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Wed, 13 Dec 2023 13:41:07 -0700
Message-ID: <CAPnjgZ2=P-kmGFEO0k_fp=XVps0YC16YJ_+yAqk4xVz0CGYz=g@mail.gmail.com>
Subject: Re: [PATCH v4] arm: dts: rockpro64: Add RockPro64 smbios
To: Tom Rini <trini@konsulko.com>
Cc: Shantur Rathore <i@shantur.com>, u-boot@lists.denx.de,
 philipp.tomsich@vrull.eu, 
 kever.yang@rock-chips.com, jagan@amarulasolutions.com
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

Hi Tom,

On Wed, 13 Dec 2023 at 13:29, Tom Rini <trini@konsulko.com> wrote:
>
> On Wed, Dec 13, 2023 at 12:50:06PM -0700, Simon Glass wrote:
> > Hi Tom,
> >
> > On Mon, 11 Dec 2023 at 13:53, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Mon, Dec 11, 2023 at 08:42:19PM +0000, Shantur Rathore wrote:
> > > > Hi,
> > > >
> > > > On Mon, Nov 13, 2023 at 11:24=E2=80=AFAM Shantur Rathore <i@shantur=
.com> wrote:
> > > > >
> > > > > Add smbios information for Pine64 RockPro64 board and enable in
> > > > > config
> > > > >
> > > > > Signed-off-by: Shantur Rathore <i@shantur.com>
> > > > > ---
> > > > >  Changes
> > > > >  v4: Change PINE64 to Pine64
> > > > >  v3: Enable SYSINFO and SYSINFO_SMBIOS in defconfig
> > > > >
> > > > >  arch/arm/dts/rk3399-rockpro64-u-boot.dtsi | 22 +++++++++++++++++=
+++++
> > > > >  configs/rockpro64-rk3399_defconfig        |  2 ++
> > > > >  2 files changed, 24 insertions(+)
> > > > >
> > > > > diff --git a/arch/arm/dts/rk3399-rockpro64-u-boot.dtsi b/arch/arm=
/dts/rk3399-rockpro64-u-boot.dtsi
> > > > > index 732727d9b0..089732524a 100644
> > > > > --- a/arch/arm/dts/rk3399-rockpro64-u-boot.dtsi
> > > > > +++ b/arch/arm/dts/rk3399-rockpro64-u-boot.dtsi
> > > > > @@ -9,6 +9,28 @@
> > > > >         chosen {
> > > > >                 u-boot,spl-boot-order =3D "same-as-spl", &spi_fla=
sh, &sdmmc, &sdhci;
> > > > >         };
> > > > > +
> > > > > +        smbios {
> > > > > +                compatible =3D "u-boot,sysinfo-smbios";
> > > > > +                smbios {
> > > > > +                        system {
> > > > > +                                manufacturer =3D "Pine64";
> > > > > +                                product =3D "RockPro64";
> > > > > +                        };
> [snip]
> > > Yes, we should just defer this and pickup the SMBIOS series that Ilia=
s
> > > has posted.
> >
> > I don't think it is a suitable substitute, it is just a fallback.
> >
> > So I believe this patch should be applied.
>
> Please note that this patch is adding _less_ details than the top-level
> model field contains today for the platform.  The only difference is
> "Pine64" vs "pine64".

The top-level model is "Pine64 RockPro64 v2.1", I believe. But:

- the first part of that is the manufacturer, not the product
- the second part is what we have in this patch
- the third part is the version

SMBIOS tries to split things up into separate fields.

So, perhaps a new version of this patch could add:

   system {
     version =3D "2.1";
   };

Regards,
Simon
