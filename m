Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A879C55162
	for <u-boot@archiver.kernel.org>; Fri, 31 Jul 2026 02:11:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9100040E84;
	Fri, 31 Jul 2026 02:11:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VthSDphJVgc5; Fri, 31 Jul 2026 02:11:49 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5DFD540D59
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785463909;
	bh=6rWdY4P62+U/sKZoT6bjB2fsP2NgzEbld+ZvJEUdJE4=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=l1ED6jfvAILkRGrAq5oCM/L9sJIQEHTDgYsPz5fGj9ONVKKQa1Gz18p5fgitlbo8w
	 cs/jF8wOXzMOsyfwvtc+KSCOgXkrWahDD7HwXWF0OZOCnEtMRjg5jNzLdSVP6GLsUU
	 +/9NENCTz5ShIVpH0P9ItyN4AZHT3jpqPDSdy0ZONH8MXEV+pJVXUDU4hid4FxWOAu
	 jJbaWUD1LicYewAEGG3aPAeiDslaaEtiOAeU+4mElj9ZMwok+KZf9nz615sXhj12aa
	 0hk8dPMfTf4RD4u6S5c8pgHTQJ4IgFS+SvI0mSMFUKU23s1dqXrLC4+uSEsDVhKgLg
	 Oo6fFbhYdFJyw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5DFD540D59;
	Fri, 31 Jul 2026 02:11:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id DDC3869
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 01:36:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CF6B440E42
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 01:36:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id dbuBAOEt4oDf for <u-boot@lists.u-boot-project.org>;
 Fri, 31 Jul 2026 01:36:55 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::102e; helo=mail-pj1-x102e.google.com;
 envelope-from=bhimesh.matsa@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 1E6B240E41
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1E6B240E41
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1E6B240E41
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 01:36:54 +0000 (UTC)
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-3811f512167so460980a91.3
 for <u-boot@lists.u-boot-project.org>; Thu, 30 Jul 2026 18:36:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785461814; x=1786066614;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6rWdY4P62+U/sKZoT6bjB2fsP2NgzEbld+ZvJEUdJE4=;
 b=hMHVsTk/e9cko6NrUjUjxM/w6r6Sc6S/QyAkoe784ajkZ+ArxH+7VJLHOpAkOxFCnW
 4r/aXL74sRcq1/pPLypvgymokwdGFbWkJ5UAxfTusrIO+HZSll8/oa4ioo+PcnCFLla5
 isfCk0xk7LdJOS6sLV0d08Je1u4rvM9fO2z3Sphn/HIo/ba9/GZRVdx6aQTJUKY1TCVg
 L7S1s3nLVE9M4XrcjRzJ14M1OyS58iYL2jUX3so5jY5voE5C1okhAVudAsbeXNRQl70b
 Br+Nwi/1APSgRv0P+vLQZSY2uqn8mtz/dpbd03mLYL489/QVL7+/amHh4B1PqXrITpw7
 OpjA==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro7rkR73UDaEA4fJpjtxvJbpczdlXx4VAojX+jjwHBeQvHwx4AyYDvrBYpS88zbhwII8IhpLJ8=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YxDbn73FeScHI+NWBRKchlQmmhK4Ut9rPwzbIGZdjRmNPS32Ka2
 416PgQZeHtPGSmR2h1fHXe+oqspR+SoiQLL/5Jd1ltrTNm4FgsEIU9ES
X-Gm-Gg: AR+sD101ouvcs7VH57uRdsyqySBVdvwteoEN/rIK3NwUMIDcjVmN4NyHFb/nacCmWPd
 DYNPdEr8QtZgiUiYku0AGJ0o/3gUf431A47NRzjk+gRCI43xYj8EBBR9TJp6+MR2It4zNNso3Tr
 SkevHJ8gZIfEwH4rT8T5BwLNlqJwPiyvM9zZLeQeYkHNVjMeqj/+TVOeXkB2b++fW9IBnoHSEIX
 2mVUoLshCMb/MpWnoB9fsZTVAwxWw6gZ0wbmNxts/21gqU9O8RBRNQqDBK9k1duCYBv7FgivMpr
 +vLMFDFkje2iFn3NR1Pw8G1ddOAwKBh48XbAKpLVumLKVJ//2Wl1REp6wXPN4ojNn6NHZqTa/ZF
 1LCK7jnuq7wakludS2u9OPLuvaixLQNJLxHWeuAyAfEuZqf6L2HiMaQlW6bjLvJsupW0L2JWrkj
 K14fukGgfaQY8NJKlHCerZLyfIuk4pSNQ/beqZWSvimEzA53/TAm7f89Syqj2SNAzFWQ6cUQ==
X-Received: by 2002:a17:90a:ec8b:b0:37f:c97a:939f with SMTP id
 98e67ed59e1d1-38fb10f0d30mr187789a91.7.1785461814290; 
 Thu, 30 Jul 2026 18:36:54 -0700 (PDT)
Received: from kumara-Inspiron-15-3530..
 ([2406:7400:63:b1e4:34aa:6ba5:be21:9790])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13fa758e799sm23853c88.14.2026.07.30.18.36.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 18:36:53 -0700 (PDT)
From: Kumara Bhimeswararao Matsa <bhimesh.matsa@gmail.com>
To: Jaehoon Chung <jh80.chung@samsung.com>,
	Peng Fan <peng.fan@nxp.com>
Cc: Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org,
 Kumara Bhimeswararao Matsa <bhimesh.matsa@gmail.com>
Subject: [PATCH] power: regulator: tps65219: Fix LDO3 and LDO4 selector
 boundaries
Date: Fri, 31 Jul 2026 07:06:43 +0530
Message-ID: <20260731013643.28244-1-bhimesh.matsa@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 31 Jul 2026 02:11:47 +0000
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785461814; x=1786066614;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=6rWdY4P62+U/sKZoT6bjB2fsP2NgzEbld+ZvJEUdJE4=;
 b=G7lii5Flpc7LLGKLt47WzpryiHnuUEAlqIBIwv+xfxzLIG6o1shOpkho9B0eCccmQO
 tHefwVPFiW0EuMgw5Y6UuxptVz76Lw3Auy2UjRzFL3qXAqQ3d3xHRM5NqMVmSZ7AWdhX
 Hq9H6zywhruQTLA+mjpnTugaPCWz0xVAHDaoqnQ/V7c/tKewPfU4b1yjmN+hfwo55UH5
 gaWW1JlLZHLgnKhPRlzZut6tez9wqHGI0x33QI6MkySZnsQA6f0k30uzvQfbP0ilQSt0
 x/XobrM8q2fgr2YQZNugayFhMJKQHReWCN+rya37wUBrL9lPomBdvkv+0uXhXvh3HkVZ
 AQtA==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=G7lii5Fl
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

According to the TPS65219 datasheet, selectors 0x00 through 0x0c map
to 1.2 V, while selectors 0x36 through 0x3f map to 3.3 V.

The driver currently uses 0x12 and 0x54 as the selector boundaries
for LDO3 and LDO4. These values do not match the selector ranges
defined by the datasheet.

Use the correct selector boundary values of 0x0c and 0x36.

Fixes: Fixes: b5cfa0c7ca4f ("power: add driver for the TPS65219 PMIC")
Signed-off-by: Kumara Bhimeswararao Matsa <bhimesh.matsa@gmail.com>
---
 include/power/tps65219.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/power/tps65219.h b/include/power/tps65219.h
index e8780af2d81..4feea081f61 100644
--- a/include/power/tps65219.h
+++ b/include/power/tps65219.h
@@ -50,7 +50,7 @@
 #define TPS65219_LDO12_VOLT_REG_MAX	0x56
 #define TPS65219_LDO34_VOLT_MIN		1200000
 #define TPS65219_LDO34_VOLT_MAX		3300000
-#define TPS65219_LDO34_VOLT_REG_MIN	0x12
-#define TPS65219_LDO34_VOLT_REG_MAX	0x54
+#define TPS65219_LDO34_VOLT_REG_MIN	0x0c
+#define TPS65219_LDO34_VOLT_REG_MAX	0x36
 
 #endif /* TPS65219_H */

base-commit: 100e12ea78c73071b9710f08b32fd4590019266f
-- 
2.43.0

