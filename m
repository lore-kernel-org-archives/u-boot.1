Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93FA4CD37BE
	for <u-boot@archiver.kernel.org>; Mon, 11 May 2026 13:58:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 820E184674;
	Mon, 11 May 2026 15:58:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="umyy4+wu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B1098341A; Mon, 11 May 2026 15:58:04 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 97DE084661
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 15:57:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-67b6da5a618so5992455a12.2
 for <u-boot@lists.denx.de>; Mon, 11 May 2026 06:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778507879; x=1779112679; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cqQs1JcXm1eUL7CfIgZCMoGxPWrlSxHVx9Aa+JWpc64=;
 b=umyy4+wueO/n+C0DTWNZIGvGALDKMpCHdOR9zJ1EuX2orTqepH+nCHViAr7RKguiDG
 isGSglTF8Gx6dsfd75etNUs2JisU2DxDSRz+5a9MH4k9RAIpstLYQATTgjrOgpSQu07a
 Iu2lsGFzZ4t/ERgdOnDy8LdJ0oLqtercd8GudM4Zey7I1xwoxKa6dlAwohduv5QubTkR
 6zXV8yqAZan+G7s8hnP0UTvWG8rD28b0qP9j2wvGKvJ5JXhz3Mzfm80z/gnkxMft4/L3
 1nkRx1qe4pI6O12eittxYl2MC/CXYTsjVzEzkLRqu/nqiSo+0gUiqVF73hZwhy3w4vh5
 z2tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778507879; x=1779112679;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=cqQs1JcXm1eUL7CfIgZCMoGxPWrlSxHVx9Aa+JWpc64=;
 b=ltuXQxovuk/Gxa1hKiRaPsLnM1i4fLCfBs/lHEf5oUkvn5a8UKiCHdq8pBlgEjkBsq
 ELZG1ahUT2PN7MHobIAFhGEQWH1ljSG/Z/G+iRdLZbSuIa9eQjFR1O+Ml5+Gkdxi+1fU
 Vb1AlY738wVCxTmYfSzfJvHgVEtw90OgWfemyEdzlvexxu7hOdGPtxdYw6qkkSsmjEJV
 uwGmYilOYHH5SA+E5TkqFgNnlXuZY/gNIxoT8NrlVeUxpVaxGGf+xOJE3wk3lgn/rORg
 7YW6Y8TgmL2dC7SLq8J5y5wd/wn9ewHhJWXX4q+grkH18JsZQiD7MK3uAzKVD6/gQPc7
 s+NQ==
X-Gm-Message-State: AOJu0YyClp3Q4WN0F+01WAtEIrOTGFHhia3tjpMkb4qTlxOh0pHl/fNg
 LxHT0HwNdVqBTnNPGLyYmKYKiqeZg/i/LYJ8dY0dxuhTsNwFuJTpq7NY30w6VoaXypo=
X-Gm-Gg: Acq92OH3/TR/FEwLVtZixiNsjEw/DoB7aOmmxz0X7UepUJWlwMWaaH5Ni6I5KFDr+35
 QC6C6vMNBCXl3yI5hzWYvpcYIhAMUk46aJZaUYA7mt36p37hVTScZ6tNoAuG/eruEnHuQmgXrdj
 Yk3wFeEFDo+RPnvcobY+lPolNzaj72wmxpDqqWx+Lsq/ahynVnfwa+vtsxmYeWcmrrHnSUnC57Z
 dF0nyZFvUXvOJdDNcruKIrxyeCP0yMLQ3SD1aTnd0UrXylWqh1/Pp6vL0cO87pAsRJXvYCuQTia
 0DVCM/0GsSbpIp4KmOJqIS9JcGXAhyAYVZ1It+sRNs8JZTjo8fBpGBaaUHu+LLl13tNASfoI/Mu
 /0Yw3XwCB7ZpetcsuNVqMcHzBzOkwTYh7yWmWEYar5Nb++8bphInGein7Y31FSEzlo2f84aF6yV
 paOGispNF2IiMnq8E5v7npjyYaKUMCyM3eTCDhb++0gcuCBnHe9k5sSjPdHtAvG0y4sE26KDQxe
 6Ew2fE=
X-Received: by 2002:a05:6402:5288:b0:67e:43a7:1764 with SMTP id
 4fb4d7f45d1cf-67f716e0b40mr4810692a12.26.1778507879066; 
 Mon, 11 May 2026 06:57:59 -0700 (PDT)
Received: from lion.localdomain (p4fc3dd86.dip0.t-ipconnect.de.
 [79.195.221.134]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-67ef0dfd34fsm3805377a12.14.2026.05.11.06.57.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 06:57:58 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Mon, 11 May 2026 15:57:48 +0200
Subject: [PATCH v7 6/6] configs: qcom: use mkmbn and stop building ELF
 files
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260511-b4-qcom-tooling-improvements-v7-6-0c06346e79a9@linaro.org>
References: <20260511-b4-qcom-tooling-improvements-v7-0-0c06346e79a9@linaro.org>
In-Reply-To: <20260511-b4-qcom-tooling-improvements-v7-0-0c06346e79a9@linaro.org>
To: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>, 
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Peng Fan <peng.fan@nxp.com>, 
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Michal Simek <michal.simek@amd.com>, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=4310;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=QW95m6QX17dqnnGyQQlhoEHyB8Wu85GIJBC0DK3TyPQ=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhizGB7G1XS8Xty0q7294H9wZGnPn9FGzZQ0zNdbF3drqI
 vgn9lV5RykLgyAHg6yYIov4iWWWTWsv22tsX3ABZg4rE8gQBi5OAZgI11qG/wHd5aqvz3vWfYuJ
 W/f7eQfHf0ezFKF1F6Onrz0of/TugucM/2N63F+Y58/69z9gyu4XiT7OH21bcpUWLNtV/KRMfqL
 0MVsA
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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

With mkmbn integrated we now no longer need CONFIG_REMAKE_ELF to then
run qtestsign and can instead just enable QCOM_GENERATE_MBN to have
mkmbn emit an MBN file directly.

While we're here, finally rename the db410c and 820c defconfigs to have
the qcom_ prefix.

Tested on qcs6490 and sm8550.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 configs/qcm6490_defconfig                                             | 2 +-
 configs/{dragonboard410c_defconfig => qcom_dragonboard410c_defconfig} | 2 +-
 configs/{dragonboard820c_defconfig => qcom_dragonboard820c_defconfig} | 0
 configs/qcom_ipq9574_mmc_defconfig                                    | 2 +-
 configs/qcom_qcs615_defconfig                                         | 2 +-
 configs/qcom_qcs8300_defconfig                                        | 2 +-
 configs/qcom_qcs9100_defconfig                                        | 2 +-
 7 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/configs/qcm6490_defconfig b/configs/qcm6490_defconfig
index b088367f86c0..56ec771ba1e4 100644
--- a/configs/qcm6490_defconfig
+++ b/configs/qcm6490_defconfig
@@ -9,9 +9,9 @@
 CONFIG_ARM=y
 
 # Address where U-Boot will be loaded
 CONFIG_TEXT_BASE=0x9fc00000
-CONFIG_REMAKE_ELF=y
+CONFIG_QCOM_GENERATE_MBN=y
 
 CONFIG_DEFAULT_DEVICE_TREE="qcom/qcs6490-rb3gen2"
 
 CONFIG_FASTBOOT_BUF_ADDR=0xd8800000
diff --git a/configs/dragonboard410c_defconfig b/configs/qcom_dragonboard410c_defconfig
similarity index 98%
rename from configs/dragonboard410c_defconfig
rename to configs/qcom_dragonboard410c_defconfig
index 51ad265688c4..e93f5f3094f4 100644
--- a/configs/dragonboard410c_defconfig
+++ b/configs/qcom_dragonboard410c_defconfig
@@ -11,9 +11,9 @@ CONFIG_ENV_OFFSET=0x0
 CONFIG_DEFAULT_DEVICE_TREE="qcom/apq8016-sbc"
 CONFIG_OF_LIBFDT_OVERLAY=y
 CONFIG_SYS_LOAD_ADDR=0x80080000
 CONFIG_IDENT_STRING="\nQualcomm-DragonBoard 410C"
-CONFIG_REMAKE_ELF=y
+CONFIG_QCOM_GENERATE_MBN=y
 CONFIG_BUTTON_CMD=y
 CONFIG_FIT=y
 CONFIG_BOOTSTD_FULL=y
 CONFIG_OF_BOARD_SETUP=y
diff --git a/configs/dragonboard820c_defconfig b/configs/qcom_dragonboard820c_defconfig
similarity index 100%
rename from configs/dragonboard820c_defconfig
rename to configs/qcom_dragonboard820c_defconfig
diff --git a/configs/qcom_ipq9574_mmc_defconfig b/configs/qcom_ipq9574_mmc_defconfig
index 6592d9de39da..98614f6196b2 100644
--- a/configs/qcom_ipq9574_mmc_defconfig
+++ b/configs/qcom_ipq9574_mmc_defconfig
@@ -11,9 +11,9 @@ CONFIG_DEFAULT_DEVICE_TREE="qcom/ipq9574-rdp433"
 CONFIG_SYS_LOAD_ADDR=0x50000000
 CONFIG_DEBUG_UART_BASE=0x78b1000
 CONFIG_DEBUG_UART_CLOCK=1843200
 CONFIG_DEBUG_UART=y
-CONFIG_REMAKE_ELF=y
+CONFIG_QCOM_GENERATE_MBN=y
 # CONFIG_EFI_LOADER is not set
 CONFIG_FIT=y
 CONFIG_FIT_VERBOSE=y
 # CONFIG_BOOTSTD is not set
diff --git a/configs/qcom_qcs615_defconfig b/configs/qcom_qcs615_defconfig
index 27666a8129d7..f4760703c94a 100644
--- a/configs/qcom_qcs615_defconfig
+++ b/configs/qcom_qcs615_defconfig
@@ -15,9 +15,9 @@ CONFIG_DEBUG_UART_MSM_GENI=y
 CONFIG_DEBUG_UART_CLOCK=7372800
 
 CONFIG_DEFAULT_DEVICE_TREE="qcom/qcs615-ride"
 
-CONFIG_REMAKE_ELF=y
+CONFIG_QCOM_GENERATE_MBN=y
 
 # Address where U-Boot will be loaded
 CONFIG_TEXT_BASE=0x9fc00000
 
diff --git a/configs/qcom_qcs8300_defconfig b/configs/qcom_qcs8300_defconfig
index 5fffcddc16e9..8ff790f2889d 100644
--- a/configs/qcom_qcs8300_defconfig
+++ b/configs/qcom_qcs8300_defconfig
@@ -15,7 +15,7 @@ CONFIG_DEBUG_UART_MSM_GENI=y
 CONFIG_DEBUG_UART_CLOCK=14745600
 
 # Address where U-Boot will be loaded
 CONFIG_TEXT_BASE=0xaf000000
-CONFIG_REMAKE_ELF=y
+CONFIG_QCOM_GENERATE_MBN=y
 
 CONFIG_DEFAULT_DEVICE_TREE="qcom/qcs8300-ride"
diff --git a/configs/qcom_qcs9100_defconfig b/configs/qcom_qcs9100_defconfig
index 082106157bbc..84b2b9a1bd1b 100644
--- a/configs/qcom_qcs9100_defconfig
+++ b/configs/qcom_qcs9100_defconfig
@@ -6,9 +6,9 @@
 #include "qcom_defconfig"
 
 # Address where U-Boot will be loaded
 CONFIG_TEXT_BASE=0xaf000000
-CONFIG_REMAKE_ELF=y
+CONFIG_QCOM_GENERATE_MBN=y
 CONFIG_FASTBOOT_BUF_ADDR=0xdb300000
 CONFIG_DEFAULT_DEVICE_TREE="qcom/qcs9100-ride-r3"
 CONFIG_ENV_IS_IN_SCSI=y
 CONFIG_ENV_SCSI_PART_UUID="71cb9cd0-acf1-b6cb-ad91-be9572fe11a9"

-- 
2.53.0

