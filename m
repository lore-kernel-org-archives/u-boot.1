Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C71FC678DC
	for <u-boot@archiver.kernel.org>; Fri, 18 Aug 2023 00:28:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F105486C2D;
	Fri, 18 Aug 2023 02:27:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="cUO7K2Az";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2843F86C18; Fri, 18 Aug 2023 02:27:22 +0200 (CEST)
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com
 [IPv6:2607:f8b0:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 69BEA86C0B
 for <u-boot@lists.denx.de>; Fri, 18 Aug 2023 02:27:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-349783c5d43so1393815ab.3
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 17:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692318438; x=1692923238;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9x3uiU5Y18KO4NomZO3T5cmrnLhli0YswUsOeEnCgHI=;
 b=cUO7K2Azf8gvLMYj8r6a4ggQh/dc+RCcF1vcK8N4pjPy2SY9GEbFK+6vAoO3t4Tb0W
 XgcfEQ6lOx6jcC0BUgPCFD9oOh/WYB0972qOrvu77L1AEgW/zIxp1tlLTsq2dYVXtvYE
 HuNzDp10C9VTLfaSLX76IrAO3nl0ZsCdNPNBU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692318438; x=1692923238;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9x3uiU5Y18KO4NomZO3T5cmrnLhli0YswUsOeEnCgHI=;
 b=eTnYqBcVnt3DOBxEplgNLCK8yfRYgX+514juLPdSzCdcdOXODm5lGDxaDg6iUmy3R7
 duwUUy7+uX9FGQZ9hBfCWX1zmmhjfeuiLCIVYcGEi0T7QyD7lxde62fYyWFLv/kLVsm8
 wEO5ZjCPobeSQqntzu69SnnOVlgsMobSYmmI/UcSfn83AGfjOIFyc2seXvttEidLSR8H
 xdbDi/DR7QZecPJgvt2LIvg9mKgALV0nMznQeB/scq1Ocs7bQmWy8jUKRmG1AnwqUGJg
 FttyUUppTlUEoFKtIuTJlpbxhJVOT1U4YPJ7+ezzoyC6MmS3B2+/mi3Xdk8qQ55aSgEr
 Fplw==
X-Gm-Message-State: AOJu0Yx3WjDe5x/gFP5SrhIyVwoUZOgyiXrjZMVZ3s6dYKm+wem0kxEg
 +LTroaHI69Ti/7PomilMJZoDtwDAAui84xm/KN0=
X-Google-Smtp-Source: AGHT+IHd7E/chG9jIvYGJGq6N0B2Xgisq14ZRSKtddKNUQJJ3bkmWctWFCjns7eNOLc1c1BoBo/n2w==
X-Received: by 2002:a05:6e02:13cf:b0:349:9665:38b with SMTP id
 v15-20020a056e0213cf00b003499665038bmr1029178ilj.30.1692318437968; 
 Thu, 17 Aug 2023 17:27:17 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 i14-20020a056e02054e00b0034bad471d1fsm190376ils.3.2023.08.17.17.27.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Aug 2023 17:27:17 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Bin Meng <bmeng.cn@gmail.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Brandon Maier <brandon.maier@collins.com>,
 Kautuk Consul <kconsul@ventanamicro.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
Subject: [PATCH v2 05/20] x86: Allow APCI in SPL
Date: Thu, 17 Aug 2023 18:26:44 -0600
Message-ID: <20230818002706.853550-6-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230818002706.853550-1-sjg@chromium.org>
References: <20230818002706.853550-1-sjg@chromium.org>
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

This is needed so we can find the DBG2 table provided by coreboot. Add a
Kconfig so it can be enabled.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 lib/Kconfig | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/lib/Kconfig b/lib/Kconfig
index 07e61de5b641..a9dca5f52b5a 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -289,6 +289,14 @@ config ACPI
 	  not necessarily include generation of tables
 	  (see GENERATE_ACPI_TABLE), but allows for tables to be located.
 
+config SPL_ACPI
+	bool "Enable support for ACPI libraries in SPL"
+	depends on SPL && SUPPORT_ACPI
+	help
+	  Provides library functions for dealing with ACPI tables in SPL. This
+	  does not necessarily include generation of tables
+	  (see GENERATE_ACPI_TABLE), but allows for tables to be located.
+
 config GENERATE_ACPI_TABLE
 	bool "Generate an ACPI (Advanced Configuration and Power Interface) table"
 	depends on ACPI
-- 
2.42.0.rc1.204.g551eb34607-goog

