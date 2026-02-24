Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 420E8F4BB6F
	for <u-boot@archiver.kernel.org>; Tue, 24 Feb 2026 18:31:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B92682BF2;
	Tue, 24 Feb 2026 19:31:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Q1JDh6ER";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D41883642; Tue, 24 Feb 2026 19:31:12 +0100 (CET)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4413680050
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 19:31:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7d4c12ff3d5so5420494a34.2
 for <u-boot@lists.denx.de>; Tue, 24 Feb 2026 10:31:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1771957869; x=1772562669; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9Y8CTlZ/qrkn0AYftJg7R1fpGHzJHnlBT3zfR9vyauY=;
 b=Q1JDh6ERnXVlTw8C3McNNnUrlzGe0F2V4b38wUv+ICHYFzeD82FZ1lvv1dv4dMYZVe
 +R3ZjPZ9EgrdAs9h8z0wcE2LPoAK6Le/Uty+T8fZYUODPwN/EpPIzqXX9CTblUzC+z/x
 GF0luwK+8Bbh62hvWztZ7qCz3n+bWjPEYqYsE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771957869; x=1772562669;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9Y8CTlZ/qrkn0AYftJg7R1fpGHzJHnlBT3zfR9vyauY=;
 b=ajqqNklAD0hTYdcIjg02uuSSRBgibcHWo/la1MWZ4YqDckdKVlg2IlHyCWFGsdcpZy
 raHPC4TCqeTLH38qSAUe9PypPU0XnWunvk0c5fqa0uNHjfoQnxGeORZDnHsn4xZ4hXcV
 QDfn4ODc3mSwb3HZ2pIMop2WH9+0zMfask/kHo3VMqmVhc1cARXUEs2aTc7P/TfyblOK
 IvqieDdTAVTlB9zlLHo1l+aeyZm2ApzLIb/N3hWO2JKdDSjy3JzO49kpmxPyj6Va5uhe
 mVxXgo0hMGmZTWr5B04ltvZr/6HJCF/nNXON60o7qbjWMxCQ6TeL2vsSej+vCebN+xE7
 oD3g==
X-Gm-Message-State: AOJu0YxfDQ7Bx8cdRYjcdWp/NLeUgJ5yjUApbH4boh9/G9CAk4uX1dZg
 7+ti9Xnr9lylfQDTQQubA7Nv1nzGPn4IfkyVyLl1IdfI9dpIiXXa3JevQS0MXa+XC9KfgsK79Ql
 ZQ7jh0dQ=
X-Gm-Gg: AZuq6aI+eOG9nZOhgwB5KKbYJx8RpxICfvYvgkvoFv0OJTcRIOItlxoK+aZNj3eH05R
 ME2UHKZfUHe3efHjB2ujBTR+Dd2ZcyaCXnkEVm1khr7B6xdjv0p0EcpjDRQ2vij1C1/pjDkeSJb
 NM7FZSc50GsRvRmSzbrn1YAeekW94iTGjUPFKS5QMICfBa3R2xXFRo7NgL2hoDEOERTAQOlrNXa
 3i3iLDSb/0AEy7xWG1aiEz8gUDjYLVjS+1bD5kvOcajdl2bWd8pfJy5Db4PYrcO59/bnabFy7BM
 mBTWH1PlIjNxbFbpRPVmQNe8KEZDwfhsLtFJTJ+z8XPbIqoM4wn5ZucI4u7kZuQDxJQcq+ZnJTS
 UHdSTEKwzIYkm/eq1rna7Co8vBvzNwhnc4UAWsKijFCscTeghrVan3zqT+Do6Qf1c8OHM1WXOoe
 oS/MzrX4/XGgRS1HD9pm5vI9U2LEMmL9uaFbNI3beokzYnmBmQvH78AVh2k9jPmzxzX62uSLu7c
 nm8uLs48Prpl1hOUWU0TKc7u4McVFo3LquDOhhqf/z7qMXk1PGbCebEZ4ZQafP9
X-Received: by 2002:a05:6830:2b25:b0:7cf:d9ba:c99b with SMTP id
 46e09a7af769-7d52be3dd53mr9990719a34.11.1771957868984; 
 Tue, 24 Feb 2026 10:31:08 -0800 (PST)
Received: from bill-the-cat.. (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d52cf78736sm11216664a34.5.2026.02.24.10.31.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 10:31:08 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>
Subject: [PATCH] Gitlab: Fix TEST_PY_TEST_SPEC for qemu-x86_64 in sjg-lab
Date: Tue, 24 Feb 2026 12:31:07 -0600
Message-ID: <20260224183107.124914-1-trini@konsulko.com>
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

With the change to regularize the usage of TEST_PY_TEST_SPEC in the
sjg-lab stanza with commit c7f360f20d84 ("Gitlab: Rework sjg-lab calling
test.py to be closer to test.py stage") the leading "and " part of the
usage under qemu-x86_64 wasn't removed when it should have been. Do so
now.

Fixes: c7f360f20d84 ("Gitlab: Rework sjg-lab calling test.py to be closer to test.py stage")
Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Simon Glass <sjg@chromium.org>
---
 .gitlab-ci.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 08d01c41f358..245e422d72fa 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -795,5 +795,5 @@ vf2:
 qemu-x86_64:
   variables:
     ROLE: qemu-x86_64
-    TEST_PY_TEST_SPEC: "and not sleep"
+    TEST_PY_TEST_SPEC: "not sleep"
   <<: *sjg_lab_dfn
-- 
2.43.0

