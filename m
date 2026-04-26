Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4096FF885E
	for <u-boot@archiver.kernel.org>; Sun, 26 Apr 2026 15:41:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50EF48432A;
	Sun, 26 Apr 2026 17:41:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="cmJZJPe8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2896E80087; Sun, 26 Apr 2026 17:41:13 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB9C984236
 for <u-boot@lists.denx.de>; Sun, 26 Apr 2026 17:41:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4893940bb5eso47470855e9.3
 for <u-boot@lists.denx.de>; Sun, 26 Apr 2026 08:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1777218069; x=1777822869;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6deyBlFxw09CVeWWPj4uHvVX4vEcxqd8u/pC4T+uRdE=;
 b=cmJZJPe83XF9CqHDZmOmgZ9feLx/3ihIDXVhKtJGx4pcxI8A1XAxbNpXiP3rFi7Xl2
 cUCht99bTyyqzFYt+Aa6RcCEgbJ3+Win/ykBgKvFbRJYwLsUoOuwTgZQ/b5abyWqJY1C
 u0qCf71Td1dbHodJPDmxzPmneLdHgqZbXhfXQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777218069; x=1777822869;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6deyBlFxw09CVeWWPj4uHvVX4vEcxqd8u/pC4T+uRdE=;
 b=kbe/EBKaEmQgXim1BoyGqkhyrNKYZGXJrvBgXbjpgwCguT2SWmuUEek70DTGB2XSIZ
 ZqT6lttcpxdDcqpYsXH/m/WJXSzRy6et5i9lAGQF9uA1W1r3OrhYzEZXm0tyk5U0e6wE
 6rDZSsFY8u1/zOZvElKbwxWbK417jl0E/FKh5ZOtxHPr6a1euorm3T1WeWaR2AcM/oc4
 eUk1yQqotLrE2Z+sT5Xdq74pxgO45XMBFFsa97kI+aiNEBRY/DSQlCImFylDCAmuYwSv
 crAKU852FTU3UVUqXjeGfkMQyQFuu3uRuifSXcSf880Pf23ndDwdgtljVQIwj0ekg+V+
 ZrvA==
X-Gm-Message-State: AOJu0Yz6as//rra/oyOdZcTZ0xmXCe4xoSTru+sgY/msUp4wwgza0E59
 Jt6DRG+CtQAoS5zuUF9wst8247QKNMLSVYXoZxTkjaTYINOkxBtbeBBDR7FMZ4p7YyxqhUxI35a
 wG7Af
X-Gm-Gg: AeBDietdEESC880vtBtHLUdzsk0In9nb2C/nfw4/xZjQoMkgcKubsOt2bOKJJX8joAg
 ZJ2KKLF1bheKjVDFnKvv9wEt3J0D+RQl7xirh+seSukqO00hlA5TCAvtbKcTy8PL0oLHjPmGuQi
 0L+EvgFiy0UEXvVswU+B9dfgoYUEcRRGKKke8n0CgBbg3Fo1/9sntpsvbj5ugVVc7E8RXK0C1oZ
 Dg92pyw9Y1y8qAqJbxR8AAvwqGXh/QSa3CuzP+SZBWB4InMaV+k7UdmbMU73KG4Q4UNQR5+nnH0
 yV4BPSuAo3+lAAoAuHCXuiTu72rDzLjsQ2UCPY6klcLjORz3KfbMW/RMVsGs5OQ5LSrSol5e5MC
 vQvhNmd9fOZJAlY2kixJdFaCQS9NPSSipEd9+sfq+Y1FafhV6ec8tdSkOqMmCbzTrqKYArQTbwE
 1vwsmeYopE42XZCFh0aAjUpjzgWlG3dgDX5NvEjsHY6VuK+AK8fbp/7I3nDhuD1REuM/ATIkCIt
 p0pznKiLdQ2WFtEzn+S/kyhBWalS82yH7uOI7G06lVscoPwM39uvsCxzEWl79jaVdWHjj5XKf6Y
 fcLabYD06CG9sxY+/hcZjgZseHY8aQ==
X-Received: by 2002:a05:600d:b:b0:48a:56de:d63c with SMTP id
 5b1f17b1804b1-48a56dedadfmr243922765e9.27.1777218068923; 
 Sun, 26 Apr 2026 08:41:08 -0700 (PDT)
Received: from dario-ThinkPad-P14s-Gen-5.amarulasolutions.com
 (host-82-56-22-134.retail.telecomitalia.it. [82.56.22.134])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4891bb3d121sm802593765e9.14.2026.04.26.08.41.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Apr 2026 08:41:08 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v6 7/8] test: dm: fwu_mdata: add test for
 fwu_mdata_get_image_guid
Date: Sun, 26 Apr 2026 17:40:39 +0200
Message-ID: <20260426154054.2040932-8-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260426154054.2040932-1-dario.binacchi@amarulasolutions.com>
References: <20260426154054.2040932-1-dario.binacchi@amarulasolutions.com>
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

