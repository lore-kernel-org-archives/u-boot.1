Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71476F43697
	for <u-boot@archiver.kernel.org>; Fri, 17 Apr 2026 12:51:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 154FB84485;
	Fri, 17 Apr 2026 14:44:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="I5y6tMUu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A3F0384214; Thu, 16 Apr 2026 17:20:25 +0200 (CEST)
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com
 [IPv6:2607:f8b0:4864:20::f42])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 903FD840AB
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 17:20:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jcethrid@gmail.com
Received: by mail-qv1-xf42.google.com with SMTP id
 6a1803df08f44-89f1e767f92so64347616d6.2
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 08:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776352822; x=1776957622; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=auDUwgjF6PBTzkdpoV01ML94EU0dbMvmyHe2ja4j5fw=;
 b=I5y6tMUuzKxKuceRJU42z+hpafQaDL/fTpSWhPn3vFm3qvWEPq2gQ3cYlIoWBCwA1c
 wy2jPGW0KFlMlD4uX6Zr5Zr18H8D9nVY8sbu0bnbg9j6XqSUeGs80TSzrRJFsvK6RE8V
 3045wn5tK+Sxli4+aVmYstHVUj7E2vO2rOgZw+OqdZOVECunVvGuxTNZIsq/r62B1dD4
 NpEtkGfHFxitpVuMB9hOmEyFgHpOCdp2iouNLGlS2Qgs+lIrnZvEDlrcZ0bYLO62VVB/
 BFWFu4gITCb5EpNhzREzh3QN3NNvntJ7liz1eV+APU4ROp3qYYL9DpUCDO+TBhHB5fi6
 ZyIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776352822; x=1776957622;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=auDUwgjF6PBTzkdpoV01ML94EU0dbMvmyHe2ja4j5fw=;
 b=EA5FsZ/BKb3XtiMzvfz9c0xRmTJ3ezRFCkkKNMXEPT4OM10MFVGzCtmJ7IfSuOkGAr
 yEXfe9u+It2go2QHSn47AfSyY9kyNUnAHiZML2isLUB9EezFSpj3yBF9nebxvq6SXkN8
 yYhIGHOuRf4XVIDsKXRcjeR6DZH+rYaQbDM8QrzpyHZvYrHBRefR/mCuIHPA8wq9AbZV
 OR/NrIvSdriEkdJCLT4ouEySraA3LoFDeElaw4V+3hH7AaQGGZsDoBXvcS8ubsg4dpK7
 n5kl2GA1G48nOcM0MKPy82OYbE8OBupWZO1ob8Ma5DIfZBmZHncTwUpPCpVxcY0Wop1k
 e+3w==
X-Gm-Message-State: AOJu0Yw910U9ihDtLjIBxWBiP8mOmyCByfJ3qBMu8WStxLm8wBV6p7dG
 OJImfn3sbdvC+TWcczyimcVcjJz45NIEfqyKYeVcN2rAaHWH1f6RLYmAgb4GsSDq
X-Gm-Gg: AeBDievqa06a5PxvXRm/tOUTJAxYyU9u07WeuxTMFs+PxFfQJIPaHkjJ0jLWOrX3faL
 XMx+4GsgcGaNj8VuNw9L0DF62ZUc2APtoJAVd+14QsAv18C7eh+2VzcWdQ6ELY08TcHkkTSzfdx
 TtUZ3Kom907Fcf/iRYjEzHf9Ix79s5HOWiNXSsMBEFZN8n2Em79vKLu0pLGurr/G2tKNC5Yr5q8
 kvS5Q9I/9GqlkrKHR4u1LimgEg8lpYhDqeuhJJRZ90B7+oR591YFDPy4wFIpUlh1ATsdcTeAcxO
 sAspJdZa6iD7rSHVR2FTRXZ9Lqj0JwEdzFHFshuXLzuku5gbheSIZ1HeGJ6Hm3EpkyIQ4LxCakI
 2cDrXDyTfoxbD5uWghERNPzhEdPxLRguKj/Rlf2dtc+xUGLTokGSMDt4E36tV/1Fn7XVO2opGDV
 EcXcDBRdRpcVfVYt9mUTs+Nf/FV9ezszlOww==
X-Received: by 2002:a05:6214:4409:b0:8ac:b4d5:50e8 with SMTP id
 6a1803df08f44-8acb4d55c77mr229469886d6.26.1776352822230; 
 Thu, 16 Apr 2026 08:20:22 -0700 (PDT)
Received: from cethr-l01.localdomain ([136.56.120.109])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ae6c93b7e2sm38561586d6.8.2026.04.16.08.20.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 08:20:22 -0700 (PDT)
From: Caleb Ethridge <jcethrid@gmail.com>
To: u-boot@lists.denx.de
Cc: malysagreg@gmail.com, trini@konsulko.com, linux@analog.com,
 philip@philipmolloy.com, Caleb Ethridge <caleb.ethridge@analog.com>
Subject: [RESEND v4 09/14] mach-sc5xx: Update image load address
Date: Thu, 16 Apr 2026 11:19:44 -0400
Message-Id: <ae8a42e7a46b728cb9df22a9f47eda3192e13158.1776344788.git.jcethrid@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1776344788.git.jcethrid@gmail.com>
References: <cover.1776344788.git.jcethrid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 17 Apr 2026 14:44:25 +0200
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

