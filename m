Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D609CD13D3
	for <u-boot@archiver.kernel.org>; Thu, 30 Apr 2026 08:06:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EAE5D8465C;
	Thu, 30 Apr 2026 10:06:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Cqklb7U/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 40D988465A; Thu, 30 Apr 2026 10:06:42 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5905384612
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 10:06:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-43d64313c39so459234f8f.3
 for <u-boot@lists.denx.de>; Thu, 30 Apr 2026 01:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1777536399; x=1778141199;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j7kw4CvLJkX2EjGaympe8ZZB0RtPYp/BO11dE+j3/IY=;
 b=Cqklb7U/1JO0Td4lBxVNZEOFKQQFdhv02UM8TdxgtaqN2Q99BKMGrWiGhC6JarjGfF
 tw9kI4CQJDXJxP4cSqfsbbPagfU2E+F4yqfLTWHrsjiHkpB/b1tTxAuAbBhDRYlXVz+K
 YiA5f2u3XX+517kyySvNRAU5HtSwRkTxwze1c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777536399; x=1778141199;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=j7kw4CvLJkX2EjGaympe8ZZB0RtPYp/BO11dE+j3/IY=;
 b=QL3yCX/tnAMlL2dvZnkJe575Qt66CYbFGLShxFi0S8eITOobrVWVBZ4wXaEoD0bq41
 yfiAXKVuf32walKtwpjFFhfVax8/dTYCzOySEGiV/A3ren4bZfcY5PVWzp8/PZhtHosk
 uu6O4D+zwPelcf0kYIyp20giK0YYk1SUrk9dZVprbqYe3aa98LucaZPqsPsqW6Zc5aXQ
 xy3C9Q6OCLri7fuF6Ojwqul5kGR5rW5FXUa5o8dGLNCzqYJiNbg5jI0jjc/W2uYw0Jtg
 t8wtIV4pKheKp4pQR5wqyN0Ug0ZsXzGy+Avo9JZPeGgf0IrwfwAQ0kiXeIcVIUlHDfOS
 c3Zg==
X-Gm-Message-State: AOJu0YyY6nOU8K6yByx5CbYHXzCmrco2BDauWvpJ+J667115uBCH259v
 /HB2cbwuKp7BCdrWqsuBTgxe2adwE4YTc/N7GW+4VIuGqVbO7MXBHDBOsOL+WVQn9XDlxXlvq3U
 yqdyi
X-Gm-Gg: AeBDieuDm//7FtF4Eue7USphB9qnxh4TZQ5RZovs5PysLUc1faZbKYGkaBbXcugV/44
 ANvRMj789P+R/qm1XHIGE3i9onaRfZL+iNUvLoYErqyFpfdqwF0ADkk6sEIzHipo8Il4ZLfTgzT
 WODtb4MAswUVORWX9AzubQU03cl4Xpk164oD4kSVYUK3M1l1mm5+XR/YErnxP6DmW1tuPFYKk7a
 iSMXFmtXLGFzV2k3Kzpq3POFS6ZuNnh7J0LqGo52PGkp4zSfIuwpLoN+hO2+xulHSf4M9ZgIMzt
 ItxBkyBkJcgoJ2hbgTs7jTExnizGxZ8BS4LAE7smbY+9SNjSgR6iLz4do+4XvIZ6EiwvLpqaq63
 DOyAJDf3oqcdslbfUYlA8Q9TLQYvXg9XkU3OOdgYywi+LduVoQG+wNhmhwiLM/hilEi1fgDNWm0
 fBnYBFX5rG1mRMcAR920f5RQNjfTrJxJu0MzW3iFAKHgXhszthYNUaOSwmvF4o48+SSbM/Uh2RS
 BdgyE7uiKszL//4PVbtQBNoxCSAVh0OsFosYmqfkYE9MiTu2yDx+XZuG5PeQjPaTlCTWG94g8wR
 cOR8Xn038LRBC5h5/EgDw8UvWnDeIEsBYczRKXg3m1wiNQ==
X-Received: by 2002:a05:6000:2381:b0:43d:1dfe:350a with SMTP id
 ffacd0b85a97d-4493e982942mr2857364f8f.22.1777536399424; 
 Thu, 30 Apr 2026 01:06:39 -0700 (PDT)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-82-56-22-134.retail.telecomitalia.it. [82.56.22.134])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-449c576d0a2sm668071f8f.31.2026.04.30.01.06.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 01:06:38 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Simon Glass <sjg@chromium.org>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v8 2/8] test: dm: part: add test for part_get_info_by_uuid
Date: Thu, 30 Apr 2026 10:06:03 +0200
Message-ID: <20260430080627.849636-3-dario.binacchi@amarulasolutions.com>
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

