Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E27EC0219B
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 16:33:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72A6B80BAE;
	Sun,  9 Feb 2025 17:33:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mKJFLsNQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0BDEC807FE; Sun,  9 Feb 2025 15:56:48 +0100 (CET)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com
 [IPv6:2a00:1450:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 094C380141
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 15:56:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maks.mishinfz@gmail.com
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-30761be8fa7so32210621fa.2
 for <u-boot@lists.denx.de>; Sun, 09 Feb 2025 06:56:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739113005; x=1739717805; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=dpQx/H2wVLxLKF2JRYTA5HJc+lAH0utSsqeOxecpPVU=;
 b=mKJFLsNQlEoPbHhSrdFcEG7IP5xgrycru+kHLDDBK2uWGSg2tvCLe3ylL9wOn5peZ9
 tOB5tDcIx2HH2JyWfiz7x6yng1ALJQATlHIgTt44y/4BGhOUmG+e4JsIkv+yuhy5HW9f
 Vq6mcirtle26X0zjDGGJEcuoHnBqLdvXS0J8ChDanUWteeHUQ/loddy3NONxH3Gp5xKv
 3455P7pNkjoUaqBOkXWJ3IhM8lslSK9quolieJT89k9CwoM/fgLvupEB8SjwMmKFbiBO
 fdXBcjKiSusFaiDhGuJyGNXv5Q6gwXxyT90NbBKsbB5MCmWx5V1xjb1F/Fer13VcCtxN
 SsVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739113005; x=1739717805;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dpQx/H2wVLxLKF2JRYTA5HJc+lAH0utSsqeOxecpPVU=;
 b=VQdHZzBkuT80vKIdUD8KLOTqDes2VDMRhD1e9PPtKb+vxC7YZcA8y/hvJI6Ihcnj0G
 gk/GUWI1fhLBJV5K6b+K8RqRCBadjEhLWhjy0bWi89cIyOrzU1B7iTt9J7S3cOWLJwRw
 PDVxGEeWWIhOhjg9tcY87P8au3KWDJhylwTETgywueUYafGHhH0Xom0WwolR/jXeW45N
 xKltHujrBHktHOf7ShTYxCgO/a8rwQFbUW0SuCX3wJaKaGF+cZG6NGqgZzHNEFAVfBfN
 ruEa2JF/80cs98bWAVi/xGF0EPNU3NsRLm380ZaBueIEyyJL8pmgI93zU8mI3PAAh2xE
 ZP/A==
X-Gm-Message-State: AOJu0YwOiIwG0dEBCTg36I+5Q0Al1kYAmyPau3cipr8xxh4Ru2kJkpVj
 SWWG6ZFgWnwE09VbKMZHJxuvVUmfX87QL61p+tM7jZwq7r2YbeC6H+LNWN1s
X-Gm-Gg: ASbGncswvD8jstHdfcDv0wXmfMBwURsw5RXxYdWxG3vMHfpDOOoThUCaoYf0OZPK9L9
 lnsflyRvzkPqTNt1sIbhz5nt1HUwXSOpW1uMPGgNc31W2e2aUc1PP7M03xuofoocWfcWCNb82Ix
 7Mxr8Y/XB5TBJqBOgOz1BplUxbe9QMwQK0+xXMSD6tkNUyVlXnvdqgs7P9IxbUQARDg2BJ0JykI
 qNMPLmHij/ELXycWRxe+br9kRBAFAvgVR5AX3VRldQghm5O1fHF4BMAmXlojUfRpj2jdKN/tAfJ
 HynBOqyWdYC8UG6oQkQgWxo=
X-Google-Smtp-Source: AGHT+IEKgZV99SvNI7sCdhqyzVedwhG0RYv6AwlK2QupjYUqyyWuitY4nIvyPp3u9grCHfdxXt+org==
X-Received: by 2002:a05:6512:2348:b0:543:f1d1:c6d6 with SMTP id
 2adb3069b0e04-54414aae0f7mr2439373e87.2.1739113004699; 
 Sun, 09 Feb 2025 06:56:44 -0800 (PST)
Received: from dev.rasu.local ([212.22.67.162])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-544106041e2sm989151e87.238.2025.02.09.06.56.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Feb 2025 06:56:44 -0800 (PST)
From: Maks Mishin <maks.mishinfz@gmail.com>
X-Google-Original-From: Maks Mishin <maks.mishinFZ@gmail.com>
To: u-boot@lists.denx.de
Cc: Maks Mishin <maks.mishinFZ@gmail.com>
Subject: [PATCH] tools: Fix handle leak in mmap_fdt function
Date: Sun,  9 Feb 2025 17:56:41 +0300
Message-Id: <20250209145641.635650-1-maks.mishinFZ@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 09 Feb 2025 17:33:22 +0100
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

The handle 'ptr' is created at fit_common.c:91 by calling 
function 'mmap' and lost at fit_common.c:127: 
Added call of free for `ptr` if ptr != MAP_FAILED.

Trigger was found by the Svace static analyzer.

Signed-off-by: Maks Mishin <maks.mishinFZ@gmail.com>
---
 tools/fit_common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/fit_common.c b/tools/fit_common.c
index d1cde16c1c..135e105929 100644
--- a/tools/fit_common.c
+++ b/tools/fit_common.c
@@ -123,6 +123,7 @@ err:
 		close(fd);
 	if (delete_on_error)
 		unlink(fname);
+	free(ptr);
 
 	return -1;
 }
-- 
2.34.1

