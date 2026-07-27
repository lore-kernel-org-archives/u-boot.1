Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B28EC53209
	for <u-boot@archiver.kernel.org>; Mon, 27 Jul 2026 21:34:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9B01840660;
	Mon, 27 Jul 2026 21:34:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uU3PPCt7wXi6; Mon, 27 Jul 2026 21:33:59 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8CB21407E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785188039;
	bh=vjbPIqJ/eR7O7uJLOQfnFQMOZnNiUN4Ayj7XTryt/1o=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=aam6UKM6MmpXasz0aF293AaKNJs9kmhcGzfns/wXIyp9HSD2qclEA9qLU/HjRFkv/
	 YNwZyxZzFNuQX/MkiFX+ioti3hVKBcvr76JNfKMvSfPuRmcOdy9NM20zya/zwoajj9
	 Gl7h9CjgJ8LN3YrPf6QUEOR01mMkm3H0xeHP3e96QyhjZ3zjYISizeMvJOu6nS2jZ/
	 jLqksdtCPFUeNOFeq6I+AN3iEdDfbQMSjFMUO5y0FsO6U7+rSIrZomfx3CMBIHv5Hz
	 SvcRkNoTqZc78wyAzNSktLFSdcNvseGc2DjnFo5I2vC4+oplmfahyzSul+ZiERW2qg
	 eTBaYMesQjRlw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8CB21407E0;
	Mon, 27 Jul 2026 21:33:59 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id E7623357
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 21:33:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CD82680F40
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 21:33:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sUGDFOUm15_o for <u-boot@lists.u-boot-project.org>;
 Mon, 27 Jul 2026 21:33:57 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1033; helo=mail-pj1-x1033.google.com;
 envelope-from=festevam@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org B600580F3E
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B600580F3E
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com
 [IPv6:2607:f8b0:4864:20::1033])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B600580F3E
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 21:33:57 +0000 (UTC)
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-382ef647e20so3248869a91.1
 for <u-boot@lists.u-boot-project.org>; Mon, 27 Jul 2026 14:33:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785188037; x=1785792837;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=vjbPIqJ/eR7O7uJLOQfnFQMOZnNiUN4Ayj7XTryt/1o=;
 b=ARcBfKRKYnDxXFmzizbHOrCBIdqZU+4/ytwzY3y8kWQVR5jd6aJPq/uv3LJJQ6+8g+
 7HXGrXCcAKI58ZhV4dCjh0l62K4olIEpW4tskZT8dAR1/7LrvVC8XGcCYh5PhFpOSBFI
 cnTh+wvidlJiyv3Ps0buYq/2O6aBtdyP6KKiMXEdMKi20KK+0ylsHuMM9hq+Ap0+an7+
 FAMLXcnUjKFs2It2pY4vrwhMvb9Eb9Ba+5vLUpUZ6lxMdec8m/yZstTjP+4BjzBwktoS
 oFpFVwlT6Aw937Yeah0ok9Q8ZOqgtIC/lG1R5cnsHTcQnC4hMXaXthAQLHB3XEBq5uXC
 olIA==
X-Gm-Message-State: AOJu0YwnA55GeHPFEDdfyqTBjdkE4DyMW9+fsoD/WfHLK9etKBDODe0a
 A26DgKIvs3O6wY2n6noocDkTA8IfV5tSGGzrrSMvIrJ1mB5Ll7HF56cR
X-Gm-Gg: AR+sD13OfM9Kd1fENxNmvwB1fT3hiCZh+jaj/3uBjiNifkpIeq+w2sUeHx+1r00WR1m
 uIkhkkuxQ0OAH2nQhn5Yf+gHYakL0ZVTpUtteJ+j8KOOSTDs2z0mcBb2bSi82nyO7c7mRaQppFU
 V8Uee6pVYdxYKeRFAKC+rHQdjw+LwVtae1792mE4R5qLoKpdrztvmvmHCyY+gXRetTg7zdKSDs7
 qCshw8WJbl5EAoLyE2eytCz3VcUvh+7R4BYZQKiUqHkxkXxUytr5Ajky+IaVumjCBoChaU9iYJu
 W50r5ZU571mJGScUvydQ0vgWntpLNSwxaFAN28eq3f2ikv13VHBdNH4+qf/9MtxtxP+VULSBNDP
 g7IEbG2KnO+M4AnV8F0L4V67Bl9zMCdtXQS2Z+gDBMUbsbvrZuFz77TkR4b7O6SLq6ltl/PfQN+
 xL+8fgRkPllghdCyAn88A8FbxGBpnNKSrJiPP83a1AdUc7LjLOFYs=
X-Received: by 2002:a17:90b:1e0d:b0:38e:dc4:3f64 with SMTP id
 98e67ed59e1d1-38f29784460mr8621864a91.38.1785188036638; 
 Mon, 27 Jul 2026 14:33:56 -0700 (PDT)
Received: from fabio-X870-EAGLE-WIFI7..
 ([2804:1b3:a801:60b4:21e4:da15:d321:6b72])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13e52f0c6f2sm29640388c88.11.2026.07.27.14.33.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 14:33:56 -0700 (PDT)
From: Fabio Estevam <festevam@gmail.com>
To: trini@konsulko.com
Cc: u-boot@lists.u-boot-project.org, chris@kleiner.pro, uboot-imx@nxp.com,
 Max.Merchel@ew.tq-group.com, emanuele.ghidoli@toradex.com, agx@sigxcpu.org,
 marex@nabladev.com, mathieu.dubois-briand@bootlin.com,
 shofiqtest@gmail.com, vitor.soares@toradex.com
Subject: [GIT PULL] Please pull u-boot-imx-main-20260727
Date: Mon, 27 Jul 2026 18:33:49 -0300
Message-ID: <20260727213351.2603837-1-festevam@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785188037; x=1785792837;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vjbPIqJ/eR7O7uJLOQfnFQMOZnNiUN4Ayj7XTryt/1o=;
 b=CldOC/+7Kx41kH3ro5PZRuHXNOvg5b3oYSYL2rw1a+NJnT5aAR0v4RnN8GbxjNRogs
 xflcVhO9ZXDvq+wLI8Ns9ct4fW7ikSVWMc/Nz74FelUN5IAdXzKNf8mAtheTO4/4llbZ
 H/8qelm9PN/hbLTxiDlWOLAtzpGHdnZFARWgj3I3uwyigjf99PbMSO2/NN0DHdawlPJF
 i40Y2ebjl7PZz9AtHzjATnmk0TSEhVfsa/9E/2itxYHc+p0Yoz9qDNF7fdhKPlA+PFZP
 eo6P1LLp++AJ24A0wWRBFqGHNjyy4VQAOFzFFFVnj5ena8O8VRb9TEQDGgFQUKJ4M7Ji
 7Qgw==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=CldOC/+7
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

Hi Tom,

Please pull from u-boot-imx/main, thanks.

The following changes since commit 574b1adad70a19d95c65e0f37f9c36d94fb5418f:

  fit: prefer the default configuration on best-match ties (2026-07-24 10:46:16 -0600)

are available in the Git repository at:

  https://git.u-boot-project.org/u-boot/custodians/u-boot-imx.git tags/u-boot-imx-main-20260727

for you to fetch changes up to ce5793d777fd1f5bb6b0448c6366ba989c4a3509:

  board: gateworks: fsa: bound FSA EEPROM gpio descriptor count (2026-07-27 13:05:07 -0300)


u-boot-imx-main-20260727
------------------------

CI: https://git.u-boot-project.org/u-boot/custodians/u-boot-imx/-/pipelines/749

- Support authenticating signed Mcore container image on i.MX9.
- Support booting CM70, CM71 and CM33 sync cores on i.MX9.
- Add i.MX SNVS RTC driver.
- Detect RAM sizes on Toradex smarc and aquila i.MX95 boards.
- Add support for the Librem5 devkit.
- Subtract half a cycle instead of three quarters of a cycle after DQS gating calibration
on i.Mx6.
- Several tqma6 improvements.
- Add product ID support for new Toradex boards.
----------------------------------------------------------------
Alexander Feilke (1):
      configs: tqma6ul: add support for redundant environment

Alexander Koch (1):
      rtc: snvs: Add i.MX SNVS RTC driver

Alice Guo (1):
      imx9: bootaux: Support booting CM70, CM71 and CM33 sync cores

Christopher Kleiner (1):
      board: gateworks: fsa: bound FSA EEPROM gpio descriptor count

Emanuele Ghidoli (2):
      board: toradex: smarc-imx95: detect RAM sizes
      board: toradex: aquila-imx95: detect RAM sizes

Guido Günther (1):
      board: purism: Add support for the Librem5 devkit

Marek Vasut (6):
      mx6: ddr: Subtract half a cycle instead of three quarters of a cycle after DQS gating calibration
      arm64: dts: imx8m: Reinstate TEE ifdeffery
      binman: imx8mimage: Generate FSPI header in binman instead of mkimage
      arm64: dts: imx8mm: Drop nxp,fspi-header-filename
      arm64: dts: imx8mn: Drop nxp,fspi-header-filename
      arm64: imx: Handle both MMC2 and SD2 boot devices on Data Modul i.MX8M Mini eDM SBC

Markus Niebel (2):
      board: tqma6: change U-Boot device tree fragments
      board: tqma6: implement ENET errata workaround detection

Mathieu Dubois-Briand (1):
      imx93_frdm: Add OP-TEE device tree node

Max Merchel (7):
      sysinfo: tq_eeprom: select NVMEM
      arm: dts: tqma6ul: add eeprom nvmem-layout
      arm: dts: tqma6ul: integrate tq,eeprom sysinfo driver
      boards: tqma6ul: select TQ_COMMON_SYSINFO
      ARM: dts: tqma6: add boot phase properties
      dts: tqma6: mba6: remove old device trees
      board: tqma6: use runtime SoC detection in enet setup

Md Shofiqul Islam (1):
      ge: common: vpd_reader: fix errloc array size in verify_bch()

Paul Gerber (1):
      board: tqma6: add kernel device tree handling for environment

Peng Fan (1):
      imx9: scmi: reset GPIO2 according its node status

Vitor Soares (7):
      toradex: tdx-cfg-block: Add smarc imx95 0229 pid4
      toradex: tdx-cfg-block: Add aquila tda4 0230 pid4
      toradex: tdx-cfg-block: Add apalis imx8qm 64gb emmc pid4s
      toradex: tdx-cfg-block: Add verdin imx8mp 64gb emmc pid4s
      toradex: tdx-cfg-block: Add verdin imx8mm 0239 pid4
      toradex: tdx-cfg-block: Add smarc imx8mp 0240 pid4
      toradex: tdx-cfg-block: Add verdin am62 0242 pid4

Ye Li (4):
      imx9: bootaux: Support authenticate signed Mcore container image
      imx9{4, 5, 52}_evk: power on mcore according to SM config
      arm: dts: imx943-evk: Add label for gpio expander devices
      imx9: scmi: Update get mac from fuse for iMX952

 arch/arm/dts/imx6dl-mba6.dtsi                      |  22 -
 arch/arm/dts/imx6dl-mba6a-u-boot.dtsi              |   8 +
 arch/arm/dts/imx6dl-mba6a.dts                      |  21 -
 arch/arm/dts/imx6dl-mba6b-u-boot.dtsi              |   7 +-
 arch/arm/dts/imx6q-mba6.dtsi                       |  44 -
 arch/arm/dts/imx6q-mba6a-u-boot.dtsi               |   8 +
 arch/arm/dts/imx6q-mba6a.dts                       |  20 -
 arch/arm/dts/imx6q-mba6b-u-boot.dtsi               |   7 +-
 arch/arm/dts/imx6qdl-mba6-u-boot.dtsi              |  37 +-
 arch/arm/dts/imx6qdl-mba6.dtsi                     | 535 ------------
 arch/arm/dts/imx6qdl-mba6a.dtsi                    |  30 -
 arch/arm/dts/imx6qdl-mba6b.dtsi                    |  49 --
 arch/arm/dts/imx6qdl-tqma6-u-boot.dtsi             |  54 ++
 arch/arm/dts/imx6qdl-tqma6a-u-boot.dtsi            |  14 +
 arch/arm/dts/imx6qdl-tqma6b-u-boot.dtsi            |  18 +
 arch/arm/dts/imx6ul-tqma6ul-common-u-boot.dtsi     |  18 +
 arch/arm/dts/imx8mm-u-boot.dtsi                    |   7 +-
 arch/arm/dts/imx8mn-u-boot.dtsi                    |   7 +-
 arch/arm/dts/imx8mp-u-boot.dtsi                    |   6 +
 arch/arm/dts/imx8mq-librem5-devkit-u-boot.dtsi     |  11 +
 arch/arm/dts/imx8mq-u-boot.dtsi                    |   6 +
 arch/arm/dts/imx93-11x11-frdm-u-boot.dtsi          |   7 +
 arch/arm/dts/imx943-evk-u-boot.dtsi                |  28 +
 arch/arm/include/asm/arch-imx9/imx-regs.h          |  30 +
 arch/arm/include/asm/arch-imx9/sys_proto.h         |   2 +
 arch/arm/mach-imx/imx8m/Kconfig                    |   7 +
 arch/arm/mach-imx/imx9/imx_bootaux.c               | 355 +++++++-
 arch/arm/mach-imx/imx9/scmi/soc.c                  | 164 +++-
 arch/arm/mach-imx/mx6/Kconfig                      |   1 +
 arch/arm/mach-imx/mx6/ddr.c                        |   4 +-
 board/data_modul/imx8mm_edm_sbc/spl.c              |   2 +-
 board/gateworks/fsa.c                              |   8 +
 board/ge/common/vpd_reader.c                       |   2 +-
 board/nxp/imx94_evk/imx94_evk.c                    |   3 +
 board/nxp/imx952_evk/imx952_evk.c                  |   3 +
 board/nxp/imx95_evk/imx95_evk.c                    |   8 +
 board/purism/librem5-devkit/Kconfig                |  18 +
 board/purism/librem5-devkit/MAINTAINERS            |   8 +
 board/purism/librem5-devkit/Makefile               |  13 +
 .../purism/librem5-devkit/imximage-8mq-lpddr4.cfg  |   9 +
 board/purism/librem5-devkit/librem5-devkit.c       |  77 ++
 board/purism/librem5-devkit/librem5-devkit.env     |  20 +
 board/purism/librem5-devkit/lpddr4_timing.c        | 931 +++++++++++++++++++++
 board/purism/librem5-devkit/lpddr4_timing_b0.c     | 794 ++++++++++++++++++
 board/purism/librem5-devkit/spl.c                  | 371 ++++++++
 board/toradex/aquila-imx95/aquila-imx95.c          |  23 +-
 board/toradex/common/tdx-cfg-block.c               |  11 +
 board/toradex/common/tdx-cfg-block.h               |  11 +
 board/toradex/smarc-imx95/smarc-imx95.c            |  23 +-
 board/toradex/verdin-am62/verdin-am62.c            |   3 +-
 board/toradex/verdin-imx8mm/verdin-imx8mm.c        |   3 +-
 board/toradex/verdin-imx8mp/verdin-imx8mp.c        |   4 +-
 board/tq/tqma6/tqma6.c                             |  86 +-
 board/tq/tqma6/tqma6.h                             |  14 +
 board/tq/tqma6/tqma6_mba6.c                        |  33 +-
 configs/imx95_evk.config                           |   2 +-
 configs/librem5-devkit_defconfig                   | 183 ++++
 configs/tqma6ul_common.config                      |   2 +
 doc/board/purism/index.rst                         |   1 +
 doc/board/purism/librem5-devkit.rst                |  56 ++
 drivers/rtc/Kconfig                                |   7 +
 drivers/rtc/Makefile                               |   1 +
 drivers/rtc/snvs-rtc.c                             | 118 +++
 drivers/sysinfo/Kconfig                            |   1 +
 include/configs/aquila-imx95.h                     |  15 +-
 include/configs/librem5-devkit.h                   |  36 +
 include/configs/toradex-smarc-imx95.h              |  15 +-
 include/imx_sip.h                                  |   2 +
 include/scmi_nxp_protocols.h                       |  11 +
 tools/binman/etype/nxp_imx8mimage.py               |  95 ++-
 tools/binman/ftest.py                              |  23 +-
 tools/binman/test/vendor/nxp_imx8m_fspi.dts        |   1 -
 .../nxp_imx8m_fspi_fail_columnadresswidth.dts      |  19 +
 ...fail.dts => nxp_imx8m_fspi_fail_devicetype.dts} |   3 +-
 .../vendor/nxp_imx8m_fspi_fail_flashpadtype.dts    |  19 +
 .../nxp_imx8m_fspi_fail_readsampleclksrc.dts       |  19 +
 .../vendor/nxp_imx8m_fspi_fail_serialclkfreq.dts   |  19 +
 tools/binman/test/vendor/nxp_imx8m_fspi_pass.dts   |   1 -
 78 files changed, 3837 insertions(+), 817 deletions(-)
 delete mode 100644 arch/arm/dts/imx6dl-mba6.dtsi
 create mode 100644 arch/arm/dts/imx6dl-mba6a-u-boot.dtsi
 delete mode 100644 arch/arm/dts/imx6dl-mba6a.dts
 delete mode 100644 arch/arm/dts/imx6q-mba6.dtsi
 create mode 100644 arch/arm/dts/imx6q-mba6a-u-boot.dtsi
 delete mode 100644 arch/arm/dts/imx6q-mba6a.dts
 delete mode 100644 arch/arm/dts/imx6qdl-mba6.dtsi
 delete mode 100644 arch/arm/dts/imx6qdl-mba6a.dtsi
 delete mode 100644 arch/arm/dts/imx6qdl-mba6b.dtsi
 create mode 100644 arch/arm/dts/imx6qdl-tqma6-u-boot.dtsi
 create mode 100644 arch/arm/dts/imx6qdl-tqma6a-u-boot.dtsi
 create mode 100644 arch/arm/dts/imx6qdl-tqma6b-u-boot.dtsi
 create mode 100644 arch/arm/dts/imx8mq-librem5-devkit-u-boot.dtsi
 create mode 100644 board/purism/librem5-devkit/Kconfig
 create mode 100644 board/purism/librem5-devkit/MAINTAINERS
 create mode 100644 board/purism/librem5-devkit/Makefile
 create mode 100644 board/purism/librem5-devkit/imximage-8mq-lpddr4.cfg
 create mode 100644 board/purism/librem5-devkit/librem5-devkit.c
 create mode 100644 board/purism/librem5-devkit/librem5-devkit.env
 create mode 100644 board/purism/librem5-devkit/lpddr4_timing.c
 create mode 100644 board/purism/librem5-devkit/lpddr4_timing_b0.c
 create mode 100644 board/purism/librem5-devkit/spl.c
 create mode 100644 board/tq/tqma6/tqma6.h
 create mode 100644 configs/librem5-devkit_defconfig
 create mode 100644 doc/board/purism/librem5-devkit.rst
 create mode 100644 drivers/rtc/snvs-rtc.c
 create mode 100644 include/configs/librem5-devkit.h
 create mode 100644 tools/binman/test/vendor/nxp_imx8m_fspi_fail_columnadresswidth.dts
 rename tools/binman/test/vendor/{nxp_imx8m_fspi_fail.dts => nxp_imx8m_fspi_fail_devicetype.dts} (83%)
 create mode 100644 tools/binman/test/vendor/nxp_imx8m_fspi_fail_flashpadtype.dts
 create mode 100644 tools/binman/test/vendor/nxp_imx8m_fspi_fail_readsampleclksrc.dts
 create mode 100644 tools/binman/test/vendor/nxp_imx8m_fspi_fail_serialclkfreq.dts
