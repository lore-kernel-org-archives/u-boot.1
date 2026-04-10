Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1508BE99058
	for <u-boot@archiver.kernel.org>; Sat, 11 Apr 2026 07:10:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AF69C8421E;
	Sat, 11 Apr 2026 09:09:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZdENAHx6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B7BA8414B; Fri, 10 Apr 2026 15:58:46 +0200 (CEST)
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com
 [IPv6:2607:f8b0:4864:20::842])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 129BF8416F
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 15:58:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jcethrid@gmail.com
Received: by mail-qt1-x842.google.com with SMTP id
 d75a77b69052e-50b3488fb31so25123531cf.1
 for <u-boot@lists.denx.de>; Fri, 10 Apr 2026 06:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775829523; x=1776434323; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=auDUwgjF6PBTzkdpoV01ML94EU0dbMvmyHe2ja4j5fw=;
 b=ZdENAHx6Q4TUnifBNohyCEmLQW7PY1HtbA2rxt4zsHd/js0P33ftODYjDc+C1bISQQ
 QIHmKqrxacDn4A8eb+rsgnqsbh7ml2ovlzZr1kQ3OCu55W9WtpIdNUeHIDk3eSU5n4Jm
 3lIA5/6r62r+tnqb274/f2mpb5gEFhZxCj9DTGfmbXUN7v7MuqKQihnEG2ygSGnzce/r
 9jx9iQK39lPDzivPiKy3PHgUesgmFld8Q3Kj1ZZxBZfP0yC6A3uIqT9L6O8cxy2aJ7if
 RSV6E2T/Efu6Wk6K9uvkLF64a6TlZC44DTDWOtkSSVMMtaBUmlQdqGawIvEhvRkCKEeY
 U+ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775829523; x=1776434323;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=auDUwgjF6PBTzkdpoV01ML94EU0dbMvmyHe2ja4j5fw=;
 b=JcoxWNx4foaX4ECT3lw6GVUNg2nYqC9MiHZG/q29dH/h2roNORlyTN6cEW3u+zOJGW
 OtywMxW5+Hmx1LHeyhfpNQsLxpYnVlcDquibnF8iiLiiZRpIQoGz6ixRLGcqHDCdUCl2
 SzQJlP5S2PmY4PMlE1v4yEFRrdpHCltyFKGWKfbFm0Wah+6DH0au/S4KhyNzGIlKn6l4
 lN6ulGvqLWP6gt5fhm+LuGtl7ihRa8zceg59UBLSU6QFY4YJRVMAa6aoxVpmAh4nVOfz
 ypJs8Lg9FAk6abeZCHxs7mHki+quivU6bQSPQN5Hv0vh1x4Ci+ki0vJKexrxAVCHcFRb
 XH/g==
X-Gm-Message-State: AOJu0YxgHt+pMN3qhl8kVnqbLx638ZfpFVVkfAyrB5loH9cAZ408vPYv
 uXh5tgtZsFC8ChEL/Ne8v4mf86frwqbts+AjfMSVR505OgzVIjcGPQ8rCQGFhrdX
X-Gm-Gg: AeBDieuxGw3bQAE/aR6zHoVosA+P/2b5I2QyjX2cKld4yQxZrpZgBoGziRuapwXrvSP
 /dq4RQzjfE0sv3bW0MhlfX/wflbrV0eppHDjWJGULbi4BbIw/mil8VgOi/ztNQInu8FgROxuIT+
 Tsg2Sabx7QscGLq1Nkpy73AsTTmcDrZt0zy3gCmsKeAypiDntsRYOY1io76WYRWD5MC7sSjj3Am
 KxvO2W0K/MgTBgDAbWotNjB1TCHsdIlbYAvV8L0xJlsL1fLUnq0CFd7Gy1xpwhyQBSvRNRfEmr0
 Q7DR/tfSHRONYwoP4bhwSIXVi3R3zT/cJcT91jFkRX1hgBrKtDS2t7cKJuJb7VWtL/rDLDTnFGa
 kqcwLzLE2PRE+Tv576R/NhbHAgLKkifMfPzf5XmupqzCmMDJixfux+le1lbRy9n80Ln7S0/DRMS
 AMs9rlRP9q+P5XIgRSQNldnoK8BkuA7uL4xw==
X-Received: by 2002:ac8:7fc7:0:b0:50b:54e8:399e with SMTP id
 d75a77b69052e-50dc1a1b0ddmr86656081cf.16.1775829522752; 
 Fri, 10 Apr 2026 06:58:42 -0700 (PDT)
Received: from cethr-l01.localdomain ([136.56.120.109])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50dd53f9c16sm21723141cf.11.2026.04.10.06.58.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Apr 2026 06:58:42 -0700 (PDT)
From: Caleb Ethridge <jcethrid@gmail.com>
To: u-boot@lists.denx.de
Cc: malysagreg@gmail.com, trini@konsulko.com, linux@analog.com,
 philip@philipmolloy.com, Caleb Ethridge <caleb.ethridge@analog.com>
Subject: [PATCH v4 09/14] mach-sc5xx: Update image load address
Date: Fri, 10 Apr 2026 09:58:04 -0400
Message-Id: <878575b4c2e72646f4a9e4de07b786816b8f1400.1775829166.git.jcethrid@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1775829166.git.jcethrid@gmail.com>
References: <cover.1775829166.git.jcethrid@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 11 Apr 2026 09:08:55 +0200
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

