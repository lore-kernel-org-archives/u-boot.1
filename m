Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C4A7D73094
	for <u-boot@archiver.kernel.org>; Sat,  4 Apr 2026 15:27:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E25DE84105;
	Sat,  4 Apr 2026 17:26:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="lltr2Wvl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0AF1383C14; Sat,  4 Apr 2026 17:26:59 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0DE4283CD3
 for <u-boot@lists.denx.de>; Sat,  4 Apr 2026 17:26:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-43cf7683a28so1576455f8f.2
 for <u-boot@lists.denx.de>; Sat, 04 Apr 2026 08:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1775316416; x=1775921216;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7vsC278ki22hZLC0y+544VenywlCTyldgzB/WZ5r7Zg=;
 b=lltr2WvlYKV9u4onzfzlKrUe+6giAY6Rk2SCbsX43RnbL5iVDL4YxlY1u8fDhfy2Ro
 dajyjdh++rtTeKPvhjuAyQuZsBcbGQ5QZhS3ssZSv83fNvrbBx/iY7QnrYrA5vxsWUSx
 LsgCyd6RFUTAtUSUd63xeWVp91AAbv8lzXoac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775316416; x=1775921216;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7vsC278ki22hZLC0y+544VenywlCTyldgzB/WZ5r7Zg=;
 b=UwSwy9SL6C0kzjQhu2KzFU6lrIBF0lB5+3AgSFZGwvVeW5/Iv2xyBRCE2T/BqnPgZA
 jR0RHSRVFTotvO7NlMLVMtQ7B1McYEQ6HJJZtl4PBwhA/9SaYAVkOXo3EyAkvtPSKFcV
 rEzh+3aBqtVwmyXcnSL0lzqq09TKPte0Hv9KrtpU1jxp6H4YZs6AIyS6mbnzOlnrCyUB
 th6OX8WBXxgbCGBfHAKUncKCCTw7Plu0BGmfCmlA2CPkyo7440tlePjTWatDV35C/BHx
 ybJtBbk2bKmmKGAhofbYlqw722ZtDU2VMwBRWpp8MVrqA8JTCJys9LVWvVZq0mv5oRF1
 8Bqg==
X-Gm-Message-State: AOJu0YzSJLwAxt0OTpLsYxO5zyQt/AkWA/4G+wd8YkTCAJqIiyJQNj8G
 vWhd7AZgPpvIr3gEHbLIUlfrz1fiVPfHJA3q6CFZ3YfeJJsMBHEHtRtRHzfDpO+LfvcS+AeYqYb
 Q+vGI
X-Gm-Gg: AeBDieu14pxQpIufNSR0t2Y5n3gKUmkOmffFDOVXiLDFgzCdrztrz+PBfGY7ZqBUkno
 6f8v/F4c1LWCZ+rbpwOnfjGjVEeqidFujs+Z6JGiFG3OCzijglizqbX9dAqDegLoEJOq7vS6oOZ
 bQOWoq6mdf+m7ez/lNeEr47oh2+fQ1BDU9aaImA9aKH532xB4OwdJNzPwDezWo2/hNKZf2NdQ1w
 cO+qJ1rBx+6bgPSj9UoRjfqM/+cyzswse/Pt78ZqeaA1BRgEkVU1uDEqp4knMhlmml1nQfMWl2m
 yb8pGG5pT0r8I0i1iA1bh478hIbBmmkwcq7bydc8sCs/UlVAoaMQY3crObGaz8H0iuTH5fZMhHv
 RNmUhuvWGXfTmcQOwJb/c1P9jnn3+StYQrbajXdcOqH5SnNwJT+8VQqwUSuCLvKJntPSRnml4kI
 EhCJim4OZkZoq5ha4UE06qhPllguuqJJuJ5jm6qI05v8cOT10yzMe5C0XipnNnzhD/62CYBT5Cw
 GOnXYGx8Pwr2o/o1UMatn/p8NW+v44y5QZMpga422KplIw0o6DTYTRDz9re2SYnkmilgcf5avuo
 BiR48IS77JaL14ThtFq8oPVU
X-Received: by 2002:a05:6000:40ca:b0:43d:a58:b076 with SMTP id
 ffacd0b85a97d-43d292e89a7mr9641908f8f.44.1775316416188; 
 Sat, 04 Apr 2026 08:26:56 -0700 (PDT)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-87-9-100-184.retail.telecomitalia.it. [87.9.100.184])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d1e4f1a99sm28059462f8f.32.2026.04.04.08.26.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Apr 2026 08:26:55 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 2/7] test: dm: part: add test for part_get_info_by_uuid
Date: Sat,  4 Apr 2026 17:23:29 +0200
Message-ID: <20260404152640.3297713-3-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260404152640.3297713-1-dario.binacchi@amarulasolutions.com>
References: <20260404152640.3297713-1-dario.binacchi@amarulasolutions.com>
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
---

(no changes since v1)

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

