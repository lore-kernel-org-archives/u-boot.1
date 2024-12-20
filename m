Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75A8CE7718B
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 14:47:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7D45A80352;
	Fri, 20 Dec 2024 15:47:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="UipEB2Bt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 20AC38036F; Fri, 20 Dec 2024 15:47:43 +0100 (CET)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9FFC480243
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 15:47:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=suse.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ldevulder@suse.com
Received: by mail-wm1-x344.google.com with SMTP id
 5b1f17b1804b1-43634b570c1so14631025e9.0
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 06:47:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1734706060; x=1735310860; darn=lists.denx.de;
 h=mime-version:user-agent:content-transfer-encoding:autocrypt
 :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=FIW2r6meqocq0oBGI/nQUHBRaLOegTYeEe6QBhWsRXg=;
 b=UipEB2BtV1lWhYXpuqplOc9uoguihtGMbDLh4H316BT+n8hnExlvWeufE12M0GQk7t
 mLkvu+8gAEAODcnJFBDrk9uAdqOxv8CThjGy0rmh4pSdzMKArCOcSGRmZ3KolA8v9Ftt
 PVicnHZmJSA1tm8HwyTfzX++pM87lNlM05nkjCe8/qrIEI8q+LPdBFUQ2RUEC3mit9sm
 xTHj9muoS6IlfxApjFl6EhYwcfhwtufMB01nf0KvYd9F/g7OwSOE1+5zUB3xTdP9Vhnn
 ciH3GpAfWwE1HUePKZI/L9hX6IYaSmmPw+TL4HQUOGL0K5Usb27pBt9/HSgYxcs9gAb8
 uxwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734706060; x=1735310860;
 h=mime-version:user-agent:content-transfer-encoding:autocrypt
 :references:in-reply-to:date:cc:to:from:subject:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FIW2r6meqocq0oBGI/nQUHBRaLOegTYeEe6QBhWsRXg=;
 b=eUoJlLHGPr+6ue+DE5SurXlNvgf849zTlR5dNUH4fLD726SL9u5j3sM3ouUfqBEk2b
 z027L1Sxm8E/sCSVROmMuDhhmXlM3Qw9w3BucnnUaGdNUsBBxPRsU5DXGLci92N9mV7j
 wwR6MKEX3jL/wZhlyiMrnurXDqC4WvvPkX6bbHiv5FvskJ6ir55f8QS1gCwh2QCfPo/M
 xadSHdnz0+zcuN9QRWd1D/GDerTtaYLYAEvQ3awVxqG4JzpOXUg04CAJ+YL0farfzLRx
 D4andbEzJMwSumiYYW6Hs8lBDU+Ue/RbS1ZwzUgvgXsve5r90EzOacuABWWBRc2z71MZ
 oJgQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5VEj9BXithQU2sLV0jwgLAQM2ybBGTMtl00FBEL5CkNJFQzw0CxDhLZEhH2OfPQWiC9xo0rY=@lists.denx.de
X-Gm-Message-State: AOJu0YwnYiCNh6fpJXHG9YuNWCgkIeio/YPsrnH3vtD1fnLKQy/LfNbF
 wlITG1E/9SMTHCDc2qZsaE4HEpE8yDRk/YQPWpnotTrQH6WFi+e6hS6xsvQ7Si0=
X-Gm-Gg: ASbGncvdIFvRfNoI68DCERNoeCo9W2fDXT7X9UgcvEa39Is6KyE1jYh6Fv8nGbyzkcL
 hokTjsy/LWKeEY40A5JZL/j641a7LD3WICj6vNcpdsvGzqsKFIFGLdj4OlFtzzmcp0NmETBwNOQ
 4DmgKVLw3sSR/vbtq8qHAOz31opGj0vCJ5c1dWGqQSEcEZFX4LWIt8X8KYziJy0A9wTkbixDPQr
 xfnC3TS7IkFK5WsfaiYt8s2RlMMyXWRVwwaobb8KVsCyi/s0D2sUDw=
X-Google-Smtp-Source: AGHT+IFRByXNha7zbXZevxHhsZXkefwbjQs8o3CAePtv4oX8bM4PAf/OET9kWw6O+9wbrAxTEjFvnw==
X-Received: by 2002:a5d:5f4a:0:b0:385:fdc2:1808 with SMTP id
 ffacd0b85a97d-38a223f7172mr3470019f8f.40.1734706060097; 
 Fri, 20 Dec 2024 06:47:40 -0800 (PST)
Received: from [192.168.4.7] ([82.66.145.28]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4366127c508sm47489135e9.33.2024.12.20.06.47.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2024 06:47:39 -0800 (PST)
Message-ID: <60c42f0ef67165d880bed647b4c545842d09d827.camel@suse.com>
Subject: Re: [PATCH v8 00/12] Support OF_UPSTREAM for StarFive JH7110
From: Loic Devulder <ldevulder@suse.com>
To: Hal Feng <hal.feng@starfivetech.com>, Leo <ycliang@andestech.com>, Tom
 Rini	 <trini@konsulko.com>, Sumit Garg <sumit.garg@linaro.org>, Rick Chen	
 <rick@andestech.com>, Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, Peng
 Fan	 <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, Heinrich
 Schuchardt	 <xypron.glpk@gmx.de>, H Bell <dmoo_dv@protonmail.com>, E
 Shattow	 <lucent@gmail.com>, Conor Dooley <conor.dooley@microchip.com>, Nam
 Cao	 <namcao@linutronix.de>, Bo Gan <ganboing@gmail.com>
Cc: Emil Renner Berthing <emil.renner.berthing@canonical.com>, Minda Chen
 <minda.chen@starfivetech.com>, u-boot@lists.denx.de
Date: Fri, 20 Dec 2024 15:47:39 +0100
In-Reply-To: <20241208091942.47298-1-hal.feng@starfivetech.com>
References: <20241208091942.47298-1-hal.feng@starfivetech.com>
Autocrypt: addr=ldevulder@suse.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 
MIME-Version: 1.0
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

Hi all,

I successfully tested theses patches on latest version of openSUSE Tumblewe=
ed.
U-Boot loads the DT file from the OS image as expected, I'm now able to boo=
t from nvme ssd and
access it within the OS :-)

Tested-by: Loic Devulder <ldevulder@suse.com>

On Sun, 2024-12-08 at 17:19 +0800, Hal Feng wrote:
> This patchset add OF_UPSTREAM support for StarFive JH7110 based boards.
> All the JH7110 based boards can use the DT from upstreaming linux kernel.
> The v1.3b board device tree is set as the default device tree. Support
> CONFIG_MULTI_DTB_FIT and the SPL selects the correct U-Boot dtb using the
> EEPROM information.
>=20
> Note:
> 1. Mars CM (lite) are missing upstream dts and so are detected but not
> supported in this series. Users of Mars CM and Mars CM Lite may stay with
> U-Boot v2024.10 until this is resolved.
>=20
> 2. Property values of node phy0/1, gmac0/1, stmmac_axi_setup for all
> JH7110 based boards now follow the upstream dts.
>=20
> 3. Set "cdns,read-delay =3D <2>" for qspi flash@0 and this setting will b=
e
> synced to Linux later.
>=20
> Changes since v7:
> - In patch 2, drop "spi-max-frequency" property of qspi, set
> =C2=A0 "cdns,read-delay =3D <2>" for flash@0.
> =C2=A0 Drop &stmmac_axi_setup &gmac0 &gmac1 property overrides.
> =C2=A0 Drop the redundant &S7_0 { status =3D "okay"; }.
>=20
> Changes since v6:
> - Drop the "snps,dw-mshc" override of compatible in patch 2, then add
> =C2=A0 "starfive,jh7110-mmc" compatible in mmc driver to match upstream D=
T.
> - Delete newline at end of Mars DT file in patch 5.
> - Sort OF_LIST in patch 7.
> - Sort items of images and configurations in patch 8.
>=20
> Changes since v5:
> - In patch 2, drop the override of rx-internal-delay-ps on phy0 and phy1.
> - In patch 5, drop "/delete-property/ motorcomm,tx-clk-10-inverted;" for
> =C2=A0 Mars network phy0.
> - In patch 8, rename fdt and conf based on the compatible identifier of
> =C2=A0 boards.
>=20
> Changes since v4:
> - Merge patch 2, 3, 5 into patch 1, ensuring git bisect works.
> - Add a new patch to sort the list of JH7110 imply statements.
> - Drop the reparent of clock JH7110_AONCLK_APB_FUNC in patch 4, which is
> =C2=A0 unnecessary and will cause errors in gmac0 initialization.
>=20
> Changes since v3:
> - Add detection for Milk-V Mars CM (lite) boards in patch 13.
>=20
> Changes since v2:
> - Drop patch 1, because the riscv of_upstream Makefile is created by Cono=
r
> =C2=A0 in commit 239e4705099c.
> - Drop phy0 rx delay for milkv u-boot dtsi in patch 9.
> - Add a Fixes tag for patch 13.
> - In patch 14, the PCB version is only obtained when the product_id is
> =C2=A0 VF7110. Improve the commit messages.
>=20
> Changes since v1:
> - Drop patch 12.
> - Modify patch 11 and add three new patches to support
> =C2=A0 CONFIG_MULTI_DTB_FIT. The SPL selects the correct U-Boot dtb using=
 the
> =C2=A0 EEPROM information.
>=20
> History:
> v7: https://lore.kernel.org/all/20241203030430.26089-1-hal.feng@starfivet=
ech.com/
> v6: https://lore.kernel.org/all/20241125003205.75327-1-hal.feng@starfivet=
ech.com/
> v5: https://lore.kernel.org/all/20241119020425.51989-1-hal.feng@starfivet=
ech.com/
> v4: https://lore.kernel.org/all/20241111020808.38974-1-hal.feng@starfivet=
ech.com/
> v3: https://lore.kernel.org/all/20241105034328.56439-1-hal.feng@starfivet=
ech.com/
> v2: https://lore.kernel.org/all/20241028015847.42344-1-hal.feng@starfivet=
ech.com/
> v1: https://lore.kernel.org/all/20240930155919.111738-1-hal.feng@starfive=
tech.com/
>=20
> Hal Feng (12):
> =C2=A0 dts: starfive: Switch to using upstream DT
> =C2=A0 riscv: dts: jh7110: Make u-boot device trees adapting to upstream =
DT
> =C2=A0 mmc: dw_mmc: Add "starfive,jh7110-mmc" compatible to match upstrea=
m DT
> =C2=A0 pcie: starfive: Make the driver compatible with upstream DT
> =C2=A0 riscv: dts: jh7110: Move common code to the new
> =C2=A0=C2=A0=C2=A0 jh7110-common-u-boot.dtsi
> =C2=A0 riscv: dts: jh7110: Add u-boot device tree for JH7110 based boards
> =C2=A0 board: starfive: spl: Drop the unneeded DT modification code
> =C2=A0 configs: visionfive2: Enable MULTI_DTB_FIT for JH7110 based board =
DT
> =C2=A0 riscv: dts: jh7110: Support multiple DTBs in a Fit image
> =C2=A0 board: starfive: spl: Fix the wrong use of CONFIG_IS_ENABLED()
> =C2=A0 board: starfive: spl: Support multiple DTBs for JH7110 based board=
s
> =C2=A0 riscv: cpu: jh7110: Sort the list of imply statements
>=20
> =C2=A0arch/riscv/cpu/jh7110/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 19 +-
> =C2=A0arch/riscv/dts/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 -
> =C2=A0arch/riscv/dts/jh7110-common-u-boot.dtsi=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 195 +++++
> =C2=A0arch/riscv/dts/jh7110-milkv-mars-u-boot.dtsi=C2=A0 |=C2=A0=C2=A0 6 =
+
> =C2=A0.../dts/jh7110-pine64-star64-u-boot.dtsi=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0=C2=A0 6 +
> =C2=A0.../jh7110-starfive-visionfive-2-u-boot.dtsi=C2=A0 | 117 ---
> =C2=A0...10-starfive-visionfive-2-v1.2a-u-boot.dtsi |=C2=A0=C2=A0 6 +
> =C2=A0...10-starfive-visionfive-2-v1.3b-u-boot.dtsi |=C2=A0=C2=A0 6 +
> =C2=A0.../dts/jh7110-starfive-visionfive-2.dts=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 11 -
> =C2=A0.../dts/jh7110-starfive-visionfive-2.dtsi=C2=A0=C2=A0=C2=A0=C2=A0 |=
 380 ---------
> =C2=A0arch/riscv/dts/jh7110-u-boot.dtsi=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 27 +-
> =C2=A0arch/riscv/dts/jh7110.dtsi=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 | 761 ------------------
> =C2=A0board/starfive/visionfive2/spl.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 391 +--------
> =C2=A0configs/starfive_visionfive2_defconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 4 +-
> =C2=A0drivers/clk/starfive/clk-jh7110-pll.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 6 +-
> =C2=A0drivers/clk/starfive/clk-jh7110.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 44 +-
> =C2=A0drivers/mmc/snps_dw_mmc.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0=C2=A0 1 +
> =C2=A0drivers/pci/pcie_starfive_jh7110.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 59 +-
> =C2=A0.../dt-bindings/clock/starfive,jh7110-crg.h=C2=A0=C2=A0 | 258 -----=
-
> =C2=A0.../dt-bindings/reset/starfive,jh7110-crg.h=C2=A0=C2=A0 | 183 -----
> =C2=A020 files changed, 342 insertions(+), 2139 deletions(-)
> =C2=A0create mode 100644 arch/riscv/dts/jh7110-common-u-boot.dtsi
> =C2=A0create mode 100644 arch/riscv/dts/jh7110-milkv-mars-u-boot.dtsi
> =C2=A0create mode 100644 arch/riscv/dts/jh7110-pine64-star64-u-boot.dtsi
> =C2=A0delete mode 100644 arch/riscv/dts/jh7110-starfive-visionfive-2-u-bo=
ot.dtsi
> =C2=A0create mode 100644 arch/riscv/dts/jh7110-starfive-visionfive-2-v1.2=
a-u-boot.dtsi
> =C2=A0create mode 100644 arch/riscv/dts/jh7110-starfive-visionfive-2-v1.3=
b-u-boot.dtsi
> =C2=A0delete mode 100644 arch/riscv/dts/jh7110-starfive-visionfive-2.dts
> =C2=A0delete mode 100644 arch/riscv/dts/jh7110-starfive-visionfive-2.dtsi
> =C2=A0delete mode 100644 arch/riscv/dts/jh7110.dtsi
> =C2=A0delete mode 100644 include/dt-bindings/clock/starfive,jh7110-crg.h
> =C2=A0delete mode 100644 include/dt-bindings/reset/starfive,jh7110-crg.h
>=20
>=20
> base-commit: 45f05f681224d88d1b170063001b59edc8fc24cf

--=20
Loic
