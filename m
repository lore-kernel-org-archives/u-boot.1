Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E847CDB47F
	for <u-boot@archiver.kernel.org>; Wed, 24 Jun 2026 07:35:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ACC568460E;
	Wed, 24 Jun 2026 09:35:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=riscstar-com.20251104.gappssmtp.com header.i=@riscstar-com.20251104.gappssmtp.com header.b="EMF3dzCQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B8B284671; Wed, 24 Jun 2026 09:35:05 +0200 (CEST)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6DBD880287
 for <u-boot@lists.denx.de>; Wed, 24 Jun 2026 09:35:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=riscstar.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=eric.chung@riscstar.com
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-5ad53c8d4dfso813337e87.1
 for <u-boot@lists.denx.de>; Wed, 24 Jun 2026 00:35:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782286501; cv=none;
 d=google.com; s=arc-20240605;
 b=lEQwHlCPvf1fvFUAw3oRG83xhnkrsXj216EucJaHKeE5l81L4OsR5kL/hJtQGV+A2F
 yzl7mV190ZMKNLwLQowUKvfh30ZovmpbHuYvyYklaJCj/csFVfiwp24nxGMK5vijJsUh
 SXhWlxrnHxPzFMtrvtu227vsYv96HAnEW4BBEx23gJ6+ekdPH0umjA6sc4tfCkFLUbyc
 1fChcI5jEH1+q9cUi/E3zifMWeSwlRAnpINkq2D99UIt0Nzt3xxJ/LqsebM2Q/R77uOS
 E+uR2qmJzCCJ8VIL06h4oi3M30NZtO1ZLjezD5jy1wgm/bsJUf7gLALFmKXBu/UW46mS
 6XxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=3N3uYG7nQwf2KO3DSs1QFZmCLxRdwEloOmYtrF77GmI=;
 fh=ZaJr1b5w+RYALWcTbYsAJyeoMZdkKB4d9gt7dTB7Tts=;
 b=eGCcEmJzzV7MAI2izef64LLYgJaS0vebZEurX/vYRwzyQjdUce7h7bOQGYIaLR73O1
 gcSdNxTNfOV1swo7q2J9LdxxIid6Sg7JkLuZALnyJcn4TKwn/in6Voj9QxR55RLS1aUz
 7U7L5z4OsmrX2hnyPDIkz9GQ77+hvfW5Th18POewyG2OO6Rh9qr6NMGP3uw3X4QG1R7V
 abpCp0MJt8UtN58xO64qzcEFSq6ZIgt+ccQdrNvDekIOq5aAxEx8izBUFwGJokPkF6Vu
 y2C7kZGjQ9eGz9ej3v4yQi6zTXLnSzo8Qeuv7TkvhwVGGlpkPonE2iBi9juQKsTJDNXu
 YmUw==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1782286501; x=1782891301;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3N3uYG7nQwf2KO3DSs1QFZmCLxRdwEloOmYtrF77GmI=;
 b=EMF3dzCQkPs7//UP4BMBiErNhjkhhHEdbHQkf+P6pVk8XOXFZ3DpJzgd+ch39pqepG
 Bdd6CRCzD5y6I6FwVuRwV7r/QG0NupcltF9QDQeCRb7f9TGY833r63uJSyUR9lygPkjT
 hRWn5rYdzic+9iweWIPgYF5DQXIowmeram00qIn/haCw7CJFmqM4IR83/SypECpTMEv0
 oEOAXx+hfIFtgvn7aVi8ktnJFRCJFfyHr6f28QQxVIWUrhQ5appKGc040sAhsUiWaV7v
 acLmI/GduGOh59GZzfGgljnwp6RxmlqqFFChLxYmLER4DpgXpCIeXAw/AI6iDYgT5PyR
 4fMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782286501; x=1782891301;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3N3uYG7nQwf2KO3DSs1QFZmCLxRdwEloOmYtrF77GmI=;
 b=if8TQEMgYczSvVuZ94Iw6aVobT1CSMV/nwJoR/k3mrbm1xn/xu31m8Z8Rbve9fl6HU
 59/K22hn+9rePUZYZcvoiWIeGhwXyR3B9Ix6ZxU+f8BF0Dz3KxdYyN8OgpjMkoLp3UOF
 aGMEQ+c/Yahkr2HEKqO8dbrHBtrQt8rn0J4RG8WW6pP5ICO/8pvvkNcPFDsgBhZicfnH
 OWvOF12zPbxMQXM/h9DTGsN9p1W9AaYkc3jXYHDmv+fwcBR9E5dBe6tWwh20mhcTUPmJ
 0YzsN0wO+GV6YA54lY3u8wTnMEpdURWcJdQ1svOX2WsUX+tQhcdxq0QZJ4CVdGhyvlcV
 7GFg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8ubB3rbI3MSgdZnwC5m78fFRW/lUeh+mmauNZ2BewR3iin7HL9X0YgF1GE85RXy2j06bLvl/4=@lists.denx.de
X-Gm-Message-State: AOJu0YzL7GtkLjnLS8Xd6XcQSkBc4hzuggRfDuZkwTa4Po0W+BNEFwE6
 Ah7L6J8k4gr9uwlzHlXdQldWowPjxyJ2qyeChNNdpSHunQkezv6EkiyqEbbFWbxZaCR9vZWnNiz
 CnttSTXSW/ro1Es3PIT8LM+XExXzzcihCoELCaz1UNg==
X-Gm-Gg: AfdE7ckd2BcUuXEo0EiyJmPKYmo5vlXvwmsLalSNfJAPUffIOtHWyyoDOWVbyZ2arSF
 3PR00fX2YlbepZ9/0MJ077HpQED6Ntd6Xce9+E+PNm8LiqkpodtE22ILWV3ywNMx1SkgWwoRrU8
 JdUjX6BbrkDMP0AOGnUNSknVby1FiHk/D9DgRcYuWpJEYXT2hFLBq/e4IOV3/5PxiBlT53MnuLz
 Uv6SWBSjh+6y25fQ4VWRzwUrOjzM3BXiXhHSb2OpVFlhYD4pOkcETbcnfTlDRv1SlvAHn7QpxN/
 p9gJs6iI+2icxqFc28XUNXEHgt9ZSn654aRxxU2+NRjCo7T1BS7ibFPGsHnwM7UZyql+OcxGPA=
 =
X-Received: by 2002:ac2:4c4b:0:b0:5aa:4a98:bdb0 with SMTP id
 2adb3069b0e04-5ad695820dbmr1883724e87.4.1782286501221; Wed, 24 Jun 2026
 00:35:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260612201901.73657-1-raymondmaoca@gmail.com>
 <20260612201901.73657-3-raymondmaoca@gmail.com> <aiz8E_EFaSj9q-Fl@pie>
 <CAH22mJwsH9gPo6xTrX6G+9weAbaV2pk6XGqi=Xshng4XuaNvcg@mail.gmail.com>
 <ajthOhWTPVMIyMfH@pie>
In-Reply-To: <ajthOhWTPVMIyMfH@pie>
From: Eric Chung <eric.chung@riscstar.com>
Date: Wed, 24 Jun 2026 15:34:48 +0800
X-Gm-Features: AVVi8CcTThTclZqdu7XDjdW5wqesyXgcGZNqiT9_QMqBerc-qfFFZx9b1wb-Rkk
Message-ID: <CAH22mJzRLNufQ1wA2n9NUY6CoZTt2tXLrN7Av=qL2+v6wqLRyQ@mail.gmail.com>
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

On Wed, Jun 24, 2026 at 12:47=E2=80=AFPM Yao Zi <me@ziyao.cc> wrote:
>
> On Wed, Jun 24, 2026 at 10:23:35AM +0800, Eric Chung wrote:
> > On Sat, Jun 13, 2026 at 2:44=E2=80=AFPM 'Yao Zi' via uboot <uboot@riscs=
tar.com> wrote:
> > >
> > > On Fri, Jun 12, 2026 at 04:18:55PM -0400, Raymond Mao wrote:
> > > > From: Guodong Xu <guodong@riscstar.com>
> > > >
> > > > Add SDHCI platform driver support for SpacemiT K1 SoC. This driver
> > > > implements the necessary platform-specific operations for the SDHCI
> > > > controller, enabling MMC/SD card functionality on K1-based platform=
s.
> > >
> > > Is there any reason not to re-use Linux-side K1 MMC driver,
> > > sdhci-of-k1.c, and its companion ABI? Since Linux commit e9cb83c10071
> > > (mmc: sdhci-of-k1: add comprehensive SDR tuning support, 2026-05-11)
> > > it is now capable of operating on SD cards, too.
> > >
> > Excuse me. Is there any ABI breakage in this SD/eMMC device?
>
> Yes, I only take a brief look, and at least the names for pinctrl states
> differ from Linux upstream, as mentioned below.
>
I can change the pinctrl state.

> So are there any reasons not to re-use it? This driver has been
> carefully reviewed in Linux side, has the expected ABI, which would
> reduce your work of upstreaming.
>
There is no tuning support in linux driver when I write the mmc driver in u=
boot.

> > > > Signed-off-by: Guodong Xu <guodong@riscstar.com>
> > > > Signed-off-by: Raymond Mao <raymond.mao@riscstar.com>
> > > > ---
> > > >  drivers/mmc/Kconfig          |   7 +
> > > >  drivers/mmc/Makefile         |   1 +
> > > >  drivers/mmc/spacemit_sdhci.c | 934 +++++++++++++++++++++++++++++++=
++++
> > > >  3 files changed, 942 insertions(+)
> > > >  create mode 100644 drivers/mmc/spacemit_sdhci.c
> > >
> > > ...
> > >
> > > > diff --git a/drivers/mmc/spacemit_sdhci.c b/drivers/mmc/spacemit_sd=
hci.c
> > > > new file mode 100644
> > > > index 00000000000..392ca389fa9
> > > > --- /dev/null
> > > > +++ b/drivers/mmc/spacemit_sdhci.c
>
> ...
>
> > > > +static void spacemit_sdhci_set_control_reg(struct sdhci_host *host=
)
> > > > +{
> > >
> > > ...
> > >
> > > > +     /* Set pinctrl state */
> > > > +     if (IS_ENABLED(CONFIG_PINCTRL)) {
> > > > +             if (mmc->clock >=3D 200000000)
> > > > +                     pinctrl_select_state(mmc->dev, "fast");
> > > > +             else
> > > > +                     pinctrl_select_state(mmc->dev, "default");
> > > > +     }
> > >
> > > This doesn't match Linux side ABI, where when card operates in UHS mo=
de,
> > > pinctrl state "uhs" is selected.
> > >
> > OK. Switch to "uhs". By the way, the upstream DTS file hasn't been
> > synced into uboot yet. This is not easy to find.
>
> I'm not sure what do you mean by "not easy to find". You could always
> refer to the dt-bindings maintained by Linux side for ABI description,
> and we want to keep aligned with it in U-Boot side as long as possible
> to reduce maintenance burden and improve interoperability.
>
> > > Regards,
> > > Yao Zi
> > >
> > > [1]: https://lore.kernel.org/linux-riscv/aUDwDkd8k_4gD1yc@pie/
> > > [2]: https://lore.kernel.org/linux-riscv/20260108-kx-pinctrl-aib-io-p=
wr-domain-v2-0-6bcb46146e53@linux.spacemit.com
>
> Regards,
> Yao Zi
