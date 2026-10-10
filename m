Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 106EACA6017
	for <u-boot@archiver.kernel.org>; Sat, 10 Oct 2026 04:31:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2DC9D8142B;
	Sat, 10 Oct 2026 04:31:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1k--Um0Xqtvz; Sat, 10 Oct 2026 04:31:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 10EBE812D3
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791606662;
	b=nIQfE/MoRvQx27xKj+zD6kft72M2t7lAoQIYS7VcWd3f9Kk8IXAIATGE0JD/6nlEC9HY
	 l3EWv8CDn5vAnGvQwzBtp62Zu0NQOiW9xGWxhezDOwXKg6Lhj9USF16hUHcaOhQFK6W+o
	 3Bhn3oB50TmZ3jeRvjFD+jvVGQlj0BJzNa3zCKmXQjn304GmGmIl1gV3+xDVXtW1Ngnxj
	 q35AZDOuonqOWsOwz5PE839A8vxHU80uaU8XrriKitKVt14V4I2zetoyIwyQxmRJ4KPbo
	 eW5efhw3zCzQbeitmuLr6Yavosz9jztFLsv69FzLIQDvMIvsUO1K5IbW9rIij6UMk2w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791606662;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=DsYRxKGqXl61mDzx4xDdqRahyaXhdWBuluTfSM82kZY=;
	b=OTa8/kSx0jf8cWHidK+Gr9Hog1UYpUJ2hbfoBFleoP6ETuKTIifoRi4JqTBQvOscrv3F
	 e9kp4rNYYH39W4Kky3xeGxOeddsarIErD8sZSU2YoXxoGedyVEDZ/vKChTjZA5ew5U3Ou
	 Wz04CqdYvvEHNZT3gS+74p3IWv4N50W8UYa1Crur/G1ntU1E2zxda9NYGctpXp33qAFlS
	 YzOzXrkx6HIFiiwDcBum4kPpJGUrAGyw3ciiIZo2lZ5gBEPfsQZap2GpXwPFkLrLaA0cn
	 DDut535t2yfRFuFnEtWFiaplpgWfndZgQSWBDeJBm1w8QaUjBsUtk9nnu0jw6o+3UGA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jdvWANM0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791606662;
	bh=DsYRxKGqXl61mDzx4xDdqRahyaXhdWBuluTfSM82kZY=;
	h=Date:From:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Uw6uldsp5crnI7uMxjIBYvPKkGk7YK0c3Lh3CKDxxTPvm0tW13nlhtpQp5twjpEqt
	 8m24+4ijDKFFL6cNmIj1mWHZGxlx8kPpTxGhneKojow6aRtj2N3FYQ3A0iNP3i3aas
	 rJ3EPaOlGqekKzcex2mkka8JX7BAg9mLpGkSCw8vO2LE9xDzKcUuLw5ZQzgpDxEYA2
	 p8IOSWs27Ck/CbuHqzeemShtaTcp6lMsRdFsd3C9xnXPu1EgveKASvnuGz3KYKukPE
	 tEUHIpL2teZjQG2EnMglpr4AUtyo6UDEHZcIs9GIU1vj2PVQgXt9dqXOSzur/29TfW
	 aTiOToEtjOKhg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 10EBE812D3;
	Sat, 10 Oct 2026 04:31:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 3CDCF9D1
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 04:31:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 27AAC81199
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 04:31:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MsLNPOZv7QK5 for <u-boot@lists.u-boot-project.org>;
 Sat, 10 Oct 2026 04:31:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 291F681191
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791606660;
 b=NiMrA7O73W/wIEAkbsJqmtxRkaqQPs3Fin5NSXAlVPJ08c94MFmsfPoMvLhgjQQYL2LZ
 COnUjyKhsw7lgs8+gaJPBSn9amV3euHK0YoCdcOyBzvZyfTQUsLLVow5q+c2JdPpn3YIT
 64bOgb+h6+UuaRU6lAfCe7ad0ptQLfWoxUQ6r+m+Hok+5K5iAs2Q1SRe0tPOodwM0uSO6
 ce4F0EAD1fWvJUksgHElxPu/TIfaG+Gz+/LC38w39zKI0+vWqAZhyCOB0x0vO25AK3LQw
 f1ZPkjygF9WFZuduRZASYfnv+MMLZ3YjrMhZhNMdfTO5zpFxlsTRO5K/kkJswbasDqQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791606660;
 h=Received-SPF:Received:Received:DKIM-Signature:Date:From:To:Cc:
 Subject:Message-ID:MIME-Version:Content-Type:Content-Disposition;
 bh=DsYRxKGqXl61mDzx4xDdqRahyaXhdWBuluTfSM82kZY=;
 b=kNGfyTULSErXC0dYqkIav0Zw7gYK/lQ3C0VKxnnFkT2k/8XF132cZpvGqvDpsBbvsiWS
 l9yQGjzkjXYJyXHjwQG5yx4dhXe9MzQMkiUIf+g7i5yiYfORJ9USrM8Jrl2n3TygzTXcN
 XkOJ7dgcjUcMl3FYuulCg2VMCQgwW799wslcCNxPtBISDw9yys09XsKaKf0wd33xg2hyT
 ECdowPcR7qGU36J6jNd9dqnvJ7hnnnrqKi/qkyT6Kt2nKeRt9Y3BQp7pM5dczd9cgMnbE
 iID/9urCKn7LUYeVlQwDMy0VFg170pGDWzH9sDaDbWKDXDmtLY/eqadgem0I12Vd3Sw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=kernel.org;
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=jdvWANM0; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=dlan@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=jdvWANM0
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 291F681191
 for <u-boot@lists.u-boot-project.org>; Sat, 10 Oct 2026 04:30:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8339240859;
 Sat, 10 Oct 2026 04:30:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF9091F000FF;
 Sat, 10 Oct 2026 04:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791606658;
 bh=DsYRxKGqXl61mDzx4xDdqRahyaXhdWBuluTfSM82kZY=;
 h=Date:From:To:Cc:Subject;
 b=jdvWANM0pUch1wRNDmqc38MVEdtaHwbBDnKZTpAdtdLlT9VChOc2EcECY00WI3pwN
 DYFmcDIXckP++vVN8TFWJ+xms95JPijnCLLIH5SAbrbzzquRfr6nbG+aTsr7wjBdHh
 VqO21Ir3vupsHO33YQrWnLzjU/ceySLTVZV6ofNXvT2ksHq3Yqdm79XMuuZ3dsdcol
 +NOWYn7R0zrSCxoSoCzWrNSYCmsXTMYG2pSWOz12+UdUa+jLd1jg1LW9Z6RmwT/SLR
 wfEu7D/gLabpbaTAyRwW6oI818icSFyzsPpzCa+w+L3a0/WB1Vsx8efDvlROVVbzPL
 QtGQD8e89uOOQ==
Date: Sat, 10 Oct 2026 04:30:56 +0000
From: Yixun Lan <dlan@kernel.org>
To: trini@konsulko.com
Cc: u-boot@lists.u-boot-project.org, E Shattow <e@freeshell.de>
Subject: [GIT PULL] Please pull U-Boot spacemit-main-20261010
Message-ID: <20261010043056-GKA26088@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
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

Hi Tom,

Please pull from u-boot-spacemit into main, thanks.

CI for this pull request is available here:
  https://git.u-boot-project.org/u-boot/custodians/u-boot-spacemit/-/pipelines/1535


The following changes since commit 0a55b098d6f5f6bafa84fc2f18b433dd167bf729:

  Merge patch series "rng: airoha: add support for the Airoha TRNG" (2026-10-08 10:41:43 -0600)

are available in the Git repository at:

  https://git.u-boot-project.org/u-boot/custodians/u-boot-spacemit/ tags/spacemit-main-20261010

for you to fetch changes up to 01b0d2681dac9a153b0426290d696166ae999de7:

  configs: spacemit: k3: Enable Ethernet support (2026-10-10 02:21:01 +0000)

----------------------------------------------------------------
Pull request spacemit-main-20261010.

All SoC:
- Fix mux clock

K3 SoC:
- Add pinctrl support
- Add gpio support
- Add clock and reset
- Baisc board support
- Enable ethernet

----------------------------------------------------------------
Dave Klotz (1):
      clk: spacemit: program the mux when setting a mix clock's rate

Yixun Lan (15):
      pinctrl: spacemit: k3: add K3 pin support
      gpio: spacemit: add support for K3 SoC
      clk: spacemit: ccu_mix: fix inverted condition in ccu_mix_trigger_fc()
      clk: spacemit: ccu_mix: add inverted enable gate clock
      clk: spacemit: ccu_pll: add plla type clock
      clk: spacemit: k3: extract common header
      clk: spacemit: k3: add the clock tree
      clk: spacemit: k3: add CPU PLL rate tables
      reset: spacemit: Extract common K1 reset code
      reset: spacemit: Add SpacemiT K3 reset driver
      board: spacemit: add SpacemiT K3 Pico-ITX
      riscv: dts: spacemit: k3: add binman node
      configs: spacemit: Add K3 default configuration
      doc: spacemit: k3: Add Pico-ITX board
      configs: spacemit: k3: Enable Ethernet support

 arch/riscv/Kconfig                             |    5 +
 arch/riscv/cpu/k3/Kconfig                      |   18 +
 arch/riscv/cpu/k3/Makefile                     |    5 +
 arch/riscv/cpu/k3/dram.c                       |   21 +
 arch/riscv/dts/spacemit-k3-binman.dtsi         |    6 +
 arch/riscv/dts/spacemit-k3-u-boot.dtsi         |    6 +
 board/spacemit/k3/Kconfig                      |   30 +
 board/spacemit/k3/MAINTAINERS                  |    9 +
 configs/spacemit_k3_defconfig                  |   64 +
 doc/board/spacemit/index.rst                   |    1 +
 doc/board/spacemit/spacemit-pico-itx.rst       |  200 +++
 drivers/clk/spacemit/Kconfig                   |    9 +
 drivers/clk/spacemit/Makefile                  |    1 +
 drivers/clk/spacemit/clk-k3.c                  | 2049 ++++++++++++++++++++++++
 drivers/clk/spacemit/clk_common.h              |    1 +
 drivers/clk/spacemit/clk_mix.c                 |   96 +-
 drivers/clk/spacemit/clk_mix.h                 |   27 +-
 drivers/clk/spacemit/clk_pll.c                 |  124 +-
 drivers/clk/spacemit/clk_pll.h                 |   43 +-
 drivers/gpio/Kconfig                           |   11 +-
 drivers/gpio/spacemit_gpio.c                   |   97 +-
 drivers/pinctrl/spacemit/Kconfig               |    4 +-
 drivers/pinctrl/spacemit/pinctrl-k1.c          |  291 +++-
 drivers/reset/Kconfig                          |    1 +
 drivers/reset/Makefile                         |    2 +-
 drivers/reset/spacemit/Kconfig                 |   22 +
 drivers/reset/spacemit/Makefile                |    4 +-
 drivers/reset/spacemit/reset-spacemit-common.c |   93 ++
 drivers/reset/spacemit/reset-spacemit-common.h |   40 +
 drivers/reset/spacemit/reset-spacemit-k1.c     |  128 +-
 drivers/reset/spacemit/reset-spacemit-k3.c     |  242 +++
 include/configs/spacemit-k3.h                  |   13 +
 include/soc/spacemit/k3-reset.h                |   21 +
 include/soc/spacemit/k3-syscon.h               |  271 ++++
 34 files changed, 3724 insertions(+), 231 deletions(-)
 create mode 100644 arch/riscv/cpu/k3/Kconfig
 create mode 100644 arch/riscv/cpu/k3/Makefile
 create mode 100644 arch/riscv/cpu/k3/dram.c
 create mode 100644 arch/riscv/dts/spacemit-k3-binman.dtsi
 create mode 100644 arch/riscv/dts/spacemit-k3-u-boot.dtsi
 create mode 100644 board/spacemit/k3/Kconfig
 create mode 100644 board/spacemit/k3/MAINTAINERS
 create mode 100644 configs/spacemit_k3_defconfig
 create mode 100644 doc/board/spacemit/spacemit-pico-itx.rst
 create mode 100644 drivers/clk/spacemit/clk-k3.c
 create mode 100644 drivers/reset/spacemit/Kconfig
 create mode 100644 drivers/reset/spacemit/reset-spacemit-common.c
 create mode 100644 drivers/reset/spacemit/reset-spacemit-common.h
 create mode 100644 drivers/reset/spacemit/reset-spacemit-k3.c
 create mode 100644 include/configs/spacemit-k3.h
 create mode 100644 include/soc/spacemit/k3-reset.h
 create mode 100644 include/soc/spacemit/k3-syscon.h

-- 
Yixun Lan (dlan)


