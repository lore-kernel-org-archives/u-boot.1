Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67196CE7A86
	for <u-boot@archiver.kernel.org>; Fri, 22 Sep 2023 21:38:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8EA38689A;
	Fri, 22 Sep 2023 23:38:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KDQXD+2e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 15838864F0; Fri, 22 Sep 2023 23:38:31 +0200 (CEST)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 11F3486529
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 23:38:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-79fa425855cso38873139f.2
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 14:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695418707; x=1696023507; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uF+1RYekd1RK4zlNjjTSnyk6hQ0tjWzXjtSqPf/F12Y=;
 b=KDQXD+2eQLxFXDxFdgXGdgLwKI6fcbz4f0mzKP8bS/X5Ax0OKT52UaTkkEGxCnk1Fk
 UkeeFVPJdzVhwqUGLvqUE8fXStyOr+uo7kslsF+B1cA0Pu83azxgSdOjrPDMowWVIP5Y
 DFwcWtkD7O/ENWgP+CwywOrCRB+OpNa9ESqnQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695418707; x=1696023507;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uF+1RYekd1RK4zlNjjTSnyk6hQ0tjWzXjtSqPf/F12Y=;
 b=iNxs945wtefrITbzykyRMerMW+GY06oMbinrXUtg6KF3KLr02o41WISc0z05KvSo9c
 UhKQpp04vZzo4rsfem9/YFpWbh5kotprjwE6WpCdPMvWJQB/3f6YRfU9oZCLLaZ5HTwf
 WbeJmnEgV4wgd5ZgYDrDnhtw0WmXV+uQ8vntMiOzwheWqhG5+kWU4OTyGP3cTqjtRv1/
 slFg2o4flmRWM+7oOYZBqCQBPYY9Df9U6P+TuKD9CFQiafT8xY73IXfNRx0RUy3Jn8j1
 4CPwSPR56LJwpNinB3ThojJeTTlsao8PbddtSXThIdqeqoC9LAVvUwhjRsOCJBJAjUNh
 JkSA==
X-Gm-Message-State: AOJu0YwSbL1zXw+n2TM+vyn3zEw1pZ831KQTc7sr9CjlHsB6WXCFCE7z
 S3ap453fL4zsNKnWyZd1dGerZU3jnX/Qu+1e4OU=
X-Google-Smtp-Source: AGHT+IGFr4sKSDhEnKeHkfrjToj6XeWTwR/egL4TWjUyp3HWtiQeJ4fbmVW5rsyZIrjnHTVRImylFA==
X-Received: by 2002:a05:6602:2155:b0:790:f733:2f9e with SMTP id
 y21-20020a056602215500b00790f7332f9emr600184ioy.13.1695418707581; 
 Fri, 22 Sep 2023 14:38:27 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:9fd8:298f:4748:f9a])
 by smtp.gmail.com with ESMTPSA id
 y24-20020a02bb18000000b0042b09bde126sm1221477jan.165.2023.09.22.14.38.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Sep 2023 14:38:27 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH v2 3/4] x86: coreboot: Add a boot script
Date: Fri, 22 Sep 2023 15:38:15 -0600
Message-ID: <20230922153814.v2.3.I134d949e881ebcd532e927119703b28747fe4c53@changeid>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
In-Reply-To: <20230922213819.1886094-1-sjg@chromium.org>
References: <20230922213819.1886094-1-sjg@chromium.org>
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

Provide the user with a list of available boot options. Selecting one
causes it to be booted. Pressing <ESC> causes U-Boot to return to the
command-line prompt.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Add new patch to add a coreboot boot script

 configs/coreboot64_defconfig | 1 +
 configs/coreboot_defconfig   | 1 +
 2 files changed, 2 insertions(+)

diff --git a/configs/coreboot64_defconfig b/configs/coreboot64_defconfig
index 555d281ef3c..dfd47ebb1cf 100644
--- a/configs/coreboot64_defconfig
+++ b/configs/coreboot64_defconfig
@@ -17,6 +17,7 @@ CONFIG_SYS_MONITOR_BASE=0x01120000
 CONFIG_SHOW_BOOT_PROGRESS=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="root=/dev/sdb3 init=/sbin/init rootwait ro"
+CONFIG_BOOTCOMMAND="bootflow scan -l; if bootflow menu; then bootflow boot; fi"
 CONFIG_PRE_CONSOLE_BUFFER=y
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
 CONFIG_LOG=y
diff --git a/configs/coreboot_defconfig b/configs/coreboot_defconfig
index edc38f1f592..ca5e581f8f2 100644
--- a/configs/coreboot_defconfig
+++ b/configs/coreboot_defconfig
@@ -15,6 +15,7 @@ CONFIG_SYS_MONITOR_BASE=0x01110000
 CONFIG_SHOW_BOOT_PROGRESS=y
 CONFIG_USE_BOOTARGS=y
 CONFIG_BOOTARGS="root=/dev/sdb3 init=/sbin/init rootwait ro"
+CONFIG_BOOTCOMMAND="bootflow scan -l; if bootflow menu; then bootflow boot; fi"
 CONFIG_PRE_CONSOLE_BUFFER=y
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
 CONFIG_LOG=y
-- 
2.42.0.515.g380fc7ccd1-goog

