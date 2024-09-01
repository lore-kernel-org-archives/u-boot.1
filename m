Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E913FC54FC6
	for <u-boot@archiver.kernel.org>; Sun,  1 Sep 2024 22:28:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D4D8E88C35;
	Mon,  2 Sep 2024 00:27:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IIwlthdP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 297B288B16; Mon,  2 Sep 2024 00:27:02 +0200 (CEST)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1B35988BD4
 for <u-boot@lists.denx.de>; Mon,  2 Sep 2024 00:27:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-82a13d1c8f9so166015939f.1
 for <u-boot@lists.denx.de>; Sun, 01 Sep 2024 15:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1725229618; x=1725834418; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/teZiUk0bTynahU246G+ye0nJzrAnwKyFUvVPIr9uqY=;
 b=IIwlthdP9L6Ed1EECbOH3tmAYS/WEBx23AzQW5B4IFK3YpXbtNWY3DeDcZ6ayLiu/X
 +w49d79MX8hW9FChFpyHoX6GmXZFz/9chKv2F86PHWeKVDLlztC9VPfjTjZs6h/eB4nN
 K52gesXWZSbCckxaVIrghme9wJkixaM9OdL0o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725229618; x=1725834418;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/teZiUk0bTynahU246G+ye0nJzrAnwKyFUvVPIr9uqY=;
 b=HFnAU7W9q859JvIrfhj4E/tja3UdVM/JiGqMCjhqfKLZS5f3lKN/qg62+8gwrCQO4O
 Thd8ojPpkPrc7CS5UdtzUDBpzlqP1Dj2tPlVyLM2tLjQ5V5iF1FeL2mXfvzaAIUaKWMQ
 wfFD9DTjW/KnAaUbc8grRn2KebhqeyjAD9VxfpfJ+XW+fMVC6fEG7mLSLQSGAjZpdp+Z
 q2oJ82ofTWI5OQhVl+gIcp/ZlgJcef7WhCGmgEOYdmxTLT/JEqPmpYW0KZ6uwYY3hvUW
 CT46VkC3rwRJGyeVwFd0boXE2Tf5eAL/WVr7PuV01LFwASmuwd6VnITihY6Zxc9etrhb
 z77w==
X-Gm-Message-State: AOJu0YzSnTIIPII6wEqo/lEglb0/cR1JiJcwTsIM36kpSoXlLFrRA173
 BG6kH1ULJuNyR3bsW/mE5MZhWZWxoV64fJQB4/vr8UYNuf9InsaXY5Cz539gfl3nFWaAepIdUWM
 =
X-Google-Smtp-Source: AGHT+IFE2BP7wPWuOMgsP7sYZq/TaIKQ0sUy8hsojjXRyZqILsUCZhBTdmsynYMxOanjWCbA4NDo/g==
X-Received: by 2002:a05:6602:b90:b0:82a:3d74:6c4c with SMTP id
 ca18e2360f4ac-82a3d746dfamr512267539f.15.1725229618443; 
 Sun, 01 Sep 2024 15:26:58 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-82a1a4c099asm215751839f.48.2024.09.01.15.26.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Sep 2024 15:26:57 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 10/23] test: mbr: Adjust test to use lower-case hex
Date: Sun,  1 Sep 2024 16:26:21 -0600
Message-Id: <20240901222634.460873-11-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240901222634.460873-1-sjg@chromium.org>
References: <20240901222634.460873-1-sjg@chromium.org>
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

Switch to lower-case hex which is more commonly used in U-Boot.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 test/cmd/mbr.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/test/cmd/mbr.c b/test/cmd/mbr.c
index e1a9cdffb04..98a745df6bc 100644
--- a/test/cmd/mbr.c
+++ b/test/cmd/mbr.c
@@ -50,7 +50,7 @@ static char * mbr_parts_tail = "'";
 000001e0  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
 000001f0  00 00 00 00 00 00 00 00  00 00 00 00 00 00 55 aa  |..............U.|
 */
-static unsigned mbr_cmp_start = 0x1B8;
+static unsigned int mbr_cmp_start = 0x1b8;
 static unsigned mbr_cmp_size = 0x48;
 static unsigned char mbr_parts_ref_p1[] = {
                                                 0x78, 0x56, 0x34, 0x12, 0x00, 0x00, 0x80, 0x05,
@@ -257,7 +257,7 @@ static int mbr_test_run(struct unit_test_state *uts)
 	mbr_wa = map_to_sysmem(mbr_wbuf);
 	ebr_wa = map_to_sysmem(ebr_wbuf);
 	ra = map_to_sysmem(rbuf);
-	ebr_blk = (ulong)0xB00000 / 0x200;
+	ebr_blk = (ulong)0xb00000 / 0x200;
 
 	/* Make sure mmc6 exists */
 	ut_asserteq(6, blk_get_device_by_str("mmc", "6", &mmc_dev_desc));
@@ -267,7 +267,8 @@ static int mbr_test_run(struct unit_test_state *uts)
 	ut_assert_console_end();
 
 	/* Make sure mmc6 is 12+ MiB in size */
-	ut_assertok(run_commandf("mmc read 0x%lx 0x%lx 1", ra, (ulong)0xBFFE00 / 0x200));
+	ut_assertok(run_commandf("mmc read 0x%lx 0x%lx 1", ra,
+				 (ulong)0xbffe00 / 0x200));
 
 	/* Test one MBR partition */
 	init_write_buffers(mbr_wbuf, sizeof(mbr_wbuf), ebr_wbuf, sizeof(ebr_wbuf), __LINE__);
-- 
2.34.1

