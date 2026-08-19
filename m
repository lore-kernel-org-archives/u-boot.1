Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F702C5DF6D
	for <u-boot@archiver.kernel.org>; Wed, 19 Aug 2026 13:42:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 018574064F;
	Wed, 19 Aug 2026 13:42:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id noVt01zyPmLM; Wed, 19 Aug 2026 13:42:09 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787146929;
	bh=7ynm2LH3nmjVAPNaiy3joUJEjcxoBxzCiedmtEuXXxg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=edHSNcreMI3h/BHOSOeiMFTAEeMQj9nQ2kPpZkB3wgKEUE54yoCZddS3NpQy0vxR4
	 55OvXH7mTvqR5p9j0lfj8gY33fD/iz6HiFXqQ26ykKagkXIV1MUYa0Rf2eQWAJHvlK
	 CY1JqA6hMFXewaPYfV1lRYG/7tmZVQ3Lrp8UEKYnmQ1srk9XygBbVw9hn1T+lI7RLY
	 zm5BMNEvCOQnNUcAMC5kJW1VOD9WXzPW26Pe5xyDmv4lbqQMjx//HmvQlFPsXlrfcm
	 tBdeuLY4r5qZy179C9k3TlFl5tKYxMHpEgUKfwozuXsv6txoml79wDhlrzpgtVWQ3J
	 +S2oh6UrUtsjg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id EA97140721;
	Wed, 19 Aug 2026 13:42:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id ACD2C1460
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 12:59:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 928C4405F6
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 12:59:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QkDnjLP0oLoH for <u-boot@lists.u-boot-project.org>;
 Wed, 19 Aug 2026 12:59:47 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::b130; helo=mail-yx1-xb130.google.com;
 envelope-from=ikerpedrosam@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=IHgGlxe6
Received: from mail-yx1-xb130.google.com (mail-yx1-xb130.google.com
 [IPv6:2607:f8b0:4864:20::b130])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6104840566
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 12:59:47 +0000 (UTC)
Received: by mail-yx1-xb130.google.com with SMTP id
 956f58d0204a3-6688acd1a51so1788020d50.3
 for <u-boot@lists.u-boot-project.org>; Wed, 19 Aug 2026 05:59:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787144386; cv=none;
 d=google.com; s=arc-20260327;
 b=mQVVyfEpEigXssi8xkJD3jJQCK4mtM/RPgWv6Hin5UrM9nkCWgnHlseuT5EWsNSPOO
 LDZbV9KTvb5wwjMtZPkJUteMeYlsrU8kjn/DD/pCfuRykiZ1cM3p36mAXYvBtsYaB+KO
 iFYggVpIiFpSErtCXJBqIukPnS/JXGqVgZSC8DxZlOe4ggFHr5jiG7Ym6iM6Sg+VneOv
 0Vsp2uwO6wv5zgNZVdCEwepyXVxIfJ5A9Nc5EgtKL0Hzkyn+uR3BxveL9CmHexFhL2Kz
 w5///XpKtvOqU7rJGZ1HwkTEutpIn67S0B1xKD88+DFFrUT/8B3p8IbGw2eAC3cAql9M
 im3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=7ynm2LH3nmjVAPNaiy3joUJEjcxoBxzCiedmtEuXXxg=;
 fh=QGlk0yGT2SuZmoTEPHnRoA6akUBNhb0jMzB94JQWbok=;
 b=XTpZYD+s+EZQvaV0JKbLzgevvG9783oUzvohcK69XhsbpsbszXNH25+/kcmQVK9l2h
 fMBZQqW0MgnBZM6iRYdwpoH0okdhIvzd5M1xqB6ZkCSwIS9J9ed99LUYhNttn7ztV4++
 k/KqQv/DsxrhHtgVEM4PM6ExVoHVIqmDDOXYWMwjNx1d4ZKux9KQGkkgTY+NIOY55T74
 j0W/F0RZ4mwPgQhUH/1eoXDPyoMhW6NwYUQtkvWSiKv2z1fwZC2jgFVpfcBcTXR6fevw
 6PBKT7ZtsFE/lo3EGHDk99yNm5e/GGIKoNntM77yNB5TeY4JZkGDtOnFnTy6009Ca/4f
 9VpA==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787144386; x=1787749186;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=7ynm2LH3nmjVAPNaiy3joUJEjcxoBxzCiedmtEuXXxg=;
 b=IHgGlxe6uAIyCjgx/9i9I8Ek1nRQZdiaBxsuMkwSNymBIPQn9i/JOpjaa7oe4kjGat
 FTMN5Lr+QKGICB8KDLdhxEmyryllZilARKet/3l+Fc535fYmMZHTpxXyejphkREoqED3
 Gm6+v2yzlQ1zfMvFvFfK7tRpTcUo3ARJyjC+exdqA3bdNr0Jq/n8W9NI1XMJtxh0yQ4o
 ne2+bsfenL23p2S/OEI5T4X0g54M7PHi83jfEGKZ+tX1UM1kbeIF3AWhtq1nj/QbYxK7
 li6Ewd78YgDaFEnHe1O4eTdmZG2BShh+TZnBuueZ6sZLD7DykzWp1v5G4bwGOyQXVQ28
 D5XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787144386; x=1787749186;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7ynm2LH3nmjVAPNaiy3joUJEjcxoBxzCiedmtEuXXxg=;
 b=NpCyR3OATMZuq3OG/Kcwxx47DtB/E1+ex6+5eBKXnfG6qQThjZ+YbYJCBl2PYF7+lf
 BlVBiP/Wb01Hw8OXgMrb5qAiWHj43zpLGbM9MdNS7DefryP6vcitZRZHNMqy5sJLSmnE
 GPQhMktie/EwJe79KcMW3878daNVub0Z6uhGbK2bkNEVzi//P9WxrXGbC6vcS0TioIFN
 sB68vGxkjYt0zM+CZ9xqY24Ufqnfsxd/YDUmzh3HkHd3suSizvVG3o5wioMCKzIQshSC
 ZkbRK3SqJydBK1+o8wqi1MjXo4GUqZaAW8aXZGz2ju6ztguEiHwlsBY7IG6YMmStZ9+y
 lSTw==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro888+PR2g06U6M/jVdwFgudijHYAIwce0pjFG+wnjt6TXlIL5iVEahe9+eTUabSqZ3y+AH1HA=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++k/WyYVtHDoUpAG9wlpt9DEgS9h+VMBGZXM89Kwf9rKhLU+sJ3I
 7gnYWdJfsxlqVjJJqWlfl81zJi1qN6W5TDUwI7VkouFs4Sns5g4ptV3EyKE/BE9E01gLj269apm
 EqfoOCs21FqE3ZvFUbyqwKTf0OT8XyXGW9eI8
X-Gm-Gg: AR+sD12qR/h7y1zdoWRHl+Q5evmMmY8S3naEo9/4F6T4JamBTEfLtN0EdwLPMI1iI5t
 83JjqvXHwz3qAK/OExA3RNGj7IztDhVTkvsy7aaRyNInzwxRDldMvugf4pLizMV4ic0i+YYyvyP
 vCM5SYxtXv/AeLutn8QVrolZnWt5qBlw9hRbxNKNE1GRCYQC8Peed8oga3HsV6h0CRRdGQtHzeH
 VrTZvRtkssRxTUCDiATmhKQ7YSnJgHtWyrd7cUkgcPDsFXit7dG8/hce3bueAbFqyvHgT/e7VSw
 rd+w7CUsvrkex6mrHgEyOnaJG/Zr6AcgVNIVMoR0FUaloQ==
X-Received: by 2002:a05:690e:c4f:b0:668:ae76:b4c1 with SMTP id
 956f58d0204a3-66ccb5dcbc9mr1838974d50.12.1787144385926; Wed, 19 Aug 2026
 05:59:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260819-m4-v9-0-6e66016392b9@riscstar.com>
In-Reply-To: <20260819-m4-v9-0-6e66016392b9@riscstar.com>
From: Iker Pedrosa <ikerpedrosam@gmail.com>
Date: Wed, 19 Aug 2026 14:59:34 +0200
X-Gm-Features: AcwNN1UJ6nRGgkuiqQ-2z3yXDSKbDjyxAXjq7LcfqXS6nskxJh0i0bWjE9cSg5o
Message-ID: <CABdCQ=PpZhm4SWnOqE+wrf86eGT3iZSYSxUous-DB=0DFcb0mw@mail.gmail.com>
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
X-Mailman-Approved-At: Wed, 19 Aug 2026 13:42:00 +0000
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

El mi=C3=A9, 19 ago 2026 a las 5:55, Eric Chung (<eric.chung@riscstar.com>)=
 escribi=C3=B3:
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
> To: u-boot@lists.denx.de
> To: u-boot@lists.u-boot-project.org
> Cc: Huan Zhou <pericycle.cc@gmail.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Tim Ouyang <tim609@andestech.com>
> Cc: Leo Liang <leo.liang@sifive.com>
> Cc: Raymond Mao <raymond.mao@riscstar.com>
> Cc: Peng Fan <peng.fan@nxp.com>
> Cc: Jaehoon Chung <jh80.chung@samsung.com>
> Cc: Bhimeswararao Matsa <bhimeswararao.matsa@gmail.com>
> Cc: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
> Cc: Kaustabh Chakraborty <kauschluss@disroot.org>
> Cc: Han Xu <han.xu@nxp.com>
> Cc: Yanir Levin <yanir.levin@tandemg.com>
> Cc: Christoph Stoidner <c.stoidner@phytec.de>
> Cc: Balsundar Ponnusamy <balsundar.ponnusamy@altera.com>
> Cc: Daniel Palmer <daniel@thingy.jp>
> Cc: Anshul Dalal <anshuld@ti.com>
> Cc: Bastien Curutchet <bastien.curutchet@bootlin.com>
> Cc: Angelo Dureghello <angelo@kernel-space.org>
> Cc: Johan Jonker <jbx6244@gmail.com>
> Cc: Sam Protsenko <semen.protsenko@linaro.org>
> Cc: Guodong Xu <guodong@riscstar.com>
> Cc: Yao Zi <me@ziyao.cc>
> Cc: Rick Chen <rick@andestech.com>
> Cc: Leo <ycliang@andestech.com>
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
> Eric Chung (9):
>       spacemit: k1: select boot device via config registers
>       pinctrl: k1: fix pull-up/pull-down configuration
>       pinctrl: k1: add IO power domain configuration support
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

I am just curious, is there a particular reason why the device-tree
changes for the OrangePi RV2 aren't included in this series?

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
>  drivers/pinctrl/spacemit/pinctrl-k1.c              | 104 +++-
>  dts/upstream/src/riscv/spacemit/k1-bananapi-f3.dts |  31 +-
>  dts/upstream/src/riscv/spacemit/k1-musepi-pro.dts  | 329 +++++++++-
>  dts/upstream/src/riscv/spacemit/k1-pinctrl.dtsi    |  60 ++
>  dts/upstream/src/riscv/spacemit/k1.dtsi            |  28 +
>  15 files changed, 1677 insertions(+), 159 deletions(-)
> ---
> base-commit: 527115ef6783cec49e5610c523c124b399011361
> change-id: 20260629-m4-98e01659fefb
>
> Best regards,
> --
> Eric Chung <eric.chung@riscstar.com>
>
