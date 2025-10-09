Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 730B7CCA470
	for <u-boot@archiver.kernel.org>; Thu,  9 Oct 2025 09:30:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 325D58449D;
	Thu,  9 Oct 2025 11:30:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="g1x3r/9y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3BF5A844BC; Thu,  9 Oct 2025 11:30:28 +0200 (CEST)
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com
 [IPv6:2607:f8b0:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 214688447F
 for <u-boot@lists.denx.de>; Thu,  9 Oct 2025 11:30:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x132.google.com with SMTP id
 e9e14a558f8ab-42d8b15548eso3606535ab.2
 for <u-boot@lists.denx.de>; Thu, 09 Oct 2025 02:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1760002224; x=1760607024; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q64FUi8AYGfVIwyieLiuqa+c6LQc/p8K9TNv0pahPH8=;
 b=g1x3r/9yQmgYP6/fY0c4+RgKXegWedJEmvuMyCEjGYU67d6wp56f7udKKpiikTclGb
 PGjLrCzGLPCm+W7LTUjP9VxXIu9e8MWhg3fzjzgxaVM33giRKSdyN6gCcX7g9QJdbBnq
 2XwB4JV42G+7UUvYnbl3b8nnhljCHCMXdgZkk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760002224; x=1760607024;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Q64FUi8AYGfVIwyieLiuqa+c6LQc/p8K9TNv0pahPH8=;
 b=qn2fR1yYR+gK87oQKAr7aroX7gnE4FZNFZs7oCkBSN1+ZOqIwIe57xVyn+aKbal1P6
 eBVJCv2wF4j+yIuxGRjp8d9c9dHeQkkq8aCqYCm2dsMd9fPNdOlqQItbP3IB2QtdFkM6
 AZ192dUjVZQ4ZOOnmBiFAsEOXWkp2dh+t6/4yAaVky6s4lbRvd3ghhLwtVpd1N//6CfD
 NcZF9nAJG6IWVS8adYOxh7SMXWw+/+uqbemc5nltoh1mNfTmq9HxwTz8JwojmzFNmeTC
 w+vYhAqqTg7q2v+2tSxMphvfwjgqpWwHnF5SJcl1Rnod9J86ZNRfHmtyc8ZxzTmcQjey
 PS4A==
X-Gm-Message-State: AOJu0Yy7j/muhtYqVIcMWC80tqdIfEvcE0N7zjL1kGpoJ4Pjo+RZP0xL
 hqJVrOcfQcw/Vdret6hUaVLCAUJxWOStpqllb+F6y073XPBS8t67rAqXfkUOtkmcPfqwOqjNav2
 bRDou6P4L
X-Gm-Gg: ASbGncs+Ku4UlSaFuYwgYiiRnHm1ec0uTp+YDK5qCMQNQgS4GbYfz757JLmdT/LMGpA
 8WNyJnLPPwZzRg8lCGj7W5Vl9anwgdWU9qgX1kDQIUF+m6qxPrnp5PGldoQ8jSxQccPA9LE8sZj
 8Ttuu+l3kabxwE0+gj1wRBVCQoK+316u/by3krw9Ti2Ho39c0AJ+Rx5WT0DnzrUdAzioD9Bc7hx
 mYjjCcuOpcBPnmtRTii3dGS5MDbikS8f9uOKv+upObFchtTmHJJ+rVYcGke3+4/PgsJFQTF46+F
 IS55QGtuMtsCqhV+FhT8WvEq9L+CoQQB/Mh001hKXzUEvzb03WeLsi38Rl+rDszgZVmgyWo2x/s
 yK/Djq0gEEGkKQgGDEy0mM2NKnt+q5yf1yX6oVXbU
X-Google-Smtp-Source: AGHT+IGgRzRoDqs2N3WQnnaupVKeJ4sshxYpei0LKsfbFjDHAd+m4SxoJtTc3yH5MXXdr5o28RDYmQ==
X-Received: by 2002:a05:6e02:1847:b0:42a:cc5e:bde5 with SMTP id
 e9e14a558f8ab-42f873d12fcmr51754985ab.21.1760002223787; 
 Thu, 09 Oct 2025 02:30:23 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-57b5ea300f7sm7839341173.16.2025.10.09.02.30.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Oct 2025 02:30:22 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Peter Robinson <pbrobinson@gmail.com>,
 Simon Glass <sjg@chromium.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Maximilian Brune <maximilian.brune@9elements.com>,
 Moritz Fischer <moritzf@google.com>
Subject: [PATCH v4 3/4] boot: Add more debugging to iter_incr()
Date: Thu,  9 Oct 2025 03:29:54 -0600
Message-ID: <20251009092959.260121-4-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251009092959.260121-1-sjg@chromium.org>
References: <20251009092959.260121-1-sjg@chromium.org>
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

This function is the core of the bootstd iteration. Add some debugging
for the decisions it makes along the way, to make it easier to track
what is going on.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/bootflow.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/boot/bootflow.c b/boot/bootflow.c
index 78df09f369d..de69e27bec7 100644
--- a/boot/bootflow.c
+++ b/boot/bootflow.c
@@ -193,8 +193,10 @@ static int iter_incr(struct bootflow_iter *iter)
 	log_debug("entry: err=%d\n", iter->err);
 	global = iter->doing_global;
 
-	if (iter->err == BF_NO_MORE_DEVICES)
+	if (iter->err == BF_NO_MORE_DEVICES) {
+		log_debug("-> err: no more devices1\n");
 		return BF_NO_MORE_DEVICES;
+	}
 
 	if (iter->err != BF_NO_MORE_PARTS) {
 		/* Get the next boothmethod */
@@ -218,9 +220,13 @@ static int iter_incr(struct bootflow_iter *iter)
 			inc_dev = false;
 		}
 	}
+	log_debug("! no more methods: cur_method %d num_methods %d\n",
+		  iter->cur_method, iter->num_methods);
 
-	if (iter->flags & BOOTFLOWIF_SINGLE_PARTITION)
+	if (iter->flags & BOOTFLOWIF_SINGLE_PARTITION) {
+		log_debug("-> single partition: no more devices\n");
 		return BF_NO_MORE_DEVICES;
+	}
 
 	/* No more bootmeths; start at the first one, and... */
 	iter->cur_method = 0;
@@ -228,11 +234,15 @@ static int iter_incr(struct bootflow_iter *iter)
 
 	if (iter->err != BF_NO_MORE_PARTS) {
 		/* ...select next partition  */
-		if (++iter->part <= iter->max_part)
+		if (++iter->part <= iter->max_part) {
+			log_debug("-> next partition %d max %d\n", iter->part,
+				  iter->max_part);
 			return 0;
+		}
 	}
 
 	/* No more partitions; start at the first one and... */
+	log_debug("! no more partitions\n");
 	iter->part = 0;
 
 	/*
@@ -326,8 +336,13 @@ static int iter_incr(struct bootflow_iter *iter)
 	}
 
 	/* if there are no more bootdevs, give up */
-	if (ret)
+	if (ret) {
+		log_debug("-> no more bootdevs\n");
 		return log_msg_ret("incr", BF_NO_MORE_DEVICES);
+	}
+
+	log_debug("-> bootdev '%s' method '%s'\n", dev->name,
+		  iter->method->name);
 
 	return 0;
 }
-- 
2.43.0

