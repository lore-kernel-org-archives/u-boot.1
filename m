Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38D16FB5EA0
	for <u-boot@archiver.kernel.org>; Tue, 17 Mar 2026 01:25:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3C4D8405A;
	Tue, 17 Mar 2026 02:24:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="poR3xkoh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F31DF84209; Tue, 17 Mar 2026 02:24:32 +0100 (CET)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 38E768405A
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 02:24:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7d74a59262fso4518587a34.0
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 18:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773710668; x=1774315468; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=NYcr3nrrvR8Njy4rgBCR0AK8FiYT6d8NOxhkBFeS7YA=;
 b=poR3xkohNE3Hy7ZMnkdrzMPl0/esEVn68DBPbIx/EWtLSYoCodk/NYxLdgeYDigte1
 b2jIETuzMCTL9+A1Eggzn7wNQa1N7WHdg4lRER5soPaIMeOp1TVOnFMMuiaIDncb4hyc
 UHo7Bac41APA5urGJ3BM4CK5Jx5oszc3ZKdBg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773710668; x=1774315468;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NYcr3nrrvR8Njy4rgBCR0AK8FiYT6d8NOxhkBFeS7YA=;
 b=oyEHIQbL3cEJqdH8dejeLIPFpCWfMuPaGrIqTBbVMHvS7rgIrKaxA7kZ08JWOVwNty
 4oyfqYKWnq0ANoqmgI5O0OHti3Oiz518n+Gl3D8kxUMRxtdpII5Nd9Q0+3QKAUAfGAl6
 SRHnMQGZASz95F8g3Mj3WztiZLciM8ltYiB2X6iN9X7F+dFdbrp60e2YAYhR0mVN05V3
 qCGtGm23zk8aMCsA73wlFUIKuBWlH96ShJA9ri/c2Kkxmpf33VZm5C+1Jm/5Hpjb7Voa
 RjupLD7ZmdSJ0ilU5BZxWh42acCX2HGrD8Dgq/NYsKplUi09OAhIzgFaBuPnf1qdugSk
 GYmg==
X-Gm-Message-State: AOJu0YwwI22unUgz6Oo4pPTSVHGXNgZ1kKQ4tYzfADTbsPueqCi9T0xA
 +HjOrkhvRHeXEf5LaPivxgv0KKwy7vdKF1Hr7dvve85F7JXHuVSV+gnK1vDUdpqlZc5Ieuh2YU1
 YPfkU/mM=
X-Gm-Gg: ATEYQzyOZcjJYoybXGFrM0Z0u8nO/ntTXOkoDdk0/mCvt/HqHzKJVrxzH14dWWW8ZKH
 kfpjn7SEISGOpElTyg9AY10GP+Xyg0xUeVnV12ynkjSB2WAWTJaOXlOrWodoBG5l7fsRtAYnfoZ
 t6liPagEHJfjQg6CxOlqfFbByTVB0hBbnT7a3L3B2Xa3UK7lrVquo1nCe8ThvPa7Kb5FGbbLm8N
 /zdT0wXNLl2i/eUnmnpVvma/jfxIXm3KaYko9kWnsJyJwJhFG46VAbwEEfn4U19l041a3IVSxoj
 EPUeUYTYN0OvBa+VlvBX23nWHCYxkEDllELphBiwxcGSW4wApCV2kKE/HVa69yG7WAf8Q+irN3X
 ZguxbSeNimypGwVLoMkMFXjlQJN1wjQHZuOAwAUpjE63iGONAPXCWB0que2GtHvrlmdXCEenQ0f
 vxuPvBq88RZGuN8iucuVd2Y+EAQ5btSaL2KcPWQ25QoW7Z1N5mPP/4OOfiL4/YJ9+kR65TJzYQI
 tuGLGL/FFaaI54VwvPdydpzxobpF2MFOkcLrvFdkg/ftAkFuFk=
X-Received: by 2002:a05:6830:6adc:b0:7cf:da97:57d6 with SMTP id
 46e09a7af769-7d78246a5fdmr9585307a34.6.1773710667913; 
 Mon, 16 Mar 2026 18:24:27 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d76ae3a18bsm13066752a34.18.2026.03.16.18.24.27
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 18:24:27 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] sandbox: Add missing select's to the architecture symbol
Date: Mon, 16 Mar 2026 19:24:26 -0600
Message-ID: <20260317012426.4162458-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

As exposed by "make randconfig", we have an issues around a number of
symbols that we select without making sure to also select their
prerequisite symbols. Add these missing symbols.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 arch/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/Kconfig b/arch/Kconfig
index 62148f00cd36..7e563ba8b218 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -203,12 +203,15 @@ config SANDBOX
 	select DM_SPI
 	select DM_SPI_FLASH
 	select GZIP_COMPRESSED
+	select I2C
 	select LZO
 	select MMC
 	select MTD
 	select OF_BOARD_SETUP
+	select OF_CONTROL
 	select PCI_ENDPOINT
 	select SPI
+	select SERIAL
 	select SUPPORT_OF_CONTROL
 	select SUPPORT_BIG_ENDIAN
 	select SUPPORT_LITTLE_ENDIAN
-- 
2.43.0

