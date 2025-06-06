Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 700D8C5AD49
	for <u-boot@archiver.kernel.org>; Fri,  6 Jun 2025 07:22:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6CE7082AA7;
	Fri,  6 Jun 2025 09:22:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CGjMwcFK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F7E882AA7; Fri,  6 Jun 2025 09:22:11 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AF5FE81FEE
 for <u-boot@lists.denx.de>; Fri,  6 Jun 2025 09:22:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ansuelsmth@gmail.com
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43edecbfb46so13782635e9.0
 for <u-boot@lists.denx.de>; Fri, 06 Jun 2025 00:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749194529; x=1749799329; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vTCmuHHrTdMPGKuvFRjf4pegUh1fQ+eFskZKXMrK41M=;
 b=CGjMwcFKv2LzTJLsC5uDYfvtWjtnVRr46nk+kt/J/k+xUkbLSXIAXYs3/yLbeLuTgb
 x9/1uxN6SI+C9tAgvm1uNTPwhtz555rTZ++ErwdyIycUmaVUzL5cY8+Pzj7d24D3tXqS
 gPgASHsK+++dOVYVGNLuIMrsYV7m3ciSljf8pPSpggrWxKuNVGnN9KB0Ap9skPyN4uje
 2/SuJ8NSa2tygsvL+EE9fJYw7n2vHLGewa0nN5Gj9VSIotKDvTFWFGOP1e9L+LNdBwON
 miKWT9gLOb5pYz5s2u8Syl3LTFA8a72wo9B7moqigMGQ6tuk4Gn8F7b9fzLWMdtun7eJ
 ErqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749194529; x=1749799329;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vTCmuHHrTdMPGKuvFRjf4pegUh1fQ+eFskZKXMrK41M=;
 b=LYYVr3wG6Y3IL26KecpcmXXFOWi7mZETUdboL+3hKKN8C9rl/+KcrAMB8pUXtfhAWH
 jReK2gP1twZH2NJvNEjDE6wXIBxJiuJYWsH4e+qMZTtorearsbuGb2AYXnlPVINzNWXZ
 COPOu9F9uaYQlDkyysw49MoCWnq0vJ1szKONzYvhRga9FUIztxVQhEmQ75FJEesLrt75
 Hs5w/PwJp08CWDhGtNCRBqWevq3AGct9ZF743QttjrQNKTOyL0QsDEVIdu3WvOphV3O6
 hlNTKkCYz+WdEV/7PvyuMp4AGMCK5B/pMwNbf9KeX5AyHddoZNr+m+v+t77+sbLaVLkq
 9mHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8eeDyCFyRgeJ3OD35TBbCUEN2WbVS5EzNKLikJQHItamVdHSodhBWG4Fzo4HANEGhqaaZL6M=@lists.denx.de
X-Gm-Message-State: AOJu0Yx8mToLNPGuS9X7BtyCteH+BTLUdf4xxL9JylaIT/3xDfk2/xIa
 8ZzyUvgd8+lcdH7/loBLlOfvbIM3yLqHZ7j9A83UaXUXEkPK9e/ZHxpV
X-Gm-Gg: ASbGncujEa/mcOkuPMerWBYfb1UmaIDtXFV5q7Z+gBjJVlnbUs0Bcv+xzaHX2sY6Gve
 03vofLeL91na9XHZ59G5Dq7RGxP6pXrZy2xwNot02GqGcUXjJ/G51oQFBeeU/RoOnE+hj9vJQRH
 KeXdMIUJ3Vfq+TZEHsaDARWV2bzDM85xRRYcDhsud9g5dlrIptc2CVJmWS1oYkNA3/s37InchEq
 La97y/6GkdAqZIRDwdlcE/7/DogPydY2o4BjFF8YmKSi2Q4MmhiSVZE0cN/ywlzJqcsE7vfuEdK
 Cy2atR0mfuyX3UfttbYysK8zVM9Gjj4ImpxIGIhRfdioszMWEvO4cnogGZiKklsXkpeta8fEbmg
 YOJiyalH3gnKgnIj19esKbMSVnuDOugaxc+vb/Grm5w==
X-Google-Smtp-Source: AGHT+IFF0jxBZkp6Me/EJO4ZS0tYQ0SRJ2Ueulc7aYWhNkzu+0Y+HX+NzTAj1B3sB2hX+r2W2LY0rA==
X-Received: by 2002:a05:600c:3492:b0:451:efb0:a2ca with SMTP id
 5b1f17b1804b1-4520138dcfdmr24664785e9.12.1749194529035; 
 Fri, 06 Jun 2025 00:22:09 -0700 (PDT)
Received: from localhost.localdomain (93-34-88-225.ip49.fastwebnet.it.
 [93.34.88.225]) by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4521375b5e1sm14666295e9.37.2025.06.06.00.22.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Jun 2025 00:22:08 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Mark Kettenis <kettenis@openbsd.org>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Sumit Garg <sumit.garg@kernel.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>,
 Simon Glass <sjg@chromium.org>, Christian Marangi <ansuelsmth@gmail.com>,
 u-boot@lists.denx.de, u-boot-qcom@groups.io
Subject: [PATCH v3 3/5] iommu: qcom-smmu: add missing linux/bug.h header for
 WARN_ON
Date: Fri,  6 Jun 2025 09:21:32 +0200
Message-ID: <20250606072140.18824-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250606072140.18824-1-ansuelsmth@gmail.com>
References: <20250606072140.18824-1-ansuelsmth@gmail.com>
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

The WARN_ON macro requires inclusion of linux/bug.h header. It did
previously work as bitfield.h included it indirectly but now this has
changed.

Explicitly include the header to fix compilation error.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/iommu/qcom-hyp-smmu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/qcom-hyp-smmu.c b/drivers/iommu/qcom-hyp-smmu.c
index c1b95bc8b8c..2e51ce4f242 100644
--- a/drivers/iommu/qcom-hyp-smmu.c
+++ b/drivers/iommu/qcom-hyp-smmu.c
@@ -11,6 +11,7 @@
 #include <dm.h>
 #include <iommu.h>
 #include <linux/bitfield.h>
+#include <linux/bug.h>
 #include <linux/list.h>
 #include <linux/err.h>
 #include <lmb.h>
-- 
2.48.1

