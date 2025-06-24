Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52515C77B7C
	for <u-boot@archiver.kernel.org>; Tue, 24 Jun 2025 08:45:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75DCF82DF2;
	Tue, 24 Jun 2025 10:45:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PlIoiMsG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 64AA582DA1; Tue, 24 Jun 2025 10:45:34 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C8E682C2F
 for <u-boot@lists.denx.de>; Tue, 24 Jun 2025 10:45:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=stephan.gerhold@linaro.org
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3a510432236so3734042f8f.0
 for <u-boot@lists.denx.de>; Tue, 24 Jun 2025 01:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750754732; x=1751359532; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/tzVdDM7y2l7r1TRvSbRnM9oGcEPzNfWX++xCO7/eQ4=;
 b=PlIoiMsGVejAGLeAc/+7E5erhPHKOSi1VHYONR2M4RvaWeSYn0/6l7ztbk6s1EnKEN
 EWhDoSLnbEeasMmS8MPk1ZgXf8qddGODiWE8cuHrkMxstboR2ZBWcJdqJ02yC9olZlHd
 /qLfXNFbvkLWy02Di2A3g/iynkMPg4ZxL6Xl4TwWU953AfMjqIWvv3DCpoIKVmGvERMl
 v4q5cyVMm/qE3ZFCbTotegs3TK3Hx5HajSne8gdt5oTKCEybitP5Wxu/KJ2ekwy3Nt/k
 UQZm6e5lwAoHHGX5IgMTb+C68qXNMhRuAf3bWXu8RjjOYJ2cdAr7G6s0RCisxFn6b/ue
 fFGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750754732; x=1751359532;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/tzVdDM7y2l7r1TRvSbRnM9oGcEPzNfWX++xCO7/eQ4=;
 b=hSvLWDL8ZViGpEp+WDVISQDrMWULbWlr51ww1Zz8lYdT+JZafcOFE5PuyUZXsIio1Q
 lxLpH3qecHwZr6UT2PKdG5U2Hr7VHuf5yyTQEQhvFp0ZWSQau0vS9STBccZVacf76G2P
 xND+k7TwODwzlKlGk6gxoI0/NSkVyJY1faDtQyXzwQ5bc1SpYVgW2fq5s7oqnxC+1hxU
 Vg784Rr8ifyUyqs6GExnZgcXwcHxTc6Fxno0wZio/NPzn1lhFOtSQnJ9ElhlG7TSzyuP
 jLAd5Kmky4wc9w4nR/9o0pfrVjxB+Uwk5jPRNi+3jAfsmBuYlQEu1ccJwo/VlkIe2vF+
 vWZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQMa9CIoPiGKLUsygekq9wItfXNtrA1pzsaCBKnt9/UdaYo3jjKReW7hCVfdUz02RQKLWQjbU=@lists.denx.de
X-Gm-Message-State: AOJu0YzRCCIjr26tPNpO5ZL0e6kXrMBDBqysfYXxGr6crW099b+vUnhj
 /tBZhYcSDs5+9CRdIx1PsEeDh8z0UA4I4q6WAn5CpBPLmJFcwe5GFbEgKw38fB+4fmg=
X-Gm-Gg: ASbGncvIKlgBGR5wKECNLhqE+P0aonhRGOzEbaI1iV0ovYqRIzBTxxgGNOUgYyA/w9x
 Hm19zjQRn6Du+gLaeh8vE75Y6zwjMiU6HHFNdYj7oHk8xFCDSYEog8/8pIZNqzIzCGE9Xi8mrNS
 0/qCbsci23+ZSHVqFxv5qkV+u36lRPq+09ShWiTZRvX8BgfRATvsralxOJEZaNdkjJ8lSfT10EK
 zThLrUh+kBLJmUJDhq46I/DbVW369W6M7uhq8RNgI3lNtacGp+s9QWvTpgv0Yp9583YqbabJ+vE
 1E5+e/k6+r/j40NwLxwp10DVEHNyCJTLK2MnTwMDYOFhVOxAHA9p2uVeooagMqkJxtvG9nQWNvD
 Cv5oApKsFZQ==
X-Google-Smtp-Source: AGHT+IE/38/mesr/DEu/B4As4hzFNQDdaERqkTZRh0kI13lFmHibiMFtVWGZwUMTZGZT6ch2rXu/sg==
X-Received: by 2002:a05:6000:3111:b0:3a1:fcd6:1e6b with SMTP id
 ffacd0b85a97d-3a6d1334011mr11640699f8f.57.1750754731674; 
 Tue, 24 Jun 2025 01:45:31 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:2454:ff21:ef30:8d0b:e160:4436:f56b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6e811049bsm1342888f8f.88.2025.06.24.01.45.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Jun 2025 01:45:31 -0700 (PDT)
From: Stephan Gerhold <stephan.gerhold@linaro.org>
Subject: [PATCH 00/10] Fix UART autoboot issues on DragonBoard 410c
Date: Tue, 24 Jun 2025 10:45:13 +0200
Message-Id: <20250624-db410c-autoboot-fixes-v1-0-d96c97ae41d1@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJllWmgC/x3LTQqAIBBA4avErBvQUvq5SrQwHWs2GVoRSHdPW
 n48XoZEkSnBWGWIdHPisBfIugK7mX0lZFcMjWi0UHJAtygpLJrrDEsIJ3p+KKFxnVdeD11reij
 vEekPZZ3m9/0A7PDqoGcAAAA=
X-Change-ID: 20250419-db410c-autoboot-fixes-ad7f4f5973a8
To: Casey Connolly <casey.connolly@linaro.org>
Cc: Sumit Garg <sumit.garg@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>, 
 Sam Day <me@samcday.com>, u-boot-qcom@groups.io, u-boot@lists.denx.de
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

There have been issues with autoboot on DB410c for years, where autoboot
gets interrupted by spurious input on the UART console. I've tried fixing
this back in 2021, but it turned out this fix was not enough. Looking into
it further, there are two separate issues to fix:

 - Spurious input with UART disconnected: The RX pin is floating in this
   case, resulting in garbage or a UART break event (0x00 byte). This is
   interpreted as input in the autoboot prompt. Fix this by adding
   bias-pull-up for the RX pin. I've made this change upstream in Linux for
   all MSM8916/MSM8939 devices, so I only backport the changes here using
   tools/update-subtree.sh.

 - Spurious input when querying console size with UART connected: It's
   unclear why this happens, but it seems to be some issue in the overly
   complex implementation of 4-character packing mode in the serial_msm
   driver. Fix this by switching the driver to use the more simple
   single-character mode, which doesn't have this issue.

With these patches, autoboot is finally working reliably on DragonBoard
410c (and hopefully will remain so for the future :-)).

Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
---
Stephan Gerhold (10):
      arm64: dts: qcom: msm8916/39: Move UART pinctrl to board files
      arm64: dts: qcom: msm8916/39: Introduce new UART console pinctrl
      arm64: dts: qcom: msm8919/39: Use UART2 console pinctrl where appropriate
      arm64: dts: qcom: msm8916-motorola: Use UART1 console pinctrl
      board: dragonboard410c: Drop now unneeded bootph-all for console
      Revert "serial: serial_msm: Delay initialization to let pins stabilize"
      serial: msm: Cleanup register naming
      serial: msm: Reset after writing to DMEN
      serial: msm: Re-enable after resetting
      serial: msm: Use single character mode

 arch/arm/dts/apq8016-sbc-u-boot.dtsi               |   9 --
 drivers/serial/serial_msm.c                        | 127 +++++----------------
 dts/upstream/src/arm64/qcom/apq8016-sbc.dts        |   6 +
 .../src/arm64/qcom/apq8016-schneider-hmibsc.dts    |   6 +
 dts/upstream/src/arm64/qcom/apq8039-t2.dts         |   6 +
 .../src/arm64/qcom/msm8916-acer-a1-724.dts         |   3 +
 .../src/arm64/qcom/msm8916-alcatel-idol347.dts     |   3 +
 dts/upstream/src/arm64/qcom/msm8916-asus-z00l.dts  |   3 +
 .../src/arm64/qcom/msm8916-gplus-fl8005a.dts       |   3 +
 dts/upstream/src/arm64/qcom/msm8916-huawei-g7.dts  |   3 +
 dts/upstream/src/arm64/qcom/msm8916-lg-c50.dts     |   3 +
 dts/upstream/src/arm64/qcom/msm8916-lg-m216.dts    |   3 +
 .../src/arm64/qcom/msm8916-longcheer-l8150.dts     |   3 +
 .../src/arm64/qcom/msm8916-longcheer-l8910.dts     |   3 +
 .../src/arm64/qcom/msm8916-motorola-common.dtsi    |  11 +-
 dts/upstream/src/arm64/qcom/msm8916-mtp.dts        |   3 +
 .../arm64/qcom/msm8916-samsung-a2015-common.dtsi   |   3 +
 .../arm64/qcom/msm8916-samsung-fortuna-common.dtsi |   3 +
 .../src/arm64/qcom/msm8916-samsung-gt5-common.dtsi |   3 +
 .../src/arm64/qcom/msm8916-samsung-j5-common.dtsi  |   3 +
 .../src/arm64/qcom/msm8916-samsung-serranove.dts   |   3 +
 dts/upstream/src/arm64/qcom/msm8916-ufi.dtsi       |   3 +
 .../src/arm64/qcom/msm8916-wingtech-wt865x8.dtsi   |   3 +
 .../src/arm64/qcom/msm8916-wingtech-wt88047.dts    |   3 +
 dts/upstream/src/arm64/qcom/msm8916.dtsi           |  51 +++++++--
 .../src/arm64/qcom/msm8939-huawei-kiwi.dts         |   3 +
 .../src/arm64/qcom/msm8939-longcheer-l9100.dts     |   3 +
 dts/upstream/src/arm64/qcom/msm8939-samsung-a7.dts |   3 +
 .../src/arm64/qcom/msm8939-wingtech-wt82918.dtsi   |   3 +
 dts/upstream/src/arm64/qcom/msm8939.dtsi           |  51 +++++++--
 30 files changed, 204 insertions(+), 129 deletions(-)
---
base-commit: fb4a488eb91b089912ffbc9a74d0527f0f2c79ac
change-id: 20250419-db410c-autoboot-fixes-ad7f4f5973a8

Best regards,
-- 
Stephan Gerhold <stephan.gerhold@linaro.org>

