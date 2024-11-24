Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ECF5E6780A
	for <u-boot@archiver.kernel.org>; Sun, 24 Nov 2024 20:29:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 539688984B;
	Sun, 24 Nov 2024 21:27:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wYvsJsT8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E95EA8995B; Sun, 24 Nov 2024 21:27:51 +0100 (CET)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F25B4895A4
 for <u-boot@lists.denx.de>; Sun, 24 Nov 2024 21:27:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=caleb.connolly@linaro.org
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-aa55171d73cso45088166b.0
 for <u-boot@lists.denx.de>; Sun, 24 Nov 2024 12:27:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732480069; x=1733084869; darn=lists.denx.de;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=XTnj2V+fCGfjE3UXwJb+V6Ed8v35O0pP0mKPTMlEpv8=;
 b=wYvsJsT8iB8jk3O1eCc6nUjPtK6h4vreJlxHU3cJlD1xO3uA37JC3jjldHP6b9Wklf
 kQZK80gnpeHGuHVsSCisbfSho+kjb1wUfcV252PkDLZS04DOzawtVNhY22fWJXYWg4UH
 Cmn01FXWC8qz+1DA9vtHvw2cSXIEdBs0EkZSU/MGxMWUgQ8w/R+abM67Fl+0hXCUKHRc
 ZQQJ1AJtpiibibFd0gFQiagP66cuzQVdn6P3ekeWlCvmkCzhtODrZOimuZ0MxP+b//IQ
 sc5FOphvlRtiHK/i9Mq51ck6i6s1xNpLcC2HKeyoE/RC5xvUlYU7O3kUXz+W2Zs/wblR
 gTlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732480069; x=1733084869;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XTnj2V+fCGfjE3UXwJb+V6Ed8v35O0pP0mKPTMlEpv8=;
 b=oOC/x9KW9b9QK4n8zlYNNtwtRTKMhM3rHC4UVqkPUmtzjj/NBJfjfkrvQWn+oe366e
 P+nle/5Bk16Buska3fPhyIsGel5e1kLd67Ge7hXIWIASH4sZ5ZOvzU0LkOsHahGegaY8
 wtVT4T/kYNVe1Yk2O2txKSyZ/CAXWZ4ldKgkOpmLS5v8gAnA/1+RxP75oxz1W4AVBNYy
 ej4DSVGaTF8Ixu0Yagh+xQJp6CHQoi9JwPO9QljZjHoRInZlb7ZT+YssSqqA5JiGQUTo
 /wIDKybYAHrk6MEpI677TqBWAcSzwR6i185Hp6hAyLp4Zs9xSRPP5Vcg1jPMQoTWX0E0
 lerw==
X-Gm-Message-State: AOJu0YyMeV9jy+ITuY4e9OsjCHiJa4BciJcp/N7mECWRGptnKmaEytEE
 omFE6AAdYQKQ/YrywbLi9V+FnBx5/ceD8TjJRIt63ekks6md3Au0nZEoYAPjsvE=
X-Gm-Gg: ASbGncsL/onFblD9uCxUUgL7axypC/AhewFbFjcao13oSrZoO+YSytr5Cx4a8wdFvCu
 fNrp+tLg97rHrhCqjniQ7Thjs+XFWdkIigeZ3QAEhrM/U33offPUIYlpfFtXb4n1H2VPFFYlL7w
 VmG+W+98GD4Zlfr2UYXU3Hmi0r94SQ2cIngxhwuHYfnre60tn99NNfDcC8U9/9Srs/3ryT7+Dsz
 goQ/Zzua66D4+e193fPC+9Nh60wH2xnlfxmdjIrBHjf5zxVvmmZ7rLgabqsaSQKh50Y
X-Google-Smtp-Source: AGHT+IEE89lC6WWdy6DxoycyKst2v71ujXM6Vx5bhjwNC4Lswlr4iLKc/16LjZ6hKAGkd/T7BGUzig==
X-Received: by 2002:a17:906:1daa:b0:aa5:37f1:ce63 with SMTP id
 a640c23a62f3a-aa537f1cef6mr487720866b.32.1732480069514; 
 Sun, 24 Nov 2024 12:27:49 -0800 (PST)
Received: from lion.localdomain ([2a02:8109:888d:ff00:ca7f:54ff:fe52:4519])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa50b28cda1sm378720666b.9.2024.11.24.12.27.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Nov 2024 12:27:49 -0800 (PST)
From: Caleb Connolly <caleb.connolly@linaro.org>
Date: Sun, 24 Nov 2024 21:27:10 +0100
Subject: [PATCH RFC 14/14] configs: add x1e_defconfig
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241124-b4-efistub-arm64-v1-14-3e33f0340071@linaro.org>
References: <20241124-b4-efistub-arm64-v1-0-3e33f0340071@linaro.org>
In-Reply-To: <20241124-b4-efistub-arm64-v1-0-3e33f0340071@linaro.org>
To: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>, 
 Anatolij Gustschin <agust@denx.de>, 
 Caleb Connolly <caleb.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@linaro.org>
Cc: u-boot@lists.denx.de, u-boot-qcom@groups.io
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1620;
 i=caleb.connolly@linaro.org; h=from:subject:message-id;
 bh=u5YEv9aLJ6aJE9FD/crDptwvK0hZP0TbWUtL5V+XcZU=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhnTnHuPDZ0MzK3bxVPAvCNGUUcqYd8yHWzq6jtHKjyN0w
 pdZ7z53lLIwCHIwyIopsoifWGbZtPayvcb2BRdg5rAygQxh4OIUgImczmf4X3eEISIxuExs2V+n
 ExI+fmVx/ZpZHO++79q/7oVGYN+dTIa/4jkm4kGMu5Y7f+uZMsVJuWZtrtsExdK+VzpC+/VqLbL
 3AQA=
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

Add a defconfig for Qualcomm X1 Elite based devices. These boot U-Boot
using EFISTUB from their stock EFI bootloader.

Initially we support display and USB, keyboard will require i2c-hid,
NVME will require PCIe support.

Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
---
 board/qualcomm/efistub.env | 11 +++++++++++
 configs/x1e_defconfig      | 17 +++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/board/qualcomm/efistub.env b/board/qualcomm/efistub.env
new file mode 100644
index 000000000000..5264603556ad
--- /dev/null
+++ b/board/qualcomm/efistub.env
@@ -0,0 +1,11 @@
+stdin=serial,button-kbd
+stdout=serial,vidconsole
+stderr=serial,vidconsole
+preboot=usb start; pci enum; nvme scan;
+fastboot=fastboot -l $fastboot_addr_r usb 0
+do_boot=bootefi bootmgr
+bootmenu_0=Boot first available device=run do_boot
+bootmenu_1=Enable fastboot mode=run fastboot
+bootmenu_2=Reset device=reset
+menucmd=bootmenu
+bootcmd=run do_boot
diff --git a/configs/x1e_defconfig b/configs/x1e_defconfig
new file mode 100644
index 000000000000..d60210f2ca5b
--- /dev/null
+++ b/configs/x1e_defconfig
@@ -0,0 +1,17 @@
+#include "qcom_defconfig"
+
+# Broken?? Probably an issue with mapping the memory
+CONFIG_QCOM_COMMAND_DB=n
+
+CONFIG_EFI=y
+CONFIG_EFI_STUB=y
+CONFIG_EFI_STUB_64BIT=y
+
+CONFIG_DEBUG_UART=y
+CONFIG_DEBUG_UART_ANNOUNCE=y
+CONFIG_DEBUG_UART_BASE=0x894000
+CONFIG_DEBUG_UART_MSM_GENI=y
+CONFIG_DEBUG_UART_CLOCK=14745600
+
+CONFIG_DEFAULT_ENV_FILE="board/qualcomm/efistub.env"
+CONFIG_DEFAULT_DEVICE_TREE="qcom/x1e80100-crd"

-- 
2.47.0

