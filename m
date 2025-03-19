Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74E4FC35FFF
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 11:50:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CB39B81101;
	Wed, 19 Mar 2025 12:49:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RZ0kmhRs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B32878191C; Wed, 19 Mar 2025 12:49:58 +0100 (CET)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9379D810F4
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 12:49:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-39149bccb69so6605231f8f.2
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 04:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742384995; x=1742989795; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Vpnb9pKi9BRhfN7UbMZYTv0ooupVJicG8AKjkTArpgs=;
 b=RZ0kmhRsdAuDp7G3USzm258X/I9aYbCwNmYgC9NbY8MbAOXqv0f+7k1vl5zvpM4JnF
 QroORNXsoUGm3PHs4pfgTR/EAKXY/3+nxj3wlNLe1WzLM4OK0J6ClE7akUTkv5gGfFMN
 DBZdHOSHlZWbywQtu00e+VY5i1ncXpPJoLpPo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742384995; x=1742989795;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Vpnb9pKi9BRhfN7UbMZYTv0ooupVJicG8AKjkTArpgs=;
 b=HlVshy0u3v86gKwb9uyG4cDCbEHGeukk8JFO/ebVhAw9FkClR8G4nc4OszBfVYTkLJ
 VHRxDcY1vo+bnBxbRv3RhDvGb3TIbLos2DXwnjsnUjDYzSp/dtJhYFzN1NL24APiyNOj
 90Z8SeozrdZvzivogJ0XJQ5nZ6UV1Fb4M2JUaMPoKXUPQUxwpHFtD0YH1Ryx5/qao4FH
 Bb0WZ7LWcGki3buVDzpE3/IH6nlK6FUxhhURjHC4ymWYfQMigzjioztSmmc0m3O3JtPl
 e8xLMPlSi6o+s85be1xRuWd0pdOKWpMPzVa9pumqcDvK8xRLk59wCtoqW7upbP0hZghx
 5obA==
X-Gm-Message-State: AOJu0YxH1sXypENxr4shjxwN07c11WW7YJjXrn04IkywevwOHQgMgrX3
 fV6ioTfWfgpqL33567lTf79Xxkc2PZ49EavUtlGlDjdLj+/n7NK9guXPsS/d9u/oJHyXS4mOvHe
 6nvL2
X-Gm-Gg: ASbGncs1xbpbGbvn2c1OzO0Gi38Utk7Nj/JFcBupsyWrKF6LpF2ePYFBwwrnoUtWqzQ
 ILwBk+PitSbwaYcUlLZ4Rz/LrosWAIsyF/WDC/9UngMPEJsIUe2CYpS272fmOE3RPJw8wrg2UoM
 7glVVZuhTnPPAMAt/P0TPOd32uOW87zcriSDuqcAMbQ/Ps3599JSwfnyWPdK5LOFQwO1OqIougf
 tpYaaEJzv8oQJ2hFtNdwMO7Oa1QqZPdBC3gIBqx+SxfbvoKSSB9U2PRGIDEU+cHuxr9vWWv2X2S
 LIUZwWaIsdpfjWjIKcbB1boNRtWkChQGKdZqjVqlgQ==
X-Google-Smtp-Source: AGHT+IEhKz+kcGLz7/AdOzMr6IpK6PgBXRz2o9bfS1aD439B7MIXew9eQ1ZYV/gj+KbUrUc+b2G8Xg==
X-Received: by 2002:a05:6000:2712:b0:391:4390:97e3 with SMTP id
 ffacd0b85a97d-399739de4bcmr1935011f8f.33.1742384995402; 
 Wed, 19 Mar 2025 04:49:55 -0700 (PDT)
Received: from chromium.org ([169.155.233.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d43f855efsm16539905e9.34.2025.03.19.04.49.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Mar 2025 04:49:54 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH] log: Add helpers for calling log_msg_ret() et al
Date: Wed, 19 Mar 2025 12:49:27 +0100
Message-ID: <20250319114947.2188805-1-sjg@chromium.org>
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

Logging of function return-values is used very frequently in U-Boot now.
Add a few helper macros to make it less verbose to use.

It turns out that the log_ret() variants are not so useful, since it is
not obviously where the error is coming from. So only the log_msg_ret()
variants are worthy of these macros.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 include/log.h | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/include/log.h b/include/log.h
index 4f6d6a2c2cf..bdda7af570c 100644
--- a/include/log.h
+++ b/include/log.h
@@ -380,6 +380,32 @@ void __assert_fail(const char *assertion, const char *file, unsigned int line,
 #define log_msg_retz(_msg, _ret) ((void)(_msg), _ret)
 #endif
 
+/*
+ * LOGR() - helper macro for calling a function and logging error returns
+ *
+ * Logs if the function returns a negative value
+ *
+ * Usage:   LOGR("abc", my_function(...));
+ */
+#define LOGR(_msg, _expr)	do {		\
+	int _ret = _expr;			\
+	if (_ret < 0)				\
+		return log_msg_ret(_msg, _ret);	\
+	} while (0)
+
+/*
+ * LOGZ() - helper macro for calling a function and logging error returns
+ *
+ * Logs if the function returns a non-zero value
+ *
+ * Usage:   LOGZ("abc", my_function(...));
+ */
+#define LOGZ(_msg, _expr)	do {		\
+	int _ret = _expr;			\
+	if (_ret)				\
+		return log_msg_retz(_msg, _ret);	\
+	} while (0)
+
 /** * enum log_rec_flags - Flags for a log record */
 enum log_rec_flags {
 	/** @LOGRECF_FORCE_DEBUG: Force output of debug record */
-- 
2.43.0

