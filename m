Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E757FC6FA8F
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 20:00:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A752D86A1A;
	Thu, 24 Aug 2023 21:59:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="YMfZmdAF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68C7F869B7; Thu, 24 Aug 2023 21:59:33 +0200 (CEST)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6EE5869FD
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 21:59:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-792623074edso31780239f.1
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 12:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692907168; x=1693511968;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aSstTT7N0bnxhZqk1HfxuZOzmBM+9yc340zFKd0wwsE=;
 b=YMfZmdAF6MZmajXK/enE/2RMEBqwGW4pZ2sMwQBOjkdrvkF2sJiLC3qjSrpozrzmqx
 e4x9AO2UQXyo6fCUaeSSYlHZt7ZAHk9e17F6i1ec0DOLKxVHQKH3cTCUEnsinadMQaJK
 MUE1IbN0N/yBrZS6pcVsOY2wIbqJmdNPn1l/k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692907168; x=1693511968;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aSstTT7N0bnxhZqk1HfxuZOzmBM+9yc340zFKd0wwsE=;
 b=Yb2kQBlnG0DDkMRleL6R9MS59dBXnwTOgx9EdQkUVVMhzgZ03iYoMzL3vERtSulZZm
 dwoKuiIR3VxLZJCZ1aE4PuhbORwx2Egc7IwemcbAJqGxa6t6PgB2OVAYxOaZ/42z61Im
 KFp4GGPEiukS5Q38IVdqdSFYhfnyEy/x3th2URmEUwUfv8tfrcOSvuRt2UizFv/k+Ylo
 O/80ZTEcwGvRu7kuYpNStklMA66nvKlFP4JN85jFXYSKU5dOZdpNIV4+L8wlfNiPPBTe
 3sjzre8iql3wZ29IUbWqaDDPjVjFjXXxaCoAQ1jpgRQw0yfo62xXIrauSuBRtLhLYP0r
 ftow==
X-Gm-Message-State: AOJu0YyZKJp7uKVks8eAw7wwcQ9xpxHLqOjb/0xoJ36QoSilCcZqpCU0
 yukiCebjrc53SVfWPSimCkTUavkP3l0ySgKddxI=
X-Google-Smtp-Source: AGHT+IFeEHBuZ7hfxtiMCTEAFQMzVGv28ueV1IoIIzrNifUOE5919nC+k9E+hC88lK8Sm1c7PW1Pog==
X-Received: by 2002:a6b:dd08:0:b0:783:498c:9cf0 with SMTP id
 f8-20020a6bdd08000000b00783498c9cf0mr6226903ioc.4.1692907168626; 
 Thu, 24 Aug 2023 12:59:28 -0700 (PDT)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 c11-20020a5e8f0b000000b00786fe5039b8sm9744iok.46.2023.08.24.12.59.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 12:59:28 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Andre Przywara <andre.przywara@arm.com>,
 Hai Pham <hai.pham.ud@renesas.com>, Johan Jonker <jbx6244@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Michal Simek <michal.simek@amd.com>
Subject: [PATCH 02/19] Kconfig: Move API into general setup
Date: Thu, 24 Aug 2023 13:58:53 -0600
Message-ID: <20230824195917.1687886-3-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
In-Reply-To: <20230824195917.1687886-1-sjg@chromium.org>
References: <20230824195917.1687886-1-sjg@chromium.org>
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

This is perhaps not a commonly used feature so should not have its own
option in the main menu. Move it under general setup.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Kconfig b/Kconfig
index 91170bf8d223..0a2e97578dfc 100644
--- a/Kconfig
+++ b/Kconfig
@@ -585,10 +585,10 @@ config MP
 	  This provides an option to bringup different processors
 	  in multiprocessor cases.
 
-endmenu		# General setup
-
 source "api/Kconfig"
 
+endmenu		# General setup
+
 source "boot/Kconfig"
 
 source "common/Kconfig"
-- 
2.42.0.rc1.204.g551eb34607-goog

