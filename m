Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9EEBC35FFB
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 12:00:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E171A81D67;
	Wed, 19 Mar 2025 12:59:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="N2F7UZ4+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D02381A0C; Wed, 19 Mar 2025 12:59:38 +0100 (CET)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1974081951
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 12:59:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3912d2c89ecso6132159f8f.2
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 04:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742385575; x=1742990375; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JLuTyc5ph5bcSKJr0GzPpw0mobMKA9QhFP85FBodOhY=;
 b=N2F7UZ4+2kan5R233GdAyp0JnnK5DlTQZUYRXDxmAwWNmiwfNFKwu49nA3918bpyNl
 m9+wKE4rbmS6W9Ttyox9ubCuT0GYB3QOxlWuv8+gznSuEyjjHCcC3xWAvi3iH/n81xDI
 f0DZJrHltaoO+nN9skI5nfshSlwOK+u+fkf7Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742385575; x=1742990375;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JLuTyc5ph5bcSKJr0GzPpw0mobMKA9QhFP85FBodOhY=;
 b=wvDzZqQtBuX/B+GyoLrljSa4k6+zAmZatJv7vo6m6ZvzCWyL6XGx3d9AufoTSc9gUd
 ZsE/ke4mQ1D0FU+/OIGG+ZUGL3t9kPNk/5V1TAcrR5Bt/bbtG2RxZxax3JUea3x9haLO
 CZTUqMgry5wk9NaA4tCNAY5Vd3hRnrkcUFLRVZsat1P6GyBHVkIZ2lKFTD60metBtmra
 cMRqaZ90lkC//0NdKu09L48Olq0ZZh9cBTd0eZVUGc0SoeLC95H+rX1LTFWwSqSarkWW
 6+14/wfz5DNMNbQea5gOzTHG+IChXm6ICCkvCm3wifHrG5wEoEE2bJdE3oGFcgepbhjq
 HThA==
X-Gm-Message-State: AOJu0YwGPveHL2zo+4BO6QGs8/UdFOpemFe+akQ2Aq7r4A26dkYpYUB6
 DO0cmwa+Lge3OhHSLEg3INkS0X1Q/IEj1CV3FDTJg6o6csA092Kp1lz/E4KbOHWZP1ps2tfUy0S
 Urw==
X-Gm-Gg: ASbGncs4eelFvOt8wXpKjbBGW/5vYZMDIrFCXihehzWsqrRoytj/nQ3HjQ6Im+9i+kf
 VXo3Ft8lTXqFGg3sQFmwwETRpsq9cFLis47bASRSMtATHbrrdSBHj4AFeCWSqXgmlW2Hcj4DBUc
 eX86iqjzKB1scgiTNlzxNJlKKHMfEzrTyavaPxJYxQPdH3UlmbKuJu90w+d00VmDFmZ4R856e5G
 m1TWDJdoh/1BVIrOTny/4xKWgL9gKLSwYcQkubh9tG5gohejW2z2Lb40LRPykoqfu9pBkEWqvpK
 0+kTM9yi72mhbRqdi9aSKN26aV1Q2KDyCQpL2QZe/w==
X-Google-Smtp-Source: AGHT+IFPripcjQXI8s8pJ0asU6iXXf5+O3N6AiTFyBRQIKVQEBipgUazLyZLKYpTWJB5/GL9PER3IA==
X-Received: by 2002:a05:6000:1568:b0:391:3cf6:95fd with SMTP id
 ffacd0b85a97d-399739e5de2mr1986766f8f.30.1742385574993; 
 Wed, 19 Mar 2025 04:59:34 -0700 (PDT)
Received: from chromium.org ([169.155.233.10])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395cb7ea16csm20606906f8f.82.2025.03.19.04.59.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Mar 2025 04:59:34 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 4/6] membuf: Add an easy way to set up a buffer with data
Date: Wed, 19 Mar 2025 12:59:06 +0100
Message-ID: <20250319115911.2204045-5-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250319115911.2204045-1-sjg@chromium.org>
References: <20250319115911.2204045-1-sjg@chromium.org>
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

In some cases it is useful to set up a buffer with some data to read,
e.g. when reading lines from a text file. Add a helper for this.

Tidy up the comment for membuf_init() while we are here.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 include/membuf.h | 15 ++++++++++++++-
 lib/membuf.c     |  8 ++++++++
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/include/membuf.h b/include/membuf.h
index b495a72652b..f5c474cf730 100644
--- a/include/membuf.h
+++ b/include/membuf.h
@@ -222,7 +222,9 @@ int membuf_readline(struct membuf *mb, char *str, int maxlen, int minch,
 int membuf_extend_by(struct membuf *mb, int by, int max);
 
 /**
- * membuf_init() - set up a new membuff using an existing membuff
+ * membuf_init() - set up a new membuff using an existing buffer
+ *
+ * The buffer is initially empty
  *
  * @mb: membuff to set up
  * @buff: Address of buffer
@@ -230,6 +232,17 @@ int membuf_extend_by(struct membuf *mb, int by, int max);
  */
 void membuf_init(struct membuf *mb, char *buff, int size);
 
+/**
+ * membuf_init_with_data() - set up a new membuff using existing data
+ *
+ * The buffer is set up to contain the provided data
+ *
+ * @mb: membuff to set up
+ * @buff: Address of buffer
+ * @size: Size of buffer
+ */
+void membuf_init_with_data(struct membuf *mb, char *buff, int size);
+
 /**
  * membuf_uninit() - clear a membuff so it can no longer be used
  *
diff --git a/lib/membuf.c b/lib/membuf.c
index 016430ae988..347c92e3326 100644
--- a/lib/membuf.c
+++ b/lib/membuf.c
@@ -405,6 +405,14 @@ void membuf_init(struct membuf *mb, char *buff, int size)
 	membuf_purge(mb);
 }
 
+void membuf_init_with_data(struct membuf *mb, char *buff, int size)
+{
+	char *data;
+
+	membuf_init(mb, buff, size);
+	membuf_putraw(mb, size, true, &data);
+}
+
 int membuf_new(struct membuf *mb, int size)
 {
 	mb->start = malloc(size);
-- 
2.43.0

