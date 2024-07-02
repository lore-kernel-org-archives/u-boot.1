Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A188C30658
	for <u-boot@archiver.kernel.org>; Tue,  2 Jul 2024 16:37:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94C4D883AC;
	Tue,  2 Jul 2024 18:37:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bykbyk8r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1FCCD886A0; Tue,  2 Jul 2024 18:37:35 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31F12882B7
 for <u-boot@lists.denx.de>; Tue,  2 Jul 2024 18:37:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3627ef1fc07so2582119f8f.3
 for <u-boot@lists.denx.de>; Tue, 02 Jul 2024 09:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1719938252; x=1720543052; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=QvuVZ93g7bJ2P554t24L8nGmZRKfT329hlEpziI/Glw=;
 b=bykbyk8rnTGEs5S8fkLyWOyD1BeGtzFwpAD5eWciij4KAIa0fQLIku3YsrfAkNSks4
 XQWMa3XgeFSQ7Uvzc3uyIM86qXlRkcWurqX4V8ok7HQaiaoNO9P6yu+XZjBjcedhIMg1
 kd0H9KZ2QBmVOeueS9U1G936HpUWTi4wmpZAU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719938252; x=1720543052;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QvuVZ93g7bJ2P554t24L8nGmZRKfT329hlEpziI/Glw=;
 b=rjGiLlYbVRXwRb1Ayc9RTSHncMcxcgRjn0QTH9ObSCc/2BJxJrEwSOaDy3N9w2fxq6
 8NKvAIAMEZIWepkyv8m18e6Z4g4ce62xCy+WzyHjqoTI6/ARmnpSa1/UGe32JkrYocWO
 4Wf0B7ToeX4fwToiPKzhIpLz5hKhfIEu6oKJHQIFHHrnxrh9e6FOO/ROOqtpNcvPcKFK
 F6qUxsSun7+DNYT/ZC2/mYd1nPak5DaDJ/4ARObj+BSkOVa1NBVpvhWZDOH8rbu1bZvU
 odZ3NRRqVCo1VJtPitC1fqUA5LcI4t3BmzkCSrNLiCUOVivwlqWGI+l91G7dptd9Rx2g
 fXkw==
X-Gm-Message-State: AOJu0YzgiCiI0LdaiHve3/YimieypkweQHfri0YA0zNXZsWiuF2NKtvj
 pz6dPSXInaA9gserOvdyjeOfJL1CGdU0802h73rPI56heBVNTxmOqChAdcM4iVZQKOFGIECBYbM
 =
X-Google-Smtp-Source: AGHT+IEw6Lb5FPTAtMi1tKESJIoi523+wZcBeM9BonasYE6gY0l9+nSia5+5qtChfm7Z7QPR+hzLcQ==
X-Received: by 2002:a05:6000:1fa8:b0:366:e9b8:784f with SMTP id
 ffacd0b85a97d-367756c6fabmr6276825f8f.32.1719938252187; 
 Tue, 02 Jul 2024 09:37:32 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3678e5c2b08sm1215217f8f.71.2024.07.02.09.37.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 09:37:31 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Neha Malcom Francis <n-francis@ti.com>, Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [PATCH v2] binman: Update cbfstool
Date: Tue,  2 Jul 2024 17:37:28 +0100
Message-Id: <20240702163729.2674096-1-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
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

Update to a newer version of this tool, 4.22.01. This runs OK with the
current binman tests and matches the one in CI.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Use the same version as CI (4.22.01)

 tools/binman/btool/cbfstool.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/binman/btool/cbfstool.py b/tools/binman/btool/cbfstool.py
index 29be2d8a2b5..2d8559abb2b 100644
--- a/tools/binman/btool/cbfstool.py
+++ b/tools/binman/btool/cbfstool.py
@@ -214,6 +214,7 @@ class Bintoolcbfstool(bintool.Bintool):
         """
         if method != bintool.FETCH_BIN:
             return None
+        # Version 4.22.01
         fname, tmpdir = self.fetch_from_drive(
-            '1IOnE0Qvy97d-0WOCwF64xBGpKSY2sMtJ')
+            '1gxNxRuJgD0Iiy9LAPCSB_0959eJCp98g')
         return fname, tmpdir
-- 
2.34.1

