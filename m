Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EE7DFF885E
	for <u-boot@archiver.kernel.org>; Sun, 26 Apr 2026 15:47:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C3B184262;
	Sun, 26 Apr 2026 17:47:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Ryhytnbq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 788D2839D9; Sun, 26 Apr 2026 17:47:34 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A98E839D9
 for <u-boot@lists.denx.de>; Sun, 26 Apr 2026 17:47:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-43d73352cf2so7840587f8f.1
 for <u-boot@lists.denx.de>; Sun, 26 Apr 2026 08:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1777218452; x=1777823252;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j7kw4CvLJkX2EjGaympe8ZZB0RtPYp/BO11dE+j3/IY=;
 b=RyhytnbquusJL0iJWeY/vZiah8QeI0MSZFwa2/RBXTFmKbxMcI6bQd/WsdZB+QQTlu
 YH1rjTY2vzSnficLfCAwkkQmz2XFF115rA0GUJ+okpzUXp0cClDMs6d4KueZgh7bEfLm
 /tl43A7+0p3/oooZ8GLGoLvq4G6bF6zsMkD1E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777218452; x=1777823252;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=j7kw4CvLJkX2EjGaympe8ZZB0RtPYp/BO11dE+j3/IY=;
 b=BswyfKyvegCitoLn9FBXfxutVK7ymSMub/df97NlLCC31+HIW23VEMAUBsYi7XmpZY
 TGPLimXvDqCfvmiJ0aP2Z4RrjCV6up/BlvGCPKiPFzZVy813zpn7BZyuOqpZIRXx0md9
 wOGbeaN1L7OUJS25bFiTencytphDCWSkAGxy7Q4+1ga6M40qYKmN/b82DZpd09lCc7d6
 3QPy9EZBw2qqePURlzeIaFHs+WHh+P0k1OcHxm3NacAAxpRMr/YP9zPpV1aS8lenkGKB
 jcJjF3hEPsGBSzb1PyujhFZqvnXbyCl1RQM5vXLBfLu06qPJ7l96pWXoLU76cgfF/swm
 clkA==
X-Gm-Message-State: AOJu0YyG43vIAc9YOYpJU/NCWCqTqUeJmVjeWQYTtPpn7Rt7c8bHAEPg
 /uF9mwCqGXqqCNvQwPuoj2ecQ2yuk8AZpoMJ/u7Ev91WjpxE2QbhTBAI1x+pCya1inoML9BSWSC
 QB5Ca
X-Gm-Gg: AeBDiev34z/RFUqkziJthEWoWUHy5OZz7f9K70FOV0a58OYPSXCXXHtbWEgJz6Ls+IG
 gemwvrQWCAw87zUjOgsn407+Q3xKVMmJImG1cIoVcN62z7y2jtUQT5UiFzPjc9k7bVqCUf0frmX
 NK0jh16Vwyij/6838kU5l6HYc/HExzDXmICGeWsVUaZMEcBklnYfAxq05vbNu/kFg1YAX8YorLU
 kPk+/GebYyeq7k/vntLuKGFKoYj/W7A3kI4RGKhOGuwauiJFCGEXHRsubdFaf0HobsFhBRuzApH
 ypZg7nWAYvTVHc7+HjYsyEV/s5IXC+q7LoycRhS7sWFBKFyPMQ6GbpPdLcCTbxzBa0bVR+Sa+Es
 LQmh3G5pzWznqPGitdwIIyG98DuV9cThm/cPxuuIAjPY27uXumt7fdqxMZAvWRjtQLojbtHaD6V
 Mu7TIrCuyk/XmDwFLu8PoE+MLB5qEACEkE1bS3yJtcwWroO7i5TZFBvT8/n78t/7YrqfYQRCKno
 /R7YFOjZSt27WGJARcKnm2qvUYsW8l1WhTF5tz6rjCVSOCZa27lAsX7vraPhgrVaDD4pioksvxc
 VKZt6Qp6xqeetNIZFd11sxxQAJBtkA==
X-Received: by 2002:a05:6000:2508:b0:43d:7e6f:3816 with SMTP id
 ffacd0b85a97d-43fe3e14ecbmr59468933f8f.40.1777218451696; 
 Sun, 26 Apr 2026 08:47:31 -0700 (PDT)
Received: from dario-ThinkPad-P14s-Gen-5.amarulasolutions.com
 (host-82-56-22-134.retail.telecomitalia.it. [82.56.22.134])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-44123d23e0bsm34489985f8f.15.2026.04.26.08.47.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Apr 2026 08:47:31 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Simon Glass <sjg@chromium.org>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v7 2/8] test: dm: part: add test for part_get_info_by_uuid
Date: Sun, 26 Apr 2026 17:46:55 +0200
Message-ID: <20260426154724.2042569-3-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260426154724.2042569-1-dario.binacchi@amarulasolutions.com>
References: <20260426154724.2042569-1-dario.binacchi@amarulasolutions.com>
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

