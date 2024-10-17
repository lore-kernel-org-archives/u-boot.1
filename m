Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32455D2F7FD
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 08:05:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 656EE88E32;
	Thu, 17 Oct 2024 10:05:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="BoEAuM5q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A39588E36; Thu, 17 Oct 2024 10:05:03 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 96DD088C60
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 10:04:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43111cff9d3so5767035e9.1
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 01:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729152299; x=1729757099; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=vKhUkfMrPQu1maeXjpFd+U/N4aLJjJn0kK2Z4cG23rU=;
 b=BoEAuM5qAfXWn+8gzy6IGqqf9B8kA5u6eFixD0jifipshxpHjW2T9v2rO/k93H93Z4
 B9UtmqjEFoaLNCiuzWlDFvYD2/Eeax17DSfkLLkYRYRVVdYg9/O2fMrm/hdFUQOY7zge
 lTkONukYkoCRLQ9uMJiiryFWyIv/Pfu6zLD8a6hnfaZI0r1isIF6PZ8nEJGsZeKR/ddj
 K+CY0XAHmlLtuRMwq1aaL35pd6Xd0kOxURhWR9NBXJsGXeYXaAKvhspToBtFVAilIZnK
 I+yb34qFvIqlQ5p6MQjV3/eKx/9tZXFyGdTgg/tZ/pUTM6gekwRmTxzcNj7u7IcgzAjk
 TxXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729152299; x=1729757099;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vKhUkfMrPQu1maeXjpFd+U/N4aLJjJn0kK2Z4cG23rU=;
 b=FCofdhFuhqOXkTPjY5OymmPQGrScKuOAav7EPPiYYfEt6Uv5E8AmejsUhcokHq1Rv5
 oeypWMOUuhf/epescZA9pnFRQEtkFsNPPM74evh6hCFC6+OmreeSg+N+AaOOAWKiRL6l
 0i7ic76kx/6+9wTbPLgNmo8I7K4U+D2SsUXDiJEscUhqJOiPviWod1YJQjYT+a8qzqN4
 h6qrx97DdyF+zTFt0U0vVBWu8BIFbo3eX947/wvFdCoLXA58K4I3+7ds2EIcTqHolvQA
 Jh7dzJCZRB1tm4ASueJx2TQx8j2NgXEPM2MAY9QBLh781mEL3dplVzwSJnoNzHBctn/x
 nLmQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8W685s6BG+GtHT6II59ycWZp8N5iItFdCxIOerHozuPP0PantKKJ3FdjloSVo3s45g/CGN2M=@lists.denx.de
X-Gm-Message-State: AOJu0Yyw3RFc384xSsn3zMZqz+bBG0ApPHa0ZU2zI22VgZsXc5OhgOjW
 ir7+Z3dXUiw82d8Bhi4gd/bzwSefD1IOkGg7uRh2J15G8DuZSCRZ+GN4+F+akfA=
X-Google-Smtp-Source: AGHT+IHnUAik6TXjnlMPxorTZ800gouoOVgHdO5unjxnby0dRp50X9Dx3yX7Zgr89ln447wURRvKgg==
X-Received: by 2002:a05:600c:3516:b0:430:5760:2fe with SMTP id
 5b1f17b1804b1-4314a35ee1dmr53518355e9.22.1729152299006; 
 Thu, 17 Oct 2024 01:04:59 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43158c39cafsm17720625e9.16.2024.10.17.01.04.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2024 01:04:57 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Thu, 17 Oct 2024 10:04:54 +0200
Subject: [PATCH] qcom_defconfig: enable PINCONF
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241017-topic-sm8x50-enable-pinconf-v1-1-a70ddf492e87@linaro.org>
X-B4-Tracking: v=1; b=H4sIACXFEGcC/x3MQQqDMBAF0KvIrB1IrDahV5Eu0vhtB9pJSEoRx
 Ls3uHybt1NFEVS6dTsV/KRK0gbbdxRfQZ9gWZppMMNojXX8TVki14/fJsPQ8HiDs2hMuvLkAzy
 ci8vlSm3IBats5z7fj+MPkXOdJG0AAAA=
X-Change-ID: 20241017-topic-sm8x50-enable-pinconf-58ae8e77cd36
To: Caleb Connolly <caleb.connolly@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot-qcom@groups.io, u-boot@lists.denx.de, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=892;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=7+s1f6ZannlF5DEJC8ACmA7mmapLe2w7kvpCFWYuV5I=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBnEMUoOTNGozlCReNOGKqg+FvlBQkBrYhw0rz1gHiq
 jbRcHI2JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZxDFKAAKCRB33NvayMhJ0Y20D/
 956mma6mmFEUgpQMwGzgEwUi9061Jk1hc0QH3vCLDyfo7becRpuCW2XAkUhdmUCSy9LzDF2VUHEmo2
 IuzBTKfk8rCIbf8ktE9Ccn5Z8tK3X3YAzGPPzeh1zK6EiYJesTFmBiZhL0wyIM0nUwTsQYBksmkWJ5
 OEC5s2IdSm8d0uAl44OhtzcsyfXSxwyCnI/lvQW2tsYdrmxgwmJwtrZKMFwAU5ZKV+GKmgGSpdnsfU
 DV3ChYgi9MqpO8gge7X/OBIZzbA52mHCnCXuAI2Obg5NHgZU5rJIHMtbAw5H/fiCtltmQcJ8kKCqFe
 qYA6Lvrleyy44NN6d80PIEOmeVsFstz/R0j3H5wo7afLPvJnTMGekV9f5upQna0trh/v/petO18Dmr
 HEujPoAMzWAHhPRgtGzj+K2WR0oVaUXOmIOoBeUgaHjQ/xZP8DyqMqGaMW6CYA6c6VdNrkifacSvGM
 bSbxml+HykOt5SzUAJv8YTzjkaSYuNiBg7gz7bME1vKy2UxrFB1lP4pQIb1LsQheuhmB+4oo8sRYMj
 faiOpBQb7MpWUXGo8qdKVCwd/dCFfHM2q0TVGWNx7hS8saMtMYi/nOtyplcG1aJQW3MVvrK2VqEAlm
 Y7EIDcpjGY2Ma44ZcRF163oZNKhkWUjSMYHsWPjhHzGbv7QtpPUR6pMtG5Uw==
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

The SM8550 and SM8650 SoCs requires PINCONF to properly
setup SDC pins in order to function correctly.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 configs/qcom_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/qcom_defconfig b/configs/qcom_defconfig
index ea0dd3e58018c8bf08e4a455a47e29cf1bbd3c60..3ffc650c77191b224c7b2322fa4e1fbe1a1a97a5 100644
--- a/configs/qcom_defconfig
+++ b/configs/qcom_defconfig
@@ -81,6 +81,7 @@ CONFIG_PHY_QCOM_QUSB2=y
 CONFIG_PHY_QCOM_USB_SNPS_FEMTO_V2=y
 CONFIG_PHY_QCOM_SNPS_EUSB2=y
 CONFIG_PINCTRL=y
+CONFIG_PINCONF=y
 CONFIG_PINCTRL_QCOM_APQ8016=y
 CONFIG_PINCTRL_QCOM_APQ8096=y
 CONFIG_PINCTRL_QCOM_QCM2290=y

---
base-commit: d5cab0d6adc26ec1bbd45c2fed101184d04454ae
change-id: 20241017-topic-sm8x50-enable-pinconf-58ae8e77cd36

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

