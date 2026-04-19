Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95310EA7190
	for <u-boot@archiver.kernel.org>; Sun, 19 Apr 2026 14:33:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5469584297;
	Sun, 19 Apr 2026 16:33:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="OlnsHDeS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A44408426E; Sun, 19 Apr 2026 16:33:00 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B30DE83B99
 for <u-boot@lists.denx.de>; Sun, 19 Apr 2026 16:32:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-488a88aeec9so34552545e9.2
 for <u-boot@lists.denx.de>; Sun, 19 Apr 2026 07:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1776609178; x=1777213978;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j7kw4CvLJkX2EjGaympe8ZZB0RtPYp/BO11dE+j3/IY=;
 b=OlnsHDeS0kB0HO5VoJ+bhrojPfbSAlX3oYBOKr9+I2XMfQmpzM/yhD6f+eKx/FQZ0l
 UHaLWplJ8hXXumeJsN6uAtAMFObBnoSLyQRc6C641fVpID5lWH6FXIwvLxFTdJDUWeqV
 HlnNWQYUzq1KPpksu37T9IP37BSvyYFSW5Rd8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776609178; x=1777213978;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=j7kw4CvLJkX2EjGaympe8ZZB0RtPYp/BO11dE+j3/IY=;
 b=KJap5av+IvKBRZgs84XCjS/kOXk6+oefvO9ERSrX2sXwv5R5k2C00rQfrXlpvb+jlJ
 acL8HIT4UfpBdAzXmQYFgaGtj6JTfEpw1bnt2WXVl2PERkfZymge77gi+U6uWvD/Psxk
 mAoROJAjQd23X9KGz5C9XiBduxb4MqScwPSGCd0lRfBamrn+uowavbIhw51MIHhyQxnh
 QJvYoa9dmk7SFQpIlw1LJGBvRio7BL5qzoRWcpA6MhwJA57bWNlcTVmPlmOrA2eQyTjI
 u6FUjHefYZ0nFEfAa6nnF5ZE7P+wtF3bTysw01OP3cXuWPluDbUD+l63z25UhR5tfZPS
 O6fg==
X-Gm-Message-State: AOJu0YygznBWVJm1+MTJ/tuqu+gd35Dfj52Fy72Z7gZ3aAhmmCfySnof
 /aR0d+gLdmDolOSiOrqmB2n/kteZ9iys39B4k6q9ez8NnWPkL67cctT8AR7AS+PIH44xdkYGspi
 4rHEi
X-Gm-Gg: AeBDieui8ghJv4un2HEgVYc66JVlQsnA5xxVcO1rI1d3fDN0vEKM10LVlzsOuv2IBWF
 0qSJporghGofl0ctW9OpQ9K8343P9gkXK5caRqI9Ynm8AhpwPadnW0TTwFoOdfpjJximZggBtgS
 fU6ZX4yx15b4RiPrhRBMOGNGr+5Iv0asA5085QrmhospEQgv+SsGUJs8ghLUurOZ4Yu1r+76jwS
 aJI9MkR3RZX8Bsn4nLQJ8X/p2itThXJmmxwjFaw8+0Fcn0bb732FEOj6Ea42E35pAWLCjONIz4C
 W3PUEG57eL32g1wexxrojVEF5XVVbDLHZjEtXHonxXFE59SeqTqZWLJ4QZx9ftybOcPFfNPrwCe
 5KanZ2ZKF8pI3RfoJxefeKQv1kpYzUXiZJxKF0yH7MKh+t2uCSf/2ZGj+BIb60n0UNSFxAADZ/Y
 lVHmg9G/NCyAv9t1fCRGtQuQZOzmZVmVUs3q8W0OEOFITs7CDcnNPW4GAdHZ3xksGgLM0Ca34FP
 iPWWYVOKLFc8Sejq29jcryrlv0qyAQEi2fOFcMJSyqXYaEkSrIWFH3zvxR0mmm+szafevjjU8wr
 kVwo0fQHUgZYE+YVVNpMA2YKL4TTqLRJ
X-Received: by 2002:a05:600d:8449:b0:488:a894:b27a with SMTP id
 5b1f17b1804b1-488fb74a8c2mr124692015e9.8.1776609177967; 
 Sun, 19 Apr 2026 07:32:57 -0700 (PDT)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-79-20-97-39.retail.telecomitalia.it. [79.20.97.39])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fb755938sm86864245e9.3.2026.04.19.07.32.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Apr 2026 07:32:57 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Simon Glass <sjg@chromium.org>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 2/8] test: dm: part: add test for part_get_info_by_uuid
Date: Sun, 19 Apr 2026 16:31:42 +0200
Message-ID: <20260419143247.437733-3-dario.binacchi@amarulasolutions.com>
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

Add a new unit test for the part_get_info_by_uuid() function.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Reviewed-by: Simon Glass <sjg@chromium.org>

---

(no changes since v3)

Changes in v3:
- Add Reviewed-by tag of Simon Glass

 test/dm/part.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/test/dm/part.c b/test/dm/part.c
index caae23bd4aad..ad37d7f406f4 100644
--- a/test/dm/part.c
+++ b/test/dm/part.c
@@ -195,3 +195,56 @@ static int dm_test_part_get_info_by_type(struct unit_test_state *uts)
 	return 0;
 }
 DM_TEST(dm_test_part_get_info_by_type, UTF_SCAN_PDATA | UTF_SCAN_FDT);
+
+static int dm_test_part_get_info_by_uuid(struct unit_test_state *uts)
+{
+	struct disk_partition parts[] = {
+		{
+			.start = 48,
+			.size = 1,
+			.name = "test1",
+			.uuid = "c5bce7a2-03f0-4d03-9048-01ff23b9d527",
+		},
+		{
+			.start = 49,
+			.size = 1,
+			.name = "test2",
+			.uuid = "9df346e8-2c53-4cd8-b9ac-3af83f9a9b74",
+		},
+	};
+	char disk_guid[UUID_STR_LEN + 1] =
+		"8d60b397-1bb6-4d33-80ee-b1587d24c2f8";
+	struct blk_desc *mmc_dev_desc;
+	struct disk_partition info;
+	int part, i;
+
+	ut_asserteq(2, blk_get_device_by_str("mmc", "2", &mmc_dev_desc));
+
+	if (CONFIG_IS_ENABLED(RANDOM_UUID)) {
+		for (i = 0; i < ARRAY_SIZE(parts); i++)
+			gen_rand_uuid_str(parts[i].uuid, UUID_STR_FORMAT_STD);
+
+		gen_rand_uuid_str(disk_guid, UUID_STR_FORMAT_STD);
+	}
+
+	ut_assertok(gpt_restore(mmc_dev_desc, disk_guid, parts,
+				ARRAY_SIZE(parts)));
+
+	for (i = 0; i < ARRAY_SIZE(parts); i++) {
+		part = part_get_info_by_uuid(mmc_dev_desc, parts[i].uuid,
+					     &info);
+
+		ut_asserteq(i + 1, part);
+		ut_asserteq_str(parts[i].name, info.name);
+		ut_asserteq(parts[i].start, info.start);
+		ut_asserteq(parts[i].size, info.size);
+	}
+
+	part = part_get_info_by_uuid(mmc_dev_desc,
+				     "00000000-0000-0000-0000-000000000000",
+				     &info);
+	ut_assert(part < 0);
+
+	return 0;
+}
+DM_TEST(dm_test_part_get_info_by_uuid, UTF_SCAN_PDATA | UTF_SCAN_FDT);
-- 
2.43.0

