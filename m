Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8155EA719C
	for <u-boot@archiver.kernel.org>; Sun, 19 Apr 2026 14:33:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8F1D28419E;
	Sun, 19 Apr 2026 16:33:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="CZy0pZBS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A57FD842ED; Sun, 19 Apr 2026 16:33:10 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 14A6A842E1
 for <u-boot@lists.denx.de>; Sun, 19 Apr 2026 16:33:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4888375f735so24240785e9.3
 for <u-boot@lists.denx.de>; Sun, 19 Apr 2026 07:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1776609187; x=1777213987;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6deyBlFxw09CVeWWPj4uHvVX4vEcxqd8u/pC4T+uRdE=;
 b=CZy0pZBSKjLXQg5Srhk1NcwtBqOzDEwyRJOC91DSbYq+ie3Lip9T3caGh+QMfZJzu/
 CAn42PUMGwVr7LL9VFSAqHCcVmtzyx/ytnK7PJhABjXTxl1xzNpiuRJGpx73PYic908T
 WP+Tw/fSocUo3c42jJgKBsr47R96MD175EIno=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776609187; x=1777213987;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6deyBlFxw09CVeWWPj4uHvVX4vEcxqd8u/pC4T+uRdE=;
 b=q9vJ1eZU2+2l4uXcd490MYUvgIBVcAI9/pGYr2Z95fvxc2Ub6yCoo47lP3jhJK9aZl
 FSmLyTzfQp1wiJ4KKXSDsj5X33O8xYYI40bBtq+a+tlthbxAp4m5HX4spdDlhboyZ1Am
 V6u8/BoIlt9w4MdZ7OosR1PRG9VSxmyacEy0e4DawAWLqm/Et8H8rMNMLF7FGQ+M2pVD
 W3Kkbfx+l1iC3Dbxru2iIOut/Wf5SM0qO1YsTxEDLGhUnGlkT9Kuie/QquFQDOo9aE3n
 H9QmhFqnXtgfNYvyewVNIDkohsU/6TOolxg5M0lbVvcInHCrZoESLnHdn2VKo5AdP1gH
 Yu6w==
X-Gm-Message-State: AOJu0Yz5aJae13XEC90CtYvGW/gy1PrsGWry27sQL1nKkmgvOGgZOrbw
 adyaqHB0E+uvRMIfE77JNokBJi905bXvnLQEfBnQMdUm8X8g1mv6+FxJ7USaVEcfH87jp4V95oq
 ImyXZ
X-Gm-Gg: AeBDieuh+GjzpIIqbGemJty6aw/L4jCcTFmKGJ6iuWheOLHScTDEa6ic0hpcetitFri
 03ie/3ZtSp54WB2kOOhQAGjqezJwra6hucMIKBEJd2COK8D9r2SwDgVQt6lLJKeEI8QqIUeOdsz
 0Gadg3lZwSJfnF+/WfztYEz80JrHUWqUBDgaiJkDAXr0OsvHXEkDlo+3yw/h7vku7EnP7z3twUy
 RoKzD/pB6X4OFzZC9e/2UtZB3Wd2LxQSr06autEfksotA2M6zf2D8RTUiWNxPM3jWMHDY+meEs4
 6TC1OMyCGBJjJW4ADEnoFfinjsElI1J7UNI9BL3w9+kMkc0xZRWhm5BQ7oifVS4uW2INcN0buoR
 u6M/fGFGvPSfsDUHfBKhUwo1nn9waOZxnqCpSGbY5W7J23R7WRVq0BhlPfpdzktK1x5j3S/PTuT
 sBiMyvXGFtTGFdF2s9MpcXJhKzBb/UJuNySnl4Mnl2c2qvZsFpFGdUU5Cahz8EoxHnmogTEUZhz
 yngNFlj0RD9FWUHApj3iEa4P+qDKHiz/eIzCTVCVL7FxZBzsq+KVTVEMuJPpRbjx+iwwiPZvwJB
 AVq8f+YGBpqI2OdfqS8Jb9P+eFJrH4yz
X-Received: by 2002:a05:600c:a404:b0:47e:e2eb:bc22 with SMTP id
 5b1f17b1804b1-488fb73b2a3mr124175025e9.5.1776609187279; 
 Sun, 19 Apr 2026 07:33:07 -0700 (PDT)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-79-20-97-39.retail.telecomitalia.it. [79.20.97.39])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fb755938sm86864245e9.3.2026.04.19.07.33.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Apr 2026 07:33:06 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 7/8] test: dm: fwu_mdata: add test for
 fwu_mdata_get_image_guid
Date: Sun, 19 Apr 2026 16:31:47 +0200
Message-ID: <20260419143247.437733-8-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260419143247.437733-1-dario.binacchi@amarulasolutions.com>
References: <20260419143247.437733-1-dario.binacchi@amarulasolutions.com>
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

