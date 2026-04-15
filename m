Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43A34F4213F
	for <u-boot@archiver.kernel.org>; Wed, 15 Apr 2026 18:33:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 33E338407D;
	Wed, 15 Apr 2026 20:33:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="RprOXNim";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16C12841D7; Wed, 15 Apr 2026 20:33:09 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24F288407D
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 20:33:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-48334ee0aeaso70379345e9.1
 for <u-boot@lists.denx.de>; Wed, 15 Apr 2026 11:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1776277986; x=1776882786;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4qwQtwx0F7OAHSpH2BRtevmG2YeLdtKDK5EN3GCzcuk=;
 b=RprOXNim/DmXchn0775L1h37t170HiV+FUCHCp591pXg5Rgb3vrp56aYRc5WoGmN+M
 tYqxQA0srk85hsIabPTTHld02et0DGY0uOshXqB/IDcAZ48egZEwrfs3B1FI5PGA+lRO
 oPzfErUEY6p6IHi0mvTPntJ/vDk5YnbvIJQW8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776277986; x=1776882786;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4qwQtwx0F7OAHSpH2BRtevmG2YeLdtKDK5EN3GCzcuk=;
 b=bDYUNdYO73A3JqJ8Q/ApLDR6k3EtTDk9QQ/KVhJUfiQ9RNbIF7+sOnhxKhxHrHDUht
 8oLPlx+3g4WBbvNZ7qdmEnMRET6LkZ2HEpf4JVF0x4vBxPiBIixyM2/9298Ly6Y9mU3O
 DjbGVhObcKxkCbDIB7bnHVdpJBMlQNPC6CLBBTrIndHzDzqCZB/JLTNlGXDDo8GzLzAY
 +pUzTtVjyRhKLbq4t2NxqxRvJ7LPzruapgyjzG9oMgMpAtOm8Urcboz55+g1O2D1edMu
 Cq7MvHVJZFDssMPVDyjiYuEEYrY0/swzb0NELABZmWrPZfD0en7dM07yXItS6U/zB7ge
 C+Jw==
X-Gm-Message-State: AOJu0Yy2g4eFMOMf+iCfswIeeku/o+6gtvEi3j0nsa/0TZdFib8+u8I9
 QPbXPZ58JmiECkbZOeoEFUC4CA+vW61PQoNggDx1lKZRQIAjqYRvU9csuYMotbNB+rTqevgzRcs
 ZmByw
X-Gm-Gg: AeBDievUGFQfR0enRw/xvUlgPwibL1KjJ0BlmDNV/OVjKKZq1pueVxrir0fzL5/HvSJ
 dtzP27UGGJyTAcKHQgf8/9B6kTOL6wR9C6UqiqEdo0kzIhNdDjBCL8YUe3iStvlFhpR1WOVDn2Q
 QJB2s7B4pUp4STr9Lu9M8Bl2U1TqKvjTu84rCBcq9/eP32KiYhoDRnDlDjRn6BwcXXjy5cak6aQ
 aekX4quY9tG9VoPQ5riOP+PQLX6gj0XJMUdaILU+WoAi/xPQkFpKMaW8yFi70iLMynE56bhDcXp
 OTvflxSkiL8tR7q8kO4EumVuHY5WBOyuT6vdrTRFCtUT+J895VJmOhlNJXo/5cjnW+zh+gKa0iv
 35TUqG1qj4wW8s1KOOCnqAkls87Q2FYsgh7e4rrTLYNPASXTOD1jMq4UWYmUEjqKf/j990Poqw/
 WVHigmio3fr+y5Irww5DLvQYsl0Sol2iovajlOJq9gsg9H/UL3rqgTN6ftG8DibFt5rheVKxmGP
 H3qoIvZliiDqEolQQxVZKCTM2z0MyT0sHvnniRbyr6QC9Z81T3Diez1Ow==
X-Received: by 2002:a05:600c:45cd:b0:488:a82f:bb96 with SMTP id
 5b1f17b1804b1-488d68c7fc2mr298052595e9.29.1776277986317; 
 Wed, 15 Apr 2026 11:33:06 -0700 (PDT)
Received: from dario-ThinkPad-P14s-Gen-5.amarulasolutions.com ([2.196.40.93])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488f0e72980sm34953115e9.5.2026.04.15.11.33.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2026 11:33:05 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Simon Glass <sjg@chromium.org>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 2/7] test: dm: part: add test for part_get_info_by_uuid
Date: Wed, 15 Apr 2026 20:31:29 +0200
Message-ID: <20260415183250.3031030-3-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260415183250.3031030-1-dario.binacchi@amarulasolutions.com>
References: <20260415183250.3031030-1-dario.binacchi@amarulasolutions.com>
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

