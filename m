Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DAF1C28B20
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 16:30:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AFC8081951;
	Fri, 28 Mar 2025 17:30:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="X637V8rM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0667181E1C; Fri, 28 Mar 2025 17:30:46 +0100 (CET)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB3438144A
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 17:30:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=andrew.goodbody@linaro.org
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-394780e98easo1430448f8f.1
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 09:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743179443; x=1743784243; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9hR5PvZeOdO5mBySDB43laq1MkymmOcMhi4vuIr0sBs=;
 b=X637V8rMCDoSwRGJ73IHJdPIBa2+RZpo1DIHpXfL1plRDZiJ9J5wRWfBywqt7iU/oc
 87UeL54A8+ehl5fkM9Ib87vkm1WVUEnS62c8kq1c12sudaNKkMepbl29qdJieveip65+
 IjuT8+JHFblT6+iKYy3hZhBuS5WWllaNuRm0vdY5V087+RPiIxWGU1e0ngxZwPsTUFBw
 ar/X1vnmRCskTrAnGbZl4k3pF/h0+ZEq+4vgt05UNfEQFt2giS7f5iOwM0fbceTN6af3
 H/fqBg0KaNUewY/zsi4PDsvtqr/VFvN98WG2zM9fsc+Co1uZheJxRYK3fWpFU97MXKwH
 988A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743179443; x=1743784243;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9hR5PvZeOdO5mBySDB43laq1MkymmOcMhi4vuIr0sBs=;
 b=UuNbNGA9oZVT6dqF32TTEB97tE8mxBAvEgtmwNwPEGAMIn6STqjuN1hvto2MkuS8op
 ihhidW8P3Yt8xK2YlofFQkq8aPlBQ4sKliecY3OJ/Sz5NcKsORn/iey9UV/OkYDXhdN7
 BHqu+Xf6CfVhDT4QU1Y5SdFEskBWoIWrG1YeZT/xtbrTS2NGsQTxiKx7ygNILqCroL6I
 H8NCd/J1xtUtYFJGmIZO7xmK8/kHVJ2LzPQpqW82vS7177+wMqEcbPZnF/aMgaUIE6OT
 eL5PJ7zAbXwH21ssiwuQiy9dxtSGyQ6udnUtqnP4ywZM9Tlq3gF6v0zBsUoc3Pj78LGB
 EkLQ==
X-Gm-Message-State: AOJu0Yy4Z183VIJHoJ6DunipHR9yX3IWWJCKBgQHXV7mWyzZ85rPbLWE
 scHyCSRrPRHatJvn4y00iAeULpkOkZVj6m72J9+n4znjz2JdR6mOcxqzJmMdYhM77vH4b20jRB7
 o
X-Gm-Gg: ASbGncvbzcqosHOGg8U0FaGUHlpHKr7EmcqNS6qWGDxzdwM8j3pqRFFArvHBU8atUfS
 1HqMqiagZ97wQdmtxwHL+m5Vc0i0Br0EtsjrMbtU+CDUtZOXSd3uncNz7GPCM2RlM6n+iCm1pfw
 2vSe/lTtpVgo8qt0spTLaUlA+JFrNAMaY5KkMbXfucWFsraIDQrKxK5DDhpwXRKthpBm5bSdDfk
 60MLIRD2OWRmZOkPHmsX8hjCz9ttVLRZjn6qrCpvJJp/5kQ2oLTc6qd7uDoiwFHR8QeBKfXy5pS
 kciaiSsMFdfjfWzg0vWywZ4sd/B1Ve6hZ1hp2MRGLCl0ZIlq+Jjl0+65SRHORmGJ
X-Google-Smtp-Source: AGHT+IGopBMEPkz2k19iEDuKApJwMkutemgcdp4wVt/Rr51X7GVCApkt1r+dnUyrc7amXaAfBo5oKQ==
X-Received: by 2002:a05:6000:40e0:b0:399:7f44:5c74 with SMTP id
 ffacd0b85a97d-39ad1789a74mr7673701f8f.55.1743179443171; 
 Fri, 28 Mar 2025 09:30:43 -0700 (PDT)
Received: from artemis2.broadband ([2a0a:ef40:e72:7f01:e9f8:d687:2de7:2161])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b7a42a3sm3101360f8f.91.2025.03.28.09.30.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 09:30:42 -0700 (PDT)
From: Andrew Goodbody <andrew.goodbody@linaro.org>
To: u-boot@lists.denx.de
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>,
 Love Kumar <love.kumar@amd.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] test/py: memtest: Fix test for non-trivial parameters
Date: Fri, 28 Mar 2025 16:30:37 +0000
Message-Id: <20250328163037.24594-1-andrew.goodbody@linaro.org>
X-Mailer: git-send-email 2.39.5
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

When using non-trivial values for parameters for this test it
will cause a spurious failure as the test passes a decimal value
to the mtest command which will interpret it as hexadecimal and
result in failure as below.

test/py/tests/test_memtest.py:66: in test_memtest_ddr
    assert expected_response in response
E   AssertionError: assert 'Tested 16 iteration(s) with 0 errors.' in 'Refusing to do empty test\r\nmtest - simple RAM read/write test\r\n\r\nUsage:\r\nmtest [start [end [pattern [iterations]]]]'
----------------------------- Captured stdout call -----------------------------
U-Boot> mtest 134217728 0x8001000 90 0x10
Refusing to do empty test
mtest - simple RAM read/write test
Usage:
mtest [start [end [pattern [iterations]]]]

The fix is to ensure that all the parameters to the mtest command are
passed as hexadecimal values.

Fixes: 22efc1cf276c ("test/py: memtest: Add tests for mtest command")
Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>

---

 test/py/tests/test_memtest.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/test/py/tests/test_memtest.py b/test/py/tests/test_memtest.py
index 0618d96f1be..f03e23db2e4 100644
--- a/test/py/tests/test_memtest.py
+++ b/test/py/tests/test_memtest.py
@@ -29,12 +29,12 @@ def get_memtest_env(u_boot_console):
     if not f:
         pytest.skip("memtest is not enabled!")
     else:
-        start = f.get("start_addr", 0x0)
-        size = f.get("size", 0x1000)
-        pattern = f.get("pattern", 0x0)
+        start = hex(f.get("start_addr", 0x0))
+        size = hex(f.get("size", 0x1000))
+        pattern = hex(f.get("pattern", 0x0))
         iteration = f.get("iteration", 2)
         timeout = f.get("timeout", 50000)
-        end = hex(int(start) + int(size))
+        end = hex(int(start, 16) + int(size, 16))
         return start, end, pattern, iteration, timeout
 
 @pytest.mark.buildconfigspec("cmd_memtest")
-- 
2.39.5

