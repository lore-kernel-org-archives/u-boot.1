Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFA58CD98C7
	for <u-boot@archiver.kernel.org>; Thu, 11 Jun 2026 21:59:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 80654838BB;
	Thu, 11 Jun 2026 23:59:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="VsR1RpJA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0CFB284664; Thu, 11 Jun 2026 23:59:27 +0200 (CEST)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D851B8056B
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 23:59:24 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dlechner@baylibre.com
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-4866834f8deso170428b6e.2
 for <u-boot@lists.denx.de>; Thu, 11 Jun 2026 14:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1781215163; x=1781819963; darn=lists.denx.de;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=a+xZYlFx4MY88hXVhv3jsvWKhutZ4ZXOnyfxASt/mMc=;
 b=VsR1RpJAffS2pkKJdNSCPf1vE7C9+8RuEtsMlVSzcElv6gupbgAADE/LcKVeB6wOwB
 wGFaDj6oq/qYHOWH5Dpyps9cwrvGK79JmWZ423EZ6HAHN22djqbSjh5UX2xF3gH2nGvZ
 b7EEjJfJWkP4KOItw2UIkRXPzqtlpqNJUura2922Hkuha43X30ATHCnHKEvnSWlkxM01
 NH9VNEXyEk2bz//kMsN9q4QHYHxH0IabCrEyK6BXKn4WwsVG5xHethOMcv0bL4Ekmj4i
 NnVFWm8pb0UKh+ZyZ2LnQoKxp4LWM0difoylJ/M/TneaccSRcm3F+o5Kk7YpZ/nRugDq
 3r1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781215163; x=1781819963;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a+xZYlFx4MY88hXVhv3jsvWKhutZ4ZXOnyfxASt/mMc=;
 b=AImkkXNZ/fS4lqiCSxphMhh5Wu+IIbMQXGx397PKE6CnCXpKOJgUFeXjlS8frPLOu3
 8xzwLKTH7Vrx9DT5qIJCeBdDTufjiBoE8n0Cd0acqdvTvLIHrxUkZIU5AMXP/ajuH3/l
 pRwH7iEI3z5IKlsgxLmomNJxl0Kn0ak3PxTf4Up0UCwgUZhLRMNiUP4FkPf1AizvRv4Y
 eFgzF+zhoj93Tjutxg4PPABuGtcU2JqkrlL7NB1DSBGB2TrB60RaIx2NoT/ZZQgBC8Lq
 PR4zNistKoGbsvQETuDbWoAHpcEOJbxuBc3U3dZUe+kZNS6cGzwt1Fg1ha7LNXv968PH
 /10Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ8WL/YVChxt6G9zVglFc1v31EAK641gH0r0sfgFsz1HRyzuLsvPjlsZIht+zY+XIDy3MJkXgOU=@lists.denx.de
X-Gm-Message-State: AOJu0YycTcA4nLY2gNtCifORXorbl3Mflt1FbISVBvqa8bUE3Byj6+V5
 ymKlqpQms4qOyG2kUMxm1q6mnWyQdNRPacAcsUN3DLmp+5ig2KqNsBAvT1ulfaGY7ao=
X-Gm-Gg: Acq92OEiHap6T7/iL1u4FA5zKTu39XqHMVSZVJz75OAo/quPq1UsfrvkXKddVTGKpYs
 AyIYO9Tntf32IfyJA5ffDo3tYZhA2NCEbhLSVQeI5NSSYMY5HwZxK9bqVl+LUw+KapipA0GeFud
 kXSZW+x5gCtLpeQebEqWpSFxd9DVBljcr9ygiVrGua8dOOgZFOcSuwMCkRbal9eJ3ZX1elaZ9Ao
 Qc919jP1FIVgqArORvUFH9pBC4Ht2aeUsA5tAUitX74/AlaZ2z56xuAyYKvqq3Ze5jM3cDEjWwQ
 3Lri5v6ZKqF4pceYK/AVqV+C66KSOJYbYNAaRQW8rNhn4e55ihIw6tgAgAJE5IlasQBLPm/N9lG
 0u2azipwR84HtQwpHm7mG8vMMXSOj6ZXhT+jxu++rkh3h6ItYoB7uo2+VMIuT0R83/Ola7j+B7C
 7v3K1QGCxTwuso1LQbub1R0dkhgSE=
X-Received: by 2002:a05:6808:3029:b0:479:ac7d:6d91 with SMTP id
 5614622812f47-4872f5ec9e5mr153961b6e.39.1781215163666; 
 Thu, 11 Jun 2026 14:59:23 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:cba0:23d4:353:6048])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-4872ff17ceasm44288b6e.6.2026.06.11.14.59.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 14:59:22 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 11 Jun 2026 16:59:13 -0500
Subject: [PATCH] cmd: ufetch: fix compiling with no CONFIG_SYS_CONFIG_NAME
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260611-fix-ufetch-compile-v1-1-43f2e3239265@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqDQBBE0atIr9Mwo9CIVwlZxLaMLUZlRkUQ7
 +7ELB9U/YMigiFSlR0UsFm0aUzwj4y0e48fsDXJlLtcnHjPre28tli0Y52+sw1ghYOgFBQQSsc
 5IK3u6PP1d1zrHrr8SnSeF9SBa9V2AAAA
X-Change-ID: 20260611-fix-ufetch-compile-ce0e6e86e3e6
To: Casey Connolly <casey.connolly@linaro.org>, Tom Rini <trini@konsulko.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot@lists.denx.de, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1070; i=dlechner@baylibre.com; 
 h=from:subject:message-id;
 bh=sLiznae9b5XXKHQn2smdY7gLyxWYWuVdMzw3D1PjQyo=; 
 b=owEBhAF7/pANAwAKAcLMIAH/AY/AAcsmYgBqKy+yhLtf7b05vhvL9rjXMtcQ6vtRnn1aiGTEk
 ej7YzEPU0SJAUoEAAEKADQWIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaisvshYcZGxlY2huZXJA
 YmF5bGlicmUuY29tAAoJEMLMIAH/AY/ASWAH/jsQKf2NvHgOsSHCtdSQypGjRgSn51WxGrMY1Yu
 BUThNw4bBE28xDZy57rqFKYt/Fx1HtEKHeSG6JMZKIn6a9VkF/i7oBiNCU6ijYHO2LWwjl2gtya
 n3s/AaIKaWwJ/qpCSicLr4ISjnngClVjLohPxt7QMqk5bm5xmk6xnptZpNRUCVA87qMOHabQXfs
 3huCi+Ht+vwiY6neHj8Vqaiof/p9mAP8F9qU4GumlEconPnJElFPxuJc8MkbhUhuaNHRGO+yFRj
 yGHq66vmQhGP4xt0+c/s0sha1dWa4SbczZr8gvxkEgODMYCFU+5W4t/0W8vJ7rxTKXrdCJ9Emsr
 qfnQ=
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03
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

Add some preprocessor guards to avoid a compile error when
CONFIG_SYS_CONFIG_NAME is not defined.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 cmd/ufetch.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/cmd/ufetch.c b/cmd/ufetch.c
index e7b5d773f5e..ff2d1deb24c 100644
--- a/cmd/ufetch.c
+++ b/cmd/ufetch.c
@@ -60,7 +60,9 @@ enum output_lines {
 	FIRST,
 	SECOND,
 	KERNEL,
+#ifdef CONFIG_SYS_CONFIG_NAME
 	SYSINFO,
+#endif
 	HOST,
 	UPTIME,
 	IP,
@@ -125,9 +127,11 @@ static int do_ufetch(struct cmd_tbl *cmdtp, int flag, int argc,
 		case KERNEL:
 			printf("Kernel:" RESET " %s\n", U_BOOT_VERSION);
 			break;
+#ifdef CONFIG_SYS_CONFIG_NAME
 		case SYSINFO:
 			printf("Config:" RESET " %s_defconfig\n", CONFIG_SYS_CONFIG_NAME);
 			break;
+#endif
 		case HOST:
 			model = ofnode_read_string(ofnode_root(), "model");
 			if (model)

---
base-commit: 53e9c41847c24b422ecd21421204d4e6a0c07d76
change-id: 20260611-fix-ufetch-compile-ce0e6e86e3e6

Best regards,
--  
David Lechner <dlechner@baylibre.com>

