Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36F77CCD187
	for <u-boot@archiver.kernel.org>; Sun, 12 Oct 2025 06:45:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E6A8D8388C;
	Sun, 12 Oct 2025 08:44:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BFlQZ7RW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0B7A9838F3; Sun, 12 Oct 2025 08:44:39 +0200 (CEST)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7BC48388C
 for <u-boot@lists.denx.de>; Sun, 12 Oct 2025 08:44:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-9335a918867so336316039f.2
 for <u-boot@lists.denx.de>; Sat, 11 Oct 2025 23:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1760251475; x=1760856275; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+aL47SSin52NIFLQElKihMorT2aRR8f63vRRvjlN03A=;
 b=BFlQZ7RW7lwbu/0sSucxMaFnF5Pr/87qgDkOCbkmqsxvq6fuHYIRlppfbwTB3Nv7j2
 +b7EtQ9bI2YPvdc3F2aI4Sq3PzeZ7IjACNdWK5ZEk61fHVWI3ZHCMG9pgO4OLTVKULro
 NOBAEW6Ovh2IxbwfTrnsFZ4BSyGUwCkiAPzOY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760251475; x=1760856275;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+aL47SSin52NIFLQElKihMorT2aRR8f63vRRvjlN03A=;
 b=QUMIGrFdKC06bOEUgwGrypIlYgS4o0eUZKlEeCuwEpNDpRTuF3pa/K7JPUY4eHS2zJ
 1Cuqea0nY9t3tLeJF9xpxFh8Oj5CXArkpsGibtJt+KqTc/Fm2P0iwTphma/gbrtn8rH8
 wkVwvIguIyDWzlyCSTqqVgqFwXj2+gbMSX4upGonCd7ASxFpX4rTtr5Ijql4niFuupeb
 xDvJAUVrkA694AxoTyMl+TSiY+SdNjdgNnU1Zh/bH3Kv5wFQfi6/H44e6Sl4epmfqkwk
 /XkdKvB3Ha17c2QEWLhNZFxnXh88lWfJP8wbymTOhMfQIksCC6/Qtz7F3H+Y2kXYr6DA
 cwfA==
X-Gm-Message-State: AOJu0YxcR/7KD7ePreXQ5lMMs3bHNwLwWMGeSzUACi79jIEwU/L5yO8O
 nqx/I3Lh9XF4d/xjCQbHoassWOSJ/gq+qvmokdMmBqqI/gPoiCfzIQrj46XlBsbtoc/qLXzg0Eh
 yEaTdtUHLy/k=
X-Gm-Gg: ASbGncuFStXFjI6f0pVLzVMIwSxv44OEo64T0DTVnLHVhCim74SrmXyWrVs/QXk2MSY
 PrHsJENFUgS+wAofqE0vAOIJvUENauGZbO6EAigRegh/JoSINEnOe50U//r97x5DIQdgvrr8SuZ
 cjG/1qNE/8Chi7KghgGuPWQUHkEhNqVjZSk44xY/Ik6fHogvgcDbYUlEwWykLFsvnEI/VqE/rc+
 DpO55pZl/RYeV762hFG0HkShmLMK9LZTPAts++DmxwP5Fbpz7XFGhWco4+izJbdsiG4Ulsm8iCD
 WGo1djzl4huDeo0PEerzF3oYfInsJneqIxX3gzuDBJlkYzQrINN7jSOQ5P5Bmd+LHkWODxlU8Kw
 xadtyhqI+SHcz9sMgDh3ivIu/VdGt/+dFiMc=
X-Google-Smtp-Source: AGHT+IHVa5hsnXplGxZLT4beHtC2ga+SKB/LL2k4LHs6m6oK298ygjLlyxOsKCON4gg+q+Pybbl6DA==
X-Received: by 2002:a05:6e02:491c:b0:42f:8fef:a610 with SMTP id
 e9e14a558f8ab-42f8fefa8bamr145660615ab.20.1760251475140; 
 Sat, 11 Oct 2025 23:44:35 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-42f90343080sm38109625ab.22.2025.10.11.23.44.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Oct 2025 23:44:33 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Peter Robinson <pbrobinson@gmail.com>,
 Simon Glass <sjg@chromium.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Maximilian Brune <maximilian.brune@9elements.com>,
 Moritz Fischer <moritzf@google.com>
Subject: [PATCH v5 4/4] boot: Move preparing bootdev into a function
Date: Sun, 12 Oct 2025 00:43:56 -0600
Message-ID: <20251012064412.2892979-5-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251012064412.2892979-1-sjg@chromium.org>
References: <20251012064412.2892979-1-sjg@chromium.org>
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

We will want to use this same logic in another place within iter_inc(),
so split it out into its own function.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v5:
- Rework commit message

 boot/bootflow.c | 40 +++++++++++++++++++++++++++++-----------
 1 file changed, 29 insertions(+), 11 deletions(-)

diff --git a/boot/bootflow.c b/boot/bootflow.c
index 13f086167ab..2588b0b6047 100644
--- a/boot/bootflow.c
+++ b/boot/bootflow.c
@@ -178,6 +178,32 @@ static void scan_next_in_uclass(struct udevice **devp)
 	*devp = dev;
 }
 
+/**
+ * prepare_bootdev() - Get ready to use a bootdev
+ *
+ * @iter: Bootflow iterator being used
+ * @dev: UCLASS_BOOTDEV device to use
+ * @method_flags: Method flag for the bootdev
+ * Return 0 if OK, -ve if the bootdev failed to probe
+ */
+static int prepare_bootdev(struct bootflow_iter *iter, struct udevice *dev,
+			   int method_flags)
+{
+	int ret;
+
+	/*
+	 * Probe the bootdev. This does not probe any attached block device,
+	 * since they are siblings
+	 */
+	ret = device_probe(dev);
+	log_debug("probe %s %d\n", dev->name, ret);
+	if (ret)
+		return log_msg_ret("probe", ret);
+	bootflow_iter_set_dev(iter, dev, method_flags);
+
+	return 0;
+}
+
 /**
  * iter_incr() - Move to the next item (method, part, bootdev)
  *
@@ -311,18 +337,10 @@ static int iter_incr(struct bootflow_iter *iter)
 		}
 		log_debug("ret=%d, dev=%p %s\n", ret, dev,
 			  dev ? dev->name : "none");
-		if (ret) {
+		if (ret)
 			bootflow_iter_set_dev(iter, NULL, 0);
-		} else {
-			/*
-			 * Probe the bootdev. This does not probe any attached
-			 * block device, since they are siblings
-			 */
-			ret = device_probe(dev);
-			log_debug("probe %s %d\n", dev->name, ret);
-			if (!log_msg_ret("probe", ret))
-				bootflow_iter_set_dev(iter, dev, method_flags);
-		}
+		else
+			ret = prepare_bootdev(iter, dev, method_flags);
 	}
 
 	/* if there are no more bootdevs, give up */
-- 
2.43.0

