Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0EBDC36018
	for <u-boot@archiver.kernel.org>; Mon,  7 Apr 2025 17:00:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D70A682F35;
	Mon,  7 Apr 2025 18:59:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="rJVxing6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E62382F29; Mon,  7 Apr 2025 18:59:58 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 182A282E66
 for <u-boot@lists.denx.de>; Mon,  7 Apr 2025 18:59:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stephan.gerhold@linaro.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-ac34257295dso933378866b.2
 for <u-boot@lists.denx.de>; Mon, 07 Apr 2025 09:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744045195; x=1744649995; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=KXLtpfwFPq03wtV1OvTiX9dqXoyPqCr97zJIVAsrUNQ=;
 b=rJVxing6Am0TyZWCRjK+gYxuZjDk+UBi1FFVX1Ry7WJ0gc1a71+qYokpr2Htqsz0fD
 POTeOsJvWKtvj35ThaxcEIa9jWMhzUw1+retFEf/aGSNkGr88+XHRz7YepwFHnDpD1EH
 LxXxeGfqT2eSa5gFdrDc4poCtPv9Awp2Ap8IswnX/8agzE4co51V15D8IZFtDFrfJnrX
 lkcMvZgjf1siqsV/a9ZkoLlBDu5afUue5AiEHFokC8UcL24Adx8x/naxfBx4d8F4c/zN
 fyMfFX17DxMaK6R/fzx+RGOA6IgbCD2mWnseS/o990bImxb58zwg27PQfQSp2M3qrdtA
 KgPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744045195; x=1744649995;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KXLtpfwFPq03wtV1OvTiX9dqXoyPqCr97zJIVAsrUNQ=;
 b=U2qS7oIo8QVkVrsol1GNtAkuOddnIGqTUG9cYb3/zuYMGYEv71CE3aAaopPAVDFBxg
 B7KiCLjxn/7w6861CjdxpCGMA+eXLepefsBnKFvPKepnJRAKIKfAoOhE+5uhGOdJrjMo
 oF7S6AbeajlEGv5SvgaCrUOEucO3fl+ehEe/42YgXinus0uWVh8T1NATkNRGrBjKMkmz
 vANRKJJ9s0c0P1196ms6BOVdkA+Kf+tB8Zqhw9vhOHT0yj5Dt0Ud32JhrqOTvBOvgTJL
 ZYWm7Tgg9MkFIywbPX4df+xW7oSDgxVXorqFzFuCTtdMS0B07vX1TfHPEWE+dOrqrS+8
 xWEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWlOt53JfjQgYRQgM53GuicYVeWdmcDHeRh4GzdPTiXzuUTCSYo12jue3uhjHVo9Op9FUg+iSk=@lists.denx.de
X-Gm-Message-State: AOJu0Yxadrk0r33rv3w6DfS8WTgcdQ8QYYYA0Ted9TWnAW2WUQfERMTf
 GGt/FyFtawYWTtQqrEE6cimBJpU8UqgYLk6Tn5Ko0WoHUgseJf5/ouPmio3njsM=
X-Gm-Gg: ASbGncv5Af9BEJ2DGjOawqAoxrMQSRTGCTBTZBCsfT/Q4GQgmSInTnN+XGniRNpJyr+
 46bcQUtifmgZocOD5f/wrwA8a8NFdJGhFJQj5WYDdyNK0ilZW2kDG8sXGPSnkWXAUBbtSJ///Gu
 N7ZOANyZmcPA5Ml6SIvfu+IWKkc0hogSma6JnHl7QZWTwQPheIfoVPK7Oh6lGgTrmSxQQhoXa3T
 KW6MyCCfBDhOGzgw4AvXuVBKos0mlqkhndT/kvFoEm8xnPS6T4OxInvbuieows0+1jBmeH3Dxhz
 Am/RmWxo/rC40sIKGth8BQ8QTQLJm3O3/L7gn3W4AES64pD9rYjwD46ijYx1Gwg8pywq
X-Google-Smtp-Source: AGHT+IG77JTnRafYXcCZ6ztIhgb9CKJOhjQws03CkIQi1bx4lgVqPYVnvkq9MLwv+HAd4jxERn9hRQ==
X-Received: by 2002:a17:906:6a05:b0:ac6:f6e9:6ba0 with SMTP id
 a640c23a62f3a-ac7d6ec3b99mr960512266b.52.1744045195382; 
 Mon, 07 Apr 2025 09:59:55 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2454:ff21:ef30:b2e5:7ea8:e86c:3f99])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac7bfea16aesm773603666b.70.2025.04.07.09.59.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Apr 2025 09:59:54 -0700 (PDT)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Subject: [PATCH 00/13] board: dragonboard410c: Various fixes and cleanup
Date: Mon, 07 Apr 2025 18:59:21 +0200
Message-Id: <20250407-db410c-fixes-v1-0-524aefbc8bb4@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGkE9GcC/x3LTQqAIBBA4avErBNU/ImuEi1Mp5qNhUIE4t0bW
 n48XoOKhbDCPDQo+FClKzPUOEA8Qz5QUGKDltpKI71Im1Eyip1erGKy0QWXUHvlgJe74B/4WNb
 ePxT9w8teAAAA
X-Change-ID: 20250407-db410c-fixes-85c6a6de2716
To: Caleb Connolly <caleb.connolly@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, Ramon Fried <rfried.dev@gmail.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, u-boot@lists.denx.de, 
 u-boot-qcom@groups.io, Sam Day <me@samcday.com>
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

The DB410c U-Boot port has not been updated much lately. This series
includes various fixes and cleanup to bring it back into better shape. I've
also added myself as new maintainer (and Sam as reviewer), since Ramon has
not been active on the U-Boot mailing list for over a year now.

Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
Stephan Gerhold (13):
      mach-snapdragon: Fix EL2 boot on DragonBoard 410c
      board: dragonboard410c: Fix RAM size
      board: dragonboard410c: Fix BD address
      board: dragonboard410c: Drop UNSTUFF_BITS() macro
      board: dragonboard410c: Drop reflash functionality
      board: dragonboard410c: Drop unused linux_image
      board: dragonboard410c: Use dynamically allocated load addresses
      board: dragonboard410c: Fix counter frequency
      board: dragonboard410c: Enable RTL8152 ethernet
      board: dragonboard410c: Use BOOTSTD instead of DISTRO_DEFAULTS
      board: dragonboard410c: Enable support for Android boot images
      board: dragonboard410c: Use button_cmd instead of custom code
      board: dragonboard410c: Update maintainers

 arch/arm/Kconfig                                   |  2 +-
 arch/arm/dts/apq8016-sbc-u-boot.dtsi               |  2 +-
 board/qualcomm/dragonboard410c/MAINTAINERS         |  3 +-
 board/qualcomm/dragonboard410c/dragonboard410c.c   | 67 +++++++---------------
 board/qualcomm/dragonboard410c/dragonboard410c.env | 38 ++----------
 configs/dragonboard410c_defconfig                  | 10 ++--
 include/configs/dragonboard410c.h                  | 11 ----
 7 files changed, 35 insertions(+), 98 deletions(-)
---
base-commit: 4b2895adb0ab94fdaabd6c19cef4d72986483461
change-id: 20250407-db410c-fixes-85c6a6de2716

Best regards,
-- 
Stephan Gerhold <stephan.gerhold@linaro.org>

