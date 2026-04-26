Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD584FF885E
	for <u-boot@archiver.kernel.org>; Sun, 26 Apr 2026 15:41:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D7EF3842E7;
	Sun, 26 Apr 2026 17:41:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="RYvJDYcN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CBBFC84119; Sun, 26 Apr 2026 17:41:04 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C46AB80087
 for <u-boot@lists.denx.de>; Sun, 26 Apr 2026 17:41:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=amarulasolutions.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=dario.binacchi@amarulasolutions.com
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-488ba840146so84608665e9.1
 for <u-boot@lists.denx.de>; Sun, 26 Apr 2026 08:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1777218062; x=1777822862;
 darn=lists.denx.de; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j7kw4CvLJkX2EjGaympe8ZZB0RtPYp/BO11dE+j3/IY=;
 b=RYvJDYcNNRpO66meIecck5m+3DHc+k+N1vSln3h8adhm7gunF4b3l1gU8xHJHJRgst
 fSb18gfgHsSKmOZAZlh+rVvXO22LaM3eneoiu9K7U477CH0ASPjS83C6msXnjBguQqMf
 dRYAGmpgV0q4Fc4tWbo9w6juzapcZgPGIp42w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777218062; x=1777822862;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=j7kw4CvLJkX2EjGaympe8ZZB0RtPYp/BO11dE+j3/IY=;
 b=AS24X5NFXn0NVRiJFYi4jy0Ietx4EnFKyr6QXSSUcukZqc4fKCQHbl296CJ/8hu7nC
 uqWmPSnG2RRQMUo8nnmAxsB4XeOkwpwtL3fLzC1sOF3LcgmVPs1XyYHPInqFZp3ve8S6
 XBQnFT+mpO/NC7ZaCNWcUt1In/2Vgnak/RkkEvHWjDoy8RX+3ugrvYLkJwUgnYWjcR9m
 0cBfaz7mNEODjo8BIeyWhjM2e4N5IpVCVGWkVeSNYiYuRIQuX0b5RRsNaUCY4ZvViMy6
 5QPpTUd3yU5SwazBHsEIn3WhCZ3+LZRJ6qx8aB6CFMQYv2f6lFNqXMJCfqo0LBUV30cx
 g55g==
X-Gm-Message-State: AOJu0YzB9vHV0LdOyXb00ldW5rP0hENZO3D99Apo6H+AKZcgH9T7axyW
 R+fPwI2dWWBpTCFGe7aBb8ws3UeQ2MdphzSr0Ehi4wkdVNIyYIzHw0MPJJvC9P+YxQ2toAq6MGI
 uayrr
X-Gm-Gg: AeBDietG1jO1tsPFoAxdCaRgQUa4GNTf1yzv+aPIN79HVFKbRKrMPcOEybaBrZZbVbf
 GgI7KYHNpbX6Ms0raaemYHxPFAKEdi3gSPXGEh/bPM6raNRax0qxoVvqsjN/kMEiEGUjjDLmQHv
 IbpGcLPgdZ37mDiaFI7FBlNTAnaB6j2Jl27vP15Ast4wI1r7As3pYhBNOJ3O+SLTllRUxENCcza
 TSu75jBd056Uu5+IYLtFBwZzPBccz2j6EEbn5AJp3wmdejZSkCpoBwc8iqRew++eiNJ2dLGWgxx
 QYBtU55DLyg7RhpOYc/R/YP1OPXodRpl748hFbZa27/WqrurJFVGxr1XTT8k2K2RRNPQ1bFyVc1
 6TOl40ZG6XohAms5HFy289VbT6vdw0siryS/N4FHiz90OphhsAj2QYvEFZB0Xc4O2RczcKv6MYW
 kzjuK3lC0lw531f2fo9+VD6Nzp69lfCB6GMgw5kzouc1U/zwaBjsDCAth2wAdnnfn6VYWOY0vtN
 Ji24VxhBJVo3lwK+MCVSbQXfmU0xTQNXjUfSSjrpKtcNXRUTPgN8oSF3LJvk7udUk0vduHKEXbN
 gKWE9c7E2hsM3/TkkhLJcXMvilhzoQ==
X-Received: by 2002:a05:600c:6289:b0:488:f941:aab2 with SMTP id
 5b1f17b1804b1-488fb78a561mr549098865e9.30.1777218061944; 
 Sun, 26 Apr 2026 08:41:01 -0700 (PDT)
Received: from dario-ThinkPad-P14s-Gen-5.amarulasolutions.com
 (host-82-56-22-134.retail.telecomitalia.it. [82.56.22.134])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4891bb3d121sm802593765e9.14.2026.04.26.08.41.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Apr 2026 08:41:01 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: u-boot@lists.denx.de
Cc: linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Simon Glass <sjg@chromium.org>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v6 2/8] test: dm: part: add test for part_get_info_by_uuid
Date: Sun, 26 Apr 2026 17:40:34 +0200
Message-ID: <20260426154054.2040932-3-dario.binacchi@amarulasolutions.com>
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

