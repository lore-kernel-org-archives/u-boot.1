Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23E34C87FC5
	for <u-boot@archiver.kernel.org>; Thu, 24 Jul 2025 15:33:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B612838AB;
	Thu, 24 Jul 2025 17:33:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="q0twLCJu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16409838C1; Thu, 24 Jul 2025 17:32:59 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2BB3683844
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 17:32:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-455b002833bso5290795e9.0
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 08:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753371176; x=1753975976; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zAH4/5l5ttN4AuGxqo8lmtUqEQsVBIY81omB1hnBbt0=;
 b=q0twLCJuviIWiKinxaBHK7bVB9aV8TCqNU3AyMw8NGr8qkaW8YotC1EDNe1R3ra0GG
 J6GuYEkqcO72hM7mDwWkKXFINLwGm0jMQiDOcAO8k/fQHjirU5o45EOHdT9whLEkSL6f
 OYQmcQ4I/FOIetXeyXP8EW4SVMFd4KpMinCViDZTtJWWV1P+oPhqsWjemAwqOksYmG/Y
 uIg1yi+3+TyYoZouH1g5+M1RejtMdwK0lQyxXXlHk/yQ++azHnv14cmwQcxl72es33mh
 SqHwLQxHU02zHb2+iCbLpthXEjXTV0AGQ7uT50TPCaId1aDZs/JVFx3KdRul1r+SsaYE
 08sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753371176; x=1753975976;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zAH4/5l5ttN4AuGxqo8lmtUqEQsVBIY81omB1hnBbt0=;
 b=M/SkkKw4xNKyTBkfTCM6uWi+SvGwepJAYLZ9ln4vo0AYW2NVkjBakHEtXxJHauqn+I
 5dZHnEcVmgeXGiukarmCdirdw/ACKmfyxOdOD9NRVNBM8KgdD00A3ZHxZ/1nPXRkHVYA
 bXf1S7tyomJdBIS0Xw8QNA/WwORmvAAUL/zNz3LNvwZk0Z6MhjHobPQqSDlKawnbgftn
 pC+rV8ZtyOxaIoy6PKb/I/smezSd1ZuhkSM7RvfyjRXN9qAIpiImBF3SxUHW/I8q49hC
 sxwPe0BMgqhaA2mo0e9hY4ZJicoOVV3xrUdiSLCDiPmJULNTROou9Y3GyAE4k8ymWtf2
 1ddA==
X-Gm-Message-State: AOJu0YwNkA6ndDwg07yZS4qmdCNXpCHveFH2S4DsJI/qiLktakib46Ar
 CXkqdmFZPUphOaljFvZmZ+C9AhUv1sIC2k0zJyAv8GUERnZ1tIN3+H1KCt853Ht3/7LJSISZSw7
 ZpSunNq4=
X-Gm-Gg: ASbGnctGj/JciWTaMC3ASSRzp/F+kfmp+EvDlcca88piYAxyTsIql5HbsPRQDaYnVKM
 XYmvrfLsEh9jyzcT2VRiBgPTv4dMsZnkQxs9I4xBv8rEoVwGuRchbAaa4YsQhwSyO6z9dKUSewL
 AY5NZznvF2VZMbP1RI1B7/Z69jb2YQzUI0EWkemrgnF66hxO6K4f+3nN7TkxEUjZrB20VQUe5d7
 SSPtUEpqltDqZsTLo7bIPprA+PODYcrMQ5MhScT+feVhuVhkojGIz/sz+uzpI5M/NaMdxyUj1LQ
 q7t3fqZa69Y0nIYSf39pHim2Ir/KKevNb40RJv0ZLdkMKplt0nyzSw0Ts/kEIg2m5XJ3PLUVcHe
 toiVvRvBQ7rpFyR2GnTZxDfI/cETybAu4//omDU2hNiGp8P6IOmw=
X-Google-Smtp-Source: AGHT+IFniVsIaw1DEOMgC890a8Egr78l3gjmwdCDOrfvOEXXvzBrpcRmAfHddgIf9xDstsx3KgPnLQ==
X-Received: by 2002:a5d:588a:0:b0:3a4:ee51:8144 with SMTP id
 ffacd0b85a97d-3b768ea0012mr6114128f8f.13.1753371176400; 
 Thu, 24 Jul 2025 08:32:56 -0700 (PDT)
Received: from artemis2.elfringham.co.uk
 ([2a0a:ef40:f9e:3c01:e4d2:a911:6ad2:b1ce])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-458705684a8sm23644485e9.26.2025.07.24.08.32.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Jul 2025 08:32:55 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
Date: Thu, 24 Jul 2025 16:32:55 +0100
Subject: [PATCH] ddr: fsl: Provide initial value for zqcs_init
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250724-ddr_fsl-v1-1-cedcac10dddf@linaro.org>
X-B4-Tracking: v=1; b=H4sIACZSgmgC/x2N0QqDMAwAf0XybKErq6K/IjJiG2dAO0mGCMV/X
 93jcQeXQUmYFPoqg9DByp9U4FFXEBZMbzIcC4OzztvWPU2M8pp1NQGbFruGPHoLpZ5QyUyCKSx
 3v6F+SW6xC818/hfDeF0/dRCQbXIAAAA=
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Andrew Goodbody <andrew.goodbody@linaro.org>
X-Mailer: b4 0.12.0
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

In the case of !zq_en zqcs_init is never assigned to although its value
is used. Correct by initialising zqcs_init to 0.

This issue was found by Smatch.

Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
---
 drivers/ddr/fsl/ctrl_regs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ddr/fsl/ctrl_regs.c b/drivers/ddr/fsl/ctrl_regs.c
index 9a25192c079..fea08c9000f 100644
--- a/drivers/ddr/fsl/ctrl_regs.c
+++ b/drivers/ddr/fsl/ctrl_regs.c
@@ -2173,7 +2173,7 @@ static void set_ddr_zq_cntl(fsl_ddr_cfg_regs_t *ddr, unsigned int zq_en)
 	/* Normal Operation Short Calibration Time (tZQCS) */
 	unsigned int zqcs = 0;
 #ifdef CONFIG_SYS_FSL_DDR4
-	unsigned int zqcs_init;
+	unsigned int zqcs_init = 0;
 #endif
 
 	if (zq_en) {

---
base-commit: 3532f1f5edfc97c9dcea723cdeb732eda44bc669
change-id: 20250724-ddr_fsl-ca67a96e5a50

Best regards,
-- 
Andrew Goodbody <andrew.goodbody@linaro.org>

