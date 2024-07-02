Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 172A3C30658
	for <u-boot@archiver.kernel.org>; Tue,  2 Jul 2024 18:27:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 92946887A1;
	Tue,  2 Jul 2024 20:27:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="nHzLAlMF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A890E87D0A; Tue,  2 Jul 2024 20:27:36 +0200 (CEST)
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com
 [IPv6:2607:f8b0:4864:20::82f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8CC4187F8C
 for <u-boot@lists.denx.de>; Tue,  2 Jul 2024 20:27:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-446416dccd5so21506531cf.3
 for <u-boot@lists.denx.de>; Tue, 02 Jul 2024 11:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719944853; x=1720549653; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zvsvYrvUSA9Ga38zikKq4gGEQHNa7JCl+6hgGGEUeHU=;
 b=nHzLAlMFyWhUzV3elD0wP0IvsWB8477TnJR+Dra09AjNrq5shNmId+zdMAXrp3vP3N
 etTpKiEpY1GQq0ZuFtf6dxz70sFVLjTpDsRnfw8d71aVkkPtzegfm7/aFEOFhfJl6kg8
 3NPsN9+U6v5Ili/aPdwqk21dYIWsEiMu3ZdlyL/odPGjl9jcrCYgY2HHTPM8y51vz/Hf
 dK2Kj2E73NF1vA1QpzTWpWABwo5cCjDNIXa/OPYtw8q1UQFAcnj0vymYfofEiC9YYjAS
 JC5SvJ3sWpfpvc7l9s1k5Qwf4uVJaKS5osGAe7Pgbx14PbyEY1qlWqSjAM8kGRSI9xpR
 OwqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719944853; x=1720549653;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zvsvYrvUSA9Ga38zikKq4gGEQHNa7JCl+6hgGGEUeHU=;
 b=RsWmifukBL3o3EwMeRRtFkNKzNWRr6nrZnJJKJrrN6S9cgCYQoOnbVGyxYhwfHMEwF
 lXnK3g+NAiscKYjpJkhFrcnWNiWXVhPJwQvzuG2DRfXy2l4T1lq6eySm/x5XTOGOkX3Z
 TkM3W8x8WnslkWVkyCrN+XD2as2bDO6VxLE2J5e/o0KALHzHTW0FXO8qTz1oJ/JaeVFd
 wMU8b3nKOI9/iBlppNiC9nqkjdE0c3O/A8K5VcncsLsJSHk8huK0WuWTrUzHVRDFk3ie
 EcRaXPMyPCCBRMN9yjbiQG2XaR3Jfd/C0z2Udw2MovEwSz5ySg/NS/IM2g821wtVIJLW
 k5jw==
X-Gm-Message-State: AOJu0YzpJs69B7wIsdGA7m+SSZ+X3tpfyWqZK8meo12bAoCNPul8m7IT
 ucwB8fM0c638qgHM7kL9hYTFelhGxaBm81FoAvYgBaRIZK6pqBjkVgqJi2WYwr3v8e7QKiRfDpw
 j
X-Google-Smtp-Source: AGHT+IHn8gNzU8khcdbo3NxGR0dkQ9E/qiQU18rl6Dupq6w5OsS7qyfSpHMMKReUqNjG2eA59StRbg==
X-Received: by 2002:ac8:5f82:0:b0:445:624:22ed with SMTP id
 d75a77b69052e-44662dd3be1mr142396461cf.9.1719944853286; 
 Tue, 02 Jul 2024 11:27:33 -0700 (PDT)
Received: from ubuntu.localdomain
 (pool-174-114-184-37.cpe.net.cable.rogers.com. [174.114.184.37])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-446514b613dsm43316351cf.84.2024.07.02.11.27.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 11:27:32 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: manish.pandey2@arm.com, Raymond Mao <raymond.mao@linaro.org>,
 Tom Rini <trini@konsulko.com>, Stefan Bosch <stefan_b@posteo.net>,
 Mario Six <mario.six@gdsys.cc>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michal Simek <michal.simek@amd.com>,
 Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>, Simon Glass <sjg@chromium.org>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Sean Anderson <seanga2@gmail.com>, Jesse Taube <mr.bossman075@gmail.com>,
 Bryan Brattlof <bb@ti.com>, "Leon M. Busch-George" <leon@georgemail.eu>,
 Ilya Lukin <4.shket@gmail.com>, Sergei Antonov <saproj@gmail.com>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Alexander Gendin <agendin@matrox.com>, Bin Meng <bmeng@tinylab.org>,
 =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle@arm.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
Subject: [PATCH v4 09/29] makefile: add mbedtls include directories
Date: Tue,  2 Jul 2024 11:22:45 -0700
Message-Id: <20240702182325.2904421-10-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240702182325.2904421-1-raymond.mao@linaro.org>
References: <20240702182325.2904421-1-raymond.mao@linaro.org>
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

Add the mbedtls include directories into the build system.

Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
Changes in v2
- None.
Changes in v3
- Remove changes for PLATFORM_CPPFLAGS.
Changes in v4
- Fix errors when building without "O=".
- Minor fix of the include directories.

 Makefile | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Makefile b/Makefile
index 07d7947c8af..fd855dbd5c9 100644
--- a/Makefile
+++ b/Makefile
@@ -829,6 +829,12 @@ KBUILD_HOSTCFLAGS += $(if $(CONFIG_TOOLS_DEBUG),-g)
 UBOOTINCLUDE    := \
 	-Iinclude \
 	$(if $(KBUILD_SRC), -I$(srctree)/include) \
+	$(if $(CONFIG_MBEDTLS_LIB), \
+		"-DMBEDTLS_CONFIG_FILE=\"mbedtls_def_config.h\"" \
+		-I$(srctree)/lib/mbedtls \
+		-I$(srctree)/lib/mbedtls/port \
+		-I$(srctree)/lib/mbedtls/external/mbedtls \
+		-I$(srctree)/lib/mbedtls/external/mbedtls/include) \
 	$(if $(CONFIG_$(SPL_)SYS_THUMB_BUILD), \
 		$(if $(CONFIG_HAS_THUMB2), \
 			$(if $(CONFIG_CPU_V7M), \
-- 
2.25.1

