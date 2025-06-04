Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2B0BC5B549
	for <u-boot@archiver.kernel.org>; Wed,  4 Jun 2025 15:48:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33004801BE;
	Wed,  4 Jun 2025 17:48:27 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="OU1BufRJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6FC2803DF; Wed,  4 Jun 2025 17:48:25 +0200 (CEST)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4DBEA800D7
 for <u-boot@lists.denx.de>; Wed,  4 Jun 2025 17:48:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=raymond.mao@linaro.org
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-6fafdd322d3so555746d6.3
 for <u-boot@lists.denx.de>; Wed, 04 Jun 2025 08:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749052101; x=1749656901; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=GWbzpCw7PUNy4730d5bI428srzhf0xzBQ+WJdnHqpZA=;
 b=OU1BufRJQ/3NRX8De+VLxcx539k/kZm4bMM804eF61QsxcUa79xZjijdmp9nWC/OVw
 Sn648pxgR1OBi4+5fvSs1HG3QY/a9KYO0OapoB76NzXJD5ndHVD9noI5YYG00yTYpMf/
 o8pmaPPWJK+o0WMJniu8vCBdZua6B5NJXOfACaKKNAlpzxd2H4xobjIgQCV51ztGu1if
 Qm7D609OszIwaUrXrg6zj7VHIuCHJKzljzUzCR35tFR5UXPngVgnRnq+QAWanhksJSn+
 wthFiHNMZMD67jHcHsBHGDFP5uOdDXiFZDnWLkXH7+GRIyixT36VL2pCCleGCU5PjAzQ
 M3vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749052101; x=1749656901;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GWbzpCw7PUNy4730d5bI428srzhf0xzBQ+WJdnHqpZA=;
 b=oqsrWUYzDr723cRTLvkPB5HKrmQj6fzlOTX4jsvAsY94MYtX+mHiijaAje5uC7gu2g
 NBDkdbdmUAIqZrszVQ7doddkLvQmOS65UOyl4baHgnGEtmbZjdMP7L5C1nadRDxGV07j
 K3K1KwQjq0K2v13S/02WjSFKAhiYk5mv7LUB41ARj/Swz/zTUYGmlvfBk4V/Wfaesc05
 MJbO3OT4sNiq8iYzt9bDpDXlN7H+9leulLHlfMNR98UTziAHpG75U+K050pQe0UjA3i8
 2U7hU+PIlkFSA+yrs6yA8F1IcaYJMuZbYx7VkxHpvXWxQ5dqmk8IEMGv2ChrmmotQUN1
 mWCg==
X-Gm-Message-State: AOJu0Yx1tTaX5XVFLpwSfHknq1Tm7eOhrrX/WBUvGkOTCRL/PfExu3uE
 ihf6TE649D2nM30rS7Za0u1ktuc4g3bgZsy6GrCSUsK5RTEGf4q9IcCVzB2hEeHFVrys9dmo/dc
 q+3xb
X-Gm-Gg: ASbGncs4izPJuSuGpWCrlYzOSI+cFWdtsoBc5zdHPGalJQnr7NmF5wHeTpWSd/bA2Sa
 Wt0aXh3RT4z4YS2w5OiVFGlBmikkIqay7tB1wsNmwO8qpncS4g3foajZtA9poY/vjCPB+afiLND
 srZcr1pN+ZFsENeGBEE0XAWZO2yUBbf9TgCZaauMJCjdBCXSMSJXa9Fs7oKaY3Ev2OmADBx8N6C
 oIll5xwuOrwfEivJgZAHcN2OIgu7D/UiV3zsyRTH4faAJncsXfEW7DbOhrUz9IEyqizYb9V4d9h
 ZtMebnIYUUyjspCfEyB5ZV4lyyA9s7oj7KZ4GcILl665+054g034rT+GLretjeDMgVgEurR0Vqq
 W4Rp4K9AOE/CWTlNEMh74bM7rRPgmXUWokZm8
X-Google-Smtp-Source: AGHT+IFSBX6Rzv7M5OVoLDnrBpwoO359tD2QHAIhacp4jyZ9hvgkM23zA427X0euTYojHhiQuX7ejQ==
X-Received: by 2002:a05:6214:2501:b0:6fa:c41e:cc70 with SMTP id
 6a1803df08f44-6faf700f7b3mr46043386d6.22.1749052101445; 
 Wed, 04 Jun 2025 08:48:21 -0700 (PDT)
Received: from ubuntu.localdomain (173-206-114-64.cpe.distributel.net.
 [173.206.114.64]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fac6e0126csm100717146d6.80.2025.06.04.08.48.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Jun 2025 08:48:20 -0700 (PDT)
From: Raymond Mao <raymond.mao@linaro.org>
To: u-boot@lists.denx.de
Cc: Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Adriano Cordova <adrianox@gmail.com>, Michal Simek <michal.simek@amd.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sam Edwards <cfsworks@gmail.com>, Jonathan Humphreys <j-humphreys@ti.com>,
 Prasad Kummari <prasad.kummari@amd.com>,
 Paul HENRYS <paul.henrys_ext@softathome.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Daniel Golle <daniel@makrotopia.org>
Subject: [PATCH v2] sandbox: solve undefined reference to pthread_kill symbol
Date: Wed,  4 Jun 2025 08:48:11 -0700
Message-Id: <20250604154814.1856244-1-raymond.mao@linaro.org>
X-Mailer: git-send-email 2.25.1
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

This patch is to solve the sandbox building error:
$ make O=build-sandbox -s sandbox_defconfig
$ make O=build-sandbox -s -j2
/usr/bin/ld: /tmp/u-boot.27rzOu.ltrans58.ltrans.o: undefined reference to symbol 'pthread_kill@@GLIBC_2.2.5'
/usr/bin/ld: /lib/x86_64-linux-gnu/libpthread.so.0: error adding symbols: DSO missing from command line
collect2: error: ld returned 1 exit status
[...]

Fixes: b989f9ed9fe1 ("test: lib: add initjmp() test")
Signed-off-by: Raymond Mao <raymond.mao@linaro.org>
---
Changes in v2:
- update fixes tag in commit message.

 arch/sandbox/config.mk | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sandbox/config.mk b/arch/sandbox/config.mk
index dd9b7473fa9..9a61e803a57 100644
--- a/arch/sandbox/config.mk
+++ b/arch/sandbox/config.mk
@@ -3,7 +3,7 @@
 
 PLATFORM_CPPFLAGS += -D__SANDBOX__ -U_FORTIFY_SOURCE
 PLATFORM_CPPFLAGS += -fPIC -ffunction-sections -fdata-sections
-PLATFORM_LIBS += -lrt
+PLATFORM_LIBS += -lrt -lpthread
 SDL_CONFIG ?= sdl2-config
 
 # Define this to avoid linking with SDL, which requires SDL libraries
-- 
2.25.1

