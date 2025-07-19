Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0B70C83F27
	for <u-boot@archiver.kernel.org>; Sat, 19 Jul 2025 23:06:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1801B832F9;
	Sun, 20 Jul 2025 01:06:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=on-the-web.ch
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=smtpservice.net header.i=@smtpservice.net header.b="nrzw+m0/";
	dkim=pass (2048-bit key; unprotected) header.d=on-the-web.ch header.i=@on-the-web.ch header.b="ZryfymsR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C3C88334F; Sun, 20 Jul 2025 00:21:46 +0200 (CEST)
Received: from e3i311.smtp2go.com (e3i311.smtp2go.com [158.120.85.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C0CD182C87
 for <u-boot@lists.denx.de>; Sun, 20 Jul 2025 00:21:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=on-the-web.ch
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=bounce.py73rikruk5tiy5=2yy6wneldseb=426epkjxf2olgx@em923567.on-the-web.ch
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smtpservice.net;
 i=@smtpservice.net; q=dns/txt; s=a1-4; t=1752963694; h=feedback-id :
 x-smtpcorp-track : date : message-id : to : subject : from : reply-to
 : sender : list-unsubscribe : list-unsubscribe-post;
 bh=jPOc8G9HVTAHw2x9qxJoM5amO1xd7P7NshCRTPSWblQ=;
 b=nrzw+m0/AxAWmxuazfBY0GXdl5sVBjHtxlxEpCIf8DpvZiRiU4Sc+4Prx5IwEXujqx3sh
 PdsyALGWh260h1wonlKZeG55FY7smCftTCen/0ZAsggjsPPZTdk647ubqq9soxCKUEM7fYq
 gAnY9M7Uog1okjVK/9LgM+OYV3awk+Qffn3PdGkcV3UTncmgmAra2DupHB1sd4inK+9hjFJ
 p/PlFHCwXPHl34U/SN0VzSRT3YudR9pWGXaE/bPEzlteRMfIT1dckB7jxmfHlVcZV/U/oBO
 jACPUc2CPeIfLt4gLooGFmx4DanQgeNHqxXSH1p3QXmw1goVlOXAEd6CsOUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=on-the-web.ch;
 i=@on-the-web.ch; q=dns/txt; s=s923567; t=1752963694; h=from : subject
 : to : message-id : date;
 bh=jPOc8G9HVTAHw2x9qxJoM5amO1xd7P7NshCRTPSWblQ=;
 b=ZryfymsREVI5W7wQpqRqKNSfAsM2oHd7+nX852VJHzVUd290pLW6u8Q/3UoEFSpuo31c/
 UnEr/YcCP7ZvQcJKzEg+qdBqn50ZmBsedHfg3MOI5TMANz3DWFRz8bj8Ov7l58HVRVWpruI
 CqzcFtQhbHNhdf50OAmDBzZpSJxZifuO9eDjFDnla7fxZt5PcxBWPgDvny2nkfX8NlNY97x
 f9SGlduzVHVXeMBsFCy2kO7BoIDBauR0EgG5prZPWdZtEOyMXEnR4XO/5wRfko57pUNw1Aq
 5AqQMszlm8eWBfFtVut6Wj0T7SFmXANtya115oLPI1kU12YrBlQnpIyWhF6g==
Received: from [10.34.231.120] (helo=SmtpCorp) by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.96-S2G) (envelope-from <sputnik@on-the-web.ch>)
 id 1udFOn-U24cpc-1Q; Sat, 19 Jul 2025 21:47:17 +0000
Received: from [10.114.245.143] (helo=ch-web-troubles-5500.home)
 by smtpcorp.com with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.98.1-S2G) (envelope-from <sputnik@on-the-web.ch>)
 id 1udFOm-FnQW0hPvgzA-kCan; Sat, 19 Jul 2025 21:47:16 +0000
From: Martin Herren <sputnik@on-the-web.ch>
To: u-boot@lists.denx.de
Cc: Martin Herren <sputnik@on-the-web.ch>, Andreas Schwab <schwab@suse.de>,
 Anup Patel <anup@brainfault.org>, Atish Patra <atishp@atishpatra.org>,
 Bin Meng <bmeng.cn@gmail.com>,
 "Chia-Wei, Wang" <chiawei_wang@aspeedtech.com>,
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
 Michal Simek <michal.simek@amd.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Padmarao Begari <padmarao.begari@amd.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 Peter Robinson <pbrobinson@gmail.com>, Rick Chen <rick@andestech.com>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@kernel.org>,
 Thomas Bonnefille <thomas.bonnefille@bootlin.com>,
 Tom Rini <trini@konsulko.com>, Wei Fu <wefu@redhat.com>,
 Yao Zi <ziyao@disroot.org>, Yixun Lan <dlan@gentoo.org>,
 Yuri Zaporozhets <yuriz@vodafonemail.de>
Subject: [PATCH 0/4] Update riscv's SYS_BOOTM_LEN to the most commonly used
 value.
Date: Sat, 19 Jul 2025 23:46:31 +0200
Message-ID: <20250719214650.214931-1-sputnik@on-the-web.ch>
X-Mailer: git-send-email 2.50.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Report-Abuse: Please forward a copy of this message, including all headers,
 to <abuse-report@smtp2go.com>
Feedback-ID: 923567m:923567atSSOWT:923567sZnE37Y8eL
X-smtpcorp-track: fQXLY2Y0_KUU.IGBPh6iibkn1.mw-cYweR6Jl
X-Mailman-Approved-At: Sun, 20 Jul 2025 01:06:38 +0200
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


The most commonly used SYS_BOOTM_LEN for riscv is 0x4000000 which is
used in 25 of the current defconfigs.

The previous default config value of 0x800000 was only used in 8
defconfigs.

This patch sets the default to this value.

No actual value for any board has been changed as all defconfigs have
been adapted to keep the same SYS_BOOTM_LEN.
Only exception is the Microchip Icicle which has been increased to the
new default value.

Command used to get the stats of the used values on RISCV defconfigs:

```
grep -l "CONFIG_RISCV=y" configs/* | \
 xargs -I {} sh -c "grep -H CONFIG_SYS_BOOTM_LEN {} || echo {}:DEFAULT" | \
 cut -d ':' -f 2 | sort | uniq -c
```

Changes in v3:
- Add commit to change microchip_mpfs_icicle_defconfig to the new
  SYS_BOOTM_LEN value, on Conor Dooley's request

Martin Herren (4):
  riscv: Set SYS_BOOTM_LEN explicitly to 0x800000
  riscv: Set SYS_BOOTM_LEN default to 0x4000000
  riscv: Remove default SYS_BOOTM_LEN from defconfig
  riscv: Increase Microchip Icicle's SYS_BOOTM_LEN

 boot/Kconfig                            | 2 +-
 configs/ae350_rv32_defconfig            | 1 -
 configs/ae350_rv32_falcon_defconfig     | 1 -
 configs/ae350_rv32_falcon_xip_defconfig | 1 -
 configs/ae350_rv32_spl_defconfig        | 1 -
 configs/ae350_rv32_spl_xip_defconfig    | 1 -
 configs/ae350_rv32_xip_defconfig        | 1 -
 configs/ae350_rv64_defconfig            | 1 -
 configs/ae350_rv64_falcon_defconfig     | 1 -
 configs/ae350_rv64_falcon_xip_defconfig | 1 -
 configs/ae350_rv64_spl_defconfig        | 1 -
 configs/ae350_rv64_spl_xip_defconfig    | 1 -
 configs/ae350_rv64_xip_defconfig        | 1 -
 configs/ibex-ast2700_defconfig          | 1 -
 configs/k230_canmv_defconfig            | 1 +
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
 33 files changed, 8 insertions(+), 26 deletions(-)

