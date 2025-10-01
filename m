Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DC3FCAC5BB
	for <u-boot@archiver.kernel.org>; Wed,  1 Oct 2025 20:31:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C12CB83677;
	Wed,  1 Oct 2025 22:30:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="iuMLNx2H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BDF1083677; Wed,  1 Oct 2025 22:30:49 +0200 (CEST)
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3FD9C83653
 for <u-boot@lists.denx.de>; Wed,  1 Oct 2025 22:30:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-79f79e37c04so206818a34.3
 for <u-boot@lists.denx.de>; Wed, 01 Oct 2025 13:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759350646; x=1759955446; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=s+nISNa/5FGYCYG4NyxsSxloYycwO/StG1eZRNy442g=;
 b=iuMLNx2Hi5ET5GcMWdJtDRF31kvtH1Xm8DqIs3jBjNoAXRL8DBw8Nq0vkcMu7+mo+Q
 J4fxc4HptEWc6ATOPj6sz8LBzgjG2Duuy+0blJnT36uJFl/lFE921u1X5L0s8WD06v/O
 LncWyN4gv1AZquZw7jinSCDyfC7yNi/ESnP9w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759350646; x=1759955446;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=s+nISNa/5FGYCYG4NyxsSxloYycwO/StG1eZRNy442g=;
 b=qJvtmCrXl/KGQ1kRX89kDvulWaHtgW+EHoqTZrydam6vDtYPWWfZkjWUtmCh6CV0LK
 XiLgpTPH2aqi2WmClcfYtOPB9zXx983RtEKF0FsUR+xW2PY/ZHjwaesUv9SrEsVYLpw6
 HYy4fTvvHJYYAJxH+G70nDabsQ65Hqgpn2YerocG5BJyES2USvk+4+Sjo0yTyWmwuSo8
 dn+LU9kzW+Jf+a8h/SmTWHBdzx4nnU640EyiBnByMuG8S8IKiHmSyD+xSzvdLjPllD17
 7wFdGNFj4Oziv/m6JZc6cO+i8nH/6sHqDrrOGWBcP/gVhXXISWLkt6jqb5vfiliu+UDm
 3jdw==
X-Gm-Message-State: AOJu0Yw1JAsPJPLw/sb694WfGorY9ciiKzAWTbr5JSGc381fHPbJHBGA
 WI7220ok1fq8Kb+f3yFJaLZQnJrdTWlnK388yc6whbxQFeB1IxNrhYJ8sYdY6yNKvW+UinzUslT
 JyGDtS48=
X-Gm-Gg: ASbGnctA1t/6F7QO2csZrTc1C412lyEuU2j6pqX1TzlCCI4IHkgZbkKv4dPxIoRTrhw
 9v8wfsSoU89OWpYlzso05deALlqiRwvisFP5zzlfGtbQa6wL4E8TdYkOCAKbX0D4ekzHZAIkDgz
 jVVvjLwBnCWGO7gnpIkjoBFZ078Faw7p8d0gSIIN7SdNzjGwoVf0IQt/eMxWCKl9/BNIgzjuXqe
 PytcK6EdDnCkuNh57dOEz0nX/wpWY+Tswn3lCwHQLxwY7r9LULhn9//wv6qkBYMgdaQ8Dlb6phN
 LT8Hg0UNGJRVtCP66Y11AY+Sey9wKk94LaMRuxS5lkYYcMUmt6wa7Mq/FyBdmrNFYqA/7d58gVb
 WgxgwaE2xXRjNcJrvW8NgMe8YOkPEtwBqoePnjwK6xgVWifrppGtmO/lAT62jdQdmjt/Y8RO9MG
 vccweqzcs=
X-Google-Smtp-Source: AGHT+IHt7plHA/2MRNifC9TFwV2sWSuFvZ3TxSDRE5jfvCLIbp8Mp5SjhEXFbU9XDehnhk3nZnV7+w==
X-Received: by 2002:a05:6830:d09:b0:7af:f401:f8b4 with SMTP id
 46e09a7af769-7bddb9ddcfemr5177556a34.18.1759350646006; 
 Wed, 01 Oct 2025 13:30:46 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7bf3f610041sm123471a34.3.2025.10.01.13.30.45
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Oct 2025 13:30:45 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] video: Add SPL_VIDEO_SYNC_CYCLIC_MS symbol
Date: Wed,  1 Oct 2025 14:30:44 -0600
Message-ID: <20251001203044.2828394-1-trini@konsulko.com>
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

When compiling video-uclass.c for SPL and with SPL_CYCLIC enabled, we
also need to know SPL_VIDEO_SYNC_CYCLIC_MS as a value. This is most
easily resolved by adding a symbol to set this to the value of
VIDEO_SYNC_CYCLIC_MS as one shouldn't ever need these to differ.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 drivers/video/Kconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 0fc1c161541e..d8c58086eb48 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -285,6 +285,11 @@ config VIDEO_SYNC_CYCLIC_MS
 	  improves the responsiveness of the command line to new characters
 	  being entered.
 
+config SPL_VIDEO_SYNC_CYCLIC_MS
+	int
+	depends on VIDEO_SYNC_CYCLIC_MS > 0
+	default VIDEO_SYNC_CYCLIC_MS
+
 config PANEL
 	bool "Enable panel uclass support"
 	default y
-- 
2.43.0

