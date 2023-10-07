Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6BFEE95A67
	for <u-boot@archiver.kernel.org>; Sat,  7 Oct 2023 23:26:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F5A886F43;
	Sun,  8 Oct 2023 01:16:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EPJCB/G+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1378186EDF; Sun,  8 Oct 2023 01:14:29 +0200 (CEST)
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com
 [IPv6:2607:f8b0:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CFA2386F0D
 for <u-boot@lists.denx.de>; Sun,  8 Oct 2023 01:13:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-353c3c21761so6666935ab.2
 for <u-boot@lists.denx.de>; Sat, 07 Oct 2023 16:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696720400; x=1697325200; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JPiSJypWnexMQC24TfdtaO59cIj1LzIK/Zd4rdf5JME=;
 b=EPJCB/G+aPLPz5117KgRavCkdW2M6bdLSnfu06Jcu86joBGP8KSFlJzMxmT88tfqmV
 gMagIkG2DfUZixsykt0CHRMJhEuyhEsB9VMpPzHcxtel/qawKE2iuKEzsNw/KBCvDGdN
 zF3JkbAf8tozQhGdw9pn+0tcAXd2c9s2JNul4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696720400; x=1697325200;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JPiSJypWnexMQC24TfdtaO59cIj1LzIK/Zd4rdf5JME=;
 b=ka/3fEYnA0/b5/l/1k4sAYB/DStGXnZCSX1CEMDQ/TvmENYnvIjrhYsiT1JEUFZWPT
 32tNzIAMDacpcFsEctMT6lSaTr87hVitQ0n0CG6xMzNIytJwtXFupnFkGJ0FqX064Mxj
 Pxpx1qBvy4CDOaUkRVx6t9xzTLHsKwZ2qhJZG1PoxJxhA+GxSyaJ/gUOiCMt1vmWqXno
 XW0ZVkwhH5UhtWTTKxprTpTmss1wRKUl744Se3Ea1iaGLcg1RmKOi1uXCzzeQofjfP6h
 4jpWENqCs5+HuR0LDa1zNR4J4Fdabneg7HnYj4FqxaIrh654SGS6dZXHS82qZbLzGGRK
 yOQQ==
X-Gm-Message-State: AOJu0YyEbDYy2o8chhM8wbJImTEAlA3SAMDKghXE24qYRTMXCD7Dy67f
 5x3hlnRfk0sXw0iWcKjWH75xxzqGDa0lYiR4H6w=
X-Google-Smtp-Source: AGHT+IGrnpjf67cavUy6v6MjZUSUINK6RzuKmJROHog9o4p4v0S/lvpO4/1g43PS1qxEglJ/ujJxqw==
X-Received: by 2002:a05:6e02:1a2c:b0:351:20f4:3a28 with SMTP id
 g12-20020a056e021a2c00b0035120f43a28mr14784791ile.0.1696720400343; 
 Sat, 07 Oct 2023 16:13:20 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 x7-20020a92de07000000b0035129b9c61bsm2002320ilm.45.2023.10.07.16.13.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 07 Oct 2023 16:13:20 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Anatolij Gustschin <agust@denx.de>
Subject: [PATCH v2 20/27] video: Allow use without CONFIG_CMDLINE
Date: Sat,  7 Oct 2023 17:12:39 -0600
Message-ID: <20231007231255.277623-21-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
In-Reply-To: <20231007231255.277623-1-sjg@chromium.org>
References: <20231007231255.277623-1-sjg@chromium.org>
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

Provide a fallback for when CONFIG_SYS_CBSIZE is not provided, so that
the console can still be used.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 drivers/video/console_truetype.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/video/console_truetype.c b/drivers/video/console_truetype.c
index 0f9bb49e44f7..8186b5b49f0b 100644
--- a/drivers/video/console_truetype.c
+++ b/drivers/video/console_truetype.c
@@ -124,7 +124,11 @@ struct pos_info {
  * Allow one for each character on the command line plus one for each newline.
  * This is just an estimate, but it should not be exceeded.
  */
+#ifdef CONFIG_SYS_CBSIZE
 #define POS_HISTORY_SIZE	(CONFIG_SYS_CBSIZE * 11 / 10)
+#else
+#define POS_HISTORY_SIZE	(250 * 11 / 10)
+#endif
 
 /**
  * struct console_tt_metrics - Information about a font / size combination
-- 
2.42.0.609.gbb76f46606-goog

