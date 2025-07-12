Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ED67C83F1D
	for <u-boot@archiver.kernel.org>; Sat, 12 Jul 2025 13:07:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FD068006D;
	Sat, 12 Jul 2025 15:07:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=on-the-web.ch
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=on-the-web.ch header.i=@on-the-web.ch header.b="XQRiPZTy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E9B7800D7; Sat, 12 Jul 2025 10:27:05 +0200 (CEST)
Received: from mail-24422.protonmail.ch (mail-24422.protonmail.ch
 [109.224.244.22])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 263A08003E
 for <u-boot@lists.denx.de>; Sat, 12 Jul 2025 10:27:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=on-the-web.ch
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sputnik@on-the-web.ch
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=on-the-web.ch;
 s=protonmail3; t=1752308821; x=1752568021;
 bh=9UYh3HuX4WN4RuS2EwORSYPpYP3jTxeZxFmnMOP7Euk=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=XQRiPZTyp+nIzyNiYL3o0XOWl1Ot7sLVi3UlOMmrheo7RTb0VLRC/b9G4FOi7Cu05
 YzovwKZcReQmay8+7s0k+INl5rwjCzMWJ/ql4kwmxA4/StuuAilY7UC3cmpspnzkTa
 1xEg7YI1ZDbtzEJHetJpUVjaYSmBUd1aeXh8BXyAni05sHuRzBG50irj2+y+HAbctK
 FjfiGFY0VkMhqec85DO9oRH1pFjwkh5yPukKgwatvRj5A3GGOvOPq4T1mRNqdFqnfw
 Yh2ISjOzBnxOK2t0NpVhu/h+NppBuZNmQRGMNgykBlhhqTQKtmhRiB0ce/zGgkMzl3
 obkjke2uUo3mw==
Date: Sat, 12 Jul 2025 08:26:55 +0000
To: u-boot@lists.denx.de
From: Martin Herren <sputnik@on-the-web.ch>
Cc: Martin Herren <sputnik@on-the-web.ch>, Andreas Schwab <schwab@suse.de>,
 Anup Patel <anup@brainfault.org>, Atish Patra <atishp@atishpatra.org>,
 Bin Meng <bmeng.cn@gmail.com>, "Chia-Wei, Wang" <chiawei_wang@aspeedtech.com>,
 Conor Dooley <conor.dooley@microchip.com>,
 Cyril Jean <cyril.jean@microchip.com>, E Shattow <e@freeshell.de>,
 Green Wan <green.wan@sifive.com>, Hal Feng <hal.feng@starfivetech.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Junhui Liu <junhui.liu@pigmoral.tech>,
 Kongyang Liu <seashell11234455@gmail.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Maksim Kiselev <bigunclemax@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martin Schwan <m.schwan@phytec.de>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michal Simek <michal.simek@amd.com>, Minda Chen <minda.chen@starfivetech.com>,
 Padmarao Begari
 <padmarao.begari@amd.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Peter Robinson <pbrobinson@gmail.com>, Rick Chen <rick@andestech.com>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Sumit Garg <sumit.garg@kernel.org>,
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>,
 Tom Rini <trini@konsulko.com>, Wei Fu <wefu@redhat.com>,
 Yao Zi <ziyao@disroot.org>, Yixun Lan <dlan@gentoo.org>,
 Yuri Zaporozhets <yuriz@vodafonemail.de>
Subject: [PATCH 0/3] Update riscv's SYS_BOOTM_LEN to the most commonly used
 value.
Message-ID: <20250712082540.14091-1-sputnik@on-the-web.ch>
Feedback-ID: 61562450:user:proton
X-Pm-Message-ID: e0b68a876d8d53d6ab228834e688af9d7968a6c9
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg=pgp-sha256;
 boundary="------d36b3cc8328991b875eca77af6f783c44cec41c3d321328a5182d2181a8383e8";
 charset=utf-8
X-Mailman-Approved-At: Sat, 12 Jul 2025 15:07:04 +0200
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

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------d36b3cc8328991b875eca77af6f783c44cec41c3d321328a5182d2181a8383e8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
From: Martin Herren <sputnik@on-the-web.ch>
To: u-boot@lists.denx.de
Cc: Martin Herren <sputnik@on-the-web.ch>,
	Andreas Schwab <schwab@suse.de>,
	Anup Patel <anup@brainfault.org>,
	Atish Patra <atishp@atishpatra.org>,
	Bin Meng <bmeng.cn@gmail.com>,
	"Chia-Wei, Wang" <chiawei_wang@aspeedtech.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Cyril Jean <cyril.jean@microchip.com>,
	E Shattow <e@freeshell.de>,
	Green Wan <green.wan@sifive.com>,
	Hal Feng <hal.feng@starfivetech.com>,
	Heinrich Schuchardt <xypron.glpk@gmx.de>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Jerome Forissier <jerome.forissier@linaro.org>,
	Junhui Liu <junhui.liu@pigmoral.tech>,
	Kongyang Liu <seashell11234455@gmail.com>,
	Leo Yu-Chi Liang <ycliang@andestech.com>,
	Maksim Kiselev <bigunclemax@gmail.com>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	Martin Schwan <m.schwan@phytec.de>,
	Mattijs Korpershoek <mkorpershoek@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	Minda Chen <minda.chen@starfivetech.com>,
	Padmarao Begari <padmarao.begari@amd.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Peter Robinson <pbrobinson@gmail.com>,
	Rick Chen <rick@andestech.com>,
	Sean Anderson <seanga2@gmail.com>,
	Simon Glass <sjg@chromium.org>,
	Sughosh Ganu <sughosh.ganu@linaro.org>,
	Sumit Garg <sumit.garg@kernel.org>,
	Thomas Bonnefille <thomas.bonnefille@bootlin.com>,
	Tom Rini <trini@konsulko.com>,
	Wei Fu <wefu@redhat.com>,
	Yao Zi <ziyao@disroot.org>,
	Yixun Lan <dlan@gentoo.org>,
	Yuri Zaporozhets <yuriz@vodafonemail.de>
Subject: [PATCH 0/3] Update riscv's SYS_BOOTM_LEN to the most commonly used value.
Date: Sat, 12 Jul 2025 10:25:20 +0200
Message-ID: <20250712082540.14091-1-sputnik@on-the-web.ch>
X-Mailer: git-send-email 2.50.0
MIME-Version: 1.0


The most commonly used SYS_BOOTM_LEN for riscv is 0x4000000 which is
used in 25 of the current defconfigs.

The previous default config value of 0x800000 was only used in 8
defconfigs.

This patch sets the default to this value.

Command used to get the stats of the used values on RISCV defconfigs:

```
grep -l "CONFIG_RISCV=y" configs/* | \
 xargs -I {} sh -c "grep -H CONFIG_SYS_BOOTM_LEN {} || echo {}:DEFAULT" | \
 cut -d ':' -f 2 | sort | uniq -c
```


Martin Herren (3):
  riscv: Set SYS_BOOTM_LEN explicitly to 0x800000
  riscv: Set SYS_BOOTM_LEN default to 0x4000000
  riscv: Remove default SYS_BOOTM_LEN from defconfig

 boot/Kconfig                            | 2 +-
 configs/ae350_rv32_defconfig            | 1 -
 configs/ae350_rv32_falcon_defconfig     | 1 -
 configs/ae350_rv32_falcon_xip_defconfig | 1 -
 configs/ae350_rv32_spl_defconfig        | 1 -
 configs/ae350_rv32_spl_xip_defconfig    | 1 -
 configs/ae350_rv32_xip_defconfig        | 1 -
 configs
/ae350_rv64_defconfig            | 1 -
 configs/ae350_rv64_falcon_defconfig     | 1 -
 configs/ae350_rv64_falcon_xip_defconfig | 1 -
 configs/ae350_rv64_spl_defconfig        | 1 -
 configs/ae350_rv64_spl_xip_defconfig    | 1 -
 configs/ae350_rv64_xip_defconfig        | 1 -
 configs/ibex-ast2700_defconfig          | 1 -
 configs/k230_canmv_defconfig            | 1 +
 configs/microchip_mpfs_icicle_defconfig | 1 +
 configs/milkv_duo_defconfig             | 1 -
 configs/qemu-riscv32_defconfig          | 1 -
 configs/qemu-riscv32_smode_defconfig    | 1 -
 configs/qemu-riscv32_spl_defconfig      | 1 -
 configs/qemu-riscv64_defconfig          | 1 -
 configs/qemu-riscv64_smode_defconfig    | 1 -
 configs/qemu-riscv64_spl_defconfig      | 1 -
 configs/sifive_unleashed_defconfig      | 1 -
 configs/sifive_unmatched_defconfig      | 1 -
 configs/sipeed_licheerv_nano_defconfig  | 1 -
 configs/sipeed_maix_bitm_defconfig      | 1 +
 configs/sipeed_maix_smode_defconfig     | 1 +

 configs/starfive_visionfive2_defconfig  | 1 -
 configs/th1520_lpi4a_defconfig          | 1 -
 configs/xilinx_mbv32_defconfig          | 1 +
 configs/xilinx_mbv32_smode_defconfig    | 1 +
 configs/xilinx_mbv64_defconfig          | 1 +
 configs/xilinx_mbv64_smode_defconfig    | 1 +
 34 files changed, 9 insertions(+), 26 deletions(-)


--------d36b3cc8328991b875eca77af6f783c44cec41c3d321328a5182d2181a8383e8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wqsEARYIAF0FgmhyHE0JkIiu+thqKlAPNRQAAAAAABwAEHNhbHRAbm90YXRp
b25zLm9wZW5wZ3Bqcy5vcmdreMFt65DCoNBhdMLG8rOoFiEEJgeVlthQxcLg
gu1biK762GoqUA8AAIoGAQD0xOBui9/w35EMdKh6W8e1npfTk4qrcE3E0v1Y
0xc23AD9FeorADZOKYQkIbWvV8fNkuOlXBMUGPFEpKJnrok+UwM=
=ZPGz
-----END PGP SIGNATURE-----


--------d36b3cc8328991b875eca77af6f783c44cec41c3d321328a5182d2181a8383e8--

