Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E2D5CAC5BB
	for <u-boot@archiver.kernel.org>; Wed,  1 Oct 2025 21:30:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A66483621;
	Wed,  1 Oct 2025 23:29:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Vdgxyt7n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6311A83621; Wed,  1 Oct 2025 23:29:43 +0200 (CEST)
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com
 [IPv6:2607:f8b0:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B07A7835FE
 for <u-boot@lists.denx.de>; Wed,  1 Oct 2025 23:29:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-42d8ad71a51so4351765ab.1
 for <u-boot@lists.denx.de>; Wed, 01 Oct 2025 14:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1759354179; x=1759958979; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T756nKl/ZMkcKp4lXQ7Cq9k6RZjWrGUphyE7x9sVBoE=;
 b=Vdgxyt7nhXVlbEANGjXGP/kUvnVtUkD6dfzWFVuo0p53Ek4w+a8eTWa0CJksLeYvH5
 oJH6bRQAn9rMPohhz7soamneFMVoNw8mdM3EfyAaT13cfau6FvufPAa29CUMZMTJ7vpd
 wBLBKfO6zOZGxsmRdn9qhc2dJwq3BqZQpKVVM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759354179; x=1759958979;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T756nKl/ZMkcKp4lXQ7Cq9k6RZjWrGUphyE7x9sVBoE=;
 b=ubN/EpTkspbzPYIk+a4v6OSFDCEk8UXsrC17Vh2zrM8q8j203aqAXp8nhnnCOuNrgo
 u/Xco6j8Fxr5XUrecYqdX6ja+2jnalKp3G785EreuuX+daB7ntjaaSBHnrI2zIzMyjwr
 zk/pSaKPgDJY2UD1I3AsuUonjQgkgqHW8wuRgZ6S+dBo2EWqm9GT4uRIskGxW4zCkL3J
 DdrIGt/366uTGf2rf0/lLxFPSiB/eN5HsX7xOkJ4QTQ91cOoZEy4E8l7+VBFLFaM8VN3
 YXBGqCQxRu0sehN0FCgw4BPFwsk/f/j8OGwON0Uayy8+mnlur75ws0JT/fgGPs1OMKf5
 H55Q==
X-Gm-Message-State: AOJu0YyfhU8LGYObLDyHZcvA/YxArzb2802gcr/HhL5hDSDbf7DAzF8z
 OzqSFYcudLgypM6fSlqQYXjwI/Z/pUY1zt0fSEpYT/4rthCLAkvu16XT2zM+dS3NYqMzTTW30Bq
 v0l3CzvBm
X-Gm-Gg: ASbGncuMr5jspcrD2PZ1AWPr6Rm0yDQ5eoHZZ1ZLJQlqqWwu0OpyCc4oCE96+BqUsDZ
 QAh2n4BeU9BKbivR76LSMLPRLBvczAS/Rkppipf/xuhxKS+nMbuR2D1Xha6+jtIiOvqUteEC1D2
 ua+pTsO8u6k7yENQMTf/a0sPEy9+rUdhuPJHq5mVP9fli6aWlmCE6z6sDsRDq4TQsLlygteRiL7
 iKnzAsDL+HxWV6BX7DAMMa2YT9/LAqWVkx4rnQk6O2AJ1sc+n00A8Hx8mYYF9qZ6uJd8CnEySC/
 VT1aU7ql+xtV4n+JoqdMj+qQAfKgKBaI7q/mPcrE3A57dFI6V74j1FpdYPvZ+erqgDHXKGfTJTF
 sonq/95MH/wlxnL/BQvHJ1eRr7od5mGDBK36CQH+e
X-Google-Smtp-Source: AGHT+IFb63bOXdPmhAZTo3/Nl9l8/aN+e10j33MJedhWVG1CU9cH2sP6w5lZnWWHW4jQfmQVT2bHbA==
X-Received: by 2002:a05:6e02:1a23:b0:425:70c5:61b3 with SMTP id
 e9e14a558f8ab-42d81647952mr74786165ab.27.1759354178897; 
 Wed, 01 Oct 2025 14:29:38 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-57b5ec09429sm202844173.55.2025.10.01.14.29.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Oct 2025 14:29:37 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 04/17] boot: Add more debugging to iter_incr()
Date: Wed,  1 Oct 2025 15:26:29 -0600
Message-ID: <20251001212649.3263574-5-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251001212649.3263574-1-sjg@chromium.org>
References: <20251001212649.3263574-1-sjg@chromium.org>
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

 boot/bootflow.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/boot/bootflow.c b/boot/bootflow.c
index 5af3f6b3163..4595aa55f0f 100644
--- a/boot/bootflow.c
+++ b/boot/bootflow.c
@@ -193,14 +193,19 @@ static int iter_incr(struct bootflow_iter *iter)
 	log_debug("entry: err=%d\n", iter->err);
 	global = iter->doing_global;
 
-	if (iter->err == BF_NO_MORE_DEVICES)
+	if (iter->err == BF_NO_MORE_DEVICES) {
+		log_debug("-> err: no more devices1\n");
 		return BF_NO_MORE_DEVICES;
+	}
 
 	/* Get the next boothmethod */
 	if (++iter->cur_method < iter->num_methods) {
 		iter->method = iter->method_order[iter->cur_method];
+		log_debug("-> next method '%s'\n", iter->method->name);
 		return 0;
 	}
+	log_debug("! no more methods: cur_method %d num_methods %d\n",
+		  iter->cur_method, iter->num_methods);
 
 	/*
 	 * If we have finished scanning the global bootmeths, start the
@@ -217,8 +222,10 @@ static int iter_incr(struct bootflow_iter *iter)
 		inc_dev = false;
 	}
 
-	if (iter->flags & BOOTFLOWIF_SINGLE_PARTITION)
+	if (iter->flags & BOOTFLOWIF_SINGLE_PARTITION) {
+		log_debug("-> single partition: no more devices\n");
 		return BF_NO_MORE_DEVICES;
+	}
 
 	/* No more bootmeths; start at the first one, and... */
 	iter->cur_method = 0;
@@ -226,11 +233,15 @@ static int iter_incr(struct bootflow_iter *iter)
 
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
@@ -324,8 +335,13 @@ static int iter_incr(struct bootflow_iter *iter)
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

