Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B600C369A2
	for <u-boot@archiver.kernel.org>; Fri, 11 Apr 2025 15:31:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B78DF8418A;
	Fri, 11 Apr 2025 17:31:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ruvn1AbW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C1098419E; Fri, 11 Apr 2025 17:31:01 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4FE9D8418A
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 17:30:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43d04ea9d9aso10637405e9.3
 for <u-boot@lists.denx.de>; Fri, 11 Apr 2025 08:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744385457; x=1744990257; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SN0AdoG0e7dbKQGuC9llAgzmc45S+ohEsodZyUhF9QI=;
 b=ruvn1AbWNdP+MZKlohWGAyYDKgg8Zx3/idQCMI1g14VTsxrNAWfYt2Ax24DtYjXzus
 CGj1G8FWkx7xPZVkP0arzFkySr+4nhb9XyeXx0iwSHJyl7dKaJA1183YnhkWQxR5tW5N
 MRIggGrVCQw+4zic+RCdDN2qoypshB0V5b4ESdC3agtRJIRV0dx0MvSwMW6ci1jXszb8
 Yc5deJNjAHjiizPUB8Dp6F0YDOQjieYx+cVL+9eiTQ79h/xYho66K7+7hiwDrqH9GIHK
 6Nif6fSBX08Ovk3dvxcTi3vP/vRo3dPGX8l+yZn4NRy1naKJt0THNYbB9go6E10ZyElR
 nsKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744385457; x=1744990257;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SN0AdoG0e7dbKQGuC9llAgzmc45S+ohEsodZyUhF9QI=;
 b=OHm3VriO14usJ7g8elwgf+eKlx5vHqgEzwDs5pb20OI1P8naINXnzvGFISBK3YQV4m
 WsLt6R8XQBD8p3CU5O18ig9VENz9tjJSJoch/q7vN0Tz5kdj4q05jpdnbNBXa2+L33R2
 /Pwj61i0qi+0K9CDJd/y35ano1eB1l4qz3KnwBCkp0hFtJ8069MdhmiWgb6F66U0hSO1
 w3W5CIrbqfAfLAZ0RAUlJcbRUJmuugs4dKvq7Z3fI1mSjYYxaR96TXcbeDvwDpcbX7DX
 yX5az13nYtlAMFvb267HqsgBXDal65fubHlM+TMpEJ/+UhLxrm15/TXLIwSqBKilhtpA
 X0Nw==
X-Gm-Message-State: AOJu0Yzpc0Bqr+0g1NryC+ExDJz1VPP1CmOg9LMXKBXCKsRUcB500bAL
 ReEWr7BWIy0umbw9km+RR4MrZyTyvwGaqx9lixnu4s17buX1KVJxoh8WB1aN36jXqYMInVvWv1U
 uqvc=
X-Gm-Gg: ASbGncsotyDiZ0o+i4vNZ9hs2+mJKtZFbEArR4OBMEKtdDIaycRVGEA4OnH74JLsc6K
 9ZFnJIS6i6NyOaCWVsyT7/Y1cT/7KCqHJZyYxl+mdLsiwBkSeyc8/acOqIHek5FLQBHnRunkSMv
 l6b8Wxruv4gR1jfeT4+DM9MYDlG0Ul7WYMcrNBazZqjzyKQe5lErGElUMUXEvN3RHEcS54msl0d
 JccGGmMJ3VxYfYsD7qGVOgmVHY6Hzvwu0suiqI2kQ8kGJfEdpPRqxwpRRXcl70fdnnrw5E7ShZl
 Ebj8RTq/oWrAo1h9RzkfFGzcV5DHUpjK4Ho45a888zkeeOdYIQ==
X-Google-Smtp-Source: AGHT+IH0DYx8Y/gJM7KK8LEOQiSUu2taJeQ6NVRKLLe/KanB1QlF++XyHiWEMrTjz3DtUvLaqCQtvA==
X-Received: by 2002:a05:600c:1e18:b0:43d:2230:303b with SMTP id
 5b1f17b1804b1-43f3a9ab06bmr22978185e9.20.1744385457500; 
 Fri, 11 Apr 2025 08:30:57 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:94cf:dbda:d223:8de8])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43f205ecf30sm90337355e9.1.2025.04.11.08.30.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Apr 2025 08:30:56 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Love Kumar <love.kumar@amd.com>, Michal Simek <michal.simek@amd.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [RFC PATCH v1 3/7] test/py/tests/test_bootstage.py: add test for JSON
 report
Date: Fri, 11 Apr 2025 17:29:29 +0200
Message-ID: <20250411153040.1772000-4-jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250411153040.1772000-1-jerome.forissier@linaro.org>
References: <20250411153040.1772000-1-jerome.forissier@linaro.org>
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

Add test for CONFIG_BOOTSTAGE_REPORT_JSON.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---

 test/py/tests/test_bootstage.py | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/test/py/tests/test_bootstage.py b/test/py/tests/test_bootstage.py
index 379c1cae6dd..8d0afe2611b 100644
--- a/test/py/tests/test_bootstage.py
+++ b/test/py/tests/test_bootstage.py
@@ -30,6 +30,15 @@ def test_bootstage_report(ubman):
     assert 'Accumulated time:' in output
     assert 'dm_r' in output
 
+@pytest.mark.buildconfigspec('bootstage')
+@pytest.mark.buildconfigspec('cmd_bootstage')
+@pytest.mark.buildconfigspec('bootstage_report_json')
+def test_bootstage_report_json(ubman):
+    output = ubman.run_command('bootstage report')
+    assert '=== Begin JSON bootstage report ===' in output
+    assert '"dm_r"' in output
+    assert '"reset~board_init_f"' in output
+
 @pytest.mark.buildconfigspec('bootstage')
 @pytest.mark.buildconfigspec('cmd_bootstage')
 @pytest.mark.buildconfigspec('bootstage_stash')
-- 
2.43.0

