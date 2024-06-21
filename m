Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81209C27C4F
	for <u-boot@archiver.kernel.org>; Fri, 21 Jun 2024 13:15:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 946FD88577;
	Fri, 21 Jun 2024 15:14:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="eRGFOvDy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8495288405; Fri, 21 Jun 2024 15:14:34 +0200 (CEST)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8543288405
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 15:14:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-7eec09cc7f6so75759939f.0
 for <u-boot@lists.denx.de>; Fri, 21 Jun 2024 06:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1718975670; x=1719580470; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eIaUHtmxOCoDPB8Dr2EtcMBBfsP4hsti4aYZcgI3OQk=;
 b=eRGFOvDy9pUDaigk/VJdiAKS6OMYJRqrXI6QEvFulRR3ZEkM/6pQtCVP66zP3GWW/W
 YCGrVmt/oid7/B15fenyz3HkEZQIihNWM157rMKqhXet2lSuqHxxeYzEcsbRQrZwWuLQ
 fgjD2HPt70msnKHoDdlxN+AHePXycn/dkTFnY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718975670; x=1719580470;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eIaUHtmxOCoDPB8Dr2EtcMBBfsP4hsti4aYZcgI3OQk=;
 b=vk3p9AJCiu5yB/rWWGJjE41gKlXpRzcfuO6WkvFtVbnJtmfZtuMwBe7ezxpSo08t7c
 ABYBg2wmHL2ec5MVX6ZPZvoRQMX+B+5nmORK9tKbYnLxkj/aemrGNpJVYet4AW7zA9Et
 Hw0NvqOsv9sftu/3ggFQj2I1qmIDNzPqLFfTSxQJlDIJ4MrxVAtcS8mBi45L/p6OwXuA
 +zxBY+C13/8SaRAs5JzG2HZoS+c6u9DineKJxkIOOJuCSC0GIvG2MhVpPdqCpDDIifoV
 OSLOTOgf0qWD7q8dNDRSoW8Iekj09Tm/sk3bgTCaZsgEKCKUU3hCqGqhXxMbtP9mJY47
 GE+A==
X-Gm-Message-State: AOJu0YxeHDyNNS7TEYySf2P3VbPoyH47ax1dbPXzLzOzASMKahp1FHFG
 cvGr5kXHtrA64ED0k1unKhFrVmMmAvnrN+FVBXfXfVCJe+3qGI7z72qxtEoreKv1s/EXjI9Zgog
 RBQ==
X-Google-Smtp-Source: AGHT+IEZ9zSvxf1XnGz2Wu8RCS3RNJMRkS/RInzvWk3Ou8A/LwA6KiRn+TH1tpqSvgOaykusM7Dz3A==
X-Received: by 2002:a05:6602:15c9:b0:7eb:906e:e3ee with SMTP id
 ca18e2360f4ac-7f13ee5c07dmr971246439f.12.1718975670204; 
 Fri, 21 Jun 2024 06:14:30 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4b9d12496fdsm346881173.163.2024.06.21.06.14.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Jun 2024 06:14:29 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>,
	Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 5/6] u_boot_pylib: Use correct coverage tool within venv
Date: Fri, 21 Jun 2024 07:14:21 -0600
Message-Id: <20240621131423.2363294-6-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240621131423.2363294-1-sjg@chromium.org>
References: <20240621131423.2363294-1-sjg@chromium.org>
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

When running within a Python venv we must use the 'coverage' tool (which
is within the venv) so that the venv packages are used in preference to
system packages. Otherwise the coverage tests run in a different
environment from the normal tests and may fail due to missing packages.

Handle this by detecting the venv and changing the tool name.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/u_boot_pylib/test_util.py | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/tools/u_boot_pylib/test_util.py b/tools/u_boot_pylib/test_util.py
index f18d385d995..857ce58c98c 100644
--- a/tools/u_boot_pylib/test_util.py
+++ b/tools/u_boot_pylib/test_util.py
@@ -60,12 +60,17 @@ def run_test_coverage(prog, filter_fname, exclude_list, build_dir, required=None
     prefix = ''
     if build_dir:
         prefix = 'PYTHONPATH=$PYTHONPATH:%s/sandbox_spl/tools ' % build_dir
-    cmd = ('%spython3-coverage run '
-           '--omit "%s" %s %s %s %s' % (prefix, ','.join(glob_list),
+
+    # Detect a Python virtualenv and use 'coverage' instead
+    covtool = ('python3-coverage' if sys.prefix == sys.base_prefix else
+               'coverage')
+
+    cmd = ('%s%s run '
+           '--omit "%s" %s %s %s %s' % (prefix, covtool, ','.join(glob_list),
                                         prog, extra_args or '', test_cmd,
                                         single_thread or '-P1'))
     os.system(cmd)
-    stdout = command.output('python3-coverage', 'report')
+    stdout = command.output(covtool, 'report')
     lines = stdout.splitlines()
     if required:
         # Convert '/path/to/name.py' just the module name 'name'
-- 
2.34.1

