Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A714FF885E
	for <u-boot@archiver.kernel.org>; Sun, 26 Apr 2026 15:37:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0005F84262;
	Sun, 26 Apr 2026 17:36:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="qbete4Fv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 702F38421D; Sun, 26 Apr 2026 17:36:34 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 84067841D7
 for <u-boot@lists.denx.de>; Sun, 26 Apr 2026 17:36:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-488ab2db91aso132360665e9.3
 for <u-boot@lists.denx.de>; Sun, 26 Apr 2026 08:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1777217792; x=1777822592;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6deyBlFxw09CVeWWPj4uHvVX4vEcxqd8u/pC4T+uRdE=;
 b=qbete4FvyZAJFQcZDalS+A2bC2jojvhK0GloAv8FP7NHwh6KmYRT+mPHkw+3QVCSSW
 /7CbLIQSGo76MANITLXyiIZABPeSD2FoN8Vb9S9bJywOQVCTZ1vDIx3NINC9e5BC8Or3
 FO0dBBpTbTd149/Fybl8gG38Hm8t+6ZhNDHGY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777217792; x=1777822592;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6deyBlFxw09CVeWWPj4uHvVX4vEcxqd8u/pC4T+uRdE=;
 b=bSG5QsSXEIdeK7XQg97hDQ81JxOezv9FGh26Zn+NTqQErV2nWiNVAIuxIX0ckl4ohc
 yWk1FNxDEPgkdswwjp684hN1S3AEdBtzzBDzzzQPoPPkM8J3WDjtm51n/J0hYuKtmOdY
 syqTQQWjXs73zvBJ3Y+NSbzBokM27X6z60HsQOo4vsvEON8rCIl3vrgZWc5M8OnaoLrE
 gchqG3efdmBQKSJ3YUeybNg2YRxHicpot6vvE1N5Xtaj1pUQdT1JjV/lqEk0R0MuQ1Kq
 a/8YrtrHGYiKROSD12qzeCRm8Xy2p2rxgI57nXwtBt7qAjBJaUXjBTxL+TWbJNXedDTk
 Vq2A==
X-Gm-Message-State: AOJu0Yx/2kGVAergYYEGDg9AVDI/juMWZzGDSCLcz7TARrwQTTjEa8So
 yBVu0WBjxkqPQoCYPILzswP0TY3TyQTbWeYb/pj2jjg/c/3AzZOamIbqBtSe1AGWSIyq8dD+lPo
 m4TQx
X-Gm-Gg: AeBDieuMNC6CHKyQxu8nurbOM6Rm1g1lD+itRmTHF3ZZUTkJ0HodwwBnvnpi/dnzFaF
 2Z2neYkRYCe3KyvxPA4XnDSebjvMnJElBdPQy2e3hnOthkg3K+XSgOm5LJICFiHITPka50cExR9
 quJpaLw6LUgms/6XKKw9Ah4m0+L4o3NB7fW23O68W0Dqtb38g9w+wqa+skk+LVcUfVIyahs94gC
 rqVP4qVkrmBHqtteVO0JSSgUIoEnwI1cYLH4QJYQFyjmawHsoL5hZ8sBcJYi/SOTKNhqZKsKOMF
 eJ9/Ce2wTunXBR8bYlmAcnJKXOLzVOL+l9SPiNGifzirk4G2HNgh9QbR4OyfVjBgyjjideaWj0a
 QwvKRVECZVJusIPXTVT+GSgLxMy7Yzb3m8vNz36lXIFGR4YJ8emEL4SzAsdfJqzd5YCYdu4xSvV
 b1AwdXHxaXBuF38kqZLbmbEk45z//lnFcfxqWXAalZ2Lt724TUvicLB9RlB4lQ2MhRTkLxvmnNq
 QYIDct636rg+DcF5dJ3KbwGHLZejDKpsrx9QXA/eBTsO5qoySZvL9y95saecw43v7G1Iym40cr9
 RlJW2OENdabVQh/oJ1XeoVr3GcqWYg==
X-Received: by 2002:a05:600c:350e:b0:488:b811:51c4 with SMTP id
 5b1f17b1804b1-488fb788231mr613506515e9.25.1777217791794; 
 Sun, 26 Apr 2026 08:36:31 -0700 (PDT)
Received: from dario-ThinkPad-P14s-Gen-5.amarulasolutions.com
 (host-82-56-22-134.retail.telecomitalia.it. [82.56.22.134])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a5499b0edsm388438845e9.14.2026.04.26.08.36.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Apr 2026 08:36:31 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v5 7/8] test: dm: fwu_mdata: add test for
 fwu_mdata_get_image_guid
Date: Sun, 26 Apr 2026 17:35:32 +0200
Message-ID: <20260426153617.2039651-8-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260426153617.2039651-1-dario.binacchi@amarulasolutions.com>
References: <20260426153617.2039651-1-dario.binacchi@amarulasolutions.com>
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
---

(no changes since v1)

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

