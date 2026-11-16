Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA70606A33D
	for <u-boot@archiver.kernel.org>; Mon, 16 Nov 2026 17:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=PTKhli8S;
	dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256 header.s=20231125 header.b=G7D98XKI
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1F4CF406FA;
	Mon, 16 Nov 2026 17:05:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id du87TLw2rLb9; Mon, 16 Nov 2026 17:05:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E8120406A5
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794848724;
	b=Cna9zaFIAE3wbeS/QtkwFej+CtUZwS5B8mXjwTMpwJu8/ZI/C4+77nMgIAJA4cFW4GTb
	 2pwelAM/zyNberps+CuNBHiUhPlWH5+s94/moRwz+j7gRTAbYCottip+0/bvUK8neVZ+u
	 ti0t5qiLIc2KpH7Z/A8Qii0BQ/J+AXapp+XTUPwf+mVBAQW5oX0lIt5HVch8Bo/wl12TI
	 IT6ej7Puh2wPBj4jEVwqZtQaOeC7UaVS1X61wKfs1N4dU8vmHH9ulEi7SkDThs5zBjis1
	 dU24HrYg+uwTIkm7xqF+nAI19UFjqnUCf+mhX1XtmmT+fDkHs/u9tPQFWQz42RB3Z2g==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794848724;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Infomaniak-Routing:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=B8A7mdUUqBKxtOfD9AKMmUovUoZpCLBcIBnDXSnaiVA=;
	b=kOL+Gk1BfpZwv4PSF8HndNJZgYW+/IviyYmV3RGVlmIPEDmThrk8k8REkFQOd2IgtZu8
	 KObSgB3W1vPblV01Q3+zRWCvve0bw6640iY8FS42NkVZJoVNxueDykiRuHSaM8iIGxDfi
	 t5dX3gtPzHuFrD3oRrELamI8tcir2IoLpRXW3xWAkFhpbCmrBl4S8V6kKvjL6AgMPFVqb
	 UgcrzjBVs/L5u0meDWZ3zjyF90Pqd2lL/RciCRXFoUS+JzwY+L1E+00bsim+r87LbJHuE
	 10AqT3qCrerDPP/JqUcE8JcvTQrfRe3eN4kcfPOO3RbjuOi81U+2G9rCTQboVeTE7gw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=0leil.net;
	dkim=pass header.d=0leil.net header.i=@0leil.net header.a=rsa-sha256 header.s=20231125 header.b=G7D98XKI;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794848724;
	bh=B8A7mdUUqBKxtOfD9AKMmUovUoZpCLBcIBnDXSnaiVA=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=PTKhli8SGu4uV+QMm5zGeK4rll8Hl1/yCizs5ndV+sd0pHop9tVDTCRCEHvGtusRV
	 XeanFO+F3y8nUsTKu3UiNJleh8h76RWrve1ACtWneiXwveZYOJK7zy/AQg9PdI6EJ6
	 PGM1UMQL2xxXuhprX7QtSRkgKur5OaNl1OKB52xXy1ghfNsNu9mwXKhibGo6IVGlsK
	 V6aSkpN5bClXN5eLyuTW11wjivegXJKVdU2wgSq3TSxmaMBslyE1NcF/ZFuX7mnEYl
	 pkGMCHyAMIee3zrkPqecdgTiS2NEjtDW2Ea2ZGOLlqMTPDG7cuMPMgqr4HVyH8Is6g
	 NVTXrPNEzx9Pw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id E8120406A5;
	Mon, 16 Nov 2026 17:05:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 79B1C169
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:05:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6544E406A5
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:05:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id R4NuX9JsbVhm for <u-boot@lists.u-boot-project.org>;
 Mon, 16 Nov 2026 17:05:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D036C405F4
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2001:1600:19:7ff8::42ae"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:1600:19:7ff8::42ae; helo=smtp-42ae.mail.infomaniak.ch;
 envelope-from=u-boot@0leil.net; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=0leil.net
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=0leil.net header.i=@0leil.net
 header.a=rsa-sha256 header.s=20231125 header.b=G7D98XKI
Received: from smtp-42ae.mail.infomaniak.ch (smtp-42ae.mail.infomaniak.ch
 [IPv6:2001:1600:19:7ff8::42ae])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D036C405F4
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 17:05:20 +0000 (UTC)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:4:17::246c])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jSvPV1mcmz2ScZ
 for <u-boot@lists.u-boot-project.org>; Mon, 16 Nov 2026 18:05:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=0leil.net;
 s=20231125; t=1794848718;
 bh=B8A7mdUUqBKxtOfD9AKMmUovUoZpCLBcIBnDXSnaiVA=;
 h=From:To:Cc:Subject:Date:From;
 b=G7D98XKImMtr48FDskK2LmWPGEG8cbrbS2Ox+HaT5MK1Z5Az/+NnVovSybHLz6z3q
 hxZifCEzS0SUqcO9TZOo9g/9cdfi0YxZlE4CbSoe0FbWFKmC6RpkO1TkNUuI8X2uEJ
 jB4EtJk7Dphteg6nTShDDH8ID4iT9T4i6zsJOxAJnxTZ/pblx96cgVlWyvEoGNUCFG
 2ipe0uAT4kdJvnQzlwnAgG6k5Ir2bJOrURU19iLuNYJJ179cXTT4rZtXzNqeZR5sjR
 Hzl0Kg+MkZea8vKOa0NfiYm1Of//nHQ8SbJjY1TdeiN1uC8fqM7HiRzSKqN+xwwFHI
 sTJ8fI3JvLx5w==
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4jSvPT38CxzMRL; Mon, 16 Nov 2026 18:05:17 +0100 (CET)
From: Quentin Schulz <u-boot@0leil.net>
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
Subject: [GIT PULL] Please pull u-boot-rockchip-2027.04-20261116 into next
Date: Mon, 16 Nov 2026 18:03:47 +0100
Message-ID: <20261116170457.1849016-1-u-boot@0leil.net>
X-Mailer: git-send-email 2.56.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-23.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Tom,

CI for this pull request is available here: https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip/-/pipelines/2066

The following changes since commit ecdcf9e365df6249a57cd8cc946e7026804ff4ae:

  Prepare v2027.01-rc2 (2026-11-09 15:52:36 -0600)

are available in the Git repository at:

  https://git.u-boot-project.org/u-boot/custodians/u-boot-rockchip.git tags/u-boot-rockchip-2027.04-20261116

for you to fetch changes up to 40393084b930d7ed5dcecf7952cea06b9006df68:

  clk: rockchip: rk3576: Use correct mask for UART1 parent clock (2026-11-16 11:59:35 +0100)

----------------------------------------------------------------
- Properly handle LPDDR5X,
- Remove rkmux.py script,
- Migrate doc/README.rockchip to doc/board/rockchip/,
- Fix various issues in clock drivers for RK35xx family,
- Remove redundant call to clk_set_defaults() in Rockchip clock drivers,
- Add new devices:
  - FriendlyElec NanoPI R28S,

----------------------------------------------------------------
Cunhao Lu (1):
      rockchip: ram: Fix LPDDR5X size decoding

Johan Jonker (6):
      rockchip: scripts: remove rkmux.py
      rockchip: doc: add mask ROM mode text
      rockchip: doc: remove TODO
      rockchip: doc: remove README.rockchip
      rockchip: doc: add back to ROM section
      rockchip: doc: add notes section

Jonas Karlman (46):
      clk: rockchip: rk3506: Remove unnecessary clk_set_defaults() call
      clk: rockchip: rk3528: Remove unnecessary clk_set_defaults() call
      clk: rockchip: rk3568: Remove unnecessary clk_set_defaults() call
      clk: rockchip: rk3576: Remove unnecessary clk_set_defaults() call
      clk: rockchip: rk3588: Remove unnecessary clk_set_defaults() call
      clk: rockchip: rv1126: Remove unnecessary clk_set_defaults() call
      clk: rockchip: rk3308: Remove unnecessary clk_set_defaults() call
      clk: rockchip: rk3528: Return correct rate for CLK_PWMx
      clk: rockchip: rk3528: Fix VOP clock configuration
      clk: rockchip: rk3528: Align PPLL entry in PLL table
      clk: rockchip: rk3568: Use correct clock id for GPLL
      clk: rockchip: rk3568: Fix PWM0 parent selection mask
      clk: rockchip: rk3568: Use PWM0 divider shift
      clk: rockchip: rk3568: Use correct PLL rate for CLK_MAC0_2TOP
      clk: rockchip: rk3588: Use GPLL rate for CLK_TSADC
      clk: rockchip: rk3588: Use correct PLL rate for SCLK_UARTx divider
      clk: rockchip: rk3588: Fix ACLK_BUS_ROOT divider encoding
      clk: rockchip: rk3588: Set ACLK_BUS_ROOT to 375 MHz
      clk: rockchip: rk3588: Remove redundant PLL register macros
      clk: rockchip: rk3588: Rename PPLL register macro
      clk: rockchip: rk3588: Align BxPLL entries in PLL table
      clk: rockchip: rk3588: Use SPLL_HZ constant
      clk: rockchip: rk3576: Use correct mode register for VPLL
      clk: rockchip: rk3576: Fix ACLK_TOP_MID parent selection
      clk: rockchip: rk3576: Fix I2C rate selection
      clk: rockchip: rk3576: Fix CLK_I2C8 rate change
      clk: rockchip: rk3576: Use correct clock register for CLK_SARADC
      clk: rockchip: rk3576: Use correct TSADC clock register
      clk: rockchip: rk3576: Use correct PLL rate for UART fractional clocks
      clk: rockchip: rk3576: Use correct PLL rate for UART divisor
      clk: rockchip: rk3576: Rename PPLL register macro
      clk: rockchip: rk3576: Remove unused BPLL register macro
      clk: rockchip: rk3576: Group LPLL register macro with CCI macros
      clk: rockchip: rk3576: Align BPLL entry in PLL table
      clk: rockchip: rk3506: Return correct rate for CLK_I2C0 and CLK_I2C1
      clk: rockchip: rk3568: Drop unused GRF syscon lookup
      clk: rockchip: rk3588: Drop unused GRF syscon lookup
      adc: rockchip-saradc: Use 3 MHz clock rate for RK3528
      clk: rockchip: pll: Fix fractional PLL rate calculation
      clk: rockchip: pll: Fix automatic PLL fractional parameter calculation
      clk: rockchip: pll: Always write the dsmpd flag
      clk: rockchip: pll: Always write the k parameter
      clk: rockchip: pll: Use PLL_FIXED_MODE flag on RK3588/RK3576 PPLL
      clk: rockchip: pll: Limit special rk3588_pll handling to RK3588
      clk: rockchip: rk3576: Fix ACLK_TOP divisor value
      clk: rockchip: rk3576: Use correct mask for UART1 parent clock

安容 (6):
      dt-bindings: arm: rockchip: Add FriendlyElec NanoPi R28S
      arm64: dts: rockchip: Split out the common NanoPi RK3528 parts
      arm64: dts: rockchip: Add devicetree for the FriendlyElec NanoPi R28S
      rockchip: rk3528: Split out common NanoPi u-boot.dtsi
      board: rockchip: Add common NanoPi RK3528 board target
      board: rockchip: Add FriendlyElec NanoPi R28S

 MAINTAINERS                                        |   1 -
 arch/arm/dts/rk3528-nanopi-r28s-u-boot.dtsi        |   3 +
 arch/arm/dts/rk3528-nanopi-u-boot.dtsi             |  16 +
 arch/arm/dts/rk3528-nanopi-zero2-u-boot.dtsi       |  10 +-
 arch/arm/include/asm/arch-rockchip/clock.h         |   2 +-
 arch/arm/include/asm/arch-rockchip/cru_rk3528.h    |   1 -
 arch/arm/include/asm/arch-rockchip/cru_rk3568.h    |   2 -
 arch/arm/include/asm/arch-rockchip/cru_rk3576.h    |   6 +-
 arch/arm/include/asm/arch-rockchip/cru_rk3588.h    |   7 +-
 arch/arm/include/asm/arch-rockchip/cru_rv1126.h    |   1 -
 arch/arm/include/asm/arch-rockchip/sdram.h         |   2 +-
 arch/arm/mach-rockchip/Kconfig                     |  16 +-
 arch/arm/mach-rockchip/rk3528/Kconfig              |   7 +
 arch/arm/mach-rockchip/rk3528/MAINTAINERS          |   6 -
 arch/arm/mach-rockchip/sdram.c                     |   4 +-
 board/friendlyelec/nanopi-rk3528/Kconfig           |  14 +
 board/friendlyelec/nanopi-rk3528/MAINTAINERS       |   9 +
 board/friendlyelec/nanopi-rk3528/Makefile          |   3 +
 board/friendlyelec/nanopi-rk3528/nanopi-rk3528.c   |  60 ++
 configs/nanopi-zero2-rk3528_defconfig              |   3 +
 doc/README.rockchip                                | 684 ---------------------
 doc/README.rockusb                                 |   1 -
 doc/board/rockchip/rockchip.rst                    |  57 +-
 drivers/adc/rockchip-saradc.c                      |   2 +-
 drivers/clk/rockchip/clk_pll.c                     |  73 +--
 drivers/clk/rockchip/clk_rk3308.c                  |   9 +-
 drivers/clk/rockchip/clk_rk3506.c                  |   8 +-
 drivers/clk/rockchip/clk_rk3528.c                  |  23 +-
 drivers/clk/rockchip/clk_rk3568.c                  |  21 +-
 drivers/clk/rockchip/clk_rk3576.c                  |  44 +-
 drivers/clk/rockchip/clk_rk3588.c                  |  49 +-
 drivers/clk/rockchip/clk_rv1126.c                  |   9 -
 dts/upstream/Bindings/arm/rockchip.yaml            |  12 +-
 .../src/arm64/rockchip/rk3528-nanopi-r28s.dts      | 160 +++++
 .../src/arm64/rockchip/rk3528-nanopi-zero2.dts     | 290 +--------
 dts/upstream/src/arm64/rockchip/rk3528-nanopi.dtsi | 291 +++++++++
 scripts/pylint.base                                |   1 -
 tools/rkimage.c                                    |   5 +-
 tools/rkmux.py                                     | 218 -------
 tools/rksd.c                                       |   2 -
 tools/rkspi.c                                      |   2 -
 41 files changed, 727 insertions(+), 1407 deletions(-)
 create mode 100644 arch/arm/dts/rk3528-nanopi-r28s-u-boot.dtsi
 create mode 100644 arch/arm/dts/rk3528-nanopi-u-boot.dtsi
 create mode 100644 board/friendlyelec/nanopi-rk3528/Kconfig
 create mode 100644 board/friendlyelec/nanopi-rk3528/MAINTAINERS
 create mode 100644 board/friendlyelec/nanopi-rk3528/Makefile
 create mode 100644 board/friendlyelec/nanopi-rk3528/nanopi-rk3528.c
 delete mode 100644 doc/README.rockchip
 create mode 100644 dts/upstream/src/arm64/rockchip/rk3528-nanopi-r28s.dts
 create mode 100644 dts/upstream/src/arm64/rockchip/rk3528-nanopi.dtsi
 delete mode 100755 tools/rkmux.py
