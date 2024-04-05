Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E2A3C67861
	for <u-boot@archiver.kernel.org>; Fri,  5 Apr 2024 08:22:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD441884A2;
	Fri,  5 Apr 2024 10:22:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ClQkT0X0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3022C884A1; Fri,  5 Apr 2024 10:22:01 +0200 (CEST)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com
 [IPv6:2a00:1450:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2469188498
 for <u-boot@lists.denx.de>; Fri,  5 Apr 2024 10:21:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-516cbf3fd3dso2030016e87.2
 for <u-boot@lists.denx.de>; Fri, 05 Apr 2024 01:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712305318; x=1712910118; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=O06h+69DZ0NsCiH7qpAb42rstTrVclPL7bvVfO1OMQo=;
 b=ClQkT0X0QhHxY29MXBVRXHWH4r9j+cgb2PGu3Gsuwyop0QMelabkLlXW2r2BG1+WF8
 tvp0zYRiwmeoTx5eJaszkLQc9q24ZnmRgNkvNTlKef9kZ6if2RS+J74UzcMwHpaqAJ2p
 R8T0BGXsUdgegLZnxVngoJ9NXnl+ErgjpDrqRgKSDkQiJqgQvGncOY7Ty2sCYt0caELG
 70ZbLewECakLm1V4olA6TFXSfiCrOiyxCL/ig5yo+7FuGmPzfZcq44jjiYr4FdOH6S4B
 BhotV5wQPvaqREP5htMnhIQ/iPma36jmv2szqzaXjwMK7E+BqBMOf6m0k8qsGulBdK0f
 pT8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712305318; x=1712910118;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=O06h+69DZ0NsCiH7qpAb42rstTrVclPL7bvVfO1OMQo=;
 b=FFWLBE+X9MJELTarRmLktw8hlK/q0jjc74JB/MXq1tk3a242e+R2skAgCOflSokMP5
 0Fpidn70LJR6LxqWhTs2umJ3S18kuasC9ZJO6TMZatTSRL0/ijoAfuK9WJmFsYTjrGGE
 HoOZQ3wK6YyDzgt4S0s80Ca2yfHh3fztxlbLoVILIaxdMB5jzO5ppFpqE/ikXZjq02vi
 A1/O7jNGdXtD+8HKsu1PP6RhOdskOheqfvmwH243fUZpEZ40uIjEqravBxqv9dJWD1zd
 1i4+vySV2XAzmM0YpzrgArej3NwJwCKXrcL7/jchzPDSfnoIKBszX9T5wA+C3VubC3R2
 V4/w==
X-Gm-Message-State: AOJu0Yz7fp1bEsjsMSu4zDsjQ9A1lpuGMa+Oj9B8BNuiDaTGBj+wGHHW
 FDu56riVaUlMJpN38Q6sGdeLEq0dIIW53lbCQolxZ9eu4NR+KEDav1HrVuUhC0w=
X-Google-Smtp-Source: AGHT+IFTOn9pyBMIkpRAq9+ofeekq0FnwEmb72u/7h5E/QR8nmHizHxh8btPly2HPaG26ywWiOe7Xg==
X-Received: by 2002:a05:6512:b8e:b0:515:d4a6:215 with SMTP id
 b14-20020a0565120b8e00b00515d4a60215mr594616lfv.7.1712305318208; 
 Fri, 05 Apr 2024 01:21:58 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 j27-20020adfb31b000000b00341d84f641asm1452326wrd.8.2024.04.05.01.21.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Apr 2024 01:21:57 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH 0/4] smpi: msm: fix version 5 and add version 7 support
Date: Fri, 05 Apr 2024 10:21:52 +0200
Message-Id: <20240405-topic-sm8x50-spmi-fixes-v1-0-031a9e5efab4@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKC0D2YC/x2LQQqAMAzAviI9W5ibgvoV8TBn1R7UsYoIsr9bJ
 KcQ8oJQYhLoixcS3Sx8HipVWUDY/LES8qwO1tjaKHidkQPK3j6NQYk748IPCXoK3eQ621ZuAr1
 joj/oPIw5f4cqOm9pAAAA
To: Caleb Connolly <caleb.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, 
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Dzmitry Sankouski <dsankouski@gmail.com>
Cc: u-boot@lists.denx.de, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1074;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=npPLhJ/xzSzqZk9f+xZiyPr2D96RcAgpqYhaNbaRtyI=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBmD7SjHVwdH31Zxso0qXVYI7ltJ6s0GxiCSZPINJ9c
 KOxexdyJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZg+0owAKCRB33NvayMhJ0fYZEA
 DM6NYLmejviLzotSzJhLtjYeUiowTJzxoqXbt5mTfUOxj5l4yxRpha5p81SwuZZfkwL+6SktGl2qQW
 zUebQihuDkTOSjr3rVYPTeG2RHZtiryEArTS2XWHuUk66f2Uq4h0aqxLKg1m+mRvJYvk0fkOpMNfMk
 SW5jHiRsYukLeoNwyN8oxFWdLxD8oamgmf6dFQy3gxVuwO4K4QNKbmgLnxFcqnQPPE5C2Zg911h/VK
 67NwInqBkThoq9j24JZwNQ/oeyi2480DxRdgLKVfa1SwkjQ2FyeH/zK4Txh5hvOcubkgK6QqbD7uY3
 P9AEpcZz8W4gpU2gbD0LKH2Dlcg5tJShIdokvsnnrdJG0Py0HtWbcqgzp18GM8eYoBnSw89ndoXmIN
 JRxgfsDcsEN2gmQ1R/sxOqGrw5lmsD0IPv73nAgFJb2N1I5+wNMRJ0jTgMVEkecrKKCwxslPvmfuvD
 WBgldAhos3IavsC9TBjT7lvgmNmN6dyQqmd3MeJH2qkflfbT4KmiT3/nxmrnt8EI7pANZwU3rlK/qh
 BGp/dDiMAww1D3GOz+gt9WvsasbyA01dwVCWHTJXUZFPzT0jJrKVvlSaz+AYewAnQ4qeuMZ04R/fjl
 t+0ctKWYIK4NtXevl55gKwmC9ZY7yJJxWjZVzWgHQ3IkmG1zbVCrbgp30eAQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
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

First, fix version 5 support by using the right ch_offset in
then msm_spmi_write() reg accesses.

Then:
- properly format command by importing helpers from Linux driver and
  use a switch/case to handle all versions in msm_spmi_write/read() command.
- handle peripheral ownership by poking into the cnfg registers and
  mark periperal as read-only when the owner id doesn't match
- finally add version 7 defines

SPMI Arbiter Version 7 is present on SM8450, SM8550 and SM8650 SoC.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Neil Armstrong (4):
      spmi: msm: fix version 5 support
      spmi: msm: properly format command
      spmi: msm: handle peripheral ownership
      spmi: msm: support controller version 7

 drivers/spmi/spmi-msm.c | 148 +++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 116 insertions(+), 32 deletions(-)
---
base-commit: f0e6aba1218bca578605697eed8aa94582bf57bb
change-id: 20240404-topic-sm8x50-spmi-fixes-aec9b392813b

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

