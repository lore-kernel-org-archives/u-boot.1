Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67D4AFCD0DA
	for <u-boot@archiver.kernel.org>; Wed, 18 Mar 2026 08:59:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E421C84090;
	Wed, 18 Mar 2026 09:59:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="3ZKmgWMb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4E5F840AB; Wed, 18 Mar 2026 09:59:18 +0100 (CET)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EF5F983FDC
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 09:59:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jstephan@baylibre.com
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-660a293515fso12632097a12.1
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 01:59:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773824355; cv=none;
 d=google.com; s=arc-20240605;
 b=AYper5I87fpDSv8909XeNXPNDzoVDkI/X6gxEGZN89gfE0LCcBsvvyj8O4u5HoS5co
 TTWQXPh9ocVYjO1kEERYo6gKRFBTALcyRuU2s3B+36MnZRP5utNgj0Z1hXbCwH+HX5Ue
 t9Z/1mqg14xdoPlyBe8gNX7Uyiq3VpDq8U5T11HAzB/F4E0ogEDFhY8487qAQmwQ518z
 FxHsarJOke3eZaXv9YwndypUV6xYtDbs3XFpjOtm0idNXazV192lt7Y1njV/RkMBO2Wg
 bgCKHvble08N/pbWQfacYPuNDs78qm6y5RB7ejAwY0M688aPmVMKmmaS7c8Q4hi77pjm
 DPwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=y38RjA/Nw3SozUqtnp9y5s3Extt8dkrLSM+qR9/1nw8=;
 fh=5HYY23vYipIMF7hOGNxafhnbmK/+rcN0f4EY0x2BRcw=;
 b=ZyDWkDqnxALt+zrorSdYW/ElN2XPwAAB4WeJ+Unj5tHpSloqC0NAMPbzzt6N1slGa+
 X/XaEvDB68YbtkAbTbBTBi2KFutfnW+Unm0Eh9ZuZXcJS9I90usKGIwU6a+lb9CCcnmI
 j05aC6kZXpljs5q2kamo8EbF4N6/WuLKQTyc0nAbZzPhI3kHciblWZOPPjD0kDSpBYaJ
 WVqsN47zsZ3ezZ8A2Uub4ixIuw9Y4g080qKUApLgSAhHxjtcLq/4R+uEdXnu6Huj2ZDu
 QX0kNwlcglMuFQiZk01/TtY/jXdIz6RazeP2w8jsKodFXuBIr8pWPEzNeOP7c7oR5s0z
 7FKA==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1773824355; x=1774429155;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y38RjA/Nw3SozUqtnp9y5s3Extt8dkrLSM+qR9/1nw8=;
 b=3ZKmgWMbF5BQLd9E3dAt6ZKxuoMSIeau2pdD7DR0EzJYHkfu2WnuxOsKNO9zWlChrn
 tv95YryDxmG9vQyISnueosiIQ9VSjuvEoyrYkB9Sqjat7UHgWYZEj1nmhCx0z44aKvYx
 N+qa3lUL2dmHHEtjWrhYHaVZVV12/wFyG2yh82zPM/pwYXEsamQ2fOK2Va6WW7wJEBiL
 jBqqzlgUCUVUedXn1wY0G/nnU80v0NbYW0rhxWjzN64xPTFHm70n9ysCazDu98fJuRfy
 Mv+B3OH9KmmZU36XEpXDm+ancfHCoo+k5fMvU6XcDbMpOtDBu+QDrv7Y1TYwpHcGKGHR
 2yqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773824355; x=1774429155;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=y38RjA/Nw3SozUqtnp9y5s3Extt8dkrLSM+qR9/1nw8=;
 b=mcSm1E2WYxailvh2HeL6igNmW37qHRYRMrOC4aQvlgc+1f6qIZsb/4q3BguxTQeonC
 tvziyM3VBJ1sWHE4g6DZ5euroj0Kphlx9kjFyvI1dyvreotuJv/te9MO4QIKtkLWcT8A
 iEfID3zlt29Kq3m23mgOa005BrsdLxmyXpGfK5cgllOw3ont24PgZP3KSG5KDralQkQ8
 yJwZeovBeQ8CmT6QWArjA979Z4/aLBFPhPnxUV0TUVIAiHOQ6GxunTcgIbpMb429OZiA
 pDp6r0t2LSMFQtcHJYKL+uglA4DU5P8tQlOYwIwR1TiZNU9uwVHuajBIzIf7uiqs/HN9
 BCSw==
X-Gm-Message-State: AOJu0Yx1XKFx9tWVl7wox/5sb41KnAti0dRf9LowtVNHTDxor8xNVUyQ
 Na5MVyiYmNqub4OzNKFmyuRuf5olEqdma4Od/Ne6Bu5cQXjWscRl67glTwILE/aevEnTrFblilT
 G28YZSwu//UfIAyqF0ImKtS/wa7Oo6JAiWmP+2VWZTw==
X-Gm-Gg: ATEYQzznLn95mKvWfaBUCRKBQYXxwx63ghrLJVTOvk7PSjmJzvloqEfHZGaMhZ27cpD
 jXo+2PS+z1idrRSOx/MHmbpLleUPL9Po/5yWOXVlrIIlIMVTKsWwLTDPowo1OPhx9cOx0BGbtui
 xlYuGWa47F+ccPxQkCreXsynPXh0PiVDjtjNghzbO0on7aheJmmpp2byyGab5mBfXB/HLAIMbYm
 YU7AmiwB0D9EvtqnAktExIDwB93b/8fiWFAj6breUxLALkbnFJCmUfA9qyHmXqYZ6hXB+JVV0Uj
 37CjFsGt+aEILFKzRNm4AR+bLZFb4QXt6OkCpEUBxY+l+gyDqfOBPoMH1tO94fb1v6lT3FfVRte
 rYmWkQcJEJXO+rm5aSgSk/okNAw==
X-Received: by 2002:a17:907:3fa2:b0:b8e:64e:1ed with SMTP id
 a640c23a62f3a-b97f4a162a0mr157493166b.50.1773824355245; Wed, 18 Mar 2026
 01:59:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260317-mt8195-add-ufs-support-v1-0-7d731ec438ae@baylibre.com>
 <20260317-mt8195-add-ufs-support-v1-11-7d731ec438ae@baylibre.com>
 <2a4f651d-bdb4-4c3b-be58-e2b882556e7f@baylibre.com>
In-Reply-To: <2a4f651d-bdb4-4c3b-be58-e2b882556e7f@baylibre.com>
From: Julien Stephan <jstephan@baylibre.com>
Date: Wed, 18 Mar 2026 09:59:06 +0100
X-Gm-Features: AaiRm51ilHKcSnuXLh1jEOv_ddk1Kb4HdC6VOsUr0uv0ggPTeNxqTaFkaB8YmGY
Message-ID: <CAEHHSvZrTL7Lc+cuLeb1+WLzkGX6M375kD--zO7QTv7icB15GA@mail.gmail.com>
Subject: Re: [PATCH 11/11] configs: add new defconfig for mt8395_evk_ufs
To: David Lechner <dlechner@baylibre.com>
Cc: u-boot@lists.denx.de, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Ryder Lee <ryder.lee@mediatek.com>, 
 Weijie Gao <weijie.gao@mediatek.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>,
 Tom Rini <trini@konsulko.com>, 
 Macpaul Lin <macpaul.lin@mediatek.com>, Julien Masson <jmasson@baylibre.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>,
 Bhupesh Sharma <bhupesh.linux@gmail.com>, 
 Neha Malcom Francis <n-francis@ti.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Chris-QJ Chen <chris-qj.chen@mediatek.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>
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

Le mar. 17 mars 2026 =C3=A0 23:03, David Lechner <dlechner@baylibre.com> a =
=C3=A9crit :
>
> On 3/17/26 9:24 AM, Julien Stephan wrote:
> > This new defconfig is based on mt8395_evk, where we remove the mmc
>
> We will still want MMC enabled here for the SD card slot. The
> target OS could be on an SD card even when booting from UFS.
>
fair enough

> > configs and add all the ufs related ones.
> >
> > Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> > ---
> >  board/mediatek/MAINTAINERS       |  3 ++-
> >  configs/mt8395_evk_ufs_defconfig | 33 ++++++++++++++++++++++++++++++++=
+
> >  2 files changed, 35 insertions(+), 1 deletion(-)
> >
> > diff --git a/board/mediatek/MAINTAINERS b/board/mediatek/MAINTAINERS
> > index 4f371592059..dba620e57d5 100644
> > --- a/board/mediatek/MAINTAINERS
> > +++ b/board/mediatek/MAINTAINERS
> > @@ -21,7 +21,8 @@ M:  Macpaul Lin <Macpaul.Lin@mediatek.com>
> >  S:   Maintained
> >  F:   configs/mt8390_evk_defconfig
> >
> > -MT8395 EVK
> > +MT8395 EVK (UFS)
>
> I think saying "(UFS)" here is a bit confusing. It is still the same
> board (just different dip switch setting). I would not change this line.
>
> >  M:   Macpaul Lin <Macpaul.Lin@mediatek.com>
> >  S:   Maintained
> >  F:   configs/mt8395_evk_defconfig
> > +F:   configs/mt8395_evk_ufs_defconfig
> > diff --git a/configs/mt8395_evk_ufs_defconfig b/configs/mt8395_evk_ufs_=
defconfig
> > new file mode 100644
> > index 00000000000..9a9de689953
> > --- /dev/null
> > +++ b/configs/mt8395_evk_ufs_defconfig
> > @@ -0,0 +1,33 @@
> > +CONFIG_ARM=3Dy
> > +CONFIG_COUNTER_FREQUENCY=3D13000000
> > +CONFIG_POSITION_INDEPENDENT=3Dy
> > +CONFIG_ARCH_MEDIATEK=3Dy
> > +CONFIG_TEXT_BASE=3D0x4c000000
> > +CONFIG_NR_DRAM_BANKS=3D1
> > +CONFIG_DEFAULT_DEVICE_TREE=3D"mediatek/mt8395-genio-1200-evk-ufs"
> > +CONFIG_TARGET_MT8195=3Dy
> > +CONFIG_SYS_LOAD_ADDR=3D0x60000000
> > +CONFIG_IDENT_STRING=3D" mt8395-evk"
> > +# CONFIG_BOARD_INIT is not set
> > +CONFIG_CMD_CLK=3Dy
> > +CONFIG_CMD_GPT=3Dy
> > +CONFIG_CMD_PART=3Dy
> > +CONFIG_CMD_UFS=3Dy
> > +CONFIG_OF_UPSTREAM=3Dy
> > +CONFIG_CLK=3Dy
> > +CONFIG_PHY=3Dy
> > +CONFIG_PINCTRL=3Dy
> > +CONFIG_PINCONF=3Dy
> > +CONFIG_PINCTRL_MT8195=3Dy
> > +CONFIG_DM_PMIC=3Dy
> > +CONFIG_DM_PMIC_MTK_PWRAP=3Dy
> > +CONFIG_DM_REGULATOR=3Dy
> > +CONFIG_DM_REGULATOR_MT6359=3Dy
> > +CONFIG_SCSI=3Dy
> > +CONFIG_BAUDRATE=3D921600
> > +CONFIG_DM_SERIAL=3Dy
> > +CONFIG_MTK_SERIAL=3Dy
> > +CONFIG_UFS=3Dy
> > +CONFIG_UFS_MEDIATEK=3Dy
> > +CONFIG_WDT=3Dy
> > +CONFIG_WDT_MTK=3Dy
> >
>
> Can we make a .config file and #include it here so that we aren't
> duplicating so much of mt8395_evk_defconfig?
>
Sure!
