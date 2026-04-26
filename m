Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8493AFF885D
	for <u-boot@archiver.kernel.org>; Sun, 26 Apr 2026 15:36:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8AC484120;
	Sun, 26 Apr 2026 17:36:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="frObQ8d9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C19A784105; Sun, 26 Apr 2026 17:36:26 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D985D80087
 for <u-boot@lists.denx.de>; Sun, 26 Apr 2026 17:36:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-488b150559bso74772375e9.1
 for <u-boot@lists.denx.de>; Sun, 26 Apr 2026 08:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1777217784; x=1777822584;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j7kw4CvLJkX2EjGaympe8ZZB0RtPYp/BO11dE+j3/IY=;
 b=frObQ8d9j4TK96wC8OX2sX7objpRCh9lzZ9RA4IaeUauKhusg4zaEgTlXX+h0umhiT
 P4lMflaT+4oPr5Rlm0QgC9iyMaQuV+naJOMWCREADIMajIGIo1jFXpWricX3l08BUPIO
 ohO6J/0FLkbCs4oYDydTvnwTOWpm+tiFQ9H8s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777217784; x=1777822584;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=j7kw4CvLJkX2EjGaympe8ZZB0RtPYp/BO11dE+j3/IY=;
 b=UAR/5dditq7dGyhUhWhLxtqBlOcXRXVjS0xaelwlffwmCRLxNqRtZUcex0CpqFf1Oa
 LZRg4ttSKCwEymCfAd8Fefv1InEwrGNAB2neXoUyzn568cKKmk3NJ7SxsfgMypbYqG5u
 Vuf3YVnPKX+SR4Hog8XQTEEh5NSgfGDkYm+XnSQblYgSSdG6Hs4NUWwwopv94KaaG5Q5
 S8PgR5fdx1tuILe5/Nvc8eynlX2LmxXBtd1lsAjFcVGy81DbJhsLqelBRW4z4rvsS0/9
 KuJdK3MzjUSYsPZLjLIzu/79TXKy2K4NKek75EwN8v4Ryc4JlzkPJr0FFv1lPHl+Feyv
 JZfg==
X-Gm-Message-State: AOJu0YyfAQ4CYmW2RXJejuhKOTTipyLLJ+Ogy2RQxNzkkGcl8uqScb+G
 RVea++s5uPKQexi5R5QUTZU17au8LmMzxK/7hLqMMP/h/hqUrqvnunUuTh1WtSWF5+rgLhKTDhr
 7rjcG
X-Gm-Gg: AeBDietzobvDZPmuxUluZPzK7ke+OtBXQpy0xP2AazbGs51RbNnW1hgb2BpQxFaNQR3
 X5Ed1q1bQ01DmsSGjShfwn5MqcHEUaWS0pkPz80RwyM4zaGMfrzHKNr51oDNg2BiCT7ZGBSPjks
 RhSs5k5+2+MFP4hfLPIDp3qxB9C6f7acKmFiQZAZhn63Tf5cMZuKVB1LzhJsxSva6V3hBrKVq9V
 cgcqnfzmFXoLUv+anQ+xW2Szpt3w4VpBg97RjrLLxsfA3z7sVG35JasaB8fcxb5Q2DtdGpcEkVB
 TO2qjKY+V++oDUGdtlKuwh4fangOW6sqSw6AXYfNAC6kA0SWB0TH+jYirmq4RMIhSNAe/q9z+ZW
 eIEUQuJcuFjt9PEcHXQGBL6Kpzn+oFaTwr2S9zbHDucpsOW5a8nObWfytvUj+X2zqzRpC8oUR+S
 qVq3CpYu0gwWcDIIu11m78I0xzvo+QzGUCYCguP5AO3LKow/wS5MJ9gf/cfCZsqYbnZuCWO9dDj
 1jjIc5/dWh95S4SZ0rUDgXO2/SwXZ0rfoJnGmfcfEMPzBOy77q5aSkUDN3thTjZORmtZoVBGOmp
 GJX/RwzWCwRRzx64Uj3EPMJjPdpSkQ==
X-Received: by 2002:a05:600c:a305:b0:48a:53cb:85f4 with SMTP id
 5b1f17b1804b1-48a53cb8734mr287837415e9.24.1777217783633; 
 Sun, 26 Apr 2026 08:36:23 -0700 (PDT)
Received: from dario-ThinkPad-P14s-Gen-5.amarulasolutions.com
 (host-82-56-22-134.retail.telecomitalia.it. [82.56.22.134])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a5499b0edsm388438845e9.14.2026.04.26.08.36.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Apr 2026 08:36:23 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Simon Glass <sjg@chromium.org>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v5 2/8] test: dm: part: add test for part_get_info_by_uuid
Date: Sun, 26 Apr 2026 17:35:27 +0200
Message-ID: <20260426153617.2039651-3-dario.binacchi@amarulasolutions.com>
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

