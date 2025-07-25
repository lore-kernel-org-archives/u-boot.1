Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8E73C87FCA
	for <u-boot@archiver.kernel.org>; Fri, 25 Jul 2025 19:42:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F22B839BB;
	Fri, 25 Jul 2025 21:42:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UNQvdwC9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AAA99839C6; Fri, 25 Jul 2025 21:42:19 +0200 (CEST)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E57983980
 for <u-boot@lists.denx.de>; Fri, 25 Jul 2025 21:42:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-41b6561d3c5so713162b6e.1
 for <u-boot@lists.denx.de>; Fri, 25 Jul 2025 12:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1753472536; x=1754077336; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=lI/cPsmrviJPPwsGex1vu8pDFal0EYvt+pR5sgoacIs=;
 b=UNQvdwC96QJG8YRtSLA1V4E8Yw5frX1coAXrZO6cY3a6tYopmJw1hTvfYB755C31bO
 k+aTRhg0EPkCSDPMB9xkyEs/cicdAtGdXkLYP38gBxFJKep3hhsFGtiHwFX/4IsyfmxQ
 WT5q+Ev4xfCg0YIzPqx3c1d+GT6U0utN3edQs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753472536; x=1754077336;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lI/cPsmrviJPPwsGex1vu8pDFal0EYvt+pR5sgoacIs=;
 b=s3huTXxOV2Lb366hWtPgVZRkzhbPi1c18fZI7ZMtZAw9JvQgzs76aOqi7lazZawL2c
 9usPvHHPtk2ZJjORSZ/SRWkd1LSTqDWSSj6XUZoS2ix6SQwK6RvfM182r+JD43xtvwda
 rt1zJC1ibADUAN1fKSLaH9Yscjes1GN4TOP44RsuBClw5PeT19uKb4QmZyk/698p+n9W
 QoCfgc+WQQo2NMOa6EX5EPQP77JmWvwgfXExWShDYsh9FqCM5JQURZGo9ocKyW9CLbgP
 JfKyBDy78IVpMjH8ODSt+xFpbsXg4u7qyhkUCby93VDYNx5IwQylL1gGyundelzkUSMh
 nOEg==
X-Gm-Message-State: AOJu0YwoxF26YK9140yjWBfDJT1LdUOdTBaVz+DL88y+EfCTyb7JVlvW
 g+cKcKeapsj18MK7qbCeYc+ZXf23VwFlomdmdbRttf+JnApOt0AOt8UXOzSoZYYCEMudtzRHR+K
 sAIVRq9s=
X-Gm-Gg: ASbGnctEyHdQG4COh3/DKbxmgpLOzVyAYCONaXn3svcDk8nzZn8cJTTZ7E8Q7+AUJv4
 El6EAf8TmKfpkw5ehwrLKXT6WWxKrbkOmKsbg4j44XmNnJYU22cQ3zthvJp5GakqFXyMKrLM8Oz
 y+EMskDFbcYWE8uuWbXUlxQrhL6v0CM6wSbkFSMoSZa4v6H/Oku+d9k47isE3Rq3X7IliUgvowA
 sXNBhrWYvFThaF2pRFEIsjyDVov5XoTPx9qlIxatk4mYk51ei5nG2c+uQNwZ2cZLVvUyUewCW85
 A5kW/sgws9DtC0oW3eqCtP8rFNda2Mu9TKMaNLgV82GBI7Z7FqeDgnrJS4o9UDS1Snv+3I553GL
 gkO0YxnPjjoMdx80hfdQeSa02ixIuR/5RN86wLdJHksUnWiC++U860NX2IE8=
X-Google-Smtp-Source: AGHT+IHQTrXcEEKM8y5LVdjpJqaKXiIQDigcDuDJNfMp9npAYHvqD6NF+awxC1EzDtEXlTMfHZa3Mw==
X-Received: by 2002:a05:6808:21a6:b0:409:f8e:727f with SMTP id
 5614622812f47-42bb75e3773mr1534434b6e.3.1753472536057; 
 Fri, 25 Jul 2025 12:42:16 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-61913f4cde7sm100555eaf.5.2025.07.25.12.42.15
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Jul 2025 12:42:15 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] test: py: test_fit_mkimage_validate: Only run either test on
 sandbox
Date: Fri, 25 Jul 2025 13:42:14 -0600
Message-ID: <20250725194214.4156440-1-trini@konsulko.com>
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

Both of these tests are only valid for sandbox (and require dtc) so both
tests need the pytest annotations.

Fixes 93d09d3bd8ea ("test: fit: add test case for invalid default configuration reference")
Signed-off-by: Tom Rini <trini@konsulko.com>
---
 test/py/tests/test_fit_mkimage_validate.py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/test/py/tests/test_fit_mkimage_validate.py b/test/py/tests/test_fit_mkimage_validate.py
index ef974c8c7622..170b2a8cbbb6 100644
--- a/test/py/tests/test_fit_mkimage_validate.py
+++ b/test/py/tests/test_fit_mkimage_validate.py
@@ -57,6 +57,8 @@ def test_fit_invalid_image_reference(ubman):
     assert result.returncode != 0, "mkimage should fail due to missing image reference"
     assert "references undefined image 'notexist'" in result.stderr
 
+@pytest.mark.boardspec('sandbox')
+@pytest.mark.requiredtool('dtc')
 def test_fit_invalid_default_config(ubman):
     """Test that mkimage fails when default config is missing"""
 
-- 
2.43.0

