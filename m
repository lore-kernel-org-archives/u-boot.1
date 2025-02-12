Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03E01C02198
	for <u-boot@archiver.kernel.org>; Wed, 12 Feb 2025 22:24:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 17C55809D0;
	Wed, 12 Feb 2025 23:24:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="jDxkfJj7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F014801DE; Wed, 12 Feb 2025 23:24:13 +0100 (CET)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com
 [IPv6:2607:f8b0:4864:20::730])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D8B9680C77
 for <u-boot@lists.denx.de>; Wed, 12 Feb 2025 23:24:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-7c05b91245fso11543085a.2
 for <u-boot@lists.denx.de>; Wed, 12 Feb 2025 14:24:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739399050; x=1740003850; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=EZArmwiz8Ih6m+kQ+b6qg+hTlBkWdsPMZjN2CnuIrgo=;
 b=jDxkfJj7UY7CfH5Zqocte6+la6fzEE5ekCStwQ6phQUrYEpL8r/AY7lNII2cLtCPVq
 pN3uaBUEW67rEXv+RQw5LYE5ZoqVI2VmoV9uJCQPGrmHRaWBWMsOpxsbSgnVH3kUuRgR
 lKht5tfBATqc0YEyp2XP7lJr3QKMEQr2A0wO4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739399050; x=1740003850;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EZArmwiz8Ih6m+kQ+b6qg+hTlBkWdsPMZjN2CnuIrgo=;
 b=T8ageK9xTIisy1t4pWnbyJzZ9XtOxdtFA167Q9B473/qvgTTufTu1aHQSwR/mtzmSG
 Dz16xURGYzG4cRDi6GfIVKu59LupGXlxMQwoGGajHATB5WkdK0/8RIdtdNzGUNr6DyWp
 IJU2czKxUzZW5vdXvm/AAe3Xq/1mV3cRoBjyBq+qf4xrRQdc9YSC0bKReUDd5j7/zdi7
 pLhNZ28EiQbKllB/iZi9DqPmGEK8+82LYEt4ugYi2PQ7VMYSK5wuOoLoLfhVMQVXtjjh
 Gjz3k/sW8Vd8dcvrSE4wDJTL6V7WTUz7zZO3g6D652NG+SWyqtRGFGTY8SEZXuXiOdz3
 k2sA==
X-Gm-Message-State: AOJu0Yya6wf5zQ5QlIzWzfGmoj7/CyOdNE+7FrKmzv3rKsEPyhYXdEl2
 9UnyS2+lzLoIZOirQmA+senrBS7V6rjvJrVDN70noN+TiSQfAds22vgJi7GRxB2PXy+imGhgld+
 5
X-Gm-Gg: ASbGncuYsmTigbWcKvoUM50UHiPUN4cqv8uTwNjmz14n44L2ADBpH+ucox53H+Y6Xao
 g3HAW+gijU16xSYPmQGufyZHcQsL6/pDCv85TQWJmixuq7sEYKHx6pXpFRhS0jiAZp+2oMaebu4
 OFHZLxwmyZGsO5yGGL0ZfJ6bVruvnq8Dr6PD3k9jq8lmHhgzVQaPQRoTuWHdcX3CIXig2Y307hN
 B81AG3VMWQs9ZnjJus3LYULxOZQaiS3F0vcW9iTJOzenx4rwM7U+6P1hm3UhHnIOpPVxEtLdNpj
 Ee6IwoQMjOYRLGGl0Q==
X-Google-Smtp-Source: AGHT+IEUqOmTGeg0Uw0YLAOnDoN8oAtmhqKsdBsZBI7931Wq1+TVwmJdfJXml2K2rqjj0FOaESEiNw==
X-Received: by 2002:a05:620a:440e:b0:7c0:53c5:ec2 with SMTP id
 af79cd13be357-7c06fc6c283mr708165585a.17.1739399049845; 
 Wed, 12 Feb 2025 14:24:09 -0800 (PST)
Received: from bill-the-cat.. ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c060bcb0dbsm467369885a.28.2025.02.12.14.24.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Feb 2025 14:24:08 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Love Kumar <love.kumar@amd.com>
Subject: [PATCH] test/py: Rework test_spi.py to assert we found output
Date: Wed, 12 Feb 2025 16:24:07 -0600
Message-ID: <20250212222407.684579-1-trini@konsulko.com>
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

When running a newer version of pylint it will complain that page_size
may be used before being assignment. Looking deeper what is going on is
that we could run in to the case where the regex we run for any of the
flash information fails but since we don't have a result, we don't check
it either. In the case of the rest of the numerical values we then have
some assignment (multiplying by some value) and so pylint doesn't
complain. Rework things to assert that each regex has a result and so
failure will stop the test and we won't have any use before assignment.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Love Kumar <love.kumar@amd.com>
---
 test/py/tests/test_spi.py | 44 +++++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 23 deletions(-)

diff --git a/test/py/tests/test_spi.py b/test/py/tests/test_spi.py
index 0abdfa78b761..d57db9178e99 100644
--- a/test/py/tests/test_spi.py
+++ b/test/py/tests/test_spi.py
@@ -119,37 +119,35 @@ def spi_pre_commands(u_boot_console, freq):
         pytest.fail('Not recognized the SPI flash part name')
 
     m = re.search('page size (.+?) Bytes', output)
-    if m:
-        try:
-            page_size = int(m.group(1))
-        except ValueError:
-            pytest.fail('Not recognized the SPI page size')
+    assert m
+    try:
+        page_size = int(m.group(1))
+    except ValueError:
+        pytest.fail('Not recognized the SPI page size')
 
     m = re.search('erase size (.+?) KiB', output)
-    if m:
-        try:
-            erase_size = int(m.group(1))
-        except ValueError:
-            pytest.fail('Not recognized the SPI erase size')
-
+    assert m
+    try:
+        erase_size = int(m.group(1))
         erase_size *= 1024
+    except ValueError:
+        pytest.fail('Not recognized the SPI erase size')
 
     m = re.search('total (.+?) MiB', output)
-    if m:
-        try:
-            total_size = int(m.group(1))
-        except ValueError:
-            pytest.fail('Not recognized the SPI total size')
-
+    assert m
+    try:
+        total_size = int(m.group(1))
         total_size *= 1024 * 1024
+    except ValueError:
+        pytest.fail('Not recognized the SPI total size')
 
     m = re.search('Detected (.+?) with', output)
-    if m:
-        try:
-            flash_part = m.group(1)
-            assert flash_part == part_name
-        except ValueError:
-            pytest.fail('Not recognized the SPI flash part')
+    assert m
+    try:
+        flash_part = m.group(1)
+        assert flash_part == part_name
+    except ValueError:
+        pytest.fail('Not recognized the SPI flash part')
 
     global SPI_DATA
     SPI_DATA = {
-- 
2.43.0

