Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77860C27C65
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 20:07:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F0D588804;
	Tue, 11 Jun 2024 22:02:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="K6n4eTo6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B34E3887CC; Tue, 11 Jun 2024 22:02:40 +0200 (CEST)
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com
 [IPv6:2607:f8b0:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 19343887DD
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 22:02:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-37597eba356so14071125ab.2
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 13:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718136157; x=1718740957; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=44bk925XlBlo4oIPhsCGOVqldbsxzgGdPRMUpsyUgp0=;
 b=K6n4eTo6U8mZ55xi2CFFGHzjGd28w1xcfwxOdoT6pLsdDIPmOwePj4ofuwsd/E5zQc
 AE3CZUI78MFhLFjos8PE2XYaOwiCZwUQvhdH9wIWx921bsImn1GFoW7vb0mLr2mGvWmo
 AbzZfq9WROTno9nqTQzsEzSK1q7pPlXmJWpmw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718136157; x=1718740957;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=44bk925XlBlo4oIPhsCGOVqldbsxzgGdPRMUpsyUgp0=;
 b=Npk6V8wI2NEJUBtTZS1Q4Gw7LXDly0JjG5PwS9OsIyiD8BQ+iQs4kq7M82czr2hoIg
 snY8i5ZWUnXIHMoVy4KMn5kBb0Yc6cR9EjUv2W1ycjqCNWhh6O3uw6VJqIexVaV7B64h
 Sd8g+4LLIXC2x7mOmTLb9t0f/aAeEfTgfrSlGmY6jnqc3TJWG8g3k7h4tm9JnDF5Fg4P
 5zkBDxxuiv1XKB51Z6sw70G//NeT6FPpSYTJtD69HRSw9Xc0+aeawiAdy/gmDrWVTvhB
 GmdR38spmGqCipwpuFgpETgLSHcWukSht731C5qR3TpW9V2JdIIYZo2v7AQZhR/L6mhM
 c95w==
X-Gm-Message-State: AOJu0YyppS8P5FzlrhhGIHzdBlJmOOSPJtSKWmo2Y8wvoxynAMZ1pdht
 Amd61eWnjjpgeoZd/tN1a6EFJdP04fRQiFJuzChEAbBkKkBBSEahjwLZ/5JhtG6k7jjQ7bneuMs
 3/g==
X-Google-Smtp-Source: AGHT+IEZ2uglipTU5Akx19wF8fIJbn/4vCPtdZWJuArxusfyWXMGyqrMcphunIJoXinBTt22LcaqIw==
X-Received: by 2002:a92:290e:0:b0:375:8b0e:4434 with SMTP id
 e9e14a558f8ab-3758b0e477fmr96496645ab.16.1718136156716; 
 Tue, 11 Jun 2024 13:02:36 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-375ca7617cbsm1119305ab.30.2024.06.11.13.02.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jun 2024 13:02:36 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>, Pavel Herrmann <morpheus.ibis@gmail.com>
Subject: [PATCH 28/42] test: dm: Show failing driver name
Date: Tue, 11 Jun 2024 14:01:42 -0600
Message-Id: <20240611200156.2245525-29-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240611200156.2245525-1-sjg@chromium.org>
References: <20240611200156.2245525-1-sjg@chromium.org>
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

When a driver is not registered properly it is not clear which one it
is. Adjust test_dm_compat() to show this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 test/py/tests/test_dm.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/test/py/tests/test_dm.py b/test/py/tests/test_dm.py
index 68d4ea12235..be94971e455 100644
--- a/test/py/tests/test_dm.py
+++ b/test/py/tests/test_dm.py
@@ -13,8 +13,11 @@ def test_dm_compat(u_boot_console):
                for line in response[:-1].split('\n')[2:])
 
     response = u_boot_console.run_command('dm compat')
+    bad_drivers = set()
     for driver in drivers:
-        assert driver in response
+        if not driver in response:
+            bad_drivers.add(driver)
+    assert not bad_drivers
 
     # check sorting - output looks something like this:
     #  testacpi      0  [   ]   testacpi_drv          |-- acpi-test
-- 
2.34.1

