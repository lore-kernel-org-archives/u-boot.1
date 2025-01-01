Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94BF2E7718B
	for <u-boot@archiver.kernel.org>; Wed,  1 Jan 2025 22:23:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EFF56804CE;
	Wed,  1 Jan 2025 23:22:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="E4ayjzxI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BD16A804CE; Wed,  1 Jan 2025 23:22:39 +0100 (CET)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50B6E8031D
 for <u-boot@lists.denx.de>; Wed,  1 Jan 2025 23:22:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-21661be2c2dso133662755ad.1
 for <u-boot@lists.denx.de>; Wed, 01 Jan 2025 14:22:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1735770154; x=1736374954; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V1lwyVlFVp5Ym+aFH3ulf1HaSDsq93UevGAt0A2UQn8=;
 b=E4ayjzxI+FLR9d0lU45V2QOzi5fXUC1yptFQ23DlFYyeDuzByyNTKUfb9f0xEKStpK
 KZjJvgxSTsDaRHdjKK0HE/sOQ7vPjlvX3U7jFQCvZHkW3o9hQyAdOHJe+baSK0G1DywE
 ZeBia53xnm7QgbV0/PZ2XSMAxQLyRKM21M4ms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735770154; x=1736374954;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V1lwyVlFVp5Ym+aFH3ulf1HaSDsq93UevGAt0A2UQn8=;
 b=YgW87OaKEuPFCi3jbYRSawsGU4rXFewunTKiC+zuqXNcX4IYiSdwD7XxVAni0ZTRX9
 wOA1WN6U5ucrq/WeBn4gdyrsse2dNRHuBFM4fKGyDkBmkg7uVtdqnoEZ1TIp9QX7JHnq
 qIJWOyxnOTUxZTKPs3XxFbbE909NgOrp/Fp4Frj3bjAFS8+z4/Oq9ZzUkixzjzOGkPQ2
 PNYoskWg28bmABWG1QL3O8KObuG1xkKIdU5jG4LT4IifC/MMdnu9jii25+s4JDfGTXky
 ccljQmYMfgp2KoByJCfQ6rMV1/6G20/V52cSB/Z9UJmYap1ngevn2Js40zANjEGqwnE4
 GUhg==
X-Gm-Message-State: AOJu0YxbnosnAN7ziTrm3347XBJyB50ZrZoXK/OP6Ko1ya8XAiTfZEVD
 SA8mPmaWhFjoWQG+/QQsbKiALBhaYMwM8i5pycAS+PV7747q2iDqSPwoV5IpKSqMDbITUBeFsEk
 =
X-Gm-Gg: ASbGncs95Q32wDDBnFRTRujSLxmuHAyUEM758DqUBsC03sahphrT/1kv4oaEUAHWAYO
 UEHm5D8PMohgVFYUlouRdZgmCIe5ntvr9/6mnJX+vpY4+oJzgfZPfvjGgOIDdc9+JqZ3mN+pkzV
 SE2YseySvTGzz6AIKGkkvIINub4ZmfqrUGWP7gfGgpI8Wa+rwKSoHvU/EBxqK8+bZ/tliaUDdz8
 maICj3rl6gahHfkTVZz9TPkKjd/rj/WW8gFft3+P4/Ns9xekV/rgzE=
X-Google-Smtp-Source: AGHT+IEqOfY+5grVueBq8Khf5e3LnfTzrnxomzxFOmsqib8bVTHLojAbchizIntRbjjjjvFUsmjPnw==
X-Received: by 2002:a05:6a20:9d93:b0:1e1:a434:295e with SMTP id
 adf61e73a8af0-1e5e081d69cmr69610609637.43.1735770153991; 
 Wed, 01 Jan 2025 14:22:33 -0800 (PST)
Received: from chromium.org ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72ad3393d5fsm18873947b3a.154.2025.01.01.14.22.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jan 2025 14:22:33 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Christian Marangi <ansuelsmth@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Janne Grunau <j@jannau.net>, Marek Vasut <marex@denx.de>,
 Pavel Herrmann <morpheus.ibis@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 50/67] dm: core: Clarify behaviour of ofnode_name_eq()
Date: Thu,  2 Jan 2025 11:09:36 +1300
Message-ID: <20250101221003.1944600-51-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250101221003.1944600-1-sjg@chromium.org>
References: <20250101221003.1944600-1-sjg@chromium.org>
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

This function is somewhat ambiguous, so expand the comments and add a
test for the undefined behaviour.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 include/dm/ofnode.h | 7 +++----
 test/dm/core.c      | 2 ++
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/include/dm/ofnode.h b/include/dm/ofnode.h
index 024ae4cd289..6d6a6fef8ef 100644
--- a/include/dm/ofnode.h
+++ b/include/dm/ofnode.h
@@ -386,11 +386,10 @@ static inline oftree oftree_from_np(struct device_node *root)
 void oftree_dispose(oftree tree);
 
 /**
- * ofnode_name_eq() - Check if the node name is equivalent to a given name
- *                    ignoring the unit address
+ * ofnode_name_eq() - Check a node name ignoring its unit address
  *
- * @node:	valid node reference that has to be compared
- * @name:	name that has to be compared with the node name
+ * @node:	valid node to compared, which may have a unit address
+ * @name:	name (without unit address) to compare with the node name
  * Return: true if matches, false if it doesn't match
  */
 bool ofnode_name_eq(ofnode node, const char *name);
diff --git a/test/dm/core.c b/test/dm/core.c
index c59ffc6f611..d40916ef588 100644
--- a/test/dm/core.c
+++ b/test/dm/core.c
@@ -186,6 +186,8 @@ static int dm_test_compare_node_name(struct unit_test_state *uts)
 	ut_assert(ofnode_valid(node));
 	ut_assert(ofnode_name_eq(node, "mmio-bus"));
 
+	ut_assert(!ofnode_name_eq(node, "mmio-bus@0"));
+
 	return 0;
 }
 DM_TEST(dm_test_compare_node_name, UTF_SCAN_PDATA);
-- 
2.43.0

