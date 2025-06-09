Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FC45C61CE8
	for <u-boot@archiver.kernel.org>; Mon,  9 Jun 2025 16:10:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F087482998;
	Mon,  9 Jun 2025 18:10:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Ch/sIEor";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD54682B00; Mon,  9 Jun 2025 18:10:16 +0200 (CEST)
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com
 [IPv6:2607:f8b0:4864:20::c34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C0DC826AA
 for <u-boot@lists.denx.de>; Mon,  9 Jun 2025 18:10:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-6060a70ba80so2434220eaf.2
 for <u-boot@lists.denx.de>; Mon, 09 Jun 2025 09:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1749485413; x=1750090213; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=Cssr8twv2thAnVgYUmdX7j+fU0KKEL8FgHtsQqWplQo=;
 b=Ch/sIEorbUZqlbcYXWQztUnQR3C3BUQU6h5/iX4sGvBMv8okHCFJYfbYyB9mmmkirv
 hAIY+k5/4FSFXjmnnjq1QPxcOeaVTlAiP/X6cM3L1lVG6n7gWd5tO/MVzzsz49gp8aco
 P/9V9PoTbw0vHypom+3WYIfVYcEuCfmYB1u0I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749485413; x=1750090213;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Cssr8twv2thAnVgYUmdX7j+fU0KKEL8FgHtsQqWplQo=;
 b=r1wsyhKZg4O56Xrpr+9+JlyR85qq0EYt6QL7kFHQ0CEyEXf/IsETh8bm6ieNa4Ua1V
 /TcQDybYuP/eNcqyHh5FzOnTbcb04T6cVn23dipNde43Ki95r3xsmPc94F5qZ7gQcSR1
 0VMB65F2D728puDnXsjVDmDDNfAoAeh8TenHRBLXRh6tX1gP6pdghWGZ1ygzbAuIJHRv
 0krkeGFS83Z8Ib95FahDOQN+9xQxv7KTeoFokYGpZILZTLsZ3XiAJvujt2VnOn0evTOA
 7TqzGyhX+wrkToMhK35jmtAtitx8NBeF9LcVUboSE1tYUBcEMjds6tWyD0jR+HSIElmW
 CuFQ==
X-Gm-Message-State: AOJu0YzjsnWTqOvGqUvkRyHr8N2nMzZVpi3aubFsXCb2iBvh8RbnFwhc
 ITOjQGy/fDF0UrGzIK5lYJ2HIoyr34LIlgsMPjpY2S8oUt+KUnG33URDj0G4lDXnJl9Pu+BOABZ
 6LSj7R7o=
X-Gm-Gg: ASbGncvTrzFBfzSgE62LXbbWYMfAaEWtDIITdefKBmnZ4FU3o7W/iZOf28Em13mP07+
 e2fuwl3Db1cNRyABg015F35dhojRAFHLr6swaal6xuaZ7DEaGdAboYM76wOM1CvwTxHpGG6j/QY
 0W/eyfT8/Hcy5AYUtXwO38bEqINrCFHYsjXtCnuzccWYlSidkkDDZtTYOD0gTsEX6Auqn2t4kBg
 BVTZdv0I0kMw4TFSS+VYaaEWd2vXiz5aJWdHJBhP1zygUDXSwrlXMioaWcL9wE1NrXMqcsts3cq
 8e1HtCaKaORJll8rsj+XEN2zjBi60G8OXnmePwUZZq/ii35dIOCG6GHT7yaCo5t1BAfbtWaO4W3
 fAG4qeyHcYYN4KL0=
X-Google-Smtp-Source: AGHT+IGiJCSeend+QDtjSNdJxS+ZmdnANQubB4jaGjLFabUrAJDGUDq9t07EE1nLSg7UWEISstXoMQ==
X-Received: by 2002:a4a:e5d0:0:b0:610:ce80:d9fa with SMTP id
 006d021491bc7-610ce816774mr2324428eaf.4.1749485412833; 
 Mon, 09 Jun 2025 09:10:12 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-60f3e826c0esm1366114eaf.28.2025.06.09.09.10.12
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Jun 2025 09:10:12 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] Gitlab: Allow running sandbox test.py jobs on more hosts
Date: Mon,  9 Jun 2025 10:10:11 -0600
Message-ID: <20250609161011.674524-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

With a test investigation of how long each of our current build machines
can take to run the sandbox test.py job, we can see that the longest
running hosts are any of the arm64 machines. In some cases this may be a
matter of overall system load, but in others it's hard to say. The
challenge with these tests is that the run itself is single threaded and
covers a large number of tests. There may be gains made in looking in to
optimizing some individual tests. For now however we will likely gain
the most by removing potential bottle necks here and allow any amd64 or
arm64 host to run the test instead of trying to ensure they only run on
one of the few "fast" machines.

Link: https://source.denx.de/u-boot/u-boot/-/pipelines/26533/test_report
Signed-off-by: Tom Rini <trini@konsulko.com>
---
 .gitlab-ci.yml | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 18afc03b4600..2dfeda9985d7 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -264,8 +264,8 @@ Check packing of Python tools:
 sandbox test.py:
   parallel:
     matrix:
-      - HOST: "fast arm64"
-      - HOST: "fast amd64"
+      - HOST: "arm64"
+      - HOST: "amd64"
   tags:
     - ${HOST}
   variables:
@@ -276,8 +276,8 @@ sandbox test.py:
 sandbox with clang test.py:
   parallel:
     matrix:
-      - HOST: "fast arm64"
-      - HOST: "fast amd64"
+      - HOST: "arm64"
+      - HOST: "amd64"
   tags:
     - ${HOST}
   variables:
@@ -288,8 +288,8 @@ sandbox with clang test.py:
 sandbox64 test.py:
   parallel:
     matrix:
-      - HOST: "fast arm64"
-      - HOST: "fast amd64"
+      - HOST: "arm64"
+      - HOST: "amd64"
   tags:
     - ${HOST}
   variables:
@@ -299,8 +299,8 @@ sandbox64 test.py:
 sandbox64 with clang test.py:
   parallel:
     matrix:
-      - HOST: "fast arm64"
-      - HOST: "fast amd64"
+      - HOST: "arm64"
+      - HOST: "amd64"
   tags:
     - ${HOST}
   variables:
@@ -311,8 +311,8 @@ sandbox64 with clang test.py:
 sandbox64_lwip test.py:
   parallel:
     matrix:
-      - HOST: "fast arm64"
-      - HOST: "fast amd64"
+      - HOST: "arm64"
+      - HOST: "amd64"
   tags:
     - ${HOST}
   variables:
-- 
2.43.0

