Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99460606A321
	for <u-boot@archiver.kernel.org>; Wed, 28 Oct 2026 20:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=IYuLLquy;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=wH6D2ucJ
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3650940826;
	Wed, 28 Oct 2026 20:56:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id k-krBpbJcNr0; Wed, 28 Oct 2026 20:56:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 04FB940814
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793220973;
	b=CK1rGzm/NY2xOn9KOvt1FqMqIbAO1oNFUSecAzmY/hjmuu4KVTWvrnrrDLI8VhCLZ5JU
	 omhYBprWTMeFlYiW43fSRRjjjyD3K8FEnHbQGC3bDoDwkgDcoPfYLdOPSFpmw8/ZGMLwQ
	 Edxgsvm2wR8mfPLH3cThGNX6ARlnUgiZeqehYTPihKuJR7ENwRwTIAEU1mSR88WaFsrbw
	 Ydjce3Kwl2tC5kQHRD+K43rbm6gqKd8n1eDxXg+cGaVm2j/cY342oi6kmihm9nvSR1avx
	 lrKRDLlVUEN/yB1K4tfMgtzeCm1RufND6lS1wDGhlD6fHrS++WtKBC0afffRi02K4Lw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793220973;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=eJH7MO/Vj+VO+v4840tjsB4xoRh4eLBgkADehIAYm/s=;
	b=A5rOvexxtQ1ogkEvcgEo3TR9BIeSZFyyRkWJwHHoWS6gfk6UQMPkkit6rgL9io9GmJtW
	 RRNxJ1YP4Oa40s6CXh9M7b7Ovg9CjVrGVciG9jOm22cLX5oH4OhfQqkPsQBbdfxitMFKn
	 O6wHXw27JES1+Az6nH4H2qNPfhayugaCoEMjY/lL/R5YznC/7a4LUnrA5Koi25X2spUcS
	 EyhL2svAH+afMsaodZrtzwyeOKUhWiO5q5ApNERpzjz9OvzAoioGKbgd8fcgI1OHJV2xq
	 YkNYXC1dZ2TPlUThMzJUdHx/Ufn/+tBcQ/ozUh62oz716JDrfwnYHE65hbAWnDs0TDQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793220973;
	bh=eJH7MO/Vj+VO+v4840tjsB4xoRh4eLBgkADehIAYm/s=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=IYuLLquykd/z2kQ6aiEa/0P07btV02WNQptWIDpCj1XebfubHDVuSpjkECpKHGSwt
	 UmhuBGU/uDR1jW0C/Qj9AdDic03GR/2hMgfnqqYw5r4pVLh2Fm2AVYxlwoO/8QNU1M
	 gGG+rMOGh7qFftSYES6mtQYBOZUPT3irL1vL6HWauofK2qegFYalDo9hLhK4/P3Sir
	 SO0tDdlGQtaQR+ysbg+/E0f78VquF1psV6CFi2nE3eTdgJMcH8XjKP2upc5qxtNNFI
	 JlDAnt+puV96rUskFKhuc4ZIy+ghd+nQh9kywx3JKD7c4x6GQKhJGxx1/CNioqO1bc
	 s49MEFgrRiqQg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 04FB940814;
	Wed, 28 Oct 2026 20:56:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 16ACB356
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 20:56:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id F0EE26061D
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 20:56:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mti33MAwKpTP for <u-boot@lists.u-boot-project.org>;
 Wed, 28 Oct 2026 20:56:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6EB2E605D8
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::333"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793220970;
 b=iz0v2e6Mrjhoh0Z9lkkaJndzZUyLS/qYYZsneakXo7PGvaex7z9WL909yNIualJ22wqi
 JC0gZEzlfP1gVRpZRijZWwE/kO+Y0xpXXqO/yy0Ud1uWxxAA2bmrwHFOfH48sbAaR1D9g
 lBut9OnC0YrqFQq/DlhgbXkWZlYPyTJpjvGrApARA9LGvEM0O+p7/LzNhL0pLfZfx92Qi
 lSuRbXqSCZ+f6v1H4YIWWOIh+soUUsc5WFpv7WLupLRXOCIbGXaVCSDOKcrExSwT5HIjq
 M0oaS4gxRr1cNJAMs7PIoXNTYsZ5ZEE5BnVLwVMPlHWg0j3d4ccdfuFc4rDlEOFLQxw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793220970;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Transfer-Encoding;
 bh=eJH7MO/Vj+VO+v4840tjsB4xoRh4eLBgkADehIAYm/s=;
 b=hXlimQ7F6cfMdTftNYb0y74DmircSHoEWHdr4f2JPJXid1VsrjCYew2vD1ZJdSxY6jiv
 uCKyAhRUwtLJqvqKQJCc58m5Ax3DZCPInrP0ky+UP15OR/xqTLTlrafn1qNL0ehRJjovf
 94CPhBvECi8NQ6yqjlMGk5kW4B71RwieGzLbiiL9Gy+EqYUGVmB860oaocbj7ZFwoMtWl
 EViEQNnRCrPf7GgiMxh8illAhReQ3fik7VPeWe0sA8xProi2YGzuLzGKSWapHW2HKyKA2
 wlwlpSLkImNq0LxwCWpNAG1RnRp7DMur1taWzSSAnsb80GL5daFZ+HBKLkI3b3htozA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=wH6D2ucJ; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::333"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::333; helo=mail-wm1-x333.google.com;
 envelope-from=casey.connolly@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=wH6D2ucJ
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6EB2E605D8
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 20:56:08 +0000 (UTC)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4a35a60499eso11745205e9.0
 for <u-boot@lists.u-boot-project.org>; Wed, 28 Oct 2026 13:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793220966; x=1793825766;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=eJH7MO/Vj+VO+v4840tjsB4xoRh4eLBgkADehIAYm/s=;
 b=wH6D2ucJnKnsJ0i0Mwzdsicb5dpd7nifM7CFPhG7L/vwTySbURuWerQfW3K9t5Gw1N
 c728IlXhfDGt9DMV2mnkePlLXw4B5w3IQuFAAj4rdzzOktJuISxJ0XrNbFIH1vhFTHET
 WmfnYoLGq7nU2gzyEmozRfENWgxQd+9bnjFnyA0k/ixdhKD9iYIIP3cOAk3T/ZYOJCZy
 KHx3l5BG1BDB5vJpoZaVydFtwab4rGxoB7Zqo4uR7HioyK1j/Hq72ZPbglz5HArNjnOD
 QPgwz7IkC08mt044uXd16RyVbhg7BSr6+w3xthLEqctYdjVCvLlRMLbz1oztVswOEhEl
 1yZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793220966; x=1793825766;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eJH7MO/Vj+VO+v4840tjsB4xoRh4eLBgkADehIAYm/s=;
 b=nklqing2CIfyJL8WKP30G6NCJunIpZe1FmB33bXNQo1IXoJuXCmPSqhNpxXbVZqAu+
 t65Dhejf0sRDXgYx4nI4ZCgy4oZKhqcwxrjrm+9kSACPEPY7NliIfRkRnivynREW2lF2
 t+nWF9Rj1fZ0GgJVVCHVLAKuaCSSjkJF1rUafjT8usxcoS4hPRgiFy+GipvMR6o1bcIQ
 8GcQgAtLydG/df13TDQiQ5sizLR10ZDh0EAlLuvPRigdWH3f3xT1Csg8Q4RLAJQlg54f
 Ja1EZbaEmkZLuMAHIkV5+mnOvl6t6psDnl+sxwIBPbfFXudJ+fS1J2phyhAXjnnGRgtq
 zWng==
X-Forwarded-Encrypted: i=1;
 AKwUvBzcfwYIjaNpZ1pnt3wmqIjg6CxTI0BlWgjJzkC/ysRgjP7x/8H1ZeWU7UxcRhn8iB5L4LaMS3Y=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIku85GSDWebk68dgsrXy4hFE4wY/1nPMuJeaoEzEUFL7B7uLhy
 3pZrrx0GXFErHgeJXbnXoa7RI2cESNQyt1m+mMuYAsZCGnPAwqR26rY+RFB4iWLzUsE=
X-Gm-Gg: AYBFou3uAyDcE22BdN0VHKnK50p15+MCHjAJE//TK2IiLvio8aUY18fyFGOn1YXf3l7
 LIrTyJSMpwIl8e1lm8VLc7TXBpxk9ityNQy8EZIfjUmnExmw2uqoXiz5HIjgUcqE0oEzeQJo9Fg
 GNgSD3NDO3hGXRxdgBMAis0mhb8e3yuhq973QBl92JFtfLCiE/pa+X7CfOfinP+czrPgBtmBZKt
 ntsLA3/wi81HcWAeDqL/Xp5UrSlXyX8gudYNk3NG1yxtXN5p4LwO8oNvm7WBJ6VTPXIu56OnIMW
 k5dLTOV3w5EQxO0qj9RAagCVX331hCvLzqNQ+Vv+y+IEAnkiVdPR3tsO2sjbCeEhhO/xh6GgpJl
 pudkdLaP9/9+STNCzO7WLwkyp/WBcDvJDi/IIMa/SSMW42HnT11u9Vl2dbpoQ/xpPd38ATV6Fi3
 eUkoW7fZb9fEaTQZw3w8BwPbg0zMUWjbriiC5jSfx4uW69Y6bobmSXITaIicUcoUga7REXvfEN1
 RuUx8iYMuVm74Zx2mXuwLocEcNjDBNZ2anvC4PD9fCKgmzuc9aEvgO2v/stz+V8EgZCkq6XFjUF
 CJqzBeVGhR+4BPeRaXr0FcCwxh4FYJA4sRpooWhFxOSIliSbEVdls6IHdlivDUOueLrVLiBbePO
 lP6c=
X-Received: by 2002:a05:600c:848c:b0:4a2:a6e:80f5 with SMTP id
 5b1f17b1804b1-4a96639b002mr90023895e9.11.1793220966526; 
 Wed, 28 Oct 2026 13:56:06 -0700 (PDT)
Received: from lion.tail248178.ts.net (p5b29ef1e.dip0.t-ipconnect.de.
 [91.41.239.30]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4aa7f3229dbsm15874085e9.1.2026.10.28.13.56.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 13:56:04 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
To: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org,
 u-boot-qcom@groups.io
Cc: Sumit Garg <sumit.garg@kernel.org>, neil.armstrong@linaro.org,
 Alexey Minnekhanov <alexeymin@minlexx.ru>,
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>,
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>,
 David Heidelberg <david@ixit.cz>, Francois Berder <fberder@outlook.fr>,
 Han Gao <gaohan@iscas.ac.cn>,
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
 Naveen Kumar Chaudhary <naveen.osdev@gmail.com>,
 Petr Hodina <petr.hodina@protonmail.com>,
 Casey Connolly <casey.connolly@linaro.org>
Subject: [PULL] Please pull qcom-main
Date: Wed, 28 Oct 2026 21:51:26 +0100
Message-ID: <20261028205507.1705522-2-casey.connolly@linaro.org>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Tom,

Sorry this missed -rc1.

The larger changes will follow (likely for -next unless there's some
folks are particularly keen to get in?).

* Add scsi_scan_new(), handle scsi scan in mach-snapdragon without relying on preboot
* Small docs cleanup
* MMC HS200/HS400 support
* SDM845 rpmh regulator and USB3 PHY support
* Support for switching to EL2 (replacing gunyah) via SMC call
* GENI UART minor RX fixes
* GENI minicore support (GENI QUPs which don't require firmware)
* Added proper support for various GDSC reset flags
* SDM845 pinctrl/clk fixes
* QMP USB phy orientation support
* Fix SMEM memory map not including some carveouts

* ufetch: fixed LBA size wrapping on 32-bit systems

Small rebase, CI run from before: https://git.u-boot-project.org/u-boot/custodians/u-boot-snapdragon/-/pipelines/1779

The following changes since commit 03e45557e1f38a39a0c80fe30483130ff376cf92:

  Merge patch series "boot: image-fdt: fix reservation errors above ram_top" (2026-10-27 12:29:11 -0600)

are available in the Git repository at:

  https://git.u-boot-project.org/u-boot/custodians/u-boot-snapdragon.git qcom-main

for you to fetch changes up to e7e12a59f96e5ff8b01c50dccbb9671ba5de245b:

  clk: qcom: sdm845: add GCC_QUPV3_WRAP0_S4_CLK case (2026-10-28 21:50:53 +0100)

----------------------------------------------------------------
Alexey Minnekhanov (4):
      clk/qcom: Print more details about stuck GDSC
      clk/qcom: Import GDSC flags from Linux
      clk/qcom: Add newly added GDSC flags to all qcom clk drivers
      clk/qcom: Treat different GDSCs differently

Aswin Murugan (9):
      scsi: Add scsi_scan_new() to scan only new devices
      mach-snapdragon: rescan only newly added SCSI devices for capsule update
      mach-snapdragon: Add early EL2 hypervisor switch support
      configs: qualcomm: Add Gunyah exit config fragment
      configs: qcom_qcs9100: Enable Gunyah exit support
      mmc: msm_sdhci: fix max-frequency read into wrong-sized variable
      mmc: msm_sdhci: add HS200/HS400 support
      configs: qcom: enable CONFIG_MMC_HS400_SUPPORT
      mach-snapdragon: smem: Use available_length for RAM partition v2+

Balaji Selvanathan (12):
      mach-snapdragon: scan SCSI devices in board_late_init()
      board: qualcomm: drop preboot from the default environment
      qcom: qcs615: disable SCSI and use MMC for fastboot
      qcom: qcs615: store environment in eMMC logfs partition
      doc: qcom: dragonwing: Improve build and installation documentation
      serial: msm_geni: fix RX FIFO init with proper cancel sequence
      clk: qcom: Add shared RPMH clock driver for SM8550/SM8650/SA8775P
      clk: qcom: qcs8300: Extend GCC clock driver to full gate/RCG coverage
      pinctrl: qcom: Add QCS8300 pinctrl driver
      configs: qcom_qcs8300: Switch to monaco-evk DT and enable new drivers
      configs: rename qcom_qcs8300_defconfig to qcom_monaco_defconfig
      clk: qcom: sc7280: enable shared RPMH clock driver

Balaji Selvanathan via U-Boot (1):
      phy: qcom: qmp-combo: honor USB-C orientation for port select

Casey Connolly (3):
      gpio: qcom_spmi_gpio: fix bias-pull-down
      gpio: qcom_spmi_gpio: add pmk8350/pm8350c
      dts: qcom: remove hardcoded memory maps

David Heidelberg (4):
      phy: qcom: qmp-combo: select PCS register offsets per version
      phy: qcom: qmp-combo: add SDM845 support
      power: regulator: qcom-rpmh: add PM8998 support
      configs: qcom: enable QMP USB3-DP combo PHY

Francois Berder (1):
      clk: qcom: Fix invalid usage of dev_read_addr

Han Gao (1):
      cmd: ufetch: avoid truncating storage sizes on 32-bit systems

Manivannan Sadhasivam (1):
      configs: qcm6490_defconfig: Enable SCSI as the Fastboot flash block interface

Naveen Kumar Chaudhary (2):
      serial: msm_geni: remove unreachable dead code in pending()
      serial: msm_geni: fix clock rate return type truncation

Petr Hodina (3):
      gpio: qcom_spmi_gpio: add qcom,pm8150l-gpio
      pinctrl: qcom: sdm845: select the mux value per pin
      clk: qcom: sdm845: add GCC_QUPV3_WRAP0_S4_CLK case

Varadarajan Narayanan via U-Boot (1):
      misc: qcom_geni: Add minicore support

 arch/arm/dts/ipq5424-rdp466-u-boot.dtsi            |   6 -
 arch/arm/dts/ipq9574-rdp433-u-boot.dtsi            |   9 -
 arch/arm/dts/qcs615-ride-u-boot.dtsi               |  14 -
 arch/arm/dts/qcs6490-rb3gen2-u-boot.dtsi           |  23 -
 arch/arm/dts/qcs8300-ride-u-boot.dtsi              |  19 -
 arch/arm/dts/qcs9100-ride-r3-u-boot.dtsi           |  20 -
 arch/arm/mach-snapdragon/Kconfig                   |   8 +
 arch/arm/mach-snapdragon/board.c                   |  10 +
 arch/arm/mach-snapdragon/capsule_update.c          |  12 +-
 arch/arm/mach-snapdragon/dram.c                    |   3 +-
 arch/arm/mach-snapdragon/include/mach/boot0.h      |   2 +
 .../include/mach/gunyah_exit_boot0.h               |  36 +
 arch/arm/mach-snapdragon/mem_map.c                 |   4 +
 board/qualcomm/default.env                         |   1 -
 board/qualcomm/exit-gunyah.config                  |   4 +
 cmd/ufetch.c                                       |   4 +-
 configs/qcm6490_defconfig                          |   4 +
 configs/qcom_defconfig                             |   2 +
 ...com_qcs8300_defconfig => qcom_monaco_defconfig} |   4 +-
 configs/qcom_qcs615_defconfig                      |  12 +
 configs/qcom_qcs9100_defconfig                     |   1 +
 doc/board/qualcomm/dragonwing.rst                  |  75 +-
 doc/board/qualcomm/iq8.rst                         |   6 +-
 drivers/clk/clk-stub.c                             |   4 -
 drivers/clk/qcom/Kconfig                           |  13 +
 drivers/clk/qcom/Makefile                          |   1 +
 drivers/clk/qcom/clock-milos.c                     |   6 +-
 drivers/clk/qcom/clock-qcom.c                      |  62 +-
 drivers/clk/qcom/clock-qcom.h                      |  20 +
 drivers/clk/qcom/clock-qcs8300.c                   | 547 ++++++++++++++-
 drivers/clk/qcom/clock-rpmh.c                      |  62 ++
 drivers/clk/qcom/clock-sa8775p.c                   |   4 +-
 drivers/clk/qcom/clock-sc7280.c                    |   8 +-
 drivers/clk/qcom/clock-sdm845.c                    |  52 +-
 drivers/clk/qcom/clock-sm6125.c                    |   8 +-
 drivers/clk/qcom/clock-sm6350.c                    |   4 +-
 drivers/clk/qcom/clock-sm8150.c                    |  14 +-
 drivers/clk/qcom/clock-sm8550.c                    |  16 +-
 drivers/clk/qcom/clock-sm8650.c                    |  16 +-
 drivers/clk/qcom/clock-x1e80100.c                  |  54 +-
 drivers/gpio/qcom_spmi_gpio.c                      |  10 +-
 drivers/misc/Kconfig                               |   6 +
 drivers/misc/Makefile                              |   1 +
 drivers/misc/qcom_geni-minicore.c                  | 103 +++
 drivers/misc/qcom_geni.c                           |  85 ++-
 drivers/mmc/Kconfig                                |   1 +
 drivers/mmc/msm_sdhci.c                            | 754 ++++++++++++++++++++-
 drivers/phy/qcom/phy-qcom-qmp-combo.c              | 203 +++++-
 drivers/pinctrl/qcom/Kconfig                       |   8 +
 drivers/pinctrl/qcom/Makefile                      |   1 +
 drivers/pinctrl/qcom/pinctrl-qcs8300.c             | 468 +++++++++++++
 drivers/pinctrl/qcom/pinctrl-sdm845.c              |  45 +-
 drivers/power/regulator/qcom-rpmh-regulator.c      | 137 ++++
 drivers/scsi/scsi.c                                |  27 +
 drivers/serial/serial_msm_geni.c                   |  70 +-
 include/scsi.h                                     |   8 +
 include/soc/qcom/geni-se.h                         |   5 +
 include/soc/qcom/minicore.h                        |  25 +
 58 files changed, 2828 insertions(+), 299 deletions(-)
 delete mode 100644 arch/arm/dts/qcs615-ride-u-boot.dtsi
 delete mode 100644 arch/arm/dts/qcs6490-rb3gen2-u-boot.dtsi
 delete mode 100644 arch/arm/dts/qcs8300-ride-u-boot.dtsi
 delete mode 100644 arch/arm/dts/qcs9100-ride-r3-u-boot.dtsi
 create mode 100644 arch/arm/mach-snapdragon/include/mach/gunyah_exit_boot0.h
 create mode 100644 board/qualcomm/exit-gunyah.config
 rename configs/{qcom_qcs8300_defconfig => qcom_monaco_defconfig} (83%)
 create mode 100644 drivers/clk/qcom/clock-rpmh.c
 create mode 100644 drivers/misc/qcom_geni-minicore.c
 create mode 100644 drivers/pinctrl/qcom/pinctrl-qcs8300.c
 create mode 100644 include/soc/qcom/minicore.h
