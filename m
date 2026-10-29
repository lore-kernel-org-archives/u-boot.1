Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F69606A31C
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 22:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=LiIlxwlK;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=SS7NTWJw
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7766B81095;
	Thu, 29 Oct 2026 22:35:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ohfMsntCUxsh; Thu, 29 Oct 2026 22:35:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4EDFC81082
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793313342;
	b=A2eRMqo/jJdKtzRd8xZcq02Vkd5h+YA3KfoeU6/5Se99IYQh37vve0cDAb05s/DfvVzF
	 ViZAc/s33SAdtqK0m9CyEYa/95cWKI35P+rFF7tq5IUjjB896gDx5Wo68VKfwDym2Vx5o
	 s5GEqSqJyjg8Ywbe7RS/wYx/jSzT+CN0Y0EonG8ZvEQ2c8MTao6Pse177N57GBWl0Rfb4
	 cSt+dRTOebmZfddOxcfONpd4uyRidENF8D7N1gMCu4PmB53soBMkubOnV5piE+Wj0I4Fv
	 y6xtF/HJf3oVUzf37UPhU/6xsg8xMfQnu6MT3NhxHa3MiTnUfVS0CyXKzHV+CvsBP4Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793313342;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=dnDAJZA0y0VNqxS1TI4MunjNHuyp+Y0UcpZbMl/twQE=;
	b=l7xwU0YzmdimTeXgOOHYEcvsI4Z0/HMvMxef0DhGRk2O5/0xskABDGB5G1rLtGVRx58p
	 mvX1PWBCSJtNIsaCE7Bpono3Jkh0fqT5NHDv6Xeb+7q3pXE9c+HaDKBrytY5sJkofs82N
	 eJd6C87e+mfDnTfJ0DQvyueZU56mvrSKeBLhKHKRDAQ18I1sU7KoW3DCu56Eyvsaz15cl
	 BW3WmC//f3S5jIwtAo39vB3AhuqVBnakDMXxHAMzjtZWzvOaQi93zDYJr3hAsSvFSFuqx
	 z4ZtCksKRt0B1yW8+aSytIkS7TRXjhr5DYNIy1DvpWMDiHlm3V5X2r+gRF6Jbbg1gJA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793313342;
	bh=dnDAJZA0y0VNqxS1TI4MunjNHuyp+Y0UcpZbMl/twQE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LiIlxwlKC8Xckgy4JBCQ7XayqYFxruzAqOLaRjiDUUJ8b9VpULbtVi2Vwldj6dFd5
	 +h1r8zP12Eb4FfZse7EoHN6Iqmpv6l7HcABjszFHXP3M3L6z15I2v1purEhJqE4s13
	 lijZ7rREGTHQfYqlcexpv9jmiV+8btzC9DXfLBu+Gm0rOkDJrXlSrjTjQS8sm5v+Px
	 sxb/krQDF1PsNRacEfj9wMYnPnECd0VuJJnLxRs+Nv8zAWub4GDfdVB9IXLJsaBLNX
	 8lDsGmyFfHB2nF5i1EhYnL5OF4MKfB1QTAimPYJjluAGm0gh0bcsU8T6e+To9mpG4h
	 BdrpHEmkaUvjg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4EDFC81082;
	Thu, 29 Oct 2026 22:35:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6A65B362
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 22:35:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4F1BB40A82
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 22:35:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TLObnkc6kMU5 for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 22:35:39 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 9121440A80
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::329"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793313339;
 b=SXB8BOOz6jiFkTlOHIipgyn5Pb/OIYuMpUAxDsAZsqASz/bNQ8AQbvwatPyViK49kBbt
 UVWbdFJt8R1E3LMBjgt9fKvHOAB3eUw8ZxsS3CAr7L82obCL0oSOpcLky4xteeHGlEzKt
 0RFO3R9AUO2ERyD+0Y2z2lB92/wT2hV2BEAhVW2gIqsd8Q9cxKtJ1QQulV/0iUQJWr6nF
 TVuSz/7S9a/GAEJNzz3d34JWTrIOIwQSnwhIdnXbfyPkSx7VOKAMgcUbSVMniXQcN2fSe
 a2ODOkzUMm3wIpxsNdXQJ7oOOmCmpwx5xAvxFwmkjcvW7JuqjjLHuJaH6C7doDhQpMQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793313339;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=dnDAJZA0y0VNqxS1TI4MunjNHuyp+Y0UcpZbMl/twQE=;
 b=FImh1ABL1njLvzK+ePZzxKnDYMEEiqoI634e65/GvrZqnw8pll8xahZg6Doxf/V0SzXF
 mvujahriW+vkaCQdzlWX3Ue7KEQv/9gR6Mcss/UJpRzZ/hF51oWh+92rl4vNt+Drti9th
 0taQ96d/UeBbbomLtqSfrvqUeHzRQyS5xbyJKWamsRkHmXmz1ce9UBKhWATrsnFILZ3y/
 WgSlHeXduC+qlFibwRdNK75zujIUWCaE68paNSfIBQB+Kj5Tq3PTUck8wmUDxTPxHBdY6
 garyKPsV0Fe214JCT/Hp7e4yz1jyRzLHtD2CakoO6y7awwv9TVM+1MHjNggMGcXEIKg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=linaro.org;
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=SS7NTWJw; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::329"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::329; helo=mail-wm1-x329.google.com;
 envelope-from=casey.connolly@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=SS7NTWJw
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9121440A80
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 22:35:38 +0000 (UTC)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4a3517554f7so497045e9.2
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 15:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1793313336; x=1793918136;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dnDAJZA0y0VNqxS1TI4MunjNHuyp+Y0UcpZbMl/twQE=;
 b=SS7NTWJw4b4F4Z++3KwXFWW/TGdMQGqafbyInkbCtFimd6VDVLCG63UgdAH04XTUwW
 kvp6Ns6/iyyUSmKuIp+GE+pVv6A8fhEnsD23KpBwxnBHmOj7w4KMhLOBzPPRG2YhsLjy
 lQKLP9VQWw5g46PStMid4rHr3xZKQUD4l08zcMNI9qh91J5kTy5YKvxjplL3FI0VJEw2
 sbg9GlcKeGIdoe2/d6Ke1BqEx+rJQ4GA3UwxI1lfpGzxw1K2N4WqhD+XA00X1op1H8GC
 k55rlDj0njMGOUSVtbhbTkmZpgjeDdrqJlN1IyonJXxu/gwe18nmUcBxcSYQajCoZpom
 S5dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793313336; x=1793918136;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=dnDAJZA0y0VNqxS1TI4MunjNHuyp+Y0UcpZbMl/twQE=;
 b=qKBb0eWc0B3dateJO3/+Kn9ERcOguXTzzKPHrc7K1UWxJC7aa2JO2EqIUH74ZkU/8k
 kVnPJupQBVehIvjOuVVbmo+oRX45zkJq7yYl7TItndexldX7/CZOXwETx+iPkHZpCdoj
 0ptXJRi7MEFANdmNGOSvPK6pchjGTtFfbGKM17wjrsNGtlkiTs62nK5LUcGiLV7j8HuS
 +Czp7qZQpzZRKEkzYUbWsAK1E5EjNRelAPIDcUawydymR9q1veZCoshXvZm9/nL5e5Nl
 MFpbXtvUuYQBuMrMG8pAmc3jxjgjkYph5cKsHvGzWowEFbuZPBREN6bQJok40Itgct+A
 OK8A==
X-Forwarded-Encrypted: i=1;
 AKwUvBzxk63qIF0HYG7wVcFFxl8gJnHPDp21OUGt9V7485tehvmqQGiiVBdzkS77Gei34ZZ1crcPPio=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKOZvG/HOWM4hAmsOIhQPO6rFT1kknCZyanFNy/Ob+TnX//Tg4a
 ugTYbqv/EH2LUyduTa9xPHn7hjjebIRy7Nbkf0xFJCTA6NiBx8Gg+CEo6cjW03SYulI=
X-Gm-Gg: AYBFou3ToLKRKL7t5z0XNizEDBZmNb/6XHFN8XQQTtteeVkMQvRCNEj9a0FDJOuC5Gh
 CLa322TyJFlSe7tH6fPnPS+gUA1RpMQZp6qczYsGPrI4JwnSifOcG4Elqkl8F8XXFer/gWUSRux
 2ITuvPRbn1c/pl9GIhBO3Qd2Rk4Vhg2+fCflkfVWhD7++le/9cWAIGZyVzgCYHpIQ3bIjEMXzNp
 rMrE6Ki2fYyF2Hnbu6/WlB6eRtX50oNLYR7BZRegJetNPz1J/8x/aO7g4FNmzgURDyMkA3jA/Kb
 VRpHe9c2IGVxKuDOfgd4MVwxiqzirIL3ktj4bGFCTI0GjZHGKohMnmSjqZBx3zNCIKGbjlINbc9
 0iMaE0Gc03Xs5IS90+3FEU6h0xWTgG+WyYGCzdBz5oUntWgXlPxpFqUY9Dp/HjHm9nn917gpVLy
 45EcWFuWMOE4RHrBQI87J1poFWW+d4BKBuyA5ob0xxTcsUZI2OkQJBKX+bUl5llKnc0hrFORYoO
 CDA+xiGTR5borcvxWlRQeppvh9xJ5OH/HwgDTrSBOsRNj6KFtZ5KoMwEWu4YAKf5Yg0Ypgu/dxg
 FN4DGVrQ5P9WnW+Lrp2ZkcR6YLKygc1agQynYZGkPjyz6Gf9BeljUkvJjGJi/liGN/KMosSNqEG
 4VmQ=
X-Received: by 2002:a05:6000:1785:b0:48d:f14a:9182 with SMTP id
 ffacd0b85a97d-48e6e2e7536mr1797677f8f.20.1793313336236; 
 Thu, 29 Oct 2026 15:35:36 -0700 (PDT)
Received: from lion.tail248178.ts.net (p5b29ef1e.dip0.t-ipconnect.de.
 [91.41.239.30]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e712cc3e5sm107144f8f.39.2026.10.29.15.35.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 15:35:35 -0700 (PDT)
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
Date: Thu, 29 Oct 2026 23:33:44 +0100
Message-ID: <20261029223529.3031661-1-casey.connolly@linaro.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: 20261029003217.GE2677024@bill-the-cat
References: 
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

Resend without broken MMC patches

Sorry this missed -rc1.

The larger changes will follow (likely for -next unless there's some
folks are particularly keen to get in?).

* Add scsi_scan_new(), handle scsi scan in mach-snapdragon without relying on preboot
* Small docs cleanup
* SDM845 rpmh regulator and USB3 PHY support
* Support for switching to EL2 (replacing gunyah) via SMC call
* GENI UART minor RX fixes
* GENI minicore support (GENI QUPs which don't require firmware)
* Added proper support for various GDSC reset flags
* SDM845 pinctrl/clk fixes
* QMP USB phy orientation support
* Fix SMEM memory map not including some carveouts

* ufetch: fixed LBA size wrapping on 32-bit systems

The following changes since commit 03e45557e1f38a39a0c80fe30483130ff376cf92:

  Merge patch series "boot: image-fdt: fix reservation errors above ram_top" (2026-10-27 12:29:11 -0600)

are available in the Git repository at:

  https://git.u-boot-project.org/u-boot/custodians/u-boot-snapdragon.git qcom-main

for you to fetch changes up to 9e9d03456f5eb55d919207d395e4685fdb704380:

  clk: qcom: sdm845: add GCC_QUPV3_WRAP0_S4_CLK case (2026-10-29 19:33:15 +0100)

----------------------------------------------------------------
Alexey Minnekhanov (4):
      clk/qcom: Print more details about stuck GDSC
      clk/qcom: Import GDSC flags from Linux
      clk/qcom: Add newly added GDSC flags to all qcom clk drivers
      clk/qcom: Treat different GDSCs differently

Aswin Murugan (7):
      scsi: Add scsi_scan_new() to scan only new devices
      mach-snapdragon: rescan only newly added SCSI devices for capsule update
      mach-snapdragon: Add early EL2 hypervisor switch support
      configs: qualcomm: Add Gunyah exit config fragment
      configs: qcom_qcs9100: Enable Gunyah exit support
      mmc: msm_sdhci: fix max-frequency read into wrong-sized variable
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
 .../include/mach/gunyah_exit_boot0.h               |  36 ++
 arch/arm/mach-snapdragon/mem_map.c                 |   4 +
 board/qualcomm/default.env                         |   1 -
 board/qualcomm/exit-gunyah.config                  |   4 +
 cmd/ufetch.c                                       |   4 +-
 configs/qcm6490_defconfig                          |   4 +
 configs/qcom_defconfig                             |   1 +
 ...com_qcs8300_defconfig => qcom_monaco_defconfig} |   4 +-
 configs/qcom_qcs615_defconfig                      |  12 +
 configs/qcom_qcs9100_defconfig                     |   1 +
 doc/board/qualcomm/dragonwing.rst                  |  75 ++-
 doc/board/qualcomm/iq8.rst                         |   6 +-
 drivers/clk/clk-stub.c                             |   4 -
 drivers/clk/qcom/Kconfig                           |  13 +
 drivers/clk/qcom/Makefile                          |   1 +
 drivers/clk/qcom/clock-milos.c                     |   6 +-
 drivers/clk/qcom/clock-qcom.c                      |  62 ++-
 drivers/clk/qcom/clock-qcom.h                      |  20 +
 drivers/clk/qcom/clock-qcs8300.c                   | 547 ++++++++++++++++++++-
 drivers/clk/qcom/clock-rpmh.c                      |  62 +++
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
 drivers/misc/qcom_geni-minicore.c                  | 103 ++++
 drivers/misc/qcom_geni.c                           |  85 +++-
 drivers/mmc/msm_sdhci.c                            |   3 +-
 drivers/phy/qcom/phy-qcom-qmp-combo.c              | 203 +++++++-
 drivers/pinctrl/qcom/Kconfig                       |   8 +
 drivers/pinctrl/qcom/Makefile                      |   1 +
 drivers/pinctrl/qcom/pinctrl-qcs8300.c             | 468 ++++++++++++++++++
 drivers/pinctrl/qcom/pinctrl-sdm845.c              |  45 +-
 drivers/power/regulator/qcom-rpmh-regulator.c      | 137 ++++++
 drivers/scsi/scsi.c                                |  27 +
 drivers/serial/serial_msm_geni.c                   |  70 ++-
 include/scsi.h                                     |   8 +
 include/soc/qcom/geni-se.h                         |   5 +
 include/soc/qcom/minicore.h                        |  25 +
 57 files changed, 2076 insertions(+), 298 deletions(-)
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
