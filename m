Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4455AC5DF81
	for <u-boot@archiver.kernel.org>; Thu, 20 Aug 2026 12:45:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E159B60787;
	Thu, 20 Aug 2026 12:45:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HZfS97E3QFw1; Thu, 20 Aug 2026 12:45:21 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787229920;
	bh=FJoaz7duc8Us4hR/jBbdq2Ul/M4H6pQgzQxw1JXcrIY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NAHwsksCcyKx0eHzmApAgLPgrUnoqTHxCumsl4NLqVrcUN1ROBn2rdI49GNnxXs+Z
	 r2qU5TgQ/9Su7NCDX98x2YCUTpUVTPDprr04TFqOSF/ZH/8cieJJpiWfyrnZZ9wjUO
	 RDfEtY3PMMjYDpUrFG3MZVx4ni8KuTJnmoUKdyIGfC8ypwvl2HK8lGkYH7tvhGbNcv
	 dGnuggIwADfLQP0h2Fdi3fDst+Q/3Hpp0jRMF84xotHFpDRsUpTPFNATUolGeIP69V
	 L90HfDi4UJv89oa+s/oDfDFbFYM3C4QhPkypMlySRtapjqUcwgwOaDmEWKbjDWBwFq
	 tmqR2DP0/LKdQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CC6CA605D7;
	Thu, 20 Aug 2026 12:45:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 85A642FD
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 09:27:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6B9FA4058F
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 09:27:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZrsRSu1G15qm for <u-boot@lists.u-boot-project.org>;
 Thu, 20 Aug 2026 09:27:48 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::112b; helo=mail-yw1-x112b.google.com;
 envelope-from=ikerpedrosam@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=Oa6maa3l
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3F48A405B3
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 09:27:47 +0000 (UTC)
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-8201447e8cdso32841607b3.3
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 02:27:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787218067; cv=none;
 d=google.com; s=arc-20260327;
 b=rCf1R98E5fhmHt8ghjeMJRqTnU7yStF+vF/5+qpyu6rb4vGDdP12Lb/xFpWJCl4hvv
 kscjHs/+2UnynXWFb1qMK3U+fRJPUPeBSWCcyB/loPiWENxc5dCwGJFfWvMmJPrdFCtU
 bCJHIezHaJ36/Jl2G69Flb4mGsziuWFbLIXY34b48YwcXLASR1dxNzwJBB5XBXMnDtCl
 Q9b+R8IKjm5e9CatD3D28nJADqtdgBdOUZCH1oATS/UEIsGk/jMtFfhX11kf8EXH//pi
 w0mQc0YUQ0LweJwrA/abmQKdOb0AGkxrYzLoSOe6Bli7327mvy7GNqR+9HLg1IucxYJV
 rBwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=FJoaz7duc8Us4hR/jBbdq2Ul/M4H6pQgzQxw1JXcrIY=;
 fh=rhVbzTmvbcvKPXT01gDpBA51PksgnODEKLsAUNBuPOw=;
 b=S508JKse45NfFAUU3G+WmHEyBfROuyIiocPKbAhmp25pwZcLlZo30knucQqg82Kmbc
 s6OLuG5O3ITReNosGRyPhV61IQ1niqqDpC/TmKPDK8N8WIYdwoM+LnZHC2CEgoY1j7mj
 Lhe9wBZTzdmudM+ucjJUkrERd5fX0y42sHfaV9VjlbhP4rmna/hna+ZOcjcWOD9WiXpS
 6QRzR7j88KEKBjBaAw9BH5z2rvDE69FGL35B5Uhd8tM7X4jNCzXPsMqe2nN47Lw7kvyj
 nTqH6TS75wscQfxbUdNosbpIgbpTcWmINsr83WIuGQW5c1PH9hYHH3MVyixe5t+PoP8l
 7RSg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787218067; x=1787822867;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FJoaz7duc8Us4hR/jBbdq2Ul/M4H6pQgzQxw1JXcrIY=;
 b=Oa6maa3lPuym8L39/9CF+CWqw7BkIoAxsoR+KWXMv/pywixXqG6B2Lv2i9GIZe16It
 UpJUZsRPZOjLMPgWuUQuioOE5x8YckmOe7gkzfXRtOPs7ZYFy8K8HT5KCSJESpQWYZ60
 IOI1FHJYtJ4P4qg+9818wRX8g17drMN2LJk9wFXyn2CXo5bkEot7AzxyXYP/F2A74TcP
 Zu2RH/PhfNIWGn5/8eSyQKZbpOr8rlGY4KfKq5z9irJjiDjHFA+1GVNPExGLeAxi5SZf
 qiZjNQBxPr31C7RPuIneQeUjeOWJqskH5Lf5lN+dGDuC2svyx2kdsSThGma78dydLP7j
 DtoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787218067; x=1787822867;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FJoaz7duc8Us4hR/jBbdq2Ul/M4H6pQgzQxw1JXcrIY=;
 b=m/t0Ye35FG+qJNv1f9ytPQ376WRlmqaaDBbdSdi3lZ9ZG8nEyKCxm72ydRM4CUFEmd
 LZaciDCR+jlYHk2hWB1BhXRpoupnPI/rn2jgMwGNCM811R4iVLCYpQvExHA2Auna5OD1
 ae8UMfL5QQQAw41dYg0ASs5l+nmyPvZNMzYGxSWyBf0d4+u39N5hckAd4vU2pDYhXVt7
 n1ltlV1MlMjy6+Rud8HRg2zM9TgBFqJPrRO8k1ljdxAjmQGo5pdmyUBKyPNFa+yrdDdO
 JHfOchyQoAuq3H8bcjr4qdPDwSmAzrxUbwdQ5YNP09sUiEiAgkV9E4S4t/5QMRSq5Tzd
 S/Hw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrjMu1tQWCswyE8Y9ICH+83dMtSO2E8H2qQhQONAmyXfNLReWgH/Doi10QhTyzQ8VhXfSkkAzk=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++m4Rce4za29ewitjn50TyaiZQNcHGE84kx+l3438hh0yvF/pDea
 DKPrP6i7Ooh0AL1ud+7h9Q4OD8XYmwH52eev1/RdYvVeosirXP/wu+bSTTPS0ofEuYXqqkSPnTV
 e5Eg89PRCxCttel8RRNIgI8eX4TeaGkM=
X-Gm-Gg: AR+sD10phruUM4/mr4KbrpFMNjau5yzb7w3VdU/vn4HJiZnqNx6IR7k7qf7sFV3q73x
 IeCREkrcykcWnktns+ZcHTJzJai9Udg9JPfmNW5guiNxtsHRGfWeg8vXSuYuSi8qyhGIg+TuF8O
 HdmGzG+H5sFccY+lSdGwb4oyGNELbdEcnH/jmUtR9yLr4gvwFlkFWn9/K9WfX8Hoce2Ez1ckHHd
 ldWPY/cbrusdJovDp2dAMfPfolhd/fydUw/ThmGBX5F8nIQ6rFOrAsiyVzUnBbsB3l8pGsZKSMC
 h2AhVsixF2pNa6bnuWW+CW423pmuDh83Ae36Iiturslo
X-Received: by 2002:a05:690c:7305:b0:809:6b62:2f7a with SMTP id
 00721157ae682-844e139c6dcmr48048787b3.21.1787218066735; Thu, 20 Aug 2026
 02:27:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260819-m4-v9-0-6e66016392b9@riscstar.com>
 <CABdCQ=PpZhm4SWnOqE+wrf86eGT3iZSYSxUous-DB=0DFcb0mw@mail.gmail.com>
 <CAH22mJy_eq1hy0mPHh3SYZfSmVynmG0+oBsHZ_GDOGSxkgDTLQ@mail.gmail.com>
In-Reply-To: <CAH22mJy_eq1hy0mPHh3SYZfSmVynmG0+oBsHZ_GDOGSxkgDTLQ@mail.gmail.com>
From: Iker Pedrosa <ikerpedrosam@gmail.com>
Date: Thu, 20 Aug 2026 11:27:33 +0200
X-Gm-Features: AcwNN1Vh-bss1CnnvqCW4vRJ3nQ_hfYQwyZ5asQ3e8cL3mXwhh4VCUvEbdhZFuo
Message-ID: <CABdCQ=O4adRiLLbjMiY6XBfFN-0mQWMjmV7OSmTkx2Ag2Dnvbw@mail.gmail.com>
Subject: Re: [PATCH v9 00/19] spacemit mmc driver
To: Eric Chung <eric.chung@riscstar.com>
Cc: u-boot-spacemit@groups.io, u-boot@lists.u-boot-project.org, 
 Tom Rini <trini@konsulko.com>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, Peng Fan <peng.fan@nxp.com>, 
 Huan Zhou <pericycle.cc@gmail.com>, Raymond Mao <raymond.mao@riscstar.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>, 
 Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Kaustabh Chakraborty <kauschluss@disroot.org>, 
 Han Xu <han.xu@nxp.com>, Yanir Levin <yanir.levin@tandemg.com>, 
 Christoph Stoidner <c.stoidner@phytec.de>,
 Balsundar Ponnusamy <balsundar.ponnusamy@altera.com>, 
 Daniel Palmer <daniel@thingy.jp>, Anshul Dalal <anshuld@ti.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Angelo Dureghello <angelo@kernel-space.org>, 
 Johan Jonker <jbx6244@gmail.com>, Sam Protsenko <semen.protsenko@linaro.org>, 
 Guodong Xu <guodong@riscstar.com>, Yao Zi <me@ziyao.cc>,
 Rick Chen <rick@andestech.com>, 
 Leo <ycliang@andestech.com>, Yixun Lan <dlan@kenrel.org>,
 Yixun Lan <dlan@kernel.org>, 
 Alex Elder <elder@riscstar.com>, Yixun Lan <dlan@gentoo.org>,
 Anand Moon <linux.amoon@gmail.com>, 
 Trevor Gamblin <tgamblin@baylibre.com>, Vincent Legoll <legoll@online.fr>, 
 Troy Mitchell <troy.mitchell@linux.dev>, 
 Margherita Milani <margherita.milani@amarulasolutions.com>, 
 Aurelien Jarno <aurelien@aurel32.net>, Andre Heider <a.heider@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 20 Aug 2026 12:45:19 +0000
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

El jue, 20 ago 2026 a las 4:06, Eric Chung (<eric.chung@riscstar.com>) escr=
ibi=C3=B3:
>
> On Wed, Aug 19, 2026 at 8:59=E2=80=AFPM Iker Pedrosa <ikerpedrosam@gmail.=
com> wrote:
> >
> > El mi=C3=A9, 19 ago 2026 a las 5:55, Eric Chung (<eric.chung@riscstar.c=
om>) escribi=C3=B3:
> > >
> > > This series adds MMC support for the SpacemiT K1: an SDHCI platform
> > > driver, the SD card device-tree overlay, defconfig options, and SPL
> > > boot-device selection from the SoC strap/config registers. The SDHCI
> > > driver is usable in both SPL and U-Boot proper.
> > >
> > > A flashing guide (doc/board/spacemit/k1-flash.rst) describes how to
> > > write images to eMMC.
> > >
> > > ---
> > > Changes in v9:
> > > - spl: Enhance detection on booting from SD.
> > > - dts: Synched upstream DTS files for K1.
> > > - doc: Create SD card image from scratch.
> > > - mmc: Avoid to use CMD18 on SD card in SPL.
> > > - pinctrl: Drop "fix drive strength configuration".
> > > - Link to v8: https://patch.msgid.link/20260802-m4-v8-4-e916643205f3@=
riscstar.com
> > >
> > > Changes in v8:
> > > - doc: Remove SD card.
> > > - Link to v7: https://patch.msgid.link/20260729-m4-v7-8-2cb04b4fe389@=
riscstar.com
> > >
> > > Changes in v7:
> > > - env: Drop env support on the mmc series.
> > > - dts: Sync upstream DTS files for spacemit.
> > > - pinctrl: Simply clrsetbits_le32() on pull-up/pull-down configuratio=
n.
> > > - spl: Fix DTB matching.
> > > - Link to v6: https://patch.msgid.link/20260727-m4-v6-0-2f58566d48ca@=
riscstar.com
> > >
> > > Changes in v6:
> > > - pinctrl: Fix drive strength configuration.
> > > - pinctrl: Fix pull-up/pull-down configuration.
> > > - pinctrl: Use dev_read_phandle_with_args() to fetch "spacemit,syscon=
" instead.
> > > - spacemit: rebase on latest upstream branch.
> > > - Link to v5: https://patch.msgid.link/20260722-m4-v5-0-c41a951e5157@=
riscstar.com
> > >
> > > Changes in v5:
> > > - mmc: Split CMD23 support out.
> > > - mmc: Use read_poll_timeout().
> > > - mmc: Set pinctrl state based on selected timing mode.
> > > - mmc: Remove the condition based on quirks.
> > > - pinctrl: Fix power source argument.
> > > - dts: Add missing power source on mmc pins.
> > > - Link to v4: https://patch.msgid.link/20260707-m4-v4-0-dbd01185f911@=
riscstar.com
> > >
> > > Changes in v4:
> > > - mmc: Add CMD23 for write.
> > > - mmc: Fix CMD23 only for CMD18.
> > > - mmc: Update bulk release operations on reset and clocks for spacemi=
t
> > >   platform driver.
> > > - MAINTAINER: update the maintainer of Spacemit K1.
> > > - Link to v3: https://patch.msgid.link/20260705-m4-v3-0-5a9bc7f25fc5@=
riscstar.com
> > >
> > > Changes in v3:
> > > - pinctrl: Fix "fast" by "uhs".
> > > - pinctrl: Add syscon dependency.
> > > - mmc: Fix quick by capability.
> > > - doc: Add SD boot support.
> > > - Link to v2: https://lore.kernel.org/u-boot/20260630-m1-v1-0-83f1334=
7b3ba@riscstar.com/T/#m2aba875a2696a7bb9b704618d22ae2fd7f7f5acc
> > >
> > > Changes in v2:
> > > - cmd: drop patches on eminfo & tlv_eeprom.
> > > - configs: Enable ADMA and SYSCON support.
> > > - dts: Use vmmc-supply as vqmmc-supply on the SD card node.
> > > - mmc: k1: Enable ADMA mode support, use CMD23 for multi-block
> > >   read/write, correct pinctrl state from "fast" to "uhs".
> > > - mmc: sdhci: Add new quirk patch to enable CMD23 for multi-block
> > >   transfers.
> > > - pinctrl: k1: Add new IO power domain configuration support for
> > >   dual-voltage GPIO banks.
> > > - spacemit: k1: Use FIELD_GET() to parse boot strap mode.
> > > - Link to v1: https://lore.kernel.org/u-boot/20260521-k1-spl-mmc-sdca=
rd-v1-0-1bd14b8c4f9f@riscstar.com/
> > >
> > > To: u-boot-spacemit@groups.io
> > > To: u-boot@lists.denx.de
> > > To: u-boot@lists.u-boot-project.org
> > > Cc: Huan Zhou <pericycle.cc@gmail.com>
> > > Cc: Tom Rini <trini@konsulko.com>
> > > Cc: Tim Ouyang <tim609@andestech.com>
> > > Cc: Leo Liang <leo.liang@sifive.com>
> > > Cc: Raymond Mao <raymond.mao@riscstar.com>
> > > Cc: Peng Fan <peng.fan@nxp.com>
> > > Cc: Jaehoon Chung <jh80.chung@samsung.com>
> > > Cc: Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>
> > > Cc: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
> > > Cc: Kaustabh Chakraborty <kauschluss@disroot.org>
> > > Cc: Han Xu <han.xu@nxp.com>
> > > Cc: Yanir Levin <yanir.levin@tandemg.com>
> > > Cc: Christoph Stoidner <c.stoidner@phytec.de>
> > > Cc: Balsundar Ponnusamy <balsundar.ponnusamy@altera.com>
> > > Cc: Daniel Palmer <daniel@thingy.jp>
> > > Cc: Anshul Dalal <anshuld@ti.com>
> > > Cc: Bastien Curutchet <bastien.curutchet@bootlin.com>
> > > Cc: Angelo Dureghello <angelo@kernel-space.org>
> > > Cc: Johan Jonker <jbx6244@gmail.com>
> > > Cc: Sam Protsenko <semen.protsenko@linaro.org>
> > > Cc: Guodong Xu <guodong@riscstar.com>
> > > Cc: Yao Zi <me@ziyao.cc>
> > > Cc: Rick Chen <rick@andestech.com>
> > > Cc: Leo <ycliang@andestech.com>
> > > Signed-off-by: Eric Chung <eric.chung@riscstar.com>
> > >
> > > ---
> > > Alex Elder (1):
> > >       riscv: dts: spacemit: define a SPI controller node
> > >
> > > Andre Heider (6):
> > >       riscv: dts: spacemit: k1-musepi-pro: add PMIC and power infrast=
ructure
> > >       riscv: dts: spacemit: k1-musepi-pro: add 24c02 eeprom
> > >       riscv: dts: spacemit: k1-musepi-pro: enable QSPI and add SPI NO=
R
> > >       riscv: dts: spacemit: k1-musepi-pro: enable USB 3 ports
> > >       riscv: dts: spacemit: k1-musepi-pro: enable PCIe ports
> > >       riscv: dts: spacemit: k1-musepi-pro: set default console baud r=
ate
> > >
> > > Eric Chung (9):
> > >       spacemit: k1: select boot device via config registers
> > >       pinctrl: k1: fix pull-up/pull-down configuration
> > >       pinctrl: k1: add IO power domain configuration support
> > >       mmc: k1: add sdhci platform driver
> > >       dts: k1: enable mmc devices in SPL
> > >       configs: k1: enable SD and eMMC support
> > >       MAINTAINER: update Spacemit K1 entry
> > >       doc: spacemit: flash on K1 SoC based boards
> > >       spacemit: k1: fix product name detection and DTB matching in SP=
L
> > >
> > > Iker Pedrosa (2):
> > >       riscv: dts: spacemit: k1: add SD card controller and pinctrl su=
pport
> > >       riscv: dts: spacemit: k1-bananapi-f3: add SD card support with =
UHS modes
> >
> > I am just curious, is there a particular reason why the device-tree
> > changes for the OrangePi RV2 aren't included in this series?
> >
>
> I only fetch the patches I could verify, as I only have the musepi pro
> and bananpi f3. Other patches I'll leave to the maintainer.

Thanks for clarifying! That makes total sense. Hopefully, someone with
an OrangePi RV2 can pick that up once this series gets merged.
