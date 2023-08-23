Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4F2FC3DA6F
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 21:12:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D4FAA86505;
	Wed, 23 Aug 2023 23:11:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Ac1a3HUx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DF196864E5; Wed, 23 Aug 2023 23:11:16 +0200 (CEST)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39D6A86445
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 23:11:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-790970a8706so216015139f.2
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 14:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692825073; x=1693429873;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Sijbmn1CVfq/RukuYjAfUr/xL2ytE8vIhvnMovt4hiQ=;
 b=Ac1a3HUxi6O8KeoFbAwbQP3LvGKTKl2FBJ+zalctA3hQvFdxzVO+Sy71OzWqLnPWab
 CfzZxcYIPQo/45TUTS14iWFSxyH8BX9oWNYKHyqmXIX9oK2aJ3Nh9VAYFEx+hiwMEuQD
 Rp6lX020EiKs0Bu04BRRq60qmHVs3nxWqvsdU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692825073; x=1693429873;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Sijbmn1CVfq/RukuYjAfUr/xL2ytE8vIhvnMovt4hiQ=;
 b=ZyoNFnyIoIG8qk/56JTiDEMcbSTCAjGwD61nNYo+OvfyDe4g3FzG1+yAhMdjJNzGzG
 oXo3Cv50M7Dgwp677Le9QEPU40VSIkWAReZPfL+Ks7KEML7lB0gPbWUgFKJjdERjzJlZ
 SbjZbAM6PPs+omDTAbcTpOVRORMGuogFWT0+s2Fhf1FkXd9Q4j4ADr5tKcRXPAtibGWd
 +BCJyihBNTrFDRSjNPQG3u7cH+JObWUmMvo5iGh6mjioS2OliRgSpYziOHzK4jcdzRFH
 AaeZBf6PMA9qBYkJRKZC1fBGlEr5Mo7z7wwhr0XtqWZaTbNsoNk6lS0hDaERmU9Fl1Gf
 OLig==
X-Gm-Message-State: AOJu0YxFlZogesK6cv8nqsj+oonSZsgmpUIvp0+EJZH0oWO8vJ4KsFQB
 cg80hHBBGSsoYHX7KJS7GDx3C0klI/Wt6iAuL80=
X-Google-Smtp-Source: AGHT+IEM0ymoT9aSjg0YY3ziH/pqySp1+2QAeOnVDzWJBFqU8iBqNpx5V3RBQbcHGOr62GLxO5AUlQ==
X-Received: by 2002:a05:6e02:1ba9:b0:348:d5dd:247 with SMTP id
 n9-20020a056e021ba900b00348d5dd0247mr4465253ili.6.1692825072861; 
 Wed, 23 Aug 2023 14:11:12 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:938f:460b:b19c:dee2])
 by smtp.gmail.com with ESMTPSA id
 c15-20020a02c9cf000000b0041627abe120sm3921075jap.160.2023.08.23.14.11.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 14:11:12 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 06/20] x86: coreboot: Look for DBG2 UART in SPL too
Date: Wed, 23 Aug 2023 15:10:23 -0600
Message-ID: <20230823211059.1235147-7-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230823211059.1235147-1-sjg@chromium.org>
References: <20230823211059.1235147-1-sjg@chromium.org>
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

If coreboot does not set up sysinfo for the UART, SPL currently hangs.
Use the DBG2 teechnique there as well. This allows coreboot64 to boot from
coreboot even if the console info is missing from sysinfo

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 configs/coreboot64_defconfig | 1 +
 drivers/serial/Kconfig       | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/configs/coreboot64_defconfig b/configs/coreboot64_defconfig
index 5623197f6be..e8165961c19 100644
--- a/configs/coreboot64_defconfig
+++ b/configs/coreboot64_defconfig
@@ -54,4 +54,5 @@ CONFIG_SYS_64BIT_LBA=y
 CONFIG_SOUND=y
 CONFIG_SOUND_I8254=y
 CONFIG_CONSOLE_SCROLL_LINES=5
+CONFIG_SPL_ACPI=y
 # CONFIG_GZIP is not set
diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
index 7ca42df6a7e..27b4b9d9650 100644
--- a/drivers/serial/Kconfig
+++ b/drivers/serial/Kconfig
@@ -672,7 +672,7 @@ config COREBOOT_SERIAL
 config COREBOOT_SERIAL_FROM_DBG2
 	bool "Obtain UART from ACPI tables"
 	depends on COREBOOT_SERIAL
-	default y if !SPL
+	default y
 	help
 	  Select this to try to find a DBG2 record in the ACPI tables, in the
 	  event that coreboot does not provide information about the UART in the
-- 
2.42.0.rc1.204.g551eb34607-goog

