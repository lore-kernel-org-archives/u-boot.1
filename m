Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08CE3C7115B
	for <u-boot@archiver.kernel.org>; Mon, 23 Jun 2025 23:51:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4E8C182EAA;
	Tue, 24 Jun 2025 01:49:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yI9QB32W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4FBE182E5A; Tue, 24 Jun 2025 01:49:45 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BE7B382E9F
 for <u-boot@lists.denx.de>; Tue, 24 Jun 2025 01:49:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-45348bff79fso52226515e9.2
 for <u-boot@lists.denx.de>; Mon, 23 Jun 2025 16:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750722582; x=1751327382; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wQ83s0WW+Z5OpsdExE0EF7Pa3hLkcW5X8rgOtcglJqU=;
 b=yI9QB32WJHDzOaQxAXx9p2JjnobFR6uUBSNeI1SjYhTUjgs+mM5zn8TXEKrdDI4slW
 iUDVzi3nQT7zkIxi3is300pKIxf3BZ95rPko2BpKe7MI5p5eoKIzsHlqwHf3IMwv3XgY
 iUZLdy6lb2qizJtnEqxZHgdWhEcroZ+jbFOLsWuL1YPf6wxZ7Zrh0U+sZG8evVMbQI2f
 eJUG8ilG4q+mRJ2mBbT5mm3LsTqCi/lACLodnxOCrqukWnjOWizV0+nFihp+v7Zq5fJB
 hbPllWCisZOkAkHKsk7qdfhuPJIKBI1avpDQTcKNa6ET8uTh4H4optRbO3ouTjGHKAjW
 EjWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750722582; x=1751327382;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wQ83s0WW+Z5OpsdExE0EF7Pa3hLkcW5X8rgOtcglJqU=;
 b=l1TmWv3lxLClsy3qcKSpfVMrd1LqIrQCGhIsf2akY0gs1tl1EFSNDxVzCcmChKqi7y
 6d3pchOYZunqoprLrelUdpotOb3Gvr8VFcFFUbsw5ncheNILK67p1kbuwSuCskzGObM8
 oj2YfKJvNTmy7LlGYxvQRa4FSZSemZZleS4yQkVb2tHMJKnrW2v0gmFo8lZeXO2rZ5oz
 RUBqORkJYtBM6quaNxWgqDbdSNIt2UBOwwK2OEuIybcxyuLzpm1k9dT6P/SknJwNMZx8
 Q0AAD6CdRZvmq1tmLOxGKbDzGUXtDtSg9f7YaUkfKf7Nm+dElyF1qW71DLN/1g8V6KxP
 YLMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVqzXqOX5DSDl5Lv5a0BAAiyBYGV1HsgI5GqdtG1jcuLEyXcZ9VtELxtKitc/ybvyyf/y1OYsE=@lists.denx.de
X-Gm-Message-State: AOJu0YwUZnIogsZaL5MYggIDxGw2oNC2N+TKPrYqaMeguS5Vzht3TmGk
 uLogD33xRMp8iWXWSvxE4hZBAeF7kxH/B2X1lM3+RJ9Gnw1hMSFPtjS3dusMHf8w38w=
X-Gm-Gg: ASbGncvSs/yGPn9f0JDpwMEirk2HUdN1jGCVBiRR81MQ8S8L05zATnLt76pMXi8EYqA
 szA1A9uPevefKwwnzOhzeJ2SUFoUFTlx+4hpzGQPc0U3xW+tLAgdQSP5nI8HOCd4m/G5DUOmPgE
 9c4o4yP8mmgppoTeo9HHpq6nwjnyDLMkELMxGeZH6sm8Dq3g889N6tBawb1YQrbC675XyZXYUqR
 FuCYbsVndn2eyj/nMXoxH8tswAMJF5Svr/LaGEFM3Vz2vGd6osUZGGReux3QGlLyvmsM7mW1R6q
 B+iXzp33zjfbcbBRDHs4VaL4rJnwWTb+wa1n0MJ+iRW5/y6smkfCKWMKehJbIv5kCqnFoJCJPZs
 fcfnt3B3+dME=
X-Google-Smtp-Source: AGHT+IH12GEIkILGKIAacwjDUYyvVgbJtnHD2QKnFisRGLRCSuDZGctDIGuP23SGqa7ykFJNnHXe3A==
X-Received: by 2002:a05:6000:2c0d:b0:3a4:ef70:e0e1 with SMTP id
 ffacd0b85a97d-3a6d13321d3mr12316644f8f.55.1750722582175; 
 Mon, 23 Jun 2025 16:49:42 -0700 (PDT)
Received: from toyger.tail248178.ts.net ([213.240.182.16])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6e7fb5716sm432284f8f.0.2025.06.23.16.49.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Jun 2025 16:49:41 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
To: trini@konsulko.com, neil.armstrong@linaro.org, sumit.garg@kernel.org, 
 lukma@denx.de, seanga2@gmail.com, ilias.apalodimas@linaro.org, 
 me@samcday.com, christopher.obbard@linaro.org, quic_varada@quicinc.com, 
 sughosh.ganu@linaro.org, sjg@chromium.org, lehmanju@devpi.de, 
 bhupesh.linux@gmail.com, u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>
Cc: Balaji Selvanathan <quic_bselvana@quicinc.com>
In-Reply-To: <20250529154931.1879976-1-quic_bselvana@quicinc.com>
References: <20250529154931.1879976-1-quic_bselvana@quicinc.com>
Subject: Re: [PATCH v4 0/6] Introduce support for QCS8300 SoC based IQ8
 Series Platform
Message-Id: <175072258049.128390.12186985473033447273.b4-ty@linaro.org>
Date: Tue, 24 Jun 2025 01:49:40 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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


On Thu, 29 May 2025 21:19:25 +0530, Balaji Selvanathan wrote:
> These patches introduce the initial support code needed
> for the Qualcomm Dragonwing QCS8300 SoC based IQ8 Series Platform.
> For information on supported boards and build instructions please
> refer to doc/board/qualcomm/dragonwing.rst file.
> 
> Please see [1] for SoC related details
> 
> [...]

Applied, thanks!

[1/6] doc: board: qualcomm: document Dragonwing board building/flashing
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/3400b06c9bb5
[2/6] dts: qcs8300-ride-u-boot.dtsi: Add memory entry to bootup
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/d4efc04d283d
[3/6] clk/qcom: qcs8300: Add GCC clock driver for QCS8300
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/8c8fbf390864
[4/6] phy: qcom: Enable QMP UFS PHY driver for QCS8300
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/21f2b5eda800
[5/6] qcom_defconfig: Enable QCS8300 clock driver
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/7c24a00b7f7f
[6/6] configs: add qcom_qcs8300_defconfig
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/0670da70b9a5

Best regards,
-- 
Casey Connolly <casey.connolly@linaro.org>

