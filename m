Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2558C7115A
	for <u-boot@archiver.kernel.org>; Tue, 17 Jun 2025 12:12:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 50F2882C2F;
	Tue, 17 Jun 2025 14:12:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="uMEVfL0j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A28DA82CFA; Tue, 17 Jun 2025 14:12:50 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D45CB82BA1
 for <u-boot@lists.denx.de>; Tue, 17 Jun 2025 14:12:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-450cb2ddd46so31624915e9.2
 for <u-boot@lists.denx.de>; Tue, 17 Jun 2025 05:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750162367; x=1750767167; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=07ehJHFTHDTKWJIHKi+VnaBymw5Vi6ce5SWkJ8pVAd8=;
 b=uMEVfL0j3/bYjXEatn5nabHZEUakiaXu8ZlxVrdMZt6c3Kg7t0G6W9eLN36nKT5mhy
 Bndl06MLcLabKKd90Dz69XvLnocM5CyL9oST8cTZhfMmjj+5vHhHTd+FRczUnL47Tvyf
 SSyQ4tUvuUMFAN5yhuufZ2tL+4y6PySM6+XMzgqugNyXjp3MPuVZCZhNwxu6lSIeLVn6
 APmGeXjNi/Pl6bw04DbdMofqOqUkl4mHGBgXFRMhfFFkF+4c5sko5SKFo2GzuVCPj38f
 3byIphzIRFSfMhOvgP/wPat+lJsY+D2M0iDzYmyR7Dkul3HTOHQfeKx972esBs/VxmsT
 aP8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750162367; x=1750767167;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=07ehJHFTHDTKWJIHKi+VnaBymw5Vi6ce5SWkJ8pVAd8=;
 b=j2goh3+Q4bruv7JTQNKfkcSXh6eWRi1Q1BIE6M8Wxkzac3Ls+Iui3v3UuZ1WqyXsA0
 +X9/h+850w/Sj51JBaYhzVSW6epr0KJk0viF9LnAgmxnWxoN3X8gJO0n7sPgisnAAg73
 C5gROwUNDgvDE9IIWS0zxtP8zwpKJ4Wjz8nJJLSIp+F17qTnZlVa4aT/gwZyicxszp1g
 vD6S+ZCBPMZEwwYDW+u6BMore+gyLxBOW59jyBnali4n+iM7gnPRyyMTCNIOw83Dh5Ei
 TkOhl/J7zB7uxpezRqjCNl/br9+s1OHFVgnKL4ueNEy83h2LwEyx8fNV4/jHuIVv7hDc
 LyUw==
X-Gm-Message-State: AOJu0YwiAvutoEmVqyYwBg7zIMLHL+9CkgvoY7PxaGRzjVwi0fb8A9iF
 1RBTKXyqYmyjb1nwcfz7ueeTRpij7JOIBH89fNLJ/YvNq1ECBPewbuSCXOyGH2DB3c3ap3pEdRy
 auvte
X-Gm-Gg: ASbGncubV6gtVjgVUlM546SR3PsnEhvmRUJj2I/i/P0Oka39RbUhOWVlGBwy5bT1ZaU
 pRu05tOeTjdsFceTVbB94B//0CgCqcBIsis4VujGSrE1Hei8z6IEZRK0Hd9FnGun7zsdO/6+JvZ
 u5/tIOO7r0Gx6iHZQDsd2LYNSSl5bhLrDGXM4SG0TVrUjvq4dwxYn/uM1u0+r48M7/1Do9qnu1r
 puqqf1tVwRQmfIWJjVQXWOZTuJjeonSyxKX4699IWtwUlqJ12hsHqThCbdr0+EqGvBRraapbv/n
 ylaZogpkGKauvLAk5IfHvu4mzcH6jAElE+brGfxUyTo4cfctGc0J72Q5gSdMguZqKPwve9eQMkk
 YFFg/oA==
X-Google-Smtp-Source: AGHT+IFgQw+EyxY3YkVnJEIIkmbxDgyN2yTDWUcD4m1kM4M5wQJ6SH50CS1VHv6Kxxvqgo4T+Qup+g==
X-Received: by 2002:a05:600c:4f4f:b0:442:f482:c421 with SMTP id
 5b1f17b1804b1-45352e28826mr19250555e9.22.1750162366865; 
 Tue, 17 Jun 2025 05:12:46 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:d4f5:465a:56e7:e545])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4532e195768sm175310595e9.0.2025.06.17.05.12.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Jun 2025 05:12:46 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: U-Boot mailing list <u-boot@lists.denx.de>
Cc: Jerome Forissier <jerome.forissier@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2] doc: cmd: wget: remove erroneous note
Date: Tue, 17 Jun 2025 14:10:58 +0200
Message-ID: <20250617121107.2585075-1-jerome.forissier@linaro.org>
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

The note about U-Boot not being able to verify server certificates is
false now that WGET_CACERT and WGET_BUILTIN_CACERT have been added.
Remove it.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
---

(no changes since v1)

 doc/usage/cmd/wget.rst | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/doc/usage/cmd/wget.rst b/doc/usage/cmd/wget.rst
index 44033aaff39..06df2842549 100644
--- a/doc/usage/cmd/wget.rst
+++ b/doc/usage/cmd/wget.rst
@@ -185,13 +185,6 @@ TCP Selective Acknowledgments in the legacy network stack can be enabled via
 CONFIG_PROT_TCP_SACK=y. This will improve the download speed. Selective
 Acknowledgments are enabled by default with lwIP.
 
-.. note::
-
-    U-Boot currently has no way to verify certificates for HTTPS.
-    A place to store the root CA certificates is needed, and then MBed TLS would
-    need to walk the entire chain. Therefore, man-in-the middle attacks are
-    possible and HTTPS should not be relied upon for payload authentication.
-
 Return value
 ------------
 
-- 
2.43.0

base-commit: 17012e3068d047ad71460f039eeb0c3be63f82a0
branch: wget-doc-update
