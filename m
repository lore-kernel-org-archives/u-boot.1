Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CBCAC3ABCB
	for <u-boot@archiver.kernel.org>; Mon, 12 May 2025 21:54:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 867E382162;
	Mon, 12 May 2025 23:54:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UsNe8WrV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A7666829A0; Mon, 12 May 2025 23:54:29 +0200 (CEST)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 49B3780C83
 for <u-boot@lists.denx.de>; Mon, 12 May 2025 23:54:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-3f6dccdcadaso3931753b6e.2
 for <u-boot@lists.denx.de>; Mon, 12 May 2025 14:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1747086866; x=1747691666; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6uDzOaF2+77vuGdQzeoxeoxiEHQYB66ULO2itMFnjyc=;
 b=UsNe8WrVlZeEnPkdnZMI2hQfYV0CSseg3V7jUg8ig2zxhBH+0ohPpTTuxX/EMP+R7F
 DVo73wPYoGhj2Azil3xsXjC6jDMukfa9Ag4DFcXRGJlMKP71+f1kqWLo+Wh/u2+t0VXA
 TRNSvfi5QAbgTVVUlGXVCazT/KlBiBleqXoAE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747086866; x=1747691666;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6uDzOaF2+77vuGdQzeoxeoxiEHQYB66ULO2itMFnjyc=;
 b=I2221e7DRYjVE3Ytt0kPIdUTu7YnrlRwxdj0bkPA9dwMS6gebHTdrPhGPRm8SQeR5r
 L4hCFFA6dqLTc2DKuPV+YS3YBX8/kd+sKt3CBKzh7tD/Wd4GA7YuoxFwk/aBlWv3IA7v
 ckHoCp5aTyYoojWKldQ3twzLjXYuY97lKxO49R0Adt/rwdmFV+wbXDj9FkvIKdh2hVFz
 NvmryUmhbNB+GhKkvaTb6g2eWV/sFUBQU4QpQs7RRKb4ijEhDVI1soAOUpsKuyCc69yV
 BBH/vo9pXe/VB15/+2L1jije25/R3w/jBBhT24z+GkXJ1A6tYQLmyyANhNpXsazbFEab
 Jlkg==
X-Gm-Message-State: AOJu0YwzVu/hXc3X0KlmiA5Oe4sApjHElKiVQeDM8DBacT2Z17XuSE4D
 89gOmfc+fcexMNYB5hHuPQmePx/5nj8tFVohbkVzMrpUMlkPlROXisXcDNngrhj/Mt9TPwLvrn5
 rdPQ=
X-Gm-Gg: ASbGncvzkdBtztbKJdEvRiP1RvrS0tvbOA55vtaJpR7r2i4WcpeRzv0hC9RH5UxCdqT
 QkiUWSkO8+tPd/aIYKFuAOyXS6HlqVtyZuglAca2zxp1CugPtB+dh6YZ3ePKpGH58G/GDKMIYml
 pyn833zy2VP2uQ59Hr/SQlY4KngFONbar59C3ZNCIhzxRTK/W7SxFHiJZtaA17VkQcoPLQHN3a/
 3zY+2MxQ0+CTwC/Ya9iFpyO+2hUXZfoXvjRUKbQrjrMZeYfWw5VREmAOZHzlYKx6lnQAVRWIruQ
 vf3MNZEU4TkBow7GJTV8kUiZ1TX1U+FzCypDmW/LABOCy6PXB3L7jpF9JFLQ1/WYueNnzbWDUYt
 6IRoLADxEC+2LZK8jn8BpdoRN9A==
X-Google-Smtp-Source: AGHT+IFZ9lZrkQY2Ks1saLPBeCORzyEEIRFUB7/FyypnkVhDU5Mlq4VQjKz/vvvHZJz6Oks+JVbNsg==
X-Received: by 2002:a05:6808:2209:b0:3f7:e553:56c6 with SMTP id
 5614622812f47-4037fe8db39mr10153718b6e.37.1747086866066; 
 Mon, 12 May 2025 14:54:26 -0700 (PDT)
Received: from bill-the-cat.. (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40380399c6csm1729260b6e.49.2025.05.12.14.54.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 May 2025 14:54:25 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: [PATCH] doc: pytest: Use globing for test files
Date: Mon, 12 May 2025 15:54:24 -0600
Message-ID: <20250512215424.2362166-1-trini@konsulko.com>
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

After the original series was merged, Quentin noted that we could handle
adding additional tests more easily by using the glob feature. Do so.

Suggested-by: Quentin Schulz <quentin.schulz@cherry.de>
Signed-off-by: Tom Rini <trini@konsulko.com>
---
 doc/develop/pytest/index.rst | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/doc/develop/pytest/index.rst b/doc/develop/pytest/index.rst
index 0a7c1b21a24b..dce8a96370f4 100644
--- a/doc/develop/pytest/index.rst
+++ b/doc/develop/pytest/index.rst
@@ -16,12 +16,6 @@ Individual tests
 
 .. toctree::
    :maxdepth: 1
+   :glob:
 
-   test_000_version
-   test_bind
-   test_bootmenu
-   test_bootstage
-   test_button
-   test_efi_loader
-   test_net
-   test_net_boot
+   test_*
-- 
2.43.0

