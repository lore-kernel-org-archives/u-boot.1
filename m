Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AA60CCA470
	for <u-boot@archiver.kernel.org>; Wed,  1 Oct 2025 21:31:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0919D836C1;
	Wed,  1 Oct 2025 23:30:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="G9ap18lT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 707088381D; Wed,  1 Oct 2025 23:30:05 +0200 (CEST)
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com
 [IPv6:2607:f8b0:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32533835D8
 for <u-boot@lists.denx.de>; Wed,  1 Oct 2025 23:30:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-424da17e309so3672225ab.2
 for <u-boot@lists.denx.de>; Wed, 01 Oct 2025 14:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1759354200; x=1759959000; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2Jv2Pa7wwLzle12C8Oklb39xybqhmpseVlMi/lMi1Fw=;
 b=G9ap18lT5HYO3/Q0C694imlpXuALhVI/7kabxiAG5SJzDFfq0/AGls9v0xd5Gi/TRc
 6S5k1eLBc5EIE0LsOPWqsl8m0XP+VQd+QGX/QnkZHwNkvu4jGwrb2TkvjtOsIEj467eQ
 8qavvDBARHvEN0ftXpLAKYtPO8PoYU50AHa2o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759354200; x=1759959000;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2Jv2Pa7wwLzle12C8Oklb39xybqhmpseVlMi/lMi1Fw=;
 b=QN8OrchGp5oXlHF8qqmUjuAShGUBTvigssugURkdiVnYkcI4PwkXjXPhO+aFRxCnoV
 dMJbQZIDEFm7x+7oMxTRO/8BC+498aGB1ECiJn5mzXvbJiZ58C0pJ+IIGl+vy3djSC5h
 xXVaugQi4Mb08gRYzYd3IuTt7opj/hsovEoLYmrWapymYQjLyUpjPaXLeG7wPG5MqCR1
 H1D8Pt6I7AUYFLr/ZFMPeZLS29RTJ3ABIcMAgpTTqcwA3OZF233VAflL/wk3dnx2ClkX
 04Kb36CCKQ2g2z9mBh0fDKuA/NZOMmX744GTvreYm7rfuJOqKnlbZa5xfiJEmZi+Cs6N
 rTEw==
X-Gm-Message-State: AOJu0YyfwWKSDGTdoW1aJ2aUDJdqN2amEv8LHPSLinsw0qOGNkHk46zS
 Gxw3txa2R9J5j+4CMOGpDTiE7mGCXHjsuVCslvUJD5BgyXU/uvlZCoBS4AHQFJ9eQ2JLyHGScdT
 KaBIIHuty
X-Gm-Gg: ASbGncv5uOO4nxpd2LOcmyfM4HoLQHoXMiuXzuFEecufWfK6TOOba6lYjLimSujztWu
 2u4p4pO+k3OGeoOp1NLl/44tQaBfgV92gESZXz7EHFEs7/8R61k5n5sCaR04WDzVjiCaUaX8ZyR
 RJxqKQ42tlJQGp4EA8XQ/xHDu6LXJhDDDGQjrgB2zAAfK/3b2PBOcmBHkNBAYoaQGNm2kNJ564f
 M557hIvkIp4pmsitlGtJHmoto7i+5AVGvJUbpmiLMITFobEoj1CQZ0CG4/8/Bldf3ncwQN88Z+z
 NoBqRfT1EjMmkrV0Hrqusx/GPpOiWMU+MbJ26OI8SB+SlcfKiEglwbQZSQlQ5AvvO5/1yJjyanT
 iWYkWOUKWVBibq99CcKrgJjDhUF0ic2P5cXRGwM1A
X-Google-Smtp-Source: AGHT+IGgeXg0NHrdbRPOValNqFqgkeEP/vp1fC2iFSDi8FkPKbqTY1UES0Ri99Q6GrrCpcDZlQt+ng==
X-Received: by 2002:a05:6e02:1d94:b0:429:a1b7:ee3d with SMTP id
 e9e14a558f8ab-42d815cebe3mr69465055ab.2.1759354200062; 
 Wed, 01 Oct 2025 14:30:00 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-57b5ec09429sm202844173.55.2025.10.01.14.29.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Oct 2025 14:29:59 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 16/17] boot: Run the EFI bootmgr just before network devices
Date: Wed,  1 Oct 2025 15:26:41 -0600
Message-ID: <20251001212649.3263574-17-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251001212649.3263574-1-sjg@chromium.org>
References: <20251001212649.3263574-1-sjg@chromium.org>
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

At present the EFI bootmgr scans all devices in the system before
deciding which one to boot. Ideally it would use the bootstd iterator
for this, but in the meantime, give it a lower priority, so it runs
just before the network devices.

Note that if there are no hunted network devices hunted, then it will
run at the end, after all bootdevs are exhausted. In other words, it
will always run.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Update commit message to indicate the bootmeth will always run
- Document how the priority was chosen

 boot/bootmeth_efi_mgr.c | 9 +++++++++
 test/boot/bootflow.c    | 4 ++--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/boot/bootmeth_efi_mgr.c b/boot/bootmeth_efi_mgr.c
index 42b8863815e..05fc35d01a9 100644
--- a/boot/bootmeth_efi_mgr.c
+++ b/boot/bootmeth_efi_mgr.c
@@ -99,6 +99,15 @@ static int bootmeth_efi_mgr_bind(struct udevice *dev)
 	plat->desc = "EFI bootmgr flow";
 	plat->flags = BOOTMETHF_GLOBAL;
 
+	/*
+	 * bootmgr scans all available devices which can take a while,
+	 * especially for network devices. So choose the priority so that it
+	 * comes just before the 'very slow' devices. This allows systems which
+	 * don't rely on bootmgr to boot quickly, while allowing bootmgr to run
+	 * on systems which need it.
+	 */
+	plat->glob_prio = BOOTDEVP_6_NET_BASE;
+
 	return 0;
 }
 
diff --git a/test/boot/bootflow.c b/test/boot/bootflow.c
index 1e98bb7d978..ea394c34ba9 100644
--- a/test/boot/bootflow.c
+++ b/test/boot/bootflow.c
@@ -455,11 +455,11 @@ static int bootflow_system(struct unit_test_state *uts)
 	ut_assertok(device_probe(dev));
 	sandbox_set_fake_efi_mgr_dev(dev, true);
 
-	/* We should get a single 'bootmgr' method at the start */
+	/* We should get a single 'bootmgr' method at the end */
 	bootstd_clear_glob();
 	ut_assertok(run_command("bootflow scan -lH", 0));
 	ut_assert_skip_to_line(
-		"  0  efi_mgr      ready   (none)       0  <NULL>                    ");
+		"  1  efi_mgr      ready   (none)       0  <NULL>                    ");
 	ut_assert_skip_to_line("No more bootdevs");
 	ut_assert_skip_to_line("(2 bootflows, 2 valid)");
 	ut_assert_console_end();
-- 
2.43.0

