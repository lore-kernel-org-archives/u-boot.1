Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C4CBCDB479
	for <u-boot@archiver.kernel.org>; Wed, 24 Jun 2026 04:49:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B6CA5849D8;
	Wed, 24 Jun 2026 06:48:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="Vsw1rh1Z";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8DEF884671; Wed, 24 Jun 2026 04:23:50 +0200 (CEST)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05E68801A9
 for <u-boot@lists.denx.de>; Wed, 24 Jun 2026 04:23:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eric.chung@riscstar.com
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-5aa68d65d24so563689e87.1
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 19:23:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782267827; cv=none;
 d=google.com; s=arc-20240605;
 b=S6xhUPpi213TO+Tn4sUBg6+hU+5MyPDzMp9KdNcoTgTY7eZpS6Q9TLqBFU3YKLDO7P
 Wvi4yHbswHyKjKPyIj0Tb5AVMR3tRdt5S+Z1AyhbmresEns124n089fo+OLGDjtHUTaG
 mySf2Bi/TBW4jWP6qlTe8Bgvcxm0tr5OXpDvMPubITWL42Ys/dt37XHNIZ7mikvEukyJ
 t7OP96r7LFOeeNvw7x6gAV/J5EpGowsA0NcuxPuH/zMOhLm7elX7m6BtlOq8PBUp8deg
 EmJWSjE3bj1nCiVer5YPLEBdbhloSj/bEdTOC9HwBzppK6OISAkydJxHYiyYcfNFjktM
 DITg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=1+zedM2Yy4Gsh+XT6XgD7OqG0P2jb8d/djoZZCSoqtc=;
 fh=Ip4Pag46s69nQxd6XwoHWVoZlQWD0I1TCYF1Z6pyNfY=;
 b=ZZFwWvcK59fUkZzRhZveVPsUAslaCKfwCc7Nj9QL2VZLBRgxkckfXxUHi/aqErlXxh
 Cu9NxyMTi1HOIt2GCrJMAETLM0RRj4MYodDOYWj0IP0DOLzoQkr4/sQYTWVF9V7s6X04
 XKiVfPvZrTLdrhQdEDIAHcQoKOV620iQdhK1qNlqTVtGDHU/mg0vflY9Ied+87/Smje6
 xBTpocfzEiFNVqPa4VVQVvZKz96irlhkqSIDgjhQWtLHDU6AYIc4eNjxPQJGJwct55He
 gtHzDtW9ZFT6vn7qxaVlWMr54gdjK6usZNvDxrjjxDFLLMGM6OEJQSXfuYSjloCaWeoW
 dZRw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1782267827; x=1782872627;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1+zedM2Yy4Gsh+XT6XgD7OqG0P2jb8d/djoZZCSoqtc=;
 b=Vsw1rh1ZY3LuWMIiLi7CFKefXCILQTDYDi7kakyhX381XvZ0teRcmKCCYjYqJCKgU+
 Vr0Ca4zlF+j0ndK1KrWws9FPkzyFgbvlfUhtroCmTSGbc1Thb7TU8RSk7GT6MEFphofZ
 HoL3P+m0HtZQLGPGDrtxdEjg8FeB10ZQ/fGO+TezZprOnY5RWLSMNnQkiR+J2Xzb5gGF
 blMLcwd9QjMv/WhSsJgYr7R1Nm+9boKFbdRL0A40v8i1+c8w1nv/fZz7hvQ1+3WeV0Wt
 acqMLbhK5oMywTKGiqaKyHsNOZ//5SUJWPkEyUZSC48kT0qTIH/nc4ijSyrE9LgopcGS
 8y0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782267827; x=1782872627;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1+zedM2Yy4Gsh+XT6XgD7OqG0P2jb8d/djoZZCSoqtc=;
 b=K5RVQEcccdNmhIuAf2pEHUSEbgjD8hIBaaIu/npBeU7EYxaNnemj+V+vDtdiEhsmx/
 TxW+lr+IjCXIDGwoeKtvh55+83O7a7aZfOCCky9piXbN8jguEmoDe1gn/8DDl6Brn+iZ
 ArsW3OGkBAyjI8PdSkcUChhiwV04uXkaWJuPUgM6Nn7GyOg/MP2BrttqvB8KGJP3CkjE
 7zq6hKQ0in2zxQAYT2IE/6w6OJRmDak7rFmAZRCgjjv3Gm71TZrgsPx0J4YfNSznFpRA
 ahTAgm28FPAgRqLEFoFQXQF8mGDHtKzAWs2LMJYwY04KhF2VIueh5Cg29XB/wU8Ov5dp
 ySpw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/TqIKGCshtmKC5l8cOwEyAN2cSZKSjUUtKmGswfZnPRUhnr2t8ZwifPqKJ+2NbGpAtUxc2rCw=@lists.denx.de
X-Gm-Message-State: AOJu0YzD12CD2pYwkA5SPkfZhkDjsEaNHHMY5VtxRY0nm9hI2cyfja5X
 wIGu63YznbkHcvIapd6vJA9XSnj9YYYp4xG1xukusW+u0zY/6M+h4YFnSl1w97M6F/k0mJUk+i2
 Evq8I85yMZLhBv6MyEACc4PWLyNaxMbGxqixLAFbPNQ==
X-Gm-Gg: AfdE7ckb8dCWba1/vegq2a5//7l6v48FS1ZZWKJZ8eChmOVvw/b6uv/i0AP6nzob5eo
 Yjvc7w3GcwpMHUdx41cr0rEd0Y/n2vwHhiV3+DRL4eeksX9D0FQrKPJh3b0li0Ej6XvFTGP/kew
 w0MiJmztOKnhuwPBxluzZNbqujJZS9NFkps+kIleUUudHKQu4nPqNnOoD6DWQrY0ayw+2QMRHL8
 4S7Rkv2H1Fkr3WwSPOrkIs1f0c0Q826bwPcmbu1o4fMt2KCOQY6FFMPQfN2BI07rzMlbR6G5sJO
 WeBJaCGyz7JZd54GYgK5ja2jwivw4RYi09XiIyp3bedbMH6k54jq8p3LikzarBt2kLbSMyKywn5
 DblYRbfwt
X-Received: by 2002:a05:6512:66d6:10b0:5ad:57b9:8057 with SMTP id
 2adb3069b0e04-5ad5be70c2emr3738779e87.48.1782267827176; Tue, 23 Jun 2026
 19:23:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260612201901.73657-1-raymondmaoca@gmail.com>
 <20260612201901.73657-3-raymondmaoca@gmail.com> <aiz8E_EFaSj9q-Fl@pie>
In-Reply-To: <aiz8E_EFaSj9q-Fl@pie>
From: Eric Chung <eric.chung@riscstar.com>
Date: Wed, 24 Jun 2026 10:23:35 +0800
X-Gm-Features: AVVi8CeL_QBZPbvPMFoVijqPscgTNsrnO-i6CEGrW6kGaQxj5BZ9qdOky_dHL7c
Message-ID: <CAH22mJwsH9gPo6xTrX6G+9weAbaV2pk6XGqi=Xshng4XuaNvcg@mail.gmail.com>
Subject: Re: [PATCH 2/8] mmc: k1: add sdhci platform driver
To: Yao Zi <me@ziyao.cc>
Cc: Raymond Mao <raymondmaoca@gmail.com>, u-boot@lists.denx.de,
 uboot@riscstar.com, 
 u-boot-spacemit@groups.io, raymond.mao@riscstar.com, rick@andestech.com, 
 ycliang@andestech.com, trini@konsulko.com, lukma@denx.de, hs@nabladev.com, 
 jh80.chung@samsung.com, peng.fan@nxp.com, xypron.glpk@gmx.de, 
 randolph@andestech.com, dlan@gentoo.org, junhui.liu@pigmoral.tech, 
 neil.armstrong@linaro.org, quentin.schulz@cherry.de, samuel@sholland.org, 
 Guodong Xu <guodong@riscstar.com>, Scott Bambrough <scott@riscstar.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 24 Jun 2026 06:48:40 +0200
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

On Sat, Jun 13, 2026 at 2:44=E2=80=AFPM 'Yao Zi' via uboot <uboot@riscstar.=
com> wrote:
>
> On Fri, Jun 12, 2026 at 04:18:55PM -0400, Raymond Mao wrote:
> > From: Guodong Xu <guodong@riscstar.com>
> >
> > Add SDHCI platform driver support for SpacemiT K1 SoC. This driver
> > implements the necessary platform-specific operations for the SDHCI
> > controller, enabling MMC/SD card functionality on K1-based platforms.
>
> Is there any reason not to re-use Linux-side K1 MMC driver,
> sdhci-of-k1.c, and its companion ABI? Since Linux commit e9cb83c10071
> (mmc: sdhci-of-k1: add comprehensive SDR tuning support, 2026-05-11)
> it is now capable of operating on SD cards, too.
>
Excuse me. Is there any ABI breakage in this SD/eMMC device?

> > Signed-off-by: Guodong Xu <guodong@riscstar.com>
> > Signed-off-by: Raymond Mao <raymond.mao@riscstar.com>
> > ---
> >  drivers/mmc/Kconfig          |   7 +
> >  drivers/mmc/Makefile         |   1 +
> >  drivers/mmc/spacemit_sdhci.c | 934 +++++++++++++++++++++++++++++++++++
> >  3 files changed, 942 insertions(+)
> >  create mode 100644 drivers/mmc/spacemit_sdhci.c
>
> ...
>
> > diff --git a/drivers/mmc/spacemit_sdhci.c b/drivers/mmc/spacemit_sdhci.=
c
> > new file mode 100644
> > index 00000000000..392ca389fa9
> > --- /dev/null
> > +++ b/drivers/mmc/spacemit_sdhci.c
>
> ...
>
> > +static void spacemit_sdhci_set_aib_mmc1_io(struct sdhci_host *host, in=
t voltage)
> > +{
> > +     struct mmc *mmc =3D host->mmc;
> > +     struct spacemit_sdhci_plat *plat =3D dev_get_plat(mmc->dev);
> > +     void __iomem *aib_mmc1_io, *apbc_asfar, *apbc_assar;
> > +     u32 reg;
> > +
> > +     if (!plat->aib_mmc1_io_reg || !plat->apbc_asfar_reg ||
> > +         !plat->apbc_assar_reg)
> > +             return;
> > +
> > +     aib_mmc1_io =3D map_sysmem((uintptr_t)plat->aib_mmc1_io_reg,
> > +                              sizeof(u32));
> > +     apbc_asfar =3D map_sysmem((uintptr_t)plat->apbc_asfar_reg,
> > +                             sizeof(u32));
> > +     apbc_assar =3D map_sysmem((uintptr_t)plat->apbc_assar_reg,
> > +                             sizeof(u32));
>
> AFAIK aib_mmc1_io region is related to pinctrl settings, and shouldn't
> be handled by the MMC driver directly. Quoting my own reply[1] to the
> series adding SD support to sdhci-of-k1.c in Linux side,
>
OK. I'll move it to pinctrl.

> > Also, the pin controller on K1 SoC seems to have some undocumented
> > registers to select the IO voltage of SD pins, which should be
> > adjusted when switching IO voltage.
> >
> > I think these pins should be implemented in the pinctrl driver, then
> > you could create two pinctrl states, one for 1.8v operation, one for
> > 3.3v, and switch between them through pinctrl_lookup_state() when
> > changing IO voltage.
>
> This idea is later confirmed by SpacemiT guy's series[2],
>
> > On K1, IO domain power control registers determine whether a GPIO bank
> > operates at 1.8V or 3.3V. These registers default to 3.3V operation,
> > which may lead to functional failures when GPIO banks are externally
> > supplied with 1.8V but internally remain configured for 3.3V.
> >
> > The IO power domain registers are implemented as secure registers and
> > require an explicit unlock sequence via the AIB Secure Access Register
> > (ASAR), located in the APBC register space.
>
> Thus I think you should move the logic to pinctrl driver instead, like
> what has been done in the Linux upstream driver.
>
OK

> > +     writel(AKEY_ASFAR, apbc_asfar);
> > +     writel(AKEY_ASSAR, apbc_assar);
> > +     reg =3D readl(aib_mmc1_io);
> > +
> > +     switch (voltage) {
> > +     case MMC_SIGNAL_VOLTAGE_180:
> > +             reg |=3D MMC1_IO_V18EN;
> > +             break;
> > +     default:
> > +             reg &=3D ~MMC1_IO_V18EN;
> > +             break;
> > +     }
> > +     writel(AKEY_ASFAR, apbc_asfar);
> > +     writel(AKEY_ASSAR, apbc_assar);
> > +     writel(reg, aib_mmc1_io);
> > +}
>
> ...
>
> > +static void spacemit_sdhci_set_control_reg(struct sdhci_host *host)
> > +{
>
> ...
>
> > +     /* Set pinctrl state */
> > +     if (IS_ENABLED(CONFIG_PINCTRL)) {
> > +             if (mmc->clock >=3D 200000000)
> > +                     pinctrl_select_state(mmc->dev, "fast");
> > +             else
> > +                     pinctrl_select_state(mmc->dev, "default");
> > +     }
>
> This doesn't match Linux side ABI, where when card operates in UHS mode,
> pinctrl state "uhs" is selected.
>
OK. Switch to "uhs". By the way, the upstream DTS file hasn't been
synced into uboot yet. This is not easy to find.

> Regards,
> Yao Zi
>
> [1]: https://lore.kernel.org/linux-riscv/aUDwDkd8k_4gD1yc@pie/
> [2]: https://lore.kernel.org/linux-riscv/20260108-kx-pinctrl-aib-io-pwr-d=
omain-v2-0-6bcb46146e53@linux.spacemit.com
