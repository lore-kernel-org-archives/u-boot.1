Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A67AC4828F
	for <u-boot@archiver.kernel.org>; Fri,  2 Feb 2024 14:41:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82DBF87B8C;
	Fri,  2 Feb 2024 15:41:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hbThH+K4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A08C487B8C; Fri,  2 Feb 2024 15:37:06 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AAA4C878ED
 for <u-boot@lists.denx.de>; Fri,  2 Feb 2024 15:37:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=massimiliano.minella@gmail.com
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-40ef6bbb61fso18112855e9.1
 for <u-boot@lists.denx.de>; Fri, 02 Feb 2024 06:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706884624; x=1707489424; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=fV6Q/zhyZsN4/omdfWqz4QgadMmqODKpRkZ0qhHWfZM=;
 b=hbThH+K4oHNyFYB9M70A5DsDrltTFDmOnS3odD+oG0jd771RnW9RVLcQjyZT2/Nsll
 yZd6Fbv9DN2rzgvDJXphLplABhAwb+sLqLUJVNBuGwCECvOP7b14wnEJh2cdvNXm6WS9
 lZgiEeDCcvjuswt7YHOpU8i2KpHjyeupit7mEqZkJBIvUTN+sZoyR0rvZ8dkvPY35Zlh
 0JyKDexfj+Y6NgSQ1Xfhoo06KWbjNPj6S77jsfJpUDie1zYAadbPHO7sRputNinV8Jim
 DR7SaBGhlExoMYIwvs96CHt03Sx+cehU7p0S2nqI1+PmDeSaiDPi2wOfaBwROngpqW5T
 zk7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706884624; x=1707489424;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fV6Q/zhyZsN4/omdfWqz4QgadMmqODKpRkZ0qhHWfZM=;
 b=Q7eZ1yC7YtG2RP8ru45u27qW+RezuLYf8ZgqAbU2GIEwExSGaAHFVlV/QxmMLEeDj2
 E6E07siyAhayAVEy/HYWnJlcIk0QwEKMT/evIehc+SSSOTaVE4pmGp6mYiMt0TgTCm5H
 FNhRlZsWHwumhgP0IiJN/wJfk0BYXyMybkURaIXicee/WDDxfNNpPPRVHWtvbuWieDD7
 Q0BR4S/E9FsdWPAGUj5E9QbAvPo71Ga4y0VciCpceTRU12q3lXrMF9yCdRWOMd6zrA0e
 1tumsEFkywbGYzwN7L6sy+0zzFGgSMD92oVW6blY3YAzSRc+CqNCgB5T2VMd0VXrsK/y
 LuPg==
X-Gm-Message-State: AOJu0YyVjSsAoTA7MPrFEY91Ya1LtcKA8rC0+Dm8PU4sdfUFHSKDPKIl
 8KMmRwvzItI8969rhqLZlvJSEBep1VjfsrvgcmxqegoXVYF4wXLyjbYpYgwg/e12fQ==
X-Google-Smtp-Source: AGHT+IGYDQ0GUEqF7r0VP7XAoDvGlkJg9H13RUOA7Egv9S2G2BWY5LYvMg68DXYcOEhnH9mkqP7kGA==
X-Received: by 2002:a05:600c:1ca4:b0:40e:a3b8:a2b8 with SMTP id
 k36-20020a05600c1ca400b0040ea3b8a2b8mr1593821wms.26.1706884623430; 
 Fri, 02 Feb 2024 06:37:03 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCWv+4HWt4dcrAOBbJ/IHGb25vTYYaXr+DObLws5X14W9dnwoDOgy7Vh8GpO2dTwcoIOssSJyPMGtKb+UN0qjn2bsI97dbjj8oZiBjY=
Received: from localhost ([165.225.81.67]) by smtp.gmail.com with ESMTPSA id
 p9-20020a05600c468900b0040fb989f4bdsm75869wmo.23.2024.02.02.06.37.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Feb 2024 06:37:02 -0800 (PST)
From: Massimiliano Minella <massimiliano.minella@gmail.com>
To: u-boot@lists.denx.de
Cc: Roland Gaudig <roland.gaudig@weidmueller.com>,
 Massimiliano Minella <massimiliano.minella@se.com>
Subject: [PATCH] cmd: setexpr: fix no matching string in gsub return empty
 value
Date: Fri,  2 Feb 2024 15:36:56 +0100
Message-ID: <20240202143657.3883166-1-massimiliano.minella@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 02 Feb 2024 15:41:31 +0100
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

From: Massimiliano Minella <massimiliano.minella@se.com>

In gsub, when the destination string is empty, the string 't' is
provided and the regular expression doesn't match, then the final result
is an empty string.

Example:

=> echo ${foo}

=> setenv foo
=> setexpr foo gsub e a bar
=> echo ${foo}

=>

The variable ${foo} should contain "bar" and the lack of match shouldn't
be considered an error.

This patch fixes the erroneous behavior by removing the return
statement and breaking out of the loop in case of lack of match.

Also add a test for the no match case.

Signed-off-by: Massimiliano Minella <massimiliano.minella@se.com>
---
 cmd/setexpr.c      |  6 ++----
 test/cmd/setexpr.c | 10 ++++++++++
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/cmd/setexpr.c b/cmd/setexpr.c
index 233471f6cb..6a7c0c914b 100644
--- a/cmd/setexpr.c
+++ b/cmd/setexpr.c
@@ -216,14 +216,12 @@ int setexpr_regex_sub(char *data, uint data_size, char *nbuf, uint nbuf_size,
 		if (res == 0) {
 			if (loop == 0) {
 				debug("%s: No match\n", data);
-				return 1;
 			} else {
-				break;
+				debug("## MATCH ## %s\n", data);
 			}
+			break;
 		}
 
-		debug("## MATCH ## %s\n", data);
-
 		if (!s)
 			return 1;
 
diff --git a/test/cmd/setexpr.c b/test/cmd/setexpr.c
index 312593e1e3..ee329e94b8 100644
--- a/test/cmd/setexpr.c
+++ b/test/cmd/setexpr.c
@@ -179,6 +179,16 @@ static int setexpr_test_regex(struct unit_test_state *uts)
 	val = env_get("mary");
 	ut_asserteq_str("this is a test", val);
 
+	/* No match */
+	ut_assertok(run_command("setenv fred 'this is a test'", 0));
+	ut_assertok(run_command("setenv mary ''", 0));
+	ut_assertok(run_command("setexpr fred gsub us is \"${fred}\"", 0));
+	ut_assertok(run_command("setexpr mary gsub us is \"${fred}\"", 0));
+	val = env_get("fred");
+	ut_asserteq_str("this is a test", val);
+	val = env_get("mary");
+	ut_asserteq_str("this is a test", val);
+
 	unmap_sysmem(buf);
 
 	return 0;
-- 
2.43.0

