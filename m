Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E85C5E95A68
	for <u-boot@archiver.kernel.org>; Sat,  7 Oct 2023 23:25:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B7DDE86F34;
	Sun,  8 Oct 2023 01:16:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mvg0fbmw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 890EB86EFA; Sun,  8 Oct 2023 01:13:59 +0200 (CEST)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CEF8F86EF1
 for <u-boot@lists.denx.de>; Sun,  8 Oct 2023 01:13:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-35135b79b6aso13494195ab.0
 for <u-boot@lists.denx.de>; Sat, 07 Oct 2023 16:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696720391; x=1697325191; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JAdFTzAv9Q1wHJD86uM0/bfWj5SLUCU1+srVYUe51Nw=;
 b=mvg0fbmwwpvlVP3/PXBgErDo3sX6HN3eJEVPu7VyQZtn5RHoKO9Fy8dVKfo4dn9jKt
 eN2wtEKfw++T0+ZTZ4kIT+oTn4MpAhvys8K7oL74yowhWUBGc3l0o4NJ2rE5is597Er6
 7Oy2pvhP8P/gbQkWtWnuTE0/OyN2nb/MTF9dE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696720391; x=1697325191;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JAdFTzAv9Q1wHJD86uM0/bfWj5SLUCU1+srVYUe51Nw=;
 b=rabd4n1dIQEVMgeTv5g/tTVPpwlte7JLfnP0v9AUJgQPqlIabmd9Es/4XY2DERGVpL
 SXufhPiGkLPwL6SbR4v4UfL6Q1BfwL09JMNBMn2hLmnVc4vAHod5rpetUywaz3yM71vC
 xqIM0IgFE4mMr9tmMGGV1xsBxyLiixl0YQa0OIfGT7n331m7mIleHezljyMntECUS3M4
 zDokTeFZV0JOOlWv5/pWwARLaGsd8J9iCgO2+mToPOrL1Wsv+W9JUIh2uDI4k395IHh1
 Vl9uH9SYHsz44dSg+AV6cdz6NuApflpH+r5kW0nvk5i6FHy8UmhNqpqJfmciBpc1PUne
 T5+A==
X-Gm-Message-State: AOJu0YwEjrf0XP9rIlsCQLoqAyS/8XoihE/bRu8/C5nczl/HyCl4WUiB
 v93zCYSjYw+cPfAjvWp2qOvFDT7mByDrePgp9j8=
X-Google-Smtp-Source: AGHT+IFSvPlNpeuchf7AAEzDwDV2dOs0hNidpfjoMFkiAc9Ud7GgGcVQ8x9mXCzcTmCfSF5/EuZE+A==
X-Received: by 2002:a92:c24a:0:b0:34f:6dbb:6a2a with SMTP id
 k10-20020a92c24a000000b0034f6dbb6a2amr14647852ilo.7.1696720391439; 
 Sat, 07 Oct 2023 16:13:11 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 x7-20020a92de07000000b0035129b9c61bsm2002320ilm.45.2023.10.07.16.13.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Oct 2023 16:13:11 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 09/27] fastboot: Declare a dependency on CMDLINE
Date: Sat,  7 Oct 2023 17:12:28 -0600
Message-ID: <20231007231255.277623-10-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
In-Reply-To: <20231007231255.277623-1-sjg@chromium.org>
References: <20231007231255.277623-1-sjg@chromium.org>
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

When CMDLINE is not enabled, this code fails to build. Correct this by
adding a condition.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Change this to use a Kconfig dependency instead of code failing

 drivers/fastboot/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/fastboot/Kconfig b/drivers/fastboot/Kconfig
index 837c6f1180da..24b100f381fe 100644
--- a/drivers/fastboot/Kconfig
+++ b/drivers/fastboot/Kconfig
@@ -2,6 +2,7 @@ menu "Fastboot support"
 
 config FASTBOOT
 	bool
+	depends on CMDLINE
 	imply ANDROID_BOOT_IMAGE
 	imply CMD_FASTBOOT
 	help
-- 
2.42.0.609.gbb76f46606-goog

