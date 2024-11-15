Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 127B2D68BCD
	for <u-boot@archiver.kernel.org>; Fri, 15 Nov 2024 16:45:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 83F728906C;
	Fri, 15 Nov 2024 17:45:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="hfixn2Dg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E7BD48908A; Fri, 15 Nov 2024 17:45:45 +0100 (CET)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED41389045
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 17:45:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-38221306992so1028418f8f.3
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 08:45:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731689143; x=1732293943; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=JlSBaaktm8T1pIgDyKQOGn7JnJI6qqwwUu7OuvB/rdM=;
 b=hfixn2DgRLQ6d5PYpQPQzhbZUR5TK5pwPYH5G/VYhxk7tTWQHm5m1EGndddQ2IpxBj
 x3BK01J7Uss79wDbE5SHcyWF4gQqEopZA6TH57eV4e5pwueVCynCapxxnShOgW76CUPu
 vWqroXa3dhaWeqGgrm5B6fsxyzCSg6bWh4wGhEGuUc/8u7pG4u3+Z9WFH3oR4lduAOZb
 olWxZ1KfSsSHd4x1D72bcWlH1Tg68PLdg2JVn1OE9aY2gADeW/xmORdQbBlUzXGnDTko
 iAKRmXA2eLtvaOWAqNcte7g30mVwQsGFs4597pMb1VjXZM2uUrEx5+zHrt5dcwRho8C3
 FAbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731689143; x=1732293943;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JlSBaaktm8T1pIgDyKQOGn7JnJI6qqwwUu7OuvB/rdM=;
 b=DCM7I/kR9FdwRFn86oNIgVmHUyEOMU+z+GY/LH5+I4LoawONgWdasDaPyVf/AnNtK8
 UQ6+cC+rlLk6XNlV1deoynDhBVu9/uVquLf2apkN8pJf6pL/9oxEZHhJITK4//hOSMBT
 USOOSMmCSEXdd+BmbgglVGQDXEclwZq/VuBGymKucDcpSd57x4X1PIHcu9Ym+w4ITlA1
 sZjBR3T9CaxTKKg/NQXXUI3a+6hv0eB+Ek2UMwrtMfcmWRUmed0HVrlnTRfALGfWW4fr
 eam0AvMqhncmYg+6eou+N6ofpyXGZBwgYJjgCngTSCPZJFK1CZYQkmuSlnCm2fq+NcgD
 +Jvg==
X-Gm-Message-State: AOJu0YzOLo/0OP0sIxTIN05y1sD/mDaxU1FNa0atrwYvHONBGbAB+8Cn
 e6B+l0nzX8s2k3sxU38t7svPUs6UxERMcWujXfyxKAkF3DIRIY6GiIAO/1ThOt6J+/Qu3YxCAwU
 FmyQ=
X-Google-Smtp-Source: AGHT+IFxb3OUgxthcPLhphMbg4zxkxlAJVDCd3iZtXo0/hJuEoieWaLPFMOVEL9zJUepTLOWeAjh9Q==
X-Received: by 2002:a5d:5f81:0:b0:37d:2edd:b731 with SMTP id
 ffacd0b85a97d-38225a847ebmr2546450f8f.30.1731689143186; 
 Fri, 15 Nov 2024 08:45:43 -0800 (PST)
Received: from builder.. ([2a01:e0a:3cb:7bb0:e49a:77a4:3a37:4bad])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38222c14306sm3262377f8f.21.2024.11.15.08.45.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Nov 2024 08:45:42 -0800 (PST)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>,
 Yasuharu Shibata <yasuharu.shibata@gmail.com>
Subject: [PATCH v2] test/cmd/wget.c: move net_test_wget() to the cmd test suite
Date: Fri, 15 Nov 2024 17:45:14 +0100
Message-Id: <20241115164514.2186763-1-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
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

Since net_test_wget() is testing a command and is in test/cmd it should
be in the 'cmd' test suite, not 'lib'.

Saving and restoring the values of the environment variables that the
test manipulates is necessary to avoid a regression when running the
whole ut test suite. A minimal reproducer is:

 $ ./u-boot -T -c "ut cmd net_test_wget; ut dm dm_test_eth_act" | \
     grep -E "(Test:|Failures:)"

Reported-by: Simon Glass <sjg@chromium.org>
Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 test/cmd/wget.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/test/cmd/wget.c b/test/cmd/wget.c
index fe26fee54c9..7570c065a10 100644
--- a/test/cmd/wget.c
+++ b/test/cmd/wget.c
@@ -19,7 +19,7 @@
 #include <dm/test.h>
 #include <dm/device-internal.h>
 #include <dm/uclass-internal.h>
-#include <test/lib.h>
+#include <test/cmd.h>
 #include <test/test.h>
 #include <test/ut.h>
 
@@ -206,6 +206,10 @@ static int sb_http_handler(struct udevice *dev, void *packet,
 
 static int net_test_wget(struct unit_test_state *uts)
 {
+	char *prev_ethact = env_get("ethact");
+	char *prev_ethrotate = env_get("ethrotate");
+	char *prev_loadaddr = env_get("loadaddr");
+
 	sandbox_eth_set_tx_handler(0, sb_http_handler);
 	sandbox_eth_set_priv(0, uts);
 
@@ -223,6 +227,10 @@ static int net_test_wget(struct unit_test_state *uts)
 	ut_assert_nextline("md5 for 00020000 ... 0002001f ==> 234af48e94b0085060249ecb5942ab57");
 	ut_assert_console_end();
 
+	env_set("ethact", prev_ethact);
+	env_set("ethrotate", prev_ethrotate);
+	env_set("loadaddr", prev_loadaddr);
+
 	return 0;
 }
-LIB_TEST(net_test_wget, UTF_CONSOLE);
+CMD_TEST(net_test_wget, UTF_CONSOLE);
-- 
2.40.1

