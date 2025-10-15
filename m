Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F516CCD194
	for <u-boot@archiver.kernel.org>; Wed, 15 Oct 2025 15:46:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B890836C1;
	Wed, 15 Oct 2025 17:45:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gdHIRFgO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 03D2E800D7; Wed, 15 Oct 2025 17:45:24 +0200 (CEST)
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com
 [IPv6:2a00:1450:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB1BA836C1
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 17:45:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-57dfd0b6cd7so7563578e87.0
 for <u-boot@lists.denx.de>; Wed, 15 Oct 2025 08:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1760543118; x=1761147918; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2Z0BYrjAGHiAzrYqldXXm89MqA19kOWOQIt5zXdSvFY=;
 b=gdHIRFgOeloXBu5gWRdOzvMLPHrXSrek5e7+sChlsgD3ntj0k+WM7Bf+/6hSCEylFV
 /42cLNoiPBFdRsSvhGh21Wh/fzMXreM+STdtqqEasif4pW3Kp65TACScEGh98P28g4bn
 TdTiLBOouHzoHSFlrVwUgpmnNum4435U70KPQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760543119; x=1761147919;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2Z0BYrjAGHiAzrYqldXXm89MqA19kOWOQIt5zXdSvFY=;
 b=haHEfGIe3ZhDBo0ui7IVBA8Am2HGGUBgATG6VbtMyb75BBS74TyAWxNDISLrdwszqM
 CZgn8QbrH9imNcb+WguSdkhKBLKcTYbcNfzC0cgOdJNH+1OSnY58r8kfVPf0oAGmfOJz
 Wc8yvuDOXtdEIRJj/OdNCq/Fhl+M86vvwjrpi6z3jad0R3Q7xMY0p/lnklQYQm4ycMCC
 P+SfGUo+A9wZrXaOoOggzqXc2qx3+EWx1YH9E28pbPGo6jZxvbx4krmsMOFfabNzT5mk
 zV0sbsY9ztsn4DlnkiXi4GUC1BkPvpOJcwVGnV086brAxobTzmccG7i19wcpoVZRqyZe
 WBdQ==
X-Gm-Message-State: AOJu0YxQoNv5KDgwvIXJkTwBIRcVoBfL2utDe9jyhU0jtes5ownZYpvs
 zoddTyK374VPbsqocPWSAuiIW5ZEqF1aESe8U/Cb8ZQ/43ronuo1qwlyXVP4DtDLPof2dEPBmZC
 FhPTZjhc007M=
X-Gm-Gg: ASbGncsCqMkGz1Sizrpb56qFUpoxljnhs4Mt5XZqXbvRL+0KYh23HMnFAMPVORZZJe5
 JF6STTxn+gLmVCpgHBfXNlpVg88cjdBKN9b0Wwys6l6+IHA+TTcByDfjMZpujVCNq5c80jGDuA3
 h2FVdOLyCmLxGoCZ/rJChRROHWg4/mLy3opMKt5MT/oYZgYJHzVI5dnE8NQlOWWBQNw+v9x7Awy
 Ajmy85e6hrejQ2KZVHhw1Ygtevt1W7vgrCfgTiuyR6ITdyM5GuXGguqzS9x/5rwSS7lk2kHzYGy
 jYd6Zvdh9HdtxC0eLjPU/ol7jI04gz/l6yilGYYH0xh9zhsKUEsNCWJ20erxk7ZsryELYQTZMj7
 nAMo7tQuaf+ybytNGtJ8yY00dOjVVpThC76BIyQ==
X-Google-Smtp-Source: AGHT+IHfc7U3UzhnidYpXIuHr/6IINLa4dshDHRmwUZIHN4xKRiiPBXBjnI3QU/qLSQIWM82PYgvHw==
X-Received: by 2002:a05:6512:3f28:b0:581:f381:4ebe with SMTP id
 2adb3069b0e04-5906d88b1c8mr8293300e87.22.1760543118504; 
 Wed, 15 Oct 2025 08:45:18 -0700 (PDT)
Received: from chromium.org ([91.209.212.108])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-59088563cbesm6363777e87.64.2025.10.15.08.45.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Oct 2025 08:45:16 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Martin Schwan <m.schwan@phytec.de>,
 Martyn Welch <martyn.welch@collabora.com>,
 Maximilian Brune <maximilian.brune@9elements.com>,
 Moritz Fischer <moritzf@google.com>
Subject: [PATCH v4 10/11] boot: Run global bootmeths after all bootdevs are
 exhausted
Date: Wed, 15 Oct 2025 16:44:13 +0100
Message-ID: <20251015154423.908468-11-sjg@chromium.org>
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

When there are no more bootdevs we should still go through the global
bootmeths, since some may not have yet been used, if their priority has
not yet come up.

Add a final check for this at the end of the iterator.

Update the documentation to match the new behaviour of global bootmeths.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v3)

Changes in v3:
- Pull doc changes into this patch

Changes in v2:
- Add a bit more detail suggested by Heinrich

 boot/bootflow.c                  | 23 ++++++++++++++++++
 doc/develop/bootstd/overview.rst | 40 +++++++++++++++++++++++++++-----
 2 files changed, 57 insertions(+), 6 deletions(-)

diff --git a/boot/bootflow.c b/boot/bootflow.c
index 38b8af916b2..d8a4a81a838 100644
--- a/boot/bootflow.c
+++ b/boot/bootflow.c
@@ -354,6 +354,18 @@ static int iter_incr(struct bootflow_iter *iter)
 			return 0;
 		}
 
+		/* if this was the final global bootmeth check, we are done */
+		if (iter->cur_prio == BOOTDEVP_COUNT) {
+			log_debug("-> done global bootmeths\n");
+
+			/* print the same message as bootflow_iter_set_dev() */
+			if ((iter->flags & (BOOTFLOWIF_SHOW |
+					    BOOTFLOWIF_SINGLE_DEV)) ==
+					    BOOTFLOWIF_SHOW)
+				printf("No more bootdevs\n");
+			return BF_NO_MORE_DEVICES;
+		}
+
 		/*
 		 * Don't move to the next dev as we haven't tried this
 		 * one yet!
@@ -459,6 +471,17 @@ static int iter_incr(struct bootflow_iter *iter)
 			ret = prepare_bootdev(iter, dev, method_flags, true);
 	}
 
+	if (IS_ENABLED(CONFIG_BOOTMETH_GLOBAL) && ret) {
+		log_debug("no more bootdevs, trying global\n");
+
+		/* allow global bootmeths with any priority */
+		iter->cur_prio = BOOTDEVP_COUNT;
+		if (!next_glob_bootmeth(iter)) {
+			log_debug("-> next method '%s'\n", iter->method->name);
+			return 0;
+		}
+	}
+
 	/* if there are no more bootdevs, give up */
 	if (ret)
 		return log_msg_ret("incr", BF_NO_MORE_DEVICES);
diff --git a/doc/develop/bootstd/overview.rst b/doc/develop/bootstd/overview.rst
index 0a237359575..e36cde4d360 100644
--- a/doc/develop/bootstd/overview.rst
+++ b/doc/develop/bootstd/overview.rst
@@ -133,7 +133,8 @@ which scans for available bootflows, optionally listing each find it finds (-l)
 and trying to boot it (-b).
 
 When global bootmeths are available, these are typically checked before the
-above bootdev scanning.
+above bootdev scanning, but it is possible provide a priority to make them
+run later, by setting the glob_prio field in the driver's bind() method.
 
 
 Controlling ordering
@@ -612,9 +613,9 @@ simply copied into the iterator. Either way, the `method_order` array it set up,
 along with `num_methods`.
 
 Note that global bootmeths are always put at the end of the ordering. If any are
-present, `cur_method` is set to the first one, so that global bootmeths are done
-first. Once all have been used, these bootmeths are dropped from the iteration.
-When there are no global bootmeths, `cur_method` is set to 0.
+present, `cur_method` is set to the first one, so that global bootmeths are
+processed first, so long as their priority allows it. Bootstd keeps track of
+which global bootmeths have been used, to make sure they are only used once.
 
 At this point the iterator is ready to use, with the first bootmeth selected.
 Most of the other fields are 0. This means that the current partition
@@ -714,8 +715,35 @@ to the next partition, or bootdev, for example. The special values
 `BF_NO_MORE_PARTS` and `BF_NO_MORE_DEVICES` handle this. When `iter_incr` sees
 `BF_NO_MORE_PARTS` it knows that it should immediately move to the next bootdev.
 When it sees `BF_NO_MORE_DEVICES` it knows that there is nothing more it can do
-so it should immediately return. The caller of `iter_incr()` is responsible for
-updating the `err` field, based on the return value it sees.
+so it should immediately run any unused global bootmeths and then return. The
+caller of `iter_incr()` is responsible for updating the `err` field, based on
+the return value it sees.
+
+Global bootmeths can have a non-zero priority, which indicates where in the
+iteration sequence they should run. Each time a new bootdev is produced by a
+hunter, all of the global bootmeths are first checked to see if they should run
+before this new bootdev. For example, if the bootdev was produced by a hunter
+with priority BOOTDEVP_6_NET_BASE, then a quick check is made for global
+bootmeths with that priority or less. If there are any, they run before the new
+bootdev is processed.
+
+Assuming they are enabled and the iteration sequence runs right to the end, all
+global bootmeths will be used. This is handled by a special case at the end of
+iter_incr(), where it processes amy so-far-unused global bootmeths.
+
+It is important to note the special nature of global bootmeths, with respect to
+priority. If there are two normal bootmeths and a global one, the normal ones
+are run for each bootdev, but the global one is independent of bootdevs. The
+order might be:
+
+    bootdev priority 3: normal-1, normal-3
+    global-2, prio 4
+    bootdev priority 5: normal-1, normal-3
+
+Of course if a specific bootmeth ordering is provided, then this overrides the
+default ordering. Global bootmeths must be listed at the end, reflecting their
+hybrid nature (they are bootmeths but operate on the system as a whole, not on
+a particular bootdev).
 
 The above describes the iteration process at a high level. It is basically a
 very simple increment function with a checker called `bootflow_check()` that
-- 
2.43.0

