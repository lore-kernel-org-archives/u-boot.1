Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 391A5F46C79
	for <u-boot@archiver.kernel.org>; Mon,  6 Apr 2026 19:47:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16E728418C;
	Mon,  6 Apr 2026 21:46:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IKPnYv+m";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3070783936; Mon,  6 Apr 2026 21:21:45 +0200 (CEST)
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com
 [IPv6:2607:f8b0:4864:20::f41])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1374D8352B
 for <u-boot@lists.denx.de>; Mon,  6 Apr 2026 21:21:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jcethrid@gmail.com
Received: by mail-qv1-xf41.google.com with SMTP id
 6a1803df08f44-8a4b8c3a30bso58581696d6.3
 for <u-boot@lists.denx.de>; Mon, 06 Apr 2026 12:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775503302; x=1776108102; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=auDUwgjF6PBTzkdpoV01ML94EU0dbMvmyHe2ja4j5fw=;
 b=IKPnYv+mnsyENx9ajM8RfgTWO9Ph0eP+KPfDoNQ5yl+ziuPyvCl6JD0PKUIA5+CCJf
 sFNUyQnApesxosFibwZJXng+k1Kyj4Vzws9AztfBNDLNzC9Cyf0sYfe5M9mT2YxLCIuF
 t2PetvoUgdZiV8iwpaV00gP6+H8HuiYk94HpB7DKElPV7g0vq0lBxKu/Vt82jnwtKJ0H
 Ud8RWmoentzVc27UpoOvf7BJp7wvFRDyXo98fOioLpy2lfPZ+fm7XsuPU/zIHbx9ytyx
 Qm4j5EFkMNmtScm+1rFMzWnDtCnc8VAabfN8IvePg+rI+4+ypqBii2IsH2sHo24RRQs7
 nJ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775503302; x=1776108102;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=auDUwgjF6PBTzkdpoV01ML94EU0dbMvmyHe2ja4j5fw=;
 b=rp0g9kbLV5t8OjdpIubAAJQFd2BY6mS1XoghAB+0cCXfMGpLUFSDhEgpSH8RCn5u4b
 nT0wDYke+SxeDOCk6rA6YB7Te6vlNDjY0mNYnIEmlnO1DtqlY55ILA1Hlq2UuiPTEbeO
 hXQo3OQRkRh4SoQdgx58aERsm0Rjwgwl99XxHPBHnJSavUoNjcTZvpicN3eD31sM8+rr
 tMvz6d+5T2oNHN1P5z/beHnQbqwwVeByoaCJZf/ZWCmBULvZgW4ZnYbCn/t3DMAR6mfg
 MW+55vPlNa21EVresGbcXrfqc2ghT96Qa4Yp7e52adj15BoGya6fexE/rx8FzKnMlJx1
 PDkg==
X-Gm-Message-State: AOJu0Yzlkl1433CADGlYs16MMMgXfalEssHz9v515GPnMdHHoNbmeUAw
 k5I6bBj8PDjvQtyuRfmORIcn8HWedTqsW11Lq3/VwN6DLQxCb4FONdMcsrHOGwkW
X-Gm-Gg: AeBDietbBBcPzYCgVXCOeOL8fMxYmWJKwoEK05hs6Aj1rK2Uzy3qjL3LaD4VlqQ1asl
 dkiNOWxkd5W/Pp4SYJBPuZSEZnyYjFwaD65D6v17r50u39Uyx1OHxdaAhQGFcrGSmVIJnhkliFx
 8XkoXvdBfHlV1x2OfNyA407VwpJX3TTR1zueGiMUZnzMLhJ1YVud5DhYy6mN56Kas2yL4GxSVzW
 UIxGq7jhhGYlYBbrLCwOp6D61ZoTB5zeI4fdBttR4nynsUsyHK4+Ipwa0Y1Y6FRY63GhbhsP89m
 mjW4bCuc/1PNGnnJl3Jg0uPkEKG9uM0oFuVi49qJptvr+yRvSCb5pEwFyDPOymKwYNNPdrN2639
 MGrmj4p9P/gp5VrzluzzIebFllPWtbjoZ2Upj4e9lAeRK2szGpjwH+X6AeyHg2iDFKoFbEWLyy8
 7KFMGEz8JLZBKm6MsizJHAP+/bnuG+q1TICQ==
X-Received: by 2002:a05:6214:8082:b0:8a5:fced:6af2 with SMTP id
 6a1803df08f44-8a7040fd56dmr197047636d6.38.1775503301858; 
 Mon, 06 Apr 2026 12:21:41 -0700 (PDT)
Received: from cethr-l01.localdomain ([136.56.120.109])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8a596e03dc6sm150191166d6.34.2026.04.06.12.21.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 12:21:41 -0700 (PDT)
From: Caleb Ethridge <jcethrid@gmail.com>
To: u-boot@lists.denx.de
Cc: malysagreg@gmail.com, trini@konsulko.com, linux@analog.com,
 philip@philipmolloy.com, Caleb Ethridge <caleb.ethridge@analog.com>
Subject: [PATCH v3 09/13] mach-sc5xx: Update image load address
Date: Mon,  6 Apr 2026 15:06:11 -0400
Message-Id: <0cf685984703ebfae74d8ce928b9782edf5e9d54.1775500819.git.jcethrid@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1775500819.git.jcethrid@gmail.com>
References: <cover.1775500819.git.jcethrid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 06 Apr 2026 21:46:28 +0200
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
index 6d4b20d70f6..20e5ee0eb76 100644
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
index f915175e041..bfce3a9c9b0 100644
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

