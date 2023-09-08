Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1B11EEB56F
	for <u-boot@archiver.kernel.org>; Fri,  8 Sep 2023 20:37:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20B5086A78;
	Fri,  8 Sep 2023 22:37:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="seftYWyl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1227B86A80; Fri,  8 Sep 2023 22:37:32 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C8DA86A5F
 for <u-boot@lists.denx.de>; Fri,  8 Sep 2023 22:37:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ilias.apalodimas@linaro.org
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-31adc5c899fso2522899f8f.2
 for <u-boot@lists.denx.de>; Fri, 08 Sep 2023 13:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694205449; x=1694810249; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8/LBgAXA5Lhthm6Cb7lwYgJL9iPQarlGWiCmTiIVPvk=;
 b=seftYWylk2i+hiL99f6zcWFDRGU5MKHn5tjL3IHXDjS/XYS7QNOL6Ce/bPIVYfsm+w
 sQJL9cPU7Xz++WmaLHHZuxfO+SFw+jJ2EO+I7czvGiecLwbgxnyGEqJ+9+pKI2xsO717
 vcwPsOPZCv86Xx9Tib7hej4gsXKSb9fj2vEZTB6FT9i33FPwHOrbLxaqS5OcmL1GlS/T
 /T6BieAyDxC3vHg4URSvlozu5+qi+xwVPGR0fHyGQYQ4+fMWJzgDIt+Xw/9fnVWPWc8c
 qIPvAZQtrlATR4KwmKO9jTmWsAZuCRSyoiHiAZnT4ijPLOkVsGIHzagCob5fKaVcUfc9
 TYAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694205449; x=1694810249;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8/LBgAXA5Lhthm6Cb7lwYgJL9iPQarlGWiCmTiIVPvk=;
 b=DB0wxmZVgRkneiYym7Ji/z5qkvYyfU2LthroYf2ws9IEpKH/G//+uT5mJbIO0L/K1Q
 LbOydfNOjidsaod7UNQ9vST7j5Phott74yY7+ZnkewBOlWmXPtVDeGdda+7V7x4HeQQX
 U/2uSQncBB+oRYap4i6sep5W53AmLRZVGsMxWT8WpjrOnAo0fJVr6qurVDFgb/Mr6jCu
 TnlQL3Yq4YMW/N5hwP//deA+ZALXjLg0PFMFKp8rRXAPqq42712W5AO5Y7bUP1FYfkeo
 hRY2EUdBB4c8qzrouB1oe1eCIgepCLNh/Xg7+C2V0Y7wLwbqfkl6/feA+VmlYfKajWjn
 BJNA==
X-Gm-Message-State: AOJu0YxEr1NdHpT+KKz5EMP/Bjaxf+WNzshURq/oCNNWUCdHJCM+x2/U
 q+4WQdjnZdevNvIoOL4QoFZiwUNiKepN+xd9INs=
X-Google-Smtp-Source: AGHT+IGfDEP8fNmzzqLS0c+gqeAX9epJSpDqvkK/PSYdxFaXDiTy6lkF8mqI538xJY8bv/AX7NFOPw==
X-Received: by 2002:a05:6000:1b06:b0:318:7bc:122e with SMTP id
 f6-20020a0560001b0600b0031807bc122emr2833476wrz.23.1694205448948; 
 Fri, 08 Sep 2023 13:37:28 -0700 (PDT)
Received: from hades.. ([2a02:85f:fcb3:de74:3efd:feff:fe6b:c5ca])
 by smtp.gmail.com with ESMTPSA id
 h5-20020adfe985000000b0031ae8d86af4sm2910062wrm.103.2023.09.08.13.37.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Sep 2023 13:37:28 -0700 (PDT)
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: u-boot@lists.denx.de,
	xypron.glpk@gmx.de
Cc: sjg@chromium.org,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH] tpm: Fix autostart for TPM1.2 devices
Date: Fri,  8 Sep 2023 23:37:22 +0300
Message-Id: <20230908203723.5702-1-ilias.apalodimas@linaro.org>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

On commit e663b2ff4ba2("tpm: Add 'tpm autostart' shell command") an
autostart function was added for both TPM1.2 and 2.0 devices.  Instead
of correctly wiring the autostart command for TPM1.2 devices that patch
mistakenly added it on 'tpm init'

Fixes: commit e663b2ff4ba2("tpm: Add 'tpm autostart' shell command")
Signed-off-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
---
 cmd/tpm-v1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cmd/tpm-v1.c b/cmd/tpm-v1.c
index 3b95c950cc96..1b1efcd204d2 100644
--- a/cmd/tpm-v1.c
+++ b/cmd/tpm-v1.c
@@ -655,7 +655,7 @@ TPM_COMMAND_NO_ARG(tpm_physical_disable)
 static struct cmd_tbl tpm1_commands[] = {
 	U_BOOT_CMD_MKENT(device, 0, 1, do_tpm_device, "", ""),
 	U_BOOT_CMD_MKENT(info, 0, 1, do_tpm_info, "", ""),
-	U_BOOT_CMD_MKENT(init, 0, 1, do_tpm_autostart, "", ""),
+	U_BOOT_CMD_MKENT(autostart, 0, 1, do_tpm_autostart, "", ""),
 	U_BOOT_CMD_MKENT(init, 0, 1, do_tpm_init, "", ""),
 	U_BOOT_CMD_MKENT(startup, 0, 1,
 			 do_tpm_startup, "", ""),
--
2.37.2

