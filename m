Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31F4CFF8875
	for <u-boot@archiver.kernel.org>; Thu, 30 Apr 2026 08:07:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5841884656;
	Thu, 30 Apr 2026 10:06:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="TLWbgJbP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7543384658; Thu, 30 Apr 2026 10:06:51 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 914BA8466D
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 10:06:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-43cff5dafc3so403676f8f.1
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 01:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1777536409; x=1778141209;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zShprpE24HYD85O7mGR679R50uLgc36fQhJmBMY4H8g=;
 b=TLWbgJbPQYEFMMRlkglFPr1jbKEuV9SHLzg5w9cwIGjaerFe8Q/PBvGjmXXdPnQF3f
 aP8knAbiXaAXzakz4rV6tCrudLrSRt7OrzOAnnZCxVZGdmmWeuXAn3ENnGrxdmvJcj/J
 jBIokUIXqnU9VdhRfoNHB2UEkenliGRa9pu3g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777536409; x=1778141209;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zShprpE24HYD85O7mGR679R50uLgc36fQhJmBMY4H8g=;
 b=ly7Ih9GYxE9rIu+djkc9uJb6njH5qjKH0SNiPPwn08sAIhyA4jaCoHDEIZuZCDP9hv
 y23YIE3PCllYxy/OL4BqkznbI/znaapdORW73dP7hN4m43WOeUKvYrR2N962yine0mkA
 gpiZH/fS6G8+gooZzJRVwAHd72eOE5Q5YpzUBlhUnyRs7BFzU6R6P1K4sp0aGGnDoLze
 unhkI4n3/1TI0Wmv2g4/LDcNhvwNh8m8GBsIVy/t4KF6lHUyF5f1xBwIC1bmNY08ikPT
 KzXznAZhwdMoi18egnV3OutXHZDyzwQg3nV1MUTPOMWUajOfJ3/DXsRtDZ1Luz1tpdRK
 aKgw==
X-Gm-Message-State: AOJu0YxmyevpzRFYxMxfMw2LptpFdRCAR3QwQO//tStniR/IOVJI6QAI
 tEw+hMK8SNG83/JuT8zHQ0xWa8n+lzNMawFG2WfuHEO01fJr6tlC9THxA3Z6GZZG8GbTkMdQ7Jn
 BmoUa
X-Gm-Gg: AeBDieuIKjCZLN35I/klLBL+liuVeT9crsuYYpalYARF74zTqpaznbHXOmwLY0IVCUW
 PKlqRQFunuiwYVqx+xhD6SBLApAcYbRT9NxefBrYHsSIIDHR08MgeYvEq6/U9tgnqSqX6+xiYU9
 3OeHGmSjASKmhb7m2caPLJNBc1ozP/NhuDcf3zf95uciD7pRrWU9wErbjdCUoy3PcTQrXg1vcTO
 SIeEDNzBmB6dulGe91ikPIQwnkW+eWOP02MDHA36GpfZfvFlOGIBxto7WTf8aCPX/xxYKz7/+7l
 sQm4TwU2EcKqaFGt2sS72pEQtW4WpSmCyIuBm/HbY0S6kbcxdzOB2a42bwOAOkVrydZdnnf6mZV
 ZDX6UFneh9EjvbGtpBuLMUjwyVtNuHzPI5LGcVra5vL2aoWnTavp368flOkCyi8S8KM4Ngetyrx
 zLmO84XQ/ZQDlbnKxKgTVCurEDwrG1PjFZLSeuW55VKzSM++z2bM/xGfCqgiXwKnOfnIKMHjeRh
 fCRbYs6vvASI9G9AovDpU2UH0iDYixxy+qcqexUTSCtiS0Si4boW+bDiWtelVKJqEBL5T60PpmE
 jgN0MV4p9L6YP79KFUI2NO781raNbEo3GhA=
X-Received: by 2002:a05:6000:24c8:b0:446:96b1:f53 with SMTP id
 ffacd0b85a97d-4493e5a7a4emr2826890f8f.26.1777536408600; 
 Thu, 30 Apr 2026 01:06:48 -0700 (PDT)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-82-56-22-134.retail.telecomitalia.it. [82.56.22.134])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-449c576d0a2sm668071f8f.31.2026.04.30.01.06.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 01:06:48 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Simon Glass <sjg@chromium.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v8 7/8] test: dm: fwu_mdata: add test for
 fwu_mdata_get_image_guid
Date: Thu, 30 Apr 2026 10:06:08 +0200
Message-ID: <20260430080627.849636-8-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430080627.849636-1-dario.binacchi@amarulasolutions.com>
References: <20260430080627.849636-1-dario.binacchi@amarulasolutions.com>
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

(no changes since v7)

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

