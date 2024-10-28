Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A645D10C0B
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 12:42:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 885C2890E7;
	Mon, 28 Oct 2024 13:41:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="XdtKZ8Sr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4CD64890D4; Mon, 28 Oct 2024 13:41:50 +0100 (CET)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D06C890E7
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 13:41:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a99f646ff1bso542312066b.2
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 05:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1730119307; x=1730724107; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YaZ0ZG9QC/r6i28oX2Oe3bvxqAQaSBxteSbj8dg96BQ=;
 b=XdtKZ8SrxncJ/KxMEqK7cmMsdJpPcJDXG1JgCB5d75S3DoFj/faN82sMaqaL4jqVMS
 Qg3K5aGUTRb05aRU6SCYelHKXxE2QstMkcfVVhzgybA4IoihEh+c3L0djw+XXfHKAvLi
 84foGJrOXN4G4+F9Hov/k05Jw746U9jQ/susk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730119307; x=1730724107;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YaZ0ZG9QC/r6i28oX2Oe3bvxqAQaSBxteSbj8dg96BQ=;
 b=ccg8h/EA1gsNTy2fI7GlsebDvaWa5V3PCsekxzmdqtK3V8W/RO5rdSUVva8Zf1DJOy
 d1wn2RC7mnxjv84J6X0QB1nJiZsKn+2YJdL8RQ7OxloPal6wQjyuadyspeLl0Oca76Ck
 l0ST2QTsccmg9LB8++2KTDEX348lFhRdpo/YvfjSnQPHomePgqZRSIXpycfV/oG6m4jB
 uW9jHc4dy1+GxAKCm47zsj1K2c8V2tqjYTcpTLZxZUuE/njXLPk24olS3OpGkZ8cgzET
 4RALHXXkInAzRMpOZiGRngneZWfHi+dVWfWFcOVAXA8rQsuS38jfixS6BTPu2LP7EsTt
 VCHg==
X-Gm-Message-State: AOJu0Yxnt9f+SIdwEnQi/jKD05wYAtAkkQyc67H3qinQi0JAIZmgsnGz
 /uDCgl50ghO6rv2rpLbs54kgeTY91C/P4OXiTVAqxxYjTtXNybQhO5lN+C55oXlWha3BMre0193
 MBw==
X-Google-Smtp-Source: AGHT+IHb5CpgEiucsw+xTiVa80wqotIaKYoeut/lN4e6111qBnprhGbs6JmbmZCKxDFc4dUzMhM0fA==
X-Received: by 2002:a17:907:6d1a:b0:a9d:e2ba:7158 with SMTP id
 a640c23a62f3a-a9de5a456acmr715478066b.0.1730119307310; 
 Mon, 28 Oct 2024 05:41:47 -0700 (PDT)
Received: from chromium.org (43-114-103-145.static.glaslokaal.nl.
 [145.103.114.43]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9b30c7ae0bsm375313766b.156.2024.10.28.05.41.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2024 05:41:46 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 07/21] command_ut: test: Move test into lib
Date: Mon, 28 Oct 2024 13:41:12 +0100
Message-ID: <20241028124130.32072-8-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241028124130.32072-1-sjg@chromium.org>
References: <20241028124130.32072-1-sjg@chromium.org>
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

This test doesn't belong at the top level. Move it into the lib/
directory, since that is where compression is implemented.

Rename it to just 'command', since it is obviously a unit test and the
_ut suffix does not add much except to make it different from the names
of other test files.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 test/Makefile                        | 1 -
 test/cmd/Makefile                    | 1 +
 test/{command_ut.c => cmd/command.c} | 0
 3 files changed, 1 insertion(+), 1 deletion(-)
 rename test/{command_ut.c => cmd/command.c} (100%)

diff --git a/test/Makefile b/test/Makefile
index fcd73f0b472..283d97012cf 100644
--- a/test/Makefile
+++ b/test/Makefile
@@ -7,7 +7,6 @@ obj-y += test-main.o
 obj-$(CONFIG_$(XPL_)CMDLINE) += bootm.o
 obj-$(CONFIG_$(XPL_)CMDLINE) += cmd/
 obj-$(CONFIG_$(XPL_)CMDLINE) += cmd_ut.o
-obj-$(CONFIG_$(XPL_)CMDLINE) += command_ut.o
 obj-y += dm/
 obj-$(CONFIG_FUZZ) += fuzz/
 ifndef CONFIG_SANDBOX_VPL
diff --git a/test/cmd/Makefile b/test/cmd/Makefile
index 4b487c1d2cb..b897636e44f 100644
--- a/test/cmd/Makefile
+++ b/test/cmd/Makefile
@@ -5,6 +5,7 @@
 
 obj-y += cmd_ut_cmd.o
 
+obj-$(CONFIG_$(XPL_)CMDLINE) += command.o
 ifdef CONFIG_HUSH_PARSER
 obj-$(CONFIG_CONSOLE_RECORD) += test_echo.o
 endif
diff --git a/test/command_ut.c b/test/cmd/command.c
similarity index 100%
rename from test/command_ut.c
rename to test/cmd/command.c
-- 
2.43.0

