Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1E4ECCA470
	for <u-boot@archiver.kernel.org>; Wed,  1 Oct 2025 21:31:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98D1983631;
	Wed,  1 Oct 2025 23:29:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hbU6a8PV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 842C2836EE; Wed,  1 Oct 2025 23:29:55 +0200 (CEST)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4D1C683544
 for <u-boot@lists.denx.de>; Wed,  1 Oct 2025 23:29:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-938c85ccabcso14203039f.0
 for <u-boot@lists.denx.de>; Wed, 01 Oct 2025 14:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1759354191; x=1759958991; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jf1geVvaRg2m7Ij0jAODT9roUTnQyxUTNa/vce68iBA=;
 b=hbU6a8PVYC6FDS+1fi7buxTIkVuaRY5i7NuqmpOxXmiTjF1Tl0qSSFf7MJiwCBxXW5
 Z7yMo7pLaxPHT2N07hrKYKrBLG5Vx9NYBfEBFiE3ai+5IYN/Wicsa7BW1AdxN2ZCTlY4
 mB6niTjVHs6oVG9NC0SETaHi3ZRWhiaqJMGQg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759354191; x=1759958991;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Jf1geVvaRg2m7Ij0jAODT9roUTnQyxUTNa/vce68iBA=;
 b=tEYt/YxEHYep36ad+p/T5EOunYulDgLtU+QVS8B5SN6fyh0WyYW78Pqg+e3JXxiQu/
 Ic99njK+RcWN7sHqiDB+2m1xCOTPv592JWaLO3l1FkdwnwgvT70gfgID5lC035QT8joL
 m3Ydk9Zmpsoub/RSToCSOmEQ8Dl0rpJgOcFJu5Daq6FyApiCLIkJI3ZTZVlkBWOTPNQS
 isqjhluR8qN78Um1Pm6O+QqaEU8Ng05OMlwW0i6LzAr1EXB80mAhFd245xST9lUJuUI3
 7iM5ZTPRTCN7ZqJ9tnaYkFWsjDyOrLDTQirJ9j/yx2D+wtlqS1ikFixkub9Pf34huRLq
 sc8A==
X-Gm-Message-State: AOJu0YxeCzoCmNyEPFKGAwSgIwoBkobwl55PEVYEZHhgYFbURWT6QtVx
 frvnLwARMfp3w/MJrUmNExBEyH0IQm5oMP/546S+SN2b3w+fHu0R9UVQl9LxW9hlGonCjuwxmPb
 jdp66fHig
X-Gm-Gg: ASbGncuU2KkPr1FW4UPY/poOsou639w5TBQY0gQ1tDf1ir0qR72ypxs6Ep056rfUA+J
 zpGiiVQvnnNruDIjzd6gB/vYozOJD+Staak8luC9qnu4xbTMeOTXbXxp5JkMJspOcC1Pwdc3eKi
 jLpL6v7tCfJPyjk2HBvcLmo8enFJKDrazncAQzKjnTruGb1dpAqeT0+Q93siNEitZjQ7TNtokOo
 0+gaHe3PNErF/Y6CphMJONng3m+STdGLVEb24YlRFgSoFa05UTKRUszOTzR+8B043X+j4zVVqgX
 /crv7h3GKjr0D6XkibHylFSfWP7v79yJrbPsDHYKpgmYDgWr45XQk+rcUi/MnZayhmsNE8zvuKy
 0rncrTsdeYVg/jHwZsbWxnqTLoe8RF8NXZgUCW0Vo
X-Google-Smtp-Source: AGHT+IExrbagNtIgWErAH7oF9PF5OPYqGyufRWtOhFo7S8yReyAPtp/U/4q0+R2UeFvLDtu2JcMW3g==
X-Received: by 2002:a05:6e02:19ce:b0:42d:89c3:df7f with SMTP id
 e9e14a558f8ab-42d8b1c90c9mr14825235ab.7.1759354191395; 
 Wed, 01 Oct 2025 14:29:51 -0700 (PDT)
Received: from chromium.org ([73.34.74.121]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-57b5ec09429sm202844173.55.2025.10.01.14.29.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Oct 2025 14:29:50 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 11/17] boot: Support rescanning the global bootmeths
Date: Wed,  1 Oct 2025 15:26:36 -0600
Message-ID: <20251001212649.3263574-12-sjg@chromium.org>
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

Add the logic to scan through the global bootmeths for every new
bootdev, in preparation for allowing global bootmeths to select where in
the hunter ordering they go.

Use a new bootmeth_glob_allowed() function to check if a bootmeth is
allowed, ensuring that each can run at most once.

For now this has no actual effect, since the global bootmeths are
unconditionally processed at the start, with iter->methods_done being
updated to include all of them. Therefore when scanning again, no
unprocessed global bootmeths will be found.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/bootflow.c    | 90 ++++++++++++++++++++++++++++++++++++++++++++--
 include/bootflow.h |  5 +++
 2 files changed, 93 insertions(+), 2 deletions(-)

diff --git a/boot/bootflow.c b/boot/bootflow.c
index 4218b53d19f..711b971c419 100644
--- a/boot/bootflow.c
+++ b/boot/bootflow.c
@@ -245,19 +245,81 @@ static void scan_next_in_uclass(struct udevice **devp)
 	*devp = dev;
 }
 
+/**
+ * bootmeth_glob_allowed() - Check if a global bootmeth is usable at this point
+ *
+ * @iter: Bootflow iterator being used
+ * Return: true if the global bootmeth has not already been used
+ */
+static bool bootmeth_glob_allowed(struct bootflow_iter *iter, int meth_seq)
+{
+	struct udevice *meth = iter->method_order[meth_seq];
+	bool done = iter->methods_done & BIT(meth_seq);
+
+	log_debug("considering glob '%s': done %d\n", meth->name, done);
+
+	/* if this one has already been used, try the next */
+	if (done)
+		return false;
+
+	return true;
+}
+
+/**
+ * next_glob_bootmeth() - Find the next global bootmeth to use
+ *
+ * Scans the global bootmeths to find the first unused one whose priority has
+ * been reached. If found, iter->cur_method and iter->method are set up and
+ * doing_global is set to true
+ *
+ * @iter: Bootflow iterator being used
+ * Return 0 if found, -ENOENT if no more global bootmeths are available
+ */
+static int next_glob_bootmeth(struct bootflow_iter *iter)
+{
+	log_debug("rescan global bootmeths have_global %d\n",
+		  iter->have_global);
+	if (IS_ENABLED(CONFIG_BOOTMETH_GLOBAL) && iter->have_global) {
+		int i;
+
+		/* rescan the global bootmeths */
+		log_debug("first_glob_method %d num_methods %d methods_done %x\n",
+			  iter->first_glob_method, iter->num_methods,
+			  iter->methods_done);
+		for (i = iter->first_glob_method; i < iter->num_methods; i++) {
+			if (bootmeth_glob_allowed(iter, i)) {
+				iter->cur_method = i;
+				iter->method = iter->method_order[i];
+				iter->doing_global = true;
+				iter->dev = NULL;
+				return 0;
+			}
+		}
+	}
+
+	return -ENOENT;
+}
+
 /**
  * prepare_bootdev() - Get ready to use a bootdev
  *
  * @iter: Bootflow iterator being used
  * @dev: UCLASS_BOOTDEV device to use
  * @method_flags: Method flag for the bootdev
+ * @check_global: true to check global bootmeths before processing @dev
  * Return 0 if OK, -ve if the bootdev failed to probe
  */
 static int prepare_bootdev(struct bootflow_iter *iter, struct udevice *dev,
-			   int method_flags)
+			   int method_flags, bool check_global)
 {
 	int ret;
 
+	if (check_global && !next_glob_bootmeth(iter)) {
+		iter->pending_bootdev = dev;
+		iter->pending_method_flags = method_flags;
+		return 0;
+	}
+
 	/*
 	 * Probe the bootdev. This does not probe any attached block device,
 	 * since they are siblings
@@ -308,6 +370,30 @@ static int iter_incr(struct bootflow_iter *iter)
 		iter->num_methods = iter->first_glob_method;
 		iter->doing_global = false;
 
+		/*
+		 * we've come to the end, so see if we should use a pending
+		 * bootdev from when we decided to rescan the global bootmeths
+		 */
+		if (iter->pending_bootdev) {
+			int meth_flags = iter->pending_method_flags;
+
+			dev = iter->pending_bootdev;
+			iter->pending_bootdev = NULL;
+			iter->pending_method_flags = 0;
+
+			ret = prepare_bootdev(iter, dev, meth_flags, false);
+			if (ret)
+				return log_msg_ret("ipb", ret);
+
+			iter->cur_method = 0;
+			iter->method = iter->method_order[iter->cur_method];
+
+			log_debug("-> using pending bootdev '%s' method '%s'\n",
+				  dev->name, iter->method->name);
+
+			return 0;
+		}
+
 		/*
 		 * Don't move to the next dev as we haven't tried this
 		 * one yet!
@@ -416,7 +502,7 @@ static int iter_incr(struct bootflow_iter *iter)
 		if (ret)
 			bootflow_iter_set_dev(iter, NULL, 0);
 		else
-			ret = prepare_bootdev(iter, dev, method_flags);
+			ret = prepare_bootdev(iter, dev, method_flags, true);
 	}
 
 	/* if there are no more bootdevs, give up */
diff --git a/include/bootflow.h b/include/bootflow.h
index 6437a6ef5e4..ec19f8dc436 100644
--- a/include/bootflow.h
+++ b/include/bootflow.h
@@ -267,6 +267,9 @@ enum {
  * (enum bootflow_meth_flags_t)
  * @methods_done: indicates which methods have been processed, one bit for
  * each method in @method_order[]
+ * @pending_bootdev: if non-NULL, bootdev which will be used when the global
+ * bootmeths are done
+ * @pending_method_flags: method flags which will be used with @pending_bootdev
  */
 struct bootflow_iter {
 	int flags;
@@ -290,6 +293,8 @@ struct bootflow_iter {
 	bool doing_global;
 	int method_flags;
 	uint methods_done;
+	struct udevice *pending_bootdev;
+	int pending_method_flags;
 };
 
 /**
-- 
2.43.0

