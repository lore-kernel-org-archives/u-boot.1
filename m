Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B806FFF885E
	for <u-boot@archiver.kernel.org>; Sun, 26 Apr 2026 15:48:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CAAED84372;
	Sun, 26 Apr 2026 17:47:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="OX9huxM6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F51B84309; Sun, 26 Apr 2026 17:47:41 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 810738407E
 for <u-boot@lists.denx.de>; Sun, 26 Apr 2026 17:47:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-43d03db7f87so6396458f8f.3
 for <u-boot@lists.denx.de>; Sun, 26 Apr 2026 08:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1777218459; x=1777823259;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KdenFksAhxmVcxyTgy6MvO1TEY6LsbInC1KB7MV5fFk=;
 b=OX9huxM6TwXiZ9qOS4gW1XBOaTfqA8RTFI1k8ASIysdprS8j6PKWDDgYNnmaBXtPVG
 25vSD9Qi8nAXQHKR/9daWf581Gv9YtOdbCGY0vg6rr/tTsOJ3vVk4EjAQeS8dWAFvM3Q
 KZlsgd7IzaFNrDbOUM0aaxgpLwXJ1a5DDV/JY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777218459; x=1777823259;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KdenFksAhxmVcxyTgy6MvO1TEY6LsbInC1KB7MV5fFk=;
 b=KjIlGiSvQNcoEkXk1yk4TMJbESV1j1dJlXaUP1cKq4pjUJj7lkNvigrDb1EKYPIlyr
 S6lnW6nb7GtyyPuz0juslk2N++/lhFpketAFsulEfIlCD00JirjFpi7L3eY3Sm0Ugar1
 iWecAClngo3y4SQykUbTW97pCisQRYFGvP0LPbBa4Jw2vGbUsy5+7D7RNMYAz3iAJWCz
 FcsYCngzteKiMX7cY1dqZ6fekjrZFyF2URYu2tBNYNuzG3omXFYybCEsVV0YslI6qk2D
 A0x1AfuUhtTema+jsvcdzxM7qXGKNZnSYYzPFTsaMzysCRaBJGnFMguZt2mCm8VIR5wN
 tfqQ==
X-Gm-Message-State: AOJu0Yzh2XpMoZcndp18pdI+3+WK5IjdPBLEPn0bc1qehepwH+Y08hPp
 tbkkIpR3YSuzkwp8CojE7tj/oeHp9ZNn3RTKdhiU0kv9KiaEDcMtGPhAYVWpGb9boAHOiB5wfZi
 eYxPD
X-Gm-Gg: AeBDietLWYCxCUi+qhd5+zQpFSFR+B8EfZrmRqHC6JRakt7vEgDyjrYUWhAt+K5hi74
 m7eBOiIIH73yX+0Rmr7W7+usZEX3hZolwQ38nzbQnegt8SJxVl8vFxmKarPeZzMtEVqNdEz3xaK
 9cqpuh8zcEKlKDEw3oIOBcfp+pgPlhXSduSfGPMCSv7sTlqi0rEXgK07hJGC5b+E6GBzT6eme/O
 oHat5kF5/iYlhsezVfx79eth7J6s0cmKA5MMH9uqyNzoLOjqxmIigLWfwwT/fwr7Qw86apHFB3s
 fXHCWAiopCYG7+Cmw8Z5oPMVZDusScJBoRTb4WxgVpM/1PzRYKkSu7eC8cBjifb+QW4JPj/C8JS
 KwoFV4vdD4SEzGTh42NWpFZK9/KoskIPGAqJ1oDYOADfoFFDxEiPq0J/AntDp5Xqd6f7FR4/xaT
 Wya0VuKW9tIwRoG9UJEFWESY+RPi1JCO1UVaJ+XQBWOmFDoZBHKwQb3tZ8vSsOdj80LIWJn4BBk
 5V6pVYecBnbj8kBAcZeNPx/teIFLCuYYZtc76n8JqHTDIZndSEvERDVRQat2os2iGROLPwEes3g
 CKytBIVFeEvvzCZiTjToH7EMdThxgA==
X-Received: by 2002:a05:6000:1ac9:b0:43d:6787:9934 with SMTP id
 ffacd0b85a97d-43fe3db39b2mr58717997f8f.9.1777218458731; 
 Sun, 26 Apr 2026 08:47:38 -0700 (PDT)
Received: from dario-ThinkPad-P14s-Gen-5.amarulasolutions.com
 (host-82-56-22-134.retail.telecomitalia.it. [82.56.22.134])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-44123d23e0bsm34489985f8f.15.2026.04.26.08.47.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Apr 2026 08:47:38 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v7 7/8] test: dm: fwu_mdata: add test for
 fwu_mdata_get_image_guid
Date: Sun, 26 Apr 2026 17:47:00 +0200
Message-ID: <20260426154724.2042569-8-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260426154724.2042569-1-dario.binacchi@amarulasolutions.com>
References: <20260426154724.2042569-1-dario.binacchi@amarulasolutions.com>
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

Add a new unit test for the fwu_mdata_get_image_guid() function.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Reviewed-by: Simon Glass <sjg@chromium.org>

---

Changes in v7:
- Add Reviewed-by of Simon Glass for patc 7/8 of "test: dm:
fwu_mdata: add test for fwu_mdata_get_image_guid"

 test/dm/fwu_mdata.c | 48 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/test/dm/fwu_mdata.c b/test/dm/fwu_mdata.c
index cfe543d8a236..8624ccf61f79 100644
--- a/test/dm/fwu_mdata.c
+++ b/test/dm/fwu_mdata.c
@@ -143,3 +143,51 @@ static int dm_test_fwu_mdata_write(struct unit_test_state *uts)
 	return 0;
 }
 DM_TEST(dm_test_fwu_mdata_write, UTF_SCAN_FDT);
+
+static int dm_test_fwu_mdata_get_image_guid(struct unit_test_state *uts)
+{
+	efi_guid_t image_type_guid =
+		EFI_GUID(0x09d7cf52, 0x0720, 0x4710, \
+			 0x91, 0xd1, 0x08, 0x46, 0x9b, 0x7f, 0xe9, 0xc8);
+	efi_guid_t bank_0_image_guid =
+		EFI_GUID(0x10057a86, 0xdaf1, 0x4f93, \
+			 0xba, 0x7f, 0xb1, 0x95, 0xf7, 0xfa, 0x41, 0x70);
+	efi_guid_t bank_1_image_guid =
+		EFI_GUID(0xdb62ed3e, 0x6237, 0x4fb4, \
+			 0x80, 0xc4, 0x1b, 0x74, 0xd8, 0x46, 0xa8, 0xe7);
+	efi_guid_t wrong_image_type_guid =
+		EFI_GUID(0x12345678, 0x1302, 0x133f, \
+			 0x18, 0x0a, 0x14, 0x05, 0x18, 0x05, 0x14, 0x0b);
+	struct udevice *dev;
+	efi_guid_t image_guid;
+
+	ut_assertok(setup_blk_device(uts));
+	ut_assertok(populate_mmc_disk_image(uts));
+	ut_assertok(write_mmc_blk_device(uts));
+
+	/*
+	 * Trigger lib/fwu_updates/fwu.c fwu_boottime_checks()
+	 * to populate g_dev global pointer in that library.
+	 */
+	ut_assertok(event_notify_null(EVT_POST_PREBOOT));
+
+	ut_assertok(uclass_first_device_err(UCLASS_FWU_MDATA, &dev));
+
+	ut_assertok(fwu_init());
+
+	ut_assertok(fwu_mdata_get_image_guid(&image_guid, &image_type_guid, 0));
+	ut_assertok(guidcmp(&image_guid, &bank_0_image_guid));
+
+	ut_assertok(fwu_mdata_get_image_guid(&image_guid, &image_type_guid, 1));
+	ut_assertok(guidcmp(&image_guid, &bank_1_image_guid));
+
+	ut_asserteq(-EINVAL, fwu_mdata_get_image_guid(&image_guid,
+						      &image_type_guid, 2));
+
+	ut_asserteq(-ENOENT, fwu_mdata_get_image_guid(&image_guid,
+						      &wrong_image_type_guid,
+						      0));
+
+	return 0;
+}
+DM_TEST(dm_test_fwu_mdata_get_image_guid, UTF_SCAN_FDT);
-- 
2.43.0

