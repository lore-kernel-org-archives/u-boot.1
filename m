Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 221EBCD5BC8
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 20:22:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8521C848E7;
	Tue, 26 May 2026 22:22:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="OrPfaw3k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C78E384843; Tue, 26 May 2026 22:22:28 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4EBFC848D7
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 22:22:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7de4be15125so10716961a34.0
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 13:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1779826945; x=1780431745; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NCIk8REhGTPpzgimRlNZdkp1alW/wtV7Dbt+FUfBj5g=;
 b=OrPfaw3khFFE/u2pF0XMp7jccBaAdR/B9AyX6ZPey1bALN8gbMmAbBSclJe7NbKgtk
 2tlO7LSZJ6TVWBMLhaSrWVPWr1I4w9HQLyWrjG7bmcegdPsoXN95dzhcf5M7RoY2LClx
 z6TeAaLXypSQxq35YONbDWpeaXCDd8VyHFYms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779826945; x=1780431745;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NCIk8REhGTPpzgimRlNZdkp1alW/wtV7Dbt+FUfBj5g=;
 b=ZSJ4/WQmlM0IDys1u1IhAm838N/igmnlveCwIuiPF84ywvIeA5rvtP4LE1zsgRnoh0
 wjAjuP9rdwdXaPqtsQqgMrVzaU1oDMIUqXp+z8SXSF6bJSgthXOzaedGc/ypExvsx8jF
 tvr8NA7cxIN1chy/s3iezUdxdqswGpaRTYZpxRYj3WwvayC8ebBkh3rJW6E5Pk1ZxrdM
 9kFAKRVGFLyG0HuDQrrECvCAPZQMCvVES/P63Cm8jBmVAQFIp6qgRRm/sqOmO64q5Q6A
 vmtgn0CNX5zFmWlzmKkXL7OxOXYJj1I2cDKfyiNlXaKaD4HBTDVZII16nFSlOY8vHiit
 sTpw==
X-Gm-Message-State: AOJu0YyIIsD5xgLFNfJ7+Pt7mBB2KHdHwrFYy3Y98/V/ijpZAwmrlwnO
 5qmc9Sz9pH0ZTxlSniz+H7U18ggWuhMiod7G2rfHtvdjTXlEy8ciFcCRiTXLSf/uHfrvd4f09nP
 EfD1hOWw=
X-Gm-Gg: Acq92OGmwzsLwZRHNkMoAXcECxpDQha9fnrAwgtzScsTxg3nVq2SoKBaqsSjYQf0Oej
 RTx0n+3t2x3676b3qAKv4yVzrvltyjoFghQcVMm8hJse4Rz/y0+3oo9uztO3FYhjPOY6OGIuK5l
 5k9nNjLA3MmMSHfHG3UYL2T2cc5u9cAHkJBsxPyiQXkHuKwhZX9R80s7MuPDvspflMFhWAY1X1X
 qAP18NGLMC7DrOMQuIdzr/LTvjjw0p8CvTSGVVmRLYmRXg+ZKyKALJdAnaZdyO2ayVBju9nlGNj
 WFslW0Joj6IWTy3LA9+HQAs0Jzg7CZ1T+r4UV8PAKevqvWwIWtsxByB9kxWQk6y9/E/VUNTx/gF
 rsQRYdQg+FUa9L/gZpebbkPqQAgwGBzV6OwQe8W3EITz67XVioSer2WiqYD8M979585l0QeBSeL
 L6+3I4bv4HcSSCejqleN29LfgKWtoiM8K8xy2KDfOw5hJVwDUblAsnNPegktaxeK5SZZVocLfl3
 aKeppIJk95VbtOAsENzeCcthwzsH9YhiAaylUMyHe7e/kxwDijJJPUde/BnB9E5XqWAtJrBl/9H
 xrffbukGvUzat0E=
X-Received: by 2002:a05:6830:4983:b0:7e5:f957:a61f with SMTP id
 46e09a7af769-7e5feed1a7bmr13476209a34.18.1779826945130; 
 Tue, 26 May 2026 13:22:25 -0700 (PDT)
Received: from bill-the-cat.tailc58245.ts.net
 (fixed-187-191-8-235.totalplay.net. [187.191.8.235])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e60663a2cbsm10593685a34.19.2026.05.26.13.22.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 13:22:24 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Anton Ivanov <anton@binarly.io>
Subject: [PATCH 2/2] dtc: libfdt: Introduce a can_assume check in
 fdt_check_full
Date: Tue, 26 May 2026 14:19:28 -0600
Message-ID: <20260526202218.4004070-3-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526202218.4004070-1-trini@konsulko.com>
References: <20260526202218.4004070-1-trini@konsulko.com>
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

The current upstream method of having a function omit various tests is
to use the can_assume macro. Take the logic we had previously been using
and instead make it a can_assume(PERFECT) check within fdt_check_full
itself.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
I will be submitting this change upstream and will follow up if needed
here.
---
 scripts/dtc/libfdt/fdt_check.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/scripts/dtc/libfdt/fdt_check.c b/scripts/dtc/libfdt/fdt_check.c
index a21ebbc9239f..7509c11d8580 100644
--- a/scripts/dtc/libfdt/fdt_check.c
+++ b/scripts/dtc/libfdt/fdt_check.c
@@ -21,6 +21,8 @@ int fdt_check_full(const void *fdt, size_t bufsize)
 	const char *propname;
 	bool expect_end = false;
 
+	if (can_assume(PERFECT))
+		return 0;
 	if (bufsize < FDT_V1_SIZE)
 		return -FDT_ERR_TRUNCATED;
 	if (bufsize < fdt_header_size(fdt))
-- 
2.43.0

