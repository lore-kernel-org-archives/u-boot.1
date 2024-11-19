Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97F5AD44157
	for <u-boot@archiver.kernel.org>; Tue, 19 Nov 2024 13:23:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB3498960E;
	Tue, 19 Nov 2024 14:20:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hD763Lw8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA4EF8959D; Tue, 19 Nov 2024 14:20:10 +0100 (CET)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B07B189600
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 14:20:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-3a6c2077afcso3247315ab.0
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 05:20:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1732022407; x=1732627207; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=36EfDcAwJNoLtewqhX7CZ42De1uaZxpS21vMwm9MMj0=;
 b=hD763Lw8PMlxd21l8raqmGlQVGmFXN/AGrjmaqmQ7PD6F+tCBFiQEDLiuXrAW1EkCh
 tLAZmSwZfCbmsDwPvN/dYQCG79BjfMXSBOktmPTAIWGYyZ12JNrGqok7UVjWCjJS/6eB
 IIJ2EmrWFEOioxixbDiC3y0SJBjUJwGcVMXs8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732022407; x=1732627207;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=36EfDcAwJNoLtewqhX7CZ42De1uaZxpS21vMwm9MMj0=;
 b=cPLDqDyhcf3W1looblkEb31Ve4rCyyjsEk8C7yFg9CXNci9degjUvb3vM0xSbAdIXh
 yZ/TfDihf7pInWY9cU+0KiF2PLw2IQ+ft9o+3vfQicuAU+f4dHyg/bQpvWGFIv6pYrX2
 fsvneh0BQxbBm8LSxijpVtHfaqR9J1YshmqvnIDHzTKOki6QkxNh1JTT49uKbO0mX/Wy
 MgkL6UvcPOLWyZP1/GmeXc3dvsJ7i1hUDaZH53cErbyb7VTtwkMkWOYzDSiOR2UTJfbC
 Z/SRMOP43tqfAqUSkRmAv8UIgWWkC/1GXYBZb7B67vI5VxwXBRxLszzC2Xh1VirPCmGz
 F99A==
X-Gm-Message-State: AOJu0Yy2CfX2aPGmEDAVgu4Pwd/Mg1w3+9uYdq892jw+TfZgXnJnkheo
 yUlvWVkQN9PLZ5enjPpq25bxHYKIkqJKilQH0HCnNXG4H0Ja/5cE8ap4jcTy8wgjrmris6t4oQQ
 =
X-Google-Smtp-Source: AGHT+IHbeNxzEaX1Vp2wSeymxAU2/vx/dldOcLYTbhQv8R+rGZbMo8/exK97AV2CraKhfbsXYtVcPQ==
X-Received: by 2002:a05:6e02:2143:b0:3a7:2705:5d17 with SMTP id
 e9e14a558f8ab-3a747ff8d73mr173993075ab.1.1732022406917; 
 Tue, 19 Nov 2024 05:20:06 -0800 (PST)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a7811e4905sm753085ab.2.2024.11.19.05.20.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Nov 2024 05:20:05 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>
Subject: [PATCH 28/39] test: Update bootm test to restore silent_console
Date: Tue, 19 Nov 2024 06:18:33 -0700
Message-Id: <20241119131844.4078144-29-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241119131844.4078144-1-sjg@chromium.org>
References: <20241119131844.4078144-1-sjg@chromium.org>
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

Unset this environment variable at the end of bootm_test_silent() et al
to avoid affecting subsequent tests.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 test/boot/bootm.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/test/boot/bootm.c b/test/boot/bootm.c
index 52b83f149cb..db024bb1b0b 100644
--- a/test/boot/bootm.c
+++ b/test/boot/bootm.c
@@ -121,6 +121,9 @@ static int bootm_test_silent(struct unit_test_state *uts)
 	ut_assertok(bootm_process_cmdline(buf, BUF_SIZE, BOOTM_CL_SILENT));
 	ut_asserteq_str("console=ttynull something", buf);
 
+	/* restore settings */
+	env_set("silent_linux", NULL);
+
 	return 0;
 }
 BOOTM_TEST(bootm_test_silent, 0);
@@ -226,6 +229,8 @@ static int bootm_test_subst_var(struct unit_test_state *uts)
 	ut_assertok(bootm_process_cmdline_env(BOOTM_CL_SILENT));
 	ut_asserteq_str("some${var}thing console=ttynull", env_get("bootargs"));
 
+	env_set("silent_linux", NULL);
+
 	return 0;
 }
 BOOTM_TEST(bootm_test_subst_var, 0);
@@ -243,6 +248,8 @@ static int bootm_test_subst_both(struct unit_test_state *uts)
 	ut_assertok(bootm_process_cmdline_env(BOOTM_CL_ALL));
 	ut_asserteq_str("some1234567890thing console=ttynull", env_get("bootargs"));
 
+	env_set("silent_linux", NULL);
+
 	return 0;
 }
 BOOTM_TEST(bootm_test_subst_both, 0);
-- 
2.34.1

