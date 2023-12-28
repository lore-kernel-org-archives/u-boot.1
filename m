Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D54CC3DA6E
	for <u-boot@archiver.kernel.org>; Thu, 28 Dec 2023 15:09:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 74D5E87954;
	Thu, 28 Dec 2023 16:09:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bikWXHem";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 348B987A27; Thu, 28 Dec 2023 16:09:27 +0100 (CET)
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com
 [IPv6:2607:f8b0:4864:20::82c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9D66879E5
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 16:09:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-427f0f75cf0so6308521cf.1
 for <u-boot@lists.denx.de>; Thu, 28 Dec 2023 07:09:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1703776163; x=1704380963; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=no58KO7DxbMxIZ5ojulTOZwDRMrp2Sexn2Z6gScpYu8=;
 b=bikWXHemqKD4qtxXB4cIiwO71+cU3CCA5pM9X9yQ5HJqCTMap9av0wluYWT5LqoiZQ
 xqe9Z7MiOYDUWtsunRqD5k/L+yshwlvpUOy5mcp+gLNVBSKjUWwN5Hv6xMxFEaPUF7Sw
 syP0eLF4pY3Iy1fQXpcP3T/5PwG98uVtf8gs0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703776163; x=1704380963;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=no58KO7DxbMxIZ5ojulTOZwDRMrp2Sexn2Z6gScpYu8=;
 b=whZHG/BPrPJhlhphnZsPW24zmG3Yup0lR0K4W6rOgBGzkdV9DYWz4oMfahbLS2l5DV
 h/yGJhjm7x57Cxa87GOigSAxQhe81dlDimLghUPHIOqI6xW0ygb0/SoV5nGOWxCVJ7co
 RJUN9HF6k/xm681WemqeAcT6bkf+C66bTNk9jfEppK8Z3a0QfxuueTuVOg54GxGl6Mu+
 PouKGDtYZbGiXGIXjNRu3hTLV0Voo6Y+vIQzRl9zp1Zzceddv4PBo7yaxWXzdzu3Ngz7
 c6KYseicxw7Wvy2BoKawO8xjmu90Jrgl/fEAktHXkPhce54+8N4F0AkBA8RPT68bY9gB
 lF/A==
X-Gm-Message-State: AOJu0YwFJ49xC9FtJ+3GFqy901v1720iNepJI7nz8/D68XtSa/FSySxJ
 ky5PLIQ1A5GYwnVCsq8CIVXuSBPUOqdw5pQr1VTo63eNGYPP
X-Google-Smtp-Source: AGHT+IGXobipWD9AF+Dr6vuXuZ8xSzaJ16THTAe2IDx5kjzf4GRn6OHi0yl+naUUwM1p7INNs75ruJWacCShFzs2Deo=
X-Received: by 2002:ad4:530d:0:b0:67f:ac30:6256 with SMTP id
 y13-20020ad4530d000000b0067fac306256mr8275485qvr.104.1703776163433; Thu, 28
 Dec 2023 07:09:23 -0800 (PST)
MIME-Version: 1.0
References: <20231228115804.3626579-1-sumit.garg@linaro.org>
 <20231228115804.3626579-5-sumit.garg@linaro.org>
 <CAFLszThfxe_n02auF+vZ1u7FynKkrWEYFU3SdkRTLgBVuiv+Hw@mail.gmail.com>
 <20231228140313.GB2652760@bill-the-cat>
In-Reply-To: <20231228140313.GB2652760@bill-the-cat>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 28 Dec 2023 15:09:12 +0000
Message-ID: <CAFLszTiPFyRQZtrKhETjMzn6JukFJaBYMugdL-RPO3LJB9XUMA@mail.gmail.com>
Subject: Re: [PATCH v3 4/8] dts: Add alternative location for upstream DTB
 builds
To: Tom Rini <trini@konsulko.com>
Cc: Sumit Garg <sumit.garg@linaro.org>, u-boot@lists.denx.de,
 u-boot-amlogic@groups.io, 
 u-boot-custodians@lists.denx.de, robh+dt@kernel.org, 
 krzysztof.kozlowski+dt@linaro.org, conor@kernel.org, 
 neil.armstrong@linaro.org, caleb.connolly@linaro.org, ff@shokubai.tech, 
 daniel.thompson@linaro.org, dgilmore@fedoraproject.org, pbrobinson@gmail.com, 
 ilias.apalodimas@linaro.org, maxim.uvarov@linaro.org, b.galvani@gmail.com, 
 xypron.glpk@gmx.de, michal.simek@amd.com, seanga2@gmail.com, 
 rasmus.villemoes@prevas.dk, peng.fan@nxp.com, jh80.chung@samsung.com, 
 rfried.dev@gmail.com, marex@denx.de, mibodhi@gmail.com
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

Hi Tom, Sumit,

On Thu, Dec 28, 2023 at 2:03=E2=80=AFPM Tom Rini <trini@konsulko.com> wrote=
:
>
> On Thu, Dec 28, 2023 at 01:37:26PM +0000, Simon Glass wrote:
> > Hi Sumit,
> >
> > On Thu, Dec 28, 2023 at 11:58=E2=80=AFAM Sumit Garg <sumit.garg@linaro.=
org> wrote:
> > >
> > > Allow platform owners to mirror devicetree files from devitree-rebasi=
ng
> > > directory into dts/arch/$(ARCH) (special case for dts/arch/arm64). Th=
en
> > > build then along with any *-u-boot.dtsi file present in arch/$(ARCH)/=
dts
> > > directory. Also add a new Makefile for arm64.
> > >
> > > This will help easy migration for platforms which currently are compl=
iant
> > > with upstream Linux kernel devicetree files.
> > >
> > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > > ---
> > >
> > > Changes in v3:
> > > --------------
> > > - Minor commit message update
> > >
> > > Changes in v2:
> > > --------------
> > > - s/DEVICE_TREE_LOC/dt_dir/ and s/U-boot/U-Boot/
> > >
> > >  dts/Kconfig             | 11 +++++++++++
> > >  dts/Makefile            | 17 ++++++++++++++---
> > >  dts/arch/arm64/Makefile | 14 ++++++++++++++
> > >  3 files changed, 39 insertions(+), 3 deletions(-)
> > >  create mode 100644 dts/arch/arm64/Makefile
> > >
> > > diff --git a/dts/Kconfig b/dts/Kconfig
> > > index 00c0aeff893..e58c1c6f2ab 100644
> > > --- a/dts/Kconfig
> > > +++ b/dts/Kconfig
> > > @@ -85,6 +85,17 @@ config OF_LIVE
> > >           enables a live tree which is available after relocation,
> > >           and can be adjusted as needed.
> > >
> > > +config OF_UPSTREAM
> > > +       bool "Enable use of devicetree imported from Linux kernel rel=
ease"
> > > +       help
> > > +         Traditionally, U-Boot platforms used to have their custom d=
evicetree
> > > +         files or copy devicetree files from Linux kernel which are =
hard to
> > > +         maintain and can usually get out-of-sync from Linux kernel.=
 This
> > > +         option enables platforms to migrate to devicetree-rebasing =
repo where
> > > +         a regular sync will be maintained every major Linux kernel =
release
> > > +         cycle. However, platforms can still have some custom u-boot=
 specific
> > > +         bits maintained as part of *-u-boot.dtsi files.
> >
> > My only other suggestion here is to mention that this should be set in
> > Kconfig, for the SoC as a whole. So I believe that means that it
> > should be hidden, with no string for the 'bool':
> >
> >       bool  # Enable use of devicetree imported from Linux kernel relea=
se
>
> I think we can just keep prompting for it now, to make the transition
> easier, before this option just goes away in time, hopefully.
>
> > Also, this doesn't seem to work for me. Before this series I get these
> > files when building firefly-rk3399:
> >
> > rk3399-eaidk-610.dtb            rk3399-khadas-edge-v.dtb
> > rk3399-orangepi.dtb        rk3399-rock-pi-4a.dtb
> > rk3399-evb.dtb                  rk3399-leez-p710.dtb
> > rk3399-pinebook-pro.dtb    rk3399-rock-pi-4c.dtb
> > rk3399-ficus.dtb                rk3399-nanopc-t4.dtb
> > rk3399-pinephone-pro.dtb   rk3399-rockpro64.dtb
> > rk3399-firefly.dtb              rk3399-nanopi-m4-2gb.dtb
> > rk3399pro-rock-pi-n10.dtb  rk3399-roc-pc.dtb
> > rk3399-gru-bob.dtb              rk3399-nanopi-m4b.dtb
> > rk3399-puma-haikou.dtb     rk3399-roc-pc-mezzanine.dtb
> > rk3399-gru-kevin.dtb            rk3399-nanopi-m4.dtb
> > rk3399-rock-4c-plus.dtb
> > rk3399-khadas-edge-captain.dtb  rk3399-nanopi-neo4.dtb    rk3399-rock-4=
se.dtb
> > rk3399-khadas-edge.dtb          rk3399-nanopi-r4s.dtb     rk3399-rock96=
0.dtb
> >
> > Afterwards I get this:
> >
> > make[3]: *** No rule to make target
> > 'dts/arch/arm64/rk3399-firefly.dtb', needed by 'dtbs'.  Stop.
> >
> > So I set this manually for that one board:
> >
> > CONFIG_DEFAULT_DEVICE_TREE=3D"rockchip/rk3399-firefly"
> >
> > and get:
> >
> > make[3]: *** No rule to make target
> > 'dts/arch/arm64/rockchip/rk3399-firefly.dtb', needed by 'dtbs'.  Stop.
> >
> > I am not sure how to fix this, nor how this can be made to build all
> > the DTs for rk3399, as it does today.
>
> Looking at the patch for amlogic boards, you need to make the link to
> devicetree-rebasing inside dts/...

OK, let me give up on rk3399 for now...that doesn't seem to work even
with the link.

Using odroid-c2 with -next I see:

$ ls /tmp/b/odroid-c2/arch/arm/dts/
meson-a1-ad401.dtb                 meson-g12b-odroid-n2l.dtb
    meson-gxl-s905x-libretech-cc.dtb
meson-axg-jethome-jethub-j100.dtb  meson-g12b-odroid-n2-plus.dtb
    meson-gxl-s905x-libretech-cc-v2.dtb
meson-axg-s400.dtb                 meson-g12b-radxa-zero2.dtb
    meson-gxl-s905x-p212.dtb
meson-g12a-radxa-zero.dtb          meson-gxbb-kii-pro.dtb
    meson-gxm-gt1-ultimate.dtb
meson-g12a-sei510.dtb              meson-gxbb-nanopi-k2.dtb
    meson-gxm-khadas-vim2.dtb
meson-g12a-u200.dtb                meson-gxbb-odroidc2.dtb
    meson-gxm-s912-libretech-pc.dtb
meson-g12b-a311d-bananapi-m2s.dtb  meson-gxbb-p200.dtb
    meson-gxm-wetek-core2.dtb
meson-g12b-a311d-khadas-vim3.dtb   meson-gxbb-p201.dtb
    meson-sm1-bananapi-m2-pro.dtb
meson-g12b-bananapi-cm4-cm4io.dtb  meson-gxbb-wetek-hub.dtb
    meson-sm1-bananapi-m5.dtb
meson-g12b-gsking-x.dtb            meson-gxbb-wetek-play2.dtb
    meson-sm1-khadas-vim3l.dtb
meson-g12b-gtking.dtb              meson-gxl-s805x-libretech-ac.dtb
    meson-sm1-odroid-c4.dtb
meson-g12b-gtking-pro.dtb          meson-gxl-s905d-libretech-pc.dtb
    meson-sm1-odroid-hc4.dtb
meson-g12b-odroid-go-ultra.dtb
meson-gxl-s905w-jethome-jethub-j80.dtb  meson-sm1-sei610.dtb
meson-g12b-odroid-n2.dtb           meson-gxl-s905x-khadas-vim.dtb
$
With this series (sort of, since I am really not sure how to
cherry-pick the commits from the PR) I see nothing:

$ ls /tmp/b/odroid-c2/arch/arm/dts/
$

This shows some of the files:

$ find /tmp/b/odroid-c2/ -name "*.dtb"
/tmp/b/odroid-c2/dts/dt.dtb
/tmp/b/odroid-c2/dts/arch/arm64/amlogic/meson-gxbb-odroidc2.dtb
/tmp/b/odroid-c2/dts/arch/arm64/amlogic/meson-gxbb-nanopi-k2.dtb
/tmp/b/odroid-c2/dts/arch/arm64/amlogic/meson-gxbb-wetek-play2.dtb
/tmp/b/odroid-c2/dts/arch/arm64/amlogic/meson-gxbb-kii-pro.dtb
/tmp/b/odroid-c2/dts/arch/arm64/amlogic/meson-gxbb-p200.dtb
/tmp/b/odroid-c2/dts/arch/arm64/amlogic/meson-gxbb-p201.dtb
/tmp/b/odroid-c2/dts/arch/arm64/amlogic/meson-gxbb-wetek-hub.dtb
/tmp/b/odroid-c2/u-boot.dtb

but where are the rest? Also, is it possible to put the output .dtb
files into the same directory? Otherwise we may have some pain with
binman.

[..]

Regards,
Simon
