Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56C7CFF885A
	for <u-boot@archiver.kernel.org>; Sat, 25 Apr 2026 20:38:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 18C56844E4;
	Sat, 25 Apr 2026 22:36:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WXma9TZE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F2DB58419E; Sat, 25 Apr 2026 22:02:08 +0200 (CEST)
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com
 [IPv6:2607:f8b0:4864:20::1044])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4DC284154
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 22:02:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jcethrid@gmail.com
Received: by mail-pj1-x1044.google.com with SMTP id
 98e67ed59e1d1-3614826eca4so8009551a91.1
 for <u-boot@lists.denx.de>; Sat, 25 Apr 2026 13:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777147325; x=1777752125; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FoPRsH+3rt5UvLzzr97UhZ6VyOxF6JZRf8i/FcdvSMI=;
 b=WXma9TZELvFUV1U/NJnFMTNEBZThR7NenYmxgjVeTqjNbz1nDEvsSHebOlhwb6rkMp
 rvkatGOHF5EQbAYy1trSvuxUPrT7rjMjG7pkf4a1QmE8c2kM9tUBp0TwK1atA6KG6AeZ
 gvKBAuWFH4I2+rc1ctr0n1LhiSa+/WROxM8PQ7SaD6KlkXra3fNCbJty5gi9ytcfOQsK
 eM7GdX8PyJGBvGBU6i8m/I68I5q26hIuOSqYxnfFAO2eoyf5lmrpQziI6CyRQ4Km9MX4
 ELAlgMu1HRgfc9FPbchotmEx2+UXNrRaBXnYQ8wuuNtowe33cmSD4Rj99qUqOWjmvC8m
 l2sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777147325; x=1777752125;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FoPRsH+3rt5UvLzzr97UhZ6VyOxF6JZRf8i/FcdvSMI=;
 b=kaovWTMNVtrjEaOUwXUvUcIhbJm/uaaBshr5GP6FFw1pNXlEQh+rqqLM5qgnXIAlEx
 6GteDUDyyRLP9hLlGEXbiX9sIcN2glqsjFtjczr1RqpASkMehG3fBZPLK7S70Lf/Aofg
 8aU6mWo1fTqBe4fKqi+0IYuvkZnsCizuGbFvikMkUGFjt4NqELFBSzW3I56FE0TZhlXG
 QNFxdBJSdZhgiuwwcJhKJri/FgxuhRjEglWe8JQ6YIBBn10bwYrilIKXnj8I67JMXva2
 HGTs2U4DFNhVl1kA/JMKposfn/1xDdnoQC0MTBNy9TB7pWFuKWO/8PEB26TmylyP6kn2
 HfXw==
X-Gm-Message-State: AOJu0YysiZ5Z2QGoVOvvogH5m3QJG1/HJOldVAjmRQQj+gwIoq1JEbfO
 2mP85TfQk95aExJeLlacN2VyVswPLmdvGFAUUb0wPtLTt1wSky1aARD9iH0qBWAO
X-Gm-Gg: AeBDieuP/jCPW4KrM0RoBANH5p3rZ8PiCm4NyOdjsbWTUKpvHY7rEweRNKJW7VZgq7C
 hFDHgeGJXjpbdmdXp1XDiVRskbheMpmjoTj+gT/yi+PgvK/0/X/Dv4hYmKQ5nUDGMSDqY3Ouka4
 Y0hfWT/KkUHIi6djuo7tO+/AuIhMDSpLXrx/NNwhJY5QpTJpt0RNfzl9MEuFLnnxOaLIw93hbj/
 9w53BTQr/qXQsmv8rENb9Oy1mGqf4fN1/zWewLBEiQ38cVDKKOShb+BMQmNX450qzH8hjAIFER4
 qJTuZ6M1ZlGCZMLcJkHMLe6l3c/jlCfgus00WDHre0/r9PBTzpAbA3/In/uaIgAN+X2WnMTBPBX
 fiMcbhsbf1MHkqrkaiYx8ErkE+U6gpXM4XMOGBlNb3QCyM+dmRhyh7BeGwVr1LIeU1FnjFwkB8h
 8lzglQsOZ0l4mZWmYBkldo0IrKo7BrtdssKLNLlTtDoeR9HKPmL2XKROA=
X-Received: by 2002:a05:6122:20a2:b0:56b:814e:d35a with SMTP id
 71dfb90a1353d-56fa58fc2c7mr13270256e0c.8.1776954350764; 
 Thu, 23 Apr 2026 07:25:50 -0700 (PDT)
Received: from cethr-l01.localdomain ([136.56.120.109])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b02aa4f1f9sm157183266d6.0.2026.04.23.07.25.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 07:25:50 -0700 (PDT)
From: Caleb Ethridge <jcethrid@gmail.com>
To: u-boot@lists.denx.de
Cc: malysagreg@gmail.com, trini@konsulko.com, linux@analog.com,
 philip@philipmolloy.com, sjg@chromium.org,
 Caleb Ethridge <caleb.ethridge@analog.com>
Subject: [PATCH v5 09/15] mach-sc5xx: Update image load address
Date: Thu, 23 Apr 2026 10:24:44 -0400
Message-Id: <c3d7aaf8ae4f70a19f66837ab987f51fbe91387d.1776954004.git.jcethrid@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1776954004.git.jcethrid@gmail.com>
References: <cover.1776954004.git.jcethrid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 25 Apr 2026 22:36:28 +0200
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

From: Caleb Ethridge <caleb.ethridge@analog.com>

Update the load address for the image in
each environment to match the updated partitions
in Linux.

Signed-off-by: Caleb Ethridge <caleb.ethridge@analog.com>
---
 board/adi/sc573-ezlite/sc573-ezlite.env         | 2 +-
 board/adi/sc584-ezkit/sc584-ezkit.env           | 2 +-
 board/adi/sc589-ezkit/sc589-ezkit.env           | 2 +-
 board/adi/sc589-mini/sc589-mini.env             | 2 +-
 board/adi/sc594-som-ezkit/sc594-som-ezkit.env   | 2 +-
 board/adi/sc594-som-ezlite/sc594-som-ezlite.env | 2 +-
 board/adi/sc598-som-ezkit/sc598-som-ezkit.env   | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/board/adi/sc573-ezlite/sc573-ezlite.env b/board/adi/sc573-ezlite/sc573-ezlite.env
index 36bd207f410..4ee08deb1b3 100644
--- a/board/adi/sc573-ezlite/sc573-ezlite.env
+++ b/board/adi/sc573-ezlite/sc573-ezlite.env
@@ -4,7 +4,7 @@
  */
 
 jffs2file=adsp-sc5xx-__stringify(CONFIG_ADI_IMAGE)-adsp-sc573-ezkit.jffs2
-adi_image_offset=0xe0000
+adi_image_offset=0xd0000
 loadaddr=CONFIG_SC5XX_LOADADDR
 
 #define USE_NFS
diff --git a/board/adi/sc584-ezkit/sc584-ezkit.env b/board/adi/sc584-ezkit/sc584-ezkit.env
index 9336fc4e59d..bdfc0f037bc 100644
--- a/board/adi/sc584-ezkit/sc584-ezkit.env
+++ b/board/adi/sc584-ezkit/sc584-ezkit.env
@@ -4,7 +4,7 @@
  */
 
 jffs2file=adsp-sc5xx-__stringify(CONFIG_ADI_IMAGE)-adsp-sc584-ezkit.jffs2
-adi_image_offset=0xe0000
+adi_image_offset=0xd0000
 loadaddr=CONFIG_SC5XX_LOADADDR
 
 #define USE_NFS
diff --git a/board/adi/sc589-ezkit/sc589-ezkit.env b/board/adi/sc589-ezkit/sc589-ezkit.env
index a4a686158ca..6f314542ecc 100644
--- a/board/adi/sc589-ezkit/sc589-ezkit.env
+++ b/board/adi/sc589-ezkit/sc589-ezkit.env
@@ -4,7 +4,7 @@
  */
 
 jffs2file=adsp-sc5xx-__stringify(CONFIG_ADI_IMAGE)-adsp-sc589-ezkit.jffs2
-adi_image_offset=0xe0000
+adi_image_offset=0xd0000
 loadaddr=CONFIG_SC5XX_LOADADDR
 
 #define USE_NFS
diff --git a/board/adi/sc589-mini/sc589-mini.env b/board/adi/sc589-mini/sc589-mini.env
index 2a322bc6761..c5ea555411e 100644
--- a/board/adi/sc589-mini/sc589-mini.env
+++ b/board/adi/sc589-mini/sc589-mini.env
@@ -4,7 +4,7 @@
  */
 
 jffs2file=adsp-sc5xx-__stringify(CONFIG_ADI_IMAGE)-adsp-sc589-mini.jffs2
-adi_image_offset=0xe0000
+adi_image_offset=0xd0000
 loadaddr=CONFIG_SC5XX_LOADADDR
 
 #define USE_NFS
diff --git a/board/adi/sc594-som-ezkit/sc594-som-ezkit.env b/board/adi/sc594-som-ezkit/sc594-som-ezkit.env
index a4c72f2e9c7..4d86eafe145 100644
--- a/board/adi/sc594-som-ezkit/sc594-som-ezkit.env
+++ b/board/adi/sc594-som-ezkit/sc594-som-ezkit.env
@@ -4,7 +4,7 @@
  */
 
 jffs2file=adsp-sc5xx-__stringify(CONFIG_ADI_IMAGE)-adsp-sc594-som-ezkit.jffs2
-adi_image_offset=0x110000
+adi_image_offset=0x100000
 loadaddr=CONFIG_SC5XX_LOADADDR
 
 #define USE_NFS
diff --git a/board/adi/sc594-som-ezlite/sc594-som-ezlite.env b/board/adi/sc594-som-ezlite/sc594-som-ezlite.env
index e312fc95ae4..d374ebd5a54 100644
--- a/board/adi/sc594-som-ezlite/sc594-som-ezlite.env
+++ b/board/adi/sc594-som-ezlite/sc594-som-ezlite.env
@@ -4,7 +4,7 @@
  */
 
 jffs2file=adsp-sc5xx-__stringify(CONFIG_ADI_IMAGE)-adsp-sc594-som-ezlite.jffs2
-adi_image_offset=0x110000
+adi_image_offset=0x100000
 loadaddr=CONFIG_SC5XX_LOADADDR
 
 #define USE_NFS
diff --git a/board/adi/sc598-som-ezkit/sc598-som-ezkit.env b/board/adi/sc598-som-ezkit/sc598-som-ezkit.env
index 754dcece976..cbc5a57c755 100644
--- a/board/adi/sc598-som-ezkit/sc598-som-ezkit.env
+++ b/board/adi/sc598-som-ezkit/sc598-som-ezkit.env
@@ -4,7 +4,7 @@
  */
 
 jffs2file=adsp-sc5xx-__stringify(CONFIG_ADI_IMAGE)-adsp-sc598-som-ezkit.jffs2
-adi_image_offset=0x110000
+adi_image_offset=0x100000
 loadaddr=CONFIG_SC5XX_LOADADDR
 
 #define USE_NFS
-- 
2.34.1

