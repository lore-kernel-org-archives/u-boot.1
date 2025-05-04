Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96ACFC3ABAC
	for <u-boot@archiver.kernel.org>; Sun,  4 May 2025 13:25:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2CDB829C3;
	Sun,  4 May 2025 15:24:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="VRiqQyNy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E72B482A3B; Sun,  4 May 2025 15:24:17 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 02303828F8
 for <u-boot@lists.denx.de>; Sun,  4 May 2025 15:24:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-ac2ab99e16eso745420366b.0
 for <u-boot@lists.denx.de>; Sun, 04 May 2025 06:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746365055; x=1746969855; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qInn2EnFnAs4Yl3qtXhifOFzZ8ENiXmW89qsgsIkOkw=;
 b=VRiqQyNy8LlDlHTw+9goyupw4zvS02sHxaQN03jzf9BfyjfMDT6KQ47BPZIlHoew7k
 +2nCqpSAlGiLkcYKpeXyfLQlw0JDT+1s7Ij7yKpn8uA4keJAaQ4gCGK7W5JuT4nCFwu6
 UINz7tIrRQ19Fmka+UmNqZnPkfrXGuHYKECVo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746365055; x=1746969855;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qInn2EnFnAs4Yl3qtXhifOFzZ8ENiXmW89qsgsIkOkw=;
 b=MDSrnLVEjGcStlxW4KsqNw2PBTkhntXJ85Z5d7hQUTeeKK5Pn25Zc592pBqNNjqY6a
 zZWWvH27/qHfSXMUIkStJG/j6/MbwFpIuEVBFjJYFjFkQDJePqm0K4Y3Dj7tEnaxVb2x
 ouVMT0WNVwqhOUME8Albjj6lfyXLX1yS33OhKSe4fMQSny8WDuHFo1bxrAhjFo84q7CA
 +mchDo4pnvJrd2p5tqDfPQZD5lMaIOISwCshWC9kR0PI+lIiwQwEMtHJZlnxjVvicM/P
 w7AAf9Be5aG/sCZbYmvp4utglkUdZK1M8erADzheBdj451+vB81bQ9JGaUpbRJ5OHJpo
 Ey7A==
X-Gm-Message-State: AOJu0YxZJm61103xK3JXFTghUb5iv2ikmpftFA6HXqT77/pOvk6z6nbD
 RhCloWSusbJcZHFp9lR/oBy2Q/lxcML2Omg9r0inqBqCTr2qSpflUw+3sSZjeESywiLYV6XQPt2
 cwtFd3FU=
X-Gm-Gg: ASbGncsdHaMDcpXbBAByPccKgRka/Xteo8SqZ1Z6BvJzw2oYiYoOWS1ruUqjlGwNcU6
 53nCWmEj+gyjlyYyJDNurKNtWt+GvIZMDgELLRpBtKK5WOgF62qBNTyrqrvW8b1yHqH9BaWtima
 LCwTEPUBDm3IvPk+fSicl/+BiiEPsDxSphMkks/rbzBPCDRaBHkELRaVhD9MeYTblGxBYIuD8MS
 pVYx4u/xL36lMwztnziY5gUn+eCW4JRql/PaOjlN+sSXQg0Z7caz7w+qX8B76TqBxE0OeD07Rud
 wexIa5Ev47OGzNdxcqDZIh619qMzZN8PDh8sbyEqmRx2jrQ=
X-Google-Smtp-Source: AGHT+IFBu0CWN7sYSJLe1P8dw0NJ/5jLzI8tw6oQmORsXRGbDG/IOzPtiuj21N4Ahc/AzvoRDesdmQ==
X-Received: by 2002:a17:907:3da0:b0:acb:b966:3a7c with SMTP id
 a640c23a62f3a-ad1a4aa5dedmr322348066b.47.1746365054816; 
 Sun, 04 May 2025 06:24:14 -0700 (PDT)
Received: from chromium.org ([213.157.19.135])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad1891f508asm328655666b.85.2025.05.04.06.24.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 May 2025 06:24:13 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 07/30] u_boot_pylib: Avoid concurrent execution of only one
 test
Date: Sun,  4 May 2025 15:23:23 +0200
Message-ID: <20250504132356.2317305-8-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250504132356.2317305-1-sjg@chromium.org>
References: <20250504132356.2317305-1-sjg@chromium.org>
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

There is no point in spinning up multiple processes if there is only one
test to execute. Add a check for this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 tools/u_boot_pylib/test_util.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/u_boot_pylib/test_util.py b/tools/u_boot_pylib/test_util.py
index d46c3df5094..fc441a78dc1 100644
--- a/tools/u_boot_pylib/test_util.py
+++ b/tools/u_boot_pylib/test_util.py
@@ -191,7 +191,7 @@ def run_test_suites(toolname, debug, verbosity, test_preserve_dirs, processes,
         resultclass=FullTextTestResult,
     )
 
-    if use_concurrent and processes != 1:
+    if use_concurrent and processes != 1 and not test_name:
         suite = ConcurrentTestSuite(suite,
                 fork_for_tests(processes or multiprocessing.cpu_count()))
 
-- 
2.43.0

