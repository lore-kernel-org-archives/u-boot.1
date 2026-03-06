Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C500DF513ED
	for <u-boot@archiver.kernel.org>; Fri,  6 Mar 2026 02:38:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8954983FC5;
	Fri,  6 Mar 2026 03:37:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="WPQobswT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5202683F8A; Fri,  6 Mar 2026 03:37:17 +0100 (CET)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 04F2483F8A
 for <u-boot@lists.denx.de>; Fri,  6 Mar 2026 03:37:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-899fa9610bbso81889466d6.0
 for <u-boot@lists.denx.de>; Thu, 05 Mar 2026 18:37:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1772764633; x=1773369433; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zR5UG7UPbCcW3ZgvRgF1R5CwOX75cfq5yjDs6yPrLV0=;
 b=WPQobswTIBkxPzuHluQLCaN+Q/JSftZ6LY+TT6COyOQ1oEiuUEQdTmBsnbt5kcxOjb
 1e3rnLTX3OhOs0Or4aw0LUijq/LrKHAQGtirZPZI1XMFtB1JHKym1ib6R1tWhG/jqNTI
 MoY5fgVW1joCTNs1SaAuNW9CB+5w7RJwIeGOk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772764633; x=1773369433;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zR5UG7UPbCcW3ZgvRgF1R5CwOX75cfq5yjDs6yPrLV0=;
 b=IRKnRLLNF1i8nm/ayk3YHsWPTs0SQdomlfKQMRCetQqtBZ6PoErFNsqCzLECvbfU0T
 Suf5wJCUbmOqIVBqvhV5JopUFrTbtt5ag0QgjFrKD7yA2Uu5Fj3NGuzgshv63nsTOCoJ
 CRiVloGzZ8eb8qJxhmci/sPl5g/QgyTeHpIswC90z/NrivjePmjEXMayAofDYdj45I7M
 0mkCYTlEH5dyTnaH51rvvccHPOvyct4/L/S+WIxfuM89tS7paeEyo1AqBG43cD0A0Z94
 yDU1ANF8UUvSixKH+VvCUhDD9Ssh1cx9CmBN9jTJlciBYJm9Xbt1EWvIrMdI84/JvccL
 ZIwA==
X-Gm-Message-State: AOJu0YwASjrQ5fhtAgogWbKhFbWxm5rh1+jUs553yfS4H4pt9FNAINQW
 Cmq8y15F0GCWMBj9Z4s2A8lEaU/LYoeUgwg7FRxS82iRVjGAqFXUtWhyFeo+IhmtsykDW7wow0X
 5nN8=
X-Gm-Gg: ATEYQzwDcDUSye/gQOldB9dG0Y2bZBDzH6GiuoyQyZ4DyzrgARycva87ub6jK6pzbBj
 ds/AIr55vW12kUG1N+Iqxl62oOyaaZS6LmQdtSi3T7pLbE4KE9fMjiNGA9i1U47OEzx0WpaGyTQ
 DBPSrethfgp63cZ0d4pu7mS7EF38gAQ1KcNW4jEoKE79tn1gxltbk6vw1rmyH4u/z62yeSDYFxP
 MMDlrfwwerQMJu02VxZqhmS8C/NiAD2e9iNCkcOwRH33MmUawYPV3cj9ykdYY14tQcpE3er17He
 gnAtAIj/sZ3Jc0NnsREWEuYZKeyDUwjjeiQinQ+AC+FGOkvbBOAyaz/OHVRvsoAUXJvz0Pix1F0
 dR5kBP7ggfcnHgMIx53PG64s85MC8B9P89jE+bHMiLSbiFiXpEB2nug0aYkllthKumBjnPrpBgY
 5FJm1Mz5xfxcfSjmdpmQ==
X-Received: by 2002:a05:6214:f2a:b0:89a:984:6f3c with SMTP id
 6a1803df08f44-89a30a3cdfamr6582066d6.24.1772764633274; 
 Thu, 05 Mar 2026 18:37:13 -0800 (PST)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89a316e8eb2sm1063436d6.35.2026.03.05.18.37.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2026 18:37:12 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <simon.glass@canonical.com>,
 Benjamin ROBIN <dev@benjarobin.fr>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 =?UTF-8?q?=E7=89=9B=20=E5=BF=97=E5=AE=8F?= <Zone.Niuzh@hotmail.com>
Subject: [PATCH v4 07/17] bootm: Stash bootstage data in bootm_final()
Date: Thu,  5 Mar 2026 19:36:16 -0700
Message-ID: <20260306023638.2678886-8-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306023638.2678886-1-sjg@chromium.org>
References: <20260306023638.2678886-1-sjg@chromium.org>
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

From: Simon Glass <simon.glass@canonical.com>

ARM stashes bootstage data to a known memory location before booting,
so the kernel can pick it up. Add this to bootm_final() so all
architectures benefit from it.

The bootstage_stash_default() function is a no-op when bootstage or
stashing is disabled.

Signed-off-by: Simon Glass <simon.glass@canonical.com>
Reviewed-by: Tom Rini <trini@konsulko.com>

---

(no changes since v3)

Changes in v3:
- Add new patch for bootstage stashing, needed for ARM conversion

 boot/bootm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/boot/bootm.c b/boot/bootm.c
index e553497192c..c42f3b925bc 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -1205,6 +1205,7 @@ void bootm_final(int flag)
 
 	if (IS_ENABLED(CONFIG_BOOTSTAGE_FDT) && IS_ENABLED(CONFIG_CMD_FDT))
 		bootstage_fdt_add_report();
+	bootstage_stash_default();
 	if (IS_ENABLED(CONFIG_BOOTSTAGE_REPORT))
 		bootstage_report();
 
-- 
2.43.0

