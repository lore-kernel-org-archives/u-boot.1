Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74536C624D5
	for <u-boot@archiver.kernel.org>; Wed,  2 Sep 2026 01:51:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 2EB7F407C6;
	Wed,  2 Sep 2026 01:51:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 3mJWNSi--aKX; Wed,  2 Sep 2026 01:51:55 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788313915;
	bh=3lYynlyjag6320GoKhIjNYV4LZihjmbRv/ltBj0IYYU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rYCM2g6awAiawGVeir0xIiIFXhclWkILBIlAfMZ7rewcuO60J4KniKh6d6LwaSYVd
	 njIREjutmWddvWzpy7Xi56yqdEtGepWs0B+Ipdpv89qPjGJuc5YqXWBmZxLn1JhAeu
	 JtzlsPijlTkHf4czFQI+f/4L61E0k9ZcW19C5hTyiYV3ZOJoq1hDPZ3F6fGPfZTU1g
	 sG823kjxO7+M8nX85PINhHF6Bgk711sCGWXVAqIhJ682o3DXvZLK1EL/aGzhUaEUoI
	 Q2BRZjnmNZlxxisg1Z/VVa14Wdc+decIwnj2Z6QeXXHn+LfXB13nLYI0K9JrIb+bKD
	 9pn8SzU2/wHNg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A4926407B2;
	Wed,  2 Sep 2026 01:51:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 64ADC2FE
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 01:51:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4A68D40076
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 01:51:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rkvj8oM44NmG for <u-boot@lists.u-boot-project.org>;
 Wed,  2 Sep 2026 01:51:53 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::129; helo=mail-lf1-x129.google.com;
 envelope-from=eric.chung@riscstar.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=riscstar-com.20251104.gappssmtp.com
 header.i=@riscstar-com.20251104.gappssmtp.com header.a=rsa-sha256
 header.s=20251104 header.b=Dn87s4H1
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3638E400AB
 for <u-boot@lists.u-boot-project.org>; Wed,  2 Sep 2026 01:51:51 +0000 (UTC)
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-5b2b92065ffso349652e87.1
 for <u-boot@lists.u-boot-project.org>; Tue, 01 Sep 2026 18:51:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788313909; cv=none;
 d=google.com; s=arc-20260327;
 b=sVI4yb1mouBLarG6P3hrC0My9vxkmVdVI10+oDb0F3FFz6BWD9ttVQod2Ux8SY+VJD
 pdsP5i6DxVPkUsE7B90ByfnY30jHFlZrfXpcQn7YXhloPnxQPFIr3t1Ricu57HWs+7O0
 EBqbJvnm13j66d6oUD0i44bw6NIMpHp7Vqg1BALKNrqDs9XQYy5hBi+SZX/ZhBGWyQN2
 9+YxyN8jkwGwEj/dytgFyRfypoZMWOrCS9uWN7YFzZjxdM7kEuUdmK8OhNCqjH3N2Q+y
 eAqKoiVxJfZ/6PFC+MhxDaLwD9P+yqxDrb/gk2mMBLmp0E1cDhU2TGTwHeB8oIo7Lbph
 TLQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=3lYynlyjag6320GoKhIjNYV4LZihjmbRv/ltBj0IYYU=;
 fh=iTjENAVwOA2S3NJqcDripAjWEpJPBorgHx1NMjLKPwI=;
 b=I9sP2gZZrXBgzuILHNpH5gr5rjbYnAGmoGrhG6ffLkkuMj+5qZcAtXR7Bc/JPVbCZ1
 qZXMNQrR+GxR2oO7WJzU5vsm0KnA95GQ9Eg7YNcFFAlxj3b0D9ydiPCn9g4sHqPUOFBs
 MQoZeSzYrKpTSgL9lOSdAeQXt9FvxxyMiGXCMNKP96l9FZDY594ajU/Sb+dbEHxv8Hkj
 1XNAvRtQXoRAGOZlcNcne1b3cZ1lu5z7m7e7Pw55xxULcs0vRMLWsJt+APXDZ3xNYxxm
 1jz7ca+wusbXsfnIwlt9wMAfXusBvslKa5axeS1MNW35TP4tMk1X+hAGGo7wAXWygtGh
 Nqjg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=riscstar-com.20251104.gappssmtp.com; s=20251104; t=1788313909; x=1788918709;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3lYynlyjag6320GoKhIjNYV4LZihjmbRv/ltBj0IYYU=;
 b=Dn87s4H1KZxuGnbwINpACCacu3uPOZrYZ5Htw3M61Q6Jy3IhsVmCKcodoFd2l5HvQK
 NOv3oPrjEnOrpMQYrGWqYRuVytf/x5fWU+9fU+pz2HXEaSwrunEf81YYIumI03H/XcuO
 mBlfEXTAjAPHo8SX5tkf50K+wWMv0vG9sPdgVq1r65HrhrH7N6LKG73eogUefQRW4+28
 Xqrzln+esq00h9IvMUhLmGV8xy04vbNPSEPUBUrj1WhhL1lQCggcbGL28/uviTSyb4wF
 qhvyLQqh7L/TX8stWisM63G+pPZYxtkHC5LlcSyJnyS190iZ4kgf5xUWhwA0ehl7LV0g
 uwFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788313909; x=1788918709;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3lYynlyjag6320GoKhIjNYV4LZihjmbRv/ltBj0IYYU=;
 b=dgrCwsEG/lOyP3tB9DAQM9eyaJ0MCV+tbQ+B852EOgloxnH7JIze+C2GCLjDeofPOX
 w2H6eQDdiAULL2FAvnuvSIoVVt20RFiE00FXW4A6FOYmIEEhhtasqOrIbvkATCKGlchT
 6DotWctli80gdhBsoEoFDynpEuHeyusaOgQFlDdg3wMreTT/LG7lIEkzanqocl02ue1g
 +rzrkDXLQRuS085Xa+eVZDc8CJ2VWhFZjMMCo4nDoZV+Aa1/uwJ4Tkl4zQ0Ig6CBOX1m
 nIXNn8DMHh+F+9iPSgzdV9Mq5iXBxHKnJLWWFHyuDnLEl8AJQyVyUEtUcKjmDRjdF5zy
 tBkA==
X-Forwarded-Encrypted: i=1;
 AKwUvByZ4Y/zkYJozybdG+w/UvA4GcXzgsQrTbliaitdOxb2BqoP0CQUDAumO+C8kkeIh9XwdxDGXRk=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++k4vdjaeN1X984v4CU2/P2gnnG33RHx/8kqVaGslO9gdaZP2PrE
 mQmyxLaQ7YecAEFQSjYJUyMsF24I9+WkG87POYhc9WvXySc2TNzYerm7pKrE/wPLp6n62IqYeJq
 aFDSCsjpeSfAKzswwZMzOZ2Mz55K9lWDBlUJd64pufQ==
X-Gm-Gg: AYBFou3dBG9buXGRuJGzOGcYPMidYWmSnUwbugOBEzZQ0oL/h9dS9ujFyFXnjxu+lB/
 cs9wU0O5iGI8J7vI0A2YOUc4CfucLiFLnpdi7cHKkSK6yjI7S4UI/x9eLwr5nDHD5SWADnk0nqe
 tO9f0bNT6+JcULd1qRZIdT0rUNrEKzqZXoDBt8ntpnoD6rb77hxPmj0t9xaw4f/Z9QZ4rKNv3f/
 nyHiDUcref9VbUgaeVUH9nxTwN8SjhbE8DOT0r/Y0gI1wqY0V37hoQN8MROZHlKLR8Xc0OVW41s
 X7mMsO4R6ISeULkcfOBjEXKA+Hf34xCGC+zDcUFK/SeB/VBh925ddxIk+2y3wB5WqhrdJGjmFsg
 0cCNibOv/ipX04NEdqddrRQL2o0ceqkCiDaM5g0svq0sqMzXR8HhFpULPnNWlfHLQabR6JrsvJ+
 vp0w==
X-Received: by 2002:a05:6512:238a:b0:5b6:4b1:f8bd with SMTP id
 2adb3069b0e04-5b6087ddde0mr470111e87.30.1788313908952; Tue, 01 Sep 2026
 18:51:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260824-m4-v10-0-5e0adcb1edb9@riscstar.com>
In-Reply-To: <20260824-m4-v10-0-5e0adcb1edb9@riscstar.com>
From: Eric Chung <eric.chung@riscstar.com>
Date: Wed, 2 Sep 2026 09:51:36 +0800
X-Gm-Features: AcwNN1XXUayWMIAOROJGe5uZ7d5x5aOO9MGfKbidE7Q13V6iWX0hPf95rgjQug4
Message-ID: <CAH22mJwH+sh5tN4PYnU4pRRLqMGiH1JY5=aJeZrn+6cjgT+7OA@mail.gmail.com>
Subject: Re: [PATCH v10 00/17] spacemit mmc driver
To: u-boot-spacemit@groups.io, u-boot@lists.u-boot-project.org
Cc: Tom Rini <trini@konsulko.com>, Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, Yao Zi <me@ziyao.cc>,
 Wei Fu <wefu@redhat.com>, 
 Huan Zhou <pericycle.cc@gmail.com>, Guodong Xu <guodong@riscstar.com>, 
 Raymond Mao <raymond.mao@riscstar.com>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, Anshul Dalal <anshuld@ti.com>, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Johan Jonker <jbx6244@gmail.com>, 
 Sumit Garg <sumit.garg@kernel.org>, Yixun Lan <dlan@kernel.org>, 
 Iker Pedrosa <ikerpedrosam@gmail.com>, Alex Elder <elder@riscstar.com>, 
 Andre Heider <a.heider@gmail.com>, Trevor Gamblin <tgamblin@baylibre.com>,
 Yixun Lan <dlan@gentoo.org>, 
 Anand Moon <linux.amoon@gmail.com>, Vincent Legoll <legoll@online.fr>, 
 Troy Mitchell <troy.mitchell@linux.dev>, 
 Margherita Milani <margherita.milani@amarulasolutions.com>, 
 Aurelien Jarno <aurelien@aurel32.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, Aug 24, 2026 at 4:50=E2=80=AFPM Eric Chung <eric.chung@riscstar.com=
> wrote:
>
> This series adds MMC support for the SpacemiT K1: an SDHCI platform
> driver, the SD card device-tree overlay, defconfig options, and SPL
> boot-device selection from the SoC strap/config registers. The SDHCI
> driver is usable in both SPL and U-Boot proper.
>
> A flashing guide (doc/board/spacemit/k1-flash.rst) describes how to
> write images to eMMC.
>
> ---
> Changes in v10:
> - pinctrl: Move all pinctrl patches into a new patch set.
> - Link to v9: https://patch.msgid.link/20260819-m4-v9-0-6e66016392b9@risc=
star.com
>
> Changes in v9:
> - spl: Enhance detection on booting from SD.
> - dts: Synched upstream DTS files for K1.
> - doc: Create SD card image from scratch.
> - mmc: Avoid to use CMD18 on SD card in SPL.
> - pinctrl: Drop "fix drive strength configuration".
> - Link to v8: https://patch.msgid.link/20260802-m4-v8-4-e916643205f3@risc=
star.com
>
> Changes in v8:
> - doc: Remove SD card.
> - Link to v7: https://patch.msgid.link/20260729-m4-v7-8-2cb04b4fe389@risc=
star.com
>
> Changes in v7:
> - env: Drop env support on the mmc series.
> - dts: Sync upstream DTS files for spacemit.
> - pinctrl: Simply clrsetbits_le32() on pull-up/pull-down configuration.
> - spl: Fix DTB matching.
> - Link to v6: https://patch.msgid.link/20260727-m4-v6-0-2f58566d48ca@risc=
star.com
>
> Changes in v6:
> - pinctrl: Fix drive strength configuration.
> - pinctrl: Fix pull-up/pull-down configuration.
> - pinctrl: Use dev_read_phandle_with_args() to fetch "spacemit,syscon" in=
stead.
> - spacemit: rebase on latest upstream branch.
> - Link to v5: https://patch.msgid.link/20260722-m4-v5-0-c41a951e5157@risc=
star.com
>
> Changes in v5:
> - mmc: Split CMD23 support out.
> - mmc: Use read_poll_timeout().
> - mmc: Set pinctrl state based on selected timing mode.
> - mmc: Remove the condition based on quirks.
> - pinctrl: Fix power source argument.
> - dts: Add missing power source on mmc pins.
> - Link to v4: https://patch.msgid.link/20260707-m4-v4-0-dbd01185f911@risc=
star.com
>
> Changes in v4:
> - mmc: Add CMD23 for write.
> - mmc: Fix CMD23 only for CMD18.
> - mmc: Update bulk release operations on reset and clocks for spacemit
>   platform driver.
> - MAINTAINER: update the maintainer of Spacemit K1.
> - Link to v3: https://patch.msgid.link/20260705-m4-v3-0-5a9bc7f25fc5@risc=
star.com
>
> Changes in v3:
> - pinctrl: Fix "fast" by "uhs".
> - pinctrl: Add syscon dependency.
> - mmc: Fix quick by capability.
> - doc: Add SD boot support.
> - Link to v2: https://lore.kernel.org/u-boot/20260630-m1-v1-0-83f13347b3b=
a@riscstar.com/T/#m2aba875a2696a7bb9b704618d22ae2fd7f7f5acc
>
> Changes in v2:
> - cmd: drop patches on eminfo & tlv_eeprom.
> - configs: Enable ADMA and SYSCON support.
> - dts: Use vmmc-supply as vqmmc-supply on the SD card node.
> - mmc: k1: Enable ADMA mode support, use CMD23 for multi-block
>   read/write, correct pinctrl state from "fast" to "uhs".
> - mmc: sdhci: Add new quirk patch to enable CMD23 for multi-block
>   transfers.
> - pinctrl: k1: Add new IO power domain configuration support for
>   dual-voltage GPIO banks.
> - spacemit: k1: Use FIELD_GET() to parse boot strap mode.
> - Link to v1: https://lore.kernel.org/u-boot/20260521-k1-spl-mmc-sdcard-v=
1-0-1bd14b8c4f9f@riscstar.com/
>
> To: u-boot-spacemit@groups.io
> To: u-boot@lists.u-boot-project.org
> To: Yao Zi <me@ziyao.cc>
> Cc: Huan Zhou <pericycle.cc@gmail.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Guodong Xu <guodong@riscstar.com>
> Cc: Raymond Mao <raymond.mao@riscstar.com>
> Cc: Peng Fan <peng.fan@nxp.com>
> Cc: Jaehoon Chung <jh80.chung@samsung.com>
> Cc: Anshul Dalal <anshuld@ti.com>
> Cc: Bastien Curutchet <bastien.curutchet@bootlin.com>
> Cc: Johan Jonker <jbx6244@gmail.com>
> Cc: Sumit Garg <sumit.garg@kernel.org>
> Cc: Yixun Lan <dlan@kernel.org>
> Cc: Iker Pedrosa <ikerpedrosam@gmail.com>
> Cc: Alex Elder <elder@riscstar.com>
> Cc: Andre Heider <a.heider@gmail.com>
> Cc: Trevor Gamblin <tgamblin@baylibre.com>
> Cc: Tim Ouyang <tim609@andestech.com>
> Cc: Leo Liang <leo.liang@sifive.com>
> Signed-off-by: Eric Chung <eric.chung@riscstar.com>
>
> ---
> Alex Elder (1):
>       riscv: dts: spacemit: define a SPI controller node
>
> Andre Heider (6):
>       riscv: dts: spacemit: k1-musepi-pro: add PMIC and power infrastruct=
ure
>       riscv: dts: spacemit: k1-musepi-pro: add 24c02 eeprom
>       riscv: dts: spacemit: k1-musepi-pro: enable QSPI and add SPI NOR
>       riscv: dts: spacemit: k1-musepi-pro: enable USB 3 ports
>       riscv: dts: spacemit: k1-musepi-pro: enable PCIe ports
>       riscv: dts: spacemit: k1-musepi-pro: set default console baud rate
>
> Eric Chung (7):
>       spacemit: k1: select boot device via config registers
>       mmc: k1: add sdhci platform driver
>       dts: k1: enable mmc devices in SPL
>       configs: k1: enable SD and eMMC support
>       MAINTAINER: update Spacemit K1 entry
>       doc: spacemit: flash on K1 SoC based boards
>       spacemit: k1: fix product name detection and DTB matching in SPL
>
> Iker Pedrosa (2):
>       riscv: dts: spacemit: k1: add SD card controller and pinctrl suppor=
t
>       riscv: dts: spacemit: k1-bananapi-f3: add SD card support with UHS =
modes
>
> Trevor Gamblin (1):
>       riscv: dts: spacemit: k1-musepi-pro: add SD card support with UHS m=
odes
>
>  arch/riscv/dts/k1-bananapi-f3-u-boot.dtsi          |  12 +-
>  arch/riscv/dts/k1-musepi-pro-u-boot.dtsi           | 136 +---
>  board/spacemit/k1/MAINTAINERS                      |   5 +-
>  board/spacemit/k1/spl.c                            | 145 ++++-
>  configs/spacemit_k1_defconfig                      |  22 +
>  doc/board/spacemit/index.rst                       |   1 +
>  doc/board/spacemit/k1-mmc.rst                      | 271 ++++++++
>  drivers/mmc/Kconfig                                |   7 +
>  drivers/mmc/Makefile                               |   1 +
>  drivers/mmc/spacemit_sdhci.c                       | 684 +++++++++++++++=
++++++
>  dts/upstream/src/riscv/spacemit/k1-bananapi-f3.dts |  31 +-
>  dts/upstream/src/riscv/spacemit/k1-musepi-pro.dts  | 329 +++++++++-
>  dts/upstream/src/riscv/spacemit/k1-pinctrl.dtsi    |  60 ++
>  dts/upstream/src/riscv/spacemit/k1.dtsi            |  28 +
>  14 files changed, 1581 insertions(+), 151 deletions(-)
> ---
> base-commit: 6073c36b2c8d39afe3ecc789b281667a3ddebc70
> change-id: 20260629-m4-98e01659fefb
>
> Best regards,
> --
> Eric Chung <eric.chung@riscstar.com>
>

Hi Tim, Leo, Yao

Could this patch set be merged now?

Best Regards
Eric
