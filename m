Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55B1BCDB465
	for <u-boot@archiver.kernel.org>; Mon, 16 Oct 2023 22:35:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9BB286F0D;
	Tue, 17 Oct 2023 00:30:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SPZXVbpl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C74EB86E16; Tue, 17 Oct 2023 00:30:26 +0200 (CEST)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C76586F03
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 00:30:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-66d17fd450aso38547156d6.1
 for <u-boot@lists.denx.de>; Mon, 16 Oct 2023 15:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1697495401; x=1698100201; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3xUIaEJFr06pWeLhi4v6OekZ5y6fvvwftcGl9ZWwmJQ=;
 b=SPZXVbpl2IuIqwoNvzbGc+Y9u4dapF4yfjxXFhlUkHRYgSNFln/4V8ZIOJKaADsVsw
 TjauDGOQcN+aookpeifm4hAbfWqLG09oXL9MIVet8qgs/8+x5Jp9yKZzoY5uhk1u+2P9
 eaSlVS7wU8aAob0w/GeueJE1Q6F6OOh9aQWuY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697495401; x=1698100201;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3xUIaEJFr06pWeLhi4v6OekZ5y6fvvwftcGl9ZWwmJQ=;
 b=R42Kr/jdrebMtJnYscQldOiTQku1f5Dg/+Q6KqLhw5fchQmf6f/xCqh9BvweeS/Vps
 1zKenkwGxRSOdcc5cAkWqGI1VxVjpAqeJFAt1kHTXHp/HAyeWHPIqcmyufoKNb9DOz+Y
 1K9pZB90LHSDq5AvKe2gb12k1DJYFoVN7kQnv6wtyVA51to5zkeJL3Ln8N+kbCq/BVZx
 aXAnU9WQpyGDoA6bpWJnKWAxpkXa5HdK+G+Zoo6cd8nKFxrvCm8OOk5bucAU2jRZAfJ1
 E/JnZwP4eeythHjb4PBcfuVs7LwtKpDrkBTTCcQnzDcbTyNXcMjzk9zeUNMKXy3BBoRg
 NTWA==
X-Gm-Message-State: AOJu0YzqwAukVCAJYr7vuUEK1fwDp0t3e4MuJ28r9GZmsBo9Rgy5mOXx
 eEkpIS2IFKBj0CESJ9Nb9R9RluEp+cjM/Gk67YBMcg==
X-Google-Smtp-Source: AGHT+IGu/1ykj5uqAKVpG/Ig5yJmhvLLfdgXcEsMAyhJu9AHIKjMuSjAkOdmCdDK3lRte4CC3mm3Dw==
X-Received: by 2002:a0c:d6c7:0:b0:63f:8839:658 with SMTP id
 l7-20020a0cd6c7000000b0063f88390658mr226815qvi.1.1697495401179; 
 Mon, 16 Oct 2023 15:30:01 -0700 (PDT)
Received: from sjg1.unitedwifi.com ([205.220.129.18])
 by smtp.gmail.com with ESMTPSA id
 z14-20020a05620a08ce00b007671cfe8a18sm101802qkz.13.2023.10.16.15.29.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Oct 2023 15:30:00 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 07/32] fastboot: Declare a dependency on CMDLINE
Date: Mon, 16 Oct 2023 16:27:58 -0600
Message-ID: <20231016222835.596572-8-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
In-Reply-To: <20231016222835.596572-1-sjg@chromium.org>
References: <20231016222835.596572-1-sjg@chromium.org>
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

(no changes since v2)

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
2.42.0.655.g421f12c284-goog

