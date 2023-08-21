Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2142DEE4993
	for <u-boot@archiver.kernel.org>; Mon, 21 Aug 2023 18:02:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D6D587051;
	Mon, 21 Aug 2023 20:02:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MWTHTKaX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35F728704B; Mon, 21 Aug 2023 20:02:54 +0200 (CEST)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40C2186813
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 20:02:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-790b95beeedso139249039f.0
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 11:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692640970; x=1693245770;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=a2pjLxbest+0WZUqtLo2mpBJexTPwyLe+Gjd2ukfO+w=;
 b=MWTHTKaXf3We07hnu1arByooKWK9nv0QXa6pTCn5rGYEBh10Z7Rb9HJzrTQiLM6QsE
 z7r72Yct7mWZ3xtAuYbhUIKIPF5VzIM+yhtBNKcu0LCsVVw1rlYRbWUUuz3CnNBM8d9c
 UE5LRru4PhGCALgiImFZseT5HaxDT5x9B4IGc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692640970; x=1693245770;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=a2pjLxbest+0WZUqtLo2mpBJexTPwyLe+Gjd2ukfO+w=;
 b=PNYKJpsLy2aVv3yb2Cnzwl7p6ule/2ZbHJmmYfYHDQq2vFKjjusymhRvpDvn3uqyB6
 LI8pcLRBdAkS+QNa8dVc6npF2f7yEQHlSXbBeVnJUcKxBVbWhWY7Bq+jhh0RfnDRrPs6
 2LLr5HLmgT2SSpMMpg6VM1FizsMVrYKg50ZXpT2kW+ICWTQS/5odWlQ9HETXsk6Hmb02
 F6Kiyt8guyVwnwq0hW2mzKWktx/fnvH9zodxm9gf7wsWwja+ey2pOW0o3X/yBoCdbvq9
 ZMh6ozeFQGda6gIKIDk9hegHlb8iUG3gauv4Ai2jHj04FpjE6W4wbXG5sU9E7AAtyL2I
 KMYg==
X-Gm-Message-State: AOJu0YxyreiKFjOXFqevr4Rb4k/nIYZggp8ykZ3RViho/Vkcnk55/PMV
 vWsMDoBPr9DDVY4V788dReUnYA==
X-Google-Smtp-Source: AGHT+IFfd4gx3DaCbgFL3dChUreiPZL/eKJzxHsBjdj44KSS/0fqF69Jg0p+EB/vCqKXAM0Wb6vSLw==
X-Received: by 2002:a6b:610a:0:b0:783:6eef:1496 with SMTP id
 v10-20020a6b610a000000b007836eef1496mr10989656iob.19.1692640969742; 
 Mon, 21 Aug 2023 11:02:49 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:9102:8976:7620:5093])
 by smtp.gmail.com with ESMTPSA id
 g5-20020a5ec745000000b007791e286fdbsm2583924iop.21.2023.08.21.11.02.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Aug 2023 11:02:49 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: devicetree@vger.kernel.org
Cc: Tom Rini <trini@konsulko.com>, U-Boot Mailing List <u-boot@lists.denx.de>,
 Rob Herring <robh@kernel.org>, Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Peng Fan <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 1/3] Add validation instructions
Date: Mon, 21 Aug 2023 12:01:15 -0600
Message-ID: <20230821180220.2724080-1-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
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

Add simple instructions for people wanting to validate their schema.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 README.md | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/README.md b/README.md
index 9d2f6e8..d8767fa 100644
--- a/README.md
+++ b/README.md
@@ -118,6 +118,25 @@ Example:
 dt-check-compatible -s processed-schema.json vendor,a-compatible
 ```
 
+## Testing your changes
+
+Once you add or change schema, you should test it locally. This assumes that
+your system is set up so that 'python' runs Python 3.
+
+First make sure you don't have any existing dt-schema in your system as this
+may interfere:
+
+```
+sudo apt-get remove dt-schema
+pip remove dt-schema
+```
+
+Then, to validate, use:
+
+```
+PYTHONPATH=. test/test-dt-validate.py
+```
+
 ## Installing
 The project and its dependencies can be installed with pip:
 
-- 
2.42.0.rc1.204.g551eb34607-goog

