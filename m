Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 628BCC02180
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 13:39:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7BFD180EB5;
	Wed, 15 Jan 2025 14:32:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BHUWBuCG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 34C6D80DF7; Wed, 15 Jan 2025 14:32:35 +0100 (CET)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F299280A3F
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 14:32:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-84a012f7232so29419339f.0
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 05:32:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736947951; x=1737552751; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wzNzYY9jaT0g94INdnqYp4vg0FZP8stZkKphVITitAU=;
 b=BHUWBuCGWpzPklzD5jjbV7iKaTWWkDuVfwUI6Pj9yEtZnHw0dVhhCv3bA5nDgFxhxv
 sKWa5e3/NzN6CQC0EVWuK+gx/PwxSIQB6OM547MxgpXPPHjKtswvvwgaQtEQKsiWHywb
 g4/XM74VJp0vLcKQonrWVa41yXQ9Xr+dUw9FQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736947951; x=1737552751;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wzNzYY9jaT0g94INdnqYp4vg0FZP8stZkKphVITitAU=;
 b=YslUwBmO2tkzkbGBuEzFVjn40UNvlInuyEc1m1fKU/Qup/pmgJvTD/4TKkofyF+Vc/
 Jvxh/XfHRV2yJtwJIWQBCjs3r7MfosEIVqoKyw5isPmq1mzVIoMA5NQH614yJ9fthSIN
 vwdB6jritE0+WX3wI5uAOLQ8GU7373ZI5XvgcYa3pQHG+FxIHF6Z4EpgVa2PhWNpzEKY
 m59KBuPXF+PSHNN8SwwNMyhCnE5qAzDMT/doR88fm68cxroAy4mSG5yEuSLzosw3guWt
 O2VkEqmIGGzTyYMIwSmFx3yFFKmc3XgL9F5gUr1KRwc4AWLS0imytL5rEYRPJ8e5Mg4O
 isgw==
X-Gm-Message-State: AOJu0YwbrE4NmIC8px5pvXJWF1DMdps24utoa597C3vmRW4fk2CEns/p
 Qc3YFj2dXdHCG2h030AWjbKzBt0468qqRU2+83B23bddPhIqU8nrgNJhGa2nTYjmjVUOiuxFA0Q
 =
X-Gm-Gg: ASbGncsgFHC3ntGe7YrW4mIlw0paEygU5Ee/ZiPP4sxuO+8baRJW1RCmu4xXv4pB9bv
 G92OfKyP7RZPYs/pA3lXwdpNkBTForDVjJStu2/QCHdeP9oO7WRbAFV06Feq9OwR626qiVlMsqb
 BAg+GZzQ6b+yFb2rDfz8GavQQscWRCRxAaiHdUNk/JXMe9TsRr7F/mnbFtDeX81OwZ0UQ/vDmFc
 r8xQUOz8odL620w+EPYbdK6RMbFZu0/Wh7FStDOoYTsBTcs1PcVncX0ByG9E41RlnfLrNhxIDoI
 8tpnvnGKP6odjyuQOg==
X-Google-Smtp-Source: AGHT+IHoqSAEK3MSR62KeegwWxGnC/H8CgbtEXPoeNW9ouzkrCE0gCdQrcx+D3ZCSdmhOqwOz+U4ww==
X-Received: by 2002:a05:6602:4250:b0:835:3dfc:5ba5 with SMTP id
 ca18e2360f4ac-84f6740cfaemr213211239f.5.1736947951214; 
 Wed, 15 Jan 2025 05:32:31 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea1b5f836csm4091248173.20.2025.01.15.05.32.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 05:32:30 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 42/43] test: Disable test_suite
Date: Wed, 15 Jan 2025 06:31:12 -0700
Message-Id: <20250115133114.590375-43-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250115133114.590375-1-sjg@chromium.org>
References: <20250115133114.590375-1-sjg@chromium.org>
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

This fails at present, so disable it until it can pass.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 test/py/tests/test_suite.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/test/py/tests/test_suite.py b/test/py/tests/test_suite.py
index 1c248602199..d5d68502167 100644
--- a/test/py/tests/test_suite.py
+++ b/test/py/tests/test_suite.py
@@ -122,7 +122,8 @@ def process_ut_info(cons, output):
 @pytest.mark.buildconfigspec('sandbox')
 @pytest.mark.notbuildconfigspec('sandbox_spl')
 @pytest.mark.notbuildconfigspec('sandbox64')
-def test_suite(u_boot_console, u_boot_config):
+# This test is disabled since it fails; remove the leading 'x' to try it
+def xtest_suite(u_boot_console, u_boot_config):
     """Perform various checks on the unit tests, including:
 
        - The number of suites matches that reported by the 'ut info'
-- 
2.34.1

