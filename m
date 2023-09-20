Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53F05CE79A9
	for <u-boot@archiver.kernel.org>; Wed, 20 Sep 2023 03:01:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF8E186C16;
	Wed, 20 Sep 2023 05:00:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aNxAQ8bl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC69886C22; Wed, 20 Sep 2023 05:00:39 +0200 (CEST)
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com
 [IPv6:2607:f8b0:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7C7E86BFB
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 05:00:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-34fd83200efso12009415ab.0
 for <u-boot@lists.denx.de>; Tue, 19 Sep 2023 20:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695178836; x=1695783636; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uYwTRxZqQQH8b4YbS/lkKqUbcslyhg3JYLEoEi7E/KA=;
 b=aNxAQ8blei+KkhJ76K/Ln8RN0qxEW6rPhUksp9FUU42f8Ej2IKSVYFv7XC/i+6dMiS
 jv3MLomjXSrSttYW/GzRw/QoOxQ/qN8yKQTeDWaC3ckQ9vsAXjxyyb+UGY8xJyBT8mSa
 mCUa5eena0du7nF8cGI0SDiovkIgmceFWtgm8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695178836; x=1695783636;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uYwTRxZqQQH8b4YbS/lkKqUbcslyhg3JYLEoEi7E/KA=;
 b=VHj78pdG3hYHHQdcPR2CgvCL3OBHZ3OTd8AjJQp4dPZcfAPZvroDnytllu8K4ISazU
 OHTaBzI02NmNtVZ9ZmngAkDTCIjg9gqN/+bQz9OGMaK9SG3raybZO0BaaW3dOK1mJcwN
 c6OKAsNJ5gaN4coeyQN2mlcqkAbALf2hIjaQF4HV4UVUR2iT3N8wWUtcI+LvHP/L6rlM
 I88e7zixn8ef3RSPJ/ir8iPvxgywhxw3kaGa+Du5UBv2Z4A/+9JpP8RxutmtJ2EOQSHX
 87YnV1m8CgnporInDKIy4T1UiHlBduRSRKqx6G2HXp2+z8r9Oh20EfqXfk/x5VIQPOEd
 /aTQ==
X-Gm-Message-State: AOJu0YzMCQiChqoixylOM6W3P/euad9fo1wiEn0xpJ4XjLMVLB8Ou3za
 SPMtAjUoszxvMau04HxFsyU6Hm+fbA1NUm/6V30=
X-Google-Smtp-Source: AGHT+IGGkCA+LuCYwRt7lTITIzVqEBaR+3Ct8c2sY27D7AAeepJ19o/igiaOnTpFkkS7vKmb9SZN8g==
X-Received: by 2002:a05:6e02:156b:b0:34f:75eb:f81 with SMTP id
 k11-20020a056e02156b00b0034f75eb0f81mr1751404ilu.5.1695178836336; 
 Tue, 19 Sep 2023 20:00:36 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 s5-20020a92d905000000b0034feb68437fsm1835423iln.24.2023.09.19.20.00.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Sep 2023 20:00:36 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Bin Meng <bmeng.cn@gmail.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v5 05/20] x86: Allow APCI in SPL
Date: Tue, 19 Sep 2023 21:00:06 -0600
Message-ID: <20230920030027.1385833-6-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.459.ge4e396fd5e-goog
In-Reply-To: <20230920030027.1385833-1-sjg@chromium.org>
References: <20230920030027.1385833-1-sjg@chromium.org>
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
Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
---

(no changes since v1)

 lib/Kconfig | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/lib/Kconfig b/lib/Kconfig
index eb2b10161824..7edaeebfdaf5 100644
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
2.42.0.459.ge4e396fd5e-goog

