Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D5ACC3601A
	for <u-boot@archiver.kernel.org>; Thu,  3 Apr 2025 16:03:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E2C282054;
	Thu,  3 Apr 2025 18:03:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="zeOXHE4g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38A1182075; Thu,  3 Apr 2025 18:03:27 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A399182006
 for <u-boot@lists.denx.de>; Thu,  3 Apr 2025 18:03:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=neil.armstrong@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4394345e4d5so7370355e9.0
 for <u-boot@lists.denx.de>; Thu, 03 Apr 2025 09:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743696204; x=1744301004; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xULLmeHarL7Eg3vXiKu+A2SrrgmS1T8pyxRNZ2r5zKY=;
 b=zeOXHE4gOKE3qvIIBqSpglYtED86aJ7f0eulK+Uy/ghEdjhB+ng7eEmWZvBOvuUPwL
 YeO5HCzAWN9qjwQ2YVZNo5lFAfiLJM0+aGTCzj05MDlkM6Qm+TTbhNAqTHxz0Jc25Mh6
 gzRhAA+5huBC2mAovBPb4XTHllFSnsPeVqRbKJsVsJr20nuptMXw5KxNRNlcs7Vci/6A
 wPigNG56IA2b2Fgr7rrH/JOCgcAJ/pBgSBbu36BUUErwFz+n+SkjgKkZn5mrI3JNAG2v
 EXk2Xn9ZQu5Buf41oRk+DZyfiq3gz4ThJkHkb2FLhIWfrQJZ8/JlPeAyjcrt8OMM3xLH
 uZwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743696204; x=1744301004;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xULLmeHarL7Eg3vXiKu+A2SrrgmS1T8pyxRNZ2r5zKY=;
 b=akqFcz+UJBKzB75AD7heN8CGk0rn3iej213jAXnyHWipZKDrephjxnuXr4gu3xWV3w
 OfFYeNfCkwQ5z1ElVaHBZF4m3MUXy2rE6bMkkVMKNRwSlo/sTye1s0T0m4WToFhjT7iK
 S0wRiBoGnadF+KkpECkfMCUheRlOVjvFjJ4ZGJuaN00859Yl5tMNCEroaNy1HIcf0A/e
 ZK3940hybVylyaqcrbJeKJPzjsrmLATZm5ZL0nr0Hkp+TSJJqYIPUBFo7nRohtPbilZy
 aylpDquyNzd6MxaHVFx1TYzSmsRMbRqn6hc8pb3p2eM0GGhNWS1KqgfhnifuLECYQz4R
 b3dg==
X-Gm-Message-State: AOJu0YwZ+EkespE2Ut6oX8lhHXM4vE1Z/SmO34lwMqv+Be2Yr1KTXr+Q
 v0V2y1wrPUiui13L2+QGVw+BS0py4po82T+W//we1KR2i2ZKZ8we1u7ojODBeCo=
X-Gm-Gg: ASbGncswOG9KbnWpA9xfUSRMOjA4iMJga4vm3fI2G6dO4mheWfA2MJLtPlxmePmzZZJ
 fbDL15UgsqEyLfMVIbvdZc/N0n2t8aLkbaHNg5Ue+jfeQUeBWHRjvSCNPDBWAHgJFLM5pgbv1lV
 o86D7bKzjCwbASfqAIGMR9ajxdep2O2cB5jx5SSpYUV7DicjWwoYRD1LXpRGQA2mGlnSExZyZPa
 S4WnU4qSducs++pKiBs1uQl6L23ddTK4yTYlfHWG5/xfl3Z0uBRdYW0fsH8a/Nlzk7kGO9mQ/gF
 bWxbmZ6q43bSWtfRsd5VkuJvRFmLMw9PF5QrHb2swIndFUZcVUaqWu+o7TgBzWKhOg==
X-Google-Smtp-Source: AGHT+IG01NcztaIBH7spTnJNvAWDtmtbpMzaDR+WTYB8Hx1WMIauFvEsUV8QCJ6LgOhvdza7eNF2DA==
X-Received: by 2002:a05:600c:1f96:b0:43c:e7ae:4bcf with SMTP id
 5b1f17b1804b1-43eb5b80267mr72716385e9.0.1743696203858; 
 Thu, 03 Apr 2025 09:03:23 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:3d9:2080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec1692ba4sm25213895e9.16.2025.04.03.09.03.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Apr 2025 09:03:23 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Thu, 03 Apr 2025 18:03:21 +0200
Subject: [PATCH] board: libre-computer: check interface before comparing it
 in set_dfu_alt_info()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250403-u-boot-fix-set-dfu-alt-info-interface-v1-1-1fdd12463186@linaro.org>
X-B4-Tracking: v=1; b=H4sIAEix7mcC/x2NQQqDMBBFryKz7kBMFWyvIl0k8acdkESSWAri3
 Tu4efAW7/+DKoqg0rM7qOArVXJS6W8dhY9Lb7As6mSNHc1g7ryzz7lxlB9XNF7izm5tLClmRUO
 JLoAfHhPcCOtDT7q1FWhx/cyv8/wDWJFKh3cAAAA=
X-Change-ID: 20250403-u-boot-fix-set-dfu-alt-info-interface-9be8ea5e2bc1
To: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3154;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=S56hhxrdZ7b/gS6dg8oNZg3c7/fkO+8IQUki6qRMmP4=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBn7rFKteoGKmqTi9XVKqn1pRqMPeDDgHtS7a+B4Z36
 R24BT16JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZ+6xSgAKCRB33NvayMhJ0QlpD/
 9CsnxKzKveDuXXYKO7y/m1rkib4LXYk2he2Xmfni+btneADdyQD0jAVjZPkKprX6HPwgg7cWMck1Tn
 gZrDK8CMDpk/lFiGrPKv4FQOdAIexTCPrSg2557HKs2ZWgJF7Pgn/d0d9PB+twaLtYrFs9QjiWyzgb
 vA6ig24aWly66ej5uYevHLu88D5yiY+rih09TC1qzP9sFShyPMLPMxED3V+/DQ6yw/WdPi9/QsH97e
 fYBA8hBG9skUMr8+tHj5GwmN27ffNzOiNbeTWeBFF3fDuuqOPV3/upGjNU1r1D9ZiP04XSXpm6rsnF
 wVBimWUfLaOSQr+pPAyIKSZA0sZtw3VmbY4yMvNLhNo2qSP1+b9w7ZTtu9AGdzJEquGH39HEE2HtTR
 5ivc/Yd1zKPYfmkXsCm/I270zvn/cPR4l83yKFlZkGRNyb3GBK8iRWvWMylV7i6A6Nve4IlH+xIupG
 REgkz4BWBffU82PAuT9uxJpMtpOjYL2nEcqXnKLVdzeYj6kJ4Gv2z7ZGVs9fQtwY0o4Pd3/otou3gl
 uOqmbxS7+qAjDruvfrqGVHtCXqbzUWC9m6biC+avoHKogW3DRt+yrJhAiwJnvu3S3p4OqjfMDioMop
 7C0Xmt9hlVVKa2fx77Nt8aKOT2FPCafZ02g+iwX4AQqFm3Fs8YjlEQ+BJkRA==
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

When set_dfu_alt_info() is called, interface can be NULL when called for
the EFI capsule, so check it before calling it with strcmp().

Fixes: 12ea40d29dc ("ARM: meson: add support for Libre Computer aml-s905d3-cc")
Fixes: 9e6e6b034b1 ("ARM: meson: add support for Libre Computer aml-a311d-cc")
Fixes: 75c87c6cbc0 ("board: libre-computer: aml-s805x-cc: Enable capsule updates")
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 board/libre-computer/aml-a311d-cc/aml-a311d-cc.c   | 2 +-
 board/libre-computer/aml-s805x-ac/aml-s805x-ac.c   | 2 +-
 board/libre-computer/aml-s905d3-cc/aml-s905d3-cc.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/board/libre-computer/aml-a311d-cc/aml-a311d-cc.c b/board/libre-computer/aml-a311d-cc/aml-a311d-cc.c
index e45cfd5d8a3885683dd6b1d0eea03084dc6dfdb5..294f78858a7848fe8255c9b9b42e2f556a6e05d1 100644
--- a/board/libre-computer/aml-a311d-cc/aml-a311d-cc.c
+++ b/board/libre-computer/aml-a311d-cc/aml-a311d-cc.c
@@ -29,7 +29,7 @@ struct efi_capsule_update_info update_info = {
 #if IS_ENABLED(CONFIG_SET_DFU_ALT_INFO)
 void set_dfu_alt_info(char *interface, char *devstr)
 {
-	if (strcmp(interface, "ram") == 0)
+	if (interface && strcmp(interface, "ram") == 0)
 		env_set("dfu_alt_info", "fitimage ram 0x08080000 0x4000000");
 	else if (IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT))
 		env_set("dfu_alt_info", update_info.dfu_string);
diff --git a/board/libre-computer/aml-s805x-ac/aml-s805x-ac.c b/board/libre-computer/aml-s805x-ac/aml-s805x-ac.c
index 94cf5b4361fac5003dded2f8dc2bfc9be7630099..1ec9a5b401e210045f1b13720f1e5c16e1f7f86b 100644
--- a/board/libre-computer/aml-s805x-ac/aml-s805x-ac.c
+++ b/board/libre-computer/aml-s805x-ac/aml-s805x-ac.c
@@ -36,7 +36,7 @@ struct efi_capsule_update_info update_info = {
 #if IS_ENABLED(CONFIG_SET_DFU_ALT_INFO)
 void set_dfu_alt_info(char *interface, char *devstr)
 {
-	if (strcmp(interface, "ram") == 0)
+	if (interface && strcmp(interface, "ram") == 0)
 		env_set("dfu_alt_info", "fitimage ram 0x08080000 0x4000000");
 	else if (IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT))
 		env_set("dfu_alt_info", update_info.dfu_string);
diff --git a/board/libre-computer/aml-s905d3-cc/aml-s905d3-cc.c b/board/libre-computer/aml-s905d3-cc/aml-s905d3-cc.c
index f641db5a494f358ed89591fae06e66eb18f85709..b552035ee03a7b848455ae6564688b4a12e02326 100644
--- a/board/libre-computer/aml-s905d3-cc/aml-s905d3-cc.c
+++ b/board/libre-computer/aml-s905d3-cc/aml-s905d3-cc.c
@@ -29,7 +29,7 @@ struct efi_capsule_update_info update_info = {
 #if IS_ENABLED(CONFIG_SET_DFU_ALT_INFO)
 void set_dfu_alt_info(char *interface, char *devstr)
 {
-	if (strcmp(interface, "ram") == 0)
+	if (interface && strcmp(interface, "ram") == 0)
 		env_set("dfu_alt_info", "fitimage ram 0x08080000 0x4000000");
 	else if (IS_ENABLED(CONFIG_EFI_HAVE_CAPSULE_SUPPORT))
 		env_set("dfu_alt_info", update_info.dfu_string);

---
base-commit: f59fb9846c5a1d129f78b2945a094477388fd346
change-id: 20250403-u-boot-fix-set-dfu-alt-info-interface-9be8ea5e2bc1

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

