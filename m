Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ADB4C4345F
	for <u-boot@archiver.kernel.org>; Thu, 18 Apr 2024 17:24:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 541AB88662;
	Thu, 18 Apr 2024 19:24:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="rG3C3zH8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D57888662; Thu, 18 Apr 2024 19:24:30 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 26ED988669
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 19:24:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-418c0d83e61so11990925e9.3
 for <u-boot@lists.denx.de>; Thu, 18 Apr 2024 10:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713461067; x=1714065867; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=tkLKA7XrKzbaUJzue1gwxK3KdMpP9v0OKLE+JMcT5UE=;
 b=rG3C3zH8fRXoFbCQ8rMQwXZBNZwu9/93wvWtzZpheuMIxUvm+cR+dPPuv8e0uG8zVV
 INscJjQjCkFRHflP7TBlpF2d0jionN6Ly0XfzslSpsHAnqmG0ANncTbZqHN7v3GBv5tu
 bhEcyLAwyAxXpIczOzQSPiXwn4yV2cH9miXD1hZBP0UqeUauBXHRA4M7070BsaYq+kSk
 ErhVt5t8Vjg6IcrJ6sg2kpxgzJ4r9R6taZjUY6fB+FhxDGB2hmz2PeUu+nbm1qAGOnAv
 0EOn3YZgl6+gOQ+wQcdwBb4pT6dtco8Inek9O8jnkvQHO9go6db97KiJCRPA4JrURoBR
 HVCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713461067; x=1714065867;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tkLKA7XrKzbaUJzue1gwxK3KdMpP9v0OKLE+JMcT5UE=;
 b=bERPdbWOn23qM/3fjBsUFAPJWp8LZRrBYz2LddmRqLzHCja+D+GJXHbalbDMh2gDh+
 PoNypc0DGxRNYXznZB+esaf7IuOQci6WI46ofMbFFEswGD3+bXcJ1qExqYUfilQPFGdb
 wFpLgSifLexVGFnFHDa63SMumPbMgt+oGD9d1ytPpyOrulUUlVHGYu8WT7doetjCA+G2
 EqS/h+SznBTjEEqSWd5otTcCoiOM7KhqWIxGMGrJLDI9uZWsjlvOcBs4pEQBakUmFJyw
 1tKO2Sg4rzJt0pwiM73wBl7cLc6YkNu788NPkGNQaPrJl0Jzh03BW7+X74crMYmOGUiL
 ATLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXsTi7Jlt7i22LXX+qt9OngBB2S/lvpqOts8Iq0GxdR2rJqImmUz2YZ5mRHIZVD7BC7rKL0NwO1mlM4JB/0hEmYDGwvdg==
X-Gm-Message-State: AOJu0YztOVCQV+SKcS95c5MAaTK1ta/p7fC8jQL9GNJECRvyoRSDsMX2
 CVJh/l24c4zON1YvhQRuZRx0ujtALhQ4S1MVKiwyTfXc4Nh8XeimmDrta3EU67I=
X-Google-Smtp-Source: AGHT+IFUfJ2ggtFItcGskP8BQD8V4r/iOP5gQA5Te0NC/q7mCSrwQXu17KH1+WD+myXSKpiXHDP8eg==
X-Received: by 2002:a05:600c:198e:b0:418:93d1:ef2a with SMTP id
 t14-20020a05600c198e00b0041893d1ef2amr3131007wmq.20.1713461067599; 
 Thu, 18 Apr 2024 10:24:27 -0700 (PDT)
Received: from lion.localdomain (host-92-17-96-232.as13285.net. [92.17.96.232])
 by smtp.gmail.com with ESMTPSA id
 e32-20020a5d5960000000b0033ec9ddc638sm2301799wri.31.2024.04.18.10.24.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Apr 2024 10:24:27 -0700 (PDT)
From: Caleb Connolly <caleb.connolly@linaro.org>
Subject: [PATCH 0/3] qcom: switch to OF_UPSTREAM
Date: Thu, 18 Apr 2024 18:24:08 +0100
Message-Id: <20240418-b4-qcom-rbx-fixes-v1-0-e524eb29ae86@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADhXIWYC/x3LQQqAIBBA0avErBtwxFVXiRbaTDWLtBRCkO6et
 Hx8foMiWaXANDTI8mjRFDtoHGA9fNwFlbvBGuuMI8Lg8F7TiTlU3LRKQbLs2LOQ8Qz9u7L8oW/
 z8r4f2q5lMGMAAAA=
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Marek Vasut <marex@denx.de>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Ramon Fried <rfried.dev@gmail.com>, 
 Jorge Ramirez-Ortiz <jorge.ramirez.ortiz@gmail.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, 
 Caleb Connolly <caleb.connolly@linaro.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2119;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=3II51XQQwygy3vkSsIflFD2Xd2efsB/z2CLIWzWEkNA=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhjTFcE+LNNczemfOfr3EterCsevbarmur5vYE/i+wpjfY
 KJ1Xmp4RykLgyAHg6yYIov4iWWWTWsv22tsX3ABZg4rE8gQBi5OAZhItgPD/zC9D5/9vE/aKYp+
 mp1kvHWWt6s27+fKl1FhfpNNOVfOu8bIsClz4rWviodm8ncoac0w9awwkWBXv3yPV+KGVEuibEf
 /JwA=
X-Developer-Key: i=caleb.connolly@linaro.org; a=openpgp;
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

This series does the initial switch to OF_UPSTREAM for Qualcomm
platforms. The DT files we have in U-Boot are outdated by now, so drop
them and move to upstream.

Patch 2 drops all the Qualcomm dts files that are now provided in
dts/upstream. As some of the files exceed the 100k size limit by
themselves I thought it would be easier to just lump them together
rather than trying to split them up.

The associated qcom headers will be cleaned up in future patches.

---
Caleb Connolly (3):
      mach-snapdragon: use OF_UPSTREAM
      arm: dts: drop qcom dts files
      qcom_defconfig: set SYS_INIT_SP_BSS_OFFSET

 MAINTAINERS                                 |    4 -
 arch/arm/Kconfig                            |    1 +
 arch/arm/dts/apq8016-sbc.dts                |  729 ----
 arch/arm/dts/apq8096-db820c.dts             | 1137 ------
 arch/arm/dts/msm8916-pm8916.dtsi            |  157 -
 arch/arm/dts/msm8916.dtsi                   | 2702 -------------
 arch/arm/dts/msm8996.dtsi                   | 3884 ------------------
 arch/arm/dts/pm8916.dtsi                    |  178 -
 arch/arm/dts/pm8994.dtsi                    |  152 -
 arch/arm/dts/pm8998.dtsi                    |  130 -
 arch/arm/dts/pmi8994.dtsi                   |   65 -
 arch/arm/dts/pmi8998.dtsi                   |   98 -
 arch/arm/dts/pms405.dtsi                    |  149 -
 arch/arm/dts/qcs404-evb-4000.dts            |   96 -
 arch/arm/dts/qcs404-evb.dtsi                |  389 --
 arch/arm/dts/qcs404.dtsi                    | 1829 ---------
 arch/arm/dts/sdm845-db845c.dts              | 1190 ------
 arch/arm/dts/sdm845-samsung-starqltechn.dts |  460 ---
 arch/arm/dts/sdm845-wcd9340.dtsi            |   86 -
 arch/arm/dts/sdm845.dtsi                    | 5752 ---------------------------
 configs/dragonboard410c_defconfig           |    2 +-
 configs/dragonboard820c_defconfig           |    2 +-
 configs/qcom_defconfig                      |    3 +-
 23 files changed, 5 insertions(+), 19190 deletions(-)
---
base-commit: d5460b082cd6afd0e07c0ec0e5a82d1af8dc09f7

// Caleb (they/them)

