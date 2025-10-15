Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47B0BCCD185
	for <u-boot@archiver.kernel.org>; Wed, 15 Oct 2025 15:45:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1E95E8362A;
	Wed, 15 Oct 2025 17:45:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PuFMVvTU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C6DC683677; Wed, 15 Oct 2025 17:45:06 +0200 (CEST)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB1F6800D7
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 17:45:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-5818de29d15so8389697e87.2
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 08:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1760543103; x=1761147903; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FGs61Y8r7U5JGj63bug5+4cqQKVxAKGgPwdKECMFfIY=;
 b=PuFMVvTUQGsL//80fSFi9UTZStKmvOJkuLWJPMJ7T8b8mxh07ENf0f3v3h63sz0/x4
 6oOFtPao+6y6XRVvVGDqkTWwQ/TJx+WMyRUjl6VNQeQXrJUH2dbQFMi9tjuntOmemXNb
 7aBc3t5wBDxwHijRzJ3v0e0M8A4Fv0w3ehgr8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760543103; x=1761147903;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FGs61Y8r7U5JGj63bug5+4cqQKVxAKGgPwdKECMFfIY=;
 b=rw1SgAPZjgrvIwQrNynVrEvhQrzyuCBycqlU6xgibgiCSWKchM++8xLG2XfCYqf3te
 7tWk0kWXIZt22S31XyeBZNV/sksPafJ38smqua2YT7oHFF7WuUtyHFMl902H0QIY/xwh
 Ikf16suNjeK26+y9tq8tes5GSg6HZYtCtbZmPdr8kg93Lx8IqijSGA83VSzqQWKTfKRv
 PS+yvQM4F8w6wiVTFB/ZBYMz/kbRdx2H11ieB1VSSwP3AwdmxVY6KBynMrkABwZi6iSR
 YgiX4PvORVtNsKee53LTfcwPcKX6cEHnhrRGKQ0z4IMu6vS7X6/snOC3SDPT0mkTLex0
 zzxw==
X-Gm-Message-State: AOJu0Yzapoibq3kUkoPxbXiCdlIHqEQ9Roz4FXbBnrpAPdzP3tJ3pP1G
 wAPkgI3v9Bntj+QH8MRAU15VwN9nXVuSQdgBk8LEchY4Rt5f6UdW9hhuNFsa2sfr5kKUBFYoNzl
 9Xgg8qrrPoXQ=
X-Gm-Gg: ASbGncvFXfR4TlSkdkrgo6FmnQ4NkGfbmGLYPpNOZcP5BOBv6U/uw6FIa0JEyUccFET
 BZ4yZpHGEyLiZ8KcckSxBtl0/cKCvro1e51isuU2As0y+An+xfjiLFrKRRAQKnq+ELrTUqXcout
 2O8m1l0Fdl5eSFdd3ySMfuSPB6+ijV2MaipZhSGR1K6DTrTC6MLE3751NNlWoNDkYHPe/vJoUgG
 cUhaQ2kIThyGAB5DUWJsjQjMFnN/GnYshxJVbdlj9ZQ982+p3xHLA5ky0iEFVAwgz4QPqBax8JZ
 v0nSupECbcqsPJs8DehyTh+CC50lDOa6RH2HnhJQ7dfVEqXYnKRdZbT1JBjvf1Zj7aomYd7KRlC
 +5SDi5ykAOK9MFMoKjmgsC0CQPnEucHKT4MNbJuSxUTHg59Df
X-Google-Smtp-Source: AGHT+IFy7HqiOEFfQ3D9S0H1e6I2yAikIrWrBRpi9U62uIhpp7QiCr+thzYo8AxZlP7PYHUBRt2/Aw==
X-Received: by 2002:a05:6512:33c8:b0:579:6de0:983b with SMTP id
 2adb3069b0e04-5906dc2a41dmr10300612e87.17.1760543102665; 
 Wed, 15 Oct 2025 08:45:02 -0700 (PDT)
Received: from chromium.org ([91.209.212.108])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-59088563cbesm6363777e87.64.2025.10.15.08.44.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Oct 2025 08:45:01 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Maximilian Brune <maximilian.brune@9elements.com>,
 Moritz Fischer <moritzf@google.com>,
 Sam Protsenko <semen.protsenko@linaro.org>
Subject: [PATCH v4 06/11] boot: Support rescanning the global bootmeths
Date: Wed, 15 Oct 2025 16:44:09 +0100
Message-ID: <20251015154423.908468-7-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251015154423.908468-1-sjg@chromium.org>
References: <20251015154423.908468-1-sjg@chromium.org>
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
index 2e4d1a345cd..73deba24d30 100644
--- a/boot/bootflow.c
+++ b/boot/bootflow.c
@@ -187,19 +187,81 @@ static void scan_next_in_uclass(struct udevice **devp)
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
@@ -245,6 +307,30 @@ static int iter_incr(struct bootflow_iter *iter)
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
@@ -347,7 +433,7 @@ static int iter_incr(struct bootflow_iter *iter)
 		if (ret)
 			bootflow_iter_set_dev(iter, NULL, 0);
 		else
-			ret = prepare_bootdev(iter, dev, method_flags);
+			ret = prepare_bootdev(iter, dev, method_flags, true);
 	}
 
 	/* if there are no more bootdevs, give up */
diff --git a/include/bootflow.h b/include/bootflow.h
index 58a4ab9f811..059d38251b7 100644
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

