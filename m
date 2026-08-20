Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A509BC5DF85
	for <u-boot@archiver.kernel.org>; Thu, 20 Aug 2026 03:23:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 449F280C1C;
	Thu, 20 Aug 2026 03:23:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id u2lNgAnXBsmS; Thu, 20 Aug 2026 03:22:59 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787196179;
	bh=hlb/pBl9hdUKjWVayXv8bjItWmAUQCCG5YCEdNf5BDA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ahw5QVGfl4pLiY4CM/E/u7kOv3FD3uAgPrbCpvB00IQWz3m5ehqR892eWWjEhMY7K
	 bps1ZgOLvmrPsWEk2jaXQyWxE4uecg5yqgE3k1HjnOoKm9Bz66/23Zw2L3zI9pKeUY
	 rnEptNlUHk8Jfboy/kOMxD7a9gAzrbIMYb1y4nw0wGoLPZEqABmV/9OZ7aOSnijR0I
	 jz+RIzRbjT2sqLG4s4cPTsBfoZ6DY5Pa2JAhVsUt7OwaY0LUkF7ewNMJwRdsxxoACZ
	 sarnLpmBz1cmCTw17YoEoMMpUYF3sP3s+JaclJ4E3eGnE4nL9CpTQaEjTHmjv2ZGEe
	 ycjuWOgNbO+mg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id A51A780C09;
	Thu, 20 Aug 2026 03:22:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 691CE263
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 02:06:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 46F0B40080
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 02:06:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lHARje624zJc for <u-boot@lists.u-boot-project.org>;
 Thu, 20 Aug 2026 02:06:58 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::129; helo=mail-lf1-x129.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=INEFrEW4
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4479040064
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 02:06:56 +0000 (UTC)
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-5aeb8c19017so2804554e87.0
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 19:06:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787191615; cv=none;
 d=google.com; s=arc-20260327;
 b=SvMrFXBhqsN/g3mz0sJvtV+JBbIwQwa+13a+HFR8kb8UjMNszaUXFDNnrG6yYTbWHA
 4Pw6HBMj1IeqC03IJ+S52DmFMfNpUU1EYgj2eh4uTYXDo+jA1toRqJvYvL3jhqcnMoyK
 0a5qUr1f9X0+gjz0mMuOYoVVv6g+Sovn7S0JLnVJP2g1T1wKHTbyp+jVScnESrBBlhku
 wGJV+h1Bd1WXJ2YTNV1X4N16QMakP3UHrud6a2/wgE0Qgvi++Bmx9qe7mGJn57U/D/Oq
 7qr8cuT/KsQOxEPay1bZmBmtBPag1r57WdcXlpUUb+NF5/e/B26/aZk/bOeEwuT/unOO
 zjXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=hlb/pBl9hdUKjWVayXv8bjItWmAUQCCG5YCEdNf5BDA=;
 fh=taMwTY2re3A82EWHzki6+t9FV1DmQpYuFrLT3QqTIGA=;
 b=bqZAxqNwxas7WY7IqvGKG2Evd5bK/+rOVQMLwYxgOON9tnlBE1BgE6Itjb/YnLrEfC
 jh/QwIFoUA7IosIuhB6Y/jrjm5oX3IgsLGrwkNSx8dXdyymy/ljSstuZyrJ2cXEtfnB7
 36T4tzUwDuzn5x754/thKREygfuImDsTkAv2xAFsfN2qax3Fh1y+XnE8S1xrb0/wOXIA
 hdTDxXFBPcCYXivh5eOlZpmCTVHvptYH1YBePqYFiqrvpWmOO7v2BybkpeS/R52yoSoS
 J6+SiQjWlRjb/kS9UFy9ALhWJHtBzcqFOPx2KoneKYjrL6T87ZLBML5AU/Y0jRDnVUBp
 j48w==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1787191615; x=1787796415;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=hlb/pBl9hdUKjWVayXv8bjItWmAUQCCG5YCEdNf5BDA=;
 b=INEFrEW4sQu3TTNlmT9z8yorh12sGwenoJiah5bF3B/eaPVAnoxFUus0uzS2vYXYhC
 zbCZwfisBxoFkvLWhGXYbWpMzKDGmqCUrl/lpZPYmL7Gp/oiii32a/yuLAMJweSxj2F9
 jFVdem/7UAojMA68Y2yxqaqAaRUkg912h0pAJ9TBsglx8NkZGXeP8qZUZKEKvU1uclkZ
 5sBK2HbyG7ZWRolfPuY8bw6CA/aUTcblHbZU9mPSAPnUqGZJUJvIxOAOMEkHi/BbZr15
 yXL54LrDhojiC3FsFZIJM1NoeOaOC0B+DoD6m6YOF/zYFP0Z2CHv3FopwOOrPvtzlNek
 KiOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787191615; x=1787796415;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hlb/pBl9hdUKjWVayXv8bjItWmAUQCCG5YCEdNf5BDA=;
 b=mJb9JQDIG8Go6hnwmpCfsprxYYm/nkROU8WotvtPZeoK4mMm2YiWx+GruViNGg2EIZ
 9naQtp6iLiAQoP/G57ydS07n8faLxCMhoS0P39TXbEdf1FjUJ//o21+OAun/S2Eb5/28
 aC9vsOU2k8INoBVcsbt80gwjfaEojtK9XIYWzgPMpGrvIwe4BYsVrHDFaVyx0eTFvlW8
 +2O1gQjjvraITMcSm5W/OqKXHFH8nOB41xEvJpMq4m2U6bRADlofEQFPsJdj5uFPBFlH
 HsCfLYc3I/Bm1AxJn+ay6jkAVG0UaUFV5T60leWcdQAp7wrwXPVVfdHOERXE/2LPw53p
 8T1A==
X-Forwarded-Encrypted: i=1;
 AHgh+RrJIYkz0hKz6lqlkLghhQ9OJh6lJTCQDhUFsjpkSBvy6tx+apYypoQF4NlIK9y0BtN8fPhuUy8=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0Yy3IcEgtnL217zoodb4qOeetwZBN6X3FOySWGJcpyWbPha9LcZ1
 RV1e3Yv07lFHQm9NZENOrQr+LhF9F5MKWkuXnXmh1MPxnxYre8zkQJQ+ZrvMBzifyXxGCYkv449
 2PaaLqzYEqLnO2BeEHMy3MHQXjVit7Jq/YhNzC2u7lA==
X-Gm-Gg: AR+sD12rWIF9Mqtgh30lA7IAT8BB5J+9kJYXRpP3wxeWekGs7PabPGTqK4/Pn9pq2Ph
 XEQInG22/B3YBGJowPeXOtP+OCIAchhNHHCa3HvzDLPwaPDaSpacZj/3R1xMXPg+eBJqFQEEuxY
 P09aSw2dsHuZJ3AVPScu+PlayGLl8I4F9yZUqRMJ9N5F7RMoMUF/yjehvELAScxeSLFmtqD/6Q0
 ZZQS8XpIvHyKRwtzd9LZNOSksDCyfZzJ6IFBXklpejrAvXxay2PPt340jMD4PIvlfEt4pHtyntp
 9LXwj5BXVn1/nq7HvKH0Gz6SUypFrVAAunZZZalbDyA020f5b+AkvbjFamRZyy4ofFj4KdY3Zng
 GkyMHa0LnamcVcuW/6ZN4wQBUfklWxzl/e5OJZFMWKbWVETP7XJIshxKZ7c3Tm0QW3xRoe0f+/1
 lGYQ==
X-Received: by 2002:a05:6512:2205:b0:5aa:6e86:55e5 with SMTP id
 2adb3069b0e04-5b478bd06ddmr2641933e87.13.1787191614593; Wed, 19 Aug 2026
 19:06:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260819-m4-v9-0-6e66016392b9@riscstar.com>
 <CABdCQ=PpZhm4SWnOqE+wrf86eGT3iZSYSxUous-DB=0DFcb0mw@mail.gmail.com>
In-Reply-To: <CABdCQ=PpZhm4SWnOqE+wrf86eGT3iZSYSxUous-DB=0DFcb0mw@mail.gmail.com>
From: Eric Chung <eric.chung@riscstar.com>
Date: Thu, 20 Aug 2026 10:06:42 +0800
X-Gm-Features: AcwNN1UtJ20IfV_waUZ3EOrjuJscQPzIxoej0VlrBXUcTCQ3C5W2CQv0eadUe2E
Message-ID: <CAH22mJy_eq1hy0mPHh3SYZfSmVynmG0+oBsHZ_GDOGSxkgDTLQ@mail.gmail.com>
Subject: Re: [PATCH v9 00/19] spacemit mmc driver
To: Iker Pedrosa <ikerpedrosam@gmail.com>
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
X-Mailman-Approved-At: Thu, 20 Aug 2026 03:22:58 +0000
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

On Wed, Aug 19, 2026 at 8:59=E2=80=AFPM Iker Pedrosa <ikerpedrosam@gmail.co=
m> wrote:
>
> El mi=C3=A9, 19 ago 2026 a las 5:55, Eric Chung (<eric.chung@riscstar.com=
>) escribi=C3=B3:
> >
> > This series adds MMC support for the SpacemiT K1: an SDHCI platform
> > driver, the SD card device-tree overlay, defconfig options, and SPL
> > boot-device selection from the SoC strap/config registers. The SDHCI
> > driver is usable in both SPL and U-Boot proper.
> >
> > A flashing guide (doc/board/spacemit/k1-flash.rst) describes how to
> > write images to eMMC.
> >
> > ---
> > Changes in v9:
> > - spl: Enhance detection on booting from SD.
> > - dts: Synched upstream DTS files for K1.
> > - doc: Create SD card image from scratch.
> > - mmc: Avoid to use CMD18 on SD card in SPL.
> > - pinctrl: Drop "fix drive strength configuration".
> > - Link to v8: https://patch.msgid.link/20260802-m4-v8-4-e916643205f3@ri=
scstar.com
> >
> > Changes in v8:
> > - doc: Remove SD card.
> > - Link to v7: https://patch.msgid.link/20260729-m4-v7-8-2cb04b4fe389@ri=
scstar.com
> >
> > Changes in v7:
> > - env: Drop env support on the mmc series.
> > - dts: Sync upstream DTS files for spacemit.
> > - pinctrl: Simply clrsetbits_le32() on pull-up/pull-down configuration.
> > - spl: Fix DTB matching.
> > - Link to v6: https://patch.msgid.link/20260727-m4-v6-0-2f58566d48ca@ri=
scstar.com
> >
> > Changes in v6:
> > - pinctrl: Fix drive strength configuration.
> > - pinctrl: Fix pull-up/pull-down configuration.
> > - pinctrl: Use dev_read_phandle_with_args() to fetch "spacemit,syscon" =
instead.
> > - spacemit: rebase on latest upstream branch.
> > - Link to v5: https://patch.msgid.link/20260722-m4-v5-0-c41a951e5157@ri=
scstar.com
> >
> > Changes in v5:
> > - mmc: Split CMD23 support out.
> > - mmc: Use read_poll_timeout().
> > - mmc: Set pinctrl state based on selected timing mode.
> > - mmc: Remove the condition based on quirks.
> > - pinctrl: Fix power source argument.
> > - dts: Add missing power source on mmc pins.
> > - Link to v4: https://patch.msgid.link/20260707-m4-v4-0-dbd01185f911@ri=
scstar.com
> >
> > Changes in v4:
> > - mmc: Add CMD23 for write.
> > - mmc: Fix CMD23 only for CMD18.
> > - mmc: Update bulk release operations on reset and clocks for spacemit
> >   platform driver.
> > - MAINTAINER: update the maintainer of Spacemit K1.
> > - Link to v3: https://patch.msgid.link/20260705-m4-v3-0-5a9bc7f25fc5@ri=
scstar.com
> >
> > Changes in v3:
> > - pinctrl: Fix "fast" by "uhs".
> > - pinctrl: Add syscon dependency.
> > - mmc: Fix quick by capability.
> > - doc: Add SD boot support.
> > - Link to v2: https://lore.kernel.org/u-boot/20260630-m1-v1-0-83f13347b=
3ba@riscstar.com/T/#m2aba875a2696a7bb9b704618d22ae2fd7f7f5acc
> >
> > Changes in v2:
> > - cmd: drop patches on eminfo & tlv_eeprom.
> > - configs: Enable ADMA and SYSCON support.
> > - dts: Use vmmc-supply as vqmmc-supply on the SD card node.
> > - mmc: k1: Enable ADMA mode support, use CMD23 for multi-block
> >   read/write, correct pinctrl state from "fast" to "uhs".
> > - mmc: sdhci: Add new quirk patch to enable CMD23 for multi-block
> >   transfers.
> > - pinctrl: k1: Add new IO power domain configuration support for
> >   dual-voltage GPIO banks.
> > - spacemit: k1: Use FIELD_GET() to parse boot strap mode.
> > - Link to v1: https://lore.kernel.org/u-boot/20260521-k1-spl-mmc-sdcard=
-v1-0-1bd14b8c4f9f@riscstar.com/
> >
> > To: u-boot-spacemit@groups.io
> > To: u-boot@lists.denx.de
> > To: u-boot@lists.u-boot-project.org
> > Cc: Huan Zhou <pericycle.cc@gmail.com>
> > Cc: Tom Rini <trini@konsulko.com>
> > Cc: Tim Ouyang <tim609@andestech.com>
> > Cc: Leo Liang <leo.liang@sifive.com>
> > Cc: Raymond Mao <raymond.mao@riscstar.com>
> > Cc: Peng Fan <peng.fan@nxp.com>
> > Cc: Jaehoon Chung <jh80.chung@samsung.com>
> > Cc: Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>
> > Cc: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
> > Cc: Kaustabh Chakraborty <kauschluss@disroot.org>
> > Cc: Han Xu <han.xu@nxp.com>
> > Cc: Yanir Levin <yanir.levin@tandemg.com>
> > Cc: Christoph Stoidner <c.stoidner@phytec.de>
> > Cc: Balsundar Ponnusamy <balsundar.ponnusamy@altera.com>
> > Cc: Daniel Palmer <daniel@thingy.jp>
> > Cc: Anshul Dalal <anshuld@ti.com>
> > Cc: Bastien Curutchet <bastien.curutchet@bootlin.com>
> > Cc: Angelo Dureghello <angelo@kernel-space.org>
> > Cc: Johan Jonker <jbx6244@gmail.com>
> > Cc: Sam Protsenko <semen.protsenko@linaro.org>
> > Cc: Guodong Xu <guodong@riscstar.com>
> > Cc: Yao Zi <me@ziyao.cc>
> > Cc: Rick Chen <rick@andestech.com>
> > Cc: Leo <ycliang@andestech.com>
> > Signed-off-by: Eric Chung <eric.chung@riscstar.com>
> >
> > ---
> > Alex Elder (1):
> >       riscv: dts: spacemit: define a SPI controller node
> >
> > Andre Heider (6):
> >       riscv: dts: spacemit: k1-musepi-pro: add PMIC and power infrastru=
cture
> >       riscv: dts: spacemit: k1-musepi-pro: add 24c02 eeprom
> >       riscv: dts: spacemit: k1-musepi-pro: enable QSPI and add SPI NOR
> >       riscv: dts: spacemit: k1-musepi-pro: enable USB 3 ports
> >       riscv: dts: spacemit: k1-musepi-pro: enable PCIe ports
> >       riscv: dts: spacemit: k1-musepi-pro: set default console baud rat=
e
> >
> > Eric Chung (9):
> >       spacemit: k1: select boot device via config registers
> >       pinctrl: k1: fix pull-up/pull-down configuration
> >       pinctrl: k1: add IO power domain configuration support
> >       mmc: k1: add sdhci platform driver
> >       dts: k1: enable mmc devices in SPL
> >       configs: k1: enable SD and eMMC support
> >       MAINTAINER: update Spacemit K1 entry
> >       doc: spacemit: flash on K1 SoC based boards
> >       spacemit: k1: fix product name detection and DTB matching in SPL
> >
> > Iker Pedrosa (2):
> >       riscv: dts: spacemit: k1: add SD card controller and pinctrl supp=
ort
> >       riscv: dts: spacemit: k1-bananapi-f3: add SD card support with UH=
S modes
>
> I am just curious, is there a particular reason why the device-tree
> changes for the OrangePi RV2 aren't included in this series?
>

I only fetch the patches I could verify, as I only have the musepi pro
and bananpi f3. Other patches I'll leave to the maintainer.
