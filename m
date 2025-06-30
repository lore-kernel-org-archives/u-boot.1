Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F01FC8302B
	for <u-boot@archiver.kernel.org>; Mon, 30 Jun 2025 16:04:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F93782E6A;
	Mon, 30 Jun 2025 18:04:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Xql+QdKw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D57682E6A; Mon, 30 Jun 2025 18:04:53 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2519B80B9B
 for <u-boot@lists.denx.de>; Mon, 30 Jun 2025 18:04:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3a50956e5d3so3974614f8f.1
 for <u-boot@lists.denx.de>; Mon, 30 Jun 2025 09:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751299490; x=1751904290; darn=lists.denx.de;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ttm6LzZuU0LBtjYbYJN4HutZTAK3t+ue6NqfNXSZnmw=;
 b=Xql+QdKwPHyP5M0XU2U593Ho/Xyn+I/Jn5nhiydrZ+QBmRkMkdddqrZCZ+64KpstPe
 NPFGob9tRH5hq6upJ9Kb4zJIvdDM0ZDLV0b3EM+xb9FlFinX+ev1M9JdViCBKKWcrAu6
 BHKFMVPVGCd5ZsMVX8rKO5ybPQJOZMJTotGEfk6HMrv24f9efNCbPcbHjBoaHtXq59D0
 BUcm3f39RMxlHnLnGcLEw8+tuNmgHUckhp/wxxqjGLsfRc7nHjhmMLx3tRKOvZiWJYPP
 2QtN8lkdAWesxrG+RkemRazksrXAU3eDRKl6K1txnbYtodipBJMvOSYqaS69bfFCM+qY
 0OSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751299490; x=1751904290;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ttm6LzZuU0LBtjYbYJN4HutZTAK3t+ue6NqfNXSZnmw=;
 b=HLu/CeerpiFcTSeopVU+Im4GWYB9ShbvhbC9cpS1lNdwdn3Ra+aRMrUt9d7HFRGLkK
 9SguYG06nrF/DLQMF+PvtxOkcRfQ2pSdBv0eaEd5s/OgxEV2smIz6a/Ei+Rvk4g81XGs
 rk53x/nAlsxevKPrlC66t0cJgnc4aBgWCgKz9VjuECGzKSu6mXHLLKSHlkaKkd3vlg6M
 FT2OG6SsQEUdjxTKV1SNvz10r7r0UUfIUhNL1W5aqyyzvvsnLKe5UOQS9o97obnFWK15
 NViLllgNn3wvLZWUfqlpKlpgkcvn7JFe+1RMsl+EZ2XmU+UFYeefFq2mxsIZ3aSmPkya
 egGA==
X-Gm-Message-State: AOJu0YxV8lxwZQeNcu0zpKQPaAgV2/M0tbK8Lp+tYxH+BujmzFDK8aPc
 +rkWPrCmeS3dX+VZoQG7axWsM8UyYHRMhY8CMG+Lplz1aUw7Nkz7JjN5Xshfmk1Mw10=
X-Gm-Gg: ASbGncubaE9oocqOJHVcUIlaPKW83HfNHKYJsAS4daRxn3v9aIZI9w8eFy7z6vS5xk6
 VKaN1HkPZ7i4AErVMan+2ZhYZtIePwvqQWD0SMihcOfMnQcZdntRP3bu9vBICQn5pXUcTkPSEbC
 zATNoa4QKLEdMQ0DMV/y2TAyXY8Zb1rvLYXqJQU4buQfUhYYTKtDrfC5HHP6COJomPoFOieHF5+
 lKCakkVU/6rmBnzulyvrq77HspstVpecyKhsuW1T1ffeusSqaNC37SU5yekcB5xvvqJVzOtmc8/
 Qpxny1gWN+dMYCMAbGiBH70lohOrToHVm360gwtvhCnCj4KvUIvX2e4SHB5zOYFLgCVmpsnx8Pn
 Wi1qTSjk=
X-Google-Smtp-Source: AGHT+IFXeB/lMdSKfL3C9Oj6fnwOnM/bsBTMsDYO11fv1hSfcja5r0T9YrDw6B43lvvmhAE21y/caQ==
X-Received: by 2002:adf:fdca:0:b0:3a4:e4ee:4c7b with SMTP id
 ffacd0b85a97d-3a90d5a7cfemr10996593f8f.15.1751299490284; 
 Mon, 30 Jun 2025 09:04:50 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a88c7ec69dsm10685215f8f.6.2025.06.30.09.04.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Jun 2025 09:04:49 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v2 0/2] gpio: qcom: rewritte SPMI gpio driver from Linux driver
Date: Mon, 30 Jun 2025 18:04:43 +0200
Message-Id: <20250630-topic-sm8x50-pmic-gpio-pinctrl-new-v2-0-cc1512931197@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJu1YmgC/5WNQQ6CMBBFr0Jm7Zi2tkBccQ/DAmuBSaBtpgQxh
 LtbuYG7//7ivR2SY3IJ7sUO7FZKFHwGdSnAjp0fHNIrMyihjNBC4hIiWUxzvRmBcc57iBQwkrc
 LT+jdG5Wpa3sznS6lhSyK7HrazsijzTxSWgJ/zuYqf+9f+lWiwEqLqnK9eOpSNxP5jsM18ADtc
 RxfVuJx7dUAAAA=
X-Change-ID: 20250401-topic-sm8x50-pmic-gpio-pinctrl-new-2588c35a461c
To: Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@kernel.org>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Casey Connolly <casey.connolly@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Alexey Minnekhanov <alexeymin@postmarketos.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1169;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=YSFdp9qwJO7gqz/Gl0gbC+wX4kiO90sj5ZxkGoLTdHI=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBoYrWf/NS5D4OIRhUnPC0pdfxkEeJavKXqIIOmGtbx
 SRXst7WJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaGK1nwAKCRB33NvayMhJ0azLEA
 CC0GE7ucMWJAOHYOLhH5QSfzkIKXkWtH2y+BumI6txO+MaVJq3l0+pc1eWL09ulpIGn/WJFfA5RLyI
 PQKWiTi1a1fXaO3y8NTockgoMzaNXWYFUmeOqu+iyJVJ+qh1sj2Oci5+SFUK+EO6AmBf0n8b1L6PD3
 mwiouPaEBnHknMsFDjZCW5liteGXOsCoS9mxxBlP5g5G/bqhenF8PRhP0cOTgSKQbWifuMLX9bhrC7
 PrUoKz48Pggd0ENcygo5ZJaRoksU6ZV75DrBTGRmODzdOGA7nE4Zodcqa4NEpT9Hj42n+5zfyHLk+0
 +mTWqop2cZk+wFqdoG3xHRzLGwNX6Yv10p9OlkcEUrs7YLFp0qtwuG+KsEDRGWAWsUGQKczDyXmzLE
 rL2LKuDmlL/BAm8k7v1r28bh2A7WVrRW74jWmfoyMtvpNfrKIwb3Z9wbfCr8GJq6QiWwFE3SbCJUoI
 67g5gXJ2q20XzM/37F1FTsfqNYGh9FQu354Xa3/0EjWaIrKtmI2OxUaACIm2AotmZLqr4wAQOd1hwh
 ffxEUDQ+XYiIkcuulB4+YxtR+/eBl+ulbOf5+qRNQmkJYWAlLStKZwlt56iCakSIKP9dH4Bp0F4wyK
 EEALJ/NmDelP8bvvi6Y3ZJyDvlmigRtpUXcC0eCdlKY8OHqdhlslTRm5ZrQg==
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

The current SPMI gpio driver is very old and doesn't support
pin state tracking to fully support the whole pinconf calls.

The simplest is to rewritte the driver using the v6.14 Linux
driver and fully implement pinctrl, pinmux, pinconf and gpio
support using all the newer interfaces.

The goal is to deprecate the old one it has been validated
on currently supported hardware.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v2:
- Collected tested-by
- Rebased on next
- Link to v1: https://lore.kernel.org/r/20250401-topic-sm8x50-pmic-gpio-pinctrl-new-v1-0-74077ef0b464@linaro.org

---
Neil Armstrong (2):
      gpio: qcom: add new driver for SPMI gpios
      gpio: qcom: move pm8550 gpio to new driver

 drivers/gpio/Makefile         |    2 +-
 drivers/gpio/qcom_pmic_gpio.c |   20 +-
 drivers/gpio/qcom_spmi_gpio.c | 1035 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 1037 insertions(+), 20 deletions(-)
---
base-commit: f2220962f9cb1366bfc003ec2cc5650499c68895
change-id: 20250401-topic-sm8x50-pmic-gpio-pinctrl-new-2588c35a461c

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

