Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 293C4C35274
	for <u-boot@archiver.kernel.org>; Mon, 18 Dec 2023 07:25:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4578C87DDF;
	Mon, 18 Dec 2023 08:25:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="DY7hoNt0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0618F87DDD; Mon, 18 Dec 2023 08:25:16 +0100 (CET)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com
 [IPv6:2607:f8b0:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE68C87DE8
 for <u-boot@lists.denx.de>; Mon, 18 Dec 2023 08:25:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sumit.garg@linaro.org
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6d7750e2265so162792b3a.3
 for <u-boot@lists.denx.de>; Sun, 17 Dec 2023 23:25:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702884311; x=1703489111; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aKd8zKPaWd4l/PK9RYPjewh6HFEN9+PzrofUA1TQ2HY=;
 b=DY7hoNt0Ldbvg37+msMlKjkpx9hvTGZshFoRp6WOLatM9g514GzFwVqFWqaIuyC8uk
 CQIG3DqrXPIAZJnY3tR3imGOGmirW2Pt7bK/pS/+b6xOPI4MqWN11EMQazZjeLH6sPZI
 +QcnLEmbu8ILPmzYYP8mCq4cMj9/RP45B2BEYGG5w2HRGC9IEr8lFDsqWb5sy3BFXiIb
 Z/WhgdClJrWKXL4xil+CXqYAs4e760mAnHpX7jWGP8R60uKymGlf65Z8kAqp0QVFa+Ue
 /kJLubRy+YjfMIqk2J7WIhpVQMAm2aZLGQ/5cjTVyNVvetEoCOxTPfWtPBCnHXeWo9HM
 IBhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702884311; x=1703489111;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aKd8zKPaWd4l/PK9RYPjewh6HFEN9+PzrofUA1TQ2HY=;
 b=nykCKV2XPvJg0rOk+J9GRcMXSU//K21qwZWndX6VgV+lSgNUnvn7TznWtntS+TQnSy
 FHVDx6uWPcx28TNOBOPZP7CMA4LGF5yZq3t2UqpXUhNDnnLUFElswQDIofFkOCFD8fC/
 zdzMzj4uUQJ+a2FNQHWUMol++6HcQGgtBl3h6JOfXfKh7/nFJ6msYeKbUgHH2K3vozMS
 FvriWs2JB1+1xEeTUcBIra2AM2rLE/VMNIbGER4yZKW+ZXD9zE8qMe1o/TCEkGqdBRKp
 y6ra9UJVFfZw1zcQzrOJ/YZVEuoBod6VsxMPjYoN12NAHRLgHaqVd1eRfrWl45PpSyFW
 4Elg==
X-Gm-Message-State: AOJu0YwpcTtp3+rBguIMiyDblRq+Am7SCUPaYNkfO9br92EO4XXCdjW9
 qN+GJcO25z8OvIgiuSMCpO0dggusts83GPhuQMA0dQ==
X-Google-Smtp-Source: AGHT+IFLbrVjWiMzU6LVE7jojEcmZXaEkUVpuQD0z3ZgGbGjMnZ9Y+MQU8ybN2RYL/0pl/pnfViDtA==
X-Received: by 2002:a05:6a20:4285:b0:18b:9b41:eb90 with SMTP id
 o5-20020a056a20428500b0018b9b41eb90mr7975111pzj.10.1702884311138; 
 Sun, 17 Dec 2023 23:25:11 -0800 (PST)
Received: from sumit-X1.. ([223.178.213.6]) by smtp.gmail.com with ESMTPSA id
 nr21-20020a17090b241500b0028b8b269aedsm1038997pjb.57.2023.12.17.23.25.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Dec 2023 23:25:10 -0800 (PST)
From: Sumit Garg <sumit.garg@linaro.org>
To: u-boot@lists.denx.de
Cc: caleb.connolly@linaro.org, neil.armstrong@linaro.org, lukma@denx.de,
 seanga2@gmail.com, marex@denx.de, laetitia.mariottini@se.com,
 pascal.eberhard@se.com, abdou.saker@se.com, jimmy.lalande@se.com,
 benjamin.missey@non.se.com, daniel.thompson@linaro.org,
 Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH 5/7] hmibsc: Enable RAUC support
Date: Mon, 18 Dec 2023 12:54:26 +0530
Message-Id: <20231218072428.1802969-6-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231218072428.1802969-1-sumit.garg@linaro.org>
References: <20231218072428.1802969-1-sumit.garg@linaro.org>
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

Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 include/configs/hmibsc.h | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/include/configs/hmibsc.h b/include/configs/hmibsc.h
index 04052ed6dee..b614dec7870 100644
--- a/include/configs/hmibsc.h
+++ b/include/configs/hmibsc.h
@@ -16,4 +16,42 @@
 #define PHYS_SDRAM_1_SIZE		SZ_1G
 #define CFG_SYS_SDRAM_BASE		PHYS_SDRAM_1
 
+#undef CONFIG_BOOTCOMMAND
+# define CONFIG_BOOTCOMMAND \
+	"setenv devtype mmc; setenv devnum 0; " \
+	"test -n \"${BOOT_ORDER}\" || setenv BOOT_ORDER \"A B\"; " \
+	"test -n \"${BOOT_A_LEFT}\" || setenv BOOT_A_LEFT 3; " \
+	"test -n \"${BOOT_B_LEFT}\" || setenv BOOT_B_LEFT 3; " \
+	"setenv raucslot; " \
+	"for BOOT_SLOT in \"${BOOT_ORDER}\"; do " \
+	"  if test \"x${raucslot}\" != \"x\"; then " \
+	"      echo \"skip remaining slots...\"; " \
+	"  elif test \"x${BOOT_SLOT}\" = \"xA\"; then " \
+	"    if test ${BOOT_A_LEFT} -gt 0; then " \
+	"      setexpr BOOT_A_LEFT ${BOOT_A_LEFT} - 1; " \
+	"      echo \"Found valid RAUC slot A\"; " \
+	"      setenv raucslot \"rauc.slot=A\"; " \
+	"      setenv raucpart A; setenv distro_bootpart 6;" \
+	"    fi; " \
+	"  elif test \"x${BOOT_SLOT}\" = \"xB\"; then " \
+	"    if test ${BOOT_B_LEFT} -gt 0; then " \
+	"      setexpr BOOT_B_LEFT ${BOOT_B_LEFT} - 1; " \
+	"      echo \"Found valid RAUC slot B\"; " \
+	"      setenv raucslot \"rauc.slot=B\"; " \
+	"      setenv raucpart B; setenv distro_bootpart 7;" \
+	"    fi; " \
+	"  fi; " \
+	"done; " \
+	"if test -n \"${raucslot}\"; then " \
+	"  setenv bootargs console=ttyMSM1 root=PARTLABEL=rootfs_${raucpart} rw rootwait ${raucslot}; " \
+	"  saveenv; " \
+	"else " \
+	"  echo \"No valid RAUC slot found. Resetting tries to 3\"; " \
+	"  setenv BOOT_A_LEFT 3; " \
+	"  setenv BOOT_B_LEFT 3; " \
+	"  saveenv; " \
+	"  reset; " \
+	"fi; " \
+	"load ${devtype} ${devnum}:${distro_bootpart} ${loadaddr} /boot/fitImage && bootm"
+
 #endif
-- 
2.34.1

