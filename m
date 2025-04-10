Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D45AC3601E
	for <u-boot@archiver.kernel.org>; Thu, 10 Apr 2025 12:44:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 901D783B98;
	Thu, 10 Apr 2025 14:43:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mbvET9cS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8537B83C34; Thu, 10 Apr 2025 14:43:49 +0200 (CEST)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A58A83C23
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 14:43:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-85e73562577so80148139f.0
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 05:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1744289025; x=1744893825; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Oc3r78e+GbXVxxtR30BeonxUPjn6TlNUOYnair1GYj4=;
 b=mbvET9cSL+uknn6IZi3jHQSgB+FzLZeyEf8Vi6m3LRDZcao4KEr1PbzAavE/8XI39i
 JCIeFydOnP0JMW+JaybYkzfgrRTDSJu5qG4pWQlC5FnojNEek0T+qE4Q7svdgQtXgc9r
 zqKxCxUQMD105jh+3Lu7VBpLKYLRjDh8Y+b8c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744289025; x=1744893825;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Oc3r78e+GbXVxxtR30BeonxUPjn6TlNUOYnair1GYj4=;
 b=ArNQ6Q539ZqXR1ajBXAxd0QIlQMkoMVKN9NmyC2GdIKd6KKDXNk8GjQODdigf0uDlL
 itnTucYSDVFfRLmsWlbcnR/p6I6eBzjGVqdX1SnDLkEHz5F8q6UzzOalVNF9tmCYmq3M
 G5mi+r8XdPPuAXIbO+MIX7N26gQ2xOciHvTWu3gcPpEgTx92gAV9xZjj7SxgotTnEHmZ
 3kbFy9r3k2HRB+TIDwhOZl+tSUJexlt8RA90NWn15QIUIRHHh0h4oZBDj6O0L0+PthtR
 pcEUL2rbolyXLzx+glUwiOu/gIf5c0OtJEfWYWjoHqlSn/PCwP8sd7KxGBbem38lyIfr
 7DSA==
X-Gm-Message-State: AOJu0YylCINv9WUgr0zqZzuqqwWnWq+7vz3jadQnu9SfPe13G7QjfqlW
 Incdpw7zSimtMjMOVEEg1VpkwSitaR06VLJFyjolMuk4r4SJMZs7IoZF6BqnxP/3LDHvHI9W7TA
 =
X-Gm-Gg: ASbGncsi19O7/7IDfPjr1+m18nxWvl9LusOFL89wdFbsN+xlWTkNijVFWigCrK7oyV0
 y9PRW7rcOFGydicFDK5ZWyx2lFdQUVabAKH/u7BAoImqyQWE/TGiaCVD40onF0WUES2gx7s3QjX
 lydLd9NmT5msG6EclfQzux3Y5gj00/uZiFwE4Gj1tby8s2KPkp8KnjipmBAjYzpRkQ8AfFoXLdW
 DMrMn7WuzKo5exEr096AkWeKsoxzqB3erMAijSrP5IE3/xwTdgug4ZvyGjIlLe12LCiwEXxFH3U
 E3QKOuCRZYR/fOhhZrCFD17YVHamYC3kKLFpm5yOGX/Svn4eW3+6lIaxW27CDs+TL0L5HBSP5FQ
 YfA==
X-Google-Smtp-Source: AGHT+IGZ8YfPuoiI/MO3ThEDlrOojez51LqFmZOSBiq8eeq1x6FkNv7gxq/SM/9kCyePZgTDxVLQlQ==
X-Received: by 2002:a05:6602:3e9a:b0:85e:2e53:ed27 with SMTP id
 ca18e2360f4ac-8616ecdc19cmr289939239f.3.1744289025197; 
 Thu, 10 Apr 2025 05:43:45 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f505d170e7sm729471173.32.2025.04.10.05.43.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Apr 2025 05:43:44 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 2/8] binman: Exclude dist-packages and site-packages
Date: Thu, 10 Apr 2025 06:42:59 -0600
Message-ID: <20250410124333.843527-3-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250410124333.843527-1-sjg@chromium.org>
References: <20250410124333.843527-1-sjg@chromium.org>
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

Newer versions of the python3-coverage tool require a directory
separator before and after the directory name. Add this so that system
package are not included in the coverage report.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/u_boot_pylib/test_util.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/u_boot_pylib/test_util.py b/tools/u_boot_pylib/test_util.py
index dd671965263..ed216c4fc4e 100644
--- a/tools/u_boot_pylib/test_util.py
+++ b/tools/u_boot_pylib/test_util.py
@@ -56,7 +56,7 @@ def run_test_coverage(prog, filter_fname, exclude_list, build_dir,
     else:
         glob_list = []
     glob_list += exclude_list
-    glob_list += ['*libfdt.py', '*site-packages*', '*dist-packages*']
+    glob_list += ['*libfdt.py', '*/site-packages/*', '*/dist-packages/*']
     glob_list += ['*concurrencytest*']
     test_cmd = 'test' if 'binman' in prog or 'patman' in prog else '-t'
     prefix = ''
-- 
2.43.0

